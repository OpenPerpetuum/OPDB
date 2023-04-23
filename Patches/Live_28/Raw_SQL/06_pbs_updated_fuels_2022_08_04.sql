USE [perpetuumsa]
GO

----------------------------------------
-- update to fuel properties
-- modified 2022/08/04
----------------------------------------

DROP TABLE IF EXISTS #CORE;
CREATE TABLE #CORE
(
	defName varchar(100),
	energyAmount int
);

INSERT INTO #CORE (defName, energyAmount) VALUES
('def_axicol', 40), --50
('def_espitium', 400), --500
('def_specimen_sap_item_flux', 28000),
('def_gamma_energyblock', 2000), --2200
('def_corebooster_ammo',1000); --750

MERGE [dbo].[definitionconfig] d USING #CORE c
ON d.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE c.defName=definitionname)
WHEN MATCHED
    THEN UPDATE SET
		corecalories=c.energyAmount;

DROP TABLE IF EXISTS #CORE;
PRINT N'UPDATED FUELS';
GO