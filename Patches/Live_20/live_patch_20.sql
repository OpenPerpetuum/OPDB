USE [perpetuumsa]
GO

--------------------------------------------------------
--Patch 20: The npc base Stronghold, destroyer tweaks, new tech elite-modules and production
--00_INSERT_ZONE_70.sql
--01_Stronghold_entry-exit_configs_and_mobile_device.sql
--02_NPC_PBS_entitydef_inserts__2020_08_07.sql
--03_NPC_PresenceFlocks_zone70__2020_08_09.sql
--04_EliteModules_upserts__2020_12_26.sql
--05_npcloots_zone70__2020_09_10.sql
--06_Entity_Insert_RallyTerminal_zone70.sql
--07_DECOR_IMPORT_zone70_2021_01_10.sql
--08_Aggvalues_destro_balance__2020_12_26.sql
--09_Aggvalues_pbsTurret_ranges__2020_12_26.sql
--10_Moduleprops_upsert_ewarFalloff__2020_12_22.sql
--11_PlantrulesOmega_zones_update__2021_01_19.sql
--12_Productioncost_upsert__2021_01_20.sql
--------------------------------------------------------

PRINT N'00_INSERT_ZONE_70.sql';
USE [perpetuumsa]
GO

-------------------------------------------------------------
-- STRONGHOLD ZONE INSERTION SCRIPT
-- Runs all necesary record insertions for basic empty zone
-- Assumes layers valid and correct size for zone params
-------------------------------------------------------------

--Zone columns
DECLARE @zoneId INT;
SET @zoneId=70; --Zone ID!  Must be same as layer numbers!

DECLARE @size INT;
SET @size = 512; --Double check this!

DECLARE @x INT;
DECLARE @y INT;
DECLARE @zoneName VARCHAR(50);
DECLARE @zoneDesc VARCHAR(50);
DECLARE @note VARCHAR(2048);
DECLARE @fertility INT;
DECLARE @zoneplugin NVARCHAR(50);
DECLARE @zoneip NVARCHAR(50);
DECLARE @zoneport INT;
DECLARE @isInstance BIT;
DECLARE @enabled BIT;
DECLARE @spawnId INT;
DECLARE @plantRuleset INT;
DECLARE @protected BIT;
DECLARE @raceId INT;
DECLARE @width INT;
DECLARE @height INT;
DECLARE @terraformable BIT;
DECLARE @zoneType INT;
DECLARE @sparkCost INT;
DECLARE @maxDockingBase INT;
DECLARE @sleeping BIT;
DECLARE @plantAltitudeScale FLOAT;
DECLARE @host VARCHAR(50);
DECLARE @active BIT;
--NPCSpawn for zone
DECLARE @spawnName VARCHAR(50);
DECLARE @spawnDesc VARCHAR(50);
DECLARE @spawnNote NVARCHAR(2000);
--Entity columns for zone storage entity
DECLARE @eid BIGINT;
DECLARE @definition INT;
DECLARE @ename VARCHAR(128);

--Insert NPCSpawn first for npcspawnid
SET @spawnName = 'zone_strghld_' + CONVERT(varchar(10), @zoneId) + '_spawn';
SET @spawnDesc = 'zone_strghld_' + CONVERT(varchar(10), @zoneId) + '_spawn';
SET @spawnNote = 'Stronghold spawn for NPC base ' + CONVERT(varchar(10), @zoneId);

PRINT N'INSERTING/UPDATING NPCSPAWN TABLE';
IF EXISTS (SELECT TOP 1 id FROM npcspawn WHERE name=@spawnName)
BEGIN
	UPDATE npcspawn SET
		description=@spawnDesc,
		note=@spawnNote
	WHERE name=@spawnName;
END
ELSE
BEGIN
	INSERT INTO [dbo].[npcspawn] ([name],[description],[note])
	VALUES (@spawnName, @spawnDesc, @spawnNote);
END

--SET ZONE PARAMETERS

SET @x=20000;
SET @y=20000;
SET @zoneName = 'zone_strghld_' + CONVERT(varchar(10), @zoneId);
SET @zoneDesc = @zoneName + '_desc';
SET @note = 'NPCStrongholdBase'+CONVERT(varchar(10), @zoneId);
SET @fertility = 20;
SET @zoneplugin = 'zone_'+CONVERT(varchar(10), @zoneId)
SET @zoneip = '109.236.88.106'
SET @zoneport = 18800+@zoneId;
SET @isInstance =0;
SET @enabled =1;
SET @spawnId = (SELECT TOP 1 id FROM npcspawn WHERE name=@spawnName);
SET @plantRuleset = @zoneId;
SET @protected =1;
SET @raceId = 1;
SET @width = @size;
SET @height = @size;
SET @terraformable =0;
SET @zoneType =4;
SET @sparkCost =3;
SET @maxDockingBase = 0;
SET @sleeping= 0;
SET @plantAltitudeScale =1;
SET @host ='genxyHost-01';
SET @active =1;

PRINT N'DELETE/REINSERT NEW PLANTRULE FOR ZONE';
DROP TABLE IF EXISTS #PLANTRULE;
CREATE TABLE #PLANTRULE(
	ruleFile VARCHAR(100)
);
INSERT INTO #PLANTRULE (ruleFile) VALUES
--('bonsai.txt'),
('bush_a.txt'),
('bush_b.txt'),
('coppertree.txt'),
--('devrinol.txt'),
('grass_a.txt'),
('grass_b.txt'),
('nanowheat.txt'),
('pinetree.txt'),
--('poffeteg.txt'),
('quag.txt'),
--('rango.txt'),
('rango_lowaltitude.txt'),
--('reed.txt'),
('titanplant.txt');

DELETE FROM plantrules WHERE rulesetid=@plantRuleset;
INSERT INTO plantrules (plantrule, rulesetid, note)
SELECT ruleFile, @plantRuleset, 'stronghold plant rules' FROM #PLANTRULE;

DROP TABLE IF EXISTS #PLANTRULE;

--SET ENTITY FOR ZONE STORAGE
SET @eid=(SELECT TOP 1 eid + 1 FROM entities WHERE eid + 1 NOT IN (SELECT DISTINCT eid FROM entities));
SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_zone_storage');
SET @ename = 'es_zone_'+CONVERT(varchar(10), @zoneId)+'_storage';

PRINT N'INSERTING/UPDATING ENTITIES TABLE';
IF EXISTS (SELECT TOP 1 eid FROM entities WHERE ename=@ename)
BEGIN
	UPDATE entities SET
		definition=@definition
	WHERE ename=@ename;
	SET @eid = (SELECT TOP 1 eid FROM entities WHERE ename=@ename);
END
ELSE
BEGIN
	INSERT INTO [dbo].[entities]
			   ([eid],[definition],[owner],[parent],[health],[ename],[quantity],[repackaged],[dynprop])
		 VALUES
			   (@eid,@definition,NULL,NULL,100,@ename,1,0,NULL);
END

PRINT N'INSERTING/UPDATING entitystorage TABLE';
IF EXISTS (SELECT TOP 1 eid FROM entitystorage WHERE storage_name=@ename)
BEGIN
	UPDATE entitystorage SET
		eid=@eid
	WHERE storage_name=@ename;
END
ELSE
BEGIN
	INSERT INTO [dbo].[entitystorage]
			   (storage_name,eid)
		 VALUES
			   (@ename,@eid);
END

PRINT N'INSERTING/UPDATING ZONE TABLE';
IF EXISTS (SELECT TOP 1 id FROM zones WHERE name=@zoneName AND description=@zoneName+'_desc')
BEGIN
	UPDATE zones SET
		id=@zoneId,
		x=@x,
		y=@y,
		name=@zoneName,
		description=@zoneDesc,
		note=@note,
		fertility=@fertility,
		zoneplugin=@zoneplugin,
		zoneport=@zoneport,
		isinstance=@isInstance,
		enabled=@enabled,
		spawnid=@spawnId,
		plantruleset=@plantRuleset,
		protected=@protected,
		raceid=@raceId,
		width=@width,
		height=@height,
		terraformable=@terraformable,
		zonetype=@zoneType,
		sparkcost=@sparkCost,
		maxdockingbase=@maxDockingBase,
		sleeping=@sleeping,
		plantaltitudescale=@plantAltitudeScale,
		host=@host,
		active=@active
	WHERE name=@zoneName;

END
ELSE
BEGIN
	INSERT INTO [dbo].[zones]
           ([id],[x],[y],[name],[description],[note],[fertility],[zoneplugin],[zoneip],[zoneport],[isinstance],[enabled],[spawnid],[plantruleset]
		   ,[protected],[raceid],[width],[height],[terraformable],[zonetype],[sparkcost],[maxdockingbase],[sleeping],[plantaltitudescale],[host],[active])
     VALUES
           (@zoneId,@x,@y,@zoneName,@zoneDesc,@note,@fertility,@zoneplugin,@zoneip,@zoneport,@isInstance,@enabled,@spawnId,@plantRuleset
           ,@protected,@raceId,@width,@height,@terraformable,@zoneType,@sparkCost,@maxDockingBase,@sleeping,@plantAltitudeScale,@host,@active);
END


PRINT N'NEW ZONE READY!';
GO

PRINT N'01_Stronghold_entry-exit_configs_and_mobile_device.sql';
USE [perpetuumsa]
GO
------------------------------------------------------------------
-- Add new mobile teleport for new stronghold
-- Inserts on Entitydefaults
-- Map to new zone teleports
-- Add/reset Exit rifts on new zone
-- Date modified: 2020/08/23 
------------------------------------------------------------------

DECLARE @zoneID INT;
SET @zoneID = 70;

--Teleport-column on SH properties
DECLARE @ename VARCHAR(128);
SET @ename = 'tp_zone_strnghld_'+CAST(@zoneID as varchar);
DECLARE @x INT;
DECLARE @y INT;
DECLARE @z INT;
DECLARE @rot INT;
SET @x = 473;
SET @y = 403;
SET @z = 20;
SET @rot = 90;

DECLARE @parentEntity bigint;
SET @parentEntity = (SELECT TOP 1 eid from entitystorage where storage_name='teleport_column');

DECLARE @eid bigint;
SET @eid = (SELECT TOP 1 eid + 1 FROM entities WHERE eid + 1 NOT IN (SELECT DISTINCT eid FROM entities));

PRINT N'SETUP EXIT RIFTS FOR ZONE';
DELETE FROM strongholdexitconfig WHERE zoneid=@zoneID;
INSERT strongholdexitconfig (zoneid, x, y) VALUES
(@zoneID, 487, 397),
(@zoneID, 33, 45);


DECLARE @tmShops INT;
SET @tmShops = (SELECT TOP 1 id FROM itemshoppresets WHERE name='tm_preset_pve');

DROP TABLE IF EXISTS #ENTITYDEFS;
CREATE TABLE #ENTITYDEFS
(
	def INT,
	defName varchar(100),
	catFlags bigint,
	attrFlags bigint,
	cargoVolume float,
	massOfModule float,
	genxyOptStr varchar(max),
	description varchar(max),
	marketable int
);
INSERT INTO #ENTITYDEFS (def, defName, attrFlags, catFlags, cargoVolume, massOfModule, genxyOptStr, description, marketable) VALUES
(5726,'def_mobile_teleport_stronghold_capsule', 25167872, 131480, 4, 8000, '', 'def_mobile_teleport_stronghold_capsule_desc', 1),
(5727,'def_mobile_teleport_stronghold_basic', 12583936, 33948280, 4, 8000, '', 'def_mobile_teleport_stronghold_capsule_desc', 0),
(5922,'def_mobile_teleport_stronghold_level_02_capsule', 25167872, 131480, 4, 8000, '', 'def_mobile_teleport_stronghold_level_02_capsule_desc', 1),
(5923,'def_mobile_teleport_stronghold_level_02', 12583936, 33948280, 4, 8000, '', 'def_mobile_teleport_stronghold_level_02_desc', 0);


DROP TABLE IF EXISTS #DEFCONFIGS;
CREATE TABLE #DEFCONFIGS
(
	defName varchar(100),
	targetName varchar(100),
	spoolTime int
);
INSERT INTO #DEFCONFIGS (defName, targetName, spoolTime) VALUES
('def_mobile_teleport_stronghold_capsule', 'def_mobile_teleport_stronghold_basic', 15000),
('def_mobile_teleport_stronghold_level_02_capsule', 'def_mobile_teleport_stronghold_level_02', 15000);

DROP TABLE IF EXISTS #SHOPENTRIES;
CREATE TABLE #SHOPENTRIES
(
	defName varchar(100),
	tokenPrice int,
	nicPrice int
);
INSERT INTO #SHOPENTRIES (defName, tokenPrice, nicPrice) VALUES
('def_mobile_teleport_stronghold_capsule', 20, 500000),
('def_mobile_teleport_stronghold_level_02_capsule', 50, 1000000);

DROP TABLE IF EXISTS #DEVTOZONEMAP;
CREATE TABLE #DEVTOZONEMAP
(
	defName varchar(100),
	targetZoneID int,
);
INSERT INTO #DEVTOZONEMAP (defName, targetZoneID) VALUES
('def_mobile_teleport_stronghold_basic', (SELECT TOP 1 id FROM zones WHERE name='zone_pvp_arena' AND zonetype=4)),
('def_mobile_teleport_stronghold_level_02', @zoneID);


------------------------------------------------------------------
--Add teleport column to Stronghold
--Adds or updates zoneentities
------------------------------------------------------------------


PRINT N' INSERT/UPDATE TELEPORT ON entities';
IF NOT EXISTS (SELECT eid FROM entities WHERE ename=@ename)
BEGIN
	INSERT INTO entities (eid, definition, owner, parent, health, ename, quantity, repackaged, dynprop) VALUES
	(@eid, 1394, NULL, @parentEntity, 100, @ename, 1, 0, '#enabled=i1');
END
ELSE
BEGIN
	UPDATE entities SET
		definition=1394,
		parent=@parentEntity,
		health=100,
		quantity=1,
		repackaged=0,
		dynprop='#enabled=i1'
	WHERE ename=@ename;
	SET @eid = (SELECT TOP 1 eid FROM entities WHERE ename=@ename);
END

PRINT N' INSERT/UPDATE TELEPORT ON zoneentities';
IF NOT EXISTS (SELECT eid FROM zoneentities WHERE ename=@ename)
BEGIN
	INSERT INTO zoneentities (zoneID, eid, definition, owner, ename, x, y, z, orientation, enabled, note, runtime, synckey) VALUES 
	(@zoneID, @eid, NULL, NULL, @ename, @x, @y, @z, @rot, 1, 'stronghold teleport 70', 0, 'tp_strnghld_'+CAST(@zoneID as varchar));
END
ELSE
BEGIN
	UPDATE zoneentities SET
		zoneID = @zoneID,
		eid=@eid,
		x = @x,
		y = @y,
		z = @z,
		orientation = @rot,
		enabled = 1,
		note = 'stronghold teleport 70',
		runtime = 0,
		synckey = 'tp_strnghld_'+CAST(@zoneID as varchar)
	WHERE ename=@ename;
END


PRINT N'[[[[entitydefaults]]]]';
SET IDENTITY_INSERT [dbo].[entitydefaults] ON;
PRINT N'UPDATE/INSERT ENTITY DEFS for NPC PBS definitions';
--Update/insert [entitydefaults] entries
MERGE [dbo].[entitydefaults] def USING #ENTITYDEFS d2
ON def.definition = d2.def
WHEN MATCHED
    THEN UPDATE SET
		categoryflags=catFlags,
		attributeflags=attrFlags,
		volume=cargoVolume,
		mass=massOfModule,
		tiertype=NULL,
		tierlevel=NULL,
		options=genxyOptStr,
		enabled=1,
		hidden=0,
		purchasable=marketable,
		descriptiontoken=description
WHEN NOT MATCHED
    THEN INSERT (definition, definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel) VALUES
	(def, defName, 1, attrFlags, catFlags, genxyOptStr, '', 1 ,cargoVolume, massOfModule, 0, 100, description, marketable, NULL, NULL);
SET IDENTITY_INSERT [dbo].[entitydefaults] OFF;

PRINT N'[[[definitionconfig]]]';
MERGE [dbo].[definitionconfig] config USING #DEFCONFIGS defs
ON config.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defs.defName)
WHEN MATCHED
    THEN UPDATE SET
	definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defs.defName),
	targetdefinition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defs.targetName),
	action_delay=defs.spoolTime,
	note='Stronghold mobile teleport capsule->field device mapping'
WHEN NOT MATCHED
    THEN INSERT (definition, targetdefinition, action_delay, note) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defs.defName),
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defs.targetName),
	defs.spoolTime,
	'Stronghold mobile teleport capsule->field device mapping');

PRINT N'[[itemshop]]';
MERGE [dbo].[itemshop] shop USING #SHOPENTRIES e
ON shop.targetdefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=e.defName)
WHEN MATCHED
    THEN UPDATE SET
		presetid=@tmShops,
		targetamount=1,
		tmcoin=e.tokenPrice,
		icscoin=e.tokenPrice,
		asicoin=e.tokenPrice,
		unicoin=e.tokenPrice,
		credit=e.nicPrice,
		standing=NULL
WHEN NOT MATCHED
    THEN INSERT (presetid, targetdefinition, targetamount, tmcoin, icscoin, asicoin, credit, unicoin, globallimit, purchasecount, standing) VALUES
	(@tmShops, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=e.defName), 1, 
	e.tokenPrice, e.tokenPrice, e.tokenPrice, e.nicPrice, e.tokenPrice, NULL, 1, NULL);


PRINT N'[zoneteleportdevicemap]';
MERGE [dbo].[zoneteleportdevicemap] map USING #DEVTOZONEMAP dev
ON map.zoneid = dev.targetZoneID
WHEN MATCHED
    THEN UPDATE SET
		map.sourcedefinition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = dev.defName)
WHEN NOT MATCHED
    THEN INSERT (sourcedefinition, zoneid) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = dev.defName), dev.targetZoneID);


DROP TABLE IF EXISTS #DEVTOZONEMAP;
DROP TABLE IF EXISTS #SHOPENTRIES;
DROP TABLE IF EXISTS #DEFCONFIGS;
DROP TABLE IF EXISTS #ENTITYDEFS;
GO

PRINT N'02_NPC_PBS_entitydef_inserts__2020_08_07.sql';
USE [perpetuumsa]
GO
--------------------------------------------------------------------------
-- NPC PBS DEFINITIONS + stronghold npcs
-- Inserts entitydefaults for: robot components and npc defs of npc-pbs
-- Insert aggregatevalues for stats and npc modifier/bonuses
-- Insert robottemplates and relations
-- Date: 2021/01/20
--------------------------------------------------------------------------

DECLARE @compDesc VARCHAR(MAX);
DECLARE @npcDesc VARCHAR(MAX);

SET @compDesc = 'def_npcpbs_component_desc';
SET @npcDesc = 'def_npc_pbs_desc';

DECLARE @baseResist AS INT = 150;
DECLARE @turretResist AS INT = 250;
DECLARE @turretResistPeak AS INT = 400;
DECLARE @turretLockRangeMod AS FLOAT = 1.5;
DECLARE @turretFalloffMod AS FLOAT = 2.0;
DECLARE @turretOptimalMod AS FLOAT = 1.0;
DECLARE @turretDamageMod AS FLOAT = 1.0;
DECLARE @turretRepAmountMod AS FLOAT = 8.0;
DECLARE @turretRepRateMod AS FLOAT = 0.5;

