USE [perpetuumsa]
GO

--------------------------------------------
-- ELITE MODULES for GAMMA HOLY F
-- a lot
-- Date modified: 2021/11/17
--------------------------------------------

DECLARE @dataShardCat AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_datashards');

DECLARE @dynamicCtCategory AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_dynamic_cprg');--For ct capsule defined cts

DECLARE @tmShops AS INT = (SELECT TOP 1 id FROM itemshoppresets WHERE name='tm_preset_pve');
DECLARE @t2smallpriceNIC AS INT = 600000;
DECLARE @t4smallpriceNIC AS INT = 800000;
DECLARE @t2medpriceNIC AS INT = 1200000;
DECLARE @t4medpriceNIC AS INT = 1600000;

DECLARE @t2smallpriceTOK AS INT = 30;
DECLARE @t4smallpriceTOK AS INT = 40;
DECLARE @t2medpriceTOK AS INT = 60;
DECLARE @t4medpriceTOK AS INT = 80;


DROP TABLE IF EXISTS #MATERIALDEF;
CREATE TABLE #MATERIALDEF 
(
	def INT,
	defName varchar(100),
	attrFlags bigint,
	catFlags bigint,
	genxyOptStr varchar(max),
	cargoVolume float,
	massOfModule float,
	techType int,
	techLevel int,
);
INSERT INTO #MATERIALDEF (def, defName, attrFlags, catFlags, genxyOptStr, cargoVolume, massOfModule, techType, techLevel) VALUES
(6200,'def_material_boss_gamma_thelodica',2048,@dataShardCat,NULL,0.002,0.25,NULL,NULL),
(6201,'def_material_boss_gamma_pelistal',2048,@dataShardCat,NULL,0.002,0.25,NULL,NULL),
(6202,'def_material_boss_gamma_nuimqol',2048,@dataShardCat,NULL,0.002,0.25,NULL,NULL),
(6203,'def_material_boss_gamma_syndicate',2048,@dataShardCat,NULL,0.002,0.25,NULL,NULL);

DROP TABLE IF EXISTS #ENTITYDEF;
CREATE TABLE #ENTITYDEF 
(
	def INT,
	defName varchar(100),
	attrFlags bigint,
	catFlags bigint,
	genxyOptStr varchar(max),
	cargoVolume float,
	massOfModule float,
	techType int,
	techLevel int,
);
INSERT INTO #ENTITYDEF (def, defName, attrFlags, catFlags, genxyOptStr, cargoVolume, massOfModule, techType, techLevel) VALUES

(6204,'def_elitet4_gamma_small_autocannon',303824,4362209039,'#moduleFlag=i51#ammoCapacity=ic8#ammoType=L1030a#tier=$tierlevel_t4+',0.6,275,3,4),
(6205,'def_elitet4_gamma_medium_autocannon',336592,8657176335,'#moduleFlag=i91#ammoCapacity=ic8#ammoType=L2030a#tier=$tierlevel_t4+',1.2,550,3,4),
(6206,'def_elitet4_gamma_longrange_medium_autocannon',336592,8657176335,'#moduleFlag=i91#ammoCapacity=i96#ammoType=L2030a#tier=$tierlevel_t4+',1.2,715,3,4),

(6207,'def_elitet4_gamma_small_laser',303824,16844559,'#moduleFlag=i51#ammoCapacity=i5a#ammoType=L1020a#tier=$tierlevel_t4+',0.5,275,3,4),
(6208,'def_elitet4_gamma_medium_laser',336592,33621775,'#moduleFlag=i91#ammoCapacity=i5a#ammoType=L2020a#tier=$tierlevel_t4+',1,550,3,4),
(6209,'def_elitet4_gamma_longrange_medium_laser',336592,33621775,'#moduleFlag=i91#ammoCapacity=i78#ammoType=L2020a#tier=$tierlevel_t4+',1,715,3,4),

(6210,'def_elitet4_gamma_small_railgun',303824,17041167,'#moduleFlag=i51#ammoCapacity=i2d#ammoType=L1010a#tier=$tierlevel_t4+',0.5,275,3,4),
(6211,'def_elitet4_gamma_medium_railgun',336592,33818383,'#moduleFlag=i91#ammoCapacity=i14#ammoType=L2010a#tier=$tierlevel_t4+',1,550,3,4),
(6212,'def_elitet4_gamma_longrange_medium_railgun',336592,33818383,'#moduleFlag=i91#ammoCapacity=i32#ammoType=L2010a#tier=$tierlevel_t4+',1,715,3,4),

