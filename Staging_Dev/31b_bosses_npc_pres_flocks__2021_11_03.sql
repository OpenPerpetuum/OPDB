USE [perpetuumsa]
GO

-------------------------------------------
-- T0 Gamma NPC bosses
-- flocks, pres, waves, the whole thing
-- Date modified: 2021/11/18
-------------------------------------------


DECLARE @behaviourType AS INT = 2;

DECLARE @respawnTime AS INT = (2*60*60);--2 HOURS
DECLARE @miniBossRespawnTime AS INT = (5*60*60);--5 HOURS
DECLARE @pitBossRespawnTime AS INT = (120*60*60);--120 HOURS

DECLARE @BOSS_WAVE_RANGE AS INT = 115;


DROP TABLE IF EXISTS #BOSS_LOCATIONS;
CREATE TABLE #BOSS_LOCATIONS(
	zoneid int,
	x int,
	y int,
	minibossLocation bit default 0
);
INSERT INTO #BOSS_LOCATIONS(zoneid, x, y) VALUES
(110, 1005, 1010),
(114, 966, 930),
(119, 1150, 990),
(131, 1020, 975);

INSERT INTO #BOSS_LOCATIONS(zoneid, x, y, minibossLocation) VALUES
(110, 980, 670, 1),
(114, 720, 1370, 1),
(119, 1430, 1350, 1),
(131, 830, 1280, 1);


DROP TABLE IF EXISTS #BOSS_CONFIGS;
CREATE TABLE #BOSS_CONFIGS(
	bossName varchar(128),
	respawnNoiseFactor float default 0.15,
	lootSplitFlag bit default 1,
	overrideRelations bit default 0,
	customAggressMessage varchar(255),
	customDeathMessage varchar(255),
	isAnnounced bit default 1,
);
INSERT INTO #BOSS_CONFIGS (bossName, customAggressMessage, customDeathMessage) VALUES
('def_npc_gamma_mesmer_boss_miniboss', '', ''),
('def_npc_gamma_felos_nuimqol_pitboss', '', ''),
('def_npc_gamma_seth_boss_miniboss', '', ''),
('def_npc_gamma_onyx_thelodica_pitboss', '', ''),
('def_npc_gamma_gropho_boss_miniboss', '', ''),
('def_npc_gamma_hydra_pelistal_pitboss', '', ''),
('def_npc_gamma_legatus_boss_miniboss', '', ''),
('def_npc_gamma_apollo_syndicate_syn_pitboss', '', '');


DROP TABLE IF EXISTS #WAVES;
CREATE TABLE #WAVES (
	targetFlockName VARCHAR(100),
	presenceName VARCHAR(100),
	npcDefName VARCHAR(100),
	numInFlock INT,
	thresh FLOAT
);
INSERT INTO #WAVES (targetFlockName, presenceName, npcDefName, numInFlock, thresh) VALUES
('miniboss_01_z131_mesmer_boss_miniboss', 'reinforce_miniboss_01_z131_wave0', 'def_npc_gamma_kain_dps_l6', 2, 0.1),
('miniboss_01_z131_mesmer_boss_miniboss', 'reinforce_miniboss_01_z131_wave0', 'def_npc_gamma_cameleon_shield_l6', 2, 0.1),
('miniboss_01_z131_mesmer_boss_miniboss', 'reinforce_miniboss_01_z131_wave1', 'def_npc_gamma_kain_tank_l7', 3, 0.4),
('miniboss_01_z131_mesmer_boss_miniboss', 'reinforce_miniboss_01_z131_wave1', 'def_npc_gamma_vagabond_armor_l7', 3, 0.4),
('miniboss_01_z131_mesmer_boss_miniboss', 'reinforce_miniboss_01_z131_wave2', 'def_npc_gamma_mesmer_dps_l7', 2, 0.6),
('miniboss_01_z131_mesmer_boss_miniboss', 'reinforce_miniboss_01_z131_wave2', 'def_npc_gamma_vagabond_armor_l7', 2, 0.6),
('miniboss_01_z131_mesmer_boss_miniboss', 'reinforce_miniboss_01_z131_wave2', 'def_npc_gamma_cameleon_shield_l7', 2, 0.6),

