USE [perpetuumsa]
GO

-----------------------------------------------
-- Some zone entities left over in Zone 16
-- throwing exceptions during server startup
--
-- Date: 2020/09/16
-----------------------------------------------

DELETE FROM zoneentities WHERE eid IN (1328, 1329, 1339)