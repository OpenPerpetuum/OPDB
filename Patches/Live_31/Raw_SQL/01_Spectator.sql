---- Create category flags for sentry turrets and remote controllers

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_sentry_turrets' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(3474, 'cf_sentry_turrets', 'Sentry Turret (deployed)', 1, 0)
END

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_remote_controlled_units' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(8202, 'cf_remote_controlled_units', 'Remote controlled units', 0, 0)
END

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_sentry_turret_units' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(1056778, 'cf_sentry_turret_units', 'Sentry turrets', 0, 0)
END

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_remote_controllers' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(722703, 'cf_remote_controllers', 'Remote controllers', 0, 1)
END

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_sentry_turret_guns' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(788239, 'cf_sentry_turret_guns', 'Sentry Turret Guns', 1, 1)
END

---- Add new slot flag

IF NOT EXISTS (SELECT 1 FROM slotFlags WHERE name = 'specialized' )
BEGIN
	INSERT INTO slotFlags (offset, name, note) VALUES (11, 'specialized', 'Special slot for remote comtrollers')
END

GO

---- Add new aggregate fields

IF NOT EXISTS (SELECT 1 FROM aggregatefields WHERE name = 'remote_control_bandwidth_max')
BEGIN
	INSERT INTO aggregatefields (name, formula, measurementunit, measurementmultiplier, measurementoffset, category, digits, moreisbetter, usedinconfig, note) VALUES
	('remote_control_bandwidth_max', 1,'remote_control_bandwidth_max_unit', 1, 0, 3, 0, 1, 1, 'Controlled entities limit')
END

IF NOT EXISTS (SELECT 1 FROM aggregatefields WHERE name = 'remote_control_bandwidth_max_modifier')
BEGIN
	INSERT INTO aggregatefields (name, formula, measurementunit, measurementmultiplier, measurementoffset, category, digits, moreisbetter, usedinconfig, note) VALUES
	('remote_control_bandwidth_max_modifier', 1,'remote_control_bandwidth_max_modifier_unit', 1, 0, 3, 0, 1, 1, 'Controlled entities limit')
END

IF NOT EXISTS (SELECT 1 FROM aggregatefields WHERE name = 'remote_control_bandwidth_usage')
BEGIN
	INSERT INTO aggregatefields (name, formula, measurementunit, measurementmultiplier, measurementoffset, category, digits, moreisbetter, usedinconfig, note) VALUES
	('remote_control_bandwidth_usage', 1,'remote_control_bandwidth_usage_unit', 1, 0, 3, 0, 1, 1, 'Channel usage')
END

GO

---- Create entity defaults for turret launchers

DECLARE @categoryFlag INT

SET @categoryFlag = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_remote_controllers')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_remote_controller')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_remote_controller', 1, 2359516, @categoryFlag, '#moduleFlag=i808  #ammoCapacity=i3  #ammoType=L200a  #powergrid_usage=f0.00  #cpu_usage=f0.00  #tier=$tierlevel_t1', 1, 1, 1, 0, 100, 'def_standart_remote_controller_desc', 1, 1, 1)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named1_remote_controller', 1, 2359516, @categoryFlag, '#moduleFlag=i808  #ammoCapacity=i3  #ammoType=L200a  #powergrid_usage=f0.00  #cpu_usage=f0.00  #tier=$tierlevel_t2', 1, 1, 1, 0, 100, 'def_standart_remote_controller_desc', 1, 1, 2)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named2_remote_controller', 1, 2359516, @categoryFlag, '#moduleFlag=i808  #ammoCapacity=i4  #ammoType=L200a  #powergrid_usage=f0.00  #cpu_usage=f0.00  #tier=$tierlevel_t3', 1, 1, 1, 0, 100, 'def_standart_remote_controller_desc', 1, 1, 3)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named3_remote_controller')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named3_remote_controller', 1, 2359516, @categoryFlag, '#moduleFlag=i808  #ammoCapacity=i5  #ammoType=L200a  #powergrid_usage=f0.00  #cpu_usage=f0.00  #tier=$tierlevel_t4', 1, 1, 1, 0, 100, 'def_standart_remote_controller_desc', 1, 1, 4)
END

GO

---- Create definitions for Sentry turret guns

DECLARE @categoryFlag INT

SET @categoryFlag = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_sentry_turret_guns')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_sentry_turret_gun')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_sentry_turret_gun', 1, 336592, @categoryFlag, '#moduleFlag=i91#ammoCapacity=i96#ammoType=L2030a#tier=$tierlevel_t1', 1, 1, 1, 0, 100, 'def_standart_sentry_turret_gun_desc', 0, 1, 1)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named1_sentry_turret_gun')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named1_sentry_turret_gun', 1, 336592, @categoryFlag, '#moduleFlag=i91#ammoCapacity=i96#ammoType=L2030a#tier=$tierlevel_t2', 1, 1, 1, 0, 100, 'def_named1_sentry_turret_gun_desc', 0, 1, 2)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named2_sentry_turret_gun')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named2_sentry_turret_gun', 1, 336592, @categoryFlag, '#moduleFlag=i91#ammoCapacity=i96#ammoType=L2030a#tier=$tierlevel_t3', 1, 1, 1, 0, 100, 'def_named2_sentry_turret_gun_desc', 0, 1, 3)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named3_sentry_turret_gun')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named3_sentry_turret_gun', 1, 336592, @categoryFlag, '#moduleFlag=i91#ammoCapacity=i96#ammoType=L2030a#tier=$tierlevel_t4', 1, 1, 1, 0, 100, 'def_named3_sentry_turret_gun_desc', 0, 1, 4)
END

GO

---- Create entity defaults for sentry turrets

DECLARE @category INT

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_robot_chassis')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_sentry_turret_chassis')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_sentry_turret_chassis', 1, 1024, @category, '#slotFlags=46d3,6d3  #height=f2.00  #decay=n500', 1, 175, 45000, 1, 100, 'def_sentry_turret_chassis_desc', 0, NULL, NULL)
END

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_robot_head')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_sentry_turret_head')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_sentry_turret_head', 1, 1024, @category, '#slotFlags=48,8,8,8  #height=f0.10', 1, 3, 2500, 1, 100, 'def_sentry_turret_head_desc', 0, NULL, NULL)
END

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_robot_leg')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_sentry_turret_leg')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_sentry_turret_leg', 1, 1024, @category, '#slotFlags=420  #height=f1.50', 1, 35, 5000, 1, 100, 'def_sentry_turret_leg_desc', 0, NULL, NULL)
END

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_robot_inventory')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_robot_inventory_sentry_turret')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_robot_inventory_sentry_turret', 1, 4195336, @category, '#capacity=f120.0', 1, 0, 0, 0, 100, 'def_robot_inventory_desc', 0, NULL, NULL)
END

DECLARE @head INT
DECLARE @chassis INT
DECLARE @leg INT
DECLARE @cargo INT

