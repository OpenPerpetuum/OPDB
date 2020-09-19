USE [perpetuumsa]
GO

-----------------------------------------------
-- Some zone entities left over in Zone 16
-- throwing exceptions during server startup
--
-- Date: 2020/09/16
-----------------------------------------------

DELETE FROM zoneentities WHERE id = 1528 and x = 1024.5 and y = 1024.5 and z = 439
DELETE FROM zoneentities WHERE id = 1529 and x = 1024.5 and y = 1032.5 and z = 439
DELETE FROM zoneentities WHERE id = 1539 and x = 1113.5 and y = 1049.5 and z = 420