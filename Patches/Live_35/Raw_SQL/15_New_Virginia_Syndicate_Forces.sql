USE perpetuumsa

GO

DECLARE @targetDefinition INT
DECLARE @spawnid INT
DECLARE @presenceid INT
DECLARE @definition INT

SET @spawnid = (SELECT TOP 1 spawnid FROM zones WHERE name = 'zone_TM')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_syndicate_forces_vektor_main_combat_bot')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_syndicate_forces_vektor_main_combat_bot', 1, 1024, 1167, '#faction=SSyndicate', 'Vektor, Armor, Machine Guns', 1, 0, 0, 0, 100, 'def_syndicate_forces_vektor_main_combat_bot_desc', 1, NULL, NULL)
END
ELSE
BEGIN
	UPDATE entitydefaults SET options = '#faction=SSyndicate' WHERE definitionname = 'def_syndicate_forces_vektor_main_combat_bot'
END

SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_syndicate_forces_vektor_main_combat_bot')

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

DECLARE @field INT

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.3)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 3 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 3 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1 WHERE definition = @targetDefinition AND field = @field
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

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'damage_modifier')

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
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.2 WHERE definition = @targetDefinition AND field = @field
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
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.9)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.9 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.2 WHERE definition = @targetDefinition AND field = @field
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

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, -0.25)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = -0.25 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'turret_cycle_time_modifier')

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
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1 WHERE definition = @targetDefinition AND field = @field
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
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, -10)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = -10 WHERE definition = @targetDefinition AND field = @field
END

DECLARE @robot INT
DECLARE @head INT
DECLARE @chassis INT
DECLARE @leg INT
DECLARE @inventory INT

DECLARE @sensor_booster INT
DECLARE @s_demob INT
DECLARE @firearm_tuning INT
DECLARE @small_mg INT
DECLARE @mg_ammo INT
DECLARE @small_armor_rep INT
DECLARE @medium_injector INT
DECLARE @injector_charges INT
DECLARE @uni_plate INT
DECLARE @small_plate INT

SET @robot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_vektor_bot')
SET @head = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_vektor_head')
SET @chassis = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_vektor_chassis')
SET @leg = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_vektor_leg')
SET @inventory = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robot_inventory_combat_runner')

SET @sensor_booster = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_sensor_booster')
SET @s_demob = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_webber')
SET @firearm_tuning = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_damage_mod_projectile')
SET @small_mg = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_small_autocannon')
SET @mg_ammo = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_ammo_small_projectile_rewa')
SET @small_armor_rep = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_small_armor_repairer')
SET @uni_plate = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_resistant_plating')
SET @small_plate = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_small_armor_plate')

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'Vektor_Main_Combat')
BEGIN
	INSERT INTO robottemplates (name, description, note) VALUES
	('Vektor_Main_Combat', CONCAT(
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
		FORMAT(@sensor_booster, 'X'),
		'|slot=i2]|m2=[|definition=i',
		FORMAT(@s_demob, 'X'),
		'|slot=i3]|m3=[|definition=i',
		FORMAT(@firearm_tuning, 'X'),
		'|slot=i4]]#chassisModules=[|m0=[|definition=i',
		FORMAT(@small_mg, 'X'),
		'|slot=i1|ammoDefinition=i',
		FORMAT(@mg_ammo, 'X'),
		'|ammoQuantity=i17]|m1=[|definition=i',
		FORMAT(@small_mg, 'X'),
		'|slot=i2|ammoDefinition=i',
		FORMAT(@mg_ammo, 'X'),
		'|ammoQuantity=i17]|m2=[|definition=i',
		FORMAT(@small_mg, 'X'),
		'|slot=i3|ammoDefinition=i',
		FORMAT(@mg_ammo, 'X'),
		'|ammoQuantity=i17]|m3=[|definition=i',
		FORMAT(@small_mg, 'X'),
		'|slot=i4|ammoDefinition=i',
		FORMAT(@mg_ammo, 'X'),
		'|ammoQuantity=i17]]#legModules=[|m0=[|definition=i',
		FORMAT(@small_armor_rep, 'X'),
		'|slot=i1]|m1=[|definition=i',
		FORMAT(@uni_plate, 'X'),
		'|slot=i2]|m2=[|definition=i',
		FORMAT(@small_plate, 'X'),
		'|slot=i3]]'), 'Syndicate Forces Main Combat Vektor')
END

DECLARE @templateId INT

SET @templateId = (SELECT TOP 1 id FROM robottemplates WHERE name = 'Vektor_Main_Combat')

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note) VALUES
(@targetDefinition, @templateId, 0, NULL, NULL, 15, 'def_npc_nv_vektor_main_combat')

