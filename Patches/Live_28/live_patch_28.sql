USE [perpetuumsa]
GO


-------------------------------------------------------------
--PATCH 27: Gamma unblock, turret, production and aura balancing, masker reduction, fuel balancing
--01_turrets_aggvalues_merge__2021_12_03.sql
--01b_turrets_damage_update_2022-04-16.sql
--02_turrets_defconfig_merge__2021_12_04.sql
--03_otherpbs_defconfig_merge__2021_12_04.sql
--04_otherpbs_aggvalues_merge__2021_12_04.sql
--05_effectdefmods_merge_delreinsert__2021_12_04.sql
--06_pbs_updated_fuels_2022_08_04.sql
--40_enable_pbs_extension__2021_10_22.sql
-------------------------------------------------------------

USE [perpetuumsa]
GO

----------------------------------------
-- Turret stats
-- Made a distiction for EW turrets
-- fixed sensor strength
-- Date Modified: 2032/04/123
----------------------------------------

PRINT N'Define all stats and modifiers by tech and turret type';
DROP TABLE IF EXISTS #STATS_BY_TECH;
CREATE TABLE #STATS_BY_TECH(
	tech INT,
	fieldName VARCHAR(128),
	modValue FLOAT
);
INSERT INTO #STATS_BY_TECH (tech, fieldName, modValue) VALUES
(1, 'resist_thermal', 180),
(1, 'resist_kinetic', 180),
(1, 'resist_explosive', 180),
(1, 'resist_chemical', 180),

(2, 'resist_thermal', 240),
(2, 'resist_kinetic', 240),
(2, 'resist_explosive', 240),
(2, 'resist_chemical', 240),

(3, 'resist_thermal', 300),
(3, 'resist_kinetic', 300),
(3, 'resist_explosive', 300),
(3, 'resist_chemical', 300),

(1, 'signature_radius', 12),
(2, 'signature_radius', 18),
(3, 'signature_radius', 30),

(1, 'armor_max', 45000),
(2, 'armor_max', 67500),
(3, 'armor_max', 75000),

(1, 'sensor_strength', 160),
(2, 'sensor_strength', 180),
(3, 'sensor_strength', 200),

(1, 'detection_strength', 125),
(2, 'detection_strength', 125),
(3, 'detection_strength', 125),

(1, 'stealth_strength', 80),
(2, 'stealth_strength', 80),
(3, 'stealth_strength', 80),

(1, 'locking_range_modifier', 1.35),
(2, 'locking_range_modifier', 1.425),
(3, 'locking_range_modifier', 1.50),

(1,'damage_modifier', 0.4),
(2,'damage_modifier', 0.6),
(3,'damage_modifier', 1.0),

(1,'energy_neutralized_amount_modifier', 0.5),
(2,'energy_neutralized_amount_modifier', 0.7),
(3,'energy_neutralized_amount_modifier', 1.0),

(1,'ecm_strength_modifier', 0.85),
(2,'ecm_strength_modifier', 0.9),
(3,'ecm_strength_modifier', 1.0),

(1,'ew_optimal_range_modifier',0.85),
(2,'ew_optimal_range_modifier',0.9),
(3,'ew_optimal_range_modifier',1.0),

(1,'optimal_range_modifier',0.85),
(2,'optimal_range_modifier',0.9),
(3,'optimal_range_modifier',1.0),

(1,'falloff_modifier',1.6),
(2,'falloff_modifier',1.8),
(3,'falloff_modifier',2.0),

(1,'missile_falloff_modifier',1.6),
(2,'missile_falloff_modifier',1.8),
(3,'missile_falloff_modifier',2.0),

(1,'turret_fallof_modifier',1.6),
(2,'turret_fallof_modifier',1.8),
(3,'turret_fallof_modifier',2.0),

(1,'core_max',2500),
(2,'core_max',2500),
(3,'core_max',2500),

-- EW turrets 

(4, 'resist_thermal', 180),
(4, 'resist_kinetic', 180),
(4, 'resist_explosive', 180),
(4, 'resist_chemical', 180),

(5, 'resist_thermal', 240),
(5, 'resist_kinetic', 240),
(5, 'resist_explosive', 240),
(5, 'resist_chemical', 240),

(6, 'resist_thermal', 300),
(6, 'resist_kinetic', 300),
(6, 'resist_explosive', 300),
(6, 'resist_chemical', 300),

(4, 'signature_radius', 12),
(5, 'signature_radius', 18),
(6, 'signature_radius', 30),

(4, 'armor_max', 45000),
(5, 'armor_max', 67500),
(6, 'armor_max', 75000),

(4, 'sensor_strength', 160),
(5, 'sensor_strength', 180),
(6, 'sensor_strength', 200),

(4, 'detection_strength', 135),
(5, 'detection_strength', 135),
(6, 'detection_strength', 135),

(4, 'stealth_strength', 80),
(5, 'stealth_strength', 80),
(6, 'stealth_strength', 80),

(4, 'locking_range_modifier', 1.35),
(5, 'locking_range_modifier', 1.425),
(6, 'locking_range_modifier', 1.50),

(4,'damage_modifier', 0.4),
(5,'damage_modifier', 0.6),
(6,'damage_modifier', 1.0),

(4,'energy_neutralized_amount_modifier', 0.5),
(5,'energy_neutralized_amount_modifier', 0.7),
(6,'energy_neutralized_amount_modifier', 1.0),

(4,'ecm_strength_modifier', 0.85),
(5,'ecm_strength_modifier', 0.9),
(6,'ecm_strength_modifier', 1.0),

(4,'ew_optimal_range_modifier',0.85),
(5,'ew_optimal_range_modifier',0.9),
(6,'ew_optimal_range_modifier',1.0),

(4,'optimal_range_modifier',0.85),
(5,'optimal_range_modifier',0.9),
(6,'optimal_range_modifier',1.0),

(4,'falloff_modifier',1.6),
(5,'falloff_modifier',1.8),
(6,'falloff_modifier',2.0),

(4,'missile_falloff_modifier',1.6),
(5,'missile_falloff_modifier',1.8),
(6,'missile_falloff_modifier',2.0),

(4,'turret_fallof_modifier',1.6),
(5,'turret_fallof_modifier',1.8),
(6,'turret_fallof_modifier',2.0),

(4,'core_max',2500),
(5,'core_max',2500),
(6,'core_max',2500);

DROP TABLE IF EXISTS #TURRETNAME_BY_TECH;
CREATE TABLE #TURRETNAME_BY_TECH(
	defName VARCHAR(128),
	tech INT 
);
INSERT INTO #TURRETNAME_BY_TECH (defName, tech) VALUES
('def_pbs_turret_ew_large', 6),
('def_pbs_turret_ew_medium', 5),
('def_pbs_turret_ew_small', 4),

('def_pbs_turret_laser_large', 3),
('def_pbs_turret_laser_medium', 2),
('def_pbs_turret_laser_small', 1),

('def_pbs_turret_missile_large', 3),
('def_pbs_turret_missile_medium', 2),
('def_pbs_turret_missile_small', 1),

('def_pbs_turret_rail_large', 3),
('def_pbs_turret_rail_medium', 2),
('def_pbs_turret_rail_small', 1);



DROP TABLE IF EXISTS #TURRET_STATS;
CREATE TABLE #TURRET_STATS(
	defName VARCHAR(128),
	fieldName VARCHAR(128),
	modValue FLOAT
);
INSERT INTO #TURRET_STATS (defName, fieldName, modValue)
SELECT t.defName, s.fieldName, s.modValue
FROM #STATS_BY_TECH s
JOIN #TURRETNAME_BY_TECH t ON t.tech=s.tech;

INSERT INTO #TURRET_STATS (defName, fieldName, modValue)
SELECT t.defName+'_capsule', s.fieldName, s.modValue
FROM #STATS_BY_TECH s
JOIN #TURRETNAME_BY_TECH t ON t.tech=s.tech;


PRINT N'Merge all turret stats';
MERGE [dbo].[aggregatevalues] v USING #TURRET_STATS s
ON v.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE s.defName=definitionname) AND
v.field = (SELECT TOP 1 id FROM aggregatefields WHERE name=s.fieldName)
WHEN MATCHED
    THEN UPDATE SET
		v.value=s.modValue
WHEN NOT MATCHED
    THEN INSERT (definition, field, value) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE s.defName=definitionname),
	(SELECT TOP 1 id FROM aggregatefields WHERE name=s.fieldName),
	s.modValue);


DROP TABLE IF EXISTS #STATS_BY_TECH;
DROP TABLE IF EXISTS #TURRET_STATS;
DROP TABLE IF EXISTS #TURRETNAME_BY_TECH;
PRINT N'Turret stats applied';
GO

USE [perpetuumsa]
GO

----------------------------------------
-- update to turrets damage
-- updates the damages for strongohold and pbs
-- modified 2022/04/16
----------------------------------------

DROP TABLE IF EXISTS #AGG_VALS;
CREATE TABLE #AGG_VALS(
	defName VARCHAR(100),
	fieldName VARCHAR(100),
	fieldValue float
);
INSERT INTO #AGG_VALS (defName, fieldName, fieldValue) VALUES
('def_turret_laser', 'damage_modifier', 17.5), --10
('def_turret_railgun', 'damage_modifier', 26); --30


