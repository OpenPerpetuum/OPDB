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