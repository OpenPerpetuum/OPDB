USE perpetuumsa

GO

DECLARE @targetDefinition INT
DECLARE @spawnid INT
DECLARE @presenceid INT
DECLARE @definition INT

DECLARE @robot INT
DECLARE @head INT
DECLARE @chassis INT
DECLARE @leg INT
DECLARE @inventory INT

DECLARE @sensor_booster INT
DECLARE @eccm INT
DECLARE @shield_hardener INT
DECLARE @repair_upgrade INT
DECLARE @mg_ammo INT
DECLARE @remrep INT
DECLARE @energy_transferer INT
DECLARE @shield INT
DECLARE @recharger INT
DECLARE @accu INT
DECLARE @armor_plate INT

DECLARE @templateId INT

DECLARE @field INT

DECLARE @lootDefinition INT

----

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_termis_support_rank1')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_npc_termis_support_rank1', 1, 1024, 1167, '#faction=SNiani', 'Termis, Shield, Remote Armor Repairer, Energy Transferer', 1, 0, 0, 0, 100, 'def_npc_termis_support_rank1_desc', 1, NULL, NULL)
END
ELSE
BEGIN
	UPDATE entitydefaults SET options = '#faction=SNiani' WHERE definitionname = 'def_npc_termis_support_rank1'
END

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_termis_support_rank2')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_npc_termis_support_rank2', 1, 1024, 1167, '#faction=SNiani', 'Termis, Shield, Remote Armor Repairer, Energy Transferer', 1, 0, 0, 0, 100, 'def_npc_termis_support_rank2_desc', 1, NULL, NULL)
END
ELSE
BEGIN
	UPDATE entitydefaults SET options = '#faction=SNiani' WHERE definitionname = 'def_npc_termis_support_rank2'
END

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_termis_support_rank3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_npc_termis_support_rank3', 1, 1024, 1167, '#faction=SNiani', 'Termis, Shield, Remote Armor Repairer, Energy Transferer', 1, 0, 0, 0, 100, 'def_npc_termis_support_rank3_desc', 1, NULL, NULL)
END
ELSE
BEGIN
	UPDATE entitydefaults SET options = '#faction=SNiani' WHERE definitionname = 'def_npc_termis_support_rank3'
END

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_termis_support_rank4')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_npc_termis_support_rank4', 1, 1024, 1167, '#faction=SNiani', 'Termis, Shield, Remote Armor Repairer, Energy Transferer', 1, 0, 0, 0, 100, 'def_npc_termis_support_rank4_desc', 1, NULL, NULL)
END
ELSE
BEGIN
	UPDATE entitydefaults SET options = '#faction=SNiani' WHERE definitionname = 'def_npc_termis_support_rank4'
END

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_termis_support_rank5')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_npc_termis_support_rank5', 1, 1024, 1167, '#faction=SNiani', 'Termis, Shield, Remote Armor Repairer, Energy Transferer', 1, 0, 0, 0, 100, 'def_npc_termis_support_rank5_desc', 1, NULL, NULL)
END
ELSE
BEGIN
	UPDATE entitydefaults SET options = '#faction=SNiani' WHERE definitionname = 'def_npc_termis_support_rank5'
END

--

SET @robot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_termis_bot')
SET @head = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_termis_head')
SET @chassis = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_termis_chassis')
SET @leg = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_termis_leg')
SET @inventory = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robot_inventory_indy_mech')

SET @sensor_booster = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_sensor_booster')
SET @eccm = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_eccm')
SET @shield_hardener = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_shield_hardener')
SET @repair_upgrade = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_armor_repairer_upgrade')

SET @remrep = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_remote_armor_repairer')
SET @energy_transferer = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_energy_transfer')

SET @shield = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_shield_generator')
SET @recharger = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_core_recharger')
SET @accu = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_core_battery')
SET @armor_plate = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_armor_plate')

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'Termis_Niani_Support_Generic')
BEGIN
	INSERT INTO robottemplates (name, description, note) VALUES
	('Termis_Niani_Support_Generic', CONCAT(
		'#robot=i',
		FORMAT(@robot, 'X'),
		'#head=i',
		FORMAT(@head, 'X'),
		'#chassis=i',
		FORMAT(@chassis, 'X'),
		'#leg=i',
		FORMAT(@leg, 'X'),
		'#container=i',
		FORMAT(@inventory, 'X'),
		'#headModules=[|m0=[|definition=i',
		FORMAT(@sensor_booster, 'X'),
		'|slot=i1]|m1=[|definition=i',
		FORMAT(@eccm, 'X'),
		'|slot=i2]|m2=[|definition=i',
		FORMAT(@shield_hardener, 'X'),
		'|slot=i3]|m3=[|definition=i',
		FORMAT(@repair_upgrade, 'X'),
		'|slot=i4]]#chassisModules=[|m0=[|definition=i',
		FORMAT(@remrep, 'X'),
		'|slot=i2]|m1=[|definition=i',
		FORMAT(@energy_transferer, 'X'),
		'|slot=i3]|m2=[|definition=i',
		FORMAT(@remrep, 'X'),
		'|slot=i4]|m3=[|definition=i',
		FORMAT(@energy_transferer, 'X'),
		'|slot=i5]]#legModules=[|m0=[|definition=i',
		FORMAT(@shield, 'X'),
		'|slot=i1]|m1=[|definition=i',
		FORMAT(@recharger, 'X'),
		'|slot=i2]|m2=[|definition=i',
		FORMAT(@accu, 'X'),
		'|slot=i3]|m3=[|definition=i',
		FORMAT(@armor_plate, 'X'),
		'|slot=i4]]'), 'Termis Niani Support Generic')
END

----

SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_termis_support_rank1')

SET @templateId = (SELECT TOP 1 id FROM robottemplates WHERE name = 'Termis_Niani_Support_Generic')

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note) VALUES
(@targetDefinition, @templateId, 0, NULL, NULL, 1, 'def_npc_termis_support_rank1')

--

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.1)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.1 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.1)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.1 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.9)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.9 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_repair_amount_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.05)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.05 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'falloff_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.1)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.1 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.1)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.1 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.9)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.9 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_repair_cycle_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.95)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.95 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.4)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.4 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission_modifier_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.5 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'detection_strength_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 25)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 25 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'stealth_strength_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, -20)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = -20 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'shield_absorbtion_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.8)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.8 WHERE definition = @targetDefinition AND field = @field
END

