--Mission bonuses by type balance
--See Econ Spreadsheet for details
USE [perpetuumsa]
GO


DECLARE @TEMPTARGETREWARDS TABLE
(
  name varchar(50), 
  reward int
)

--rewards by objective
INSERT INTO @TEMPTARGETREWARDS VALUES
('loot_item',50),
('kill_definition',50),
('scan_mineral',250),
('drill_mineral',4100),
('submit_item',200),
('use_switch',50),
('find_artifact',175),
('use_itemsupply',250),
('massproduce',500),
('research',500),
('harvest_plant',1000),
('pop_npc',12),
('lock_unit',50);

UPDATE      t1
SET         reward = t2.reward
FROM        missiontargettypes t1
INNER JOIN  @TEMPTARGETREWARDS t2
ON          t1.name = t2.name;

GO