('pitboss_01_z131_felos_nuimqol_pitboss', 'reinforce_pitboss_01_z131_wave0', 'def_npc_gamma_kain_dps_l7', 2, 0.1),
('pitboss_01_z131_felos_nuimqol_pitboss', 'reinforce_pitboss_01_z131_wave0', 'def_npc_gamma_cameleon_shield_l7', 3, 0.1),
('pitboss_01_z131_felos_nuimqol_pitboss', 'reinforce_pitboss_01_z131_wave0', 'def_npc_pbs_turret_em_level0', 1, 0.1),
('pitboss_01_z131_felos_nuimqol_pitboss', 'reinforce_pitboss_01_z131_wave1', 'def_npc_gamma_kain_tank_l7', 3, 0.4),
('pitboss_01_z131_felos_nuimqol_pitboss', 'reinforce_pitboss_01_z131_wave1', 'def_npc_gamma_vagabond_armor_l7', 2, 0.4),
('pitboss_01_z131_felos_nuimqol_pitboss', 'reinforce_pitboss_01_z131_wave1', 'def_npc_gamma_cameleon_shield_l7', 2, 0.4),
('pitboss_01_z131_felos_nuimqol_pitboss', 'reinforce_pitboss_01_z131_wave1', 'def_npc_pbs_turret_em_level0', 1, 0.4),
('pitboss_01_z131_felos_nuimqol_pitboss', 'reinforce_pitboss_01_z131_wave1', 'def_npc_pbs_turret_ew_level0', 1, 0.4),
('pitboss_01_z131_felos_nuimqol_pitboss', 'reinforce_pitboss_01_z131_wave2', 'def_npc_gamma_mesmer_tank_l7', 3, 0.6),
('pitboss_01_z131_felos_nuimqol_pitboss', 'reinforce_pitboss_01_z131_wave2', 'def_npc_gamma_vagabond_shield_l7', 3, 0.6),
('pitboss_01_z131_felos_nuimqol_pitboss', 'reinforce_pitboss_01_z131_wave2', 'def_npc_gamma_cameleon_shield_l7', 2, 0.6),
('pitboss_01_z131_felos_nuimqol_pitboss', 'reinforce_pitboss_01_z131_wave2', 'def_npc_pbs_turret_em_level0', 2, 0.6),
('pitboss_01_z131_felos_nuimqol_pitboss', 'reinforce_pitboss_01_z131_wave2', 'def_npc_pbs_turret_ew_level0', 1, 0.6),

('miniboss_01_z119_seth_boss_miniboss', 'reinforce_miniboss_01_z119_wave0', 'def_npc_gamma_artemis_dps_l6', 3, 0.3),
('miniboss_01_z119_seth_boss_miniboss', 'reinforce_miniboss_01_z119_wave0', 'def_npc_gamma_intakt_shield_l6', 3, 0.3),
('miniboss_01_z119_seth_boss_miniboss', 'reinforce_miniboss_01_z119_wave1', 'def_npc_gamma_artemis_tank_l7', 4, 0.5),
('miniboss_01_z119_seth_boss_miniboss', 'reinforce_miniboss_01_z119_wave1', 'def_npc_gamma_zenith_armor_l7', 3, 0.5),
('miniboss_01_z119_seth_boss_miniboss', 'reinforce_miniboss_01_z119_wave2', 'def_npc_gamma_seth_dps_l7', 2, 0.7),
('miniboss_01_z119_seth_boss_miniboss', 'reinforce_miniboss_01_z119_wave2', 'def_npc_gamma_zenith_shield_l7', 3, 0.7),
('miniboss_01_z119_seth_boss_miniboss', 'reinforce_miniboss_01_z119_wave2', 'def_npc_gamma_artemis_dps_l7', 2, 0.7),

