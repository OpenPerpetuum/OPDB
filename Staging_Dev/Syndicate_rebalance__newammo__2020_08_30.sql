USE [perpetuumsa]
GO

--------------------------------------------------
-- Syndicate balance
-- Insert new ammo for firearms with different toxic dmg balance
-- Updates toxic dmg on existing ammo and bombs
-- Updates syndicate bot stats
-- Updates syndicate bot bonuses
-- Last Modified: 2020/12/01
--------------------------------------------------

DECLARE @toxicDamageName VARCHAR(100);
SET @toxicDamageName = 'damage_toxic';

DECLARE @tmShops INT;
SET @tmShops = (SELECT TOP 1 id FROM itemshoppresets WHERE name='tm_preset_pve');

DECLARE @dynCtCategory bigint;
SET @dynCtCategory = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_dynamic_cprg');

DECLARE @smallToxicAmmo INT;
DECLARE @smallToxicAmmoCT INT;
DECLARE @smallToxicAmmoCTCAPSULE INT;
DECLARE @medToxicAmmo INT;
DECLARE @medToxicAmmoCT INT;
DECLARE @medToxicAmmoCTCAPSULE INT;

SET @smallToxicAmmo = 5924;
SET @smallToxicAmmoCT = 5925;
SET @smallToxicAmmoCTCAPSULE = 5926;
SET @medToxicAmmo = 5927;
SET @medToxicAmmoCT = 5928;
SET @medToxicAmmoCTCAPSULE = 5929;

DROP TABLE IF EXISTS #AMMODEFS;
CREATE TABLE #AMMODEFS(
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
INSERT INTO #AMMODEFS ([definition],[definitionname],[quantity],[attributeflags],[categoryflags],[options],[note],[enabled],[volume],[mass],[hidden],[health],[descriptiontoken],[purchasable],[tiertype],[tierlevel]) VALUES
(@smallToxicAmmo,'def_ammo_small_projectile_t',1000,34816,66314,'#bullettime=f45.0','toxic ammo small',1,0.5,0.1,0,100,'def_ammo_projectile_t_desc',1,0,0),
(@smallToxicAmmoCT,'def_ammo_small_projectile_t_cprg',1,1024,@dynCtCategory,NULL,NULL,1,0.01,0.1,0,100,'calibration_program_desc',0,NULL,NULL),
(@smallToxicAmmoCTCAPSULE,'def_ammo_small_projectile_t_CT_capsule',1,2052,1179,'','CT Capsule!',1,0.1,0.1,0,100,'def_ammo_small_projectile_t_CT_capsule_desc',1,0,0),
(@medToxicAmmo,'def_ammo_medium_projectile_t',1000,67584,131850,'#bullettime=f50.0','toxic ammo med',1,1,0.2,0,100,'def_ammo_projectile_t_desc',1,0,0),
(@medToxicAmmoCT,'def_ammo_medium_projectile_t_cprg',1,1024,@dynCtCategory,NULL,NULL,1,0.01,0.1,0,100,'calibration_program_desc',0,NULL,NULL),
(@medToxicAmmoCTCAPSULE,'def_ammo_medium_projectile_t_CT_capsule',1,2052,1179,'','CT Capsule!',1,0.1,0.1,0,100,'def_ammo_medium_projectile_t_CT_capsule_desc',1,0,0);


DROP TABLE IF EXISTS #AMMOCOMPONENTS;
CREATE TABLE #AMMOCOMPONENTS(
	defName VARCHAR(100),
	compDefName VARCHAR(100),
	amount FLOAT
);
INSERT INTO #AMMOCOMPONENTS (defName, compDefName, amount) VALUES
('def_ammo_small_projectile_t','def_titanium',100),
('def_ammo_small_projectile_t','def_phlobotil',100),
('def_ammo_small_projectile_t','def_polynucleit',100),
('def_ammo_small_projectile_t','def_polynitrocol',100),
('def_ammo_small_projectile_t','def_axicoline',100),

