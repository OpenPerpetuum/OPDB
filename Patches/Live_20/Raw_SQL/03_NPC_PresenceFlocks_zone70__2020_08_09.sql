USE [perpetuumsa]
GO

--------------------------------------------------------------------------
-- Stronghold zone 70 npc layout and config
-- Date: 2021/01/17
--------------------------------------------------------------------------

DECLARE @zoneID AS INT = 70;
DECLARE @spawnID AS INT = (SELECT TOP 1 spawnid FROM zones WHERE id=@zoneID);
DECLARE @prefix AS VARCHAR(64) = 'sh' + CONVERT(VARCHAR(10), @zoneId);
DECLARE @bossRespawnTime AS INT = 548640; --6.35 days
DECLARE @baseRespawnTime AS INT = 518400; --6 days
DECLARE @respawnTime AS INT = 548640; --6.35 days as default
DECLARE @sideQuestRespawnTime AS INT = 104400; --29hrs
DECLARE @turretRespawnTime AS INT = 86400; --1 day
DECLARE @trashRespawnTime AS INT = 400; --6.67m
DECLARE @behaviourType AS INT = 2; --2=red aggressive

DROP TABLE IF EXISTS #PRESENCES;
CREATE TABLE #PRESENCES(
	presName VARCHAR(100),
);
INSERT INTO #PRESENCES (presName) VALUES
(@prefix + '_base_pres'),
(@prefix + '_north_pres'),
(@prefix + '_south_pres'),
(@prefix + '_trash_pres');

DROP TABLE IF EXISTS #FLOCKS;
CREATE TABLE #FLOCKS(
	presName VARCHAR(100),
	defName VARCHAR(100),
	numMembers INT,
	x INT,
	y INT,
	homeRange INT
);
INSERT INTO #FLOCKS (presName, defName, numMembers, x, y, homeRange) VALUES

(@prefix + '_base_pres','def_npc_sh70_mainboss',1,94,108,35),

(@prefix + '_base_pres','def_npc_pbs_base_medium_rank1',1,86,100,0),
(@prefix + '_base_pres','def_npc_pbs_control_tower_rank1',1,295,90,0),
(@prefix + '_base_pres','def_npc_pbs_control_tower_rank1',1,191,164,0),
(@prefix + '_base_pres','def_npc_pbs_e_battery_rank1',1,156,146,0),
(@prefix + '_base_pres','def_npc_pbs_e_battery_rank1',1,148,139,0),
(@prefix + '_base_pres','def_npc_pbs_e_emitter_rank1',1,179,130,0),
(@prefix + '_base_pres','def_npc_pbs_e_emitter_rank1',1,163,146,0),
(@prefix + '_base_pres','def_npc_pbs_e_emitter_rank1',1,166,115,0),
(@prefix + '_base_pres','def_npc_pbs_e_emitter_rank1',1,189,104,0),
(@prefix + '_base_pres','def_npc_pbs_e_emitter_rank1',1,119,126,0),
(@prefix + '_base_pres','def_npc_pbs_e_emitter_rank1',1,114,131,0),
(@prefix + '_base_pres','def_npc_pbs_e_emitter_rank1',1,90,191,0),
(@prefix + '_base_pres','def_npc_pbs_e_transfer_rank1',1,135,145,0),
(@prefix + '_base_pres','def_npc_pbs_e_transfer_rank1',1,133,147,0),
(@prefix + '_base_pres','def_npc_pbs_e_transfer_rank1',1,77,122,0),
(@prefix + '_base_pres','def_npc_pbs_e_transfer_rank1',1,75,120,0),
(@prefix + '_base_pres','def_npc_pbs_e_transfer_rank1',1,79,124,0),
(@prefix + '_base_pres','def_npc_pbs_e_transfer_rank1',1,128,171,0),
(@prefix + '_base_pres','def_npc_pbs_e_transfer_rank1',1,104,191,0),
(@prefix + '_base_pres','def_npc_pbs_facility_rank1',1,172,119,0),
(@prefix + '_base_pres','def_npc_pbs_facility_rank1',1,155,69,0),
(@prefix + '_base_pres','def_npc_pbs_facility_rank1',1,115,103,0),
(@prefix + '_base_pres','def_npc_pbs_facility_rank1',1,114,91,0),
(@prefix + '_base_pres','def_npc_pbs_facility_upgrade_rank1',1,107,101,0),
(@prefix + '_base_pres','def_npc_pbs_facility_upgrade_rank1',1,107,105,0),
(@prefix + '_base_pres','def_npc_pbs_facility_upgrade_rank1',1,107,109,0),
(@prefix + '_base_pres','def_npc_pbs_facility_upgrade_rank1',1,107,91,0),
(@prefix + '_base_pres','def_npc_pbs_facility_upgrade_rank1',1,107,89,0),
(@prefix + '_base_pres','def_npc_pbs_facility_upgrade_rank1',1,107,95,0),
(@prefix + '_base_pres','def_npc_pbs_reactor_rank1',1,81,114,0),
(@prefix + '_base_pres','def_npc_pbs_reactor_rank1',1,145,148,0),
(@prefix + '_base_pres','def_npc_pbs_reactor_rank1',1,109,170,0),
(@prefix + '_base_pres','def_npc_pbs_reactor_rank1',1,198,167,0),

