USE [perpetuumsa]
GO

------------------------------------------------------------
--PATCH 16
--Including:
--Anniversarkhe_and_gifts_year2__2020_04_07
--Entitydefaults__update_ChassisScanners__2020_03_21
--Entitydefaults_insert_mob_tele_strnghld__2020_04_03
--NPC_beta1_pbosses__2020_04_07
--npcs_create_iztable_modify_npcpresence__2020_03_10
--SP_artifactRefresh__2020_03_19
--Zoneentity_insert_strnghld_tele_col__2020_04_03
------------------------------------------------------------
PRINT N'PATCH 16 BEGIN!';
------------------------------------------------------------
PRINT N'SP_artifactRefresh__2020_03_19';
USE [perpetuumsa]
GO

IF OBJECT_ID('opp.artifactRefresh', 'P') IS NOT NULL
	DROP PROCEDURE [opp].[artifactRefresh];
GO

CREATE PROCEDURE [opp].[artifactRefresh]
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @fromDate DATETIME;
	SET @fromDate= DATEADD(DAY, -7, GETDATE());
	DELETE a FROM artifacts AS a JOIN artifacttypes AS t ON t.id=a.artifacttype WHERE t.persistent=1 AND a.missionguid IS NULL AND a.created < @fromDate;
END

GO
------------------------------------------------------------
PRINT N'npcs_create_iztable_modify_npcpresence__2020_03_10';
USE [perpetuumsa]
GO
IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[npcpresence]') 
         AND name = 'izgroupid'
)
BEGIN
	ALTER TABLE [dbo].[npcpresence]
	  ADD izgroupid INT NULL;
END

DROP TABLE IF EXISTS dbo.npcinterzonegroup;

CREATE TABLE dbo.npcinterzonegroup (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	name VARCHAR(64) NOT NULL,
	respawnTime int NOT NULL DEFAULT 86400,
	respawnNoiseFactor float NOT NULL DEFAULT 0.15
);
GO
------------------------------------------------------------

PRINT N'Entitydefaults__update_ChassisScanners__2020_03_21';
USE [perpetuumsa]
GO

----------------------------------------------------------------
--Make Chassis Scanners offsensive module (pvp flag to use)
--Updates entitydefaults.attributeflags
--Date: 2020/03/21
----------------------------------------------------------------

PRINT N'UPDATING CHASSIS SCANNER TO BE OFFSENSIVE MODULE';
DECLARE @offset bigint;
SET @offset = (SELECT offset FROM attributeFlags WHERE name='offensive_module');

DECLARE @category bigint;
SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_chassis_scanner');

PRINT N'ENTITY DEFS TO BE UPDATED';
SELECT * FROM entitydefaults WHERE categoryflags=@category;

PRINT N'UPDATE ATTR FLAGS';
UPDATE entitydefaults SET
	attributeflags = attributeflags | POWER(2, @offset)
WHERE categoryflags=@category;

PRINT N'UPDATED ENTITY DEFS';
SELECT * FROM entitydefaults WHERE categoryflags=@category;

PRINT N'DONE WITH CHASSIS SCANNER FLAG UPDATE';
GO
------------------------------------------------------------

------------------------------------------------------------

PRINT N'Entitydefaults_insert_mob_tele_strnghld__2020_04_03';
USE [perpetuumsa]
GO

------------------------------------------------------------------
--Stronghold teleporter item definitions
--Adds or updates entitydefaults
--Date modified: 2020/04/03
------------------------------------------------------------------


DECLARE @capsuleName VARCHAR(128);
DECLARE @fieldDevName VARCHAR(128);

SET @capsuleName = 'def_mobile_teleport_stronghold_capsule';
SET @fieldDevName = 'def_mobile_teleport_stronghold_basic';

IF NOT EXISTS (SELECT definition FROM entitydefaults WHERE definitionname=@capsuleName)
BEGIN
	INSERT INTO [dbo].[entitydefaults] ([definitionname],[quantity],[attributeflags],[categoryflags],[options],[note],[enabled],[volume],[mass],[hidden],[health],[descriptiontoken],[purchasable],[tiertype],[tierlevel]) VALUES
	(@capsuleName,1,25167872,131480,'','Stronghold teleport capsule',1,4,8000,0,100,'def_mobile_teleport_stronghold_capsule_desc',1,0,0);
END
ELSE
BEGIN
	UPDATE entitydefaults SET
		attributeflags = 25167872,
		categoryflags = 131480,
		note = 'Stronghold teleport capsule',
		volume = 4,
		mass = 8000
	WHERE definitionname=@capsuleName;
