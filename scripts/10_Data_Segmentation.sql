-- Group the data based on a specific range.
-- Helps understand the correlation between measures.

/*Segemnt products into cost tanges and
count how many products fall into each segment*/
WITH product_segments AS (
SELECT
product_key,
product_name,
cost,
CASE WHEN cost < 100 THEN 'Below 100'
	 WHEN cost BETWEEN 100 and 500 THEN '100-500'
	 WHEN cost BETWEEN 500 and 1000 THEN '500-1000'
	 ELSE 'Above 1000'
END cost_range
FROM gold.dim_products
)
SELECT 
cost_range,
COUNT(product_key) AS total_products
FROM product_segments
GROUP BY cost_range

ORDER BY total_products DESC
