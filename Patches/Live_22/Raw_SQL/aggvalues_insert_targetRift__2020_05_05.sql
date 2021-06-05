USE [perpetuumsa]
GO

-----------------------------------------------------
-- Targetted rift stats (mostly for masking)
--
-- Date Modified: 2021_05_05
-----------------------------------------------------


DROP TABLE IF EXISTS #STATS;
CREATE TABLE #STATS(
	defName VARCHAR(100),
	fieldName VARCHAR(100),
	val FLOAT
);
INSERT INTO #STATS (defName, fieldName, val) VALUES
('def_rift_targetted_portal','armor_max',42069),
('def_rift_targetted_portal','resist_chemical',100000),
('def_rift_targetted_portal','resist_explosive',100000),
('def_rift_targetted_portal','resist_kinetic',100000),
('def_rift_targetted_portal','resist_thermal',100000),
('def_rift_targetted_portal','signature_radius',1),
('def_rift_targetted_portal','blob_emission',10),
('def_rift_targetted_portal','blob_emission_radius',50),
('def_rift_targetted_portal','stealth_strength',25);

PRINT N'DELETE aggregatevalues TO BE REPLACED (0 rows affected)<-1ST RUN';
DELETE FROM aggregatevalues WHERE definition IN 
	(SELECT definition FROM entitydefaults WHERE definitionname IN 
		(SELECT DISTINCT defName FROM #STATS));

PRINT N'INSERT aggregatevalues (9 rows affected)';
INSERT INTO aggregatevalues(definition, field, value)
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defName),
	(SELECT TOP 1 id FROM aggregatefields WHERE name=fieldName),
	val
FROM #STATS;


DROP TABLE IF EXISTS #STATS;
GO
