---- Create category flags for sentry turrets and remote controllers

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_sentry_turrets' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(3474, 'cf_sentry_turrets', 'Sentry Turret (deployed)', 1, 0)
END

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_remote_controlled_units' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(4618, 'cf_remote_controlled_units', 'Remote controlled units', 0, 0)
END

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_remote_controlled_turrets' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(70154, 'cf_remote_controlled_turrets', 'Remote controlled turrets', 0, 0)
END

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_sentry_turret_units' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(16847370, 'cf_sentry_turret_units', 'Sentry turrets', 0, 0)
END

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_remote_controllers' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(787471, 'cf_remote_controllers', 'Remote controllers', 0, 1)
END

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_sentry_turret_guns' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(788239, 'cf_sentry_turret_guns', 'Sentry Turret Guns', 1, 1)
END

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_electronics_equipment_calibration_programs' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(100926486, 'cf_electronics_equipment_calibration_programs', 'Electronics Equipment CT', 1, 1)
END

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_ct_capsules_robot_syndicate_commandbot' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(5519083504795, 'cf_ct_capsules_robot_syndicate_commandbot', 'Syndicate command bot CT capsules', 1, 1)
END

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_ammo_rcu_calibration_programs' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(251855894, 'cf_ammo_rcu_calibration_programs', 'RCU CTs', 1, 1)
END

GO

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

IF NOT EXISTS (SELECT 1 FROM aggregatefields WHERE name = 'remote_control_operational_range')
BEGIN
	INSERT INTO aggregatefields (name, formula, measurementunit, measurementmultiplier, measurementoffset, category, digits, moreisbetter, usedinconfig, note) VALUES
	('remote_control_operational_range', 1,'remote_control_operational_range_unit', 1, 0, 3, 0, 1, 1, 'Operational range')
END

IF NOT EXISTS (SELECT 1 FROM aggregatefields WHERE name = 'remote_control_operational_range_modifier')
BEGIN
	INSERT INTO aggregatefields (name, formula, measurementunit, measurementmultiplier, measurementoffset, category, digits, moreisbetter, usedinconfig, note) VALUES
	('remote_control_operational_range_modifier', 1,'remote_control_operational_range_modifier_unit', 1, 0, 3, 0, 1, 1, 'Operational range modifier')
END

IF NOT EXISTS (SELECT 1 FROM aggregatefields WHERE name = 'remote_control_lifetime')
BEGIN
	INSERT INTO aggregatefields (name, formula, measurementunit, measurementmultiplier, measurementoffset, category, digits, moreisbetter, usedinconfig, note) VALUES
	('remote_control_lifetime', 1,'remote_control_lifetime_unit', 1, 0, 3, 0, 1, 1, 'RCU lifetime')
END

IF NOT EXISTS (SELECT 1 FROM aggregatefields WHERE name = 'remote_control_lifetime_modifier')
BEGIN
	INSERT INTO aggregatefields (name, formula, measurementunit, measurementmultiplier, measurementoffset, category, digits, moreisbetter, usedinconfig, note) VALUES
	('remote_control_lifetime_modifier', 1,'remote_control_lifetime_modifier_unit', 1, 0, 3, 0, 1, 1, 'RCU lifetime modifier')
END

GO

---- Create entity defaults for remote controllers

DECLARE @categoryFlag INT

SET @categoryFlag = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_remote_controllers')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_remote_controller')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_remote_controller', 1, 2359320, @categoryFlag, '#moduleFlag=i808  #ammoCapacity=i3  #ammoType=L200a  #powergrid_usage=f0.00  #cpu_usage=f0.00  #tier=$tierlevel_t1', 1, 1, 1, 0, 100, 'def_standart_remote_controller_desc', 1, 1, 1)
END
ELSE
BEGIN
	UPDATE entitydefaults SET options='#moduleFlag=i808  #ammoCapacity=i3  #ammoType=L200a  #powergrid_usage=f0.00  #cpu_usage=f0.00  #tier=$tierlevel_t1', mass=1 WHERE definitionname = 'def_standart_remote_controller'
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named1_remote_controller', 1, 2359320, @categoryFlag, '#moduleFlag=i808  #ammoCapacity=i3  #ammoType=L200a  #powergrid_usage=f0.00  #cpu_usage=f0.00  #tier=$tierlevel_t2', 1, 1, 1, 0, 100, 'def_standart_remote_controller_desc', 1, 1, 2)
END
ELSE
BEGIN
	UPDATE entitydefaults SET options='#moduleFlag=i808  #ammoCapacity=i3  #ammoType=L200a  #powergrid_usage=f0.00  #cpu_usage=f0.00  #tier=$tierlevel_t2', mass=1 WHERE definitionname = 'def_named1_remote_controller'
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named2_remote_controller', 1, 2359320, @categoryFlag, '#moduleFlag=i808  #ammoCapacity=i4  #ammoType=L200a  #powergrid_usage=f0.00  #cpu_usage=f0.00  #tier=$tierlevel_t3', 1, 1, 1, 0, 100, 'def_standart_remote_controller_desc', 1, 1, 3)
END
ELSE
BEGIN
	UPDATE entitydefaults SET options='#moduleFlag=i808  #ammoCapacity=i4  #ammoType=L200a  #powergrid_usage=f0.00  #cpu_usage=f0.00  #tier=$tierlevel_t3', mass=1 WHERE definitionname = 'def_named2_remote_controller'
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named3_remote_controller')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named3_remote_controller', 1, 2359320, @categoryFlag, '#moduleFlag=i808  #ammoCapacity=i5  #ammoType=L200a  #powergrid_usage=f0.00  #cpu_usage=f0.00  #tier=$tierlevel_t4', 1, 1, 1, 0, 100, 'def_standart_remote_controller_desc', 1, 1, 4)
END
ELSE
BEGIN
	UPDATE entitydefaults SET options='#moduleFlag=i808  #ammoCapacity=i5  #ammoType=L200a  #powergrid_usage=f0.00  #cpu_usage=f0.00  #tier=$tierlevel_t4', mass=1 WHERE definitionname = 'def_named3_remote_controller'
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
ELSE
BEGIN
	UPDATE entitydefaults SET attributeflags = 1024 WHERE definitionname = 'def_standart_sentry_turret'
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named1_sentry_turret')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named1_sentry_turret', 1, 1024, @category, CONCAT('#head=n', @head, '  #chassis=n', @chassis, '  #leg=n', @leg, '  #inventory=n', @cargo), 1, 123, 0, 0, 100, 'def_named1_sentry_turret_desc', 1, 1, 2)
END
ELSE
BEGIN
	UPDATE entitydefaults SET attributeflags = 1024 WHERE definitionname = 'def_named1_sentry_turret'
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named2_sentry_turret')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named2_sentry_turret', 1, 1024, @category, CONCAT('#head=n', @head, '  #chassis=n', @chassis, '  #leg=n', @leg, '  #inventory=n', @cargo), 1, 123, 0, 0, 100, 'def_named2_sentry_turret_desc', 1, 1, 3)
END
ELSE
BEGIN
	UPDATE entitydefaults SET attributeflags = 1024 WHERE definitionname = 'def_named2_sentry_turret'
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named3_sentry_turret')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named3_sentry_turret', 1, 1024, @category, CONCAT('#head=n', @head, '  #chassis=n', @chassis, '  #leg=n', @leg, '  #inventory=n', @cargo), 1, 123, 0, 0, 100, 'def_named3_sentry_turret_desc', 1, 1, 4)
END
ELSE
BEGIN
	UPDATE entitydefaults SET attributeflags = 1024 WHERE definitionname = 'def_named3_sentry_turret'
END

GO

---- Create sentry turrets as ammo 

DECLARE @categoryFlag INT
DECLARE @options VARCHAR(MAX)

SET @categoryFlag = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_sentry_turret_units')

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_standart_sentry_turret'), ' #turretType=$Sentry #tier=$tierlevel_t1')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_sentry_turret_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_sentry_turret_unit', 10, 2048, @categoryFlag, @options, 1, 10, 1, 0, 100, 'def_standart_sentry_turret_unit_desc', 1, 1, 1)
END
ELSE
BEGIN
	UPDATE entitydefaults SET quantity = 10, volume = 10 WHERE definitionname = 'def_standart_sentry_turret_unit'
END

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_named1_sentry_turret'), ' #turretType=$Sentry #tier=$tierlevel_t2')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named1_sentry_turret_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named1_sentry_turret_unit', 10, 2048, @categoryFlag, @options, 1, 10, 1, 0, 100, 'def_named1_sentry_turret_desc', 1, 1, 2)
END
ELSE
BEGIN
	UPDATE entitydefaults SET quantity = 10, volume = 10 WHERE definitionname = 'def_named1_sentry_turret_unit'
END

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_named2_sentry_turret'), ' #turretType=$Sentry #tier=$tierlevel_t3')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named2_sentry_turret_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named2_sentry_turret_unit', 10, 2048, @categoryFlag, @options, 1, 10, 1, 0, 100, 'def_named2_sentry_turret_unit_desc', 1, 1, 3)
END
ELSE
BEGIN
	UPDATE entitydefaults SET quantity = 10, volume = 10 WHERE definitionname = 'def_named2_sentry_turret_unit'
END

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_named3_sentry_turret'), ' #turretType=$Sentry #tier=$tierlevel_t4')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named3_sentry_turret_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named3_sentry_turret_unit', 10, 2048, @categoryFlag, @options, 1, 10, 1, 0, 100, 'def_named3_sentry_turret_unit_desc', 1, 1, 4)
END
ELSE
BEGIN
	UPDATE entitydefaults SET quantity = 10, volume = 10 WHERE definitionname = 'def_named3_sentry_turret_unit'
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

---- Lifetime

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_lifetime')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300000)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 300000 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300000)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 300000 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300000)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 300000 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300000)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 300000 WHERE definition = @definition AND field = @field
END

---- Lifetime modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_lifetime_modifier')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 60000)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 60000 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 60000)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 60000 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 60000)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 60000 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 60000)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 60000 WHERE definition = @definition AND field = @field
END

---- Damage modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'damage_modifier')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 3.036)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 3.036 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 3.311)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 3.311 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 3.751)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 3.751 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 4 WHERE definition = @definition AND field = @field
END

---- Weapon cycle

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cycle_time')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1790)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1790 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1790)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1790 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2140)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2140 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2140)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2140 WHERE definition = @definition AND field = @field
END

---- Accuracy

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'accuracy')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 3.6)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 3.6 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4.2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 4.2 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 8.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 8.5 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 10.2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 10.2 WHERE definition = @definition AND field = @field
END

---- Optimal range

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 5 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 10)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 10 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 15)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 15 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 20)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 20 WHERE definition = @definition AND field = @field
END

---- Falloff

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'falloff')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 20)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 20 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 15)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 15 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 10)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 10 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_sentry_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 5 WHERE definition = @definition AND field = @field
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
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 100)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 100 WHERE definition = @definition AND field = @field
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

---- Set up aggregate fields for remote controllers

DECLARE @definition INT
DECLARE @field INT

---- Max bandwidth

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_bandwidth_max')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 5 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 5 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 5 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 5 WHERE definition = @definition AND field = @field
END

---- Accumulator usage

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_usage')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 150)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 150 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 135)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 135 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 165)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 165 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 180)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 180 WHERE definition = @definition AND field = @field
END

---- CPU usage

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_remote_controller')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 170)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 170 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 154)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 154 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 180)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 180 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 200)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 200 WHERE definition = @definition AND field = @field
END

---- Cycle time

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_remote_controller')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cycle_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 10000)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 3000 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 10000)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 3000 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 7500)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2500 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 5000)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2000 WHERE definition = @definition AND field = @field
END

---- Optimal range

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_remote_controller')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 20)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 20 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 20)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 20 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 25)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 25 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 30)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 30 WHERE definition = @definition AND field = @field
END

---- Reactor usage

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_remote_controller')
SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_usage')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 150)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 150 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 135)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 135 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 165)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 165 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 180)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 180 WHERE definition = @definition AND field = @field
END

---- Rcu Lifetime

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_lifetime')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300000)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 300000 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300000)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 300000 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300000)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 300000 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300000)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 300000 WHERE definition = @definition AND field = @field
END

---- Drones operational range

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_operational_range')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 30)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 30 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 30)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 30 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 30)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 30 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_remote_controller')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 30)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 30 WHERE definition = @definition AND field = @field
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
ELSE
BEGIN
	UPDATE entitydefaults SET options = '#slotFlags=4d3,6d0 #height=f2.00 #decay=n500', mass=78000  WHERE definitionname = 'def_spectator_chassis'
END

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_heavymech_head')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_spectator_head')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_spectator_head', 1, 1024, @category, '#slotFlags=4808,8,8,8,8,8  #height=f0.10', 1, 3, 3000, 1, 100, 'def_spectator_head_desc', 0, NULL, NULL)
END
ELSE
BEGIN
	UPDATE entitydefaults SET options = '#slotFlags=4808,8,8,8,8,8  #height=f0.10', mass=3000  WHERE definitionname = 'def_spectator_head'
END

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_heavymech_leg')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_spectator_leg')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_spectator_leg', 1, 1024, @category, '#slotFlags=420,20,20,20,20  #height=f1.10', 1, 20, 18000, 1, 100, 'def_spectator_leg_desc', 0, NULL, NULL)
END
ELSE
BEGIN
	UPDATE entitydefaults SET options = '#slotFlags=420,20,20,20,20  #height=f1.10', mass=18000  WHERE definitionname = 'def_spectator_leg'
END

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_robot_inventory')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_robot_inventory_spectator')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_robot_inventory_spectator', 1, 4195336, @category, '#capacity=f320.0', 1, 0, 0, 0, 100, 'def_robot_inventory_desc', 0, NULL, NULL)
END
ELSE
BEGIN
	UPDATE entitydefaults SET options = '#capacity=f320.0', mass=0  WHERE definitionname = 'def_robot_inventory_spectator'
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
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 30)
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
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 10000)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 10000 WHERE definition = @definition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 10000)
END
BEGIN
	UPDATE aggregatevalues SET value = 10000 WHERE definition = @definition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1000)
END
BEGIN
	UPDATE aggregatevalues SET value = 1000 WHERE definition = @definition AND field = @field
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

SET @extension = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname = 'ext_glider_specialist')

IF NOT EXISTS (SELECT 1 FROM enablerextensions WHERE definition = @definition AND extensionid = @extension)
BEGIN
	INSERT INTO enablerextensions (definition, extensionid, extensionlevel) VALUES
	(@definition, @extension, 1)
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
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 3.036 WHERE definition = @definitionId AND field = @fieldId
END

-- accuracy

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'accuracy')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 3.6)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 3.6 WHERE definition = @definitionId AND field = @fieldId
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
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1790 WHERE definition = @definitionId AND field = @fieldId
END

-- falloff

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'falloff')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 20)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 20 WHERE definition = @definitionId AND field = @fieldId
END

-- optimal_range

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 5 WHERE definition = @definitionId AND field = @fieldId
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
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 3.311 WHERE definition = @definitionId AND field = @fieldId
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
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1790 WHERE definition = @definitionId AND field = @fieldId
END

-- falloff

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'falloff')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 15)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 15 WHERE definition = @definitionId AND field = @fieldId
END

-- optimal_range

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 10)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 10 WHERE definition = @definitionId AND field = @fieldId
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
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 3.751 WHERE definition = @definitionId AND field = @fieldId
END

-- accuracy

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'accuracy')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 8.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 8.5 WHERE definition = @definitionId AND field = @fieldId
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
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2140 WHERE definition = @definitionId AND field = @fieldId
END

-- falloff

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'falloff')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 10)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 10 WHERE definition = @definitionId AND field = @fieldId
END

-- optimal_range

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 15)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 15 WHERE definition = @definitionId AND field = @fieldId
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
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 4 WHERE definition = @definitionId AND field = @fieldId
END

-- accuracy

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'accuracy')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 10.2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 10.2 WHERE definition = @definitionId AND field = @fieldId
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
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2140 WHERE definition = @definitionId AND field = @fieldId
END

-- falloff

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'falloff')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 5 WHERE definition = @definitionId AND field = @fieldId
END

-- optimal_range

SET @fieldId = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definitionId AND field = @fieldId)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definitionId, @fieldId, 20)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 20 WHERE definition = @definitionId AND field = @fieldId
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
ELSE
BEGIN
	UPDATE extensions SET rank=5, bonus=1, price=125000, freezelimit=7 WHERE extensionname = 'ext_remote_control'
END

IF NOT EXISTS (SELECT 1 FROM extensions WHERE extensionname = 'ext_sentry_turrets_experience')
BEGIN
	INSERT INTO extensions (extensionid, extensionname, category, rank, learningattributeprimary, bonus, note, price, active, description, targetpropertyID, effectenhancer, hidden, freezelimit) VALUES
	(367, 'ext_sentry_turrets_experience', @extensionsCategory, 5, 'attributeA', 0, 'Enabler for higher level sentry turrets', 125000, 1, 'ext_sentry_turrets_experience_desc', NULL, 0, 0, 4)
END
ELSE
BEGIN
	UPDATE extensions SET rank=5, bonus=0, price=125000, freezelimit=4 WHERE extensionname = 'ext_sentry_turrets_experience'
END

IF NOT EXISTS (SELECT 1 FROM extensions WHERE extensionname = 'ext_mining_turrets_experience')
BEGIN
	INSERT INTO extensions (extensionid, extensionname, category, rank, learningattributeprimary, bonus, note, price, active, description, targetpropertyID, effectenhancer, hidden, freezelimit) VALUES
	(368, 'ext_mining_turrets_experience', @extensionsCategory, 5, 'attributeA', 0, 'Enabler for higher level mining turrets', 125000, 1, 'ext_mining_turrets_experience_desc', NULL, 0, 0, 4)
END
ELSE
BEGIN
	UPDATE extensions SET rank=5, bonus=0, price=125000, freezelimit=4 WHERE extensionname = 'ext_mining_turrets_experience'
END

IF NOT EXISTS (SELECT 1 FROM extensions WHERE extensionname = 'ext_harvesting_turrets_experience')
BEGIN
	INSERT INTO extensions (extensionid, extensionname, category, rank, learningattributeprimary, bonus, note, price, active, description, targetpropertyID, effectenhancer, hidden, freezelimit) VALUES
	(369, 'ext_harvesting_turrets_experience', @extensionsCategory, 5, 'attributeA', 0, 'Enabler for higher level harvesting turrets', 125000, 1, 'ext_harvesting_turrets_experience_desc', NULL, 0, 0, 4)
END
ELSE
BEGIN
	UPDATE extensions SET rank=5, bonus=0, price=125000, freezelimit=4 WHERE extensionname = 'ext_harvesting_turrets_experience'
END

IF NOT EXISTS (SELECT 1 FROM extensions WHERE extensionname = 'ext_pelistal_combat_drones_experience')
BEGIN
	INSERT INTO extensions (extensionid, extensionname, category, rank, learningattributeprimary, bonus, note, price, active, description, targetpropertyID, effectenhancer, hidden, freezelimit) VALUES
	(370, 'ext_pelistal_combat_drones_experience', @extensionsCategory, 5, 'attributeA', 0, 'Enabler for higher level pelistal combat drones', 125000, 1, 'ext_pelistal_combat_drones_experience_desc', NULL, 0, 0, 4)
END
ELSE
BEGIN
	UPDATE extensions SET rank=5, bonus=0, price=125000, freezelimit=4 WHERE extensionname = 'ext_pelistal_combat_drones_experience'
END

