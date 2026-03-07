USE Home_Arkan_DB;
GO

-- 1. Orders
CREATE TABLE olist_orders (
    order_id VARCHAR(50),
    customer_id VARCHAR(50),
    order_status VARCHAR(50),
    order_purchase_timestamp VARCHAR(50),
    order_approved_at VARCHAR(50),
    order_delivered_carrier_date VARCHAR(50),
    order_delivered_customer_date VARCHAR(50),
    order_estimated_delivery_date VARCHAR(50)
);

-- 2. Items
CREATE TABLE olist_order_items (
    order_id VARCHAR(50),
    order_item_id INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date VARCHAR(50),
    price DECIMAL(10, 2),
    freight_value DECIMAL(10, 2)
);

-- 3. Payments
CREATE TABLE olist_order_payments (
    order_id VARCHAR(50),
    payment_sequential INT,
    payment_type VARCHAR(50),
    payment_installments INT,
    payment_value DECIMAL(10, 2)
);

-- 4. Reviews
CREATE TABLE olist_order_reviews (
    review_id VARCHAR(50),
    order_id VARCHAR(50),
    review_score INT,
    review_comment_title NVARCHAR(MAX),  
    review_comment_message NVARCHAR(MAX), 
    review_creation_date VARCHAR(50),
    review_answer_timestamp VARCHAR(50)
);

-- 5. Products
CREATE TABLE olist_products (
    product_id VARCHAR(50),
    product_category_name NVARCHAR(100),
    product_name_length NVARCHAR(100),
    product_description_length NVARCHAR(100),
    product_photos_qty NVARCHAR(100),
    product_weight_g NVARCHAR(100),
    product_length_cm NVARCHAR(100),
    product_height_cm NVARCHAR(100),
    product_width_cm NVARCHAR(100)
);

-- 6. Customers
CREATE TABLE olist_customers (
    customer_id VARCHAR(50),
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix VARCHAR(20),
    customer_city NVARCHAR(100),
    customer_state VARCHAR(10)
);

-- 7. Sellers
CREATE TABLE olist_sellers (
    seller_id VARCHAR(50),
    seller_zip_code_prefix VARCHAR(20),
    seller_city NVARCHAR(100),
    seller_state VARCHAR(10)
);

-- 8. Geography Mapping
CREATE TABLE geography_mapping (
    Olist_Source_Mapping VARCHAR(50),
    State_Code VARCHAR(50),
    City_Name NVARCHAR(100),
    Region NVARCHAR(100),
);

-- 9. Product Categories Mapping
CREATE TABLE product_categories_mapping (
    product_category_name NVARCHAR(100),
    product_category_name_english NVARCHAR(100)
);
GO