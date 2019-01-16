USE [perpetuumsa]
GO

---Mech Observers increase in loot 
--Nic: 870K to 3.25M
--Hitech Kernals 2K to 8K
--Factional Kernals: 7.6K to 10K
--ADD Common Kernals 5k
--ADD Lvl 7 and 8 Decoders 50% drop

---Heavy Observers increase in loot
--Nic: 1.5M to 4.9M
--Hitech Kernals 6K to 10K
--Factional Kernals: 9K to 12K
--ADD Common Kernals 8K
--ADD Lvl 8 and 9 Decoders 50% drop

----Tyrannos Observer Loot Buff

DECLARE @definitionID int;
DECLARE @lootdefinitionID int;
DECLARE @npclootID int;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_roaming_tyrannos_beta' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_webber' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_sensor_dampener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_sensor_jammer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_damage_mod_missile' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_missile_launcher' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_resistant_plating' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_mass_reductor' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_pelistal_expert' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=50, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_pelistal_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=10000, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=8000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=8000, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=6000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_pelistal' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=10000, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=8000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 5000, 1, 1,1, 3000);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_7' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 2, 0.5, 1,1, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_8' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 2, 0.5, 1,1, 1);

---Kain Loot Buff

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_roaming_kain_beta' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_railgun' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_resistant_plating' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_mass_reductor' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_sensor_jammer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_damage_mod_railgun' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_webber' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_nuimqol_expert' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=50, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_nuimqol_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=10000, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=8000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=8000, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=6000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_nuimqol' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=10000, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=8000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 5000, 1, 1,1, 3000);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_7' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 2, 0.5, 1,1, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_8' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 2, 0.5, 1,1, 1);

--Artemis Loot Buff

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_roaming_artemis_beta' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_resistant_plating' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_mass_reductor' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_sensor_dampener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_sensor_jammer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_damage_mod_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_webber' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_thelodica_expert' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=50, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_thelodica_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=10000, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=8000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=8000, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=6000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_thelodica' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=10000, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=8000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_7' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 2, 0.5, 1,1, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_8' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 2, 0.5, 1,1, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 5000, 1, 1,1, 3000);

--Seth Loot Buff

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_roaming_seth_beta' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_tracking_upgrade' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_longrange_medium_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_resistant_plating' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_thelodica_expert' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=50, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_mass_reductor' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_damage_mod_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_sensor_booster' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_thelodica_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=15000, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=10000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=10000, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=8000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_thelodica' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=12000, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=10000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 8000, 1, 1,1, 6000);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_8' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 2, 0.5, 1,1, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_9' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 2, 0.5, 1,1, 1);

--Gropho Loot Buff

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_roaming_gropho_beta' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_tracking_upgrade' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_missile_launcher' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_resistant_plating' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_pelistal_expert' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=50, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_mass_reductor' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_damage_mod_missile' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_sensor_booster' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_pelistal_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=15000, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=10000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=10000, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=8000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_pelistal' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=12000, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=10000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 8000, 1, 1,1, 6000);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_8' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 2, 0.5, 1,1, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_9' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 2, 0.5, 1,1, 1);


--Mesmer Loot Buff

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_roaming_mesmer_beta' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_tracking_upgrade' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_longrange_medium_railgun' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_resistant_plating' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_nuimqol_expert' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=50, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_mass_reductor' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_damage_mod_railgun' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_sensor_booster' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_nuimqol_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=15000, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=10000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=10000, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=8000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_nuimqol' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=12000, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=10000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 8000, 1, 1,1, 6000);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_8' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 2, 0.5, 1,1, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_9' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 2, 0.5, 1,1, 1);


GO