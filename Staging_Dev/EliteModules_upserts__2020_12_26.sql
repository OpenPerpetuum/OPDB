USE [perpetuumsa]
GO

--------------------------------------------
-- ELITE MODULES for Stronghold zone 70 boss
-- a lot
-- Date modified: 2020/12/26
--------------------------------------------

DECLARE @armorCTCategory  AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_armor_calibration_programs');
DECLARE @engineeringCTCategory AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_engineering_calibration_programs');
DECLARE @ewCTCategory AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_ew_calibration_programs');--ew and electronics
DECLARE @highTierCommodity AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_hightier_commodities');

DECLARE @tmShops AS INT = (SELECT TOP 1 id FROM itemshoppresets WHERE name='tm_preset_pve');
DECLARE @t2smallpriceNIC AS INT = 150000;
DECLARE @t4smallpriceNIC AS INT = 200000;
DECLARE @t2medpriceNIC AS INT = 300000;
DECLARE @t4medpriceNIC AS INT = 400000;

DECLARE @t2smallpriceTOK AS INT = 15;
DECLARE @t4smallpriceTOK AS INT = 20;
DECLARE @t2medpriceTOK AS INT = 30;
DECLARE @t4medpriceTOK AS INT = 40;


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
(5935,'def_elitet2_70_small_armor_repairer',49168,16908559,'#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t2+',1,168.75,3,2),
(5936,'def_elitet4_70_small_armor_repairer',49168,16908559,'#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t4+',1,250,3,4),

(5937,'def_elitet2_70_medium_armor_repairer',81936,33685775,'#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t2+',1.5,506.25,3,2),
(5938,'def_elitet4_70_medium_armor_repairer',81936,33685775,'#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t4+',1.5,800,3,4),

(5939,'def_elitet2_70_small_shield_generator',49432,16843279,'#moduleFlag=i20#tier=$tierlevel_t2+',0.3,135,3,2),
(5940,'def_elitet4_70_small_shield_generator',49432,16843279,'#moduleFlag=i20#tier=$tierlevel_t4+',0.3,230,3,4),

(5941,'def_elitet2_70_medium_shield_generator',82200,33620495,'#moduleFlag=i20#tier=$tierlevel_t2+',0.5,270,3,2),
(5942,'def_elitet4_70_medium_shield_generator',82200,33620495,'#moduleFlag=i20#tier=$tierlevel_t4+',0.5,470,3,4),

(5943,'def_elitet2_70_sensor_booster',16656,66575,'#moduleFlag=i8 #ammoCapacity=i0 #tier=$tierlevel_t2+',0.5,60,3,2),
(5944,'def_elitet4_70_sensor_booster',16656,66575,'#moduleFlag=i8 #ammoCapacity=i0 #tier=$tierlevel_t4+',0.5,100,3,4),

(5945,'def_elitet2_70_webber',720,16844047,'#moduleFlag=i8 #ammoCapacity=i0 #tier=$tierlevel_t2+',0.5,67.5,3,2),
(5946,'def_elitet4_70_webber',720,16844047,'#moduleFlag=i8 #ammoCapacity=i0 #tier=$tierlevel_t4+',0.5,100,3,4),

(5947,'def_elitet2_70_eccm',524288,263439,'#moduleFlag=i8 #ammoCapacity=i0 #tier=$tierlevel_t2+',0.5,67.5,3,2),
(5948,'def_elitet4_70_eccm',524288,263439,'#moduleFlag=i8 #ammoCapacity=i0 #tier=$tierlevel_t4+',0.5,100,3,4),

(5949,'def_elitet2_70_small_core_booster',311316,17367823,'#moduleFlag=i20 #ammoCapacity=ic #ammoType=L70a #tier=$tierlevel_t2+',0.5,67.5,3,2),
(5950,'def_elitet4_70_small_core_booster',311316,17367823,'#moduleFlag=i20 #ammoCapacity=ic #ammoType=L70a #tier=$tierlevel_t4+',0.5,100,3,4),

