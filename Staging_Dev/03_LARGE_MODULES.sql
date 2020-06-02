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
('def_named1_large_armor_plate_pr', 655360, 50397455, 4, 7200, 2, 2, '#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t2_pr'),
('def_named2_large_armor_plate_pr', 655360, 50397455, 4, 9000, 2, 3, '#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t3_pr'),
('def_named3_large_armor_plate_pr', 655360, 50397455, 4, 10050, 2, 4, '#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t4_pr'),
--
('def_named1_large_armor_repairer_pr', 147472, 50462991, 3, 1350, 2, 2, '#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t2_pr'),
('def_named2_large_armor_repairer_pr', 147472, 50462991, 3, 1500, 2, 3, '#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t3_pr'),
('def_named3_large_armor_repairer_pr', 147472, 50462991, 3, 1600, 2, 4, '#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t4_pr'),
--
('def_named1_large_shield_generator_pr', 147736, 50397711, 1, 720, 2, 2, '#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t2_pr'),
('def_named2_large_shield_generator_pr', 147736, 50397711, 1, 880, 2, 3, '#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t3_pr'),
('def_named3_large_shield_generator_pr', 147736, 50397711, 1, 940, 2, 4, '#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t4_pr'),
--
('def_named1_large_core_battery_pr', 655364, 50856719, 3, 2700, 2, 2, '#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t2_pr'),
('def_named2_large_core_battery_pr', 655364, 50856719, 3, 3000, 2, 3, '#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t3_pr'),
('def_named3_large_core_battery_pr', 655364, 50856719, 3, 3000, 2, 4, '#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t4_pr'),
--
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
('def_standard_large_shield_generator', 'core_usage', 60),
('def_standard_large_shield_generator', 'shield_absorbtion', 1.8181),
('def_standard_large_shield_generator', 'shield_radius', 30),
('def_standard_large_shield_generator', 'cycle_time', 10000),
--
('def_named1_large_shield_generator', 'cpu_usage', 300),
('def_named1_large_shield_generator', 'powergrid_usage', 1125),
('def_named1_large_shield_generator', 'core_usage', 50),
('def_named1_large_shield_generator', 'shield_absorbtion', 1.8181),
('def_named1_large_shield_generator', 'shield_radius', 30),
('def_named1_large_shield_generator', 'cycle_time', 9500),
--
('def_named1_large_shield_generator_pr', 'cpu_usage', 300),
('def_named1_large_shield_generator_pr', 'powergrid_usage', 1125),
('def_named1_large_shield_generator_pr', 'core_usage', 50),
('def_named1_large_shield_generator_pr', 'shield_absorbtion', 1.8181),
('def_named1_large_shield_generator_pr', 'shield_radius', 30),
('def_named1_large_shield_generator_pr', 'cycle_time', 9500),
--
('def_named2_large_shield_generator', 'cpu_usage', 335),
('def_named2_large_shield_generator', 'powergrid_usage', 1350),
('def_named2_large_shield_generator', 'core_usage', 55),
('def_named2_large_shield_generator', 'shield_absorbtion', 1.9047),
('def_named2_large_shield_generator', 'shield_radius', 33),
('def_named2_large_shield_generator', 'cycle_time', 7750),
--
('def_named2_large_shield_generator_pr', 'cpu_usage', 335),
('def_named2_large_shield_generator_pr', 'powergrid_usage', 1350),
('def_named2_large_shield_generator_pr', 'core_usage', 55),
('def_named2_large_shield_generator_pr', 'shield_absorbtion', 1.9047),
('def_named2_large_shield_generator_pr', 'shield_radius', 33),
('def_named2_large_shield_generator_pr', 'cycle_time', 7750),
--
('def_named3_large_shield_generator', 'cpu_usage', 350),
('def_named3_large_shield_generator', 'powergrid_usage', 1425),
('def_named3_large_shield_generator', 'core_usage', 55),
('def_named3_large_shield_generator', 'shield_absorbtion', 2),
('def_named3_large_shield_generator', 'shield_radius', 36),
('def_named3_large_shield_generator', 'cycle_time', 6500),
--
('def_named3_large_shield_generator_pr', 'cpu_usage', 350),
('def_named3_large_shield_generator_pr', 'powergrid_usage', 1425),
('def_named3_large_shield_generator_pr', 'core_usage', 55),
('def_named3_large_shield_generator_pr', 'shield_absorbtion', 2),
('def_named3_large_shield_generator_pr', 'shield_radius', 36),
('def_named3_large_shield_generator_pr', 'cycle_time', 6500),
--
('def_standard_large_core_battery', 'cpu_usage', 400),
('def_standard_large_core_battery', 'powergrid_usage', 840),
('def_standard_large_core_battery', 'core_max', 1125),
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
('def_named1_large_armor_plate', 'ext_mechanic', 3),
('def_named1_large_armor_plate_pr', 'ext_mechanic', 3),
('def_named2_large_armor_plate', 'ext_mechanic', 3),
('def_named2_large_armor_plate_pr', 'ext_mechanic', 3),
('def_named3_large_armor_plate', 'ext_mechanic', 3),
('def_named3_large_armor_plate_pr', 'ext_mechanic', 3),
--
('def_standard_large_armor_repairer', 'ext_repair_systems', 3),
('def_named1_large_armor_repairer', 'ext_repair_systems', 3),
('def_named1_large_armor_repairer_pr', 'ext_repair_systems', 3),
('def_named2_large_armor_repairer', 'ext_repair_systems', 3),
('def_named2_large_armor_repairer_pr', 'ext_repair_systems', 3),
('def_named3_large_armor_repairer', 'ext_repair_systems', 3),
('def_named3_large_armor_repairer_pr', 'ext_repair_systems', 3),
--
('def_standard_large_shield_generator', 'ext_shield_operation', 4),
('def_named1_large_shield_generator', 'ext_shield_operation', 4),
('def_named1_large_shield_generator_pr', 'ext_shield_operation', 4),
('def_named2_large_shield_generator', 'ext_shield_operation', 4),
('def_named2_large_shield_generator_pr', 'ext_shield_operation', 4),
('def_named3_large_shield_generator', 'ext_shield_operation', 4),
('def_named3_large_shield_generator_pr', 'ext_shield_operation', 4),