----

SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_termis_support_rank2')

SET @templateId = (SELECT TOP 1 id FROM robottemplates WHERE name = 'Termis_Niani_Support_Generic')

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note) VALUES
(@targetDefinition, @templateId, 0, NULL, NULL, 2, 'def_npc_termis_support_rank2')

--

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.8)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.8 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_repair_amount_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.1)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.1 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'falloff_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.8)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.8 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_repair_cycle_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.9)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.9 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.4)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.4 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission_modifier_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.5 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'detection_strength_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 25)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 25 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'stealth_strength_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, -20)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = -20 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'shield_absorbtion_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.85)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.85 WHERE definition = @targetDefinition AND field = @field
END

----

SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_termis_support_rank3')

SET @templateId = (SELECT TOP 1 id FROM robottemplates WHERE name = 'Termis_Niani_Support_Generic')

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note) VALUES
(@targetDefinition, @templateId, 0, NULL, NULL, 2, 'def_npc_termis_support_rank3')

--

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.3)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.3 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.3)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.3 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.7)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.7 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_repair_amount_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.15)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.15 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'falloff_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.3)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.3 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.3)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.3 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.7)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.7 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_repair_cycle_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.85)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.85 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.4)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.4 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission_modifier_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.5 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'detection_strength_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 25)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 25 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'stealth_strength_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, -20)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = -20 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'shield_absorbtion_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.9)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.9 WHERE definition = @targetDefinition AND field = @field
END

----

SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_termis_support_rank4')

SET @templateId = (SELECT TOP 1 id FROM robottemplates WHERE name = 'Termis_Niani_Support_Generic')

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note) VALUES
(@targetDefinition, @templateId, 0, NULL, NULL, 2, 'def_npc_termis_support_rank4')

--

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.4)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.4 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.4)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.4 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.6)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.6 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_repair_amount_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'falloff_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.4)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.4 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.4)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.4 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.6)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.6 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_repair_cycle_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.8)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.8 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.4)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.4 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission_modifier_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.5 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'detection_strength_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 25)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 25 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'stealth_strength_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, -20)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = -20 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'shield_absorbtion_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.95)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.9 WHERE definition = @targetDefinition AND field = @field
END

----

SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_termis_support_rank5')

SET @templateId = (SELECT TOP 1 id FROM robottemplates WHERE name = 'Termis_Niani_Support_Generic')

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note) VALUES
(@targetDefinition, @templateId, 0, NULL, NULL, 2, 'def_npc_termis_support_rank5')

--

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.5 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.5 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.5 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_repair_amount_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.25)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.25 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'falloff_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.5 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.5 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.5 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_repair_cycle_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.75)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.75 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.4)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.4 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission_modifier_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.5 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'detection_strength_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 25)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 25 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'stealth_strength_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, -20)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = -20 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'shield_absorbtion_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.1)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1 WHERE definition = @targetDefinition AND field = @field
END

--------

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_argano_support_rank1')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_npc_argano_support_rank1', 1, 1024, 1167, '#faction=SNiani', 'Argano, Shield, Remote Armor Repairer, Energy Transferer', 1, 0, 0, 0, 100, 'def_npc_argano_support_rank1_desc', 1, NULL, NULL)
END
ELSE
BEGIN
	UPDATE entitydefaults SET options = '#faction=SNiani' WHERE definitionname = 'def_npc_argano_support_rank1'
END

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_argano_support_rank2')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_npc_argano_support_rank2', 1, 1024, 1167, '#faction=SNiani', 'Argano, Shield, Remote Armor Repairer, Energy Transferer', 1, 0, 0, 0, 100, 'def_npc_argano_support_rank2_desc', 1, NULL, NULL)
END
ELSE
BEGIN
	UPDATE entitydefaults SET options = '#faction=SNiani' WHERE definitionname = 'def_npc_argano_support_rank2'
END

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_argano_support_rank3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_npc_argano_support_rank3', 1, 1024, 1167, '#faction=SNiani', 'Argano, Shield, Remote Armor Repairer, Energy Transferer', 1, 0, 0, 0, 100, 'def_npc_argano_support_rank3_desc', 1, NULL, NULL)
END
ELSE
BEGIN
	UPDATE entitydefaults SET options = '#faction=SNiani' WHERE definitionname = 'def_npc_argano_support_rank3'
END

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_argano_support_rank4')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_npc_argano_support_rank4', 1, 1024, 1167, '#faction=SNiani', 'Argano, Shield, Remote Armor Repairer, Energy Transferer', 1, 0, 0, 0, 100, 'def_npc_argano_support_rank4_desc', 1, NULL, NULL)
END
ELSE
BEGIN
	UPDATE entitydefaults SET options = '#faction=SNiani' WHERE definitionname = 'def_npc_argano_support_rank4'
END

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_argano_support_rank5')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_npc_argano_support_rank5', 1, 1024, 1167, '#faction=SNiani', 'Argano, Shield, Remote Armor Repairer, Energy Transferer', 1, 0, 0, 0, 100, 'def_npc_argano_support_rank5_desc', 1, NULL, NULL)
END
ELSE
BEGIN
	UPDATE entitydefaults SET options = '#faction=SNiani' WHERE definitionname = 'def_npc_argano_support_rank5'
END

--

SET @robot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_argano_bot')
SET @head = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_argano_head')
SET @chassis = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_argano_chassis')
SET @leg = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_argano_leg')
SET @inventory = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robot_inventory_combat_ewmech_indy_runner')

SET @sensor_booster = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_sensor_booster')
SET @eccm = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_eccm')
SET @repair_upgrade = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_armor_repairer_upgrade')

SET @remrep = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_small_remote_armor_repairer')
SET @energy_transferer = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_small_energy_transfer')