(5951,'def_elitet2_70_medium_core_booster',344084,34145039,'#moduleFlag=i20 #ammoCapacity=ic #ammoType=L70a #tier=$tierlevel_t2+',1,135,3,2),
(5952,'def_elitet4_70_medium_core_booster',344084,34145039,'#moduleFlag=i20 #ammoCapacity=ic #ammoType=L70a #tier=$tierlevel_t4+',1,200,3,4),

(5953,'def_elitet2_70_tracking_upgrade',524288,459791,'#moduleFlag=i8 #ammoCapacity=i0 #tier=$tierlevel_t2+',0.1,33.75,3,2),
(5954,'def_elitet4_70_tracking_upgrade',524288,459791,'#moduleFlag=i8 #ammoCapacity=i0 #tier=$tierlevel_t4+',0.1,50,3,4);

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
(5955,'def_elitet2_70_small_armor_repairer_cprg',1024,@armorCTCategory,'#tier=$tierlevel_t2+',0.01,0.1,3,2),
(5956,'def_elitet4_70_small_armor_repairer_cprg',1024,@armorCTCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),

(5957,'def_elitet2_70_medium_armor_repairer_cprg',1024,@armorCTCategory,'#tier=$tierlevel_t2+',0.01,0.1,3,2),
(5958,'def_elitet4_70_medium_armor_repairer_cprg',1024,@armorCTCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),

(5959,'def_elitet2_70_small_shield_generator_cprg',1024,@engineeringCTCategory,'#tier=$tierlevel_t2+',0.01,0.1,3,2),
(5960,'def_elitet4_70_small_shield_generator_cprg',1024,@engineeringCTCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),

(5961,'def_elitet2_70_medium_shield_generator_cprg',1024,@engineeringCTCategory,'#tier=$tierlevel_t2+',0.01,0.1,3,2),
(5962,'def_elitet4_70_medium_shield_generator_cprg',1024,@engineeringCTCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),

(5963,'def_elitet2_70_sensor_booster_cprg',1024,@ewCTCategory,'#tier=$tierlevel_t2+',0.01,0.1,3,2),
(5964,'def_elitet4_70_sensor_booster_cprg',1024,@ewCTCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),

(5965,'def_elitet2_70_webber_cprg',1024,@ewCTCategory,'#tier=$tierlevel_t2+',0.01,0.1,3,2),
(5966,'def_elitet4_70_webber_cprg',1024,@ewCTCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),

(5967,'def_elitet2_70_eccm_cprg',1024,@ewCTCategory,'#tier=$tierlevel_t2+',0.01,0.1,3,2),
(5968,'def_elitet4_70_eccm_cprg',1024,@ewCTCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),

(5969,'def_elitet2_70_small_core_booster_cprg',1024,@engineeringCTCategory,'#tier=$tierlevel_t2+',0.01,0.1,3,2),
(5970,'def_elitet4_70_small_core_booster_cprg',1024,@engineeringCTCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),

(5971,'def_elitet2_70_medium_core_booster_cprg',1024,@engineeringCTCategory,'#tier=$tierlevel_t2+',0.01,0.1,3,2),
(5972,'def_elitet4_70_medium_core_booster_cprg',1024,@engineeringCTCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),

(5973,'def_elitet2_70_tracking_upgrade_cprg',1024,@ewCTCategory,'#tier=$tierlevel_t2+',0.01,0.1,3,2),
(5974,'def_elitet4_70_tracking_upgrade_cprg',1024,@ewCTCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4);

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
(5975,'def_elitet2_70_small_armor_repairer_CT_capsule',2052,1179,'#tier=$tierlevel_t2+',0.1,0.1,3,2),
(5976,'def_elitet4_70_small_armor_repairer_CT_capsule',2052,1179,'#tier=$tierlevel_t4+',0.1,0.1,3,4),

(5977,'def_elitet2_70_medium_armor_repairer_CT_capsule',2052,1179,'#tier=$tierlevel_t2+',0.1,0.1,3,2),
(5978,'def_elitet4_70_medium_armor_repairer_CT_capsule',2052,1179,'#tier=$tierlevel_t4+',0.1,0.1,3,4),

