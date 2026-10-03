---- Set up aggregate fields for Sentry turrets as ammo

DECLARE @definition INT
DECLARE @field INT

---- Armor max

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_sentry_turret_unit')

UPDATE aggregatevalues SET value = 35200 WHERE definition = @definition AND field = @field

---- Damage chemical

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'damage_chemical')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_sentry_turret_unit')

UPDATE aggregatevalues SET value = 6 WHERE definition = @definition AND field = @field

---- Damage explosive

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'damage_explosive')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_sentry_turret_unit')

UPDATE aggregatevalues SET value = 12 WHERE definition = @definition AND field = @field

---- Damage kinetic

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'damage_kinetic')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_sentry_turret_unit')

UPDATE aggregatevalues SET value = 12 WHERE definition = @definition AND field = @field

---- Damage thermal

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'damage_thermal')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_sentry_turret_unit')

UPDATE aggregatevalues SET value = 12 WHERE definition = @definition AND field = @field

---- Damage toxic

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'damage_toxic')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_sentry_turret_unit')

UPDATE aggregatevalues SET value = 6 WHERE definition = @definition AND field = @field

---- Weapon cycle

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cycle_time')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_sentry_turret_unit')

UPDATE aggregatevalues SET value = 6000 WHERE definition = @definition AND field = @field

---- Accuracy

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'accuracy')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_sentry_turret_unit')

UPDATE aggregatevalues SET value = 18 WHERE definition = @definition AND field = @field

---- Optimal range

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_sentry_turret_unit')

UPDATE aggregatevalues SET value = 22 WHERE definition = @definition AND field = @field

---- Falloff

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'falloff')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_sentry_turret_unit')

UPDATE aggregatevalues SET value = 28 WHERE definition = @definition AND field = @field

---- Resists

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_chemical')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_sentry_turret_unit')

UPDATE aggregatevalues SET value = 45 WHERE definition = @definition AND field = @field

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_explosive')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_sentry_turret_unit')

UPDATE aggregatevalues SET value = 45 WHERE definition = @definition AND field = @field

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_kinetic')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_sentry_turret_unit')

UPDATE aggregatevalues SET value = 45 WHERE definition = @definition AND field = @field

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_thermal')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_sentry_turret_unit')

UPDATE aggregatevalues SET value = 45 WHERE definition = @definition AND field = @field

GO

---- Set up aggregate fields for Sentry turrets

DECLARE @definition INT
DECLARE @field INT

--head

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_sentry_turret_head')

---- CPU max

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_max')

UPDATE aggregatevalues SET value = 370 WHERE definition = @definition AND field = @field

---- Locked targets max

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locked_targets_max')

UPDATE aggregatevalues SET value = 6 WHERE definition = @definition AND field = @field

---- Locking range

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range')

UPDATE aggregatevalues SET value = 35 WHERE definition = @definition AND field = @field

---- Locking time

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_time')

UPDATE aggregatevalues SET value = 10500 WHERE definition = @definition AND field = @field

---- Sensor strength

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'sensor_strength')

UPDATE aggregatevalues SET value = 100 WHERE definition = @definition AND field = @field

---- Blob emission

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission')

UPDATE aggregatevalues SET value = 4 WHERE definition = @definition AND field = @field

---- Blob emission radius

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission_radius')

UPDATE aggregatevalues SET value = 30 WHERE definition = @definition AND field = @field

---- Blob level low

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_level_low')

UPDATE aggregatevalues SET value = 90 WHERE definition = @definition AND field = @field

---- Blob level high

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_level_high')

UPDATE aggregatevalues SET value = 405 WHERE definition = @definition AND field = @field

---- Detection strength

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'detection_strength')

UPDATE aggregatevalues SET value = 90 WHERE definition = @definition AND field = @field

---- Stealth strength

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'stealth_strength')

UPDATE aggregatevalues SET value = 100 WHERE definition = @definition AND field = @field

-- chassis

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_sentry_turret_chassis')

---- Ammo reload time

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'ammo_reload_time')

UPDATE aggregatevalues SET value = 10000 WHERE definition = @definition AND field = @field

---- Armor max

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max')

UPDATE aggregatevalues SET value = 3520 WHERE definition = @definition AND field = @field

---- Core max

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max')

UPDATE aggregatevalues SET value = 3080 WHERE definition = @definition AND field = @field

---- Core recharge time

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time')

UPDATE aggregatevalues SET value = 720 WHERE definition = @definition AND field = @field

---- Powergrid max

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_max')

UPDATE aggregatevalues SET value = 1200 WHERE definition = @definition AND field = @field

---- Resists

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_chemical')

UPDATE aggregatevalues SET value = 45 WHERE definition = @definition AND field = @field

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_explosive')

UPDATE aggregatevalues SET value = 45 WHERE definition = @definition AND field = @field

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_kinetic')

UPDATE aggregatevalues SET value = 45 WHERE definition = @definition AND field = @field

--

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_thermal')

UPDATE aggregatevalues SET value = 45 WHERE definition = @definition AND field = @field

---- Signature radius

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius')

UPDATE aggregatevalues SET value = 22 WHERE definition = @definition AND field = @field

---- Reactor radiation

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'reactor_radiation')

UPDATE aggregatevalues SET value = 7 WHERE definition = @definition AND field = @field

---- Mine detection range

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'mine_detection_range')

UPDATE aggregatevalues SET value = 7 WHERE definition = @definition AND field = @field

GO