USE [perpetuumsa]
GO

----------------------------------------------
--Thelodica research tree changes
--Full map of positions w/ new items
--Costs of new items
----------------------------------------------

DECLARE @techGroupId INT;
SET @techGroupId = (SELECT TOP 1 id FROM techtreegroups WHERE name='thelodica');

--Show what the tree for this tech group has, ordered in top-left to bottom-right
--select 
--	(select top 1 definitionname from entitydefaults where definition in (parentdefinition)),
--	(select top 1 definitionname from entitydefaults where definition in (childdefinition)),
--	x, y
--from techtree where groupID=@techGroupId order by y, x;

PRINT N'THELODICA RESEARCH TREE';
DROP TABLE IF EXISTS #TECHSLOTSTHELODICA;
CREATE TABLE #TECHSLOTSTHELODICA
(
	preDefName VARCHAR(100),
	defName VARCHAR(100),
	x INT,
	y INT
);
INSERT INTO #TECHSLOTSTHELODICA (preDefName, defName, x, y) VALUES
('def_ammo_small_lasercrystal_d','def_ammo_small_lasercrystal_a',2,0),
('def_ammo_medium_lasercrystal_d','def_ammo_medium_lasercrystal_a',5,0),
('def_standard_small_laser','def_ammo_small_lasercrystal_d',1,1),
('def_ammo_small_lasercrystal_d','def_ammo_small_lasercrystal_c',2,1),
('def_standard_medium_laser','def_ammo_medium_lasercrystal_d',4,1),
('def_ammo_medium_lasercrystal_d','def_ammo_medium_lasercrystal_c',5,1),
('def_ammo_small_lasercrystal_d','def_ammo_small_lasercrystal_b',2,2),
('def_ammo_medium_lasercrystal_d','def_ammo_medium_lasercrystal_b',5,2),
(NULL,'def_standard_small_laser',0,5),
('def_standard_small_laser','def_prometheus_bot',1,5),
('def_named1_small_laser','def_baphomet_bot',2,5),
('def_named2_small_laser','def_standard_medium_laser',3,5),
('def_standard_medium_laser','def_named1_medium_laser',4,5),
('def_named1_medium_laser','def_named2_medium_laser',5,5),
('def_named2_medium_laser','def_named3_medium_laser',6,5),
('def_named1_longrange_medium_laser','def_seth_bot',7,5),
('def_standard_small_laser','def_named1_small_laser',1,6),
('def_named1_small_laser','def_named2_small_laser',2,6),
('def_named2_small_laser','def_named3_small_laser',3,6),
('def_standard_medium_laser','def_artemis_bot',4,6),
('def_named1_medium_laser','def_longrange_standard_medium_laser',5,4),
('def_longrange_standard_medium_laser','def_named1_longrange_medium_laser',6,4),
('def_named1_longrange_medium_laser','def_named2_longrange_medium_laser',7,4),
('def_named2_longrange_medium_laser','def_named3_longrange_medium_laser',8,4),
('def_named2_damage_mod_laser','def_standard_gang_assist_precision_firing_module',6,8),
('def_standard_gang_assist_precision_firing_module','def_named1_gang_assist_precision_firing_module',7,8),
('def_named1_gang_assist_precision_firing_module','def_named2_gang_assist_precision_firing_module',8,8),
('def_named2_gang_assist_precision_firing_module','def_named3_gang_assist_precision_firing_module',9,8),
('def_standard_small_laser','def_standard_damage_mod_laser',1,7),
('def_standard_damage_mod_laser','def_named1_damage_mod_laser',3,7),
('def_named1_damage_mod_laser','def_named2_damage_mod_laser',5,7),
('def_named2_damage_mod_laser','def_named3_damage_mod_laser',7,7),
('def_named1_small_armor_plate','def_standard_medium_armor_plate',2,9),
('def_standard_medium_armor_plate','def_named1_medium_armor_plate',3,9),
('def_named1_medium_armor_plate','def_named2_medium_armor_plate',4,9),
('def_named2_medium_armor_plate','def_named3_medium_armor_plate',5,9),
('def_named1_resistant_plating','def_standard_gang_assist_defense_module',6,11),
('def_standard_gang_assist_defense_module','def_named1_gang_assist_defense_module',7,11),
('def_named1_gang_assist_defense_module','def_named2_gang_assist_defense_module',8,11),
('def_named2_gang_assist_defense_module','def_named3_gang_assist_defense_module',9,11),
(NULL,'def_standard_small_armor_plate',0,10),
('def_standard_small_armor_plate','def_named1_small_armor_plate',1,10),
('def_named1_small_armor_plate','def_named2_small_armor_plate',2,10),
('def_named2_small_armor_plate','def_named3_small_armor_plate',3,10),
('def_named1_medium_armor_plate','def_standard_resistant_plating',4,10),
('def_standard_resistant_plating','def_named1_resistant_plating',5,10),
('def_named1_resistant_plating','def_named2_resistant_plating',6,10),
('def_named2_resistant_plating','def_named3_resistant_plating',7,10),
('def_standard_small_armor_plate','def_standard_kin_armor_hardener',2,11),
('def_standard_kin_armor_hardener','def_named1_kin_armor_hardener',3,11),
('def_named1_kin_armor_hardener','def_named2_kin_armor_hardener',4,11),
('def_named2_kin_armor_hardener','def_named3_kin_armor_hardener',5,11),
('def_named1_kin_armor_hardener','def_standard_kinetic_kers',4,12),
('def_standard_kinetic_kers','def_named1_kinetic_kers',5,12),
('def_named1_kinetic_kers','def_named2_kinetic_kers',6,12),
('def_named2_kinetic_kers','def_named3_kinetic_kers',7,12),
('def_standard_sensor_dampener','def_intakt_bot',3,13),
('def_named1_sensor_dampener','def_standard_sensor_supressor_booster',4,13),
('def_standard_sensor_supressor_booster','def_named1_sensor_supressor_booster',5,13),
('def_named1_sensor_supressor_booster','def_named2_sensor_supressor_booster',6,13),
('def_named2_sensor_supressor_booster','def_named3_sensor_supressor_booster',7,13),
(NULL,'def_standard_sensor_dampener',2,14),
('def_standard_sensor_dampener','def_named1_sensor_dampener',3,14),
('def_named1_sensor_dampener','def_named2_sensor_dampener',4,14),
('def_named2_sensor_dampener','def_named3_sensor_dampener',5,14),
('def_named2_sensor_dampener','def_zenith_bot',5,15),
('def_zenith_bot','def_standard_gang_assist_information_module',6,15),
('def_standard_gang_assist_information_module','def_named1_gang_assist_information_module',7,15),
('def_named1_gang_assist_information_module','def_named2_gang_assist_information_module',8,15),
('def_named2_gang_assist_information_module','def_named3_gang_assist_information_module',9,15),
--NEW LARGE STUFF
('def_longrange_standard_medium_laser','def_longrange_standard_large_laser',6,3),
('def_longrange_standard_large_laser','def_named1_longrange_large_laser',7,3),
('def_named1_longrange_large_laser','def_named2_longrange_large_laser',8,3),
('def_named2_longrange_large_laser','def_named3_longrange_large_laser',9,3),
('def_named2_medium_laser','def_standard_large_laser',6,6),
('def_standard_large_laser','def_named1_large_laser',7,6),
('def_named1_large_laser','def_named2_large_laser',8,6),
('def_named2_large_laser','def_named3_large_laser',9,6),
('def_longrange_standard_large_laser','def_ammo_large_lasercrystal_d',6,1),
('def_ammo_large_lasercrystal_d','def_ammo_large_lasercrystal_b',7,0),
('def_ammo_large_lasercrystal_d','def_ammo_large_lasercrystal_c',7,1),
('def_ammo_large_lasercrystal_d','def_ammo_large_lasercrystal_a',7,2),
('def_seth_bot','def_onyx_bot',9,5),
('def_named1_resistant_plating','def_standard_large_armor_plate',6,9),
('def_standard_large_armor_plate','def_named1_large_armor_plate',7,9),
('def_named1_large_armor_plate','def_named2_large_armor_plate',8,9),
('def_named2_large_armor_plate','def_named3_large_armor_plate',9,9);

