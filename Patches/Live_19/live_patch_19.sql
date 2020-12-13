USE [perpetuumsa]
GO
PRINT N'Applying Patch 19';
---------------------------------------------------------
-- Patch 19
-- Aggvalues_fix_seth_t2nexus__2020_10_27
-- Aggvalues_update_MegLRMAgs__2020_12_03
-- Effects_environmental__2020_11_29
-- EntityDef_Insert_RallyTerm__2020_11_18
-- Npcbossinfo_update_customMsgs__2020_11_27
-- Npcreinforcements_update_fluxoreThresh__2020_11_28
-- Npcreinforcements_insert_bossreinforce__2020_11_27
-- Syndicate_rebalance__newammo__2020_08_30
-- Zone_16_invalid_entities__2020_09_16
---------------------------------------------------------


PRINT N'Aggvalues_fix_seth_t2nexus__2020_10_27';
USE [perpetuumsa]
GO

--------------------------------------------------
-- Seth srf areas were off 23->25
-- T2 Shield nexus module missing range field (server defaults to 100, set here just in case)
-- Date: 2020/10/27
--------------------------------------------------

DROP TABLE IF EXISTS #MODIFIERS;
CREATE TABLE #MODIFIERS 
(
	defName varchar(100),
	fieldName varchar(100),
	fieldValue float,
);

INSERT INTO #MODIFIERS (defName, fieldName, fieldValue) VALUES
('def_seth_chassis', 'signature_radius', 25),
('def_seth_chassis_mk2', 'signature_radius', 25),
('def_seth_chassis_pr', 'signature_radius', 25),
('def_seth_chassis_reward1', 'signature_radius', 25),

('def_named1_gang_assist_shield_calculation_module', 'default_effect_range', 100);

PRINT N'MERGE SRF AREA UPDATES TO AGGREGATE VALUES FOR Seth and T2 shield nexus';

MERGE INTO
  aggregatevalues
USING
  #MODIFIERS
ON
  field = (SELECT TOP 1 id FROM aggregatefields WHERE fieldName=name)
  AND
  definition = (SELECT TOP 1 definition FROM entitydefaults WHERE defName=definitionname)
WHEN MATCHED THEN
  UPDATE SET
    value = fieldValue
WHEN NOT MATCHED THEN
  INSERT
    (definition, field, value)
  VALUES
    ((SELECT TOP 1 definition FROM entitydefaults WHERE defName=definitionname), (SELECT TOP 1 id FROM aggregatefields WHERE fieldName=name), fieldValue);


PRINT N'MERGED!';
DROP TABLE IF EXISTS #MODIFIERS;
GO



USE [perpetuumsa]
GO

----------------------------------------
-- Shield radius field, increase display units 0->1
--
-- Date modified: 2020/10/27
----------------------------------------


UPDATE aggregatefields SET 
	digits=1
WHERE name='shield_radius';

GO




PRINT N'Aggvalues_update_MegLRMAgs__2020_12_03';
USE [perpetuumsa]
GO

------------------------------------------------------------
-- LR Med Magnetic weapon Accum and some fitting tweaks
--
-- Date Modified: 2020/12/03
------------------------------------------------------------

DROP TABLE IF EXISTS #STATS;
CREATE TABLE #STATS(
	defName VARCHAR(100),
	fieldName VARCHAR(100),
	fieldValue float
);

INSERT INTO #STATS (defName, fieldName, fieldValue) VALUES
('def_artifact_damaged_longrange_medium_railgun','core_usage',22),
('def_artifact_damaged_longrange_medium_railgun','cpu_usage',40),
('def_artifact_damaged_longrange_medium_railgun','powergrid_usage',185),

('def_artifact_a_longrange_medium_railgun','core_usage',25),
('def_artifact_a_longrange_medium_railgun','cpu_usage',45),
('def_artifact_a_longrange_medium_railgun','powergrid_usage',205),

('def_longrange_standard_medium_railgun','core_usage',22),
('def_longrange_standard_medium_railgun','cpu_usage',40),
('def_longrange_standard_medium_railgun','powergrid_usage',185),

('def_named1_longrange_medium_railgun','core_usage',20),
('def_named1_longrange_medium_railgun','cpu_usage',36),
('def_named1_longrange_medium_railgun','powergrid_usage',170),

('def_named1_longrange_medium_railgun_pr','core_usage',20),
('def_named1_longrange_medium_railgun_pr','cpu_usage',34),
('def_named1_longrange_medium_railgun_pr','powergrid_usage',163),

('def_named2_longrange_medium_railgun','core_usage',25),
('def_named2_longrange_medium_railgun','cpu_usage',43),
('def_named2_longrange_medium_railgun','powergrid_usage',185),

('def_named2_longrange_medium_railgun_pr','core_usage',25),
('def_named2_longrange_medium_railgun_pr','cpu_usage',38),
('def_named2_longrange_medium_railgun_pr','powergrid_usage',176),

('def_named3_longrange_medium_railgun','core_usage',29),
('def_named3_longrange_medium_railgun','cpu_usage',45),
('def_named3_longrange_medium_railgun','powergrid_usage',200),

('def_named3_longrange_medium_railgun_pr','core_usage',29),
('def_named3_longrange_medium_railgun_pr','cpu_usage',43),
('def_named3_longrange_medium_railgun_pr','powergrid_usage',190);



PRINT N'INSERT/UPDATE aggregatevalues FOR MAGNETIC WEAPONS, MED, LR';
MERGE aggregatevalues v USING #STATS s
ON v.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=s.defName) AND
v.field = (SELECT TOP 1 id FROM aggregatefields WHERE name=s.fieldName)
WHEN MATCHED
    THEN UPDATE SET
		v.value = s.fieldValue;

DROP TABLE IF EXISTS #STATS;
GO



PRINT N'Effects_environmental__2020_11_29';
USE [perpetuumsa]
GO

PRINT N'ADDING ENVIRONMENTAL EFFECTS';

-----------------------------------------------------
-- Insert new effects, effcat, and modifiers
-- Note: hard-coded values must match enums in server!
-- Date Modified: 11/29/2020
-----------------------------------------------------

DROP TABLE IF EXISTS #EFFS;
CREATE TABLE #EFFS 
(
	effId INT,
	effName VARCHAR(100)
);

DROP TABLE IF EXISTS #EFFECTMODS;
CREATE TABLE #EFFECTMODS 
(
	effId INT,
	fieldName VARCHAR(100),
	fieldValue FLOAT
);

DECLARE @effectCatName AS VARCHAR(100) = 'effcat_environmental_effects';
DECLARE @effectDayName  AS VARCHAR(100) = 'effect_day';
DECLARE @effectDayClearName  AS VARCHAR(100) = 'effect_day_clear';
DECLARE @effectDayOvercastName  AS VARCHAR(100) = 'effect_day_overcast';
DECLARE @effectNightName  AS VARCHAR(100) = 'effect_night';
DECLARE @effectNightClearName  AS VARCHAR(100) = 'effect_night_clear';
DECLARE @effectNightOvercastName  AS VARCHAR(100) = 'effect_night_overcast';
DECLARE @effectGoodWeatherName  AS VARCHAR(100) = 'effect_weather_good';
DECLARE @effectBadWeatherName  AS VARCHAR(100) = 'effect_weather_bad';

