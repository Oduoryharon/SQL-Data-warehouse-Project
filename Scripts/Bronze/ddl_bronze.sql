/*
=================================
DDL Script: Create Bronze Tables
=================================
Script Purpose: 
	This script creates table in the 'bronze' schema, dropping the existing tables if they already exixsts
	Run this script to redidfine DDL Stracture of bronze table

*/


	IF OBJECT_ID ('bronze.crm_cust_info', 'U') IS NOT NULL
		DROP TABLE bronze.crm_cust_info;
	CREATE TABLE bronze.crm_cust_info(
		cst_id INT,
		cst_key NVARCHAR(50),
		cst_firstname NVARCHAR(50),
		cst_lastname NVARCHAR(50),
		cst_marital_status NVARCHAR(50),
		cst_gndr NVARCHAR(50),
		cst_create_date DATE
	);

	IF OBJECT_ID ('bronze.crm_prd_info', 'U') IS NOT NULL
		DROP TABLE bronze.crm_prd_info;

	CREATE TABLE bronze.crm_prd_info (
		prd_id INT,
		prd_key NVARCHAR(50),
		prd_nm NVARCHAR(50),
		prd_cost INT,
		prd_line NVARCHAR(20),
		prd_start_dt DATETIME,
		prd_end_dt DATETIME
	);
	IF OBJECT_ID ('bronze.crm_sales_details', 'U') IS NOT NULL
		DROP TABLE bronze.crm_sales_details;
	CREATE TABLE bronze.crm_sales_details (
		sls_ord_num NVARCHAR(50),
		sls_prd_key NVARCHAR(50),
		sls_cust_id INT,
		sls_order_dt INT,
		sls_ship_dt INT,
		sls_due_dt INT,
		sls_sales INT,
		sls_quantity INT,
		sls_price INT

	);

	ALTER TABLE bronze.erp_cust_az12 
	ALTER COLUMN gen VARCHAR(50);



	IF OBJECT_ID ('erp_loc_a101', 'U') IS NOT NULL
		DROP TABLE erp_loc_101;
	CREATE TABLE erp_loc_a101 (
		cid NVARCHAR(50),
		cntry NVARCHAR(50)
	);

	IF OBJECT_ID ('erp_px_cat_g1v1', 'U') IS NOT NULL
		DROP TABLE erp_px_cat_g1v1;
	CREATE TABLE erp_px_cat_g1v2 (
		id NVARCHAR(50),
		cat NVARCHAR(50),
		subcat NVARCHAR(50),
		maintenance NVARCHAR(50)
	)

	EXEC sp_rename 'dbo.erp_cust_az12', 'bronze.erp_cust_az12'

	-- Miving this tables to another schema
	ALTER SCHEMA Bronze TRANSFER dbo.erp_loc_a101;
	ALTER SCHEMA Bronze TRANSFER dbo.erp_cust_az12;
	ALTER SCHEMA Bronze TRANSFER dbo.erp_px_cat_g1v2
