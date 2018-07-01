USE [perpetuumsa]
GO
-------------------Live Patch 1------------------

------------Loot tweaks to L3-4 syndicates----------

DECLARE @definitionID int;
DECLARE @lootdefinitionID int;
DECLARE @npclootID int;

PRINT N'def_npc_locust_firstmate_rank4 LOOT';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank4' ORDER BY definition DESC);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_exp_armor_hardener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_small_lasercrystal_d' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=20, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_damage_mod_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=50, [probability]=0.5, [repackaged]=0, [dontdamage]=1, [minquantity]=40 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_thelodica_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5, [probability]=0, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_1' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_2' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_thelodica_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=45, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=37 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=48, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=32 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_thelodica' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=24, [probability]=0, [repackaged]=0, [dontdamage]=1, [minquantity]=16 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=315, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=210 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_small_projectile_a' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=50, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=25 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_autocannon' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.15, [repackaged]=0, [dontdamage]=0, [minquantity]=0 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=48, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=12 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_autocannon' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_sensor_dampener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_eccm' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_small_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_small_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_sensor_booster' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_sensor_booster' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_eccm' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_eccm' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_3' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_4' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_5' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_6' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_7' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_advanced' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=50, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=40 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_expert' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=50, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=10 WHERE [id]=@npclootID;




PRINT N'def_npc_locust_firstmate_rank3 LOOT';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank3' ORDER BY definition DESC);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_exp_armor_hardener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_small_lasercrystal_d' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=20, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_damage_mod_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5, [probability]=0.5, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_thelodica_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5, [probability]=0, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_1' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_2' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_thelodica_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=45, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=37 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=48, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=32 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_thelodica' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=24, [probability]=0, [repackaged]=0, [dontdamage]=1, [minquantity]=16 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=152, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=100 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_small_projectile_a' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=45, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=20 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_autocannon' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.15, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=35, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=12 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_eccm' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_sensor_booster' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_sensor_booster' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_autocannon' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

GO
----------------------------------------------


DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;

------------Hershfield Observer Modifier adjustments-----------
PRINT N'def_npc_roaming_baphomet_alpha';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_roaming_baphomet_alpha' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_npc_roaming_baphomet_alpha', quantity=1, attributeflags=1024, categoryflags=911, options='', 
                note='', enabled=1, volume=0, mass=0, hidden='True', health=100, descriptiontoken='def_npc_roaming_baphomet_alpha_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'aggrorange_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'falloff_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'optimal_range_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'stealth_strength_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, -50);



PRINT N'def_npc_roaming_arbalest_alpha';

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_roaming_arbalest_alpha' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_npc_roaming_arbalest_alpha', quantity=1, attributeflags=1024, categoryflags=1167, options='', 
                note='', enabled=1, volume=0, mass=0, hidden='True', health=100, descriptiontoken='def_npc_roaming_arbalest_alpha_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'aggrorange_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'falloff_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'optimal_range_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'stealth_strength_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, -50);


PRINT N'def_npc_roaming_waspish_alpha';

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_roaming_waspish_alpha' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_npc_roaming_waspish_alpha', quantity=1, attributeflags=1024, categoryflags=1423, options='', 
                note='', enabled=1, volume=0, mass=0, hidden='True', health=100, descriptiontoken='def_npc_roaming_waspish_alpha_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'aggrorange_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'falloff_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'optimal_range_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'stealth_strength_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, -50);

GO




----------------------------------------



---------NEW PRESENCES------------
PRINT N'INSERT presences for NV peli drones and L1 nian npcs';

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('tma_Pelistaldrones',7,7,2040,2040,'tm npc set',1,1,0,0,0,0,0
			    ,0,0,0,0,1,1);


INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
				,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
				VALUES ('tma_factional_spawns',7,7,2040,2040,'tm npc set',1,1,0,0,0,0,0
				,0,0,0,0,1,1);
GO


----------NV nian faction flock inserts------------
PRINT N'INSERT flocks into presence: tma_factional_spawns';