PRINT N'UPDATE AGG VALUES';
MERGE [dbo].[aggregatevalues] a USING #AGG_VALS v
ON a.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=v.defName) AND
a.field = (SELECT TOP 1 id FROM aggregatefields WHERE name=v.fieldName)
WHEN MATCHED
    THEN UPDATE SET
		value=v.fieldValue;


DROP TABLE IF EXISTS #AGG_VALS;
PRINT N'UPDATED TURRET DMG';
GO

USE [perpetuumsa]
GO

------------------------------------------------
-- Turret Def configs 
-- Date modified: 2021/12/04
------------------------------------------------

DROP TABLE IF EXISTS #TURRET_CONFIGS;
CREATE TABLE #TURRET_CONFIGS(
	[definition] [int] NOT NULL,
	[targetdefinition] [int] NULL,
	[item_work_range] [float] NULL,
	[cycle_time] [int] NULL,
	[constructionradius] [int] NULL,
	[transmitradius] [int] NULL,
	[constructionlevelmax] [int] NULL,
	[blockingradius] [int] NULL,
	[chargeamount] [int] NULL,
	[inconnections] [int] NULL,
	[outconnections] [int] NULL,
	[coretransferred] [float] NULL,
	[transferefficiency] [float] NULL,
	[productionupgradeamount] [int] NULL,
	[productionlevel] [int] NULL,
	[coreconsumption] [float] NULL,
	[corekickstartthreshold] [float] NULL,
	[reinforcecountermax] [int] NULL,
	[bandwidthusage] [int] NULL,
	[bandwidthcapacity] [int] NULL,
	[emitradius] [int] NULL,
	[typeexclusiverange] [int] NULL,
	[network_node_range] [int] NULL,
	[hitsize] [float] NULL
);

INSERT INTO #TURRET_CONFIGS (definition,
constructionradius, transmitradius, constructionlevelmax, blockingradius, inconnections, outconnections, coreconsumption, corekickstartthreshold, bandwidthusage, hitsize) VALUES
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_turret_ew_large'),
3, 20, 20, 1, 5, 1, 10, 0.25, 400, 1.4142),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_turret_laser_large'),
3, 20, 20, 1, 5, 1, 10, 0.25, 200, 1.4142),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_turret_missile_large'),
3, 20, 20, 1, 5, 1, 10, 0.25, 200, 1.4142),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_turret_rail_large'),
3, 20, 20, 1, 5, 1, 10, 0.25, 200, 1.4142),

((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_turret_ew_medium'),
3, 20, 15, 1, 4, 1, 10, 0.25, 300, 1.4142),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_turret_laser_medium'),
3, 20, 15, 1, 4, 1, 10, 0.25, 150, 1.4142),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_turret_missile_medium'),
3, 20, 15, 1, 4, 1, 10, 0.25, 150, 1.4142),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_turret_rail_medium'),
3, 20, 15, 1, 4, 1, 10, 0.25, 150, 1.4142),

((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_turret_ew_small'),
3, 20, 10, 1, 3, 1, 10, 0.25, 200, 1.4142),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_turret_laser_small'),
3, 20, 10, 1, 3, 1, 10, 0.25, 100, 1.4142),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_turret_missile_small'),
3, 20, 10, 1, 3, 1, 10, 0.25, 100, 1.4142),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_turret_rail_small'),
3, 20, 10, 1, 3, 1, 10, 0.25, 100, 1.4142);


PRINT N'INSERT CAPSULE DEFCONFIGS';
INSERT INTO #TURRET_CONFIGS (definition,
constructionradius, transmitradius, constructionlevelmax, blockingradius, inconnections, outconnections, coreconsumption, bandwidthusage, hitsize) VALUES
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_turret_ew_large_capsule'),
3, 20, 20, 1, 5, 1, 10, 400, 1.4142),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_turret_laser_large_capsule'),
3, 20, 20, 1, 5, 1, 10, 200, 1.4142),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_turret_missile_large_capsule'),
3, 20, 20, 1, 5, 1, 10, 200, 1.4142),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_turret_rail_large_capsule'),
3, 20, 20, 1, 5, 1, 10, 200, 1.4142),

((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_turret_ew_medium_capsule'),
3, 20, 15, 1, 4, 1, 10, 300, 1.4142),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_turret_laser_medium_capsule'),
3, 20, 15, 1, 4, 1, 10, 150, 1.4142),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_turret_missile_medium_capsule'),
3, 20, 15, 1, 4, 1, 10, 150, 1.4142),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_turret_rail_medium_capsule'),
3, 20, 15, 1, 4, 1, 10, 150, 1.4142),

((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_turret_ew_small_capsule'),
3, 20, 10, 1, 3, 1, 10, 200, 1.4142),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_turret_laser_small_capsule'),
3, 20, 10, 1, 3, 1, 10, 100, 1.4142),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_turret_missile_small_capsule'),
3, 20, 10, 1, 3, 1, 10, 100, 1.4142),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_turret_rail_small_capsule'),
3, 20, 10, 1, 3, 1, 10, 100, 1.4142);



PRINT N'UPSERT [definitionconfig]';
MERGE [dbo].[definitionconfig] cd USING #TURRET_CONFIGS c
ON cd.definition = c.definition
WHEN MATCHED
    THEN UPDATE SET
		item_work_range=c.item_work_range,
		cycle_time=c.cycle_time,
		constructionradius=c.constructionradius,
		transmitradius=c.transmitradius,
		constructionlevelmax=c.constructionlevelmax,
		blockingradius=c.blockingradius,
		chargeamount=c.chargeamount,
		inconnections=c.inconnections,
		outconnections=c.outconnections,
		coretransferred=c.coretransferred,
		transferefficiency=c.transferefficiency,
		productionupgradeamount=c.productionupgradeamount,
		productionlevel=c.productionlevel,
		coreconsumption=c.coreconsumption,
		corekickstartthreshold=c.corekickstartthreshold,
		reinforcecountermax=c.reinforcecountermax,
		bandwidthusage=c.bandwidthusage,
		bandwidthcapacity=c.bandwidthcapacity,
		emitradius=c.emitradius,
		typeexclusiverange=c.typeexclusiverange,
		network_node_range=c.network_node_range,
		hitsize=c.hitsize;


DROP TABLE IF EXISTS #TURRET_CONFIGS;
PRINT N'TURRET DEF CONFIG STATS UPDATED';
GO

USE [perpetuumsa]
GO

------------------------------------------------
-- Turret Def configs 
-- Date modified: 2021/12/04
------------------------------------------------

DROP TABLE IF EXISTS #PBS_CONFIGS;
CREATE TABLE #PBS_CONFIGS(
	[definition] [int] NOT NULL,
	[targetdefinition] [int] NULL,
	[item_work_range] [float] NULL,
	[cycle_time] [int] NULL,
	[constructionradius] [int] NULL,
	[transmitradius] [int] NULL,
	[constructionlevelmax] [int] NULL,
	[blockingradius] [int] NULL,
	[chargeamount] [int] NULL,
	[inconnections] [int] NULL,
	[outconnections] [int] NULL,
	[coretransferred] [float] NULL,
	[transferefficiency] [float] NULL,
	[productionupgradeamount] [int] NULL,
	[productionlevel] [int] NULL,
	[coreconsumption] [float] NULL,
	[corekickstartthreshold] [float] NULL,
	[reinforcecountermax] [int] NULL,
	[bandwidthusage] [int] NULL,
	[bandwidthcapacity] [int] NULL,
	[emitradius] [int] NULL,
	[typeexclusiverange] [int] NULL,
	[network_node_range] [int] NULL,
	[hitsize] [float] NULL
);
PRINT N'REPAIRERS';
INSERT INTO #PBS_CONFIGS (definition,
cycle_time, constructionradius, transmitradius, constructionlevelmax, blockingradius,
chargeamount, inconnections, outconnections, coreconsumption, corekickstartthreshold, bandwidthusage, hitsize) VALUES
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_armor_repairer_large'),
30000, 2, 35, 100, 2, 13500, 2, 5, 60, 0.7, 300, 2.8284),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_armor_repairer_medium'),
30000, 2, 35, 75, 2, 12378, 2, 4, 55, 0.7, 250, 2.8284),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_armor_repairer_small'),
30000, 2, 35, 50, 1, 11250, 2, 3, 50, 0.7, 200, 1.4142);

PRINT N'AURA EMITTERS';
INSERT INTO #PBS_CONFIGS (definition,
cycle_time, constructionradius, transmitradius, constructionlevelmax, blockingradius,
inconnections, outconnections, coreconsumption, corekickstartthreshold, bandwidthusage,
emitradius, hitsize) VALUES
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_aura_emitter_large'),
30000, 2, 25, 100, 1, 5, 0, 20, 0.8, 1500, 1500, 1.4142),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_aura_emitter_medium'),
30000, 2, 25, 75, 1, 4, 0, 15, 0.8, 1250, 1500, 1.4142),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_aura_emitter_small'),
30000, 2, 25, 50, 1, 3, 0, 10, 0.8, 1000, 1500, 1.4142);


PRINT N'CONTROL TOWERS';
INSERT INTO #PBS_CONFIGS (definition,
constructionradius, transmitradius, constructionlevelmax, blockingradius,
inconnections, outconnections, bandwidthusage,
hitsize) VALUES
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_control_tower_large'),
2, 250, 40, 1, 2, 5, 150, 1.4142),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_control_tower_medium'),
2, 225, 30, 1, 2, 4, 125, 1.4142),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_control_tower_small'),
2, 200, 20, 1, 2, 3, 100, 1.4142);


