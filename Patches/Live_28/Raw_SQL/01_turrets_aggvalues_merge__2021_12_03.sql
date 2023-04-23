USE [perpetuumsa]
GO

----------------------------------------
-- Turret stats
-- Made a distiction for EW turrets
-- Date Modified: 2022/04/15
----------------------------------------

PRINT N'Define all stats and modifiers by tech and turret type';
DROP TABLE IF EXISTS #STATS_BY_TECH;
CREATE TABLE #STATS_BY_TECH(
	tech INT,
	fieldName VARCHAR(128),
	modValue FLOAT
);
INSERT INTO #STATS_BY_TECH (tech, fieldName, modValue) VALUES
(1, 'resist_thermal', 180),
(1, 'resist_kinetic', 180),
(1, 'resist_explosive', 180),
(1, 'resist_chemical', 180),

(2, 'resist_thermal', 240),
(2, 'resist_kinetic', 240),
(2, 'resist_explosive', 240),
(2, 'resist_chemical', 240),

(3, 'resist_thermal', 300),
(3, 'resist_kinetic', 300),
(3, 'resist_explosive', 300),
(3, 'resist_chemical', 300),

(1, 'signature_radius', 12),
(2, 'signature_radius', 18),
(3, 'signature_radius', 30),

(1, 'armor_max', 45000),
(2, 'armor_max', 67500),
(3, 'armor_max', 75000),

(1, 'sensor_strength', 160),
(2, 'sensor_strength', 180),
(3, 'sensor_strength', 200),

(1, 'detection_strength', 125),
(2, 'detection_strength', 125),
(3, 'detection_strength', 125),

(1, 'stealth_strength', 80),
(2, 'stealth_strength', 80),
(3, 'stealth_strength', 80),

(1, 'locking_range_modifier', 1.35),
(2, 'locking_range_modifier', 1.425),
(3, 'locking_range_modifier', 1.50),

(1,'damage_modifier', 0.4),
(2,'damage_modifier', 0.6),
(3,'damage_modifier', 1.0),

(1,'energy_neutralized_amount_modifier', 0.5),
(2,'energy_neutralized_amount_modifier', 0.7),
(3,'energy_neutralized_amount_modifier', 1.0),

(1,'ecm_strength_modifier', 0.85),
(2,'ecm_strength_modifier', 0.9),
(3,'ecm_strength_modifier', 1.0),

(1,'ew_optimal_range_modifier',0.85),
(2,'ew_optimal_range_modifier',0.9),
(3,'ew_optimal_range_modifier',1.0),

(1,'optimal_range_modifier',0.85),
(2,'optimal_range_modifier',0.9),
(3,'optimal_range_modifier',1.0),

(1,'falloff_modifier',1.6),
(2,'falloff_modifier',1.8),
(3,'falloff_modifier',2.0),

(1,'missile_falloff_modifier',1.6),
(2,'missile_falloff_modifier',1.8),
(3,'missile_falloff_modifier',2.0),

(1,'turret_fallof_modifier',1.6),
(2,'turret_fallof_modifier',1.8),
(3,'turret_fallof_modifier',2.0),

(1,'core_max',2500),
(2,'core_max',2500),
(3,'core_max',2500),

-- EW turrets 

(4, 'resist_thermal', 180),
(4, 'resist_kinetic', 180),
(4, 'resist_explosive', 180),
(4, 'resist_chemical', 180),

(5, 'resist_thermal', 240),
(5, 'resist_kinetic', 240),
(5, 'resist_explosive', 240),
(5, 'resist_chemical', 240),

(6, 'resist_thermal', 300),
(6, 'resist_kinetic', 300),
(6, 'resist_explosive', 300),
(6, 'resist_chemical', 300),

(4, 'signature_radius', 12),
(5, 'signature_radius', 18),
(6, 'signature_radius', 30),

(4, 'armor_max', 45000),
(5, 'armor_max', 67500),
(6, 'armor_max', 75000),

(4, 'sensor_strength', 160),
(5, 'sensor_strength', 180),
(6, 'sensor_strength', 200),

