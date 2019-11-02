USE [perpetuumsa]
GO

------------------------------------------------
--Patch 13: Intrusion system overhaul
--
--Patch files contained:
--Ammo_balance_pvpfirearm_ammo__2019_08_29.sql
--ChassisBonuses_mk2__2019_08_29.sql
--EntityDef_outpostDecay__2019_09_08.sql
--IntrusionLoot_fullrework__2019_10_13.sql
--NPC_sapguardians_all__2019_10_13.sql
--presence_flock_hok_MoneySpawn_NPCPresence_flocksUPDATE__2019_07_28_13_06_42.sql
--Relics_update_reliczoneconfig__2019_10_02.sql
--SAPRelic_init__2019_09_28.sql
--SpecimenSAP_items__full__2019_09_21.sql
--Syndicate_balance__2019_08_29.sql
----------------------------------------------------



PRINT N'Syndicate_balance__2019_08_29.sql';

USE [perpetuumsa]
GO

--------------------------------
--Syndicate rebalance and bug fixin
--Helix Slope capability 51->56
--All Syndicate Masses increased
--Masking +10 on helix and locust
--
--Date Modified: 2019/08/29
---------------------------------


DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;


----Helix Leg Slope Capability----
PRINT N'Helix Leg incr Slope 5->6';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_helix_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'slope' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET
value=6 
WHERE id = @aggvalueID;


----Helix Chassis Mass----
PRINT N'Helix Chassis Mass 4000->5000';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_helix_chassis' ORDER BY definition DESC);

UPDATE entitydefaults SET 
mass=5000 
WHERE definition=@definitionID;


--Helix Signal Masking Increase
PRINT N'Helix Masking incr 120->130';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_helix_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'stealth_strength' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET 
value=130 
WHERE id = @aggvalueID;

----Vektor Mass Incr 5000->6000------
PRINT N'Vektor Mass Incr 5000->6000';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vektor_chassis' ORDER BY definition DESC);

UPDATE entitydefaults SET
 mass=6000
 WHERE definition=@definitionID;


--Locust Signal Masking Increase 
PRINT N'Locust Masking incr 110->120';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_locust_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'stealth_strength' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET 
value=120 
WHERE id = @aggvalueID;

--Locust Mass Incr 
PRINT N'Locust Mass incr 9000->11000';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_locust_chassis' ORDER BY definition DESC);

UPDATE entitydefaults SET
 mass=11000 
 WHERE definition=@definitionID;


---Echelon Mass Incr
PRINT N'Echelon Mass incr 21000->24000';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_echelon_chassis' ORDER BY definition DESC);

UPDATE entitydefaults SET 
mass=24000 
WHERE definition=@definitionID;


--Callisto Mass Incr
PRINT N'Echelon Mass incr 12k->14k';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_callisto_chassis' ORDER BY definition DESC);

UPDATE entitydefaults SET
  mass=14000 
  WHERE definition=@definitionID;

--Legatus Mass Incr
PRINT N'Echelon Mass incr 25k->30k';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_legatus_chassis' ORDER BY definition DESC);

UPDATE entitydefaults SET 
mass=30000 
WHERE definition=@definitionID;


GO

----------------------------------------------------------------------------
PRINT N'SpecimenSAP_items__full__2019_09_21';
----------------------------------------------------------------------------

USE [perpetuumsa]
GO

------------------------------------------------
--Specimen SAP Item, CTs, CT-capsule, production table, and Specimen SAP item requirements
--A full rework of Specimen SAPS - largely just making new producable items
--NOW INCLUDES: a new T0 module recycled-material
--And Specimen SAP pts = 15
--
--Last Modified: 2019/10/20
------------------------------------------------

UPDATE entitydefaults
SET options='#increase=n15'
WHERE definitionname='def_sap_specimen_processing';


----------------------------------------
-- Add new material for recovery from t0 module recycling
-- To be used by specimen items production
----------------------------------------


PRINT N'INSERT new material for t0 recycling'
DECLARE @itemName VARCHAR(128);
DECLARE @categoryOfItem BIGINT;
SET @itemName = 'def_specimen_sap_item_flux';
SET @categoryOfItem = (SELECT TOP 1 value FROM categoryFlags where name='cf_pbs_reactor_booster');

IF NOT EXISTS (SELECT TOP 1 definition from entitydefaults WHERE definitionname=@itemName)
BEGIN
	PRINT N'INSERT ' + @itemName;
	INSERT INTO [dbo].[entitydefaults]
		([definitionname],[quantity],[attributeflags],[categoryflags],[options],[note],[enabled],[volume],[mass],[hidden],[health],[descriptiontoken],[purchasable],[tiertype],[tierlevel])
	VALUES
		(@itemName,1,2048,@categoryOfItem,'','Specimen Item Material',1,0.1,0.1,0,100,'def_titanium_desc',1,NULL,NULL);
END
ELSE
BEGIN
	PRINT N'Updating ' + @itemName;
	UPDATE [dbo].[entitydefaults] SET
		volume=0.1,
		mass=0.1,
		categoryflags=@categoryOfItem,
		tierlevel=NULL,
		tiertype=NULL
	WHERE definitionname=@itemName;
END

DECLARE @itemDef int;
SET @itemDef = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@itemName);

PRINT N'Adding ' + @itemName + ' to t0 components';
IF EXISTS (SELECT TOP 1 componentdefinition from [components] WHERE componentdefinition=@itemDef)
BEGIN
	PRINT N'Deleting existing entries for this type of item for any product - for re-insert';
	DELETE FROM components WHERE componentdefinition=@itemDef;
END

DECLARE @lookupFlag BIGINT;
SET @lookupFlag = (SELECT value FROM dbo.categoryFlags WHERE name='cf_robot_equipment');
PRINT N'INSERTING INTO COMPONENTS FOR T0 MODULES ' + @itemName;
--INSERT add'l component on all t0 artifact modules for recovery via recycling
INSERT INTO [dbo].[components] ([definition],[componentdefinition],[componentamount]) 
SELECT definition, @itemDef, 4 FROM entitydefaults WHERE tiertype=1 AND tierlevel=0 AND definitionname LIKE 'def_artifact_damaged_%'
AND (categoryflags & CAST(dbo.GetCFMask(@lookupFlag)as BIGINT) = @lookupFlag);

GO

-------------------------------------------------------------------------


DECLARE @dynCtCategory bigint;
DECLARE @categoryOfItem bigint;
SET @dynCtCategory = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_dynamic_cprg');
SET @categoryOfItem = (SELECT TOP 1 value FROM categoryFlags where name='cf_pbs_reactor_booster');

DECLARE @hershfieldPresetShop int;
SET @hershfieldPresetShop = (SELECT TOP 1 id FROM itemshoppresets WHERE name = 'tm_preset_pve');

--Wipe Siege table
PRINT N'CLEAR SIEGEITEMS TABLE (Speci sap req items)';
DELETE FROM [dbo].[siegeitems];

PRINT N'SETUP TEMP TABLES';
DROP TABLE IF EXISTS #AMOUNTS_TABLE
CREATE TABLE #AMOUNTS_TABLE
(
	matName varchar(128),
	matAmount int
);

DECLARE @itemName varchar(128);
DECLARE @ctName varchar(128);
DECLARE @capsuleName varchar(128);

SET @itemName = 'def_specimen_sap_item';
SET @ctName = 'def_specimen_sap_item_dynamic_cprg';
SET @capsuleName = 'def_specimen_sap_item_CT_capsule';

INSERT INTO #AMOUNTS_TABLE (matName, matAmount) VALUES
('def_titan', 50000),
('def_crude', 200000),
('def_liquizit', 100000),
('def_silgium', 50000),
('def_stermonit', 50000),
('def_imentium', 50000),
('def_helioptris', 50000),
('def_triandlus', 50000),
('def_prismocitae', 50000),
('def_specimen_sap_item_flux', 1);