(5979,'def_elitet2_70_small_shield_generator_CT_capsule',2052,1179,'#tier=$tierlevel_t2+',0.1,0.1,3,2),
(5980,'def_elitet4_70_small_shield_generator_CT_capsule',2052,1179,'#tier=$tierlevel_t4+',0.1,0.1,3,4),

(5981,'def_elitet2_70_medium_shield_generator_CT_capsule',2052,1179,'#tier=$tierlevel_t2+',0.1,0.1,3,2),
(5982,'def_elitet4_70_medium_shield_generator_CT_capsule',2052,1179,'#tier=$tierlevel_t4+',0.1,0.1,3,4),

(5983,'def_elitet2_70_sensor_booster_CT_capsule',2052,1179,'#tier=$tierlevel_t2+',0.1,0.1,3,2),
(5984,'def_elitet4_70_sensor_booster_CT_capsule',2052,1179,'#tier=$tierlevel_t4+',0.1,0.1,3,4),

(5985,'def_elitet2_70_webber_CT_capsule',2052,1179,'#tier=$tierlevel_t2+',0.1,0.1,3,2),
(5986,'def_elitet4_70_webber_CT_capsule',2052,1179,'#tier=$tierlevel_t4+',0.1,0.1,3,4),

(5987,'def_elitet2_70_eccm_CT_capsule',2052,1179,'#tier=$tierlevel_t2+',0.1,0.1,3,2),
(5988,'def_elitet4_70_eccm_CT_capsule',2052,1179,'#tier=$tierlevel_t4+',0.1,0.1,3,4),

(5989,'def_elitet2_70_small_core_booster_CT_capsule',2052,1179,'#tier=$tierlevel_t2+',0.1,0.1,3,2),
(5990,'def_elitet4_70_small_core_booster_CT_capsule',2052,1179,'#tier=$tierlevel_t4+',0.1,0.1,3,4),

(5991,'def_elitet2_70_medium_core_booster_CT_capsule',2052,1179,'#tier=$tierlevel_t2+',0.1,0.1,3,2),
(5992,'def_elitet4_70_medium_core_booster_CT_capsule',2052,1179,'#tier=$tierlevel_t4+',0.1,0.1,3,4),

(5993,'def_elitet2_70_tracking_upgrade_CT_capsule',2052,1179,'#tier=$tierlevel_t2+',0.1,0.1,3,2),
(5994,'def_elitet4_70_tracking_upgrade_CT_capsule',2052,1179,'#tier=$tierlevel_t4+',0.1,0.1,3,4);

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
(5995,'def_material_boss_z70',2048,@highTierCommodity,NULL,0.01,0.5,NULL,NULL);


DROP TABLE IF EXISTS #SHOPENTRIES;
CREATE TABLE #SHOPENTRIES
(
	defName varchar(100),
	tokenPrice int,
	nicPrice int
);
INSERT INTO #SHOPENTRIES (defName, tokenPrice, nicPrice) VALUES
('def_elitet2_70_small_armor_repairer',@t2smallpriceTOK,@t2smallpriceNIC),
('def_elitet4_70_small_armor_repairer',@t4smallpriceTOK,@t4smallpriceNIC),
('def_elitet2_70_medium_armor_repairer',@t2medpriceTOK,@t2medpriceNIC),
('def_elitet4_70_medium_armor_repairer',@t4medpriceTOK,@t4medpriceNIC),
('def_elitet2_70_small_shield_generator',@t2smallpriceTOK,@t2smallpriceNIC),
('def_elitet4_70_small_shield_generator',@t4smallpriceTOK,@t4smallpriceNIC),
('def_elitet2_70_medium_shield_generator',@t2medpriceTOK,@t2medpriceNIC),
('def_elitet4_70_medium_shield_generator',@t4medpriceTOK,@t4medpriceNIC),
('def_elitet2_70_sensor_booster',@t2medpriceTOK,@t2medpriceNIC),
('def_elitet4_70_sensor_booster',@t4medpriceTOK,@t4medpriceNIC),
('def_elitet2_70_webber',@t2medpriceTOK,@t2medpriceNIC),
('def_elitet4_70_webber',@t4medpriceTOK,@t4medpriceNIC),
('def_elitet2_70_eccm',@t2medpriceTOK,@t2medpriceNIC),
('def_elitet4_70_eccm',@t4medpriceTOK,@t4medpriceNIC),
('def_elitet2_70_small_core_booster',@t2smallpriceTOK,@t2smallpriceNIC),
('def_elitet4_70_small_core_booster',@t4medpriceTOK,@t4smallpriceNIC),
('def_elitet2_70_medium_core_booster',@t2medpriceTOK,@t2medpriceNIC),
('def_elitet4_70_medium_core_booster',@t4medpriceTOK,@t4medpriceNIC),
('def_elitet2_70_tracking_upgrade',@t2medpriceTOK,@t2medpriceNIC),
('def_elitet4_70_tracking_upgrade',@t4medpriceTOK,@t4medpriceNIC);


