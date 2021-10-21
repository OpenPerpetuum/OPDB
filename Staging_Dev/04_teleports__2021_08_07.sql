USE [perpetuumsa]
GO

-----------------------------------------------
-- Gamma teleport network holy f...
--
-- Date modified: 2021/10/17
-----------------------------------------------

PRINT N'BUILDING TELEPORT NETWORK';

DECLARE @eidStart AS BIGINT = 5600;

DROP TABLE IF EXISTS #TELEDEF_BYRACE;
CREATE TABLE #TELEDEF_BYRACE(
	def int,
	raceId int
);
INSERT INTO #TELEDEF_BYRACE (def, raceId) VALUES
(1394,1),
(1395,2),
(667,3);

DROP TABLE IF EXISTS #CONNECTIONS;
CREATE TABLE #CONNECTIONS(
	sourceColName VARCHAR(100),
	targetColName VARCHAR(100)
);
INSERT INTO #CONNECTIONS (sourceColName, targetColName) VALUES
('teleport_column_tmpvp_4','tpc_z100'),
('tpc_z100','teleport_column_tmpvp_4'),
('tpc_z100','tpc_z130_SW'),
('tpc_z100','tpc_z112_NE'),
('tpc_z100','tpc_z113_S'),

('teleport_column_initia_sw','tpc_z101'),
('tpc_z101','teleport_column_initia_sw'),
('tpc_z101','tpc_z113_N'),
('tpc_z101','tpc_z115_E'),

('teleport_column_asipvp_5','tpc_z102'),
('tpc_z102','teleport_column_asipvp_5'),
('tpc_z102','tpc_z120_SE'),
('tpc_z102','tpc_z115_W'),
('tpc_z102','tpc_z116_N'),

('teleport_column_asi2_vougar','tpc_z103'),
('tpc_z103','teleport_column_asi2_vougar'),
('tpc_z103','tpc_z116_S'),
('tpc_z103','tpc_z117_E'),
('tpc_z103','tpc_z109_N'),

('teleport_column_icspvp_2','tpc_z104'),
('tpc_z104','teleport_column_icspvp_2'),
('tpc_z104','tpc_z137_N'),
('tpc_z104','tpc_z109_S'),
('tpc_z104','tpc_z111_W'),

('teleport_column_ics2_vsehovski','tpc_z105'),
('tpc_z105','teleport_column_ics2_vsehovski'),
('tpc_z105','tpc_z132_SW'),
('tpc_z105','tpc_z112_SE'),
('tpc_z105','tpc_z111_E'),

('tpc_z110_W','tpc_z109_E'),
('tpc_z110_E','tpc_z111_N'),


('tpc_z119_S','tpc_z117_NW'),
('tpc_z119_N','tpc_z120_SW'),
('tpc_z131_NW','tpc_z130_SE'),
('tpc_z131_E','tpc_z132_NW'),

('tpc_z106_NE','tpc_z112_NW'),
('tpc_z106_SW','tpc_z107_E'),

('tpc_z107_E','tpc_z106_SW'),

('tpc_z107_W','tpc_z108_E'),

('tpc_z108_E','tpc_z107_W'),

('tpc_z108_SW','tpc_z116_E'),
('tpc_z109_N','tpc_z103'),
('tpc_z109_W','tpc_z139_N'),
('tpc_z109_S','tpc_z104'),
('tpc_z109_E','tpc_z110_W'),
('tpc_z111_N','tpc_z110_E'),
('tpc_z111_E','tpc_z105'),
('tpc_z111_S','tpc_z135_N'),
('tpc_z111_W','tpc_z104'),
('tpc_z112_NW','tpc_z106_NE'),
('tpc_z112_NE','tpc_z100'),
('tpc_z112_SE','tpc_z105'),



('tpc_z113_N','tpc_z101'),

('tpc_z113_S','tpc_z100'),
('tpc_z113_E','tpc_z127_SW'),

('tpc_z114_S','tpc_z113_W'),
('tpc_z114_N','tpc_z115_S'),

('tpc_z115_N','tpc_z123_SW'),