(@prefix + '_base_pres','def_npc_pbs_turret_ew_rank1',1,24,35,0),
(@prefix + '_base_pres','def_npc_pbs_turret_missile_rank1',1,63,100,0),
(@prefix + '_base_pres','def_npc_pbs_turret_missile_rank1',1,89,74,0),
(@prefix + '_base_pres','def_npc_pbs_turret_laser_rank1',1,125,83,0),
(@prefix + '_base_pres','def_npc_pbs_turret_laser_rank1',1,72,137,0),
(@prefix + '_base_pres','def_npc_pbs_turret_em_rank1',1,132,107,0),
(@prefix + '_base_pres','def_npc_pbs_turret_em_rank1',1,96,143,0),
(@prefix + '_base_pres','def_npc_pbs_turret_laser_rank1',1,109,145,0),
(@prefix + '_base_pres','def_npc_pbs_turret_missile_rank1',1,115,139,0),
(@prefix + '_base_pres','def_npc_pbs_turret_ew_rank1',1,121,133,0),
(@prefix + '_base_pres','def_npc_pbs_turret_missile_rank1',1,127,127,0),
(@prefix + '_base_pres','def_npc_pbs_turret_laser_rank1',1,134,120,0),

(@prefix + '_base_pres','def_npc_pbs_turret_laser_rank1',1,90,205,0),
(@prefix + '_base_pres','def_npc_pbs_turret_em_rank1',1,83,212,0),
(@prefix + '_base_pres','def_npc_pbs_turret_missile_rank1',1,72,211,0),
(@prefix + '_base_pres','def_npc_pbs_turret_ew_rank1',1,63,209,0),

(@prefix + '_base_pres','def_npc_pbs_turret_laser_rank1',1,193,102,0),
(@prefix + '_base_pres','def_npc_pbs_turret_em_rank1',1,201,94,0),
(@prefix + '_base_pres','def_npc_pbs_turret_missile_rank1',1,200,84,0),
(@prefix + '_base_pres','def_npc_pbs_turret_ew_rank1',1,199,74,0),

(@prefix + '_base_pres','def_npc_pbs_turret_laser_rank1',1,141,183,0),
(@prefix + '_base_pres','def_npc_pbs_turret_em_rank1',1,116,203,0),
(@prefix + '_base_pres','def_npc_pbs_turret_missile_rank1',1,113,177,0),
(@prefix + '_base_pres','def_npc_pbs_turret_ew_rank1',1,129,196,0),

(@prefix + '_base_pres','def_npc_pbs_turret_laser_rank1',1,172,150,0),
(@prefix + '_base_pres','def_npc_pbs_turret_em_rank1',1,183,137,0),
(@prefix + '_base_pres','def_npc_pbs_turret_missile_rank1',1,178,138,0),
(@prefix + '_base_pres','def_npc_pbs_turret_ew_rank1',1,173,144,0),