('pitboss_01_z119_onyx_thelodica_pitboss', 'reinforce_pitboss_01_z119_wave0', 'def_npc_gamma_artemis_dps_l7', 2, 0.2),
('pitboss_01_z119_onyx_thelodica_pitboss', 'reinforce_pitboss_01_z119_wave0', 'def_npc_gamma_intakt_shield_l7', 3, 0.2),
('pitboss_01_z119_onyx_thelodica_pitboss', 'reinforce_pitboss_01_z119_wave0', 'def_npc_pbs_turret_laser_level0', 1, 0.2),
('pitboss_01_z119_onyx_thelodica_pitboss', 'reinforce_pitboss_01_z119_wave1', 'def_npc_gamma_artemis_tank_l7', 3, 0.4),
('pitboss_01_z119_onyx_thelodica_pitboss', 'reinforce_pitboss_01_z119_wave1', 'def_npc_gamma_zenith_armor_l7', 2, 0.4),
('pitboss_01_z119_onyx_thelodica_pitboss', 'reinforce_pitboss_01_z119_wave1', 'def_npc_gamma_intakt_shield_l7', 2, 0.4),
('pitboss_01_z119_onyx_thelodica_pitboss', 'reinforce_pitboss_01_z119_wave1', 'def_npc_pbs_turret_laser_level0', 1, 0.4),
('pitboss_01_z119_onyx_thelodica_pitboss', 'reinforce_pitboss_01_z119_wave1', 'def_npc_pbs_turret_ew_level0', 1, 0.4),
('pitboss_01_z119_onyx_thelodica_pitboss', 'reinforce_pitboss_01_z119_wave2', 'def_npc_gamma_seth_dps_l7', 3, 0.6),
('pitboss_01_z119_onyx_thelodica_pitboss', 'reinforce_pitboss_01_z119_wave2', 'def_npc_gamma_zenith_shield_l7', 3, 0.6),
('pitboss_01_z119_onyx_thelodica_pitboss', 'reinforce_pitboss_01_z119_wave2', 'def_npc_gamma_intakt_shield_l7', 2, 0.6),
('pitboss_01_z119_onyx_thelodica_pitboss', 'reinforce_pitboss_01_z119_wave2', 'def_npc_pbs_turret_laser_level0', 2, 0.6),
('pitboss_01_z119_onyx_thelodica_pitboss', 'reinforce_pitboss_01_z119_wave2', 'def_npc_pbs_turret_ew_level0', 1, 0.6),

('miniboss_01_z114_gropho_boss_miniboss', 'reinforce_miniboss_01_z114_wave0', 'def_npc_gamma_tyrannos_dps_l5', 4, 0.15),
('miniboss_01_z114_gropho_boss_miniboss', 'reinforce_miniboss_01_z114_wave0', 'def_npc_gamma_troiar_shield_l6', 4, 0.15),
('miniboss_01_z114_gropho_boss_miniboss', 'reinforce_miniboss_01_z114_wave1', 'def_npc_gamma_tyrannos_tank_l6', 4, 0.35),
('miniboss_01_z114_gropho_boss_miniboss', 'reinforce_miniboss_01_z114_wave1', 'def_npc_gamma_ictus_shield_l6', 3, 0.35),
('miniboss_01_z114_gropho_boss_miniboss', 'reinforce_miniboss_01_z114_wave2', 'def_npc_gamma_gropho_dps_l6', 2, 0.65),
('miniboss_01_z114_gropho_boss_miniboss', 'reinforce_miniboss_01_z114_wave2', 'def_npc_gamma_ictus_shield_l6', 3, 0.65),
('miniboss_01_z114_gropho_boss_miniboss', 'reinforce_miniboss_01_z114_wave2', 'def_npc_gamma_tyrannos_tank_l6', 2, 0.65),
('miniboss_01_z114_gropho_boss_miniboss', 'reinforce_miniboss_01_z114_wave2', 'def_npc_gropho_miniboss_rank3', 1, 0.65),

