USE [perpetuumsa]
GO

------------------------------------------------------------------------
-- PBS deployable item (capsule) prototype definitions
-- Create a 1:1 copy of definition and stats but target research tree to prototype
-- And RE to yield CT
-- Date Modified: 2021/07/25
------------------------------------------------------------------------

DECLARE @HIDDEN AS BIT = 1;
DECLARE @PURCHASABLE AS BIT = 0;

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
	1, d.volume, d.mass, @HIDDEN, d.health, d.descriptiontoken, @PURCHASABLE, 2, d.tierlevel FROM entitydefaults d
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
