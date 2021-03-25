USE [perpetuumsa]
GO
------------------------------------
-- Mission reward tweak, again
--
-- Date modified: 2021/03/24
------------------------------------

DROP TABLE IF EXISTS #REWARDS;
CREATE TABLE #REWARDS(
	name varchar(100),
	reward int
);
INSERT INTO #REWARDS(name, reward) VALUES
('loot_item',55),
('kill_definition',55),
('scan_mineral',175),--was 200
('drill_mineral',4200),
('submit_item',220),
('use_switch',55),
('find_artifact',175),--was 200
('use_itemsupply',275),
('massproduce',550),
('research',550),
('harvest_plant',1100),
('pop_npc',15),
('lock_unit',55);

PRINT N'MERGE missiontargettypes';
MERGE missiontargettypes t USING #REWARDS r
ON t.name=r.name
WHEN MATCHED
    THEN UPDATE SET
		t.reward=r.reward;


DROP TABLE IF EXISTS #REWARDS;
GO