DECLARE @presenceID int
DECLARE @flockID int;
DECLARE @definitionID int;
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'tma_factional_spawns' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'tma_factional_spawns',[topx] = 7,[topy] = 7,[bottomx] = 2040,[bottomy] = 2040,[note] = 'tm npc set',[spawnid] = 1,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_prometheus_scout_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Theo Scout At Terminal' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Theo Scout At Terminal', @presenceID, 2, @definitionID, 484, 1595, 2, 5, 60, 0, 20, 'Theo Fact TMA', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_prometheus_scout_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Theo Scout At Terminal2' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Theo Scout At Terminal2', @presenceID, 1, @definitionID, 433, 1704, 2, 5, 60, 0, 20, 'Theo Fact TMA2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_baphomet_scout_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Theo Scout At Terminal2' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Theo Scout At Terminal2', @presenceID, 1, @definitionID, 433, 1704, 2, 5, 60, 0, 20, 'Theo Fact TMA2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_baphomet_scout_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Theo Scout AT Terminal3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Theo Scout AT Terminal3', @presenceID, 2, @definitionID, 182, 1679, 2, 5, 60, 0, 20, 'Theo Fact TMA3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_intakt_ewjammer_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Theo Scout At Terminal3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Theo Scout At Terminal3', @presenceID, 1, @definitionID, 182, 1679, 2, 5, 60, 0, 20, 'Theo Fact TMA3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_scout_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Num Scout at Terminal' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Num Scout at Terminal', @presenceID, 2, @definitionID, 565, 541, 2, 5, 60, 0, 20, 'Num Fact TMA', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_scout_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Num Scout At Terminal2' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Num Scout At Terminal2', @presenceID, 1, @definitionID, 425, 370, 2, 5, 60, 0, 20, 'Num Fact TMA2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_scout_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Num Scout At Terminal2' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Num Scout At Terminal2', @presenceID, 1, @definitionID, 425, 370, 2, 5, 60, 0, 20, 'Num Fact TMA2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_scout_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Num Scout At Terminal3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Num Scout At Terminal3', @presenceID, 2, @definitionID, 443, 181, 2, 5, 60, 0, 20, 'Num Fact TMA3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_cameleon_ewjammer_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Num Scout At Terminal' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Num Scout At Terminal', @presenceID, 1, @definitionID, 443, 181, 2, 5, 60, 0, 20, 'Num Fact TMA3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_castel_scout_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Pel Scout At Terminal' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Pel Scout At Terminal', @presenceID, 2, @definitionID, 1299, 1440, 2, 5, 60, 0, 20, 'Pel Fact TMA', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_castel_scout_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Pel Scout At Terminal2' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Pel Scout At Terminal2', @presenceID, 1, @definitionID, 1288, 1561, 2, 5, 60, 0, 20, 'Pel Fact TMA2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_waspish_scout_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Pel Scout At Terminal2' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Pel Scout At Terminal2', @presenceID, 1, @definitionID, 1288, 1561, 2, 5, 60, 0, 20, 'Pel Fact TMA2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_waspish_scout_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Pel Scout At Terminal3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Pel Scout At Terminal3', @presenceID, 2, @definitionID, 1356, 1697, 2, 5, 60, 0, 20, 'Pel Fact TMA3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_troiar_ewjammer_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Pel Scout At Terminal3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Pel Scout At Terminal3', @presenceID, 1, @definitionID, 1356, 1697, 2, 5, 60, 0, 20, 'Pel Fact TMA3', 1, 1, 1, 1); 


----------Adding Pelistal drone flocks for Combat Training---------
PRINT N'INSERT flocks into presence: tma_Pelistaldrones';
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'tma_Pelistaldrones' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'tma_Pelistaldrones',[topx] = 7,[topy] = 7,[bottomx] = 2040,[bottomy] = 2040,[note] = 'tm npc set',[spawnid] = 1,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_dummy_decoy_tm' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Arkhe_TM' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Arkhe_TM', @presenceID, 1, @definitionID, 1071, 1012, 2, 5, 60, 0, 20, 'TM Drones', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_dummy_decoy_tm' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Arkhe_TM2' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Arkhe_TM2', @presenceID, 1, @definitionID, 1071, 1012, 2, 5, 60, 0, 20, 'TM Drones2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_dummy_decoy_tm' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Arkhe_TM3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Arkhe_TM3', @presenceID, 1, @definitionID, 1071, 1012, 2, 5, 60, 0, 20, 'TM  Drone3', 1, 1, 1, 1); 

GO


-----------------------------------------------

