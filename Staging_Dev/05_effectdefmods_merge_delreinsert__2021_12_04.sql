USE [perpetuumsa]
GO

--------------------------------------------
-- Update script for all pbs effects (assuming no new effects)
--
-- Date modified: 2021/12/04
--------------------------------------------


PRINT N'PBS EFFECTS UPDATE';
DROP TABLE IF EXISTS #PBS_EFFECTS;
CREATE TABLE #PBS_EFFECTS(
	effName VARCHAR(128),
	fieldName VARCHAR(128),
	modValue FLOAT
);
INSERT INTO #PBS_EFFECTS(effName, fieldName, modValue) VALUES
--boosters
('effect_pbs_booster_cycle_time_lvl1','effect_weapon_cycle_time_modifier',0.75),
('effect_pbs_booster_cycle_time_lvl2','effect_weapon_cycle_time_modifier',0.7),
('effect_pbs_booster_cycle_time_lvl3','effect_weapon_cycle_time_modifier',0.65),

('effect_pbs_booster_resist_lvl1','effect_resist_chemical',100),
('effect_pbs_booster_resist_lvl1','effect_resist_explosive',100),
('effect_pbs_booster_resist_lvl1','effect_resist_kinetic',100),
('effect_pbs_booster_resist_lvl1','effect_resist_thermal',100),

('effect_pbs_booster_resist_lvl2','effect_resist_chemical',125),
('effect_pbs_booster_resist_lvl2','effect_resist_explosive',125),
('effect_pbs_booster_resist_lvl2','effect_resist_kinetic',125),
('effect_pbs_booster_resist_lvl2','effect_resist_thermal',125),

('effect_pbs_booster_resist_lvl3','effect_resist_chemical',150),
('effect_pbs_booster_resist_lvl3','effect_resist_explosive',150),
('effect_pbs_booster_resist_lvl3','effect_resist_kinetic',150),
('effect_pbs_booster_resist_lvl3','effect_resist_thermal',150),

('effect_pbs_booster_sensor_lvl1','effect_detection_strength_modifier',5),
('effect_pbs_booster_sensor_lvl1','effect_missile_range_modifier',1.1),
('effect_pbs_booster_sensor_lvl1','effect_optimal_range_modifier',1.1),
--('effect_pbs_booster_sensor_lvl1','effect_sensor_booster_locking_range_modifier',1.125),
('effect_pbs_booster_sensor_lvl1','effect_sensor_booster_locking_time_modifier',0.8),
('effect_pbs_booster_sensor_lvl1','effect_sensor_strength_modifier',1.2),

('effect_pbs_booster_sensor_lvl2','effect_detection_strength_modifier',6),
('effect_pbs_booster_sensor_lvl2','effect_missile_range_modifier',1.125),
('effect_pbs_booster_sensor_lvl2','effect_optimal_range_modifier',1.125),
--('effect_pbs_booster_sensor_lvl2','effect_sensor_booster_locking_range_modifier',1.15),
('effect_pbs_booster_sensor_lvl2','effect_sensor_booster_locking_time_modifier',0.75),
('effect_pbs_booster_sensor_lvl2','effect_sensor_strength_modifier',1.25),

('effect_pbs_booster_sensor_lvl3','effect_detection_strength_modifier',7),
('effect_pbs_booster_sensor_lvl3','effect_missile_range_modifier',1.15),
('effect_pbs_booster_sensor_lvl3','effect_optimal_range_modifier',1.15),
--('effect_pbs_booster_sensor_lvl3','effect_sensor_booster_locking_range_modifier',1.175),
('effect_pbs_booster_sensor_lvl3','effect_sensor_booster_locking_time_modifier',0.7),
('effect_pbs_booster_sensor_lvl3','effect_sensor_strength_modifier',1.3),