DROP TABLE IF EXISTS #ENTITYDEFS;
CREATE TABLE #ENTITYDEFS
(
	def INT,
	defName varchar(100),
	catFlags bigint,
	attrFlags bigint,
	cargoVolume float,
	massOfModule float,
	genxyOptStr varchar(max),
	description varchar(max),
);
INSERT INTO #ENTITYDEFS (def, defName, attrFlags, catFlags, cargoVolume, massOfModule, genxyOptStr, description) VALUES
--Robot component definitions
(5883,'def_npcpbs_turret_head', 1024, 336, 2, 1000, '#height=f0.10  #slotFlags=48,8,8,8,8,8,8,8', @compDesc),
(5884,'def_npcpbs_turret_chassis', 1024, 592, 2, 1000, '#slotFlags=4693,693  #height=f2.50  #decay=n500', @compDesc),
(5885,'def_npcpbs_turret_leg', 1024, 848, 2, 1000, '#height=f5.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5886,'def_npcpbs_reactor_leg', 1024, 848, 2, 1000, '#height=f5.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5887,'def_npcpbs_e_transmitter_leg', 1024, 848, 2, 1000, '#height=f5.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5888,'def_npcpbs_e_transfer_leg', 1024, 848, 2, 1000, '#height=f5.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5889,'def_npcpbs_e_battery_leg', 1024, 848, 2, 1000, '#height=f5.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5890,'def_npcpbs_facility_leg', 1024, 848, 2, 1000, '#height=f5.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5891,'def_npcpbs_facility_upgrade_leg', 1024, 848, 2, 1000, '#height=f5.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5892,'def_npcpbs_mining_tower_leg', 1024, 848, 2, 1000, '#height=f5.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5893,'def_npcpbs_repair_leg', 1024, 848, 2, 1000, '#height=f5.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5894,'def_npcpbs_eff_booster_leg', 1024, 848, 2, 1000, '#height=f5.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5895,'def_npcpbs_eff_emitter_leg', 1024, 848, 2, 1000, '#height=f5.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5896,'def_npcpbs_control_tower_leg', 1024, 848, 2, 1000, '#height=f5.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5897,'def_npcpbs_base_small_leg', 1024, 848, 2, 1000, '#height=f7.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5898,'def_npcpbs_base_medium_leg', 1024, 848, 2, 1000,'#height=f7.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5899,'def_npcpbs_base_large_leg', 1024, 848, 2, 1000, '#height=f7.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5900,'def_npcpbs_invis_head', 1024, 336, 2, 1000, '#height=f0.10  #slotFlags=48,8,8,8,8,8,8,8', @compDesc),
(5901,'def_npcpbs_invis_chassis', 1024, 592, 2, 1000,  '#height=f1.00', @compDesc),
--NPC defs
(5902,'def_npc_pbs_turret_laser_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5903,'def_npc_pbs_turret_em_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5904,'def_npc_pbs_turret_missile_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5905,'def_npc_pbs_turret_ew_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5906,'def_npc_pbs_reactor_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5907,'def_npc_pbs_e_emitter_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5908,'def_npc_pbs_e_transfer_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5909,'def_npc_pbs_e_battery_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5910,'def_npc_pbs_facility_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5911,'def_npc_pbs_facility_upgrade_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5912,'def_npc_pbs_miner_tower_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5913,'def_npc_pbs_energy_tower_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5914,'def_npc_pbs_repair_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5915,'def_npc_pbs_eff_booster_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5916,'def_npc_pbs_eff_emitter_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5917,'def_npc_pbs_control_tower_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5918,'def_npc_pbs_base_small_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5919,'def_npc_pbs_base_medium_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5920,'def_npc_pbs_base_large_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5921,'def_npc_sh70_mainboss', 1024, 911, 0, 0, NULL, 'def_npc_sh70_mainboss_desc'),
(5996,'def_npc_sh70_miniboss_a', 1024, 911, 0, 0, NULL, 'def_npc_sh70_miniboss_a_desc'),
(5997,'def_npc_sh70_miniboss_b', 1024, 911, 0, 0, NULL, 'def_npc_sh70_miniboss_b_desc');

DROP TABLE IF EXISTS #TEMPLATES;
CREATE TABLE #TEMPLATES
(
	tempName varchar(100),
	botName varchar(100),
	headName varchar(100),
	chassisName varchar(100),
	legName varchar(100),
	inventoryName varchar(100),
	loadOut VARCHAR(MAX)
);
INSERT INTO #TEMPLATES (tempName, botName, headName, chassisName, legName, inventoryName, loadOut) VALUES
('def_npc_pbs_turret_laser_template', 'def_pbs_turret_bot', 'def_npcpbs_turret_head', 'def_npcpbs_turret_chassis', 'def_npcpbs_turret_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[|m0=[|definition=i12ff|slot=i1|ammoDefinition=i1439|ammoQuantity=i19]|m1=[|definition=i12ff|slot=i2|ammoDefinition=i1439|ammoQuantity=i19]]#legModules=[|m0=[|definition=i14|slot=i1]]'),
('def_npc_pbs_turret_em_temlate', 'def_pbs_turret_bot', 'def_npcpbs_turret_head', 'def_npcpbs_turret_chassis', 'def_npcpbs_turret_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[|m0=[|definition=i1301|slot=i1|ammoDefinition=i1438|ammoQuantity=i14]|m1=[|definition=i1301|slot=i2|ammoDefinition=i1438|ammoQuantity=i14]]#legModules=[|m0=[|definition=i14|slot=i1]]'),
('def_npc_pbs_turret_missile_template', 'def_pbs_turret_bot', 'def_npcpbs_turret_head', 'def_npcpbs_turret_chassis', 'def_npcpbs_turret_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[|m0=[|definition=i1300|slot=i1|ammoDefinition=i143a|ammoQuantity=i14]|m1=[|definition=i1300|slot=i2|ammoDefinition=i143a|ammoQuantity=i14]]#legModules=[|m0=[|definition=i14|slot=i1]]'),
('def_npc_pbs_turret_ew_template', 'def_pbs_turret_bot', 'def_npcpbs_turret_head', 'def_npcpbs_turret_chassis', 'def_npcpbs_turret_leg', 'def_robot_inventory_daidalos',
'#headModules=[|m0=[|definition=i1370|slot=i1]|m1=[|definition=i1371|slot=i2]|m2=[|definition=i1372|slot=i3]|m3=[|definition=i1371|slot=i4]|m4=[|definition=i1372|slot=i5]]#chassisModules=[|m0=[|definition=i136f|slot=i1]|m1=[|definition=i136f|slot=i2]]#legModules=[|m0=[|definition=i14|slot=i1]]'),
('def_npc_pbs_reactor_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_reactor_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]'),
('def_npc_pbs_e_emitter_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_e_transmitter_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]'),
('def_npc_pbs_e_transfer_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_e_transfer_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]'),
('def_npc_pbs_e_battery_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_e_battery_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]'),
('def_npc_pbs_facility_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_facility_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]'),
('def_npc_pbs_facility_upgrade_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_facility_upgrade_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]'),
('def_npc_pbs_miner_tower_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_mining_tower_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]'),
('def_npc_pbs_repair_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_repair_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]'),
('def_npc_pbs_eff_booster_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_eff_booster_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]'),
('def_npc_pbs_eff_emitter_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_eff_emitter_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]'),
('def_npc_pbs_control_tower_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_control_tower_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]'),
('def_npc_pbs_base_small_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_base_small_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]'),
('def_npc_pbs_base_medium_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_base_medium_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]'),
('def_npc_pbs_base_large_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_base_large_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]'),
('def_npc_sh70_miniboss_a_template', 'def_ictus_mk2_bot', 'def_ictus_head_mk2', 'def_ictus_chassis_mk2', 'def_ictus_leg_mk2', 'def_robot_inventory_daidalos',
'#headModules=[|m0=[|definition=i32|slot=i1]|m1=[|definition=i33|slot=i2]|m2=[|definition=i33|slot=i3]|m3=[|definition=i32|slot=i4]]#chassisModules=[|m0=[|definition=i27|slot=i1]|m1=[|definition=i27|slot=i2]|m2=[|definition=i40|slot=i3|ammoDefinition=i991|ammoQuantity=if]|m3=[|definition=i40|slot=i4|ammoDefinition=i992|ammoQuantity=if]|m4=[|definition=i27|slot=i5]]#legModules=[|m0=[|definition=i1d|slot=i1]|m1=[|definition=i28a|slot=i2|ammoDefinition=i298|ammoQuantity=ia]|m2=[|definition=i14|slot=i3]|m3=[|definition=i18|slot=i4]]'),
('def_npc_sh70_miniboss_b_template', 'def_tyrannos_mk2_bot', 'def_tyrannos_head_mk2', 'def_tyrannos_chassis_mk2', 'def_tyrannos_leg_mk2', 'def_robot_inventory_daidalos',
'#headModules=[|m0=[|definition=i31|slot=i1]|m1=[|definition=i32|slot=i2]|m2=[|definition=i33|slot=i3]|m3=[|definition=i34|slot=i4]|m4=[|definition=i34|slot=i5]]#chassisModules=[|m0=[|definition=i40|slot=i1|ammoDefinition=i992|ammoQuantity=if]|m1=[|definition=i40|slot=i2|ammoDefinition=i991|ammoQuantity=if]|m2=[|definition=i40|slot=i3|ammoDefinition=i992|ammoQuantity=if]|m3=[|definition=i40|slot=i4|ammoDefinition=i991|ammoQuantity=if]|m4=[|definition=i3e9|slot=i5|ammoDefinition=i101|ammoQuantity=if]|m5=[|definition=i3e9|slot=i6|ammoDefinition=i102|ammoQuantity=if]]#legModules=[|m0=[|definition=i1d|slot=i1]|m1=[|definition=i289|slot=i2|ammoDefinition=i298|ammoQuantity=ia]|m2=[|definition=i1a|slot=i3]|m3=[|definition=i14|slot=i4]]'),
('def_npc_sh70_mainboss_template', 'def_hydra_bot', 'def_hydra_bot_head', 'def_hydra_bot_chassis', 'def_hydra_bot_leg', 'def_robot_inventory_daidalos',
'#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=ib52|slot=i2]|m2=[|definition=i32|slot=i3]|m3=[|definition=i33|slot=i4]|m4=[|definition=i34|slot=i5]]#chassisModules=[|m0=[|definition=i41|slot=i1|ammoDefinition=i123|ammoQuantity=i32]|m1=[|definition=i41|slot=i2|ammoDefinition=i123|ammoQuantity=i32]|m2=[|definition=i41|slot=i3|ammoDefinition=i123|ammoQuantity=i32]|m3=[|definition=i41|slot=i4|ammoDefinition=i123|ammoQuantity=i32]|m4=[|definition=i41|slot=i5|ammoDefinition=i123|ammoQuantity=i32]|m5=[|definition=i41|slot=i6|ammoDefinition=i123|ammoQuantity=i32]]#legModules=[|m0=[|definition=i11|slot=i1]|m1=[|definition=i14|slot=i2]|m2=[|definition=i19|slot=i3]|m3=[|definition=i287|slot=i4]]');

DROP TABLE IF EXISTS #TEMPRELATIONS;
CREATE TABLE #TEMPRELATIONS
(
	defName varchar(100),
	tempName varchar(100),
	epKill INT,
);
INSERT INTO #TEMPRELATIONS (defName, tempName, epKill) VALUES
('def_npc_pbs_turret_laser_rank1', 'def_npc_pbs_turret_laser_template', 10),
('def_npc_pbs_turret_em_rank1', 'def_npc_pbs_turret_em_temlate', 10),
('def_npc_pbs_turret_missile_rank1', 'def_npc_pbs_turret_missile_template', 10),
('def_npc_pbs_turret_ew_rank1', 'def_npc_pbs_turret_ew_template', 10),
('def_npc_pbs_reactor_rank1', 'def_npc_pbs_reactor_template', 20),
('def_npc_pbs_e_emitter_rank1', 'def_npc_pbs_e_emitter_template', 10),
('def_npc_pbs_e_transfer_rank1', 'def_npc_pbs_e_transfer_template', 10),
('def_npc_pbs_e_battery_rank1', 'def_npc_pbs_e_battery_template', 10),
('def_npc_pbs_facility_rank1', 'def_npc_pbs_facility_template', 10),
('def_npc_pbs_facility_upgrade_rank1', 'def_npc_pbs_facility_upgrade_template', 10),
('def_npc_pbs_miner_tower_rank1', 'def_npc_pbs_miner_tower_template', 15),
('def_npc_pbs_energy_tower_rank1', 'def_npc_pbs_miner_tower_template', 15),
('def_npc_pbs_repair_rank1', 'def_npc_pbs_miner_tower_template', 15),
('def_npc_pbs_eff_booster_rank1', 'def_npc_pbs_eff_booster_template', 15),
('def_npc_pbs_eff_emitter_rank1', 'def_npc_pbs_eff_emitter_template', 15),
('def_npc_pbs_control_tower_rank1', 'def_npc_pbs_control_tower_template', 20),
('def_npc_pbs_base_small_rank1', 'def_npc_pbs_base_small_template', 50),
('def_npc_pbs_base_medium_rank1', 'def_npc_pbs_base_medium_template', 100),
('def_npc_pbs_base_large_rank1', 'def_npc_pbs_base_large_template', 150),
('def_npc_sh70_miniboss_a', 'def_npc_sh70_miniboss_a_template', 200),
('def_npc_sh70_miniboss_b', 'def_npc_sh70_miniboss_b_template', 200),
('def_npc_sh70_mainboss', 'def_npc_sh70_mainboss_template', 1000);

DROP TABLE IF EXISTS #STATS;
CREATE TABLE #STATS
(
	defName varchar(100),
	fieldName varchar(100),
	fieldValue float,
);
INSERT INTO #STATS (defName, fieldName, fieldValue) VALUES
('def_npcpbs_turret_head', 'cpu_max', 5000),
('def_npcpbs_turret_head', 'locked_targets_max', 100),
('def_npcpbs_turret_head', 'locking_range', 100),
('def_npcpbs_turret_head', 'locking_time', 5000),
('def_npcpbs_turret_head', 'sensor_strength', 200),
('def_npcpbs_turret_head', 'detection_strength', 125),
('def_npcpbs_turret_head', 'stealth_strength', 100),
('def_npcpbs_turret_head', 'blob_level_low', 300),
('def_npcpbs_turret_head', 'blob_level_high', 500),
('def_npcpbs_turret_chassis', 'ammo_reload_time', 10000),
('def_npcpbs_turret_chassis', 'armor_max', 75000),
('def_npcpbs_turret_chassis', 'core_max', 30000),
('def_npcpbs_turret_chassis', 'core_recharge_time', 300),
('def_npcpbs_turret_chassis', 'powergrid_max', 5000),
('def_npcpbs_turret_chassis', 'resist_chemical', @baseResist),
('def_npcpbs_turret_chassis', 'resist_explosive', @baseResist),
('def_npcpbs_turret_chassis', 'resist_kinetic', @baseResist),
('def_npcpbs_turret_chassis', 'resist_thermal', @baseResist),
('def_npcpbs_turret_chassis', 'signature_radius', 30),
('def_npcpbs_turret_chassis', 'missile_miss', 1),
('def_npcpbs_turret_chassis', 'reactor_radiation', 1),
('def_npcpbs_turret_leg', 'speed_max', 0),
('def_npcpbs_turret_leg', 'slope', 4),
--
('def_npcpbs_reactor_leg', 'armor_max', 100000),
('def_npcpbs_reactor_leg', 'resist_chemical', @baseResist),
('def_npcpbs_reactor_leg', 'resist_explosive', @baseResist),
('def_npcpbs_reactor_leg', 'resist_kinetic', @baseResist),
('def_npcpbs_reactor_leg', 'resist_thermal', @baseResist),
('def_npcpbs_reactor_leg', 'signature_radius', 30),
--
('def_npcpbs_e_transmitter_leg', 'armor_max', 50000),
('def_npcpbs_e_transmitter_leg', 'resist_chemical', @baseResist),
('def_npcpbs_e_transmitter_leg', 'resist_explosive', @baseResist),
('def_npcpbs_e_transmitter_leg', 'resist_kinetic', @baseResist),
('def_npcpbs_e_transmitter_leg', 'resist_thermal', @baseResist),
('def_npcpbs_e_transmitter_leg', 'signature_radius', 20),
--
('def_npcpbs_e_transfer_leg', 'armor_max', 50000),
('def_npcpbs_e_transfer_leg', 'resist_chemical', @baseResist),
('def_npcpbs_e_transfer_leg', 'resist_explosive', @baseResist),
('def_npcpbs_e_transfer_leg', 'resist_kinetic', @baseResist),
('def_npcpbs_e_transfer_leg', 'resist_thermal', @baseResist),
('def_npcpbs_e_transfer_leg', 'signature_radius', 20),
--
('def_npcpbs_e_battery_leg', 'armor_max', 75000),
('def_npcpbs_e_battery_leg', 'resist_chemical', @baseResist),
('def_npcpbs_e_battery_leg', 'resist_explosive', @baseResist),
('def_npcpbs_e_battery_leg', 'resist_kinetic', @baseResist),
('def_npcpbs_e_battery_leg', 'resist_thermal', @baseResist),
('def_npcpbs_e_battery_leg', 'signature_radius', 25),
--
('def_npcpbs_facility_leg', 'armor_max', 10000),
('def_npcpbs_facility_leg', 'resist_chemical', @baseResist),
('def_npcpbs_facility_leg', 'resist_explosive', @baseResist),
('def_npcpbs_facility_leg', 'resist_kinetic', @baseResist),
('def_npcpbs_facility_leg', 'resist_thermal', @baseResist),
('def_npcpbs_facility_leg', 'signature_radius', 35),
--
('def_npcpbs_facility_upgrade_leg', 'armor_max', 25000),
('def_npcpbs_facility_upgrade_leg', 'resist_chemical', @baseResist),
('def_npcpbs_facility_upgrade_leg', 'resist_explosive', @baseResist),
('def_npcpbs_facility_upgrade_leg', 'resist_kinetic', @baseResist),
('def_npcpbs_facility_upgrade_leg', 'resist_thermal', @baseResist),
('def_npcpbs_facility_upgrade_leg', 'signature_radius', 20),
--
('def_npcpbs_mining_tower_leg', 'armor_max', 75000),
('def_npcpbs_mining_tower_leg', 'resist_chemical', @baseResist),
('def_npcpbs_mining_tower_leg', 'resist_explosive', @baseResist),
('def_npcpbs_mining_tower_leg', 'resist_kinetic', @baseResist),
('def_npcpbs_mining_tower_leg', 'resist_thermal', @baseResist),
('def_npcpbs_mining_tower_leg', 'signature_radius', 30),
--
('def_npcpbs_repair_leg', 'armor_max', 50000),
('def_npcpbs_repair_leg', 'resist_chemical', @baseResist),
('def_npcpbs_repair_leg', 'resist_explosive', @baseResist),
('def_npcpbs_repair_leg', 'resist_kinetic', @baseResist),
('def_npcpbs_repair_leg', 'resist_thermal', @baseResist),
('def_npcpbs_repair_leg', 'signature_radius', 20),
--
('def_npcpbs_eff_booster_leg', 'armor_max', 25000),
('def_npcpbs_eff_booster_leg', 'resist_chemical', @baseResist),
('def_npcpbs_eff_booster_leg', 'resist_explosive', @baseResist),
('def_npcpbs_eff_booster_leg', 'resist_kinetic', @baseResist),
('def_npcpbs_eff_booster_leg', 'resist_thermal', @baseResist),
('def_npcpbs_eff_booster_leg', 'signature_radius', 20),
--
('def_npcpbs_eff_emitter_leg', 'armor_max', 25000),
('def_npcpbs_eff_emitter_leg', 'resist_chemical', @baseResist),
('def_npcpbs_eff_emitter_leg', 'resist_explosive', @baseResist),
('def_npcpbs_eff_emitter_leg', 'resist_kinetic', @baseResist),
('def_npcpbs_eff_emitter_leg', 'resist_thermal', @baseResist),
('def_npcpbs_eff_emitter_leg', 'signature_radius', 20),
--
('def_npcpbs_control_tower_leg', 'armor_max', 50000),
('def_npcpbs_control_tower_leg', 'resist_chemical', @baseResist),
('def_npcpbs_control_tower_leg', 'resist_explosive', @baseResist),
('def_npcpbs_control_tower_leg', 'resist_kinetic', @baseResist),
('def_npcpbs_control_tower_leg', 'resist_thermal', @baseResist),
('def_npcpbs_control_tower_leg', 'signature_radius', 30),
--
('def_npcpbs_base_small_leg', 'armor_max', 100000),
('def_npcpbs_base_small_leg', 'resist_chemical', @baseResist),
('def_npcpbs_base_small_leg', 'resist_explosive', @baseResist),
('def_npcpbs_base_small_leg', 'resist_kinetic', @baseResist),
('def_npcpbs_base_small_leg', 'resist_thermal', @baseResist),
('def_npcpbs_base_small_leg', 'signature_radius', 30),
--
('def_npcpbs_base_medium_leg', 'armor_max', 125000),
('def_npcpbs_base_medium_leg', 'resist_chemical', @baseResist),
('def_npcpbs_base_medium_leg', 'resist_explosive', @baseResist),
('def_npcpbs_base_medium_leg', 'resist_kinetic', @baseResist),
('def_npcpbs_base_medium_leg', 'resist_thermal', @baseResist),
('def_npcpbs_base_medium_leg', 'signature_radius', 35),
--
('def_npcpbs_base_large_leg', 'armor_max', 150000),
('def_npcpbs_base_large_leg', 'resist_chemical', @baseResist),
('def_npcpbs_base_large_leg', 'resist_explosive', @baseResist),
('def_npcpbs_base_large_leg', 'resist_kinetic', @baseResist),
('def_npcpbs_base_large_leg', 'resist_thermal', @baseResist),
('def_npcpbs_base_large_leg', 'signature_radius', 45),

--common to all non-turret npcs
('def_npcpbs_invis_head', 'cpu_max', 1000),
('def_npcpbs_invis_head', 'locked_targets_max', 0),
('def_npcpbs_invis_head', 'locking_range', 1),
('def_npcpbs_invis_head', 'locking_time', 10000),
('def_npcpbs_invis_head', 'sensor_strength', 200),
('def_npcpbs_invis_head', 'detection_strength', 125),
('def_npcpbs_invis_head', 'stealth_strength', 100),
('def_npcpbs_invis_head', 'blob_level_low', 300),
('def_npcpbs_invis_head', 'blob_level_high', 500),
('def_npcpbs_invis_head', 'ammo_reload_time', 10000),
('def_npcpbs_invis_head', 'core_max', 3000),
('def_npcpbs_invis_head', 'core_recharge_time', 1800),
('def_npcpbs_invis_head', 'powergrid_max', 1000),
('def_npcpbs_invis_head', 'missile_miss', 1),
('def_npcpbs_invis_head', 'reactor_radiation', 1),
('def_npcpbs_invis_head', 'speed_max', 0),
('def_npcpbs_invis_head', 'slope', 4),
--
('def_npc_pbs_turret_laser_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_turret_laser_rank1', 'armor_repair_amount_modifier', @turretRepAmountMod),
('def_npc_pbs_turret_laser_rank1', 'armor_repair_cycle_time_modifier', @turretRepRateMod),
('def_npc_pbs_turret_laser_rank1', 'core_max_modifier',2),
('def_npc_pbs_turret_laser_rank1', 'core_recharge_time_modifier',0.5),
('def_npc_pbs_turret_laser_rank1', 'damage_modifier', @turretDamageMod),
('def_npc_pbs_turret_laser_rank1', 'falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_laser_rank1', 'locking_range_modifier', @turretLockRangeMod),
('def_npc_pbs_turret_laser_rank1', 'locking_time_modifier', 1.25),
('def_npc_pbs_turret_laser_rank1', 'missile_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_laser_rank1', 'optimal_range_modifier', @turretOptimalMod),
('def_npc_pbs_turret_laser_rank1', 'turret_fallof_modifier', @turretFalloffMod),
('def_npc_pbs_turret_laser_rank1', 'resist_chemical', @turretResist),
('def_npc_pbs_turret_laser_rank1', 'resist_explosive', @turretResist),
('def_npc_pbs_turret_laser_rank1', 'resist_kinetic', @turretResist),
('def_npc_pbs_turret_laser_rank1', 'resist_thermal', @turretResistPeak),
('def_npc_pbs_turret_laser_rank1', 'turret_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_laser_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_turret_em_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_turret_em_rank1', 'armor_repair_amount_modifier', @turretRepAmountMod),
('def_npc_pbs_turret_em_rank1', 'armor_repair_cycle_time_modifier', @turretRepRateMod),
('def_npc_pbs_turret_em_rank1', 'core_max_modifier',2),
('def_npc_pbs_turret_em_rank1', 'core_recharge_time_modifier',0.5),
('def_npc_pbs_turret_em_rank1', 'damage_modifier', @turretDamageMod),
('def_npc_pbs_turret_em_rank1', 'falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_em_rank1', 'locking_range_modifier', @turretLockRangeMod),
('def_npc_pbs_turret_em_rank1', 'locking_time_modifier', 1.25),
('def_npc_pbs_turret_em_rank1', 'missile_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_em_rank1', 'optimal_range_modifier', @turretOptimalMod),
('def_npc_pbs_turret_em_rank1', 'turret_fallof_modifier', @turretFalloffMod),
('def_npc_pbs_turret_em_rank1', 'resist_chemical', @turretResist),
('def_npc_pbs_turret_em_rank1', 'resist_explosive', @turretResist),
('def_npc_pbs_turret_em_rank1', 'resist_kinetic', @turretResistPeak),
('def_npc_pbs_turret_em_rank1', 'resist_thermal', @turretResist),
('def_npc_pbs_turret_em_rank1', 'turret_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_em_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_turret_missile_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_turret_missile_rank1', 'armor_repair_amount_modifier', @turretRepAmountMod),
('def_npc_pbs_turret_missile_rank1', 'armor_repair_cycle_time_modifier', @turretRepRateMod),
('def_npc_pbs_turret_missile_rank1', 'core_max_modifier',2),
('def_npc_pbs_turret_missile_rank1', 'core_recharge_time_modifier',0.5),
('def_npc_pbs_turret_missile_rank1', 'damage_modifier', @turretDamageMod),
('def_npc_pbs_turret_missile_rank1', 'falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_missile_rank1', 'locking_range_modifier', @turretLockRangeMod),
('def_npc_pbs_turret_missile_rank1', 'locking_time_modifier', 1.25),
('def_npc_pbs_turret_missile_rank1', 'missile_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_missile_rank1', 'effect_missile_range_modifier', 1.1),
('def_npc_pbs_turret_missile_rank1', 'optimal_range_modifier', @turretOptimalMod),
('def_npc_pbs_turret_missile_rank1', 'missile_falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_missile_rank1', 'resist_chemical', @turretResist),
('def_npc_pbs_turret_missile_rank1', 'resist_explosive', @turretResistPeak),
('def_npc_pbs_turret_missile_rank1', 'resist_kinetic', @turretResist),
('def_npc_pbs_turret_missile_rank1', 'resist_thermal', @turretResist),
('def_npc_pbs_turret_missile_rank1', 'turret_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_missile_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_turret_ew_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_turret_ew_rank1', 'armor_repair_amount_modifier', @turretRepAmountMod),
('def_npc_pbs_turret_ew_rank1', 'armor_repair_cycle_time_modifier', @turretRepRateMod),
('def_npc_pbs_turret_ew_rank1', 'core_max_modifier',2),
('def_npc_pbs_turret_ew_rank1', 'core_recharge_time_modifier',0.5),
('def_npc_pbs_turret_ew_rank1', 'damage_modifier', @turretDamageMod),
('def_npc_pbs_turret_ew_rank1', 'ecm_strength_modifier', @turretDamageMod),
('def_npc_pbs_turret_ew_rank1', 'energy_neutralized_amount_modifier', @turretDamageMod),
('def_npc_pbs_turret_ew_rank1', 'falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_ew_rank1', 'locking_range_modifier', @turretLockRangeMod),
('def_npc_pbs_turret_ew_rank1', 'locking_time_modifier', 1.25),
('def_npc_pbs_turret_ew_rank1', 'missile_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_ew_rank1', 'optimal_range_modifier', @turretOptimalMod),
('def_npc_pbs_turret_ew_rank1', 'resist_chemical', @turretResist),
('def_npc_pbs_turret_ew_rank1', 'resist_explosive', @turretResist),
('def_npc_pbs_turret_ew_rank1', 'resist_kinetic', @turretResist),
('def_npc_pbs_turret_ew_rank1', 'resist_thermal', @turretResist),
('def_npc_pbs_turret_ew_rank1', 'turret_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_ew_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_reactor_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_reactor_rank1', 'resist_chemical', @baseResist),
('def_npc_pbs_reactor_rank1', 'resist_explosive', @baseResist),
('def_npc_pbs_reactor_rank1', 'resist_kinetic', @baseResist),
('def_npc_pbs_reactor_rank1', 'resist_thermal', @baseResist),
('def_npc_pbs_reactor_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_e_emitter_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_e_emitter_rank1', 'resist_chemical', @baseResist),
('def_npc_pbs_e_emitter_rank1', 'resist_explosive', @baseResist),
('def_npc_pbs_e_emitter_rank1', 'resist_kinetic', @baseResist),
('def_npc_pbs_e_emitter_rank1', 'resist_thermal', @baseResist),
('def_npc_pbs_e_emitter_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_e_transfer_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_e_transfer_rank1', 'resist_chemical', @baseResist),
('def_npc_pbs_e_transfer_rank1', 'resist_explosive', @baseResist),
('def_npc_pbs_e_transfer_rank1', 'resist_kinetic', @baseResist),
('def_npc_pbs_e_transfer_rank1', 'resist_thermal', @baseResist),
('def_npc_pbs_e_transfer_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_e_battery_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_e_battery_rank1', 'resist_chemical', @baseResist),
('def_npc_pbs_e_battery_rank1', 'resist_explosive', @baseResist),
('def_npc_pbs_e_battery_rank1', 'resist_kinetic', @baseResist),
('def_npc_pbs_e_battery_rank1', 'resist_thermal', @baseResist),
('def_npc_pbs_e_battery_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_facility_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_facility_rank1', 'resist_chemical', @baseResist),
('def_npc_pbs_facility_rank1', 'resist_explosive', @baseResist),
('def_npc_pbs_facility_rank1', 'resist_kinetic', @baseResist),
('def_npc_pbs_facility_rank1', 'resist_thermal', @baseResist),
('def_npc_pbs_facility_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_facility_upgrade_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_facility_upgrade_rank1', 'resist_chemical', @baseResist),
('def_npc_pbs_facility_upgrade_rank1', 'resist_explosive', @baseResist),
('def_npc_pbs_facility_upgrade_rank1', 'resist_kinetic', @baseResist),
('def_npc_pbs_facility_upgrade_rank1', 'resist_thermal', @baseResist),
('def_npc_pbs_facility_upgrade_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_miner_tower_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_miner_tower_rank1', 'resist_chemical', @baseResist),
('def_npc_pbs_miner_tower_rank1', 'resist_explosive', @baseResist),
('def_npc_pbs_miner_tower_rank1', 'resist_kinetic', @baseResist),
('def_npc_pbs_miner_tower_rank1', 'resist_thermal', @baseResist),
('def_npc_pbs_miner_tower_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_energy_tower_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_energy_tower_rank1', 'resist_chemical', @baseResist),
('def_npc_pbs_energy_tower_rank1', 'resist_explosive', @baseResist),
('def_npc_pbs_energy_tower_rank1', 'resist_kinetic', @baseResist),
('def_npc_pbs_energy_tower_rank1', 'resist_thermal', @baseResist),
('def_npc_pbs_energy_tower_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_repair_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_repair_rank1', 'resist_chemical', @baseResist),
('def_npc_pbs_repair_rank1', 'resist_explosive', @baseResist),
('def_npc_pbs_repair_rank1', 'resist_kinetic', @baseResist),
('def_npc_pbs_repair_rank1', 'resist_thermal', @baseResist),
('def_npc_pbs_repair_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_eff_booster_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_eff_booster_rank1', 'resist_chemical', @baseResist),
('def_npc_pbs_eff_booster_rank1', 'resist_explosive', @baseResist),
('def_npc_pbs_eff_booster_rank1', 'resist_kinetic', @baseResist),
('def_npc_pbs_eff_booster_rank1', 'resist_thermal', @baseResist),
('def_npc_pbs_eff_booster_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_eff_emitter_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_eff_emitter_rank1', 'resist_chemical', @baseResist),
('def_npc_pbs_eff_emitter_rank1', 'resist_explosive', @baseResist),
('def_npc_pbs_eff_emitter_rank1', 'resist_kinetic', @baseResist),
('def_npc_pbs_eff_emitter_rank1', 'resist_thermal', @baseResist),
('def_npc_pbs_eff_emitter_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_control_tower_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_control_tower_rank1', 'resist_chemical', @baseResist),
('def_npc_pbs_control_tower_rank1', 'resist_explosive', @baseResist),
('def_npc_pbs_control_tower_rank1', 'resist_kinetic', @baseResist),
('def_npc_pbs_control_tower_rank1', 'resist_thermal', @baseResist),
('def_npc_pbs_control_tower_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_base_small_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_base_small_rank1', 'resist_chemical', @baseResist),
('def_npc_pbs_base_small_rank1', 'resist_explosive', @baseResist),
('def_npc_pbs_base_small_rank1', 'resist_kinetic', @baseResist),
('def_npc_pbs_base_small_rank1', 'resist_thermal', @baseResist),
('def_npc_pbs_base_small_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_base_medium_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_base_medium_rank1', 'resist_chemical', @baseResist),
('def_npc_pbs_base_medium_rank1', 'resist_explosive', @baseResist),
('def_npc_pbs_base_medium_rank1', 'resist_kinetic', @baseResist),
('def_npc_pbs_base_medium_rank1', 'resist_thermal', @baseResist),
('def_npc_pbs_base_medium_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_base_large_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_base_large_rank1', 'resist_chemical', @baseResist),
('def_npc_pbs_base_large_rank1', 'resist_explosive', @baseResist),
('def_npc_pbs_base_large_rank1', 'resist_kinetic', @baseResist),
('def_npc_pbs_base_large_rank1', 'resist_thermal', @baseResist),
('def_npc_pbs_base_large_rank1', 'received_repaired_modifier', 1.1), 

('def_npc_sh70_miniboss_a', 'armor_max_modifier',5.5),
('def_npc_sh70_miniboss_a', 'armor_repair_amount_modifier', 1.55),
('def_npc_sh70_miniboss_a', 'armor_repair_cycle_time_modifier', 0.67),
('def_npc_sh70_miniboss_a', 'core_max_modifier',5.25),
('def_npc_sh70_miniboss_a', 'core_recharge_time_modifier',0.55),
('def_npc_sh70_miniboss_a', 'cpu_max_modifier',2),
('def_npc_sh70_miniboss_a', 'damage_modifier', 3),
('def_npc_sh70_miniboss_a', 'detection_strength_modifier',15),
('def_npc_sh70_miniboss_a', 'falloff_modifier',2.5),
('def_npc_sh70_miniboss_a', 'missile_falloff_modifier', 2.5),
('def_npc_sh70_miniboss_a', 'locking_range_modifier',4),
('def_npc_sh70_miniboss_a', 'locking_time_modifier',1.25),
('def_npc_sh70_miniboss_a', 'locked_targets_max_bonus',10),
('def_npc_sh70_miniboss_a', 'missile_cycle_time_modifier',1),
('def_npc_sh70_miniboss_a', 'optimal_range_modifier',3),
('def_npc_sh70_miniboss_a', 'powergrid_max_modifier',3),
('def_npc_sh70_miniboss_a', 'resist_chemical',400),
('def_npc_sh70_miniboss_a', 'resist_explosive',400),
('def_npc_sh70_miniboss_a', 'resist_kinetic',400),
('def_npc_sh70_miniboss_a', 'resist_thermal',400),
('def_npc_sh70_miniboss_a', 'speed_max_modifier', 1.5),
('def_npc_sh70_miniboss_a', 'turret_fallof_modifier', 2.5),
('def_npc_sh70_miniboss_a', 'turret_cycle_time_modifier',1),
('def_npc_sh70_miniboss_a', 'received_repaired_modifier',1.25),

('def_npc_sh70_miniboss_b', 'armor_max_modifier',5.5),
('def_npc_sh70_miniboss_b', 'armor_repair_amount_modifier', 1.55),
('def_npc_sh70_miniboss_b', 'armor_repair_cycle_time_modifier', 0.67),
('def_npc_sh70_miniboss_b', 'core_max_modifier',5.25),
('def_npc_sh70_miniboss_b', 'core_recharge_time_modifier',0.55),
('def_npc_sh70_miniboss_b', 'cpu_max_modifier',2),
('def_npc_sh70_miniboss_b', 'damage_modifier', 3),
('def_npc_sh70_miniboss_b', 'detection_strength_modifier',15),
('def_npc_sh70_miniboss_b', 'falloff_modifier',2.5),
('def_npc_sh70_miniboss_b', 'missile_falloff_modifier', 2.5),
('def_npc_sh70_miniboss_b', 'locking_range_modifier',4),
('def_npc_sh70_miniboss_b', 'locking_time_modifier',1.25),
('def_npc_sh70_miniboss_b', 'locked_targets_max_bonus',10),
('def_npc_sh70_miniboss_b', 'missile_cycle_time_modifier',1),
('def_npc_sh70_miniboss_b', 'optimal_range_modifier',3),
('def_npc_sh70_miniboss_b', 'powergrid_max_modifier',3),
('def_npc_sh70_miniboss_b', 'resist_chemical',400),
('def_npc_sh70_miniboss_b', 'resist_explosive',400),
('def_npc_sh70_miniboss_b', 'resist_kinetic',400),
('def_npc_sh70_miniboss_b', 'resist_thermal',400),
('def_npc_sh70_miniboss_b', 'speed_max_modifier', 1.5),
('def_npc_sh70_miniboss_b', 'turret_fallof_modifier', 2.5),
('def_npc_sh70_miniboss_b', 'turret_cycle_time_modifier',1),
('def_npc_sh70_miniboss_b', 'received_repaired_modifier',1.25),

('def_npc_sh70_mainboss', 'armor_max_modifier',5.5),
('def_npc_sh70_mainboss', 'armor_repair_amount_modifier', 2.55),
('def_npc_sh70_mainboss', 'armor_repair_cycle_time_modifier', 0.67),
('def_npc_sh70_mainboss', 'core_max_modifier',5.25),
('def_npc_sh70_mainboss', 'core_recharge_time_modifier',0.65),
('def_npc_sh70_mainboss', 'cpu_max_modifier',2),
('def_npc_sh70_mainboss', 'damage_modifier', 5),
('def_npc_sh70_mainboss', 'detection_strength_modifier',5),
('def_npc_sh70_mainboss', 'falloff_modifier',2.5),
('def_npc_sh70_mainboss', 'missile_falloff_modifier', 2.5),
('def_npc_sh70_mainboss', 'locking_range_modifier',4),
('def_npc_sh70_mainboss', 'locking_time_modifier',1.25),
('def_npc_sh70_mainboss', 'locked_targets_max_bonus',10),
('def_npc_sh70_mainboss', 'missile_cycle_time_modifier',1),
('def_npc_sh70_mainboss', 'optimal_range_modifier',3),
('def_npc_sh70_mainboss', 'powergrid_max_modifier',3),
('def_npc_sh70_mainboss', 'resist_chemical',600),
('def_npc_sh70_mainboss', 'resist_explosive',600),
('def_npc_sh70_mainboss', 'resist_kinetic',600),
('def_npc_sh70_mainboss', 'resist_thermal',600),
('def_npc_sh70_mainboss', 'speed_max_modifier', 1.75),
('def_npc_sh70_mainboss', 'turret_cycle_time_modifier',1),
('def_npc_sh70_mainboss', 'received_repaired_modifier',1.25);

SET IDENTITY_INSERT [dbo].[entitydefaults] ON;
PRINT N'UPDATE/INSERT ENTITY DEFS for NPC PBS definitions';
--Update/insert [entitydefaults] entries
MERGE [dbo].[entitydefaults] def USING #ENTITYDEFS d2
ON def.definition = d2.def
WHEN MATCHED
    THEN UPDATE SET
		definitionname=defName,
		categoryflags=catFlags,
		attributeflags=attrFlags,
		volume=cargoVolume,
		mass=massOfModule,
		tiertype=NULL,
		tierlevel=NULL,
		options=genxyOptStr,
		enabled=1,
		hidden=0,
		purchasable=0,
		descriptiontoken=description
WHEN NOT MATCHED
    THEN INSERT (definition, definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel) VALUES
	(def, defName, 1, attrFlags, catFlags, genxyOptStr, 'NPC PBS components and bot definitions', 1 ,cargoVolume, massOfModule, 0, 100, description, 0, NULL, NULL);
SET IDENTITY_INSERT [dbo].[entitydefaults] OFF;

PRINT N'DELETE OLD STATS (0 results if 1st run)';
DELETE FROM aggregatevalues WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #STATS));

PRINT N'INSERT NEW STATS';
INSERT INTO aggregatevalues (definition, field, value)
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defName), 
	(SELECT TOP 1 id FROM aggregatefields WHERE name=fieldName), 
	fieldValue
FROM #STATS;

DELETE FROM robottemplaterelation WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #TEMPRELATIONS));
DELETE FROM robottemplates WHERE name in (SELECT tempName FROM #TEMPLATES);

INSERT INTO robottemplates (name, description, note)
SELECT t.tempName,
	'#robot=i'+dbo.ToHex((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=t.botName))+
	'#head=i'+dbo.ToHex((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=t.headName))+
	'#chassis=i'+dbo.ToHex((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=t.chassisName))+
	'#leg=i'+dbo.ToHex((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=t.legName))+
	'#container=i'+dbo.ToHex((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=t.inventoryName))+
	t.loadOut,
	'NPC PBS TEMPLATE'
 FROM #TEMPLATES as t;


INSERT INTO robottemplaterelation ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
SELECT
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=t.defName),
	(SELECT TOP 1 id FROM robottemplates WHERE name=t.tempName),
	0, 0, NULL, NULL, t.epKill, 'Relate: '+t.defName+ '<->'+t.tempName
FROM #TEMPRELATIONS AS t;

DROP TABLE IF EXISTS #TEMPRELATIONS;
DROP TABLE IF EXISTS #TEMPLATES;
DROP TABLE IF EXISTS #STATS;
DROP TABLE IF EXISTS #ENTITYDEFS;
GO

PRINT N'03_NPC_PresenceFlocks_zone70__2020_08_09.sql';
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

PRINT N'04_EliteModules_upserts__2020_12_26.sql';
USE [perpetuumsa]
GO

--------------------------------------------
-- ELITE MODULES for Stronghold zone 70 boss
-- a lot
-- Date modified: 2021/01/19
--------------------------------------------

DECLARE @highTierCommodity AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_hightier_commodities');

DECLARE @dynamicCtCategory AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_dynamic_cprg');--For ct capsule defined cts

DECLARE @tmShops AS INT = (SELECT TOP 1 id FROM itemshoppresets WHERE name='tm_preset_pve');
DECLARE @t2smallpriceNIC AS INT = 600000;
DECLARE @t4smallpriceNIC AS INT = 800000;
DECLARE @t2medpriceNIC AS INT = 1200000;
DECLARE @t4medpriceNIC AS INT = 1600000;

DECLARE @t2smallpriceTOK AS INT = 30;
DECLARE @t4smallpriceTOK AS INT = 40;
DECLARE @t2medpriceTOK AS INT = 60;
DECLARE @t4medpriceTOK AS INT = 80;


DROP TABLE IF EXISTS #ENTITYDEF;
CREATE TABLE #ENTITYDEF 
(
	def INT,
	defName varchar(100),
	attrFlags bigint,
	catFlags bigint,
	genxyOptStr varchar(max),
	cargoVolume float,
	massOfModule float,
	techType int,
	techLevel int,
);

INSERT INTO #ENTITYDEF (def, defName, attrFlags, catFlags, genxyOptStr, cargoVolume, massOfModule, techType, techLevel) VALUES
(5935,'def_elitet2_70_small_armor_repairer',49168,16908559,'#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t2+',1,168.75,3,2),
(5936,'def_elitet4_70_small_armor_repairer',49168,16908559,'#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t4+',1,250,3,4),

(5937,'def_elitet2_70_medium_armor_repairer',81936,33685775,'#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t2+',1.5,506.25,3,2),
(5938,'def_elitet4_70_medium_armor_repairer',81936,33685775,'#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t4+',1.5,800,3,4),

(5939,'def_elitet2_70_small_shield_generator',49432,16843279,'#moduleFlag=i20#tier=$tierlevel_t2+',0.3,135,3,2),
(5940,'def_elitet4_70_small_shield_generator',49432,16843279,'#moduleFlag=i20#tier=$tierlevel_t4+',0.3,230,3,4),

(5941,'def_elitet2_70_medium_shield_generator',82200,33620495,'#moduleFlag=i20#tier=$tierlevel_t2+',0.5,270,3,2),
(5942,'def_elitet4_70_medium_shield_generator',82200,33620495,'#moduleFlag=i20#tier=$tierlevel_t4+',0.5,470,3,4),

(5943,'def_elitet2_70_sensor_booster',16656,66575,'#moduleFlag=i8 #ammoCapacity=i0 #tier=$tierlevel_t2+',0.5,60,3,2),
(5944,'def_elitet4_70_sensor_booster',16656,66575,'#moduleFlag=i8 #ammoCapacity=i0 #tier=$tierlevel_t4+',0.5,100,3,4),

(5945,'def_elitet2_70_webber',720,16844047,'#moduleFlag=i8 #ammoCapacity=i0 #tier=$tierlevel_t2+',0.5,67.5,3,2),
(5946,'def_elitet4_70_webber',720,16844047,'#moduleFlag=i8 #ammoCapacity=i0 #tier=$tierlevel_t4+',0.5,100,3,4),

(5947,'def_elitet2_70_eccm',524288,263439,'#moduleFlag=i8 #ammoCapacity=i0 #tier=$tierlevel_t2+',0.5,67.5,3,2),
(5948,'def_elitet4_70_eccm',524288,263439,'#moduleFlag=i8 #ammoCapacity=i0 #tier=$tierlevel_t4+',0.5,100,3,4),

(5949,'def_elitet2_70_small_core_booster',311316,17367823,'#moduleFlag=i20 #ammoCapacity=if #ammoType=L70a #tier=$tierlevel_t2+',0.5,67.5,3,2),
(5950,'def_elitet4_70_small_core_booster',311316,17367823,'#moduleFlag=i20 #ammoCapacity=ic #ammoType=L70a #tier=$tierlevel_t4+',0.5,100,3,4),

(5951,'def_elitet2_70_medium_core_booster',344084,34145039,'#moduleFlag=i20 #ammoCapacity=if #ammoType=L70a #tier=$tierlevel_t2+',1,135,3,2),
(5952,'def_elitet4_70_medium_core_booster',344084,34145039,'#moduleFlag=i20 #ammoCapacity=ic #ammoType=L70a #tier=$tierlevel_t4+',1,200,3,4),

(5953,'def_elitet2_70_tracking_upgrade',524288,459791,'#moduleFlag=i8 #ammoCapacity=i0 #tier=$tierlevel_t2+',0.1,33.75,3,2),
(5954,'def_elitet4_70_tracking_upgrade',524288,459791,'#moduleFlag=i8 #ammoCapacity=i0 #tier=$tierlevel_t4+',0.1,50,3,4);

DROP TABLE IF EXISTS #CTS;
CREATE TABLE #CTS 
(
	def INT,
	defName varchar(100),
	attrFlags bigint,
	catFlags bigint,
	genxyOptStr varchar(max),
	cargoVolume float,
	massOfModule float,
	techType int,
	techLevel int,
);
INSERT INTO #CTS (def, defName, attrFlags, catFlags, genxyOptStr, cargoVolume, massOfModule, techType, techLevel) VALUES
(5955,'def_elitet2_70_small_armor_repairer_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t2+',0.01,0.1,3,2),
(5956,'def_elitet4_70_small_armor_repairer_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),

(5957,'def_elitet2_70_medium_armor_repairer_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t2+',0.01,0.1,3,2),
(5958,'def_elitet4_70_medium_armor_repairer_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),

(5959,'def_elitet2_70_small_shield_generator_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t2+',0.01,0.1,3,2),
(5960,'def_elitet4_70_small_shield_generator_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),

(5961,'def_elitet2_70_medium_shield_generator_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t2+',0.01,0.1,3,2),
(5962,'def_elitet4_70_medium_shield_generator_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),

(5963,'def_elitet2_70_sensor_booster_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t2+',0.01,0.1,3,2),
(5964,'def_elitet4_70_sensor_booster_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),

(5965,'def_elitet2_70_webber_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t2+',0.01,0.1,3,2),
(5966,'def_elitet4_70_webber_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),

(5967,'def_elitet2_70_eccm_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t2+',0.01,0.1,3,2),
(5968,'def_elitet4_70_eccm_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),

(5969,'def_elitet2_70_small_core_booster_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t2+',0.01,0.1,3,2),
(5970,'def_elitet4_70_small_core_booster_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),

(5971,'def_elitet2_70_medium_core_booster_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t2+',0.01,0.1,3,2),
(5972,'def_elitet4_70_medium_core_booster_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),

(5973,'def_elitet2_70_tracking_upgrade_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t2+',0.01,0.1,3,2),
(5974,'def_elitet4_70_tracking_upgrade_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4);

DROP TABLE IF EXISTS #CTS_CAPSULES;
CREATE TABLE #CTS_CAPSULES 
(
	def INT,
	defName varchar(100),
	attrFlags bigint,
	catFlags bigint,
	genxyOptStr varchar(max),
	cargoVolume float,
	massOfModule float,
	techType int,
	techLevel int,
);
INSERT INTO #CTS_CAPSULES (def, defName, attrFlags, catFlags, genxyOptStr, cargoVolume, massOfModule, techType, techLevel) VALUES
(5975,'def_elitet2_70_small_armor_repairer_CT_capsule',2052,1179,'#tier=$tierlevel_t2+',0.1,0.1,3,2),
(5976,'def_elitet4_70_small_armor_repairer_CT_capsule',2052,1179,'#tier=$tierlevel_t4+',0.1,0.1,3,4),

(5977,'def_elitet2_70_medium_armor_repairer_CT_capsule',2052,1179,'#tier=$tierlevel_t2+',0.1,0.1,3,2),
(5978,'def_elitet4_70_medium_armor_repairer_CT_capsule',2052,1179,'#tier=$tierlevel_t4+',0.1,0.1,3,4),

(5979,'def_elitet2_70_small_shield_generator_CT_capsule',2052,1179,'#tier=$tierlevel_t2+',0.1,0.1,3,2),
(5980,'def_elitet4_70_small_shield_generator_CT_capsule',2052,1179,'#tier=$tierlevel_t4+',0.1,0.1,3,4),

(5981,'def_elitet2_70_medium_shield_generator_CT_capsule',2052,1179,'#tier=$tierlevel_t2+',0.1,0.1,3,2),
(5982,'def_elitet4_70_medium_shield_generator_CT_capsule',2052,1179,'#tier=$tierlevel_t4+',0.1,0.1,3,4),

(5983,'def_elitet2_70_sensor_booster_CT_capsule',2052,1179,'#tier=$tierlevel_t2+',0.1,0.1,3,2),
(5984,'def_elitet4_70_sensor_booster_CT_capsule',2052,1179,'#tier=$tierlevel_t4+',0.1,0.1,3,4),

(5985,'def_elitet2_70_webber_CT_capsule',2052,1179,'#tier=$tierlevel_t2+',0.1,0.1,3,2),
(5986,'def_elitet4_70_webber_CT_capsule',2052,1179,'#tier=$tierlevel_t4+',0.1,0.1,3,4),

(5987,'def_elitet2_70_eccm_CT_capsule',2052,1179,'#tier=$tierlevel_t2+',0.1,0.1,3,2),
(5988,'def_elitet4_70_eccm_CT_capsule',2052,1179,'#tier=$tierlevel_t4+',0.1,0.1,3,4),

(5989,'def_elitet2_70_small_core_booster_CT_capsule',2052,1179,'#tier=$tierlevel_t2+',0.1,0.1,3,2),
(5990,'def_elitet4_70_small_core_booster_CT_capsule',2052,1179,'#tier=$tierlevel_t4+',0.1,0.1,3,4),

(5991,'def_elitet2_70_medium_core_booster_CT_capsule',2052,1179,'#tier=$tierlevel_t2+',0.1,0.1,3,2),
(5992,'def_elitet4_70_medium_core_booster_CT_capsule',2052,1179,'#tier=$tierlevel_t4+',0.1,0.1,3,4),

(5993,'def_elitet2_70_tracking_upgrade_CT_capsule',2052,1179,'#tier=$tierlevel_t2+',0.1,0.1,3,2),
(5994,'def_elitet4_70_tracking_upgrade_CT_capsule',2052,1179,'#tier=$tierlevel_t4+',0.1,0.1,3,4);

DROP TABLE IF EXISTS #MATERIALDEF;
CREATE TABLE #MATERIALDEF 
(
	def INT,
	defName varchar(100),
	attrFlags bigint,
	catFlags bigint,
	genxyOptStr varchar(max),
	cargoVolume float,
	massOfModule float,
	techType int,
	techLevel int,
);
INSERT INTO #MATERIALDEF (def, defName, attrFlags, catFlags, genxyOptStr, cargoVolume, massOfModule, techType, techLevel) VALUES
(5995,'def_material_boss_z70',2048,@highTierCommodity,NULL,0.01,0.5,NULL,NULL);


DROP TABLE IF EXISTS #SHOPENTRIES;
CREATE TABLE #SHOPENTRIES
(
	defName varchar(100),
	tokenPrice int,
	nicPrice int
);
INSERT INTO #SHOPENTRIES (defName, tokenPrice, nicPrice) VALUES
('def_elitet2_70_small_armor_repairer_CT_capsule',@t2smallpriceTOK,@t2smallpriceNIC),
('def_elitet4_70_small_armor_repairer_CT_capsule',@t4smallpriceTOK,@t4smallpriceNIC),
('def_elitet2_70_medium_armor_repairer_CT_capsule',@t2medpriceTOK,@t2medpriceNIC),
('def_elitet4_70_medium_armor_repairer_CT_capsule',@t4medpriceTOK,@t4medpriceNIC),
('def_elitet2_70_small_shield_generator_CT_capsule',@t2smallpriceTOK,@t2smallpriceNIC),
('def_elitet4_70_small_shield_generator_CT_capsule',@t4smallpriceTOK,@t4smallpriceNIC),
('def_elitet2_70_medium_shield_generator_CT_capsule',@t2medpriceTOK,@t2medpriceNIC),
('def_elitet4_70_medium_shield_generator_CT_capsule',@t4medpriceTOK,@t4medpriceNIC),
('def_elitet2_70_sensor_booster_CT_capsule',@t2medpriceTOK,@t2medpriceNIC),
('def_elitet4_70_sensor_booster_CT_capsule',@t4medpriceTOK,@t4medpriceNIC),
('def_elitet2_70_webber_CT_capsule',@t2medpriceTOK,@t2medpriceNIC),
('def_elitet4_70_webber_CT_capsule',@t4medpriceTOK,@t4medpriceNIC),
('def_elitet2_70_eccm_CT_capsule',@t2medpriceTOK,@t2medpriceNIC),
('def_elitet4_70_eccm_CT_capsule',@t4medpriceTOK,@t4medpriceNIC),
('def_elitet2_70_small_core_booster_CT_capsule',@t2smallpriceTOK,@t2smallpriceNIC),
('def_elitet4_70_small_core_booster_CT_capsule',@t4medpriceTOK,@t4smallpriceNIC),
('def_elitet2_70_medium_core_booster_CT_capsule',@t2medpriceTOK,@t2medpriceNIC),
('def_elitet4_70_medium_core_booster_CT_capsule',@t4medpriceTOK,@t4medpriceNIC),
('def_elitet2_70_tracking_upgrade_CT_capsule',@t2medpriceTOK,@t2medpriceNIC),
('def_elitet4_70_tracking_upgrade_CT_capsule',@t4medpriceTOK,@t4medpriceNIC);


DROP TABLE IF EXISTS #CT_RELATE;
CREATE TABLE #CT_RELATE 
(
	defName varchar(100),
	ctName varchar(100),
	capName varchar(100)
);
INSERT INTO #CT_RELATE (defName, ctName, capName) VALUES
('def_elitet2_70_small_armor_repairer', 'def_elitet2_70_small_armor_repairer_cprg', 'def_elitet2_70_small_armor_repairer_CT_capsule'),
('def_elitet4_70_small_armor_repairer', 'def_elitet4_70_small_armor_repairer_cprg', 'def_elitet4_70_small_armor_repairer_CT_capsule'),

('def_elitet2_70_medium_armor_repairer', 'def_elitet2_70_medium_armor_repairer_cprg', 'def_elitet2_70_medium_armor_repairer_CT_capsule'),
('def_elitet4_70_medium_armor_repairer', 'def_elitet4_70_medium_armor_repairer_cprg', 'def_elitet4_70_medium_armor_repairer_CT_capsule'),

('def_elitet2_70_small_shield_generator', 'def_elitet2_70_small_shield_generator_cprg', 'def_elitet2_70_small_shield_generator_CT_capsule'),
('def_elitet4_70_small_shield_generator', 'def_elitet4_70_small_shield_generator_cprg', 'def_elitet4_70_small_shield_generator_CT_capsule'),

('def_elitet2_70_medium_shield_generator', 'def_elitet2_70_medium_shield_generator_cprg', 'def_elitet2_70_medium_shield_generator_CT_capsule'),
('def_elitet4_70_medium_shield_generator', 'def_elitet4_70_medium_shield_generator_cprg', 'def_elitet4_70_medium_shield_generator_CT_capsule'),

('def_elitet2_70_sensor_booster', 'def_elitet2_70_sensor_booster_cprg', 'def_elitet2_70_sensor_booster_CT_capsule'),
('def_elitet4_70_sensor_booster', 'def_elitet4_70_sensor_booster_cprg', 'def_elitet4_70_sensor_booster_CT_capsule'),

('def_elitet2_70_webber', 'def_elitet2_70_webber_cprg', 'def_elitet2_70_webber_CT_capsule'),
('def_elitet4_70_webber', 'def_elitet4_70_webber_cprg', 'def_elitet4_70_webber_CT_capsule'),

('def_elitet2_70_eccm', 'def_elitet2_70_eccm_cprg', 'def_elitet2_70_eccm_CT_capsule'),
('def_elitet4_70_eccm', 'def_elitet4_70_eccm_cprg', 'def_elitet4_70_eccm_CT_capsule'),

('def_elitet2_70_small_core_booster', 'def_elitet2_70_small_core_booster_cprg', 'def_elitet2_70_small_core_booster_CT_capsule'),
('def_elitet4_70_small_core_booster', 'def_elitet4_70_small_core_booster_cprg', 'def_elitet4_70_small_core_booster_CT_capsule'),

('def_elitet2_70_medium_core_booster', 'def_elitet2_70_medium_core_booster_cprg', 'def_elitet2_70_medium_core_booster_CT_capsule'),
('def_elitet4_70_medium_core_booster', 'def_elitet4_70_medium_core_booster_cprg', 'def_elitet4_70_medium_core_booster_CT_capsule'),

('def_elitet2_70_tracking_upgrade', 'def_elitet2_70_tracking_upgrade_cprg', 'def_elitet2_70_tracking_upgrade_CT_capsule'),
('def_elitet4_70_tracking_upgrade', 'def_elitet4_70_tracking_upgrade_cprg', 'def_elitet4_70_tracking_upgrade_CT_capsule');

DROP TABLE IF EXISTS #STATS;
CREATE TABLE #STATS(
	defName varchar(100),
	fieldName varchar(100),
	fieldValue float,
);
INSERT INTO #STATS (defName, fieldName, fieldValue) VALUES

('def_elitet2_70_small_armor_repairer','core_recharge_time_modifier',0.97),--3% accum recharge
('def_elitet2_70_small_armor_repairer','armor_repair_amount',65),
('def_elitet2_70_small_armor_repairer','core_usage',54),
('def_elitet2_70_small_armor_repairer','cpu_usage',29),
('def_elitet2_70_small_armor_repairer','cycle_time',13500),
('def_elitet2_70_small_armor_repairer','powergrid_usage',17),

('def_elitet4_70_small_armor_repairer','core_recharge_time_modifier',0.95),--5% accum recharge
('def_elitet4_70_small_armor_repairer','armor_repair_amount',75),
('def_elitet4_70_small_armor_repairer','core_usage',70),
('def_elitet4_70_small_armor_repairer','cpu_usage',40),
('def_elitet4_70_small_armor_repairer','cycle_time',12000),
('def_elitet4_70_small_armor_repairer','powergrid_usage',27),

('def_elitet2_70_medium_armor_repairer','core_recharge_time_modifier',0.975),--2.5% accum recharge
('def_elitet2_70_medium_armor_repairer','armor_repair_amount',200),
('def_elitet2_70_medium_armor_repairer','core_usage',278),
('def_elitet2_70_medium_armor_repairer','cpu_usage',43),
('def_elitet2_70_medium_armor_repairer','cycle_time',13500),
('def_elitet2_70_medium_armor_repairer','powergrid_usage',87),

('def_elitet4_70_medium_armor_repairer','core_recharge_time_modifier',0.96),--4% accum recharge
('def_elitet4_70_medium_armor_repairer','armor_repair_amount',230),
('def_elitet4_70_medium_armor_repairer','core_usage',330),
('def_elitet4_70_medium_armor_repairer','cpu_usage',55),
('def_elitet4_70_medium_armor_repairer','cycle_time',12000),
('def_elitet4_70_medium_armor_repairer','powergrid_usage',110),

('def_elitet2_70_small_shield_generator','core_recharge_time_modifier',0.97),--3% accum recharge
('def_elitet2_70_small_shield_generator','core_usage',1),
('def_elitet2_70_small_shield_generator','cpu_usage',38),
('def_elitet2_70_small_shield_generator','cycle_time',2250),
('def_elitet2_70_small_shield_generator','powergrid_usage',43),
('def_elitet2_70_small_shield_generator','shield_absorbtion',2.1277),--47% ap ratio
('def_elitet2_70_small_shield_generator','shield_radius',5),

('def_elitet4_70_small_shield_generator','core_recharge_time_modifier',0.95),--5% accum recharge
('def_elitet4_70_small_shield_generator','core_usage',1),
('def_elitet4_70_small_shield_generator','cpu_usage',50),
('def_elitet4_70_small_shield_generator','cycle_time',2000),
('def_elitet4_70_small_shield_generator','powergrid_usage',57),
('def_elitet4_70_small_shield_generator','shield_absorbtion',2),
('def_elitet4_70_small_shield_generator','shield_radius',6),

('def_elitet2_70_medium_shield_generator','core_recharge_time_modifier',0.975),--2.5% accum recharge
('def_elitet2_70_medium_shield_generator','core_usage',12.5),
('def_elitet2_70_medium_shield_generator','cpu_usage',57),
('def_elitet2_70_medium_shield_generator','cycle_time',7000),
('def_elitet2_70_medium_shield_generator','powergrid_usage',214),
('def_elitet2_70_medium_shield_generator','shield_absorbtion',2.1277),
('def_elitet2_70_medium_shield_generator','shield_radius',12),

('def_elitet4_70_medium_shield_generator','core_recharge_time_modifier',0.96),--4% accum recharge
('def_elitet4_70_medium_shield_generator','core_usage',12.5),
('def_elitet4_70_medium_shield_generator','cpu_usage',70),
('def_elitet4_70_medium_shield_generator','cycle_time',6500),
('def_elitet4_70_medium_shield_generator','powergrid_usage',285),
('def_elitet4_70_medium_shield_generator','shield_absorbtion',2),
('def_elitet4_70_medium_shield_generator','shield_radius',25),

('def_elitet2_70_sensor_booster','sensor_strength_modifier',17.5), --17.5 sensor_strength
('def_elitet2_70_sensor_booster','core_usage',8),
('def_elitet2_70_sensor_booster','cpu_usage',12),
('def_elitet2_70_sensor_booster','cycle_time',10000),
('def_elitet2_70_sensor_booster','effect_sensor_booster_locking_range_modifier',1.4),
('def_elitet2_70_sensor_booster','effect_sensor_booster_locking_time_modifier',0.75),
('def_elitet2_70_sensor_booster','powergrid_usage',5),

('def_elitet4_70_sensor_booster','sensor_strength_modifier',25), --25 sensor_strength
('def_elitet4_70_sensor_booster','core_usage',12),
('def_elitet4_70_sensor_booster','cpu_usage',19),
('def_elitet4_70_sensor_booster','cycle_time',10000),
('def_elitet4_70_sensor_booster','effect_sensor_booster_locking_range_modifier',1.45),
('def_elitet4_70_sensor_booster','effect_sensor_booster_locking_time_modifier',0.7),
('def_elitet4_70_sensor_booster','powergrid_usage',9),

('def_elitet2_70_webber','locking_time_modifier',0.895),--10.5% lock time
('def_elitet2_70_webber','core_usage',13),
('def_elitet2_70_webber','cpu_usage',39),
('def_elitet2_70_webber','cycle_time',5000),
('def_elitet2_70_webber','falloff',0),
('def_elitet2_70_webber','optimal_range',12),
('def_elitet2_70_webber','powergrid_usage',13),
('def_elitet2_70_webber','effect_massivness_speed_max_modifier',0.625),

('def_elitet4_70_webber','locking_time_modifier',0.85),--15% lock time
('def_elitet4_70_webber','core_usage',20),
('def_elitet4_70_webber','cpu_usage',50),
('def_elitet4_70_webber','cycle_time',5000),
('def_elitet4_70_webber','falloff',0),
('def_elitet4_70_webber','optimal_range',15),
('def_elitet4_70_webber','powergrid_usage',16),
('def_elitet4_70_webber','effect_massivness_speed_max_modifier',0.55),

('def_elitet2_70_eccm','damage_laser_modifier',0.05),--5% damage (all types)
('def_elitet2_70_eccm','damage_missile_modifier',0.05),
('def_elitet2_70_eccm','damage_projectile_modifier',0.05),
('def_elitet2_70_eccm','damage_railgun_modifier',0.05),
('def_elitet2_70_eccm','cpu_usage',20),
('def_elitet2_70_eccm','powergrid_usage',13),
('def_elitet2_70_eccm','sensor_strength_modifier',60),

('def_elitet4_70_eccm','damage_laser_modifier',0.07),--7% damage (all types)
('def_elitet4_70_eccm','damage_missile_modifier',0.07),
('def_elitet4_70_eccm','damage_projectile_modifier',0.07),
('def_elitet4_70_eccm','damage_railgun_modifier',0.07),
('def_elitet4_70_eccm','cpu_usage',27),
('def_elitet4_70_eccm','powergrid_usage',17),
('def_elitet4_70_eccm','sensor_strength_modifier',75),

('def_elitet2_70_small_core_booster','reactor_radiation_modifier',0.945),--5.5% reactor stab
('def_elitet2_70_small_core_booster','core_usage',0),
('def_elitet2_70_small_core_booster','cpu_usage',17),
('def_elitet2_70_small_core_booster','cycle_time',19000),
('def_elitet2_70_small_core_booster','powergrid_usage',43),

('def_elitet4_70_small_core_booster','reactor_radiation_modifier',0.9),--10% reactor stab
('def_elitet4_70_small_core_booster','core_usage',0),
('def_elitet4_70_small_core_booster','cpu_usage',22),
('def_elitet4_70_small_core_booster','cycle_time',17000),
('def_elitet4_70_small_core_booster','powergrid_usage',60),

('def_elitet2_70_medium_core_booster','reactor_radiation_modifier',0.95),--5% reactor stab
('def_elitet2_70_medium_core_booster','core_usage',0),
('def_elitet2_70_medium_core_booster','cpu_usage',22),
('def_elitet2_70_medium_core_booster','cycle_time',10500),
('def_elitet2_70_medium_core_booster','powergrid_usage',214),

('def_elitet4_70_medium_core_booster','reactor_radiation_modifier',0.91),--9% reactor stab
('def_elitet4_70_medium_core_booster','core_usage',0),
('def_elitet4_70_medium_core_booster','cpu_usage',27),
('def_elitet4_70_medium_core_booster','cycle_time',9000),
('def_elitet4_70_medium_core_booster','powergrid_usage',300),

('def_elitet2_70_tracking_upgrade','damage_laser_modifier',0.05),--5% damage (all types)
('def_elitet2_70_tracking_upgrade','damage_missile_modifier',0.05),
('def_elitet2_70_tracking_upgrade','damage_projectile_modifier',0.05),
('def_elitet2_70_tracking_upgrade','damage_railgun_modifier',0.05),
('def_elitet2_70_tracking_upgrade','cpu_usage',31),
('def_elitet2_70_tracking_upgrade','optimal_range_modifier',1.12),
('def_elitet2_70_tracking_upgrade','powergrid_usage',86),

('def_elitet4_70_tracking_upgrade','damage_laser_modifier',0.07),--7% damage (all types)
('def_elitet4_70_tracking_upgrade','damage_missile_modifier',0.07),
('def_elitet4_70_tracking_upgrade','damage_projectile_modifier',0.07),
('def_elitet4_70_tracking_upgrade','damage_railgun_modifier',0.07),
('def_elitet4_70_tracking_upgrade','cpu_usage',40),
('def_elitet4_70_tracking_upgrade','optimal_range_modifier',1.15),
('def_elitet4_70_tracking_upgrade','powergrid_usage',125);


DROP TABLE IF EXISTS #SKILLS;
CREATE TABLE #SKILLS (
	defName varchar(100),
	extName varchar(100),
	extLevel float,
);
INSERT INTO #SKILLS (defName, extName, extLevel) VALUES
('def_elitet2_70_small_armor_repairer','ext_repair_systems',6),
('def_elitet4_70_small_armor_repairer','ext_repair_systems',7),
('def_elitet2_70_medium_armor_repairer','ext_repair_systems',6),
('def_elitet4_70_medium_armor_repairer','ext_repair_systems',7),
('def_elitet2_70_small_shield_generator','ext_shield_operation',6),
('def_elitet4_70_small_shield_generator','ext_shield_operation',7),
('def_elitet2_70_medium_shield_generator','ext_shield_upgrades',6),
('def_elitet4_70_medium_shield_generator','ext_shield_upgrades',7),
('def_elitet2_70_sensor_booster','ext_electronics',6),
('def_elitet4_70_sensor_booster','ext_electronics',7),
('def_elitet2_70_webber','ext_propulsion_disabling',6),
('def_elitet4_70_webber','ext_propulsion_disabling',7),
('def_elitet2_70_eccm','ext_electronic_warfare',6),
('def_elitet4_70_eccm','ext_electronic_warfare',7),
('def_elitet2_70_small_core_booster','ext_core_management',6),
('def_elitet4_70_small_core_booster','ext_core_management',7),
('def_elitet2_70_medium_core_booster','ext_core_management',6),
('def_elitet4_70_medium_core_booster','ext_core_management',7),
('def_elitet2_70_tracking_upgrade','ext_long_range_targeting',6),
('def_elitet4_70_tracking_upgrade','ext_long_range_targeting',7);

DROP TABLE IF EXISTS #INDY;
CREATE TABLE #INDY
(
	defName VARCHAR(100),
	commodityName VARCHAR(100),
	amount INT
);
INSERT INTO #INDY (defName, commodityName, amount) VALUES
('def_elitet2_70_small_armor_repairer','def_named1_small_armor_repairer',1),
('def_elitet2_70_small_armor_repairer','def_material_boss_z70',150),

('def_elitet4_70_small_armor_repairer','def_named3_small_armor_repairer',1),
('def_elitet4_70_small_armor_repairer','def_material_boss_z70',200),

('def_elitet2_70_medium_armor_repairer','def_named1_medium_armor_repairer',1),
('def_elitet2_70_medium_armor_repairer','def_material_boss_z70',300),

('def_elitet4_70_medium_armor_repairer','def_named3_medium_armor_repairer',1),
('def_elitet4_70_medium_armor_repairer','def_material_boss_z70',400),

('def_elitet2_70_small_shield_generator','def_named1_small_shield_generator',1),
('def_elitet2_70_small_shield_generator','def_material_boss_z70',150),

('def_elitet4_70_small_shield_generator','def_named3_small_shield_generator',1),
('def_elitet4_70_small_shield_generator','def_material_boss_z70',200),

('def_elitet2_70_medium_shield_generator','def_named1_medium_shield_generator',1),
('def_elitet2_70_medium_shield_generator','def_material_boss_z70',300),

('def_elitet4_70_medium_shield_generator','def_named3_medium_shield_generator',1),
('def_elitet4_70_medium_shield_generator','def_material_boss_z70',400),

('def_elitet2_70_sensor_booster','def_named1_sensor_booster',1),
('def_elitet2_70_sensor_booster','def_material_boss_z70',300),

('def_elitet4_70_sensor_booster','def_named3_sensor_booster',1),
('def_elitet4_70_sensor_booster','def_material_boss_z70',400),

('def_elitet2_70_webber','def_named1_webber',1),
('def_elitet2_70_webber','def_material_boss_z70',300),

('def_elitet4_70_webber','def_named3_webber',1),
('def_elitet4_70_webber','def_material_boss_z70',400),

('def_elitet2_70_eccm','def_named1_eccm',1),
('def_elitet2_70_eccm','def_material_boss_z70',300),

('def_elitet4_70_eccm','def_named3_eccm',1),
('def_elitet4_70_eccm','def_material_boss_z70',400),

('def_elitet2_70_small_core_booster','def_named1_small_core_booster',1),
('def_elitet2_70_small_core_booster','def_material_boss_z70',150),

('def_elitet4_70_small_core_booster','def_named3_small_core_booster',1),
('def_elitet4_70_small_core_booster','def_material_boss_z70',200),

('def_elitet2_70_medium_core_booster','def_named1_medium_core_booster',1),
('def_elitet2_70_medium_core_booster','def_material_boss_z70',300),

('def_elitet4_70_medium_core_booster','def_named3_medium_core_booster',1),
('def_elitet4_70_medium_core_booster','def_material_boss_z70',400),

('def_elitet2_70_tracking_upgrade','def_named1_tracking_upgrade',1),
('def_elitet2_70_tracking_upgrade','def_material_boss_z70',300),

('def_elitet4_70_tracking_upgrade','def_named3_tracking_upgrade',1),
('def_elitet4_70_tracking_upgrade','def_material_boss_z70',400);


PRINT N'UPSERT [entitydefaults] identity insert ON';
SET IDENTITY_INSERT [dbo].[entitydefaults] ON;
MERGE [dbo].[entitydefaults] e USING #ENTITYDEF d
ON e.definition = d.def
WHEN MATCHED
    THEN UPDATE SET
		categoryflags=catFlags,
		attributeflags=attrFlags,
		volume=cargoVolume,
		mass=massOfModule,
		tiertype=techType,
		tierlevel=techLevel,
		options=genxyOptStr,
		enabled=1,
		hidden=0,
		purchasable=1,
		descriptiontoken=defName+'_desc'
WHEN NOT MATCHED
    THEN INSERT (definition, definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel) VALUES
	(def,defName,1,attrFlags,catFlags,genxyOptStr,'elite module',1,cargoVolume,massOfModule,0,100,defName+'_desc',1,techType,techLevel);

PRINT N'UPSERT  cts into [entitydefaults]';
MERGE [dbo].[entitydefaults] e USING #CTS d
ON e.definition = d.def
WHEN MATCHED
    THEN UPDATE SET
		categoryflags=catFlags,
		attributeflags=attrFlags,
		volume=cargoVolume,
		mass=massOfModule,
		tiertype=techType,
		tierlevel=techLevel,
		options=genxyOptStr,
		enabled=1,
		hidden=0,
		purchasable=1,
		descriptiontoken='calibration_program_desc'
WHEN NOT MATCHED
    THEN INSERT (definition, definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel) VALUES
	(def,defName,1,attrFlags,catFlags,genxyOptStr,'elite module',1,cargoVolume,massOfModule,0,100,'calibration_program_desc',1,techType,techLevel);

PRINT N'UPSERT  ct capsules into [entitydefaults]';
MERGE [dbo].[entitydefaults] e USING #CTS_CAPSULES d
ON e.definition = d.def
WHEN MATCHED
    THEN UPDATE SET
		categoryflags=catFlags,
		attributeflags=attrFlags,
		volume=cargoVolume,
		mass=massOfModule,
		tiertype=techType,
		tierlevel=techLevel,
		options=genxyOptStr,
		enabled=1,
		hidden=0,
		purchasable=1,
		descriptiontoken='elite_ct_capsule_desc'
WHEN NOT MATCHED
    THEN INSERT (definition, definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel) VALUES
	(def,defName,1,attrFlags,catFlags,genxyOptStr,'elite module',1,cargoVolume,massOfModule,0,100,'elite_ct_capsule_desc',1,techType,techLevel);

PRINT N'UPSERT  new boss material into [entitydefaults]';
MERGE [dbo].[entitydefaults] e USING #MATERIALDEF d
ON e.definition = d.def
WHEN MATCHED
    THEN UPDATE SET
		categoryflags=catFlags,
		attributeflags=attrFlags,
		volume=cargoVolume,
		mass=massOfModule,
		tiertype=techType,
		tierlevel=techLevel,
		options=genxyOptStr,
		enabled=1,
		hidden=0,
		purchasable=1,
		descriptiontoken=defName+'_desc'
WHEN NOT MATCHED
    THEN INSERT (definition, definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel) VALUES
	(def,defName,1,attrFlags,catFlags,genxyOptStr,'elite module',1,cargoVolume,massOfModule,0,100,defName+'_desc',1,techType,techLevel);

SET IDENTITY_INSERT [dbo].[entitydefaults] OFF;
PRINT N'[entitydefaults] insert/updates done - identity insert off';

PRINT N'DELETE [aggregatevalues] (0 if first run)';
DELETE FROM aggregatevalues WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #STATS));
PRINT N'UPSERT [aggregatevalues]';
MERGE [dbo].[aggregatevalues] v USING #STATS s
ON v.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=s.defName) AND
v.field = (SELECT TOP 1 id FROM aggregatefields WHERE name=s.fieldName)
WHEN MATCHED
    THEN UPDATE SET
		v.value=s.fieldValue
WHEN NOT MATCHED
    THEN INSERT (definition, field, value) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=s.defName),
	(SELECT TOP 1 id FROM aggregatefields WHERE name=s.fieldName),
	s.fieldValue);

PRINT N'UPSERT [enablerextensions]';
MERGE [dbo].[enablerextensions] e USING #SKILLS s
ON e.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=s.defName) AND
e.extensionid = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname=s.extName)
WHEN MATCHED
    THEN UPDATE SET
		e.extensionlevel=s.extLevel
WHEN NOT MATCHED
    THEN INSERT (definition, extensionid, extensionlevel) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=s.defName),
	(SELECT TOP 1 extensionid FROM extensions WHERE extensionname=s.extName),
	s.extLevel);

PRINT N'UPSERT [dynamiccalibrationtemplates]';
MERGE [dbo].[dynamiccalibrationtemplates] t USING #CT_RELATE c
ON t.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=c.ctName)
WHEN MATCHED
    THEN UPDATE SET
		materialefficiency=1,
		timeefficiency=1,
		targetdefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=c.defName)
