USE [perpetuumsa]
GO

DECLARE @light AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_syndicate_runners');
DECLARE @assault AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_syndicate_crawlers');
DECLARE @mech AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_syndicate_mechs');
DECLARE @hmech AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_syndicate_heavymechs');

DECLARE @primaryCommodity AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_primary_commodities');

DECLARE @dynamicCtCategory AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_dynamic_cprg');--For ct capsule defined cts

DECLARE @lightSyndicateCTCapsules AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_ct_capsules_robot_syndicate_light');
DECLARE @assaultSyndicateCTCapsules AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_ct_capsules_robot_syndicate_assault');
DECLARE @mechSyndicateCTCapsules AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_ct_capsules_robot_syndicate_mech');
DECLARE @hmechSyndicateCTCapsules AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_ct_capsules_robot_syndicate_heavymech');

DECLARE @tmShops AS INT = (SELECT TOP 1 id FROM itemshoppresets WHERE name='tm_preset_pve');

DROP TABLE IF EXISTS #ENTITYDEF;
CREATE TABLE #ENTITYDEF (
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
(191,'def_biotichrin',2048,@primaryCommodity,'',0.005,0.55,NULL,NULL);

DROP TABLE IF EXISTS #CTS;
CREATE TABLE #CTS (
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
(6018,'def_vektor_bot_cprg',1024,@dynamicCtCategory,'',0.01,0.1,NULL,NULL),
(6019,'def_helix_bot_cprg',1024,@dynamicCtCategory,'',0.01,0.1,NULL,NULL),
(6020,'def_locust_bot_cprg',1024,@dynamicCtCategory,'',0.01,0.1,NULL,NULL),
(6021,'def_echelon_bot_cprg',1024,@dynamicCtCategory,'',0.01,0.1,NULL,NULL),
(6022,'def_callisto_bot_cprg',1024,@dynamicCtCategory,'',0.01,0.1,NULL,NULL),
(6023,'def_legatus_bot_cprg',1024,@dynamicCtCategory,'',0.01,0.1,NULL,NULL),
(6024,'def_ikarus_bot_cprg',1024,@dynamicCtCategory,'',0.01,0.1,NULL,NULL),
(6025,'def_cronus_bot_cprg',1024,@dynamicCtCategory,'',0.01,0.1,NULL,NULL),
(6026,'def_hermes_bot_cprg',1024,@dynamicCtCategory,'',0.01,0.1,NULL,NULL),
(6027,'def_daidalos_bot_cprg',1024,@dynamicCtCategory,'',0.01,0.1,NULL,NULL),
(6028,'def_metis_bot_cprg',1024,@dynamicCtCategory,'',0.01,0.1,NULL,NULL);

DROP TABLE IF EXISTS #CTS_CAPSULES;
CREATE TABLE #CTS_CAPSULES (
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
(6029,'def_vektor_bot_CT_capsule',2052,@lightSyndicateCTCapsules,'',0.01,0.1,NULL,NULL),
(6030,'def_helix_bot_CT_capsule',2052,@lightSyndicateCTCapsules,'',0.01,0.1,NULL,NULL),
(6031,'def_locust_bot_CT_capsule',2052,@assaultSyndicateCTCapsules,'',0.01,0.1,NULL,NULL),
(6032,'def_echelon_bot_CT_capsule',2052,@mechSyndicateCTCapsules,'',0.01,0.1,NULL,NULL),
(6033,'def_callisto_bot_CT_capsule',2052,@mechSyndicateCTCapsules,'',0.01,0.1,NULL,NULL),
(6034,'def_legatus_bot_CT_capsule',2052,@hmechSyndicateCTCapsules,'',0.01,0.1,NULL,NULL),
(6035,'def_ikarus_bot_CT_capsule',2052,@lightSyndicateCTCapsules,'',0.01,0.1,NULL,NULL),
(6036,'def_cronus_bot_CT_capsule',2052,@assaultSyndicateCTCapsules,'',0.01,0.1,NULL,NULL),
(6037,'def_hermes_bot_CT_capsule',2052,@assaultSyndicateCTCapsules,'',0.01,0.1,NULL,NULL),
(6038,'def_daidalos_bot_CT_capsule',2052,@mechSyndicateCTCapsules,'',0.01,0.1,NULL,NULL),
(6039,'def_metis_bot_CT_capsule',2052,@hmechSyndicateCTCapsules,'',0.01,0.1,NULL,NULL);

