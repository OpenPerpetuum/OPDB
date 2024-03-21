---- Add new aggregate fields for Landmines and detection range

IF NOT EXISTS (SELECT TOP 1 name FROM aggregatefields WHERE name = 'trigger_mass')
BEGIN
	INSERT INTO aggregatefields (name, formula, measurementunit, measurementmultiplier, measurementoffset, category, digits, moreisbetter, usedinconfig, note) VALUES
	('trigger_mass', 0, 'mass_unit', 1, 0, 0, 0, NULL, NULL, NULL)
END
ELSE
BEGIN
	UPDATE aggregatefields SET formula = 0, measurementunit = 'mass_unit', measurementmultiplier = 10, measurementoffset = 0, category = 5, digits = 0, moreisbetter = 1, usedinconfig = 1, note = NULL
	WHERE name = 'trigger_mass'
END

IF NOT EXISTS (SELECT TOP 1 name FROM aggregatefields WHERE name = 'mine_detection_range')
BEGIN
	INSERT INTO aggregatefields (name, formula, measurementunit, measurementmultiplier, measurementoffset, category, digits, moreisbetter, usedinconfig, note) VALUES
	('mine_detection_range', 1, 'mine_detection_range_unit', 10, 0, 5, 0, 1, 1, NULL)
END
ELSE
BEGIN
	UPDATE aggregatefields SET formula = 1, measurementunit = 'mine_detection_range_unit', measurementmultiplier = 10, measurementoffset = 0, category = 5, digits = 0, moreisbetter = 1, usedinconfig = 1, note = NULL
	WHERE name = 'mine_detection_range'
END

IF NOT EXISTS (SELECT TOP 1 name FROM aggregatefields WHERE name = 'mine_detection_range_modifier')
BEGIN
	INSERT INTO aggregatefields (name, formula, measurementunit, measurementmultiplier, measurementoffset, category, digits, moreisbetter, usedinconfig, note) VALUES
	('mine_detection_range_modifier', 0, 'mine_detection_range_modifier_unit', 100, -100, 5, 0, 1, 1, NULL)
END
ELSE
BEGIN
	UPDATE aggregatefields SET formula = 0, measurementunit = 'mine_detection_range_modifier_unit', measurementmultiplier = 100, measurementoffset = -100, category = 5, digits = 0, moreisbetter = 1, usedinconfig = 1, note = NULL
	WHERE name = 'mine_detection_range_modifier'
END

IF NOT EXISTS (SELECT TOP 1 name FROM aggregatefields WHERE name = 'effect_mine_detection_range_modifier')
BEGIN
	INSERT INTO aggregatefields (name, formula, measurementunit, measurementmultiplier, measurementoffset, category, digits, moreisbetter, usedinconfig, note) VALUES
	('effect_mine_detection_range_modifier', 0, 'effect_mine_detection_range_modifier_unit', 100, -100, 6, 0, 1, 1, NULL)
END
ELSE
BEGIN
	UPDATE aggregatefields SET formula = 0, measurementunit = 'effect_mine_detection_range_modifier_unit', measurementmultiplier = 100, measurementoffset = -100, category = 6, digits = 0, moreisbetter = 1, usedinconfig = 1, note = NULL
	WHERE name = 'effect_mine_detection_range_modifier'
END

IF NOT EXISTS (SELECT TOP 1 name FROM aggregatefields WHERE name = 'effect_enhancer_mine_detection_range_modifier')
BEGIN
	INSERT INTO aggregatefields (name, formula, measurementunit, measurementmultiplier, measurementoffset, category, digits, moreisbetter, usedinconfig, note) VALUES
	('effect_enhancer_mine_detection_range_modifier', 0, 'effect_enhancer_mine_detection_range_modifier_unit', 100, -100, 6, 0, 1, 1, NULL)
END
ELSE
BEGIN
	UPDATE aggregatefields SET formula = 0, measurementunit = 'effect_enhancer_mine_detection_range_modifier_unit', measurementmultiplier = 100, measurementoffset = -100, category = 6, digits = 0, moreisbetter = 1, usedinconfig = 1, note = NULL
	WHERE name = 'effect_enhancer_mine_detection_range_modifier'
END

GO

---- Landmines category ----

IF NOT EXISTS (SELECT TOP 1 name FROM categoryFlags WHERE name = 'cf_landmines')
BEGIN
	INSERT INTO categoryFlags (value, name, note, hidden, isunique) VALUES
	(263314, 'cf_landmines', 'Landmines', 0, 0)
END
ELSE
BEGIN
	UPDATE categoryFlags SET value = 263314, note = 'Landmines', hidden = 0, isunique = 0
	WHERE name = 'cf_landmines'
END

-- Light landmines subcategory --

IF NOT EXISTS (SELECT TOP 1 name FROM categoryFlags WHERE name = 'cf_light_landmines')
BEGIN
	INSERT INTO categoryFlags (value, name, note, hidden, isunique) VALUES
	(17040530, 'cf_light_landmines', 'Light landmines', 0, 0)
END
ELSE
BEGIN
	UPDATE categoryFlags SET value = 17040530, note = 'Light landmines', hidden = 0, isunique = 0
	WHERE name = 'cf_light_landmines'
END

-- Medium landmines subcategory --

IF NOT EXISTS (SELECT TOP 1 name FROM categoryFlags WHERE name = 'cf_medium_landmines')
BEGIN
	INSERT INTO categoryFlags (value, name, note, hidden, isunique) VALUES
	(33817746, 'cf_medium_landmines', 'Medium landmines', 0, 0)
END
ELSE
BEGIN
	UPDATE categoryFlags SET value = 33817746, note = 'Medium landmines', hidden = 0, isunique = 0
	WHERE name = 'cf_medium_landmines'
END

-- Heavy landmines subcategory --

IF NOT EXISTS (SELECT TOP 1 name FROM categoryFlags WHERE name = 'cf_heavy_landmines')
BEGIN
	INSERT INTO categoryFlags (value, name, note, hidden, isunique) VALUES
	(50594962, 'cf_heavy_landmines', 'Heavy landmines', 0, 0)