('pitboss_01_z114_hydra_pelistal_pitboss', 'reinforce_pitboss_01_z114_wave0', 'def_npc_gamma_tyrannos_dps_l6', 4, 0.15),
('pitboss_01_z114_hydra_pelistal_pitboss', 'reinforce_pitboss_01_z114_wave0', 'def_npc_gamma_troiar_shield_l7', 4, 0.15),
('pitboss_01_z114_hydra_pelistal_pitboss', 'reinforce_pitboss_01_z114_wave0', 'def_npc_pbs_turret_missile_level0', 1, 0.15),
('pitboss_01_z114_hydra_pelistal_pitboss', 'reinforce_pitboss_01_z114_wave1', 'def_npc_gamma_tyrannos_tank_l6', 4, 0.35),
('pitboss_01_z114_hydra_pelistal_pitboss', 'reinforce_pitboss_01_z114_wave1', 'def_npc_gamma_ictus_shield_l7', 2, 0.35),
('pitboss_01_z114_hydra_pelistal_pitboss', 'reinforce_pitboss_01_z114_wave1', 'def_npc_gamma_troiar_shield_l7', 3, 0.35),
('pitboss_01_z114_hydra_pelistal_pitboss', 'reinforce_pitboss_01_z114_wave1', 'def_npc_pbs_turret_missile_level0', 1, 0.35),
('pitboss_01_z114_hydra_pelistal_pitboss', 'reinforce_pitboss_01_z114_wave1', 'def_npc_pbs_turret_ew_level0', 1, 0.35),
('pitboss_01_z114_hydra_pelistal_pitboss', 'reinforce_pitboss_01_z114_wave2', 'def_npc_gamma_gropho_tank_l6', 5, 0.65),
('pitboss_01_z114_hydra_pelistal_pitboss', 'reinforce_pitboss_01_z114_wave2', 'def_npc_gamma_ictus_shield_l7', 4, 0.65),
('pitboss_01_z114_hydra_pelistal_pitboss', 'reinforce_pitboss_01_z114_wave2', 'def_npc_gamma_troiar_shield_l7', 3, 0.65),
('pitboss_01_z114_hydra_pelistal_pitboss', 'reinforce_pitboss_01_z114_wave2', 'def_npc_pbs_turret_missile_level0', 2, 0.65),
('pitboss_01_z114_hydra_pelistal_pitboss', 'reinforce_pitboss_01_z114_wave2', 'def_npc_pbs_turret_ew_level0', 1, 0.65),

('miniboss_01_z110_legatus_boss_miniboss', 'reinforce_miniboss_01_z110_wave0', 'def_npc_gamma_echelon_dps_l6', 2, 0.3),
('miniboss_01_z110_legatus_boss_miniboss', 'reinforce_miniboss_01_z110_wave0', 'def_npc_gamma_helix_shield_l6', 2, 0.3),
('miniboss_01_z110_legatus_boss_miniboss', 'reinforce_miniboss_01_z110_wave1', 'def_npc_gamma_echelon_tank_l7', 3, 0.5),
('miniboss_01_z110_legatus_boss_miniboss', 'reinforce_miniboss_01_z110_wave1', 'def_npc_gamma_callisto_shield_l7', 3, 0.5),
('miniboss_01_z110_legatus_boss_miniboss', 'reinforce_miniboss_01_z110_wave2', 'def_npc_gamma_legatus_dps_l7', 2, 0.7),
('miniboss_01_z110_legatus_boss_miniboss', 'reinforce_miniboss_01_z110_wave2', 'def_npc_gamma_callisto_armor_l7', 2, 0.7),
('miniboss_01_z110_legatus_boss_miniboss', 'reinforce_miniboss_01_z110_wave2', 'def_npc_gamma_echelon_dps_l7', 2, 0.7),
('miniboss_01_z110_legatus_boss_miniboss', 'reinforce_miniboss_01_z110_wave2', 'def_npc_gamma_helix_shield_l7', 2, 0.7),