PRINT N'Smite compact token price fix';

UPDATE itemshop 
SET tmcoin=600
WHERE targetdefinition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_missile_rewa');

GO



----------------------BALANCING------------------
-------------------------------------------------

PRINT N'THELO BONUS ADJ: OPTIMAL 1->2%, LASER-ACCU -2%->-3%';

DECLARE @definitionID int;
DECLARE @extensionID int;
DECLARE @aggfieldID int;
DECLARE @chassisbonusID int;


-----------THELO BONUS ADJ: OPTIMAL 1->2%, LASER-ACCU -2%->-3%------

PRINT N'def_prometheus_chassis';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_laser_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.03 WHERE id = @chassisbonusID;


PRINT N'def_baphomet_head';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_baphomet_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'laser_optimal_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.02 WHERE id = @chassisbonusID;


PRINT N'def_baphomet_chassis';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_baphomet_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_laser_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.03 WHERE id = @chassisbonusID;


PRINT N'def_artemis_head';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'laser_optimal_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.02 WHERE id = @chassisbonusID;


PRINT N'def_artemis_chassis';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_laser_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.03 WHERE id = @chassisbonusID;


PRINT N'def_seth_head';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_seth_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'laser_optimal_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.02 WHERE id = @chassisbonusID;


PRINT N'def_seth_chassis';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_seth_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_laser_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.03 WHERE id = @chassisbonusID;



-------------PROTOTYPES--------------------

PRINT N'def_prometheus_chassis';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_chassis_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_laser_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.03 WHERE id = @chassisbonusID;


PRINT N'def_baphomet_head_pr';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_baphomet_head_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'laser_optimal_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.02 WHERE id = @chassisbonusID;


PRINT N'def_baphomet_chassis_pr';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_baphomet_chassis_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_laser_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.03 WHERE id = @chassisbonusID;


PRINT N'def_artemis_head_pr';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_head_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'laser_optimal_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.02 WHERE id = @chassisbonusID;


PRINT N'def_artemis_chassis_pr';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_chassis_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_laser_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.03 WHERE id = @chassisbonusID;


PRINT N'def_seth_head_pr';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_seth_head_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'laser_optimal_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.02 WHERE id = @chassisbonusID;


PRINT N'def_seth_chassis_pr';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_seth_chassis_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_laser_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.03 WHERE id = @chassisbonusID;

GO



--------------Syndicate Combat masking buff mech/Hmech only--------------

PRINT N'Syndicate Combat masking buff mech/Hmech only';

DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;

PRINT N'def_legatus_head';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_legatus_head' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_legatus_head', quantity=1, attributeflags=1024, categoryflags=262480, options='#height=f0.2#slotFlags=48,8,8,8,8', 
                note='', enabled=1, volume=3, mass=1000, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'stealth_strength' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=100 WHERE id =  @aggvalueID;



PRINT N'def_echelon_head';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_echelon_head' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_echelon_head', quantity=1, attributeflags=1024, categoryflags=196944, options='#height=f0.01#slotFlags=48,8,8,8,8', 
                note='', enabled=1, volume=3, mass=700, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'stealth_strength' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=110 WHERE id =  @aggvalueID;


-----------Keep masking same for lights/assaults/ewar--------------

GO





---------------------------------------------------------------------------
-----Syndicate Speed Increase to -5% baseline (light->ew mech only)-------

PRINT N'Syndicate Speed Increase to -5% baseline (light->ew mech only)';

DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;


PRINT N'def_vektor_leg';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vektor_leg' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_vektor_leg', quantity=1, attributeflags=1024, categoryflags=66384, options='#height=f0.35#slotFlags=420,20,20', 
                note='', enabled=1, volume=3, mass=1700, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2.97 WHERE id =  @aggvalueID;


PRINT N'def_helix_leg';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_helix_leg' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_helix_leg', quantity=1, attributeflags=1024, categoryflags=66384, options='#height=f0.5#slotFlags=420,20,20', 
                note='', enabled=1, volume=5, mass=800, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=3.319 WHERE id =  @aggvalueID;



PRINT N'def_locust_leg';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_locust_leg' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_locust_leg', quantity=1, attributeflags=1024, categoryflags=131920, options='#height=f0.5#slotFlags=420,20,20,20', 
                note='', enabled=1, volume=7, mass=2700, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2.903 WHERE id =  @aggvalueID;