END
ELSE
BEGIN
	UPDATE categoryFlags SET value = 50594962, note = 'Heavy landmines', hidden = 0, isunique = 0
	WHERE name = 'cf_heavy_landmines'
END

GO

---- Landmines definitions ----

-- Light landmine (deployed) --

IF NOT EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_light_landmine')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_light_landmine', 1, 1024, 17040530, '#triggerMass=n10000', NULL, 1, 1.5, 1000, 0, 100, 'def_light_landmine_desc', 0, 0, 0)
END
ELSE
BEGIN
	UPDATE entitydefaults SET quantity = 1, attributeflags = 1024, categoryflags = 17040530, options = '#triggerMass=n10000', note = NULL, enabled = 1, volume = 1.5, mass = 1000, hidden = 0, health = 100, descriptiontoken = 'def_light_landmine_desc', purchasable = 0, tiertype = 0, tierlevel = 1
	WHERE definitionname = 'def_light_landmine'
END

-- Light landmine (capsule) --

IF NOT EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_light_landmine_capsule')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_light_landmine_capsule', 1, 25167872, 3480, NULL, NULL, 1, 1.5, 1000, 0, 100, 'def_light_landmine_capsule_desc', 1, 0, 0)
END
ELSE
BEGIN
	UPDATE entitydefaults SET quantity = 1, attributeflags = 25167872, categoryflags = 3480, options = NULL, note = NULL, enabled = 1, volume = 1.5, mass = 1000, hidden = 0, health = 100, descriptiontoken = 'def_light_landmine_capsule_desc', purchasable = 1, tiertype = 0, tierlevel = 1
	WHERE definitionname = 'def_light_landmine_capsule'
END

-- Medium landmine (deployed) --

IF NOT EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_medium_landmine')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_medium_landmine', 1, 1024, 33817746, '#triggerMass=n20000', NULL, 1, 1.5, 1000, 0, 100, 'def_medium_landmine_desc', 0, 0, 0)
END
ELSE
BEGIN
	UPDATE entitydefaults SET quantity = 1, attributeflags = 1024, categoryflags = 33817746, options = '#triggerMass=n20000', note = NULL, enabled = 1, volume = 1.5, mass = 1000, hidden = 0, health = 100, descriptiontoken = 'def_medium_landmine_desc', purchasable = 0, tiertype = 0, tierlevel = 1
	WHERE definitionname = 'def_medium_landmine'
END

-- Medium landmine (capsule) --

IF NOT EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_medium_landmine_capsule')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_medium_landmine_capsule', 1, 25167872, 3480, NULL, NULL, 1, 1.5, 1000, 0, 100, 'def_medium_landmine_capsule_desc', 1, 0, 0)
END
ELSE
BEGIN
	UPDATE entitydefaults SET quantity = 1, attributeflags = 25167872, categoryflags = 3480, options = NULL, note = NULL, enabled = 1, volume = 1.5, mass = 1000, hidden = 0, health = 100, descriptiontoken = 'def_medium_landmine_capsule_desc', purchasable = 1, tiertype = 0, tierlevel = 1
	WHERE definitionname = 'def_medium_landmine_capsule'
END

-- Heavy landmine (deployed) --

IF NOT EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_heavy_landmine')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_heavy_landmine', 1, 1024, 50594962, '#triggerMass=n30000', NULL, 1, 1.5, 1000, 0, 100, 'def_heavy_landmine_desc', 0, 0, 0)
END
ELSE
BEGIN
	UPDATE entitydefaults SET quantity = 1, attributeflags = 1024, categoryflags = 50594962, options = '#triggerMass=n30000', note = NULL, enabled = 1, volume = 1.5, mass = 1000, hidden = 0, health = 100, descriptiontoken = 'def_heavy_landmine_desc', purchasable = 0, tiertype = 0, tierlevel = 1
	WHERE definitionname = 'def_heavy_landmine'
END

-- Heavy landmine (capsule) --

IF NOT EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_heavy_landmine_capsule')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_heavy_landmine_capsule', 1, 25167872, 3480, NULL, NULL, 1, 1.5, 1000, 0, 100, 'def_heavy_landmine_capsule_desc', 1, 0, 0)
END
ELSE
BEGIN
	UPDATE entitydefaults SET quantity = 1, attributeflags = 25167872, categoryflags = 3480, options = NULL, note = NULL, enabled = 1, volume = 1.5, mass = 1000, hidden = 0, health = 100, descriptiontoken = 'def_heavy_landmine_capsule_desc', purchasable = 1, tiertype = 0, tierlevel = 1
	WHERE definitionname = 'def_heavy_landmine_capsule'
END

DECLARE @lightMine INT
DECLARE @mediumMine INT
DECLARE @heavyMine INT

SET @lightMine = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_light_landmine' ORDER BY definition DESC);
SET @mediumMine = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_medium_landmine' ORDER BY definition DESC);
SET @heavyMine = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_heavy_landmine' ORDER BY definition DESC);

IF NOT EXISTS (SELECT 1 FROM definitionconfig WHERE definition = @lightMine)
BEGIN
	INSERT INTO definitionconfig (definition, explosion_radius, damage_chemical, damage_explosive, damage_kinetic, damage_thermal, damage_toxic, item_work_range, cycle_time) VALUES
	(@lightMine, 1, 100, 100, 100, 100, 100, 5.0, 2000)
END
ELSE
BEGIN
	UPDATE definitionconfig SET
		explosion_radius = 1,
		damage_chemical = 100,
		damage_explosive = 100,
		damage_kinetic = 100,
		damage_thermal = 100,
		damage_toxic = 100,
		item_work_range = 5.0,
		cycle_time = 2000
	WHERE definition = @lightMine
END

IF NOT EXISTS (SELECT 1 FROM definitionconfig WHERE definition = @mediumMine)
BEGIN
	INSERT INTO definitionconfig (definition, explosion_radius, damage_chemical, damage_explosive, damage_kinetic, damage_thermal, damage_toxic, item_work_range, cycle_time) VALUES
	(@mediumMine, 1, 300, 300, 300, 300, 300, 5.0, 2000)
END
ELSE
BEGIN
	UPDATE definitionconfig SET
		explosion_radius = 1,
		damage_chemical = 300,
		damage_explosive = 300,
		damage_kinetic = 300,
		damage_thermal = 300,
		damage_toxic = 300,
		item_work_range = 5.0,
		cycle_time = 2000
	WHERE definition = @mediumMine