END

IF NOT EXISTS (SELECT definition FROM entitydefaults WHERE definitionname=@fieldDevName)
BEGIN
INSERT INTO [dbo].[entitydefaults] ([definitionname],[quantity],[attributeflags],[categoryflags],[options],[note],[enabled],[volume],[mass],[hidden],[health],[descriptiontoken],[purchasable],[tiertype],[tierlevel]) VALUES
(@fieldDevName,1,12583936,33948280,'','Stronghold teleport field obj',1,4,8000,0,100,'def_mobile_teleport_stronghold_basic_desc',0,0,0);
END
ELSE
BEGIN
	UPDATE entitydefaults SET
		attributeflags = 12583936,
		categoryflags = 33948280,
		note = 'Stronghold teleport field ob',
		volume = 4,
		mass = 8000
	WHERE definitionname=@fieldDevName;
END


IF NOT EXISTS (SELECT definition FROM definitionconfig WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = @capsuleName))
BEGIN
	INSERT INTO definitionconfig (definition, targetdefinition, action_delay, note) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = @capsuleName), 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = @fieldDevName), 
	120000, 
	'Stronghold mobile teleport mapping');
END
ELSE
BEGIN
	UPDATE definitionconfig SET
		action_delay=120000
	WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = @capsuleName);
END

PRINT N'ADD mobile teleport to itemshop';
DECLARE @tmShops INT;
DECLARE @strongholdTeleDef INT;
SET @strongholdTeleDef = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = @capsuleName);

SET @tmShops = (SELECT TOP 1 id FROM itemshoppresets WHERE name='tm_preset_pve');

IF NOT EXISTS (SELECT [targetdefinition] FROM [itemshop] WHERE [targetdefinition]=@strongholdTeleDef)
BEGIN
INSERT INTO [dbo].[itemshop]
           ([presetid],[targetdefinition],[targetamount],[tmcoin],[icscoin],[asicoin],[credit],[unicoin],[globallimit],[purchasecount],[standing])
     VALUES
		   (@tmShops,@strongholdTeleDef,1,100,100,100,1000000,100,NULL,0,1);
END
ELSE
BEGIN
	UPDATE [dbo].[itemshop] SET
		tmcoin=100,
		icscoin=100,
		asicoin=100,
		credit=1000000,
		unicoin=100,
		standing=1
	WHERE presetid=@tmShops AND targetdefinition=@strongholdTeleDef;
END

GO



------------------------------------------------------------------
PRINT N'Zoneentity_insert_strnghld_tele_col__2020_04_03';
USE [perpetuumsa]
GO

------------------------------------------------------------------
--Add teleport column to Omega (stronghold zone)
--Adds or updates zoneentities
--Date modified: 2020/04/03
------------------------------------------------------------------

DECLARE @targetZoneID int;
SET @targetZoneID = (SELECT TOP 1 id FROM zones WHERE name='zone_pvp_arena' AND zonetype=4);

DECLARE @ename VARCHAR(128);
SET @ename = 'tp_zone_strnghld_01';

DECLARE @parentEntity bigint;
SET @parentEntity = (SELECT TOP 1 eid from entitystorage where storage_name='teleport_column');

DECLARE @eid bigint;
SET @eid = 50000;

IF NOT EXISTS (SELECT eid FROM entities WHERE ename=@ename)
BEGIN
	INSERT INTO entities (eid, definition, owner, parent, health, ename, quantity, repackaged, dynprop) VALUES
	(@eid, 1394, NULL, @parentEntity, 100, @ename, 1, 0, '#enabled=i1');
END
ELSE
BEGIN
	UPDATE entities SET
		eid=@eid,
		definition=1394,
		parent=@parentEntity,
		health=100,
		quantity=1,
		repackaged=0,
		dynprop='#enabled=i1'
	WHERE ename=@ename;
END


IF NOT EXISTS (SELECT eid FROM zoneentities WHERE ename=@ename)
BEGIN
	INSERT INTO zoneentities (zoneID, eid, definition, owner, ename, x, y, z, orientation, enabled, note, runtime, synckey) VALUES 
	(@targetZoneID, @eid, NULL, NULL, @ename, 1108, 1048, 50, 128, 1, 'stronghold teleport 1', 0, 'tp_strnghld_01');
END
ELSE
BEGIN
	UPDATE zoneentities SET
		zoneID = @targetZoneID,
		eid=@eid,
		x = 1108,
		y = 1048,
		z = 50,
		orientation = 128,
		enabled = 1,
		note = 'stronghold teleport 1',
		runtime = 0,
		synckey = 'tp_strnghld_01'
	WHERE ename=@ename;
