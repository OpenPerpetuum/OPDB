USE [perpetuumsa]
GO


--Show what the tree for this tech group has, ordered in top-left to bottom-right
--select 
--	(select top 1 definitionname from entitydefaults where definition in (parentdefinition)),
--	(select top 1 definitionname from entitydefaults where definition in (childdefinition)),
--	x, y
--from techtree where groupID=4 order by y, x;


DROP TABLE IF EXISTS #TECHSLOTSPELISTAL;
CREATE TABLE #TECHSLOTSPELISTAL
(
	preDefName VARCHAR(100),
	defName VARCHAR(100),
	x INT,
	y INT
);
INSERT INTO #TECHSLOTSPELISTAL (preDefName, defName, x, y) VALUES
('def_ammo_rocket_d','def_ammo_rocket_b',2,0),
('def_ammo_missile_d','def_ammo_missile_b',5,0),
('def_standard_rocket_launcher','def_ammo_rocket_d',1,1),
('def_ammo_rocket_d','def_ammo_rocket_c',2,1),
('def_standard_missile_launcher','def_ammo_missile_d',4,1),
('def_ammo_missile_d','def_ammo_missile_c',5,1),
('def_ammo_rocket_d','def_ammo_rocket_a',2,2),
('def_ammo_missile_d','def_ammo_missile_a',5,2),
('def_named2_missile_launcher','def_gropho_bot',7,9),
(NULL,'def_standard_rocket_launcher',0,8),
('def_standard_rocket_launcher','def_castel_bot',1,8),
('def_named1_rocket_launcher','def_waspish_bot',2,8),
('def_named2_rocket_launcher','def_standard_missile_launcher',3,8),
('def_standard_missile_launcher','def_named1_missile_launcher',4,8),
('def_named1_missile_launcher','def_named2_missile_launcher',5,8),
('def_named2_missile_launcher','def_named3_missile_launcher',6,8),
('def_ammo_longrange_missile_d','def_ammo_longrange_missile_b',7,0),
('def_standard_rocket_launcher','def_named1_rocket_launcher',1,9),
('def_named1_rocket_launcher','def_named2_rocket_launcher',2,9),
('def_named2_rocket_launcher','def_named3_rocket_launcher',3,9),
('def_standard_missile_launcher','def_tyrannos_bot',4,9),
('def_named1_missile_launcher','def_ammo_longrange_missile_d',6,2),
('def_ammo_longrange_missile_d','def_ammo_longrange_missile_c',7,1),
('def_ammo_longrange_missile_d','def_ammo_longrange_missile_a',7,2),
('def_standard_rocket_launcher','def_standard_damage_mod_missile',1,10),
('def_standard_damage_mod_missile','def_named1_damage_mod_missile',3,10),
('def_named1_damage_mod_missile','def_named2_damage_mod_missile',5,10),
('def_named2_damage_mod_missile','def_named3_damage_mod_missile',7,10),
('def_named2_damage_mod_missile','def_standard_gang_assist_shared_dataprocessing_module',6,11),
('def_standard_gang_assist_shared_dataprocessing_module','def_named1_gang_assist_shared_dataprocessing_module',7,11),
('def_named1_gang_assist_shared_dataprocessing_module','def_named2_gang_assist_shared_dataprocessing_module',8,11),
('def_named2_gang_assist_shared_dataprocessing_module','def_named3_gang_assist_shared_dataprocessing_module',9,11),
('def_named1_small_shield_generator','def_standard_medium_shield_generator',2,12),
('def_standard_medium_shield_generator','def_named1_medium_shield_generator',3,12),
('def_named1_medium_shield_generator','def_named2_medium_shield_generator',4,12),
('def_named2_medium_shield_generator','def_named3_medium_shield_generator',5,12),
(NULL,'def_standard_small_shield_generator',0,13),
('def_standard_small_shield_generator','def_named1_small_shield_generator',1,13),
('def_named1_small_shield_generator','def_named2_small_shield_generator',2,13),
('def_named2_small_shield_generator','def_named3_small_shield_generator',3,13),
('def_named1_medium_shield_generator','def_standard_shield_hardener',4,13),
('def_standard_shield_hardener','def_named1_shield_hardener',5,13),
('def_named1_shield_hardener','def_named2_shield_hardener',6,13),
('def_named2_shield_hardener','def_named3_shield_hardener',7,13),
('def_standard_small_shield_generator','def_standard_thrm_armor_hardener',2,14),
('def_standard_thrm_armor_hardener','def_named1_thrm_armor_hardener',3,14),
('def_named1_thrm_armor_hardener','def_named2_thrm_armor_hardener',4,14),
('def_named2_thrm_armor_hardener','def_named3_thrm_armor_hardener',5,14),
('def_named1_shield_hardener','def_standard_gang_assist_shield_calculation_module',6,14),
('def_standard_gang_assist_shield_calculation_module','def_named1_gang_assist_shield_calculation_module',7,14),
('def_named1_gang_assist_shield_calculation_module','def_named2_gang_assist_shield_calculation_module',8,14),
('def_named2_gang_assist_shield_calculation_module','def_named3_gang_assist_shield_calculation_module',9,14),
('def_named1_thrm_armor_hardener','def_standard_thermal_kers',4,15),
('def_standard_thermal_kers','def_named1_thermal_kers',5,15),
('def_named1_thermal_kers','def_named2_thermal_kers',6,15),
('def_named2_thermal_kers','def_named3_thermal_kers',7,15),
('def_standard_small_energy_neutralizer','def_troiar_bot',3,16),
('def_named1_small_energy_neutralizer','def_standard_energy_warfare_upgrade',4,16),
('def_standard_energy_warfare_upgrade','def_named1_energy_warfare_upgrade',5,16),
('def_named1_energy_warfare_upgrade','def_named2_energy_warfare_upgrade',6,16),
('def_named2_energy_warfare_upgrade','def_named3_energy_warfare_upgrade',7,16),
(NULL,'def_standard_small_energy_neutralizer',2,17),
('def_standard_small_energy_neutralizer','def_named1_small_energy_neutralizer',3,17),
('def_named1_small_energy_neutralizer','def_named2_small_energy_neutralizer',4,17),
('def_named2_small_energy_neutralizer','def_named3_small_energy_neutralizer',5,17),
('def_named1_small_energy_neutralizer','def_standard_medium_energy_neutralizer',4,18),
('def_standard_medium_energy_neutralizer','def_named1_medium_energy_neutralizer',5,18),
('def_named1_medium_energy_neutralizer','def_named2_medium_energy_neutralizer',6,18),
('def_named2_medium_energy_neutralizer','def_named3_medium_energy_neutralizer',7,18),
('def_standard_medium_energy_neutralizer','def_ictus_bot',5,19),
('def_ictus_bot','def_standard_gang_assist_core_management_module',6,19),
('def_standard_gang_assist_core_management_module','def_named1_gang_assist_core_management_module',7,19),
('def_named1_gang_assist_core_management_module','def_named2_gang_assist_core_management_module',8,19),
('def_named2_gang_assist_core_management_module','def_named3_gang_assist_core_management_module',9,19),
--NEW LARGE STUFF
('def_named2_missile_launcher','def_standard_cruisemissile_launcher',6,7),
('def_standard_cruisemissile_launcher','def_named1_cruisemissile_launcher',7,7),
('def_named1_cruisemissile_launcher','def_named2_cruisemissile_launcher',8,7),
('def_named2_cruisemissile_launcher','def_named3_cruisemissile_launcher',9,7),
('def_gropho_bot','def_hydra_bot',9,9),
('def_named1_shield_hardener','def_standard_large_shield_generator',6,12),
('def_standard_large_shield_generator','def_named1_large_shield_generator',7,12),
('def_named1_large_shield_generator','def_named2_large_shield_generator',8,12),
('def_named2_large_shield_generator','def_named3_large_shield_generator',9,12),
('def_standard_cruisemissile_launcher','def_ammo_cruisemissile_d',6,5),
('def_ammo_cruisemissile_d','def_ammo_cruisemissile_b',7,4),
('def_ammo_cruisemissile_d','def_ammo_cruisemissile_c',7,5),
('def_ammo_cruisemissile_d','def_ammo_cruisemissile_a',7,6),
('def_ammo_cruisemissile_d','def_ammo_longrange_cruisemissile_d',7,3),
('def_ammo_longrange_cruisemissile_d','def_ammo_longrange_cruisemissile_b',8,2),
('def_ammo_longrange_cruisemissile_d','def_ammo_longrange_cruisemissile_c',8,3),
('def_ammo_longrange_cruisemissile_d','def_ammo_longrange_cruisemissile_a',8,4);


