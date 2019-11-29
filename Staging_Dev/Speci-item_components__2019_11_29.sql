USE [perpetuumsa]
GO

------------------------------------------------
--Specimen item production table rebalance
--
--Last Modified: 2019/11/29
------------------------------------------------

DECLARE @itemName VARCHAR(128);
DECLARE @itemDef int;
SET @itemName = 'def_specimen_sap_item';
SET @itemDef = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@itemName);

PRINT N'SETUP TEMP TABLES';
DROP TABLE IF EXISTS #AMOUNTS_TABLE
CREATE TABLE #AMOUNTS_TABLE
(
	matName varchar(128),
	matAmount int
);

INSERT INTO #AMOUNTS_TABLE (matName, matAmount) VALUES
('def_titan', 10000),
('def_crude', 40000),
('def_liquizit', 20000),
('def_silgium', 10000),
('def_stermonit', 10000),
('def_imentium', 10000),
('def_helioptris', 10000),
('def_triandlus', 10000),
('def_prismocitae', 10000),
('def_specimen_sap_item_flux', 1);


PRINT N'Checking for existing components...';
IF EXISTS (SELECT TOP 1 definition from [components] WHERE definition=@itemDef)
BEGIN
	PRINT N'Found Existing components for this item... DELETING!!!';
	DELETE FROM components WHERE definition=@itemDef;
	PRINT N'Item Production table deleted';
END

PRINT N'INSERT [components] FOR PRODUCTION MATERIAL REQUIREMENTS';
INSERT INTO [dbo].[components] ([definition],[componentdefinition],[componentamount])
SELECT @itemDef, (SELECT TOP 1 definition FROM entitydefaults WHERE m.matName=definitionname), m.matAmount FROM #AMOUNTS_TABLE as m;


PRINT N'Specimen item production table updated';
GO