('pitboss_01_z110_apollo_syndicate_syn_pitboss', 'reinforce_pitboss_01_z110_wave0', 'def_npc_gamma_echelon_dps_l6', 2, 0.2),
('pitboss_01_z110_apollo_syndicate_syn_pitboss', 'reinforce_pitboss_01_z110_wave0', 'def_npc_gamma_helix_shield_l7', 3, 0.2),
('pitboss_01_z110_apollo_syndicate_syn_pitboss', 'reinforce_pitboss_01_z110_wave0', 'def_npc_pbs_turret_missile_level0', 1, 0.2),
('pitboss_01_z110_apollo_syndicate_syn_pitboss', 'reinforce_pitboss_01_z110_wave1', 'def_npc_gamma_echelon_tank_l6', 3, 0.4),
('pitboss_01_z110_apollo_syndicate_syn_pitboss', 'reinforce_pitboss_01_z110_wave1', 'def_npc_gamma_callisto_armor_l7', 2, 0.4),
('pitboss_01_z110_apollo_syndicate_syn_pitboss', 'reinforce_pitboss_01_z110_wave1', 'def_npc_gamma_helix_shield_l7', 2, 0.4),
('pitboss_01_z110_apollo_syndicate_syn_pitboss', 'reinforce_pitboss_01_z110_wave1', 'def_npc_pbs_turret_laser_level0', 1, 0.4),
('pitboss_01_z110_apollo_syndicate_syn_pitboss', 'reinforce_pitboss_01_z110_wave1', 'def_npc_pbs_turret_ew_level0', 1, 0.4),
('pitboss_01_z110_apollo_syndicate_syn_pitboss', 'reinforce_pitboss_01_z110_wave2', 'def_npc_gamma_legatus_tank_l7', 3, 0.6),
('pitboss_01_z110_apollo_syndicate_syn_pitboss', 'reinforce_pitboss_01_z110_wave2', 'def_npc_gamma_callisto_shield_l7', 3, 0.6),
('pitboss_01_z110_apollo_syndicate_syn_pitboss', 'reinforce_pitboss_01_z110_wave2', 'def_npc_gamma_helix_shield_l7', 2, 0.6),
('pitboss_01_z110_apollo_syndicate_syn_pitboss', 'reinforce_pitboss_01_z110_wave2', 'def_npc_pbs_turret_em_level0', 2, 0.6),
('pitboss_01_z110_apollo_syndicate_syn_pitboss', 'reinforce_pitboss_01_z110_wave2', 'def_npc_pbs_turret_ew_level0', 1, 0.6)
;


DROP TABLE IF EXISTS #ZONES_BY_TIER_AND_FACTION;
CREATE TABLE #ZONES_BY_TIER_AND_FACTION(
	zoneId INT NOT NULL,
	zonetier INT NOT NULL,
	zonefaction varchar(128) NOT NULL
);
INSERT INTO #ZONES_BY_TIER_AND_FACTION(zoneId, zonetier, zonefaction)
SELECT
	id,
	pbsTechLimit,
	CASE raceid
		WHEN 1 THEN 'Pelistal' 
		WHEN 2 THEN 'Nuimqol' 
		WHEN 3 THEN 'Thelodica' 
	END
FROM zones WHERE id > 105 AND name not like 'zone_gamma_tc_%'
AND id != 110;

INSERT INTO #ZONES_BY_TIER_AND_FACTION(zoneId, zonetier, zonefaction)
SELECT 110, 0, 'Syndicate';


DROP TABLE IF EXISTS #TMPNPCPRESENCE;
CREATE TABLE #TMPNPCPRESENCE
(
	name varchar(128) NOT NULL, --the FULL name
	topx int NOT NULL DEFAULT 800,
	topy int NOT NULL DEFAULT 800,
	bottomx int NOT NULL DEFAULT 1200,
	bottomy int NOT NULL DEFAULT 1200,
	note nvarchar(2000) NULL,
	spawnid int NULL,
	enabled bit NOT NULL DEFAULT 1,
	roaming bit NOT NULL DEFAULT 1,
	roamingrespawnseconds int NULL DEFAULT 0, --not important for non roamers
	presencetype int NOT NULL DEFAULT 0, --static nonroam
	maxrandomflock int NULL,
	randomcenterx int NULL,
	randomcentery int NULL,
	randomradius int NULL,
	dynamiclifetime int NULL,
	isbodypull bit NOT NULL DEFAULT 1,
	isrespawnallowed bit NOT NULL DEFAULT 1,
	safebodypull bit NOT NULL DEFAULT 1,
	izgroupid int NULL,
	growthseconds int NULL
);