END

IF NOT EXISTS (SELECT 1 FROM definitionconfig WHERE definition = @heavyMine)
BEGIN
	INSERT INTO definitionconfig (definition, explosion_radius, damage_chemical, damage_explosive, damage_kinetic, damage_thermal, damage_toxic, item_work_range, cycle_time) VALUES
	(@heavyMine, 1, 900, 900, 900, 900, 900, 5.0, 2000)
END
ELSE
BEGIN
	UPDATE definitionconfig SET
		explosion_radius = 1,
		damage_chemical = 900,
		damage_explosive = 900,
		damage_kinetic = 900,
		damage_thermal = 900,
		damage_toxic = 900,
		item_work_range = 5.0,
		cycle_time = 2000
	WHERE definition = @heavyMine
END

GO

---- Stats for landmines in cargo to display in properties ----

DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;

-- Light Landines --

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_light_landmine_capsule' ORDER BY definition DESC);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'despawn_time' ORDER BY [name] DESC);
SET @aggvalueID = 28800000

IF NOT EXISTS (SELECT TOP 1 value FROM aggregatevalues WHERE definition = @definitionID AND field = @aggfieldID)
BEGIN
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, @aggvalueID);
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = @aggvalueID WHERE definition = @definitionID AND field = @aggfieldID
END

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_chemical' ORDER BY [name] DESC);
SET @aggvalueID = 100;

IF NOT EXISTS (SELECT TOP 1 value FROM aggregatevalues WHERE definition = @definitionID AND field = @aggfieldID)
BEGIN
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, @aggvalueID);
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = @aggvalueID WHERE definition = @definitionID AND field = @aggfieldID
END

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_explosive' ORDER BY [name] DESC);
SET @aggvalueID = 100;

IF NOT EXISTS (SELECT TOP 1 value FROM aggregatevalues WHERE definition = @definitionID AND field = @aggfieldID)
BEGIN
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, @aggvalueID);
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = @aggvalueID WHERE definition = @definitionID AND field = @aggfieldID
END

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_kinetic' ORDER BY [name] DESC);
SET @aggvalueID = 100;

IF NOT EXISTS (SELECT TOP 1 value FROM aggregatevalues WHERE definition = @definitionID AND field = @aggfieldID)
BEGIN
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, @aggvalueID);
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = @aggvalueID WHERE definition = @definitionID AND field = @aggfieldID
END

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_thermal' ORDER BY [name] DESC);
SET @aggvalueID = 100;

IF NOT EXISTS (SELECT TOP 1 value FROM aggregatevalues WHERE definition = @definitionID AND field = @aggfieldID)
BEGIN
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, @aggvalueID);
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = @aggvalueID WHERE definition = @definitionID AND field = @aggfieldID
END

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_toxic' ORDER BY [name] DESC);
SET @aggvalueID = 100;

IF NOT EXISTS (SELECT TOP 1 value FROM aggregatevalues WHERE definition = @definitionID AND field = @aggfieldID)
BEGIN
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, @aggvalueID);
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = @aggvalueID WHERE definition = @definitionID AND field = @aggfieldID
END

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'trigger_mass' ORDER BY [name] DESC);
SET @aggvalueID = 10000;

IF NOT EXISTS (SELECT TOP 1 value FROM aggregatevalues WHERE definition = @definitionID AND field = @aggfieldID)
BEGIN
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, @aggvalueID);
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = @aggvalueID WHERE definition = @definitionID AND field = @aggfieldID
END

-- Medium Landmines --

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_medium_landmine_capsule' ORDER BY definition DESC);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'despawn_time' ORDER BY [name] DESC);
SET @aggvalueID = 28800000;

IF NOT EXISTS (SELECT TOP 1 value FROM aggregatevalues WHERE definition = @definitionID AND field = @aggfieldID)
BEGIN
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, @aggvalueID);
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = @aggvalueID WHERE definition = @definitionID AND field = @aggfieldID
END

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_chemical' ORDER BY [name] DESC);
SET @aggvalueID = 300;

IF NOT EXISTS (SELECT TOP 1 value FROM aggregatevalues WHERE definition = @definitionID AND field = @aggfieldID)
BEGIN
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, @aggvalueID);
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = @aggvalueID WHERE definition = @definitionID AND field = @aggfieldID
END

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_explosive' ORDER BY [name] DESC);
SET @aggvalueID = 300;

IF NOT EXISTS (SELECT TOP 1 value FROM aggregatevalues WHERE definition = @definitionID AND field = @aggfieldID)
BEGIN
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, @aggvalueID);
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = @aggvalueID WHERE definition = @definitionID AND field = @aggfieldID
END

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_kinetic' ORDER BY [name] DESC);
SET @aggvalueID = 300;

IF NOT EXISTS (SELECT TOP 1 value FROM aggregatevalues WHERE definition = @definitionID AND field = @aggfieldID)
BEGIN
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, @aggvalueID);
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = @aggvalueID WHERE definition = @definitionID AND field = @aggfieldID
END

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_thermal' ORDER BY [name] DESC);
SET @aggvalueID = 300;

IF NOT EXISTS (SELECT TOP 1 value FROM aggregatevalues WHERE definition = @definitionID AND field = @aggfieldID)
BEGIN
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, @aggvalueID);
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = @aggvalueID WHERE definition = @definitionID AND field = @aggfieldID
END

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_toxic' ORDER BY [name] DESC);
SET @aggvalueID = 300;

IF NOT EXISTS (SELECT TOP 1 value FROM aggregatevalues WHERE definition = @definitionID AND field = @aggfieldID)
BEGIN
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, @aggvalueID);
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = @aggvalueID WHERE definition = @definitionID AND field = @aggfieldID
END

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'trigger_mass' ORDER BY [name] DESC);
SET @aggvalueID = 20000;

IF NOT EXISTS (SELECT TOP 1 value FROM aggregatevalues WHERE definition = @definitionID AND field = @aggfieldID)
BEGIN
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, @aggvalueID);
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = @aggvalueID WHERE definition = @definitionID AND field = @aggfieldID
END