DROP TABLE IF EXISTS #CT_RELATE;
CREATE TABLE #CT_RELATE 
(
	defName varchar(100),
	ctName varchar(100),
	capName varchar(100)
);
INSERT INTO #CT_RELATE (defName, ctName, capName) VALUES
('def_elitet2_70_small_armor_repairer', 'def_elitet2_70_small_armor_repairer_cprg', 'def_elitet2_70_small_armor_repairer_CT_capsule'),
('def_elitet4_70_small_armor_repairer', 'def_elitet4_70_small_armor_repairer_cprg', 'def_elitet4_70_small_armor_repairer_CT_capsule'),

('def_elitet2_70_medium_armor_repairer', 'def_elitet2_70_small_armor_repairer_cprg', 'def_elitet2_70_medium_armor_repairer_CT_capsule'),
('def_elitet4_70_medium_armor_repairer', 'def_elitet4_70_small_armor_repairer_cprg', 'def_elitet4_70_medium_armor_repairer_CT_capsule'),

('def_elitet2_70_small_shield_generator', 'def_elitet2_70_small_shield_generator_cprg', 'def_elitet2_70_small_shield_generator_CT_capsule'),
('def_elitet4_70_small_shield_generator', 'def_elitet4_70_small_shield_generator_cprg', 'def_elitet4_70_small_shield_generator_CT_capsule'),

('def_elitet2_70_medium_shield_generator', 'def_elitet2_70_medium_shield_generator_cprg', 'def_elitet2_70_medium_shield_generator_CT_capsule'),
('def_elitet4_70_medium_shield_generator', 'def_elitet4_70_medium_shield_generator_cprg', 'def_elitet4_70_medium_shield_generator_CT_capsule'),

('def_elitet2_70_sensor_booster', 'def_elitet2_70_small_armor_repairer_cprg', 'def_elitet2_70_small_armor_repairer_CT_capsule'),
('def_elitet4_70_sensor_booster', 'def_elitet4_70_small_armor_repairer_cprg', 'def_elitet4_70_small_armor_repairer_CT_capsule'),

('def_elitet2_70_webber', 'def_elitet2_70_webber_cprg', 'def_elitet2_70_webber_CT_capsule'),
('def_elitet4_70_webber', 'def_elitet4_70_webber_cprg', 'def_elitet4_70_webber_CT_capsule'),

('def_elitet2_70_eccm', 'def_elitet2_70_eccm_cprg', 'def_elitet2_70_eccm_CT_capsule'),
('def_elitet4_70_eccm', 'def_elitet4_70_eccm_cprg', 'def_elitet4_70_eccm_CT_capsule'),

('def_elitet2_70_small_core_booster', 'def_elitet2_70_small_core_booster_cprg', 'def_elitet2_70_small_core_booster_CT_capsule'),
('def_elitet4_70_small_core_booster', 'def_elitet4_70_small_core_booster_cprg', 'def_elitet4_70_small_core_booster_CT_capsule'),

('def_elitet2_70_medium_core_booster', 'def_elitet2_70_medium_core_booster_cprg', 'def_elitet2_70_medium_core_booster_CT_capsule'),
('def_elitet4_70_medium_core_booster', 'def_elitet4_70_medium_core_booster_cprg', 'def_elitet4_70_medium_core_booster_CT_capsule'),