SET @shield = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_small_shield_generator')
SET @recharger = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_core_recharger')
SET @accu = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_small_core_battery')

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'Argano_Niani_Support_Generic')
BEGIN
	INSERT INTO robottemplates (name, description, note) VALUES
	('Argano_Niani_Support_Generic', CONCAT(
		'#robot=i',
		FORMAT(@robot, 'X'),
		'#head=i',
		FORMAT(@head, 'X'),
		'#chassis=i',
		FORMAT(@chassis, 'X'),
		'#leg=i',
		FORMAT(@leg, 'X'),
		'#container=i',
		FORMAT(@inventory, 'X'),
		'#headModules=[|m0=[|definition=i',
		FORMAT(@sensor_booster, 'X'),
		'|slot=i1]|m1=[|definition=i',
		FORMAT(@eccm, 'X'),
		'|slot=i2]|m2=[|definition=i',
		FORMAT(@repair_upgrade, 'X'),
		'|slot=i3]]#chassisModules=[|m0=[|definition=i',
		FORMAT(@remrep, 'X'),
		'|slot=i1]|m1=[|definition=i',
		FORMAT(@remrep, 'X'),
		'|slot=i2]|m2=[|definition=i',
		FORMAT(@energy_transferer, 'X'),
		'|slot=i3]]#legModules=[|m0=[|definition=i',
		FORMAT(@shield, 'X'),
		'|slot=i1]|m1=[|definition=i',
		FORMAT(@recharger, 'X'),
		'|slot=i2]|m2=[|definition=i',
		FORMAT(@accu, 'X'),
		'|slot=i3]]'), 'Argano Niani Support Generic')
END

----

SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_argano_support_rank1')

SET @templateId = (SELECT TOP 1 id FROM robottemplates WHERE name = 'Argano_Niani_Support_Generic')

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note) VALUES
(@targetDefinition, @templateId, 0, NULL, NULL, 1, 'def_npc_argano_support_rank1')

--

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.1)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.1 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.1)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.1 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.9)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.9 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_repair_amount_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.05)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.05 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'falloff_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.1)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.1 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.1)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.1 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.9)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.9 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_repair_cycle_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.95)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.95 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.4)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.4 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission_modifier_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.5 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'detection_strength_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 25)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 25 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'stealth_strength_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, -20)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = -20 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'shield_absorbtion_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.8)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.8 WHERE definition = @targetDefinition AND field = @field
END

----

SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_argano_support_rank2')

SET @templateId = (SELECT TOP 1 id FROM robottemplates WHERE name = 'Argano_Niani_Support_Generic')

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note) VALUES
(@targetDefinition, @templateId, 0, NULL, NULL, 2, 'def_npc_argano_support_rank2')

--

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.8)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.8 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_repair_amount_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.1)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.1 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'falloff_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.8)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.8 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_repair_cycle_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.9)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.9 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.4)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.4 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission_modifier_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.5 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'detection_strength_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 25)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 25 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'stealth_strength_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, -20)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = -20 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'shield_absorbtion_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.85)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.85 WHERE definition = @targetDefinition AND field = @field
END

----

SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_argano_support_rank3')

SET @templateId = (SELECT TOP 1 id FROM robottemplates WHERE name = 'Argano_Niani_Support_Generic')

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note) VALUES
(@targetDefinition, @templateId, 0, NULL, NULL, 2, 'def_npc_argano_support_rank3')

--

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.3)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.3 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.3)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.3 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.7)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.7 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_repair_amount_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.15)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.15 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'falloff_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.3)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.3 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.3)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.3 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.7)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.7 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_repair_cycle_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.85)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.85 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.4)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.4 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission_modifier_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.5 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'detection_strength_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 25)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 25 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'stealth_strength_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, -20)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = -20 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'shield_absorbtion_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.9)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.9 WHERE definition = @targetDefinition AND field = @field
END

----

SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_argano_support_rank4')

SET @templateId = (SELECT TOP 1 id FROM robottemplates WHERE name = 'Argano_Niani_Support_Generic')

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note) VALUES
(@targetDefinition, @templateId, 0, NULL, NULL, 2, 'def_npc_argano_support_rank4')

--

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.4)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.4 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.4)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.4 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.6)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.6 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_repair_amount_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'falloff_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.4)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.4 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.4)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.4 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.6)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.6 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_repair_cycle_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.8)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.8 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.4)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.4 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission_modifier_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.5 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'detection_strength_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 25)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 25 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'stealth_strength_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, -20)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = -20 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'shield_absorbtion_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.95)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.9 WHERE definition = @targetDefinition AND field = @field
END

----

SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_argano_support_rank5')

SET @templateId = (SELECT TOP 1 id FROM robottemplates WHERE name = 'Argano_Niani_Support_Generic')

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note) VALUES
(@targetDefinition, @templateId, 0, NULL, NULL, 2, 'def_npc_argano_support_rank5')

--

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.5 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.5 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.5 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_repair_amount_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.25)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.25 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'falloff_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.5 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.5 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.5 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_repair_cycle_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.75)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.75 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.4)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.4 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission_modifier_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.5 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'detection_strength_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 25)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 25 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'stealth_strength_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, -20)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = -20 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'shield_absorbtion_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.1)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1 WHERE definition = @targetDefinition AND field = @field
END

--------

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_riveler_support_rank1')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_npc_riveler_support_rank1', 1, 1024, 1167, '#faction=SNiani', 'Riveler, Shield, Remote Armor Repairer, Energy Transferer', 1, 0, 0, 0, 100, 'def_npc_riveler_support_rank1_desc', 1, NULL, NULL)
END
ELSE
BEGIN
	UPDATE entitydefaults SET options = '#faction=SNiani' WHERE definitionname = 'def_npc_riveler_support_rank1'
END

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_riveler_support_rank2')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_npc_riveler_support_rank2', 1, 1024, 1167, '#faction=SNiani', 'Riveler, Shield, Remote Armor Repairer, Energy Transferer', 1, 0, 0, 0, 100, 'def_npc_riveler_support_rank2_desc', 1, NULL, NULL)
END
ELSE
BEGIN
	UPDATE entitydefaults SET options = '#faction=SNiani' WHERE definitionname = 'def_npc_riveler_support_rank2'
END

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_riveler_support_rank3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_npc_riveler_support_rank3', 1, 1024, 1167, '#faction=SNiani', 'Riveler, Shield, Remote Armor Repairer, Energy Transferer', 1, 0, 0, 0, 100, 'def_npc_riveler_support_rank3_desc', 1, NULL, NULL)
END
ELSE
BEGIN
	UPDATE entitydefaults SET options = '#faction=SNiani' WHERE definitionname = 'def_npc_riveler_support_rank3'
