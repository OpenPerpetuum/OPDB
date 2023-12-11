USE [perpetuumsa]
GO

PRINT N'00_RESPEC_Tokens.sql';

---- New category for RESPEC Tokens ----

IF NOT EXISTS (SELECT 1 FROM categoryFlags WHERE name = 'cf_respec_tokens')
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(263323, 'cf_respec_tokens', 'RESPEC Tokens', 0, 0)
END

GO

---- RESPEC Token ----

DECLARE @categoryFlags INT

SET @categoryFlags = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_respec_tokens')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_respec_token')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_respec_token', 1, 2052, @categoryflags, '#onceInMonths=n1', '', 1, 0.1, 0.1, 0, 100, 'def_respec_token_desc', 1, 0, 0); 
END

GO

---- Add RESPEC Token into Syndicate shop ----

DECLARE @definition INT
DECLARE @itemshop_preset INT

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_respec_token')
SET @itemshop_preset = (SELECT TOP 1 id FROM itemshoppresets WHERE name = 'tm_preset_pve')

INSERT INTO itemshop (presetid, targetdefinition, targetamount, tmcoin, icscoin, asicoin, credit, unicoin, globallimit, purchasecount, standing) VALUES
(@itemshop_preset, @definition, 1, null, null, null, 20000000, 3000, null, 0, null)

GO

---- Add new field LastRespec into characters table ----

ALTER TABLE dbo.characters ADD LastRespec datetime NULL
	
GO

------------------------------------------------------

PRINT N'01_Spark_Teleport_Devices.sql';

---- Add new category for Spark Teleport Devices ----

IF NOT EXISTS (SELECT 1 FROM categoryFlags WHERE name = 'cf_spark_teleport_devices')
BEGIN
	INSERT INTO categoryFlags (value, name, note, hidden, isunique) VALUES
	(328859, 'cf_spark_teleport_devices', 'Spark Teleport Devices', 0, 0)
END

GO

---- Spark Teleport Devices ----
DECLARE @categoryFlags INT
DECLARE @options VARCHAR(MAX)
DECLARE @baseeid INT

SET @categoryFlags = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_spark_teleport_devices')

SET @baseeid = (SELECT TOP 1 eid FROM entities WHERE ename = 'base_tm_pve_exp1')
SET @options = CONCAT('#baseId=n', @baseeid)

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_spark_teleport_device_hersh')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
	VALUES ( 'def_spark_teleport_device_hersh', 1, 2052, @categoryFlags, @options, '', 1, 2, 50000, 0, 100, 'def_spark_teleport_device_hersh_desc', 1, 0, 0);
END

SET @baseeid = (SELECT TOP 1 eid FROM entities WHERE ename = 'base_TM')
SET @options = CONCAT('#baseId=n', @baseeid)

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_spark_teleport_device_nv')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
	VALUES ( 'def_spark_teleport_device_nv', 1, 2052, @categoryFlags, @options, '', 1, 2, 50000, 0, 100, 'def_spark_teleport_device_nv_desc', 1, 0, 0);
END

GO

---- Add Spark Teleport Devices into Syndicate shop ----

DECLARE @definition INT
DECLARE @itemshop_preset INT

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spark_teleport_device_hersh')
SET @itemshop_preset = (SELECT TOP 1 id FROM itemshoppresets WHERE name = 'tm_preset_pve')

IF NOT EXISTS (SELECT 1 FROM itemshop WHERE targetdefinition = @definition AND presetid = @itemshop_preset)
BEGIN
	INSERT INTO itemshop (presetid, targetdefinition, targetamount, tmcoin, icscoin, asicoin, credit, unicoin, globallimit, purchasecount, standing) VALUES
	(@itemshop_preset, @definition, 1, NULL, NULL, NULL, 5000000, 300, null, 0, null)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spark_teleport_device_nv')

IF NOT EXISTS (SELECT 1 FROM itemshop WHERE targetdefinition = @definition AND presetid = @itemshop_preset)
BEGIN
	INSERT INTO itemshop (presetid, targetdefinition, targetamount, tmcoin, icscoin, asicoin, credit, unicoin, globallimit, purchasecount, standing) VALUES
	(@itemshop_preset, @definition, 1, NULL, NULL, NULL, 5000000, 300, null, 0, null)
END

GO

---- Add Hershfield as spark teleport location ----

DECLARE @basedefinition INT
DECLARE @baseeid INT

SET @basedefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_public_docking_base_pelistal')

SET @baseeid = (SELECT TOP 1 eid FROM entities WHERE ename = 'base_tm_pve_exp1')

IF NOT EXISTS (SELECT 1 FROM charactersparkteleports WHERE characterid = 0 AND baseeid = @baseeid AND basedefinition = @basedefinition)
BEGIN
	INSERT INTO [charactersparkteleports] (characterid, baseeid, basedefinition, zoneid, x, y) VALUES
	(0, @baseeid, @basedefinition, 8, 945.5, 788.5)
END

---- Add New Virginia as spark teleport location ----

SET @baseeid = (SELECT TOP 1 eid FROM entities WHERE ename = 'base_TM')

IF NOT EXISTS (SELECT 1 FROM charactersparkteleports WHERE characterid = 0 AND baseeid = @baseeid AND basedefinition = @basedefinition)
BEGIN
	INSERT INTO [charactersparkteleports] (characterid, baseeid, basedefinition, zoneid, x, y) VALUES
	(0, @baseeid, @basedefinition, 0, 1080.5, 850.5)
END

GO

PRINT N'02_PrototypeLines.sql';

UPDATE extensions SET active = 1 WHERE extensionname in ('ext_production_max_prototyper_slots_advanced', 'ext_production_max_prototyper_slots_expert')

GO

PRINT N'03_T4plusRepairsBuff.sql';

-- T4+ Medium and Small Armor Repair Buff to make them in line with T4P base stats so the T4P are true upgrades.

--Zone 70 T4+ Medium Repair