('tpc_z115_S','tpc_z114_N'),


('tpc_z116_S','tpc_z103'),
('tpc_z116_E','tpc_z108_SW'),
('tpc_z117_NW','tpc_z119_S'),
('tpc_z117_NE','tpc_z103'),

('tpc_z117_SW','tpc_z118_N'),
('tpc_z118_N','tpc_z117_SW'),

('tpc_z118_S','tpc_z140_W'),

('tpc_z120_NW','tpc_z121_SW'),

('tpc_z120_SE','tpc_z102'),
('tpc_z120_SW','tpc_z119_N'),

('tpc_z121_NE','tpc_z122_NW'),

('tpc_z121_SW','tpc_z120_NW'),
('tpc_z122_NW','tpc_z121_NE'),
('tpc_z122_SE','tpc_z123_NW'),

('tpc_z123_NW','tpc_z122_SE'),
('tpc_z123_NE','tpc_z124_W'),

('tpc_z123_SW','tpc_z115_N'),

('tpc_z124_E','tpc_z125_N'),

('tpc_z124_W','tpc_z123_NE'),
('tpc_z125_N','tpc_z124_E'),
('tpc_z125_E','tpc_z126_N'),

('tpc_z125_W','tpc_z101'),
('tpc_z126_N','tpc_z125_E'),

('tpc_z126_S','tpc_z127_NE'),

('tpc_z127_SW','tpc_z113_E'),
('tpc_z127_SE','tpc_z128_NW'),
('tpc_z127_NE','tpc_z126_S'),
('tpc_z128_NW','tpc_z127_SE'),
('tpc_z128_NE','tpc_z129_W'),

('tpc_z129_W','tpc_z128_NE'),
('tpc_z129_S','tpc_z130_NE'),

('tpc_z130_NE','tpc_z129_S'),
('tpc_z130_SE','tpc_z131_NW'),
('tpc_z130_SW','tpc_z100'),
('tpc_z132_NW','tpc_z131_E'),

('tpc_z132_SE','tpc_z133_NE'),
('tpc_z132_SW','tpc_z105'),

('tpc_z133_NE','tpc_z132_SE'),

('tpc_z133_SW','tpc_z134_E'),

('tpc_z134_W','tpc_z135_E'),

('tpc_z134_E','tpc_z133_SW'),
('tpc_z135_N','tpc_z111_S'),

('tpc_z135_S','tpc_z136_N'),
('tpc_z135_E','tpc_z134_W'),
('tpc_z136_N','tpc_z135_S'),
('tpc_z136_W','tpc_z137_E'),

('tpc_z137_N','tpc_z104'),
('tpc_z137_W','tpc_z138_E'),

('tpc_z137_E','tpc_z136_W'),
('tpc_z138_N','tpc_z139_S'),

('tpc_z138_E','tpc_z137_W'),
('tpc_z139_N','tpc_z109_W'),
('tpc_z139_W','tpc_z140_E'),
('tpc_z139_S','tpc_z138_N'),

('tpc_z140_W','tpc_z118_S'),

('tpc_z140_E','tpc_z139_W');



DROP TABLE IF EXISTS #RAWDATA;
CREATE TABLE #RAWDATA(
	zoneid int,
	raceid int,
	x int,
	y int,
	teleName VARCHAR(100)
);
INSERT INTO #RAWDATA (zoneid, raceid, x, y, teleName) VALUES
(100,1,139, 131,'tpc_z100'),
(101,1,90, 85,'tpc_z101'),
(102,3,73, 148,'tpc_z102'),
(103,3,92,121,'tpc_z103'),
(104,2,128, 81,'tpc_z104'),
(105,2,78, 127,'tpc_z105'),

(110,2,261, 1201,'tpc_z110_W'),
(110,2,1711, 1155,'tpc_z110_E'),
(114,1,1642, 1607,'tpc_z114_S'),
(114,1,463,507,'tpc_z114_N'),
(119,3,580, 1635,'tpc_z119_S'),
(119,3,1428, 481,'tpc_z119_N'),
(131,2,471,456,'tpc_z131_NW'),
(131,2,1779, 1162,'tpc_z131_E'),