--kernel costs
DROP TABLE IF EXISTS #TECHCOSTTHELODICA;
CREATE TABLE #TECHCOSTTHELODICA
(
	defName VARCHAR(100),
	kernelType INT,
	kernelAmount INT
);
INSERT INTO #TECHCOSTTHELODICA (defName, kernelType, kernelAmount) VALUES
('def_standard_large_laser',1,34300),
('def_standard_large_laser',6,17150),
('def_named1_large_laser',1,51200),
('def_named1_large_laser',6,25600),
('def_named2_large_laser',1,72900),
('def_named2_large_laser',6,36450),
('def_named3_large_laser',1,100000),
('def_named3_large_laser',6,50000),
('def_longrange_standard_large_laser',1,34300),
('def_longrange_standard_large_laser',6,17150),
('def_named1_longrange_large_laser',1,51200),
('def_named1_longrange_large_laser',6,25600),
('def_named2_longrange_large_laser',1,72900),
('def_named2_longrange_large_laser',6,36450),
('def_named3_longrange_large_laser',1,100000),
('def_named3_longrange_large_laser',6,50000),
('def_ammo_large_lasercrystal_d',1,34300),
('def_ammo_large_lasercrystal_d',6,17150),
('def_ammo_large_lasercrystal_b',1,51200),
('def_ammo_large_lasercrystal_b',6,25600),
('def_ammo_large_lasercrystal_c',1,51200),
('def_ammo_large_lasercrystal_c',6,25600),
('def_ammo_large_lasercrystal_a',1,51200),
('def_ammo_large_lasercrystal_a',6,25600),
('def_standard_large_armor_plate',1,34300),
('def_standard_large_armor_plate',6,17150),
('def_named1_large_armor_plate',1,51200),
('def_named1_large_armor_plate',6,25600),
('def_named2_large_armor_plate',1,72900),
('def_named2_large_armor_plate',6,36450),
('def_named3_large_armor_plate',1,100000),
('def_named3_large_armor_plate',6,50000),
('def_onyx_bot',1,500000),
('def_onyx_bot',6,250000);


--Show and delete existing kernel costs
SELECT * FROM techtreenodeprices where definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #TECHCOSTTHELODICA));
DELETE FROM techtreenodeprices where definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #TECHCOSTTHELODICA));

--Insert the fresh prices
INSERT INTO techtreenodeprices (definition, pointtype, amount)
SELECT (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defName), kernelType, kernelAmount from #TECHCOSTTHELODICA;

--Update/insert techtree entries
MERGE [dbo].[techtree] t USING #TECHSLOTSTHELODICA s
ON t.[childdefinition] = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=s.defName)
WHEN MATCHED
    THEN UPDATE SET
		parentdefinition = ISNULL((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=s.preDefName), 0),
		x = s.x,
		y = s.y
WHEN NOT MATCHED
    THEN INSERT ([parentdefinition],[childdefinition],[groupID],[x],[y]) VALUES
	(ISNULL((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=s.preDefName), 0),
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=s.defName),
	@techGroupId, s.x, s.y);

DROP TABLE IF EXISTS #TECHSLOTSTHELODICA;
DROP TABLE IF EXISTS #TECHCOSTTHELODICA;
GO