DECLARE @effectDayId AS INT = 107;
DECLARE @effectDayClearId AS INT = 108;
DECLARE @effectDayOvercastId  AS INT = 109;
DECLARE @effectNightId  AS INT = 110;
DECLARE @effectNightClearId  AS INT = 111;
DECLARE @effectNightOvercastId  AS INT = 112;
DECLARE @effectGoodWeatherId  AS INT = 113;
DECLARE @effectBadWeatherId  AS INT = 114;

DECLARE @effCatPower AS INT = 45;

INSERT INTO #EFFECTMODS (effId, fieldName, fieldValue) VALUES
(@effectDayId, 'effect_stealth_strength_modifier', -2),
(@effectNightId, 'effect_stealth_strength_modifier', 2),

(@effectGoodWeatherId, 'effect_detection_strength_modifier', 2),
(@effectBadWeatherId, 'effect_detection_strength_modifier', -2),

(@effectDayClearId, 'effect_detection_strength_modifier', 2),
(@effectDayClearId, 'effect_stealth_strength_modifier', -2),
(@effectDayOvercastId, 'effect_detection_strength_modifier', -2),
(@effectDayOvercastId, 'effect_stealth_strength_modifier', -2),

(@effectNightClearId, 'effect_detection_strength_modifier', 2),
(@effectNightClearId, 'effect_stealth_strength_modifier', 2),
(@effectNightOvercastId, 'effect_detection_strength_modifier', -2),
(@effectNightOvercastId, 'effect_stealth_strength_modifier', 2);

INSERT INTO #EFFS (effId, effName) VALUES
(@effectDayId, @effectDayName),
(@effectDayClearId, @effectDayClearName),
(@effectDayOvercastId, @effectDayOvercastName),
(@effectNightId, @effectNightName),
(@effectNightClearId, @effectNightClearName),
(@effectNightOvercastId, @effectNightOvercastName),
(@effectGoodWeatherId, @effectGoodWeatherName),
(@effectBadWeatherId, @effectBadWeatherName);