(6213,'def_elitet4_gamma_rocket_launcher',303824,16975631,'#moduleFlag=i52#ammoCapacity=i1e#ammoType=L1040a#tier=$tierlevel_t4+',1,275,3,4),
(6214,'def_elitet4_gamma_missile_launcher',336592,33752847,'#moduleFlag=i92#ammoCapacity=i1e#ammoType=L2040a #tier=$tierlevel_t4+',2,550,3,4),

(6215,'def_elitet4_gamma_small_driller',294928,16844303,'#moduleFlag=i250#ammoCapacity=i2d#ammoType=L50a#tier=$tierlevel_t4+',1,400,3,4),
(6216,'def_elitet4_gamma_medium_driller',327696,33621519,'#moduleFlag=i290#ammoCapacity=i2d#ammoType=L50a#tier=$tierlevel_t4+',1.5,1000,3,4),

(6217,'def_elitet4_gamma_small_harvester',294928,17171983,'#moduleFlag=i250#ammoCapacity=i2d#ammoType=La0a#tier=$tierlevel_t4+',1,400,3,4),
(6218,'def_elitet4_gamma_medium_harvester',327696,33949199,'#moduleFlag=i290#ammoCapacity=i2d#ammoType=La0a#tier=$tierlevel_t4+',1.5,1000,3,4);


