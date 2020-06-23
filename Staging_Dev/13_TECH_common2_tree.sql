USE [perpetuumsa]
GO


--Show what the tree for this tech group has, ordered in top-left to bottom-right
--select 
--	(select top 1 definitionname from entitydefaults where definition in (parentdefinition)),
--	(select top 1 definitionname from entitydefaults where definition in (childdefinition)),
--	x, y
--from techtree where groupID=9 order by y, x;


DROP TABLE IF EXISTS #TECHSLOTSCOMMON;
CREATE TABLE #TECHSLOTSCOMMON
(
	preDefName VARCHAR(100),
	defName VARCHAR(100),
	x INT,
	y INT
);
INSERT INTO #TECHSLOTSCOMMON (preDefName, defName, x, y) VALUES
('def_named1_small_energy_transfer','def_standard_medium_energy_transfer',4,0),
('def_standard_medium_energy_transfer','def_named1_medium_energy_transfer',5,0),
('def_named1_medium_energy_transfer','def_named2_medium_energy_transfer',6,0),
('def_named2_medium_energy_transfer','def_named3_medium_energy_transfer',7,0),
('def_named1_powergrid_upgrades','def_standard_small_energy_transfer',2,1),
('def_standard_small_energy_transfer','def_named1_small_energy_transfer',3,1),
('def_named1_small_energy_transfer','def_named2_small_energy_transfer',4,1),
('def_named2_small_energy_transfer','def_named3_small_energy_transfer',5,1),
('def_named1_small_energy_vampire','def_standard_medium_energy_vampire',6,1),
('def_standard_medium_energy_vampire','def_named1_medium_energy_vampire',7,1),
('def_named1_medium_energy_vampire','def_named2_medium_energy_vampire',8,1),
('def_named2_medium_energy_vampire','def_named3_medium_energy_vampire',9,1),
(NULL,'def_standard_powergrid_upgrades',0,2),
('def_standard_powergrid_upgrades','def_named1_powergrid_upgrades',1,2),
('def_named1_powergrid_upgrades','def_named2_powergrid_upgrades',2,2),
('def_named2_powergrid_upgrades','def_named3_powergrid_upgrades',3,2),
('def_named1_small_energy_transfer','def_standard_small_energy_vampire',4,2),
('def_standard_small_energy_vampire','def_named1_small_energy_vampire',5,2),
('def_named1_small_energy_vampire','def_named2_small_energy_vampire',6,2),
('def_named2_small_energy_vampire','def_named3_small_energy_vampire',7,2),
('def_named1_powergrid_upgrades','def_standard_reactor_sealing',2,3),
('def_standard_reactor_sealing','def_named1_reactor_sealing',3,3),
('def_named1_reactor_sealing','def_named2_reactor_sealing',4,3),
('def_named2_reactor_sealing','def_named3_reactor_sealing',5,3),
('def_named1_core_recharger','def_standard_small_core_battery',3,5),
('def_standard_small_core_battery','def_named1_small_core_battery',4,5),
('def_named1_small_core_battery','def_named2_small_core_battery',5,5),
('def_named2_small_core_battery','def_named3_small_core_battery',6,5),
('def_standard_powergrid_upgrades','def_standard_core_recharger',1,6),
('def_standard_core_recharger','def_named1_core_recharger',2,6),
('def_named1_core_recharger','def_named2_core_recharger',3,6),
('def_named2_core_recharger','def_named3_core_recharger',4,6),
('def_named1_small_core_battery','def_standard_medium_core_battery',5,4),
('def_standard_medium_core_battery','def_named1_medium_core_battery',6,4),
('def_named1_medium_core_battery','def_named2_medium_core_battery',7,4),
('def_named2_medium_core_battery','def_named3_medium_core_battery',8,4),
('def_named1_core_recharger','def_standard_small_core_booster',3,7),
('def_standard_small_core_booster','def_named1_small_core_booster',4,7),
('def_named1_small_core_booster','def_named2_small_core_booster',5,7),
('def_named2_small_core_booster','def_named3_small_core_booster',6,7),
('def_standard_small_core_booster','def_corebooster_ammo',4,8),
('def_named1_small_core_booster','def_standard_medium_core_booster',5,8),
('def_standard_medium_core_booster','def_named1_medium_core_booster',6,8),
('def_named1_medium_core_booster','def_named2_medium_core_booster',7,8),
('def_named2_medium_core_booster','def_named3_medium_core_booster',8,8),
('def_named1_chassis_scanner','def_standard_cargo_scanner',3,10),
('def_standard_cargo_scanner','def_named1_cargo_scanner',4,10),
('def_named1_cargo_scanner','def_named2_cargo_scanner',5,10),
('def_named2_cargo_scanner','def_named3_cargo_scanner',6,10),
('def_standard_cpu_upgrade','def_standard_chassis_scanner',1,9),
('def_standard_chassis_scanner','def_named1_chassis_scanner',2,9),
('def_named1_chassis_scanner','def_named2_chassis_scanner',3,9),
('def_named2_chassis_scanner','def_named3_chassis_scanner',4,9),
('def_standard_cpu_upgrade','def_standard_eccm',1,11),
('def_standard_eccm','def_named1_eccm',2,11),
('def_named1_eccm','def_named2_eccm',3,11),
('def_named2_eccm','def_named3_eccm',4,11),
('def_standard_tracking_upgrade','def_standard_target_painter',5,11),
('def_standard_target_painter','def_named1_target_painter',6,11),
('def_named1_target_painter','def_named2_target_painter',7,11),
('def_named2_target_painter','def_named3_target_painter',8,11),
(NULL,'def_standard_cpu_upgrade',0,12),
('def_standard_cpu_upgrade','def_named1_cpu_upgrade',1,12),
('def_named1_cpu_upgrade','def_named2_cpu_upgrade',2,12),
('def_named2_cpu_upgrade','def_named3_cpu_upgrade',3,12),
('def_standard_detection_modul','def_standard_tracking_upgrade',4,12),
('def_standard_tracking_upgrade','def_named1_tracking_upgrade',5,12),
('def_named1_tracking_upgrade','def_named2_tracking_upgrade',6,12),
('def_named2_tracking_upgrade','def_named3_tracking_upgrade',7,12),
('def_named1_sensor_booster','def_standard_detection_modul',3,13),
('def_standard_detection_modul','def_named1_detection_modul',4,13),
('def_named1_detection_modul','def_named2_detection_modul',5,13),
('def_named2_detection_modul','def_named3_detection_modul',6,13),
('def_standard_cpu_upgrade','def_standard_sensor_booster',1,14),
('def_standard_sensor_booster','def_named1_sensor_booster',2,14),
('def_named1_sensor_booster','def_named2_sensor_booster',3,14),
('def_named2_sensor_booster','def_named3_sensor_booster',4,14),
('def_named1_detection_modul','def_standard_stealth_modul',5,14),
('def_standard_stealth_modul','def_named1_stealth_modul',6,14),
('def_named1_stealth_modul','def_named2_stealth_modul',7,14),
('def_named2_stealth_modul','def_named3_stealth_modul',8,14),
('def_named2_sensor_booster','def_standard_webber',4,15),
('def_standard_webber','def_named1_webber',5,15),
('def_named1_webber','def_named2_webber',6,15),
('def_named2_webber','def_named3_webber',7,15),
('def_standard_sensor_booster','def_standard_remote_sensor_booster',2,16),
('def_standard_remote_sensor_booster','def_named1_remote_sensor_booster',3,16),
('def_named1_remote_sensor_booster','def_named2_remote_sensor_booster',4,16),
('def_named2_remote_sensor_booster','def_named3_remote_sensor_booster',5,16),
('def_named1_webber','def_standard_longrange_webber',6,16),
('def_standard_longrange_webber','def_named1_longrange_webber',7,16),
('def_named1_longrange_webber','def_named2_longrange_webber',8,16),
('def_named2_longrange_webber','def_named3_longrange_webber',9,16),
('def_named1_remote_sensor_booster','def_standard_gang_assist_ewar_range_module',4,17),
('def_standard_gang_assist_ewar_range_module','def_named1_gang_assist_ewar_range_module',5,17),
('def_named1_gang_assist_ewar_range_module','def_named2_gang_assist_ewar_range_module',6,17),
('def_named2_gang_assist_ewar_range_module','def_named3_gang_assist_ewar_range_module',7,17),
('def_standard_remote_sensor_booster','def_standard_blob_emission_modulator',3,18),
('def_standard_blob_emission_modulator','def_named1_blob_emission_modulator',4,18),
('def_named1_blob_emission_modulator','def_named2_blob_emission_modulator',5,18),
('def_named2_blob_emission_modulator','def_named3_blob_emission_modulator',6,18),
--NEW LARGE STUFF
('def_standard_medium_core_battery','def_standard_large_core_battery',6,3),
('def_standard_large_core_battery','def_named1_large_core_battery',7,3),
('def_named1_large_core_battery','def_named2_large_core_battery',8,3),
('def_named2_large_core_battery','def_named3_large_core_battery',9,3),
('def_standard_medium_core_booster','def_standard_large_core_booster',6,9),
('def_standard_large_core_booster','def_named1_large_core_booster',7,9),
('def_named1_large_core_booster','def_named2_large_core_booster',8,9),
('def_named2_large_core_booster','def_named3_large_core_booster',9,9);


