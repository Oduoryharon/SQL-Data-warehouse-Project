**Data Dictionary for Gold layer**
**Overview**
 The Gold layer is a business-level data representation, structured to support analytical and
 reporting use cases. It consists of dimensions, tables, and fact tables for  specific business metrics.

 ================================================================================================
**1.	Gold dim.customers**
**. purpose:** stores customer details enrichment with demographic and geographic data.
**.columns:**
 
|Column name    |Data_Type   |Description|
|---------------|------------|--------------------------------------------------------------------|
|customer_key   |INT         |Surrogate keys uniquely identifying each customer record in dimension table.|
|customer_id    |INT         |unique numerical identifier for each customer.|
|customer_number|NVARCHAR(50)|Alphanumeric customer representing the customer, used for tracking and referencing|
|first_name     |NVARCHAR(50)|The customer's first name as recorded in the system|
|last_name      |NVARCHAR(50)|The customer's last name or family name.|
|country        |NVARCHAR(50)|The country of residence of customer e.g Australia.|
|marital_status |NVARCHAR(50)|The marital status of customer e.g (single, married)|
|gender         |NVARCHAR(50)|The gender of the customer e.g (male, female).|
|birthdate      |DATE        |The date of birrth of customer formatted as YYYY-MM-DD e.g (1971-08-11)|
|create_date    |DATE        |The date and time when the customer record was created n the system|

=================================================================================================
**2. Gold.dim_products**
**.purpose:** It more information about products and their products.
**.columns**
|Column name         |Data_Type   |Description|
|--------------------|------------|--------------------------------------------------|
|product_key         |INT         |Surrogate key uniquely identifying each product record in product dimension table. |
|product_id          |INT         |A unique identifier assigned to product for internal tracking and referencing.|
|product_number        |NVARCHAR(50)|a stractured alphanumeric code representing product, used for categorization or inventory|
|product_name        |NVARCHAR(50)|Descriptive name for product,including key details such as color, type and size|
|category_id           |NVARCHAR(50)|a unique identifier for product category, linking to its high level classification|
|category            |NVARCHAR(50)|The broader classification of product(e.g bike components) to group related items|
|subcategory         |NVARCHAR(50)|a more detailed classificatio of product within category such pr |
|maintenance_required|NVARCHAR(50)|indicate whether product requires mainteace e.g 'yes' or 'no'|
|cost                |INT         |The cost or base price of the product,measured in monetary unit|
|product_line        |NVARCHAR(50)|The specific product lin or series to which product belongs(Roads, mountain)|
|start_date          |DATE        |The date when product became available for sale|

===================================================================================================

**3.Gold.fact_sales**
**purpose:** stores transactional sales data for analytical purposes.
**colums**

|Column name  |Data Type   |Description|
|-------------|------------|------------------------------------------------------------------|
|order_number |NVARCHAR(50)|a unique alphanumeric identifier for each sales orders e.g ('SOS4496')|
|product_key  |INT         |Surrogate key linking the order to the product dimension table|
|customer_key |INT         |surrogate key linking the order to the customer dimension table|
|order_date   |DATE        |The date when order was placed|
|shipping_date|DATE        |the date when order was shipped to customeers|
|due_date     |DATE        |The date when order payment was due |
|sales_amount |INT         |The total monetary value of the sales for the item, in the whole currency unit (e.g 25)|
|quantity     |INT         |The number of unis of the product ordered for the line item (e.g 1)|
|price        |INT         |The price per unit of the product for the line item, in the whole currency unit (e. 25)|



