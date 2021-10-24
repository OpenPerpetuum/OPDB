USE [perpetuumsa]
GO
---------------------------------------------
--PATCH 23: just some fixes
--chassis_bonus_missingfix__2021_07_23.sql
--Def_Z70_71_and_72_Loot_update__2021_07_23.sql
---------------------------------------------
PRINT N'P23 START';
GO
PRINT N'chassis_bonus_missingfix__2021_07_23.sql'
USE [perpetuumsa]
GO


-------------------------------------------------------
-- MISSING bonuses bug
-- Patch 22 wiped out a number of bonuses (got past test team)
-- Date Modified: 2021/07/23
-------------------------------------------------------

DROP TABLE IF EXISTS #BONUS;
CREATE TABLE #BONUS(
	defName VARCHAR(100),
	fieldName VARCHAR(100),
	extName VARCHAR(100),
	bonusAmount FLOAT
);
INSERT INTO #BONUS (defName, fieldName, extName, bonusAmount) VALUES
('def_daidalos_chassis','damage_medium_projectile_modifier','ext_heavyarmored_unit_piloting',0.1),
('def_daidalos_chassis','damage_small_projectile_modifier','ext_heavyarmored_unit_piloting',0.1),
('def_daidalos_chassis','armor_max_modifier','ext_syndicate_industry_specialist',0.01),
('def_daidalos_chassis','resist_chemical','ext_indy_role_specialist',3),
('def_daidalos_chassis','resist_explosive','ext_indy_role_specialist',3),
('def_daidalos_chassis','resist_kinetic','ext_indy_role_specialist',3),
('def_daidalos_chassis','resist_thermal','ext_indy_role_specialist',3),

('def_hermes_chassis','damage_medium_projectile_modifier','ext_lightarmored_unit_piloting',0.03),
('def_hermes_chassis','damage_small_projectile_modifier','ext_lightarmored_unit_piloting',0.03),
('def_hermes_chassis','mining_probe_accuracy_modifier','ext_lightarmored_unit_piloting',0.03),
('def_hermes_chassis','mining_probe_artifact_range_modifier','ext_lightarmored_unit_piloting',0.03);

--SELECT * FROM chassisbonus WHERE definition IN 
--	(SELECT definition FROM entitydefaults WHERE definitionname IN 
--		(SELECT DISTINCT defName FROM #BONUS));

PRINT N'DELETE CHASSIS BONUSES TO BE REPLACED (4 rows affected)<-1ST RUN';
DELETE FROM chassisbonus WHERE definition IN 
	(SELECT definition FROM entitydefaults WHERE definitionname IN 
		(SELECT DISTINCT defName FROM #BONUS));

PRINT N'INSERT CHASSIS BONUSES (11 rows affected)';
INSERT INTO chassisbonus (definition, extension, bonus, note, targetpropertyID, effectenhancer)
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defName),
	(SELECT TOP 1 extensionid FROM extensions WHERE extensionname=extName),
	bonusAmount, NULL,
	(SELECT TOP 1 id FROM aggregatefields WHERE name=fieldName),
	0
FROM #BONUS;

DROP TABLE IF EXISTS #BONUS;
GO


GO
PRINT N'Def_Z70_71_and_72_Loot_update__2021_07_23.sql'


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
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=35, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=15 WHERE [id]=@npclootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_Zone72_One_Eye_Josef' ORDER BY definition DESC);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_material_boss_z72' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=35, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=15 WHERE [id]=@npclootID;


PRINT N'DONE UPDATING SHARD LOOT ON ZONE 70-71-72 BOSS LOOTS';
GO


PRINT N'P23 DONE';
GO