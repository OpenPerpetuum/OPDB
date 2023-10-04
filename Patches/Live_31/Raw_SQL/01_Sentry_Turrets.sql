---- Create category flags

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_sentry_turrets' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(3474, 'cf_sentry_turrets', 'Sentry Turret (deployed)', 1, 0)
END

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_turret_launcher_ammo' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(8202, 'cf_turret_launcher_ammo', 'Field turres', 0, 0)
END

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_sentry_turret_ammo' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(1056778, 'cf_sentry_turret_ammo', 'Sentry turrets', 0, 0)
END

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_em_sentry_turret_ammo' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(269492234, 'cf_em_sentry_turret_ammo', 'EM sentry turrets', 0, 0)
END

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_laser_sentry_turret_ammo' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(537927690, 'cf_laser_sentry_turret_ammo', 'Laser sentry turrets', 0, 0)
END

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_missile_sentry_turret_ammo' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(806363146, 'cf_missile_sentry_turret_ammo', 'Missile sentry turrets', 0, 0)
END

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_firearm_sentry_turret_ammo' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(1074798602, 'cf_firearm_sentry_turret_ammo', 'Firearms sentry turrets', 0, 0)
END

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_turret_launchers' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(722703, 'cf_turret_launchers', 'Turret launchers', 0, 1)
END

GO

---- Add new slot flag
IF NOT EXISTS (SELECT 1 FROM slotFlags WHERE name = 'specialized' )
BEGIN
	INSERT INTO slotFlags (offset, name, note) VALUES (11, 'specialized', 'Special tools for Mk3 only')
END

GO

---- Create entity defaults for turret launchers

DECLARE @categoryFlag INT

SET @categoryFlag = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_turret_launchers')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_turret_launcher')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_turret_launcher', 1, 2359516, @categoryFlag, '#moduleFlag=i800  #ammoCapacity=i3  #ammoType=L200a  #powergrid_usage=f0.00  #cpu_usage=f0.00  #tier=$tierlevel_t1', 1, 1, 1, 0, 100, 'def_standart_turret_launcher_desc', 1, 1, 1)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named1_turret_launcher')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named1_turret_launcher', 1, 2359516, @categoryFlag, '#moduleFlag=i800  #ammoCapacity=i3  #ammoType=L200a  #powergrid_usage=f0.00  #cpu_usage=f0.00  #tier=$tierlevel_t2', 1, 1, 1, 0, 100, 'def_standart_turret_launcher_desc', 1, 1, 2)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named2_turret_launcher')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named2_turret_launcher', 1, 2359516, @categoryFlag, '#moduleFlag=i800  #ammoCapacity=i4  #ammoType=L200a  #powergrid_usage=f0.00  #cpu_usage=f0.00  #tier=$tierlevel_t3', 1, 1, 1, 0, 100, 'def_standart_turret_launcher_desc', 1, 1, 3)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named3_turret_launcher')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named3_turret_launcher', 1, 2359516, @categoryFlag, '#moduleFlag=i800  #ammoCapacity=i5  #ammoType=L200a  #powergrid_usage=f0.00  #cpu_usage=f0.00  #tier=$tierlevel_t4', 1, 1, 1, 0, 100, 'def_standart_turret_launcher_desc', 1, 1, 4)
END

GO

---- Create entity defaults for deployed turrets

-- EM

DECLARE @categoryFlag INT

SET @categoryFlag = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_sentry_turrets')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_em_sentry_turret')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_em_sentry_turret', 1, 1024, @categoryFlag, '', 1, 1, 1, 0, 100, 'def_standart_em_sentry_turret_desc', 0, 1, 1)
END

-- Laser

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_laser_sentry_turret')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_laser_sentry_turret', 1, 1024, @categoryFlag, '', 1, 1, 1, 0, 100, 'def_standart_laser_sentry_turret_desc', 0, 1, 1)
END

-- Missile

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_missile_sentry_turret')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_missile_sentry_turret', 1, 1024, @categoryFlag, '', 1, 1, 1, 0, 100, 'def_standart_missile_sentry_turret_desc', 0, 1, 1)
END

-- Firearm

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_firearm_sentry_turret')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_firearm_sentry_turret', 1, 1024, @categoryFlag, '', 1, 1, 1, 0, 100, 'def_standart_firearm_sentry_turret_desc', 0, 1, 1)
END