PRINT N'1. MAKE THE ITEM [entitydefaults]';
PRINT N'2. MAKE THE CT [entitydefaults]';
PRINT N'3. MAKE THE CT-capsule [entitydefaults]';
IF NOT EXISTS (SELECT TOP 1 definition from entitydefaults WHERE definitionname=@itemName)
BEGIN
	INSERT INTO [dbo].[entitydefaults]
		([definitionname],[quantity],[attributeflags],[categoryflags],[options],[note],[enabled],[volume],[mass],[hidden],[health],[descriptiontoken],[purchasable],[tiertype],[tierlevel])
	VALUES
		(@itemName,1,2048,@categoryOfItem,'','Specimen Item',1,16,16,0,100,'def_titanium_desc',1,1,1),
		(@ctName,1,1024,@dynCtCategory,'','Specimen Item CT',1,0.1,0.1,0,100,'calibration_program_desc',0,1,1),
		(@capsuleName, 1, 2052, 1179, '', 'CT Capsule', 1, 0.1, 0.1, 0, 100, 'calibration_program_desc', 1, 1, 1);
END
ELSE
BEGIN
	--Maybe we try different volumes on the item
	UPDATE [dbo].[entitydefaults] SET
	volume=16,
	mass=16,
	categoryflags=@categoryOfItem
	WHERE definitionname=@itemName;
END


DECLARE @itemDef int;
DECLARE @ctDef int;
DECLARE @ctCapsuleDef int;

SET @itemDef = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@itemName);
SET @ctDef = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@ctName);
SET @ctCapsuleDef = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@capsuleName);

PRINT N'4. Map the CT to produce the ITEM';
IF NOT EXISTS (SELECT TOP 1 definition from [calibrationtemplateitems] WHERE definition=@ctCapsuleDef)
BEGIN
	INSERT INTO [dbo].[calibrationtemplateitems]
			([definition],[targetdefinition])
		VALUES
			(@ctCapsuleDef,@ctDef);
END

PRINT N'5. MAP THE CT TO THE ITEM VIA [dynamiccalibrationtemplates]';
IF NOT EXISTS (SELECT TOP 1 definition from [dynamiccalibrationtemplates] WHERE definition=@ctDef)
BEGIN
	INSERT INTO [dbo].[dynamiccalibrationtemplates] ([definition],[materialefficiency],[timeefficiency],[targetdefinition]) 
	VALUES
		(@ctDef,180,180,@itemDef);
END
ELSE
BEGIN
	--maybe we try different efficiencies
	UPDATE [dbo].[dynamiccalibrationtemplates] SET
		materialefficiency=180,
		timeefficiency=180
	WHERE definition=@ctDef;
END


PRINT N'6. INSERT CT INTO SYN SHOP';
IF EXISTS (SELECT TOP 1 targetdefinition from [itemshop] WHERE targetdefinition=@ctCapsuleDef)
BEGIN
	PRINT N'FOUND ITEM ALREADY IN SHOP - DELETING'
	DELETE FROM itemshop
	WHERE targetdefinition=@ctCapsuleDef;
	PRINT N'DELETED'
END

INSERT INTO [dbo].[itemshop]
	([presetid],[targetdefinition],[targetamount],[tmcoin],[icscoin],[asicoin],[credit],[unicoin],[globallimit],[purchasecount],[standing])
VALUES
	(@hershfieldPresetShop,@ctCapsuleDef,1,10,10,10,500000,20,NULL,0,NULL);
PRINT N'INSERTED itemshop entry for CT';

PRINT N'7. INSERT ITEM TO SPECIMEN TABLE';
INSERT INTO [dbo].[siegeitems] (definition, minquantity, maxquantity) VALUES
(@itemDef, 2, 3);



PRINT N'8. INSERT [components] FOR PRODUCTION MATERIAL REQUIREMENTS';
IF EXISTS (SELECT TOP 1 definition from [components] WHERE definition=@itemDef)
BEGIN
	PRINT N'Found Existing components for this item... DELETING!!!';
	DELETE FROM components WHERE definition=@itemDef;
	PRINT N'Item Production table deleted';
END

PRINT N'Inserting item production table';
INSERT INTO [dbo].[components] ([definition],[componentdefinition],[componentamount])
SELECT @itemDef, (SELECT TOP 1 definition FROM entitydefaults WHERE m.matName=definitionname), m.matAmount FROM #AMOUNTS_TABLE as m




--Things that apply to all items via category
PRINT N'9. CONFIGURE THE DECALIBRATION SETTINGS FOR THE CT productiondecalibration';
IF NOT EXISTS (SELECT TOP 1 categoryflag from productiondecalibration WHERE categoryflag=@categoryOfItem)
BEGIN
	INSERT INTO productiondecalibration (categoryflag, distorsionmin, distorsionmax, decrease)
	VALUES(@categoryOfItem, 0.003, 0.005, 1);
	PRINT N'INSERTED declaibration for this category';
END
ELSE
BEGIN
	--Maybe we try differnet num runs (eff/decrease)
	UPDATE productiondecalibration
	SET
		categoryflag = @categoryOfItem,
		distorsionmax = 0.005,
		distorsionmin= 0.003,
		decrease=1
	WHERE categoryflag=@categoryOfItem;
	PRINT N'updated declaibration for this category';
END

PRINT N'10. CONFIGURE THE BASE-DURATION OF THE CT [productionduration]';
IF NOT EXISTS (SELECT TOP 1 category FROM [perpetuumsa].[dbo].[productionduration] WHERE category=@categoryOfItem)
BEGIN
	INSERT INTO [dbo].[productionduration]([category],[durationmodifier])
	VALUES
		(@categoryOfItem,0.25);
	PRINT N'INSERTED production duration for this category';
END
ELSE
BEGIN
	UPDATE [productionduration]
	SET
		durationmodifier = 0.25
	WHERE category=@categoryOfItem;
	PRINT N'updated production duration for this category';
END

--cleanup
PRINT N'DROP TEMP TABLES';
DROP TABLE IF EXISTS #AMOUNTS_TABLE
PRINT N'========SPECIMEN FULL REWORK COMPLETE!============';

GO



----------------------------------------------------------------------------
PRINT N'SAPRelic_init__2019_09_28';
----------------------------------------------------------------------------


USE [perpetuumsa]
GO

-------------------------------------------------------
--New Relic Definition for SAP Relics
--
--Date modified: 2019/09/28
-------------------------------------------------------

PRINT N'SAPRelic EntityDefault for server unit creation';

INSERT INTO [dbo].[entitydefaults]
           ([definitionname],[quantity],[attributeflags],[categoryflags],[options],[note],[enabled],[volume],[mass],[hidden],[health],[descriptiontoken],[purchasable],[tiertype],[tierlevel])
     VALUES
           ('def_relic_sap',1,1024,0 ,NULL,'SAP Relic',1,1,1,0,100,NULL,0,NULL,NULL);
GO

PRINT N'SAPRelic Definition - Add absurd masking';
DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_relic_sap' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'stealth_strength' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 99999999);
GO


INSERT INTO [dbo].[relictypes]
           ([name],[raceid],[level],[ep])
     VALUES
           ('sap_relic_basetype', 0, 0, 50);
GO

DECLARE @sapRelicType int;
SET @sapRelicType = (SELECT TOP 1 id FROM relictypes WHERE name='sap_relic_basetype');


INSERT INTO [dbo].[relicloot]
           ([definition],[minquantity],[maxquantity],[chance],[relictypeid],[packed])
SELECT [definition],[minquantity],[maxquantity],[chance],@sapRelicType,[packed] FROM relicloot
WHERE [relictypeid]=(SELECT TOP 1 id FROM relictypes WHERE name='relic_level1_neutral_beta1');
GO



----------------------------------------------------------------------------
PRINT N'Relics_update_reliczoneconfig__2019_10_02';
----------------------------------------------------------------------------


USE [perpetuumsa]
GO

--------------------------------
--Increase spawn maximum for all relic-enabled zones
--Date: 2019/10/02
--------------------------------


UPDATE [reliczoneconfig] SET
maxspawn=9
WHERE zoneid in (0,3,4,5,8,9,10,11);

GO


----------------------------------------------------------------------------
PRINT N'presence_flock_hok_MoneySpawn_NPCPresence_flocksUPDATE__2019_07_28_13_06_42';
----------------------------------------------------------------------------


USE [perpetuumsa]
GO

------------------------------------------------
--Fix inconsistent flock counts in hokk spawn
--Date: 2019/07/28
-----------------------------------------------


DECLARE @presenceID int
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_MoneySpawn' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_MoneySpawn',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'hokk_Moneyspawn',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