IF NOT EXISTS (SELECT 1 FROM extensions WHERE extensionname = 'ext_nuimqol_combat_drones_experience')
BEGIN
	INSERT INTO extensions (extensionid, extensionname, category, rank, learningattributeprimary, bonus, note, price, active, description, targetpropertyID, effectenhancer, hidden, freezelimit) VALUES
	(371, 'ext_nuimqol_combat_drones_experience', @extensionsCategory, 5, 'attributeA', 0, 'Enabler for higher level nuimqol combat drones', 125000, 1, 'ext_nuimqol_combat_drones_experience_desc', NULL, 0, 0, 4)
END
ELSE
BEGIN
	UPDATE extensions SET rank=5, bonus=0, price=125000, freezelimit=4 WHERE extensionname = 'ext_nuimqol_combat_drones_experience'
END

IF NOT EXISTS (SELECT 1 FROM extensions WHERE extensionname = 'ext_thelodica_combat_drones_experience')
BEGIN
	INSERT INTO extensions (extensionid, extensionname, category, rank, learningattributeprimary, bonus, note, price, active, description, targetpropertyID, effectenhancer, hidden, freezelimit) VALUES
	(372, 'ext_thelodica_combat_drones_experience', @extensionsCategory, 5, 'attributeA', 0, 'Enabler for higher level thelodica combat drones', 125000, 1, 'ext_thelodica_combat_drones_experience_desc', NULL, 0, 0, 4)
END
ELSE
BEGIN
	UPDATE extensions SET rank=5, bonus=0, price=125000, freezelimit=4 WHERE extensionname = 'ext_thelodica_combat_drones_experience'
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_operational_range_modifier')

IF NOT EXISTS (SELECT 1 FROM extensions WHERE extensionname = 'ext_remote_control_long_range_drone_operations')
BEGIN
	INSERT INTO extensions (extensionid, extensionname, category, rank, learningattributeprimary, bonus, note, price, active, description, targetpropertyID, effectenhancer, hidden, freezelimit) VALUES
	(373, 'ext_remote_control_long_range_drone_operations', @extensionsCategory, 5, 'attributeA', 5, '', 125000, 1, 'ext_remote_control_long_range_drone_operations_desc', @field, 0, 0, 4)
END
ELSE
BEGIN
	UPDATE extensions SET rank=5, bonus=5, price=125000, freezelimit=4 WHERE extensionname = 'ext_remote_control_long_range_drone_operations'
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_lifetime_modifier')

IF NOT EXISTS (SELECT 1 FROM extensions WHERE extensionname = 'ext_remote_control_lifetime_management')
BEGIN
	INSERT INTO extensions (extensionid, extensionname, category, rank, learningattributeprimary, bonus, note, price, active, description, targetpropertyID, effectenhancer, hidden, freezelimit) VALUES
	(374, 'ext_remote_control_lifetime_management', @extensionsCategory, 5, 'attributeA', 60000, '', 125000, 1, 'ext_remote_control_lifetime_management_desc', @field, 0, 0, 4)
END
ELSE
BEGIN
	UPDATE extensions SET rank=5, bonus=60000, price=125000, freezelimit=4 WHERE extensionname = 'ext_remote_control_lifetime_management'
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

SET @base = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_lifetime')
SET @modifier = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_lifetime_modifier')

IF NOT EXISTS (SELECT 1 FROM [modulepropertymodifiers] WHERE categoryflags = @category AND baseField = @base AND modifierField = @modifier)
BEGIN
	INSERT INTO [modulepropertymodifiers] (categoryflags, baseField, modifierField) VALUES
	(@category, @base, @modifier)
END

SET @base = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_operational_range')
SET @modifier = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_operational_range_modifier')

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
	(33624586, 'cf_mining_turret_units', 'Mining turrets', 0, 0)
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
ELSE
BEGIN
	UPDATE entitydefaults SET attributeflags = 1024 WHERE definitionname = 'def_standart_mining_turret'
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named1_mining_turret')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named1_mining_turret', 1, 1024, @category, CONCAT('#head=n', @head, '  #chassis=n', @chassis, '  #leg=n', @leg, '  #inventory=n', @cargo), 1, 123, 0, 0, 100, 'def_named1_mining_turret_desc', 1, 1, 2)
END
ELSE
BEGIN
	UPDATE entitydefaults SET attributeflags = 1024 WHERE definitionname = 'def_named1_mining_turret'
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named2_mining_turret')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named2_mining_turret', 1, 1024, @category, CONCAT('#head=n', @head, '  #chassis=n', @chassis, '  #leg=n', @leg, '  #inventory=n', @cargo), 1, 123, 0, 0, 100, 'def_named2_mining_turret_desc', 1, 1, 3)
END
ELSE
BEGIN
	UPDATE entitydefaults SET attributeflags = 1024 WHERE definitionname = 'def_named2_mining_turret'
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named3_mining_turret')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named3_mining_turret', 1, 1024, @category, CONCAT('#head=n', @head, '  #chassis=n', @chassis, '  #leg=n', @leg, '  #inventory=n', @cargo), 1, 123, 0, 0, 100, 'def_named3_mining_turret_desc', 1, 1, 4)
END
ELSE
BEGIN
	UPDATE entitydefaults SET attributeflags = 1024 WHERE definitionname = 'def_named3_mining_turret'
END

GO

---- Create mining turrets as ammo 

DECLARE @categoryFlag INT
DECLARE @options VARCHAR(MAX)

SET @categoryFlag = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_mining_turret_units')

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_standart_mining_turret'), ' #turretType=$Mining #tier=$tierlevel_t1')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_mining_turret_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_mining_turret_unit', 10, 2048, @categoryFlag, @options, 1, 10, 1, 0, 100, 'def_standart_mining_turret_unit_desc', 1, 1, 1)
END
ELSE
BEGIN
	UPDATE entitydefaults SET quantity = 10, volume = 10 WHERE definitionname = 'def_standart_mining_turret_unit'
END

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_named1_mining_turret'), ' #turretType=$Mining #tier=$tierlevel_t2')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named1_mining_turret_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named1_mining_turret_unit', 10, 2048, @categoryFlag, @options, 1, 10, 1, 0, 100, 'def_named1_mining_turret_unit_desc', 1, 1, 2)
END
ELSE
BEGIN
	UPDATE entitydefaults SET quantity = 10, volume = 10 WHERE definitionname = 'def_named1_mining_turret_unit'
END

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_named2_mining_turret'), ' #turretType=$Mining #tier=$tierlevel_t3')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named2_mining_turret_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named2_mining_turret_unit', 10, 2048, @categoryFlag, @options, 1, 10, 1, 0, 100, 'def_named2_mining_turret_unit_desc', 1, 1, 3)
END
ELSE
BEGIN
	UPDATE entitydefaults SET quantity = 10, volume = 10 WHERE definitionname = 'def_named2_mining_turret_unit'
END

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_named3_mining_turret'), ' #turretType=$Mining #tier=$tierlevel_t4')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named3_mining_turret_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named3_mining_turret_unit', 10, 2048, @categoryFlag, @options, 1, 10, 1, 0, 100, 'def_named3_mining_turret_unit_desc', 1, 1, 4)
END
ELSE
BEGIN
	UPDATE entitydefaults SET quantity = 10, volume = 10 WHERE definitionname = 'def_named3_mining_turret_unit'
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

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_lifetime')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_mining_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300000)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 300000 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_mining_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300000)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 300000 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_mining_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300000)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 300000 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_mining_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300000)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 300000 WHERE definition = @definition AND field = @field
END

GO

---- Set up aggregate fields for mining turrets

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
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2.7951)
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
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 3.7268)
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
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4.0994)
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
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 5.12425)
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
	(50401802, 'cf_harvesting_turret_units', 'Harvesting turrets', 0, 0)
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
ELSE
BEGIN
	UPDATE entitydefaults SET attributeflags = 1024 WHERE definitionname = 'def_standart_harvesting_turret'
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named1_harvesting_turret')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named1_harvesting_turret', 1, 1024, @category, CONCAT('#head=n', @head, '  #chassis=n', @chassis, '  #leg=n', @leg, '  #inventory=n', @cargo), 1, 123, 0, 0, 100, 'def_named1_harvesting_turret_desc', 1, 1, 2)
END
ELSE
BEGIN
	UPDATE entitydefaults SET attributeflags = 1024 WHERE definitionname = 'def_named1_harvesting_turret'
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named2_harvesting_turret')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named2_harvesting_turret', 1, 1024, @category, CONCAT('#head=n', @head, '  #chassis=n', @chassis, '  #leg=n', @leg, '  #inventory=n', @cargo), 1, 123, 0, 0, 100, 'def_named2_harvesting_turret_desc', 1, 1, 3)
END
ELSE
BEGIN
	UPDATE entitydefaults SET attributeflags = 1024 WHERE definitionname = 'def_named2_harvesting_turret'
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named3_harvesting_turret')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named3_harvesting_turret', 1, 1024, @category, CONCAT('#head=n', @head, '  #chassis=n', @chassis, '  #leg=n', @leg, '  #inventory=n', @cargo), 1, 123, 0, 0, 100, 'def_named3_harvesting_turret_desc', 1, 1, 4)
END
ELSE
BEGIN
	UPDATE entitydefaults SET attributeflags = 1024, options = CONCAT('#head=n', @head, '  #chassis=n', @chassis, '  #leg=n', @leg, '  #inventory=n', @cargo) WHERE definitionname = 'def_named3_harvesting_turret'
END

GO

---- Create harvesting turrets as ammo 

DECLARE @categoryFlag INT
DECLARE @options VARCHAR(MAX)

SET @categoryFlag = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_harvesting_turret_units')

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_standart_harvesting_turret'), ' #turretType=$Harvesting #tier=$tierlevel_t1')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_harvesting_turret_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_harvesting_turret_unit', 10, 2048, @categoryFlag, @options, 1, 10, 1, 0, 100, 'def_standart_harvesting_turret_unit_desc', 1, 1, 1)
END
ELSE
BEGIN
	UPDATE entitydefaults SET quantity = 10, volume = 10 WHERE definitionname = 'def_standart_harvesting_turret_unit'
END

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_named1_harvesting_turret'), ' #turretType=$Harvesting #tier=$tierlevel_t2')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named1_harvesting_turret_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named1_harvesting_turret_unit', 10, 2048, @categoryFlag, @options, 1, 10, 1, 0, 100, 'def_named1_harvesting_turret_unit_desc', 1, 1, 2)
END
ELSE
BEGIN
	UPDATE entitydefaults SET quantity = 10, volume = 10 WHERE definitionname = 'def_named1_harvesting_turret_unit'
END

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_named2_harvesting_turret'), ' #turretType=$Harvesting #tier=$tierlevel_t3')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named2_harvesting_turret_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named2_harvesting_turret_unit', 10, 2048, @categoryFlag, @options, 1, 10, 1, 0, 100, 'def_named2_harvesting_turret_unit_desc', 1, 1, 3)
END
ELSE
BEGIN
	UPDATE entitydefaults SET quantity = 10, volume = 10 WHERE definitionname = 'def_named2_harvesting_turret_unit'
END

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_named3_harvesting_turret'), ' #turretType=$Harvesting #tier=$tierlevel_t4')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named3_harvesting_turret_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named3_harvesting_turret_unit', 10, 2048, @categoryFlag, @options, 1, 10, 1, 0, 100, 'def_named3_harvesting_turret_unit_desc', 1, 1, 4)
END
ELSE
BEGIN
	UPDATE entitydefaults SET quantity = 10, volume = 10 WHERE definitionname = 'def_named3_harvesting_turret_unit'
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

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_lifetime')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_harvesting_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300000)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 300000 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_harvesting_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300000)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 300000 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_harvesting_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300000)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 300000 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_harvesting_turret_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300000)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 300000 WHERE definition = @definition AND field = @field
END

GO

---- Set up aggregate fields for harvesting turrets

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
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2.99475)
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
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 3.993)
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
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4.3924)
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
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 5.4905)
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

---- Create category flags for combat drones

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_combat_drones' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(4242, 'cf_combat_drones', 'Combat Drones (deployed)', 1, 0)
END

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_remote_controlled_combat_drones' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(135690, 'cf_remote_controlled_combat_drones', 'Remote controlled combat drones', 0, 0)
END

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_pelistal_combat_drones_units' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(16912906, 'cf_pelistal_combat_drones_units', 'Remote controlled pelistal combat drones', 0, 0)
END

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_nuimqol_combat_drones_units' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(33690122, 'cf_nuimqol_combat_drones_units', 'Remote controlled nuimqol combat drones', 0, 0)
END

IF NOT EXISTS (SELECT 1 FROM categoryflags WHERE name = 'cf_thelodica_combat_drones_units' )
BEGIN
	INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
	(50467338, 'cf_thelodica_combat_drones_units', 'Remote controlled thelodica combat drones', 0, 0)
END

GO

---- Create entity defaults for pelistal combat drones

DECLARE @category INT

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_robot_chassis')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_pelistal_combat_drone_chassis')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_pelistal_combat_drone_chassis', 1, 1024, @category, '#height=f0.5#slotFlags=44d0,4d0,d2,d2,492', 1, 8, 13000, 1, 100, 'def_pelistal_combat_drone_chassis_desc', 0, NULL, NULL)
END

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_robot_head')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_pelistal_combat_drone_head')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_pelistal_combat_drone_head', 1, 1024, @category, '#height=f0.15#slotFlags=48,8,8,8', 1, 2, 600, 1, 100, 'def_pelistal_combat_drone_head_desc', 0, NULL, NULL)
END

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_robot_leg')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_pelistal_combat_drone_leg')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_pelistal_combat_drone_leg', 1, 1024, @category, '#slotFlags=420,20,20,20  #height=f0.30', 1, 10, 2250, 1, 100, 'def_pelistal_combat_drone_leg_desc', 0, NULL, NULL)
END

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_robot_inventory')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_pelistal_combat_drone_inventory')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_pelistal_combat_drone_inventory', 1, 4195336, @category, '#capacity=f15.0', 1, 0, 0, 0, 100, 'def_robot_inventory_desc', 0, NULL, NULL)
END

DECLARE @head INT
DECLARE @chassis INT
DECLARE @leg INT
DECLARE @cargo INT

SET @head = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_pelistal_combat_drone_head')
SET @chassis = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_pelistal_combat_drone_chassis')
SET @leg = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_pelistal_combat_drone_leg')
SET @cargo = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_pelistal_combat_drone_inventory')

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_combat_drones')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_pelistal_combat_drone')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_pelistal_combat_drone', 1, 1024, @category, CONCAT('#head=n', @head, '  #chassis=n', @chassis, '  #leg=n', @leg, '  #inventory=n', @cargo), 1, 123, 0, 0, 100, 'def_standart_pelistal_combat_drone_desc', 1, 1, 1)
END
ELSE
BEGIN
	UPDATE entitydefaults SET attributeflags = 1024 WHERE definitionname = 'def_standart_pelistal_combat_drone'
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named1_pelistal_combat_drone')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named1_pelistal_combat_drone', 1, 1024, @category, CONCAT('#head=n', @head, '  #chassis=n', @chassis, '  #leg=n', @leg, '  #inventory=n', @cargo), 1, 123, 0, 0, 100, 'def_named1_pelistal_combat_drone_desc', 1, 1, 2)
END
ELSE
BEGIN
	UPDATE entitydefaults SET attributeflags = 1024 WHERE definitionname = 'def_named1_pelistal_combat_drone'
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named2_pelistal_combat_drone')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named2_pelistal_combat_drone', 1, 1024, @category, CONCAT('#head=n', @head, '  #chassis=n', @chassis, '  #leg=n', @leg, '  #inventory=n', @cargo), 1, 123, 0, 0, 100, 'def_named2_pelistal_combat_drone_desc', 1, 1, 3)
END
ELSE
BEGIN
	UPDATE entitydefaults SET attributeflags = 1024 WHERE definitionname = 'def_named2_pelistal_combat_drone'
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named3_pelistal_combat_drone')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named3_pelistal_combat_drone', 1, 1024, @category, CONCAT('#head=n', @head, '  #chassis=n', @chassis, '  #leg=n', @leg, '  #inventory=n', @cargo), 1, 123, 0, 0, 100, 'def_named3_pelistal_combat_drone_desc', 1, 1, 4)
END
ELSE
BEGIN
	UPDATE entitydefaults SET attributeflags = 1024 WHERE definitionname = 'def_named3_pelistal_combat_drone'
END

GO

---- Create pelistal combat drones as ammo 

DECLARE @categoryFlag INT
DECLARE @options VARCHAR(MAX)

SET @categoryFlag = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_pelistal_combat_drones_units')

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_standart_pelistal_combat_drone'), ' #turretType=$CombatDrone #tier=$tierlevel_t1')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_pelistal_combat_drone_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_pelistal_combat_drone_unit', 10, 2048, @categoryFlag, @options, 1, 20, 1, 0, 100, 'def_standart_pelistal_combat_drone_desc', 1, 1, 1)
END
ELSE
BEGIN
	UPDATE entitydefaults SET quantity = 10, volume = 20 WHERE definitionname = 'def_standart_pelistal_combat_drone_unit'
END

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_named1_pelistal_combat_drone'), ' #turretType=$CombatDrone #tier=$tierlevel_t2')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named1_pelistal_combat_drone_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named1_pelistal_combat_drone_unit', 10, 2048, @categoryFlag, @options, 1, 20, 1, 0, 100, 'def_named1_pelistal_combat_drone_desc', 1, 1, 2)
END
ELSE
BEGIN
	UPDATE entitydefaults SET quantity = 10, volume = 20 WHERE definitionname = 'def_named1_pelistal_combat_drone_unit'
END

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_named2_pelistal_combat_drone'), ' #turretType=$CombatDrone #tier=$tierlevel_t3')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named2_pelistal_combat_drone_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named2_pelistal_combat_drone_unit', 10, 2048, @categoryFlag, @options, 1, 20, 1, 0, 100, 'def_named2_pelistal_combat_drone_unit_desc', 1, 1, 3)
END
ELSE
BEGIN
	UPDATE entitydefaults SET quantity = 10, volume = 20 WHERE definitionname = 'def_named2_pelistal_combat_drone_unit'
END

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_named3_pelistal_combat_drone'), ' #turretType=$CombatDrone #tier=$tierlevel_t4')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named3_pelistal_combat_drone_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named3_pelistal_combat_drone_unit', 10, 2048, @categoryFlag, @options, 1, 20, 1, 0, 100, 'def_named3_pelistal_combat_drone_unit_desc', 1, 1, 4)
END
ELSE
BEGIN
	UPDATE entitydefaults SET quantity = 10, volume = 20 WHERE definitionname = 'def_named3_pelistal_combat_drone_unit'
END

GO

---- Create pelistal combat drones templates

DECLARE @robot VARCHAR(MAX)
DECLARE @head VARCHAR(MAX)
DECLARE @chassis VARCHAR(MAX)
DECLARE @leg VARCHAR(MAX)
DECLARE @cargo VARCHAR(MAX)
DECLARE @ammo VARCHAR(MAX)
DECLARE @gunDefinitionId VARCHAR(MAX)
DECLARE @description VARCHAR(MAX)

SET @head = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_pelistal_combat_drone_head')
SET @chassis = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_pelistal_combat_drone_chassis')
SET @leg = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_pelistal_combat_drone_leg')
SET @cargo = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_pelistal_combat_drone_inventory')
SET @ammo = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_ammo_missile_b')
SET @gunDefinitionId = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_standard_missile_launcher')

-- T1

SET @robot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_pelistal_combat_drone')

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'standart_pelistal_combat_drone')
BEGIN
	SET @description = CONCAT('#robot=i', @robot, '#head=i', @head, '#chassis=i', @chassis, '#leg=i', @leg, '#container=i', @cargo, '#chassisModules=[|m0=[|definition=i', @gunDefinitionId, '|slot=i3|ammoDefinition=i', @ammo, '|ammoQuantity=i14]|m1=[|definition=i', @gunDefinitionId, '|slot=i4|ammoDefinition=i', @ammo, '|ammoQuantity=i14]|m3=[|definition=i', @gunDefinitionId, '|slot=i5|ammoDefinition=i', @ammo, '|ammoQuantity=i14]]')

	INSERT INTO robottemplates (name, description, note) VALUES
	('standart_pelistal_combat_drone', @description, 'Standart pelistal combat drone')