DROP TABLE IF EXISTS #SHOPENTRIES;
CREATE TABLE #SHOPENTRIES (
	defName varchar(100),
	tokenPrice int,
	nicPrice int
);
INSERT INTO #SHOPENTRIES (defName, tokenPrice, nicPrice) VALUES
--Editted for 15pt/5-run values
('def_vektor_bot_CT_capsule',125,250000),
('def_helix_bot_CT_capsule',550,750000),
('def_locust_bot_CT_capsule',375,750000),
('def_echelon_bot_CT_capsule',1500,2250000),
('def_callisto_bot_CT_capsule',2250,3750000),
('def_legatus_bot_CT_capsule',6650,12500000),
('def_ikarus_bot_CT_capsule',50,125000),
('def_cronus_bot_CT_capsule',500,750000),
('def_hermes_bot_CT_capsule',500,875000),
('def_daidalos_bot_CT_capsule',1650,5000000),
('def_metis_bot_CT_capsule',8750,17500000);

DROP TABLE IF EXISTS #CT_RELATE;
CREATE TABLE #CT_RELATE (
	defName varchar(100),
	ctName varchar(100),
	capName varchar(100)
);
INSERT INTO #CT_RELATE (defName, ctName, capName) VALUES
('def_vektor_bot', 'def_vektor_bot_cprg', 'def_vektor_bot_CT_capsule'),
('def_helix_bot', 'def_helix_bot_cprg', 'def_helix_bot_CT_capsule'),
('def_locust_bot', 'def_locust_bot_cprg', 'def_locust_bot_CT_capsule'),
('def_echelon_bot', 'def_echelon_bot_cprg', 'def_echelon_bot_CT_capsule'),
('def_callisto_bot', 'def_callisto_bot_cprg', 'def_callisto_bot_CT_capsule'),
('def_legatus_bot', 'def_legatus_bot_cprg', 'def_legatus_bot_CT_capsule'),
('def_ikarus_bot', 'def_ikarus_bot_cprg', 'def_ikarus_bot_CT_capsule'),
('def_cronus_bot', 'def_cronus_bot_cprg', 'def_cronus_bot_CT_capsule'),
('def_hermes_bot', 'def_hermes_bot_cprg', 'def_hermes_bot_CT_capsule'),
('def_daidalos_bot', 'def_daidalos_bot_cprg', 'def_daidalos_bot_CT_capsule'),
('def_metis_bot', 'def_metis_bot_cprg', 'def_metis_bot_CT_capsule');

DROP TABLE IF EXISTS #INDY;
CREATE TABLE #INDY (
	defName VARCHAR(100),
	commodityName VARCHAR(100),
	amount INT
);
INSERT INTO #INDY (defName, commodityName, amount) VALUES
('def_biotichrin', 'def_helioptris', 25),
('def_biotichrin', 'def_triandlus', 25),
('def_biotichrin', 'def_prismocitae', 25),
('def_biotichrin', 'def_crude', 25),

('def_vektor_bot', 'def_titanium', 560),
('def_vektor_bot', 'def_axicol', 80),
('def_vektor_bot', 'def_axicoline', 150),
('def_vektor_bot', 'def_plasteosine', 110),
('def_vektor_bot', 'def_isopropentol', 110),
('def_vektor_bot', 'def_metachropin', 110),
('def_vektor_bot', 'def_statichnol', 110),
('def_vektor_bot', 'def_biotichrin', 175),

('def_helix_bot', 'def_titanium', 750),
('def_helix_bot', 'def_axicol', 380),
('def_helix_bot', 'def_axicoline', 150),
('def_helix_bot', 'def_plasteosine', 110),
('def_helix_bot', 'def_vitricyl', 340),
('def_helix_bot', 'def_chollonin', 340),
('def_helix_bot', 'def_prilumium', 340),
('def_helix_bot', 'def_espitium', 380),
('def_helix_bot', 'def_biotichrin', 250),