END

GO

------------------------------------------------------------------


------------------------------------------------------------------
PRINT N'NPC_beta1_pbosses__2020_04_07';
USE [perpetuumsa]
GO

----------------------------------------------------------
--Beta 1 Interzone Pitboss spawns
--Adds npc, izgroup, and 3 presences of the iz roaming type
--Date modified: 2020/04/09
----------------------------------------------------------

DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
DECLARE @templateID int;
DECLARE @flockID int;
DECLARE @presenceID int;
DECLARE @lootdefinitionID int;
DECLARE @npclootID int;

--Duration between IZ presence respawn
DECLARE @respawnSeconds int;
SET @respawnSeconds = (3*24*60*60);

--Duration of presence to last on a zone
DECLARE @durationSpawned int;
SET @durationSpawned = (2*24*60*60);

--BETA 1 PITBOSS: STATS
DROP TABLE IF EXISTS #NPCSTATS;
CREATE TABLE #NPCSTATS (
	fieldName VARCHAR(64) NOT NULL,
	value float NOT NULL,
);

INSERT INTO #NPCSTATS (fieldName, value) VALUES
('armor_max_modifier', 8.5),
('armor_repair_amount_modifier', 12.5),
('armor_repair_cycle_time_modifier', 0.95),
('core_max_modifier', 15),
('core_recharge_time_modifier', 0.9),
('cpu_max_modifier', 2.6),
('critical_hit_chance_modifier', 0.2),
('damage_modifier', 3.1),
('detection_strength_modifier',	25),
('ecm_strength_modifier', 2.1),
('falloff_modifier', 1.6),
('locking_range_modifier', 1.6),
('locking_time_modifier', 0.95),
('missile_cycle_time_modifier', 0.85),
('optimal_range_modifier', 4.1),
('powergrid_max_modifier', 2.1),
('resist_chemical', 300),
('resist_explosive', 300),
('resist_kinetic', 300),
('resist_thermal', 300),
('speed_max_modifier', 0.9),
('turret_cycle_time_modifier', 0.85),
('received_repaired_modifier', 10),
('sensor_strength_modifier', 15),
('stealth_strength_modifier', -50);


--BETA 1 PITBOSS:LOOT
DROP TABLE IF EXISTS #NPCLOOTS;
CREATE TABLE #NPCLOOTS (
	defName VARCHAR(100) NOT NULL,
	probability float NOT NULL,
	minQuantity int NOT NULL,
	maxQuantity int NOT NULL,
	dontDmg bit NOT NULL,
	repackaged bit NOT NULL,
);

INSERT INTO #NPCLOOTS (defName, probability, minQuantity, maxQuantity, dontDmg, repackaged) VALUES
('def_common_reactor_plasma', 1.0, 80000, 120000, 1, 1),
('def_pelistal_reactor_plasma', 1.0, 80000, 120000, 1, 1),
('def_nuimqol_reactor_plasma', 1.0, 80000, 120000, 1, 1),
('def_thelodica_reactor_plasma', 1.0, 80000, 120000, 1, 1),
('def_kernel_pelistal', 1.0, 50000, 75000, 1, 1),
('def_kernel_thelodica', 1.0, 50000, 75000, 1, 1),
('def_kernel_nuimqol', 1.0, 50000, 75000, 1, 1),
('def_kernel_common', 1.0, 50000, 75000, 1, 1),
('def_kernel_hitech', 1.0, 10000, 11000, 1, 1),
('def_robotshard_common_basic', 1.0, 500, 700, 1, 1),
('def_robotshard_common_advanced', 1.0, 500, 700, 1, 1),
('def_robotshard_common_expert', 1.0, 500, 700, 1, 1),
('def_robotshard_nuimqol_basic', 1.0, 500, 700, 1, 1),
('def_robotshard_nuimqol_advanced', 1.0, 500, 700, 1, 1),
('def_robotshard_nuimqol_expert', 1.0, 500, 700, 1, 1),
('def_robotshard_pelistal_basic', 1.0, 500, 700, 1, 1),
('def_robotshard_pelistal_advanced', 1.0, 500, 700, 1, 1),
('def_robotshard_pelistal_expert', 1.0, 500, 700, 1, 1),
('def_robotshard_thelodica_basic', 1.0, 500, 700, 1, 1),
('def_robotshard_thelodica_advanced', 1.0, 500, 700, 1, 1),
('def_robotshard_thelodica_expert', 1.0, 500, 700, 1, 1),
('def_research_kit_9', 1.0, 2, 5, 1, 1),
('def_research_kit_10', 1.0, 2, 5, 1, 1),
('def_boost_ep_t0', 1.0, 1, 2, 1, 1),
('def_boost_ep_t1', 0.5, 1, 1, 1, 1),
('def_reactore_core_runner', 1.0, 1, 2, 1, 1),
('def_reactore_core_assault', 1.0, 1, 2, 1, 1),
('def_reactore_core_mech', 1.0, 1, 2, 1, 1),
('def_reactore_core_heavymech', 1.0, 1, 2, 1, 1),
('def_scarab_mk2_A_CT_capsule', 0.25, 1, 1, 1, 1),
('def_gropho_mk2_A_CT_capsule', 0.25, 1, 1, 1, 1),
('def_mesmer_mk2_A_CT_capsule', 0.25, 1, 1, 1, 1),
('def_seth_mk2_A_CT_capsule', 0.25, 1, 1, 1, 1),
('def_named2_gang_assist_speed_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_information_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_industry_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_siege_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_defense_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_ewar_range_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_shared_dataprocessing_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_coordinated_maneuvering_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_maintance_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_precision_firing_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_core_management_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_fast_extraction_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_shield_calculation_module', 0.11, 1, 1, 0, 1);


