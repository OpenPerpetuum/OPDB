---- Boost Stolen Spectator spawns

DECLARE @presenceid INT
DECLARE @definition INT

-- Make Spectator spawns roaming

UPDATE npcpresence SET topx=10, topy=10, bottomx=2038, bottomy=2038, roaming=1, roamingrespawnseconds = 18000, presencetype=5 WHERE name in ('spectator_01_z7', 'spectator_01_z1', 'spectator_01_z6')

-- Shinjalar

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'spectator_01_z7')

DELETE FROM npcflock WHERE presenceid = @presenceid

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_spectator_miniboss')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'spectator_01_z7_def_npc_shinjalar_spectator_miniboss')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('spectator_01_z7_def_npc_shinjalar_spectator_miniboss', @presenceid, 1, @definition, 0, 0, 0, 10, 18000, 0, 50, 'shinjalar spectator npc', 0.9, 1, 1, 2, 1)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_zenith_shield_l7')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'spectator_01_z7_def_npc_shinjalar_zenith_shield_l7')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('spectator_01_z7_def_npc_shinjalar_zenith_shield_l7', @presenceid,3, @definition, 0, 0, 0, 10, 18000, 0, 50, 'shinjalar spectator npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_artemis_dps_l7')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'spectator_01_z7_def_npc_shinjalar_artemis_dps_l7')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('spectator_01_z7_def_npc_shinjalar_artemis_dps_l7', @presenceid, 5, @definition, 0, 0, 0, 10, 18000, 0, 50, 'shinjalar spectator npc', 0.9, 1, 1, 2, 0)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_seth_miniboss_rank3')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'spectator_01_z7_def_npc_shinjalar_seth_miniboss_rank3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('spectator_01_z7_def_npc_shinjalar_seth_miniboss_rank3', @presenceid, 2, @definition, 0, 0, 0, 10, 18000, 0, 50, 'shinjalar spectator npc', 0.9, 1, 1, 2, 0)
END

-- Attalica

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'spectator_01_z1')

--

DELETE FROM npcflock WHERE presenceid = @presenceid

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_spectator_miniboss')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'spectator_01_z1_def_npc_attalica_spectator_miniboss')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('spectator_01_z1_def_npc_attalica_spectator_miniboss', @presenceid, 1, @definition, 0, 0, 0, 10, 18000, 0, 50, 'attalica spectator npc', 0.9, 1, 1, 2, 1)
END
ELSE
BEGIN
	UPDATE npcflock SET spawnoriginX = 1345, spawnoriginY = 225 WHERE name = 'spectator_01_z1_def_npc_attalica_spectator_miniboss'
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_ictus_shield_l7')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'spectator_01_z1_def_npc_attalica_ictus_shield_l7')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('spectator_01_z1_def_npc_attalica_ictus_shield_l7', @presenceid, 3, @definition, 0, 0, 0, 10, 18000, 0, 50, 'attalica spectator npc', 0.9, 1, 1, 2, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET spawnoriginX = 1345, spawnoriginY = 225 WHERE name = 'spectator_01_z1_def_npc_attalica_ictus_shield_l7'
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_tyrannos_dps_l7')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'spectator_01_z1_def_npc_attalica_tyrannos_dps_l7')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('spectator_01_z1_def_npc_attalica_tyrannos_dps_l7', @presenceid, 5, @definition, 0, 0, 0, 10, 18000, 0, 50, 'attalica spectator npc', 0.9, 1, 1, 2, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET spawnoriginX = 1345, spawnoriginY = 225 WHERE name = 'spectator_01_z1_def_npc_attalica_tyrannos_dps_l7'
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_gropho_miniboss_rank3')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'spectator_01_z1_def_npc_attalica_gropho_miniboss_rank3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('spectator_01_z1_def_npc_attalica_gropho_miniboss_rank3', @presenceid, 2, @definition, 0, 0, 0, 10, 18000, 0, 50, 'attalica spectator npc', 0.9, 1, 1, 2, 0)
END

-- Tellesis

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'spectator_01_z6')

--

