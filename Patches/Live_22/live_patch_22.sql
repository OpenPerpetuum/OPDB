USE [perpetuumsa]
GO

PRINT N'APPLYING PATCH 22';
-------------------------------------------------
--Patch 22 filelist:
--aggfield_extensions_insert_flux_skills__2021_05_01.sql
--aggvalues_insert_targetRift__2020_05_05.sql
--aggvalues_update_arkmk2__2021_05_01.sql
--chassisbonus_reinsert_assaultchassis__2021_05_01.sql
--Components_firearms__2021_05_02.sql
--CreateProc_forcedockhome__2021_04_18.sql
--Effects_insert_strhld_timer__2021_05_02.sql
--Entitydefaults_enable_t4plusz71z72__2021_05_02.sql
--NpcBossInfo_ALTER_channel_insert_npcannounce__2021_05_10.sql
--robottemplates_71bonnie__2021_05_01.sql
--Zones_ALTER_newcol__2021_04_25.sql

--Date modified: 2021/05/28
--------------------------------------------------

--aggfield_extensions_insert_flux_skills__2021_05_01.sql
PRINT N'aggfield_extensions_insert_flux_skills__2021_05_01.sql';
USE [perpetuumsa]
GO

-----------------------------------------------
-- Flux mining amount extensions
-- Adds 2 new modifier fields that must be enumerated and mapped in server enums!
-- Date Modified: 2021/05/02
-----------------------------------------------

DECLARE @miningAmountFieldID AS INT = 662;
DECLARE @miningAmountFieldName AS VARCHAR(100) = 'mining_amount_flux_modifier';
DECLARE @miningAmountSkillName AS VARCHAR(100) = 'ext_flux_miner_expert';

DECLARE @miningCycleFieldID AS INT = 663;
DECLARE @miningCycleFieldName AS VARCHAR(100) = 'mining_cycle_time_flux_modifier';
DECLARE @miningCycleSkillName AS VARCHAR(100) = 'ext_flux_mining_buffer_expert';

DECLARE @lastExtId AS INT = (SELECT TOP 1 extensionid FROM extensions ORDER BY extensionid DESC);

IF NOT EXISTS (SELECT TOP 1 id FROM dbo.aggregatefields WHERE name = @miningAmountFieldName)
BEGIN
PRINT N'INSERTING '+@miningAmountFieldName;
	SET IDENTITY_INSERT dbo.aggregatefields ON;
	INSERT INTO dbo.aggregatefields(id, name, formula, measurementunit, measurementmultiplier, measurementoffset, category, digits, moreisbetter, usedinconfig, note) VALUES
	(@miningAmountFieldID, @miningAmountFieldName, 0, @miningAmountFieldName+'_desc', 100, 0, 6, 2, 1, 1, 'Flux mining modifier');
	SET IDENTITY_INSERT dbo.aggregatefields OFF;
END

IF NOT EXISTS (SELECT TOP 1 extensionid FROM dbo.extensions WHERE extensionname = @miningAmountSkillName)
BEGIN
	PRINT N'INSERTING extensions '+@miningAmountSkillName;
	INSERT INTO dbo.extensions(extensionid, extensionname, category, rank, targetlearningattribute, learningattributeprimary, learningattributesecondary, bonus, note, price, active, description, targetpropertyID, effectenhancer, hidden, freezelimit) VALUES
	(@lastExtId+1, @miningAmountSkillName, 15, 7, NULL, 'attributeC', 'attributeB', 0.03, 'Flux mining skill', 245000, 1, @miningAmountSkillName+'_desc', @miningAmountFieldID, 0, 0, 7);
END


IF NOT EXISTS (SELECT TOP 1 id FROM dbo.aggregatefields WHERE name = @miningCycleFieldName)
BEGIN
	PRINT N'INSERTING aggregatefields '+@miningCycleFieldName;
	SET IDENTITY_INSERT dbo.aggregatefields ON;
	INSERT INTO dbo.aggregatefields(id, name, formula, measurementunit, measurementmultiplier, measurementoffset, category, digits, moreisbetter, usedinconfig, note) VALUES
	(@miningCycleFieldID, @miningCycleFieldName, 2, @miningCycleFieldName+'_unit', 100, -100, 6, 0, 0, 1, 'Flux mining cycle modifier');
	SET IDENTITY_INSERT dbo.aggregatefields OFF;