--kernel costs
DROP TABLE IF EXISTS #TECHCOSTCOMMON;
CREATE TABLE #TECHCOSTCOMMON
(
	defName VARCHAR(100),
	kernelType INT,
	kernelAmount INT
);
INSERT INTO #TECHCOSTCOMMON (defName, kernelType, kernelAmount) VALUES
('def_standard_large_core_battery',5,34300),
('def_standard_large_core_battery',6,17150),
('def_named1_large_core_battery',5,51200),
('def_named1_large_core_battery',6,25600),
('def_named2_large_core_battery',5,72900),
('def_named2_large_core_battery',6,36450),
('def_named3_large_core_battery',5,100000),
('def_named3_large_core_battery',6,50000),
('def_standard_large_core_booster',5,34300),
('def_standard_large_core_booster',6,17150),
('def_named1_large_core_booster',5,51200),
('def_named1_large_core_booster',6,25600),
('def_named2_large_core_booster',5,72900),
('def_named2_large_core_booster',6,36450),
('def_named3_large_core_booster',5,100000),
('def_named3_large_core_booster',6,50000);


--Show and delete existing kernel costs
SELECT * FROM techtreenodeprices where definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #TECHCOSTCOMMON));
DELETE FROM techtreenodeprices where definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #TECHCOSTCOMMON));

--Insert the fresh prices
INSERT INTO techtreenodeprices (definition, pointtype, amount)
SELECT (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defName), kernelType, kernelAmount from #TECHCOSTCOMMON;

--Update/insert techtree entries
MERGE [dbo].[techtree] t USING #TECHSLOTSCOMMON s
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
	9, s.x, s.y);

DROP TABLE IF EXISTS #TECHSLOTSCOMMON;
DROP TABLE IF EXISTS #TECHCOSTPELISTAL;
GO