('def_elitet2_70_tracking_upgrade', 'def_elitet2_70_tracking_upgrade_cprg', 'def_elitet2_70_tracking_upgrade_CT_capsule'),
('def_elitet4_70_tracking_upgrade', 'def_elitet4_70_tracking_upgrade_cprg', 'def_elitet4_70_tracking_upgrade_CT_capsule');


DROP TABLE IF EXISTS #STATS;
CREATE TABLE #STATS(
	defName varchar(100),
	fieldName varchar(100),
	fieldValue float,
);
INSERT INTO #STATS (defName, fieldName, fieldValue) VALUES

('def_elitet2_70_small_armor_repairer','core_recharge_time_modifier',0.97),--3% accum recharge
('def_elitet2_70_small_armor_repairer','armor_repair_amount',65),
('def_elitet2_70_small_armor_repairer','core_usage',54),
('def_elitet2_70_small_armor_repairer','cpu_usage',29),
('def_elitet2_70_small_armor_repairer','cycle_time',13500),
('def_elitet2_70_small_armor_repairer','powergrid_usage',17),

('def_elitet4_70_small_armor_repairer','core_recharge_time_modifier',0.95),--5% accum recharge
('def_elitet4_70_small_armor_repairer','armor_repair_amount',75),
('def_elitet4_70_small_armor_repairer','core_usage',70),
('def_elitet4_70_small_armor_repairer','cpu_usage',40),
('def_elitet4_70_small_armor_repairer','cycle_time',12000),
('def_elitet4_70_small_armor_repairer','powergrid_usage',27),

('def_elitet2_70_medium_armor_repairer','core_recharge_time_modifier',0.975),--2.5% accum recharge
('def_elitet2_70_medium_armor_repairer','armor_repair_amount',200),
('def_elitet2_70_medium_armor_repairer','core_usage',278),
('def_elitet2_70_medium_armor_repairer','cpu_usage',43),
('def_elitet2_70_medium_armor_repairer','cycle_time',13500),
('def_elitet2_70_medium_armor_repairer','powergrid_usage',87),

('def_elitet4_70_medium_armor_repairer','core_recharge_time_modifier',0.96),--4% accum recharge
('def_elitet4_70_medium_armor_repairer','armor_repair_amount',230),
('def_elitet4_70_medium_armor_repairer','core_usage',330),
('def_elitet4_70_medium_armor_repairer','cpu_usage',55),
('def_elitet4_70_medium_armor_repairer','cycle_time',12000),
('def_elitet4_70_medium_armor_repairer','powergrid_usage',110),

('def_elitet2_70_small_shield_generator','core_recharge_time_modifier',0.97),--3% accum recharge
('def_elitet2_70_small_shield_generator','core_usage',1),
('def_elitet2_70_small_shield_generator','cpu_usage',38),
('def_elitet2_70_small_shield_generator','cycle_time',2250),
('def_elitet2_70_small_shield_generator','powergrid_usage',43),
('def_elitet2_70_small_shield_generator','shield_absorbtion',2.1277),--47% ap ratio
('def_elitet2_70_small_shield_generator','shield_radius',5),

('def_elitet4_70_small_shield_generator','core_recharge_time_modifier',0.95),--5% accum recharge
('def_elitet4_70_small_shield_generator','core_usage',1),
('def_elitet4_70_small_shield_generator','cpu_usage',50),
('def_elitet4_70_small_shield_generator','cycle_time',2000),
('def_elitet4_70_small_shield_generator','powergrid_usage',57),
('def_elitet4_70_small_shield_generator','shield_absorbtion',2),
('def_elitet4_70_small_shield_generator','shield_radius',6),

('def_elitet2_70_medium_shield_generator','core_recharge_time_modifier',0.975),--2.5% accum recharge
('def_elitet2_70_medium_shield_generator','core_usage',12.5),
('def_elitet2_70_medium_shield_generator','cpu_usage',57),
('def_elitet2_70_medium_shield_generator','cycle_time',7000),
('def_elitet2_70_medium_shield_generator','powergrid_usage',214),
('def_elitet2_70_medium_shield_generator','shield_absorbtion',2.1277),
('def_elitet2_70_medium_shield_generator','shield_radius',12),