SET @head = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_sentry_turret_head')
SET @chassis = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_sentry_turret_chassis')
SET @leg = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_sentry_turret_leg')
SET @cargo = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robot_inventory_sentry_turret')

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_sentry_turrets')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_sentry_turret')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_sentry_turret', 1, 1024, @category, CONCAT('#head=n', @head, '  #chassis=n', @chassis, '  #leg=n', @leg, '  #inventory=n', @cargo), 1, 123, 0, 0, 100, 'def_standart_sentry_turret_desc', 1, 1, 1)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named1_sentry_turret')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named1_sentry_turret', 1, 1024, @category, CONCAT('#head=n', @head, '  #chassis=n', @chassis, '  #leg=n', @leg, '  #inventory=n', @cargo), 1, 123, 0, 0, 100, 'def_named1_sentry_turret_desc', 1, 1, 2)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named2_sentry_turret')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named2_sentry_turret', 1, 1024, @category, CONCAT('#head=n', @head, '  #chassis=n', @chassis, '  #leg=n', @leg, '  #inventory=n', @cargo), 1, 123, 0, 0, 100, 'def_named2_sentry_turret_desc', 1, 1, 3)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named3_sentry_turret')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named3_sentry_turret', 1, 1024, @category, CONCAT('#head=n', @head, '  #chassis=n', @chassis, '  #leg=n', @leg, '  #inventory=n', @cargo), 1, 123, 0, 0, 100, 'def_named3_sentry_turret_desc', 1, 1, 4)
END

GO

---- Create sentry turrets as ammo 

DECLARE @categoryFlag INT
DECLARE @options VARCHAR(MAX)

SET @categoryFlag = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_sentry_turret_units')

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_standart_sentry_turret'), ' #turretType=$Sentry')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_sentry_turret_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_sentry_turret_unit', 1, 2048, @categoryFlag, @options, 1, 1, 1, 0, 100, 'def_standart_sentry_turret_unit_desc', 1, 1, 1)
END

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_named1_sentry_turret'), ' #turretType=$Sentry')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named1_sentry_turret_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named1_sentry_turret_unit', 1, 2048, @categoryFlag, @options, 1, 1, 1, 0, 100, 'def_named1_sentry_turret_desc', 1, 1, 2)
END

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_named2_sentry_turret'), ' #turretType=$Sentry')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named2_sentry_turret_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named2_sentry_turret_unit', 1, 2048, @categoryFlag, @options, 1, 1, 1, 0, 100, 'def_named2_sentry_turret_unit_desc', 1, 1, 3)
END

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_named3_sentry_turret'), ' #turretType=$Sentry')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named3_sentry_turret_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named3_sentry_turret_unit', 1, 2048, @categoryFlag, @options, 1, 1, 1, 0, 100, 'def_named3_sentry_turret_unit_desc', 1, 1, 4)
END

GO

---- Create sentry turrets templates

DECLARE @robot INT
DECLARE @head INT
DECLARE @chassis INT
DECLARE @leg INT
DECLARE @cargo INT
DECLARE @gunDefinitionId VARCHAR(MAX)
DECLARE @description VARCHAR(MAX)

SET @head = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_sentry_turret_head')
SET @chassis = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_sentry_turret_chassis')
SET @leg = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_sentry_turret_leg')
SET @cargo = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robot_inventory_sentry_turret')

-- T1

SET @robot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_sentry_turret')

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'standart_sentry_turret')
BEGIN
	SET @gunDefinitionId = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_standart_sentry_turret_gun')
	
	SET @description = CONCAT('#robot=i', FORMAT(@robot, 'X'), '#head=i', FORMAT(@head, 'X'), '#chassis=i', FORMAT(@chassis, 'X'), '#leg=i', FORMAT(@leg, 'X'), '#container=i', FORMAT(@cargo, 'X'), '#chassisModules=[|m0=[|definition=i', @gunDefinitionId, '|slot=i1|ammoDefinition=i986|ammoQuantity=i96]|m1=[|definition=i', @gunDefinitionId, '|slot=i2|ammoDefinition=i986|ammoQuantity=i96]]')

	INSERT INTO robottemplates (name, description, note) VALUES
	('standart_sentry_turret', @description, 'Standart sentry turret')
END

-- T2

SET @robot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_sentry_turret')

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'named1_sentry_turret')
BEGIN
	SET @gunDefinitionId = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_named1_sentry_turret_gun')
	
	SET @description = CONCAT('#robot=i', FORMAT(@robot, 'X'), '#head=i', FORMAT(@head, 'X'), '#chassis=i', FORMAT(@chassis, 'X'), '#leg=i', FORMAT(@leg, 'X'), '#container=i', FORMAT(@cargo, 'X'), '#chassisModules=[|m0=[|definition=i', @gunDefinitionId, '|slot=i1|ammoDefinition=i986|ammoQuantity=i96]|m1=[|definition=i', @gunDefinitionId, '|slot=i2|ammoDefinition=i986|ammoQuantity=i96]]')

	INSERT INTO robottemplates (name, description, note) VALUES
	('named1_sentry_turret', @description, 'T2 sentry turret')
END

-- T3

SET @robot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_sentry_turret')

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'named2_sentry_turret')
BEGIN
	SET @gunDefinitionId = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_named2_sentry_turret_gun')
	
	SET @description = CONCAT('#robot=i', FORMAT(@robot, 'X'), '#head=i', FORMAT(@head, 'X'), '#chassis=i', FORMAT(@chassis, 'X'), '#leg=i', FORMAT(@leg, 'X'), '#container=i', FORMAT(@cargo, 'X'), '#chassisModules=[|m0=[|definition=i', @gunDefinitionId, '|slot=i1|ammoDefinition=i986|ammoQuantity=i96]|m1=[|definition=i', @gunDefinitionId, '|slot=i2|ammoDefinition=i986|ammoQuantity=i96]]')

	INSERT INTO robottemplates (name, description, note) VALUES
	('named2_sentry_turret', @description, 'T3 sentry turret')
END

-- T4

SET @robot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_sentry_turret')

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'named3_sentry_turret')
BEGIN
	SET @gunDefinitionId = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_named3_sentry_turret_gun')
	
	SET @description = CONCAT('#robot=i', FORMAT(@robot, 'X'), '#head=i', FORMAT(@head, 'X'), '#chassis=i', FORMAT(@chassis, 'X'), '#leg=i', FORMAT(@leg, 'X'), '#container=i', FORMAT(@cargo, 'X'), '#chassisModules=[|m0=[|definition=i', @gunDefinitionId, '|slot=i1|ammoDefinition=i986|ammoQuantity=i96]|m1=[|definition=i', @gunDefinitionId, '|slot=i2|ammoDefinition=i986|ammoQuantity=i96]]')

	INSERT INTO robottemplates (name, description, note) VALUES
	('named3_sentry_turret', @description, 'T4 sentry turret')
END

GO

---- Link sentry turrets with their templates

DECLARE @turret_def INT
DECLARE @turret_template INT

SET @turret_def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_sentry_turret')
SET @turret_template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'standart_sentry_turret')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @turret_def AND templateid = @turret_template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@turret_def, @turret_template, 0, 0, 'Standart sentry turret')
END

SET @turret_def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_sentry_turret')
SET @turret_template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'named1_sentry_turret')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @turret_def AND templateid = @turret_template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@turret_def, @turret_template, 0, 0, 'T2 sentry turret')
END

SET @turret_def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_sentry_turret')
SET @turret_template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'named2_sentry_turret')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @turret_def AND templateid = @turret_template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@turret_def, @turret_template, 0, 0, 'T3 sentry turret')
END

SET @turret_def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_sentry_turret')
SET @turret_template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'named3_sentry_turret')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @turret_def AND templateid = @turret_template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@turret_def, @turret_template, 0, 0, 'T4 sentry turret')
END

GO

---- Set up aggregate fields for turrets as ammo