('def_locust_bot', 'def_titanium', 750),
('def_locust_bot', 'def_axicol', 190),
('def_locust_bot', 'def_axicoline', 750),
('def_locust_bot', 'def_plasteosine', 380),
('def_locust_bot', 'def_isopropentol', 440),
('def_locust_bot', 'def_metachropin', 440),
('def_locust_bot', 'def_statichnol', 440),
('def_locust_bot', 'def_biotichrin', 350),

('def_echelon_bot', 'def_titanium', 2250),
('def_echelon_bot', 'def_axicol', 190),
('def_echelon_bot', 'def_axicoline', 750),
('def_echelon_bot', 'def_plasteosine', 380),
('def_echelon_bot', 'def_phlobotil', 880),
('def_echelon_bot', 'def_polynucleit', 880),
('def_echelon_bot', 'def_polynitrocol', 880),
('def_echelon_bot', 'def_hydrobenol', 750),
('def_echelon_bot', 'def_espitium', 190),
('def_echelon_bot', 'def_alligior', 380),
('def_echelon_bot', 'def_biotichrin', 700),

('def_callisto_bot', 'def_titanium', 750),
('def_callisto_bot', 'def_axicol', 1130),
('def_callisto_bot', 'def_axicoline', 380),
('def_callisto_bot', 'def_plasteosine', 190),
('def_callisto_bot', 'def_vitricyl', 1130),
('def_callisto_bot', 'def_chollonin', 1130),
('def_callisto_bot', 'def_prilumium', 1130),
('def_callisto_bot', 'def_hydrobenol', 380),
('def_callisto_bot', 'def_espitium', 1130),
('def_callisto_bot', 'def_alligior', 190),
('def_callisto_bot', 'def_unimetal', 560),
('def_callisto_bot', 'def_biotichrin', 700),

('def_legatus_bot', 'def_phlobotil', 2250),
('def_legatus_bot', 'def_polynucleit', 2250),
('def_legatus_bot', 'def_polynitrocol', 2250),
('def_legatus_bot', 'def_hydrobenol', 2630),
('def_legatus_bot', 'def_espitium', 380),
('def_legatus_bot', 'def_alligior', 3750),
('def_legatus_bot', 'def_unimetal', 3750),
('def_legatus_bot', 'def_biotichrin', 3000),

('def_ikarus_bot', 'def_titanium', 560),
('def_ikarus_bot', 'def_axicol', 230),
('def_ikarus_bot', 'def_plasteosine', 380),
('def_ikarus_bot', 'def_biotichrin', 50),

('def_cronus_bot', 'def_titanium', 2250),
('def_cronus_bot', 'def_axicol', 380),
('def_cronus_bot', 'def_plasteosine', 1130),
('def_cronus_bot', 'def_biotichrin', 800),

('def_hermes_bot', 'def_titanium', 750),
('def_hermes_bot', 'def_axicol', 190),
('def_hermes_bot', 'def_axicoline', 750),
('def_hermes_bot', 'def_plasteosine', 380),
('def_hermes_bot', 'def_biotichrin', 2500),

('def_daidalos_bot', 'def_titanium', 3000),
('def_daidalos_bot', 'def_axicol', 560),
('def_daidalos_bot', 'def_plasteosine', 1500),
('def_daidalos_bot', 'def_espitium', 750),
('def_daidalos_bot', 'def_alligior', 1880),
('def_daidalos_bot', 'def_unimetal', 3750),
('def_daidalos_bot', 'def_biotichrin', 2750),

('def_metis_bot', 'def_titanium', 6250),
('def_metis_bot', 'def_axicol', 630),
('def_metis_bot', 'def_plasteosine', 3130),
('def_metis_bot', 'def_espitium', 630),
('def_metis_bot', 'def_alligior', 3130),
('def_metis_bot', 'def_unimetal', 6250),
('def_metis_bot', 'def_biotichrin', 3000);

DROP TABLE IF EXISTS #PRODSTATS;
CREATE TABLE #PRODSTATS (
	cat BIGINT,
	costModifier FLOAT,
	distMin FLOAT,
	distMax FLOAT,
	decr FLOAT,
	durationMod FLOAT
);
INSERT INTO #PRODSTATS (cat, costModifier, distMin, distMax, decr, durationMod) VALUES
(@light, 1, 0.005, 0.01, 3, 2.25),
(@assault, 2, 0.005, 0.01, 3, 3),
(@mech, 3, 0.005, 0.01, 3, 6),
(@hmech, 4, 0.005, 0.01, 3, 7.5);