DELETE FROM npcflock WHERE presenceid = @presenceid

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_spectator_miniboss')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'spectator_01_z6_def_npc_tellesis_spectator_miniboss')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('spectator_01_z6_def_npc_tellesis_spectator_miniboss', @presenceid, 1, @definition, 0, 0, 0, 10, 18000, 0, 50, 'tellesis spectator npc', 0.9, 1, 1, 2, 1)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_vagabond_shield_l7')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'spectator_01_z6_def_npc_tellesis_vagabond_shield_l7')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('spectator_01_z6_def_npc_tellesis_vagabond_shield_l7', @presenceid, 3, @definition, 0, 0, 0, 10, 18000, 0, 50, 'tellesis spectator npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_kain_dps_l7')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'spectator_01_z6_def_npc_tellesis_kain_dps_l7')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('spectator_01_z6_def_npc_tellesis_kain_dps_l7', @presenceid, 5, @definition, 0, 0, 0, 10, 18000, 0, 50, 'tellesis spectator npc', 0.9, 1, 1, 2, 0)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_mesmer_miniboss_rank3')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'spectator_01_z6_def_npc_tellesis_mesmer_miniboss_rank3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('spectator_01_z6_def_npc_tellesis_mesmer_miniboss_rank3', @presenceid, 2, @definition, 0, 0, 0, 10, 18000, 0, 50, 'tellesis spectator npc', 0.9, 1, 1, 2, 0)
END

GO

---- Rebalance loot

DECLARE @targetDefinition INT
DECLARE @lootDefinition INT

-- Tellesis

SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_spectator_miniboss')

DELETE FROM npcloot WHERE definition = @targetDefinition

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_core_recharger')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_shield_generator')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_shield_hardener')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_remote_controller')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_energy_vampire')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1)

--

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_core_recharger')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_shield_generator')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_shield_hardener')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_energy_vampire')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1)

--

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_core_recharger')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_medium_shield_generator')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_shield_hardener')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_medium_energy_vampire')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_mk3_A_CT_capsule')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.25, 1, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_nuimqol_combat_drone_unit')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 15, 0.5, 0, 1, 5)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_nuimqol_combat_drone_unit')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 15, 0.25, 0, 1, 5)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_nuimqol_combat_drone_unit')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 15, 0.05, 0, 1, 5)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_nuimqol_combat_drone_unit')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 15, 0.025, 0, 1, 5)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_material_boss_gamma_syndicate')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 200, 1, 0, 1, 180)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_nuimqol')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 75000, 1, 0, 1, 37500)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_hitech')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 75000, 1, 0, 1, 37500)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_common')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 75000, 1, 0, 1, 37500)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_8')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.3, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_9')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.3, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_nuimqol_reactor_plasma')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 250000, 1, 0, 1, 125000)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_boost_ep_t0')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 3, 1, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_boost_ep_t1')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 2, 1, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_boost_ep_t2')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 1, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_reactore_core_heavymech')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 3, 0, 1, 1)

-- Shinjalar

SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_spectator_miniboss')

DELETE FROM npcloot WHERE definition = @targetDefinition

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_core_recharger')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_shield_generator')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_shield_hardener')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_remote_controller')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_energy_vampire')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1)

--

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_core_recharger')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_shield_generator')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_shield_hardener')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_energy_vampire')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1)

--

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_core_recharger')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_medium_shield_generator')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_shield_hardener')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_medium_energy_vampire')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_mk3_A_CT_capsule')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.25, 1, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_thelodica_combat_drone_unit')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 15, 0.5, 0, 1, 5)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_thelodica_combat_drone_unit')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 15, 0.25, 0, 1, 5)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_thelodica_combat_drone_unit')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 15, 0.05, 0, 1, 5)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_thelodica_combat_drone_unit')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 15, 0.025, 0, 1, 5)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_material_boss_gamma_syndicate')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 200, 1, 0, 1, 180)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_thelodica')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 75000, 1, 0, 1, 37500)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_hitech')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 75000, 1, 0, 1, 37500)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_common')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 75000, 1, 0, 1, 37500)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_8')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.3, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_9')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.3, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_thelodica_reactor_plasma')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 250000, 1, 0, 1, 125000)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_boost_ep_t0')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 3, 1, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_boost_ep_t1')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 2, 1, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_boost_ep_t2')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 1, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_reactore_core_heavymech')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 3, 0, 1, 1)

-- Attalica

SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_spectator_miniboss')

