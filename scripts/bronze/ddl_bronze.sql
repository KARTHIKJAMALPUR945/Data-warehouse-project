/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/

--- Creating a table
USE DataWarehouse

--- Creating table for cusomer info
IF OBJECT_ID ('bronze.crm_cust_info', 'U') IS NOT NULL
	DROP TABLE bronze.crm_cust_info;
CREATE TABLE bronze.crm_cust_info(

	cst_ID INT,
	cst_key NVARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_lastname NVARCHAR(50),
	cst_marital_status NVARCHAR(50),
	cst_gndr NVARCHAR(10),
	cst_create_date DATE 
);


--- Creating table for prd info from CRM
IF OBJECT_ID ('bronze.crm_prd_info', 'U') IS NOT NULL
	DROP TABLE bronze.crm_prd_info;
CREATE TABLE bronze.crm_prd_info(

prd_id INT,
prd_key NVARCHAR(50),
prd_nm NVARCHAR(50),
prd_cost INT,
prd_line NVARCHAR(50),
prd_start_dt DATETIME,
prd_end_dt DATETIME

);


--- Creating table for sales details from CRM
IF OBJECT_ID ('crm_sales_details', 'U') IS NOT NULL
	DROP TABLE bronze.crm_sales_details;
CREATE TABLE bronze.crm_sales_details(

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

--- Creating table for customer details from erp
IF OBJECT_ID ('bronze.erp_cust_details', 'U') IS NOT NULL
	DROP TABLE bronze.erp_cust_details;
CREATE TABLE bronze.erp_cust_details(

CID NVARCHAR(50),
BDATE DATE,
GEN NVARCHAR(50)

);


---creating table for location details from erp
IF OBJECT_ID ('bronze.erp_loc_details', 'U') IS NOT NULL
	DROP TABLE bronze.erp_loc_details;
CREATE TABLE bronze.erp_loc_details(

CID	NVARCHAR(50),
CNTRY NVARCHAR(50)

);

--- Creating table for personal categories from erp
IF OBJECT_ID ('bronze.erp_per_cat', 'U') IS NOT NULL
	DROP TABLE bronze.erp_per_cat;
CREATE TABLE bronze.erp_per_cat(

ID NVARCHAR(50),
CAT NVARCHAR(50),
SUBCAT NVARCHAR(50),
MAINTENANCE NVARCHAR(50)

);
