USE [perpetuumsa]
GO
---------------------------------
-- GAMMA RELICS
-- Contributors: Ghroom
-- Date Modified: 2021/10/20
---------------------------------
PRINT N'Configure and insert gamma relics';
DROP TABLE IF EXISTS #TMPRELICTYPE;
CREATE TABLE #TMPRELICTYPE(
	name varchar(128) NOT NULL,
	raceid int NULL,
	level int NULL,
	ep int NULL
);
INSERT INTO #TMPRELICTYPE (name,raceid,level,ep) VALUES
('relic_level4_neutral_gamma',0,4,130),
('relic_level4_indy_gamma',4,4,130),
('relic_level4_numiqol_gamma',2,4,130),
('relic_level4_thelodica_gamma',3,4,130),
('relic_level4_pelistal_gamma',1,4,130);

--SELECT * FROM relictypes WHERE name IN (SELECT DISTINCT name FROM #TMPRELICTYPE);
DELETE FROM relictypes WHERE name IN (SELECT DISTINCT name FROM #TMPRELICTYPE);

INSERT INTO relictypes (name, raceid, level, ep)
SELECT name, raceid, level, ep FROM #TMPRELICTYPE;

INSERT INTO dbo.relictypes (name,raceid,level,ep)
SELECT name,raceid,level,ep
FROM #TMPRELICTYPE;

DROP TABLE IF EXISTS #TMPRELICTYPE;
GO

USE [perpetuumsa]
GO

DROP TABLE IF EXISTS #ZONES_BY_TIER;
CREATE TABLE #ZONES_BY_TIER(
	zoneid int,
	tier int
);
INSERT INTO #ZONES_BY_TIER (zoneid, tier)
SELECT id, pbsTechLimit FROM zones WHERE pbsTechLimit IS NOT NULL AND id>99;

--Tc's flag with -1 for case statement
UPDATE #ZONES_BY_TIER SET
	tier = -1
WHERE zoneid < 106 AND zoneid > 99;


DROP TABLE IF EXISTS #TMPRELICSPAWNINFO;
CREATE TABLE #TMPRELICSPAWNINFO(	
	tiername varchar(100),
	relictypename varchar(100),
	relictypeid int NULL,
	tier int NULL,
	rate int NOT NULL,
	x int NULL,
	y int NULL
);

INSERT INTO #TMPRELICSPAWNINFO(tiername,relictypename,rate)
VALUES
('T0','relic_level2_neutral_beta2',10),
('T0','relic_level3_neutral_beta2',20),
('T0','relic_level4_neutral_gamma',25),
('T0','relic_level2_indy_beta2',10),
('T0','relic_level3_indy_beta2',20),
('T0','relic_level4_indy_gamma',25),
('T0','relic_level2_numiqol_beta2',10),
('T0','relic_level3_numiqol_beta2',20),
('T0','relic_level4_numiqol_gamma',25),
('T0','relic_level2_thelodica_beta2',10),
('T0','relic_level3_thelodica_beta2',20),
('T0','relic_level4_thelodica_gamma',25),
('T0','relic_level2_pelistal_beta2',10),
('T0','relic_level3_pelistal_beta2',20),
('T0','relic_level4_pelistal_gamma',25),
('T1','relic_level2_neutral_beta2',10),
('T1','relic_level3_neutral_beta2',25),
('T1','relic_level4_neutral_gamma',20),
('T1','relic_level2_indy_beta2',10),
('T1','relic_level3_indy_beta2',25),
('T1','relic_level4_indy_gamma',20),
('T1','relic_level2_numiqol_beta2',10),
('T1','relic_level3_numiqol_beta2',25),
('T1','relic_level4_numiqol_gamma',20),
('T1','relic_level2_thelodica_beta2',10),
('T1','relic_level3_thelodica_beta2',25),
('T1','relic_level4_thelodica_gamma',20),
('T1','relic_level2_pelistal_beta2',10),
('T1','relic_level3_pelistal_beta2',25),
('T1','relic_level4_pelistal_gamma',20),
('T2','relic_level2_neutral_beta2',15),
('T2','relic_level3_neutral_beta2',25),
('T2','relic_level4_neutral_gamma',15),
('T2','relic_level2_indy_beta2',15),
('T2','relic_level3_indy_beta2',25),
('T2','relic_level4_indy_gamma',15),
('T2','relic_level2_numiqol_beta2',15),
('T2','relic_level3_numiqol_beta2',25),
('T2','relic_level4_numiqol_gamma',15),
('T2','relic_level2_thelodica_beta2',10),
('T2','relic_level3_thelodica_beta2',25),
('T2','relic_level4_thelodica_gamma',20),
('T2','relic_level2_pelistal_beta2',10),
('T2','relic_level3_pelistal_beta2',25),
('T2','relic_level4_pelistal_gamma',20),
('T3','relic_level2_neutral_beta2',30),
('T3','relic_level3_neutral_beta2',20),
('T3','relic_level4_neutral_gamma',10),
('T3','relic_level2_indy_beta2',30),
('T3','relic_level3_indy_beta2',20),
('T3','relic_level4_indy_gamma',10),
('T3','relic_level2_numiqol_beta2',30),
('T3','relic_level3_numiqol_beta2',20),
('T3','relic_level4_numiqol_gamma',10),
('T3','relic_level2_thelodica_beta2',30),
('T3','relic_level3_thelodica_beta2',20),
('T3','relic_level4_thelodica_gamma',10),
('T3','relic_level2_pelistal_beta2',30),
('T3','relic_level3_pelistal_beta2',20),
('T3','relic_level4_pelistal_gamma',10),
('TC','relic_level2_neutral_beta2',20),
('TC','relic_level2_indy_beta2',20),
('TC','relic_level2_numiqol_beta2',20),
('TC','relic_level2_pelistal_beta2',20),
('TC','relic_level2_thelodica_beta2',20);