DECLARE @definition INT
DECLARE @field INT

---- Bandwidth usage

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_bandwidth_usage')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 3)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 3)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 3)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 3)
END

---- Despawn time

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'despawn_time')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300000)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 600000)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 900000)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1200000)
END

GO

---- Set up aggregate fields for sentry turrets

DECLARE @definition INT
DECLARE @field INT

--head

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_sentry_turret_head')

---- CPU max

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1000)
END

---- Locked targets max

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locked_targets_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 10)
END

---- Locking range

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 10)
END

---- Locking time

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 10000)
END

---- Sensor strength

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'sensor_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 500)
END

---- Blob emission

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 10)
END

---- Blob emission radius

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission_radius')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 30)
END

---- Blob level low

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_level_low')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 90)
END

---- Blob level high

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_level_high')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 335)
END

---- Detection strength

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'detection_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 100)
END

---- Stealth strength

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'stealth_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 100)
END

-- chassis

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_sentry_turret_chassis')

---- Ammo reload time

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'ammo_reload_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 10000)
END

---- Armor max

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1000)
END

---- Core max

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2000)
END

---- Core recharge time

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

---- Powergrid max

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1000)
END

---- Resists

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_chemical')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 45)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_explosive')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 45)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_kinetic')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 45)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_thermal')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 45)
END

---- Signature radius

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1)
END

---- Reactor radiation

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'reactor_radiation')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 10)
END

---- Mine detection range

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'mine_detection_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 7)
END

-- leg

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_sentry_turret_leg')

---- Slope

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'slope')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 10)
END

---- Speed max

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'speed_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0)
END

-- Standart Sentry turret

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_sentry_turret')

---- Locking range modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

---- Armor max modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1)
END

---- Signature radius modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

---- T2 Sentry turret ----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_sentry_turret')

---- Locking range modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

---- Armor max modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2)
END

---- Signature radius modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4.75)
END

---- T3 Sentry turret ----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_sentry_turret')

---- Locking range modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

---- Armor max modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 5)
END

---- Signature radius modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 8.25)
END

---- T4 Sentry turret ----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_sentry_turret')

---- Locking range modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

---- Armor max modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 7)
END

---- Signature radius modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 18)
END

GO

---- Set up aggregate fields for turret launchers

DECLARE @definition INT
DECLARE @field INT

---- Max bandwidth

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_bandwidth_max')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 5)
END

---- Accumulator usage

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_usage')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 50)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 45)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 55)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 60)
END

---- CPU usage

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_remote_controller')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 85)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 77)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 90)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 100)
END

---- Cycle time

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_remote_controller')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cycle_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 3000)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 3000)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2500)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2000)
END

---- Optimal range

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_remote_controller')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 20)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 20)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 25)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 30)
END

---- Reactor usage

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_remote_controller')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 150)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 135)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 165)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_remote_controller')

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
	('def_spectator_head', 1, 1024, @category, '#slotFlags=4808,8,8,8,8,8  #height=f0.10', 1, 3, 3000, 1, 100, 'def_spectator_head_desc', 0, NULL, NULL)
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

---- Set aggregate field values to sentry turret guns

DECLARE @definitionId INT
DECLARE @fieldId INT

-- standart

SET @definitionId = (SELECT TOP 1 definition FROM entityDefaults WHERE definitionname = 'def_standart_sentry_turret_gun')

-- damage modifier

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'damage_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 3.036)
END

-- accuracy

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'accuracy')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 3.6)
END

-- core_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 2)
END

-- cpu_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 10)
END

-- cycle_time

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cycle_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 1790)
END

-- falloff

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'falloff')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 30)
END

-- optimal_range

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 10)
END

-- powergrid_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 115)
END

-- least_optimal

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'least_optimal')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 3)
END

-- T2

SET @definitionId = (SELECT TOP 1 definition FROM entityDefaults WHERE definitionname = 'def_named1_sentry_turret_gun')

-- damage modifier

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'damage_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 3.311)
END

-- accuracy

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'accuracy')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 4.2)
END

-- core_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 2)
END

-- cpu_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 10)
END

-- cycle_time

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cycle_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 1790)
END

-- falloff

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'falloff')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 20)
END

-- optimal_range

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 20)
END

-- powergrid_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 115)
END

-- least_optimal

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'least_optimal')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 3)
END

-- T3

SET @definitionId = (SELECT TOP 1 definition FROM entityDefaults WHERE definitionname = 'def_named2_sentry_turret_gun')

-- damage modifier

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'damage_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 3.751)
END

-- accuracy

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'accuracy')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 8.5)
END

-- core_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 2)
END

-- cpu_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 10)
END

-- cycle_time

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cycle_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 2140)
END

-- falloff

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'falloff')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 10)
END

-- optimal_range

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 30)
END

-- powergrid_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 115)
END

-- least_optimal

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'least_optimal')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 3)
END

-- T4

SET @definitionId = (SELECT TOP 1 definition FROM entityDefaults WHERE definitionname = 'def_named3_sentry_turret_gun')

-- damage modifier

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'damage_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 4)
END

-- accuracy

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'accuracy')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 10.2)
END

-- core_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 2)
END

-- cpu_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 10)
END

-- cycle_time

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cycle_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 2140)
END

-- falloff

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'falloff')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 5)
END

-- optimal_range

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 35)
END

-- powergrid_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 115)
END

-- least_optimal

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'least_optimal')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 3)
END

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
DECLARE @field INT

SET @extensionsCategory = (SELECT TOP 1 extensioncategoryid FROM extensioncategories WHERE categoryname = 'extcat_remote_command')

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_bandwidth_max_modifier')

IF NOT EXISTS (SELECT 1 FROM extensions WHERE extensionname = 'ext_remote_control')
BEGIN
	INSERT INTO extensions (extensionid, extensionname, category, rank, learningattributeprimary, bonus, note, price, active, description, targetpropertyID, effectenhancer, hidden, freezelimit) VALUES
	(366, 'ext_remote_control', @extensionsCategory, 5, 'attributeA', 1, '', 125000, 1, 'ext_remote_control_desc', @field, 0, 0, 7)
END

IF NOT EXISTS (SELECT 1 FROM extensions WHERE extensionname = 'ext_sentry_turrets_experience')
BEGIN
	INSERT INTO extensions (extensionid, extensionname, category, rank, learningattributeprimary, bonus, note, price, active, description, targetpropertyID, effectenhancer, hidden, freezelimit) VALUES
	(367, 'ext_sentry_turrets_experience', @extensionsCategory, 5, 'attributeA', 0, 'Enabler for higher level sentry turrets', 125000, 1, 'ext_sentry_turrets_experience_desc', NULL, 0, 0, 4)
END

IF NOT EXISTS (SELECT 1 FROM extensions WHERE extensionname = 'ext_mining_turrets_experience')
BEGIN
	INSERT INTO extensions (extensionid, extensionname, category, rank, learningattributeprimary, bonus, note, price, active, description, targetpropertyID, effectenhancer, hidden, freezelimit) VALUES
	(368, 'ext_mining_turrets_experience', @extensionsCategory, 5, 'attributeA', 0, 'Enabler for higher level mining turrets', 125000, 1, 'ext_mining_turrets_experience_desc', NULL, 0, 0, 4)
END

