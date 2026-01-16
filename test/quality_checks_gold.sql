
/*
=================================================================================
Quanlity Checks
=================================================================================
Script Purpose:
  This script performs quality checks to validate the intergrity, consistency,
  and accuracy of the Gold Layer. These checks ensure:
  - Uniqueness of surrogate keys in dimension tables.
  - Referential intergrity between fact and dimension tables.
  - Validation of relationship in the data model for analytical purpose.

Usage Notes:
  - Run these checks after data loading Silver Layer.
  - Investigate and resolve any discrepancies found suring the checks.
=================================================================================
*/

-- =================================================
-- Cheking 'gold.dim_customers'
-- =================================================
-- Check for Uniqueness of Customer Key in gold.dim_customers
-- Expectations: No Results
SELECT 
  customer_key,
  COUNT(*) AS duplicates_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

-- =================================================
-- Checking 'gold.product_key'
-- =================================================
-- check for uniqueness of Product Key in gold.dim_products
-- Expectations: No Results
SELECT 
  product_key,
  COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;

-- =================================================
-- Checking 'gold.fact_sales'
-- =================================================
-- check the data model connectivity between fact and dimension 
SELECT 
  *
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers
ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
WHERE p.product_key IS NULL 
OR c.customer_key IS NULL