('def_standard_large_shield_generator', 'ext_shield_upgrades', 3),
('def_named1_large_shield_generator', 'ext_shield_upgrades', 3),
('def_named1_large_shield_generator_pr', 'ext_shield_upgrades', 3),
('def_named2_large_shield_generator', 'ext_shield_upgrades', 3),
('def_named2_large_shield_generator_pr', 'ext_shield_upgrades', 3),
('def_named3_large_shield_generator', 'ext_shield_upgrades', 3),
('def_named3_large_shield_generator_pr', 'ext_shield_upgrades', 3),
--
('def_standard_large_core_battery', 'ext_core_management', 4),
('def_named1_large_core_battery', 'ext_core_management', 4),
('def_named1_large_core_battery_pr', 'ext_core_management', 4),
('def_named2_large_core_battery', 'ext_core_management', 4),
('def_named2_large_core_battery_pr', 'ext_core_management', 4),
('def_named3_large_core_battery', 'ext_core_management', 4),
('def_named3_large_core_battery_pr', 'ext_core_management', 4),
--
('def_standard_large_core_booster', 'ext_engineering',5),
('def_named1_large_core_booster', 'ext_engineering', 5),
('def_named1_large_core_booster_pr', 'ext_engineering', 5),
('def_named2_large_core_booster', 'ext_engineering', 5),
('def_named2_large_core_booster_pr', 'ext_engineering', 5),
('def_named3_large_core_booster', 'ext_engineering', 5),
('def_named3_large_core_booster_pr', 'ext_engineering', 5),

('def_standard_large_core_booster', 'ext_energy_systems_operation',3),
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
('def_named1_large_armor_plate','def_named1_large_armor_plate_pr'),
('def_named2_large_armor_plate','def_named2_large_armor_plate_pr'),
('def_named3_large_armor_plate','def_named3_large_armor_plate_pr'),
--
('def_named1_large_armor_repairer','def_named1_large_armor_repairer_pr'),
('def_named2_large_armor_repairer','def_named2_large_armor_repairer_pr'),
('def_named3_large_armor_repairer','def_named3_large_armor_repairer_pr'),
--
('def_named1_large_shield_generator','def_named1_large_shield_generator_pr'),
('def_named2_large_shield_generator','def_named2_large_shield_generator_pr'),
('def_named3_large_shield_generator','def_named3_large_shield_generator_pr'),
--
('def_named1_large_core_battery','def_named1_large_core_battery_pr'),
('def_named2_large_core_battery','def_named2_large_core_battery_pr'),
('def_named3_large_core_battery','def_named3_large_core_battery_pr'),
--
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
('def_standard_large_armor_plate', 'def_standard_large_armor_plate_cprg', 4),
('def_named1_large_armor_plate_pr', 'def_named1_large_armor_plate_cprg', 5),
('def_named2_large_armor_plate_pr', 'def_named2_large_armor_plate_cprg', 6),
('def_named3_large_armor_plate_pr', 'def_named3_large_armor_plate_cprg', 7),
--
('def_standard_large_armor_repairer', 'def_standard_large_armor_repairer_cprg', 5),
('def_named1_large_armor_repairer_pr', 'def_named1_large_armor_repairer_cprg', 6),
('def_named2_large_armor_repairer_pr', 'def_named2_large_armor_repairer_cprg', 7),
('def_named3_large_armor_repairer_pr', 'def_named3_large_armor_repairer_cprg', 8),
--
('def_standard_large_shield_generator', 'def_standard_large_shield_generator_cprg', 5),
('def_named1_large_shield_generator_pr', 'def_named1_large_shield_generator_cprg', 6),
('def_named2_large_shield_generator_pr', 'def_named2_large_shield_generator_cprg', 7),
('def_named3_large_shield_generator_pr', 'def_named3_large_shield_generator_cprg', 8),
--
('def_standard_large_core_battery', 'def_standard_large_core_battery_cprg', 5),
('def_named1_large_core_battery_pr', 'def_named1_large_core_battery_cprg', 6),
('def_named2_large_core_battery_pr', 'def_named2_large_core_battery_cprg', 7),
('def_named3_large_core_battery_pr', 'def_named3_large_core_battery_cprg', 8),
--
('def_standard_large_core_booster', 'def_standard_large_core_booster_cprg', 5),
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