(@prefix + '_base_pres','def_npc_pbs_turret_laser_rank1',1,215,172,0),
(@prefix + '_base_pres','def_npc_pbs_turret_em_rank1',1,211,176,0),
(@prefix + '_base_pres','def_npc_pbs_turret_missile_rank1',1,207,180,0),
(@prefix + '_base_pres','def_npc_pbs_turret_ew_rank1',1,203,184,0),

(@prefix + '_south_pres','def_npc_sh70_miniboss_a',1,154,347,45),
(@prefix + '_south_pres','def_npc_pbs_energy_tower_rank1',1,143,349,0),
(@prefix + '_south_pres','def_npc_artemis_guard',1,154,347,55),
(@prefix + '_south_pres','def_npc_kain_guard',1,154,347,55),
(@prefix + '_south_pres','def_npc_tyrannos_guard',1,154,347,55),
(@prefix + '_south_pres','def_npc_troiar_ewjammer_rank5',1,154,347,60),
(@prefix + '_south_pres','def_npc_intakt_ewjammer_rank5',1,154,347,60),
(@prefix + '_south_pres','def_npc_cameleon_heavyew_rank5',1,154,347,60),
(@prefix + '_south_pres','def_npc_prometheus_interceptor_rank5',2,154,347,60),
(@prefix + '_south_pres','def_npc_yagel_interceptor_rank5',2,154,347,60),
(@prefix + '_south_pres','def_npc_castel_interceptor_rank5',2,154,347,60),

(@prefix + '_north_pres','def_npc_sh70_miniboss_b',1,428,120,45),
(@prefix + '_north_pres','def_npc_pbs_miner_tower_rank1',1,428,112,0),
(@prefix + '_north_pres','def_npc_pbs_reactor_rank1',1,390,59,0),
(@prefix + '_north_pres','def_npc_fivepercent_argano',3,428,120,50),
(@prefix + '_north_pres','def_npc_fivepercent_Laird',3,428,120,50),
(@prefix + '_north_pres','def_npc_riveler_basic_rank5',3,428,120,50),
(@prefix + '_north_pres','def_npc_symbiont_basic_rank5',3,428,120,50),
(@prefix + '_north_pres','def_npc_troiar_ewjammer_rank5',1,428,120,50),
(@prefix + '_north_pres','def_npc_intakt_ewjammer_rank5',1,428,120,50),
(@prefix + '_north_pres','def_npc_cameleon_heavyew_rank5',1,428,120,50),
(@prefix + '_north_pres','def_npc_prometheus_interceptor_rank5',2,428,120,50),
(@prefix + '_north_pres','def_npc_yagel_interceptor_rank5',2,428,120,50),
(@prefix + '_north_pres','def_npc_castel_interceptor_rank5',2,428,120,50),
(@prefix + '_north_pres','def_npc_gropho_guard',1,428,120,50),
(@prefix + '_north_pres','def_npc_seth_guard',1,428,120,50),
(@prefix + '_north_pres','def_npc_mesmer_guard',1,428,120,50),

(@prefix + '_trash_pres','def_npc_prometheus_interceptor_rank5',2,100,105,90),
(@prefix + '_trash_pres','def_npc_yagel_interceptor_rank5',2,105,105,90),
(@prefix + '_trash_pres','def_npc_castel_interceptor_rank5',2,105,100,90),

(@prefix + '_trash_pres','def_npc_prometheus_interceptor_rank5',2,300,95,55),
(@prefix + '_trash_pres','def_npc_yagel_interceptor_rank5',2,295,100,55),
(@prefix + '_trash_pres','def_npc_castel_interceptor_rank5',2,300,100,55),

(@prefix + '_trash_pres','def_npc_tyrannos_dps_rank3',1,230,155,75),
(@prefix + '_trash_pres','def_npc_baphomet_dps_rank4',1,230,155,75),
(@prefix + '_trash_pres','def_npc_yagel_dps_rank5',2,230,155,75),

(@prefix + '_trash_pres','def_npc_kain_dps_rank3',1,267,88,75),
(@prefix + '_trash_pres','def_npc_waspish_dps_rank4',1,267,88,75),
(@prefix + '_trash_pres','def_npc_prometheus_dps_rank5',2,267,88,75),