END


IF NOT EXISTS (SELECT TOP 1 extensionid FROM dbo.extensions WHERE extensionname = @miningCycleSkillName)
BEGIN
	PRINT N'INSERTING extensions '+@miningCycleSkillName;
	SET @lastExtId = (SELECT TOP 1 extensionid FROM extensions ORDER BY extensionid DESC);
	INSERT INTO dbo.extensions(extensionid, extensionname, category, rank, targetlearningattribute, learningattributeprimary, learningattributesecondary, bonus, note, price, active, description, targetpropertyID, effectenhancer, hidden, freezelimit) VALUES
	(@lastExtId+1, @miningCycleSkillName, 15, 7, NULL, 'attributeC', 'attributeB', 0.01, 'Flux mining skill', 245000, 1, @miningCycleSkillName+'_desc', @miningCycleFieldID, 0, 0, 7);
END


DROP TABLE IF EXISTS #EXT_REQS;
CREATE TABLE #EXT_REQS(
	extName VARCHAR(100),
	reqExtName VARCHAR(100),
	reqExtLevel INT
);
INSERT INTO #EXT_REQS (extName, reqExtName, reqExtLevel) VALUES
(@miningAmountSkillName, 'ext_epriton_miner_expert', 5),
(@miningCycleSkillName, 'ext_epriton_mining_buffer_expert', 5);

