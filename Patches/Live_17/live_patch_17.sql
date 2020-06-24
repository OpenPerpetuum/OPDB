USE [perpetuumsa]
GO
---------------------------------------------------------------
--Live 17: Destroyers + Flux ore + npc reinforcements
--Last modified:2020/06/24
--
--01_BALANCE_coreactorCpu_onePerRobot__2020_05_26.sql
--02_BALANCE_Hmech_srf_area__2020_01_28.sql
--03_LARGE_AMMO.sql
--04_LARGE_MODULES.sql
--05_LARGE_WEAPONS.sql
--06_Minerals_ammo_addfluxore__2020_05_01.sql
--07_Ore_npcs__defintions__2020_05_20.sql
--08_NPCReinforcements_createTables_npcs__2020_05_08.sql
--09_BOT_nuimqol_large.sql
--10_BOT_pelistal_large.sql
--11_BOT_thelodica_large.sql
--12_BOT_PRODUCTION_all_large.sql
--13_TECH_common2_tree.sql
--14_TECH_nuimqol_tree.sql
--15_TECH_pelistal_tree.sql
--16_TECH_thelodica_tree.sql
--17_CREATE_TABLE_productioncost__2020_04_25.sql
--18_def_intakt_chassis_mk2__2020_05_16_00_32_50.sql
--19_def_npc_beta1_pitboss_loot__2020_05_11_21_35_23.sql
--20_Defconfig_izteleport_range__2020_05_17.sql
--
--
---------------------------------------------------------------


PRINT N'01_BALANCE_coreactorCpu_onePerRobot__2020_05_26';

USE [perpetuumsa]
GO

----------------------------------------------------------------
--Coreactor and Coprocessor make 1-per robot only
--Note: only the categoryflag isunique field matters, attributes on defs just for consistency
--Date: 2020/05/26
----------------------------------------------------------------


PRINT N'UPDATE entitydefaults and categoryFlags to make co/react/cpus 1-per-robot fit';
DECLARE @oneModuleFlag BIGINT;
SET @oneModuleFlag = POWER(2, (SELECT TOP 1 offset FROM attributeFlags WHERE name='onePerRobot'));

--This doesn't actually do anything, Deprecated? But change for consistency..
UPDATE entitydefaults SET
	attributeflags = attributeflags | @oneModuleFlag
WHERE categoryflags=(SELECT TOP 1 value FROM categoryFlags WHERE name='cf_cpu_upgrades');

UPDATE entitydefaults SET
	attributeflags = attributeflags | @oneModuleFlag
WHERE categoryflags=(SELECT TOP 1 value FROM categoryFlags WHERE name='cf_powergrid_upgrades');

--This actually matters
UPDATE categoryFlags SET
	isunique = 1
WHERE value = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_powergrid_upgrades') OR
value = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_cpu_upgrades');


GO

PRINT N'02_BALANCE_Hmech_srf_area__2020_01_28';

USE [perpetuumsa]
GO

---------------------------------------------------------
--Misc Balancing for Patch 17: Hmech srf area, T4 shield to match, Green HM/Mech reactor
--15->25 Combats
--14->23 Syndicate Combats
--14->23 Industrial
--12->15 Glider
--Last Modified: 2020/05/29
---------------------------------------------------------


DROP TABLE IF EXISTS #MODIFIERS;
CREATE TABLE #MODIFIERS 
(
	defName varchar(100),
	fieldName varchar(100),
	fieldValue float,
);

INSERT INTO #MODIFIERS (defName, fieldName, fieldValue) VALUES
--Tyrannos/Gropho Reactor
('def_tyrannos_chassis', 'powergrid_max', 1000), --from 900
('def_tyrannos_chassis_pr', 'powergrid_max', 1000), --from 900
('def_tyrannos_chassis_mk2', 'powergrid_max', 1100), --from 1000
('def_gropho_chassis', 'powergrid_max', 1125), --from 1025
('def_gropho_chassis_pr', 'powergrid_max', 1125), --from 1025
('def_gropho_chassis_mk2', 'powergrid_max', 1237.5), --from 1127.5

--Shields
('def_named3_medium_shield_generator', 'shield_radius', 25),
('def_named3_medium_shield_generator_pr', 'shield_radius', 25),
--Hmechs
('def_gropho_chassis', 'signature_radius', 25),
('def_gropho_chassis_mk2', 'signature_radius', 25),
('def_gropho_chassis_pr', 'signature_radius', 25),
('def_gropho_chassis_reward1', 'signature_radius', 25),

('def_legatus_chassis', 'signature_radius', 23),

('def_lithus_chassis', 'signature_radius', 23),
('def_lithus_chassis_mk2', 'signature_radius', 23),
('def_lithus_chassis_pr', 'signature_radius', 23),

('def_mesmer_chassis', 'signature_radius', 25),
('def_mesmer_chassis_mk2', 'signature_radius', 25),
('def_mesmer_chassis_pr', 'signature_radius', 25),
('def_mesmer_chassis_reward1', 'signature_radius', 25),

('def_metis_chassis', 'signature_radius', 23),

('def_riveler_chassis', 'signature_radius', 23),
('def_riveler_chassis_mk2', 'signature_radius', 23),
('def_riveler_chassis_pr', 'signature_radius', 23),

('def_scarab_chassis', 'signature_radius', 15),
('def_scarab_chassis_mk2', 'signature_radius', 15),
('def_scarab_chassis_pr', 'signature_radius', 15),

('def_seth_chassis', 'signature_radius', 23),
('def_seth_chassis_mk2', 'signature_radius', 23),
('def_seth_chassis_pr', 'signature_radius', 23),
('def_seth_chassis_reward1', 'signature_radius', 23),

('def_symbiont_chassis', 'signature_radius', 23),
('def_symbiont_chassis_mk2', 'signature_radius', 23),
('def_symbiont_chassis_pr', 'signature_radius', 23);

PRINT N'ABOUT TO MERGE SRF AREA UPDATES TO AGGREGATE VALUES FOR ALL HEAVY MECH STATS (and medium t4 shield)';

MERGE INTO
  aggregatevalues
USING
  #MODIFIERS
ON
  field = (SELECT TOP 1 id FROM aggregatefields WHERE fieldName=name)
  AND
  definition = (SELECT TOP 1 definition FROM entitydefaults WHERE defName=definitionname)
WHEN MATCHED THEN
  UPDATE SET
    value = fieldValue
WHEN NOT MATCHED THEN
  INSERT
    (definition, field, value)
  VALUES
    ((SELECT TOP 1 definition FROM entitydefaults WHERE defName=definitionname), (SELECT TOP 1 id FROM aggregatefields WHERE fieldName=name), fieldValue);


PRINT N'MERGED!';
DROP TABLE IF EXISTS #MODIFIERS;
GO

PRINT N'03_LARGE_AMMO';

USE [perpetuumsa]
GO

--New property modifier and skill for falloff
DECLARE @missileFalloffMod int;

IF NOT EXISTS (SELECT TOP 1 id FROM aggregatefields WHERE name='missile_falloff_modifier')
BEGIN
	PRINT N'INSERTING missile_falloff_modifier';
	INSERT INTO aggregatefields (name, formula, measurementunit, measurementmultiplier, measurementoffset, category, digits, moreisbetter, usedinconfig, note) VALUES
	('missile_falloff_modifier', 0, 'missile_falloff_modifier_unit', 100, -100, 6, 0, 1, 1, 'missile falloff mod');
END

IF NOT EXISTS (SELECT TOP 1 id FROM aggregatefields WHERE name='module_missile_falloff_modifier')
BEGIN
	PRINT N'INSERTING module_missile_falloff_modifier';
	INSERT INTO aggregatefields (name, formula, measurementunit, measurementmultiplier, measurementoffset, category, digits, moreisbetter, usedinconfig, note) VALUES
	('module_missile_falloff_modifier', 0, 'module_missile_falloff_modifier_unit', 100, -100, 6, 2, 1, 1, 'missile falloff mod on module');
END

SET @missileFalloffMod = (SELECT TOP 1 id FROM aggregatefields WHERE name='missile_falloff_modifier');
IF NOT EXISTS (SELECT TOP 1 extensionid FROM extensions WHERE extensionname='ext_missile_falloff')
BEGIN
	PRINT N'INSERTING ext_missile_falloff';
	DECLARE @lastExtId int;
	SET @lastExtId = (SELECT TOP 1 extensionid FROM extensions ORDER BY extensionid DESC);
	INSERT INTO extensions (extensionid, extensionname, category, rank, targetlearningattribute, learningattributeprimary, learningattributesecondary, bonus, note, price, active, description, targetpropertyID, effectenhancer, hidden, freezelimit)
	VALUES
	(@lastExtId+1, 'ext_missile_falloff', 4, 4, NULL, 'attributeA', 'attributeB', 0.03, 'new falloff for missiles', 80000, 1, 'ext_missile_falloff_desc', @missileFalloffMod, 0, 0, 7);
END

IF NOT EXISTS (SELECT TOP 1 id FROM modulepropertymodifiers WHERE categoryflags=(SELECT TOP 1 value FROM categoryFlags WHERE name='cf_missiles')
	AND basefield=(SELECT TOP 1 id FROM aggregatefields WHERE name='module_missile_falloff_modifier')
	AND modifierfield=(SELECT TOP 1 id FROM aggregatefields WHERE name='missile_falloff_modifier'))
BEGIN
	PRINT N'INSERTING modulepropertymodifiers FOR cf_missiles module_missile_falloff_modifier missile_falloff_modifier';
	INSERT INTO modulepropertymodifiers (categoryflags, basefield, modifierfield) VALUES
	((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_missiles'),
	(SELECT TOP 1 id FROM aggregatefields WHERE name='module_missile_falloff_modifier'),
	(SELECT TOP 1 id FROM aggregatefields WHERE name='missile_falloff_modifier'));
END
GO

PRINT N'INSERTING PROTOTYPE AMMOS';
DROP TABLE IF EXISTS #AMMO_PROTO_DEFS;
CREATE TABLE #AMMO_PROTO_DEFS 
(
	defName varchar(100),
	quantity int,
	attrFlags bigint,
	catFlags bigint,
	genxyOptStr varchar(max),
	note varchar(2048),
	cargoVolume float,
	massOfModule float,
	description nvarchar(100),
	techType int,
	techLevel int
);
INSERT INTO #AMMO_PROTO_DEFS (defName, quantity, attrFlags, catFlags, genxyOptStr, note, cargoVolume, massOfModule, description, techType, techLevel) VALUES
('def_ammo_large_railgun_a_pr',1,133120,196874,'#damageChemical=f0.00  #damageKinetic=f32.00  #damageExplosive=f0.00  #damageThermal=f16.00  #optimalRangeModifier=f1.00  #explosion_radius=f0  #bullettime=f53.0','',2,0.4,'def_ammo_railgun_a_desc',NULL,NULL),
('def_ammo_large_railgun_b_pr',1,133120,196874,'#damageChemical=f0.00  #damageKinetic=f56.00  #damageExplosive=f0.00  #damageThermal=f0.00  #optimalRangeModifier=f0.75  #explosion_radius=f0  #bullettime=f53.0','',2,0.4,'def_ammo_railgun_b_desc',NULL,NULL),
('def_ammo_large_railgun_c_pr',1,133120,196874,'#damageChemical=f0.00  #damageKinetic=f32.00  #damageExplosive=f24.00  #damageThermal=f16.00  #optimalRangeModifier=f0.50  #explosion_radius=f0  #bullettime=f53.0','',2,0.4,'def_ammo_railgun_c_desc',NULL,NULL),
('def_ammo_large_railgun_d_pr',1,133120,196874,'#damageChemical=f32.00  #damageKinetic=f24.00  #damageExplosive=f0.00  #damageThermal=f0.00  #optimalRangeModifier=f0.75  #explosion_radius=f0  #bullettime=f53.0','',2,0.4,'def_ammo_railgun_d_desc',NULL,NULL),
('def_ammo_large_lasercrystal_a_pr',1,133120,197130,'#damageChemical=f0.00  #damageKinetic=f0.00  #damageExplosive=f0.00  #damageThermal=f48.00  #optimalRangeModifier=f1.00  #explosion_radius=f0  #bullettime=f3000.0','',2,0.4,'def_ammo_lasercrystal_a_desc',NULL,NULL),
('def_ammo_large_lasercrystal_b_pr',1,133120,197130,'#damageChemical=f0.00  #damageKinetic=f0.00  #damageExplosive=f8.00  #damageThermal=f48.00  #optimalRangeModifier=f0.75  #explosion_radius=f0  #bullettime=f3000.0','',2,0.4,'def_ammo_lasercrystal_b_desc',NULL,NULL),
('def_ammo_large_lasercrystal_c_pr',1,133120,197130,'#damageChemical=f0.00  #damageKinetic=f16.00  #damageExplosive=f16.00  #damageThermal=f40.00  #optimalRangeModifier=f0.50  #explosion_radius=f0  #bullettime=f3000.0','',2,0.4,'def_ammo_lasercrystal_c_desc',NULL,NULL),
('def_ammo_large_lasercrystal_d_pr',1,133120,197130,'#damageChemical=f28.00  #damageKinetic=f0.00  #damageExplosive=f0.00  #damageThermal=f28.00  #optimalRangeModifier=f0.75  #explosion_radius=f0  #bullettime=f3000.0','',2,0.4,'def_ammo_lasercrystal_d_desc',NULL,NULL),
('def_ammo_cruisemissile_a_pr',1,133120,197642,'#damageChemical=f0.00  #damageKinetic=f90.00  #damageExplosive=f90.00  #damageThermal=f0.00  #range=f40  #explosion_radius=f16  #bullettime=f7.0','',2,0.75,'def_ammo_cruisemissile_a_desc',NULL,NULL),
('def_ammo_cruisemissile_b_pr',1,133120,197642,'#damageChemical=f0.00  #damageKinetic=f0.00  #damageExplosive=f180.00  #damageThermal=f0.00  #range=f40  #explosion_radius=f12  #bullettime=f7.0','',2,0.75,'def_ammo_cruisemissile_b_desc',NULL,NULL),
('def_ammo_cruisemissile_c_pr',1,133120,197642,'#damageChemical=f0.00  #damageKinetic=f0.00  #damageExplosive=f90.00  #damageThermal=f90.00  #range=f40  #explosion_radius=f16  #bullettime=f7.0','',2,0.75,'def_ammo_cruisemissile_c_desc',NULL,NULL),
('def_ammo_cruisemissile_d_pr',1,133120,197642,'#damageChemical=f90.00  #damageKinetic=f0.00  #damageExplosive=f90.00  #damageThermal=f0.00  #range=f40  #explosion_radius=f16  #bullettime=f7.0','',2,0.75,'def_ammo_cruisemissile_d_desc',NULL,NULL),
('def_ammo_longrange_cruisemissile_a_pr',1,133120,197642,'#damageChemical=f0.00  #damageKinetic=f90.00  #damageExplosive=f90.00  #damageThermal=f0.00  #range=f40  #explosion_radius=f16  #bullettime=f7.0','',2,0.75,'def_ammo_longrange_cruisemissile_a_desc',NULL,NULL),
('def_ammo_longrange_cruisemissile_b_pr',1,133120,197642,'#damageChemical=f0.00  #damageKinetic=f0.00  #damageExplosive=f180.00  #damageThermal=f0.00  #range=f40  #explosion_radius=f12  #bullettime=f7.0','',2,0.75,'def_ammo_longrange_cruisemissile_b_desc',NULL,NULL),
('def_ammo_longrange_cruisemissile_c_pr',1,133120,197642,'#damageChemical=f0.00  #damageKinetic=f0.00  #damageExplosive=f90.00  #damageThermal=f90.00  #range=f40  #explosion_radius=f16  #bullettime=f7.0','',2,0.75,'def_ammo_longrange_cruisemissile_c_desc',NULL,NULL),
('def_ammo_longrange_cruisemissile_d_pr',1,133120,197642,'#damageChemical=f90.00  #damageKinetic=f0.00  #damageExplosive=f90.00  #damageThermal=f0.00  #range=f40  #explosion_radius=f16  #bullettime=f7.0','',2,0.75,'def_ammo_longrange_cruisemissile_d_desc',NULL,NULL);

PRINT N'MERGE (INSERT/UPDATE) PROTO AMMO ENTITYDEFS';
MERGE [dbo].[entitydefaults] def USING #AMMO_PROTO_DEFS ammo
ON def.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=ammo.defName)
WHEN MATCHED
    THEN UPDATE SET
		quantity=ammo.quantity,
		categoryflags=catFlags,
		attributeflags=attrFlags,
		volume=cargoVolume,
		mass=massOfModule,
		tiertype=techType,
		tierlevel=techLevel,
		options=genxyOptStr,
		note=ammo.note,
		enabled=1,
		hidden=0,
		purchasable=1,
		health=100,
		descriptiontoken=description
WHEN NOT MATCHED
    THEN INSERT (definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel) VALUES
	(defName,1,attrFlags,catFlags,genxyOptStr,note,1,cargoVolume,massOfModule,0,100,description,1,techType,techLevel);

DROP TABLE IF EXISTS #AMMO_PROTO_DEFS;
GO


DROP TABLE IF EXISTS #AMMO;
CREATE TABLE #AMMO 
(
	ammoName varchar(100),
	fieldName varchar(100),
	fieldValue float,
);
INSERT INTO #AMMO (ammoName, fieldName, fieldValue) VALUES
('def_ammo_large_railgun_a', 'damage_kinetic', 39),
('def_ammo_large_railgun_a', 'damage_thermal', 27),
('def_ammo_large_railgun_a', 'optimal_range_modifier', 1.0),
('def_ammo_large_railgun_b', 'damage_kinetic', 42),
('def_ammo_large_railgun_b', 'damage_chemical', 24),
('def_ammo_large_railgun_b', 'optimal_range_modifier', 1.0),
('def_ammo_large_railgun_c', 'damage_kinetic', 39),
('def_ammo_large_railgun_c', 'damage_explosive', 27),
('def_ammo_large_railgun_c', 'optimal_range_modifier', 1.0),
('def_ammo_large_railgun_d', 'damage_kinetic', 72),
('def_ammo_large_railgun_d', 'optimal_range_modifier', 1.0),
--
('def_ammo_large_lasercrystal_a', 'damage_thermal', 42),
('def_ammo_large_lasercrystal_a', 'damage_chemical', 24),
('def_ammo_large_lasercrystal_a', 'optimal_range_modifier', 1.0),
('def_ammo_large_lasercrystal_b', 'damage_thermal', 39),
('def_ammo_large_lasercrystal_b', 'damage_explosive', 27),
('def_ammo_large_lasercrystal_b', 'optimal_range_modifier', 1.0),
('def_ammo_large_lasercrystal_c', 'damage_kinetic', 27),
('def_ammo_large_lasercrystal_c', 'damage_thermal', 39),
('def_ammo_large_lasercrystal_c', 'optimal_range_modifier', 1.0),
('def_ammo_large_lasercrystal_d', 'damage_thermal', 72),
('def_ammo_large_lasercrystal_d', 'optimal_range_modifier', 1.0),
--
('def_ammo_cruisemissile_a', 'damage_kinetic', 67.5),
('def_ammo_cruisemissile_a', 'damage_explosive', 90),
('def_ammo_cruisemissile_a', 'optimal_range', 18),
('def_ammo_cruisemissile_a', 'falloff', 3),
('def_ammo_cruisemissile_a', 'explosion_radius', 37.5),
('def_ammo_cruisemissile_b', 'damage_explosive', 90),
('def_ammo_cruisemissile_b', 'damage_chemical', 67.5),
('def_ammo_cruisemissile_b', 'optimal_range', 18),
('def_ammo_cruisemissile_b', 'falloff', 3),
('def_ammo_cruisemissile_b', 'explosion_radius', 37.5),
('def_ammo_cruisemissile_c', 'damage_thermal', 67.5),
('def_ammo_cruisemissile_c', 'damage_explosive', 90),
('def_ammo_cruisemissile_c', 'optimal_range', 18),
('def_ammo_cruisemissile_c', 'falloff', 3),
('def_ammo_cruisemissile_c', 'explosion_radius', 37.5),
('def_ammo_cruisemissile_d', 'damage_explosive', 180),
('def_ammo_cruisemissile_d', 'explosion_radius', 37.5),
('def_ammo_cruisemissile_d', 'optimal_range', 18),
('def_ammo_cruisemissile_d', 'falloff', 3),
--
('def_ammo_longrange_cruisemissile_a', 'damage_kinetic', 45),
('def_ammo_longrange_cruisemissile_a', 'damage_explosive', 60),
('def_ammo_longrange_cruisemissile_a', 'optimal_range', 35),
('def_ammo_longrange_cruisemissile_a', 'falloff', 10),
('def_ammo_longrange_cruisemissile_a', 'explosion_radius', 39),
('def_ammo_longrange_cruisemissile_b', 'damage_explosive', 60),
('def_ammo_longrange_cruisemissile_b', 'damage_chemical', 45),
('def_ammo_longrange_cruisemissile_b', 'optimal_range', 35),
('def_ammo_longrange_cruisemissile_b', 'falloff', 10),
('def_ammo_longrange_cruisemissile_b', 'explosion_radius', 39),
('def_ammo_longrange_cruisemissile_c', 'damage_thermal', 45),
('def_ammo_longrange_cruisemissile_c', 'damage_explosive', 60),
('def_ammo_longrange_cruisemissile_c', 'optimal_range', 35),
('def_ammo_longrange_cruisemissile_c', 'falloff', 10),
('def_ammo_longrange_cruisemissile_c', 'explosion_radius', 39),
('def_ammo_longrange_cruisemissile_d', 'damage_explosive', 120),
('def_ammo_longrange_cruisemissile_d', 'optimal_range', 35),
('def_ammo_longrange_cruisemissile_d', 'falloff', 10),
('def_ammo_longrange_cruisemissile_d', 'explosion_radius', 39);
--PROTOS
INSERT INTO #AMMO (ammoName, fieldName, fieldValue) VALUES
('def_ammo_large_railgun_a_pr', 'damage_kinetic', 39),
('def_ammo_large_railgun_a_pr', 'damage_thermal', 27),
('def_ammo_large_railgun_a_pr', 'optimal_range_modifier', 1.0),
('def_ammo_large_railgun_b_pr', 'damage_kinetic', 42),
('def_ammo_large_railgun_b_pr', 'damage_chemical', 24),
('def_ammo_large_railgun_b_pr', 'optimal_range_modifier', 1.0),
('def_ammo_large_railgun_c_pr', 'damage_kinetic', 39),
('def_ammo_large_railgun_c_pr', 'damage_explosive', 27),
('def_ammo_large_railgun_c_pr', 'optimal_range_modifier', 1.0),
('def_ammo_large_railgun_d_pr', 'damage_kinetic', 72),
('def_ammo_large_railgun_d_pr', 'optimal_range_modifier', 1.0),
--
('def_ammo_large_lasercrystal_a_pr', 'damage_thermal', 42),
('def_ammo_large_lasercrystal_a_pr', 'damage_chemical', 24),
('def_ammo_large_lasercrystal_a_pr', 'optimal_range_modifier', 1.0),
('def_ammo_large_lasercrystal_b_pr', 'damage_thermal', 39),
('def_ammo_large_lasercrystal_b_pr', 'damage_explosive', 27),
('def_ammo_large_lasercrystal_b_pr', 'optimal_range_modifier', 1.0),
('def_ammo_large_lasercrystal_c_pr', 'damage_kinetic', 27),
('def_ammo_large_lasercrystal_c_pr', 'damage_thermal', 39),
('def_ammo_large_lasercrystal_c_pr', 'optimal_range_modifier', 1.0),
('def_ammo_large_lasercrystal_d_pr', 'damage_thermal', 72),
('def_ammo_large_lasercrystal_d_pr', 'optimal_range_modifier', 1.0),
--
('def_ammo_cruisemissile_a_pr', 'damage_kinetic', 67.5),
('def_ammo_cruisemissile_a_pr', 'damage_explosive', 90),
('def_ammo_cruisemissile_a_pr', 'optimal_range', 18),
('def_ammo_cruisemissile_a_pr', 'falloff', 3),
('def_ammo_cruisemissile_a_pr', 'explosion_radius', 37.5),
('def_ammo_cruisemissile_b_pr', 'damage_explosive', 90),
('def_ammo_cruisemissile_b_pr', 'damage_chemical', 67.5),
('def_ammo_cruisemissile_b_pr', 'optimal_range', 18),
('def_ammo_cruisemissile_b_pr', 'falloff', 3),
('def_ammo_cruisemissile_b_pr', 'explosion_radius', 37.5),
('def_ammo_cruisemissile_c_pr', 'damage_thermal', 67.5),
('def_ammo_cruisemissile_c_pr', 'damage_explosive', 90),
('def_ammo_cruisemissile_c_pr', 'optimal_range', 18),
('def_ammo_cruisemissile_c_pr', 'falloff', 3),
('def_ammo_cruisemissile_c_pr', 'explosion_radius', 37.5),
('def_ammo_cruisemissile_d_pr', 'damage_explosive', 180),
('def_ammo_cruisemissile_d_pr', 'explosion_radius', 37.5),
('def_ammo_cruisemissile_d_pr', 'optimal_range', 18),
('def_ammo_cruisemissile_d_pr', 'falloff', 3),
--
('def_ammo_longrange_cruisemissile_a_pr', 'damage_kinetic', 45),
('def_ammo_longrange_cruisemissile_a_pr', 'damage_explosive', 60),
('def_ammo_longrange_cruisemissile_a_pr', 'optimal_range', 35),
('def_ammo_longrange_cruisemissile_a_pr', 'falloff', 10),
('def_ammo_longrange_cruisemissile_a_pr', 'explosion_radius', 39),
('def_ammo_longrange_cruisemissile_b_pr', 'damage_explosive', 60),
('def_ammo_longrange_cruisemissile_b_pr', 'damage_chemical', 45),
('def_ammo_longrange_cruisemissile_b_pr', 'optimal_range', 35),
('def_ammo_longrange_cruisemissile_b_pr', 'falloff', 10),
('def_ammo_longrange_cruisemissile_b_pr', 'explosion_radius', 39),
('def_ammo_longrange_cruisemissile_c_pr', 'damage_thermal', 45),
('def_ammo_longrange_cruisemissile_c_pr', 'damage_explosive', 60),
('def_ammo_longrange_cruisemissile_c_pr', 'optimal_range', 35),
('def_ammo_longrange_cruisemissile_c_pr', 'falloff', 10),
('def_ammo_longrange_cruisemissile_c_pr', 'explosion_radius', 39),
('def_ammo_longrange_cruisemissile_d_pr', 'damage_explosive', 120),
('def_ammo_longrange_cruisemissile_d_pr', 'optimal_range', 35),
('def_ammo_longrange_cruisemissile_d_pr', 'falloff', 10),
('def_ammo_longrange_cruisemissile_d_pr', 'explosion_radius', 39);


DROP TABLE IF EXISTS #BEAMS;
CREATE TABLE #BEAMS 
(
	ammoName varchar(100),
	beamName varchar(100)
);
INSERT INTO #BEAMS (ammoName, beamName) VALUES
('def_ammo_large_railgun_a', 'pbs_turret_railgun'),
('def_ammo_large_railgun_b', 'pbs_turret_railgun'),
('def_ammo_large_railgun_c', 'pbs_turret_railgun'),
('def_ammo_large_railgun_d', 'pbs_turret_railgun'),
--
('def_ammo_large_lasercrystal_a', 'multifocal_medium_laser'),
('def_ammo_large_lasercrystal_b', 'multifocal_medium_laser'),
('def_ammo_large_lasercrystal_c', 'multifocal_medium_laser'),
('def_ammo_large_lasercrystal_d', 'multifocal_medium_laser'),
--
('def_ammo_cruisemissile_a', 'pbs_turret_missile'),
('def_ammo_cruisemissile_b', 'pbs_turret_missile'),
('def_ammo_cruisemissile_c', 'pbs_turret_missile'),
('def_ammo_cruisemissile_d', 'pbs_turret_missile'),
--
('def_ammo_longrange_cruisemissile_a', 'cruisemissile_large'),
('def_ammo_longrange_cruisemissile_b', 'cruisemissile_large'),
('def_ammo_longrange_cruisemissile_c', 'cruisemissile_large'),
('def_ammo_longrange_cruisemissile_d', 'cruisemissile_large');

INSERT INTO #BEAMS (ammoName, beamName) VALUES
('def_ammo_large_railgun_a_pr', 'pbs_turret_railgun'),
('def_ammo_large_railgun_b_pr', 'pbs_turret_railgun'),
('def_ammo_large_railgun_c_pr', 'pbs_turret_railgun'),
('def_ammo_large_railgun_d_pr', 'pbs_turret_railgun'),
--
('def_ammo_large_lasercrystal_a_pr', 'multifocal_medium_laser'),
('def_ammo_large_lasercrystal_b_pr', 'multifocal_medium_laser'),
('def_ammo_large_lasercrystal_c_pr', 'multifocal_medium_laser'),
('def_ammo_large_lasercrystal_d_pr', 'multifocal_medium_laser'),
--
('def_ammo_cruisemissile_a_pr', 'pbs_turret_missile'),
('def_ammo_cruisemissile_b_pr', 'pbs_turret_missile'),
('def_ammo_cruisemissile_c_pr', 'pbs_turret_missile'),
('def_ammo_cruisemissile_d_pr', 'pbs_turret_missile'),
--
('def_ammo_longrange_cruisemissile_a_pr', 'cruisemissile_large'),
('def_ammo_longrange_cruisemissile_b_pr', 'cruisemissile_large'),
('def_ammo_longrange_cruisemissile_c_pr', 'cruisemissile_large'),
('def_ammo_longrange_cruisemissile_d_pr', 'cruisemissile_large');


DROP TABLE IF EXISTS #ENABLESKILLS;
CREATE TABLE #ENABLESKILLS 
(
	ammoName VARCHAR(100),
	extName VARCHAR(100),
	level INT
);
INSERT INTO #ENABLESKILLS (ammoName, extName, level) VALUES
('def_ammo_large_railgun_a', 'ext_large_railgun', 1),
('def_ammo_large_railgun_b', 'ext_large_railgun', 1),
('def_ammo_large_railgun_c', 'ext_large_railgun', 1),
('def_ammo_large_railgun_d', 'ext_large_railgun', 1),
--
('def_ammo_large_lasercrystal_a', 'ext_large_laser', 1),
('def_ammo_large_lasercrystal_b', 'ext_large_laser', 1),
('def_ammo_large_lasercrystal_c', 'ext_large_laser', 1),
('def_ammo_large_lasercrystal_d', 'ext_large_laser', 1),
--
('def_ammo_cruisemissile_a', 'ext_cruise_missiles', 1),
('def_ammo_cruisemissile_b', 'ext_cruise_missiles', 1),
('def_ammo_cruisemissile_c', 'ext_cruise_missiles', 1),
('def_ammo_cruisemissile_d', 'ext_cruise_missiles', 1),
--
('def_ammo_longrange_cruisemissile_a', 'ext_cruise_missiles', 2),
('def_ammo_longrange_cruisemissile_b', 'ext_cruise_missiles', 2),
('def_ammo_longrange_cruisemissile_c', 'ext_cruise_missiles', 2),
('def_ammo_longrange_cruisemissile_d', 'ext_cruise_missiles', 2);

INSERT INTO #ENABLESKILLS (ammoName, extName, level) VALUES
('def_ammo_large_railgun_a_pr', 'ext_large_railgun', 1),
('def_ammo_large_railgun_b_pr', 'ext_large_railgun', 1),
('def_ammo_large_railgun_c_pr', 'ext_large_railgun', 1),
('def_ammo_large_railgun_d_pr', 'ext_large_railgun', 1),
--
('def_ammo_large_lasercrystal_a_pr', 'ext_large_laser', 1),
('def_ammo_large_lasercrystal_b_pr', 'ext_large_laser', 1),
('def_ammo_large_lasercrystal_c_pr', 'ext_large_laser', 1),
('def_ammo_large_lasercrystal_d_pr', 'ext_large_laser', 1),
--
('def_ammo_cruisemissile_a_pr', 'ext_cruise_missiles', 1),
('def_ammo_cruisemissile_b_pr', 'ext_cruise_missiles', 1),
('def_ammo_cruisemissile_c_pr', 'ext_cruise_missiles', 1),
('def_ammo_cruisemissile_d_pr', 'ext_cruise_missiles', 1),
--
('def_ammo_longrange_cruisemissile_a_pr', 'ext_cruise_missiles', 2),
('def_ammo_longrange_cruisemissile_b_pr', 'ext_cruise_missiles', 2),
('def_ammo_longrange_cruisemissile_c_pr', 'ext_cruise_missiles', 2),
('def_ammo_longrange_cruisemissile_d_pr', 'ext_cruise_missiles', 2);


UPDATE entitydefaults SET
 attributeflags=133120
WHERE definitionname in (SELECT DISTINCT ammoName FROM #BEAMS) and definitionname like 'def_ammo_%';

SELECT * FROM entitydefaults WHERE definitionname in (SELECT DISTINCT ammoName FROM #BEAMS);

SELECT * FROM beamassignment WHERE definition in (SELECT entitydefaults.definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT ammoName FROM #BEAMS));
DELETE FROM beamassignment WHERE definition in (SELECT entitydefaults.definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT ammoName FROM #BEAMS));

INSERT INTO beamassignment (definition, beam)
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=ammoName),
	(SELECT TOP 1 id FROM beams WHERE name=beamName)
FROM #BEAMS

PRINT N'ENABLE LARGE AMMO DEFINITIONS';
UPDATE entitydefaults SET
	hidden=0,
	enabled=1,
	purchasable=1
WHERE definitionname in (SELECT DISTINCT ammoName from #AMMO);
SELECT DISTINCT categoryflags from entitydefaults where definitionname in (SELECT DISTINCT ammoName from #AMMO);
SELECT * FROM categoryFlags WHERE value in (SELECT DISTINCT categoryflags from entitydefaults where definitionname in (SELECT DISTINCT ammoName from #AMMO));


PRINT N'SHOW LARGE AMMO CATEGORIES';
UPDATE categoryFlags SET
	hidden=0
WHERE value in (SELECT DISTINCT categoryflags from entitydefaults where definitionname in (SELECT DISTINCT ammoName from #AMMO));

PRINT N'PRINT OLD STATS';
SELECT definitionname, field, value FROM aggregatevalues as a
JOIN entitydefaults as e on e.definition=a.definition
 WHERE a.definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT ammoName FROM #AMMO));

PRINT N'DELETE OLD STATS';
DELETE FROM aggregatevalues WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT ammoName FROM #AMMO));

PRINT N'INSERT NEW STATS';
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value])
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE ammoName=definitionname),
	(SELECT TOP 1 id FROM aggregatefields WHERE fieldName=name),
	fieldValue 
FROM #AMMO

--DELETE and REINSERT
PRINT N'DELETE AMMO REQ-EXTENSIONS';
SELECT * FROM enablerextensions WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT ammoName FROM #ENABLESKILLS));
DELETE FROM enablerextensions WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT ammoName FROM #ENABLESKILLS));
PRINT N'INSERT AMMO REQ-EXTENSIONS';
INSERT INTO [dbo].[enablerextensions] ([definition],[extensionid],[extensionlevel]) 
SELECT (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname= ammoName),
	(SELECT TOP 1 extensionid FROM extensions WHERE extensionname = extName),
	level
FROM #ENABLESKILLS;


PRINT N'Enable skills that are required to operate the ammo';
UPDATE extensions SET
	hidden=0, active=1
WHERE extensionname in (SELECT DISTINCT extName FROM #ENABLESKILLS);

DROP TABLE IF EXISTS #UNIQ_CAT_FLAGS;
CREATE TABLE #UNIQ_CAT_FLAGS
(
	catFlags bigint
);
INSERT INTO #UNIQ_CAT_FLAGS (catFlags) SELECT DISTINCT categoryflags from entitydefaults where definitionname in (SELECT DISTINCT ammoName from #AMMO);
select * from #UNIQ_CAT_FLAGS
PRINT N'UN-HIDE AMMO CATEGORIES';
UPDATE categoryFlags SET
  hidden=0
WHERE value in (SELECT catFlags from #UNIQ_CAT_FLAGS);

select * from productiondecalibration where categoryflag in(196874, 197130, 197642)

PRINT N'UPDATE/INSERT WEP Category for production decalibration';
--Update/insert [productiondecalibration] entries
MERGE [dbo].[productiondecalibration] decal USING #UNIQ_CAT_FLAGS ammo
ON decal.categoryflag = ammo.catFlags
WHEN MATCHED
    THEN UPDATE SET
		distorsionmin=0.003,
		distorsionmax=0.005,
		decrease=0.3
WHEN NOT MATCHED
    THEN INSERT (categoryflag,distorsionmin,distorsionmax,decrease) VALUES
	(ammo.catFlags, 0.003, 0.005, 0.3);

PRINT N'UPDATE/INSERT WEP Category for production duration';
--Update/insert [productionduration] entries
MERGE [dbo].[productionduration] dur USING #UNIQ_CAT_FLAGS ammo
ON dur.category = ammo.catFlags
WHEN MATCHED
    THEN UPDATE SET
		durationmodifier=0.45
WHEN NOT MATCHED
    THEN INSERT (category,durationmodifier) VALUES
	(ammo.catFlags, 0.45);

DROP TABLE IF EXISTS #UNIQ_CAT_FLAGS;


DROP TABLE IF EXISTS #ENABLESKILLS;
DROP TABLE IF EXISTS #BEAMS;
DROP TABLE IF EXISTS #AMMO;
PRINT N'LARGE AMMOS UPDATED';
GO


PRINT N'AMMO PRODUCTION';

DROP TABLE IF EXISTS #AMMO_COMPS;
CREATE TABLE #AMMO_COMPS
(
	defName VARCHAR(100),
	commodityName VARCHAR(100),
	amount INT
);
INSERT INTO #AMMO_COMPS (defName, commodityName, amount) VALUES
('def_ammo_large_railgun_a', 'def_polynucleit', 75),
('def_ammo_large_railgun_a', 'def_polynitrocol', 150),
('def_ammo_large_railgun_a', 'def_titanium', 75),
('def_ammo_large_railgun_a', 'def_specimen_sap_item_flux', 2),

('def_ammo_large_railgun_b', 'def_axicoline', 150),
('def_ammo_large_railgun_b', 'def_polynitrocol', 150),
('def_ammo_large_railgun_b', 'def_titanium', 75),
('def_ammo_large_railgun_b', 'def_specimen_sap_item_flux', 2),

('def_ammo_large_railgun_c', 'def_phlobotil', 75),
('def_ammo_large_railgun_c', 'def_polynitrocol', 150),
('def_ammo_large_railgun_c', 'def_titanium', 75),
('def_ammo_large_railgun_c', 'def_specimen_sap_item_flux', 2),

('def_ammo_large_railgun_d', 'def_polynitrocol', 300),
('def_ammo_large_railgun_d', 'def_titanium', 75),
('def_ammo_large_railgun_d', 'def_specimen_sap_item_flux', 2),
--
('def_ammo_large_lasercrystal_a', 'def_axicoline', 150),
('def_ammo_large_lasercrystal_a', 'def_polynucleit', 150),
('def_ammo_large_lasercrystal_a', 'def_titanium', 75),
('def_ammo_large_lasercrystal_a', 'def_specimen_sap_item_flux', 2),

('def_ammo_large_lasercrystal_b', 'def_phlobotil', 75),
('def_ammo_large_lasercrystal_b', 'def_polynucleit', 150),
('def_ammo_large_lasercrystal_b', 'def_titanium', 75),
('def_ammo_large_lasercrystal_b', 'def_specimen_sap_item_flux', 2),

('def_ammo_large_lasercrystal_c', 'def_polynucleit', 150),
('def_ammo_large_lasercrystal_c', 'def_polynitrocol', 75),
('def_ammo_large_lasercrystal_c', 'def_titanium', 75),
('def_ammo_large_lasercrystal_c', 'def_specimen_sap_item_flux', 2),

('def_ammo_large_lasercrystal_d', 'def_polynucleit', 300),
('def_ammo_large_lasercrystal_d', 'def_titanium', 75),
('def_ammo_large_lasercrystal_d', 'def_specimen_sap_item_flux', 2),
--
('def_ammo_cruisemissile_a', 'def_phlobotil', 150),
('def_ammo_cruisemissile_a', 'def_polynitrocol', 75),
('def_ammo_cruisemissile_a', 'def_titanium', 75),
('def_ammo_cruisemissile_a', 'def_specimen_sap_item_flux', 2),

('def_ammo_cruisemissile_b', 'def_phlobotil', 150),
('def_ammo_cruisemissile_b', 'def_axicoline', 150),
('def_ammo_cruisemissile_b', 'def_titanium', 75),
('def_ammo_cruisemissile_b', 'def_specimen_sap_item_flux', 2),

('def_ammo_cruisemissile_c', 'def_phlobotil', 150),
('def_ammo_cruisemissile_c', 'def_polynucleit', 75),
('def_ammo_cruisemissile_c', 'def_titanium', 75),
('def_ammo_cruisemissile_c', 'def_specimen_sap_item_flux', 2),

('def_ammo_cruisemissile_d', 'def_phlobotil', 300),
('def_ammo_cruisemissile_d', 'def_titanium', 75),
('def_ammo_cruisemissile_d', 'def_specimen_sap_item_flux', 2),
--
('def_ammo_longrange_cruisemissile_a', 'def_phlobotil', 150),
('def_ammo_longrange_cruisemissile_a', 'def_polynitrocol', 75),
('def_ammo_longrange_cruisemissile_a', 'def_titanium', 75),
('def_ammo_longrange_cruisemissile_a', 'def_specimen_sap_item_flux', 2),

('def_ammo_longrange_cruisemissile_b', 'def_phlobotil', 150),
('def_ammo_longrange_cruisemissile_b', 'def_axicoline', 150),
('def_ammo_longrange_cruisemissile_b', 'def_titanium', 75),
('def_ammo_longrange_cruisemissile_b', 'def_specimen_sap_item_flux', 2),

('def_ammo_longrange_cruisemissile_c', 'def_phlobotil', 150),
('def_ammo_longrange_cruisemissile_c', 'def_polynucleit', 75),
('def_ammo_longrange_cruisemissile_c', 'def_titanium', 75),
('def_ammo_longrange_cruisemissile_c', 'def_specimen_sap_item_flux', 2),

('def_ammo_longrange_cruisemissile_d', 'def_phlobotil', 300),
('def_ammo_longrange_cruisemissile_d', 'def_titanium', 75),
('def_ammo_longrange_cruisemissile_d', 'def_specimen_sap_item_flux', 2);

INSERT INTO #AMMO_COMPS (defName, commodityName, amount) VALUES
('def_ammo_large_railgun_a_pr', 'def_polynucleit', 75),
('def_ammo_large_railgun_a_pr', 'def_polynitrocol', 150),
('def_ammo_large_railgun_a_pr', 'def_titanium', 75),
('def_ammo_large_railgun_a_pr', 'def_specimen_sap_item_flux', 2),

('def_ammo_large_railgun_b_pr', 'def_axicoline', 150),
('def_ammo_large_railgun_b_pr', 'def_polynitrocol', 150),
('def_ammo_large_railgun_b_pr', 'def_titanium', 75),
('def_ammo_large_railgun_b_pr', 'def_specimen_sap_item_flux', 2),

('def_ammo_large_railgun_c_pr', 'def_phlobotil', 75),
('def_ammo_large_railgun_c_pr', 'def_polynitrocol', 150),
('def_ammo_large_railgun_c_pr', 'def_titanium', 75),
('def_ammo_large_railgun_c_pr', 'def_specimen_sap_item_flux', 2),

('def_ammo_large_railgun_d_pr', 'def_polynitrocol', 300),
('def_ammo_large_railgun_d_pr', 'def_titanium', 75),
('def_ammo_large_railgun_d_pr', 'def_specimen_sap_item_flux', 2),
--
('def_ammo_large_lasercrystal_a_pr', 'def_axicoline', 150),
('def_ammo_large_lasercrystal_a_pr', 'def_polynucleit', 150),
('def_ammo_large_lasercrystal_a_pr', 'def_titanium', 75),
('def_ammo_large_lasercrystal_a_pr', 'def_specimen_sap_item_flux', 2),

('def_ammo_large_lasercrystal_b_pr', 'def_phlobotil', 75),
('def_ammo_large_lasercrystal_b_pr', 'def_polynucleit', 150),
('def_ammo_large_lasercrystal_b_pr', 'def_titanium', 75),
('def_ammo_large_lasercrystal_b_pr', 'def_specimen_sap_item_flux', 2),

('def_ammo_large_lasercrystal_c_pr', 'def_polynucleit', 150),
('def_ammo_large_lasercrystal_c_pr', 'def_polynitrocol', 75),
('def_ammo_large_lasercrystal_c_pr', 'def_titanium', 75),
('def_ammo_large_lasercrystal_c_pr', 'def_specimen_sap_item_flux', 2),

('def_ammo_large_lasercrystal_d_pr', 'def_polynucleit', 300),
('def_ammo_large_lasercrystal_d_pr', 'def_titanium', 75),
('def_ammo_large_lasercrystal_d_pr', 'def_specimen_sap_item_flux', 2),
--
('def_ammo_cruisemissile_a_pr', 'def_phlobotil', 150),
('def_ammo_cruisemissile_a_pr', 'def_polynitrocol', 75),
('def_ammo_cruisemissile_a_pr', 'def_titanium', 75),
('def_ammo_cruisemissile_a_pr', 'def_specimen_sap_item_flux', 2),

('def_ammo_cruisemissile_b_pr', 'def_phlobotil', 150),
('def_ammo_cruisemissile_b_pr', 'def_axicoline', 150),
('def_ammo_cruisemissile_b_pr', 'def_titanium', 75),
('def_ammo_cruisemissile_b_pr', 'def_specimen_sap_item_flux', 2),

('def_ammo_cruisemissile_c_pr', 'def_phlobotil', 150),
('def_ammo_cruisemissile_c_pr', 'def_polynucleit', 75),
('def_ammo_cruisemissile_c_pr', 'def_titanium', 75),
('def_ammo_cruisemissile_c_pr', 'def_specimen_sap_item_flux', 2),

('def_ammo_cruisemissile_d_pr', 'def_phlobotil', 300),
('def_ammo_cruisemissile_d_pr', 'def_titanium', 75),
('def_ammo_cruisemissile_d_pr', 'def_specimen_sap_item_flux', 2),
--
('def_ammo_longrange_cruisemissile_a_pr', 'def_phlobotil', 150),
('def_ammo_longrange_cruisemissile_a_pr', 'def_polynitrocol', 75),
('def_ammo_longrange_cruisemissile_a_pr', 'def_titanium', 75),
('def_ammo_longrange_cruisemissile_a_pr', 'def_specimen_sap_item_flux', 2),

('def_ammo_longrange_cruisemissile_b_pr', 'def_phlobotil', 150),
('def_ammo_longrange_cruisemissile_b_pr', 'def_axicoline', 150),
('def_ammo_longrange_cruisemissile_b_pr', 'def_titanium', 75),
('def_ammo_longrange_cruisemissile_b_pr', 'def_specimen_sap_item_flux', 2),

('def_ammo_longrange_cruisemissile_c_pr', 'def_phlobotil', 150),
('def_ammo_longrange_cruisemissile_c_pr', 'def_polynucleit', 75),
('def_ammo_longrange_cruisemissile_c_pr', 'def_titanium', 75),
('def_ammo_longrange_cruisemissile_c_pr', 'def_specimen_sap_item_flux', 2),

('def_ammo_longrange_cruisemissile_d_pr', 'def_phlobotil', 300),
('def_ammo_longrange_cruisemissile_d_pr', 'def_titanium', 75),
('def_ammo_longrange_cruisemissile_d_pr', 'def_specimen_sap_item_flux', 2);

PRINT N'DELETE components FOR ANY EXISTING LARGE mods (0 results if 1st run)';
SELECT * FROM components WHERE definition IN (SELECT definition FROM entitydefaults WHERE definitionname IN (SELECT DISTINCT defName FROM #AMMO_COMPS));
DELETE FROM components WHERE definition IN (SELECT definition FROM entitydefaults WHERE definitionname IN (SELECT DISTINCT defName FROM #AMMO_COMPS));

PRINT N'INSERT components FORLARGE mods';
INSERT INTO components (definition, componentdefinition, componentamount)
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defName),
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=commodityName),
	amount
FROM #AMMO_COMPS;


DROP TABLE IF EXISTS #AMMO_COMPS;
GO


PRINT N'CALIBRATION TEMPLATES FOR MODULES';

DECLARE @CTammoLaserCategory BIGINT;
DECLARE @CTammoRailgunCategory BIGINT;
DECLARE @CTammoMissileCategory BIGINT;

SET @CTammoLaserCategory = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_ammo_laser_calibration_programs');
SET @CTammoRailgunCategory = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_ammo_railgun_calibration_programs');
SET @CTammoMissileCategory = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_ammo_missile_calibration_programs');



DROP TABLE IF EXISTS #AMMOCTS;
CREATE TABLE #AMMOCTS 
(
	defName varchar(100),
	catFlags bigint,
	attrFlags bigint,
	cargoVolume float,
	massOfModule float,
	techType int,
	techLevel int,
	genxyOptStr varchar(max),
);

INSERT INTO #AMMOCTS (defName, attrFlags, catFlags, cargoVolume, massOfModule, techType, techLevel, genxyOptStr) VALUES
('def_ammo_large_railgun_a_cprg', 1024, @CTammoRailgunCategory, 0.01, 0.1, NULL, NULL, NULL),
('def_ammo_large_railgun_b_cprg', 1024, @CTammoRailgunCategory, 0.01, 0.1, NULL, NULL, NULL),
('def_ammo_large_railgun_c_cprg', 1024, @CTammoRailgunCategory, 0.01, 0.1, NULL, NULL, NULL),
('def_ammo_large_railgun_d_cprg', 1024, @CTammoRailgunCategory, 0.01, 0.1, NULL, NULL, NULL),
--
('def_ammo_large_lasercrystal_a_cprg', 1024, @CTammoLaserCategory, 0.01, 0.1, NULL, NULL, NULL),
('def_ammo_large_lasercrystal_b_cprg', 1024, @CTammoLaserCategory, 0.01, 0.1, NULL, NULL, NULL),
('def_ammo_large_lasercrystal_c_cprg', 1024, @CTammoLaserCategory, 0.01, 0.1, NULL, NULL, NULL),
('def_ammo_large_lasercrystal_d_cprg', 1024, @CTammoLaserCategory, 0.01, 0.1, NULL, NULL, NULL),
--
('def_ammo_cruisemissile_a_cprg', 1024, @CTammoMissileCategory, 0.01, 0.1, NULL, NULL, NULL),
('def_ammo_cruisemissile_b_cprg', 1024, @CTammoMissileCategory, 0.01, 0.1, NULL, NULL, NULL),
('def_ammo_cruisemissile_c_cprg', 1024, @CTammoMissileCategory, 0.01, 0.1, NULL, NULL, NULL),
('def_ammo_cruisemissile_d_cprg', 1024, @CTammoMissileCategory, 0.01, 0.1, NULL, NULL, NULL),
--
('def_ammo_longrange_cruisemissile_a_cprg', 1024, @CTammoMissileCategory, 0.01, 0.1, NULL, NULL, NULL),
('def_ammo_longrange_cruisemissile_b_cprg', 1024, @CTammoMissileCategory, 0.01, 0.1, NULL, NULL, NULL),
('def_ammo_longrange_cruisemissile_c_cprg', 1024, @CTammoMissileCategory, 0.01, 0.1, NULL, NULL, NULL),
('def_ammo_longrange_cruisemissile_d_cprg', 1024, @CTammoMissileCategory, 0.01, 0.1, NULL, NULL, NULL);




PRINT N'UPDATE/INSERT CTS';
--Update/insert [entitydefaults] entries
MERGE [dbo].[entitydefaults] def USING #AMMOCTS ct
ON def.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=ct.defName)
WHEN MATCHED
    THEN UPDATE SET
		categoryflags=catFlags,
		attributeflags=attrFlags,
		volume=cargoVolume,
		mass=massOfModule,
		tiertype=techType,
		tierlevel=techLevel,
		options=genxyOptStr,
		enabled=1,
		hidden=0,
		purchasable=0,
		descriptiontoken='calibration_program_desc'
WHEN NOT MATCHED
    THEN INSERT (definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel) VALUES
	(defName, 1, attrFlags,catFlags,genxyOptStr,'CT large AMMO',1,cargoVolume,massOfModule,0,100,'calibration_program_desc',0,techType,techLevel);

PRINT N'DELETE calibrationdefaults FOR ANY EXISTING LARGE MOD CTS (0 results if 1st run)';
SELECT * FROM calibrationdefaults WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #AMMOCTS));
DELETE FROM calibrationdefaults WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #AMMOCTS));

PRINT N'INSERT calibrationdefaults FOR MOD CTS';
INSERT INTO calibrationdefaults (definition, materialefficiency, timeefficiency)
SELECT (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = defName), 80, 80 FROM #AMMOCTS;

DROP TABLE IF EXISTS #PROTO_TO_CT;
CREATE TABLE #PROTO_TO_CT
(
	protoDefName VARCHAR(100),
	ctDefName VARCHAR(100),
	level INT
);

INSERT INTO #PROTO_TO_CT (protoDefName, ctDefName, level) VALUES
('def_ammo_large_railgun_a_pr', 'def_ammo_large_railgun_a_cprg', 5),
('def_ammo_large_railgun_b_pr', 'def_ammo_large_railgun_b_cprg', 5),
('def_ammo_large_railgun_c_pr', 'def_ammo_large_railgun_c_cprg', 5),
('def_ammo_large_railgun_d_pr', 'def_ammo_large_railgun_d_cprg', 5),
--
('def_ammo_large_lasercrystal_a_pr', 'def_ammo_large_lasercrystal_a_cprg', 5),
('def_ammo_large_lasercrystal_b_pr', 'def_ammo_large_lasercrystal_b_cprg', 5),
('def_ammo_large_lasercrystal_c_pr', 'def_ammo_large_lasercrystal_c_cprg', 5),
('def_ammo_large_lasercrystal_d_pr', 'def_ammo_large_lasercrystal_d_cprg', 5),
--
('def_ammo_cruisemissile_a_pr', 'def_ammo_cruisemissile_a_cprg', 5),
('def_ammo_cruisemissile_b_pr', 'def_ammo_cruisemissile_b_cprg', 5),
('def_ammo_cruisemissile_c_pr', 'def_ammo_cruisemissile_c_cprg', 5),
('def_ammo_cruisemissile_d_pr', 'def_ammo_cruisemissile_d_cprg', 5),
--
('def_ammo_longrange_cruisemissile_a_pr', 'def_ammo_longrange_cruisemissile_a_cprg', 5),
('def_ammo_longrange_cruisemissile_b_pr', 'def_ammo_longrange_cruisemissile_b_cprg', 5),
('def_ammo_longrange_cruisemissile_c_pr', 'def_ammo_longrange_cruisemissile_c_cprg', 5),
('def_ammo_longrange_cruisemissile_d_pr', 'def_ammo_longrange_cruisemissile_d_cprg', 5);

PRINT N'DELETE itemresearchlevels FOR ANY EXISTING LARGE MOD CTS (0 results if 1st run)';
SELECT * FROM itemresearchlevels WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT protoDefName FROM #PROTO_TO_CT));
DELETE FROM itemresearchlevels WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT protoDefName FROM #PROTO_TO_CT));

PRINT N'INSERT itemresearchlevels FOR MOD CTS';
INSERT INTO itemresearchlevels (definition, calibrationprogram, researchlevel, enabled)
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = protoDefName), 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = ctDefName), 
	level, 1
FROM #PROTO_TO_CT;


DROP TABLE IF EXISTS #AMMOCTS;
DROP TABLE IF EXISTS #PROTO_TO_CT;
GO


PRINT N'AMMO PROTOTYPE PAIRINGS';

DROP TABLE IF EXISTS #PROTOPAIRS;
CREATE TABLE #PROTOPAIRS
(
	defName varchar(100),
	protoDefName varchar(100),
);


INSERT INTO #PROTOPAIRS (defName, protoDefName) VALUES
('def_ammo_large_railgun_a', 'def_ammo_large_railgun_a_pr'),
('def_ammo_large_railgun_b', 'def_ammo_large_railgun_b_pr'),
('def_ammo_large_railgun_c', 'def_ammo_large_railgun_c_pr'),
('def_ammo_large_railgun_d', 'def_ammo_large_railgun_d_pr'),
--
('def_ammo_large_lasercrystal_a', 'def_ammo_large_lasercrystal_a_pr'),
('def_ammo_large_lasercrystal_b', 'def_ammo_large_lasercrystal_b_pr'),
('def_ammo_large_lasercrystal_c', 'def_ammo_large_lasercrystal_c_pr'),
('def_ammo_large_lasercrystal_d', 'def_ammo_large_lasercrystal_d_pr'),
--
('def_ammo_cruisemissile_a', 'def_ammo_cruisemissile_a_pr'),
('def_ammo_cruisemissile_b', 'def_ammo_cruisemissile_b_pr'),
('def_ammo_cruisemissile_c', 'def_ammo_cruisemissile_c_pr'),
('def_ammo_cruisemissile_d', 'def_ammo_cruisemissile_d_pr'),
--
('def_ammo_longrange_cruisemissile_a', 'def_ammo_longrange_cruisemissile_a_pr'),
('def_ammo_longrange_cruisemissile_b', 'def_ammo_longrange_cruisemissile_b_pr'),
('def_ammo_longrange_cruisemissile_c', 'def_ammo_longrange_cruisemissile_c_pr'),
('def_ammo_longrange_cruisemissile_d', 'def_ammo_longrange_cruisemissile_d_pr');


--DELETE and reinsert
PRINT N'DELETE prototypes FOR ANY EXISTING LARGE ammo-proto PAIRS (0 results if first run)';
SELECT * FROM prototypes WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT defName FROM #PROTOPAIRS));
DELETE FROM prototypes WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT defName FROM #PROTOPAIRS));

--INSERT
PRINT N'INSERT prototypes FOR LARGE ammo proto PAIRS';
INSERT INTO prototypes (definition, prototype)
SELECT (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = defName), 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = protoDefName)
FROM #PROTOPAIRS;
DROP TABLE IF EXISTS #PROTOPAIRS;
GO



PRINT N'04_LARGE_MODULES';

USE [perpetuumsa]
GO

DROP TABLE IF EXISTS #LARGEMODS;
CREATE TABLE #LARGEMODS 
(
	defName varchar(100),
	catFlags bigint,
	attrFlags bigint,
	cargoVolume float,
	massOfModule float,
	techType int,
	techLevel int,
	genxyOptStr varchar(max),
);

INSERT INTO #LARGEMODS (defName, attrFlags, catFlags, cargoVolume, massOfModule, techType, techLevel, genxyOptStr) VALUES
('def_standard_large_armor_plate', 655360, 50397455, 4, 9000, 1, 1, '#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t1'),
('def_named1_large_armor_plate', 655360, 50397455, 4, 7200, 1, 2, '#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t2'),
('def_named2_large_armor_plate', 655360, 50397455, 4, 9000, 1, 3, '#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t3'),
('def_named3_large_armor_plate', 655360, 50397455, 4, 10050, 1, 4, '#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t4'),
--
('def_standard_large_armor_repairer', 147472, 50462991, 3, 1500, 1, 1, '#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t1'),
('def_named1_large_armor_repairer', 147472, 50462991, 3, 1350, 1, 2, '#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t2'),
('def_named2_large_armor_repairer', 147472, 50462991, 3, 1500, 1, 3, '#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t3'),
('def_named3_large_armor_repairer', 147472, 50462991, 3, 1600, 1, 4, '#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t4'),
--
('def_standard_large_shield_generator', 147736, 50397711, 1, 800, 1, 1, '#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t1'),
('def_named1_large_shield_generator', 147736, 50397711, 1, 720, 1, 2, '#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t2'),
('def_named2_large_shield_generator', 147736, 50397711, 1, 880, 1, 3, '#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t3'),
('def_named3_large_shield_generator', 147736, 50397711, 1, 940, 1, 4, '#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t4'),
--
('def_standard_large_core_battery', 655364, 50856719, 3, 3000, 1, 1, '#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t1'),
('def_named1_large_core_battery', 655364, 50856719, 3, 2700, 1, 2, '#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t2'),
('def_named2_large_core_battery', 655364, 50856719, 3, 3000, 1, 3, '#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t3'),
('def_named3_large_core_battery', 655364, 50856719, 3, 3000, 1, 4, '#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t4'),
--
('def_standard_large_core_booster', 409620, 50922255, 2, 1600, 1, 1, '#moduleFlag=i20 #ammoCapacity=ia #ammoType=L70a #tier=$tierlevel_t1'),
('def_named1_large_core_booster', 409620, 50922255, 2, 1440, 1, 2, '#moduleFlag=i20 #ammoCapacity=ia #ammoType=L70a #tier=$tierlevel_t2'),
('def_named2_large_core_booster', 409620, 50922255, 2, 1600, 1, 3, '#moduleFlag=i20 #ammoCapacity=ia #ammoType=L70a #tier=$tierlevel_t3'),
('def_named3_large_core_booster', 409620, 50922255, 2, 1600, 1, 4, '#moduleFlag=i20 #ammoCapacity=ic #ammoType=L70a #tier=$tierlevel_t4'),
--PROTOTYPES
('def_standard_large_armor_plate_pr', 655360, 50397455, 4, 9000, NULL, NULL, '#moduleFlag=i20 #ammoCapacity=i0'),
('def_named1_large_armor_plate_pr', 655360, 50397455, 4, 7200, 2, 2, '#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t2_pr'),
('def_named2_large_armor_plate_pr', 655360, 50397455, 4, 9000, 2, 3, '#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t3_pr'),
('def_named3_large_armor_plate_pr', 655360, 50397455, 4, 10050, 2, 4, '#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t4_pr'),
--
('def_standard_large_armor_repairer_pr', 147472, 50462991, 3, 1500, NULL, NULL, '#moduleFlag=i20 #ammoCapacity=i0'),
('def_named1_large_armor_repairer_pr', 147472, 50462991, 3, 1350, 2, 2, '#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t2_pr'),
('def_named2_large_armor_repairer_pr', 147472, 50462991, 3, 1500, 2, 3, '#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t3_pr'),
('def_named3_large_armor_repairer_pr', 147472, 50462991, 3, 1600, 2, 4, '#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t4_pr'),
--
('def_standard_large_shield_generator_pr', 147736, 50397711, 1, 800, NULL, NULL, '#moduleFlag=i20 #ammoCapacity=i0'),
('def_named1_large_shield_generator_pr', 147736, 50397711, 1, 720, 2, 2, '#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t2_pr'),
('def_named2_large_shield_generator_pr', 147736, 50397711, 1, 880, 2, 3, '#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t3_pr'),
('def_named3_large_shield_generator_pr', 147736, 50397711, 1, 940, 2, 4, '#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t4_pr'),
--
('def_standard_large_core_battery_pr', 655364, 50856719, 3, 3000, NULL, NULL, '#moduleFlag=i20 #ammoCapacity=i0'),
('def_named1_large_core_battery_pr', 655364, 50856719, 3, 2700, 2, 2, '#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t2_pr'),
('def_named2_large_core_battery_pr', 655364, 50856719, 3, 3000, 2, 3, '#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t3_pr'),
('def_named3_large_core_battery_pr', 655364, 50856719, 3, 3000, 2, 4, '#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t4_pr'),
--
('def_standard_large_core_booster_pr', 409620, 50922255, 2, 1600, NULL, NULL, '#moduleFlag=i20 #ammoCapacity=ia #ammoType=L70a'),
('def_named1_large_core_booster_pr', 409620, 50922255, 2, 1440, 2, 2, '#moduleFlag=i20 #ammoCapacity=ia #ammoType=L70a #tier=$tierlevel_t2_pr'),
('def_named2_large_core_booster_pr', 409620, 50922255, 2, 1600, 2, 3, '#moduleFlag=i20 #ammoCapacity=ia #ammoType=L70a #tier=$tierlevel_t3_pr'),
('def_named3_large_core_booster_pr', 409620, 50922255, 2, 1600, 2, 4, '#moduleFlag=i20 #ammoCapacity=ic #ammoType=L70a #tier=$tierlevel_t4_pr');

DROP TABLE IF EXISTS #MODSTATS;
CREATE TABLE #MODSTATS 
(
	defName varchar(100),
	fieldName varchar(100),
	fieldValue float,
);
INSERT INTO #MODSTATS (defName, fieldName, fieldValue) VALUES
('def_standard_large_armor_plate', 'cpu_usage', 60),
('def_standard_large_armor_plate', 'powergrid_usage', 1050),
('def_standard_large_armor_plate', 'armor_max', 4050),
('def_standard_large_armor_plate', 'signature_radius', 3),
('def_standard_large_armor_plate', 'massiveness', 0.144),

('def_standard_large_armor_plate_pr', 'cpu_usage', 60),
('def_standard_large_armor_plate_pr', 'powergrid_usage', 1050),
('def_standard_large_armor_plate_pr', 'armor_max', 4050),
('def_standard_large_armor_plate_pr', 'signature_radius', 3),
('def_standard_large_armor_plate_pr', 'massiveness', 0.144),
--
('def_named1_large_armor_plate', 'cpu_usage', 60),
('def_named1_large_armor_plate', 'powergrid_usage', 840),
('def_named1_large_armor_plate', 'armor_max', 4050),
('def_named1_large_armor_plate', 'signature_radius', 3),
('def_named1_large_armor_plate', 'massiveness', 0.144),
--
('def_named1_large_armor_plate_pr', 'cpu_usage', 60),
('def_named1_large_armor_plate_pr', 'powergrid_usage', 840),
('def_named1_large_armor_plate_pr', 'armor_max', 4050),
('def_named1_large_armor_plate_pr', 'signature_radius', 3),
('def_named1_large_armor_plate_pr', 'massiveness', 0.144),
--
('def_named2_large_armor_plate', 'cpu_usage', 60),
('def_named2_large_armor_plate', 'powergrid_usage', 1050),
('def_named2_large_armor_plate', 'armor_max', 4350),
('def_named2_large_armor_plate', 'signature_radius', 3),
('def_named2_large_armor_plate', 'massiveness', 0.156),
--
('def_named2_large_armor_plate_pr', 'cpu_usage', 60),
('def_named2_large_armor_plate_pr', 'powergrid_usage', 1050),
('def_named2_large_armor_plate_pr', 'armor_max', 4350),
('def_named2_large_armor_plate_pr', 'signature_radius', 3),
('def_named2_large_armor_plate_pr', 'massiveness', 0.156),
--
('def_named3_large_armor_plate', 'cpu_usage', 60),
('def_named3_large_armor_plate', 'powergrid_usage', 1190),
('def_named3_large_armor_plate', 'armor_max', 4725),
('def_named3_large_armor_plate', 'signature_radius', 3),
('def_named3_large_armor_plate', 'massiveness', 0.18),
--
('def_named3_large_armor_plate_pr', 'cpu_usage', 60),
('def_named3_large_armor_plate_pr', 'powergrid_usage', 1190),
('def_named3_large_armor_plate_pr', 'armor_max', 4725),
('def_named3_large_armor_plate_pr', 'signature_radius', 3),
('def_named3_large_armor_plate_pr', 'massiveness', 0.18),
--
('def_standard_large_armor_repairer', 'cpu_usage', 400),
('def_standard_large_armor_repairer', 'powergrid_usage', 1000),
('def_standard_large_armor_repairer', 'armor_repair_amount', 360),
('def_standard_large_armor_repairer', 'core_usage', 495),
('def_standard_large_armor_repairer', 'cycle_time', 15000),

('def_standard_large_armor_repairer_pr', 'cpu_usage', 400),
('def_standard_large_armor_repairer_pr', 'powergrid_usage', 1000),
('def_standard_large_armor_repairer_pr', 'armor_repair_amount', 360),
('def_standard_large_armor_repairer_pr', 'core_usage', 495),
('def_standard_large_armor_repairer_pr', 'cycle_time', 15000),
--
('def_named1_large_armor_repairer', 'cpu_usage', 360),
('def_named1_large_armor_repairer', 'powergrid_usage', 900),
('def_named1_large_armor_repairer', 'armor_repair_amount', 360),
('def_named1_large_armor_repairer', 'core_usage', 362),
('def_named1_large_armor_repairer', 'cycle_time', 15000),
--
('def_named1_large_armor_repairer_pr', 'cpu_usage', 360),
('def_named1_large_armor_repairer_pr', 'powergrid_usage', 900),
('def_named1_large_armor_repairer_pr', 'armor_repair_amount', 360),
('def_named1_large_armor_repairer_pr', 'core_usage', 362),
('def_named1_large_armor_repairer_pr', 'cycle_time', 15000),
--
('def_named2_large_armor_repairer', 'cpu_usage', 440),
('def_named2_large_armor_repairer', 'powergrid_usage', 1100),
('def_named2_large_armor_repairer', 'armor_repair_amount', 410),
('def_named2_large_armor_repairer', 'core_usage', 478.5),
('def_named2_large_armor_repairer', 'cycle_time', 13500),
--
('def_named2_large_armor_repairer_pr', 'cpu_usage', 440),
('def_named2_large_armor_repairer_pr', 'powergrid_usage', 1100),
('def_named2_large_armor_repairer_pr', 'armor_repair_amount', 410),
('def_named2_large_armor_repairer_pr', 'core_usage', 478.5),
('def_named2_large_armor_repairer_pr', 'cycle_time', 13500),
--
('def_named3_large_armor_repairer', 'cpu_usage', 440),
('def_named3_large_armor_repairer', 'powergrid_usage', 1100),
('def_named3_large_armor_repairer', 'armor_repair_amount', 460),
('def_named3_large_armor_repairer', 'core_usage', 495),
('def_named3_large_armor_repairer', 'cycle_time', 12000),
--
('def_named3_large_armor_repairer_pr', 'cpu_usage', 440),
('def_named3_large_armor_repairer_pr', 'powergrid_usage', 1100),
('def_named3_large_armor_repairer_pr', 'armor_repair_amount', 460),
('def_named3_large_armor_repairer_pr', 'core_usage', 495),
('def_named3_large_armor_repairer_pr', 'cycle_time', 12000),
--
('def_standard_large_shield_generator', 'cpu_usage', 325),
('def_standard_large_shield_generator', 'powergrid_usage', 1250),
('def_standard_large_shield_generator', 'core_usage', 30),
('def_standard_large_shield_generator', 'shield_absorbtion', 1.9048),
('def_standard_large_shield_generator', 'shield_radius', 30),
('def_standard_large_shield_generator', 'cycle_time', 10000),

('def_standard_large_shield_generator_pr', 'cpu_usage', 325),
('def_standard_large_shield_generator_pr', 'powergrid_usage', 1250),
('def_standard_large_shield_generator_pr', 'core_usage', 30),
('def_standard_large_shield_generator_pr', 'shield_absorbtion', 1.9048),
('def_standard_large_shield_generator_pr', 'shield_radius', 30),
('def_standard_large_shield_generator_pr', 'cycle_time', 10000),
--
('def_named1_large_shield_generator', 'cpu_usage', 300),
('def_named1_large_shield_generator', 'powergrid_usage', 1125),
('def_named1_large_shield_generator', 'core_usage', 25),
('def_named1_large_shield_generator', 'shield_absorbtion', 1.9048),
('def_named1_large_shield_generator', 'shield_radius', 30),
('def_named1_large_shield_generator', 'cycle_time', 9500),
--
('def_named1_large_shield_generator_pr', 'cpu_usage', 300),
('def_named1_large_shield_generator_pr', 'powergrid_usage', 1125),
('def_named1_large_shield_generator_pr', 'core_usage', 25),
('def_named1_large_shield_generator_pr', 'shield_absorbtion', 1.9048),
('def_named1_large_shield_generator_pr', 'shield_radius', 30),
('def_named1_large_shield_generator_pr', 'cycle_time', 9500),
--
('def_named2_large_shield_generator', 'cpu_usage', 335),
('def_named2_large_shield_generator', 'powergrid_usage', 1350),
('def_named2_large_shield_generator', 'core_usage', 30),
('def_named2_large_shield_generator', 'shield_absorbtion', 2.0),
('def_named2_large_shield_generator', 'shield_radius', 30),
('def_named2_large_shield_generator', 'cycle_time', 7750),
--
('def_named2_large_shield_generator_pr', 'cpu_usage', 335),
('def_named2_large_shield_generator_pr', 'powergrid_usage', 1350),
('def_named2_large_shield_generator_pr', 'core_usage', 30),
('def_named2_large_shield_generator_pr', 'shield_absorbtion', 2.0),
('def_named2_large_shield_generator_pr', 'shield_radius', 30),
('def_named2_large_shield_generator_pr', 'cycle_time', 7750),
--
('def_named3_large_shield_generator', 'cpu_usage', 350),
('def_named3_large_shield_generator', 'powergrid_usage', 1425),
('def_named3_large_shield_generator', 'core_usage', 30),
('def_named3_large_shield_generator', 'shield_absorbtion', 2.105),
('def_named3_large_shield_generator', 'shield_radius', 33),
('def_named3_large_shield_generator', 'cycle_time', 6500),
--
('def_named3_large_shield_generator_pr', 'cpu_usage', 350),
('def_named3_large_shield_generator_pr', 'powergrid_usage', 1425),
('def_named3_large_shield_generator_pr', 'core_usage', 30),
('def_named3_large_shield_generator_pr', 'shield_absorbtion', 2.105),
('def_named3_large_shield_generator_pr', 'shield_radius', 33),
('def_named3_large_shield_generator_pr', 'cycle_time', 6500),
--
('def_standard_large_core_battery', 'cpu_usage', 400),
('def_standard_large_core_battery', 'powergrid_usage', 840),
('def_standard_large_core_battery', 'core_max', 1125),

('def_standard_large_core_battery_pr', 'cpu_usage', 400),
('def_standard_large_core_battery_pr', 'powergrid_usage', 840),
('def_standard_large_core_battery_pr', 'core_max', 1125),
--
('def_named1_large_core_battery', 'cpu_usage', 360),
('def_named1_large_core_battery', 'powergrid_usage', 800),
('def_named1_large_core_battery', 'core_max', 1125),
--
('def_named1_large_core_battery_pr', 'cpu_usage', 360),
('def_named1_large_core_battery_pr', 'powergrid_usage', 800),
('def_named1_large_core_battery_pr', 'core_max', 1125),
--
('def_named2_large_core_battery', 'cpu_usage', 430),
('def_named2_large_core_battery', 'powergrid_usage', 856),
('def_named2_large_core_battery', 'core_max', 1200),
--
('def_named2_large_core_battery_pr', 'cpu_usage', 430),
('def_named2_large_core_battery_pr', 'powergrid_usage', 856),
('def_named2_large_core_battery_pr', 'core_max', 1200),
--
('def_named3_large_core_battery', 'cpu_usage', 460),
('def_named3_large_core_battery', 'powergrid_usage', 872),
('def_named3_large_core_battery', 'core_max', 1290),
--
('def_named3_large_core_battery_pr', 'cpu_usage', 460),
('def_named3_large_core_battery_pr', 'powergrid_usage', 872),
('def_named3_large_core_battery_pr', 'core_max', 1290),
--
('def_standard_large_core_booster', 'cpu_usage', 375),
('def_standard_large_core_booster', 'powergrid_usage', 1250),
('def_standard_large_core_booster', 'core_usage', 0),
('def_standard_large_core_booster', 'cycle_time', 6050),

('def_standard_large_core_booster_pr', 'cpu_usage', 375),
('def_standard_large_core_booster_pr', 'powergrid_usage', 1250),
('def_standard_large_core_booster_pr', 'core_usage', 0),
('def_standard_large_core_booster_pr', 'cycle_time', 6050),
--
('def_named1_large_core_booster', 'cpu_usage', 345),
('def_named1_large_core_booster', 'powergrid_usage', 1125),
('def_named1_large_core_booster', 'core_usage', 0),
('def_named1_large_core_booster', 'cycle_time', 6050),
--
('def_named1_large_core_booster_pr', 'cpu_usage', 345),
('def_named1_large_core_booster_pr', 'powergrid_usage', 1125),
('def_named1_large_core_booster_pr', 'core_usage', 0),
('def_named1_large_core_booster_pr', 'cycle_time', 6050),
--
('def_named2_large_core_booster', 'cpu_usage', 375),
('def_named2_large_core_booster', 'powergrid_usage', 1375),
('def_named2_large_core_booster', 'core_usage', 0),
('def_named2_large_core_booster', 'cycle_time', 5500),
--
('def_named2_large_core_booster_pr', 'cpu_usage', 375),
('def_named2_large_core_booster_pr', 'powergrid_usage', 1375),
('def_named2_large_core_booster_pr', 'core_usage', 0),
('def_named2_large_core_booster_pr', 'cycle_time', 5500),
--
('def_named3_large_core_booster', 'cpu_usage', 405),
('def_named3_large_core_booster', 'powergrid_usage', 1500),
('def_named3_large_core_booster', 'core_usage', 0),
('def_named3_large_core_booster', 'cycle_time', 4400),
--
('def_named3_large_core_booster_pr', 'cpu_usage', 405),
('def_named3_large_core_booster_pr', 'powergrid_usage', 1500),
('def_named3_large_core_booster_pr', 'core_usage', 0),
('def_named3_large_core_booster_pr', 'cycle_time', 4400);


DROP TABLE IF EXISTS #ENABLESKILLS
CREATE TABLE #ENABLESKILLS 
(
	modName VARCHAR(100),
	extName VARCHAR(100),
	level INT
);
INSERT INTO #ENABLESKILLS (modName, extName, level) VALUES
('def_standard_large_armor_plate', 'ext_mechanic', 3),
('def_standard_large_armor_plate_pr', 'ext_mechanic', 3),
('def_named1_large_armor_plate', 'ext_mechanic', 3),
('def_named1_large_armor_plate_pr', 'ext_mechanic', 3),
('def_named2_large_armor_plate', 'ext_mechanic', 3),
('def_named2_large_armor_plate_pr', 'ext_mechanic', 3),
('def_named3_large_armor_plate', 'ext_mechanic', 3),
('def_named3_large_armor_plate_pr', 'ext_mechanic', 3),
--
('def_standard_large_armor_repairer', 'ext_repair_systems', 3),
('def_standard_large_armor_repairer_pr', 'ext_repair_systems', 3),
('def_named1_large_armor_repairer', 'ext_repair_systems', 3),
('def_named1_large_armor_repairer_pr', 'ext_repair_systems', 3),
('def_named2_large_armor_repairer', 'ext_repair_systems', 3),
('def_named2_large_armor_repairer_pr', 'ext_repair_systems', 3),
('def_named3_large_armor_repairer', 'ext_repair_systems', 3),
('def_named3_large_armor_repairer_pr', 'ext_repair_systems', 3),
--
('def_standard_large_shield_generator', 'ext_shield_operation', 4),
('def_standard_large_shield_generator_pr', 'ext_shield_operation', 4),
('def_named1_large_shield_generator', 'ext_shield_operation', 4),
('def_named1_large_shield_generator_pr', 'ext_shield_operation', 4),
('def_named2_large_shield_generator', 'ext_shield_operation', 4),
('def_named2_large_shield_generator_pr', 'ext_shield_operation', 4),
('def_named3_large_shield_generator', 'ext_shield_operation', 4),
('def_named3_large_shield_generator_pr', 'ext_shield_operation', 4),

('def_standard_large_shield_generator', 'ext_shield_upgrades', 3),
('def_standard_large_shield_generator_pr', 'ext_shield_upgrades', 3),
('def_named1_large_shield_generator', 'ext_shield_upgrades', 3),
('def_named1_large_shield_generator_pr', 'ext_shield_upgrades', 3),
('def_named2_large_shield_generator', 'ext_shield_upgrades', 3),
('def_named2_large_shield_generator_pr', 'ext_shield_upgrades', 3),
('def_named3_large_shield_generator', 'ext_shield_upgrades', 3),
('def_named3_large_shield_generator_pr', 'ext_shield_upgrades', 3),
--
('def_standard_large_core_battery', 'ext_core_management', 4),
('def_standard_large_core_battery_pr', 'ext_core_management', 4),
('def_named1_large_core_battery', 'ext_core_management', 4),
('def_named1_large_core_battery_pr', 'ext_core_management', 4),
('def_named2_large_core_battery', 'ext_core_management', 4),
('def_named2_large_core_battery_pr', 'ext_core_management', 4),
('def_named3_large_core_battery', 'ext_core_management', 4),
('def_named3_large_core_battery_pr', 'ext_core_management', 4),
--
('def_standard_large_core_booster', 'ext_engineering',5),
('def_standard_large_core_booster_pr', 'ext_engineering',5),
('def_named1_large_core_booster', 'ext_engineering', 5),
('def_named1_large_core_booster_pr', 'ext_engineering', 5),
('def_named2_large_core_booster', 'ext_engineering', 5),
('def_named2_large_core_booster_pr', 'ext_engineering', 5),
('def_named3_large_core_booster', 'ext_engineering', 5),
('def_named3_large_core_booster_pr', 'ext_engineering', 5),

('def_standard_large_core_booster', 'ext_energy_systems_operation',3),
('def_standard_large_core_booster_pr', 'ext_energy_systems_operation',3),
('def_named1_large_core_booster', 'ext_energy_systems_operation', 3),
('def_named1_large_core_booster_pr', 'ext_energy_systems_operation', 3),
('def_named2_large_core_booster', 'ext_energy_systems_operation', 3),
('def_named2_large_core_booster_pr', 'ext_energy_systems_operation', 3),
('def_named3_large_core_booster', 'ext_energy_systems_operation', 3),
('def_named3_large_core_booster_pr', 'ext_energy_systems_operation', 3);


DROP TABLE IF EXISTS #UNIQ_CAT_FLAGS;
CREATE TABLE #UNIQ_CAT_FLAGS
(
	catFlags bigint
);
INSERT INTO #UNIQ_CAT_FLAGS (catFlags) SELECT DISTINCT catFlags FROM #LARGEMODS;

PRINT N'UN-HIDE WEAPON CATEGORIES';
UPDATE categoryFlags SET
  hidden=0
WHERE value in (SELECT catFlags from #UNIQ_CAT_FLAGS);


PRINT N'UPDATE/INSERT ENTITY DEFS FOR LARGE modules + protos';
--Update/insert [entitydefaults] entries
MERGE [dbo].[entitydefaults] def USING #LARGEMODS module
ON def.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=module.defName)
WHEN MATCHED
    THEN UPDATE SET
		categoryflags=catFlags,
		attributeflags=attrFlags,
		volume=cargoVolume,
		mass=massOfModule,
		tiertype=techType,
		tierlevel=techLevel,
		options=genxyOptStr,
		enabled=1,
		hidden=0,
		purchasable=1,
		descriptiontoken=defName+'_desc'
WHEN NOT MATCHED
    THEN INSERT (definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel) VALUES
	(defName,1,attrFlags,catFlags,genxyOptStr,'large module',1,cargoVolume,massOfModule,0,100,defName+'_desc',1,techType,techLevel);


PRINT N'UPDATE/INSERT WEP Category for production decalibration';
--Update/insert [productiondecalibration] entries
MERGE [dbo].[productiondecalibration] decal USING #UNIQ_CAT_FLAGS mods
ON decal.categoryflag = mods.catFlags
WHEN MATCHED
    THEN UPDATE SET
		distorsionmin=0.003,
		distorsionmax=0.005,
		decrease=1
WHEN NOT MATCHED
    THEN INSERT (categoryflag,distorsionmin,distorsionmax,decrease) VALUES
	(mods.catFlags, 0.003,0.005,1);

DROP TABLE IF EXISTS #UNIQ_CAT_FLAGS;

DROP TABLE IF EXISTS #PROD_DURATION_MOD;
CREATE TABLE #PROD_DURATION_MOD 
(
	catFlags BIGINT,
	modifier float
);
INSERT INTO #PROD_DURATION_MOD (catFlags, modifier) VALUES
((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_armor_plates'), 1.5),
((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_armor_repairers'), 1.5),
((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_core_batteries'), 1.5),
((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_core_boosters'), 1.5),
((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_shield_generators'), 2);


PRINT N'UPDATE/INSERT WEP Category for production duration';
--Update/insert [productionduration] entries
MERGE [dbo].[productionduration] dur USING #PROD_DURATION_MOD mods
ON dur.category = mods.catFlags
WHEN MATCHED
    THEN UPDATE SET
		durationmodifier=mods.modifier
WHEN NOT MATCHED
    THEN INSERT (category,durationmodifier) VALUES
	(mods.catFlags, mods.modifier);

DROP TABLE IF EXISTS #PROD_DURATION_MOD;



PRINT N'PRINT OLD STATS';
SELECT definitionname, field, value FROM aggregatevalues as a
JOIN entitydefaults AS e ON e.definition=a.definition
WHERE a.definition IN (SELECT definition FROM entitydefaults WHERE definitionname IN (SELECT DISTINCT defName FROM #MODSTATS));

PRINT N'DELETE OLD STATS';
DELETE FROM aggregatevalues WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #MODSTATS));

PRINT N'INSERT NEW STATS';
INSERT INTO aggregatevalues (definition, field, value)
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defName), 
	(SELECT TOP 1 id FROM aggregatefields WHERE name=fieldName), 
	fieldValue 
FROM #MODSTATS 


--DELETE and REINSERT
PRINT N'DELETE MODULE REQ-EXTENSIONS';
SELECT * FROM enablerextensions WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT modName FROM #ENABLESKILLS));
DELETE FROM enablerextensions WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT modName FROM #ENABLESKILLS));
PRINT N'INSERT MODULE REQ-EXTENSIONS';
INSERT INTO [dbo].[enablerextensions] ([definition],[extensionid],[extensionlevel]) 
SELECT (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname= modName),
	(SELECT TOP 1 extensionid FROM extensions WHERE extensionname = extName),
	level
FROM #ENABLESKILLS;


PRINT N'Enable skills that are required to operate the MODULE';
UPDATE extensions SET
	hidden=0, active=1
WHERE extensionname in (SELECT DISTINCT extName FROM #ENABLESKILLS);



PRINT N'CREATE [modulepropertymodifiers] entries for large modules';
PRINT N'Delete existing to avoid duplicates';
DELETE FROM [dbo].[modulepropertymodifiers] WHERE categoryflags in (
(SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_armor_plates'),
(SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_armor_repairers'),
(SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_core_batteries'),
(SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_core_boosters'),
(SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_shield_generators'));

PRINT N'INSERT [modulepropertymodifiers] for large weapon damage, cpu, and powergrid effects';
INSERT INTO [dbo].[modulepropertymodifiers] ([categoryflags],[basefield],[modifierfield]) VALUES
--PLATES
((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_armor_plates'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='powergrid_usage'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='powergrid_usage_armor_modifier')),
--
((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_armor_plates'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='cpu_usage'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='cpu_usage_armor_modifier')),
--Armor Rep
((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_armor_repairers'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='cpu_usage'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='cpu_usage_armor_modifier')),
--
((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_armor_repairers'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='core_usage'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='core_usage_armor_repair_modifier')),
--
((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_armor_repairers'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='armor_repair_amount'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='armor_repair_amount_modifier')),
--
((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_armor_repairers'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='cycle_time'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='armor_repair_cycle_time_modifier')),
--
((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_armor_repairers'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='powergrid_usage'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='powergrid_usage_armor_modifier')),
--CORE BATTERY
((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_core_batteries'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='powergrid_usage'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='powergrid_usage_engineering_modifier')),
--
((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_core_batteries'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='cpu_usage'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='cpu_usage_engineering_modifier')),
--BOOSTERS
((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_core_boosters'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='cpu_usage'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='cpu_usage_engineering_modifier')),
--
((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_core_boosters'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='cycle_time'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='engineering_cycle_time_modifier')),
--
((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_core_boosters'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='powergrid_usage'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='powergrid_usage_engineering_modifier')),
--SHEILD
((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_shield_generators'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='powergrid_usage'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='powergrid_usage_engineering_modifier')),
--
((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_shield_generators'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='cycle_time'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='shield_cycle_time_modifier')),
--
((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_shield_generators'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='shield_absorbtion'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='shield_absorbtion_modifier')),
--
((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_shield_generators'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='cpu_usage'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='cpu_usage_shield_generators_modifier')),
--
((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_shield_generators'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='core_usage'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='core_usage_shield_generator_modifier'));

DROP TABLE IF EXISTS #ENABLESKILLS;
DROP TABLE IF EXISTS #LARGEMODS;
DROP TABLE IF EXISTS #MODSTATS;
PRINT N'LARGE MODULES SET';
GO



PRINT N'MODULE PROTOTYPE PAIRINGS';

DROP TABLE IF EXISTS #PROTOPAIRS;
CREATE TABLE #PROTOPAIRS
(
	defName varchar(100),
	protoDefName varchar(100),
);

INSERT INTO #PROTOPAIRS (defName, protoDefName) VALUES
('def_standard_large_armor_plate','def_standard_large_armor_plate_pr'),
('def_named1_large_armor_plate','def_named1_large_armor_plate_pr'),
('def_named2_large_armor_plate','def_named2_large_armor_plate_pr'),
('def_named3_large_armor_plate','def_named3_large_armor_plate_pr'),
--
('def_standard_large_armor_repairer','def_standard_large_armor_repairer_pr'),
('def_named1_large_armor_repairer','def_named1_large_armor_repairer_pr'),
('def_named2_large_armor_repairer','def_named2_large_armor_repairer_pr'),
('def_named3_large_armor_repairer','def_named3_large_armor_repairer_pr'),
--
('def_standard_large_shield_generator','def_standard_large_shield_generator_pr'),
('def_named1_large_shield_generator','def_named1_large_shield_generator_pr'),
('def_named2_large_shield_generator','def_named2_large_shield_generator_pr'),
('def_named3_large_shield_generator','def_named3_large_shield_generator_pr'),
--
('def_standard_large_core_battery','def_standard_large_core_battery_pr'),
('def_named1_large_core_battery','def_named1_large_core_battery_pr'),
('def_named2_large_core_battery','def_named2_large_core_battery_pr'),
('def_named3_large_core_battery','def_named3_large_core_battery_pr'),
--
('def_standard_large_core_booster','def_standard_large_core_booster_pr'),
('def_named1_large_core_booster','def_named1_large_core_booster_pr'),
('def_named2_large_core_booster','def_named2_large_core_booster_pr'),
('def_named3_large_core_booster','def_named3_large_core_booster_pr');

--DELETE and reinsert
PRINT N'DELETE prototypes FOR ANY EXISTING LARGE MOD-PROTO PAIRS (0 results if first run)';
SELECT * FROM prototypes WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT defName FROM #PROTOPAIRS));
DELETE FROM prototypes WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT defName FROM #PROTOPAIRS));

--INSERT
PRINT N'INSERT prototypes FOR LARGE MOD-PROTO PAIRS';
INSERT INTO prototypes (definition, prototype)
SELECT (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = defName), 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = protoDefName)
FROM #PROTOPAIRS;
DROP TABLE IF EXISTS #PROTOPAIRS;
GO



PRINT N'MODULE PRODUCTION';

DROP TABLE IF EXISTS #MOD_COMPS;
CREATE TABLE #MOD_COMPS
(
	defName VARCHAR(100),
	commodityName VARCHAR(100),
	amount INT
);
INSERT INTO #MOD_COMPS (defName, commodityName, amount) VALUES
('def_standard_large_armor_plate', 'def_titanium', 750),
('def_standard_large_armor_plate', 'def_plasteosine', 1050),
('def_standard_large_armor_plate', 'def_specimen_sap_item_flux', 15),

('def_standard_large_armor_plate_pr', 'def_titanium', 750),
('def_standard_large_armor_plate_pr', 'def_plasteosine', 1050),
('def_standard_large_armor_plate_pr', 'def_specimen_sap_item_flux', 15),
--
('def_named1_large_armor_plate', 'def_standard_large_armor_plate', 1),
('def_named1_large_armor_plate', 'def_robotshard_common_basic', 90),
('def_named1_large_armor_plate', 'def_titanium', 750),
('def_named1_large_armor_plate', 'def_plasteosine', 1050),
('def_named1_large_armor_plate', 'def_specimen_sap_item_flux', 15),
--
('def_named1_large_armor_plate_pr', 'def_standard_large_armor_plate', 1),
('def_named1_large_armor_plate_pr', 'def_robotshard_common_basic', 90),
('def_named1_large_armor_plate_pr', 'def_titanium', 750),
('def_named1_large_armor_plate_pr', 'def_plasteosine', 1050),
('def_named1_large_armor_plate_pr', 'def_specimen_sap_item_flux', 15),
--
('def_named2_large_armor_plate', 'def_named1_large_armor_plate', 1),
('def_named2_large_armor_plate', 'def_robotshard_common_basic', 60),
('def_named2_large_armor_plate', 'def_robotshard_common_advanced', 60),
('def_named2_large_armor_plate', 'def_titanium', 750),
('def_named2_large_armor_plate', 'def_plasteosine', 525),
('def_named2_large_armor_plate', 'def_alligior', 525),
('def_named2_large_armor_plate', 'def_specimen_sap_item_flux', 50),
--
('def_named2_large_armor_plate_pr', 'def_named1_large_armor_plate', 1),
('def_named2_large_armor_plate_pr', 'def_robotshard_common_basic', 60),
('def_named2_large_armor_plate_pr', 'def_robotshard_common_advanced', 60),
('def_named2_large_armor_plate_pr', 'def_titanium', 750),
('def_named2_large_armor_plate_pr', 'def_plasteosine', 525),
('def_named2_large_armor_plate_pr', 'def_alligior', 525),
('def_named2_large_armor_plate_pr', 'def_specimen_sap_item_flux', 50),
--
('def_named3_large_armor_plate', 'def_named2_large_armor_plate', 1),
('def_named3_large_armor_plate', 'def_robotshard_common_basic', 45),
('def_named3_large_armor_plate', 'def_robotshard_common_advanced', 90),
('def_named3_large_armor_plate', 'def_robotshard_common_expert', 135),
('def_named3_large_armor_plate', 'def_titanium', 750),
('def_named3_large_armor_plate', 'def_plasteosine', 1050),
('def_named3_large_armor_plate', 'def_alligior', 1050),
('def_named3_large_armor_plate', 'def_unimetal', 750),
('def_named3_large_armor_plate', 'def_specimen_sap_item_flux', 100),
--
('def_named3_large_armor_plate_pr', 'def_named2_large_armor_plate', 1),
('def_named3_large_armor_plate_pr', 'def_robotshard_common_basic', 45),
('def_named3_large_armor_plate_pr', 'def_robotshard_common_advanced', 90),
('def_named3_large_armor_plate_pr', 'def_robotshard_common_expert', 135),
('def_named3_large_armor_plate_pr', 'def_titanium', 750),
('def_named3_large_armor_plate_pr', 'def_plasteosine', 1050),
('def_named3_large_armor_plate_pr', 'def_alligior', 1050),
('def_named3_large_armor_plate_pr', 'def_unimetal', 750),
('def_named3_large_armor_plate_pr', 'def_specimen_sap_item_flux', 100),
--
('def_standard_large_armor_repairer', 'def_titanium', 150),
('def_standard_large_armor_repairer', 'def_plasteosine', 300),
('def_standard_large_armor_repairer', 'def_axicol', 75),
('def_standard_large_armor_repairer', 'def_statichnol', 300),
('def_standard_large_armor_repairer', 'def_chollonin', 75),
('def_standard_large_armor_repairer', 'def_specimen_sap_item_flux', 10),

('def_standard_large_armor_repairer_pr', 'def_titanium', 150),
('def_standard_large_armor_repairer_pr', 'def_plasteosine', 300),
('def_standard_large_armor_repairer_pr', 'def_axicol', 75),
('def_standard_large_armor_repairer_pr', 'def_statichnol', 300),
('def_standard_large_armor_repairer_pr', 'def_chollonin', 75),
('def_standard_large_armor_repairer_pr', 'def_specimen_sap_item_flux', 10),
--
('def_named1_large_armor_repairer', 'def_standard_large_armor_repairer', 1),
('def_named1_large_armor_repairer', 'def_robotshard_common_basic', 90),
('def_named1_large_armor_repairer', 'def_titanium', 150),
('def_named1_large_armor_repairer', 'def_plasteosine', 300),
('def_named1_large_armor_repairer', 'def_axicol', 75),
('def_named1_large_armor_repairer', 'def_statichnol', 300),
('def_named1_large_armor_repairer', 'def_chollonin', 75),
('def_named1_large_armor_repairer', 'def_specimen_sap_item_flux', 10),
--
('def_named1_large_armor_repairer_pr', 'def_standard_large_armor_repairer', 1),
('def_named1_large_armor_repairer_pr', 'def_robotshard_common_basic', 90),
('def_named1_large_armor_repairer_pr', 'def_titanium', 150),
('def_named1_large_armor_repairer_pr', 'def_plasteosine', 300),
('def_named1_large_armor_repairer_pr', 'def_axicol', 75),
('def_named1_large_armor_repairer_pr', 'def_statichnol', 300),
('def_named1_large_armor_repairer_pr', 'def_chollonin', 75),
('def_named1_large_armor_repairer_pr', 'def_specimen_sap_item_flux', 10),
--
('def_named2_large_armor_repairer', 'def_named1_large_armor_repairer', 1),
('def_named2_large_armor_repairer', 'def_robotshard_common_basic', 60),
('def_named2_large_armor_repairer', 'def_robotshard_common_advanced', 60),
('def_named2_large_armor_repairer', 'def_titanium', 150),
('def_named2_large_armor_repairer', 'def_alligior', 300),
('def_named2_large_armor_repairer', 'def_espitium', 75),
('def_named2_large_armor_repairer', 'def_statichnol', 300),
('def_named2_large_armor_repairer', 'def_chollonin', 75),
('def_named2_large_armor_repairer', 'def_specimen_sap_item_flux', 30),
--
('def_named2_large_armor_repairer_pr', 'def_named1_large_armor_repairer', 1),
('def_named2_large_armor_repairer_pr', 'def_robotshard_common_basic', 60),
('def_named2_large_armor_repairer_pr', 'def_robotshard_common_advanced', 60),
('def_named2_large_armor_repairer_pr', 'def_titanium', 150),
('def_named2_large_armor_repairer_pr', 'def_alligior', 300),
('def_named2_large_armor_repairer_pr', 'def_espitium', 75),
('def_named2_large_armor_repairer_pr', 'def_statichnol', 300),
('def_named2_large_armor_repairer_pr', 'def_chollonin', 75),
('def_named2_large_armor_repairer_pr', 'def_specimen_sap_item_flux', 30),
--
('def_named3_large_armor_repairer', 'def_named2_large_armor_repairer', 1),
('def_named3_large_armor_repairer', 'def_robotshard_common_basic', 45),
('def_named3_large_armor_repairer', 'def_robotshard_common_advanced', 90),
('def_named3_large_armor_repairer', 'def_robotshard_common_expert', 135),
('def_named3_large_armor_repairer', 'def_alligior', 600),
('def_named3_large_armor_repairer', 'def_espitium', 150),
('def_named3_large_armor_repairer', 'def_statichnol', 600),
('def_named3_large_armor_repairer', 'def_chollonin', 150),
('def_named3_large_armor_repairer', 'def_unimetal', 300),
('def_named3_large_armor_repairer', 'def_specimen_sap_item_flux', 60),
--
('def_named3_large_armor_repairer_pr', 'def_named2_large_armor_repairer', 1),
('def_named3_large_armor_repairer_pr', 'def_robotshard_common_basic', 45),
('def_named3_large_armor_repairer_pr', 'def_robotshard_common_advanced', 90),
('def_named3_large_armor_repairer_pr', 'def_robotshard_common_expert', 135),
('def_named3_large_armor_repairer_pr', 'def_alligior', 600),
('def_named3_large_armor_repairer_pr', 'def_espitium', 150),
('def_named3_large_armor_repairer_pr', 'def_statichnol', 600),
('def_named3_large_armor_repairer_pr', 'def_chollonin', 150),
('def_named3_large_armor_repairer_pr', 'def_unimetal', 300),
('def_named3_large_armor_repairer_pr', 'def_specimen_sap_item_flux', 60),
--
('def_standard_large_shield_generator', 'def_titanium', 300),
('def_standard_large_shield_generator', 'def_plasteosine', 600),
('def_standard_large_shield_generator', 'def_axicol', 300),
('def_standard_large_shield_generator', 'def_isopropentol', 600),
('def_standard_large_shield_generator', 'def_vitricyl', 300),
('def_standard_large_shield_generator', 'def_specimen_sap_item_flux', 25),

('def_standard_large_shield_generator_pr', 'def_titanium', 300),
('def_standard_large_shield_generator_pr', 'def_plasteosine', 600),
('def_standard_large_shield_generator_pr', 'def_axicol', 300),
('def_standard_large_shield_generator_pr', 'def_isopropentol', 600),
('def_standard_large_shield_generator_pr', 'def_vitricyl', 300),
('def_standard_large_shield_generator_pr', 'def_specimen_sap_item_flux', 25),
--
('def_named1_large_shield_generator', 'def_standard_large_shield_generator', 1),
('def_named1_large_shield_generator', 'def_robotshard_common_basic', 90),
('def_named1_large_shield_generator', 'def_titanium', 300),
('def_named1_large_shield_generator', 'def_plasteosine', 600),
('def_named1_large_shield_generator', 'def_axicol', 300),
('def_named1_large_shield_generator', 'def_isopropentol', 600),
('def_named1_large_shield_generator', 'def_vitricyl', 300),
('def_named1_large_shield_generator', 'def_specimen_sap_item_flux', 25),
--
('def_named1_large_shield_generator_pr', 'def_standard_large_shield_generator', 1),
('def_named1_large_shield_generator_pr', 'def_robotshard_common_basic', 90),
('def_named1_large_shield_generator_pr', 'def_titanium', 300),
('def_named1_large_shield_generator_pr', 'def_plasteosine', 600),
('def_named1_large_shield_generator_pr', 'def_axicol', 300),
('def_named1_large_shield_generator_pr', 'def_isopropentol', 600),
('def_named1_large_shield_generator_pr', 'def_vitricyl', 300),
('def_named1_large_shield_generator_pr', 'def_specimen_sap_item_flux', 25),
--
('def_named2_large_shield_generator', 'def_named1_large_shield_generator', 1),
('def_named2_large_shield_generator', 'def_robotshard_common_basic', 60),
('def_named2_large_shield_generator', 'def_robotshard_common_advanced', 60),
('def_named2_large_shield_generator', 'def_titanium', 300),
('def_named2_large_shield_generator', 'def_alligior', 600),
('def_named2_large_shield_generator', 'def_espitium', 300),
('def_named2_large_shield_generator', 'def_isopropentol', 600),
('def_named2_large_shield_generator', 'def_vitricyl', 300),
('def_named2_large_shield_generator', 'def_specimen_sap_item_flux', 75),
--
('def_named2_large_shield_generator_pr', 'def_named1_large_shield_generator', 1),
('def_named2_large_shield_generator_pr', 'def_robotshard_common_basic', 60),
('def_named2_large_shield_generator_pr', 'def_robotshard_common_advanced', 60),
('def_named2_large_shield_generator_pr', 'def_titanium', 300),
('def_named2_large_shield_generator_pr', 'def_alligior', 600),
('def_named2_large_shield_generator_pr', 'def_espitium', 300),
('def_named2_large_shield_generator_pr', 'def_isopropentol', 600),
('def_named2_large_shield_generator_pr', 'def_vitricyl', 300),
('def_named2_large_shield_generator_pr', 'def_specimen_sap_item_flux', 75),
--
('def_named3_large_shield_generator', 'def_named2_large_shield_generator', 1),
('def_named3_large_shield_generator', 'def_robotshard_common_basic', 45),
('def_named3_large_shield_generator', 'def_robotshard_common_advanced', 90),
('def_named3_large_shield_generator', 'def_robotshard_common_expert', 135),
('def_named3_large_shield_generator', 'def_alligior', 1200),
('def_named3_large_shield_generator', 'def_espitium', 600),
('def_named3_large_shield_generator', 'def_isopropentol', 1200),
('def_named3_large_shield_generator', 'def_vitricyl', 600),
('def_named3_large_shield_generator', 'def_unimetal', 600),
('def_named3_large_shield_generator', 'def_specimen_sap_item_flux', 150),
--
('def_named3_large_shield_generator_pr', 'def_named2_large_shield_generator', 1),
('def_named3_large_shield_generator_pr', 'def_robotshard_common_basic', 45),
('def_named3_large_shield_generator_pr', 'def_robotshard_common_advanced', 90),
('def_named3_large_shield_generator_pr', 'def_robotshard_common_expert', 135),
('def_named3_large_shield_generator_pr', 'def_alligior', 1200),
('def_named3_large_shield_generator_pr', 'def_espitium', 600),
('def_named3_large_shield_generator_pr', 'def_isopropentol', 1200),
('def_named3_large_shield_generator_pr', 'def_vitricyl', 600),
('def_named3_large_shield_generator_pr', 'def_unimetal', 600),
('def_named3_large_shield_generator_pr', 'def_specimen_sap_item_flux', 150),
--
('def_standard_large_core_battery', 'def_titanium', 300),
('def_standard_large_core_battery', 'def_axicol', 600),
('def_standard_large_core_battery', 'def_specimen_sap_item_flux', 10),

('def_standard_large_core_battery_pr', 'def_titanium', 300),
('def_standard_large_core_battery_pr', 'def_axicol', 600),
('def_standard_large_core_battery_pr', 'def_specimen_sap_item_flux', 10),
--
('def_named1_large_core_battery', 'def_standard_large_core_battery', 1),
('def_named1_large_core_battery', 'def_robotshard_common_basic', 90),
('def_named1_large_core_battery', 'def_titanium', 300),
('def_named1_large_core_battery', 'def_axicol', 600),
('def_named1_large_core_battery', 'def_specimen_sap_item_flux', 10),
--
('def_named1_large_core_battery_pr', 'def_standard_large_core_battery', 1),
('def_named1_large_core_battery_pr', 'def_robotshard_common_basic', 90),
('def_named1_large_core_battery_pr', 'def_titanium', 300),
('def_named1_large_core_battery_pr', 'def_axicol', 600),
('def_named1_large_core_battery_pr', 'def_specimen_sap_item_flux', 10),
--
('def_named2_large_core_battery', 'def_named1_large_core_battery', 1),
('def_named2_large_core_battery', 'def_robotshard_common_basic', 60),
('def_named2_large_core_battery', 'def_robotshard_common_advanced', 60),
('def_named2_large_core_battery', 'def_titanium', 300),
('def_named2_large_core_battery', 'def_axicol', 300),
('def_named2_large_core_battery', 'def_espitium', 300),
('def_named2_large_core_battery', 'def_specimen_sap_item_flux', 25),
--
('def_named2_large_core_battery_pr', 'def_named2_large_core_battery', 1),
('def_named2_large_core_battery_pr', 'def_robotshard_common_basic', 60),
('def_named2_large_core_battery_pr', 'def_robotshard_common_advanced', 60),
('def_named2_large_core_battery_pr', 'def_titanium', 300),
('def_named2_large_core_battery_pr', 'def_axicol', 300),
('def_named2_large_core_battery_pr', 'def_espitium', 300),
('def_named2_large_core_battery_pr', 'def_specimen_sap_item_flux', 25),
--
('def_named3_large_core_battery', 'def_named2_large_core_battery', 1),
('def_named3_large_core_battery', 'def_robotshard_common_basic', 45),
('def_named3_large_core_battery', 'def_robotshard_common_advanced', 90),
('def_named3_large_core_battery', 'def_robotshard_common_expert', 135),
('def_named3_large_core_battery', 'def_titanium', 300),
('def_named3_large_core_battery', 'def_axicol', 600),
('def_named3_large_core_battery', 'def_espitium', 600),
('def_named3_large_core_battery', 'def_unimetal', 300),
('def_named3_large_core_battery', 'def_specimen_sap_item_flux', 50),
--
('def_named3_large_core_battery_pr', 'def_named2_large_core_battery', 1),
('def_named3_large_core_battery_pr', 'def_robotshard_common_basic', 45),
('def_named3_large_core_battery_pr', 'def_robotshard_common_advanced', 90),
('def_named3_large_core_battery_pr', 'def_robotshard_common_expert', 135),
('def_named3_large_core_battery_pr', 'def_titanium', 300),
('def_named3_large_core_battery_pr', 'def_axicol', 600),
('def_named3_large_core_battery_pr', 'def_espitium', 600),
('def_named3_large_core_battery_pr', 'def_unimetal', 300),
('def_named3_large_core_battery_pr', 'def_specimen_sap_item_flux', 50),
--
('def_standard_large_core_booster', 'def_titanium', 300),
('def_standard_large_core_booster', 'def_axicol', 600),
('def_standard_large_core_booster', 'def_specimen_sap_item_flux', 5),

('def_standard_large_core_booster_pr', 'def_titanium', 300),
('def_standard_large_core_booster_pr', 'def_axicol', 600),
('def_standard_large_core_booster_pr', 'def_specimen_sap_item_flux', 5),
--
('def_named1_large_core_booster', 'def_standard_large_core_booster', 1),
('def_named1_large_core_booster', 'def_robotshard_common_basic', 90),
('def_named1_large_core_booster', 'def_titanium', 300),
('def_named1_large_core_booster', 'def_axicol', 600),
('def_named1_large_core_booster', 'def_specimen_sap_item_flux', 5),
--
('def_named1_large_core_booster_pr', 'def_standard_large_core_booster', 1),
('def_named1_large_core_booster_pr', 'def_robotshard_common_basic', 90),
('def_named1_large_core_booster_pr', 'def_titanium', 300),
('def_named1_large_core_booster_pr', 'def_axicol', 600),
('def_named1_large_core_booster_pr', 'def_specimen_sap_item_flux', 5),
--
('def_named2_large_core_booster', 'def_named1_large_core_booster', 1),
('def_named2_large_core_booster', 'def_robotshard_common_basic', 60),
('def_named2_large_core_booster', 'def_robotshard_common_advanced', 60),
('def_named2_large_core_booster', 'def_axicol', 150),
('def_named2_large_core_booster', 'def_espitium', 150),
('def_named2_large_core_booster', 'def_specimen_sap_item_flux', 15),
--
('def_named2_large_core_booster_pr', 'def_named1_large_core_booster', 1),
('def_named2_large_core_booster_pr', 'def_robotshard_common_basic', 60),
('def_named2_large_core_booster_pr', 'def_robotshard_common_advanced', 60),
('def_named2_large_core_booster_pr', 'def_axicol', 150),
('def_named2_large_core_booster_pr', 'def_espitium', 150),
('def_named2_large_core_booster_pr', 'def_specimen_sap_item_flux', 15),
--
('def_named3_large_core_booster', 'def_named2_large_core_booster', 1),
('def_named3_large_core_booster', 'def_robotshard_common_basic', 45),
('def_named3_large_core_booster', 'def_robotshard_common_advanced', 90),
('def_named3_large_core_booster', 'def_robotshard_common_expert', 135),
('def_named3_large_core_booster', 'def_titanium', 300),
('def_named3_large_core_booster', 'def_axicol', 300),
('def_named3_large_core_booster', 'def_espitium', 300),
('def_named3_large_core_booster', 'def_unimetal', 300),
('def_named3_large_core_booster', 'def_specimen_sap_item_flux', 30),
--
('def_named3_large_core_booster_pr', 'def_named2_large_core_booster', 1),
('def_named3_large_core_booster_pr', 'def_robotshard_common_basic', 45),
('def_named3_large_core_booster_pr', 'def_robotshard_common_advanced', 90),
('def_named3_large_core_booster_pr', 'def_robotshard_common_expert', 135),
('def_named3_large_core_booster_pr', 'def_titanium', 300),
('def_named3_large_core_booster_pr', 'def_axicol', 300),
('def_named3_large_core_booster_pr', 'def_espitium', 300),
('def_named3_large_core_booster_pr', 'def_unimetal', 300),
('def_named3_large_core_booster_pr', 'def_specimen_sap_item_flux', 30);


PRINT N'DELETE components FOR ANY EXISTING LARGE mods (0 results if 1st run)';
SELECT * FROM components WHERE definition IN (SELECT definition FROM entitydefaults WHERE definitionname IN (SELECT DISTINCT defName FROM #MOD_COMPS));
DELETE FROM components WHERE definition IN (SELECT definition FROM entitydefaults WHERE definitionname IN (SELECT DISTINCT defName FROM #MOD_COMPS));

PRINT N'INSERT components FORLARGE mods';
INSERT INTO components (definition, componentdefinition, componentamount)
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defName),
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=commodityName),
	amount
FROM #MOD_COMPS;


DROP TABLE IF EXISTS #MOD_COMPS;
GO


PRINT N'CALIBRATION TEMPLATES FOR MODULES';

DECLARE @armorCTCategory BIGINT;
DECLARE @engineeringCTCategory BIGINT;

SET @armorCTCategory = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_armor_calibration_programs');
SET @engineeringCTCategory = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_engineering_calibration_programs');

DROP TABLE IF EXISTS #MODCTS;
CREATE TABLE #MODCTS 
(
	defName varchar(100),
	catFlags bigint,
	attrFlags bigint,
	cargoVolume float,
	massOfModule float,
	techType int,
	techLevel int,
	genxyOptStr varchar(max),
);

INSERT INTO #MODCTS (defName, attrFlags, catFlags, cargoVolume, massOfModule, techType, techLevel, genxyOptStr) VALUES
('def_standard_large_armor_plate_cprg', 1024, @armorCTCategory, 0.01, 0.1, 1, 1, '#tier=$tierlevel_t1'),
('def_named1_large_armor_plate_cprg', 1024, @armorCTCategory, 0.01, 0.1, 1, 2, '#tier=$tierlevel_t2'),
('def_named2_large_armor_plate_cprg', 1024, @armorCTCategory, 0.01, 0.1, 1, 3, '#tier=$tierlevel_t3'),
('def_named3_large_armor_plate_cprg', 1024, @armorCTCategory, 0.01, 0.1, 1, 4, '#tier=$tierlevel_t4'),
--
('def_standard_large_armor_repairer_cprg', 1024, @armorCTCategory, 0.01, 0.1, 1, 1, '#tier=$tierlevel_t1'),
('def_named1_large_armor_repairer_cprg', 1024, @armorCTCategory, 0.01, 0.1, 1, 2, '#tier=$tierlevel_t2'),
('def_named2_large_armor_repairer_cprg', 1024, @armorCTCategory, 0.01, 0.1, 1, 3, '#tier=$tierlevel_t3'),
('def_named3_large_armor_repairer_cprg', 1024, @armorCTCategory, 0.01, 0.1, 1, 4, '#tier=$tierlevel_t4'),
--
('def_standard_large_shield_generator_cprg', 1024, @engineeringCTCategory, 0.01, 0.1, 1, 1, '#tier=$tierlevel_t1'),
('def_named1_large_shield_generator_cprg', 1024, @engineeringCTCategory, 0.01, 0.1, 1, 2, '#tier=$tierlevel_t2'),
('def_named2_large_shield_generator_cprg', 1024, @engineeringCTCategory, 0.01, 0.1, 1, 3, '#tier=$tierlevel_t3'),
('def_named3_large_shield_generator_cprg', 1024, @engineeringCTCategory, 0.01, 0.1, 1, 4, '#tier=$tierlevel_t4'),
--
('def_standard_large_core_battery_cprg', 1024, @engineeringCTCategory, 0.01, 0.1, 1, 1, '#tier=$tierlevel_t1'),
('def_named1_large_core_battery_cprg', 1024, @engineeringCTCategory, 0.01, 0.1, 1, 2, '#tier=$tierlevel_t2'),
('def_named2_large_core_battery_cprg', 1024, @engineeringCTCategory, 0.01, 0.1, 1, 3, '#tier=$tierlevel_t3'),
('def_named3_large_core_battery_cprg', 1024, @engineeringCTCategory, 0.01, 0.1, 1, 4, '#tier=$tierlevel_t4'),
--
('def_standard_large_core_booster_cprg', 1024, @engineeringCTCategory, 0.01, 0.1, 1, 1, '#tier=$tierlevel_t1'),
('def_named1_large_core_booster_cprg', 1024, @engineeringCTCategory, 0.01, 0.1, 1, 2, '#tier=$tierlevel_t2'),
('def_named2_large_core_booster_cprg', 1024, @engineeringCTCategory, 0.01, 0.1, 1, 3, '#tier=$tierlevel_t3'),
('def_named3_large_core_booster_cprg', 1024, @engineeringCTCategory, 0.01, 0.1, 1, 4, '#tier=$tierlevel_t4');


PRINT N'UPDATE/INSERT CTS';
--Update/insert [entitydefaults] entries
MERGE [dbo].[entitydefaults] def USING #MODCTS ct
ON def.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=ct.defName)
WHEN MATCHED
    THEN UPDATE SET
		categoryflags=catFlags,
		attributeflags=attrFlags,
		volume=cargoVolume,
		mass=massOfModule,
		tiertype=techType,
		tierlevel=techLevel,
		options=genxyOptStr,
		enabled=1,
		hidden=0,
		purchasable=0,
		descriptiontoken='calibration_program_desc'
WHEN NOT MATCHED
    THEN INSERT (definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel) VALUES
	(defName, 1, attrFlags,catFlags,genxyOptStr,'CT large weapon',1,cargoVolume,massOfModule,0,100,'calibration_program_desc',0,techType,techLevel);

PRINT N'DELETE calibrationdefaults FOR ANY EXISTING LARGE MOD CTS (0 results if 1st run)';
SELECT * FROM calibrationdefaults WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #MODCTS));
DELETE FROM calibrationdefaults WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #MODCTS));

PRINT N'INSERT calibrationdefaults FOR MOD CTS';
INSERT INTO calibrationdefaults (definition, materialefficiency, timeefficiency)
SELECT (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = defName), 70, 70 FROM #MODCTS;

DROP TABLE IF EXISTS #PROTO_TO_CT;
CREATE TABLE #PROTO_TO_CT
(
	protoDefName VARCHAR(100),
	ctDefName VARCHAR(100),
	level INT
);

INSERT INTO #PROTO_TO_CT (protoDefName, ctDefName, level) VALUES
('def_standard_large_armor_plate_pr', 'def_standard_large_armor_plate_cprg', 4),
('def_named1_large_armor_plate_pr', 'def_named1_large_armor_plate_cprg', 5),
('def_named2_large_armor_plate_pr', 'def_named2_large_armor_plate_cprg', 6),
('def_named3_large_armor_plate_pr', 'def_named3_large_armor_plate_cprg', 7),
--
('def_standard_large_armor_repairer_pr', 'def_standard_large_armor_repairer_cprg', 5),
('def_named1_large_armor_repairer_pr', 'def_named1_large_armor_repairer_cprg', 6),
('def_named2_large_armor_repairer_pr', 'def_named2_large_armor_repairer_cprg', 7),
('def_named3_large_armor_repairer_pr', 'def_named3_large_armor_repairer_cprg', 8),
--
('def_standard_large_shield_generator_pr', 'def_standard_large_shield_generator_cprg', 5),
('def_named1_large_shield_generator_pr', 'def_named1_large_shield_generator_cprg', 6),
('def_named2_large_shield_generator_pr', 'def_named2_large_shield_generator_cprg', 7),
('def_named3_large_shield_generator_pr', 'def_named3_large_shield_generator_cprg', 8),
--
('def_standard_large_core_battery_pr', 'def_standard_large_core_battery_cprg', 5),
('def_named1_large_core_battery_pr', 'def_named1_large_core_battery_cprg', 6),
('def_named2_large_core_battery_pr', 'def_named2_large_core_battery_cprg', 7),
('def_named3_large_core_battery_pr', 'def_named3_large_core_battery_cprg', 8),
--
('def_standard_large_core_booster_pr', 'def_standard_large_core_booster_cprg', 5),
('def_named1_large_core_booster_pr', 'def_named1_large_core_booster_cprg', 6),
('def_named2_large_core_booster_pr', 'def_named2_large_core_booster_cprg', 7),
('def_named3_large_core_booster_pr', 'def_named3_large_core_booster_cprg', 8);


PRINT N'DELETE itemresearchlevels FOR ANY EXISTING LARGE MOD CTS (0 results if 1st run)';
SELECT * FROM itemresearchlevels WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT protoDefName FROM #PROTO_TO_CT));
DELETE FROM itemresearchlevels WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT protoDefName FROM #PROTO_TO_CT));

PRINT N'INSERT itemresearchlevels FOR MOD CTS';
INSERT INTO itemresearchlevels (definition, calibrationprogram, researchlevel, enabled)
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = protoDefName), 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = ctDefName), 
	level, 1
FROM #PROTO_TO_CT;


DROP TABLE IF EXISTS #MODCTS;
DROP TABLE IF EXISTS #PROTO_TO_CT;
GO

PRINT N'05_LARGE_WEAPONS';

USE [perpetuumsa]
GO
----------------------------
--LARGE WEAPONS
--Set stats in entitydefaults and aggregatevalues
--All definitions already in defaults - no inserts for new defs
----------------------------


DROP TABLE IF EXISTS #LARGEWEP;
CREATE TABLE #LARGEWEP 
(
	defName varchar(100),
	catFlags bigint,
	attrFlags bigint,
	cargoVolume float,
	massOfModule float,
	techType int,
	techLevel int,
	genxyOptStr varchar(max),
);
INSERT INTO #LARGEWEP (defName, attrFlags, catFlags, cargoVolume, massOfModule, techType, techLevel, genxyOptStr) VALUES
('def_standard_large_laser', 402128, 50398991, 1.5, 1000, 1, 1, '#moduleFlag=i111 #ammoCapacity=i3c #ammoType=L3020a #tier=$tierlevel_t1'),
('def_named1_large_laser', 402128, 50398991, 1.5, 900, 1, 2, '#moduleFlag=i111 #ammoCapacity=i4b #ammoType=L3020a #tier=$tierlevel_t2'),
('def_named2_large_laser', 402128, 50398991, 1.5, 1000, 1, 3, '#moduleFlag=i111 #ammoCapacity=i4b #ammoType=L3020a #tier=$tierlevel_t3'),
('def_named3_large_laser', 402128, 50398991, 1.5, 1100, 1, 4, '#moduleFlag=i111 #ammoCapacity=i2d #ammoType=L3020a #tier=$tierlevel_t4'),
--
('def_longrange_standard_large_laser', 402128, 50398991, 1.5, 1300, 1, 1, '#moduleFlag=i111 #ammoCapacity=i3c #ammoType=L3020a #tier=$tierlevel_t1'),
('def_named1_longrange_large_laser', 402128, 50398991, 1.5, 1170, 1, 2, '#moduleFlag=i111 #ammoCapacity=i3c #ammoType=L3020a #tier=$tierlevel_t2'),
('def_named2_longrange_large_laser', 402128, 50398991, 1.5, 1300, 1, 3, '#moduleFlag=i111 #ammoCapacity=i3c #ammoType=L3020a #tier=$tierlevel_t3'),
('def_named3_longrange_large_laser', 402128, 50398991, 1.5, 1430, 1, 4, '#moduleFlag=i111 #ammoCapacity=i3c #ammoType=L3020a #tier=$tierlevel_t4'),
--
('def_standard_cruisemissile_launcher', 402128, 50530063, 1.5, 1000, 1, 1, '#moduleFlag=i112 #ammoCapacity=i14 #ammoType=L3040a #tier=$tierlevel_t1'),
('def_named1_cruisemissile_launcher', 402128, 50530063, 1.5, 900, 1, 2, '#moduleFlag=i112 #ammoCapacity=i14 #ammoType=L3040a #tier=$tierlevel_t2'),
('def_named2_cruisemissile_launcher', 402128, 50530063, 1.5, 1000, 1, 3, '#moduleFlag=i112 #ammoCapacity=i14 #ammoType=L3040a #tier=$tierlevel_t3'),
('def_named3_cruisemissile_launcher', 402128, 50530063, 1.5, 1100, 1, 4, '#moduleFlag=i112 #ammoCapacity=i14 #ammoType=L3040a #tier=$tierlevel_t4'),
--
('def_standard_large_railgun', 402128, 50595599, 1.5, 1000, 1, 1, '#moduleFlag=i111 #ammoCapacity=i19 #ammoType=L3010a #tier=$tierlevel_t1'),
('def_named1_large_railgun', 402128, 50595599, 1.5, 900, 1, 2, '#moduleFlag=i111 #ammoCapacity=i1e #ammoType=L3010a #tier=$tierlevel_t2'),
('def_named2_large_railgun', 402128, 50595599, 1.5, 1000, 1, 3, '#moduleFlag=i111 #ammoCapacity=i1e #ammoType=L3010a #tier=$tierlevel_t3'),
('def_named3_large_railgun', 402128, 50595599, 1.5, 1100, 1, 4, '#moduleFlag=i111 #ammoCapacity=i14 #ammoType=L3010a #tier=$tierlevel_t4'),
--
('def_longrange_standard_large_railgun', 402128, 50595599, 1.5, 1300, 1, 1, '#moduleFlag=i111 #ammoCapacity=i19 #ammoType=L3010a #tier=$tierlevel_t1'),
('def_named1_longrange_large_railgun', 402128, 50595599, 1.5, 1170, 1, 2, '#moduleFlag=i111 #ammoCapacity=i19 #ammoType=L3010a #tier=$tierlevel_t2'),
('def_named2_longrange_large_railgun', 402128, 50595599, 1.5, 1300, 1, 3, '#moduleFlag=i111 #ammoCapacity=i19 #ammoType=L3010a #tier=$tierlevel_t3'),
('def_named3_longrange_large_railgun', 402128, 50595599, 1.5, 1430, 1, 4, '#moduleFlag=i111 #ammoCapacity=i19 #ammoType=L3010a #tier=$tierlevel_t4'),
--PROTOTYPES
('def_standard_large_laser_pr', 402128, 50398991, 1.5, 1000, NULL, NULL, ''),
('def_named1_large_laser_pr', 402128, 50398991, 1.5, 900, 2, 2, '#tier=$tierlevel_t2_pr'),
('def_named2_large_laser_pr', 402128, 50398991, 1.5, 1000, 2, 3, '#tier=$tierlevel_t3_pr'),
('def_named3_large_laser_pr', 402128, 50398991, 1.5, 1100, 2, 4, '#tier=$tierlevel_t4_pr'),
--
('def_longrange_standard_large_laser_pr', 402128, 50398991, 1.5, 1300, NULL, NULL, ''),
('def_named1_longrange_large_laser_pr', 402128, 50398991, 1.5, 1170, 2, 2, '#tier=$tierlevel_t2_pr'),
('def_named2_longrange_large_laser_pr', 402128, 50398991, 1.5, 1300, 2, 3, '#tier=$tierlevel_t3_pr'),
('def_named3_longrange_large_laser_pr', 402128, 50398991, 1.5, 1430, 2, 4, '#tier=$tierlevel_t4_pr'),
--
('def_standard_cruisemissile_launcher_pr', 402128, 50530063, 1.5, 1000, NULL, NULL, ''),
('def_named1_cruisemissile_launcher_pr', 402128, 50530063, 1.5, 900, 2, 2, '#tier=$tierlevel_t2_pr'),
('def_named2_cruisemissile_launcher_pr', 402128, 50530063, 1.5, 1000, 2, 3, '#tier=$tierlevel_t3_pr'),
('def_named3_cruisemissile_launcher_pr', 402128, 50530063, 1.5, 1100, 2, 4, '#tier=$tierlevel_t4_pr'),
--
('def_standard_large_railgun_pr', 402128, 50595599, 1.5, 1000, NULL, NULL, ''),
('def_named1_large_railgun_pr', 402128, 50595599, 1.5, 900, 2, 2, '#tier=$tierlevel_t2_pr'),
('def_named2_large_railgun_pr', 402128, 50595599, 1.5, 1000, 2, 3, '#tier=$tierlevel_t3_pr'),
('def_named3_large_railgun_pr', 402128, 50595599, 1.5, 1100, 2, 4, '#tier=$tierlevel_t4_pr'),
--
('def_longrange_standard_large_railgun_pr', 402128, 50595599, 1.5, 1300, NULL, NULL, ''),
('def_named1_longrange_large_railgun_pr', 402128, 50595599, 1.5, 1170, 2, 2, '#tier=$tierlevel_t2_pr'),
('def_named2_longrange_large_railgun_pr', 402128, 50595599, 1.5, 1300, 2, 3, '#tier=$tierlevel_t3_pr'),
('def_named3_longrange_large_railgun_pr', 402128, 50595599, 1.5, 1430, 2, 4, '#tier=$tierlevel_t4_pr');

DROP TABLE IF EXISTS #UNIQ_CAT_FLAGS;
CREATE TABLE #UNIQ_CAT_FLAGS
(
	catFlags bigint
);
INSERT INTO #UNIQ_CAT_FLAGS (catFlags) SELECT DISTINCT catFlags FROM #LARGEWEP;

PRINT N'UN-HIDE WEAPON CATEGORIES';
UPDATE categoryFlags SET
  hidden=0
WHERE value in (SELECT catFlags from #UNIQ_CAT_FLAGS);


PRINT N'UPDATE/INSERT WEP Category for production decalibration';
--Update/insert [productiondecalibration] entries
MERGE [dbo].[productiondecalibration] decal USING #UNIQ_CAT_FLAGS wep
ON decal.categoryflag = wep.catFlags
WHEN MATCHED
    THEN UPDATE SET
		distorsionmin=0.003,
		distorsionmax=0.005,
		decrease=1
WHEN NOT MATCHED
    THEN INSERT (categoryflag,distorsionmin,distorsionmax,decrease) VALUES
	(wep.catFlags, 0.003,0.005,1);

PRINT N'UPDATE/INSERT WEP Category for production duration';
--Update/insert [productionduration] entries
MERGE [dbo].[productionduration] dur USING #UNIQ_CAT_FLAGS wep
ON dur.category = wep.catFlags
WHEN MATCHED
    THEN UPDATE SET
		durationmodifier=3
WHEN NOT MATCHED
    THEN INSERT (category,durationmodifier) VALUES
	(wep.catFlags, 3);


DROP TABLE IF EXISTS #UNIQ_CAT_FLAGS;

DROP TABLE IF EXISTS #WEPSTATS;
CREATE TABLE #WEPSTATS 
(
	defName varchar(100),
	fieldName varchar(100),
	fieldValue float,
);
INSERT INTO #WEPSTATS (defName, fieldName, fieldValue) VALUES
('def_standard_large_laser', 'cpu_usage', 62.5),
('def_standard_large_laser', 'powergrid_usage', 350),
('def_standard_large_laser', 'core_usage', 11.76),
('def_standard_large_laser', 'cycle_time', 5000),
('def_standard_large_laser', 'damage_modifier', 1.91),
('def_standard_large_laser', 'optimal_range', 22.5),
('def_standard_large_laser', 'falloff', 10),
('def_standard_large_laser', 'accuracy', 34.5),

('def_standard_large_laser_pr', 'cpu_usage', 62.5),
('def_standard_large_laser_pr', 'powergrid_usage', 350),
('def_standard_large_laser_pr', 'core_usage', 11.76),
('def_standard_large_laser_pr', 'cycle_time', 5000),
('def_standard_large_laser_pr', 'damage_modifier', 1.91),
('def_standard_large_laser_pr', 'optimal_range', 22.5),
('def_standard_large_laser_pr', 'falloff', 10),
('def_standard_large_laser_pr', 'accuracy', 34.5),

('def_named1_large_laser', 'cpu_usage', 55),
('def_named1_large_laser', 'powergrid_usage', 315),
('def_named1_large_laser', 'core_usage', 9.52),
('def_named1_large_laser', 'cycle_time', 5000),
('def_named1_large_laser', 'damage_modifier', 1.91),
('def_named1_large_laser', 'optimal_range', 22.5),
('def_named1_large_laser', 'falloff', 10),
('def_named1_large_laser', 'accuracy', 34.5),

('def_named1_large_laser_pr', 'cpu_usage', 55),
('def_named1_large_laser_pr', 'powergrid_usage', 315),
('def_named1_large_laser_pr', 'core_usage', 9.52),
('def_named1_large_laser_pr', 'cycle_time', 5000),
('def_named1_large_laser_pr', 'damage_modifier', 1.91),
('def_named1_large_laser_pr', 'optimal_range', 22.5),
('def_named1_large_laser_pr', 'falloff', 10),
('def_named1_large_laser_pr', 'accuracy', 34.5),

('def_named2_large_laser', 'cpu_usage', 70),
('def_named2_large_laser', 'powergrid_usage', 394),
('def_named2_large_laser', 'core_usage', 11.2),
('def_named2_large_laser', 'cycle_time', 4500),
('def_named2_large_laser', 'damage_modifier', 2.07),
('def_named2_large_laser', 'optimal_range', 23.5),
('def_named2_large_laser', 'falloff', 10),
('def_named2_large_laser', 'accuracy', 34.5),

('def_named2_large_laser_pr', 'cpu_usage', 70),
('def_named2_large_laser_pr', 'powergrid_usage', 394),
('def_named2_large_laser_pr', 'core_usage', 11.2),
('def_named2_large_laser_pr', 'cycle_time', 4500),
('def_named2_large_laser_pr', 'damage_modifier', 2.07),
('def_named2_large_laser_pr', 'optimal_range', 23.5),
('def_named2_large_laser_pr', 'falloff', 10),
('def_named2_large_laser_pr', 'accuracy', 34.5),

('def_named3_large_laser', 'cpu_usage', 75),
('def_named3_large_laser', 'powergrid_usage', 437.5),
('def_named3_large_laser', 'core_usage', 13.44),
('def_named3_large_laser', 'cycle_time', 5000),
('def_named3_large_laser', 'damage_modifier', 2.40),
('def_named3_large_laser', 'optimal_range', 24),
('def_named3_large_laser', 'falloff', 10),
('def_named3_large_laser', 'accuracy', 34.5),

('def_named3_large_laser_pr', 'cpu_usage', 75),
('def_named3_large_laser_pr', 'powergrid_usage', 437.5),
('def_named3_large_laser_pr', 'core_usage', 13.44),
('def_named3_large_laser_pr', 'cycle_time', 5000),
('def_named3_large_laser_pr', 'damage_modifier', 2.40),
('def_named3_large_laser_pr', 'optimal_range', 24),
('def_named3_large_laser_pr', 'falloff', 10),
('def_named3_large_laser_pr', 'accuracy', 34.5),
--
('def_longrange_standard_large_laser', 'cpu_usage', 75),
('def_longrange_standard_large_laser', 'powergrid_usage', 402.5),
('def_longrange_standard_large_laser', 'core_usage', 14),
('def_longrange_standard_large_laser', 'cycle_time', 6000),
('def_longrange_standard_large_laser', 'damage_modifier', 1.50),
('def_longrange_standard_large_laser', 'optimal_range', 50),
('def_longrange_standard_large_laser', 'falloff', 25),
('def_longrange_standard_large_laser', 'accuracy', 36),

('def_longrange_standard_large_laser_pr', 'cpu_usage', 75),
('def_longrange_standard_large_laser_pr', 'powergrid_usage', 402.5),
('def_longrange_standard_large_laser_pr', 'core_usage', 14),
('def_longrange_standard_large_laser_pr', 'cycle_time', 6000),
('def_longrange_standard_large_laser_pr', 'damage_modifier', 1.50),
('def_longrange_standard_large_laser_pr', 'optimal_range', 50),
('def_longrange_standard_large_laser_pr', 'falloff', 25),
('def_longrange_standard_large_laser_pr', 'accuracy', 36),

('def_named1_longrange_large_laser', 'cpu_usage', 67.5),
('def_named1_longrange_large_laser', 'powergrid_usage', 367.5),
('def_named1_longrange_large_laser', 'core_usage', 12.32),
('def_named1_longrange_large_laser', 'cycle_time', 6000),
('def_named1_longrange_large_laser', 'damage_modifier', 1.50),
('def_named1_longrange_large_laser', 'optimal_range', 50),
('def_named1_longrange_large_laser', 'falloff', 25),
('def_named1_longrange_large_laser', 'accuracy', 36),

('def_named1_longrange_large_laser_pr', 'cpu_usage', 67.5),
('def_named1_longrange_large_laser_pr', 'powergrid_usage', 367.5),
('def_named1_longrange_large_laser_pr', 'core_usage', 12.32),
('def_named1_longrange_large_laser_pr', 'cycle_time', 6000),
('def_named1_longrange_large_laser_pr', 'damage_modifier', 1.50),
('def_named1_longrange_large_laser_pr', 'optimal_range', 50),
('def_named1_longrange_large_laser_pr', 'falloff', 25),
('def_named1_longrange_large_laser_pr', 'accuracy', 36),

('def_named2_longrange_large_laser', 'cpu_usage', 80),
('def_named2_longrange_large_laser', 'powergrid_usage', 411),
('def_named2_longrange_large_laser', 'core_usage', 14.7),
('def_named2_longrange_large_laser', 'cycle_time', 6000),
('def_named2_longrange_large_laser', 'damage_modifier', 1.88),
('def_named2_longrange_large_laser', 'optimal_range', 51.5),
('def_named2_longrange_large_laser', 'falloff', 25),
('def_named2_longrange_large_laser', 'accuracy', 36),

('def_named2_longrange_large_laser_pr', 'cpu_usage', 80),
('def_named2_longrange_large_laser_pr', 'powergrid_usage', 411),
('def_named2_longrange_large_laser_pr', 'core_usage', 14.7),
('def_named2_longrange_large_laser_pr', 'cycle_time', 6000),
('def_named2_longrange_large_laser_pr', 'damage_modifier', 1.88),
('def_named2_longrange_large_laser_pr', 'optimal_range', 51.5),
('def_named2_longrange_large_laser_pr', 'falloff', 25),
('def_named2_longrange_large_laser_pr', 'accuracy', 36),

('def_named3_longrange_large_laser', 'cpu_usage', 87.5),
('def_named3_longrange_large_laser', 'powergrid_usage', 437.5),
('def_named3_longrange_large_laser', 'core_usage', 16.8),
('def_named3_longrange_large_laser', 'cycle_time', 6000),
('def_named3_longrange_large_laser', 'damage_modifier', 1.95),
('def_named3_longrange_large_laser', 'optimal_range', 52.5),
('def_named3_longrange_large_laser', 'falloff', 25),
('def_named3_longrange_large_laser', 'accuracy', 36),

('def_named3_longrange_large_laser_pr', 'cpu_usage', 87.5),
('def_named3_longrange_large_laser_pr', 'powergrid_usage', 437.5),
('def_named3_longrange_large_laser_pr', 'core_usage', 16.8),
('def_named3_longrange_large_laser_pr', 'cycle_time', 6000),
('def_named3_longrange_large_laser_pr', 'damage_modifier', 1.95),
('def_named3_longrange_large_laser_pr', 'optimal_range', 52.5),
('def_named3_longrange_large_laser_pr', 'falloff', 25),
('def_named3_longrange_large_laser_pr', 'accuracy', 36),
--
('def_standard_large_railgun', 'cpu_usage', 80),
('def_standard_large_railgun', 'powergrid_usage', 225),
('def_standard_large_railgun', 'core_usage', 10.5),
('def_standard_large_railgun', 'cycle_time', 6000),
('def_standard_large_railgun', 'damage_modifier', 2.55),
('def_standard_large_railgun', 'optimal_range', 20),
('def_standard_large_railgun', 'falloff', 7.5),
('def_standard_large_railgun', 'accuracy', 40.5),

('def_standard_large_railgun_pr', 'cpu_usage', 80),
('def_standard_large_railgun_pr', 'powergrid_usage', 225),
('def_standard_large_railgun_pr', 'core_usage', 10.5),
('def_standard_large_railgun_pr', 'cycle_time', 6000),
('def_standard_large_railgun_pr', 'damage_modifier', 2.55),
('def_standard_large_railgun_pr', 'optimal_range', 20),
('def_standard_large_railgun_pr', 'falloff', 7.5),
('def_standard_large_railgun_pr', 'accuracy', 40.5),

('def_named1_large_railgun', 'cpu_usage', 62.5),
('def_named1_large_railgun', 'powergrid_usage', 202.25),
('def_named1_large_railgun', 'core_usage', 8.4),
('def_named1_large_railgun', 'cycle_time', 6000),
('def_named1_large_railgun', 'damage_modifier', 2.55),
('def_named1_large_railgun', 'optimal_range', 20),
('def_named1_large_railgun', 'falloff', 7.5),
('def_named1_large_railgun', 'accuracy', 40.5),

('def_named1_large_railgun_pr', 'cpu_usage', 62.5),
('def_named1_large_railgun_pr', 'powergrid_usage', 202.25),
('def_named1_large_railgun_pr', 'core_usage', 8.4),
('def_named1_large_railgun_pr', 'cycle_time', 6000),
('def_named1_large_railgun_pr', 'damage_modifier', 2.55),
('def_named1_large_railgun_pr', 'optimal_range', 20),
('def_named1_large_railgun_pr', 'falloff', 7.5),
('def_named1_large_railgun_pr', 'accuracy', 40.5),

('def_named2_large_railgun', 'cpu_usage', 87.5),
('def_named2_large_railgun', 'powergrid_usage', 247.5),
('def_named2_large_railgun', 'core_usage', 10.5),
('def_named2_large_railgun', 'cycle_time', 6000),
('def_named2_large_railgun', 'damage_modifier', 3.0),
('def_named2_large_railgun', 'optimal_range', 21.5),
('def_named2_large_railgun', 'falloff', 6),
('def_named2_large_railgun', 'accuracy', 40.5),

('def_named2_large_railgun_pr', 'cpu_usage', 87.5),
('def_named2_large_railgun_pr', 'powergrid_usage', 247.5),
('def_named2_large_railgun_pr', 'core_usage', 10.5),
('def_named2_large_railgun_pr', 'cycle_time', 6000),
('def_named2_large_railgun_pr', 'damage_modifier', 3.0),
('def_named2_large_railgun_pr', 'optimal_range', 21.5),
('def_named2_large_railgun_pr', 'falloff', 6),
('def_named2_large_railgun_pr', 'accuracy', 40.5),

('def_named3_large_railgun', 'cpu_usage', 95),
('def_named3_large_railgun', 'powergrid_usage', 270),
('def_named3_large_railgun', 'core_usage', 14),
('def_named3_large_railgun', 'cycle_time', 8000),
('def_named3_large_railgun', 'damage_modifier', 4.5),
('def_named3_large_railgun', 'optimal_range', 22.5),
('def_named3_large_railgun', 'falloff', 6),
('def_named3_large_railgun', 'accuracy', 40.5),

('def_named3_large_railgun_pr', 'cpu_usage', 95),
('def_named3_large_railgun_pr', 'powergrid_usage', 270),
('def_named3_large_railgun_pr', 'core_usage', 14),
('def_named3_large_railgun_pr', 'cycle_time', 8000),
('def_named3_large_railgun_pr', 'damage_modifier', 4.5),
('def_named3_large_railgun_pr', 'optimal_range', 22.5),
('def_named3_large_railgun_pr', 'falloff', 6),
('def_named3_large_railgun_pr', 'accuracy', 40.5),
--
('def_longrange_standard_large_railgun', 'cpu_usage', 100),
('def_longrange_standard_large_railgun', 'powergrid_usage', 277.5),
('def_longrange_standard_large_railgun', 'core_usage', 18.9),
('def_longrange_standard_large_railgun', 'cycle_time', 10000),
('def_longrange_standard_large_railgun', 'damage_modifier', 3.0),
('def_longrange_standard_large_railgun', 'optimal_range', 44),
('def_longrange_standard_large_railgun', 'falloff', 22.5),
('def_longrange_standard_large_railgun', 'accuracy', 42),

('def_longrange_standard_large_railgun_pr', 'cpu_usage', 100),
('def_longrange_standard_large_railgun_pr', 'powergrid_usage', 277.5),
('def_longrange_standard_large_railgun_pr', 'core_usage', 18.9),
('def_longrange_standard_large_railgun_pr', 'cycle_time', 10000),
('def_longrange_standard_large_railgun_pr', 'damage_modifier', 3.0),
('def_longrange_standard_large_railgun_pr', 'optimal_range', 44),
('def_longrange_standard_large_railgun_pr', 'falloff', 22.5),
('def_longrange_standard_large_railgun_pr', 'accuracy', 42),

('def_named1_longrange_large_railgun', 'cpu_usage', 90),
('def_named1_longrange_large_railgun', 'powergrid_usage', 277.5),
('def_named1_longrange_large_railgun', 'core_usage', 17.5),
('def_named1_longrange_large_railgun', 'cycle_time', 10000),
('def_named1_longrange_large_railgun', 'damage_modifier', 3.0),
('def_named1_longrange_large_railgun', 'optimal_range', 44),
('def_named1_longrange_large_railgun', 'falloff', 22.5),
('def_named1_longrange_large_railgun', 'accuracy', 42),

('def_named1_longrange_large_railgun_pr', 'cpu_usage', 90),
('def_named1_longrange_large_railgun_pr', 'powergrid_usage', 277.5),
('def_named1_longrange_large_railgun_pr', 'core_usage', 17.5),
('def_named1_longrange_large_railgun_pr', 'cycle_time', 10000),
('def_named1_longrange_large_railgun_pr', 'damage_modifier', 3.0),
('def_named1_longrange_large_railgun_pr', 'optimal_range', 44),
('def_named1_longrange_large_railgun_pr', 'falloff', 22.5),
('def_named1_longrange_large_railgun_pr', 'accuracy', 42),

('def_named2_longrange_large_railgun', 'cpu_usage', 107.5),
('def_named2_longrange_large_railgun', 'powergrid_usage', 277.5),
('def_named2_longrange_large_railgun', 'core_usage', 22.4),
('def_named2_longrange_large_railgun', 'cycle_time', 10000),
('def_named2_longrange_large_railgun', 'damage_modifier', 3.75),
('def_named2_longrange_large_railgun', 'optimal_range', 45),
('def_named2_longrange_large_railgun', 'falloff', 21.0),
('def_named2_longrange_large_railgun', 'accuracy', 42),

('def_named2_longrange_large_railgun_pr', 'cpu_usage', 107.5),
('def_named2_longrange_large_railgun_pr', 'powergrid_usage', 277.5),
('def_named2_longrange_large_railgun_pr', 'core_usage', 22.4),
('def_named2_longrange_large_railgun_pr', 'cycle_time', 10000),
('def_named2_longrange_large_railgun_pr', 'damage_modifier', 3.75),
('def_named2_longrange_large_railgun_pr', 'optimal_range', 45),
('def_named2_longrange_large_railgun_pr', 'falloff', 21.0),
('def_named2_longrange_large_railgun_pr', 'accuracy', 42),

('def_named3_longrange_large_railgun', 'cpu_usage', 112.5),
('def_named3_longrange_large_railgun', 'powergrid_usage', 300),
('def_named3_longrange_large_railgun', 'core_usage', 25.2),
('def_named3_longrange_large_railgun', 'cycle_time', 10000),
('def_named3_longrange_large_railgun', 'damage_modifier', 4.05),
('def_named3_longrange_large_railgun', 'optimal_range', 46),
('def_named3_longrange_large_railgun', 'falloff', 21),
('def_named3_longrange_large_railgun', 'accuracy', 42),

('def_named3_longrange_large_railgun_pr', 'cpu_usage', 112.5),
('def_named3_longrange_large_railgun_pr', 'powergrid_usage', 300),
('def_named3_longrange_large_railgun_pr', 'core_usage', 25.2),
('def_named3_longrange_large_railgun_pr', 'cycle_time', 10000),
('def_named3_longrange_large_railgun_pr', 'damage_modifier', 4.05),
('def_named3_longrange_large_railgun_pr', 'optimal_range', 46),
('def_named3_longrange_large_railgun_pr', 'falloff', 21),
('def_named3_longrange_large_railgun_pr', 'accuracy', 42),
--
('def_standard_cruisemissile_launcher', 'cpu_usage', 100),
('def_standard_cruisemissile_launcher', 'powergrid_usage', 225),
('def_standard_cruisemissile_launcher', 'core_usage', 20),
('def_standard_cruisemissile_launcher', 'cycle_time', 14000),
('def_standard_cruisemissile_launcher', 'damage_modifier', 1.3),
('def_standard_cruisemissile_launcher', 'accuracy', 1),

('def_standard_cruisemissile_launcher_pr', 'cpu_usage', 100),
('def_standard_cruisemissile_launcher_pr', 'powergrid_usage', 225),
('def_standard_cruisemissile_launcher_pr', 'core_usage', 20),
('def_standard_cruisemissile_launcher_pr', 'cycle_time', 14000),
('def_standard_cruisemissile_launcher_pr', 'damage_modifier', 1.3),
('def_standard_cruisemissile_launcher_pr', 'accuracy', 1),

('def_named1_cruisemissile_launcher', 'cpu_usage', 90),
('def_named1_cruisemissile_launcher', 'powergrid_usage', 202.5),
('def_named1_cruisemissile_launcher', 'core_usage', 20),
('def_named1_cruisemissile_launcher', 'cycle_time', 14000),
('def_named1_cruisemissile_launcher', 'damage_modifier', 1.3),
('def_named1_cruisemissile_launcher', 'accuracy', 1),

('def_named1_cruisemissile_launcher_pr', 'cpu_usage', 90),
('def_named1_cruisemissile_launcher_pr', 'powergrid_usage', 202.5),
('def_named1_cruisemissile_launcher_pr', 'core_usage', 20),
('def_named1_cruisemissile_launcher_pr', 'cycle_time', 14000),
('def_named1_cruisemissile_launcher_pr', 'damage_modifier', 1.3),
('def_named1_cruisemissile_launcher_pr', 'accuracy', 1),

('def_named2_cruisemissile_launcher', 'cpu_usage', 105),
('def_named2_cruisemissile_launcher', 'powergrid_usage', 240),
('def_named2_cruisemissile_launcher', 'core_usage', 20),
('def_named2_cruisemissile_launcher', 'cycle_time', 12000),
('def_named2_cruisemissile_launcher', 'damage_modifier', 1.4),
('def_named2_cruisemissile_launcher', 'module_missile_range_modifier', 1.1),
('def_named2_cruisemissile_launcher', 'accuracy', 1),

('def_named2_cruisemissile_launcher_pr', 'cpu_usage', 105),
('def_named2_cruisemissile_launcher_pr', 'powergrid_usage', 240),
('def_named2_cruisemissile_launcher_pr', 'core_usage', 20),
('def_named2_cruisemissile_launcher_pr', 'cycle_time', 12000),
('def_named2_cruisemissile_launcher_pr', 'damage_modifier', 1.4),
('def_named2_cruisemissile_launcher_pr', 'module_missile_range_modifier', 1.1),
('def_named2_cruisemissile_launcher_pr', 'accuracy', 1),

('def_named3_cruisemissile_launcher', 'cpu_usage', 112.5),
('def_named3_cruisemissile_launcher', 'powergrid_usage', 255),
('def_named3_cruisemissile_launcher', 'core_usage', 20),
('def_named3_cruisemissile_launcher', 'cycle_time', 10500),
('def_named3_cruisemissile_launcher', 'damage_modifier', 1.5),
('def_named3_cruisemissile_launcher', 'module_missile_range_modifier', 1.2),
('def_named3_cruisemissile_launcher', 'accuracy', 1),

('def_named3_cruisemissile_launcher_pr', 'cpu_usage', 112.5),
('def_named3_cruisemissile_launcher_pr', 'powergrid_usage', 255),
('def_named3_cruisemissile_launcher_pr', 'core_usage', 20),
('def_named3_cruisemissile_launcher_pr', 'cycle_time', 10500),
('def_named3_cruisemissile_launcher_pr', 'damage_modifier', 1.5),
('def_named3_cruisemissile_launcher_pr', 'module_missile_range_modifier', 1.2),
('def_named3_cruisemissile_launcher_pr', 'accuracy', 1);


PRINT N'UPDATE/INSERT ENTITY DEFS FOR LARGE WEPS + protos';
--Update/insert [entitydefaults] entries
MERGE [dbo].[entitydefaults] def USING #LARGEWEP wep
ON def.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=wep.defName)
WHEN MATCHED
    THEN UPDATE SET
		categoryflags=catFlags,
		attributeflags=attrFlags,
		volume=cargoVolume,
		mass=massOfModule,
		tiertype=techType,
		tierlevel=techLevel,
		options=genxyOptStr,
		enabled=1,
		hidden=0,
		purchasable=1,
		descriptiontoken=defName+'_desc'
WHEN NOT MATCHED
    THEN INSERT (definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel) VALUES
	(defName,1,attrFlags,catFlags,genxyOptStr,'large weapon module',1,cargoVolume,massOfModule,0,100,defName+'_desc',1,techType,techLevel);



PRINT N'PRINT OLD STATS';
SELECT definitionname, field, value FROM aggregatevalues as a
JOIN entitydefaults AS e ON e.definition=a.definition
WHERE a.definition IN (SELECT definition FROM entitydefaults WHERE definitionname IN (SELECT DISTINCT defName FROM #WEPSTATS));

PRINT N'DELETE OLD STATS (0 results if 1st run)';
DELETE FROM aggregatevalues WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #WEPSTATS));

PRINT N'INSERT NEW STATS';
INSERT INTO aggregatevalues (definition, field, value)
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defName), 
	(SELECT TOP 1 id FROM aggregatefields WHERE name=fieldName), 
	fieldValue 
FROM #WEPSTATS 




PRINT N'CREATE [modulepropertymodifiers] entries for large weapons';
PRINT N'Delete existing to avoid duplicates';
DELETE FROM [dbo].[modulepropertymodifiers] WHERE categoryflags in (
(SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_lasers'),
(SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_railguns'),
(SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_missile_launchers'));


PRINT N'INSERT [modulepropertymodifiers] for large weapon damage, cpu, and powergrid effects';
INSERT INTO [dbo].[modulepropertymodifiers] ([categoryflags],[basefield],[modifierfield]) VALUES
((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_lasers'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='cpu_usage'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='cpu_usage_large_laser_modifier')),

((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_lasers'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='damage_modifier'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='damage_large_laser_modifier')),

((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_lasers'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='powergrid_usage'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='powergrid_usage_large_laser_modifier')),

((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_railguns'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='cpu_usage'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='cpu_usage_large_railgun_modifier')),

((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_railguns'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='damage_modifier'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='damage_large_railgun_modifier')),

((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_railguns'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='powergrid_usage'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='powergrid_usage_large_railgun_modifier')),

((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_missile_launchers'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='cpu_usage'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='cpu_usage_large_missile_modifier')),

((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_missile_launchers'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='damage_modifier'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='damage_large_missile_modifier')),

((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_missile_launchers'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='powergrid_usage'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='powergrid_usage_large_missile_modifier'));

DROP TABLE IF EXISTS #WEPSTATS;
DROP TABLE IF EXISTS #LARGEWEP;
PRINT N'LARGE WEAPONS SET';
GO


PRINT N'WEAPON PROTOTYPE PAIRINGS';

DROP TABLE IF EXISTS #PROTOPAIRS;
CREATE TABLE #PROTOPAIRS
(
	defName varchar(100),
	protoDefName varchar(100),
);

INSERT INTO #PROTOPAIRS (defName, protoDefName) VALUES
('def_standard_large_laser','def_standard_large_laser_pr'),
('def_named1_large_laser','def_named1_large_laser_pr'),
('def_named2_large_laser','def_named2_large_laser_pr'),
('def_named3_large_laser','def_named3_large_laser_pr'),
--
('def_longrange_standard_large_laser','def_longrange_standard_large_laser_pr'),
('def_named1_longrange_large_laser','def_named1_longrange_large_laser_pr'),
('def_named2_longrange_large_laser','def_named2_longrange_large_laser_pr'),
('def_named3_longrange_large_laser','def_named3_longrange_large_laser_pr'),
--
('def_standard_cruisemissile_launcher','def_standard_cruisemissile_launcher_pr'),
('def_named1_cruisemissile_launcher','def_named1_cruisemissile_launcher_pr'),
('def_named2_cruisemissile_launcher','def_named2_cruisemissile_launcher_pr'),
('def_named3_cruisemissile_launcher','def_named3_cruisemissile_launcher_pr'),
--
('def_standard_large_railgun','def_standard_large_railgun_pr'),
('def_named1_large_railgun','def_named1_large_railgun_pr'),
('def_named2_large_railgun','def_named2_large_railgun_pr'),
('def_named3_large_railgun','def_named3_large_railgun_pr'),
--
('def_longrange_standard_large_railgun','def_longrange_standard_large_railgun_pr'),
('def_named1_longrange_large_railgun','def_named1_longrange_large_railgun_pr'),
('def_named2_longrange_large_railgun','def_named2_longrange_large_railgun_pr'),
('def_named3_longrange_large_railgun','def_named3_longrange_large_railgun_pr');

--DELETE and reinsert
PRINT N'DELETE prototypes FOR ANY EXISTING LARGE WEP-PROTO PAIRS (0 results if first run)';
SELECT * FROM prototypes WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT defName FROM #PROTOPAIRS));
DELETE FROM prototypes WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT defName FROM #PROTOPAIRS));

--INSERT
PRINT N'INSERT prototypes FOR LARGE WEP-PROTO PAIRS';
INSERT INTO prototypes (definition, prototype)
SELECT (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = defName), 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = protoDefName)
FROM #PROTOPAIRS;
DROP TABLE IF EXISTS #PROTOPAIRS;
GO


PRINT N'WEAPON PRODUCTION';

DROP TABLE IF EXISTS #WEPCOMPONENTS;
CREATE TABLE #WEPCOMPONENTS
(
	defName VARCHAR(100),
	commodityName VARCHAR(100),
	amount INT
);
INSERT INTO #WEPCOMPONENTS (defName, commodityName, amount) VALUES
('def_standard_large_laser', 'def_titanium', 150),
('def_standard_large_laser', 'def_axicoline', 150),
('def_standard_large_laser', 'def_polynucleit', 150),
('def_standard_large_laser', 'def_specimen_sap_item_flux', 10),

('def_standard_large_laser_pr', 'def_titanium', 150),
('def_standard_large_laser_pr', 'def_axicoline', 150),
('def_standard_large_laser_pr', 'def_polynucleit', 150),
('def_standard_large_laser_pr', 'def_specimen_sap_item_flux', 10),

('def_named1_large_laser', 'def_standard_large_laser', 1),
('def_named1_large_laser', 'def_robotshard_common_basic', 45),
('def_named1_large_laser', 'def_robotshard_thelodica_basic', 45),
('def_named1_large_laser', 'def_titanium', 150),
('def_named1_large_laser', 'def_axicoline', 150),
('def_named1_large_laser', 'def_polynucleit', 150),
('def_named1_large_laser', 'def_specimen_sap_item_flux', 10),

('def_named1_large_laser_pr', 'def_standard_large_laser', 1),
('def_named1_large_laser_pr', 'def_robotshard_common_basic', 45),
('def_named1_large_laser_pr', 'def_robotshard_thelodica_basic', 45),
('def_named1_large_laser_pr', 'def_titanium', 150),
('def_named1_large_laser_pr', 'def_axicoline', 150),
('def_named1_large_laser_pr', 'def_polynucleit', 150),
('def_named1_large_laser_pr', 'def_specimen_sap_item_flux', 10),

('def_named2_large_laser', 'def_named1_large_laser', 1),
('def_named2_large_laser', 'def_robotshard_common_basic', 30),
('def_named2_large_laser', 'def_robotshard_common_advanced', 30),
('def_named2_large_laser', 'def_robotshard_thelodica_basic', 30),
('def_named2_large_laser', 'def_robotshard_thelodica_advanced', 30),
('def_named2_large_laser', 'def_titanium', 150),
('def_named2_large_laser', 'def_hydrobenol', 150),
('def_named2_large_laser', 'def_polynucleit', 150),
('def_named2_large_laser', 'def_specimen_sap_item_flux', 25),

('def_named2_large_laser_pr', 'def_named1_large_laser', 1),
('def_named2_large_laser_pr', 'def_robotshard_common_basic', 30),
('def_named2_large_laser_pr', 'def_robotshard_common_advanced', 30),
('def_named2_large_laser_pr', 'def_robotshard_thelodica_basic', 30),
('def_named2_large_laser_pr', 'def_robotshard_thelodica_advanced', 30),
('def_named2_large_laser_pr', 'def_titanium', 150),
('def_named2_large_laser_pr', 'def_hydrobenol', 150),
('def_named2_large_laser_pr', 'def_polynucleit', 150),
('def_named2_large_laser_pr', 'def_specimen_sap_item_flux', 25),

('def_named3_large_laser', 'def_named2_large_laser', 1),
('def_named3_large_laser', 'def_robotshard_common_basic', 23),
('def_named3_large_laser', 'def_robotshard_common_advanced', 45),
('def_named3_large_laser', 'def_robotshard_common_expert', 68),
('def_named3_large_laser', 'def_robotshard_thelodica_basic', 23),
('def_named3_large_laser', 'def_robotshard_thelodica_advanced', 45),
('def_named3_large_laser', 'def_robotshard_thelodica_expert', 68),
('def_named3_large_laser', 'def_unimetal', 300),
('def_named3_large_laser', 'def_hydrobenol', 300),
('def_named3_large_laser', 'def_polynucleit', 300),
('def_named3_large_laser', 'def_specimen_sap_item_flux', 50),

('def_named3_large_laser_pr', 'def_named2_large_laser', 1),
('def_named3_large_laser_pr', 'def_robotshard_common_basic', 23),
('def_named3_large_laser_pr', 'def_robotshard_common_advanced', 45),
('def_named3_large_laser_pr', 'def_robotshard_common_expert', 68),
('def_named3_large_laser_pr', 'def_robotshard_thelodica_basic', 23),
('def_named3_large_laser_pr', 'def_robotshard_thelodica_advanced', 45),
('def_named3_large_laser_pr', 'def_robotshard_thelodica_expert', 68),
('def_named3_large_laser_pr', 'def_unimetal', 300),
('def_named3_large_laser_pr', 'def_hydrobenol', 300),
('def_named3_large_laser_pr', 'def_polynucleit', 300),
('def_named3_large_laser_pr', 'def_specimen_sap_item_flux', 50),
--
('def_longrange_standard_large_laser', 'def_titanium', 150),
('def_longrange_standard_large_laser', 'def_axicoline', 150),
('def_longrange_standard_large_laser', 'def_polynucleit', 150),
('def_longrange_standard_large_laser', 'def_axicol', 75),
('def_longrange_standard_large_laser', 'def_prilumium', 75),
('def_longrange_standard_large_laser', 'def_specimen_sap_item_flux', 10),

('def_longrange_standard_large_laser_pr', 'def_titanium', 150),
('def_longrange_standard_large_laser_pr', 'def_axicoline', 150),
('def_longrange_standard_large_laser_pr', 'def_polynucleit', 150),
('def_longrange_standard_large_laser_pr', 'def_axicol', 75),
('def_longrange_standard_large_laser_pr', 'def_prilumium', 75),
('def_longrange_standard_large_laser_pr', 'def_specimen_sap_item_flux', 10),

('def_named1_longrange_large_laser', 'def_longrange_standard_large_laser', 1),
('def_named1_longrange_large_laser', 'def_robotshard_common_basic', 45),
('def_named1_longrange_large_laser', 'def_robotshard_thelodica_basic', 45),
('def_named1_longrange_large_laser', 'def_titanium', 150),
('def_named1_longrange_large_laser', 'def_axicoline', 150),
('def_named1_longrange_large_laser', 'def_polynucleit', 150),
('def_named1_longrange_large_laser', 'def_axicol', 75),
('def_named1_longrange_large_laser', 'def_prilumium', 75),
('def_named1_longrange_large_laser', 'def_specimen_sap_item_flux', 10),

('def_named1_longrange_large_laser_pr', 'def_longrange_standard_large_laser', 1),
('def_named1_longrange_large_laser_pr', 'def_robotshard_common_basic', 45),
('def_named1_longrange_large_laser_pr', 'def_robotshard_thelodica_basic', 45),
('def_named1_longrange_large_laser_pr', 'def_titanium', 150),
('def_named1_longrange_large_laser_pr', 'def_axicoline', 150),
('def_named1_longrange_large_laser_pr', 'def_polynucleit', 150),
('def_named1_longrange_large_laser_pr', 'def_axicol', 75),
('def_named1_longrange_large_laser_pr', 'def_prilumium', 75),
('def_named1_longrange_large_laser_pr', 'def_specimen_sap_item_flux', 10),

('def_named2_longrange_large_laser', 'def_named1_longrange_large_laser', 1),
('def_named2_longrange_large_laser', 'def_robotshard_common_basic', 30),
('def_named2_longrange_large_laser', 'def_robotshard_common_advanced', 30),
('def_named2_longrange_large_laser', 'def_robotshard_thelodica_basic', 30),
('def_named2_longrange_large_laser', 'def_robotshard_thelodica_advanced', 30),
('def_named2_longrange_large_laser', 'def_titanium', 150),
('def_named2_longrange_large_laser', 'def_hydrobenol', 150),
('def_named2_longrange_large_laser', 'def_polynucleit', 150),
('def_named2_longrange_large_laser', 'def_prilumium', 75),
('def_named2_longrange_large_laser', 'def_espitium', 75),
('def_named2_longrange_large_laser', 'def_specimen_sap_item_flux', 25),

('def_named2_longrange_large_laser_pr', 'def_named1_longrange_large_laser', 1),
('def_named2_longrange_large_laser_pr', 'def_robotshard_common_basic', 30),
('def_named2_longrange_large_laser_pr', 'def_robotshard_common_advanced', 30),
('def_named2_longrange_large_laser_pr', 'def_robotshard_thelodica_basic', 30),
('def_named2_longrange_large_laser_pr', 'def_robotshard_thelodica_advanced', 30),
('def_named2_longrange_large_laser_pr', 'def_titanium', 150),
('def_named2_longrange_large_laser_pr', 'def_hydrobenol', 150),
('def_named2_longrange_large_laser_pr', 'def_polynucleit', 150),
('def_named2_longrange_large_laser_pr', 'def_prilumium', 75),
('def_named2_longrange_large_laser_pr', 'def_espitium', 75),
('def_named2_longrange_large_laser_pr', 'def_specimen_sap_item_flux', 25),

('def_named3_longrange_large_laser', 'def_named2_longrange_large_laser', 1),
('def_named3_longrange_large_laser', 'def_robotshard_common_basic', 23),
('def_named3_longrange_large_laser', 'def_robotshard_common_advanced', 45),
('def_named3_longrange_large_laser', 'def_robotshard_common_expert', 68),
('def_named3_longrange_large_laser', 'def_robotshard_thelodica_basic', 23),
('def_named3_longrange_large_laser', 'def_robotshard_thelodica_advanced', 45),
('def_named3_longrange_large_laser', 'def_robotshard_thelodica_expert', 68),
('def_named3_longrange_large_laser', 'def_hydrobenol', 300),
('def_named3_longrange_large_laser', 'def_polynucleit', 300),
('def_named3_longrange_large_laser', 'def_prilumium', 150),
('def_named3_longrange_large_laser', 'def_espitium', 150),
('def_named3_longrange_large_laser', 'def_unimetal', 300),
('def_named3_longrange_large_laser', 'def_specimen_sap_item_flux', 50),

('def_named3_longrange_large_laser_pr', 'def_named2_longrange_large_laser', 1),
('def_named3_longrange_large_laser_pr', 'def_robotshard_common_basic', 23),
('def_named3_longrange_large_laser_pr', 'def_robotshard_common_advanced', 45),
('def_named3_longrange_large_laser_pr', 'def_robotshard_common_expert', 68),
('def_named3_longrange_large_laser_pr', 'def_robotshard_thelodica_basic', 23),
('def_named3_longrange_large_laser_pr', 'def_robotshard_thelodica_advanced', 45),
('def_named3_longrange_large_laser_pr', 'def_robotshard_thelodica_expert', 68),
('def_named3_longrange_large_laser_pr', 'def_hydrobenol', 300),
('def_named3_longrange_large_laser_pr', 'def_polynucleit', 300),
('def_named3_longrange_large_laser_pr', 'def_prilumium', 150),
('def_named3_longrange_large_laser_pr', 'def_espitium', 150),
('def_named3_longrange_large_laser_pr', 'def_unimetal', 300),
('def_named3_longrange_large_laser_pr', 'def_specimen_sap_item_flux', 50),
--
('def_standard_large_railgun', 'def_titanium', 150),
('def_standard_large_railgun', 'def_axicoline', 150),
('def_standard_large_railgun', 'def_polynitrocol', 150),
('def_standard_large_railgun', 'def_specimen_sap_item_flux', 10),

('def_standard_large_railgun_pr', 'def_titanium', 150),
('def_standard_large_railgun_pr', 'def_axicoline', 150),
('def_standard_large_railgun_pr', 'def_polynitrocol', 150),
('def_standard_large_railgun_pr', 'def_specimen_sap_item_flux', 10),

('def_named1_large_railgun', 'def_standard_large_railgun', 1),
('def_named1_large_railgun', 'def_robotshard_common_basic', 45),
('def_named1_large_railgun', 'def_robotshard_nuimqol_basic', 45),
('def_named1_large_railgun', 'def_titanium', 150),
('def_named1_large_railgun', 'def_axicoline', 150),
('def_named1_large_railgun', 'def_polynitrocol', 150),
('def_named1_large_railgun', 'def_specimen_sap_item_flux', 10),

('def_named1_large_railgun_pr', 'def_standard_large_railgun', 1),
('def_named1_large_railgun_pr', 'def_robotshard_common_basic', 45),
('def_named1_large_railgun_pr', 'def_robotshard_nuimqol_basic', 45),
('def_named1_large_railgun_pr', 'def_titanium', 150),
('def_named1_large_railgun_pr', 'def_axicoline', 150),
('def_named1_large_railgun_pr', 'def_polynitrocol', 150),
('def_named1_large_railgun_pr', 'def_specimen_sap_item_flux', 10),

('def_named2_large_railgun', 'def_named1_large_railgun', 1),
('def_named2_large_railgun', 'def_robotshard_common_basic', 30),
('def_named2_large_railgun', 'def_robotshard_common_advanced', 30),
('def_named2_large_railgun', 'def_robotshard_nuimqol_basic', 30),
('def_named2_large_railgun', 'def_robotshard_nuimqol_advanced', 30),
('def_named2_large_railgun', 'def_titanium', 150),
('def_named2_large_railgun', 'def_hydrobenol', 150),
('def_named2_large_railgun', 'def_polynitrocol', 150),
('def_named2_large_railgun', 'def_specimen_sap_item_flux', 25),

('def_named2_large_railgun_pr', 'def_named1_large_railgun', 1),
('def_named2_large_railgun_pr', 'def_robotshard_common_basic', 30),
('def_named2_large_railgun_pr', 'def_robotshard_common_advanced', 30),
('def_named2_large_railgun_pr', 'def_robotshard_nuimqol_basic', 30),
('def_named2_large_railgun_pr', 'def_robotshard_nuimqol_advanced', 30),
('def_named2_large_railgun_pr', 'def_titanium', 150),
('def_named2_large_railgun_pr', 'def_hydrobenol', 150),
('def_named2_large_railgun_pr', 'def_polynitrocol', 150),
('def_named2_large_railgun_pr', 'def_specimen_sap_item_flux', 25),

('def_named3_large_railgun', 'def_named2_large_railgun', 1),
('def_named3_large_railgun', 'def_robotshard_common_basic', 23),
('def_named3_large_railgun', 'def_robotshard_common_advanced', 45),
('def_named3_large_railgun', 'def_robotshard_common_expert', 68),
('def_named3_large_railgun', 'def_robotshard_nuimqol_basic', 23),
('def_named3_large_railgun', 'def_robotshard_nuimqol_advanced', 45),
('def_named3_large_railgun', 'def_robotshard_nuimqol_expert', 68),
('def_named3_large_railgun', 'def_unimetal', 300),
('def_named3_large_railgun', 'def_hydrobenol', 300),
('def_named3_large_railgun', 'def_polynitrocol', 300),
('def_named3_large_railgun', 'def_specimen_sap_item_flux', 50),

('def_named3_large_railgun_pr', 'def_named2_large_railgun', 1),
('def_named3_large_railgun_pr', 'def_robotshard_common_basic', 23),
('def_named3_large_railgun_pr', 'def_robotshard_common_advanced', 45),
('def_named3_large_railgun_pr', 'def_robotshard_common_expert', 68),
('def_named3_large_railgun_pr', 'def_robotshard_nuimqol_basic', 23),
('def_named3_large_railgun_pr', 'def_robotshard_nuimqol_advanced', 45),
('def_named3_large_railgun_pr', 'def_robotshard_nuimqol_expert', 68),
('def_named3_large_railgun_pr', 'def_unimetal', 300),
('def_named3_large_railgun_pr', 'def_hydrobenol', 300),
('def_named3_large_railgun_pr', 'def_polynitrocol', 300),
('def_named3_large_railgun_pr', 'def_specimen_sap_item_flux', 50),
--
('def_longrange_standard_large_railgun', 'def_titanium', 150),
('def_longrange_standard_large_railgun', 'def_axicoline', 150),
('def_longrange_standard_large_railgun', 'def_polynitrocol', 150),
('def_longrange_standard_large_railgun', 'def_axicol', 75),
('def_longrange_standard_large_railgun', 'def_chollonin', 75),
('def_longrange_standard_large_railgun', 'def_specimen_sap_item_flux', 10),

('def_longrange_standard_large_railgun_pr', 'def_titanium', 150),
('def_longrange_standard_large_railgun_pr', 'def_axicoline', 150),
('def_longrange_standard_large_railgun_pr', 'def_polynitrocol', 150),
('def_longrange_standard_large_railgun_pr', 'def_axicol', 75),
('def_longrange_standard_large_railgun_pr', 'def_chollonin', 75),
('def_longrange_standard_large_railgun_pr', 'def_specimen_sap_item_flux', 10),

('def_named1_longrange_large_railgun', 'def_longrange_standard_large_railgun', 1),
('def_named1_longrange_large_railgun', 'def_robotshard_common_basic', 45),
('def_named1_longrange_large_railgun', 'def_robotshard_nuimqol_basic', 45),
('def_named1_longrange_large_railgun', 'def_titanium', 150),
('def_named1_longrange_large_railgun', 'def_axicoline', 150),
('def_named1_longrange_large_railgun', 'def_polynitrocol', 150),
('def_named1_longrange_large_railgun', 'def_axicol', 75),
('def_named1_longrange_large_railgun', 'def_chollonin', 75),
('def_named1_longrange_large_railgun', 'def_specimen_sap_item_flux', 10),

('def_named1_longrange_large_railgun_pr', 'def_longrange_standard_large_railgun', 1),
('def_named1_longrange_large_railgun_pr', 'def_robotshard_common_basic', 45),
('def_named1_longrange_large_railgun_pr', 'def_robotshard_nuimqol_basic', 45),
('def_named1_longrange_large_railgun_pr', 'def_titanium', 150),
('def_named1_longrange_large_railgun_pr', 'def_axicoline', 150),
('def_named1_longrange_large_railgun_pr', 'def_polynitrocol', 150),
('def_named1_longrange_large_railgun_pr', 'def_axicol', 75),
('def_named1_longrange_large_railgun_pr', 'def_chollonin', 75),
('def_named1_longrange_large_railgun_pr', 'def_specimen_sap_item_flux', 10),

('def_named2_longrange_large_railgun', 'def_named1_longrange_large_railgun', 1),
('def_named2_longrange_large_railgun', 'def_robotshard_common_basic', 30),
('def_named2_longrange_large_railgun', 'def_robotshard_common_advanced', 30),
('def_named2_longrange_large_railgun', 'def_robotshard_nuimqol_basic', 30),
('def_named2_longrange_large_railgun', 'def_robotshard_nuimqol_advanced', 30),
('def_named2_longrange_large_railgun', 'def_titanium', 150),
('def_named2_longrange_large_railgun', 'def_hydrobenol', 150),
('def_named2_longrange_large_railgun', 'def_polynitrocol', 150),
('def_named2_longrange_large_railgun', 'def_espitium', 75),
('def_named2_longrange_large_railgun', 'def_chollonin', 75),
('def_named2_longrange_large_railgun', 'def_specimen_sap_item_flux', 25),

('def_named2_longrange_large_railgun_pr', 'def_named1_longrange_large_railgun', 1),
('def_named2_longrange_large_railgun_pr', 'def_robotshard_common_basic', 30),
('def_named2_longrange_large_railgun_pr', 'def_robotshard_common_advanced', 30),
('def_named2_longrange_large_railgun_pr', 'def_robotshard_nuimqol_basic', 30),
('def_named2_longrange_large_railgun_pr', 'def_robotshard_nuimqol_advanced', 30),
('def_named2_longrange_large_railgun_pr', 'def_titanium', 150),
('def_named2_longrange_large_railgun_pr', 'def_hydrobenol', 150),
('def_named2_longrange_large_railgun_pr', 'def_polynitrocol', 150),
('def_named2_longrange_large_railgun_pr', 'def_espitium', 75),
('def_named2_longrange_large_railgun_pr', 'def_chollonin', 75),
('def_named2_longrange_large_railgun_pr', 'def_specimen_sap_item_flux', 25),

('def_named3_longrange_large_railgun', 'def_named2_longrange_large_railgun', 1),
('def_named3_longrange_large_railgun', 'def_robotshard_common_basic', 23),
('def_named3_longrange_large_railgun', 'def_robotshard_common_advanced', 45),
('def_named3_longrange_large_railgun', 'def_robotshard_common_expert', 68),
('def_named3_longrange_large_railgun', 'def_robotshard_nuimqol_basic', 23),
('def_named3_longrange_large_railgun', 'def_robotshard_nuimqol_advanced', 45),
('def_named3_longrange_large_railgun', 'def_robotshard_nuimqol_expert', 68),
('def_named3_longrange_large_railgun', 'def_unimetal', 300),
('def_named3_longrange_large_railgun', 'def_hydrobenol', 300),
('def_named3_longrange_large_railgun', 'def_polynitrocol', 300),
('def_named3_longrange_large_railgun', 'def_espitium', 150),
('def_named3_longrange_large_railgun', 'def_chollonin', 150),
('def_named3_longrange_large_railgun', 'def_specimen_sap_item_flux', 50),

('def_named3_longrange_large_railgun_pr', 'def_named2_longrange_large_railgun', 1),
('def_named3_longrange_large_railgun_pr', 'def_robotshard_common_basic', 23),
('def_named3_longrange_large_railgun_pr', 'def_robotshard_common_advanced', 45),
('def_named3_longrange_large_railgun_pr', 'def_robotshard_common_expert', 68),
('def_named3_longrange_large_railgun_pr', 'def_robotshard_nuimqol_basic', 23),
('def_named3_longrange_large_railgun_pr', 'def_robotshard_nuimqol_advanced', 45),
('def_named3_longrange_large_railgun_pr', 'def_robotshard_nuimqol_expert', 68),
('def_named3_longrange_large_railgun_pr', 'def_unimetal', 300),
('def_named3_longrange_large_railgun_pr', 'def_hydrobenol', 300),
('def_named3_longrange_large_railgun_pr', 'def_polynitrocol', 300),
('def_named3_longrange_large_railgun_pr', 'def_espitium', 150),
('def_named3_longrange_large_railgun_pr', 'def_chollonin', 150),
('def_named3_longrange_large_railgun_pr', 'def_specimen_sap_item_flux', 50),
--
('def_standard_cruisemissile_launcher', 'def_titanium', 150),
('def_standard_cruisemissile_launcher', 'def_axicoline', 150),
('def_standard_cruisemissile_launcher', 'def_phlobotil', 150),
('def_standard_cruisemissile_launcher', 'def_specimen_sap_item_flux', 10),

('def_standard_cruisemissile_launcher_pr', 'def_titanium', 150),
('def_standard_cruisemissile_launcher_pr', 'def_axicoline', 150),
('def_standard_cruisemissile_launcher_pr', 'def_phlobotil', 150),
('def_standard_cruisemissile_launcher_pr', 'def_specimen_sap_item_flux', 10),

('def_named1_cruisemissile_launcher', 'def_standard_cruisemissile_launcher', 1),
('def_named1_cruisemissile_launcher', 'def_robotshard_common_basic', 45),
('def_named1_cruisemissile_launcher', 'def_robotshard_pelistal_basic', 45),
('def_named1_cruisemissile_launcher', 'def_titanium', 150),
('def_named1_cruisemissile_launcher', 'def_axicoline', 150),
('def_named1_cruisemissile_launcher', 'def_phlobotil', 150),
('def_named1_cruisemissile_launcher', 'def_specimen_sap_item_flux', 10),

('def_named1_cruisemissile_launcher_pr', 'def_standard_cruisemissile_launcher', 1),
('def_named1_cruisemissile_launcher_pr', 'def_robotshard_common_basic', 45),
('def_named1_cruisemissile_launcher_pr', 'def_robotshard_pelistal_basic', 45),
('def_named1_cruisemissile_launcher_pr', 'def_titanium', 150),
('def_named1_cruisemissile_launcher_pr', 'def_axicoline', 150),
('def_named1_cruisemissile_launcher_pr', 'def_phlobotil', 150),
('def_named1_cruisemissile_launcher_pr', 'def_specimen_sap_item_flux', 10),

('def_named2_cruisemissile_launcher', 'def_named1_cruisemissile_launcher', 1),
('def_named2_cruisemissile_launcher', 'def_robotshard_common_basic', 30),
('def_named2_cruisemissile_launcher', 'def_robotshard_common_advanced', 30),
('def_named2_cruisemissile_launcher', 'def_robotshard_pelistal_basic', 30),
('def_named2_cruisemissile_launcher', 'def_robotshard_pelistal_advanced', 30),
('def_named2_cruisemissile_launcher', 'def_titanium', 150),
('def_named2_cruisemissile_launcher', 'def_hydrobenol', 150),
('def_named2_cruisemissile_launcher', 'def_phlobotil', 150),
('def_named2_cruisemissile_launcher', 'def_specimen_sap_item_flux', 25),

('def_named2_cruisemissile_launcher_pr', 'def_named1_cruisemissile_launcher', 1),
('def_named2_cruisemissile_launcher_pr', 'def_robotshard_common_basic', 30),
('def_named2_cruisemissile_launcher_pr', 'def_robotshard_common_advanced', 30),
('def_named2_cruisemissile_launcher_pr', 'def_robotshard_pelistal_basic', 30),
('def_named2_cruisemissile_launcher_pr', 'def_robotshard_pelistal_advanced', 30),
('def_named2_cruisemissile_launcher_pr', 'def_titanium', 150),
('def_named2_cruisemissile_launcher_pr', 'def_hydrobenol', 150),
('def_named2_cruisemissile_launcher_pr', 'def_phlobotil', 150),
('def_named2_cruisemissile_launcher_pr', 'def_specimen_sap_item_flux', 25),

('def_named3_cruisemissile_launcher', 'def_named2_cruisemissile_launcher', 1),
('def_named3_cruisemissile_launcher', 'def_robotshard_common_basic', 23),
('def_named3_cruisemissile_launcher', 'def_robotshard_common_advanced', 45),
('def_named3_cruisemissile_launcher', 'def_robotshard_common_expert', 68),
('def_named3_cruisemissile_launcher', 'def_robotshard_pelistal_basic', 23),
('def_named3_cruisemissile_launcher', 'def_robotshard_pelistal_advanced', 45),
('def_named3_cruisemissile_launcher', 'def_robotshard_pelistal_expert', 68),
('def_named3_cruisemissile_launcher', 'def_unimetal', 300),
('def_named3_cruisemissile_launcher', 'def_hydrobenol', 300),
('def_named3_cruisemissile_launcher', 'def_phlobotil', 300),
('def_named3_cruisemissile_launcher', 'def_specimen_sap_item_flux', 50),

('def_named3_cruisemissile_launcher_pr', 'def_named2_cruisemissile_launcher', 1),
('def_named3_cruisemissile_launcher_pr', 'def_robotshard_common_basic', 23),
('def_named3_cruisemissile_launcher_pr', 'def_robotshard_common_advanced', 45),
('def_named3_cruisemissile_launcher_pr', 'def_robotshard_common_expert', 68),
('def_named3_cruisemissile_launcher_pr', 'def_robotshard_pelistal_basic', 23),
('def_named3_cruisemissile_launcher_pr', 'def_robotshard_pelistal_advanced', 45),
('def_named3_cruisemissile_launcher_pr', 'def_robotshard_pelistal_expert', 68),
('def_named3_cruisemissile_launcher_pr', 'def_unimetal', 300),
('def_named3_cruisemissile_launcher_pr', 'def_hydrobenol', 300),
('def_named3_cruisemissile_launcher_pr', 'def_phlobotil', 300),
('def_named3_cruisemissile_launcher_pr', 'def_specimen_sap_item_flux', 50);

PRINT N'DELETE components FOR ANY EXISTING LARGE WEPS (0 results if 1st run)';
SELECT * FROM components WHERE definition IN (SELECT definition FROM entitydefaults WHERE definitionname IN (SELECT DISTINCT defName FROM #WEPCOMPONENTS));
DELETE FROM components WHERE definition IN (SELECT definition FROM entitydefaults WHERE definitionname IN (SELECT DISTINCT defName FROM #WEPCOMPONENTS));

PRINT N'INSERT components FORLARGE WEPS';
INSERT INTO components (definition, componentdefinition, componentamount)
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defName),
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=commodityName),
	amount
FROM #WEPCOMPONENTS;


DROP TABLE IF EXISTS #WEPCOMPONENTS;
GO


PRINT N'CALIBRATION TEMPLATES FOR WEAPONS';

DROP TABLE IF EXISTS #WEPCTS;
CREATE TABLE #WEPCTS 
(
	defName varchar(100),
	catFlags bigint,
	attrFlags bigint,
	cargoVolume float,
	massOfModule float,
	techType int,
	techLevel int,
	genxyOptStr varchar(max),
);

INSERT INTO #WEPCTS (defName, attrFlags, catFlags, cargoVolume, massOfModule, techType, techLevel, genxyOptStr) VALUES
('def_standard_large_laser_cprg', 1024, 33686550, 0.01, 0.1, 1, 1, '#tier=$tierlevel_t1'),
('def_named1_large_laser_cprg', 1024, 33686550, 0.01, 0.1, 1, 2, '#tier=$tierlevel_t2'),
('def_named2_large_laser_cprg', 1024, 33686550, 0.01, 0.1, 1, 3, '#tier=$tierlevel_t3'),
('def_named3_large_laser_cprg', 1024, 33686550, 0.01, 0.1, 1, 4, '#tier=$tierlevel_t4'),
--
('def_longrange_standard_large_laser_cprg', 1024, 33686550, 0.01, 0.1, 1, 1, '#tier=$tierlevel_t1'),
('def_named1_longrange_large_laser_cprg', 1024, 33686550, 0.01, 0.1, 1, 2, '#tier=$tierlevel_t2'),
('def_named2_longrange_large_laser_cprg', 1024, 33686550, 0.01, 0.1, 1, 3, '#tier=$tierlevel_t3'),
('def_named3_longrange_large_laser_cprg', 1024, 33686550, 0.01, 0.1, 1, 4, '#tier=$tierlevel_t4'),
--
('def_standard_cruisemissile_launcher_cprg', 1024, 67240982, 0.01, 0.1, 1, 1, '#tier=$tierlevel_t1'),
('def_named1_cruisemissile_launcher_cprg', 1024, 67240982, 0.01, 0.1, 1, 2, '#tier=$tierlevel_t2'),
('def_named2_cruisemissile_launcher_cprg', 1024, 67240982, 0.01, 0.1, 1, 3, '#tier=$tierlevel_t3'),
('def_named3_cruisemissile_launcher_cprg', 1024, 67240982, 0.01, 0.1, 1, 4, '#tier=$tierlevel_t4'),
--
('def_standard_large_railgun_cprg', 1024, 16909334, 0.01, 0.1, 1, 1, '#tier=$tierlevel_t1'),
('def_named1_large_railgun_cprg', 1024, 16909334, 0.01, 0.1, 1, 2, '#tier=$tierlevel_t2'),
('def_named2_large_railgun_cprg', 1024, 16909334, 0.01, 0.1, 1, 3, '#tier=$tierlevel_t3'),
('def_named3_large_railgun_cprg', 1024, 16909334, 0.01, 0.1, 1, 4, '#tier=$tierlevel_t4'),
--
('def_longrange_standard_large_railgun_cprg', 1024, 16909334, 0.01, 0.1, 1, 1, '#tier=$tierlevel_t1'),
('def_named1_longrange_large_railgun_cprg', 1024, 16909334, 0.01, 0.1, 1, 2, '#tier=$tierlevel_t2'),
('def_named2_longrange_large_railgun_cprg', 1024, 16909334, 0.01, 0.1, 1, 3, '#tier=$tierlevel_t3'),
('def_named3_longrange_large_railgun_cprg', 1024, 16909334, 0.01, 0.1, 1, 4, '#tier=$tierlevel_t4');


PRINT N'UPDATE/INSERT CTS';
--Update/insert [entitydefaults] entries
MERGE [dbo].[entitydefaults] def USING #WEPCTS ct
ON def.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=ct.defName)
WHEN MATCHED
    THEN UPDATE SET
		categoryflags=catFlags,
		attributeflags=attrFlags,
		volume=cargoVolume,
		mass=massOfModule,
		tiertype=techType,
		tierlevel=techLevel,
		options=genxyOptStr,
		enabled=1,
		hidden=0,
		purchasable=0,
		descriptiontoken='calibration_program_desc'
WHEN NOT MATCHED
    THEN INSERT (definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel) VALUES
	(defName, 1, attrFlags,catFlags,genxyOptStr,'CT large weapon',1,cargoVolume,massOfModule,0,100,'calibration_program_desc',0,techType,techLevel);

PRINT N'DELETE calibrationdefaults FOR ANY EXISTING LARGE WEP CTS (0 results if 1st run)';
SELECT * FROM calibrationdefaults WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #WEPCTS));
DELETE FROM calibrationdefaults WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #WEPCTS));

PRINT N'INSERT calibrationdefaults FOR WEP CTS';
INSERT INTO calibrationdefaults (definition, materialefficiency, timeefficiency)
SELECT (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = defName), 70, 70 FROM #WEPCTS;

DROP TABLE IF EXISTS #PROTO_TO_CT;
CREATE TABLE #PROTO_TO_CT
(
	protoDefName VARCHAR(100),
	ctDefName VARCHAR(100),
	level INT
);

INSERT INTO #PROTO_TO_CT (protoDefName, ctDefName, level) VALUES
('def_standard_large_laser_pr', 'def_standard_large_laser_cprg', 5),
('def_named1_large_laser_pr', 'def_named1_large_laser_cprg', 6),
('def_named2_large_laser_pr', 'def_named2_large_laser_cprg', 7),
('def_named3_large_laser_pr', 'def_named3_large_laser_cprg', 8),
--
('def_longrange_standard_large_laser_pr', 'def_longrange_standard_large_laser_cprg', 5),
('def_named1_longrange_large_laser_pr', 'def_named1_longrange_large_laser_cprg', 6),
('def_named2_longrange_large_laser_pr', 'def_named2_longrange_large_laser_cprg', 7),
('def_named3_longrange_large_laser_pr', 'def_named3_longrange_large_laser_cprg', 8),
--
('def_standard_cruisemissile_launcher_pr', 'def_standard_cruisemissile_launcher_cprg', 5),
('def_named1_cruisemissile_launcher_pr', 'def_named1_cruisemissile_launcher_cprg', 6),
('def_named2_cruisemissile_launcher_pr', 'def_named2_cruisemissile_launcher_cprg', 7),
('def_named3_cruisemissile_launcher_pr', 'def_named3_cruisemissile_launcher_cprg', 8),
--
('def_standard_large_railgun_pr', 'def_standard_large_railgun_cprg', 5),
('def_named1_large_railgun_pr', 'def_named1_large_railgun_cprg', 6),
('def_named2_large_railgun_pr', 'def_named2_large_railgun_cprg', 7),
('def_named3_large_railgun_pr', 'def_named3_large_railgun_cprg', 8),
--
('def_longrange_standard_large_railgun_pr', 'def_longrange_standard_large_railgun_cprg', 5),
('def_named1_longrange_large_railgun_pr', 'def_named1_longrange_large_railgun_cprg', 6),
('def_named2_longrange_large_railgun_pr', 'def_named2_longrange_large_railgun_cprg', 7),
('def_named3_longrange_large_railgun_pr', 'def_named3_longrange_large_railgun_cprg', 8);


PRINT N'DELETE itemresearchlevels FOR ANY EXISTING LARGE WEP CTS (0 results if 1st run)';
SELECT * FROM itemresearchlevels WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT protoDefName FROM #PROTO_TO_CT));
DELETE FROM itemresearchlevels WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT protoDefName FROM #PROTO_TO_CT));

PRINT N'INSERT itemresearchlevels FOR WEP CTS';
INSERT INTO itemresearchlevels (definition, calibrationprogram, researchlevel, enabled)
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = protoDefName), 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = ctDefName), 
	level, 1
FROM #PROTO_TO_CT;


DROP TABLE IF EXISTS #WEPCTS;
DROP TABLE IF EXISTS #PROTO_TO_CT;
GO

PRINT N'06_Minerals_ammo_addfluxore__2020_05_01';

USE [perpetuumsa]
GO
------------------------------------------------------------------
--Add a new raw material/ore: Flux Ore
--Insert entitydef geoscandocument
--Insert entitydef mineral
--Insert mineral
--Insert mineralconfigs for zones
--Insert scanner ammos
--Insert mining ammo
--Insert production and research for mining ammo
--2nd script to insert market orders for scanner ammos
--
--Last modified: 2020/06/23
------------------------------------------------------------------



PRINT N'ADD/UPDATE def_geoscan_document_fluxore ON entitydefaults';
IF EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_geoscan_document_fluxore')
BEGIN
	UPDATE entitydefaults SET
		definitionname = 'def_geoscan_document_fluxore',
		quantity = 1,
		attributeflags = 2048,
		categoryflags = 1685,
		options = '',
		note = '',
		enabled = 1,
		volume = 0.1,
		mass = 0.1,
		hidden = 0,
		health = 100,
		descriptiontoken = 'def_geoscan_document_desc',
		purchasable = 0,
		tiertype = NULL,
		tierlevel = NULL
	WHERE definitionname = 'def_geoscan_document_fluxore';
END
ELSE
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
	VALUES 
	('def_geoscan_document_fluxore', 1, 2048, 1685, '', '', 1, 0.1, 0.1, 0, 100, 'def_geoscan_document_desc', 0, NULL, NULL); 
END

PRINT N'ADD/UPDATE def_fluxore ON entitydefaults';
IF EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_fluxore')
BEGIN
	UPDATE entitydefaults SET
		definitionname = 'def_fluxore',
		quantity = 1,
		attributeflags = 2048,
		categoryflags = 131348,
		options = '',
		note = '',
		enabled = 1,
		volume = 0.0001,
		mass = 0.01,
		hidden = 0,
		health = 100,
		descriptiontoken = 'def_fluxore_desc',
		purchasable = 1,
		tiertype = NULL,
		tierlevel = NULL
	WHERE definitionname = 'def_fluxore';
END
ELSE
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
	VALUES 
	('def_fluxore', 1, 2048, 131348, '', '', 1, 0.0001, 0.01, 0, 100, 'def_fluxore_desc', 1, NULL, NULL); 
END


PRINT N'ADD/UPDATE fluxore ON minerals';
IF EXISTS (SELECT TOP 1 idx FROM minerals WHERE name='fluxore')
BEGIN
	UPDATE minerals SET
		idx = 16,
		name = 'fluxore',
		definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_fluxore'),
		amount = 100,
		extractionType = 0,
		enablereffectrequired = 0,
		note = 'flux ore',
		geoscandocument = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_geoscan_document_fluxore')
	WHERE name='fluxore';
END
ELSE
BEGIN
	INSERT INTO minerals (idx, name, definition, amount, extractionType, enablereffectrequired, note, geoscandocument) VALUES
	(16, 'fluxore', (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_fluxore'), 100, 0, 0, 'flux ore', (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_geoscan_document_fluxore'));
END


PRINT N'ADD/UPDATE def_ammo_mining_probe_fluxore_tile ON entitydefaults';
IF EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_mining_probe_fluxore_tile')
BEGIN
	UPDATE entitydefaults SET
		definitionname = 'def_ammo_mining_probe_fluxore_tile',
		quantity = 1000,
		attributeflags = 2048,
		categoryflags = 133386,
		options = '#mineral=$fluxore #type=n1',
		note = '',
		enabled = 1,
		volume = 0.5,
		mass = 0.1,
		hidden = 0,
		health = 100,
		descriptiontoken = 'def_ammo_mining_probe_tile_desc',
		purchasable = 1,
		tiertype = NULL,
		tierlevel = NULL
	WHERE definitionname = 'def_ammo_mining_probe_fluxore_tile';
END
ELSE
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
	VALUES 
	('def_ammo_mining_probe_fluxore_tile', 1000, 2048, 133386, '#mineral=$fluxore #type=n1', '', 1, 0.5, 0.1, 0, 100, 'def_ammo_mining_probe_tile_desc', 1, NULL, NULL); 
END

PRINT N'DELETE-REINSERT aggregatevalues FOR def_ammo_mining_probe_fluxore_tile';
SELECT * FROM aggregatevalues WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_mining_probe_fluxore_tile');
DELETE FROM aggregatevalues WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_mining_probe_fluxore_tile');

INSERT INTO aggregatevalues (definition, field, value) 
VALUES
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_mining_probe_fluxore_tile'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='tile_based_mining_probe_radius'),
10);


PRINT N'ADD/UPDATE def_ammo_mining_probe_fluxore_direction ON entitydefaults';
IF EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_mining_probe_fluxore_direction')
BEGIN
	UPDATE entitydefaults SET
		definitionname = 'def_ammo_mining_probe_fluxore_direction',
		quantity = 1000,
		attributeflags = 2048,
		categoryflags = 395530,
		options = '#mineral=$fluxore',
		note = '',
		enabled = 1,
		volume = 0.5,
		mass = 0.1,
		hidden = 0,
		health = 100,
		descriptiontoken = 'def_ammo_mining_probe_direction_desc',
		purchasable = 1,
		tiertype = NULL,
		tierlevel = NULL
	WHERE definitionname = 'def_ammo_mining_probe_fluxore_direction';
END
ELSE
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
	VALUES 
	('def_ammo_mining_probe_fluxore_direction', 1000, 2048, 395530, '#mineral=$fluxore', '', 1, 0.5, 0.1, 0, 100, 'def_ammo_mining_probe_direction_desc', 1, NULL, NULL); 
END


PRINT N'ADD/UPDATE def_ammo_mining_fluxore ON entitydefaults';
IF EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_mining_fluxore')
BEGIN
	UPDATE entitydefaults SET
		definitionname = 'def_ammo_mining_fluxore',
		quantity = 1000,
		attributeflags = 2147485696,
		categoryflags = 1290,
		options = 'mineral=$fluxore',
		note = '',
		enabled = 1,
		volume = 0.5,
		mass = 0.1,
		hidden = 0,
		health = 100,
		descriptiontoken = 'def_ammo_mining_desc',
		purchasable = 1,
		tiertype = NULL,
		tierlevel = NULL
	WHERE definitionname = 'def_ammo_mining_fluxore';
END
ELSE
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
	VALUES 
	('def_ammo_mining_fluxore', 1000, 2147485696, 1290, 'mineral=$fluxore', '', 1, 0.5, 1, 0, 100, 'def_ammo_mining_desc', 1, NULL, NULL); 
END

SELECT * FROM beamassignment WHERE definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_mining_fluxore');
DELETE FROM beamassignment WHERE definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_mining_fluxore');
INSERT INTO beamassignment (beam, definition) VALUES
((SELECT TOP 1 id FROM beams WHERE name='small_driller'),
(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_mining_fluxore'));

DROP TABLE IF EXISTS #MINERALCONFS;
CREATE TABLE #MINERALCONFS
(
	zoneName VARCHAR(100),
	materialName VARCHAR(100),
	maxNodes INT,
	maxTilesPerNode INT,
	totalAmountPerNode INT,
	minThreshold FLOAT
);
INSERT INTO #MINERALCONFS (zoneName, materialName, maxNodes, maxTilesPerNode, totalAmountPerNode, minThreshold) VALUES
('norhoop', 'fluxore', 6, 300, 5000000, 0.5),
('domhalarn', 'fluxore', 6, 300, 5000000, 0.5),
('hokkogaros', 'fluxore', 6, 300, 5000000, 0.5),
('alsbale', 'fluxore', 10, 300, 5000000, 0.5),
('novastrov', 'fluxore', 10, 300, 5000000, 0.5),
('kentagura', 'fluxore', 10, 300, 5000000, 0.5);

PRINT N'UPDATE/INSERT mineralconfigs for fluxore';
MERGE [dbo].[mineralconfigs] configs USING #MINERALCONFS conf
ON configs.materialtype = (select top 1 idx from minerals where name=conf.materialName) AND
	configs.zoneid = (select top 1 id from zones where note=conf.zoneName)
WHEN MATCHED
    THEN UPDATE SET
		maxnodes = conf.maxNodes,
		maxtilespernode = conf.maxTilesPerNode,
		totalamountpernode = conf.totalAmountPerNode,
		minthreshold = conf.minThreshold
WHEN NOT MATCHED
    THEN INSERT (zoneid, materialtype, maxnodes, maxtilespernode, totalamountpernode, minthreshold) VALUES
	((select top 1 id from zones where note=conf.zoneName),
	(select top 1 idx from minerals where name=conf.materialName),
	conf.maxNodes,
	conf.maxTilesPerNode,
	conf.totalAmountPerNode,
	conf.minThreshold);
DROP TABLE IF EXISTS #MINERALCONFS;
PRINT N'FLUXORE IS A GO';
GO


----------------------------------------------
--Set Flux as refined commodity of Flux Ore
---------------------------------------------


PRINT N'Make Flux a proper refined material';
DECLARE @flux INT;
SET @flux = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_specimen_sap_item_flux');

DECLARE @fluxOre INT;
SET @fluxOre = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_fluxore');

PRINT N'SET proper category for Flux';
UPDATE entitydefaults SET
	categoryflags = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_primary_commodities')
WHERE definition = @flux;

PRINT N'DELETE components for refining flux (0 results if 1st run)';
SELECT * FROM components WHERE definition  = @flux;
DELETE FROM components WHERE definition = @flux;

PRINT N'INSERT components for refining flux';
INSERT INTO components (definition, componentdefinition, componentamount) VALUES
	(@flux, @fluxOre, 350);

GO


----------------------------------------------
--Add Flux ore mining ammo to indy tree and production pipeline
---------------------------------------------

DECLARE @fluxAmmo INT;
DECLARE @liqAmmo INT;
DECLARE @indyTechTree INT;
SET @indyTechTree = (SELECT TOP 1 id FROM techtreegroups WHERE name='indy');
SET @liqAmmo = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_ammo_mining_liquizit');
SET @fluxAmmo = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_ammo_mining_fluxore');


IF NOT EXISTS (SELECT TOP 1 [childdefinition] FROM techtree WHERE [childdefinition]=@fluxAmmo)
BEGIN
	INSERT INTO techtree ([parentdefinition],[childdefinition],[groupID],[x],[y]) VALUES
	(@liqAmmo, @fluxAmmo, @indyTechTree, 4, 5);
END
ELSE
BEGIN
	UPDATE techtree SET
		parentdefinition=@liqAmmo,
		groupID=@indyTechTree,
		x=4,
		y=5
	WHERE childdefinition=@fluxAmmo;
END

--Show and delete existing kernel costs
SELECT * FROM techtreenodeprices where definition = @fluxAmmo;
DELETE FROM techtreenodeprices where definition = @fluxAmmo;

--Insert the fresh prices
INSERT INTO techtreenodeprices (definition, pointtype, amount) VALUES
(@fluxAmmo, (SELECT TOP 1 id FROM techtreepointtypes WHERE name='hitech'), 6250),
(@fluxAmmo, (SELECT TOP 1 id FROM techtreepointtypes WHERE name='industrial'), 12500);
GO


--------------------------------------------
-- Add CT defintion and production data
---------------------------------------


PRINT N'INSERTING PROTOTYPE AMMOS';
DROP TABLE IF EXISTS #AMMO_PROTO_DEFS;
CREATE TABLE #AMMO_PROTO_DEFS 
(
	defName varchar(100),
	quantity int,
	attrFlags bigint,
	catFlags bigint,
	genxyOptStr varchar(max),
	note varchar(2048),
	cargoVolume float,
	massOfModule float,
	description nvarchar(100),
	techType int,
	techLevel int
);
INSERT INTO #AMMO_PROTO_DEFS (defName, quantity, attrFlags, catFlags, genxyOptStr, note, cargoVolume, massOfModule, description, techType, techLevel) VALUES
('def_ammo_mining_fluxore_pr',1,2147485696,1290,'mineral=$fluxore','',0.5,0.5,'def_ammo_mining_desc',NULL,NULL),
('def_ammo_mining_gammaterial_pr',1,2147485696,1290,'mineral=$gammaterial','',0.5,0.5,'def_ammo_mining_desc',NULL,NULL);

PRINT N'MERGE (INSERT/UPDATE) PROTO AMMO ENTITYDEFS';
MERGE [dbo].[entitydefaults] def USING #AMMO_PROTO_DEFS ammo
ON def.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=ammo.defName)
WHEN MATCHED
    THEN UPDATE SET
		quantity=ammo.quantity,
		categoryflags=catFlags,
		attributeflags=attrFlags,
		volume=cargoVolume,
		mass=massOfModule,
		tiertype=techType,
		tierlevel=techLevel,
		options=genxyOptStr,
		note=ammo.note,
		enabled=1,
		hidden=0,
		purchasable=1,
		health=100,
		descriptiontoken=description
WHEN NOT MATCHED
    THEN INSERT (definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel) VALUES
	(defName,1,attrFlags,catFlags,genxyOptStr,note,1,cargoVolume,massOfModule,0,100,description,1,techType,techLevel);

PRINT N'AMMO PROTOTYPE PAIRINGS';

DROP TABLE IF EXISTS #PROTOPAIRS;
CREATE TABLE #PROTOPAIRS
(
	defName varchar(100),
	protoDefName varchar(100),
);

INSERT INTO #PROTOPAIRS (defName, protoDefName) VALUES
('def_ammo_mining_fluxore','def_ammo_mining_fluxore_pr'),
('def_ammo_mining_gammaterial','def_ammo_mining_gammaterial_pr');

--DELETE and reinsert
PRINT N'DELETE prototypes FOR ANY EXISTING LARGE WEP-PROTO PAIRS (0 results if first run)';
SELECT * FROM prototypes WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT defName FROM #PROTOPAIRS));
DELETE FROM prototypes WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT defName FROM #PROTOPAIRS));

--INSERT
PRINT N'INSERT prototypes FOR mining ammo PAIRS';
INSERT INTO prototypes (definition, prototype)
SELECT (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = defName), 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = protoDefName)
FROM #PROTOPAIRS;
DROP TABLE IF EXISTS #PROTOPAIRS;


DECLARE @miningAmmoCTCategory BIGINT;
SET @miningAmmoCTCategory = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_ammo_mining_calibration_programs');

PRINT N'ADD/UPDATE def_ammo_mining_fluxore ON entitydefaults';
IF EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_mining_fluxore_cprg')
BEGIN
	UPDATE entitydefaults SET
		definitionname = 'def_ammo_mining_fluxore_cprg',
		quantity = 1,
		attributeflags = 1024,
		categoryflags = @miningAmmoCTCategory,
		options = NULL,
		note = NULL,
		enabled = 1,
		volume = 0.01,
		mass = 0.1,
		hidden = 0,
		health = 100,
		descriptiontoken = 'calibration_program_desc',
		purchasable = 1,
		tiertype = NULL,
		tierlevel = NULL
	WHERE definitionname = 'def_ammo_mining_fluxore_cprg';
END
ELSE
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
	VALUES 
	('def_ammo_mining_fluxore_cprg', 1, 1024, @miningAmmoCTCategory, NULL, NULL, 1, 0.01, 1, 0, 100, 'calibration_program_desc', 1, NULL, NULL); 
END

PRINT N'DELETE calibrationdefaults FOR ANY EXISTING LARGE MOD CTS (0 results if 1st run)';
SELECT * FROM calibrationdefaults WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname ='def_ammo_mining_fluxore_cprg');
DELETE FROM calibrationdefaults WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname ='def_ammo_mining_fluxore_cprg');

PRINT N'INSERT calibrationdefaults FOR MOD CTS';
INSERT INTO calibrationdefaults (definition, materialefficiency, timeefficiency)
SELECT (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_ammo_mining_fluxore_cprg'), 80, 80;

PRINT N'DELETE itemresearchlevels FOR ANY EXISTING LARGE MOD CTS (0 results if 1st run)';
SELECT * FROM itemresearchlevels WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname ='def_ammo_mining_fluxore_pr');
SELECT * FROM itemresearchlevels WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname ='def_ammo_mining_gammaterial_pr');
DELETE FROM itemresearchlevels WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname ='def_ammo_mining_fluxore_pr');
DELETE FROM itemresearchlevels WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname ='def_ammo_mining_gammaterial_pr');

PRINT N'INSERT itemresearchlevels FOR ammo CTS';
INSERT INTO itemresearchlevels (definition, calibrationprogram, researchlevel, enabled) VALUES
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_ammo_mining_fluxore_pr'), 
(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_ammo_mining_fluxore_cprg'), 
1, 1);

INSERT INTO itemresearchlevels (definition, calibrationprogram, researchlevel, enabled) VALUES
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_ammo_mining_gammaterial_pr'), 
(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_ammo_mining_gammaterial_cprg'), 
1, 1);


DROP TABLE IF EXISTS #AMMO_COMPS;
CREATE TABLE #AMMO_COMPS
(
	defName VARCHAR(100),
	commodityName VARCHAR(100),
	amount INT
);
INSERT INTO #AMMO_COMPS (defName, commodityName, amount) VALUES
('def_ammo_mining_fluxore', 'def_unimetal', 10),
('def_ammo_mining_fluxore', 'def_statichnol', 10),
('def_ammo_mining_fluxore', 'def_isopropentol', 10),
('def_ammo_mining_fluxore', 'def_metachropin', 10),

('def_ammo_mining_fluxore_pr', 'def_unimetal', 10),
('def_ammo_mining_fluxore_pr', 'def_statichnol', 10),
('def_ammo_mining_fluxore_pr', 'def_isopropentol', 10),
('def_ammo_mining_fluxore_pr', 'def_metachropin', 10),

('def_ammo_mining_gammaterial_pr', 'def_unimetal', 15),
('def_ammo_mining_gammaterial_pr', 'def_hydrobenol', 15);


PRINT N'DELETE components FOR flux mining ammo (0 results if 1st run)';
SELECT * FROM components WHERE definition IN (SELECT definition FROM entitydefaults WHERE definitionname IN (SELECT DISTINCT defName FROM #AMMO_COMPS));
DELETE FROM components WHERE definition IN (SELECT definition FROM entitydefaults WHERE definitionname IN (SELECT DISTINCT defName FROM #AMMO_COMPS));

PRINT N'INSERT components FOR flux mining ammo';
INSERT INTO components (definition, componentdefinition, componentamount)
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defName),
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=commodityName),
	amount
FROM #AMMO_COMPS;
DROP TABLE IF EXISTS #AMMO_COMPS;
DROP TABLE IF EXISTS #AMMO_PROTO_DEFS;
GO



USE [perpetuumsa]
GO

------------------------------------
--Flux ore scanner ammo NPC Market inf orders
--
--Date: 2020/06/21
------------------------------------

DECLARE @flux_directional INT;
DECLARE @flux_tile INT;
DECLARE @vendorid BIGINT;
DECLARE @sellprice FLOAT;

SET @sellprice = 45;

SET @flux_directional = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_mining_probe_fluxore_direction');
SET @flux_tile = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_mining_probe_fluxore_tile');

--Should be empty on first run
SELECT * FROM marketitems WHERE itemdefinition in (@flux_directional, @flux_tile) AND isvendoritem=1 AND quantity=-1;
DELETE FROM marketitems WHERE itemdefinition in (@flux_directional, @flux_tile) AND isvendoritem=1 AND quantity=-1;


--Declare cursor for vendors that also sell epri scanner charges
DECLARE vendorCursor CURSOR
FOR SELECT submittereid FROM marketitems WHERE
	price=45 AND isvendoritem=1 AND
	itemdefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_mining_probe_epriton_direction');

OPEN vendorCursor;
FETCH NEXT FROM vendorCursor INTO @vendorid;

WHILE @@FETCH_STATUS = 0
    BEGIN
		EXEC dbo.addVendorSellItem @vendorid, @flux_directional, @sellprice, 0;
		EXEC dbo.addVendorSellItem @vendorid, @flux_tile, @sellprice, 0;
		FETCH NEXT FROM vendorCursor INTO @vendorid;
    END;

CLOSE vendorCursor;
DEALLOCATE vendorCursor;

GO



PRINT N'07_Ore_npcs__defintions__2020_05_20';

USE [perpetuumsa]
GO

--Table of each npc defname and its template+template-relation unqiue parameters
PRINT N'CREATE TEMP TABLE FOR NPC DEFINTION AND 1:1 RELATED DATA';
DROP TABLE IF EXISTS #NPCDEFS;
CREATE TABLE #NPCDEFS(
	defName VARCHAR(100),
	ep INT,
	template VARCHAR(max)
);

INSERT INTO #NPCDEFS (defName, ep, template) VALUES
('def_npc_fivepercent_argano',5,'#robot=ic5#head=i52#chassis=i53#leg=i54#container=i149#headModules=[|m0=[|definition=ib1e|slot=i1|ammoDefinition=ib33|ammoQuantity=i5]|m1=[|definition=i32|slot=i2]|m2=[|definition=i33|slot=i3]]#chassisModules=[|m0=[|definition=i23|slot=i1]|m1=[|definition=i23|slot=i2]|m2=[|definition=i348|slot=i3|ammoDefinition=i984|ammoQuantity=i64]]#legModules=[|m0=[|definition=i29|slot=i1]|m1=[|definition=i29|slot=i2]|m2=[|definition=i286|slot=i3]]'),
('def_npc_fivepercent_Laird',5,'#robot=ic6#head=i55#chassis=i56#leg=i57#container=i149#headModules=[|m0=[|definition=ib1e|slot=i1|ammoDefinition=ib33|ammoQuantity=i5]|m1=[|definition=i32|slot=i2]|m2=[|definition=i33|slot=i3]]#chassisModules=[|m0=[|definition=i23|slot=i1]|m1=[|definition=i23|slot=i2]|m2=[|definition=i23|slot=i3]]#legModules=[|m0=[|definition=i29|slot=i1]|m1=[|definition=i29|slot=i2]|m2=[|definition=i286|slot=i3]]'),
('def_npc_tenpercent_castel_rank1',7,'#robot=icc#head=i67#chassis=i68#leg=i69#container=i147#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i2b|slot=i2]|m2=[|definition=i31|slot=i3]|m3=[|definition=i32|slot=i4]]#chassisModules=[|m0=[|definition=i3f|slot=i1|ammoDefinition=i98d|ammoQuantity=i64]|m1=[|definition=i3f|slot=i2|ammoDefinition=i98d|ammoQuantity=i64]|m2=[|definition=i3f|slot=i3|ammoDefinition=i98e|ammoQuantity=i64]|m3=[|definition=i3f|slot=i4|ammoDefinition=i98e|ammoQuantity=i64]]#legModules=[|m0=[|definition=ie|slot=i1]|m1=[|definition=i12|slot=i2]|m2=[|definition=i29|slot=i3]]'),
('def_npc_tenpercent_yagel_rank1',7,'#robot=ic1#head=i46#chassis=i47#leg=i48#container=i147#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i32|slot=i2]|m2=[|definition=i33|slot=i3]]#chassisModules=[|m0=[|definition=i42|slot=i1|ammoDefinition=i981|ammoQuantity=i64]|m1=[|definition=i42|slot=i2|ammoDefinition=i980|ammoQuantity=i64]|m2=[|definition=i42|slot=i3|ammoDefinition=i981|ammoQuantity=i64]|m3=[|definition=i42|slot=i4|ammoDefinition=i980|ammoQuantity=i64]]#legModules=[|m0=[|definition=ie|slot=i1]|m1=[|definition=i12|slot=i2]|m2=[|definition=i285|slot=i3]|m3=[|definition=i29|slot=i4]]'),
('def_npc_tenpercent_prom_rank1',7,'#robot=ic2#head=i49#chassis=i4a#leg=i4b#container=i147#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i32|slot=i2]|m2=[|definition=i33|slot=i3]]#chassisModules=[|m0=[|definition=i39|slot=i1|ammoDefinition=i989|ammoQuantity=i64]|m1=[|definition=i39|slot=i2|ammoDefinition=i989|ammoQuantity=i64]|m2=[|definition=i39|slot=i3|ammoDefinition=i98a|ammoQuantity=i64]|m3=[|definition=i39|slot=i4|ammoDefinition=i98a|ammoQuantity=i64]]#legModules=[|m0=[|definition=i12|slot=i1]|m1=[|definition=ie|slot=i2]|m2=[|definition=i29|slot=i3]|m3=[|definition=i12a|slot=i4]]'),
('def_npc_tenpercent_prom_rank2',8,'#robot=ic2#head=i49#chassis=i4a#leg=i4b#container=i147#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i32|slot=i2]|m2=[|definition=i33|slot=i3]]#chassisModules=[|m0=[|definition=i39|slot=i1|ammoDefinition=i989|ammoQuantity=i64]|m1=[|definition=i39|slot=i2|ammoDefinition=i989|ammoQuantity=i64]|m2=[|definition=i39|slot=i3|ammoDefinition=i98a|ammoQuantity=i64]|m3=[|definition=i39|slot=i4|ammoDefinition=i98a|ammoQuantity=i64]]#legModules=[|m0=[|definition=ie|slot=i1]|m1=[|definition=i12|slot=i2]|m2=[|definition=i29|slot=i3]|m3=[|definition=i12a|slot=i4]]'),
('def_npc_tenpercent_castel_rank2',8,'#robot=icc#head=i67#chassis=i68#leg=i69#container=i147#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i2b|slot=i2]|m2=[|definition=i31|slot=i3]|m3=[|definition=i32|slot=i4]]#chassisModules=[|m0=[|definition=i3f|slot=i1|ammoDefinition=i98d|ammoQuantity=i0]|m1=[|definition=i3f|slot=i2|ammoDefinition=i98d|ammoQuantity=i0]|m2=[|definition=i3f|slot=i3|ammoDefinition=i98e|ammoQuantity=i0]|m3=[|definition=i3f|slot=i4|ammoDefinition=i98e|ammoQuantity=i0]]#legModules=[|m0=[|definition=ie|slot=i1]|m1=[|definition=i12|slot=i2]|m2=[|definition=i29|slot=i3]]'),
('def_npc_tenpercent_yagel_rank2',8,'#robot=ic1#head=i46#chassis=i47#leg=i48#container=i147#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i32|slot=i2]|m2=[|definition=i33|slot=i3]]#chassisModules=[|m0=[|definition=i42|slot=i1|ammoDefinition=if8|ammoQuantity=i64]|m1=[|definition=i42|slot=i2|ammoDefinition=if7|ammoQuantity=i64]|m2=[|definition=i42|slot=i3|ammoDefinition=if8|ammoQuantity=i64]|m3=[|definition=i42|slot=i4|ammoDefinition=if7|ammoQuantity=i64]]#legModules=[|m0=[|definition=ie|slot=i1]|m1=[|definition=i12|slot=i2]|m2=[|definition=i285|slot=i3]|m3=[|definition=i29|slot=i4]]'),
('def_npc_percent_wasp_rank2',10,'#robot=ic4#head=i4f#chassis=i50#leg=i51#container=i148#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i32|slot=i2]|m2=[|definition=i33|slot=i3]|m3=[|definition=i1636|slot=i4]|m4=[|definition=i0|slot=i5]]#chassisModules=[|m0=[|definition=i3f|slot=i1|ammoDefinition=i98d|ammoQuantity=i64]|m1=[|definition=i3f|slot=i2|ammoDefinition=i98d|ammoQuantity=i64]|m2=[|definition=i3f|slot=i3|ammoDefinition=i98d|ammoQuantity=i64]|m3=[|definition=i3f|slot=i4|ammoDefinition=i98d|ammoQuantity=i64]|m4=[|definition=i3f|slot=i5|ammoDefinition=i98d|ammoQuantity=i64]]#legModules=[|m0=[|definition=ie|slot=i1]|m1=[|definition=i12|slot=i2]|m2=[|definition=i29|slot=i3]|m3=[|definition=i12a|slot=i4]]'),
('def_npc_percent_baph_rank2',10,'#robot=ica#head=i61#chassis=i62#leg=i63#container=i148#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i32|slot=i2]|m2=[|definition=i33|slot=i3]|m3=[|definition=i38f|slot=i4]|m4=[|definition=i38f|slot=i5]]#chassisModules=[|m0=[|definition=i39|slot=i1|ammoDefinition=i989|ammoQuantity=i64]|m1=[|definition=i39|slot=i2|ammoDefinition=i989|ammoQuantity=i64]|m2=[|definition=i39|slot=i3|ammoDefinition=i989|ammoQuantity=i64]|m3=[|definition=i39|slot=i4|ammoDefinition=i98a|ammoQuantity=i64]]#legModules=[|m0=[|definition=ie|slot=i1]|m1=[|definition=i12|slot=i2]|m2=[|definition=i29|slot=i3]|m3=[|definition=i12a|slot=i4]|m4=[|definition=i285|slot=i5]]'),
('def_npc_percent_arby_rank2',10,'#robot=ic9#head=i5e#chassis=i5f#leg=i60#container=i148#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i32|slot=i2]|m2=[|definition=i33|slot=i3]|m3=[|definition=ib1e|slot=i4|ammoDefinition=ib33|ammoQuantity=ia]]#chassisModules=[|m0=[|definition=i42|slot=i1|ammoDefinition=i980|ammoQuantity=i64]|m1=[|definition=i42|slot=i2|ammoDefinition=i980|ammoQuantity=i64]|m2=[|definition=i42|slot=i3|ammoDefinition=i980|ammoQuantity=i64]|m3=[|definition=i42|slot=i4|ammoDefinition=i981|ammoQuantity=i64]|m4=[|definition=i42|slot=i5|ammoDefinition=i981|ammoQuantity=i64]]#legModules=[|m0=[|definition=ie|slot=i1]|m1=[|definition=i12|slot=i2]|m2=[|definition=i29|slot=i3]|m3=[|definition=i12a|slot=i4]|m4=[|definition=i285|slot=i5]]'),
('def_npc_percent_arby_rank3',11,'#robot=ic9#head=i5e#chassis=i5f#leg=i60#container=i148#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i32|slot=i2]|m2=[|definition=i33|slot=i3]|m3=[|definition=ib1e|slot=i4|ammoDefinition=ib33|ammoQuantity=ia]]#chassisModules=[|m0=[|definition=i42|slot=i1|ammoDefinition=i980|ammoQuantity=i64]|m1=[|definition=i42|slot=i2|ammoDefinition=i980|ammoQuantity=i64]|m2=[|definition=i42|slot=i3|ammoDefinition=i980|ammoQuantity=i64]|m3=[|definition=i42|slot=i4|ammoDefinition=i981|ammoQuantity=i64]|m4=[|definition=i42|slot=i5|ammoDefinition=i981|ammoQuantity=i64]]#legModules=[|m0=[|definition=ie|slot=i1]|m1=[|definition=i12|slot=i2]|m2=[|definition=i29|slot=i3]|m3=[|definition=i12a|slot=i4]|m4=[|definition=i285|slot=i5]]'),
('def_npc_percent_baph_rank3',11,'#robot=ica#head=i61#chassis=i62#leg=i63#container=i148#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i32|slot=i2]|m2=[|definition=i33|slot=i3]|m3=[|definition=i38f|slot=i4]|m4=[|definition=i38f|slot=i5]]#chassisModules=[|m0=[|definition=i39|slot=i1|ammoDefinition=i989|ammoQuantity=i64]|m1=[|definition=i39|slot=i2|ammoDefinition=i989|ammoQuantity=i64]|m2=[|definition=i39|slot=i3|ammoDefinition=i989|ammoQuantity=i64]|m3=[|definition=i39|slot=i4|ammoDefinition=i98a|ammoQuantity=i64]]#legModules=[|m0=[|definition=ie|slot=i1]|m1=[|definition=i12|slot=i2]|m2=[|definition=i29|slot=i3]|m3=[|definition=i12a|slot=i4]|m4=[|definition=i285|slot=i5]]'),
('def_npc_percent_wasp_rank3',11,'#robot=ic4#head=i4f#chassis=i50#leg=i51#container=i148#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i32|slot=i2]|m2=[|definition=i33|slot=i3]|m3=[|definition=i1636|slot=i4]|m4=[|definition=i0|slot=i5]]#chassisModules=[|m0=[|definition=i3f|slot=i1|ammoDefinition=i98d|ammoQuantity=i64]|m1=[|definition=i3f|slot=i2|ammoDefinition=i98d|ammoQuantity=i64]|m2=[|definition=i3f|slot=i3|ammoDefinition=i98d|ammoQuantity=i64]|m3=[|definition=i3f|slot=i4|ammoDefinition=i98e|ammoQuantity=i64]|m4=[|definition=i3f|slot=i5|ammoDefinition=i98e|ammoQuantity=i64]|m5=[|definition=i0|slot=i6]]#legModules=[|m0=[|definition=ie|slot=i1]|m1=[|definition=i12|slot=i2]|m2=[|definition=i12a|slot=i3]|m3=[|definition=i285|slot=i4]]'),
('def_npc_percent_wasp_rank4',12,'#robot=ic4#head=i4f#chassis=i50#leg=i51#container=i148#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i32|slot=i2]|m2=[|definition=i33|slot=i3]|m3=[|definition=i1636|slot=i4]|m4=[|definition=i0|slot=i5]]#chassisModules=[|m0=[|definition=i3f|slot=i1|ammoDefinition=i98d|ammoQuantity=i64]|m1=[|definition=i3f|slot=i2|ammoDefinition=i98d|ammoQuantity=i64]|m2=[|definition=i3f|slot=i3|ammoDefinition=i98d|ammoQuantity=i64]|m3=[|definition=i3f|slot=i4|ammoDefinition=i98e|ammoQuantity=i64]|m4=[|definition=i3f|slot=i5|ammoDefinition=i98e|ammoQuantity=i64]|m5=[|definition=i0|slot=i6]]#legModules=[|m0=[|definition=ie|slot=i1]|m1=[|definition=i12|slot=i2]|m2=[|definition=i12a|slot=i3]|m3=[|definition=i285|slot=i4]]'),
('def_npc_percent_baph_rank4',12,'#robot=ica#head=i61#chassis=i62#leg=i63#container=i148#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i32|slot=i2]|m2=[|definition=i33|slot=i3]|m3=[|definition=i38f|slot=i4]|m4=[|definition=i38f|slot=i5]]#chassisModules=[|m0=[|definition=i39|slot=i1|ammoDefinition=i989|ammoQuantity=i64]|m1=[|definition=i39|slot=i2|ammoDefinition=i989|ammoQuantity=i64]|m2=[|definition=i39|slot=i3|ammoDefinition=i989|ammoQuantity=i64]|m3=[|definition=i39|slot=i4|ammoDefinition=i98a|ammoQuantity=i64]|m4=[|definition=i39|slot=i5|ammoDefinition=i98a|ammoQuantity=i64]]#legModules=[|m0=[|definition=ie|slot=i1]|m1=[|definition=i12|slot=i2]|m2=[|definition=i29|slot=i3]|m3=[|definition=i12a|slot=i4]|m4=[|definition=i285|slot=i5]]'),
('def_npc_percent_arby_rank4',12,'#robot=ic9#head=i5e#chassis=i5f#leg=i60#container=i148#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i32|slot=i2]|m2=[|definition=i33|slot=i3]|m3=[|definition=ib1e|slot=i4|ammoDefinition=ib33|ammoQuantity=ia]]#chassisModules=[|m0=[|definition=i42|slot=i1|ammoDefinition=i980|ammoQuantity=i8c]|m1=[|definition=i42|slot=i2|ammoDefinition=i980|ammoQuantity=i64]|m2=[|definition=i42|slot=i3|ammoDefinition=i980|ammoQuantity=i64]|m3=[|definition=i42|slot=i4|ammoDefinition=i981|ammoQuantity=i64]|m4=[|definition=i42|slot=i5|ammoDefinition=i981|ammoQuantity=i64]|m5=[|definition=i0|slot=i6]]#legModules=[|m0=[|definition=ie|slot=i1]|m1=[|definition=i12|slot=i2]|m2=[|definition=i29|slot=i3]|m3=[|definition=i12a|slot=i4]|m4=[|definition=i285|slot=i5]]'),
('def_npc_percent_kain_rank3',15,'#robot=icd#head=i6a#chassis=i6b#leg=i6c#container=i14a#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i38d|slot=i2]|m2=[|definition=i38d|slot=i3]|m3=[|definition=i38d|slot=i4]]#chassisModules=[|m0=[|definition=i43|slot=i1|ammoDefinition=i982|ammoQuantity=i64]|m1=[|definition=i43|slot=i2|ammoDefinition=i982|ammoQuantity=i64]|m2=[|definition=i43|slot=i3|ammoDefinition=i982|ammoQuantity=i64]|m3=[|definition=i43|slot=i4|ammoDefinition=i982|ammoQuantity=i64]|m4=[|definition=i0|slot=i5]|m5=[|definition=i0|slot=i6]]#legModules=[|m0=[|definition=i10|slot=i1]|m1=[|definition=i13|slot=i2]|m2=[|definition=i18|slot=i3]|m3=[|definition=i1a|slot=i4]|m4=[|definition=i1b|slot=i5]]'),
('def_npc_percent_kain_rank4',16,'#robot=icd#head=i6a#chassis=i6b#leg=i6c#container=i14a#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i38d|slot=i2]|m2=[|definition=i38d|slot=i3]|m3=[|definition=i38d|slot=i4]]#chassisModules=[|m0=[|definition=i43|slot=i1|ammoDefinition=i982|ammoQuantity=i64]|m1=[|definition=i43|slot=i2|ammoDefinition=i982|ammoQuantity=i64]|m2=[|definition=i43|slot=i3|ammoDefinition=i982|ammoQuantity=i64]|m3=[|definition=i43|slot=i4|ammoDefinition=i982|ammoQuantity=i64]|m4=[|definition=i0|slot=i5]|m5=[|definition=i0|slot=i6]]#legModules=[|m0=[|definition=i10|slot=i1]|m1=[|definition=i13|slot=i2]|m2=[|definition=i18|slot=i3]|m3=[|definition=i1a|slot=i4]|m4=[|definition=i1b|slot=i5]]'),
('def_npc_percent_kain_rank5',17,'#robot=icd#head=i6a#chassis=i6b#leg=i6c#container=i14a#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i38d|slot=i2]|m2=[|definition=i38d|slot=i3]|m3=[|definition=i38d|slot=i4]]#chassisModules=[|m0=[|definition=i43|slot=i1|ammoDefinition=i982|ammoQuantity=i64]|m1=[|definition=i43|slot=i2|ammoDefinition=i982|ammoQuantity=i64]|m2=[|definition=i43|slot=i3|ammoDefinition=i982|ammoQuantity=i64]|m3=[|definition=i43|slot=i4|ammoDefinition=i982|ammoQuantity=i64]|m4=[|definition=i0|slot=i5]|m5=[|definition=i0|slot=i6]]#legModules=[|m0=[|definition=i10|slot=i1]|m1=[|definition=i13|slot=i2]|m2=[|definition=i18|slot=i3]|m3=[|definition=i1a|slot=i4]|m4=[|definition=i1b|slot=i5]]'),
('def_npc_percent_arty_rank5',17,'#robot=ice#head=i6d#chassis=i6e#leg=i6f#container=i14a#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i2b|slot=i2]|m2=[|definition=i391|slot=i3]|m3=[|definition=i391|slot=i4]|m4=[|definition=i38f|slot=i5]]#chassisModules=[|m0=[|definition=i3a|slot=i1|ammoDefinition=i98b|ammoQuantity=i64]|m1=[|definition=i3a|slot=i2|ammoDefinition=i98b|ammoQuantity=i64]|m2=[|definition=i3a|slot=i3|ammoDefinition=i98b|ammoQuantity=i64]|m3=[|definition=i3a|slot=i4|ammoDefinition=i98b|ammoQuantity=i64]|m4=[|definition=i0|slot=i5]]#legModules=[|m0=[|definition=i10|slot=i1]|m1=[|definition=i13|slot=i2]|m2=[|definition=i19|slot=i3]|m3=[|definition=i1a|slot=i4]|m4=[|definition=i1b|slot=i5]]'),
('def_npc_percent_arty_rank4',16,'#robot=ice#head=i6d#chassis=i6e#leg=i6f#container=i14a#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i2b|slot=i2]|m2=[|definition=i391|slot=i3]|m3=[|definition=i391|slot=i4]|m4=[|definition=i38f|slot=i5]]#chassisModules=[|m0=[|definition=i3a|slot=i1|ammoDefinition=i98b|ammoQuantity=i64]|m1=[|definition=i3a|slot=i2|ammoDefinition=i98b|ammoQuantity=i64]|m2=[|definition=i3a|slot=i3|ammoDefinition=i98b|ammoQuantity=i64]|m3=[|definition=i3a|slot=i4|ammoDefinition=i98b|ammoQuantity=i64]|m4=[|definition=i0|slot=i5]]#legModules=[|m0=[|definition=i10|slot=i1]|m1=[|definition=i13|slot=i2]|m2=[|definition=i19|slot=i3]|m3=[|definition=i1a|slot=i4]|m4=[|definition=i1b|slot=i5]]'),
('def_npc_percent_arty_rank3',15,'#robot=ice#head=i6d#chassis=i6e#leg=i6f#container=i14a#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i2b|slot=i2]|m2=[|definition=i391|slot=i3]|m3=[|definition=i391|slot=i4]|m4=[|definition=i38f|slot=i5]]#chassisModules=[|m0=[|definition=i3a|slot=i1|ammoDefinition=i98b|ammoQuantity=i64]|m1=[|definition=i3a|slot=i2|ammoDefinition=i98b|ammoQuantity=i64]|m2=[|definition=i3a|slot=i3|ammoDefinition=i98b|ammoQuantity=i64]|m3=[|definition=i3a|slot=i4|ammoDefinition=i98b|ammoQuantity=i64]|m4=[|definition=i0|slot=i5]]#legModules=[|m0=[|definition=i10|slot=i1]|m1=[|definition=i13|slot=i2]|m2=[|definition=i19|slot=i3]|m3=[|definition=i1a|slot=i4]|m4=[|definition=i1b|slot=i5]]'),
('def_npc_percent_tyro_rank3',15,'#robot=id0#head=i73#chassis=i74#leg=i75#container=i14a#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i2b|slot=i2]|m2=[|definition=i391|slot=i3]|m3=[|definition=i391|slot=i4]|m4=[|definition=ib52|slot=i5]]#chassisModules=[|m0=[|definition=i40|slot=i1|ammoDefinition=i992|ammoQuantity=i64]|m1=[|definition=i40|slot=i2|ammoDefinition=i992|ammoQuantity=i64]|m2=[|definition=i40|slot=i3|ammoDefinition=i992|ammoQuantity=i64]|m3=[|definition=i40|slot=i4|ammoDefinition=i992|ammoQuantity=i64]|m4=[|definition=i0|slot=i5]|m5=[|definition=i0|slot=i6]]#legModules=[|m0=[|definition=i10|slot=i1]|m1=[|definition=i13|slot=i2]|m2=[|definition=i29|slot=i3]|m3=[|definition=i286|slot=i4]]'),
('def_npc_percent_tyro_rank4',16,'#robot=id0#head=i73#chassis=i74#leg=i75#container=i14a#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i2b|slot=i2]|m2=[|definition=i391|slot=i3]|m3=[|definition=i391|slot=i4]|m4=[|definition=ib52|slot=i5]]#chassisModules=[|m0=[|definition=i40|slot=i1|ammoDefinition=i992|ammoQuantity=i64]|m1=[|definition=i40|slot=i2|ammoDefinition=i992|ammoQuantity=i64]|m2=[|definition=i40|slot=i3|ammoDefinition=i992|ammoQuantity=i64]|m3=[|definition=i40|slot=i4|ammoDefinition=i992|ammoQuantity=i64]|m4=[|definition=i0|slot=i5]|m5=[|definition=i0|slot=i6]]#legModules=[|m0=[|definition=i10|slot=i1]|m1=[|definition=i13|slot=i2]|m2=[|definition=i29|slot=i3]|m3=[|definition=i286|slot=i4]]'),
('def_npc_percent_tyro_rank5',17,'#robot=id0#head=i73#chassis=i74#leg=i75#container=i14a#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i2b|slot=i2]|m2=[|definition=i391|slot=i3]|m3=[|definition=i391|slot=i4]|m4=[|definition=ib52|slot=i5]]#chassisModules=[|m0=[|definition=i40|slot=i1|ammoDefinition=i992|ammoQuantity=i64]|m1=[|definition=i40|slot=i2|ammoDefinition=i992|ammoQuantity=i64]|m2=[|definition=i40|slot=i3|ammoDefinition=i992|ammoQuantity=i64]|m3=[|definition=i40|slot=i4|ammoDefinition=i992|ammoQuantity=i64]|m4=[|definition=i0|slot=i5]|m5=[|definition=i0|slot=i6]]#legModules=[|m0=[|definition=i10|slot=i1]|m1=[|definition=i13|slot=i2]|m2=[|definition=i289|slot=i3]|m3=[|definition=i29|slot=i4]]'),
('def_npc_percent_gropho_rank5',25,'#robot=id8#head=i8b#chassis=i8c#leg=i8d#container=i14c#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i2b|slot=i2]|m2=[|definition=i391|slot=i3]|m3=[|definition=i391|slot=i4]|m4=[|definition=i38e|slot=i5]|m5=[|definition=i38e|slot=i6]]#chassisModules=[|m0=[|definition=i40|slot=i1|ammoDefinition=i991|ammoQuantity=i64]|m1=[|definition=i40|slot=i2|ammoDefinition=i991|ammoQuantity=i64]|m2=[|definition=i40|slot=i3|ammoDefinition=i991|ammoQuantity=i64]|m3=[|definition=i40|slot=i4|ammoDefinition=i991|ammoQuantity=i64]|m4=[|definition=i40|slot=i5|ammoDefinition=i991|ammoQuantity=i64]|m5=[|definition=i40|slot=i6|ammoDefinition=i991|ammoQuantity=i64]|m6=[|definition=i0|slot=i7]]#legModules=[|m0=[|definition=i10|slot=i1]|m1=[|definition=i10|slot=i2]|m2=[|definition=i13|slot=i3]|m3=[|definition=i1a|slot=i4]|m4=[|definition=i19|slot=i5]]'),
('def_npc_percent_gropho_rank4',20,'#robot=id8#head=i8b#chassis=i8c#leg=i8d#container=i14c#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i2b|slot=i2]|m2=[|definition=i38e|slot=i3]|m3=[|definition=i38e|slot=i4]|m4=[|definition=i391|slot=i5]|m5=[|definition=i391|slot=i6]]#chassisModules=[|m0=[|definition=i40|slot=i1|ammoDefinition=i991|ammoQuantity=i64]|m1=[|definition=i40|slot=i2|ammoDefinition=i991|ammoQuantity=i64]|m2=[|definition=i40|slot=i3|ammoDefinition=i991|ammoQuantity=i64]|m3=[|definition=i40|slot=i4|ammoDefinition=i991|ammoQuantity=i64]|m4=[|definition=i40|slot=i5|ammoDefinition=i991|ammoQuantity=i64]|m5=[|definition=i40|slot=i6|ammoDefinition=i991|ammoQuantity=i64]|m6=[|definition=i0|slot=i7]]#legModules=[|m0=[|definition=i10|slot=i1]|m1=[|definition=i10|slot=i2]|m2=[|definition=i13|slot=i3]|m3=[|definition=i1a|slot=i4]|m4=[|definition=i19|slot=i5]]'),
('def_npc_percent_seth_rank4',20,'#robot=id6#head=i85#chassis=i86#leg=i87#container=i14c#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i2b|slot=i2]|m2=[|definition=i38f|slot=i3]|m3=[|definition=i38f|slot=i4]|m4=[|definition=i38f|slot=i5]|m5=[|definition=i38f|slot=i6]]#chassisModules=[|m0=[|definition=i3a|slot=i1|ammoDefinition=i98b|ammoQuantity=i64]|m1=[|definition=i3a|slot=i2|ammoDefinition=i98b|ammoQuantity=i64]|m2=[|definition=i3a|slot=i3|ammoDefinition=i98b|ammoQuantity=i64]|m3=[|definition=i3a|slot=i4|ammoDefinition=i98b|ammoQuantity=i64]|m4=[|definition=i3a|slot=i5|ammoDefinition=i98b|ammoQuantity=i64]|m5=[|definition=i3a|slot=i6|ammoDefinition=i98b|ammoQuantity=i64]]#legModules=[|m0=[|definition=i10|slot=i1]|m1=[|definition=i10|slot=i2]|m2=[|definition=i13|slot=i3]|m3=[|definition=i29|slot=i4]|m4=[|definition=i286|slot=i5]|m5=[|definition=i1b|slot=i6]]'),
('def_npc_percent_seth_rank5',25,'#robot=id6#head=i85#chassis=i86#leg=i87#container=i14c#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i2b|slot=i2]|m2=[|definition=i38f|slot=i3]|m3=[|definition=i38f|slot=i4]|m4=[|definition=i38f|slot=i5]|m5=[|definition=i38f|slot=i6]]#chassisModules=[|m0=[|definition=i3a|slot=i1|ammoDefinition=i98b|ammoQuantity=i64]|m1=[|definition=i3a|slot=i2|ammoDefinition=i98b|ammoQuantity=i64]|m2=[|definition=i3a|slot=i3|ammoDefinition=i98b|ammoQuantity=i64]|m3=[|definition=i3a|slot=i4|ammoDefinition=i98b|ammoQuantity=i64]|m4=[|definition=i3a|slot=i5|ammoDefinition=i98b|ammoQuantity=i64]|m5=[|definition=i3a|slot=i6|ammoDefinition=i98b|ammoQuantity=i64]]#legModules=[|m0=[|definition=i10|slot=i1]|m1=[|definition=i10|slot=i2]|m2=[|definition=i13|slot=i3]|m3=[|definition=i286|slot=i4]|m4=[|definition=i29|slot=i5]|m5=[|definition=i1b|slot=i6]]'),
('def_npc_percent_mesmer_rank5',25,'#robot=id5#head=i82#chassis=i83#leg=i84#container=i14c#headModules=[|m0=[|definition=i424|slot=i1]|m1=[|definition=i424|slot=i2]|m2=[|definition=i424|slot=i3]|m3=[|definition=i424|slot=i4]|m4=[|definition=i31|slot=i5]]#chassisModules=[|m0=[|definition=i43|slot=i1|ammoDefinition=i982|ammoQuantity=i64]|m1=[|definition=i43|slot=i2|ammoDefinition=i982|ammoQuantity=i64]|m2=[|definition=i43|slot=i3|ammoDefinition=i982|ammoQuantity=i64]|m3=[|definition=i43|slot=i4|ammoDefinition=i982|ammoQuantity=i64]|m4=[|definition=i43|slot=i5|ammoDefinition=i982|ammoQuantity=i64]|m5=[|definition=i43|slot=i6|ammoDefinition=i982|ammoQuantity=i64]|m6=[|definition=i0|slot=i7]]#legModules=[|m0=[|definition=i286|slot=i1]|m1=[|definition=i286|slot=i2]|m2=[|definition=i289|slot=i3]|m3=[|definition=i13|slot=i4]|m4=[|definition=i13|slot=i5]|m5=[|definition=i13|slot=i6]]'),
('def_npc_percent_mesmer_rank4',20,'#robot=id5#head=i82#chassis=i83#leg=i84#container=i14c#headModules=[|m0=[|definition=i424|slot=i1]|m1=[|definition=i424|slot=i2]|m2=[|definition=i424|slot=i3]|m3=[|definition=i424|slot=i4]|m4=[|definition=i31|slot=i5]]#chassisModules=[|m0=[|definition=i43|slot=i1|ammoDefinition=i982|ammoQuantity=i64]|m1=[|definition=i43|slot=i2|ammoDefinition=i982|ammoQuantity=i64]|m2=[|definition=i43|slot=i3|ammoDefinition=i982|ammoQuantity=i64]|m3=[|definition=i43|slot=i4|ammoDefinition=i982|ammoQuantity=i64]|m4=[|definition=i43|slot=i5|ammoDefinition=i982|ammoQuantity=i64]|m5=[|definition=i43|slot=i6|ammoDefinition=i982|ammoQuantity=i64]|m6=[|definition=i0|slot=i7]]#legModules=[|m0=[|definition=i286|slot=i1]|m1=[|definition=i286|slot=i2]|m2=[|definition=i289|slot=i3]|m3=[|definition=i13|slot=i4]|m4=[|definition=i13|slot=i5]|m5=[|definition=i13|slot=i6]]');


PRINT N'CREATE TEMP TABLE FOR NPC MODIFIERS (aggregatevalues)';
DROP TABLE IF EXISTS #NPCMODS;
CREATE TABLE #NPCMODS 
(
	defName VARCHAR(100),
	fieldName VARCHAR(100),
	fieldValue FLOAT,
);
INSERT INTO #NPCMODS (defName, fieldName, fieldValue) VALUES
('def_npc_fivepercent_argano','resist_chemical',50),
('def_npc_fivepercent_argano','resist_explosive',50),
('def_npc_fivepercent_argano','resist_kinetic',50),
('def_npc_fivepercent_argano','resist_thermal',50),
('def_npc_fivepercent_argano','armor_max_modifier',0.6),
('def_npc_fivepercent_argano','armor_repair_amount_modifier',0.5),
('def_npc_fivepercent_argano','cpu_max_modifier',2),
('def_npc_fivepercent_argano','damage_modifier',0.6),
('def_npc_fivepercent_argano','missile_cycle_time_modifier',1.2),
('def_npc_fivepercent_argano','powergrid_max_modifier',2),
('def_npc_fivepercent_argano','speed_max_modifier',0.6),
('def_npc_fivepercent_argano','turret_cycle_time_modifier',1.4),
('def_npc_fivepercent_argano','received_repaired_modifier',0.6),

('def_npc_fivepercent_Laird','resist_chemical',50),
('def_npc_fivepercent_Laird','resist_explosive',50),
('def_npc_fivepercent_Laird','resist_kinetic',50),
('def_npc_fivepercent_Laird','resist_thermal',50),
('def_npc_fivepercent_Laird','armor_max_modifier',0.6),
('def_npc_fivepercent_Laird','armor_repair_amount_modifier',0.5),
('def_npc_fivepercent_Laird','cpu_max_modifier',2),
('def_npc_fivepercent_Laird','damage_modifier',0.6),
('def_npc_fivepercent_Laird','missile_cycle_time_modifier',1.2),
('def_npc_fivepercent_Laird','powergrid_max_modifier',2),
('def_npc_fivepercent_Laird','speed_max_modifier',0.6),
('def_npc_fivepercent_Laird','turret_cycle_time_modifier',1.4),
('def_npc_fivepercent_Laird','received_repaired_modifier',0.6),

('def_npc_tenpercent_castel_rank1','resist_chemical',50),
('def_npc_tenpercent_castel_rank1','resist_explosive',50),
('def_npc_tenpercent_castel_rank1','resist_kinetic',50),
('def_npc_tenpercent_castel_rank1','resist_thermal',50),
('def_npc_tenpercent_castel_rank1','armor_max_modifier',0.6),
('def_npc_tenpercent_castel_rank1','armor_repair_amount_modifier',0.5),
('def_npc_tenpercent_castel_rank1','cpu_max_modifier',2),
('def_npc_tenpercent_castel_rank1','damage_modifier',0.6),
('def_npc_tenpercent_castel_rank1','missile_cycle_time_modifier',1.2),
('def_npc_tenpercent_castel_rank1','powergrid_max_modifier',2),
('def_npc_tenpercent_castel_rank1','speed_max_modifier',0.6),
('def_npc_tenpercent_castel_rank1','turret_cycle_time_modifier',1.4),
('def_npc_tenpercent_castel_rank1','received_repaired_modifier',0.6),

('def_npc_tenpercent_yagel_rank1','resist_chemical',50),
('def_npc_tenpercent_yagel_rank1','resist_explosive',50),
('def_npc_tenpercent_yagel_rank1','resist_kinetic',50),
('def_npc_tenpercent_yagel_rank1','resist_thermal',50),
('def_npc_tenpercent_yagel_rank1','armor_max_modifier',0.6),
('def_npc_tenpercent_yagel_rank1','armor_repair_amount_modifier',0.5),
('def_npc_tenpercent_yagel_rank1','cpu_max_modifier',2),
('def_npc_tenpercent_yagel_rank1','damage_modifier',0.6),
('def_npc_tenpercent_yagel_rank1','missile_cycle_time_modifier',1.2),
('def_npc_tenpercent_yagel_rank1','powergrid_max_modifier',2),
('def_npc_tenpercent_yagel_rank1','speed_max_modifier',0.6),
('def_npc_tenpercent_yagel_rank1','turret_cycle_time_modifier',1.4),
('def_npc_tenpercent_yagel_rank1','received_repaired_modifier',0.6),

('def_npc_tenpercent_prom_rank1','resist_chemical',50),
('def_npc_tenpercent_prom_rank1','resist_explosive',50),
('def_npc_tenpercent_prom_rank1','resist_kinetic',50),
('def_npc_tenpercent_prom_rank1','resist_thermal',50),
('def_npc_tenpercent_prom_rank1','armor_max_modifier',0.6),
('def_npc_tenpercent_prom_rank1','armor_repair_amount_modifier',0.5),
('def_npc_tenpercent_prom_rank1','cpu_max_modifier',2),
('def_npc_tenpercent_prom_rank1','damage_modifier',0.6),
('def_npc_tenpercent_prom_rank1','missile_cycle_time_modifier',1.2),
('def_npc_tenpercent_prom_rank1','powergrid_max_modifier',2),
('def_npc_tenpercent_prom_rank1','speed_max_modifier',0.6),
('def_npc_tenpercent_prom_rank1','turret_cycle_time_modifier',1.4),
('def_npc_tenpercent_prom_rank1','received_repaired_modifier',0.6),

('def_npc_tenpercent_prom_rank2','resist_chemical',75),
('def_npc_tenpercent_prom_rank2','resist_explosive',75),
('def_npc_tenpercent_prom_rank2','resist_kinetic',75),
('def_npc_tenpercent_prom_rank2','resist_thermal',75),
('def_npc_tenpercent_prom_rank2','armor_max_modifier',0.95),
('def_npc_tenpercent_prom_rank2','cpu_max_modifier',2),
('def_npc_tenpercent_prom_rank2','optimal_range_modifier',1.1),
('def_npc_tenpercent_prom_rank2','powergrid_max_modifier',2),
('def_npc_tenpercent_prom_rank2','speed_max_modifier',0.6),
('def_npc_tenpercent_prom_rank2','received_repaired_modifier',0.9),

('def_npc_tenpercent_castel_rank2','resist_chemical',75),
('def_npc_tenpercent_castel_rank2','resist_explosive',75),
('def_npc_tenpercent_castel_rank2','resist_kinetic',75),
('def_npc_tenpercent_castel_rank2','resist_thermal',75),
('def_npc_tenpercent_castel_rank2','armor_max_modifier',0.95),
('def_npc_tenpercent_castel_rank2','cpu_max_modifier',2),
('def_npc_tenpercent_castel_rank2','optimal_range_modifier',1.1),
('def_npc_tenpercent_castel_rank2','powergrid_max_modifier',2),
('def_npc_tenpercent_castel_rank2','speed_max_modifier',0.6),
('def_npc_tenpercent_castel_rank2','received_repaired_modifier',0.9),

('def_npc_tenpercent_yagel_rank2','resist_chemical',75),
('def_npc_tenpercent_yagel_rank2','resist_explosive',75),
('def_npc_tenpercent_yagel_rank2','resist_kinetic',75),
('def_npc_tenpercent_yagel_rank2','resist_thermal',75),
('def_npc_tenpercent_yagel_rank2','armor_max_modifier',0.95),
('def_npc_tenpercent_yagel_rank2','cpu_max_modifier',2),
('def_npc_tenpercent_yagel_rank2','optimal_range_modifier',1.1),
('def_npc_tenpercent_yagel_rank2','powergrid_max_modifier',2),
('def_npc_tenpercent_yagel_rank2','speed_max_modifier',0.6),
('def_npc_tenpercent_yagel_rank2','received_repaired_modifier',0.9),

('def_npc_percent_wasp_rank2','resist_chemical',75),
('def_npc_percent_wasp_rank2','resist_explosive',75),
('def_npc_percent_wasp_rank2','resist_kinetic',75),
('def_npc_percent_wasp_rank2','resist_thermal',75),
('def_npc_percent_wasp_rank2','armor_max_modifier',0.95),
('def_npc_percent_wasp_rank2','cpu_max_modifier',2),
('def_npc_percent_wasp_rank2','optimal_range_modifier',1.1),
('def_npc_percent_wasp_rank2','powergrid_max_modifier',2),
('def_npc_percent_wasp_rank2','speed_max_modifier',0.6),
('def_npc_percent_wasp_rank2','received_repaired_modifier',0.9),

('def_npc_percent_baph_rank2','resist_chemical',75),
('def_npc_percent_baph_rank2','resist_explosive',75),
('def_npc_percent_baph_rank2','resist_kinetic',75),
('def_npc_percent_baph_rank2','resist_thermal',75),
('def_npc_percent_baph_rank2','armor_max_modifier',0.95),
('def_npc_percent_baph_rank2','cpu_max_modifier',2),
('def_npc_percent_baph_rank2','optimal_range_modifier',1.1),
('def_npc_percent_baph_rank2','powergrid_max_modifier',2),
('def_npc_percent_baph_rank2','speed_max_modifier',0.6),
('def_npc_percent_baph_rank2','received_repaired_modifier',0.9),

('def_npc_percent_arby_rank2','resist_chemical',75),
('def_npc_percent_arby_rank2','resist_explosive',75),
('def_npc_percent_arby_rank2','resist_kinetic',75),
('def_npc_percent_arby_rank2','resist_thermal',75),
('def_npc_percent_arby_rank2','armor_max_modifier',0.95),
('def_npc_percent_arby_rank2','cpu_max_modifier',2),
('def_npc_percent_arby_rank2','optimal_range_modifier',1.1),
('def_npc_percent_arby_rank2','powergrid_max_modifier',2),
('def_npc_percent_arby_rank2','speed_max_modifier',0.6),
('def_npc_percent_arby_rank2','received_repaired_modifier',0.9),

('def_npc_percent_arby_rank3','resist_chemical',100),
('def_npc_percent_arby_rank3','resist_explosive',100),
('def_npc_percent_arby_rank3','resist_kinetic',100),
('def_npc_percent_arby_rank3','resist_thermal',100),
('def_npc_percent_arby_rank3','armor_max_modifier',1.3),
('def_npc_percent_arby_rank3','core_max_modifier',1.2),
('def_npc_percent_arby_rank3','core_recharge_time_modifier',0.8),
('def_npc_percent_arby_rank3','cpu_max_modifier',2),
('def_npc_percent_arby_rank3','damage_modifier',1.2),
('def_npc_percent_arby_rank3','falloff_modifier',1.2),
('def_npc_percent_arby_rank3','locking_range_modifier',1.1),
('def_npc_percent_arby_rank3','locking_time_modifier',0.9),
('def_npc_percent_arby_rank3','missile_cycle_time_modifier',0.9),
('def_npc_percent_arby_rank3','optimal_range_modifier',1.2),
('def_npc_percent_arby_rank3','powergrid_max_modifier',2),
('def_npc_percent_arby_rank3','speed_max_modifier',0.6),
('def_npc_percent_arby_rank3','turret_cycle_time_modifier',0.9),
('def_npc_percent_arby_rank3','received_repaired_modifier',1.1),

('def_npc_percent_baph_rank3','resist_chemical',100),
('def_npc_percent_baph_rank3','resist_explosive',100),
('def_npc_percent_baph_rank3','resist_kinetic',100),
('def_npc_percent_baph_rank3','resist_thermal',100),
('def_npc_percent_baph_rank3','armor_max_modifier',1.3),
('def_npc_percent_baph_rank3','core_max_modifier',1.2),
('def_npc_percent_baph_rank3','core_recharge_time_modifier',0.8),
('def_npc_percent_baph_rank3','cpu_max_modifier',2),
('def_npc_percent_baph_rank3','damage_modifier',1.2),
('def_npc_percent_baph_rank3','falloff_modifier',1.2),
('def_npc_percent_baph_rank3','locking_range_modifier',1.1),
('def_npc_percent_baph_rank3','locking_time_modifier',0.9),
('def_npc_percent_baph_rank3','missile_cycle_time_modifier',0.9),
('def_npc_percent_baph_rank3','optimal_range_modifier',1.2),
('def_npc_percent_baph_rank3','powergrid_max_modifier',2),
('def_npc_percent_baph_rank3','speed_max_modifier',0.6),
('def_npc_percent_baph_rank3','turret_cycle_time_modifier',0.9),
('def_npc_percent_baph_rank3','received_repaired_modifier',1.1),

('def_npc_percent_wasp_rank3','resist_chemical',100),
('def_npc_percent_wasp_rank3','resist_explosive',100),
('def_npc_percent_wasp_rank3','resist_kinetic',100),
('def_npc_percent_wasp_rank3','resist_thermal',100),
('def_npc_percent_wasp_rank3','armor_max_modifier',1.3),
('def_npc_percent_wasp_rank3','core_max_modifier',1.2),
('def_npc_percent_wasp_rank3','core_recharge_time_modifier',0.8),
('def_npc_percent_wasp_rank3','cpu_max_modifier',2),
('def_npc_percent_wasp_rank3','damage_modifier',1.2),
('def_npc_percent_wasp_rank3','falloff_modifier',1.2),
('def_npc_percent_wasp_rank3','locking_range_modifier',1.1),
('def_npc_percent_wasp_rank3','locking_time_modifier',0.9),
('def_npc_percent_wasp_rank3','missile_cycle_time_modifier',0.9),
('def_npc_percent_wasp_rank3','optimal_range_modifier',1.2),
('def_npc_percent_wasp_rank3','powergrid_max_modifier',2),
('def_npc_percent_wasp_rank3','speed_max_modifier',0.6),
('def_npc_percent_wasp_rank3','turret_cycle_time_modifier',0.9),
('def_npc_percent_wasp_rank3','received_repaired_modifier',1.1),

('def_npc_percent_wasp_rank4','resist_chemical',125),
('def_npc_percent_wasp_rank4','resist_explosive',125),
('def_npc_percent_wasp_rank4','resist_kinetic',125),
('def_npc_percent_wasp_rank4','resist_thermal',125),
('def_npc_percent_wasp_rank4','armor_max_modifier',1.5),
('def_npc_percent_wasp_rank4','core_max_modifier',1.3),
('def_npc_percent_wasp_rank4','core_recharge_time_modifier',0.7),
('def_npc_percent_wasp_rank4','cpu_max_modifier',2),
('def_npc_percent_wasp_rank4','damage_modifier',1.3),
('def_npc_percent_wasp_rank4','falloff_modifier',1.3),
('def_npc_percent_wasp_rank4','locking_range_modifier',1.1),
('def_npc_percent_wasp_rank4','locking_time_modifier',0.9),
('def_npc_percent_wasp_rank4','missile_cycle_time_modifier',0.8),
('def_npc_percent_wasp_rank4','optimal_range_modifier',1.3),
('def_npc_percent_wasp_rank4','powergrid_max_modifier',2),
('def_npc_percent_wasp_rank4','speed_max_modifier',0.6),
('def_npc_percent_wasp_rank4','turret_cycle_time_modifier',0.8),
('def_npc_percent_wasp_rank4','received_repaired_modifier',1.2),

('def_npc_percent_baph_rank4','resist_chemical',125),
('def_npc_percent_baph_rank4','resist_explosive',125),
('def_npc_percent_baph_rank4','resist_kinetic',125),
('def_npc_percent_baph_rank4','resist_thermal',125),
('def_npc_percent_baph_rank4','armor_max_modifier',1.5),
('def_npc_percent_baph_rank4','core_max_modifier',1.3),
('def_npc_percent_baph_rank4','core_recharge_time_modifier',0.7),
('def_npc_percent_baph_rank4','cpu_max_modifier',2),
('def_npc_percent_baph_rank4','damage_modifier',1.3),
('def_npc_percent_baph_rank4','falloff_modifier',1.3),
('def_npc_percent_baph_rank4','locking_range_modifier',1.1),
('def_npc_percent_baph_rank4','locking_time_modifier',0.9),
('def_npc_percent_baph_rank4','missile_cycle_time_modifier',0.8),
('def_npc_percent_baph_rank4','optimal_range_modifier',1.3),
('def_npc_percent_baph_rank4','powergrid_max_modifier',2),
('def_npc_percent_baph_rank4','speed_max_modifier',0.6),
('def_npc_percent_baph_rank4','turret_cycle_time_modifier',0.8),
('def_npc_percent_baph_rank4','received_repaired_modifier',1.2),

('def_npc_percent_arby_rank4','resist_chemical',125),
('def_npc_percent_arby_rank4','resist_explosive',125),
('def_npc_percent_arby_rank4','resist_kinetic',125),
('def_npc_percent_arby_rank4','resist_thermal',125),
('def_npc_percent_arby_rank4','armor_max_modifier',1.5),
('def_npc_percent_arby_rank4','core_max_modifier',1.3),
('def_npc_percent_arby_rank4','core_recharge_time_modifier',0.7),
('def_npc_percent_arby_rank4','cpu_max_modifier',2),
('def_npc_percent_arby_rank4','damage_modifier',1.3),
('def_npc_percent_arby_rank4','falloff_modifier',1.3),
('def_npc_percent_arby_rank4','locking_range_modifier',1.1),
('def_npc_percent_arby_rank4','locking_time_modifier',0.9),
('def_npc_percent_arby_rank4','missile_cycle_time_modifier',0.8),
('def_npc_percent_arby_rank4','optimal_range_modifier',1.3),
('def_npc_percent_arby_rank4','powergrid_max_modifier',2),
('def_npc_percent_arby_rank4','speed_max_modifier',0.6),
('def_npc_percent_arby_rank4','turret_cycle_time_modifier',0.8),
('def_npc_percent_arby_rank4','received_repaired_modifier',1.2),

('def_npc_percent_kain_rank3','resist_chemical',100),
('def_npc_percent_kain_rank3','resist_explosive',100),
('def_npc_percent_kain_rank3','resist_kinetic',100),
('def_npc_percent_kain_rank3','resist_thermal',100),
('def_npc_percent_kain_rank3','armor_max_modifier',1.3),
('def_npc_percent_kain_rank3','core_max_modifier',1.2),
('def_npc_percent_kain_rank3','core_recharge_time_modifier',0.8),
('def_npc_percent_kain_rank3','cpu_max_modifier',2),
('def_npc_percent_kain_rank3','damage_modifier',1.2),
('def_npc_percent_kain_rank3','falloff_modifier',1.2),
('def_npc_percent_kain_rank3','locking_range_modifier',1.1),
('def_npc_percent_kain_rank3','locking_time_modifier',0.9),
('def_npc_percent_kain_rank3','missile_cycle_time_modifier',0.9),
('def_npc_percent_kain_rank3','optimal_range_modifier',1.2),
('def_npc_percent_kain_rank3','powergrid_max_modifier',2),
('def_npc_percent_kain_rank3','speed_max_modifier',0.7),
('def_npc_percent_kain_rank3','turret_cycle_time_modifier',0.9),
('def_npc_percent_kain_rank3','received_repaired_modifier',1.1),

('def_npc_percent_kain_rank4','resist_chemical',125),
('def_npc_percent_kain_rank4','resist_explosive',125),
('def_npc_percent_kain_rank4','resist_kinetic',125),
('def_npc_percent_kain_rank4','resist_thermal',125),
('def_npc_percent_kain_rank4','armor_max_modifier',1.5),
('def_npc_percent_kain_rank4','core_max_modifier',1.3),
('def_npc_percent_kain_rank4','core_recharge_time_modifier',0.7),
('def_npc_percent_kain_rank4','cpu_max_modifier',2),
('def_npc_percent_kain_rank4','damage_modifier',1.3),
('def_npc_percent_kain_rank4','falloff_modifier',1.3),
('def_npc_percent_kain_rank4','locking_range_modifier',1.1),
('def_npc_percent_kain_rank4','locking_time_modifier',0.9),
('def_npc_percent_kain_rank4','missile_cycle_time_modifier',0.8),
('def_npc_percent_kain_rank4','optimal_range_modifier',1.3),
('def_npc_percent_kain_rank4','powergrid_max_modifier',2),
('def_npc_percent_kain_rank4','speed_max_modifier',0.7),
('def_npc_percent_kain_rank4','turret_cycle_time_modifier',0.8),
('def_npc_percent_kain_rank4','received_repaired_modifier',1.2),

('def_npc_percent_kain_rank5','resist_chemical',150),
('def_npc_percent_kain_rank5','resist_explosive',150),
('def_npc_percent_kain_rank5','resist_kinetic',150),
('def_npc_percent_kain_rank5','resist_thermal',150),
('def_npc_percent_kain_rank5','armor_max_modifier',1.7),
('def_npc_percent_kain_rank5','core_max_modifier',1.5),
('def_npc_percent_kain_rank5','core_recharge_time_modifier',0.7),
('def_npc_percent_kain_rank5','cpu_max_modifier',2),
('def_npc_percent_kain_rank5','damage_modifier',1.5),
('def_npc_percent_kain_rank5','falloff_modifier',1.3),
('def_npc_percent_kain_rank5','locking_range_modifier',1.5),
('def_npc_percent_kain_rank5','locking_time_modifier',0.7),
('def_npc_percent_kain_rank5','missile_cycle_time_modifier',0.7),
('def_npc_percent_kain_rank5','optimal_range_modifier',1.3),
('def_npc_percent_kain_rank5','powergrid_max_modifier',2),
('def_npc_percent_kain_rank5','speed_max_modifier',0.7),
('def_npc_percent_kain_rank5','turret_cycle_time_modifier',0.7),
('def_npc_percent_kain_rank5','received_repaired_modifier',1.3),

('def_npc_percent_arty_rank5','resist_chemical',150),
('def_npc_percent_arty_rank5','resist_explosive',150),
('def_npc_percent_arty_rank5','resist_kinetic',150),
('def_npc_percent_arty_rank5','resist_thermal',150),
('def_npc_percent_arty_rank5','armor_max_modifier',1.7),
('def_npc_percent_arty_rank5','core_max_modifier',1.5),
('def_npc_percent_arty_rank5','core_recharge_time_modifier',0.7),
('def_npc_percent_arty_rank5','cpu_max_modifier',2),
('def_npc_percent_arty_rank5','damage_modifier',1.5),
('def_npc_percent_arty_rank5','falloff_modifier',1.3),
('def_npc_percent_arty_rank5','locking_range_modifier',1.5),
('def_npc_percent_arty_rank5','locking_time_modifier',0.7),
('def_npc_percent_arty_rank5','missile_cycle_time_modifier',0.7),
('def_npc_percent_arty_rank5','optimal_range_modifier',1.3),
('def_npc_percent_arty_rank5','powergrid_max_modifier',2),
('def_npc_percent_arty_rank5','speed_max_modifier',0.7),
('def_npc_percent_arty_rank5','turret_cycle_time_modifier',0.7),
('def_npc_percent_arty_rank5','received_repaired_modifier',1.3),

('def_npc_percent_arty_rank4','resist_chemical',125),
('def_npc_percent_arty_rank4','resist_explosive',125),
('def_npc_percent_arty_rank4','resist_kinetic',125),
('def_npc_percent_arty_rank4','resist_thermal',125),
('def_npc_percent_arty_rank4','armor_max_modifier',1.5),
('def_npc_percent_arty_rank4','core_max_modifier',1.3),
('def_npc_percent_arty_rank4','core_recharge_time_modifier',0.7),
('def_npc_percent_arty_rank4','cpu_max_modifier',2),
('def_npc_percent_arty_rank4','damage_modifier',1.3),
('def_npc_percent_arty_rank4','falloff_modifier',1.3),
('def_npc_percent_arty_rank4','locking_range_modifier',1.1),
('def_npc_percent_arty_rank4','locking_time_modifier',0.9),
('def_npc_percent_arty_rank4','missile_cycle_time_modifier',0.8),
('def_npc_percent_arty_rank4','optimal_range_modifier',1.3),
('def_npc_percent_arty_rank4','powergrid_max_modifier',2),
('def_npc_percent_arty_rank4','speed_max_modifier',0.7),
('def_npc_percent_arty_rank4','turret_cycle_time_modifier',0.8),
('def_npc_percent_arty_rank4','received_repaired_modifier',1.2),

('def_npc_percent_arty_rank3','resist_chemical',100),
('def_npc_percent_arty_rank3','resist_explosive',100),
('def_npc_percent_arty_rank3','resist_kinetic',100),
('def_npc_percent_arty_rank3','resist_thermal',100),
('def_npc_percent_arty_rank3','armor_max_modifier',1.3),
('def_npc_percent_arty_rank3','core_max_modifier',1.2),
('def_npc_percent_arty_rank3','core_recharge_time_modifier',0.8),
('def_npc_percent_arty_rank3','cpu_max_modifier',2),
('def_npc_percent_arty_rank3','damage_modifier',1.2),
('def_npc_percent_arty_rank3','falloff_modifier',1.2),
('def_npc_percent_arty_rank3','locking_range_modifier',1.1),
('def_npc_percent_arty_rank3','locking_time_modifier',0.9),
('def_npc_percent_arty_rank3','missile_cycle_time_modifier',0.9),
('def_npc_percent_arty_rank3','optimal_range_modifier',1.2),
('def_npc_percent_arty_rank3','powergrid_max_modifier',2),
('def_npc_percent_arty_rank3','speed_max_modifier',0.7),
('def_npc_percent_arty_rank3','turret_cycle_time_modifier',0.9),
('def_npc_percent_arty_rank3','received_repaired_modifier',1.1),

('def_npc_percent_tyro_rank3','resist_chemical',100),
('def_npc_percent_tyro_rank3','resist_explosive',100),
('def_npc_percent_tyro_rank3','resist_kinetic',100),
('def_npc_percent_tyro_rank3','resist_thermal',100),
('def_npc_percent_tyro_rank3','armor_max_modifier',1.3),
('def_npc_percent_tyro_rank3','core_max_modifier',1.2),
('def_npc_percent_tyro_rank3','core_recharge_time_modifier',0.8),
('def_npc_percent_tyro_rank3','cpu_max_modifier',2),
('def_npc_percent_tyro_rank3','damage_modifier',1.2),
('def_npc_percent_tyro_rank3','falloff_modifier',1.2),
('def_npc_percent_tyro_rank3','locking_range_modifier',1.1),
('def_npc_percent_tyro_rank3','locking_time_modifier',0.9),
('def_npc_percent_tyro_rank3','missile_cycle_time_modifier',0.9),
('def_npc_percent_tyro_rank3','optimal_range_modifier',1.2),
('def_npc_percent_tyro_rank3','powergrid_max_modifier',2),
('def_npc_percent_tyro_rank3','speed_max_modifier',0.7),
('def_npc_percent_tyro_rank3','turret_cycle_time_modifier',0.9),
('def_npc_percent_tyro_rank3','received_repaired_modifier',1.1),

('def_npc_percent_tyro_rank4','resist_chemical',125),
('def_npc_percent_tyro_rank4','resist_explosive',125),
('def_npc_percent_tyro_rank4','resist_kinetic',125),
('def_npc_percent_tyro_rank4','resist_thermal',125),
('def_npc_percent_tyro_rank4','armor_max_modifier',1.5),
('def_npc_percent_tyro_rank4','core_max_modifier',1.3),
('def_npc_percent_tyro_rank4','core_recharge_time_modifier',0.7),
('def_npc_percent_tyro_rank4','cpu_max_modifier',2),
('def_npc_percent_tyro_rank4','damage_modifier',1.3),
('def_npc_percent_tyro_rank4','falloff_modifier',1.3),
('def_npc_percent_tyro_rank4','locking_range_modifier',1.1),
('def_npc_percent_tyro_rank4','locking_time_modifier',0.9),
('def_npc_percent_tyro_rank4','missile_cycle_time_modifier',0.8),
('def_npc_percent_tyro_rank4','optimal_range_modifier',1.3),
('def_npc_percent_tyro_rank4','powergrid_max_modifier',2),
('def_npc_percent_tyro_rank4','speed_max_modifier',0.7),
('def_npc_percent_tyro_rank4','turret_cycle_time_modifier',0.8),
('def_npc_percent_tyro_rank4','received_repaired_modifier',1.2),

('def_npc_percent_tyro_rank5','resist_chemical',150),
('def_npc_percent_tyro_rank5','resist_explosive',150),
('def_npc_percent_tyro_rank5','resist_kinetic',150),
('def_npc_percent_tyro_rank5','resist_thermal',150),
('def_npc_percent_tyro_rank5','armor_max_modifier',1.7),
('def_npc_percent_tyro_rank5','core_max_modifier',1.5),
('def_npc_percent_tyro_rank5','core_recharge_time_modifier',0.7),
('def_npc_percent_tyro_rank5','cpu_max_modifier',2),
('def_npc_percent_tyro_rank5','damage_modifier',1.5),
('def_npc_percent_tyro_rank5','falloff_modifier',1.3),
('def_npc_percent_tyro_rank5','locking_range_modifier',1.5),
('def_npc_percent_tyro_rank5','locking_time_modifier',0.7),
('def_npc_percent_tyro_rank5','missile_cycle_time_modifier',0.7),
('def_npc_percent_tyro_rank5','optimal_range_modifier',1.3),
('def_npc_percent_tyro_rank5','powergrid_max_modifier',2),
('def_npc_percent_tyro_rank5','speed_max_modifier',0.7),
('def_npc_percent_tyro_rank5','turret_cycle_time_modifier',0.7),
('def_npc_percent_tyro_rank5','received_repaired_modifier',1.3),

('def_npc_percent_gropho_rank5','resist_chemical',150),
('def_npc_percent_gropho_rank5','resist_explosive',150),
('def_npc_percent_gropho_rank5','resist_kinetic',150),
('def_npc_percent_gropho_rank5','resist_thermal',150),
('def_npc_percent_gropho_rank5','armor_max_modifier',1.7),
('def_npc_percent_gropho_rank5','core_max_modifier',1.5),
('def_npc_percent_gropho_rank5','core_recharge_time_modifier',0.7),
('def_npc_percent_gropho_rank5','cpu_max_modifier',2),
('def_npc_percent_gropho_rank5','damage_modifier',1.5),
('def_npc_percent_gropho_rank5','falloff_modifier',1.3),
('def_npc_percent_gropho_rank5','locking_range_modifier',1.5),
('def_npc_percent_gropho_rank5','locking_time_modifier',0.7),
('def_npc_percent_gropho_rank5','missile_cycle_time_modifier',0.7),
('def_npc_percent_gropho_rank5','optimal_range_modifier',1.3),
('def_npc_percent_gropho_rank5','powergrid_max_modifier',2),
('def_npc_percent_gropho_rank5','speed_max_modifier',0.9),
('def_npc_percent_gropho_rank5','turret_cycle_time_modifier',0.7),
('def_npc_percent_gropho_rank5','received_repaired_modifier',1.3),

('def_npc_percent_gropho_rank4','resist_chemical',125),
('def_npc_percent_gropho_rank4','resist_explosive',125),
('def_npc_percent_gropho_rank4','resist_kinetic',125),
('def_npc_percent_gropho_rank4','resist_thermal',125),
('def_npc_percent_gropho_rank4','armor_max_modifier',1.5),
('def_npc_percent_gropho_rank4','core_max_modifier',1.3),
('def_npc_percent_gropho_rank4','core_recharge_time_modifier',0.7),
('def_npc_percent_gropho_rank4','cpu_max_modifier',2),
('def_npc_percent_gropho_rank4','damage_modifier',1.3),
('def_npc_percent_gropho_rank4','falloff_modifier',1.3),
('def_npc_percent_gropho_rank4','locking_range_modifier',1.1),
('def_npc_percent_gropho_rank4','locking_time_modifier',0.9),
('def_npc_percent_gropho_rank4','missile_cycle_time_modifier',0.8),
('def_npc_percent_gropho_rank4','optimal_range_modifier',1.3),
('def_npc_percent_gropho_rank4','powergrid_max_modifier',2),
('def_npc_percent_gropho_rank4','speed_max_modifier',0.9),
('def_npc_percent_gropho_rank4','turret_cycle_time_modifier',0.8),
('def_npc_percent_gropho_rank4','received_repaired_modifier',1.2),

('def_npc_percent_seth_rank4','resist_chemical',125),
('def_npc_percent_seth_rank4','resist_explosive',125),
('def_npc_percent_seth_rank4','resist_kinetic',125),
('def_npc_percent_seth_rank4','resist_thermal',125),
('def_npc_percent_seth_rank4','armor_max_modifier',1.5),
('def_npc_percent_seth_rank4','core_max_modifier',1.3),
('def_npc_percent_seth_rank4','core_recharge_time_modifier',0.7),
('def_npc_percent_seth_rank4','cpu_max_modifier',2),
('def_npc_percent_seth_rank4','damage_modifier',1.3),
('def_npc_percent_seth_rank4','falloff_modifier',1.3),
('def_npc_percent_seth_rank4','locking_range_modifier',1.1),
('def_npc_percent_seth_rank4','locking_time_modifier',0.9),
('def_npc_percent_seth_rank4','missile_cycle_time_modifier',0.8),
('def_npc_percent_seth_rank4','optimal_range_modifier',1.3),
('def_npc_percent_seth_rank4','powergrid_max_modifier',2),
('def_npc_percent_seth_rank4','speed_max_modifier',0.9),
('def_npc_percent_seth_rank4','turret_cycle_time_modifier',0.8),
('def_npc_percent_seth_rank4','received_repaired_modifier',1.2),

('def_npc_percent_seth_rank5','resist_chemical',150),
('def_npc_percent_seth_rank5','resist_explosive',150),
('def_npc_percent_seth_rank5','resist_kinetic',150),
('def_npc_percent_seth_rank5','resist_thermal',150),
('def_npc_percent_seth_rank5','armor_max_modifier',1.7),
('def_npc_percent_seth_rank5','core_max_modifier',1.5),
('def_npc_percent_seth_rank5','core_recharge_time_modifier',0.7),
('def_npc_percent_seth_rank5','cpu_max_modifier',2),
('def_npc_percent_seth_rank5','damage_modifier',1.5),
('def_npc_percent_seth_rank5','falloff_modifier',1.3),
('def_npc_percent_seth_rank5','locking_range_modifier',1.5),
('def_npc_percent_seth_rank5','locking_time_modifier',0.7),
('def_npc_percent_seth_rank5','missile_cycle_time_modifier',0.7),
('def_npc_percent_seth_rank5','optimal_range_modifier',1.3),
('def_npc_percent_seth_rank5','powergrid_max_modifier',2),
('def_npc_percent_seth_rank5','speed_max_modifier',0.9),
('def_npc_percent_seth_rank5','turret_cycle_time_modifier',0.7),
('def_npc_percent_seth_rank5','received_repaired_modifier',1.3),

('def_npc_percent_mesmer_rank5','resist_chemical',150),
('def_npc_percent_mesmer_rank5','resist_explosive',150),
('def_npc_percent_mesmer_rank5','resist_kinetic',150),
('def_npc_percent_mesmer_rank5','resist_thermal',150),
('def_npc_percent_mesmer_rank5','armor_max_modifier',1.7),
('def_npc_percent_mesmer_rank5','core_max_modifier',1.5),
('def_npc_percent_mesmer_rank5','core_recharge_time_modifier',0.7),
('def_npc_percent_mesmer_rank5','cpu_max_modifier',2),
('def_npc_percent_mesmer_rank5','damage_modifier',1.5),
('def_npc_percent_mesmer_rank5','falloff_modifier',1.3),
('def_npc_percent_mesmer_rank5','locking_range_modifier',1.5),
('def_npc_percent_mesmer_rank5','locking_time_modifier',0.7),
('def_npc_percent_mesmer_rank5','missile_cycle_time_modifier',0.7),
('def_npc_percent_mesmer_rank5','optimal_range_modifier',1.3),
('def_npc_percent_mesmer_rank5','powergrid_max_modifier',2),
('def_npc_percent_mesmer_rank5','speed_max_modifier',0.9),
('def_npc_percent_mesmer_rank5','turret_cycle_time_modifier',0.7),
('def_npc_percent_mesmer_rank5','received_repaired_modifier',1.3),

('def_npc_percent_mesmer_rank4','resist_chemical',125),
('def_npc_percent_mesmer_rank4','resist_explosive',125),
('def_npc_percent_mesmer_rank4','resist_kinetic',125),
('def_npc_percent_mesmer_rank4','resist_thermal',125),
('def_npc_percent_mesmer_rank4','armor_max_modifier',1.5),
('def_npc_percent_mesmer_rank4','core_max_modifier',1.3),
('def_npc_percent_mesmer_rank4','core_recharge_time_modifier',0.7),
('def_npc_percent_mesmer_rank4','cpu_max_modifier',2),
('def_npc_percent_mesmer_rank4','damage_modifier',1.3),
('def_npc_percent_mesmer_rank4','falloff_modifier',1.3),
('def_npc_percent_mesmer_rank4','locking_range_modifier',1.1),
('def_npc_percent_mesmer_rank4','locking_time_modifier',0.9),
('def_npc_percent_mesmer_rank4','missile_cycle_time_modifier',0.8),
('def_npc_percent_mesmer_rank4','optimal_range_modifier',1.3),
('def_npc_percent_mesmer_rank4','powergrid_max_modifier',2),
('def_npc_percent_mesmer_rank4','speed_max_modifier',0.9),
('def_npc_percent_mesmer_rank4','turret_cycle_time_modifier',0.8),
('def_npc_percent_mesmer_rank4','received_repaired_modifier',1.2);


PRINT N'CREATE TEMP TABLE FOR NPC LOOT';
DROP TABLE IF EXISTS #LOOT;
CREATE TABLE #LOOT 
(
	npcDefName VARCHAR(100),
	lootDefName VARCHAR(100),
	minQuant INT,
	maxQuant INT,
	prob FLOAT,
	dontDmg BIT,
	package BIT,
);

INSERT INTO #LOOT (npcDefName, lootDefName, minQuant, maxQuant, prob, dontDmg, package) VALUES
('def_npc_fivepercent_argano','def_artifact_damaged_small_armor_plate',1,2,0.05,1,1),
('def_npc_fivepercent_argano','def_artifact_damaged_small_armor_repairer',1,2,0.05,1,1),
('def_npc_fivepercent_argano','def_artifact_damaged_armor_repairer_upgrade',1,2,0.05,1,1),
('def_npc_fivepercent_argano','def_artifact_damaged_small_energy_transfer',1,2,0.05,1,1),
('def_npc_fivepercent_argano','def_artifact_damaged_core_recharger',1,2,0.05,1,1),
('def_npc_fivepercent_argano','def_artifact_damaged_sensor_booster',1,2,0.05,1,1),
('def_npc_fivepercent_argano','def_artifact_damaged_sensor_dampener',1,2,0.05,1,1),
('def_npc_fivepercent_argano','def_artifact_damaged_small_driller',1,2,0.05,1,1),
('def_npc_fivepercent_argano','def_artifact_damaged_small_harvester',1,2,0.05,1,1),
('def_npc_fivepercent_argano','def_common_reactor_plasma',1000,1250,1,1,1),
('def_npc_fivepercent_argano','def_kernel_common',1000,1250,1,1,1),
('def_npc_fivepercent_Laird','def_artifact_damaged_small_armor_plate',1,2,0.05,1,1),
('def_npc_fivepercent_Laird','def_artifact_damaged_small_armor_repairer',1,2,0.05,1,1),
('def_npc_fivepercent_Laird','def_artifact_damaged_armor_repairer_upgrade',1,2,0.05,1,1),
('def_npc_fivepercent_Laird','def_artifact_damaged_small_energy_transfer',1,2,0.05,1,1),
('def_npc_fivepercent_Laird','def_artifact_damaged_core_recharger',1,2,0.05,1,1),
('def_npc_fivepercent_Laird','def_artifact_damaged_sensor_booster',1,2,0.05,1,1),
('def_npc_fivepercent_Laird','def_artifact_damaged_sensor_dampener',1,2,0.05,1,1),
('def_npc_fivepercent_Laird','def_artifact_damaged_small_driller',1,2,0.05,1,1),
('def_npc_fivepercent_Laird','def_artifact_damaged_small_harvester',1,2,0.05,1,1),
('def_npc_fivepercent_Laird','def_common_reactor_plasma',1000,1250,1,1,1),
('def_npc_fivepercent_Laird','def_kernel_common',1000,1250,1,1,1),
('def_npc_tenpercent_castel_rank1','def_artifact_damaged_small_armor_plate',1,2,0.05,1,1),
('def_npc_tenpercent_castel_rank1','def_artifact_damaged_small_armor_repairer',1,2,0.05,1,1),
('def_npc_tenpercent_castel_rank1','def_artifact_damaged_armor_repairer_upgrade',1,2,0.05,1,1),
('def_npc_tenpercent_castel_rank1','def_artifact_damaged_small_energy_transfer',1,2,0.05,1,1),
('def_npc_tenpercent_castel_rank1','def_artifact_damaged_core_recharger',1,2,0.05,1,1),
('def_npc_tenpercent_castel_rank1','def_artifact_damaged_sensor_booster',1,2,0.05,1,1),
('def_npc_tenpercent_castel_rank1','def_artifact_damaged_sensor_dampener',1,2,0.05,1,1),
('def_npc_tenpercent_castel_rank1','def_artifact_damaged_small_driller',1,2,0.05,1,1),
('def_npc_tenpercent_castel_rank1','def_artifact_damaged_small_harvester',1,2,0.05,1,1),
('def_npc_tenpercent_yagel_rank1','def_artifact_damaged_small_armor_plate',1,2,0.05,1,1),
('def_npc_tenpercent_yagel_rank1','def_artifact_damaged_small_armor_repairer',1,2,0.05,1,1),
('def_npc_tenpercent_yagel_rank1','def_artifact_damaged_armor_repairer_upgrade',1,2,0.05,1,1),
('def_npc_tenpercent_yagel_rank1','def_artifact_damaged_small_energy_transfer',1,2,0.05,1,1),
('def_npc_tenpercent_yagel_rank1','def_artifact_damaged_core_recharger',1,2,0.05,1,1),
('def_npc_tenpercent_yagel_rank1','def_artifact_damaged_sensor_booster',1,2,0.05,1,1),
('def_npc_tenpercent_yagel_rank1','def_artifact_damaged_sensor_dampener',1,2,0.05,1,1),
('def_npc_tenpercent_yagel_rank1','def_nuimqol_reactor_plasma',1000,1250,1,1,1),
('def_npc_tenpercent_yagel_rank1','def_kernel_nuimqol',1000,1250,1,1,1),
('def_npc_tenpercent_prom_rank1','def_artifact_damaged_small_armor_plate',1,2,0.05,1,1),
('def_npc_tenpercent_prom_rank1','def_artifact_damaged_small_armor_repairer',1,2,0.05,1,1),
('def_npc_tenpercent_prom_rank1','def_artifact_damaged_armor_repairer_upgrade',1,2,0.05,1,1),
('def_npc_tenpercent_prom_rank1','def_artifact_damaged_small_energy_transfer',1,2,0.05,1,1),
('def_npc_tenpercent_prom_rank1','def_artifact_damaged_core_recharger',1,2,0.05,1,1),
('def_npc_tenpercent_prom_rank1','def_artifact_damaged_sensor_booster',1,2,0.05,1,1),
('def_npc_tenpercent_prom_rank1','def_artifact_damaged_sensor_dampener',1,2,0.05,1,1),
('def_npc_tenpercent_prom_rank1','def_artifact_damaged_small_laser',1,2,0.05,1,1),
('def_npc_tenpercent_prom_rank1','def_artifact_damaged_damage_mod_laser',1,2,0.05,1,1),
('def_npc_tenpercent_prom_rank1','def_thelodica_reactor_plasma',1000,1250,1,1,1),
('def_npc_tenpercent_prom_rank1','def_kernel_thelodica',1000,1250,1,1,1),
('def_npc_tenpercent_prom_rank2','def_artifact_damaged_small_armor_plate',1,2,0.05,1,1),
('def_npc_tenpercent_prom_rank2','def_artifact_damaged_small_armor_repairer',1,2,0.05,1,1),
('def_npc_tenpercent_prom_rank2','def_artifact_damaged_armor_repairer_upgrade',1,2,0.05,1,1),
('def_npc_tenpercent_prom_rank2','def_artifact_damaged_small_energy_transfer',1,2,0.05,1,1),
('def_npc_tenpercent_prom_rank2','def_artifact_damaged_core_recharger',1,2,0.05,1,1),
('def_npc_tenpercent_prom_rank2','def_artifact_damaged_sensor_booster',1,2,0.05,1,1),
('def_npc_tenpercent_prom_rank2','def_artifact_damaged_sensor_dampener',1,2,0.05,1,1),
('def_npc_tenpercent_prom_rank2','def_artifact_damaged_small_laser',1,2,0.05,1,1),
('def_npc_tenpercent_prom_rank2','def_artifact_damaged_damage_mod_laser',1,2,0.05,1,1),
('def_npc_tenpercent_prom_rank2','def_thelodica_reactor_plasma',1250,1500,1,1,1),
('def_npc_tenpercent_prom_rank2','def_kernel_thelodica',1250,1500,1,1,1),
('def_npc_tenpercent_castel_rank2','def_artifact_damaged_small_armor_plate',1,2,0.05,1,1),
('def_npc_tenpercent_castel_rank2','def_artifact_damaged_small_armor_repairer',1,2,0.05,1,1),
('def_npc_tenpercent_castel_rank2','def_artifact_damaged_armor_repairer_upgrade',1,2,0.05,1,1),
('def_npc_tenpercent_castel_rank2','def_artifact_damaged_small_energy_transfer',1,2,0.05,1,1),
('def_npc_tenpercent_castel_rank2','def_artifact_damaged_core_recharger',1,2,0.05,1,1),
('def_npc_tenpercent_castel_rank2','def_artifact_damaged_sensor_booster',1,2,0.05,1,1),
('def_npc_tenpercent_castel_rank2','def_artifact_damaged_sensor_dampener',1,2,0.05,1,1),
('def_npc_tenpercent_castel_rank2','def_artifact_damaged_small_driller',1,2,0.05,1,1),
('def_npc_tenpercent_castel_rank2','def_artifact_damaged_small_harvester',1,2,0.05,1,1),
('def_npc_tenpercent_castel_rank2','def_artifact_damaged_rocket_launcher',1,2,0.05,1,1),
('def_npc_tenpercent_castel_rank2','def_artifact_damaged_damage_mod_missile',1,2,0.05,1,1),
('def_npc_tenpercent_castel_rank2','def_pelistal_reactor_plasma',1250,1500,1,1,1),
('def_npc_tenpercent_castel_rank2','def_kernel_pelistal',1250,1500,1,1,1),
('def_npc_tenpercent_yagel_rank2','def_artifact_damaged_small_armor_plate',1,2,0.05,1,1),
('def_npc_tenpercent_yagel_rank2','def_artifact_damaged_small_armor_repairer',1,2,0.05,1,1),
('def_npc_tenpercent_yagel_rank2','def_artifact_damaged_armor_repairer_upgrade',1,2,0.05,1,1),
('def_npc_tenpercent_yagel_rank2','def_artifact_damaged_small_energy_transfer',1,2,0.05,1,1),
('def_npc_tenpercent_yagel_rank2','def_artifact_damaged_core_recharger',1,2,0.05,1,1),
('def_npc_tenpercent_yagel_rank2','def_artifact_damaged_sensor_booster',1,2,0.05,1,1),
('def_npc_tenpercent_yagel_rank2','def_artifact_damaged_sensor_dampener',1,2,0.05,1,1),
('def_npc_tenpercent_yagel_rank2','def_artifact_damaged_small_railgun',1,2,0.05,1,1),
('def_npc_tenpercent_yagel_rank2','def_artifact_damaged_damage_mod_railgun',1,2,0.05,1,1),
('def_npc_tenpercent_yagel_rank2','def_nuimqol_reactor_plasma',1250,1500,1,1,1),
('def_npc_tenpercent_yagel_rank2','def_kernel_nuimqol',1250,1500,1,1,1),
('def_npc_percent_wasp_rank2','def_artifact_damaged_small_armor_plate',1,2,0.05,1,1),
('def_npc_percent_wasp_rank2','def_artifact_damaged_small_armor_repairer',1,2,0.05,1,1),
('def_npc_percent_wasp_rank2','def_artifact_damaged_armor_repairer_upgrade',1,2,0.05,1,1),
('def_npc_percent_wasp_rank2','def_artifact_damaged_small_energy_transfer',1,2,0.05,1,1),
('def_npc_percent_wasp_rank2','def_artifact_damaged_core_recharger',1,2,0.05,1,1),
('def_npc_percent_wasp_rank2','def_artifact_damaged_sensor_booster',1,2,0.05,1,1),
('def_npc_percent_wasp_rank2','def_artifact_damaged_sensor_dampener',1,2,0.05,1,1),
('def_npc_percent_wasp_rank2','def_artifact_damaged_small_driller',1,2,0.05,1,1),
('def_npc_percent_wasp_rank2','def_artifact_damaged_small_harvester',1,2,0.05,1,1),
('def_npc_percent_wasp_rank2','def_artifact_damaged_rocket_launcher',1,2,0.05,1,1),
('def_npc_percent_wasp_rank2','def_artifact_damaged_damage_mod_missile',1,2,0.05,1,1),
('def_npc_percent_wasp_rank2','def_pelistal_reactor_plasma',1500,1750,1,1,1),
('def_npc_percent_wasp_rank2','def_kernel_pelistal',1500,1750,1,1,1),
('def_npc_percent_arby_rank2','def_artifact_damaged_small_armor_plate',1,2,0.05,1,1),
('def_npc_percent_arby_rank2','def_artifact_damaged_small_armor_repairer',1,2,0.05,1,1),
('def_npc_percent_arby_rank2','def_artifact_damaged_armor_repairer_upgrade',1,2,0.05,1,1),
('def_npc_percent_arby_rank2','def_artifact_damaged_small_energy_transfer',1,2,0.05,1,1),
('def_npc_percent_arby_rank2','def_artifact_damaged_core_recharger',1,2,0.05,1,1),
('def_npc_percent_arby_rank2','def_artifact_damaged_sensor_booster',1,2,0.05,1,1),
('def_npc_percent_arby_rank2','def_artifact_damaged_sensor_dampener',1,2,0.05,1,1),
('def_npc_percent_arby_rank2','def_artifact_damaged_small_railgun',1,2,0.05,1,1),
('def_npc_percent_arby_rank2','def_artifact_damaged_damage_mod_railgun',1,2,0.05,1,1),
('def_npc_percent_arby_rank2','def_nuimqol_reactor_plasma',1500,1750,1,1,1),
('def_npc_percent_arby_rank2','def_kernel_nuimqol',1500,1750,1,1,1),
('def_npc_percent_arby_rank3','def_artifact_damaged_small_armor_plate',1,2,0.05,1,1),
('def_npc_percent_arby_rank3','def_artifact_damaged_small_armor_repairer',1,2,0.05,1,1),
('def_npc_percent_arby_rank3','def_artifact_damaged_armor_repairer_upgrade',1,2,0.05,1,1),
('def_npc_percent_arby_rank3','def_artifact_damaged_small_energy_transfer',1,2,0.05,1,1),
('def_npc_percent_arby_rank3','def_artifact_damaged_core_recharger',1,2,0.05,1,1),
('def_npc_percent_arby_rank3','def_artifact_damaged_sensor_booster',1,2,0.05,1,1),
('def_npc_percent_arby_rank3','def_artifact_damaged_sensor_dampener',1,2,0.05,1,1),
('def_npc_percent_arby_rank3','def_artifact_damaged_small_railgun',1,2,0.05,1,1),
('def_npc_percent_arby_rank3','def_artifact_damaged_damage_mod_railgun',1,2,0.05,1,1),
('def_npc_percent_arby_rank3','def_nuimqol_reactor_plasma',1750,2000,1,1,1),
('def_npc_percent_arby_rank3','def_kernel_nuimqol',1750,2000,1,1,1),
('def_npc_percent_baph_rank3','def_artifact_damaged_small_armor_plate',1,2,0.05,1,1),
('def_npc_percent_baph_rank3','def_artifact_damaged_small_armor_repairer',1,2,0.05,1,1),
('def_npc_percent_baph_rank3','def_artifact_damaged_armor_repairer_upgrade',1,2,0.05,1,1),
('def_npc_percent_baph_rank3','def_artifact_damaged_small_energy_transfer',1,2,0.05,1,1),
('def_npc_percent_baph_rank3','def_artifact_damaged_core_recharger',1,2,0.05,1,1),
('def_npc_percent_baph_rank3','def_artifact_damaged_sensor_booster',1,2,0.05,1,1),
('def_npc_percent_baph_rank3','def_artifact_damaged_sensor_dampener',1,2,0.05,1,1),
('def_npc_percent_baph_rank3','def_artifact_damaged_small_laser',1,2,0.05,1,1),
('def_npc_percent_baph_rank3','def_artifact_damaged_damage_mod_laser',1,2,0.05,1,1),
('def_npc_percent_baph_rank3','def_thelodica_reactor_plasma',1500,1750,1,1,1),
('def_npc_percent_baph_rank3','def_kernel_thelodica',1500,1750,1,1,1),
('def_npc_percent_wasp_rank3','def_artifact_damaged_small_armor_plate',1,2,0.05,1,1),
('def_npc_percent_wasp_rank3','def_artifact_damaged_small_armor_repairer',1,2,0.05,1,1),
('def_npc_percent_wasp_rank3','def_artifact_damaged_armor_repairer_upgrade',1,2,0.05,1,1),
('def_npc_percent_wasp_rank3','def_artifact_damaged_small_energy_transfer',1,2,0.05,1,1),
('def_npc_percent_wasp_rank3','def_artifact_damaged_core_recharger',1,2,0.05,1,1),
('def_npc_percent_wasp_rank3','def_artifact_damaged_sensor_booster',1,2,0.05,1,1),
('def_npc_percent_wasp_rank3','def_artifact_damaged_sensor_dampener',1,2,0.05,1,1),
('def_npc_percent_wasp_rank3','def_artifact_damaged_small_driller',1,2,0.05,1,1),
('def_npc_percent_wasp_rank3','def_artifact_damaged_small_harvester',1,2,0.05,1,1),
('def_npc_percent_wasp_rank3','def_artifact_damaged_rocket_launcher',1,2,0.05,1,1),
('def_npc_percent_wasp_rank3','def_artifact_damaged_damage_mod_missile',1,2,0.05,1,1),
('def_npc_percent_wasp_rank3','def_pelistal_reactor_plasma',2000,2000,1,1,1),
('def_npc_percent_wasp_rank3','def_kernel_pelistal',2000,2000,1,1,1),
('def_npc_percent_wasp_rank4','def_artifact_damaged_small_armor_plate',1,2,0.05,1,1),
('def_npc_percent_wasp_rank4','def_artifact_damaged_small_armor_repairer',1,2,0.05,1,1),
('def_npc_percent_wasp_rank4','def_artifact_damaged_armor_repairer_upgrade',1,2,0.05,1,1),
('def_npc_percent_wasp_rank4','def_artifact_damaged_small_energy_transfer',1,2,0.05,1,1),
('def_npc_percent_wasp_rank4','def_artifact_damaged_core_recharger',1,2,0.05,1,1),
('def_npc_percent_wasp_rank4','def_artifact_damaged_sensor_booster',1,2,0.05,1,1),
('def_npc_percent_wasp_rank4','def_artifact_damaged_sensor_dampener',1,2,0.05,1,1),
('def_npc_percent_wasp_rank4','def_artifact_damaged_small_driller',1,2,0.05,1,1),
('def_npc_percent_wasp_rank4','def_artifact_damaged_small_harvester',1,2,0.05,1,1),
('def_npc_percent_wasp_rank4','def_artifact_damaged_rocket_launcher',1,2,0.05,1,1),
('def_npc_percent_wasp_rank4','def_artifact_damaged_damage_mod_missile',1,2,0.05,1,1),
('def_npc_percent_wasp_rank4','def_pelistal_reactor_plasma',2000,2250,1,1,1),
('def_npc_percent_wasp_rank4','def_kernel_pelistal',2000,2250,1,1,1),
('def_npc_percent_baph_rank4','def_artifact_damaged_small_armor_plate',1,2,0.05,1,1),
('def_npc_percent_baph_rank4','def_artifact_damaged_small_armor_repairer',1,2,0.05,1,1),
('def_npc_percent_baph_rank4','def_artifact_damaged_armor_repairer_upgrade',1,2,0.05,1,1),
('def_npc_percent_baph_rank4','def_artifact_damaged_small_energy_transfer',1,2,0.05,1,1),
('def_npc_percent_baph_rank4','def_artifact_damaged_core_recharger',1,2,0.05,1,1),
('def_npc_percent_baph_rank4','def_artifact_damaged_sensor_booster',1,2,0.05,1,1),
('def_npc_percent_baph_rank4','def_artifact_damaged_sensor_dampener',1,2,0.05,1,1),
('def_npc_percent_baph_rank4','def_artifact_damaged_small_laser',1,2,0.05,1,1),
('def_npc_percent_baph_rank4','def_artifact_damaged_damage_mod_laser',1,2,0.05,1,1),
('def_npc_percent_baph_rank4','def_thelodica_reactor_plasma',1750,2000,1,1,1),
('def_npc_percent_baph_rank4','def_kernel_thelodica',1750,2000,1,1,1),
('def_npc_percent_kain_rank3','def_artifact_damaged_medium_armor_plate',1,2,0.05,1,1),
('def_npc_percent_kain_rank3','def_artifact_damaged_medium_armor_repairer',1,2,0.05,1,1),
('def_npc_percent_kain_rank3','def_artifact_damaged_armor_repairer_upgrade',1,2,0.05,1,1),
('def_npc_percent_kain_rank3','def_artifact_damaged_chm_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_kain_rank3','def_artifact_damaged_kin_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_kain_rank3','def_artifact_damaged_exp_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_kain_rank3','def_artifact_damaged_medium_shield_generator',1,2,0.05,1,1),
('def_npc_percent_kain_rank3','def_artifact_damaged_medium_energy_transfer',1,2,0.05,1,1),
('def_npc_percent_kain_rank3','def_artifact_damaged_medium_energy_neutralizer',1,2,0.05,1,1),
('def_npc_percent_kain_rank3','def_artifact_damaged_core_recharger',1,2,0.05,1,1),
('def_npc_percent_kain_rank3','def_artifact_damaged_powergrid_upgrades',1,2,0.05,1,1),
('def_npc_percent_kain_rank3','def_artifact_damaged_medium_core_booster',1,1,0.05,1,1),
('def_npc_percent_kain_rank3','def_artifact_damaged_maneuvering_upgrade',1,2,0.05,1,1),
('def_npc_percent_kain_rank3','def_artifact_damaged_sensor_booster',1,2,0.05,1,1),
('def_npc_percent_kain_rank3','def_artifact_damaged_cpu_upgrade',1,2,0.05,1,1),
('def_npc_percent_kain_rank3','def_artifact_damaged_tracking_upgrade',1,2,0.05,1,1),
('def_npc_percent_kain_rank3','def_artifact_damaged_sensor_dampener',1,2,0.05,1,1),
('def_npc_percent_kain_rank3','def_artifact_damaged_blob_emission_modulator',1,2,0.05,1,1),
('def_npc_percent_kain_rank3','def_artifact_damaged_damage_mod_railgun',1,2,0.05,1,1),
('def_npc_percent_kain_rank3','def_nuimqol_reactor_plasma',2500,2750,1,1,1),
('def_npc_percent_kain_rank3','def_kernel_nuimqol',2500,2750,1,1,1),
('def_npc_percent_kain_rank4','def_artifact_damaged_medium_armor_plate',1,2,0.05,1,1),
('def_npc_percent_kain_rank4','def_artifact_damaged_medium_armor_repairer',1,2,0.05,1,1),
('def_npc_percent_kain_rank4','def_artifact_damaged_armor_repairer_upgrade',1,2,0.05,1,1),
('def_npc_percent_kain_rank4','def_artifact_damaged_chm_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_kain_rank4','def_artifact_damaged_kin_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_kain_rank4','def_artifact_damaged_exp_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_kain_rank4','def_artifact_damaged_medium_shield_generator',1,2,0.05,1,1),
('def_npc_percent_kain_rank4','def_artifact_damaged_medium_energy_transfer',1,2,0.05,1,1),
('def_npc_percent_kain_rank4','def_artifact_damaged_medium_energy_neutralizer',1,2,0.05,1,1),
('def_npc_percent_kain_rank4','def_artifact_damaged_core_recharger',1,2,0.05,1,1),
('def_npc_percent_kain_rank4','def_artifact_damaged_powergrid_upgrades',1,2,0.05,1,1),
('def_npc_percent_kain_rank4','def_artifact_damaged_medium_core_booster',1,1,0.05,1,1),
('def_npc_percent_kain_rank4','def_artifact_damaged_maneuvering_upgrade',1,2,0.05,1,1),
('def_npc_percent_kain_rank4','def_artifact_damaged_sensor_booster',1,2,0.05,1,1),
('def_npc_percent_kain_rank4','def_artifact_damaged_cpu_upgrade',1,2,0.05,1,1),
('def_npc_percent_kain_rank4','def_artifact_damaged_tracking_upgrade',1,2,0.05,1,1),
('def_npc_percent_kain_rank4','def_artifact_damaged_sensor_dampener',1,2,0.05,1,1),
('def_npc_percent_kain_rank4','def_artifact_damaged_blob_emission_modulator',1,2,0.05,1,1),
('def_npc_percent_kain_rank4','def_artifact_damaged_damage_mod_railgun',1,2,0.05,1,1),
('def_npc_percent_kain_rank4','def_nuimqol_reactor_plasma',2750,3000,1,1,1),
('def_npc_percent_kain_rank4','def_kernel_nuimqol',2750,3000,1,1,1),
('def_npc_percent_kain_rank5','def_artifact_damaged_medium_armor_plate',1,2,0.05,1,1),
('def_npc_percent_kain_rank5','def_artifact_damaged_medium_armor_repairer',1,2,0.05,1,1),
('def_npc_percent_kain_rank5','def_artifact_damaged_armor_repairer_upgrade',1,2,0.05,1,1),
('def_npc_percent_kain_rank5','def_artifact_damaged_chm_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_kain_rank5','def_artifact_damaged_kin_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_kain_rank5','def_artifact_damaged_exp_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_kain_rank5','def_artifact_damaged_medium_shield_generator',1,2,0.05,1,1),
('def_npc_percent_kain_rank5','def_artifact_damaged_medium_energy_transfer',1,2,0.05,1,1),
('def_npc_percent_kain_rank5','def_artifact_damaged_medium_energy_neutralizer',1,2,0.05,1,1),
('def_npc_percent_kain_rank5','def_artifact_damaged_core_recharger',1,2,0.05,1,1),
('def_npc_percent_kain_rank5','def_artifact_damaged_powergrid_upgrades',1,2,0.05,1,1),
('def_npc_percent_kain_rank5','def_artifact_damaged_medium_core_booster',1,1,0.05,1,1),
('def_npc_percent_kain_rank5','def_artifact_damaged_maneuvering_upgrade',1,2,0.05,1,1),
('def_npc_percent_kain_rank5','def_artifact_damaged_sensor_booster',1,2,0.05,1,1),
('def_npc_percent_kain_rank5','def_artifact_damaged_cpu_upgrade',1,2,0.05,1,1),
('def_npc_percent_kain_rank5','def_artifact_damaged_tracking_upgrade',1,2,0.05,1,1),
('def_npc_percent_kain_rank5','def_artifact_damaged_sensor_dampener',1,2,0.05,1,1),
('def_npc_percent_kain_rank5','def_artifact_damaged_blob_emission_modulator',1,2,0.05,1,1),
('def_npc_percent_kain_rank5','def_artifact_damaged_damage_mod_railgun',1,2,0.05,1,1),
('def_npc_percent_kain_rank5','def_nuimqol_reactor_plasma',3000,3250,1,1,1),
('def_npc_percent_kain_rank5','def_kernel_nuimqol',3000,3250,1,1,1),
('def_npc_percent_arty_rank5','def_artifact_damaged_medium_armor_plate',1,2,0.05,1,1),
('def_npc_percent_arty_rank5','def_artifact_damaged_medium_armor_repairer',1,2,0.05,1,1),
('def_npc_percent_arty_rank5','def_artifact_damaged_armor_repairer_upgrade',1,2,0.05,1,1),
('def_npc_percent_arty_rank5','def_artifact_damaged_chm_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_arty_rank5','def_artifact_damaged_kin_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_arty_rank5','def_artifact_damaged_exp_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_arty_rank5','def_artifact_damaged_medium_shield_generator',1,2,0.05,1,1),
('def_npc_percent_arty_rank5','def_artifact_damaged_medium_energy_transfer',1,2,0.05,1,1),
('def_npc_percent_arty_rank5','def_artifact_damaged_medium_energy_neutralizer',1,2,0.05,1,1),
('def_npc_percent_arty_rank5','def_artifact_damaged_core_recharger',1,2,0.05,1,1),
('def_npc_percent_arty_rank5','def_artifact_damaged_powergrid_upgrades',1,2,0.05,1,1),
('def_npc_percent_arty_rank5','def_artifact_damaged_medium_core_booster',1,1,0.05,1,1),
('def_npc_percent_arty_rank5','def_artifact_damaged_maneuvering_upgrade',1,2,0.05,1,1),
('def_npc_percent_arty_rank5','def_artifact_damaged_sensor_booster',1,2,0.05,1,1),
('def_npc_percent_arty_rank5','def_artifact_damaged_cpu_upgrade',1,2,0.05,1,1),
('def_npc_percent_arty_rank5','def_artifact_damaged_tracking_upgrade',1,2,0.05,1,1),
('def_npc_percent_arty_rank5','def_artifact_damaged_sensor_dampener',1,2,0.05,1,1),
('def_npc_percent_arty_rank5','def_artifact_damaged_blob_emission_modulator',1,2,0.05,1,1),
('def_npc_percent_arty_rank5','def_artifact_damaged_medium_laser',1,2,0.05,1,1),
('def_npc_percent_arty_rank5','def_artifact_damaged_damage_mod_laser',1,2,0.05,1,1),
('def_npc_percent_arty_rank5','def_thelodica_reactor_plasma',3000,3250,1,1,1),
('def_npc_percent_arty_rank5','def_kernel_thelodica',3000,3250,1,1,1),
('def_npc_percent_arty_rank4','def_artifact_damaged_medium_armor_plate',1,2,0.05,1,1),
('def_npc_percent_arty_rank4','def_artifact_damaged_medium_armor_repairer',1,2,0.05,1,1),
('def_npc_percent_arty_rank4','def_artifact_damaged_armor_repairer_upgrade',1,2,0.05,1,1),
('def_npc_percent_arty_rank4','def_artifact_damaged_chm_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_arty_rank4','def_artifact_damaged_kin_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_arty_rank4','def_artifact_damaged_exp_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_arty_rank4','def_artifact_damaged_medium_shield_generator',1,2,0.05,1,1),
('def_npc_percent_arty_rank4','def_artifact_damaged_medium_energy_transfer',1,2,0.05,1,1),
('def_npc_percent_arty_rank4','def_artifact_damaged_medium_energy_neutralizer',1,2,0.05,1,1),
('def_npc_percent_arty_rank4','def_artifact_damaged_core_recharger',1,2,0.05,1,1),
('def_npc_percent_arty_rank4','def_artifact_damaged_powergrid_upgrades',1,2,0.05,1,1),
('def_npc_percent_arty_rank4','def_artifact_damaged_medium_core_booster',1,1,0.05,1,1),
('def_npc_percent_arty_rank4','def_artifact_damaged_maneuvering_upgrade',1,2,0.05,1,1),
('def_npc_percent_arty_rank4','def_artifact_damaged_sensor_booster',1,2,0.05,1,1),
('def_npc_percent_arty_rank4','def_artifact_damaged_cpu_upgrade',1,2,0.05,1,1),
('def_npc_percent_arty_rank4','def_artifact_damaged_tracking_upgrade',1,2,0.05,1,1),
('def_npc_percent_arty_rank4','def_artifact_damaged_sensor_dampener',1,2,0.05,1,1),
('def_npc_percent_arty_rank4','def_artifact_damaged_blob_emission_modulator',1,2,0.05,1,1),
('def_npc_percent_arty_rank4','def_artifact_damaged_medium_laser',1,2,0.05,1,1),
('def_npc_percent_arty_rank4','def_artifact_damaged_damage_mod_laser',1,2,0.05,1,1),
('def_npc_percent_arty_rank4','def_thelodica_reactor_plasma',2750,3000,1,1,1),
('def_npc_percent_arty_rank4','def_kernel_thelodica',2750,3000,1,1,1),
('def_npc_percent_arty_rank3','def_artifact_damaged_medium_armor_plate',1,2,0.05,1,1),
('def_npc_percent_arty_rank3','def_artifact_damaged_medium_armor_repairer',1,2,0.05,1,1),
('def_npc_percent_arty_rank3','def_artifact_damaged_armor_repairer_upgrade',1,2,0.05,1,1),
('def_npc_percent_arty_rank3','def_artifact_damaged_chm_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_arty_rank3','def_artifact_damaged_kin_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_arty_rank3','def_artifact_damaged_exp_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_arty_rank3','def_artifact_damaged_medium_shield_generator',1,2,0.05,1,1),
('def_npc_percent_arty_rank3','def_artifact_damaged_medium_energy_transfer',1,2,0.05,1,1),
('def_npc_percent_arty_rank3','def_artifact_damaged_medium_energy_neutralizer',1,2,0.05,1,1),
('def_npc_percent_arty_rank3','def_artifact_damaged_core_recharger',1,2,0.05,1,1),
('def_npc_percent_arty_rank3','def_artifact_damaged_powergrid_upgrades',1,2,0.05,1,1),
('def_npc_percent_arty_rank3','def_artifact_damaged_medium_core_booster',1,1,0.05,1,1),
('def_npc_percent_arty_rank3','def_artifact_damaged_maneuvering_upgrade',1,2,0.05,1,1),
('def_npc_percent_arty_rank3','def_artifact_damaged_sensor_booster',1,2,0.05,1,1),
('def_npc_percent_arty_rank3','def_artifact_damaged_cpu_upgrade',1,2,0.05,1,1),
('def_npc_percent_arty_rank3','def_artifact_damaged_tracking_upgrade',1,2,0.05,1,1),
('def_npc_percent_arty_rank3','def_artifact_damaged_sensor_dampener',1,2,0.05,1,1),
('def_npc_percent_arty_rank3','def_artifact_damaged_blob_emission_modulator',1,2,0.05,1,1),
('def_npc_percent_arty_rank3','def_artifact_damaged_medium_laser',1,2,0.05,1,1),
('def_npc_percent_arty_rank3','def_artifact_damaged_damage_mod_laser',1,2,0.05,1,1),
('def_npc_percent_arty_rank3','def_thelodica_reactor_plasma',2500,2750,1,1,1),
('def_npc_percent_arty_rank3','def_kernel_thelodica',2500,2750,1,1,1),
('def_npc_percent_tyro_rank3','def_artifact_damaged_medium_armor_plate',1,2,0.05,1,1),
('def_npc_percent_tyro_rank3','def_artifact_damaged_medium_armor_repairer',1,2,0.05,1,1),
('def_npc_percent_tyro_rank3','def_artifact_damaged_armor_repairer_upgrade',1,2,0.05,1,1),
('def_npc_percent_tyro_rank3','def_artifact_damaged_chm_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_tyro_rank3','def_artifact_damaged_exp_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_tyro_rank3','def_artifact_damaged_thrm_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_tyro_rank3','def_artifact_damaged_medium_shield_generator',1,2,0.05,1,1),
('def_npc_percent_tyro_rank3','def_artifact_damaged_medium_energy_vampire',1,2,0.05,1,1),
('def_npc_percent_tyro_rank3','def_artifact_damaged_medium_energy_neutralizer',1,2,0.05,1,1),
('def_npc_percent_tyro_rank3','def_artifact_damaged_core_recharger',1,2,0.05,1,1),
('def_npc_percent_tyro_rank3','def_artifact_damaged_powergrid_upgrades',1,2,0.05,1,1),
('def_npc_percent_tyro_rank3','def_artifact_damaged_medium_core_battery',1,2,0.05,1,1),
('def_npc_percent_tyro_rank3','def_artifact_damaged_maneuvering_upgrade',1,2,0.05,1,1),
('def_npc_percent_tyro_rank3','def_artifact_damaged_sensor_booster',1,2,0.05,1,1),
('def_npc_percent_tyro_rank3','def_artifact_damaged_cpu_upgrade',1,2,0.05,1,1),
('def_npc_percent_tyro_rank3','def_artifact_damaged_tracking_upgrade',1,2,0.05,1,1),
('def_npc_percent_tyro_rank3','def_artifact_damaged_sensor_dampener',1,2,0.05,1,1),
('def_npc_percent_tyro_rank3','def_artifact_damaged_blob_emission_modulator',1,2,0.05,1,1),
('def_npc_percent_tyro_rank3','def_artifact_damaged_damage_mod_missile',1,2,0.05,1,1),
('def_npc_percent_tyro_rank3','def_pelistal_reactor_plasma',2500,2750,1,1,1),
('def_npc_percent_tyro_rank3','def_kernel_pelistal',2500,2750,1,1,1),
('def_npc_percent_tyro_rank4','def_artifact_damaged_medium_armor_plate',1,2,0.05,1,1),
('def_npc_percent_tyro_rank4','def_artifact_damaged_medium_armor_repairer',1,2,0.05,1,1),
('def_npc_percent_tyro_rank4','def_artifact_damaged_armor_repairer_upgrade',1,2,0.05,1,1),
('def_npc_percent_tyro_rank4','def_artifact_damaged_chm_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_tyro_rank4','def_artifact_damaged_exp_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_tyro_rank4','def_artifact_damaged_thrm_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_tyro_rank4','def_artifact_damaged_medium_shield_generator',1,2,0.05,1,1),
('def_npc_percent_tyro_rank4','def_artifact_damaged_medium_energy_vampire',1,2,0.05,1,1),
('def_npc_percent_tyro_rank4','def_artifact_damaged_medium_energy_neutralizer',1,2,0.05,1,1),
('def_npc_percent_tyro_rank4','def_artifact_damaged_core_recharger',1,2,0.05,1,1),
('def_npc_percent_tyro_rank4','def_artifact_damaged_powergrid_upgrades',1,2,0.05,1,1),
('def_npc_percent_tyro_rank4','def_artifact_damaged_medium_core_battery',1,2,0.05,1,1),
('def_npc_percent_tyro_rank4','def_artifact_damaged_maneuvering_upgrade',1,2,0.05,1,1),
('def_npc_percent_tyro_rank4','def_artifact_damaged_sensor_booster',1,2,0.05,1,1),
('def_npc_percent_tyro_rank4','def_artifact_damaged_cpu_upgrade',1,2,0.05,1,1),
('def_npc_percent_tyro_rank4','def_artifact_damaged_tracking_upgrade',1,2,0.05,1,1),
('def_npc_percent_tyro_rank4','def_artifact_damaged_sensor_dampener',1,2,0.05,1,1),
('def_npc_percent_tyro_rank4','def_artifact_damaged_blob_emission_modulator',1,2,0.05,1,1),
('def_npc_percent_tyro_rank4','def_artifact_damaged_damage_mod_missile',1,2,0.05,1,1),
('def_npc_percent_tyro_rank4','def_pelistal_reactor_plasma',2750,3000,1,1,1),
('def_npc_percent_tyro_rank4','def_kernel_pelistal',2750,3000,1,1,1),
('def_npc_percent_tyro_rank5','def_artifact_damaged_medium_armor_plate',1,2,0.05,1,1),
('def_npc_percent_tyro_rank5','def_artifact_damaged_medium_armor_repairer',1,2,0.05,1,1),
('def_npc_percent_tyro_rank5','def_artifact_damaged_armor_repairer_upgrade',1,2,0.05,1,1),
('def_npc_percent_tyro_rank5','def_artifact_damaged_chm_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_tyro_rank5','def_artifact_damaged_exp_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_tyro_rank5','def_artifact_damaged_thrm_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_tyro_rank5','def_artifact_damaged_medium_shield_generator',1,2,0.05,1,1),
('def_npc_percent_tyro_rank5','def_artifact_damaged_medium_energy_vampire',1,2,0.05,1,1),
('def_npc_percent_tyro_rank5','def_artifact_damaged_medium_energy_neutralizer',1,2,0.05,1,1),
('def_npc_percent_tyro_rank5','def_artifact_damaged_core_recharger',1,2,0.05,1,1),
('def_npc_percent_tyro_rank5','def_artifact_damaged_powergrid_upgrades',1,2,0.05,1,1),
('def_npc_percent_tyro_rank5','def_artifact_damaged_medium_core_battery',1,2,0.05,1,1),
('def_npc_percent_tyro_rank5','def_artifact_damaged_maneuvering_upgrade',1,2,0.05,1,1),
('def_npc_percent_tyro_rank5','def_artifact_damaged_sensor_booster',1,2,0.05,1,1),
('def_npc_percent_tyro_rank5','def_artifact_damaged_cpu_upgrade',1,2,0.05,1,1),
('def_npc_percent_tyro_rank5','def_artifact_damaged_tracking_upgrade',1,2,0.05,1,1),
('def_npc_percent_tyro_rank5','def_artifact_damaged_sensor_dampener',1,2,0.05,1,1),
('def_npc_percent_tyro_rank5','def_artifact_damaged_blob_emission_modulator',1,2,0.05,1,1),
('def_npc_percent_tyro_rank5','def_artifact_damaged_damage_mod_missile',1,2,0.05,1,1),
('def_npc_percent_tyro_rank5','def_pelistal_reactor_plasma',3000,3250,1,1,1),
('def_npc_percent_tyro_rank5','def_kernel_pelistal',3000,3250,1,1,1),
('def_npc_percent_gropho_rank5','def_artifact_damaged_medium_armor_plate',1,2,0.05,1,1),
('def_npc_percent_gropho_rank5','def_artifact_damaged_medium_armor_repairer',1,2,0.05,1,1),
('def_npc_percent_gropho_rank5','def_artifact_damaged_armor_repairer_upgrade',1,2,0.05,1,1),
('def_npc_percent_gropho_rank5','def_artifact_damaged_chm_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_gropho_rank5','def_artifact_damaged_exp_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_gropho_rank5','def_artifact_damaged_thrm_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_gropho_rank5','def_artifact_damaged_medium_shield_generator',1,2,0.05,1,1),
('def_npc_percent_gropho_rank5','def_artifact_damaged_medium_energy_vampire',1,2,0.05,1,1),
('def_npc_percent_gropho_rank5','def_artifact_damaged_medium_energy_neutralizer',1,2,0.05,1,1),
('def_npc_percent_gropho_rank5','def_artifact_damaged_core_recharger',1,2,0.05,1,1),
('def_npc_percent_gropho_rank5','def_artifact_damaged_powergrid_upgrades',1,2,0.05,1,1),
('def_npc_percent_gropho_rank5','def_artifact_damaged_medium_core_battery',1,2,0.05,1,1),
('def_npc_percent_gropho_rank5','def_artifact_damaged_maneuvering_upgrade',1,2,0.05,1,1),
('def_npc_percent_gropho_rank5','def_artifact_damaged_sensor_booster',1,2,0.05,1,1),
('def_npc_percent_gropho_rank5','def_artifact_damaged_cpu_upgrade',1,2,0.05,1,1),
('def_npc_percent_gropho_rank5','def_artifact_damaged_tracking_upgrade',1,2,0.05,1,1),
('def_npc_percent_gropho_rank5','def_artifact_damaged_sensor_dampener',1,2,0.05,1,1),
('def_npc_percent_gropho_rank5','def_artifact_damaged_blob_emission_modulator',1,2,0.05,1,1),
('def_npc_percent_gropho_rank5','def_artifact_damaged_damage_mod_missile',1,2,0.05,1,1),
('def_npc_percent_gropho_rank5','def_pelistal_reactor_plasma',4000,5000,1,1,1),
('def_npc_percent_gropho_rank5','def_kernel_pelistal',4000,5000,1,1,1),
('def_npc_percent_gropho_rank4','def_artifact_damaged_medium_armor_plate',1,2,0.05,1,1),
('def_npc_percent_gropho_rank4','def_artifact_damaged_medium_armor_repairer',1,2,0.05,1,1),
('def_npc_percent_gropho_rank4','def_artifact_damaged_armor_repairer_upgrade',1,2,0.05,1,1),
('def_npc_percent_gropho_rank4','def_artifact_damaged_chm_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_gropho_rank4','def_artifact_damaged_exp_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_gropho_rank4','def_artifact_damaged_thrm_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_gropho_rank4','def_artifact_damaged_medium_shield_generator',1,2,0.05,1,1),
('def_npc_percent_gropho_rank4','def_artifact_damaged_medium_energy_vampire',1,2,0.05,1,1),
('def_npc_percent_gropho_rank4','def_artifact_damaged_medium_energy_neutralizer',1,2,0.05,1,1),
('def_npc_percent_gropho_rank4','def_artifact_damaged_core_recharger',1,2,0.05,1,1),
('def_npc_percent_gropho_rank4','def_artifact_damaged_powergrid_upgrades',1,2,0.05,1,1),
('def_npc_percent_gropho_rank4','def_artifact_damaged_medium_core_battery',1,2,0.05,1,1),
('def_npc_percent_gropho_rank4','def_artifact_damaged_maneuvering_upgrade',1,2,0.05,1,1),
('def_npc_percent_gropho_rank4','def_artifact_damaged_sensor_booster',1,2,0.05,1,1),
('def_npc_percent_gropho_rank4','def_artifact_damaged_cpu_upgrade',1,2,0.05,1,1),
('def_npc_percent_gropho_rank4','def_artifact_damaged_tracking_upgrade',1,2,0.05,1,1),
('def_npc_percent_gropho_rank4','def_artifact_damaged_sensor_dampener',1,2,0.05,1,1),
('def_npc_percent_gropho_rank4','def_artifact_damaged_blob_emission_modulator',1,2,0.05,1,1),
('def_npc_percent_gropho_rank4','def_artifact_damaged_damage_mod_missile',1,2,0.05,1,1),
('def_npc_percent_gropho_rank4','def_pelistal_reactor_plasma',3500,4000,1,1,1),
('def_npc_percent_gropho_rank4','def_kernel_pelistal',3500,4000,1,1,1),
('def_npc_percent_seth_rank4','def_artifact_damaged_medium_armor_plate',1,2,0.05,1,1),
('def_npc_percent_seth_rank4','def_artifact_damaged_medium_armor_repairer',1,2,0.05,1,1),
('def_npc_percent_seth_rank4','def_artifact_damaged_armor_repairer_upgrade',1,2,0.05,1,1),
('def_npc_percent_seth_rank4','def_artifact_damaged_chm_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_seth_rank4','def_artifact_damaged_kin_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_seth_rank4','def_artifact_damaged_exp_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_seth_rank4','def_artifact_damaged_medium_shield_generator',1,2,0.05,1,1),
('def_npc_percent_seth_rank4','def_artifact_damaged_medium_energy_transfer',1,2,0.05,1,1),
('def_npc_percent_seth_rank4','def_artifact_damaged_medium_energy_neutralizer',1,2,0.05,1,1),
('def_npc_percent_seth_rank4','def_artifact_damaged_core_recharger',1,2,0.05,1,1),
('def_npc_percent_seth_rank4','def_artifact_damaged_powergrid_upgrades',1,2,0.05,1,1),
('def_npc_percent_seth_rank4','def_artifact_damaged_medium_core_booster',1,1,0.05,1,1),
('def_npc_percent_seth_rank4','def_artifact_damaged_maneuvering_upgrade',1,2,0.05,1,1),
('def_npc_percent_seth_rank4','def_artifact_damaged_sensor_booster',1,2,0.05,1,1),
('def_npc_percent_seth_rank4','def_artifact_damaged_cpu_upgrade',1,2,0.05,1,1),
('def_npc_percent_seth_rank4','def_artifact_damaged_tracking_upgrade',1,2,0.05,1,1),
('def_npc_percent_seth_rank4','def_artifact_damaged_sensor_dampener',1,2,0.05,1,1),
('def_npc_percent_seth_rank4','def_artifact_damaged_blob_emission_modulator',1,2,0.05,1,1),
('def_npc_percent_seth_rank4','def_artifact_damaged_medium_laser',1,2,0.05,1,1),
('def_npc_percent_seth_rank4','def_artifact_damaged_damage_mod_laser',1,2,0.05,1,1),
('def_npc_percent_seth_rank4','def_thelodica_reactor_plasma',3750,4000,1,1,1),
('def_npc_percent_seth_rank4','def_kernel_thelodica',3750,4000,1,1,1),
('def_npc_percent_seth_rank5','def_artifact_damaged_medium_armor_plate',1,2,0.05,1,1),
('def_npc_percent_seth_rank5','def_artifact_damaged_medium_armor_repairer',1,2,0.05,1,1),
('def_npc_percent_seth_rank5','def_artifact_damaged_armor_repairer_upgrade',1,2,0.05,1,1),
('def_npc_percent_seth_rank5','def_artifact_damaged_chm_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_seth_rank5','def_artifact_damaged_kin_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_seth_rank5','def_artifact_damaged_exp_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_seth_rank5','def_artifact_damaged_medium_shield_generator',1,2,0.05,1,1),
('def_npc_percent_seth_rank5','def_artifact_damaged_medium_energy_transfer',1,2,0.05,1,1),
('def_npc_percent_seth_rank5','def_artifact_damaged_medium_energy_neutralizer',1,2,0.05,1,1),
('def_npc_percent_seth_rank5','def_artifact_damaged_core_recharger',1,2,0.05,1,1),
('def_npc_percent_seth_rank5','def_artifact_damaged_powergrid_upgrades',1,2,0.05,1,1),
('def_npc_percent_seth_rank5','def_artifact_damaged_medium_core_booster',1,1,0.05,1,1),
('def_npc_percent_seth_rank5','def_artifact_damaged_maneuvering_upgrade',1,2,0.05,1,1),
('def_npc_percent_seth_rank5','def_artifact_damaged_sensor_booster',1,2,0.05,1,1),
('def_npc_percent_seth_rank5','def_artifact_damaged_cpu_upgrade',1,2,0.05,1,1),
('def_npc_percent_seth_rank5','def_artifact_damaged_tracking_upgrade',1,2,0.05,1,1),
('def_npc_percent_seth_rank5','def_artifact_damaged_sensor_dampener',1,2,0.05,1,1),
('def_npc_percent_seth_rank5','def_artifact_damaged_blob_emission_modulator',1,2,0.05,1,1),
('def_npc_percent_seth_rank5','def_artifact_damaged_medium_laser',1,2,0.05,1,1),
('def_npc_percent_seth_rank5','def_artifact_damaged_damage_mod_laser',1,2,0.05,1,1),
('def_npc_percent_seth_rank5','def_thelodica_reactor_plasma',4750,5000,1,1,1),
('def_npc_percent_seth_rank5','def_kernel_thelodica',4750,5000,1,1,1),
('def_npc_percent_mesmer_rank5','def_artifact_damaged_medium_armor_plate',1,2,0.05,1,1),
('def_npc_percent_mesmer_rank5','def_artifact_damaged_medium_armor_repairer',1,2,0.05,1,1),
('def_npc_percent_mesmer_rank5','def_artifact_damaged_armor_repairer_upgrade',1,2,0.05,1,1),
('def_npc_percent_mesmer_rank5','def_artifact_damaged_chm_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_mesmer_rank5','def_artifact_damaged_kin_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_mesmer_rank5','def_artifact_damaged_exp_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_mesmer_rank5','def_artifact_damaged_medium_shield_generator',1,2,0.05,1,1),
('def_npc_percent_mesmer_rank5','def_artifact_damaged_medium_energy_transfer',1,2,0.05,1,1),
('def_npc_percent_mesmer_rank5','def_artifact_damaged_medium_energy_neutralizer',1,2,0.05,1,1),
('def_npc_percent_mesmer_rank5','def_artifact_damaged_core_recharger',1,2,0.05,1,1),
('def_npc_percent_mesmer_rank5','def_artifact_damaged_powergrid_upgrades',1,2,0.05,1,1),
('def_npc_percent_mesmer_rank5','def_artifact_damaged_medium_core_booster',1,1,0.05,1,1),
('def_npc_percent_mesmer_rank5','def_artifact_damaged_maneuvering_upgrade',1,2,0.05,1,1),
('def_npc_percent_mesmer_rank5','def_artifact_damaged_sensor_booster',1,2,0.05,1,1),
('def_npc_percent_mesmer_rank5','def_artifact_damaged_cpu_upgrade',1,2,0.05,1,1),
('def_npc_percent_mesmer_rank5','def_artifact_damaged_tracking_upgrade',1,2,0.05,1,1),
('def_npc_percent_mesmer_rank5','def_artifact_damaged_sensor_dampener',1,2,0.05,1,1),
('def_npc_percent_mesmer_rank5','def_artifact_damaged_blob_emission_modulator',1,2,0.05,1,1),
('def_npc_percent_mesmer_rank5','def_artifact_damaged_damage_mod_railgun',1,2,0.05,1,1),
('def_npc_percent_mesmer_rank5','def_nuimqol_reactor_plasma',4750,5000,1,1,1),
('def_npc_percent_mesmer_rank5','def_kernel_nuimqol',4750,5000,1,1,1),
('def_npc_percent_mesmer_rank4','def_artifact_damaged_medium_armor_plate',1,2,0.05,1,1),
('def_npc_percent_mesmer_rank4','def_artifact_damaged_medium_armor_repairer',1,2,0.05,1,1),
('def_npc_percent_mesmer_rank4','def_artifact_damaged_armor_repairer_upgrade',1,2,0.05,1,1),
('def_npc_percent_mesmer_rank4','def_artifact_damaged_chm_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_mesmer_rank4','def_artifact_damaged_kin_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_mesmer_rank4','def_artifact_damaged_exp_armor_hardener',1,2,0.05,1,1),
('def_npc_percent_mesmer_rank4','def_artifact_damaged_medium_shield_generator',1,2,0.05,1,1),
('def_npc_percent_mesmer_rank4','def_artifact_damaged_medium_energy_transfer',1,2,0.05,1,1),
('def_npc_percent_mesmer_rank4','def_artifact_damaged_medium_energy_neutralizer',1,2,0.05,1,1),
('def_npc_percent_mesmer_rank4','def_artifact_damaged_core_recharger',1,2,0.05,1,1),
('def_npc_percent_mesmer_rank4','def_artifact_damaged_powergrid_upgrades',1,2,0.05,1,1),
('def_npc_percent_mesmer_rank4','def_artifact_damaged_medium_core_booster',1,1,0.05,1,1),
('def_npc_percent_mesmer_rank4','def_artifact_damaged_maneuvering_upgrade',1,2,0.05,1,1),
('def_npc_percent_mesmer_rank4','def_artifact_damaged_sensor_booster',1,2,0.05,1,1),
('def_npc_percent_mesmer_rank4','def_artifact_damaged_cpu_upgrade',1,2,0.05,1,1),
('def_npc_percent_mesmer_rank4','def_artifact_damaged_tracking_upgrade',1,2,0.05,1,1),
('def_npc_percent_mesmer_rank4','def_artifact_damaged_sensor_dampener',1,2,0.05,1,1),
('def_npc_percent_mesmer_rank4','def_artifact_damaged_blob_emission_modulator',1,2,0.05,1,1),
('def_npc_percent_mesmer_rank4','def_artifact_damaged_damage_mod_railgun',1,2,0.05,1,1),
('def_npc_percent_mesmer_rank4','def_nuimqol_reactor_plasma',3750,4000,1,1,1),
('def_npc_percent_mesmer_rank4','def_kernel_nuimqol',3750,4000,1,1,1);


PRINT N'DELETE robottemplates, robottemplaterelation, entitydefaults IF exists (should be 0 for live patch)';
DECLARE @templatesToDelete TABLE (templateid int);
INSERT INTO @templatesToDelete (templateid)
SELECT templateid FROM robottemplaterelation WHERE definition IN (SELECT definition FROM entitydefaults WHERE definitionname IN (SELECT defName FROM #NPCDEFS));

DELETE FROM robottemplaterelation WHERE templateid IN (SELECT templateid FROM @templatesToDelete);
DELETE FROM robottemplates WHERE id IN (SELECT templateid FROM @templatesToDelete);

PRINT N'INSERT/UPDATE (merge) entitydefaults FOR NPCS';
MERGE INTO
  entitydefaults d
USING
  #NPCDEFS n
ON
  n.defName = d.definitionname
WHEN MATCHED THEN
  UPDATE SET
		quantity = 1,
		attributeflags = 1024,
		categoryflags = 911,
		options = '',
		note = '',
		enabled = 1,
		volume = 0,
		mass = 0,
		hidden = 0,
		health = 100,
		descriptiontoken = 'def_npc_fluxspawn_generic_desc',
		purchasable = 0,
		tierlevel = 0,
		tiertype = 0
WHEN NOT MATCHED THEN
	INSERT (definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel)
	VALUES (defName, 1, 1024, 911, '', '', 1, 0, 0, 0, 100, 'def_npc_fluxspawn_generic_desc', 0, 0, 0);


PRINT N'INSERT robottemplates FOR NPCS';
INSERT INTO robottemplates (name, description, note)
SELECT defName+'_template', template, 'new ore npcs template for '+defName FROM #NPCDEFS;

PRINT N'INSERT robottemplaterelation FOR NPCS';
INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, missionlevel, missionleveloverride, killep, note)
SELECT (SELECT definition FROM entitydefaults WHERE definitionname=defName),
	(SELECT id FROM robottemplates WHERE name = defName+'_template'),
	0, 0, NULL, NULL, ep, 'template relation for '+defName
FROM #NPCDEFS;


PRINT N'DELETE OLD STATS';
DELETE FROM aggregatevalues WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #NPCMODS));

PRINT N'INSERT NEW STATS';
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value])
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE defName=definitionname),
	(SELECT TOP 1 id FROM aggregatefields WHERE fieldName=name),
	fieldValue 
FROM #NPCMODS;

PRINT N'DELETE OLD LOOTS';
DELETE FROM npcloot WHERE definition IN (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT npcDefName FROM #LOOT));

PRINT N'INSERT NEW LOOTS';
INSERT INTO [dbo].[npcloot] (definition, lootdefinition, minquantity, quantity, probability, dontdamage, repackaged)
SELECT
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=npcDefName),
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=lootDefName),
	minQuant,
	maxQuant,
	prob,
	dontDmg,
	package
FROM #LOOT;

DROP TABLE IF EXISTS #LOOT;
DROP TABLE IF EXISTS #NPCMODS;
DROP TABLE IF EXISTS #NPCDEFS;
GO

PRINT N'08_NPCReinforcements_createTables_npcs__2020_05_08';

USE [perpetuumsa]
GO

--------------------------------------------------------------------
--Datamodel for NPC Reinforcements: A model for npc spawns that occur on particular set of conditional criteria
--Each record is a presence and a threshold that join to potentially any other table by some targetId.
--The reinforcementType determines the polymorphic behaviour of the record as it is loaded into the server.
--The threshold allows for floating point numeric criteria to gate behaviours and determine percentages or other values to trigger a particular spawn.
--ZoneId if provided can filter presences to spawn if the target event occurs on a particular zone.
--If zone is null, it will appear anywhere the event occurs at the threshold.
--
--Requires Flux ore to be defined first!
--
--Date modified: 2020/06/14
--------------------------------------------------------------------

DROP TABLE IF EXISTS dbo.npcreinforcementtypes;

CREATE TABLE dbo.npcreinforcementtypes (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	name VARCHAR(64) NOT NULL
);

GO

INSERT INTO dbo.npcreinforcementtypes (name) VALUES
('minerals'),
('boss');


DROP TABLE IF EXISTS dbo.npcreinforcements;

CREATE TABLE dbo.npcreinforcements (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	reinforcementType INT NOT NULL,
	targetId INT NOT NULL,
	threshold float NOT NULL,
	presenceId INT NOT NULL,
	zoneId INT
);
GO


DROP TABLE IF EXISTS #WAVES;
CREATE TABLE #WAVES (
	presenceName VARCHAR(100),
	npcDefName VARCHAR(100),
	numInFlock INT,
);

INSERT INTO #WAVES (presenceName, npcDefName, numInFlock) VALUES
--Faction neutral wave
('flux_ore_npc_wave_0', 'def_npc_fivepercent_argano', 2),
('flux_ore_npc_wave_0', 'def_npc_fivepercent_Laird', 2),
--Pelistal waves
('flux_ore_npc_wave_1_pelistal', 'def_npc_fivepercent_argano', 1),
('flux_ore_npc_wave_1_pelistal', 'def_npc_fivepercent_Laird', 1),
('flux_ore_npc_wave_1_pelistal', 'def_npc_tenpercent_castel_rank1', 3),
('flux_ore_npc_wave_1_pelistal', 'def_npc_percent_wasp_rank2', 1),

('flux_ore_npc_wave_2_pelistal', 'def_npc_fivepercent_argano', 1),
('flux_ore_npc_wave_2_pelistal', 'def_npc_fivepercent_Laird', 1),
('flux_ore_npc_wave_2_pelistal', 'def_npc_tenpercent_castel_rank1', 2),
('flux_ore_npc_wave_2_pelistal', 'def_npc_tenpercent_castel_rank2', 1),
('flux_ore_npc_wave_2_pelistal', 'def_npc_percent_wasp_rank2', 1),
('flux_ore_npc_wave_2_pelistal', 'def_npc_percent_wasp_rank3', 1),
('flux_ore_npc_wave_2_pelistal', 'def_npc_percent_tyro_rank3', 1),

('flux_ore_npc_wave_3_pelistal', 'def_npc_fivepercent_argano', 1),
('flux_ore_npc_wave_3_pelistal', 'def_npc_tenpercent_castel_rank1', 1),
('flux_ore_npc_wave_3_pelistal', 'def_npc_tenpercent_castel_rank2', 2),
('flux_ore_npc_wave_3_pelistal', 'def_npc_percent_wasp_rank2', 1),
('flux_ore_npc_wave_3_pelistal', 'def_npc_percent_wasp_rank3', 1),
('flux_ore_npc_wave_3_pelistal', 'def_npc_percent_wasp_rank4', 1),
('flux_ore_npc_wave_3_pelistal', 'def_npc_percent_tyro_rank3', 1),
('flux_ore_npc_wave_3_pelistal', 'def_npc_percent_tyro_rank4', 1),

('flux_ore_npc_wave_4_pelistal', 'def_npc_fivepercent_Laird', 1),
('flux_ore_npc_wave_4_pelistal', 'def_npc_tenpercent_castel_rank2', 3),
('flux_ore_npc_wave_4_pelistal', 'def_npc_percent_wasp_rank3', 1),
('flux_ore_npc_wave_4_pelistal', 'def_npc_percent_wasp_rank4', 2),
('flux_ore_npc_wave_4_pelistal', 'def_npc_percent_tyro_rank3', 2),
('flux_ore_npc_wave_4_pelistal', 'def_npc_percent_tyro_rank4', 1),

('flux_ore_npc_wave_5_pelistal', 'def_npc_tenpercent_castel_rank2', 3),
('flux_ore_npc_wave_5_pelistal', 'def_npc_percent_wasp_rank4', 3),
('flux_ore_npc_wave_5_pelistal', 'def_npc_percent_tyro_rank3', 2),
('flux_ore_npc_wave_5_pelistal', 'def_npc_percent_tyro_rank4', 1),
('flux_ore_npc_wave_5_pelistal', 'def_npc_percent_gropho_rank4', 1),

('flux_ore_npc_wave_6_pelistal', 'def_npc_tenpercent_castel_rank2', 3),
('flux_ore_npc_wave_6_pelistal', 'def_npc_percent_wasp_rank4', 3),
('flux_ore_npc_wave_6_pelistal', 'def_npc_percent_tyro_rank4', 2),
('flux_ore_npc_wave_6_pelistal', 'def_npc_percent_tyro_rank5', 1),
('flux_ore_npc_wave_6_pelistal', 'def_npc_percent_gropho_rank4', 1),

('flux_ore_npc_wave_7_pelistal', 'def_npc_tenpercent_castel_rank2', 3),
('flux_ore_npc_wave_7_pelistal', 'def_npc_percent_wasp_rank4', 3),
('flux_ore_npc_wave_7_pelistal', 'def_npc_percent_tyro_rank4', 1),
('flux_ore_npc_wave_7_pelistal', 'def_npc_percent_tyro_rank5', 2),
('flux_ore_npc_wave_7_pelistal', 'def_npc_percent_gropho_rank4', 2),

('flux_ore_npc_wave_8_pelistal', 'def_npc_tenpercent_castel_rank2', 3),
('flux_ore_npc_wave_8_pelistal', 'def_npc_percent_wasp_rank4', 3),
('flux_ore_npc_wave_8_pelistal', 'def_npc_percent_tyro_rank5', 3),
('flux_ore_npc_wave_8_pelistal', 'def_npc_percent_gropho_rank4', 2),

('flux_ore_npc_wave_9_pelistal', 'def_npc_tenpercent_castel_rank2', 3),
('flux_ore_npc_wave_9_pelistal', 'def_npc_percent_wasp_rank4', 3),
('flux_ore_npc_wave_9_pelistal', 'def_npc_percent_tyro_rank5', 3),
('flux_ore_npc_wave_9_pelistal', 'def_npc_percent_gropho_rank4', 2),
('flux_ore_npc_wave_9_pelistal', 'def_npc_percent_gropho_rank5', 1),

--Thelodica waves
('flux_ore_npc_wave_1_thelodica', 'def_npc_fivepercent_argano', 1),
('flux_ore_npc_wave_1_thelodica', 'def_npc_fivepercent_Laird', 1),
('flux_ore_npc_wave_1_thelodica', 'def_npc_tenpercent_prom_rank1', 3),
('flux_ore_npc_wave_1_thelodica', 'def_npc_percent_baph_rank2', 1),

('flux_ore_npc_wave_2_thelodica', 'def_npc_fivepercent_argano', 1),
('flux_ore_npc_wave_2_thelodica', 'def_npc_fivepercent_Laird', 1),
('flux_ore_npc_wave_2_thelodica', 'def_npc_tenpercent_prom_rank1', 2),
('flux_ore_npc_wave_2_thelodica', 'def_npc_tenpercent_prom_rank2', 1),
('flux_ore_npc_wave_2_thelodica', 'def_npc_percent_baph_rank2', 1),
('flux_ore_npc_wave_2_thelodica', 'def_npc_percent_baph_rank3', 1),
('flux_ore_npc_wave_2_thelodica', 'def_npc_percent_arty_rank3', 1),

('flux_ore_npc_wave_3_thelodica', 'def_npc_fivepercent_argano', 1),
('flux_ore_npc_wave_3_thelodica', 'def_npc_tenpercent_prom_rank1', 1),
('flux_ore_npc_wave_3_thelodica', 'def_npc_tenpercent_prom_rank2', 2),
('flux_ore_npc_wave_3_thelodica', 'def_npc_percent_baph_rank2', 1),
('flux_ore_npc_wave_3_thelodica', 'def_npc_percent_baph_rank3', 1),
('flux_ore_npc_wave_3_thelodica', 'def_npc_percent_baph_rank4', 1),
('flux_ore_npc_wave_3_thelodica', 'def_npc_percent_arty_rank3', 1),
('flux_ore_npc_wave_3_thelodica', 'def_npc_percent_arty_rank4', 1),

('flux_ore_npc_wave_4_thelodica', 'def_npc_fivepercent_Laird', 1),
('flux_ore_npc_wave_4_thelodica', 'def_npc_tenpercent_prom_rank2', 3),
('flux_ore_npc_wave_4_thelodica', 'def_npc_percent_baph_rank3', 1),
('flux_ore_npc_wave_4_thelodica', 'def_npc_percent_baph_rank4', 2),
('flux_ore_npc_wave_4_thelodica', 'def_npc_percent_arty_rank3', 2),
('flux_ore_npc_wave_4_thelodica', 'def_npc_percent_arty_rank4', 1),

('flux_ore_npc_wave_5_thelodica', 'def_npc_tenpercent_prom_rank2', 3),
('flux_ore_npc_wave_5_thelodica', 'def_npc_percent_baph_rank4', 3),
('flux_ore_npc_wave_5_thelodica', 'def_npc_percent_arty_rank3', 2),
('flux_ore_npc_wave_5_thelodica', 'def_npc_percent_arty_rank4', 1),
('flux_ore_npc_wave_5_thelodica', 'def_npc_percent_seth_rank4', 1),

('flux_ore_npc_wave_6_thelodica', 'def_npc_tenpercent_prom_rank2', 3),
('flux_ore_npc_wave_6_thelodica', 'def_npc_percent_baph_rank4', 3),
('flux_ore_npc_wave_6_thelodica', 'def_npc_percent_arty_rank4', 2),
('flux_ore_npc_wave_6_thelodica', 'def_npc_percent_arty_rank5', 1),
('flux_ore_npc_wave_6_thelodica', 'def_npc_percent_seth_rank4', 1),

('flux_ore_npc_wave_7_thelodica', 'def_npc_tenpercent_prom_rank2', 3),
('flux_ore_npc_wave_7_thelodica', 'def_npc_percent_baph_rank4', 3),
('flux_ore_npc_wave_7_thelodica', 'def_npc_percent_arty_rank4', 1),
('flux_ore_npc_wave_7_thelodica', 'def_npc_percent_arty_rank5', 2),
('flux_ore_npc_wave_7_thelodica', 'def_npc_percent_seth_rank4', 2),

('flux_ore_npc_wave_8_thelodica', 'def_npc_tenpercent_prom_rank2', 3),
('flux_ore_npc_wave_8_thelodica', 'def_npc_percent_baph_rank4', 3),
('flux_ore_npc_wave_8_thelodica', 'def_npc_percent_arty_rank5', 3),
('flux_ore_npc_wave_8_thelodica', 'def_npc_percent_seth_rank4', 2),

('flux_ore_npc_wave_9_thelodica', 'def_npc_tenpercent_prom_rank2', 3),
('flux_ore_npc_wave_9_thelodica', 'def_npc_percent_baph_rank4', 3),
('flux_ore_npc_wave_9_thelodica', 'def_npc_percent_arty_rank5', 3),
('flux_ore_npc_wave_9_thelodica', 'def_npc_percent_seth_rank4', 2),
('flux_ore_npc_wave_9_thelodica', 'def_npc_percent_seth_rank5', 1),

--Nuimqol Waves
('flux_ore_npc_wave_1_nuimqol', 'def_npc_fivepercent_argano', 1),
('flux_ore_npc_wave_1_nuimqol', 'def_npc_fivepercent_Laird', 1),
('flux_ore_npc_wave_1_nuimqol', 'def_npc_tenpercent_yagel_rank1', 3),
('flux_ore_npc_wave_1_nuimqol', 'def_npc_percent_arby_rank2', 1),

('flux_ore_npc_wave_2_nuimqol', 'def_npc_fivepercent_argano', 1),
('flux_ore_npc_wave_2_nuimqol', 'def_npc_fivepercent_Laird', 1),
('flux_ore_npc_wave_2_nuimqol', 'def_npc_tenpercent_yagel_rank1', 2),
('flux_ore_npc_wave_2_nuimqol', 'def_npc_tenpercent_yagel_rank2', 1),
('flux_ore_npc_wave_2_nuimqol', 'def_npc_percent_arby_rank2', 1),
('flux_ore_npc_wave_2_nuimqol', 'def_npc_percent_arby_rank3', 1),
('flux_ore_npc_wave_2_nuimqol', 'def_npc_percent_kain_rank3', 1),

('flux_ore_npc_wave_3_nuimqol', 'def_npc_fivepercent_argano', 1),
('flux_ore_npc_wave_3_nuimqol', 'def_npc_tenpercent_yagel_rank1', 1),
('flux_ore_npc_wave_3_nuimqol', 'def_npc_tenpercent_yagel_rank2', 2),
('flux_ore_npc_wave_3_nuimqol', 'def_npc_percent_arby_rank2', 1),
('flux_ore_npc_wave_3_nuimqol', 'def_npc_percent_arby_rank3', 1),
('flux_ore_npc_wave_3_nuimqol', 'def_npc_percent_arby_rank4', 1),
('flux_ore_npc_wave_3_nuimqol', 'def_npc_percent_kain_rank3', 1),
('flux_ore_npc_wave_3_nuimqol', 'def_npc_percent_kain_rank4', 1),

('flux_ore_npc_wave_4_nuimqol', 'def_npc_fivepercent_Laird', 1),
('flux_ore_npc_wave_4_nuimqol', 'def_npc_tenpercent_yagel_rank2', 3),
('flux_ore_npc_wave_4_nuimqol', 'def_npc_percent_arby_rank3', 1),
('flux_ore_npc_wave_4_nuimqol', 'def_npc_percent_arby_rank4', 2),
('flux_ore_npc_wave_4_nuimqol', 'def_npc_percent_kain_rank3', 2),
('flux_ore_npc_wave_4_nuimqol', 'def_npc_percent_kain_rank4', 1),

('flux_ore_npc_wave_5_nuimqol', 'def_npc_tenpercent_yagel_rank2', 3),
('flux_ore_npc_wave_5_nuimqol', 'def_npc_percent_arby_rank4', 3),
('flux_ore_npc_wave_5_nuimqol', 'def_npc_percent_kain_rank3', 2),
('flux_ore_npc_wave_5_nuimqol', 'def_npc_percent_kain_rank4', 1),
('flux_ore_npc_wave_5_nuimqol', 'def_npc_percent_mesmer_rank4', 1),

('flux_ore_npc_wave_6_nuimqol', 'def_npc_tenpercent_yagel_rank2', 3),
('flux_ore_npc_wave_6_nuimqol', 'def_npc_percent_arby_rank4', 3),
('flux_ore_npc_wave_6_nuimqol', 'def_npc_percent_kain_rank4', 2),
('flux_ore_npc_wave_6_nuimqol', 'def_npc_percent_kain_rank5', 1),
('flux_ore_npc_wave_6_nuimqol', 'def_npc_percent_mesmer_rank4', 1),

('flux_ore_npc_wave_7_nuimqol', 'def_npc_tenpercent_yagel_rank2', 3),
('flux_ore_npc_wave_7_nuimqol', 'def_npc_percent_arby_rank4', 3),
('flux_ore_npc_wave_7_nuimqol', 'def_npc_percent_kain_rank4', 1),
('flux_ore_npc_wave_7_nuimqol', 'def_npc_percent_kain_rank5', 2),
('flux_ore_npc_wave_7_nuimqol', 'def_npc_percent_mesmer_rank4', 2),

('flux_ore_npc_wave_8_nuimqol', 'def_npc_tenpercent_yagel_rank2', 3),
('flux_ore_npc_wave_8_nuimqol', 'def_npc_percent_arby_rank4', 3),
('flux_ore_npc_wave_8_nuimqol', 'def_npc_percent_kain_rank5', 3),
('flux_ore_npc_wave_8_nuimqol', 'def_npc_percent_mesmer_rank4', 2),

('flux_ore_npc_wave_9_nuimqol', 'def_npc_tenpercent_yagel_rank2', 3),
('flux_ore_npc_wave_9_nuimqol', 'def_npc_percent_arby_rank4', 3),
('flux_ore_npc_wave_9_nuimqol', 'def_npc_percent_kain_rank5', 3),
('flux_ore_npc_wave_9_nuimqol', 'def_npc_percent_mesmer_rank4', 2),
('flux_ore_npc_wave_9_nuimqol', 'def_npc_percent_mesmer_rank5', 1);


--This is what we should use
DELETE FROM npcflock WHERE presenceid in (SELECT id FROM npcpresence WHERE name in (SELECT DISTINCT presenceName FROM #WAVES));
DELETE FROM npcpresence WHERE name in (SELECT DISTINCT presenceName FROM #WAVES);

INSERT INTO npcpresence 
	(name,topx,topy,bottomx,bottomy,note,spawnid,enabled,roaming,roamingrespawnseconds,presencetype,maxrandomflock,randomcenterx,randomcentery,randomradius,dynamiclifetime,isbodypull,isrespawnallowed,safebodypull,izgroupid)
SELECT DISTINCT 
	presenceName, 0, 0, 0, 0, presenceName, 10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL
FROM #WAVES;

INSERT INTO npcflock
	(name,presenceid,flockmembercount,definition,spawnoriginX,spawnoriginY,spawnrangeMin,spawnrangeMax,respawnseconds,totalspawncount,homerange,note,respawnmultiplierlow,enabled,iscallforhelp,behaviorType,npcSpecialType)
SELECT 
	presenceName+npcDefName, (SELECT id FROM npcpresence WHERE name=presenceName), numInFlock, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=npcDefName), 0, 0, 0, 10, 0, 1, 35, presenceName+npcDefName, 0.5, 1, 1, 2, 0
FROM #WAVES;


DECLARE @fluxOre INT;
SET @fluxOre = (SELECT TOP 1 idx FROM minerals WHERE name = 'fluxore');

DECLARE @reinforceType INT;
SET @reinforceType = (SELECT TOP 1 id FROM npcreinforcementtypes WHERE name='minerals');


DECLARE @domhalarn INT;
DECLARE @hokkogaros INT;
DECLARE @norhoop INT;
DECLARE @kentagura INT;
DECLARE @alsbale INT;
DECLARE @novastrov INT;

SET @domhalarn = (SELECT TOP 1 id FROM zones WHERE note='domhalarn' AND name='zone_ICS_A_real');
SET @hokkogaros = (SELECT TOP 1 id FROM zones WHERE note='hokkogaros' AND name='zone_ASI_A_real');
SET @norhoop = (SELECT TOP 1 id FROM zones WHERE note='norhoop' AND name='zone_TM_A_real');
SET @kentagura = (SELECT TOP 1 id FROM zones WHERE note='kentagura' AND name='zone_ASI_pvp');
SET @alsbale = (SELECT TOP 1 id FROM zones WHERE note='alsbale' AND name='zone_TM_pvp');
SET @novastrov = (SELECT TOP 1 id FROM zones WHERE note='novastrov' AND name='zone_ICS_pvp');


INSERT INTO dbo.npcreinforcements (reinforcementType, targetId, threshold, presenceId, zoneId) VALUES
(@reinforceType, @fluxOre, 0.1, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_0'), NULL),

(@reinforceType, @fluxOre, 0.2, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_1_pelistal'), @norhoop),
(@reinforceType, @fluxOre, 0.3, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_2_pelistal'), @norhoop),
(@reinforceType, @fluxOre, 0.4, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_3_pelistal'), @norhoop),
(@reinforceType, @fluxOre, 0.5, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_4_pelistal'), @norhoop),
(@reinforceType, @fluxOre, 0.6, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_5_pelistal'), @norhoop),
(@reinforceType, @fluxOre, 0.7, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_6_pelistal'), @norhoop),
(@reinforceType, @fluxOre, 0.8, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_7_pelistal'), @norhoop),
(@reinforceType, @fluxOre, 0.9, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_8_pelistal'), @norhoop),
(@reinforceType, @fluxOre, 0.95, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_9_pelistal'), @norhoop),

(@reinforceType, @fluxOre, 0.2, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_1_pelistal'), @alsbale),
(@reinforceType, @fluxOre, 0.3, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_2_pelistal'), @alsbale),
(@reinforceType, @fluxOre, 0.4, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_3_pelistal'), @alsbale),
(@reinforceType, @fluxOre, 0.5, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_4_pelistal'), @alsbale),
(@reinforceType, @fluxOre, 0.6, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_5_pelistal'), @alsbale),
(@reinforceType, @fluxOre, 0.7, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_6_pelistal'), @alsbale),
(@reinforceType, @fluxOre, 0.8, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_7_pelistal'), @alsbale),
(@reinforceType, @fluxOre, 0.9, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_8_pelistal'), @alsbale),
(@reinforceType, @fluxOre, 0.95, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_9_pelistal'), @alsbale),

(@reinforceType, @fluxOre, 0.2, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_1_thelodica'), @hokkogaros),
(@reinforceType, @fluxOre, 0.3, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_2_thelodica'), @hokkogaros),
(@reinforceType, @fluxOre, 0.4, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_3_thelodica'), @hokkogaros),
(@reinforceType, @fluxOre, 0.5, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_4_thelodica'), @hokkogaros),
(@reinforceType, @fluxOre, 0.6, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_5_thelodica'), @hokkogaros),
(@reinforceType, @fluxOre, 0.7, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_6_thelodica'), @hokkogaros),
(@reinforceType, @fluxOre, 0.8, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_7_thelodica'), @hokkogaros),
(@reinforceType, @fluxOre, 0.9, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_8_thelodica'), @hokkogaros),
(@reinforceType, @fluxOre, 0.95, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_9_thelodica'), @hokkogaros),

(@reinforceType, @fluxOre, 0.2, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_1_thelodica'), @kentagura),
(@reinforceType, @fluxOre, 0.3, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_2_thelodica'), @kentagura),
(@reinforceType, @fluxOre, 0.4, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_3_thelodica'), @kentagura),
(@reinforceType, @fluxOre, 0.5, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_4_thelodica'), @kentagura),
(@reinforceType, @fluxOre, 0.6, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_5_thelodica'), @kentagura),
(@reinforceType, @fluxOre, 0.7, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_6_thelodica'), @kentagura),
(@reinforceType, @fluxOre, 0.8, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_7_thelodica'), @kentagura),
(@reinforceType, @fluxOre, 0.9, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_8_thelodica'), @kentagura),
(@reinforceType, @fluxOre, 0.95, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_9_thelodica'), @kentagura),

(@reinforceType, @fluxOre, 0.2, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_1_nuimqol'), @domhalarn),
(@reinforceType, @fluxOre, 0.3, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_2_nuimqol'), @domhalarn),
(@reinforceType, @fluxOre, 0.4, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_3_nuimqol'), @domhalarn),
(@reinforceType, @fluxOre, 0.5, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_4_nuimqol'), @domhalarn),
(@reinforceType, @fluxOre, 0.6, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_5_nuimqol'), @domhalarn),
(@reinforceType, @fluxOre, 0.7, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_6_nuimqol'), @domhalarn),
(@reinforceType, @fluxOre, 0.8, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_7_nuimqol'), @domhalarn),
(@reinforceType, @fluxOre, 0.9, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_8_nuimqol'), @domhalarn),
(@reinforceType, @fluxOre, 0.95, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_9_nuimqol'), @domhalarn),

(@reinforceType, @fluxOre, 0.2, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_1_nuimqol'), @novastrov),
(@reinforceType, @fluxOre, 0.3, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_2_nuimqol'), @novastrov),
(@reinforceType, @fluxOre, 0.4, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_3_nuimqol'), @novastrov),
(@reinforceType, @fluxOre, 0.5, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_4_nuimqol'), @novastrov),
(@reinforceType, @fluxOre, 0.6, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_5_nuimqol'), @novastrov),
(@reinforceType, @fluxOre, 0.7, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_6_nuimqol'), @novastrov),
(@reinforceType, @fluxOre, 0.8, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_7_nuimqol'), @novastrov),
(@reinforceType, @fluxOre, 0.9, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_8_nuimqol'), @novastrov),
(@reinforceType, @fluxOre, 0.95, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_9_nuimqol'), @novastrov);


DROP TABLE IF EXISTS #WAVES;
GO


PRINT N'09_BOT_nuimqol_large';

USE [perpetuumsa]
GO
--------------------------------------------------------------
--Big Bot makin script
--1 - Create robotcomponents
--2 - Create bot definition (with parts - creates associations for bonuses)
--3 - Add stats (aggvalues)
--4 - Add bonuses
--5 - Add required skills to pilot
--6 - Add RobotTemplate (empty) for robot parts - creates associations for stats and rendering definitions TODO
--7 - Create RobotTemplateRelation to relate bot def to template TODO
--------------------------------------------------------------

DECLARE @largeBotCF bigint;
SET @largeBotCF = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_walkers');
UPDATE categoryFlags SET
	hidden=0
WHERE value=@largeBotCF;

--MAKE PARTS OF ROBOT, THEN ROBOT DEFINITION
DECLARE @botName varchar(100);
DECLARE @botDef int;
DECLARE @botDefHex VARCHAR(50);
DECLARE @headName varchar(100);
DECLARE @headDef int;
DECLARE @headDefHex VARCHAR(50);
DECLARE @chassisName varchar(100);
DECLARE @chassisDef int;
DECLARE @chassisDefHex VARCHAR(50);
DECLARE @legName varchar(100);
DECLARE @legDef int;
DECLARE @legDefHex VARCHAR(50);
DECLARE @tintColor VARCHAR(50);

DECLARE @PRbotName varchar(100);
DECLARE @PRbotDef int;

SET @headName = 'def_felos_bot_head';
SET @headDef = 6005;
SET @chassisName = 'def_felos_bot_chassis';
SET @chassisDef = 6006;
SET @legName = 'def_felos_bot_leg';
SET @legDef = 6007;
SET @botName = 'def_felos_bot';
SET @botDef = 6008;
SET @tintColor ='#011D39';

SET @PRbotName = 'def_felos_bot_pr';
SET @PRbotDef = 6009;

DECLARE @headMass int;
DECLARE @chassisMass int;
DECLARE @legMass int;
SET @headMass = 3000;
SET @chassisMass = 60000;
SET @legMass = 12000;


PRINT N'INTEGRITY CHECK: ALL NAMED ENTITYDEFAULTS WITH SPECIFIED IDs MUST BE INSERTED WITH THE SPECIFIED ID';
IF EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE @botDef=definition AND @botName!=definitionname)
OR EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE @headDef=definition AND @headName!=definitionname)
OR EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE @chassisDef=definition AND @chassisName!=definitionname)
OR EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE @legDef=definition AND @legName!=definitionname)
OR EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE @PRbotDef=definition AND @PRbotName!=definitionname)
BEGIN
	PRINT N'DEFINITION INTEGRITY CHECK FAILED! SKIPPING ALL EXECUTION IN THIS SCRIPT';
	SET NOEXEC ON;
END


PRINT N'DEFINE HEAD';
IF EXISTS (SELECT TOP 1 definition from dbo.entitydefaults WHERE definitionname=@headName)
BEGIN
	UPDATE entitydefaults SET
		categoryflags = 328016,
		options = '#height=f0.2#slotFlags=48,8,8,8',
		volume = 3,
		mass = @headMass
	WHERE definitionname=@headName;
END
ELSE
BEGIN
	SET IDENTITY_INSERT entitydefaults ON;
	INSERT INTO entitydefaults (definition, definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
	VALUES 
	(@headDef, @headName, 1, 1024, 328016, '#height=f0.2#slotFlags=48,8,8,8', '', 1, 3, @headMass, 1, 100, 'bot_head_desc', 0, 0, 0); 
	SET IDENTITY_INSERT entitydefaults OFF;
END

PRINT N'DEFINE CHASSIS';

IF EXISTS (SELECT TOP 1 definition from dbo.entitydefaults WHERE definitionname=@chassisName)
BEGIN
	UPDATE entitydefaults SET
		categoryflags = 328272,
		options = '#height=f2#slotFlags=4111,111,111,111,111,111',
		volume = 20,
		mass = @chassisMass
	WHERE definitionname=@chassisName;
END
ELSE
BEGIN
	SET IDENTITY_INSERT entitydefaults ON;
	INSERT INTO entitydefaults (definition, definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
	VALUES 
	(@chassisDef, @chassisName, 1, 1024, 328272, '#height=f2#slotFlags=4111,111,111,111,111,111', '', 1, 20, @chassisMass, 1, 100, 'bot_chassis_desc', 0, 0, 0); 
	SET IDENTITY_INSERT entitydefaults OFF;
END

PRINT N'DEFINE LEGS';

IF EXISTS (SELECT TOP 1 definition from dbo.entitydefaults WHERE definitionname=@legName)
BEGIN
	UPDATE entitydefaults SET
		categoryflags = 328528,
		options = '#height=f1.1#slotFlags=420,20,20,20,20',
		volume = 20,
		mass = @legMass
	WHERE definitionname=@legName;
END
ELSE
BEGIN
	SET IDENTITY_INSERT entitydefaults ON;
	INSERT INTO entitydefaults (definition, definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
	VALUES 
	(@legDef, @legName, 1, 1024, 328528, '#height=f1.1#slotFlags=420,20,20,20,20', '', 1, 20, @legMass, 1, 100, 'bot_leg_desc', 0, 0, 0); 
	SET IDENTITY_INSERT entitydefaults OFF;
END


SET @headDef = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@headName);
SET @headDefHex = (SELECT dbo.ToHex(@headDef));
SET @chassisDef = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@chassisName);
SET @chassisDefHex = (SELECT dbo.ToHex(@chassisDef));
SET @legDef = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@legName);
SET @legDefHex = (SELECT dbo.ToHex(@legDef));

PRINT N'DEFINE BOT';

--BOT DEFINITION
IF EXISTS (SELECT TOP 1 definition from dbo.entitydefaults WHERE definitionname=@botName)
BEGIN
	UPDATE entitydefaults SET
		attributeflags=0,
		categoryflags = @largeBotCF,
		options = '#head=i'+@headDefHex+'#chassis=i'+@chassisDefHex+'#leg=i'+@legDefHex+'#container=i14c',
		volume = 22.5,
		mass = 0,
		descriptiontoken = @botName+'_desc'
	WHERE definitionname=@botName;
END
ELSE
BEGIN
	SET IDENTITY_INSERT entitydefaults ON;
	INSERT INTO entitydefaults (definition, definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
	VALUES 
	(@botDef, @botName, 1, 0, @largeBotCF, '#head=i'+@headDefHex+'#chassis=i'+@chassisDefHex+'#leg=i'+@legDefHex+'#container=i14c', '', 1, 22.5, 0, 0, 100, @botName+'_desc', 1, 0, 0); 
	SET IDENTITY_INSERT entitydefaults OFF;
END

--PROTOYPE BOT DEFINITION
IF EXISTS (SELECT TOP 1 definition from dbo.entitydefaults WHERE definitionname=@PRbotName)
BEGIN
	UPDATE entitydefaults SET
		attributeflags=0,
		categoryflags = @largeBotCF,
		options = '#head=i'+@headDefHex+'#chassis=i'+@chassisDefHex+'#leg=i'+@legDefHex+'#container=i14c #tier=$tierlevel_pr',
		volume = 22.5,
		mass = 0,
		descriptiontoken = @PRbotName+'_desc',
		tiertype=2
	WHERE definitionname=@PRbotName;
END
ELSE
BEGIN
	SET IDENTITY_INSERT entitydefaults ON;
	INSERT INTO entitydefaults (definition, definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
	VALUES 
	(@PRbotDef, @PRbotName, 1, 0, @largeBotCF, '#head=i'+@headDefHex+'#chassis=i'+@chassisDefHex+'#leg=i'+@legDefHex+'#container=i14c #tier=$tierlevel_pr', '', 1, 22.5, 0, 0, 100, @PRbotName+'_desc', 1, 2, 0);
	SET IDENTITY_INSERT entitydefaults OFF;
END

SET @botDef = (SELECT TOP 1 definition from dbo.entitydefaults WHERE definitionname=@botName);
SET @botDefHex = (SELECT dbo.ToHex(@botDef));


PRINT N'DEFINE ROBOTTEMPLATE';
DECLARE @botTemplateName VARCHAR(100);
SET @botTemplateName = @botName+'_template';

IF EXISTS (SELECT TOP 1 id FROM robottemplates WHERE name=@botTemplateName)
BEGIN
	UPDATE robottemplates SET
	description = '#robot=i'+@botDefHex+'#head=i'+@headDefHex+'#chassis=i'+@chassisDefHex+'#leg=i'+@legDefHex+'#container=i1148#headModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]|m2=[|definition=i0|slot=i3]|m3=[|definition=i0|slot=i4]]#chassisModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]|m2=[|definition=i0|slot=i3]|m3=[|definition=i0|slot=i4]|m4=[|definition=i0|slot=i5]|m5=[|definition=i0|slot=i6]]#legModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]|m2=[|definition=i0|slot=i3]|m3=[|definition=i0|slot=i4]]'
	WHERE name=@botTemplateName;
END
ELSE
BEGIN
	INSERT INTO robottemplates ([name], [description], [note]) VALUES 
	(@botTemplateName,
	'#robot=i'+@botDefHex+'#head=i'+@headDefHex+'#chassis=i'+@chassisDefHex+'#leg=i'+@legDefHex+'#container=i1148#headModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]|m2=[|definition=i0|slot=i3]|m3=[|definition=i0|slot=i4]]#chassisModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]|m2=[|definition=i0|slot=i3]|m3=[|definition=i0|slot=i4]|m4=[|definition=i0|slot=i5]|m5=[|definition=i0|slot=i6]]#legModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]|m2=[|definition=i0|slot=i3]|m3=[|definition=i0|slot=i4]]',
	'new large robot template - empty');
END

PRINT N'DEFINE ROBOTTEMPLATERELATION';
IF EXISTS (SELECT TOP 1 definition FROM [robottemplaterelation] WHERE definition=@botDef)
BEGIN
	UPDATE [robottemplaterelation] SET
		templateid = (SELECT TOP 1 id FROM robottemplates WHERE name=@botTemplateName),
		itemscoresum = 0,
		raceid = 1,
		missionlevel = NULL,
		missionleveloverride = NULL,
		killep = 0
	WHERE definition=@botDef;
END
ELSE
BEGIN
	INSERT INTO [dbo].[robottemplaterelation]([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
	VALUES
	(@botDef,(SELECT TOP 1 id FROM robottemplates WHERE name=@botTemplateName),0,1,NULL,NULL,0,'new large bot relation - empty');
END

PRINT N'DEFINE ROBOTTEMPLATERELATION FOR PROTO';
IF EXISTS (SELECT TOP 1 definition FROM [robottemplaterelation] WHERE definition=@PRbotDef)
BEGIN
	UPDATE [robottemplaterelation] SET
		templateid = (SELECT TOP 1 id FROM robottemplates WHERE name=@botTemplateName),
		itemscoresum = 0,
		raceid = 1,
		missionlevel = NULL,
		missionleveloverride = NULL,
		killep = 0
	WHERE definition=@PRbotDef;
END
ELSE
BEGIN
	INSERT INTO [dbo].[robottemplaterelation]([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
	VALUES
	(@PRbotDef,(SELECT TOP 1 id FROM robottemplates WHERE name=@botTemplateName),0,1,NULL,NULL,0,'new large bot relation - empty');
END

--BOT STATS

DROP TABLE IF EXISTS #BOTSTATS
CREATE TABLE #BOTSTATS 
(
	partDef int,
	name varchar(100),
	value float,
)

INSERT INTO #BOTSTATS (partDef, name, value) VALUES
(@headDef, 'cpu_max', 1750),
(@headDef, 'locked_targets_max', 2),
(@headDef, 'locking_range', 36),
(@headDef, 'locking_time', 15000),
(@headDef, 'sensor_strength', 95),
(@headDef, 'blob_emission', 25),
(@headDef, 'blob_emission_radius', 35),
(@headDef, 'blob_level_low', 75),
(@headDef, 'blob_level_high', 400),
(@headDef, 'detection_strength', 55),
(@headDef, 'stealth_strength', 55),
(@chassisDef, 'ammo_reload_time', 15000),
(@chassisDef, 'armor_max', 6300),
(@chassisDef, 'core_max', 5900),
(@chassisDef, 'core_recharge_time', 1200),
(@chassisDef, 'powergrid_max', 5160),
(@chassisDef, 'resist_chemical', 30),
(@chassisDef, 'resist_explosive', 150),
(@chassisDef, 'resist_kinetic', 45),
(@chassisDef, 'resist_thermal', 10),
(@chassisDef, 'signature_radius', 30),
(@chassisDef, 'missile_miss', 0.9),
(@chassisDef, 'reactor_radiation', 15),
(@legDef, 'slope', 4),
(@legDef, 'speed_max', 1.52777);

PRINT N'DELETE BOT STATS';
DELETE FROM aggregatevalues WHERE definition in (SELECT DISTINCT partDef FROM #BOTSTATS);


PRINT N'INSERT BOT STATS';
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value])
SELECT 
	#BOTSTATS.partDef, 
	(SELECT TOP 1 id FROM aggregatefields WHERE #BOTSTATS.name=aggregatefields.name),
	#BOTSTATS.value 
FROM #BOTSTATS


DECLARE @extensionName varchar(100);
DECLARE @extensionID int;

SET @extensionName = 'ext_assault_unit_piloting';
SET @extensionID = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname=@extensionName);

DECLARE @factionPilotExt int;
SET @factionPilotExt = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname='ext_nuimqol_specialist');

DECLARE @combatSpecExt int;
SET @combatSpecExt = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname='ext_combat_specialist');


PRINT N'UNHIDE ANY NEW EXTENSIONS USED FOR BOT BONUSES';
UPDATE extensions SET active=1, hidden=0 WHERE extensionid=@extensionID;

DROP TABLE IF EXISTS #BOTBONUSES;
CREATE TABLE #BOTBONUSES 
(
	partDef int,
	extID int,
	name varchar(100),
	bonus float,
);
INSERT INTO #BOTBONUSES (partDef, extID, name, bonus) VALUES
(@chassisDef, @extensionID, 'cpu_usage_large_railgun_modifier', 0.03),
(@chassisDef, @extensionID, 'powergrid_usage_large_railgun_modifier', 0.03),
(@chassisDef, @extensionID, 'damage_large_railgun_modifier', 0.05),
(@chassisDef, @combatSpecExt, 'massiveness', 0.02),
(@chassisDef, @combatSpecExt, 'core_usage_railgun_modifier', -0.02),
(@chassisDef, @factionPilotExt, 'armor_repair_amount_modifier', 0.05);

PRINT N'DELETE BOT BONUSES';
DELETE FROM chassisbonus WHERE definition in (SELECT DISTINCT partDef FROM #BOTBONUSES);

PRINT N'INSERT BOT BONUSES';
INSERT INTO chassisbonus (definition, extension, bonus, note, targetpropertyID, effectenhancer)
SELECT b.partDef, b.extID, b.bonus, 'Large bot bonus', (SELECT TOP 1 id FROM aggregatefields WHERE name=b.name), 0 FROM #BOTBONUSES AS b;

--DELETE and REINSERT
PRINT N'DELETE BOT REQ-EXTENSIONS';
DELETE FROM enablerextensions WHERE definition=@botDef;
PRINT N'INSERT BOT REQ-EXTENSIONS';
INSERT INTO [dbo].[enablerextensions] ([definition],[extensionid],[extensionlevel]) VALUES
(@botDef, @extensionID, 4),
(@botDef, (SELECT TOP 1 extensionid FROM extensions WHERE extensionname='ext_high_tech_specialist'), 8),
(@botDef, @factionPilotExt, 10);

PRINT N'DELETE PROTO-BOT REQ-EXTENSIONS';
DELETE FROM enablerextensions WHERE definition=@PRbotDef;
PRINT N'INSERT PROTO-BOT REQ-EXTENSIONS';
INSERT INTO [dbo].[enablerextensions] ([definition],[extensionid],[extensionlevel]) VALUES
(@PRbotDef, @extensionID, 4),
(@PRbotDef, (SELECT TOP 1 extensionid FROM extensions WHERE extensionname='ext_high_tech_specialist'), 8),
(@PRbotDef, @factionPilotExt, 10);


PRINT N'DEFINE colors';
IF EXISTS (SELECT TOP 1 definition FROM [definitionconfig] WHERE definition=@botDef)
BEGIN
	UPDATE [definitionconfig] SET
		tint=@tintColor
	WHERE definition in (@headDef, @chassisDef, @legDef, @botDef, @PRbotDef);
END
ELSE
BEGIN
	INSERT INTO [dbo].[definitionconfig]
		([definition],[tint],[note])
	VALUES
		(@headDef, @tintColor,'Large bot native color'),
		(@chassisDef, @tintColor,'Large bot native color'),
		(@legDef, @tintColor,'Large bot native color'),
		(@botDef, @tintColor,'Large bot native color'),
		(@PRbotDef, @tintColor,'Large bot native color');
END


DROP TABLE IF EXISTS #BOTSTATS;
DROP TABLE IF EXISTS #BOTBONUSES;
SET NOEXEC OFF;
PRINT N'LARGE NUIMQOL BOT INSERT';
GO


PRINT N'10_BOT_pelistal_large';

USE [perpetuumsa]
GO
--------------------------------------------------------------
--Big Bot makin script
--1 - Create robotcomponents
--2 - Create bot definition (with parts - creates associations for bonuses)
--3 - Add stats (aggvalues)
--4 - Add bonuses
--5 - Add required skills to pilot
--6 - Add RobotTemplate (empty) for robot parts - creates associations for stats and rendering definitions TODO
--7 - Create RobotTemplateRelation to relate bot def to template TODO
--------------------------------------------------------------

DECLARE @largeBotCF bigint;
SET @largeBotCF = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_walkers');
UPDATE categoryFlags SET
	hidden=0
WHERE value=@largeBotCF;

--MAKE PARTS OF ROBOT, THEN ROBOT DEFINITION
DECLARE @botName varchar(100);
DECLARE @botDef int;
DECLARE @botDefHex VARCHAR(50);
DECLARE @headName varchar(100);
DECLARE @headDef int;
DECLARE @headDefHex VARCHAR(50);
DECLARE @chassisName varchar(100);
DECLARE @chassisDef int;
DECLARE @chassisDefHex VARCHAR(50);
DECLARE @legName varchar(100);
DECLARE @legDef int;
DECLARE @legDefHex VARCHAR(50);
DECLARE @tintColor VARCHAR(50);

DECLARE @PRbotName varchar(100);
DECLARE @PRbotDef int;

SET @headName = 'def_hydra_bot_head';
SET @headDef = 6000;
SET @chassisName = 'def_hydra_bot_chassis';
SET @chassisDef = 6001;
SET @legName = 'def_hydra_bot_leg';
SET @legDef = 6002;
SET @botName = 'def_hydra_bot';
SET @botDef = 6003;
SET @tintColor ='#062A0D';

SET @PRbotName = 'def_hydra_bot_pr';
SET @PRbotDef = 6004;

DECLARE @headMass int;
DECLARE @chassisMass int;
DECLARE @legMass int;
SET @headMass = 3000;
SET @chassisMass = 60000;
SET @legMass = 12000;


PRINT N'INTEGRITY CHECK: ALL NAMED ENTITYDEFAULTS WITH SPECIFIED IDs MUST BE INSERTED WITH THE SPECIFIED ID';
IF EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE @botDef=definition AND @botName!=definitionname)
OR EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE @headDef=definition AND @headName!=definitionname)
OR EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE @chassisDef=definition AND @chassisName!=definitionname)
OR EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE @legDef=definition AND @legName!=definitionname)
OR EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE @PRbotDef=definition AND @PRbotName!=definitionname)
BEGIN
	PRINT N'DEFINITION INTEGRITY CHECK FAILED! SKIPPING ALL EXECUTION IN THIS SCRIPT';
	SET NOEXEC ON;
END


PRINT N'DEFINE HEAD';
IF EXISTS (SELECT TOP 1 definition from dbo.entitydefaults WHERE definitionname=@headName)
BEGIN
	UPDATE entitydefaults SET
		categoryflags = 328016,
		options = '#height=f0.2#slotFlags=48,8,8,8,8',
		volume = 3,
		mass = @headMass
	WHERE definitionname=@headName;
END
ELSE
BEGIN
	SET IDENTITY_INSERT entitydefaults ON;
	INSERT INTO entitydefaults (definition, definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
	VALUES 
	(@headDef, @headName, 1, 1024, 328016, '#height=f0.2#slotFlags=48,8,8,8,8', '', 1, 3, @headMass, 1, 100, 'bot_head_desc', 0, 0, 0); 
	SET IDENTITY_INSERT entitydefaults OFF;
END

PRINT N'DEFINE CHASSIS';

IF EXISTS (SELECT TOP 1 definition from dbo.entitydefaults WHERE definitionname=@chassisName)
BEGIN
	UPDATE entitydefaults SET
		categoryflags = 328272,
		options = '#height=f2#slotFlags=4112,112,112,112,112,112',
		volume = 20,
		mass = @chassisMass
	WHERE definitionname=@chassisName;
END
ELSE
BEGIN
	SET IDENTITY_INSERT entitydefaults ON;
	INSERT INTO entitydefaults (definition, definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
	VALUES 
	(@chassisDef, @chassisName, 1, 1024, 328272, '#height=f2#slotFlags=4112,112,112,112,112,112', '', 1, 20, @chassisMass, 1, 100, 'bot_chassis_desc', 0, 0, 0); 
	SET IDENTITY_INSERT entitydefaults OFF;
END

PRINT N'DEFINE LEGS';

IF EXISTS (SELECT TOP 1 definition from dbo.entitydefaults WHERE definitionname=@legName)
BEGIN
	UPDATE entitydefaults SET
		categoryflags = 328528,
		options = '#height=f1.1#slotFlags=420,20,20,20',
		volume = 20,
		mass = @legMass
	WHERE definitionname=@legName;
END
ELSE
BEGIN
	SET IDENTITY_INSERT entitydefaults ON;
	INSERT INTO entitydefaults (definition, definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
	VALUES 
	(@legDef, @legName, 1, 1024, 328528, '#height=f1.1#slotFlags=420,20,20,20', '', 1, 20, @legMass, 1, 100, 'bot_leg_desc', 0, 0, 0); 
	SET IDENTITY_INSERT entitydefaults OFF;
END


SET @headDef = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@headName);
SET @headDefHex = (SELECT dbo.ToHex(@headDef));
SET @chassisDef = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@chassisName);
SET @chassisDefHex = (SELECT dbo.ToHex(@chassisDef));
SET @legDef = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@legName);
SET @legDefHex = (SELECT dbo.ToHex(@legDef));

PRINT N'DEFINE BOT';

--BOT DEFINITION
IF EXISTS (SELECT TOP 1 definition from dbo.entitydefaults WHERE definitionname=@botName)
BEGIN
	UPDATE entitydefaults SET
		attributeflags=0,
		categoryflags = @largeBotCF,
		options = '#head=i'+@headDefHex+'#chassis=i'+@chassisDefHex+'#leg=i'+@legDefHex+'#container=i14c',
		volume = 22.5,
		mass = 0,
		descriptiontoken = @botName+'_desc'
	WHERE definitionname=@botName;
END
ELSE
BEGIN
	SET IDENTITY_INSERT entitydefaults ON;
	INSERT INTO entitydefaults (definition, definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
	VALUES 
	(@botDef, @botName, 1, 0, @largeBotCF, '#head=i'+@headDefHex+'#chassis=i'+@chassisDefHex+'#leg=i'+@legDefHex+'#container=i14c', '', 1, 22.5, 0, 0, 100, @botName+'_desc', 1, 0, 0); 
	SET IDENTITY_INSERT entitydefaults OFF;
END

--PROTOYPE BOT DEFINITION
IF EXISTS (SELECT TOP 1 definition from dbo.entitydefaults WHERE definitionname=@PRbotName)
BEGIN
	UPDATE entitydefaults SET
		attributeflags=0,
		categoryflags = @largeBotCF,
		options = '#head=i'+@headDefHex+'#chassis=i'+@chassisDefHex+'#leg=i'+@legDefHex+'#container=i14c #tier=$tierlevel_pr',
		volume = 22.5,
		mass = 0,
		descriptiontoken = @PRbotName+'_desc',
		tiertype=2
	WHERE definitionname=@PRbotName;
END
ELSE
BEGIN
	SET IDENTITY_INSERT entitydefaults ON;
	INSERT INTO entitydefaults (definition, definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
	VALUES 
	(@PRbotDef, @PRbotName, 1, 0, @largeBotCF, '#head=i'+@headDefHex+'#chassis=i'+@chassisDefHex+'#leg=i'+@legDefHex+'#container=i14c #tier=$tierlevel_pr', '', 1, 22.5, 0, 0, 100, @PRbotName+'_desc', 1, 2, 0);
	SET IDENTITY_INSERT entitydefaults OFF;
END


SET @botDef = (SELECT TOP 1 definition from dbo.entitydefaults WHERE definitionname=@botName);
SET @botDefHex = (SELECT dbo.ToHex(@botDef));


PRINT N'DEFINE ROBOTTEMPLATE';
DECLARE @botTemplateName VARCHAR(100);
SET @botTemplateName = @botName+'_template';

IF EXISTS (SELECT TOP 1 id FROM robottemplates WHERE name=@botTemplateName)
BEGIN
	UPDATE robottemplates SET
	description = '#robot=i'+@botDefHex+'#head=i'+@headDefHex+'#chassis=i'+@chassisDefHex+'#leg=i'+@legDefHex+'#container=i1148#headModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]|m2=[|definition=i0|slot=i3]|m3=[|definition=i0|slot=i4]]#chassisModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]|m2=[|definition=i0|slot=i3]|m3=[|definition=i0|slot=i4]|m4=[|definition=i0|slot=i5]|m5=[|definition=i0|slot=i6]]#legModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]|m2=[|definition=i0|slot=i3]|m3=[|definition=i0|slot=i4]]'
	WHERE name=@botTemplateName;
END
ELSE
BEGIN
	INSERT INTO robottemplates ([name], [description], [note]) VALUES 
	(@botTemplateName,
	'#robot=i'+@botDefHex+'#head=i'+@headDefHex+'#chassis=i'+@chassisDefHex+'#leg=i'+@legDefHex+'#container=i1148#headModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]|m2=[|definition=i0|slot=i3]|m3=[|definition=i0|slot=i4]]#chassisModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]|m2=[|definition=i0|slot=i3]|m3=[|definition=i0|slot=i4]|m4=[|definition=i0|slot=i5]|m5=[|definition=i0|slot=i6]]#legModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]|m2=[|definition=i0|slot=i3]|m3=[|definition=i0|slot=i4]]',
	'new large robot template - empty');
END

PRINT N'DEFINE ROBOTTEMPLATERELATION';
IF EXISTS (SELECT TOP 1 definition FROM [robottemplaterelation] WHERE definition=@botDef)
BEGIN
	UPDATE [robottemplaterelation] SET
		templateid = (SELECT TOP 1 id FROM robottemplates WHERE name=@botTemplateName),
		itemscoresum = 0,
		raceid = 1,
		missionlevel = NULL,
		missionleveloverride = NULL,
		killep = 0
	WHERE definition=@botDef;
END
ELSE
BEGIN
	INSERT INTO [dbo].[robottemplaterelation]([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
	VALUES
	(@botDef,(SELECT TOP 1 id FROM robottemplates WHERE name=@botTemplateName),0,1,NULL,NULL,0,'new large bot relation - empty');
END

PRINT N'DEFINE ROBOTTEMPLATERELATION FOR PROTO';
IF EXISTS (SELECT TOP 1 definition FROM [robottemplaterelation] WHERE definition=@PRbotDef)
BEGIN
	UPDATE [robottemplaterelation] SET
		templateid = (SELECT TOP 1 id FROM robottemplates WHERE name=@botTemplateName),
		itemscoresum = 0,
		raceid = 1,
		missionlevel = NULL,
		missionleveloverride = NULL,
		killep = 0
	WHERE definition=@PRbotDef;
END
ELSE
BEGIN
	INSERT INTO [dbo].[robottemplaterelation]([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
	VALUES
	(@PRbotDef,(SELECT TOP 1 id FROM robottemplates WHERE name=@botTemplateName),0,1,NULL,NULL,0,'new large bot relation - empty');
END

--BOT STATS

DROP TABLE IF EXISTS #BOTSTATS
CREATE TABLE #BOTSTATS 
(
	partDef int,
	name varchar(100),
	value float,
)

INSERT INTO #BOTSTATS (partDef, name, value) VALUES
(@headDef, 'cpu_max', 2010),
(@headDef, 'locked_targets_max', 2),
(@headDef, 'locking_range', 37),
(@headDef, 'locking_time', 15000),
(@headDef, 'sensor_strength', 95),
(@headDef, 'blob_emission', 25),
(@headDef, 'blob_emission_radius', 35),
(@headDef, 'blob_level_low', 75),
(@headDef, 'blob_level_high', 400),
(@headDef, 'detection_strength', 55),
(@headDef, 'stealth_strength', 55),
(@chassisDef, 'ammo_reload_time', 15000),
(@chassisDef, 'armor_max', 7000),
(@chassisDef, 'core_max', 5800),
(@chassisDef, 'core_recharge_time', 1200),
(@chassisDef, 'powergrid_max', 4920),
(@chassisDef, 'resist_chemical', 30),
(@chassisDef, 'resist_explosive', 45),
(@chassisDef, 'resist_kinetic', 10),
(@chassisDef, 'resist_thermal', 150),
(@chassisDef, 'signature_radius', 30),
(@chassisDef, 'missile_miss', 0.9),
(@chassisDef, 'reactor_radiation', 15),
(@legDef, 'slope', 4),
(@legDef, 'speed_max', 1.38889);

PRINT N'DELETE BOT STATS';
DELETE FROM aggregatevalues WHERE definition in (SELECT DISTINCT partDef FROM #BOTSTATS);

PRINT N'INSERT BOT STATS';
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value])
SELECT 
	#BOTSTATS.partDef, 
	(SELECT TOP 1 id FROM aggregatefields WHERE #BOTSTATS.name=aggregatefields.name),
	#BOTSTATS.value 
FROM #BOTSTATS


DECLARE @extensionName varchar(100);
DECLARE @extensionID int;

SET @extensionName = 'ext_assault_unit_piloting';
SET @extensionID = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname=@extensionName);

DECLARE @factionPilotExt int;
SET @factionPilotExt = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname='ext_pelistal_specialist');

DECLARE @combatSpecExt int;
SET @combatSpecExt = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname='ext_combat_specialist');


PRINT N'UNHIDE ANY NEW EXTENSIONS USED FOR BOT BONUSES';
UPDATE extensions SET active=1, hidden=0 WHERE extensionid=@extensionID;

DROP TABLE IF EXISTS #BOTBONUSES
CREATE TABLE #BOTBONUSES 
(
	partDef int,
	extID int,
	name varchar(100),
	bonus float,
)
INSERT INTO #BOTBONUSES (partDef, extID, name, bonus) VALUES
(@chassisDef, @extensionID, 'cpu_usage_large_missile_modifier', 0.03),
(@chassisDef, @extensionID, 'powergrid_usage_large_missile_modifier', 0.03),
(@chassisDef, @extensionID, 'damage_large_missile_modifier', 0.05),
(@chassisDef, @combatSpecExt, 'missile_cycle_time_modifier', 0.02),
(@chassisDef, @combatSpecExt, 'locking_time_modifier', 0.03),
(@chassisDef, @factionPilotExt, 'shield_absorbtion_modifier', 0.05);


PRINT N'DELETE BOT BONUSES';
DELETE FROM chassisbonus WHERE definition in (SELECT DISTINCT partDef FROM #BOTBONUSES);

PRINT N'INSERT BOT BONUSES';
INSERT INTO chassisbonus (definition, extension, bonus, note, targetpropertyID, effectenhancer)
SELECT b.partDef, b.extID, b.bonus, 'Large bot bonus', (SELECT TOP 1 id FROM aggregatefields WHERE name=b.name), 0 FROM #BOTBONUSES AS b;

--DELETE and REINSERT
PRINT N'DELETE BOT REQ-EXTENSIONS';
DELETE FROM enablerextensions WHERE definition=@botDef;
PRINT N'INSERT BOT REQ-EXTENSIONS';
INSERT INTO [dbo].[enablerextensions] ([definition],[extensionid],[extensionlevel]) VALUES
(@botDef, @extensionID, 4),
(@botDef, (SELECT TOP 1 extensionid FROM extensions WHERE extensionname='ext_high_tech_specialist'), 8),
(@botDef, @factionPilotExt, 10);

PRINT N'DELETE PROTO-BOT REQ-EXTENSIONS';
DELETE FROM enablerextensions WHERE definition=@PRbotDef;
PRINT N'INSERT PROTO-BOT REQ-EXTENSIONS';
INSERT INTO [dbo].[enablerextensions] ([definition],[extensionid],[extensionlevel]) VALUES
(@PRbotDef, @extensionID, 4),
(@PRbotDef, (SELECT TOP 1 extensionid FROM extensions WHERE extensionname='ext_high_tech_specialist'), 8),
(@PRbotDef, @factionPilotExt, 10);


PRINT N'DEFINE colors';
IF EXISTS (SELECT TOP 1 definition FROM [definitionconfig] WHERE definition=@botDef)
BEGIN
	UPDATE [definitionconfig] SET
		tint=@tintColor
	WHERE definition in (@headDef, @chassisDef, @legDef, @botDef, @PRbotDef);
END
ELSE
BEGIN
	INSERT INTO [dbo].[definitionconfig]
		([definition],[tint],[note])
	VALUES
		(@headDef, @tintColor,'Large bot native color'),
		(@chassisDef, @tintColor,'Large bot native color'),
		(@legDef, @tintColor,'Large bot native color'),
		(@botDef, @tintColor,'Large bot native color'),
		(@PRbotDef, @tintColor,'Large bot native color');
END


DROP TABLE IF EXISTS #BOTSTATS;
DROP TABLE IF EXISTS #BOTBONUSES;
SET NOEXEC OFF;
PRINT N'LARGE PELISTAL BOT INSERT';
GO


PRINT N'11_BOT_thelodica_large';

USE [perpetuumsa]
GO
--------------------------------------------------------------
--Big Bot makin script
--1 - Create robotcomponents
--2 - Create bot definition (with parts - creates associations for bonuses)
--3 - Add stats (aggvalues)
--4 - Add bonuses
--5 - Add required skills to pilot
--6 - Add RobotTemplate (empty) for robot parts - creates associations for stats and rendering definitions TODO
--7 - Create RobotTemplateRelation to relate bot def to template TODO
--------------------------------------------------------------

DECLARE @largeBotCF bigint;
SET @largeBotCF = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_walkers');
UPDATE categoryFlags SET
	hidden=0
WHERE value=@largeBotCF;

--MAKE PARTS OF ROBOT, THEN ROBOT DEFINITION
DECLARE @botName varchar(100);
DECLARE @botDef int;
DECLARE @botDefHex VARCHAR(50);
DECLARE @headName varchar(100);
DECLARE @headDef int;
DECLARE @headDefHex VARCHAR(50);
DECLARE @chassisName varchar(100);
DECLARE @chassisDef int;
DECLARE @chassisDefHex VARCHAR(50);
DECLARE @legName varchar(100);
DECLARE @legDef int;
DECLARE @legDefHex VARCHAR(50);
DECLARE @tintColor VARCHAR(50);

DECLARE @PRbotName varchar(100);
DECLARE @PRbotDef int;

SET @headName = 'def_onyx_bot_head';
SET @headDef = 6010;
SET @chassisName = 'def_onyx_bot_chassis';
SET @chassisDef = 6011;
SET @legName = 'def_onyx_bot_leg';
SET @legDef = 6012;
SET @botName = 'def_onyx_bot';
SET @botDef = 6013;
SET @tintColor ='#672200';

SET @PRbotName = 'def_onyx_bot_pr';
SET @PRbotDef = 6014;

DECLARE @headMass int;
DECLARE @chassisMass int;
DECLARE @legMass int;
SET @headMass = 3000;
SET @chassisMass = 60000;
SET @legMass = 12000;


PRINT N'INTEGRITY CHECK: ALL NAMED ENTITYDEFAULTS WITH SPECIFIED IDs MUST BE INSERTED WITH THE SPECIFIED ID';
IF EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE @botDef=definition AND @botName!=definitionname)
OR EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE @headDef=definition AND @headName!=definitionname)
OR EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE @chassisDef=definition AND @chassisName!=definitionname)
OR EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE @legDef=definition AND @legName!=definitionname)
OR EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE @PRbotDef=definition AND @PRbotName!=definitionname)
BEGIN
	PRINT N'DEFINITION INTEGRITY CHECK FAILED! SKIPPING ALL EXECUTION IN THIS SCRIPT';
	SET NOEXEC ON;
END


PRINT N'DEFINE HEAD';
IF EXISTS (SELECT TOP 1 definition from dbo.entitydefaults WHERE definitionname=@headName)
BEGIN
	UPDATE entitydefaults SET
		categoryflags = 328016,
		options = '#height=f0.2#slotFlags=48,8,8,8',
		volume = 3,
		mass = @headMass
	WHERE definitionname=@headName;
END
ELSE
BEGIN
	SET IDENTITY_INSERT entitydefaults ON;
	INSERT INTO entitydefaults (definition, definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
	VALUES 
	(@headDef, @headName, 1, 1024, 328016, '#height=f0.2#slotFlags=48,8,8,8', '', 1, 3, @headMass, 1, 100, 'bot_head_desc', 0, 0, 0); 
	SET IDENTITY_INSERT entitydefaults OFF;
END

PRINT N'DEFINE CHASSIS';

IF EXISTS (SELECT TOP 1 definition from dbo.entitydefaults WHERE definitionname=@chassisName)
BEGIN
	UPDATE entitydefaults SET
		categoryflags = 328272,
		options = '#height=f2#slotFlags=4111,111,111,111,111,111',
		volume = 20,
		mass = @chassisMass
	WHERE definitionname=@chassisName;
END
ELSE
BEGIN
	SET IDENTITY_INSERT entitydefaults ON;
	INSERT INTO entitydefaults (definition, definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
	VALUES 
	(@chassisDef, @chassisName, 1, 1024, 328272, '#height=f2#slotFlags=4111,111,111,111,111,111', '', 1, 20, @chassisMass, 1, 100, 'bot_chassis_desc', 0, 0, 0); 
	SET IDENTITY_INSERT entitydefaults OFF;
END

PRINT N'DEFINE LEGS';

IF EXISTS (SELECT TOP 1 definition from dbo.entitydefaults WHERE definitionname=@legName)
BEGIN
	UPDATE entitydefaults SET
		categoryflags = 328528,
		options = '#height=f1.1#slotFlags=420,20,20,20,20',
		volume = 20,
		mass = @legMass
	WHERE definitionname=@legName;
END
ELSE
BEGIN
	SET IDENTITY_INSERT entitydefaults ON;
	INSERT INTO entitydefaults (definition, definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
	VALUES 
	(@legDef, @legName, 1, 1024, 328528, '#height=f1.1#slotFlags=420,20,20,20,20', '', 1, 20, @legMass, 1, 100, 'bot_leg_desc', 0, 0, 0); 
	SET IDENTITY_INSERT entitydefaults OFF;
END


SET @headDef = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@headName);
SET @headDefHex = (SELECT dbo.ToHex(@headDef));
SET @chassisDef = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@chassisName);
SET @chassisDefHex = (SELECT dbo.ToHex(@chassisDef));
SET @legDef = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@legName);
SET @legDefHex = (SELECT dbo.ToHex(@legDef));

PRINT N'DEFINE BOT';

--BOT DEFINITION
IF EXISTS (SELECT TOP 1 definition from dbo.entitydefaults WHERE definitionname=@botName)
BEGIN
	UPDATE entitydefaults SET
		attributeflags=0,
		categoryflags = @largeBotCF,
		options = '#head=i'+@headDefHex+'#chassis=i'+@chassisDefHex+'#leg=i'+@legDefHex+'#container=i14c',
		volume = 22.5,
		mass = 0,
		descriptiontoken = @botName+'_desc'
	WHERE definitionname=@botName;
END
ELSE
BEGIN
	SET IDENTITY_INSERT entitydefaults ON;
	INSERT INTO entitydefaults (definition, definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
	VALUES 
	(@botDef, @botName, 1, 0, @largeBotCF, '#head=i'+@headDefHex+'#chassis=i'+@chassisDefHex+'#leg=i'+@legDefHex+'#container=i14c', '', 1, 22.5, 0, 0, 100, @botName+'_desc', 1, 0, 0);
	SET IDENTITY_INSERT entitydefaults OFF;
END

--PROTOYPE BOT DEFINITION
IF EXISTS (SELECT TOP 1 definition from dbo.entitydefaults WHERE definitionname=@PRbotName)
BEGIN
	UPDATE entitydefaults SET
		attributeflags=0,
		categoryflags = @largeBotCF,
		options = '#head=i'+@headDefHex+'#chassis=i'+@chassisDefHex+'#leg=i'+@legDefHex+'#container=i14c #tier=$tierlevel_pr',
		volume = 22.5,
		mass = 0,
		descriptiontoken = @PRbotName+'_desc',
		tiertype=2
	WHERE definitionname=@PRbotName;
END
ELSE
BEGIN
	SET IDENTITY_INSERT entitydefaults ON;
	INSERT INTO entitydefaults (definition, definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
	VALUES 
	(@PRbotDef, @PRbotName, 1, 0, @largeBotCF, '#head=i'+@headDefHex+'#chassis=i'+@chassisDefHex+'#leg=i'+@legDefHex+'#container=i14c #tier=$tierlevel_pr', '', 1, 22.5, 0, 0, 100, @PRbotName+'_desc', 1, 2, 0);
	SET IDENTITY_INSERT entitydefaults OFF;
END

SET @botDef = (SELECT TOP 1 definition from dbo.entitydefaults WHERE definitionname=@botName);
SET @botDefHex = (SELECT dbo.ToHex(@botDef));


PRINT N'DEFINE ROBOTTEMPLATE';
DECLARE @botTemplateName VARCHAR(100);
SET @botTemplateName = @botName+'_template';

IF EXISTS (SELECT TOP 1 id FROM robottemplates WHERE name=@botTemplateName)
BEGIN
	UPDATE robottemplates SET
	description = '#robot=i'+@botDefHex+'#head=i'+@headDefHex+'#chassis=i'+@chassisDefHex+'#leg=i'+@legDefHex+'#container=i1148#headModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]|m2=[|definition=i0|slot=i3]|m3=[|definition=i0|slot=i4]]#chassisModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]|m2=[|definition=i0|slot=i3]|m3=[|definition=i0|slot=i4]|m4=[|definition=i0|slot=i5]|m5=[|definition=i0|slot=i6]]#legModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]|m2=[|definition=i0|slot=i3]|m3=[|definition=i0|slot=i4]]'
	WHERE name=@botTemplateName;
END
ELSE
BEGIN
	INSERT INTO robottemplates ([name], [description], [note]) VALUES 
	(@botTemplateName,
	'#robot=i'+@botDefHex+'#head=i'+@headDefHex+'#chassis=i'+@chassisDefHex+'#leg=i'+@legDefHex+'#container=i1148#headModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]|m2=[|definition=i0|slot=i3]|m3=[|definition=i0|slot=i4]]#chassisModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]|m2=[|definition=i0|slot=i3]|m3=[|definition=i0|slot=i4]|m4=[|definition=i0|slot=i5]|m5=[|definition=i0|slot=i6]]#legModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]|m2=[|definition=i0|slot=i3]|m3=[|definition=i0|slot=i4]]',
	'new large robot template - empty');
END

PRINT N'DEFINE ROBOTTEMPLATERELATION';
IF EXISTS (SELECT TOP 1 definition FROM [robottemplaterelation] WHERE definition=@botDef)
BEGIN
	UPDATE [robottemplaterelation] SET
		templateid = (SELECT TOP 1 id FROM robottemplates WHERE name=@botTemplateName),
		itemscoresum = 0,
		raceid = 1,
		missionlevel = NULL,
		missionleveloverride = NULL,
		killep = 0
	WHERE definition=@botDef;
END
ELSE
BEGIN
	INSERT INTO [dbo].[robottemplaterelation]([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
	VALUES
	(@botDef,(SELECT TOP 1 id FROM robottemplates WHERE name=@botTemplateName),0,1,NULL,NULL,0,'new large bot relation - empty');
END

PRINT N'DEFINE ROBOTTEMPLATERELATION FOR PROTO';
IF EXISTS (SELECT TOP 1 definition FROM [robottemplaterelation] WHERE definition=@PRbotDef)
BEGIN
	UPDATE [robottemplaterelation] SET
		templateid = (SELECT TOP 1 id FROM robottemplates WHERE name=@botTemplateName),
		itemscoresum = 0,
		raceid = 1,
		missionlevel = NULL,
		missionleveloverride = NULL,
		killep = 0
	WHERE definition=@PRbotDef;
END
ELSE
BEGIN
	INSERT INTO [dbo].[robottemplaterelation]([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
	VALUES
	(@PRbotDef,(SELECT TOP 1 id FROM robottemplates WHERE name=@botTemplateName),0,1,NULL,NULL,0,'new large bot relation - empty');
END

--BOT STATS

DROP TABLE IF EXISTS #BOTSTATS
CREATE TABLE #BOTSTATS 
(
	partDef int,
	name varchar(100),
	value float,
)

INSERT INTO #BOTSTATS (partDef, name, value) VALUES
(@headDef, 'cpu_max', 1512),
(@headDef, 'locked_targets_max', 2),
(@headDef, 'locking_range', 40),
(@headDef, 'locking_time', 15000),
(@headDef, 'sensor_strength', 95),
(@headDef, 'blob_emission', 25),
(@headDef, 'blob_emission_radius', 35),
(@headDef, 'blob_level_low', 75),
(@headDef, 'blob_level_high', 400),
(@headDef, 'detection_strength', 55),
(@headDef, 'stealth_strength', 55),
(@chassisDef, 'ammo_reload_time', 15000),
(@chassisDef, 'armor_max', 7000),
(@chassisDef, 'core_max', 6000),
(@chassisDef, 'core_recharge_time', 1200),
(@chassisDef, 'powergrid_max', 6600),
(@chassisDef, 'resist_chemical', 30),
(@chassisDef, 'resist_explosive', 10),
(@chassisDef, 'resist_kinetic', 150),
(@chassisDef, 'resist_thermal', 45),
(@chassisDef, 'signature_radius', 30),
(@chassisDef, 'missile_miss', 0.9),
(@chassisDef, 'reactor_radiation', 15),
(@legDef, 'slope', 4),
(@legDef, 'speed_max', 1.38889);

PRINT N'DELETE BOT STATS';
DELETE FROM aggregatevalues WHERE definition in (SELECT DISTINCT partDef FROM #BOTSTATS);

PRINT N'INSERT BOT STATS';
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value])
SELECT 
	#BOTSTATS.partDef, 
	(SELECT TOP 1 id FROM aggregatefields WHERE #BOTSTATS.name=aggregatefields.name),
	#BOTSTATS.value 
FROM #BOTSTATS


DECLARE @extensionName varchar(100);
DECLARE @extensionID int;

SET @extensionName = 'ext_assault_unit_piloting';
SET @extensionID = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname=@extensionName);

DECLARE @factionPilotExt int;
SET @factionPilotExt = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname='ext_thelodica_specialist');

DECLARE @combatSpecExt int;
SET @combatSpecExt = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname='ext_combat_specialist');

PRINT N'UNHIDE ANY NEW EXTENSIONS USED FOR BOT BONUSES';
UPDATE extensions SET active=1, hidden=0 WHERE extensionid=@extensionID;

DROP TABLE IF EXISTS #BOTBONUSES;
CREATE TABLE #BOTBONUSES 
(
	partDef int,
	extID int,
	name varchar(100),
	bonus float,
);
INSERT INTO #BOTBONUSES (partDef, extID, name, bonus) VALUES
(@chassisDef, @extensionID, 'cpu_usage_large_laser_modifier', 0.03),
(@chassisDef, @extensionID, 'powergrid_usage_large_laser_modifier', 0.03),
(@chassisDef, @extensionID, 'damage_large_laser_modifier', 0.05),
(@chassisDef, @combatSpecExt, 'core_usage_laser_modifier', -0.02),
(@chassisDef, @combatSpecExt, 'laser_optimal_range_modifier', 0.02),
(@chassisDef, @factionPilotExt, 'resist_chemical', 5),
(@chassisDef, @factionPilotExt, 'resist_explosive', 5),
(@chassisDef, @factionPilotExt, 'resist_kinetic', 5),
(@chassisDef, @factionPilotExt, 'resist_thermal', 5);

PRINT N'DELETE BOT BONUSES';
DELETE FROM chassisbonus WHERE definition in (SELECT DISTINCT partDef FROM #BOTBONUSES);

PRINT N'INSERT BOT BONUSES';
INSERT INTO chassisbonus (definition, extension, bonus, note, targetpropertyID, effectenhancer)
SELECT b.partDef, b.extID, b.bonus, 'Large bot bonus', (SELECT TOP 1 id FROM aggregatefields WHERE name=b.name), 0 FROM #BOTBONUSES AS b;

--DELETE and REINSERT
PRINT N'DELETE BOT REQ-EXTENSIONS';
DELETE FROM enablerextensions WHERE definition=@botDef;
PRINT N'INSERT BOT REQ-EXTENSIONS';
INSERT INTO [dbo].[enablerextensions] ([definition],[extensionid],[extensionlevel]) VALUES
(@botDef, @extensionID, 4),
(@botDef, (SELECT TOP 1 extensionid FROM extensions WHERE extensionname='ext_high_tech_specialist'), 8),
(@botDef, @factionPilotExt, 10);

PRINT N'DELETE PROTO-BOT REQ-EXTENSIONS';
DELETE FROM enablerextensions WHERE definition=@PRbotDef;
PRINT N'INSERT PROTO-BOT REQ-EXTENSIONS';
INSERT INTO [dbo].[enablerextensions] ([definition],[extensionid],[extensionlevel]) VALUES
(@PRbotDef, @extensionID, 4),
(@PRbotDef, (SELECT TOP 1 extensionid FROM extensions WHERE extensionname='ext_high_tech_specialist'), 8),
(@PRbotDef, @factionPilotExt, 10);


PRINT N'DEFINE colors';
IF EXISTS (SELECT TOP 1 definition FROM [definitionconfig] WHERE definition=@botDef)
BEGIN
	UPDATE [definitionconfig] SET
		tint=@tintColor
	WHERE definition in (@headDef, @chassisDef, @legDef, @botDef, @PRbotDef);
END
ELSE
BEGIN
	INSERT INTO [dbo].[definitionconfig]
		([definition],[tint],[note])
	VALUES
		(@headDef, @tintColor,'Large bot native color'),
		(@chassisDef, @tintColor,'Large bot native color'),
		(@legDef, @tintColor,'Large bot native color'),
		(@botDef, @tintColor,'Large bot native color'),
		(@PRbotDef, @tintColor,'Large bot native color');
END


DROP TABLE IF EXISTS #BOTSTATS;
DROP TABLE IF EXISTS #BOTBONUSES;
SET NOEXEC OFF;
PRINT N'LARGE THELODICA BOT INSERT';
GO


PRINT N'12_BOT_PRODUCTION_all_large';

USE [perpetuumsa]
GO


--MUST BE RUN AFTER ALL BOTS INSERTED


PRINT N'DESTRO BOT proto-pairs';
DROP TABLE IF EXISTS #PROTOPAIRS;
CREATE TABLE #PROTOPAIRS
(
	defName varchar(100),
	protoDefName varchar(100),
);

INSERT INTO #PROTOPAIRS (defName, protoDefName) VALUES
('def_felos_bot','def_felos_bot_pr'),
('def_hydra_bot','def_hydra_bot_pr'),
('def_onyx_bot','def_onyx_bot_pr');


--DELETE and reinsert
PRINT N'DELETE prototypes FOR ANY EXISTING DESTROYER prototype pairs (0 results if first run)';
SELECT * FROM prototypes WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT defName FROM #PROTOPAIRS));
DELETE FROM prototypes WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT defName FROM #PROTOPAIRS));

--INSERT
PRINT N'INSERT prototypes FOR LARGE MOD-PROTO PAIRS';
INSERT INTO prototypes (definition, prototype)
SELECT (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = defName), 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = protoDefName)
FROM #PROTOPAIRS;

DROP TABLE IF EXISTS #PROTOPAIRS;
GO


PRINT N'PRODUCTION DURATION AND DECALIBRATION - DESTROYERS';
DECLARE @destroBotCategory BIGINT;
SET @destroBotCategory = (SELECT TOP 1 VALUE FROM categoryFlags WHERE NAME='cf_walkers');

IF EXISTS (SELECT TOP 1 categoryflag from productiondecalibration where categoryflag=@destroBotCategory)
BEGIN
	UPDATE productiondecalibration SET
		distorsionmax = 0.01,
		distorsionmin = 0.003,
		decrease = 5
	WHERE categoryflag=@destroBotCategory;
END
ELSE
BEGIN
	INSERT INTO productiondecalibration (categoryflag, distorsionmin, distorsionmax, decrease) VALUES
	(@destroBotCategory, 0.003, 0.01, 5);
END

IF EXISTS (SELECT TOP 1 category from productionduration where category=@destroBotCategory)
BEGIN
	UPDATE productionduration SET
		durationmodifier=15
	WHERE category=@destroBotCategory;
END
ELSE
BEGIN
	INSERT INTO productionduration (category, durationmodifier) VALUES
	(@destroBotCategory, 15);
END
GO


PRINT N'DESTRO BOT PRODUCTION';

DROP TABLE IF EXISTS #BOT_COMPS;
CREATE TABLE #BOT_COMPS
(
	defName VARCHAR(100),
	commodityName VARCHAR(100),
	amount INT
);

INSERT INTO #BOT_COMPS (defName, commodityName, amount) VALUES
('def_felos_bot', 'def_statichnol', 20000),
('def_felos_bot', 'def_chollonin', 2000),
('def_felos_bot', 'def_polynitrocol', 14000),
('def_felos_bot', 'def_unimetal', 9000),
('def_felos_bot', 'def_alligior', 9000),
('def_felos_bot', 'def_espitium', 9000),
('def_felos_bot', 'def_specimen_sap_item_flux', 2400),
('def_felos_bot', 'def_robotshard_common_advanced', 40),
('def_felos_bot', 'def_robotshard_common_expert', 30),
('def_felos_bot', 'def_robotshard_nuimqol_advanced', 40),
('def_felos_bot', 'def_robotshard_nuimqol_expert', 30),
--
('def_felos_bot_pr', 'def_statichnol', 20000),
('def_felos_bot_pr', 'def_chollonin', 2000),
('def_felos_bot_pr', 'def_polynitrocol', 14000),
('def_felos_bot_pr', 'def_unimetal', 9000),
('def_felos_bot_pr', 'def_alligior', 9000),
('def_felos_bot_pr', 'def_espitium', 9000),
('def_felos_bot_pr', 'def_specimen_sap_item_flux', 2400),
('def_felos_bot_pr', 'def_robotshard_common_advanced', 40),
('def_felos_bot_pr', 'def_robotshard_common_expert', 30),
('def_felos_bot_pr', 'def_robotshard_nuimqol_advanced', 40),
('def_felos_bot_pr', 'def_robotshard_nuimqol_expert', 30),
--
('def_hydra_bot', 'def_isopropentol', 20000),
('def_hydra_bot', 'def_vitricyl', 2000),
('def_hydra_bot', 'def_phlobotil', 14000),
('def_hydra_bot', 'def_unimetal', 9000),
('def_hydra_bot', 'def_alligior', 9000),
('def_hydra_bot', 'def_espitium', 9000),
('def_hydra_bot', 'def_specimen_sap_item_flux', 2400),
('def_hydra_bot', 'def_robotshard_common_advanced', 40),
('def_hydra_bot', 'def_robotshard_common_expert', 30),
('def_hydra_bot', 'def_robotshard_pelistal_advanced', 40),
('def_hydra_bot', 'def_robotshard_pelistal_expert', 30),
--
('def_hydra_bot_pr', 'def_isopropentol', 20000),
('def_hydra_bot_pr', 'def_vitricyl', 2000),
('def_hydra_bot_pr', 'def_phlobotil', 14000),
('def_hydra_bot_pr', 'def_unimetal', 9000),
('def_hydra_bot_pr', 'def_alligior', 9000),
('def_hydra_bot_pr', 'def_espitium', 9000),
('def_hydra_bot_pr', 'def_specimen_sap_item_flux', 2400),
('def_hydra_bot_pr', 'def_robotshard_common_advanced', 40),
('def_hydra_bot_pr', 'def_robotshard_common_expert', 30),
('def_hydra_bot_pr', 'def_robotshard_pelistal_advanced', 40),
('def_hydra_bot_pr', 'def_robotshard_pelistal_expert', 30),
--
('def_onyx_bot', 'def_metachropin', 20000),
('def_onyx_bot', 'def_prilumium', 2000),
('def_onyx_bot', 'def_polynucleit', 14000),
('def_onyx_bot', 'def_unimetal', 9000),
('def_onyx_bot', 'def_alligior', 9000),
('def_onyx_bot', 'def_espitium', 9000),
('def_onyx_bot', 'def_specimen_sap_item_flux', 2400),
('def_onyx_bot', 'def_robotshard_common_advanced', 40),
('def_onyx_bot', 'def_robotshard_common_expert', 30),
('def_onyx_bot', 'def_robotshard_thelodica_advanced', 40),
('def_onyx_bot', 'def_robotshard_thelodica_expert', 30),
--
('def_onyx_bot_pr', 'def_metachropin', 20000),
('def_onyx_bot_pr', 'def_prilumium', 2000),
('def_onyx_bot_pr', 'def_polynucleit', 14000),
('def_onyx_bot_pr', 'def_unimetal', 9000),
('def_onyx_bot_pr', 'def_alligior', 9000),
('def_onyx_bot_pr', 'def_espitium', 9000),
('def_onyx_bot_pr', 'def_specimen_sap_item_flux', 2400),
('def_onyx_bot_pr', 'def_robotshard_common_advanced', 40),
('def_onyx_bot_pr', 'def_robotshard_common_expert', 30),
('def_onyx_bot_pr', 'def_robotshard_thelodica_advanced', 40),
('def_onyx_bot_pr', 'def_robotshard_thelodica_expert', 30);


PRINT N'DELETE components FOR ANY EXISTING DESTROYER COMPONENTRY (0 results if 1st run)';
SELECT * FROM components WHERE definition IN (SELECT definition FROM entitydefaults WHERE definitionname IN (SELECT DISTINCT defName FROM #BOT_COMPS));
DELETE FROM components WHERE definition IN (SELECT definition FROM entitydefaults WHERE definitionname IN (SELECT DISTINCT defName FROM #BOT_COMPS));

PRINT N'INSERT components FOR DESTROYERS';
INSERT INTO components (definition, componentdefinition, componentamount)
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defName),
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=commodityName),
	amount
FROM #BOT_COMPS;


DROP TABLE IF EXISTS #BOT_COMPS;
GO



PRINT N'CALIBRATION TEMPLATES FOR MODULES';

DECLARE @botCTCategory BIGINT;

SET @botCTCategory = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_walker_calibration_programs');


DROP TABLE IF EXISTS #BOTCTS;
CREATE TABLE #BOTCTS 
(
	defName varchar(100),
	catFlags bigint,
	attrFlags bigint,
	cargoVolume float,
	massOfModule float,
	techType int,
	techLevel int,
	genxyOptStr varchar(max),
);

INSERT INTO #BOTCTS (defName, attrFlags, catFlags, cargoVolume, massOfModule, techType, techLevel, genxyOptStr) VALUES
('def_felos_bot_cprg', 1024, @botCTCategory, 0.01, 0.1, NULL, NULL, NULL),
('def_hydra_bot_cprg', 1024, @botCTCategory, 0.01, 0.1, NULL, NULL, NULL),
('def_onyx_bot_cprg', 1024, @botCTCategory, 0.01, 0.1, NULL, NULL, NULL);


PRINT N'UPDATE/INSERT CTS';
--Update/insert [entitydefaults] entries
MERGE [dbo].[entitydefaults] def USING #BOTCTS ct
ON def.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=ct.defName)
WHEN MATCHED
    THEN UPDATE SET
		categoryflags=catFlags,
		attributeflags=attrFlags,
		volume=cargoVolume,
		mass=massOfModule,
		tiertype=techType,
		tierlevel=techLevel,
		options=genxyOptStr,
		enabled=1,
		hidden=0,
		purchasable=0,
		descriptiontoken='calibration_program_desc'
WHEN NOT MATCHED
    THEN INSERT (definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel) VALUES
	(defName, 1, attrFlags,catFlags,genxyOptStr,'CT FOR DESTROYER',1,cargoVolume,massOfModule,0,100,'calibration_program_desc',0,techType,techLevel);

PRINT N'DELETE calibrationdefaults FOR ANY EXISTING LARGE MOD CTS (0 results if 1st run)';
SELECT * FROM calibrationdefaults WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #BOTCTS));
DELETE FROM calibrationdefaults WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #BOTCTS));

PRINT N'INSERT calibrationdefaults FOR MOD CTS';
INSERT INTO calibrationdefaults (definition, materialefficiency, timeefficiency)
SELECT (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = defName), 50, 50 FROM #BOTCTS;

DROP TABLE IF EXISTS #PROTO_TO_CT;
CREATE TABLE #PROTO_TO_CT
(
	protoDefName VARCHAR(100),
	ctDefName VARCHAR(100),
	level INT
);

INSERT INTO #PROTO_TO_CT (protoDefName, ctDefName, level) VALUES
('def_felos_bot_pr','def_felos_bot_cprg', 7),
('def_hydra_bot_pr','def_hydra_bot_cprg', 7),
('def_onyx_bot_pr','def_onyx_bot_cprg', 7);


PRINT N'DELETE itemresearchlevels FOR ANY EXISTING DESTRO BOT CTS (0 results if 1st run)';
SELECT * FROM itemresearchlevels WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT protoDefName FROM #PROTO_TO_CT));
DELETE FROM itemresearchlevels WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT protoDefName FROM #PROTO_TO_CT));

PRINT N'INSERT itemresearchlevels FOR DESTRO BOT CTS';
INSERT INTO itemresearchlevels (definition, calibrationprogram, researchlevel, enabled)
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = protoDefName), 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = ctDefName), 
	level, 1
FROM #PROTO_TO_CT;


DROP TABLE IF EXISTS #BOTCTS;
DROP TABLE IF EXISTS #PROTO_TO_CT;
GO

PRINT N'13_TECH_common2_tree';

USE [perpetuumsa]
GO

----------------------------------------------
--COMMON2 research tree changes
--Full map of positions w/ new items
--Costs of new items
----------------------------------------------

DECLARE @techGroupId INT;
SET @techGroupId = (SELECT TOP 1 id FROM techtreegroups WHERE name='common2');

--Show what the tree for this tech group has, ordered in top-left to bottom-right
--select 
--	(select top 1 definitionname from entitydefaults where definition in (parentdefinition)),
--	(select top 1 definitionname from entitydefaults where definition in (childdefinition)),
--	x, y
--from techtree where groupID=@techGroupId order by y, x;

PRINT N'COMMON2 RESEARCH TREE';
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
	@techGroupId, s.x, s.y);

DROP TABLE IF EXISTS #TECHSLOTSCOMMON;
DROP TABLE IF EXISTS #TECHCOSTPELISTAL;
GO



PRINT N'14_TECH_nuimqol_tree';

USE [perpetuumsa]
GO

----------------------------------------------
--NUIMQOL research tree changes
--Full map of positions w/ new items
--Costs of new items
----------------------------------------------

DECLARE @techGroupId INT;
SET @techGroupId = (SELECT TOP 1 id FROM techtreegroups WHERE name='nuimqol');

--Show what the tree for this tech group has, ordered in top-left to bottom-right
--select 
--	(select top 1 definitionname from entitydefaults where definition in (parentdefinition)),
--	(select top 1 definitionname from entitydefaults where definition in (childdefinition)),
--	x, y
--from techtree where groupID=@techGroupId order by y, x;

PRINT N'NUIMQOL RESEARCH TREE';
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
	@techGroupId, s.x, s.y);



DROP TABLE IF EXISTS #TECHSLOTSNUIMQOL;
DROP TABLE IF EXISTS #TECHCOSTNUIMQOL;
GO




PRINT N'15_TECH_pelistal_tree';

USE [perpetuumsa]
GO

----------------------------------------------
--PELISTAL research tree changes
--Full map of positions w/ new items
--Costs of new items
----------------------------------------------

DECLARE @techGroupId INT;
SET @techGroupId = (SELECT TOP 1 id FROM techtreegroups WHERE name='pelistal');

--Show what the tree for this tech group has, ordered in top-left to bottom-right
--select 
--	(select top 1 definitionname from entitydefaults where definition in (parentdefinition)),
--	(select top 1 definitionname from entitydefaults where definition in (childdefinition)),
--	x, y
--from techtree where groupID=@techGroupId order by y, x;

PRINT N'PELISTAL RESEARCH TREE';
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
	@techGroupId, s.x, s.y);

DROP TABLE IF EXISTS #TECHSLOTSPELISTAL;
DROP TABLE IF EXISTS #TECHCOSTPELISTAL;
GO



PRINT N'16_TECH_thelodica_tree';

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
('def_longrange_standard_medium_laser','def_standard_large_laser',6,3),
('def_standard_large_laser','def_named1_large_laser',7,3),
('def_named1_large_laser','def_named2_large_laser',8,3),
('def_named2_large_laser','def_named3_large_laser',9,3),
('def_named2_medium_laser','def_longrange_standard_large_laser',6,6),
('def_longrange_standard_large_laser','def_named1_longrange_large_laser',7,6),
('def_named1_longrange_large_laser','def_named2_longrange_large_laser',8,6),
('def_named2_longrange_large_laser','def_named3_longrange_large_laser',9,6),
('def_standard_large_laser','def_ammo_large_lasercrystal_d',6,1),
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




PRINT N'17_CREATE_TABLE_productioncost__2020_04_25';

USE [perpetuumsa]
GO

----------------------------------------------------------------------------
--Migration to add productioncost Table
--Table contains production cost multiplier for nic costs associated with production
--
--Date modified: 2020/04/25
----------------------------------------------------------------------------


DROP TABLE IF EXISTS dbo.productioncost;

CREATE TABLE dbo.productioncost (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	category BIGINT,
	tiertype INT,
	tierlevel INT,
	costmodifier FLOAT NOT NULL DEFAULT 1.0
);


INSERT INTO dbo.productioncost (category, tiertype, tierlevel, costmodifier) VALUES
(NULL, NULL, 1, 1.0),
(NULL, NULL, 2, 2.0),
(NULL, NULL, 3, 3.0),
(NULL, NULL, 4, 4.0),
((SELECT value FROM categoryFlags WHERE name='cf_thelodica_runners'), NULL, NULL, 1.0),
((SELECT value FROM categoryFlags WHERE name='cf_thelodica_crawlers'), NULL, NULL, 2.0),
((SELECT value FROM categoryFlags WHERE name='cf_thelodica_mechs'), NULL, NULL, 3.0),
((SELECT value FROM categoryFlags WHERE name='cf_thelodica_heavymechs'), NULL, NULL, 4.0),
((SELECT value FROM categoryFlags WHERE name='cf_nuimqol_runners'), NULL, NULL, 1.0),
((SELECT value FROM categoryFlags WHERE name='cf_nuimqol_crawlers'), NULL, NULL, 2.0),
((SELECT value FROM categoryFlags WHERE name='cf_nuimqol_mechs'), NULL, NULL, 3.0),
((SELECT value FROM categoryFlags WHERE name='cf_nuimqol_heavymechs'), NULL, NULL, 4.0),
((SELECT value FROM categoryFlags WHERE name='cf_pelistal_runners'), NULL, NULL, 1.0),
((SELECT value FROM categoryFlags WHERE name='cf_pelistal_crawlers'), NULL, NULL, 2.0),
((SELECT value FROM categoryFlags WHERE name='cf_pelistal_mechs'), NULL, NULL, 3.0),
((SELECT value FROM categoryFlags WHERE name='cf_pelistal_heavymechs'), NULL, NULL, 4.0),
((SELECT value FROM categoryFlags WHERE name='cf_syndicate_runners'), NULL, NULL, 1.0),
((SELECT value FROM categoryFlags WHERE name='cf_syndicate_crawlers'), NULL, NULL, 2.0),
((SELECT value FROM categoryFlags WHERE name='cf_syndicate_mechs'), NULL, NULL, 3.0),
((SELECT value FROM categoryFlags WHERE name='cf_syndicate_heavymechs'), NULL, NULL, 4.0),
((SELECT value FROM categoryFlags WHERE name='cf_industrial_runners'), NULL, NULL, 1.0),
((SELECT value FROM categoryFlags WHERE name='cf_industrial_crawlers'), NULL, NULL, 2.0),
((SELECT value FROM categoryFlags WHERE name='cf_industrial_mechs'), NULL, NULL, 3.0),
((SELECT value FROM categoryFlags WHERE name='cf_industrial_heavymechs'), NULL, NULL, 4.0),
((SELECT value FROM categoryFlags WHERE name='cf_industrial_heavy_gliders'), NULL, NULL, 4.0),
((SELECT value FROM categoryFlags WHERE name='cf_walkers'), NULL, NULL, 5.0);

GO

PRINT N'18_def_intakt_chassis_mk2__2020_05_16_00_32_50';

USE [perpetuumsa]
GO

----------------------------------------------------
--Intakt MK2 Reactor fix
--Date: 2020/05/16
------------------------------------------------------
DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_chassis_mk2' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=192 WHERE id =  @aggvalueID;

GO

PRINT N'19_def_npc_beta1_pitboss_loot__2020_05_11_21_35_23';

USE [perpetuumsa]
GO
------------------------------------------------------------
--Beta 1 Pitboss loot updates
--Updated quantities and new entries for smooth and higher quantity loot drops
--
--Date modified: 2020/05/15
------------------------------------------------------------

--BETA 1 PITBOSS:LOOT
DROP TABLE IF EXISTS #NPCLOOTS;
CREATE TABLE #NPCLOOTS (
	defName VARCHAR(100) NOT NULL,
	probability float NOT NULL,
	minQuantity int NOT NULL,
	maxQuantity int NOT NULL,
	dontDmg bit NOT NULL,
	repackaged bit NOT NULL,
);

INSERT INTO #NPCLOOTS (defName, probability, minQuantity, maxQuantity, dontDmg, repackaged) VALUES
('def_common_reactor_plasma', 1.0, 80000, 200000, 1, 1),
('def_pelistal_reactor_plasma', 1.0, 80000, 200000, 1, 1),
('def_nuimqol_reactor_plasma', 1.0, 80000, 200000, 1, 1),
('def_thelodica_reactor_plasma', 1.0, 80000, 200000, 1, 1),
('def_kernel_pelistal', 1.0, 75000, 125000, 1, 1),
('def_kernel_thelodica', 1.0, 75000, 125000, 1, 1),
('def_kernel_nuimqol', 1.0, 75000, 125000, 1, 1),
('def_kernel_common', 1.0, 75000, 125000, 1, 1),
('def_kernel_hitech', 1.0, 15000, 25000, 1, 1),
('def_robotshard_common_basic', 1.0, 500, 2000, 1, 1),
('def_robotshard_common_advanced', 1.0, 500, 2000, 1, 1),
('def_robotshard_common_expert', 1.0, 500, 2000, 1, 1),
('def_robotshard_nuimqol_basic', 1.0, 500, 2000, 1, 1),
('def_robotshard_nuimqol_advanced', 1.0, 500, 2000, 1, 1),
('def_robotshard_nuimqol_expert', 1.0, 500, 2000, 1, 1),
('def_robotshard_pelistal_basic', 1.0, 500, 2000, 1, 1),
('def_robotshard_pelistal_advanced', 1.0, 500, 2000, 1, 1),
('def_robotshard_pelistal_expert', 1.0, 500, 2000, 1, 1),
('def_robotshard_thelodica_basic', 1.0, 500, 2000, 1, 1),
('def_robotshard_thelodica_advanced', 1.0, 500, 2000, 1, 1),
('def_robotshard_thelodica_expert', 1.0, 500, 2000, 1, 1),
('def_research_kit_9', 1.0, 2, 5, 1, 1),
('def_research_kit_10', 1.0, 2, 5, 1, 1),
('def_boost_ep_t0', 1.0, 2, 5, 1, 1),
('def_boost_ep_t1', 1.0, 1, 2, 1, 1),
('def_reactore_core_runner', 1.0, 1, 2, 1, 1),
('def_reactore_core_assault', 1.0, 1, 2, 1, 1),
('def_reactore_core_mech', 1.0, 1, 2, 1, 1),
('def_reactore_core_heavymech', 1.0, 1, 2, 1, 1),
--Add 3x entries to get 3x 25% chance to get CT
('def_scarab_mk2_A_CT_capsule', 0.25, 1, 1, 1, 1),
('def_gropho_mk2_A_CT_capsule', 0.25, 1, 1, 1, 1),
('def_mesmer_mk2_A_CT_capsule', 0.25, 1, 1, 1, 1),
('def_seth_mk2_A_CT_capsule', 0.25, 1, 1, 1, 1),
('def_scarab_mk2_A_CT_capsule', 0.25, 1, 1, 1, 1),
('def_gropho_mk2_A_CT_capsule', 0.25, 1, 1, 1, 1),
('def_mesmer_mk2_A_CT_capsule', 0.25, 1, 1, 1, 1),
('def_seth_mk2_A_CT_capsule', 0.25, 1, 1, 1, 1),
('def_scarab_mk2_A_CT_capsule', 0.25, 1, 1, 1, 1),
('def_gropho_mk2_A_CT_capsule', 0.25, 1, 1, 1, 1),
('def_mesmer_mk2_A_CT_capsule', 0.25, 1, 1, 1, 1),
('def_seth_mk2_A_CT_capsule', 0.25, 1, 1, 1, 1),
--Add 3x entries to get 3x 11% chance to get nexus modules
('def_named2_gang_assist_speed_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_information_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_industry_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_siege_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_defense_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_ewar_range_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_shared_dataprocessing_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_coordinated_maneuvering_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_maintance_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_precision_firing_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_core_management_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_fast_extraction_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_shield_calculation_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_speed_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_information_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_industry_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_siege_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_defense_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_ewar_range_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_shared_dataprocessing_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_coordinated_maneuvering_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_maintance_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_precision_firing_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_core_management_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_fast_extraction_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_shield_calculation_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_speed_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_information_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_industry_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_siege_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_defense_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_ewar_range_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_shared_dataprocessing_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_coordinated_maneuvering_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_maintance_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_precision_firing_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_core_management_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_fast_extraction_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_shield_calculation_module', 0.11, 1, 1, 0, 1);


DECLARE @definitionID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_beta1_pitboss' ORDER BY definition DESC);

PRINT N'BETA 1 PITBOSS:LOOT';
PRINT N'Delete old loot';
DELETE FROM npcloot WHERE definition=@definitionID;
PRINT N'Add loot';
INSERT INTO npcloot ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity])
SELECT @definitionID, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defName), maxQuantity, probability, repackaged, dontDmg, minQuantity FROM #NPCLOOTS;

DROP TABLE IF EXISTS #NPCLOOTS;
GO

PRINT N'20_Defconfig_izteleport_range__2020_05_17';

USE [perpetuumsa]
GO

---------------------------------------------------
--Interzone range increase 30k->40k
--
--Date Modified: 2020/05/17
---------------------------------------------------

UPDATE definitionconfig SET 
	item_work_range = 4072
WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname like 'def_mobile_world_teleport%');

GO

PRINT N'LIVE PATCH 17 APPLIED';
GO
