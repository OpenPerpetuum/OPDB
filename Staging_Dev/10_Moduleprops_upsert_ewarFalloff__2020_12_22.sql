USE [perpetuumsa]
GO

----------------------------------------------------------
-- Add falloff and falloff modifiers to Ewar/Enwar modules
-- Falloff add to "turret" type modules
-- modulepropertymodifiers added if missing
-- Date modified: 2020/12/29
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
PRINT N'0 if already run';
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
