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


SELECT * FROM beamassignment WHERE definition in (SELECT entitydefaults.definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT ammoName FROM #BEAMS));
DELETE FROM beamassignment WHERE definition in (SELECT entitydefaults.definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT ammoName FROM #BEAMS));

INSERT INTO beamassignment (definition, beam)
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=ammoName),
	(SELECT TOP 1 id FROM beams WHERE name=beamName)
FROM #BEAMS


DROP TABLE IF EXISTS #BEAMS;
DROP TABLE IF EXISTS #STATS;
DROP TABLE IF EXISTS #ENTITYDEFS
GO