DELETE FROM effectdefaultmodifiers WHERE effectid IN (SELECT effId FROM #EFFS);
DELETE FROM effects WHERE id IN (SELECT effId FROM #EFFS);
DELETE FROM effectcategories WHERE flag>=@effCatPower;

INSERT INTO effectcategories (name, flag, maxlevel, note) VALUES
(@effectCatName, @effCatPower, 1, 'dynamic zone environmental effects');

DECLARE @catFlag BIGINT;
SET @catFlag = POWER(CAST(2 AS BIGINT), (SELECT TOP 1 CAST(flag AS BIGINT) FROM effectcategories WHERE name=@effectCatName));

SET IDENTITY_INSERT effects ON;

INSERT INTO effects (id, effectcategory, duration, name, description, note, isaura, auraradius, ispositive, display, saveable)
SELECT effId, @catFlag, 0, effName, effName+'_desc', 'environ effects', 1, 0, 1, 1, 0
FROM #EFFS;

SET IDENTITY_INSERT effects OFF;

INSERT INTO effectdefaultmodifiers (effectid, field, value)
SELECT effId, (SELECT TOP 1 id FROM aggregatefields WHERE name=fieldName), fieldValue
FROM #EFFECTMODS;


DROP TABLE IF EXISTS #EFFECTMODS;
DROP TABLE IF EXISTS #EFFS;
GO





PRINT N'EntityDef_Insert_RallyTerm__2020_11_18';
USE [perpetuumsa]
GO

----------------------------------
-- "Rally" Field Terminal
-- Inserts new definition
--
-- Date Modified: 2020/11/18
----------------------------------

DECLARE @def AS INT = 5930;
DECLARE @defName AS VARCHAR(100) = 'def_field_terminal_rally';


-- Add new EntityDefault for a "rally" terminal that doesn't give assignments
PRINT N'ADD RALLY FIELD TERM DEFINITION';
IF NOT EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = @defName)
BEGIN
	SET IDENTITY_INSERT [dbo].[entitydefaults] ON;
	INSERT INTO [dbo].[entitydefaults]
			   ([definition],[definitionname],[quantity],[attributeflags],[categoryflags],[options],[note],[enabled],[volume],[mass],[hidden],[health],[descriptiontoken],[purchasable],[tiertype],[tierlevel])
		 VALUES
			   (@def,@defName,1,943719424,131448,'','Field term w/o missions',1,0,0,0,100,@defName+'_desc',0,null,null);
	SET IDENTITY_INSERT [dbo].[entitydefaults] OFF;
END
ELSE
BEGIN
	UPDATE [dbo].[entitydefaults] SET
		attributeflags = 943719424,
		categoryflags = 131448,
		options = '',
		note = 'Field term w/o missions',
		enabled =1,
		volume = 0,
		mass = 0,
		hidden = 0,
		health = 100,
		descriptiontoken = @defName+'_desc',
		purchasable = 0,
		tierlevel = null,
		tiertype = null
	WHERE definitionname=@defName;
END
GO





PRINT N'Npcbossinfo_update_customMsgs__2020_11_27';
USE [perpetuumsa]
GO

------------------------------------------
-- Npcbossinfo chat messages
-- Clean up excess chatter, give others more character
-- Date modified: 2020/11/27
------------------------------------------

PRINT N'UPDATE npcbossinfo: customDeathMessage/customAggressMessage';

UPDATE npcbossinfo SET 
	customDeathMessage=NULL,
	customAggressMessage=NULL
WHERE flockid IN (SELECT id FROM npcflock WHERE name IN (
	'kain_protector_stronghold1',
	'cameleon_with_numiquol_protector',
	'arbalest_with_numiquol_protector',
	'artemis_protector_stronghold1',
	'intakt_by_protector',
	'baphomet_by_protector',
	'tyrannos_protector',
	'waspish_with_protector',
	'troiar_with_protector',
	'intakt_stronghold_trash',
	'cam_stronghold_trash',
	'troiar_stronghold_trash',
	'Baph_stronghold_trash',
	'Arbalest_stronghold_trash',
	'Waspish_stronghold_trash',
	'Rough_Rider_Leader',
	'Rough_rider_Scout1',
	'Rough_rider_scout2',
	'def_npc_Malfunctioning_Arkhe',
	'def_npc_Imperial_Infantry',
	'def_npc_Tribal_Member',
	'def_npc_Sacrist_Convert',
	'hersh_yellow_boss',
	'Blue_Hersh_mech_boss',
	'hersh_GreenBoss',
	'Hersh_RR_1',
	'Hersh_Pit_Boss'));

UPDATE npcbossinfo SET 
	customDeathMessage='bzzt.. uploading research exfiltration packets... fizzbuzz.. zorp..',
	customAggressMessage='zzzzrt.. aggressionN0 routines... ENGAGED'
WHERE flockid IN (SELECT id FROM npcflock WHERE name IN ('def_npc_Malfunctioning_Arkhe'));


UPDATE npcbossinfo SET 
	customAggressMessage='Oh? You''re Approaching Me?'
WHERE flockid IN (SELECT id FROM npcflock WHERE name IN (
	'Rough_Rider_Leader',
	'def_npc_Imperial_Infantry',
	'def_npc_Tribal_Member',
	'def_npc_Sacrist_Convert',
	'hersh_yellow_boss',
	'Blue_Hersh_mech_boss',
	'hersh_GreenBoss',
	'Hersh_RR_1',
	'Hersh_Pit_Boss'));

UPDATE npcbossinfo SET 
	customDeathMessage='The Syndicate will fall! We will see to it... Until next time Agent.'
WHERE flockid IN (SELECT id FROM npcflock WHERE name IN (
	'Rough_Rider_Leader',
	'Hersh_RR_1'));

UPDATE npcbossinfo SET 
	customDeathMessage='This will not be our last encounter human!'
WHERE flockid IN (SELECT id FROM npcflock WHERE name IN (
	'def_npc_Imperial_Infantry',
	'def_npc_Tribal_Member',
	'def_npc_Sacrist_Convert',
	'hersh_yellow_boss',
	'Blue_Hersh_mech_boss',
	'hersh_GreenBoss'));

UPDATE npcbossinfo SET 
	customDeathMessage='Thank you human, my consciousness once trapped in this abomination is now free to end this viral slavery! For Nia!'
WHERE flockid IN (SELECT id FROM npcflock WHERE name IN (
	'Hersh_Pit_Boss'));

UPDATE npcbossinfo SET 
	customDeathMessage='Impossible! Humans too self-serving to operate as collective as we. Perhaps we revise our strategies...',
	customAggressMessage='Human! I thought I could smell your viral controls on my brother. Let me free him from your digital shackles!'
WHERE flockid IN (SELECT id FROM npcflock WHERE name IN (
	'Norhoop_Pitboss_flock_boss',
	'Hokkogaros_Pitboss_flock_boss',
	'Domhalarn_Pitboss_flock_boss'));

PRINT N'DONE UPDATE npcbossinfo: customDeathMessage/customAggressMessage';
GO





PRINT N'Npcreinforcements_update_fluxoreThresh__2020_11_28';
USE [perpetuumsa]
GO
------------------------------------
-- Npcreinforcements
-- Threshold adjustments to accomodate corrected algorithm
-- Date modified: 2020/11/28
------------------------------------
PRINT N'UPDATING npcreinforcements thresholds for fluxore spawns';
DECLARE @fluxOre AS INT = (SELECT TOP 1 idx FROM minerals WHERE name = 'fluxore');

DECLARE @reinforceType AS INT = (SELECT TOP 1 id FROM npcreinforcementtypes WHERE name='minerals');

UPDATE npcreinforcements SET 
	threshold=0.01
WHERE 
presenceId IN (SELECT TOP 1 id FROM npcpresence WHERE name in ('flux_ore_npc_wave_0')) AND
targetId=@fluxOre AND reinforcementType=@reinforceType;

UPDATE npcreinforcements SET 
	threshold=0.1
WHERE 
presenceId IN (SELECT id FROM npcpresence WHERE name IN 
('flux_ore_npc_wave_1_pelistal', 'flux_ore_npc_wave_1_thelodica', 'flux_ore_npc_wave_1_nuimqol')) AND
targetId=@fluxOre AND reinforcementType=@reinforceType;

UPDATE npcreinforcements SET 
	threshold=0.2
WHERE 
presenceId IN (SELECT id FROM npcpresence WHERE name IN 
('flux_ore_npc_wave_2_pelistal', 'flux_ore_npc_wave_2_thelodica', 'flux_ore_npc_wave_2_nuimqol')) AND
targetId=@fluxOre AND reinforcementType=@reinforceType;

UPDATE npcreinforcements SET 
	threshold=0.3
WHERE 
presenceId IN (SELECT id FROM npcpresence WHERE name IN 
('flux_ore_npc_wave_3_pelistal', 'flux_ore_npc_wave_3_thelodica', 'flux_ore_npc_wave_3_nuimqol')) AND
targetId=@fluxOre AND reinforcementType=@reinforceType;

UPDATE npcreinforcements SET 
	threshold=0.4
WHERE 
presenceId IN (SELECT id FROM npcpresence WHERE name IN 
('flux_ore_npc_wave_4_pelistal', 'flux_ore_npc_wave_4_thelodica', 'flux_ore_npc_wave_4_nuimqol')) AND
targetId=@fluxOre AND reinforcementType=@reinforceType;

UPDATE npcreinforcements SET 
	threshold=0.5
WHERE 
presenceId IN (SELECT id FROM npcpresence WHERE name IN 
('flux_ore_npc_wave_5_pelistal', 'flux_ore_npc_wave_5_thelodica', 'flux_ore_npc_wave_5_nuimqol')) AND
targetId=@fluxOre AND reinforcementType=@reinforceType;

UPDATE npcreinforcements SET 
	threshold=0.6
WHERE 
presenceId IN (SELECT id FROM npcpresence WHERE name IN 
('flux_ore_npc_wave_6_pelistal', 'flux_ore_npc_wave_6_thelodica', 'flux_ore_npc_wave_6_nuimqol')) AND
targetId=@fluxOre AND reinforcementType=@reinforceType;

UPDATE npcreinforcements SET 
	threshold=0.7
WHERE 
presenceId IN (SELECT id FROM npcpresence WHERE name IN 
('flux_ore_npc_wave_7_pelistal', 'flux_ore_npc_wave_7_thelodica', 'flux_ore_npc_wave_7_nuimqol')) AND
targetId=@fluxOre AND reinforcementType=@reinforceType;

UPDATE npcreinforcements SET 
	threshold=0.8
WHERE 
presenceId IN (SELECT id FROM npcpresence WHERE name IN 
('flux_ore_npc_wave_8_pelistal', 'flux_ore_npc_wave_8_thelodica', 'flux_ore_npc_wave_8_nuimqol')) AND
targetId=@fluxOre AND reinforcementType=@reinforceType;

UPDATE npcreinforcements SET 
	threshold=0.9
WHERE 
presenceId IN (SELECT id FROM npcpresence WHERE name IN 
('flux_ore_npc_wave_9_pelistal', 'flux_ore_npc_wave_9_thelodica', 'flux_ore_npc_wave_9_nuimqol')) AND
targetId=@fluxOre AND reinforcementType=@reinforceType;

PRINT N'DONE UPDATING npcreinforcements thresholds for fluxore spawns';
GO




PRINT N'Npcreinforcements_insert_bossreinforce__2020_11_27';
USE [perpetuumsa]
GO

------------------------------------------
-- NPCReinforcements for existing bosses
--
-- Date modified: 2020/12/02
------------------------------------------

PRINT N'ADD/UPDATE npcreinforcements FOR NPC BOSSES';

DECLARE @reinforceType AS INT = (SELECT TOP 1 id FROM npcreinforcementtypes WHERE name='boss');

DROP TABLE IF EXISTS #WAVES;
CREATE TABLE #WAVES (
	targetFlockName VARCHAR(100),
	presenceName VARCHAR(100),
	npcDefName VARCHAR(100),
	numInFlock INT,
	behaviorType INT,
	thresh FLOAT
);

INSERT INTO #WAVES (targetFlockName, presenceName, npcDefName, numInFlock, behaviorType, thresh) VALUES
--Hersh Pitboss
('Hersh_Pit_Boss', 'reinforce_pitboss_hersh_wave_0', 'def_npc_argano_basic_rank3', 1, 1, 0.1),
('Hersh_Pit_Boss', 'reinforce_pitboss_hersh_wave_0', 'def_npc_laird_basic_rank3', 1, 1, 0.1),
('Hersh_Pit_Boss', 'reinforce_pitboss_hersh_wave_0', 'def_npc_vektor_swab_rank3', 1, 1, 0.1),