('def_ammo_medium_projectile_t','def_titanium',200),
('def_ammo_medium_projectile_t','def_phlobotil',200),
('def_ammo_medium_projectile_t','def_polynucleit',200),
('def_ammo_medium_projectile_t','def_polynitrocol',200),
('def_ammo_medium_projectile_t','def_axicoline',200);


DROP TABLE IF EXISTS #SHOPENTRIES;
CREATE TABLE #SHOPENTRIES
(
	defName varchar(100),
	tokenPrice int,
	nicPrice int
);
INSERT INTO #SHOPENTRIES (defName, tokenPrice, nicPrice) VALUES
('def_ammo_small_projectile_t_CT_capsule', 20, 1000000),
('def_ammo_medium_projectile_t_CT_capsule', 100, 5000000);

DROP TABLE IF EXISTS #TOXICDMG;
CREATE TABLE #TOXICDMG(
	ammoName VARCHAR(100),
	dmg INT
);
INSERT INTO #TOXICDMG(ammoName, dmg) VALUES
('def_ammo_large_projectile_a', 18),
('def_ammo_large_projectile_b', 18),
('def_ammo_large_projectile_c', 18),
('def_ammo_large_projectile_d', 18),
('def_ammo_medium_projectile_a', 12),
('def_ammo_medium_projectile_b', 12),
('def_ammo_medium_projectile_c', 12),
('def_ammo_medium_projectile_d', 12),
('def_ammo_medium_projectile_rewa', 12),
('def_ammo_medium_projectile_rewb', 12),
('def_ammo_small_projectile_a', 6),
('def_ammo_small_projectile_b', 6),
('def_ammo_small_projectile_c', 6),
('def_ammo_small_projectile_d', 6),
('def_ammo_small_projectile_rewa', 6),
('def_ammo_small_projectile_rewb', 6);


DROP TABLE IF EXISTS #TOXICBOMB;
CREATE TABLE #TOXICBOMB(
	bombName VARCHAR(100),
	toxicDmg INT,
	chemicalDmg INT,
	explosionRange INT,
	volume FLOAT
);
INSERT INTO #TOXICBOMB(bombName, toxicDmg, chemicalDmg, explosionRange, volume) VALUES
('def_area_bomb', 1000, 3500, 13, 1),
('def_area_bomb_capsule', 1000, 3500, 15, 7.5),
('def_plant_bomb', 2000, 1000, 13, 1),
('def_plant_bomb_capsule', 2000, 1000, 15, 4);


DROP TABLE IF EXISTS #STATS;
CREATE TABLE #STATS(
	defName VARCHAR(100),
	fieldName VARCHAR(100),
	value FLOAT
);
INSERT INTO #STATS (defName, fieldName, value) VALUES
--('def_vektor_chassis','core_max',200),
--('def_vektor_chassis','core_recharge_time',120),
--('def_vektor_chassis','signature_radius',4.5),
--('def_vektor_leg','speed_max',2.97),

--('def_helix_chassis','core_max',350),
--('def_helix_chassis','core_recharge_time',120),
--('def_helix_chassis','signature_radius',4),
('def_helix_leg','speed_max',3.388), --changed

('def_locust_chassis','core_max',420), --changed
('def_locust_chassis','core_recharge_time',180),
('def_locust_chassis','signature_radius',5.5),
('def_locust_leg','speed_max',2.933), --changed

('def_echelon_chassis','core_max',2050),--changed
('def_echelon_chassis','core_recharge_time',420),
('def_echelon_chassis','signature_radius',10),--changed
('def_echelon_leg','speed_max',2.48),--changed

('def_callisto_chassis','core_max',2600),
('def_callisto_chassis','core_recharge_time',360),
('def_callisto_chassis','signature_radius',9),--changed
('def_callisto_leg','speed_max',2.556),

('def_legatus_chassis','core_max',3850),
('def_legatus_chassis','core_recharge_time',720),
('def_legatus_chassis','signature_radius',22),--changed
('def_legatus_leg','speed_max',1.847),--changed