END

-- T2

SET @robot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_pelistal_combat_drone')

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'named1_pelistal_combat_drone')
BEGIN
	SET @description = CONCAT('#robot=i', @robot, '#head=i', @head, '#chassis=i', @chassis, '#leg=i', @leg, '#container=i', @cargo, '#chassisModules=[|m0=[|definition=i', @gunDefinitionId, '|slot=i3|ammoDefinition=i', @ammo, '|ammoQuantity=i14]|m1=[|definition=i', @gunDefinitionId, '|slot=i4|ammoDefinition=i', @ammo, '|ammoQuantity=i14]|m3=[|definition=i', @gunDefinitionId, '|slot=i5|ammoDefinition=i', @ammo, '|ammoQuantity=i14]]')

	INSERT INTO robottemplates (name, description, note) VALUES
	('named1_pelistal_combat_drone', @description, 'T2 pelistal combat drone')
END

-- T3

SET @robot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_pelistal_combat_drone')

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'named2_pelistal_combat_drone')
BEGIN
	SET @description = CONCAT('#robot=i', @robot, '#head=i', @head, '#chassis=i', @chassis, '#leg=i', @leg, '#container=i', @cargo, '#chassisModules=[|m0=[|definition=i', @gunDefinitionId, '|slot=i3|ammoDefinition=i', @ammo, '|ammoQuantity=i14]|m1=[|definition=i', @gunDefinitionId, '|slot=i4|ammoDefinition=i', @ammo, '|ammoQuantity=i14]|m3=[|definition=i', @gunDefinitionId, '|slot=i5|ammoDefinition=i', @ammo, '|ammoQuantity=i14]]')

	INSERT INTO robottemplates (name, description, note) VALUES
	('named2_pelistal_combat_drone', @description, 'T3 pelistal combat drone')
END

-- T4

SET @robot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_pelistal_combat_drone')

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'named3_pelistal_combat_drone')
BEGIN
	SET @description = CONCAT('#robot=i', @robot, '#head=i', @head, '#chassis=i', @chassis, '#leg=i', @leg, '#container=i', @cargo, '#chassisModules=[|m0=[|definition=i', @gunDefinitionId, '|slot=i3|ammoDefinition=i', @ammo, '|ammoQuantity=i14]|m1=[|definition=i', @gunDefinitionId, '|slot=i4|ammoDefinition=i', @ammo, '|ammoQuantity=i14]|m3=[|definition=i', @gunDefinitionId, '|slot=i5|ammoDefinition=i', @ammo, '|ammoQuantity=i14]]')

	INSERT INTO robottemplates (name, description, note) VALUES
	('named3_pelistal_combat_drone', @description, 'T4 pelistal combat drone')
END

GO

---- Link pelistal combat drones with their templates

DECLARE @turret_def INT
DECLARE @turret_template INT

SET @turret_def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_pelistal_combat_drone')
SET @turret_template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'standart_pelistal_combat_drone')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @turret_def AND templateid = @turret_template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@turret_def, @turret_template, 0, 0, 'Standart pelistal combat drone')
END

SET @turret_def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_pelistal_combat_drone')
SET @turret_template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'named1_pelistal_combat_drone')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @turret_def AND templateid = @turret_template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@turret_def, @turret_template, 0, 0, 'T2 pelistal combat drone')
END

SET @turret_def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_pelistal_combat_drone')
SET @turret_template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'named2_pelistal_combat_drone')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @turret_def AND templateid = @turret_template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@turret_def, @turret_template, 0, 0, 'T3 pelistal combat drone')
END

SET @turret_def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_pelistal_combat_drone')
SET @turret_template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'named3_pelistal_combat_drone')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @turret_def AND templateid = @turret_template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@turret_def, @turret_template, 0, 0, 'T4 pelistal combat drone')
END

GO

---- Set up aggregate fields for pelistal combat drones as ammo

DECLARE @definition INT
DECLARE @field INT

---- Bandwidth usage

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_bandwidth_usage')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_pelistal_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 5)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_pelistal_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 5)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_pelistal_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 5)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_pelistal_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 5)
END

---- Despawn time

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_lifetime')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_pelistal_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300000)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 300000 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_pelistal_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300000)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 300000 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_pelistal_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300000)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 300000 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_pelistal_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300000)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 300000 WHERE definition = @definition AND field = @field
END

---- Damage

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'damage_modifier')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_pelistal_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.843)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.843 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_pelistal_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.935)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.935 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_pelistal_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1.87)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.87 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_pelistal_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2.053)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2.053 WHERE definition = @definition AND field = @field
END

---- Cycle

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'missile_cycle_time_modifier')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_pelistal_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.29)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.29 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_pelistal_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.29)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.29 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_pelistal_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.62)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.62 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_pelistal_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.62)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.62 WHERE definition = @definition AND field = @field
END

---- Explosion radius

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'explosion_radius_modifier')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_pelistal_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.7)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.7 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_pelistal_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.7)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.7 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_pelistal_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.6)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.6 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_pelistal_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.6)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.6 WHERE definition = @definition AND field = @field
END

GO

---- Set up aggregate fields for pelistal combat drones

DECLARE @definition INT
DECLARE @field INT

--head

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_pelistal_combat_drone_head')

---- CPU max

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 495)
END

---- Locked targets max

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locked_targets_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 7)
END

---- Locking range

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 30)
END

---- Locking time

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 12500)
END

---- Sensor strength

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'sensor_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 100)
END

---- Blob emission

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 7)
END

---- Blob emission radius

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission_radius')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 20)
END

---- Blob level low

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_level_low')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 105)
END

---- Blob level high

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_level_high')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 375)
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

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_pelistal_combat_drone_chassis')

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
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2800)
END

---- Core recharge time

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 480)
END

---- Powergrid max

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 950)
END

---- Resists

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_chemical')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 30)
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
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 10)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_thermal')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 150)
END

---- Signature radius

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 10)
END

---- Missile miss

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'missile_miss')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.9)
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

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_pelistal_combat_drone_leg')

---- Slope

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'slope')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 6)
END

---- Speed max

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'speed_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2.6)
END

-- Standart Pelistal combat drone

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_pelistal_combat_drone')

---- Locking range modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

-- damage modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'damage_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.843)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.843 WHERE definition = @definition AND field = @field
END

-- explosion radius modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'explosion_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.7)
END

-- missile cycle time modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'missile_cycle_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.29)
END

---- Armor max modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1.292)
END

---- Signature radius modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

---- Locking time modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.22)
END

---- T2 pelistal combat drone ----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_pelistal_combat_drone')

---- Locking range modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

-- damage modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'damage_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.935)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.935 WHERE definition = @definition AND field = @field
END

-- explosion radius modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'explosion_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.7)
END

-- missile cycle time modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'missile_cycle_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.29)
END

---- Armor max modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1.938)
END

---- Signature radius modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4.75)
END

---- Locking time modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.22)
END

---- T3 pelistal combat drone ----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_pelistal_combat_drone')

---- Locking range modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

-- damage modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'damage_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1.87)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.87 WHERE definition = @definition AND field = @field
END

-- explosion radius modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'explosion_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.6)
END

-- missile cycle time modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'missile_cycle_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.62)
END

---- Armor max modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4.76)
END

---- Signature radius modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 8.25)
END

---- Locking time modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.22)
END

---- T4 pelistal combat drone ----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_pelistal_combat_drone')

---- Locking range modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

-- damage modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'damage_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2.053)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2.053 WHERE definition = @definition AND field = @field
END

-- explosion radius modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'explosion_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.6)
END

-- missile cycle time modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'missile_cycle_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.62)
END

---- Armor max modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 6.8)
END

---- Signature radius modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 18)
END

---- Locking time modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.22)
END

GO

---- Add enabler extensions for pelistal combat drones

DECLARE @definition INT
DECLARE @extension INT

SET @extension = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname = 'ext_pelistal_combat_drones_experience')

-- standart

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_pelistal_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM enablerextensions WHERE definition = @definition AND extensionid = @extension)
BEGIN
	INSERT INTO enablerextensions (definition, extensionid, extensionlevel) VALUES
	(@definition, @extension, 2)
END

-- T2

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_pelistal_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM enablerextensions WHERE definition = @definition AND extensionid = @extension)
BEGIN
	INSERT INTO enablerextensions (definition, extensionid, extensionlevel) VALUES
	(@definition, @extension, 4)
END

-- T3

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_pelistal_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM enablerextensions WHERE definition = @definition AND extensionid = @extension)
BEGIN
	INSERT INTO enablerextensions (definition, extensionid, extensionlevel) VALUES
	(@definition, @extension, 6)
END

-- T4

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_pelistal_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM enablerextensions WHERE definition = @definition AND extensionid = @extension)
BEGIN
	INSERT INTO enablerextensions (definition, extensionid, extensionlevel) VALUES
	(@definition, @extension, 8)
END

GO

--------------

---- Create entity defaults for nuimqol combat drones

DECLARE @category INT

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_robot_chassis')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_nuimqol_combat_drone_chassis')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_nuimqol_combat_drone_chassis', 1, 1024, @category, '#height=f0.45#slotFlags=44d1,4d1,d1', 1, 8, 13000, 1, 100, 'def_nuimqol_combat_drone_chassis_desc', 0, NULL, NULL)
END

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_robot_head')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_nuimqol_combat_drone_head')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_nuimqol_combat_drone_head', 1, 1024, @category, '#height=f0.15#slotFlags=48,8,8,8,8,8', 1, 2, 600, 1, 100, 'def_nuimqol_combat_drone_head_desc', 0, NULL, NULL)
END

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_robot_leg')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_nuimqol_combat_drone_leg')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_nuimqol_combat_drone_leg', 1, 1024, @category, '#height=f1.25#slotFlags=420,20,20,20', 1, 10, 2250, 1, 100, 'def_nuimqol_combat_drone_leg_desc', 0, NULL, NULL)
END

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_robot_inventory')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_nuimqol_combat_drone_inventory')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_nuimqol_combat_drone_inventory', 1, 4195336, @category, '#capacity=f15.0', 1, 0, 0, 0, 100, 'def_robot_inventory_desc', 0, NULL, NULL)
END

DECLARE @head INT
DECLARE @chassis INT
DECLARE @leg INT
DECLARE @cargo INT

SET @head = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_nuimqol_combat_drone_head')
SET @chassis = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_nuimqol_combat_drone_chassis')
SET @leg = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_nuimqol_combat_drone_leg')
SET @cargo = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_nuimqol_combat_drone_inventory')

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_combat_drones')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_nuimqol_combat_drone')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_nuimqol_combat_drone', 1, 1024, @category, CONCAT('#head=n', @head, '  #chassis=n', @chassis, '  #leg=n', @leg, '  #inventory=n', @cargo), 1, 123, 0, 0, 100, 'def_standart_nuimqol_combat_drone_desc', 1, 1, 1)
END
ELSE
BEGIN
	UPDATE entitydefaults SET attributeflags = 1024 WHERE definitionname = 'def_standart_nuimqol_combat_drone'
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named1_nuimqol_combat_drone')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named1_nuimqol_combat_drone', 1, 1024, @category, CONCAT('#head=n', @head, '  #chassis=n', @chassis, '  #leg=n', @leg, '  #inventory=n', @cargo), 1, 123, 0, 0, 100, 'def_named1_nuimqol_combat_drone_desc', 1, 1, 2)
END
ELSE
BEGIN
	UPDATE entitydefaults SET attributeflags = 1024 WHERE definitionname = 'def_named1_nuimqol_combat_drone'
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named2_nuimqol_combat_drone')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named2_nuimqol_combat_drone', 1, 1024, @category, CONCAT('#head=n', @head, '  #chassis=n', @chassis, '  #leg=n', @leg, '  #inventory=n', @cargo), 1, 123, 0, 0, 100, 'def_named2_nuimqol_combat_drone_desc', 1, 1, 3)
END
ELSE
BEGIN
	UPDATE entitydefaults SET attributeflags = 1024 WHERE definitionname = 'def_named2_nuimqol_combat_drone'
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named3_nuimqol_combat_drone')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named3_nuimqol_combat_drone', 1, 1024, @category, CONCAT('#head=n', @head, '  #chassis=n', @chassis, '  #leg=n', @leg, '  #inventory=n', @cargo), 1, 123, 0, 0, 100, 'def_named3_nuimqol_combat_drone_desc', 1, 1, 4)
END
ELSE
BEGIN
	UPDATE entitydefaults SET attributeflags = 1024 WHERE definitionname = 'def_named3_nuimqol_combat_drone'
END

GO

---- Create nuimqol combat drones as ammo 

DECLARE @categoryFlag INT
DECLARE @options VARCHAR(MAX)

SET @categoryFlag = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_nuimqol_combat_drones_units')

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_standart_nuimqol_combat_drone'), ' #turretType=$CombatDrone #tier=$tierlevel_t1')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_nuimqol_combat_drone_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_nuimqol_combat_drone_unit', 10, 2048, @categoryFlag, @options, 1, 20, 1, 0, 100, 'def_standart_nuimqol_combat_drone_desc', 1, 1, 1)
END
ELSE
BEGIN
	UPDATE entitydefaults SET quantity = 10, volume = 20 WHERE definitionname = 'def_standart_nuimqol_combat_drone_unit'
END

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_named1_nuimqol_combat_drone'), ' #turretType=$CombatDrone #tier=$tierlevel_t2')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named1_nuimqol_combat_drone_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named1_nuimqol_combat_drone_unit', 10, 2048, @categoryFlag, @options, 1, 20, 1, 0, 100, 'def_named1_nuimqol_combat_drone_desc', 1, 1, 2)
END
ELSE
BEGIN
	UPDATE entitydefaults SET quantity = 10, volume = 20 WHERE definitionname = 'def_named1_nuimqol_combat_drone_unit'
END

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_named2_nuimqol_combat_drone'), ' #turretType=$CombatDrone #tier=$tierlevel_t3')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named2_nuimqol_combat_drone_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named2_nuimqol_combat_drone_unit', 10, 2048, @categoryFlag, @options, 1, 20, 1, 0, 100, 'def_named2_nuimqol_combat_drone_unit_desc', 1, 1, 3)
END
ELSE
BEGIN
	UPDATE entitydefaults SET quantity = 10, volume = 20 WHERE definitionname = 'def_named2_nuimqol_combat_drone_unit'
END

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_named3_nuimqol_combat_drone'), ' #turretType=$CombatDrone #tier=$tierlevel_t4')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named3_nuimqol_combat_drone_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named3_nuimqol_combat_drone_unit', 10, 2048, @categoryFlag, @options, 1, 20, 1, 0, 100, 'def_named3_nuimqol_combat_drone_unit_desc', 1, 1, 4)
END
ELSE
BEGIN
	UPDATE entitydefaults SET quantity = 10, volume = 20 WHERE definitionname = 'def_named3_nuimqol_combat_drone_unit'
END

GO

---- Create nuimqol combat drones templates

DECLARE @robot VARCHAR(MAX)
DECLARE @head VARCHAR(MAX)
DECLARE @chassis VARCHAR(MAX)
DECLARE @leg VARCHAR(MAX)
DECLARE @cargo VARCHAR(MAX)
DECLARE @ammo VARCHAR(MAX)
DECLARE @gunDefinitionId VARCHAR(MAX)
DECLARE @description VARCHAR(MAX)

SET @head = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_nuimqol_combat_drone_head')
SET @chassis = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_nuimqol_combat_drone_chassis')
SET @leg = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_nuimqol_combat_drone_leg')
SET @cargo = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_nuimqol_combat_drone_inventory')
SET @ammo = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_ammo_medium_railgun_b')
SET @gunDefinitionId = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_standard_medium_railgun')

-- T1

SET @robot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_nuimqol_combat_drone')

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'standart_nuimqol_combat_drone')
BEGIN
	SET @description = CONCAT('#robot=i', @robot, '#head=i', @head, '#chassis=i', @chassis, '#leg=i', @leg, '#container=i', @cargo, '#chassisModules=[|m0=[|definition=i', @gunDefinitionId, '|slot=i1|ammoDefinition=i', @ammo, '|ammoQuantity=i32]|m1=[|definition=i', @gunDefinitionId, '|slot=i2|ammoDefinition=i', @ammo, '|ammoQuantity=i32]|m2=[|definition=i', @gunDefinitionId, '|slot=i3|ammoDefinition=i', @ammo, '|ammoQuantity=i32]]')

	INSERT INTO robottemplates (name, description, note) VALUES
	('standart_nuimqol_combat_drone', @description, 'Standart nuimqol combat drone')
END

-- T2

SET @robot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_nuimqol_combat_drone')

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'named1_nuimqol_combat_drone')
BEGIN
	SET @description = CONCAT('#robot=i', @robot, '#head=i', @head, '#chassis=i', @chassis, '#leg=i', @leg, '#container=i', @cargo, '#chassisModules=[|m0=[|definition=i', @gunDefinitionId, '|slot=i1|ammoDefinition=i', @ammo, '|ammoQuantity=i32]|m1=[|definition=i', @gunDefinitionId, '|slot=i2|ammoDefinition=i', @ammo, '|ammoQuantity=i32]|m2=[|definition=i', @gunDefinitionId, '|slot=i3|ammoDefinition=i', @ammo, '|ammoQuantity=i32]]')

	INSERT INTO robottemplates (name, description, note) VALUES
	('named1_nuimqol_combat_drone', @description, 'T2 nuimqol combat drone')
END

-- T3

SET @robot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_nuimqol_combat_drone')

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'named2_nuimqol_combat_drone')
BEGIN
	SET @description = CONCAT('#robot=i', @robot, '#head=i', @head, '#chassis=i', @chassis, '#leg=i', @leg, '#container=i', @cargo, '#chassisModules=[|m0=[|definition=i', @gunDefinitionId, '|slot=i1|ammoDefinition=i', @ammo, '|ammoQuantity=i32]|m1=[|definition=i', @gunDefinitionId, '|slot=i2|ammoDefinition=i', @ammo, '|ammoQuantity=i32]|m2=[|definition=i', @gunDefinitionId, '|slot=i3|ammoDefinition=i', @ammo, '|ammoQuantity=i32]]')

	INSERT INTO robottemplates (name, description, note) VALUES
	('named2_nuimqol_combat_drone', @description, 'T3 nuimqol combat drone')
END

-- T4

SET @robot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_nuimqol_combat_drone')

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'named3_nuimqol_combat_drone')
BEGIN
	SET @description = CONCAT('#robot=i', @robot, '#head=i', @head, '#chassis=i', @chassis, '#leg=i', @leg, '#container=i', @cargo, '#chassisModules=[|m0=[|definition=i', @gunDefinitionId, '|slot=i1|ammoDefinition=i', @ammo, '|ammoQuantity=i32]|m1=[|definition=i', @gunDefinitionId, '|slot=i2|ammoDefinition=i', @ammo, '|ammoQuantity=i32]|m2=[|definition=i', @gunDefinitionId, '|slot=i3|ammoDefinition=i', @ammo, '|ammoQuantity=i32]]')

	INSERT INTO robottemplates (name, description, note) VALUES
	('named3_nuimqol_combat_drone', @description, 'T4 nuimqol combat drone')
END

GO

---- Link nuimqol combat drones with their templates

DECLARE @turret_def INT
DECLARE @turret_template INT

SET @turret_def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_nuimqol_combat_drone')
SET @turret_template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'standart_nuimqol_combat_drone')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @turret_def AND templateid = @turret_template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@turret_def, @turret_template, 0, 0, 'Standart nuimqol combat drone')
END