(106,2,289, 468,'tpc_z106_NW'),
(106,2,1390, 1829,'tpc_z106_SE'),
(106,2,1695, 348,'tpc_z106_NE'),
(106,2,187, 1536,'tpc_z106_SW'),
(107,3,996,297,'tpc_z107_N'),
(107,3,1761, 1192,'tpc_z107_E'),
(107,3,1013, 1911,'tpc_z107_S'),
(107,3,288, 1190,'tpc_z107_W'),
(108,3,1015, 435,'tpc_z108_N'),
(108,3,1821, 856,'tpc_z108_E'),
(108,3,1764, 1740,'tpc_z108_SE'),
(108,3,603, 1694,'tpc_z108_SW'),
(109,3,975, 333,'tpc_z109_N'),
(109,3,255, 915,'tpc_z109_W'),
(109,3,1109, 1720,'tpc_z109_S'),
(109,3,1718, 801,'tpc_z109_E'),
(111,2,619, 313,'tpc_z111_N'),
(111,2,1878, 897,'tpc_z111_E'),
(111,2,1416, 1849,'tpc_z111_S'),
(111,2,289, 1316,'tpc_z111_W'),
(112,2,386, 235,'tpc_z112_NW'),
(112,2,1577, 199,'tpc_z112_NE'),
(112,2,1364, 1269,'tpc_z112_SE'),
(112,2,602, 1663,'tpc_z112_SW'),
(113,1,1068, 346,'tpc_z113_N'),
(113,1,342, 1482,'tpc_z113_W'),
(113,1,1416, 1802,'tpc_z113_S'),
(113,1,1729, 857,'tpc_z113_E'),
(115,1,929, 265,'tpc_z115_N'),
(115,1,324, 1315,'tpc_z115_W'),
(115,1,1759, 1755,'tpc_z115_S'),
(115,1,1699, 881,'tpc_z115_E'),
(116,3,975, 534,'tpc_z116_N'),
(116,3,156, 1189,'tpc_z116_W'),
(116,3,1405, 1874,'tpc_z116_S'),
(116,3,1897, 1044,'tpc_z116_E'),
(117,3,280, 247,'tpc_z117_NW'),
(117,3,1425, 389,'tpc_z117_NE'),
(117,3,1731, 1348,'tpc_z117_SE'),
(117,3,808, 1456,'tpc_z117_SW'),
(118,3,1245, 272,'tpc_z118_N'),
(118,3,1789, 769,'tpc_z118_E'),
(118,3,837, 1807,'tpc_z118_S'),
(118,3,302, 930,'tpc_z118_W'),
(120,3,460, 270,'tpc_z120_NW'),
(120,3,1531, 321,'tpc_z120_NE'),
(120,3,1547, 1408,'tpc_z120_SE'),
(120,3,254, 1387,'tpc_z120_SW'),
(121,1,428, 305,'tpc_z121_NW'),
(121,1,1624, 401,'tpc_z121_NE'),
(121,1,1566, 1679,'tpc_z121_SE'),
(121,1,436, 1739,'tpc_z121_SW'),
(122,1,369, 622,'tpc_z122_NW'),
(122,1,1648, 1673,'tpc_z122_SE'),
(122,1,1430, 486,'tpc_z122_NE'),
(122,1,535, 1739,'tpc_z122_SW'),
(123,1,265, 446,'tpc_z123_NW'),
(123,1,1570, 352,'tpc_z123_NE'),
(123,1,1431, 1559,'tpc_z123_SE'),
(123,1,381, 1806,'tpc_z123_SW'),
(124,1,829, 325,'tpc_z124_N'),
(124,1,1794, 900,'tpc_z124_E'),
(124,1,1363, 1722,'tpc_z124_S'),
(124,1,285, 1251,'tpc_z124_W'),
(125,1,756, 233,'tpc_z125_N'),
(125,1,1772, 888,'tpc_z125_E'),
(125,1,1151, 1667,'tpc_z125_S'),
(125,1,380, 1277,'tpc_z125_W'),
(126,1,880, 262,'tpc_z126_N'),
(126,1,1725, 884,'tpc_z126_E'),
(126,1,1226, 1583,'tpc_z126_S'),
(126,1,385, 1171,'tpc_z126_W'),
(127,1,916, 382,'tpc_z127_NW'),
(127,1,348, 1715,'tpc_z127_SW'),
(127,1,1542, 1478,'tpc_z127_SE'),
(127,1,1856, 584,'tpc_z127_NE'),
(128,2,375, 240,'tpc_z128_NW'),
(128,2,1837, 515,'tpc_z128_NE'),
(128,2,1669, 1410,'tpc_z128_SE'),
(128,2,359, 1518,'tpc_z128_SW'),
(129,2,1020, 233,'tpc_z129_N'),
(129,2,1727, 777,'tpc_z129_E'),
(129,2,234, 1271,'tpc_z129_W'),
(129,2,1508, 1737,'tpc_z129_S'),
(130,2,530, 387,'tpc_z130_NW'),
(130,2,1675, 372,'tpc_z130_NE'),
(130,2,1715, 1534,'tpc_z130_SE'),
(130,2,600, 1448,'tpc_z130_SW'),
(132,2,683, 245,'tpc_z132_NW'),
(132,2,1767, 148,'tpc_z132_NE'),
(132,2,1768, 1543,'tpc_z132_SE'),
(132,2,229, 1281,'tpc_z132_SW'),
(133,2,340, 546,'tpc_z133_NW'),
(133,2,1780, 856,'tpc_z133_NE'),
(133,2,1708, 1664,'tpc_z133_SE'),
(133,2,284, 1725,'tpc_z133_SW'),
(134,2,992, 199,'tpc_z134_N'),
(134,2,283, 978,'tpc_z134_W'),
(134,2,651, 1597,'tpc_z134_S'),
(134,2,1809, 835,'tpc_z134_E'),
(135,2,528, 416,'tpc_z135_N'),
(135,2,261, 1217,'tpc_z135_W'),
(135,2,1159, 1780,'tpc_z135_S'),
(135,2,1833, 1239,'tpc_z135_E'),
(136,2,866, 448,'tpc_z136_N'),
(136,2,333, 982,'tpc_z136_W'),
(136,2,942, 1635,'tpc_z136_S'),
(136,2,1770, 952,'tpc_z136_E'),
(137,3,984, 456,'tpc_z137_N'),
(137,3,187, 1057,'tpc_z137_W'),
(137,3,1126, 1770,'tpc_z137_S'),
(137,3,1609, 991,'tpc_z137_E'),
(138,3,1176, 309,'tpc_z138_N'),
(138,3,320, 1036,'tpc_z138_W'),
(138,3,652, 1745,'tpc_z138_S'),
(138,3,1604, 978,'tpc_z138_E'),
(139,3,855, 273,'tpc_z139_N'),
(139,3,336, 1231,'tpc_z139_W'),
(139,3,1168, 1720,'tpc_z139_S'),
(139,3,1863, 916,'tpc_z139_E'),
(140,3,411, 314,'tpc_z140_W'),
(140,3,1758, 438,'tpc_z140_N'),
(140,3,1484, 1371,'tpc_z140_E'),
(140,3,548, 1617,'tpc_z140_S');

