USE perpetuumsa
GO
----------------------------------------------------------
-- Gamma turret weapon balance
-- Date modified: 2020/12/26
----------------------------------------------------------
PRINT N'updating PBS turret module ranges';
DROP TABLE IF EXISTS #STATS;
CREATE TABLE #STATS
(
	defName varchar(100),
	fieldName varchar(100),
	fieldValue float,
);
INSERT INTO #STATS (defName, fieldName, fieldValue) VALUES
('def_turret_laser', 'optimal_range', 85),--90
('def_turret_laser', 'falloff', 60),--30
('def_ammo_longrange_missile_pbs_turret', 'optimal_range', 75), --75
('def_ammo_longrange_missile_pbs_turret', 'falloff', 35), --0
('def_turret_missile_launcher', 'module_missile_range_modifier', 1), --1.2
('def_turret_missile_launcher', 'module_missile_falloff_modifier', 1), --N/A
('def_turret_railgun', 'optimal_range', 65),--90
('def_turret_railgun', 'falloff', 50),
('def_turret_energy_neutralizer', 'optimal_range', 50),--90
('def_turret_energy_neutralizer', 'falloff', 70),--0
('def_turret_webber', 'optimal_range', 60),--90
('def_turret_webber', 'falloff', 30),--0
('def_turret_sensor_jammer', 'optimal_range', 60),--90
('def_turret_sensor_jammer', 'falloff', 30),--0
('def_turret_sensor_dampener', 'optimal_range', 75),--90
('def_turret_sensor_dampener', 'falloff', 50);--0

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