--('def_ikarus_chassis','core_max',150),
--('def_ikarus_chassis','core_recharge_time',240),
--('def_ikarus_chassis','signature_radius',4),
--('def_ikarus_leg','speed_max',3.35),

--('def_cronus_chassis','core_max',1400),
--('def_cronus_chassis','core_recharge_time',300),
--('def_cronus_chassis','signature_radius',5),
--('def_cronus_leg','speed_max',2.75),

--('def_hermes_chassis','core_max',450),
--('def_hermes_chassis','core_recharge_time',240),
--('def_hermes_chassis','signature_radius',4.5),
--('def_hermes_leg','speed_max',3),

--('def_daidalos_chassis','core_max',1800),
--('def_daidalos_chassis','core_recharge_time',480),
--('def_daidalos_chassis','signature_radius',11),
--('def_daidalos_leg','speed_max',2.25),

--('def_metis_chassis','core_max',3250),
--('def_metis_chassis','core_recharge_time',360),
--('def_metis_chassis','signature_radius',23),
--('def_metis_leg','speed_max',1.7),
--Guns
--('def_standard_medium_autocannon','cycle_time',4000),
--('def_standard_medium_autocannon','damage_modifier',1.6),
--('def_standard_medium_autocannon','falloff',20),
--('def_standard_medium_autocannon','optimal_range',12.5),

--('def_named1_medium_autocannon','cycle_time',4000),
--('def_named1_medium_autocannon','damage_modifier',1.6),
--('def_named1_medium_autocannon','falloff',20),
--('def_named1_medium_autocannon','optimal_range',12.5),

--('def_named1_medium_autocannon_pr','cycle_time',4000),
--('def_named1_medium_autocannon_pr','damage_modifier',1.6),
--('def_named1_medium_autocannon_pr','falloff',20),
--('def_named1_medium_autocannon_pr','optimal_range',12.5),

--('def_named2_medium_autocannon','cycle_time',4000),
--('def_named2_medium_autocannon','damage_modifier',1.7),
--('def_named2_medium_autocannon','falloff',21.5),
--('def_named2_medium_autocannon','optimal_range',14.5),

--('def_named2_medium_autocannon_pr','cycle_time',4000),
--('def_named2_medium_autocannon_pr','damage_modifier',1.7),
--('def_named2_medium_autocannon_pr','falloff',21.5),
--('def_named2_medium_autocannon_pr','optimal_range',14.5),

--('def_named3_medium_autocannon','cycle_time',3000),
--('def_named3_medium_autocannon','damage_modifier',1.35),
--('def_named3_medium_autocannon','falloff',18.5),
--('def_named3_medium_autocannon','optimal_range',15),

--('def_named3_medium_autocannon_pr','cycle_time',3000),
--('def_named3_medium_autocannon_pr','damage_modifier',1.35),
--('def_named3_medium_autocannon_pr','falloff',18.5),
--('def_named3_medium_autocannon_pr','optimal_range',15),

('def_longrange_standard_medium_autocannon','cycle_time',8000),
('def_longrange_standard_medium_autocannon','damage_modifier',2.0),
('def_longrange_standard_medium_autocannon','falloff',28),
('def_longrange_standard_medium_autocannon','optimal_range',22),

('def_named1_longrange_medium_autocannon','cycle_time',8000),
('def_named1_longrange_medium_autocannon','damage_modifier',2.0),
('def_named1_longrange_medium_autocannon','falloff',28),
('def_named1_longrange_medium_autocannon','optimal_range',22),

('def_named1_longrange_medium_autocannon_pr','cycle_time',8000),
('def_named1_longrange_medium_autocannon_pr','damage_modifier',2.0),
('def_named1_longrange_medium_autocannon_pr','falloff',28),
('def_named1_longrange_medium_autocannon_pr','optimal_range',22),

