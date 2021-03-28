USE [perpetuumsa]
GO
----------------------------------
-- Metis balance updates
-- Date modified: 2021/03/15
----------------------------------

DROP TABLE IF EXISTS #AGG_VALS;
CREATE TABLE #AGG_VALS(
	defName VARCHAR(100),
	fieldName VARCHAR(100),
	fieldValue float
);
INSERT INTO #AGG_VALS (defName, fieldName, fieldValue) VALUES
('def_metis_head', 'locked_targets_max', 6),
('def_metis_head', 'sensor_strength', 95),
('def_metis_head', 'detection_strength', 80),
('def_metis_head', 'stealth_strength', 105);


PRINT N'UPDATE AGG VALUES';
MERGE [dbo].[aggregatevalues] a USING #AGG_VALS v
ON a.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=v.defName) AND
a.field = (SELECT TOP 1 id FROM aggregatefields WHERE name=v.fieldName)
WHEN MATCHED
    THEN UPDATE SET
		value=v.fieldValue;


DROP TABLE IF EXISTS #AGG_VALS;
PRINT N'UPDATED METIS BOT STATS';