DROP TABLE IF EXISTS #CONFIG;
CREATE TABLE #CONFIG(
	tier int,
	maxSpawn int,
	respawnRate int
);
INSERT INTO #CONFIG(tier, maxSpawn, respawnRate) VALUES
(-1, 1, 10800),
(0, 18, 10800),
(1, 9, 10800),
(2, 9, 10800),
(3, 9, 10800);

UPDATE t
SET t.relictypeid = (SELECT TOP 1 reltyp.id FROM dbo.relictypes reltyp WHERE reltyp.name = t.relictypename),
	t.tier = (CASE WHEN t.tiername = 'TC' THEN -1
				WHEN t.tiername = 'T0' THEN 0
				WHEN t.tiername = 'T1' THEN 1
				WHEN t.tiername = 'T2' THEN 2
				WHEN t.tiername = 'T3' THEN 3
			END)
FROM #TMPRELICSPAWNINFO t;


DROP TABLE IF EXISTS #INFOS;
CREATE TABLE #INFOS(	
	relictypeid int NULL,
	zoneid int NULL,
	rate int NOT NULL,
	x int NULL,
	y int NULL
);
INSERT INTO #INFOS (relictypeid, zoneid, rate)
SELECT t.relictypeid, z.zoneid, t.rate
FROM #ZONES_BY_TIER z
JOIN #TMPRELICSPAWNINFO t ON t.tier=z.tier;

