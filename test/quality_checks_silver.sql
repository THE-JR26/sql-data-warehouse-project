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
