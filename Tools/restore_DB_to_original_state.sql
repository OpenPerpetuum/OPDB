USE [master]
GO


ALTER DATABASE perpetuumsa
SET SINGLE_USER WITH
ROLLBACK IMMEDIATE

RESTORE DATABASE perpetuumsa FROM DISK = 'C:\PerpetuumServer\data\database\perpetuumsa.bak' WITH 
MOVE 'perpetuumsa' TO 'C:\PerpetuumServer\data\database\psa.mdf',
MOVE 'perpetuumsa_log' TO 'C:\PerpetuumServer\data\database\psa_log.ldf', REPLACE

ALTER DATABASE perpetuumsa SET MULTI_USER
GO