DECLARE @flockID int;
DECLARE @definitionID int;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Leg_hokk_MST3' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Leg_hokk_MST3' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 1689, [spawnoriginY] = 1341 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'Leg_hokk_MST3', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Leg_hokk_MST4' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Leg_hokk_MST4' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 1689, [spawnoriginY] = 1341 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'Leg_hokk_MST4', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_callisto_buccaneer_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Callisto_hokk_MST4' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Callisto_hokk_MST4' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 1689, [spawnoriginY] = 1341 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'Callisto_hokk_MST4', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ikarus_abstrans_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'ikarus_hokk_MST4' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'ikarus_hokk_MST4' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 1689, [spawnoriginY] = 1341 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'Ikarus_hokk_MST4', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'echelon_hokk_MST4' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'echelon_hokk_MST4' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 1689, [spawnoriginY] = 1341 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'echelon_hokk_MST4', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'echelon_hokk_MST3' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'echelon_hokk_MST3' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 1689, [spawnoriginY] = 1341 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'echelon_hokk_MST3', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;


GO


----------------------------------------------------------------------------
PRINT N'NPC_sapguardians_all__2019_10_13';
----------------------------------------------------------------------------


USE [perpetuumsa]
GO

------------------------------------------
-- NPC Boss Info Table
-- Table create to handle more detailed settings for a BossFlock
-- 
-- Date Modified: 2019/09/01
------------------------------------------
PRINT N'TABLE CHANGES FOR NPCBOSSINFO';
DROP TABLE IF EXISTS dbo.npcbossinfo;

CREATE TABLE dbo.npcbossinfo(
	id INT NOT NULL IDENTITY PRIMARY KEY,
	flockid INT NOT NULL,
	respawnNoiseFactor FLOAT NULL,
	lootSplitFlag BIT NOT NULL,
	outpostEID BIGINT NULL,
	stabilityPts INT NULL,
	overrideRelations BIT NOT NULL,
	customDeathMessage VARCHAR(128) NULL,
	customAggressMessage VARCHAR(128) NULL
);
PRINT N'INSERT default values for all existing bosses with new table';
--Insert default values
INSERT INTO dbo.npcbossinfo (flockid, respawnNoiseFactor, lootSplitFlag, outpostEID, stabilityPts, overrideRelations, customDeathMessage, customAggressMessage) 
SELECT npcflock.id, 0.15, 1, NULL, NULL, 0, 'Nice Shot! Enjoy the loot ;)', 'CAUTION: you are engaging with a powerful foe!'
FROM npcflock
WHERE npcflock.npcSpecialType=1;

PRINT N'DONE with new BossInfo table';
GO




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
			behaviorType=1,
			npcSpecialType=1
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


----------------------------------------------------------------------------
PRINT N'IntrusionLoot_fullrework__2019_10_13';
----------------------------------------------------------------------------

USE [perpetuumsa]
GO

----------------------------------------------------------------------
--A full and complete rework of SAP Loot with Patch 13 SAP changes
--See design documents for details
--Last Modified: 2019/10/26
----------------------------------------------------------------------

PRINT N'FULL WIPE OF INSTRUSION LOOT';
DELETE FROM [dbo].[intrusionloot];


--OUTPOSTS
DECLARE @nuimqolOutpost INT;
DECLARE @pelistalOutpost INT;
DECLARE @thelodicaOutpost INT;

SET @nuimqolOutpost = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_public_docking_base_nuimqol_outpost');
SET @pelistalOutpost = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_public_docking_base_pelistal_outpost');
SET @thelodicaOutpost = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_public_docking_base_thelodica_outpost');

--SAPS
DECLARE @activeSAP INT;
DECLARE @destroSAP INT;
DECLARE @passiveSAP INT;
DECLARE @speciSAP INT;

SET @activeSAP = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_sap_active_hacking');
SET @destroSAP = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_sap_destruction');
SET @passiveSAP = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_sap_passive_hacking');
SET @speciSAP = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_sap_specimen_processing');

--LOOTS
DECLARE @cortexLight INT;
DECLARE @cortexAssault INT;
DECLARE @cortexMech INT;
DECLARE @cortexHMech INT;
DECLARE @decoderLv6 INT;
DECLARE @decoderLv7 INT;
DECLARE @decoderLv8 INT;
DECLARE @decoderLv9 INT;
DECLARE @kernelCommon INT;
DECLARE @kernelHitech INT;
DECLARE @kernelNuimqol INT;
DECLARE @kernelThelodica INT;
DECLARE @kernelPelistal INT;
DECLARE @plasmaCommon INT;
DECLARE @plasmaNuimqol INT;
DECLARE @plasmaThelodica INT;
DECLARE @plasmaPelistal INT;
DECLARE @ammoSmallNuimqolA INT;
DECLARE @ammoSmallNuimqolB INT;
DECLARE @ammoMedNuimqolA INT;
DECLARE @ammoMedNuimqolB INT;
DECLARE @ammoSmallThelodicaA INT;
DECLARE @ammoSmallThelodicaB INT;
DECLARE @ammoMedThelodicaA INT;
DECLARE @ammoMedThelodicaB INT;
DECLARE @ammoSmallPelistalA INT;
DECLARE @ammoSmallPelistalB INT;
DECLARE @ammoMedPelistalA INT;
DECLARE @ammoMedPelistalB INT;
DECLARE @ammoMedPelistalLRA INT;
DECLARE @ammoMedPelistalLRB INT;
DECLARE @epBoostT0 INT;

SET @cortexLight = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_reactore_core_runner');
SET @cortexAssault = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_reactore_core_assault');
SET @cortexMech = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_reactore_core_mech');
SET @cortexHMech = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_reactore_core_heavymech');
SET @decoderLv6 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_research_kit_6');
SET @decoderLv7 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_research_kit_7');
SET @decoderLv8 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_research_kit_8');
SET @decoderLv9 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_research_kit_9');
SET @kernelCommon = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_kernel_common');
SET @kernelHitech = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_kernel_hitech');
SET @kernelNuimqol = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_kernel_nuimqol');
SET @kernelThelodica = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_kernel_thelodica');
SET @kernelPelistal = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_kernel_pelistal');
SET @plasmaCommon = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_common_reactor_plasma');
SET @plasmaNuimqol = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_nuimqol_reactor_plasma');
SET @plasmaThelodica = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_thelodica_reactor_plasma');
SET @plasmaPelistal = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pelistal_reactor_plasma');
SET @ammoSmallNuimqolA = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_small_railgun_rewa');
SET @ammoSmallNuimqolB  = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_small_railgun_rewb');
SET @ammoMedNuimqolA  = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_rewa');
SET @ammoMedNuimqolB  = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_rewb');
SET @ammoSmallThelodicaA  = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_small_railgun_rewa');
SET @ammoSmallThelodicaB  = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_small_railgun_rewa');
SET @ammoMedThelodicaA  = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_small_railgun_rewa');
SET @ammoMedThelodicaB  = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_small_railgun_rewa');
SET @ammoSmallPelistalA  = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_rocket_rewa');
SET @ammoSmallPelistalB  = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_rocket_rewb');
SET @ammoMedPelistalA  = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_missile_rewa');
SET @ammoMedPelistalB  = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_missile_rewB');
SET @ammoMedPelistalLRA  = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_longrange_missile_rewa');
SET @ammoMedPelistalLRB  = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_longrange_missile_rewb');
SET @epBoostT0 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_boost_ep_t0');

PRINT N'INSERT ALL-NEW INSTRUSION LOOTS!';

INSERT INTO [dbo].[intrusionloot]
	([sitedefinition],[sapdefinition],[itemdefinition],[minquantity],[maxquantity],[minstabilitythreshold],[maxstabilitythreshold],[probability])
