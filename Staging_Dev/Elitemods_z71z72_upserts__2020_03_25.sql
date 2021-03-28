USE [perpetuumsa]
GO
SET NOEXEC ON;
--------------------------------------------
-- ELITE MODULES for Stronghold zone 71 and 72 bosses
-- a lot
-- Date modified: 2021/03/25
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
(6042,'def_elitet2_72_small_armor_repairer',49168,16908559,'#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t2+',1,168.75,3,2),
(6043,'def_elitet4_72_small_armor_repairer',49168,16908559,'#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t4+',1,250,3,4),

(6044,'def_elitet2_72_medium_armor_repairer',81936,33685775,'#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t2+',1.5,506.25,3,2),
(6045,'def_elitet4_72_medium_armor_repairer',81936,33685775,'#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t4+',1.5,800,3,4),

(6046,'def_elitet2_71_small_shield_generator',49432,16843279,'#moduleFlag=i20#tier=$tierlevel_t2+',0.3,135,3,2),
(6047,'def_elitet4_71_small_shield_generator',49432,16843279,'#moduleFlag=i20#tier=$tierlevel_t4+',0.3,230,3,4),

(6048,'def_elitet2_71_medium_shield_generator',82200,33620495,'#moduleFlag=i20#tier=$tierlevel_t2+',0.5,270,3,2),
(6049,'def_elitet4_71_medium_shield_generator',82200,33620495,'#moduleFlag=i20#tier=$tierlevel_t4+',0.5,470,3,4),
--geoscanner
(6050,'def_elitet2_71_mining_probe_module',2359320,329231,'#moduleFlag=i8 #ammoCapacity=ia #ammoType=L90a #tier=$tierlevel_t2+',0.5,135,3,2),
(6051,'def_elitet4_71_mining_probe_module',2359320,329231,'#moduleFlag=i8 #ammoCapacity=ia #ammoType=L90a #tier=$tierlevel_t4+',0.5,200,3,4),

