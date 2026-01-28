-- Explore All object in the Database
SELECT * FROM INFORMATION_SCHEMA.Tables



-- Explore All columns in the Database
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customer'