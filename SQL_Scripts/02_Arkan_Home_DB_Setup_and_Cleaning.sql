USE Home_Arkan_DB;
GO

UPDATE olist_products SET product_name_length = NULL WHERE product_name_length = '';
UPDATE olist_products SET product_description_length = NULL WHERE product_description_length = '';
UPDATE olist_products SET product_photos_qty = NULL WHERE product_photos_qty = '';
UPDATE olist_products SET product_weight_g = NULL WHERE product_weight_g = '';
UPDATE olist_products SET product_length_cm = NULL WHERE product_length_cm = '';
UPDATE olist_products SET product_height_cm = NULL WHERE product_height_cm = '';
UPDATE olist_products SET product_width_cm = NULL WHERE product_width_cm = '';
GO

ALTER TABLE olist_products ALTER COLUMN product_name_length INT;
ALTER TABLE olist_products ALTER COLUMN product_description_length INT;
ALTER TABLE olist_products ALTER COLUMN product_photos_qty INT;
ALTER TABLE olist_products ALTER COLUMN product_weight_g INT;
ALTER TABLE olist_products ALTER COLUMN product_length_cm INT;
ALTER TABLE olist_products ALTER COLUMN product_height_cm INT;
ALTER TABLE olist_products ALTER COLUMN product_width_cm INT;
GO

SELECT 'Olist Orders' AS Table_Name, COUNT(*) AS Row_Count FROM olist_orders
UNION ALL
SELECT 'Olist Items', COUNT(*) FROM olist_order_items
UNION ALL
SELECT 'Olist Customers', COUNT(*) FROM olist_customers
UNION ALL
SELECT 'Olist Sellers', COUNT(*) FROM olist_sellers
UNION ALL
SELECT 'Olist Products', COUNT(*) FROM olist_products
UNION ALL
SELECT 'Olist Payments', COUNT(*) FROM olist_order_payments
UNION ALL
SELECT 'Olist Reviews', COUNT(*) FROM olist_order_reviews
UNION ALL
SELECT 'Geography Mapping', COUNT(*) FROM geography_mapping
UNION ALL
SELECT 'Product Categories', COUNT(*) FROM product_categories_mapping;
GO