VALUES
--ALL
--0-49
	(@nuimqolOutpost, @activeSAP, @kernelCommon, 900, 1100, 0, 49, 1),
	(@nuimqolOutpost, @activeSAP, @kernelHitech, 150, 250, 0, 49, 1),
	(@nuimqolOutpost, @activeSAP, @plasmaCommon, 1000, 2000, 0, 49, 1),
	(@nuimqolOutpost, @activeSAP, @epBoostT0, 1, 1, 0, 49, 1),

	(@nuimqolOutpost, @passiveSAP, @kernelCommon, 900, 1100, 0, 49, 1),
	(@nuimqolOutpost, @passiveSAP, @kernelHitech, 150, 250, 0, 49, 1),
	(@nuimqolOutpost, @passiveSAP, @plasmaCommon, 1000, 2000, 0, 49, 1),
	(@nuimqolOutpost, @passiveSAP, @epBoostT0, 1, 1, 0, 49, 1),

	(@nuimqolOutpost, @destroSAP, @kernelCommon, 900, 1100, 0, 49, 1),
	(@nuimqolOutpost, @destroSAP, @kernelHitech, 150, 250, 0, 49, 1),
	(@nuimqolOutpost, @destroSAP, @plasmaCommon, 1000, 2000, 0, 49, 1),
	(@nuimqolOutpost, @destroSAP, @epBoostT0, 1, 1, 0, 49, 1),

	(@nuimqolOutpost, @speciSAP, @kernelCommon, 900, 1100, 0, 49, 1),
	(@nuimqolOutpost, @speciSAP, @kernelHitech, 150, 250, 0, 49, 1),
	(@nuimqolOutpost, @speciSAP, @plasmaCommon, 1000, 2000, 0, 49, 1),
	(@nuimqolOutpost, @speciSAP, @epBoostT0, 1, 1, 0, 49, 1),
	--pelistal
	(@pelistalOutpost, @activeSAP, @kernelCommon, 900, 1100, 0, 49, 1),
	(@pelistalOutpost, @activeSAP, @kernelHitech, 150, 250, 0, 49, 1),
	(@pelistalOutpost, @activeSAP, @plasmaCommon, 1000, 2000, 0, 49, 1),
	(@pelistalOutpost, @activeSAP, @epBoostT0, 1, 1, 0, 49, 1),

	(@pelistalOutpost, @passiveSAP, @kernelCommon, 900, 1100, 0, 49, 1),
	(@pelistalOutpost, @passiveSAP, @kernelHitech, 150, 250, 0, 49, 1),
	(@pelistalOutpost, @passiveSAP, @plasmaCommon, 1000, 2000, 0, 49, 1),
	(@pelistalOutpost, @passiveSAP, @epBoostT0, 1, 1, 0, 49, 1),

	(@pelistalOutpost, @destroSAP, @kernelCommon, 900, 1100, 0, 49, 1),
	(@pelistalOutpost, @destroSAP, @kernelHitech, 150, 250, 0, 49, 1),
	(@pelistalOutpost, @destroSAP, @plasmaCommon, 1000, 2000, 0, 49, 1),
	(@pelistalOutpost, @destroSAP, @epBoostT0, 1, 1, 0, 49, 1),

	(@pelistalOutpost, @speciSAP, @kernelCommon, 900, 1100, 0, 49, 1),
	(@pelistalOutpost, @speciSAP, @kernelHitech, 150, 250, 0, 49, 1),
	(@pelistalOutpost, @speciSAP, @plasmaCommon, 1000, 2000, 0, 49, 1),
	(@pelistalOutpost, @speciSAP, @epBoostT0, 1, 1, 0, 49, 1),
	--thelo
	(@thelodicaOutpost, @activeSAP, @kernelCommon, 900, 1100, 0, 49, 1),
	(@thelodicaOutpost, @activeSAP, @kernelHitech, 150, 250, 0, 49, 1),
	(@thelodicaOutpost, @activeSAP, @plasmaCommon, 1000, 2000, 0, 49, 1),
	(@thelodicaOutpost, @activeSAP, @epBoostT0, 1, 1, 0, 49, 1),

	(@thelodicaOutpost, @passiveSAP, @kernelCommon, 900, 1100, 0, 49, 1),
	(@thelodicaOutpost, @passiveSAP, @kernelHitech, 150, 250, 0, 49, 1),
	(@thelodicaOutpost, @passiveSAP, @plasmaCommon, 1000, 2000, 0, 49, 1),
	(@thelodicaOutpost, @passiveSAP, @epBoostT0, 1, 1, 0, 49, 1),

	(@thelodicaOutpost, @destroSAP, @kernelCommon, 900, 1100, 0, 49, 1),
	(@thelodicaOutpost, @destroSAP, @kernelHitech, 150, 250, 0, 49, 1),
	(@thelodicaOutpost, @destroSAP, @plasmaCommon, 1000, 2000, 0, 49, 1),
	(@thelodicaOutpost, @destroSAP, @epBoostT0, 1, 1, 0, 49, 1),

	(@thelodicaOutpost, @speciSAP, @kernelCommon, 900, 1100, 0, 49, 1),
	(@thelodicaOutpost, @speciSAP, @kernelHitech, 150, 250, 0, 49, 1),
	(@thelodicaOutpost, @speciSAP, @plasmaCommon, 1000, 2000, 0, 49, 1),
	(@thelodicaOutpost, @speciSAP, @epBoostT0, 1, 1, 0, 49, 1),

--ACTIVE
--0-49
	(@nuimqolOutpost, @activeSAP, @cortexLight, 1, 1, 0, 49, 1),
	(@nuimqolOutpost, @activeSAP, @cortexAssault, 1, 1, 0, 49, 1),
	(@nuimqolOutpost, @activeSAP, @cortexLight, 1, 1, 0, 49, 0.125),
	(@nuimqolOutpost, @activeSAP, @cortexAssault, 1, 1, 0, 49, 0.125),
	(@nuimqolOutpost, @activeSAP, @cortexMech, 1, 1, 0, 49, 0.125),
	(@nuimqolOutpost, @activeSAP, @cortexHMech, 1, 1, 0, 49, 0.125),
	(@nuimqolOutpost, @activeSAP, @decoderLv6, 1, 1, 0, 49, 0.5),
	(@nuimqolOutpost, @activeSAP, @decoderLv7, 1, 1, 0, 49, 0.25),
	(@nuimqolOutpost, @activeSAP, @decoderLv8, 1, 1, 0, 49, 0.15),
	(@nuimqolOutpost, @activeSAP, @decoderLv9, 1, 1, 0, 49, 0.1),

	(@pelistalOutpost, @activeSAP, @cortexLight, 1, 1, 0, 49, 1),
	(@pelistalOutpost, @activeSAP, @cortexAssault, 1, 1, 0, 49, 1),
	(@pelistalOutpost, @activeSAP, @cortexLight, 1, 1, 0, 49, 0.125),
	(@pelistalOutpost, @activeSAP, @cortexAssault, 1, 1, 0, 49, 0.125),
	(@pelistalOutpost, @activeSAP, @cortexMech, 1, 1, 0, 49, 0.125),
	(@pelistalOutpost, @activeSAP, @cortexHMech, 1, 1, 0, 49, 0.125),
	(@pelistalOutpost, @activeSAP, @decoderLv6, 1, 1, 0, 49, 0.5),
	(@pelistalOutpost, @activeSAP, @decoderLv7, 1, 1, 0, 49, 0.25),
	(@pelistalOutpost, @activeSAP, @decoderLv8, 1, 1, 0, 49, 0.15),
	(@pelistalOutpost, @activeSAP, @decoderLv9, 1, 1, 0, 49, 0.1),

	(@thelodicaOutpost, @activeSAP, @cortexLight, 1, 1, 0, 49, 1),
	(@thelodicaOutpost, @activeSAP, @cortexAssault, 1, 1, 0, 49, 1),
	(@thelodicaOutpost, @activeSAP, @cortexLight, 1, 1, 0, 49, 0.125),
	(@thelodicaOutpost, @activeSAP, @cortexAssault, 1, 1, 0, 49, 0.125),
	(@thelodicaOutpost, @activeSAP, @cortexMech, 1, 1, 0, 49, 0.125),
	(@thelodicaOutpost, @activeSAP, @cortexHMech, 1, 1, 0, 49, 0.125),
	(@thelodicaOutpost, @activeSAP, @decoderLv6, 1, 1, 0, 49, 0.5),
	(@thelodicaOutpost, @activeSAP, @decoderLv7, 1, 1, 0, 49, 0.25),
	(@thelodicaOutpost, @activeSAP, @decoderLv8, 1, 1, 0, 49, 0.15),
	(@thelodicaOutpost, @activeSAP, @decoderLv9, 1, 1, 0, 49, 0.1),