GO

---- Create turrets as ammo

DECLARE @categoryFlag INT
DECLARE @options VARCHAR(MAX)

SET @categoryFlag = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_em_sentry_turret_ammo')

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_standart_em_sentry_turret'))

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_em_sentry_turret_ammo')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_em_sentry_turret_ammo', 1, 2048, @categoryFlag, @options, 1, 1, 1, 0, 100, 'def_standart_em_sentry_turret_ammo_desc', 1, 1, 1)
END

--
SET @categoryFlag = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_laser_sentry_turret_ammo')

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_standart_laser_sentry_turret'))

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_laser_sentry_turret_ammo')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_laser_sentry_turret_ammo', 1, 2048, @categoryFlag, @options, 1, 1, 1, 0, 100, 'def_standart_laser_sentry_turret_ammo_desc', 1, 1, 1)
END

--

SET @categoryFlag = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_missile_sentry_turret_ammo')

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_standart_missile_sentry_turret'))

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_missile_sentry_turret_ammo')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_missile_sentry_turret_ammo', 1, 2048, @categoryFlag, @options, 1, 1, 1, 0, 100, 'def_standart_missile_sentry_turret_ammo_desc', 1, 1, 1)
END

--

SET @categoryFlag = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_firearm_sentry_turret_ammo')

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_standart_firearm_sentry_turret'))

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_firearm_sentry_turret_ammo')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_firearm_sentry_turret_ammo', 1, 2048, @categoryFlag, @options, 1, 1, 1, 0, 100, 'def_standart_firearm_sentry_turret_ammo_desc', 1, 1, 1)
END

GO

---- Create turret templates

-- EM

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'standart_em_sentry_turret')
BEGIN
	INSERT INTO robottemplates (name, description, note) VALUES
	('standart_em_sentry_turret', '#robot=i1350#head=i1302#chassis=i1303#leg=ia01#container=i14d#chassisModules=[|m0=[|definition=i43|slot=i1|ammoDefinition=ifc|ammoQuantity=i32]|m1=[|definition=i43|slot=i2|ammoDefinition=ifc|ammoQuantity=i32]]', 'EM Sentry turret template')
END

-- Laser

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'standart_laser_sentry_turret')
BEGIN
	INSERT INTO robottemplates (name, description, note) VALUES
	('standart_laser_sentry_turret', '#robot=i1350#head=i1302#chassis=i1303#leg=ia01#container=i14d#chassisModules=[|m0=[|definition=i3a|slot=i1|ammoDefinition=i113|ammoQuantity=i4e]|m1=[|definition=i3a|slot=i2|ammoDefinition=i113|ammoQuantity=i4e]]', 'Laser Sentry turret template')
END

-- Missile

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'standart_missile_sentry_turret')
BEGIN
	INSERT INTO robottemplates (name, description, note) VALUES
	('standart_missile_sentry_turret', '#robot=i1350#head=i1302#chassis=i1303#leg=ia01#container=i14d#chassisModules=[|m0=[|definition=i41|slot=i1|ammoDefinition=i124|ammoQuantity=i14]|m1=[|definition=i41|slot=i2|ammoDefinition=i124|ammoQuantity=i14]]', 'Missile Sentry turret template')
END

-- Firearm

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'standart_firearm_sentry_turret')
BEGIN
	INSERT INTO robottemplates (name, description, note) VALUES
	('standart_firearm_sentry_turret', '#robot=i1350#head=i1302#chassis=i1303#leg=ia01#container=i14d#chassisModules=[|m0=[|definition=i3d|slot=i1|ammoDefinition=i986|ammoQuantity=i96]|m1=[|definition=i3d|slot=i2|ammoDefinition=i986|ammoQuantity=i96]]', 'Firearm Sentry turret template')
END

GO

---- Link turrets with their templates

DECLARE @turret_def INT
DECLARE @turret_template INT

---- EM

SET @turret_def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_em_sentry_turret')
SET @turret_template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'standart_em_sentry_turret')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @turret_def AND @turret_template = @turret_template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@turret_def, @turret_template, 0, 0, 'EM Sentry turret')
END

---- Laser

