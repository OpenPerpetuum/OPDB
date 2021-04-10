USE [perpetuumsa]
GO

----------------------------------------------------------------
-- Stronghold 71-72 npcs WIP script
--
-- Date mod: 2021/04/10
----------------------------------------------------------------

IF NOT EXISTS (SELECT id FROM zones WHERE name='zone_strghld_71') OR
NOT EXISTS (SELECT 1 FROM zones WHERE name='zone_strghld_72')
BEGIN
	PRINT N'ZONE 71-72 NOT FOUND! ABORTING EXECUTION';
	SET NOEXEC ON;
END

DECLARE @zone71SpawnId AS INT = (SELECT TOP 1 spawnid FROM zones WHERE name='zone_strghld_71');
DECLARE @zone72SpawnId AS INT = (SELECT TOP 1 spawnid FROM zones WHERE name='zone_strghld_72');

DROP TABLE IF EXISTS #ED;
CREATE TABLE #ED (
	def INT,
	defName VARCHAR(128),
	templateName VARCHAR(128),
	template VARCHAR(MAX) NULL,
	epKill INT,
);

INSERT INTO #ED (def, defName, templateName, epKill, template) VALUES
(5931, 'def_npc_Zone71_WilliamHBonnie', 'Zone71_WilliamHBonnie', 100, '#robot=i1590#head=i1591#chassis=i1592#leg=i1593#container=i149#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i33|slot=i2]|m2=[|definition=i32|slot=i3]|m3=[|definition=i0|slot=i4]|m4=[|definition=i0|slot=i5]]#chassisModules=[|m0=[|definition=i3d|slot=i1|ammoDefinition=i986|ammoQuantity=i1f4]|m1=[|definition=i3d|slot=i2|ammoDefinition=i988|ammoQuantity=i1f4]|m2=[|definition=i23|slot=i3]]#legModules=[|m0=[|definition=i10|slot=i1]|m1=[|definition=i19|slot=i2]|m2=[|definition=i12a|slot=i3]|m3=[|definition=i10|slot=i4]|m4=[|definition=i9f5|slot=i5]]'),
(5932, 'def_npc_Helix_BossGuard', 'Helix_Boss_Guard', 15, '#robot=i1584#head=i1585#chassis=i1586#leg=i1587#container=i146#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i33|slot=i2]|m2=[|definition=i32|slot=i3]|m3=[|definition=i0|slot=i4]]#chassisModules=[|m0=[|definition=i26|slot=i1]|m1=[|definition=i26|slot=i2]|m2=[|definition=i3c|slot=i3|ammoDefinition=i984|ammoQuantity=ifa]]#legModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]|m2=[|definition=i0|slot=i3]]'),
(5933, 'def_npc_Zone72_One_Eye_Josef', 'echelon_masterdeathdealer', 150, NULL),
(5934, 'def_npc_Rough_Rider_Death_Dealer', 'echelon_masterdeathdealer', 10, NULL);

DROP TABLE IF EXISTS #NPC_MODS;
CREATE TABLE #NPC_MODS (
	defName VARCHAR(128),
	fieldName VARCHAR(128),
	val FLOAT
);