SET @turret_def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_nuimqol_combat_drone')
SET @turret_template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'named1_nuimqol_combat_drone')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @turret_def AND templateid = @turret_template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@turret_def, @turret_template, 0, 0, 'T2 nuimqol combat drone')
END

SET @turret_def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_nuimqol_combat_drone')
SET @turret_template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'named2_nuimqol_combat_drone')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @turret_def AND templateid = @turret_template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@turret_def, @turret_template, 0, 0, 'T3 nuimqol combat drone')
END

SET @turret_def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_nuimqol_combat_drone')
SET @turret_template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'named3_nuimqol_combat_drone')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @turret_def AND templateid = @turret_template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@turret_def, @turret_template, 0, 0, 'T4 nuimqol combat drone')
END

GO

---- Set up aggregate fields for nuimqol combat drones as ammo

DECLARE @definition INT
DECLARE @field INT

---- Bandwidth usage

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_bandwidth_usage')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_nuimqol_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 5)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_nuimqol_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 5)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_nuimqol_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 5)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_nuimqol_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 5)
END

---- Despawn time

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_lifetime')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_nuimqol_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300000)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 300000 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_nuimqol_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300000)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 300000 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_nuimqol_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300000)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 300000 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_nuimqol_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300000)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 300000 WHERE definition = @definition AND field = @field
END

---- Damage

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'damage_modifier')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_nuimqol_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1.41167)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.41167 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_nuimqol_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1.503)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.503 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_nuimqol_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4.3267)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 4.3267 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_nuimqol_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4.51)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 4.51 WHERE definition = @definition AND field = @field
END

---- Cycle

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'turret_cycle_time_modifier')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_nuimqol_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.858)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.858 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_nuimqol_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.858)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.858 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_nuimqol_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.95)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.95 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_nuimqol_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.95)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.95 WHERE definition = @definition AND field = @field
END

---- Accuracy

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'accuracy_modifier')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_nuimqol_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.7)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.7 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_nuimqol_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.7)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.7 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_nuimqol_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.6)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.6 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_nuimqol_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.6)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.6 WHERE definition = @definition AND field = @field
END

GO

---- Set up aggregate fields for nuimqol combat drones

DECLARE @definition INT
DECLARE @field INT

--head

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_nuimqol_combat_drone_head')

---- CPU max

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 450)
END

---- Locked targets max

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locked_targets_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 7)
END

---- Locking range

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 35)
END

---- Locking time

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 12500)
END

---- Sensor strength

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'sensor_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 125)
END

---- Blob emission

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 7)
END

---- Blob emission radius

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission_radius')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 20)
END

---- Blob level low

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_level_low')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 105)
END

---- Blob level high

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_level_high')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 375)
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

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_nuimqol_combat_drone_chassis')

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
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1170)
END

---- Core max

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2400)
END

---- Core recharge time

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 360)
END

---- Powergrid max

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 600)
END

---- Resists

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_chemical')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 30)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_explosive')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 150)
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
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 10)
END

---- Signature radius

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 10)
END

---- Missile miss

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'missile_miss')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.9)
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

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_nuimqol_combat_drone_leg')

---- Slope

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'slope')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 6)
END

---- Speed max

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'speed_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2.6)
END

-- Standart nuimqol combat drone

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_nuimqol_combat_drone')

---- Locking range modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

-- damage modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'damage_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1.41167)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.41167 WHERE definition = @definition AND field = @field
END

-- accuracy modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'accuracy_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.7)
END

-- turret cycle time modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'turret_cycle_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.858)
END

---- Armor max modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1.156)
END

---- Signature radius modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

---- Locking time modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.22)
END

---- T2 nuimqol combat drone ----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_nuimqol_combat_drone')

---- Locking range modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

-- damage modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'damage_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1.503)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.503 WHERE definition = @definition AND field = @field
END

-- accuracy modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'accuracy_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.7)
END

-- turret cycle time modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'turret_cycle_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.858)
END

---- Armor max modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1.7)
END

---- Signature radius modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4.75)
END

---- Locking time modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.22)
END

---- T3 nuimqol combat drone ----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_nuimqol_combat_drone')

---- Locking range modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

-- damage modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'damage_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4.3267)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 4.3267 WHERE definition = @definition AND field = @field
END

-- accuracy modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'accuracy_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.6)
END

-- turret cycle time modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'turret_cycle_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.95)
END

---- Armor max modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4.284)
END

---- Signature radius modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 8.25)
END

---- Locking time modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.22)
END

---- T4 nuimqol combat drone ----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_nuimqol_combat_drone')

---- Locking range modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

-- damage modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'damage_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4.51)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 4.51 WHERE definition = @definition AND field = @field
END

-- accuracy modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'accuracy_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.6)
END

-- turret cycle time modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'turret_cycle_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.95)
END

---- Armor max modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 6.12)
END

---- Signature radius modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 18)
END

---- Locking time modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.22)
END

GO

---- Add enabler extensions for nuimqol combat drones

DECLARE @definition INT
DECLARE @extension INT

SET @extension = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname = 'ext_nuimqol_combat_drones_experience')

-- standart

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_nuimqol_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM enablerextensions WHERE definition = @definition AND extensionid = @extension)
BEGIN
	INSERT INTO enablerextensions (definition, extensionid, extensionlevel) VALUES
	(@definition, @extension, 2)
END

-- T2

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_nuimqol_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM enablerextensions WHERE definition = @definition AND extensionid = @extension)
BEGIN
	INSERT INTO enablerextensions (definition, extensionid, extensionlevel) VALUES
	(@definition, @extension, 4)
END

-- T3

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_nuimqol_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM enablerextensions WHERE definition = @definition AND extensionid = @extension)
BEGIN
	INSERT INTO enablerextensions (definition, extensionid, extensionlevel) VALUES
	(@definition, @extension, 6)
END

-- T4

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_nuimqol_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM enablerextensions WHERE definition = @definition AND extensionid = @extension)
BEGIN
	INSERT INTO enablerextensions (definition, extensionid, extensionlevel) VALUES
	(@definition, @extension, 8)
END

GO

--------------

---- Create entity defaults for thelodica combat drones

DECLARE @category INT

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_robot_chassis')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_thelodica_combat_drone_chassis')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_thelodica_combat_drone_chassis', 1, 1024, @category, '#height=f0.5#slotFlags=44d1,4d1,d1', 1, 8, 13000, 1, 100, 'def_thelodica_combat_drone_chassis_desc', 0, NULL, NULL)
END

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_robot_head')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_thelodica_combat_drone_head')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_thelodica_combat_drone_head', 1, 1024, @category, '#height=f0.15#slotFlags=48,8,8,8,8,8', 1, 2, 600, 1, 100, 'def_thelodica_combat_drone_head_desc', 0, NULL, NULL)
END

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_robot_leg')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_thelodica_combat_drone_leg')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_thelodica_combat_drone_leg', 1, 1024, @category, '#height=f1#slotFlags=420,20,20,20', 1, 10, 2250, 1, 100, 'def_thelodica_combat_drone_leg_desc', 0, NULL, NULL)
END

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_robot_inventory')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_thelodica_combat_drone_inventory')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_thelodica_combat_drone_inventory', 1, 4195336, @category, '#capacity=f15.0', 1, 0, 0, 0, 100, 'def_robot_inventory_desc', 0, NULL, NULL)
END

DECLARE @head INT
DECLARE @chassis INT
DECLARE @leg INT
DECLARE @cargo INT

SET @head = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_thelodica_combat_drone_head')
SET @chassis = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_thelodica_combat_drone_chassis')
SET @leg = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_thelodica_combat_drone_leg')
SET @cargo = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_thelodica_combat_drone_inventory')

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_combat_drones')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_thelodica_combat_drone')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_thelodica_combat_drone', 1, 1024, @category, CONCAT('#head=n', @head, '  #chassis=n', @chassis, '  #leg=n', @leg, '  #inventory=n', @cargo), 1, 123, 0, 0, 100, 'def_standart_thelodica_combat_drone_desc', 1, 1, 1)
END
ELSE
BEGIN
	UPDATE entitydefaults SET attributeflags = 1024 WHERE definitionname = 'def_standart_thelodica_combat_drone'
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named1_thelodica_combat_drone')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named1_thelodica_combat_drone', 1, 1024, @category, CONCAT('#head=n', @head, '  #chassis=n', @chassis, '  #leg=n', @leg, '  #inventory=n', @cargo), 1, 123, 0, 0, 100, 'def_named1_thelodica_combat_drone_desc', 1, 1, 2)
END
ELSE
BEGIN
	UPDATE entitydefaults SET attributeflags = 1024 WHERE definitionname = 'def_named1_thelodica_combat_drone'
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named2_thelodica_combat_drone')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named2_thelodica_combat_drone', 1, 1024, @category, CONCAT('#head=n', @head, '  #chassis=n', @chassis, '  #leg=n', @leg, '  #inventory=n', @cargo), 1, 123, 0, 0, 100, 'def_named2_thelodica_combat_drone_desc', 1, 1, 3)
END
ELSE
BEGIN
	UPDATE entitydefaults SET attributeflags = 1024 WHERE definitionname = 'def_named2_thelodica_combat_drone'
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named3_thelodica_combat_drone')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named3_thelodica_combat_drone', 1, 1024, @category, CONCAT('#head=n', @head, '  #chassis=n', @chassis, '  #leg=n', @leg, '  #inventory=n', @cargo), 1, 123, 0, 0, 100, 'def_named3_thelodica_combat_drone_desc', 1, 1, 4)
END
ELSE
BEGIN
	UPDATE entitydefaults SET attributeflags = 1024 WHERE definitionname = 'def_named3_thelodica_combat_drone'
END

GO

---- Create thelodica combat drones as ammo 

DECLARE @categoryFlag INT
DECLARE @options VARCHAR(MAX)

SET @categoryFlag = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_thelodica_combat_drones_units')

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_standart_thelodica_combat_drone'), ' #turretType=$CombatDrone #tier=$tierlevel_t1')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_thelodica_combat_drone_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_thelodica_combat_drone_unit', 10, 2048, @categoryFlag, @options, 1, 20, 1, 0, 100, 'def_standart_thelodica_combat_drone_desc', 1, 1, 1)
END
ELSE
BEGIN
	UPDATE entitydefaults SET quantity = 10, volume = 20 WHERE definitionname = 'def_standart_thelodica_combat_drone_unit'
END

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_named1_thelodica_combat_drone'), ' #turretType=$CombatDrone #tier=$tierlevel_t2')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named1_thelodica_combat_drone_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named1_thelodica_combat_drone_unit', 10, 2048, @categoryFlag, @options, 1, 20, 1, 0, 100, 'def_named1_thelodica_combat_drone_desc', 1, 1, 2)
END
ELSE
BEGIN
	UPDATE entitydefaults SET quantity = 10, volume = 20 WHERE definitionname = 'def_named1_thelodica_combat_drone_unit'
END

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_named2_thelodica_combat_drone'), ' #turretType=$CombatDrone #tier=$tierlevel_t3')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named2_thelodica_combat_drone_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named2_thelodica_combat_drone_unit', 10, 2048, @categoryFlag, @options, 1, 20, 1, 0, 100, 'def_named2_thelodica_combat_drone_unit_desc', 1, 1, 3)
END
ELSE
BEGIN
	UPDATE entitydefaults SET quantity = 10, volume = 20 WHERE definitionname = 'def_named2_thelodica_combat_drone_unit'
END

SET @options = CONCAT('#turretId=i', (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_named3_thelodica_combat_drone'), ' #turretType=$CombatDrone #tier=$tierlevel_t4')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named3_thelodica_combat_drone_unit')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named3_thelodica_combat_drone_unit', 10, 2048, @categoryFlag, @options, 1, 20, 1, 0, 100, 'def_named3_thelodica_combat_drone_unit_desc', 1, 1, 4)
END
ELSE
BEGIN
	UPDATE entitydefaults SET quantity = 10, volume = 20 WHERE definitionname = 'def_named3_thelodica_combat_drone_unit'
END

GO

---- Create thelodica combat drones templates

DECLARE @robot VARCHAR(MAX)
DECLARE @head VARCHAR(MAX)
DECLARE @chassis VARCHAR(MAX)
DECLARE @leg VARCHAR(MAX)
DECLARE @cargo VARCHAR(MAX)
DECLARE @ammo VARCHAR(MAX)
DECLARE @gunDefinitionId VARCHAR(MAX)
DECLARE @description VARCHAR(MAX)

SET @head = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_thelodica_combat_drone_head')
SET @chassis = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_thelodica_combat_drone_chassis')
SET @leg = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_thelodica_combat_drone_leg')
SET @cargo = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_thelodica_combat_drone_inventory')
SET @ammo = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_ammo_medium_lasercrystal_a')
SET @gunDefinitionId = (SELECT TOP 1 FORMAT(definition, 'X') FROM entitydefaults WHERE definitionname = 'def_standard_medium_laser')

-- T1

SET @robot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_thelodica_combat_drone')

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'standart_thelodica_combat_drone')
BEGIN
	SET @description = CONCAT('#robot=i', @robot, '#head=i', @head, '#chassis=i', @chassis, '#leg=i', @leg, '#container=i', @cargo, '#chassisModules=[|m0=[|definition=i', @gunDefinitionId, '|slot=i1|ammoDefinition=i', @ammo, '|ammoQuantity=i78]|m1=[|definition=i', @gunDefinitionId, '|slot=i2|ammoDefinition=i', @ammo, '|ammoQuantity=i78]|m2=[|definition=i', @gunDefinitionId, '|slot=i3|ammoDefinition=i', @ammo, '|ammoQuantity=i78]]')

	INSERT INTO robottemplates (name, description, note) VALUES
	('standart_thelodica_combat_drone', @description, 'Standart thelodica combat drone')
END

-- T2

SET @robot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_thelodica_combat_drone')

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'named1_thelodica_combat_drone')
BEGIN
	SET @description = CONCAT('#robot=i', @robot, '#head=i', @head, '#chassis=i', @chassis, '#leg=i', @leg, '#container=i', @cargo, '#chassisModules=[|m0=[|definition=i', @gunDefinitionId, '|slot=i1|ammoDefinition=i', @ammo, '|ammoQuantity=i78]|m1=[|definition=i', @gunDefinitionId, '|slot=i2|ammoDefinition=i', @ammo, '|ammoQuantity=i78]|m2=[|definition=i', @gunDefinitionId, '|slot=i3|ammoDefinition=i', @ammo, '|ammoQuantity=i78]]')

	INSERT INTO robottemplates (name, description, note) VALUES
	('named1_thelodica_combat_drone', @description, 'T2 thelodica combat drone')
END

-- T3

SET @robot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_thelodica_combat_drone')

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'named2_thelodica_combat_drone')
BEGIN
	SET @description = CONCAT('#robot=i', @robot, '#head=i', @head, '#chassis=i', @chassis, '#leg=i', @leg, '#container=i', @cargo, '#chassisModules=[|m0=[|definition=i', @gunDefinitionId, '|slot=i1|ammoDefinition=i', @ammo, '|ammoQuantity=i78]|m1=[|definition=i', @gunDefinitionId, '|slot=i2|ammoDefinition=i', @ammo, '|ammoQuantity=i78]|m2=[|definition=i', @gunDefinitionId, '|slot=i3|ammoDefinition=i', @ammo, '|ammoQuantity=i78]]')

	INSERT INTO robottemplates (name, description, note) VALUES
	('named2_thelodica_combat_drone', @description, 'T3 thelodica combat drone')
END

-- T4

SET @robot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_thelodica_combat_drone')

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'named3_thelodica_combat_drone')
BEGIN
	SET @description = CONCAT('#robot=i', @robot, '#head=i', @head, '#chassis=i', @chassis, '#leg=i', @leg, '#container=i', @cargo, '#chassisModules=[|m0=[|definition=i', @gunDefinitionId, '|slot=i1|ammoDefinition=i', @ammo, '|ammoQuantity=i78]|m1=[|definition=i', @gunDefinitionId, '|slot=i2|ammoDefinition=i', @ammo, '|ammoQuantity=i78]|m2=[|definition=i', @gunDefinitionId, '|slot=i3|ammoDefinition=i', @ammo, '|ammoQuantity=i78]]')

	INSERT INTO robottemplates (name, description, note) VALUES
	('named3_thelodica_combat_drone', @description, 'T4 thelodica combat drone')
END

GO

---- Link thelodica combat drones with their templates

DECLARE @turret_def INT
DECLARE @turret_template INT

SET @turret_def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_thelodica_combat_drone')
SET @turret_template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'standart_thelodica_combat_drone')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @turret_def AND templateid = @turret_template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@turret_def, @turret_template, 0, 0, 'Standart thelodica combat drone')
END

SET @turret_def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_thelodica_combat_drone')
SET @turret_template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'named1_thelodica_combat_drone')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @turret_def AND templateid = @turret_template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@turret_def, @turret_template, 0, 0, 'T2 thelodica combat drone')
END

SET @turret_def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_thelodica_combat_drone')
SET @turret_template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'named2_thelodica_combat_drone')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @turret_def AND templateid = @turret_template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@turret_def, @turret_template, 0, 0, 'T3 thelodica combat drone')
END

SET @turret_def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_thelodica_combat_drone')
SET @turret_template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'named3_thelodica_combat_drone')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @turret_def AND templateid = @turret_template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@turret_def, @turret_template, 0, 0, 'T4 thelodica combat drone')
END

GO

---- Set up aggregate fields for thelodica combat drones as ammo

DECLARE @definition INT
DECLARE @field INT

---- Bandwidth usage

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_bandwidth_usage')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_thelodica_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 5)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_thelodica_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 5)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_thelodica_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 5)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_thelodica_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 5)
END

---- Despawn time

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_lifetime')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_thelodica_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300000)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 300000 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_thelodica_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300000)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 300000 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_thelodica_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300000)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 300000 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_thelodica_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300000)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 300000 WHERE definition = @definition AND field = @field
END

---- Damage

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'damage_modifier')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_thelodica_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1.001)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.001 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_thelodica_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1.1843)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.1843 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_thelodica_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 3.0287)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 3.0287 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_thelodica_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4.818)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 4.818 WHERE definition = @definition AND field = @field
END

---- Cycle

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'turret_cycle_time_modifier')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_thelodica_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.625)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.625 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_thelodica_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.625)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.625 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_thelodica_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.714)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.714 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_thelodica_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.714)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.714 WHERE definition = @definition AND field = @field
END

---- Accuracy

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'accuracy_modifier')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_thelodica_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.7)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.7 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_thelodica_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.7)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.7 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_thelodica_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.6)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.6 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_thelodica_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.6)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.6 WHERE definition = @definition AND field = @field
END

GO

---- Set up aggregate fields for thelodica combat drones

DECLARE @definition INT
DECLARE @field INT

--head

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_thelodica_combat_drone_head')

---- CPU max

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 425)
END

---- Locked targets max

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locked_targets_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 7)
END

---- Locking range

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 35)
END

---- Locking time

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 12500)
END

---- Sensor strength

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'sensor_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 125)
END

---- Blob emission

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 7)
END

---- Blob emission radius

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission_radius')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 20)
END

---- Blob level low

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_level_low')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 105)
END

---- Blob level high

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_level_high')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 375)
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

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_thelodica_combat_drone_chassis')

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
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1300)
END

---- Core max

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2400)
END

---- Core recharge time

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 360)
END

---- Powergrid max

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 750)
END

---- Resists

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_chemical')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 30)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_explosive')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 10)
END

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_kinetic')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 150)
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

---- Missile miss

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'missile_miss')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.9)
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

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_thelodica_combat_drone_leg')

---- Slope

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'slope')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 6)
END

---- Speed max

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'speed_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2.6)
END