PRINT N'MASKING TOWERS';
INSERT INTO #PBS_CONFIGS (definition,
cycle_time, constructionradius, transmitradius, constructionlevelmax, blockingradius,
inconnections, outconnections, coreconsumption, corekickstartthreshold, bandwidthusage,
emitradius, hitsize) VALUES
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_maskertower_large'),
30000, 2, 30, 100, 1, 2, 0, 12, 0.8, 750, 150, 1.4142),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_maskertower_medium'),
30000, 2, 30, 75, 1, 2, 0, 11, 0.8, 625, 150, 1.4142),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_maskertower_small'),
30000, 2, 30, 50, 1, 2, 0, 10, 0.8, 500, 150, 1.4142);


PRINT N'BOOSTER';
INSERT INTO #PBS_CONFIGS (definition,
cycle_time, constructionradius, transmitradius, constructionlevelmax, blockingradius,
inconnections, outconnections, coreconsumption, corekickstartthreshold, bandwidthusage,
hitsize) VALUES
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_effect_supplier_large'),
30000, 2, 60, 40, 1, 2, 15, 60, 0.8, 450, 1.4142),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_effect_supplier_medium'),
30000, 2, 55, 30, 1, 2, 13, 55, 0.8, 375, 1.4142),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_effect_supplier_small'),
30000, 2, 50, 20, 1, 2, 10, 50, 0.8, 300, 1.4142);


PRINT N'HIGHWAY';
INSERT INTO #PBS_CONFIGS (definition, item_work_range,
cycle_time, constructionradius, transmitradius, constructionlevelmax, blockingradius,
inconnections, outconnections, coretransferred, transferefficiency, coreconsumption, 
corekickstartthreshold, bandwidthusage, emitradius, hitsize) VALUES
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_highwaynode_large'), 5,
30000, 2, 90, 40, 1, 3, 2, 360, 0.96, 30, 0.9, 60, 5, 1.4142),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_highwaynode_medium'), 4,
30000, 2, 75, 30, 1, 2, 1, 330, 0.97, 25, 0.9, 50, 4, 1.4142),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_highwaynode_small'), 3,
30000, 2, 60, 20, 1, 2, 1, 300, 0.95, 20, 0.9, 40, 3, 1.4142);


PRINT N'PRODUCTION BOOSTER';
INSERT INTO #PBS_CONFIGS (definition,
cycle_time, constructionradius, transmitradius, constructionlevelmax, blockingradius,
inconnections, outconnections, productionupgradeamount, coreconsumption, 
corekickstartthreshold, bandwidthusage, hitsize) VALUES
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_production_upgrade_large'),
30000, 1, 45, 40, 1, 2, 1, 80, 60, 0.65, 150, 1.4142),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_production_upgrade_medium'),
30000, 1, 45, 30, 1, 2, 1, 50, 55, 0.65, 125, 1.4142),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_production_upgrade_small'),
30000, 1, 45, 20, 1, 2, 1, 30, 50, 0.65, 100, 1.4142);



PRINT N'DOCKING BASE';
INSERT INTO #PBS_CONFIGS (definition,
cycle_time, constructionradius, transmitradius, constructionlevelmax, blockingradius, 
inconnections, outconnections, reinforcecountermax, bandwidthcapacity, typeexclusiverange, network_node_range,
hitsize) VALUES
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_docking_base_large'),
30000, 11, 75, 1000, 10, 15, 5, 5, 45000, 300, 150, 14.142),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_docking_base_medium'),
30000, 11, 68, 750, 7, 12, 3, 4, 25000, 300, 125, 9.8994),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_docking_base_small'),
30000, 11, 50, 500, 5, 10, 2, 3, 12500, 300, 100, 7.071);

PRINT N'ENERGY STRUCTURES';
INSERT INTO #PBS_CONFIGS (definition,
cycle_time, constructionradius, transmitradius, constructionlevelmax, blockingradius, 
inconnections, outconnections, coretransferred, transferefficiency, bandwidthusage,
hitsize) VALUES
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_core_battery_large'),
30000, 5, 60, 500, 3, 5, 2, 9500, 0.7, 30, 4.2426),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_core_battery_medium'),
30000, 5, 55, 375, 3, 4, 2, 8000, 0.7, 25, 4.2426),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_core_battery_small'),
30000, 5, 50, 250, 3, 3, 2, 7000, 0.7, 20, 4.2426),

((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_core_transmitter_large'),
30000, 2, 25, 20, 1, 2, 5, 1000, 1.0, 150, 1.4142),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_core_transmitter_medium'),
30000, 2, 25, 15, 1, 2, 4, 1125, 0.99, 125, 1.4142),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_core_transmitter_small'),
30000, 2, 25, 10, 1, 2, 4, 1000, 0.98, 100, 1.4142),

((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_XL_core_transmitter_large'),
30000, 2, 50, 40, 1, 2, 3, 6000, 1.0, 90, 1.4142),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_XL_core_transmitter_medium'),
30000, 2, 50, 30, 1, 2, 2, 5250, 0.995, 75, 1.4142),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_XL_core_transmitter_small'),
30000, 2, 50, 20, 1, 2, 2, 4500, 0.99, 60, 1.4142);


PRINT N'REACTOR';
INSERT INTO #PBS_CONFIGS (definition,
cycle_time, constructionradius, transmitradius, constructionlevelmax, blockingradius, 
inconnections, outconnections, coretransferred, transferefficiency, bandwidthusage,
hitsize) VALUES
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_reactor_large'),
30000, 8, 20, 600, 7, 2, 3, 6500, 1.0, 750, 9.8994),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_reactor_medium'),
30000, 8, 20, 450, 5, 2, 2, 5500, 1.0, 625, 7.071),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_reactor_small'),
30000, 8, 20, 300, 5, 2, 2, 4500, 1.0, 500, 7.071);



DROP TABLE IF EXISTS #FACILITY_BY_TECH;
CREATE TABLE #FACILITY_BY_TECH(
	tech int,
	defName varchar(128)
);
INSERT INTO #FACILITY_BY_TECH (tech, defName) VALUES
(3, 'def_pbs_calibration_forge_large'),
(2, 'def_pbs_calibration_forge_medium'),
(1, 'def_pbs_calibration_forge_small'),

(3, 'def_pbs_mill_large'),
(2, 'def_pbs_mill_medium'),
(1, 'def_pbs_mill_small'),

(3, 'def_pbs_prototyper_large'),
(2, 'def_pbs_prototyper_medium'),
(1, 'def_pbs_prototyper_small'),

(3, 'def_pbs_refinery_large'),
(2, 'def_pbs_refinery_medium'),
(1, 'def_pbs_refinery_small'),

(3, 'def_pbs_repair_large'),
(2, 'def_pbs_repair_medium'),
(1, 'def_pbs_repair_small'),

(3, 'def_pbs_reprocessor_large'),
(2, 'def_pbs_reprocessor_medium'),
(1, 'def_pbs_reprocessor_small'),

(3, 'def_pbs_research_kit_forge_large'),
(2, 'def_pbs_research_kit_forge_medium'),
(1, 'def_pbs_research_kit_forge_small'),

(3, 'def_pbs_research_lab_large'),
(2, 'def_pbs_research_lab_medium'),
(1, 'def_pbs_research_lab_small');


PRINT N'CONFIGS FOR ALL FACILITIES';
INSERT INTO #PBS_CONFIGS (definition,
cycle_time, constructionradius, transmitradius, constructionlevelmax, blockingradius,
inconnections, outconnections, coreconsumption, corekickstartthreshold, bandwidthusage,
hitsize, productionlevel)
SELECT (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defName),
30000, 7, 45, 500, 6, 6, 1, 600, 0.65, 1500, 8.4852, 200
FROM #FACILITY_BY_TECH WHERE tech=3;

INSERT INTO #PBS_CONFIGS (definition,
cycle_time, constructionradius, transmitradius, constructionlevelmax, blockingradius,
inconnections, outconnections, coreconsumption, corekickstartthreshold, bandwidthusage,
hitsize, productionlevel)
SELECT (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defName),
30000, 7, 45, 375, 5, 5, 1, 550, 0.65, 1250, 7.071, 165
FROM #FACILITY_BY_TECH WHERE tech=2;

INSERT INTO #PBS_CONFIGS (definition,
cycle_time, constructionradius, transmitradius, constructionlevelmax, blockingradius,
inconnections, outconnections, coreconsumption, corekickstartthreshold, bandwidthusage,
hitsize, productionlevel)
SELECT (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defName),
30000, 7, 45, 250, 4, 4, 1, 500, 0.65, 1000, 5.6568, 130
FROM #FACILITY_BY_TECH WHERE tech=1;


