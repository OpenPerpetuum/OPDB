USE [perpetuumsa]
GO

--New property modifier and skill for falloff
DECLARE @missileFalloffMod int;

IF NOT EXISTS (SELECT TOP 1 id FROM aggregatefields WHERE name='missile_falloff_modifier')
BEGIN
	PRINT N'INSERTING missile_falloff_modifier';
	INSERT INTO aggregatefields (name, formula, measurementunit, measurementmultiplier, measurementoffset, category, digits, moreisbetter, usedinconfig, note) VALUES
	('missile_falloff_modifier', 0, 'missile_falloff_modifier_unit', 100, -100, 6, 0, 1, 1, 'missile falloff mod');
END

IF NOT EXISTS (SELECT TOP 1 id FROM aggregatefields WHERE name='module_missile_falloff_modifier')
BEGIN
	PRINT N'INSERTING module_missile_falloff_modifier';
	INSERT INTO aggregatefields (name, formula, measurementunit, measurementmultiplier, measurementoffset, category, digits, moreisbetter, usedinconfig, note) VALUES
	('module_missile_falloff_modifier', 0, 'module_missile_falloff_modifier_unit', 100, -100, 6, 2, 1, 1, 'missile falloff mod on module');
END

SET @missileFalloffMod = (SELECT TOP 1 id FROM aggregatefields WHERE name='missile_falloff_modifier');
IF NOT EXISTS (SELECT TOP 1 extensionid FROM extensions WHERE extensionname='ext_missile_falloff')
BEGIN
	PRINT N'INSERTING ext_missile_falloff';
	INSERT INTO extensions (extensionname, category, rank, targetlearningattribute, learningattributeprimary, learningattributesecondary, bonus, note, price, active, description, targetpropertyID, effectenhancer, hidden, freezelimit)
	VALUES
	('ext_missile_falloff', 4, 4, NULL, 'attributeA', 'attributeB', 0.03, 'new falloff for missiles', 80000, 1, 'ext_missile_falloff_desc', @missileFalloffMod, 0, 0, 7);
END

IF NOT EXISTS (SELECT TOP 1 id FROM modulepropertymodifiers WHERE categoryflags=(SELECT TOP 1 value FROM categoryFlags WHERE name='cf_missiles')
	AND basefield=(SELECT TOP 1 id FROM aggregatefields WHERE name='module_missile_falloff_modifier')
	AND modifierfield=(SELECT TOP 1 id FROM aggregatefields WHERE name='missile_falloff_modifier'))