SET @turret_def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_laser_sentry_turret')
SET @turret_template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'standart_laser_sentry_turret')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @turret_def AND @turret_template = @turret_template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@turret_def, @turret_template, 0, 0, 'Laser Sentry turret')
END

---- Missile

SET @turret_def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_missile_sentry_turret')
SET @turret_template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'standart_missile_sentry_turret')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @turret_def AND @turret_template = @turret_template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@turret_def, @turret_template, 0, 0, 'Missile Sentry turret')
END

---- Firearm

SET @turret_def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_firearm_sentry_turret')
SET @turret_template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'standart_firearm_sentry_turret')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @turret_def AND @turret_template = @turret_template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@turret_def, @turret_template, 0, 0, 'Firearm Sentry turret')
END

GO

---- Add new aggregate fields

IF NOT EXISTS (SELECT 1 FROM aggregatefields WHERE name = 'bandwidth_max')
BEGIN
	INSERT INTO aggregatefields (name, formula, measurementunit, measurementmultiplier, measurementoffset, category, digits, moreisbetter, usedinconfig, note) VALUES
	('bandwidth_max', 1,'bandwidth_max_unit', 1, 0, 3, 0, 1, 1, 'Controlled entities limit')
END
/*
IF NOT EXISTS (SELECT 1 FROM aggregatefields WHERE name = 'bandwidth_max_modifier')
BEGIN
	INSERT INTO aggregatefields (name, formula, measurementunit, measurementmultiplier, measurementoffset, category, digits, moreisbetter, usedinconfig, note) VALUES
	('bandwidth_max_modifier', 1,'bandwidth_max_modifier_unit', 1, 0, 3, 0, 1, 1, 'Controlled entities limit modifier')
END
*/
GO

---- Set up aggregate fields for turrets

DECLARE @definition INT
DECLARE @field INT

---- Armor

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_em_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1500)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_laser_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1500)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_missile_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1500)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_firearm_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1500)
END

---- Accumulator

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_em_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1500)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_laser_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1500)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_missile_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1500)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_firearm_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1500)
END

---- Detection

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_em_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'detection_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 20)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_laser_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'detection_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 20)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_missile_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'detection_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 20)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_firearm_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'detection_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 20)
END

---- Masking

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_em_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'stealth_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 70)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_laser_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'stealth_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 70)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_missile_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'stealth_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 70)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_firearm_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'stealth_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 70)
END

---- Accumulator recharge

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_em_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 60)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_laser_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 60)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_missile_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 60)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_firearm_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1)
END

---- Optimal range

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_em_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 100)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_laser_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 100)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_missile_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 100)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_firearm_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 100)
END

---- Locking range

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_em_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 140)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_laser_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 140)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_missile_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 140)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_firearm_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 140)
END

---- Resists

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_em_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_chemical')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_laser_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_chemical')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_missile_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_chemical')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_firearm_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_chemical')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_em_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_explosive')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_laser_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_explosive')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_missile_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_explosive')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_firearm_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_explosive')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_em_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_kinetic')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_laser_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_kinetic')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_missile_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_kinetic')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_firearm_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_kinetic')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_em_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_thermal')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_laser_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_thermal')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_missile_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_thermal')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_firearm_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_thermal')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

---- Signature radius

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_em_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 30)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_laser_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 30)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_missile_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 30)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_firearm_sentry_turret')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 30)
END

GO

---- Set up aggregate fields for turret launchers

DECLARE @definition INT
DECLARE @field INT

---- Max bandwidth

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'bandwidth_max')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_turret_launcher')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_turret_launcher')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_turret_launcher')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_turret_launcher')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 5)
END

---- Accumulator usage

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_usage')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_turret_launcher')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 50)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_turret_launcher')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 45)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_turret_launcher')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 55)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_turret_launcher')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 60)
END

---- CPU usage

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_turret_launcher')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 85)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_turret_launcher')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 77)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_turret_launcher')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 90)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_turret_launcher')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 100)
END

---- Cycle time

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_turret_launcher')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cycle_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 3000)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_turret_launcher')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 3000)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_turret_launcher')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2500)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_turret_launcher')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2000)
END

---- Optimal range

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_turret_launcher')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 20)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_turret_launcher')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 20)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_turret_launcher')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 25)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_turret_launcher')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 30)
END

