/*
==================================================================================
Product Report
==================================================================================
Purpose: 
	- This report consolidates key customer metrics and behaviors

Highlights:
	1. Gathers essential fields and such names, ages, category, subcategory, and cost.
	2. Segemnts products by revenue to indetify High-Performers, Mid-Range, or Low-Performers.
	3. Aggregates customer-leverl metrics:
		- total orders
		- total sales
		- total quantity pruchased
		- total customers (unique)
		- lifespan (in months)
	4. Calculates valuable KPIs:
		- recency (months since last order)
		- average order revenue (AOR)
		- average monthly spend
==================================================================================
*/
CREATE VIEW gold.report_products AS
WITH base_query AS (
/*------------------------------------------------------------------------------
1) Base Query: Retrives core columns from fact_sales and dim_products
------------------------------------------------------------------------------*/
SELECT 
	f.order_number,
	f.order_date,
	f.customer_key,
	f.sales_amount,
	f.quantity,
	p.product_key,
	p.product_name,
	p.category,
	p.subcategory,
	p.cost

FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
	ON f.product_key = p.product_key
WHERE order_date IS NOT NULL -- only cosider valid sales dates
), 

product_aggregation AS (
/*------------------------------------------------------------------------------
2) Customer Aggregation: Summarizes key metrics at the customer level
------------------------------------------------------------------------------*/
SELECT 
	product_key, 
	product_name,
	category,
	subcategory,
	cost,
	DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan,
	MAX(order_date) AS last_sale_date,
	COUNT(DISTINCT order_number) AS total_orders,
	COUNT(DISTINCT customer_key) AS total_customers,
	SUM(sales_amount) as total_sales,
	SUM(quantity) AS total_quantity,
	ROUND(AVG(CAST(sales_amount AS FLOAT) / NULLIF(quantity, 0)),1) AS avg_selling_price
FROM base_query
GROUP BY 
	product_key,
	product_name,
	category,
	subcategory,
	cost
)

/*------------------------------------------------------------------------------
3) Final QUery: Combines all product results onto one output.
------------------------------------------------------------------------------*/
SELECT 
	product_key,
	product_name,
	category,
	subcategory,
	cost,
	last_sale_date,
	DATEDIFF(MONTH, last_sale_date, GETDATE()) AS recency_in_months,
	CASE
		WHEN total_sales > 50000 THEN 'High -Performer'
		WHEN total_sales >= 10000 THEN 'Mid-Range'
		ELSE 'Low-Performer'
	END AS product_segments,
	lifespan,
	total_orders,
	total_sales,
	total_quantity,
	total_customers,
	avg_selling_price,
	-- Average order revenue (ADR)
	CASE 
		WHEN total_orders = 0 THEN 0
		ELSE total_sales / total_orders
	END AS avg_order_revenue,

	-- Average Monthly Revenue
	CASE 
		WHEN lifespan = 0 THEN total_sales
		ELSE total_sales / lifespan
	END AS avg_monthly_revenue

FROM product_aggregation

--SELECT *
--FROM gold.report_products