(4, 'detection_strength', 135),
(5, 'detection_strength', 135),
(6, 'detection_strength', 135),

(4, 'stealth_strength', 80),
(5, 'stealth_strength', 80),
(6, 'stealth_strength', 80),

(4, 'locking_range_modifier', 1.35),
(5, 'locking_range_modifier', 1.425),
(6, 'locking_range_modifier', 1.50),

(4,'damage_modifier', 0.4),
(5,'damage_modifier', 0.6),
(6,'damage_modifier', 1.0),

(4,'energy_neutralized_amount_modifier', 0.5),
(5,'energy_neutralized_amount_modifier', 0.7),
(6,'energy_neutralized_amount_modifier', 1.0),

(4,'ecm_strength_modifier', 0.85),
(5,'ecm_strength_modifier', 0.9),
(6,'ecm_strength_modifier', 1.0),

(4,'ew_optimal_range_modifier',0.85),
(5,'ew_optimal_range_modifier',0.9),
(6,'ew_optimal_range_modifier',1.0),

(4,'optimal_range_modifier',0.85),
(5,'optimal_range_modifier',0.9),
(6,'optimal_range_modifier',1.0),

(4,'falloff_modifier',1.6),
(5,'falloff_modifier',1.8),
(6,'falloff_modifier',2.0),

(4,'missile_falloff_modifier',1.6),
(5,'missile_falloff_modifier',1.8),
(6,'missile_falloff_modifier',2.0),

(4,'turret_fallof_modifier',1.6),
(5,'turret_fallof_modifier',1.8),
(6,'turret_fallof_modifier',2.0),

(4,'core_max',2500),
(5,'core_max',2500),
(6,'core_max',2500);

DROP TABLE IF EXISTS #TURRETNAME_BY_TECH;
CREATE TABLE #TURRETNAME_BY_TECH(
	defName VARCHAR(128),
	tech INT 
);
INSERT INTO #TURRETNAME_BY_TECH (defName, tech) VALUES
('def_pbs_turret_ew_large', 6),
('def_pbs_turret_ew_medium', 5),
('def_pbs_turret_ew_small', 4),

('def_pbs_turret_laser_large', 3),
('def_pbs_turret_laser_medium', 2),
('def_pbs_turret_laser_small', 1),

('def_pbs_turret_missile_large', 3),
('def_pbs_turret_missile_medium', 2),
('def_pbs_turret_missile_small', 1),

('def_pbs_turret_rail_large', 3),
('def_pbs_turret_rail_medium', 2),
('def_pbs_turret_rail_small', 1);



DROP TABLE IF EXISTS #TURRET_STATS;
CREATE TABLE #TURRET_STATS(
	defName VARCHAR(128),
	fieldName VARCHAR(128),
	modValue FLOAT
);
INSERT INTO #TURRET_STATS (defName, fieldName, modValue)
SELECT t.defName, s.fieldName, s.modValue
FROM #STATS_BY_TECH s
JOIN #TURRETNAME_BY_TECH t ON t.tech=s.tech;

INSERT INTO #TURRET_STATS (defName, fieldName, modValue)
SELECT t.defName+'_capsule', s.fieldName, s.modValue
FROM #STATS_BY_TECH s
JOIN #TURRETNAME_BY_TECH t ON t.tech=s.tech;


PRINT N'Merge all turret stats';
MERGE [dbo].[aggregatevalues] v USING #TURRET_STATS s
ON v.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE s.defName=definitionname) AND
v.field = (SELECT TOP 1 id FROM aggregatefields WHERE name=s.fieldName)
WHEN MATCHED
    THEN UPDATE SET
		v.value=s.modValue
WHEN NOT MATCHED
    THEN INSERT (definition, field, value) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE s.defName=definitionname),
	(SELECT TOP 1 id FROM aggregatefields WHERE name=s.fieldName),
	s.modValue);


DROP TABLE IF EXISTS #STATS_BY_TECH;
DROP TABLE IF EXISTS #TURRET_STATS;
DROP TABLE IF EXISTS #TURRETNAME_BY_TECH;
PRINT N'Turret stats applied';
GO