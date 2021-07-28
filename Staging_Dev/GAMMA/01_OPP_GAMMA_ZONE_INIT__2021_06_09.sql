USE [perpetuumsa]
GO

DROP TABLE IF EXISTS #GAMMAPLANTS;
CREATE TABLE #GAMMAPLANTS(
	ruleSetID INT,
	plantRuleFile VARCHAR(100)
);
INSERT INTO #GAMMAPLANTS (ruleSetID, plantRuleFile) VALUES
--raceid3 thelodica
--t0
(30,'electroplant_t0.txt'),
(30,'irontree_t0.txt'),
(30,'slimeroot_t0.txt'),
--(30,'rustbush_t0.txt'),
(30,'bush_a.txt'),
(30,'bush_b.txt'),
(30,'coppertree.txt'),
(30,'devrinol.txt'),
(30,'grass_a.txt'),
(30,'grass_b.txt'),
(30,'nanowheat.txt'),
(30,'pinetree.txt'),
(30,'poffeteg.txt'),
(30,'quag.txt'),
(30,'rango.txt'),
(30,'reed.txt'),
--t1
(31,'electroplant_t1.txt'),
(31,'irontree_t1.txt'),
(31,'slimeroot_t1.txt'),
--(31,'rustbush_t1.txt'),
(31,'electroplant_seeded_t1.txt'),
(31,'irontree_seeded_t1.txt'),
(31,'slimeroot_seeded_t1.txt'),
(31,'rustbush_seeded_t1.txt'),
(31,'bush_a.txt'),
(31,'bush_b.txt'),
(31,'coppertree.txt'),
(31,'devrinol.txt'),
(31,'grass_a.txt'),
(31,'grass_b.txt'),
(31,'nanowheat.txt'),
(31,'pinetree.txt'),
(31,'poffeteg.txt'),
(31,'quag.txt'),
(31,'rango.txt'),
(31,'reed.txt'),
(31,'wall.txt'),
--t2
(32,'electroplant_t2.txt'),
(32,'irontree_t2.txt'),
(32,'slimeroot_t2.txt'),
--(32,'rustbush_t2.txt'),
(32,'electroplant_seeded_t2.txt'),
--(32,'irontree_seeded_t2.txt'),
--(32,'slimeroot_seeded_t2.txt'),
(32,'rustbush_seeded_t2.txt'),
(32,'bush_a.txt'),
(32,'bush_b.txt'),
(32,'coppertree.txt'),
(32,'devrinol.txt'),
(32,'grass_a.txt'),
(32,'grass_b.txt'),
(32,'nanowheat.txt'),
(32,'pinetree.txt'),
(32,'poffeteg.txt'),
(32,'quag.txt'),
(32,'rango.txt'),
(32,'reed.txt'),
(32,'wall.txt'),
--t3
(33,'electroplant_t3.txt'),
(33,'irontree_t3.txt'),
(33,'slimeroot_t3.txt'),
--(33,'rustbush_t3.txt'),
--(33,'electroplant_seeded_t3.txt'),
--(33,'irontree_seeded_t3.txt'),
--(33,'slimeroot_seeded_t3.txt'),
(33,'rustbush_seeded_t3.txt'),
(33,'bush_a.txt'),
(33,'bush_b.txt'),
(33,'coppertree.txt'),
(33,'devrinol.txt'),
(33,'grass_a.txt'),
(33,'grass_b.txt'),
(33,'nanowheat.txt'),
(33,'pinetree.txt'),
(33,'poffeteg.txt'),
(33,'quag.txt'),
(33,'rango.txt'),
(33,'reed.txt'),
(33,'wall.txt'),
--TC
(34,'bush_a.txt'),
(34,'bush_b.txt'),
(34,'coppertree.txt'),
(34,'devrinol.txt'),
(34,'grass_a.txt'),
(34,'grass_b.txt'),
(34,'nanowheat.txt'),
(34,'pinetree.txt'),
(34,'poffeteg.txt'),
(34,'quag.txt'),
(34,'rango.txt'),
(34,'reed.txt'),