DROP TABLE IF EXISTS #TMPNPC;
CREATE TABLE #TMPNPC
(
	zonetier INT NOT NULL,
	zonefaction varchar(128) NOT NULL,
	fullName varchar(128) NULL, --the fully qualified name based on zone logic
	presencename varchar(100) NOT NULL, --temp field used to gather presence id later
	defname varchar(100) NOT NULL, --temp field used to gather definition id later
	flockmembercount int NULL --number of npc
);
INSERT INTO #TMPNPC (zonetier,zonefaction,presencename,defname,flockmembercount)
VALUES

(0,'Nuimqol','miniboss_01','def_npc_gamma_mesmer_boss_miniboss',1),
(0,'Nuimqol','miniboss_01','def_npc_gamma_vagabond_shield_l7',2),
(0,'Nuimqol','miniboss_01','def_npc_gamma_kain_dps_l7',2),
(0,'Nuimqol','pitboss_01','def_npc_gamma_felos_nuimqol_pitboss',1),
(0,'Nuimqol','pitboss_01','def_npc_mesmer_miniboss_rank3',1),
(0,'Nuimqol','pitboss_01','def_npc_vagabond_miniboss_rank3',2),

(0,'Thelodica','miniboss_01','def_npc_gamma_seth_boss_miniboss',1),
(0,'Thelodica','miniboss_01','def_npc_gamma_zenith_shield_l7',2),
(0,'Thelodica','miniboss_01','def_npc_gamma_artemis_dps_l7',2),
(0,'Thelodica','pitboss_01','def_npc_gamma_onyx_thelodica_pitboss',1),
(0,'Thelodica','pitboss_01','def_npc_seth_miniboss_rank3',1),
(0,'Thelodica','pitboss_01','def_npc_zenith_miniboss_rank3',2),

(0,'Pelistal','miniboss_01','def_npc_gamma_gropho_boss_miniboss',1),
(0,'Pelistal','miniboss_01','def_npc_gamma_ictus_shield_l7',2),
(0,'Pelistal','miniboss_01','def_npc_gamma_tyrannos_dps_l7',2),
(0,'Pelistal','pitboss_01','def_npc_gamma_hydra_pelistal_pitboss',1),
(0,'Pelistal','pitboss_01','def_npc_gropho_miniboss_rank3',1),
(0,'Pelistal','pitboss_01','def_npc_ictus_miniboss_rank3',2),

(0,'Syndicate','miniboss_01','def_npc_gamma_legatus_boss_miniboss',1),
(0,'Syndicate','miniboss_01','def_npc_gamma_callisto_shield_l7',2),
(0,'Syndicate','miniboss_01','def_npc_gamma_echelon_dps_l7',2),
(0,'Syndicate','pitboss_01','def_npc_gamma_apollo_syndicate_syn_pitboss',1),
(0,'Syndicate','pitboss_01','def_npc_gamma_legatus_advanced_observer',2),
(0,'Syndicate','pitboss_01','def_npc_gamma_callisto_advanced_observer',2)
;


DROP TABLE IF EXISTS #NPC_PRES_AND_FLOCK_BY_ZONE;
CREATE TABLE #NPC_PRES_AND_FLOCK_BY_ZONE
(
	zoneId INT NOT NULL,
	fullName varchar(128) NULL, --the fully qualified name based on zone logic
	defname varchar(100) NOT NULL, --temp field used to gather definition id later
	flockmembercount int NULL --number of npc
);
INSERT INTO #NPC_PRES_AND_FLOCK_BY_ZONE(zoneId, fullName, defname, flockmembercount)
SELECT z.zoneId, CONCAT(t.presencename, '_z', z.zoneId), t.defname, t.flockmembercount
FROM #TMPNPC t
INNER JOIN #ZONES_BY_TIER_AND_FACTION z ON z.zonefaction=t.zonefaction AND z.zonetier=t.zonetier;