--50-99
	(@nuimqolOutpost, @activeSAP, @cortexLight, 1, 1, 50, 99, 1),
	(@nuimqolOutpost, @activeSAP, @cortexAssault, 1, 1, 50, 99, 1),
	(@nuimqolOutpost, @activeSAP, @cortexMech, 1, 1, 50, 99, 1),
	(@nuimqolOutpost, @activeSAP, @cortexLight, 1, 1, 50, 99, 0.125),
	(@nuimqolOutpost, @activeSAP, @cortexAssault, 1, 1, 50, 99, 0.125),
	(@nuimqolOutpost, @activeSAP, @cortexMech, 1, 1, 50, 99, 0.125),
	(@nuimqolOutpost, @activeSAP, @cortexHMech, 1, 1, 50, 99, 0.125),
	(@nuimqolOutpost, @activeSAP, @decoderLv6, 1, 2, 50, 99, 0.5),
	(@nuimqolOutpost, @activeSAP, @decoderLv7, 1, 2, 50, 99, 0.25),
	(@nuimqolOutpost, @activeSAP, @decoderLv8, 1, 2, 50, 99, 0.15),
	(@nuimqolOutpost, @activeSAP, @decoderLv9, 1, 2, 50, 99, 0.1),

	(@pelistalOutpost, @activeSAP, @cortexLight, 1, 1, 50, 99, 1),
	(@pelistalOutpost, @activeSAP, @cortexAssault, 1, 1, 50, 99, 1),
	(@pelistalOutpost, @activeSAP, @cortexMech, 1, 1, 50, 99, 1),
	(@pelistalOutpost, @activeSAP, @cortexLight, 1, 1, 50, 99, 0.125),
	(@pelistalOutpost, @activeSAP, @cortexAssault, 1, 1, 50, 99, 0.125),
	(@pelistalOutpost, @activeSAP, @cortexMech, 1, 1, 50, 99, 0.125),
	(@pelistalOutpost, @activeSAP, @cortexHMech, 1, 1, 50, 99, 0.125),
	(@pelistalOutpost, @activeSAP, @decoderLv6, 1, 2, 50, 99, 0.5),
	(@pelistalOutpost, @activeSAP, @decoderLv7, 1, 2, 50, 99, 0.25),
	(@pelistalOutpost, @activeSAP, @decoderLv8, 1, 2, 50, 99, 0.15),
	(@pelistalOutpost, @activeSAP, @decoderLv9, 1, 2, 50, 99, 0.1),

	(@thelodicaOutpost, @activeSAP, @cortexLight, 1, 1, 50, 99, 1),
	(@thelodicaOutpost, @activeSAP, @cortexAssault, 1, 1, 50, 99, 1),
	(@thelodicaOutpost, @activeSAP, @cortexMech, 1, 1, 50, 99, 1),
	(@thelodicaOutpost, @activeSAP, @cortexLight, 1, 1, 50, 99, 0.125),
	(@thelodicaOutpost, @activeSAP, @cortexAssault, 1, 1, 50, 99, 0.125),
	(@thelodicaOutpost, @activeSAP, @cortexMech, 1, 1, 50, 99, 0.125),
	(@thelodicaOutpost, @activeSAP, @cortexHMech, 1, 1, 50, 99, 0.125),
	(@thelodicaOutpost, @activeSAP, @decoderLv6, 1, 2, 50, 99, 0.5),
	(@thelodicaOutpost, @activeSAP, @decoderLv7, 1, 2, 50, 99, 0.25),
	(@thelodicaOutpost, @activeSAP, @decoderLv8, 1, 2, 50, 99, 0.15),
	(@thelodicaOutpost, @activeSAP, @decoderLv9, 1, 2, 50, 99, 0.1),
--100+
	(@nuimqolOutpost, @activeSAP, @cortexLight, 1, 1, 100, 200, 1),
	(@nuimqolOutpost, @activeSAP, @cortexAssault, 1, 1, 100, 200, 1),
	(@nuimqolOutpost, @activeSAP, @cortexMech, 1, 1, 100, 200, 1),
	(@nuimqolOutpost, @activeSAP, @cortexHMech, 1, 1, 100, 200, 1),
	(@nuimqolOutpost, @activeSAP, @cortexLight, 1, 1, 100, 200, 0.125),
	(@nuimqolOutpost, @activeSAP, @cortexAssault, 1, 1, 100, 200, 0.125),
	(@nuimqolOutpost, @activeSAP, @cortexMech, 1, 1, 100, 200, 0.125),
	(@nuimqolOutpost, @activeSAP, @cortexHMech, 1, 1, 100, 200, 0.125),
	(@nuimqolOutpost, @activeSAP, @decoderLv6, 1, 3, 100, 200, 0.5),
	(@nuimqolOutpost, @activeSAP, @decoderLv7, 1, 3, 100, 200, 0.25),
	(@nuimqolOutpost, @activeSAP, @decoderLv8, 1, 3, 100, 200, 0.15),
	(@nuimqolOutpost, @activeSAP, @decoderLv9, 1, 3, 100, 200, 0.1),

	(@pelistalOutpost, @activeSAP, @cortexLight, 1, 1, 100, 200, 1),
	(@pelistalOutpost, @activeSAP, @cortexAssault, 1, 1, 100, 200, 1),
	(@pelistalOutpost, @activeSAP, @cortexMech, 1, 1, 100, 200, 1),
	(@pelistalOutpost, @activeSAP, @cortexHMech, 1, 1, 100, 200, 1),
	(@pelistalOutpost, @activeSAP, @cortexLight, 1, 1, 100, 200, 0.125),
	(@pelistalOutpost, @activeSAP, @cortexAssault, 1, 1, 100, 200, 0.125),
	(@pelistalOutpost, @activeSAP, @cortexMech, 1, 1, 100, 200, 0.125),
	(@pelistalOutpost, @activeSAP, @cortexHMech, 1, 1, 100, 200, 0.125),
	(@pelistalOutpost, @activeSAP, @decoderLv6, 1, 3, 100, 200, 0.5),
	(@pelistalOutpost, @activeSAP, @decoderLv7, 1, 3, 100, 200, 0.25),
	(@pelistalOutpost, @activeSAP, @decoderLv8, 1, 3, 100, 200, 0.15),
	(@pelistalOutpost, @activeSAP, @decoderLv9, 1, 3, 100, 200, 0.1),

	(@thelodicaOutpost, @activeSAP, @cortexLight, 1, 1, 100, 200, 1),
	(@thelodicaOutpost, @activeSAP, @cortexAssault, 1, 1, 100, 200, 1),
	(@thelodicaOutpost, @activeSAP, @cortexMech, 1, 1, 100, 200, 1),
	(@thelodicaOutpost, @activeSAP, @cortexHMech, 1, 1, 100, 200, 1),
	(@thelodicaOutpost, @activeSAP, @cortexLight, 1, 1, 100, 200, 0.125),
	(@thelodicaOutpost, @activeSAP, @cortexAssault, 1, 1, 100, 200, 0.125),
	(@thelodicaOutpost, @activeSAP, @cortexMech, 1, 1, 100, 200, 0.125),
	(@thelodicaOutpost, @activeSAP, @cortexHMech, 1, 1, 100, 200, 0.125),
	(@thelodicaOutpost, @activeSAP, @decoderLv6, 1, 3, 100, 200, 0.5),
	(@thelodicaOutpost, @activeSAP, @decoderLv7, 1, 3, 100, 200, 0.25),
	(@thelodicaOutpost, @activeSAP, @decoderLv8, 1, 3, 100, 200, 0.15),
	(@thelodicaOutpost, @activeSAP, @decoderLv9, 1, 3, 100, 200, 0.1),

