Data Dictionary for Gold layer
Overview
The Gold layer is a business-level data representation, structured to support analytical and
reporting use cases. It consists of dimensions, tables, and fact tables for  specific business metrics.
1.	Gold dim.customers
. purpose: stores customer details enrichment with demographic and geographic data.
.columns:
 
Column name |	Data_Type	Description
-----------------------------------------------------------------------------------------------------------------
Customer_key |	INT	Surrogate keys uniquely identifying each customer record in the dimension table.
Customer_id	  INT	Unique numerical identifier assigned to each customer.
Customer_number	NVARCHAR(50)	Alphanumeric customer representing the customer, used for tracking and referencing
first_name	NVARCHAR(50)	The customer's first name as recorded in the system.
Last_name	NVARCHAR(50)	The customer's last name or family name.
country	NVARCHAR(50)	The country of residence of customer e.g Australia.
Marital_status	NVARCHAR(50)	The marital status of the customer(e.g single, married) .
gender	NVARCHAR(50)	The gender of the customer e.g (male, female).
birthdate	DATE	The date of birth of customer formatted as YYYY-MM-DD e.g(1971-10-11).
Create_date	DATE	The date and time when the customer record was created and in the system.

