-- Aggregate the date progressively over time
-- Helps to understand whether our business is growing or declining

-- Calculate the total sales per month
-- and the funning total of sales over time
SELECT 
order_date,
total_sales,
SUM(total_sales) OVER ( ORDER BY order_date) AS running_total_sales,
AVG(avg_price) OVER (ORDER BY order_date) as moving_average_price
FROM
(
SELECT
DATETRUNC(year, order_date) AS order_date,
SUM(sales_amount) as total_sales,
AVG(price) AS avg_price
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(year, order_date)
--ORDER BY DATETRUNC(month, order_date)
) t