---Beta 1 Pit Boss
PRINT N'BETA 1 PITBOSS: DEFINE NPC';
DECLARE @bossDefName VARCHAR(100);
SET @bossDefName = 'def_npc_beta1_pitboss';
IF NOT EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@bossDefName)
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
		VALUES 
	(@bossDefName, 1, 1024, 911, '', '', 1, 0, 0, 0, 100, CONCAT(@bossDefName, '_desc'), 0, 0, 0);
END


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = @bossDefName ORDER BY definition DESC);

PRINT N'BETA 1 PITBOSS: Define color!';
IF NOT EXISTS (SELECT TOP 1 definition FROM definitionconfig WHERE definition=@definitionID)
BEGIN
	INSERT INTO [dbo].[definitionconfig] (definition, tint) VALUES
	(@definitionID, '#960d00');
END
ELSE
BEGIN
	UPDATE [dbo].[definitionconfig] SET
		tint = '#960d00'
	WHERE definition=@definitionID;
END


PRINT N'BETA 1 PITBOSS: NPC TEMPLATE';
DECLARE @templateName VARCHAR(100);
SET @templateName = CONCAT(@bossDefName, '_template');
DECLARE @template VARCHAR(max);
SET @template = '#robot=ibdf#head=ibc9#chassis=ibd6#leg=ibd7#container=i14c#headModules=[|m0=[|definition=ib1e|slot=i1|ammoDefinition=ib33|ammoQuantity=i5]|m1=[|definition=i2b|slot=i2]|m2=[|definition=i31|slot=i3]|m3=[|definition=i34|slot=i4]|m4=[|definition=i32|slot=i5]|m5=[|definition=i33|slot=i6]]#chassisModules=[|m0=[|definition=i3a|slot=i1|ammoDefinition=i98b|ammoQuantity=if]|m1=[|definition=i40|slot=i2|ammoDefinition=i992|ammoQuantity=if]|m2=[|definition=i43|slot=i3|ammoDefinition=i983|ammoQuantity=if]|m3=[|definition=i3a|slot=i4|ammoDefinition=i98c|ammoQuantity=if]|m4=[|definition=i40|slot=i5|ammoDefinition=i991|ammoQuantity=if]|m5=[|definition=i43|slot=i6|ammoDefinition=i982|ammoQuantity=if]|m6=[|definition=i0|slot=i7]]#legModules=[|m0=[|definition=i10|slot=i1]|m1=[|definition=i13|slot=i2]|m2=[|definition=i13|slot=i3]|m3=[|definition=i3b7|slot=i4]|m4=[|definition=i11e0|slot=i5]|m5=[|definition=i1d|slot=i6]]';
IF NOT EXISTS (SELECT TOP 1 id FROM robottemplates WHERE [name]=@templateName)
BEGIN
	INSERT INTO robottemplates ([name], [description], [note])
	VALUES (@templateName, @template, 'Pitboss for beta1s');

	SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = @templateName ORDER BY id DESC);

	PRINT N'BETA 1 PITBOSS: TEMPLATE RELATION';
	INSERT INTO [dbo].[robottemplaterelation] ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
	VALUES (@definitionID,@templateID,0,0,NULL,NULL,1500,'Beta1 PitBoss');
