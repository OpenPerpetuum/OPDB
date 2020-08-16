USE [perpetuumsa]
GO

--------------------------------------------------------
-- Economy updates for P18
-- Lower number of fields on all islands (was 2x designed numbers)
-- ~10% buff to all mission target categories
-- Date Modified: 2020/08/14
--------------------------------------------------------

DROP TABLE IF EXISTS #REWARDS;
CREATE TABLE #REWARDS(
	name varchar(100),
	reward int
);
INSERT INTO #REWARDS(name, reward) VALUES
('loot_item',55),
('kill_definition',55),
('scan_mineral',200),
('drill_mineral',4200),
('submit_item',220),
('use_switch',55),
('find_artifact',200),
('use_itemsupply',275),
('massproduce',550),
('research',550),
('harvest_plant',1100),
('pop_npc',15),
('lock_unit',55);

MERGE missiontargettypes t USING #REWARDS r
ON t.name=r.name
WHEN MATCHED
    THEN UPDATE SET
		t.reward=r.reward;



DROP TABLE IF EXISTS #MINS;
CREATE TABLE #MINS(
	zoneName varchar(100),
	material int,
	numfields int
);
INSERT INTO #MINS(zoneName, material, numfields) VALUES
('zone_TM', 1, 8),
('zone_TM', 2, 8),
('zone_TM', 5, 8),
('zone_TM_pve', 1, 8),
('zone_TM_pve', 2, 8),
('zone_TM_pve', 3, 8),
('zone_TM_pve', 4, 8),
('zone_TM_pve', 5, 8),
('zone_TM_pve', 12, 8),
('zone_ICS_A_real', 1, 10),
('zone_ICS_A_real', 2, 10),
('zone_ICS_A_real', 3, 10),
('zone_ICS_A_real', 4, 10),
('zone_ICS_A_real', 5, 10),
('zone_ICS_A_real', 6, 15),
('zone_ICS_A_real', 16, 4),
('zone_ASI_A_real', 1, 10),
('zone_ASI_A_real', 2, 10),
('zone_ASI_A_real', 3, 10),
('zone_ASI_A_real', 5, 10),
('zone_ASI_A_real', 12, 10),
('zone_ASI_A_real', 6, 15),
('zone_ASI_A_real', 16, 4),
('zone_TM_A_real', 1, 10),
('zone_TM_A_real', 2, 10),
('zone_TM_A_real', 4, 10),
('zone_TM_A_real', 5, 10),
('zone_TM_A_real', 12, 10),
('zone_TM_A_real', 6, 15),
('zone_TM_A_real', 16, 4),
('zone_ICS_pvp', 1, 12),
('zone_ICS_pvp', 2, 12),
('zone_ICS_pvp', 3, 12),
('zone_ICS_pvp', 4, 12),
('zone_ICS_pvp', 5, 12),
('zone_ICS_pvp', 6, 18),
('zone_ICS_pvp', 16, 5),
('zone_ASI_pvp', 1, 12),
('zone_ASI_pvp', 2, 12),
('zone_ASI_pvp', 3, 12),
('zone_ASI_pvp', 5, 12),
('zone_ASI_pvp', 12, 12),
('zone_ASI_pvp', 6, 18),
('zone_ASI_pvp', 16, 5),
('zone_TM_pvp', 1, 12),
('zone_TM_pvp', 2, 12),
('zone_TM_pvp', 4, 12),
('zone_TM_pvp', 5, 12),
('zone_TM_pvp', 12, 12),
('zone_TM_pvp', 6, 18),
('zone_TM_pvp', 16, 5);

MERGE mineralconfigs c USING #MINS m
ON c.materialtype=m.material AND c.zoneid=(SELECT TOP 1 id FROM zones WHERE name=m.zoneName)
WHEN MATCHED
    THEN UPDATE SET
		maxNodes = m.numFields;



DROP TABLE IF EXISTS #REWARDS;
DROP TABLE IF EXISTS #MINS;
GO