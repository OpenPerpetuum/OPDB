USE [perpetuumsa]
GO

-----------------------------------------------
-- Gamma teleport network holy f...
--
-- Date modified: 2021/08/08
-----------------------------------------------

PRINT N'BUILDING TELEPORT NETWORK';

DECLARE @eidStart AS BIGINT = 5600;
DECLARE @prefix AS VARCHAR(32) = 'tpc_';

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
('teleport_column_tmpvp_7','z100'),
('z100','teleport_column_tmpvp_7'),
('z100','z130_SW'),
('z100','z112_NE'),
('z100','z113_S'),

('teleport_column_tm2_uiria_Z','z101'),
('z101','teleport_column_tm2_uiria_Z'),
('z101','z125_E'),
('z101','z113_N'),
('z101','z115_W'),

('teleport_column_asipvp_7','z102'),
('z102','teleport_column_asipvp_7'),
('z102','z120_SE'),
('z102','z115_E'),
('z102','z116_N'),

('tp_zone_4_11','z103'),
('z103','tp_zone_4_11'),
('z103','z116_S'),
('z103','z117_E'),
('z103','z109_N'),

('teleport_column_icspvp_1','z104'),
('z104','teleport_column_icspvp_1'),
('z104','z137_N'),
('z104','z109_S'),
('z104','z111_W'),

('teleport_column_ics2_vsehovski_Z','z105'),
('z105','teleport_column_ics2_vsehovski_Z'),
('z105','z132_SW'),
('z105','z112_SE'),
('z105','z111_E'),

('z110_W','z109_E'),
('z110_E','z111_N'),
('z114_S','z115_S'),
('z114_N','z113_W'),
('z119_S','z117_NW'),
('z119_N','z120_SW'),
('z131_NW','z130_SE'),
('z131_E','z132_NW'),

('z106_NE','z112_NW'),
('z106_SW','z107_E'),

('z107_E','z106_SW'),

('z107_W','z108_E'),

('z108_E','z107_W'),

('z108_SW','z116_E'),
('z109_N','z103'),
('z109_W','z139_N'),
('z109_S','z104'),
('z109_E','z110_W'),
('z111_N','z110_E'),
('z111_E','z105'),
('z111_S','z135_N'),
('z111_W','z104'),
('z112_NW','z106_NE'),
('z112_NE','z100'),
('z112_SE','z105'),

('z113_N','z101'),
('z113_W','z114_N'),
('z113_S','z100'),
('z113_E','z127_SW'),
('z115_N','z123_SW'),
('z115_W','z101'),
('z115_S','z114_N'),
('z115_E','z102'),

('z116_S','z103'),
('z116_E','z108_SW'),
('z117_NW','z119_S'),
('z117_NE','z103'),

('z117_SW','z118_N'),
('z118_N','z117_SW'),

('z118_S','z140_W'),

('z120_NW','z121_SW'),

('z120_SE','z102'),
('z120_SW','z119_N'),

('z121_NE','z122_NW'),

('z121_SW','z120_NW'),
('z122_NW','z121_NE'),
('z122_SE','z123_NW'),

('z123_NW','z122_SE'),
('z123_NE','z124_E'),

('z123_SW','z115_N'),

('z124_E','z123_NE'),

('z124_W','z125_N'),
('z125_N','z124_W'),
('z125_E','z101'),

('z125_W','z126_N'),
('z126_N','z125_W'),

('z126_S','z127_NE'),

('z127_SW','z113_E'),
('z127_SE','z128_NW'),
('z127_NE','z126_S'),
('z128_NW','z127_SE'),
('z128_NE','z129_W'),

('z129_W','z128_NE'),
('z129_S','z130_NE'),

('z130_NE','z129_S'),
('z130_SE','z131_NW'),
('z130_SW','z100'),
('z132_NW','z131_E'),

('z132_SE','z133_NE'),
('z132_SW','z105'),

('z133_NE','z132_SE'),

('z133_SW','z134_E'),

('z134_W','z135_E'),

('z134_E','z133_SW'),
('z135_N','z111_S'),

('z135_S','z136_N'),
('z135_E','z134_W'),
('z136_N','z135_S'),
('z136_W','z137_E'),

('z137_N','z104'),
('z137_W','z138_E'),

('z137_E','z136_W'),
('z138_N','z139_S'),

('z138_E','z137_W'),
('z139_N','z109_W'),
('z139_W','z140_E'),
('z139_S','z138_N'),

('z140_W','z118_S'),

('z140_E','z139_W');