--SELECT * FROM extensionprerequire WHERE 
--	extensionid IN (SELECT extensionid FROM extensions WHERE extensionname in (SELECT DISTINCT extName FROM #EXT_REQS));

DELETE FROM extensionprerequire WHERE 
	extensionid IN (SELECT extensionid FROM extensions WHERE extensionname in (SELECT DISTINCT extName FROM #EXT_REQS));

INSERT INTO extensionprerequire (extensionid, requiredextension, requiredlevel)
SELECT 
	(SELECT extensionid FROM extensions WHERE extensionname=extName),
	(SELECT extensionid FROM extensions WHERE extensionname=reqExtName),
	reqExtLevel
FROM #EXT_REQS;

DROP TABLE IF EXISTS #EXT_REQS;
GO


--aggvalues_insert_targetRift__2020_05_05.sql
PRINT N'aggvalues_insert_targetRift__2020_05_05.sql';
USE [perpetuumsa]
GO

-----------------------------------------------------
-- Targetted rift stats (mostly for masking)
--
-- Date Modified: 2021_05_05
-----------------------------------------------------


DROP TABLE IF EXISTS #STATS;
CREATE TABLE #STATS(
	defName VARCHAR(100),
	fieldName VARCHAR(100),
	val FLOAT
);
INSERT INTO #STATS (defName, fieldName, val) VALUES
('def_rift_targetted_portal','armor_max',42069),
('def_rift_targetted_portal','resist_chemical',100000),
('def_rift_targetted_portal','resist_explosive',100000),
('def_rift_targetted_portal','resist_kinetic',100000),
('def_rift_targetted_portal','resist_thermal',100000),
('def_rift_targetted_portal','signature_radius',1),
('def_rift_targetted_portal','blob_emission',10),
('def_rift_targetted_portal','blob_emission_radius',50),
('def_rift_targetted_portal','stealth_strength',25);

PRINT N'DELETE aggregatevalues TO BE REPLACED (0 rows affected)<-1ST RUN';
DELETE FROM aggregatevalues WHERE definition IN 
	(SELECT definition FROM entitydefaults WHERE definitionname IN 
		(SELECT DISTINCT defName FROM #STATS));

PRINT N'INSERT aggregatevalues (9 rows affected)';
INSERT INTO aggregatevalues(definition, field, value)
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defName),
	(SELECT TOP 1 id FROM aggregatefields WHERE name=fieldName),
	val
FROM #STATS;


DROP TABLE IF EXISTS #STATS;
GO


--aggvalues_update_arkmk2__2021_05_01.sql
PRINT N'aggvalues_update_arkmk2__2021_05_01.sql';
USE [perpetuumsa]
GO

------------------------------------
-- Arkhe mk2+gift arkhe interference buff
-- Date modified: 2021/05/01
------------------------------------

DROP TABLE IF EXISTS #AGG_VALS;
CREATE TABLE #AGG_VALS(
	defName VARCHAR(100),
	fieldName VARCHAR(100),
	fieldValue float
);
INSERT INTO #AGG_VALS (defName, fieldName, fieldValue) VALUES
('def_arkhe2_bot_head', 'blob_level_low', 40),
('def_arkhe2_bot_head', 'blob_level_high', 140);


PRINT N'UPDATE AGG VALUES';
MERGE [dbo].[aggregatevalues] a USING #AGG_VALS v
ON a.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=v.defName) AND
a.field = (SELECT TOP 1 id FROM aggregatefields WHERE name=v.fieldName)
WHEN MATCHED
    THEN UPDATE SET
		value=v.fieldValue;


DROP TABLE IF EXISTS #AGG_VALS;
PRINT N'UPDATED ARKHE MK2+ANNIVERSARKHE BOT STATS';
GO

--chassisbonus_reinsert_assaultchassis__2021_05_01.sql
PRINT N'chassisbonus_reinsert_assaultchassis__2021_05_01.sql';
USE [perpetuumsa]
GO

-------------------------------------------------------
-- Assault bonus bug
-- Flat weapon type damage bonus is linear, the size specific is the desired bonus type
-- Add small/medium so both receive bonus as intended
-- Date Modified: 2021/05/05
-------------------------------------------------------

DROP TABLE IF EXISTS #BONUS;
CREATE TABLE #BONUS(
	defName VARCHAR(100),
	fieldName VARCHAR(100),
	extName VARCHAR(100),
	bonusAmount FLOAT
);
INSERT INTO #BONUS (defName, fieldName, extName, bonusAmount) VALUES
('def_waspish_chassis','damage_medium_missile_modifier','ext_lightarmored_unit_piloting',0.05),
('def_waspish_chassis','damage_small_missile_modifier','ext_lightarmored_unit_piloting',0.05),
('def_waspish_chassis','missile_cycle_time_modifier','ext_lightarmored_unit_piloting',0.02),

('def_waspish_chassis_mk2','damage_medium_missile_modifier','ext_lightarmored_unit_piloting',0.05),
('def_waspish_chassis_mk2','damage_small_missile_modifier','ext_lightarmored_unit_piloting',0.05),
('def_waspish_chassis_mk2','missile_cycle_time_modifier','ext_lightarmored_unit_piloting',0.02),

('def_waspish_chassis_pr','damage_medium_missile_modifier','ext_lightarmored_unit_piloting',0.05),
('def_waspish_chassis_pr','damage_small_missile_modifier','ext_lightarmored_unit_piloting',0.05),
('def_waspish_chassis_pr','missile_cycle_time_modifier','ext_lightarmored_unit_piloting',0.02),

('def_arbalest_chassis','damage_medium_railgun_modifier','ext_lightarmored_unit_piloting',0.05),
('def_arbalest_chassis','damage_small_railgun_modifier','ext_lightarmored_unit_piloting',0.05),
('def_arbalest_chassis','damage_small_missile_modifier','ext_lightarmored_unit_piloting',0.05),

('def_arbalest_chassis_mk2','damage_medium_railgun_modifier','ext_lightarmored_unit_piloting',0.05),
('def_arbalest_chassis_mk2','damage_small_railgun_modifier','ext_lightarmored_unit_piloting',0.05),
('def_arbalest_chassis_mk2','damage_small_missile_modifier','ext_lightarmored_unit_piloting',0.05),

('def_arbalest_chassis_pr','damage_medium_railgun_modifier','ext_lightarmored_unit_piloting',0.05),
('def_arbalest_chassis_pr','damage_small_railgun_modifier','ext_lightarmored_unit_piloting',0.05),
('def_arbalest_chassis_pr','damage_small_missile_modifier','ext_lightarmored_unit_piloting',0.05),

('def_baphomet_chassis','core_usage_laser_modifier','ext_lightarmored_unit_piloting',-0.03),
('def_baphomet_chassis','damage_medium_laser_modifier','ext_lightarmored_unit_piloting',0.05),
('def_baphomet_chassis','damage_small_laser_modifier','ext_lightarmored_unit_piloting',0.05),

('def_baphomet_chassis_pr','core_usage_laser_modifier','ext_lightarmored_unit_piloting',-0.03),
('def_baphomet_chassis_pr','damage_medium_laser_modifier','ext_lightarmored_unit_piloting',0.05),
('def_baphomet_chassis_pr','damage_small_laser_modifier','ext_lightarmored_unit_piloting',0.05),

('def_baphomet_mk2_chassis','core_usage_laser_modifier','ext_lightarmored_unit_piloting',-0.03),
('def_baphomet_mk2_chassis','damage_medium_laser_modifier','ext_lightarmored_unit_piloting',0.05),
('def_baphomet_mk2_chassis','damage_small_laser_modifier','ext_lightarmored_unit_piloting',0.05),

('def_daidalos_chassis','damage_medium_projectile_modifier','ext_heavyarmored_unit_piloting',0.1),
('def_daidalos_chassis','damage_small_projectile_modifier','ext_heavyarmored_unit_piloting',0.1),

('def_hermes_chassis','damage_medium_projectile_modifier','ext_lightarmored_unit_piloting',0.03),
('def_hermes_chassis','damage_small_projectile_modifier','ext_lightarmored_unit_piloting',0.03),

('def_locust_chassis','damage_medium_projectile_modifier','ext_lightarmored_unit_piloting',0.03),
('def_locust_chassis','damage_small_projectile_modifier','ext_lightarmored_unit_piloting',0.03),
('def_locust_chassis','projectile_falloff_modifier','ext_lightarmored_unit_piloting',0.03),
('def_locust_chassis','damage_toxic_modifier','ext_syndicate_combat_specialist',0.5);

--SELECT * FROM chassisbonus WHERE definition IN 
--	(SELECT definition FROM entitydefaults WHERE definitionname IN 
--		(SELECT DISTINCT defName FROM #BONUS));

PRINT N'DELETE CHASSIS BONUSES TO BE REPLACED (15 rows affected)<-1ST RUN';
DELETE FROM chassisbonus WHERE definition IN 
	(SELECT definition FROM entitydefaults WHERE definitionname IN 
		(SELECT DISTINCT defName FROM #BONUS));

PRINT N'INSERT CHASSIS BONUSES (35 rows affected)';
INSERT INTO chassisbonus (definition, extension, bonus, note, targetpropertyID, effectenhancer)
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defName),
	(SELECT TOP 1 extensionid FROM extensions WHERE extensionname=extName),
	bonusAmount, NULL,
	(SELECT TOP 1 id FROM aggregatefields WHERE name=fieldName),
	0
FROM #BONUS;

DROP TABLE IF EXISTS #BONUS;
GO

--Components_firearms__2021_05_02.sql
PRINT N'Components_firearms__2021_05_02.sql';
USE [perpetuumsa]
GO

--------------------------------------------------
-- Firearm production, reduce titanium = levels of other modules
--
-- Date modified: 2021/05/05
--------------------------------------------------

PRINT N'Firearm production adjustments';
DROP TABLE IF EXISTS #COMPS;
CREATE TABLE #COMPS(
	defName VARCHAR(100),
	compName VARCHAR(100),
	amount INT
);
INSERT INTO #COMPS (defName, compName, amount) VALUES
('def_standard_small_autocannon','def_titanium',50),
('def_standard_medium_autocannon','def_titanium',100),
('def_named1_small_autocannon','def_titanium',50),
('def_named2_small_autocannon','def_titanium',50),
('def_named3_small_autocannon','def_titanium',50),
('def_named1_medium_autocannon','def_titanium',100),
('def_named2_medium_autocannon','def_titanium',100),
('def_named3_medium_autocannon','def_titanium',100),
('def_longrange_standard_medium_autocannon','def_titanium',100),
('def_named1_longrange_medium_autocannon','def_titanium',100),
('def_named2_longrange_medium_autocannon','def_titanium',100),
('def_named3_longrange_medium_autocannon','def_titanium',100),
('def_named1_small_autocannon_pr','def_titanium',50),
('def_named2_small_autocannon_pr','def_titanium',50),
('def_named3_small_autocannon_pr','def_titanium',50),
('def_named1_medium_autocannon_pr','def_titanium',100),
('def_named2_medium_autocannon_pr','def_titanium',100),
('def_named3_medium_autocannon_pr','def_titanium',100),
('def_named1_longrange_medium_autocannon_pr','def_titanium',100),
('def_named2_longrange_medium_autocannon_pr','def_titanium',100),
('def_named3_longrange_medium_autocannon_pr','def_titanium',100);

PRINT N'Update [components]';
MERGE [dbo].[components] c USING #COMPS i
ON c.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=i.defName) AND
c.componentdefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=i.compName) 
WHEN MATCHED
    THEN UPDATE SET
		componentamount = i.amount;

PRINT N'Updated [components] for firearm prod';
DROP TABLE IF EXISTS #COMPS;
GO

--CreateProc_forcedockhome__2021_04_18.sql
PRINT N'CreateProc_forcedockhome__2021_04_18.sql';
USE [perpetuumsa]
GO

----------------------------------------------------
-- Dock character to their home or TMA
-- 
-- Date modified: 2021/04/18
----------------------------------------------------


DROP PROCEDURE IF EXISTS [opp].[characterForceDockHome];

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [opp].[characterForceDockHome]
	@characterId INT
	
AS
BEGIN
		SET NOCOUNT ON;
		DECLARE @baseEid BIGINT, @publicContainer BIGINT, @activeRobot BIGINT;
		SET @baseEid = 561; --TMA default

		DECLARE @homeBaseEid AS BIGINT = (SELECT TOP 1 homeBaseEID FROM dbo.characters WHERE characterID=@characterId);
		IF (@homeBaseEid IS NOT NULL)
		BEGIN
			SET @baseEid = @homeBaseEid;
		END 
		SET @publicContainer = (SELECT TOP 1 eid FROM entities WHERE parent=@baseEid AND
			definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_public_container'));
		
		--dock character to tma
		UPDATE dbo.characters SET 
			docked=1,
			zoneID=NULL,
			positionX=NULL,
			positionY=NULL,
			baseEID=@baseEid 
		WHERE characterID=@characterId;
		 
		SET @activeRobot = (SELECT activechassis FROM dbo.characters WHERE characterID=@characterId);
		
		IF (@activeRobot IS NOT NULL)
		BEGIN
			--parent robot to tma public container
			UPDATE dbo.entities SET parent=@publicContainer WHERE eid=@activeRobot
		END     
	
END
GO


--Effects_insert_strhld_timer__2021_05_02.sql
PRINT N'Effects_insert_strhld_timer__2021_05_02.sql';
USE [perpetuumsa]
GO

-------------------------------------------
-- Add effect for stronghold player time expiration
--
-- Date modified: 2021/05/02 
-------------------------------------------


DECLARE @effectID AS INT = 115;
DECLARE @effectName AS VARCHAR(100) = 'effect_stronghold_despawn_timer';
DECLARE @effectCat AS BIGINT = POWER(CAST(2 AS BIGINT), CAST((SELECT TOP 1 flag from effectcategories where NAME='effcat_terrain_object_effects') AS BIGINT));

IF NOT EXISTS (SELECT TOP 1 id FROM dbo.effects WHERE name = @effectName)
BEGIN
PRINT N'INSERTING '+@effectName;
	SET IDENTITY_INSERT dbo.effects ON;
	INSERT INTO dbo.effects(id, effectcategory, duration, name, description, note, isaura, auraradius, ispositive, display, saveable) VALUES
	(@effectID, @effectCat, 600000, @effectName, @effectName+'_desc', 'stronghold despawn timer', 0, 0, 0, 3, 0);
	SET IDENTITY_INSERT dbo.effects OFF;
END

GO

--Entitydefaults_enable_t4plusz71z72__2021_05_02.sql
PRINT N'Entitydefaults_enable_t4plusz71z72__2021_05_02.sql';
USE [perpetuumsa]
GO

PRINT N'Enable and show ALL T4+ FOR Z71-72';

PRINT N'TABLE OF NAMES';
DROP TABLE IF EXISTS #HIDE;
CREATE TABLE #HIDE (
	defName VARCHAR(100)
);
INSERT INTO #HIDE (defName) VALUES 
('def_elitet4_72_small_armor_repairer'),
('def_elitet4_72_medium_armor_repairer'),
('def_elitet4_71_small_shield_generator'),
('def_elitet4_71_medium_shield_generator'),
('def_elitet4_71_mining_probe_module'),
('def_elitet4_72_damage_mod_projectile'),
('def_elitet4_72_mass_reductor'),
('def_elitet4_71_maneuvering_upgrade'),

('def_elitet4_72_small_armor_repairer_cprg'),
('def_elitet4_72_medium_armor_repairer_cprg'),
('def_elitet4_71_small_shield_generator_cprg'),
('def_elitet4_71_medium_shield_generator_cprg'),
('def_elitet4_71_mining_probe_module_cprg'),
('def_elitet4_72_damage_mod_projectile_cprg'),
('def_elitet4_72_mass_reductor_cprg'),
('def_elitet4_71_maneuvering_upgrade_cprg'),

('def_elitet4_72_small_armor_repairer_CT_capsule'),
('def_elitet4_72_medium_armor_repairer_CT_capsule'),
('def_elitet4_71_small_shield_generator_CT_capsule'),
('def_elitet4_71_medium_shield_generator_CT_capsule'),
('def_elitet4_71_mining_probe_module_CT_capsule'),
('def_elitet4_72_damage_mod_projectile_CT_capsule'),
('def_elitet4_72_mass_reductor_CT_capsule'),
('def_elitet4_71_maneuvering_upgrade_CT_capsule');

PRINT N'MERGE/UPDATE ALL MATCHING DEFS';
MERGE [dbo].[entitydefaults] e USING #HIDE d
ON e.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=d.defName)
WHEN MATCHED
    THEN UPDATE SET
		enabled=1,
		hidden=0;

