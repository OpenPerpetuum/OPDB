USE [perpetuumsa]
GO


--MUST BE RUN AFTER ALL BOTS INSERTED


PRINT N'DESTRO BOT proto-pairs';
DROP TABLE IF EXISTS #PROTOPAIRS;
CREATE TABLE #PROTOPAIRS
(
	defName varchar(100),
	protoDefName varchar(100),
);

INSERT INTO #PROTOPAIRS (defName, protoDefName) VALUES
('def_felos_bot','def_felos_bot_pr'),
('def_hydra_bot','def_hydra_bot_pr'),
('def_onyx_bot','def_onyx_bot_pr');


--DELETE and reinsert
PRINT N'DELETE prototypes FOR ANY EXISTING DESTROYER prototype pairs (0 results if first run)';
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


PRINT N'PRODUCTION DURATION AND DECALIBRATION - DESTROYERS';
DECLARE @destroBotCategory BIGINT;
SET @destroBotCategory = (SELECT TOP 1 VALUE FROM categoryFlags WHERE NAME='cf_walkers');

IF EXISTS (SELECT TOP 1 categoryflag from productiondecalibration where categoryflag=@destroBotCategory)
BEGIN
	UPDATE productiondecalibration SET
		distorsionmax = 0.01,
		distorsionmin = 0.003,
		decrease = 5
	WHERE categoryflag=@destroBotCategory;
END
ELSE
BEGIN
	INSERT INTO productiondecalibration (categoryflag, distorsionmin, distorsionmax, decrease) VALUES
	(@destroBotCategory, 0.003, 0.01, 5);
END

IF EXISTS (SELECT TOP 1 category from productionduration where category=@destroBotCategory)
BEGIN
	UPDATE productionduration SET
		durationmodifier=15
	WHERE category=@destroBotCategory;
END
ELSE
BEGIN
	INSERT INTO productionduration (category, durationmodifier) VALUES
	(@destroBotCategory, 15);
END
DROP TABLE IF EXISTS #PROTOPAIRS;
GO


PRINT N'DESTRO BOT PRODUCTION';

DROP TABLE IF EXISTS #BOT_COMPS;
CREATE TABLE #BOT_COMPS
(
	defName VARCHAR(100),
	commodityName VARCHAR(100),
	amount INT
);

INSERT INTO #BOT_COMPS (defName, commodityName, amount) VALUES
('def_felos_bot', 'def_statichnol', 20000),
('def_felos_bot', 'def_chollonin', 2000),
('def_felos_bot', 'def_polynitrocol', 14000),
('def_felos_bot', 'def_unimetal', 9000),
('def_felos_bot', 'def_alligior', 9000),
('def_felos_bot', 'def_espitium', 9000),
('def_felos_bot', 'def_specimen_sap_item_flux', 2400),
('def_felos_bot', 'def_robotshard_common_advanced', 40),
('def_felos_bot', 'def_robotshard_common_expert', 30),
('def_felos_bot', 'def_robotshard_nuimqol_advanced', 40),
('def_felos_bot', 'def_robotshard_nuimqol_expert', 30),
--
('def_felos_bot_pr', 'def_statichnol', 20000),
('def_felos_bot_pr', 'def_chollonin', 2000),
('def_felos_bot_pr', 'def_polynitrocol', 14000),
('def_felos_bot_pr', 'def_unimetal', 9000),
('def_felos_bot_pr', 'def_alligior', 9000),
('def_felos_bot_pr', 'def_espitium', 9000),
('def_felos_bot_pr', 'def_specimen_sap_item_flux', 2400),
('def_felos_bot_pr', 'def_robotshard_common_advanced', 40),
('def_felos_bot_pr', 'def_robotshard_common_expert', 30),
('def_felos_bot_pr', 'def_robotshard_nuimqol_advanced', 40),
('def_felos_bot_pr', 'def_robotshard_nuimqol_expert', 30),
--
('def_hydra_bot', 'def_isopropentol', 20000),
('def_hydra_bot', 'def_vitricyl', 2000),
('def_hydra_bot', 'def_phlobotil', 14000),
('def_hydra_bot', 'def_unimetal', 9000),
('def_hydra_bot', 'def_alligior', 9000),
('def_hydra_bot', 'def_espitium', 9000),
('def_hydra_bot', 'def_specimen_sap_item_flux', 2400),
('def_hydra_bot', 'def_robotshard_common_advanced', 40),
('def_hydra_bot', 'def_robotshard_common_expert', 30),
('def_hydra_bot', 'def_robotshard_pelistal_advanced', 40),
('def_hydra_bot', 'def_robotshard_pelistal_expert', 30),
--
('def_hydra_bot_pr', 'def_isopropentol', 20000),
('def_hydra_bot_pr', 'def_vitricyl', 2000),
('def_hydra_bot_pr', 'def_phlobotil', 14000),
('def_hydra_bot_pr', 'def_unimetal', 9000),
('def_hydra_bot_pr', 'def_alligior', 9000),
('def_hydra_bot_pr', 'def_espitium', 9000),
('def_hydra_bot_pr', 'def_specimen_sap_item_flux', 2400),
('def_hydra_bot_pr', 'def_robotshard_common_advanced', 40),
('def_hydra_bot_pr', 'def_robotshard_common_expert', 30),
('def_hydra_bot_pr', 'def_robotshard_pelistal_advanced', 40),
('def_hydra_bot_pr', 'def_robotshard_pelistal_expert', 30),
--
('def_onyx_bot', 'def_metachropin', 20000),
('def_onyx_bot', 'def_prilumium', 2000),
('def_onyx_bot', 'def_polynucleit', 14000),
('def_onyx_bot', 'def_unimetal', 9000),
('def_onyx_bot', 'def_alligior', 9000),
('def_onyx_bot', 'def_espitium', 9000),
('def_onyx_bot', 'def_specimen_sap_item_flux', 2400),
('def_onyx_bot', 'def_robotshard_common_advanced', 40),
('def_onyx_bot', 'def_robotshard_common_expert', 30),
('def_onyx_bot', 'def_robotshard_thelodica_advanced', 40),
('def_onyx_bot', 'def_robotshard_thelodica_expert', 30),
--
('def_onyx_bot_pr', 'def_metachropin', 20000),
('def_onyx_bot_pr', 'def_prilumium', 2000),
('def_onyx_bot_pr', 'def_polynucleit', 14000),
('def_onyx_bot_pr', 'def_unimetal', 9000),
('def_onyx_bot_pr', 'def_alligior', 9000),
('def_onyx_bot_pr', 'def_espitium', 9000),
('def_onyx_bot_pr', 'def_specimen_sap_item_flux', 2400),
('def_onyx_bot_pr', 'def_robotshard_common_advanced', 40),
('def_onyx_bot_pr', 'def_robotshard_common_expert', 30),
('def_onyx_bot_pr', 'def_robotshard_thelodica_advanced', 40),
('def_onyx_bot_pr', 'def_robotshard_thelodica_expert', 30);