DROP TABLE IF EXISTS #TELES;
CREATE TABLE #TELES(
	zoneid int,
	raceid int,
	x int,
	y int,
	eid bigint,
	def int,
	ename NVARCHAR(128),
	synckey varchar(50),
);
INSERT INTO #TELES (zoneid, raceid, x, y, eid, def, ename, synckey)
SELECT
	d.zoneid,
	d.raceid,
	d.x,
	d.y,
	@eidStart+ROW_NUMBER() OVER(order by d.zoneid),
	(SELECT TOP 1 r.def FROM #TELEDEF_BYRACE r WHERE r.raceid=d.raceid),
	d.teleName,
	d.teleName
FROM #RAWDATA d order by d.zoneid;


PRINT N'DELETE AND REINSERT teleportdescriptions,  entities, zoneentities';
--select * from entities where eid in (select eid from #TELES)
--select * from zoneentities where eid in (select eid from #TELES)
--SELECT * FROM teleportdescriptions WHERE sourcecolumn in (select eid from #TELES) OR targetcolumn in (select eid from #TELES);
DELETE FROM teleportdescriptions WHERE sourcecolumn in (select eid from #TELES) OR targetcolumn in (select eid from #TELES);
DELETE from entities where eid in (select eid from #TELES);
DELETE from zoneentities where eid in (select eid from #TELES);

PRINT N'INSERT entities';
INSERT INTO entities (eid, definition, owner, parent, health, ename, quantity, repackaged, dynprop)
SELECT eid, def, NULL, NULL, 100, ename, 1, 0, '#enabled=i1' FROM #TELES;

PRINT N'INSERT zoneentities';
INSERT INTO zoneentities (zoneID, eid, definition, owner, ename, x, y, z, orientation, enabled, note, runtime, synckey)
SELECT zoneid, eid, NULL, NULL, ename, x+0.5, y+0.5, 0, 0, 1, 'tpcol', 0, synckey FROM #TELES;


PRINT N'INSERT *EXISTING* TELEPORT ENTITIES INTO #TELES (AFTER DELETE/INSERT CALLS USING #TELES)';
INSERT INTO #TELES (zoneid, raceid, x, y, eid, def, ename, synckey)
SELECT zoneID, 
	(SELECT TOP 1 r.raceId FROM #TELEDEF_BYRACE r WHERE r.def=e.definition),
	z.x, z.y, z.eid, e.definition, z.ename, z.synckey
FROM zoneentities z 
INNER JOIN entities e ON e.ename=z.ename
WHERE z.ename in (SELECT distinct sourceColName FROM #CONNECTIONS) AND z.ename NOT IN (SELECT ename FROM #TELES);

PRINT N'INSERT teleportdescriptions';
PRINT N'CONNECTING A->B';
INSERT INTO teleportdescriptions
	(description, sourcecolumn, targetcolumn, sourcezone, sourcerange, targetzone, targetrange, usetimeout, listable, active, type, sourcecolumnname, targetcolumnname)
SELECT
	s.ename+'_to_'+t.ename,
	s.eid, t.eid, s.zoneid, 7, t.zoneid, 7, 0, 1, 1, 2, s.ename, t.ename 
FROM #CONNECTIONS c
INNER JOIN #TELES s on s.ename = c.sourceColName
INNER JOIN #TELES t on t.ename = c.targetColName;


PRINT N'Bidirectional misses: ';
SELECT
	s.ename+'_to_'+t.ename,
	s.eid, t.eid, s.zoneid, 7, t.zoneid, 7, 0, 1, 1, 2, s.ename, t.ename 
FROM #CONNECTIONS c
INNER JOIN #TELES s on s.ename = c.targetColName
INNER JOIN #TELES t on t.ename = c.sourceColName
WHERE s.ename+'_to_'+t.ename NOT IN (SELECT description from teleportdescriptions)
PRINT N'CONNECTING B->A if missing from config';
--Insert the other direction by joining the opposite names
INSERT INTO teleportdescriptions
	(description, sourcecolumn, targetcolumn, sourcezone, sourcerange, targetzone, targetrange, usetimeout, listable, active, type, sourcecolumnname, targetcolumnname)
SELECT
	s.ename+'_to_'+t.ename,
	s.eid, t.eid, s.zoneid, 7, t.zoneid, 7, 0, 1, 1, 2, s.ename, t.ename 
FROM #CONNECTIONS c
INNER JOIN #TELES s on s.ename = c.targetColName
INNER JOIN #TELES t on t.ename = c.sourceColName
WHERE s.ename+'_to_'+t.ename NOT IN (SELECT description from teleportdescriptions)


PRINT N'TELEPORT NETWORK BUILT';
GO

