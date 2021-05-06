USE [perpetuumsa]
GO

-------------------------------------------------------
-- Assault bonus bug
-- Flat weapon type damage bonus is linear, the size specific is the desired bonus type
-- Add small/medium so both receive bonus as intended
-- Date Modified: 2021/05/05
-------------------------------------------------------

DROP TABLE IF EXISTS #BONUS;
CREATE TABLE #BONUS(
	defName VARCHAR(100),
	fieldName VARCHAR(100),
	extName VARCHAR(100),
	bonusAmount FLOAT
);
INSERT INTO #BONUS (defName, fieldName, extName, bonusAmount) VALUES
('def_waspish_chassis','damage_medium_missile_modifier','ext_lightarmored_unit_piloting',0.05),
('def_waspish_chassis','damage_small_missile_modifier','ext_lightarmored_unit_piloting',0.05),
('def_waspish_chassis','missile_cycle_time_modifier','ext_lightarmored_unit_piloting',0.02),

('def_waspish_chassis_mk2','damage_medium_missile_modifier','ext_lightarmored_unit_piloting',0.05),
('def_waspish_chassis_mk2','damage_small_missile_modifier','ext_lightarmored_unit_piloting',0.05),
('def_waspish_chassis_mk2','missile_cycle_time_modifier','ext_lightarmored_unit_piloting',0.02),

('def_waspish_chassis_pr','damage_medium_missile_modifier','ext_lightarmored_unit_piloting',0.05),
('def_waspish_chassis_pr','damage_small_missile_modifier','ext_lightarmored_unit_piloting',0.05),
('def_waspish_chassis_pr','missile_cycle_time_modifier','ext_lightarmored_unit_piloting',0.02),

('def_arbalest_chassis','damage_medium_railgun_modifier','ext_lightarmored_unit_piloting',0.05),
('def_arbalest_chassis','damage_small_railgun_modifier','ext_lightarmored_unit_piloting',0.05),
('def_arbalest_chassis','damage_small_missile_modifier','ext_lightarmored_unit_piloting',0.05),

('def_arbalest_chassis_mk2','damage_medium_railgun_modifier','ext_lightarmored_unit_piloting',0.05),
('def_arbalest_chassis_mk2','damage_small_railgun_modifier','ext_lightarmored_unit_piloting',0.05),
('def_arbalest_chassis_mk2','damage_small_missile_modifier','ext_lightarmored_unit_piloting',0.05),

('def_arbalest_chassis_pr','damage_medium_railgun_modifier','ext_lightarmored_unit_piloting',0.05),
('def_arbalest_chassis_pr','damage_small_railgun_modifier','ext_lightarmored_unit_piloting',0.05),
('def_arbalest_chassis_pr','damage_small_missile_modifier','ext_lightarmored_unit_piloting',0.05),

('def_baphomet_chassis','core_usage_laser_modifier','ext_lightarmored_unit_piloting',-0.03),
('def_baphomet_chassis','damage_medium_laser_modifier','ext_lightarmored_unit_piloting',0.05),
('def_baphomet_chassis','damage_small_laser_modifier','ext_lightarmored_unit_piloting',0.05),

('def_baphomet_chassis_pr','core_usage_laser_modifier','ext_lightarmored_unit_piloting',-0.03),
('def_baphomet_chassis_pr','damage_medium_laser_modifier','ext_lightarmored_unit_piloting',0.05),
('def_baphomet_chassis_pr','damage_small_laser_modifier','ext_lightarmored_unit_piloting',0.05),

('def_baphomet_chassis_mk2','core_usage_laser_modifier','ext_lightarmored_unit_piloting',-0.03),
('def_baphomet_chassis_mk2','damage_medium_laser_modifier','ext_lightarmored_unit_piloting',0.05),
('def_baphomet_chassis_mk2','damage_small_laser_modifier','ext_lightarmored_unit_piloting',0.05),

('def_daidalos_chassis','damage_medium_projectile_modifier','ext_heavyarmored_unit_piloting',0.1),
('def_daidalos_chassis','damage_small_projectile_modifier','ext_heavyarmored_unit_piloting',0.1),

('def_hermes_chassis','damage_medium_projectile_modifier','ext_lightarmored_unit_piloting',0.03),
('def_hermes_chassis','damage_small_projectile_modifier','ext_lightarmored_unit_piloting',0.03),

('def_locust_chassis','damage_medium_projectile_modifier','ext_lightarmored_unit_piloting',0.03),
('def_locust_chassis','damage_small_projectile_modifier','ext_lightarmored_unit_piloting',0.03),
('def_locust_chassis','projectile_falloff_modifier','ext_lightarmored_unit_piloting',0.03),
('def_locust_chassis','damage_toxic_modifier','ext_syndicate_combat_specialist',0.5);

--SELECT * FROM chassisbonus WHERE definition IN 
--	(SELECT definition FROM entitydefaults WHERE definitionname IN 
--		(SELECT DISTINCT defName FROM #BONUS));

PRINT N'DELETE CHASSIS BONUSES TO BE REPLACED (15 rows affected)<-1ST RUN';
DELETE FROM chassisbonus WHERE definition IN 
	(SELECT definition FROM entitydefaults WHERE definitionname IN 
		(SELECT DISTINCT defName FROM #BONUS));

PRINT N'INSERT CHASSIS BONUSES (25 rows affected)';
INSERT INTO chassisbonus (definition, extension, bonus, note, targetpropertyID, effectenhancer)
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defName),
	(SELECT TOP 1 extensionid FROM extensions WHERE extensionname=extName),
	bonusAmount, NULL,
	(SELECT TOP 1 id FROM aggregatefields WHERE name=fieldName),
	0
FROM #BONUS;

DROP TABLE IF EXISTS #BONUS;
GO