PRINT N'DELETE components FOR ANY EXISTING DESTROYER COMPONENTRY (0 results if 1st run)';
SELECT * FROM components WHERE definition IN (SELECT definition FROM entitydefaults WHERE definitionname IN (SELECT DISTINCT defName FROM #BOT_COMPS));
DELETE FROM components WHERE definition IN (SELECT definition FROM entitydefaults WHERE definitionname IN (SELECT DISTINCT defName FROM #BOT_COMPS));

PRINT N'INSERT components FOR DESTROYERS';
INSERT INTO components (definition, componentdefinition, componentamount)
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defName),
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=commodityName),
	amount
FROM #BOT_COMPS;


DROP TABLE IF EXISTS #BOT_COMPS;
GO



PRINT N'CALIBRATION TEMPLATES FOR MODULES';

DECLARE @botCTCategory BIGINT;

SET @botCTCategory = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_walker_calibration_programs');


DROP TABLE IF EXISTS #BOTCTS;
CREATE TABLE #BOTCTS 
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

INSERT INTO #BOTCTS (defName, attrFlags, catFlags, cargoVolume, massOfModule, techType, techLevel, genxyOptStr) VALUES
('def_felos_bot_cprg', 1024, @botCTCategory, 0.01, 0.1, NULL, NULL, NULL),
('def_hydra_bot_cprg', 1024, @botCTCategory, 0.01, 0.1, NULL, NULL, NULL),
('def_onyx_bot_cprg', 1024, @botCTCategory, 0.01, 0.1, NULL, NULL, NULL);


PRINT N'UPDATE/INSERT CTS';
--Update/insert [entitydefaults] entries
MERGE [dbo].[entitydefaults] def USING #BOTCTS ct
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
	(defName, 1, attrFlags,catFlags,genxyOptStr,'CT FOR DESTROYER',1,cargoVolume,massOfModule,0,100,'calibration_program_desc',0,techType,techLevel);

PRINT N'DELETE calibrationdefaults FOR ANY EXISTING LARGE MOD CTS (0 results if 1st run)';
SELECT * FROM calibrationdefaults WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #BOTCTS));
DELETE FROM calibrationdefaults WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #BOTCTS));

PRINT N'INSERT calibrationdefaults FOR MOD CTS';
INSERT INTO calibrationdefaults (definition, materialefficiency, timeefficiency)
SELECT (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = defName), 50, 50 FROM #BOTCTS;

DROP TABLE IF EXISTS #PROTO_TO_CT;
CREATE TABLE #PROTO_TO_CT
(
	protoDefName VARCHAR(100),
	ctDefName VARCHAR(100),
	level INT
);

INSERT INTO #PROTO_TO_CT (protoDefName, ctDefName, level) VALUES
('def_felos_bot_pr','def_felos_bot_cprg', 7),
('def_hydra_bot_pr','def_hydra_bot_cprg', 7),
('def_onyx_bot_pr','def_onyx_bot_cprg', 7);


PRINT N'DELETE itemresearchlevels FOR ANY EXISTING DESTRO BOT CTS (0 results if 1st run)';
SELECT * FROM itemresearchlevels WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT protoDefName FROM #PROTO_TO_CT));
DELETE FROM itemresearchlevels WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT protoDefName FROM #PROTO_TO_CT));

PRINT N'INSERT itemresearchlevels FOR DESTRO BOT CTS';
INSERT INTO itemresearchlevels (definition, calibrationprogram, researchlevel, enabled)
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = protoDefName), 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = ctDefName), 
	level, 1
FROM #PROTO_TO_CT;


DROP TABLE IF EXISTS #BOTCTS;
DROP TABLE IF EXISTS #PROTO_TO_CT;
GO