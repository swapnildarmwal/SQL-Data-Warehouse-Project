/*
==========================================
Create Databse and Schemas
==========================================

Script Purpose;
      This script create a new database name 'Data Warhouse' after checking if it already exists.
      If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas
      within the database: 'Bronze','Silver', and 'Gold'


Warning;
      Running this script will drop the entire 'Datawarehouse' database if it exists.
      All data in the database will be permanently deleted. Proceed with caution
      and ensure you have proper backups before running this script.
*/

use master;
go


--Drop and Recreate the 'datawarehouse' database

If Exists (Select 1 from sys.database where name = 'Datawarehouse')
Begin
	alter database datawarehouse set single_user with rollback immediate;
	Drop database Datawarehouse;
End;
go

--Create the 'Datawarehouse' database

create database DataWarehouse;
go

use DataWarehouse;
go


--Creating Schema

create schema Bronze;
go

create schema Silver;
go

create schema Gold;
go