-- Standart thelodica combat drone

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_thelodica_combat_drone')

---- Locking range modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

-- damage modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'damage_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1.001)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.001 WHERE definition = @definition AND field = @field
END

-- accuracy modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'accuracy_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.7)
END

-- turret cycle time modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'turret_cycle_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.625)
END

---- Armor max modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1.292)
END

---- Signature radius modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

---- Locking time modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.22)
END

---- T2 thelodica combat drone ----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_thelodica_combat_drone')

---- Locking range modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

-- damage modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'damage_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1.1843)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.1843 WHERE definition = @definition AND field = @field
END

-- accuracy modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'accuracy_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.7)
END

-- turret cycle time modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'turret_cycle_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.625)
END

---- Armor max modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 1.938)
END

---- Signature radius modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4.75)
END

---- Locking time modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.22)
END

---- T3 thelodica combat drone ----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_thelodica_combat_drone')

---- Locking range modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

-- damage modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'damage_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 3.0287)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 3.8287 WHERE definition = @definition AND field = @field
END

-- accuracy modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'accuracy_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.6)
END

-- turret cycle time modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'turret_cycle_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.714)
END

---- Armor max modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4.76)
END

---- Signature radius modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 8.25)
END

---- Locking time modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.22)
END

---- T4 thelodica combat drone ----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_thelodica_combat_drone')

---- Locking range modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4)
END

-- damage modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'damage_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 4.818)
END

-- accuracy modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'accuracy_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.6)
END

-- turret cycle time modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'turret_cycle_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.714)
END

---- Armor max modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 6.8)
END

---- Signature radius modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 18)
END

---- Locking time modifier

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 0.22)
END

GO

---- Add enabler extensions for thelodica combat drones

DECLARE @definition INT
DECLARE @extension INT

SET @extension = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname = 'ext_thelodica_combat_drones_experience')

-- standart

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_thelodica_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM enablerextensions WHERE definition = @definition AND extensionid = @extension)
BEGIN
	INSERT INTO enablerextensions (definition, extensionid, extensionlevel) VALUES
	(@definition, @extension, 2)
END

-- T2

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_thelodica_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM enablerextensions WHERE definition = @definition AND extensionid = @extension)
BEGIN
	INSERT INTO enablerextensions (definition, extensionid, extensionlevel) VALUES
	(@definition, @extension, 4)
END

-- T3

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_thelodica_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM enablerextensions WHERE definition = @definition AND extensionid = @extension)
BEGIN
	INSERT INTO enablerextensions (definition, extensionid, extensionlevel) VALUES
	(@definition, @extension, 6)
END

-- T4

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_thelodica_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM enablerextensions WHERE definition = @definition AND extensionid = @extension)
BEGIN
	INSERT INTO enablerextensions (definition, extensionid, extensionlevel) VALUES
	(@definition, @extension, 8)
END

GO

-- Reconfigure extensions dependency and complexity

UPDATE extensions SET rank = 7, price = 245000 WHERE extensionname = 'ext_command_robotics'

UPDATE extensions SET rank = 7, price = 245000 WHERE extensionname = 'ext_sentry_turrets_experience'

UPDATE extensions SET rank = 8, price = 320000 WHERE extensionname = 'ext_mining_turrets_experience'

UPDATE extensions SET rank = 8, price = 320000 WHERE extensionname = 'ext_harvesting_turrets_experience'

UPDATE extensions SET rank = 9, price = 405000 WHERE extensionname = 'ext_pelistal_combat_drones_experience'

UPDATE extensions SET rank = 9, price = 405000 WHERE extensionname = 'ext_nuimqol_combat_drones_experience'

UPDATE extensions SET rank = 9, price = 405000 WHERE extensionname = 'ext_thelodica_combat_drones_experience'

DECLARE @extensionId INT
DECLARE @requiredExtension iNT

SET @extensionId = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname = 'ext_sentry_turrets_experience')
SET @requiredExtension = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname = 'ext_remote_control')

IF NOT EXISTS (SELECT 1 FROM extensionprerequire WHERE extensionid = @extensionId AND requiredextension = @requiredExtension)
BEGIN
	INSERT INTO extensionprerequire (extensionid, requiredextension, requiredlevel)
	VALUES (@extensionId, @requiredExtension, 3)
END

SET @extensionId = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname = 'ext_mining_turrets_experience')
SET @requiredExtension = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname = 'ext_sentry_turrets_experience')

IF NOT EXISTS (SELECT 1 FROM extensionprerequire WHERE extensionid = @extensionId AND requiredextension = @requiredExtension)
BEGIN
	INSERT INTO extensionprerequire (extensionid, requiredextension, requiredlevel)
	VALUES (@extensionId, @requiredExtension, 4)
END

SET @extensionId = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname = 'ext_harvesting_turrets_experience')
SET @requiredExtension = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname = 'ext_sentry_turrets_experience')

IF NOT EXISTS (SELECT 1 FROM extensionprerequire WHERE extensionid = @extensionId AND requiredextension = @requiredExtension)
BEGIN
	INSERT INTO extensionprerequire (extensionid, requiredextension, requiredlevel)
	VALUES (@extensionId, @requiredExtension, 4)
END

SET @extensionId = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname = 'ext_pelistal_combat_drones_experience')
SET @requiredExtension = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname = 'ext_sentry_turrets_experience')

IF NOT EXISTS (SELECT 1 FROM extensionprerequire WHERE extensionid = @extensionId AND requiredextension = @requiredExtension)
BEGIN
	INSERT INTO extensionprerequire (extensionid, requiredextension, requiredlevel)
	VALUES (@extensionId, @requiredExtension, 6)
END

SET @extensionId = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname = 'ext_nuimqol_combat_drones_experience')
SET @requiredExtension = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname = 'ext_sentry_turrets_experience')

IF NOT EXISTS (SELECT 1 FROM extensionprerequire WHERE extensionid = @extensionId AND requiredextension = @requiredExtension)
BEGIN
	INSERT INTO extensionprerequire (extensionid, requiredextension, requiredlevel)
	VALUES (@extensionId, @requiredExtension, 6)
END

SET @extensionId = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname = 'ext_nuimqol_combat_drones_experience')
SET @requiredExtension = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname = 'ext_sentry_turrets_experience')

IF NOT EXISTS (SELECT 1 FROM extensionprerequire WHERE extensionid = @extensionId AND requiredextension = @requiredExtension)
BEGIN
	INSERT INTO extensionprerequire (extensionid, requiredextension, requiredlevel)
	VALUES (@extensionId, @requiredExtension, 6)
END

GO

--------- CRAFT -----------

---- Position in tech tree ----

DECLARE @parent INT
DECLARE @spectator INT
DECLARE @pupeteerT1 INT
DECLARE @pupeteerT2 INT
DECLARE @pupeteerT3 INT
DECLARE @pupeteerT4 INT
DECLARE @miningTurretT1 INT
DECLARE @miningTurretT2 INT
DECLARE @miningTurretT3 INT
DECLARE @miningTurretT4 INT
DECLARE @harvestingTurretT1 INT
DECLARE @harvestingTurretT2 INT
DECLARE @harvestingTurretT3 INT
DECLARE @harvestingTurretT4 INT
DECLARE @sentryTurretT1 INT
DECLARE @sentryTurretT2 INT
DECLARE @sentryTurretT3 INT
DECLARE @sentryTurretT4 INT
DECLARE @pelistalDroneT1 INT
DECLARE @pelistalDroneT2 INT
DECLARE @pelistalDroneT3 INT
DECLARE @pelistalDroneT4 INT
DECLARE @nuimqolDroneT1 INT
DECLARE @nuimqolDroneT2 INT
DECLARE @nuimqolDroneT3 INT
DECLARE @nuimqolDroneT4 INT
DECLARE @thelodicaDroneT1 INT
DECLARE @thelodicaDroneT2 INT
DECLARE @thelodicaDroneT3 INT
DECLARE @thelodicaDroneT4 INT

DECLARE @group INT

SET @parent = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_cpu_upgrade')
SET @spectator = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_bot')
SET @pupeteerT1 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_remote_controller')
SET @pupeteerT2 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller')
SET @pupeteerT3 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller')
SET @pupeteerT4 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_remote_controller')
SET @miningTurretT1 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_mining_turret_unit')
SET @miningTurretT2 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_mining_turret_unit')
SET @miningTurretT3 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_mining_turret_unit')
SET @miningTurretT4 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_mining_turret_unit')
SET @harvestingTurretT1 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_harvesting_turret_unit')
SET @harvestingTurretT2 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_harvesting_turret_unit')
SET @harvestingTurretT3 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_harvesting_turret_unit')
SET @harvestingTurretT4 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_harvesting_turret_unit')
SET @sentryTurretT1 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_sentry_turret_unit')
SET @sentryTurretT2 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_sentry_turret_unit')
SET @sentryTurretT3 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_sentry_turret_unit')
SET @sentryTurretT4 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_sentry_turret_unit')
SET @pelistalDroneT1 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_pelistal_combat_drone_unit')
SET @pelistalDroneT2 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_pelistal_combat_drone_unit')
SET @pelistalDroneT3 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_pelistal_combat_drone_unit')
SET @pelistalDroneT4 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_pelistal_combat_drone_unit')
SET @nuimqolDroneT1 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_nuimqol_combat_drone_unit')
SET @nuimqolDroneT2 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_nuimqol_combat_drone_unit')
SET @nuimqolDroneT3 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_nuimqol_combat_drone_unit')
SET @nuimqolDroneT4 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_nuimqol_combat_drone_unit')
SET @thelodicaDroneT1 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_thelodica_combat_drone_unit')
SET @thelodicaDroneT2 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_thelodica_combat_drone_unit')
SET @thelodicaDroneT3 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_thelodica_combat_drone_unit')
SET @thelodicaDroneT4 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_thelodica_combat_drone_unit')

SET @group = (SELECT TOP 1 id FROM [techtreegroups] WHERE name = 'common2')

DELETE FROM techtree WHERE childdefinition IN (@spectator,@pupeteerT1,@pupeteerT2,@pupeteerT3,@pupeteerT4,@miningTurretT1,@miningTurretT2,@miningTurretT3,@miningTurretT4,
@harvestingTurretT1,@harvestingTurretT2,@harvestingTurretT3,@harvestingTurretT4,@sentryTurretT1,@sentryTurretT2,@sentryTurretT3,@sentryTurretT4,
@pelistalDroneT1,@pelistalDroneT2,@pelistalDroneT3,@pelistalDroneT4,@nuimqolDroneT1,@nuimqolDroneT2,@nuimqolDroneT3,@nuimqolDroneT4,
@thelodicaDroneT1,@thelodicaDroneT2,@thelodicaDroneT3,@thelodicaDroneT4)

INSERT INTO [techtree] (parentdefinition, childdefinition, groupID, x, y, enablerextensionid) VALUES
	(@parent, @spectator, @group, 1, 20, NULL),
	(@spectator, @pupeteerT1, @group, 2, 20, NULL),
	(@pupeteerT1, @pupeteerT2, @group, 3, 20, NULL),
	(@pupeteerT2, @pupeteerT3, @group, 4, 20, NULL),
	(@pupeteerT3, @pupeteerT4, @group, 5, 20, NULL),
	(@pupeteerT1, @miningTurretT1, @group, 3, 21, NULL),
	(@miningTurretT1, @miningTurretT2, @group, 4, 21, NULL),
	(@miningTurretT2, @miningTurretT3, @group, 5, 21, NULL),
	(@miningTurretT3, @miningTurretT4, @group, 6, 21, NULL),
	(@pupeteerT1, @harvestingTurretT1, @group, 3, 22, NULL),
	(@harvestingTurretT1, @harvestingTurretT2, @group, 4, 22, NULL),
	(@harvestingTurretT2, @harvestingTurretT3, @group, 5, 22, NULL),
	(@harvestingTurretT3, @harvestingTurretT4, @group, 6, 22, NULL),
	(@pupeteerT1, @sentryTurretT1, @group, 3, 23, NULL),
	(@sentryTurretT1, @sentryTurretT2, @group, 4, 23, NULL),
	(@sentryTurretT2, @sentryTurretT3, @group, 5, 23, NULL),
	(@sentryTurretT3, @sentryTurretT4, @group, 6, 23, NULL),
	(@sentryTurretT1, @pelistalDroneT1, @group, 4, 24, NULL),
	(@pelistalDroneT1, @pelistalDroneT2, @group, 5, 24, NULL),
	(@pelistalDroneT2, @pelistalDroneT3, @group, 6, 24, NULL),
	(@pelistalDroneT3, @pelistalDroneT4, @group, 7, 24, NULL),
	(@sentryTurretT1, @nuimqolDroneT1, @group, 4, 25, NULL),
	(@nuimqolDroneT1, @nuimqolDroneT2, @group, 5, 25, NULL),
	(@nuimqolDroneT2, @nuimqolDroneT3, @group, 6, 25, NULL),
	(@nuimqolDroneT3, @nuimqolDroneT4, @group, 7, 25, NULL),
	(@sentryTurretT1, @thelodicaDroneT1, @group, 4, 26, NULL),
	(@thelodicaDroneT1, @thelodicaDroneT2, @group, 5, 26, NULL),
	(@thelodicaDroneT2, @thelodicaDroneT3, @group, 6, 26, NULL),
	(@thelodicaDroneT3, @thelodicaDroneT4, @group, 7, 26, NULL)

GO

---- Create entity defaults for Spectator prototype

DECLARE @category INT

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_heavymech_chassis')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_spectator_chassis_pr')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_spectator_chassis_pr', 1, 1024, @category, '#slotFlags=4d3,6d0 #height=f2.00 #decay=n500', 1, 100, 78000, 1, 100, 'def_spectator_chassis_desc', 0, NULL, NULL)
END
ELSE
BEGIN
	UPDATE entitydefaults SET options = '#slotFlags=4d3,6d0 #height=f2.00 #decay=n500', mass=78000  WHERE definitionname = 'def_spectator_chassis_pr'
END

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_heavymech_head')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_spectator_head_pr')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_spectator_head_pr', 1, 1024, @category, '#slotFlags=4808,8,8,8,8,8  #height=f0.10', 1, 3, 3000, 1, 100, 'def_spectator_head_desc', 0, NULL, NULL)
END
ELSE
BEGIN
	UPDATE entitydefaults SET options = '#slotFlags=4808,8,8,8,8,8  #height=f0.10', mass=3000  WHERE definitionname = 'def_spectator_head_pr'
END

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_heavymech_leg')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_spectator_leg_pr')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_spectator_leg_pr', 1, 1024, @category, '#slotFlags=420,20,20,20,20  #height=f1.10', 1, 20, 18000, 1, 100, 'def_spectator_leg_desc', 0, NULL, NULL)
END
ELSE
BEGIN
	UPDATE entitydefaults SET options = '#slotFlags=420,20,20,20,20  #height=f1.10', mass=18000  WHERE definitionname = 'def_spectator_leg_pr'
END

DECLARE @head INT
DECLARE @chassis INT
DECLARE @leg INT
DECLARE @cargo INT

SET @head = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_head_pr')
SET @chassis = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_chassis_pr')
SET @leg = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_leg_pr')
SET @cargo = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robot_inventory_spectator')

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_combat_command_robots')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_spectator_bot_pr')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_spectator_bot_pr', 1, 0, @category, CONCAT('#head=n', @head, '  #chassis=n', @chassis, '  #leg=n', @leg, '  #inventory=n', @cargo, '#tier=$tierlevel_pr'), 1, 123, 0, 0, 100, 'def_spectator_bot_desc', 1, 2, NULL)
END

GO

---- Create robot definitions and it's template and link them

DECLARE @robot INT
DECLARE @head INT
DECLARE @chassis INT
DECLARE @leg INT
DECLARE @cargo INT

SET @robot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_bot_pr')
SET @head = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_head_pr')
SET @chassis = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_chassis_pr')
SET @leg = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_leg_pr')
SET @cargo = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robot_inventory_spectator')

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'spectator_pr_empty')
BEGIN
	INSERT INTO robottemplates (name, description, note) VALUES
	('spectator_pr_empty', CONCAT('#robot=i', FORMAT(@robot, 'X'), '#head=i', FORMAT(@head, 'X'), '#chassis=i', FORMAT(@chassis, 'X'), '#leg=i', FORMAT(@leg, 'X'), '#container=i', FORMAT(@cargo, 'X')), 'Spectator')
END

DECLARE @template INT

SET @template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'spectator_pr_empty')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @robot AND templateid = @template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@robot, @template, 0, 0, 'def_spectator_pr_bot')
END

GO

---- Set up aggregate fields for Spectator prototype

DECLARE @definition INT
DECLARE @field INT

-- Legs

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_leg_pr')

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

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_head_pr')

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 515)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locked_targets_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 5)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 30)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_time')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 10000)
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'sensor_strength')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 90)
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

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_chassis_pr')

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
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 845)
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

---- Add enabler extensions for Spectator prototype

DECLARE @definition INT
DECLARE @extension INT

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_bot_pr')

SET @extension = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname = 'ext_command_robotics')

IF NOT EXISTS (SELECT 1 FROM enablerextensions WHERE definition = @definition AND extensionid = @extension)
BEGIN
	INSERT INTO enablerextensions (definition, extensionid, extensionlevel) VALUES
	(@definition, @extension, 4)
END

SET @extension = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname = 'ext_glider_specialist')

IF NOT EXISTS (SELECT 1 FROM enablerextensions WHERE definition = @definition AND extensionid = @extension)
BEGIN
	INSERT INTO enablerextensions (definition, extensionid, extensionlevel) VALUES
	(@definition, @extension, 1)
END

GO

---- Add chassis bonuses and link them with extensions and aggregate fields

DECLARE @definition INT
DECLARE @extension INT
DECLARE @field INT

-- Chassis
    
SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_chassis_pr')

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

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_head_pr')

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

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_leg_pr')

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'shield_absorbtion_modifier')

IF NOT EXISTS (SELECT 1 FROM chassisbonus WHERE definition = @definition AND extension = @extension AND targetpropertyID = @field)
BEGIN
	INSERT INTO chassisbonus (definition, extension, bonus, targetpropertyID, effectenhancer) VALUES
	(@definition, @extension, 0.01, @field, 0)
END

GO

-----------------------------

---- Create entity defaults for remote controllers prototypes

DECLARE @categoryFlag INT

SET @categoryFlag = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_remote_controllers')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller_pr')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named1_remote_controller_pr', 1, 2359320, @categoryFlag, '#moduleFlag=i808  #ammoCapacity=i3  #ammoType=L200a  #powergrid_usage=f0.00  #cpu_usage=f0.00  #tier=$tierlevel_t2_pr', 1, 1, 1, 0, 100, 'def_standart_remote_controller_desc', 1, 1, 2)
END
ELSE
BEGIN
	UPDATE entitydefaults SET options='#moduleFlag=i808  #ammoCapacity=i3  #ammoType=L200a  #powergrid_usage=f0.00  #cpu_usage=f0.00  #tier=$tierlevel_t2_pr', mass=1 WHERE definitionname = 'def_named1_remote_controller_pr'
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller_pr')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named2_remote_controller_pr', 1, 2359320, @categoryFlag, '#moduleFlag=i808  #ammoCapacity=i4  #ammoType=L200a  #powergrid_usage=f0.00  #cpu_usage=f0.00  #tier=$tierlevel_t3_pr', 1, 1, 1, 0, 100, 'def_standart_remote_controller_desc', 1, 1, 3)
END
ELSE
BEGIN
	UPDATE entitydefaults SET options='#moduleFlag=i808  #ammoCapacity=i4  #ammoType=L200a  #powergrid_usage=f0.00  #cpu_usage=f0.00  #tier=$tierlevel_t3_pr', mass=1 WHERE definitionname = 'def_named2_remote_controller_pr'
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named3_remote_controller_pr')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named3_remote_controller_pr', 1, 2359320, @categoryFlag, '#moduleFlag=i808  #ammoCapacity=i5  #ammoType=L200a  #powergrid_usage=f0.00  #cpu_usage=f0.00  #tier=$tierlevel_t4_pr', 1, 1, 1, 0, 100, 'def_standart_remote_controller_desc', 1, 1, 4)
END
ELSE
BEGIN
	UPDATE entitydefaults SET options='#moduleFlag=i808  #ammoCapacity=i5  #ammoType=L200a  #powergrid_usage=f0.00  #cpu_usage=f0.00  #tier=$tierlevel_t4_pr', mass=1 WHERE definitionname = 'def_named3_remote_controller_pr'