PRINT N'UPSERT [entitydefaults] identity insert ON';
SET IDENTITY_INSERT [dbo].[entitydefaults] ON;

PRINT N'UPSERT new commodity plant goo [entitydefaults]';
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
	(def,defName,1,attrFlags,catFlags,genxyOptStr,'commodity',1,cargoVolume,massOfModule,0,100,defName+'_desc',1,techType,techLevel);


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
	(def,defName,1,attrFlags,catFlags,genxyOptStr,'syndicate bot CT',1,cargoVolume,massOfModule,0,100,'calibration_program_desc',1,techType,techLevel);

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
		descriptiontoken=defName+'_desc'
WHEN NOT MATCHED
    THEN INSERT (definition, definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel) VALUES
	(def,defName,1,attrFlags,catFlags,genxyOptStr,'syndicate bot CT Capsule',1,cargoVolume,massOfModule,0,100,defName+'_desc',1,techType,techLevel);

SET IDENTITY_INSERT [dbo].[entitydefaults] OFF;
PRINT N'[entitydefaults] insert/updates done - identity insert off';

PRINT N'UPSERT [dynamiccalibrationtemplates]';
MERGE [dbo].[dynamiccalibrationtemplates] t USING #CT_RELATE c
ON t.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=c.ctName)
WHEN MATCHED
    THEN UPDATE SET
		materialefficiency=15,
		timeefficiency=15,
		targetdefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=c.defName)
WHEN NOT MATCHED
    THEN INSERT (definition, materialefficiency, timeefficiency, targetdefinition) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=c.ctName),
	15,15,
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

PRINT N'DELETE FOR CLEAN SLATE ON [components] FOR SYNDICATE BOT PRODUCTION';
DELETE FROM components WHERE definition IN(SELECT DISTINCT definition FROM entitydefaults WHERE definitionname IN (SELECT DISTINCT defName FROM #INDY));
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
WHEN MATCHED
    THEN UPDATE SET
		presetid=@tmShops,
		targetamount=1,
		unicoin=e.tokenPrice,
		credit=e.nicPrice
WHEN NOT MATCHED
    THEN INSERT (presetid, targetdefinition, targetamount, tmcoin, icscoin, asicoin, credit, unicoin, globallimit, purchasecount, standing) VALUES
	(@tmShops, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=e.defName), 1, 0, 0, 0, e.nicPrice, e.tokenPrice, NULL, 1, 0);

PRINT N'UPSERT [productioncost]';
MERGE [dbo].[productioncost] c USING #PRODSTATS s
ON c.category = s.cat
WHEN MATCHED
    THEN UPDATE SET
		costmodifier=s.costModifier
WHEN NOT MATCHED
    THEN INSERT (category, tiertype, tierlevel, costmodifier) VALUES
	(s.cat, NULL, NULL, s.costModifier);

PRINT N'UPSERT [productiondecalibration]';
MERGE [dbo].[productiondecalibration] d USING #PRODSTATS s
ON d.categoryflag = s.cat
WHEN MATCHED
    THEN UPDATE SET
		distorsionmin=s.distMin,
		distorsionmax=s.distMax,
		decrease=s.decr
WHEN NOT MATCHED
    THEN INSERT (categoryflag, distorsionmin, distorsionmax, decrease) VALUES
	(s.cat, s.distMin, s.distMax, s.decr);

PRINT N'UPSERT [productionduration]';
MERGE [dbo].[productionduration] d USING #PRODSTATS s
ON d.category = s.cat
WHEN MATCHED
    THEN UPDATE SET
		durationmodifier=s.durationMod
WHEN NOT MATCHED
    THEN INSERT (category, durationmodifier) VALUES
	(s.cat, s.durationMod);

DROP TABLE IF EXISTS #ENTITYDEF;
DROP TABLE IF EXISTS #CT_RELATE;
DROP TABLE IF EXISTS #CTS;
DROP TABLE IF EXISTS #CTS_CAPSULES;
DROP TABLE IF EXISTS #INDY;
DROP TABLE IF EXISTS #SHOPENTRIES;
DROP TABLE IF EXISTS #PRODSTATS;
GO