('def_elitet4_70_medium_shield_generator','core_recharge_time_modifier',0.96),--4% accum recharge
('def_elitet4_70_medium_shield_generator','core_usage',12.5),
('def_elitet4_70_medium_shield_generator','cpu_usage',70),
('def_elitet4_70_medium_shield_generator','cycle_time',6500),
('def_elitet4_70_medium_shield_generator','powergrid_usage',285),
('def_elitet4_70_medium_shield_generator','shield_absorbtion',2),
('def_elitet4_70_medium_shield_generator','shield_radius',25),

('def_elitet2_70_sensor_booster','sensor_strength_modifier',17.5), --17.5 sensor_strength
('def_elitet2_70_sensor_booster','core_usage',8),
('def_elitet2_70_sensor_booster','cpu_usage',12),
('def_elitet2_70_sensor_booster','cycle_time',10000),
('def_elitet2_70_sensor_booster','effect_sensor_booster_locking_range_modifier',1.4),
('def_elitet2_70_sensor_booster','effect_sensor_booster_locking_time_modifier',0.75),
('def_elitet2_70_sensor_booster','powergrid_usage',5),

('def_elitet4_70_sensor_booster','sensor_strength_modifier',25), --25 sensor_strength
('def_elitet4_70_sensor_booster','core_usage',12),
('def_elitet4_70_sensor_booster','cpu_usage',19),
('def_elitet4_70_sensor_booster','cycle_time',10000),
('def_elitet4_70_sensor_booster','effect_sensor_booster_locking_range_modifier',1.45),
('def_elitet4_70_sensor_booster','effect_sensor_booster_locking_time_modifier',0.7),
('def_elitet4_70_sensor_booster','powergrid_usage',9),

('def_elitet2_70_webber','locking_time_modifier',0.93),--7% lock time
('def_elitet2_70_webber','core_usage',13),
('def_elitet2_70_webber','cpu_usage',39),
('def_elitet2_70_webber','cycle_time',5000),
('def_elitet2_70_webber','falloff',0),
('def_elitet2_70_webber','optimal_range',12),
('def_elitet2_70_webber','powergrid_usage',13),
('def_elitet2_70_webber','effect_massivness_speed_max_modifier',0.625),

('def_elitet4_70_webber','locking_time_modifier',0.9),--10% lock time
('def_elitet4_70_webber','core_usage',20),
('def_elitet4_70_webber','cpu_usage',50),
('def_elitet4_70_webber','cycle_time',5000),
('def_elitet4_70_webber','falloff',0),
('def_elitet4_70_webber','optimal_range',15),
('def_elitet4_70_webber','powergrid_usage',16),
('def_elitet4_70_webber','effect_massivness_speed_max_modifier',0.55),

('def_elitet2_70_eccm','damage_modifier',1.05),--5% damage (all types)
('def_elitet2_70_eccm','cpu_usage',20),
('def_elitet2_70_eccm','powergrid_usage',13),
('def_elitet2_70_eccm','sensor_strength_modifier',60),

('def_elitet4_70_eccm','damage_modifier',1.07),--7% damage (all types)
('def_elitet4_70_eccm','cpu_usage',27),
('def_elitet4_70_eccm','powergrid_usage',17),
('def_elitet4_70_eccm','sensor_strength_modifier',75),

('def_elitet2_70_small_core_booster','reactor_radiation_modifier',0.945),--5.5% reactor stab
('def_elitet2_70_small_core_booster','core_usage',0),
('def_elitet2_70_small_core_booster','cpu_usage',17),
('def_elitet2_70_small_core_booster','cycle_time',19000),
('def_elitet2_70_small_core_booster','powergrid_usage',43),

('def_elitet4_70_small_core_booster','reactor_radiation_modifier',0.9),--10% reactor stab
('def_elitet4_70_small_core_booster','core_usage',0),
('def_elitet4_70_small_core_booster','cpu_usage',22),
('def_elitet4_70_small_core_booster','cycle_time',17000),
('def_elitet4_70_small_core_booster','powergrid_usage',60),