END
ELSE
BEGIN
	UPDATE robottemplates SET
		description = @template
	WHERE name=@templateName;

	SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = @templateName ORDER BY id DESC);

	UPDATE [dbo].[robottemplaterelation] SET
		templateid = @templateID,
		itemscoresum = 0,
		raceid = 0,
		missionlevel = NULL,
		missionleveloverride = NULL,
		killep = 1500,
		note = 'Beta1 PitBoss'
	WHERE definition = @definitionID;
END

PRINT N'BETA 1 PITBOSS: STATS';
PRINT N'Delete old stats';
DELETE FROM [dbo].[aggregatevalues] WHERE definition=@definitionID;
PRINT N'Insert all stats';
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value])
SELECT @definitionID, (SELECT TOP 1 id FROM aggregatefields WHERE name=fieldName), value FROM #NPCSTATS;

PRINT N'BETA 1 PITBOSS:LOOT';
PRINT N'Delete old loot';
DELETE FROM npcloot WHERE definition=@definitionID;
PRINT N'Add loot';
INSERT INTO npcloot ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity])
SELECT @definitionID, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defName), maxQuantity, probability, repackaged, dontDmg, minQuantity FROM #NPCLOOTS;

PRINT N'BETA 1 PITBOSS DEFINED!';

PRINT N'BETA 1 PITBOSSES INTERZONE SPAWN CONFIGURATIONS';
DECLARE @izGroupName VARCHAR(64);
DECLARE @izGroupID INT;
SET @izGroupName = 'beta1_pitboss_izgrp';

IF NOT EXISTS (SELECT TOP 1 id FROM [npcinterzonegroup] WHERE name=@izGroupName)
BEGIN
	INSERT INTO [dbo].[npcinterzonegroup] ([name],[respawnTime],[respawnNoiseFactor]) VALUES
	(@izGroupName, @respawnSeconds, 0.15);
END
ELSE
BEGIN
	UPDATE [dbo].[npcinterzonegroup] SET
		[respawnTime] = @respawnSeconds,
		[respawnNoiseFactor] =  0.15
	WHERE name=@izGroupName;
END


SET @izGroupID = (SELECT TOP 1 id FROM [dbo].[npcinterzonegroup] WHERE name=@izGroupName);

DECLARE @presenceNameNorhoop VARCHAR(128);
SET @presenceNameNorhoop = 'Presence_NPC_Norhoop_PitBoss';
DECLARE @presenceNameHokk VARCHAR(128);
SET @presenceNameHokk = 'Presence_NPC_Hokkogaros_PitBoss';
DECLARE @presenceNameDom VARCHAR(128);
SET @presenceNameDom = 'Presence_NPC_Domhalarn_PitBoss';


PRINT N'NORHOOP PRESENCE';
IF NOT EXISTS (SELECT TOP 1 id FROM [dbo].[npcpresence] WHERE name=@presenceNameNorhoop)
BEGIN
	INSERT INTO [dbo].[npcpresence]
			   ([name],[topx],[topy],[bottomx],[bottomy],[note],
			   [spawnid],[enabled],[roaming],[roamingrespawnseconds],
			   [presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],
			   [dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull],[izgroupid])
		 VALUES
			   (@presenceNameNorhoop,10,10,2030,2030,'Norhoop Pitboss presence',
			   (SELECT TOP 1 spawnid FROM zones WHERE note='norhoop' AND id=5),1,1,@respawnSeconds+@durationSpawned,
			   8,0,0,1,0,
			   @durationSpawned,0,0,0,@izGroupID);
END
ELSE
BEGIN
	UPDATE [dbo].[npcpresence] SET
		enabled = 1,
		spawnid = (SELECT TOP 1 spawnid FROM zones WHERE note='norhoop' AND id=5),
		presencetype=8,
		roaming = 1,
		roamingrespawnseconds=@respawnSeconds+@durationSpawned,
		dynamiclifetime = @durationSpawned,
		izgroupid = @izGroupID
	WHERE name = @presenceNameNorhoop;
END

PRINT N'HOKK PRESENCE';
IF NOT EXISTS (SELECT TOP 1 id FROM [dbo].[npcpresence] WHERE name=@presenceNameHokk)
BEGIN
	INSERT INTO [dbo].[npcpresence]
			   ([name],[topx],[topy],[bottomx],[bottomy],[note],
			   [spawnid],[enabled],[roaming],[roamingrespawnseconds],
			   [presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],
			   [dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull],[izgroupid])
		 VALUES
			   (@presenceNameHokk,10,10,2030,2030,'Hokkogaros Pitboss presence',
			   (SELECT TOP 1 spawnid FROM zones WHERE note='hokkogaros' AND id=4),1,1,@respawnSeconds+@durationSpawned,
			   8,0,0,1,0,
			   @durationSpawned,0,0,0,@izGroupID);