('Hersh_Pit_Boss', 'reinforce_pitboss_hersh_wave_1', 'def_npc_argano_basic_rank3', 1, 1, 0.25),
('Hersh_Pit_Boss', 'reinforce_pitboss_hersh_wave_1', 'def_npc_laird_basic_rank3', 1, 1, 0.25),
('Hersh_Pit_Boss', 'reinforce_pitboss_hersh_wave_1', 'def_npc_sequer_basic_rank3', 1, 1, 0.25),
('Hersh_Pit_Boss', 'reinforce_pitboss_hersh_wave_1', 'def_npc_locust_firstmate_rank3', 1, 1, 0.25),
('Hersh_Pit_Boss', 'reinforce_pitboss_hersh_wave_1', 'def_npc_vektor_swab_rank3', 1, 1, 0.25),

('Hersh_Pit_Boss', 'reinforce_pitboss_hersh_wave_2', 'def_npc_sequer_basic_rank4', 2, 1, 0.4),
('Hersh_Pit_Boss', 'reinforce_pitboss_hersh_wave_2', 'def_npc_termis_basic_rank3', 1, 1, 0.4),
('Hersh_Pit_Boss', 'reinforce_pitboss_hersh_wave_2', 'def_npc_gargoyle_basic_rank3', 1, 1, 0.4),
('Hersh_Pit_Boss', 'reinforce_pitboss_hersh_wave_2', 'def_npc_locust_firstmate_rank3', 2, 1, 0.4),

('Hersh_Pit_Boss', 'reinforce_pitboss_hersh_wave_3', 'def_npc_sequer_basic_rank4', 2, 1, 0.65),
('Hersh_Pit_Boss', 'reinforce_pitboss_hersh_wave_3', 'def_npc_termis_basic_rank4', 2, 1, 0.65),
('Hersh_Pit_Boss', 'reinforce_pitboss_hersh_wave_3', 'def_npc_gargoyle_basic_rank4', 2, 1, 0.65),
('Hersh_Pit_Boss', 'reinforce_pitboss_hersh_wave_3', 'def_npc_locust_firstmate_rank4', 2, 1, 0.65),
('Hersh_Pit_Boss', 'reinforce_pitboss_hersh_wave_3', 'def_npc_callisto_buccaneer_rank2', 1, 1, 0.65),

--Dom Pitboss
('Domhalarn_Pitboss_flock_boss', 'reinforce_pitboss_dom_wave_0', 'def_npc_argano_basic_rank4', 1, 1, 0.1),
('Domhalarn_Pitboss_flock_boss', 'reinforce_pitboss_dom_wave_0', 'def_npc_laird_basic_rank4', 1, 1, 0.1),
('Domhalarn_Pitboss_flock_boss', 'reinforce_pitboss_dom_wave_0', 'def_npc_yagel_dps_rank4', 1, 1, 0.1),

('Domhalarn_Pitboss_flock_boss', 'reinforce_pitboss_dom_wave_1', 'def_npc_cameleon_ewjammer_rank4', 1, 1, 0.25),
('Domhalarn_Pitboss_flock_boss', 'reinforce_pitboss_dom_wave_1', 'def_npc_arbalest_interceptor_rank4', 1, 1, 0.25),
('Domhalarn_Pitboss_flock_boss', 'reinforce_pitboss_dom_wave_1', 'def_npc_yagel_dps_rank4', 1, 1, 0.25),

('Domhalarn_Pitboss_flock_boss', 'reinforce_pitboss_dom_wave_2', 'def_npc_cameleon_ewjammer_rank4', 2, 1, 0.4),
('Domhalarn_Pitboss_flock_boss', 'reinforce_pitboss_dom_wave_2', 'def_npc_arbalest_interceptor_rank4', 1, 1, 0.4),
('Domhalarn_Pitboss_flock_boss', 'reinforce_pitboss_dom_wave_2', 'def_npc_yagel_dps_rank4', 2, 1, 0.4),
('Domhalarn_Pitboss_flock_boss', 'reinforce_pitboss_dom_wave_2', 'def_npc_kain_ew_rank4', 1, 1, 0.4),

('Domhalarn_Pitboss_flock_boss', 'reinforce_pitboss_dom_wave_3', 'def_npc_cameleon_ewjammer_rank5', 2, 1, 0.65),
('Domhalarn_Pitboss_flock_boss', 'reinforce_pitboss_dom_wave_3', 'def_npc_arbalest_interceptor_rank5', 2, 1, 0.65),
('Domhalarn_Pitboss_flock_boss', 'reinforce_pitboss_dom_wave_3', 'def_npc_vagabond_jammer_rank4', 1, 1, 0.65),
('Domhalarn_Pitboss_flock_boss', 'reinforce_pitboss_dom_wave_3', 'def_npc_kain_dps_rank5', 2, 1, 0.65),

--Hokk Pitboss
('Hokkogaros_Pitboss_flock_boss', 'reinforce_pitboss_hokk_wave_0', 'def_npc_argano_basic_rank4', 1, 1, 0.1),
('Hokkogaros_Pitboss_flock_boss', 'reinforce_pitboss_hokk_wave_0', 'def_npc_laird_basic_rank4', 1, 1, 0.1),
('Hokkogaros_Pitboss_flock_boss', 'reinforce_pitboss_hokk_wave_0', 'def_npc_prometheus_dps_rank4', 1, 1, 0.1),

('Hokkogaros_Pitboss_flock_boss', 'reinforce_pitboss_hokk_wave_1', 'def_npc_intakt_ewjammer_rank4', 1, 1, 0.25),
('Hokkogaros_Pitboss_flock_boss', 'reinforce_pitboss_hokk_wave_1', 'def_npc_baphomet_interceptor_rank4', 1, 1, 0.25),
('Hokkogaros_Pitboss_flock_boss', 'reinforce_pitboss_hokk_wave_1', 'def_npc_prometheus_dps_rank4', 1, 1, 0.25),

('Hokkogaros_Pitboss_flock_boss', 'reinforce_pitboss_hokk_wave_2', 'def_npc_intakt_ewjammer_rank4', 2, 1, 0.4),
('Hokkogaros_Pitboss_flock_boss', 'reinforce_pitboss_hokk_wave_2', 'def_npc_baphomet_interceptor_rank4', 1, 1, 0.4),
('Hokkogaros_Pitboss_flock_boss', 'reinforce_pitboss_hokk_wave_2', 'def_npc_prometheus_dps_rank4', 2, 1, 0.4),
('Hokkogaros_Pitboss_flock_boss', 'reinforce_pitboss_hokk_wave_2', 'def_npc_artemis_ew_rank4', 1, 1, 0.4),

('Hokkogaros_Pitboss_flock_boss', 'reinforce_pitboss_hokk_wave_3', 'def_npc_intakt_ewjammer_rank5', 2, 1, 0.65),
('Hokkogaros_Pitboss_flock_boss', 'reinforce_pitboss_hokk_wave_3', 'def_npc_baphomet_interceptor_rank5', 2, 1, 0.65),
('Hokkogaros_Pitboss_flock_boss', 'reinforce_pitboss_hokk_wave_3', 'def_npc_zenith_jammer_rank4', 1, 1, 0.65),
('Hokkogaros_Pitboss_flock_boss', 'reinforce_pitboss_hokk_wave_3', 'def_npc_artemis_dps_rank5', 2, 1, 0.65),

--Nor Pitboss
('Norhoop_Pitboss_flock_boss', 'reinforce_pitboss_hoop_wave_0', 'def_npc_argano_basic_rank4', 1, 1, 0.1),
('Norhoop_Pitboss_flock_boss', 'reinforce_pitboss_hoop_wave_0', 'def_npc_laird_basic_rank4', 1, 1, 0.1),
('Norhoop_Pitboss_flock_boss', 'reinforce_pitboss_hoop_wave_0', 'def_npc_castel_dps_rank4', 1, 1, 0.1),

