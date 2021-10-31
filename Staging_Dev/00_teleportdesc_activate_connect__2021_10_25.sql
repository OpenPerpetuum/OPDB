USE [perpetuumsa]
GO

-------------------------------
-- ACTIVATE THE TELEPORTS
-- DATE MODIFIED: 2021/10/25
-------------------------------

DROP TABLE IF EXISTS #DISABLED_CONNECTIONS;
CREATE TABLE #DISABLED_CONNECTIONS(
	sourceColName VARCHAR(100),
	targetColName VARCHAR(100)
);
INSERT INTO #DISABLED_CONNECTIONS (sourceColName, targetColName) VALUES
('teleport_column_tmpvp_4','tpc_z100'),
('tpc_z100','teleport_column_tmpvp_4'),
('teleport_column_initia_sw','tpc_z101'),
('tpc_z101','teleport_column_initia_sw'),
('teleport_column_asipvp_5','tpc_z102'),
('tpc_z102','teleport_column_asipvp_5'),
('teleport_column_asi2_vougar','tpc_z103'),
('tpc_z103','teleport_column_asi2_vougar'),
('teleport_column_icspvp_2','tpc_z104'),
('tpc_z104','teleport_column_icspvp_2'),
('teleport_column_ics2_vsehovski','tpc_z105'),
('tpc_z105','teleport_column_ics2_vsehovski');


UPDATE teleportdescriptions SET
	active=1
WHERE sourcecolumn IN (SELECT eid FROM zoneentities WHERE ename IN (SELECT sourceColName FROM #DISABLED_CONNECTIONS)) 
AND targetcolumn IN (SELECT eid FROM zoneentities WHERE ename IN (SELECT targetColName FROM #DISABLED_CONNECTIONS));


DROP TABLE IF EXISTS #DISABLED_CONNECTIONS;
PRINT N'TELEPORT NETWORK ACTIVATED';
GO