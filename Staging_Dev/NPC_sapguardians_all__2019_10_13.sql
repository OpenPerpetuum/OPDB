USE [perpetuumsa]
GO

----------------------------------------------------------
--NPC SAP Gaurdians (and invaders)
--Sets/Resets all the necesary bits for these special npc bosses
--
--Last modified: 2019/10/13
----------------------------------------------------------

PRINT N'BEGIN - SAP GUARDIAN CONFIGURATION';
PRINT N'Robottemplate';
DECLARE @templateName VARCHAR(50);
SET @templateName='SAP Gaurdian';

IF NOT EXISTS (SELECT TOP 1 id FROM robottemplates WHERE name=@templateName)
BEGIN
	PRINT N'INSERT robottemplate';
	INSERT INTO robottemplates (name, description, note) VALUES
	(@templateName,
	'#robot=ibbd#head=ibc9#chassis=ibb5#leg=ibd1#container=i14a#headModules=[|m0=[|definition=i31|slot=i1]|m1=[|definition=i32|slot=i2]|m2=[|definition=i33|slot=i3]|m3=[|definition=i34|slot=i4]|m4=[|definition=i34|slot=i5]|m5=[|definition=i1f|slot=i6]]#chassisModules=[|m0=[|definition=i27|slot=i1]|m1=[|definition=i3a|slot=i2|ammoDefinition=i98b|ammoQuantity=i19]|m2=[|definition=i3d|slot=i3|ammoDefinition=i986|ammoQuantity=i19]|m3=[|definition=i43|slot=i4|ammoDefinition=i982|ammoQuantity=i19]|m4=[|definition=i40|slot=i5|ammoDefinition=i991|ammoQuantity=i19]|m5=[|definition=i40|slot=i6|ammoDefinition=i992|ammoQuantity=i19]]#legModules=[|m0=[|definition=i1d|slot=i1]|m1=[|definition=i13|slot=i2]|m2=[|definition=i11e0|slot=i3]|m3=[|definition=i11e1|slot=i4]]',
	'The SAP guardian template, version 1.0');
END
ELSE 
BEGIN
	PRINT N'UPDATE robottemplate';
	UPDATE robottemplates
	SET description='#robot=ibbd#head=ibc9#chassis=ibb5#leg=ibd1#container=i14a#headModules=[|m0=[|definition=i31|slot=i1]|m1=[|definition=i32|slot=i2]|m2=[|definition=i33|slot=i3]|m3=[|definition=i34|slot=i4]|m4=[|definition=i34|slot=i5]|m5=[|definition=i1f|slot=i6]]#chassisModules=[|m0=[|definition=i27|slot=i1]|m1=[|definition=i3a|slot=i2|ammoDefinition=i98b|ammoQuantity=i19]|m2=[|definition=i3d|slot=i3|ammoDefinition=i986|ammoQuantity=i19]|m3=[|definition=i43|slot=i4|ammoDefinition=i982|ammoQuantity=i19]|m4=[|definition=i40|slot=i5|ammoDefinition=i991|ammoQuantity=i19]|m5=[|definition=i40|slot=i6|ammoDefinition=i992|ammoQuantity=i19]]#legModules=[|m0=[|definition=i1d|slot=i1]|m1=[|definition=i13|slot=i2]|m2=[|definition=i11e0|slot=i3]|m3=[|definition=i11e1|slot=i4]]'
	WHERE name=@templateName;
END

PRINT N'Setting up temp table of all npcs and their outpost mappings';
DROP TABLE IF EXISTS #SAPBOSSES
CREATE TABLE #SAPBOSSES
(
	zoneID int,
	outpostName varchar(128),
	x float,
	y float,
	npcName varchar(128),
	isGuard bit

)
DECLARE @lookupFlag bigint
SET @lookupFlag = (select value from dbo.categoryFlags where name='cf_outpost');
INSERT INTO #SAPBOSSES
SELECT zoneID, entities.ename, x, y, '', 0 from entities
join zoneentities on zoneentities.eid=entities.eid
where entities.definition in (select definition from entitydefaults 
where categoryflags & CAST(dbo.GetCFMask(@lookupFlag)as BIGINT) = @lookupFlag)

INSERT INTO #SAPBOSSES
SELECT zoneID, entities.ename, x, y, '', 1 from entities
join zoneentities on zoneentities.eid=entities.eid
where entities.definition in (select definition from entitydefaults 
where categoryflags & CAST(dbo.GetCFMask(@lookupFlag)as BIGINT) = @lookupFlag)