(@prefix + '_trash_pres','def_npc_artemis_dps_rank3',1,108,246,75),
(@prefix + '_trash_pres','def_npc_arbalest_dps_rank4',1,108,246,75),
(@prefix + '_trash_pres','def_npc_castel_dps_rank5',2,108,246,75);


PRINT N'CLEARING NPC SPAWN (0 if 1st run)';
--Clear and reinsert all
DELETE FROM npcflock WHERE presenceid in (SELECT id FROM npcpresence WHERE spawnid=@spawnID);
DELETE FROM npcpresence WHERE spawnid=@spawnID;
PRINT N'INSERTING PRESENCES';
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
	,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
	SELECT presName,6,6,500,500,'STRONGHOLD BASE 01 PRES',@spawnID,1,0,0,0,0,0,0,0,0,1,1,1 FROM #PRESENCES;

PRINT N'INSERTING FLOCKS';
INSERT INTO [dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
	,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType])
SELECT 
	f.defName+'_'+CAST(f.x as varchar)+'_'+CAST(f.y as varchar)+'_z'+CAST(@zoneID as varchar), 
	(SELECT TOP 1 id FROM npcpresence WHERE name=presName),
	f.numMembers, 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=f.defName), 
	f.x, f.y, 0, 1, @respawnTime, 0, f.homeRange, 'STRONGHOLD BASE 01 FLOCKS', 1, 1, 1, @behaviourType
FROM #FLOCKS as f;


PRINT N'UPDATING FLOCKS W/ SPECIAL PARAMETERS';
--SPECIAL FLOCK EXCEPTIONS
PRINT N'UPDATING TRASH FLOCKS WITH FASTER RESPAWN';
UPDATE npcflock SET
	respawnseconds=@trashRespawnTime
WHERE presenceid=(SELECT TOP 1 id FROM npcpresence WHERE name=@prefix + '_trash_pres');

UPDATE npcflock SET
	respawnseconds=@sideQuestRespawnTime
WHERE presenceid=(SELECT TOP 1 id FROM npcpresence WHERE name=@prefix + '_north_pres');

UPDATE npcflock SET
	respawnseconds=@sideQuestRespawnTime
WHERE presenceid=(SELECT TOP 1 id FROM npcpresence WHERE name=@prefix + '_south_pres');

UPDATE npcflock SET
	respawnseconds=@baseRespawnTime
WHERE presenceid=(SELECT TOP 1 id FROM npcpresence WHERE name=@prefix + '_base_pres');

UPDATE npcflock SET
	respawnseconds=@turretRespawnTime
WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname IN
	('def_npc_pbs_turret_laser_rank1', 'def_npc_pbs_turret_em_rank1', 'def_npc_pbs_turret_missile_rank1', 'def_npc_pbs_turret_ew_rank1')) 
AND presenceid=(SELECT TOP 1 id FROM npcpresence WHERE name=@prefix + '_base_pres');

PRINT N'UPDATING BASE FLOCKS AS BOSS TYPE';
UPDATE npcflock SET
	npcSpecialType=1
WHERE id in (SELECT id FROM npcflock WHERE presenceid in (SELECT id FROM npcpresence WHERE name=@prefix + '_base_pres'));

PRINT N'DELETING BOSSINFO FOR BASE PRESENCE FLOCKS (0 if 1st run)';
DELETE FROM npcbossinfo WHERE flockid in (SELECT id FROM npcflock WHERE presenceid in (SELECT id FROM npcpresence WHERE name=@prefix + '_base_pres'));
PRINT N'RE-INSERTING BOSSINFO FOR BASE PRESENCE FLOCKS';
INSERT INTO npcbossinfo (flockid, respawnNoiseFactor, lootSplitFlag, outpostEID, stabilityPts, overrideRelations, customDeathMessage, customAggressMessage) 
SELECT id, 0.05, 1, NULL, NULL, 0, NULL, NULL FROM npcflock WHERE presenceid in (SELECT id FROM npcpresence WHERE name=@prefix + '_base_pres');


PRINT N'UPDATING main boss flock';