PRINT N'all t4+ for z71-2 enabled and shown';
DROP TABLE IF EXISTS #HIDE;
GO

--NpcBossInfo_ALTER_channel_insert_npcannounce__2021_05_10.sql
PRINT N'NpcBossInfo_ALTER_channel_insert_npcannounce__2021_05_10.sql';
USE [perpetuumsa]
GO

-------------------------------------------------
-- Boss announcer features
-- Add column to npcbossinfo
-- Insert new channel for reporting
-- Update select bossinfos with flag value
-- Date modified: 2021/05/17
-------------------------------------------------

PRINT N'ALTER [dbo].[npcbossinfo]';
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[perpetuumsa].[dbo].[npcbossinfo]')
	AND name = 'isAnnounced')
BEGIN
	PRINT N'ADDING COL isAnnounced';
	ALTER TABLE [perpetuumsa].[dbo].[npcbossinfo] ADD
		isAnnounced BIT NOT NULL DEFAULT(0);
END
GO

USE [perpetuumsa]
GO
PRINT N'ADDING NEW CHAT CHANNEL FOR NPC ANNOUNCEMENTS';
DECLARE @chanName AS VARCHAR(100) = 'Syndicate Radio';

IF NOT EXISTS (SELECT TOP 1 name FROM channels WHERE name=@chanName)
BEGIN
	PRINT N'INSERT INTO channels '+@chanName;
	INSERT INTO channels (name, password, topic, type) VALUES
	(@chanName, NULL, '', 1);
