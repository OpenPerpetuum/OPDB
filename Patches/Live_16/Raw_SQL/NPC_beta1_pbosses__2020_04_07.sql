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
('armor_max_modifier', 9.5),
('armor_repair_amount_modifier', 12.5),
('armor_repair_cycle_time_modifier', 0.95),
('core_max_modifier', 15),
('core_recharge_time_modifier', 0.85),
('cpu_max_modifier', 2.6),
('critical_hit_chance_modifier', 0.2),
('damage_modifier', 4.1),
('detection_strength_modifier',	25),
('ecm_strength_modifier', 2.1),
('falloff_modifier', 1.6),
('locking_range_modifier', 1.6),
('locking_time_modifier', 0.95),
('missile_cycle_time_modifier', 0.85),
('optimal_range_modifier', 4.1),
('powergrid_max_modifier', 2.1),
('resist_chemical', 900),
('resist_explosive', 900),
('resist_kinetic', 900),
('resist_thermal', 900),
('speed_max_modifier', 0.9),
('turret_cycle_time_modifier', 0.85),
('received_repaired_modifier', 10),
('sensor_strength_modifier', 115),
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