END

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_riveler_support_rank4')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_npc_riveler_support_rank4', 1, 1024, 1167, '#faction=SNiani', 'Riveler, Shield, Remote Armor Repairer, Energy Transferer', 1, 0, 0, 0, 100, 'def_npc_riveler_support_rank4_desc', 1, NULL, NULL)
END
ELSE
BEGIN
	UPDATE entitydefaults SET options = '#faction=SNiani' WHERE definitionname = 'def_npc_riveler_support_rank4'
END

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_riveler_support_rank5')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_npc_riveler_support_rank5', 1, 1024, 1167, '#faction=SNiani', 'Riveler, Shield, Remote Armor Repairer, Energy Transferer', 1, 0, 0, 0, 100, 'def_npc_riveler_support_rank5_desc', 1, NULL, NULL)
END
ELSE
BEGIN
	UPDATE entitydefaults SET options = '#faction=SNiani' WHERE definitionname = 'def_npc_riveler_support_rank5'
END

--

SET @robot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_riveler_bot')
SET @head = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_riveler_head')
SET @chassis = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_riveler_chassis')
SET @leg = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_riveler_leg')
SET @inventory = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robot_inventory_indy_heavymech')

SET @sensor_booster = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_sensor_booster')
SET @eccm = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_eccm')
SET @repair_upgrade = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_armor_repairer_upgrade')
SET @shield_hardener = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_shield_hardener')

SET @remrep = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_remote_armor_repairer')
SET @energy_transferer = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_energy_transfer')

SET @shield = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_shield_generator')
SET @recharger = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_core_recharger')
SET @accu = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_core_battery')
SET @armor_plate = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_armor_plate')

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'Riveler_Niani_Support_Generic')
BEGIN
	INSERT INTO robottemplates (name, description, note) VALUES
	('Riveler_Niani_Support_Generic', CONCAT(
		'#robot=i',
		FORMAT(@robot, 'X'),
		'#head=i',
		FORMAT(@head, 'X'),
		'#chassis=i',
		FORMAT(@chassis, 'X'),
		'#leg=i',
		FORMAT(@leg, 'X'),
		'#container=i',
		FORMAT(@inventory, 'X'),
		'#headModules=[|m0=[|definition=i',
		FORMAT(@sensor_booster, 'X'),
		'|slot=i1]|m1=[|definition=i',
		FORMAT(@eccm, 'X'),
		'|slot=i2]|m2=[|definition=i',
		FORMAT(@repair_upgrade, 'X'),
		'|slot=i3]|m3=[|definition=i',
		FORMAT(@shield_hardener, 'X'),
		'|slot=i4]]#chassisModules=[|m0=[|definition=i',
		FORMAT(@remrep, 'X'),
		'|slot=i1]|m1=[|definition=i',
		FORMAT(@energy_transferer, 'X'),
		'|slot=i2]|m2=[|definition=i',
		FORMAT(@remrep, 'X'),
		'|slot=i3]|m3=[|definition=i',
		FORMAT(@remrep, 'X'),
		'|slot=i4]|m4=[|definition=i',
		FORMAT(@energy_transferer, 'X'),
		'|slot=i5]|m5=[|definition=i',
		FORMAT(@energy_transferer, 'X'),
		'|slot=i6]]#legModules=[|m0=[|definition=i',
		FORMAT(@shield, 'X'),
		'|slot=i1]|m1=[|definition=i',
		FORMAT(@recharger, 'X'),
		'|slot=i2]|m2=[|definition=i',
		FORMAT(@recharger, 'X'),
		'|slot=i3]|m3=[|definition=i',
		FORMAT(@accu, 'X'),
		'|slot=i4]|m4=[|definition=i',
		FORMAT(@armor_plate, 'X'),
		'|slot=i5]]'), 'Riveler Niani Support Generic')
END

----

SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_riveler_support_rank1')

SET @templateId = (SELECT TOP 1 id FROM robottemplates WHERE name = 'Riveler_Niani_Support_Generic')

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note) VALUES
(@targetDefinition, @templateId, 0, NULL, NULL, 1, 'def_npc_riveler_support_rank1')

--

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.1)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.1 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.1)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.1 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.9)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.9 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_repair_amount_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.05)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.05 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'falloff_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.1)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.1 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.1)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.1 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.9)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.9 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_repair_cycle_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.95)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.95 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.4)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.4 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission_modifier_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.5 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'detection_strength_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 25)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 25 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'stealth_strength_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, -20)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = -20 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'shield_absorbtion_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.8)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.8 WHERE definition = @targetDefinition AND field = @field
END

----

SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_riveler_support_rank2')

SET @templateId = (SELECT TOP 1 id FROM robottemplates WHERE name = 'Riveler_Niani_Support_Generic')

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note) VALUES
(@targetDefinition, @templateId, 0, NULL, NULL, 2, 'def_npc_riveler_support_rank2')

--

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.8)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.8 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_repair_amount_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.1)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.1 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'falloff_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.8)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.8 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_repair_cycle_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.9)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.9 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.4)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.4 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission_modifier_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.5 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'detection_strength_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 25)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 25 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'stealth_strength_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, -20)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = -20 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'shield_absorbtion_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.85)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.85 WHERE definition = @targetDefinition AND field = @field
END

----

SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_riveler_support_rank3')

SET @templateId = (SELECT TOP 1 id FROM robottemplates WHERE name = 'Riveler_Niani_Support_Generic')

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note) VALUES
(@targetDefinition, @templateId, 0, NULL, NULL, 2, 'def_npc_riveler_support_rank3')

--

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.3)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.3 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.3)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.3 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.7)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.7 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_repair_amount_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.15)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.15 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'falloff_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.3)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.3 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.3)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.3 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.7)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.7 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_repair_cycle_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.85)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.85 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.4)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.4 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission_modifier_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.5 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'detection_strength_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 25)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 25 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'stealth_strength_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, -20)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = -20 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'shield_absorbtion_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.9)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.9 WHERE definition = @targetDefinition AND field = @field
END

----

SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_riveler_support_rank4')

SET @templateId = (SELECT TOP 1 id FROM robottemplates WHERE name = 'Riveler_Niani_Support_Generic')

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note) VALUES
(@targetDefinition, @templateId, 0, NULL, NULL, 2, 'def_npc_riveler_support_rank4')

--

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.4)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.4 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.4)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.4 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.6)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.6 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_repair_amount_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'falloff_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.4)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.4 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.4)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.4 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.6)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.6 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_repair_cycle_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.8)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.8 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.4)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.4 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission_modifier_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.5 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'detection_strength_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 25)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 25 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'stealth_strength_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, -20)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = -20 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'shield_absorbtion_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.95)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.9 WHERE definition = @targetDefinition AND field = @field
END