('def_named2_longrange_medium_autocannon','cycle_time',6000),
('def_named2_longrange_medium_autocannon','damage_modifier',1.70),
('def_named2_longrange_medium_autocannon','falloff',31.0),
('def_named2_longrange_medium_autocannon','optimal_range',23.5),

('def_named2_longrange_medium_autocannon_pr','cycle_time',6000),
('def_named2_longrange_medium_autocannon_pr','damage_modifier',1.70),
('def_named2_longrange_medium_autocannon_pr','falloff',31.0),
('def_named2_longrange_medium_autocannon_pr','optimal_range',23.5),

('def_named3_longrange_medium_autocannon','cycle_time',9000),
('def_named3_longrange_medium_autocannon','damage_modifier',2.70),
('def_named3_longrange_medium_autocannon','falloff',32.0),
('def_named3_longrange_medium_autocannon','optimal_range',24.0),

('def_named3_longrange_medium_autocannon_pr','cycle_time',9000),
('def_named3_longrange_medium_autocannon_pr','damage_modifier',2.70),
('def_named3_longrange_medium_autocannon_pr','falloff',32.0),
('def_named3_longrange_medium_autocannon_pr','optimal_range',24.0),
--NEW AMMO
('def_ammo_small_projectile_t','damage_chemical',12),
('def_ammo_small_projectile_t',@toxicDamageName,24),

('def_ammo_medium_projectile_t','damage_chemical',24),
('def_ammo_medium_projectile_t',@toxicDamageName,48);


DROP TABLE IF EXISTS #BONUS;
CREATE TABLE #BONUS(
	defName VARCHAR(100),
	fieldName VARCHAR(100),
	value FLOAT
);
INSERT INTO #BONUS (defName, fieldName, value) VALUES
('def_vektor_chassis','damage_toxic_modifier',0.5),
('def_locust_chassis','damage_toxic_modifier',0.5),
('def_echelon_chassis','damage_toxic_modifier',0.5),
('def_legatus_chassis','damage_toxic_modifier',0.5),

('def_vektor_leg','signature_radius',-0.05),
('def_helix_leg','signature_radius',-0.05),
('def_locust_leg','signature_radius',-0.075),--changed
('def_echelon_leg','signature_radius',-0.175),--changed
('def_callisto_leg','signature_radius',-0.1),
('def_legatus_leg','signature_radius',-0.4),--changed
('def_daidalos_leg','signature_radius',-0.2);


DROP TABLE IF EXISTS #BEAMS;
CREATE TABLE #BEAMS 
(
	ammoName varchar(100),
	beamName varchar(100)
);
INSERT INTO #BEAMS (ammoName, beamName) VALUES
('def_ammo_small_projectile_t', 'pnc_small_bullet'),
('def_ammo_medium_projectile_t', 'pnc_medium_bullet');


DROP TABLE IF EXISTS #ENABLESKILLS;
CREATE TABLE #ENABLESKILLS 
(
	ammoName VARCHAR(100),
	extName VARCHAR(100),
	level INT
);
INSERT INTO #ENABLESKILLS (ammoName, extName, level) VALUES
('def_ammo_small_projectile_t','ext_small_projectile_turret',8),
('def_ammo_medium_projectile_t','ext_medium_projectile_turret',8);


DROP TABLE IF EXISTS #PROTO_TO_CT;
CREATE TABLE #PROTO_TO_CT
(
	protoDefName VARCHAR(100),
	ctDefName VARCHAR(100),
	level INT
);

INSERT INTO #PROTO_TO_CT (protoDefName, ctDefName, level) VALUES
('def_ammo_small_projectile_t','def_ammo_small_projectile_t_cprg', 2),
('def_ammo_medium_projectile_t','def_ammo_medium_projectile_t_cprg', 2);