--SELECT * FROM dbo.relicspawninfo WHERE zoneid IN (SELECT DISTINCT zoneid FROM #ZONES_BY_TIER);
DELETE FROM dbo.relicspawninfo WHERE zoneid IN (SELECT DISTINCT zoneid FROM #ZONES_BY_TIER);

INSERT INTO dbo.relicspawninfo (relictypeid,zoneid,rate)
SELECT relictypeid,zoneid,rate
FROM #INFOS;

--SELECT * FROM dbo.reliczoneconfig WHERE zoneid IN (SELECT DISTINCT zoneid FROM #ZONES_BY_TIER);
DELETE FROM dbo.reliczoneconfig WHERE zoneid IN (SELECT DISTINCT zoneid FROM #ZONES_BY_TIER);

INSERT INTO dbo.reliczoneconfig(zoneid, maxspawn, respawnrate)
SELECT z.zoneid, c.maxSpawn, c.respawnRate
FROM #ZONES_BY_TIER z
JOIN #CONFIG c ON c.tier=z.tier;

DROP TABLE IF EXISTS #INFOS;
DROP TABLE IF EXISTS #TMPRELICSPAWNINFO;
DROP TABLE IF EXISTS #ZONES_BY_TIER;
GO

USE [perpetuumsa]
GO

DROP TABLE IF EXISTS #TMPRELICLOOT;
CREATE TABLE #TMPRELICLOOT(	
	relicname varchar(100) NOT NULL,
	defname varchar(100) NOT NULL,
	minquantity int NOT NULL,
	maxquantity int NOT NULL,
	chance decimal(9, 6) NOT NULL,
	definition int NULL,
	relictypeid int NULL
);

INSERT INTO #TMPRELICLOOT (relicname,defname,minquantity,maxquantity,chance)
VALUES
('relic_level4_neutral_gamma','def_robotshard_common_basic',70,75,1),
('relic_level4_neutral_gamma','def_robotshard_common_advanced',70,75,1),
('relic_level4_neutral_gamma','def_robotshard_common_expert',70,75,1),
('relic_level4_neutral_gamma','def_common_reactor_plasma',5850,7150,1),
('relic_level4_neutral_gamma','def_kernel_common',8776,10726,1),
('relic_level4_neutral_gamma','def_kernel_hitech',2926,3576,1),

('relic_level4_indy_gamma','def_robotshard_common_basic',70,75,1),
('relic_level4_indy_gamma','def_robotshard_common_advanced',70,75,1),
('relic_level4_indy_gamma','def_robotshard_common_expert',70,75,1),
('relic_level4_indy_gamma','def_common_reactor_plasma',5850,7150,1),
('relic_level4_indy_gamma','def_kernel_industrial',5850,7150,1),
('relic_level4_indy_gamma','def_kernel_common',5850,7150,1),

('relic_level4_numiqol_gamma','def_robotshard_nuimqol_basic',70,75,1),
('relic_level4_numiqol_gamma','def_robotshard_nuimqol_advanced',70,75,1),
('relic_level4_numiqol_gamma','def_robotshard_nuimqol_expert',70,75,1),
('relic_level4_numiqol_gamma','def_nuimqol_reactor_plasma',5850,7150,1),
('relic_level4_numiqol_gamma','def_kernel_nuimqol',5850,7150,1),
('relic_level4_numiqol_gamma','def_kernel_common',5850,7150,1),

('relic_level4_thelodica_gamma','def_robotshard_thelodica_basic',70,75,1),
('relic_level4_thelodica_gamma','def_robotshard_thelodica_advanced',70,75,1),
('relic_level4_thelodica_gamma','def_robotshard_thelodica_expert',70,75,1),
('relic_level4_thelodica_gamma','def_thelodica_reactor_plasma',5850,7150,1),
('relic_level4_thelodica_gamma','def_kernel_thelodica',5850,7150,1),
('relic_level4_thelodica_gamma','def_kernel_common',5850,7150,1),

('relic_level4_pelistal_gamma','def_robotshard_pelistal_basic',70,75,1),
('relic_level4_pelistal_gamma','def_robotshard_pelistal_advanced',70,75,1),
('relic_level4_pelistal_gamma','def_robotshard_pelistal_expert',70,75,1),
('relic_level4_pelistal_gamma','def_pelistal_reactor_plasma',5850,7150,1),
('relic_level4_pelistal_gamma','def_kernel_pelistal',5850,7150,1),
('relic_level4_pelistal_gamma','def_kernel_common',5850,7150,1);

UPDATE t
SET t.relictypeid = (SELECT TOP 1 reltyp.id FROM dbo.relictypes reltyp WHERE reltyp.name = t.relicname),
	t.definition = (SELECT TOP 1 e.definition FROM dbo.entitydefaults e WHERE e.definitionname = t.defname)
FROM #TMPRELICLOOT t;

--SELECT * FROM relicloot WHERE id IN (SELECT DISTINCT relictypeid FROM #TMPRELICLOOT);
DELETE FROM relicloot WHERE id IN (SELECT DISTINCT relictypeid FROM #TMPRELICLOOT);

INSERT INTO dbo.relicloot (definition,minquantity,maxquantity,chance,relictypeid,packed)
SELECT definition, minquantity, maxquantity, chance, relictypeid, 0 as packed
FROM #TMPRELICLOOT

DROP TABLE IF EXISTS #TMPRELICLOOT;
GO

PRINT N'GAMMA RELICS CONFIGURED AND INSERTED';
GO