USE [perpetuumsa]
GO

--------------------------------
--Increase spawn maximum for all relic-enabled zones
--Date: 2019/10/02
--------------------------------


UPDATE [reliczoneconfig] SET
maxspawn=9
WHERE zoneid in (0,3,4,5,8,9,10,11);

GO