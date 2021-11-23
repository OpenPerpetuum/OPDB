USE [perpetuumsa]
GO

----------------------------------------
-- Reduce Sentinel turret armor max
--
-- Date modified: 2021/11/21
----------------------------------------

PRINT N'Reducing armor max mod from 1.05->0.85 on sentinel npc turrets';
DROP TABLE IF EXISTS #TURRETSTAT;
CREATE TABLE #TURRETSTAT(
	npcName VARCHAR(128),
	fieldName VARCHAR(128),
	modifier FLOAT
);
INSERT INTO #TURRETSTAT (npcName, fieldName, modifier) VALUES
('def_npc_pbs_turret_em_rank1', 'armor_max_modifier', 0.85),
('def_npc_pbs_turret_ew_rank1', 'armor_max_modifier', 0.85),
('def_npc_pbs_turret_missile_rank1', 'armor_max_modifier', 0.85),
('def_npc_pbs_turret_laser_rank1', 'armor_max_modifier', 0.85);


MERGE INTO [dbo].[aggregatevalues] v USING #TURRETSTAT s
ON v.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=s.npcName) AND
v.field = (SELECT TOP 1 id FROM aggregatefields WHERE name=s.fieldName)
WHEN MATCHED
    THEN UPDATE SET
		v.value=s.modifier;

PRINT N'Done';
GO