DELETE FROM npcloot WHERE definition = @targetDefinition

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_core_recharger')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_shield_generator')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_shield_hardener')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_remote_controller')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_energy_vampire')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1)

--

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_core_recharger')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_shield_generator')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_shield_hardener')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_energy_vampire')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1)

--

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_core_recharger')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_medium_shield_generator')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_shield_hardener')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_medium_energy_vampire')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_mk3_A_CT_capsule')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.25, 1, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_pelistal_combat_drone_unit')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 15, 1, 0, 1, 5)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_pelistal_combat_drone_unit')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 15, 0.75, 0, 1, 5)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_pelistal_combat_drone_unit')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 15, 0.5, 0, 1, 5)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_pelistal_combat_drone_unit')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 15, 0.25, 0, 1, 5)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_material_boss_gamma_syndicate')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 200, 1, 0, 1, 180)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_pelistal')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 75000, 1, 0, 1, 37500)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_hitech')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 75000, 1, 0, 1, 37500)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_common')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 75000, 1, 0, 1, 37500)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_8')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.3, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_9')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.3, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_nuimqol_reactor_plasma')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 250000, 1, 0, 1, 125000)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_boost_ep_t0')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 3, 1, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_boost_ep_t1')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 2, 1, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_boost_ep_t2')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 1, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_reactore_core_heavymech')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 3, 0, 1, 1)

GO

---- Reconfigure Spectators templates

DECLARE @robot INT
DECLARE @head INT
DECLARE @chassis INT
DECLARE @leg INT
DECLARE @inventory INT
DECLARE @shield INT
DECLARE @shield_hardener INT
DECLARE @remote_controller INT
DECLARE @recharger INT
DECLARE @drainer INT
DECLARE @sensor_booster INT
DECLARE @combat_drone INT

SET @robot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_bot')
SET @head = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_head')
SET @chassis = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_chassis')
SET @leg = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_leg')
SET @inventory = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robot_inventory_spectator')
SET @shield = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_shield_generator')
SET @shield_hardener = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_shield_hardener')
SET @remote_controller = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_remote_controller')
SET @recharger = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_core_recharger')
SET @drainer = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_energy_vampire')
SET @sensor_booster = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_sensor_booster')

-- Thelodica

SET @combat_drone = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_thelodica_combat_drone_unit')

UPDATE robottemplates SET description = CONCAT(
	'#robot=i',
	FORMAT(@robot, 'X'),
	'#head=i',
	FORMAT(@head, 'X'),
	'#chassis=i',
	FORMAT(@chassis, 'X'),
	'#leg=i',
	FORMAT(@leg, 'X'),
	'#container=i',
	FORMAT(@inventory, 'X'),
	'#headModules=[|m0=[|definition=i',
	FORMAT(@remote_controller, 'X'),
	'|slot=i1|ammoDefinition=i',
	FORMAT(@combat_drone, 'X'),
	'|ammoQuantity=i1]|m1=[|definition=i',
	FORMAT(@sensor_booster, 'X'),
	'|slot=i2]|m2=[|definition=i',
	FORMAT(@sensor_booster, 'X'),
	'|slot=i3]|m3=[|definition=i',
	FORMAT(@shield_hardener, 'X'),
	'|slot=i4]|m4=[|definition=i',
	FORMAT(@shield_hardener, 'X'),
	'|slot=i5]|m5=[|definition=i',
	FORMAT(@shield_hardener, 'X'),
	'|slot=i6]]#chassisModules=[|m0=[|definition=i',
	FORMAT(@drainer, 'X'),
	'|slot=i1]]#legModules=[|m0=[|definition=i',
	FORMAT(@shield, 'X'),
	'|slot=i1]|m1=[|definition=i',
	FORMAT(@recharger, 'X'),
	'|slot=i2]|m1=[|definition=i',
	FORMAT(@recharger, 'X'),
	'|slot=i2]|m1=[|definition=i',
	FORMAT(@recharger, 'X'),
	'|slot=i4]|m1=[|definition=i',
	FORMAT(@recharger, 'X'),
	'|slot=i5]]')
WHERE name = 'Spectator_Thelodica_Drones_Shield'

-- Nuimqol

SET @combat_drone = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_nuimqol_combat_drone_unit')

