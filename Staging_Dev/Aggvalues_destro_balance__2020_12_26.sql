USE [perpetuumsa]
GO
------------------------------------------------
-- Destroyer balance round 1 for P20
-- Onyx reduce locking and LR gun optimal range
-- Seth reduce locking range
-- Destro locked targets 2->3
------------------------------------------------
PRINT N'DESTRO STAT UPDATES';
DROP TABLE IF EXISTS #STATS;
CREATE TABLE #STATS(
	defName varchar(100),
	fieldName varchar(100),
	fieldValue float,
);
INSERT INTO #STATS (defName, fieldName, fieldValue) VALUES
('def_felos_bot_head', 'locked_targets_max', 3),--was 2
('def_hydra_bot_head', 'locked_targets_max', 3),
('def_onyx_bot_head', 'locked_targets_max', 3),
('def_onyx_bot_head', 'locking_range', 38),--was 40

('def_seth_head', 'locking_range', 36),--was 37
('def_seth_head_mk2', 'locking_range', 36),
('def_seth_head_pr', 'locking_range', 36),

('def_longrange_standard_large_laser', 'optimal_range', 47.5),--was 50
('def_longrange_standard_large_laser_pr', 'optimal_range', 47.5),
('def_named1_longrange_large_laser', 'optimal_range', 47.5),
('def_named1_longrange_large_laser_pr', 'optimal_range', 47.5),
('def_named2_longrange_large_laser', 'optimal_range', 49),--was 51.5
('def_named2_longrange_large_laser_pr', 'optimal_range', 49),
('def_named3_longrange_large_laser', 'optimal_range', 50),--was 52.5
('def_named3_longrange_large_laser_pr', 'optimal_range', 50);

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

PRINT N'DESTRO STAT UPDATES complete';
DROP TABLE IF EXISTS #STATS;
GO