---- Reactor usage

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_turret_launcher')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 150)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_turret_launcher')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 135)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_turret_launcher')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 165)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_turret_launcher')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 180)
END

GO

---- Create categories for command bots

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_command_robots')
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(4097, 'cf_command_robots', 'Command robots', 0, 0)
END

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_combat_command_robots')
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(69633, 'cf_combat_command_robots', 'Combat command robots', 0, 0)
END

GO

---- Create entity defaults for Spectator

DECLARE @category INT

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_heavymech_chassis')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_spectator_chassis')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_spectator_chassis', 1, 1024, @category, '#slotFlags=4d3,6d0 #height=f2.00 #decay=n500', 1, 100, 78000, 1, 100, 'def_spectator_chassis_desc', 0, NULL, NULL)
END

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_heavymech_head')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_spectator_head')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_spectator_head', 1, 1024, @category, '#slotFlags=4800,8,8,8,8,8  #height=f0.10', 1, 3, 3000, 1, 100, 'def_spectator_head_desc', 0, NULL, NULL)
END

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_heavymech_leg')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_spectator_leg')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_spectator_leg', 1, 1024, @category, '#slotFlags=420,20,20,20,20  #height=f1.10', 1, 20, 18000, 1, 100, 'def_spectator_leg_desc', 0, NULL, NULL)
END

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_robot_inventory')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_robot_inventory_spectator')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_robot_inventory_spectator', 1, 4195336, @category, '#capacity=f1080.0', 1, 0, 0, 0, 100, 'def_robot_inventory_desc', 0, NULL, NULL)
END

DECLARE @head INT
DECLARE @chassis INT
DECLARE @leg INT
DECLARE @cargo INT

SET @head = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_head')
SET @chassis = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_chassis')
SET @leg = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_leg')
SET @cargo = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robot_inventory_spectator')

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_combat_command_robots')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_spectator_bot')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_spectator_bot', 1, 0, @category, CONCAT('#head=n', @head, '  #chassis=n', @chassis, '  #leg=n', @leg, '  #inventory=n', @cargo), 1, 123, 0, 0, 100, 'def_spectator_bot_desc', 1, 1, 3)
END

GO

---- Create robot definitions and it's template and link them

DECLARE @robot INT
DECLARE @head INT
DECLARE @chassis INT
DECLARE @leg INT
DECLARE @cargo INT

SET @robot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_bot')
SET @head = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_head')
SET @chassis = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_chassis')
SET @leg = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_leg')
SET @cargo = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robot_inventory_spectator')

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'spectator_empty')
BEGIN
	INSERT INTO robottemplates (name, description, note) VALUES
	('spectator_empty', CONCAT('#robot=i', FORMAT(@robot, 'X'), '#head=i', FORMAT(@head, 'X'), '#chassis=i', FORMAT(@chassis, 'X'), '#leg=i', FORMAT(@leg, 'X'), '#container=i', FORMAT(@cargo, 'X')), 'Spectator')
END

DECLARE @template INT

SET @template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'spectator_empty')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @robot AND templateid = @template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@robot, @template, 0, 0, 'def_spectator_bot')
END

GO

---- Set up aggregate fields for Spectator

DECLARE @definition INT
DECLARE @field INT

-- Legs

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_leg')

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'slope')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'speed_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1.7)
END

-- Head

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_head')

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 495)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locked_targets_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 5)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 15)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 12500)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'sensor_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 80)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission_radius')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 20)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_level_low')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 75)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_level_high')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 340)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'detection_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 95)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'stealth_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 75)
END


-- Chassis

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_chassis')

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'ammo_reload_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 10000)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2500)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2750)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 720)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 825)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_chemical')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 30)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_explosive')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 45)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_kinetic')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 45)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_thermal')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 45)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 23)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'reactor_radiation')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 7)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'mine_detection_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 7)
END

GO

---- Add new robot control extensions

DECLARE @extensionsCategory INT

SET @extensionsCategory = (SELECt TOP 1 extensioncategoryid FROM extensioncategories WHERE categoryname = 'extcat_vehicle_control')

