USE [Home_Arkan_DB]
GO

-- 1. CLEAN UP: Drop existing tables to start fresh
IF OBJECT_ID('Fact_Sales', 'U') IS NOT NULL DROP TABLE Fact_Sales;
IF OBJECT_ID('Dim_Product', 'U') IS NOT NULL DROP TABLE Dim_Product;
IF OBJECT_ID('Dim_Geography', 'U') IS NOT NULL DROP TABLE Dim_Geography;
IF OBJECT_ID('Dim_PaymentMethod', 'U') IS NOT NULL DROP TABLE Dim_PaymentMethod;
IF OBJECT_ID('Dim_Status', 'U') IS NOT NULL DROP TABLE Dim_Status;
IF OBJECT_ID('map_customer_unique', 'U') IS NOT NULL DROP TABLE map_customer_unique;
IF OBJECT_ID('map_seller', 'U') IS NOT NULL DROP TABLE map_seller;
IF OBJECT_ID('map_product', 'U') IS NOT NULL DROP TABLE map_product;
IF OBJECT_ID('map_order', 'U') IS NOT NULL DROP TABLE map_order;
GO

-- 2. CREATE MAPPING TABLES
SELECT 
    customer_unique_id AS Old_CustomerUnique_ID, 
    CAST(ROW_NUMBER() OVER (ORDER BY customer_unique_id) AS INT) AS CustomerUniqueKey
INTO map_customer_unique 
FROM (SELECT DISTINCT customer_unique_id FROM olist_customers WHERE customer_unique_id IS NOT NULL) t;

SELECT 
    seller_id AS Old_Seller_ID, 
    CAST(ROW_NUMBER() OVER (ORDER BY seller_id) AS INT) AS SellerKey
INTO map_seller 
FROM (SELECT DISTINCT seller_id FROM olist_sellers WHERE seller_id IS NOT NULL) t;

SELECT 
    product_id AS Old_Product_ID, 
    CAST(ROW_NUMBER() OVER (ORDER BY product_id) AS INT) AS ProductKey
INTO map_product 
FROM (SELECT DISTINCT product_id FROM olist_products WHERE product_id IS NOT NULL) t;

SELECT 
    order_id AS Old_Order_ID, 
    CAST(ROW_NUMBER() OVER (ORDER BY order_id) AS INT) AS OrderKey
INTO map_order 
FROM (SELECT DISTINCT order_id FROM olist_orders WHERE order_id IS NOT NULL) t;
GO

-- 3. BUILD DIMENSION TABLES

-- A. Dim_Geography
SELECT 
    CAST(ROW_NUMBER() OVER (ORDER BY gm.State_Code) AS INT) AS GeoKey,
    gm.Olist_Source_Mapping, 
    gm.State_Code AS Egypt_StateCode,
    gm.City_Name AS Egypt_CityName,
    gm.Region AS Egypt_Region,
    sf.Img AS Flag_Image_URL
INTO Dim_Geography
FROM geography_mapping gm
LEFT JOIN state_flags sf ON gm.State_Code = sf.State_Code
WHERE gm.State_Code IS NOT NULL;

ALTER TABLE Dim_Geography ALTER COLUMN GeoKey INT NOT NULL;
ALTER TABLE Dim_Geography ADD CONSTRAINT PK_Dim_Geography PRIMARY KEY (GeoKey);
GO

-- B. Dim_Product
SELECT 
    m.ProductKey, 
    COALESCE(NULLIF(pcm.product_category_name_english, ''), 'Others') AS CategoryName_English
INTO Dim_Product 
FROM olist_products p 
JOIN map_product m ON p.product_id = m.Old_Product_ID 
LEFT JOIN product_categories_mapping pcm ON p.product_category_name = pcm.product_category_name;

ALTER TABLE Dim_Product ALTER COLUMN ProductKey INT NOT NULL;
ALTER TABLE Dim_Product ADD CONSTRAINT PK_Dim_Product PRIMARY KEY (ProductKey);

-- C. Dim_PaymentMethod
WITH CleanPayments AS (
    SELECT order_id, 
        CASE WHEN payment_type IN ('boleto', 'not_defined') OR payment_type IS NULL OR payment_type = '' THEN 'cash' ELSE payment_type END AS CleanPaymentType
    FROM olist_order_payments
)
SELECT 
    CAST(ROW_NUMBER() OVER (ORDER BY CleanPaymentType) AS INT) AS PaymentMethodKey, 
    CleanPaymentType AS PaymentMethodName