DROP TABLE IF EXISTS #RAWDATA;
CREATE TABLE #RAWDATA(
	zoneid int,
	raceid int,
	x int,
	y int,
	teleName VARCHAR(100)
);
INSERT INTO #RAWDATA (zoneid, raceid, x, y, teleName) VALUES
(100,1,139, 131,'z100'),
(101,1,90, 85,'z101'),
(102,3,73, 148,'z102'),
(103,3,92,121,'z103'),
(104,2,128, 81,'z104'),
(105,2,78, 127,'z105'),

(110,2,261, 1201,'z110_W'),
(110,2,1711, 1155,'z110_E'),
(114,1,1119, 1353,'z114_S'),
(114,1,463,507,'z114_N'),
(119,3,580, 1635,'z119_S'),
(119,3,554, 741,'z119_N'),
(131,2,471,456,'z131_NW'),
(131,2,1779, 1162,'z131_E'),

(106,2,289, 468,'z106_NW'),
(106,2,1390, 1829,'z106_SE'),
(106,2,1695, 348,'z106_NE'),
(106,2,187, 1536,'z106_SW'),
(107,3,996,297,'z107_N'),
(107,3,1761, 1192,'z107_E'),
(107,3,1013, 1911,'z107_S'),
(107,3,288, 1190,'z107_W'),
(108,3,1015, 435,'z108_N'),
(108,3,1821, 856,'z108_E'),
(108,3,1764, 1740,'z108_SE'),
(108,3,603, 1694,'z108_SW'),
(109,3,975, 333,'z109_N'),
(109,3,255, 915,'z109_W'),
(109,3,1109, 1720,'z109_S'),
(109,3,1718, 801,'z109_E'),
(111,2,619, 313,'z111_N'),
(111,2,1878, 897,'z111_E'),
(111,2,1416, 1849,'z111_S'),
(111,2,289, 1316,'z111_W'),
(112,2,386, 235,'z112_NW'),
(112,2,1577, 199,'z112_NE'),
(112,2,1364, 1269,'z112_SE'),
(112,2,602, 1663,'z112_SW'),
(113,1,1068, 346,'z113_N'),
(113,1,342, 1482,'z113_W'),
(113,1,1416, 1802,'z113_S'),
(113,1,1729, 857,'z113_E'),
(115,1,929, 265,'z115_N'),
(115,1,324, 1315,'z115_W'),
(115,1,1759, 1755,'z115_S'),
(115,1,1699, 881,'z115_E'),
(116,3,975, 534,'z116_N'),
(116,3,156, 1189,'z116_W'),
(116,3,1405, 1874,'z116_S'),
(116,3,1897, 1044,'z116_E'),
(117,3,280, 247,'z117_NW'),
(117,3,1425, 389,'z117_NE'),
(117,3,1731, 1348,'z117_SE'),
(117,3,808, 1456,'z117_SW'),
(118,3,1245, 272,'z118_N'),
(118,3,1789, 769,'z118_E'),
(118,3,1059, 1519,'z118_S'),
(118,3,302, 930,'z118_W'),
(120,3,460, 270,'z120_NW'),
(120,3,1531, 321,'z120_NE'),
(120,3,1547, 1408,'z120_SE'),
(120,3,254, 1387,'z120_SW'),
(121,1,428, 305,'z121_NW'),
(121,1,1624, 401,'z121_NE'),
(121,1,1566, 1679,'z121_SE'),
(121,1,436, 1739,'z121_SW'),
(122,1,369, 622,'z122_NW'),
(122,1,1648, 1673,'z122_SE'),
(122,1,1430, 486,'z122_NE'),
(122,1,535, 1739,'z122_SW'),
(123,1,265, 446,'z123_NW'),
(123,1,1570, 352,'z123_NE'),
(123,1,1431, 1559,'z123_SE'),
(123,1,381, 1806,'z123_SW'),
(124,1,829, 325,'z124_N'),
(124,1,1794, 900,'z124_E'),
(124,1,1363, 1722,'z124_S'),
(124,1,285, 1251,'z124_W'),
(125,1,756, 233,'z125_N'),
(125,1,1772, 888,'z125_E'),
(125,1,1151, 1667,'z125_S'),
(125,1,380, 1277,'z125_W'),
(126,1,880, 262,'z126_N'),
(126,1,1725, 884,'z126_E'),
(126,1,1226, 1583,'z126_S'),
(126,1,385, 1171,'z126_W'),
(127,1,916, 382,'z127_NW'),
(127,1,348, 1715,'z127_SW'),
(127,1,1542, 1478,'z127_SE'),
(127,1,1856, 584,'z127_NE'),
(128,2,375, 240,'z128_NW'),
(128,2,1837, 515,'z128_NE'),
(128,2,1669, 1410,'z128_SE'),
(128,2,359, 1518,'z128_SW'),
(129,2,1020, 233,'z129_N'),
(129,2,1727, 777,'z129_E'),
(129,2,234, 1271,'z129_W'),
(129,2,1508, 1737,'z129_S'),
(130,2,530, 387,'z130_NW'),
(130,2,1675, 372,'z130_NE'),
(130,2,1715, 1534,'z130_SE'),
(130,2,600, 1448,'z130_SW'),
(132,2,683, 245,'z132_NW'),
(132,2,1767, 148,'z132_NE'),
(132,2,1768, 1543,'z132_SE'),
(132,2,229, 1281,'z132_SW'),
(133,2,340, 546,'z133_NW'),
(133,2,1780, 856,'z133_NE'),
(133,2,1708, 1664,'z133_SE'),
(133,2,284, 1725,'z133_SW'),
(134,2,992, 199,'z134_N'),
(134,2,283, 978,'z134_W'),
(134,2,1809, 835,'z134_S'),
(134,2,1043, 1415,'z134_E'),
(135,2,931, 683,'z135_N'),
(135,2,261, 1217,'z135_W'),
(135,2,1159, 1780,'z135_S'),
(135,2,1624, 908,'z135_E'),
(136,2,866, 448,'z136_N'),
(136,2,333, 982,'z136_W'),
(136,2,942, 1635,'z136_S'),
(136,2,1770, 952,'z136_E'),
(137,3,984, 456,'z137_N'),
(137,3,187, 1057,'z137_W'),
(137,3,1126, 1770,'z137_S'),
(137,3,1609, 991,'z137_E'),
(138,3,1176, 309,'z138_N'),
(138,3,320, 1036,'z138_W'),
(138,3,652, 1745,'z138_S'),
(138,3,1604, 978,'z138_E'),
(139,3,855, 273,'z139_N'),
(139,3,336, 1231,'z139_W'),
(139,3,1168, 1720,'z139_S'),
(139,3,1863, 916,'z139_E'),
(140,3,507, 836,'z140_W'),
(140,3,1260, 617,'z140_N'),
(140,3,1484, 1371,'z140_E'),
(140,3,757, 1535,'z140_S');

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
	CASE LEFT(d.teleName, 1) WHEN 'z' THEN @prefix+d.teleName ELSE d.teleName END,
	@prefix+d.teleName
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
SELECT zoneid, eid, NULL, NULL, ename, x, y, 0, 0, 1, 'tpcol', 0, synckey FROM #TELES;

