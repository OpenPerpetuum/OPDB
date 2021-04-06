USE [perpetuumsa]
GO
--------------------------------------
-- Mineral field numbers
--
-- Date Modified: 2021/03/24
--------------------------------------

DROP TABLE IF EXISTS #MINS;
CREATE TABLE #MINS(
	zoneName varchar(100),
	material int,
	numfields int
);
INSERT INTO #MINS(zoneName, material, numfields) VALUES
('zone_TM', 1, 7),
('zone_TM', 2, 7),
('zone_TM', 5, 7),
('zone_TM_pve', 1, 7),
('zone_TM_pve', 2, 7),
('zone_TM_pve', 3, 7),
('zone_TM_pve', 4, 7),
('zone_TM_pve', 5, 7),
('zone_TM_pve', 12, 7),
('zone_ICS_A_real', 1, 8),
('zone_ICS_A_real', 2, 8),
('zone_ICS_A_real', 3, 8),
('zone_ICS_A_real', 4, 8),
('zone_ICS_A_real', 5, 8),
('zone_ICS_A_real', 6, 10),
('zone_ICS_A_real', 16, 4),
('zone_ASI_A_real', 1, 8),
('zone_ASI_A_real', 2, 8),
('zone_ASI_A_real', 3, 8),
('zone_ASI_A_real', 5, 8),
('zone_ASI_A_real', 12, 8),
('zone_ASI_A_real', 6, 10),
('zone_ASI_A_real', 16, 4),
('zone_TM_A_real', 1, 8),
('zone_TM_A_real', 2, 8),
('zone_TM_A_real', 4, 8),
('zone_TM_A_real', 5, 8),
('zone_TM_A_real', 12, 8),
('zone_TM_A_real', 6, 10),
('zone_TM_A_real', 16, 4),
('zone_ICS_pvp', 1, 10),
('zone_ICS_pvp', 2, 10),
('zone_ICS_pvp', 3, 10),
('zone_ICS_pvp', 4, 10),
('zone_ICS_pvp', 5, 10),
('zone_ICS_pvp', 6, 12),
('zone_ICS_pvp', 16, 5),
('zone_ASI_pvp', 1, 10),
('zone_ASI_pvp', 2, 10),
('zone_ASI_pvp', 3, 10),
('zone_ASI_pvp', 5, 10),
('zone_ASI_pvp', 12, 10),
('zone_ASI_pvp', 6, 12),
('zone_ASI_pvp', 16, 5),
('zone_TM_pvp', 1, 10),
('zone_TM_pvp', 2, 10),
('zone_TM_pvp', 4, 10),
('zone_TM_pvp', 5, 10),
('zone_TM_pvp', 12, 10),
('zone_TM_pvp', 6, 12),
('zone_TM_pvp', 16, 5);

PRINT N'MERGE mineralconfigs (51 rows affected)';
MERGE mineralconfigs c USING #MINS m
ON c.materialtype=m.material AND c.zoneid=(SELECT TOP 1 id FROM zones WHERE name=m.zoneName)
WHEN MATCHED
    THEN UPDATE SET
		maxNodes = m.numFields;


DROP TABLE IF EXISTS #REWARDS;
DROP TABLE IF EXISTS #MINS;
GO