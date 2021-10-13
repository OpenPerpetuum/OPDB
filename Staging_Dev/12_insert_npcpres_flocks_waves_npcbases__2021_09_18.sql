USE [perpetuumsa]
GO

-------------------------------------
-- New GrowingPresence configs for gamma
--
-- Date modifified: 2021/09/18
-- TODO: define T1/2/3 variants w/ faction variations? (needs design)
-------------------------------------

DECLARE @PRES_TYPE AS INT = 12;
DECLARE @PRES_LIFETIME AS INT = 60*30;
DECLARE @GROWTH_CYCLE AS INT = 60*3;
DECLARE @SPAWN_ID AS INT = (select top 1 spawnid from zones where id=106);

DROP TABLE IF EXISTS #PRES;
CREATE TABLE #PRES(
	[name] [varchar](128) NOT NULL,
	[topx] [int] NOT NULL,
	[topy] [int] NOT NULL,
	[bottomx] [int] NOT NULL,
	[bottomy] [int] NOT NULL,
	[spawnid] [int] NULL,
	[enabled] [bit] NOT NULL,
	[roaming] [bit] NOT NULL,
	[roamingrespawnseconds] [int] NOT NULL,
	[presencetype] [int] NOT NULL,
	[maxrandomflock] [int] NULL,
	[randomcenterx] [int] NULL,
	[randomcentery] [int] NULL,
	[randomradius] [int] NULL,
	[dynamiclifetime] [int] NULL,
	[isbodypull] [bit] NOT NULL,
	[isrespawnallowed] [bit] NOT NULL,
	[safebodypull] [bit] NOT NULL,
	[izgroupid] [int] NULL,
	[growthseconds] [int] NULL
);
INSERT INTO #PRES (name, topx, topy, bottomx, bottomy,spawnid, enabled, roaming, roamingrespawnseconds,
	presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull,
	isrespawnallowed, safebodypull, izgroupid, growthseconds)
VALUES
	('npc_escalation_flocks_holder',999,999,1049,1049,10,0,0,0,@PRES_TYPE,NULL,NULL,NULL,NULL,NULL,1,0,1,NULL,@PRES_LIFETIME),
	('zone_106_npc_base_pres_01_TEST',40,40,2000,2000,@SPAWN_ID,1,0,@PRES_LIFETIME,@PRES_TYPE,NULL,NULL,NULL,NULL,@PRES_LIFETIME,1,1,1,NULL,@GROWTH_CYCLE),
	('zone_106_npc_base_pres_02_TEST',40,40,2000,2000,@SPAWN_ID,1,0,@PRES_LIFETIME,@PRES_TYPE,NULL,NULL,NULL,NULL,@PRES_LIFETIME,1,1,1,NULL,@GROWTH_CYCLE),
	('zone_106_npc_base_pres_03_TEST',40,40,2000,2000,@SPAWN_ID,1,0,@PRES_LIFETIME,@PRES_TYPE,NULL,NULL,NULL,NULL,@PRES_LIFETIME,1,1,1,NULL,@GROWTH_CYCLE),
	('zone_106_npc_base_pres_04_TEST',40,40,2000,2000,@SPAWN_ID,1,0,@PRES_LIFETIME,@PRES_TYPE,NULL,NULL,NULL,NULL,@PRES_LIFETIME,1,1,1,NULL,@GROWTH_CYCLE),
	('zone_106_npc_base_pres_05_TEST',40,40,2000,2000,@SPAWN_ID,1,0,@PRES_LIFETIME,@PRES_TYPE,NULL,NULL,NULL,NULL,@PRES_LIFETIME,1,1,1,NULL,@GROWTH_CYCLE);