IF NOT EXISTS (SELECT 1 FROM extensions WHERE extensionname = 'ext_harvesting_turrets_experience')
BEGIN
	INSERT INTO extensions (extensionid, extensionname, category, rank, learningattributeprimary, bonus, note, price, active, description, targetpropertyID, effectenhancer, hidden, freezelimit) VALUES
	(369, 'ext_harvesting_turrets_experience', @extensionsCategory, 5, 'attributeA', 0, 'Enabler for higher level harvesting turrets', 125000, 1, 'ext_harvesting_turrets_experience_desc', NULL, 0, 0, 4)
END

GO

---- Link base value with modifier via category flag

DECLARE @category INT
DECLARE @base INT
DECLARE @modifier INT

-- remote controllers

-- bandwidth

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_remote_controllers')
SET @base = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_bandwidth_max')
SET @modifier = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_bandwidth_max_modifier')

IF NOT EXISTS (SELECT 1 FROM [modulepropertymodifiers] WHERE categoryflags = @category AND baseField = @base AND modifierField = @modifier)
BEGIN
	INSERT INTO [modulepropertymodifiers] (categoryflags, baseField, modifierField) VALUES
	(@category, @base, @modifier)
END

---- Add enabler extensions for sentry turrets

DECLARE @definition INT
DECLARE @extension INT

SET @extension = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname = 'ext_sentry_turrets_experience')

-- standart

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM enablerextensions WHERE definition = @definition AND extensionid = @extension)
BEGIN
	INSERT INTO enablerextensions (definition, extensionid, extensionlevel) VALUES
	(@definition, @extension, 2)
END

-- T2

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM enablerextensions WHERE definition = @definition AND extensionid = @extension)
BEGIN
	INSERT INTO enablerextensions (definition, extensionid, extensionlevel) VALUES
	(@definition, @extension, 4)
END

-- T3

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM enablerextensions WHERE definition = @definition AND extensionid = @extension)
BEGIN
	INSERT INTO enablerextensions (definition, extensionid, extensionlevel) VALUES
	(@definition, @extension, 6)
END

-- T4

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM enablerextensions WHERE definition = @definition AND extensionid = @extension)
BEGIN
	INSERT INTO enablerextensions (definition, extensionid, extensionlevel) VALUES
	(@definition, @extension, 8)
END

GO

-------------------------

---- Create category flags for mining turrets

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_mining_turrets' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(3730, 'cf_mining_turrets', 'Mining Turret (deployed)', 1, 0)
END

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_mining_turret_units' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(2105354, 'cf_mining_turret_units', 'Mining turrets', 0, 0)
END

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_industrial_turret_drillers' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(198159, 'cf_industrial_turret_drillers', 'Industrial Turret Drillers', 1, 1)
END

GO

---- Create definitions for Mining turret drillers

DECLARE @categoryFlag INT

SET @categoryFlag = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_industrial_turret_drillers')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_industrial_turret_driller')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_industrial_turret_driller', 1, 1024, @categoryFlag, '#moduleFlag=i91#tier=$tierlevel_t1', 1, 1, 1, 0, 100, 'def_standart_industrial_turret_driller_desc', 0, 1, 1)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named1_industrial_turret_driller')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named1_industrial_turret_driller', 1, 1024, @categoryFlag, '#moduleFlag=i91#tier=$tierlevel_t2', 1, 1, 1, 0, 100, 'def_named1_industrial_turret_driller_desc', 0, 1, 2)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named2_industrial_turret_driller')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named2_industrial_turret_driller', 1, 1024, @categoryFlag, '#moduleFlag=i91#tier=$tierlevel_t3', 1, 1, 1, 0, 100, 'def_named2_industrial_turret_driller_desc', 0, 1, 3)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named3_industrial_turret_driller')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named3_industrial_turret_driller', 1, 1024, @categoryFlag, '#moduleFlag=i91#tier=$tierlevel_t4', 1, 1, 1, 0, 100, 'def_named3_industrial_turret_driller_desc', 0, 1, 4)
END

GO

---- Create entity defaults for mining turrets

DECLARE @category INT

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_robot_chassis')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_mining_turret_chassis')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_mining_turret_chassis', 1, 1024, @category, '#slotFlags=46d3,6d3  #height=f2.00  #decay=n500', 1, 175, 45000, 1, 100, 'def_mining_turret_chassis_desc', 0, NULL, NULL)
END

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_robot_head')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_mining_turret_head')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_mining_turret_head', 1, 1024, @category, '#slotFlags=48,8,8,8  #height=f0.10', 1, 3, 2500, 1, 100, 'def_mining_turret_head_desc', 0, NULL, NULL)
END

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_robot_leg')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_mining_turret_leg')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_mining_turret_leg', 1, 1024, @category, '#slotFlags=420  #height=f1.50', 1, 35, 5000, 1, 100, 'def_mining_turret_leg_desc', 0, NULL, NULL)
END

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_robot_inventory')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_robot_inventory_mining_turret')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_robot_inventory_mining_turret', 1, 4195336, @category, '#capacity=f120.0', 1, 0, 0, 0, 100, 'def_robot_inventory_desc', 0, NULL, NULL)
END

DECLARE @head INT
DECLARE @chassis INT
DECLARE @leg INT
DECLARE @cargo INT

SET @head = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_mining_turret_head')
SET @chassis = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_mining_turret_chassis')
SET @leg = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_mining_turret_leg')
SET @cargo = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robot_inventory_mining_turret')

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_mining_turrets')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_mining_turret')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_mining_turret', 1, 1024, @category, CONCAT('#head=n', @head, '  #chassis=n', @chassis, '  #leg=n', @leg, '  #inventory=n', @cargo), 1, 123, 0, 0, 100, 'def_standart_mining_turret_desc', 1, 1, 1)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named1_mining_turret')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named1_mining_turret', 1, 1024, @category, CONCAT('#head=n', @head, '  #chassis=n', @chassis, '  #leg=n', @leg, '  #inventory=n', @cargo), 1, 123, 0, 0, 100, 'def_named1_mining_turret_desc', 1, 1, 2)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named2_mining_turret')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named2_mining_turret', 1, 1024, @category, CONCAT('#head=n', @head, '  #chassis=n', @chassis, '  #leg=n', @leg, '  #inventory=n', @cargo), 1, 123, 0, 0, 100, 'def_named2_mining_turret_desc', 1, 1, 3)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named3_mining_turret')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named3_mining_turret', 1, 1024, @category, CONCAT('#head=n', @head, '  #chassis=n', @chassis, '  #leg=n', @leg, '  #inventory=n', @cargo), 1, 123, 0, 0, 100, 'def_named3_mining_turret_desc', 1, 1, 4)
END

GO

---- Create mining turrets as ammo 

DECLARE @categoryFlag INT
DECLARE @options VARCHAR(MAX)

SET @categoryFlag = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_mining_turret_units')

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_standart_mining_turret'), ' #turretType=$Mining')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_mining_turret_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_mining_turret_unit', 1, 2048, @categoryFlag, @options, 1, 1, 1, 0, 100, 'def_standart_mining_turret_unit_desc', 1, 1, 1)
END

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_named1_mining_turret'), ' #turretType=$Mining')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named1_mining_turret_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named1_mining_turret_unit', 1, 2048, @categoryFlag, @options, 1, 1, 1, 0, 100, 'def_named1_mining_turret_unit_desc', 1, 1, 2)
END

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_named2_mining_turret'), ' #turretType=$Mining')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named2_mining_turret_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named2_mining_turret_unit', 1, 2048, @categoryFlag, @options, 1, 1, 1, 0, 100, 'def_named2_mining_turret_unit_desc', 1, 1, 3)
END

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_named3_mining_turret'), ' #turretType=$Mining')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named3_mining_turret_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named3_mining_turret_unit', 1, 2048, @categoryFlag, @options, 1, 1, 1, 0, 100, 'def_named3_mining_turret_unit_desc', 1, 1, 4)
END