PRINT N'UPSERT [definitionconfig]';
MERGE [dbo].[definitionconfig] cd USING #PBS_CONFIGS c
ON cd.definition = c.definition
WHEN MATCHED
    THEN UPDATE SET
		item_work_range=c.item_work_range,
		cycle_time=c.cycle_time,
		constructionradius=c.constructionradius,
		transmitradius=c.transmitradius,
		constructionlevelmax=c.constructionlevelmax,
		blockingradius=c.blockingradius,
		chargeamount=c.chargeamount,
		inconnections=c.inconnections,
		outconnections=c.outconnections,
		coretransferred=c.coretransferred,
		transferefficiency=c.transferefficiency,
		productionupgradeamount=c.productionupgradeamount,
		productionlevel=c.productionlevel,
		coreconsumption=c.coreconsumption,
		corekickstartthreshold=c.corekickstartthreshold,
		reinforcecountermax=c.reinforcecountermax,
		bandwidthusage=c.bandwidthusage,
		bandwidthcapacity=c.bandwidthcapacity,
		emitradius=c.emitradius,
		typeexclusiverange=c.typeexclusiverange,
		network_node_range=c.network_node_range,
		hitsize=c.hitsize;


PRINT N'UPSERT [definitionconfig] for capsules';
MERGE [dbo].[definitionconfig] cd USING #PBS_CONFIGS c
ON cd.definition = (SELECT TOP 1 definition FROM entitydefaults
	WHERE definitionname=(SELECT TOP 1 definitionname FROM entitydefaults WHERE definition=c.definition)+'_capsule')
WHEN MATCHED
    THEN UPDATE SET
		item_work_range=c.item_work_range,
		cycle_time=c.cycle_time,
		constructionradius=c.constructionradius,
		transmitradius=c.transmitradius,
		constructionlevelmax=c.constructionlevelmax,
		blockingradius=c.blockingradius,
		chargeamount=c.chargeamount,
		inconnections=c.inconnections,
		outconnections=c.outconnections,
		coretransferred=c.coretransferred,
		transferefficiency=c.transferefficiency,
		productionupgradeamount=c.productionupgradeamount,
		productionlevel=c.productionlevel,
		coreconsumption=c.coreconsumption,
		corekickstartthreshold=c.corekickstartthreshold,
		reinforcecountermax=c.reinforcecountermax,
		bandwidthusage=c.bandwidthusage,
		bandwidthcapacity=c.bandwidthcapacity,
		emitradius=c.emitradius,
		typeexclusiverange=c.typeexclusiverange,
		network_node_range=c.network_node_range,
		hitsize=c.hitsize;


DROP TABLE IF EXISTS #PBS_CONFIGS;
DROP TABLE IF EXISTS #FACILITY_BY_TECH;
PRINT N'OTHER PBS CONFIG STATS UPDATED';
GO

USE [perpetuumsa]
GO

-----------------------------------------------
-- All other Base Stats
-- 
-- Date modified: 2021/12/04
-----------------------------------------------