SET IDENTITY_INSERT entitydefaults ON;
MERGE entitydefaults d USING #AMMODEFS a
ON d.definition=a.definition AND d.definitionname=a.definitionname
WHEN MATCHED
    THEN UPDATE SET
		d.[quantity]=a.[quantity],
		d.[attributeflags]=a.[attributeflags],
		d.[categoryflags]=a.[categoryflags],
		d.[options]=a.[options],
		d.[note]=a.[note],
		d.[enabled]=a.[enabled],
		d.[volume]=a.[volume],
		d.[mass]=a.[mass],
		d.[hidden]=a.[hidden],
		d.[health]=a.[health],
		d.[descriptiontoken]=a.[descriptiontoken],
		d.[purchasable]=a.[purchasable],
		d.[tiertype]=a.[tiertype],
		d.[tierlevel]=a.[tierlevel]
WHEN NOT MATCHED
    THEN INSERT([definition],[definitionname],[quantity],[attributeflags],[categoryflags],[options],[note],[enabled],[volume],[mass],[hidden],[health],[descriptiontoken],[purchasable],[tiertype],[tierlevel]) VALUES
	(a.[definition],a.[definitionname],a.[quantity],a.[attributeflags],a.[categoryflags],a.[options],a.[note],a.[enabled],a.[volume],a.[mass],a.[hidden],a.[health],a.[descriptiontoken],a.[purchasable],a.[tiertype],a.[tierlevel]);
SET IDENTITY_INSERT entitydefaults OFF;

PRINT N'INSERT OR UPDATE [dynamiccalibrationtemplates] FOR NEW TOXIC AMMO';
IF NOT EXISTS (SELECT TOP 1 definition FROM dynamiccalibrationtemplates WHERE definition=@smallToxicAmmoCT)
BEGIN
	PRINT N'INSERTING 2 RECORDS ON [dynamiccalibrationtemplates]...';
	INSERT INTO [dbo].dynamiccalibrationtemplates([definition],[materialefficiency],[timeefficiency],[targetdefinition]) VALUES
		(@smallToxicAmmoCT, 10, 10, @smallToxicAmmo),
		(@medToxicAmmoCT, 10, 10, @medToxicAmmo);
	PRINT N'INSERTED';
END
ELSE
BEGIN
	PRINT N'UPDATING 2 RECORDS ON [dynamiccalibrationtemplates]...';
	UPDATE dynamiccalibrationtemplates SET
		materialefficiency=10,
		timeefficiency=10
	WHERE definition in (@smallToxicAmmoCT, @medToxicAmmoCT);
	PRINT N'UPDATED';
END

PRINT N'INSERT if missing [calibrationtemplateitems] FOR NEW TOXIC AMMO';
IF NOT EXISTS (SELECT TOP 1 definition FROM [calibrationtemplateitems] WHERE definition=@smallToxicAmmoCTCAPSULE)
BEGIN
	PRINT N'INSERTING 2 RECORDS ON [calibrationtemplateitems]...';
	INSERT INTO [dbo].[calibrationtemplateitems]
				([definition],[targetdefinition])
			VALUES
				(@smallToxicAmmoCTCAPSULE,@smallToxicAmmoCT),
				(@medToxicAmmoCTCAPSULE,@medToxicAmmoCT);
	PRINT N'INSERTED!';
END

DELETE FROM components WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #AMMOCOMPONENTS));
PRINT N'DELETE/RE-INSERT components FOR NEW TOXIC AMMO';
INSERT INTO components(definition, componentdefinition, componentamount)
	SELECT 
		(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=a.defName),
		(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=a.compDefName),
		a.amount
	FROM #AMMOCOMPONENTS AS a;


PRINT N'INSERT/UPDATE chassisbonus FOR SYNDICATE BOT STATS';
MERGE aggregatevalues v USING #STATS s
ON v.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=s.defName) AND
v.field = (SELECT TOP 1 id FROM aggregatefields WHERE name=s.fieldName)
WHEN MATCHED
    THEN UPDATE SET
		v.value = s.value
WHEN NOT MATCHED
    THEN INSERT(definition, field, value) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=s.defName),
	(SELECT TOP 1 id FROM aggregatefields WHERE name=s.fieldName),
	s.value);