PRINT N'def_callisto_leg';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_callisto_leg' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_callisto_leg', quantity=1, attributeflags=1024, categoryflags=197456, options='#height=f1#slotFlags=420,20,20,20,20', 
                note='', enabled=1, volume=6, mass=2400, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2.556 WHERE id =  @aggvalueID;

---Mech/Hmech reamin at current speed (-10% baseline)--


GO



-----------------------------------------------------

----------Shield cycle time adjust to match missiles------

PRINT N'Shield cycle time adjust to match missiles';

DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;


--T0 small
PRINT N'def_artifact_damaged_small_shield_generator';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_damaged_small_shield_generator' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cycle_time' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=3000 WHERE id =  @aggvalueID;


--t1 small
PRINT N'def_standard_small_shield_generator';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_shield_generator' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2750 WHERE id =  @aggvalueID;


--t2 small
PRINT N'def_named1_small_shield_generator';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_shield_generator' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2500 WHERE id =  @aggvalueID;


--t2p small
PRINT N'def_named1_small_shield_generator';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_shield_generator_pr' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2500 WHERE id =  @aggvalueID;


-- T3- small
PRINT N'def_artifact_a_small_shield_generator';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_small_shield_generator' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2375 WHERE id =  @aggvalueID;


--t3 small
PRINT N'def_named1_small_shield_generator';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_small_shield_generator' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2250 WHERE id =  @aggvalueID;


--t3p small
PRINT N'def_named1_small_shield_generator';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_small_shield_generator_pr' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2250 WHERE id =  @aggvalueID;


--t4 small
PRINT N'def_named1_small_shield_generator';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_small_shield_generator' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2000 WHERE id =  @aggvalueID;


--t4p small
PRINT N'def_named1_small_shield_generator';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_small_shield_generator_pr' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2000 WHERE id =  @aggvalueID;



---Mediums

--t0

PRINT N'def_artifact_damaged_medium_shield_generator';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_damaged_medium_shield_generator' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12000 WHERE id =  @aggvalueID;



--t1
PRINT N'def_standard_medium_shield_generator';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_shield_generator' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=10000 WHERE id =  @aggvalueID;


--t2
PRINT N'def_named1_medium_shield_generator';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_shield_generator' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=9500 WHERE id =  @aggvalueID;


--t2p
PRINT N'def_named1_medium_shield_generator_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_shield_generator_pr' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=9500 WHERE id =  @aggvalueID;


-- t3-
PRINT N'def_artifact_a_medium_shield_generator';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_medium_shield_generator' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=8500 WHERE id =  @aggvalueID;

--t3
PRINT N'def_named2_medium_shield_generator';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_shield_generator' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=7750 WHERE id =  @aggvalueID;

--t3p
PRINT N'def_named2_medium_shield_generator_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_shield_generator_pr' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=7750 WHERE id =  @aggvalueID;


--t4
PRINT N'def_named3_medium_shield_generator';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_shield_generator' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=6500 WHERE id =  @aggvalueID;


--t4p
PRINT N'def_named3_medium_shield_generator_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_shield_generator_pr' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=6500 WHERE id =  @aggvalueID;


GO


-------------------------------------------------------------------------
----------Revert Reactor Sealant changes-----------
PRINT N'REACTOR SEALANTS REVERT TO PERP 3.8.3';


DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;

PRINT N'def_standard_reactor_sealing';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_reactor_sealing' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'reactor_radiation_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.75 WHERE id =  @aggvalueID;


PRINT N'def_named1_reactor_sealing';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_reactor_sealing' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'reactor_radiation_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.75 WHERE id =  @aggvalueID;


PRINT N'def_named2_reactor_sealing';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_reactor_sealing' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'reactor_radiation_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.7 WHERE id =  @aggvalueID;


PRINT N'def_named3_reactor_sealing';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_reactor_sealing' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'reactor_radiation_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.65 WHERE id =  @aggvalueID;



----PROTOTYPES---
PRINT N'def_named1_reactor_sealing_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_reactor_sealing_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'reactor_radiation_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.75 WHERE id =  @aggvalueID;


PRINT N'def_named2_reactor_sealing_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_reactor_sealing_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'reactor_radiation_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.7 WHERE id =  @aggvalueID;