('def_elitet2_70_medium_core_booster','reactor_radiation_modifier',0.95),--5% reactor stab
('def_elitet2_70_medium_core_booster','core_usage',0),
('def_elitet2_70_medium_core_booster','cpu_usage',22),
('def_elitet2_70_medium_core_booster','cycle_time',10500),
('def_elitet2_70_medium_core_booster','powergrid_usage',214),

('def_elitet4_70_medium_core_booster','reactor_radiation_modifier',0.91),--9% reactor stab
('def_elitet4_70_medium_core_booster','core_usage',0),
('def_elitet4_70_medium_core_booster','cpu_usage',27),
('def_elitet4_70_medium_core_booster','cycle_time',9000),
('def_elitet4_70_medium_core_booster','powergrid_usage',300),

('def_elitet2_70_tracking_upgrade','damage_modifier',1.05),--5% damage (all types)
('def_elitet2_70_tracking_upgrade','cpu_usage',31),
('def_elitet2_70_tracking_upgrade','optimal_range_modifier',1.12),
('def_elitet2_70_tracking_upgrade','powergrid_usage',86),

('def_elitet4_70_tracking_upgrade','damage_modifier',1.07),--7% damage (all types)
('def_elitet4_70_tracking_upgrade','cpu_usage',40),
('def_elitet4_70_tracking_upgrade','optimal_range_modifier',1.15),
('def_elitet4_70_tracking_upgrade','powergrid_usage',125);


DROP TABLE IF EXISTS #SKILLS;
CREATE TABLE #SKILLS (
	defName varchar(100),
	extName varchar(100),
	extLevel float,
);
INSERT INTO #SKILLS (defName, extName, extLevel) VALUES
('def_elitet2_70_small_armor_repairer','ext_repair_systems',6),
('def_elitet4_70_small_armor_repairer','ext_repair_systems',7),
('def_elitet2_70_medium_armor_repairer','ext_repair_systems',6),
('def_elitet4_70_medium_armor_repairer','ext_repair_systems',7),
('def_elitet2_70_small_shield_generator','ext_shield_operation',6),
('def_elitet4_70_small_shield_generator','ext_shield_operation',7),
('def_elitet2_70_medium_shield_generator','ext_shield_upgrades',6),
('def_elitet4_70_medium_shield_generator','ext_shield_upgrades',7),
('def_elitet2_70_sensor_booster','ext_electronics',6),
('def_elitet4_70_sensor_booster','ext_electronics',7),
('def_elitet2_70_webber','ext_propulsion_disabling',6),
('def_elitet4_70_webber','ext_propulsion_disabling',7),
('def_elitet2_70_eccm','ext_electronic_warfare',6),
('def_elitet4_70_eccm','ext_electronic_warfare',7),
('def_elitet2_70_small_core_booster','ext_core_management',6),
('def_elitet4_70_small_core_booster','ext_core_management',7),
('def_elitet2_70_medium_core_booster','ext_core_management',6),
('def_elitet4_70_medium_core_booster','ext_core_management',7),
('def_elitet2_70_tracking_upgrade','ext_long_range_targeting',6),
('def_elitet4_70_tracking_upgrade','ext_long_range_targeting',7);

DROP TABLE IF EXISTS #INDY;
CREATE TABLE #INDY
(
	defName VARCHAR(100),
	commodityName VARCHAR(100),
	amount INT
);
INSERT INTO #INDY (defName, commodityName, amount) VALUES
('def_elitet2_70_small_armor_repairer','def_named3_small_armor_repairer',1),
('def_elitet2_70_small_armor_repairer','def_material_boss_z70',150),

('def_elitet4_70_small_armor_repairer','def_named3_small_armor_repairer',1),
('def_elitet4_70_small_armor_repairer','def_material_boss_z70',200),

('def_elitet2_70_medium_armor_repairer','def_named3_medium_armor_repairer',1),
('def_elitet2_70_medium_armor_repairer','def_material_boss_z70',300),