IF NOT EXISTS (SELECT 1 FROM extensions WHERE extensionname = 'ext_command_robotics')
BEGIN
	INSERT INTO extensions (extensionid, extensionname, category, rank, learningattributeprimary, bonus, note, price, active, description, effectenhancer, hidden, freezelimit) VALUES
	(365, 'ext_command_robotics', @extensionsCategory, 5, 'attributeA', 0.03, 'Enabler for command bots', 125000, 1, 'ext_command_robotics_desc', 0, 0, 7)
END

GO

---- Add enabler extensions for Spectator

DECLARE @definition INT
DECLARE @extension INT

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_bot')

SET @extension = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname = 'ext_command_robotics')

IF NOT EXISTS (SELECT 1 FROM enablerextensions WHERE definition = @definition AND extensionid = @extension)
BEGIN
	INSERT INTO enablerextensions (definition, extensionid, extensionlevel) VALUES
	(@definition, @extension, 4)
END

GO

---- Add chassis bonuses and link them with extensions and aggregate fields

DECLARE @definition INT
DECLARE @extension INT
DECLARE @field INT

-- Chassis
    
SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_chassis')

SET @extension = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname = 'ext_command_robotics')

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_chemical')

IF NOT EXISTS (SELECT 1 FROM chassisbonus WHERE definition = @definition AND extension = @extension AND targetpropertyID = @field)
BEGIN
	INSERT INTO chassisbonus (definition, extension, bonus, targetpropertyID, effectenhancer) VALUES
	(@definition, @extension, 3, @field, 0)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_explosive')

IF NOT EXISTS (SELECT 1 FROM chassisbonus WHERE definition = @definition AND extension = @extension AND targetpropertyID = @field)
BEGIN
	INSERT INTO chassisbonus (definition, extension, bonus, targetpropertyID, effectenhancer) VALUES
	(@definition, @extension, 3, @field, 0)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_kinetic')

IF NOT EXISTS (SELECT 1 FROM chassisbonus WHERE definition = @definition AND extension = @extension AND targetpropertyID = @field)
BEGIN
	INSERT INTO chassisbonus (definition, extension, bonus, targetpropertyID, effectenhancer) VALUES
	(@definition, @extension, 3, @field, 0)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_thermal')

IF NOT EXISTS (SELECT 1 FROM chassisbonus WHERE definition = @definition AND extension = @extension AND targetpropertyID = @field)
BEGIN
	INSERT INTO chassisbonus (definition, extension, bonus, targetpropertyID, effectenhancer) VALUES
	(@definition, @extension, 3, @field, 0)
END

SET @extension = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname = 'ext_glider_specialist')

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM chassisbonus WHERE definition = @definition AND extension = @extension AND targetpropertyID = @field)
BEGIN
	INSERT INTO chassisbonus (definition, extension, bonus, targetpropertyID, effectenhancer) VALUES
	(@definition, @extension, 0.01, @field, 0)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'reactor_radiation_modifier')

IF NOT EXISTS (SELECT 1 FROM chassisbonus WHERE definition = @definition AND extension = @extension AND targetpropertyID = @field)
BEGIN
	INSERT INTO chassisbonus (definition, extension, bonus, targetpropertyID, effectenhancer) VALUES
	(@definition, @extension, -0.02, @field, 0)
END

-- Head (whyyyy)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_head')

SET @extension = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname = 'ext_command_robotics')

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max_modifier')

IF NOT EXISTS (SELECT 1 FROM chassisbonus WHERE definition = @definition AND extension = @extension AND targetpropertyID = @field)
BEGIN
	INSERT INTO chassisbonus (definition, extension, bonus, targetpropertyID, effectenhancer) VALUES
	(@definition, @extension, 0.03, @field, 0)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'massiveness')

IF NOT EXISTS (SELECT 1 FROM chassisbonus WHERE definition = @definition AND extension = @extension AND targetpropertyID = @field)
BEGIN
	INSERT INTO chassisbonus (definition, extension, bonus, targetpropertyID, effectenhancer) VALUES
	(@definition, @extension, 0.01, @field, 0)
END

-- Leg

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_leg')

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'shield_absorbtion_modifier')

IF NOT EXISTS (SELECT 1 FROM chassisbonus WHERE definition = @definition AND extension = @extension AND targetpropertyID = @field)
BEGIN
	INSERT INTO chassisbonus (definition, extension, bonus, targetpropertyID, effectenhancer) VALUES
	(@definition, @extension, 0.01, @field, 0)
