1. gold.dim_customer
   * Purpose: Store customer details enriched with demographics and geographic data.
   * Columns:
    | Column Name | Data Type | Description |
    | ----------- | --------- | ----------- |
    | customer_key | INT | Surrogate key iniqualy identifying each customer record in the dimention table. |
| customer_id | INT | Unique numerical identifier assigned to each customer. |
| customer_number| NVARCHAR(50) | Alphanumeric identifier representing the customer, used for tracking and references. |
| first_name |  NVARCHAR(50) | The customer's first name, as recorded in the system. |
| last_name | NVARCHAR(50) | The customer's last name or family name. |
| country | NVARCHAR(50) | The country of residence for the customer (e.g., 'Australia'). |
| marital_status | NVARCHAR(50) | The marital status of the customer (e.g., Married', 'Single'). |
| gender | NVARCHAR(50) | The gender of the customer (e.g., 'Male', 'Female', 'n/a'). |
| birthdate | DATE | The date of birth of the customer, formatted as YYYY-MM-DD (e.g., 1971-10-06). |
| create_date | DATE | The date and time when the customer record was created in the system. |