DECLARE @bossDefName AS VARCHAR(128) = 'def_npc_sh70_mainboss';
DECLARE @bossDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@bossDefName);
DECLARE @bossFlockId AS INT = (SELECT TOP 1 id FROM npcflock WHERE definition = @bossDef);

UPDATE npcflock SET
	npcSpecialType=1,
	respawnseconds=@bossRespawnTime
WHERE id=@bossFlockId;
PRINT N'INSERT/UPDATE NPCBOSSINFO FOR main boss flock';
IF NOT EXISTS (SELECT TOP 1 id FROM npcbossinfo WHERE flockid=@bossFlockId)
BEGIN
	INSERT INTO npcbossinfo (flockid, respawnNoiseFactor, lootSplitFlag, outpostEID, stabilityPts, overrideRelations, customDeathMessage, customAggressMessage) VALUES
	(@bossFlockId, 0.15, 1, NULL, NULL, 0, 'We will return, human.  Your time on our world will end soon.', NULL);
END
ELSE
BEGIN
	UPDATE npcbossinfo SET
		respawnNoiseFactor = 0.15,
		lootSplitFlag = 1,
		customAggressMessage = NULL,
		customDeathMessage = 'We will return, human.  Your time on our world will end soon.'
	WHERE flockid = @bossFlockId;
END

SET @bossDefName = 'def_npc_sh70_miniboss_a';
SET @bossDef = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@bossDefName);
SET @bossFlockId = (SELECT TOP 1 id FROM npcflock WHERE definition = @bossDef);

UPDATE npcflock SET
	npcSpecialType=1
WHERE id=@bossFlockId;
PRINT N'INSERT/UPDATE NPCBOSSINFO FOR MINI boss A flock';
IF NOT EXISTS (SELECT TOP 1 id FROM npcbossinfo WHERE flockid=@bossFlockId)
BEGIN
	INSERT INTO npcbossinfo (flockid, respawnNoiseFactor, lootSplitFlag, outpostEID, stabilityPts, overrideRelations, customDeathMessage, customAggressMessage) VALUES
	(@bossFlockId, 0.05, 1, NULL, NULL, 0, 'Vile human, you know little of this world and our attunement to its energies - your efforts will be in vain!', 'HUMAN, your exploitation of our world''s energy ends NOW!');
END
ELSE
BEGIN
	UPDATE npcbossinfo SET
		respawnNoiseFactor = 0.05,
		lootSplitFlag = 1,
		customAggressMessage = 'HUMAN, your exploitation of our world''s energy ends NOW!',
		customDeathMessage = 'Vile human, you know little of this world and our attunement to its energies - your efforts will be in vain!'
	WHERE flockid = @bossFlockId;
END

SET @bossDefName = 'def_npc_sh70_miniboss_b';
SET @bossDef = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@bossDefName);
SET @bossFlockId = (SELECT TOP 1 id FROM npcflock WHERE definition = @bossDef);

UPDATE npcflock SET
	npcSpecialType=1
WHERE id=@bossFlockId;
PRINT N'INSERT/UPDATE NPCBOSSINFO FOR MINI boss B flock';
IF NOT EXISTS (SELECT TOP 1 id FROM npcbossinfo WHERE flockid=@bossFlockId)
BEGIN
	INSERT INTO npcbossinfo (flockid, respawnNoiseFactor, lootSplitFlag, outpostEID, stabilityPts, overrideRelations, customDeathMessage, customAggressMessage) VALUES
	(@bossFlockId, 0.05, 1, NULL, NULL, 0, 'The Commandant will see to it that you and your kind will leave this world - forever!', 'Back to mining little ones, I will deal with these intruders..');
END
ELSE
BEGIN
	UPDATE npcbossinfo SET
		respawnNoiseFactor = 0.05,
		lootSplitFlag = 1,
		customAggressMessage = 'Back to mining little ones, I will deal with these intruders..',
		customDeathMessage = 'The Commandant will see to it that you and your kind will leave this world - forever!'
	WHERE flockid = @bossFlockId;
END