--raceid2 nuimqol
--t0
(20,'electroplant_t0.txt'),
(20,'irontree_t0.txt'),
--(20,'slimeroot_t0.txt'),
(20,'rustbush_t0.txt'),
(20,'bush_a.txt'),
(20,'bush_b.txt'),
(20,'coppertree.txt'),
(20,'devrinol.txt'),
(20,'grass_a.txt'),
(20,'grass_b.txt'),
(20,'nanowheat.txt'),
(20,'pinetree.txt'),
(20,'poffeteg.txt'),
(20,'quag.txt'),
(20,'rango.txt'),
(20,'reed.txt'),
--t1
(21,'electroplant_t1.txt'),
(21,'irontree_t1.txt'),
--(21,'slimeroot_t1.txt'),
(21,'rustbush_t1.txt'),
(21,'electroplant_seeded_t1.txt'),
(21,'irontree_seeded_t1.txt'),
(21,'slimeroot_seeded_t1.txt'),
(21,'rustbush_seeded_t1.txt'),
(21,'bush_a.txt'),
(21,'bush_b.txt'),
(21,'coppertree.txt'),
(21,'devrinol.txt'),
(21,'grass_a.txt'),
(21,'grass_b.txt'),
(21,'nanowheat.txt'),
(21,'pinetree.txt'),
(21,'poffeteg.txt'),
(21,'quag.txt'),
(21,'rango.txt'),
(21,'reed.txt'),
(21,'wall.txt'),
--t2
(22,'electroplant_t2.txt'),
(22,'irontree_t2.txt'),
--(22,'slimeroot_t2.txt'),
(22,'rustbush_t2.txt'),
(22,'electroplant_seeded_t2.txt'),
--(22,'irontree_seeded_t2.txt'),
(22,'slimeroot_seeded_t2.txt'),
--(22,'rustbush_seeded_t2.txt'),
(22,'bush_a.txt'),
(22,'bush_b.txt'),
(22,'coppertree.txt'),
(22,'devrinol.txt'),
(22,'grass_a.txt'),
(22,'grass_b.txt'),
(22,'nanowheat.txt'),
(22,'pinetree.txt'),
(22,'poffeteg.txt'),
(22,'quag.txt'),
(22,'rango.txt'),
(22,'reed.txt'),
(22,'wall.txt'),
--t3
(23,'electroplant_t3.txt'),
(23,'irontree_t3.txt'),
--(23,'slimeroot_t3.txt'),
(23,'rustbush_t3.txt'),
--(23,'electroplant_seeded_t3.txt'),
--(23,'irontree_seeded_t3.txt'),
(23,'slimeroot_seeded_t3.txt'),
--(23,'rustbush_seeded_t3.txt'),
(23,'bush_a.txt'),
(23,'bush_b.txt'),
(23,'coppertree.txt'),
(23,'devrinol.txt'),
(23,'grass_a.txt'),
(23,'grass_b.txt'),
(23,'nanowheat.txt'),
(23,'pinetree.txt'),
(23,'poffeteg.txt'),
(23,'quag.txt'),
(23,'rango.txt'),
(23,'reed.txt'),
(23,'wall.txt'),
--TC
(24,'bush_a.txt'),
(24,'bush_b.txt'),
(24,'coppertree.txt'),
(24,'devrinol.txt'),
(24,'grass_a.txt'),
(24,'grass_b.txt'),
(24,'nanowheat.txt'),
(24,'pinetree.txt'),
(24,'poffeteg.txt'),
(24,'quag.txt'),
(24,'rango.txt'),
(24,'reed.txt'),