GO

---- Create mining turrets templates

DECLARE @robot INT
DECLARE @head INT
DECLARE @chassis INT
DECLARE @leg INT
DECLARE @cargo INT
DECLARE @gunDefinitionId VARCHAR(MAX)
DECLARE @description VARCHAR(MAX)

SET @head = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_mining_turret_head')
SET @chassis = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_mining_turret_chassis')
SET @leg = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_mining_turret_leg')
SET @cargo = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robot_inventory_mining_turret')

-- T1

SET @robot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_mining_turret')

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'standart_mining_turret')
BEGIN
	SET @gunDefinitionId = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_standart_industrial_turret_driller')
	
	SET @description = CONCAT('#robot=i', FORMAT(@robot, 'X'), '#head=i', FORMAT(@head, 'X'), '#chassis=i', FORMAT(@chassis, 'X'), '#leg=i', FORMAT(@leg, 'X'), '#container=i', FORMAT(@cargo, 'X'), '#chassisModules=[|m0=[|definition=i', @gunDefinitionId, '|slot=i1]|m1=[|definition=i', @gunDefinitionId, '|slot=i2]]')

	INSERT INTO robottemplates (name, description, note) VALUES
	('standart_mining_turret', @description, 'Standart mining turret')
END

-- T2

SET @robot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_mining_turret')

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'named1_mining_turret')
BEGIN
	SET @gunDefinitionId = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_named1_industrial_turret_driller')
	
	SET @description = CONCAT('#robot=i', FORMAT(@robot, 'X'), '#head=i', FORMAT(@head, 'X'), '#chassis=i', FORMAT(@chassis, 'X'), '#leg=i', FORMAT(@leg, 'X'), '#container=i', FORMAT(@cargo, 'X'), '#chassisModules=[|m0=[|definition=i', @gunDefinitionId, '|slot=i1]|m1=[|definition=i', @gunDefinitionId, '|slot=i2]]')

	INSERT INTO robottemplates (name, description, note) VALUES
	('named1_mining_turret', @description, 'T2 mining turret')
END

-- T3

SET @robot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_mining_turret')

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'named2_mining_turret')
BEGIN
	SET @gunDefinitionId = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_named2_industrial_turret_driller')
	
	SET @description = CONCAT('#robot=i', FORMAT(@robot, 'X'), '#head=i', FORMAT(@head, 'X'), '#chassis=i', FORMAT(@chassis, 'X'), '#leg=i', FORMAT(@leg, 'X'), '#container=i', FORMAT(@cargo, 'X'), '#chassisModules=[|m0=[|definition=i', @gunDefinitionId, '|slot=i1]|m1=[|definition=i', @gunDefinitionId, '|slot=i2]]')

	INSERT INTO robottemplates (name, description, note) VALUES
	('named2_mining_turret', @description, 'T3 mining turret')
END

-- T4

SET @robot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_mining_turret')

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'named3_mining_turret')
BEGIN
	SET @gunDefinitionId = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_named3_industrial_turret_driller')
	
	SET @description = CONCAT('#robot=i', FORMAT(@robot, 'X'), '#head=i', FORMAT(@head, 'X'), '#chassis=i', FORMAT(@chassis, 'X'), '#leg=i', FORMAT(@leg, 'X'), '#container=i', FORMAT(@cargo, 'X'), '#chassisModules=[|m0=[|definition=i', @gunDefinitionId, '|slot=i1]|m1=[|definition=i', @gunDefinitionId, '|slot=i2]]')

	INSERT INTO robottemplates (name, description, note) VALUES
	('named3_mining_turret', @description, 'T4 mining turret')
END

GO

---- Link mining turrets with their templates

DECLARE @turret_def INT
DECLARE @turret_template INT

SET @turret_def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_mining_turret')
SET @turret_template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'standart_mining_turret')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @turret_def AND templateid = @turret_template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@turret_def, @turret_template, 0, 0, 'Standart mining turret')
END

SET @turret_def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_mining_turret')
SET @turret_template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'named1_mining_turret')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @turret_def AND templateid = @turret_template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@turret_def, @turret_template, 0, 0, 'T2 mining turret')
END

SET @turret_def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_mining_turret')
SET @turret_template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'named2_mining_turret')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @turret_def AND templateid = @turret_template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@turret_def, @turret_template, 0, 0, 'T3 mining turret')
END

SET @turret_def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_mining_turret')
SET @turret_template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'named3_mining_turret')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @turret_def AND templateid = @turret_template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@turret_def, @turret_template, 0, 0, 'T4 mining turret')
END

GO

---- Set up aggregate fields for mining turrets as ammo

DECLARE @definition INT
DECLARE @field INT

---- Bandwidth usage

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_bandwidth_usage')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_mining_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_mining_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_mining_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_mining_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

---- Despawn time

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'despawn_time')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_mining_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300000)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_mining_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 600000)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_mining_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 900000)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_mining_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1200000)
END

GO

---- Set up aggregate fields for mining turrets

DECLARE @definition INT
DECLARE @field INT

DECLARE @definition INT
DECLARE @field INT

--head

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_mining_turret_head')

---- CPU max

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1000)
END

---- Locked targets max

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locked_targets_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 10)
END

---- Locking range

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 10)
END

---- Locking time

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 10000)
END

---- Sensor strength

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'sensor_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 500)
END

---- Blob emission

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 10)
END

---- Blob emission radius

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission_radius')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 30)
END

---- Blob level low

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_level_low')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 90)
END

---- Blob level high

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_level_high')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 335)
END

---- Detection strength

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'detection_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 100)
END

---- Stealth strength

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'stealth_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 100)
END

-- chassis

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_mining_turret_chassis')

---- Ammo reload time

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'ammo_reload_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 10000)
END

---- Armor max

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1000)
END

---- Core max

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2000)
END

---- Core recharge time

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

---- Powergrid max

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1000)
END

---- Resists

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_chemical')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 45)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_explosive')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 45)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_kinetic')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 45)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_thermal')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 45)
END

---- Signature radius

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 10)
END

---- Reactor radiation

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'reactor_radiation')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 10)
END

---- Mine detection range

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'mine_detection_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 7)
END

-- leg

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_mining_turret_leg')

---- Slope

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'slope')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 10)
END

---- Speed max

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'speed_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0)
END

-- Standart Mining turret

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_mining_turret')

---- Locking range modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

-- mining_amount_modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'mining_amount_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1.21)
END

---- Armor max modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1)
END

---- Signature radius modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

---- T2 Mining turret ----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_mining_turret')

---- Locking range modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

-- mining_amount_modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'mining_amount_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1.62)
END

---- Armor max modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2)
END

---- Signature radius modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4.75)
END

---- T3 Mining turret ----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_mining_turret')

---- Locking range modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

-- mining_amount_modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'mining_amount_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1.78)
END

---- Armor max modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 5)
END

---- Signature radius modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 8.25)
END

---- T4 Mining turret ----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_mining_turret')