PRINT N'INSERT/UPDATE chassisbonus FOR SYNDICATE BOT BONUSES';
MERGE chassisbonus c USING #BONUS b
ON c.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=b.defName) AND
c.targetPropertyID = (SELECT TOP 1 id FROM aggregatefields WHERE name=b.fieldName)
WHEN MATCHED
    THEN UPDATE SET
		c.bonus = b.value;


PRINT N'INSERT/UPDATE aggregatevalues FOR TOXIC DMG AMMO';
MERGE aggregatevalues v USING #TOXICDMG t
ON v.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=t.ammoName) AND
v.field = (SELECT TOP 1 id FROM aggregatefields WHERE name=@toxicDamageName)
WHEN MATCHED
    THEN UPDATE SET
		v.value = t.dmg
WHEN NOT MATCHED
    THEN INSERT(definition, field, value) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=t.ammoName),
	(SELECT TOP 1 id FROM aggregatefields WHERE name=@toxicDamageName),
	t.dmg);


PRINT N'UPDATE definitionconfig FOR BOMBS';
MERGE definitionconfig c USING #TOXICBOMB t
ON c.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=t.bombName)
WHEN MATCHED
    THEN UPDATE SET
		c.damage_toxic = t.toxicDmg,
		c.damage_chemical = t.chemicalDmg,
		c.item_work_range = t.explosionRange;

PRINT N'UPDATE entitydefaults FOR BOMBS';
MERGE entitydefaults d USING #TOXICBOMB t
ON d.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=t.bombName)
WHEN MATCHED
    THEN UPDATE SET
		d.volume = t.volume;

PRINT N'UPDATE npc-market sellorders for plant bomb';
UPDATE marketitems SET
	price=300000
WHERE itemdefinition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_plant_bomb_capsule') AND
isvendoritem=1 AND isSell=1;


PRINT N'DELETE/RE-INSERT beamassignment FOR NEW TOXIC AMMO';
DELETE FROM beamassignment WHERE definition in (SELECT entitydefaults.definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT ammoName FROM #BEAMS));
INSERT INTO beamassignment (definition, beam)
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=ammoName),
	(SELECT TOP 1 id FROM beams WHERE name=beamName)
FROM #BEAMS

--DELETE and REINSERT
PRINT N'DELETE AMMO REQ-EXTENSIONS';
DELETE FROM enablerextensions WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT ammoName FROM #ENABLESKILLS));
PRINT N'INSERT AMMO REQ-EXTENSIONS';
INSERT INTO [dbo].[enablerextensions] ([definition],[extensionid],[extensionlevel]) 
SELECT (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname= ammoName),
	(SELECT TOP 1 extensionid FROM extensions WHERE extensionname = extName),
	level
FROM #ENABLESKILLS;


PRINT N'DELETE itemresearchlevels FOR ANY EXISTING toxicammo ct pairs';
DELETE FROM itemresearchlevels WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT protoDefName FROM #PROTO_TO_CT));

--PRINT N'INSERT itemresearchlevels FOR toxicammo ct pairs';
--INSERT INTO itemresearchlevels (definition, calibrationprogram, researchlevel, enabled)
--SELECT 
--	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = protoDefName), 
--	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = ctDefName), 
--	level, 1
--FROM #PROTO_TO_CT;

PRINT N'[itemshop]';
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

PRINT N'DONE: new damage type added to bombs and projectile ammo';
DROP TABLE IF EXISTS #PROTO_TO_CT;
DROP TABLE IF EXISTS #SHOPENTRIES;
DROP TABLE IF EXISTS #AMMODEFS;
DROP TABLE IF EXISTS #AMMOCOMPONENTS;
DROP TABLE IF EXISTS #TOXICBOMB;
DROP TABLE IF EXISTS #TOXICDMG;
DROP TABLE IF EXISTS #BONUS;
DROP TABLE IF EXISTS #STATS;
GO