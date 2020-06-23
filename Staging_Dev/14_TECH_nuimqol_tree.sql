USE [perpetuumsa]
GO


--Show what the tree for this tech group has, ordered in top-left to bottom-right
--select 
--	(select top 1 definitionname from entitydefaults where definition in (parentdefinition)),
--	(select top 1 definitionname from entitydefaults where definition in (childdefinition)),
--	x, y
--from techtree where groupID=3 order by y, x;


DROP TABLE IF EXISTS #TECHSLOTSNUIMQOL;
CREATE TABLE #TECHSLOTSNUIMQOL
(
	preDefName VARCHAR(100),
	defName VARCHAR(100),
	x INT,
	y INT
);
INSERT INTO #TECHSLOTSNUIMQOL (preDefName, defName, x, y) VALUES
('def_ammo_small_railgun_d','def_ammo_small_railgun_b',2,0),
('def_ammo_medium_railgun_d','def_ammo_medium_railgun_b',5,0),
('def_standard_small_railgun','def_ammo_small_railgun_d',1,1),
('def_ammo_small_railgun_d','def_ammo_small_railgun_c',2,1),
('def_standard_medium_railgun','def_ammo_medium_railgun_d',4,1),
('def_ammo_medium_railgun_d','def_ammo_medium_railgun_c',5,1),
('def_ammo_small_railgun_d','def_ammo_small_railgun_a',2,2),
('def_ammo_medium_railgun_d','def_ammo_medium_railgun_a',5,2),
(NULL,'def_standard_small_railgun',0,5),
('def_standard_small_railgun','def_yagel_bot',1,5),
('def_named1_small_railgun','def_arbalest_bot',2,5),
('def_named2_small_railgun','def_standard_medium_railgun',3,5),
('def_standard_medium_railgun','def_named1_medium_railgun',4,5),
('def_named1_medium_railgun','def_named2_medium_railgun',5,5),
('def_named2_medium_railgun','def_named3_medium_railgun',6,5),
('def_named1_longrange_medium_railgun','def_mesmer_bot',7,5),
('def_standard_small_railgun','def_named1_small_railgun',1,6),
('def_named1_small_railgun','def_named2_small_railgun',2,6),
('def_named2_small_railgun','def_named3_small_railgun',3,6),
('def_standard_medium_railgun','def_kain_bot',4,6),
('def_named1_medium_railgun','def_longrange_standard_medium_railgun',5,4),
('def_longrange_standard_medium_railgun','def_named1_longrange_medium_railgun',6,4),
('def_named1_longrange_medium_railgun','def_named2_longrange_medium_railgun',7,4),
('def_named2_longrange_medium_railgun','def_named3_longrange_medium_railgun',8,4),
('def_named2_damage_mod_railgun','def_standard_gang_assist_siege_module',6,8),
('def_standard_gang_assist_siege_module','def_named1_gang_assist_siege_module',7,8),
('def_named1_gang_assist_siege_module','def_named2_gang_assist_siege_module',8,8),
('def_named2_gang_assist_siege_module','def_named3_gang_assist_siege_module',9,8),
('def_standard_small_railgun','def_standard_damage_mod_railgun',1,7),
('def_standard_damage_mod_railgun','def_named1_damage_mod_railgun',3,7),
('def_named1_damage_mod_railgun','def_named2_damage_mod_railgun',5,7),
('def_named2_damage_mod_railgun','def_named3_damage_mod_railgun',7,7),
('def_named1_small_armor_repairer','def_standard_medium_armor_repairer',2,9),
('def_standard_medium_armor_repairer','def_named1_medium_armor_repairer',3,9),
('def_named1_medium_armor_repairer','def_named2_medium_armor_repairer',4,9),
('def_named2_medium_armor_repairer','def_named3_medium_armor_repairer',5,9),
('def_named1_armor_repairer_upgrade','def_standard_gang_assist_maintance_module',6,11),
('def_standard_gang_assist_maintance_module','def_named1_gang_assist_maintance_module',7,11),
('def_named1_gang_assist_maintance_module','def_named2_gang_assist_maintance_module',8,11),
('def_named2_gang_assist_maintance_module','def_named3_gang_assist_maintance_module',9,11),
(NULL,'def_standard_small_armor_repairer',0,10),
('def_standard_small_armor_repairer','def_named1_small_armor_repairer',1,10),
('def_named1_small_armor_repairer','def_named2_small_armor_repairer',2,10),
('def_named2_small_armor_repairer','def_named3_small_armor_repairer',3,10),
('def_named1_medium_armor_repairer','def_standard_armor_repairer_upgrade',4,10),
('def_standard_armor_repairer_upgrade','def_named1_armor_repairer_upgrade',5,10),
('def_named1_armor_repairer_upgrade','def_named2_armor_repairer_upgrade',6,10),
('def_named2_armor_repairer_upgrade','def_named3_armor_repairer_upgrade',7,10),
('def_standard_small_armor_repairer','def_standard_exp_armor_hardener',2,11),
('def_standard_exp_armor_hardener','def_named1_exp_armor_hardener',3,11),
('def_named1_exp_armor_hardener','def_named2_exp_armor_hardener',4,11),
('def_named2_exp_armor_hardener','def_named3_exp_armor_hardener',5,11),
('def_named1_exp_armor_hardener','def_standard_explosive_kers',4,12),
('def_standard_explosive_kers','def_named1_explosive_kers',5,12),
('def_named1_explosive_kers','def_named2_explosive_kers',6,12),
('def_named2_explosive_kers','def_named3_explosive_kers',7,12),
('def_standard_sensor_jammer','def_cameleon_bot',3,13),
('def_named1_sensor_jammer','def_standard_ecm_booster',4,13),
('def_standard_ecm_booster','def_named1_ecm_booster',5,13),
('def_named1_ecm_booster','def_named2_ecm_booster',6,13),
('def_named2_ecm_booster','def_named3_ecm_booster',7,13),
(NULL,'def_standard_sensor_jammer',2,14),
('def_standard_sensor_jammer','def_named1_sensor_jammer',3,14),
('def_named1_sensor_jammer','def_named2_sensor_jammer',4,14),
('def_named2_sensor_jammer','def_named3_sensor_jammer',5,14),
('def_named2_sensor_jammer','def_vagabond_bot',5,15),
('def_vagabond_bot','def_standard_gang_assist_speed_module',6,15),
('def_standard_gang_assist_speed_module','def_named1_gang_assist_speed_module',7,15),
('def_named1_gang_assist_speed_module','def_named2_gang_assist_speed_module',8,15),
('def_named2_gang_assist_speed_module','def_named3_gang_assist_speed_module',9,15),
--NEW LARGE STUFF
('def_longrange_standard_medium_railgun','def_standard_large_railgun',6,3),
('def_standard_large_railgun','def_named1_large_railgun',7,3),
('def_named1_large_railgun','def_named2_large_railgun',8,3),
('def_named2_large_railgun','def_named3_large_railgun',9,3),
('def_named2_medium_railgun','def_longrange_standard_large_railgun',6,6),
('def_longrange_standard_large_railgun','def_named1_longrange_large_railgun',7,6),
('def_named1_longrange_large_railgun','def_named2_longrange_large_railgun',8,6),
('def_named2_longrange_large_railgun','def_named3_longrange_large_railgun',9,6),
('def_standard_large_railgun','def_ammo_large_railgun_d',6,1),
('def_ammo_large_railgun_d','def_ammo_large_railgun_b',7,0),
('def_ammo_large_railgun_d','def_ammo_large_railgun_c',7,1),
('def_ammo_large_railgun_d','def_ammo_large_railgun_a',7,2),
('def_mesmer_bot','def_felos_bot',9,5),
('def_named1_armor_repairer_upgrade','def_standard_large_armor_repairer',6,9),
('def_standard_large_armor_repairer','def_named1_large_armor_repairer',7,9),
('def_named1_large_armor_repairer','def_named2_large_armor_repairer',8,9),
('def_named2_large_armor_repairer','def_named3_large_armor_repairer',9,9);