---- Locking range modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

-- mining_amount_modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'mining_amount_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2.22)
END

---- Armor max modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 7)
END

---- Signature radius modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 18)
END

GO

---- Set aggregate field values to mining turret drillers

DECLARE @definitionId INT
DECLARE @fieldId INT

-- standart

SET @definitionId = (SELECT TOP 1 definition FROM entityDefaults WHERE definitionname = 'def_standart_industrial_turret_driller')

-- core_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 0)
END

-- cpu_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 50)
END

-- cycle_time

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cycle_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 6310)
END

-- optimal_range

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 5)
END

-- powergrid_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 150)
END

-- T2

SET @definitionId = (SELECT TOP 1 definition FROM entityDefaults WHERE definitionname = 'def_named1_industrial_turret_driller')

-- core_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 0)
END

-- cpu_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 50)
END

-- cycle_time

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cycle_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 5560)
END

-- optimal_range

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 10)
END

-- powergrid_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 150)
END

-- T3

SET @definitionId = (SELECT TOP 1 definition FROM entityDefaults WHERE definitionname = 'def_named2_industrial_turret_driller')

-- core_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 0)
END

-- cpu_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 50)
END

-- cycle_time

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cycle_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 5050)
END

-- optimal_range

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 15)
END

-- powergrid_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 150)
END

-- T4

SET @definitionId = (SELECT TOP 1 definition FROM entityDefaults WHERE definitionname = 'def_named3_industrial_turret_driller')

-- core_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 0)
END

-- cpu_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 50)
END

-- cycle_time

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cycle_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 4060)
END

-- optimal_range

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 20)
END

-- powergrid_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 150)
END

GO

---- Add enabler extensions for sentry turrets

DECLARE @definition INT
DECLARE @extension INT

SET @extension = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname = 'ext_mining_turrets_experience')

-- standart

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_mining_turret_unit')

IF NOT EXISTS (SELECT 1 FROM enablerextensions WHERE definition = @definition AND extensionid = @extension)
BEGIN
	INSERT INTO enablerextensions (definition, extensionid, extensionlevel) VALUES
	(@definition, @extension, 2)
END

-- T2

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_mining_turret_unit')

IF NOT EXISTS (SELECT 1 FROM enablerextensions WHERE definition = @definition AND extensionid = @extension)
BEGIN
	INSERT INTO enablerextensions (definition, extensionid, extensionlevel) VALUES
	(@definition, @extension, 4)
END

-- T3

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_mining_turret_unit')

IF NOT EXISTS (SELECT 1 FROM enablerextensions WHERE definition = @definition AND extensionid = @extension)
BEGIN
	INSERT INTO enablerextensions (definition, extensionid, extensionlevel) VALUES
	(@definition, @extension, 6)
END

-- T4

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_mining_turret_unit')

IF NOT EXISTS (SELECT 1 FROM enablerextensions WHERE definition = @definition AND extensionid = @extension)
BEGIN
	INSERT INTO enablerextensions (definition, extensionid, extensionlevel) VALUES
	(@definition, @extension, 8)
END

GO

-- assign beams to drillers

DECLARE @moduleId INT
DECLARE @beamId INT

SET @beamId = (SELECT TOP 1 id FROM beams WHERE name = 'small_driller')

-- standart

SET @moduleId = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_industrial_turret_driller')

IF NOT EXISTS (SELECT 1 FROM beamassignment WHERE definition = @moduleId AND beam = @beamId)
BEGIN
	INSERT INTO beamassignment (definition, beam) VALUES (@moduleId, @beamId)
END

-- T2

SET @moduleId = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_industrial_turret_driller')

IF NOT EXISTS (SELECT 1 FROM beamassignment WHERE definition = @moduleId AND beam = @beamId)
BEGIN
	INSERT INTO beamassignment (definition, beam) VALUES (@moduleId, @beamId)
END

-- T3

SET @moduleId = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_industrial_turret_driller')

IF NOT EXISTS (SELECT 1 FROM beamassignment WHERE definition = @moduleId AND beam = @beamId)
BEGIN
	INSERT INTO beamassignment (definition, beam) VALUES (@moduleId, @beamId)
END

-- T4

SET @moduleId = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_industrial_turret_driller')

IF NOT EXISTS (SELECT 1 FROM beamassignment WHERE definition = @moduleId AND beam = @beamId)
BEGIN
	INSERT INTO beamassignment (definition, beam) VALUES (@moduleId, @beamId)
END

GO

-------------------------

---- Create category flags for harvesting turrets

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_harvesting_turrets' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(3986, 'cf_harvesting_turrets', 'Harvesting Turret (deployed)', 1, 0)
END

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_harvesting_turret_units' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(3153930, 'cf_harvesting_turret_units', 'Harvesting turrets', 0, 0)
END

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_industrial_turret_harvesters' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(525839, 'cf_industrial_turret_harvesters', 'Industrial Turret Drillers', 1, 1)
END

GO

---- Create definitions for Mining turret harvesters

DECLARE @categoryFlag INT

SET @categoryFlag = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_industrial_turret_harvesters')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_industrial_turret_harvester')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_industrial_turret_harvester', 1, 1024, @categoryFlag, '#moduleFlag=i91#tier=$tierlevel_t1', 1, 1, 1, 0, 100, 'def_standart_industrial_turret_harvester_desc', 0, 1, 1)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named1_industrial_turret_harvester')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named1_industrial_turret_harvester', 1, 1024, @categoryFlag, '#moduleFlag=i91#tier=$tierlevel_t2', 1, 1, 1, 0, 100, 'def_named1_industrial_turret_harvester_desc', 0, 1, 2)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named2_industrial_turret_harvester')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named2_industrial_turret_harvester', 1, 1024, @categoryFlag, '#moduleFlag=i91#tier=$tierlevel_t3', 1, 1, 1, 0, 100, 'def_named2_industrial_turret_harvester_desc', 0, 1, 3)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named3_industrial_turret_harvester')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named3_industrial_turret_harvester', 1, 1024, @categoryFlag, '#moduleFlag=i91#tier=$tierlevel_t4', 1, 1, 1, 0, 100, 'def_named3_industrial_turret_harvester_desc', 0, 1, 4)
END

GO

---- Create entity defaults for harvesting turrets

DECLARE @category INT

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_robot_chassis')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_harvesting_turret_chassis')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_harvesting_turret_chassis', 1, 1024, @category, '#slotFlags=46d3,6d3  #height=f2.00  #decay=n500', 1, 175, 45000, 1, 100, 'def_harvesting_turret_chassis_desc', 0, NULL, NULL)
END

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_robot_head')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_harvesting_turret_head')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_harvesting_turret_head', 1, 1024, @category, '#slotFlags=48,8,8,8  #height=f0.10', 1, 3, 2500, 1, 100, 'def_harvesting_turret_head_desc', 0, NULL, NULL)
END

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_robot_leg')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_harvesting_turret_leg')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_harvesting_turret_leg', 1, 1024, @category, '#slotFlags=420  #height=f1.50', 1, 35, 5000, 1, 100, 'def_harvesting_turret_leg_desc', 0, NULL, NULL)
END

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_robot_inventory')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_robot_inventory_harvesting_turret')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_robot_inventory_harvesting_turret', 1, 4195336, @category, '#capacity=f120.0', 1, 0, 0, 0, 100, 'def_robot_inventory_desc', 0, NULL, NULL)
END

