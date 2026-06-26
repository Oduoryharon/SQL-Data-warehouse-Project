/*
======================================================
Stores Procedure: Load Bronze layer (Source -> Bronze)
======================================================
Script Purpose: 
	This stored procedure stores the data into 'bronze' Schema from external CSV files.
	It perfom the following action:
		-Truncate the bronze tabes before loading the data.
		-Use the BULK INSERT command to load data fro csv file into bronze tables.

Paramaters:
	None,
	This stored procedures does not accept any paramaters or return values

	Usage example
	EXEC bronze.load_bronze

*/




CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @starttime DATETIME, @endtime DATETIME;
	BEGIN TRY
		PRINT'============================='
		PRINT'Loading Data in bronze layer'
		PRINT'============================='

		PRINT'--------------------'
		PRINT'Loading CRM Tables'
		PRINT'--------------------'
		SET @starttime = GETDATE();
		SET @starttime = GETDATE();
		PRINT'-----------------------------------------'
		PRINT'>>Truncating Table: bronze.crm_cust_info '
		PRINT'-----------------------------------------'
		TRUNCATE TABLE bronze.crm_cust_info

		PRINT'-------------------------------------------'
		PRINT'Inserting Data Into: bronze.crm_cust_info '
		PRINT'-------------------------------------------'

		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\wande\Documents\sql-crush\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK

		)

		SET @endtime = GETDATE();
		PRINT'<< Load duration: ' + CAST(DATEDIFF(second, @starttime, @endtime) AS NVARCHAR) + ' Seconds'

		SELECT COUNT(*) FROM bronze.crm_cust_info

		SET @starttime = GETDATE()
		PRINT'-----------------------------------------'
		PRINT'>>Truncating Table: bronze.crm_prd_info '
		PRINT'-----------------------------------------'

		TRUNCATE TABLE bronze.crm_prd_info

		PRINT'-------------------------------------------'
		PRINT'Inserting Data Into: bronze.crm_prd_info '
		PRINT'-------------------------------------------'

		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\wande\Documents\sql-crush\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK

		)
		SET @endtime = GETDATE()
		PRINT'<< Load duratiin: '  + CAST(DATEDIFF(second, @starttime, @endtime) AS NVARCHAR) + ' Seconds'

		SELECT * FROM bronze.crm_prd_info

		SET @starttime = GETDATE()
		PRINT'---------------------------------------------'
		PRINT'>>Truncating Table: bronze.crm_sales_details '
		PRINT'---------------------------------------------'

		TRUNCATE TABLE bronze.crm_sales_details

		PRINT'----------------------------------------------'
		PRINT'Inserting Data Into: bronze.crm_sales_details '
		PRINT'----------------------------------------------'

		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\wande\Documents\sql-crush\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK

		)
		SET @endtime = GETDATE()
		PRINT'<< Load duration: ' + CAST(DATEDIFF(second, @starttime, @endtime) AS NVARCHAR) + ' Seconds'

		SELECT * FROM bronze.crm_sales_details

	
		PRINT'--------------------'
		PRINT'Loading ERP Tables'
		PRINT'--------------------'

		SET @starttime = GETDATE()
		PRINT'-----------------------------------------'
		PRINT'>>Truncating Table: bronze.erp_cust_az12 '
		PRINT'-----------------------------------------'

		TRUNCATE TABLE Bronze.erp_cust_az12

	
		PRINT'------------------------------------------'
		PRINT'Inserting Data Into: bronze.erp_cust_az12 '
		PRINT'------------------------------------------'

		BULK INSERT Bronze.erp_cust_az12
		FROM 'C:\Users\wande\Documents\sql-crush\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK

		);

		SET @endtime = GETDATE()
		PRINT'<< Load duration: ' + CAST(DATEDIFF(second, @starttime, @endtime) AS NVARCHAR) + ' Seconds'


		SET @starttime = GETDATE()
		PRINT'----------------------------------------'
		PRINT'>>Truncating Table: bronze.erp_loc_a101 '
		PRINT'----------------------------------------'

		TRUNCATE TABLE bronze.erp_loc_a101

		PRINT'-----------------------------------------'
		PRINT'Inserting Data Into: bronze.erp_loc_a101 '
		PRINT'-----------------------------------------'

		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\wande\Documents\sql-crush\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK

		)
		SET @endtime = GETDATE()
		PRINT'<< Load duration: ' + CAST(DATEDIFF(second, @starttime, @endtime) AS NVARCHAR) + ' Seconds'


		SELECT * FROM bronze.erp_loc_a101


		SET @starttime = GETDATE()
		PRINT'----------------------------------------'
		PRINT'>>Truncating Table: bronze.erp_loc_a101 '
		PRINT'----------------------------------------'

		TRUNCATE TABLE Bronze.erp_px_cat_g1v2

		PRINT'----------------------------------------------'
		PRINT'Inserting Data Into: bronze.erp_px_cat_g1v2 '
		PRINT'----------------------------------------------'

		BULK INSERT Bronze.erp_px_cat_g1v2
		FROM 'C:\Users\wande\Documents\sql-crush\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK

		)
		SET @endtime = GETDATE()
		PRINT'<< Load duration: ' + CAST(DATEDIFF(second, @starttime, @endtime) AS NVARCHAR) + ' Seconds'
		SET @endtime = GETDATE()
		PRINT'<< Total Load time : ' + CAST(DATEDIFF(second, @starttime, @endtime) AS NVARCHAR) + ' Seconds'

		SELECT * FROM bronze.erp_px_cat_g1v2
	END TRY
	BEGIN CATCH
		PRINT'========================================='
		PRINT'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT'Error Message' + ERROR_MESSAGE();
		PRINT'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT'Error Message' + CAST(ERROR_STATE() AS NVARCHAR)
		PRINT'========================================='
	END CATCH
END
