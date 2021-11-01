USE [perpetuumsa]
GO

--------------------------------------------------
-- New Fuel items
-- Date modified: 2021/11/1
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
(@PREFIX+'c', 'def_gamma_energyblock', 75),

(@PREFIX+'c_pr', 'def_titanium', 225),
(@PREFIX+'c_pr', 'def_axicol', 1125),
(@PREFIX+'c_pr', 'def_vitricyl', 1125),
(@PREFIX+'c_pr', 'def_chollonin', 1125),
(@PREFIX+'c_pr', 'def_prilumium', 1125),
(@PREFIX+'c_pr', 'def_espitium', 1125),
(@PREFIX+'c_pr', 'def_unimetal', 225),
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
		tiertype=NULL,
		tierlevel=NULL,
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