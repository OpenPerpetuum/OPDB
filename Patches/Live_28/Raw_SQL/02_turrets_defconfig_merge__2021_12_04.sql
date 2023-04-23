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