--raceid1 pelistal
--t0
(10,'electroplant_t0.txt'),
--(10,'irontree_t0.txt'),
(10,'slimeroot_t0.txt'),
(10,'rustbush_t0.txt'),
(10,'bush_a.txt'),
(10,'bush_b.txt'),
(10,'coppertree.txt'),
(10,'devrinol.txt'),
(10,'grass_a.txt'),
(10,'grass_b.txt'),
(10,'nanowheat.txt'),
(10,'pinetree.txt'),
(10,'poffeteg.txt'),
(10,'quag.txt'),
(10,'rango.txt'),
(10,'reed.txt'),
--t1
(11,'electroplant_t1.txt'),
--(11,'irontree_t1.txt'),
(11,'slimeroot_t1.txt'),
(11,'rustbush_t1.txt'),
(11,'electroplant_seeded_t1.txt'),
(11,'irontree_seeded_t1.txt'),
(11,'slimeroot_seeded_t1.txt'),
(11,'rustbush_seeded_t1.txt'),
(11,'bush_a.txt'),
(11,'bush_b.txt'),
(11,'coppertree.txt'),
(11,'devrinol.txt'),
(11,'grass_a.txt'),
(11,'grass_b.txt'),
(11,'nanowheat.txt'),
(11,'pinetree.txt'),
(11,'poffeteg.txt'),
(11,'quag.txt'),
(11,'rango.txt'),
(11,'reed.txt'),
(11,'wall.txt'),
--t2
(12,'electroplant_t2.txt'),
--(12,'irontree_t2.txt'),
(12,'slimeroot_t2.txt'),
(12,'rustbush_t2.txt'),
(12,'electroplant_seeded_t2.txt'),
(12,'irontree_seeded_t2.txt'),
--(12,'slimeroot_seeded_t2.txt'),
--(12,'rustbush_seeded_t2.txt'),
(12,'bush_a.txt'),
(12,'bush_b.txt'),
(12,'coppertree.txt'),
(12,'devrinol.txt'),
(12,'grass_a.txt'),
(12,'grass_b.txt'),
(12,'nanowheat.txt'),
(12,'pinetree.txt'),
(12,'poffeteg.txt'),
(12,'quag.txt'),
(12,'rango.txt'),
(12,'reed.txt'),
(12,'wall.txt'),
--t3
(13,'electroplant_t3.txt'),
--(13,'irontree_t3.txt'),
(13,'slimeroot_t3.txt'),
(13,'rustbush_t3.txt'),
--(13,'electroplant_seeded_t3.txt'),
(13,'irontree_seeded_t3.txt'),
--(13,'slimeroot_seeded_t3.txt'),
--(13,'rustbush_seeded_t3.txt'),
(13,'bush_a.txt'),
(13,'bush_b.txt'),
(13,'coppertree.txt'),
(13,'devrinol.txt'),
(13,'grass_a.txt'),
(13,'grass_b.txt'),
(13,'nanowheat.txt'),
(13,'pinetree.txt'),
(13,'poffeteg.txt'),
(13,'quag.txt'),
(13,'rango.txt'),
(13,'reed.txt'),
(13,'wall.txt'),
--TC
(14,'bush_a.txt'),
(14,'bush_b.txt'),
(14,'coppertree.txt'),
(14,'devrinol.txt'),
(14,'grass_a.txt'),
(14,'grass_b.txt'),
(14,'nanowheat.txt'),
(14,'pinetree.txt'),
(14,'poffeteg.txt'),
(14,'quag.txt'),
(14,'rango.txt'),
(14,'reed.txt');


DROP TABLE IF EXISTS #FACTIONPLANTMAP;
CREATE TABLE #FACTIONPLANTMAP(
	raceID INT,
	tierLevel INT,
	ruleID INT
);
INSERT INTO #FACTIONPLANTMAP (raceID, tierLevel, ruleID) VALUES
(1, 0, 10),
(1, 1, 11),
(1, 2, 12),
(1, 3, 13),
(1, -1, 14),
(2, 0, 20),
(2, 1, 21),
(2, 2, 22),
(2, 3, 23),
(2, -1, 24),
(3, 0, 30),
(3, 1, 31),
(3, 2, 32),
(3, 3, 33),
(3, -1, 34);

DROP TABLE IF EXISTS #GAMMAZONEPREP;
CREATE TABLE #GAMMAZONEPREP(
	zId INT,
	zPrefix VARCHAR(100),
	zSize INT,
	x INT,
	y INT,
	raceID INT,
	tier INT
);
INSERT INTO #GAMMAZONEPREP (zId, zPrefix, zSize, x, y, raceID, tier) VALUES
--Tc islands
(100, 'zone_gamma_tc_z', 256, 7988, -34302, 1, -1),
(101, 'zone_gamma_tc_z', 256, -374, -40237, 1, -1),
(102, 'zone_gamma_tc_z', 256, -9082, -34128, 3, -1),
(103, 'zone_gamma_tc_z', 256, -10035, -24034, 3, -1),
(104, 'zone_gamma_tc_z', 256, 1447, -18626, 2, -1),
(105, 'zone_gamma_tc_z', 256, 13275, -23435, 2, -1),

--Phase1
(106, 'zone_gamma_z', 2048, 3731, -29068, 2, 2),
(107, 'zone_gamma_z', 2048, -81, -27422, 3, 3),
(108, 'zone_gamma_z', 2048, -6233, -29242, 3, 2),
(109, 'zone_gamma_z', 2048, -5410, -22223, 3, 1),
(110, 'zone_gamma_z', 2048, 1435, -22223, 2, 0),
(111, 'zone_gamma_z', 2048, 7630, -24519, 2, 1),
(112, 'zone_gamma_z', 2048, 10923, -27985, 2, 1),
(113, 'zone_gamma_z', 2048, 3168, -33574, 1, 1),
(114, 'zone_gamma_z', 2048, -3677, -33487, 1, 0),
(115, 'zone_gamma_z', 2048, -7230, -35697, 1, 1),
(116, 'zone_gamma_z', 2048, -12862, -28548, 3, 1),