('Norhoop_Pitboss_flock_boss', 'reinforce_pitboss_hoop_wave_1', 'def_npc_troiar_ewjammer_rank4', 1, 1, 0.25),
('Norhoop_Pitboss_flock_boss', 'reinforce_pitboss_hoop_wave_1', 'def_npc_waspish_interceptor_rank4', 1, 1, 0.25),
('Norhoop_Pitboss_flock_boss', 'reinforce_pitboss_hoop_wave_1', 'def_npc_castel_dps_rank4', 1, 1, 0.25),

('Norhoop_Pitboss_flock_boss', 'reinforce_pitboss_hoop_wave_2', 'def_npc_troiar_ewjammer_rank4', 2, 1, 0.4),
('Norhoop_Pitboss_flock_boss', 'reinforce_pitboss_hoop_wave_2', 'def_npc_waspish_interceptor_rank4', 1, 1, 0.4),
('Norhoop_Pitboss_flock_boss', 'reinforce_pitboss_hoop_wave_2', 'def_npc_castel_dps_rank4', 2, 1, 0.4),
('Norhoop_Pitboss_flock_boss', 'reinforce_pitboss_hoop_wave_2', 'def_npc_tyrannos_ew_rank4', 1, 1, 0.4),

('Norhoop_Pitboss_flock_boss', 'reinforce_pitboss_hoop_wave_3', 'def_npc_troiar_ewjammer_rank5', 2, 1, 0.65),
('Norhoop_Pitboss_flock_boss', 'reinforce_pitboss_hoop_wave_3', 'def_npc_waspish_interceptor_rank4', 2, 1, 0.65),
('Norhoop_Pitboss_flock_boss', 'reinforce_pitboss_hoop_wave_3', 'def_npc_ictus_jammer_rank4', 1, 1, 0.65),
('Norhoop_Pitboss_flock_boss', 'reinforce_pitboss_hoop_wave_3', 'def_npc_tyrannos_dps_rank5', 2, 1, 0.65),

--Omega Stronghold Bosses
('tyrannos_protector', 'reinforce_strnghld1_tyrannos_wave_0', 'def_npc_troiar_ewjammer_rank5', 1, 2, 0.25),
('tyrannos_protector', 'reinforce_strnghld1_tyrannos_wave_1', 'def_npc_troiar_ewjammer_rank5', 2, 2, 0.55),

('artemis_protector_stronghold1', 'reinforce_strnghld1_artemis_wave_0', 'def_npc_intakt_ewjammer_rank5', 1, 2, 0.25),
('artemis_protector_stronghold1', 'reinforce_strnghld1_artemis_wave_1', 'def_npc_intakt_ewjammer_rank5', 2, 2, 0.55),

('kain_protector_stronghold1', 'reinforce_strnghld1_kain_wave_0', 'def_npc_cameleon_ewjammer_rank5', 1, 2, 0.25),
('kain_protector_stronghold1', 'reinforce_strnghld1_kain_wave_1', 'def_npc_cameleon_ewjammer_rank5', 2, 2, 0.55);

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
	presenceName+npcDefName, (SELECT id FROM npcpresence WHERE name=presenceName), numInFlock, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=npcDefName), 0, 0, 0, 10, 0, 1, 55, presenceName+npcDefName, 0.5, 1, 1, behaviorType, 0
FROM #WAVES;

INSERT INTO dbo.npcreinforcements
	(reinforcementType, targetId, threshold, presenceId, zoneId)
SELECT
	@reinforceType, (SELECT TOP 1 id FROM npcflock WHERE name=targetFlockName), thresh, (SELECT TOP 1 id FROM npcpresence WHERE name=presenceName), NULL
FROM #WAVES;

PRINT N'DONE w/ ADD/UPDATE npcreinforcements FOR NPC BOSSES';
DROP TABLE IF EXISTS #WAVES;
GO





PRINT N'Syndicate_rebalance__newammo__2020_08_30';
USE [perpetuumsa]
GO

--------------------------------------------------
-- Syndicate balance
-- Insert new ammo for firearms with different toxic dmg balance
-- Updates toxic dmg on existing ammo and bombs
-- Updates syndicate bot stats
-- Updates syndicate bot bonuses
-- Last Modified: 2020/12/12
--------------------------------------------------

DECLARE @toxicDamageName VARCHAR(100);
SET @toxicDamageName = 'damage_toxic';

DECLARE @tmShops INT;
SET @tmShops = (SELECT TOP 1 id FROM itemshoppresets WHERE name='tm_preset_pve');

DECLARE @dynCtCategory bigint;
SET @dynCtCategory = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_dynamic_cprg');

DECLARE @smallToxicAmmo INT;
DECLARE @smallToxicAmmoCT INT;
DECLARE @smallToxicAmmoCTCAPSULE INT;
DECLARE @medToxicAmmo INT;
DECLARE @medToxicAmmoCT INT;
DECLARE @medToxicAmmoCTCAPSULE INT;

SET @smallToxicAmmo = 5924;
SET @smallToxicAmmoCT = 5925;
SET @smallToxicAmmoCTCAPSULE = 5926;
SET @medToxicAmmo = 5927;
SET @medToxicAmmoCT = 5928;
SET @medToxicAmmoCTCAPSULE = 5929;

DROP TABLE IF EXISTS #AMMODEFS;
CREATE TABLE #AMMODEFS(
	[definition] [int] NOT NULL,
	[definitionname] [varchar](100) NOT NULL,
	[quantity] [int] NOT NULL,
	[attributeflags] [bigint] NOT NULL,
	[categoryflags] [bigint] NOT NULL,
	[options] [varchar](max) NULL,
	[note] [nvarchar](2048) NULL,
	[enabled] [bit] NOT NULL,
	[volume] [float] NULL,
	[mass] [float] NULL,
	[hidden] [bit] NOT NULL,
	[health] [float] NOT NULL,
	[descriptiontoken] [nvarchar](100) NULL,
	[purchasable] [bit] NOT NULL,
	[tiertype] [int] NULL,
	[tierlevel] [int] NULL,
);
INSERT INTO #AMMODEFS ([definition],[definitionname],[quantity],[attributeflags],[categoryflags],[options],[note],[enabled],[volume],[mass],[hidden],[health],[descriptiontoken],[purchasable],[tiertype],[tierlevel]) VALUES
(@smallToxicAmmo,'def_ammo_small_projectile_t',1000,34816,66314,'#bullettime=f45.0','toxic ammo small',1,0.5,0.1,0,100,'def_ammo_projectile_t_desc',1,0,0),
(@smallToxicAmmoCT,'def_ammo_small_projectile_t_cprg',1,1024,@dynCtCategory,NULL,NULL,1,0.01,0.1,0,100,'calibration_program_desc',0,NULL,NULL),
(@smallToxicAmmoCTCAPSULE,'def_ammo_small_projectile_t_CT_capsule',1,2052,1179,'','CT Capsule!',1,0.1,0.1,0,100,'def_ammo_small_projectile_t_CT_capsule_desc',1,0,0),
(@medToxicAmmo,'def_ammo_medium_projectile_t',1000,67584,131850,'#bullettime=f50.0','toxic ammo med',1,1,0.2,0,100,'def_ammo_projectile_t_desc',1,0,0),
(@medToxicAmmoCT,'def_ammo_medium_projectile_t_cprg',1,1024,@dynCtCategory,NULL,NULL,1,0.01,0.1,0,100,'calibration_program_desc',0,NULL,NULL),
(@medToxicAmmoCTCAPSULE,'def_ammo_medium_projectile_t_CT_capsule',1,2052,1179,'','CT Capsule!',1,0.1,0.1,0,100,'def_ammo_medium_projectile_t_CT_capsule_desc',1,0,0);