DECLARE @reinforceType AS INT = (SELECT TOP 1 id FROM npcreinforcementtypes WHERE name='boss');
DECLARE @bossFlockName AS VARCHAR(100) = (SELECT TOP 1 name FROM npcflock WHERE definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_sh70_mainboss'));
DECLARE @minibossAFlockName AS VARCHAR(100) = (SELECT TOP 1 name FROM npcflock WHERE definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_sh70_miniboss_a'));
DECLARE @minibossBFlockName AS VARCHAR(100) = (SELECT TOP 1 name FROM npcflock WHERE definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_sh70_miniboss_b'));

DROP TABLE IF EXISTS #WAVES;
CREATE TABLE #WAVES (
	targetFlockName VARCHAR(100),
	presenceName VARCHAR(100),
	npcDefName VARCHAR(100),
	numInFlock INT,
	thresh FLOAT
);
INSERT INTO #WAVES (targetFlockName, presenceName, npcDefName, numInFlock, thresh) VALUES
--Stronghold  mini boss A waves
(@minibossAFlockName, 'reinforce_stronghold_miniboss_a_z70_wave_0', 'def_npc_percent_arty_rank3', 1, 0.05),
(@minibossAFlockName, 'reinforce_stronghold_miniboss_a_z70_wave_0', 'def_npc_percent_tyro_rank3', 1, 0.05),
(@minibossAFlockName, 'reinforce_stronghold_miniboss_a_z70_wave_0', 'def_npc_percent_kain_rank3', 1, 0.05),

(@minibossAFlockName, 'reinforce_stronghold_miniboss_a_z70_wave_1', 'def_npc_percent_arty_rank3', 1, 0.55),
(@minibossAFlockName, 'reinforce_stronghold_miniboss_a_z70_wave_1', 'def_npc_percent_tyro_rank3', 1, 0.55),
(@minibossAFlockName, 'reinforce_stronghold_miniboss_a_z70_wave_1', 'def_npc_percent_kain_rank3', 1, 0.55),
(@minibossAFlockName, 'reinforce_stronghold_miniboss_a_z70_wave_1', 'def_npc_troiar_ewjammer_rank5', 1, 0.55),
(@minibossAFlockName, 'reinforce_stronghold_miniboss_a_z70_wave_1', 'def_npc_intakt_ewjammer_rank5', 1, 0.55),
(@minibossAFlockName, 'reinforce_stronghold_miniboss_a_z70_wave_1', 'def_npc_cameleon_heavyew_rank5', 1, 0.55),

--mini boss B
(@minibossBFlockName, 'reinforce_stronghold_miniboss_b_z70_wave_0', 'def_npc_troiar_ewjammer_rank5', 1, 0.05),
(@minibossBFlockName, 'reinforce_stronghold_miniboss_b_z70_wave_0', 'def_npc_intakt_ewjammer_rank5', 1, 0.05),
(@minibossBFlockName, 'reinforce_stronghold_miniboss_b_z70_wave_0', 'def_npc_cameleon_heavyew_rank5', 1, 0.05),

(@minibossBFlockName, 'reinforce_stronghold_miniboss_b_z70_wave_1', 'def_npc_troiar_ewjammer_rank5', 1, 0.55),
(@minibossBFlockName, 'reinforce_stronghold_miniboss_b_z70_wave_1', 'def_npc_intakt_ewjammer_rank5', 1, 0.55),
(@minibossBFlockName, 'reinforce_stronghold_miniboss_b_z70_wave_1', 'def_npc_cameleon_heavyew_rank5', 1, 0.55),
(@minibossBFlockName, 'reinforce_stronghold_miniboss_b_z70_wave_1', 'def_npc_percent_arty_rank3', 1, 0.55),
(@minibossBFlockName, 'reinforce_stronghold_miniboss_b_z70_wave_1', 'def_npc_percent_tyro_rank3', 1, 0.55),
(@minibossBFlockName, 'reinforce_stronghold_miniboss_b_z70_wave_1', 'def_npc_percent_kain_rank3', 1, 0.55),

--Stronghold boss waves
(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_0', 'def_npc_tenpercent_castel_rank2', 1, 0.05),
(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_0', 'def_npc_percent_wasp_rank4', 1, 0.05),
(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_0', 'def_npc_percent_tyro_rank5', 1, 0.05),

(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_1', 'def_npc_tenpercent_yagel_rank2', 1, 0.15),
(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_1', 'def_npc_percent_arby_rank4', 1, 0.15),
(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_1', 'def_npc_percent_kain_rank5', 1, 0.15),

(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_2', 'def_npc_tenpercent_prom_rank2', 1, 0.25),
(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_2', 'def_npc_percent_baph_rank4', 1, 0.25),
(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_2', 'def_npc_percent_arty_rank5', 1, 0.25),

(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_3', 'def_npc_troiar_ewjammer_rank5', 1, 0.35),
(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_3', 'def_npc_percent_gropho_rank4', 1, 0.35),
(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_3', 'def_npc_percent_wasp_rank4', 1, 0.35),
(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_3', 'def_npc_percent_tyro_rank5', 1, 0.35),

(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_4', 'def_npc_cameleon_heavyew_rank5', 1, 0.45),
(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_4', 'def_npc_percent_mesmer_rank4', 1, 0.45),
(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_4', 'def_npc_percent_arby_rank4', 1, 0.45),
(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_4', 'def_npc_percent_kain_rank5', 1, 0.45),

(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_5', 'def_npc_intakt_ewjammer_rank5', 1, 0.55),
(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_5', 'def_npc_percent_seth_rank4', 1, 0.55),
(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_5', 'def_npc_percent_baph_rank4', 1, 0.55),
(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_5', 'def_npc_percent_arty_rank5', 1, 0.55),

(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_6', 'def_npc_troiar_ewjammer_rank5', 1, 0.65),
(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_6', 'def_npc_cameleon_heavyew_rank5', 1, 0.65),
(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_6', 'def_npc_intakt_ewjammer_rank5', 1, 0.65),
(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_6', 'def_npc_percent_gropho_rank4', 1, 0.65),
(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_6', 'def_npc_percent_wasp_rank4', 1, 0.65),
(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_6', 'def_npc_percent_mesmer_rank4', 1, 0.65),
(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_6', 'def_npc_percent_arby_rank4', 1, 0.65),
(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_6', 'def_npc_percent_seth_rank4', 1, 0.65),
(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_6', 'def_npc_percent_baph_rank4', 1, 0.65),

(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_7', 'def_npc_troiar_ewjammer_rank5', 2, 0.80),
(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_7', 'def_npc_cameleon_heavyew_rank5', 2, 0.80),
(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_7', 'def_npc_intakt_ewjammer_rank5', 2, 0.80),
(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_7', 'def_npc_percent_gropho_rank5', 1, 0.80),
(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_7', 'def_npc_percent_wasp_rank4', 1, 0.80),
(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_7', 'def_npc_percent_tyro_rank5', 1, 0.80),
(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_7', 'def_npc_percent_mesmer_rank5', 1, 0.80),
(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_7', 'def_npc_percent_arby_rank4', 1, 0.80),
(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_7', 'def_npc_percent_kain_rank5', 1, 0.80),
(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_7', 'def_npc_percent_seth_rank5', 1, 0.80),
(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_7', 'def_npc_percent_baph_rank4', 1, 0.80),
(@bossFlockName, 'reinforce_stronghold_boss_z70_wave_7', 'def_npc_percent_arty_rank5', 1, 0.80);

PRINT N'DELETE npcflock, npcpresence, npcreinforcements IF EXISTS where data in temp table';
DELETE FROM npcflock WHERE presenceid in (SELECT id FROM npcpresence WHERE name in (SELECT DISTINCT presenceName FROM #WAVES));
DELETE FROM npcpresence WHERE name in (SELECT DISTINCT presenceName FROM #WAVES);
DELETE FROM npcreinforcements WHERE targetId in (SELECT id FROM npcflock WHERE name IN (SELECT DISTINCT targetFlockName from #WAVES));

PRINT N'INSERT npcflock, npcpresence, npcreinforcements FROM temp table';
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


DROP TABLE IF EXISTS #FLOCKS;
DROP TABLE IF EXISTS #PRESENCES;
DROP TABLE IF EXISTS #WAVES;
GO