WHEN NOT MATCHED
    THEN INSERT (definition, materialefficiency, timeefficiency, targetdefinition) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=c.ctName),
	1,1,
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=c.defName));

PRINT N'UPSERT [calibrationtemplateitems]';
MERGE [dbo].[calibrationtemplateitems] t USING #CT_RELATE c
ON t.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=c.capName)
WHEN MATCHED
    THEN UPDATE SET
		targetdefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=c.ctName)
WHEN NOT MATCHED
    THEN INSERT (definition, targetdefinition) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=c.capName),
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=c.ctName));

PRINT N'UPSERT [components]';
MERGE [dbo].[components] c USING #INDY i
ON c.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=i.defName) AND
c.componentdefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=i.commodityName) 
WHEN MATCHED
    THEN UPDATE SET
		componentamount = i.amount
WHEN NOT MATCHED
    THEN INSERT (definition, componentdefinition, componentamount) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=i.defName),
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=i.commodityName),
	i.amount);

PRINT N'UPSERT [itemshop]';
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


DROP TABLE IF EXISTS #STATS;
DROP TABLE IF EXISTS #ENTITYDEF;
DROP TABLE IF EXISTS #MATERIALDEF;
DROP TABLE IF EXISTS #CT_RELATE;
DROP TABLE IF EXISTS #CTS;
DROP TABLE IF EXISTS #CTS_CAPSULES;
DROP TABLE IF EXISTS #INDY;
DROP TABLE IF EXISTS #SKILLS;
DROP TABLE IF EXISTS #SHOPENTRIES; 
GO