--Phase2
(117, 'zone_gamma_z', 2048, -15678, -24303, 3, 1),
(118, 'zone_gamma_z', 2048, -17584, -19624, 3, 2),
(119, 'zone_gamma_z', 2048, -16588, -31884, 3, 0),
(120, 'zone_gamma_z', 2048, -13468, -36867, 3, 1),
(121, 'zone_gamma_z', 2048, -12515, -41502, 1, 2),
(122, 'zone_gamma_z', 2048, -8876, -44102, 1, 3),
(123, 'zone_gamma_z', 2048, -4240, -42455, 1, 2),
(124, 'zone_gamma_z', 2048, -428, -46354, 1, 2),
(125, 'zone_gamma_z', 2048, 3774, -44535, 1, 1),
(126, 'zone_gamma_z', 2048, 8367, -41372, 1, 2),
(127, 'zone_gamma_z', 2048, 4858, -38556, 1, 2),
(128, 'zone_gamma_z', 2048, 9536, -36910, 2, 3),
(129, 'zone_gamma_z', 2048, 14389, -37516, 2, 2),
(130, 'zone_gamma_z', 2048, 14215, -33877, 2, 1),
(131, 'zone_gamma_z', 2048, 15299, -30108, 2, 0),
(132, 'zone_gamma_z', 2048, 17118, -25256, 2, 1),
(133, 'zone_gamma_z', 2048, 17725, -20577, 2, 2),
(134, 'zone_gamma_z', 2048, 14259, -17761, 2, 3),
(135, 'zone_gamma_z', 2048, 8973, -19147, 2, 2),
(136, 'zone_gamma_z', 2048, 10360, -13298, 2, 2),
(137, 'zone_gamma_z', 2048, 3428, -13688, 3, 1),
(138, 'zone_gamma_z', 2048, -4674, -14078, 3, 2),
(139, 'zone_gamma_z', 2048, -5150, -17674, 3, 2),
(140, 'zone_gamma_z', 2048, -13165, -17804, 3, 3);