UPDATE robottemplates SET description = CONCAT(
	'#robot=i',
	FORMAT(@robot, 'X'),
	'#head=i',
	FORMAT(@head, 'X'),
	'#chassis=i',
	FORMAT(@chassis, 'X'),
	'#leg=i',
	FORMAT(@leg, 'X'),
	'#container=i',
	FORMAT(@inventory, 'X'),
	'#headModules=[|m0=[|definition=i',
	FORMAT(@remote_controller, 'X'),
	'|slot=i1|ammoDefinition=i',
	FORMAT(@combat_drone, 'X'),
	'|ammoQuantity=i1]|m1=[|definition=i',
	FORMAT(@sensor_booster, 'X'),
	'|slot=i2]|m2=[|definition=i',
	FORMAT(@sensor_booster, 'X'),
	'|slot=i3]|m3=[|definition=i',
	FORMAT(@shield_hardener, 'X'),
	'|slot=i4]|m4=[|definition=i',
	FORMAT(@shield_hardener, 'X'),
	'|slot=i5]|m5=[|definition=i',
	FORMAT(@shield_hardener, 'X'),
	'|slot=i6]]#chassisModules=[|m0=[|definition=i',
	FORMAT(@drainer, 'X'),
	'|slot=i1]]#legModules=[|m0=[|definition=i',
	FORMAT(@shield, 'X'),
	'|slot=i1]|m1=[|definition=i',
	FORMAT(@recharger, 'X'),
	'|slot=i2]|m1=[|definition=i',
	FORMAT(@recharger, 'X'),
	'|slot=i2]|m1=[|definition=i',
	FORMAT(@recharger, 'X'),
	'|slot=i4]|m1=[|definition=i',
	FORMAT(@recharger, 'X'),
	'|slot=i5]]')
WHERE name = 'Spectator_Nuimqol_Drones_Shield'

-- Pelistal

SET @combat_drone = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_pelistal_combat_drone_unit')

UPDATE robottemplates SET description = CONCAT(
	'#robot=i',
	FORMAT(@robot, 'X'),
	'#head=i',
	FORMAT(@head, 'X'),
	'#chassis=i',
	FORMAT(@chassis, 'X'),
	'#leg=i',
	FORMAT(@leg, 'X'),
	'#container=i',
	FORMAT(@inventory, 'X'),
	'#headModules=[|m0=[|definition=i',
	FORMAT(@remote_controller, 'X'),
	'|slot=i1|ammoDefinition=i',
	FORMAT(@combat_drone, 'X'),
	'|ammoQuantity=i1]|m1=[|definition=i',
	FORMAT(@sensor_booster, 'X'),
	'|slot=i2]|m2=[|definition=i',
	FORMAT(@sensor_booster, 'X'),
	'|slot=i3]|m3=[|definition=i',
	FORMAT(@shield_hardener, 'X'),
	'|slot=i4]|m4=[|definition=i',
	FORMAT(@shield_hardener, 'X'),
	'|slot=i5]|m5=[|definition=i',
	FORMAT(@shield_hardener, 'X'),
	'|slot=i6]]#chassisModules=[|m0=[|definition=i',
	FORMAT(@drainer, 'X'),
	'|slot=i1]]#legModules=[|m0=[|definition=i',
	FORMAT(@shield, 'X'),
	'|slot=i1]|m1=[|definition=i',
	FORMAT(@recharger, 'X'),
	'|slot=i2]|m1=[|definition=i',
	FORMAT(@recharger, 'X'),
	'|slot=i2]|m1=[|definition=i',
	FORMAT(@recharger, 'X'),
	'|slot=i4]|m1=[|definition=i',
	FORMAT(@recharger, 'X'),
	'|slot=i5]]')
WHERE name = 'Spectator_Pelistal_Drones_Shield'

GO

---- Change Spectator stats

DECLARE @targetDefinition INT

-- Shinjalar

SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_spectator_miniboss')

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

DECLARE @field INT

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_chemical')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 250)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 200 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_explosive')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 250)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 200 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_kinetic')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 250)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 200 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_thermal')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 250)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 200 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'sensor_strength_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 350)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 300 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_bandwidth_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 20)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 15 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_operational_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 80)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 50 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 3)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 3 WHERE definition = @targetDefinition AND field = @field
END