INSERT INTO #NPC_MODS (defName, fieldName, val) VALUES
('def_npc_Zone71_WilliamHBonnie','armor_max_modifier',3),
('def_npc_Zone71_WilliamHBonnie','core_max_modifier',2.5),
('def_npc_Zone71_WilliamHBonnie','cpu_max_modifier',2),
('def_npc_Zone71_WilliamHBonnie','damage_modifier',0.25),
('def_npc_Zone71_WilliamHBonnie','missile_cycle_time_modifier',1),
('def_npc_Zone71_WilliamHBonnie','powergrid_max_modifier',2),
('def_npc_Zone71_WilliamHBonnie','speed_max_modifier',0.5),
('def_npc_Zone71_WilliamHBonnie','turret_cycle_time_modifier',0.75),
('def_npc_Helix_BossGuard','armor_max_modifier',1.25),
('def_npc_Helix_BossGuard','core_max_modifier',2),
('def_npc_Helix_BossGuard','core_recharge_time_modifier',0.5),
('def_npc_Helix_BossGuard','cpu_max_modifier',2),
('def_npc_Helix_BossGuard','damage_modifier',1),
('def_npc_Helix_BossGuard','falloff_modifier',1.25),
('def_npc_Helix_BossGuard','locking_range_modifier',1.25),
('def_npc_Helix_BossGuard','locking_time_modifier',0.75),
('def_npc_Helix_BossGuard','optimal_range_modifier',1.25),
('def_npc_Helix_BossGuard','powergrid_max_modifier',2),
('def_npc_Zone72_One_Eye_Josef','armor_max_modifier',3),
('def_npc_Zone72_One_Eye_Josef','core_max_modifier',2.5),
('def_npc_Zone72_One_Eye_Josef','core_recharge_time_modifier',1),
('def_npc_Zone72_One_Eye_Josef','cpu_max_modifier',2),
('def_npc_Zone72_One_Eye_Josef','damage_modifier',0.5),
('def_npc_Zone72_One_Eye_Josef','falloff_modifier',1.5),
('def_npc_Zone72_One_Eye_Josef','locking_range_modifier',1.5),
('def_npc_Zone72_One_Eye_Josef','locking_time_modifier',0.75),
('def_npc_Zone72_One_Eye_Josef','missile_cycle_time_modifier',0.75),
('def_npc_Zone72_One_Eye_Josef','optimal_range_modifier',1.5),
('def_npc_Zone72_One_Eye_Josef','powergrid_max_modifier',2),
('def_npc_Zone72_One_Eye_Josef','turret_cycle_time_modifier',1),
('def_npc_Rough_Rider_Death_Dealer','armor_max_modifier',1.25),
('def_npc_Rough_Rider_Death_Dealer','armor_repair_amount_modifier',0.25),
('def_npc_Rough_Rider_Death_Dealer','cpu_max_modifier',2),
('def_npc_Rough_Rider_Death_Dealer','damage_modifier',0.5),
('def_npc_Rough_Rider_Death_Dealer','missile_cycle_time_modifier',1.25),
('def_npc_Rough_Rider_Death_Dealer','powergrid_max_modifier',2),
('def_npc_Rough_Rider_Death_Dealer','speed_max_modifier',0.75),
('def_npc_Rough_Rider_Death_Dealer','turret_cycle_time_modifier',1.4),
('def_npc_Rough_Rider_Death_Dealer','received_repaired_modifier',0.1);


DROP TABLE IF EXISTS #PRES;
CREATE TABLE #PRES(
	presName VARCHAR(128),
	spawnId INT,	
);
INSERT INTO #PRES(presName, spawnId)VALUES
('pres_z71_grp1', @zone71SpawnId),
('pres_z71_grp2', @zone71SpawnId),
('pres_z71_grp3', @zone71SpawnId),
('pres_z71_grp4', @zone71SpawnId),

('pres_z72_grp1', @zone72SpawnId),
('pres_z72_grp2', @zone72SpawnId),
('pres_z72_grp3', @zone72SpawnId),
('pres_z72_grp4', @zone72SpawnId),
('pres_z72_grp5', @zone72SpawnId),
('pres_z72_grp6', @zone72SpawnId);

DROP TABLE IF EXISTS #FLOCKS;
CREATE TABLE #FLOCKS(
	flockName VARCHAR(128),
	presName VARCHAR(128),
	npcName VARCHAR(128),
	flockCount INT,
	x INT,
	y INT,
	sMin INT,
	sMax INT,
	respawnSeconds INT,
	homeRange INT,
);

