/*
========================================================================
stored procedure: Load Bronze layer (Source -> Bronze)
========================================================================
Script Purpose:
      This stored Procedure loads data into the 'bronze schema' from external CSV files.
      It performs the following actions:
      - Truncates teh bronze tables before loading data.
      - Uses the 'BULK INSERT' command to load data from CSV files to Bronze tables.

Parameters:
    None.
    This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===========================================================================
*/

create or alter procedure bronze.load_bronze as 
begin
	declare @start_time Datetime, @end_time datetime , @start datetime , @end datetime
	set @start = Getdate(); 

	begin try
		Print '================================';
		Print 'Loading the Bronze Layer';
		Print '================================';

		print '---------------------------------';
		Print 'Loading CRM Table';
		Print '---------------------------------';


		set @start_time = getdate();
		Print'>>Truncateing table:bronze.crm_cust_info';
		truncate table bronze.crm_cust_info;

		print '>> Inserting Data into: bronze.crm_cust_info';
		bulk insert bronze.crm_cust_info 
		from 'C:\Users\user\OneDrive\Desktop\SQL\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print ' >> Load Duration ' + cast(datediff(second , @start_time, @end_time) as nvarchar) + ' Seconds';
		print ' >>-------------------------------------';


		set @start_time = getdate() ;
		Print'>>Truncateing table:bronze.crm_prd_info';
		truncate table bronze.crm_prd_info;

		print '>> Inserting Data into: bronze.crm_prd_info';
		bulk insert bronze.crm_prd_info
		from 'C:\Users\user\OneDrive\Desktop\SQL\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate()
		print ' >> Load Duration ' + cast(datediff(second , @start_time, @end_time) as nvarchar) + ' Seconds';
		print ' >>-------------------------------------'; 


		set @start_time = GETDATE()
		Print'>>Truncateing table:bronze.crm_sales_details';
		truncate table bronze.crm_sales_details;

		print '>> Inserting Data into: bronze.crm_sales_details';
		bulk insert bronze.crm_sales_details
		from 'C:\Users\user\OneDrive\Desktop\SQL\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		print ' >> Load Duration ' + cast(datediff(second , @start_time, @end_time) as nvarchar) + ' Seconds';
		print ' >>-------------------------------------'; 


		print '---------------------------------';
		Print 'Loading ERP Table';
		Print '---------------------------------';

		set @start_time = GETDATE()
		Print'>>Truncateing table:bronze.erp_cust_az12';
		truncate table bronze.erp_cust_az12;

		print '>> Inserting Data into: bronze.bronze.erp_cust_az12';
		bulk insert bronze.erp_cust_az12
		from 'C:\Users\user\OneDrive\Desktop\SQL\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = GETDATE()
		print ' >> Load Duration ' + cast(datediff(second , @start_time, @end_time) as nvarchar) + ' Seconds';
		print ' >>-------------------------------------'; 


		set @start_time = GETDATE()
		Print'>>Truncateing table:bronze.erp_loc_a101';
		truncate table bronze.erp_loc_a101;

		print '>> Inserting Data into: bronze.bronze.erp_loc_a101';
		bulk insert bronze.erp_loc_a101
		from 'C:\Users\user\OneDrive\Desktop\SQL\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = GETDATE()
		print ' >> Load Duration ' + cast(datediff(second , @start_time, @end_time) as nvarchar) + ' Seconds';
		print ' >>-------------------------------------'; 


		set @start_time = getdate()
		Print'>>Truncateing table:erp_px_cat_g1v2';
		truncate table bronze.erp_px_cat_g1v2;

		print '>> Inserting Data into: bronze.erp_px_cat_g1v2';
		bulk insert bronze.erp_px_cat_g1v2
		from 'C:\Users\user\OneDrive\Desktop\SQL\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = GETDATE()
		print ' >> Load Duration ' + cast(datediff(second , @start_time, @end_time) as nvarchar) + ' Seconds';
		print ' >>-------------------------------------'; 

	end try

	Begin catch 
		print '================================================';
		print 'ERROR OCCURRED DURING LOADING BRONZE LAYER';
		print 'Error Message' + error_message();
		print 'Error Number' +  cast(Error_number() as nvarchar);
		print 'Error State' +  cast(Error_state() as nvarchar);
		print '=================================================';

	end catch 
	set @end = getdate()

	Print '====================================================';
	print 'Load duration of Stored procedure ' + cast(datediff(second, @start, @end ) as nvarchar) + ' Seconds';
	print '====================================================';
end;
