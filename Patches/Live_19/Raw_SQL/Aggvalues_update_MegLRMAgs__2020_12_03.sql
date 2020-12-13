USE [perpetuumsa]
GO

------------------------------------------------------------
-- LR Med Magnetic weapon Accum and some fitting tweaks
--
-- Date Modified: 2020/12/03
------------------------------------------------------------

DROP TABLE IF EXISTS #STATS;
CREATE TABLE #STATS(
	defName VARCHAR(100),
	fieldName VARCHAR(100),
	fieldValue float
);

INSERT INTO #STATS (defName, fieldName, fieldValue) VALUES
('def_artifact_damaged_longrange_medium_railgun','core_usage',22),
('def_artifact_damaged_longrange_medium_railgun','cpu_usage',40),
('def_artifact_damaged_longrange_medium_railgun','powergrid_usage',185),

('def_artifact_a_longrange_medium_railgun','core_usage',25),
('def_artifact_a_longrange_medium_railgun','cpu_usage',45),
('def_artifact_a_longrange_medium_railgun','powergrid_usage',205),

('def_longrange_standard_medium_railgun','core_usage',22),
('def_longrange_standard_medium_railgun','cpu_usage',40),
('def_longrange_standard_medium_railgun','powergrid_usage',185),

('def_named1_longrange_medium_railgun','core_usage',20),
('def_named1_longrange_medium_railgun','cpu_usage',36),
('def_named1_longrange_medium_railgun','powergrid_usage',170),

('def_named1_longrange_medium_railgun_pr','core_usage',20),
('def_named1_longrange_medium_railgun_pr','cpu_usage',34),
('def_named1_longrange_medium_railgun_pr','powergrid_usage',163),

('def_named2_longrange_medium_railgun','core_usage',25),
('def_named2_longrange_medium_railgun','cpu_usage',43),
('def_named2_longrange_medium_railgun','powergrid_usage',185),

('def_named2_longrange_medium_railgun_pr','core_usage',25),
('def_named2_longrange_medium_railgun_pr','cpu_usage',38),
('def_named2_longrange_medium_railgun_pr','powergrid_usage',176),

('def_named3_longrange_medium_railgun','core_usage',29),
('def_named3_longrange_medium_railgun','cpu_usage',45),
('def_named3_longrange_medium_railgun','powergrid_usage',200),

('def_named3_longrange_medium_railgun_pr','core_usage',29),
('def_named3_longrange_medium_railgun_pr','cpu_usage',43),
('def_named3_longrange_medium_railgun_pr','powergrid_usage',190);



PRINT N'INSERT/UPDATE aggregatevalues FOR MAGNETIC WEAPONS, MED, LR';
MERGE aggregatevalues v USING #STATS s
ON v.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=s.defName) AND
v.field = (SELECT TOP 1 id FROM aggregatefields WHERE name=s.fieldName)
WHEN MATCHED
    THEN UPDATE SET
		v.value = s.fieldValue;

DROP TABLE IF EXISTS #STATS;
GO