DECLARE @head INT
DECLARE @chassis INT
DECLARE @leg INT
DECLARE @cargo INT

SET @head = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_harvesting_turret_head')
SET @chassis = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_harvesting_turret_chassis')
SET @leg = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_harvesting_turret_leg')
SET @cargo = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robot_inventory_harvesting_turret')

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_harvesting_turrets')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_harvesting_turret')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_harvesting_turret', 1, 1024, @category, CONCAT('#head=n', @head, '  #chassis=n', @chassis, '  #leg=n', @leg, '  #inventory=n', @cargo), 1, 123, 0, 0, 100, 'def_standart_harvesting_turret_desc', 1, 1, 1)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named1_harvesting_turret')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named1_harvesting_turret', 1, 1024, @category, CONCAT('#head=n', @head, '  #chassis=n', @chassis, '  #leg=n', @leg, '  #inventory=n', @cargo), 1, 123, 0, 0, 100, 'def_named1_harvesting_turret_desc', 1, 1, 2)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named2_harvesting_turret')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named2_harvesting_turret', 1, 1024, @category, CONCAT('#head=n', @head, '  #chassis=n', @chassis, '  #leg=n', @leg, '  #inventory=n', @cargo), 1, 123, 0, 0, 100, 'def_named2_harvesting_turret_desc', 1, 1, 3)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named3_harvesting_turret')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named3_harvesting_turret', 1, 1024, @category, CONCAT('#head=n', @head, '  #chassis=n', @chassis, '  #leg=n', @leg, '  #inventory=n', @cargo), 1, 123, 0, 0, 100, 'def_named3_harvesting_turret_desc', 1, 1, 4)
END

GO

---- Create harvesting turrets as ammo 

DECLARE @categoryFlag INT
DECLARE @options VARCHAR(MAX)

SET @categoryFlag = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_harvesting_turret_units')

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_standart_harvesting_turret'), ' #turretType=$Harvesting')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_harvesting_turret_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_harvesting_turret_unit', 1, 2048, @categoryFlag, @options, 1, 1, 1, 0, 100, 'def_standart_harvesting_turret_unit_desc', 1, 1, 1)
END

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_named1_harvesting_turret'), ' #turretType=$Harvesting')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named1_harvesting_turret_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named1_harvesting_turret_unit', 1, 2048, @categoryFlag, @options, 1, 1, 1, 0, 100, 'def_named1_harvesting_turret_unit_desc', 1, 1, 2)
END

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_named2_harvesting_turret'), ' #turretType=$Harvesting')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named2_harvesting_turret_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named2_harvesting_turret_unit', 1, 2048, @categoryFlag, @options, 1, 1, 1, 0, 100, 'def_named2_harvesting_turret_unit_desc', 1, 1, 3)
END

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_named3_harvesting_turret'), ' #turretType=$Harvesting')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named3_harvesting_turret_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named3_harvesting_turret_unit', 1, 2048, @categoryFlag, @options, 1, 1, 1, 0, 100, 'def_named3_harvesting_turret_unit_desc', 1, 1, 4)
END

GO

---- Create harvesting turrets templates

DECLARE @robot INT
DECLARE @head INT
DECLARE @chassis INT
DECLARE @leg INT
DECLARE @cargo INT
DECLARE @gunDefinitionId VARCHAR(MAX)
DECLARE @description VARCHAR(MAX)

SET @head = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_harvesting_turret_head')
SET @chassis = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_harvesting_turret_chassis')
SET @leg = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_harvesting_turret_leg')
SET @cargo = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robot_inventory_harvesting_turret')

-- T1

SET @robot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_harvesting_turret')

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'standart_harvesting_turret')
BEGIN
	SET @gunDefinitionId = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_standart_industrial_turret_harvester')
	
	SET @description = CONCAT('#robot=i', FORMAT(@robot, 'X'), '#head=i', FORMAT(@head, 'X'), '#chassis=i', FORMAT(@chassis, 'X'), '#leg=i', FORMAT(@leg, 'X'), '#container=i', FORMAT(@cargo, 'X'), '#chassisModules=[|m0=[|definition=i', @gunDefinitionId, '|slot=i1]|m1=[|definition=i', @gunDefinitionId, '|slot=i2]]')

	INSERT INTO robottemplates (name, description, note) VALUES
	('standart_harvesting_turret', @description, 'Standart harvesting turret')
END

-- T2

SET @robot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_harvesting_turret')

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'named1_harvesting_turret')
BEGIN
	SET @gunDefinitionId = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_named1_industrial_turret_harvester')
	
	SET @description = CONCAT('#robot=i', FORMAT(@robot, 'X'), '#head=i', FORMAT(@head, 'X'), '#chassis=i', FORMAT(@chassis, 'X'), '#leg=i', FORMAT(@leg, 'X'), '#container=i', FORMAT(@cargo, 'X'), '#chassisModules=[|m0=[|definition=i', @gunDefinitionId, '|slot=i1]|m1=[|definition=i', @gunDefinitionId, '|slot=i2]]')

	INSERT INTO robottemplates (name, description, note) VALUES
	('named1_harvesting_turret', @description, 'T2 harvesting turret')
END

-- T3

SET @robot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_harvesting_turret')

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'named2_harvesting_turret')
BEGIN
	SET @gunDefinitionId = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_named2_industrial_turret_harvester')
	
	SET @description = CONCAT('#robot=i', FORMAT(@robot, 'X'), '#head=i', FORMAT(@head, 'X'), '#chassis=i', FORMAT(@chassis, 'X'), '#leg=i', FORMAT(@leg, 'X'), '#container=i', FORMAT(@cargo, 'X'), '#chassisModules=[|m0=[|definition=i', @gunDefinitionId, '|slot=i1]|m1=[|definition=i', @gunDefinitionId, '|slot=i2]]')

	INSERT INTO robottemplates (name, description, note) VALUES
	('named2_harvesting_turret', @description, 'T3 harvesting turret')
END

-- T4

SET @robot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_harvesting_turret')

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'named3_harvesting_turret')
BEGIN
	SET @gunDefinitionId = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_named3_industrial_turret_harvester')
	
	SET @description = CONCAT('#robot=i', FORMAT(@robot, 'X'), '#head=i', FORMAT(@head, 'X'), '#chassis=i', FORMAT(@chassis, 'X'), '#leg=i', FORMAT(@leg, 'X'), '#container=i', FORMAT(@cargo, 'X'), '#chassisModules=[|m0=[|definition=i', @gunDefinitionId, '|slot=i1]|m1=[|definition=i', @gunDefinitionId, '|slot=i2]]')

	INSERT INTO robottemplates (name, description, note) VALUES
	('named3_harvesting_turret', @description, 'T4 harvesting turret')
END

GO

---- Link harvesting turrets with their templates

DECLARE @turret_def INT
DECLARE @turret_template INT

SET @turret_def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_harvesting_turret')
SET @turret_template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'standart_harvesting_turret')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @turret_def AND templateid = @turret_template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@turret_def, @turret_template, 0, 0, 'Standart harvesting turret')
END

SET @turret_def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_harvesting_turret')
SET @turret_template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'named1_harvesting_turret')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @turret_def AND templateid = @turret_template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@turret_def, @turret_template, 0, 0, 'T2 harvesting turret')
END

SET @turret_def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_harvesting_turret')
SET @turret_template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'named2_harvesting_turret')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @turret_def AND templateid = @turret_template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@turret_def, @turret_template, 0, 0, 'T3 harvesting turret')
END