UPDATE #SAPBOSSES SET
npcName='def_npc_sap_guard_lao' WHERE isGuard=1 AND outpostName='outpost_asi_2_exp1';
UPDATE #SAPBOSSES SET
npcName='def_npc_sap_invade_lao' WHERE isGuard=0 AND outpostName='outpost_asi_2_exp1';
UPDATE #SAPBOSSES SET
npcName='def_npc_sap_guard_southi' WHERE isGuard=1 AND  outpostName='outpost_asi_1_exp1';
UPDATE #SAPBOSSES SET
npcName='def_npc_sap_invade_southi' WHERE isGuard=0 AND outpostName='outpost_asi_1_exp1';
UPDATE #SAPBOSSES SET
npcName='def_npc_sap_guard_nauwy' WHERE isGuard=1 AND outpostName='asi_outpost_s_06';
UPDATE #SAPBOSSES SET
npcName='def_npc_sap_invade_nauwy' WHERE isGuard=0 AND outpostName='asi_outpost_s_06';
UPDATE #SAPBOSSES SET
npcName='def_npc_sap_guard_abbu' WHERE isGuard=1 AND outpostName='asi_outpost_i_05';
UPDATE #SAPBOSSES SET
npcName='def_npc_sap_invade_abbu' WHERE isGuard=0 AND outpostName='asi_outpost_i_05';
UPDATE #SAPBOSSES SET
npcName='def_npc_sap_guard_darm' WHERE isGuard=1 AND outpostName='asi_outpost_w_04';
UPDATE #SAPBOSSES SET
npcName='def_npc_sap_invade_darm' WHERE isGuard=0 AND outpostName='asi_outpost_w_04';
UPDATE #SAPBOSSES SET
npcName='def_npc_sap_guard_dana' WHERE isGuard=1 AND outpostName='outpost_ics_2_exp1';
UPDATE #SAPBOSSES SET
npcName='def_npc_sap_invade_dana' WHERE isGuard=0 AND outpostName='outpost_ics_2_exp1';
UPDATE #SAPBOSSES SET
npcName='def_npc_sap_guard_newcrim' WHERE isGuard=1 AND outpostName='outpost_ics_1_exp1';
UPDATE #SAPBOSSES SET
npcName='def_npc_sap_invade_newcrim' WHERE isGuard=0 AND outpostName='outpost_ics_1_exp1';
UPDATE #SAPBOSSES SET
npcName='def_npc_sap_guard_koy' WHERE isGuard=1 AND outpostName='ics_outpost_s_06';
UPDATE #SAPBOSSES SET
npcName='def_npc_sap_invade_koy' WHERE isGuard=0 AND outpostName='ics_outpost_s_06';
UPDATE #SAPBOSSES SET
npcName='def_npc_sap_guard_hey' WHERE isGuard=1 AND outpostName='ics_outpost_i_05';
UPDATE #SAPBOSSES SET
npcName='def_npc_sap_invade_hey' WHERE isGuard=0 AND outpostName='ics_outpost_i_05';
UPDATE #SAPBOSSES SET
npcName='def_npc_sap_guard_moy' WHERE isGuard=1 AND outpostName='ics_outpost_w_04';
UPDATE #SAPBOSSES SET
npcName='def_npc_sap_invade_moy' WHERE isGuard=0 AND  outpostName='ics_outpost_w_04';
UPDATE #SAPBOSSES SET
npcName='def_npc_sap_guard_kara' WHERE isGuard=1 AND outpostName='tm_outpost_w_04';
UPDATE #SAPBOSSES SET
npcName='def_npc_sap_invade_kara' WHERE isGuard=0 AND outpostName='tm_outpost_w_04';
UPDATE #SAPBOSSES SET
npcName='def_npc_sap_guard_initia' WHERE isGuard=1 AND outpostName='tm_outpost_s_06';
UPDATE #SAPBOSSES SET
npcName='def_npc_sap_invade_initia' WHERE isGuard=0 AND outpostName='tm_outpost_s_06';
UPDATE #SAPBOSSES SET
npcName='def_npc_sap_guard_uria' WHERE isGuard=1 AND outpostName='tm_outpost_i_05';
UPDATE #SAPBOSSES SET
npcName='def_npc_sap_invade_uria' WHERE isGuard=0 AND outpostName='tm_outpost_i_05';
UPDATE #SAPBOSSES SET
npcName='def_npc_sap_guard_fortd' WHERE isGuard=1 AND outpostName='outpost_tm_1_exp1';
UPDATE #SAPBOSSES SET
npcName='def_npc_sap_invade_fortd' WHERE isGuard=0 AND outpostName='outpost_tm_1_exp1';
UPDATE #SAPBOSSES SET
npcName='def_npc_sap_guard_bstone' WHERE isGuard=1 AND outpostName='outpost_tm_2_exp1';
UPDATE #SAPBOSSES SET
npcName='def_npc_sap_invade_bstone' WHERE isGuard=0 AND outpostName='outpost_tm_2_exp1';