END
ELSE
BEGIN
	UPDATE [dbo].[npcpresence] SET
		enabled = 1,
		spawnid = (SELECT TOP 1 spawnid FROM zones WHERE note='hokkogaros' AND id=4),
		presencetype=8,
		roaming = 1,
		roamingrespawnseconds=@respawnSeconds+@durationSpawned,
		dynamiclifetime = @durationSpawned,
		izgroupid = @izGroupID
	WHERE name = @presenceNameHokk;
END

PRINT N'DOM PRESENCE';
IF NOT EXISTS (SELECT TOP 1 id FROM [dbo].[npcpresence] WHERE name=@presenceNameDom)
BEGIN
	INSERT INTO [dbo].[npcpresence]
			   ([name],[topx],[topy],[bottomx],[bottomy],[note],
			   [spawnid],[enabled],[roaming],[roamingrespawnseconds],
			   [presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],
			   [dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull],[izgroupid])
		 VALUES
			   (@presenceNameDom,10,10,2030,2030,'Domhalarn Pitboss presence',
			   (SELECT TOP 1 spawnid FROM zones WHERE note='domhalarn' AND id=3),1,1,@respawnSeconds+@durationSpawned,
			   8,0,0,1,0,
			   @durationSpawned,0,0,0,@izGroupID);
END
ELSE
BEGIN
	UPDATE [dbo].[npcpresence] SET
		enabled = 1,
		spawnid = (SELECT TOP 1 spawnid FROM zones WHERE note='domhalarn' AND id=3),
		presencetype=8,
		roaming = 1,
		roamingrespawnseconds=@respawnSeconds+@durationSpawned,
		dynamiclifetime = @durationSpawned,
		izgroupid = @izGroupID
	WHERE name = @presenceNameDom;
END

DECLARE @flockName VARCHAR(128);


PRINT N'SETUP BOSS FLOCK FOR NORHOOP PRESENCE';
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = @presenceNameNorhoop ORDER BY id DESC);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = @bossDefName ORDER BY definition DESC);
SET @flockName = 'Norhoop_Pitboss_flock_boss';


IF NOT EXISTS (SELECT TOP 1 id FROM [dbo].[npcflock] WHERE name=@flockName)
BEGIN
	INSERT INTO [dbo].[npcflock]
			   ([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax]
			   ,[respawnseconds],[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType],[npcSpecialType])
		 VALUES
			   (@flockName,@presenceID,1,@definitionID,950,1265,1,9,@respawnSeconds+@durationSpawned,0,50,@flockName,1,1,1,1,1);

	SET @flockID = (SELECT TOP 1 id FROM npcflock WHERE name=@flockName);
	INSERT INTO [dbo].[npcbossinfo]
			   ([flockid],[respawnNoiseFactor],[lootSplitFlag],[outpostEID],[stabilityPts],[overrideRelations],[customDeathMessage],[customAggressMessage])
		 VALUES
			   (@flockID,0.1,1,NULL,NULL,0,'You have not seen the last of us, Human','For Nia!');
END
ELSE
BEGIN
	UPDATE [dbo].[npcflock] SET
		spawnoriginX = 950,
		spawnoriginY = 1265,
		spawnrangeMin = 1,
		spawnrangeMax = 9,
		enabled = 1,
		flockmembercount = 1,
		respawnseconds = @respawnSeconds+@durationSpawned,
		totalspawncount = 0,
		homerange = 50,
		note = @flockName,
		npcSpecialType = 1
	WHERE presenceid = @presenceID AND definition = @definitionID AND name = @flockName;

	SET @flockID = (SELECT TOP 1 id FROM npcflock WHERE name=@flockName);

	UPDATE [dbo].[npcbossinfo] SET
		[respawnNoiseFactor] = 0.1,
		[lootSplitFlag] = 1,
		[outpostEID] = NULL,
		[stabilityPts] = NULL,
		[overrideRelations] = 0,
		[customDeathMessage] = 'You have not seen the last of us, Human',
		[customAggressMessage] = 'For Nia!'
    WHERE [flockid] = @flockID;
END




PRINT N'SETUP BOSS FLOCK FOR HOKKOGAROS PRESENCE';
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = @presenceNameHokk ORDER BY id DESC);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = @bossDefName ORDER BY definition DESC);
SET @flockName = 'Hokkogaros_Pitboss_flock_boss';


