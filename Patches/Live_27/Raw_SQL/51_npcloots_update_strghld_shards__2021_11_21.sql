USE [perpetuumsa]
GO

----------------------------------------
-- Update stronghold shard loot drop rate
--
-- Date modified: 2021/11/21
----------------------------------------

PRINT N'Increasing shard loot drop rate on all strongholds';
DROP TABLE IF EXISTS #SHARDLOOT;
CREATE TABLE #SHARDLOOT(
	npcName VARCHAR(128),
	lootName VARCHAR(128),
	minQuant INT,
	maxQuant INT
);
INSERT INTO #SHARDLOOT (npcName, lootName, minQuant, maxQuant) VALUES
('def_npc_sh70_mainboss', 'def_material_boss_z70', 19000, 21000),
('def_npc_sh70_miniboss_a', 'def_material_boss_z70', 110, 190),
('def_npc_sh70_miniboss_b', 'def_material_boss_z70', 110, 190),
('def_npc_Zone71_WilliamHBonnie', 'def_material_boss_z71', 40, 60),
('def_npc_Zone72_One_Eye_Josef', 'def_material_boss_z72', 40, 60);

MERGE INTO [dbo].[npcloot] l USING #SHARDLOOT s
ON l.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=s.npcName) AND
l.lootdefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=s.lootName)
WHEN MATCHED
    THEN UPDATE SET
		l.minquantity=s.minQuant,
		l.quantity=s.maxQuant;

PRINT N'Done';
GO