----

SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_riveler_support_rank5')

SET @templateId = (SELECT TOP 1 id FROM robottemplates WHERE name = 'Riveler_Niani_Support_Generic')

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note) VALUES
(@targetDefinition, @templateId, 0, NULL, NULL, 2, 'def_npc_riveler_support_rank5')

--

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.5 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.5 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.5 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_repair_amount_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.25)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.25 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'falloff_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.5 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.5 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.5 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_repair_cycle_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.75)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.75 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.4)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.4 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission_modifier_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.5 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'detection_strength_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 25)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 25 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'stealth_strength_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, -20)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = -20 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'shield_absorbtion_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.1)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1 WHERE definition = @targetDefinition AND field = @field
END

----

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'hershfield_numiquol_npcs1')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_argano_support_rank3')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'argano_support_at_spawn41')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('argano_support_at_spawn41', @presenceid, 1, @definition, 1510, 620, 0, 5, 60, 0, 30, 'def_npc_argano_support_rank3', 1, 1, 1, 1, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET respawnseconds = 60 WHERE name = 'argano_support_at_spawn41'
END

--

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'hershfield_numiquol_npcs10')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_termis_support_rank2')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'termis_support_at_spawn50')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('termis_support_at_spawn50', @presenceid, 1, @definition, 1540, 450, 0, 5, 60, 0, 30, 'def_npc_termis_support_rank2', 1, 1, 1, 1, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET respawnseconds = 60 WHERE name = 'termis_support_at_spawn50'
END

--

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'hershfield_numiquol_npcs2')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_argano_support_rank3')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'argano_support_at_spawn42')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('argano_support_at_spawn42', @presenceid, 2, @definition, 1540, 450, 0, 5, 60, 0, 30, 'def_npc_argano_support_rank3', 1, 1, 1, 1, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET respawnseconds = 60 WHERE name = 'argano_support_at_spawn42'
END

--

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'hershfield_numiquol_npcs3')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_argano_support_rank4')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'argano_support_at_spawn43')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('argano_support_at_spawn43', @presenceid, 2, @definition, 1350, 320, 0, 5, 60, 0, 30, 'def_npc_argano_support_rank4', 1, 1, 1, 1, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET respawnseconds = 60 WHERE name = 'argano_support_at_spawn43'
END

--

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'hershfield_numiquol_npcs4')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_argano_support_rank3')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'argano_support_at_spawn44')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('argano_support_at_spawn44', @presenceid, 2, @definition, 1260, 420, 0, 5, 60, 0, 30, 'def_npc_argano_support_rank3', 1, 1, 1, 1, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET respawnseconds = 60 WHERE name = 'argano_support_at_spawn44'
END

--

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'hershfield_numiquol_npcs5')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_termis_support_rank3')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'termis_support_at_spawn45')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('termis_support_at_spawn45', @presenceid, 2, @definition, 1170, 420, 0, 5, 60, 0, 30, 'def_npc_termis_support_rank3', 1, 1, 1, 1, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET respawnseconds = 60 WHERE name = 'termis_support_at_spawn45'
END

--

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'hershfield_numiquol_npcs6')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_riveler_support_rank4')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'riveler_support_at_spawn46')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('riveler_support_at_spawn46', @presenceid, 2, @definition, 1030, 380, 0, 5, 60, 0, 30, 'def_npc_riveler_support_rank4', 1, 1, 1, 1, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET respawnseconds = 60 WHERE name = 'riveler_support_at_spawn46'
END

--

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'hershfield_numiquol_npcs7')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_riveler_support_rank4')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'riveler_support_at_spawn47')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('riveler_support_at_spawn47', @presenceid, 3, @definition, 1320, 540, 0, 5, 60, 0, 30, 'def_npc_riveler_support_rank4', 1, 1, 1, 1, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET respawnseconds = 60 WHERE name = 'riveler_support_at_spawn47'
END

--

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'hershfield_numiquol_npcs8')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_termis_support_rank4')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'termis_support_at_spawn48')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('termis_support_at_spawn48', @presenceid, 1, @definition, 1470, 290, 0, 5, 60, 0, 30, 'def_npc_termis_support_rank4', 1, 1, 1, 1, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET respawnseconds = 60 WHERE name = 'termis_support_at_spawn48'
END

--

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'hershfield_numiquol_npcs9')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_riveler_support_rank4')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'riveler_support_at_spawn49')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('riveler_support_at_spawn49', @presenceid, 3, @definition, 1290, 280, 0, 5, 60, 0, 30, 'def_npc_riveler_support_rank4', 1, 1, 1, 1, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET respawnseconds = 60 WHERE name = 'riveler_support_at_spawn49'
END

--

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'hershfield_pelistal_npcs')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_termis_support_rank2')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'termis_support_at_spawn30')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('termis_support_at_spawn30', @presenceid, 2, @definition, 240, 1700, 0, 5, 60, 0, 30, 'def_npc_termis_support_rank2', 1, 1, 1, 1, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET respawnseconds = 60 WHERE name = 'termis_support_at_spawn30'
END

--

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'hershfield_pelistal_npcs')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_argano_support_rank3')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'argano_support_at_spawn21')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('argano_support_at_spawn21', @presenceid, 1, @definition, 1290, 1410, 0, 5, 60, 0, 30, 'def_npc_argano_support_rank3', 1, 1, 1, 1, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET respawnseconds = 60 WHERE name = 'argano_support_at_spawn21'
END

--

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'hershfield_pelistal_npcs')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_argano_support_rank4')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'argano_support_at_spawn22')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('argano_support_at_spawn22', @presenceid, 2, @definition, 1180, 1490, 0, 5, 60, 0, 30, 'def_npc_argano_support_rank4', 1, 1, 1, 1, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET respawnseconds = 60 WHERE name = 'argano_support_at_spawn22'
END

--

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'hershfield_pelistal_npcs')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_argano_support_rank4')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'argano_support_at_spawn23')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('argano_support_at_spawn23', @presenceid, 2, @definition, 1030, 1390, 0, 5, 60, 0, 30, 'def_npc_argano_support_rank4', 1, 1, 1, 1, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET respawnseconds = 60 WHERE name = 'argano_support_at_spawn23'
END