---- Create reinforcements

-- Tellesis

DECLARE @spawnid INT
DECLARE @presenceid INT
DECLARE @definition INT
DECLARE @templateid INT

SET @spawnid = (SELECT TOP 1 spawnid FROM zones WHERE name = 'zone_ICS_pve')

-- Wave 1

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'spectator_npc_wave_1_z6' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('spectator_npc_wave_1_z6', 0, 0, 0, 0, 'Tellesis Spectator reinforcement wave 1', @spawnid, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL, NULL)
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'spectator_npc_wave_1_z6')

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_kain_dps_l3')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'spectator_npc_wave_1_z6_gamma_kain_dps_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('spectator_npc_wave_1_z6_gamma_kain_dps_l3', @presenceid, 2, @definition, 0, 0, 0, 10, 0, 1, 50, 'tellesis npc', 0.5, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_vagabond_shield_l3')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'spectator_npc_wave_1_z6_gamma_vagabond_shield_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('spectator_npc_wave_1_z6_gamma_vagabond_shield_l3', @presenceid, 3, @definition, 0, 0, 0, 10, 0, 1, 50, 'tellesis npc', 0.5, 1, 1, 2, 0)
END

-- Wave 2

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'spectator_npc_wave_2_z6' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('spectator_npc_wave_2_z6', 0, 0, 0, 0, 'Tellesis Spectator reinforcement wave 2', @spawnid, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL, NULL)
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'spectator_npc_wave_2_z6')

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_kain_dps_l5')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'spectator_npc_wave_2_z6_gamma_kain_dps_l5')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('spectator_npc_wave_2_z6_gamma_kain_dps_l5', @presenceid, 2, @definition, 0, 0, 0, 10, 0, 1, 50, 'tellesis npc', 0.5, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_vagabond_shield_l5')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'spectator_npc_wave_2_z6_gamma_vagabond_shield_l5')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('spectator_npc_wave_2_z6_gamma_vagabond_shield_l5', @presenceid, 3, @definition, 0, 0, 0, 10, 0, 1, 50, 'tellesis npc', 0.5, 1, 1, 2, 0)
END

-- Wave 3

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'spectator_npc_wave_3_z6' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('spectator_npc_wave_3_z6', 0, 0, 0, 0, 'Tellesis Spectator reinforcement wave 3', @spawnid, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL, NULL)
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'spectator_npc_wave_3_z6')

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_kain_dps_l7')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'spectator_npc_wave_3_z6_gamma_kain_dps_l7')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('spectator_npc_wave_3_z6_gamma_kain_dps_l7', @presenceid, 2, @definition, 0, 0, 0, 10, 0, 1, 50, 'tellesis npc', 0.5, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_vagabond_shield_l7')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'spectator_npc_wave_3_z6_gamma_vagabond_shield_l7')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('spectator_npc_wave_3_z6_gamma_vagabond_shield_l7', @presenceid, 3, @definition, 0, 0, 0, 10, 0, 1, 50, 'tellesis npc', 0.5, 1, 1, 2, 0)
END

GO

---- Set up reinforcements for Tellesis Spectator

DECLARE @targetId INT
DECLARE @presenceId INT
DECLARE @zoneId INT

SET @zoneId = (SELECT TOP 1 id FROM zones WHERE name = 'zone_ICS_pve')

-- Wave 1

SET @targetId = (SELECT TOP 1 id FROM npcflock WHERE name = 'spectator_01_z6_def_npc_tellesis_spectator_miniboss')
SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'spectator_npc_wave_1_z6')

IF NOT EXISTS (SELECT 1 FROM npcreinforcements WHERE targetId = @targetId AND presenceId = @presenceId AND zoneId = @zoneId)
BEGIN
	INSERT INTO npcreinforcements (reinforcementType, targetId, threshold, presenceId, zoneId) VALUES
	(2, @targetId, 0.75, @presenceId, @zoneId)
END

-- Wave 2

SET @targetId = (SELECT TOP 1 id FROM npcflock WHERE name = 'spectator_01_z6_def_npc_tellesis_spectator_miniboss')
SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'spectator_npc_wave_2_z6')