PRINT N'def_named3_reactor_sealing_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_reactor_sealing_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'reactor_radiation_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.65 WHERE id =  @aggvalueID;

GO


------------------------------------------------------

------------Nuimqol: remove crit--------

PRINT N'Nuimqol: remove crit';
DECLARE @definitionID int;
DECLARE @extensionID int;
DECLARE @aggfieldID int;
DECLARE @chassisbonusID int;


PRINT N'def_mesmer_chassis';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

PRINT N'def_mesmer_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_chassis_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;




PRINT N'def_kain_chassis';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

PRINT N'def_kain_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_chassis_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;




PRINT N'def_arbalest_chassis_';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_arbalest_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

PRINT N'def_arbalest_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_arbalest_chassis_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;





PRINT N'def_yagel_chassis';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_yagel_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;


PRINT N'def_yagel_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_yagel_chassis_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;


GO



----------------------------------------------

------------Nuimqol Armor repair 7%->5%-----------
PRINT N'-Nuimqol Armor repair 7%->5%';
DECLARE @definitionID int;
DECLARE @extensionID int;
DECLARE @aggfieldID int;
DECLARE @chassisbonusID int;

PRINT N'def_yagel_leg';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_nuimqol_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_yagel_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);
UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;

PRINT N'def_yagel_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_yagel_leg_pr' ORDER BY definition DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);
UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;


PRINT N'def_cameleon_leg';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_leg' ORDER BY definition DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);
UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;

PRINT N'def_cameleon_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_leg_pr' ORDER BY definition DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);
UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;


PRINT N'def_arbalest_leg';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_arbalest_leg' ORDER BY definition DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);
UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;

PRINT N'def_arbalest_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_arbalest_leg_pr' ORDER BY definition DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);
UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;


PRINT N'def_kain_leg';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_leg' ORDER BY definition DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);
UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;

PRINT N'def_kain_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_leg_pr' ORDER BY definition DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);
UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;


PRINT N'def_vagabond_leg';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vagabond_leg' ORDER BY definition DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);
UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;

PRINT N'def_vagabond_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vagabond_leg_pr' ORDER BY definition DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);
UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;


PRINT N'def_mesmer_leg';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_leg' ORDER BY definition DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);
UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;

PRINT N'def_mesmer_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_leg_pr' ORDER BY definition DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);
UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;

GO



--------------------------------------------

--------Reduce HitDispersion Mech bonus; add explosion-size bonus-------


PRINT N'Reduce HitDispersion Mech bonus; add explosion-size bonus';
DECLARE @definitionID int;
DECLARE @extensionID int;
DECLARE @aggfieldID int;
DECLARE @chassisbonusID int;


PRINT N'def_legatus_head';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_legatus_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'accuracy_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.01 WHERE id = @chassisbonusID;



PRINT N'def_echelon_head';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_echelon_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'accuracy_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.02 WHERE id = @chassisbonusID;




PRINT N'def_locust_head';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_locust_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'accuracy_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.01 WHERE id = @chassisbonusID;




PRINT N'def_kain_head';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'accuracy_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.01 WHERE id = @chassisbonusID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'explosion_radius_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, -0.01, '', @aggfieldID, 0);


PRINT N'def_kain_head_pr';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_head_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'accuracy_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.01 WHERE id = @chassisbonusID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'explosion_radius_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, -0.01, '', @aggfieldID, 0);




PRINT N'def_tyrannos_head';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_tyrannos_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'accuracy_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.01 WHERE id = @chassisbonusID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'explosion_radius_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, -0.01, '', @aggfieldID, 0);


PRINT N'def_tyrannos_head_pr';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_tyrannos_head_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'accuracy_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.01 WHERE id = @chassisbonusID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'explosion_radius_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, -0.01, '', @aggfieldID, 0);



PRINT N'def_artemis_head';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'accuracy_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.01 WHERE id = @chassisbonusID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'explosion_radius_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, -0.01, '', @aggfieldID, 0);



PRINT N'def_artemis_head_pr';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_head_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'accuracy_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.01 WHERE id = @chassisbonusID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'explosion_radius_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, -0.01, '', @aggfieldID, 0);


GO




---------------------------------------