--DESTRO
--0-49
	(@nuimqolOutpost, @destroSAP, @ammoSmallNuimqolA, 125, 175, 0, 49, 1),
	(@nuimqolOutpost, @destroSAP, @ammoSmallNuimqolB, 125, 175, 0, 49, 1),
	(@nuimqolOutpost, @destroSAP, @ammoMedNuimqolA, 125, 175, 0, 49, 1),
	(@nuimqolOutpost, @destroSAP, @ammoMedNuimqolB, 125, 175, 0, 49, 1),
	(@nuimqolOutpost, @destroSAP, @plasmaNuimqol, 1000, 2000, 0, 49, 1),

	(@pelistalOutpost, @destroSAP, @ammoSmallPelistalA, 125, 175, 0, 49, 1),
	(@pelistalOutpost, @destroSAP, @ammoSmallPelistalB, 125, 175, 0, 49, 1),
	(@pelistalOutpost, @destroSAP, @ammoMedPelistalA, 125, 175, 0, 49, 1),
	(@pelistalOutpost, @destroSAP, @ammoMedPelistalB, 125, 175, 0, 49, 1),
	(@pelistalOutpost, @destroSAP, @ammoMedPelistalLRA, 125, 175, 0, 49, 1),
	(@pelistalOutpost, @destroSAP, @ammoMedPelistalLRB, 125, 175, 0, 49, 1),
	(@pelistalOutpost, @destroSAP, @plasmaPelistal, 1000, 2000, 0, 49, 1),

	(@thelodicaOutpost, @destroSAP, @ammoSmallThelodicaA, 125, 175, 0, 49, 1),
	(@thelodicaOutpost, @destroSAP, @ammoSmallThelodicaB, 125, 175, 0, 49, 1),
	(@thelodicaOutpost, @destroSAP, @ammoMedThelodicaA, 125, 175, 0, 49, 1),
	(@thelodicaOutpost, @destroSAP, @ammoMedThelodicaB, 125, 175, 0, 49, 1),
	(@thelodicaOutpost, @destroSAP, @plasmaThelodica, 1000, 2000, 0, 49, 1),
--50-99
	(@nuimqolOutpost, @destroSAP, @ammoSmallNuimqolA, 250, 350, 50, 99, 1),
	(@nuimqolOutpost, @destroSAP, @ammoSmallNuimqolB, 250, 350, 50, 99, 1),
	(@nuimqolOutpost, @destroSAP, @ammoMedNuimqolA, 250, 350, 50, 99, 1),
	(@nuimqolOutpost, @destroSAP, @ammoMedNuimqolB, 250, 350, 50, 99, 1),
	(@nuimqolOutpost, @destroSAP, @plasmaNuimqol, 1000, 2000, 50, 99, 1),

	(@pelistalOutpost, @destroSAP, @ammoSmallPelistalA, 250, 350, 50, 99, 1),
	(@pelistalOutpost, @destroSAP, @ammoSmallPelistalB, 250, 350, 50, 99, 1),
	(@pelistalOutpost, @destroSAP, @ammoMedPelistalA, 250, 350, 50, 99, 1),
	(@pelistalOutpost, @destroSAP, @ammoMedPelistalB, 250, 350, 50, 99, 1),
	(@pelistalOutpost, @destroSAP, @ammoMedPelistalLRA, 250, 350, 50, 99, 1),
	(@pelistalOutpost, @destroSAP, @ammoMedPelistalLRB, 250, 350, 50, 99, 1),
	(@pelistalOutpost, @destroSAP, @plasmaPelistal, 1000, 2000, 50, 99, 1),

	(@thelodicaOutpost, @destroSAP, @ammoSmallThelodicaA, 250, 350, 50, 99, 1),
	(@thelodicaOutpost, @destroSAP, @ammoSmallThelodicaB, 250, 350, 50, 99, 1),
	(@thelodicaOutpost, @destroSAP, @ammoMedThelodicaA, 250, 350, 50, 99, 1),
	(@thelodicaOutpost, @destroSAP, @ammoMedThelodicaB, 250, 350, 50, 99, 1),
	(@thelodicaOutpost, @destroSAP, @plasmaThelodica, 1000, 2000, 50, 99, 1),
--100+
	(@nuimqolOutpost, @destroSAP, @ammoSmallNuimqolA, 375, 525, 100, 200, 1),
	(@nuimqolOutpost, @destroSAP, @ammoSmallNuimqolB, 375, 525, 100, 200, 1),
	(@nuimqolOutpost, @destroSAP, @ammoMedNuimqolA, 375, 525, 100, 200, 1),
	(@nuimqolOutpost, @destroSAP, @ammoMedNuimqolB, 375, 525, 100, 200, 1),
	(@nuimqolOutpost, @destroSAP, @plasmaNuimqol, 1000, 2000, 100, 200, 1),

	(@pelistalOutpost, @destroSAP, @ammoSmallPelistalA, 375, 525, 100, 200, 1),
	(@pelistalOutpost, @destroSAP, @ammoSmallPelistalB, 375, 525, 100, 200, 1),
	(@pelistalOutpost, @destroSAP, @ammoMedPelistalA, 375, 525, 100, 200, 1),
	(@pelistalOutpost, @destroSAP, @ammoMedPelistalB, 375, 525, 100, 200, 1),
	(@pelistalOutpost, @destroSAP, @ammoMedPelistalLRA, 375, 525, 100, 200, 1),
	(@pelistalOutpost, @destroSAP, @ammoMedPelistalLRB, 375, 525, 100, 200, 1),
	(@pelistalOutpost, @destroSAP, @plasmaPelistal, 1000, 2000, 100, 200, 1),

	(@thelodicaOutpost, @destroSAP, @ammoSmallThelodicaA, 375, 525, 100, 200, 1),
	(@thelodicaOutpost, @destroSAP, @ammoSmallThelodicaB, 375, 525, 100, 200, 1),
	(@thelodicaOutpost, @destroSAP, @ammoMedThelodicaA, 375, 525, 100, 200, 1),
	(@thelodicaOutpost, @destroSAP, @ammoMedThelodicaB, 375, 525, 100, 200, 1),
	(@thelodicaOutpost, @destroSAP, @plasmaThelodica, 1000, 2000, 100, 200, 1),


--PASSIVE
--0-49
	(@nuimqolOutpost, @passiveSAP, @decoderLv6, 1, 1, 0, 49, 0.5),
	(@nuimqolOutpost, @passiveSAP, @decoderLv7, 1, 1, 0, 49, 0.25),
	(@nuimqolOutpost, @passiveSAP, @decoderLv8, 1, 1, 0, 49, 0.15),
	(@nuimqolOutpost, @passiveSAP, @decoderLv9, 1, 1, 0, 49, 0.1),
	(@nuimqolOutpost, @passiveSAP, @plasmaNuimqol, 2500, 3500, 0, 49, 1),

	(@pelistalOutpost, @passiveSAP, @decoderLv6, 1, 1, 0, 49, 0.5),
	(@pelistalOutpost, @passiveSAP, @decoderLv7, 1, 1, 0, 49, 0.25),
	(@pelistalOutpost, @passiveSAP, @decoderLv8, 1, 1, 0, 49, 0.15),
	(@pelistalOutpost, @passiveSAP, @decoderLv9, 1, 1, 0, 49, 0.1),
	(@pelistalOutpost, @passiveSAP, @plasmaPelistal, 2500, 3500, 0, 49, 1),

	(@thelodicaOutpost, @passiveSAP, @decoderLv6, 1, 1, 0, 49, 0.5),
	(@thelodicaOutpost, @passiveSAP, @decoderLv7, 1, 1, 0, 49, 0.25),
	(@thelodicaOutpost, @passiveSAP, @decoderLv8, 1, 1, 0, 49, 0.15),
	(@thelodicaOutpost, @passiveSAP, @decoderLv9, 1, 1, 0, 49, 0.1),
	(@thelodicaOutpost, @passiveSAP, @plasmaThelodica, 2500, 3500, 0, 49, 1),