DROP TABLE IF EXISTS #AMMOCOMPONENTS;
CREATE TABLE #AMMOCOMPONENTS(
	defName VARCHAR(100),
	compDefName VARCHAR(100),
	amount FLOAT
);
INSERT INTO #AMMOCOMPONENTS (defName, compDefName, amount) VALUES
('def_ammo_small_projectile_t','def_titanium',100),
('def_ammo_small_projectile_t','def_phlobotil',100),
('def_ammo_small_projectile_t','def_polynucleit',100),
('def_ammo_small_projectile_t','def_polynitrocol',100),
('def_ammo_small_projectile_t','def_axicoline',100),

('def_ammo_medium_projectile_t','def_titanium',200),
('def_ammo_medium_projectile_t','def_phlobotil',200),
('def_ammo_medium_projectile_t','def_polynucleit',200),
('def_ammo_medium_projectile_t','def_polynitrocol',200),
('def_ammo_medium_projectile_t','def_axicoline',200);


DROP TABLE IF EXISTS #SHOPENTRIES;
CREATE TABLE #SHOPENTRIES
(
	defName varchar(100),
	tokenPrice int,
	nicPrice int
);
INSERT INTO #SHOPENTRIES (defName, tokenPrice, nicPrice) VALUES
('def_ammo_small_projectile_t_CT_capsule', 20, 1000000),
('def_ammo_medium_projectile_t_CT_capsule', 100, 5000000);

DROP TABLE IF EXISTS #TOXICDMG;
CREATE TABLE #TOXICDMG(
	ammoName VARCHAR(100),
	dmg INT
);
INSERT INTO #TOXICDMG(ammoName, dmg) VALUES
('def_ammo_large_projectile_a', 9),
('def_ammo_large_projectile_b', 9),
('def_ammo_large_projectile_c', 9),
('def_ammo_large_projectile_d', 9),
('def_ammo_medium_projectile_a', 6),
('def_ammo_medium_projectile_b', 6),
('def_ammo_medium_projectile_c', 6),
('def_ammo_medium_projectile_d', 6),
('def_ammo_medium_projectile_rewa', 6),
('def_ammo_medium_projectile_rewb', 6),
('def_ammo_small_projectile_a', 3),
('def_ammo_small_projectile_b', 3),
('def_ammo_small_projectile_c', 3),
('def_ammo_small_projectile_d', 3),
('def_ammo_small_projectile_rewa', 3),
('def_ammo_small_projectile_rewb', 3);


DROP TABLE IF EXISTS #TOXICBOMB;
CREATE TABLE #TOXICBOMB(
	bombName VARCHAR(100),
	toxicDmg INT,
	chemicalDmg INT,
	explosionRange INT,
	volume FLOAT
);
INSERT INTO #TOXICBOMB(bombName, toxicDmg, chemicalDmg, explosionRange, volume) VALUES
('def_area_bomb', 1000, 3500, 13, 1),
('def_area_bomb_capsule', 1000, 3500, 15, 7.5),
('def_plant_bomb', 2000, 1000, 13, 1),
('def_plant_bomb_capsule', 2000, 1000, 15, 4);


DROP TABLE IF EXISTS #STATS;
CREATE TABLE #STATS(
	defName VARCHAR(100),
	fieldName VARCHAR(100),
	value FLOAT
);
INSERT INTO #STATS (defName, fieldName, value) VALUES
--('def_vektor_chassis','core_max',200),
--('def_vektor_chassis','core_recharge_time',120),
--('def_vektor_chassis','signature_radius',4.5),
--('def_vektor_leg','speed_max',2.97),

--('def_helix_chassis','core_max',350),
--('def_helix_chassis','core_recharge_time',120),
--('def_helix_chassis','signature_radius',4),
('def_helix_leg','speed_max',3.388), --changed

('def_locust_chassis','core_max',420), --changed
('def_locust_chassis','core_recharge_time',180),
('def_locust_chassis','signature_radius',5.5),
('def_locust_leg','speed_max',2.933), --changed

('def_echelon_chassis','core_max',2050),--changed
('def_echelon_chassis','core_recharge_time',420),
('def_echelon_chassis','signature_radius',10),--changed
('def_echelon_leg','speed_max',2.48),--changed

('def_callisto_chassis','core_max',2600),
('def_callisto_chassis','core_recharge_time',360),
('def_callisto_chassis','signature_radius',9),--changed
('def_callisto_leg','speed_max',2.556),

('def_legatus_chassis','core_max',3850),
('def_legatus_chassis','core_recharge_time',720),
('def_legatus_chassis','signature_radius',22),--changed
('def_legatus_leg','speed_max',1.847),--changed

--('def_ikarus_chassis','core_max',150),
--('def_ikarus_chassis','core_recharge_time',240),
--('def_ikarus_chassis','signature_radius',4),
--('def_ikarus_leg','speed_max',3.35),

--('def_cronus_chassis','core_max',1400),
--('def_cronus_chassis','core_recharge_time',300),
--('def_cronus_chassis','signature_radius',5),
--('def_cronus_leg','speed_max',2.75),

--('def_hermes_chassis','core_max',450),
--('def_hermes_chassis','core_recharge_time',240),
--('def_hermes_chassis','signature_radius',4.5),
--('def_hermes_leg','speed_max',3),

--('def_daidalos_chassis','core_max',1800),
--('def_daidalos_chassis','core_recharge_time',480),
--('def_daidalos_chassis','signature_radius',11),
--('def_daidalos_leg','speed_max',2.25),

--('def_metis_chassis','core_max',3250),
--('def_metis_chassis','core_recharge_time',360),
--('def_metis_chassis','signature_radius',23),
--('def_metis_leg','speed_max',1.7),
--Guns
--('def_standard_medium_autocannon','cycle_time',4000),
--('def_standard_medium_autocannon','damage_modifier',1.6),
--('def_standard_medium_autocannon','falloff',20),
--('def_standard_medium_autocannon','optimal_range',12.5),

--('def_named1_medium_autocannon','cycle_time',4000),
--('def_named1_medium_autocannon','damage_modifier',1.6),
--('def_named1_medium_autocannon','falloff',20),
--('def_named1_medium_autocannon','optimal_range',12.5),

--('def_named1_medium_autocannon_pr','cycle_time',4000),
--('def_named1_medium_autocannon_pr','damage_modifier',1.6),
--('def_named1_medium_autocannon_pr','falloff',20),
--('def_named1_medium_autocannon_pr','optimal_range',12.5),

--('def_named2_medium_autocannon','cycle_time',4000),
--('def_named2_medium_autocannon','damage_modifier',1.7),
--('def_named2_medium_autocannon','falloff',21.5),
--('def_named2_medium_autocannon','optimal_range',14.5),

--('def_named2_medium_autocannon_pr','cycle_time',4000),
--('def_named2_medium_autocannon_pr','damage_modifier',1.7),
--('def_named2_medium_autocannon_pr','falloff',21.5),
--('def_named2_medium_autocannon_pr','optimal_range',14.5),

