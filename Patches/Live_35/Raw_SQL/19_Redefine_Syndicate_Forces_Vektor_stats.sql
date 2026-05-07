DECLARE @targetDefinition INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_syndicate_forces_vektor_main_combat_bot')

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