DECLARE @definitionID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_70_medium_armor_repairer' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_elitet4_70_medium_armor_repairer', quantity=1, attributeflags=81936, categoryflags=33685775, options='#moduleFlag=i20#tier=$tierlevel_t4+', 
                note='elite module', enabled=1, volume=1.5, mass=600, hidden=0, health=100, descriptiontoken='def_elitet4_70_medium_armor_repairer_desc', purchasable=1, tiertype=3, 
                tierlevel=4 where definition=@definitionID;

DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=297 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=52 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=105 WHERE id =  @aggvalueID;

--Zone 70 T4+ Small Repair

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_70_small_armor_repairer' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_elitet4_70_small_armor_repairer', quantity=1, attributeflags=49168, categoryflags=16908559, options='#moduleFlag=i20#tier=$tierlevel_t4+', 
                note='elite module', enabled=1, volume=1, mass=187.5, hidden=0, health=100, descriptiontoken='def_elitet4_70_small_armor_repairer_desc', purchasable=1, tiertype=3, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=63 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=38 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=26 WHERE id =  @aggvalueID;

--Zone 72 T4+ Medium Repair

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_72_medium_armor_repairer' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_elitet4_72_medium_armor_repairer', quantity=1, attributeflags=81936, categoryflags=33685775, options='#moduleFlag=i20#tier=$tierlevel_t4+', 
                note='elite module', enabled=1, volume=1.5, mass=600, hidden=0, health=100, descriptiontoken='def_elitet4_72_medium_armor_repairer_desc', purchasable=1, tiertype=3, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=297 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=52 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=105 WHERE id =  @aggvalueID;

--Zone 72 T4+ Small Repair

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_72_small_armor_repairer' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_elitet4_72_small_armor_repairer', quantity=1, attributeflags=49168, categoryflags=16908559, options='#moduleFlag=i20#tier=$tierlevel_t4+', 
                note='elite module', enabled=1, volume=1, mass=187.5, hidden=0, health=100, descriptiontoken='def_elitet4_72_small_armor_repairer_desc', purchasable=1, tiertype=3, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=63 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=38 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=26 WHERE id =  @aggvalueID;

GO

PRINT N'04_artifact_loot_cts_2023_10_22.sql';

-------------------------------------------------------------------
--Artifact CT Loot rebalance
--Added Light Combat, Light E-War, Light & Assault Indy MK2 CT Capsules to Gamma Artifact Table 
--Small buffs to other MK2 CT Capsules droprate.
--Date modified: 2023/10/21
--Date modified: 2023/10/29
--      Update chance from 0.725 to 0.0725
-------------------------------------------------------------------

DROP TABLE IF EXISTS #INDY_CTS_BY_NAME;
DROP TABLE IF EXISTS #NUIMQOL_CTS_BY_NAME;
DROP TABLE IF EXISTS #PELI_CTS_BY_NAME;
DROP TABLE IF EXISTS #THELO_CTS_BY_NAME;

CREATE TABLE #INDY_CTS_BY_NAME (defName varchar(100), islandType varchar(100), level int, chance float);
CREATE TABLE #NUIMQOL_CTS_BY_NAME (defName varchar(100), islandType varchar(100), level int, chance float);
CREATE TABLE #PELI_CTS_BY_NAME (defName varchar(100), islandType varchar(100), level int, chance float);
CREATE TABLE #THELO_CTS_BY_NAME (defName varchar(100), islandType varchar(100), level int, chance float);

DROP TABLE IF EXISTS #INDY_CTS;
DROP TABLE IF EXISTS #NUIM_CTS;
DROP TABLE IF EXISTS #PELI_CTS;
DROP TABLE IF EXISTS #THELO_CTS;
CREATE TABLE #INDY_CTS (def int, islandType varchar(100), level int, chance float);
CREATE TABLE #NUIM_CTS (def int, islandType varchar(100), level int, chance float);
CREATE TABLE #PELI_CTS (def int, islandType varchar(100), level int, chance float);
CREATE TABLE #THELO_CTS (def int, islandType varchar(100), level int, chance float);

INSERT INTO #INDY_CTS_BY_NAME (defName, islandType, level, chance) VALUES
--LIGHT BOT: Argano
--A T1
('def_argano_mk2_A_CT_capsule', 'alpha', 1, 0.105),
('def_argano_mk2_A_CT_capsule', 'beta', 1, 0.05),
('def_argano_mk2_A_CT_capsule', 'gamma', 1, 0.03), 
--B T2
('def_argano_mk2_B_CT_capsule', 'alpha', 2, 0.105),
('def_argano_mk2_B_CT_capsule', 'beta', 2, 0.05),
('def_argano_mk2_B_CT_capsule', 'gamma', 2, 0.03),
--C T3
('def_argano_mk2_C_CT_capsule', 'alpha', 3, 0.105),
('def_argano_mk2_C_CT_capsule', 'beta', 3, 0.05),
('def_argano_mk2_C_CT_capsule', 'gamma', 3, 0.03),
--LIGHT BOT: Laird
--A T1
('def_laird_mk2_A_CT_capsule', 'alpha', 1, 0.105),
('def_laird_mk2_A_CT_capsule', 'beta', 1, 0.05),
('def_laird_mk2_A_CT_capsule', 'gamma', 1, 0.03),
--B T2
('def_laird_mk2_B_CT_capsule', 'alpha', 2, 0.105),
('def_laird_mk2_B_CT_capsule', 'beta', 2, 0.05),
('def_laird_mk2_B_CT_capsule', 'gamma', 2,0.03),
--C T3
('def_laird_mk2_C_CT_capsule', 'alpha', 3, 0.105),
('def_laird_mk2_C_CT_capsule', 'beta', 3, 0.05),
('def_laird_mk2_C_CT_capsule', 'gamma', 3, 0.03),
--ASSAULT BOT: Sequer
--A T1
('def_sequer_mk2_A_CT_capsule', 'alpha', 1, 0.0725),
('def_sequer_mk2_A_CT_capsule', 'beta', 1, 0.05),
('def_sequer_mk2_A_CT_capsule', 'gamma', 1, 0.0325),
--B T2
('def_sequer_mk2_B_CT_capsule', 'alpha', 2, 0.0725),
('def_sequer_mk2_B_CT_capsule', 'beta', 2, 0.05),
('def_sequer_mk2_B_CT_capsule', 'gamma', 2, 0.0325),
--C T3
('def_sequer_mk2_C_CT_capsule', 'alpha', 3, 0.0725),
('def_sequer_mk2_C_CT_capsule', 'beta', 3, 0.05),
('def_sequer_mk2_C_CT_capsule', 'gamma', 3, 0.0325),

