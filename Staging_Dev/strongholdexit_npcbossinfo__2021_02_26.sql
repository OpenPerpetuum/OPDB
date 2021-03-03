USE [perpetuumsa]
GO

------------------------------------------------
-- Zone 71-72 Stronghold Exit anom configs
--
-- Date: 2/26/2021
------------------------------------------------
PRINT N'CONFIGURE STRONGHOND ZONE 71, 72 ENTRANCE AND EXITS';

PRINT N'EXIT TEMP TABLE';
DROP TABLE IF EXISTS #EXITS;
CREATE TABLE #EXITS(
	zoneid INT,
	x INT,
	y INT
);
INSERT INTO #EXITS (zoneid, x, y) VALUES
(71, 211, 119),
(72, 89, 185);

PRINT N'DELETE AND REINSERT FOR ZONES (71,72)';
DELETE FROM strongholdexitconfig WHERE zoneid IN (SELECT DISTINCT zoneid FROM #EXITS);
INSERT INTO strongholdexitconfig (zoneid, x, y)
SELECT zoneid, x, y FROM #EXITS;

DROP TABLE IF EXISTS #EXITS;
GO