PRINT N'CLEAR PLANT RULES';
SELECT * FROM plantrules WHERE rulesetid IN (SELECT DISTINCT ruleSetID FROM #GAMMAPLANTS);
DELETE FROM plantrules WHERE rulesetid IN (SELECT DISTINCT ruleSetID FROM #GAMMAPLANTS);
PRINT N'INSERT PLANT RULES';
INSERT INTO plantrules (plantrule, rulesetid, note)
SELECT plantRuleFile, ruleSetID, 'Gamma Plant Rules' FROM #GAMMAPLANTS;


PRINT N'CLEAR FLOCKS';
SELECT * FROM npcflock WHERE presenceid IN (
	SELECT id FROM npcpresence WHERE spawnid IN (
		SELECT spawnid FROM zones WHERE id IN (
			SELECT zId FROM #GAMMAZONEPREP
		)
	)
);
DELETE FROM npcflock WHERE presenceid IN (
	SELECT id FROM npcpresence WHERE spawnid IN (
		SELECT spawnid FROM zones WHERE id IN (
			SELECT zId FROM #GAMMAZONEPREP
		)
	)
);
PRINT N'CLEAR PRESENCE';
SELECT * FROM npcpresence WHERE spawnid IN (
	SELECT spawnid FROM zones WHERE id IN (
		SELECT zId FROM #GAMMAZONEPREP
	)
);
DELETE FROM npcpresence WHERE spawnid IN (
	SELECT spawnid FROM zones WHERE id IN (
		SELECT zId FROM #GAMMAZONEPREP
	)
);

PRINT N'CLEAR SPAWN';
SELECT * FROM npcspawn WHERE id IN (SELECT spawnid FROM zones WHERE id IN (SELECT zId FROM #GAMMAZONEPREP));
DELETE FROM npcspawn WHERE id IN (SELECT spawnid FROM zones WHERE id IN (SELECT zId FROM #GAMMAZONEPREP));

PRINT N'INSERT SPAWN';
INSERT INTO [dbo].[npcspawn] ([name],[description],[note])
SELECT 'zone_gamma_' + CONVERT(varchar(10), zId) + '_spawn',
'zone_gamma_' + CONVERT(varchar(10), zId) + '_spawn',
'zone_gamma_' + CONVERT(varchar(10), zId) + '_spawn' FROM #GAMMAZONEPREP;


--SET ENTITY FOR ZONE STORAGE
DECLARE @storageDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_zone_storage');
--MAJOR ASSUMPTION [entities] eid's 2200<->2300 are unused!
MERGE [dbo].[entities] AS e
USING #GAMMAZONEPREP AS g 
ON (e.ename = 'es_zone_'+CONVERT(varchar(10), g.zId)+'_storage') 
WHEN MATCHED THEN 
	UPDATE SET
		e.eid=2100+g.zId
WHEN NOT MATCHED 
	THEN INSERT (eid,definition,owner,parent,health,ename,quantity,repackaged,dynprop) VALUES 
		(2100+zId,@storageDef,NULL,NULL,100,'es_zone_'+CONVERT(varchar(10), zId)+'_storage',1,0,NULL);

MERGE [dbo].[entitystorage] AS s
USING #GAMMAZONEPREP AS g 
ON (s.storage_name = 'es_zone_'+CONVERT(varchar(10), g.zId)+'_storage') 
WHEN MATCHED THEN 
	UPDATE SET
		s.eid=(SELECT TOP 1 eid FROM entities WHERE ename='es_zone_'+CONVERT(varchar(10), zId)+'_storage')
WHEN NOT MATCHED 
	THEN INSERT (storage_name,eid) VALUES 
		('es_zone_'+CONVERT(varchar(10), zId)+'_storage', (SELECT TOP 1 eid FROM entities WHERE ename='es_zone_'+CONVERT(varchar(10), zId)+'_storage'));

SELECT * FROM zones WHERE id IN (SELECT zId FROM #GAMMAZONEPREP);
DELETE FROM zones WHERE id IN (SELECT zId FROM #GAMMAZONEPREP); 

INSERT INTO [dbo].[zones]
        ([id],[x],[y],[name],[description],[note],[fertility],[zoneplugin],[zoneip],[zoneport],[isinstance],[enabled],[spawnid],[plantruleset]
		,[protected],[raceid],[width],[height],[terraformable],[zonetype],[sparkcost],[maxdockingbase],[sleeping],[plantaltitudescale],[host],[active])
SELECT
	g.zId,
	g.x,
	g.y, 
	g.zPrefix+CONVERT(varchar(10), g.zId),--[name]
	g.zPrefix+CONVERT(varchar(10), g.zId)+'_desc',--[description]
	'gamma tier '+CONVERT(varchar(10), g.tier),--[note]
	20,--[fertility]
	'zone_'+CONVERT(varchar(10), g.zId),--[zoneplugin]
	'109.236.88.106',--[zoneip]
	18800+g.zId,--[zoneport]
	0,--[isinstance]
	1,--[enabled]
	(SELECT TOP 1 id FROM npcspawn WHERE name='zone_gamma_' + CONVERT(varchar(10), g.zId) + '_spawn'),--[spawnid]
	(SELECT TOP 1 f.ruleID FROM #FACTIONPLANTMAP AS f WHERE f.raceID=g.raceID AND f.tierLevel=g.tier),--[plantruleset]
	0,--[protected]
	g.raceID,--[raceid]
	g.zSize,--[width]
	g.zSize,--[height]
	CASE WHEN g.tier > 0 THEN 1 ELSE 0 END AS terraformable,--[terraformable]--Set to 0 to disable erosion to altitude edits
	2,--[zonetype]
	3,--[sparkcost]
	2,--[maxdockingbase]
	0,--[sleeping]
	1,--[plantaltitudescale]
	'genxyHost-01',--[host]
	1--[active]
FROM #GAMMAZONEPREP AS g;

SELECT * FROM zoneriftsconfig WHERE zoneid IN (SELECT zId FROM #GAMMAZONEPREP);
DELETE FROM zoneriftsconfig WHERE zoneid IN (SELECT zId FROM #GAMMAZONEPREP);

INSERT INTO zoneriftsconfig (zoneid, maxrifts, maxlevel)
	SELECT zId, 10, 4 FROM #GAMMAZONEPREP WHERE tier>0 OR zSize>2000;

INSERT INTO zoneriftsconfig (zoneid, maxrifts, maxlevel)
	SELECT zId, 0, 0 FROM #GAMMAZONEPREP WHERE zId NOT IN (SELECT zoneid FROM zoneriftsconfig);

GO