DROP TABLE IF EXISTS #BASE_STATS;
CREATE TABLE #BASE_STATS(
	defName VARCHAR(128),
	fieldName VARCHAR(128),
	modValue FLOAT
);
INSERT INTO #BASE_STATS (defName, fieldName, modValue) VALUES
('def_pbs_armor_repairer_large','stealth_strength',50),
('def_pbs_armor_repairer_large','signature_radius',30),
('def_pbs_armor_repairer_large','resist_thermal',120),
('def_pbs_armor_repairer_large','resist_kinetic',120),
('def_pbs_armor_repairer_large','resist_explosive',120),
('def_pbs_armor_repairer_large','resist_chemical',120),
('def_pbs_armor_repairer_large','core_max',6000),
('def_pbs_armor_repairer_large','armor_max',75000),
('def_pbs_armor_repairer_medium','stealth_strength',50),
('def_pbs_armor_repairer_medium','signature_radius',25),
('def_pbs_armor_repairer_medium','resist_thermal',75),
('def_pbs_armor_repairer_medium','resist_kinetic',75),
('def_pbs_armor_repairer_medium','resist_explosive',75),
('def_pbs_armor_repairer_medium','resist_chemical',75),
('def_pbs_armor_repairer_medium','core_max',5500),
('def_pbs_armor_repairer_medium','armor_max',65000),
('def_pbs_armor_repairer_small','stealth_strength',50),
('def_pbs_armor_repairer_small','signature_radius',20),
('def_pbs_armor_repairer_small','resist_thermal',30),
('def_pbs_armor_repairer_small','resist_kinetic',30),
('def_pbs_armor_repairer_small','resist_explosive',30),
('def_pbs_armor_repairer_small','resist_chemical',30),
('def_pbs_armor_repairer_small','core_max',5000),
('def_pbs_armor_repairer_small','armor_max',50000),
('def_pbs_aura_emitter_large','stealth_strength',50),
('def_pbs_aura_emitter_large','signature_radius',30),
('def_pbs_aura_emitter_large','resist_thermal',120),
('def_pbs_aura_emitter_large','resist_kinetic',120),
('def_pbs_aura_emitter_large','resist_explosive',120),
('def_pbs_aura_emitter_large','resist_chemical',120),
('def_pbs_aura_emitter_large','core_max',45000),
('def_pbs_aura_emitter_large','armor_max',75000),
('def_pbs_aura_emitter_medium','stealth_strength',50),
('def_pbs_aura_emitter_medium','signature_radius',25),
('def_pbs_aura_emitter_medium','resist_thermal',75),
('def_pbs_aura_emitter_medium','resist_kinetic',75),
('def_pbs_aura_emitter_medium','resist_explosive',75),
('def_pbs_aura_emitter_medium','resist_chemical',75),
('def_pbs_aura_emitter_medium','core_max',41250),
('def_pbs_aura_emitter_medium','armor_max',65000),
('def_pbs_aura_emitter_small','stealth_strength',50),
('def_pbs_aura_emitter_small','signature_radius',20),
('def_pbs_aura_emitter_small','resist_thermal',30),
('def_pbs_aura_emitter_small','resist_kinetic',30),
('def_pbs_aura_emitter_small','resist_explosive',30),
('def_pbs_aura_emitter_small','resist_chemical',30),
('def_pbs_aura_emitter_small','core_max',37500),
('def_pbs_aura_emitter_small','armor_max',50000),
('def_pbs_calibration_forge_large','stealth_strength',50),
('def_pbs_calibration_forge_large','signature_radius',120),
('def_pbs_calibration_forge_large','resist_thermal',120),
('def_pbs_calibration_forge_large','resist_kinetic',120),
('def_pbs_calibration_forge_large','resist_explosive',120),
('def_pbs_calibration_forge_large','resist_chemical',120),
('def_pbs_calibration_forge_large','core_max',3000),
('def_pbs_calibration_forge_large','armor_max',300000),
('def_pbs_calibration_forge_medium','stealth_strength',50),
('def_pbs_calibration_forge_medium','signature_radius',65),
('def_pbs_calibration_forge_medium','resist_thermal',75),
('def_pbs_calibration_forge_medium','resist_kinetic',75),
('def_pbs_calibration_forge_medium','resist_explosive',75),
('def_pbs_calibration_forge_medium','resist_chemical',75),
('def_pbs_calibration_forge_medium','core_max',2750),
('def_pbs_calibration_forge_medium','armor_max',250000),
('def_pbs_calibration_forge_small','stealth_strength',50),
('def_pbs_calibration_forge_small','signature_radius',50),
('def_pbs_calibration_forge_small','resist_thermal',30),
('def_pbs_calibration_forge_small','resist_kinetic',30),
('def_pbs_calibration_forge_small','resist_explosive',30),
('def_pbs_calibration_forge_small','resist_chemical',30),
('def_pbs_calibration_forge_small','core_max',2500),
('def_pbs_calibration_forge_small','armor_max',200000),
('def_pbs_control_tower_large','stealth_strength',50),
('def_pbs_control_tower_large','signature_radius',30),
('def_pbs_control_tower_large','resist_thermal',120),
('def_pbs_control_tower_large','resist_kinetic',120),
('def_pbs_control_tower_large','resist_explosive',120),
('def_pbs_control_tower_large','resist_chemical',120),
('def_pbs_control_tower_large','armor_max',75000),
('def_pbs_control_tower_medium','stealth_strength',50),
('def_pbs_control_tower_medium','signature_radius',25),
('def_pbs_control_tower_medium','resist_thermal',75),
('def_pbs_control_tower_medium','resist_kinetic',75),
('def_pbs_control_tower_medium','resist_explosive',75),
('def_pbs_control_tower_medium','resist_chemical',75),
('def_pbs_control_tower_medium','armor_max',65000),
('def_pbs_control_tower_small','stealth_strength',50),
('def_pbs_control_tower_small','signature_radius',20),
('def_pbs_control_tower_small','resist_thermal',30),
('def_pbs_control_tower_small','resist_kinetic',30),
('def_pbs_control_tower_small','resist_explosive',30),
('def_pbs_control_tower_small','resist_chemical',30),
('def_pbs_control_tower_small','armor_max',50000),
('def_pbs_core_battery_large','stealth_strength',50),
('def_pbs_core_battery_large','signature_radius',60),
('def_pbs_core_battery_large','resist_thermal',120),
('def_pbs_core_battery_large','resist_kinetic',120),
('def_pbs_core_battery_large','resist_explosive',120),
('def_pbs_core_battery_large','resist_chemical',120),
('def_pbs_core_battery_large','core_max',19152000),
('def_pbs_core_battery_large','armor_max',75000),
('def_pbs_core_battery_medium','stealth_strength',50),
('def_pbs_core_battery_medium','signature_radius',50),
('def_pbs_core_battery_medium','resist_thermal',75),
('def_pbs_core_battery_medium','resist_kinetic',75),
('def_pbs_core_battery_medium','resist_explosive',75),
('def_pbs_core_battery_medium','resist_chemical',75),
('def_pbs_core_battery_medium','core_max',16128000),
('def_pbs_core_battery_medium','armor_max',65000),
('def_pbs_core_battery_small','stealth_strength',50),
('def_pbs_core_battery_small','signature_radius',40),
('def_pbs_core_battery_small','resist_thermal',30),
('def_pbs_core_battery_small','resist_kinetic',30),
('def_pbs_core_battery_small','resist_explosive',30),
('def_pbs_core_battery_small','resist_chemical',30),
('def_pbs_core_battery_small','core_max',14112000),
('def_pbs_core_battery_small','armor_max',50000),
('def_pbs_core_transmitter_large','stealth_strength',50),
('def_pbs_core_transmitter_large','signature_radius',30),
('def_pbs_core_transmitter_large','resist_thermal',120),
('def_pbs_core_transmitter_large','resist_kinetic',120),
('def_pbs_core_transmitter_large','resist_explosive',120),
('def_pbs_core_transmitter_large','resist_chemical',120),
('def_pbs_core_transmitter_large','core_max',24000),
('def_pbs_core_transmitter_large','armor_max',30000),
('def_pbs_core_transmitter_medium','stealth_strength',50),
('def_pbs_core_transmitter_medium','signature_radius',25),
('def_pbs_core_transmitter_medium','resist_thermal',75),
('def_pbs_core_transmitter_medium','resist_kinetic',75),
('def_pbs_core_transmitter_medium','resist_explosive',75),
('def_pbs_core_transmitter_medium','resist_chemical',75),
('def_pbs_core_transmitter_medium','core_max',21000),
('def_pbs_core_transmitter_medium','armor_max',25000),
('def_pbs_core_transmitter_small','stealth_strength',50),
('def_pbs_core_transmitter_small','signature_radius',20),
('def_pbs_core_transmitter_small','resist_thermal',30),
('def_pbs_core_transmitter_small','resist_kinetic',30),
('def_pbs_core_transmitter_small','resist_explosive',30),
('def_pbs_core_transmitter_small','resist_chemical',30),
('def_pbs_core_transmitter_small','core_max',18000),
('def_pbs_core_transmitter_small','armor_max',20000),
('def_pbs_docking_base_large','stealth_strength',50),
('def_pbs_docking_base_large','signature_radius',150),
('def_pbs_docking_base_large','resist_thermal',120),
('def_pbs_docking_base_large','resist_kinetic',120),
('def_pbs_docking_base_large','resist_explosive',120),
('def_pbs_docking_base_large','resist_chemical',120),
('def_pbs_docking_base_large','armor_max',750000),
('def_pbs_docking_base_medium','stealth_strength',50),
('def_pbs_docking_base_medium','signature_radius',125),
('def_pbs_docking_base_medium','resist_thermal',75),
('def_pbs_docking_base_medium','resist_kinetic',75),
('def_pbs_docking_base_medium','resist_explosive',75),
('def_pbs_docking_base_medium','resist_chemical',75),
('def_pbs_docking_base_medium','armor_max',650000),
('def_pbs_docking_base_small','stealth_strength',50),
('def_pbs_docking_base_small','signature_radius',100),
('def_pbs_docking_base_small','resist_thermal',30),
('def_pbs_docking_base_small','resist_kinetic',30),
('def_pbs_docking_base_small','resist_explosive',30),
('def_pbs_docking_base_small','resist_chemical',30),
('def_pbs_docking_base_small','armor_max',500000),
('def_pbs_effect_supplier_large','stealth_strength',50),
('def_pbs_effect_supplier_large','signature_radius',30),
('def_pbs_effect_supplier_large','resist_thermal',120),
('def_pbs_effect_supplier_large','resist_kinetic',120),
('def_pbs_effect_supplier_large','resist_explosive',120),
('def_pbs_effect_supplier_large','resist_chemical',120),
('def_pbs_effect_supplier_large','core_max',3750),
('def_pbs_effect_supplier_large','armor_max',45000),
('def_pbs_effect_supplier_medium','stealth_strength',50),
('def_pbs_effect_supplier_medium','signature_radius',25),
('def_pbs_effect_supplier_medium','resist_thermal',75),
('def_pbs_effect_supplier_medium','resist_kinetic',75),
('def_pbs_effect_supplier_medium','resist_explosive',75),
('def_pbs_effect_supplier_medium','resist_chemical',75),
('def_pbs_effect_supplier_medium','core_max',3125),
('def_pbs_effect_supplier_medium','armor_max',37500),
('def_pbs_effect_supplier_small','stealth_strength',50),
('def_pbs_effect_supplier_small','signature_radius',20),
('def_pbs_effect_supplier_small','resist_thermal',30),
('def_pbs_effect_supplier_small','resist_kinetic',30),
('def_pbs_effect_supplier_small','resist_explosive',30),
('def_pbs_effect_supplier_small','resist_chemical',30),
('def_pbs_effect_supplier_small','core_max',2500),
('def_pbs_effect_supplier_small','armor_max',30000),
('def_pbs_energywell_large','stealth_strength',50),
('def_pbs_energywell_large','signature_radius',30),
('def_pbs_energywell_large','resist_thermal',120),
('def_pbs_energywell_large','resist_kinetic',120),
('def_pbs_energywell_large','resist_explosive',120),
('def_pbs_energywell_large','resist_chemical',120),
('def_pbs_energywell_large','armor_max',30000),
('def_pbs_energywell_medium','stealth_strength',50),
('def_pbs_energywell_medium','signature_radius',25),
('def_pbs_energywell_medium','resist_thermal',75),
('def_pbs_energywell_medium','resist_kinetic',75),
('def_pbs_energywell_medium','resist_explosive',75),
('def_pbs_energywell_medium','resist_chemical',75),
('def_pbs_energywell_medium','armor_max',25000),
('def_pbs_energywell_small','stealth_strength',50),
('def_pbs_energywell_small','signature_radius',20),
('def_pbs_energywell_small','resist_thermal',30),
('def_pbs_energywell_small','resist_kinetic',30),
('def_pbs_energywell_small','resist_explosive',30),
('def_pbs_energywell_small','resist_chemical',30),
('def_pbs_energywell_small','armor_max',20000),
--('def_pbs_expiring_docking_base','stealth_strength',80),
--('def_pbs_expiring_docking_base','signature_radius',100),
--('def_pbs_expiring_docking_base','resist_thermal',50),
--('def_pbs_expiring_docking_base','resist_kinetic',50),
--('def_pbs_expiring_docking_base','resist_explosive',50),
--('def_pbs_expiring_docking_base','resist_chemical',50),
--('def_pbs_expiring_docking_base','armor_max',250000),
('def_pbs_highwaynode_large','stealth_strength',50),
('def_pbs_highwaynode_large','signature_radius',75),
('def_pbs_highwaynode_large','resist_thermal',300),
('def_pbs_highwaynode_large','resist_kinetic',300),
('def_pbs_highwaynode_large','resist_explosive',300),
('def_pbs_highwaynode_large','resist_chemical',300),
('def_pbs_highwaynode_large','core_recharge_time',345600),
('def_pbs_highwaynode_large','core_max',4500),
('def_pbs_highwaynode_large','armor_max',15000),
('def_pbs_highwaynode_medium','stealth_strength',50),
('def_pbs_highwaynode_medium','signature_radius',65),
('def_pbs_highwaynode_medium','resist_thermal',225),
('def_pbs_highwaynode_medium','resist_kinetic',225),
('def_pbs_highwaynode_medium','resist_explosive',225),
('def_pbs_highwaynode_medium','resist_chemical',225),
('def_pbs_highwaynode_medium','core_recharge_time',345600),
('def_pbs_highwaynode_medium','core_max',3750),
('def_pbs_highwaynode_medium','armor_max',12500),
('def_pbs_highwaynode_small','stealth_strength',50),
('def_pbs_highwaynode_small','signature_radius',50),
('def_pbs_highwaynode_small','resist_thermal',150),
('def_pbs_highwaynode_small','resist_kinetic',150),
('def_pbs_highwaynode_small','resist_explosive',150),
('def_pbs_highwaynode_small','resist_chemical',150),
('def_pbs_highwaynode_small','core_recharge_time',345600),
('def_pbs_highwaynode_small','core_max',3000),
('def_pbs_highwaynode_small','armor_max',10000),
('def_pbs_maskertower_large','stealth_strength',50),
('def_pbs_maskertower_large','signature_radius',30),
('def_pbs_maskertower_large','resist_thermal',120),
('def_pbs_maskertower_large','resist_kinetic',120),
('def_pbs_maskertower_large','resist_explosive',120),
('def_pbs_maskertower_large','resist_chemical',120),
('def_pbs_maskertower_large','core_max',30000),
('def_pbs_maskertower_large','armor_max',75000),
('def_pbs_maskertower_medium','stealth_strength',50),
('def_pbs_maskertower_medium','signature_radius',25),
('def_pbs_maskertower_medium','resist_thermal',75),
('def_pbs_maskertower_medium','resist_kinetic',75),
('def_pbs_maskertower_medium','resist_explosive',75),
('def_pbs_maskertower_medium','resist_chemical',75),
('def_pbs_maskertower_medium','core_max',27500),
('def_pbs_maskertower_medium','armor_max',65000),
('def_pbs_maskertower_small','stealth_strength',50),
('def_pbs_maskertower_small','signature_radius',20),
('def_pbs_maskertower_small','resist_thermal',30),
('def_pbs_maskertower_small','resist_kinetic',30),
('def_pbs_maskertower_small','resist_explosive',30),
('def_pbs_maskertower_small','resist_chemical',30),
('def_pbs_maskertower_small','core_max',25000),
('def_pbs_maskertower_small','armor_max',50000),
('def_pbs_mill_large','stealth_strength',50),
('def_pbs_mill_large','signature_radius',120),
('def_pbs_mill_large','resist_thermal',120),
('def_pbs_mill_large','resist_kinetic',120),
('def_pbs_mill_large','resist_explosive',120),
('def_pbs_mill_large','resist_chemical',120),
('def_pbs_mill_large','core_max',3000),
('def_pbs_mill_large','armor_max',300000),
('def_pbs_mill_medium','stealth_strength',50),
('def_pbs_mill_medium','signature_radius',65),
('def_pbs_mill_medium','resist_thermal',75),
('def_pbs_mill_medium','resist_kinetic',75),
('def_pbs_mill_medium','resist_explosive',75),
('def_pbs_mill_medium','resist_chemical',75),
('def_pbs_mill_medium','core_max',2750),
('def_pbs_mill_medium','armor_max',250000),
('def_pbs_mill_small','stealth_strength',50),
('def_pbs_mill_small','signature_radius',50),
('def_pbs_mill_small','resist_thermal',30),
('def_pbs_mill_small','resist_kinetic',30),
('def_pbs_mill_small','resist_explosive',30),
('def_pbs_mill_small','resist_chemical',30),
('def_pbs_mill_small','core_max',2500),
('def_pbs_mill_small','armor_max',200000),
('def_pbs_mining_tower_large','stealth_strength',50),
('def_pbs_mining_tower_large','signature_radius',45),
('def_pbs_mining_tower_large','resist_thermal',120),
('def_pbs_mining_tower_large','resist_kinetic',120),
('def_pbs_mining_tower_large','resist_explosive',120),
('def_pbs_mining_tower_large','resist_chemical',120),
('def_pbs_mining_tower_large','core_max',30000),
('def_pbs_mining_tower_large','armor_max',150000),
('def_pbs_mining_tower_medium','stealth_strength',50),
('def_pbs_mining_tower_medium','signature_radius',37.5),
('def_pbs_mining_tower_medium','resist_thermal',75),
('def_pbs_mining_tower_medium','resist_kinetic',75),
('def_pbs_mining_tower_medium','resist_explosive',75),
('def_pbs_mining_tower_medium','resist_chemical',75),
('def_pbs_mining_tower_medium','core_max',27500),
('def_pbs_mining_tower_medium','armor_max',125000),
('def_pbs_mining_tower_small','stealth_strength',50),
('def_pbs_mining_tower_small','signature_radius',30),
('def_pbs_mining_tower_small','resist_thermal',30),
('def_pbs_mining_tower_small','resist_kinetic',30),
('def_pbs_mining_tower_small','resist_explosive',30),
('def_pbs_mining_tower_small','resist_chemical',30),
('def_pbs_mining_tower_small','core_max',25000),
('def_pbs_mining_tower_small','armor_max',100000),
('def_pbs_production_upgrade_large','stealth_strength',50),
('def_pbs_production_upgrade_large','signature_radius',30),
('def_pbs_production_upgrade_large','resist_thermal',120),
('def_pbs_production_upgrade_large','resist_kinetic',120),
('def_pbs_production_upgrade_large','resist_explosive',120),
('def_pbs_production_upgrade_large','resist_chemical',120),
('def_pbs_production_upgrade_large','core_max',750),
('def_pbs_production_upgrade_large','armor_max',45000),
('def_pbs_production_upgrade_medium','stealth_strength',50),
('def_pbs_production_upgrade_medium','signature_radius',25),
('def_pbs_production_upgrade_medium','resist_thermal',75),
('def_pbs_production_upgrade_medium','resist_kinetic',75),
('def_pbs_production_upgrade_medium','resist_explosive',75),
('def_pbs_production_upgrade_medium','resist_chemical',75),
('def_pbs_production_upgrade_medium','core_max',625),
('def_pbs_production_upgrade_medium','armor_max',37500),
('def_pbs_production_upgrade_small','stealth_strength',50),
('def_pbs_production_upgrade_small','signature_radius',20),
('def_pbs_production_upgrade_small','resist_thermal',30),
('def_pbs_production_upgrade_small','resist_kinetic',30),
('def_pbs_production_upgrade_small','resist_explosive',30),
('def_pbs_production_upgrade_small','resist_chemical',30),
('def_pbs_production_upgrade_small','core_max',500),
('def_pbs_production_upgrade_small','armor_max',30000),
('def_pbs_prototyper_large','stealth_strength',50),
('def_pbs_prototyper_large','signature_radius',120),
('def_pbs_prototyper_large','resist_thermal',120),
('def_pbs_prototyper_large','resist_kinetic',120),
('def_pbs_prototyper_large','resist_explosive',120),
('def_pbs_prototyper_large','resist_chemical',120),
('def_pbs_prototyper_large','core_max',3000),
('def_pbs_prototyper_large','armor_max',300000),
('def_pbs_prototyper_medium','stealth_strength',50),
('def_pbs_prototyper_medium','signature_radius',65),
('def_pbs_prototyper_medium','resist_thermal',75),
('def_pbs_prototyper_medium','resist_kinetic',75),
('def_pbs_prototyper_medium','resist_explosive',75),
('def_pbs_prototyper_medium','resist_chemical',75),
('def_pbs_prototyper_medium','core_max',2750),
('def_pbs_prototyper_medium','armor_max',250000),
('def_pbs_prototyper_small','stealth_strength',50),
('def_pbs_prototyper_small','signature_radius',50),
('def_pbs_prototyper_small','resist_thermal',30),
('def_pbs_prototyper_small','resist_kinetic',30),
('def_pbs_prototyper_small','resist_explosive',30),
('def_pbs_prototyper_small','resist_chemical',30),
('def_pbs_prototyper_small','core_max',2500),
('def_pbs_prototyper_small','armor_max',200000),
('def_pbs_reactor_large','stealth_strength',50),
('def_pbs_reactor_large','signature_radius',75),
('def_pbs_reactor_large','resist_thermal',120),
('def_pbs_reactor_large','resist_kinetic',120),
('def_pbs_reactor_large','resist_explosive',120),
('def_pbs_reactor_large','resist_chemical',120),
('def_pbs_reactor_large','core_recharge_time',345600),
('def_pbs_reactor_large','core_max',25000000),
('def_pbs_reactor_large','armor_max',150000),
('def_pbs_reactor_medium','stealth_strength',50),
('def_pbs_reactor_medium','signature_radius',65),
('def_pbs_reactor_medium','resist_thermal',75),
('def_pbs_reactor_medium','resist_kinetic',75),
('def_pbs_reactor_medium','resist_explosive',75),
('def_pbs_reactor_medium','resist_chemical',75),
('def_pbs_reactor_medium','core_recharge_time',345600),
('def_pbs_reactor_medium','core_max',20000000),
('def_pbs_reactor_medium','armor_max',125000),
('def_pbs_reactor_small','stealth_strength',50),
('def_pbs_reactor_small','signature_radius',50),
('def_pbs_reactor_small','resist_thermal',30),
('def_pbs_reactor_small','resist_kinetic',30),
('def_pbs_reactor_small','resist_explosive',30),
('def_pbs_reactor_small','resist_chemical',30),
('def_pbs_reactor_small','core_recharge_time',345600),
('def_pbs_reactor_small','core_max',17500000),
('def_pbs_reactor_small','armor_max',100000),
('def_pbs_refinery_large','stealth_strength',50),
('def_pbs_refinery_large','signature_radius',120),
('def_pbs_refinery_large','resist_thermal',120),
('def_pbs_refinery_large','resist_kinetic',120),
('def_pbs_refinery_large','resist_explosive',120),
('def_pbs_refinery_large','resist_chemical',120),
('def_pbs_refinery_large','core_max',3000),
('def_pbs_refinery_large','armor_max',300000),
('def_pbs_refinery_medium','stealth_strength',50),
('def_pbs_refinery_medium','signature_radius',65),
('def_pbs_refinery_medium','resist_thermal',75),
('def_pbs_refinery_medium','resist_kinetic',75),
('def_pbs_refinery_medium','resist_explosive',75),
('def_pbs_refinery_medium','resist_chemical',75),
('def_pbs_refinery_medium','core_max',2750),
('def_pbs_refinery_medium','armor_max',250000),
('def_pbs_refinery_small','stealth_strength',50),
('def_pbs_refinery_small','signature_radius',50),
('def_pbs_refinery_small','resist_thermal',30),
('def_pbs_refinery_small','resist_kinetic',30),
('def_pbs_refinery_small','resist_explosive',30),
('def_pbs_refinery_small','resist_chemical',30),
('def_pbs_refinery_small','core_max',2500),
('def_pbs_refinery_small','armor_max',200000),
('def_pbs_repair_large','stealth_strength',50),
('def_pbs_repair_large','signature_radius',120),
('def_pbs_repair_large','resist_thermal',120),
('def_pbs_repair_large','resist_kinetic',120),
('def_pbs_repair_large','resist_explosive',120),
('def_pbs_repair_large','resist_chemical',120),
('def_pbs_repair_large','core_max',3000),
('def_pbs_repair_large','armor_max',300000),
('def_pbs_repair_medium','stealth_strength',50),
('def_pbs_repair_medium','signature_radius',65),
('def_pbs_repair_medium','resist_thermal',75),
('def_pbs_repair_medium','resist_kinetic',75),
('def_pbs_repair_medium','resist_explosive',75),
('def_pbs_repair_medium','resist_chemical',75),
('def_pbs_repair_medium','core_max',2750),
('def_pbs_repair_medium','armor_max',250000),
('def_pbs_repair_small','stealth_strength',50),
('def_pbs_repair_small','signature_radius',50),
('def_pbs_repair_small','resist_thermal',30),
('def_pbs_repair_small','resist_kinetic',30),
('def_pbs_repair_small','resist_explosive',30),
('def_pbs_repair_small','resist_chemical',30),
('def_pbs_repair_small','core_max',2500),
('def_pbs_repair_small','armor_max',200000),
('def_pbs_reprocessor_large','stealth_strength',50),
('def_pbs_reprocessor_large','signature_radius',120),
('def_pbs_reprocessor_large','resist_thermal',120),
('def_pbs_reprocessor_large','resist_kinetic',120),
('def_pbs_reprocessor_large','resist_explosive',120),
('def_pbs_reprocessor_large','resist_chemical',120),
('def_pbs_reprocessor_large','core_max',3000),
('def_pbs_reprocessor_large','armor_max',300000),
('def_pbs_reprocessor_medium','stealth_strength',50),
('def_pbs_reprocessor_medium','signature_radius',65),
('def_pbs_reprocessor_medium','resist_thermal',75),
('def_pbs_reprocessor_medium','resist_kinetic',75),
('def_pbs_reprocessor_medium','resist_explosive',75),
('def_pbs_reprocessor_medium','resist_chemical',75),
('def_pbs_reprocessor_medium','core_max',2750),
('def_pbs_reprocessor_medium','armor_max',250000),
('def_pbs_reprocessor_small','stealth_strength',50),
('def_pbs_reprocessor_small','signature_radius',50),
('def_pbs_reprocessor_small','resist_thermal',30),
('def_pbs_reprocessor_small','resist_kinetic',30),
('def_pbs_reprocessor_small','resist_explosive',30),
('def_pbs_reprocessor_small','resist_chemical',30),
('def_pbs_reprocessor_small','core_max',2500),
('def_pbs_reprocessor_small','armor_max',200000),
('def_pbs_research_kit_forge_large','stealth_strength',50),
('def_pbs_research_kit_forge_large','signature_radius',120),
('def_pbs_research_kit_forge_large','resist_thermal',120),
('def_pbs_research_kit_forge_large','resist_kinetic',120),
('def_pbs_research_kit_forge_large','resist_explosive',120),
('def_pbs_research_kit_forge_large','resist_chemical',120),
('def_pbs_research_kit_forge_large','core_max',3000),
('def_pbs_research_kit_forge_large','armor_max',300000),
('def_pbs_research_kit_forge_medium','stealth_strength',50),
('def_pbs_research_kit_forge_medium','signature_radius',65),
('def_pbs_research_kit_forge_medium','resist_thermal',75),
('def_pbs_research_kit_forge_medium','resist_kinetic',75),
('def_pbs_research_kit_forge_medium','resist_explosive',75),
('def_pbs_research_kit_forge_medium','resist_chemical',75),
('def_pbs_research_kit_forge_medium','core_max',2750),
('def_pbs_research_kit_forge_medium','armor_max',250000),
('def_pbs_research_kit_forge_small','stealth_strength',50),
('def_pbs_research_kit_forge_small','signature_radius',50),
('def_pbs_research_kit_forge_small','resist_thermal',30),
('def_pbs_research_kit_forge_small','resist_kinetic',30),
('def_pbs_research_kit_forge_small','resist_explosive',30),
('def_pbs_research_kit_forge_small','resist_chemical',30),
('def_pbs_research_kit_forge_small','core_max',2500),
('def_pbs_research_kit_forge_small','armor_max',200000),
('def_pbs_research_lab_large','stealth_strength',50),
('def_pbs_research_lab_large','signature_radius',120),
('def_pbs_research_lab_large','resist_thermal',120),
('def_pbs_research_lab_large','resist_kinetic',120),
('def_pbs_research_lab_large','resist_explosive',120),
('def_pbs_research_lab_large','resist_chemical',120),
('def_pbs_research_lab_large','core_max',3000),
('def_pbs_research_lab_large','armor_max',300000),
('def_pbs_research_lab_medium','stealth_strength',50),
('def_pbs_research_lab_medium','signature_radius',65),
('def_pbs_research_lab_medium','resist_thermal',75),
('def_pbs_research_lab_medium','resist_kinetic',75),
('def_pbs_research_lab_medium','resist_explosive',75),
('def_pbs_research_lab_medium','resist_chemical',75),
('def_pbs_research_lab_medium','core_max',2750),
('def_pbs_research_lab_medium','armor_max',250000),
('def_pbs_research_lab_small','stealth_strength',50),
('def_pbs_research_lab_small','signature_radius',50),
('def_pbs_research_lab_small','resist_thermal',30),
('def_pbs_research_lab_small','resist_kinetic',30),
('def_pbs_research_lab_small','resist_explosive',30),
('def_pbs_research_lab_small','resist_chemical',30),
('def_pbs_research_lab_small','core_max',2500),
('def_pbs_research_lab_small','armor_max',200000),
('def_pbs_XL_core_transmitter_large','stealth_strength',50),
('def_pbs_XL_core_transmitter_large','signature_radius',30),
('def_pbs_XL_core_transmitter_large','resist_thermal',120),
('def_pbs_XL_core_transmitter_large','resist_kinetic',120),
('def_pbs_XL_core_transmitter_large','resist_explosive',120),
('def_pbs_XL_core_transmitter_large','resist_chemical',120),
('def_pbs_XL_core_transmitter_large','core_max',120000),
('def_pbs_XL_core_transmitter_large','armor_max',45000),
('def_pbs_XL_core_transmitter_medium','stealth_strength',50),
('def_pbs_XL_core_transmitter_medium','signature_radius',25),
('def_pbs_XL_core_transmitter_medium','resist_thermal',75),
('def_pbs_XL_core_transmitter_medium','resist_kinetic',75),
('def_pbs_XL_core_transmitter_medium','resist_explosive',75),
('def_pbs_XL_core_transmitter_medium','resist_chemical',75),
('def_pbs_XL_core_transmitter_medium','core_max',105000),
('def_pbs_XL_core_transmitter_medium','armor_max',37500),
('def_pbs_XL_core_transmitter_small','stealth_strength',50),
('def_pbs_XL_core_transmitter_small','signature_radius',20),
('def_pbs_XL_core_transmitter_small','resist_thermal',30),
('def_pbs_XL_core_transmitter_small','resist_kinetic',30),
('def_pbs_XL_core_transmitter_small','resist_explosive',30),
('def_pbs_XL_core_transmitter_small','resist_chemical',30),
('def_pbs_XL_core_transmitter_small','core_max',90000),
('def_pbs_XL_core_transmitter_small','armor_max',30000);


