-- Explore All Countries our customers come from

SELECT DISTINCT country FROM gold.dim_customer

-- Explore All Categories "The major Divisions"
SELECT DISTINCT category, subcategory, product_name FROM gold.dim_products
ORDER BY 1,2,3