INSERT INTO #FLOCKS (flockName, presName, npcName, flockCount, x, y, sMin, sMax, respawnSeconds, homeRange) VALUES
('RR_Light_71_GRP1', 'pres_z71_grp1', 'def_npc_RoughRider_Scout', 1, 112, 192, 1, 5, 900, 35),
('RR_Assault_71_GRP1', 'pres_z71_grp1', 'def_npc_RoughRider_Cavalry', 1, 112, 192, 1, 5, 900, 35),
('RR_Light_71_GRP2', 'pres_z71_grp2', 'def_npc_RoughRider_Scout', 1, 139, 141, 1, 5, 900, 35),
('RR_Assault_71_GRP3', 'pres_z71_grp3', 'def_npc_RoughRider_Cavalry', 1, 169, 75, 1, 5, 900, 35),
('RR_Boss_71_GRP4', 'pres_z71_grp4', 'def_npc_Zone71_WilliamHBonnie', 1, 209, 116, 1, 5, 5400, 55),
('RR_Lewar_71_GRP4', 'pres_z71_grp4', 'def_npc_Helix_BossGuard', 2, 208, 116, 1, 5, 900, 55),
('RR_Assault_71_GRP4', 'pres_z71_grp4', 'def_npc_RoughRider_Cavalry', 1, 208, 116, 1, 5, 900, 45),

('RR_Light_72_GRP1', 'pres_z72_grp1', 'def_npc_RoughRider_Scout', 1, 133, 75, 1, 5, 900, 45),
('RR_Assault_72_GRP2', 'pres_z72_grp2', 'def_npc_RoughRider_Cavalry', 1, 53, 80, 1, 5, 900, 45),
('RR_Mech_72_GRP2', 'pres_z72_grp2', 'def_npc_Rough_Rider_Death_Dealer', 1, 53, 80, 1, 5, 900, 45),
('RR_Mech_72_GRP3', 'pres_z72_grp4', 'def_npc_Rough_Rider_Death_Dealer', 1, 58, 130, 1, 5, 900, 45),
('RR_Boss_72_GRP4', 'pres_z72_grp4', 'def_npc_Zone72_One_Eye_Josef', 1, 86, 179, 1, 5, 5400, 45),
('RR_Mech_72_GRP5', 'pres_z72_grp4', 'def_npc_Rough_Rider_Death_Dealer', 1, 86, 179, 1, 5, 900, 45),
('RR_Lewar_72_GRP5', 'pres_z72_grp4', 'def_npc_Helix_BossGuard', 1, 86, 179, 1, 5, 900, 55),
('RR_Light_72_GRP5', 'pres_z72_grp5', 'def_npc_Rough_Rider_Death_Dealer', 1, 161, 95, 1, 5, 900, 45),
('IMHM_HM_72_GRP6', 'pres_z72_grp6', 'def_npc_riveler_basic_rank5', 1, 208, 180, 1, 5, 900, 45),
('RR_Lewar_72_GRP6', 'pres_z72_grp6', 'def_npc_Helix_BossGuard', 2, 208, 180, 1, 5, 900, 55),
('IHM_HM_72_GRP6', 'pres_z72_grp6', 'def_npc_scarab_basic_rank5', 1, 208, 180, 1, 5, 900, 45);

DROP TABLE IF EXISTS #BOSSINFO;
CREATE TABLE #BOSSINFO (
	flockName VARCHAR(128),
	respawnNoise FLOAT,
	aggMsg VARCHAR(128),
	deathMsg VARCHAR(128)
);

INSERT INTO #BOSSINFO (flockName, respawnNoise, aggMsg, deathMsg) VALUES
('RR_Boss_71_GRP4', 0.1, 'Alright boys, leave no witnesses. We cant have the Syndicate tracking this location!', 'You have not seen the last of the Rough Riders!'),
('RR_Boss_72_GRP4', 0.1, 'I may have one eye, but I can see you are fixin for a fight.', 'You fool! Dont you know the Syndicate is using you to ... *explodes*');


DECLARE @behaviourType AS INT = 2; --aggressive
DROP TABLE IF EXISTS #WAVES;
CREATE TABLE #WAVES (
	targetFlockName VARCHAR(100),
	presenceName VARCHAR(100),
	npcDefName VARCHAR(100),
	numInFlock INT,
	thresh FLOAT
);
INSERT INTO #WAVES (targetFlockName, presenceName, npcDefName, numInFlock, thresh) VALUES
--Stronghold 71 boss waves
('RR_Boss_71_GRP4', 'reinforce_stronghold_miniboss_a_z71_wave_0', 'def_npc_RoughRider_Scout', 1, 0.05),

