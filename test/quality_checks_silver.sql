/*
==============================================================================
Quality Checks
==============================================================================
Script Purpose:
    This script performs various quality checks for data consistency accuracy,
    and standardization across the 'silver' schemas. It includes checks for:
    - Null or duplicate primary keys.
    - Unwanted spaces in string field.
    - Data Standardization and consistency.
    - Invalid data ranges and orders.
    - Data consistency between related fields.

Usage Notes:
    - Run these checks after data loading Silver Layer.
    - Investigate and resolve any discrepancies found during the checks.
==============================================================================
*/

-- ====================================================================
-- Checking 'silver.crm_cust_info'
-- ====================================================================
-- Checks for NULLS or Duplicates in Primary key
-- Expectation: No Results
SELECT
  cst_id,
  COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- Check for Unwated Spaces
-- Expectations: No Results
SELECT 
    cst_key
FROM silver.crm_cust_info
WHERE cst_key != TRIM(cst_key);

-- Data Standardized & Consistensy
SELECT DISTINCT
    cst_marital_status
FROM silver.crm_cust_info;

-- ========================================================
-- Cheching 'silver.crm_prd_info'
-- ========================================================
-- Check for NULLS or Duplicates in Primary Key
-- Expectations: No Result

SELECT 
    prd_id,
    COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- Check for Unwanted Spaces
-- Expectations: No Result
SELECT 
    prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);

-- Check for NULLS or Negative Values in Cost
-- Expectations: No Result
SELECT 
    prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

-- Data Standardized & Consistency
SELECT 
    prd_line
FROM silver.crm_prd_info;

-- Check for Invalid Date Orders (Start Date > End Date)
-- Expectation: No Results
SELECT 
    *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt;

-- ===========================================
-- Checking '' silver.crm_sales_details
-- ===========================================
-- Check for Invalid Dates
-- Expectations: No Invalid Dates
SELECT 
    NULLIF(sls_due_dt, 0) AS sls_due_dt
FROM bronze.crm_sales_datails
WHERE sls_due_dt <= 0 
    OR LEN(sls_due_dt)
    OR sls_due_dt > 20500101
    OR sls_due_dt < 19000101;

-- Check for Invalid Date Order (Order Date > Shipping/Due Dates)
-- Expectations: No Results
SELECT
    * 
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt
   OR sls_order_dt > sls_due_dt;

-- Check Data Consistency: Sales = Quantity * price
-- Expectations : No Results
SELECT DISTINCT
    sls_sales,