END

GO

---- Set up aggregate fields for remote controllers

DECLARE @definition INT
DECLARE @field INT

---- Max bandwidth

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_bandwidth_max')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller_pr')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 5 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller_pr')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 5 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_remote_controller_pr')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 5 WHERE definition = @definition AND field = @field
END

---- Accumulator usage

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_usage')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller_pr')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 135)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 135 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller_pr')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 165)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 165 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_remote_controller_pr')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 180)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 180 WHERE definition = @definition AND field = @field
END

---- CPU usage

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_usage')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller_pr')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 140)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 154 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller_pr')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 164)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 180 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_remote_controller_pr')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 180)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 200 WHERE definition = @definition AND field = @field
END

---- Cycle time

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cycle_time')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller_pr')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 3000)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 3000 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller_pr')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2500)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2500 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_remote_controller_pr')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 2000)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2000 WHERE definition = @definition AND field = @field
END

---- Optimal range

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller_pr')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 20)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 20 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller_pr')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 25)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 25 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_remote_controller_pr')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 30)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 30 WHERE definition = @definition AND field = @field
END

---- Reactor usage

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_usage')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller_pr')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 135)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 135 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller_pr')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 165)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 165 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_remote_controller_pr')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 180)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 180 WHERE definition = @definition AND field = @field
END

---- Rcu Lifetime

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_lifetime')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller_pr')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300000)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 300000 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller_pr')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300000)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 300000 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_remote_controller_pr')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 300000)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 300000 WHERE definition = @definition AND field = @field
END

---- Drones operational range

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_operational_range')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller_pr')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 30)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 30 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller_pr')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 30)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 30 WHERE definition = @definition AND field = @field
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_remote_controller_pr')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @definition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@definition, @field, 30)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 30 WHERE definition = @definition AND field = @field
END

GO

-------------------------------------------------------------

---- Create CT for Spectator

DECLARE @categoryFlags INT

SET @categoryFlags = (SELECT TOP 1 value FROM categoryflags WHERE name = 'cf_heavymech_calibration_programs')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_spectator_bot_cprg')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_spectator_bot_cprg', 1, 1024, @categoryFlags, '#tier=$tierlevel_t3', NULL, 1, 0.01, 0.1, 0, 100, 'calibration_program_desc', 0, 1, 3)
END

---- Create CT for remote controllers

SET @categoryFlags = (SELECT TOP 1 value FROM categoryflags WHERE name = 'cf_electronics_equipment_calibration_programs')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_remote_controller_cprg')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_remote_controller_cprg', 1, 1024, @categoryFlags, '#tier=$tierlevel_t1', NULL, 1, 0.01, 0.1, 0, 100, 'calibration_program_desc', 0, 1, 1)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller_cprg')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named1_remote_controller_cprg', 1, 1024, @categoryFlags, '#tier=$tierlevel_t2', NULL, 1, 0.01, 0.1, 0, 100, 'calibration_program_desc', 0, 1, 2)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller_cprg')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named2_remote_controller_cprg', 1, 1024, @categoryFlags, '#tier=$tierlevel_t3', NULL, 1, 0.01, 0.1, 0, 100, 'calibration_program_desc', 0, 1, 3)
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named3_remote_controller_cprg')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named3_remote_controller_cprg', 1, 1024, @categoryFlags, '#tier=$tierlevel_t4', NULL, 1, 0.01, 0.1, 0, 100, 'calibration_program_desc', 0, 1, 4)
END

---- Create CT for sentry turrets

SET @categoryFlags = (SELECT TOP 1 value FROM categoryflags WHERE name = 'cf_ammo_rcu_calibration_programs')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_sentry_turret_unit_cprg')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_sentry_turret_unit_cprg', 1, 1024, @categoryFlags, NULL, NULL, 1, 0.01, 0.1, 0, 100, 'calibration_program_desc', 0, 1, 1)
END
ELSE
BEGIN
	UPDATE entitydefaults SET categoryflags = @categoryFlags WHERE definitionname = 'def_standart_sentry_turret_unit_cprg'
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named1_sentry_turret_unit_cprg')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named1_sentry_turret_unit_cprg', 1, 1024, @categoryFlags, NULL, NULL, 1, 0.01, 0.1, 0, 100, 'calibration_program_desc', 0, 1, 2)
END
ELSE
BEGIN
	UPDATE entitydefaults SET categoryflags = @categoryFlags WHERE definitionname = 'def_named1_sentry_turret_unit_cprg'
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named2_sentry_turret_unit_cprg')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named2_sentry_turret_unit_cprg', 1, 1024, @categoryFlags, NULL, NULL, 1, 0.01, 0.1, 0, 100, 'calibration_program_desc', 0, 1, 3)
END
ELSE
BEGIN
	UPDATE entitydefaults SET categoryflags = @categoryFlags WHERE definitionname = 'def_named2_sentry_turret_unit_cprg'
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named3_sentry_turret_unit_cprg')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named3_sentry_turret_unit_cprg', 1, 1024, @categoryFlags, NULL, NULL, 1, 0.01, 0.1, 0, 100, 'calibration_program_desc', 0, 1, 4)
END
ELSE
BEGIN
	UPDATE entitydefaults SET categoryflags = @categoryFlags WHERE definitionname = 'def_named3_sentry_turret_unit_cprg'
END

---- Create CT for mining turrets

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_mining_turret_unit_cprg')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_mining_turret_unit_cprg', 1, 1024, @categoryFlags, NULL, NULL, 1, 0.01, 0.1, 0, 100, 'calibration_program_desc', 0, 1, 1)
END
ELSE
BEGIN
	UPDATE entitydefaults SET categoryflags = @categoryFlags WHERE definitionname = 'def_standart_mining_turret_unit_cprg'
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named1_mining_turret_unit_cprg')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named1_mining_turret_unit_cprg', 1, 1024, @categoryFlags, NULL, NULL, 1, 0.01, 0.1, 0, 100, 'calibration_program_desc', 0, 1, 2)
END
ELSE
BEGIN
	UPDATE entitydefaults SET categoryflags = @categoryFlags WHERE definitionname = 'def_named1_mining_turret_unit_cprg'
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named2_mining_turret_unit_cprg')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named2_mining_turret_unit_cprg', 1, 1024, @categoryFlags, NULL, NULL, 1, 0.01, 0.1, 0, 100, 'calibration_program_desc', 0, 1, 3)
END
ELSE
BEGIN
	UPDATE entitydefaults SET categoryflags = @categoryFlags WHERE definitionname = 'def_named2_mining_turret_unit_cprg'
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named3_mining_turret_unit_cprg')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named3_mining_turret_unit_cprg', 1, 1024, @categoryFlags, NULL, NULL, 1, 0.01, 0.1, 0, 100, 'calibration_program_desc', 0, 1, 4)
END
ELSE
BEGIN
	UPDATE entitydefaults SET categoryflags = @categoryFlags WHERE definitionname = 'def_named3_mining_turret_unit_cprg'
END

---- Create CT for harvesting turrets

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_harvesting_turret_unit_cprg')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_harvesting_turret_unit_cprg', 1, 1024, @categoryFlags, NULL, NULL, 1, 0.01, 0.1, 0, 100, 'calibration_program_desc', 0, 1, 1)
END
ELSE
BEGIN
	UPDATE entitydefaults SET categoryflags = @categoryFlags WHERE definitionname = 'def_standart_harvesting_turret_unit_cprg'
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named1_harvesting_turret_unit_cprg')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named1_harvesting_turret_unit_cprg', 1, 1024, @categoryFlags, NULL, NULL, 1, 0.01, 0.1, 0, 100, 'calibration_program_desc', 0, 1, 2)
END
ELSE
BEGIN
	UPDATE entitydefaults SET categoryflags = @categoryFlags WHERE definitionname = 'def_named1_harvesting_turret_unit_cprg'
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named2_harvesting_turret_unit_cprg')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named2_harvesting_turret_unit_cprg', 1, 1024, @categoryFlags, NULL, NULL, 1, 0.01, 0.1, 0, 100, 'calibration_program_desc', 0, 1, 3)
END
ELSE
BEGIN
	UPDATE entitydefaults SET categoryflags = @categoryFlags WHERE definitionname = 'def_named2_harvesting_turret_unit_cprg'
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named3_harvesting_turret_unit_cprg')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named3_harvesting_turret_unit_cprg', 1, 1024, @categoryFlags, NULL, NULL, 1, 0.01, 0.1, 0, 100, 'calibration_program_desc', 0, 1, 4)
END
ELSE
BEGIN
	UPDATE entitydefaults SET categoryflags = @categoryFlags WHERE definitionname = 'def_named3_harvesting_turret_unit_cprg'
END

---- Create CT for pelistal combat drones

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_pelistal_combat_drone_unit_cprg')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_pelistal_combat_drone_unit_cprg', 1, 1024, @categoryFlags, NULL, NULL, 1, 0.01, 0.1, 0, 100, 'calibration_program_desc', 0, 1, 1)
END
ELSE
BEGIN
	UPDATE entitydefaults SET categoryflags = @categoryFlags WHERE definitionname = 'def_standart_pelistal_combat_drone_unit_cprg'
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named1_pelistal_combat_drone_unit_cprg')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named1_pelistal_combat_drone_unit_cprg', 1, 1024, @categoryFlags, NULL, NULL, 1, 0.01, 0.1, 0, 100, 'calibration_program_desc', 0, 1, 2)
END
ELSE
BEGIN
	UPDATE entitydefaults SET categoryflags = @categoryFlags WHERE definitionname = 'def_named1_pelistal_combat_drone_unit_cprg'
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named2_pelistal_combat_drone_unit_cprg')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named2_pelistal_combat_drone_unit_cprg', 1, 1024, @categoryFlags, NULL, NULL, 1, 0.01, 0.1, 0, 100, 'calibration_program_desc', 0, 1, 3)
END
ELSE
BEGIN
	UPDATE entitydefaults SET categoryflags = @categoryFlags WHERE definitionname = 'def_named2_pelistal_combat_drone_unit_cprg'
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named3_pelistal_combat_drone_unit_cprg')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named3_pelistal_combat_drone_unit_cprg', 1, 1024, @categoryFlags, NULL, NULL, 1, 0.01, 0.1, 0, 100, 'calibration_program_desc', 0, 1, 4)
END
ELSE
BEGIN
	UPDATE entitydefaults SET categoryflags = @categoryFlags WHERE definitionname = 'def_named3_pelistal_combat_drone_unit_cprg'
END

---- Create CT for nuimqol combat drones

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_nuimqol_combat_drone_unit_cprg')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_nuimqol_combat_drone_unit_cprg', 1, 1024, @categoryFlags, NULL, NULL, 1, 0.01, 0.1, 0, 100, 'calibration_program_desc', 0, 1, 1)
END
ELSE
BEGIN
	UPDATE entitydefaults SET categoryflags = @categoryFlags WHERE definitionname = 'def_standart_nuimqol_combat_drone_unit_cprg'
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named1_nuimqol_combat_drone_unit_cprg')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named1_nuimqol_combat_drone_unit_cprg', 1, 1024, @categoryFlags, NULL, NULL, 1, 0.01, 0.1, 0, 100, 'calibration_program_desc', 0, 1, 2)
END
ELSE
BEGIN
	UPDATE entitydefaults SET categoryflags = @categoryFlags WHERE definitionname = 'def_named1_nuimqol_combat_drone_unit_cprg'
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named2_nuimqol_combat_drone_unit_cprg')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named2_nuimqol_combat_drone_unit_cprg', 1, 1024, @categoryFlags, NULL, NULL, 1, 0.01, 0.1, 0, 100, 'calibration_program_desc', 0, 1, 3)
END
ELSE
BEGIN
	UPDATE entitydefaults SET categoryflags = @categoryFlags WHERE definitionname = 'def_named2_nuimqol_combat_drone_unit_cprg'
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named3_nuimqol_combat_drone_unit_cprg')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named3_nuimqol_combat_drone_unit_cprg', 1, 1024, @categoryFlags, NULL, NULL, 1, 0.01, 0.1, 0, 100, 'calibration_program_desc', 0, 1, 4)
END
ELSE
BEGIN
	UPDATE entitydefaults SET categoryflags = @categoryFlags WHERE definitionname = 'def_named3_nuimqol_combat_drone_unit_cprg'
END

---- Create CT for thelodica combat drones

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_standart_thelodica_combat_drone_unit_cprg')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_standart_thelodica_combat_drone_unit_cprg', 1, 1024, @categoryFlags, NULL, NULL, 1, 0.01, 0.1, 0, 100, 'calibration_program_desc', 0, 1, 1)
END
ELSE
BEGIN
	UPDATE entitydefaults SET categoryflags = @categoryFlags WHERE definitionname = 'def_standart_thelodica_combat_drone_unit_cprg'
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named1_thelodica_combat_drone_unit_cprg')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named1_thelodica_combat_drone_unit_cprg', 1, 1024, @categoryFlags, NULL, NULL, 1, 0.01, 0.1, 0, 100, 'calibration_program_desc', 0, 1, 2)
END
ELSE
BEGIN
	UPDATE entitydefaults SET categoryflags = @categoryFlags WHERE definitionname = 'def_named1_thelodica_combat_drone_unit_cprg'
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named2_thelodica_combat_drone_unit_cprg')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named2_thelodica_combat_drone_unit_cprg', 1, 1024, @categoryFlags, NULL, NULL, 1, 0.01, 0.1, 0, 100, 'calibration_program_desc', 0, 1, 3)
END
ELSE
BEGIN
	UPDATE entitydefaults SET categoryflags = @categoryFlags WHERE definitionname = 'def_named2_thelodica_combat_drone_unit_cprg'
END

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_named3_thelodica_combat_drone_unit_cprg')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_named3_thelodica_combat_drone_unit_cprg', 1, 1024, @categoryFlags, NULL, NULL, 1, 0.01, 0.1, 0, 100, 'calibration_program_desc', 0, 1, 4)
END
ELSE
BEGIN
	UPDATE entitydefaults SET categoryflags = @categoryFlags WHERE definitionname = 'def_named3_thelodica_combat_drone_unit_cprg'
END

GO

-- set base ct efficiency

DECLARE @definition INT

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_bot_cprg')

DELETE FROM calibrationdefaults WHERE definition = @definition

INSERT INTO calibrationdefaults (definition, materialefficiency, timeefficiency) VALUES
(@definition, 50, 50)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_remote_controller_cprg')

DELETE FROM calibrationdefaults WHERE definition = @definition

INSERT INTO calibrationdefaults (definition, materialefficiency, timeefficiency) VALUES
(@definition, 70, 70)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller_cprg')

DELETE FROM calibrationdefaults WHERE definition = @definition

INSERT INTO calibrationdefaults (definition, materialefficiency, timeefficiency) VALUES
(@definition, 70, 70)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller_cprg')

DELETE FROM calibrationdefaults WHERE definition = @definition

INSERT INTO calibrationdefaults (definition, materialefficiency, timeefficiency) VALUES
(@definition, 70, 70)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_remote_controller_cprg')

DELETE FROM calibrationdefaults WHERE definition = @definition

INSERT INTO calibrationdefaults (definition, materialefficiency, timeefficiency) VALUES
(@definition, 70, 70)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_sentry_turret_unit_cprg')

DELETE FROM calibrationdefaults WHERE definition = @definition

INSERT INTO calibrationdefaults (definition, materialefficiency, timeefficiency) VALUES
(@definition, 90, 90)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_sentry_turret_unit_cprg')

DELETE FROM calibrationdefaults WHERE definition = @definition

INSERT INTO calibrationdefaults (definition, materialefficiency, timeefficiency) VALUES
(@definition, 90, 90)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_sentry_turret_unit_cprg')

DELETE FROM calibrationdefaults WHERE definition = @definition

INSERT INTO calibrationdefaults (definition, materialefficiency, timeefficiency) VALUES
(@definition, 90, 90)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_sentry_turret_unit_cprg')

DELETE FROM calibrationdefaults WHERE definition = @definition

INSERT INTO calibrationdefaults (definition, materialefficiency, timeefficiency) VALUES
(@definition, 90, 90)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_mining_turret_unit_cprg')

DELETE FROM calibrationdefaults WHERE definition = @definition

INSERT INTO calibrationdefaults (definition, materialefficiency, timeefficiency) VALUES
(@definition, 90, 90)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_mining_turret_unit_cprg')

DELETE FROM calibrationdefaults WHERE definition = @definition

INSERT INTO calibrationdefaults (definition, materialefficiency, timeefficiency) VALUES
(@definition, 90, 90)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_mining_turret_unit_cprg')

DELETE FROM calibrationdefaults WHERE definition = @definition

INSERT INTO calibrationdefaults (definition, materialefficiency, timeefficiency) VALUES
(@definition, 90, 90)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_mining_turret_unit_cprg')

DELETE FROM calibrationdefaults WHERE definition = @definition

INSERT INTO calibrationdefaults (definition, materialefficiency, timeefficiency) VALUES
(@definition, 90, 90)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_harvesting_turret_unit_cprg')

DELETE FROM calibrationdefaults WHERE definition = @definition

INSERT INTO calibrationdefaults (definition, materialefficiency, timeefficiency) VALUES
(@definition, 90, 90)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_harvesting_turret_unit_cprg')

DELETE FROM calibrationdefaults WHERE definition = @definition

INSERT INTO calibrationdefaults (definition, materialefficiency, timeefficiency) VALUES
(@definition, 90, 90)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_harvesting_turret_unit_cprg')

DELETE FROM calibrationdefaults WHERE definition = @definition

INSERT INTO calibrationdefaults (definition, materialefficiency, timeefficiency) VALUES
(@definition, 90, 90)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_harvesting_turret_unit_cprg')

DELETE FROM calibrationdefaults WHERE definition = @definition

INSERT INTO calibrationdefaults (definition, materialefficiency, timeefficiency) VALUES
(@definition, 90, 90)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_pelistal_combat_drone_unit_cprg')

DELETE FROM calibrationdefaults WHERE definition = @definition

INSERT INTO calibrationdefaults (definition, materialefficiency, timeefficiency) VALUES
(@definition, 80, 80)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_pelistal_combat_drone_unit_cprg')

DELETE FROM calibrationdefaults WHERE definition = @definition

INSERT INTO calibrationdefaults (definition, materialefficiency, timeefficiency) VALUES
(@definition, 80, 80)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_pelistal_combat_drone_unit_cprg')

DELETE FROM calibrationdefaults WHERE definition = @definition

INSERT INTO calibrationdefaults (definition, materialefficiency, timeefficiency) VALUES
(@definition, 80, 80)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_pelistal_combat_drone_unit_cprg')

DELETE FROM calibrationdefaults WHERE definition = @definition

INSERT INTO calibrationdefaults (definition, materialefficiency, timeefficiency) VALUES
(@definition, 80, 80)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_nuimqol_combat_drone_unit_cprg')

DELETE FROM calibrationdefaults WHERE definition = @definition