--Boss presences
INSERT INTO #TMPNPCPRESENCE (name, spawnid, roaming, presencetype)
SELECT 
	DISTINCT fullName,
	(SELECT TOP 1 spawnid FROM zones WHERE id=zoneId),
	0, 0
FROM #NPC_PRES_AND_FLOCK_BY_ZONE;

PRINT N'DELETE AND REINSERT FLOCKS AND PRESENCES';

--Delete the member flocks of the presences about to be deleted
DELETE FROM npcflock WHERE presenceid IN (
	SELECT id FROM dbo.npcpresence WHERE name IN (
		SELECT NAME FROM #TMPNPCPRESENCE));

--Delete the presences about to be replaced
DELETE FROM dbo.npcpresence WHERE name IN (SELECT NAME FROM #TMPNPCPRESENCE);


INSERT INTO dbo.npcpresence
SELECT name,topx,topy,bottomx,bottomy,note,spawnid,enabled,roaming,roamingrespawnseconds,presencetype,maxrandomflock,
	randomcenterx,randomcentery,randomradius,dynamiclifetime,isbodypull,isrespawnallowed,safebodypull,izgroupid,growthseconds 
FROM #TMPNPCPRESENCE;



DROP TABLE IF EXISTS #TMPNPCFLOCK;
CREATE TABLE #TMPNPCFLOCK
(
	name varchar(128) NOT NULL,
	presenceid int NULL,
	--presencename varchar(100) NOT NULL, --temp field used to gather presence id later
	flockmembercount int NULL, --number of npc
	definition int NOT NULL, --definition (of npc)
	defname varchar(100) NOT NULL, --temp field used to gather definition id later
	spawnoriginX int NOT NULL DEFAULT 999,
	spawnoriginY int NOT NULL DEFAULT 999,
	spawnrangeMin int NOT NULL DEFAULT 1,
	spawnrangeMax int NOT NULL DEFAULT 15,
	respawnseconds int NOT NULL DEFAULT 1*24*60*60,
	totalspawncount int NOT NULL DEFAULT 0,	--set to 0 to allow respawning or something idk
	homerange int NOT NULL DEFAULT 90,
	note nvarchar(2000) NULL,
	respawnmultiplierlow float NULL DEFAULT 0.9,
	enabled bit NOT NULL DEFAULT 1,
	iscallforhelp bit NOT NULL DEFAULT 1,
	behaviorType int NOT NULL DEFAULT 2, --2=red
	npcSpecialType int NOT NULL DEFAULT 0
);
INSERT INTO #TMPNPCFLOCK (name,presenceid,flockmembercount,definition,defname,spawnoriginX,spawnoriginY,note,respawnseconds,behaviorType,npcSpecialType)
SELECT
	CONCAT(p.fullName, REPLACE(p.defname,'def_npc_gamma','')) as name,
	(SELECT TOP 1 n.id FROM dbo.npcpresence n WHERE n.name = p.fullName) AS presenceid,
	p.flockmembercount,
	(SELECT TOP 1 e.definition FROM dbo.entitydefaults e WHERE p.defname = e.definitionname) as definition,
	p.defname,
	z.x,
	z.y,
	'gamma boss npc' as note,
	CASE
		WHEN p.fullname like '%miniboss%' THEN @miniBossRespawnTime
		WHEN p.fullname like '%pitboss%' THEN @pitBossRespawnTime
		ELSE @respawnTime
	END as respawnseconds,
	2 as behaviorType,
	CASE WHEN p.defname in (select bossName from #BOSS_CONFIGS) THEN 1 ELSE 0 END as npcSpecialType --isboss?
FROM #NPC_PRES_AND_FLOCK_BY_ZONE p
JOIN #BOSS_LOCATIONS z ON z.zoneid=p.zoneId AND z.minibossLocation=CASE WHEN p.fullname like '%miniboss%' THEN 1 ELSE 0 END;



DELETE FROM dbo.npcflock WHERE name IN (SELECT distinct name from #TMPNPCFLOCK);

INSERT INTO dbo.npcflock(name,presenceid,flockmembercount,definition,spawnoriginX,spawnoriginY,spawnrangeMin,spawnrangeMax,respawnseconds,
	totalspawncount,homerange,note,respawnmultiplierlow,enabled,iscallforhelp,behaviorType,npcSpecialType)
SELECT name,presenceid,flockmembercount,definition,spawnoriginX,spawnoriginY,spawnrangeMin,spawnrangeMax,respawnseconds,
	totalspawncount,homerange,note,respawnmultiplierlow,enabled,iscallforhelp,behaviorType,npcSpecialType 
FROM #TMPNPCFLOCK
;

DELETE FROM dbo.npcbossinfo WHERE flockid IN (
	SELECT TOP 1 id FROM npcflock WHERE definition IN (
		SELECT definition FROM entitydefaults WHERE definitionname in (
			SELECT bossName FROM #BOSS_CONFIGS
		)
	)
);

INSERT INTO dbo.npcbossinfo(flockid, respawnNoiseFactor, lootSplitFlag, overrideRelations, customAggressMessage, customDeathMessage, isAnnounced)
SELECT (SELECT TOP 1 id FROM npcflock WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=bossName)),
	respawnNoiseFactor, lootSplitFlag, overrideRelations, customAggressMessage, customDeathMessage, isAnnounced
FROM #BOSS_CONFIGS;


PRINT N'DELETE npcflock, npcpresence, npcreinforcements IF EXISTS where data in temp table';
DELETE FROM npcflock WHERE presenceid in (SELECT id FROM npcpresence WHERE name in (SELECT DISTINCT presenceName FROM #WAVES));
DELETE FROM npcpresence WHERE name in (SELECT DISTINCT presenceName FROM #WAVES);
DELETE FROM npcreinforcements WHERE targetId in (SELECT id FROM npcflock WHERE name IN (SELECT DISTINCT targetFlockName from #WAVES));

DECLARE @reinforceType AS INT = (SELECT TOP 1 id FROM npcreinforcementtypes WHERE name='boss');
PRINT N'INSERT npcflock, npcpresence, npcreinforcements FROM #WAVES table';
INSERT INTO npcpresence 
	(name,topx,topy,bottomx,bottomy,note,spawnid,enabled,roaming,roamingrespawnseconds,presencetype,maxrandomflock,randomcenterx,randomcentery,randomradius,dynamiclifetime,isbodypull,isrespawnallowed,safebodypull,izgroupid)
SELECT DISTINCT 
	presenceName, 0, 0, 0, 0, presenceName, 10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL
FROM #WAVES;

INSERT INTO npcflock
	(name,presenceid,flockmembercount,definition,spawnoriginX,spawnoriginY,spawnrangeMin,spawnrangeMax,respawnseconds,totalspawncount,homerange,note,respawnmultiplierlow,enabled,iscallforhelp,behaviorType,npcSpecialType)
SELECT 
	presenceName+npcDefName, (SELECT id FROM npcpresence WHERE name=presenceName), numInFlock, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=npcDefName), 3, 15, 0, 10, 0, 1, @BOSS_WAVE_RANGE, presenceName+npcDefName, 0.5, 1, 1, @behaviourType, 0
FROM #WAVES;

INSERT INTO dbo.npcreinforcements
	(reinforcementType, targetId, threshold, presenceId, zoneId)
SELECT
	@reinforceType, (SELECT TOP 1 id FROM npcflock WHERE name=targetFlockName), thresh, (SELECT TOP 1 id FROM npcpresence WHERE name=presenceName), NULL
FROM #WAVES;



DROP TABLE IF EXISTS #TMPNPCPRESENCE;
DROP TABLE IF EXISTS #TMPNPCFLOCK;
DROP TABLE IF EXISTS #TMPNPC;
DROP TABLE IF EXISTS #NPC_PRES_AND_FLOCK_BY_ZONE;
DROP TABLE IF EXISTS #ZONES_BY_TIER_AND_FACTION;
DROP TABLE IF EXISTS #BOSS_CONFIGS;
DROP TABLE IF EXISTS #BOSS_LOCATIONS;
DROP TABLE IF EXISTS #WAVES;
GO