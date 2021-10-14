USE [perpetuumsa]
GO


-----------------------------------------------
-- Expiring PBS base "staging base"
-- Adds a set of definitions, configs, stats, and components
-- TODO: research, CT, prototype, related bits, market seed?
-- 
-- Date modified: 2021/10/11 
-----------------------------------------------

DECLARE @DEF_NAME AS VARCHAR(100) = 'def_pbs_expiring_docking_base';
DECLARE @DEF AS INT = 6613;
DECLARE @DEF_OBJ AS INT = 6614;
DECLARE @DEF_CAP AS INT = 6615;

DECLARE @ENV_STR AS VARCHAR(MAX) = (SELECT TOP 1 descriptionstring from environmentdescription WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_docking_base_small'));


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
1, 200, 200000, 0, 100, @DEF_NAME+'_desc', 1, 1, 0);


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
(@DEF_CAP, @DEF_OBJ, NULL, 30000, 330, NULL, 6, 0, 100, 5, 0, 0, 0, 0, 0, NULL, 100, 0, 7.071, 'capsule->object staging base'),
(@DEF_OBJ, @DEF, 1, NULL, 330, 5000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '#000000', NULL, NULL, NULL, 'object->base staging'),
(@DEF, NULL, NULL, 30000, 330, NULL, 6, 0, 100, 5, 0, 0, 0, 0, 0, '#820028', 100, 0, 7.071, 'staging base');


DROP TABLE IF EXISTS #VALS;
CREATE TABLE #VALS(
	defname varchar(100),
	fieldname varchar(100),
	fieldvalue float
);
INSERT INTO #VALS(defname, fieldname, fieldvalue) VALUES
(@DEF_NAME,'armor_max',500000),
(@DEF_NAME,'resist_chemical',50),
(@DEF_NAME,'resist_explosive',50),
(@DEF_NAME,'resist_kinetic',50),
(@DEF_NAME,'resist_thermal',50),
(@DEF_NAME,'signature_radius',100),
(@DEF_NAME,'stealth_strength',75),
(@DEF_NAME+'_capsule','armor_max',500000),
(@DEF_NAME+'_capsule','resist_chemical',50),
(@DEF_NAME+'_capsule','resist_explosive',50),
(@DEF_NAME+'_capsule','resist_kinetic',50),
(@DEF_NAME+'_capsule','resist_thermal',50),
(@DEF_NAME+'_capsule','signature_radius',100),
(@DEF_NAME+'_capsule','stealth_strength',75),
(@DEF_NAME+'_object','armor_max',5000),
(@DEF_NAME+'_object','resist_chemical',50),
(@DEF_NAME+'_object','resist_explosive',50),
(@DEF_NAME+'_object','resist_kinetic',50),
(@DEF_NAME+'_object','resist_thermal',50),
(@DEF_NAME+'_object','signature_radius',5),
(@DEF_NAME+'_object','stealth_strength',155);


DROP TABLE IF EXISTS #COMPS;
CREATE TABLE #COMPS(
	defname varchar(100),
	compname varchar(100),
	compval int
);
INSERT INTO #COMPS(defname, compname, compval) VALUES
(@DEF_NAME+'_capsule','def_titanium',20000),
(@DEF_NAME+'_capsule','def_plasteosine',7500),
(@DEF_NAME+'_capsule','def_alligior',7500),
(@DEF_NAME+'_capsule','def_hydrobenol',2000),
(@DEF_NAME+'_capsule','def_espitium',5000),
(@DEF_NAME+'_capsule','def_unimetal',20000),
(@DEF_NAME+'_capsule','def_axicol',5000),
(@DEF_NAME+'_capsule','def_axicoline',2000);



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

DELETE FROM components WHERE definition IN (
	SELECT definition FROM entitydefaults WHERE definitionname IN (
		SELECT DISTINCT defname FROM #COMPS
	)
); 


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

PRINT N'UPSERT [components]';
MERGE [dbo].[components] c USING #COMPS p
ON c.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=p.defname) AND 
c.componentdefinition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=p.compname)
WHEN MATCHED
    THEN UPDATE SET
		componentdefinition = (SELECT TOP 1 id FROM entitydefaults WHERE definitionname=p.compname),
		componentamount = p.compval
WHEN NOT MATCHED
    THEN INSERT (definition, componentdefinition, componentamount) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=p.defname),
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=p.compname),
	p.compval);


DELETE FROM environmentdescription WHERE definition=@DEF;
INSERT INTO environmentdescription (definition, descriptionstring) VALUES
(@DEF,@ENV_STR);

GO