--

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'hershfield_pelistal_npcs')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_argano_support_rank3')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'argano_support_at_spawn24')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('argano_support_at_spawn24', @presenceid, 2, @definition, 940, 1500, 0, 5, 60, 0, 30, 'def_npc_argano_support_rank3', 1, 1, 1, 1, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET respawnseconds = 60 WHERE name = 'argano_support_at_spawn24'
END

--

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'hershfield_pelistal_npcs')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_termis_support_rank3')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'termis_support_at_spawn25')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('termis_support_at_spawn25', @presenceid, 2, @definition, 740, 1450, 0, 5, 60, 0, 30, 'def_npc_termis_support_rank3', 1, 1, 1, 1, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET respawnseconds = 60 WHERE name = 'termis_support_at_spawn25'
END

--

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'hershfield_pelistal_npcs')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_riveler_support_rank4')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'riveler_support_at_spawn26')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('riveler_support_at_spawn26', @presenceid, 2, @definition, 600, 1485, 0, 5, 60, 0, 30, 'def_npc_riveler_support_rank4', 1, 1, 1, 1, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET respawnseconds = 60 WHERE name = 'riveler_support_at_spawn26'
END

--

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'hershfield_pelistal_npcs')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_riveler_support_rank4')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'riveler_support_at_spawn26')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('riveler_support_at_spawn26', @presenceid, 2, @definition, 600, 1485, 0, 5, 60, 0, 30, 'def_npc_riveler_support_rank4', 1, 1, 1, 1, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET respawnseconds = 60 WHERE name = 'riveler_support_at_spawn26'
END

--

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'hershfield_pelistal_npcs')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_riveler_support_rank4')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'riveler_support_at_spawn27')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('riveler_support_at_spawn27', @presenceid, 3, @definition, 690, 1700, 0, 5, 60, 0, 30, 'def_npc_riveler_support_rank4', 1, 1, 1, 1, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET respawnseconds = 60 WHERE name = 'riveler_support_at_spawn27'
END

--

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'hershfield_pelistal_npcs')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_riveler_support_rank4')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'riveler_support_at_spawn27')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('riveler_support_at_spawn27', @presenceid, 3, @definition, 690, 1700, 0, 5, 60, 0, 30, 'def_npc_riveler_support_rank4', 1, 1, 1, 1, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET respawnseconds = 60 WHERE name = 'riveler_support_at_spawn27'
END

--

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'hershfield_pelistal_npcs')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_termis_support_rank4')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'termis_support_at_spawn28')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('termis_support_at_spawn28', @presenceid, 3, @definition, 500, 1730, 0, 5, 60, 0, 30, 'def_npc_termis_support_rank4', 1, 1, 1, 1, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET respawnseconds = 60 WHERE name = 'termis_support_at_spawn28'
END

--

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'hershfield_pelistal_npcs')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_riveler_support_rank4')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'riveler_support_at_spawn29')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('riveler_support_at_spawn29', @presenceid, 3, @definition, 400, 1560, 0, 5, 60, 0, 30, 'def_npc_riveler_support_rank4', 1, 1, 1, 1, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET respawnseconds = 60 WHERE name = 'riveler_support_at_spawn29'
END

--

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'hershfield_theolodical_npcs')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_argano_support_rank3')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'argano_support_at_spawn31')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('argano_support_at_spawn31', @presenceid, 1, @definition, 740, 550, 0, 5, 60, 0, 30, 'def_npc_argano_support_rank3', 1, 1, 1, 1, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET respawnseconds = 60 WHERE name = 'argano_support_at_spawn31'
END

--

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'hershfield_theolodical_npcs')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_argano_support_rank3')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'argano_support_at_spawn32')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('argano_support_at_spawn32', @presenceid, 2, @definition, 620, 720, 0, 5, 60, 0, 30, 'def_npc_argano_support_rank3', 1, 1, 1, 1, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET respawnseconds = 60 WHERE name = 'argano_support_at_spawn32'
END

--

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'hershfield_theolodical_npcs')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_argano_support_rank4')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'argano_support_at_spawn33')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('argano_support_at_spawn33', @presenceid, 2, @definition, 520, 920, 0, 5, 60, 0, 30, 'def_npc_argano_support_rank4', 1, 1, 1, 1, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET respawnseconds = 60 WHERE name = 'argano_support_at_spawn33'
END

--

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'hershfield_theolodical_npcs')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_argano_support_rank3')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'argano_support_at_spawn34')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('argano_support_at_spawn34', @presenceid, 1, @definition, 455, 740, 0, 5, 60, 0, 30, 'def_npc_argano_support_rank3', 1, 1, 1, 1, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET respawnseconds = 60 WHERE name = 'argano_support_at_spawn34'
END

--

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'hershfield_theolodical_npcs')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_termis_support_rank3')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'termis_support_at_spawn35')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('termis_support_at_spawn35', @presenceid, 2, @definition, 820, 320, 0, 5, 60, 0, 30, 'def_npc_termis_support_rank3', 1, 1, 1, 1, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET respawnseconds = 60 WHERE name = 'termis_support_at_spawn35'
END

--

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'hershfield_theolodical_npcs')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_termis_support_rank3')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'termis_support_at_spawn35')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('termis_support_at_spawn35', @presenceid, 2, @definition, 820, 320, 0, 5, 60, 0, 30, 'def_npc_termis_support_rank3', 1, 1, 1, 1, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET respawnseconds = 60 WHERE name = 'termis_support_at_spawn35'
END

--

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'hershfield_theolodical_npcs')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_riveler_support_rank4')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'riveler_support_at_spawn36')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('riveler_support_at_spawn36', @presenceid, 2, @definition, 600, 430, 0, 5, 60, 0, 30, 'def_npc_riveler_support_rank4', 1, 1, 1, 1, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET respawnseconds = 60 WHERE name = 'riveler_support_at_spawn36'
END

--

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'hershfield_theolodical_npcs')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_riveler_support_rank4')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'riveler_support_at_spawn37')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('riveler_support_at_spawn37', @presenceid, 3, @definition, 430, 540, 0, 5, 60, 0, 30, 'def_npc_riveler_support_rank4', 1, 1, 1, 1, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET respawnseconds = 60 WHERE name = 'riveler_support_at_spawn37'
END