INTO Dim_PaymentMethod 
FROM (SELECT DISTINCT CleanPaymentType FROM CleanPayments) t;

ALTER TABLE Dim_PaymentMethod ALTER COLUMN PaymentMethodKey INT NOT NULL;
ALTER TABLE Dim_PaymentMethod ADD CONSTRAINT PK_Dim_PaymentMethod PRIMARY KEY (PaymentMethodKey);

-- D. Dim_Status
SELECT 
    CAST(ROW_NUMBER() OVER (ORDER BY order_status) AS INT) AS StatusKey, 
    order_status AS StatusName
INTO Dim_Status 
FROM (SELECT DISTINCT order_status FROM olist_orders WHERE order_status IS NOT NULL) t;

ALTER TABLE Dim_Status ALTER COLUMN StatusKey INT NOT NULL;
ALTER TABLE Dim_Status ADD CONSTRAINT PK_Dim_Status PRIMARY KEY (StatusKey);
GO

-- 4. BUILD THE MASTER FACT TABLE (Fact_Sales)
WITH RankedPayments AS (
    SELECT order_id, 
        CASE WHEN payment_type IN ('boleto', 'not_defined') OR payment_type IS NULL OR payment_type = '' THEN 'cash' ELSE payment_type END AS CleanPaymentType, 
        ROW_NUMBER() OVER(PARTITION BY order_id ORDER BY payment_value DESC) as rn
    FROM olist_order_payments
),
OrderReviews AS (
    SELECT order_id, AVG(CAST(review_score AS FLOAT)) AS AvgReviewScore
    FROM olist_order_reviews GROUP BY order_id
)
SELECT 
    mo.OrderKey, mp.ProductKey, dst.StatusKey, dpm.PaymentMethodKey,
    cg.GeoKey AS CustomerGeoKey, sg.GeoKey AS SellerGeoKey,
    mcu.CustomerUniqueKey, ms.SellerKey,          
    TRY_CAST(o.order_purchase_timestamp AS DATETIME) AS PurchaseDate,
    TRY_CAST(o.order_approved_at AS DATETIME) AS ApprovedDate,
    TRY_CAST(o.order_delivered_carrier_date AS DATETIME) AS DeliveredCarrierDate,
    TRY_CAST(o.order_delivered_customer_date AS DATETIME) AS DeliveredCustomerDate,
    TRY_CAST(o.order_estimated_delivery_date AS DATETIME) AS EstimatedDeliveryDate,
    TRY_CAST(oi.shipping_limit_date AS DATETIME) AS ShippingLimitDate,
    oi.price AS Price, oi.freight_value AS FreightValue,
    rv.AvgReviewScore AS ReviewScore
INTO Fact_Sales
FROM olist_order_items oi
JOIN map_order mo ON oi.order_id = mo.Old_Order_ID
JOIN map_product mp ON oi.product_id = mp.Old_Product_ID
JOIN olist_orders o ON oi.order_id = o.order_id
JOIN olist_customers c ON o.customer_id = c.customer_id
JOIN olist_sellers s ON oi.seller_id = s.seller_id
JOIN map_customer_unique mcu ON c.customer_unique_id = mcu.Old_CustomerUnique_ID
JOIN map_seller ms ON oi.seller_id = ms.Old_Seller_ID
LEFT JOIN Dim_Geography cg ON c.customer_state = cg.Olist_Source_Mapping
LEFT JOIN Dim_Geography sg ON s.seller_state = sg.Olist_Source_Mapping
LEFT JOIN Dim_Status dst ON o.order_status = dst.StatusName
LEFT JOIN RankedPayments rp ON o.order_id = rp.order_id AND rp.rn = 1
LEFT JOIN Dim_PaymentMethod dpm ON rp.CleanPaymentType = dpm.PaymentMethodName
LEFT JOIN OrderReviews rv ON o.order_id = rv.order_id;
GO

-- 5. FINAL STEP: Drop mapping column
ALTER TABLE Dim_Geography DROP COLUMN Olist_Source_Mapping;
GO