-- Heavy Landmines --

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_heavy_landmine_capsule' ORDER BY definition DESC);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'despawn_time' ORDER BY [name] DESC);
SET @aggvalueID = 28800000;

IF NOT EXISTS (SELECT TOP 1 value FROM aggregatevalues WHERE definition = @definitionID AND field = @aggfieldID)
BEGIN
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, @aggvalueID);
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = @aggvalueID WHERE definition = @definitionID AND field = @aggfieldID
END

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_chemical' ORDER BY [name] DESC);
SET @aggvalueID = 900;

IF NOT EXISTS (SELECT TOP 1 value FROM aggregatevalues WHERE definition = @definitionID AND field = @aggfieldID)
BEGIN
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, @aggvalueID);
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = @aggvalueID WHERE definition = @definitionID AND field = @aggfieldID
END

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_explosive' ORDER BY [name] DESC);
SET @aggvalueID = 900;

IF NOT EXISTS (SELECT TOP 1 value FROM aggregatevalues WHERE definition = @definitionID AND field = @aggfieldID)
BEGIN
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, @aggvalueID);
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = @aggvalueID WHERE definition = @definitionID AND field = @aggfieldID
END

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_kinetic' ORDER BY [name] DESC);
SET @aggvalueID = 900;

IF NOT EXISTS (SELECT TOP 1 value FROM aggregatevalues WHERE definition = @definitionID AND field = @aggfieldID)
BEGIN
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, @aggvalueID);
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = @aggvalueID WHERE definition = @definitionID AND field = @aggfieldID
END

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_thermal' ORDER BY [name] DESC);
SET @aggvalueID = 900;

IF NOT EXISTS (SELECT TOP 1 value FROM aggregatevalues WHERE definition = @definitionID AND field = @aggfieldID)
BEGIN
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, @aggvalueID);
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = @aggvalueID WHERE definition = @definitionID AND field = @aggfieldID
END

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_toxic' ORDER BY [name] DESC);
SET @aggvalueID = 900;

IF NOT EXISTS (SELECT TOP 1 value FROM aggregatevalues WHERE definition = @definitionID AND field = @aggfieldID)
BEGIN
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, @aggvalueID);
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = @aggvalueID WHERE definition = @definitionID AND field = @aggfieldID
END

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'trigger_mass' ORDER BY [name] DESC);
SET @aggvalueID = 30000;

IF NOT EXISTS (SELECT TOP 1 value FROM aggregatevalues WHERE definition = @definitionID AND field = @aggfieldID)
BEGIN
	INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, @aggvalueID);
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = @aggvalueID WHERE definition = @definitionID AND field = @aggfieldID
END

GO

---- Link landmine capsules with landmines ----

DECLARE @lightMine INT
DECLARE @lightMineCapsule INT
DECLARE @mediumMine INT
DECLARE @mediumMineCapsule INT
DECLARE @heavyMine INT
DECLARE @heavyMineCapsule INT

SET @lightMine = (SELECT TOP 1 definition FROM entitydefaults WHERE [definitionname] = 'def_light_landmine' ORDER BY definition DESC);
SET @lightMineCapsule = (SELECT TOP 1 definition FROM entitydefaults WHERE [definitionname] = 'def_light_landmine_capsule' ORDER BY definition DESC);
SET @mediumMine = (SELECT TOP 1 definition FROM entitydefaults WHERE [definitionname] = 'def_medium_landmine' ORDER BY definition DESC);
SET @mediumMineCapsule = (SELECT TOP 1 definition FROM entitydefaults WHERE [definitionname] = 'def_medium_landmine_capsule' ORDER BY definition DESC);
SET @heavyMine = (SELECT TOP 1 definition FROM entitydefaults WHERE [definitionname] = 'def_heavy_landmine' ORDER BY definition DESC);
SET @heavyMineCapsule = (SELECT TOP 1 definition FROM entitydefaults WHERE [definitionname] = 'def_heavy_landmine_capsule' ORDER BY definition DESC);

IF NOT EXISTS (SELECT TOP 1 targetdefinition FROM definitionconfig WHERE definition = @lightMine)
BEGIN
	INSERT INTO definitionconfig (definition, targetdefinition) VALUES
	(@lightMine, NULL)
END
ELSE
BEGIN
	UPDATE definitionconfig SET targetdefinition = NULL WHERE definition = @lightMine
END

IF NOT EXISTS (SELECT TOP 1 targetdefinition FROM definitionconfig WHERE definition = @lightMineCapsule)
BEGIN
	INSERT INTO definitionconfig (definition, targetdefinition) VALUES
	(@lightMineCapsule, @lightMine)
END
ELSE
BEGIN
	UPDATE definitionconfig SET targetdefinition = @lightMine WHERE definition = @lightMineCapsule
END

IF NOT EXISTS (SELECT TOP 1 targetdefinition FROM definitionconfig WHERE definition = @mediumMine)
BEGIN
	INSERT INTO definitionconfig (definition, targetdefinition) VALUES
	(@mediumMine, NULL)
END
ELSE
BEGIN
	UPDATE definitionconfig SET targetdefinition = NULL WHERE definition = @mediumMine
END

IF NOT EXISTS (SELECT TOP 1 targetdefinition FROM definitionconfig WHERE definition = @mediumMineCapsule)
BEGIN
	INSERT INTO definitionconfig (definition, targetdefinition) VALUES
	(@mediumMineCapsule, @mediumMine)
END
ELSE
BEGIN
	UPDATE definitionconfig SET targetdefinition = @mediumMine WHERE definition = @mediumMineCapsule
END

IF NOT EXISTS (SELECT TOP 1 targetdefinition FROM definitionconfig WHERE definition = @heavyMine)
BEGIN
	INSERT INTO definitionconfig (definition, targetdefinition) VALUES
	(@heavyMine, NULL)
END
ELSE
BEGIN
	UPDATE definitionconfig SET targetdefinition = NULL WHERE definition = @heavyMine
END

IF NOT EXISTS (SELECT TOP 1 targetdefinition FROM definitionconfig WHERE definition = @heavyMineCapsule)
BEGIN
	INSERT INTO definitionconfig (definition, targetdefinition) VALUES
	(@heavyMineCapsule, @heavyMine)
