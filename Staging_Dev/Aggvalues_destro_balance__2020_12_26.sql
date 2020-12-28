USE [perpetuumsa]
GO
------------------------------------------------
-- Destroyer balance round 1 for P20
-- Onyx reduce locking and LR gun optimal range
-- Seth reduce locking range
-- Destro locked targets 2->3
-- Hydra LR ammo falloff inc
-- Felos LR gun falloff inc
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
('def_felos_bot_head', 'locking_range', 35),--was 36
('def_hydra_bot_head', 'locking_range', 36),--was 37
('def_onyx_bot_head', 'locking_range', 37),--was 40

('def_seth_head', 'locking_range', 35),--was 37
('def_seth_head_mk2', 'locking_range', 35),
('def_seth_head_pr', 'locking_range', 35),

('def_longrange_standard_large_laser', 'optimal_range', 44),--was 50
('def_longrange_standard_large_laser_pr', 'optimal_range', 44),
('def_named1_longrange_large_laser', 'optimal_range', 44),
('def_named1_longrange_large_laser_pr', 'optimal_range', 44),
('def_named2_longrange_large_laser', 'optimal_range', 45.5),--was 51.5
('def_named2_longrange_large_laser_pr', 'optimal_range', 45.5),
('def_named3_longrange_large_laser', 'optimal_range', 46.5),--was 52.5
('def_named3_longrange_large_laser_pr', 'optimal_range', 46.5),

('def_longrange_standard_large_railgun', 'falloff', 25.5),--was 22.5
('def_longrange_standard_large_railgun_pr', 'falloff', 25.5),
('def_named1_longrange_large_railgun', 'falloff', 25.5),--was 22.5
('def_named1_longrange_large_railgun_pr', 'falloff', 25.5),
('def_named2_longrange_large_railgun', 'falloff', 24),--was 21
('def_named2_longrange_large_railgun_pr', 'falloff', 24),
('def_named3_longrange_large_railgun', 'falloff', 24),--was 21
('def_named3_longrange_large_railgun_pr', 'falloff', 24),

('def_ammo_longrange_cruisemissile_a', 'falloff', 15),--was 10
('def_ammo_longrange_cruisemissile_b', 'falloff', 15),
('def_ammo_longrange_cruisemissile_c', 'falloff', 15),
('def_ammo_longrange_cruisemissile_d', 'falloff', 15),
('def_ammo_longrange_cruisemissile_a_pr', 'falloff', 15),
('def_ammo_longrange_cruisemissile_b_pr', 'falloff', 15),
('def_ammo_longrange_cruisemissile_c_pr', 'falloff', 15),
('def_ammo_longrange_cruisemissile_d_pr', 'falloff', 15);


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