--

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'hershfield_theolodical_npcs')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_termis_support_rank4')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'termis_support_at_spawn38')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('termis_support_at_spawn38', @presenceid, 2, @definition, 550, 250, 0, 5, 60, 0, 30, 'def_npc_termis_support_rank4', 1, 1, 1, 1, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET respawnseconds = 60 WHERE name = 'termis_support_at_spawn38'
END

--

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'hershfield_theolodical_npcs')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_riveler_support_rank4')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'riveler_support_at_spawn39')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('riveler_support_at_spawn39', @presenceid, 3, @definition, 260, 650, 0, 5, 60, 0, 30, 'def_npc_riveler_support_rank4', 1, 1, 1, 1, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET respawnseconds = 60 WHERE name = 'riveler_support_at_spawn39'
END

--

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'hershfield_theolodical_npcs')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_argano_support_rank2')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'argano_support_at_spawn30')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('argano_support_at_spawn30', @presenceid, 1, @definition, 385, 300, 0, 5, 60, 0, 30, 'def_npc_argano_support_rank2', 1, 1, 1, 1, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET respawnseconds = 60 WHERE name = 'argano_support_at_spawn30'
END

----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_argano_support_rank1')

DELETE FROM npcloot WHERE definition = @definition

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_basic')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 5, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_sensor_booster')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_eccm')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_armor_repairer_upgrade')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_small_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_small_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_small_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_small_shield_generator')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_core_recharger')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_small_core_battery')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_1')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_2')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_common_reactor_plasma')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 16, 1, 0, 0, 13)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_common')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 24, 1, 0, 1, 16)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_industrial')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 12, 1, 0, 1, 8)

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_argano_support_rank2')

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_basic')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 10, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_advanced')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 5, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_sensor_booster')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.1, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_sensor_booster')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_eccm')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.1, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_eccm')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_armor_repairer_upgrade')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.1, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_armor_repairer_upgrade')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_small_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.1, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_small_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_small_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.1, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_small_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_small_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.1, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_small_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_small_shield_generator')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.1, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_small_shield_generator')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_core_recharger')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.1, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_core_recharger')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_small_core_battery')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.1, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_small_core_battery')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_1')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.01, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_2')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.01, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_3')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_4')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_common_reactor_plasma')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 21, 1, 0, 0, 17)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_common')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 48, 1, 0, 1, 32)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_industrial')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 24, 1, 0, 1, 16)

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_argano_support_rank3')

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_basic')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 7, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_advanced')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 5, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_expert')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 3, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_sensor_booster')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.125, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_sensor_booster')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_eccm')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.125, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_eccm')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_armor_repairer_upgrade')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.125, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_armor_repairer_upgrade')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_small_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.125, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_small_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_small_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.125, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_small_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_small_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.125, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_small_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_small_shield_generator')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.125, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_small_shield_generator')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_core_recharger')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.125, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_core_recharger')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_small_core_battery')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.125, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_small_core_battery')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_1')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.02, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_2')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.02, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_3')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.01, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_4')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.01, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_5')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_6')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_common_reactor_plasma')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 32, 1, 0, 0, 26)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_common')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 96, 1, 0, 1, 64)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_industrial')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 48, 1, 0, 1, 32)

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_argano_support_rank4')

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_basic')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 5, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_advanced')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 5, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_expert')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 5, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_sensor_booster')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.15, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_sensor_booster')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_eccm')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.15, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_eccm')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_armor_repairer_upgrade')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.15, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_armor_repairer_upgrade')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_small_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.15, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_small_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_small_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.15, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_small_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_small_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.15, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_small_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_small_shield_generator')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.15, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_small_shield_generator')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_core_recharger')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.15, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_core_recharger')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_small_core_battery')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.15, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_small_core_battery')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_3')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.02, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_4')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.02, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_5')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.01, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_6')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.01, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_7')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_8')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_common_reactor_plasma')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 48, 1, 0, 0, 39)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_hitech')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 24, 1, 0, 1, 16)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_industrial')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 96, 1, 0, 1, 64)

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_argano_support_rank5')

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_basic')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 3, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_advanced')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 5, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_expert')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 7, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_sensor_booster')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_sensor_booster')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_eccm')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_eccm')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_armor_repairer_upgrade')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_armor_repairer_upgrade')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_small_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_small_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_small_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_small_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_small_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_small_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_small_shield_generator')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_small_shield_generator')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_core_recharger')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_core_recharger')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_small_core_battery')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_small_core_battery')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_5')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.02, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_6')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.02, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_7')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.01, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_8')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.01, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_9')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_10')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_common_reactor_plasma')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 71, 1, 0, 0, 58)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_hitech')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 48, 1, 0, 1, 32)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_industrial')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 192, 1, 0, 1, 128)

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_termis_support_rank1')

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_basic')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 5, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_sensor_booster')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.05, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_eccm')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.05, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_armor_repairer_upgrade')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.05, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_shield_hardener')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.05, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.05, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.05, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.05, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.05, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_shield_generator')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.05, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_core_recharger')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.05, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_core_battery')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.05, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_armor_plate')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.05, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_1')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_2')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_common_reactor_plasma')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 66, 1, 0, 0, 54)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_common')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 96, 1, 0, 1, 64)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_industrial')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 48, 1, 0, 1, 32)

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_termis_support_rank2')

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_basic')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 10, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_advanced')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 10, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_sensor_booster')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.1, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_sensor_booster')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_eccm')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.1, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_eccm')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_armor_repairer_upgrade')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.1, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_armor_repairer_upgrade')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_shield_hardener')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.1, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_shield_hardener')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.1, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.1, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.1, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.1, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_shield_generator')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.1, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_shield_generator')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_core_recharger')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.1, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_core_recharger')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_core_battery')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.1, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_core_battery')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_armor_plate')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.1, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_armor_plate')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_1')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.01, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_2')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.01, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_3')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_4')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_common_reactor_plasma')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 86, 1, 0, 0, 70)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_common')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 192, 1, 0, 1, 128)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_industrial')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 96, 1, 0, 1, 64)

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_termis_support_rank3')

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_basic')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 7, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_advanced')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 5, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_expert')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 3, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_sensor_booster')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.125, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_sensor_booster')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_eccm')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.125, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_eccm')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_armor_repairer_upgrade')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.125, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_armor_repairer_upgrade')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_shield_hardener')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.125, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_shield_hardener')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.125, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.125, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.125, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.125, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_shield_generator')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.125, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_shield_generator')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_core_recharger')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.125, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_core_recharger')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_core_battery')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.125, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_core_battery')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_armor_plate')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.125, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_armor_plate')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_1')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.02, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_2')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.02, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_3')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.01, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_4')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.01, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_5')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_6')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_common_reactor_plasma')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 132, 1, 0, 0, 108)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_common')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 384, 1, 0, 1, 256)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_industrial')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 192, 1, 0, 1, 128)

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_termis_support_rank4')

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_basic')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 5, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_advanced')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 5, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_expert')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 5, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_sensor_booster')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.15, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_sensor_booster')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_eccm')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.15, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_eccm')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_armor_repairer_upgrade')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.15, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_armor_repairer_upgrade')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_shield_hardener')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.15, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_shield_hardener')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.15, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.15, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.15, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.15, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_shield_generator')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.15, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_medium_shield_generator')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_core_recharger')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.15, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_core_recharger')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_core_battery')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.15, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_medium_core_battery')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_armor_plate')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.15, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_medium_armor_plate')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_3')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.02, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_4')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.02, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_5')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.01, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_6')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.01, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_7')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_8')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_common_reactor_plasma')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 197, 1, 0, 0, 161)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_hitech')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 96, 1, 0, 0, 64)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_industrial')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 384, 1, 0, 1, 256)

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_termis_support_rank5')

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_basic')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 3, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_advanced')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 5, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_expert')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 7, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_sensor_booster')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_sensor_booster')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_eccm')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_eccm')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_armor_repairer_upgrade')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_armor_repairer_upgrade')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_shield_hardener')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_shield_hardener')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_shield_generator')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_medium_shield_generator')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_core_recharger')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_core_recharger')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_core_battery')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_medium_core_battery')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_armor_plate')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_medium_armor_plate')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_5')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.02, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_6')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.02, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_7')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.01, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_8')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.01, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_9')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_10')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_common_reactor_plasma')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 296, 1, 0, 0, 242)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_hitech')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 192, 1, 0, 1, 128)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_industrial')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 768, 1, 0, 1, 512)

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_riveler_support_rank1')

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_basic')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 5, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_sensor_booster')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.5, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_eccm')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.5, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_armor_repairer_upgrade')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.5, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_shield_hardener')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.5, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.5, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.5, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.5, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.5, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.5, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.5, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_shield_generator')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.5, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_core_recharger')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.5, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_core_recharger')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.5, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_core_battery')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.5, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_armor_plate')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.5, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_1')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_2')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_common_reactor_plasma')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 178, 1, 0, 0, 146)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_common')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 120, 1, 0, 1, 80)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_industrial')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 60, 1, 0, 1, 40)

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_riveler_support_rank2')

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_basic')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 10, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_advanced')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 5, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_sensor_booster')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.1, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_sensor_booster')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_eccm')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.1, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_eccm')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_armor_repairer_upgrade')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.1, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_armor_repairer_upgrade')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_shield_hardener')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.1, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_shield_hardener')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.1, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.1, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.1, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.1, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.1, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.1, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_shield_generator')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.1, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_shield_generator')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_core_recharger')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.1, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_core_recharger')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_core_recharger')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.1, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_core_recharger')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_core_battery')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.1, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_core_battery')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_armor_plate')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.1, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_armor_plate')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_1')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.01, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_2')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.01, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_3')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_4')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_common_reactor_plasma')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 232, 1, 0, 0, 190)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_common')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 240, 1, 0, 1, 160)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_industrial')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 120, 1, 0, 1, 80)

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_riveler_support_rank3')

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_basic')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 7, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_advanced')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 5, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_expert')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 3, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_sensor_booster')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.125, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_sensor_booster')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_eccm')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.125, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_eccm')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_armor_repairer_upgrade')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.125, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_armor_repairer_upgrade')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_shield_hardener')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.125, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_shield_hardener')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.125, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.125, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.125, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.125, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.125, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.125, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_shield_generator')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.125, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_shield_generator')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_core_recharger')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.125, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_core_recharger')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_core_recharger')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.125, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_core_recharger')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_core_battery')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.125, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_core_battery')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_armor_plate')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.125, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_armor_plate')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_1')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.02, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_2')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.02, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_3')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.01, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_4')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.01, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_5')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_6')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_common_reactor_plasma')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 357, 1, 0, 0, 292)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_common')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 480, 1, 0, 1, 320)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_industrial')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 240, 1, 0, 1, 160)

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_riveler_support_rank4')

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_basic')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 5, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_advanced')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 5, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_expert')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 5, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_sensor_booster')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.15, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_sensor_booster')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_eccm')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.15, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_eccm')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_armor_repairer_upgrade')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.15, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_armor_repairer_upgrade')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_shield_hardener')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.15, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_shield_hardener')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.15, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.15, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.15, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.15, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.15, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.15, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_shield_generator')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.15, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_medium_shield_generator')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_core_recharger')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.15, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_core_recharger')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_core_recharger')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.15, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_core_recharger')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_core_battery')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.15, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_medium_core_battery')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_armor_plate')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.15, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_medium_armor_plate')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_3')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.02, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_4')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.02, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_5')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.01, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_6')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.01, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_7')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_8')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_common_reactor_plasma')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 536, 1, 0, 0, 438)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_hitech')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 120, 1, 0, 1, 80)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_industrial')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 480, 1, 0, 1, 320)

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_riveler_support_rank5')

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_basic')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 3, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_advanced')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 5, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_expert')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 7, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_sensor_booster')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_sensor_booster')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_eccm')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_eccm')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_armor_repairer_upgrade')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_armor_repairer_upgrade')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_shield_hardener')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_shield_hardener')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_medium_remote_armor_repairer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_medium_energy_transfer')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_shield_generator')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_medium_shield_generator')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_core_recharger')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_core_recharger')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_core_recharger')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_core_recharger')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_core_battery')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_medium_core_battery')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_armor_plate')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_medium_armor_plate')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.0025, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_5')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.02, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_6')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.02, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_7')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.01, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_8')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.01, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_9')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_10')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 1, 0.005, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_common_reactor_plasma')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 805, 1, 0, 0, 658)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_basic')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 3, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_advanced')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 5, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_expert')
INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
VALUES (@definition, @lootDefinition, 7, 0.5, 0, 1, 1)

--

GO