END
ELSE
BEGIN
	UPDATE definitionconfig SET targetdefinition = @heavyMine WHERE definition = @heavyMineCapsule
END

GO

---- New stat mine detection for all robots ----
DECLARE @definitionID int;
DECLARE @aggfieldID int;
DECLARE @tempTable TABLE (definition INT, field INT, value FLOAT)

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mine_detection_range' ORDER BY [name] DESC);

INSERT INTO @tempTable (definition, field, value) 
(SELECT definition, @aggfieldID, 7 FROM entitydefaults ed
	INNER JOIN categoryFlags cf
	ON ed.categoryflags = cf.value
	WHERE cf.name IN ('cf_robot_chassis', 'cf_runner_chassis', 'cf_crawler_chassis', 'cf_mech_chassis', 'cf_heavymech_chassis', 'cf_walker_chassis')
);

MERGE aggregatevalues AS Target
USING (SELECT definition, field, value FROM @tempTable) AS Source
ON (Target.definition = Source.definition AND Target.field = Source.field)
WHEN MATCHED THEN
    UPDATE SET Target.value = Source.value
WHEN NOT MATCHED BY TARGET THEN
    INSERT (definition, field, value)
    VALUES (Source.definition, Source.field, Source.value);

-- Hermes has 100m base landmines detection range --
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_hermes_chassis' ORDER BY definition DESC);

UPDATE [dbo].[aggregatevalues] SET value = 10 WHERE [definition] = @definitionID and [field] = @aggfieldID;

-- Admin bot has 1000m base landmines detection range --
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_test_bot_chassis' ORDER BY definition DESC);

UPDATE [dbo].[aggregatevalues] SET value = 100 WHERE [definition] = @definitionID and [field] = @aggfieldID;

GO

---- Hermes bonus based on High-tech specialist extension ----

DECLARE @definition INT
DECLARE @extension INT
DECLARE @property INT

SET @definition = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_hermes_chassis')
SET @extension = (SELECT TOP 1 extensionid from extensions WHERE [extensionname] = 'ext_high_tech_specialist')
SET @property = (SELECT TOP 1 id from aggregatefields WHERE name = 'mine_detection_range')

IF NOT EXISTS (SELECT 1 FROM chassisbonus WHERE definition = @definition AND extension = @extension AND targetpropertyID = @property)
BEGIN
	INSERT INTO chassisbonus (definition, extension, bonus, note, targetpropertyID, effectenhancer) VALUES
	(@definition, @extension, 0.3, NULL, @property, 0)
END
ELSE
BEGIN
	UPDATE chassisbonus SET bonus = 0.3 WHERE definition = @definition AND extension = @extension AND targetpropertyID = @property
END

GO

---- Landmine detectors category ----

DELETE FROM categoryFlags WHERE name = 'cf_landmine_detectors'

INSERT INTO categoryFlags (value, name, note, hidden, isunique) VALUES
(983823, 'cf_landmine_detectors', 'Landmine Detectors', 0, 1)

GO

---- Landmine detectors, prototypes and cts ----

DECLARE @categoryFlags int
DECLARE @tempTable TABLE (
definitionname VARCHAR(100),
quantity INT,
attributeflags BIGINT,
categoryflags BIGINT,
options VARCHAR(MAX),
note NVARCHAR(2048),
enabled BIT,
volume FLOAT,
mass FLOAT,
hidden BIT,
health FLOAT,
descriptiontoken NVARCHAR(100),
purchasable BIT,
tiertype INT,
tierlevel INT)

SET @categoryFlags = (SELECT TOP 1 value FROM categoryflags WHERE name = 'cf_landmine_detectors')

