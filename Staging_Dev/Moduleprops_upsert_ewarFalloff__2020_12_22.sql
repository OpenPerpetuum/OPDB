USE [perpetuumsa]
GO

----------------------------------------------------------
-- Add falloff and falloff modifiers to Ewar/Enwar modules
-- Falloff add to "turret" type modules
-- modulepropertymodifiers added if missing
-- Date modified: 2020/12/22
----------------------------------------------------------

PRINT N'ADD FALLOFF MODIFIERS TO E(N)WAR MODULES';
DROP TABLE IF EXISTS #MOD_PROPS;
CREATE TABLE #MOD_PROPS (
	categoryName VARCHAR(100),
	baseFieldName VARCHAR(100),
	modFieldName VARCHAR(100)
);
INSERT INTO #MOD_PROPS (categoryName, baseFieldName, modFieldName) VALUES
('cf_energy_neutralizers', 'falloff', 'falloff_modifier'),
('cf_energy_transferers', 'falloff', 'falloff_modifier'),
('cf_energy_vampires', 'falloff', 'falloff_modifier'),
('cf_sensor_jammers', 'falloff', 'falloff_modifier'),
('cf_sensor_dampeners', 'falloff', 'falloff_modifier'),
('cf_webber', 'falloff', 'falloff_modifier');


--insert [modulepropertymodifiers] entries
PRINT N'6 rows if new, 0 if already run';
MERGE [dbo].[modulepropertymodifiers] m USING #MOD_PROPS t
ON m.categoryflags = (SELECT TOP 1 value FROM categoryflags WHERE name=t.categoryName) AND
m.basefield=(SELECT TOP 1 id FROM aggregatefields WHERE name=t.baseFieldName) AND
m.modifierfield=(SELECT TOP 1 id FROM aggregatefields WHERE name=t.modFieldName)
WHEN NOT MATCHED
    THEN INSERT (categoryflags, basefield, modifierfield) VALUES
	((SELECT TOP 1 value FROM categoryflags WHERE name=t.categoryName),
	(SELECT TOP 1 id FROM aggregatefields WHERE name=t.baseFieldName),
	(SELECT TOP 1 id FROM aggregatefields WHERE name=t.modFieldName));

PRINT N'Done adding FALLOFF MODIFIERS TO E(N)WAR MODULES';
DROP TABLE IF EXISTS #MOD_PROPS;
GO



USE perpetuumsa
GO

DROP TABLE IF EXISTS #STATS;
CREATE TABLE #STATS
(
	defName varchar(100),
	fieldName varchar(100),
	fieldValue float,
);
INSERT INTO #STATS (defName, fieldName, fieldValue) VALUES
('def_turret_laser', 'optimal_range', 90),--90
('def_turret_laser', 'falloff', 40),--30
('def_ammo_longrange_missile_pbs_turret', 'optimal_range', 85), --75
('def_ammo_longrange_missile_pbs_turret', 'falloff', 10), --0
('def_turret_missile_launcher', 'module_missile_range_modifier', 1), --1.2
('def_turret_missile_launcher', 'module_missile_falloff_modifier', 1), --N/A
('def_turret_railgun', 'optimal_range', 80),--90
('def_turret_railgun', 'falloff', 30),
('def_turret_energy_neutralizer', 'optimal_range', 80),--90
('def_turret_energy_neutralizer', 'falloff', 10),--0
('def_turret_webber', 'optimal_range', 80),--90
('def_turret_webber', 'falloff', 5),--0
('def_turret_sensor_jammer', 'optimal_range', 80),--90
('def_turret_sensor_jammer', 'falloff', 10),--0
('def_turret_sensor_dampener', 'optimal_range', 80),--90
('def_turret_sensor_dampener', 'falloff', 40);--0

MERGE [dbo].[aggregatevalues] v USING #STATS s
ON v.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE s.defName=definitionname) AND
v.field = (SELECT TOP 1 id FROM aggregatefields WHERE name=s.fieldName)
WHEN MATCHED
    THEN UPDATE SET
		v.value=s.fieldValue
WHEN NOT MATCHED
    THEN INSERT (definition, field, value) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE s.defName=definitionname),
	(SELECT TOP 1 id FROM aggregatefields WHERE name=s.fieldName),
	s.fieldValue);
	
DROP TABLE IF EXISTS #STATS;
PRINT N'Done updating PBS turret module ranges';
GO