DROP TABLE IF EXISTS #CTS;
CREATE TABLE #CTS 
(
	def INT,
	defName varchar(100),
	attrFlags bigint,
	catFlags bigint,
	genxyOptStr varchar(max),
	cargoVolume float,
	massOfModule float,
	techType int,
	techLevel int,
);
INSERT INTO #CTS (def, defName, attrFlags, catFlags, genxyOptStr, cargoVolume, massOfModule, techType, techLevel) VALUES
(6219,'def_elitet4_gamma_small_autocannon_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),
(6220,'def_elitet4_gamma_medium_autocannon_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),
(6221,'def_elitet4_gamma_longrange_medium_autocannon_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),

(6222,'def_elitet4_gamma_small_laser_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),
(6223,'def_elitet4_gamma_medium_laser_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),
(6224,'def_elitet4_gamma_longrange_medium_laser_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),

(6225,'def_elitet4_gamma_small_railgun_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),
(6226,'def_elitet4_gamma_medium_railgun_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),
(6227,'def_elitet4_gamma_longrange_medium_railgun_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),

(6228,'def_elitet4_gamma_rocket_launcher_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),
(6229,'def_elitet4_gamma_missile_launcher_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),

(6230,'def_elitet4_gamma_small_driller_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),
(6231,'def_elitet4_gamma_medium_driller_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),

(6232,'def_elitet4_gamma_small_harvester_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),
(6233,'def_elitet4_gamma_medium_harvester_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4);



DECLARE @IndyCTCapsule AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_ct_capsules_equipment_industrial');
DECLARE @WeaponCTCapsule AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_ct_capsules_equipment_weapons');


DROP TABLE IF EXISTS #CTS_CAPSULES;
CREATE TABLE #CTS_CAPSULES 
(
	def INT,
	defName varchar(100),
	attrFlags bigint,
	catFlags bigint,
	genxyOptStr varchar(max),
	cargoVolume float,
	massOfModule float,
	techType int,
	techLevel int,
);
INSERT INTO #CTS_CAPSULES (def, defName, attrFlags, catFlags, genxyOptStr, cargoVolume, massOfModule, techType, techLevel) VALUES
(6234,'def_elitet4_gamma_small_autocannon_CT_capsule',2052,@WeaponCTCapsule,'#tier=$tierlevel_t4+',0.1,0.1,3,4),
(6235,'def_elitet4_gamma_medium_autocannon_CT_capsule',2052,@WeaponCTCapsule,'#tier=$tierlevel_t4+',0.1,0.1,3,4),
(6236,'def_elitet4_gamma_longrange_medium_autocannon_CT_capsule',2052,@WeaponCTCapsule,'#tier=$tierlevel_t4+',0.1,0.1,3,4),

(6237,'def_elitet4_gamma_small_laser_CT_capsule',2052,@WeaponCTCapsule,'#tier=$tierlevel_t4+',0.1,0.1,3,4),
(6238,'def_elitet4_gamma_medium_laser_CT_capsule',2052,@WeaponCTCapsule,'#tier=$tierlevel_t4+',0.1,0.1,3,4),
(6239,'def_elitet4_gamma_longrange_medium_laser_CT_capsule',2052,@WeaponCTCapsule,'#tier=$tierlevel_t4+',0.1,0.1,3,4),

(6240,'def_elitet4_gamma_small_railgun_CT_capsule',2052,@WeaponCTCapsule,'#tier=$tierlevel_t4+',0.1,0.1,3,4),
(6241,'def_elitet4_gamma_medium_railgun_CT_capsule',2052,@WeaponCTCapsule,'#tier=$tierlevel_t4+',0.1,0.1,3,4),
(6242,'def_elitet4_gamma_longrange_medium_railgun_CT_capsule',2052,@WeaponCTCapsule,'#tier=$tierlevel_t4+',0.1,0.1,3,4),

(6243,'def_elitet4_gamma_rocket_launcher_CT_capsule',2052,@WeaponCTCapsule,'#tier=$tierlevel_t4+',0.1,0.1,3,4),
(6244,'def_elitet4_gamma_missile_launcher_CT_capsule',2052,@WeaponCTCapsule,'#tier=$tierlevel_t4+',0.1,0.1,3,4),

(6245,'def_elitet4_gamma_small_driller_CT_capsule',2052,@IndyCTCapsule,'#tier=$tierlevel_t4+',0.1,0.1,3,4),
(6246,'def_elitet4_gamma_medium_driller_CT_capsule',2052,@IndyCTCapsule,'#tier=$tierlevel_t4+',0.1,0.1,3,4),

(6247,'def_elitet4_gamma_small_harvester_CT_capsule',2052,@IndyCTCapsule,'#tier=$tierlevel_t4+',0.1,0.1,3,4),
(6248,'def_elitet4_gamma_medium_harvester_CT_capsule',2052,@IndyCTCapsule,'#tier=$tierlevel_t4+',0.1,0.1,3,4);

DROP TABLE IF EXISTS #SHOPENTRIES;
CREATE TABLE #SHOPENTRIES
(
	defName varchar(256),
	nicPrice int,
	unitokenPrice int null,
	thelodicatokenPrice int null,
	nuimqoltokenPrice int null,
	pelistaltokenPrice int null,
);
INSERT INTO #SHOPENTRIES (defName, nicPrice, unitokenPrice, thelodicatokenPrice, nuimqoltokenPrice, pelistaltokenPrice) VALUES
('def_elitet4_gamma_small_autocannon_CT_capsule',@t4smallpriceNIC, @t4smallpriceTOK, NULL, NULL, NULL),
('def_elitet4_gamma_medium_autocannon_CT_capsule',@t4medpriceNIC, @t4medpriceTOK, NULL, NULL, NULL),
('def_elitet4_gamma_longrange_medium_autocannon_CT_capsule',@t4medpriceNIC, @t4medpriceTOK, NULL, NULL, NULL),
('def_elitet4_gamma_small_laser_CT_capsule',@t4smallpriceNIC, NULL, @t4smallpriceTOK, NULL, NULL),
('def_elitet4_gamma_medium_laser_CT_capsule',@t4medpriceNIC, NULL, @t4medpriceTOK, NULL, NULL),
('def_elitet4_gamma_longrange_medium_laser_CT_capsule',@t4medpriceNIC, NULL, @t4medpriceTOK, NULL, NULL),
('def_elitet4_gamma_small_railgun_CT_capsule',@t4smallpriceNIC, NULL, NULL, @t4smallpriceTOK, NULL),
('def_elitet4_gamma_medium_railgun_CT_capsule',@t4medpriceNIC, NULL, NULL, @t4medpriceTOK, NULL),
('def_elitet4_gamma_longrange_medium_railgun_CT_capsule',@t4medpriceNIC, NULL, NULL, @t4medpriceTOK, NULL),
('def_elitet4_gamma_rocket_launcher_CT_capsule',@t4smallpriceNIC, NULL, NULL, NULL, @t4smallpriceTOK),
('def_elitet4_gamma_missile_launcher_CT_capsule',@t4medpriceNIC, NULL, NULL, NULL, @t4medpriceTOK),
('def_elitet4_gamma_small_driller_CT_capsule',@t4smallpriceNIC, @t4smallpriceTOK, NULL, NULL, NULL),
('def_elitet4_gamma_medium_driller_CT_capsule',@t4medpriceNIC, @t4medpriceTOK, NULL, NULL, NULL),
('def_elitet4_gamma_small_harvester_CT_capsule',@t4smallpriceNIC, @t4smallpriceTOK, NULL, NULL, NULL),
('def_elitet4_gamma_medium_harvester_CT_capsule',@t4medpriceNIC, @t4medpriceTOK, NULL, NULL, NULL);


DROP TABLE IF EXISTS #CT_RELATE;
CREATE TABLE #CT_RELATE 
(
	defName varchar(100),
	ctName varchar(100),
	capName varchar(100)
);
INSERT INTO #CT_RELATE (defName, ctName, capName) VALUES
('def_elitet4_gamma_small_autocannon', 'def_elitet4_gamma_small_autocannon_cprg', 'def_elitet4_gamma_small_autocannon_CT_capsule'),
('def_elitet4_gamma_medium_autocannon', 'def_elitet4_gamma_medium_autocannon_cprg', 'def_elitet4_gamma_medium_autocannon_CT_capsule'),
('def_elitet4_gamma_longrange_medium_autocannon', 'def_elitet4_gamma_longrange_medium_autocannon_cprg', 'def_elitet4_gamma_longrange_medium_autocannon_CT_capsule'),

('def_elitet4_gamma_small_laser', 'def_elitet4_gamma_small_laser_cprg', 'def_elitet4_gamma_small_laser_CT_capsule'),
('def_elitet4_gamma_medium_laser', 'def_elitet4_gamma_medium_laser_cprg', 'def_elitet4_gamma_medium_laser_CT_capsule'),
('def_elitet4_gamma_longrange_medium_laser', 'def_elitet4_gamma_longrange_medium_laser_cprg', 'def_elitet4_gamma_longrange_medium_laser_CT_capsule'),

('def_elitet4_gamma_small_railgun', 'def_elitet4_gamma_small_railgun_cprg', 'def_elitet4_gamma_small_railgun_CT_capsule'),
('def_elitet4_gamma_medium_railgun', 'def_elitet4_gamma_medium_railgun_cprg', 'def_elitet4_gamma_medium_railgun_CT_capsule'),
('def_elitet4_gamma_longrange_medium_railgun', 'def_elitet4_gamma_longrange_medium_railgun_cprg', 'def_elitet4_gamma_longrange_medium_railgun_CT_capsule'),

('def_elitet4_gamma_rocket_launcher', 'def_elitet4_gamma_rocket_launcher_cprg', 'def_elitet4_gamma_rocket_launcher_CT_capsule'),
('def_elitet4_gamma_missile_launcher', 'def_elitet4_gamma_missile_launcher_cprg', 'def_elitet4_gamma_missile_launcher_CT_capsule'),

('def_elitet4_gamma_small_driller', 'def_elitet4_gamma_small_driller_cprg', 'def_elitet4_gamma_small_driller_CT_capsule'),
('def_elitet4_gamma_medium_driller', 'def_elitet4_gamma_medium_driller_cprg', 'def_elitet4_gamma_medium_driller_CT_capsule'),

('def_elitet4_gamma_small_harvester', 'def_elitet4_gamma_small_harvester_cprg', 'def_elitet4_gamma_small_harvester_CT_capsule'),
('def_elitet4_gamma_medium_harvester', 'def_elitet4_gamma_medium_harvester_cprg', 'def_elitet4_gamma_medium_harvester_CT_capsule');


DROP TABLE IF EXISTS #STATS;
CREATE TABLE #STATS(
	defName varchar(100),
	fieldName varchar(100),
	fieldValue float,
);
INSERT INTO #STATS (defName, fieldName, fieldValue) VALUES
('def_elitet4_gamma_small_laser','accuracy',4),
('def_elitet4_gamma_small_laser','core_usage',4.8),
('def_elitet4_gamma_small_laser','cpu_usage',22),
('def_elitet4_gamma_small_laser','cycle_time',3500),
('def_elitet4_gamma_small_laser','damage_modifier',1.175),--117.50%
('def_elitet4_gamma_small_laser','falloff',10),
('def_elitet4_gamma_small_laser','optimal_range',16.5),
('def_elitet4_gamma_small_laser','powergrid_usage',44),
('def_elitet4_gamma_small_laser','least_optimal',6),

('def_elitet4_gamma_medium_laser','accuracy',11.5),
('def_elitet4_gamma_medium_laser','core_usage',19.2),
('def_elitet4_gamma_medium_laser','cpu_usage',30),
('def_elitet4_gamma_medium_laser','cycle_time',5000),
('def_elitet4_gamma_medium_laser','damage_modifier',1.70),--170.00%
('def_elitet4_gamma_medium_laser','falloff',10),
('def_elitet4_gamma_medium_laser','optimal_range',19),
('def_elitet4_gamma_medium_laser','powergrid_usage',250),
('def_elitet4_gamma_medium_laser','least_optimal',6),

('def_elitet4_gamma_small_autocannon','accuracy',6),
('def_elitet4_gamma_small_autocannon','core_usage',1),
('def_elitet4_gamma_small_autocannon','cpu_usage',7),
('def_elitet4_gamma_small_autocannon','cycle_time',2500),
('def_elitet4_gamma_small_autocannon','damage_modifier',1.175),--117.50%
('def_elitet4_gamma_small_autocannon','falloff',15),
('def_elitet4_gamma_small_autocannon','optimal_range',8.5),
('def_elitet4_gamma_small_autocannon','powergrid_usage',18),
('def_elitet4_gamma_small_autocannon','least_optimal',1),

('def_elitet4_gamma_medium_autocannon','accuracy',17),
('def_elitet4_gamma_medium_autocannon','core_usage',2),
('def_elitet4_gamma_medium_autocannon','cpu_usage',13),
('def_elitet4_gamma_medium_autocannon','cycle_time',3000),
('def_elitet4_gamma_medium_autocannon','damage_modifier',1.425),--142.50%
('def_elitet4_gamma_medium_autocannon','falloff',18.5),
('def_elitet4_gamma_medium_autocannon','optimal_range',15),
('def_elitet4_gamma_medium_autocannon','powergrid_usage',140),
('def_elitet4_gamma_medium_autocannon','least_optimal',2),

('def_elitet4_gamma_rocket_launcher','accuracy',1),
('def_elitet4_gamma_rocket_launcher','core_usage',1),
('def_elitet4_gamma_rocket_launcher','cpu_usage',34),
('def_elitet4_gamma_rocket_launcher','cycle_time',6500),
('def_elitet4_gamma_rocket_launcher','damage_modifier',1.05),--105.00%
('def_elitet4_gamma_rocket_launcher','powergrid_usage',29),
('def_elitet4_gamma_rocket_launcher','module_missile_range_modifier',1.2),

('def_elitet4_gamma_missile_launcher','accuracy',1),
('def_elitet4_gamma_missile_launcher','core_usage',2),
('def_elitet4_gamma_missile_launcher','cpu_usage',45),
('def_elitet4_gamma_missile_launcher','cycle_time',10500),
('def_elitet4_gamma_missile_launcher','damage_modifier',1.10),--110.00%
('def_elitet4_gamma_missile_launcher','powergrid_usage',170),
('def_elitet4_gamma_missile_launcher','module_missile_range_modifier',1.2),

('def_elitet4_gamma_small_railgun','accuracy',5),
('def_elitet4_gamma_small_railgun','core_usage',5),
('def_elitet4_gamma_small_railgun','cpu_usage',30),
('def_elitet4_gamma_small_railgun','cycle_time',6000),
('def_elitet4_gamma_small_railgun','damage_modifier',2.20),--220.00%
('def_elitet4_gamma_small_railgun','falloff',6),
('def_elitet4_gamma_small_railgun','optimal_range',13.5),
('def_elitet4_gamma_small_railgun','powergrid_usage',37),
('def_elitet4_gamma_small_railgun','least_optimal',9),

('def_elitet4_gamma_medium_railgun','accuracy',13.5),
('def_elitet4_gamma_medium_railgun','core_usage',20),
('def_elitet4_gamma_medium_railgun','cpu_usage',38),
('def_elitet4_gamma_medium_railgun','cycle_time',8000),
('def_elitet4_gamma_medium_railgun','damage_modifier',3.25),--325.00%
('def_elitet4_gamma_medium_railgun','falloff',6),
('def_elitet4_gamma_medium_railgun','optimal_range',17.5),
('def_elitet4_gamma_medium_railgun','powergrid_usage',180),
('def_elitet4_gamma_medium_railgun','least_optimal',13),

('def_elitet4_gamma_longrange_medium_railgun','accuracy',14),
('def_elitet4_gamma_longrange_medium_railgun','core_usage',29),
('def_elitet4_gamma_longrange_medium_railgun','cpu_usage',45),
('def_elitet4_gamma_longrange_medium_railgun','cycle_time',10000),
('def_elitet4_gamma_longrange_medium_railgun','damage_modifier',2.95),--295.00%
('def_elitet4_gamma_longrange_medium_railgun','falloff',6),
('def_elitet4_gamma_longrange_medium_railgun','optimal_range',31),
('def_elitet4_gamma_longrange_medium_railgun','powergrid_usage',200),
('def_elitet4_gamma_longrange_medium_railgun','least_optimal',21),

('def_elitet4_gamma_longrange_medium_laser','accuracy',12),
('def_elitet4_gamma_longrange_medium_laser','core_usage',24),
('def_elitet4_gamma_longrange_medium_laser','cpu_usage',35),
('def_elitet4_gamma_longrange_medium_laser','cycle_time',6000),
('def_elitet4_gamma_longrange_medium_laser','damage_modifier',1.40),--140.00%
('def_elitet4_gamma_longrange_medium_laser','falloff',10),
('def_elitet4_gamma_longrange_medium_laser','optimal_range',37.5),
('def_elitet4_gamma_longrange_medium_laser','powergrid_usage',250),
('def_elitet4_gamma_longrange_medium_laser','least_optimal',12),

('def_elitet4_gamma_longrange_medium_autocannon','accuracy',18),
('def_elitet4_gamma_longrange_medium_autocannon','core_usage',2),
('def_elitet4_gamma_longrange_medium_autocannon','cpu_usage',14),
('def_elitet4_gamma_longrange_medium_autocannon','cycle_time',9000),
('def_elitet4_gamma_longrange_medium_autocannon','damage_modifier',2.85),--285.00%
('def_elitet4_gamma_longrange_medium_autocannon','falloff',32),
('def_elitet4_gamma_longrange_medium_autocannon','optimal_range',24),
('def_elitet4_gamma_longrange_medium_autocannon','powergrid_usage',150),
('def_elitet4_gamma_longrange_medium_autocannon','least_optimal',5),

('def_elitet4_gamma_small_driller','core_usage',22),
('def_elitet4_gamma_small_driller','cpu_usage',45),
('def_elitet4_gamma_small_driller','cycle_time',11750),--11.75
('def_elitet4_gamma_small_driller','optimal_range',3.5),
('def_elitet4_gamma_small_driller','powergrid_usage',33),

('def_elitet4_gamma_medium_driller','core_usage',65),
('def_elitet4_gamma_medium_driller','cpu_usage',55),
('def_elitet4_gamma_medium_driller','cycle_time',9400),--9.40
('def_elitet4_gamma_medium_driller','optimal_range',4),
('def_elitet4_gamma_medium_driller','powergrid_usage',170),

('def_elitet4_gamma_small_harvester','core_usage',22),
('def_elitet4_gamma_small_harvester','cpu_usage',44),
('def_elitet4_gamma_small_harvester','cycle_time',11750),--11.75
('def_elitet4_gamma_small_harvester','optimal_range',3.5),
('def_elitet4_gamma_small_harvester','powergrid_usage',33),

('def_elitet4_gamma_medium_harvester','core_usage',65),
('def_elitet4_gamma_medium_harvester','cpu_usage',55),
('def_elitet4_gamma_medium_harvester','cycle_time',9400),--9.40
('def_elitet4_gamma_medium_harvester','optimal_range',4),
('def_elitet4_gamma_medium_harvester','powergrid_usage',165);


DROP TABLE IF EXISTS #SKILLS;
CREATE TABLE #SKILLS (
	defName varchar(100),
	extName varchar(100),
	extLevel float,
);
INSERT INTO #SKILLS (defName, extName, extLevel) VALUES
('def_elitet4_gamma_small_laser','ext_small_laser',7),
('def_elitet4_gamma_medium_laser','ext_medium_laser',7),
('def_elitet4_gamma_small_autocannon','ext_small_projectile_turret',7),
('def_elitet4_gamma_medium_autocannon','ext_medium_projectile_turret',7),
('def_elitet4_gamma_rocket_launcher','ext_rockets',7),
('def_elitet4_gamma_missile_launcher','ext_standard_missiles',7),
('def_elitet4_gamma_small_railgun','ext_small_railgun',7),
('def_elitet4_gamma_medium_railgun','ext_medium_railgun',7),
('def_elitet4_gamma_longrange_medium_railgun','ext_medium_railgun',8),
('def_elitet4_gamma_longrange_medium_laser','ext_medium_laser',8),
('def_elitet4_gamma_longrange_medium_autocannon','ext_medium_projectile_turret',8),
('def_elitet4_gamma_small_driller','ext_miner',7),
('def_elitet4_gamma_medium_driller','ext_miner',8),
('def_elitet4_gamma_small_harvester','ext_harvester',7),
('def_elitet4_gamma_medium_harvester','ext_harvester',8);


DROP TABLE IF EXISTS #INDY;
CREATE TABLE #INDY
(
	defName VARCHAR(100),
	commodityName VARCHAR(100),
	amount INT
);
INSERT INTO #INDY (defName, commodityName, amount) VALUES
('def_elitet4_gamma_small_autocannon', 'def_named3_small_autocannon', 1),
('def_elitet4_gamma_small_autocannon','def_material_boss_gamma_syndicate',200),

('def_elitet4_gamma_medium_autocannon', 'def_named3_medium_autocannon', 1),
('def_elitet4_gamma_medium_autocannon','def_material_boss_gamma_syndicate',400),

('def_elitet4_gamma_longrange_medium_autocannon', 'def_named3_longrange_medium_autocannon', 1),
('def_elitet4_gamma_longrange_medium_autocannon','def_material_boss_gamma_syndicate',400),

('def_elitet4_gamma_small_laser', 'def_named3_small_laser', 1),
('def_elitet4_gamma_small_laser','def_material_boss_gamma_thelodica',200),

('def_elitet4_gamma_medium_laser', 'def_named3_medium_laser', 1),
('def_elitet4_gamma_medium_laser','def_material_boss_gamma_thelodica',400),

('def_elitet4_gamma_longrange_medium_laser', 'def_named3_longrange_medium_laser', 1),
('def_elitet4_gamma_longrange_medium_laser','def_material_boss_gamma_thelodica',400),

('def_elitet4_gamma_small_railgun', 'def_named3_small_railgun', 1),
('def_elitet4_gamma_small_railgun','def_material_boss_gamma_nuimqol',200),

('def_elitet4_gamma_medium_railgun', 'def_named3_medium_railgun', 1),
('def_elitet4_gamma_medium_railgun','def_material_boss_gamma_nuimqol',400),

('def_elitet4_gamma_longrange_medium_railgun', 'def_named3_longrange_medium_railgun', 1),
('def_elitet4_gamma_longrange_medium_railgun','def_material_boss_gamma_nuimqol',400),

('def_elitet4_gamma_rocket_launcher', 'def_named3_rocket_launcher', 1),
('def_elitet4_gamma_rocket_launcher','def_material_boss_gamma_pelistal',200),

('def_elitet4_gamma_missile_launcher', 'def_named3_missile_launcher', 1),
('def_elitet4_gamma_missile_launcher','def_material_boss_gamma_pelistal',400),

('def_elitet4_gamma_small_driller', 'def_named3_small_driller', 1),
('def_elitet4_gamma_small_driller','def_material_boss_gamma_pelistal',67),
('def_elitet4_gamma_small_driller','def_material_boss_gamma_nuimqol',67),
('def_elitet4_gamma_small_driller','def_material_boss_gamma_thelodica',67),

('def_elitet4_gamma_medium_driller', 'def_named3_medium_driller', 1),
('def_elitet4_gamma_medium_driller','def_material_boss_gamma_pelistal',134),
('def_elitet4_gamma_medium_driller','def_material_boss_gamma_nuimqol',134),
('def_elitet4_gamma_medium_driller','def_material_boss_gamma_thelodica',134),

('def_elitet4_gamma_small_harvester', 'def_named3_small_harvester', 1),
('def_elitet4_gamma_small_harvester','def_material_boss_gamma_pelistal',67),
('def_elitet4_gamma_small_harvester','def_material_boss_gamma_nuimqol',67),
('def_elitet4_gamma_small_harvester','def_material_boss_gamma_thelodica',67),

('def_elitet4_gamma_medium_harvester', 'def_named3_medium_harvester', 1),
('def_elitet4_gamma_medium_harvester','def_material_boss_gamma_pelistal',134),
('def_elitet4_gamma_medium_harvester','def_material_boss_gamma_nuimqol',134),
('def_elitet4_gamma_medium_harvester','def_material_boss_gamma_thelodica',134);



PRINT N'UPSERT [entitydefaults] identity insert ON';
SET IDENTITY_INSERT [dbo].[entitydefaults] ON;
MERGE [dbo].[entitydefaults] e USING #ENTITYDEF d
ON e.definition = d.def
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
    THEN INSERT (definition, definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel) VALUES
	(def,defName,1,attrFlags,catFlags,genxyOptStr,'elite module',1,cargoVolume,massOfModule,0,100,defName+'_desc',1,techType,techLevel);

PRINT N'UPSERT  cts into [entitydefaults]';
MERGE [dbo].[entitydefaults] e USING #CTS d
ON e.definition = d.def
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
		descriptiontoken='calibration_program_desc'
WHEN NOT MATCHED
    THEN INSERT (definition, definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel) VALUES
	(def,defName,1,attrFlags,catFlags,genxyOptStr,'elite module ct',1,cargoVolume,massOfModule,0,100,'calibration_program_desc',1,techType,techLevel);

PRINT N'UPSERT  ct capsules into [entitydefaults]';
MERGE [dbo].[entitydefaults] e USING #CTS_CAPSULES d
ON e.definition = d.def
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
		descriptiontoken='elite_ct_capsule_desc'
WHEN NOT MATCHED
    THEN INSERT (definition, definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel) VALUES
	(def,defName,1,attrFlags,catFlags,genxyOptStr,'elite module ct capsule',1,cargoVolume,massOfModule,0,100,'elite_ct_capsule_desc',1,techType,techLevel);

PRINT N'UPSERT  new boss material into [entitydefaults]';
MERGE [dbo].[entitydefaults] e USING #MATERIALDEF d
ON e.definition = d.def
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
    THEN INSERT (definition, definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel) VALUES
	(def,defName,1,attrFlags,catFlags,genxyOptStr,'elite module material',1,cargoVolume,massOfModule,0,100,defName+'_desc',1,techType,techLevel);

SET IDENTITY_INSERT [dbo].[entitydefaults] OFF;
PRINT N'[entitydefaults] insert/updates done - identity insert off';

PRINT N'DELETE [aggregatevalues] (0 if first run)';
DELETE FROM aggregatevalues WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #STATS));
PRINT N'UPSERT [aggregatevalues]';
MERGE [dbo].[aggregatevalues] v USING #STATS s
ON v.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=s.defName) AND
v.field = (SELECT TOP 1 id FROM aggregatefields WHERE name=s.fieldName)
WHEN MATCHED
    THEN UPDATE SET
		v.value=s.fieldValue
WHEN NOT MATCHED
    THEN INSERT (definition, field, value) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=s.defName),
	(SELECT TOP 1 id FROM aggregatefields WHERE name=s.fieldName),
	s.fieldValue);

PRINT N'UPSERT [enablerextensions]';
MERGE [dbo].[enablerextensions] e USING #SKILLS s
ON e.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=s.defName) AND
e.extensionid = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname=s.extName)
WHEN MATCHED
    THEN UPDATE SET
		e.extensionlevel=s.extLevel
WHEN NOT MATCHED
    THEN INSERT (definition, extensionid, extensionlevel) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=s.defName),
	(SELECT TOP 1 extensionid FROM extensions WHERE extensionname=s.extName),
	s.extLevel);

PRINT N'UPSERT [dynamiccalibrationtemplates]';
MERGE [dbo].[dynamiccalibrationtemplates] t USING #CT_RELATE c
ON t.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=c.ctName)
WHEN MATCHED
    THEN UPDATE SET
		materialefficiency=1,
		timeefficiency=1,
		targetdefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=c.defName)
WHEN NOT MATCHED
    THEN INSERT (definition, materialefficiency, timeefficiency, targetdefinition) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=c.ctName),
	1,1,
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=c.defName));

PRINT N'UPSERT [calibrationtemplateitems]';
MERGE [dbo].[calibrationtemplateitems] t USING #CT_RELATE c
ON t.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=c.capName)
WHEN MATCHED
    THEN UPDATE SET
		targetdefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=c.ctName)