IF NOT EXISTS (SELECT 1 FROM npcreinforcements WHERE targetId = @targetId AND presenceId = @presenceId AND zoneId = @zoneId)
BEGIN
	INSERT INTO npcreinforcements (reinforcementType, targetId, threshold, presenceId, zoneId) VALUES
	(2, @targetId, 0.5, @presenceId, @zoneId)
END

-- Wave 3

SET @targetId = (SELECT TOP 1 id FROM npcflock WHERE name = 'spectator_01_z6_def_npc_tellesis_spectator_miniboss')
SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'spectator_npc_wave_3_z6')

IF NOT EXISTS (SELECT 1 FROM npcreinforcements WHERE targetId = @targetId AND presenceId = @presenceId AND zoneId = @zoneId)
BEGIN
	INSERT INTO npcreinforcements (reinforcementType, targetId, threshold, presenceId, zoneId) VALUES
	(2, @targetId, 0.25, @presenceId, @zoneId)
END

GO

-- Shinjalar

DECLARE @spawnid INT
DECLARE @presenceid INT
DECLARE @definition INT
DECLARE @templateid INT

SET @spawnid = (SELECT TOP 1 spawnid FROM zones WHERE name = 'zone_ASI_pve')

-- Wave 1

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'spectator_npc_wave_1_z7' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('spectator_npc_wave_1_z7', 0, 0, 0, 0, 'Shinjalar Spectator reinforcement wave 1', @spawnid, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL, NULL)
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'spectator_npc_wave_1_z7')

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_artemis_dps_l3')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'spectator_npc_wave_1_z7_gamma_artemis_dps_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('spectator_npc_wave_1_z7_gamma_artemis_dps_l3', @presenceid, 2, @definition, 0, 0, 0, 10, 0, 1, 50, 'shinjalar npc', 0.5, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_zenith_shield_l3')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'spectator_npc_wave_1_z7_gamma_zenith_shield_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('spectator_npc_wave_1_z7_gamma_zenith_shield_l3', @presenceid, 3, @definition, 0, 0, 0, 10, 0, 1, 50, 'shinjalar npc', 0.5, 1, 1, 2, 0)
END

-- Wave 2

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'spectator_npc_wave_2_z7' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('spectator_npc_wave_2_z7', 0, 0, 0, 0, 'Shinjalar Spectator reinforcement wave 2', @spawnid, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL, NULL)
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'spectator_npc_wave_2_z7')

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_artemis_dps_l5')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'spectator_npc_wave_2_z7_gamma_artemis_dps_l5')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('spectator_npc_wave_2_z7_gamma_artemis_dps_l5', @presenceid, 2, @definition, 0, 0, 0, 10, 0, 1, 50, 'tellesis npc', 0.5, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_zenith_shield_l5')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'spectator_npc_wave_2_z7_gamma_zenith_shield_l5')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('spectator_npc_wave_2_z7_gamma_zenith_shield_l5', @presenceid, 3, @definition, 0, 0, 0, 10, 0, 1, 50, 'shinjalar npc', 0.5, 1, 1, 2, 0)
END

-- Wave 3

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'spectator_npc_wave_3_z7' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('spectator_npc_wave_3_z7', 0, 0, 0, 0, 'Shinjalar Spectator reinforcement wave 3', @spawnid, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL, NULL)
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'spectator_npc_wave_3_z7')

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_artemis_dps_l7')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'spectator_npc_wave_3_z7_gamma_artemis_dps_l7')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('spectator_npc_wave_3_z7_gamma_kain_artemis_l7', @presenceid, 2, @definition, 0, 0, 0, 10, 0, 1, 50, 'shinjalar npc', 0.5, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_zenith_shield_l7')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'spectator_npc_wave_3_z7_gamma_zenith_shield_l7')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('spectator_npc_wave_3_z7_gamma_zenith_shield_l7', @presenceid, 3, @definition, 0, 0, 0, 10, 0, 1, 50, 'shinjalar npc', 0.5, 1, 1, 2, 0)
END

GO

---- Set up reinforcements for Shinjalar Spectator

DECLARE @targetId INT
DECLARE @presenceId INT
DECLARE @zoneId INT

SET @zoneId = (SELECT TOP 1 id FROM zones WHERE name = 'zone_ASI_pve')