PRINT N'05_npcloots_zone70__2020_09_10.sql';
USE [perpetuumsa]
GO

--------------------------------------------------------------------------
-- Stronghold zone 70 npc loot!
-- Date: 2020/12/30
--------------------------------------------------------------------------


PRINT N'SET ALL NPC LOOT FOR NPC STRONGHOLD';
DROP TABLE IF EXISTS #LOOT;
CREATE TABLE #LOOT(
	npcName VARCHAR(100),
	lootName VARCHAR(100),
	minQuantity FLOAT,
	maxQuantity FLOAT,
	probability FLOAT DEFAULT(1.0)
);

INSERT INTO #LOOT (npcName, lootName, minQuantity, maxQuantity, probability) VALUES
('def_npc_pbs_base_medium_rank1','def_titanium',1000,2000, 1.0),
('def_npc_pbs_base_medium_rank1','def_plasteosine',375,750, 1.0),
('def_npc_pbs_base_medium_rank1','def_alligior',750,1500, 1.0),
('def_npc_pbs_base_medium_rank1','def_hydrobenol',200,400, 1.0),
('def_npc_pbs_base_medium_rank1','def_espitium',500,1000, 1.0),
('def_npc_pbs_base_medium_rank1','def_unimetal',2000,4000, 1.0),
('def_npc_pbs_base_medium_rank1','def_axicol',250,500, 1.0),
('def_npc_pbs_base_medium_rank1','def_axicoline',100,200, 1.0),
('def_npc_pbs_base_medium_rank1','def_gamma_buildblock',1000,2000, 1.0),
('def_npc_pbs_base_medium_rank1','def_gamma_defblock',375,750, 1.0),
('def_npc_pbs_base_medium_rank1','def_gamma_energyblock',250,500, 1.0),
('def_npc_pbs_base_medium_rank1','def_gamma_offenseblock',100,200, 1.0),
('def_npc_pbs_base_medium_rank1','def_common_reactor_plasma',5000,12000, 1.0),
('def_npc_pbs_base_medium_rank1','def_kernel_pelistal',5000,10000, 1.0),
('def_npc_pbs_base_medium_rank1','def_kernel_thelodica',5000,10000, 1.0),
('def_npc_pbs_base_medium_rank1','def_kernel_nuimqol',5000,10000, 1.0),
('def_npc_pbs_base_medium_rank1','def_kernel_common',20000,40000, 1.0),
('def_npc_pbs_base_medium_rank1','def_kernel_hitech',10000,20000, 1.0),
('def_npc_pbs_base_medium_rank1','def_robotshard_common_basic',500,1000, 1.0),
('def_npc_pbs_base_medium_rank1','def_robotshard_common_advanced',400,1000, 1.0),
('def_npc_pbs_base_medium_rank1','def_robotshard_common_expert',300,1000, 1.0),
('def_npc_pbs_base_medium_rank1','def_intakt_bot',1,1, 0.75),
('def_npc_pbs_base_medium_rank1','def_cameleon_bot',1,1, 0.75),
('def_npc_pbs_base_medium_rank1','def_troiar_bot',1,1, 0.75),
('def_npc_pbs_base_medium_rank1','def_kain_bot',1,1, 0.85),
('def_npc_pbs_base_medium_rank1','def_artemis_bot',1,1, 0.85),
('def_npc_pbs_base_medium_rank1','def_tyrannos_bot',1,1, 0.85),
('def_npc_pbs_base_medium_rank1','def_termis_bot',1,1, 0.95),
('def_npc_pbs_base_medium_rank1','def_gargoyle_bot',1,1, 0.95),

