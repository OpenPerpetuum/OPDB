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

GO

PRINT N'PATCH 30 COMPLETE';
GO