--MECH BOT: Termis
--A T1
('def_termis_mk2_A_CT_capsule', 'alpha', 1, 0.0325),
('def_termis_mk2_A_CT_capsule', 'beta', 1, 0.05),
('def_termis_mk2_A_CT_capsule', 'gamma', 1, 0.0725),
--B T2
('def_termis_mk2_B_CT_capsule', 'alpha', 2, 0.03),
('def_termis_mk2_B_CT_capsule', 'beta', 2, 0.05),
('def_termis_mk2_B_CT_capsule', 'gamma', 2, 0.0725),
--C T3
('def_termis_mk2_C_CT_capsule', 'alpha', 3, 0.03),
('def_termis_mk2_C_CT_capsule', 'beta', 3, 0.05),
('def_termis_mk2_C_CT_capsule', 'gamma', 3, 0.0725),

--MECH BOT: Gargoyle
--A T1
('def_gargoyle_mk2_A_CT_capsule', 'alpha', 1, 0.0325),
('def_gargoyle_mk2_A_CT_capsule', 'beta', 1, 0.05),
('def_gargoyle_mk2_A_CT_capsule', 'gamma', 1, 0.0725),
--B T2
('def_gargoyle_mk2_B_CT_capsule', 'alpha', 2, 0.0325),
('def_gargoyle_mk2_B_CT_capsule', 'beta', 2, 0.05),
('def_gargoyle_mk2_B_CT_capsule', 'gamma', 2, 0.0725),
--C T3
('def_gargoyle_mk2_C_CT_capsule', 'alpha', 3, 0.0325),
('def_gargoyle_mk2_C_CT_capsule', 'beta', 3, 0.05),
('def_gargoyle_mk2_C_CT_capsule', 'gamma', 3, 0.0725),

--HEAVYMECH BOT: Riveler
--A T1
('def_riveler_mk2_A_CT_capsule', 'alpha', 1, 0.0105),
('def_riveler_mk2_A_CT_capsule', 'beta', 1, 0.08),
('def_riveler_mk2_A_CT_capsule', 'gamma', 1, 0.10),
--B T2
('def_riveler_mk2_B_CT_capsule', 'alpha', 2, 0.0105),
('def_riveler_mk2_B_CT_capsule', 'beta', 2, 0.08),
('def_riveler_mk2_B_CT_capsule', 'gamma', 2, 0.10),
--C T3
('def_riveler_mk2_C_CT_capsule', 'alpha', 3, 0.0105),
('def_riveler_mk2_C_CT_capsule', 'beta', 3, 0.08),
('def_riveler_mk2_C_CT_capsule', 'gamma', 3, 0.10),

--HEAVYMECH BOT: Symbiont
--A T1
('def_symbiont_mk2_A_CT_capsule', 'alpha', 1, 0.0105),
('def_symbiont_mk2_A_CT_capsule', 'beta', 1, 0.08),
('def_symbiont_mk2_A_CT_capsule', 'gamma', 1, 0.10),
--B T2
('def_symbiont_mk2_B_CT_capsule', 'alpha', 2, 0.0105),
('def_symbiont_mk2_B_CT_capsule', 'beta', 2, 0.08),
('def_symbiont_mk2_B_CT_capsule', 'gamma', 2, 0.10),
--C T3
('def_symbiont_mk2_C_CT_capsule', 'alpha', 3, 0.0105),
('def_symbiont_mk2_C_CT_capsule', 'beta', 3, 0.08),
('def_symbiont_mk2_C_CT_capsule', 'gamma', 3, 0.10),

--HEAVYMECH BOT: Lithus
--A T1
('def_lithus_mk2_A_CT_capsule', 'alpha', 1, 0.0105),
('def_lithus_mk2_A_CT_capsule', 'beta', 1, 0.08),
('def_lithus_mk2_A_CT_capsule', 'gamma', 1, 0.10),
--B T2
('def_lithus_mk2_B_CT_capsule', 'alpha', 2, 0.0105),
('def_lithus_mk2_B_CT_capsule', 'beta', 2, 0.08),
('def_lithus_mk2_B_CT_capsule', 'gamma', 2, 0.10),
--C T3
('def_lithus_mk2_C_CT_capsule', 'alpha', 3, 0.0125),
('def_lithus_mk2_C_CT_capsule', 'beta', 3, 0.08),
('def_lithus_mk2_C_CT_capsule', 'gamma', 3, 0.10),
--
--HEAVYGLIDER BOT: Scarab
--A T1
('def_scarab_mk2_A_CT_capsule', 'beta', 1, 0.0105),
('def_scarab_mk2_A_CT_capsule', 'gamma', 1, 0.05),
--B T2
('def_scarab_mk2_B_CT_capsule', 'beta', 2, 0.0105),
('def_scarab_mk2_B_CT_capsule', 'gamma', 2, 0.05),
--C T3
('def_scarab_mk2_C_CT_capsule', 'beta', 3, 0.0105),
('def_scarab_mk2_C_CT_capsule', 'gamma', 3, 0.05);
--