PRINT N'Merge all PBS stats';
MERGE [dbo].[aggregatevalues] v USING #BASE_STATS s
ON v.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE s.defName=definitionname) AND
v.field = (SELECT TOP 1 id FROM aggregatefields WHERE name=s.fieldName)
WHEN MATCHED
    THEN UPDATE SET
		v.value=s.modValue
WHEN NOT MATCHED
    THEN INSERT (definition, field, value) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE s.defName=definitionname),
	(SELECT TOP 1 id FROM aggregatefields WHERE name=s.fieldName),
	s.modValue);


PRINT N'Merge all PBS stats for capsule defs';
MERGE [dbo].[aggregatevalues] v USING #BASE_STATS s
ON v.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE s.defName+'_capsule'=definitionname) AND
v.field = (SELECT TOP 1 id FROM aggregatefields WHERE name=s.fieldName)
WHEN MATCHED
    THEN UPDATE SET
		v.value=s.modValue
WHEN NOT MATCHED
    THEN INSERT (definition, field, value) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE s.defName=definitionname),
	(SELECT TOP 1 id FROM aggregatefields WHERE name=s.fieldName),
	s.modValue);

DROP TABLE IF EXISTS #BASE_STATS;
PRINT N'All PBS stats updated';
GO

USE [perpetuumsa]
GO

