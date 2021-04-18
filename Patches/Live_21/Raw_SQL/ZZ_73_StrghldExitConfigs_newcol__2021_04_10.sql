USE [perpetuumsa]
GO

-------------------------------------------------
-- All stronghold exits now get a RiftConfig to set their destinations
-- new rift configs for all stronghold exits
-- update strongholdexits with new config ids
-- Date: 2021/04/10
-------------------------------------------------

PRINT N'ALTER [dbo].[strongholdexitconfig]';
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[perpetuumsa].[dbo].[strongholdexitconfig]')
	AND name = 'riftConfigId')
BEGIN
	PRINT N'ADDING COL riftConfigId';
	ALTER TABLE [perpetuumsa].[dbo].strongholdexitconfig ADD
		riftConfigId INT NULL;
END
GO


USE [perpetuumsa]
GO

DROP TABLE IF EXISTS #CONFIGS;
CREATE TABLE #CONFIGS(
	name VARCHAR(100),
	groupId INT,
	zoneId INT,
	x INT,
	y INT,
	w FLOAT
);
INSERT INTO #CONFIGS (name, groupId, zoneId, x, y, w) VALUES
('stronghold_default_exit', 1, 8, 970, 810, 1),
('stronghold_z71_exit', 2, 0, 1750, 850, 1),
('stronghold_z72_exit', 3, 8, 1970, 1830, 1),
('stronghold_z71_exit_boss', 4, 0, 1100, 865, 1),
('stronghold_z72_exit_boss', 5, 8, 971, 811, 1);

DROP TABLE IF EXISTS #EXITS;
CREATE TABLE #EXITS(
	zoneid INT,
	x INT,
	y INT,
	configName VARCHAR(100)
);
INSERT INTO #EXITS (zoneid, x, y, configName) VALUES
(71, 20, 175, 'stronghold_z71_exit'),
(71, 211, 119, 'stronghold_z71_exit_boss'),
(72, 219, 28, 'stronghold_z72_exit'),
(72, 89, 185, 'stronghold_z72_exit_boss');

DELETE FROM riftdestinations WHERE groupId IN (SELECT destinationGroupId from riftconfigs WHERE name IN (SELECT name FROM #CONFIGS));
DELETE FROM riftconfigs WHERE name IN (SELECT name FROM #CONFIGS);

PRINT N'INSERT INTO [dbo].[riftdestinations]';
INSERT INTO [dbo].[riftdestinations] (groupId, zoneId, x, y, weight)
	SELECT groupId, zoneId, x, y, w
	FROM #CONFIGS;

PRINT N'INSERT INTO [dbo].[riftconfigs]';
INSERT INTO [dbo].[riftconfigs] (name, destinationGroupId)
	SELECT name, groupId
	FROM #CONFIGS;


PRINT N'UPDATE strongholdexitconfig for boss entry riftconfigs';
PRINT N'Strongholds 16 and 70 all go to hershfield default exit destination';
UPDATE strongholdexitconfig SET
	riftConfigId = (SELECT TOP 1 id FROM [dbo].[riftconfigs] WHERE name='stronghold_default_exit')
WHERE zoneid=16 OR zoneid=70;


PRINT N'DELETE AND REINSERT FOR ZONES (71,72)';
DELETE FROM strongholdexitconfig WHERE zoneid IN (SELECT DISTINCT zoneid FROM #EXITS);
INSERT INTO strongholdexitconfig (zoneid, x, y, riftConfigId)
SELECT zoneid, x, y, (SELECT TOP 1 id FROM riftconfigs WHERE name=configName)
FROM #EXITS;


DROP TABLE IF EXISTS #CONFIGS;
DROP TABLE IF EXISTS #EXITS;
GO