--50-99
	(@nuimqolOutpost, @passiveSAP, @decoderLv6, 1, 2, 50, 99, 0.5),
	(@nuimqolOutpost, @passiveSAP, @decoderLv7, 1, 2, 50, 99, 0.25),
	(@nuimqolOutpost, @passiveSAP, @decoderLv8, 1, 2, 50, 99, 0.15),
	(@nuimqolOutpost, @passiveSAP, @decoderLv9, 1, 2, 50, 99, 0.1),
	(@nuimqolOutpost, @passiveSAP, @plasmaNuimqol, 5000, 7000, 50, 99, 1),

	(@pelistalOutpost, @passiveSAP, @decoderLv6, 1, 2, 50, 99, 0.5),
	(@pelistalOutpost, @passiveSAP, @decoderLv7, 1, 2, 50, 99, 0.25),
	(@pelistalOutpost, @passiveSAP, @decoderLv8, 1, 2, 50, 99, 0.15),
	(@pelistalOutpost, @passiveSAP, @decoderLv9, 1, 2, 50, 99, 0.1),
	(@pelistalOutpost, @passiveSAP, @plasmaPelistal, 5000, 7000, 50, 99, 1),

	(@thelodicaOutpost, @passiveSAP, @decoderLv6, 1, 2, 50, 99, 0.5),
	(@thelodicaOutpost, @passiveSAP, @decoderLv7, 1, 2, 50, 99, 0.25),
	(@thelodicaOutpost, @passiveSAP, @decoderLv8, 1, 2, 50, 99, 0.15),
	(@thelodicaOutpost, @passiveSAP, @decoderLv9, 1, 2, 50, 99, 0.1),
	(@thelodicaOutpost, @passiveSAP, @plasmaThelodica, 5000, 7000, 50, 99, 1),
--100+
	(@nuimqolOutpost, @passiveSAP, @decoderLv6, 1, 3, 100, 200, 0.5),
	(@nuimqolOutpost, @passiveSAP, @decoderLv7, 1, 3, 100, 200, 0.25),
	(@nuimqolOutpost, @passiveSAP, @decoderLv8, 1, 3, 100, 200, 0.15),
	(@nuimqolOutpost, @passiveSAP, @decoderLv9, 1, 3, 100, 200, 0.1),
	(@nuimqolOutpost, @passiveSAP, @plasmaNuimqol, 7500, 10500, 100, 200, 1),

	(@pelistalOutpost, @passiveSAP, @decoderLv6, 1, 3, 100, 200, 0.5),
	(@pelistalOutpost, @passiveSAP, @decoderLv7, 1, 3, 100, 200, 0.25),
	(@pelistalOutpost, @passiveSAP, @decoderLv8, 1, 3, 100, 200, 0.15),
	(@pelistalOutpost, @passiveSAP, @decoderLv9, 1, 3, 100, 200, 0.1),
	(@pelistalOutpost, @passiveSAP, @plasmaPelistal, 7500, 10500, 100, 200, 1),

	(@thelodicaOutpost, @passiveSAP, @decoderLv6, 1, 3, 100, 200, 0.5),
	(@thelodicaOutpost, @passiveSAP, @decoderLv7, 1, 3, 100, 200, 0.25),
	(@thelodicaOutpost, @passiveSAP, @decoderLv8, 1, 3, 100, 200, 0.15),
	(@thelodicaOutpost, @passiveSAP, @decoderLv9, 1, 3, 100, 200, 0.1),
	(@thelodicaOutpost, @passiveSAP, @plasmaThelodica, 7500, 10500, 100, 200, 1),


--SPECI
--0-49
	(@nuimqolOutpost, @speciSAP, @cortexLight, 1, 1, 0, 49, 0.33),
	(@nuimqolOutpost, @speciSAP, @cortexAssault, 1, 1, 0, 49, 0.32),
	(@nuimqolOutpost, @speciSAP, @cortexMech, 1, 1, 0, 49, 0.31),
	(@nuimqolOutpost, @speciSAP, @cortexHMech, 1, 1, 0, 49, 0.3),
	(@nuimqolOutpost, @speciSAP, @kernelCommon, 900, 1100, 0, 49, 1),
	(@nuimqolOutpost, @speciSAP, @kernelNuimqol, 900, 1100, 0, 49, 1),
	(@nuimqolOutpost, @speciSAP, @kernelHitech, 150, 250, 0, 49, 1),

	(@pelistalOutpost, @speciSAP, @cortexLight, 1, 1, 0, 49, 0.33),
	(@pelistalOutpost, @speciSAP, @cortexAssault, 1, 1, 0, 49, 0.32),
	(@pelistalOutpost, @speciSAP, @cortexMech, 1, 1, 0, 49, 0.31),
	(@pelistalOutpost, @speciSAP, @cortexHMech, 1, 1, 0, 49, 0.3),
	(@pelistalOutpost, @speciSAP, @kernelCommon, 900, 1100, 0, 49, 1),
	(@pelistalOutpost, @speciSAP, @kernelPelistal, 900, 1100, 0, 49, 1),
	(@pelistalOutpost, @speciSAP, @kernelHitech, 150, 250, 0, 49, 1),

	(@thelodicaOutpost, @speciSAP, @cortexLight, 1, 1, 0, 49, 0.33),
	(@thelodicaOutpost, @speciSAP, @cortexAssault, 1, 1, 0, 49, 0.32),
	(@thelodicaOutpost, @speciSAP, @cortexMech, 1, 1, 0, 49, 0.31),
	(@thelodicaOutpost, @speciSAP, @cortexHMech, 1, 1, 0, 49, 0.3),
	(@thelodicaOutpost, @speciSAP, @kernelCommon, 900, 1100, 0, 49, 1),
	(@thelodicaOutpost, @speciSAP, @kernelThelodica, 900, 1100, 0, 49, 1),
	(@thelodicaOutpost, @speciSAP, @kernelHitech, 150, 250, 0, 49, 1),
--50-99
	(@nuimqolOutpost, @speciSAP, @cortexLight, 1, 1, 50, 99, 0.66),
	(@nuimqolOutpost, @speciSAP, @cortexAssault, 1, 1, 50, 99, 0.64),
	(@nuimqolOutpost, @speciSAP, @cortexMech, 1, 1, 50, 99, 0.62),
	(@nuimqolOutpost, @speciSAP, @cortexHMech, 1, 1, 50, 99, 0.6),
	(@nuimqolOutpost, @speciSAP, @kernelCommon, 1800, 2200, 50, 99, 1),
	(@nuimqolOutpost, @speciSAP, @kernelNuimqol, 1800, 2200, 50, 99, 1),
	(@nuimqolOutpost, @speciSAP, @kernelHitech, 450, 750, 50, 99, 1),

	(@pelistalOutpost, @speciSAP, @cortexLight, 1, 1, 50, 99, 0.66),
	(@pelistalOutpost, @speciSAP, @cortexAssault, 1, 1, 50, 99, 0.64),
	(@pelistalOutpost, @speciSAP, @cortexMech, 1, 1, 50, 99, 0.62),
	(@pelistalOutpost, @speciSAP, @cortexHMech, 1, 1, 50, 99, 0.6),
	(@pelistalOutpost, @speciSAP, @kernelCommon, 1800, 2200, 50, 99, 1),
	(@pelistalOutpost, @speciSAP, @kernelPelistal, 1800, 2200, 50, 99, 1),
	(@pelistalOutpost, @speciSAP, @kernelHitech, 450, 750, 50, 99, 1),

	(@thelodicaOutpost, @speciSAP, @cortexLight, 1, 1, 50, 99, 0.66),
	(@thelodicaOutpost, @speciSAP, @cortexAssault, 1, 1, 50, 99, 0.64),
	(@thelodicaOutpost, @speciSAP, @cortexMech, 1, 1, 50, 99, 0.62),
	(@thelodicaOutpost, @speciSAP, @cortexHMech, 1, 1, 50, 99, 0.6),
	(@thelodicaOutpost, @speciSAP, @kernelCommon, 1800, 2200, 50, 99, 1),
	(@thelodicaOutpost, @speciSAP, @kernelThelodica, 1800, 2200, 50, 99, 1),
	(@thelodicaOutpost, @speciSAP, @kernelHitech, 450, 750, 50, 99, 1),
