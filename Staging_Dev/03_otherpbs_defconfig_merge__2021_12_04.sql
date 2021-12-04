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
30000, 2, 35, 100, 2, 18000, 2, 5, 60, 0.7, 300, 2.8284),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_armor_repairer_medium'),
30000, 2, 35, 75, 2, 15000, 2, 4, 55, 0.7, 250, 2.8284),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_armor_repairer_small'),
30000, 2, 35, 50, 1, 12000, 2, 3, 50, 0.7, 200, 1.4142);

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
30000, 1, 45, 40, 1, 2, 1, 50, 60, 0.65, 150, 1.4142),
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_production_upgrade_medium'),
30000, 1, 45, 30, 1, 2, 1, 40, 55, 0.65, 125, 1.4142),
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
30000, 7, 45, 500, 6, 6, 1, 600, 0.65, 1500, 8.4852, 125
FROM #FACILITY_BY_TECH WHERE tech=3;

INSERT INTO #PBS_CONFIGS (definition,
cycle_time, constructionradius, transmitradius, constructionlevelmax, blockingradius,
inconnections, outconnections, coreconsumption, corekickstartthreshold, bandwidthusage,
hitsize, productionlevel)
SELECT (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defName),
30000, 7, 45, 375, 5, 5, 1, 550, 0.65, 1250, 7.071, 100
FROM #FACILITY_BY_TECH WHERE tech=2;

INSERT INTO #PBS_CONFIGS (definition,
cycle_time, constructionradius, transmitradius, constructionlevelmax, blockingradius,
inconnections, outconnections, coreconsumption, corekickstartthreshold, bandwidthusage,
hitsize, productionlevel)
SELECT (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defName),
30000, 7, 45, 250, 4, 4, 1, 500, 0.65, 1000, 5.6568, 50
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