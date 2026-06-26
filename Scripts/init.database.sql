/*

=============================
Create DataBase and Schemas
=============================
SCRIPT PURPOSE:
	This scripts create a new database called 'DataWarehouse' after checking if it already 
	exixsts. If the database exixsts, it's dropped and recreated. Additionally the scripts
	setups three schemas within the database 'Bronze', 'silver', and 'Gold'.

WARNING!!:
	Running this script will drop the entire 'Datawarehouse' after checking if t already
	exists. All data in the database will be permanently deleted. Proceed with caution
	and ensure you have prpr backups before running this script


*/


CREATE DATABASE DataWarehouse

-- Drop and Recreate the 'DataWarehouse' Database
IF  EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END;

-- Create Schema bronze
CREATE SCHEMA Bronze
GO

-- Create Schema Silver
CREATE SCHEMA Silver
GO

-- Create Schema Gold
CREATE SCHEMA Gold
GO