INSERT INTO #PELI_CTS_BY_NAME (defName, islandType, level, chance) VALUES
--LIGHT BOT: Castel
--A T1 
('def_castel_mk2_A_CT_capsule', 'alpha', 1, 0.105),
('def_castel_mk2_A_CT_capsule', 'beta', 1, 0.05),
('def_castel_mk2_A_CT_capsule', 'gamma', 1, 0.03),
--B T2
('def_castel_mk2_B_CT_capsule', 'alpha', 2, 0.105),
('def_castel_mk2_B_CT_capsule', 'beta', 2, 0.05),
('def_castel_mk2_B_CT_capsule', 'gamma', 2, 0.03),
--C T3
('def_castel_mk2_C_CT_capsule', 'alpha', 3, 0.105),
('def_castel_mk2_C_CT_capsule', 'beta', 3, 0.05),
('def_castel_mk2_C_CT_capsule', 'gamma', 3, 0.03),
--LIGHT EWAR BOT: Troiar
--A T1
('def_troiar_mk2_A_CT_capsule', 'alpha', 1, 0.0725),
('def_troiar_mk2_A_CT_capsule', 'beta', 1, 0.05),
('def_troiar_mk2_A_CT_capsule', 'gamma', 1, 0.05),
--B T2
('def_troiar_mk2_B_CT_capsule', 'alpha', 2, 0.0725),
('def_troiar_mk2_B_CT_capsule', 'beta', 2, 0.05),
('def_troiar_mk2_B_CT_capsule', 'gamma', 2, 0.05),
--C T3
('def_troiar_mk2_C_CT_capsule', 'alpha', 3, 0.0725),
('def_troiar_mk2_C_CT_capsule', 'beta', 3, 0.05),
('def_troiar_mk2_C_CT_capsule', 'gamma', 3, 0.05),
--ASSAULT BOT: Waspish
--A T1 CT
('def_waspish_mk2_A_CT_capsule', 'alpha', 1, 0.0725),
('def_waspish_mk2_A_CT_capsule', 'beta', 1, 0.05),
('def_waspish_mk2_A_CT_capsule', 'gamma', 1, 0.05),
--B T2
('def_waspish_mk2_B_CT_capsule', 'alpha', 2, 0.0725),
('def_waspish_mk2_B_CT_capsule', 'beta', 2, 0.05),
('def_waspish_mk2_B_CT_capsule', 'gamma', 2, 0.05),
--C T3
('def_waspish_mk2_C_CT_capsule', 'alpha', 3, 0.0725),
('def_waspish_mk2_C_CT_capsule', 'beta', 3, 0.05),
('def_waspish_mk2_C_CT_capsule', 'gamma', 3, 0.05),
--MECH BOT: Tyrannos
--A T1 CT
('def_tyrannos_mk2_A_CT_capsule', 'alpha', 1, 0.0105),
('def_tyrannos_mk2_A_CT_capsule', 'beta', 1, 0.08),
('def_tyrannos_mk2_A_CT_capsule', 'gamma', 1, 0.0725),
--B T2
('def_tyrannos_mk2_B_CT_capsule', 'alpha', 2, 0.0105),
('def_tyrannos_mk2_B_CT_capsule', 'beta', 2, 0.08),
('def_tyrannos_mk2_B_CT_capsule', 'gamma', 2, 0.0725),
--C T3
('def_tyrannos_mk2_C_CT_capsule', 'alpha', 3, 0.0105),
('def_tyrannos_mk2_C_CT_capsule', 'beta', 3, 0.08),
('def_tyrannos_mk2_C_CT_capsule', 'gamma', 3, 0.0725),
--MECH EWAR BOT: Ictus
--A T1
('def_ictus_mk2_A_CT_capsule', 'beta', 1, 0.10),
('def_ictus_mk2_A_CT_capsule', 'gamma', 1, 0.0725),
--B T2
('def_ictus_mk2_B_CT_capsule', 'beta', 2, 0.10),
('def_ictus_mk2_B_CT_capsule', 'gamma', 2, 0.0725),
--C T3
('def_ictus_mk2_C_CT_capsule', 'beta', 3, 0.10),
('def_ictus_mk2_C_CT_capsule', 'gamma', 3, 0.0725),
--HEAVYMECH BOT: Gropho
--A T1
('def_gropho_mk2_A_CT_capsule', 'beta', 1, 0.08),
('def_gropho_mk2_A_CT_capsule', 'gamma', 1, 0.10),
--B T2
('def_gropho_mk2_B_CT_capsule', 'beta', 2, 0.08),
('def_gropho_mk2_B_CT_capsule', 'gamma', 2, 0.10),
--C T3
('def_gropho_mk2_C_CT_capsule', 'beta', 3, 0.08),
('def_gropho_mk2_C_CT_capsule', 'gamma', 3, 0.10);
--