INSERT INTO calibrationdefaults (definition, materialefficiency, timeefficiency) VALUES
(@definition, 80, 80)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_nuimqol_combat_drone_unit_cprg')

DELETE FROM calibrationdefaults WHERE definition = @definition

INSERT INTO calibrationdefaults (definition, materialefficiency, timeefficiency) VALUES
(@definition, 80, 80)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_nuimqol_combat_drone_unit_cprg')

DELETE FROM calibrationdefaults WHERE definition = @definition

INSERT INTO calibrationdefaults (definition, materialefficiency, timeefficiency) VALUES
(@definition, 80, 80)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_nuimqol_combat_drone_unit_cprg')

DELETE FROM calibrationdefaults WHERE definition = @definition

INSERT INTO calibrationdefaults (definition, materialefficiency, timeefficiency) VALUES
(@definition, 80, 80)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_thelodica_combat_drone_unit_cprg')

DELETE FROM calibrationdefaults WHERE definition = @definition

INSERT INTO calibrationdefaults (definition, materialefficiency, timeefficiency) VALUES
(@definition, 80, 80)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_thelodica_combat_drone_unit_cprg')

DELETE FROM calibrationdefaults WHERE definition = @definition

INSERT INTO calibrationdefaults (definition, materialefficiency, timeefficiency) VALUES
(@definition, 80, 80)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_thelodica_combat_drone_unit_cprg')

DELETE FROM calibrationdefaults WHERE definition = @definition

INSERT INTO calibrationdefaults (definition, materialefficiency, timeefficiency) VALUES
(@definition, 80, 80)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_thelodica_combat_drone_unit_cprg')

DELETE FROM calibrationdefaults WHERE definition = @definition

INSERT INTO calibrationdefaults (definition, materialefficiency, timeefficiency) VALUES
(@definition, 80, 80)

GO

-- create dynamic CT spectator

DECLARE @categoryFlags INT

SET @categoryFlags = (SELECT TOP 1 value FROM categoryflags WHERE name = 'cf_dynamic_cprg')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_spectator_bot_A_dynamic_cprg')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_spectator_bot_A_dynamic_cprg', 1, 1024, @categoryFlags, '#tier=$tierlevel_mk3', NULL, 1, 0.1, 0.1, 0, 100, 'calibration_program_desc', 0, 1, 3)
END

DECLARE @definition INT
DECLARE @targetDefinition INT

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_bot_A_dynamic_cprg')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_bot')

DELETE FROM dynamiccalibrationtemplates WHERE definition = @definition AND targetdefinition = @targetDefinition

INSERT INTO dynamiccalibrationtemplates (definition, materialefficiency, timeefficiency, targetdefinition) VALUES
(@definition, 5, 5, @targetDefinition)

GO

---- set up decalibration and production time

DECLARE @categoryFlags BIGINT

SET @categoryFlags = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_combat_command_robots')

IF NOT EXISTS (SELECT 1 FROM productiondecalibration WHERE categoryflag = @categoryFlags)
BEGIN
	INSERT INTO productiondecalibration (categoryflag, distorsionmin, distorsionmax, decrease) values
	(@categoryflags, 0.005, 0.01, 3)
END

IF NOT EXISTS (SELECT 1 FROM productionduration WHERE category = @categoryFlags)
BEGIN
	INSERT INTO productionduration (category, durationmodifier) values
	(@categoryFlags, 10)
END

SET @categoryFlags = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_remote_controllers')

IF NOT EXISTS (SELECT 1 FROM productiondecalibration WHERE categoryflag = @categoryFlags)
BEGIN
	INSERT INTO productiondecalibration (categoryflag, distorsionmin, distorsionmax, decrease) values
	(@categoryflags, 0.003, 0.005, 1)
END

IF NOT EXISTS (SELECT 1 FROM productionduration WHERE category = @categoryFlags)
BEGIN
	INSERT INTO productionduration (category, durationmodifier) values
	(@categoryFlags, 2)
END

SET @categoryFlags = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_sentry_turret_units')

IF NOT EXISTS (SELECT 1 FROM productiondecalibration WHERE categoryflag = @categoryFlags)
BEGIN
	INSERT INTO productiondecalibration (categoryflag, distorsionmin, distorsionmax, decrease) values
	(@categoryflags, 0.001, 0.0015, 0.3)
END

IF NOT EXISTS (SELECT 1 FROM productionduration WHERE category = @categoryFlags)
BEGIN
	INSERT INTO productionduration (category, durationmodifier) values
	(@categoryFlags, 0.2)
END

SET @categoryFlags = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_mining_turret_units')

IF NOT EXISTS (SELECT 1 FROM productiondecalibration WHERE categoryflag = @categoryFlags)
BEGIN
	INSERT INTO productiondecalibration (categoryflag, distorsionmin, distorsionmax, decrease) values
	(@categoryflags, 0.001, 0.0015, 0.3)
END

IF NOT EXISTS (SELECT 1 FROM productionduration WHERE category = @categoryFlags)
BEGIN
	INSERT INTO productionduration (category, durationmodifier) values
	(@categoryFlags, 0.2)
END

SET @categoryFlags = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_harvesting_turret_units')

IF NOT EXISTS (SELECT 1 FROM productiondecalibration WHERE categoryflag = @categoryFlags)
BEGIN
	INSERT INTO productiondecalibration (categoryflag, distorsionmin, distorsionmax, decrease) values
	(@categoryflags, 0.001, 0.0015, 0.3)
END

IF NOT EXISTS (SELECT 1 FROM productionduration WHERE category = @categoryFlags)
BEGIN
	INSERT INTO productionduration (category, durationmodifier) values
	(@categoryFlags, 0.2)
END

SET @categoryFlags = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_pelistal_combat_drones_units')

IF NOT EXISTS (SELECT 1 FROM productiondecalibration WHERE categoryflag = @categoryFlags)
BEGIN
	INSERT INTO productiondecalibration (categoryflag, distorsionmin, distorsionmax, decrease) values
	(@categoryflags, 0.001, 0.0015, 0.3)
END

IF NOT EXISTS (SELECT 1 FROM productionduration WHERE category = @categoryFlags)
BEGIN
	INSERT INTO productionduration (category, durationmodifier) values
	(@categoryFlags, 0.2)
END

SET @categoryFlags = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_nuimqol_combat_drones_units')

IF NOT EXISTS (SELECT 1 FROM productiondecalibration WHERE categoryflag = @categoryFlags)
BEGIN
	INSERT INTO productiondecalibration (categoryflag, distorsionmin, distorsionmax, decrease) values
	(@categoryflags, 0.001, 0.0015, 0.3)
END

IF NOT EXISTS (SELECT 1 FROM productionduration WHERE category = @categoryFlags)
BEGIN
	INSERT INTO productionduration (category, durationmodifier) values
	(@categoryFlags, 0.2)
END

SET @categoryFlags = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_thelodica_combat_drones_units')

IF NOT EXISTS (SELECT 1 FROM productiondecalibration WHERE categoryflag = @categoryFlags)
BEGIN
	INSERT INTO productiondecalibration (categoryflag, distorsionmin, distorsionmax, decrease) values
	(@categoryflags, 0.001, 0.0015, 0.3)
END

IF NOT EXISTS (SELECT 1 FROM productionduration WHERE category = @categoryFlags)
BEGIN
	INSERT INTO productionduration (category, durationmodifier) values
	(@categoryFlags, 0.2)
END

---- Production and prorotyping cost in materials, modules and components ----

DECLARE @definition INT

DECLARE @titanium INT
DECLARE @cryoperine INT
DECLARE @axicoline INT
DECLARE @plasteosine INT
DECLARE @flux INT

DECLARE @biotichrin INT
DECLARE @polynitrocol INT
DECLARE @polynucleit INT
DECLARE @phlobotil INT

DECLARE @bryochite INT
DECLARE @alligior INT
DECLARE @espitium INT
DECLARE @hydrobenol INT

DECLARE @common_basic_components INT
DECLARE @common_advanced_components INT
DECLARE @common_expert_components INT
DECLARE @pelistal_expert_components INT
DECLARE @nuimqol_expert_components INT
DECLARE @thelodica_expert_components INT

DECLARE @gamma_syndicate_shards INT
DECLARE @gamma_pelistal_shards INT
DECLARE @gamma_nuimqol_shards INT
DECLARE @gamma_thelodica_shards INT

DECLARE @remote_controller_t1 INT
DECLARE @remote_controller_t2 INT
DECLARE @remote_controller_t3 INT

SET @titanium = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_titanium')
SET @cryoperine = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_axicol')
SET @axicoline = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_axicoline')
SET @plasteosine = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_plasteosine')
SET @flux = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_specimen_sap_item_flux')

SET @biotichrin = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_biotichrin')
SET @polynitrocol = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_polynitrocol')
SET @polynucleit = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_polynucleit')
SET @phlobotil = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_phlobotil')

SET @alligior = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_alligior')
SET @hydrobenol = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_hydrobenol')
SET @espitium = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_espitium')
SET @bryochite = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_unimetal') -- unimetal Y U NO bryochite

SET @common_basic_components = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_basic')
SET @common_advanced_components = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_advanced')
SET @common_expert_components = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_expert')

SET @pelistal_expert_components = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_pelistal_expert')
SET @nuimqol_expert_components = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_nuimqol_expert')
SET @thelodica_expert_components = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_thelodica_expert')

SET @gamma_syndicate_shards = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_material_boss_gamma_syndicate')
SET @gamma_pelistal_shards = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_material_boss_gamma_pelistal')
SET @gamma_nuimqol_shards = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_material_boss_gamma_nuimqol')
SET @gamma_thelodica_shards = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_material_boss_gamma_syndicate')

SET @remote_controller_t1 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_remote_controller')
SET @remote_controller_t2 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller')
SET @remote_controller_t3 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller')

-- Spectator --
SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_bot')

DELETE FROM components WHERE definition = @definition

INSERT INTO components (definition, componentdefinition, componentamount) VALUES
(@definition, @biotichrin, 5000),
(@definition, @phlobotil, 3000),
(@definition, @polynucleit, 3000),
(@definition, @polynitrocol, 3000),
(@definition, @titanium, 15000),
(@definition, @plasteosine, 2000),
(@definition, @cryoperine, 3500),
(@definition, @hydrobenol, 3000),
(@definition, @espitium, 10000),
(@definition, @alligior, 5000),
(@definition, @bryochite, 40000),
(@definition, @flux, 500),
(@definition, @gamma_syndicate_shards, 200)

-- Spectator Prototype --
SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_bot_pr')

DELETE FROM components WHERE definition = @definition

INSERT INTO components (definition, componentdefinition, componentamount) VALUES
(@definition, @biotichrin, 5000),
(@definition, @phlobotil, 3000),
(@definition, @polynucleit, 3000),
(@definition, @polynitrocol, 3000),
(@definition, @titanium, 15000),
(@definition, @plasteosine, 2000),
(@definition, @cryoperine, 3500),
(@definition, @hydrobenol, 3000),
(@definition, @espitium, 10000),
(@definition, @alligior, 5000),
(@definition, @bryochite, 40000),
(@definition, @flux, 500),
(@definition, @gamma_syndicate_shards, 200),
(@definition, @common_expert_components, 45),
(@definition, @pelistal_expert_components, 45),
(@definition, @nuimqol_expert_components, 45),
(@definition, @thelodica_expert_components, 45)


-- Remote controller T1 --
SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_remote_controller')

DELETE FROM components WHERE definition = @definition

INSERT INTO components (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium, 50),
(@definition, @cryoperine, 250),
(@definition, @axicoline, 100),
(@definition, @espitium, 50)

-- Remote controller T2 --
SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller')

DELETE FROM components WHERE definition = @definition

INSERT INTO components (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium, 50),
(@definition, @cryoperine, 250),
(@definition, @axicoline, 100),
(@definition, @espitium, 50),
(@definition, @remote_controller_t1, 1)

-- Remote controller T2 prototype --
SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller_pr')

DELETE FROM components WHERE definition = @definition

INSERT INTO components (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium, 50),
(@definition, @cryoperine, 250),
(@definition, @axicoline, 100),
(@definition, @espitium, 50),
(@definition, @remote_controller_t1, 1),
(@definition, @common_basic_components, 30)

-- Remote controller T3 --
SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller')

DELETE FROM components WHERE definition = @definition

INSERT INTO components (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium, 50),
(@definition, @cryoperine, 250),
(@definition, @axicoline, 100),
(@definition, @espitium, 175),
(@definition, @hydrobenol, 50),
(@definition, @remote_controller_t2, 1)

-- Remote controller T3 prototype --
SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller_pr')

DELETE FROM components WHERE definition = @definition

INSERT INTO components (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium, 50),
(@definition, @cryoperine, 250),
(@definition, @axicoline, 100),
(@definition, @espitium, 175),
(@definition, @hydrobenol, 50),
(@definition, @remote_controller_t2, 1),
(@definition, @common_basic_components, 20),
(@definition, @common_advanced_components, 20)

-- Remote controller T4 --
SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_remote_controller')

DELETE FROM components WHERE definition = @definition

INSERT INTO components (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium, 50),
(@definition, @cryoperine, 250),
(@definition, @axicoline, 100),
(@definition, @espitium, 300),
(@definition, @hydrobenol, 100),
(@definition, @bryochite, 50),
(@definition, @remote_controller_t3, 1)

-- Remote controller T4 prototype --
SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_remote_controller_pr')

DELETE FROM components WHERE definition = @definition

INSERT INTO components (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium, 50),
(@definition, @cryoperine, 250),
(@definition, @axicoline, 100),
(@definition, @espitium, 300),
(@definition, @hydrobenol, 100),
(@definition, @bryochite, 50),
(@definition, @remote_controller_t3, 1),
(@definition, @common_basic_components, 15),
(@definition, @common_advanced_components, 30),
(@definition, @common_expert_components, 45)

-- Sentry turrets --
SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_sentry_turret_unit')

DELETE FROM components WHERE definition = @definition

INSERT INTO components (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium, 500),
(@definition, @phlobotil, 500),
(@definition, @polynucleit, 500),
(@definition, @polynitrocol, 500),
(@definition, @axicoline, 500)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_sentry_turret_unit')

DELETE FROM components WHERE definition = @definition

INSERT INTO components (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium, 750),
(@definition, @phlobotil, 750),
(@definition, @polynucleit, 750),
(@definition, @polynitrocol, 750),
(@definition, @axicoline, 750)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_sentry_turret_unit')

DELETE FROM components WHERE definition = @definition

INSERT INTO components (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium, 750),
(@definition, @phlobotil, 750),
(@definition, @polynucleit, 750),
(@definition, @polynitrocol, 750),
(@definition, @axicoline, 750),
(@definition, @espitium, 50)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_sentry_turret_unit')

DELETE FROM components WHERE definition = @definition

INSERT INTO components (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium, 1000),
(@definition, @phlobotil, 1000),
(@definition, @polynucleit, 1000),
(@definition, @polynitrocol, 1000),
(@definition, @axicoline, 1000),
(@definition, @espitium, 100),
(@definition, @bryochite, 50),
(@definition, @flux, 10),
(@definition, @gamma_syndicate_shards, 1)

-- Mining turrets --
SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_mining_turret_unit')

DELETE FROM components WHERE definition = @definition

INSERT INTO components (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium, 500),
(@definition, @axicoline, 500)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_mining_turret_unit')

DELETE FROM components WHERE definition = @definition

INSERT INTO components (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium, 750),
(@definition, @axicoline, 750)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_mining_turret_unit')

DELETE FROM components WHERE definition = @definition

INSERT INTO components (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium, 750),
(@definition, @axicoline, 750),
(@definition, @espitium, 50)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_mining_turret_unit')

DELETE FROM components WHERE definition = @definition

INSERT INTO components (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium, 1000),
(@definition, @axicoline, 1000),
(@definition, @espitium, 100),
(@definition, @bryochite, 50),
(@definition, @flux, 10),
(@definition, @gamma_syndicate_shards, 1)

-- Harvesting turrets --
SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_harvesting_turret_unit')

DELETE FROM components WHERE definition = @definition

INSERT INTO components (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium, 500),
(@definition, @axicoline, 500)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_harvesting_turret_unit')

DELETE FROM components WHERE definition = @definition

INSERT INTO components (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium, 750),
(@definition, @axicoline, 750)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_harvesting_turret_unit')

DELETE FROM components WHERE definition = @definition

INSERT INTO components (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium, 750),
(@definition, @axicoline, 750),
(@definition, @espitium, 50)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_harvesting_turret_unit')

DELETE FROM components WHERE definition = @definition

INSERT INTO components (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium, 1000),
(@definition, @axicoline, 1000),
(@definition, @espitium, 100),
(@definition, @bryochite, 50),
(@definition, @flux, 10),
(@definition, @gamma_syndicate_shards, 1)

-- Pelistal drones --
SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_pelistal_combat_drone_unit')

DELETE FROM components WHERE definition = @definition

INSERT INTO components (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium, 1000),
(@definition, @phlobotil, 2000)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_pelistal_combat_drone_unit')

DELETE FROM components WHERE definition = @definition

INSERT INTO components (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium, 1500),
(@definition, @phlobotil, 3000)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_pelistal_combat_drone_unit')

DELETE FROM components WHERE definition = @definition

INSERT INTO components (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium, 1500),
(@definition, @phlobotil, 3000),
(@definition, @espitium, 10)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_pelistal_combat_drone_unit')

DELETE FROM components WHERE definition = @definition

INSERT INTO components (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium, 2000),
(@definition, @phlobotil, 4000),
(@definition, @espitium, 200),
(@definition, @bryochite, 100),
(@definition, @flux, 20),
(@definition, @gamma_pelistal_shards, 1)

-- Nuimqol drones --
SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_nuimqol_combat_drone_unit')

DELETE FROM components WHERE definition = @definition

INSERT INTO components (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium, 1000),
(@definition, @polynitrocol, 2000)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_nuimqol_combat_drone_unit')

DELETE FROM components WHERE definition = @definition

INSERT INTO components (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium, 1500),
(@definition, @polynitrocol, 3000)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_nuimqol_combat_drone_unit')

DELETE FROM components WHERE definition = @definition

INSERT INTO components (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium, 1500),
(@definition, @polynitrocol, 3000),
(@definition, @espitium, 10)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_nuimqol_combat_drone_unit')

DELETE FROM components WHERE definition = @definition

INSERT INTO components (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium, 2000),
(@definition, @polynitrocol, 4000),
(@definition, @espitium, 200),
(@definition, @bryochite, 100),
(@definition, @flux, 20),
(@definition, @gamma_nuimqol_shards, 20)

-- Thelodica drones --
SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_thelodica_combat_drone_unit')

DELETE FROM components WHERE definition = @definition

INSERT INTO components (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium, 1000),
(@definition, @polynucleit, 2000)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_thelodica_combat_drone_unit')

DELETE FROM components WHERE definition = @definition

INSERT INTO components (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium, 1500),
(@definition, @polynucleit, 3000)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_thelodica_combat_drone_unit')

DELETE FROM components WHERE definition = @definition

INSERT INTO components (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium, 1500),
(@definition, @polynucleit, 3000),
(@definition, @espitium, 10)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_thelodica_combat_drone_unit')

DELETE FROM components WHERE definition = @definition

INSERT INTO components (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium, 2000),
(@definition, @polynucleit, 4000),
(@definition, @espitium, 200),
(@definition, @bryochite, 100),
(@definition, @flux, 20),
(@definition, @gamma_thelodica_shards, 1)

GO

---- Research levels ----

DECLARE @definition INT
DECLARE @calibration INT

-- Spectator prototype

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_bot_pr')
SET @calibration = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_bot_cprg')

DELETE FROM itemresearchlevels WHERE definition = @definition AND calibrationprogram = @calibration