('def_elitet4_70_medium_armor_repairer','def_named3_medium_armor_repairer',1),
('def_elitet4_70_medium_armor_repairer','def_material_boss_z70',400),

('def_elitet2_70_small_shield_generator','def_named3_small_shield_generator',1),
('def_elitet2_70_small_shield_generator','def_material_boss_z70',150),

('def_elitet4_70_small_shield_generator','def_named3_small_shield_generator',1),
('def_elitet4_70_small_shield_generator','def_material_boss_z70',200),

('def_elitet2_70_medium_shield_generator','def_named3_medium_shield_generator',1),
('def_elitet2_70_medium_shield_generator','def_material_boss_z70',300),

('def_elitet4_70_medium_shield_generator','def_named3_medium_shield_generator',1),
('def_elitet4_70_medium_shield_generator','def_material_boss_z70',400),

('def_elitet2_70_sensor_booster','def_named3_sensor_booster',1),
('def_elitet2_70_sensor_booster','def_material_boss_z70',300),

('def_elitet4_70_sensor_booster','def_named3_sensor_booster',1),
('def_elitet4_70_sensor_booster','def_material_boss_z70',400),

('def_elitet2_70_webber','def_named3_webber',1),
('def_elitet2_70_webber','def_material_boss_z70',300),

('def_elitet4_70_webber','def_named3_webber',1),
('def_elitet4_70_webber','def_material_boss_z70',400),

('def_elitet2_70_eccm','def_named3_eccm',1),
('def_elitet2_70_eccm','def_material_boss_z70',300),

('def_elitet4_70_eccm','def_named3_eccm',1),
('def_elitet4_70_eccm','def_material_boss_z70',400),

('def_elitet2_70_small_core_booster','def_named3_small_core_booster',1),
('def_elitet2_70_small_core_booster','def_material_boss_z70',150),

('def_elitet4_70_small_core_booster','def_named3_small_core_booster',1),
('def_elitet4_70_small_core_booster','def_material_boss_z70',200),

('def_elitet2_70_medium_core_booster','def_named3_medium_core_booster',1),
('def_elitet2_70_medium_core_booster','def_material_boss_z70',300),

('def_elitet4_70_medium_core_booster','def_named3_medium_core_booster',1),
('def_elitet4_70_medium_core_booster','def_material_boss_z70',400),

('def_elitet2_70_tracking_upgrade','def_named3_tracking_upgrade',1),
('def_elitet2_70_tracking_upgrade','def_material_boss_z70',300),

('def_elitet4_70_tracking_upgrade','def_named3_tracking_upgrade',1),
('def_elitet4_70_tracking_upgrade','def_material_boss_z70',400);


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
		descriptiontoken=defName+'_desc'
WHEN NOT MATCHED
    THEN INSERT (definition, definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel) VALUES
	(def,defName,1,attrFlags,catFlags,genxyOptStr,'elite module',1,cargoVolume,massOfModule,0,100,defName+'_desc',1,techType,techLevel);

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
		descriptiontoken=defName+'_desc'
WHEN NOT MATCHED
    THEN INSERT (definition, definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel) VALUES
	(def,defName,1,attrFlags,catFlags,genxyOptStr,'elite module',1,cargoVolume,massOfModule,0,100,defName+'_desc',1,techType,techLevel);

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
	(def,defName,1,attrFlags,catFlags,genxyOptStr,'elite module',1,cargoVolume,massOfModule,0,100,defName+'_desc',1,techType,techLevel);

SET IDENTITY_INSERT [dbo].[entitydefaults] OFF;
PRINT N'[entitydefaults] insert/updates done - identity insert off';


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
WHEN MATCHED
    THEN UPDATE SET
		presetid=@tmShops,
		targetamount=1,
		unicoin=e.tokenPrice,
		credit=e.nicPrice
WHEN NOT MATCHED
    THEN INSERT (presetid, targetdefinition, targetamount, tmcoin, icscoin, asicoin, credit, unicoin, globallimit, purchasecount, standing) VALUES
	(@tmShops, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=e.defName), 1, 0, 0, 0, e.nicPrice, e.tokenPrice, NULL, 1, 0);


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
