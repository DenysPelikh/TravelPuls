
USE master
GO

IF db_id('Travel_master') IS NOT NULL
BEGIN
	PRINT N'Travel_master dropping'; 
	DROP DATABASE Travel_master  
END
GO

CREATE DATABASE Travel_master;
GO

PRINT N'Travel_master was created successfully';
GO

EXECUTE sp_helpdb Travel_master
GO

USE Travel_master
GO