DELETE FROM npcescalactions WHERE presenceid IN (SELECT id FROM npcpresence WHERE name IN (SELECT DISTINCT name FROM #PRES));
DELETE FROM npcflock WHERE presenceid IN (SELECT id FROM npcpresence WHERE name IN (SELECT DISTINCT name FROM #PRES));
DELETE FROM npcpresence WHERE name IN (SELECT DISTINCT name FROM #PRES);

PRINT N'INSERTING PRESENCES';
INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy,spawnid, enabled, roaming, roamingrespawnseconds,
	presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull,
	isrespawnallowed, safebodypull, izgroupid, growthseconds)
	SELECT name, topx, topy, bottomx, bottomy,spawnid, enabled, roaming, roamingrespawnseconds,
	presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull,
	isrespawnallowed, safebodypull, izgroupid, growthseconds FROM #PRES;

--INSERT INTO npcflock(name,presenceid,flockmembercount,definition,spawnoriginX,spawnoriginY,spawnrangeMin,spawnrangeMax,respawnseconds
--	,totalspawncount,homerange,note,respawnmultiplierlow,enabled,iscallforhelp,behaviorType)
--SELECT 
--	f.name + '_base',(SELECT TOP 1 id FROM npcpresence WHERE name=f.name),1, 
--	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_pbs_base_small_rank1'), 
--	555, 555, 2, 6, @PRES_LIFETIME*2, 0, 10, 'Base flock for npc base', 1, 1, 1, 2
--FROM #PRES as f WHERE name!='npc_escalation_flocks_holder';


DROP TABLE IF EXISTS #PREP_FLOCKS;
CREATE TABLE #PREP_FLOCKS (
	flockName VARCHAR(100),
	npcDefName VARCHAR(100),
	numInFlock INT,
	level INT,
	probability FLOAT
);
INSERT INTO #PREP_FLOCKS (flockName, npcDefName, numInFlock, level, probability) VALUES
('level0_base','def_npc_pbs_base_small_rank1', 1, 0, 1.0),
('level0_riv','def_npc_riveler_basic_rank5', 1, 1, 0.5),
('level0_symb','def_npc_symbiont_basic_rank5', 1, 1, 0.5),

('level1_reactor','def_npc_pbs_reactor_rank1', 1, 1, 1.0),
('level1_lithus','def_npc_lithus_basic_rank5', 1, 1, 0.5),
('level1_prom','def_npc_prometheus_scout_rank1', 1, 1, 0.33),
('level1_yagel','def_npc_yagel_scout_rank1', 1, 1, 0.33),
('level1_castel','def_npc_castel_scout_rank1', 1, 1, 0.33),

('level2_ew','def_npc_pbs_turret_ew_level0', 1, 2, 1.0),
('level2_etrans','def_npc_pbs_e_transfer_rank1', 2, 2, 1.0),
('level2_eemit','def_npc_pbs_e_emitter_rank1', 1, 2, 1.0),
('level2_seth','def_npc_seth_tank_rank5', 1, 2, 0.33),
('level2_mesmer','def_npc_mesmer_tank_rank5', 1, 2, 0.33),
('level2_gropho','def_npc_gropho_tank_rank5', 1, 2, 0.33),

('level3_em','def_npc_pbs_turret_em_level0', 1, 3, 0.33),
('level3_missile','def_npc_pbs_turret_missile_level0', 1, 3, 0.33),
('level3_laser','def_npc_pbs_turret_laser_level0', 1, 3, 0.33),
('level3_ew','def_npc_pbs_e_emitter_rank1', 1, 3, 1.0),

('level4_em','def_npc_pbs_turret_em_level0', 1, 4, 0.5),
('level4_missile','def_npc_pbs_turret_missile_level0', 1, 4, 0.5),
('level4_laser','def_npc_pbs_turret_laser_level0', 1, 4, 0.5),
--('level4_rep','def_npc_pbs_repair_rank1', 1, 4, 1.0), --bugged template probably

('level5_seth','def_npc_seth_tank_rank5', 1, 5, 0.33),
('level5_mesmer','def_npc_mesmer_tank_rank5', 1, 5, 0.33),
('level5_gropho','def_npc_gropho_tank_rank5', 1, 5, 0.33),
('level5_em','def_npc_pbs_turret_em_level0', 1, 5, 0.66),
('level5_missile','def_npc_pbs_turret_missile_level0', 1, 5, 0.66),
('level5_laser','def_npc_pbs_turret_laser_level0', 1, 5, 0.66),
('level5_boost','def_npc_pbs_eff_booster_rank1', 1, 5, 1.0),

('level6_em','def_npc_pbs_turret_em_level0', 1, 6, 0.99),
('level6_missile','def_npc_pbs_turret_missile_level0', 1, 6, 0.99),
('level6_laser','def_npc_pbs_turret_laser_level0', 1, 6, 0.99),
('level6_ew','def_npc_pbs_turret_ew_level0', 1, 6, 1.0),

('level9_niani_seth','def_npc_percent_seth_rank5', 1, 9, 0.33),
('level9_niani_mesmer','def_npc_percent_mesmer_rank5', 1, 9, 0.33),
('level9_niani_gropho','def_npc_percent_gropho_rank5', 1, 9, 0.33);

DROP TABLE IF EXISTS #LEVELS;
CREATE TABLE #LEVELS (
	targetPresName VARCHAR(100),
	flockName VARCHAR(100),
	npcDefName VARCHAR(100),
	numInFlock INT,
	level INT,
	probability FLOAT
);
INSERT INTO #LEVELS (targetPresName, flockName, npcDefName, numInFlock, level, probability)
SELECT p.name, p.name+'_'+f.flockName, f.npcDefName, f.numInFlock, f.level, f.probability FROM #PREP_FLOCKS f
JOIN #PRES p ON 1=1
WHERE p.name!='npc_escalation_flocks_holder';


DECLARE @HOLDER_PRES AS INT = (SELECT id FROM npcpresence WHERE name='npc_escalation_flocks_holder');

DELETE FROM npcflock WHERE name in (SELECT DISTINCT flockName FROM #LEVELS);

INSERT INTO npcflock
	(name,presenceid,flockmembercount,definition,
	spawnoriginX,spawnoriginY,spawnrangeMin,spawnrangeMax,respawnseconds,totalspawncount,homerange,note,respawnmultiplierlow,enabled,iscallforhelp,behaviorType,npcSpecialType)
SELECT 
	flockName, @HOLDER_PRES, numInFlock, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=npcDefName),
	0, 0, 3*level+1, 5*level+1, 0, 1, 55, 'escalation flock test', 1, 1, 1, 2, 0
FROM #LEVELS;



INSERT INTO npcescalactions (presenceId, flockId, level, chance)
SELECT
	(SELECT TOP 1 id FROM npcpresence WHERE name=L.targetPresName),
	(SELECT TOP 1 id FROM npcflock WHERE name=L.flockName),
	L.level, L.probability
FROM #LEVELS L

DROP TABLE IF EXISTS #PRES;
DROP TABLE IF EXISTS #LEVELS;
DROP TABLE IF EXISTS #PREP_FLOCKS;
GO