WHEN NOT MATCHED
    THEN INSERT (definition, targetdefinition) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=c.capName),
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=c.ctName));

PRINT N'UPSERT [components]';
MERGE [dbo].[components] c USING #INDY i
ON c.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=i.defName) AND
c.componentdefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=i.commodityName) 
WHEN MATCHED
    THEN UPDATE SET
		componentamount = i.amount
WHEN NOT MATCHED
    THEN INSERT (definition, componentdefinition, componentamount) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=i.defName),
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=i.commodityName),
	i.amount);

PRINT N'UPSERT [itemshop]';
MERGE [dbo].[itemshop] shop USING #SHOPENTRIES e
ON shop.targetdefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=e.defName)
AND presetid = @tmShops
WHEN MATCHED
    THEN UPDATE SET
		presetid=@tmShops,
		targetamount=1,
		unicoin=e.unitokenPrice,
		asicoin=e.thelodicatokenPrice,
		icscoin=e.nuimqoltokenPrice,
		tmcoin=e.pelistaltokenPrice,
		credit=e.nicPrice
WHEN NOT MATCHED
    THEN INSERT (presetid, targetdefinition, targetamount, tmcoin, icscoin, asicoin, credit, unicoin, globallimit, purchasecount, standing) VALUES
	(@tmShops, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=e.defName), 1, e.pelistaltokenPrice, e.nuimqoltokenPrice, e.thelodicatokenPrice, e.nicPrice, e.unitokenPrice, NULL, 1, 0);


DROP TABLE IF EXISTS #STATS;
DROP TABLE IF EXISTS #ENTITYDEF;
DROP TABLE IF EXISTS #MATERIALDEF;
DROP TABLE IF EXISTS #CT_RELATE;
DROP TABLE IF EXISTS #CTS;
DROP TABLE IF EXISTS #CTS_CAPSULES;
DROP TABLE IF EXISTS #INDY;
DROP TABLE IF EXISTS #SKILLS;
DROP TABLE IF EXISTS #SHOPENTRIES; 
GO
