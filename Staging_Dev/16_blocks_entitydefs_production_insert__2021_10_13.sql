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
(6624, @PREFIX+'_t0', @PREFIX+'_t0_desc','#tier=$tierlevel_t0', 10, 2147485696, 69898, 0.1, 1000, 1, 1, 0),
(6625, @PREFIX+'_t1', @PREFIX+'_t1_desc','#tier=$tierlevel_t1', 10, 2147485696, 69898, 0.1, 1000, 1, 1, 1),
(6626, @PREFIX+'_t2', @PREFIX+'_t2_desc','#tier=$tierlevel_t2', 10, 2147485696, 69898, 0.1, 1000, 1, 1, 2),
(6627, @PREFIX+'_t3', @PREFIX+'_t3_desc','#tier=$tierlevel_t3', 10, 2147485696, 69898, 0.1, 1000, 1, 1, 3),
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