('RR_Boss_71_GRP4', 'reinforce_stronghold_miniboss_a_z71_wave_1', 'def_npc_RoughRider_Scout', 1, 0.25),
('RR_Boss_71_GRP4', 'reinforce_stronghold_miniboss_a_z71_wave_1', 'def_npc_RoughRider_Cavalry', 1, 0.25),

('RR_Boss_71_GRP4', 'reinforce_stronghold_miniboss_a_z71_wave_2', 'def_npc_RoughRider_Scout', 1, 0.55),
('RR_Boss_71_GRP4', 'reinforce_stronghold_miniboss_a_z71_wave_2', 'def_npc_RoughRider_Cavalry', 1, 0.55),
('RR_Boss_71_GRP4', 'reinforce_stronghold_miniboss_a_z71_wave_2', 'def_npc_Helix_BossGuard', 1, 0.55),

('RR_Boss_71_GRP4', 'reinforce_stronghold_miniboss_a_z71_wave_3', 'def_npc_Helix_BossGuard', 2, 0.75),

--Stronghold 72 boss waves
('RR_Boss_72_GRP4', 'reinforce_stronghold_miniboss_a_z72_wave_0', 'def_npc_RoughRider_Cavalry', 1, 0.05),

('RR_Boss_72_GRP4', 'reinforce_stronghold_miniboss_a_z72_wave_1', 'def_npc_RoughRider_Cavalry', 1, 0.25),
('RR_Boss_72_GRP4', 'reinforce_stronghold_miniboss_a_z72_wave_1', 'def_npc_Helix_BossGuard', 1, 0.25),

('RR_Boss_72_GRP4', 'reinforce_stronghold_miniboss_a_z72_wave_2', 'def_npc_RoughRider_Cavalry', 1, 0.55),
('RR_Boss_72_GRP4', 'reinforce_stronghold_miniboss_a_z72_wave_2', 'def_npc_Helix_BossGuard', 2, 0.55),
('RR_Boss_72_GRP4', 'reinforce_stronghold_miniboss_a_z72_wave_2', 'def_npc_Rough_Rider_Death_Dealer', 1, 0.55),

('RR_Boss_72_GRP4', 'reinforce_stronghold_miniboss_a_z72_wave_3', 'def_npc_Helix_BossGuard', 2, 0.75),
('RR_Boss_72_GRP4', 'reinforce_stronghold_miniboss_a_z72_wave_3', 'def_npc_Rough_Rider_Death_Dealer', 2, 0.75);

