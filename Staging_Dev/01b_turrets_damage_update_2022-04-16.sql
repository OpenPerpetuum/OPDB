USE [perpetuumsa]
GO

----------------------------------------
-- update to turrets damage
-- updates the damages for strongohold and pbs
-- modified 2022/04/16
----------------------------------------

DROP TABLE IF EXISTS #AGG_VALS;
CREATE TABLE #AGG_VALS(
	defName VARCHAR(100),
	fieldName VARCHAR(100),
	fieldValue float
);
INSERT INTO #AGG_VALS (defName, fieldName, fieldValue) VALUES
('def_turret_laser', 'damage_modifier', 17.5), --10
('def_turret_railgun', 'damage_modifier', 26); --30


PRINT N'UPDATE AGG VALUES';
MERGE [dbo].[aggregatevalues] a USING #AGG_VALS v
ON a.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=v.defName) AND
a.field = (SELECT TOP 1 id FROM aggregatefields WHERE name=v.fieldName)
WHEN MATCHED
    THEN UPDATE SET
		value=v.fieldValue;


DROP TABLE IF EXISTS #AGG_VALS;
PRINT N'UPDATED TURRET DMG';
GO