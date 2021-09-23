USE [perpetuumsa]
GO

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
(4806,'def_reactor_booster_a', 2052, 916, 10, 15000, NULL, 'def_reactor_booster_a_desc', 1, 1),
(6110,'def_reactor_booster_b', 2052, 916, 10, 15000, NULL, 'def_reactor_booster_a_desc', 1, 2),
(6111,'def_reactor_booster_c', 2052, 916, 10, 15000, NULL, 'def_reactor_booster_a_desc', 1, 3);


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
('def_reactor_booster_a', 2000000),
('def_reactor_booster_b', 4000000),
('def_reactor_booster_c', 8000000);

DROP TABLE IF EXISTS #MATS;
CREATE TABLE #MATS
(
	defName varchar(100),
	componentDefName varchar(100),
	amount int
);
INSERT INTO #MATS (defName, componentDefName, amount) VALUES
('def_reactor_booster_b', 'def_titanium', 150),
('def_reactor_booster_b', 'def_axicol', 750),
('def_reactor_booster_b', 'def_vitricyl', 750),
('def_reactor_booster_b', 'def_chollonin', 750),
('def_reactor_booster_b', 'def_prilumium', 750),
('def_reactor_booster_b', 'def_espitium', 750),
('def_reactor_booster_b', 'def_unimetal', 150),
('def_reactor_booster_b', 'def_gamma_energyblock', 50),

('def_reactor_booster_c', 'def_titanium', 225),
('def_reactor_booster_c', 'def_axicol', 1125),
('def_reactor_booster_c', 'def_vitricyl', 1125),
('def_reactor_booster_c', 'def_chollonin', 1125),
('def_reactor_booster_c', 'def_prilumium', 1125),
('def_reactor_booster_c', 'def_espitium', 1125),
('def_reactor_booster_c', 'def_unimetal', 225),
('def_reactor_booster_c', 'def_gamma_energyblock', 75);


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
	(def, defName, 1, attrFlags, catFlags, genxyOptStr, 'Reactor fuel rods', 1 ,cargoVolume, massOfModule, 0, 100, description, 0, tierType, tierLevel);
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


DROP TABLE IF EXISTS #MATS;
DROP TABLE IF EXISTS #CORE;
DROP TABLE IF EXISTS #ENTITYDEFS;
GO