--------------------------------------------
-- Update script for all pbs effects (assuming no new effects)
--
-- Date modified: 2021/12/04
--------------------------------------------


PRINT N'PBS EFFECTS UPDATE';
DROP TABLE IF EXISTS #PBS_EFFECTS;
CREATE TABLE #PBS_EFFECTS(
	effName VARCHAR(128),
	fieldName VARCHAR(128),
	modValue FLOAT
);
INSERT INTO #PBS_EFFECTS(effName, fieldName, modValue) VALUES
--boosters
('effect_pbs_booster_cycle_time_lvl1','effect_weapon_cycle_time_modifier',0.75),
('effect_pbs_booster_cycle_time_lvl2','effect_weapon_cycle_time_modifier',0.7),
('effect_pbs_booster_cycle_time_lvl3','effect_weapon_cycle_time_modifier',0.65),

('effect_pbs_booster_resist_lvl1','effect_resist_chemical',100),
('effect_pbs_booster_resist_lvl1','effect_resist_explosive',100),
('effect_pbs_booster_resist_lvl1','effect_resist_kinetic',100),
('effect_pbs_booster_resist_lvl1','effect_resist_thermal',100),

('effect_pbs_booster_resist_lvl2','effect_resist_chemical',125),
('effect_pbs_booster_resist_lvl2','effect_resist_explosive',125),
('effect_pbs_booster_resist_lvl2','effect_resist_kinetic',125),
('effect_pbs_booster_resist_lvl2','effect_resist_thermal',125),