PRINT N'SAPBOSSES temp table Complete';
SELECT * from #SAPBOSSES
PRINT N'Begin configuration for each SAP npc';
DECLARE @name varchar(128);
DECLARE @x int;
DECLARE @y int;
DECLARE @zoneID int;
DECLARE @outpostName varchar(128);
DECLARE @isGaurd bit;

DECLARE db_cursor CURSOR FOR 
SELECT 	zoneID,outpostName,x,y,npcName,isGuard FROM #SAPBOSSES
OPEN db_cursor  
FETCH NEXT FROM db_cursor INTO  @zoneID,@outpostName,@x,@y,@name,@isGaurd

WHILE @@FETCH_STATUS = 0  
BEGIN  

	PRINT N'ENTITYDEF';
	IF NOT EXISTS (SELECT TOP 1 definition FROM [dbo].[entitydefaults] WHERE definitionname=@name)
	BEGIN
		PRINT N'Insert entitydefault SAP npc';
		INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
		VALUES (@name, 1, 1024, 911, '', 'SAP NPC definition', 1, 0, 0, 0, 100, 'def_npc_seth_heavydps_rank1_desc', 0, 0, 0);
	END
	ELSE
	BEGIN
		PRINT N'Update entitydefault SAP npc';
		UPDATE entitydefaults SET
			attributeflags=1024,
			categoryflags=911,
			options='',
			note='SAP NPC definition',
			enabled=1,
			volume=0,
			mass=0,
			hidden=0,
			health=100,
			descriptiontoken='def_npc_seth_heavydps_rank1_desc',
			purchasable=0,
			tierlevel=0,
			tiertype=0
		WHERE definitionname=@name;
	END

	DECLARE @spawnID int;
	SET @spawnID = (SELECT TOP 1 spawnid FROM zones WHERE id=@zoneID);

	DECLARE @outpostEID bigint;
	SET @outpostEID = (SELECT TOP 1 eid FROM entities WHERE ename=@outpostName);


	DECLARE @definitionID int;
	DECLARE @aggvalueID int;
	DECLARE @aggfieldID int;
	DECLARE @templateID int;
	DECLARE @lootdefinitionID int;
	DECLARE @npclootID int;
	DECLARE @presenceID int;
	DECLARE @flockID int;

	SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = @name ORDER BY definition DESC);
	SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'SAP Gaurdian' ORDER BY id DESC);

	--Set Template Relations
	PRINT N'[robottemplaterelation]';
	IF NOT EXISTS (SELECT TOP 1 definition FROM [dbo].[robottemplaterelation] WHERE definition=@definitionID)
	BEGIN
		PRINT N'INSERT [robottemplaterelation]';
		INSERT INTO [dbo].[robottemplaterelation] ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
		VALUES (@definitionID,@templateID,0,0,NULL,NULL,100,'SAP Gaurdian <->Sap gaurd template');
	END
	ELSE
	BEGIN
		PRINT N'UPDATE [robottemplaterelation]';
		UPDATE [robottemplaterelation] SET 
			templateid=@templateID,
			missionlevel=NULL,
			missionleveloverride=NULL,
			killep=100,
			note='SAP Gaurdian <->Sap gaurd template'
		WHERE definition=@definitionID;

	END

	--NPC Presence
	PRINT N'[npcpresence] - insert if not present, no further update necesary with iteration';
	IF NOT EXISTS (SELECT TOP 1 name FROM [dbo].[npcpresence] WHERE name=CONCAT(@name,'_SAP_PRESENCE'))
	BEGIN
	PRINT N'INSERT [npcpresence]';
		INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
					,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
					VALUES (CONCAT(@name,'_SAP_PRESENCE'),10,10,2030,2030,'ITS THE SAP GUARD',@spawnID,1,0,0,0,0,0,0,0,0,1,1,1);
	END

	SET @presenceID = (SELECT TOP 1 id FROM npcpresence WHERE name=CONCAT(@name,'_SAP_PRESENCE'));

	--NPC Flock
	PRINT N'[npcflock]';
	IF NOT EXISTS (SELECT TOP 1 name FROM [dbo].[npcflock] WHERE name=CONCAT(@name,'_SAP_FLOCK'))
	BEGIN
		PRINT N'INSERT [npcflock]';
		INSERT INTO [dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
						,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType],[npcSpecialType]) VALUES
						(CONCAT(@name,'_SAP_FLOCK'), @presenceID, 1, @definitionID, @x, @y, 3, 20, 21600, 0, 35, 'SAP GAURD', 0, 1, 1, 2, 1);
	END
	ELSE
	BEGIN
		PRINT N'UPDATE [npcflock]';
		UPDATE [dbo].[npcflock] SET
			presenceid=@presenceID,
			flockmembercount=1,
			definition=@definitionID,
			spawnoriginX=@x+1, 
			spawnoriginY=@y+1,
			spawnrangeMin=3,
			spawnrangeMax=20,
			respawnseconds=21600,
			homerange=35,
			behaviorType=1
		WHERE name=CONCAT(@name,'_SAP_FLOCK');
	END

	SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = CONCAT(@name,'_SAP_FLOCK') ORDER BY id DESC);

	--Guard/Invader specific settings and Bossinfo
	IF @isGaurd=1
	BEGIN
		PRINT N'UPDATE [npcflock] WITH GUARD PARAMS';
		UPDATE npcflock SET 
			spawnoriginX=@x+1, 
			spawnoriginY=@y+1,
			spawnrangeMin=3,
			spawnrangeMax=20,
			respawnseconds=180,
			homerange=35,
			behaviorType=1
		WHERE id=@flockID;

		PRINT N'[npcbossinfo]';
		IF NOT EXISTS (SELECT TOP 1 flockid FROM [dbo].[npcbossinfo] WHERE flockid=@flockID)
		BEGIN
			PRINT N'INSERT [npcbossinfo]';
			INSERT INTO [dbo].[npcbossinfo]
				([flockid],[respawnNoiseFactor],[lootSplitFlag],[outpostEID],[stabilityPts],[overrideRelations],[customDeathMessage],[customAggressMessage])
			VALUES
				(@flockID,0.15,1,@outpostEID,-2,1,'SAP Gaurd down!','Outpost Defenses engaged');
		END
		ELSE
		BEGIN
			PRINT N'UPDATE [npcbossinfo]';
			UPDATE [dbo].[npcbossinfo] SET
				respawnNoiseFactor=0.15,
				lootSplitFlag=1,
				outpostEID=@outpostEID,
				stabilityPts=-2,
				overrideRelations=1,
				customDeathMessage='SAP Gaurd down!',
				customAggressMessage='Outpost Defenses engaged'
			WHERE flockid=@flockID;
		END
	END
	ELSE
	BEGIN
		PRINT N'UPDATE [npcflock] WITH INVADER PARAMS';
		UPDATE npcflock SET 
			spawnoriginX=@x-1, 
			spawnoriginY=@y-1,
			spawnrangeMin=3,
			spawnrangeMax=20,
			respawnseconds=180,
			homerange=300,
			behaviorType=1
		WHERE id=@flockID;

		IF NOT EXISTS (SELECT TOP 1 flockid FROM [dbo].[npcbossinfo] WHERE flockid=@flockID)
		BEGIN
			PRINT N'INSERT [npcbossinfo]';
			INSERT INTO [dbo].[npcbossinfo]
				([flockid],[respawnNoiseFactor],[lootSplitFlag],[outpostEID],[stabilityPts],[overrideRelations],[customDeathMessage],[customAggressMessage])
			VALUES
				(@flockID,0.15,1,@outpostEID,-2,1,'Nia will have her revenge, Human','That terminal belongs to us!');
		END
		ELSE
		BEGIN
			PRINT N'UPDATE [npcbossinfo]';
			UPDATE [dbo].[npcbossinfo] SET
				respawnNoiseFactor=0.15,
				lootSplitFlag=1,
				outpostEID=@outpostEID,
				stabilityPts=2,
				overrideRelations=1,
				customDeathMessage='Nia will have her revenge, Human',
				customAggressMessage='That terminal belongs to us!'
			WHERE flockid=@flockID;
		END
	END


	--NPC Modifiers
	PRINT N'DELETE [aggregatevalues] (clear out any previous configuration for this npc)';
	DELETE FROM [aggregatevalues] WHERE definition=@definitionID; --Clear old settings

	PRINT N'INSERT [aggregatevalues] Set npc modifiers';
	SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
	SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.1);

	SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'ecm_strength_modifier' ORDER BY [name] DESC);
	SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 3);

	SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'ew_optimal_range_modifier' ORDER BY [name] DESC);
	SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.5);

	SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'sensor_strength_modifier' ORDER BY [name] DESC);
	SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2);

	SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy_modifier' ORDER BY [name] DESC);
	SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.5);

	SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max_modifier' ORDER BY [name] DESC);
	SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2);

	SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
	SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 3);

	SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_cycle_time_modifier' ORDER BY [name] DESC);
	SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.75);

	SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_max_modifier' ORDER BY [name] DESC);
	SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 5);

	SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_recharge_time_modifier' ORDER BY [name] DESC);
	SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.7);

	SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_max_modifier' ORDER BY [name] DESC);
	SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2.6);

	SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_modifier' ORDER BY [name] DESC);
	SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2.0);

	SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'falloff_modifier' ORDER BY [name] DESC);
	SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.6);

	SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locking_range_modifier' ORDER BY [name] DESC);
	SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2.5);

	SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locking_time_modifier' ORDER BY [name] DESC);
	SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.85);

	SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'missile_cycle_time_modifier' ORDER BY [name] DESC);
	SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.85);

	SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'optimal_range_modifier' ORDER BY [name] DESC);
	SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2.1);

	SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_max_modifier' ORDER BY [name] DESC);
	SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2.1);

	SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'resist_chemical' ORDER BY [name] DESC);
	SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 200);

	SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'resist_explosive' ORDER BY [name] DESC);
	SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 200);

	SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'resist_kinetic' ORDER BY [name] DESC);
	SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 200);

	SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'resist_thermal' ORDER BY [name] DESC);
	SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 200);

	SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max_modifier' ORDER BY [name] DESC);
	SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.85);

	SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'turret_cycle_time_modifier' ORDER BY [name] DESC);
	SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.85);

	SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'stealth_strength_modifier' ORDER BY [name] DESC);
	SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, -50);




	--LOOT
	PRINT N'DELETE [npcloot] wipe loot for npc, if present';
	DELETE FROM [npcloot] WHERE [definition]=@definitionID; --clear old loots

	PRINT N'INSERT [npcloot] for SAP npc';
	SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_core_recharger' ORDER BY definition DESC);
	INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.25, 1,1, 1);
	SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_sensor_booster' ORDER BY definition DESC);
	INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.25, 1,1, 1);
	SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_webber' ORDER BY definition DESC);
	INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.25, 1,1, 1);
	SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_sensor_jammer' ORDER BY definition DESC);
	INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.25, 1,1, 1);
	SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_sensor_dampener' ORDER BY definition DESC);
	INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.25, 1,1, 1);
	SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_mass_reductor' ORDER BY definition DESC);
	INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.25, 1,1, 1);
	SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_blob_emission_modulator' ORDER BY definition DESC);
	INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.25, 1,1, 1);
	SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_detection_modul' ORDER BY definition DESC);
	INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.25, 1,1, 1);
	SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_stealth_modul' ORDER BY definition DESC);
	INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.25, 1,1, 1);
	SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_target_painter' ORDER BY definition DESC);
	INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.25, 1,1, 1);
	SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_boost_ep_t0' ORDER BY definition DESC);
	INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 1,1, 1);
	SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_sensor_supressor_booster' ORDER BY definition DESC);
	INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.25, 1,1, 1);
	SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_ecm_booster' ORDER BY definition DESC);
	INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.25, 1,1, 1);
	SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_energy_warfare_upgrade' ORDER BY definition DESC);
	INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.25, 1,1, 1);
	SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_reactor_sealing' ORDER BY definition DESC);
	INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.25, 1,1, 1);
	SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_longrange_webber' ORDER BY definition DESC);
	INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.25, 1,1, 1);
	SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
	INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 5000, 1, 1,1, 4000);

    FETCH NEXT FROM db_cursor INTO  @zoneID,@outpostName,@x,@y,@name,@isGaurd
END 

CLOSE db_cursor  
DEALLOCATE db_cursor

DROP TABLE IF EXISTS #SAPBOSSES


GO