--aura emitter
('effect_pbs_engineering_lvl1','effect_core_recharge_time_modifier',0.96),
('effect_pbs_engineering_lvl1','effect_repair_amount_modifier',1.075),
--('effect_pbs_engineering_lvl1','effect_locking_time_modifier',1.035),
('effect_pbs_engineering_lvl2','effect_core_recharge_time_modifier',0.95),
('effect_pbs_engineering_lvl2','effect_repair_amount_modifier',1.1),
--('effect_pbs_engineering_lvl2','effect_locking_time_modifier',1.05),
('effect_pbs_engineering_lvl3','effect_core_recharge_time_modifier',0.94),
('effect_pbs_engineering_lvl3','effect_repair_amount_modifier',1.125),
--('effect_pbs_engineering_lvl3','effect_locking_time_modifier',1.075),

('effect_pbs_industry_lvl1','effect_harvesting_amount_modifier',1.05),
('effect_pbs_industry_lvl1','effect_mining_amount_modifier',1.05),
('effect_pbs_industry_lvl1','effect_mining_probe_accuracy_modifier',1.1),
('effect_pbs_industry_lvl2','effect_harvesting_amount_modifier',1.075),
('effect_pbs_industry_lvl2','effect_mining_amount_modifier',1.075),
('effect_pbs_industry_lvl2','effect_mining_probe_accuracy_modifier',1.125),
('effect_pbs_industry_lvl3','effect_harvesting_amount_modifier',1.10),
('effect_pbs_industry_lvl3','effect_mining_amount_modifier',1.10),
('effect_pbs_industry_lvl3','effect_mining_probe_accuracy_modifier',1.15),

('effect_pbs_sensors_lvl1','effect_detection_strength_modifier',5),
('effect_pbs_sensors_lvl1','effect_stealth_strength_modifier',10),
--('effect_pbs_sensors_lvl1','effect_ecm_strength_modifier',1.025),
('effect_pbs_sensors_lvl2','effect_detection_strength_modifier',6),
('effect_pbs_sensors_lvl2','effect_stealth_strength_modifier',12.5),
--('effect_pbs_sensors_lvl2','effect_ecm_strength_modifier',1.035),
('effect_pbs_sensors_lvl3','effect_detection_strength_modifier',7),
('effect_pbs_sensors_lvl3','effect_stealth_strength_modifier',15),
--('effect_pbs_sensors_lvl3','effect_ecm_strength_modifier',1.05),

--colix mining tower
('effect_pbs_mining_tower_gammaterial_lvl1','effect_mining_amount_modifier',1.1),
('effect_pbs_mining_tower_gammaterial_lvl2','effect_mining_amount_modifier',1.15),
('effect_pbs_mining_tower_gammaterial_lvl3','effect_mining_amount_modifier',1.2),

--masking tower
('effect_pbs_gap_generator_masking_lvl1','effect_stealth_strength_modifier',10),
('effect_pbs_gap_generator_masking_lvl2','effect_stealth_strength_modifier',12.5),
('effect_pbs_gap_generator_masking_lvl3','effect_stealth_strength_modifier',15)
;

SELECT * FROM effectdefaultmodifiers WHERE effectid IN (
	SELECT id FROM effects WHERE name IN (
		SELECT DISTINCT effName FROM #PBS_EFFECTS
	)
); 
DELETE FROM effectdefaultmodifiers WHERE effectid IN (
	SELECT id FROM effects WHERE name IN (
		SELECT DISTINCT effName FROM #PBS_EFFECTS
	)
); 

PRINT N'Merge all pbs effect modifiers';
MERGE [dbo].[effectdefaultmodifiers] v USING #PBS_EFFECTS s
ON v.effectid = (SELECT TOP 1 id FROM effects WHERE name=s.effName) AND
v.field = (SELECT TOP 1 id FROM aggregatefields WHERE name=s.fieldName)
WHEN MATCHED
    THEN UPDATE SET
		v.value=s.modValue
WHEN NOT MATCHED
    THEN INSERT (effectid, field, value) VALUES
	((SELECT TOP 1 id FROM effects WHERE name=s.effName),
	(SELECT TOP 1 id FROM aggregatefields WHERE name=s.fieldName),
	s.modValue);

PRINT N'PBS EFFECTS UPDATED';
DROP TABLE IF EXISTS #PBS_EFFECTS;
GO