IF NOT EXISTS (SELECT TOP 1 id FROM [dbo].[npcflock] WHERE name=@flockName)
BEGIN
	INSERT INTO [dbo].[npcflock]
			   ([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax]
			   ,[respawnseconds],[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType],[npcSpecialType])
		 VALUES
			   (@flockName,@presenceID,1,@definitionID,1130,1320,1,9,@respawnSeconds+@durationSpawned,0,50,@flockName,1,1,1,1,1);

	SET @flockID = (SELECT TOP 1 id FROM npcflock WHERE name=@flockName);
	INSERT INTO [dbo].[npcbossinfo]
			   ([flockid],[respawnNoiseFactor],[lootSplitFlag],[outpostEID],[stabilityPts],[overrideRelations],[customDeathMessage],[customAggressMessage])
		 VALUES
			   (@flockID,0.1,1,NULL,NULL,0,'You have not seen the last of us, Human','For Nia!');
END
ELSE
BEGIN
	UPDATE [dbo].[npcflock] SET
		spawnoriginX = 1130,
		spawnoriginY = 1320,
		spawnrangeMin = 1,
		spawnrangeMax = 9,
		enabled = 1,
		flockmembercount = 1,
		respawnseconds = @respawnSeconds+@durationSpawned,
		totalspawncount = 0,
		homerange = 50,
		note = @flockName,
		npcSpecialType = 1
	WHERE presenceid = @presenceID AND definition = @definitionID AND name = @flockName;

	SET @flockID = (SELECT TOP 1 id FROM npcflock WHERE name=@flockName);

	UPDATE [dbo].[npcbossinfo] SET
		[respawnNoiseFactor] = 0.1,
		[lootSplitFlag] = 1,
		[outpostEID] = NULL,
		[stabilityPts] = NULL,
		[overrideRelations] = 0,
		[customDeathMessage] = 'You have not seen the last of us, Human',
		[customAggressMessage] = 'For Nia!'
    WHERE [flockid] = @flockID;
END


PRINT N'SETUP BOSS FLOCK FOR DOMHALARN PRESENCE';
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = @presenceNameDom ORDER BY id DESC);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = @bossDefName ORDER BY definition DESC);
SET @flockName = 'Domhalarn_Pitboss_flock_boss';


IF NOT EXISTS (SELECT TOP 1 id FROM [dbo].[npcflock] WHERE name=@flockName)
BEGIN
	INSERT INTO [dbo].[npcflock]
			   ([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax]
			   ,[respawnseconds],[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType],[npcSpecialType])
		 VALUES
			   (@flockName,@presenceID,1,@definitionID,585,1090,1,9,@respawnSeconds+@durationSpawned,0,50,@flockName,1,1,1,1,1);

	SET @flockID = (SELECT TOP 1 id FROM npcflock WHERE name=@flockName);
	INSERT INTO [dbo].[npcbossinfo]
			   ([flockid],[respawnNoiseFactor],[lootSplitFlag],[outpostEID],[stabilityPts],[overrideRelations],[customDeathMessage],[customAggressMessage])
		 VALUES
			   (@flockID,0.1,1,NULL,NULL,0,'You have not seen the last of us, Human','For Nia!');
END
ELSE
BEGIN
	UPDATE [dbo].[npcflock] SET
		spawnoriginX = 585,
		spawnoriginY = 1090,
		spawnrangeMin = 1,
		spawnrangeMax = 9,
		enabled = 1,
		flockmembercount = 1,
		respawnseconds = @respawnSeconds+@durationSpawned,
		totalspawncount = 0,
		homerange = 50,
		note = @flockName,
		npcSpecialType = 1
	WHERE presenceid = @presenceID AND definition = @definitionID AND name = @flockName;

	SET @flockID = (SELECT TOP 1 id FROM npcflock WHERE name=@flockName);

	UPDATE [dbo].[npcbossinfo] SET
		[respawnNoiseFactor] = 0.1,
		[lootSplitFlag] = 1,
		[outpostEID] = NULL,
		[stabilityPts] = NULL,
		[overrideRelations] = 0,
		[customDeathMessage] = 'You have not seen the last of us, Human',
		[customAggressMessage] = 'For Nia!'
    WHERE [flockid] = @flockID;
END

DROP TABLE IF EXISTS #NPCSTATS;
DROP TABLE IF EXISTS #NPCLOOTS;
PRINT N'BETA 1 PITBOSS AND IZPRESENCES DEFINED!';
PRINT N'DONE!';
GO
------------------------------------------------------------------