('def_npc_pbs_reactor_rank1','def_titanium',250,500, 1.0),
('def_npc_pbs_reactor_rank1','def_plasteosine',175,350, 1.0),
('def_npc_pbs_reactor_rank1','def_alligior',350,700, 1.0),
('def_npc_pbs_reactor_rank1','def_espitium',1500,3000, 1.0),
('def_npc_pbs_reactor_rank1','def_unimetal',500,1000, 1.0),
('def_npc_pbs_reactor_rank1','def_axicol',750,1500, 1.0),
('def_npc_pbs_reactor_rank1','def_gamma_buildblock',250,500, 1.0),
('def_npc_pbs_reactor_rank1','def_gamma_defblock',175,350, 1.0),
('def_npc_pbs_reactor_rank1','def_gamma_energyblock',750,1500, 1.0),
('def_npc_pbs_reactor_rank1','def_common_reactor_plasma',25000,50000, 1.0),
('def_npc_pbs_reactor_rank1','def_kernel_common',5000,10000, 1.0),
('def_npc_pbs_reactor_rank1','def_kernel_hitech',2000,4000, 1.0),
('def_npc_pbs_reactor_rank1','def_robotshard_common_basic',100,300, 1.0),
('def_npc_pbs_reactor_rank1','def_robotshard_common_advanced',100,200, 1.0),
('def_npc_pbs_reactor_rank1','def_robotshard_common_expert',100,100, 1.0),