--('def_named3_medium_autocannon','cycle_time',3000),
--('def_named3_medium_autocannon','damage_modifier',1.35),
--('def_named3_medium_autocannon','falloff',18.5),
--('def_named3_medium_autocannon','optimal_range',15),

--('def_named3_medium_autocannon_pr','cycle_time',3000),
--('def_named3_medium_autocannon_pr','damage_modifier',1.35),
--('def_named3_medium_autocannon_pr','falloff',18.5),
--('def_named3_medium_autocannon_pr','optimal_range',15),

('def_longrange_standard_medium_autocannon','cycle_time',8000),
('def_longrange_standard_medium_autocannon','damage_modifier',2.0),
('def_longrange_standard_medium_autocannon','falloff',28),
('def_longrange_standard_medium_autocannon','optimal_range',22),

('def_named1_longrange_medium_autocannon','cycle_time',8000),
('def_named1_longrange_medium_autocannon','damage_modifier',2.0),
('def_named1_longrange_medium_autocannon','falloff',28),
('def_named1_longrange_medium_autocannon','optimal_range',22),

('def_named1_longrange_medium_autocannon_pr','cycle_time',8000),
('def_named1_longrange_medium_autocannon_pr','damage_modifier',2.0),
('def_named1_longrange_medium_autocannon_pr','falloff',28),
('def_named1_longrange_medium_autocannon_pr','optimal_range',22),

('def_named2_longrange_medium_autocannon','cycle_time',6000),
('def_named2_longrange_medium_autocannon','damage_modifier',1.60),
('def_named2_longrange_medium_autocannon','falloff',31.0),
('def_named2_longrange_medium_autocannon','optimal_range',23.5),

('def_named2_longrange_medium_autocannon_pr','cycle_time',6000),
('def_named2_longrange_medium_autocannon_pr','damage_modifier',1.60),
('def_named2_longrange_medium_autocannon_pr','falloff',31.0),
('def_named2_longrange_medium_autocannon_pr','optimal_range',23.5),

('def_named3_longrange_medium_autocannon','cycle_time',9000),
('def_named3_longrange_medium_autocannon','damage_modifier',2.70),
('def_named3_longrange_medium_autocannon','falloff',32.0),
('def_named3_longrange_medium_autocannon','optimal_range',24.0),

('def_named3_longrange_medium_autocannon_pr','cycle_time',9000),
('def_named3_longrange_medium_autocannon_pr','damage_modifier',2.70),
('def_named3_longrange_medium_autocannon_pr','falloff',32.0),
('def_named3_longrange_medium_autocannon_pr','optimal_range',24.0),
--NEW AMMO
('def_ammo_small_projectile_t','damage_chemical',6),
('def_ammo_small_projectile_t','damage_explosive',1),
('def_ammo_small_projectile_t','damage_kinetic',1),
('def_ammo_small_projectile_t','damage_thermal',1),
('def_ammo_small_projectile_t',@toxicDamageName,20),

('def_ammo_medium_projectile_t','damage_chemical',12),
('def_ammo_medium_projectile_t','damage_explosive',2),
('def_ammo_medium_projectile_t','damage_kinetic',2),
('def_ammo_medium_projectile_t','damage_thermal',2),
('def_ammo_medium_projectile_t',@toxicDamageName,40);


DROP TABLE IF EXISTS #BONUS;
CREATE TABLE #BONUS(
	defName VARCHAR(100),
	fieldName VARCHAR(100),
	value FLOAT
);
INSERT INTO #BONUS (defName, fieldName, value) VALUES
('def_vektor_chassis','damage_toxic_modifier',0.5),
('def_locust_chassis','damage_toxic_modifier',0.5),
('def_echelon_chassis','damage_toxic_modifier',0.5),
('def_legatus_chassis','damage_toxic_modifier',0.5),

('def_vektor_leg','signature_radius',-0.05),
('def_helix_leg','signature_radius',-0.05),
('def_locust_leg','signature_radius',-0.075),--changed
('def_echelon_leg','signature_radius',-0.175),--changed
('def_callisto_leg','signature_radius',-0.1),
('def_legatus_leg','signature_radius',-0.4),--changed
('def_daidalos_leg','signature_radius',-0.2);


DROP TABLE IF EXISTS #BEAMS;
CREATE TABLE #BEAMS 
(
	ammoName varchar(100),
	beamName varchar(100)
);
INSERT INTO #BEAMS (ammoName, beamName) VALUES
('def_ammo_small_projectile_t', 'pnc_small_bullet'),
('def_ammo_medium_projectile_t', 'pnc_medium_bullet');


DROP TABLE IF EXISTS #ENABLESKILLS;
CREATE TABLE #ENABLESKILLS 
(
	ammoName VARCHAR(100),
	extName VARCHAR(100),
	level INT
);
INSERT INTO #ENABLESKILLS (ammoName, extName, level) VALUES
('def_ammo_small_projectile_t','ext_small_projectile_turret',8),
('def_ammo_medium_projectile_t','ext_medium_projectile_turret',8);


DROP TABLE IF EXISTS #PROTO_TO_CT;
CREATE TABLE #PROTO_TO_CT
(
	protoDefName VARCHAR(100),
	ctDefName VARCHAR(100),
	level INT
);

INSERT INTO #PROTO_TO_CT (protoDefName, ctDefName, level) VALUES
('def_ammo_small_projectile_t','def_ammo_small_projectile_t_cprg', 2),
('def_ammo_medium_projectile_t','def_ammo_medium_projectile_t_cprg', 2);


SET IDENTITY_INSERT entitydefaults ON;
MERGE entitydefaults d USING #AMMODEFS a
ON d.definition=a.definition AND d.definitionname=a.definitionname
WHEN MATCHED
    THEN UPDATE SET
		d.[quantity]=a.[quantity],
		d.[attributeflags]=a.[attributeflags],
		d.[categoryflags]=a.[categoryflags],
		d.[options]=a.[options],
		d.[note]=a.[note],
		d.[enabled]=a.[enabled],
		d.[volume]=a.[volume],
		d.[mass]=a.[mass],
		d.[hidden]=a.[hidden],
		d.[health]=a.[health],
		d.[descriptiontoken]=a.[descriptiontoken],
		d.[purchasable]=a.[purchasable],
		d.[tiertype]=a.[tiertype],
		d.[tierlevel]=a.[tierlevel]
WHEN NOT MATCHED
    THEN INSERT([definition],[definitionname],[quantity],[attributeflags],[categoryflags],[options],[note],[enabled],[volume],[mass],[hidden],[health],[descriptiontoken],[purchasable],[tiertype],[tierlevel]) VALUES
	(a.[definition],a.[definitionname],a.[quantity],a.[attributeflags],a.[categoryflags],a.[options],a.[note],a.[enabled],a.[volume],a.[mass],a.[hidden],a.[health],a.[descriptiontoken],a.[purchasable],a.[tiertype],a.[tierlevel]);
SET IDENTITY_INSERT entitydefaults OFF;

