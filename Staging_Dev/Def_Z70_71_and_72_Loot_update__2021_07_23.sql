USE [perpetuumsa]
GO

--------------------------------
-- NPC loots for strongholds update
--
-- Author: @Ville
-- Date modified: 2021/07/23
--------------------------------

PRINT N'UPDATING SHARD LOOT ON ZONE 70-71-72 BOSS LOOTS';
DECLARE @definitionID int;
DECLARE @lootdefinitionID int;
DECLARE @npclootID int;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sh70_mainboss' ORDER BY definition DESC);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_material_boss_z70' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=20000, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=15000 WHERE [id]=@npclootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_Zone71_WilliamHBonnie' ORDER BY definition DESC);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_material_boss_z71' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=30, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=25 WHERE [id]=@npclootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_Zone72_One_Eye_Josef' ORDER BY definition DESC);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_material_boss_z72' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=30, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=25 WHERE [id]=@npclootID;

PRINT N'DONE UPDATING SHARD LOOT ON ZONE 70-71-72 BOSS LOOTS';
GO