-- Wave 1

SET @targetId = (SELECT TOP 1 id FROM npcflock WHERE name = 'spectator_01_z7_def_npc_shinjalar_spectator_miniboss')
SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'spectator_npc_wave_1_z7')

IF NOT EXISTS (SELECT 1 FROM npcreinforcements WHERE targetId = @targetId AND presenceId = @presenceId AND zoneId = @zoneId)
BEGIN
	INSERT INTO npcreinforcements (reinforcementType, targetId, threshold, presenceId, zoneId) VALUES
	(2, @targetId, 0.75, @presenceId, @zoneId)
END

-- Wave 2

SET @targetId = (SELECT TOP 1 id FROM npcflock WHERE name = 'spectator_01_z7_def_npc_shinjalar_spectator_miniboss')
SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'spectator_npc_wave_2_z7')

IF NOT EXISTS (SELECT 1 FROM npcreinforcements WHERE targetId = @targetId AND presenceId = @presenceId AND zoneId = @zoneId)
BEGIN
	INSERT INTO npcreinforcements (reinforcementType, targetId, threshold, presenceId, zoneId) VALUES
	(2, @targetId, 0.5, @presenceId, @zoneId)
END

-- Wave 3

SET @targetId = (SELECT TOP 1 id FROM npcflock WHERE name = 'spectator_01_z7_def_npc_shinjalar_spectator_miniboss')
SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'spectator_npc_wave_3_z7')

IF NOT EXISTS (SELECT 1 FROM npcreinforcements WHERE targetId = @targetId AND presenceId = @presenceId AND zoneId = @zoneId)
BEGIN
	INSERT INTO npcreinforcements (reinforcementType, targetId, threshold, presenceId, zoneId) VALUES
	(2, @targetId, 0.25, @presenceId, @zoneId)
END

GO

-- Attalica

DECLARE @spawnid INT
DECLARE @presenceid INT
DECLARE @definition INT
DECLARE @templateid INT

SET @spawnid = (SELECT TOP 1 spawnid FROM zones WHERE name = 'zone_ICS')

-- Wave 1

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'spectator_npc_wave_1_z1' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('spectator_npc_wave_1_z1', 0, 0, 0, 0, 'Attalica Spectator reinforcement wave 1', @spawnid, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL, NULL)
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'spectator_npc_wave_1_z1')

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_tyrannos_dps_l3')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'spectator_npc_wave_1_z1_gamma_tyrannos_dps_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('spectator_npc_wave_1_z1_gamma_tyrannos_dps_l3', @presenceid, 2, @definition, 0, 0, 0, 10, 0, 1, 50, 'attalica npc', 0.5, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_ictus_shield_l3')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'spectator_npc_wave_1_z1_gamma_ictus_shield_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('spectator_npc_wave_1_z1_gamma_ictus_shield_l3', @presenceid, 3, @definition, 0, 0, 0, 10, 0, 1, 50, 'attalica npc', 0.5, 1, 1, 2, 0)
END

-- Wave 2

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'spectator_npc_wave_2_z1' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('spectator_npc_wave_2_z1', 0, 0, 0, 0, 'Attalica Spectator reinforcement wave 2', @spawnid, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL, NULL)
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'spectator_npc_wave_2_z1')

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_tyrannos_dps_l5')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'spectator_npc_wave_2_z1_gamma_tyrannos_dps_l5')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('spectator_npc_wave_2_z1_gamma_tyrannos_dps_l5', @presenceid, 2, @definition, 0, 0, 0, 10, 0, 1, 50, 'attalica npc', 0.5, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_ictus_shield_l5')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'spectator_npc_wave_2_z1_gamma_ictus_shield_l5')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('spectator_npc_wave_2_z1_gamma_ictus_shield_l5', @presenceid, 3, @definition, 0, 0, 0, 10, 0, 1, 50, 'attalica npc', 0.5, 1, 1, 2, 0)
END