END
ELSE
BEGIN
	PRINT N'UPDATE channels '+@chanName;
	UPDATE channels SET
		password=NULL,
		topic='',
		type=1
	WHERE name=@chanName;
END

DECLARE @oppChar AS INT = (SELECT TOP 1 characterID FROM characters WHERE nick='[OPP] Announcer');
DECLARE @chanID AS INT = (SELECT TOP 1 id FROM channels WHERE name=@chanName);

PRINT N'DELETE AND REINSERT [OPP] CHAR INTO CHANNEL WITH ROLES';
--SELECT * FROM channelmembers WHERE channelid=@chanID AND memberid=@oppChar;
DELETE FROM channelmembers WHERE channelid=@chanID AND memberid=@oppChar;
INSERT INTO channelmembers (channelid, memberid, role) VALUES
(@chanID, @oppChar, 2);

GO

USE [perpetuumsa]
GO
PRINT N'UPDATE npcbossinfo WITH isAnnounced CONFIGS';
UPDATE npcbossinfo SET
	isAnnounced=1
WHERE flockid IN (SELECT id FROM npcflock WHERE npcSpecialType=1 AND name IN 
(
'Rough_Rider_Leader',
'def_npc_Imperial_Infantry',
'def_npc_Tribal_Member',
'def_npc_Sacrist_Convert',
'hersh_yellow_boss',
'Blue_Hersh_mech_boss',
'hersh_GreenBoss',
'Hersh_RR_1',
'Hersh_Pit_Boss',
'Norhoop_Pitboss_flock_boss',
'Hokkogaros_Pitboss_flock_boss',
'Domhalarn_Pitboss_flock_boss',
'def_npc_sh70_mainboss_94_108_z70'
));