--kernel costs
DROP TABLE IF EXISTS #TECHCOSTNUIMQOL;
CREATE TABLE #TECHCOSTNUIMQOL
(
	defName VARCHAR(100),
	kernelType INT,
	kernelAmount INT
);
INSERT INTO #TECHCOSTNUIMQOL (defName, kernelType, kernelAmount) VALUES
('def_standard_large_railgun',3,34300),
('def_standard_large_railgun',6,17150),
('def_named1_large_railgun',3,51200),
('def_named1_large_railgun',6,25600),
('def_named2_large_railgun',3,72900),
('def_named2_large_railgun',6,36450),
('def_named3_large_railgun',3,100000),
('def_named3_large_railgun',6,50000),
('def_longrange_standard_large_railgun',3,34300),
('def_longrange_standard_large_railgun',6,17150),
('def_named1_longrange_large_railgun',3,51200),
('def_named1_longrange_large_railgun',6,25600),
('def_named2_longrange_large_railgun',3,72900),
('def_named2_longrange_large_railgun',6,36450),
('def_named3_longrange_large_railgun',3,100000),
('def_named3_longrange_large_railgun',6,50000),
('def_ammo_large_railgun_d',3,34300),
('def_ammo_large_railgun_d',6,17150),
('def_ammo_large_railgun_b',3,51200),
('def_ammo_large_railgun_b',6,25600),
('def_ammo_large_railgun_c',3,51200),
('def_ammo_large_railgun_c',6,25600),
('def_ammo_large_railgun_a',3,51200),
('def_ammo_large_railgun_a',6,25600),
('def_standard_large_armor_repairer',3,34300),
('def_standard_large_armor_repairer',6,17150),
('def_named1_large_armor_repairer',3,51200),
('def_named1_large_armor_repairer',6,25600),
('def_named2_large_armor_repairer',3,72900),
('def_named2_large_armor_repairer',6,36450),
('def_named3_large_armor_repairer',3,100000),
('def_named3_large_armor_repairer',6,50000),
('def_felos_bot',3,500000),
('def_felos_bot',6,250000);


--Show and delete existing kernel costs
SELECT * FROM techtreenodeprices where definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #TECHCOSTNUIMQOL));
DELETE FROM techtreenodeprices where definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #TECHCOSTNUIMQOL));

--Insert the fresh prices
INSERT INTO techtreenodeprices (definition, pointtype, amount)
SELECT (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defName), kernelType, kernelAmount from #TECHCOSTNUIMQOL;

--Update/insert techtree entries
MERGE [dbo].[techtree] t USING #TECHSLOTSNUIMQOL s
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
	3, s.x, s.y);



DROP TABLE IF EXISTS #TECHSLOTSNUIMQOL;
DROP TABLE IF EXISTS #TECHCOSTNUIMQOL;
GO