INSERT INTO #NUIMQOL_CTS_BY_NAME (defName, islandType, level, chance) VALUES
--LIGHT BOT: Yagel
--A T1
('def_yagel_mk2_A_CT_capsule', 'alpha', 1, 0.105),
('def_yagel_mk2_A_CT_capsule', 'beta', 1, 0.05),
('def_yagel_mk2_A_CT_capsule', 'gamma', 1, 0.03),
--B T2
('def_yagel_mk2_B_CT_capsule', 'alpha', 2, 0.105),
('def_yagel_mk2_B_CT_capsule', 'beta', 2, 0.05),
('def_yagel_mk2_B_CT_capsule', 'gamma', 2, 0.03),
--C T3
('def_yagel_mk2_C_CT_capsule', 'alpha', 3, 0.105),
('def_yagel_mk2_C_CT_capsule', 'beta', 3, 0.05),
('def_yagel_mk2_C_CT_capsule', 'gamma', 3, 0.03),
--LIGHT EWAR BOT: Cameleon
--A T1
('def_cameleon_mk2_A_CT_capsule', 'alpha', 1, 0.0725),
('def_cameleon_mk2_A_CT_capsule', 'beta', 1, 0.05),
('def_cameleon_mk2_A_CT_capsule', 'gamma', 1, 0.05),
--B T2
('def_cameleon_mk2_B_CT_capsule', 'alpha', 2, 0.0725),
('def_cameleon_mk2_B_CT_capsule', 'beta', 2, 0.05),
('def_cameleon_mk2_B_CT_capsule', 'gamma', 2, 0.05),
--C T3
('def_cameleon_mk2_C_CT_capsule', 'alpha', 3, 0.0725),
('def_cameleon_mk2_C_CT_capsule', 'beta', 3, 0.05),
('def_cameleon_mk2_C_CT_capsule', 'gamma', 3, 0.05),
--ASSAULT BOT: Arbalest
--A T1
('def_arbalest_mk2_A_CT_capsule', 'alpha', 1, 0.0725),
('def_arbalest_mk2_A_CT_capsule', 'beta', 1, 0.05),
('def_arbalest_mk2_A_CT_capsule', 'gamma', 1, 0.05),
--B T2
('def_arbalest_mk2_B_CT_capsule', 'alpha', 2, 0.0725),
('def_arbalest_mk2_B_CT_capsule', 'beta', 2, 0.05),
('def_arbalest_mk2_B_CT_capsule', 'gamma', 2, 0.05),
--C T3
('def_arbalest_mk2_C_CT_capsule', 'alpha', 3, 0.0725),
('def_arbalest_mk2_C_CT_capsule', 'beta', 3, 0.05),
('def_arbalest_mk2_C_CT_capsule', 'gamma', 3, 0.05),
--MECH BOT: Kain
--A T1
('def_kain_mk2_A_CT_capsule', 'alpha', 1, 0.0105),
('def_kain_mk2_A_CT_capsule', 'beta', 1, 0.08),
('def_kain_mk2_A_CT_capsule', 'gamma', 1, 0.0725),
--B T2
('def_kain_mk2_B_CT_capsule', 'alpha', 2, 0.0105),
('def_kain_mk2_B_CT_capsule', 'beta', 2, 0.08),
('def_kain_mk2_B_CT_capsule', 'gamma', 2, 0.0725),
--C T3
('def_kain_mk2_C_CT_capsule', 'alpha', 3, 0.0105),
('def_kain_mk2_C_CT_capsule', 'beta', 3, 0.08),
('def_kain_mk2_C_CT_capsule', 'gamma', 3, 0.0725),
--MECH EWAR : Vagabond
--A T1 CT
('def_vagabond_mk2_A_CT_capsule', 'beta', 1, 0.10),
('def_vagabond_mk2_A_CT_capsule', 'gamma', 1, 0.0725),
--B T2
('def_vagabond_mk2_B_CT_capsule', 'beta', 2, 0.10),
('def_vagabond_mk2_B_CT_capsule', 'gamma', 2, 0.0725),
--C T3
('def_vagabond_mk2_C_CT_capsule', 'beta', 3, 0.10),
('def_vagabond_mk2_C_CT_capsule', 'gamma', 3, 0.0725),
--HEAVYMECH BOT: Mesmer
--A T1 CT
('def_mesmer_mk2_A_CT_capsule', 'beta', 1, 0.08),
('def_mesmer_mk2_A_CT_capsule', 'gamma', 1, 0.10),
--B T2
('def_mesmer_mk2_B_CT_capsule', 'beta', 2, 0.08),
('def_mesmer_mk2_B_CT_capsule', 'gamma', 2, 0.10),
--C T3
('def_mesmer_mk2_C_CT_capsule', 'beta', 3, 0.08),
('def_mesmer_mk2_C_CT_capsule', 'gamma', 3, 0.10);
--

INSERT INTO #THELO_CTS_BY_NAME (defName, islandType, level, chance) VALUES
--LIGHT BOT: Prometheus
--A T1
('def_prometheus_mk2_A_CT_capsule', 'alpha', 1, 0.105),
('def_prometheus_mk2_A_CT_capsule', 'beta', 1, 0.05),
('def_prometheus_mk2_A_CT_capsule', 'gamma', 1, 0.03),
--B T2
('def_prometheus_mk2_B_CT_capsule', 'alpha', 2, 0.105),
('def_prometheus_mk2_B_CT_capsule', 'beta', 2, 0.05),
('def_prometheus_mk2_B_CT_capsule', 'gamma', 2, 0.03),
--C T3
('def_prometheus_mk2_C_CT_capsule', 'alpha', 3, 0.105),
('def_prometheus_mk2_C_CT_capsule', 'beta', 3, 0.05),
('def_prometheus_mk2_C_CT_capsule', 'gamma', 3, 0.03),
--LIGHT EWAR BOT: Intakt
--A T1
('def_intakt_mk2_A_CT_capsule', 'alpha', 1, 0.0725),
('def_intakt_mk2_A_CT_capsule', 'beta', 1, 0.05),
('def_intakt_mk2_A_CT_capsule', 'gamma', 1, 0.05),
--B T2
('def_intakt_mk2_B_CT_capsule', 'alpha', 2, 0.0725),
('def_intakt_mk2_B_CT_capsule', 'beta', 2, 0.05),
('def_intakt_mk2_B_CT_capsule', 'gamma', 2, 0.05),
--C T3
('def_intakt_mk2_C_CT_capsule', 'alpha', 3, 0.0725),
('def_intakt_mk2_C_CT_capsule', 'beta', 3, 0.05),
('def_intakt_mk2_C_CT_capsule', 'gamma', 3, 0.05),
--ASSAULT BOT: Baphomet
--A T1
('def_baphomet_mk2_A_CT_capsule', 'alpha', 1, 0.0725),
('def_baphomet_mk2_A_CT_capsule', 'beta', 1, 0.05),
('def_baphomet_mk2_A_CT_capsule', 'gamma', 1, 0.05),
--B T2
('def_baphomet_mk2_B_CT_capsule', 'alpha', 2, 0.0725),
('def_baphomet_mk2_B_CT_capsule', 'beta', 2, 0.05),
('def_baphomet_mk2_B_CT_capsule', 'gamma', 2, 0.05),
--C T3
('def_baphomet_mk2_C_CT_capsule', 'alpha', 3, 0.0725),
('def_baphomet_mk2_C_CT_capsule', 'beta', 3, 0.05),
('def_baphomet_mk2_C_CT_capsule', 'gamma', 3, 0.05),
--MECH BOT: Artemis
--A T1 CT
('def_artemis_mk2_A_CT_capsule', 'alpha', 1, 0.0105),
('def_artemis_mk2_A_CT_capsule', 'beta', 1, 0.08),
('def_artemis_mk2_A_CT_capsule', 'gamma', 1, 0.0725),
--B T2
('def_artemis_mk2_B_CT_capsule', 'alpha', 2, 0.0105),
('def_artemis_mk2_B_CT_capsule', 'beta', 2, 0.08),
('def_artemis_mk2_B_CT_capsule', 'gamma', 2, 0.0725),
--C T3
('def_artemis_mk2_C_CT_capsule', 'alpha', 3, 0.0105),
('def_artemis_mk2_C_CT_capsule', 'beta', 3, 0.08),
('def_artemis_mk2_C_CT_capsule', 'gamma', 3, 0.0725),
--MECH EWAR BOT: Zenith
--A T1
('def_zenith_mk2_A_CT_capsule', 'beta', 1, 0.10),
('def_zenith_mk2_A_CT_capsule', 'gamma', 1, 0.0725),
--B T2
('def_zenith_mk2_B_CT_capsule', 'beta', 2, 0.10),
('def_zenith_mk2_B_CT_capsule', 'gamma', 2, 0.0725),
--C T3
('def_zenith_mk2_C_CT_capsule', 'beta', 3, 0.10),
('def_zenith_mk2_C_CT_capsule', 'gamma', 3, 0.0725),
--HEAVYMECH BOT: Seth
--A T1 CT
('def_seth_mk2_A_CT_capsule', 'beta', 1, 0.08),
('def_seth_mk2_A_CT_capsule', 'gamma', 1, 0.10),
--B T2
('def_seth_mk2_B_CT_capsule', 'beta', 2, 0.08),
('def_seth_mk2_B_CT_capsule', 'gamma', 2, 0.10),
--C T3
('def_seth_mk2_C_CT_capsule', 'beta', 3, 0.08),
('def_seth_mk2_C_CT_capsule', 'gamma', 3, 0.10);
--

