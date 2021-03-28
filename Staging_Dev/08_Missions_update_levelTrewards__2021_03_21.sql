USE [perpetuumsa]
GO

-----------------------------------------------
-- Update Level T assignments nic rewards
-- Date modified: 2021/03/21
-----------------------------------------------

DROP TABLE IF EXISTS #REWARDS;
CREATE TABLE #REWARDS (
	name VARCHAR(128),
	reward FLOAT
);
INSERT INTO #REWARDS (name, reward) VALUES
('mission_asi_gen_tutorial_exp3_01',18750),
('mission_ics_gen_tutorial_exp3_01',18750),
('mission_tm_gen_tutorial_exp3_01',18750),
('mission_asi_gen_tutorial_exp3_02',22500),
('mission_ics_gen_tutorial_exp3_02',22500),
('mission_tm_gen_tutorial_exp3_02',22500),
('mission_asi_gen_tutorial_exp3_03',27500),
('mission_ics_gen_tutorial_exp3_03',27500),
('mission_tm_gen_tutorial_exp3_03',27500),
('mission_asi_i_tutorial_exp3_01',31250),
('mission_ics_i_tutorial_exp3_01',31250),
('mission_tm_i_tutorial_exp3_01',31250),
('mission_asi_gen_tutorial_exp3_04',33750),
('mission_ics_gen_tutorial_exp3_04',33750),
('mission_tm_gen_tutorial_exp3_04',33750),
('mission_asi_w_tutorial_exp3_01',37500),
('mission_ics_w_tutorial_exp3_01',37500),
('mission_tm_w_tutorial_exp3_01',37500),
('mission_asi_gen_tutorial_exp3_05',43750),
('mission_asi_i_tutorial_exp3_02',43750),
('mission_ics_gen_tutorial_exp3_05',43750),
('mission_ics_i_tutorial_exp3_02',43750),
('mission_tm_gen_tutorial_exp3_05',43750),
('mission_tm_i_tutorial_exp3_02',43750),
('mission_asi_w_tutorial_exp3_02',53125),
('mission_ics_w_tutorial_exp3_02',53125),
('mission_tm_w_tutorial_exp3_02',53125),
('mission_asi_i_tutorial_exp3_03',56250),
('mission_ics_i_tutorial_exp3_03',56250),
('mission_tm_i_tutorial_exp3_03',56250),
('mission_asi_w_tutorial_exp3_03',68750),
('mission_ics_w_tutorial_exp3_03',68750),
('mission_tm_w_tutorial_exp3_03',68750),
('mission_asi_i_tutorial_exp3_04',75000),
('mission_ics_i_tutorial_exp3_04',75000),
('mission_tm_i_tutorial_exp3_04',75000),
('mission_asi_w_tutorial_exp3_04',81250),
('mission_ics_w_tutorial_exp3_04',81250),
('mission_tm_w_tutorial_exp3_04',81250),
('mission_asi_i_tutorial_exp3_05',87500),
('mission_ics_i_tutorial_exp3_05',87500),
('mission_tm_i_tutorial_exp3_05',87500),
('mission_asi_w_tutorial_exp3_05',93750),
('mission_ics_w_tutorial_exp3_05',93750),
('mission_tm_w_tutorial_exp3_05',93750),
('mission_asi_w_tutorial_exp3_06',112500),
('mission_ics_w_tutorial_exp3_06',112500),
('mission_tm_w_tutorial_exp3_06',112500);

PRINT N'UPDATE LEVEL T MISSION REWARDS';
MERGE [dbo].[missions] m USING #REWARDS r
ON m.name = r.name
WHEN MATCHED
    THEN UPDATE SET
		rewardfee=r.reward;

PRINT N'DONE UPDATING LEVEL T MISSION REWARDS';
DROP TABLE IF EXISTS #REWARDS;
GO