('def_npc_pbs_e_emitter_rank1','def_titanium',5,10, 1.0),
('def_npc_pbs_e_emitter_rank1','def_espitium',30,60, 1.0),
('def_npc_pbs_e_emitter_rank1','def_unimetal',10,20, 1.0),
('def_npc_pbs_e_emitter_rank1','def_axicol',15,30, 1.0),
('def_npc_pbs_e_emitter_rank1','def_gamma_buildblock',5,10, 1.0),
('def_npc_pbs_e_emitter_rank1','def_gamma_energyblock',15,30, 1.0),
('def_npc_pbs_e_emitter_rank1','def_common_reactor_plasma',100,200, 1.0),
('def_npc_pbs_e_emitter_rank1','def_kernel_common',200,400, 1.0),
('def_npc_pbs_e_emitter_rank1','def_kernel_hitech',100,200, 1.0),
('def_npc_pbs_e_emitter_rank1','def_robotshard_common_basic',10,30, 1.0),
('def_npc_pbs_e_emitter_rank1','def_robotshard_common_advanced',10,20, 1.0),
('def_npc_pbs_e_emitter_rank1','def_robotshard_common_expert',10,10, 1.0),

('def_npc_pbs_e_transfer_rank1','def_titanium',10,20, 1.0),
('def_npc_pbs_e_transfer_rank1','def_espitium',40,80, 1.0),
('def_npc_pbs_e_transfer_rank1','def_unimetal',20,40, 1.0),
('def_npc_pbs_e_transfer_rank1','def_axicol',20,40, 1.0),
('def_npc_pbs_e_transfer_rank1','def_gamma_buildblock',10,20, 1.0),
('def_npc_pbs_e_transfer_rank1','def_gamma_energyblock',20,40, 1.0),
('def_npc_pbs_e_transfer_rank1','def_common_reactor_plasma',100,200, 1.0),
('def_npc_pbs_e_transfer_rank1','def_kernel_common',200,400, 1.0),
('def_npc_pbs_e_transfer_rank1','def_kernel_hitech',100,200, 1.0),
('def_npc_pbs_e_transfer_rank1','def_robotshard_common_basic',10,30, 1.0),
('def_npc_pbs_e_transfer_rank1','def_robotshard_common_advanced',10,20, 1.0),
('def_npc_pbs_e_transfer_rank1','def_robotshard_common_expert',10,10, 1.0),

('def_npc_pbs_facility_rank1','def_titanium',250,500, 1.0),
('def_npc_pbs_facility_rank1','def_plasteosine',125,250, 1.0),
('def_npc_pbs_facility_rank1','def_alligior',250,500, 1.0),
('def_npc_pbs_facility_rank1','def_hydrobenol',250,500, 1.0),
('def_npc_pbs_facility_rank1','def_espitium',250,500, 1.0),
('def_npc_pbs_facility_rank1','def_unimetal',500,1000, 1.0),
('def_npc_pbs_facility_rank1','def_axicol',125,250, 1.0),
('def_npc_pbs_facility_rank1','def_axicoline',125,250, 1.0),
('def_npc_pbs_facility_rank1','def_gamma_buildblock',250,500, 1.0),
('def_npc_pbs_facility_rank1','def_gamma_defblock',125,250, 1.0),
('def_npc_pbs_facility_rank1','def_gamma_energyblock',125,250, 1.0),
('def_npc_pbs_facility_rank1','def_gamma_offenseblock',125,250, 1.0),
('def_npc_pbs_facility_rank1','def_common_reactor_plasma',100,200, 1.0),
('def_npc_pbs_facility_rank1','def_kernel_common',200,400, 1.0),
('def_npc_pbs_facility_rank1','def_kernel_hitech',100,200, 1.0),
('def_npc_pbs_facility_rank1','def_robotshard_common_basic',100,300, 1.0),
('def_npc_pbs_facility_rank1','def_robotshard_common_advanced',100,200, 1.0),
('def_npc_pbs_facility_rank1','def_robotshard_common_expert',100,100, 1.0),

('def_npc_pbs_facility_upgrade_rank1','def_titanium',12,25, 1.0),
('def_npc_pbs_facility_upgrade_rank1','def_hydrobenol',25,50, 1.0),
('def_npc_pbs_facility_upgrade_rank1','def_espitium',50,100, 1.0),
('def_npc_pbs_facility_upgrade_rank1','def_unimetal',25,50, 1.0),
('def_npc_pbs_facility_upgrade_rank1','def_axicol',25,50, 1.0),
('def_npc_pbs_facility_upgrade_rank1','def_axicoline',12,25, 1.0),
('def_npc_pbs_facility_upgrade_rank1','def_gamma_buildblock',15,25, 1.0),
('def_npc_pbs_facility_upgrade_rank1','def_gamma_energyblock',25,50, 1.0),
('def_npc_pbs_facility_upgrade_rank1','def_gamma_offenseblock',12,25, 1.0),
('def_npc_pbs_facility_upgrade_rank1','def_common_reactor_plasma',100,200, 1.0),
('def_npc_pbs_facility_upgrade_rank1','def_kernel_common',200,400, 1.0),
('def_npc_pbs_facility_upgrade_rank1','def_kernel_hitech',100,200, 1.0),
('def_npc_pbs_facility_upgrade_rank1','def_robotshard_common_basic',10,30, 1.0),
('def_npc_pbs_facility_upgrade_rank1','def_robotshard_common_advanced',10,20, 1.0),
('def_npc_pbs_facility_upgrade_rank1','def_robotshard_common_expert',10,10, 1.0),

('def_npc_pbs_repair_rank1','def_titanium',25,50, 1.0),
('def_npc_pbs_repair_rank1','def_plasteosine',37,75, 1.0),
('def_npc_pbs_repair_rank1','def_alligior',75,150, 1.0),
('def_npc_pbs_repair_rank1','def_unimetal',50,100, 1.0),
('def_npc_pbs_repair_rank1','def_gamma_buildblock',25,50, 1.0),
('def_npc_pbs_repair_rank1','def_gamma_defblock',37,75, 1.0),
('def_npc_pbs_repair_rank1','def_common_reactor_plasma',100,200, 1.0),
('def_npc_pbs_repair_rank1','def_kernel_common',200,400, 1.0),
('def_npc_pbs_repair_rank1','def_kernel_hitech',100,200, 1.0),
('def_npc_pbs_repair_rank1','def_robotshard_common_basic',10,30, 1.0),
('def_npc_pbs_repair_rank1','def_robotshard_common_advanced',10,20, 1.0),
('def_npc_pbs_repair_rank1','def_robotshard_common_expert',10,10, 1.0),

('def_npc_pbs_miner_tower_rank1','def_titanium',125,250, 1.0),
('def_npc_pbs_miner_tower_rank1','def_plasteosine',125,250, 1.0),
('def_npc_pbs_miner_tower_rank1','def_alligior',250,500, 1.0),
('def_npc_pbs_miner_tower_rank1','def_espitium',125,250, 1.0),
('def_npc_pbs_miner_tower_rank1','def_unimetal',250,500, 1.0),
('def_npc_pbs_miner_tower_rank1','def_axicol',62,125, 1.0),
('def_npc_pbs_miner_tower_rank1','def_gamma_buildblock',125,250, 1.0),
('def_npc_pbs_miner_tower_rank1','def_gamma_defblock',125,250, 1.0),
('def_npc_pbs_miner_tower_rank1','def_gamma_energyblock',62,125, 1.0),
('def_npc_pbs_miner_tower_rank1','def_gammaterial',10000,50000, 1.0),
('def_npc_pbs_miner_tower_rank1','def_common_reactor_plasma',1000,2000, 1.0),
('def_npc_pbs_miner_tower_rank1','def_kernel_common',200,400, 1.0),
('def_npc_pbs_miner_tower_rank1','def_kernel_hitech',100,200, 1.0),
('def_npc_pbs_miner_tower_rank1','def_robotshard_common_basic',10,30, 1.0),
('def_npc_pbs_miner_tower_rank1','def_robotshard_common_advanced',10,20, 1.0),
('def_npc_pbs_miner_tower_rank1','def_robotshard_common_expert',10,10, 1.0),

('def_npc_pbs_control_tower_rank1','def_titanium',25,50, 1.0),
('def_npc_pbs_control_tower_rank1','def_espitium',50,100, 1.0),
('def_npc_pbs_control_tower_rank1','def_unimetal',50,100, 1.0),
('def_npc_pbs_control_tower_rank1','def_axicol',25,50, 1.0),
('def_npc_pbs_control_tower_rank1','def_gamma_buildblock',25,50, 1.0),
('def_npc_pbs_control_tower_rank1','def_gamma_energyblock',25,50, 1.0),
('def_npc_pbs_control_tower_rank1','def_common_reactor_plasma',1000,2000, 1.0),
('def_npc_pbs_control_tower_rank1','def_kernel_common',200,400, 1.0),
('def_npc_pbs_control_tower_rank1','def_kernel_hitech',100,200, 1.0),
('def_npc_pbs_control_tower_rank1','def_robotshard_common_basic',10,30, 1.0),
('def_npc_pbs_control_tower_rank1','def_robotshard_common_advanced',10,20, 1.0),
('def_npc_pbs_control_tower_rank1','def_robotshard_common_expert',10,10, 1.0),

('def_npc_pbs_turret_em_rank1','def_titanium',5,10, 1.0),
('def_npc_pbs_turret_em_rank1','def_hydrobenol',75,150, 1.0),
('def_npc_pbs_turret_em_rank1','def_espitium',50,100, 1.0),
('def_npc_pbs_turret_em_rank1','def_unimetal',10,20, 1.0),
('def_npc_pbs_turret_em_rank1','def_axicol',25,50, 1.0),
('def_npc_pbs_turret_em_rank1','def_axicoline',37,75, 1.0),
('def_npc_pbs_turret_em_rank1','def_gamma_buildblock',5,10, 1.0),
('def_npc_pbs_turret_em_rank1','def_gamma_energyblock',25,50, 1.0),
('def_npc_pbs_turret_em_rank1','def_gamma_offenseblock',37,75, 1.0),
('def_npc_pbs_turret_em_rank1','def_nuimqol_reactor_plasma',4000,6000, 1.0),
('def_npc_pbs_turret_em_rank1','def_kernel_nuimqol',10000,20000, 1.0),
('def_npc_pbs_turret_em_rank1','def_robotshard_nuimqol_basic',300,500, 1.0),
('def_npc_pbs_turret_em_rank1','def_robotshard_nuimqol_advanced',200,400, 1.0),
('def_npc_pbs_turret_em_rank1','def_robotshard_nuimqol_expert',100,300, 1.0),

('def_npc_pbs_turret_laser_rank1','def_titanium',5,10, 1.0),
('def_npc_pbs_turret_laser_rank1','def_hydrobenol',75,150, 1.0),
('def_npc_pbs_turret_laser_rank1','def_espitium',50,100, 1.0),
('def_npc_pbs_turret_laser_rank1','def_unimetal',10,20, 1.0),
('def_npc_pbs_turret_laser_rank1','def_axicol',25,50, 1.0),
('def_npc_pbs_turret_laser_rank1','def_axicoline',37,75, 1.0),
('def_npc_pbs_turret_laser_rank1','def_gamma_buildblock',5,10, 1.0),
('def_npc_pbs_turret_laser_rank1','def_gamma_energyblock',25,50, 1.0),
('def_npc_pbs_turret_laser_rank1','def_gamma_offenseblock',37,75, 1.0),
('def_npc_pbs_turret_laser_rank1','def_thelodica_reactor_plasma',4000,6000, 1.0),
('def_npc_pbs_turret_laser_rank1','def_kernel_thelodica',10000,20000, 1.0),
('def_npc_pbs_turret_laser_rank1','def_robotshard_thelodica_basic',300,500, 1.0),
('def_npc_pbs_turret_laser_rank1','def_robotshard_thelodica_advanced',200,400, 1.0),
('def_npc_pbs_turret_laser_rank1','def_robotshard_thelodica_expert',100,300, 1.0),

('def_npc_pbs_turret_missile_rank1','def_titanium',5,10, 1.0),
('def_npc_pbs_turret_missile_rank1','def_hydrobenol',75,150, 1.0),
('def_npc_pbs_turret_missile_rank1','def_espitium',50,100, 1.0),
('def_npc_pbs_turret_missile_rank1','def_unimetal',10,20, 1.0),
('def_npc_pbs_turret_missile_rank1','def_axicol',25,50, 1.0),
('def_npc_pbs_turret_missile_rank1','def_axicoline',37,75, 1.0),
('def_npc_pbs_turret_missile_rank1','def_gamma_buildblock',5,10, 1.0),
('def_npc_pbs_turret_missile_rank1','def_gamma_energyblock',25,50, 1.0),
('def_npc_pbs_turret_missile_rank1','def_gamma_offenseblock',37,75, 1.0),
('def_npc_pbs_turret_missile_rank1','def_pelistal_reactor_plasma',4000,6000, 1.0),
('def_npc_pbs_turret_missile_rank1','def_kernel_pelistal',10000,20000, 1.0),
('def_npc_pbs_turret_missile_rank1','def_robotshard_pelistal_basic',300,500, 1.0),
('def_npc_pbs_turret_missile_rank1','def_robotshard_pelistal_advanced',200,400, 1.0),
('def_npc_pbs_turret_missile_rank1','def_robotshard_pelistal_expert',100,300, 1.0),

('def_npc_pbs_eff_booster_rank1','def_titanium',12,25, 1.0),
('def_npc_pbs_eff_booster_rank1','def_hydrobenol',25,50, 1.0),
('def_npc_pbs_eff_booster_rank1','def_espitium',50,100, 1.0),
('def_npc_pbs_eff_booster_rank1','def_unimetal',25,50, 1.0),
('def_npc_pbs_eff_booster_rank1','def_axicol',25,50, 1.0),
('def_npc_pbs_eff_booster_rank1','def_axicoline',12,25, 1.0),
('def_npc_pbs_eff_booster_rank1','def_gamma_buildblock',12,25, 1.0),
('def_npc_pbs_eff_booster_rank1','def_gamma_energyblock',25,50, 1.0),
('def_npc_pbs_eff_booster_rank1','def_gamma_offenseblock',12,25, 1.0),
('def_npc_pbs_eff_booster_rank1','def_common_reactor_plasma',100,200, 1.0),
('def_npc_pbs_eff_booster_rank1','def_kernel_common',200,400, 1.0),
('def_npc_pbs_eff_booster_rank1','def_kernel_hitech',100,200, 1.0),
('def_npc_pbs_eff_booster_rank1','def_robotshard_common_basic',10,30, 1.0),
('def_npc_pbs_eff_booster_rank1','def_robotshard_common_advanced',10,20, 1.0),
('def_npc_pbs_eff_booster_rank1','def_robotshard_common_expert',10,10, 1.0),

('def_npc_pbs_e_battery_rank1','def_titanium',100,200, 1.0),
('def_npc_pbs_e_battery_rank1','def_espitium',500,1000, 1.0),
('def_npc_pbs_e_battery_rank1','def_unimetal',200,400, 1.0),
('def_npc_pbs_e_battery_rank1','def_axicol',250,500, 1.0),
('def_npc_pbs_e_battery_rank1','def_gamma_buildblock',100,200, 1.0),
('def_npc_pbs_e_battery_rank1','def_gamma_energyblock',250,500, 1.0),
('def_npc_pbs_e_battery_rank1','def_common_reactor_plasma',100,200, 1.0),
('def_npc_pbs_e_battery_rank1','def_kernel_common',200,400, 1.0),
('def_npc_pbs_e_battery_rank1','def_kernel_hitech',100,200, 1.0),
('def_npc_pbs_e_battery_rank1','def_robotshard_common_basic',10,30, 1.0),
('def_npc_pbs_e_battery_rank1','def_robotshard_common_advanced',10,20, 1.0),
('def_npc_pbs_e_battery_rank1','def_robotshard_common_expert',10,10, 1.0),