SELECT * FROM #INDY_CTS_BY_NAME;
SELECT * FROM #NUIMQOL_CTS_BY_NAME;
SELECT * FROM #PELI_CTS_BY_NAME;
SELECT * FROM #THELO_CTS_BY_NAME;

PRINT N'INSERT TABLES WITH DEFINITION ID LOOKUP';
INSERT INTO #INDY_CTS (def, islandType, level, chance)
SELECT (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=#INDY_CTS_BY_NAME.defName) as def, islandType, level, chance FROM #INDY_CTS_BY_NAME;

INSERT INTO #NUIM_CTS (def, islandType, level, chance)
SELECT (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=#NUIMQOL_CTS_BY_NAME.defName) as def, islandType, level, chance FROM #NUIMQOL_CTS_BY_NAME;

INSERT INTO #PELI_CTS (def, islandType, level, chance)
SELECT (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=#PELI_CTS_BY_NAME.defName) as def, islandType, level, chance FROM #PELI_CTS_BY_NAME;

INSERT INTO #THELO_CTS (def, islandType, level, chance)
SELECT (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=#THELO_CTS_BY_NAME.defName) as def, islandType, level, chance FROM #THELO_CTS_BY_NAME;


DECLARE @cf_modules bigint;
SET @cf_modules = (SELECT value FROM categoryFlags WHERE name='cf_lottery_items');

--Old Loot
PRINT N'SELECTING ALL CT CAPSULE LOOT'
SELECT * FROM artifactloot JOIN artifacttypes ON artifacttype=artifacttypes.id 
WHERE definition IN (
SELECT definition FROM entitydefaults WHERE definitionname LIKE '%_CT_capsule' AND note='MK2 CT Capsule!' AND
categoryflags & CAST(dbo.GetCFMask(@cf_modules) as BIGINT) = @cf_modules
);

--DELETE ALL CT-CAPSULES FROM ARTIFACT LOOT (AND RE-INSERT)
PRINT N'DELETING ALL CT CAPSULE LOOT'
DELETE FROM artifactloot WHERE definition IN (
SELECT definition FROM entitydefaults WHERE definitionname LIKE '%_CT_capsule' AND note='MK2 CT Capsule!' AND
categoryflags & CAST(dbo.GetCFMask(@cf_modules) as BIGINT) = @cf_modules
);


--INSERT PELISTAL CTS TO PELISTAL SCIENCE ARTIFACTS
PRINT N'PELISTAL SCIENTIFIC ARTIFACTS';
PRINT N'science_pelistal_level1_alpha';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_pelistal_level1_alpha'), def, 1, 1, chance, 1 
	FROM #PELI_CTS WHERE level=1 AND islandType='alpha';

PRINT N'science_pelistal_level2_alpha';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_pelistal_level2_alpha'), def, 1, 1, chance, 1 
	FROM #PELI_CTS WHERE level=2 AND islandType='alpha';

PRINT N'science_pelistal_level3_alpha';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_pelistal_level3_alpha'), def, 1, 1, chance, 1 
	FROM #PELI_CTS WHERE level=3 AND islandType='alpha';

PRINT N'science_pelistal_level1_beta';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_pelistal_level1_beta'), def, 1, 1, chance, 1 
	FROM #PELI_CTS WHERE level=1 AND islandType='beta';

PRINT N'science_pelistal_level2_beta';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_pelistal_level2_beta'), def, 1, 1, chance, 1 
	FROM #PELI_CTS WHERE level=2 AND islandType='beta';

PRINT N'science_pelistal_level3_beta';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_pelistal_level3_beta'), def, 1, 1, chance, 1 
	FROM #PELI_CTS WHERE level=3 AND islandType='beta';

PRINT N'science_pelistal_level1_gamma';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_pelistal_level1_gamma'), def, 1, 1, chance, 1 
	FROM #PELI_CTS WHERE level=1 AND islandType='gamma';

PRINT N'science_pelistal_level2_gamma';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_pelistal_level2_gamma'), def, 1, 1, chance, 1 
	FROM #PELI_CTS WHERE level=2 AND islandType='gamma';

PRINT N'science_pelistal_level3_gamma';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_pelistal_level3_gamma'), def, 1, 1, chance, 1 
	FROM #PELI_CTS WHERE level=3 AND islandType='gamma';


--INSERT NUIMQOL CTS TO NUIMQOL SCIENCE ARTIFACTS
PRINT N'NUIMQOL SCIENTIFIC ARTIFACTS';
PRINT N'science_nuimqol_level1_alpha';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_nuimqol_level1_alpha'), def, 1, 1, chance, 1 
	FROM #NUIM_CTS WHERE level=1 AND islandType='alpha';

PRINT N'science_nuimqol_level2_alpha';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_nuimqol_level2_alpha'), def, 1, 1, chance, 1 
	FROM #NUIM_CTS WHERE level=2 AND islandType='alpha';

PRINT N'science_nuimqol_level3_alpha';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_nuimqol_level3_alpha'), def, 1, 1, chance, 1 
	FROM #NUIM_CTS WHERE level=3 AND islandType='alpha';

PRINT N'science_nuimqol_level1_beta';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_nuimqol_level1_beta'), def, 1, 1, chance, 1 
	FROM #NUIM_CTS WHERE level=1 AND islandType='beta';

PRINT N'science_nuimqol_level2_beta';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_nuimqol_level2_beta'), def, 1, 1, chance, 1 
	FROM #NUIM_CTS WHERE level=2 AND islandType='beta';

PRINT N'science_nuimqol_level3_beta';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_nuimqol_level3_beta'), def, 1, 1, chance, 1 
	FROM #NUIM_CTS WHERE level=3 AND islandType='beta';

PRINT N'science_nuimqol_level1_gamma';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_nuimqol_level1_gamma'), def, 1, 1, chance, 1 
	FROM #NUIM_CTS WHERE level=1 AND islandType='gamma';

PRINT N'science_nuimqol_level2_gamma';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_nuimqol_level2_gamma'), def, 1, 1, chance, 1 
	FROM #NUIM_CTS WHERE level=2 AND islandType='gamma';

PRINT N'science_nuimqol_level3_gamma';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_nuimqol_level3_gamma'), def, 1, 1, chance, 1 
	FROM #NUIM_CTS WHERE level=3 AND islandType='gamma';


--INSERT THELODICA CTS TO THELODICA SCIENCE ARTIFACTS
PRINT N'THELODICA SCIENTIFIC ARTIFACTS';
PRINT N'science_thelodica_level1_alpha';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_thelodica_level1_alpha'), def, 1, 1, chance, 1 
	FROM #THELO_CTS WHERE level=1 AND islandType='alpha';

PRINT N'science_thelodica_level2_alpha';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_thelodica_level2_alpha'), def, 1, 1, chance, 1 
	FROM #THELO_CTS WHERE level=2 AND islandType='alpha';

PRINT N'science_thelodica_level3_alpha';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_thelodica_level3_alpha'), def, 1, 1, chance, 1 
	FROM #THELO_CTS WHERE level=3 AND islandType='alpha';

PRINT N'science_thelodica_level1_beta';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_thelodica_level1_beta'), def, 1, 1, chance, 1 
	FROM #THELO_CTS WHERE level=1 AND islandType='beta';

PRINT N'science_thelodica_level2_beta';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_thelodica_level2_beta'), def, 1, 1, chance, 1 
	FROM #THELO_CTS WHERE level=2 AND islandType='beta';

PRINT N'science_thelodica_level3_beta';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_thelodica_level3_beta'), def, 1, 1, chance, 1 
	FROM #THELO_CTS WHERE level=3 AND islandType='beta';

PRINT N'science_thelodica_level1_gamma';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_thelodica_level1_gamma'), def, 1, 1, chance, 1 
	FROM #THELO_CTS WHERE level=1 AND islandType='gamma';

PRINT N'science_thelodica_level2_gamma';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_thelodica_level2_gamma'), def, 1, 1, chance, 1 
	FROM #THELO_CTS WHERE level=2 AND islandType='gamma';

PRINT N'science_thelodica_level3_gamma';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_thelodica_level3_gamma'), def, 1, 1, chance, 1 
	FROM #THELO_CTS WHERE level=3 AND islandType='gamma';


--INSERT INDUSTRIAL CTS TO NUIMQOL INDUSTRIAL ARTIFACTS
PRINT N'NUIMQOL INDUSTRIAL ARTIFACTS';
PRINT N'industrial_nuimqol_level1_alpha';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_nuimqol_level1_alpha'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=1 AND islandType='alpha';

PRINT N'industrial_nuimqol_level2_alpha';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_nuimqol_level2_alpha'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=2 AND islandType='alpha';

PRINT N'industrial_nuimqol_level3_alpha';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_nuimqol_level3_alpha'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=3 AND islandType='alpha';

PRINT N'industrial_nuimqol_level1_beta';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_nuimqol_level1_beta'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=1 AND islandType='beta';

PRINT N'industrial_nuimqol_level2_beta';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_nuimqol_level2_beta'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=2 AND islandType='beta';

PRINT N'industrial_nuimqol_level3_beta';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_nuimqol_level3_beta'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=3 AND islandType='beta';

PRINT N'industrial_nuimqol_level1_gamma';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_nuimqol_level1_gamma'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=1 AND islandType='gamma';

PRINT N'industrial_nuimqol_level2_gamma';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_nuimqol_level2_gamma'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=2 AND islandType='gamma';

PRINT N'industrial_nuimqol_level3_gamma';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_nuimqol_level3_gamma'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=3 AND islandType='gamma';


--INSERT INDUSTRIAL CTS TO PELISTAL INDUSTRIAL ARTIFACTS
PRINT N'PELISTAL INDUSTRIAL ARTIFACTS';
PRINT N'industrial_pelistal_level1_alpha';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_pelistal_level1_alpha'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=1 AND islandType='alpha';

PRINT N'industrial_pelistal_level2_alpha';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_pelistal_level2_alpha'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=2 AND islandType='alpha';

PRINT N'industrial_pelistal_level3_alpha';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_pelistal_level3_alpha'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=3 AND islandType='alpha';

PRINT N'industrial_pelistal_level1_beta';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_pelistal_level1_beta'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=1 AND islandType='beta';

PRINT N'industrial_pelistal_level2_beta';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_pelistal_level2_beta'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=2 AND islandType='beta';

PRINT N'industrial_pelistal_level3_beta';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_pelistal_level3_beta'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=3 AND islandType='beta';

PRINT N'industrial_pelistal_level1_gamma';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_pelistal_level1_gamma'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=1 AND islandType='gamma';

PRINT N'industrial_pelistal_level2_gamma';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_pelistal_level2_gamma'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=2 AND islandType='gamma';

PRINT N'industrial_pelistal_level3_gamma';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_pelistal_level3_gamma'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=3 AND islandType='gamma';


--INSERT INDUSTRIAL CTS TO THELODICA INDUSTRIAL ARTIFACTS
PRINT N'THELODICA INDUSTRIAL ARTIFACTS';
PRINT N'industrial_thelodica_level1_alpha';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_thelodica_level1_alpha'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=1 AND islandType='alpha';

PRINT N'industrial_thelodica_level2_alpha';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_thelodica_level2_alpha'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=2 AND islandType='alpha';

PRINT N'industrial_thelodica_level3_alpha';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_thelodica_level3_alpha'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=3 AND islandType='alpha';

PRINT N'industrial_thelodica_level1_beta';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_thelodica_level1_beta'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=1 AND islandType='beta';

PRINT N'industrial_thelodica_level2_beta';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_thelodica_level2_beta'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=2 AND islandType='beta';

PRINT N'industrial_thelodica_level3_beta';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_thelodica_level3_beta'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=3 AND islandType='beta';

PRINT N'industrial_thelodica_level1_gamma';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_thelodica_level1_gamma'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=1 AND islandType='gamma';

PRINT N'industrial_thelodica_level2_gamma';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_thelodica_level2_gamma'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=2 AND islandType='gamma';

PRINT N'industrial_thelodica_level3_gamma';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_thelodica_level3_gamma'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=3 AND islandType='gamma';

GO

PRINT N'20_removing_duplicate_plant_rules__2023_10_10.sql';

---------------------------------------
-- Removing duplicate rules for plants
-- 
-- Date modified: 2023/10/10
--      Intial commit
-- Date modified: 2023/10/13
--      Fix non-ASCII characters
-- Date modified: 2023/10/29
--      Added title
---------------------------------------

-- Table for suspicious rules.
DECLARE @table_for_check TABLE
(
    idx       INT          NOT NULL,
    plantrule VARCHAR(256) NOT NULL,
    rulesetid INT          NOT NULL
);

-- Select all the rules according to the template.
INSERT INTO @table_for_check (idx, plantrule, rulesetid)
    SELECT idx, plantrule, rulesetid FROM [dbo].[plantrules]
        WHERE [plantrule] LIKE '%_seeded_%';

-- Table with rows to delete.
DECLARE @table_for_removing TABLE
(
    idx       INT          NOT NULL,
    plantrule VARCHAR(256) NOT NULL,
    rulesetid INT          NOT NULL
);

-- Variables with information about the rule.
DECLARE
    @idx       INT,
    @plantrule VARCHAR(256),
    @rulesetid INT,
    @plantname VARCHAR(256), -- Name of the plant.
    @dup       INT;          -- Number of duplicates.

-- Go through all the filtered rules.
DECLARE plantrule_cursor CURSOR FOR
    SELECT [idx], [plantrule], [rulesetid] FROM @table_for_check;

OPEN plantrule_cursor  
FETCH NEXT FROM plantrule_cursor INTO @idx, @plantrule, @rulesetid;

WHILE @@FETCH_STATUS = 0  
BEGIN
    -- Extract the name of the plant from the name of the rule.
    SET @plantname = LEFT(@plantrule, PATINDEX('%_seeded_%', @plantrule) - 1);
    -- Count the number of duplicates.
    SET @dup = (SELECT COUNT(*) FROM [dbo].[plantrules]
        WHERE [plantrule] LIKE @plantname + '%' AND NOT [plantrule] = @plantrule AND [rulesetid] = @rulesetid);
    
    IF 0 = @dup
        BEGIN
            -- Everything is fine - the only rule on the island.
            PRINT  'ID:' + CONVERT(varchar(3), @rulesetid) +
            ' PLANT:' + @plantname +
            ' RULE:' + @plantrule +
            ' -- OK';
        END
    ELSE
        BEGIN
            -- There are duplicates with rules for wild plants.
            PRINT  'ID:' + CONVERT(varchar(3), @rulesetid) +
            ' PLANT:' + @plantname +
            ' RULE:' + @plantrule +
            ' -- DUP_COUNT: '  + CONVERT(varchar(3), @dup) + ' -- ADD FOR REMOVE';

            -- Add a rule for seed plants to the table for deletion.
            INSERT INTO @table_for_removing  ([idx], [plantrule], [rulesetid])
                VALUES (@idx, @plantrule, @rulesetid);
        END

    -- Next rule.
    FETCH NEXT FROM plantrule_cursor INTO @idx, @plantrule, @rulesetid;
END

CLOSE plantrule_cursor;
DEALLOCATE plantrule_cursor;

-- Visual control of all rules for deletion.
SELECT * FROM @table_for_removing;
-- If they are all for T1 islands (control by name), then we remove them from the database.
IF 0 = (SELECT COUNT(*) FROM @table_for_removing WHERE NOT [plantrule] LIKE '%_t1.txt')
BEGIN
    DELETE FROM [dbo].[plantrules] WHERE [idx] IN (SELECT [idx] FROM @table_for_removing);
END

GO

PRINT N'PATCH 30 COMPLETE';
GO