(6052,'def_elitet2_72_damage_mod_projectile',524292,33883919,'#moduleFlag=i8 #tier=$tierlevel_t2+',0.5,75,3,2),
(6053,'def_elitet4_72_damage_mod_projectile',524292,33883919,'#moduleFlag=i8 #tier=$tierlevel_t4+',0.5,125,3,4),
--LWF
(6054,'def_elitet2_72_mass_reductor',524320,327951,'#moduleFlag=i20 #tier=$tierlevel_t2+',0.5,1.5,3,2),
(6055,'def_elitet4_72_mass_reductor',524320,327951,'#moduleFlag=i20 #tier=$tierlevel_t4+',0.5,2,3,4),
--evasive
(6056,'def_elitet2_71_maneuvering_upgrade',524300,656143,'#moduleFlag=i20 #tier=$tierlevel_t2+',0.5,17,3,2),
(6057,'def_elitet4_71_maneuvering_upgrade',524300,656143,'#moduleFlag=i20 #tier=$tierlevel_t4+',0.5,35,3,4);



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
(6058,'def_elitet2_72_small_armor_repairer_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t2+',0.01,0.1,3,2),
(6059,'def_elitet4_72_small_armor_repairer_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),

(6060,'def_elitet2_72_medium_armor_repairer_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t2+',0.01,0.1,3,2),
(6061,'def_elitet4_72_medium_armor_repairer_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),

(6062,'def_elitet2_71_small_shield_generator_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t2+',0.01,0.1,3,2),
(6063,'def_elitet4_71_small_shield_generator_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),

(6064,'def_elitet2_71_medium_shield_generator_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t2+',0.01,0.1,3,2),
(6065,'def_elitet4_71_medium_shield_generator_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),

(6066,'def_elitet2_71_mining_probe_module_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t2+',0.01,0.1,3,2),
(6067,'def_elitet4_71_mining_probe_module_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),

(6068,'def_elitet2_72_damage_mod_projectile_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t2+',0.01,0.1,3,2),
(6069,'def_elitet4_72_damage_mod_projectile_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),

(6070,'def_elitet2_72_mass_reductor_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t2+',0.01,0.1,3,2),
(6071,'def_elitet4_72_mass_reductor_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),

(6072,'def_elitet2_71_maneuvering_upgrade_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t2+',0.01,0.1,3,2),
(6073,'def_elitet4_71_maneuvering_upgrade_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4);

DECLARE @ArmorCTCapsule AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_ct_capsules_equipment_armor');
DECLARE @ShieldCTCapsule AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_ct_capsules_equipment_shield');
DECLARE @IndyCTCapsule AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_ct_capsules_equipment_industrial');
DECLARE @WeaponCTCapsule AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_ct_capsules_equipment_weapons');
DECLARE @EngineeringCTCapsule AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_ct_capsules_equipment_engineering');

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
(6074,'def_elitet2_72_small_armor_repairer_CT_capsule',2052,@ArmorCTCapsule,'#tier=$tierlevel_t2+',0.1,0.1,3,2),
(6075,'def_elitet4_72_small_armor_repairer_CT_capsule',2052,@ArmorCTCapsule,'#tier=$tierlevel_t4+',0.1,0.1,3,4),

(6076,'def_elitet2_72_medium_armor_repairer_CT_capsule',2052,@ArmorCTCapsule,'#tier=$tierlevel_t2+',0.1,0.1,3,2),
(6077,'def_elitet4_72_medium_armor_repairer_CT_capsule',2052,@ArmorCTCapsule,'#tier=$tierlevel_t4+',0.1,0.1,3,4),

(6078,'def_elitet2_71_small_shield_generator_CT_capsule',2052,@ShieldCTCapsule,'#tier=$tierlevel_t2+',0.1,0.1,3,2),
(6079,'def_elitet4_71_small_shield_generator_CT_capsule',2052,@ShieldCTCapsule,'#tier=$tierlevel_t4+',0.1,0.1,3,4),

(6080,'def_elitet2_71_medium_shield_generator_CT_capsule',2052,@ShieldCTCapsule,'#tier=$tierlevel_t2+',0.1,0.1,3,2),
(6081,'def_elitet4_71_medium_shield_generator_CT_capsule',2052,@ShieldCTCapsule,'#tier=$tierlevel_t4+',0.1,0.1,3,4),

(6082,'def_elitet2_71_mining_probe_module_CT_capsule',2052,@IndyCTCapsule,'#tier=$tierlevel_t2+',0.1,0.1,3,2),
(6083,'def_elitet4_71_mining_probe_module_CT_capsule',2052,@IndyCTCapsule,'#tier=$tierlevel_t4+',0.1,0.1,3,4),

(6084,'def_elitet2_72_damage_mod_projectile_CT_capsule',2052,@WeaponCTCapsule,'#tier=$tierlevel_t2+',0.1,0.1,3,2),
(6085,'def_elitet4_72_damage_mod_projectile_CT_capsule',2052,@WeaponCTCapsule,'#tier=$tierlevel_t4+',0.1,0.1,3,4),

(6086,'def_elitet2_72_mass_reductor_CT_capsule',2052,@ArmorCTCapsule,'#tier=$tierlevel_t2+',0.1,0.1,3,2),
(6087,'def_elitet4_72_mass_reductor_CT_capsule',2052,@ArmorCTCapsule,'#tier=$tierlevel_t4+',0.1,0.1,3,4),

(6088,'def_elitet2_71_maneuvering_upgrade_CT_capsule',2052,@EngineeringCTCapsule,'#tier=$tierlevel_t2+',0.1,0.1,3,2),
(6089,'def_elitet4_71_maneuvering_upgrade_CT_capsule',2052,@EngineeringCTCapsule,'#tier=$tierlevel_t4+',0.1,0.1,3,4);

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
(6040,'def_material_boss_z71',2048,@dataShardCat,NULL,0.01,0.5,NULL,NULL),
(6041,'def_material_boss_z72',2048,@dataShardCat,NULL,0.01,0.5,NULL,NULL);


DROP TABLE IF EXISTS #SHOPENTRIES;
CREATE TABLE #SHOPENTRIES
(
	defName varchar(100),
	tokenPrice int,
	nicPrice int
);
INSERT INTO #SHOPENTRIES (defName, tokenPrice, nicPrice) VALUES
('def_elitet2_72_small_armor_repairer_CT_capsule',@t2smallpriceTOK,@t2smallpriceNIC),
('def_elitet4_72_small_armor_repairer_CT_capsule',@t4smallpriceTOK,@t4smallpriceNIC),
('def_elitet2_72_medium_armor_repairer_CT_capsule',@t2medpriceTOK,@t2medpriceNIC),
('def_elitet4_72_medium_armor_repairer_CT_capsule',@t4medpriceTOK,@t4medpriceNIC),
('def_elitet2_71_small_shield_generator_CT_capsule',@t2smallpriceTOK,@t2smallpriceNIC),
('def_elitet4_71_small_shield_generator_CT_capsule',@t4smallpriceTOK,@t4smallpriceNIC),
('def_elitet2_71_medium_shield_generator_CT_capsule',@t2medpriceTOK,@t2medpriceNIC),
('def_elitet4_71_medium_shield_generator_CT_capsule',@t4medpriceTOK,@t4medpriceNIC),
('def_elitet2_71_mining_probe_module_CT_capsule',@t2medpriceTOK,@t2medpriceNIC),
('def_elitet4_71_mining_probe_module_CT_capsule',@t4medpriceTOK,@t4medpriceNIC),
('def_elitet2_72_damage_mod_projectile_CT_capsule',@t2medpriceTOK,@t2medpriceNIC),
('def_elitet4_72_damage_mod_projectile_CT_capsule',@t4medpriceTOK,@t4medpriceNIC),
('def_elitet2_72_mass_reductor_CT_capsule',@t2medpriceTOK,@t2medpriceNIC),
('def_elitet4_72_mass_reductor_CT_capsule',@t4medpriceTOK,@t4medpriceNIC),
('def_elitet2_71_maneuvering_upgrade_CT_capsule',@t2medpriceTOK,@t2medpriceNIC),
('def_elitet4_71_maneuvering_upgrade_CT_capsule',@t4medpriceTOK,@t4medpriceNIC);


DROP TABLE IF EXISTS #CT_RELATE;
CREATE TABLE #CT_RELATE 
(
	defName varchar(100),
	ctName varchar(100),
	capName varchar(100)
);
INSERT INTO #CT_RELATE (defName, ctName, capName) VALUES
('def_elitet2_72_small_armor_repairer', 'def_elitet2_72_small_armor_repairer_cprg', 'def_elitet2_72_small_armor_repairer_CT_capsule'),
('def_elitet4_72_small_armor_repairer', 'def_elitet4_72_small_armor_repairer_cprg', 'def_elitet4_72_small_armor_repairer_CT_capsule'),

('def_elitet2_72_medium_armor_repairer', 'def_elitet2_72_medium_armor_repairer_cprg', 'def_elitet2_72_medium_armor_repairer_CT_capsule'),
('def_elitet4_72_medium_armor_repairer', 'def_elitet4_72_medium_armor_repairer_cprg', 'def_elitet4_72_medium_armor_repairer_CT_capsule'),

('def_elitet2_71_small_shield_generator', 'def_elitet2_71_small_shield_generator_cprg', 'def_elitet2_71_small_shield_generator_CT_capsule'),
('def_elitet4_71_small_shield_generator', 'def_elitet4_71_small_shield_generator_cprg', 'def_elitet4_71_small_shield_generator_CT_capsule'),

('def_elitet2_71_medium_shield_generator', 'def_elitet2_71_medium_shield_generator_cprg', 'def_elitet2_71_medium_shield_generator_CT_capsule'),
('def_elitet4_71_medium_shield_generator', 'def_elitet4_71_medium_shield_generator_cprg', 'def_elitet4_71_medium_shield_generator_CT_capsule'),

('def_elitet2_71_mining_probe_module', 'def_elitet2_71_mining_probe_module_cprg', 'def_elitet2_71_mining_probe_module_CT_capsule'),
('def_elitet4_71_mining_probe_module', 'def_elitet4_71_mining_probe_module_cprg', 'def_elitet4_71_mining_probe_module_CT_capsule'),

('def_elitet2_72_damage_mod_projectile', 'def_elitet2_72_damage_mod_projectile_cprg', 'def_elitet2_72_damage_mod_projectile_CT_capsule'),
('def_elitet4_72_damage_mod_projectile', 'def_elitet4_72_damage_mod_projectile_cprg', 'def_elitet4_72_damage_mod_projectile_CT_capsule'),

('def_elitet2_72_mass_reductor', 'def_elitet2_72_mass_reductor_cprg', 'def_elitet2_72_mass_reductor_CT_capsule'),
('def_elitet4_72_mass_reductor', 'def_elitet4_72_mass_reductor_cprg', 'def_elitet4_72_mass_reductor_CT_capsule'),

('def_elitet2_71_maneuvering_upgrade', 'def_elitet2_71_maneuvering_upgrade_cprg', 'def_elitet2_71_maneuvering_upgrade_CT_capsule'),
('def_elitet4_71_maneuvering_upgrade', 'def_elitet4_71_maneuvering_upgrade_cprg', 'def_elitet4_71_maneuvering_upgrade_CT_capsule');


DROP TABLE IF EXISTS #STATS;
CREATE TABLE #STATS(
	defName varchar(100),
	fieldName varchar(100),
	fieldValue float,
);
INSERT INTO #STATS (defName, fieldName, fieldValue) VALUES

('def_elitet2_72_small_armor_repairer','armor_max',175),--hp
('def_elitet2_72_small_armor_repairer','armor_repair_amount',65),
('def_elitet2_72_small_armor_repairer','core_usage',54),
('def_elitet2_72_small_armor_repairer','cpu_usage',29),
('def_elitet2_72_small_armor_repairer','cycle_time',13500),
('def_elitet2_72_small_armor_repairer','powergrid_usage',17),

('def_elitet4_72_small_armor_repairer','armor_max',225),--hp
('def_elitet4_72_small_armor_repairer','armor_repair_amount',75),
('def_elitet4_72_small_armor_repairer','core_usage',70),
('def_elitet4_72_small_armor_repairer','cpu_usage',40),
('def_elitet4_72_small_armor_repairer','cycle_time',12000),
('def_elitet4_72_small_armor_repairer','powergrid_usage',27),

('def_elitet2_72_medium_armor_repairer','armor_max',575),--hp
('def_elitet2_72_medium_armor_repairer','armor_repair_amount',200),
('def_elitet2_72_medium_armor_repairer','core_usage',278),
('def_elitet2_72_medium_armor_repairer','cpu_usage',43),
('def_elitet2_72_medium_armor_repairer','cycle_time',13500),
('def_elitet2_72_medium_armor_repairer','powergrid_usage',87),

('def_elitet4_72_medium_armor_repairer','armor_max',675),--hp
('def_elitet4_72_medium_armor_repairer','armor_repair_amount',230),
('def_elitet4_72_medium_armor_repairer','core_usage',330),
('def_elitet4_72_medium_armor_repairer','cpu_usage',55),
('def_elitet4_72_medium_armor_repairer','cycle_time',12000),
('def_elitet4_72_medium_armor_repairer','powergrid_usage',110),

('def_elitet2_71_small_shield_generator','signature_radius',-0.2),-- -0.2m srf area
('def_elitet2_71_small_shield_generator','core_usage',1),
('def_elitet2_71_small_shield_generator','cpu_usage',38),
('def_elitet2_71_small_shield_generator','cycle_time',2250),
('def_elitet2_71_small_shield_generator','powergrid_usage',43),
('def_elitet2_71_small_shield_generator','shield_absorbtion',2.1277),--47% ap ratio
('def_elitet2_71_small_shield_generator','shield_radius',5),

('def_elitet4_71_small_shield_generator','signature_radius',-0.3),-- -0.3m srf area
('def_elitet4_71_small_shield_generator','core_usage',1),
('def_elitet4_71_small_shield_generator','cpu_usage',50),
('def_elitet4_71_small_shield_generator','cycle_time',2000),
('def_elitet4_71_small_shield_generator','powergrid_usage',57),
('def_elitet4_71_small_shield_generator','shield_absorbtion',2),
('def_elitet4_71_small_shield_generator','shield_radius',6),

('def_elitet2_71_medium_shield_generator','signature_radius',-0.4), -- -0.4m srf area
('def_elitet2_71_medium_shield_generator','core_usage',12.5),
('def_elitet2_71_medium_shield_generator','cpu_usage',57),
('def_elitet2_71_medium_shield_generator','cycle_time',7000),
('def_elitet2_71_medium_shield_generator','powergrid_usage',214),
('def_elitet2_71_medium_shield_generator','shield_absorbtion',2.1277),
('def_elitet2_71_medium_shield_generator','shield_radius',12),

('def_elitet4_71_medium_shield_generator','signature_radius',-0.6), -- -0.6m srf area
('def_elitet4_71_medium_shield_generator','core_usage',12.5),
('def_elitet4_71_medium_shield_generator','cpu_usage',70),
('def_elitet4_71_medium_shield_generator','cycle_time',6500),
('def_elitet4_71_medium_shield_generator','powergrid_usage',285),
('def_elitet4_71_medium_shield_generator','shield_absorbtion',2),
('def_elitet4_71_medium_shield_generator','shield_radius',25),

('def_elitet2_71_maneuvering_upgrade','armor_max_modifier',1.03), -- 3% armor hp
('def_elitet2_71_maneuvering_upgrade','cpu_usage',19),
('def_elitet2_71_maneuvering_upgrade','powergrid_usage',21),
('def_elitet2_71_maneuvering_upgrade','signature_radius',-1.00),
('def_elitet2_71_maneuvering_upgrade','massiveness',0.05),

('def_elitet4_71_maneuvering_upgrade','armor_max_modifier',1.05), -- 3% armor hp
('def_elitet4_71_maneuvering_upgrade','cpu_usage',29),
('def_elitet4_71_maneuvering_upgrade','powergrid_usage',28),
('def_elitet4_71_maneuvering_upgrade','signature_radius',-1.15),
('def_elitet4_71_maneuvering_upgrade','massiveness',0.075),

('def_elitet2_72_mass_reductor','signature_radius',-0.2), -- -0.2m
('def_elitet2_72_mass_reductor','cpu_usage',5),
('def_elitet2_72_mass_reductor','powergrid_usage',2),
('def_elitet2_72_mass_reductor','speed_max_modifier',1.19),
('def_elitet2_72_mass_reductor','massiveness',-0.2),

('def_elitet4_72_mass_reductor','signature_radius',-0.3), -- -0.3m
('def_elitet4_72_mass_reductor','cpu_usage',7),
('def_elitet4_72_mass_reductor','powergrid_usage',3),
('def_elitet4_72_mass_reductor','speed_max_modifier',1.25),
('def_elitet4_72_mass_reductor','massiveness',-0.25),

('def_elitet2_71_mining_probe_module','stealth_strength',10), -- 10 masking
('def_elitet2_71_mining_probe_module','core_usage',45),
('def_elitet2_71_mining_probe_module','cpu_usage',38),
('def_elitet2_71_mining_probe_module','cycle_time',15000),
('def_elitet2_71_mining_probe_module','powergrid_usage',43),
('def_elitet2_71_mining_probe_module','mining_probe_accuracy',0.6),

('def_elitet4_71_mining_probe_module','stealth_strength',17.5), -- 17.5 masking
('def_elitet4_71_mining_probe_module','core_usage',90),
('def_elitet4_71_mining_probe_module','cpu_usage',60),
('def_elitet4_71_mining_probe_module','cycle_time',10000),
('def_elitet4_71_mining_probe_module','powergrid_usage',53),
('def_elitet4_71_mining_probe_module','mining_probe_accuracy',0.7),

('def_elitet2_72_damage_mod_projectile','projectile_optimal_range_modifier',1.015), -- 1.5% optimal
('def_elitet2_72_damage_mod_projectile','projectile_falloff_modifier',1.03), --3% falloff
('def_elitet2_72_damage_mod_projectile','cpu_usage',13),
('def_elitet2_72_damage_mod_projectile','powergrid_usage',4),
('def_elitet2_72_damage_mod_projectile','damage_projectile_modifier',0.19),

('def_elitet2_72_damage_mod_projectile','projectile_optimal_range_modifier',1.025), -- 2.5% optimal
('def_elitet2_72_damage_mod_projectile','projectile_falloff_modifier',1.05),--5% falloff
('def_elitet4_72_damage_mod_projectile','cpu_usage',16),
('def_elitet4_72_damage_mod_projectile','powergrid_usage',5),
('def_elitet4_72_damage_mod_projectile','damage_projectile_modifier',0.25),




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
('def_elitet2_70_small_armor_repairer','def_named1_small_armor_repairer',1),
('def_elitet2_70_small_armor_repairer','def_material_boss_z70',150),

('def_elitet4_70_small_armor_repairer','def_named3_small_armor_repairer',1),
('def_elitet4_70_small_armor_repairer','def_material_boss_z70',200),

('def_elitet2_70_medium_armor_repairer','def_named1_medium_armor_repairer',1),
('def_elitet2_70_medium_armor_repairer','def_material_boss_z70',300),

('def_elitet4_70_medium_armor_repairer','def_named3_medium_armor_repairer',1),
('def_elitet4_70_medium_armor_repairer','def_material_boss_z70',400),

('def_elitet2_70_small_shield_generator','def_named1_small_shield_generator',1),
('def_elitet2_70_small_shield_generator','def_material_boss_z70',150),

('def_elitet4_70_small_shield_generator','def_named3_small_shield_generator',1),
('def_elitet4_70_small_shield_generator','def_material_boss_z70',200),

('def_elitet2_70_medium_shield_generator','def_named1_medium_shield_generator',1),
('def_elitet2_70_medium_shield_generator','def_material_boss_z70',300),

('def_elitet4_70_medium_shield_generator','def_named3_medium_shield_generator',1),
('def_elitet4_70_medium_shield_generator','def_material_boss_z70',400),

('def_elitet2_70_sensor_booster','def_named1_sensor_booster',1),
('def_elitet2_70_sensor_booster','def_material_boss_z70',300),

('def_elitet4_70_sensor_booster','def_named3_sensor_booster',1),
('def_elitet4_70_sensor_booster','def_material_boss_z70',400),

('def_elitet2_70_webber','def_named1_webber',1),
('def_elitet2_70_webber','def_material_boss_z70',300),

('def_elitet4_70_webber','def_named3_webber',1),
('def_elitet4_70_webber','def_material_boss_z70',400),

('def_elitet2_70_eccm','def_named1_eccm',1),
('def_elitet2_70_eccm','def_material_boss_z70',300),

('def_elitet4_70_eccm','def_named3_eccm',1),
('def_elitet4_70_eccm','def_material_boss_z70',400),

('def_elitet2_70_small_core_booster','def_named1_small_core_booster',1),
('def_elitet2_70_small_core_booster','def_material_boss_z70',150),

('def_elitet4_70_small_core_booster','def_named3_small_core_booster',1),
('def_elitet4_70_small_core_booster','def_material_boss_z70',200),

('def_elitet2_70_medium_core_booster','def_named1_medium_core_booster',1),
('def_elitet2_70_medium_core_booster','def_material_boss_z70',300),

('def_elitet4_70_medium_core_booster','def_named3_medium_core_booster',1),
('def_elitet4_70_medium_core_booster','def_material_boss_z70',400),

('def_elitet2_70_tracking_upgrade','def_named1_tracking_upgrade',1),
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
		descriptiontoken='calibration_program_desc'
WHEN NOT MATCHED
    THEN INSERT (definition, definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel) VALUES
	(def,defName,1,attrFlags,catFlags,genxyOptStr,'elite module',1,cargoVolume,massOfModule,0,100,'calibration_program_desc',1,techType,techLevel);

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
	(def,defName,1,attrFlags,catFlags,genxyOptStr,'elite module',1,cargoVolume,massOfModule,0,100,'elite_ct_capsule_desc',1,techType,techLevel);

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
