/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/


---create a stored procedure---
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		
		SET @batch_start_time = GETDATE();
		PRINT '========================================================';
		PRINT 'loading bronze layer';
		PRINT '========================================================';




	--- Bulk loading the tables ---
		PRINT '-------------------- ------------------------------------';
		PRINT 'loading crm tables';
		PRINT '--------------------------------------------------------';

		SET @start_time = GETDATE();
	---Loading customer info
		PRINT '>>> Truncating table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;


		PRINT '>>> Inserting data into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\Karthik\OneDrive\Desktop\Data warehouse\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>>>-----------------';



		--- loading the product info
		SET @start_time = GETDATE();
		PRINT '>>> Truncating table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>>> Inserting data into: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\Karthik\OneDrive\Desktop\Data warehouse\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>>>-----------------';


		SET @start_time = GETDATE();
		--- loading the sales details from crm
		PRINT '>>> Truncating table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '>>> Inserting data into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\Karthik\OneDrive\Desktop\Data warehouse\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>>>-----------------';


		PRINT '--------------------------------------------------------';
		PRINT 'loading erp tables'
		PRINT '--------------------------------------------------------';


		SET @start_time = GETDATE();
		--- loading the customer details from erp
		PRINT '>>> Truncating table: bronze.erp_cust_details';
		TRUNCATE TABLE bronze.erp_cust_details;

		PRINT '>>> Inserting data into: bronze.erp_cust_details'
		BULK INSERT bronze.erp_cust_details
		FROM 'C:\Users\Karthik\OneDrive\Desktop\Data warehouse\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>>>-----------------';


		SET @start_time = GETDATE();
		--- loading the location details from erp
		PRINT '>>> Truncating table: bronze.erp_loc_details';
		TRUNCATE TABLE bronze.erp_loc_details;

		PRINT '>>> Inserting data into: bronze.erp_loc_details';
		BULK INSERT bronze.erp_loc_details
		FROM 'C:\Users\Karthik\OneDrive\Desktop\Data warehouse\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>>>-----------------'



		SET @start_time = GETDATE();
		--- loading the personal categories from erp
		PRINT '>>> Truncating table: bronze.erp_per_cat';
		TRUNCATE TABLE bronze.erp_per_cat

		PRINT '>>> Inserting data into: bronze.erp_per_cat';
		BULK INSERT bronze.erp_per_cat
		FROM 'C:\Users\Karthik\OneDrive\Desktop\Data warehouse\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_ERP\PX_CAT_G1V2.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>>>-----------------';

		SET @batch_end_time = GETDATE();
		PRINT '==========================================================';
		PRINT 'Loading bronze layer is completed';
		PRINT '==========================================================';
		PRINT 'Total bronze layer loading duration:' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + 'seconds';
		PRINT '>>>----------------'

	END TRY
	BEGIN CATCH
		PRINT '===================================================';
		PRINT 'ERROR OCCURED DURING LOADING THE BRONZE LAYER';
		PRINT 'ErroR message' + ERROR_MESSAGE();
		PRINT 'Error message' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error message' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '===================================================';
	END CATCH


END