--100+
	(@nuimqolOutpost, @speciSAP, @cortexLight, 1, 1, 100, 200, 0.99),
	(@nuimqolOutpost, @speciSAP, @cortexAssault, 1, 1, 100, 200, 0.96),
	(@nuimqolOutpost, @speciSAP, @cortexMech, 1, 1, 100, 200, 0.93),
	(@nuimqolOutpost, @speciSAP, @cortexHMech, 1, 1, 100, 200, 0.9),
	(@nuimqolOutpost, @speciSAP, @kernelCommon, 2700, 3300, 100, 200, 1),
	(@nuimqolOutpost, @speciSAP, @kernelNuimqol, 2700, 3300, 100, 200, 1),
	(@nuimqolOutpost, @speciSAP, @kernelHitech, 450, 750, 100, 200, 1),

	(@pelistalOutpost, @speciSAP, @cortexLight, 1, 1, 100, 200, 0.99),
	(@pelistalOutpost, @speciSAP, @cortexAssault, 1, 1, 100, 200, 0.96),
	(@pelistalOutpost, @speciSAP, @cortexMech, 1, 1, 100, 200, 0.93),
	(@pelistalOutpost, @speciSAP, @cortexHMech, 1, 1, 100, 200, 0.9),
	(@pelistalOutpost, @speciSAP, @kernelCommon, 2700, 3300, 100, 200, 1),
	(@pelistalOutpost, @speciSAP, @kernelPelistal, 2700, 3300, 100, 200, 1),
	(@pelistalOutpost, @speciSAP, @kernelHitech, 450, 750, 100, 200, 1),

	(@thelodicaOutpost, @speciSAP, @cortexLight, 1, 1, 100, 200, 0.99),
	(@thelodicaOutpost, @speciSAP, @cortexAssault, 1, 1, 100, 200, 0.96),
	(@thelodicaOutpost, @speciSAP, @cortexMech, 1, 1, 100, 200, 0.93),
	(@thelodicaOutpost, @speciSAP, @cortexHMech, 1, 1, 100, 200, 0.9),
	(@thelodicaOutpost, @speciSAP, @kernelCommon, 2700, 3300, 100, 200, 1),
	(@thelodicaOutpost, @speciSAP, @kernelThelodica, 2700, 3300, 100, 200, 1),
	(@thelodicaOutpost, @speciSAP, @kernelHitech, 450, 750, 100, 200, 1);

GO



----------------------------------------------------------------------------
PRINT N'EntityDef_outpostDecay__2019_09_08';
----------------------------------------------------------------------------

USE [perpetuumsa]
GO

--------------------------------------------
--Outpost Decay Definition
--A definition for valid intrusion events and logs
--
--Date Modified: 2019/09/08
--------------------------------------------

INSERT INTO [dbo].[entitydefaults]
           ([definitionname],[quantity],[attributeflags],[categoryflags],[options],[note],[enabled],[volume],[mass],[hidden],[health],[descriptiontoken],[purchasable],[tiertype],[tierlevel])
     VALUES
           ('def_outpost_decay',1,2,(SELECT value FROM categoryFlags WHERE name = 'cf_intrusion_objects'),'','Decay def',1,1,1,0,100,'',0,1,1);
GO


----------------------------------------------------------------------------
PRINT N'ChassisBonuses_mk2__2019_08_29';
----------------------------------------------------------------------------


USE [perpetuumsa]
GO

---------------------------------------
--MK2 Bonus Buff
--Combats +1% dmg 
--Ewar +3 resists
--Date modified: 2019/08/29
---------------------------------------
PRINT N'Applying Mk2 Bonuses';
DECLARE @definitionID int;
DECLARE @extensionID int;
DECLARE @aggfieldID int;
DECLARE @chassisbonusID int;

--Yagel

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_high_tech_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_yagel_head_mk2' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_small_railgun_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.01, '', @aggfieldID, 0);

--Prom

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_high_tech_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_head_mk2' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_small_laser_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.01, '', @aggfieldID, 0);

--Castel


SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_high_tech_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_castel_head_mk2' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_small_missile_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.01, '', @aggfieldID, 0);

--Cam

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_high_tech_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_head_mk2' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_chemical' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 3, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_high_tech_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_head_mk2' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_explosive' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 3, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_high_tech_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_head_mk2' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_kinetic' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 3, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_high_tech_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_head_mk2' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_thermal' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 3, '', @aggfieldID, 0);

--Intakt

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_high_tech_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_head_mk2' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_thermal' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 3, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_high_tech_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_head_mk2' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_chemical' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 3, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_high_tech_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_head_mk2' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_explosive' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 3, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_high_tech_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_head_mk2' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_kinetic' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 3, '', @aggfieldID, 0);

--troiar

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_high_tech_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_troiar_head_mk2' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_kinetic' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 3, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_high_tech_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_troiar_head_mk2' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_thermal' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 3, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_high_tech_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_troiar_head_mk2' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_explosive' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 3, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_high_tech_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_troiar_head_mk2' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_chemical' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 3, '', @aggfieldID, 0);

--Arby

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_high_tech_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_arbalest_head_mk2' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_small_railgun_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.01, '', @aggfieldID, 0);

--Baph

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_high_tech_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_baphomet_mk2_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_small_laser_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.01, '', @aggfieldID, 0);

--Waspish

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_high_tech_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_waspish_head_mk2' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_small_missile_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.01, '', @aggfieldID, 0);

--Kain

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_high_tech_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_head_mk2' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_medium_railgun_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.01, '', @aggfieldID, 0);

--artemis

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_high_tech_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_head_mk2' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_medium_laser_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.01, '', @aggfieldID, 0);

--Tyro

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_high_tech_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_tyrannos_head_mk2' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_medium_missile_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.01, '', @aggfieldID, 0);

--Vaga

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_high_tech_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vagabond_head_mk2' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_thermal' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 3, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_high_tech_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vagabond_head_mk2' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_chemical' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 3, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_high_tech_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vagabond_head_mk2' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_explosive' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 3, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_high_tech_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vagabond_head_mk2' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_kinetic' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 3, '', @aggfieldID, 0);

--zenith

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_high_tech_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_zenith_head_mk2' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_kinetic' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 3, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_high_tech_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_zenith_head_mk2' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_thermal' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 3, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_high_tech_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_zenith_head_mk2' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_explosive' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 3, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_high_tech_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_zenith_head_mk2' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_chemical' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 3, '', @aggfieldID, 0);

--Ictus

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_high_tech_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ictus_head_mk2' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_chemical' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 3, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_high_tech_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ictus_head_mk2' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_explosive' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 3, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_high_tech_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ictus_head_mk2' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_kinetic' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 3, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_high_tech_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ictus_head_mk2' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_thermal' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 3, '', @aggfieldID, 0);

--Mesmer

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_high_tech_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_head_mk2' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_medium_railgun_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.01, '', @aggfieldID, 0);

--Seth

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_high_tech_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_seth_head_mk2' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_medium_laser_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.01, '', @aggfieldID, 0);

--Gropho

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_high_tech_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_gropho_head_mk2' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_medium_missile_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.01, '', @aggfieldID, 0);

GO
PRINT N'Done Applying MK2 Bonus adds!';


----------------------------------------------------------------------------
PRINT N'Ammo_balance_pvpfirearm_ammo__2019_08_29';
----------------------------------------------------------------------------


USE [perpetuumsa]
GO


--------------------------
--Syndicate PVP Ammo rebalance
--Flechette 
--small 24dmg -> 18dmg, med 48->36
---70% falloff -> +25% optimal
--Date: 2019/08/29
--------------------------

PRINT N'Small ammo';
DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_small_projectile_rewb' ORDER BY definition DESC);

UPDATE entitydefaults SET
options='#damageChemical=f0.00
#damageKinetic=f6.00
#damageExplosive=f6.00
#damageThermal=f6.00
#optimalRangeModifier=f1.00
#explosion_radius=f0
#bullettime=f25.0'
WHERE definition=@definitionID;

PRINT N'updates'
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_explosive' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=6 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_kinetic' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=6 WHERE id =  @aggvalueID;

PRINT N'inserts'
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'optimal_range_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.25);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_thermal' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 6);

PRINT N'delete'
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'falloff_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;





PRINT N'Medium ammo';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_medium_projectile_rewb' ORDER BY definition DESC);

UPDATE entitydefaults SET
options='#damageChemical=f0.00
#damageKinetic=f12.00
#damageExplosive=f12.00
#damageThermal=f0.00
#optimalRangeModifier=f1.00
#explosion_radius=f0
#bullettime=f30.0'
WHERE definition=@definitionID;


PRINT N'updates'
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_explosive' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_kinetic' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12 WHERE id =  @aggvalueID;

PRINT N'inserts'
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_thermal' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 12);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'optimal_range' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2.5);

PRINT N'delete'
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'falloff_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;

GO


PRINT N'========PATCH 13 APPLIED=============';