PRINT N'INSERT teleportdescriptions';
PRINT N'CONNECTING A->B';
INSERT INTO teleportdescriptions
	(description, sourcecolumn, targetcolumn, sourcezone, sourcerange, targetzone, targetrange, usetimeout, listable, active, type, sourcecolumnname, targetcolumnname)
SELECT
	s.ename+'_to_'+t.ename,
	s.eid, t.eid, s.zoneid, 7, t.zoneid, 7, 0, 1, 1, 2, s.ename, t.ename 
FROM #CONNECTIONS c
INNER JOIN #TELES s on s.ename = @prefix+c.sourceColName
INNER JOIN #TELES t on t.ename = @prefix+c.targetColName;


PRINT N'Bidirectional misses: ';
SELECT
	s.ename+'_to_'+t.ename,
	s.eid, t.eid, s.zoneid, 7, t.zoneid, 7, 0, 1, 1, 2, s.ename, t.ename 
FROM #CONNECTIONS c
INNER JOIN #TELES s on s.ename = @prefix+c.targetColName
INNER JOIN #TELES t on t.ename = @prefix+c.sourceColName
WHERE s.ename+'_to_'+t.ename NOT IN (SELECT description from teleportdescriptions)
PRINT N'CONNECTING B->A if missing from config';
--Insert the other direction by joining the opposite names
INSERT INTO teleportdescriptions
	(description, sourcecolumn, targetcolumn, sourcezone, sourcerange, targetzone, targetrange, usetimeout, listable, active, type, sourcecolumnname, targetcolumnname)
SELECT
	s.ename+'_to_'+t.ename,
	s.eid, t.eid, s.zoneid, 7, t.zoneid, 7, 0, 1, 1, 2, s.ename, t.ename 
FROM #CONNECTIONS c
INNER JOIN #TELES s on s.ename = @prefix+c.targetColName
INNER JOIN #TELES t on t.ename = @prefix+c.sourceColName
WHERE s.ename+'_to_'+t.ename NOT IN (SELECT description from teleportdescriptions)


PRINT N'TELEPORT NETWORK BUILT';
GO