SET @turret_def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_harvesting_turret')
SET @turret_template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'named3_harvesting_turret')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @turret_def AND templateid = @turret_template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@turret_def, @turret_template, 0, 0, 'T4 harvesting turret')
END

GO

---- Set up aggregate fields for harvesting turrets as ammo

DECLARE @definition INT
DECLARE @field INT

---- Bandwidth usage

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_bandwidth_usage')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_harvesting_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_harvesting_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_harvesting_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_harvesting_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

---- Despawn time

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'despawn_time')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_harvesting_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300000)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_harvesting_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 600000)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_harvesting_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 900000)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_harvesting_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1200000)
END

GO

---- Set up aggregate fields for harvesting turrets

DECLARE @definition INT
DECLARE @field INT

DECLARE @definition INT
DECLARE @field INT

--head

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_harvesting_turret_head')

---- CPU max

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1000)
END

---- Locked targets max

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locked_targets_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 10)
END

---- Locking range

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 10)
END

---- Locking time

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 10000)
END

---- Sensor strength

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'sensor_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 500)
END

---- Blob emission

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 10)
END

---- Blob emission radius

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission_radius')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 30)
END

---- Blob level low

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_level_low')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 90)
END

---- Blob level high

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_level_high')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 335)
END

---- Detection strength

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'detection_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 100)
END

---- Stealth strength

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'stealth_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 100)
END

-- chassis

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_harvesting_turret_chassis')

---- Ammo reload time

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'ammo_reload_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 10000)
END

---- Armor max

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1000)
END

---- Core max

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2000)
END

---- Core recharge time

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300)
END

---- Powergrid max

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1000)
END

---- Resists

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_chemical')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 45)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_explosive')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 45)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_kinetic')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 45)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_thermal')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 45)
END

---- Signature radius

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 10)
END

---- Reactor radiation

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'reactor_radiation')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 10)
END

---- Mine detection range

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'mine_detection_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 7)
END

-- leg

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_harvesting_turret_leg')

---- Slope

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'slope')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 10)
END

---- Speed max

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'speed_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0)
END

-- Standart Harvesting turret

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_harvesting_turret')

---- Locking range modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

-- harvesting_amount_modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'harvesting_amount_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1.36)
END

---- Armor max modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1)
END

---- Signature radius modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

---- T2 Harvesting turret ----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_harvesting_turret')

---- Locking range modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

-- harvesting_amount_modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'harvesting_amount_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1.82)
END

---- Armor max modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2)
END

---- Signature radius modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4.75)
END

---- T3 Harvesting turret ----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_harvesting_turret')

---- Locking range modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

-- harvesting_amount_modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'harvesting_amount_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2)
END

---- Armor max modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 5)
END

---- Signature radius modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 8.25)
END

---- T4 Harvesting turret ----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_harvesting_turret')

---- Locking range modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

-- harvesting_amount_modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'harvesting_amount_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2.5)
END

---- Armor max modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 7)
END

---- Signature radius modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 18)
END

GO

---- Set aggregate field values to industrial turret harvesters

DECLARE @definitionId INT
DECLARE @fieldId INT

-- standart

SET @definitionId = (SELECT TOP 1 definition FROM entityDefaults WHERE definitionname = 'def_standart_industrial_turret_harvester')

-- core_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 0)
END

-- cpu_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 50)
END

-- cycle_time

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cycle_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 6580)
END

-- optimal_range

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 5)
END

-- powergrid_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 150)
END

-- T2

SET @definitionId = (SELECT TOP 1 definition FROM entityDefaults WHERE definitionname = 'def_named1_industrial_turret_harvester')

-- core_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 0)
END

-- cpu_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 50)
END

-- cycle_time

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cycle_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 6010)
END

-- optimal_range

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 10)
END

-- powergrid_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 150)
END

-- T3

SET @definitionId = (SELECT TOP 1 definition FROM entityDefaults WHERE definitionname = 'def_named2_industrial_turret_harvester')

-- core_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 0)
END

-- cpu_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 50)
END

-- cycle_time

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cycle_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 5260)
END

-- optimal_range

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 15)
END

-- powergrid_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 150)
END

-- T4

SET @definitionId = (SELECT TOP 1 definition FROM entityDefaults WHERE definitionname = 'def_named3_industrial_turret_harvester')

-- core_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 0)
END

-- cpu_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 50)
END

-- cycle_time

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cycle_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 4810)
END

-- optimal_range

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 20)
END

-- powergrid_usage

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 150)
END

GO

---- Add enabler extensions for harvesting turrets

DECLARE @definition INT
DECLARE @extension INT

SET @extension = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname = 'ext_harvesting_turrets_experience')

-- standart

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_harvesting_turret_unit')

IF NOT EXISTS (SELECT 1 FROM enablerextensions WHERE definition = @definition AND extensionid = @extension)
BEGIN
	INSERT INTO enablerextensions (definition, extensionid, extensionlevel) VALUES
	(@definition, @extension, 2)
END

-- T2

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_harvesting_turret_unit')

IF NOT EXISTS (SELECT 1 FROM enablerextensions WHERE definition = @definition AND extensionid = @extension)
BEGIN
	INSERT INTO enablerextensions (definition, extensionid, extensionlevel) VALUES
	(@definition, @extension, 4)
END

-- T3

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_harvesting_turret_unit')

IF NOT EXISTS (SELECT 1 FROM enablerextensions WHERE definition = @definition AND extensionid = @extension)
BEGIN
	INSERT INTO enablerextensions (definition, extensionid, extensionlevel) VALUES
	(@definition, @extension, 6)
END

-- T4

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_harvesting_turret_unit')

IF NOT EXISTS (SELECT 1 FROM enablerextensions WHERE definition = @definition AND extensionid = @extension)
BEGIN
	INSERT INTO enablerextensions (definition, extensionid, extensionlevel) VALUES
	(@definition, @extension, 8)
END

GO

-- assign beams to drillers

DECLARE @moduleId INT
DECLARE @beamId INT

SET @beamId = (SELECT TOP 1 id FROM beams WHERE name = 'small_harvester')

-- standart

SET @moduleId = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_industrial_turret_harvester')

IF NOT EXISTS (SELECT 1 FROM beamassignment WHERE definition = @moduleId AND beam = @beamId)
BEGIN
	INSERT INTO beamassignment (definition, beam) VALUES (@moduleId, @beamId)
END

-- T2

SET @moduleId = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_industrial_turret_harvester')

IF NOT EXISTS (SELECT 1 FROM beamassignment WHERE definition = @moduleId AND beam = @beamId)
BEGIN
	INSERT INTO beamassignment (definition, beam) VALUES (@moduleId, @beamId)
END

-- T3

SET @moduleId = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_industrial_turret_harvester')

IF NOT EXISTS (SELECT 1 FROM beamassignment WHERE definition = @moduleId AND beam = @beamId)
BEGIN
	INSERT INTO beamassignment (definition, beam) VALUES (@moduleId, @beamId)
END

-- T4

SET @moduleId = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_industrial_turret_harvester')

IF NOT EXISTS (SELECT 1 FROM beamassignment WHERE definition = @moduleId AND beam = @beamId)
BEGIN
	INSERT INTO beamassignment (definition, beam) VALUES (@moduleId, @beamId)
END

GO