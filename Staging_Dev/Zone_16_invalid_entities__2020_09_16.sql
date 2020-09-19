USE [perpetuumsa]
GO

-----------------------------------------------
-- Some zone entities left over in Zone 16
-- throwing exceptions during server startup
--
-- Date: 2020/09/16
-----------------------------------------------

DELETE FROM zoneentities WHERE id IN (1528, 1529, 1539)