PRINT N'INSERT OR UPDATE [dynamiccalibrationtemplates] FOR NEW TOXIC AMMO';
IF NOT EXISTS (SELECT TOP 1 definition FROM dynamiccalibrationtemplates WHERE definition=@smallToxicAmmoCT)
BEGIN
	PRINT N'INSERTING 2 RECORDS ON [dynamiccalibrationtemplates]...';
	INSERT INTO [dbo].dynamiccalibrationtemplates([definition],[materialefficiency],[timeefficiency],[targetdefinition]) VALUES
		(@smallToxicAmmoCT, 10, 10, @smallToxicAmmo),
		(@medToxicAmmoCT, 10, 10, @medToxicAmmo);
	PRINT N'INSERTED';
END
ELSE
BEGIN
	PRINT N'UPDATING 2 RECORDS ON [dynamiccalibrationtemplates]...';
	UPDATE dynamiccalibrationtemplates SET
		materialefficiency=10,
		timeefficiency=10
	WHERE definition in (@smallToxicAmmoCT, @medToxicAmmoCT);
	PRINT N'UPDATED';
END

PRINT N'INSERT if missing [calibrationtemplateitems] FOR NEW TOXIC AMMO';
IF NOT EXISTS (SELECT TOP 1 definition FROM [calibrationtemplateitems] WHERE definition=@smallToxicAmmoCTCAPSULE)
BEGIN
	PRINT N'INSERTING 2 RECORDS ON [calibrationtemplateitems]...';
	INSERT INTO [dbo].[calibrationtemplateitems]
				([definition],[targetdefinition])
			VALUES
				(@smallToxicAmmoCTCAPSULE,@smallToxicAmmoCT),
				(@medToxicAmmoCTCAPSULE,@medToxicAmmoCT);
	PRINT N'INSERTED!';
END

DELETE FROM components WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #AMMOCOMPONENTS));
PRINT N'DELETE/RE-INSERT components FOR NEW TOXIC AMMO';
INSERT INTO components(definition, componentdefinition, componentamount)
	SELECT 
		(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=a.defName),
		(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=a.compDefName),
		a.amount
	FROM #AMMOCOMPONENTS AS a;


PRINT N'INSERT/UPDATE chassisbonus FOR SYNDICATE BOT STATS';
MERGE aggregatevalues v USING #STATS s
ON v.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=s.defName) AND
v.field = (SELECT TOP 1 id FROM aggregatefields WHERE name=s.fieldName)
WHEN MATCHED
    THEN UPDATE SET
		v.value = s.value
WHEN NOT MATCHED
    THEN INSERT(definition, field, value) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=s.defName),
	(SELECT TOP 1 id FROM aggregatefields WHERE name=s.fieldName),
	s.value);

PRINT N'INSERT/UPDATE chassisbonus FOR SYNDICATE BOT BONUSES';
MERGE chassisbonus c USING #BONUS b
ON c.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=b.defName) AND
c.targetPropertyID = (SELECT TOP 1 id FROM aggregatefields WHERE name=b.fieldName)
WHEN MATCHED
    THEN UPDATE SET
		c.bonus = b.value;


PRINT N'INSERT/UPDATE aggregatevalues FOR TOXIC DMG AMMO';
MERGE aggregatevalues v USING #TOXICDMG t
ON v.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=t.ammoName) AND
v.field = (SELECT TOP 1 id FROM aggregatefields WHERE name=@toxicDamageName)
WHEN MATCHED
    THEN UPDATE SET
		v.value = t.dmg
WHEN NOT MATCHED
    THEN INSERT(definition, field, value) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=t.ammoName),
	(SELECT TOP 1 id FROM aggregatefields WHERE name=@toxicDamageName),
	t.dmg);


PRINT N'UPDATE definitionconfig FOR BOMBS';
MERGE definitionconfig c USING #TOXICBOMB t
ON c.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=t.bombName)
WHEN MATCHED
    THEN UPDATE SET
		c.damage_toxic = t.toxicDmg,
		c.damage_chemical = t.chemicalDmg,
		c.item_work_range = t.explosionRange;

PRINT N'UPDATE entitydefaults FOR BOMBS';
MERGE entitydefaults d USING #TOXICBOMB t
ON d.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=t.bombName)
WHEN MATCHED
    THEN UPDATE SET
		d.volume = t.volume;

PRINT N'UPDATE npc-market sellorders for plant bomb';
UPDATE marketitems SET
	price=300000
WHERE itemdefinition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_plant_bomb_capsule') AND
isvendoritem=1 AND isSell=1;


PRINT N'DELETE/RE-INSERT beamassignment FOR NEW TOXIC AMMO';
DELETE FROM beamassignment WHERE definition in (SELECT entitydefaults.definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT ammoName FROM #BEAMS));
INSERT INTO beamassignment (definition, beam)
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=ammoName),
	(SELECT TOP 1 id FROM beams WHERE name=beamName)
FROM #BEAMS

--DELETE and REINSERT
PRINT N'DELETE AMMO REQ-EXTENSIONS';
DELETE FROM enablerextensions WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT ammoName FROM #ENABLESKILLS));
PRINT N'INSERT AMMO REQ-EXTENSIONS';
INSERT INTO [dbo].[enablerextensions] ([definition],[extensionid],[extensionlevel]) 
SELECT (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname= ammoName),
	(SELECT TOP 1 extensionid FROM extensions WHERE extensionname = extName),
	level
FROM #ENABLESKILLS;


PRINT N'DELETE itemresearchlevels FOR ANY EXISTING toxicammo ct pairs';
DELETE FROM itemresearchlevels WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT protoDefName FROM #PROTO_TO_CT));

--PRINT N'INSERT itemresearchlevels FOR toxicammo ct pairs';
--INSERT INTO itemresearchlevels (definition, calibrationprogram, researchlevel, enabled)
--SELECT 
--	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = protoDefName), 
--	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = ctDefName), 
--	level, 1
--FROM #PROTO_TO_CT;

PRINT N'[itemshop]';
MERGE [dbo].[itemshop] shop USING #SHOPENTRIES e
ON shop.targetdefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=e.defName)
WHEN MATCHED
    THEN UPDATE SET
		presetid=@tmShops,
		targetamount=1,
		unicoin=e.tokenPrice,
		credit=e.nicPrice
WHEN NOT MATCHED
    THEN INSERT (presetid, targetdefinition, targetamount, tmcoin, icscoin, asicoin, credit, unicoin, globallimit, purchasecount, standing) VALUES
	(@tmShops, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=e.defName), 1, 0, 0, 0, e.nicPrice, e.tokenPrice, NULL, 1, 0);

PRINT N'DONE: new damage type added to bombs and projectile ammo';
DROP TABLE IF EXISTS #BEAMS;
DROP TABLE IF EXISTS #ENABLESKILLS;
DROP TABLE IF EXISTS #PROTO_TO_CT;
DROP TABLE IF EXISTS #SHOPENTRIES;
DROP TABLE IF EXISTS #AMMODEFS;
DROP TABLE IF EXISTS #AMMOCOMPONENTS;
DROP TABLE IF EXISTS #TOXICBOMB;
DROP TABLE IF EXISTS #TOXICDMG;
DROP TABLE IF EXISTS #BONUS;
DROP TABLE IF EXISTS #STATS;
GO



PRINT N'Zone_16_invalid_entities__2020_09_16';
USE [perpetuumsa]
GO

-----------------------------------------------
-- Some zone entities left over in Zone 16
-- throwing exceptions during server startup
--
-- Date: 2020/09/22
-----------------------------------------------

DELETE FROM zoneentities WHERE eid IN (1328, 1329, 1339) AND synckey IN ('arena_guard', 'tp_back_home', 'tp_back_home2');
GO

PRINT N'Done! Patch 19 Applied';
GO