--kernel costs
DROP TABLE IF EXISTS #TECHCOSTPELISTAL;
CREATE TABLE #TECHCOSTPELISTAL
(
	defName VARCHAR(100),
	kernelType INT,
	kernelAmount INT
);
INSERT INTO #TECHCOSTPELISTAL (defName, kernelType, kernelAmount) VALUES
('def_standard_cruisemissile_launcher',2,34300),
('def_standard_cruisemissile_launcher',6,17150),
('def_named1_cruisemissile_launcher',2,51200),
('def_named1_cruisemissile_launcher',6,25600),
('def_named2_cruisemissile_launcher',2,72900),
('def_named2_cruisemissile_launcher',6,36450),
('def_named3_cruisemissile_launcher',2,100000),
('def_named3_cruisemissile_launcher',6,50000),
('def_ammo_cruisemissile_d',2,34300),
('def_ammo_cruisemissile_d',6,17150),
('def_ammo_cruisemissile_b',2,51200),
('def_ammo_cruisemissile_b',6,25600),
('def_ammo_cruisemissile_c',2,51200),
('def_ammo_cruisemissile_c',6,25600),
('def_ammo_cruisemissile_a',2,51200),
('def_ammo_cruisemissile_a',6,25600),
('def_ammo_longrange_cruisemissile_d',2,51200),
('def_ammo_longrange_cruisemissile_d',6,25600),
('def_ammo_longrange_cruisemissile_b',2,72900),
('def_ammo_longrange_cruisemissile_b',6,36450),
('def_ammo_longrange_cruisemissile_c',2,72900),
('def_ammo_longrange_cruisemissile_c',6,36450),
('def_ammo_longrange_cruisemissile_a',2,72900),
('def_ammo_longrange_cruisemissile_a',6,36450),
('def_standard_large_shield_generator',2,34300),
('def_standard_large_shield_generator',6,17150),
('def_named1_large_shield_generator',2,51200),
('def_named1_large_shield_generator',6,25600),
('def_named2_large_shield_generator',2,72900),
('def_named2_large_shield_generator',6,36450),
('def_named3_large_shield_generator',2,100000),
('def_named3_large_shield_generator',6,50000),
('def_hydra_bot',2,500000),
('def_hydra_bot',6,250000);


--Show and delete existing kernel costs
SELECT * FROM techtreenodeprices where definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #TECHCOSTPELISTAL));
DELETE FROM techtreenodeprices where definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #TECHCOSTPELISTAL));

--Insert the fresh prices
INSERT INTO techtreenodeprices (definition, pointtype, amount)
SELECT (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defName), kernelType, kernelAmount from #TECHCOSTPELISTAL;

--Update/insert techtree entries
MERGE [dbo].[techtree] t USING #TECHSLOTSPELISTAL s
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
	4, s.x, s.y);

DROP TABLE IF EXISTS #TECHSLOTSPELISTAL;
DROP TABLE IF EXISTS #TECHCOSTPELISTAL;
GO