INSERT INTO itemresearchlevels (definition, researchlevel, calibrationprogram, enabled) VALUES
(@definition, 8, @calibration, 1)

-- Remote controller T1

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_remote_controller')
SET @calibration = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_remote_controller_cprg')

DELETE FROM itemresearchlevels WHERE definition = @definition AND calibrationprogram = @calibration

INSERT INTO itemresearchlevels (definition, researchlevel, calibrationprogram, enabled) VALUES
(@definition, 5, @calibration, 1)

-- Remote controller T2 prototype

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller_pr')
SET @calibration = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller_cprg')

DELETE FROM itemresearchlevels WHERE definition = @definition AND calibrationprogram = @calibration

INSERT INTO itemresearchlevels (definition, researchlevel, calibrationprogram, enabled) VALUES
(@definition, 6, @calibration, 1)

-- Remote controller T3 prototype

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller_pr')
SET @calibration = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller_cprg')

DELETE FROM itemresearchlevels WHERE definition = @definition AND calibrationprogram = @calibration

INSERT INTO itemresearchlevels (definition, researchlevel, calibrationprogram, enabled) VALUES
(@definition, 7, @calibration, 1)

-- Remote controller T4 prototype

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_remote_controller_pr')
SET @calibration = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_remote_controller_cprg')

DELETE FROM itemresearchlevels WHERE definition = @definition AND calibrationprogram = @calibration

INSERT INTO [itemresearchlevels] (definition, researchlevel, calibrationprogram, enabled) VALUES
(@definition, 8, @calibration, 1)

-- Sentry turrets

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_sentry_turret_unit')
SET @calibration = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_sentry_turret_unit_cprg')

DELETE FROM itemresearchlevels WHERE definition = @definition AND calibrationprogram = @calibration

INSERT INTO [itemresearchlevels] (definition, researchlevel, calibrationprogram, enabled) VALUES
(@definition, 2, @calibration, 1)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_sentry_turret_unit')
SET @calibration = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_sentry_turret_unit_cprg')

DELETE FROM itemresearchlevels WHERE definition = @definition AND calibrationprogram = @calibration

INSERT INTO [itemresearchlevels] (definition, researchlevel, calibrationprogram, enabled) VALUES
(@definition, 3, @calibration, 1)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_sentry_turret_unit')
SET @calibration = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_sentry_turret_unit_cprg')

DELETE FROM itemresearchlevels WHERE definition = @definition AND calibrationprogram = @calibration

INSERT INTO [itemresearchlevels] (definition, researchlevel, calibrationprogram, enabled) VALUES
(@definition, 4, @calibration, 1)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_sentry_turret_unit')
SET @calibration = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_sentry_turret_unit_cprg')

DELETE FROM itemresearchlevels WHERE definition = @definition AND calibrationprogram = @calibration

INSERT INTO [itemresearchlevels] (definition, researchlevel, calibrationprogram, enabled) VALUES
(@definition, 5, @calibration, 1)

-- Mining turrets

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_mining_turret_unit')
SET @calibration = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_mining_turret_unit_cprg')

DELETE FROM itemresearchlevels WHERE definition = @definition AND calibrationprogram = @calibration

INSERT INTO [itemresearchlevels] (definition, researchlevel, calibrationprogram, enabled) VALUES
(@definition, 2, @calibration, 1)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_mining_turret_unit')
SET @calibration = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_mining_turret_unit_cprg')

DELETE FROM itemresearchlevels WHERE definition = @definition AND calibrationprogram = @calibration

INSERT INTO [itemresearchlevels] (definition, researchlevel, calibrationprogram, enabled) VALUES
(@definition, 3, @calibration, 1)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_mining_turret_unit')
SET @calibration = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_mining_turret_unit_cprg')

DELETE FROM itemresearchlevels WHERE definition = @definition AND calibrationprogram = @calibration

INSERT INTO [itemresearchlevels] (definition, researchlevel, calibrationprogram, enabled) VALUES
(@definition, 4, @calibration, 1)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_mining_turret_unit')
SET @calibration = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_mining_turret_unit_cprg')

DELETE FROM itemresearchlevels WHERE definition = @definition AND calibrationprogram = @calibration

INSERT INTO [itemresearchlevels] (definition, researchlevel, calibrationprogram, enabled) VALUES
(@definition, 5, @calibration, 1)

-- Harvesting turrets

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_harvesting_turret_unit')
SET @calibration = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_harvesting_turret_unit_cprg')

DELETE FROM itemresearchlevels WHERE definition = @definition AND calibrationprogram = @calibration

INSERT INTO [itemresearchlevels] (definition, researchlevel, calibrationprogram, enabled) VALUES
(@definition, 2, @calibration, 1)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_harvesting_turret_unit')
SET @calibration = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_harvesting_turret_unit_cprg')

DELETE FROM itemresearchlevels WHERE definition = @definition AND calibrationprogram = @calibration

INSERT INTO [itemresearchlevels] (definition, researchlevel, calibrationprogram, enabled) VALUES
(@definition, 3, @calibration, 1)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_harvesting_turret_unit')
SET @calibration = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_harvesting_turret_unit_cprg')

DELETE FROM itemresearchlevels WHERE definition = @definition AND calibrationprogram = @calibration

INSERT INTO [itemresearchlevels] (definition, researchlevel, calibrationprogram, enabled) VALUES
(@definition, 4, @calibration, 1)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_harvesting_turret_unit')
SET @calibration = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_harvesting_turret_unit_cprg')

DELETE FROM itemresearchlevels WHERE definition = @definition AND calibrationprogram = @calibration

INSERT INTO [itemresearchlevels] (definition, researchlevel, calibrationprogram, enabled) VALUES
(@definition, 5, @calibration, 1)

-- Pelistal drones

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_pelistal_combat_drone_unit')
SET @calibration = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_pelistal_combat_drone_unit_cprg')

DELETE FROM itemresearchlevels WHERE definition = @definition AND calibrationprogram = @calibration

INSERT INTO [itemresearchlevels] (definition, researchlevel, calibrationprogram, enabled) VALUES
(@definition, 3, @calibration, 1)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_pelistal_combat_drone_unit')
SET @calibration = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_pelistal_combat_drone_unit_cprg')

DELETE FROM itemresearchlevels WHERE definition = @definition AND calibrationprogram = @calibration

INSERT INTO [itemresearchlevels] (definition, researchlevel, calibrationprogram, enabled) VALUES
(@definition, 4, @calibration, 1)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_pelistal_combat_drone_unit')
SET @calibration = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_pelistal_combat_drone_unit_cprg')

DELETE FROM itemresearchlevels WHERE definition = @definition AND calibrationprogram = @calibration

INSERT INTO [itemresearchlevels] (definition, researchlevel, calibrationprogram, enabled) VALUES
(@definition, 5, @calibration, 1)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_pelistal_combat_drone_unit')
SET @calibration = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_pelistal_combat_drone_unit_cprg')

DELETE FROM itemresearchlevels WHERE definition = @definition AND calibrationprogram = @calibration

INSERT INTO [itemresearchlevels] (definition, researchlevel, calibrationprogram, enabled) VALUES
(@definition, 6, @calibration, 1)

-- Nuimqol drones

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_nuimqol_combat_drone_unit')
SET @calibration = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_nuimqol_combat_drone_unit_cprg')

DELETE FROM itemresearchlevels WHERE definition = @definition AND calibrationprogram = @calibration

INSERT INTO [itemresearchlevels] (definition, researchlevel, calibrationprogram, enabled) VALUES
(@definition, 3, @calibration, 1)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_nuimqol_combat_drone_unit')
SET @calibration = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_nuimqol_combat_drone_unit_cprg')

DELETE FROM itemresearchlevels WHERE definition = @definition AND calibrationprogram = @calibration

INSERT INTO [itemresearchlevels] (definition, researchlevel, calibrationprogram, enabled) VALUES
(@definition, 4, @calibration, 1)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_nuimqol_combat_drone_unit')
SET @calibration = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_nuimqol_combat_drone_unit_cprg')

DELETE FROM itemresearchlevels WHERE definition = @definition AND calibrationprogram = @calibration

INSERT INTO [itemresearchlevels] (definition, researchlevel, calibrationprogram, enabled) VALUES
(@definition, 5, @calibration, 1)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_nuimqol_combat_drone_unit')
SET @calibration = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_nuimqol_combat_drone_unit_cprg')

DELETE FROM itemresearchlevels WHERE definition = @definition AND calibrationprogram = @calibration

INSERT INTO [itemresearchlevels] (definition, researchlevel, calibrationprogram, enabled) VALUES
(@definition, 6, @calibration, 1)

-- Thelodica drones

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_thelodica_combat_drone_unit')
SET @calibration = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_thelodica_combat_drone_unit_cprg')

DELETE FROM itemresearchlevels WHERE definition = @definition AND calibrationprogram = @calibration

INSERT INTO [itemresearchlevels] (definition, researchlevel, calibrationprogram, enabled) VALUES
(@definition, 3, @calibration, 1)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_thelodica_combat_drone_unit')
SET @calibration = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_thelodica_combat_drone_unit_cprg')

DELETE FROM itemresearchlevels WHERE definition = @definition AND calibrationprogram = @calibration

INSERT INTO [itemresearchlevels] (definition, researchlevel, calibrationprogram, enabled) VALUES
(@definition, 4, @calibration, 1)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_thelodica_combat_drone_unit')
SET @calibration = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_thelodica_combat_drone_unit_cprg')

DELETE FROM itemresearchlevels WHERE definition = @definition AND calibrationprogram = @calibration

INSERT INTO [itemresearchlevels] (definition, researchlevel, calibrationprogram, enabled) VALUES
(@definition, 5, @calibration, 1)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_thelodica_combat_drone_unit')
SET @calibration = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_thelodica_combat_drone_unit_cprg')

DELETE FROM itemresearchlevels WHERE definition = @definition AND calibrationprogram = @calibration

INSERT INTO [itemresearchlevels] (definition, researchlevel, calibrationprogram, enabled) VALUES
(@definition, 6, @calibration, 1)

GO

---- Create CT capsules for Spectator

DECLARE @categoryFlags BIGINT

SET @categoryFlags = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_ct_capsules_robot_syndicate_commandbot')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_spectator_mk3_A_CT_capsule')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_spectator_mk3_A_CT_capsule', 1, 2052, @categoryFlags, '', 'MK3 CT Capsule', 1, 0.1, 0.1, 0, 100, 'def_spectator_mk3_A_CT_capsule_desc', 1, 1, 1)
END

GO

---- link CT capsules with dynamic templates

DECLARE @definition INT
DECLARE @targetDefinition INT

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_mk3_A_CT_capsule')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_bot_A_dynamic_cprg')

DELETE FROM calibrationtemplateitems WHERE definition = @definition AND targetDefinition = @targetDefinition

INSERT INTO calibrationtemplateitems (definition, targetDefinition) VALUES
(@definition, @targetDefinition)

GO

----Research cost ----

DECLARE @definition INT
DECLARE @common INT
DECLARE @hightech INT
DECLARE @pelistal INT
DECLARE @nuimqol INT
DECLARE @thelodica INT

SET @common = (SELECT TOP 1 id FROM techtreepointtypes WHERE name = 'common')
SET @hightech = (SELECT TOP 1 id FROM techtreepointtypes WHERE name = 'hitech')
SET @pelistal = (SELECT TOP 1 id FROM techtreepointtypes WHERE name = 'pelistal')
SET @nuimqol = (SELECT TOP 1 id FROM techtreepointtypes WHERE name = 'nuimqol')
SET @thelodica = (SELECT TOP 1 id FROM techtreepointtypes WHERE name = 'thelodica')

-- Spectator

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_bot')

DELETE FROM techtreenodeprices WHERE definition = @definition

INSERT INTO [techtreenodeprices] (definition, pointtype, amount) VALUES
(@definition, @common, 150000),
(@definition, @hightech, 150000)

-- Remote controller T1

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_remote_controller')

DELETE FROM techtreenodeprices WHERE definition = @definition

INSERT INTO [techtreenodeprices] (definition, pointtype, amount) VALUES
(@definition, @common, 12800)

-- Remote controller T2

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller')

DELETE FROM techtreenodeprices WHERE definition = @definition

INSERT INTO [techtreenodeprices] (definition, pointtype, amount) VALUES
(@definition, @common, 25000)

-- Remote controller T3

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller')

DELETE FROM techtreenodeprices WHERE definition = @definition

INSERT INTO [techtreenodeprices] (definition, pointtype, amount) VALUES
(@definition, @common, 43200)

-- Remote controller T4

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_remote_controller')

DELETE FROM techtreenodeprices WHERE definition = @definition

INSERT INTO [techtreenodeprices] (definition, pointtype, amount) VALUES
(@definition, @common, 34300),
(@definition, @hightech, 17150)

-- Sentry turrets

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_sentry_turret_unit')

DELETE FROM techtreenodeprices WHERE definition = @definition

INSERT INTO [techtreenodeprices] (definition, pointtype, amount) VALUES
(@definition, @common, 3200)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_sentry_turret_unit')

DELETE FROM techtreenodeprices WHERE definition = @definition

INSERT INTO [techtreenodeprices] (definition, pointtype, amount) VALUES
(@definition, @common, 9600)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_sentry_turret_unit')

DELETE FROM techtreenodeprices WHERE definition = @definition

INSERT INTO [techtreenodeprices] (definition, pointtype, amount) VALUES
(@definition, @common, 21600),
(@definition, @hightech, 7200)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_sentry_turret_unit')

DELETE FROM techtreenodeprices WHERE definition = @definition

INSERT INTO [techtreenodeprices] (definition, pointtype, amount) VALUES
(@definition, @common, 43200),
(@definition, @hightech, 43200)

-- Mining turrets

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_mining_turret_unit')

DELETE FROM techtreenodeprices WHERE definition = @definition

INSERT INTO [techtreenodeprices] (definition, pointtype, amount) VALUES
(@definition, @common, 3200)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_mining_turret_unit')

DELETE FROM techtreenodeprices WHERE definition = @definition

INSERT INTO [techtreenodeprices] (definition, pointtype, amount) VALUES
(@definition, @common, 9600)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_mining_turret_unit')

DELETE FROM techtreenodeprices WHERE definition = @definition

INSERT INTO [techtreenodeprices] (definition, pointtype, amount) VALUES
(@definition, @common, 21600),
(@definition, @hightech, 7200)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_mining_turret_unit')

DELETE FROM techtreenodeprices WHERE definition = @definition

INSERT INTO [techtreenodeprices] (definition, pointtype, amount) VALUES
(@definition, @common, 43200),
(@definition, @hightech, 43200)

-- Harvesting turrets

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_harvesting_turret_unit')

DELETE FROM techtreenodeprices WHERE definition = @definition

INSERT INTO [techtreenodeprices] (definition, pointtype, amount) VALUES
(@definition, @common, 3200)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_harvesting_turret_unit')

DELETE FROM techtreenodeprices WHERE definition = @definition

INSERT INTO [techtreenodeprices] (definition, pointtype, amount) VALUES
(@definition, @common, 9600)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_harvesting_turret_unit')

DELETE FROM techtreenodeprices WHERE definition = @definition

INSERT INTO [techtreenodeprices] (definition, pointtype, amount) VALUES
(@definition, @common, 21600),
(@definition, @hightech, 7200)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_harvesting_turret_unit')

DELETE FROM techtreenodeprices WHERE definition = @definition

INSERT INTO [techtreenodeprices] (definition, pointtype, amount) VALUES
(@definition, @common, 43200),
(@definition, @hightech, 43200)

-- Pelistal drones

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_pelistal_combat_drone_unit')

DELETE FROM techtreenodeprices WHERE definition = @definition

INSERT INTO [techtreenodeprices] (definition, pointtype, amount) VALUES
(@definition, @common, 4000)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_pelistal_combat_drone_unit')

DELETE FROM techtreenodeprices WHERE definition = @definition

INSERT INTO [techtreenodeprices] (definition, pointtype, amount) VALUES
(@definition, @common, 12000)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_pelistal_combat_drone_unit')

DELETE FROM techtreenodeprices WHERE definition = @definition

INSERT INTO [techtreenodeprices] (definition, pointtype, amount) VALUES
(@definition, @common, 27000),
(@definition, @pelistal, 9000)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_pelistal_combat_drone_unit')

DELETE FROM techtreenodeprices WHERE definition = @definition

INSERT INTO [techtreenodeprices] (definition, pointtype, amount) VALUES
(@definition, @common, 54000),
(@definition, @pelistal, 54000)

-- Nuimqol drones

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_nuimqol_combat_drone_unit')

DELETE FROM techtreenodeprices WHERE definition = @definition

INSERT INTO [techtreenodeprices] (definition, pointtype, amount) VALUES
(@definition, @common, 4000)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_nuimqol_combat_drone_unit')

DELETE FROM techtreenodeprices WHERE definition = @definition

INSERT INTO [techtreenodeprices] (definition, pointtype, amount) VALUES
(@definition, @common, 12000)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_nuimqol_combat_drone_unit')

DELETE FROM techtreenodeprices WHERE definition = @definition

INSERT INTO [techtreenodeprices] (definition, pointtype, amount) VALUES
(@definition, @common, 27000),
(@definition, @nuimqol, 9000)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_nuimqol_combat_drone_unit')

DELETE FROM techtreenodeprices WHERE definition = @definition

INSERT INTO [techtreenodeprices] (definition, pointtype, amount) VALUES
(@definition, @common, 54000),
(@definition, @nuimqol, 54000)

-- Thelodica drones

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_thelodica_combat_drone_unit')

DELETE FROM techtreenodeprices WHERE definition = @definition

INSERT INTO [techtreenodeprices] (definition, pointtype, amount) VALUES
(@definition, @common, 4000)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_thelodica_combat_drone_unit')

DELETE FROM techtreenodeprices WHERE definition = @definition

INSERT INTO [techtreenodeprices] (definition, pointtype, amount) VALUES
(@definition, @common, 12000)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_thelodica_combat_drone_unit')

DELETE FROM techtreenodeprices WHERE definition = @definition

INSERT INTO [techtreenodeprices] (definition, pointtype, amount) VALUES
(@definition, @common, 27000),
(@definition, @thelodica, 9000)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_thelodica_combat_drone_unit')

DELETE FROM techtreenodeprices WHERE definition = @definition

INSERT INTO [techtreenodeprices] (definition, pointtype, amount) VALUES
(@definition, @common, 54000),
(@definition, @thelodica, 54000)

GO

---- Link items and their prototypes----

DECLARE @item int
DECLARE @prototype int

-- Spectator

SET @item = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname LIKE 'def_spectator_bot')
SET @prototype = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname LIKE 'def_spectator_bot_pr')

DELETE FROM prototypes WHERE definition = @item AND prototype = @prototype

INSERT INTO prototypes (definition, prototype) VALUES (@item, @prototype)

-- Remote controller T2

SET @item = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname LIKE 'def_named1_remote_controller')
SET @prototype = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname LIKE 'def_named1_remote_controller_pr')

DELETE FROM prototypes WHERE definition = @item AND prototype = @prototype

INSERT INTO prototypes (definition, prototype) VALUES (@item, @prototype)

-- Remote controller T3

SET @item = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname LIKE 'def_named2_remote_controller')
SET @prototype = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname LIKE 'def_named2_remote_controller_pr')

DELETE FROM prototypes WHERE definition = @item AND prototype = @prototype

INSERT INTO prototypes (definition, prototype) VALUES (@item, @prototype)

-- Remote controller T4

SET @item = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname LIKE 'def_named3_remote_controller')
SET @prototype = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname LIKE 'def_named3_remote_controller_pr')

DELETE FROM prototypes WHERE definition = @item AND prototype = @prototype

INSERT INTO prototypes (definition, prototype) VALUES (@item, @prototype)

GO