GO

--robottemplates_71bonnie__2021_05_01.sql
PRINT N'robottemplates_71bonnie__2021_05_01.sql';
USE [perpetuumsa]
GO

-----------------------------------------------------
-- Stronghold npc bugs/tweaks
-- Bonnie and helix no armor rep equipped
-- Date Modified: 2021_05_05
-----------------------------------------------------

PRINT N'UPDATE robot templates for Zone71_WilliamHBonnie and Helix_Boss_Guard';
UPDATE robottemplates SET
	description='#robot=i1590#head=i1591#chassis=i1592#leg=i1593#container=i149#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i33|slot=i2]|m2=[|definition=i32|slot=i3]|m3=[|definition=i0|slot=i4]|m4=[|definition=i0|slot=i5]]#chassisModules=[|m0=[|definition=i3d|slot=i1|ammoDefinition=i986|ammoQuantity=i1f4]|m1=[|definition=i3d|slot=i2|ammoDefinition=i988|ammoQuantity=i1f4]|m2=[|definition=i24|slot=i3]]#legModules=[|m0=[|definition=i12|slot=i1]|m1=[|definition=i19|slot=i2]|m2=[|definition=i12a|slot=i3]|m3=[|definition=i10|slot=i4]|m4=[|definition=i13|slot=i5]]'