------INDY MK1 BOT STAT: +1 TARGET--------
PRINT N'INDY MK1 BOT STAT: +1 TARGET';
DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
PRINT N'def_symbiont_head_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_symbiont_head_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locked_targets_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=5 WHERE id =  @aggvalueID;


PRINT N'def_riveler_head_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_riveler_head_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locked_targets_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=5 WHERE id =  @aggvalueID;



PRINT N'def_gargoyle_head_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_gargoyle_head_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locked_targets_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4 WHERE id =  @aggvalueID;



PRINT N'def_termis_head_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_termis_head_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locked_targets_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4 WHERE id =  @aggvalueID;



PRINT N'def_laird_head_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_laird_head_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locked_targets_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=3 WHERE id =  @aggvalueID;


PRINT N'def_argano_head_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_argano_head_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locked_targets_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=3 WHERE id =  @aggvalueID;


PRINT N'def_symbiont_head';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_symbiont_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locked_targets_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=5 WHERE id =  @aggvalueID;



PRINT N'def_riveler_head';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_riveler_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locked_targets_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=5 WHERE id =  @aggvalueID;



PRINT N'def_gargoyle_head';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_gargoyle_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locked_targets_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4 WHERE id =  @aggvalueID;


PRINT N'def_termis_head';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_termis_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locked_targets_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4 WHERE id =  @aggvalueID;



PRINT N'def_laird_head';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_laird_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locked_targets_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=3 WHERE id =  @aggvalueID;


PRINT N'def_argano_head';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_argano_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locked_targets_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=3 WHERE id =  @aggvalueID;

GO




----------------------------------------------------


-----------Firearm dispersion increase----------
------smalls 5.5->6
------med 14.5->17
------med 15->18

PRINT N'Firearm dispersion increase';
DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;

PRINT N'def_standard_small_autocannon';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_autocannon' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=6 WHERE id =  @aggvalueID;

PRINT N'def_standard_medium_autocannon';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_autocannon' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=17 WHERE id =  @aggvalueID;

PRINT N'def_named1_small_autocannon';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_autocannon' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=6 WHERE id =  @aggvalueID;

PRINT N'def_named2_small_autocannon';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_small_autocannon' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=6 WHERE id =  @aggvalueID;

PRINT N'def_named3_small_autocannon';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_small_autocannon' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=6 WHERE id =  @aggvalueID;

PRINT N'def_named1_medium_autocannon';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_autocannon' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=17 WHERE id =  @aggvalueID;

PRINT N'def_named2_medium_autocannon';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_autocannon' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=17 WHERE id =  @aggvalueID;

PRINT N'def_named3_medium_autocannon';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_autocannon' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=17 WHERE id =  @aggvalueID;

PRINT N'def_longrange_standard_medium_autocannon';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_longrange_standard_medium_autocannon' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=18 WHERE id =  @aggvalueID;

PRINT N'def_named1_longrange_medium_autocannon';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_longrange_medium_autocannon' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=18 WHERE id =  @aggvalueID;

PRINT N'def_named2_longrange_medium_autocannon';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_longrange_medium_autocannon' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=18 WHERE id =  @aggvalueID;

PRINT N'def_named3_longrange_medium_autocannon';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_longrange_medium_autocannon' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=18 WHERE id =  @aggvalueID;

PRINT N'PROTOTYPES';


PRINT N'def_named1_small_autocannon_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_autocannon_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=6 WHERE id =  @aggvalueID;

PRINT N'def_named2_small_autocannon_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_small_autocannon_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=6 WHERE id =  @aggvalueID;

PRINT N'def_named3_small_autocannon_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_small_autocannon_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=6 WHERE id =  @aggvalueID;

PRINT N'def_named1_medium_autocannon_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_autocannon_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=17 WHERE id =  @aggvalueID;

PRINT N'def_named2_medium_autocannon_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_autocannon_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=17 WHERE id =  @aggvalueID;

PRINT N'def_named3_medium_autocannon_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_autocannon_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=17 WHERE id =  @aggvalueID;

PRINT N'def_named1_longrange_medium_autocannon_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_longrange_medium_autocannon_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=18 WHERE id =  @aggvalueID;

PRINT N'def_named2_longrange_medium_autocannon_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_longrange_medium_autocannon_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=18 WHERE id =  @aggvalueID;

