USE [perpetuumsa]
GO


-------------------------------------------------------------
--PATCH 27: GAMMA NPCS, prototypes, research cost, t4+ shards, staging base, t0 block
--00_teleportdesc_activate_connect__2021_10_25.sql
--01_zones_update_xy__2021_10_30.sql
--05_gamma_prototype_capsules__2021_07_25.sql
--08_pbs_definitionconfig_updates__2021_09_02.sql
--11_insert_npcdefs_npcturrets__2021_09_18.sql
--15_fuels_entitydefs_defconfig_insert__2021_09_19.sql
--16_blocks_entitydefs_production_insert__2021_10_13.sql
--17_elite_mods_gamma_shards__2021_10_31.sql
--18_large_ammo_pvp__2021_11_01.sql
--20_techtreenodeprices_updatepbs__2021_09_18.sql
--25_stagingbase_newdefs__2021_10_09.sql
--26_zoneeffects_t0_update__2021_11_07.sql
--30_npc_gamma_defs__2021_10_25.sql
--31_npc_pres_flocks__2021_10_25.sql
--31b_bosses_npc_pres_flocks__2021_11_03.sql
--32_npcloots_step1__2021_11_01.sql
--33_npcloots_step2__2021_11_04.sql
--34_update_robottemplaterelations_ep__2021_11_02.sql
--35_update_robottemplaterelations_ep_part2__2021_11_04.sql
--46_market_alpha_gammaitems__2021_10_14.sql
-------------------------------------------------------------



PRINT N'00_teleportdesc_activate_connect__2021_10_25.sql';
USE [perpetuumsa]
GO

-------------------------------
-- ACTIVATE THE TELEPORTS
-- DATE MODIFIED: 2021/10/25
-------------------------------

DROP TABLE IF EXISTS #DISABLED_CONNECTIONS;
CREATE TABLE #DISABLED_CONNECTIONS(
	sourceColName VARCHAR(100),
	targetColName VARCHAR(100)
);
INSERT INTO #DISABLED_CONNECTIONS (sourceColName, targetColName) VALUES
('teleport_column_tmpvp_4','tpc_z100'),
('tpc_z100','teleport_column_tmpvp_4'),
('teleport_column_initia_sw','tpc_z101'),
('tpc_z101','teleport_column_initia_sw'),
('teleport_column_asipvp_5','tpc_z102'),
('tpc_z102','teleport_column_asipvp_5'),
('teleport_column_asi2_vougar','tpc_z103'),
('tpc_z103','teleport_column_asi2_vougar'),
('teleport_column_icspvp_2','tpc_z104'),
('tpc_z104','teleport_column_icspvp_2'),
('teleport_column_ics2_vsehovski','tpc_z105'),
('tpc_z105','teleport_column_ics2_vsehovski');


UPDATE teleportdescriptions SET
	active=1
WHERE sourcecolumn IN (SELECT eid FROM zoneentities WHERE ename IN (SELECT sourceColName FROM #DISABLED_CONNECTIONS)) 
AND targetcolumn IN (SELECT eid FROM zoneentities WHERE ename IN (SELECT targetColName FROM #DISABLED_CONNECTIONS));


DROP TABLE IF EXISTS #DISABLED_CONNECTIONS;
PRINT N'TELEPORT NETWORK ACTIVATED';
GO


PRINT N'01_zones_update_xy__2021_10_30.sql';
USE [perpetuumsa]
GO

-------------------------------------------
-- Phase 2 map tweaks
--
-- Date Modified: 2021/10/30
-------------------------------------------

DROP TABLE IF EXISTS #ZONEMAP;
CREATE TABLE #ZONEMAP(
	zoneId int,
	x int,
	y int
);
INSERT INTO #ZONEMAP (zoneId, x, y) VALUES
((SELECT TOP 1 id FROM zones WHERE name='zone_gamma_tc_z101'), 774, -36500),
((SELECT TOP 1 id FROM zones WHERE name='zone_gamma_tc_z104'), 2147, -15026),
((SELECT TOP 1 id FROM zones WHERE name='zone_gamma_z108'), -6233, -28442),
((SELECT TOP 1 id FROM zones WHERE name='zone_gamma_z110'), 1435, -21223),
((SELECT TOP 1 id FROM zones WHERE name='zone_gamma_z119'), -18588, -31884),
((SELECT TOP 1 id FROM zones WHERE name='zone_gamma_z126'), 8367, -43372),
((SELECT TOP 1 id FROM zones WHERE name='zone_gamma_z131'), 17299, -30108);

MERGE [dbo].[zones] AS z
USING #ZONEMAP AS m
ON m.zoneId=z.id
WHEN MATCHED THEN
	UPDATE SET
		x=m.x,
		y=m.y;


DROP TABLE IF EXISTS #ZONEMAP;
GO


PRINT N'05_gamma_prototype_capsules__2021_07_25.sql';
USE [perpetuumsa]
GO

------------------------------------------------------------------------
-- PBS deployable item (capsule) prototype definitions
-- Create a 1:1 copy of definition and stats but target research tree to prototype
-- And RE to yield CT
-- Date Modified: 2021/07/25
------------------------------------------------------------------------


PRINT N'Create PBS prototype capsules to be the research target, reverse engineer to CT, to produce non-prototype capsules (originals)';
DECLARE @PbsCapCat AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name = 'cf_pbs_capsules');
DECLARE @DEF_OFFSET AS INT = 2000; --DO NOT CHANGE! This is just creating a fixed/safe offset in the entitydefault definition-id space to make the copy of definitions/configs easier since the relationship of a prototype to its base type would be a constant offset.
DECLARE @StackableOnly AS BIGINT = 2048; --Disable deployability for these items - causes more problems

SELECT * FROM entitydefaults d
WHERE (d.categoryflags & CAST(dbo.GetCFMask(@PbsCapCat)as BIGINT) = @PbsCapCat) AND d.definition < 6000 AND d.tiertype=1
ORDER BY d.definition;

DROP TABLE IF EXISTS #PBS_PR_CAP_DEFS;
CREATE TABLE #PBS_PR_CAP_DEFS(
	[definition] [int] NOT NULL,
	[definitionname] [varchar](100) NOT NULL,
	[quantity] [int] NOT NULL,
	[attributeflags] [bigint] NOT NULL,
	[categoryflags] [bigint] NOT NULL,
	[options] [varchar](max) NULL,
	[note] [nvarchar](2048) NULL,
	[enabled] [bit] NOT NULL,
	[volume] [float] NULL,
	[mass] [float] NULL,
	[hidden] [bit] NOT NULL,
	[health] [float] NOT NULL,
	[descriptiontoken] [nvarchar](100) NULL,
	[purchasable] [bit] NOT NULL,
	[tiertype] [int] NULL,
	[tierlevel] [int] NULL,
);
INSERT INTO #PBS_PR_CAP_DEFS
([definition], [definitionname],[quantity],[attributeflags],[categoryflags],[options],[note],
[enabled],[volume],[mass],[hidden],[health],[descriptiontoken],[purchasable],[tiertype],[tierlevel])
SELECT
	d.definition+@DEF_OFFSET, d.definitionname+'_pr', d.quantity, @StackableOnly, d.categoryflags, d.options+'_pr', 'PBS CAPSULE PROTOTYPE DEF',
	1, d.volume, d.mass, 0, d.health, d.descriptiontoken, 1, 2, d.tierlevel FROM entitydefaults d
WHERE (d.categoryflags & CAST(dbo.GetCFMask(@PbsCapCat)as BIGINT) = @PbsCapCat) AND d.definition < 6000 AND d.tiertype=1
ORDER BY d.definition;

DROP TABLE IF EXISTS #PBS_PR_CAP_CONFIGS;
CREATE TABLE #PBS_PR_CAP_CONFIGS(
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
	[hitsize] [float] NULL,
	[note] [varchar](2000) NULL,
);
INSERT INTO #PBS_PR_CAP_CONFIGS 
	(definition, targetdefinition, item_work_range, cycle_time, constructionradius, transmitradius,
	constructionlevelmax, blockingradius, chargeamount, inconnections, outconnections, coretransferred,
	transferefficiency, productionupgradeamount, productionlevel, coreconsumption, corekickstartthreshold,
	reinforcecountermax, bandwidthusage, bandwidthcapacity, emitradius, typeexclusiverange, network_node_range,
	hitsize, note)
SELECT 
	c.definition+@DEF_OFFSET, NULL, c.item_work_range, c.cycle_time, c.constructionradius, c.transmitradius,
	c.constructionlevelmax, c.blockingradius, c.chargeamount, c.inconnections, c.outconnections, c.coretransferred,
	c.transferefficiency, c.productionupgradeamount, c.productionlevel, c.coreconsumption, c.corekickstartthreshold,
	c.reinforcecountermax, c.bandwidthusage, c.bandwidthcapacity, c.emitradius, c.typeexclusiverange, c.network_node_range,
	c.hitsize, 'PBS CAPSULE PROTOTYPE DEFCONFIG'
FROM definitionconfig c
JOIN entitydefaults d ON d.definition=c.definition
WHERE (d.categoryflags & CAST(dbo.GetCFMask(@PbsCapCat)as BIGINT) = @PbsCapCat) AND d.definition < 6000 AND d.tiertype=1
ORDER BY d.definition;

DROP TABLE IF EXISTS #PBS_PR_CAP_VALUES;
CREATE TABLE #PBS_PR_CAP_VALUES(
	definition INT,
	field INT,
	value FLOAT
);
INSERT INTO #PBS_PR_CAP_VALUES (definition, field, value)
SELECT v.definition+@DEF_OFFSET, v.field, v.value FROM aggregatevalues v
JOIN entitydefaults d ON d.definition=v.definition
WHERE (d.categoryflags & CAST(dbo.GetCFMask(@PbsCapCat)as BIGINT) = @PbsCapCat) AND d.definition < 6000 AND d.tiertype=1
ORDER BY d.definition;

DROP TABLE IF EXISTS #PBS_PR_CAP_COMPONENTS;
CREATE TABLE #PBS_PR_CAP_COMPONENTS(
	definition INT,
	componentdefinition INT,
	componentamount INT
);
INSERT INTO #PBS_PR_CAP_COMPONENTS (definition, componentdefinition, componentamount)
SELECT c.definition+@DEF_OFFSET, c.componentdefinition, c.componentamount FROM components c
JOIN entitydefaults d ON d.definition=c.definition
WHERE (d.categoryflags & CAST(dbo.GetCFMask(@PbsCapCat)as BIGINT) = @PbsCapCat) AND d.definition < 6000 AND d.tiertype=1
ORDER BY d.definition;

DROP TABLE IF EXISTS #PROTOPAIRS;
CREATE TABLE #PROTOPAIRS
(
	definition INT,
	protoDefinition INT
);
INSERT INTO #PROTOPAIRS (definition, protoDefinition)
SELECT d.definition, d.definition+@DEF_OFFSET from entitydefaults d
WHERE (d.categoryflags & CAST(dbo.GetCFMask(@PbsCapCat)as BIGINT) = @PbsCapCat) AND d.definition < 6000 AND d.tiertype=1
ORDER BY d.definition;

--------------------------------------------------------
--Where the action happens
--------------------------------------------------------

PRINT N'UPSERT [entitydefaults]';
SET IDENTITY_INSERT entitydefaults ON;
MERGE [dbo].[entitydefaults] d USING #PBS_PR_CAP_DEFS p
ON d.definition = p.definition
WHEN MATCHED
    THEN UPDATE SET
		definitionname=p.definitionname,
		categoryflags=p.categoryflags,
		attributeflags=p.attributeflags,
		volume=p.volume,
		mass=p.mass,
		tiertype=p.tiertype,
		tierlevel=p.tierlevel,
		options=p.options,
		enabled=p.enabled,
		hidden=p.hidden,
		purchasable=p.purchasable,
		descriptiontoken=p.descriptiontoken
WHEN NOT MATCHED
    THEN INSERT
	([definition], [definitionname],[quantity],[attributeflags],[categoryflags],[options],[note],
	[enabled],[volume],[mass],[hidden],[health],[descriptiontoken],[purchasable],[tiertype],[tierlevel])
	VALUES
	(p.definition, p.definitionname, p.quantity, p.attributeflags, p.categoryflags, p.options, p.note,
	p.enabled, p.volume, p.mass, p.hidden, p.health, p.descriptiontoken, p.purchasable, p.tiertype, p.tierlevel);
SET IDENTITY_INSERT entitydefaults OFF;

PRINT N'UPSERT [definitionconfig]';
MERGE [dbo].[definitionconfig] cd USING #PBS_PR_CAP_CONFIGS c
ON cd.definition = c.definition
WHEN MATCHED
    THEN UPDATE SET
		definition=c.definition,
		targetdefinition=c.targetdefinition,
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
		hitsize=c.hitsize,
		note=c.note
WHEN NOT MATCHED
    THEN INSERT
	(definition, targetdefinition, item_work_range, cycle_time, constructionradius, transmitradius,
	constructionlevelmax, blockingradius, chargeamount, inconnections, outconnections, coretransferred,
	transferefficiency, productionupgradeamount, productionlevel, coreconsumption, corekickstartthreshold,
	reinforcecountermax, bandwidthusage, bandwidthcapacity, emitradius, typeexclusiverange, network_node_range,
	hitsize, note)
	VALUES
	(c.definition, c.targetdefinition, c.item_work_range, c.cycle_time, c.constructionradius, c.transmitradius,
	c.constructionlevelmax, c.blockingradius, c.chargeamount, c.inconnections, c.outconnections, c.coretransferred,
	c.transferefficiency, c.productionupgradeamount, c.productionlevel, c.coreconsumption, c.corekickstartthreshold,
	c.reinforcecountermax, c.bandwidthusage, c.bandwidthcapacity, c.emitradius, c.typeexclusiverange, c.network_node_range,
	c.hitsize, c.note);

PRINT N'UPSERT [aggregatevalues]';
MERGE [dbo].[aggregatevalues] v USING #PBS_PR_CAP_VALUES p
ON v.definition = p.definition AND v.field=p.field
WHEN MATCHED
    THEN UPDATE SET
		value = p.value
WHEN NOT MATCHED
    THEN INSERT (definition, field, value) VALUES
	(p.definition, p.field, p.value);

PRINT N'UPSERT [components]';
MERGE [dbo].[components] c USING #PBS_PR_CAP_COMPONENTS p
ON c.definition = p.definition AND c.componentdefinition=p.componentdefinition
WHEN MATCHED
    THEN UPDATE SET
		componentdefinition = p.componentdefinition,
		componentamount = p.componentamount
WHEN NOT MATCHED
    THEN INSERT (definition, componentdefinition, componentamount) VALUES
	(p.definition, p.componentdefinition, p.componentamount);

PRINT N'UPSERT [prototypes]';
MERGE [dbo].[prototypes] pro USING #PROTOPAIRS p
ON pro.definition = p.definition
WHEN MATCHED
    THEN UPDATE SET
		definition=p.definition,
		prototype=p.protoDefinition
WHEN NOT MATCHED
    THEN INSERT (definition, prototype) VALUES
		(p.definition, p.protoDefinition);

PRINT N'SWAP NORMAL PBS CAPSULE DEFINTION TO PROTODEFINITION FOR [itemresearchlevels]';
MERGE [dbo].[itemresearchlevels] i USING #PROTOPAIRS p
ON i.definition = p.definition
WHEN MATCHED
    THEN UPDATE SET
		definition=p.protoDefinition;

PRINT N'PBS Prototype capsules defined and values copied from originals';
DROP TABLE IF EXISTS #PBS_PR_CAP_DEFS;
DROP TABLE IF EXISTS #PBS_PR_CAP_CONFIGS;
DROP TABLE IF EXISTS #PBS_PR_CAP_VALUES;
DROP TABLE IF EXISTS #PBS_PR_CAP_COMPONENTS;
DROP TABLE IF EXISTS #PROTOPAIRS;
GO



PRINT N'08_pbs_definitionconfig_updates__2021_09_02.sql';
USE [perpetuumsa]
GO

-----------------------------------------------
-- Gamma building param changes
--
-- Date modified: 2021/09/02
-----------------------------------------------

DROP TABLE IF EXISTS #POSTFIXES;
CREATE TABLE #POSTFIXES(
	fix VARCHAR(128)
);
INSERT #POSTFIXES (fix) VALUES
(''),
('_capsule'),
('_capsule_pr');

DROP TABLE IF EXISTS #PBS_CONFIGS;
CREATE TABLE #PBS_CONFIGS(
	defPrefix VARCHAR(128),
	paramName VARCHAR(128),
	paramValue int
);
INSERT INTO #PBS_CONFIGS (defPrefix, paramName, paramValue) VALUES
('def_pbs_docking_base_medium', 'bandwidthcapacity', 25000),
('def_pbs_docking_base_small', 'bandwidthcapacity', 12500),

('def_pbs_calibration_forge_large', 'transmitradius', 45),
('def_pbs_calibration_forge_medium', 'transmitradius', 45),
('def_pbs_calibration_forge_small', 'transmitradius', 45),
('def_pbs_mill_large', 'transmitradius', 45),
('def_pbs_mill_medium', 'transmitradius', 45),
('def_pbs_mill_small', 'transmitradius', 45),
('def_pbs_production_upgrade_large', 'transmitradius', 45),
('def_pbs_production_upgrade_medium', 'transmitradius', 45),
('def_pbs_production_upgrade_small', 'transmitradius', 45),
('def_pbs_prototyper_large', 'transmitradius', 45),
('def_pbs_prototyper_medium', 'transmitradius', 45),
('def_pbs_prototyper_small', 'transmitradius', 45),
('def_pbs_refinery_large', 'transmitradius', 45),
('def_pbs_refinery_medium', 'transmitradius', 45),
('def_pbs_refinery_small', 'transmitradius', 45),
('def_pbs_repair_large', 'transmitradius', 45),
('def_pbs_repair_medium', 'transmitradius', 45),
('def_pbs_repair_small', 'transmitradius', 45),
('def_pbs_reprocessor_large', 'transmitradius', 45),
('def_pbs_reprocessor_medium', 'transmitradius', 45),
('def_pbs_reprocessor_small', 'transmitradius', 45),
('def_pbs_research_kit_forge_large', 'transmitradius', 45),
('def_pbs_research_kit_forge_medium', 'transmitradius', 45),
('def_pbs_research_kit_forge_small', 'transmitradius', 45),
('def_pbs_research_lab_large', 'transmitradius', 45),
('def_pbs_research_lab_medium', 'transmitradius', 45),
('def_pbs_research_lab_small', 'transmitradius', 45);

DROP TABLE IF EXISTS #PBS_CONFIGS_MERGED;
CREATE TABLE #PBS_CONFIGS_MERGED(
	def int,
	paramName VARCHAR(128),
	paramValue int
);
INSERT INTO #PBS_CONFIGS_MERGED (def, paramName, paramValue)
SELECT (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=c.defPrefix+f.fix), c.paramName, c.paramValue FROM #PBS_CONFIGS c
JOIN #POSTFIXES f ON 1=1;

--SELECT definition, transmitradius, bandwidthcapacity FROM definitionconfig
--WHERE definition in (select def from #PBS_CONFIGS_MERGED);

MERGE [dbo].[definitionconfig] AS c
USING #PBS_CONFIGS_MERGED AS p 
ON p.def=c.definition AND p.paramName='transmitradius'
WHEN MATCHED THEN 
	UPDATE SET
		transmitradius=p.paramValue;

MERGE [dbo].[definitionconfig] AS c
USING #PBS_CONFIGS_MERGED AS p 
ON p.def=c.definition AND p.paramName='bandwidthcapacity'
WHEN MATCHED THEN 
	UPDATE SET
		bandwidthcapacity=p.paramValue;


DROP TABLE IF EXISTS #PBS_CONFIGS;
DROP TABLE IF EXISTS #PBS_CONFIGS_MERGED;
DROP TABLE IF EXISTS #POSTFIXES;
GO

PRINT N'11_insert_npcdefs_npcturrets__2021_09_18.sql';
USE [perpetuumsa]
GO

-------------------------------------
-- Define new NPC Turrets
--
-- Date modifified: 2021/11/17
-------------------------------------

PRINT N'NEW NPC DEFINTIONS 6094-6109';

DECLARE @armor_max_level0 AS FLOAT = 0.5;
DECLARE @armor_max_level1 AS FLOAT = 0.75;
DECLARE @armor_max_level2 AS FLOAT = 0.9;
DECLARE @armor_max_level3 AS FLOAT = 1.0;

DECLARE @resist_level0 AS INT = 50;
DECLARE @resist_level1 AS INT = 75;
DECLARE @resist_level2 AS INT = 125;
DECLARE @resist_level3 AS INT = 150;
DECLARE @peakResistMod AS FLOAT = 1.5;

DECLARE @turretLockRangeMod AS FLOAT = 1.5;

DECLARE @turretFalloffMod AS FLOAT = 2.0;
DECLARE @turretOptimalMod_level0 AS FLOAT = 0.65;
DECLARE @turretOptimalMod_level1 AS FLOAT = 0.85;
DECLARE @turretOptimalMod_level2 AS FLOAT = 1.05;
DECLARE @turretOptimalMod_level3 AS FLOAT = 1.25;

DECLARE @turretDamageMod_level0 AS FLOAT = 0.5;
DECLARE @turretDamageMod_level1 AS FLOAT = 0.65;
DECLARE @turretDamageMod_level2 AS FLOAT = 0.8;
DECLARE @turretDamageMod_level3 AS FLOAT = 1.0;

DECLARE @turretRepAmountMod_level0 AS FLOAT = 1.0;
DECLARE @turretRepAmountMod_level1 AS FLOAT = 2.0;
DECLARE @turretRepAmountMod_level2 AS FLOAT = 4.0;
DECLARE @turretRepAmountMod_level3 AS FLOAT = 6.0;

DECLARE @turretRepRateMod AS FLOAT = 0.5;

DECLARE @npcDesc AS VARCHAR(MAX) = 'def_npc_pbs_desc';

DROP TABLE IF EXISTS #ENTITYDEFS;
CREATE TABLE #ENTITYDEFS
(
	def INT,
	defName varchar(100),
	catFlags bigint,
	attrFlags bigint,
	cargoVolume float,
	massOfModule float,
	genxyOptStr varchar(max),
	description varchar(max),
);
INSERT INTO #ENTITYDEFS (def, defName, attrFlags, catFlags, cargoVolume, massOfModule, genxyOptStr, description) VALUES
--NPC defs
(6094,'def_npc_pbs_turret_laser_level0', 1024, 911, 0, 0, NULL, @npcDesc),
(6095,'def_npc_pbs_turret_em_level0', 1024, 911, 0, 0, NULL, @npcDesc),
(6096,'def_npc_pbs_turret_missile_level0', 1024, 911, 0, 0, NULL, @npcDesc),
(6097,'def_npc_pbs_turret_ew_level0', 1024, 911, 0, 0, NULL, @npcDesc),
(6098,'def_npc_pbs_turret_laser_level1', 1024, 911, 0, 0, NULL, @npcDesc),
(6099,'def_npc_pbs_turret_em_level1', 1024, 911, 0, 0, NULL, @npcDesc),
(6100,'def_npc_pbs_turret_missile_level1', 1024, 911, 0, 0, NULL, @npcDesc),
(6101,'def_npc_pbs_turret_ew_level1', 1024, 911, 0, 0, NULL, @npcDesc),
(6102,'def_npc_pbs_turret_laser_level2', 1024, 911, 0, 0, NULL, @npcDesc),
(6103,'def_npc_pbs_turret_em_level2', 1024, 911, 0, 0, NULL, @npcDesc),
(6104,'def_npc_pbs_turret_missile_level2', 1024, 911, 0, 0, NULL, @npcDesc),
(6105,'def_npc_pbs_turret_ew_level2', 1024, 911, 0, 0, NULL, @npcDesc),
(6106,'def_npc_pbs_turret_laser_level3', 1024, 911, 0, 0, NULL, @npcDesc),
(6107,'def_npc_pbs_turret_em_level3', 1024, 911, 0, 0, NULL, @npcDesc),
(6108,'def_npc_pbs_turret_missile_level3', 1024, 911, 0, 0, NULL, @npcDesc),
(6109,'def_npc_pbs_turret_ew_level3', 1024, 911, 0, 0, NULL, @npcDesc);


DROP TABLE IF EXISTS #TEMPRELATIONS;
CREATE TABLE #TEMPRELATIONS
(
	defName varchar(100),
	tempName varchar(100),
	epKill INT,
);
INSERT INTO #TEMPRELATIONS (defName, tempName, epKill) VALUES
('def_npc_pbs_turret_laser_level0', 'def_npc_pbs_turret_laser_template', 10),
('def_npc_pbs_turret_em_level0', 'def_npc_pbs_turret_em_temlate', 10),
('def_npc_pbs_turret_missile_level0', 'def_npc_pbs_turret_missile_template', 10),
('def_npc_pbs_turret_ew_level0', 'def_npc_pbs_turret_ew_template', 10),

('def_npc_pbs_turret_laser_level1', 'def_npc_pbs_turret_laser_template', 15),
('def_npc_pbs_turret_em_level1', 'def_npc_pbs_turret_em_temlate', 15),
('def_npc_pbs_turret_missile_level1', 'def_npc_pbs_turret_missile_template', 15),
('def_npc_pbs_turret_ew_level1', 'def_npc_pbs_turret_ew_template', 15),

('def_npc_pbs_turret_laser_level2', 'def_npc_pbs_turret_laser_template', 20),
('def_npc_pbs_turret_em_level2', 'def_npc_pbs_turret_em_temlate', 20),
('def_npc_pbs_turret_missile_level2', 'def_npc_pbs_turret_missile_template', 20),
('def_npc_pbs_turret_ew_level2', 'def_npc_pbs_turret_ew_template', 20),

('def_npc_pbs_turret_laser_level3', 'def_npc_pbs_turret_laser_template', 30),
('def_npc_pbs_turret_em_level3', 'def_npc_pbs_turret_em_temlate', 30),
('def_npc_pbs_turret_missile_level3', 'def_npc_pbs_turret_missile_template', 30),
('def_npc_pbs_turret_ew_level3', 'def_npc_pbs_turret_ew_template', 30);


DROP TABLE IF EXISTS #STATS;
CREATE TABLE #STATS
(
	defName varchar(100),
	fieldName varchar(100),
	fieldValue float,
);
INSERT INTO #STATS (defName, fieldName, fieldValue) VALUES
('def_npc_pbs_base_small_rank1', 'stealth_strength_modifier', -90), --JUST FOR TESTING

('def_npc_pbs_turret_laser_level0', 'armor_max_modifier', @armor_max_level0),
('def_npc_pbs_turret_laser_level0', 'armor_repair_amount_modifier', @turretRepAmountMod_level0),
('def_npc_pbs_turret_laser_level0', 'armor_repair_cycle_time_modifier', @turretRepRateMod),
('def_npc_pbs_turret_laser_level0', 'core_max_modifier',2),
('def_npc_pbs_turret_laser_level0', 'core_recharge_time_modifier',0.5),
('def_npc_pbs_turret_laser_level0', 'damage_modifier', @turretDamageMod_level0),
('def_npc_pbs_turret_laser_level0', 'falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_laser_level0', 'locking_range_modifier', @turretLockRangeMod),
('def_npc_pbs_turret_laser_level0', 'locking_time_modifier', 1.25),
('def_npc_pbs_turret_laser_level0', 'missile_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_laser_level0', 'optimal_range_modifier', @turretOptimalMod_level0),
('def_npc_pbs_turret_laser_level0', 'turret_fallof_modifier', @turretFalloffMod),
('def_npc_pbs_turret_laser_level0', 'resist_chemical',@resist_level0),
('def_npc_pbs_turret_laser_level0', 'resist_explosive', @resist_level0),
('def_npc_pbs_turret_laser_level0', 'resist_kinetic', @resist_level0),
('def_npc_pbs_turret_laser_level0', 'resist_thermal', @resist_level0*@peakResistMod),
('def_npc_pbs_turret_laser_level0', 'turret_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_laser_level0', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_turret_em_level0', 'armor_max_modifier', @armor_max_level0),
('def_npc_pbs_turret_em_level0', 'armor_repair_amount_modifier', @turretRepAmountMod_level0),
('def_npc_pbs_turret_em_level0', 'armor_repair_cycle_time_modifier', @turretRepRateMod),
('def_npc_pbs_turret_em_level0', 'core_max_modifier',2),
('def_npc_pbs_turret_em_level0', 'core_recharge_time_modifier',0.5),
('def_npc_pbs_turret_em_level0', 'damage_modifier', @turretDamageMod_level0),
('def_npc_pbs_turret_em_level0', 'falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_em_level0', 'locking_range_modifier', @turretLockRangeMod),
('def_npc_pbs_turret_em_level0', 'locking_time_modifier', 1.25),
('def_npc_pbs_turret_em_level0', 'missile_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_em_level0', 'optimal_range_modifier', @turretOptimalMod_level0),
('def_npc_pbs_turret_em_level0', 'turret_fallof_modifier', @turretFalloffMod),
('def_npc_pbs_turret_em_level0', 'resist_chemical', @resist_level0),
('def_npc_pbs_turret_em_level0', 'resist_explosive', @resist_level0),
('def_npc_pbs_turret_em_level0', 'resist_kinetic', @resist_level0*@peakResistMod),
('def_npc_pbs_turret_em_level0', 'resist_thermal', @resist_level0),--TODO
('def_npc_pbs_turret_em_level0', 'turret_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_em_level0', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_turret_missile_level0', 'armor_max_modifier', @armor_max_level0),
('def_npc_pbs_turret_missile_level0', 'armor_repair_amount_modifier', @turretRepAmountMod_level0),
('def_npc_pbs_turret_missile_level0', 'armor_repair_cycle_time_modifier', @turretRepRateMod),
('def_npc_pbs_turret_missile_level0', 'core_max_modifier',2),
('def_npc_pbs_turret_missile_level0', 'core_recharge_time_modifier',0.5),
('def_npc_pbs_turret_missile_level0', 'damage_modifier', @turretDamageMod_level0),
('def_npc_pbs_turret_missile_level0', 'falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_missile_level0', 'locking_range_modifier', @turretLockRangeMod),
('def_npc_pbs_turret_missile_level0', 'locking_time_modifier', 1.25),
('def_npc_pbs_turret_missile_level0', 'missile_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_missile_level0', 'effect_missile_range_modifier', 1.1),
('def_npc_pbs_turret_missile_level0', 'optimal_range_modifier', @turretOptimalMod_level0),
('def_npc_pbs_turret_missile_level0', 'missile_falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_missile_level0', 'resist_chemical', @resist_level0),
('def_npc_pbs_turret_missile_level0', 'resist_explosive', @resist_level0*@peakResistMod),
('def_npc_pbs_turret_missile_level0', 'resist_kinetic', @resist_level0),
('def_npc_pbs_turret_missile_level0', 'resist_thermal', @resist_level0),
('def_npc_pbs_turret_missile_level0', 'turret_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_missile_level0', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_turret_ew_level0', 'armor_max_modifier', @armor_max_level0),
('def_npc_pbs_turret_ew_level0', 'armor_repair_amount_modifier', @turretRepAmountMod_level0),
('def_npc_pbs_turret_ew_level0', 'armor_repair_cycle_time_modifier', @turretRepRateMod),
('def_npc_pbs_turret_ew_level0', 'core_max_modifier',2),
('def_npc_pbs_turret_ew_level0', 'core_recharge_time_modifier',0.5),
('def_npc_pbs_turret_ew_level0', 'damage_modifier', @turretDamageMod_level0),
('def_npc_pbs_turret_ew_level0', 'ecm_strength_modifier', @turretDamageMod_level0),
('def_npc_pbs_turret_ew_level0', 'energy_neutralized_amount_modifier', @turretDamageMod_level0),
('def_npc_pbs_turret_ew_level0', 'falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_ew_level0', 'locking_range_modifier', @turretLockRangeMod),
('def_npc_pbs_turret_ew_level0', 'locking_time_modifier', 1.25),
('def_npc_pbs_turret_ew_level0', 'missile_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_ew_level0', 'optimal_range_modifier', @turretOptimalMod_level0),
('def_npc_pbs_turret_ew_level0', 'resist_chemical', @resist_level0*@peakResistMod),
('def_npc_pbs_turret_ew_level0', 'resist_explosive', @resist_level0),
('def_npc_pbs_turret_ew_level0', 'resist_kinetic', @resist_level0),
('def_npc_pbs_turret_ew_level0', 'resist_thermal', @resist_level0),
('def_npc_pbs_turret_ew_level0', 'turret_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_ew_level0', 'received_repaired_modifier', 1.1);

INSERT INTO #STATS (defName, fieldName, fieldValue) VALUES
('def_npc_pbs_turret_laser_level1', 'armor_max_modifier', @armor_max_level1),
('def_npc_pbs_turret_laser_level1', 'armor_repair_amount_modifier', @turretRepAmountMod_level1),
('def_npc_pbs_turret_laser_level1', 'armor_repair_cycle_time_modifier', @turretRepRateMod),
('def_npc_pbs_turret_laser_level1', 'core_max_modifier',2),
('def_npc_pbs_turret_laser_level1', 'core_recharge_time_modifier',0.5),
('def_npc_pbs_turret_laser_level1', 'damage_modifier', @turretDamageMod_level1),
('def_npc_pbs_turret_laser_level1', 'falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_laser_level1', 'locking_range_modifier', @turretLockRangeMod),
('def_npc_pbs_turret_laser_level1', 'locking_time_modifier', 1.25),
('def_npc_pbs_turret_laser_level1', 'missile_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_laser_level1', 'optimal_range_modifier', @turretOptimalMod_level1),
('def_npc_pbs_turret_laser_level1', 'turret_fallof_modifier', @turretFalloffMod),
('def_npc_pbs_turret_laser_level1', 'resist_chemical',@resist_level1),
('def_npc_pbs_turret_laser_level1', 'resist_explosive', @resist_level1),
('def_npc_pbs_turret_laser_level1', 'resist_kinetic', @resist_level1),
('def_npc_pbs_turret_laser_level1', 'resist_thermal', @resist_level1*@peakResistMod),
('def_npc_pbs_turret_laser_level1', 'turret_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_laser_level1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_turret_em_level1', 'armor_max_modifier', @armor_max_level1),
('def_npc_pbs_turret_em_level1', 'armor_repair_amount_modifier', @turretRepAmountMod_level1),
('def_npc_pbs_turret_em_level1', 'armor_repair_cycle_time_modifier', @turretRepRateMod),
('def_npc_pbs_turret_em_level1', 'core_max_modifier',2),
('def_npc_pbs_turret_em_level1', 'core_recharge_time_modifier',0.5),
('def_npc_pbs_turret_em_level1', 'damage_modifier', @turretDamageMod_level1),
('def_npc_pbs_turret_em_level1', 'falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_em_level1', 'locking_range_modifier', @turretLockRangeMod),
('def_npc_pbs_turret_em_level1', 'locking_time_modifier', 1.25),
('def_npc_pbs_turret_em_level1', 'missile_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_em_level1', 'optimal_range_modifier', @turretOptimalMod_level1),
('def_npc_pbs_turret_em_level1', 'turret_fallof_modifier', @turretFalloffMod),
('def_npc_pbs_turret_em_level1', 'resist_chemical', @resist_level1),
('def_npc_pbs_turret_em_level1', 'resist_explosive', @resist_level1),
('def_npc_pbs_turret_em_level1', 'resist_kinetic', @resist_level1*@peakResistMod),
('def_npc_pbs_turret_em_level1', 'resist_thermal', @resist_level1),--TODO
('def_npc_pbs_turret_em_level1', 'turret_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_em_level1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_turret_missile_level1', 'armor_max_modifier', @armor_max_level1),
('def_npc_pbs_turret_missile_level1', 'armor_repair_amount_modifier', @turretRepAmountMod_level1),
('def_npc_pbs_turret_missile_level1', 'armor_repair_cycle_time_modifier', @turretRepRateMod),
('def_npc_pbs_turret_missile_level1', 'core_max_modifier',2),
('def_npc_pbs_turret_missile_level1', 'core_recharge_time_modifier',0.5),
('def_npc_pbs_turret_missile_level1', 'damage_modifier', @turretDamageMod_level1),
('def_npc_pbs_turret_missile_level1', 'falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_missile_level1', 'locking_range_modifier', @turretLockRangeMod),
('def_npc_pbs_turret_missile_level1', 'locking_time_modifier', 1.25),
('def_npc_pbs_turret_missile_level1', 'missile_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_missile_level1', 'effect_missile_range_modifier', 1.1),
('def_npc_pbs_turret_missile_level1', 'optimal_range_modifier', @turretOptimalMod_level1),
('def_npc_pbs_turret_missile_level1', 'missile_falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_missile_level1', 'resist_chemical', @resist_level1),
('def_npc_pbs_turret_missile_level1', 'resist_explosive', @resist_level1*@peakResistMod),
('def_npc_pbs_turret_missile_level1', 'resist_kinetic', @resist_level1),
('def_npc_pbs_turret_missile_level1', 'resist_thermal', @resist_level1),
('def_npc_pbs_turret_missile_level1', 'turret_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_missile_level1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_turret_ew_level1', 'armor_max_modifier', @armor_max_level1),
('def_npc_pbs_turret_ew_level1', 'armor_repair_amount_modifier', @turretRepAmountMod_level1),
('def_npc_pbs_turret_ew_level1', 'armor_repair_cycle_time_modifier', @turretRepRateMod),
('def_npc_pbs_turret_ew_level1', 'core_max_modifier',2),
('def_npc_pbs_turret_ew_level1', 'core_recharge_time_modifier',0.5),
('def_npc_pbs_turret_ew_level1', 'damage_modifier', @turretDamageMod_level1),
('def_npc_pbs_turret_ew_level1', 'ecm_strength_modifier', @turretDamageMod_level1),
('def_npc_pbs_turret_ew_level1', 'energy_neutralized_amount_modifier', @turretDamageMod_level1),
('def_npc_pbs_turret_ew_level1', 'falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_ew_level1', 'locking_range_modifier', @turretLockRangeMod),
('def_npc_pbs_turret_ew_level1', 'locking_time_modifier', 1.25),
('def_npc_pbs_turret_ew_level1', 'missile_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_ew_level1', 'optimal_range_modifier', @turretOptimalMod_level1),
('def_npc_pbs_turret_ew_level1', 'resist_chemical', @resist_level1*@peakResistMod),
('def_npc_pbs_turret_ew_level1', 'resist_explosive', @resist_level1),
('def_npc_pbs_turret_ew_level1', 'resist_kinetic', @resist_level1),
('def_npc_pbs_turret_ew_level1', 'resist_thermal', @resist_level1),
('def_npc_pbs_turret_ew_level1', 'turret_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_ew_level1', 'received_repaired_modifier', 1.1);

INSERT INTO #STATS (defName, fieldName, fieldValue) VALUES
('def_npc_pbs_turret_laser_level2', 'armor_max_modifier', @armor_max_level2),
('def_npc_pbs_turret_laser_level2', 'armor_repair_amount_modifier', @turretRepAmountMod_level2),
('def_npc_pbs_turret_laser_level2', 'armor_repair_cycle_time_modifier', @turretRepRateMod),
('def_npc_pbs_turret_laser_level2', 'core_max_modifier',2),
('def_npc_pbs_turret_laser_level2', 'core_recharge_time_modifier',0.5),
('def_npc_pbs_turret_laser_level2', 'damage_modifier', @turretDamageMod_level2),
('def_npc_pbs_turret_laser_level2', 'falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_laser_level2', 'locking_range_modifier', @turretLockRangeMod),
('def_npc_pbs_turret_laser_level2', 'locking_time_modifier', 1.25),
('def_npc_pbs_turret_laser_level2', 'missile_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_laser_level2', 'optimal_range_modifier', @turretOptimalMod_level2),
('def_npc_pbs_turret_laser_level2', 'turret_fallof_modifier', @turretFalloffMod),
('def_npc_pbs_turret_laser_level2', 'resist_chemical',@resist_level2),
('def_npc_pbs_turret_laser_level2', 'resist_explosive', @resist_level2),
('def_npc_pbs_turret_laser_level2', 'resist_kinetic', @resist_level2),
('def_npc_pbs_turret_laser_level2', 'resist_thermal', @resist_level2*@peakResistMod),
('def_npc_pbs_turret_laser_level2', 'turret_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_laser_level2', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_turret_em_level2', 'armor_max_modifier', @armor_max_level2),
('def_npc_pbs_turret_em_level2', 'armor_repair_amount_modifier', @turretRepAmountMod_level2),
('def_npc_pbs_turret_em_level2', 'armor_repair_cycle_time_modifier', @turretRepRateMod),
('def_npc_pbs_turret_em_level2', 'core_max_modifier',2),
('def_npc_pbs_turret_em_level2', 'core_recharge_time_modifier',0.5),
('def_npc_pbs_turret_em_level2', 'damage_modifier', @turretDamageMod_level2),
('def_npc_pbs_turret_em_level2', 'falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_em_level2', 'locking_range_modifier', @turretLockRangeMod),
('def_npc_pbs_turret_em_level2', 'locking_time_modifier', 1.25),
('def_npc_pbs_turret_em_level2', 'missile_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_em_level2', 'optimal_range_modifier', @turretOptimalMod_level2),
('def_npc_pbs_turret_em_level2', 'turret_fallof_modifier', @turretFalloffMod),
('def_npc_pbs_turret_em_level2', 'resist_chemical', @resist_level2),
('def_npc_pbs_turret_em_level2', 'resist_explosive', @resist_level2),
('def_npc_pbs_turret_em_level2', 'resist_kinetic', @resist_level2*@peakResistMod),
('def_npc_pbs_turret_em_level2', 'resist_thermal', @resist_level2),--TODO
('def_npc_pbs_turret_em_level2', 'turret_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_em_level2', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_turret_missile_level2', 'armor_max_modifier', @armor_max_level2),
('def_npc_pbs_turret_missile_level2', 'armor_repair_amount_modifier', @turretRepAmountMod_level2),
('def_npc_pbs_turret_missile_level2', 'armor_repair_cycle_time_modifier', @turretRepRateMod),
('def_npc_pbs_turret_missile_level2', 'core_max_modifier',2),
('def_npc_pbs_turret_missile_level2', 'core_recharge_time_modifier',0.5),
('def_npc_pbs_turret_missile_level2', 'damage_modifier', @turretDamageMod_level2),
('def_npc_pbs_turret_missile_level2', 'falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_missile_level2', 'locking_range_modifier', @turretLockRangeMod),
('def_npc_pbs_turret_missile_level2', 'locking_time_modifier', 1.25),
('def_npc_pbs_turret_missile_level2', 'missile_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_missile_level2', 'effect_missile_range_modifier', 1.1),
('def_npc_pbs_turret_missile_level2', 'optimal_range_modifier', @turretOptimalMod_level2),
('def_npc_pbs_turret_missile_level2', 'missile_falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_missile_level2', 'resist_chemical', @resist_level2),
('def_npc_pbs_turret_missile_level2', 'resist_explosive', @resist_level2*@peakResistMod),
('def_npc_pbs_turret_missile_level2', 'resist_kinetic', @resist_level2),
('def_npc_pbs_turret_missile_level2', 'resist_thermal', @resist_level2),
('def_npc_pbs_turret_missile_level2', 'turret_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_missile_level2', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_turret_ew_level2', 'armor_max_modifier', @armor_max_level2),
('def_npc_pbs_turret_ew_level2', 'armor_repair_amount_modifier', @turretRepAmountMod_level2),
('def_npc_pbs_turret_ew_level2', 'armor_repair_cycle_time_modifier', @turretRepRateMod),
('def_npc_pbs_turret_ew_level2', 'core_max_modifier',2),
('def_npc_pbs_turret_ew_level2', 'core_recharge_time_modifier',0.5),
('def_npc_pbs_turret_ew_level2', 'damage_modifier', @turretDamageMod_level2),
('def_npc_pbs_turret_ew_level2', 'ecm_strength_modifier', @turretDamageMod_level2),
('def_npc_pbs_turret_ew_level2', 'energy_neutralized_amount_modifier', @turretDamageMod_level2),
('def_npc_pbs_turret_ew_level2', 'falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_ew_level2', 'locking_range_modifier', @turretLockRangeMod),
('def_npc_pbs_turret_ew_level2', 'locking_time_modifier', 1.25),
('def_npc_pbs_turret_ew_level2', 'missile_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_ew_level2', 'optimal_range_modifier', @turretOptimalMod_level2),
('def_npc_pbs_turret_ew_level2', 'resist_chemical', @resist_level2*@peakResistMod),
('def_npc_pbs_turret_ew_level2', 'resist_explosive', @resist_level2),
('def_npc_pbs_turret_ew_level2', 'resist_kinetic', @resist_level2),
('def_npc_pbs_turret_ew_level2', 'resist_thermal', @resist_level2),
('def_npc_pbs_turret_ew_level2', 'turret_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_ew_level2', 'received_repaired_modifier', 1.1);


INSERT INTO #STATS (defName, fieldName, fieldValue) VALUES
('def_npc_pbs_turret_laser_level3', 'armor_max_modifier', @armor_max_level3),
('def_npc_pbs_turret_laser_level3', 'armor_repair_amount_modifier', @turretRepAmountMod_level3),
('def_npc_pbs_turret_laser_level3', 'armor_repair_cycle_time_modifier', @turretRepRateMod),
('def_npc_pbs_turret_laser_level3', 'core_max_modifier',2),
('def_npc_pbs_turret_laser_level3', 'core_recharge_time_modifier',0.5),
('def_npc_pbs_turret_laser_level3', 'damage_modifier', @turretDamageMod_level3),
('def_npc_pbs_turret_laser_level3', 'falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_laser_level3', 'locking_range_modifier', @turretLockRangeMod),
('def_npc_pbs_turret_laser_level3', 'locking_time_modifier', 1.25),
('def_npc_pbs_turret_laser_level3', 'missile_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_laser_level3', 'optimal_range_modifier', @turretOptimalMod_level3),
('def_npc_pbs_turret_laser_level3', 'turret_fallof_modifier', @turretFalloffMod),
('def_npc_pbs_turret_laser_level3', 'resist_chemical',@resist_level3),
('def_npc_pbs_turret_laser_level3', 'resist_explosive', @resist_level3),
('def_npc_pbs_turret_laser_level3', 'resist_kinetic', @resist_level3),
('def_npc_pbs_turret_laser_level3', 'resist_thermal', @resist_level3*@peakResistMod),
('def_npc_pbs_turret_laser_level3', 'turret_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_laser_level3', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_turret_em_level3', 'armor_max_modifier', @armor_max_level3),
('def_npc_pbs_turret_em_level3', 'armor_repair_amount_modifier', @turretRepAmountMod_level3),
('def_npc_pbs_turret_em_level3', 'armor_repair_cycle_time_modifier', @turretRepRateMod),
('def_npc_pbs_turret_em_level3', 'core_max_modifier',2),
('def_npc_pbs_turret_em_level3', 'core_recharge_time_modifier',0.5),
('def_npc_pbs_turret_em_level3', 'damage_modifier', @turretDamageMod_level3),
('def_npc_pbs_turret_em_level3', 'falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_em_level3', 'locking_range_modifier', @turretLockRangeMod),
('def_npc_pbs_turret_em_level3', 'locking_time_modifier', 1.25),
('def_npc_pbs_turret_em_level3', 'missile_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_em_level3', 'optimal_range_modifier', @turretOptimalMod_level3),
('def_npc_pbs_turret_em_level3', 'turret_fallof_modifier', @turretFalloffMod),
('def_npc_pbs_turret_em_level3', 'resist_chemical', @resist_level3),
('def_npc_pbs_turret_em_level3', 'resist_explosive', @resist_level3),
('def_npc_pbs_turret_em_level3', 'resist_kinetic', @resist_level3*@peakResistMod),
('def_npc_pbs_turret_em_level3', 'resist_thermal', @resist_level3),--TODO
('def_npc_pbs_turret_em_level3', 'turret_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_em_level3', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_turret_missile_level3', 'armor_max_modifier', @armor_max_level3),
('def_npc_pbs_turret_missile_level3', 'armor_repair_amount_modifier', @turretRepAmountMod_level3),
('def_npc_pbs_turret_missile_level3', 'armor_repair_cycle_time_modifier', @turretRepRateMod),
('def_npc_pbs_turret_missile_level3', 'core_max_modifier',2),
('def_npc_pbs_turret_missile_level3', 'core_recharge_time_modifier',0.5),
('def_npc_pbs_turret_missile_level3', 'damage_modifier', @turretDamageMod_level3),
('def_npc_pbs_turret_missile_level3', 'falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_missile_level3', 'locking_range_modifier', @turretLockRangeMod),
('def_npc_pbs_turret_missile_level3', 'locking_time_modifier', 1.25),
('def_npc_pbs_turret_missile_level3', 'missile_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_missile_level3', 'effect_missile_range_modifier', 1.1),
('def_npc_pbs_turret_missile_level3', 'optimal_range_modifier', @turretOptimalMod_level3),
('def_npc_pbs_turret_missile_level3', 'missile_falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_missile_level3', 'resist_chemical', @resist_level3),
('def_npc_pbs_turret_missile_level3', 'resist_explosive', @resist_level3*@peakResistMod),
('def_npc_pbs_turret_missile_level3', 'resist_kinetic', @resist_level3),
('def_npc_pbs_turret_missile_level3', 'resist_thermal', @resist_level3),
('def_npc_pbs_turret_missile_level3', 'turret_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_missile_level3', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_turret_ew_level3', 'armor_max_modifier', @armor_max_level3),
('def_npc_pbs_turret_ew_level3', 'armor_repair_amount_modifier', @turretRepAmountMod_level3),
('def_npc_pbs_turret_ew_level3', 'armor_repair_cycle_time_modifier', @turretRepRateMod),
('def_npc_pbs_turret_ew_level3', 'core_max_modifier',2),
('def_npc_pbs_turret_ew_level3', 'core_recharge_time_modifier',0.5),
('def_npc_pbs_turret_ew_level3', 'damage_modifier', @turretDamageMod_level3),
('def_npc_pbs_turret_ew_level3', 'ecm_strength_modifier', @turretDamageMod_level3),
('def_npc_pbs_turret_ew_level3', 'energy_neutralized_amount_modifier', @turretDamageMod_level3),
('def_npc_pbs_turret_ew_level3', 'falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_ew_level3', 'locking_range_modifier', @turretLockRangeMod),
('def_npc_pbs_turret_ew_level3', 'locking_time_modifier', 1.25),
('def_npc_pbs_turret_ew_level3', 'missile_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_ew_level3', 'optimal_range_modifier', @turretOptimalMod_level3),
('def_npc_pbs_turret_ew_level3', 'resist_chemical', @resist_level3*@peakResistMod),
('def_npc_pbs_turret_ew_level3', 'resist_explosive', @resist_level3),
('def_npc_pbs_turret_ew_level3', 'resist_kinetic', @resist_level3),
('def_npc_pbs_turret_ew_level3', 'resist_thermal', @resist_level3),
('def_npc_pbs_turret_ew_level3', 'turret_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_ew_level3', 'received_repaired_modifier', 1.1);


SET IDENTITY_INSERT [dbo].[entitydefaults] ON;
PRINT N'UPDATE/INSERT ENTITY DEFS for NPC PBS definitions';
--Update/insert [entitydefaults] entries
MERGE [dbo].[entitydefaults] def USING #ENTITYDEFS d2
ON def.definition = d2.def
WHEN MATCHED
    THEN UPDATE SET
		definitionname=defName,
		categoryflags=catFlags,
		attributeflags=attrFlags,
		volume=cargoVolume,
		mass=massOfModule,
		tiertype=NULL,
		tierlevel=NULL,
		options=genxyOptStr,
		enabled=1,
		hidden=0,
		purchasable=0,
		descriptiontoken=description
WHEN NOT MATCHED
    THEN INSERT (definition, definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel) VALUES
	(def, defName, 1, attrFlags, catFlags, genxyOptStr, 'NPC PBS components and bot definitions', 1 ,cargoVolume, massOfModule, 0, 100, description, 0, NULL, NULL);
SET IDENTITY_INSERT [dbo].[entitydefaults] OFF;

PRINT N'DELETE OLD STATS (0 results if 1st run)';
DELETE FROM aggregatevalues WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #STATS));

PRINT N'INSERT NEW STATS';
INSERT INTO aggregatevalues (definition, field, value)
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defName), 
	(SELECT TOP 1 id FROM aggregatefields WHERE name=fieldName), 
	fieldValue
FROM #STATS;

PRINT N'DELETE OLD robottemplaterelation (0 results if 1st run)';
DELETE FROM robottemplaterelation WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #TEMPRELATIONS));
PRINT N'INSERT robottemplaterelation';
INSERT INTO robottemplaterelation ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
SELECT
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=t.defName),
	(SELECT TOP 1 id FROM robottemplates WHERE name=t.tempName),
	0, 0, NULL, NULL, t.epKill, 'Relate: '+t.defName+ '<->'+t.tempName
FROM #TEMPRELATIONS AS t;
DROP TABLE IF EXISTS #TEMPRELATIONS;
DROP TABLE IF EXISTS #TEMPLATES;
DROP TABLE IF EXISTS #STATS;
DROP TABLE IF EXISTS #ENTITYDEFS;
GO

USE [perpetuumsa]
GO
PRINT N'LOOTS';

DROP TABLE IF EXISTS #NPCLOOTS;
CREATE TABLE #NPCLOOTS(
	defName varchar(128),
	lootName varchar(128),
	minQuantity int,
	maxQuantity int,
	probability float,
);
INSERT INTO #NPCLOOTS(defName, lootName, minQuantity, maxQuantity, probability) VALUES
('def_npc_pbs_turret_em_level0','def_titanium',5,10,0.5),
('def_npc_pbs_turret_em_level0','def_hydrobenol',75,150,0.5),
('def_npc_pbs_turret_em_level0','def_espitium',50,100,0.5),
('def_npc_pbs_turret_em_level0','def_unimetal',10,20,0.5),
('def_npc_pbs_turret_em_level0','def_axicol',25,50,0.5),
('def_npc_pbs_turret_em_level0','def_axicoline',37,75,0.5),
('def_npc_pbs_turret_em_level0','def_gamma_buildblock',5,10,0.5),
('def_npc_pbs_turret_em_level0','def_gamma_energyblock',25,50,0.5),
('def_npc_pbs_turret_em_level0','def_gamma_offenseblock',37,75,0.5),
('def_npc_pbs_turret_em_level0','def_nuimqol_reactor_plasma',500,1000,1),
('def_npc_pbs_turret_em_level0','def_kernel_nuimqol',500,1000,1),
('def_npc_pbs_turret_em_level0','def_robotshard_nuimqol_basic',30,30,1),
('def_npc_pbs_turret_em_level0','def_robotshard_nuimqol_advanced',20,20,1),
('def_npc_pbs_turret_em_level0','def_robotshard_nuimqol_expert',10,10,1),
('def_npc_pbs_turret_ew_level0','def_titanium',5,10,0.5),
('def_npc_pbs_turret_ew_level0','def_hydrobenol',75,150,0.5),
('def_npc_pbs_turret_ew_level0','def_espitium',50,100,0.5),
('def_npc_pbs_turret_ew_level0','def_unimetal',10,20,0.5),
('def_npc_pbs_turret_ew_level0','def_axicol',25,50,0.5),
('def_npc_pbs_turret_ew_level0','def_axicoline',37,75,0.5),
('def_npc_pbs_turret_ew_level0','def_gamma_buildblock',5,10,0.5),
('def_npc_pbs_turret_ew_level0','def_gamma_energyblock',25,50,0.5),
('def_npc_pbs_turret_ew_level0','def_gamma_offenseblock',37,75,0.5),
('def_npc_pbs_turret_ew_level0','def_common_reactor_plasma',500,1000,1),
('def_npc_pbs_turret_ew_level0','def_kernel_common',500,1000,1),
('def_npc_pbs_turret_ew_level0','def_kernel_hitech',250,500,1),
('def_npc_pbs_turret_ew_level0','def_robotshard_common_basic',30,30,1),
('def_npc_pbs_turret_ew_level0','def_robotshard_common_advanced',20,20,1),
('def_npc_pbs_turret_ew_level0','def_robotshard_common_expert',10,10,1),
('def_npc_pbs_turret_laser_level0','def_titanium',5,10,0.5),
('def_npc_pbs_turret_laser_level0','def_hydrobenol',75,150,0.5),
('def_npc_pbs_turret_laser_level0','def_espitium',50,100,0.5),
('def_npc_pbs_turret_laser_level0','def_unimetal',10,20,0.5),
('def_npc_pbs_turret_laser_level0','def_axicol',25,50,0.5),
('def_npc_pbs_turret_laser_level0','def_axicoline',37,75,0.5),
('def_npc_pbs_turret_laser_level0','def_gamma_buildblock',5,10,0.5),
('def_npc_pbs_turret_laser_level0','def_gamma_energyblock',25,50,0.5),
('def_npc_pbs_turret_laser_level0','def_gamma_offenseblock',37,75,0.5),
('def_npc_pbs_turret_laser_level0','def_thelodica_reactor_plasma',500,1000,1),
('def_npc_pbs_turret_laser_level0','def_kernel_thelodica',500,1000,1),
('def_npc_pbs_turret_laser_level0','def_robotshard_thelodica_basic',30,30,1),
('def_npc_pbs_turret_laser_level0','def_robotshard_thelodica_advanced',20,20,1),
('def_npc_pbs_turret_laser_level0','def_robotshard_thelodica_expert',10,10,1),
('def_npc_pbs_turret_missile_level0','def_titanium',5,10,0.5),
('def_npc_pbs_turret_missile_level0','def_hydrobenol',75,150,0.5),
('def_npc_pbs_turret_missile_level0','def_espitium',50,100,0.5),
('def_npc_pbs_turret_missile_level0','def_unimetal',10,20,0.5),
('def_npc_pbs_turret_missile_level0','def_axicol',25,50,0.5),
('def_npc_pbs_turret_missile_level0','def_axicoline',37,75,0.5),
('def_npc_pbs_turret_missile_level0','def_gamma_buildblock',5,10,0.5),
('def_npc_pbs_turret_missile_level0','def_gamma_energyblock',25,50,0.5),
('def_npc_pbs_turret_missile_level0','def_gamma_offenseblock',37,75,0.5),
('def_npc_pbs_turret_missile_level0','def_pelistal_reactor_plasma',500,1000,1),
('def_npc_pbs_turret_missile_level0','def_kernel_pelistal',500,1000,1),
('def_npc_pbs_turret_missile_level0','def_robotshard_pelistal_basic',30,30,1),
('def_npc_pbs_turret_missile_level0','def_robotshard_pelistal_advanced',20,20,1),
('def_npc_pbs_turret_missile_level0','def_robotshard_pelistal_expert',10,10,1),
--
('def_npc_pbs_turret_em_level1','def_titanium',5,10,0.75),
('def_npc_pbs_turret_em_level1','def_hydrobenol',75,150,0.75),
('def_npc_pbs_turret_em_level1','def_espitium',50,100,0.75),
('def_npc_pbs_turret_em_level1','def_unimetal',10,20,0.75),
('def_npc_pbs_turret_em_level1','def_axicol',25,50,0.75),
('def_npc_pbs_turret_em_level1','def_axicoline',37,75,0.75),
('def_npc_pbs_turret_em_level1','def_gamma_buildblock',5,10,0.75),
('def_npc_pbs_turret_em_level1','def_gamma_energyblock',25,50,0.75),
('def_npc_pbs_turret_em_level1','def_gamma_offenseblock',37,75,0.75),
('def_npc_pbs_turret_em_level1','def_nuimqol_reactor_plasma',1000,1100,1),
('def_npc_pbs_turret_em_level1','def_kernel_nuimqol',1000,1100,1),
('def_npc_pbs_turret_em_level1','def_robotshard_nuimqol_basic',30,40,1),
('def_npc_pbs_turret_em_level1','def_robotshard_nuimqol_advanced',20,30,1),
('def_npc_pbs_turret_em_level1','def_robotshard_nuimqol_expert',10,20,1),
('def_npc_pbs_turret_ew_level1','def_titanium',5,10,0.75),
('def_npc_pbs_turret_ew_level1','def_hydrobenol',75,150,0.75),
('def_npc_pbs_turret_ew_level1','def_espitium',50,100,0.75),
('def_npc_pbs_turret_ew_level1','def_unimetal',10,20,0.75),
('def_npc_pbs_turret_ew_level1','def_axicol',25,50,0.75),
('def_npc_pbs_turret_ew_level1','def_axicoline',37,75,0.75),
('def_npc_pbs_turret_ew_level1','def_gamma_buildblock',5,10,0.75),
('def_npc_pbs_turret_ew_level1','def_gamma_energyblock',25,50,0.75),
('def_npc_pbs_turret_ew_level1','def_gamma_offenseblock',37,75,0.75),
('def_npc_pbs_turret_ew_level1','def_common_reactor_plasma',1000,1100,1),
('def_npc_pbs_turret_ew_level1','def_kernel_common',1000,1100,1),
('def_npc_pbs_turret_ew_level1','def_kernel_hitech',500,1100,1),
('def_npc_pbs_turret_ew_level1','def_robotshard_common_basic',30,40,1),
('def_npc_pbs_turret_ew_level1','def_robotshard_common_advanced',20,30,1),
('def_npc_pbs_turret_ew_level1','def_robotshard_common_expert',10,20,1),
('def_npc_pbs_turret_laser_level1','def_titanium',5,10,0.75),
('def_npc_pbs_turret_laser_level1','def_hydrobenol',75,150,0.75),
('def_npc_pbs_turret_laser_level1','def_espitium',50,100,0.75),
('def_npc_pbs_turret_laser_level1','def_unimetal',10,20,0.75),
('def_npc_pbs_turret_laser_level1','def_axicol',25,50,0.75),
('def_npc_pbs_turret_laser_level1','def_axicoline',37,75,0.75),
('def_npc_pbs_turret_laser_level1','def_gamma_buildblock',5,10,0.75),
('def_npc_pbs_turret_laser_level1','def_gamma_energyblock',25,50,0.75),
('def_npc_pbs_turret_laser_level1','def_gamma_offenseblock',37,75,0.75),
('def_npc_pbs_turret_laser_level1','def_thelodica_reactor_plasma',1000,1100,1),
('def_npc_pbs_turret_laser_level1','def_kernel_thelodica',1000,1100,1),
('def_npc_pbs_turret_laser_level1','def_robotshard_thelodica_basic',30,40,1),
('def_npc_pbs_turret_laser_level1','def_robotshard_thelodica_advanced',20,30,1),
('def_npc_pbs_turret_laser_level1','def_robotshard_thelodica_expert',10,20,1),
('def_npc_pbs_turret_missile_level1','def_titanium',5,10,0.75),
('def_npc_pbs_turret_missile_level1','def_hydrobenol',75,150,0.75),
('def_npc_pbs_turret_missile_level1','def_espitium',50,100,0.75),
('def_npc_pbs_turret_missile_level1','def_unimetal',10,20,0.75),
('def_npc_pbs_turret_missile_level1','def_axicol',25,50,0.75),
('def_npc_pbs_turret_missile_level1','def_axicoline',37,75,0.75),
('def_npc_pbs_turret_missile_level1','def_gamma_buildblock',5,10,0.75),
('def_npc_pbs_turret_missile_level1','def_gamma_energyblock',25,50,0.75),
('def_npc_pbs_turret_missile_level1','def_gamma_offenseblock',37,75,0.75),
('def_npc_pbs_turret_missile_level1','def_pelistal_reactor_plasma',1000,1100,1),
('def_npc_pbs_turret_missile_level1','def_kernel_pelistal',1000,1100,1),
('def_npc_pbs_turret_missile_level1','def_robotshard_pelistal_basic',30,40,1),
('def_npc_pbs_turret_missile_level1','def_robotshard_pelistal_advanced',20,30,1),
('def_npc_pbs_turret_missile_level1','def_robotshard_pelistal_expert',10,20,1),
--
('def_npc_pbs_turret_em_level2','def_titanium',5,10,0.9),
('def_npc_pbs_turret_em_level2','def_hydrobenol',75,150,0.9),
('def_npc_pbs_turret_em_level2','def_espitium',50,100,0.9),
('def_npc_pbs_turret_em_level2','def_unimetal',10,20,0.9),
('def_npc_pbs_turret_em_level2','def_axicol',25,50,0.9),
('def_npc_pbs_turret_em_level2','def_axicoline',37,75,0.9),
('def_npc_pbs_turret_em_level2','def_gamma_buildblock',5,10,0.9),
('def_npc_pbs_turret_em_level2','def_gamma_energyblock',25,50,0.9),
('def_npc_pbs_turret_em_level2','def_gamma_offenseblock',37,75,0.9),
('def_npc_pbs_turret_em_level2','def_nuimqol_reactor_plasma',1000,2000,1),
('def_npc_pbs_turret_em_level2','def_kernel_nuimqol',1000,2000,1),
('def_npc_pbs_turret_em_level2','def_robotshard_nuimqol_basic',30,50,1),
('def_npc_pbs_turret_em_level2','def_robotshard_nuimqol_advanced',20,40,1),
('def_npc_pbs_turret_em_level2','def_robotshard_nuimqol_expert',10,30,1),
('def_npc_pbs_turret_ew_level2','def_titanium',5,10,0.9),
('def_npc_pbs_turret_ew_level2','def_hydrobenol',75,150,0.9),
('def_npc_pbs_turret_ew_level2','def_espitium',50,100,0.9),
('def_npc_pbs_turret_ew_level2','def_unimetal',10,20,0.9),
('def_npc_pbs_turret_ew_level2','def_axicol',25,50,0.9),
('def_npc_pbs_turret_ew_level2','def_axicoline',37,75,0.9),
('def_npc_pbs_turret_ew_level2','def_gamma_buildblock',5,10,0.9),
('def_npc_pbs_turret_ew_level2','def_gamma_energyblock',25,50,0.9),
('def_npc_pbs_turret_ew_level2','def_gamma_offenseblock',37,75,0.9),
('def_npc_pbs_turret_ew_level2','def_common_reactor_plasma',1000,2000,1),
('def_npc_pbs_turret_ew_level2','def_kernel_common',1000,2000,1),
('def_npc_pbs_turret_ew_level2','def_kernel_hitech',500,1000,1),
('def_npc_pbs_turret_ew_level2','def_robotshard_common_basic',30,50,1),
('def_npc_pbs_turret_ew_level2','def_robotshard_common_advanced',20,30,1),
('def_npc_pbs_turret_ew_level2','def_robotshard_common_expert',10,30,1),
('def_npc_pbs_turret_laser_level2','def_titanium',5,10,0.9),
('def_npc_pbs_turret_laser_level2','def_hydrobenol',75,150,0.9),
('def_npc_pbs_turret_laser_level2','def_espitium',50,100,0.9),
('def_npc_pbs_turret_laser_level2','def_unimetal',10,20,0.9),
('def_npc_pbs_turret_laser_level2','def_axicol',25,50,0.9),
('def_npc_pbs_turret_laser_level2','def_axicoline',37,75,0.9),
('def_npc_pbs_turret_laser_level2','def_gamma_buildblock',5,10,0.9),
('def_npc_pbs_turret_laser_level2','def_gamma_energyblock',25,50,0.9),
('def_npc_pbs_turret_laser_level2','def_gamma_offenseblock',37,75,0.9),
('def_npc_pbs_turret_laser_level2','def_thelodica_reactor_plasma',1000,2000,1),
('def_npc_pbs_turret_laser_level2','def_kernel_thelodica',1000,2000,1),
('def_npc_pbs_turret_laser_level2','def_robotshard_thelodica_basic',30,50,1),
('def_npc_pbs_turret_laser_level2','def_robotshard_thelodica_advanced',20,40,1),
('def_npc_pbs_turret_laser_level2','def_robotshard_thelodica_expert',10,30,1),
('def_npc_pbs_turret_missile_level2','def_titanium',5,10,0.9),
('def_npc_pbs_turret_missile_level2','def_hydrobenol',75,150,0.9),
('def_npc_pbs_turret_missile_level2','def_espitium',50,100,0.9),
('def_npc_pbs_turret_missile_level2','def_unimetal',10,20,0.9),
('def_npc_pbs_turret_missile_level2','def_axicol',25,50,0.9),
('def_npc_pbs_turret_missile_level2','def_axicoline',37,75,0.9),
('def_npc_pbs_turret_missile_level2','def_gamma_buildblock',5,10,0.9),
('def_npc_pbs_turret_missile_level2','def_gamma_energyblock',25,50,0.9),
('def_npc_pbs_turret_missile_level2','def_gamma_offenseblock',37,75,0.9),
('def_npc_pbs_turret_missile_level2','def_pelistal_reactor_plasma',1000,2000,1),
('def_npc_pbs_turret_missile_level2','def_kernel_pelistal',1000,2000,1),
('def_npc_pbs_turret_missile_level2','def_robotshard_pelistal_basic',30,50,1),
('def_npc_pbs_turret_missile_level2','def_robotshard_pelistal_advanced',20,40,1),
('def_npc_pbs_turret_missile_level2','def_robotshard_pelistal_expert',10,30,1),
--
('def_npc_pbs_turret_em_level3','def_titanium',5,10,1),
('def_npc_pbs_turret_em_level3','def_hydrobenol',75,150,1),
('def_npc_pbs_turret_em_level3','def_espitium',50,100,1),
('def_npc_pbs_turret_em_level3','def_unimetal',10,20,1),
('def_npc_pbs_turret_em_level3','def_axicol',25,50,1),
('def_npc_pbs_turret_em_level3','def_axicoline',37,75,1),
('def_npc_pbs_turret_em_level3','def_gamma_buildblock',5,10,1),
('def_npc_pbs_turret_em_level3','def_gamma_energyblock',25,50,1),
('def_npc_pbs_turret_em_level3','def_gamma_offenseblock',37,75,1),
('def_npc_pbs_turret_em_level3','def_nuimqol_reactor_plasma',1000,3000,1),
('def_npc_pbs_turret_em_level3','def_kernel_nuimqol',1000,3000,1),
('def_npc_pbs_turret_em_level3','def_robotshard_nuimqol_basic',30,60,1),
('def_npc_pbs_turret_em_level3','def_robotshard_nuimqol_advanced',20,50,1),
('def_npc_pbs_turret_em_level3','def_robotshard_nuimqol_expert',10,40,1),
('def_npc_pbs_turret_ew_level3','def_titanium',5,10,1),
('def_npc_pbs_turret_ew_level3','def_hydrobenol',75,150,1),
('def_npc_pbs_turret_ew_level3','def_espitium',50,100,1),
('def_npc_pbs_turret_ew_level3','def_unimetal',10,20,1),
('def_npc_pbs_turret_ew_level3','def_axicol',25,50,1),
('def_npc_pbs_turret_ew_level3','def_axicoline',37,75,1),
('def_npc_pbs_turret_ew_level3','def_gamma_buildblock',5,10,1),
('def_npc_pbs_turret_ew_level3','def_gamma_energyblock',25,50,1),
('def_npc_pbs_turret_ew_level3','def_gamma_offenseblock',37,75,1),
('def_npc_pbs_turret_ew_level3','def_common_reactor_plasma',1000,3000,1),
('def_npc_pbs_turret_ew_level3','def_kernel_common',1000,3000,1),
('def_npc_pbs_turret_ew_level3','def_kernel_hitech',500,1500,1),
('def_npc_pbs_turret_ew_level3','def_robotshard_common_basic',30,60,1),
('def_npc_pbs_turret_ew_level3','def_robotshard_common_advanced',20,50,1),
('def_npc_pbs_turret_ew_level3','def_robotshard_common_expert',10,40,1),
('def_npc_pbs_turret_laser_level3','def_titanium',5,10,1),
('def_npc_pbs_turret_laser_level3','def_hydrobenol',75,150,1),
('def_npc_pbs_turret_laser_level3','def_espitium',50,100,1),
('def_npc_pbs_turret_laser_level3','def_unimetal',10,20,1),
('def_npc_pbs_turret_laser_level3','def_axicol',25,50,1),
('def_npc_pbs_turret_laser_level3','def_axicoline',37,75,1),
('def_npc_pbs_turret_laser_level3','def_gamma_buildblock',5,10,1),
('def_npc_pbs_turret_laser_level3','def_gamma_energyblock',25,50,1),
('def_npc_pbs_turret_laser_level3','def_gamma_offenseblock',37,75,1),
('def_npc_pbs_turret_laser_level3','def_thelodica_reactor_plasma',1000,3000,1),
('def_npc_pbs_turret_laser_level3','def_kernel_thelodica',1000,3000,1),
('def_npc_pbs_turret_laser_level3','def_robotshard_thelodica_basic',30,60,1),
('def_npc_pbs_turret_laser_level3','def_robotshard_thelodica_advanced',20,50,1),
('def_npc_pbs_turret_laser_level3','def_robotshard_thelodica_expert',10,40,1),
('def_npc_pbs_turret_missile_level3','def_titanium',5,10,1),
('def_npc_pbs_turret_missile_level3','def_hydrobenol',75,150,1),
('def_npc_pbs_turret_missile_level3','def_espitium',50,100,1),
('def_npc_pbs_turret_missile_level3','def_unimetal',10,20,1),
('def_npc_pbs_turret_missile_level3','def_axicol',25,50,1),
('def_npc_pbs_turret_missile_level3','def_axicoline',37,75,1),
('def_npc_pbs_turret_missile_level3','def_gamma_buildblock',5,10,1),
('def_npc_pbs_turret_missile_level3','def_gamma_energyblock',25,50,1),
('def_npc_pbs_turret_missile_level3','def_gamma_offenseblock',37,75,1),
('def_npc_pbs_turret_missile_level3','def_pelistal_reactor_plasma',1000,3000,1),
('def_npc_pbs_turret_missile_level3','def_kernel_pelistal',1000,3000,1),
('def_npc_pbs_turret_missile_level3','def_robotshard_pelistal_basic',30,60,1),
('def_npc_pbs_turret_missile_level3','def_robotshard_pelistal_advanced',20,50,1),
('def_npc_pbs_turret_missile_level3','def_robotshard_pelistal_expert',10,40,1);


PRINT N'DELETE ALL LOOTS (0 if 1st run) FOR NEW NPC DEFS';
DELETE FROM npcloot WHERE definition IN (
	SELECT definition FROM entitydefaults WHERE definitionname IN (
		SELECT DISTINCT defName FROM #NPCLOOTS
	)
);

PRINT N'UPDATE/INSERT ALL LOOTS';
MERGE npcloot n USING #NPCLOOTS o
ON n.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=o.defName) AND
n.lootdefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=o.lootName)
WHEN MATCHED
    THEN UPDATE SET
		minquantity=o.minQuantity,
		quantity=o.maxQuantity,
		probability=o.probability
WHEN NOT MATCHED
    THEN INSERT (definition, lootdefinition, minquantity, quantity, probability, repackaged, dontdamage) VALUES
		((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=o.defName),
		(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=o.lootName),
		o.minQuantity, o.maxQuantity, o.probability, 0, 0);


PRINT N'DONE WITH NPC LOOTS';
DROP TABLE IF EXISTS #NPCLOOTS;
GO


PRINT N'15_fuels_entitydefs_defconfig_insert__2021_09_19.sql';
USE [perpetuumsa]
GO

--------------------------------------------------
-- New Fuel items
-- Date modified: 2021/11/16
-------------------------------------------------

DECLARE @PREFIX AS VARCHAR(128) = 'def_reactor_booster_';
DECLARE @FUEL_CAT AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_pbs_reactor_booster');


DROP TABLE IF EXISTS #ENTITYDEFS;
CREATE TABLE #ENTITYDEFS
(
	def INT,
	defName varchar(100),
	catFlags bigint,
	attrFlags bigint,
	cargoVolume float,
	massOfModule float,
	genxyOptStr varchar(max),
	description varchar(max),
	tierType int null,
	tierLevel int null
);
INSERT INTO #ENTITYDEFS (def, defName, attrFlags, catFlags, cargoVolume, massOfModule, genxyOptStr, description, tierType, tierLevel) VALUES
(4806,@PREFIX+'a', 2052, 916, 10, 15000, '#tier=$tierlevel_t1', @PREFIX+'a_desc', 1, 1),
(6110,@PREFIX+'b', 2052, 916, 15, 15000, '#tier=$tierlevel_t2', @PREFIX+'a_desc', 1, 2),
(6111,@PREFIX+'c', 2052, 916, 25, 15000, '#tier=$tierlevel_t3', @PREFIX+'a_desc', 1, 3),
(6112,@PREFIX+'a_pr', 2052, 916, 10, 15000, '#tier=$tierlevel_t1_pr', @PREFIX+'a_desc', 2, 1),
(6113,@PREFIX+'b_pr', 2052, 916, 15, 15000, '#tier=$tierlevel_t2_pr', @PREFIX+'a_desc', 2, 2),
(6114,@PREFIX+'c_pr', 2052, 916, 25, 15000, '#tier=$tierlevel_t3_pr', @PREFIX+'a_desc', 2, 3),
(5162,@PREFIX+'a_cprg', 1024, 459798, 0.01, 0.1, '#tier=$tierlevel_t1', 'calibration_program_desc', 1, 1),
(6115,@PREFIX+'b_cprg', 1024, 459798, 0.01, 0.1, '#tier=$tierlevel_t2', 'calibration_program_desc', 1, 2),
(6116,@PREFIX+'c_cprg', 1024, 459798, 0.01, 0.1, '#tier=$tierlevel_t3', 'calibration_program_desc', 1, 3);

DROP TABLE IF EXISTS #COSTS;
CREATE TABLE #COSTS(
	category bigint,
	tierlevel int,
	costmod float
);
INSERT INTO #COSTS(category, tierlevel, costmod) VALUES
(@FUEL_CAT, 1, 1),
(@FUEL_CAT, 2, 2),
(@FUEL_CAT, 3, 4);

MERGE productioncost p USING #COSTS c
ON p.category = c.category AND p.tierlevel=c.tierlevel
WHEN MATCHED
    THEN UPDATE SET
		p.costmodifier=c.costmod
WHEN NOT MATCHED
    THEN INSERT (category,tiertype,tierlevel,costmodifier) VALUES
	(c.category,NULL,c.tierlevel,c.costmod);

DROP TABLE IF EXISTS #DURATION;
CREATE TABLE #DURATION(
	category bigint,
	costmod float
);
INSERT INTO #DURATION(category, costmod) VALUES
(@FUEL_CAT, 0.25);


MERGE productionduration p USING #DURATION d
ON p.category = d.category
WHEN MATCHED
    THEN UPDATE SET
		p.durationmodifier=d.costmod
WHEN NOT MATCHED
    THEN INSERT (category,durationmodifier) VALUES
	(d.category, d.costmod);


DROP TABLE IF EXISTS #TREE;
CREATE TABLE #TREE(
	defName varchar(100),
	parentDefName varchar(100) null,
	x int,
	y int
);
INSERT INTO #TREE(defName, parentDefName, x, y) VALUES
(@PREFIX+'a', 'def_pbs_reactor_small_capsule', 2, 2),
(@PREFIX+'b', @PREFIX+'a', 3, 1),
(@PREFIX+'c', @PREFIX+'b', 4, 0);

DROP TABLE IF EXISTS #CORE;
CREATE TABLE #CORE
(
	defName varchar(100),
	energyAmount int
);
INSERT INTO #CORE (defName, energyAmount) VALUES
('def_axicol', 50),
('def_espitium', 500),
('def_specimen_sap_item_flux', 28000),
('def_gamma_energyblock', 2200),
('def_specimen_sap_item', 600000),
('def_corebooster_ammo', 750),
(@PREFIX+'a', 2000000),
(@PREFIX+'b', 4000000),
(@PREFIX+'c', 8000000),
(@PREFIX+'a_pr', 2000000),
(@PREFIX+'b_pr', 4000000),
(@PREFIX+'c_pr', 8000000);

DROP TABLE IF EXISTS #MATS;
CREATE TABLE #MATS
(
	defName varchar(100),
	componentDefName varchar(100),
	amount int
);
INSERT INTO #MATS (defName, componentDefName, amount) VALUES

(@PREFIX+'a','def_titanium',100),
(@PREFIX+'a','def_vitricyl',500),
(@PREFIX+'a','def_prilumium',500),
(@PREFIX+'a','def_chollonin',500),
(@PREFIX+'a','def_espitium',500),
(@PREFIX+'a','def_unimetal',100),
(@PREFIX+'a','def_axicol',500),

(@PREFIX+'a_pr','def_titanium',100),
(@PREFIX+'a_pr','def_vitricyl',500),
(@PREFIX+'a_pr','def_prilumium',500),
(@PREFIX+'a_pr','def_chollonin',500),
(@PREFIX+'a_pr','def_espitium',500),
(@PREFIX+'a_pr','def_unimetal',100),
(@PREFIX+'a_pr','def_axicol',500),

(@PREFIX+'b', 'def_titanium', 150),
(@PREFIX+'b', 'def_axicol', 750),
(@PREFIX+'b', 'def_vitricyl', 750),
(@PREFIX+'b', 'def_chollonin', 750),
(@PREFIX+'b', 'def_prilumium', 750),
(@PREFIX+'b', 'def_espitium', 750),
(@PREFIX+'b', 'def_unimetal', 150),
(@PREFIX+'b', 'def_gamma_energyblock', 50),

(@PREFIX+'b_pr', 'def_titanium', 150),
(@PREFIX+'b_pr', 'def_axicol', 750),
(@PREFIX+'b_pr', 'def_vitricyl', 750),
(@PREFIX+'b_pr', 'def_chollonin', 750),
(@PREFIX+'b_pr', 'def_prilumium', 750),
(@PREFIX+'b_pr', 'def_espitium', 750),
(@PREFIX+'b_pr', 'def_unimetal', 150),
(@PREFIX+'b_pr', 'def_gamma_energyblock', 50),

(@PREFIX+'c', 'def_titanium', 225),
(@PREFIX+'c', 'def_axicol', 1125),
(@PREFIX+'c', 'def_vitricyl', 1125),
(@PREFIX+'c', 'def_chollonin', 1125),
(@PREFIX+'c', 'def_prilumium', 1125),
(@PREFIX+'c', 'def_espitium', 1125),
(@PREFIX+'c', 'def_unimetal', 225),
(@PREFIX+'c', 'def_specimen_sap_item_flux', 20),
(@PREFIX+'c', 'def_gamma_energyblock', 75),

(@PREFIX+'c_pr', 'def_titanium', 225),
(@PREFIX+'c_pr', 'def_axicol', 1125),
(@PREFIX+'c_pr', 'def_vitricyl', 1125),
(@PREFIX+'c_pr', 'def_chollonin', 1125),
(@PREFIX+'c_pr', 'def_prilumium', 1125),
(@PREFIX+'c_pr', 'def_espitium', 1125),
(@PREFIX+'c_pr', 'def_unimetal', 225),
(@PREFIX+'c_pr', 'def_specimen_sap_item_flux', 20),
(@PREFIX+'c_pr', 'def_gamma_energyblock', 75);

DROP TABLE IF EXISTS #PROTOPAIRS;
CREATE TABLE #PROTOPAIRS
(
	defName varchar(100),
	protoDefName varchar(100),
);
INSERT INTO #PROTOPAIRS (defName, protoDefName) VALUES
(@PREFIX+'a', @PREFIX+'a_pr'),
(@PREFIX+'b', @PREFIX+'b_pr'),
(@PREFIX+'c', @PREFIX+'c_pr');

DROP TABLE IF EXISTS #PROTO_TO_CT;
CREATE TABLE #PROTO_TO_CT
(
	protoDefName VARCHAR(100),
	ctDefName VARCHAR(100),
	level INT
);
INSERT INTO #PROTO_TO_CT (protoDefName, ctDefName, level) VALUES
(@PREFIX+'a_pr', @PREFIX+'a_cprg', 2),
(@PREFIX+'b_pr', @PREFIX+'b_cprg', 4),
(@PREFIX+'c_pr', @PREFIX+'c_cprg', 6);


SET IDENTITY_INSERT [dbo].[entitydefaults] ON;
PRINT N'UPDATE/INSERT ENTITY DEFS for FUELS';
--Update/insert [entitydefaults] entries
MERGE [dbo].[entitydefaults] def USING #ENTITYDEFS d2
ON def.definition = d2.def
WHEN MATCHED
    THEN UPDATE SET
		definitionname=defName,
		categoryflags=catFlags,
		attributeflags=attrFlags,
		volume=cargoVolume,
		mass=massOfModule,
		tiertype=d2.tierType,
		tierlevel=d2.tierLevel,
		options=genxyOptStr,
		enabled=1,
		hidden=0,
		purchasable=1,
		descriptiontoken=description
WHEN NOT MATCHED
    THEN INSERT (definition, definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel) VALUES
	(def, defName, 1, attrFlags, catFlags, genxyOptStr, 'Reactor fuel rods', 1 ,cargoVolume, massOfModule, 0, 100, description, 1, tierType, tierLevel);
SET IDENTITY_INSERT [dbo].[entitydefaults] OFF;


MERGE [dbo].[definitionconfig] d USING #CORE c
ON d.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE c.defName=definitionname)
WHEN MATCHED
    THEN UPDATE SET
		corecalories=c.energyAmount
WHEN NOT MATCHED
    THEN INSERT (definition, corecalories) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE c.defName=definitionname), c.energyAmount);


MERGE [dbo].[components] c USING #MATS m
ON c.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE m.defName=definitionname) AND
c.componentdefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE m.componentDefName=definitionname)
WHEN MATCHED
    THEN UPDATE SET
		componentamount=m.amount
WHEN NOT MATCHED
    THEN INSERT (definition, componentdefinition, componentamount) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE m.defName=definitionname),
	(SELECT TOP 1 definition FROM entitydefaults WHERE m.componentDefName=definitionname),
	m.amount);


PRINT N'MERGING tech tree';
MERGE INTO techtree t USING #TREE r
ON t.childdefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=r.defName)
WHEN MATCHED
    THEN UPDATE SET
		t.groupID = 7,
		t.x = r.x,
		t.y = r.y,
		t.parentdefinition = COALESCE((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=r.parentDefName), 0)
WHEN NOT MATCHED
    THEN INSERT (parentdefinition, childdefinition, groupID, x, y)
	VALUES
	(COALESCE((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=r.parentDefName), 0),
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=r.defName),
	7,r.x,r.y);


PRINT N'DELETE calibrationdefaults FOR ANY EXISTING MOD CTS (0 results if 1st run)';
SELECT * FROM calibrationdefaults WHERE definition in (
	SELECT definition FROM entitydefaults WHERE definitionname in (
		SELECT DISTINCT ctDefName FROM #PROTO_TO_CT
	)
);
DELETE FROM calibrationdefaults WHERE definition in (
	SELECT definition FROM entitydefaults WHERE definitionname in (
		SELECT DISTINCT ctDefName FROM #PROTO_TO_CT
	)
);
PRINT N'INSERT calibrationdefaults FOR CTS';
INSERT INTO calibrationdefaults (definition, materialefficiency, timeefficiency)
SELECT (select top 1 definition from entitydefaults where definitionname=ctDefName), 70, 70
FROM #PROTO_TO_CT;


PRINT N'DELETE itemresearchlevels FOR ANY EXISTING CTS (1 results if 1st run)';
SELECT * FROM itemresearchlevels WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #ENTITYDEFS));
DELETE FROM itemresearchlevels WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #ENTITYDEFS));

PRINT N'INSERT itemresearchlevels FOR CTS';
INSERT INTO itemresearchlevels (definition, calibrationprogram, researchlevel, enabled)
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = protoDefName), 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = ctDefName), 
	level, 1
FROM #PROTO_TO_CT;


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

DROP TABLE IF EXISTS #TREE;
DROP TABLE IF EXISTS #MATS;
DROP TABLE IF EXISTS #CORE;
DROP TABLE IF EXISTS #ENTITYDEFS;
DROP TABLE IF EXISTS #PROTO_TO_CT;
DROP TABLE IF EXISTS #PROTOPAIRS;
DROP TABLE IF EXISTS #COSTS;
DROP TABLE IF EXISTS #DURATION;
GO



PRINT N'16_blocks_entitydefs_production_insert__2021_10_13.sql';
USE [perpetuumsa]
GO

----------------------------------------
-- Tech level blocks
--
-- Date modified: 2021/10/31
----------------------------------------


DECLARE @OLD_BLOCK_DEF AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_construction_module_ammo_normal');
DECLARE @CF_BLOCKS AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_construction_ammo');
DECLARE @PREFIX AS VARCHAR(64) = 'def_construction_module_ammo';

DECLARE @AMOUNT_FIELD AS VARCHAR(100) = 'construction_charge_amount';
DECLARE @TECH_FIELD AS VARCHAR(100) = 'construction_charge_techmax'; --666 \m/

DROP TABLE IF EXISTS #FIELDS;
CREATE TABLE #FIELDS 
(
	fieldID INT,
	fieldName VARCHAR(100)
);
INSERT INTO #FIELDS (fieldID, fieldName) VALUES
(666, @TECH_FIELD);

DROP TABLE IF EXISTS #COSTS;
CREATE TABLE #COSTS(
	category bigint,
	tierlevel int,
	costmod float
);
INSERT INTO #COSTS(category, tierlevel, costmod) VALUES
(@CF_BLOCKS, 1, 2),
(@CF_BLOCKS, 2, 4),
(@CF_BLOCKS, 3, 8);

MERGE productioncost p USING #COSTS c
ON p.category = c.category AND p.tierlevel=c.tierlevel
WHEN MATCHED
    THEN UPDATE SET
		p.costmodifier=c.costmod
WHEN NOT MATCHED
    THEN INSERT (category,tiertype,tierlevel,costmodifier) VALUES
	(c.category,NULL,c.tierlevel,c.costmod);

DROP TABLE IF EXISTS #DURATION;
CREATE TABLE #DURATION(
	category bigint,
	costmod float
);
INSERT INTO #DURATION(category, costmod) VALUES
(@CF_BLOCKS, 0.5);


MERGE productionduration p USING #DURATION d
ON p.category = d.category
WHEN MATCHED
    THEN UPDATE SET
		p.durationmodifier=d.costmod
WHEN NOT MATCHED
    THEN INSERT (category,durationmodifier) VALUES
	(d.category, d.costmod);

DROP TABLE IF EXISTS #DEFS;
CREATE TABLE #DEFS 
(
	def int,
	defName varchar(100),
	description varchar(128),
	genxy varchar(max),
	quantity int,
	catFlags bigint,
	attrFlags bigint,
	cargoVolume float,
	massOfModule float,
	purchasable bit,
	techType int,
	techLevel int
);
INSERT INTO #DEFS (def, defName, description, genxy, quantity, attrFlags, catFlags, cargoVolume, massOfModule, purchasable, techType, techLevel) VALUES
(6624, @PREFIX+'_t0', @PREFIX+'_t0_desc','#tier=$tierlevel_t0', 10, 2147485696, 69898, 3.0, 1000, 1, 1, 0),
(6625, @PREFIX+'_t1', @PREFIX+'_t1_desc','#tier=$tierlevel_t1', 10, 2147485696, 69898, 0.15, 1000, 1, 1, 1),
(6626, @PREFIX+'_t2', @PREFIX+'_t2_desc','#tier=$tierlevel_t2', 10, 2147485696, 69898, 0.15, 1000, 1, 1, 2),
(6627, @PREFIX+'_t3', @PREFIX+'_t3_desc','#tier=$tierlevel_t3', 10, 2147485696, 69898, 0.15, 1000, 1, 1, 3),
(6628, @PREFIX+'_t1_pr', @PREFIX+'_t1_desc','#tier=$tierlevel_t1_pr',1, 2147485696, 69898, 0.1, 1000, 1, 2, 1),
(6629, @PREFIX+'_t2_pr', @PREFIX+'_t2_desc','#tier=$tierlevel_t2_pr',1, 2147485696, 69898, 0.1, 1000, 1, 2, 2),
(6630, @PREFIX+'_t3_pr', @PREFIX+'_t3_desc','#tier=$tierlevel_t3_pr',1, 2147485696, 69898, 0.1, 1000, 1, 2, 3),
(6631, @PREFIX+'_t1_cprg', 'calibration_program_desc','#tier=$tierlevel_t1',1, 1024, 459798, 0.01, 0.1, 0, 1, 1),
(6632, @PREFIX+'_t2_cprg', 'calibration_program_desc','#tier=$tierlevel_t2',1, 1024, 459798, 0.01, 0.1, 0, 1, 2),
(6633, @PREFIX+'_t3_cprg', 'calibration_program_desc','#tier=$tierlevel_t3',1, 1024, 459798, 0.01, 0.1, 0, 1, 3);

DROP TABLE IF EXISTS #TREE;
CREATE TABLE #TREE(
	defName varchar(100),
	parentDefName varchar(100) null,
	x int,
	y int
);
INSERT INTO #TREE(defName, parentDefName, x, y) VALUES
(@PREFIX+'_t1', NULL, 0, 0),
(@PREFIX+'_t2', @PREFIX+'_t1', 1, 0),
(@PREFIX+'_t3', @PREFIX+'_t2', 2, 0),
('def_pbs_docking_base_small_capsule', @PREFIX+'_t1', 1, 8);


DROP TABLE IF EXISTS #PROTO_TO_CT;
CREATE TABLE #PROTO_TO_CT
(
	protoDefName VARCHAR(100),
	ctDefName VARCHAR(100),
	level INT
);

INSERT INTO #PROTO_TO_CT (protoDefName, ctDefName, level) VALUES
(@PREFIX+'_t1_pr', @PREFIX+'_t1_cprg', 2),
(@PREFIX+'_t2_pr', @PREFIX+'_t2_cprg', 4),
(@PREFIX+'_t3_pr', @PREFIX+'_t3_cprg', 6);

DROP TABLE IF EXISTS #VALS;
CREATE TABLE #VALS 
(
	defName varchar(100),
	fieldName varchar(100),
	fieldValue float,
);
INSERT INTO #VALS (defName, fieldName, fieldValue) VALUES
(@PREFIX+'_t0', @AMOUNT_FIELD, 1),
(@PREFIX+'_t1', @AMOUNT_FIELD, 1),
(@PREFIX+'_t2', @AMOUNT_FIELD, 1),
(@PREFIX+'_t3', @AMOUNT_FIELD, 1),
(@PREFIX+'_t1_pr', @AMOUNT_FIELD, 1),
(@PREFIX+'_t2_pr', @AMOUNT_FIELD, 1),
(@PREFIX+'_t3_pr', @AMOUNT_FIELD, 1),
(@PREFIX+'_t0', @TECH_FIELD, 0),
(@PREFIX+'_t1', @TECH_FIELD, 1),
(@PREFIX+'_t2', @TECH_FIELD, 2),
(@PREFIX+'_t3', @TECH_FIELD, 3),
(@PREFIX+'_t1_pr', @TECH_FIELD, 1),
(@PREFIX+'_t2_pr', @TECH_FIELD, 2),
(@PREFIX+'_t3_pr', @TECH_FIELD, 3),
('def_construction_module_ammo_dev', @AMOUNT_FIELD, 999),--dev charge
('def_construction_module_ammo_dev', @TECH_FIELD, 4);--dev charge

DROP TABLE IF EXISTS #COMPS;
CREATE TABLE #COMPS
(
	defName VARCHAR(100),
	commodityName VARCHAR(100),
	amount INT
);
INSERT INTO #COMPS (defName, commodityName, amount) VALUES
(@PREFIX+'_t1', 'def_titanium', 25),
(@PREFIX+'_t1', 'def_plasteosine', 10),
(@PREFIX+'_t1', 'def_alligior', 25),
(@PREFIX+'_t1', 'def_hydrobenol', 5),
(@PREFIX+'_t1', 'def_espitium', 10),
(@PREFIX+'_t1', 'def_unimetal', 25),
(@PREFIX+'_t1', 'def_axicol', 10),
(@PREFIX+'_t1', 'def_axicoline', 5),

(@PREFIX+'_t1_pr', 'def_titanium', 25),
(@PREFIX+'_t1_pr', 'def_plasteosine', 10),
(@PREFIX+'_t1_pr', 'def_alligior', 25),
(@PREFIX+'_t1_pr', 'def_hydrobenol', 5),
(@PREFIX+'_t1_pr', 'def_espitium', 10),
(@PREFIX+'_t1_pr', 'def_unimetal', 25),
(@PREFIX+'_t1_pr', 'def_axicol', 10),
(@PREFIX+'_t1_pr', 'def_axicoline', 5),

(@PREFIX+'_t2', 'def_titanium', 25),
(@PREFIX+'_t2', 'def_plasteosine', 10),
(@PREFIX+'_t2', 'def_alligior', 25),
(@PREFIX+'_t2', 'def_hydrobenol', 5),
(@PREFIX+'_t2', 'def_espitium', 10),
(@PREFIX+'_t2', 'def_unimetal', 25),
(@PREFIX+'_t2', 'def_axicol', 10),
(@PREFIX+'_t2', 'def_axicoline', 5),
(@PREFIX+'_t2', 'def_gamma_buildblock', 25),
(@PREFIX+'_t2', 'def_gamma_defblock', 10),
(@PREFIX+'_t2', 'def_gamma_energyblock', 10),
(@PREFIX+'_t2', 'def_gamma_offenseblock', 5),

(@PREFIX+'_t2_pr', 'def_titanium', 25),
(@PREFIX+'_t2_pr', 'def_plasteosine', 10),
(@PREFIX+'_t2_pr', 'def_alligior', 25),
(@PREFIX+'_t2_pr', 'def_hydrobenol', 5),
(@PREFIX+'_t2_pr', 'def_espitium', 10),
(@PREFIX+'_t2_pr', 'def_unimetal', 25),
(@PREFIX+'_t2_pr', 'def_axicol', 10),
(@PREFIX+'_t2_pr', 'def_axicoline', 5),
(@PREFIX+'_t2_pr', 'def_gamma_buildblock', 25),
(@PREFIX+'_t2_pr', 'def_gamma_defblock', 10),
(@PREFIX+'_t2_pr', 'def_gamma_energyblock', 10),
(@PREFIX+'_t2_pr', 'def_gamma_offenseblock', 5),

(@PREFIX+'_t3', 'def_titanium', 50),
(@PREFIX+'_t3', 'def_plasteosine', 20),
(@PREFIX+'_t3', 'def_alligior', 50),
(@PREFIX+'_t3', 'def_hydrobenol', 10),
(@PREFIX+'_t3', 'def_espitium', 20),
(@PREFIX+'_t3', 'def_unimetal', 50),
(@PREFIX+'_t3', 'def_axicol', 20),
(@PREFIX+'_t3', 'def_axicoline', 10),
(@PREFIX+'_t3', 'def_gamma_buildblock', 50),
(@PREFIX+'_t3', 'def_gamma_defblock', 20),
(@PREFIX+'_t3', 'def_gamma_energyblock', 20),
(@PREFIX+'_t3', 'def_gamma_offenseblock', 10),

(@PREFIX+'_t3_pr', 'def_titanium', 50),
(@PREFIX+'_t3_pr', 'def_plasteosine', 20),
(@PREFIX+'_t3_pr', 'def_alligior', 50),
(@PREFIX+'_t3_pr', 'def_hydrobenol', 10),
(@PREFIX+'_t3_pr', 'def_espitium', 20),
(@PREFIX+'_t3_pr', 'def_unimetal', 50),
(@PREFIX+'_t3_pr', 'def_axicol', 20),
(@PREFIX+'_t3_pr', 'def_axicoline', 10),
(@PREFIX+'_t3_pr', 'def_gamma_buildblock', 50),
(@PREFIX+'_t3_pr', 'def_gamma_defblock', 20),
(@PREFIX+'_t3_pr', 'def_gamma_energyblock', 20),
(@PREFIX+'_t3_pr', 'def_gamma_offenseblock', 10);

DROP TABLE IF EXISTS #PROTOPAIRS;
CREATE TABLE #PROTOPAIRS
(
	defName varchar(100),
	protoDefName varchar(100),
);
INSERT INTO #PROTOPAIRS (defName, protoDefName) VALUES
(@PREFIX+'_t1', @PREFIX+'_t1_pr'),
(@PREFIX+'_t2', @PREFIX+'_t2_pr'),
(@PREFIX+'_t3', @PREFIX+'_t3_pr');


PRINT N'MERGING NEW AGGREGATEFIELD';
SET IDENTITY_INSERT aggregatefields ON;
MERGE aggregatefields a USING #FIELDS f
ON a.id = f.fieldID
WHEN MATCHED
    THEN UPDATE SET
		a.name=f.fieldName,
		a.formula=1,
		a.measurementunit=f.fieldName+'_unit',
		a.measurementmultiplier=1,
		a.measurementoffset=0,
		a.category=5,
		a.digits=0,
		a.moreisbetter=1,
		a.usedinconfig=1,
		a.note=f.fieldName
WHEN NOT MATCHED
    THEN INSERT (id,name,formula,measurementunit,measurementmultiplier,measurementoffset,category,
		digits,moreisbetter,usedinconfig,note)
	VALUES
		(f.fieldID,f.fieldName,1,f.fieldName+'_unit',1,0,5,0,1,1,f.fieldName);
SET IDENTITY_INSERT aggregatefields OFF;


SET IDENTITY_INSERT [dbo].[entitydefaults] ON;
PRINT N'UPDATE/INSERT ENTITY DEFS for BLOCKS';
--Update/insert [entitydefaults] entries
MERGE [dbo].[entitydefaults] def USING #DEFS d2
ON def.definition = d2.def
WHEN MATCHED
    THEN UPDATE SET
		definitionname=defName,
		quantity=d2.quantity,
		options=genxy,
		categoryflags=catFlags,
		attributeflags=attrFlags,
		volume=cargoVolume,
		mass=massOfModule,
		tiertype=techType,
		tierlevel=techLevel,
		enabled=1,
		hidden=0,
		purchasable=1,
		descriptiontoken=description
WHEN NOT MATCHED
    THEN INSERT (definition, definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel) VALUES
	(def, defName, quantity, attrFlags, catFlags, genxy, 'construction blocks', 1 ,cargoVolume, massOfModule, 0, 100, description, 1, techType, techLevel);
SET IDENTITY_INSERT [dbo].[entitydefaults] OFF;

PRINT N'SET BEAMS';
DECLARE @BEAM AS INT = (SELECT TOP 1 beam FROM beamassignment WHERE definition=@OLD_BLOCK_DEF);
PRINT N'DELETE/REINSERT BEAMS';
SELECT * FROM beamassignment WHERE definition IN (SELECT def FROM #DEFS WHERE attrFlags!=1024);
DELETE FROM beamassignment WHERE definition IN (SELECT def FROM #DEFS WHERE attrFlags!=1024);
PRINT N'INSERT BEAMS';
INSERT INTO beamassignment (definition, beam)
SELECT def, @BEAM FROM #DEFS WHERE attrFlags!=1024;

PRINT N'DELETE OLD STATS';
DELETE FROM aggregatevalues WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #VALS));

PRINT N'INSERT NEW STATS';
INSERT INTO aggregatevalues (definition, field, value)
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defName), 
	(SELECT TOP 1 id FROM aggregatefields WHERE name=fieldName), 
	fieldValue 
FROM #VALS; 


PRINT N'DELETE components FOR ANY EXISTING (0 results if 1st run)';
SELECT * FROM components WHERE definition IN (SELECT definition FROM entitydefaults WHERE definitionname IN (SELECT DISTINCT defName FROM #COMPS));
DELETE FROM components WHERE definition IN (SELECT definition FROM entitydefaults WHERE definitionname IN (SELECT DISTINCT defName FROM #COMPS));

PRINT N'INSERT components';
INSERT INTO components (definition, componentdefinition, componentamount)
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defName),
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=commodityName),
	amount
FROM #COMPS;


PRINT N'DELETE calibrationdefaults FOR ANY EXISTING MOD CTS (0 results if 1st run)';
SELECT * FROM calibrationdefaults WHERE definition in (
	SELECT definition FROM entitydefaults WHERE definitionname in (
		SELECT DISTINCT ctDefName FROM #PROTO_TO_CT
	)
);
DELETE FROM calibrationdefaults WHERE definition in (
	SELECT definition FROM entitydefaults WHERE definitionname in (
		SELECT DISTINCT ctDefName FROM #PROTO_TO_CT
	)
);
PRINT N'INSERT calibrationdefaults FOR CTS';
INSERT INTO calibrationdefaults (definition, materialefficiency, timeefficiency)
SELECT (select top 1 definition from entitydefaults where definitionname=ctDefName), 70, 70
FROM #PROTO_TO_CT;


PRINT N'DELETE itemresearchlevels FOR ANY EXISTING CTS (0 results if 1st run)';
SELECT * FROM itemresearchlevels WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT protoDefName FROM #PROTO_TO_CT));
DELETE FROM itemresearchlevels WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT protoDefName FROM #PROTO_TO_CT));

PRINT N'INSERT itemresearchlevels FOR CTS';
INSERT INTO itemresearchlevels (definition, calibrationprogram, researchlevel, enabled)
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = protoDefName), 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = ctDefName), 
	level, 1
FROM #PROTO_TO_CT;


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

PRINT N'MERGING tech tree';
MERGE INTO techtree t USING #TREE r
ON t.childdefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=r.defName)
WHEN MATCHED
    THEN UPDATE SET
		t.groupID = 7,
		t.x = r.x,
		t.y = r.y,
		t.parentdefinition = COALESCE((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=r.parentDefName), 0)
WHEN NOT MATCHED
    THEN INSERT (parentdefinition, childdefinition, groupID, x, y)
	VALUES
	(COALESCE((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=r.parentDefName), 0),
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=r.defName),
	7,r.x,r.y);


--Hide/remove old block
PRINT N'HIDING AND REMOVING OLD CONSTRUCTION BLOCK';
UPDATE entitydefaults SET hidden=1, purchasable=0 WHERE definition=@OLD_BLOCK_DEF;
DELETE FROM techtree WHERE childdefinition=@OLD_BLOCK_DEF;


DROP TABLE IF EXISTS #PROTOPAIRS;
DROP TABLE IF EXISTS #PROTO_TO_CT;
DROP TABLE IF EXISTS #TREE;
DROP TABLE IF EXISTS #COMPS;
DROP TABLE IF EXISTS #VALS;
DROP TABLE IF EXISTS #DEFS;
DROP TABLE IF EXISTS #COSTS;
DROP TABLE IF EXISTS #DURATION;
DROP TABLE IF EXISTS #FIELDS;
GO


PRINT N'17_elite_mods_gamma_shards__2021_10_31.sql';
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




PRINT N'18_large_ammo_pvp__2021_11_01.sql';
USE [perpetuumsa]
GO

------------------------------------
-- Large Ammo PVP/Reward definition
-- for use in loots
-- Date modified: 2021/11/01
------------------------------------


DROP TABLE IF EXISTS #ENTITYDEFS;
CREATE TABLE #ENTITYDEFS
(
	def INT,
	defName varchar(100),
	quant int,
	catFlags bigint,
	attrFlags bigint,
	cargoVolume float,
	massOfModule float,
	genxyOptStr varchar(max),
	description varchar(max),
	tierType int null,
	tierLevel int null
);
INSERT INTO #ENTITYDEFS (def, defName, quant, attrFlags, catFlags, cargoVolume, massOfModule, genxyOptStr, description, tierType, tierLevel) VALUES
(6117,'def_ammo_cruisemissile_rewa', 1000, 133120, 197642, 2, 0.75, '#bullettime=f7.0', 'def_ammo_cruisemissile_rewa_desc', NULL, NULL),
(6118,'def_ammo_longrange_cruisemissile_rewa', 1000, 133120, 197642, 2, 0.75, '#bullettime=f7.0', 'def_ammo_longrange_cruisemissile_rewa_desc', NULL, NULL),
(6119,'def_ammo_large_lasercrystal_rewa', 1000, 133120, 197130, 2, 0.4, '#bullettime=f3000.0', 'def_ammo_large_lasercrystal_rewa_desc', NULL, NULL),
(6120,'def_ammo_large_railgun_rewa', 1000, 133120, 196874, 2, 0.4, '#bullettime=f53.0', 'def_ammo_large_railgun_rewa_desc', NULL, NULL);

DROP TABLE IF EXISTS #STATS;
CREATE TABLE #STATS(
	defName varchar(100),
	fieldName varchar(100),
	fieldValue float,
);
INSERT INTO #STATS (defName, fieldName, fieldValue) VALUES
('def_ammo_cruisemissile_rewa','damage_chemical',34),
('def_ammo_cruisemissile_rewa','damage_explosive',78),
('def_ammo_cruisemissile_rewa','damage_kinetic',34),
('def_ammo_cruisemissile_rewa','damage_thermal',34),
('def_ammo_cruisemissile_rewa','optimal_range',18),
('def_ammo_cruisemissile_rewa','falloff',3),
('def_ammo_longrange_cruisemissile_rewa','damage_chemical',24),
('def_ammo_longrange_cruisemissile_rewa','damage_explosive',56),
('def_ammo_longrange_cruisemissile_rewa','damage_kinetic',24),
('def_ammo_longrange_cruisemissile_rewa','damage_thermal',24),
('def_ammo_longrange_cruisemissile_rewa','optimal_range',35),
('def_ammo_longrange_cruisemissile_rewa','falloff',15),
('def_ammo_large_railgun_rewa','damage_chemical',15),
('def_ammo_large_railgun_rewa','damage_explosive',15),
('def_ammo_large_railgun_rewa','damage_kinetic',33),
('def_ammo_large_railgun_rewa','damage_thermal',15),
('def_ammo_large_railgun_rewa','optimal_range_modifier',1),
('def_ammo_large_lasercrystal_rewa','damage_chemical',15),
('def_ammo_large_lasercrystal_rewa','damage_explosive',15),
('def_ammo_large_lasercrystal_rewa','damage_kinetic',15),
('def_ammo_large_lasercrystal_rewa','damage_thermal',33),
('def_ammo_large_lasercrystal_rewa','optimal_range_modifier',1);

DROP TABLE IF EXISTS #BEAMS;
CREATE TABLE #BEAMS 
(
	ammoName varchar(100),
	beamName varchar(100)
);
INSERT INTO #BEAMS (ammoName, beamName) VALUES
('def_ammo_large_railgun_rewa', 'pbs_turret_railgun'),
('def_ammo_large_lasercrystal_rewa', 'multifocal_medium_laser'),
('def_ammo_cruisemissile_rewa', 'pbs_turret_missile'),
('def_ammo_longrange_cruisemissile_rewa', 'cruisemissile_large');


SET IDENTITY_INSERT [dbo].[entitydefaults] ON;
PRINT N'UPDATE/INSERT ENTITY DEFS for Large Ammo (PVP/reward)';
--Update/insert [entitydefaults] entries
MERGE [dbo].[entitydefaults] def USING #ENTITYDEFS d2
ON def.definition = d2.def
WHEN MATCHED
    THEN UPDATE SET
		definitionname=defName,
		categoryflags=catFlags,
		attributeflags=attrFlags,
		volume=cargoVolume,
		mass=massOfModule,
		tiertype=NULL,
		tierlevel=NULL,
		options=genxyOptStr,
		enabled=1,
		hidden=0,
		purchasable=1,
		descriptiontoken=description,
		quantity=quant
WHEN NOT MATCHED
    THEN INSERT (definition, definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel) VALUES
	(def, defName, quant, attrFlags, catFlags, genxyOptStr, 'Large Ammo pvp/reward type', 1 ,cargoVolume, massOfModule, 0, 100, description, 1, tierType, tierLevel);
SET IDENTITY_INSERT [dbo].[entitydefaults] OFF;


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


--SELECT * FROM beamassignment WHERE definition in (SELECT entitydefaults.definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT ammoName FROM #BEAMS));
DELETE FROM beamassignment WHERE definition in (SELECT entitydefaults.definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT ammoName FROM #BEAMS));

INSERT INTO beamassignment (definition, beam)
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=ammoName),
	(SELECT TOP 1 id FROM beams WHERE name=beamName)
FROM #BEAMS


DROP TABLE IF EXISTS #BEAMS;
DROP TABLE IF EXISTS #STATS;
DROP TABLE IF EXISTS #ENTITYDEFS;
GO



PRINT N'20_techtreenodeprices_updatepbs__2021_09_18.sql';
USE [perpetuumsa]
GO

-------------------------------------------------
-- PBS Research tree costs
--
--
-- Date modified: 2021/10/13
-------------------------------------------------

DROP TABLE IF EXISTS #KERNELCOSTS;
CREATE TABLE #KERNELCOSTS(
	defName VARCHAR(128),
	kernelType VARCHAR(128),
	cost INT
);
INSERT INTO #KERNELCOSTS (defName, kernelType, cost) VALUES
('def_construction_module_ammo_t1','hitech',5000),
('def_construction_module_ammo_t1','industrial',5000),
('def_construction_module_ammo_t2','hitech',10000),
('def_construction_module_ammo_t2','industrial',10000),
('def_construction_module_ammo_t3','hitech',20000),
('def_construction_module_ammo_t3','industrial',20000),
('def_reactor_booster_a','hitech',10000),
('def_reactor_booster_b','hitech',25000),
('def_reactor_booster_c','hitech',75000),
('def_pbs_docking_base_small_capsule','common',25000),
('def_pbs_docking_base_small_capsule','hitech',50000),
('def_pbs_docking_base_medium_capsule','common',125000),
('def_pbs_docking_base_medium_capsule','hitech',250000),
('def_pbs_docking_base_large_capsule','common',375000),
('def_pbs_docking_base_large_capsule','hitech',750000),
('def_pbs_reactor_small_capsule','common',12500),
('def_pbs_reactor_small_capsule','hitech',25000),
('def_pbs_reactor_medium_capsule','common',50000),
('def_pbs_reactor_medium_capsule','hitech',75000),
('def_pbs_reactor_large_capsule','common',100000),
('def_pbs_reactor_large_capsule','hitech',175000),
('def_pbs_core_transmitter_small_capsule','common',10000),
('def_pbs_core_transmitter_small_capsule','hitech',20000),
('def_pbs_core_transmitter_medium_capsule','common',25000),
('def_pbs_core_transmitter_medium_capsule','hitech',50000),
('def_pbs_core_transmitter_large_capsule','common',50000),
('def_pbs_core_transmitter_large_capsule','hitech',100000),
('def_pbs_XL_core_transmitter_small_capsule','common',12500),
('def_pbs_XL_core_transmitter_small_capsule','hitech',25000),
('def_pbs_XL_core_transmitter_medium_capsule','common',31300),
('def_pbs_XL_core_transmitter_medium_capsule','hitech',62500),
('def_pbs_XL_core_transmitter_large_capsule','common',62500),
('def_pbs_XL_core_transmitter_large_capsule','hitech',125000),
('def_pbs_core_battery_small_capsule','common',15000),
('def_pbs_core_battery_small_capsule','hitech',30000),
('def_pbs_core_battery_medium_capsule','common',37500),
('def_pbs_core_battery_medium_capsule','hitech',75000),
('def_pbs_core_battery_large_capsule','common',75000),
('def_pbs_core_battery_large_capsule','hitech',150000),
('def_pbs_production_upgrade_small_capsule','industrial',23000),
('def_pbs_production_upgrade_small_capsule','common',12000),
('def_pbs_production_upgrade_medium_capsule','hitech',46000),
('def_pbs_production_upgrade_medium_capsule','industrial',28000),
('def_pbs_production_upgrade_medium_capsule','common',14000),
('def_pbs_production_upgrade_large_capsule','hitech',105000),
('def_pbs_production_upgrade_large_capsule','industrial',53000),
('def_pbs_production_upgrade_large_capsule','common',32000),
('def_pbs_mining_tower_small_capsule','common',25000),
('def_pbs_mining_tower_small_capsule','industrial',50000),
('def_pbs_mining_tower_medium_capsule','common',50000),
('def_pbs_mining_tower_medium_capsule','hitech',75000),
('def_pbs_mining_tower_medium_capsule','industrial',125000),
('def_pbs_mining_tower_large_capsule','common',125000),
('def_pbs_mining_tower_large_capsule','hitech',250000),
('def_pbs_mining_tower_large_capsule','industrial',375000),
('def_pbs_refinery_small_capsule','industrial',15000),
('def_pbs_refinery_small_capsule','common',7500),
('def_pbs_refinery_medium_capsule','hitech',25000),
('def_pbs_refinery_medium_capsule','industrial',15000),
('def_pbs_refinery_medium_capsule','common',7500),
('def_pbs_refinery_large_capsule','hitech',50000),
('def_pbs_refinery_large_capsule','industrial',25000),
('def_pbs_refinery_large_capsule','common',15000),
('def_pbs_repair_small_capsule','common',15000),
('def_pbs_repair_small_capsule','industrial',7500),
('def_pbs_repair_medium_capsule','hitech',25000),
('def_pbs_repair_medium_capsule','industrial',15000),
('def_pbs_repair_medium_capsule','common',7500),
('def_pbs_repair_large_capsule','hitech',50000),
('def_pbs_repair_large_capsule','industrial',25000),
('def_pbs_repair_large_capsule','common',15000),
('def_pbs_reprocessor_small_capsule','common',18000),
('def_pbs_reprocessor_small_capsule','industrial',9000),
('def_pbs_reprocessor_medium_capsule','hitech',33000),
('def_pbs_reprocessor_medium_capsule','industrial',20000),
('def_pbs_reprocessor_medium_capsule','common',10000),
('def_pbs_reprocessor_large_capsule','hitech',70000),
('def_pbs_reprocessor_large_capsule','industrial',35000),
('def_pbs_reprocessor_large_capsule','common',21000),
('def_pbs_mill_small_capsule','common',18000),
('def_pbs_mill_small_capsule','industrial',9000),
('def_pbs_mill_medium_capsule','hitech',33000),
('def_pbs_mill_medium_capsule','industrial',20000),
('def_pbs_mill_medium_capsule','common',10000),
('def_pbs_mill_large_capsule','hitech',70000),
('def_pbs_mill_large_capsule','industrial',35000),
('def_pbs_mill_large_capsule','common',21000),
('def_pbs_prototyper_small_capsule','common',23000),
('def_pbs_prototyper_small_capsule','industrial',12000),
('def_pbs_prototyper_medium_capsule','hitech',46000),
('def_pbs_prototyper_medium_capsule','industrial',28000),
('def_pbs_prototyper_medium_capsule','common',14000),
('def_pbs_prototyper_large_capsule','hitech',105000),
('def_pbs_prototyper_large_capsule','industrial',53000),
('def_pbs_prototyper_large_capsule','common',32000),
('def_pbs_research_lab_small_capsule','industrial',32000),
('def_pbs_research_lab_small_capsule','common',17000),
('def_pbs_research_lab_medium_capsule','hitech',69000),
('def_pbs_research_lab_medium_capsule','industrial',42000),
('def_pbs_research_lab_medium_capsule','common',21000),
('def_pbs_research_lab_large_capsule','hitech',168000),
('def_pbs_research_lab_large_capsule','industrial',85000),
('def_pbs_research_lab_large_capsule','common',51000),
('def_pbs_calibration_forge_small_capsule','common',48000),
('def_pbs_calibration_forge_small_capsule','industrial',26000),
('def_pbs_calibration_forge_medium_capsule','hitech',110000),
('def_pbs_calibration_forge_medium_capsule','industrial',67000),
('def_pbs_calibration_forge_medium_capsule','common',34000),
('def_pbs_calibration_forge_large_capsule','hitech',286000),
('def_pbs_calibration_forge_large_capsule','industrial',145000),
('def_pbs_calibration_forge_large_capsule','common',87000),
('def_pbs_research_kit_forge_small_capsule','common',48000),
('def_pbs_research_kit_forge_small_capsule','industrial',26000),
('def_pbs_research_kit_forge_medium_capsule','hitech',110000),
('def_pbs_research_kit_forge_medium_capsule','industrial',67000),
('def_pbs_research_kit_forge_medium_capsule','common',34000),
('def_pbs_research_kit_forge_large_capsule','hitech',286000),
('def_pbs_research_kit_forge_large_capsule','industrial',145000),
('def_pbs_research_kit_forge_large_capsule','common',87000),
('def_pbs_control_tower_small_capsule','nuimqol',10000),
('def_pbs_control_tower_small_capsule','thelodica',10000),
('def_pbs_control_tower_small_capsule','pelistal',10000),
('def_pbs_control_tower_medium_capsule','nuimqol',25000),
('def_pbs_control_tower_medium_capsule','thelodica',25000),
('def_pbs_control_tower_medium_capsule','pelistal',25000),
('def_pbs_control_tower_medium_capsule','hitech',50000),
('def_pbs_control_tower_large_capsule','nuimqol',50000),
('def_pbs_control_tower_large_capsule','thelodica',50000),
('def_pbs_control_tower_large_capsule','pelistal',50000),
('def_pbs_control_tower_large_capsule','hitech',200000),
('def_pbs_armor_repairer_small_capsule','common',12500),
('def_pbs_armor_repairer_small_capsule','hitech',25000),
('def_pbs_armor_repairer_medium_capsule','common',50000),
('def_pbs_armor_repairer_medium_capsule','hitech',125000),
('def_pbs_armor_repairer_large_capsule','common',75000),
('def_pbs_armor_repairer_large_capsule','hitech',250000),
('def_pbs_turret_rail_small_capsule','common',25000),
('def_pbs_turret_rail_small_capsule','nuimqol',50000),
('def_pbs_turret_rail_medium_capsule','common',50000),
('def_pbs_turret_rail_medium_capsule','hitech',75000),
('def_pbs_turret_rail_medium_capsule','nuimqol',125000),
('def_pbs_turret_rail_large_capsule','common',125000),
('def_pbs_turret_rail_large_capsule','hitech',250000),
('def_pbs_turret_rail_large_capsule','nuimqol',375000),
('def_pbs_turret_laser_small_capsule','common',25000),
('def_pbs_turret_laser_small_capsule','thelodica',50000),
('def_pbs_turret_laser_medium_capsule','common',50000),
('def_pbs_turret_laser_medium_capsule','hitech',75000),
('def_pbs_turret_laser_medium_capsule','thelodica',125000),
('def_pbs_turret_laser_large_capsule','common',125000),
('def_pbs_turret_laser_large_capsule','hitech',250000),
('def_pbs_turret_laser_large_capsule','thelodica',375000),
('def_pbs_turret_missile_small_capsule','common',25000),
('def_pbs_turret_missile_small_capsule','pelistal',50000),
('def_pbs_turret_missile_medium_capsule','common',50000),
('def_pbs_turret_missile_medium_capsule','hitech',75000),
('def_pbs_turret_missile_medium_capsule','pelistal',125000),
('def_pbs_turret_missile_large_capsule','common',125000),
('def_pbs_turret_missile_large_capsule','hitech',250000),
('def_pbs_turret_missile_large_capsule','pelistal',375000),
('def_pbs_effect_supplier_small_capsule','nuimqol',10000),
('def_pbs_effect_supplier_small_capsule','thelodica',10000),
('def_pbs_effect_supplier_small_capsule','pelistal',10000),
('def_pbs_effect_supplier_medium_capsule','nuimqol',25000),
('def_pbs_effect_supplier_medium_capsule','thelodica',25000),
('def_pbs_effect_supplier_medium_capsule','pelistal',25000),
('def_pbs_effect_supplier_medium_capsule','hitech',50000),
('def_pbs_effect_supplier_large_capsule','nuimqol',50000),
('def_pbs_effect_supplier_large_capsule','thelodica',50000),
('def_pbs_effect_supplier_large_capsule','pelistal',50000),
('def_pbs_effect_supplier_large_capsule','hitech',200000),
('def_pbs_turret_ew_small_capsule','common',25000),
('def_pbs_turret_ew_small_capsule','hitech',50000),
('def_pbs_turret_ew_medium_capsule','common',75000),
('def_pbs_turret_ew_medium_capsule','hitech',175000),
('def_pbs_turret_ew_large_capsule','common',250000),
('def_pbs_turret_ew_large_capsule','hitech',375000),
('def_pbs_maskertower_small_capsule','common',15000),
('def_pbs_maskertower_small_capsule','hitech',35000),
('def_pbs_maskertower_medium_capsule','common',35000),
('def_pbs_maskertower_medium_capsule','hitech',75000),
('def_pbs_maskertower_large_capsule','common',75000),
('def_pbs_maskertower_large_capsule','hitech',125000),
('def_pbs_aura_emitter_small_capsule','common',19500),
('def_pbs_aura_emitter_small_capsule','hitech',45500),
('def_pbs_aura_emitter_medium_capsule','common',45500),
('def_pbs_aura_emitter_medium_capsule','hitech',97500),
('def_pbs_aura_emitter_large_capsule','common',97500),
('def_pbs_aura_emitter_large_capsule','hitech',162500),
('def_pbs_energywell_small_capsule','common',10000),
('def_pbs_energywell_small_capsule','hitech',20000),
('def_pbs_energywell_medium_capsule','common',20000),
('def_pbs_energywell_medium_capsule','hitech',50000),
('def_pbs_energywell_large_capsule','common',50000),
('def_pbs_energywell_large_capsule','hitech',100000),
('def_pbs_highwaynode_small_capsule','common',25000),
('def_pbs_highwaynode_small_capsule','hitech',50000),
('def_pbs_highwaynode_medium_capsule','common',50000),
('def_pbs_highwaynode_medium_capsule','hitech',75000),
('def_pbs_highwaynode_large_capsule','common',75000),
('def_pbs_highwaynode_large_capsule','hitech',150000);

PRINT N'SELECT CURRENT VALUES';
SELECT * FROM techtreenodeprices WHERE definition IN (
	SELECT definition FROM entitydefaults WHERE definitionname IN (
		SELECT DISTINCT defName FROM #KERNELCOSTS
	)
);

PRINT N'DELETE/REINSERT node prices';
DELETE FROM techtreenodeprices WHERE definition IN (
	SELECT definition FROM entitydefaults WHERE definitionname IN (
		SELECT DISTINCT defName FROM #KERNELCOSTS
	)
);

PRINT N'UPDATE/INSERT ALL NODE COSTS';
MERGE techtreenodeprices p USING #KERNELCOSTS k
ON p.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=k.defName) AND
p.pointtype = (SELECT TOP 1 id FROM techtreepointtypes WHERE name=k.kernelType)
WHEN MATCHED
    THEN UPDATE SET
		amount = k.cost
WHEN NOT MATCHED
    THEN INSERT (definition, pointtype, amount) VALUES
		((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=k.defName),
		(SELECT TOP 1 id FROM techtreepointtypes WHERE name=k.kernelType),
		k.cost);



DROP TABLE IF EXISTS #KERNELCOSTS;
GO



PRINT N'25_stagingbase_newdefs__2021_10_09.sql';

USE [perpetuumsa]
GO


-----------------------------------------------
-- Expiring PBS base "staging base"
-- Adds a set of definitions, configs, stats, and components
-- 
-- Date modified: 2021/10/11 
-----------------------------------------------

DECLARE @DEF_NAME AS VARCHAR(100) = 'def_pbs_expiring_docking_base';
DECLARE @DEF AS INT = 6613;
DECLARE @DEF_OBJ AS INT = 6614;
DECLARE @DEF_CAP AS INT = 6615;

DECLARE @ENV_STR AS VARCHAR(MAX) = (SELECT TOP 1 descriptionstring FROM environmentdescription WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_docking_base_small'));


DROP TABLE IF EXISTS #DEFS;
CREATE TABLE #DEFS(
	[definition] [int] NOT NULL,
	[definitionname] [varchar](100) NOT NULL,
	[quantity] [int] NOT NULL,
	[attributeflags] [bigint] NOT NULL,
	[categoryflags] [bigint] NOT NULL,
	[options] [varchar](max) NULL,
	[note] [nvarchar](2048) NULL,
	[enabled] [bit] NOT NULL,
	[volume] [float] NULL,
	[mass] [float] NULL,
	[hidden] [bit] NOT NULL,
	[health] [float] NOT NULL,
	[descriptiontoken] [nvarchar](100) NULL,
	[purchasable] [bit] NOT NULL,
	[tiertype] [int] NULL,
	[tierlevel] [int] NULL,
);
INSERT INTO #DEFS
([definition], [definitionname],[quantity],[attributeflags],[categoryflags],[options],[note],
[enabled],[volume],[mass],[hidden],[health],[descriptiontoken],[purchasable],[tiertype],[tierlevel])
VALUES
(@DEF, @DEF_NAME, 1, 1024, 151192722, '#size=n6  #dockRange=n15  #spawnRange=n1  #height=f10.00  #tier=$tierlevel_t0', 'Staging base!',
1, 2000, 2000000, 0, 100, @DEF_NAME+'_desc', 0, 1, 0),

(@DEF_OBJ, @DEF_NAME+'_object', 1, 536871936, 328594, '#height=f1  #tier=$tierlevel_t0', 'Staging base!',
1, 1, 1, 0, 100, @DEF_NAME+'_desc', 0, 1, 0),

(@DEF_CAP, @DEF_NAME+'_capsule', 1, 2172651520, 410, '#tier=$tierlevel_t0', 'Staging base!',
1, 150, 200000, 0, 100, @DEF_NAME+'_desc', 1, 1, 0);


DROP TABLE IF EXISTS #CONFIGS;
CREATE TABLE #CONFIGS(
	[definition] [int] NOT NULL,
	[targetdefinition] [int] NULL,
	[summonerscount] [int] NULL,
	[cycle_time] [int] NULL,
	[lifetime] [int] NULL,
	[activationtime] [int] NULL,
	[constructionradius] [int] NULL,
	[transmitradius] [int] NULL,
	[constructionlevelmax] [int] NULL,
	[blockingradius] [int] NULL,
	[chargeamount] [int] NULL,
	[inconnections] [int] NULL,
	[outconnections] [int] NULL,
	[reinforcecountermax] [int] NULL,
	[bandwidthusage] [int] NULL,
	[bandwidthcapacity] [int] NULL,
	[tint] [varchar](50) NULL,
	[typeexclusiverange] [int] NULL,
	[network_node_range] [int] NULL,
	[hitsize] [float] NULL,
	[note] [varchar](2000) NULL,
);
INSERT INTO #CONFIGS
 ([definition],[targetdefinition],[summonerscount],[cycle_time],[lifetime],[activationtime],
 [constructionradius],[transmitradius],[constructionlevelmax],[blockingradius],
 [inconnections],[outconnections],[reinforcecountermax],[bandwidthusage],[bandwidthcapacity],[tint]
,[typeexclusiverange],[network_node_range],[hitsize],[note])
VALUES
(@DEF_CAP, @DEF_OBJ, NULL, 30000, 168, NULL, 6, 0, 100, 5, 0, 0, 1, 0, 0, NULL, 200, 0, 7.071, 'capsule->object staging base'),
(@DEF_OBJ, @DEF, 1, NULL, 168, 5000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '#000000', NULL, NULL, NULL, 'object->base staging'),
(@DEF, NULL, NULL, 30000, 168, NULL, 6, 0, 100, 5, 0, 0, 1, 0, 0, '#820028', 200, 0, 7.071, 'staging base');


DROP TABLE IF EXISTS #VALS;
CREATE TABLE #VALS(
	defname varchar(100),
	fieldname varchar(100),
	fieldvalue float
);
INSERT INTO #VALS(defname, fieldname, fieldvalue) VALUES
(@DEF_NAME,'armor_max',250000),
(@DEF_NAME,'resist_chemical',50),
(@DEF_NAME,'resist_explosive',50),
(@DEF_NAME,'resist_kinetic',50),
(@DEF_NAME,'resist_thermal',50),
(@DEF_NAME,'signature_radius',100),
(@DEF_NAME,'stealth_strength',80),
(@DEF_NAME+'_capsule','armor_max',250000),
(@DEF_NAME+'_capsule','resist_chemical',50),
(@DEF_NAME+'_capsule','resist_explosive',50),
(@DEF_NAME+'_capsule','resist_kinetic',50),
(@DEF_NAME+'_capsule','resist_thermal',50),
(@DEF_NAME+'_capsule','signature_radius',100),
(@DEF_NAME+'_capsule','stealth_strength',80),
(@DEF_NAME+'_object','armor_max',5000),
(@DEF_NAME+'_object','resist_chemical',50),
(@DEF_NAME+'_object','resist_explosive',50),
(@DEF_NAME+'_object','resist_kinetic',50),
(@DEF_NAME+'_object','resist_thermal',50),
(@DEF_NAME+'_object','signature_radius',5),
(@DEF_NAME+'_object','stealth_strength',120);


--DROP TABLE IF EXISTS #COMPS;
--CREATE TABLE #COMPS(
--	defname varchar(100),
--	compname varchar(100),
--	compval int
--);
--INSERT INTO #COMPS(defname, compname, compval) VALUES
--(@DEF_NAME+'_capsule','def_titanium',2000),
--(@DEF_NAME+'_capsule','def_plasteosine',750),
--(@DEF_NAME+'_capsule','def_alligior',750),
--(@DEF_NAME+'_capsule','def_hydrobenol',200),
--(@DEF_NAME+'_capsule','def_espitium',500),
--(@DEF_NAME+'_capsule','def_unimetal',2000),
--(@DEF_NAME+'_capsule','def_axicol',500),
--(@DEF_NAME+'_capsule','def_axicoline',200);



PRINT N'UPSERT [entitydefaults]';
SET IDENTITY_INSERT entitydefaults ON;
MERGE [dbo].[entitydefaults] d USING #DEFS p
ON d.definition = p.definition
WHEN MATCHED
    THEN UPDATE SET
		definitionname=p.definitionname,
		categoryflags=p.categoryflags,
		attributeflags=p.attributeflags,
		volume=p.volume,
		mass=p.mass,
		tiertype=p.tiertype,
		tierlevel=p.tierlevel,
		options=p.options,
		enabled=p.enabled,
		hidden=p.hidden,
		purchasable=p.purchasable,
		descriptiontoken=p.descriptiontoken
WHEN NOT MATCHED
    THEN INSERT
	([definition], [definitionname],[quantity],[attributeflags],[categoryflags],[options],[note],
	[enabled],[volume],[mass],[hidden],[health],[descriptiontoken],[purchasable],[tiertype],[tierlevel])
	VALUES
	(p.definition, p.definitionname, p.quantity, p.attributeflags, p.categoryflags, p.options, p.note,
	p.enabled, p.volume, p.mass, p.hidden, p.health, p.descriptiontoken, p.purchasable, p.tiertype, p.tierlevel);
SET IDENTITY_INSERT entitydefaults OFF;

PRINT N'UPSERT [definitionconfig]';
MERGE [dbo].[definitionconfig] cd USING #CONFIGS c
ON cd.definition = c.definition
WHEN MATCHED
    THEN UPDATE SET
		definition=c.definition,
		targetdefinition=c.targetdefinition,
		summonerscount = c.summonerscount,
		cycle_time=c.cycle_time,
		[lifetime]=c.[lifetime],
		[activationtime]=c.[activationtime],
		constructionradius=c.constructionradius,
		transmitradius=c.transmitradius,
		constructionlevelmax=c.constructionlevelmax,
		blockingradius=c.blockingradius,
		inconnections=c.inconnections,
		outconnections=c.outconnections,
		reinforcecountermax=c.reinforcecountermax,
		bandwidthusage=c.bandwidthusage,
		bandwidthcapacity=c.bandwidthcapacity,
		[tint]=c.[tint],
		typeexclusiverange=c.typeexclusiverange,
		network_node_range=c.network_node_range,
		hitsize=c.hitsize,
		note=c.note
WHEN NOT MATCHED
    THEN INSERT
	(definition, targetdefinition, [summonerscount], cycle_time, [lifetime], [activationtime],
	constructionradius, transmitradius, constructionlevelmax, blockingradius,
	inconnections, outconnections, reinforcecountermax, bandwidthusage, bandwidthcapacity,[tint],
	typeexclusiverange, network_node_range, hitsize, note)
	VALUES
	(c.definition, c.targetdefinition, c.summonerscount, c.cycle_time, c.lifetime, c.activationtime,
	c.constructionradius, c.transmitradius, c.constructionlevelmax, c.blockingradius,
	c.inconnections, c.outconnections, c.reinforcecountermax, c.bandwidthusage, c.bandwidthcapacity, c.tint,
	c.typeexclusiverange, c.network_node_range, c.hitsize, c.note);



DELETE FROM aggregatevalues WHERE definition IN (
	SELECT definition FROM entitydefaults WHERE definitionname IN (
		SELECT DISTINCT defname FROM #VALS
	)
);

--DELETE FROM components WHERE definition IN (
--	SELECT definition FROM entitydefaults WHERE definitionname IN (
--		SELECT DISTINCT defname FROM #COMPS
--	)
--); 


PRINT N'UPSERT [aggregatevalues]';
MERGE [dbo].[aggregatevalues] v USING #VALS p
ON v.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=p.defname) AND 
v.field=(SELECT TOP 1 id FROM aggregatefields WHERE name=p.fieldname)
WHEN MATCHED
    THEN UPDATE SET
		value = p.fieldvalue
WHEN NOT MATCHED
    THEN INSERT (definition, field, value) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=p.defname),
	(SELECT TOP 1 id FROM aggregatefields WHERE name=p.fieldname),
	p.fieldvalue);

--PRINT N'UPSERT [components]';
--MERGE [dbo].[components] c USING #COMPS p
--ON c.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=p.defname) AND 
--c.componentdefinition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=p.compname)
--WHEN MATCHED
--    THEN UPDATE SET
--		componentdefinition = (SELECT TOP 1 id FROM entitydefaults WHERE definitionname=p.compname),
--		componentamount = p.compval
--WHEN NOT MATCHED
--    THEN INSERT (definition, componentdefinition, componentamount) VALUES
--	((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=p.defname),
--	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=p.compname),
--	p.compval);


DELETE FROM environmentdescription WHERE definition=@DEF;
INSERT INTO environmentdescription (definition, descriptionstring) VALUES
(@DEF,@ENV_STR);

GO


PRINT N'26_zoneeffects_t0_update__2021_11_07.sql';
USE [perpetuumsa]
GO

------------------------------------------
-- T0 speed effect add
--
-- Date modified: 2021/11/07
------------------------------------------

DECLARE @T0_EFFECT_NAME  AS VARCHAR(100) = 'effect_gamma_t0';
DECLARE @T0_EFFECT_ID AS INT = (SELECT TOP 1 id FROM effects WHERE name=@T0_EFFECT_NAME);

DROP TABLE IF EXISTS #EFFECTMODS;
CREATE TABLE #EFFECTMODS 
(
	effId INT,
	fieldName VARCHAR(100),
	fieldValue FLOAT
);
INSERT INTO #EFFECTMODS (effId, fieldName, fieldValue) VALUES
(@T0_EFFECT_ID, 'effect_mining_amount_modifier', 1.75),
(@T0_EFFECT_ID, 'effect_harvesting_amount_modifier', 1.75),
(@T0_EFFECT_ID, 'speed_max', 0.14),
(@T0_EFFECT_ID, 'pbs_tech_limit', 0);

MERGE [dbo].[effectdefaultmodifiers] m USING #EFFECTMODS e
ON m.effectid = e.effId AND m.field=(SELECT TOP 1 id FROM aggregatefields WHERE name=e.fieldName)
WHEN MATCHED
    THEN UPDATE SET
		m.effectid=e.effId,
		m.field=(SELECT TOP 1 id FROM aggregatefields WHERE name=e.fieldName),
		m.value=e.fieldValue
WHEN NOT MATCHED
	THEN INSERT (effectid, field, value) VALUES
		(e.effId, (SELECT TOP 1 id FROM aggregatefields WHERE name=e.fieldName), e.fieldValue);
		
GO


PRINT N'30_npc_gamma_defs__2021_10_25.sql';
USE perpetuumsa
GO

---------------------------------
-- Define ALL THE NPCS for gamma
-- Except npc base stuff ;)
-- Contributor: Ghroom
-- Date Modified: 2021/11/14
---------------------------------

DROP TABLE IF EXISTS #TMPBOTTEMPLATE;
CREATE TABLE #TMPBOTTEMPLATE(
	name [varchar](100) NOT NULL,
	description [varchar](max) NOT NULL,
	note [nvarchar](2000) NULL
);
INSERT INTO #TMPBOTTEMPLATE (name, description, note) 
SELECT lower(name), description, note from (
SELECT 'gamma_Sequer_Basic' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_sequer_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_sequer_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_sequer_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_sequer_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_shield_hardener'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_cargo_scanner'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_cpu_upgrade'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_jammer'), '|slot=i4',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_rocket_launcher'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_rocket_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(10)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_shield_generator'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_core_battery'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_plate'), '|slot=i4',']',
']')
 as description,'Hauler, Shield, EWAR' as note
UNION ALL
SELECT 'gamma_Lithus_Basic' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_lithus_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_lithus_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_lithus_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_lithus_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_shield_hardener'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_cargo_scanner'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_jammer'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_armor_repairer_upgrade'), '|slot=i4',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_rocket_launcher'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_rocket_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(10)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_energy_vampire'), '|slot=i2',']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_shield_generator'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_core_battery'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i4',']',
']')
 as description,'Hauler, Shield, EWAR' as note
UNION ALL
SELECT 'gamma_Scarab_Basic' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_scarab_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_scarab_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_scarab_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_scarab_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_shield_hardener'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_shield_hardener'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_jammer'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_cargo_scanner'), '|slot=i4',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_rocket_launcher'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_rocket_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(10)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_rocket_launcher'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_rocket_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(10)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_shield_generator'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_plate'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_core_battery'), '|slot=i3',']',
']')
 as description,'Hauler, Shield, EWAR' as note
UNION ALL
SELECT 'gamma_Riveler_Basic' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_riveler_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_riveler_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_riveler_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_riveler_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mining_upgrade'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mining_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mining_upgrade'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mining_probe_module'), '|slot=i4',']',
']',
'#chassisModules=[',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_energy_vampire'), '|slot=i2',']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_autocannon'), '|slot=i6','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(100)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_shield_generator'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_core_recharger'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_core_battery'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_core_battery'), '|slot=i5',']',
']')
 as description,'Miner, Shield, Enwar' as note
UNION ALL
SELECT 'gamma_Symbiont_Basic' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_symbiont_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_symbiont_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_symbiont_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_symbiont_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mining_upgrade'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mining_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mining_upgrade'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_stealth_modul'), '|slot=i4',']',
']',
'#chassisModules=[',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_energy_vampire'), '|slot=i3',']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_autocannon'), '|slot=i6','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_t'), '|ammoQuantity=i', (SELECT dbo.ToHex(100)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_shield_generator'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_core_recharger'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_core_battery'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_core_battery'), '|slot=i5',']',
']')
 as description,'Miner, Shield, Enwar' as note
UNION ALL
SELECT 'gamma_Daidalos_Basic' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_daidalos_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_daidalos_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_daidalos_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_daidalos_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_projectile'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_armor_repairer_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i3',']',
']',
'#chassisModules=[',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_autocannon'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(100)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_autocannon'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(100)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_plate'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_plate'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i5',']',
']')
 as description,'Hauler, DPS, Armor' as note
UNION ALL
SELECT 'gamma_Ikarus_Basic' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ikarus_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ikarus_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ikarus_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ikarus_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_webber'), '|slot=i1',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_energy_vampire'), '|slot=i1',']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i1',']',
']')
 as description,'Hauler, Tackle, Enwar' as note
UNION ALL
SELECT 'gamma_Cronus_Basic' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_cronus_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_cronus_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_cronus_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_cronus_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_projectile'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mining_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mining_upgrade'), '|slot=i3',']',
']',
'#chassisModules=[',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_autocannon'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_t'), '|ammoQuantity=i', (SELECT dbo.ToHex(100)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_shield_generator'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_core_battery'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_plate'), '|slot=i3',']',
']')
 as description,'Miner, Shield' as note
UNION ALL
SELECT 'gamma_Hermes_Basic' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_hermes_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_hermes_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_hermes_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_hermes_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_projectile'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mining_probe_module'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_projectile'), '|slot=i3',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_autocannon'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(100)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_autocannon'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(100)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_autocannon'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(100)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_autocannon'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(100)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_shield_generator'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_core_battery'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_plate'), '|slot=i3',']',
']')
 as description,'Explorer, Shield, DPS' as note
UNION ALL
SELECT 'gamma_Termis_Basic' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_termis_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_termis_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_termis_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_termis_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mining_upgrade'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mining_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mining_upgrade'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mining_probe_module'), '|slot=i4',']',
']',
'#chassisModules=[',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_energy_vampire'), '|slot=i3',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_autocannon'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(100)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_shield_generator'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_core_battery'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_core_battery'), '|slot=i4',']',
']')
 as description,'Miner, Shield, Enwar' as note
UNION ALL
SELECT 'gamma_Gargoyle_Basic' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_gargoyle_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_gargoyle_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_gargoyle_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_gargoyle_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mining_upgrade'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mining_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mining_upgrade'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_stealth_modul'), '|slot=i4',']',
']',
'#chassisModules=[',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_energy_vampire'), '|slot=i3',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_autocannon'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_t'), '|ammoQuantity=i', (SELECT dbo.ToHex(100)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_shield_generator'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_core_battery'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_core_battery'), '|slot=i4',']',
']')
 as description,'Miner, Shield, Enwar' as note
UNION ALL
SELECT 'gamma_Argano_Basic' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_argano_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_argano_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_argano_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_argano_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mining_upgrade'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mining_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mining_probe_module'), '|slot=i3',']',
']',
'#chassisModules=[',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_autocannon'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(100)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_shield_generator'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_core_battery'), '|slot=i3',']',
']')
 as description,'Miner, Shield' as note
UNION ALL
SELECT 'gamma_Laird_Basic' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_laird_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_laird_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_laird_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_laird_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mining_upgrade'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mining_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_stealth_modul'), '|slot=i3',']',
']',
'#chassisModules=[',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_autocannon'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_t'), '|ammoQuantity=i', (SELECT dbo.ToHex(100)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_shield_generator'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_core_battery'), '|slot=i3',']',
']')
 as description,'Miner, Shield' as note
UNION ALL
SELECT 'gamma_Seth_DPS' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_seth_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_seth_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_seth_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_seth_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_laser'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_laser'), '|slot=i5',']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_laser'), '|slot=i6',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_laser'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_laser'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_laser'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_laser'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_laser'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_laser'), '|slot=i6','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_plate'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_kin_armor_hardener'), '|slot=i5',']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i6',']',
']')
 as description,'DPS, LWF, Armor' as note
UNION ALL
SELECT 'gamma_Seth_Tank' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_seth_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_seth_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_seth_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_seth_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_armor_repairer_upgrade'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_armor_repairer_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_eccm'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_armor_repairer_upgrade'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_laser'), '|slot=i5',']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_laser'), '|slot=i6',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_laser'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_b'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_laser'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_b'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_laser'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_b'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_laser'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_b'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_laser'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_b'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_laser'), '|slot=i6','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_b'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_plate'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_kin_armor_hardener'), '|slot=i5',']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_plate'), '|slot=i6',']',
']')
 as description,'Armor, DPS, Repair' as note
UNION ALL
SELECT 'gamma_Artemis_DPS' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_artemis_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_artemis_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_artemis_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_artemis_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_laser'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_laser'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_laser'), '|slot=i5',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_laser'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_laser'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_laser'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_laser'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_missile_c'), '|ammoQuantity=i', (SELECT dbo.ToHex(25)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_plate'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_kin_armor_hardener'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i5',']',
']')
 as description,'DPS, LWF, Armor' as note
UNION ALL
SELECT 'gamma_Artemis_Tank' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_artemis_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_artemis_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_artemis_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_artemis_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_armor_repairer_upgrade'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_armor_repairer_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_eccm'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_armor_repairer_upgrade'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_laser'), '|slot=i5',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_laser'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_b'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_laser'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_b'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_laser'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_b'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_laser'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_b'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_plate'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_kin_armor_hardener'), '|slot=i5',']',
']')
 as description,'DPS, Armor' as note
UNION ALL
SELECT 'gamma_Baphomet_DPS' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_baphomet_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_baphomet_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_baphomet_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_baphomet_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_laser'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_laser'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_laser'), '|slot=i5',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_laser'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_lasercrystal_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_laser'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_lasercrystal_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_laser'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_lasercrystal_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_laser'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_lasercrystal_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_laser'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_lasercrystal_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_plate'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_kin_armor_hardener'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i5',']',
']')
 as description,'DPS, Armor' as note
UNION ALL
SELECT 'gamma_Baphomet_Speed' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_baphomet_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_baphomet_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_baphomet_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_baphomet_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_webber'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_eccm'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_laser'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_laser'), '|slot=i5',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_laser'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_lasercrystal_b'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_laser'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_lasercrystal_b'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_laser'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_lasercrystal_b'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_laser'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_lasercrystal_b'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_laser'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_lasercrystal_b'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_plate'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_kin_armor_hardener'), '|slot=i5',']',
']')
 as description,'Speed, Tackle' as note
UNION ALL
SELECT 'gamma_Prometheus_DPS' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_prometheus_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_prometheus_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_prometheus_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_prometheus_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_laser'), '|slot=i3',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_laser'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_lasercrystal_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_laser'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_lasercrystal_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_laser'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_lasercrystal_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_laser'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_lasercrystal_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_kin_armor_hardener'), '|slot=i4',']',
']')
 as description,'DPS, Speed' as note
UNION ALL
SELECT 'gamma_Prometheus_Speed' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_prometheus_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_prometheus_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_prometheus_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_prometheus_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_webber'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_laser'), '|slot=i3',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_laser'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_lasercrystal_b'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_laser'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_lasercrystal_b'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_laser'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_lasercrystal_b'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_laser'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_lasercrystal_b'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_kin_armor_hardener'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i4',']',
']')
 as description,'LWF, Tackle, DPS' as note
UNION ALL
SELECT 'gamma_Zenith_Shield' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_zenith_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_zenith_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_zenith_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_zenith_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_dampener'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_dampener'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_jammer'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_supressor_booster'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_dampener'), '|slot=i5',']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_dampener'), '|slot=i6',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_energy_vampire'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_energy_vampire'), '|slot=i2',']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_shield_generator'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_core_battery'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i4',']',
']')
 as description,'Shield, LWF, Enwar, EWAR' as note
UNION ALL
SELECT 'gamma_Zenith_Armor' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_zenith_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_zenith_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_zenith_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_zenith_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_target_painter'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_dampener'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_dampener'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_jammer'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_dampener'), '|slot=i5',']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_laser'), '|slot=i6',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_laser'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_b'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_laser'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_b'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_laser'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_b'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_plate'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_kin_armor_hardener'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i4',']',
']')
 as description,'Armor, Painter, EWAR, DPS' as note
UNION ALL
SELECT 'gamma_Intakt_Shield' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_intakt_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_intakt_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_intakt_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_intakt_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_webber'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_dampener'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_jammer'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_dampener'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i5',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_energy_vampire'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_energy_vampire'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_energy_vampire'), '|slot=i3',']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_shield_generator'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_core_battery'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_kin_armor_hardener'), '|slot=i3',']',
']')
 as description,'Shield, LWF, Enwar, Tackle' as note
UNION ALL
SELECT 'gamma_Intakt_Armor' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_intakt_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_intakt_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_intakt_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_intakt_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_dampener'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_jammer'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_dampener'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_laser'), '|slot=i5',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_laser'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_lasercrystal_b'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_laser'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_lasercrystal_b'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_energy_vampire'), '|slot=i3',']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_plate'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_kin_armor_hardener'), '|slot=i3',']',
']')
 as description,'Armor, DPS, Enwar' as note
UNION ALL
SELECT 'gamma_Gropho_DPS' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_gropho_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_gropho_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_gropho_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_gropho_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_missile'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_missile'), '|slot=i5',']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_missile'), '|slot=i6',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_missile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_missile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_missile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_missile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_missile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i6','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_missile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_plate'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_thrm_armor_hardener'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i5',']',
']')
 as description,'DPS, LWF, Armor' as note
UNION ALL
SELECT 'gamma_Gropho_Tank' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_gropho_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_gropho_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_gropho_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_gropho_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_shield_hardener'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_shield_hardener'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_eccm'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_missile'), '|slot=i5',']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_missile'), '|slot=i6',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_longrange_missile_c'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_longrange_missile_c'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_longrange_missile_c'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_longrange_missile_c'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_longrange_missile_c'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i6','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_longrange_missile_c'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m6=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_energy_vampire'), '|slot=i7',']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_shield_generator'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_core_battery'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_thrm_armor_hardener'), '|slot=i5',']',
']')
 as description,'Shield, Enwar, DPS' as note
UNION ALL
SELECT 'gamma_Tyrannos_DPS' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_tyrannos_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_tyrannos_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_tyrannos_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_tyrannos_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_missile'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_missile'), '|slot=i5',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_missile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_missile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_missile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_missile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_autocannon'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_c'), '|ammoQuantity=i', (SELECT dbo.ToHex(100)),']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_autocannon'), '|slot=i6','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_c'), '|ammoQuantity=i', (SELECT dbo.ToHex(100)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_plate'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_thrm_armor_hardener'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i4',']',
']')
 as description,'DPS, LWF, Armor' as note
UNION ALL
SELECT 'gamma_Tyrannos_Tank' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_tyrannos_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_tyrannos_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_tyrannos_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_tyrannos_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_shield_hardener'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_eccm'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_missile'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_missile'), '|slot=i5',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_longrange_missile_c'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_longrange_missile_c'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_longrange_missile_c'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_longrange_missile_c'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_energy_vampire'), '|slot=i5',']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_energy_vampire'), '|slot=i6',']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_shield_generator'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_core_battery'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_thrm_armor_hardener'), '|slot=i4',']',
']')
 as description,'Shield, DPS' as note
UNION ALL
SELECT 'gamma_Waspish_DPS' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_waspish_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_waspish_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_waspish_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_waspish_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_missile'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_missile'), '|slot=i5',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_rocket_launcher'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_rocket_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_rocket_launcher'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_rocket_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_rocket_launcher'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_rocket_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_rocket_launcher'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_rocket_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_rocket_launcher'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_rocket_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_autocannon'), '|slot=i6','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_c'), '|ammoQuantity=i', (SELECT dbo.ToHex(100)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_plate'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_thrm_armor_hardener'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i4',']',
']')
 as description,'DPS, LWF, Armor' as note
UNION ALL
SELECT 'gamma_Waspish_Speed' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_waspish_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_waspish_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_waspish_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_waspish_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_shield_hardener'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_webber'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_missile'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_missile'), '|slot=i5',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_rocket_launcher'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_rocket_c'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_rocket_launcher'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_rocket_c'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_rocket_launcher'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_rocket_c'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_rocket_launcher'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_rocket_c'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_rocket_launcher'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_rocket_c'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_energy_vampire'), '|slot=i6',']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_shield_generator'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_core_battery'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_repairer'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_thrm_armor_hardener'), '|slot=i4',']',
']')
 as description,'Shield, Tackle' as note
UNION ALL
SELECT 'gamma_Castel_DPS' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_castel_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_castel_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_castel_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_castel_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_missile'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_missile'), '|slot=i4',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_rocket_launcher'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_rocket_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_rocket_launcher'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_rocket_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_rocket_launcher'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_rocket_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_rocket_launcher'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_rocket_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_repairer'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_thrm_armor_hardener'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i3',']',
']')
 as description,'DPS, LWF, Armor' as note
UNION ALL
SELECT 'gamma_Castel_Speed' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_castel_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_castel_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_castel_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_castel_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_shield_hardener'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_webber'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_missile'), '|slot=i4',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_rocket_launcher'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_rocket_c'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_rocket_launcher'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_rocket_c'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_rocket_launcher'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_rocket_c'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_rocket_launcher'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_rocket_c'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_shield_generator'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_core_battery'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_repairer'), '|slot=i3',']',
']')
 as description,'Shield, Tackle, DPS' as note
UNION ALL
SELECT 'gamma_Ictus_Shield' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ictus_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ictus_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ictus_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ictus_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_shield_hardener'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_shield_hardener'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i4',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_energy_vampire'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_energy_vampire'), '|slot=i2',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_energy_neutralizer'), '|slot=i5',']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_shield_generator'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_energy_warfare_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_plate'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i4',']',
']')
 as description,'Shield, LWF, Enwar' as note
UNION ALL
SELECT 'gamma_Ictus_Armor' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ictus_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ictus_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ictus_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ictus_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_target_painter'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_missile'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_missile'), '|slot=i4',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_energy_vampire'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_energy_vampire'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_longrange_missile_c'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_longrange_missile_c'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_longrange_missile_c'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_plate'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_thrm_armor_hardener'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i4',']',
']')
 as description,'Armor, Painter, Enwar, DPS' as note
UNION ALL
SELECT 'gamma_Troiar_Shield' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_troiar_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_troiar_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_troiar_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_troiar_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_shield_hardener'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_webber'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i3',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_energy_vampire'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_energy_vampire'), '|slot=i2',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_energy_neutralizer'), '|slot=i5',']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_shield_generator'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i3',']',
']')
 as description,'Shield, LWF, Enwar, Tackle' as note
UNION ALL
SELECT 'gamma_Troiar_Armor' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_troiar_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_troiar_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_troiar_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_troiar_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_missile'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_missile'), '|slot=i3',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_energy_vampire'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_energy_vampire'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_rocket_launcher'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_rocket_c'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_rocket_launcher'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_rocket_c'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_energy_vampire'), '|slot=i5',']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_plate'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_thrm_armor_hardener'), '|slot=i3',']',
']')
 as description,'Armor, Enwar, DPS' as note
UNION ALL
SELECT 'gamma_Mesmer_DPS' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_mesmer_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_mesmer_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_mesmer_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_mesmer_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_railgun'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_railgun'), '|slot=i5',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_railgun'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_railgun'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_railgun'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_railgun'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_railgun'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_railgun'), '|slot=i6','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m6=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_energy_vampire'), '|slot=i7',']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_plate'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_exp_armor_hardener'), '|slot=i5',']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i6',']',
']')
 as description,'DPS, LWF, Armor' as note
UNION ALL
SELECT 'gamma_Mesmer_Tank' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_mesmer_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_mesmer_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_mesmer_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_mesmer_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_armor_repairer_upgrade'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_armor_repairer_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_eccm'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_armor_repairer_upgrade'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_railgun'), '|slot=i5',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_railgun'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_railgun'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_railgun'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_railgun'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_railgun'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_railgun'), '|slot=i6','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m6=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_energy_vampire'), '|slot=i7',']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_core_booster'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_corebooster_ammo'), '|ammoQuantity=i', (SELECT dbo.ToHex(10)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_exp_armor_hardener'), '|slot=i5',']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_plate'), '|slot=i6',']',
']')
 as description,'Armor, Repair' as note
UNION ALL
SELECT 'gamma_Kain_DPS' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_kain_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_kain_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_kain_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_kain_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_railgun'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_railgun'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_missile'), '|slot=i4',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_railgun'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_railgun'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_railgun'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_railgun'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_missile_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i6','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_missile_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_exp_armor_hardener'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i5',']',
']')
 as description,'DPS, LWF, Armor' as note
UNION ALL
SELECT 'gamma_Kain_Tank' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_kain_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_kain_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_kain_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_kain_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_armor_repairer_upgrade'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_armor_repairer_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_armor_repairer_upgrade'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_railgun'), '|slot=i4',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_railgun'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_railgun'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_railgun'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_railgun'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_exp_armor_hardener'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_core_booster'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_corebooster_ammo'), '|ammoQuantity=i', (SELECT dbo.ToHex(10)),']',
']')
 as description,'Armor, Repair' as note
UNION ALL
SELECT 'gamma_Arbalest_DPS' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_arbalest_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_arbalest_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_arbalest_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_arbalest_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_railgun'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_railgun'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_railgun'), '|slot=i4',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_railgun'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_railgun_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_railgun'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_railgun_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_railgun'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_railgun_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_railgun'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_railgun_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_railgun'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_railgun_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_rocket_launcher'), '|slot=i6','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_rocket_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_plate'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_core_booster'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_corebooster_ammo'), '|ammoQuantity=i', (SELECT dbo.ToHex(10)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_exp_armor_hardener'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_repairer'), '|slot=i5',']',
']')
 as description,'DPS, Armor' as note
UNION ALL
SELECT 'gamma_Arbalest_Speed' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_arbalest_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_arbalest_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_arbalest_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_arbalest_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_webber'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_eccm'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_railgun'), '|slot=i4',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_railgun'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_railgun_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_railgun'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_railgun_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_railgun'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_railgun_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_railgun'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_railgun_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_railgun'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_railgun_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_rocket_launcher'), '|slot=i6','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_rocket_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_repairer'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_plate'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_exp_armor_hardener'), '|slot=i5',']',
']')
 as description,'Speed, Tackle' as note
UNION ALL
SELECT 'gamma_Yagel_DPS' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_yagel_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_yagel_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_yagel_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_yagel_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_railgun'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_railgun'), '|slot=i3',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_railgun'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_railgun_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_railgun'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_railgun_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_railgun'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_railgun_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_railgun'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_railgun_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_repairer'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_core_booster'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_corebooster_ammo'), '|ammoQuantity=i', (SELECT dbo.ToHex(10)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_exp_armor_hardener'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_repairer'), '|slot=i4',']',
']')
 as description,'DPS, Armor' as note
UNION ALL
SELECT 'gamma_Yagel_Speed' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_yagel_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_yagel_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_yagel_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_yagel_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_webber'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_railgun'), '|slot=i3',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_railgun'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_railgun_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_railgun'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_railgun_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_railgun'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_railgun_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_railgun'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_railgun_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_repairer'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_exp_armor_hardener'), '|slot=i4',']',
']')
 as description,'Speed, Tackle' as note
UNION ALL
SELECT 'gamma_Vagabond_Shield' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_vagabond_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_vagabond_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_vagabond_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_vagabond_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_dampener'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_jammer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_jammer'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_ecm_booster'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_jammer'), '|slot=i5',']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_jammer'), '|slot=i6',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_energy_vampire'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_energy_vampire'), '|slot=i2',']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_shield_generator'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_core_battery'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i4',']',
']')
 as description,'Shield, LWF, Enwar, EWAR' as note
UNION ALL
SELECT 'gamma_Vagabond_Armor' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_vagabond_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_vagabond_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_vagabond_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_vagabond_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_target_painter'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_jammer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_jammer'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_dampener'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_railgun'), '|slot=i5',']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_railgun'), '|slot=i6',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_railgun'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_railgun'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_railgun'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_plate'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_exp_armor_hardener'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i4',']',
']')
 as description,'Armor Fit, Painter, EWAR' as note
UNION ALL
SELECT 'gamma_Cameleon_Shield' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_cameleon_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_cameleon_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_cameleon_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_cameleon_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_webber'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_dampener'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_jammer'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_jammer'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i5',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_energy_vampire'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_energy_vampire'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_energy_vampire'), '|slot=i3',']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_shield_generator'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_core_battery'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_exp_armor_hardener'), '|slot=i3',']',
']')
 as description,'Shield, LWF, Enwar, Tackle' as note
UNION ALL
SELECT 'gamma_Cameleon_Armor' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_cameleon_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_cameleon_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_cameleon_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_cameleon_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_dampener'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_jammer'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_jammer'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_railgun'), '|slot=i5',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_railgun'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_railgun_b'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_railgun'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_railgun_b'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_energy_vampire'), '|slot=i3',']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_plate'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_exp_armor_hardener'), '|slot=i3',']',
']')
 as description,'Armor, DPS, Enwar' as note
UNION ALL
SELECT 'gamma_Legatus_DPS' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_legatus_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_legatus_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_legatus_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_legatus_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_projectile'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_projectile'), '|slot=i5',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_autocannon'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_autocannon'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_autocannon'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_autocannon'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_autocannon'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_autocannon'), '|slot=i6','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_plate'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_plate'), '|slot=i5',']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i6',']',
']')
 as description,'DPS, LWF, Armor' as note
UNION ALL
SELECT 'gamma_Legatus_Tank' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_legatus_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_legatus_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_legatus_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_legatus_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_armor_repairer_upgrade'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_armor_repairer_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_eccm'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_projectile'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_projectile'), '|slot=i5',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_autocannon'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_autocannon'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_autocannon'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_autocannon'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_autocannon'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_autocannon'), '|slot=i6','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_plate'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_plate'), '|slot=i5',']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_plate'), '|slot=i6',']',
']')
 as description,'Armor' as note
UNION ALL
SELECT 'gamma_Echelon_DPS' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_echelon_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_echelon_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_echelon_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_echelon_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_projectile'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_projectile'), '|slot=i5',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_autocannon'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_autocannon'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_autocannon'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_autocannon'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_plate'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_plate'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i5',']',
']')
 as description,'DPS, LWF, Armor' as note
UNION ALL
SELECT 'gamma_Echelon_Tank' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_echelon_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_echelon_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_echelon_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_echelon_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_armor_repairer_upgrade'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_armor_repairer_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_eccm'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_projectile'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_projectile'), '|slot=i5',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_autocannon'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_autocannon'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_autocannon'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_autocannon'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_plate'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_plate'), '|slot=i5',']',
']')
 as description,'Armor' as note
UNION ALL
SELECT 'gamma_Locust_DPS' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_locust_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_locust_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_locust_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_locust_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_projectile'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_projectile'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_projectile'), '|slot=i5',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_autocannon'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_autocannon'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_autocannon'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_autocannon'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_autocannon'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_plate'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_plate'), '|slot=i4',']',
']')
 as description,'DPS, Armor' as note
UNION ALL
SELECT 'gamma_Locust_Speed' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_locust_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_locust_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_locust_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_locust_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_webber'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_eccm'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_projectile'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_projectile'), '|slot=i5',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_autocannon'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_autocannon'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_autocannon'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_autocannon'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_autocannon'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_maneuvering_upgrade'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i4',']',
']')
 as description,'Speed, Tackle' as note
UNION ALL
SELECT 'gamma_Vektor_DPS' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_vektor_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_vektor_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_vektor_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_vektor_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_projectile'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_projectile'), '|slot=i4',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_autocannon'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_autocannon'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_autocannon'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_autocannon'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_maneuvering_upgrade'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i3',']',
']')
 as description,'DPS, Armor' as note
UNION ALL
SELECT 'gamma_Vektor_Speed' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_vektor_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_vektor_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_vektor_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_vektor_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_webber'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_shield_hardener'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_projectile'), '|slot=i4',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_autocannon'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_autocannon'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_autocannon'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_autocannon'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_shield_generator'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i3',']',
']')
 as description,'Speed, Tackle' as note
UNION ALL
SELECT 'gamma_Callisto_Shield' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_callisto_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_callisto_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_callisto_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_callisto_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_dampener'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_jammer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_blob_emission_modulator'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_blob_emission_ammo_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(3)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_webber'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_dampener'), '|slot=i5',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_energy_vampire'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_energy_vampire'), '|slot=i2',']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_shield_generator'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_core_battery'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_plate'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i5',']',
']')
 as description,'Shield, LWF, Enwar, EWAR' as note
UNION ALL
SELECT 'gamma_Callisto_Armor' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_callisto_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_callisto_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_callisto_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_callisto_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_target_painter'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_jammer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_jammer'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_dampener'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_projectile'), '|slot=i5',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_autocannon'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_autocannon'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_autocannon'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_plate'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_chm_armor_hardener'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_maneuvering_upgrade'), '|slot=i5',']',
']')
 as description,'Armor Fit, Painter, EWAR' as note
UNION ALL
SELECT 'gamma_Helix_Shield' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_helix_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_helix_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_helix_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_helix_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_webber'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_jammer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_webber'), '|slot=i4',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_energy_vampire'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_energy_vampire'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_energy_vampire'), '|slot=i3',']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_shield_generator'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_maneuvering_upgrade'), '|slot=i3',']',
']')
 as description,'Shield, LWF, EWAR, Tackle' as note
UNION ALL
SELECT 'gamma_Helix_Armor' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_helix_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_helix_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_helix_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_helix_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_dampener'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_jammer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_projectile'), '|slot=i4',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_autocannon'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_b'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_autocannon'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_b'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_energy_vampire'), '|slot=i3',']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_plate'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_maneuvering_upgrade'), '|slot=i3',']',
']')
 as description,'Armor, DPS, EWAR' as note
UNION ALL
SELECT 'gamma_Onyx_Mammoth' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_onyx_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_onyx_bot_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_onyx_bot_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_onyx_bot_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_eccm'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i4',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_large_laser'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_large_lasercrystal_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_large_laser'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_large_lasercrystal_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_large_laser'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_large_lasercrystal_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_large_laser'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_large_lasercrystal_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_large_laser'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_large_lasercrystal_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_large_laser'), '|slot=i6','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_large_lasercrystal_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_large_armor_plate'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_large_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_kin_armor_hardener'), '|slot=i5',']',
']')
 as description,'Armor, DPS, Destro' as note
UNION ALL
SELECT 'gamma_Hydra_Mammoth' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_hydra_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_hydra_bot_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_hydra_bot_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_hydra_bot_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_eccm'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_shield_hardener'), '|slot=i5',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_cruisemissile_launcher'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_longrange_cruisemissile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_cruisemissile_launcher'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_longrange_cruisemissile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_cruisemissile_launcher'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_longrange_cruisemissile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_cruisemissile_launcher'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_longrange_cruisemissile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_cruisemissile_launcher'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_longrange_cruisemissile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_cruisemissile_launcher'), '|slot=i6','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_longrange_cruisemissile_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_large_shield_generator'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_large_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_thrm_armor_hardener'), '|slot=i4',']',
']')
 as description,'Shield, DPS, Destro' as note
UNION ALL
SELECT 'gamma_Felos_Mammoth' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_felos_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_felos_bot_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_felos_bot_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_felos_bot_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_armor_repairer_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_armor_repairer_upgrade'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i4',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_large_railgun'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_large_railgun_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_large_railgun'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_large_railgun_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_large_railgun'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_large_railgun_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_large_railgun'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_large_railgun_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_large_railgun'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_large_railgun_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_large_railgun'), '|slot=i6','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_large_railgun_d'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_large_core_booster'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_corebooster_ammo'), '|ammoQuantity=i', (SELECT dbo.ToHex(10)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_large_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_exp_armor_hardener'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_large_armor_repairer'), '|slot=i5',']',
']')
 as description,'Armor, DPS, Destro, Repair' as note
UNION ALL
SELECT 'gamma_Seth_Advanced' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_seth_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_seth_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_seth_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_seth_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i5',']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_laser'), '|slot=i6',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_laser'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_laser'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_laser'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_laser'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_laser'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_laser'), '|slot=i6','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_plate'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_kin_armor_hardener'), '|slot=i5',']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i6',']',
']')
 as description,'Observer, DPS, LWF, Armor' as note
UNION ALL
SELECT 'gamma_Artemis_Advanced' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_artemis_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_artemis_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_artemis_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_artemis_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_webber'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_laser'), '|slot=i5',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_laser'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_laser'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_laser'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_laser'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_plate'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_kin_armor_hardener'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i5',']',
']')
 as description,'Observer, DPS, LWF, Tackle' as note
UNION ALL
SELECT 'gamma_Zenith_Advanced' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_zenith_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_zenith_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_zenith_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_zenith_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_dampener'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_jammer'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_supressor_booster'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_dampener'), '|slot=i5',']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_webber'), '|slot=i6',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_laser'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_laser'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_laser'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_plate'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i4',']',
']')
 as description,'Observer, Armor, LWF, Enwar, EWAR, Tackle' as note
UNION ALL
SELECT 'gamma_Gropho_Advanced' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_gropho_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_gropho_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_gropho_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_gropho_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i5',']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_missile'), '|slot=i6',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_missile_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_missile_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_missile_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_missile_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_missile_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i6','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_missile_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m6=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_energy_vampire'), '|slot=i7',']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_shield_generator'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_thrm_armor_hardener'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_core_recharger'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i5',']',
']')
 as description,'Observer, DPS, LWF, Shield, Enwar' as note
UNION ALL
SELECT 'gamma_Tyrannos_Advanced' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_tyrannos_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_tyrannos_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_tyrannos_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_tyrannos_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_webber'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_missile'), '|slot=i5',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_missile_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_missile_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_missile_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_missile_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_energy_vampire'), '|slot=i5',']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_energy_vampire'), '|slot=i6',']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_shield_generator'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_core_battery'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i4',']',
']')
 as description,'Observer, DPS, Shield, Tackle, Enwar' as note
UNION ALL
SELECT 'gamma_Ictus_Advanced' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ictus_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ictus_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ictus_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ictus_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_shield_hardener'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_webber'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i4',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_energy_vampire'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_energy_vampire'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_longrange_missile_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_longrange_missile_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_energy_neutralizer'), '|slot=i5',']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_shield_generator'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_energy_warfare_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i4',']',
']')
 as description,'Observer, Shield, LWF, Enwar, Tackle' as note
UNION ALL
SELECT 'gamma_Mesmer_Advanced' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_mesmer_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_mesmer_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_mesmer_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_mesmer_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_railgun'), '|slot=i5',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_railgun'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_railgun'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_railgun'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_railgun'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_railgun'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_railgun'), '|slot=i6','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m6=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_energy_vampire'), '|slot=i7',']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_core_booster'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_corebooster_ammo'), '|ammoQuantity=i', (SELECT dbo.ToHex(10)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_exp_armor_hardener'), '|slot=i5',']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i6',']',
']')
 as description,'Observer, Armor, Repair, Enwar' as note
UNION ALL
SELECT 'gamma_Kain_Advanced' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_kain_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_kain_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_kain_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_kain_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_webber'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i4',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_railgun'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_railgun'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_railgun'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_railgun'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_plate'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_exp_armor_hardener'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i5',']',
']')
 as description,'Observer, DPS, LWF, Armor, Tackle' as note
UNION ALL
SELECT 'gamma_Vagabond_Advanced' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_vagabond_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_vagabond_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_vagabond_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_vagabond_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_dampener'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_jammer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_jammer'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_ecm_booster'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i5',']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_webber'), '|slot=i6',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_energy_vampire'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_energy_vampire'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_railgun'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_shield_generator'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_core_battery'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i4',']',
']')
 as description,'Observer, Shield, LWF, Enwar, EWAR, Tackle' as note
UNION ALL
SELECT 'gamma_Legatus_Advanced' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_legatus_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_legatus_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_legatus_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_legatus_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_projectile'), '|slot=i5',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_autocannon'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_autocannon'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_autocannon'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_autocannon'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_autocannon'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_autocannon'), '|slot=i6','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_plate'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_large_armor_plate'), '|slot=i5',']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i6',']',
']')
 as description,'Observer, DPS, LWF, Armor' as note
UNION ALL
SELECT 'gamma_Echelon_Advanced' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_echelon_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_echelon_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_echelon_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_echelon_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_webber'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_projectile'), '|slot=i5',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_autocannon'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_autocannon'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_autocannon'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_autocannon'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_plate'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_plate'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i5',']',
']')
 as description,'Observer, DPS, LWF, Armor, Tackle' as note
UNION ALL
SELECT 'gamma_Callisto_Advanced' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_callisto_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_callisto_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_callisto_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_callisto_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_dampener'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_jammer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_blob_emission_modulator'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_blob_emission_ammo_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(3)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_webber'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i5',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_energy_vampire'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_energy_vampire'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_autocannon'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(1)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_shield_generator'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_core_battery'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_plate'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_maneuvering_upgrade'), '|slot=i5',']',
']')
 as description,'Observer, Shield, LWF, Enwar, EWAR, Interference, Tackle' as note
UNION ALL
SELECT 'gamma_Seth_Boss' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_seth_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_seth_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_seth_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_seth_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_armor_repairer_upgrade'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_armor_repairer_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_armor_repairer_upgrade'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_laser'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_laser'), '|slot=i5',']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_laser'), '|slot=i6',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_laser'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_laser'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_laser'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_laser'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_laser'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_laser'), '|slot=i6','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_plate'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_plate'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_kin_armor_hardener'), '|slot=i5',']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_core_recharger'), '|slot=i6',']',
']')
 as description,'Miniboss, DPS, Armor' as note
UNION ALL
SELECT 'gamma_Gropho_Boss' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_gropho_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_gropho_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_gropho_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_gropho_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_shield_hardener'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_shield_hardener'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_armor_repairer_upgrade'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_missile'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_missile'), '|slot=i5',']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_missile'), '|slot=i6',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_missile_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_missile_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_missile_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_missile_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_missile_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i6','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_missile_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m6=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_energy_vampire'), '|slot=i7',']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_shield_generator'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_thrm_armor_hardener'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_core_booster'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_corebooster_ammo'), '|ammoQuantity=i', (SELECT dbo.ToHex(10)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_core_recharger'), '|slot=i5',']',
']')
 as description,'Miniboss, DPS, Shield, Enwar' as note
UNION ALL
SELECT 'gamma_Mesmer_Boss' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_mesmer_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_mesmer_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_mesmer_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_mesmer_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_armor_repairer_upgrade'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_armor_repairer_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_armor_repairer_upgrade'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_armor_repairer_upgrade'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_railgun'), '|slot=i5',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_railgun'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_railgun'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_railgun'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_railgun'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_railgun'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_railgun'), '|slot=i6','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_core_booster'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_corebooster_ammo'), '|ammoQuantity=i', (SELECT dbo.ToHex(10)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_core_recharger'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_exp_armor_hardener'), '|slot=i5',']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_repairer'), '|slot=i6',']',
']')
 as description,'Miniboss, Armor, Repair' as note
UNION ALL
SELECT 'gamma_Legatus_Boss' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_legatus_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_legatus_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_legatus_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_legatus_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_armor_repairer_upgrade'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_projectile'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_projectile'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_projectile'), '|slot=i5',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_autocannon'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_autocannon'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_autocannon'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_autocannon'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_autocannon'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_autocannon'), '|slot=i6','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_chm_armor_hardener'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_large_armor_plate'), '|slot=i5',']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_large_armor_plate'), '|slot=i6',']',
']')
 as description,'Miniboss, DPS, Armor' as note
UNION ALL
SELECT 'gamma_Onyx_Thelodica' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_onyx_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_onyx_bot_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_onyx_bot_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_onyx_bot_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_standard_blob_emission_modulator'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_blob_emission_ammo_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(10)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_armor_repairer_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_armor_repairer_upgrade'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_laser'), '|slot=i4',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_large_laser'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_large_lasercrystal_b'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_large_laser'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_large_lasercrystal_b'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_large_laser'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_large_lasercrystal_b'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_large_laser'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_large_lasercrystal_b'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_large_laser'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_large_lasercrystal_b'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_large_laser'), '|slot=i6','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_large_lasercrystal_b'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_large_armor_plate'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_large_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_kin_armor_hardener'), '|slot=i5',']',
']')
 as description,'Pitboss, Armor, DPS, Destro' as note
UNION ALL
SELECT 'gamma_Hydra_Pelistal' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_hydra_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_hydra_bot_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_hydra_bot_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_hydra_bot_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_shield_hardener'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_standard_blob_emission_modulator'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_blob_emission_ammo_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(10)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_shield_hardener'), '|slot=i5',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_cruisemissile_launcher'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_longrange_cruisemissile_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_cruisemissile_launcher'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_longrange_cruisemissile_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_cruisemissile_launcher'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_longrange_cruisemissile_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_cruisemissile_launcher'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_longrange_cruisemissile_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_cruisemissile_launcher'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_longrange_cruisemissile_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_cruisemissile_launcher'), '|slot=i6','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_longrange_cruisemissile_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_large_shield_generator'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_large_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_plate'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_large_core_booster'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_corebooster_ammo'), '|ammoQuantity=i', (SELECT dbo.ToHex(10)),']',
']')
 as description,'Pitboss, Shield, DPS, Destro' as note
UNION ALL
SELECT 'gamma_Felos_Nuimqol' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_felos_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_felos_bot_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_felos_bot_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_felos_bot_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_standard_blob_emission_modulator'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_blob_emission_ammo_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(10)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_armor_repairer_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_armor_repairer_upgrade'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i4',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_large_railgun'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_large_railgun_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_large_railgun'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_large_railgun_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_large_railgun'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_large_railgun_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_large_railgun'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_large_railgun_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_large_railgun'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_large_railgun_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_large_railgun'), '|slot=i6','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_large_railgun_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_large_armor_repairer'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_large_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_explosive_kers'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i5',']',
']')
 as description,'Pitboss, Armor, DPS, Destro, Repair' as note
UNION ALL
SELECT 'gamma_Apollo_Syndicate' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_onyx_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_gargoyle_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_mesmer_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_onyx_bot_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_standard_blob_emission_modulator'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_blob_emission_ammo_a'), '|ammoQuantity=i', (SELECT dbo.ToHex(10)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_armor_repairer_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_armor_repairer_upgrade'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i4',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_autocannon'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_autocannon'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_autocannon'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_autocannon'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_autocannon'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_longrange_medium_autocannon'), '|slot=i6','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_large_armor_plate'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_chm_armor_hardener'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_large_armor_plate'), '|slot=i5',']',
']')
 as description,'Pitboss, Armor, DPS, Destro' as note
UNION ALL
SELECT 'gamma_Baphomet_Advanced' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_baphomet_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_baphomet_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_baphomet_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_baphomet_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_laser'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_laser'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_webber'), '|slot=i5',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_laser'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_lasercrystal_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_laser'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_laser'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_lasercrystal_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_laser'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_laser'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_lasercrystal_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_plate'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_resistant_plating'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i5',']',
']')
 as description,'Courier, DPS, Armor, Tackle' as note
UNION ALL
SELECT 'gamma_Intakt_Advanced' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_intakt_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_intakt_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_intakt_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_intakt_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_jammer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_dampener'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_dampener'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_webber'), '|slot=i5',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_laser'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_lasercrystal_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_laser'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_lasercrystal_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_energy_vampire'), '|slot=i3',']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_core_booster'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_corebooster_ammo'), '|ammoQuantity=i', (SELECT dbo.ToHex(10)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_shield_generator'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i3',']',
']')
 as description,'Courier, DPS, Shield, EWAR' as note
UNION ALL
SELECT 'gamma_Prometheus_Advanced' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_prometheus_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_prometheus_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_prometheus_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_prometheus_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_target_painter'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_webber'), '|slot=i3',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_laser'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_lasercrystal_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_laser'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_laser'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_lasercrystal_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_laser'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_repairer'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_core_booster'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_corebooster_ammo'), '|ammoQuantity=i', (SELECT dbo.ToHex(0)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i3',']',
']')
 as description,'Courier, DPS, Armor, Tackle, Painter' as note
UNION ALL
SELECT 'gamma_Waspish_Advanced' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_waspish_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_waspish_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_waspish_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_waspish_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_shield_hardener'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_webber'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_missile'), '|slot=i5',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_rocket_launcher'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_rocket_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_missile_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_rocket_launcher'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_rocket_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_rocket_launcher'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_rocket_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_missile_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_energy_vampire'), '|slot=i6',']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_shield_generator'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_core_battery'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_repairer'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i4',']',
']')
 as description,'Courier, Shield, Tackle, DPS' as note
UNION ALL
SELECT 'gamma_Troiar_Advanced' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_troiar_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_troiar_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_troiar_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_troiar_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_shield_hardener'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_webber'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i3',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_energy_neutralizer'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_energy_neutralizer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_missile_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(0)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_missile_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(0)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_energy_vampire'), '|slot=i5',']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_shield_generator'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_core_battery'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i3',']',
']')
 as description,'Courier, Shield, LWF, Enwar, Tackle' as note
UNION ALL
SELECT 'gamma_Castel_Advanced' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_castel_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_castel_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_castel_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_castel_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_shield_hardener'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_webber'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_jammer'), '|slot=i4',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_rocket_launcher'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_rocket_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_missile_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_rocket_launcher'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_rocket_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_missile_launcher'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_missile_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_shield_generator'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i3',']',
']')
 as description,'Courier, Shield, LWF, Tackle, DPS, Ewar' as note
UNION ALL
SELECT 'gamma_Arbalest_Advanced' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_arbalest_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_arbalest_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_arbalest_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_arbalest_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_webber'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_armor_repairer_upgrade'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_armor_repairer_upgrade'), '|slot=i4',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_railgun'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_railgun_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_railgun'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_railgun_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_railgun'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_railgun'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_railgun_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_railgun'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m5=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_rocket_launcher'), '|slot=i6','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_rocket_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_plate'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_core_booster'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_corebooster_ammo'), '|ammoQuantity=i', (SELECT dbo.ToHex(10)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_repairer'), '|slot=i5',']',
']')
 as description,'Courier, DPS, Armor, Tackle' as note
UNION ALL
SELECT 'gamma_Cameleon_Advanced' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_cameleon_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_cameleon_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_cameleon_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_cameleon_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_webber'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_dampener'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_jammer'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_jammer'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i5',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_railgun'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_railgun_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(0)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_railgun'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_railgun_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(10)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_energy_vampire'), '|slot=i3',']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_shield_generator'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i3',']',
']')
 as description,'Courier, Shield, LWF, Enwar, Tackle' as note
UNION ALL
SELECT 'gamma_Yagel_Advanced' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_yagel_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_yagel_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_yagel_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_yagel_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_webber'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_armor_repairer_upgrade'), '|slot=i3',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_railgun'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_railgun_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_railgun'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_railgun'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_railgun_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_railgun'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(20)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_plate'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_core_booster'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_corebooster_ammo'), '|ammoQuantity=i', (SELECT dbo.ToHex(10)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_repairer'), '|slot=i5',']',
']')
 as description,'Courier, DPS, Armor, Tackle' as note
UNION ALL
SELECT 'gamma_Locust_Advanced' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_locust_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_locust_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_locust_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_locust_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_tracking_upgrade'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_webber'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_projectile'), '|slot=i4',']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_projectile'), '|slot=i5',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_autocannon'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_autocannon'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_autocannon'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_autocannon'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m4=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_autocannon'), '|slot=i5','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_plate'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_plate'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i4',']',
']')
 as description,'Courier, DPS, Armor' as note
UNION ALL
SELECT 'gamma_Helix_Advanced' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_helix_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_helix_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_helix_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_helix_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_webber'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_jammer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_webber'), '|slot=i4',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_energy_vampire'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_energy_vampire'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_energy_neutralizer'), '|slot=i3',']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_shield_generator'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_maneuvering_upgrade'), '|slot=i3',']',
']')
 as description,'Courier, Shield, LWF, EWAR, Tackle' as note
UNION ALL
SELECT 'gamma_Vektor_Advanced' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_vektor_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_vektor_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_vektor_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_vektor_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_webber'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_damage_mod_projectile'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_jammer'), '|slot=i4',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_autocannon'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_autocannon'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_autocannon'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_autocannon'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(50)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_armor_plate'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_repairer'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i3',']',
']')
 as description,'Courier, DPS, Armor' as note
UNION ALL
SELECT 'gamma_Sequer_Advanced' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_sequer_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_sequer_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_sequer_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_sequer_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_shield_hardener'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_shield_hardener'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_jammer'), '|slot=i4',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_rocket_launcher'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_rocket_rewb'), '|ammoQuantity=i', (SELECT dbo.ToHex(10)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_shield_generator'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_mass_reductor'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_core_battery'), '|slot=i3',']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_armor_plate'), '|slot=i4',']',
']')
 as description,'Courier, Hauler, Shield, EWAR' as note
UNION ALL
SELECT 'gamma_Ikarus_Advanced' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ikarus_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ikarus_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ikarus_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ikarus_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_webber'), '|slot=i1',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_energy_vampire'), '|slot=i1',']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_elitet4_71_small_shield_generator'), '|slot=i1',']',
']')
 as description,'Courier, Hauler, Tackle, Enwar' as note
UNION ALL
SELECT 'gamma_Hermes_Advanced' as name, CONCAT(
'#robot=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_hermes_bot'),
'#head=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_hermes_head'),
'#chassis=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_hermes_chassis'),
'#leg=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_hermes_leg'),
'#headModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_webber'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_elitet4_71_mining_probe_module'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_sensor_booster'), '|slot=i3',']',
']',
'#chassisModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_autocannon'), '|slot=i1','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(100)),']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_autocannon'), '|slot=i2','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(100)),']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_small_autocannon'), '|slot=i3','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(100)),']',
'|m3=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_named3_medium_autocannon'), '|slot=i4','|ammoDefinition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_ammo_medium_projectile_rewa'), '|ammoQuantity=i', (SELECT dbo.ToHex(100)),']',
']',
'#legModules=[',
'|m0=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_elitet4_71_small_shield_generator'), '|slot=i1',']',
'|m1=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_elitet4_72_mass_reductor'), '|slot=i2',']',
'|m2=[|definition=i', (SELECT TOP 1 dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_elitet4_72_small_armor_repairer'), '|slot=i3',']',
']')
 as description,'Courier, Explorer, Shield, DPS' as note
) test
;


-- AGGREGATE VALUES
DROP TABLE IF EXISTS #TMPAGGVALBYLVL;
CREATE TABLE #TMPAGGVALBYLVL(
	tiers [varchar](50) NOT NULL,
	name [varchar](200) NOT NULL,
	measure [nvarchar](2000) NULL,
	field [float] NULL	
);
INSERT INTO #TMPAGGVALBYLVL(tiers,name,measure) VALUES	
('lindy','armor_max_modifier',1.3),
('lindy','armor_repair_amount_modifier',NULL),
('lindy','armor_repair_cycle_time_modifier',NULL),
('lindy','core_max_modifier',3),
('lindy','core_recharge_time_modifier',1.5),
('lindy','cpu_max_modifier',2),
('lindy','shield_absorbtion_modifier',1.2),
('lindy','critical_hit_chance_modifier',NULL),
('lindy','damage_modifier',2),
('lindy','ecm_strength_modifier',0.7),
('lindy','energy_neutralized_amount_modifier',0.7),
('lindy','energy_vampired_amount_modifier',0.65),
('lindy','ew_optimal_range_modifier',0.9),
('lindy','falloff_modifier',1.2),
('lindy','locked_targets_max_bonus',NULL),
('lindy','locking_range_modifier',1),
('lindy','locking_time_modifier',1.2),
('lindy','missile_cycle_time_modifier',0.8),
('lindy','optimal_range_modifier',1.2),
('lindy','powergrid_max_modifier',2),
('lindy','resist_chemical',-10),
('lindy','resist_explosive',15),
('lindy','resist_kinetic',15),
('lindy','resist_thermal',15),
('lindy','sensor_strength_modifier',NULL),
('lindy','speed_max_modifier',1.25),
('lindy','turret_cycle_time_modifier',0.9),
('lindy','received_repaired_modifier',0.1),
('lindy','stealth_strength_modifier',NULL),
('lindy','detection_strength_modifier',NULL),
('lindy','missile_falloff_modifier',NULL),
('lindy','blob_emission_radius_modifier',0.4),
('lindy','blob_emission_modifier_modifier',1.5),
('lindy','reactor_radiation_modifier',1.2),
('lindy','massiveness',-0.1),
--
('L3','armor_max_modifier',1.3),
('L3','armor_repair_amount_modifier',NULL),
('L3','armor_repair_cycle_time_modifier',NULL),
('L3','core_max_modifier',1.5),
('L3','core_recharge_time_modifier',1.0),
('L3','cpu_max_modifier',2),
('L3','shield_absorbtion_modifier',0.9),
('L3','critical_hit_chance_modifier',NULL),
('L3','damage_modifier',1.2),
('L3','ecm_strength_modifier',0.7),
('L3','energy_neutralized_amount_modifier',0.7),
('L3','energy_vampired_amount_modifier',0.65),
('L3','ew_optimal_range_modifier',0.9),
('L3','falloff_modifier',1.2),
('L3','locked_targets_max_bonus',NULL),
('L3','locking_range_modifier',1.5),
('L3','locking_time_modifier',0.9),
('L3','missile_cycle_time_modifier',0.85),
('L3','optimal_range_modifier',1.2),
('L3','powergrid_max_modifier',2),
('L3','resist_chemical',NULL),
('L3','resist_explosive',NULL),
('L3','resist_kinetic',NULL),
('L3','resist_thermal',NULL),
('L3','sensor_strength_modifier',NULL),
('L3','signature_radius',-0.25),
('L3','speed_max_modifier',NULL),
('L3','turret_cycle_time_modifier',0.9),
('L3','received_repaired_modifier',0.1),
('L3','stealth_strength_modifier',-10),
('L3','detection_strength_modifier',25),
('L3','missile_falloff_modifier',NULL),
('L3','blob_emission_radius_modifier',0.4),
('L3','blob_emission_modifier_modifier',1.0),
('L3','reactor_radiation_modifier',NULL),
('L3','massiveness',NULL),
--
('L4','armor_max_modifier',1.5),
('L4','armor_repair_amount_modifier',NULL),
('L4','armor_repair_cycle_time_modifier',NULL),
('L4','core_max_modifier',1.5),
('L4','core_recharge_time_modifier',0.9),
('L4','cpu_max_modifier',2),
('L4','shield_absorbtion_modifier',0.95),
('L4','critical_hit_chance_modifier',NULL),
('L4','damage_modifier',1.3),
('L4','ecm_strength_modifier',0.9),
('L4','energy_neutralized_amount_modifier',0.9),
('L4','energy_vampired_amount_modifier',0.8),
('L4','ew_optimal_range_modifier',0.95),
('L4','falloff_modifier',1.25),
('L4','locked_targets_max_bonus',NULL),
('L4','locking_range_modifier',1.5),
('L4','locking_time_modifier',0.9),
('L4','missile_cycle_time_modifier',0.75),
('L4','optimal_range_modifier',1.3),
('L4','powergrid_max_modifier',2),
('L4','resist_chemical',NULL),
('L4','resist_explosive',NULL),
('L4','resist_kinetic',NULL),
('L4','resist_thermal',NULL),
('L4','sensor_strength_modifier',NULL),
('L4','signature_radius',-0.3),
('L4','speed_max_modifier',NULL),
('L4','turret_cycle_time_modifier',0.8),
('L4','received_repaired_modifier',0.1),
('L4','stealth_strength_modifier',-10),
('L4','detection_strength_modifier',25),
('L4','missile_falloff_modifier',NULL),
('L4','blob_emission_radius_modifier',0.4),
('L4','blob_emission_modifier_modifier',1.25),
('L4','reactor_radiation_modifier',NULL),
('L4','massiveness',NULL),
--
('L5','armor_max_modifier',1.7),
('L5','armor_repair_amount_modifier',NULL),
('L5','armor_repair_cycle_time_modifier',NULL),
('L5','core_max_modifier',1.7),
('L5','core_recharge_time_modifier',0.85),
('L5','cpu_max_modifier',2),
('L5','shield_absorbtion_modifier',1.0),
('L5','critical_hit_chance_modifier',NULL),
('L5','damage_modifier',1.5),
('L5','ecm_strength_modifier',1),
('L5','energy_neutralized_amount_modifier',1),
('L5','energy_vampired_amount_modifier',0.9),
('L5','ew_optimal_range_modifier',1),
('L5','falloff_modifier',1.3),
('L5','locked_targets_max_bonus',NULL),
('L5','locking_range_modifier',1.5),
('L5','locking_time_modifier',0.7),
('L5','missile_cycle_time_modifier',0.65),
('L5','optimal_range_modifier',1.3),
('L5','powergrid_max_modifier',2),
('L5','resist_chemical',NULL),
('L5','resist_explosive',NULL),
('L5','resist_kinetic',NULL),
('L5','resist_thermal',NULL),
('L5','sensor_strength_modifier',NULL),
('L5','signature_radius',-0.4),
('L5','speed_max_modifier',NULL),
('L5','turret_cycle_time_modifier',0.7),
('L5','received_repaired_modifier',0.1),
('L5','stealth_strength_modifier',-10),
('L5','detection_strength_modifier',25),
('L5','missile_falloff_modifier',NULL),
('L5','blob_emission_radius_modifier',0.4),
('L5','blob_emission_modifier_modifier',1.5),
('L5','reactor_radiation_modifier',NULL),
('L5','massiveness',NULL),
--
('L6','armor_max_modifier',1.8),
('L6','armor_repair_amount_modifier',NULL),
('L6','armor_repair_cycle_time_modifier',NULL),
('L6','core_max_modifier',1.85),
('L6','core_recharge_time_modifier',0.85),
('L6','cpu_max_modifier',2),
('L6','shield_absorbtion_modifier',1.05),
('L6','critical_hit_chance_modifier',NULL),
('L6','damage_modifier',1.5),
('L6','ecm_strength_modifier',1.1),
('L6','energy_neutralized_amount_modifier',1.1),
('L6','energy_vampired_amount_modifier',1.0),
('L6','ew_optimal_range_modifier',1.25),
('L6','falloff_modifier',1.4),
('L6','locked_targets_max_bonus',NULL),
('L6','locking_range_modifier',1.75),
('L6','locking_time_modifier',0.7),
('L6','missile_cycle_time_modifier',0.65),
('L6','optimal_range_modifier',1.3),
('L6','powergrid_max_modifier',2),
('L6','resist_chemical',NULL),
('L6','resist_explosive',NULL),
('L6','resist_kinetic',NULL),
('L6','resist_thermal',NULL),
('L6','sensor_strength_modifier',NULL),
('L6','signature_radius',-0.45),
('L6','speed_max_modifier',NULL),
('L6','turret_cycle_time_modifier',0.7),
('L6','received_repaired_modifier',0.1),
('L6','stealth_strength_modifier',-10),
('L6','detection_strength_modifier',25),
('L6','missile_falloff_modifier',NULL),
('L6','blob_emission_radius_modifier',0.3),
('L6','blob_emission_modifier_modifier',2),
('L6','reactor_radiation_modifier',NULL),
('L6','massiveness',NULL),
--
('L7','accuracy_modifier',0.9),
('L7','explosion_radius_modifier',0.9),
('L7','armor_max_modifier',1.95),
('L7','armor_repair_amount_modifier',NULL),
('L7','armor_repair_cycle_time_modifier',NULL),
('L7','core_max_modifier',2.5),
('L7','core_recharge_time_modifier',0.9),
('L7','cpu_max_modifier',2),
('L7','shield_absorbtion_modifier',1.1),
('L7','critical_hit_chance_modifier',NULL),
('L7','damage_modifier',1.5),
('L7','ecm_strength_modifier',1.2),
('L7','energy_neutralized_amount_modifier',1.2),
('L7','energy_vampired_amount_modifier',1.1),
('L7','ew_optimal_range_modifier',1.5),
('L7','falloff_modifier',1.5),
('L7','locked_targets_max_bonus',NULL),
('L7','locking_range_modifier',1.75),
('L7','locking_time_modifier',0.7),
('L7','missile_cycle_time_modifier',0.65),
('L7','optimal_range_modifier',2),
('L7','powergrid_max_modifier',2),
('L7','resist_chemical',10),
('L7','resist_explosive',10),
('L7','resist_kinetic',10),
('L7','resist_thermal',10),
('L7','sensor_strength_modifier',-20),
('L7','signature_radius',-0.5),
('L7','speed_max_modifier',NULL),
('L7','turret_cycle_time_modifier',0.7),
('L7','received_repaired_modifier',0.1),
('L7','stealth_strength_modifier',-10),
('L7','detection_strength_modifier',25),
('L7','missile_falloff_modifier',NULL),
('L7','blob_emission_radius_modifier',0.3),
('L7','blob_emission_modifier_modifier',2.5),
('L7','reactor_radiation_modifier',NULL),
('L7','massiveness',NULL),
--
('destro','accuracy_modifier',1.0),
('destro','explosion_radius_modifier',1.0),
('destro','armor_max_modifier',1.7),
('destro','armor_repair_amount_modifier',1),
('destro','armor_repair_cycle_time_modifier',NULL),
('destro','core_max_modifier',2),
('destro','core_recharge_time_modifier',0.7),
('destro','cpu_max_modifier',2),
('destro','shield_absorbtion_modifier',1.0),
('destro','critical_hit_chance_modifier',NULL),
('destro','damage_modifier',1.5),
('destro','ecm_strength_modifier',NULL),
('destro','energy_neutralized_amount_modifier',NULL),
('destro','ew_optimal_range_modifier',NULL),
('destro','falloff_modifier',1.3),
('destro','locked_targets_max_bonus',3),
('destro','locking_range_modifier',2),
('destro','locking_time_modifier',1),
('destro','missile_cycle_time_modifier',0.65),
('destro','optimal_range_modifier',2),
('destro','powergrid_max_modifier',2),
('destro','resist_chemical',35),
('destro','resist_explosive',35),
('destro','resist_kinetic',35),
('destro','resist_thermal',35),
('destro','sensor_strength_modifier',75),
('destro','speed_max_modifier',0.9),
('destro','turret_cycle_time_modifier',0.7),
('destro','received_repaired_modifier',0.1),
('destro','stealth_strength_modifier',NULL),
('destro','detection_strength_modifier',50),
('destro','missile_falloff_modifier',NULL),
('destro','blob_emission_radius_modifier',0.3),
('destro','blob_emission_modifier_modifier',2),
('destro','reactor_radiation_modifier',0.65),
('destro','massiveness',NULL),
--
('observer','accuracy_modifier',0.9),
('observer','explosion_radius_modifier',0.9),
('observer','armor_max_modifier',2),
('observer','armor_repair_amount_modifier',1.25),
('observer','armor_repair_cycle_time_modifier',0.8),
('observer','core_max_modifier',3),
('observer','core_recharge_time_modifier',0.9),
('observer','cpu_max_modifier',2.5),
('observer','shield_absorbtion_modifier',1.3),
('observer','critical_hit_chance_modifier',0.2),
('observer','damage_modifier',3),
('observer','ecm_strength_modifier',1.3),
('observer','energy_neutralized_amount_modifier',1.3),
('observer','energy_vampired_amount_modifier',1.1),
('observer','ew_optimal_range_modifier',1.5),
('observer','falloff_modifier',1.7),
('observer','locked_targets_max_bonus',NULL),
('observer','locking_range_modifier',2.5),
('observer','locking_time_modifier',0.5),
('observer','missile_cycle_time_modifier',0.6),
('observer','optimal_range_modifier',2),
('observer','powergrid_max_modifier',3),
('observer','resist_chemical',50),
('observer','resist_explosive',50),
('observer','resist_kinetic',50),
('observer','resist_thermal',50),
('observer','sensor_strength_modifier',50),
('observer','speed_max_modifier',NULL),
('observer','turret_cycle_time_modifier',0.7),
('observer','received_repaired_modifier',0.1),
('observer','stealth_strength_modifier',-10),
('observer','detection_strength_modifier',NULL),
('observer','missile_falloff_modifier',NULL),
('observer','blob_emission_radius_modifier',0.2),
('observer','blob_emission_modifier_modifier',2.5),
('observer','reactor_radiation_modifier',NULL),
('observer','massiveness',NULL),
--
('miniboss','accuracy_modifier',1.2),
('miniboss','explosion_radius_modifier',1.2),
('miniboss','armor_max_modifier',5),
('miniboss','armor_repair_amount_modifier',2.55),
('miniboss','armor_repair_cycle_time_modifier',0.67),
('miniboss','core_max_modifier',4.25),
('miniboss','core_recharge_time_modifier',0.65),
('miniboss','cpu_max_modifier',3),
('miniboss','shield_absorbtion_modifier',1.5),
('miniboss','critical_hit_chance_modifier',0.1),
('miniboss','damage_modifier',4.5),
('miniboss','ecm_strength_modifier',2.5),
('miniboss','energy_neutralized_amount_modifier',1.5),
('miniboss','energy_vampired_amount_modifier',1.1),
('miniboss','ew_optimal_range_modifier',1.5),
('miniboss','falloff_modifier',5.5),
('miniboss','locked_targets_max_bonus',25),
('miniboss','locked_targets_max',25),
('miniboss','locking_range_modifier',4.5),
('miniboss','locking_time_modifier',0.8),
('miniboss','missile_cycle_time_modifier',0.9),
('miniboss','optimal_range_modifier',4.5),
('miniboss','powergrid_max_modifier',3.5),
('miniboss','resist_chemical',350),
('miniboss','resist_explosive',350),
('miniboss','resist_kinetic',350),
('miniboss','resist_thermal',350),
('miniboss','sensor_strength_modifier',200),
('miniboss','speed_max_modifier',1.25),
('miniboss','turret_cycle_time_modifier',1),
('miniboss','received_repaired_modifier',1.25),
('miniboss','stealth_strength_modifier',-20),
('miniboss','detection_strength_modifier',50),
('miniboss','missile_falloff_modifier',5.5),
('miniboss','blob_emission_radius_modifier',0.3),
('miniboss','blob_emission_modifier_modifier',3),
('miniboss','reactor_radiation_modifier',0.65),
('miniboss','massiveness',NULL),

('pitboss','accuracy_modifier',1.0),
('pitboss','explosion_radius_modifier',1.0),
('pitboss','armor_max_modifier',7.5),
('pitboss','armor_repair_amount_modifier',2.55),
('pitboss','armor_repair_cycle_time_modifier',0.67),
('pitboss','core_max_modifier',6.5),
('pitboss','core_recharge_time_modifier',0.65),
('pitboss','cpu_max_modifier',2.5),
('pitboss','shield_absorbtion_modifier',3),
('pitboss','critical_hit_chance_modifier',0.2),
('pitboss','damage_modifier',5.5),
('pitboss','ecm_strength_modifier',3),
('pitboss','energy_neutralized_amount_modifier',2),
('pitboss','energy_vampired_amount_modifier',1.5),
('pitboss','ew_optimal_range_modifier',3),
('pitboss','falloff_modifier',5.5),
('pitboss','locked_targets_max_bonus',25),
('pitboss','locked_targets_max',25),
('pitboss','locking_range_modifier',4.5),
('pitboss','locking_time_modifier',1.0),
('pitboss','missile_cycle_time_modifier',0.45),
('pitboss','optimal_range_modifier',4.5),
('pitboss','powergrid_max_modifier',4),
('pitboss','resist_chemical',500),
('pitboss','resist_explosive',500),
('pitboss','resist_kinetic',500),
('pitboss','resist_thermal',500),
('pitboss','sensor_strength_modifier',300),
('pitboss','speed_max_modifier',1.75),
('pitboss','turret_cycle_time_modifier',0.7),
('pitboss','received_repaired_modifier',10),
('pitboss','stealth_strength_modifier',-10),
('pitboss','detection_strength_modifier',40),
('pitboss','missile_falloff_modifier',2.5),
('pitboss','blob_emission_radius_modifier',0.3),
('pitboss','blob_emission_modifier_modifier',4),
('pitboss','reactor_radiation_modifier',0.5),
('pitboss','massiveness',NULL),
--
('courier','accuracy_modifier',1.3),
('courier','explosion_radius_modifier',1.3),
('courier','armor_max_modifier',1.3),
('courier','armor_repair_amount_modifier',1.3),
('courier','armor_repair_cycle_time_modifier',0.67),
('courier','core_max_modifier',3),
('courier','core_recharge_time_modifier',1.0),
('courier','cpu_max_modifier',2),
('courier','shield_absorbtion_modifier',1.4),
('courier','critical_hit_chance_modifier',0.1),
('courier','damage_modifier',2),
('courier','ecm_strength_modifier',1.5),
('courier','energy_neutralized_amount_modifier',1.5),
('courier','ew_optimal_range_modifier',1.5),
('courier','falloff_modifier',1.5),
('courier','locked_targets_max_bonus',NULL),
('courier','locking_range_modifier',2),
('courier','locking_time_modifier',0.6),
('courier','missile_cycle_time_modifier',0.45),
('courier','optimal_range_modifier',1.5),
('courier','powergrid_max_modifier',2),
('courier','resist_chemical',50),
('courier','resist_explosive',50),
('courier','resist_kinetic',50),
('courier','resist_thermal',50),
('courier','sensor_strength_modifier',50),
('courier','signature_radius',-0.5),
('courier','speed_max_modifier',1.3),
('courier','turret_cycle_time_modifier',0.6),
('courier','received_repaired_modifier',0.1),
('courier','stealth_strength_modifier',20),
('courier','detection_strength_modifier',30),
('courier','missile_falloff_modifier',NULL),
('courier','blob_emission_radius_modifier',0.3),
('courier','blob_emission_modifier_modifier',2.5),
('courier','reactor_radiation_modifier',0.75),
('courier','massiveness',NULL),
--
('syn_pitboss','accuracy_modifier',3.0),
('syn_pitboss','explosion_radius_modifier',3.0),
('syn_pitboss','armor_max_modifier',7.5),
('syn_pitboss','armor_repair_amount_modifier',3.5),
('syn_pitboss','armor_repair_cycle_time_modifier',0.75),
('syn_pitboss','core_max_modifier',5.25),
('syn_pitboss','core_recharge_time_modifier',0.65),
('syn_pitboss','cpu_max_modifier',2.5),
('syn_pitboss','shield_absorbtion_modifier',2),
('syn_pitboss','critical_hit_chance_modifier',0.2),
('syn_pitboss','damage_modifier',13.0),
('syn_pitboss','ecm_strength_modifier',3),
('syn_pitboss','energy_neutralized_amount_modifier',2),
('syn_pitboss','ew_optimal_range_modifier',3),
('syn_pitboss','falloff_modifier',5.5),
('syn_pitboss','locked_targets_max_bonus',25),
('syn_pitboss','locked_targets_max',25),
('syn_pitboss','locking_range_modifier',6),
('syn_pitboss','locking_time_modifier',1.35),
('syn_pitboss','missile_cycle_time_modifier',0.65),
('syn_pitboss','optimal_range_modifier',5),
('syn_pitboss','powergrid_max_modifier',6),
('syn_pitboss','resist_chemical',515),
('syn_pitboss','resist_explosive',500),
('syn_pitboss','resist_kinetic',395),
('syn_pitboss','resist_thermal',535),
('syn_pitboss','sensor_strength_modifier',200),
('syn_pitboss','speed_max_modifier',1.75),
('syn_pitboss','turret_cycle_time_modifier',0.7),
('syn_pitboss','received_repaired_modifier',10),
('syn_pitboss','stealth_strength_modifier',-20),
('syn_pitboss','detection_strength_modifier',30),
('syn_pitboss','missile_falloff_modifier',2.5),
('syn_pitboss','blob_emission_radius_modifier',0.3),
('syn_pitboss','blob_emission_modifier_modifier',4),
('syn_pitboss','reactor_radiation_modifier',1.2),
('syn_pitboss','massiveness',NULL)
-- get field id from AGGREGATEFIELDS
UPDATE t
SET field = (SELECT top 1 id FROM dbo.aggregatefields r WHERE r.name = t.name)
FROM #TMPAGGVALBYLVL t;


-- LIST OF LEVELS
DROP TABLE IF EXISTS #BOT_TEMPLATE_AND_TIERS;
CREATE TABLE #BOT_TEMPLATE_AND_TIERS(
	templateName varchar(128),
	tierName varchar(128)
);
INSERT INTO #BOT_TEMPLATE_AND_TIERS (templateName, tierName) VALUES
('gamma_sequer_basic', 'lindy'),
('gamma_lithus_basic', 'lindy'),
('gamma_scarab_basic', 'lindy'),
('gamma_riveler_basic', 'lindy'),
('gamma_symbiont_basic', 'lindy'),
('gamma_daidalos_basic', 'lindy'),
('gamma_ikarus_basic', 'lindy'),
('gamma_cronus_basic', 'lindy'),
('gamma_hermes_basic', 'lindy'),
('gamma_termis_basic', 'lindy'),
('gamma_gargoyle_basic', 'lindy'),
('gamma_argano_basic', 'lindy'),
('gamma_laird_basic', 'lindy'),

('gamma_seth_dps', 'L3'),
('gamma_seth_tank', 'L3'),
('gamma_artemis_dps', 'L3'),
('gamma_artemis_tank', 'L3'),
('gamma_baphomet_dps', 'L3'),
('gamma_baphomet_speed', 'L3'),
('gamma_prometheus_dps', 'L3'),
('gamma_prometheus_speed', 'L3'),
('gamma_zenith_shield', 'L3'),
('gamma_zenith_armor', 'L3'),
('gamma_intakt_shield', 'L3'),
('gamma_intakt_armor', 'L3'),
('gamma_gropho_dps', 'L3'),
('gamma_gropho_tank', 'L3'),
('gamma_tyrannos_dps', 'L3'),
('gamma_tyrannos_tank', 'L3'),
('gamma_waspish_dps', 'L3'),
('gamma_waspish_speed', 'L3'),
('gamma_castel_dps', 'L3'),
('gamma_castel_speed', 'L3'),
('gamma_ictus_shield', 'L3'),
('gamma_ictus_armor', 'L3'),
('gamma_troiar_shield', 'L3'),
('gamma_troiar_armor', 'L3'),
('gamma_mesmer_dps', 'L3'),
('gamma_mesmer_tank', 'L3'),
('gamma_kain_dps', 'L3'),
('gamma_kain_tank', 'L3'),
('gamma_arbalest_dps', 'L3'),
('gamma_arbalest_speed', 'L3'),
('gamma_yagel_dps', 'L3'),
('gamma_yagel_speed', 'L3'),
('gamma_vagabond_shield', 'L3'),
('gamma_vagabond_armor', 'L3'),
('gamma_cameleon_shield', 'L3'),
('gamma_cameleon_armor', 'L3'),
('gamma_legatus_dps', 'L3'),
('gamma_legatus_tank', 'L3'),
('gamma_echelon_dps', 'L3'),
('gamma_echelon_tank', 'L3'),
('gamma_locust_dps', 'L3'),
('gamma_locust_speed', 'L3'),
('gamma_vektor_dps', 'L3'),
('gamma_vektor_speed', 'L3'),
('gamma_callisto_shield', 'L3'),
('gamma_callisto_armor', 'L3'),
('gamma_helix_shield', 'L3'),
('gamma_helix_armor', 'L3'),

('gamma_seth_dps', 'L4'),
('gamma_seth_tank', 'L4'),
('gamma_artemis_dps', 'L4'),
('gamma_artemis_tank', 'L4'),
('gamma_baphomet_dps', 'L4'),
('gamma_baphomet_speed', 'L4'),
('gamma_prometheus_dps', 'L4'),
('gamma_prometheus_speed', 'L4'),
('gamma_zenith_shield', 'L4'),
('gamma_zenith_armor', 'L4'),
('gamma_intakt_shield', 'L4'),
('gamma_intakt_armor', 'L4'),
('gamma_gropho_dps', 'L4'),
('gamma_gropho_tank', 'L4'),
('gamma_tyrannos_dps', 'L4'),
('gamma_tyrannos_tank', 'L4'),
('gamma_waspish_dps', 'L4'),
('gamma_waspish_speed', 'L4'),
('gamma_castel_dps', 'L4'),
('gamma_castel_speed', 'L4'),
('gamma_ictus_shield', 'L4'),
('gamma_ictus_armor', 'L4'),
('gamma_troiar_shield', 'L4'),
('gamma_troiar_armor', 'L4'),
('gamma_mesmer_dps', 'L4'),
('gamma_mesmer_tank', 'L4'),
('gamma_kain_dps', 'L4'),
('gamma_kain_tank', 'L4'),
('gamma_arbalest_dps', 'L4'),
('gamma_arbalest_speed', 'L4'),
('gamma_yagel_dps', 'L4'),
('gamma_yagel_speed', 'L4'),
('gamma_vagabond_shield', 'L4'),
('gamma_vagabond_armor', 'L4'),
('gamma_cameleon_shield', 'L4'),
('gamma_cameleon_armor', 'L4'),
('gamma_legatus_dps', 'L4'),
('gamma_legatus_tank', 'L4'),
('gamma_echelon_dps', 'L4'),
('gamma_echelon_tank', 'L4'),
('gamma_locust_dps', 'L4'),
('gamma_locust_speed', 'L4'),
('gamma_vektor_dps', 'L4'),
('gamma_vektor_speed', 'L4'),
('gamma_callisto_shield', 'L4'),
('gamma_callisto_armor', 'L4'),
('gamma_helix_shield', 'L4'),
('gamma_helix_armor', 'L4'),

('gamma_seth_dps', 'L5'),
('gamma_seth_tank', 'L5'),
('gamma_artemis_dps', 'L5'),
('gamma_artemis_tank', 'L5'),
('gamma_baphomet_dps', 'L5'),
('gamma_baphomet_speed', 'L5'),
('gamma_prometheus_dps', 'L5'),
('gamma_prometheus_speed', 'L5'),
('gamma_zenith_shield', 'L5'),
('gamma_zenith_armor', 'L5'),
('gamma_intakt_shield', 'L5'),
('gamma_intakt_armor', 'L5'),
('gamma_gropho_dps', 'L5'),
('gamma_gropho_tank', 'L5'),
('gamma_tyrannos_dps', 'L5'),
('gamma_tyrannos_tank', 'L5'),
('gamma_waspish_dps', 'L5'),
('gamma_waspish_speed', 'L5'),
('gamma_castel_dps', 'L5'),
('gamma_castel_speed', 'L5'),
('gamma_ictus_shield', 'L5'),
('gamma_ictus_armor', 'L5'),
('gamma_troiar_shield', 'L5'),
('gamma_troiar_armor', 'L5'),
('gamma_mesmer_dps', 'L5'),
('gamma_mesmer_tank', 'L5'),
('gamma_kain_dps', 'L5'),
('gamma_kain_tank', 'L5'),
('gamma_arbalest_dps', 'L5'),
('gamma_arbalest_speed', 'L5'),
('gamma_yagel_dps', 'L5'),
('gamma_yagel_speed', 'L5'),
('gamma_vagabond_shield', 'L5'),
('gamma_vagabond_armor', 'L5'),
('gamma_cameleon_shield', 'L5'),
('gamma_cameleon_armor', 'L5'),
('gamma_legatus_dps', 'L5'),
('gamma_legatus_tank', 'L5'),
('gamma_echelon_dps', 'L5'),
('gamma_echelon_tank', 'L5'),
('gamma_locust_dps', 'L5'),
('gamma_locust_speed', 'L5'),
('gamma_vektor_dps', 'L5'),
('gamma_vektor_speed', 'L5'),
('gamma_callisto_shield', 'L5'),
('gamma_callisto_armor', 'L5'),
('gamma_helix_shield', 'L5'),
('gamma_helix_armor', 'L5'),

('gamma_seth_dps', 'L6'),
('gamma_seth_tank', 'L6'),
('gamma_artemis_dps', 'L6'),
('gamma_artemis_tank', 'L6'),
('gamma_baphomet_dps', 'L6'),
('gamma_baphomet_speed', 'L6'),
('gamma_prometheus_dps', 'L6'),
('gamma_prometheus_speed', 'L6'),
('gamma_zenith_shield', 'L6'),
('gamma_zenith_armor', 'L6'),
('gamma_intakt_shield', 'L6'),
('gamma_intakt_armor', 'L6'),
('gamma_gropho_dps', 'L6'),
('gamma_gropho_tank', 'L6'),
('gamma_tyrannos_dps', 'L6'),
('gamma_tyrannos_tank', 'L6'),
('gamma_waspish_dps', 'L6'),
('gamma_waspish_speed', 'L6'),
('gamma_castel_dps', 'L6'),
('gamma_castel_speed', 'L6'),
('gamma_ictus_shield', 'L6'),
('gamma_ictus_armor', 'L6'),
('gamma_troiar_shield', 'L6'),
('gamma_troiar_armor', 'L6'),
('gamma_mesmer_dps', 'L6'),
('gamma_mesmer_tank', 'L6'),
('gamma_kain_dps', 'L6'),
('gamma_kain_tank', 'L6'),
('gamma_arbalest_dps', 'L6'),
('gamma_arbalest_speed', 'L6'),
('gamma_yagel_dps', 'L6'),
('gamma_yagel_speed', 'L6'),
('gamma_vagabond_shield', 'L6'),
('gamma_vagabond_armor', 'L6'),
('gamma_cameleon_shield', 'L6'),
('gamma_cameleon_armor', 'L6'),
('gamma_legatus_dps', 'L6'),
('gamma_legatus_tank', 'L6'),
('gamma_echelon_dps', 'L6'),
('gamma_echelon_tank', 'L6'),
('gamma_locust_dps', 'L6'),
('gamma_locust_speed', 'L6'),
('gamma_vektor_dps', 'L6'),
('gamma_vektor_speed', 'L6'),
('gamma_callisto_shield', 'L6'),
('gamma_callisto_armor', 'L6'),
('gamma_helix_shield', 'L6'),
('gamma_helix_armor', 'L6'),

('gamma_seth_dps', 'L7'),
('gamma_seth_tank', 'L7'),
('gamma_artemis_dps', 'L7'),
('gamma_artemis_tank', 'L7'),
('gamma_baphomet_dps', 'L7'),
('gamma_baphomet_speed', 'L7'),
('gamma_prometheus_dps', 'L7'),
('gamma_prometheus_speed', 'L7'),
('gamma_zenith_shield', 'L7'),
('gamma_zenith_armor', 'L7'),
('gamma_intakt_shield', 'L7'),
('gamma_intakt_armor', 'L7'),
('gamma_gropho_dps', 'L7'),
('gamma_gropho_tank', 'L7'),
('gamma_tyrannos_dps', 'L7'),
('gamma_tyrannos_tank', 'L7'),
('gamma_waspish_dps', 'L7'),
('gamma_waspish_speed', 'L7'),
('gamma_castel_dps', 'L7'),
('gamma_castel_speed', 'L7'),
('gamma_ictus_shield', 'L7'),
('gamma_ictus_armor', 'L7'),
('gamma_troiar_shield', 'L7'),
('gamma_troiar_armor', 'L7'),
('gamma_mesmer_dps', 'L7'),
('gamma_mesmer_tank', 'L7'),
('gamma_kain_dps', 'L7'),
('gamma_kain_tank', 'L7'),
('gamma_arbalest_dps', 'L7'),
('gamma_arbalest_speed', 'L7'),
('gamma_yagel_dps', 'L7'),
('gamma_yagel_speed', 'L7'),
('gamma_vagabond_shield', 'L7'),
('gamma_vagabond_armor', 'L7'),
('gamma_cameleon_shield', 'L7'),
('gamma_cameleon_armor', 'L7'),
('gamma_legatus_dps', 'L7'),
('gamma_legatus_tank', 'L7'),
('gamma_echelon_dps', 'L7'),
('gamma_echelon_tank', 'L7'),
('gamma_locust_dps', 'L7'),
('gamma_locust_speed', 'L7'),
('gamma_vektor_dps', 'L7'),
('gamma_vektor_speed', 'L7'),
('gamma_callisto_shield', 'L7'),
('gamma_callisto_armor', 'L7'),
('gamma_helix_shield', 'L7'),
('gamma_helix_armor', 'L7'),

('gamma_onyx_mammoth', 'destro'),
('gamma_hydra_mammoth', 'destro'),
('gamma_felos_mammoth', 'destro'),

('gamma_seth_advanced', 'observer'),
('gamma_artemis_advanced', 'observer'),
('gamma_zenith_advanced', 'observer'),
('gamma_gropho_advanced', 'observer'),
('gamma_tyrannos_advanced', 'observer'),
('gamma_ictus_advanced', 'observer'),
('gamma_mesmer_advanced', 'observer'),
('gamma_kain_advanced', 'observer'),
('gamma_vagabond_advanced', 'observer'),
('gamma_legatus_advanced', 'observer'),
('gamma_echelon_advanced', 'observer'),
('gamma_callisto_advanced', 'observer'),

('gamma_seth_advanced', 'miniboss'),
('gamma_artemis_advanced', 'miniboss'),
('gamma_zenith_advanced', 'miniboss'),
('gamma_gropho_advanced', 'miniboss'),
('gamma_tyrannos_advanced', 'miniboss'),
('gamma_ictus_advanced', 'miniboss'),
('gamma_mesmer_advanced', 'miniboss'),
('gamma_kain_advanced', 'miniboss'),
('gamma_vagabond_advanced', 'miniboss'),
('gamma_legatus_advanced', 'miniboss'),
('gamma_echelon_advanced', 'miniboss'),
('gamma_callisto_advanced', 'miniboss'),

('gamma_seth_boss', 'miniboss'),
('gamma_gropho_boss', 'miniboss'),
('gamma_mesmer_boss', 'miniboss'),
('gamma_legatus_boss', 'miniboss'),

('gamma_onyx_thelodica', 'pitboss'),
('gamma_hydra_pelistal', 'pitboss'),
('gamma_felos_nuimqol', 'pitboss'),
('gamma_apollo_syndicate', 'syn_pitboss'),

('gamma_baphomet_advanced', 'courier'),
('gamma_intakt_advanced', 'courier'),
('gamma_prometheus_advanced', 'courier'),
('gamma_waspish_advanced', 'courier'),
('gamma_troiar_advanced', 'courier'),
('gamma_castel_advanced', 'courier'),
('gamma_arbalest_advanced', 'courier'),
('gamma_cameleon_advanced', 'courier'),
('gamma_yagel_advanced', 'courier'),
('gamma_locust_advanced', 'courier'),
('gamma_helix_advanced', 'courier'),
('gamma_vektor_advanced', 'courier'),
('gamma_sequer_advanced', 'courier'),
('gamma_ikarus_advanced', 'courier'),
('gamma_hermes_advanced', 'courier')
;



-- ENTITY DEFAULTS
DROP TABLE IF EXISTS #TMPENTITYDEF;
CREATE TABLE #TMPENTITYDEF(	
	[definition] [int] NULL,
	[definitionname] [varchar](100) NOT NULL,
	[quantity] [int] NOT NULL,
	[attributeflags] [bigint] NOT NULL,
	[categoryflags] [bigint] NOT NULL,
	[options] [varchar](max) NULL,
	[note] [nvarchar](2048) NULL,
	[enabled] [bit] NOT NULL,
	[volume] [float] NULL,
	[mass] [float] NULL,
	[hidden] [bit] NOT NULL,
	[health] [float] NOT NULL,
	[descriptiontoken] [nvarchar](100) NULL,
	[purchasable] [bit] NOT NULL,
	[tiertype] [int] NULL,
	[tierlevel] [int] NULL
);
INSERT INTO #TMPENTITYDEF (definition, definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable)
SELECT 
	definition=8000+ROW_NUMBER() OVER(order by LOWER(CONCAT('def_npc_', bot.name, '_', tier.tierName))),
	LOWER(CONCAT('def_npc_', bot.name, '_', tier.tierName)) as definitionname,
	1 as quantity,
	1024 as attributeflags,
	911 as categoryflags,  --todo: put the good bot category based on raceid
	'' as options,
	bot.note as note,
	1 as enabled,
	0 as volume,
	0 as mass,
	0 as hidden,
	100 as health,
	LOWER(CONCAT('def_npc_', bot.name, '_', tier.tierName, '_desc')) as descriptiontoken,
	0 as purchasable
	FROM #TMPBOTTEMPLATE bot
inner join #BOT_TEMPLATE_AND_TIERS tier ON tier.templateName=bot.name;


PRINT N'DELETE/REINSERT ALL ENTITYDEFAULTS BY NAME AND AGGVALUES, ROBOTTEMPLATES, RELATIONS, NPCLOOT, FLOCK, PRESENCE -- WHERE APPLICABLE (0 ON FIRST RUN)';
DECLARE @DEFS TABLE (definition INT);
INSERT INTO @DEFS SELECT definition FROM dbo.entitydefaults WHERE definitionname IN (SELECT DISTINCT(definitionname) FROM #TMPENTITYDEF);

DECLARE @PRES_TO_DEL TABLE (presId INT);
INSERT INTO @PRES_TO_DEL SELECT DISTINCT presenceid FROM npcflock WHERE definition IN (SELECT definition FROM @DEFS);

DELETE FROM npcflock WHERE definition IN (SELECT definition FROM @DEFS) OR presenceid IN (SELECT presId FROM @PRES_TO_DEL);
DELETE FROM npcpresence WHERE id IN (SELECT presId FROM @PRES_TO_DEL);
DELETE FROM npcflock WHERE definition IN (SELECT definition FROM @DEFS);
DELETE FROM npcloot WHERE definition IN (SELECT definition FROM @DEFS);
DELETE FROM dbo.robottemplaterelation WHERE templateid IN (SELECT id FROM dbo.robottemplates WHERE name IN (SELECT name FROM #TMPBOTTEMPLATE));
DELETE FROM dbo.robottemplates WHERE name IN (SELECT name FROM #TMPBOTTEMPLATE);
DELETE FROM dbo.aggregatevalues WHERE definition in (SELECT definition FROM dbo.entitydefaults WHERE definitionname IN (SELECT DISTINCT(definitionname) FROM #TMPENTITYDEF));
DELETE FROM dbo.entitydefaults WHERE definitionname IN (SELECT DISTINCT(definitionname) FROM #TMPENTITYDEF);

PRINT N'UPSERT [entitydefaults]';
SET IDENTITY_INSERT entitydefaults ON;
MERGE [dbo].[entitydefaults] d USING #TMPENTITYDEF p
ON d.definition = p.definition
WHEN MATCHED
    THEN UPDATE SET
		definitionname=p.definitionname,
		categoryflags=p.categoryflags,
		attributeflags=p.attributeflags,
		volume=p.volume,
		mass=p.mass,
		tiertype=p.tiertype,
		tierlevel=p.tierlevel,
		options=p.options,
		enabled=p.enabled,
		hidden=p.hidden,
		purchasable=p.purchasable,
		descriptiontoken=p.descriptiontoken
WHEN NOT MATCHED
    THEN INSERT
	([definition], [definitionname],[quantity],[attributeflags],[categoryflags],[options],[note],
	[enabled],[volume],[mass],[hidden],[health],[descriptiontoken],[purchasable],[tiertype],[tierlevel])
	VALUES
	(p.definition, p.definitionname, p.quantity, p.attributeflags, p.categoryflags, p.options, p.note,
	p.enabled, p.volume, p.mass, p.hidden, p.health, p.descriptiontoken, p.purchasable, p.tiertype, p.tierlevel);
SET IDENTITY_INSERT entitydefaults OFF;



-- insert definition-field-value in AGGREGATEVALUES

INSERT INTO dbo.aggregatevalues (definition,field,value)
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=LOWER(CONCAT('def_npc_', bot.name, '_', t.tierName))) as definition,
	--LOWER(CONCAT('def_npc_', bot.name, '_', t.tierName)) as definitionname,
	v.field,
	--v.name,
	v.measure
FROM #TMPBOTTEMPLATE bot
inner join #BOT_TEMPLATE_AND_TIERS t ON t.templateName=bot.name
inner join #TMPAGGVALBYLVL v ON v.tiers=t.tierName AND v.measure IS NOT NULL
;



INSERT INTO dbo.robottemplates(name, description, note)
SELECT name, description, note
FROM #TMPBOTTEMPLATE;


INSERT INTO dbo.robottemplaterelation (definition,templateid,itemscoresum,raceid,missionlevel,missionleveloverride,killep,note)
 SELECT 
	e.definition,
	temp.id as templateid,
	0 as itemscoresum,
	0 as raceid,
	NULL as missionlevel,
	NULL as missionleveloverride,
	1 as killep,
	CONCAT('gamma template relation ',e.definitionname,':',temp.name) as note
FROM dbo.robottemplates temp
INNER JOIN #TMPBOTTEMPLATE t ON t.name = temp.name
INNER JOIN dbo.entitydefaults e ON e.definitionname like  CONCAT('def_npc_', temp.name,'%')
;


DROP TABLE IF EXISTS #TMPENTITYDEF;
DROP TABLE IF EXISTS #TMPENTITYID;
DROP TABLE IF EXISTS #TMPBOTTEMPLATE;
DROP TABLE IF EXISTS #TMPAGGVALBYLVL;
DROP TABLE IF EXISTS #BOT_TEMPLATE_AND_TIERS;
GO




PRINT N'31_npc_pres_flocks__2021_10_25.sql';
USE [perpetuumsa]
GO

DECLARE @respawnTime AS INT = (2*60*60);--2 HOURS
DECLARE @courierRespawnTime AS INT = (5*60*60);--5 HOURS
DECLARE @observerRespawnTime AS INT = (5*60*60);--5 HOURS

DROP TABLE IF EXISTS #ZONES_BY_TIER_AND_FACTION;
CREATE TABLE #ZONES_BY_TIER_AND_FACTION(
	zoneId INT NOT NULL,
	zonetier INT NOT NULL,
	zonefaction varchar(128) NOT NULL
);
INSERT INTO #ZONES_BY_TIER_AND_FACTION(zoneId, zonetier, zonefaction)
SELECT
	id,
	pbsTechLimit,
	CASE raceid
		WHEN 1 THEN 'Pelistal' 
		WHEN 2 THEN 'Nuimqol' 
		WHEN 3 THEN 'Thelodica' 
	END
FROM zones WHERE id > 105 AND name not like 'zone_gamma_tc_%'
AND id != 110;

INSERT INTO #ZONES_BY_TIER_AND_FACTION(zoneId, zonetier, zonefaction)
SELECT 110, 0, 'Syndicate';


DROP TABLE IF EXISTS #TMPNPCPRESENCE;
CREATE TABLE #TMPNPCPRESENCE
(
	name varchar(128) NOT NULL, --the FULL name
	topx int NOT NULL DEFAULT 40,
	topy int NOT NULL DEFAULT 40,
	bottomx int NOT NULL DEFAULT 2000,
	bottomy int NOT NULL DEFAULT 2000,
	note nvarchar(2000) NULL,
	spawnid int NULL,
	enabled bit NOT NULL DEFAULT 1,
	roaming bit NOT NULL DEFAULT 1,
	roamingrespawnseconds int NULL DEFAULT 7200, --respawn time
	presencetype int NOT NULL DEFAULT 5,
	maxrandomflock int NULL,
	randomcenterx int NULL,
	randomcentery int NULL,
	randomradius int NULL,
	dynamiclifetime int NULL,
	isbodypull bit NOT NULL DEFAULT 1,
	isrespawnallowed bit NOT NULL DEFAULT 1,
	safebodypull bit NOT NULL DEFAULT 1,
	izgroupid int NULL,
	growthseconds int NULL
);

DROP TABLE IF EXISTS #TMPNPC;
CREATE TABLE #TMPNPC
(
	zonetier INT NOT NULL,
	zonefaction varchar(128) NOT NULL,
	fullName varchar(128) NULL, --the fully qualified name based on zone logic
	presencename varchar(100) NOT NULL, --temp field used to gather presence id later
	defname varchar(100) NOT NULL, --temp field used to gather definition id later
	flockmembercount int NULL --number of npc
);
INSERT INTO #TMPNPC (zonetier,zonefaction,presencename,defname,flockmembercount)
VALUES
(0,'Nuimqol','roamer_01','def_npc_gamma_kain_dps_l7',3),
(0,'Nuimqol','roamer_01','def_npc_gamma_vagabond_shield_l7',2),
(0,'Nuimqol','roamer_01','def_npc_gamma_cameleon_shield_l7',2),
(0,'Nuimqol','roamer_02','def_npc_gamma_scarab_basic_lindy',1),
(0,'Nuimqol','roamer_02','def_npc_gamma_symbiont_basic_lindy',1),
(0,'Nuimqol','roamer_02','def_npc_gamma_riveler_basic_lindy',1),
(0,'Nuimqol','roamer_02','def_npc_gamma_termis_basic_lindy',2),
(0,'Nuimqol','roamer_02','def_npc_gamma_laird_basic_lindy',2),
(0,'Nuimqol','roamer_02','def_npc_gamma_mesmer_tank_l7',2),
(0,'Nuimqol','roamer_02','def_npc_gamma_mesmer_dps_l7',2),
(0,'Nuimqol','roamer_02','def_npc_gamma_kain_tank_l7',3),
(0,'Nuimqol','roamer_02','def_npc_gamma_vagabond_armor_l7',2),
(0,'Nuimqol','roamer_02','def_npc_gamma_yagel_speed_l7',2),
(0,'Nuimqol','roamer_03','def_npc_gamma_arbalest_dps_l7',3),
(0,'Nuimqol','roamer_03','def_npc_gamma_cameleon_armor_l7',2),
(0,'Nuimqol','roamer_03','def_npc_gamma_yagel_dps_l7',2),
(0,'Nuimqol','roamer_04','def_npc_gamma_mesmer_dps_l6',4),
(0,'Nuimqol','roamer_04','def_npc_gamma_vagabond_shield_l6',3),
(0,'Nuimqol','roamer_04','def_npc_gamma_arbalest_speed_l6',3),
(0,'Nuimqol','roamer_05','def_npc_gamma_kain_dps_l6',3),
(0,'Nuimqol','roamer_05','def_npc_gamma_vagabond_armor_l6',3),
(0,'Nuimqol','roamer_05','def_npc_gamma_yagel_dps_l6',2),
(0,'Nuimqol','roamer_06','def_npc_gamma_yagel_speed_l6',2),
(0,'Nuimqol','roamer_06','def_npc_gamma_sequer_basic_lindy',1),
(0,'Nuimqol','roamer_06','def_npc_gamma_termis_basic_lindy',1),
(0,'Nuimqol','roamer_06','def_npc_gamma_laird_basic_lindy',3),
(0,'Nuimqol','roamer_06','def_npc_gamma_arbalest_speed_l6',3),
(0,'Nuimqol','roamer_06','def_npc_gamma_cameleon_shield_l6',3),
(0,'Nuimqol','roamer_06','def_npc_gamma_kain_dps_l6',2),
(0,'Nuimqol','roamer_07','def_npc_gamma_yagel_speed_l6',2),
(0,'Nuimqol','roamer_07','def_npc_gamma_cameleon_shield_l6',3),
(0,'Nuimqol','roamer_07','def_npc_gamma_arbalest_speed_l6',4),
(0,'Nuimqol','roamer_08','def_npc_gamma_mesmer_dps_l6',2),
(0,'Nuimqol','roamer_08','def_npc_gamma_kain_dps_l6',3),
(0,'Nuimqol','roamer_08','def_npc_gamma_cameleon_shield_l6',2),
(0,'Nuimqol','roamer_08','def_npc_gamma_yagel_dps_l6',2),
(0,'Nuimqol','roamer_09','def_npc_gamma_lithus_basic_lindy',1),
(0,'Nuimqol','roamer_09','def_npc_gamma_sequer_basic_lindy',2),
(0,'Nuimqol','roamer_09','def_npc_gamma_termis_basic_lindy',1),
(0,'Nuimqol','roamer_09','def_npc_gamma_laird_basic_lindy',3),
(0,'Nuimqol','roamer_09','def_npc_gamma_arbalest_speed_l6',1),
(0,'Nuimqol','roamer_09','def_npc_gamma_kain_dps_l6',2),
(0,'Nuimqol','observer_01','def_npc_gamma_mesmer_advanced_observer',2),
(0,'Nuimqol','observer_01','def_npc_gamma_kain_advanced_observer',1),
(0,'Nuimqol','observer_01','def_npc_gamma_vagabond_advanced_observer',1),
(0,'Nuimqol','observer_02','def_npc_gamma_kain_advanced_observer',2),
(0,'Nuimqol','observer_02','def_npc_gamma_vagabond_advanced_observer',1),
(0,'Nuimqol','courier_01','def_npc_gamma_arbalest_advanced_courier',2),
(0,'Nuimqol','courier_01','def_npc_gamma_cameleon_advanced_courier',1),
(0,'Nuimqol','courier_01','def_npc_gamma_sequer_advanced_courier',3),
(0,'Nuimqol','courier_02','def_npc_gamma_yagel_advanced_courier',1),
(0,'Nuimqol','courier_02','def_npc_gamma_hermes_advanced_courier',1),

(0,'Thelodica','roamer_01','def_npc_gamma_artemis_dps_l7',3),
(0,'Thelodica','roamer_01','def_npc_gamma_zenith_shield_l7',2),
(0,'Thelodica','roamer_01','def_npc_gamma_intakt_shield_l7',2),
(0,'Thelodica','roamer_02','def_npc_gamma_scarab_basic_lindy',1),
(0,'Thelodica','roamer_02','def_npc_gamma_riveler_basic_lindy',1),
(0,'Thelodica','roamer_02','def_npc_gamma_symbiont_basic_lindy',1),
(0,'Thelodica','roamer_02','def_npc_gamma_gargoyle_basic_lindy',2),
(0,'Thelodica','roamer_02','def_npc_gamma_argano_basic_lindy',2),
(0,'Thelodica','roamer_02','def_npc_gamma_seth_tank_l7',2),
(0,'Thelodica','roamer_02','def_npc_gamma_seth_dps_l7',2),
(0,'Thelodica','roamer_02','def_npc_gamma_artemis_tank_l7',3),
(0,'Thelodica','roamer_02','def_npc_gamma_zenith_armor_l7',2),
(0,'Thelodica','roamer_02','def_npc_gamma_prometheus_speed_l7',2),
(0,'Thelodica','roamer_03','def_npc_gamma_baphomet_dps_l7',3),
(0,'Thelodica','roamer_03','def_npc_gamma_intakt_armor_l7',2),
(0,'Thelodica','roamer_03','def_npc_gamma_prometheus_dps_l7',2),
(0,'Thelodica','roamer_04','def_npc_gamma_seth_dps_l6',4),
(0,'Thelodica','roamer_04','def_npc_gamma_zenith_shield_l6',3),
(0,'Thelodica','roamer_04','def_npc_gamma_baphomet_speed_l6',3),
(0,'Thelodica','roamer_05','def_npc_gamma_artemis_dps_l6',3),
(0,'Thelodica','roamer_05','def_npc_gamma_zenith_armor_l6',3),
(0,'Thelodica','roamer_05','def_npc_gamma_prometheus_dps_l6',2),
(0,'Thelodica','roamer_06','def_npc_gamma_prometheus_speed_l6',2),
(0,'Thelodica','roamer_06','def_npc_gamma_sequer_basic_lindy',1),
(0,'Thelodica','roamer_06','def_npc_gamma_gargoyle_basic_lindy',1),
(0,'Thelodica','roamer_06','def_npc_gamma_argano_basic_lindy',3),
(0,'Thelodica','roamer_06','def_npc_gamma_baphomet_speed_l6',3),
(0,'Thelodica','roamer_06','def_npc_gamma_intakt_shield_l6',3),
(0,'Thelodica','roamer_06','def_npc_gamma_artemis_dps_l6',2),
(0,'Thelodica','roamer_07','def_npc_gamma_prometheus_speed_l6',2),
(0,'Thelodica','roamer_07','def_npc_gamma_intakt_shield_l6',3),
(0,'Thelodica','roamer_07','def_npc_gamma_baphomet_speed_l6',4),
(0,'Thelodica','roamer_08','def_npc_gamma_seth_dps_l6',2),
(0,'Thelodica','roamer_08','def_npc_gamma_artemis_dps_l6',3),
(0,'Thelodica','roamer_08','def_npc_gamma_intakt_shield_l6',2),
(0,'Thelodica','roamer_08','def_npc_gamma_prometheus_dps_l6',2),
(0,'Thelodica','roamer_09','def_npc_gamma_lithus_basic_lindy',1),
(0,'Thelodica','roamer_09','def_npc_gamma_sequer_basic_lindy',2),
(0,'Thelodica','roamer_09','def_npc_gamma_gargoyle_basic_lindy',1),
(0,'Thelodica','roamer_10','def_npc_gamma_argano_basic_lindy',3),
(0,'Thelodica','roamer_09','def_npc_gamma_baphomet_speed_l6',1),
(0,'Thelodica','roamer_09','def_npc_gamma_artemis_dps_l6',2),
(0,'Thelodica','observer_01','def_npc_gamma_seth_advanced_observer',2),
(0,'Thelodica','observer_01','def_npc_gamma_artemis_advanced_observer',1),
(0,'Thelodica','observer_01','def_npc_gamma_zenith_advanced_observer',1),
(0,'Thelodica','observer_02','def_npc_gamma_artemis_advanced_observer',2),
(0,'Thelodica','observer_02','def_npc_gamma_zenith_advanced_observer',1),
(0,'Thelodica','courier_01','def_npc_gamma_baphomet_advanced_courier',2),
(0,'Thelodica','courier_01','def_npc_gamma_intakt_advanced_courier',1),
(0,'Thelodica','courier_01','def_npc_gamma_sequer_advanced_courier',3),
(0,'Thelodica','courier_02','def_npc_gamma_prometheus_advanced_courier',1),
(0,'Thelodica','courier_02','def_npc_gamma_hermes_advanced_courier',1),

(0,'Pelistal','roamer_01','def_npc_gamma_tyrannos_dps_l7',3),
(0,'Pelistal','roamer_01','def_npc_gamma_ictus_shield_l7',2),
(0,'Pelistal','roamer_01','def_npc_gamma_troiar_shield_l7',2),
(0,'Pelistal','roamer_02','def_npc_gamma_scarab_basic_lindy',1),
(0,'Pelistal','roamer_02','def_npc_gamma_symbiont_basic_lindy',1),
(0,'Pelistal','roamer_02','def_npc_gamma_riveler_basic_lindy',1),
(0,'Pelistal','roamer_02','def_npc_gamma_termis_basic_lindy',2),
(0,'Pelistal','roamer_03','def_npc_gamma_laird_basic_lindy',2),
(0,'Pelistal','roamer_02','def_npc_gamma_gropho_tank_l7',2),
(0,'Pelistal','roamer_02','def_npc_gamma_gropho_dps_l7',2),
(0,'Pelistal','roamer_02','def_npc_gamma_tyrannos_tank_l7',3),
(0,'Pelistal','roamer_02','def_npc_gamma_ictus_armor_l7',2),
(0,'Pelistal','roamer_02','def_npc_gamma_castel_speed_l7',2),
(0,'Pelistal','roamer_03','def_npc_gamma_waspish_dps_l7',3),
(0,'Pelistal','roamer_03','def_npc_gamma_troiar_armor_l7',2),
(0,'Pelistal','roamer_03','def_npc_gamma_castel_dps_l7',2),
(0,'Pelistal','roamer_04','def_npc_gamma_gropho_dps_l6',4),
(0,'Pelistal','roamer_04','def_npc_gamma_ictus_shield_l6',3),
(0,'Pelistal','roamer_04','def_npc_gamma_waspish_speed_l6',3),
(0,'Pelistal','roamer_05','def_npc_gamma_tyrannos_dps_l6',3),
(0,'Pelistal','roamer_05','def_npc_gamma_ictus_armor_l6',3),
(0,'Pelistal','roamer_05','def_npc_gamma_castel_dps_l6',2),
(0,'Pelistal','roamer_06','def_npc_gamma_castel_speed_l6',2),
(0,'Pelistal','roamer_06','def_npc_gamma_sequer_basic_lindy',1),
(0,'Pelistal','roamer_06','def_npc_gamma_gargoyle_basic_lindy',1),
(0,'Pelistal','roamer_06','def_npc_gamma_argano_basic_lindy',3),
(0,'Pelistal','roamer_06','def_npc_gamma_waspish_speed_l6',3),
(0,'Pelistal','roamer_06','def_npc_gamma_troiar_shield_l6',3),
(0,'Pelistal','roamer_06','def_npc_gamma_tyrannos_dps_l6',2),
(0,'Pelistal','roamer_07','def_npc_gamma_castel_speed_l6',2),
(0,'Pelistal','roamer_07','def_npc_gamma_troiar_shield_l6',3),
(0,'Pelistal','roamer_07','def_npc_gamma_waspish_speed_l6',4),
(0,'Pelistal','roamer_08','def_npc_gamma_gropho_dps_l6',2),
(0,'Pelistal','roamer_08','def_npc_gamma_tyrannos_dps_l6',3),
(0,'Pelistal','roamer_08','def_npc_gamma_troiar_shield_l6',2),
(0,'Pelistal','roamer_08','def_npc_gamma_castel_dps_l6',2),
(0,'Pelistal','roamer_09','def_npc_gamma_lithus_basic_lindy',1),
(0,'Pelistal','roamer_09','def_npc_gamma_sequer_basic_lindy',2),
(0,'Pelistal','roamer_09','def_npc_gamma_gargoyle_basic_lindy',1),
(0,'Pelistal','roamer_10','def_npc_gamma_argano_basic_lindy',3),
(0,'Pelistal','roamer_09','def_npc_gamma_waspish_speed_l6',1),
(0,'Pelistal','roamer_09','def_npc_gamma_tyrannos_dps_l6',2),
(0,'Pelistal','observer_01','def_npc_gamma_gropho_advanced_observer',2),
(0,'Pelistal','observer_01','def_npc_gamma_tyrannos_advanced_observer',1),
(0,'Pelistal','observer_01','def_npc_gamma_ictus_advanced_observer',1),
(0,'Pelistal','observer_02','def_npc_gamma_tyrannos_advanced_observer',2),
(0,'Pelistal','observer_02','def_npc_gamma_ictus_advanced_observer',1),
(0,'Pelistal','courier_01','def_npc_gamma_waspish_advanced_courier',2),
(0,'Pelistal','courier_01','def_npc_gamma_troiar_advanced_courier',1),
(0,'Pelistal','courier_01','def_npc_gamma_sequer_advanced_courier',3),
(0,'Pelistal','courier_02','def_npc_gamma_castel_advanced_courier',1),
(0,'Pelistal','courier_02','def_npc_gamma_hermes_advanced_courier',1),

(0,'Syndicate','roamer_01','def_npc_gamma_legatus_dps_l7',2),
(0,'Syndicate','roamer_01','def_npc_gamma_echelon_dps_l7',3),
(0,'Syndicate','roamer_01','def_npc_gamma_callisto_shield_l7',2),
(0,'Syndicate','roamer_01','def_npc_gamma_helix_shield_l7',2),
(0,'Syndicate','roamer_02','def_npc_gamma_daidalos_basic_lindy',4),
(0,'Syndicate','roamer_02','def_npc_gamma_cronus_basic_lindy',8),
(0,'Syndicate','roamer_02','def_npc_gamma_legatus_tank_l7',2),
(0,'Syndicate','roamer_02','def_npc_gamma_echelon_tank_l7',2),
(0,'Syndicate','roamer_02','def_npc_gamma_callisto_armor_l7',2),
(0,'Syndicate','roamer_02','def_npc_gamma_vektor_speed_l7',2),
(0,'Syndicate','roamer_03','def_npc_gamma_locust_dps_l7',3),
(0,'Syndicate','roamer_03','def_npc_gamma_helix_armor_l7',2),
(0,'Syndicate','roamer_03','def_npc_gamma_vektor_dps_l7',2),
(0,'Syndicate','roamer_04','def_npc_gamma_legatus_dps_l6',3),
(0,'Syndicate','roamer_04','def_npc_gamma_callisto_shield_l6',3),
(0,'Syndicate','roamer_04','def_npc_gamma_locust_speed_l6',3),
(0,'Syndicate','roamer_05','def_npc_gamma_echelon_dps_l6',4),
(0,'Syndicate','roamer_05','def_npc_gamma_ikarus_basic_lindy',3),
(0,'Syndicate','roamer_05','def_npc_gamma_cronus_basic_lindy',4),
(0,'Syndicate','roamer_05','def_npc_gamma_callisto_armor_l6',3),
(0,'Syndicate','roamer_05','def_npc_gamma_vektor_dps_l6',2),
(0,'Syndicate','roamer_06','def_npc_gamma_vektor_speed_l6',2),
(0,'Syndicate','roamer_06','def_npc_gamma_locust_speed_l6',4),
(0,'Syndicate','roamer_06','def_npc_gamma_helix_shield_l6',3),
(0,'Syndicate','roamer_06','def_npc_gamma_echelon_dps_l6',2),
(0,'Syndicate','roamer_07','def_npc_gamma_vektor_speed_l6',2),
(0,'Syndicate','roamer_07','def_npc_gamma_helix_shield_l6',3),
(0,'Syndicate','roamer_07','def_npc_gamma_locust_dps_l6',2),
(0,'Syndicate','roamer_08','def_npc_gamma_legatus_dps_l6',2),
(0,'Syndicate','roamer_08','def_npc_gamma_echelon_dps_l6',3),
(0,'Syndicate','roamer_08','def_npc_gamma_helix_shield_l6',2),
(0,'Syndicate','roamer_08','def_npc_gamma_vektor_dps_l6',2),
(0,'Syndicate','roamer_09','def_npc_gamma_hermes_basic_lindy',1),
(0,'Syndicate','roamer_10','def_npc_gamma_daidalos_basic_lindy',1),
(0,'Syndicate','roamer_10','def_npc_gamma_ikarus_basic_lindy',1),
(0,'Syndicate','roamer_10','def_npc_gamma_cronus_basic_lindy',3),
(0,'Syndicate','roamer_10','def_npc_gamma_locust_speed_l6',1),
(0,'Syndicate','roamer_10','def_npc_gamma_echelon_dps_l6',2),
(0,'Syndicate','observer_01','def_npc_gamma_legatus_advanced_observer',2),
(0,'Syndicate','observer_01','def_npc_gamma_echelon_advanced_observer',1),
(0,'Syndicate','observer_01','def_npc_gamma_callisto_advanced_observer',1),
(0,'Syndicate','observer_02','def_npc_gamma_echelon_advanced_observer',2),
(0,'Syndicate','observer_02','def_npc_gamma_callisto_advanced_observer',1),
(0,'Syndicate','courier_01','def_npc_gamma_locust_advanced_courier',2),
(0,'Syndicate','courier_01','def_npc_gamma_helix_advanced_courier',1),
(0,'Syndicate','courier_01','def_npc_gamma_ikarus_advanced_courier',4),
(0,'Syndicate','courier_02','def_npc_gamma_vektor_advanced_courier',1),
(0,'Syndicate','courier_02','def_npc_gamma_hermes_advanced_courier',1),

(3,'Nuimqol','roamer_01','def_npc_gamma_kain_dps_l5',3),
(3,'Nuimqol','roamer_01','def_npc_gamma_vagabond_shield_l5',2),
(3,'Nuimqol','roamer_01','def_npc_gamma_cameleon_shield_l5',1),
(3,'Nuimqol','roamer_02','def_npc_gamma_lithus_basic_lindy',1),
(3,'Nuimqol','roamer_02','def_npc_gamma_riveler_basic_lindy',1),
(3,'Nuimqol','roamer_02','def_npc_gamma_gargoyle_basic_lindy',3),
(3,'Nuimqol','roamer_02','def_npc_gamma_mesmer_tank_l5',3),
(3,'Nuimqol','roamer_02','def_npc_gamma_kain_tank_l5',2),
(3,'Nuimqol','roamer_02','def_npc_gamma_vagabond_armor_l5',2),
(3,'Nuimqol','roamer_02','def_npc_gamma_yagel_speed_l5',2),
(3,'Nuimqol','roamer_03','def_npc_gamma_arbalest_dps_l5',3),
(3,'Nuimqol','roamer_03','def_npc_gamma_cameleon_armor_l5',2),
(3,'Nuimqol','roamer_03','def_npc_gamma_yagel_dps_l5',2),
(3,'Nuimqol','roamer_04','def_npc_gamma_mesmer_dps_l5',3),
(3,'Nuimqol','roamer_04','def_npc_gamma_vagabond_shield_l5',2),
(3,'Nuimqol','roamer_04','def_npc_gamma_arbalest_speed_l5',2),
(3,'Nuimqol','roamer_05','def_npc_gamma_mesmer_tank_l5',2),
(3,'Nuimqol','roamer_05','def_npc_gamma_kain_dps_l5',2),
(3,'Nuimqol','roamer_05','def_npc_gamma_vagabond_armor_l5',2),
(3,'Nuimqol','roamer_05','def_npc_gamma_yagel_dps_l5',2),
(3,'Nuimqol','roamer_06','def_npc_gamma_yagel_speed_l5',2),
(3,'Nuimqol','roamer_06','def_npc_gamma_arbalest_speed_l5',4),
(3,'Nuimqol','roamer_06','def_npc_gamma_cameleon_shield_l5',2),
(3,'Nuimqol','roamer_06','def_npc_gamma_kain_dps_l5',2),
(3,'Nuimqol','roamer_07','def_npc_gamma_yagel_speed_l5',2),
(3,'Nuimqol','roamer_07','def_npc_gamma_cameleon_shield_l5',2),
(3,'Nuimqol','roamer_07','def_npc_gamma_arbalest_dps_l5',2),
(3,'Nuimqol','roamer_08','def_npc_gamma_mesmer_dps_l5',2),
(3,'Nuimqol','roamer_08','def_npc_gamma_kain_dps_l5',4),
(3,'Nuimqol','roamer_08','def_npc_gamma_cameleon_shield_l5',1),
(3,'Nuimqol','roamer_08','def_npc_gamma_yagel_dps_l5',2),
(3,'Nuimqol','roamer_09','def_npc_gamma_sequer_basic_lindy',1),
(3,'Nuimqol','roamer_09','def_npc_gamma_laird_basic_lindy',3),
(3,'Nuimqol','roamer_09','def_npc_gamma_termis_basic_lindy',1),
(3,'Nuimqol','roamer_09','def_npc_gamma_arbalest_speed_l5',1),
(3,'Nuimqol','roamer_09','def_npc_gamma_kain_dps_l5',1),
(3,'Nuimqol','observer_01','def_npc_gamma_mesmer_advanced_observer',1),
(3,'Nuimqol','observer_01','def_npc_gamma_kain_advanced_observer',2),
(3,'Nuimqol','observer_01','def_npc_gamma_vagabond_advanced_observer',1),
(3,'Nuimqol','observer_02','def_npc_gamma_kain_advanced_observer',1),
(3,'Nuimqol','observer_02','def_npc_gamma_vagabond_advanced_observer',1),
(3,'Nuimqol','courier_01','def_npc_gamma_arbalest_advanced_courier',1),
(3,'Nuimqol','courier_01','def_npc_gamma_yagel_advanced_courier',2),
(3,'Nuimqol','courier_01','def_npc_gamma_sequer_advanced_courier',1),
(3,'Nuimqol','courier_01','def_npc_gamma_ikarus_advanced_courier',1),
(3,'Nuimqol','courier_02','def_npc_gamma_cameleon_advanced_courier',1),
(3,'Nuimqol','courier_02','def_npc_gamma_hermes_advanced_courier',1),

(2,'Nuimqol','roamer_01','def_npc_gamma_kain_dps_l4',2),
(2,'Nuimqol','roamer_01','def_npc_gamma_mesmer_dps_l4',1),
(2,'Nuimqol','roamer_01','def_npc_gamma_arbalest_dps_l4',3),
(2,'Nuimqol','roamer_01','def_npc_gamma_cameleon_shield_l4',3),
(2,'Nuimqol','roamer_02','def_npc_gamma_sequer_basic_lindy',2),
(2,'Nuimqol','roamer_02','def_npc_gamma_riveler_basic_lindy',1),
(2,'Nuimqol','roamer_02','def_npc_gamma_gargoyle_basic_lindy',2),
(2,'Nuimqol','roamer_02','def_npc_gamma_mesmer_tank_l4',2),
(2,'Nuimqol','roamer_02','def_npc_gamma_kain_tank_l4',2),
(2,'Nuimqol','roamer_02','def_npc_gamma_vagabond_armor_l4',2),
(2,'Nuimqol','roamer_02','def_npc_gamma_yagel_speed_l4',2),
(2,'Nuimqol','roamer_03','def_npc_gamma_arbalest_dps_l4',3),
(2,'Nuimqol','roamer_03','def_npc_gamma_vagabond_armor_l4',2),
(2,'Nuimqol','roamer_03','def_npc_gamma_yagel_dps_l4',3),
(2,'Nuimqol','roamer_04','def_npc_gamma_mesmer_dps_l4',3),
(2,'Nuimqol','roamer_04','def_npc_gamma_yagel_speed_l4',2),
(2,'Nuimqol','roamer_04','def_npc_gamma_arbalest_speed_l4',3),
(2,'Nuimqol','roamer_05','def_npc_gamma_kain_dps_l4',3),
(2,'Nuimqol','roamer_05','def_npc_gamma_vagabond_armor_l4',2),
(2,'Nuimqol','roamer_05','def_npc_gamma_yagel_dps_l4',3),
(2,'Nuimqol','roamer_06','def_npc_gamma_yagel_speed_l4',2),
(2,'Nuimqol','roamer_06','def_npc_gamma_arbalest_speed_l4',3),
(2,'Nuimqol','roamer_06','def_npc_gamma_cameleon_shield_l4',2),
(2,'Nuimqol','roamer_06','def_npc_gamma_kain_dps_l4',3),
(2,'Nuimqol','roamer_07','def_npc_gamma_yagel_speed_l4',2),
(2,'Nuimqol','roamer_07','def_npc_gamma_cameleon_shield_l4',2),
(2,'Nuimqol','roamer_07','def_npc_gamma_arbalest_dps_l4',2),
(2,'Nuimqol','roamer_08','def_npc_gamma_mesmer_dps_l4',2),
(2,'Nuimqol','roamer_08','def_npc_gamma_kain_dps_l4',5),
(2,'Nuimqol','roamer_08','def_npc_gamma_cameleon_armor_l4',3),
(2,'Nuimqol','roamer_08','def_npc_gamma_yagel_dps_l4',2),
(2,'Nuimqol','roamer_09','def_npc_gamma_sequer_basic_lindy',1),
(2,'Nuimqol','roamer_09','def_npc_gamma_gargoyle_basic_lindy',1),
(2,'Nuimqol','roamer_09','def_npc_gamma_termis_basic_lindy',1),
(2,'Nuimqol','roamer_09','def_npc_gamma_arbalest_speed_l3',2),
(2,'Nuimqol','observer_01','def_npc_gamma_mesmer_advanced_observer',1),
(2,'Nuimqol','observer_01','def_npc_gamma_vagabond_advanced_observer',1),
(2,'Nuimqol','observer_02','def_npc_gamma_kain_advanced_observer',1),
(2,'Nuimqol','observer_02','def_npc_gamma_vagabond_advanced_observer',1),
(2,'Nuimqol','courier_01','def_npc_gamma_arbalest_advanced_courier',1),
(2,'Nuimqol','courier_01','def_npc_gamma_cameleon_advanced_courier',1),
(2,'Nuimqol','courier_01','def_npc_gamma_sequer_advanced_courier',2),
(2,'Nuimqol','courier_02','def_npc_gamma_yagel_advanced_courier',2),
(2,'Nuimqol','courier_02','def_npc_gamma_ikarus_advanced_courier',1),

(1,'Nuimqol','roamer_01','def_npc_gamma_kain_dps_l3',2),
(1,'Nuimqol','roamer_01','def_npc_gamma_arbalest_dps_l3',4),
(1,'Nuimqol','roamer_01','def_npc_gamma_cameleon_shield_l3',3),
(1,'Nuimqol','roamer_02','def_npc_gamma_sequer_basic_lindy',2),
(1,'Nuimqol','roamer_02','def_npc_gamma_riveler_basic_lindy',1),
(1,'Nuimqol','roamer_02','def_npc_gamma_laird_basic_lindy',2),
(1,'Nuimqol','roamer_02','def_npc_gamma_mesmer_tank_l3',1),
(1,'Nuimqol','roamer_02','def_npc_gamma_kain_tank_l3',3),
(1,'Nuimqol','roamer_02','def_npc_gamma_vagabond_armor_l3',1),
(1,'Nuimqol','roamer_02','def_npc_gamma_cameleon_armor_l3',2),
(1,'Nuimqol','roamer_02','def_npc_gamma_yagel_speed_l3',2),
(1,'Nuimqol','roamer_03','def_npc_gamma_arbalest_dps_l3',4),
(1,'Nuimqol','roamer_03','def_npc_gamma_vagabond_armor_l3',2),
(1,'Nuimqol','roamer_03','def_npc_gamma_yagel_dps_l3',3),
(1,'Nuimqol','roamer_04','def_npc_gamma_mesmer_dps_l3',3),
(1,'Nuimqol','roamer_04','def_npc_gamma_yagel_speed_l3',3),
(1,'Nuimqol','roamer_04','def_npc_gamma_arbalest_speed_l3',4),
(1,'Nuimqol','roamer_05','def_npc_gamma_kain_dps_l3',3),
(1,'Nuimqol','roamer_05','def_npc_gamma_vagabond_armor_l3',1),
(1,'Nuimqol','roamer_05','def_npc_gamma_cameleon_armor_l3',1),
(1,'Nuimqol','roamer_05','def_npc_gamma_yagel_dps_l3',3),
(1,'Nuimqol','roamer_06','def_npc_gamma_yagel_speed_l3',3),
(1,'Nuimqol','roamer_06','def_npc_gamma_arbalest_speed_l3',4),
(1,'Nuimqol','roamer_06','def_npc_gamma_cameleon_shield_l3',2),
(1,'Nuimqol','roamer_06','def_npc_gamma_kain_dps_l3',3),
(1,'Nuimqol','roamer_07','def_npc_gamma_yagel_speed_l3',2),
(1,'Nuimqol','roamer_07','def_npc_gamma_cameleon_shield_l3',2),
(1,'Nuimqol','roamer_07','def_npc_gamma_arbalest_dps_l3',2),
(1,'Nuimqol','roamer_08','def_npc_gamma_mesmer_dps_l3',2),
(1,'Nuimqol','roamer_08','def_npc_gamma_kain_dps_l3',5),
(1,'Nuimqol','roamer_08','def_npc_gamma_cameleon_armor_l3',2),
(1,'Nuimqol','roamer_08','def_npc_gamma_yagel_dps_l3',3),
(1,'Nuimqol','roamer_09','def_npc_gamma_sequer_basic_lindy',1),
(1,'Nuimqol','roamer_09','def_npc_gamma_laird_basic_lindy',1),
(1,'Nuimqol','roamer_09','def_npc_gamma_argano_basic_lindy',1),
(1,'Nuimqol','roamer_09','def_npc_gamma_arbalest_speed_l3',2),
(1,'Nuimqol','roamer_09','def_npc_gamma_yagel_speed_l3',1),
(1,'Nuimqol','observer_01','def_npc_gamma_mesmer_advanced_observer',1),
(1,'Nuimqol','observer_01','def_npc_gamma_kain_advanced_observer',1),
(1,'Nuimqol','observer_02','def_npc_gamma_kain_advanced_observer',1),
(1,'Nuimqol','observer_02','def_npc_gamma_vagabond_advanced_observer',1),
(1,'Nuimqol','courier_01','def_npc_gamma_arbalest_advanced_courier',1),
(1,'Nuimqol','courier_01','def_npc_gamma_ikarus_advanced_courier',2),
(1,'Nuimqol','courier_02','def_npc_gamma_yagel_advanced_courier',1),
(1,'Nuimqol','courier_02','def_npc_gamma_ikarus_advanced_courier',1),

(3,'Thelodica','roamer_01','def_npc_gamma_artemis_dps_l5',3),
(3,'Thelodica','roamer_01','def_npc_gamma_zenith_shield_l5',2),
(3,'Thelodica','roamer_01','def_npc_gamma_intakt_shield_l5',1),
(3,'Thelodica','roamer_02','def_npc_gamma_lithus_basic_lindy',1),
(3,'Thelodica','roamer_02','def_npc_gamma_symbiont_basic_lindy',1),
(3,'Thelodica','roamer_02','def_npc_gamma_termis_basic_lindy',3),
(3,'Thelodica','roamer_02','def_npc_gamma_seth_tank_l5',3),
(3,'Thelodica','roamer_02','def_npc_gamma_artemis_tank_l5',2),
(3,'Thelodica','roamer_02','def_npc_gamma_zenith_armor_l5',2),
(3,'Thelodica','roamer_02','def_npc_gamma_prometheus_speed_l5',2),
(3,'Thelodica','roamer_03','def_npc_gamma_baphomet_dps_l5',3),
(3,'Thelodica','roamer_03','def_npc_gamma_intakt_armor_l5',2),
(3,'Thelodica','roamer_03','def_npc_gamma_prometheus_dps_l5',2),
(3,'Thelodica','roamer_04','def_npc_gamma_seth_dps_l5',3),
(3,'Thelodica','roamer_04','def_npc_gamma_zenith_shield_l5',2),
(3,'Thelodica','roamer_04','def_npc_gamma_baphomet_speed_l5',2),
(3,'Thelodica','roamer_05','def_npc_gamma_seth_tank_l5',2),
(3,'Thelodica','roamer_05','def_npc_gamma_artemis_dps_l5',2),
(3,'Thelodica','roamer_05','def_npc_gamma_zenith_armor_l5',2),
(3,'Thelodica','roamer_05','def_npc_gamma_prometheus_dps_l5',2),
(3,'Thelodica','roamer_06','def_npc_gamma_prometheus_speed_l5',2),
(3,'Thelodica','roamer_06','def_npc_gamma_baphomet_speed_l5',4),
(3,'Thelodica','roamer_06','def_npc_gamma_intakt_shield_l5',2),
(3,'Thelodica','roamer_06','def_npc_gamma_artemis_dps_l5',2),
(3,'Thelodica','roamer_07','def_npc_gamma_prometheus_speed_l5',2),
(3,'Thelodica','roamer_07','def_npc_gamma_intakt_shield_l5',2),
(3,'Thelodica','roamer_07','def_npc_gamma_baphomet_dps_l5',2),
(3,'Thelodica','roamer_08','def_npc_gamma_seth_dps_l5',2),
(3,'Thelodica','roamer_08','def_npc_gamma_artemis_dps_l5',4),
(3,'Thelodica','roamer_08','def_npc_gamma_intakt_shield_l5',1),
(3,'Thelodica','roamer_08','def_npc_gamma_prometheus_dps_l5',2),
(3,'Thelodica','roamer_09','def_npc_gamma_sequer_basic_lindy',1),
(3,'Thelodica','roamer_09','def_npc_gamma_argano_basic_lindy',3),
(3,'Thelodica','roamer_09','def_npc_gamma_gargoyle_basic_lindy',1),
(3,'Thelodica','roamer_09','def_npc_gamma_baphomet_speed_l5',1),
(3,'Thelodica','roamer_09','def_npc_gamma_artemis_dps_l5',1),
(3,'Thelodica','observer_01','def_npc_gamma_seth_advanced_observer',1),
(3,'Thelodica','observer_01','def_npc_gamma_artemis_advanced_observer',2),
(3,'Thelodica','observer_01','def_npc_gamma_zenith_advanced_observer',1),
(3,'Thelodica','observer_02','def_npc_gamma_artemis_advanced_observer',1),
(3,'Thelodica','observer_02','def_npc_gamma_zenith_advanced_observer',1),
(3,'Thelodica','courier_01','def_npc_gamma_baphomet_advanced_courier',1),
(3,'Thelodica','courier_01','def_npc_gamma_prometheus_advanced_courier',2),
(3,'Thelodica','courier_01','def_npc_gamma_sequer_advanced_courier',1),
(3,'Thelodica','courier_01','def_npc_gamma_ikarus_advanced_courier',1),
(3,'Thelodica','courier_02','def_npc_gamma_intakt_advanced_courier',1),
(3,'Thelodica','courier_02','def_npc_gamma_hermes_advanced_courier',1),

(2,'Thelodica','roamer_01','def_npc_gamma_artemis_dps_l4',2),
(2,'Thelodica','roamer_01','def_npc_gamma_seth_dps_l4',1),
(2,'Thelodica','roamer_01','def_npc_gamma_baphomet_dps_l4',3),
(2,'Thelodica','roamer_01','def_npc_gamma_intakt_shield_l4',3),
(2,'Thelodica','roamer_02','def_npc_gamma_sequer_basic_lindy',2),
(2,'Thelodica','roamer_02','def_npc_gamma_symbiont_basic_lindy',1),
(2,'Thelodica','roamer_02','def_npc_gamma_termis_basic_lindy',2),
(2,'Thelodica','roamer_02','def_npc_gamma_seth_tank_l4',2),
(2,'Thelodica','roamer_02','def_npc_gamma_artemis_tank_l4',2),
(2,'Thelodica','roamer_02','def_npc_gamma_zenith_armor_l4',2),
(2,'Thelodica','roamer_02','def_npc_gamma_prometheus_speed_l4',2),
(2,'Thelodica','roamer_03','def_npc_gamma_baphomet_dps_l4',3),
(2,'Thelodica','roamer_03','def_npc_gamma_zenith_armor_l4',2),
(2,'Thelodica','roamer_03','def_npc_gamma_prometheus_dps_l4',3),
(2,'Thelodica','roamer_04','def_npc_gamma_seth_dps_l4',3),
(2,'Thelodica','roamer_04','def_npc_gamma_prometheus_speed_l4',2),
(2,'Thelodica','roamer_04','def_npc_gamma_baphomet_speed_l4',3),
(2,'Thelodica','roamer_05','def_npc_gamma_artemis_dps_l4',3),
(2,'Thelodica','roamer_05','def_npc_gamma_zenith_armor_l4',2),
(2,'Thelodica','roamer_05','def_npc_gamma_prometheus_dps_l4',3),
(2,'Thelodica','roamer_06','def_npc_gamma_prometheus_speed_l4',2),
(2,'Thelodica','roamer_06','def_npc_gamma_baphomet_speed_l4',3),
(2,'Thelodica','roamer_06','def_npc_gamma_intakt_shield_l4',2),
(2,'Thelodica','roamer_06','def_npc_gamma_artemis_dps_l4',3),
(2,'Thelodica','roamer_07','def_npc_gamma_prometheus_speed_l4',2),
(2,'Thelodica','roamer_07','def_npc_gamma_intakt_shield_l4',2),
(2,'Thelodica','roamer_07','def_npc_gamma_baphomet_dps_l4',2),
(2,'Thelodica','roamer_08','def_npc_gamma_seth_dps_l4',2),
(2,'Thelodica','roamer_08','def_npc_gamma_artemis_dps_l4',5),
(2,'Thelodica','roamer_08','def_npc_gamma_intakt_armor_l4',3),
(2,'Thelodica','roamer_08','def_npc_gamma_prometheus_dps_l4',2),
(2,'Thelodica','roamer_09','def_npc_gamma_sequer_basic_lindy',1),
(2,'Thelodica','roamer_09','def_npc_gamma_gargoyle_basic_lindy',1),
(2,'Thelodica','roamer_09','def_npc_gamma_termis_basic_lindy',1),
(2,'Thelodica','roamer_09','def_npc_gamma_baphomet_speed_l3',2),
(2,'Thelodica','observer_01','def_npc_gamma_seth_advanced_observer',1),
(2,'Thelodica','observer_01','def_npc_gamma_zenith_advanced_observer',1),
(2,'Thelodica','observer_02','def_npc_gamma_artemis_advanced_observer',1),
(2,'Thelodica','observer_02','def_npc_gamma_zenith_advanced_observer',1),
(2,'Thelodica','courier_01','def_npc_gamma_baphomet_advanced_courier',1),
(2,'Thelodica','courier_01','def_npc_gamma_intakt_advanced_courier',1),
(2,'Thelodica','courier_01','def_npc_gamma_sequer_advanced_courier',2),
(2,'Thelodica','courier_02','def_npc_gamma_prometheus_advanced_courier',2),
(2,'Thelodica','courier_02','def_npc_gamma_ikarus_advanced_courier',1),

(1,'Thelodica','roamer_01','def_npc_gamma_artemis_dps_l3',2),
(1,'Thelodica','roamer_01','def_npc_gamma_baphomet_dps_l3',4),
(1,'Thelodica','roamer_01','def_npc_gamma_intakt_shield_l3',3),
(1,'Thelodica','roamer_02','def_npc_gamma_sequer_basic_lindy',2),
(1,'Thelodica','roamer_02','def_npc_gamma_symbiont_basic_lindy',1),
(1,'Thelodica','roamer_02','def_npc_gamma_argano_basic_lindy',2),
(1,'Thelodica','roamer_02','def_npc_gamma_seth_tank_l3',1),
(1,'Thelodica','roamer_02','def_npc_gamma_artemis_tank_l3',3),
(1,'Thelodica','roamer_02','def_npc_gamma_zenith_armor_l3',1),
(1,'Thelodica','roamer_02','def_npc_gamma_intakt_armor_l3',2),
(1,'Thelodica','roamer_02','def_npc_gamma_prometheus_speed_l3',2),
(1,'Thelodica','roamer_03','def_npc_gamma_baphomet_dps_l3',4),
(1,'Thelodica','roamer_03','def_npc_gamma_zenith_armor_l3',2),
(1,'Thelodica','roamer_03','def_npc_gamma_prometheus_dps_l3',3),
(1,'Thelodica','roamer_04','def_npc_gamma_seth_dps_l3',3),
(1,'Thelodica','roamer_04','def_npc_gamma_prometheus_speed_l3',3),
(1,'Thelodica','roamer_04','def_npc_gamma_baphomet_speed_l3',4),
(1,'Thelodica','roamer_05','def_npc_gamma_artemis_dps_l3',3),
(1,'Thelodica','roamer_05','def_npc_gamma_zenith_armor_l3',1),
(1,'Thelodica','roamer_05','def_npc_gamma_intakt_armor_l3',1),
(1,'Thelodica','roamer_05','def_npc_gamma_prometheus_dps_l3',3),
(1,'Thelodica','roamer_06','def_npc_gamma_prometheus_speed_l3',3),
(1,'Thelodica','roamer_06','def_npc_gamma_baphomet_speed_l3',4),
(1,'Thelodica','roamer_06','def_npc_gamma_intakt_shield_l3',2),
(1,'Thelodica','roamer_06','def_npc_gamma_artemis_dps_l3',3),
(1,'Thelodica','roamer_07','def_npc_gamma_prometheus_speed_l3',2),
(1,'Thelodica','roamer_07','def_npc_gamma_intakt_shield_l3',2),
(1,'Thelodica','roamer_07','def_npc_gamma_baphomet_dps_l3',2),
(1,'Thelodica','roamer_08','def_npc_gamma_seth_dps_l3',2),
(1,'Thelodica','roamer_08','def_npc_gamma_artemis_dps_l3',5),
(1,'Thelodica','roamer_08','def_npc_gamma_intakt_armor_l3',2),
(1,'Thelodica','roamer_08','def_npc_gamma_prometheus_dps_l3',3),
(1,'Thelodica','roamer_09','def_npc_gamma_sequer_basic_lindy',1),
(1,'Thelodica','roamer_09','def_npc_gamma_laird_basic_lindy',1),
(1,'Thelodica','roamer_09','def_npc_gamma_argano_basic_lindy',1),
(1,'Thelodica','roamer_09','def_npc_gamma_baphomet_speed_l3',2),
(1,'Thelodica','roamer_09','def_npc_gamma_prometheus_speed_l3',1),
(1,'Thelodica','observer_01','def_npc_gamma_seth_advanced_observer',1),
(1,'Thelodica','observer_01','def_npc_gamma_artemis_advanced_observer',1),
(1,'Thelodica','observer_02','def_npc_gamma_artemis_advanced_observer',1),
(1,'Thelodica','observer_02','def_npc_gamma_zenith_advanced_observer',1),
(1,'Thelodica','courier_01','def_npc_gamma_baphomet_advanced_courier',1),
(1,'Thelodica','courier_01','def_npc_gamma_ikarus_advanced_courier',2),
(1,'Thelodica','courier_02','def_npc_gamma_prometheus_advanced_courier',1),
(1,'Thelodica','courier_02','def_npc_gamma_ikarus_advanced_courier',1),

(3,'Pelistal','roamer_01','def_npc_gamma_tyrannos_dps_l5',3),
(3,'Pelistal','roamer_01','def_npc_gamma_ictus_shield_l5',2),
(3,'Pelistal','roamer_01','def_npc_gamma_troiar_shield_l5',1),
(3,'Pelistal','roamer_02','def_npc_gamma_lithus_basic_lindy',1),
(3,'Pelistal','roamer_02','def_npc_gamma_symbiont_basic_lindy',1),
(3,'Pelistal','roamer_02','def_npc_gamma_gargoyle_basic_lindy',3),
(3,'Pelistal','roamer_02','def_npc_gamma_gropho_tank_l5',3),
(3,'Pelistal','roamer_02','def_npc_gamma_tyrannos_tank_l5',2),
(3,'Pelistal','roamer_02','def_npc_gamma_ictus_armor_l5',2),
(3,'Pelistal','roamer_02','def_npc_gamma_castel_speed_l5',2),
(3,'Pelistal','roamer_03','def_npc_gamma_waspish_dps_l5',3),
(3,'Pelistal','roamer_03','def_npc_gamma_troiar_armor_l5',2),
(3,'Pelistal','roamer_03','def_npc_gamma_castel_dps_l5',2),
(3,'Pelistal','roamer_04','def_npc_gamma_gropho_dps_l5',3),
(3,'Pelistal','roamer_04','def_npc_gamma_ictus_shield_l5',2),
(3,'Pelistal','roamer_04','def_npc_gamma_waspish_speed_l5',2),
(3,'Pelistal','roamer_05','def_npc_gamma_gropho_tank_l5',2),
(3,'Pelistal','roamer_05','def_npc_gamma_tyrannos_dps_l5',2),
(3,'Pelistal','roamer_05','def_npc_gamma_ictus_armor_l5',2),
(3,'Pelistal','roamer_05','def_npc_gamma_castel_dps_l5',2),
(3,'Pelistal','roamer_06','def_npc_gamma_castel_speed_l5',2),
(3,'Pelistal','roamer_06','def_npc_gamma_waspish_speed_l5',4),
(3,'Pelistal','roamer_06','def_npc_gamma_troiar_shield_l5',2),
(3,'Pelistal','roamer_06','def_npc_gamma_tyrannos_dps_l5',2),
(3,'Pelistal','roamer_07','def_npc_gamma_castel_speed_l5',2),
(3,'Pelistal','roamer_07','def_npc_gamma_troiar_shield_l5',2),
(3,'Pelistal','roamer_07','def_npc_gamma_waspish_dps_l5',2),
(3,'Pelistal','roamer_08','def_npc_gamma_gropho_dps_l5',2),
(3,'Pelistal','roamer_08','def_npc_gamma_tyrannos_dps_l5',4),
(3,'Pelistal','roamer_08','def_npc_gamma_troiar_shield_l5',1),
(3,'Pelistal','roamer_08','def_npc_gamma_castel_dps_l5',2),
(3,'Pelistal','roamer_09','def_npc_gamma_sequer_basic_lindy',1),
(3,'Pelistal','roamer_09','def_npc_gamma_argano_basic_lindy',3),
(3,'Pelistal','roamer_09','def_npc_gamma_termis_basic_lindy',1),
(3,'Pelistal','roamer_09','def_npc_gamma_waspish_speed_l5',1),
(3,'Pelistal','roamer_09','def_npc_gamma_tyrannos_dps_l5',1),
(3,'Pelistal','observer_01','def_npc_gamma_gropho_advanced_observer',1),
(3,'Pelistal','observer_01','def_npc_gamma_tyrannos_advanced_observer',2),
(3,'Pelistal','observer_01','def_npc_gamma_ictus_advanced_observer',1),
(3,'Pelistal','observer_02','def_npc_gamma_tyrannos_advanced_observer',1),
(3,'Pelistal','observer_02','def_npc_gamma_ictus_advanced_observer',1),
(3,'Pelistal','courier_01','def_npc_gamma_waspish_advanced_courier',1),
(3,'Pelistal','courier_01','def_npc_gamma_castel_advanced_courier',2),
(3,'Pelistal','courier_01','def_npc_gamma_sequer_advanced_courier',1),
(3,'Pelistal','courier_01','def_npc_gamma_ikarus_advanced_courier',1),
(3,'Pelistal','courier_02','def_npc_gamma_troiar_advanced_courier',1),
(3,'Pelistal','courier_02','def_npc_gamma_hermes_advanced_courier',1),

(2,'Pelistal','roamer_01','def_npc_gamma_tyrannos_dps_l4',2),
(2,'Pelistal','roamer_01','def_npc_gamma_gropho_dps_l4',1),
(2,'Pelistal','roamer_01','def_npc_gamma_waspish_dps_l4',3),
(2,'Pelistal','roamer_01','def_npc_gamma_troiar_shield_l4',3),
(2,'Pelistal','roamer_02','def_npc_gamma_sequer_basic_lindy',2),
(2,'Pelistal','roamer_02','def_npc_gamma_riveler_basic_lindy',1),
(2,'Pelistal','roamer_02','def_npc_gamma_gargoyle_basic_lindy',2),
(2,'Pelistal','roamer_02','def_npc_gamma_gropho_tank_l4',2),
(2,'Pelistal','roamer_02','def_npc_gamma_tyrannos_tank_l4',2),
(2,'Pelistal','roamer_02','def_npc_gamma_ictus_armor_l4',2),
(2,'Pelistal','roamer_02','def_npc_gamma_castel_speed_l4',2),
(2,'Pelistal','roamer_03','def_npc_gamma_waspish_dps_l4',3),
(2,'Pelistal','roamer_03','def_npc_gamma_ictus_armor_l4',2),
(2,'Pelistal','roamer_03','def_npc_gamma_castel_dps_l4',3),
(2,'Pelistal','roamer_04','def_npc_gamma_gropho_dps_l4',3),
(2,'Pelistal','roamer_04','def_npc_gamma_castel_speed_l4',2),
(2,'Pelistal','roamer_04','def_npc_gamma_waspish_speed_l4',3),
(2,'Pelistal','roamer_05','def_npc_gamma_tyrannos_dps_l4',3),
(2,'Pelistal','roamer_05','def_npc_gamma_ictus_armor_l4',2),
(2,'Pelistal','roamer_05','def_npc_gamma_castel_dps_l4',3),
(2,'Pelistal','roamer_06','def_npc_gamma_castel_speed_l4',2),
(2,'Pelistal','roamer_06','def_npc_gamma_waspish_speed_l4',3),
(2,'Pelistal','roamer_06','def_npc_gamma_troiar_shield_l4',2),
(2,'Pelistal','roamer_06','def_npc_gamma_tyrannos_dps_l4',3),
(2,'Pelistal','roamer_07','def_npc_gamma_castel_speed_l4',2),
(2,'Pelistal','roamer_07','def_npc_gamma_troiar_shield_l4',2),
(2,'Pelistal','roamer_07','def_npc_gamma_waspish_dps_l4',2),
(2,'Pelistal','roamer_08','def_npc_gamma_gropho_dps_l4',2),
(2,'Pelistal','roamer_08','def_npc_gamma_tyrannos_dps_l4',5),
(2,'Pelistal','roamer_08','def_npc_gamma_troiar_armor_l4',3),
(2,'Pelistal','roamer_08','def_npc_gamma_castel_dps_l4',2),
(2,'Pelistal','roamer_09','def_npc_gamma_sequer_basic_lindy',1),
(2,'Pelistal','roamer_09','def_npc_gamma_gargoyle_basic_lindy',1),
(2,'Pelistal','roamer_09','def_npc_gamma_termis_basic_lindy',1),
(2,'Pelistal','roamer_09','def_npc_gamma_waspish_speed_l3',2),
(2,'Pelistal','observer_01','def_npc_gamma_gropho_advanced_observer',1),
(2,'Pelistal','observer_01','def_npc_gamma_ictus_advanced_observer',1),
(2,'Pelistal','observer_02','def_npc_gamma_tyrannos_advanced_observer',1),
(2,'Pelistal','observer_02','def_npc_gamma_ictus_advanced_observer',1),
(2,'Pelistal','courier_01','def_npc_gamma_waspish_advanced_courier',1),
(2,'Pelistal','courier_01','def_npc_gamma_troiar_advanced_courier',1),
(2,'Pelistal','courier_01','def_npc_gamma_sequer_advanced_courier',2),
(2,'Pelistal','courier_02','def_npc_gamma_castel_advanced_courier',2),
(2,'Pelistal','courier_02','def_npc_gamma_ikarus_advanced_courier',1),

(1,'Pelistal','roamer_01','def_npc_gamma_tyrannos_dps_l3',2),
(1,'Pelistal','roamer_01','def_npc_gamma_waspish_dps_l3',4),
(1,'Pelistal','roamer_01','def_npc_gamma_troiar_shield_l3',3),
(1,'Pelistal','roamer_02','def_npc_gamma_sequer_basic_lindy',2),
(1,'Pelistal','roamer_02','def_npc_gamma_riveler_basic_lindy',1),
(1,'Pelistal','roamer_02','def_npc_gamma_laird_basic_lindy',2),
(1,'Pelistal','roamer_02','def_npc_gamma_gropho_tank_l3',1),
(1,'Pelistal','roamer_02','def_npc_gamma_tyrannos_tank_l3',3),
(1,'Pelistal','roamer_02','def_npc_gamma_ictus_armor_l3',1),
(1,'Pelistal','roamer_02','def_npc_gamma_troiar_armor_l3',2),
(1,'Pelistal','roamer_02','def_npc_gamma_castel_speed_l3',2),
(1,'Pelistal','roamer_03','def_npc_gamma_waspish_dps_l3',4),
(1,'Pelistal','roamer_03','def_npc_gamma_ictus_armor_l3',2),
(1,'Pelistal','roamer_03','def_npc_gamma_castel_dps_l3',3),
(1,'Pelistal','roamer_04','def_npc_gamma_gropho_dps_l3',3),
(1,'Pelistal','roamer_04','def_npc_gamma_castel_speed_l3',3),
(1,'Pelistal','roamer_04','def_npc_gamma_waspish_speed_l3',4),
(1,'Pelistal','roamer_05','def_npc_gamma_tyrannos_dps_l3',3),
(1,'Pelistal','roamer_05','def_npc_gamma_ictus_armor_l3',1),
(1,'Pelistal','roamer_05','def_npc_gamma_troiar_armor_l3',1),
(1,'Pelistal','roamer_05','def_npc_gamma_castel_dps_l3',3),
(1,'Pelistal','roamer_06','def_npc_gamma_castel_speed_l3',3),
(1,'Pelistal','roamer_06','def_npc_gamma_waspish_speed_l3',4),
(1,'Pelistal','roamer_06','def_npc_gamma_troiar_shield_l3',2),
(1,'Pelistal','roamer_06','def_npc_gamma_tyrannos_dps_l3',3),
(1,'Pelistal','roamer_07','def_npc_gamma_castel_speed_l3',2),
(1,'Pelistal','roamer_07','def_npc_gamma_troiar_shield_l3',2),
(1,'Pelistal','roamer_07','def_npc_gamma_waspish_dps_l3',2),
(1,'Pelistal','roamer_08','def_npc_gamma_gropho_dps_l3',2),
(1,'Pelistal','roamer_08','def_npc_gamma_tyrannos_dps_l3',5),
(1,'Pelistal','roamer_08','def_npc_gamma_troiar_armor_l3',2),
(1,'Pelistal','roamer_08','def_npc_gamma_castel_dps_l3',3),
(1,'Pelistal','roamer_09','def_npc_gamma_sequer_basic_lindy',1),
(1,'Pelistal','roamer_09','def_npc_gamma_laird_basic_lindy',1),
(1,'Pelistal','roamer_09','def_npc_gamma_argano_basic_lindy',1),
(1,'Pelistal','roamer_09','def_npc_gamma_waspish_speed_l3',2),
(1,'Pelistal','roamer_09','def_npc_gamma_castel_speed_l3',1),
(1,'Pelistal','observer_01','def_npc_gamma_gropho_advanced_observer',1),
(1,'Pelistal','observer_01','def_npc_gamma_tyrannos_advanced_observer',1),
(1,'Pelistal','observer_02','def_npc_gamma_tyrannos_advanced_observer',1),
(1,'Pelistal','observer_02','def_npc_gamma_ictus_advanced_observer',1),
(1,'Pelistal','courier_01','def_npc_gamma_waspish_advanced_courier',1),
(1,'Pelistal','courier_01','def_npc_gamma_ikarus_advanced_courier',2),
(1,'Pelistal','courier_02','def_npc_gamma_castel_advanced_courier',1),
(1,'Pelistal','courier_02','def_npc_gamma_ikarus_advanced_courier',1)
;


DROP TABLE IF EXISTS #NPC_PRES_AND_FLOCK_BY_ZONE;
CREATE TABLE #NPC_PRES_AND_FLOCK_BY_ZONE
(
	zoneId INT NOT NULL,
	fullName varchar(128) NULL, --the fully qualified name based on zone logic
	defname varchar(100) NOT NULL, --temp field used to gather definition id later
	flockmembercount int NULL --number of npc
);
INSERT INTO #NPC_PRES_AND_FLOCK_BY_ZONE(zoneId, fullName, defname, flockmembercount)
SELECT z.zoneId, CONCAT(t.presencename, '_z', z.zoneId), t.defname, t.flockmembercount
FROM #TMPNPC t
INNER JOIN #ZONES_BY_TIER_AND_FACTION z ON z.zonefaction=t.zonefaction AND z.zonetier=t.zonetier;


INSERT INTO #TMPNPCPRESENCE (name, spawnid, roamingrespawnseconds)
SELECT 
	DISTINCT fullName,
	(SELECT TOP 1 spawnid FROM zones WHERE id=zoneId),
	CASE
		WHEN fullname like '%courier%' THEN @courierRespawnTime
		WHEN fullname like '%observer%' THEN @observerRespawnTime
		ELSE @respawnTime
	END as roamingrespawnseconds
FROM #NPC_PRES_AND_FLOCK_BY_ZONE;


PRINT N'DELETE AND REINSERT FLOCKS AND PRESENCES';

--Delete the member flocks of the presences about to be deleted
DELETE FROM npcflock WHERE presenceid IN (
	SELECT id FROM dbo.npcpresence WHERE name IN (
		SELECT NAME FROM #TMPNPCPRESENCE));

--Delete the presences about to be replaced
DELETE FROM dbo.npcpresence WHERE name IN (SELECT NAME FROM #TMPNPCPRESENCE);


INSERT INTO dbo.npcpresence
SELECT name,topx,topy,bottomx,bottomy,note,spawnid,enabled,roaming,roamingrespawnseconds,presencetype,maxrandomflock,
	randomcenterx,randomcentery,randomradius,dynamiclifetime,isbodypull,isrespawnallowed,safebodypull,izgroupid,growthseconds 
FROM #TMPNPCPRESENCE;



DROP TABLE IF EXISTS #TMPNPCFLOCK;
CREATE TABLE #TMPNPCFLOCK
(
	name varchar(128) NOT NULL,
	presenceid int NULL,
	--presencename varchar(100) NOT NULL, --temp field used to gather presence id later
	flockmembercount int NULL, --number of npc
	definition int NOT NULL, --definition (of npc)
	defname varchar(100) NOT NULL, --temp field used to gather definition id later
	spawnoriginX int NOT NULL DEFAULT 0,
	spawnoriginY int NOT NULL DEFAULT 0,
	spawnrangeMin int NOT NULL DEFAULT 0,
	spawnrangeMax int NOT NULL DEFAULT 10,
	respawnseconds int NOT NULL DEFAULT 7200,
	totalspawncount int NOT NULL DEFAULT 0,	--set to 0 to allow respawning or something idk
	homerange int NOT NULL DEFAULT 50,
	note nvarchar(2000) NULL,
	respawnmultiplierlow float NULL DEFAULT 0.9,
	enabled bit NOT NULL DEFAULT 1,
	iscallforhelp bit NOT NULL DEFAULT 1,
	behaviorType int NOT NULL DEFAULT 2, --2=red
	npcSpecialType int NOT NULL DEFAULT 0
);
INSERT INTO #TMPNPCFLOCK (name, presenceid, flockmembercount, definition, defname, note, respawnseconds, behaviorType)
SELECT
	CONCAT(p.fullName, REPLACE(p.defname,'def_npc_gamma','')) as name,
	(SELECT TOP 1 n.id FROM dbo.npcpresence n WHERE n.name = p.fullName) AS presenceid,
	p.flockmembercount,
	(SELECT TOP 1 e.definition FROM dbo.entitydefaults e WHERE p.defname = e.definitionname) as definition,
	p.defname,
	'gamma npc' as note,
	CASE
		WHEN p.fullname like '%courier%' THEN @courierRespawnTime
		WHEN p.fullname like '%observer%' THEN @observerRespawnTime
		ELSE @respawnTime
	END as respawnseconds,
	CASE WHEN p.fullname like '%courier%' THEN 1 ELSE 2 END as behaviorType --Couriers orange
FROM #NPC_PRES_AND_FLOCK_BY_ZONE p;

DELETE FROM dbo.npcflock WHERE name IN (SELECT distinct name from #TMPNPCFLOCK)

INSERT INTO dbo.npcflock(name,presenceid,flockmembercount,definition,spawnoriginX,spawnoriginY,spawnrangeMin,spawnrangeMax,respawnseconds,
	totalspawncount,homerange,note,respawnmultiplierlow,enabled,iscallforhelp,behaviorType,npcSpecialType)
SELECT name,presenceid,flockmembercount,definition,spawnoriginX,spawnoriginY,spawnrangeMin,spawnrangeMax,respawnseconds,
	totalspawncount,homerange,note,respawnmultiplierlow,enabled,iscallforhelp,behaviorType,npcSpecialType 
FROM #TMPNPCFLOCK
;

DROP TABLE IF EXISTS #TMPNPCPRESENCE;
DROP TABLE IF EXISTS #TMPNPCFLOCK;
DROP TABLE IF EXISTS #TMPNPC;
DROP TABLE IF EXISTS #NPC_PRES_AND_FLOCK_BY_ZONE;
DROP TABLE IF EXISTS #ZONES_BY_TIER_AND_FACTION;

GO


PRINT N'31b_bosses_npc_pres_flocks__2021_11_03.sql';
USE [perpetuumsa]
GO

-------------------------------------------
-- T0 Gamma NPC bosses
-- flocks, pres, waves, the whole thing
-- Date modified: 2021/11/18
-------------------------------------------


DECLARE @behaviourType AS INT = 2;

DECLARE @respawnTime AS INT = (2*60*60);--2 HOURS
DECLARE @miniBossRespawnTime AS INT = (5*60*60);--5 HOURS
DECLARE @pitBossRespawnTime AS INT = (120*60*60);--120 HOURS

DECLARE @BOSS_WAVE_RANGE AS INT = 115;


DROP TABLE IF EXISTS #BOSS_LOCATIONS;
CREATE TABLE #BOSS_LOCATIONS(
	zoneid int,
	x int,
	y int,
	minibossLocation bit default 0
);
INSERT INTO #BOSS_LOCATIONS(zoneid, x, y) VALUES
(110, 1005, 1010),
(114, 966, 930),
(119, 1150, 990),
(131, 1020, 975);

INSERT INTO #BOSS_LOCATIONS(zoneid, x, y, minibossLocation) VALUES
(110, 980, 670, 1),
(114, 720, 1370, 1),
(119, 1430, 1350, 1),
(131, 830, 1280, 1);


DROP TABLE IF EXISTS #BOSS_CONFIGS;
CREATE TABLE #BOSS_CONFIGS(
	bossName varchar(128),
	respawnNoiseFactor float default 0.15,
	lootSplitFlag bit default 1,
	overrideRelations bit default 0,
	customAggressMessage varchar(255),
	customDeathMessage varchar(255),
	isAnnounced bit default 1,
);
INSERT INTO #BOSS_CONFIGS (bossName, customAggressMessage, customDeathMessage) VALUES
('def_npc_gamma_mesmer_boss_miniboss', '', ''),
('def_npc_gamma_felos_nuimqol_pitboss', '', ''),
('def_npc_gamma_seth_boss_miniboss', '', ''),
('def_npc_gamma_onyx_thelodica_pitboss', '', ''),
('def_npc_gamma_gropho_boss_miniboss', '', ''),
('def_npc_gamma_hydra_pelistal_pitboss', '', ''),
('def_npc_gamma_legatus_boss_miniboss', '', ''),
('def_npc_gamma_apollo_syndicate_syn_pitboss', '', '');


DROP TABLE IF EXISTS #WAVES;
CREATE TABLE #WAVES (
	targetFlockName VARCHAR(100),
	presenceName VARCHAR(100),
	npcDefName VARCHAR(100),
	numInFlock INT,
	thresh FLOAT
);
INSERT INTO #WAVES (targetFlockName, presenceName, npcDefName, numInFlock, thresh) VALUES
('miniboss_01_z131_mesmer_boss_miniboss', 'reinforce_miniboss_01_z131_wave0', 'def_npc_gamma_kain_dps_l6', 2, 0.1),
('miniboss_01_z131_mesmer_boss_miniboss', 'reinforce_miniboss_01_z131_wave0', 'def_npc_gamma_cameleon_shield_l6', 2, 0.1),
('miniboss_01_z131_mesmer_boss_miniboss', 'reinforce_miniboss_01_z131_wave1', 'def_npc_gamma_kain_tank_l7', 3, 0.4),
('miniboss_01_z131_mesmer_boss_miniboss', 'reinforce_miniboss_01_z131_wave1', 'def_npc_gamma_vagabond_armor_l7', 3, 0.4),
('miniboss_01_z131_mesmer_boss_miniboss', 'reinforce_miniboss_01_z131_wave2', 'def_npc_gamma_mesmer_dps_l7', 2, 0.6),
('miniboss_01_z131_mesmer_boss_miniboss', 'reinforce_miniboss_01_z131_wave2', 'def_npc_gamma_vagabond_armor_l7', 2, 0.6),
('miniboss_01_z131_mesmer_boss_miniboss', 'reinforce_miniboss_01_z131_wave2', 'def_npc_gamma_cameleon_shield_l7', 2, 0.6),

('pitboss_01_z131_felos_nuimqol_pitboss', 'reinforce_pitboss_01_z131_wave0', 'def_npc_gamma_kain_dps_l7', 2, 0.1),
('pitboss_01_z131_felos_nuimqol_pitboss', 'reinforce_pitboss_01_z131_wave0', 'def_npc_gamma_cameleon_shield_l7', 3, 0.1),
('pitboss_01_z131_felos_nuimqol_pitboss', 'reinforce_pitboss_01_z131_wave0', 'def_npc_pbs_turret_em_level0', 1, 0.1),
('pitboss_01_z131_felos_nuimqol_pitboss', 'reinforce_pitboss_01_z131_wave1', 'def_npc_gamma_kain_tank_l7', 3, 0.4),
('pitboss_01_z131_felos_nuimqol_pitboss', 'reinforce_pitboss_01_z131_wave1', 'def_npc_gamma_vagabond_armor_l7', 2, 0.4),
('pitboss_01_z131_felos_nuimqol_pitboss', 'reinforce_pitboss_01_z131_wave1', 'def_npc_gamma_cameleon_shield_l7', 2, 0.4),
('pitboss_01_z131_felos_nuimqol_pitboss', 'reinforce_pitboss_01_z131_wave1', 'def_npc_pbs_turret_em_level0', 1, 0.4),
('pitboss_01_z131_felos_nuimqol_pitboss', 'reinforce_pitboss_01_z131_wave1', 'def_npc_pbs_turret_ew_level0', 1, 0.4),
('pitboss_01_z131_felos_nuimqol_pitboss', 'reinforce_pitboss_01_z131_wave2', 'def_npc_gamma_mesmer_tank_l7', 3, 0.6),
('pitboss_01_z131_felos_nuimqol_pitboss', 'reinforce_pitboss_01_z131_wave2', 'def_npc_gamma_vagabond_shield_l7', 3, 0.6),
('pitboss_01_z131_felos_nuimqol_pitboss', 'reinforce_pitboss_01_z131_wave2', 'def_npc_gamma_cameleon_shield_l7', 2, 0.6),
('pitboss_01_z131_felos_nuimqol_pitboss', 'reinforce_pitboss_01_z131_wave2', 'def_npc_pbs_turret_em_level0', 2, 0.6),
('pitboss_01_z131_felos_nuimqol_pitboss', 'reinforce_pitboss_01_z131_wave2', 'def_npc_pbs_turret_ew_level0', 1, 0.6),

('miniboss_01_z119_seth_boss_miniboss', 'reinforce_miniboss_01_z119_wave0', 'def_npc_gamma_artemis_dps_l6', 3, 0.3),
('miniboss_01_z119_seth_boss_miniboss', 'reinforce_miniboss_01_z119_wave0', 'def_npc_gamma_intakt_shield_l6', 3, 0.3),
('miniboss_01_z119_seth_boss_miniboss', 'reinforce_miniboss_01_z119_wave1', 'def_npc_gamma_artemis_tank_l7', 4, 0.5),
('miniboss_01_z119_seth_boss_miniboss', 'reinforce_miniboss_01_z119_wave1', 'def_npc_gamma_zenith_armor_l7', 3, 0.5),
('miniboss_01_z119_seth_boss_miniboss', 'reinforce_miniboss_01_z119_wave2', 'def_npc_gamma_seth_dps_l7', 2, 0.7),
('miniboss_01_z119_seth_boss_miniboss', 'reinforce_miniboss_01_z119_wave2', 'def_npc_gamma_zenith_shield_l7', 3, 0.7),
('miniboss_01_z119_seth_boss_miniboss', 'reinforce_miniboss_01_z119_wave2', 'def_npc_gamma_artemis_dps_l7', 2, 0.7),

('pitboss_01_z119_onyx_thelodica_pitboss', 'reinforce_pitboss_01_z119_wave0', 'def_npc_gamma_artemis_dps_l7', 2, 0.2),
('pitboss_01_z119_onyx_thelodica_pitboss', 'reinforce_pitboss_01_z119_wave0', 'def_npc_gamma_intakt_shield_l7', 3, 0.2),
('pitboss_01_z119_onyx_thelodica_pitboss', 'reinforce_pitboss_01_z119_wave0', 'def_npc_pbs_turret_laser_level0', 1, 0.2),
('pitboss_01_z119_onyx_thelodica_pitboss', 'reinforce_pitboss_01_z119_wave1', 'def_npc_gamma_artemis_tank_l7', 3, 0.4),
('pitboss_01_z119_onyx_thelodica_pitboss', 'reinforce_pitboss_01_z119_wave1', 'def_npc_gamma_zenith_armor_l7', 2, 0.4),
('pitboss_01_z119_onyx_thelodica_pitboss', 'reinforce_pitboss_01_z119_wave1', 'def_npc_gamma_intakt_shield_l7', 2, 0.4),
('pitboss_01_z119_onyx_thelodica_pitboss', 'reinforce_pitboss_01_z119_wave1', 'def_npc_pbs_turret_laser_level0', 1, 0.4),
('pitboss_01_z119_onyx_thelodica_pitboss', 'reinforce_pitboss_01_z119_wave1', 'def_npc_pbs_turret_ew_level0', 1, 0.4),
('pitboss_01_z119_onyx_thelodica_pitboss', 'reinforce_pitboss_01_z119_wave2', 'def_npc_gamma_seth_dps_l7', 3, 0.6),
('pitboss_01_z119_onyx_thelodica_pitboss', 'reinforce_pitboss_01_z119_wave2', 'def_npc_gamma_zenith_shield_l7', 3, 0.6),
('pitboss_01_z119_onyx_thelodica_pitboss', 'reinforce_pitboss_01_z119_wave2', 'def_npc_gamma_intakt_shield_l7', 2, 0.6),
('pitboss_01_z119_onyx_thelodica_pitboss', 'reinforce_pitboss_01_z119_wave2', 'def_npc_pbs_turret_laser_level0', 2, 0.6),
('pitboss_01_z119_onyx_thelodica_pitboss', 'reinforce_pitboss_01_z119_wave2', 'def_npc_pbs_turret_ew_level0', 1, 0.6),

('miniboss_01_z114_gropho_boss_miniboss', 'reinforce_miniboss_01_z114_wave0', 'def_npc_gamma_tyrannos_dps_l5', 4, 0.15),
('miniboss_01_z114_gropho_boss_miniboss', 'reinforce_miniboss_01_z114_wave0', 'def_npc_gamma_troiar_shield_l6', 4, 0.15),
('miniboss_01_z114_gropho_boss_miniboss', 'reinforce_miniboss_01_z114_wave1', 'def_npc_gamma_tyrannos_tank_l6', 4, 0.35),
('miniboss_01_z114_gropho_boss_miniboss', 'reinforce_miniboss_01_z114_wave1', 'def_npc_gamma_ictus_shield_l6', 3, 0.35),
('miniboss_01_z114_gropho_boss_miniboss', 'reinforce_miniboss_01_z114_wave2', 'def_npc_gamma_gropho_dps_l6', 2, 0.65),
('miniboss_01_z114_gropho_boss_miniboss', 'reinforce_miniboss_01_z114_wave2', 'def_npc_gamma_ictus_shield_l6', 3, 0.65),
('miniboss_01_z114_gropho_boss_miniboss', 'reinforce_miniboss_01_z114_wave2', 'def_npc_gamma_tyrannos_tank_l6', 2, 0.65),
('miniboss_01_z114_gropho_boss_miniboss', 'reinforce_miniboss_01_z114_wave2', 'def_npc_gropho_miniboss_rank3', 1, 0.65),

('pitboss_01_z114_hydra_pelistal_pitboss', 'reinforce_pitboss_01_z114_wave0', 'def_npc_gamma_tyrannos_dps_l6', 4, 0.15),
('pitboss_01_z114_hydra_pelistal_pitboss', 'reinforce_pitboss_01_z114_wave0', 'def_npc_gamma_troiar_shield_l7', 4, 0.15),
('pitboss_01_z114_hydra_pelistal_pitboss', 'reinforce_pitboss_01_z114_wave0', 'def_npc_pbs_turret_missile_level0', 1, 0.15),
('pitboss_01_z114_hydra_pelistal_pitboss', 'reinforce_pitboss_01_z114_wave1', 'def_npc_gamma_tyrannos_tank_l6', 4, 0.35),
('pitboss_01_z114_hydra_pelistal_pitboss', 'reinforce_pitboss_01_z114_wave1', 'def_npc_gamma_ictus_shield_l7', 2, 0.35),
('pitboss_01_z114_hydra_pelistal_pitboss', 'reinforce_pitboss_01_z114_wave1', 'def_npc_gamma_troiar_shield_l7', 3, 0.35),
('pitboss_01_z114_hydra_pelistal_pitboss', 'reinforce_pitboss_01_z114_wave1', 'def_npc_pbs_turret_missile_level0', 1, 0.35),
('pitboss_01_z114_hydra_pelistal_pitboss', 'reinforce_pitboss_01_z114_wave1', 'def_npc_pbs_turret_ew_level0', 1, 0.35),
('pitboss_01_z114_hydra_pelistal_pitboss', 'reinforce_pitboss_01_z114_wave2', 'def_npc_gamma_gropho_tank_l6', 5, 0.65),
('pitboss_01_z114_hydra_pelistal_pitboss', 'reinforce_pitboss_01_z114_wave2', 'def_npc_gamma_ictus_shield_l7', 4, 0.65),
('pitboss_01_z114_hydra_pelistal_pitboss', 'reinforce_pitboss_01_z114_wave2', 'def_npc_gamma_troiar_shield_l7', 3, 0.65),
('pitboss_01_z114_hydra_pelistal_pitboss', 'reinforce_pitboss_01_z114_wave2', 'def_npc_pbs_turret_missile_level0', 2, 0.65),
('pitboss_01_z114_hydra_pelistal_pitboss', 'reinforce_pitboss_01_z114_wave2', 'def_npc_pbs_turret_ew_level0', 1, 0.65),

('miniboss_01_z110_legatus_boss_miniboss', 'reinforce_miniboss_01_z110_wave0', 'def_npc_gamma_echelon_dps_l6', 2, 0.3),
('miniboss_01_z110_legatus_boss_miniboss', 'reinforce_miniboss_01_z110_wave0', 'def_npc_gamma_helix_shield_l6', 2, 0.3),
('miniboss_01_z110_legatus_boss_miniboss', 'reinforce_miniboss_01_z110_wave1', 'def_npc_gamma_echelon_tank_l7', 3, 0.5),
('miniboss_01_z110_legatus_boss_miniboss', 'reinforce_miniboss_01_z110_wave1', 'def_npc_gamma_callisto_shield_l7', 3, 0.5),
('miniboss_01_z110_legatus_boss_miniboss', 'reinforce_miniboss_01_z110_wave2', 'def_npc_gamma_legatus_dps_l7', 2, 0.7),
('miniboss_01_z110_legatus_boss_miniboss', 'reinforce_miniboss_01_z110_wave2', 'def_npc_gamma_callisto_armor_l7', 2, 0.7),
('miniboss_01_z110_legatus_boss_miniboss', 'reinforce_miniboss_01_z110_wave2', 'def_npc_gamma_echelon_dps_l7', 2, 0.7),
('miniboss_01_z110_legatus_boss_miniboss', 'reinforce_miniboss_01_z110_wave2', 'def_npc_gamma_helix_shield_l7', 2, 0.7),

('pitboss_01_z110_apollo_syndicate_syn_pitboss', 'reinforce_pitboss_01_z110_wave0', 'def_npc_gamma_echelon_dps_l6', 2, 0.2),
('pitboss_01_z110_apollo_syndicate_syn_pitboss', 'reinforce_pitboss_01_z110_wave0', 'def_npc_gamma_helix_shield_l7', 3, 0.2),
('pitboss_01_z110_apollo_syndicate_syn_pitboss', 'reinforce_pitboss_01_z110_wave0', 'def_npc_pbs_turret_missile_level0', 1, 0.2),
('pitboss_01_z110_apollo_syndicate_syn_pitboss', 'reinforce_pitboss_01_z110_wave1', 'def_npc_gamma_echelon_tank_l6', 3, 0.4),
('pitboss_01_z110_apollo_syndicate_syn_pitboss', 'reinforce_pitboss_01_z110_wave1', 'def_npc_gamma_callisto_armor_l7', 2, 0.4),
('pitboss_01_z110_apollo_syndicate_syn_pitboss', 'reinforce_pitboss_01_z110_wave1', 'def_npc_gamma_helix_shield_l7', 2, 0.4),
('pitboss_01_z110_apollo_syndicate_syn_pitboss', 'reinforce_pitboss_01_z110_wave1', 'def_npc_pbs_turret_laser_level0', 1, 0.4),
('pitboss_01_z110_apollo_syndicate_syn_pitboss', 'reinforce_pitboss_01_z110_wave1', 'def_npc_pbs_turret_ew_level0', 1, 0.4),
('pitboss_01_z110_apollo_syndicate_syn_pitboss', 'reinforce_pitboss_01_z110_wave2', 'def_npc_gamma_legatus_tank_l7', 3, 0.6),
('pitboss_01_z110_apollo_syndicate_syn_pitboss', 'reinforce_pitboss_01_z110_wave2', 'def_npc_gamma_callisto_shield_l7', 3, 0.6),
('pitboss_01_z110_apollo_syndicate_syn_pitboss', 'reinforce_pitboss_01_z110_wave2', 'def_npc_gamma_helix_shield_l7', 2, 0.6),
('pitboss_01_z110_apollo_syndicate_syn_pitboss', 'reinforce_pitboss_01_z110_wave2', 'def_npc_pbs_turret_em_level0', 2, 0.6),
('pitboss_01_z110_apollo_syndicate_syn_pitboss', 'reinforce_pitboss_01_z110_wave2', 'def_npc_pbs_turret_ew_level0', 1, 0.6)
;


DROP TABLE IF EXISTS #ZONES_BY_TIER_AND_FACTION;
CREATE TABLE #ZONES_BY_TIER_AND_FACTION(
	zoneId INT NOT NULL,
	zonetier INT NOT NULL,
	zonefaction varchar(128) NOT NULL
);
INSERT INTO #ZONES_BY_TIER_AND_FACTION(zoneId, zonetier, zonefaction)
SELECT
	id,
	pbsTechLimit,
	CASE raceid
		WHEN 1 THEN 'Pelistal' 
		WHEN 2 THEN 'Nuimqol' 
		WHEN 3 THEN 'Thelodica' 
	END
FROM zones WHERE id > 105 AND name not like 'zone_gamma_tc_%'
AND id != 110;

INSERT INTO #ZONES_BY_TIER_AND_FACTION(zoneId, zonetier, zonefaction)
SELECT 110, 0, 'Syndicate';


DROP TABLE IF EXISTS #TMPNPCPRESENCE;
CREATE TABLE #TMPNPCPRESENCE
(
	name varchar(128) NOT NULL, --the FULL name
	topx int NOT NULL DEFAULT 800,
	topy int NOT NULL DEFAULT 800,
	bottomx int NOT NULL DEFAULT 1200,
	bottomy int NOT NULL DEFAULT 1200,
	note nvarchar(2000) NULL,
	spawnid int NULL,
	enabled bit NOT NULL DEFAULT 1,
	roaming bit NOT NULL DEFAULT 1,
	roamingrespawnseconds int NULL DEFAULT 0, --not important for non roamers
	presencetype int NOT NULL DEFAULT 0, --static nonroam
	maxrandomflock int NULL,
	randomcenterx int NULL,
	randomcentery int NULL,
	randomradius int NULL,
	dynamiclifetime int NULL,
	isbodypull bit NOT NULL DEFAULT 1,
	isrespawnallowed bit NOT NULL DEFAULT 1,
	safebodypull bit NOT NULL DEFAULT 1,
	izgroupid int NULL,
	growthseconds int NULL
);

DROP TABLE IF EXISTS #TMPNPC;
CREATE TABLE #TMPNPC
(
	zonetier INT NOT NULL,
	zonefaction varchar(128) NOT NULL,
	fullName varchar(128) NULL, --the fully qualified name based on zone logic
	presencename varchar(100) NOT NULL, --temp field used to gather presence id later
	defname varchar(100) NOT NULL, --temp field used to gather definition id later
	flockmembercount int NULL --number of npc
);
INSERT INTO #TMPNPC (zonetier,zonefaction,presencename,defname,flockmembercount)
VALUES

(0,'Nuimqol','miniboss_01','def_npc_gamma_mesmer_boss_miniboss',1),
(0,'Nuimqol','miniboss_01','def_npc_gamma_vagabond_shield_l7',2),
(0,'Nuimqol','miniboss_01','def_npc_gamma_kain_dps_l7',2),
(0,'Nuimqol','pitboss_01','def_npc_gamma_felos_nuimqol_pitboss',1),
(0,'Nuimqol','pitboss_01','def_npc_mesmer_miniboss_rank3',1),
(0,'Nuimqol','pitboss_01','def_npc_vagabond_miniboss_rank3',2),

(0,'Thelodica','miniboss_01','def_npc_gamma_seth_boss_miniboss',1),
(0,'Thelodica','miniboss_01','def_npc_gamma_zenith_shield_l7',2),
(0,'Thelodica','miniboss_01','def_npc_gamma_artemis_dps_l7',2),
(0,'Thelodica','pitboss_01','def_npc_gamma_onyx_thelodica_pitboss',1),
(0,'Thelodica','pitboss_01','def_npc_seth_miniboss_rank3',1),
(0,'Thelodica','pitboss_01','def_npc_zenith_miniboss_rank3',2),

(0,'Pelistal','miniboss_01','def_npc_gamma_gropho_boss_miniboss',1),
(0,'Pelistal','miniboss_01','def_npc_gamma_ictus_shield_l7',2),
(0,'Pelistal','miniboss_01','def_npc_gamma_tyrannos_dps_l7',2),
(0,'Pelistal','pitboss_01','def_npc_gamma_hydra_pelistal_pitboss',1),
(0,'Pelistal','pitboss_01','def_npc_gropho_miniboss_rank3',1),
(0,'Pelistal','pitboss_01','def_npc_ictus_miniboss_rank3',2),

(0,'Syndicate','miniboss_01','def_npc_gamma_legatus_boss_miniboss',1),
(0,'Syndicate','miniboss_01','def_npc_gamma_callisto_shield_l7',2),
(0,'Syndicate','miniboss_01','def_npc_gamma_echelon_dps_l7',2),
(0,'Syndicate','pitboss_01','def_npc_gamma_apollo_syndicate_syn_pitboss',1),
(0,'Syndicate','pitboss_01','def_npc_gamma_legatus_advanced_observer',2),
(0,'Syndicate','pitboss_01','def_npc_gamma_callisto_advanced_observer',2)
;


DROP TABLE IF EXISTS #NPC_PRES_AND_FLOCK_BY_ZONE;
CREATE TABLE #NPC_PRES_AND_FLOCK_BY_ZONE
(
	zoneId INT NOT NULL,
	fullName varchar(128) NULL, --the fully qualified name based on zone logic
	defname varchar(100) NOT NULL, --temp field used to gather definition id later
	flockmembercount int NULL --number of npc
);
INSERT INTO #NPC_PRES_AND_FLOCK_BY_ZONE(zoneId, fullName, defname, flockmembercount)
SELECT z.zoneId, CONCAT(t.presencename, '_z', z.zoneId), t.defname, t.flockmembercount
FROM #TMPNPC t
INNER JOIN #ZONES_BY_TIER_AND_FACTION z ON z.zonefaction=t.zonefaction AND z.zonetier=t.zonetier;

--Boss presences
INSERT INTO #TMPNPCPRESENCE (name, spawnid, roaming, presencetype)
SELECT 
	DISTINCT fullName,
	(SELECT TOP 1 spawnid FROM zones WHERE id=zoneId),
	0, 0
FROM #NPC_PRES_AND_FLOCK_BY_ZONE;

PRINT N'DELETE AND REINSERT FLOCKS AND PRESENCES';

--Delete the member flocks of the presences about to be deleted
DELETE FROM npcflock WHERE presenceid IN (
	SELECT id FROM dbo.npcpresence WHERE name IN (
		SELECT NAME FROM #TMPNPCPRESENCE));

--Delete the presences about to be replaced
DELETE FROM dbo.npcpresence WHERE name IN (SELECT NAME FROM #TMPNPCPRESENCE);


INSERT INTO dbo.npcpresence
SELECT name,topx,topy,bottomx,bottomy,note,spawnid,enabled,roaming,roamingrespawnseconds,presencetype,maxrandomflock,
	randomcenterx,randomcentery,randomradius,dynamiclifetime,isbodypull,isrespawnallowed,safebodypull,izgroupid,growthseconds 
FROM #TMPNPCPRESENCE;



DROP TABLE IF EXISTS #TMPNPCFLOCK;
CREATE TABLE #TMPNPCFLOCK
(
	name varchar(128) NOT NULL,
	presenceid int NULL,
	--presencename varchar(100) NOT NULL, --temp field used to gather presence id later
	flockmembercount int NULL, --number of npc
	definition int NOT NULL, --definition (of npc)
	defname varchar(100) NOT NULL, --temp field used to gather definition id later
	spawnoriginX int NOT NULL DEFAULT 999,
	spawnoriginY int NOT NULL DEFAULT 999,
	spawnrangeMin int NOT NULL DEFAULT 1,
	spawnrangeMax int NOT NULL DEFAULT 15,
	respawnseconds int NOT NULL DEFAULT 1*24*60*60,
	totalspawncount int NOT NULL DEFAULT 0,	--set to 0 to allow respawning or something idk
	homerange int NOT NULL DEFAULT 90,
	note nvarchar(2000) NULL,
	respawnmultiplierlow float NULL DEFAULT 0.9,
	enabled bit NOT NULL DEFAULT 1,
	iscallforhelp bit NOT NULL DEFAULT 1,
	behaviorType int NOT NULL DEFAULT 2, --2=red
	npcSpecialType int NOT NULL DEFAULT 0
);
INSERT INTO #TMPNPCFLOCK (name,presenceid,flockmembercount,definition,defname,spawnoriginX,spawnoriginY,note,respawnseconds,behaviorType,npcSpecialType)
SELECT
	CONCAT(p.fullName, REPLACE(p.defname,'def_npc_gamma','')) as name,
	(SELECT TOP 1 n.id FROM dbo.npcpresence n WHERE n.name = p.fullName) AS presenceid,
	p.flockmembercount,
	(SELECT TOP 1 e.definition FROM dbo.entitydefaults e WHERE p.defname = e.definitionname) as definition,
	p.defname,
	z.x,
	z.y,
	'gamma boss npc' as note,
	CASE
		WHEN p.fullname like '%miniboss%' THEN @miniBossRespawnTime
		WHEN p.fullname like '%pitboss%' THEN @pitBossRespawnTime
		ELSE @respawnTime
	END as respawnseconds,
	2 as behaviorType,
	CASE WHEN p.defname in (select bossName from #BOSS_CONFIGS) THEN 1 ELSE 0 END as npcSpecialType --isboss?
FROM #NPC_PRES_AND_FLOCK_BY_ZONE p
JOIN #BOSS_LOCATIONS z ON z.zoneid=p.zoneId AND z.minibossLocation=CASE WHEN p.fullname like '%miniboss%' THEN 1 ELSE 0 END;



DELETE FROM dbo.npcflock WHERE name IN (SELECT distinct name from #TMPNPCFLOCK);

INSERT INTO dbo.npcflock(name,presenceid,flockmembercount,definition,spawnoriginX,spawnoriginY,spawnrangeMin,spawnrangeMax,respawnseconds,
	totalspawncount,homerange,note,respawnmultiplierlow,enabled,iscallforhelp,behaviorType,npcSpecialType)
SELECT name,presenceid,flockmembercount,definition,spawnoriginX,spawnoriginY,spawnrangeMin,spawnrangeMax,respawnseconds,
	totalspawncount,homerange,note,respawnmultiplierlow,enabled,iscallforhelp,behaviorType,npcSpecialType 
FROM #TMPNPCFLOCK
;

DELETE FROM dbo.npcbossinfo WHERE flockid IN (
	SELECT TOP 1 id FROM npcflock WHERE definition IN (
		SELECT definition FROM entitydefaults WHERE definitionname in (
			SELECT bossName FROM #BOSS_CONFIGS
		)
	)
);

INSERT INTO dbo.npcbossinfo(flockid, respawnNoiseFactor, lootSplitFlag, overrideRelations, customAggressMessage, customDeathMessage, isAnnounced)
SELECT (SELECT TOP 1 id FROM npcflock WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=bossName)),
	respawnNoiseFactor, lootSplitFlag, overrideRelations, customAggressMessage, customDeathMessage, isAnnounced
FROM #BOSS_CONFIGS;


PRINT N'DELETE npcflock, npcpresence, npcreinforcements IF EXISTS where data in temp table';
DELETE FROM npcflock WHERE presenceid in (SELECT id FROM npcpresence WHERE name in (SELECT DISTINCT presenceName FROM #WAVES));
DELETE FROM npcpresence WHERE name in (SELECT DISTINCT presenceName FROM #WAVES);
DELETE FROM npcreinforcements WHERE targetId in (SELECT id FROM npcflock WHERE name IN (SELECT DISTINCT targetFlockName from #WAVES));

DECLARE @reinforceType AS INT = (SELECT TOP 1 id FROM npcreinforcementtypes WHERE name='boss');
PRINT N'INSERT npcflock, npcpresence, npcreinforcements FROM #WAVES table';
INSERT INTO npcpresence 
	(name,topx,topy,bottomx,bottomy,note,spawnid,enabled,roaming,roamingrespawnseconds,presencetype,maxrandomflock,randomcenterx,randomcentery,randomradius,dynamiclifetime,isbodypull,isrespawnallowed,safebodypull,izgroupid)
SELECT DISTINCT 
	presenceName, 0, 0, 0, 0, presenceName, 10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL
FROM #WAVES;

INSERT INTO npcflock
	(name,presenceid,flockmembercount,definition,spawnoriginX,spawnoriginY,spawnrangeMin,spawnrangeMax,respawnseconds,totalspawncount,homerange,note,respawnmultiplierlow,enabled,iscallforhelp,behaviorType,npcSpecialType)
SELECT 
	presenceName+npcDefName, (SELECT id FROM npcpresence WHERE name=presenceName), numInFlock, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=npcDefName), 3, 15, 0, 10, 0, 1, @BOSS_WAVE_RANGE, presenceName+npcDefName, 0.5, 1, 1, @behaviourType, 0
FROM #WAVES;

INSERT INTO dbo.npcreinforcements
	(reinforcementType, targetId, threshold, presenceId, zoneId)
SELECT
	@reinforceType, (SELECT TOP 1 id FROM npcflock WHERE name=targetFlockName), thresh, (SELECT TOP 1 id FROM npcpresence WHERE name=presenceName), NULL
FROM #WAVES;



DROP TABLE IF EXISTS #TMPNPCPRESENCE;
DROP TABLE IF EXISTS #TMPNPCFLOCK;
DROP TABLE IF EXISTS #TMPNPC;
DROP TABLE IF EXISTS #NPC_PRES_AND_FLOCK_BY_ZONE;
DROP TABLE IF EXISTS #ZONES_BY_TIER_AND_FACTION;
DROP TABLE IF EXISTS #BOSS_CONFIGS;
DROP TABLE IF EXISTS #BOSS_LOCATIONS;
DROP TABLE IF EXISTS #WAVES;
GO

PRINT N'32_npcloots_step1__2021_11_01.sql';
USE [perpetuumsa]
GO

---------------------------------------
-- GAMMA NPC LOOTS part 1
-- L3-L7, N/P/T/S factions
-- Just basics, mods, kern/frag/plas
-- Date modified: 2021/11/02
---------------------------------------

DROP TABLE IF EXISTS #BOTS_BY_FACTION;
CREATE TABLE #BOTS_BY_FACTION(
	botName varchar(64),
	className varchar(64),
	faction varchar(64)
);
INSERT INTO #BOTS_BY_FACTION (botName, className, faction) VALUES
('apollo', 'destroyer', 'syndicate'),
('arbalest', 'assault', 'nuimqol'),
('artemis', 'mech', 'thelodica'),
('baphomet', 'assault', 'thelodica'),
('callisto', 'mech', 'syndicate'),
('cameleon', 'light ewar', 'nuimqol'),
('castel', 'light', 'pelistal'),
('cronus', 'assault indy', 'syndicate'),
('daidalos', 'mech indy', 'syndicate'),
('echelon', 'mech', 'syndicate'),
('felos', 'destroyer', 'nuimqol'),
('gargoyle', 'mech indy', 'industrial'),
('gropho', 'heavy mech', 'pelistal'),
('helix', 'light ewar', 'syndicate'),
('hermes', 'assault indy', 'syndicate'),
('hydra', 'destroyer', 'pelistal'),
('ictus', 'mech ewar', 'pelistal'),
('ikarus', 'light indy', 'syndicate'),
('intakt', 'light ewar', 'thelodica'),
('kain', 'mech', 'nuimqol'),
('laird', 'light indy', 'industrial'),
('legatus', 'heavy mech', 'syndicate'),
('lithus', 'heavy mech indy', 'industrial'),
('locust', 'assault', 'syndicate'),
('mesmer', 'heavy mech', 'nuimqol'),
('onyx', 'destroyer', 'thelodica'),
('prometheus', 'light', 'thelodica'),
('riveler', 'heavy mech indy', 'industrial'),
('scarab', 'heavy mech indy', 'industrial'),
('sequer', 'assault indy', 'industrial'),
('seth', 'heavy mech', 'thelodica'),
('symbiont', 'heavy mech indy', 'industrial'),
('termis', 'mech indy', 'industrial'),
('troiar', 'light ewar', 'pelistal'),
('tyrannos', 'mech', 'pelistal'),
('vagabond', 'mech', 'nuimqol'),
('vektor', 'light', 'syndicate'),
('waspish', 'assault', 'pelistal'),
('yagel', 'light', 'nuimqol'),
('zenith', 'mech ewar', 'thelodica');


DROP TABLE IF EXISTS #NPCS_BY_FACTION_BY_LEVEL;
CREATE TABLE #NPCS_BY_FACTION_BY_LEVEL(
	def int,
	npcName varchar(128),
	className varchar(64),
	faction varchar(64),
	levelName varchar(32)
);
INSERT INTO #NPCS_BY_FACTION_BY_LEVEL (def, npcName, className, faction, levelName)
SELECT d.definition, d.definitionname, f.className, f.faction, RIGHT(d.definitionname, CHARINDEX('_',REVERSE(d.definitionname))-1)
FROM entitydefaults d
JOIN #BOTS_BY_FACTION f ON d.definitionname like '%'+f.botName+'%'
WHERE definitionname like 'def_npc_gamma_%';

DROP TABLE IF EXISTS #LOOT_SHEET_OUTPUT_BASICS;
CREATE TABLE #LOOT_SHEET_OUTPUT_BASICS(
	faction varchar(64),
	levelName varchar(32),
	lootName varchar(128),
	heavyQuant int,
	mechQuant int,
	mechEwQuant int,
	assaultQuant int,
	lightEWQuant int,
	lightQuant int,
	prob float default 1.0
);
INSERT INTO #LOOT_SHEET_OUTPUT_BASICS (faction, levelName, lootName, heavyQuant, mechQuant, mechEwQuant, assaultQuant, lightEWQuant, lightQuant) VALUES
('thelodica','l7','def_thelodica_reactor_plasma',11128,8008,8008,1560,1560,832),
('thelodica','l7','def_kernel_thelodica',17472,9282,5642,7098,7098,3640),
('thelodica','l7','def_kernel_hitech',6240,5200,5200,2600,2600,1820),
('thelodica','l7','def_kernel_common',7488,3978,2418,3042,3042,1560),
('thelodica','l6','def_thelodica_reactor_plasma',7790,5606,5606,1092,1092,582),
('thelodica','l6','def_kernel_thelodica',12230,6497,3949,4969,4969,2548),
('thelodica','l6','def_kernel_hitech',4368,3640,3640,1820,1820,1274),
('thelodica','l6','def_kernel_common',5242,2785,1693,2129,2129,1092),
('thelodica','l5','def_thelodica_reactor_plasma',5564,4004,4004,780,780,416),
('thelodica','l5','def_kernel_thelodica',8736,4641,2821,3549,3549,1820),
('thelodica','l5','def_kernel_hitech',3120,2600,2600,1300,1300,910),
('thelodica','l5','def_kernel_common',3744,1989,1209,1521,1521,780),
('thelodica','l4','def_thelodica_reactor_plasma',4451,3203,3203,624,624,333),
('thelodica','l4','def_kernel_thelodica',6989,3713,2257,2839,2839,1456),
('thelodica','l4','def_kernel_hitech',2496,2080,2080,1040,1040,728),
('thelodica','l4','def_kernel_common',2995,1591,967,1217,1217,624),
('thelodica','l3','def_thelodica_reactor_plasma',3338,2402,2402,468,468,250),
('thelodica','l3','def_kernel_thelodica',5242,2785,1693,2129,2129,1092),
('thelodica','l3','def_kernel_hitech',1872,1560,1560,780,780,546),
('thelodica','l3','def_kernel_common',2246,1193,725,913,913,468),

('nuimqol','l7','def_nuimqol_reactor_plasma',11128,8008,8008,1560,1560,832),
('nuimqol','l7','def_kernel_nuimqol',17472,9282,5642,7098,7098,3640),
('nuimqol','l7','def_kernel_hitech',6240,5200,5200,2600,2600,1820),
('nuimqol','l7','def_kernel_common',7488,3978,2418,3042,3042,1560),
('nuimqol','l6','def_nuimqol_reactor_plasma',7790,5606,5606,1092,1092,582),
('nuimqol','l6','def_kernel_nuimqol',12230,6497,3949,4969,4969,2548),
('nuimqol','l6','def_kernel_hitech',4368,3640,3640,1820,1820,1274),
('nuimqol','l6','def_kernel_common',5242,2785,1693,2129,2129,1092),
('nuimqol','l5','def_nuimqol_reactor_plasma',5564,4004,4004,780,780,416),
('nuimqol','l5','def_kernel_nuimqol',8736,4641,2821,3549,3549,1820),
('nuimqol','l5','def_kernel_hitech',3120,2600,2600,1300,1300,910),
('nuimqol','l5','def_kernel_common',3744,1989,1209,1521,1521,780),
('nuimqol','l4','def_nuimqol_reactor_plasma',4451,3203,3203,624,624,333),
('nuimqol','l4','def_kernel_nuimqol',6989,3713,2257,2839,2839,1456),
('nuimqol','l4','def_kernel_hitech',2496,2080,2080,1040,1040,728),
('nuimqol','l4','def_kernel_common',2995,1591,967,1217,1217,624),
('nuimqol','l3','def_nuimqol_reactor_plasma',3338,2402,2402,468,468,250),
('nuimqol','l3','def_kernel_nuimqol',5242,2785,1693,2129,2129,1092),
('nuimqol','l3','def_kernel_hitech',1872,1560,1560,780,780,546),
('nuimqol','l3','def_kernel_common',2246,1193,725,913,913,468),

('pelistal','l7','def_pelistal_reactor_plasma',11128,8008,8008,1560,1560,832),
('pelistal','l7','def_kernel_pelistal',17472,9282,5642,7098,7098,3640),
('pelistal','l7','def_kernel_hitech',6240,5200,5200,2600,2600,1820),
('pelistal','l7','def_kernel_common',7488,3978,2418,3042,3042,1560),
('pelistal','l6','def_pelistal_reactor_plasma',7790,5606,5606,1092,1092,582),
('pelistal','l6','def_kernel_pelistal',12230,6497,3949,4969,4969,2548),
('pelistal','l6','def_kernel_hitech',4368,3640,3640,1820,1820,1274),
('pelistal','l6','def_kernel_common',5242,2785,1693,2129,2129,1092),
('pelistal','l5','def_pelistal_reactor_plasma',5564,4004,4004,780,780,416),
('pelistal','l5','def_kernel_pelistal',8736,4641,2821,3549,3549,1820),
('pelistal','l5','def_kernel_hitech',3120,2600,2600,1300,1300,910),
('pelistal','l5','def_kernel_common',3744,1989,1209,1521,1521,780),
('pelistal','l4','def_pelistal_reactor_plasma',4451,3203,3203,624,624,333),
('pelistal','l4','def_kernel_pelistal',6989,3713,2257,2839,2839,1456),
('pelistal','l4','def_kernel_hitech',2496,2080,2080,1040,1040,728),
('pelistal','l4','def_kernel_common',2995,1591,967,1217,1217,624),
('pelistal','l3','def_pelistal_reactor_plasma',3338,2402,2402,468,468,250),
('pelistal','l3','def_kernel_pelistal',5242,2785,1693,2129,2129,1092),
('pelistal','l3','def_kernel_hitech',1872,1560,1560,780,780,546),
('pelistal','l3','def_kernel_common',2246,1193,725,913,913,468),

('syndicate','l7','def_common_reactor_plasma',13354,9610,9610,1872,1872,998),
('syndicate','l7','def_kernel_common',22464,11934,7254,9126,9126,4680),
('syndicate','l7','def_kernel_hitech',12480,10400,10400,5200,5200,3640),
('syndicate','l6','def_common_reactor_plasma',9348,6727,6727,1310,1310,699),
('syndicate','l6','def_kernel_common',15725,8354,5078,6388,6388,3276),
('syndicate','l6','def_kernel_hitech',8736,7280,7280,3640,3640,2548),
('syndicate','l5','def_common_reactor_plasma',6677,4805,4805,936,936,499),
('syndicate','l5','def_kernel_common',11232,5967,3627,4563,4563,2340),
('syndicate','l5','def_kernel_hitech',6240,5200,5200,2600,2600,1820),
('syndicate','l4','def_common_reactor_plasma',5341,3844,3844,749,749,399),
('syndicate','l4','def_kernel_common',8986,4774,2902,3650,3650,1872),
('syndicate','l4','def_kernel_hitech',4992,4160,4160,2080,2080,1456),
('syndicate','l3','def_common_reactor_plasma',4006,2883,2883,562,562,300),
('syndicate','l3','def_kernel_common',6739,3580,2176,2738,2738,1404),
('syndicate','l3','def_kernel_hitech',3744,3120,3120,1560,1560,1092);

--frags
INSERT INTO #LOOT_SHEET_OUTPUT_BASICS (faction, levelName, lootName, heavyQuant, mechQuant, mechEwQuant, assaultQuant, lightEWQuant, lightQuant, prob) VALUES

('thelodica','l7','def_robotshard_thelodica_basic',49,29,68,33,20,46,0.5),
('thelodica','l7','def_robotshard_thelodica_advanced',49,49,49,33,33,33,0.5),
('thelodica','l7','def_robotshard_thelodica_expert',49,68,29,33,46,20,0.5),

('thelodica','l6','def_robotshard_thelodica_basic',34,20,48,23,14,32,0.5),
('thelodica','l6','def_robotshard_thelodica_advanced',34,34,34,23,23,23,0.5),
('thelodica','l6','def_robotshard_thelodica_expert',34,48,20,23,32,14,0.5),

('thelodica','l5','def_robotshard_thelodica_basic',25,15,34,17,10,23,0.5),
('thelodica','l5','def_robotshard_thelodica_advanced',25,25,25,17,17,17,0.5),
('thelodica','l5','def_robotshard_thelodica_expert',25,34,15,17,23,10,0.5),

('thelodica','l4','def_robotshard_thelodica_basic',20,12,27,13,8,18,0.5),
('thelodica','l4','def_robotshard_thelodica_advanced',20,20,20,13,13,13,0.5),
('thelodica','l4','def_robotshard_thelodica_expert',20,27,12,13,18,8,0.5),

('thelodica','l3','def_robotshard_thelodica_basic',15,9,20,10,6,14,0.5),
('thelodica','l3','def_robotshard_thelodica_advanced',15,15,15,10,10,10,0.5),
('thelodica','l3','def_robotshard_thelodica_expert',15,20,9,10,14,6,0.5),
--
('pelistal','l7','def_robotshard_pelistal_basic',49,29,68,33,20,46,0.5),
('pelistal','l7','def_robotshard_pelistal_advanced',49,49,49,33,33,33,0.5),
('pelistal','l7','def_robotshard_pelistal_expert',49,68,29,33,46,20,0.5),

('pelistal','l6','def_robotshard_pelistal_basic',34,20,48,23,14,32,0.5),
('pelistal','l6','def_robotshard_pelistal_advanced',34,34,34,23,23,23,0.5),
('pelistal','l6','def_robotshard_pelistal_expert',34,48,20,23,32,14,0.5),

('pelistal','l5','def_robotshard_pelistal_basic',25,15,34,17,10,23,0.5),
('pelistal','l5','def_robotshard_pelistal_advanced',25,25,25,17,17,17,0.5),
('pelistal','l5','def_robotshard_pelistal_expert',25,34,15,17,23,10,0.5),

('pelistal','l4','def_robotshard_pelistal_basic',20,12,27,13,8,18,0.5),
('pelistal','l4','def_robotshard_pelistal_advanced',20,20,20,13,13,13,0.5),
('pelistal','l4','def_robotshard_pelistal_expert',20,27,12,13,18,8,0.5),

('pelistal','l3','def_robotshard_pelistal_basic',15,9,20,10,6,14,0.5),
('pelistal','l3','def_robotshard_pelistal_advanced',15,15,15,10,10,10,0.5),
('pelistal','l3','def_robotshard_pelistal_expert',15,20,9,10,14,6,0.5),
--
('nuimqol','l7','def_robotshard_nuimqol_basic',49,29,68,33,20,46,0.5),
('nuimqol','l7','def_robotshard_nuimqol_advanced',49,49,49,33,33,33,0.5),
('nuimqol','l7','def_robotshard_nuimqol_expert',49,68,29,33,46,20,0.5),

('nuimqol','l6','def_robotshard_nuimqol_basic',34,20,48,23,14,32,0.5),
('nuimqol','l6','def_robotshard_nuimqol_advanced',34,34,34,23,23,23,0.5),
('nuimqol','l6','def_robotshard_nuimqol_expert',34,48,20,23,32,14,0.5),

('nuimqol','l5','def_robotshard_nuimqol_basic',25,15,34,17,10,23,0.5),
('nuimqol','l5','def_robotshard_nuimqol_advanced',25,25,25,17,17,17,0.5),
('nuimqol','l5','def_robotshard_nuimqol_expert',25,34,15,17,23,10,0.5),

('nuimqol','l4','def_robotshard_nuimqol_basic',20,12,27,13,8,18,0.5),
('nuimqol','l4','def_robotshard_nuimqol_advanced',20,20,20,13,13,13,0.5),
('nuimqol','l4','def_robotshard_nuimqol_expert',20,27,12,13,18,8,0.5),

('nuimqol','l3','def_robotshard_nuimqol_basic',15,9,20,10,6,14,0.5),
('nuimqol','l3','def_robotshard_nuimqol_advanced',15,15,15,10,10,10,0.5),
('nuimqol','l3','def_robotshard_nuimqol_expert',15,20,9,10,14,6,0.5),
--
('syndicate','l7','def_robotshard_common_basic',74,44,102,50,30,69,0.5),
('syndicate','l7','def_robotshard_common_advanced',74,74,74,50,50,50,0.5),
('syndicate','l7','def_robotshard_common_expert',74,102,44,50,69,30,0.5),

('syndicate','l6','def_robotshard_common_basic',51,30,72,35,21,48,0.5),
('syndicate','l6','def_robotshard_common_advanced',51,51,51,35,35,35,0.5),
('syndicate','l6','def_robotshard_common_expert',51,72,30,35,48,21,0.5),

('syndicate','l5','def_robotshard_common_basic',38,23,51,26,15,35,0.5),
('syndicate','l5','def_robotshard_common_advanced',38,38,38,26,26,26,0.5),
('syndicate','l5','def_robotshard_common_expert',38,51,23,26,35,15,0.5),

('syndicate','l4','def_robotshard_common_basic',30,18,41,20,12,27,0.5),
('syndicate','l4','def_robotshard_common_advanced',30,30,30,20,20,20,0.5),
('syndicate','l4','def_robotshard_common_expert',30,41,18,20,27,12,0.5),

('syndicate','l3','def_robotshard_common_basic',23,14,30,15,9,21,0.5),
('syndicate','l3','def_robotshard_common_advanced',23,23,23,15,15,15,0.5),
('syndicate','l3','def_robotshard_common_expert',23,30,14,15,21,9,0.5);

--shards
INSERT INTO #LOOT_SHEET_OUTPUT_BASICS (faction, levelName, lootName, heavyQuant, mechQuant, mechEwQuant, assaultQuant, lightEWQuant, lightQuant, prob) VALUES
('thelodica','l7','def_material_boss_gamma_thelodica',6,3,3,2,2,2,1.0),
('thelodica','l6','def_material_boss_gamma_thelodica',5,2,2,1,1,1,0.9),
('thelodica','l5','def_material_boss_gamma_thelodica',4,2,2,1,1,1,0.8),
('thelodica','l4','def_material_boss_gamma_thelodica',3,2,2,1,1,1,0.65),
('thelodica','l3','def_material_boss_gamma_thelodica',2,2,2,1,1,1,0.5),

('nuimqol','l7','def_material_boss_gamma_nuimqol',6,3,3,2,2,2,1.0),
('nuimqol','l6','def_material_boss_gamma_nuimqol',5,2,2,1,1,1,0.9),
('nuimqol','l5','def_material_boss_gamma_nuimqol',4,2,2,1,1,1,0.8),
('nuimqol','l4','def_material_boss_gamma_nuimqol',3,2,2,1,1,1,0.65),
('nuimqol','l3','def_material_boss_gamma_nuimqol',2,2,2,1,1,1,0.5),

('pelistal','l7','def_material_boss_gamma_pelistal',6,3,3,2,2,2,1.0),
('pelistal','l6','def_material_boss_gamma_pelistal',5,2,2,1,1,1,0.9),
('pelistal','l5','def_material_boss_gamma_pelistal',4,2,2,1,1,1,0.8),
('pelistal','l4','def_material_boss_gamma_pelistal',3,2,2,1,1,1,0.65),
('pelistal','l3','def_material_boss_gamma_pelistal',2,2,2,1,1,1,0.5),

('syndicate','l7','def_material_boss_gamma_syndicate',6,3,3,2,2,2,1.0),
('syndicate','l6','def_material_boss_gamma_syndicate',5,2,2,1,1,1,0.9),
('syndicate','l5','def_material_boss_gamma_syndicate',4,2,2,1,1,1,0.8),
('syndicate','l4','def_material_boss_gamma_syndicate',3,2,2,1,1,1,0.65),
('syndicate','l3','def_material_boss_gamma_syndicate',2,2,2,1,1,1,0.5);


DROP TABLE IF EXISTS #LOOT_SHEET_OUTPUT_BASICS_TRANSPOSED;
CREATE TABLE #LOOT_SHEET_OUTPUT_BASICS_TRANSPOSED(
	faction varchar(64),
	levelName varchar(32),
	className varchar(32),
	lootName varchar(128),
	minQuant int,
	maxQuant int,
	prob float default 1.0
);
INSERT INTO #LOOT_SHEET_OUTPUT_BASICS_TRANSPOSED (faction, levelName, className, lootName, minQuant, maxQuant, prob)
SELECT faction, levelName, 'light', lootName, CEILING(lightQuant*0.8), lightQuant, prob
FROM #LOOT_SHEET_OUTPUT_BASICS;

INSERT INTO #LOOT_SHEET_OUTPUT_BASICS_TRANSPOSED (faction, levelName, className, lootName, minQuant, maxQuant, prob)
SELECT faction, levelName, 'assault', lootName, CEILING(assaultQuant*0.8), assaultQuant, prob
FROM #LOOT_SHEET_OUTPUT_BASICS;

INSERT INTO #LOOT_SHEET_OUTPUT_BASICS_TRANSPOSED (faction, levelName, className, lootName, minQuant, maxQuant, prob)
SELECT faction, levelName, 'light ewar', lootName, CEILING(lightEWQuant*0.8), lightEWQuant, prob
FROM #LOOT_SHEET_OUTPUT_BASICS;

INSERT INTO #LOOT_SHEET_OUTPUT_BASICS_TRANSPOSED (faction, levelName, className, lootName, minQuant, maxQuant, prob)
SELECT faction, levelName, 'mech', lootName, CEILING(mechQuant*0.8), mechQuant, prob
FROM #LOOT_SHEET_OUTPUT_BASICS;

INSERT INTO #LOOT_SHEET_OUTPUT_BASICS_TRANSPOSED (faction, levelName, className, lootName, minQuant, maxQuant, prob)
SELECT faction, levelName, 'mech ewar', lootName, CEILING(mechEwQuant*0.8), mechEwQuant, prob
FROM #LOOT_SHEET_OUTPUT_BASICS;

INSERT INTO #LOOT_SHEET_OUTPUT_BASICS_TRANSPOSED (faction, levelName, className, lootName, minQuant, maxQuant, prob)
SELECT faction, levelName, 'heavy mech', lootName, CEILING(heavyQuant*0.8), heavyQuant, prob
FROM #LOOT_SHEET_OUTPUT_BASICS;

UPDATE #LOOT_SHEET_OUTPUT_BASICS_TRANSPOSED SET
	minQuant = 1
WHERE lootName LIKE 'def_robotshard_%';


DROP TABLE IF EXISTS #LOOT_SHEET_OUTPUT_MODULES;
CREATE TABLE #LOOT_SHEET_OUTPUT_MODULES(
	faction varchar(64),
	className varchar(32),
	lootName varchar(128),
	minQuant int,
	maxQuant int,
	level7prob float,
	level6prob float,
	level5prob float,
	level4prob float,
	level3prob float
);
INSERT INTO #LOOT_SHEET_OUTPUT_MODULES (faction, className, lootName, minQuant, maxQuant, level7prob, level6prob, level5prob, level4prob, level3prob) VALUES
--'Thelodica' 'Light','min' 'qty','max' 'qty','l7' 'chance','l6' 'chance','l5' 'chance','l4' 'chance','l3' 'chance'),
('thelodica','light', 'def_named3_kin_armor_hardener',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','light', 'def_named3_damage_mod_laser',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','light', 'def_named3_resistant_plating',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','light', 'def_named3_small_armor_plate',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','light', 'def_named3_small_laser',1,2,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','light', 'def_named2_kin_armor_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','light', 'def_named2_damage_mod_laser',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','light', 'def_named2_resistant_plating',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','light', 'def_named2_small_armor_plate',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','light', 'def_named2_small_laser',1,2,0.124,0.084,0.059,0.035,0.018),
('thelodica','light', 'def_named1_kin_armor_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('thelodica','light', 'def_named1_damage_mod_laser',1,1,0.165,0.125,0.088,0.053,0.027),
('thelodica','light', 'def_named1_resistant_plating',1,1,0.165,0.125,0.088,0.053,0.027),
('thelodica','light', 'def_named1_small_armor_plate',1,1,0.165,0.125,0.088,0.053,0.027),
('thelodica','light', 'def_named1_small_laser',1,2,0.165,0.125,0.088,0.053,0.027),
('thelodica','light', 'def_standard_kin_armor_hardener',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','light', 'def_standard_damage_mod_laser',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','light', 'def_standard_resistant_plating',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','light', 'def_standard_small_armor_plate',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','light', 'def_standard_small_laser',1,2,0.35,0.35,0.35,0.35,0.35),
('thelodica','light', 'def_ammo_small_lasercrystal_b',10,200,0.35,0.35,0.35,0.35,0.35),
('thelodica','light', 'def_ammo_small_lasercrystal_d',10,200,0.35,0.35,0.35,0.35,0.35),
('thelodica','light', 'def_named2_sensor_booster',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','light', 'def_named2_webber',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','light', 'def_named1_sensor_booster',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','light', 'def_named1_webber',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','light', 'def_named1_small_armor_repairer',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','light', 'def_standard_sensor_booster',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','light', 'def_standard_webber',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','light', 'def_standard_small_armor_repairer',1,1,0.35,0.35,0.35,0.35,0.35),
-- 'Thelodica' 'Medium' 'Combat','min' 'qty','max' 'qty','l7' 'chance','l6' 'chance','l5' 'chance','l4' 'chance','l3' 'chance'),
('thelodica','mech', 'def_named3_kin_armor_hardener',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','mech', 'def_named3_damage_mod_laser',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','mech', 'def_named3_resistant_plating',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','mech', 'def_named3_medium_armor_plate',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','mech', 'def_named2_kin_armor_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','mech', 'def_named2_resistant_plating',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','mech', 'def_named2_damage_mod_laser',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','mech', 'def_named2_medium_armor_plate',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','mech', 'def_named1_kin_armor_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('thelodica','mech', 'def_named1_damage_mod_laser',1,1,0.165,0.125,0.088,0.053,0.027),
('thelodica','mech', 'def_named1_resistant_plating',1,1,0.165,0.125,0.088,0.053,0.027),
('thelodica','mech', 'def_named1_medium_armor_plate',1,1,0.165,0.125,0.088,0.053,0.027),
('thelodica','mech', 'def_standard_tracking_upgrade',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','mech', 'def_standard_medium_armor_plate',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','mech', 'def_standard_resistant_plating',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','mech', 'def_named3_medium_laser',1,2,0.0495,0.0095,0.007,0.004,NULL),
('thelodica','mech', 'def_named3_longrange_medium_laser',1,2,0.0495,0.0095,0.007,0.004,NULL),
('thelodica','mech', 'def_named2_medium_laser',1,2,0.0992,0.0592,0.041,0.025,0.013),
('thelodica','mech', 'def_named2_longrange_medium_laser',1,2,0.0992,0.0592,0.041,0.025,0.013),
('thelodica','mech', 'def_named1_medium_laser',1,2,0.132,0.092,0.064,0.038,0.019),
('thelodica','mech', 'def_named1_longrange_medium_laser',1,2,0.132,0.092,0.064,0.038,0.019),
('thelodica','mech', 'def_standard_medium_laser',1,2,0.25,0.25,0.25,0.25,0.25),
('thelodica','mech', 'def_longrange_standard_medium_laser',1,2,0.25,0.25,0.25,0.25,0.25),
('thelodica','mech', 'def_ammo_medium_lasercrystal_b',8,120,0.35,0.35,0.35,0.35,0.35),
('thelodica','mech', 'def_ammo_medium_lasercrystal_d',8,120,0.35,0.35,0.35,0.35,0.35),
('thelodica','mech', 'def_named2_tracking_upgrade',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','mech', 'def_named2_sensor_booster',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','mech', 'def_named1_tracking_upgrade',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','mech', 'def_named1_sensor_booster',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','mech', 'def_named1_medium_armor_repairer',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','mech', 'def_standard_sensor_booster',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','mech', 'def_standard_medium_armor_repairer',1,1,0.35,0.35,0.35,0.35,0.35),

('thelodica','heavy mech', 'def_named3_kin_armor_hardener',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','heavy mech', 'def_named3_damage_mod_laser',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','heavy mech', 'def_named3_resistant_plating',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','heavy mech', 'def_named3_medium_armor_plate',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','heavy mech', 'def_named2_kin_armor_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','heavy mech', 'def_named2_resistant_plating',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','heavy mech', 'def_named2_damage_mod_laser',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','heavy mech', 'def_named2_medium_armor_plate',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','heavy mech', 'def_named1_kin_armor_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('thelodica','heavy mech', 'def_named1_damage_mod_laser',1,1,0.165,0.125,0.088,0.053,0.027),
('thelodica','heavy mech', 'def_named1_resistant_plating',1,1,0.165,0.125,0.088,0.053,0.027),
('thelodica','heavy mech', 'def_named1_medium_armor_plate',1,1,0.165,0.125,0.088,0.053,0.027),
('thelodica','heavy mech', 'def_standard_tracking_upgrade',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','heavy mech', 'def_standard_medium_armor_plate',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','heavy mech', 'def_standard_resistant_plating',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','heavy mech', 'def_named3_medium_laser',1,2,0.0495,0.0095,0.007,0.004,NULL),
('thelodica','heavy mech', 'def_named3_longrange_medium_laser',1,2,0.0495,0.0095,0.007,0.004,NULL),
('thelodica','heavy mech', 'def_named2_medium_laser',1,2,0.0992,0.0592,0.041,0.025,0.013),
('thelodica','heavy mech', 'def_named2_longrange_medium_laser',1,2,0.0992,0.0592,0.041,0.025,0.013),
('thelodica','heavy mech', 'def_named1_medium_laser',1,2,0.132,0.092,0.064,0.038,0.019),
('thelodica','heavy mech', 'def_named1_longrange_medium_laser',1,2,0.132,0.092,0.064,0.038,0.019),
('thelodica','heavy mech', 'def_standard_medium_laser',1,2,0.25,0.25,0.25,0.25,0.25),
('thelodica','heavy mech', 'def_longrange_standard_medium_laser',1,2,0.25,0.25,0.25,0.25,0.25),
('thelodica','heavy mech', 'def_ammo_medium_lasercrystal_b',8,120,0.35,0.35,0.35,0.35,0.35),
('thelodica','heavy mech', 'def_ammo_medium_lasercrystal_d',8,120,0.35,0.35,0.35,0.35,0.35),
('thelodica','heavy mech', 'def_named2_tracking_upgrade',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','heavy mech', 'def_named2_sensor_booster',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','heavy mech', 'def_named1_tracking_upgrade',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','heavy mech', 'def_named1_sensor_booster',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','heavy mech', 'def_named1_medium_armor_repairer',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','heavy mech', 'def_standard_sensor_booster',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','heavy mech', 'def_standard_medium_armor_repairer',1,1,0.35,0.35,0.35,0.35,0.35),

--'Thelodica' 'Small' 'EW','min' 'qty','max' 'qty','l7' 'chance','l6' 'chance','l5' 'chance','l4' 'chance','l3' 'chance'),
('thelodica','light ewar', 'def_named3_sensor_supressor_booster',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','light ewar', 'def_named3_sensor_dampener',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','light ewar', 'def_named2_sensor_dampener',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','light ewar', 'def_named2_sensor_supressor_booster',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','light ewar', 'def_named2_kin_armor_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','light ewar', 'def_named2_small_armor_plate',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','light ewar', 'def_named1_sensor_supressor_booster',1,1,0.165,0.125,0.088,0.053,0.027),
('thelodica','light ewar', 'def_named1_sensor_dampener',1,1,0.165,0.125,0.088,0.053,0.027),
('thelodica','light ewar', 'def_named1_kin_armor_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('thelodica','light ewar', 'def_named1_small_armor_plate',1,1,0.165,0.125,0.088,0.053,0.027),
('thelodica','light ewar', 'def_standard_kin_armor_hardener',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','light ewar', 'def_standard_small_armor_plate',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','light ewar', 'def_standard_sensor_supressor_booster',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','light ewar', 'def_standard_sensor_dampener',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','light ewar', 'def_named2_mass_reductor',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','light ewar', 'def_named2_webber',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','light ewar', 'def_named1_mass_reductor',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','light ewar', 'def_named1_webber',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','light ewar', 'def_named1_sensor_jammer',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','light ewar', 'def_standard_webber',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','light ewar', 'def_standard_sensor_jammer',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','light ewar', 'def_standard_mass_reductor',1,1,0.35,0.35,0.35,0.35,0.35),
--'Thelodica' 'Medium' 'EW','min' 'qty','max' 'qty','l7' 'chance','l6' 'chance','l5' 'chance','l4' 'chance','l3' 'chance'),
('thelodica','mech ewar', 'def_named3_sensor_supressor_booster',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','mech ewar', 'def_named3_sensor_dampener',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','mech ewar', 'def_named2_sensor_dampener',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','mech ewar', 'def_named2_sensor_supressor_booster',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','mech ewar', 'def_named2_kin_armor_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','mech ewar', 'def_named2_medium_armor_plate',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','mech ewar', 'def_named1_sensor_supressor_booster',1,1,0.165,0.125,0.088,0.053,0.027),
('thelodica','mech ewar', 'def_named1_sensor_dampener',1,1,0.165,0.125,0.088,0.053,0.027),
('thelodica','mech ewar', 'def_named1_kin_armor_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('thelodica','mech ewar', 'def_named1_medium_armor_plate',1,1,0.165,0.125,0.088,0.053,0.027),
('thelodica','mech ewar', 'def_standard_kin_armor_hardener',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','mech ewar', 'def_standard_medium_armor_plate',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','mech ewar', 'def_standard_sensor_supressor_booster',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','mech ewar', 'def_standard_sensor_dampener',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','mech ewar', 'def_named2_mass_reductor',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','mech ewar', 'def_named2_webber',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','mech ewar', 'def_named1_mass_reductor',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','mech ewar', 'def_named1_webber',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','mech ewar', 'def_named1_sensor_jammer',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','mech ewar', 'def_standard_webber',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','mech ewar', 'def_standard_sensor_jammer',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','mech ewar', 'def_standard_mass_reductor',1,1,0.35,0.35,0.35,0.35,0.35),
-- 'Nuimqol' 'Light','min' 'qty','max' 'qty','l7' 'chance','l6' 'chance','l5' 'chance','l4' 'chance','l3' 'chance'),
('nuimqol','light', 'def_named3_exp_armor_hardener',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','light', 'def_named3_damage_mod_railgun',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','light', 'def_named3_small_armor_repairer',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','light', 'def_named3_small_railgun',1,2,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','light', 'def_named2_exp_armor_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','light', 'def_named2_damage_mod_railgun',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','light', 'def_named2_small_armor_repairer',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','light', 'def_named2_small_railgun',1,2,0.124,0.084,0.059,0.035,0.018),
('nuimqol','light', 'def_named1_exp_armor_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('nuimqol','light', 'def_named1_damage_mod_railgun',1,1,0.165,0.125,0.088,0.053,0.027),
('nuimqol','light', 'def_named1_small_armor_repairer',1,1,0.165,0.125,0.088,0.053,0.027),
('nuimqol','light', 'def_named1_small_railgun',1,2,0.165,0.125,0.088,0.053,0.027),
('nuimqol','light', 'def_standard_exp_armor_hardener',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','light', 'def_standard_damage_mod_railgun',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','light', 'def_standard_small_armor_repairer',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','light', 'def_standard_small_railgun',1,2,0.35,0.35,0.35,0.35,0.35),
('nuimqol','light', 'def_ammo_small_railgun_a',10,150,0.35,0.35,0.35,0.35,0.35),
('nuimqol','light', 'def_ammo_small_railgun_d',10,150,0.35,0.35,0.35,0.35,0.35),
('nuimqol','light', 'def_named2_small_core_booster',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','light', 'def_named2_sensor_booster',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','light', 'def_named2_webber',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','light', 'def_named1_small_core_booster',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','light', 'def_named1_sensor_booster',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','light', 'def_named1_webber',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','light', 'def_named1_small_armor_plate',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','light', 'def_standard_sensor_booster',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','light', 'def_standard_webber',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','light', 'def_standard_small_core_booster',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','light', 'def_standard_small_armor_plate',1,1,0.35,0.35,0.35,0.35,0.35),
--'Nuimqol' 'Medium' 'Combat','min' 'qty','max' 'qty','l7' 'chance','l6' 'chance','l5' 'chance','l4' 'chance','l3' 'chance'),
('nuimqol','mech', 'def_named3_exp_armor_hardener',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','mech', 'def_named3_damage_mod_railgun',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','mech', 'def_named3_armor_repairer_upgrade',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','mech', 'def_named2_exp_armor_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','mech', 'def_named2_damage_mod_railgun',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','mech', 'def_named2_armor_repairer_upgrade',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','mech', 'def_named1_exp_armor_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('nuimqol','mech', 'def_named1_damage_mod_railgun',1,1,0.165,0.125,0.088,0.053,0.027),
('nuimqol','mech', 'def_named1_armor_repairer_upgrade',1,1,0.165,0.125,0.088,0.053,0.027),
('nuimqol','mech', 'def_standard_armor_repairer_upgrade',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','mech', 'def_standard_exp_armor_hardener',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','mech', 'def_standard_damage_mod_railgun',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','mech', 'def_named3_medium_railgun',1,2,0.0495,0.0095,0.007,0.004,NULL),
('nuimqol','mech', 'def_named3_longrange_medium_railgun',1,2,0.0495,0.0095,0.007,0.004,NULL),
('nuimqol','mech', 'def_named2_medium_railgun',1,2,0.0992,0.0592,0.041,0.025,0.013),
('nuimqol','mech', 'def_named2_longrange_medium_railgun',1,2,0.0992,0.0592,0.041,0.025,0.013),
('nuimqol','mech', 'def_named1_medium_railgun',1,2,0.132,0.092,0.064,0.038,0.019),
('nuimqol','mech', 'def_named1_longrange_medium_railgun',1,2,0.132,0.092,0.064,0.038,0.019),
('nuimqol','mech', 'def_standard_medium_railgun',1,2,0.25,0.25,0.25,0.25,0.25),
('nuimqol','mech', 'def_longrange_standard_medium_railgun',1,2,0.25,0.25,0.25,0.25,0.25),
('nuimqol','mech', 'def_ammo_medium_railgun_a',8,90,0.35,0.35,0.35,0.35,0.35),
('nuimqol','mech', 'def_ammo_medium_railgun_d',8,90,0.35,0.35,0.35,0.35,0.35),
('nuimqol','mech', 'def_named2_sensor_booster',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','mech', 'def_named2_medium_core_booster',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','mech', 'def_named1_sensor_booster',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','mech', 'def_named1_medium_armor_plate',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','mech', 'def_named1_resistant_plating',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','mech', 'def_named1_medium_core_booster',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','mech', 'def_standard_sensor_booster',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','mech', 'def_standard_medium_armor_plate',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','mech', 'def_standard_resistant_plating',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','mech', 'def_standard_medium_core_booster',1,1,0.35,0.35,0.35,0.35,0.35),

('nuimqol','heavy mech', 'def_named3_exp_armor_hardener',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','heavy mech', 'def_named3_damage_mod_railgun',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','heavy mech', 'def_named3_armor_repairer_upgrade',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','heavy mech', 'def_named2_exp_armor_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','heavy mech', 'def_named2_damage_mod_railgun',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','heavy mech', 'def_named2_armor_repairer_upgrade',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','heavy mech', 'def_named1_exp_armor_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('nuimqol','heavy mech', 'def_named1_damage_mod_railgun',1,1,0.165,0.125,0.088,0.053,0.027),
('nuimqol','heavy mech', 'def_named1_armor_repairer_upgrade',1,1,0.165,0.125,0.088,0.053,0.027),
('nuimqol','heavy mech', 'def_standard_armor_repairer_upgrade',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','heavy mech', 'def_standard_exp_armor_hardener',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','heavy mech', 'def_standard_damage_mod_railgun',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','heavy mech', 'def_named3_medium_railgun',1,2,0.0495,0.0095,0.007,0.004,NULL),
('nuimqol','heavy mech', 'def_named3_longrange_medium_railgun',1,2,0.0495,0.0095,0.007,0.004,NULL),
('nuimqol','heavy mech', 'def_named2_medium_railgun',1,2,0.0992,0.0592,0.041,0.025,0.013),
('nuimqol','heavy mech', 'def_named2_longrange_medium_railgun',1,2,0.0992,0.0592,0.041,0.025,0.013),
('nuimqol','heavy mech', 'def_named1_medium_railgun',1,2,0.132,0.092,0.064,0.038,0.019),
('nuimqol','heavy mech', 'def_named1_longrange_medium_railgun',1,2,0.132,0.092,0.064,0.038,0.019),
('nuimqol','heavy mech', 'def_standard_medium_railgun',1,2,0.25,0.25,0.25,0.25,0.25),
('nuimqol','heavy mech', 'def_longrange_standard_medium_railgun',1,2,0.25,0.25,0.25,0.25,0.25),
('nuimqol','heavy mech', 'def_ammo_medium_railgun_a',8,90,0.35,0.35,0.35,0.35,0.35),
('nuimqol','heavy mech', 'def_ammo_medium_railgun_d',8,90,0.35,0.35,0.35,0.35,0.35),
('nuimqol','heavy mech', 'def_named2_sensor_booster',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','heavy mech', 'def_named2_medium_core_booster',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','heavy mech', 'def_named1_sensor_booster',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','heavy mech', 'def_named1_medium_armor_plate',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','heavy mech', 'def_named1_resistant_plating',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','heavy mech', 'def_named1_medium_core_booster',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','heavy mech', 'def_standard_sensor_booster',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','heavy mech', 'def_standard_medium_armor_plate',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','heavy mech', 'def_standard_resistant_plating',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','heavy mech', 'def_standard_medium_core_booster',1,1,0.35,0.35,0.35,0.35,0.35),

-- 'Nuimqol' 'Small' 'EW','min' 'qty','max' 'qty','l7' 'chance','l6' 'chance','l5' 'chance','l4' 'chance','l3' 'chance'),
('nuimqol','light ewar', 'def_named3_ecm_booster',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','light ewar', 'def_named3_sensor_jammer',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','light ewar', 'def_named2_sensor_jammer',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','light ewar', 'def_named2_ecm_booster',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','light ewar', 'def_named2_exp_armor_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','light ewar', 'def_named2_small_armor_repairer',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','light ewar', 'def_named1_ecm_booster',1,1,0.165,0.125,0.088,0.053,0.027),
('nuimqol','light ewar', 'def_named1_sensor_jammer',1,1,0.165,0.125,0.088,0.053,0.027),
('nuimqol','light ewar', 'def_named1_exp_armor_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('nuimqol','light ewar', 'def_named1_small_armor_repairer',1,1,0.165,0.125,0.088,0.053,0.027),
('nuimqol','light ewar', 'def_standard_exp_armor_hardener',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','light ewar', 'def_standard_small_armor_repairer',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','light ewar', 'def_standard_ecm_booster',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','light ewar', 'def_standard_sensor_jammer',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','light ewar', 'def_named2_mass_reductor',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','light ewar', 'def_named2_webber',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','light ewar', 'def_named1_mass_reductor',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','light ewar', 'def_named1_webber',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','light ewar', 'def_named1_sensor_dampener',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','light ewar', 'def_standard_webber',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','light ewar', 'def_standard_sensor_dampener',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','light ewar', 'def_standard_mass_reductor',1,1,0.35,0.35,0.35,0.35,0.35),
-- 'Nuimqol' 'Medium' 'EW','min' 'qty','max' 'qty','l7' 'chance','l6' 'chance','l5' 'chance','l4' 'chance','l3' 'chance'),
('nuimqol','mech ewar', 'def_named3_ecm_booster',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','mech ewar', 'def_named3_sensor_jammer',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','mech ewar', 'def_named2_sensor_jammer',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','mech ewar', 'def_named2_ecm_booster',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','mech ewar', 'def_named2_exp_armor_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','mech ewar', 'def_named2_medium_armor_repairer',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','mech ewar', 'def_named1_ecm_booster',1,1,0.165,0.125,0.088,0.053,0.027),
('nuimqol','mech ewar', 'def_named1_sensor_jammer',1,1,0.165,0.125,0.088,0.053,0.027),
('nuimqol','mech ewar', 'def_named1_exp_armor_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('nuimqol','mech ewar', 'def_named1_medium_armor_repairer',1,1,0.165,0.125,0.088,0.053,0.027),
('nuimqol','mech ewar', 'def_standard_exp_armor_hardener',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','mech ewar', 'def_standard_medium_armor_repairer',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','mech ewar', 'def_standard_ecm_booster',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','mech ewar', 'def_standard_sensor_jammer',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','mech ewar', 'def_named2_mass_reductor',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','mech ewar', 'def_named2_webber',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','mech ewar', 'def_named1_mass_reductor',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','mech ewar', 'def_named1_webber',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','mech ewar', 'def_named1_sensor_dampener',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','mech ewar', 'def_standard_webber',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','mech ewar', 'def_standard_sensor_dampener',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','mech ewar', 'def_standard_mass_reductor',1,1,0.35,0.35,0.35,0.35,0.35),
--'Pelistal' 'Light','min' 'qty','max' 'qty','l7' 'chance','l6' 'chance','l5' 'chance','l4' 'chance','l3' 'chance'),
('pelistal','light', 'def_named3_thrm_armor_hardener',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','light', 'def_named3_damage_mod_missile',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','light', 'def_named3_small_shield_generator',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','light', 'def_named3_rocket_launcher',1,2,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','light', 'def_named2_thrm_armor_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','light', 'def_named2_damage_mod_missile',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','light', 'def_named2_small_shield_generator',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','light', 'def_named2_rocket_launcher',1,2,0.124,0.084,0.059,0.035,0.018),
('pelistal','light', 'def_named1_thrm_armor_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('pelistal','light', 'def_named1_damage_mod_missile',1,1,0.165,0.125,0.088,0.053,0.027),
('pelistal','light', 'def_named1_small_shield_generator',1,1,0.165,0.125,0.088,0.053,0.027),
('pelistal','light', 'def_named1_rocket_launcher',1,2,0.165,0.125,0.088,0.053,0.027),
('pelistal','light', 'def_standard_thrm_armor_hardener',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','light', 'def_standard_damage_mod_missile',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','light', 'def_standard_small_shield_generator',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','light', 'def_standard_rocket_launcher',1,2,0.35,0.35,0.35,0.35,0.35),
('pelistal','light', 'def_ammo_rocket_c',6,100,0.35,0.35,0.35,0.35,0.35),
('pelistal','light', 'def_ammo_rocket_d',6,100,0.35,0.35,0.35,0.35,0.35),
('pelistal','light', 'def_named2_small_core_battery',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','light', 'def_named2_sensor_booster',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','light', 'def_named2_webber',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','light', 'def_named1_small_core_battery',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','light', 'def_named1_sensor_booster',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','light', 'def_named1_webber',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','light', 'def_named1_small_armor_repairer',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','light', 'def_standard_sensor_booster',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','light', 'def_standard_webber',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','light', 'def_standard_small_core_battery',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','light', 'def_standard_small_armor_repairer',1,1,0.35,0.35,0.35,0.35,0.35),
--'Pelistal' 'Medium' 'Combat','min' 'qty','max' 'qty','l7' 'chance','l6' 'chance','l5' 'chance','l4' 'chance','l3' 'chance'),
('pelistal','mech', 'def_named3_thrm_armor_hardener',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','mech', 'def_named3_damage_mod_missile',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','mech', 'def_named3_shield_hardener',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','mech', 'def_named2_thrm_armor_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','mech', 'def_named2_damage_mod_missile',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','mech', 'def_named2_shield_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','mech', 'def_named1_thrm_armor_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('pelistal','mech', 'def_named1_damage_mod_missile',1,1,0.165,0.125,0.088,0.053,0.027),
('pelistal','mech', 'def_named1_shield_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('pelistal','mech', 'def_standard_shield_hardener',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','mech', 'def_named3_missile_launcher',1,2,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','mech', 'def_named2_missile_launcher',1,2,0.124,0.084,0.059,0.035,0.018),
('pelistal','mech', 'def_named1_missile_launcher',1,2,0.165,0.125,0.088,0.053,0.027),
('pelistal','mech', 'def_standard_missile_launcher',1,2,0.35,0.35,0.35,0.35,0.35),
('pelistal','mech', 'def_ammo_missile_d',4,35,0.35,0.35,0.35,0.35,0.35),
('pelistal','mech', 'def_ammo_longrange_missile_d',4,35,0.35,0.35,0.35,0.35,0.35),
('pelistal','mech', 'def_ammo_missile_c',4,35,0.35,0.35,0.35,0.35,0.35),
('pelistal','mech', 'def_ammo_longrange_missile_c',4,35,0.35,0.35,0.35,0.35,0.35),
('pelistal','mech', 'def_named2_sensor_booster',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','mech', 'def_named2_medium_core_battery',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','mech', 'def_named1_sensor_booster',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','mech', 'def_named1_medium_armor_repairer',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','mech', 'def_named1_resistant_plating',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','mech', 'def_named1_medium_core_battery',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','mech', 'def_standard_sensor_booster',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','mech', 'def_standard_medium_armor_repairer',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','mech', 'def_standard_resistant_plating',1,2,0.35,0.35,0.35,0.35,0.35),
('pelistal','mech', 'def_standard_medium_core_battery',1,1,0.35,0.35,0.35,0.35,0.35),

('pelistal','heavy mech', 'def_named3_thrm_armor_hardener',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','heavy mech', 'def_named3_damage_mod_missile',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','heavy mech', 'def_named3_shield_hardener',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','heavy mech', 'def_named2_thrm_armor_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','heavy mech', 'def_named2_damage_mod_missile',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','heavy mech', 'def_named2_shield_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','heavy mech', 'def_named1_thrm_armor_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('pelistal','heavy mech', 'def_named1_damage_mod_missile',1,1,0.165,0.125,0.088,0.053,0.027),
('pelistal','heavy mech', 'def_named1_shield_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('pelistal','heavy mech', 'def_standard_shield_hardener',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','heavy mech', 'def_named3_missile_launcher',1,2,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','heavy mech', 'def_named2_missile_launcher',1,2,0.124,0.084,0.059,0.035,0.018),
('pelistal','heavy mech', 'def_named1_missile_launcher',1,2,0.165,0.125,0.088,0.053,0.027),
('pelistal','heavy mech', 'def_standard_missile_launcher',1,2,0.35,0.35,0.35,0.35,0.35),
('pelistal','heavy mech', 'def_ammo_missile_d',4,35,0.35,0.35,0.35,0.35,0.35),
('pelistal','heavy mech', 'def_ammo_longrange_missile_d',4,35,0.35,0.35,0.35,0.35,0.35),
('pelistal','heavy mech', 'def_ammo_missile_c',4,35,0.35,0.35,0.35,0.35,0.35),
('pelistal','heavy mech', 'def_ammo_longrange_missile_c',4,35,0.35,0.35,0.35,0.35,0.35),
('pelistal','heavy mech', 'def_named2_sensor_booster',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','heavy mech', 'def_named2_medium_core_battery',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','heavy mech', 'def_named1_sensor_booster',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','heavy mech', 'def_named1_medium_armor_repairer',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','heavy mech', 'def_named1_resistant_plating',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','heavy mech', 'def_named1_medium_core_battery',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','heavy mech', 'def_standard_sensor_booster',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','heavy mech', 'def_standard_medium_armor_repairer',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','heavy mech', 'def_standard_resistant_plating',1,2,0.35,0.35,0.35,0.35,0.35),
('pelistal','heavy mech', 'def_standard_medium_core_battery',1,1,0.35,0.35,0.35,0.35,0.35),


--'Pelistal' 'Small' 'EW','min' 'qty','max' 'qty','l7' 'chance','l6' 'chance','l5' 'chance','l4' 'chance','l3' 'chance'),
('pelistal','light ewar', 'def_named3_energy_warfare_upgrade',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','light ewar', 'def_named3_small_energy_neutralizer',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','light ewar', 'def_named2_small_energy_neutralizer',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','light ewar', 'def_named2_energy_warfare_upgrade',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','light ewar', 'def_named2_thrm_armor_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','light ewar', 'def_named2_small_shield_generator',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','light ewar', 'def_named1_energy_warfare_upgrade',1,1,0.165,0.125,0.088,0.053,0.027),
('pelistal','light ewar', 'def_named1_small_energy_neutralizer',1,1,0.165,0.125,0.088,0.053,0.027),
('pelistal','light ewar', 'def_named1_thrm_armor_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('pelistal','light ewar', 'def_named1_small_shield_generator',1,1,0.165,0.125,0.088,0.053,0.027),
('pelistal','light ewar', 'def_standard_thrm_armor_hardener',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','light ewar', 'def_standard_small_shield_generator',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','light ewar', 'def_standard_energy_warfare_upgrade',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','light ewar', 'def_standard_small_energy_neutralizer',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','light ewar', 'def_named2_mass_reductor',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','light ewar', 'def_named2_webber',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','light ewar', 'def_named1_small_energy_vampire',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','light ewar', 'def_named1_mass_reductor',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','light ewar', 'def_named1_webber',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','light ewar', 'def_standard_webber',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','light ewar', 'def_standard_mass_reductor',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','light ewar', 'def_standard_small_energy_vampire',1,1,0.35,0.35,0.35,0.35,0.35),
--'Pelistal' 'Medium' 'EW','min' 'qty','max' 'qty','l7' 'chance','l6' 'chance','l5' 'chance','l4' 'chance','l3' 'chance'),
('pelistal','mech ewar', 'def_named3_energy_warfare_upgrade',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','mech ewar', 'def_named3_medium_energy_neutralizer',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','mech ewar', 'def_named2_energy_warfare_upgrade',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','mech ewar', 'def_named2_medium_energy_neutralizer',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','mech ewar', 'def_named2_thrm_armor_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','mech ewar', 'def_named2_medium_shield_generator',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','mech ewar', 'def_named1_energy_warfare_upgrade',1,1,0.165,0.125,0.088,0.053,0.027),
('pelistal','mech ewar', 'def_named1_medium_energy_neutralizer',1,1,0.165,0.125,0.088,0.053,0.027),
('pelistal','mech ewar', 'def_named1_thrm_armor_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('pelistal','mech ewar', 'def_named1_medium_shield_generator',1,1,0.165,0.125,0.088,0.053,0.027),
('pelistal','mech ewar', 'def_standard_thrm_armor_hardener',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','mech ewar', 'def_standard_medium_shield_generator',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','mech ewar', 'def_standard_energy_warfare_upgrade',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','mech ewar', 'def_standard_medium_energy_neutralizer',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','mech ewar', 'def_named2_mass_reductor',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','mech ewar', 'def_named2_webber',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','mech ewar', 'def_named1_medium_energy_vampire',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','mech ewar', 'def_named1_mass_reductor',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','mech ewar', 'def_named1_webber',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','mech ewar', 'def_standard_webber',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','mech ewar', 'def_standard_mass_reductor',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','mech ewar', 'def_standard_medium_energy_vampire',1,1,0.35,0.35,0.35,0.35,0.35),
--'Syndicate' 'Light','min' 'qty','max' 'qty','l7' 'chance','l6' 'chance','l5' 'chance','l4' 'chance','l3' 'chance'),
('syndicate','light', 'def_named3_webber',1,1,0.0825,0.0425,0.03,0.018,NULL),
('syndicate','light', 'def_named3_sensor_booster',1,1,0.0825,0.0425,0.03,0.018,NULL),
('syndicate','light', 'def_named3_chm_armor_hardener',1,1,0.0825,0.0425,0.03,0.018,NULL),
('syndicate','light', 'def_named3_damage_mod_projectile',1,1,0.0825,0.0425,0.03,0.018,NULL),
('syndicate','light', 'def_named3_maneuvering_upgrade',1,1,0.0825,0.0425,0.03,0.018,NULL),
('syndicate','light', 'def_named3_small_autocannon',1,2,0.0825,0.0425,0.03,0.018,NULL),
('syndicate','light', 'def_named2_webber',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','light', 'def_named2_sensor_booster',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','light', 'def_named2_chm_armor_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','light', 'def_named2_damage_mod_projectile',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','light', 'def_named2_maneuvering_upgrade',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','light', 'def_named2_small_autocannon',1,2,0.124,0.084,0.059,0.035,0.018),
('syndicate','light', 'def_named1_webber',1,1,0.165,0.125,0.088,0.053,0.027),
('syndicate','light', 'def_named1_sensor_booster',1,1,0.165,0.125,0.088,0.053,0.027),
('syndicate','light', 'def_named1_chm_armor_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('syndicate','light', 'def_named1_damage_mod_projectile',1,1,0.165,0.125,0.088,0.053,0.027),
('syndicate','light', 'def_named1_maneuvering_upgrade',1,1,0.165,0.125,0.088,0.053,0.027),
('syndicate','light', 'def_named1_small_autocannon',1,2,0.165,0.125,0.088,0.053,0.027),
('syndicate','light', 'def_standard_sensor_booster',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','light', 'def_standard_webber',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','light', 'def_standard_chm_armor_hardener',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','light', 'def_standard_damage_mod_projectile',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','light', 'def_standard_maneuvering_upgrade',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','light', 'def_standard_small_autocannon',1,2,0.35,0.35,0.35,0.35,0.35),
('syndicate','light', 'def_ammo_small_projectile_b',10,250,0.35,0.35,0.35,0.35,0.35),
('syndicate','light', 'def_ammo_small_projectile_d',10,250,0.35,0.35,0.35,0.35,0.35),
('syndicate','light', 'def_named1_small_armor_plate',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','light', 'def_named1_small_armor_repairer',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','light', 'def_standard_small_armor_plate',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','light', 'def_standard_small_armor_repairer',1,1,0.35,0.35,0.35,0.35,0.35),
--'Syndicate' 'Medium' 'Combat','min' 'qty','max' 'qty','l7' 'chance','l6' 'chance','l5' 'chance','l4' 'chance','l3' 'chance'),
('syndicate','mech', 'def_named3_chm_armor_hardener',1,1,0.0825,0.0425,0.03,0.018,NULL),
('syndicate','mech', 'def_named3_sensor_booster',1,1,0.0825,0.0425,0.03,0.018,NULL),
('syndicate','mech', 'def_named3_damage_mod_projectile',1,1,0.0825,0.0425,0.03,0.018,NULL),
('syndicate','mech', 'def_named2_chm_armor_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','mech', 'def_named2_sensor_booster',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','mech', 'def_named2_damage_mod_projectile',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','mech', 'def_named1_chm_armor_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('syndicate','mech', 'def_named1_sensor_booster',1,1,0.165,0.125,0.088,0.053,0.027),
('syndicate','mech', 'def_named1_damage_mod_projectile',1,1,0.165,0.125,0.088,0.053,0.027),
('syndicate','mech', 'def_standard_chm_armor_hardener',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','mech', 'def_standard_sensor_booster',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','mech', 'def_standard_damage_mod_projectile',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','mech', 'def_named3_medium_autocannon',1,2,0.0495,0.0095,0.007,0.004,NULL),
('syndicate','mech', 'def_named3_longrange_medium_autocannon',1,2,0.0495,0.0095,0.007,0.004,NULL),
('syndicate','mech', 'def_named2_medium_autocannon',1,2,0.0992,0.0592,0.041,0.025,0.013),
('syndicate','mech', 'def_named2_longrange_medium_autocannon',1,2,0.0992,0.0592,0.041,0.025,0.013),
('syndicate','mech', 'def_named1_medium_autocannon',1,2,0.132,0.092,0.064,0.038,0.019),
('syndicate','mech', 'def_named1_longrange_medium_autocannon',1,2,0.132,0.092,0.064,0.038,0.019),
('syndicate','mech', 'def_standard_medium_autocannon',1,2,0.25,0.25,0.25,0.25,0.25),
('syndicate','mech', 'def_longrange_standard_medium_autocannon',1,2,0.25,0.25,0.25,0.25,0.25),
('syndicate','mech', 'def_ammo_medium_projectile_b',8,160,0.35,0.35,0.35,0.35,0.35),
('syndicate','mech', 'def_ammo_medium_projectile_d',8,160,0.35,0.35,0.35,0.35,0.35),
('syndicate','mech', 'def_named1_armor_repairer_upgrade',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','mech', 'def_named1_medium_armor_plate',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','mech', 'def_named1_resistant_plating',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','mech', 'def_named1_medium_armor_repairer',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','mech', 'def_named1_tracking_upgrade',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','mech', 'def_standard_armor_repairer_upgrade',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','mech', 'def_standard_medium_armor_plate',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','mech', 'def_standard_resistant_plating',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','mech', 'def_standard_medium_armor_repairer',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','mech', 'def_standard_tracking_upgrade',1,1,0.35,0.35,0.35,0.35,0.35),

('syndicate','heavy mech', 'def_named3_chm_armor_hardener',1,1,0.0825,0.0425,0.03,0.018,NULL),
('syndicate','heavy mech', 'def_named3_sensor_booster',1,1,0.0825,0.0425,0.03,0.018,NULL),
('syndicate','heavy mech', 'def_named3_damage_mod_projectile',1,1,0.0825,0.0425,0.03,0.018,NULL),
('syndicate','heavy mech', 'def_named2_chm_armor_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','heavy mech', 'def_named2_sensor_booster',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','heavy mech', 'def_named2_damage_mod_projectile',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','heavy mech', 'def_named1_chm_armor_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('syndicate','heavy mech', 'def_named1_sensor_booster',1,1,0.165,0.125,0.088,0.053,0.027),
('syndicate','heavy mech', 'def_named1_damage_mod_projectile',1,1,0.165,0.125,0.088,0.053,0.027),
('syndicate','heavy mech', 'def_standard_chm_armor_hardener',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','heavy mech', 'def_standard_sensor_booster',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','heavy mech', 'def_standard_damage_mod_projectile',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','heavy mech', 'def_named3_medium_autocannon',1,2,0.0495,0.0095,0.007,0.004,NULL),
('syndicate','heavy mech', 'def_named3_longrange_medium_autocannon',1,2,0.0495,0.0095,0.007,0.004,NULL),
('syndicate','heavy mech', 'def_named2_medium_autocannon',1,2,0.0992,0.0592,0.041,0.025,0.013),
('syndicate','heavy mech', 'def_named2_longrange_medium_autocannon',1,2,0.0992,0.0592,0.041,0.025,0.013),
('syndicate','heavy mech', 'def_named1_medium_autocannon',1,2,0.132,0.092,0.064,0.038,0.019),
('syndicate','heavy mech', 'def_named1_longrange_medium_autocannon',1,2,0.132,0.092,0.064,0.038,0.019),
('syndicate','heavy mech', 'def_standard_medium_autocannon',1,2,0.25,0.25,0.25,0.25,0.25),
('syndicate','heavy mech', 'def_longrange_standard_medium_autocannon',1,2,0.25,0.25,0.25,0.25,0.25),
('syndicate','heavy mech', 'def_ammo_medium_projectile_b',8,160,0.35,0.35,0.35,0.35,0.35),
('syndicate','heavy mech', 'def_ammo_medium_projectile_d',8,160,0.35,0.35,0.35,0.35,0.35),
('syndicate','heavy mech', 'def_named1_armor_repairer_upgrade',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','heavy mech', 'def_named1_medium_armor_plate',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','heavy mech', 'def_named1_resistant_plating',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','heavy mech', 'def_named1_medium_armor_repairer',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','heavy mech', 'def_named1_tracking_upgrade',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','heavy mech', 'def_standard_armor_repairer_upgrade',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','heavy mech', 'def_standard_medium_armor_plate',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','heavy mech', 'def_standard_resistant_plating',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','heavy mech', 'def_standard_medium_armor_repairer',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','heavy mech', 'def_standard_tracking_upgrade',1,1,0.35,0.35,0.35,0.35,0.35),

--'Syndicate' 'Small' 'EW','min' 'qty','max' 'qty','l7' 'chance','l6' 'chance','l5' 'chance','l4' 'chance','l3' 'chance'),
('syndicate','light ewar', 'def_named3_maneuvering_upgrade',1,1,0.0825,0.0425,0.03,0.018,NULL),
('syndicate','light ewar', 'def_named3_mass_reductor',1,1,0.0825,0.0425,0.03,0.018,NULL),
('syndicate','light ewar', 'def_named3_webber',1,1,0.0825,0.0425,0.03,0.018,NULL),
('syndicate','light ewar', 'def_named2_webber',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','light ewar', 'def_named2_maneuvering_upgrade',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','light ewar', 'def_named2_mass_reductor',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','light ewar', 'def_named2_chm_armor_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','light ewar', 'def_named2_small_armor_repairer',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','light ewar', 'def_named1_maneuvering_upgrade',1,1,0.165,0.125,0.088,0.053,0.027),
('syndicate','light ewar', 'def_named1_webber',1,1,0.165,0.125,0.088,0.053,0.027),
('syndicate','light ewar', 'def_named1_mass_reductor',1,1,0.165,0.125,0.088,0.053,0.027),
('syndicate','light ewar', 'def_named1_chm_armor_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('syndicate','light ewar', 'def_named1_small_armor_repairer',1,1,0.165,0.125,0.088,0.053,0.027),
('syndicate','light ewar', 'def_standard_chm_armor_hardener',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','light ewar', 'def_standard_small_armor_repairer',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','light ewar', 'def_standard_maneuvering_upgrade',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','light ewar', 'def_standard_mass_reductor',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','light ewar', 'def_standard_webber',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','light ewar', 'def_named1_sensor_jammer',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','light ewar', 'def_named1_sensor_dampener',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','light ewar', 'def_standard_sensor_jammer',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','light ewar', 'def_standard_sensor_dampener',1,1,0.35,0.35,0.35,0.35,0.35),
--'Syndicate' 'Medium' 'EW','min' 'qty','max' 'qty','l7' 'chance','l6' 'chance','l5' 'chance','l4' 'chance','l3' 'chance'),
('syndicate','mech ewar', 'def_named3_blob_emission_modulator',1,1,0.0825,0.0425,0.03,0.018,NULL),
('syndicate','mech ewar', 'def_named3_mass_reductor',1,1,0.0825,0.0425,0.03,0.018,NULL),
('syndicate','mech ewar', 'def_named3_webber',1,1,0.0825,0.0425,0.03,0.018,NULL),
('syndicate','mech ewar', 'def_named2_mass_reductor',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','mech ewar', 'def_named2_webber',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','mech ewar', 'def_named2_blob_emission_modulator',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','mech ewar', 'def_named2_chm_armor_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','mech ewar', 'def_named1_mass_reductor',1,1,0.165,0.125,0.088,0.053,0.027),
('syndicate','mech ewar', 'def_named1_webber',1,1,0.165,0.125,0.088,0.053,0.027),
('syndicate','mech ewar', 'def_named1_blob_emission_modulator',1,1,0.165,0.125,0.088,0.053,0.027),
('syndicate','mech ewar', 'def_named1_chm_armor_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('syndicate','mech ewar', 'def_standard_chm_armor_hardener',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','mech ewar', 'def_standard_webber',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','mech ewar', 'def_standard_blob_emission_modulator',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','mech ewar', 'def_standard_mass_reductor',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','mech ewar', 'def_named1_medium_shield_generator',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','mech ewar', 'def_named1_sensor_dampener',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','mech ewar', 'def_named1_sensor_jammer',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','mech ewar', 'def_standard_medium_shield_generator',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','mech ewar', 'def_standard_sensor_jammer',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','mech ewar', 'def_standard_sensor_dampener',1,1,0.35,0.35,0.35,0.35,0.35)
;



DROP TABLE IF EXISTS #LOOT_BY_NPC;
CREATE TABLE #LOOT_BY_NPC(
	npcName varchar(128),
	lootName varchar(128),
	minQuant int,
	maxQuant int,
	prob float
);
INSERT INTO #LOOT_BY_NPC (npcName, lootName, minQuant, maxQuant, prob)
SELECT n.npcName, loot.lootName, loot.minQuant, loot.maxQuant, 1.0
FROM #NPCS_BY_FACTION_BY_LEVEL n
JOIN #LOOT_SHEET_OUTPUT_BASICS_TRANSPOSED loot ON
	loot.levelName=n.levelName AND loot.faction=n.faction AND loot.className=n.className;


INSERT INTO #LOOT_BY_NPC (npcName, lootName, minQuant, maxQuant, prob)
SELECT n.npcName, loot.lootName, loot.minQuant, loot.maxQuant, loot.level7prob
FROM #NPCS_BY_FACTION_BY_LEVEL n
JOIN #LOOT_SHEET_OUTPUT_MODULES loot ON loot.faction=n.faction AND loot.className=n.className
WHERE n.levelName='l7' AND loot.level7prob IS NOT NULL;

INSERT INTO #LOOT_BY_NPC (npcName, lootName, minQuant, maxQuant, prob)
SELECT n.npcName, loot.lootName, loot.minQuant, loot.maxQuant, loot.level6prob
FROM #NPCS_BY_FACTION_BY_LEVEL n
JOIN #LOOT_SHEET_OUTPUT_MODULES loot ON loot.faction=n.faction AND loot.className=n.className
WHERE n.levelName='l6' AND loot.level6prob IS NOT NULL;

INSERT INTO #LOOT_BY_NPC (npcName, lootName, minQuant, maxQuant, prob)
SELECT n.npcName, loot.lootName, loot.minQuant, loot.maxQuant, loot.level5prob
FROM #NPCS_BY_FACTION_BY_LEVEL n
JOIN #LOOT_SHEET_OUTPUT_MODULES loot ON loot.faction=n.faction AND loot.className=n.className
WHERE n.levelName='l5' AND loot.level5prob IS NOT NULL;

INSERT INTO #LOOT_BY_NPC (npcName, lootName, minQuant, maxQuant, prob)
SELECT n.npcName, loot.lootName, loot.minQuant, loot.maxQuant, loot.level4prob
FROM #NPCS_BY_FACTION_BY_LEVEL n
JOIN #LOOT_SHEET_OUTPUT_MODULES loot ON loot.faction=n.faction AND loot.className=n.className
WHERE n.levelName='l4' AND loot.level4prob IS NOT NULL;

INSERT INTO #LOOT_BY_NPC (npcName, lootName, minQuant, maxQuant, prob)
SELECT n.npcName, loot.lootName, loot.minQuant, loot.maxQuant, loot.level3prob
FROM #NPCS_BY_FACTION_BY_LEVEL n
JOIN #LOOT_SHEET_OUTPUT_MODULES loot ON loot.faction=n.faction AND loot.className=n.className
WHERE n.levelName='l3' AND loot.level3prob IS NOT NULL;


SELECT * FROM npcloot WHERE definition IN (
	SELECT definition FROM entitydefaults WHERE definitionname in (
		SELECT DISTINCT npcName FROM  #NPCS_BY_FACTION_BY_LEVEL
	)
);

DELETE FROM npcloot WHERE definition IN (
	SELECT definition FROM entitydefaults WHERE definitionname in (
		SELECT DISTINCT npcName FROM  #NPCS_BY_FACTION_BY_LEVEL
	)
);



MERGE [dbo].[npcloot] n USING #LOOT_BY_NPC loot
ON n.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=loot.npcName)
AND n.lootdefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=loot.lootName)
WHEN MATCHED
    THEN UPDATE SET
		n.minquantity = loot.minQuant,
		n.quantity = loot.maxQuant,
		n.probability = loot.prob,
		n.repackaged = 0,
		n.dontdamage = CASE WHEN lootName like '%named%' or lootName like '%standard%' THEN 0 ELSE 1 END
WHEN NOT MATCHED
    THEN INSERT (definition, lootdefinition, quantity, minquantity, probability, dontdamage, repackaged) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=loot.npcName),
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=loot.lootName),
	loot.maxQuant, loot.minQuant, loot.prob, CASE WHEN lootName like '%named%' or lootName like '%standard%' THEN 0 ELSE 1 END, 0);



DROP TABLE IF EXISTS #BOTS_BY_FACTION;
DROP TABLE IF EXISTS #LOOT_BY_NPC;
DROP TABLE IF EXISTS #LOOT_SHEET_OUTPUT_BASICS;
DROP TABLE IF EXISTS #LOOT_SHEET_OUTPUT_BASICS_TRANSPOSED;
DROP TABLE IF EXISTS #LOOT_SHEET_OUTPUT_MODULES;
DROP TABLE IF EXISTS #NPCS_BY_FACTION_BY_LEVEL;
GO


PRINT N'33_npcloots_step2__2021_11_04.sql';
USE [perpetuumsa]
GO

----------------------------------------------
-- Gamma NPC loots part 2: the bespoke ones
-- indy/courier/observer/mini/boss
-- Date modified: 2021/11/04
----------------------------------------------


DROP TABLE IF EXISTS #LOOTS;
CREATE TABLE #LOOTS(
	defName VARCHAR(128),
	lootName VARCHAR(128),
	minQuant INT,
	maxQuant INT,
	prob FLOAT
);
INSERT INTO #LOOTS (defName, lootName, minQuant, maxQuant, prob) VALUES
('def_npc_gamma_sequer_basic_lindy','def_kernel_industrial',6656,9984,1),
('def_npc_gamma_sequer_basic_lindy','def_kernel_common',3328,6656,1),
('def_npc_gamma_sequer_basic_lindy','def_kernel_hitech',1664,2496,1),
('def_npc_gamma_sequer_basic_lindy','def_common_reactor_plasma',3000,3600,1),
('def_npc_gamma_sequer_basic_lindy','def_robotshard_common_basic',8,84,0.5),
('def_npc_gamma_sequer_basic_lindy','def_robotshard_common_advanced',6,60,0.5),
('def_npc_gamma_sequer_basic_lindy','def_robotshard_common_expert',4,36,0.5),
('def_npc_gamma_sequer_basic_lindy','def_named3_shield_hardener',1,1,0.06),
('def_npc_gamma_sequer_basic_lindy','def_named3_small_shield_generator',1,1,0.06),
('def_npc_gamma_sequer_basic_lindy','def_named3_small_core_battery',1,1,0.06),
('def_npc_gamma_sequer_basic_lindy','def_named2_shield_hardener',1,1,0.088),
('def_npc_gamma_sequer_basic_lindy','def_named2_small_shield_generator',1,1,0.088),
('def_npc_gamma_sequer_basic_lindy','def_named2_small_core_battery',1,1,0.088),
('def_npc_gamma_sequer_basic_lindy','def_named1_shield_hardener',1,1,0.126),
('def_npc_gamma_sequer_basic_lindy','def_named1_small_shield_generator',1,1,0.126),
('def_npc_gamma_sequer_basic_lindy','def_named1_small_core_battery',1,1,0.126),
('def_npc_gamma_sequer_basic_lindy','def_standard_shield_hardener',1,1,0.25),
('def_npc_gamma_sequer_basic_lindy','def_standard_small_shield_generator',1,1,0.25),
('def_npc_gamma_sequer_basic_lindy','def_standard_small_core_battery',1,1,0.25),
('def_npc_gamma_sequer_basic_lindy','def_container_capsule',1,1,0.5),
('def_npc_gamma_sequer_basic_lindy','def_npc_egg_industrial_small_expert_capsule',1,1,0.3),
('def_npc_gamma_sequer_basic_lindy','def_npc_egg_industrial_small_miniboss3_capsule',1,1,0.1),
('def_npc_gamma_sequer_basic_lindy','def_epriton',5000,50000,0.15),
('def_npc_gamma_sequer_basic_lindy','def_stermonit',10000,100000,0.35),
('def_npc_gamma_sequer_basic_lindy','def_imentium',10000,100000,0.35),
('def_npc_gamma_sequer_basic_lindy','def_silgium',10000,100000,0.35),
('def_npc_gamma_sequer_basic_lindy','def_electroplant_fruit',2500,25000,0.15),
('def_npc_gamma_sequer_basic_lindy','def_helioptris',5000,50000,0.35),
('def_npc_gamma_sequer_basic_lindy','def_triandlus',5000,50000,0.35),
('def_npc_gamma_sequer_basic_lindy','def_prismocitae',5000,50000,0.35),


('def_npc_gamma_lithus_basic_lindy','def_kernel_industrial',16640,24960,1),
('def_npc_gamma_lithus_basic_lindy','def_kernel_common',8320,12480,1),
('def_npc_gamma_lithus_basic_lindy','def_kernel_hitech',1664,2496,1),
('def_npc_gamma_lithus_basic_lindy','def_common_reactor_plasma',9600,12000,1),
('def_npc_gamma_lithus_basic_lindy','def_robotshard_common_basic',12,120,0.5),
('def_npc_gamma_lithus_basic_lindy','def_robotshard_common_advanced',12,120,0.5),
('def_npc_gamma_lithus_basic_lindy','def_robotshard_common_expert',12,120,0.5),
('def_npc_gamma_lithus_basic_lindy','def_named3_shield_hardener',1,1,0.11),
('def_npc_gamma_lithus_basic_lindy','def_named3_medium_shield_generator',1,1,0.11),
('def_npc_gamma_lithus_basic_lindy','def_named3_medium_core_battery',1,1,0.11),
('def_npc_gamma_lithus_basic_lindy','def_named2_shield_hardener',1,1,0.125),
('def_npc_gamma_lithus_basic_lindy','def_named2_medium_shield_generator',1,1,0.125),
('def_npc_gamma_lithus_basic_lindy','def_named2_medium_core_battery',1,1,0.125),
('def_npc_gamma_lithus_basic_lindy','def_named1_shield_hardener',1,1,0.22),
('def_npc_gamma_lithus_basic_lindy','def_named1_medium_shield_generator',1,1,0.22),
('def_npc_gamma_lithus_basic_lindy','def_named1_medium_core_battery',1,1,0.22),
('def_npc_gamma_lithus_basic_lindy','def_standard_shield_hardener',1,1,0.25),
('def_npc_gamma_lithus_basic_lindy','def_standard_medium_shield_generator',1,1,0.25),
('def_npc_gamma_lithus_basic_lindy','def_standard_medium_core_battery',1,1,0.25),
('def_npc_gamma_lithus_basic_lindy','def_container_capsule',1,1,0.7),
('def_npc_gamma_lithus_basic_lindy','def_npc_egg_industrial_medium_advanced_capsule',1,1,0.3),
('def_npc_gamma_lithus_basic_lindy','def_npc_egg_industrial_medium_miniboss2_capsule',1,1,0.1),
('def_npc_gamma_lithus_basic_lindy','def_epriton',30000,300000,0.15),
('def_npc_gamma_lithus_basic_lindy','def_stermonit',100000,500000,0.35),
('def_npc_gamma_lithus_basic_lindy','def_imentium',100000,500000,0.35),
('def_npc_gamma_lithus_basic_lindy','def_silgium',100000,500000,0.35),
('def_npc_gamma_lithus_basic_lindy','def_electroplant_fruit',15000,150000,0.15),
('def_npc_gamma_lithus_basic_lindy','def_helioptris',50000,250000,0.35),
('def_npc_gamma_lithus_basic_lindy','def_triandlus',50000,250000,0.35),
('def_npc_gamma_lithus_basic_lindy','def_prismocitae',50000,250000,0.35),


('def_npc_gamma_scarab_basic_lindy','def_kernel_industrial',24960,49920,1),
('def_npc_gamma_scarab_basic_lindy','def_kernel_common',12480,18720,1),
('def_npc_gamma_scarab_basic_lindy','def_kernel_hitech',2496,3744,1),
('def_npc_gamma_scarab_basic_lindy','def_common_reactor_plasma',14400,18000,1),
('def_npc_gamma_scarab_basic_lindy','def_robotshard_common_basic',14,144,0.5),
('def_npc_gamma_scarab_basic_lindy','def_robotshard_common_advanced',24,240,0.5),
('def_npc_gamma_scarab_basic_lindy','def_robotshard_common_expert',34,336,0.5),
('def_npc_gamma_scarab_basic_lindy','def_named3_shield_hardener',1,1,0.11),
('def_npc_gamma_scarab_basic_lindy','def_named3_medium_shield_generator',1,1,0.11),
('def_npc_gamma_scarab_basic_lindy','def_named3_medium_armor_plate',1,1,0.11),
('def_npc_gamma_scarab_basic_lindy','def_named2_shield_hardener',1,1,0.125),
('def_npc_gamma_scarab_basic_lindy','def_named2_medium_shield_generator',1,1,0.125),
('def_npc_gamma_scarab_basic_lindy','def_named2_medium_armor_plate',1,1,0.125),
('def_npc_gamma_scarab_basic_lindy','def_named1_shield_hardener',1,1,0.22),
('def_npc_gamma_scarab_basic_lindy','def_named1_medium_shield_generator',1,1,0.22),
('def_npc_gamma_scarab_basic_lindy','def_named1_medium_armor_plate',1,1,0.22),
('def_npc_gamma_scarab_basic_lindy','def_standard_shield_hardener',1,1,0.25),
('def_npc_gamma_scarab_basic_lindy','def_standard_medium_shield_generator',1,1,0.25),
('def_npc_gamma_scarab_basic_lindy','def_standard_medium_armor_plate',1,1,0.25),
('def_npc_gamma_scarab_basic_lindy','def_container_capsule',1,1,1),
('def_npc_gamma_scarab_basic_lindy','def_npc_egg_industrial_medium_expert_capsule',1,1,0.5),
('def_npc_gamma_scarab_basic_lindy','def_npc_egg_industrial_medium_miniboss3_capsule',1,1,0.25),
('def_npc_gamma_scarab_basic_lindy','def_epriton',300000,3000000,0.15),
('def_npc_gamma_scarab_basic_lindy','def_stermonit',1000000,5000000,0.35),
('def_npc_gamma_scarab_basic_lindy','def_imentium',1000000,5000000,0.35),
('def_npc_gamma_scarab_basic_lindy','def_silgium',1000000,5000000,0.35),
('def_npc_gamma_scarab_basic_lindy','def_electroplant_fruit',150000,1500000,0.15),
('def_npc_gamma_scarab_basic_lindy','def_helioptris',500000,2500000,0.35),
('def_npc_gamma_scarab_basic_lindy','def_triandlus',500000,2500000,0.35),
('def_npc_gamma_scarab_basic_lindy','def_prismocitae',500000,2500000,0.35),


('def_npc_gamma_ikarus_basic_lindy','def_kernel_industrial',3328,4992,1),
('def_npc_gamma_ikarus_basic_lindy','def_kernel_common',1664,3328,1),
('def_npc_gamma_ikarus_basic_lindy','def_kernel_hitech',832,1248,1),
('def_npc_gamma_ikarus_basic_lindy','def_common_reactor_plasma',1500,1800,1),
('def_npc_gamma_ikarus_basic_lindy','def_robotshard_common_basic',4,36,0.5),
('def_npc_gamma_ikarus_basic_lindy','def_robotshard_common_advanced',2,24,0.5),
('def_npc_gamma_ikarus_basic_lindy','def_robotshard_common_expert',1,12,0.5),
('def_npc_gamma_ikarus_basic_lindy','def_named3_mass_reductor',1,1,0.06),
('def_npc_gamma_ikarus_basic_lindy','def_named2_mass_reductor',1,1,0.088),
('def_npc_gamma_ikarus_basic_lindy','def_named1_mass_reductor',1,1,0.126),
('def_npc_gamma_ikarus_basic_lindy','def_standard_mass_reductor',1,1,0.25),
('def_npc_gamma_ikarus_basic_lindy','def_container_capsule',1,1,0.45),
('def_npc_gamma_ikarus_basic_lindy','def_stermonit',5000,50000,0.35),
('def_npc_gamma_ikarus_basic_lindy','def_imentium',5000,50000,0.35),
('def_npc_gamma_ikarus_basic_lindy','def_silgium',5000,50000,0.35),
('def_npc_gamma_ikarus_basic_lindy','def_biotichrin',300,3000,0.1),


('def_npc_gamma_daidalos_basic_lindy','def_kernel_industrial',12480,18720,1),
('def_npc_gamma_daidalos_basic_lindy','def_kernel_common',6240,9360,1),
('def_npc_gamma_daidalos_basic_lindy','def_kernel_hitech',1248,1872,1),
('def_npc_gamma_daidalos_basic_lindy','def_common_reactor_plasma',7200,9000,1),
('def_npc_gamma_daidalos_basic_lindy','def_robotshard_common_basic',1,12,0.5),
('def_npc_gamma_daidalos_basic_lindy','def_robotshard_common_advanced',4,36,0.5),
('def_npc_gamma_daidalos_basic_lindy','def_robotshard_common_expert',6,60,0.5),
('def_npc_gamma_daidalos_basic_lindy','def_ammo_medium_projectile_d',100,200,0.5),
('def_npc_gamma_daidalos_basic_lindy','def_named3_longrange_medium_autocannon',1,1,0.11),
('def_npc_gamma_daidalos_basic_lindy','def_named3_damage_mod_projectile',1,1,0.11),
('def_npc_gamma_daidalos_basic_lindy','def_named3_medium_armor_plate',1,1,0.11),
('def_npc_gamma_daidalos_basic_lindy','def_named3_medium_armor_repairer',1,1,0.11),
('def_npc_gamma_daidalos_basic_lindy','def_named2_longrange_medium_autocannon',1,1,0.125),
('def_npc_gamma_daidalos_basic_lindy','def_named2_damage_mod_projectile',1,1,0.125),
('def_npc_gamma_daidalos_basic_lindy','def_named2_medium_armor_plate',1,1,0.125),
('def_npc_gamma_daidalos_basic_lindy','def_named2_medium_armor_repairer',1,1,0.125),
('def_npc_gamma_daidalos_basic_lindy','def_named1_longrange_medium_autocannon',1,1,0.22),
('def_npc_gamma_daidalos_basic_lindy','def_named1_damage_mod_projectile',1,1,0.22),
('def_npc_gamma_daidalos_basic_lindy','def_named1_medium_armor_plate',1,1,0.22),
('def_npc_gamma_daidalos_basic_lindy','def_named1_medium_armor_repairer',1,1,0.22),
('def_npc_gamma_daidalos_basic_lindy','def_longrange_standard_medium_autocannon',1,1,0.25),
('def_npc_gamma_daidalos_basic_lindy','def_standard_damage_mod_projectile',1,1,0.25),
('def_npc_gamma_daidalos_basic_lindy','def_standard_medium_armor_plate',1,1,0.25),
('def_npc_gamma_daidalos_basic_lindy','def_standard_medium_armor_repairer',1,1,0.25),
('def_npc_gamma_daidalos_basic_lindy','def_container_capsule',1,1,0.7),
('def_npc_gamma_daidalos_basic_lindy','def_stermonit',5000,250000,0.35),
('def_npc_gamma_daidalos_basic_lindy','def_imentium',5000,250000,0.35),
('def_npc_gamma_daidalos_basic_lindy','def_silgium',5000,250000,0.35),
('def_npc_gamma_daidalos_basic_lindy','def_biotichrin',1200,12000,0.1),


('def_npc_gamma_cronus_basic_lindy','def_kernel_industrial',6656,9984,1),
('def_npc_gamma_cronus_basic_lindy','def_kernel_common',4160,6240,1),
('def_npc_gamma_cronus_basic_lindy','def_kernel_hitech',1664,2496,1),
('def_npc_gamma_cronus_basic_lindy','def_common_reactor_plasma',1416,1776,1),
('def_npc_gamma_cronus_basic_lindy','def_robotshard_common_basic',6,60,0.5),
('def_npc_gamma_cronus_basic_lindy','def_robotshard_common_advanced',6,60,0.5),
('def_npc_gamma_cronus_basic_lindy','def_robotshard_common_expert',6,60,0.5),
('def_npc_gamma_cronus_basic_lindy','def_plant_bomb_capsule',1,1,0.1),
('def_npc_gamma_cronus_basic_lindy','def_named3_mining_upgrade',1,1,0.06),
('def_npc_gamma_cronus_basic_lindy','def_named3_small_shield_generator',1,1,0.06),
('def_npc_gamma_cronus_basic_lindy','def_named3_small_driller',1,1,0.03),
('def_npc_gamma_cronus_basic_lindy','def_named3_small_harvester',1,1,0.03),
('def_npc_gamma_cronus_basic_lindy','def_named1_medium_driller',1,1,0.03),
('def_npc_gamma_cronus_basic_lindy','def_named1_medium_harvester',1,1,0.03),
('def_npc_gamma_cronus_basic_lindy','def_named2_mining_upgrade',1,1,0.088),
('def_npc_gamma_cronus_basic_lindy','def_named2_small_shield_generator',1,1,0.088),
('def_npc_gamma_cronus_basic_lindy','def_named2_small_driller',1,1,0.044),
('def_npc_gamma_cronus_basic_lindy','def_named2_small_harvester',1,1,0.044),
('def_npc_gamma_cronus_basic_lindy','def_named1_mining_upgrade',1,1,0.126),
('def_npc_gamma_cronus_basic_lindy','def_named1_small_shield_generator',1,1,0.126),
('def_npc_gamma_cronus_basic_lindy','def_named1_small_driller',1,1,0.063),
('def_npc_gamma_cronus_basic_lindy','def_named1_small_harvester',1,1,0.0315),
('def_npc_gamma_cronus_basic_lindy','def_standard_mining_upgrade',1,1,0.25),
('def_npc_gamma_cronus_basic_lindy','def_standard_small_shield_generator',1,1,0.25),
('def_npc_gamma_cronus_basic_lindy','def_standard_small_driller',1,1,0.125),
('def_npc_gamma_cronus_basic_lindy','def_standard_small_harvester',1,1,0.125),
('def_npc_gamma_cronus_basic_lindy','def_standard_medium_driller',1,1,0.125),
('def_npc_gamma_cronus_basic_lindy','def_standard_medium_harvester',1,1,0.125),
('def_npc_gamma_cronus_basic_lindy','def_ammo_mining_imentium',25,125,0.25),
('def_npc_gamma_cronus_basic_lindy','def_ammo_mining_stermonit',25,125,0.25),
('def_npc_gamma_cronus_basic_lindy','def_ammo_mining_silgium',25,125,0.25),
('def_npc_gamma_cronus_basic_lindy','def_ammo_harvesting_standard',50,250,0.25),


('def_npc_gamma_riveler_basic_lindy','def_kernel_industrial',16640,24960,1),
('def_npc_gamma_riveler_basic_lindy','def_kernel_common',8320,12480,1),
('def_npc_gamma_riveler_basic_lindy','def_kernel_hitech',1664,2496,1),
('def_npc_gamma_riveler_basic_lindy','def_common_reactor_plasma',9600,12000,1),
('def_npc_gamma_riveler_basic_lindy','def_robotshard_common_basic',6,60,0.5),
('def_npc_gamma_riveler_basic_lindy','def_robotshard_common_advanced',12,120,0.5),
('def_npc_gamma_riveler_basic_lindy','def_robotshard_common_expert',18,180,0.5),
('def_npc_gamma_riveler_basic_lindy','def_named3_mining_upgrade',1,1,0.11),
('def_npc_gamma_riveler_basic_lindy','def_named3_medium_shield_generator',1,1,0.11),
('def_npc_gamma_riveler_basic_lindy','def_named3_medium_driller',1,2,0.11),
('def_npc_gamma_riveler_basic_lindy','def_named3_mining_probe_module',1,1,0.11),
('def_npc_gamma_riveler_basic_lindy','def_named3_core_recharger',1,1,0.11),
('def_npc_gamma_riveler_basic_lindy','def_named2_mining_upgrade',1,1,0.125),
('def_npc_gamma_riveler_basic_lindy','def_named2_medium_shield_generator',1,1,0.125),
('def_npc_gamma_riveler_basic_lindy','def_named2_medium_driller',1,2,0.125),
('def_npc_gamma_riveler_basic_lindy','def_named2_mining_probe_module',1,1,0.125),
('def_npc_gamma_riveler_basic_lindy','def_named2_core_recharger',1,1,0.125),
('def_npc_gamma_riveler_basic_lindy','def_named1_mining_upgrade',1,1,0.22),
('def_npc_gamma_riveler_basic_lindy','def_named1_medium_shield_generator',1,1,0.22),
('def_npc_gamma_riveler_basic_lindy','def_named1_medium_driller',1,2,0.22),
('def_npc_gamma_riveler_basic_lindy','def_named1_mining_probe_module',1,1,0.22),
('def_npc_gamma_riveler_basic_lindy','def_named1_core_recharger',1,1,0.22),
('def_npc_gamma_riveler_basic_lindy','def_standard_mining_upgrade',1,1,0.25),
('def_npc_gamma_riveler_basic_lindy','def_standard_medium_shield_generator',1,1,0.25),
('def_npc_gamma_riveler_basic_lindy','def_standard_medium_driller',1,2,0.25),
('def_npc_gamma_riveler_basic_lindy','def_standard_mining_probe_module',1,1,0.25),
('def_npc_gamma_riveler_basic_lindy','def_standard_core_recharger',1,1,0.25),
('def_npc_gamma_riveler_basic_lindy','def_ammo_mining_imentium',100,2000,0.5),
('def_npc_gamma_riveler_basic_lindy','def_ammo_mining_stermonit',100,2000,0.5),
('def_npc_gamma_riveler_basic_lindy','def_ammo_mining_epriton',100,2000,0.1),
('def_npc_gamma_riveler_basic_lindy','def_ammo_mining_silgium',100,2000,0.5),
('def_npc_gamma_riveler_basic_lindy','def_ammo_mining_fluxore',100,2000,0.1),


('def_npc_gamma_symbiont_basic_lindy','def_kernel_industrial',16640,24960,1),
('def_npc_gamma_symbiont_basic_lindy','def_kernel_common',8320,12480,1),
('def_npc_gamma_symbiont_basic_lindy','def_kernel_hitech',1664,2496,1),
('def_npc_gamma_symbiont_basic_lindy','def_common_reactor_plasma',9600,12000,1),
('def_npc_gamma_symbiont_basic_lindy','def_robotshard_common_basic',6,60,0.5),
('def_npc_gamma_symbiont_basic_lindy','def_robotshard_common_advanced',12,120,0.5),
('def_npc_gamma_symbiont_basic_lindy','def_robotshard_common_expert',18,180,0.5),
('def_npc_gamma_symbiont_basic_lindy','def_named3_mining_upgrade',1,1,0.11),
('def_npc_gamma_symbiont_basic_lindy','def_named3_medium_shield_generator',1,1,0.11),
('def_npc_gamma_symbiont_basic_lindy','def_named3_medium_harvester',1,2,0.11),
('def_npc_gamma_symbiont_basic_lindy','def_named3_stealth_modul',1,1,0.11),
('def_npc_gamma_symbiont_basic_lindy','def_named3_core_recharger',1,1,0.11),
('def_npc_gamma_symbiont_basic_lindy','def_named2_mining_upgrade',1,1,0.125),
('def_npc_gamma_symbiont_basic_lindy','def_named2_medium_shield_generator',1,1,0.125),
('def_npc_gamma_symbiont_basic_lindy','def_named2_medium_harvester',1,2,0.125),
('def_npc_gamma_symbiont_basic_lindy','def_named2_stealth_modul',1,1,0.125),
('def_npc_gamma_symbiont_basic_lindy','def_named2_core_recharger',1,1,0.125),
('def_npc_gamma_symbiont_basic_lindy','def_named1_mining_upgrade',1,1,0.22),
('def_npc_gamma_symbiont_basic_lindy','def_named1_medium_shield_generator',1,1,0.22),
('def_npc_gamma_symbiont_basic_lindy','def_named1_medium_harvester',1,2,0.22),
('def_npc_gamma_symbiont_basic_lindy','def_named1_stealth_modul',1,1,0.22),
('def_npc_gamma_symbiont_basic_lindy','def_named1_core_recharger',1,1,0.22),
('def_npc_gamma_symbiont_basic_lindy','def_standard_mining_upgrade',1,1,0.25),
('def_npc_gamma_symbiont_basic_lindy','def_standard_medium_shield_generator',1,1,0.25),
('def_npc_gamma_symbiont_basic_lindy','def_standard_medium_harvester',1,2,0.25),
('def_npc_gamma_symbiont_basic_lindy','def_standard_stealth_modul',1,1,0.25),
('def_npc_gamma_symbiont_basic_lindy','def_standard_core_recharger',1,1,0.25),
('def_npc_gamma_symbiont_basic_lindy','def_ammo_harvesting_standard',100,2500,1),
('def_npc_gamma_symbiont_basic_lindy','def_plant_seed_electroplant',10,20,0.6),
('def_npc_gamma_symbiont_basic_lindy','def_plant_seed_titanplant',10,20,0.2),
('def_npc_gamma_symbiont_basic_lindy','def_plant_seed_bonsai',10,20,0.2),
('def_npc_gamma_symbiont_basic_lindy','def_plant_seed_poffeteg',10,20,0.2),
('def_npc_gamma_symbiont_basic_lindy','def_plant_seed_irontree',10,20,0.2),
('def_npc_gamma_symbiont_basic_lindy','def_plant_seed_quag',10,20,0.2),
('def_npc_gamma_symbiont_basic_lindy','def_plant_seed_pinetree',10,20,0.2),
('def_npc_gamma_symbiont_basic_lindy','def_plant_seed_rango',10,20,0.2),
('def_npc_gamma_symbiont_basic_lindy','def_plant_seed_rustbush',10,20,0.2),
('def_npc_gamma_symbiont_basic_lindy','def_plant_seed_slimeroot',10,20,0.2),
('def_npc_gamma_symbiont_basic_lindy','def_plant_seed_coppertree',10,20,0.2),


('def_npc_gamma_termis_basic_lindy','def_kernel_industrial',13312,19968,1),
('def_npc_gamma_termis_basic_lindy','def_kernel_common',8320,12480,1),
('def_npc_gamma_termis_basic_lindy','def_kernel_hitech',3328,4992,1),
('def_npc_gamma_termis_basic_lindy','def_common_reactor_plasma',2832,3552,1),
('def_npc_gamma_termis_basic_lindy','def_robotshard_common_basic',7,72,0.5),
('def_npc_gamma_termis_basic_lindy','def_robotshard_common_advanced',7,72,0.5),
('def_npc_gamma_termis_basic_lindy','def_robotshard_common_expert',7,72,0.5),
('def_npc_gamma_termis_basic_lindy','def_named3_mining_upgrade',1,1,0.0825),
('def_npc_gamma_termis_basic_lindy','def_named3_medium_shield_generator',1,1,0.0825),
('def_npc_gamma_termis_basic_lindy','def_named3_medium_driller',1,2,0.0825),
('def_npc_gamma_termis_basic_lindy','def_named3_mining_probe_module',1,1,0.0825),
('def_npc_gamma_termis_basic_lindy','def_named3_core_recharger',1,1,0.0825),
('def_npc_gamma_termis_basic_lindy','def_named2_mining_upgrade',1,1,0.09375),
('def_npc_gamma_termis_basic_lindy','def_named2_medium_shield_generator',1,1,0.09375),
('def_npc_gamma_termis_basic_lindy','def_named2_medium_driller',1,2,0.09375),
('def_npc_gamma_termis_basic_lindy','def_named2_mining_probe_module',1,1,0.09375),
('def_npc_gamma_termis_basic_lindy','def_named2_core_recharger',1,1,0.09375),
('def_npc_gamma_termis_basic_lindy','def_named1_mining_upgrade',1,1,0.165),
('def_npc_gamma_termis_basic_lindy','def_named1_medium_shield_generator',1,1,0.165),
('def_npc_gamma_termis_basic_lindy','def_named1_medium_driller',1,2,0.165),
('def_npc_gamma_termis_basic_lindy','def_named1_mining_probe_module',1,1,0.165),
('def_npc_gamma_termis_basic_lindy','def_named1_core_recharger',1,1,0.165),
('def_npc_gamma_termis_basic_lindy','def_standard_mining_upgrade',1,1,0.25),
('def_npc_gamma_termis_basic_lindy','def_standard_medium_shield_generator',1,1,0.25),
('def_npc_gamma_termis_basic_lindy','def_standard_medium_driller',1,2,0.25),
('def_npc_gamma_termis_basic_lindy','def_standard_mining_probe_module',1,1,0.25),
('def_npc_gamma_termis_basic_lindy','def_standard_core_recharger',1,1,0.25),
('def_npc_gamma_termis_basic_lindy','def_ammo_mining_imentium',100,1000,0.5),
('def_npc_gamma_termis_basic_lindy','def_ammo_mining_stermonit',100,1000,0.5),
('def_npc_gamma_termis_basic_lindy','def_ammo_mining_silgium',100,1000,0.5),


('def_npc_gamma_gargoyle_basic_lindy','def_kernel_industrial',13312,19968,1),
('def_npc_gamma_gargoyle_basic_lindy','def_kernel_common',8320,12480,1),
('def_npc_gamma_gargoyle_basic_lindy','def_kernel_hitech',3328,4992,1),
('def_npc_gamma_gargoyle_basic_lindy','def_common_reactor_plasma',2832,3552,1),
('def_npc_gamma_gargoyle_basic_lindy','def_robotshard_common_expert',7,72,0.5),
('def_npc_gamma_gargoyle_basic_lindy','def_robotshard_common_advanced',7,72,0.5),
('def_npc_gamma_gargoyle_basic_lindy','def_robotshard_common_basic',7,72,0.5),
('def_npc_gamma_gargoyle_basic_lindy','def_named3_mining_upgrade',1,1,0.0825),
('def_npc_gamma_gargoyle_basic_lindy','def_named3_medium_shield_generator',1,1,0.0825),
('def_npc_gamma_gargoyle_basic_lindy','def_named3_medium_harvester',1,2,0.0825),
('def_npc_gamma_gargoyle_basic_lindy','def_named3_stealth_modul',1,1,0.0825),
('def_npc_gamma_gargoyle_basic_lindy','def_named3_core_recharger',1,1,0.0825),
('def_npc_gamma_gargoyle_basic_lindy','def_named2_mining_upgrade',1,1,0.09375),
('def_npc_gamma_gargoyle_basic_lindy','def_named2_medium_shield_generator',1,1,0.09375),
('def_npc_gamma_gargoyle_basic_lindy','def_named2_medium_harvester',1,2,0.09375),
('def_npc_gamma_gargoyle_basic_lindy','def_named2_stealth_modul',1,1,0.09375),
('def_npc_gamma_gargoyle_basic_lindy','def_named2_core_recharger',1,1,0.09375),
('def_npc_gamma_gargoyle_basic_lindy','def_named1_mining_upgrade',1,1,0.165),
('def_npc_gamma_gargoyle_basic_lindy','def_named1_medium_shield_generator',1,1,0.165),
('def_npc_gamma_gargoyle_basic_lindy','def_named1_medium_harvester',1,2,0.165),
('def_npc_gamma_gargoyle_basic_lindy','def_named1_stealth_modul',1,1,0.165),
('def_npc_gamma_gargoyle_basic_lindy','def_named1_core_recharger',1,1,0.165),
('def_npc_gamma_gargoyle_basic_lindy','def_standard_mining_upgrade',1,1,0.25),
('def_npc_gamma_gargoyle_basic_lindy','def_standard_medium_shield_generator',1,1,0.25),
('def_npc_gamma_gargoyle_basic_lindy','def_standard_medium_harvester',1,2,0.25),
('def_npc_gamma_gargoyle_basic_lindy','def_standard_stealth_modul',1,1,0.25),
('def_npc_gamma_gargoyle_basic_lindy','def_standard_core_recharger',1,1,0.25),
('def_npc_gamma_gargoyle_basic_lindy','def_ammo_harvesting_standard',50,1250,1),
('def_npc_gamma_gargoyle_basic_lindy','def_plant_seed_electroplant',5,10,0.6),
('def_npc_gamma_gargoyle_basic_lindy','def_plant_seed_titanplant',5,10,0.2),
('def_npc_gamma_gargoyle_basic_lindy','def_plant_seed_bonsai',5,10,0.2),
('def_npc_gamma_gargoyle_basic_lindy','def_plant_seed_poffeteg',5,10,0.2),
('def_npc_gamma_gargoyle_basic_lindy','def_plant_seed_irontree',5,10,0.2),
('def_npc_gamma_gargoyle_basic_lindy','def_plant_seed_quag',5,10,0.2),
('def_npc_gamma_gargoyle_basic_lindy','def_plant_seed_pinetree',5,10,0.2),
('def_npc_gamma_gargoyle_basic_lindy','def_plant_seed_rango',5,10,0.2),
('def_npc_gamma_gargoyle_basic_lindy','def_plant_seed_rustbush',5,10,0.2),
('def_npc_gamma_gargoyle_basic_lindy','def_plant_seed_slimeroot',5,10,0.2),
('def_npc_gamma_gargoyle_basic_lindy','def_plant_seed_coppertree',5,10,0.2),


('def_npc_gamma_argano_basic_lindy','def_kernel_industrial',3328,4992,1),
('def_npc_gamma_argano_basic_lindy','def_kernel_common',2080,3120,1),
('def_npc_gamma_argano_basic_lindy','def_kernel_hitech',832,1248,1),
('def_npc_gamma_argano_basic_lindy','def_common_reactor_plasma',708,888,1),
('def_npc_gamma_argano_basic_lindy','def_robotshard_common_basic',4,36,0.5),
('def_npc_gamma_argano_basic_lindy','def_robotshard_common_advanced',2,24,0.5),
('def_npc_gamma_argano_basic_lindy','def_robotshard_common_expert',1,12,0.5),
('def_npc_gamma_argano_basic_lindy','def_named3_mining_upgrade',1,1,0.066),
('def_npc_gamma_argano_basic_lindy','def_named3_small_shield_generator',1,1,0.066),
('def_npc_gamma_argano_basic_lindy','def_named3_small_driller',1,2,0.066),
('def_npc_gamma_argano_basic_lindy','def_named3_mining_probe_module',1,1,0.066),
('def_npc_gamma_argano_basic_lindy','def_named3_small_core_battery',1,1,0.066),
('def_npc_gamma_argano_basic_lindy','def_named2_mining_upgrade',1,1,0.075),
('def_npc_gamma_argano_basic_lindy','def_named2_small_shield_generator',1,1,0.075),
('def_npc_gamma_argano_basic_lindy','def_named2_small_driller',1,2,0.075),
('def_npc_gamma_argano_basic_lindy','def_named2_mining_probe_module',1,1,0.075),
('def_npc_gamma_argano_basic_lindy','def_named2_small_core_battery',1,1,0.075),
('def_npc_gamma_argano_basic_lindy','def_named1_mining_upgrade',1,1,0.132),
('def_npc_gamma_argano_basic_lindy','def_named1_small_shield_generator',1,1,0.132),
('def_npc_gamma_argano_basic_lindy','def_named1_small_driller',1,2,0.132),
('def_npc_gamma_argano_basic_lindy','def_named1_mining_probe_module',1,1,0.132),
('def_npc_gamma_argano_basic_lindy','def_named1_small_core_battery',1,1,0.132),
('def_npc_gamma_argano_basic_lindy','def_standard_mining_upgrade',1,1,0.25),
('def_npc_gamma_argano_basic_lindy','def_standard_small_shield_generator',1,1,0.25),
('def_npc_gamma_argano_basic_lindy','def_standard_small_driller',1,2,0.25),
('def_npc_gamma_argano_basic_lindy','def_standard_mining_probe_module',1,1,0.25),
('def_npc_gamma_argano_basic_lindy','def_standard_small_core_battery',1,1,0.25),
('def_npc_gamma_argano_basic_lindy','def_ammo_mining_imentium',50,250,0.5),
('def_npc_gamma_argano_basic_lindy','def_ammo_mining_stermonit',50,250,0.5),
('def_npc_gamma_argano_basic_lindy','def_ammo_mining_silgium',50,250,0.5),


('def_npc_gamma_laird_basic_lindy','def_kernel_industrial',3328,4992,1),
('def_npc_gamma_laird_basic_lindy','def_kernel_common',2080,3120,1),
('def_npc_gamma_laird_basic_lindy','def_kernel_hitech',832,1248,1),
('def_npc_gamma_laird_basic_lindy','def_common_reactor_plasma',708,888,1),
('def_npc_gamma_laird_basic_lindy','def_robotshard_common_basic',4,36,0.5),
('def_npc_gamma_laird_basic_lindy','def_robotshard_common_advanced',2,24,0.5),
('def_npc_gamma_laird_basic_lindy','def_robotshard_common_expert',1,12,0.5),
('def_npc_gamma_laird_basic_lindy','def_named3_mining_upgrade',1,1,0.066),
('def_npc_gamma_laird_basic_lindy','def_named3_small_shield_generator',1,1,0.066),
('def_npc_gamma_laird_basic_lindy','def_named3_small_harvester',1,2,0.066),
('def_npc_gamma_laird_basic_lindy','def_named3_stealth_modul',1,1,0.066),
('def_npc_gamma_laird_basic_lindy','def_named3_small_core_battery',1,1,0.066),
('def_npc_gamma_laird_basic_lindy','def_named2_mining_upgrade',1,1,0.075),
('def_npc_gamma_laird_basic_lindy','def_named2_small_shield_generator',1,1,0.075),
('def_npc_gamma_laird_basic_lindy','def_named2_small_harvester',1,2,0.075),
('def_npc_gamma_laird_basic_lindy','def_named2_stealth_modul',1,1,0.075),
('def_npc_gamma_laird_basic_lindy','def_named2_small_core_battery',1,1,0.075),
('def_npc_gamma_laird_basic_lindy','def_named1_mining_upgrade',1,1,0.132),
('def_npc_gamma_laird_basic_lindy','def_named1_small_shield_generator',1,1,0.132),
('def_npc_gamma_laird_basic_lindy','def_named1_small_harvester',1,2,0.132),
('def_npc_gamma_laird_basic_lindy','def_named1_stealth_modul',1,1,0.132),
('def_npc_gamma_laird_basic_lindy','def_named1_small_core_battery',1,1,0.132),
('def_npc_gamma_laird_basic_lindy','def_standard_mining_upgrade',1,1,0.25),
('def_npc_gamma_laird_basic_lindy','def_standard_small_shield_generator',1,1,0.25),
('def_npc_gamma_laird_basic_lindy','def_standard_small_harvester',1,2,0.25),
('def_npc_gamma_laird_basic_lindy','def_standard_stealth_modul',1,1,0.25),
('def_npc_gamma_laird_basic_lindy','def_standard_small_core_battery',1,1,0.25),
('def_npc_gamma_laird_basic_lindy','def_ammo_harvesting_standard',50,1250,1),
('def_npc_gamma_laird_basic_lindy','def_plant_seed_electroplant',5,10,0.6),
('def_npc_gamma_laird_basic_lindy','def_plant_seed_titanplant',2,10,0.2),
('def_npc_gamma_laird_basic_lindy','def_plant_seed_bonsai',2,10,0.2),
('def_npc_gamma_laird_basic_lindy','def_plant_seed_poffeteg',2,10,0.2),
('def_npc_gamma_laird_basic_lindy','def_plant_seed_irontree',2,10,0.2),
('def_npc_gamma_laird_basic_lindy','def_plant_seed_quag',2,10,0.2),
('def_npc_gamma_laird_basic_lindy','def_plant_seed_pinetree',2,10,0.2),
('def_npc_gamma_laird_basic_lindy','def_plant_seed_rango',2,10,0.2),
('def_npc_gamma_laird_basic_lindy','def_plant_seed_rustbush',2,10,0.2),
('def_npc_gamma_laird_basic_lindy','def_plant_seed_slimeroot',2,10,0.2),
('def_npc_gamma_laird_basic_lindy','def_plant_seed_coppertree',2,10,0.2),


('def_npc_gamma_hermes_basic_lindy','def_kernel_industrial',6656,9984,1),
('def_npc_gamma_hermes_basic_lindy','def_kernel_common',4160,6240,1),
('def_npc_gamma_hermes_basic_lindy','def_kernel_hitech',1664,2496,1),
('def_npc_gamma_hermes_basic_lindy','def_common_reactor_plasma',1416,1776,1),
('def_npc_gamma_hermes_basic_lindy','def_robotshard_common_expert',4,36,0.5),
('def_npc_gamma_hermes_basic_lindy','def_robotshard_common_advanced',7,72,0.5),
('def_npc_gamma_hermes_basic_lindy','def_robotshard_common_basic',11,108,0.5),
('def_npc_gamma_hermes_basic_lindy','def_ammo_small_projectile_d',100,200,0.5),
('def_npc_gamma_hermes_basic_lindy','def_ammo_artifact_scan_a',15,50,0.5),
('def_npc_gamma_hermes_basic_lindy','def_ammo_artifact_scan_b',15,50,0.3),
('def_npc_gamma_hermes_basic_lindy','def_ammo_artifact_scan_c',15,50,0.25),
('def_npc_gamma_hermes_basic_lindy','def_named3_mining_probe_module',1,1,0.066),
('def_npc_gamma_hermes_basic_lindy','def_named3_small_autocannon',1,1,0.066),
('def_npc_gamma_hermes_basic_lindy','def_named3_damage_mod_projectile',1,1,0.066),
('def_npc_gamma_hermes_basic_lindy','def_named3_small_armor_plate',1,1,0.066),
('def_npc_gamma_hermes_basic_lindy','def_named2_mining_probe_module',1,1,0.075),
('def_npc_gamma_hermes_basic_lindy','def_named2_small_autocannon',1,1,0.075),
('def_npc_gamma_hermes_basic_lindy','def_named2_damage_mod_projectile',1,1,0.075),
('def_npc_gamma_hermes_basic_lindy','def_named2_small_armor_plate',1,1,0.075),
('def_npc_gamma_hermes_basic_lindy','def_named1_mining_probe_module',1,1,0.132),
('def_npc_gamma_hermes_basic_lindy','def_named1_small_autocannon',1,1,0.132),
('def_npc_gamma_hermes_basic_lindy','def_named1_damage_mod_projectile',1,1,0.132),
('def_npc_gamma_hermes_basic_lindy','def_named1_small_armor_plate',1,1,0.132),
('def_npc_gamma_hermes_basic_lindy','def_standard_mining_probe_module',1,1,0.25),
('def_npc_gamma_hermes_basic_lindy','def_standard_small_autocannon',1,1,0.25),
('def_npc_gamma_hermes_basic_lindy','def_standard_damage_mod_projectile',1,1,0.25),
('def_npc_gamma_hermes_basic_lindy','def_standard_small_armor_plate',1,1,0.25),
('def_npc_gamma_hermes_basic_lindy','def_artifact_damaged_core_recharger',1,1,0.1),
('def_npc_gamma_hermes_basic_lindy','def_artifact_damaged_tracking_upgrade',1,1,0.1),
('def_npc_gamma_hermes_basic_lindy','def_artifact_damaged_maneuvering_upgrade',1,1,0.1),
('def_npc_gamma_hermes_basic_lindy','def_artifact_damaged_rocket_launcher',1,1,0.1),
('def_npc_gamma_hermes_basic_lindy','def_artifact_damaged_small_railgun',1,1,0.1),
('def_npc_gamma_hermes_basic_lindy','def_artifact_damaged_medium_armor_plate',1,1,0.1),
('def_npc_gamma_hermes_basic_lindy','def_artifact_damaged_medium_shield_generator',1,1,0.1),
('def_npc_gamma_hermes_basic_lindy','def_artifact_damaged_medium_laser',1,1,0.1),
('def_npc_gamma_hermes_basic_lindy','def_artifact_damaged_damage_mod_missile',1,1,0.1),
('def_npc_gamma_hermes_basic_lindy','def_artifact_damaged_sensor_booster',1,1,0.1),
('def_npc_gamma_hermes_basic_lindy','def_artifact_damaged_armor_repairer_upgrade',1,1,0.1),
('def_npc_gamma_hermes_basic_lindy','def_artifact_damaged_small_driller',1,1,0.1),
('def_npc_gamma_hermes_basic_lindy','def_artifact_damaged_medium_energy_neutralizer',1,1,0.1),
('def_npc_gamma_hermes_basic_lindy','def_artifact_damaged_medium_core_battery',1,1,0.1),


('def_npc_gamma_seth_advanced_observer','def_thelodica_reactor_plasma',27820,55640,1),
('def_npc_gamma_seth_advanced_observer','def_kernel_thelodica',26208,52416,1),
('def_npc_gamma_seth_advanced_observer','def_kernel_hitech',9360,18720,1),
('def_npc_gamma_seth_advanced_observer','def_kernel_common',11232,22464,1),
('def_npc_gamma_seth_advanced_observer','def_material_boss_gamma_thelodica',50,70,1),
('def_npc_gamma_seth_advanced_observer','def_ammo_medium_lasercrystal_rewb',100,200,0.5),
('def_npc_gamma_seth_advanced_observer','def_named3_medium_laser',1,1,0.22),
('def_npc_gamma_seth_advanced_observer','def_named3_resistant_plating',1,1,0.22),
('def_npc_gamma_seth_advanced_observer','def_named3_tracking_upgrade',1,1,0.22),
('def_npc_gamma_seth_advanced_observer','def_named3_damage_mod_laser',1,1,0.22),
('def_npc_gamma_seth_advanced_observer','def_named3_medium_armor_plate',1,1,0.22),
('def_npc_gamma_seth_advanced_observer','def_named2_medium_laser',1,1,0.33),
('def_npc_gamma_seth_advanced_observer','def_named2_resistant_plating',1,1,0.33),
('def_npc_gamma_seth_advanced_observer','def_named2_tracking_upgrade',1,1,0.33),
('def_npc_gamma_seth_advanced_observer','def_named2_damage_mod_laser',1,1,0.33),
('def_npc_gamma_seth_advanced_observer','def_named2_medium_armor_plate',1,1,0.33),
('def_npc_gamma_seth_advanced_observer','def_reactore_core_heavymech',1,1,0.1),
('def_npc_gamma_seth_advanced_observer','def_research_kit_7',1,1,0.1),
('def_npc_gamma_seth_advanced_observer','def_research_kit_8',1,1,0.1),


('def_npc_gamma_artemis_advanced_observer','def_thelodica_reactor_plasma',20020,40040,1),
('def_npc_gamma_artemis_advanced_observer','def_kernel_thelodica',13923,27846,1),
('def_npc_gamma_artemis_advanced_observer','def_kernel_hitech',7800,15600,1),
('def_npc_gamma_artemis_advanced_observer','def_kernel_common',5967,11934,1),
('def_npc_gamma_artemis_advanced_observer','def_material_boss_gamma_thelodica',20,30,1),
('def_npc_gamma_artemis_advanced_observer','def_ammo_medium_lasercrystal_rewa',100,150,0.5),
('def_npc_gamma_artemis_advanced_observer','def_named3_medium_laser',1,1,0.22),
('def_npc_gamma_artemis_advanced_observer','def_named3_resistant_plating',1,1,0.22),
('def_npc_gamma_artemis_advanced_observer','def_named3_tracking_upgrade',1,1,0.22),
('def_npc_gamma_artemis_advanced_observer','def_named3_damage_mod_laser',1,1,0.22),
('def_npc_gamma_artemis_advanced_observer','def_named2_medium_laser',1,1,0.33),
('def_npc_gamma_artemis_advanced_observer','def_named2_resistant_plating',1,1,0.33),
('def_npc_gamma_artemis_advanced_observer','def_named2_tracking_upgrade',1,1,0.33),
('def_npc_gamma_artemis_advanced_observer','def_named2_damage_mod_laser',1,1,0.33),
('def_npc_gamma_artemis_advanced_observer','def_reactore_core_mech',1,1,0.1),
('def_npc_gamma_artemis_advanced_observer','def_research_kit_7',1,1,0.05),
('def_npc_gamma_artemis_advanced_observer','def_research_kit_8',1,1,0.05),


('def_npc_gamma_zenith_advanced_observer','def_thelodica_reactor_plasma',20020,40040,1),
('def_npc_gamma_zenith_advanced_observer','def_kernel_thelodica',8463,16926,1),
('def_npc_gamma_zenith_advanced_observer','def_kernel_hitech',7800,15600,1),
('def_npc_gamma_zenith_advanced_observer','def_kernel_common',3627,7254,1),
('def_npc_gamma_zenith_advanced_observer','def_material_boss_gamma_thelodica',20,40,1),
('def_npc_gamma_zenith_advanced_observer','def_ammo_medium_lasercrystal_rewb',50,100,0.5),
('def_npc_gamma_zenith_advanced_observer','def_named3_longrange_medium_laser',1,1,0.22),
('def_npc_gamma_zenith_advanced_observer','def_named3_resistant_plating',1,1,0.22),
('def_npc_gamma_zenith_advanced_observer','def_named3_sensor_dampener',1,1,0.22),
('def_npc_gamma_zenith_advanced_observer','def_named3_sensor_supressor_booster',1,1,0.22),
('def_npc_gamma_zenith_advanced_observer','def_named2_longrange_medium_laser',1,1,0.33),
('def_npc_gamma_zenith_advanced_observer','def_named2_resistant_plating',1,1,0.33),
('def_npc_gamma_zenith_advanced_observer','def_named2_sensor_dampener',1,1,0.33),
('def_npc_gamma_zenith_advanced_observer','def_named2_sensor_supressor_booster',1,1,0.33),
('def_npc_gamma_zenith_advanced_observer','def_reactore_core_mech',1,1,0.1),
('def_npc_gamma_zenith_advanced_observer','def_research_kit_7',1,1,0.05),
('def_npc_gamma_zenith_advanced_observer','def_research_kit_8',1,1,0.05),


('def_npc_gamma_gropho_advanced_observer','def_pelistal_reactor_plasma',27820,55640,1),
('def_npc_gamma_gropho_advanced_observer','def_kernel_pelistal',26208,52416,1),
('def_npc_gamma_gropho_advanced_observer','def_kernel_hitech',9360,18720,1),
('def_npc_gamma_gropho_advanced_observer','def_kernel_common',11232,22464,1),
('def_npc_gamma_gropho_advanced_observer','def_material_boss_gamma_pelistal',50,70,1),
('def_npc_gamma_gropho_advanced_observer','def_ammo_missile_rewb',50,100,0.5),
('def_npc_gamma_gropho_advanced_observer','def_named3_missile_launcher',1,1,0.22),
('def_npc_gamma_gropho_advanced_observer','def_named3_core_recharger',1,1,0.22),
('def_npc_gamma_gropho_advanced_observer','def_named3_tracking_upgrade',1,1,0.22),
('def_npc_gamma_gropho_advanced_observer','def_named3_damage_mod_missile',1,1,0.22),
('def_npc_gamma_gropho_advanced_observer','def_named3_medium_shield_generator',1,1,0.22),
('def_npc_gamma_gropho_advanced_observer','def_named2_missile_launcher',1,1,0.33),
('def_npc_gamma_gropho_advanced_observer','def_named2_core_recharger',1,1,0.33),
('def_npc_gamma_gropho_advanced_observer','def_named2_tracking_upgrade',1,1,0.33),
('def_npc_gamma_gropho_advanced_observer','def_named2_damage_mod_missile',1,1,0.33),
('def_npc_gamma_gropho_advanced_observer','def_named2_medium_shield_generator',1,1,0.33),
('def_npc_gamma_gropho_advanced_observer','def_reactore_core_heavymech',1,1,0.1),
('def_npc_gamma_gropho_advanced_observer','def_research_kit_7',1,1,0.1),
('def_npc_gamma_gropho_advanced_observer','def_research_kit_8',1,1,0.1),


('def_npc_gamma_tyrannos_advanced_observer','def_pelistal_reactor_plasma',20020,40040,1),
('def_npc_gamma_tyrannos_advanced_observer','def_kernel_pelistal',13923,27846,1),
('def_npc_gamma_tyrannos_advanced_observer','def_kernel_hitech',7800,15600,1),
('def_npc_gamma_tyrannos_advanced_observer','def_kernel_common',5967,11934,1),
('def_npc_gamma_tyrannos_advanced_observer','def_material_boss_gamma_pelistal',20,30,1),
('def_npc_gamma_tyrannos_advanced_observer','def_ammo_missile_rewa',50,75,0.5),
('def_npc_gamma_tyrannos_advanced_observer','def_named3_missile_launcher',1,1,0.22),
('def_npc_gamma_tyrannos_advanced_observer','def_named3_medium_energy_vampire',1,1,0.22),
('def_npc_gamma_tyrannos_advanced_observer','def_named3_damage_mod_missile',1,1,0.22),
('def_npc_gamma_tyrannos_advanced_observer','def_named3_medium_shield_generator',1,1,0.22),
('def_npc_gamma_tyrannos_advanced_observer','def_named2_missile_launcher',1,1,0.33),
('def_npc_gamma_tyrannos_advanced_observer','def_named2_medium_energy_vampire',1,1,0.33),
('def_npc_gamma_tyrannos_advanced_observer','def_named2_damage_mod_missile',1,1,0.33),
('def_npc_gamma_tyrannos_advanced_observer','def_named2_medium_shield_generator',1,1,0.33),
('def_npc_gamma_tyrannos_advanced_observer','def_reactore_core_mech',1,1,0.1),
('def_npc_gamma_tyrannos_advanced_observer','def_research_kit_7',1,1,0.05),
('def_npc_gamma_tyrannos_advanced_observer','def_research_kit_8',1,1,0.05),


('def_npc_gamma_ictus_advanced_observer','def_pelistal_reactor_plasma',20020,40040,1),
('def_npc_gamma_ictus_advanced_observer','def_kernel_pelistal',8463,16926,1),
('def_npc_gamma_ictus_advanced_observer','def_kernel_hitech',7800,15600,1),
('def_npc_gamma_ictus_advanced_observer','def_kernel_common',3627,7254,1),
('def_npc_gamma_ictus_advanced_observer','def_material_boss_gamma_pelistal',20,40,1),
('def_npc_gamma_ictus_advanced_observer','def_ammo_longrange_missile_rewb',50,75,0.5),
('def_npc_gamma_ictus_advanced_observer','def_named3_missile_launcher',1,1,0.22),
('def_npc_gamma_ictus_advanced_observer','def_named3_energy_warfare_upgrade',1,1,0.22),
('def_npc_gamma_ictus_advanced_observer','def_named3_shield_hardener',1,1,0.22),
('def_npc_gamma_ictus_advanced_observer','def_named3_medium_energy_neutralizer',1,1,0.22),
('def_npc_gamma_ictus_advanced_observer','def_named2_missile_launcher',1,1,0.33),
('def_npc_gamma_ictus_advanced_observer','def_named2_energy_warfare_upgrade',1,1,0.33),
('def_npc_gamma_ictus_advanced_observer','def_named2_shield_hardener',1,1,0.33),
('def_npc_gamma_ictus_advanced_observer','def_named2_medium_energy_neutralizer',1,1,0.33),
('def_npc_gamma_ictus_advanced_observer','def_reactore_core_mech',1,1,0.1),
('def_npc_gamma_ictus_advanced_observer','def_research_kit_7',1,1,0.05),
('def_npc_gamma_ictus_advanced_observer','def_research_kit_8',1,1,0.05),


('def_npc_gamma_mesmer_advanced_observer','def_nuimqol_reactor_plasma',27820,55640,1),
('def_npc_gamma_mesmer_advanced_observer','def_kernel_nuimqol',26208,52416,1),
('def_npc_gamma_mesmer_advanced_observer','def_kernel_hitech',9360,18720,1),
('def_npc_gamma_mesmer_advanced_observer','def_kernel_common',11232,22464,1),
('def_npc_gamma_mesmer_advanced_observer','def_material_boss_gamma_nuimqol',50,70,1),
('def_npc_gamma_mesmer_advanced_observer','def_ammo_medium_railgun_rewb',100,200,0.5),
('def_npc_gamma_mesmer_advanced_observer','def_named3_medium_railgun',1,1,0.22),
('def_npc_gamma_mesmer_advanced_observer','def_named3_medium_core_booster',1,1,0.22),
('def_npc_gamma_mesmer_advanced_observer','def_named3_tracking_upgrade',1,1,0.22),
('def_npc_gamma_mesmer_advanced_observer','def_named3_damage_mod_railgun',1,1,0.22),
('def_npc_gamma_mesmer_advanced_observer','def_named3_medium_armor_repairer',1,1,0.22),
('def_npc_gamma_mesmer_advanced_observer','def_named2_medium_railgun',1,1,0.33),
('def_npc_gamma_mesmer_advanced_observer','def_named2_medium_core_booster',1,1,0.33),
('def_npc_gamma_mesmer_advanced_observer','def_named2_tracking_upgrade',1,1,0.33),
('def_npc_gamma_mesmer_advanced_observer','def_named2_damage_mod_railgun',1,1,0.33),
('def_npc_gamma_mesmer_advanced_observer','def_named2_medium_armor_repairer',1,1,0.33),
('def_npc_gamma_mesmer_advanced_observer','def_reactore_core_heavymech',1,1,0.1),
('def_npc_gamma_mesmer_advanced_observer','def_research_kit_7',1,1,0.1),
('def_npc_gamma_mesmer_advanced_observer','def_research_kit_8',1,1,0.1),


('def_npc_gamma_kain_advanced_observer','def_nuimqol_reactor_plasma',20020,40040,1),
('def_npc_gamma_kain_advanced_observer','def_kernel_nuimqol',13923,27846,1),
('def_npc_gamma_kain_advanced_observer','def_kernel_hitech',7800,15600,1),
('def_npc_gamma_kain_advanced_observer','def_kernel_common',5967,11934,1),
('def_npc_gamma_kain_advanced_observer','def_material_boss_gamma_nuimqol',20,30,1),
('def_npc_gamma_kain_advanced_observer','def_ammo_medium_railgun_rewa',100,150,0.5),
('def_npc_gamma_kain_advanced_observer','def_named3_medium_railgun',1,1,0.22),
('def_npc_gamma_kain_advanced_observer','def_named3_tracking_upgrade',1,1,0.22),
('def_npc_gamma_kain_advanced_observer','def_named3_damage_mod_railgun',1,1,0.22),
('def_npc_gamma_kain_advanced_observer','def_named3_medium_armor_repairer',1,1,0.22),
('def_npc_gamma_kain_advanced_observer','def_named2_medium_railgun',1,1,0.33),
('def_npc_gamma_kain_advanced_observer','def_named2_tracking_upgrade',1,1,0.33),
('def_npc_gamma_kain_advanced_observer','def_named2_damage_mod_railgun',1,1,0.33),
('def_npc_gamma_kain_advanced_observer','def_named2_medium_armor_repairer',1,1,0.33),
('def_npc_gamma_kain_advanced_observer','def_reactore_core_mech',1,1,0.1),
('def_npc_gamma_kain_advanced_observer','def_research_kit_7',1,1,0.05),
('def_npc_gamma_kain_advanced_observer','def_research_kit_8',1,1,0.05),


('def_npc_gamma_vagabond_advanced_observer','def_nuimqol_reactor_plasma',20020,40040,1),
('def_npc_gamma_vagabond_advanced_observer','def_kernel_nuimqol',8463,16926,1),
('def_npc_gamma_vagabond_advanced_observer','def_kernel_hitech',7800,15600,1),
('def_npc_gamma_vagabond_advanced_observer','def_kernel_common',3627,7254,1),
('def_npc_gamma_vagabond_advanced_observer','def_material_boss_gamma_nuimqol',20,40,1),
('def_npc_gamma_vagabond_advanced_observer','def_ammo_medium_railgun_rewb',50,100,0.5),
('def_npc_gamma_vagabond_advanced_observer','def_named3_longrange_medium_railgun',1,1,0.22),
('def_npc_gamma_vagabond_advanced_observer','def_named3_medium_core_battery',1,1,0.22),
('def_npc_gamma_vagabond_advanced_observer','def_named3_sensor_jammer',1,1,0.22),
('def_npc_gamma_vagabond_advanced_observer','def_named3_ecm_booster',1,1,0.22),
('def_npc_gamma_vagabond_advanced_observer','def_named2_longrange_medium_railgun',1,1,0.33),
('def_npc_gamma_vagabond_advanced_observer','def_named2_medium_core_battery',1,1,0.33),
('def_npc_gamma_vagabond_advanced_observer','def_named2_sensor_jammer',1,1,0.33),
('def_npc_gamma_vagabond_advanced_observer','def_named2_ecm_booster',1,1,0.33),
('def_npc_gamma_vagabond_advanced_observer','def_reactore_core_mech',1,1,0.1),
('def_npc_gamma_vagabond_advanced_observer','def_research_kit_7',1,1,0.05),
('def_npc_gamma_vagabond_advanced_observer','def_research_kit_8',1,1,0.05),


('def_npc_gamma_legatus_advanced_observer','def_common_reactor_plasma',33384,66768,1),
('def_npc_gamma_legatus_advanced_observer','def_kernel_common',33696,67392,1),
('def_npc_gamma_legatus_advanced_observer','def_kernel_hitech',18720,37440,1),
('def_npc_gamma_legatus_advanced_observer','def_material_boss_gamma_syndicate',50,70,1),
('def_npc_gamma_legatus_advanced_observer','def_ammo_medium_projectile_rewb',150,300,0.5),
('def_npc_gamma_legatus_advanced_observer','def_named3_medium_autocannon',1,1,0.22),
('def_npc_gamma_legatus_advanced_observer','def_named3_resistant_plating',1,1,0.22),
('def_npc_gamma_legatus_advanced_observer','def_named3_tracking_upgrade',1,1,0.22),
('def_npc_gamma_legatus_advanced_observer','def_named3_damage_mod_projectile',1,1,0.22),
('def_npc_gamma_legatus_advanced_observer','def_named2_large_armor_plate',1,1,0.22),
('def_npc_gamma_legatus_advanced_observer','def_named2_medium_autocannon',1,1,0.33),
('def_npc_gamma_legatus_advanced_observer','def_named2_resistant_plating',1,1,0.33),
('def_npc_gamma_legatus_advanced_observer','def_named2_tracking_upgrade',1,1,0.33),
('def_npc_gamma_legatus_advanced_observer','def_named2_damage_mod_projectile',1,1,0.33),
('def_npc_gamma_legatus_advanced_observer','def_named1_large_armor_plate',1,1,0.33),
('def_npc_gamma_legatus_advanced_observer','def_reactore_core_heavymech',1,1,0.1),
('def_npc_gamma_legatus_advanced_observer','def_research_kit_7',1,1,0.1),
('def_npc_gamma_legatus_advanced_observer','def_research_kit_8',1,1,0.1),


('def_npc_gamma_echelon_advanced_observer','def_common_reactor_plasma',24024,48048,1),
('def_npc_gamma_echelon_advanced_observer','def_kernel_common',17901,35802,1),
('def_npc_gamma_echelon_advanced_observer','def_kernel_hitech',15600,31200,1),
('def_npc_gamma_echelon_advanced_observer','def_material_boss_gamma_syndicate',20,30,1),
('def_npc_gamma_echelon_advanced_observer','def_ammo_medium_projectile_rewa',100,150,0.5),
('def_npc_gamma_echelon_advanced_observer','def_named3_medium_autocannon',1,1,0.22),
('def_npc_gamma_echelon_advanced_observer','def_named3_webber',1,1,0.22),
('def_npc_gamma_echelon_advanced_observer','def_named3_sensor_booster',1,1,0.22),
('def_npc_gamma_echelon_advanced_observer','def_named3_damage_mod_projectile',1,1,0.22),
('def_npc_gamma_echelon_advanced_observer','def_named2_medium_autocannon',1,1,0.33),
('def_npc_gamma_echelon_advanced_observer','def_named2_webber',1,1,0.33),
('def_npc_gamma_echelon_advanced_observer','def_named2_sensor_booster',1,1,0.33),
('def_npc_gamma_echelon_advanced_observer','def_named2_damage_mod_projectile',1,1,0.33),
('def_npc_gamma_echelon_advanced_observer','def_reactore_core_mech',1,1,0.1),
('def_npc_gamma_echelon_advanced_observer','def_research_kit_7',1,1,0.05),
('def_npc_gamma_echelon_advanced_observer','def_research_kit_8',1,1,0.05),


('def_npc_gamma_callisto_advanced_observer','def_common_reactor_plasma',24024,48048,1),
('def_npc_gamma_callisto_advanced_observer','def_kernel_common',10881,21762,1),
('def_npc_gamma_callisto_advanced_observer','def_kernel_hitech',15600,31200,1),
('def_npc_gamma_callisto_advanced_observer','def_material_boss_gamma_syndicate',20,40,1),
('def_npc_gamma_callisto_advanced_observer','def_ammo_medium_projectile_rewb',50,100,0.5),
('def_npc_gamma_callisto_advanced_observer','def_named3_longrange_medium_autocannon',1,1,0.22),
('def_npc_gamma_callisto_advanced_observer','def_named3_longrange_webber',1,1,0.22),
('def_npc_gamma_callisto_advanced_observer','def_named3_sensor_dampener',1,1,0.22),
('def_npc_gamma_callisto_advanced_observer','def_named3_sensor_jammer',1,1,0.22),
('def_npc_gamma_callisto_advanced_observer','def_named2_longrange_medium_autocannon',1,1,0.33),
('def_npc_gamma_callisto_advanced_observer','def_named2_longrange_webber',1,1,0.33),
('def_npc_gamma_callisto_advanced_observer','def_named2_sensor_dampener',1,1,0.33),
('def_npc_gamma_callisto_advanced_observer','def_named2_sensor_jammer',1,1,0.33),
('def_npc_gamma_callisto_advanced_observer','def_reactore_core_mech',1,1,0.1),
('def_npc_gamma_callisto_advanced_observer','def_research_kit_7',1,1,0.05),
('def_npc_gamma_callisto_advanced_observer','def_research_kit_8',1,1,0.05),


('def_npc_gamma_seth_boss_miniboss','def_thelodica_reactor_plasma',75000,150000,1),
('def_npc_gamma_seth_boss_miniboss','def_kernel_thelodica',37500,75000,1),
('def_npc_gamma_seth_boss_miniboss','def_kernel_hitech',37500,75000,1),
('def_npc_gamma_seth_boss_miniboss','def_kernel_common',37500,75000,1),
('def_npc_gamma_seth_boss_miniboss','def_material_boss_gamma_thelodica',500,700,1),
('def_npc_gamma_seth_boss_miniboss','def_ammo_medium_lasercrystal_rewb',600,1800,1),
('def_npc_gamma_seth_boss_miniboss','def_ammo_medium_lasercrystal_rewa',600,1800,1),
('def_npc_gamma_seth_boss_miniboss','def_named3_medium_laser',1,3,0.44),
('def_npc_gamma_seth_boss_miniboss','def_named3_resistant_plating',1,1,0.44),
('def_npc_gamma_seth_boss_miniboss','def_named3_armor_repairer_upgrade',1,1,0.44),
('def_npc_gamma_seth_boss_miniboss','def_named3_damage_mod_laser',1,1,0.44),
('def_npc_gamma_seth_boss_miniboss','def_named3_large_armor_plate',1,1,0.22),
('def_npc_gamma_seth_boss_miniboss','def_reactore_core_heavymech',1,2,0.3),
('def_npc_gamma_seth_boss_miniboss','def_reactore_core_mech',1,2,0.3),
('def_npc_gamma_seth_boss_miniboss','def_reactore_core_assault',1,2,0.3),
('def_npc_gamma_seth_boss_miniboss','def_reactore_core_runner',1,2,0.3),
('def_npc_gamma_seth_boss_miniboss','def_research_kit_8',1,1,0.3),
('def_npc_gamma_seth_boss_miniboss','def_research_kit_9',1,1,0.3),
('def_npc_gamma_seth_boss_miniboss','def_boost_ep_t0',1,1,0.3),
('def_npc_gamma_seth_boss_miniboss','def_seth_mk2_A_CT_capsule',1,1,0.3),
('def_npc_gamma_seth_boss_miniboss','def_artemis_mk2_A_CT_capsule',1,1,0.3),
('def_npc_gamma_seth_boss_miniboss','def_zenith_mk2_A_CT_capsule',1,1,0.3),


('def_npc_gamma_gropho_boss_miniboss','def_pelistal_reactor_plasma',75000,150000,1),
('def_npc_gamma_gropho_boss_miniboss','def_kernel_pelistal',37500,75000,1),
('def_npc_gamma_gropho_boss_miniboss','def_kernel_hitech',37500,75000,1),
('def_npc_gamma_gropho_boss_miniboss','def_kernel_common',37500,75000,1),
('def_npc_gamma_gropho_boss_miniboss','def_material_boss_gamma_pelistal',500,700,1),
('def_npc_gamma_gropho_boss_miniboss','def_ammo_missile_rewa',300,800,1),
('def_npc_gamma_gropho_boss_miniboss','def_ammo_missile_rewb',300,800,1),
('def_npc_gamma_gropho_boss_miniboss','def_ammo_longrange_missile_rewa',300,800,1),
('def_npc_gamma_gropho_boss_miniboss','def_ammo_longrange_missile_rewb',300,800,1),
('def_npc_gamma_gropho_boss_miniboss','def_named3_missile_launcher',1,3,0.44),
('def_npc_gamma_gropho_boss_miniboss','def_named3_thrm_armor_hardener',1,1,0.44),
('def_npc_gamma_gropho_boss_miniboss','def_named3_shield_hardener',1,2,0.44),
('def_npc_gamma_gropho_boss_miniboss','def_named3_damage_mod_missile',1,1,0.44),
('def_npc_gamma_gropho_boss_miniboss','def_named3_core_recharger',1,2,0.44),
('def_npc_gamma_gropho_boss_miniboss','def_reactore_core_heavymech',1,2,0.3),
('def_npc_gamma_gropho_boss_miniboss','def_reactore_core_mech',1,2,0.3),
('def_npc_gamma_gropho_boss_miniboss','def_reactore_core_assault',1,2,0.3),
('def_npc_gamma_gropho_boss_miniboss','def_reactore_core_runner',1,2,0.3),
('def_npc_gamma_gropho_boss_miniboss','def_research_kit_8',1,1,0.3),
('def_npc_gamma_gropho_boss_miniboss','def_research_kit_9',1,1,0.3),
('def_npc_gamma_gropho_boss_miniboss','def_boost_ep_t0',1,1,0.3),
('def_npc_gamma_gropho_boss_miniboss','def_gropho_mk2_A_CT_capsule',1,1,0.3),
('def_npc_gamma_gropho_boss_miniboss','def_tyrannos_mk2_A_CT_capsule',1,1,0.3),
('def_npc_gamma_gropho_boss_miniboss','def_ictus_mk2_A_CT_capsule',1,1,0.3),


('def_npc_gamma_mesmer_boss_miniboss','def_nuimqol_reactor_plasma',75000,150000,1),
('def_npc_gamma_mesmer_boss_miniboss','def_kernel_nuimqol',37500,75000,1),
('def_npc_gamma_mesmer_boss_miniboss','def_kernel_hitech',37500,75000,1),
('def_npc_gamma_mesmer_boss_miniboss','def_kernel_common',37500,75000,1),
('def_npc_gamma_mesmer_boss_miniboss','def_material_boss_gamma_nuimqol',500,700,1),
('def_npc_gamma_mesmer_boss_miniboss','def_ammo_medium_railgun_rewb',450,1200,1),
('def_npc_gamma_mesmer_boss_miniboss','def_ammo_medium_railgun_rewa',450,1200,1),
('def_npc_gamma_mesmer_boss_miniboss','def_named3_medium_railgun',1,3,0.44),
('def_npc_gamma_mesmer_boss_miniboss','def_named3_medium_armor_repairer',1,2,0.44),
('def_npc_gamma_mesmer_boss_miniboss','def_named3_armor_repairer_upgrade',1,2,0.44),
('def_npc_gamma_mesmer_boss_miniboss','def_named3_damage_mod_railgun',1,1,0.44),
('def_npc_gamma_mesmer_boss_miniboss','def_named3_medium_core_booster',1,1,0.44),
('def_npc_gamma_mesmer_boss_miniboss','def_reactore_core_heavymech',1,2,0.3),
('def_npc_gamma_mesmer_boss_miniboss','def_reactore_core_mech',1,2,0.3),
('def_npc_gamma_mesmer_boss_miniboss','def_reactore_core_assault',1,2,0.3),
('def_npc_gamma_mesmer_boss_miniboss','def_reactore_core_runner',1,2,0.3),
('def_npc_gamma_mesmer_boss_miniboss','def_research_kit_8',1,1,0.3),
('def_npc_gamma_mesmer_boss_miniboss','def_research_kit_9',1,1,0.3),
('def_npc_gamma_mesmer_boss_miniboss','def_boost_ep_t0',1,1,0.3),
('def_npc_gamma_mesmer_boss_miniboss','def_mesmer_mk2_A_CT_capsule',1,1,0.3),
('def_npc_gamma_mesmer_boss_miniboss','def_kain_mk2_A_CT_capsule',1,1,0.3),
('def_npc_gamma_mesmer_boss_miniboss','def_vagabond_mk2_A_CT_capsule',1,1,0.3),


('def_npc_gamma_legatus_boss_miniboss','def_common_reactor_plasma',100000,200000,1),
('def_npc_gamma_legatus_boss_miniboss','def_kernel_hitech',50000,100000,1),
('def_npc_gamma_legatus_boss_miniboss','def_kernel_common',50000,100000,1),
('def_npc_gamma_legatus_boss_miniboss','def_material_boss_gamma_syndicate',500,700,1),
('def_npc_gamma_legatus_boss_miniboss','def_ammo_medium_projectile_rewb',600,1800,1),
('def_npc_gamma_legatus_boss_miniboss','def_ammo_medium_projectile_rewa',600,1800,1),
('def_npc_gamma_legatus_boss_miniboss','def_named3_medium_autocannon',1,3,0.44),
('def_npc_gamma_legatus_boss_miniboss','def_named3_resistant_plating',1,1,0.44),
('def_npc_gamma_legatus_boss_miniboss','def_named3_armor_repairer_upgrade',1,1,0.44),
('def_npc_gamma_legatus_boss_miniboss','def_named3_damage_mod_projectile',1,2,0.44),
('def_npc_gamma_legatus_boss_miniboss','def_named3_large_armor_plate',1,1,0.44),
('def_npc_gamma_legatus_boss_miniboss','def_reactore_core_heavymech',1,2,0.3),
('def_npc_gamma_legatus_boss_miniboss','def_reactore_core_mech',1,2,0.3),
('def_npc_gamma_legatus_boss_miniboss','def_reactore_core_assault',1,2,0.3),
('def_npc_gamma_legatus_boss_miniboss','def_reactore_core_runner',1,2,0.3),
('def_npc_gamma_legatus_boss_miniboss','def_research_kit_8',1,1,0.3),
('def_npc_gamma_legatus_boss_miniboss','def_research_kit_9',1,1,0.3),
('def_npc_gamma_legatus_boss_miniboss','def_boost_ep_t0',1,1,0.3),
('def_npc_gamma_legatus_boss_miniboss','def_boost_ep_t1',1,1,0.3),


('def_npc_gamma_onyx_mammoth_destro','def_thelodica_reactor_plasma',100000,200000,1),
('def_npc_gamma_onyx_mammoth_destro','def_kernel_thelodica',50000,100000,1),
('def_npc_gamma_onyx_mammoth_destro','def_kernel_hitech',50000,100000,1),
('def_npc_gamma_onyx_mammoth_destro','def_kernel_common',50000,100000,1),
('def_npc_gamma_onyx_mammoth_destro','def_material_boss_gamma_thelodica',100,200,1),
('def_npc_gamma_onyx_mammoth_destro','def_ammo_large_lasercrystal_rewa',2700,3600,1),
('def_npc_gamma_onyx_mammoth_destro','def_ammo_large_lasercrystal_d',200,600,1),
('def_npc_gamma_onyx_mammoth_destro','def_named3_longrange_large_laser',1,3,0.5),
('def_npc_gamma_onyx_mammoth_destro','def_named3_large_armor_plate',1,1,0.5),
('def_npc_gamma_onyx_mammoth_destro','def_named3_large_armor_repairer',1,1,0.5),
('def_npc_gamma_onyx_mammoth_destro','def_named3_resistant_plating',1,1,1),
('def_npc_gamma_onyx_mammoth_destro','def_reactore_core_heavymech',1,3,1),
('def_npc_gamma_onyx_mammoth_destro','def_boost_ep_t1',1,2,1),


('def_npc_gamma_hydra_mammoth_destro','def_pelistal_reactor_plasma',100000,200000,1),
('def_npc_gamma_hydra_mammoth_destro','def_kernel_pelistal',50000,100000,1),
('def_npc_gamma_hydra_mammoth_destro','def_kernel_hitech',50000,100000,1),
('def_npc_gamma_hydra_mammoth_destro','def_kernel_common',50000,100000,1),
('def_npc_gamma_hydra_mammoth_destro','def_material_boss_gamma_pelistal',100,200,1),
('def_npc_gamma_hydra_mammoth_destro','def_ammo_longrange_cruisemissile_rewa',900,1200,1),
('def_npc_gamma_hydra_mammoth_destro','def_ammo_cruisemissile_rewa',900,1200,1),
('def_npc_gamma_hydra_mammoth_destro','def_ammo_longrange_cruisemissile_d',75,200,1),
('def_npc_gamma_hydra_mammoth_destro','def_ammo_cruisemissile_d',75,200,1),
('def_npc_gamma_hydra_mammoth_destro','def_named3_cruisemissile_launcher',1,3,0.5),
('def_npc_gamma_hydra_mammoth_destro','def_named3_large_shield_generator',1,1,0.5),
('def_npc_gamma_hydra_mammoth_destro','def_named3_large_armor_repairer',1,1,0.5),
('def_npc_gamma_hydra_mammoth_destro','def_named3_shield_hardener',1,1,1),
('def_npc_gamma_hydra_mammoth_destro','def_reactore_core_heavymech',1,3,1),
('def_npc_gamma_hydra_mammoth_destro','def_boost_ep_t1',1,2,1),


('def_npc_gamma_felos_mammoth_destro','def_nuimqol_reactor_plasma',100000,200000,1),
('def_npc_gamma_felos_mammoth_destro','def_kernel_nuimqol',50000,100000,1),
('def_npc_gamma_felos_mammoth_destro','def_kernel_hitech',50000,100000,1),
('def_npc_gamma_felos_mammoth_destro','def_kernel_common',50000,100000,1),
('def_npc_gamma_felos_mammoth_destro','def_material_boss_gamma_nuimqol',100,200,1),
('def_npc_gamma_felos_mammoth_destro','def_ammo_large_railgun_rewa',1800,2700,1),
('def_npc_gamma_felos_mammoth_destro','def_ammo_large_railgun_d',125,450,1),
('def_npc_gamma_felos_mammoth_destro','def_named3_longrange_large_railgun',1,3,0.5),
('def_npc_gamma_felos_mammoth_destro','def_named3_large_core_booster',1,1,0.5),
('def_npc_gamma_felos_mammoth_destro','def_named3_large_armor_repairer',1,1,0.5),
('def_npc_gamma_felos_mammoth_destro','def_named3_resistant_plating',1,1,1),
('def_npc_gamma_felos_mammoth_destro','def_reactore_core_heavymech',1,3,1),
('def_npc_gamma_felos_mammoth_destro','def_boost_ep_t1',1,2,1),


('def_npc_gamma_onyx_thelodica_pitboss','def_thelodica_reactor_plasma',150000,300000,1),
('def_npc_gamma_onyx_thelodica_pitboss','def_kernel_thelodica',105000,210000,1),
('def_npc_gamma_onyx_thelodica_pitboss','def_kernel_hitech',105000,210000,1),
('def_npc_gamma_onyx_thelodica_pitboss','def_kernel_common',105000,210000,1),
('def_npc_gamma_onyx_thelodica_pitboss','def_material_boss_gamma_thelodica',10000,14000,1),
('def_npc_gamma_onyx_thelodica_pitboss','def_ammo_large_lasercrystal_b',300,900,1),
('def_npc_gamma_onyx_thelodica_pitboss','def_named3_large_laser',2,3,1),
('def_npc_gamma_onyx_thelodica_pitboss','def_named3_large_armor_plate',1,2,1),
('def_npc_gamma_onyx_thelodica_pitboss','def_named3_large_armor_repairer',1,1,1),
('def_npc_gamma_onyx_thelodica_pitboss','def_named3_resistant_plating',1,2,1),
('def_npc_gamma_onyx_thelodica_pitboss','def_named3_armor_repairer_upgrade',1,2,1),
('def_npc_gamma_onyx_thelodica_pitboss','def_named3_gang_assist_precision_firing_module',1,1,1),
('def_npc_gamma_onyx_thelodica_pitboss','def_named3_gang_assist_defense_module',1,1,1),
('def_npc_gamma_onyx_thelodica_pitboss','def_reactore_core_heavymech',2,4,1),
('def_npc_gamma_onyx_thelodica_pitboss','def_reactore_core_mech',2,4,1),
('def_npc_gamma_onyx_thelodica_pitboss','def_reactore_core_assault',2,4,1),
('def_npc_gamma_onyx_thelodica_pitboss','def_reactore_core_runner',2,4,1),
('def_npc_gamma_onyx_thelodica_pitboss','def_boost_ep_t0',2,4,1),
('def_npc_gamma_onyx_thelodica_pitboss','def_boost_ep_t1',2,3,1),
('def_npc_gamma_onyx_thelodica_pitboss','def_boost_ep_t2',1,2,1),
('def_npc_gamma_onyx_thelodica_pitboss','def_boost_ep_t3',1,1,1),


('def_npc_gamma_hydra_pelistal_pitboss','def_pelistal_reactor_plasma',150000,300000,1),
('def_npc_gamma_hydra_pelistal_pitboss','def_kernel_pelistal',105000,210000,1),
('def_npc_gamma_hydra_pelistal_pitboss','def_kernel_hitech',105000,210000,1),
('def_npc_gamma_hydra_pelistal_pitboss','def_kernel_common',105000,210000,1),
('def_npc_gamma_hydra_pelistal_pitboss','def_material_boss_gamma_pelistal',10000,14000,1),
('def_npc_gamma_hydra_pelistal_pitboss','def_ammo_longrange_cruisemissile_a',200,500,1),
('def_npc_gamma_hydra_pelistal_pitboss','def_named3_cruisemissile_launcher',2,3,1),
('def_npc_gamma_hydra_pelistal_pitboss','def_named3_large_shield_generator',1,1,1),
('def_npc_gamma_hydra_pelistal_pitboss','def_named3_large_armor_repairer',1,1,1),
('def_npc_gamma_hydra_pelistal_pitboss','def_named3_resistant_plating',1,2,1),
('def_npc_gamma_hydra_pelistal_pitboss','def_named3_shield_hardener',1,2,1),
('def_npc_gamma_hydra_pelistal_pitboss','def_named3_gang_assist_shared_dataprocessing_module',1,1,1),
('def_npc_gamma_hydra_pelistal_pitboss','def_named3_gang_assist_shield_calculation_module',1,1,1),
('def_npc_gamma_hydra_pelistal_pitboss','def_reactore_core_heavymech',2,4,1),
('def_npc_gamma_hydra_pelistal_pitboss','def_reactore_core_mech',2,4,1),
('def_npc_gamma_hydra_pelistal_pitboss','def_reactore_core_assault',2,4,1),
('def_npc_gamma_hydra_pelistal_pitboss','def_reactore_core_runner',2,4,1),
('def_npc_gamma_hydra_pelistal_pitboss','def_boost_ep_t0',2,4,1),
('def_npc_gamma_hydra_pelistal_pitboss','def_boost_ep_t1',2,3,1),
('def_npc_gamma_hydra_pelistal_pitboss','def_boost_ep_t2',1,2,1),
('def_npc_gamma_hydra_pelistal_pitboss','def_boost_ep_t3',1,1,1),


('def_npc_gamma_felos_nuimqol_pitboss','def_nuimqol_reactor_plasma',150000,300000,1),
('def_npc_gamma_felos_nuimqol_pitboss','def_kernel_nuimqol',105000,210000,1),
('def_npc_gamma_felos_nuimqol_pitboss','def_kernel_hitech',105000,210000,1),
('def_npc_gamma_felos_nuimqol_pitboss','def_kernel_common',105000,210000,1),
('def_npc_gamma_felos_nuimqol_pitboss','def_material_boss_gamma_nuimqol',10000,14000,1),
('def_npc_gamma_felos_nuimqol_pitboss','def_ammo_large_railgun_a',600,1000,1),
('def_npc_gamma_felos_nuimqol_pitboss','def_named3_large_railgun',2,3,1),
('def_npc_gamma_felos_nuimqol_pitboss','def_named3_large_armor_plate',1,1,1),
('def_npc_gamma_felos_nuimqol_pitboss','def_named3_large_armor_repairer',1,2,1),
('def_npc_gamma_felos_nuimqol_pitboss','def_named3_resistant_plating',1,1,1),
('def_npc_gamma_felos_nuimqol_pitboss','def_named3_armor_repairer_upgrade',1,2,1),
('def_npc_gamma_felos_nuimqol_pitboss','def_named3_gang_assist_siege_module',1,1,1),
('def_npc_gamma_felos_nuimqol_pitboss','def_named3_gang_assist_maintance_module',1,1,1),
('def_npc_gamma_felos_nuimqol_pitboss','def_reactore_core_heavymech',2,4,1),
('def_npc_gamma_felos_nuimqol_pitboss','def_reactore_core_mech',2,4,1),
('def_npc_gamma_felos_nuimqol_pitboss','def_reactore_core_assault',2,4,1),
('def_npc_gamma_felos_nuimqol_pitboss','def_reactore_core_runner',2,4,1),
('def_npc_gamma_felos_nuimqol_pitboss','def_boost_ep_t0',2,4,1),
('def_npc_gamma_felos_nuimqol_pitboss','def_boost_ep_t1',2,3,1),
('def_npc_gamma_felos_nuimqol_pitboss','def_boost_ep_t2',1,2,1),
('def_npc_gamma_felos_nuimqol_pitboss','def_boost_ep_t3',1,1,1),


('def_npc_gamma_apollo_syndicate_syn_pitboss','def_common_reactor_plasma',225000,450000,1),
('def_npc_gamma_apollo_syndicate_syn_pitboss','def_kernel_hitech',150000,300000,1),
('def_npc_gamma_apollo_syndicate_syn_pitboss','def_kernel_common',150000,300000,1),
('def_npc_gamma_apollo_syndicate_syn_pitboss','def_material_boss_gamma_syndicate',10000,14000,1),
('def_npc_gamma_apollo_syndicate_syn_pitboss','def_named3_large_armor_plate',1,2,1),
('def_npc_gamma_apollo_syndicate_syn_pitboss','def_named3_large_armor_repairer',1,1,1),
('def_npc_gamma_apollo_syndicate_syn_pitboss','def_named3_resistant_plating',1,2,1),
('def_npc_gamma_apollo_syndicate_syn_pitboss','def_named3_armor_repairer_upgrade',1,2,1),
('def_npc_gamma_apollo_syndicate_syn_pitboss','def_standard_blob_emission_modulator',1,1,1),
('def_npc_gamma_apollo_syndicate_syn_pitboss','def_named3_gang_assist_coordinated_maneuvering_module',1,1,1),
('def_npc_gamma_apollo_syndicate_syn_pitboss','def_named3_gang_assist_ewar_range_module',1,1,1),
('def_npc_gamma_apollo_syndicate_syn_pitboss','def_reactore_core_heavymech',2,4,1),
('def_npc_gamma_apollo_syndicate_syn_pitboss','def_reactore_core_mech',2,4,1),
('def_npc_gamma_apollo_syndicate_syn_pitboss','def_reactore_core_assault',2,4,1),
('def_npc_gamma_apollo_syndicate_syn_pitboss','def_reactore_core_runner',2,4,1),
('def_npc_gamma_apollo_syndicate_syn_pitboss','def_boost_ep_t0',2,4,1),
('def_npc_gamma_apollo_syndicate_syn_pitboss','def_boost_ep_t1',2,3,1),
('def_npc_gamma_apollo_syndicate_syn_pitboss','def_boost_ep_t2',1,2,1),
('def_npc_gamma_apollo_syndicate_syn_pitboss','def_boost_ep_t3',1,1,1);

INSERT INTO #LOOTS (defName, lootName, minQuant, maxQuant, prob) VALUES
('def_npc_gamma_baphomet_advanced_courier','def_thelodica_reactor_plasma',2340,9360,1),
('def_npc_gamma_baphomet_advanced_courier','def_kernel_thelodica',3549,14196,1),
('def_npc_gamma_baphomet_advanced_courier','def_kernel_hitech',1300,5200,1),
('def_npc_gamma_baphomet_advanced_courier','def_kernel_common',1521,6084,1),
('def_npc_gamma_baphomet_advanced_courier','def_material_boss_gamma_thelodica',100,140,1),
('def_npc_gamma_baphomet_advanced_courier','def_ammo_small_lasercrystal_rewb',150,200,0.5),
('def_npc_gamma_baphomet_advanced_courier','def_ammo_medium_lasercrystal_rewa',80,120,0.5),
('def_npc_gamma_baphomet_advanced_courier','def_named3_medium_laser',1,1,0.22),
('def_npc_gamma_baphomet_advanced_courier','def_named3_small_laser',1,1,0.33),
('def_npc_gamma_baphomet_advanced_courier','def_named3_resistant_plating',1,1,0.22),
('def_npc_gamma_baphomet_advanced_courier','def_named3_mass_reductor',1,1,0.22),
('def_npc_gamma_baphomet_advanced_courier','def_named3_damage_mod_laser',1,1,0.22),
('def_npc_gamma_baphomet_advanced_courier','def_reactore_core_assault',1,1,0.75),
('def_npc_gamma_baphomet_advanced_courier','def_research_kit_8',1,2,0.25),
('def_npc_gamma_baphomet_advanced_courier','def_research_kit_9',1,1,0.15),


('def_npc_gamma_prometheus_advanced_courier','def_thelodica_reactor_plasma',1248,4992,1),
('def_npc_gamma_prometheus_advanced_courier','def_kernel_thelodica',1820,7280,1),
('def_npc_gamma_prometheus_advanced_courier','def_kernel_hitech',910,3640,1),
('def_npc_gamma_prometheus_advanced_courier','def_kernel_common',780,3120,1),
('def_npc_gamma_prometheus_advanced_courier','def_material_boss_gamma_thelodica',40,60,1),
('def_npc_gamma_prometheus_advanced_courier','def_ammo_small_lasercrystal_rewb',80,120,0.5),
('def_npc_gamma_prometheus_advanced_courier','def_ammo_medium_lasercrystal_rewa',80,120,0.5),
('def_npc_gamma_prometheus_advanced_courier','def_named3_medium_laser',1,1,0.22),
('def_npc_gamma_prometheus_advanced_courier','def_named3_small_laser',1,1,0.22),
('def_npc_gamma_prometheus_advanced_courier','def_named3_small_core_booster',1,1,0.22),
('def_npc_gamma_prometheus_advanced_courier','def_named3_mass_reductor',1,1,0.22),
('def_npc_gamma_prometheus_advanced_courier','def_named3_webber',1,1,0.22),
('def_npc_gamma_prometheus_advanced_courier','def_reactore_core_runner',1,1,0.75),
('def_npc_gamma_prometheus_advanced_courier','def_research_kit_8',1,2,0.25),
('def_npc_gamma_prometheus_advanced_courier','def_research_kit_9',1,1,0.15),


('def_npc_gamma_intakt_advanced_courier','def_thelodica_reactor_plasma',2340,9360,1),
('def_npc_gamma_intakt_advanced_courier','def_kernel_thelodica',3549,14196,1),
('def_npc_gamma_intakt_advanced_courier','def_kernel_hitech',1300,5200,1),
('def_npc_gamma_intakt_advanced_courier','def_kernel_common',1521,6084,1),
('def_npc_gamma_intakt_advanced_courier','def_material_boss_gamma_thelodica',60,100,1),
('def_npc_gamma_intakt_advanced_courier','def_ammo_small_lasercrystal_rewa',60,120,0.5),
('def_npc_gamma_intakt_advanced_courier','def_named3_small_laser',1,1,0.22),
('def_npc_gamma_intakt_advanced_courier','def_named3_small_core_booster',1,1,0.22),
('def_npc_gamma_intakt_advanced_courier','def_named3_mass_reductor',1,1,0.22),
('def_npc_gamma_intakt_advanced_courier','def_named3_sensor_dampener',1,1,0.22),
('def_npc_gamma_intakt_advanced_courier','def_named3_small_shield_generator',1,1,0.22),
('def_npc_gamma_intakt_advanced_courier','def_reactore_core_runner',1,1,0.9),
('def_npc_gamma_intakt_advanced_courier','def_research_kit_8',1,2,0.25),
('def_npc_gamma_intakt_advanced_courier','def_research_kit_9',1,1,0.15),


('def_npc_gamma_waspish_advanced_courier','def_pelistal_reactor_plasma',2340,9360,1),
('def_npc_gamma_waspish_advanced_courier','def_kernel_pelistal',3549,14196,1),
('def_npc_gamma_waspish_advanced_courier','def_kernel_hitech',1300,5200,1),
('def_npc_gamma_waspish_advanced_courier','def_kernel_common',1521,6084,1),
('def_npc_gamma_waspish_advanced_courier','def_material_boss_gamma_pelistal',100,140,1),
('def_npc_gamma_waspish_advanced_courier','def_ammo_rocket_rewb',80,100,0.5),
('def_npc_gamma_waspish_advanced_courier','def_ammo_missile_rewa',40,60,0.5),
('def_npc_gamma_waspish_advanced_courier','def_named3_rocket_launcher',1,1,0.33),
('def_npc_gamma_waspish_advanced_courier','def_named3_missile_launcher',1,1,0.22),
('def_npc_gamma_waspish_advanced_courier','def_named3_medium_core_battery',1,1,0.22),
('def_npc_gamma_waspish_advanced_courier','def_named3_mass_reductor',1,1,0.22),
('def_npc_gamma_waspish_advanced_courier','def_named3_shield_hardener',1,1,0.22),
('def_npc_gamma_waspish_advanced_courier','def_reactore_core_assault',1,1,0.75),
('def_npc_gamma_waspish_advanced_courier','def_research_kit_8',1,2,0.25),
('def_npc_gamma_waspish_advanced_courier','def_research_kit_9',1,1,0.15),


('def_npc_gamma_castel_advanced_courier','def_pelistal_reactor_plasma',1248,4992,1),
('def_npc_gamma_castel_advanced_courier','def_kernel_pelistal',1820,7280,1),
('def_npc_gamma_castel_advanced_courier','def_kernel_hitech',910,3640,1),
('def_npc_gamma_castel_advanced_courier','def_kernel_common',780,3120,1),
('def_npc_gamma_castel_advanced_courier','def_material_boss_gamma_pelistal',40,60,1),
('def_npc_gamma_castel_advanced_courier','def_ammo_rocket_rewb',40,60,0.5),
('def_npc_gamma_castel_advanced_courier','def_ammo_missile_rewa',40,60,0.5),
('def_npc_gamma_castel_advanced_courier','def_named3_rocket_launcher',1,1,0.22),
('def_npc_gamma_castel_advanced_courier','def_named3_missile_launcher',1,1,0.22),
('def_npc_gamma_castel_advanced_courier','def_named3_small_shield_generator',1,1,0.22),
('def_npc_gamma_castel_advanced_courier','def_named3_mass_reductor',1,1,0.22),
('def_npc_gamma_castel_advanced_courier','def_named3_sensor_booster',1,1,0.22),
('def_npc_gamma_castel_advanced_courier','def_reactore_core_runner',1,1,0.75),
('def_npc_gamma_castel_advanced_courier','def_research_kit_8',1,2,0.25),
('def_npc_gamma_castel_advanced_courier','def_research_kit_9',1,1,0.15),


('def_npc_gamma_troiar_advanced_courier','def_pelistal_reactor_plasma',2340,9360,1),
('def_npc_gamma_troiar_advanced_courier','def_kernel_pelistal',3549,14196,1),
('def_npc_gamma_troiar_advanced_courier','def_kernel_hitech',1300,5200,1),
('def_npc_gamma_troiar_advanced_courier','def_kernel_common',1521,6084,1),
('def_npc_gamma_troiar_advanced_courier','def_material_boss_gamma_pelistal',60,100,1),
('def_npc_gamma_troiar_advanced_courier','def_ammo_missile_rewa',40,60,0.5),
('def_npc_gamma_troiar_advanced_courier','def_named3_missile_launcher',1,1,0.22),
('def_npc_gamma_troiar_advanced_courier','def_named3_small_core_booster',1,1,0.22),
('def_npc_gamma_troiar_advanced_courier','def_named3_mass_reductor',1,1,0.22),
('def_npc_gamma_troiar_advanced_courier','def_named3_small_energy_neutralizer',1,1,0.22),
('def_npc_gamma_troiar_advanced_courier','def_named3_small_energy_vampire',1,1,0.22),
('def_npc_gamma_troiar_advanced_courier','def_reactore_core_runner',1,1,0.9),
('def_npc_gamma_troiar_advanced_courier','def_research_kit_8',1,2,0.25),
('def_npc_gamma_troiar_advanced_courier','def_research_kit_9',1,1,0.15),


('def_npc_gamma_arbalest_advanced_courier','def_nuimqol_reactor_plasma',2340,9360,1),
('def_npc_gamma_arbalest_advanced_courier','def_kernel_nuimqol',3549,14196,1),
('def_npc_gamma_arbalest_advanced_courier','def_kernel_hitech',1300,5200,1),
('def_npc_gamma_arbalest_advanced_courier','def_kernel_common',1521,6084,1),
('def_npc_gamma_arbalest_advanced_courier','def_material_boss_gamma_nuimqol',100,140,1),
('def_npc_gamma_arbalest_advanced_courier','def_ammo_small_railgun_rewb',120,150,0.5),
('def_npc_gamma_arbalest_advanced_courier','def_ammo_medium_railgun_rewa',80,100,0.5),
('def_npc_gamma_arbalest_advanced_courier','def_named3_small_railgun',1,1,0.33),
('def_npc_gamma_arbalest_advanced_courier','def_named3_medium_railgun',1,1,0.22),
('def_npc_gamma_arbalest_advanced_courier','def_named3_small_core_booster',1,1,0.22),
('def_npc_gamma_arbalest_advanced_courier','def_named3_mass_reductor',1,1,0.22),
('def_npc_gamma_arbalest_advanced_courier','def_named3_small_armor_repairer',1,1,0.22),
('def_npc_gamma_arbalest_advanced_courier','def_reactore_core_assault',1,1,0.75),
('def_npc_gamma_arbalest_advanced_courier','def_research_kit_8',1,2,0.25),
('def_npc_gamma_arbalest_advanced_courier','def_research_kit_9',1,1,0.15),


('def_npc_gamma_yagel_advanced_courier','def_nuimqol_reactor_plasma',1248,4992,1),
('def_npc_gamma_yagel_advanced_courier','def_kernel_nuimqol',1820,7280,1),
('def_npc_gamma_yagel_advanced_courier','def_kernel_hitech',910,3640,1),
('def_npc_gamma_yagel_advanced_courier','def_kernel_common',780,3120,1),
('def_npc_gamma_yagel_advanced_courier','def_material_boss_gamma_nuimqol',40,60,1),
('def_npc_gamma_yagel_advanced_courier','def_ammo_small_railgun_rewb',80,100,0.5),
('def_npc_gamma_yagel_advanced_courier','def_ammo_medium_railgun_rewa',80,100,0.5),
('def_npc_gamma_yagel_advanced_courier','def_named3_small_railgun',1,1,0.22),
('def_npc_gamma_yagel_advanced_courier','def_named3_medium_railgun',1,1,0.22),
('def_npc_gamma_yagel_advanced_courier','def_named3_armor_repairer_upgrade',1,1,0.22),
('def_npc_gamma_yagel_advanced_courier','def_named3_mass_reductor',1,1,0.22),
('def_npc_gamma_yagel_advanced_courier','def_named3_sensor_booster',1,1,0.22),
('def_npc_gamma_yagel_advanced_courier','def_reactore_core_runner',1,1,0.75),
('def_npc_gamma_yagel_advanced_courier','def_research_kit_8',1,2,0.25),
('def_npc_gamma_yagel_advanced_courier','def_research_kit_9',1,1,0.15),


('def_npc_gamma_cameleon_advanced_courier','def_nuimqol_reactor_plasma',2340,9360,1),
('def_npc_gamma_cameleon_advanced_courier','def_kernel_nuimqol',3549,14196,1),
('def_npc_gamma_cameleon_advanced_courier','def_kernel_hitech',1300,5200,1),
('def_npc_gamma_cameleon_advanced_courier','def_kernel_common',1521,6084,1),
('def_npc_gamma_cameleon_advanced_courier','def_material_boss_gamma_nuimqol',60,100,1),
('def_npc_gamma_cameleon_advanced_courier','def_ammo_small_railgun_rewa',80,100,0.5),
('def_npc_gamma_cameleon_advanced_courier','def_named3_small_railgun',1,1,0.22),
('def_npc_gamma_cameleon_advanced_courier','def_named3_small_core_booster',1,1,0.22),
('def_npc_gamma_cameleon_advanced_courier','def_named3_mass_reductor',1,1,0.22),
('def_npc_gamma_cameleon_advanced_courier','def_named3_sensor_jammer',1,1,0.22),
('def_npc_gamma_cameleon_advanced_courier','def_named3_medium_energy_vampire',1,1,0.22),
('def_npc_gamma_cameleon_advanced_courier','def_reactore_core_runner',1,1,0.9),
('def_npc_gamma_cameleon_advanced_courier','def_research_kit_8',1,2,0.25),
('def_npc_gamma_cameleon_advanced_courier','def_research_kit_9',1,1,0.15),


('def_npc_gamma_locust_advanced_courier','def_common_reactor_plasma',2808,11232,1),
('def_npc_gamma_locust_advanced_courier','def_kernel_common',4563,18252,1),
('def_npc_gamma_locust_advanced_courier','def_kernel_hitech',2600,10400,1),
('def_npc_gamma_locust_advanced_courier','def_material_boss_gamma_syndicate',100,140,1),
('def_npc_gamma_locust_advanced_courier','def_ammo_small_projectile_rewb',200,250,0.5),
('def_npc_gamma_locust_advanced_courier','def_ammo_medium_projectile_rewa',120,160,0.5),
('def_npc_gamma_locust_advanced_courier','def_named3_medium_autocannon',1,1,0.22),
('def_npc_gamma_locust_advanced_courier','def_named3_small_autocannon',1,1,0.33),
('def_npc_gamma_locust_advanced_courier','def_named3_medium_armor_plate',1,1,0.22),
('def_npc_gamma_locust_advanced_courier','def_named3_mass_reductor',1,1,0.22),
('def_npc_gamma_locust_advanced_courier','def_named3_damage_mod_projectile',1,1,0.22),
('def_npc_gamma_locust_advanced_courier','def_reactore_core_assault',1,1,0.75),
('def_npc_gamma_locust_advanced_courier','def_research_kit_8',1,2,0.25),
('def_npc_gamma_locust_advanced_courier','def_research_kit_9',1,1,0.15),


('def_npc_gamma_vektor_advanced_courier','def_common_reactor_plasma',1500,6000,1),
('def_npc_gamma_vektor_advanced_courier','def_kernel_common',2340,9360,1),
('def_npc_gamma_vektor_advanced_courier','def_kernel_hitech',1820,7280,1),
('def_npc_gamma_vektor_advanced_courier','def_material_boss_gamma_syndicate',40,60,1),
('def_npc_gamma_vektor_advanced_courier','def_ammo_small_projectile_rewb',120,160,0.5),
('def_npc_gamma_vektor_advanced_courier','def_ammo_medium_projectile_rewa',120,160,0.5),
('def_npc_gamma_vektor_advanced_courier','def_named3_medium_autocannon',1,1,0.22),
('def_npc_gamma_vektor_advanced_courier','def_named3_small_autocannon',1,1,0.22),
('def_npc_gamma_vektor_advanced_courier','def_named3_small_armor_repairer',1,1,0.22),
('def_npc_gamma_vektor_advanced_courier','def_named3_mass_reductor',1,1,0.22),
('def_npc_gamma_vektor_advanced_courier','def_named3_sensor_jammer',1,1,0.22),
('def_npc_gamma_vektor_advanced_courier','def_reactore_core_runner',1,1,0.75),
('def_npc_gamma_vektor_advanced_courier','def_research_kit_8',1,2,0.25),
('def_npc_gamma_vektor_advanced_courier','def_research_kit_9',1,1,0.15),


('def_npc_gamma_helix_advanced_courier','def_common_reactor_plasma',2808,11232,1),
('def_npc_gamma_helix_advanced_courier','def_kernel_common',4563,18252,1),
('def_npc_gamma_helix_advanced_courier','def_kernel_hitech',2600,10400,1),
('def_npc_gamma_helix_advanced_courier','def_material_boss_gamma_syndicate',60,100,1),
('def_npc_gamma_helix_advanced_courier','def_ammo_small_projectile_rewa',120,160,0.5),
('def_npc_gamma_helix_advanced_courier','def_named3_small_autocannon',1,1,0.22),
('def_npc_gamma_helix_advanced_courier','def_named3_maneuvering_upgrade',1,1,0.22),
('def_npc_gamma_helix_advanced_courier','def_named3_mass_reductor',1,1,0.22),
('def_npc_gamma_helix_advanced_courier','def_named3_small_energy_vampire',1,1,0.22),
('def_npc_gamma_helix_advanced_courier','def_named3_webber',1,1,0.22),
('def_npc_gamma_helix_advanced_courier','def_reactore_core_runner',1,1,0.9),
('def_npc_gamma_helix_advanced_courier','def_research_kit_8',1,2,0.25),
('def_npc_gamma_helix_advanced_courier','def_research_kit_9',1,1,0.15),


('def_npc_gamma_hermes_advanced_courier','def_common_reactor_plasma',1250,5000,1),
('def_npc_gamma_hermes_advanced_courier','def_kernel_hitech',3750,15000,1),
('def_npc_gamma_hermes_advanced_courier','def_material_boss_gamma_syndicate',240,300,1),
('def_npc_gamma_hermes_advanced_courier','def_ammo_small_projectile_rewa',150,300,1),
('def_npc_gamma_hermes_advanced_courier','def_ammo_medium_projectile_rewa',150,300,1),
('def_npc_gamma_hermes_advanced_courier','def_named3_webber',1,1,0.22),
('def_npc_gamma_hermes_advanced_courier','def_named3_small_autocannon',1,1,0.22),
('def_npc_gamma_hermes_advanced_courier','def_named3_medium_autocannon',1,1,0.22),
('def_npc_gamma_hermes_advanced_courier','def_robotshard_common_basic',150,500,0.5),
('def_npc_gamma_hermes_advanced_courier','def_robotshard_common_advanced',150,300,0.5),
('def_npc_gamma_hermes_advanced_courier','def_robotshard_common_expert',150,200,0.5),
('def_npc_gamma_hermes_advanced_courier','def_npc_egg_nuimqol_medium_miniboss3_capsule',1,1,0.2),
('def_npc_gamma_hermes_advanced_courier','def_npc_egg_pelistal_medium_miniboss3_capsule',1,1,0.2),
('def_npc_gamma_hermes_advanced_courier','def_npc_egg_thelodica_medium_miniboss3_capsule',1,1,0.2),
('def_npc_gamma_hermes_advanced_courier','def_mobile_teleport_capsule_standard',1,1,0.5),
('def_npc_gamma_hermes_advanced_courier','def_research_kit_8',1,2,0.9),
('def_npc_gamma_hermes_advanced_courier','def_research_kit_9',1,1,0.75),
('def_npc_gamma_hermes_advanced_courier','def_research_kit_10',1,1,0.5),


('def_npc_gamma_sequer_advanced_courier','def_common_reactor_plasma',1875,7500,1),
('def_npc_gamma_sequer_advanced_courier','def_kernel_hitech',2500,10000,1),
('def_npc_gamma_sequer_advanced_courier','def_material_boss_gamma_syndicate',140,180,1),
('def_npc_gamma_sequer_advanced_courier','def_named3_medium_core_battery',1,1,0.22),
('def_npc_gamma_sequer_advanced_courier','def_named3_shield_hardener',1,1,0.22),
('def_npc_gamma_sequer_advanced_courier','def_npc_egg_nuimqol_medium_expert_capsule',1,1,0.22),
('def_npc_gamma_sequer_advanced_courier','def_npc_egg_pelistal_medium_expert_capsule',1,1,0.22),
('def_npc_gamma_sequer_advanced_courier','def_npc_egg_thelodica_medium_expert_capsule',1,1,0.22),
('def_npc_gamma_sequer_advanced_courier','def_robotshard_common_basic',100,500,0.5),
('def_npc_gamma_sequer_advanced_courier','def_robotshard_common_advanced',100,300,0.5),
('def_npc_gamma_sequer_advanced_courier','def_robotshard_common_expert',100,200,0.5),
('def_npc_gamma_sequer_advanced_courier','def_research_kit_8',1,2,0.75),
('def_npc_gamma_sequer_advanced_courier','def_research_kit_9',1,1,0.5),
('def_npc_gamma_sequer_advanced_courier','def_research_kit_10',1,1,0.25),


('def_npc_gamma_ikarus_advanced_courier','def_common_reactor_plasma',625,2500,1),
('def_npc_gamma_ikarus_advanced_courier','def_kernel_hitech',750,3000,1),
('def_npc_gamma_ikarus_advanced_courier','def_material_boss_gamma_syndicate',80,120,1),
('def_npc_gamma_ikarus_advanced_courier','def_named3_medium_energy_vampire',1,1,0.22),
('def_npc_gamma_ikarus_advanced_courier','def_npc_egg_nuimqol_small_expert_capsule',1,1,0.22),
('def_npc_gamma_ikarus_advanced_courier','def_npc_egg_pelistal_small_expert_capsule',1,1,0.22),
('def_npc_gamma_ikarus_advanced_courier','def_npc_egg_thelodica_small_expert_capsule',1,1,0.22),
('def_npc_gamma_ikarus_advanced_courier','def_robotshard_common_basic',50,250,0.5),
('def_npc_gamma_ikarus_advanced_courier','def_robotshard_common_advanced',50,150,0.5),
('def_npc_gamma_ikarus_advanced_courier','def_robotshard_common_expert',50,100,0.5),
('def_npc_gamma_ikarus_advanced_courier','def_research_kit_8',1,2,0.25),
('def_npc_gamma_ikarus_advanced_courier','def_research_kit_9',1,1,0.15),
('def_npc_gamma_ikarus_advanced_courier','def_research_kit_10',1,1,0.1);


PRINT N'DELETE/RE-INSERT LOOTS FOR SPECIAL GAMMA NPC TYPES';
SELECT * FROM npcloot WHERE definition IN (
	SELECT definition FROM entitydefaults where definitionname IN (
		SELECT DISTINCT defName FROM #LOOTS
	)
);

DELETE FROM npcloot WHERE definition IN (
	SELECT definition FROM entitydefaults where definitionname IN (
		SELECT DISTINCT defName FROM #LOOTS
	)
);

INSERT INTO npcloot (definition, lootdefinition, minquantity, quantity, probability, repackaged, dontdamage)
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defName),
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=lootName),
	minQuant, maxQuant, prob, 0, CASE WHEN lootName like '%named%' or lootName like '%standard%' THEN 0 ELSE 1 END
 FROM #LOOTS;

 DROP TABLE IF EXISTS #LOOTS;
 GO


PRINT N'34_update_robottemplaterelations_ep__2021_11_02.sql';
USE [perpetuumsa]
GO

--------------------------------------------
-- Gamma NPC EPs
-- TODO: missing special levels: courier/indy/observer/mini/boss
-- Date Modified: 2021/11/02
--------------------------------------------

DROP TABLE IF EXISTS #BOTS_BY_FACTION;
CREATE TABLE #BOTS_BY_FACTION(
	botName varchar(64),
	className varchar(64),
	faction varchar(64)
);
INSERT INTO #BOTS_BY_FACTION (botName, className, faction) VALUES
('apollo', 'destroyer', 'syndicate'),
('arbalest', 'assault', 'nuimqol'),
('artemis', 'mech', 'thelodica'),
('baphomet', 'assault', 'thelodica'),
('callisto', 'mech', 'syndicate'),
('cameleon', 'light ewar', 'nuimqol'),
('castel', 'light', 'pelistal'),
('cronus', 'assault indy', 'syndicate'),
('daidalos', 'mech indy', 'syndicate'),
('echelon', 'mech', 'syndicate'),
('felos', 'destroyer', 'nuimqol'),
('gargoyle', 'mech indy', 'industrial'),
('gropho', 'heavy mech', 'pelistal'),
('helix', 'light ewar', 'syndicate'),
('hermes', 'assault indy', 'syndicate'),
('hydra', 'destroyer', 'pelistal'),
('ictus', 'mech ewar', 'pelistal'),
('ikarus', 'light indy', 'syndicate'),
('intakt', 'light ewar', 'thelodica'),
('kain', 'mech', 'nuimqol'),
('laird', 'light indy', 'industrial'),
('legatus', 'heavy mech', 'syndicate'),
('lithus', 'heavy mech indy', 'industrial'),
('locust', 'assault', 'syndicate'),
('mesmer', 'heavy mech', 'nuimqol'),
('onyx', 'destroyer', 'thelodica'),
('prometheus', 'light', 'thelodica'),
('riveler', 'heavy mech indy', 'industrial'),
('scarab', 'heavy mech indy', 'industrial'),
('sequer', 'assault indy', 'industrial'),
('seth', 'heavy mech', 'thelodica'),
('symbiont', 'heavy mech indy', 'industrial'),
('termis', 'mech indy', 'industrial'),
('troiar', 'light ewar', 'pelistal'),
('tyrannos', 'mech', 'pelistal'),
('vagabond', 'mech', 'nuimqol'),
('vektor', 'light', 'syndicate'),
('waspish', 'assault', 'pelistal'),
('yagel', 'light', 'nuimqol'),
('zenith', 'mech ewar', 'thelodica');

DROP TABLE IF EXISTS #NPCS_BY_FACTION_BY_LEVEL;
CREATE TABLE #NPCS_BY_FACTION_BY_LEVEL(
	def int,
	npcName varchar(128),
	className varchar(64),
	faction varchar(64),
	levelName varchar(32)
);
INSERT INTO #NPCS_BY_FACTION_BY_LEVEL (def, npcName, className, faction, levelName)
SELECT d.definition, d.definitionname, f.className, f.faction, RIGHT(d.definitionname, CHARINDEX('_',REVERSE(d.definitionname))-1)
FROM entitydefaults d
JOIN #BOTS_BY_FACTION f ON d.definitionname like '%'+f.botName+'%'
WHERE definitionname like 'def_npc_gamma_%';


DROP TABLE IF EXISTS #EP_BY_LEVEL_AND_CLASS;
CREATE TABLE #EP_BY_LEVEL_AND_CLASS(
	levelName varchar(32),
	className varchar(32),
	ep int
);
INSERT INTO #EP_BY_LEVEL_AND_CLASS (levelName, className, ep) VALUES
('l7', 'heavy mech', 62),
('l7', 'mech', 62),
('l7', 'mech ewar', 62),
('l7', 'assault', 41),
('l7', 'light ewar', 41),
('l7', 'light', 41),

('l6', 'heavy mech', 43),
('l6', 'mech', 43),
('l6', 'mech ewar', 43),
('l6', 'assault', 28),
('l6', 'light ewar', 28),
('l6', 'light', 28),

('l5', 'heavy mech', 31),
('l5', 'mech', 31),
('l5', 'mech ewar', 31),
('l5', 'assault', 20),
('l5', 'light ewar', 20),
('l5', 'light', 20),

('l4', 'heavy mech', 24),
('l4', 'mech', 24),
('l4', 'mech ewar', 24),
('l4', 'assault', 16),
('l4', 'light ewar', 16),
('l4', 'light', 16),

('l3', 'heavy mech', 18),
('l3', 'mech', 18),
('l3', 'mech ewar', 18),
('l3', 'assault', 12),
('l3', 'light ewar', 12),
('l3', 'light', 12);

PRINT N'UPDATING KILLEP ON THESE RELATIONS:';
--select * from robottemplaterelation
--where definition in (select def from #NPCS_BY_FACTION_BY_LEVEL);

MERGE [dbo].[robottemplaterelation] r USING #NPCS_BY_FACTION_BY_LEVEL n
ON r.definition = n.def
WHEN MATCHED
    THEN UPDATE SET
		r.killep=(SELECT TOP 1 ep FROM #EP_BY_LEVEL_AND_CLASS e WHERE e.levelName=n.levelName AND e.className=n.className);

PRINT N'UPDATED KILLEP ON GAMMA NPCS:';
select * from robottemplaterelation
where definition in (select def from #NPCS_BY_FACTION_BY_LEVEL);

DROP TABLE IF EXISTS #BOTS_BY_FACTION;
DROP TABLE IF EXISTS #EP_BY_LEVEL_AND_CLASS;
DROP TABLE IF EXISTS #NPCS_BY_FACTION_BY_LEVEL;
GO



PRINT N'35_update_robottemplaterelations_ep_part2__2021_11_04.sql';
USE [perpetuumsa]
GO

--------------------------------------------
-- Gamma NPC EP part 2, the special defs
-- Date modified: 2021/11/04
--------------------------------------------

DROP TABLE IF EXISTS #EP_BY_DEFNAME;
CREATE TABLE #EP_BY_DEFNAME(
	defName varchar(128),
	ep int
);
INSERT INTO #EP_BY_DEFNAME (defName, ep) VALUES
('def_npc_gamma_sequer_basic_lindy',40),
('def_npc_gamma_lithus_basic_lindy',60),
('def_npc_gamma_scarab_basic_lindy',90),
('def_npc_gamma_ikarus_basic_lindy',25),
('def_npc_gamma_daidalos_basic_lindy',50),
('def_npc_gamma_cronus_basic_lindy',40),
('def_npc_gamma_riveler_basic_lindy',60),
('def_npc_gamma_symbiont_basic_lindy',60),
('def_npc_gamma_termis_basic_lindy',50),
('def_npc_gamma_gargoyle_basic_lindy',50),
('def_npc_gamma_argano_basic_lindy',25),
('def_npc_gamma_laird_basic_lindy',25),
('def_npc_gamma_hermes_basic_lindy',40),
('def_npc_gamma_seth_advanced_observer',120),
('def_npc_gamma_artemis_advanced_observer',90),
('def_npc_gamma_zenith_advanced_observer',90),
('def_npc_gamma_gropho_advanced_observer',120),
('def_npc_gamma_tyrannos_advanced_observer',90),
('def_npc_gamma_ictus_advanced_observer',90),
('def_npc_gamma_mesmer_advanced_observer',120),
('def_npc_gamma_kain_advanced_observer',90),
('def_npc_gamma_vagabond_advanced_observer',90),
('def_npc_gamma_legatus_advanced_observer',120),
('def_npc_gamma_echelon_advanced_observer',90),
('def_npc_gamma_callisto_advanced_observer',90),
('def_npc_gamma_seth_boss_miniboss',300),
('def_npc_gamma_gropho_boss_miniboss',300),
('def_npc_gamma_mesmer_boss_miniboss',300),
('def_npc_gamma_legatus_boss_miniboss',300),
('def_npc_gamma_onyx_mammoth_destro',150),
('def_npc_gamma_hydra_mammoth_destro',150),
('def_npc_gamma_felos_mammoth_destro',150),
('def_npc_gamma_onyx_thelodica_pitboss',3000),
('def_npc_gamma_hydra_pelistal_pitboss',3000),
('def_npc_gamma_felos_nuimqol_pitboss',3000),
('def_npc_gamma_apollo_syndicate_syn_pitboss',3000),
('def_npc_gamma_baphomet_advanced_courier',90),
('def_npc_gamma_prometheus_advanced_courier',60),
('def_npc_gamma_intakt_advanced_courier',60),
('def_npc_gamma_waspish_advanced_courier',90),
('def_npc_gamma_castel_advanced_courier',60),
('def_npc_gamma_troiar_advanced_courier',60),
('def_npc_gamma_arbalest_advanced_courier',90),
('def_npc_gamma_yagel_advanced_courier',60),
('def_npc_gamma_cameleon_advanced_courier',60),
('def_npc_gamma_locust_advanced_courier',90),
('def_npc_gamma_vektor_advanced_courier',60),
('def_npc_gamma_helix_advanced_courier',60),
('def_npc_gamma_hermes_advanced_courier',90),
('def_npc_gamma_sequer_advanced_courier',60),
('def_npc_gamma_ikarus_advanced_courier',30);


MERGE [dbo].[robottemplaterelation] r USING #EP_BY_DEFNAME e
ON r.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=e.defName)
WHEN MATCHED
    THEN UPDATE SET
		r.killep = e.ep;

PRINT N'UPDATED KILLEP ON GAMMA NPCS round 2:';
SELECT * FROM robottemplaterelation
WHERE definition IN (
	SELECT definition FROM entitydefaults WHERE definitionname IN (
		SELECT distinct defName FROM #EP_BY_DEFNAME
	)
);

DROP TABLE IF EXISTS #EP_BY_DEFNAME;
GO


PRINT N'46_market_alpha_gammaitems__2021_10_14.sql';

USE [perpetuumsa]
GO

---------------------------------------
-- NPC ALPHA MARKET SELLS for gamma items
-- Staging base, T0 blocks, decon, mods etc.
-- Date modified: 2021/11/01
---------------------------------------


DROP TABLE IF EXISTS #SELLS;
CREATE TABLE #SELLS(
	defName VARCHAR(100),
	price FLOAT
);
INSERT INTO #SELLS (defName, price) VALUES
('def_construction_module_ammo_t0', 100000),
('def_pbs_expiring_docking_base', 25000000),
('def_ammo_terraform',7500),
('def_pbs_construction_module',500000),
('def_terraform_multi_module',500000),
('def_construction_module_ammo_deconstruct', 10000);


PRINT N'SELECT TERMINAL DEFINITIONS';
DECLARE @MAIN_TERMINAL_DEFS AS TABLE (definition INT);
INSERT INTO @MAIN_TERMINAL_DEFS
SELECT definition FROM entitydefaults WHERE definitionname IN (
	'def_public_docking_base_nuimqol',
	'def_public_docking_base_pelistal',
	'def_public_docking_base_thelodica'
);

DECLARE @MAIN_AND_PVE_OUTPOSTS AS TABLE (definition INT);
INSERT INTO @MAIN_AND_PVE_OUTPOSTS (definition)
SELECT definition FROM entitydefaults WHERE definitionname IN (
	'def_public_docking_base_nuimqol_outpost_pve',
	'def_public_docking_base_thelodica_outpost_pve',
	'def_public_docking_base_pelistal_outpost_pve'
);
INSERT INTO @MAIN_AND_PVE_OUTPOSTS (definition)
SELECT definition FROM @MAIN_TERMINAL_DEFS;

PRINT N'SELECT MARKET ENTITIES';
DECLARE @ALPHA_MARKETS TABLE (eid BIGINT);
DECLARE @BETA_PUBLIC_MARKETS TABLE (eid BIGINT);
DECLARE @MARKET_DEF AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_public_market');

INSERT INTO @ALPHA_MARKETS (eid)
SELECT e.eid FROM entities e
JOIN zoneentities ze ON e.parent=ze.eid
JOIN zones z ON z.id=ze.zoneID
WHERE 
	(SELECT TOP 1 definition FROM entities WHERE eid=ze.eid) IN (SELECT definition FROM @MAIN_AND_PVE_OUTPOSTS) AND 
	e.definition=@MARKET_DEF AND z.protected=1 AND zonetype=1; --alpha

DECLARE @VENDOR_DEF AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_public_vendor');

DECLARE @ALPHA_MARKETS_AND_VENDOR TABLE (market BIGINT, vendor BIGINT);
INSERT INTO @ALPHA_MARKETS_AND_VENDOR (market, vendor)
SELECT m.eid market, v.eid vendor FROM entities v
JOIN entities m ON m.parent=v.parent AND v.definition=@VENDOR_DEF AND m.eid IN (SELECT eid FROM @ALPHA_MARKETS);

DECLARE @ALPHA_ORDERS TABLE (marketEid BIGINT, itemDef INT, vendorEid BIGINT, price FLOAT);
INSERT INTO @ALPHA_ORDERS (marketEid, itemDef, vendorEid, price)
SELECT market,
 (select definition from entitydefaults where definitionname=defName), 
 vendor, price
FROM @ALPHA_MARKETS_AND_VENDOR m
JOIN #SELLS o ON 1=1;

MERGE [dbo].[marketitems] m USING @ALPHA_ORDERS o
ON m.marketeid = o.marketEid AND
m.itemdefinition = o.itemDef AND
m.submittereid = o.vendorEid AND
m.isSell=0 AND m.isVendorItem=1 AND m.duration=0 AND m.quantity=-1
WHEN MATCHED
    THEN UPDATE SET
		price = o.price
WHEN NOT MATCHED
    THEN INSERT (marketeid, itemdefinition, submittereid, duration, isSell, price, quantity, usecorporationwallet, isvendoritem) VALUES
	(o.marketEid, o.itemDef, o.vendorEid, 0, 1, o.price, -1, 0, 1);

PRINT N'ALPHA ORDERS FOR GAMMA SEEDED';
GO



PRINT N'PATCH 27 COMPLETE';
GO