-- Wave 3

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'spectator_npc_wave_3_z1' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('spectator_npc_wave_3_z1', 0, 0, 0, 0, 'Attalica Spectator reinforcement wave 3', @spawnid, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL, NULL)
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'spectator_npc_wave_3_z1')

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_tyrannos_dps_l7')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'spectator_npc_wave_3_z1_gamma_tyrannos_dps_l7')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('spectator_npc_wave_3_z1_gamma_tyrannos_dps_l7', @presenceid, 2, @definition, 0, 0, 0, 10, 0, 1, 50, 'attalica npc', 0.5, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_ictus_shield_l7')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'spectator_npc_wave_3_z1_gamma_ictus_shield_l7')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('spectator_npc_wave_3_z1_gamma_ictus_shield_l7', @presenceid, 3, @definition, 0, 0, 0, 10, 0, 1, 50, 'attalica npc', 0.5, 1, 1, 2, 0)
END

GO

---- Set up reinforcements for Attalica Spectator

DECLARE @targetId INT
DECLARE @presenceId INT
DECLARE @zoneId INT

SET @zoneId = (SELECT TOP 1 id FROM zones WHERE name = 'zone_ICS')

-- Wave 1

SET @targetId = (SELECT TOP 1 id FROM npcflock WHERE name = 'spectator_01_z1_def_npc_attalica_spectator_miniboss')
SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'spectator_npc_wave_1_z1')

IF NOT EXISTS (SELECT 1 FROM npcreinforcements WHERE targetId = @targetId AND presenceId = @presenceId AND zoneId = @zoneId)
BEGIN
	INSERT INTO npcreinforcements (reinforcementType, targetId, threshold, presenceId, zoneId) VALUES
	(2, @targetId, 0.75, @presenceId, @zoneId)
END

-- Wave 2

SET @targetId = (SELECT TOP 1 id FROM npcflock WHERE name = 'spectator_01_z1_def_npc_attalica_spectator_miniboss')
SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'spectator_npc_wave_2_z1')

IF NOT EXISTS (SELECT 1 FROM npcreinforcements WHERE targetId = @targetId AND presenceId = @presenceId AND zoneId = @zoneId)
BEGIN
	INSERT INTO npcreinforcements (reinforcementType, targetId, threshold, presenceId, zoneId) VALUES
	(2, @targetId, 0.5, @presenceId, @zoneId)
END

-- Wave 3

SET @targetId = (SELECT TOP 1 id FROM npcflock WHERE name = 'spectator_01_z1_def_npc_attalica_spectator_miniboss')
SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'spectator_npc_wave_3_z1')

IF NOT EXISTS (SELECT 1 FROM npcreinforcements WHERE targetId = @targetId AND presenceId = @presenceId AND zoneId = @zoneId)
BEGIN
	INSERT INTO npcreinforcements (reinforcementType, targetId, threshold, presenceId, zoneId) VALUES
	(2, @targetId, 0.25, @presenceId, @zoneId)
END

GO

---- Fix Remote controller optimal range bonus

DECLARE @categoryFlag INT
DECLARE @baseField INT
DECLARE @modifierField INT

DELETE FROM aggregatemodifiers WHERE categoryflag = @categoryFlag

SET @categoryFlag = (SELECT TOP 1 value FROM categoryflags WHERE name = 'cf_remote_controllers')
SET @baseField = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range')
SET @modifierField = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range_modifier')

INSERT INTO aggregatemodifiers (categoryflag, basefield, modifierfield) VALUES
(@categoryFlag, @baseField, @modifierField)

DELETE FROM modulepropertymodifiers WHERE categoryFlags = @categoryFlag AND basefield = @baseField AND modifierfield = @modifierField

INSERT INTO modulepropertymodifiers (categoryFlags, basefield, modifierfield) VALUES
(@categoryFlag, @baseField, @modifierField)

GO

---- Change plants rule set to the one with helio

UPDATE zones SET plantruleset = 0 WHERE name = 'zone_training'

---- Add plants grow time settings override

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE  object_id = OBJECT_ID(N'[dbo].[zones]') AND name = 'PlantsGrowthTimerOverrideMin')
BEGIN
	ALTER TABLE zones
	ADD PlantsGrowthTimerOverrideMin INT
END

GO

---- Fix training zone and override timer

UPDATE zones SET plantruleset = 0, PlantsGrowthTimerOverrideMin = 15 WHERE name = 'zone_training'

GO

---- Cleanup Hershfield minerals. They will reappear in 10-15 min.

DELETE FROM mineralnodes WHERE zoneid = 8