PRINT N'def_named3_longrange_medium_autocannon_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_longrange_medium_autocannon_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=18 WHERE id =  @aggvalueID;


GO




-----------------------------------------------

-----------REVERT ERP CHANGES----------
PRINT N'REVERT ERP TO PERP 3.8.3';


DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;


---------KINETIC-ERP----------

PRINT N'def_standard_kinetic_kers';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_kinetic_kers' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'kinetic_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.5 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'thermal_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosive_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.1 WHERE id =  @aggvalueID;



PRINT N'def_named1_kinetic_kers';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_kinetic_kers' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'kinetic_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.5 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'thermal_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosive_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.1 WHERE id =  @aggvalueID;



PRINT N'def_named2_kinetic_kers';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_kinetic_kers' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'kinetic_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.60 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'thermal_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.125 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosive_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.125 WHERE id =  @aggvalueID;



PRINT N'def_named3_kinetic_kers';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_kinetic_kers' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'kinetic_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.7 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'thermal_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.15 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosive_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.15 WHERE id =  @aggvalueID;



---PROTOTYPES--kinectic

PRINT N'def_named1_kinetic_kers_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_kinetic_kers_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'kinetic_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.5 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'thermal_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosive_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.1 WHERE id =  @aggvalueID;



PRINT N'def_named2_kinetic_kers_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_kinetic_kers_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'kinetic_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.60 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'thermal_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.125 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosive_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.125 WHERE id =  @aggvalueID;



PRINT N'def_named3_kinetic_kers_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_kinetic_kers_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'kinetic_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.7 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'thermal_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.15 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosive_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.15 WHERE id =  @aggvalueID;




-------------THERMAL-ERP---------------

PRINT N'def_standard_thermal_kers';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_thermal_kers' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'kinetic_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'thermal_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.5 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosive_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.1 WHERE id =  @aggvalueID;



PRINT N'def_named1_thermal_kers';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_thermal_kers' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'kinetic_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'thermal_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.5 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosive_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.1 WHERE id =  @aggvalueID;



PRINT N'def_named2_thermal_kers';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_thermal_kers' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'kinetic_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.125 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'thermal_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.6 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosive_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.125 WHERE id =  @aggvalueID;



PRINT N'def_named3_thermal_kers';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_thermal_kers' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'kinetic_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.15 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'thermal_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.7 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosive_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.15 WHERE id =  @aggvalueID;



----------PROTOTYPES--thermal------

PRINT N'def_named1_thermal_kers_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_thermal_kers_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'kinetic_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'thermal_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.5 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosive_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.1 WHERE id =  @aggvalueID;



PRINT N'def_named2_thermal_kers_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_thermal_kers_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'kinetic_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.125 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'thermal_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.6 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosive_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.125 WHERE id =  @aggvalueID;



PRINT N'def_named3_thermal_kers_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_thermal_kers_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'kinetic_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.15 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'thermal_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.7 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosive_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.15 WHERE id =  @aggvalueID;



-------------EXPLOSIVE -ERP-----------


PRINT N'def_standard_explosive_kers';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_explosive_kers' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'kinetic_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'thermal_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosive_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.5 WHERE id =  @aggvalueID;



PRINT N'def_named1_explosive_kers';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_explosive_kers' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'kinetic_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'thermal_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosive_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.5 WHERE id =  @aggvalueID;



PRINT N'def_named2_explosive_kers';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_explosive_kers' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'kinetic_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.125 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'thermal_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.125 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosive_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.6 WHERE id =  @aggvalueID;


PRINT N'def_named3_explosive_kers';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_explosive_kers' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'kinetic_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.15 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'thermal_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.15 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosive_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.7 WHERE id =  @aggvalueID;



----------PROTOTYPES---explosive------



PRINT N'def_named1_explosive_kers_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_explosive_kers_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'kinetic_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'thermal_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosive_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.5 WHERE id =  @aggvalueID;



PRINT N'def_named2_explosive_kers_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_explosive_kers_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'kinetic_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.125 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'thermal_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.125 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosive_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.6 WHERE id =  @aggvalueID;


PRINT N'def_named3_explosive_kers_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_explosive_kers_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'kinetic_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.15 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'thermal_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.15 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosive_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.7 WHERE id =  @aggvalueID;


GO