('effect_pbs_booster_resist_lvl3','effect_resist_chemical',150),
('effect_pbs_booster_resist_lvl3','effect_resist_explosive',150),
('effect_pbs_booster_resist_lvl3','effect_resist_kinetic',150),
('effect_pbs_booster_resist_lvl3','effect_resist_thermal',150),

('effect_pbs_booster_sensor_lvl1','effect_detection_strength_modifier',5),
('effect_pbs_booster_sensor_lvl1','effect_missile_range_modifier',1.1),
('effect_pbs_booster_sensor_lvl1','effect_optimal_range_modifier',1.1),
--('effect_pbs_booster_sensor_lvl1','effect_sensor_booster_locking_range_modifier',1.125),
('effect_pbs_booster_sensor_lvl1','effect_sensor_booster_locking_time_modifier',0.8),
('effect_pbs_booster_sensor_lvl1','effect_sensor_strength_modifier',1.2),

('effect_pbs_booster_sensor_lvl2','effect_detection_strength_modifier',6),
('effect_pbs_booster_sensor_lvl2','effect_missile_range_modifier',1.125),
('effect_pbs_booster_sensor_lvl2','effect_optimal_range_modifier',1.125),
--('effect_pbs_booster_sensor_lvl2','effect_sensor_booster_locking_range_modifier',1.15),
('effect_pbs_booster_sensor_lvl2','effect_sensor_booster_locking_time_modifier',0.75),
('effect_pbs_booster_sensor_lvl2','effect_sensor_strength_modifier',1.25),

('effect_pbs_booster_sensor_lvl3','effect_detection_strength_modifier',7),
('effect_pbs_booster_sensor_lvl3','effect_missile_range_modifier',1.15),
('effect_pbs_booster_sensor_lvl3','effect_optimal_range_modifier',1.15),
--('effect_pbs_booster_sensor_lvl3','effect_sensor_booster_locking_range_modifier',1.175),
('effect_pbs_booster_sensor_lvl3','effect_sensor_booster_locking_time_modifier',0.7),
('effect_pbs_booster_sensor_lvl3','effect_sensor_strength_modifier',1.3),

--aura emitter
('effect_pbs_engineering_lvl1','effect_core_recharge_time_modifier',0.96),
('effect_pbs_engineering_lvl1','effect_repair_amount_modifier',1.075),
--('effect_pbs_engineering_lvl1','effect_locking_time_modifier',1.035),
('effect_pbs_engineering_lvl2','effect_core_recharge_time_modifier',0.95),
('effect_pbs_engineering_lvl2','effect_repair_amount_modifier',1.1),
--('effect_pbs_engineering_lvl2','effect_locking_time_modifier',1.05),
('effect_pbs_engineering_lvl3','effect_core_recharge_time_modifier',0.94),
('effect_pbs_engineering_lvl3','effect_repair_amount_modifier',1.125),
--('effect_pbs_engineering_lvl3','effect_locking_time_modifier',1.075),

('effect_pbs_industry_lvl1','effect_harvesting_amount_modifier',1.05),
('effect_pbs_industry_lvl1','effect_mining_amount_modifier',1.05),
('effect_pbs_industry_lvl1','effect_mining_probe_accuracy_modifier',1.1),
('effect_pbs_industry_lvl2','effect_harvesting_amount_modifier',1.075),
('effect_pbs_industry_lvl2','effect_mining_amount_modifier',1.075),
('effect_pbs_industry_lvl2','effect_mining_probe_accuracy_modifier',1.125),
('effect_pbs_industry_lvl3','effect_harvesting_amount_modifier',1.10),
('effect_pbs_industry_lvl3','effect_mining_amount_modifier',1.10),
('effect_pbs_industry_lvl3','effect_mining_probe_accuracy_modifier',1.15),

('effect_pbs_sensors_lvl1','effect_detection_strength_modifier',5),
('effect_pbs_sensors_lvl1','effect_stealth_strength_modifier',10),
--('effect_pbs_sensors_lvl1','effect_ecm_strength_modifier',1.025),
('effect_pbs_sensors_lvl2','effect_detection_strength_modifier',6),
('effect_pbs_sensors_lvl2','effect_stealth_strength_modifier',12.5),
--('effect_pbs_sensors_lvl2','effect_ecm_strength_modifier',1.035),
('effect_pbs_sensors_lvl3','effect_detection_strength_modifier',7),
('effect_pbs_sensors_lvl3','effect_stealth_strength_modifier',15),
--('effect_pbs_sensors_lvl3','effect_ecm_strength_modifier',1.05),

--colix mining tower
('effect_pbs_mining_tower_gammaterial_lvl1','effect_mining_amount_modifier',1.1),
('effect_pbs_mining_tower_gammaterial_lvl2','effect_mining_amount_modifier',1.15),
('effect_pbs_mining_tower_gammaterial_lvl3','effect_mining_amount_modifier',1.2),

--masking tower
('effect_pbs_gap_generator_masking_lvl1','effect_stealth_strength_modifier',10),
('effect_pbs_gap_generator_masking_lvl2','effect_stealth_strength_modifier',12.5),
('effect_pbs_gap_generator_masking_lvl3','effect_stealth_strength_modifier',15)
;

SELECT * FROM effectdefaultmodifiers WHERE effectid IN (
	SELECT id FROM effects WHERE name IN (
		SELECT DISTINCT effName FROM #PBS_EFFECTS
	)
); 
DELETE FROM effectdefaultmodifiers WHERE effectid IN (
	SELECT id FROM effects WHERE name IN (
		SELECT DISTINCT effName FROM #PBS_EFFECTS
	)
); 

PRINT N'Merge all pbs effect modifiers';
MERGE [dbo].[effectdefaultmodifiers] v USING #PBS_EFFECTS s
ON v.effectid = (SELECT TOP 1 id FROM effects WHERE name=s.effName) AND
v.field = (SELECT TOP 1 id FROM aggregatefields WHERE name=s.fieldName)
WHEN MATCHED
    THEN UPDATE SET
		v.value=s.modValue
WHEN NOT MATCHED
    THEN INSERT (effectid, field, value) VALUES
	((SELECT TOP 1 id FROM effects WHERE name=s.effName),
	(SELECT TOP 1 id FROM aggregatefields WHERE name=s.fieldName),
	s.modValue);

PRINT N'PBS EFFECTS UPDATED';
DROP TABLE IF EXISTS #PBS_EFFECTS;
GO

USE [perpetuumsa]
GO

----------------------------------------
-- update to fuel properties
-- modified 2022/08/04
----------------------------------------

DROP TABLE IF EXISTS #CORE;
CREATE TABLE #CORE
(
	defName varchar(100),
	energyAmount int
);

INSERT INTO #CORE (defName, energyAmount) VALUES
('def_axicol', 40), --50
('def_espitium', 400), --500
('def_specimen_sap_item_flux', 28000),
('def_gamma_energyblock', 2000), --2200
('def_corebooster_ammo',1000); --750

MERGE [dbo].[definitionconfig] d USING #CORE c
ON d.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE c.defName=definitionname)
WHEN MATCHED
    THEN UPDATE SET
		corecalories=c.energyAmount;

DROP TABLE IF EXISTS #CORE;
PRINT N'UPDATED FUELS';
GO

USE [perpetuumsa]
GO

--------------------------------------
-- ENABLE AND UNLOCK ALL THE GAMMA THINGS
--
-- Date Modified: 2021/10/25
--------------------------------------


DECLARE @EXT_NAME AS VARCHAR(128) = 'ext_research_pbs';
DECLARE @PBS_CAT AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_pbs_capsules');
DECLARE @CAT_MASK AS BIGINT = (SELECT dbo.GetCFMask(@PBS_CAT));

PRINT N'UNLOCKING DEFINITIONS:';
SELECT definition, definitionname FROM entitydefaults WHERE (categoryflags & @CAT_MASK)=@PBS_CAT;

UPDATE entitydefaults SET
	enabled=1, hidden=0, purchasable=1
WHERE (categoryflags & @CAT_MASK)=@PBS_CAT;

PRINT N'UNLOCKING SKILL '+@EXT_NAME;
UPDATE extensions SET
	active=1,
	hidden=0,
	price=405000,
	rank=9
WHERE extensionname=@EXT_NAME AND extensionid=350;

GO

PRINT N'PATCH 28 COMPLETE';
GO