WHERE name='Zone71_WilliamHBonnie';

UPDATE robottemplates SET
	description='#robot=i1584#head=i1585#chassis=i1586#leg=i1587#container=i146#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i33|slot=i2]|m2=[|definition=i32|slot=i3]|m3=[|definition=i0|slot=i4]]#chassisModules=[|m0=[|definition=i26|slot=i1]|m1=[|definition=i26|slot=i2]|m2=[|definition=i3c|slot=i3|ammoDefinition=i984|ammoQuantity=ifa]]#legModules=[|m0=[|definition=i1c|slot=i1]|m1=[|definition=i12|slot=i2]]'
WHERE name='Helix_Boss_Guard';

GO


--Zones_ALTER_newcol__2021_04_25.sql
PRINT N'Zones_ALTER_newcol__2021_04_25.sql';
USE [perpetuumsa]
GO

PRINT N'ALTER [dbo].[zones]';
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[perpetuumsa].[dbo].[zones]')
	AND name = 'timeLimitMinutes')
BEGIN
	PRINT N'ADDING COL timeLimitMinutes';
	ALTER TABLE [perpetuumsa].[dbo].[zones] ADD
		timeLimitMinutes INT NULL;
END
GO

USE [perpetuumsa]
GO

--Set all strongholds (just in case)
UPDATE zones SET 
	timeLimitMinutes = 180
WHERE zonetype=4;

--Set the all small strongholds
UPDATE zones SET
	timeLimitMinutes = 60
WHERE zonetype=4 AND width < 257;

-- Set Omega stronghold
UPDATE zones SET 
	timeLimitMinutes = 180
WHERE zonetype=4 AND name='zone_pvp_arena';

--Set the zone 71-72 Syndicate mini strongholds to 1 hour
UPDATE zones SET
	timeLimitMinutes = 60
WHERE zonetype=4 AND name IN ('zone_strghld_71', 'zone_strghld_72');

--Set the Sentinel to 9 hours
UPDATE zones SET
	timeLimitMinutes = 540
WHERE zonetype=4 AND name='zone_strghld_70';

GO

PRINT N'PATCH 22 APPLIED';
GO