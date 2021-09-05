USE [perpetuumsa]
GO

--------------------------------------------------------
-- Economy updates for P25
-- 
-- Date Modified: 2021/09/05
--------------------------------------------------------

UPDATE missionconstants SET
	value=0.25
WHERE name='ScaleMineralLevelFractionForGangMember';

DROP TABLE IF EXISTS #REWARDS;
CREATE TABLE #REWARDS(
	name varchar(100),
	reward int
);
INSERT INTO #REWARDS(name, reward) VALUES
('loot_item',60),
('kill_definition',60),
('scan_mineral',200),
('drill_mineral',4200),
('submit_item',220),
('use_switch',60),
('find_artifact',200),
('use_itemsupply',275),
('massproduce',550),
('research',550),
('harvest_plant',1100),
('pop_npc',20),
('lock_unit',60);


MERGE missiontargettypes t USING #REWARDS r
ON t.name=r.name
WHEN MATCHED
    THEN UPDATE SET
		t.reward=r.reward;


DROP TABLE IF EXISTS #REWARDS;
GO