('def_npc_pbs_turret_ew_rank1','def_titanium',5,10, 1.0),
('def_npc_pbs_turret_ew_rank1','def_hydrobenol',75,150, 1.0),
('def_npc_pbs_turret_ew_rank1','def_espitium',50,100, 1.0),
('def_npc_pbs_turret_ew_rank1','def_unimetal',10,20, 1.0),
('def_npc_pbs_turret_ew_rank1','def_axicol',25,50, 1.0),
('def_npc_pbs_turret_ew_rank1','def_axicoline',37,75, 1.0),
('def_npc_pbs_turret_ew_rank1','def_gamma_buildblock',5,10, 1.0),
('def_npc_pbs_turret_ew_rank1','def_gamma_energyblock',25,50, 1.0),
('def_npc_pbs_turret_ew_rank1','def_gamma_offenseblock',37,75, 1.0),
('def_npc_pbs_turret_ew_rank1','def_common_reactor_plasma',4000,6000, 1.0),
('def_npc_pbs_turret_ew_rank1','def_kernel_common',4000,5000, 1.0),
('def_npc_pbs_turret_ew_rank1','def_kernel_hitech',1000,1500, 1.0),
('def_npc_pbs_turret_ew_rank1','def_robotshard_common_basic',10,30, 1.0),
('def_npc_pbs_turret_ew_rank1','def_robotshard_common_advanced',10,20, 1.0),
('def_npc_pbs_turret_ew_rank1','def_robotshard_common_expert',10,10, 1.0),

('def_npc_pbs_eff_emitter_rank1','def_titanium',12,25, 1.0),
('def_npc_pbs_eff_emitter_rank1','def_hydrobenol',25,50, 1.0),
('def_npc_pbs_eff_emitter_rank1','def_espitium',50,100, 1.0),
('def_npc_pbs_eff_emitter_rank1','def_unimetal',25,50, 1.0),
('def_npc_pbs_eff_emitter_rank1','def_axicol',25,50, 1.0),
('def_npc_pbs_eff_emitter_rank1','def_axicoline',12,25, 1.0),
('def_npc_pbs_eff_emitter_rank1','def_gamma_buildblock',12,25, 1.0),
('def_npc_pbs_eff_emitter_rank1','def_gamma_energyblock',25,50, 1.0),
('def_npc_pbs_eff_emitter_rank1','def_gamma_offenseblock',12,25, 1.0),
('def_npc_pbs_eff_emitter_rank1','def_common_reactor_plasma',100,200, 1.0),
('def_npc_pbs_eff_emitter_rank1','def_kernel_common',200,400, 1.0),
('def_npc_pbs_eff_emitter_rank1','def_kernel_hitech',100,200, 1.0),
('def_npc_pbs_eff_emitter_rank1','def_robotshard_common_basic',10,30, 1.0),
('def_npc_pbs_eff_emitter_rank1','def_robotshard_common_advanced',10,20, 1.0),
('def_npc_pbs_eff_emitter_rank1','def_robotshard_common_expert',10,10, 1.0),

('def_npc_pbs_energy_tower_rank1','def_titanium',67,135, 1.0),
('def_npc_pbs_energy_tower_rank1','def_plasteosine',67,135, 1.0),
('def_npc_pbs_energy_tower_rank1','def_alligior',125,250, 1.0),
('def_npc_pbs_energy_tower_rank1','def_espitium',67,135, 1.0),
('def_npc_pbs_energy_tower_rank1','def_unimetal',125,250, 1.0),
('def_npc_pbs_energy_tower_rank1','def_axicol',32,65, 1.0),
('def_npc_pbs_energy_tower_rank1','def_gamma_buildblock',67,135, 1.0),
('def_npc_pbs_energy_tower_rank1','def_gamma_defblock',67,135, 1.0),
('def_npc_pbs_energy_tower_rank1','def_gamma_energyblock',30,60, 1.0),
('def_npc_pbs_energy_tower_rank1','def_common_reactor_plasma',10000,15000, 1.0),
('def_npc_pbs_energy_tower_rank1','def_kernel_common',200,400, 1.0),
('def_npc_pbs_energy_tower_rank1','def_kernel_hitech',100,200, 1.0),
('def_npc_pbs_energy_tower_rank1','def_robotshard_common_basic',10,30, 1.0),
('def_npc_pbs_energy_tower_rank1','def_robotshard_common_advanced',10,20, 1.0),
('def_npc_pbs_energy_tower_rank1','def_robotshard_common_expert',10,10, 1.0),

('def_npc_mesmer_guard','def_ammo_medium_railgun_d',8000,10000,0.5),
('def_npc_mesmer_guard','def_named3_medium_armor_plate',1,1,0.25),
('def_npc_mesmer_guard','def_named3_medium_armor_repairer',1,1,0.25),
('def_npc_mesmer_guard','def_named3_thrm_armor_hardener',1,1,0.25),
('def_npc_mesmer_guard','def_named3_medium_railgun',1,1,0.25),
('def_npc_mesmer_guard','def_named3_damage_mod_railgun',1,1,0.25),
('def_npc_mesmer_guard','def_named3_resistant_plating',1,1,0.25),
('def_npc_mesmer_guard','def_named3_webber',1,1,0.25),
('def_npc_mesmer_guard','def_named3_eccm',1,1,0.25),
('def_npc_mesmer_guard','def_named3_medium_core_booster',1,1,0.25),
('def_npc_mesmer_guard','def_robotshard_common_basic',200,250,0.5),
('def_npc_mesmer_guard','def_robotshard_common_advanced',150,200,0.5),
('def_npc_mesmer_guard','def_robotshard_common_expert',100,150,0.5),
('def_npc_mesmer_guard','def_robotshard_nuimqol_basic',200,250,0.5),
('def_npc_mesmer_guard','def_robotshard_nuimqol_advanced',150,200,0.5),
('def_npc_mesmer_guard','def_robotshard_nuimqol_expert',100,150,0.5),
('def_npc_mesmer_guard','def_nuimqol_reactor_plasma',10000,25000,1),
('def_npc_mesmer_guard','def_kernel_nuimqol',4000,5000,1),
('def_npc_mesmer_guard','def_kernel_common',2500,10000,1),
('def_npc_mesmer_guard','def_kernel_hitech',4000,5000,1),

('def_npc_seth_guard','def_ammo_medium_lasercrystal_d',8000,10000,0.5),
('def_npc_seth_guard','def_named3_medium_armor_plate',1,1,0.25),
('def_npc_seth_guard','def_named3_medium_armor_repairer',1,1,0.25),
('def_npc_seth_guard','def_named3_exp_armor_hardener',1,1,0.25),
('def_npc_seth_guard','def_named3_medium_laser',1,1,0.25),
('def_npc_seth_guard','def_named3_damage_mod_laser',1,1,0.25),
('def_npc_seth_guard','def_named3_webber',1,1,0.25),
('def_npc_seth_guard','def_named3_eccm',1,1,0.25),
('def_npc_seth_guard','def_named3_core_recharger',1,1,0.25),
('def_npc_seth_guard','def_robotshard_common_basic',200,250,0.5),
('def_npc_seth_guard','def_robotshard_common_advanced',150,200,0.5),
('def_npc_seth_guard','def_robotshard_common_expert',100,150,0.5),
('def_npc_seth_guard','def_robotshard_thelodica_basic',200,250,0.5),
('def_npc_seth_guard','def_robotshard_thelodica_advanced',150,200,0.5),
('def_npc_seth_guard','def_robotshard_thelodica_expert',100,150,0.5),
('def_npc_seth_guard','def_thelodica_reactor_plasma',10000,25000,1),
('def_npc_seth_guard','def_kernel_thelodica',4000,5000,1),
('def_npc_seth_guard','def_kernel_common',2500,10000,1),
('def_npc_seth_guard','def_kernel_hitech',4000,5000,1),

('def_npc_gropho_guard','def_ammo_missile_d',8000,10000,0.5),
('def_npc_gropho_guard','def_named3_medium_armor_plate',1,1,0.25),
('def_npc_gropho_guard','def_named3_medium_armor_repairer',1,1,0.25),
('def_npc_gropho_guard','def_named3_kin_armor_hardener',1,1,0.25),
('def_npc_gropho_guard','def_named3_missile_launcher',1,1,0.25),
('def_npc_gropho_guard','def_named3_damage_mod_missile',1,1,0.25),
('def_npc_gropho_guard','def_named3_webber',1,1,0.25),
('def_npc_gropho_guard','def_named3_eccm',1,1,0.25),
('def_npc_gropho_guard','def_named3_medium_energy_neutralizer',1,1,0.25),
('def_npc_gropho_guard','def_robotshard_common_basic',200,250,0.5),
('def_npc_gropho_guard','def_robotshard_common_advanced',150,200,0.5),
('def_npc_gropho_guard','def_robotshard_common_expert',100,150,0.5),
('def_npc_gropho_guard','def_robotshard_pelistal_basic',200,250,0.5),
('def_npc_gropho_guard','def_robotshard_pelistal_advanced',150,200,0.5),
('def_npc_gropho_guard','def_robotshard_pelistal_expert',100,150,0.5),
('def_npc_gropho_guard','def_pelistal_reactor_plasma',10000,25000,1),
('def_npc_gropho_guard','def_kernel_pelistal',4000,5000,1),
('def_npc_gropho_guard','def_kernel_common',2500,10000,1),
('def_npc_gropho_guard','def_kernel_hitech',4000,5000,1),

('def_npc_sh70_miniboss_a','def_material_boss_z70',10,20,1.0),
('def_npc_sh70_miniboss_a','def_robotshard_common_basic',150,300,1),
('def_npc_sh70_miniboss_a','def_robotshard_common_advanced',100,200,1),
('def_npc_sh70_miniboss_a','def_robotshard_common_expert',50,100,1),
('def_npc_sh70_miniboss_a','def_common_reactor_plasma',10000,15000,1),
('def_npc_sh70_miniboss_a','def_kernel_common',8000,10000,1),
('def_npc_sh70_miniboss_a','def_kernel_hitech',4000,5000,1),

('def_npc_sh70_miniboss_b','def_material_boss_z70',10,20,1.0),
('def_npc_sh70_miniboss_b','def_robotshard_common_basic',150,300,1),
('def_npc_sh70_miniboss_b','def_robotshard_common_advanced',100,200,1),
('def_npc_sh70_miniboss_b','def_robotshard_common_expert',50,100,1),
('def_npc_sh70_miniboss_b','def_common_reactor_plasma',10000,15000,1),
('def_npc_sh70_miniboss_b','def_kernel_common',8000,10000,1),
('def_npc_sh70_miniboss_b','def_kernel_hitech',4000,5000,1),

('def_npc_sh70_mainboss','def_material_boss_z70',6000,8000,1.0),
('def_npc_sh70_mainboss','def_boost_ep_t0',1,8, 1.0),
('def_npc_sh70_mainboss','def_boost_ep_t1',1,2, 1.0),
('def_npc_sh70_mainboss','def_boost_ep_t2',1,1, 1.0),
('def_npc_sh70_mainboss','def_common_reactor_plasma',20000,50000, 1.0),
('def_npc_sh70_mainboss','def_pelistal_reactor_plasma',20000,50000, 1.0),
('def_npc_sh70_mainboss','def_nuimqol_reactor_plasma',20000,50000, 1.0),
('def_npc_sh70_mainboss','def_thelodica_reactor_plasma',20000,50000, 1.0),
('def_npc_sh70_mainboss','def_kernel_pelistal',25000,40000, 1.0),
('def_npc_sh70_mainboss','def_kernel_thelodica',25000,40000, 1.0),
('def_npc_sh70_mainboss','def_kernel_nuimqol',25000,40000, 1.0),
('def_npc_sh70_mainboss','def_kernel_common',25000,40000, 1.0),
('def_npc_sh70_mainboss','def_kernel_hitech',10000,20000, 1.0),
('def_npc_sh70_mainboss','def_robotshard_common_basic',500,1000, 1.0),
('def_npc_sh70_mainboss','def_robotshard_common_advanced',400,1000, 1.0),
('def_npc_sh70_mainboss','def_robotshard_common_expert',300,1000, 1.0),
('def_npc_sh70_mainboss','def_robotshard_nuimqol_basic',500,1000, 1.0),
('def_npc_sh70_mainboss','def_robotshard_nuimqol_advanced',400,1000, 1.0),
('def_npc_sh70_mainboss','def_robotshard_nuimqol_expert',300,1000, 1.0),
('def_npc_sh70_mainboss','def_robotshard_pelistal_basic',500,1000, 1.0),
('def_npc_sh70_mainboss','def_robotshard_pelistal_advanced',400,1000, 1.0),
('def_npc_sh70_mainboss','def_robotshard_pelistal_expert',400,1000, 1.0),
('def_npc_sh70_mainboss','def_robotshard_thelodica_basic',500,1000, 1.0),
('def_npc_sh70_mainboss','def_robotshard_thelodica_advanced',400,1000, 1.0),
('def_npc_sh70_mainboss','def_robotshard_thelodica_expert',300,1000, 1.0),
('def_npc_sh70_mainboss','def_reactore_core_runner',1,2, 1.0),
('def_npc_sh70_mainboss','def_reactore_core_assault',1,2, 1.0),
('def_npc_sh70_mainboss','def_reactore_core_mech',1,2, 1.0),
('def_npc_sh70_mainboss','def_reactore_core_heavymech',1,2, 1.0);

PRINT N'DELETE ALL LOOT TO BE REINSERTED (0 if new)';
DELETE FROM npcloot WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT npcName FROM #LOOT));

PRINT N'UPDATE/INSERT ALL LOOTS';
MERGE npcloot n USING #LOOT o
ON n.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=o.npcName) AND
n.lootdefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=o.lootName)
WHEN MATCHED
    THEN UPDATE SET
		minquantity=o.minQuantity,
		quantity=o.maxQuantity,
		probability=o.probability
WHEN NOT MATCHED
    THEN INSERT (definition, lootdefinition, minquantity, quantity, probability, repackaged, dontdamage) VALUES
		((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=o.npcName),
		(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=o.lootName),
		o.minQuantity, o.maxQuantity, o.probability, 0, 0);



DROP TABLE IF EXISTS #LOOT;
PRINT N'ALL STRONGHOLD PBS NPCS LOOT SET';
GO

PRINT N'06_Entity_Insert_RallyTerminal_zone70.sql';
USE [perpetuumsa]
GO

----------------------------------
-- Add "Rally" Field Terminal to zone 70
-- Note: Requires Zone 70!
--
-- Date Modified: 2020/11/18
----------------------------------

IF NOT EXISTS (SELECT TOP 1 id FROM zones WHERE id=70)
BEGIN
	PRINT N'ZONE 70 NOT FOUND -- NOT EXECUTING INSERTS!!';
	SET NOEXEC ON;
END

-- Parameters
DECLARE @terminalZone AS INT = 70;
DECLARE @terminalName AS VARCHAR(128) = 'fieldTerminal_z'+CAST(@terminalZone AS VARCHAR(24))+'_n00';
DECLARE @terminalSyncKey AS VARCHAR(50) = 'fieldterm_z70n00';
DECLARE @x AS INT = 454;
DECLARE @y AS INT = 397;
DECLARE @z AS INT = 125;

-- ID Stuff
DECLARE @rallyTermDef AS INT = (select definition from entitydefaults where definitionname = 'def_field_terminal_rally');
DECLARE @storageDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_public_container');
DECLARE @newEntityId AS BIGINT = (SELECT TOP 1 eid + 1 FROM entities WHERE eid + 1 NOT IN (SELECT DISTINCT eid FROM entities));
DECLARE @newEntityStorageId AS BIGINT = (SELECT TOP 1 eid + 1 FROM entities WHERE eid + 1 NOT IN (SELECT DISTINCT eid FROM entities) AND eid+1 <> @newEntityId);

IF NOT EXISTS (SELECT TOP 1 eid FROM entities WHERE ename=@terminalName)
BEGIN
	-- Insert Entity for rally terminal
	PRINT N'Insert Entity for rally terminal';
	INSERT INTO [dbo].[entities]
			   ([eid],[definition],[owner],[parent],[health],[ename],[quantity],[repackaged],[dynprop])
		 VALUES
			   (@newEntityId,@rallyTermDef,null,null,100,@terminalName,1,0,null);

	-- Insert container for rally terminal to enable storage
	PRINT N'Insert container for rally terminal to enable storage';
	INSERT INTO [dbo].[entities]
			   ([eid],[definition],[owner],[parent],[health],[ename],[quantity],[repackaged],[dynprop])
		 VALUES
			   (@newEntityStorageId,@storageDef,null,@newEntityId,100,null,1,0,'#log=i0')

	-- Insert zone entity for rally terminal
	PRINT N'Insert zone entity for rally terminal';
	INSERT INTO [dbo].[zoneentities]
			   ([zoneID],[eid],[definition],[owner],[ename],[x],[y],[z],[orientation],[enabled],[note],[runtime],[synckey])
		 VALUES
			   (@terminalZone,@newEntityId,null,null,@terminalName,@x,@y,@z,0,1,null,0,@terminalSyncKey);
END
ELSE
BEGIN
	PRINT N'WARN: OPERATION HAS ALREADY RUN, ENTITY FOUND OF NAME:'+@terminalName;
	PRINT N'NO INSERTIONS MADE!!!';
END

SET NOEXEC OFF;
GO

PRINT N'07_DECOR_IMPORT_zone70_2021_01_10.sql';
USE [perpetuumsa]
GO
--Date of export: 2020/01/10 from DEV
----------------------------------------------------------
-- DECOR REPLICATION SCRIPT (Import)
-- Decor replication involves transfer of layers and table entries
-- These scripts handle ONLY decore table entries.  
-- Layer data should be shared manually if layers are updated!
--
-- This is the IMPORT script which requires you have:
-- A) Correctly labeled, updated layer files in C:/perpserver/data/layers
-- B) The results of the export script
-- The Import will also WIPE all existing DECOR on the same ZONE!
-- If you wish to "merge" decor, handle the conflict as you see fit.
--
-- How to use Import:
-- 0.  Set the correct ZoneID
-- 1.  From the provided export text file: copy the contents
-- 2.  Paste the contents between the 'REPLACE' and 'END REPLACE'
-- 3.  Remove the last trailing ',' (comma) and replace with ';' (semicolon)
-- 4.  Run the script
----------------------------------------------------------

DECLARE @zoneID INT;
SET @zoneID = 70;