BEGIN
	PRINT N'INSERTING modulepropertymodifiers FOR cf_missiles module_missile_falloff_modifier missile_falloff_modifier';
	INSERT INTO modulepropertymodifiers (categoryflags, basefield, modifierfield) VALUES
	((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_missiles'),
	(SELECT TOP 1 id FROM aggregatefields WHERE name='module_missile_falloff_modifier'),
	(SELECT TOP 1 id FROM aggregatefields WHERE name='missile_falloff_modifier'));
END
GO


DROP TABLE IF EXISTS #AMMO
CREATE TABLE #AMMO 
(
	ammoName varchar(100),
	fieldName varchar(100),
	fieldValue float,
);
INSERT INTO #AMMO (ammoName, fieldName, fieldValue) VALUES
('def_ammo_large_railgun_a', 'damage_kinetic', 39),
('def_ammo_large_railgun_a', 'damage_thermal', 27),
('def_ammo_large_railgun_a', 'optimal_range_modifier', 1.0),
('def_ammo_large_railgun_b', 'damage_kinetic', 42),
('def_ammo_large_railgun_b', 'damage_chemical', 24),
('def_ammo_large_railgun_b', 'optimal_range_modifier', 1.0),
('def_ammo_large_railgun_c', 'damage_kinetic', 39),
('def_ammo_large_railgun_c', 'damage_explosive', 27),
('def_ammo_large_railgun_c', 'optimal_range_modifier', 1.0),
('def_ammo_large_railgun_d', 'damage_kinetic', 72),
('def_ammo_large_railgun_d', 'optimal_range_modifier', 1.0),
--
('def_ammo_large_lasercrystal_a', 'damage_thermal', 42),
('def_ammo_large_lasercrystal_a', 'damage_chemical', 24),
('def_ammo_large_lasercrystal_a', 'optimal_range_modifier', 1.0),
('def_ammo_large_lasercrystal_b', 'damage_thermal', 39),
('def_ammo_large_lasercrystal_b', 'damage_explosive', 27),
('def_ammo_large_lasercrystal_b', 'optimal_range_modifier', 1.0),
('def_ammo_large_lasercrystal_c', 'damage_kinetic', 27),
('def_ammo_large_lasercrystal_c', 'damage_thermal', 39),
('def_ammo_large_lasercrystal_c', 'optimal_range_modifier', 1.0),
('def_ammo_large_lasercrystal_d', 'damage_thermal', 72),
('def_ammo_large_lasercrystal_d', 'optimal_range_modifier', 1.0),
--
('def_ammo_cruisemissile_a', 'damage_kinetic', 67.5),
('def_ammo_cruisemissile_a', 'damage_explosive', 90),
('def_ammo_cruisemissile_a', 'optimal_range', 18),
('def_ammo_cruisemissile_a', 'falloff', 3),
('def_ammo_cruisemissile_a', 'explosion_radius', 37.5),
('def_ammo_cruisemissile_b', 'damage_explosive', 90),
('def_ammo_cruisemissile_b', 'damage_chemical', 67.5),
('def_ammo_cruisemissile_b', 'optimal_range', 18),
('def_ammo_cruisemissile_b', 'falloff', 3),
('def_ammo_cruisemissile_b', 'explosion_radius', 37.5),
('def_ammo_cruisemissile_c', 'damage_thermal', 67.5),
('def_ammo_cruisemissile_c', 'damage_explosive', 90),
('def_ammo_cruisemissile_c', 'optimal_range', 18),
('def_ammo_cruisemissile_c', 'falloff', 3),
('def_ammo_cruisemissile_c', 'explosion_radius', 37.5),
('def_ammo_cruisemissile_d', 'damage_explosive', 180),
('def_ammo_cruisemissile_d', 'explosion_radius', 37.5),
('def_ammo_cruisemissile_d', 'optimal_range', 18),
('def_ammo_cruisemissile_d', 'falloff', 3),
--
('def_ammo_longrange_cruisemissile_a', 'damage_kinetic', 45),
('def_ammo_longrange_cruisemissile_a', 'damage_explosive', 60),
('def_ammo_longrange_cruisemissile_a', 'optimal_range', 35),
('def_ammo_longrange_cruisemissile_a', 'falloff', 10),
('def_ammo_longrange_cruisemissile_a', 'explosion_radius', 39),
('def_ammo_longrange_cruisemissile_b', 'damage_explosive', 60),
('def_ammo_longrange_cruisemissile_b', 'damage_chemical', 45),
('def_ammo_longrange_cruisemissile_b', 'optimal_range', 35),
('def_ammo_longrange_cruisemissile_b', 'falloff', 10),
('def_ammo_longrange_cruisemissile_b', 'explosion_radius', 39),
('def_ammo_longrange_cruisemissile_c', 'damage_thermal', 45),
('def_ammo_longrange_cruisemissile_c', 'damage_explosive', 60),
('def_ammo_longrange_cruisemissile_c', 'optimal_range', 35),
('def_ammo_longrange_cruisemissile_c', 'falloff', 10),
('def_ammo_longrange_cruisemissile_c', 'explosion_radius', 39),
('def_ammo_longrange_cruisemissile_d', 'damage_explosive', 120),
('def_ammo_longrange_cruisemissile_d', 'optimal_range', 35),
('def_ammo_longrange_cruisemissile_d', 'falloff', 10),
('def_ammo_longrange_cruisemissile_d', 'explosion_radius', 39);


DROP TABLE IF EXISTS #BEAMS
CREATE TABLE #BEAMS 
(
	ammoName varchar(100),
	beamName varchar(100)
);
INSERT INTO #BEAMS (ammoName, beamName) VALUES
('def_ammo_large_railgun_a', 'pbs_turret_railgun'),
('def_ammo_large_railgun_b', 'pbs_turret_railgun'),
('def_ammo_large_railgun_c', 'pbs_turret_railgun'),
('def_ammo_large_railgun_d', 'pbs_turret_railgun'),
--
('def_ammo_large_lasercrystal_a', 'multifocal_medium_laser'),
('def_ammo_large_lasercrystal_b', 'multifocal_medium_laser'),
('def_ammo_large_lasercrystal_c', 'multifocal_medium_laser'),
('def_ammo_large_lasercrystal_d', 'multifocal_medium_laser'),
--
('def_ammo_cruisemissile_a', 'pbs_turret_missile'),
('def_ammo_cruisemissile_b', 'pbs_turret_missile'),
('def_ammo_cruisemissile_c', 'pbs_turret_missile'),
('def_ammo_cruisemissile_d', 'pbs_turret_missile'),
--
('def_ammo_longrange_cruisemissile_a', 'cruisemissile_large'),
('def_ammo_longrange_cruisemissile_b', 'cruisemissile_large'),
('def_ammo_longrange_cruisemissile_c', 'cruisemissile_large'),
('def_ammo_longrange_cruisemissile_d', 'cruisemissile_large');


DROP TABLE IF EXISTS #ENABLESKILLS
CREATE TABLE #ENABLESKILLS 
(
	ammoName VARCHAR(100),
	extName VARCHAR(100),
	level INT
);
INSERT INTO #ENABLESKILLS (ammoName, extName, level) VALUES
('def_ammo_large_railgun_a', 'ext_large_railgun', 1),
('def_ammo_large_railgun_b', 'ext_large_railgun', 1),
('def_ammo_large_railgun_c', 'ext_large_railgun', 1),
('def_ammo_large_railgun_d', 'ext_large_railgun', 1),
--
('def_ammo_large_lasercrystal_a', 'ext_large_laser', 1),
('def_ammo_large_lasercrystal_b', 'ext_large_laser', 1),
('def_ammo_large_lasercrystal_c', 'ext_large_laser', 1),
('def_ammo_large_lasercrystal_d', 'ext_large_laser', 1),
--
('def_ammo_cruisemissile_a', 'ext_cruise_missiles', 1),
('def_ammo_cruisemissile_b', 'ext_cruise_missiles', 1),
('def_ammo_cruisemissile_c', 'ext_cruise_missiles', 1),
('def_ammo_cruisemissile_d', 'ext_cruise_missiles', 1),
--
('def_ammo_longrange_cruisemissile_a', 'ext_cruise_missiles', 2),
('def_ammo_longrange_cruisemissile_b', 'ext_cruise_missiles', 2),
('def_ammo_longrange_cruisemissile_c', 'ext_cruise_missiles', 2),
('def_ammo_longrange_cruisemissile_d', 'ext_cruise_missiles', 2);


UPDATE entitydefaults SET
 attributeflags=133120
WHERE definitionname in (SELECT DISTINCT ammoName FROM #BEAMS) and definitionname like 'def_ammo_%';

SELECT * FROM entitydefaults WHERE definitionname in (SELECT DISTINCT ammoName FROM #BEAMS);

SELECT * FROM beamassignment WHERE definition in (SELECT entitydefaults.definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT ammoName FROM #BEAMS));
DELETE FROM beamassignment WHERE definition in (SELECT entitydefaults.definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT ammoName FROM #BEAMS));

INSERT INTO beamassignment (definition, beam)
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=ammoName),
	(SELECT TOP 1 id FROM beams WHERE name=beamName)
FROM #BEAMS

PRINT N'ENABLE LARGE AMMO DEFINITIONS';
UPDATE entitydefaults SET
	hidden=0,
	enabled=1,
	purchasable=1
WHERE definitionname in (SELECT DISTINCT ammoName from #AMMO);
SELECT DISTINCT categoryflags from entitydefaults where definitionname in (SELECT DISTINCT ammoName from #AMMO);
SELECT * FROM categoryFlags WHERE value in (SELECT DISTINCT categoryflags from entitydefaults where definitionname in (SELECT DISTINCT ammoName from #AMMO));


PRINT N'SHOW LARGE AMMO CATEGORIES';
UPDATE categoryFlags SET
	hidden=0
WHERE value in (SELECT DISTINCT categoryflags from entitydefaults where definitionname in (SELECT DISTINCT ammoName from #AMMO));

PRINT N'PRINT OLD STATS';
SELECT definitionname, field, value FROM aggregatevalues as a
JOIN entitydefaults as e on e.definition=a.definition
 WHERE a.definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT ammoName FROM #AMMO));

PRINT N'DELETE OLD STATS';
DELETE FROM aggregatevalues WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT ammoName FROM #AMMO));

PRINT N'INSERT NEW STATS';
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value])
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE ammoName=definitionname),
	(SELECT TOP 1 id FROM aggregatefields WHERE fieldName=name),
	fieldValue 
FROM #AMMO

--DELETE and REINSERT
PRINT N'DELETE AMMO REQ-EXTENSIONS';
SELECT * FROM enablerextensions WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT ammoName FROM #ENABLESKILLS));
DELETE FROM enablerextensions WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT ammoName FROM #ENABLESKILLS));
PRINT N'INSERT AMMO REQ-EXTENSIONS';
INSERT INTO [dbo].[enablerextensions] ([definition],[extensionid],[extensionlevel]) 
SELECT (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname= ammoName),
	(SELECT TOP 1 extensionid FROM extensions WHERE extensionname = extName),
	level
FROM #ENABLESKILLS;


PRINT N'Enable skills that are required to operate the ammo';
UPDATE extensions SET
	hidden=0, active=1
WHERE extensionname in (SELECT DISTINCT extName FROM #ENABLESKILLS);

DROP TABLE IF EXISTS #UNIQ_CAT_FLAGS;
CREATE TABLE #UNIQ_CAT_FLAGS
(
	catFlags bigint
);
INSERT INTO #UNIQ_CAT_FLAGS (catFlags) SELECT DISTINCT categoryflags from entitydefaults where definitionname in (SELECT DISTINCT ammoName from #AMMO);
select * from #UNIQ_CAT_FLAGS
PRINT N'UN-HIDE AMMO CATEGORIES';
UPDATE categoryFlags SET
  hidden=0
WHERE value in (SELECT catFlags from #UNIQ_CAT_FLAGS);

select * from productiondecalibration where categoryflag in(196874, 197130, 197642)

PRINT N'UPDATE/INSERT WEP Category for production decalibration';
--Update/insert [productiondecalibration] entries
MERGE [dbo].[productiondecalibration] decal USING #UNIQ_CAT_FLAGS ammo
ON decal.categoryflag = ammo.catFlags
WHEN MATCHED
    THEN UPDATE SET
		distorsionmin=0.003,
		distorsionmax=0.005,
		decrease=0.3
WHEN NOT MATCHED
    THEN INSERT (categoryflag,distorsionmin,distorsionmax,decrease) VALUES
	(ammo.catFlags, 0.003, 0.005, 0.3);

PRINT N'UPDATE/INSERT WEP Category for production duration';
--Update/insert [productionduration] entries
MERGE [dbo].[productionduration] dur USING #UNIQ_CAT_FLAGS ammo
ON dur.category = ammo.catFlags
WHEN MATCHED
    THEN UPDATE SET
		durationmodifier=0.45
WHEN NOT MATCHED
    THEN INSERT (category,durationmodifier) VALUES
	(ammo.catFlags, 0.45);

DROP TABLE IF EXISTS #UNIQ_CAT_FLAGS;


DROP TABLE IF EXISTS #ENABLESKILLS;
DROP TABLE IF EXISTS #BEAMS;
DROP TABLE IF EXISTS #AMMO;
PRINT N'LARGE AMMOS UPDATED';
GO


PRINT N'AMMO PRODUCTION';

DROP TABLE IF EXISTS #AMMO_COMPS;
CREATE TABLE #AMMO_COMPS
(
	defName VARCHAR(100),
	commodityName VARCHAR(100),
	amount INT
);
INSERT INTO #AMMO_COMPS (defName, commodityName, amount) VALUES
('def_ammo_large_railgun_a', 'def_polynucleit', 75),
('def_ammo_large_railgun_a', 'def_polynitrocol', 150),
('def_ammo_large_railgun_a', 'def_titanium', 75),
('def_ammo_large_railgun_a', 'def_specimen_sap_item_flux', 2),

('def_ammo_large_railgun_b', 'def_axicoline', 150),
('def_ammo_large_railgun_b', 'def_polynitrocol', 150),
('def_ammo_large_railgun_b', 'def_titanium', 75),
('def_ammo_large_railgun_b', 'def_specimen_sap_item_flux', 2),

('def_ammo_large_railgun_c', 'def_phlobotil', 75),
('def_ammo_large_railgun_c', 'def_polynitrocol', 150),
('def_ammo_large_railgun_c', 'def_titanium', 75),
('def_ammo_large_railgun_c', 'def_specimen_sap_item_flux', 2),

('def_ammo_large_railgun_d', 'def_polynitrocol', 300),
('def_ammo_large_railgun_d', 'def_titanium', 75),
('def_ammo_large_railgun_d', 'def_specimen_sap_item_flux', 2),
--
('def_ammo_large_lasercrystal_a', 'def_axicoline', 150),
('def_ammo_large_lasercrystal_a', 'def_polynucleit', 150),
('def_ammo_large_lasercrystal_a', 'def_titanium', 75),
('def_ammo_large_lasercrystal_a', 'def_specimen_sap_item_flux', 2),

('def_ammo_large_lasercrystal_b', 'def_phlobotil', 75),
('def_ammo_large_lasercrystal_b', 'def_polynucleit', 150),
('def_ammo_large_lasercrystal_b', 'def_titanium', 75),
('def_ammo_large_lasercrystal_b', 'def_specimen_sap_item_flux', 2),

('def_ammo_large_lasercrystal_c', 'def_polynucleit', 150),
('def_ammo_large_lasercrystal_c', 'def_polynitrocol', 75),
('def_ammo_large_lasercrystal_c', 'def_titanium', 75),
('def_ammo_large_lasercrystal_c', 'def_specimen_sap_item_flux', 2),

('def_ammo_large_lasercrystal_d', 'def_polynucleit', 300),
('def_ammo_large_lasercrystal_d', 'def_titanium', 75),
('def_ammo_large_lasercrystal_d', 'def_specimen_sap_item_flux', 2),
--
('def_ammo_cruisemissile_a', 'def_phlobotil', 150),
('def_ammo_cruisemissile_a', 'def_polynitrocol', 75),
('def_ammo_cruisemissile_a', 'def_titanium', 75),
('def_ammo_cruisemissile_a', 'def_specimen_sap_item_flux', 2),

('def_ammo_cruisemissile_b', 'def_phlobotil', 150),
('def_ammo_cruisemissile_b', 'def_axicoline', 150),
('def_ammo_cruisemissile_b', 'def_titanium', 75),
('def_ammo_cruisemissile_b', 'def_specimen_sap_item_flux', 2),

('def_ammo_cruisemissile_c', 'def_phlobotil', 150),
('def_ammo_cruisemissile_c', 'def_polynucleit', 75),
('def_ammo_cruisemissile_c', 'def_titanium', 75),
('def_ammo_cruisemissile_c', 'def_specimen_sap_item_flux', 2),

('def_ammo_cruisemissile_d', 'def_phlobotil', 300),
('def_ammo_cruisemissile_d', 'def_titanium', 75),
('def_ammo_cruisemissile_d', 'def_specimen_sap_item_flux', 2),
--
('def_ammo_longrange_cruisemissile_a', 'def_phlobotil', 150),
('def_ammo_longrange_cruisemissile_a', 'def_polynitrocol', 75),
('def_ammo_longrange_cruisemissile_a', 'def_titanium', 75),
('def_ammo_longrange_cruisemissile_a', 'def_specimen_sap_item_flux', 2),

('def_ammo_longrange_cruisemissile_b', 'def_phlobotil', 150),
('def_ammo_longrange_cruisemissile_b', 'def_axicoline', 150),
('def_ammo_longrange_cruisemissile_b', 'def_titanium', 75),
('def_ammo_longrange_cruisemissile_b', 'def_specimen_sap_item_flux', 2),

('def_ammo_longrange_cruisemissile_c', 'def_phlobotil', 150),
('def_ammo_longrange_cruisemissile_c', 'def_polynucleit', 75),
('def_ammo_longrange_cruisemissile_c', 'def_titanium', 75),
('def_ammo_longrange_cruisemissile_c', 'def_specimen_sap_item_flux', 2),

('def_ammo_longrange_cruisemissile_d', 'def_phlobotil', 300),
('def_ammo_longrange_cruisemissile_d', 'def_titanium', 75),
('def_ammo_longrange_cruisemissile_d', 'def_specimen_sap_item_flux', 2);

PRINT N'DELETE components FOR ANY EXISTING LARGE mods (0 results if 1st run)';
SELECT * FROM components WHERE definition IN (SELECT definition FROM entitydefaults WHERE definitionname IN (SELECT DISTINCT defName FROM #AMMO_COMPS));
DELETE FROM components WHERE definition IN (SELECT definition FROM entitydefaults WHERE definitionname IN (SELECT DISTINCT defName FROM #AMMO_COMPS));

PRINT N'INSERT components FORLARGE mods';
INSERT INTO components (definition, componentdefinition, componentamount)
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defName),
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=commodityName),
	amount
FROM #AMMO_COMPS;


DROP TABLE IF EXISTS #AMMO_COMPS;
GO


PRINT N'CALIBRATION TEMPLATES FOR MODULES';

DECLARE @CTammoLaserCategory BIGINT;
DECLARE @CTammoRailgunCategory BIGINT;
DECLARE @CTammoMissileCategory BIGINT;

SET @CTammoLaserCategory = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_ammo_laser_calibration_programs');
SET @CTammoRailgunCategory = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_ammo_railgun_calibration_programs');
SET @CTammoMissileCategory = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_ammo_missile_calibration_programs');



DROP TABLE IF EXISTS #AMMOCTS;
CREATE TABLE #AMMOCTS 
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

INSERT INTO #AMMOCTS (defName, attrFlags, catFlags, cargoVolume, massOfModule, techType, techLevel, genxyOptStr) VALUES
('def_ammo_large_railgun_a_cprg', 1024, @CTammoRailgunCategory, 0.01, 0.1, NULL, NULL, NULL),
('def_ammo_large_railgun_b_cprg', 1024, @CTammoRailgunCategory, 0.01, 0.1, NULL, NULL, NULL),
('def_ammo_large_railgun_c_cprg', 1024, @CTammoRailgunCategory, 0.01, 0.1, NULL, NULL, NULL),
('def_ammo_large_railgun_d_cprg', 1024, @CTammoRailgunCategory, 0.01, 0.1, NULL, NULL, NULL),
--
('def_ammo_large_lasercrystal_a_cprg', 1024, @CTammoLaserCategory, 0.01, 0.1, NULL, NULL, NULL),
('def_ammo_large_lasercrystal_b_cprg', 1024, @CTammoLaserCategory, 0.01, 0.1, NULL, NULL, NULL),
('def_ammo_large_lasercrystal_c_cprg', 1024, @CTammoLaserCategory, 0.01, 0.1, NULL, NULL, NULL),
('def_ammo_large_lasercrystal_d_cprg', 1024, @CTammoLaserCategory, 0.01, 0.1, NULL, NULL, NULL),
--
('def_ammo_cruisemissile_a_cprg', 1024, @CTammoMissileCategory, 0.01, 0.1, NULL, NULL, NULL),
('def_ammo_cruisemissile_b_cprg', 1024, @CTammoMissileCategory, 0.01, 0.1, NULL, NULL, NULL),
('def_ammo_cruisemissile_c_cprg', 1024, @CTammoMissileCategory, 0.01, 0.1, NULL, NULL, NULL),
('def_ammo_cruisemissile_d_cprg', 1024, @CTammoMissileCategory, 0.01, 0.1, NULL, NULL, NULL),
--
('def_ammo_longrange_cruisemissile_a_cprg', 1024, @CTammoMissileCategory, 0.01, 0.1, NULL, NULL, NULL),
('def_ammo_longrange_cruisemissile_b_cprg', 1024, @CTammoMissileCategory, 0.01, 0.1, NULL, NULL, NULL),
('def_ammo_longrange_cruisemissile_c_cprg', 1024, @CTammoMissileCategory, 0.01, 0.1, NULL, NULL, NULL),
('def_ammo_longrange_cruisemissile_d_cprg', 1024, @CTammoMissileCategory, 0.01, 0.1, NULL, NULL, NULL);




PRINT N'UPDATE/INSERT CTS';
--Update/insert [entitydefaults] entries
MERGE [dbo].[entitydefaults] def USING #AMMOCTS ct
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
	(defName, 1, attrFlags,catFlags,genxyOptStr,'CT large AMMO',1,cargoVolume,massOfModule,0,100,'calibration_program_desc',0,techType,techLevel);

PRINT N'DELETE calibrationdefaults FOR ANY EXISTING LARGE MOD CTS (0 results if 1st run)';
SELECT * FROM calibrationdefaults WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #AMMOCTS));
DELETE FROM calibrationdefaults WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #AMMOCTS));

PRINT N'INSERT calibrationdefaults FOR MOD CTS';
INSERT INTO calibrationdefaults (definition, materialefficiency, timeefficiency)
SELECT (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = defName), 80, 80 FROM #AMMOCTS;

DROP TABLE IF EXISTS #PROTO_TO_CT;
CREATE TABLE #PROTO_TO_CT
(
	protoDefName VARCHAR(100),
	ctDefName VARCHAR(100),
	level INT
);

INSERT INTO #PROTO_TO_CT (protoDefName, ctDefName, level) VALUES
('def_ammo_large_railgun_a', 'def_ammo_large_railgun_a_cprg', 5),
('def_ammo_large_railgun_b', 'def_ammo_large_railgun_b_cprg', 5),
('def_ammo_large_railgun_c', 'def_ammo_large_railgun_c_cprg', 5),
('def_ammo_large_railgun_d', 'def_ammo_large_railgun_d_cprg', 5),
--
('def_ammo_large_lasercrystal_a', 'def_ammo_large_lasercrystal_a_cprg', 5),
('def_ammo_large_lasercrystal_b', 'def_ammo_large_lasercrystal_b_cprg', 5),
('def_ammo_large_lasercrystal_c', 'def_ammo_large_lasercrystal_c_cprg', 5),
('def_ammo_large_lasercrystal_d', 'def_ammo_large_lasercrystal_d_cprg', 5),
--
('def_ammo_cruisemissile_a', 'def_ammo_cruisemissile_a_cprg', 5),
('def_ammo_cruisemissile_b', 'def_ammo_cruisemissile_b_cprg', 5),
('def_ammo_cruisemissile_c', 'def_ammo_cruisemissile_c_cprg', 5),
('def_ammo_cruisemissile_d', 'def_ammo_cruisemissile_d_cprg', 5),
--
('def_ammo_longrange_cruisemissile_a', 'def_ammo_longrange_cruisemissile_a_cprg', 5),
('def_ammo_longrange_cruisemissile_b', 'def_ammo_longrange_cruisemissile_b_cprg', 5),
('def_ammo_longrange_cruisemissile_c', 'def_ammo_longrange_cruisemissile_c_cprg', 5),
('def_ammo_longrange_cruisemissile_d', 'def_ammo_longrange_cruisemissile_d_cprg', 5);

PRINT N'DELETE itemresearchlevels FOR ANY EXISTING LARGE MOD CTS (0 results if 1st run)';
SELECT * FROM itemresearchlevels WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT protoDefName FROM #PROTO_TO_CT));
DELETE FROM itemresearchlevels WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT protoDefName FROM #PROTO_TO_CT));

PRINT N'INSERT itemresearchlevels FOR MOD CTS';
INSERT INTO itemresearchlevels (definition, calibrationprogram, researchlevel, enabled)
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = protoDefName), 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = ctDefName), 
	level, 1
FROM #PROTO_TO_CT;


DROP TABLE IF EXISTS #AMMOCTS;
DROP TABLE IF EXISTS #PROTO_TO_CT;
GO