INSERT INTO @tempTable (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
('def_standart_landmine_detector', 1, 16656, @categoryFlags, '#moduleFlag=i410#tier=$tierlevel_t1', NULL, 1, 0.5, 1000, 0, 100, 'def_standart_landmine_detector_desc', 1, 1, 1),
('def_named1_landmine_detector', 1, 16656, @categoryFlags, '#moduleFlag=i410#tier=$tierlevel_t2', NULL, 1, 1.5, 900, 0, 100, 'def_named_landmine_detector_desc', 1, 1, 2),
('def_named1_landmine_detector_pr', 1, 16656, @categoryFlags, '#moduleFlag=i410#tier=$tierlevel_t2_pr', NULL, 1, 1.5, 800, 0, 100, 'def_named_landmine_detector_desc', 1, 2, 2),
('def_named2_landmine_detector', 1, 16656, @categoryFlags, '#moduleFlag=i410#tier=$tierlevel_t3', NULL, 1, 1.5, 1000, 0, 1100, 'def_named_landmine_detector_desc', 1, 1, 3),
('def_named2_landmine_detector_pr', 1, 16656, @categoryFlags, '#moduleFlag=i410#tier=$tierlevel_t3_pr', NULL, 1, 1.5, 1000, 0, 100, 'def_named_landmine_detector_desc', 1, 2, 3),
('def_named3_landmine_detector', 1, 16656, @categoryFlags, '#moduleFlag=i410#tier=$tierlevel_t4', NULL, 1, 1.5, 1200, 0, 100, 'def_named_landmine_detector_desc', 1, 1, 4),
('def_named3_landmine_detector_pr', 1, 16656, @categoryFlags, '#moduleFlag=i410#tier=$tierlevel_t4_pr', NULL, 1, 1.5, 1100, 0, 100, 'def_named_landmine_detector_desc', 1, 2, 4)

SET @categoryFlags = (SELECT TOP 1 value FROM categoryflags WHERE name = 'cf_engineering_calibration_programs')

INSERT INTO @tempTable (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
('def_standart_landmine_detector_cprg', 1, 1024, @categoryFlags, '#tier=$tierlevel_t1', NULL, 1, 0.01, 0.1, 0, 100, 'calibration_program_desc', 0, 1, 1),
('def_named1_landmine_detector_cprg', 1, 1024, @categoryFlags, '#tier=$tierlevel_t2', NULL, 1, 0.01, 0.1, 0, 100, 'calibration_program_desc', 0, 1, 2),
('def_named2_landmine_detector_cprg', 1, 1024, @categoryFlags, '#tier=$tierlevel_t3', NULL, 1, 0.01, 0.1, 0, 100, 'calibration_program_desc', 0, 1, 3),
('def_named3_landmine_detector_cprg', 1, 1024, @categoryFlags, '#tier=$tierlevel_t4', NULL, 1, 0.01, 0.1, 0, 100, 'calibration_program_desc', 0, 1, 4)

MERGE entitydefaults AS Target
USING (SELECT definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel FROM @tempTable) AS Source
ON (Target.definitionname = Source.definitionname)
WHEN MATCHED THEN
    UPDATE SET 
		Target.quantity = Source.quantity,
		Target.attributeflags = Source.attributeflags,
		Target.categoryflags = Source.categoryflags,
		Target.options = Source.options,
		Target.note = Source.note,
		Target.enabled = Source.enabled,
		Target.volume = Source.volume,
		Target.mass = Source.mass,
		Target.hidden = Source.hidden,
		Target.health = Source.health,
		Target.descriptiontoken = Source.descriptiontoken,
		Target.purchasable = Source.purchasable,
		Target.tiertype = Source.tiertype,
		Target.tierlevel = Source.tierlevel
WHEN NOT MATCHED BY TARGET THEN
    INSERT (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel)
    VALUES (
		Source.definitionname,
		Source.quantity,
		Source.attributeflags,
		Source.categoryflags,
		Source.options,
		Source.note,
		Source.enabled,
		Source.volume,
		Source.mass,
		Source.hidden,
		Source.health,
		Source.descriptiontoken,
		Source.purchasable,
		Source.tiertype,
		Source.tierlevel);

GO

---- Landmine detector modules and prototypes stats ----

DECLARE @core_usage_field int
DECLARE @cpu_usage_field int
DECLARE @cycle_time_field int
DECLARE @powergrid_usage_field int
DECLARE @effect_mine_detection_range_modifier_field int
DECLARE @definition int
DECLARE @tempTable TABLE (definition INT, field INT, value FLOAT)

SET @core_usage_field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_usage')
SET @cpu_usage_field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_usage')
SET @cycle_time_field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cycle_time')
SET @powergrid_usage_field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_usage')
SET @effect_mine_detection_range_modifier_field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'effect_mine_detection_range_modifier')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_landmine_detector')
INSERT INTO @tempTable (definition, field, value) VALUES
(@definition, @core_usage_field, 14),
(@definition, @cpu_usage_field, 20),
(@definition, @cycle_time_field, 10000),
(@definition, @powergrid_usage_field, 7),
(@definition, @effect_mine_detection_range_modifier_field, 1.3)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_landmine_detector')
INSERT INTO @tempTable (definition, field, value) VALUES
(@definition, @core_usage_field, 14),
(@definition, @cpu_usage_field, 18),
(@definition, @cycle_time_field, 10000),
(@definition, @powergrid_usage_field, 6),
(@definition, @effect_mine_detection_range_modifier_field, 1.3)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_landmine_detector_pr')
INSERT INTO @tempTable (definition, field, value) VALUES
(@definition, @core_usage_field, 12),
(@definition, @cpu_usage_field, 17),
(@definition, @cycle_time_field, 10000),
(@definition, @powergrid_usage_field, 6),
(@definition, @effect_mine_detection_range_modifier_field, 1.3)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_landmine_detector')
INSERT INTO @tempTable (definition, field, value) VALUES
(@definition, @core_usage_field, 14),
(@definition, @cpu_usage_field, 23),
(@definition, @cycle_time_field, 10000),
(@definition, @powergrid_usage_field, 7),
(@definition, @effect_mine_detection_range_modifier_field, 1.4)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_landmine_detector_pr')
INSERT INTO @tempTable (definition, field, value) VALUES
(@definition, @core_usage_field, 12),
(@definition, @cpu_usage_field, 22),
(@definition, @cycle_time_field, 10000),
(@definition, @powergrid_usage_field, 7),
(@definition, @effect_mine_detection_range_modifier_field, 1.4)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_landmine_detector')
INSERT INTO @tempTable (definition, field, value) VALUES
(@definition, @core_usage_field, 18),
(@definition, @cpu_usage_field, 25),
(@definition, @cycle_time_field, 10000),
(@definition, @powergrid_usage_field, 8),
(@definition, @effect_mine_detection_range_modifier_field, 1.5)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_landmine_detector_pr')
INSERT INTO @tempTable (definition, field, value) VALUES
(@definition, @core_usage_field, 15),
(@definition, @cpu_usage_field, 24),
(@definition, @cycle_time_field, 10000),
(@definition, @powergrid_usage_field, 8),
(@definition, @effect_mine_detection_range_modifier_field, 1.5)

MERGE aggregatevalues AS Target
USING (SELECT definition, field, value FROM @tempTable) AS Source
ON (Target.definition = Source.definition AND Target.field = Source.field)
WHEN MATCHED THEN
    UPDATE SET Target.value = Source.value
WHEN NOT MATCHED BY TARGET THEN
    INSERT (definition, field, value)
    VALUES (Source.definition, Source.field, Source.value);

GO

---- Production and prorotyping cost in materials, modulesand components ----

DECLARE @definition INT

DECLARE @titanium_definition INT
DECLARE @cryoperine_definition INT
DECLARE @espitium INT
DECLARE @bryochite INT

DECLARE @common_basic_components INT
DECLARE @common_advanced_components INT
DECLARE @common_expert_components INT

DECLARE @t1_mine_detector INT
DECLARE @t2_mine_detector INT
DECLARE @t3_mine_detector INT

SET @titanium_definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_titanium')
SET @cryoperine_definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_axicol') -- axicoline Y U NO cryoperine
SET @espitium = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_espitium')
SET @bryochite = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_unimetal') -- unimetal Y U NO bryochite

SET @common_basic_components = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_basic')
SET @common_advanced_components = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_advanced')
SET @common_expert_components = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robotshard_common_expert')

SET @t1_mine_detector = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_landmine_detector')
SET @t2_mine_detector = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_landmine_detector')
SET @t3_mine_detector = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_landmine_detector')

DECLARE @tempTable TABLE (definition INT, componentdefinition INT, componentamount INT)

-- Modules --
SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_landmine_detector')
INSERT INTO @tempTable (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium_definition, 100),
(@definition, @cryoperine_definition, 400)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_landmine_detector')
INSERT INTO @tempTable (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium_definition, 100),
(@definition, @cryoperine_definition, 400),
(@definition, @t1_mine_detector, 1),
(@definition, @common_basic_components, 30)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_landmine_detector')
INSERT INTO @tempTable (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium_definition, 100),
(@definition, @cryoperine_definition, 200),
(@definition, @espitium, 200),
(@definition, @t2_mine_detector, 1),
(@definition, @common_basic_components, 20),
(@definition, @common_advanced_components, 20)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_landmine_detector')
INSERT INTO @tempTable (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium_definition, 100),
(@definition, @cryoperine_definition, 400),
(@definition, @espitium, 400),
(@definition, @bryochite, 400),
(@definition, @t3_mine_detector, 1),
(@definition, @common_basic_components, 15),
(@definition, @common_advanced_components, 30),
(@definition, @common_expert_components, 45)

-- Prototypes --
SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_landmine_detector_pr')
INSERT INTO @tempTable (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium_definition, 100),
(@definition, @cryoperine_definition, 400),
(@definition, @t1_mine_detector, 1),
(@definition, @common_basic_components, 30)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_landmine_detector_pr')
INSERT INTO @tempTable (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium_definition, 100),
(@definition, @cryoperine_definition, 200),
(@definition, @espitium, 200),
(@definition, @t2_mine_detector, 1),
(@definition, @common_basic_components, 20),
(@definition, @common_advanced_components, 20)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_landmine_detector_pr')
INSERT INTO @tempTable (definition, componentdefinition, componentamount) VALUES
(@definition, @titanium_definition, 100),
(@definition, @cryoperine_definition, 400),
(@definition, @espitium, 400),
(@definition, @bryochite, 400),
(@definition, @t3_mine_detector, 1),
(@definition, @common_basic_components, 15),
(@definition, @common_advanced_components, 30),
(@definition, @common_expert_components, 45)

MERGE components AS Target
USING (SELECT definition, componentdefinition, componentamount FROM @tempTable) AS Source
ON (Target.definition = Source.definition AND Target.componentdefinition = Source.componentdefinition)
WHEN MATCHED THEN
    UPDATE SET Target.componentamount = Source.componentamount
WHEN NOT MATCHED BY TARGET THEN
    INSERT (definition, componentdefinition, componentamount)
    VALUES (Source.definition, Source.componentdefinition, Source.componentamount);

GO

---- Research levels ----

DECLARE @definition INT
DECLARE @calibration INT
DECLARE @tempTable TABLE (definition INT, researchlevel INT, calibrationprogram INT, enabled BIT)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_landmine_detector')
SET @calibration = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_landmine_detector_cprg')
INSERT INTO @tempTable (definition, researchlevel, calibrationprogram, enabled) VALUES
(@definition, 6, @calibration, 1)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_landmine_detector_pr')
SET @calibration = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_landmine_detector_cprg')
INSERT INTO @tempTable (definition, researchlevel, calibrationprogram, enabled) VALUES
(@definition, 7, @calibration, 1)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_landmine_detector_pr')
SET @calibration = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_landmine_detector_cprg')
INSERT INTO @tempTable (definition, researchlevel, calibrationprogram, enabled) VALUES
(@definition, 8, @calibration, 1)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_landmine_detector_pr')
SET @calibration = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_landmine_detector_cprg')
INSERT INTO @tempTable (definition, researchlevel, calibrationprogram, enabled) VALUES
(@definition, 9, @calibration, 1)

MERGE itemresearchlevels AS Target
USING (SELECT definition, researchlevel, calibrationprogram, enabled FROM @tempTable) AS Source
ON (Target.definition = Source.definition)
WHEN MATCHED THEN
    UPDATE SET 
		Target.researchlevel = Source.researchlevel,
		Target.calibrationprogram = Source.calibrationprogram,
		Target.enabled = Source.enabled
WHEN NOT MATCHED BY TARGET THEN
    INSERT (definition, researchlevel, calibrationprogram, enabled)
    VALUES (Source.definition, Source.researchlevel, Source.calibrationprogram, Source.enabled);

GO

---- Position in tech tree ----

DECLARE @parent INT
DECLARE @t1 INT
DECLARE @t2 INT
DECLARE @t3 INT
DECLARE @t4 INT
DECLARE @group INT
DECLARE @tempTable TABLE (parentdefinition INT, childdefinition INT, groupID INT, x INT, y INT, enablerextensionid INT)

SET @parent = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_blob_emission_modulator')
SET @t1 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_landmine_detector')
SET @t2 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_landmine_detector')
SET @t3 = (SELECT TOP 1 definition definition FROM entitydefaults WHERE definitionname = 'def_named2_landmine_detector')
SET @t4 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_landmine_detector')
SET @group = (SELECT TOP 1 id FROM [techtreegroups] WHERE name = 'common2')

INSERT INTO @tempTable (parentdefinition, childdefinition, groupID, x, y, enablerextensionid) VALUES
(@parent, @t1, @group, 5, 19, NULL),
(@t1, @t2, @group, 6, 19, NULL),
(@t2, @t3, @group, 7, 19, NULL),
(@t3, @t4, @group, 8, 19, NULL)

MERGE techtree AS Target
USING (SELECT parentdefinition, childdefinition, groupID, x, y, enablerextensionid FROM @tempTable) AS Source
ON (Target.childdefinition = Source.childdefinition AND Target.groupID = Source.groupID)
WHEN MATCHED THEN
    UPDATE SET 
		Target.parentdefinition = Source.parentdefinition,
		Target.x = Source.x,
		Target.y = Source.y,
		Target.enablerextensionid = Source.enablerextensionid
WHEN NOT MATCHED BY TARGET THEN
    INSERT (parentdefinition, childdefinition, groupID, x, y, enablerextensionid)
    VALUES (Source.parentdefinition, Source.childdefinition, Source.groupID, Source.x, Source.y, Source.enablerextensionid);

GO

----Research cost ----

DECLARE @definition INT
DECLARE @common INT
DECLARE @hightech INT

SET @common = (SELECT TOP 1 id FROM techtreepointtypes WHERE name = 'common')
SET @hightech = (SELECT TOP 1 id FROM techtreepointtypes WHERE name = 'hitech')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_landmine_detector')
INSERT INTO [techtreenodeprices] (definition, pointtype, amount) VALUES
(@definition, @common, 25000)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_landmine_detector')
INSERT INTO [techtreenodeprices] (definition, pointtype, amount) VALUES
(@definition, @common, 43200)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_landmine_detector')
INSERT INTO [techtreenodeprices] (definition, pointtype, amount) VALUES
(@definition, @common, 68600)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_landmine_detector')
INSERT INTO [techtreenodeprices] (definition, pointtype, amount) VALUES
(@definition, @common, 51200)
INSERT INTO [techtreenodeprices] (definition, pointtype, amount) VALUES
(@definition, @hightech, 25600)

GO

---- Link modules and their prototypes----

DECLARE @module int
DECLARE @prototype int
DECLARE @tempTable TABLE (definition INT, prototype INT)

SET @module = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname LIKE 'def_named1_landmine_detector')
SET @prototype = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname LIKE 'def_named1_landmine_detector_pr')