PRINT N'DELETING ALL DECOR ON ZONE: ' + CONVERT(varchar(10), @zoneID);
DELETE FROM decor WHERE zoneid=@zoneID;
INSERT INTO decor (definition, quaternionx, quaterniony, quaternionz, quaternionw, zoneid, x, y, z, scale, changed, fadedistance, category, locked) VALUES
--REPLACE
(3469,0,0,0,1,70,125568,100736,5104,1,1,0,1,0),
(3469,0,0,0,1,70,125568,104064,5106,1,1,0,1,0),
(3315,0,-0.461749,0,0.887011,70,113024,95360,5070,1,1,0,1,0),
(3309,0,-0.737277,0,0.67559,70,112512,97408,6064,1,1,0,1,0),
(3744,0,0,0,1,70,112512,96640,5050,1,1,0,1,0),
(3744,0,0,0,1,70,112768,99712,5104,1,1,0,1,0),
(3744,0,0,0,1,70,114304,94592,5098,1,1,0,1,0),
(3337,0,-0.642787,0,0.766044,70,114988,94717,5917,1,1,0,1,0),
(3334,0,0,0,1,70,117121,95360,5102,1,1,0,1,0),
(3337,0,0.771624,0,0.636078,70,119319,95872,5960,1,1,0,1,0),
(2760,0,0,0,1,70,121767,97184,5106,1,1,0,1,0),
(3313,0,0.267238,0,0.963631,70,90017,77989,6296,1,1,0,1,0),
(3313,0,0.241922,0,0.970296,70,94592,70016,5720,1,1,0,1,0),
(3313,0,-0.948324,0,0.317305,70,83886,86683,5990,1,1,0,1,0),
(3316,0,0.267238,0,0.96363,70,98944,68480,5364,1,1,0,1,0),
(3316,0,0.317304,0,0.948323,70,83818,92501,6473,1,1,0,1,0),
(3316,0,0.292372,0,0.956305,70,88960,85632,6270,1,1,0,1,0),
(3310,0,-0.956305,0,0.292372,70,112256,93312,5896,1,1,0,1,0),
(3310,0,0.292372,0,0.956304,70,109850,91739,5898,1,1,0,1,0),
(2804,0,0.968148,0,-0.25038,70,107904,90254,5286,1,1,0,1,0),
(2802,0,0.25038,0,0.968148,70,107158,89954,9137,1,1,0,1,0),
(3310,0,0.21644,0,0.976296,70,105362,89282,5916,1,1,0,1,0),
(3480,0,0.882948,0,0.469472,70,103488,88825,5348,1,1,0,1,0),
(3310,0,0.224951,0,0.97437,70,102732,88029,5928,1,1,0,1,0),
(3480,0,0.848049,0,0.529919,70,101259,87670,5316,1,1,0,1,0),
(3310,0,0.199368,0,0.979925,70,100054,86824,5929,1,1,0,1,0),
(3310,0,0.190809,0,0.981627,70,97307,85688,5928,1,1,0,1,0),
(3480,-0.011681,0.8336,-0.023428,0.551747,70,98491,86493,5370,1,1,0,1,0),
(2805,0,0.970297,0,-0.241921,70,95776,84798,5458,1,1,0,1,0),
(3310,0,0.694658,0,0.71934,70,94336,82191,7295,1,1,0,1,0),
(3316,0,0.233445,0,0.97237,70,92800,79935,6556,1,1,0,1,0),
(3310,0,0.078459,0,0.996917,70,92032,86656,7095,1,1,0,1,0),
(3310,0,0.66262,0,0.748956,70,112798,99968,5873,1,1,0,1,0),
(2804,0,0.65606,0,0.75471,70,113034,103881,5331,1,1,0,1,0),
(3472,0,-0.998135,0,-0.061049,70,112875,102105,6555,1,1,0,1,0),
(3312,0,-0.731354,0,0.681998,70,112619,102565,4992,1,1,0,1,0),
(1406,0,-0.087155,0,0.996195,70,113260,104820,9178,1,1,0,1,0),
(3716,0,-0.71325,0,0.70091,70,127652,101747,5104,1,1,0,1,0),
(3334,0,0,0,1,70,126191,96640,4860,1,1,0,1,0),
(3328,0,0.725375,0,0.688355,70,123007,96777,6403,1,1,0,1,0),
(4043,0,0,0,1,70,108928,94848,4912,1,1,0,1,0),
(3480,0,-0.902585,0,-0.430511,70,110717,92634,5170,1,1,0,1,0),
(4043,0,0,0,1,70,102016,91008,5342,1,1,0,1,0),
(4043,0,0,0,1,70,99968,89984,5324,1,1,0,1,0),
(4043,0,0,0,1,70,97152,88704,5326,1,1,0,1,0),
(3688,0,0,0,1,70,115584,106624,5104,1,1,0,1,0),
(3685,0,0,0,1,70,118144,107927,5108,1,1,0,1,0),
(3487,0,-0.382683,0,0.92388,70,25313,28185,4084,1,1,0,1,0),
(3722,0,-0.52992,0,0.848048,70,33715,11842,4390,1,1,0,1,0),
(3720,0,-0.848049,0,-0.52992,70,40832,15651,4674,1,1,0,1,0),
(2797,0,0.207912,0,0.978148,70,39296,15232,4926,1,1,0,1,0),
(3473,0,0,0,1,70,37760,14976,4928,1,1,0,1,0),
(3700,0,0,0,1,70,37248,20352,5166,1,1,0,1,0),
(3701,0,0,0,1,70,21888,6272,4398,1,1,0,1,0),
(3316,0,0.121869,0,0.992546,70,106837,41363,5372,1,1,0,1,0),
(3313,0,0.809017,0,0.587785,70,100064,39182,5374,1,1,0,1,0),
(3293,0,0,0,1,70,95360,33920,5076,1,1,0,1,0),
(3313,0,-0.207912,0,0.978148,70,93824,32890,5142,1,1,0,1,0),
(3313,0,0.241922,0,0.970295,70,92662,20229,5218,1,1,0,1,0),
(3316,0,0.559193,0,0.829038,70,0,524288,90368,1,1,0,1,0),
(3316,0,0.566407,0,0.824126,70,91008,26752,5580,1,1,0,1,0),
(3714,0,-0.993572,0,-0.113203,70,98409,20493,4990,1,1,0,1,0),
(3718,0,-0.861629,0,0.507538,70,99968,28637,5032,1,1,0,1,0),
(3717,0,-0.866025,0,0.5,70,103933,34000,5032,1,1,0,1,0),
(3744,0,0,0,1,70,105600,36992,5376,1,1,0,1,0),
(3744,0,0,0,1,70,105088,34432,5374,1,1,0,1,0),
(3744,0,0,0,1,70,103552,35200,5374,1,1,0,1,0),
(3744,0,0,0,1,70,100736,29056,5014,1,1,0,1,0),
(3744,0,0,0,1,70,98944,26240,4966,1,1,0,1,0),
(3744,0,0,0,1,70,98176,23680,5044,1,1,0,1,0),
(2826,0,0.961262,0,0.275637,70,97878,35019,5032,1,1,0,1,0),
(3688,0,0,0,1,70,95104,31360,5032,1,1,0,1,0),
(3688,0,0,0,1,70,101760,38016,5038,1,1,0,1,0),
(3684,0,0,0,1,70,99456,32896,5032,1,1,0,1,0),
(3683,0,0,0,1,70,107904,22400,5288,1,1,0,1,0),
(3683,0,0,0,1,70,112256,23424,5370,1,1,0,1,0),
(3683,0,0,0,1,70,115328,27264,5360,1,1,0,1,0),
(3443,0,0.891007,0,0.453991,70,116949,44636,5340,1,1,0,1,0),
(2827,0,0,0,1,70,78208,44416,5234,1,1,0,1,0),
(3333,0,-0.587785,0,0.809017,70,48768,30336,5372,1,1,0,1,0),
(3333,0,-0.97437,0,0.224951,70,30295,39728,5376,1,1,0,1,0),
(3333,0,0.190809,0,0.981627,70,33540,41690,5376,1,1,0,1,0),
(3333,0,0,0,1,70,36883,42191,5376,1,1,0,1,0),
(3333,0,-0.275637,0,0.961262,70,39945,41303,5376,1,1,0,1,0),
(3333,0,-0.382682,0,0.92388,70,42368,39069,5376,1,1,0,1,0),
(3333,0,-0.469472,0,0.882948,70,47308,33343,5376,1,1,0,1,0),
(3275,0,0.71325,0,0.700909,70,18304,-160,3200,1,1,0,1,0),
(2829,0,0,0,1,70,21120,1920,2248,1,1,0,1,0),
(3392,0,0,0,1,70,17846,4177,4398,1,1,0,1,0),
(2797,0,0,0,1,70,20608,3968,4396,1,1,0,1,0),
(2797,0,0,0,1,70,20608,4736,4394,1,1,0,1,0),
(2803,0,0.707106,0,-0.707107,70,21120,4480,4396,1,1,0,1,0),
(2823,0,0,0,1,70,22104,3925,6914,1,1,0,1,0),
(3480,0,0.999657,0,0.026177,70,20597,4536,6066,1,1,0,1,0),
(3306,0,-0.66262,0,0.748956,70,19870,-2392,5061,1,1,0,1,0),
(3326,0,0,0,1,70,19808,-2661,5015,1,1,0,1,0),
(3326,0,-0.008727,0,0.999962,70,19859,-126,5009,1,1,0,1,0),
(3327,0,-0.71325,0,0.700909,70,21722,-299,5273,1,1,0,1,0),
(3683,0,0,0,1,70,20196,-4227,3190,1,1,0,1,0),
(3699,0,0,0,1,70,21168,-2735,3217,1,1,0,1,0),
(3509,0,0.66262,0,0.748956,70,52982,112000,2551,0.34,1,0,1,0),
(3392,0,0,0,1,70,19118,4182,4396,1,1,0,1,0),
(2822,0,0,0,1,70,14464,123520,3640,1,1,0,1,0),
(3461,0,0,0,1,70,16768,122752,3039,1,1,0,1,0),
(2747,0,0,0.173648,0.984808,70,16919,106407,1285,0.5,1,0,1,0),
(1406,0,0.97437,0,0.224951,70,6865,124746,3212,1,1,0,1,0),
(2746,0.097904,0.673574,-0.139113,0.719276,70,21777,113031,856,0.5,1,0,1,0),
(3335,0.179369,0.009246,0.094308,0.979207,70,24809,115918,3471,1,1,0,1,0),
(3443,-0.157838,-0.965185,-0.080845,0.192274,70,29150,115055,2832,0.5,1,0,1,0),
(1140,0,0,0,1,70,26725,10039,4690,1,1,0,1,0),
(3486,-0.615661,0,0,0.788011,70,27751,11464,4692,0.16,1,0,1,0),
(3486,-0.615661,0,0,0.788011,70,25715,11464,4692,0.16,1,0,1,0),
(2758,0,0.999848,0,-0.017452,70,114108,35456,5374,1,1,0,1,0),
(3313,0,0.891006,0,0.45399,70,113669,45440,5362,1,1,0,1,0),
(3469,0,0,0,1,70,125568,102528,5106,1,1,0,1,0),
(2806,0,0,0,1,70,65408,37248,5370,1,1,0,1,0),
(2789,0,-0.656058,0,0.75471,70,67712,18296,5274,1,1,0,1,0),
(2763,0,0.034899,0,0.999391,70,80512,20096,5352,1,1,0,1,0),
(2765,0,0,0,1,70,81280,29568,5374,1,1,0,1,0),
(2758,0,-0.887011,0,0.461749,70,30080,46976,5376,1,1,0,1,0);
--END REPLACE

GO

PRINT N'08_Aggvalues_destro_balance__2020_12_26.sql';
USE [perpetuumsa]
GO
------------------------------------------------
-- Destroyer balance round 1 for P20
-- Onyx reduce locking and LR gun optimal range
-- Seth reduce locking range
-- Destro locked targets 2->3
-- Hydra LR ammo falloff inc
-- Felos LR gun falloff inc
------------------------------------------------
PRINT N'DESTRO STAT UPDATES';
DROP TABLE IF EXISTS #STATS;
CREATE TABLE #STATS(
	defName varchar(100),
	fieldName varchar(100),
	fieldValue float,
);
INSERT INTO #STATS (defName, fieldName, fieldValue) VALUES
('def_felos_bot_head', 'detection_strength', 60),--was 55
('def_felos_bot_head', 'stealth_strength', 80),--was 55
('def_felos_bot_head', 'sensor_strength', 95),--was 95
('def_felos_bot_head', 'locked_targets_max', 3),--was 2
('def_felos_bot_head', 'locking_range', 35),--was 36

('def_hydra_bot_head', 'detection_strength', 60),--was 55
('def_hydra_bot_head', 'stealth_strength', 65),--was 55
('def_hydra_bot_head', 'sensor_strength', 110),--was 95
('def_hydra_bot_head', 'locked_targets_max', 3),--was 2
('def_hydra_bot_head', 'locking_range', 36),--was 37

('def_onyx_bot_head', 'detection_strength', 60),--was 55
('def_onyx_bot_head', 'stealth_strength', 65),--was 55
('def_onyx_bot_head', 'sensor_strength', 95),--was 95
('def_onyx_bot_head', 'locked_targets_max', 3),--was 2
('def_onyx_bot_head', 'locking_range', 37),--was 40

('def_seth_head', 'locking_range', 35),--was 37
('def_seth_head_mk2', 'locking_range', 35),
('def_seth_head_pr', 'locking_range', 35),

('def_longrange_standard_large_laser', 'optimal_range', 44),--was 50
('def_longrange_standard_large_laser_pr', 'optimal_range', 44),
('def_named1_longrange_large_laser', 'optimal_range', 44),
('def_named1_longrange_large_laser_pr', 'optimal_range', 44),
('def_named2_longrange_large_laser', 'optimal_range', 45.5),--was 51.5
('def_named2_longrange_large_laser_pr', 'optimal_range', 45.5),
('def_named3_longrange_large_laser', 'optimal_range', 46.5),--was 52.5
('def_named3_longrange_large_laser_pr', 'optimal_range', 46.5),

('def_longrange_standard_large_railgun', 'optimal_range', 46), --was 44
('def_longrange_standard_large_railgun', 'falloff', 25.5),--was 22.5
('def_longrange_standard_large_railgun_pr', 'optimal_range', 46),
('def_longrange_standard_large_railgun_pr', 'falloff', 25.5),
('def_named1_longrange_large_railgun', 'optimal_range', 46),--was 44
('def_named1_longrange_large_railgun', 'falloff', 25.5),--was 22.5
('def_named1_longrange_large_railgun_pr', 'optimal_range', 46),
('def_named1_longrange_large_railgun_pr', 'falloff', 25.5),
('def_named2_longrange_large_railgun', 'optimal_range', 47),--was 45
('def_named2_longrange_large_railgun', 'falloff', 24),--was 21
('def_named2_longrange_large_railgun_pr', 'optimal_range', 47),
('def_named2_longrange_large_railgun_pr', 'falloff', 24),
('def_named3_longrange_large_railgun', 'optimal_range', 48),--was 46
('def_named3_longrange_large_railgun', 'falloff', 24),--was 21
('def_named3_longrange_large_railgun_pr', 'optimal_range', 48),
('def_named3_longrange_large_railgun_pr', 'falloff', 24),

('def_ammo_longrange_cruisemissile_a', 'falloff', 15),--was 10
('def_ammo_longrange_cruisemissile_b', 'falloff', 15),
('def_ammo_longrange_cruisemissile_c', 'falloff', 15),
('def_ammo_longrange_cruisemissile_d', 'falloff', 15),
('def_ammo_longrange_cruisemissile_a_pr', 'falloff', 15),
('def_ammo_longrange_cruisemissile_b_pr', 'falloff', 15),
('def_ammo_longrange_cruisemissile_c_pr', 'falloff', 15),
('def_ammo_longrange_cruisemissile_d_pr', 'falloff', 15);


PRINT N'UPSERT [aggregatevalues]';
MERGE [dbo].[aggregatevalues] v USING #STATS s
ON v.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=s.defName) AND
v.field = (SELECT TOP 1 id FROM aggregatefields WHERE name=s.fieldName)
WHEN MATCHED
    THEN UPDATE SET
		v.value=s.fieldValue
WHEN NOT MATCHED
    THEN INSERT (definition, field, value) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=s.defName),
	(SELECT TOP 1 id FROM aggregatefields WHERE name=s.fieldName),
	s.fieldValue);

PRINT N'DESTRO STAT UPDATES complete';
DROP TABLE IF EXISTS #STATS;
GO


PRINT N'09_Aggvalues_pbsTurret_ranges__2020_12_26.sql';
USE perpetuumsa
GO
----------------------------------------------------------
-- Gamma turret weapon balance
-- Date modified: 2020/12/29
----------------------------------------------------------
PRINT N'updating PBS turret module ranges';
DROP TABLE IF EXISTS #STATS;
CREATE TABLE #STATS
(
	defName varchar(100),
	fieldName varchar(100),
	fieldValue float,
);
INSERT INTO #STATS (defName, fieldName, fieldValue) VALUES
('def_turret_laser', 'optimal_range', 80),--90
('def_turret_laser', 'falloff', 60),--30
('def_ammo_longrange_missile_pbs_turret', 'optimal_range', 80), --75
('def_ammo_longrange_missile_pbs_turret', 'falloff', 40), --0
('def_turret_missile_launcher', 'module_missile_range_modifier', 1), --1.2
('def_turret_missile_launcher', 'module_missile_falloff_modifier', 1), --N/A
('def_turret_railgun', 'optimal_range', 80),--90
('def_turret_railgun', 'falloff', 50),
('def_turret_energy_neutralizer', 'optimal_range', 60),--90
('def_turret_energy_neutralizer', 'falloff', 40),--0
('def_turret_webber', 'optimal_range', 80),--90
('def_turret_webber', 'falloff', 20),--0
('def_turret_sensor_jammer', 'optimal_range', 80),--90
('def_turret_sensor_jammer', 'falloff', 60),--0
('def_turret_sensor_dampener', 'optimal_range', 80),--90
('def_turret_sensor_dampener', 'falloff', 20);--0

MERGE [dbo].[aggregatevalues] v USING #STATS s
ON v.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE s.defName=definitionname) AND
v.field = (SELECT TOP 1 id FROM aggregatefields WHERE name=s.fieldName)
WHEN MATCHED
    THEN UPDATE SET
		v.value=s.fieldValue
WHEN NOT MATCHED
    THEN INSERT (definition, field, value) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE s.defName=definitionname),
	(SELECT TOP 1 id FROM aggregatefields WHERE name=s.fieldName),
	s.fieldValue);
	
DROP TABLE IF EXISTS #STATS;
PRINT N'Done updating PBS turret module ranges';
GO


PRINT N'10_Moduleprops_upsert_ewarFalloff__2020_12_22.sql';
USE [perpetuumsa]
GO

----------------------------------------------------------
-- Add falloff and falloff modifiers to Ewar/Enwar modules
-- Falloff add to "turret" type modules
-- modulepropertymodifiers added if missing
-- Date modified: 2020/12/29
----------------------------------------------------------

PRINT N'ADD FALLOFF MODIFIERS TO E(N)WAR MODULES';
DROP TABLE IF EXISTS #MOD_PROPS;
CREATE TABLE #MOD_PROPS (
	categoryName VARCHAR(100),
	baseFieldName VARCHAR(100),
	modFieldName VARCHAR(100)
);
INSERT INTO #MOD_PROPS (categoryName, baseFieldName, modFieldName) VALUES
('cf_energy_neutralizers', 'falloff', 'falloff_modifier'),
('cf_energy_transferers', 'falloff', 'falloff_modifier'),
('cf_energy_vampires', 'falloff', 'falloff_modifier'),
('cf_sensor_jammers', 'falloff', 'falloff_modifier'),
('cf_sensor_dampeners', 'falloff', 'falloff_modifier'),
('cf_webber', 'falloff', 'falloff_modifier');

--insert [modulepropertymodifiers] entries
PRINT N'0 if already run';
MERGE [dbo].[modulepropertymodifiers] m USING #MOD_PROPS t
ON m.categoryflags = (SELECT TOP 1 value FROM categoryflags WHERE name=t.categoryName) AND
m.basefield=(SELECT TOP 1 id FROM aggregatefields WHERE name=t.baseFieldName) AND
m.modifierfield=(SELECT TOP 1 id FROM aggregatefields WHERE name=t.modFieldName)
WHEN NOT MATCHED
    THEN INSERT (categoryflags, basefield, modifierfield) VALUES
	((SELECT TOP 1 value FROM categoryflags WHERE name=t.categoryName),
	(SELECT TOP 1 id FROM aggregatefields WHERE name=t.baseFieldName),
	(SELECT TOP 1 id FROM aggregatefields WHERE name=t.modFieldName));

PRINT N'Done adding FALLOFF MODIFIERS TO E(N)WAR MODULES';
DROP TABLE IF EXISTS #MOD_PROPS;
GO


PRINT N'11_PlantrulesOmega_zones_update__2021_01_19.sql';
USE [perpetuumsa]
GO

---------------------------------------------
-- Stronghold plant rule apply to Omega
--
-- Date 2021/01/19
---------------------------------------------


UPDATE zones SET
	plantruleset=(SELECT plantruleset FROM zones WHERE name='zone_strghld_70')
WHERE name='zone_pvp_arena' AND id=16;

GO

PRINT N'12_Productioncost_upsert__2021_01_20.sql';
USE [perpetuumsa]
GO

------------------------------------------
-- Set production costs for T2+/4+
-- Date: 2021/1/21
------------------------------------------

PRINT N'UPSERT productioncost FOR T2/4+';

IF EXISTS (SELECT TOP 1 id FROM productioncost WHERE tiertype=3 AND tierlevel=2 AND category IS NULL)
BEGIN
	UPDATE productioncost SET
		costmodifier=5
	WHERE tiertype=3 AND tierlevel=2 AND category IS NULL;
END
ELSE
BEGIN
	INSERT INTO productioncost (category, tiertype, tierlevel, costmodifier) VALUES
	(NULL, 3, 2, 5);
END

IF EXISTS (SELECT TOP 1 id FROM productioncost WHERE tiertype=3 AND tierlevel=4 AND category IS NULL)
BEGIN
	UPDATE productioncost SET
		costmodifier=6
	WHERE tiertype=3 AND tierlevel=4 AND category IS NULL;
END
ELSE
BEGIN
	INSERT INTO productioncost (category, tiertype, tierlevel, costmodifier) VALUES
	(NULL, 3, 4, 6);
END
PRINT N'DONE UPSERT productioncost FOR T2/4+';

GO

PRINT N'PATCH 20 APPLIED!';
GO
