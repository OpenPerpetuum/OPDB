USE [perpetuumsa]
GO

---------------------------------------------------
-- Light bot rebalance
-- Speed/mass, locking range, some reactor
-- EW mass added to be consistent at fitted velocity
-- Date modified: 2021/02/22
---------------------------------------------------

DROP TABLE IF EXISTS #CHASSIS_DEFS;
CREATE TABLE #CHASSIS_DEFS(
	defName VARCHAR(100),
	chassisMass float
);
INSERT INTO #CHASSIS_DEFS (defName, chassisMass) VALUES
('def_vektor_chassis', 8000),
('def_castel_chassis', 6500),
('def_yagel_chassis', 6750),
('def_prometheus_chassis', 6750),

('def_castel_chassis_pr', 6500),
('def_yagel_chassis_pr', 6750),
('def_prometheus_chassis_pr', 6750),

('def_castel_chassis_mk2', 7900),
('def_yagel_chassis_mk2', 8250),
('def_prometheus_chassis_mk2', 8250),

('def_helix_chassis', 5600),

('def_troiar_chassis', 4830),
('def_cameleon_chassis', 4500),
('def_intakt_chassis', 4500),

('def_troiar_chassis_pr', 4830),
('def_cameleon_chassis_pr', 4500),
('def_intakt_chassis_pr', 4500),

('def_troiar_chassis_mk2', 5800),
('def_cameleon_chassis_mk2', 5400),
('def_intakt_chassis_mk2', 5400);

DROP TABLE IF EXISTS #AGG_VALS;
CREATE TABLE #AGG_VALS(
	defName VARCHAR(100),
	fieldName VARCHAR(100),
	fieldValue float
);
INSERT INTO #AGG_VALS (defName, fieldName, fieldValue) VALUES
('def_vektor_leg', 'speed_max', 3.083),
('def_vektor_head', 'locking_range', 19),
('def_castel_leg', 'speed_max', 3.222),
('def_castel_head', 'locking_range', 18),
('def_castel_chassis', 'powergrid_max', 140),
('def_yagel_leg', 'speed_max', 3.527),
('def_yagel_head', 'locking_range', 17),
('def_yagel_chassis', 'powergrid_max', 155),
('def_prometheus_leg', 'speed_max', 3.222),
('def_prometheus_head', 'locking_range', 19),

('def_castel_leg_pr', 'speed_max', 3.222),
('def_castel_head_pr', 'locking_range', 18),
('def_castel_chassis_pr', 'powergrid_max', 140),
('def_yagel_leg_pr', 'speed_max', 3.527),
('def_yagel_head_pr', 'locking_range', 17),
('def_yagel_chassis_pr', 'powergrid_max', 155),
('def_prometheus_leg_pr', 'speed_max', 3.222),
('def_prometheus_head_pr', 'locking_range', 19),

('def_castel_leg_mk2', 'speed_max', 3.222),
('def_castel_head_mk2', 'locking_range', 18),
('def_castel_chassis_mk2', 'powergrid_max', 154),
('def_yagel_leg_mk2', 'speed_max', 3.527),
('def_yagel_head_mk2', 'locking_range', 17),
('def_yagel_chassis_mk2', 'powergrid_max', 170),
('def_prometheus_leg_mk2', 'speed_max', 3.222),
('def_prometheus_head_mk2', 'locking_range', 19);

PRINT N'UPDATE CHASSIS MASS';
MERGE [dbo].[entitydefaults] e USING #CHASSIS_DEFS c
ON e.definitionname = c.defName
WHEN MATCHED
    THEN UPDATE SET
		mass=c.chassisMass;

PRINT N'UPDATE AGG VALUES';
MERGE [dbo].[aggregatevalues] a USING #AGG_VALS v
ON a.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=v.defName) AND
a.field = (SELECT TOP 1 id FROM aggregatefields WHERE name=v.fieldName)
WHEN MATCHED
    THEN UPDATE SET
		value=v.fieldValue;



DROP TABLE IF EXISTS #AGG_VALS;
DROP TABLE IF EXISTS #CHASSIS_DEFS;
PRINT N'UPDATED LIGHT BOT STATS';
GO