--- support Argano

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_syndicate_forces_argano_main_support_bot')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_syndicate_forces_argano_main_support_bot', 1, 1024, 1167, '#faction=SSyndicate', 'Argano, Armor Repair, Energy Transfer', 1, 0, 0, 0, 100, 'def_syndicate_forces_argano_main_support_bot_desc', 1, NULL, NULL)
END
ELSE
BEGIN
	UPDATE entitydefaults SET options = '#faction=SSyndicate' WHERE definitionname = 'def_syndicate_forces_argano_main_support_bot'
END

SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_syndicate_forces_argano_main_support_bot')

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.3)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 3 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 3 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1 WHERE definition = @targetDefinition AND field = @field
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
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.2 WHERE definition = @targetDefinition AND field = @field
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
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'detection_strength_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 40)
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
	UPDATE aggregatevalues SET value = -10 WHERE definition = @targetDefinition AND field = @field
END

DECLARE @cpu_upgrade INT
DECLARE @eccm INT

DECLARE @energy_transferer INT
DECLARE @remote_armor_rep INT
DECLARE @small_shield INT
DECLARE @recharger INT
DECLARE @accu INT

SET @robot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_argano_bot')
SET @head = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_argano_head')
SET @chassis = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_argano_chassis')
SET @leg = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_argano_leg')
SET @inventory = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robot_inventory_combat_ewmech_indy_runner')

SET @sensor_booster = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_sensor_booster')
SET @cpu_upgrade = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_cpu_upgrade')
SET @eccm = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_eccm')

SET @energy_transferer = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_small_energy_transfer')
SET @remote_armor_rep = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_small_remote_armor_repairer')

SET @small_shield = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_small_shield_generator')
SET @recharger = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_core_recharger')
SET @accu = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_small_core_battery')


IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'Argano_Main_Support')
BEGIN
	INSERT INTO robottemplates (name, description, note) VALUES
	('Argano_Main_Support', CONCAT(
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
		FORMAT(@cpu_upgrade, 'X'),
		'|slot=i2]|m2=[|definition=i',
		FORMAT(@eccm, 'X'),
		'|slot=i3]]#chassisModules=[|m0=[|definition=i',
		FORMAT(@remote_armor_rep, 'X'),
		'|slot=i1]|m1=[|definition=i',
		FORMAT(@remote_armor_rep, 'X'),
		'|slot=i2]|m2=[|definition=i',
		FORMAT(@energy_transferer, 'X'),
		'|slot=i3]]#legModules=[|m0=[|definition=i',
		FORMAT(@small_shield, 'X'),
		'|slot=i1]|m1=[|definition=i',
		FORMAT(@recharger, 'X'),
		'|slot=i2]|m2=[|definition=i',
		FORMAT(@accu, 'X'),
		'|slot=i3]]'), 'Syndicate Forces Main Support Argano')
END

SET @templateId = (SELECT TOP 1 id FROM robottemplates WHERE name = 'Argano_Main_Support')

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note) VALUES
(@targetDefinition, @templateId, 0, NULL, NULL, 15, 'def_npc_nv_argano_main_support')

--- squad 1

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'syndicate_N01_z0' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('syndicate_N01_z0', 1025, 765, 1150, 895, 'new virginia syndicate forces 1', @spawnid, 1, 1, 900, 5, NULL, 1080, 850, 500, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1, topx = 1025, topy = 765, bottomx = 1150, bottomy = 895, randomcenterx = 1080, randomcentery = 850, randomradius = 500, roamingrespawnseconds = 900
	WHERE name = 'syndicate_N01_z0'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'syndicate_N01_z0')

----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_syndicate_forces_vektor_main_combat_bot')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'syndicate_N01_z0_vektor_main_combat')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('syndicate_N01_z0_vektor_main_combat', @presenceid, 2, @definition, 0, 0, 0, 10, 7200, 0, 50, 'new virginia npc', 0.9, 1, 1, 1, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET respawnseconds = 900 WHERE name = 'syndicate_N01_z0_vektor_main_combat'
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_syndicate_forces_argano_main_support_bot')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'syndicate_N01_z0_argano_main_support')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('syndicate_N01_z0_argano_main_support', @presenceid, 1, @definition, 0, 0, 0, 10, 7200, 0, 50, 'new virginia npc', 0.9, 1, 1, 1, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET respawnseconds = 900 WHERE name = 'syndicate_N01_z0_argano_main_support'
END

GO