INSERT INTO @tempTable (definition, prototype) VALUES (@module, @prototype)

SET @module = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname LIKE 'def_named2_landmine_detector')
SET @prototype = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname LIKE 'def_named2_landmine_detector_pr')

INSERT INTO @tempTable (definition, prototype) VALUES (@module, @prototype)

SET @module = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname LIKE 'def_named3_landmine_detector')
SET @prototype = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname LIKE 'def_named3_landmine_detector_pr')

INSERT INTO @tempTable (definition, prototype) VALUES (@module, @prototype)

MERGE prototypes AS Target
USING (SELECT definition, prototype FROM @tempTable) AS Source
ON (Target.definition = Source.definition)
WHEN MATCHED THEN
    UPDATE SET 
		Target.prototype = Source.prototype
WHEN NOT MATCHED BY TARGET THEN
    INSERT (definition, prototype)
    VALUES (Source.definition, Source.prototype);

GO

GO

---- Landmine detection effect category ----

DELETE FROM effectcategories WHERE name = 'effcat_mine_detection'

INSERT INTO effectcategories (name, flag, maxlevel, note) VALUES
('effcat_mine_detection', 46, 1, NULL)

---- Landmine detection effect ----

IF NOT EXISTS (SELECT 1 FROM effects WHERE name = 'effect_mine_detector')
BEGIN
	INSERT INTO effects (effectcategory, duration, name, description, note, isaura, auraradius, ispositive, display, saveable) VALUES
	(70368744177664, 10500, 'effect_mine_detector', 'effect_mine_detector_desc', 'mine detector', 0, 0, 1, 3, 0)
