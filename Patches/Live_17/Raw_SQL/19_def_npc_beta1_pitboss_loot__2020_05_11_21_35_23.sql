USE [perpetuumsa]
GO
------------------------------------------------------------
--Beta 1 Pitboss loot updates
--Updated quantities and new entries for smooth and higher quantity loot drops
--
--Date modified: 2020/05/15
------------------------------------------------------------

--BETA 1 PITBOSS:LOOT
DROP TABLE IF EXISTS #NPCLOOTS;
CREATE TABLE #NPCLOOTS (
	defName VARCHAR(100) NOT NULL,
	probability float NOT NULL,
	minQuantity int NOT NULL,
	maxQuantity int NOT NULL,
	dontDmg bit NOT NULL,
	repackaged bit NOT NULL,
);

INSERT INTO #NPCLOOTS (defName, probability, minQuantity, maxQuantity, dontDmg, repackaged) VALUES
('def_common_reactor_plasma', 1.0, 80000, 200000, 1, 1),
('def_pelistal_reactor_plasma', 1.0, 80000, 200000, 1, 1),
('def_nuimqol_reactor_plasma', 1.0, 80000, 200000, 1, 1),
('def_thelodica_reactor_plasma', 1.0, 80000, 200000, 1, 1),
('def_kernel_pelistal', 1.0, 75000, 125000, 1, 1),
('def_kernel_thelodica', 1.0, 75000, 125000, 1, 1),
('def_kernel_nuimqol', 1.0, 75000, 125000, 1, 1),
('def_kernel_common', 1.0, 75000, 125000, 1, 1),
('def_kernel_hitech', 1.0, 15000, 25000, 1, 1),
('def_robotshard_common_basic', 1.0, 500, 2000, 1, 1),
('def_robotshard_common_advanced', 1.0, 500, 2000, 1, 1),
('def_robotshard_common_expert', 1.0, 500, 2000, 1, 1),
('def_robotshard_nuimqol_basic', 1.0, 500, 2000, 1, 1),
('def_robotshard_nuimqol_advanced', 1.0, 500, 2000, 1, 1),
('def_robotshard_nuimqol_expert', 1.0, 500, 2000, 1, 1),
('def_robotshard_pelistal_basic', 1.0, 500, 2000, 1, 1),
('def_robotshard_pelistal_advanced', 1.0, 500, 2000, 1, 1),
('def_robotshard_pelistal_expert', 1.0, 500, 2000, 1, 1),
('def_robotshard_thelodica_basic', 1.0, 500, 2000, 1, 1),
('def_robotshard_thelodica_advanced', 1.0, 500, 2000, 1, 1),
('def_robotshard_thelodica_expert', 1.0, 500, 2000, 1, 1),
('def_research_kit_9', 1.0, 2, 5, 1, 1),
('def_research_kit_10', 1.0, 2, 5, 1, 1),
('def_boost_ep_t0', 1.0, 2, 5, 1, 1),
('def_boost_ep_t1', 1.0, 1, 2, 1, 1),
('def_reactore_core_runner', 1.0, 1, 2, 1, 1),
('def_reactore_core_assault', 1.0, 1, 2, 1, 1),
('def_reactore_core_mech', 1.0, 1, 2, 1, 1),
('def_reactore_core_heavymech', 1.0, 1, 2, 1, 1),
--Add 3x entries to get 3x 25% chance to get CT
('def_scarab_mk2_A_CT_capsule', 0.25, 1, 1, 1, 1),
('def_gropho_mk2_A_CT_capsule', 0.25, 1, 1, 1, 1),
('def_mesmer_mk2_A_CT_capsule', 0.25, 1, 1, 1, 1),
('def_seth_mk2_A_CT_capsule', 0.25, 1, 1, 1, 1),
('def_scarab_mk2_A_CT_capsule', 0.25, 1, 1, 1, 1),
('def_gropho_mk2_A_CT_capsule', 0.25, 1, 1, 1, 1),
('def_mesmer_mk2_A_CT_capsule', 0.25, 1, 1, 1, 1),
('def_seth_mk2_A_CT_capsule', 0.25, 1, 1, 1, 1),
('def_scarab_mk2_A_CT_capsule', 0.25, 1, 1, 1, 1),
('def_gropho_mk2_A_CT_capsule', 0.25, 1, 1, 1, 1),
('def_mesmer_mk2_A_CT_capsule', 0.25, 1, 1, 1, 1),
('def_seth_mk2_A_CT_capsule', 0.25, 1, 1, 1, 1),
--Add 3x entries to get 3x 11% chance to get nexus modules
('def_named2_gang_assist_speed_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_information_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_industry_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_siege_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_defense_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_ewar_range_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_shared_dataprocessing_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_coordinated_maneuvering_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_maintance_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_precision_firing_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_core_management_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_fast_extraction_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_shield_calculation_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_speed_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_information_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_industry_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_siege_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_defense_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_ewar_range_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_shared_dataprocessing_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_coordinated_maneuvering_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_maintance_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_precision_firing_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_core_management_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_fast_extraction_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_shield_calculation_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_speed_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_information_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_industry_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_siege_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_defense_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_ewar_range_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_shared_dataprocessing_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_coordinated_maneuvering_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_maintance_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_precision_firing_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_core_management_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_fast_extraction_module', 0.11, 1, 1, 0, 1),
('def_named2_gang_assist_shield_calculation_module', 0.11, 1, 1, 0, 1);


DECLARE @definitionID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_beta1_pitboss' ORDER BY definition DESC);

PRINT N'BETA 1 PITBOSS:LOOT';
PRINT N'Delete old loot';
DELETE FROM npcloot WHERE definition=@definitionID;
PRINT N'Add loot';
INSERT INTO npcloot ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity])
SELECT @definitionID, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defName), maxQuantity, probability, repackaged, dontDmg, minQuantity FROM #NPCLOOTS;

DROP TABLE IF EXISTS #NPCLOOTS;
GO