PRINT N'DELETE npcflock, npcpresence, npcreinforcements IF EXISTS where data in temp table';
DELETE FROM npcflock WHERE presenceid in (SELECT id FROM npcpresence WHERE name in (SELECT DISTINCT presenceName FROM #WAVES));
DELETE FROM npcpresence WHERE name in (SELECT DISTINCT presenceName FROM #WAVES);
DELETE FROM npcreinforcements WHERE targetId in (SELECT id FROM npcflock WHERE name IN (SELECT DISTINCT targetFlockName from #WAVES));


PRINT N'DELETE npc def, templates, and all occurences';
DELETE FROM robottemplaterelation WHERE definition IN (SELECT definition FROM entitydefaults WHERE definitionname IN (SELECT defName FROM #ED));
DELETE FROM aggregatevalues WHERE definition IN (SELECT definition FROM entitydefaults WHERE definitionname IN (SELECT defName FROM #ED));
DELETE FROM robottemplates WHERE name IN (SELECT templateName FROM #ED WHERE template IS NOT NULL);
DELETE FROM npcbossinfo WHERE flockid IN (SELECT id FROM npcflock WHERE name IN (SELECT flockName FROM #BOSSINFO));
DELETE FROM npcflock WHERE name IN (SELECT flockName FROM #FLOCKS);
DELETE FROM npcpresence WHERE name IN (SELECT presName FROM #PRES);
DELETE FROM npcloot WHERE definition IN (SELECT definition FROM entitydefaults WHERE definitionname IN (SELECT defName FROM #ED));
DELETE FROM entitydefaults WHERE definitionname IN (SELECT defName FROM #ED);


PRINT N'INSERT npc def, templates, ETC';
SET IDENTITY_INSERT dbo.entitydefaults ON;
INSERT INTO entitydefaults (definition,definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel) 
SELECT def, defName, 1, 1024, 911, NULL, defName, 1, 0, 0, 0, 100, defName+'_desc', 0, 0, 0 FROM #ED;
SET IDENTITY_INSERT dbo.entitydefaults OFF;

PRINT N'DELETE ALL AGG-VALS FOR THESE NPC DEFS';
DELETE FROM aggregatevalues WHERE definition IN (
	SELECT DISTINCT definition FROM entitydefaults WHERE definitionname IN (
		SELECT DISTINCT defName FROM #NPC_MODS
	)
);

PRINT N'RE-INSERT ALL AGG-VALS FOR THESE NPC DEFS';
INSERT INTO aggregatevalues (definition, field, value)
SELECT
	(SELECT TOP 1 definition FROM entitydefaults WHERE defName=definitionname),
	(SELECT TOP 1 id FROM aggregatefields WHERE name=fieldName),
	val
FROM #NPC_MODS;

INSERT INTO dbo.robottemplates (name, description, note)
SELECT templateName, template, defName+' template' FROM #ED WHERE template IS NOT NULL;

INSERT dbo.robottemplaterelation (definition, templateid, itemscoresum, raceid, missionlevel, missionleveloverride, killep, note)
SELECT 
	def,
	(SELECT TOP 1 id FROM robottemplates WHERE name=templateName),
	0, 0, NULL, NULL, epKill, defName+'<->'+templateName
FROM #ED; 

INSERT INTO dbo.npcpresence(name,topx,topy,bottomx,bottomy,note,spawnid,enabled,roaming,roamingrespawnseconds,presencetype,maxrandomflock,randomcenterx,randomcentery,randomradius,dynamiclifetime,isbodypull,isrespawnallowed,safebodypull,izgroupid)
SELECT presName,5,5,245,245,presName,spawnId,1,0,0,0,NULL,NULL,NULL,NULL,NULL,1,1,1,NULL FROM #PRES;

INSERT INTO dbo.npcflock(name,presenceid,flockmembercount,definition,spawnoriginX,spawnoriginY,spawnrangeMin,spawnrangeMax,respawnseconds,totalspawncount,homerange,note,
respawnmultiplierlow,enabled,iscallforhelp,behaviorType,npcSpecialType)
SELECT
	flockName,
	(SELECT TOP 1 id FROM npcpresence WHERE name=presName),
	flockCount,
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=npcName),
	x, y, sMin, sMax, respawnSeconds, 0, homeRange, flockName+' of '+npcName, 
	1,1,1,2,0
FROM #FLOCKS;

PRINT N'UPDATE JUST BOSS FLOCKS TO SPECIAL TYPE';
UPDATE npcflock SET
	npcSpecialType=1
WHERE name IN (SELECT flockName FROM #BOSSINFO);

INSERT INTO dbo.npcbossinfo(flockid,respawnNoiseFactor,lootSplitFlag,outpostEID,stabilityPts,overrideRelations,customDeathMessage,customAggressMessage)
SELECT 
	(SELECT TOP 1 id FROM npcflock WHERE name=flockName),
	respawnNoise, 1, NULL, NULL, 0, deathMsg, aggMsg 
FROM #BOSSINFO;

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
	presenceName+npcDefName, (SELECT id FROM npcpresence WHERE name=presenceName), numInFlock, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=npcDefName), 0, 0, 0, 10, 0, 1, 55, presenceName+npcDefName, 0.5, 1, 1, @behaviourType, 0
FROM #WAVES;

INSERT INTO dbo.npcreinforcements
	(reinforcementType, targetId, threshold, presenceId, zoneId)
SELECT
	@reinforceType, (SELECT TOP 1 id FROM npcflock WHERE name=targetFlockName), thresh, (SELECT TOP 1 id FROM npcpresence WHERE name=presenceName), NULL
FROM #WAVES;


DROP TABLE IF EXISTS #ED;
DROP TABLE IF EXISTS #NPC_MODS;
DROP TABLE IF EXISTS #PRES;
DROP TABLE IF EXISTS #FLOCKS;
DROP TABLE IF EXISTS #BOSSINFO;
DROP TABLE IF EXISTS #WAVES;

SET NOEXEC OFF;
GO