------------------------------------------------------------------
PRINT N'Anniversarkhe_and_gifts_year2__2020_04_07';

USE [perpetuumsa]
GO

-----------------------------------------------
--OPP 2 Year of LIVE server anniversary gifts!
--New robot definition
--New Package and gifts
--Procedure call to distribute gifts
--Date: 2020/04/07
-----------------------------------------------

DECLARE @botName VARCHAR(100);
SET @botName = 'def_anniversarkhe_year2_bot';


PRINT N'1. Create entity';
--WARNING: options string contains references to entitydefaults in hex (Head/leg/chassis are fixed definitions from arkhe mk2)
--ENTITYDEFAULT SAVE NEW
INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled,  volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
VALUES (@botName, 1, 0, 257, '#head=iae8#chassis=iae9#leg=iaea#container=i147#tier=$tierlevel_mk2', 'New Arkhe for 2yr aniversary!', 1, 12, 0, 0, 100, CONCAT(@botName, '_desc'), 1, 1, 2); 


PRINT N'2. Create template (from tool)';
--WARNING: description string contains references to entitydefaults in hex
--TEMPLATE INSERT

DECLARE @definitionHex varchar;
--This is how to do lookups, convert to hex, and concat into a genxy compatible string!
SET @definitionHex = (SELECT dbo.ToHex(definition) FROM entitydefaults WHERE definitionname=@botName);

INSERT INTO robottemplates ([name], [description], [note]) 
VALUES (CONCAT(@botName, '_template'), '#robot=i'+@definitionHex+'#head=iae8#chassis=iae9#leg=iaea#container=i147#headModules=[|m0=[|definition=i0|slot=i1]]#chassisModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]]#legModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]]', 'OPP Live 2 year anniversary Reward');


PRINT N'3. Create templaterelation';
INSERT INTO [dbo].[robottemplaterelation]
           ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
     VALUES
           ((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@botName)
           ,(SELECT TOP 1 id FROM robottemplates WHERE name=CONCAT(@botName, '_template')),0,1,NULL,NULL,NULL,'AnniversArkhe Template Relation year2');


PRINT N'4. Insert config w/ desired tint';
INSERT INTO [dbo].[definitionconfig]
           ([definition],[tint],[note])
     VALUES
           ((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@botName)
           ,'#ffaa00'
           ,'Color for AnniversArkhe2 bot');


PRINT N'5. Give bot skills -- ARKHE MK2 HAS NO ENABLER SKILLS RESULT WILL BE 0 rows affected';
--Use existing bot (that was copied from entitydefault) for extensions
INSERT INTO [dbo].[enablerextensions] ([definition],[extensionid],[extensionlevel])
     (SELECT (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@botName), extensionid, extensionlevel FROM enablerextensions WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_arkhe2_bot'));

PRINT N'Create Packages for pre-alpha participant levels';
INSERT INTO [dbo].[packages]
           ([name],[note])
     VALUES
           ('opp-anniversary02','2nd year of OPP Live!');

PRINT N'Insert items into Packages for pre-alpha participant levels';
DECLARE @packid int;
SET @packid = (SELECT TOP 1 id FROM packages WHERE name='opp-anniversary02');

DECLARE @aid int;
SET @aid = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_anniversary_package');

DECLARE @specialBot int;
SET @specialBot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@botName);

DECLARE @epBoostT2 int;
SET @epBoostT2 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_boost_ep_t2');

PRINT N'Items for opp-anniversary02!!!';
INSERT INTO [dbo].[packageitems]
           ([packageid],[definition],[quantity])
     VALUES
           (@packid, @aid, 2), 
		   (@packid, @specialBot, 1),
		   (@packid, @epBoostT2, 1);

GO



DECLARE @packid int;
SET @packid = (SELECT TOP 1 id FROM packages WHERE name='opp-anniversary02');
--TODO use variant of below for future gifting
--This gift gives to all current accounts at patch-time
PRINT N'Give everyone a gift! WARNING CURSOR AHEAD!';
DECLARE @id int;
DECLARE @pass varchar(100);

DECLARE curse CURSOR FOR SELECT accountID FROM accounts
OPEN curse

FETCH NEXT FROM curse INTO @id

WHILE @@FETCH_STATUS = 0 BEGIN
    EXEC dbo.accountPackageProcessOne @id, @packid
    FETCH NEXT FROM curse INTO @id
END

CLOSE curse    
DEALLOCATE curse

GO
------------------------------------------------------------------

PRINT N'PATCH 16 APPLIED!';
GO