---- Add new category for Spark Teleport Devices ----

INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
(328859, 'cf_spark_teleport_devices', 'Spark Teleport Devices', 0, 0)

GO

---- Spark Teleport Devices ----

INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
VALUES ( 'def_spark_teleport_device_hersh', 1, 2052, 328859, '', '', 1, 2, 50000, 0, 100, 'def_spark_teleport_device_hersh_desc', 1, 0, 0);

GO

---- Add Spark Teleport Devices into Syndicate shop ----

DECLARE @definition INT
DECLARE @itemshop_preset INT

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spark_teleport_device_hersh')
SET @itemshop_preset = (SELECT TOP 1 definition FROM itemshoppresets WHERE name = 'tm_preset_pve')

INSERT INTO itemshop (presetid, targetdefinition, targetamount, tmcoin, icscoin, asicoin, credit, unicoin, globallimit, purchasecount, standing) VALUES
(@itemshop_preset, @definition, 1, NULL, NULL, NULL, 5000000, 300, null, 0, null)

GO

---- Add Hershfield as spark teleport location ----

INSERT INTO [charactersparkteleports] (characterid, baseeid, basedefinition, zoneid, x, y) VALUES
(0, 142, 1392, 8, 945.5, 788.5)

GO