END

GO

/*
---- Add new aggregate field to robot

DECLARE @definitionID int;
DECLARE @categoryFlags int;
DECLARE @aggfieldID int;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'bandwidth_max');
*/
/*
DELETE FROM [aggregatevalues] WHERE field = @aggfieldID

SET @categoryFlags = (SELECT TOP 1 [value] FROM categoryFlags WHERE [NAME] = 'cf_robot_head')
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) 
(SELECT definition, @aggfieldID, 0 FROM entitydefaults where categoryflags = @categoryFlags);

SET @categoryFlags = (SELECT TOP 1 [value] FROM categoryFlags WHERE [NAME] = 'cf_runner_head')
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) 
(SELECT definition, @aggfieldID, 0 FROM entitydefaults where categoryflags = @categoryFlags);

SET @categoryFlags = (SELECT TOP 1 [value] FROM categoryFlags WHERE [NAME] = 'cf_crawler_head')
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) 
(SELECT definition, @aggfieldID, 0 FROM entitydefaults where categoryflags = @categoryFlags);

SET @categoryFlags = (SELECT TOP 1 [value] FROM categoryFlags WHERE [NAME] = 'cf_mech_head')
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) 
(SELECT definition, @aggfieldID, 0 FROM entitydefaults where categoryflags = @categoryFlags);

SET @categoryFlags = (SELECT TOP 1 [value] FROM categoryFlags WHERE [NAME] = 'cf_heavymech_head')
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) 
(SELECT definition, @aggfieldID, 0 FROM entitydefaults where categoryflags = @categoryFlags);

SET @categoryFlags = (SELECT TOP 1 [value] FROM categoryFlags WHERE [NAME] = 'cf_walker_head')
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) 
(SELECT definition, @aggfieldID, 0 FROM entitydefaults where categoryflags = @categoryFlags);
*/
/*
-- Spectator has 1.5 base bandwidth
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_spectator_head' ORDER BY definition DESC);

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionID AND field = @aggfieldID)
BEGIN
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES
	(@definitionID, @aggfieldID, 5)
END
*/
--UPDATE [dbo].[aggregatevalues] SET value = 1.5 WHERE [definition] = @definitionID and [field] = @aggfieldID;
/*
-- Spectator also has modifier
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'bandwidth_max_modifier');

DELETE FROM [aggregatevalues] WHERE field = @aggfieldID

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES
(@definitionID, @aggfieldID, 0);
*/
GO

---- Add new extensions category

IF NOT EXISTS (SELECT 1 FROM extensioncategories WHERE categoryname = 'extcat_remote_command')
BEGIN
	INSERT INTO extensioncategories (extensioncategoryid, categoryname, hidden) VALUES
	(10, 'extcat_remote_command', 0)
END

GO

---- Add new extensions

DECLARE @extensionsCategory INT
DECLARE @affectedField INT

SET @extensionsCategory = (SELECT TOP 1 extensioncategoryid FROM extensioncategories WHERE categoryname = 'extcat_remote_command')

SET @affectedField = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'bandwidth_max_modifier')

IF NOT EXISTS (SELECT 1 FROM extensions WHERE extensionname = 'ext_remote_combat_control')
BEGIN
	INSERT INTO extensions (extensionid, extensionname, category, rank, learningattributeprimary, bonus, note, price, active, description, targetpropertyID, effectenhancer, hidden, freezelimit) VALUES
	(366, 'ext_remote_combat_control', @extensionsCategory, 5, 'attributeA', 0.5, '', 125000, 1, 'ext_remote_combat_control_desc', @affectedField, 0, 0, 7)
END

/*
INSERT INTO extensions (extensionid, extensionname, category, rank, learningattributeprimary, bonus, note, price, active, description, targetpropertyID, effectenhancer, hidden, freezelimit) VALUES
(367, 'ext_field_turret_damage', @extensionsCategory, 5, 'attributeA', 0.03, '', 125000, 1, 'ext_command_robotics_desc', NULL, 0, 0, 7),
(368, 'ext_field_turret_cycle_time', @extensionsCategory, 5, 'attributeA', 0.5, '', 125000, 1, 'ext_remote_combat_control_desc', NULL, 0, 0, 7)
*/

GO