END

GO

---- Link effect modifier with it's enhancer

DECLARE @category INT
DECLARE @basefield INT
DECLARE @modifier INT

SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_landmine_detectors')
SET @basefield = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'effect_mine_detection_range_modifier')
SET @modifier = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'effect_enhancer_mine_detection_range_modifier')

INSERT INTO aggregatemodifiers (categoryflag, basefield, modifierfield) VALUES
(@category, @basefield, @modifier)

GO

---- Add landmines to public market ----

DECLARE @public_market_definition INT
SET @public_market_definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_public_market')

DECLARE @definition INT

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_light_landmine_capsule')

INSERT INTO marketitems (marketeid, submittereid, itemdefinition, duration, isSell, price, quantity, isvendoritem)
	(SELECT v.marketEID, v.vendorEID, @definition, 0, 1, 500000, -1, 1 FROM entities e
	INNER JOIN entitydefaults ed
	ON e.definition = ed.definition
	INNER JOIN vendors v
	ON v.marketEID = e.eid
	WHERE ed.definition = @public_market_definition)

INSERT INTO marketitems (marketeid, submittereid, itemdefinition, duration, isSell, price, quantity, isvendoritem)
	(SELECT e.eid, v.vendorEID, @definition, 0, 0, 50000, -1, 1 FROM entities e
	INNER JOIN entitydefaults ed
	ON e.definition = ed.definition
	INNER JOIN vendors v
	ON v.marketEID = e.eid
	WHERE ed.definition = @public_market_definition)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_medium_landmine_capsule')

INSERT INTO marketitems (marketeid, submittereid, itemdefinition, duration, isSell, price, quantity, isvendoritem)
	(SELECT e.eid, v.vendorEID, @definition, 0, 1, 1000000, -1, 1 FROM entities e
	INNER JOIN entitydefaults ed
	ON e.definition = ed.definition
	INNER JOIN vendors v
	ON v.marketEID = e.eid
	WHERE ed.definition = @public_market_definition)

INSERT INTO marketitems (marketeid, submittereid, itemdefinition, duration, isSell, price, quantity, isvendoritem)
	(SELECT e.eid, v.vendorEID, @definition, 0, 0, 100000, -1, 1 FROM entities e
	INNER JOIN entitydefaults ed
	ON e.definition = ed.definition
	INNER JOIN vendors v
	ON v.marketEID = e.eid
	WHERE ed.definition = @public_market_definition)

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_heavy_landmine_capsule')

INSERT INTO marketitems (marketeid, submittereid, itemdefinition, duration, isSell, price, quantity, isvendoritem)
	(SELECT e.eid, v.vendorEID, @definition, 0, 1, 1500000, -1, 1 FROM entities e
	INNER JOIN entitydefaults ed
	ON e.definition = ed.definition
	INNER JOIN vendors v
	ON v.marketEID = e.eid
	WHERE ed.definition = @public_market_definition)

INSERT INTO marketitems (marketeid, submittereid, itemdefinition, duration, isSell, price, quantity, isvendoritem)
	(SELECT e.eid, v.vendorEID, @definition, 0, 0, 150000, -1, 1 FROM entities e
	INNER JOIN entitydefaults ed
	ON e.definition = ed.definition
	INNER JOIN vendors v
	ON v.marketEID = e.eid
	WHERE ed.definition = @public_market_definition)
	
GO