USE [perpetuumsa]
GO

---------------------------------------
-- GAMMA NPC LOOTS part 1
-- L3-L7, N/P/T/S factions
-- Just basics, mods, kern/frag/plas
-- Date modified: 2021/11/02
---------------------------------------

DROP TABLE IF EXISTS #BOTS_BY_FACTION;
CREATE TABLE #BOTS_BY_FACTION(
	botName varchar(64),
	className varchar(64),
	faction varchar(64)
);
INSERT INTO #BOTS_BY_FACTION (botName, className, faction) VALUES
('apollo', 'destroyer', 'syndicate'),
('arbalest', 'assault', 'nuimqol'),
('artemis', 'mech', 'thelodica'),
('baphomet', 'assault', 'thelodica'),
('callisto', 'mech', 'syndicate'),
('cameleon', 'light ewar', 'nuimqol'),
('castel', 'light', 'pelistal'),
('cronus', 'assault indy', 'syndicate'),
('daidalos', 'mech indy', 'syndicate'),
('echelon', 'mech', 'syndicate'),
('felos', 'destroyer', 'nuimqol'),
('gargoyle', 'mech indy', 'industrial'),
('gropho', 'heavy mech', 'pelistal'),
('helix', 'light ewar', 'syndicate'),
('hermes', 'assault indy', 'syndicate'),
('hydra', 'destroyer', 'pelistal'),
('ictus', 'mech ewar', 'pelistal'),
('ikarus', 'light indy', 'syndicate'),
('intakt', 'light ewar', 'thelodica'),
('kain', 'mech', 'nuimqol'),
('laird', 'light indy', 'industrial'),
('legatus', 'heavy mech', 'syndicate'),
('lithus', 'heavy mech indy', 'industrial'),
('locust', 'assault', 'syndicate'),
('mesmer', 'heavy mech', 'nuimqol'),
('onyx', 'destroyer', 'thelodica'),
('prometheus', 'light', 'thelodica'),
('riveler', 'heavy mech indy', 'industrial'),
('scarab', 'heavy mech indy', 'industrial'),
('sequer', 'assault indy', 'industrial'),
('seth', 'heavy mech', 'thelodica'),
('symbiont', 'heavy mech indy', 'industrial'),
('termis', 'mech indy', 'industrial'),
('troiar', 'light ewar', 'pelistal'),
('tyrannos', 'mech', 'pelistal'),
('vagabond', 'mech', 'nuimqol'),
('vektor', 'light', 'syndicate'),
('waspish', 'assault', 'pelistal'),
('yagel', 'light', 'nuimqol'),
('zenith', 'mech ewar', 'thelodica');


DROP TABLE IF EXISTS #NPCS_BY_FACTION_BY_LEVEL;
CREATE TABLE #NPCS_BY_FACTION_BY_LEVEL(
	def int,
	npcName varchar(128),
	className varchar(64),
	faction varchar(64),
	levelName varchar(32)
);
INSERT INTO #NPCS_BY_FACTION_BY_LEVEL (def, npcName, className, faction, levelName)
SELECT d.definition, d.definitionname, f.className, f.faction, RIGHT(d.definitionname, CHARINDEX('_',REVERSE(d.definitionname))-1)
FROM entitydefaults d
JOIN #BOTS_BY_FACTION f ON d.definitionname like '%'+f.botName+'%'
WHERE definitionname like 'def_npc_gamma_%';

DROP TABLE IF EXISTS #LOOT_SHEET_OUTPUT_BASICS;
CREATE TABLE #LOOT_SHEET_OUTPUT_BASICS(
	faction varchar(64),
	levelName varchar(32),
	lootName varchar(128),
	heavyQuant int,
	mechQuant int,
	mechEwQuant int,
	assaultQuant int,
	lightEWQuant int,
	lightQuant int,
	prob float default 1.0
);
INSERT INTO #LOOT_SHEET_OUTPUT_BASICS (faction, levelName, lootName, heavyQuant, mechQuant, mechEwQuant, assaultQuant, lightEWQuant, lightQuant) VALUES
('thelodica','l7','def_thelodica_reactor_plasma',11128,8008,8008,1560,1560,832),
('thelodica','l7','def_kernel_thelodica',17472,9282,5642,7098,7098,3640),
('thelodica','l7','def_kernel_hitech',6240,5200,5200,2600,2600,1820),
('thelodica','l7','def_kernel_common',7488,3978,2418,3042,3042,1560),
('thelodica','l6','def_thelodica_reactor_plasma',7790,5606,5606,1092,1092,582),
('thelodica','l6','def_kernel_thelodica',12230,6497,3949,4969,4969,2548),
('thelodica','l6','def_kernel_hitech',4368,3640,3640,1820,1820,1274),
('thelodica','l6','def_kernel_common',5242,2785,1693,2129,2129,1092),
('thelodica','l5','def_thelodica_reactor_plasma',5564,4004,4004,780,780,416),
('thelodica','l5','def_kernel_thelodica',8736,4641,2821,3549,3549,1820),
('thelodica','l5','def_kernel_hitech',3120,2600,2600,1300,1300,910),
('thelodica','l5','def_kernel_common',3744,1989,1209,1521,1521,780),
('thelodica','l4','def_thelodica_reactor_plasma',4451,3203,3203,624,624,333),
('thelodica','l4','def_kernel_thelodica',6989,3713,2257,2839,2839,1456),
('thelodica','l4','def_kernel_hitech',2496,2080,2080,1040,1040,728),
('thelodica','l4','def_kernel_common',2995,1591,967,1217,1217,624),
('thelodica','l3','def_thelodica_reactor_plasma',3338,2402,2402,468,468,250),
('thelodica','l3','def_kernel_thelodica',5242,2785,1693,2129,2129,1092),
('thelodica','l3','def_kernel_hitech',1872,1560,1560,780,780,546),
('thelodica','l3','def_kernel_common',2246,1193,725,913,913,468),

('nuimqol','l7','def_nuimqol_reactor_plasma',11128,8008,8008,1560,1560,832),
('nuimqol','l7','def_kernel_nuimqol',17472,9282,5642,7098,7098,3640),
('nuimqol','l7','def_kernel_hitech',6240,5200,5200,2600,2600,1820),
('nuimqol','l7','def_kernel_common',7488,3978,2418,3042,3042,1560),
('nuimqol','l6','def_nuimqol_reactor_plasma',7790,5606,5606,1092,1092,582),
('nuimqol','l6','def_kernel_nuimqol',12230,6497,3949,4969,4969,2548),
('nuimqol','l6','def_kernel_hitech',4368,3640,3640,1820,1820,1274),
('nuimqol','l6','def_kernel_common',5242,2785,1693,2129,2129,1092),
('nuimqol','l5','def_nuimqol_reactor_plasma',5564,4004,4004,780,780,416),
('nuimqol','l5','def_kernel_nuimqol',8736,4641,2821,3549,3549,1820),
('nuimqol','l5','def_kernel_hitech',3120,2600,2600,1300,1300,910),
('nuimqol','l5','def_kernel_common',3744,1989,1209,1521,1521,780),
('nuimqol','l4','def_nuimqol_reactor_plasma',4451,3203,3203,624,624,333),
('nuimqol','l4','def_kernel_nuimqol',6989,3713,2257,2839,2839,1456),
('nuimqol','l4','def_kernel_hitech',2496,2080,2080,1040,1040,728),
('nuimqol','l4','def_kernel_common',2995,1591,967,1217,1217,624),
('nuimqol','l3','def_nuimqol_reactor_plasma',3338,2402,2402,468,468,250),
('nuimqol','l3','def_kernel_nuimqol',5242,2785,1693,2129,2129,1092),
('nuimqol','l3','def_kernel_hitech',1872,1560,1560,780,780,546),
('nuimqol','l3','def_kernel_common',2246,1193,725,913,913,468),

('pelistal','l7','def_pelistal_reactor_plasma',11128,8008,8008,1560,1560,832),
('pelistal','l7','def_kernel_pelistal',17472,9282,5642,7098,7098,3640),
('pelistal','l7','def_kernel_hitech',6240,5200,5200,2600,2600,1820),
('pelistal','l7','def_kernel_common',7488,3978,2418,3042,3042,1560),
('pelistal','l6','def_pelistal_reactor_plasma',7790,5606,5606,1092,1092,582),
('pelistal','l6','def_kernel_pelistal',12230,6497,3949,4969,4969,2548),
('pelistal','l6','def_kernel_hitech',4368,3640,3640,1820,1820,1274),
('pelistal','l6','def_kernel_common',5242,2785,1693,2129,2129,1092),
('pelistal','l5','def_pelistal_reactor_plasma',5564,4004,4004,780,780,416),
('pelistal','l5','def_kernel_pelistal',8736,4641,2821,3549,3549,1820),
('pelistal','l5','def_kernel_hitech',3120,2600,2600,1300,1300,910),
('pelistal','l5','def_kernel_common',3744,1989,1209,1521,1521,780),
('pelistal','l4','def_pelistal_reactor_plasma',4451,3203,3203,624,624,333),
('pelistal','l4','def_kernel_pelistal',6989,3713,2257,2839,2839,1456),
('pelistal','l4','def_kernel_hitech',2496,2080,2080,1040,1040,728),
('pelistal','l4','def_kernel_common',2995,1591,967,1217,1217,624),
('pelistal','l3','def_pelistal_reactor_plasma',3338,2402,2402,468,468,250),
('pelistal','l3','def_kernel_pelistal',5242,2785,1693,2129,2129,1092),
('pelistal','l3','def_kernel_hitech',1872,1560,1560,780,780,546),
('pelistal','l3','def_kernel_common',2246,1193,725,913,913,468),

('syndicate','l7','def_common_reactor_plasma',13354,9610,9610,1872,1872,998),
('syndicate','l7','def_kernel_common',22464,11934,7254,9126,9126,4680),
('syndicate','l7','def_kernel_hitech',12480,10400,10400,5200,5200,3640),
('syndicate','l6','def_common_reactor_plasma',9348,6727,6727,1310,1310,699),
('syndicate','l6','def_kernel_common',15725,8354,5078,6388,6388,3276),
('syndicate','l6','def_kernel_hitech',8736,7280,7280,3640,3640,2548),
('syndicate','l5','def_common_reactor_plasma',6677,4805,4805,936,936,499),
('syndicate','l5','def_kernel_common',11232,5967,3627,4563,4563,2340),
('syndicate','l5','def_kernel_hitech',6240,5200,5200,2600,2600,1820),
('syndicate','l4','def_common_reactor_plasma',5341,3844,3844,749,749,399),
('syndicate','l4','def_kernel_common',8986,4774,2902,3650,3650,1872),
('syndicate','l4','def_kernel_hitech',4992,4160,4160,2080,2080,1456),
('syndicate','l3','def_common_reactor_plasma',4006,2883,2883,562,562,300),
('syndicate','l3','def_kernel_common',6739,3580,2176,2738,2738,1404),
('syndicate','l3','def_kernel_hitech',3744,3120,3120,1560,1560,1092);

--frags
INSERT INTO #LOOT_SHEET_OUTPUT_BASICS (faction, levelName, lootName, heavyQuant, mechQuant, mechEwQuant, assaultQuant, lightEWQuant, lightQuant, prob) VALUES

('thelodica','l7','def_robotshard_thelodica_basic',49,29,68,33,20,46,0.5),
('thelodica','l7','def_robotshard_thelodica_advanced',49,49,49,33,33,33,0.5),
('thelodica','l7','def_robotshard_thelodica_expert',49,68,29,33,46,20,0.5),

('thelodica','l6','def_robotshard_thelodica_basic',34,20,48,23,14,32,0.5),
('thelodica','l6','def_robotshard_thelodica_advanced',34,34,34,23,23,23,0.5),
('thelodica','l6','def_robotshard_thelodica_expert',34,48,20,23,32,14,0.5),

('thelodica','l5','def_robotshard_thelodica_basic',25,15,34,17,10,23,0.5),
('thelodica','l5','def_robotshard_thelodica_advanced',25,25,25,17,17,17,0.5),
('thelodica','l5','def_robotshard_thelodica_expert',25,34,15,17,23,10,0.5),

('thelodica','l4','def_robotshard_thelodica_basic',20,12,27,13,8,18,0.5),
('thelodica','l4','def_robotshard_thelodica_advanced',20,20,20,13,13,13,0.5),
('thelodica','l4','def_robotshard_thelodica_expert',20,27,12,13,18,8,0.5),

('thelodica','l3','def_robotshard_thelodica_basic',15,9,20,10,6,14,0.5),
('thelodica','l3','def_robotshard_thelodica_advanced',15,15,15,10,10,10,0.5),
('thelodica','l3','def_robotshard_thelodica_expert',15,20,9,10,14,6,0.5),
--
('pelistal','l7','def_robotshard_pelistal_basic',49,29,68,33,20,46,0.5),
('pelistal','l7','def_robotshard_pelistal_advanced',49,49,49,33,33,33,0.5),
('pelistal','l7','def_robotshard_pelistal_expert',49,68,29,33,46,20,0.5),

('pelistal','l6','def_robotshard_pelistal_basic',34,20,48,23,14,32,0.5),
('pelistal','l6','def_robotshard_pelistal_advanced',34,34,34,23,23,23,0.5),
('pelistal','l6','def_robotshard_pelistal_expert',34,48,20,23,32,14,0.5),

('pelistal','l5','def_robotshard_pelistal_basic',25,15,34,17,10,23,0.5),
('pelistal','l5','def_robotshard_pelistal_advanced',25,25,25,17,17,17,0.5),
('pelistal','l5','def_robotshard_pelistal_expert',25,34,15,17,23,10,0.5),

('pelistal','l4','def_robotshard_pelistal_basic',20,12,27,13,8,18,0.5),
('pelistal','l4','def_robotshard_pelistal_advanced',20,20,20,13,13,13,0.5),
('pelistal','l4','def_robotshard_pelistal_expert',20,27,12,13,18,8,0.5),

('pelistal','l3','def_robotshard_pelistal_basic',15,9,20,10,6,14,0.5),
('pelistal','l3','def_robotshard_pelistal_advanced',15,15,15,10,10,10,0.5),
('pelistal','l3','def_robotshard_pelistal_expert',15,20,9,10,14,6,0.5),
--
('nuimqol','l7','def_robotshard_nuimqol_basic',49,29,68,33,20,46,0.5),
('nuimqol','l7','def_robotshard_nuimqol_advanced',49,49,49,33,33,33,0.5),
('nuimqol','l7','def_robotshard_nuimqol_expert',49,68,29,33,46,20,0.5),

('nuimqol','l6','def_robotshard_nuimqol_basic',34,20,48,23,14,32,0.5),
('nuimqol','l6','def_robotshard_nuimqol_advanced',34,34,34,23,23,23,0.5),
('nuimqol','l6','def_robotshard_nuimqol_expert',34,48,20,23,32,14,0.5),

('nuimqol','l5','def_robotshard_nuimqol_basic',25,15,34,17,10,23,0.5),
('nuimqol','l5','def_robotshard_nuimqol_advanced',25,25,25,17,17,17,0.5),
('nuimqol','l5','def_robotshard_nuimqol_expert',25,34,15,17,23,10,0.5),

('nuimqol','l4','def_robotshard_nuimqol_basic',20,12,27,13,8,18,0.5),
('nuimqol','l4','def_robotshard_nuimqol_advanced',20,20,20,13,13,13,0.5),
('nuimqol','l4','def_robotshard_nuimqol_expert',20,27,12,13,18,8,0.5),

('nuimqol','l3','def_robotshard_nuimqol_basic',15,9,20,10,6,14,0.5),
('nuimqol','l3','def_robotshard_nuimqol_advanced',15,15,15,10,10,10,0.5),
('nuimqol','l3','def_robotshard_nuimqol_expert',15,20,9,10,14,6,0.5),
--
('syndicate','l7','def_robotshard_common_basic',74,44,102,50,30,69,0.5),
('syndicate','l7','def_robotshard_common_advanced',74,74,74,50,50,50,0.5),
('syndicate','l7','def_robotshard_common_expert',74,102,44,50,69,30,0.5),

('syndicate','l6','def_robotshard_common_basic',51,30,72,35,21,48,0.5),
('syndicate','l6','def_robotshard_common_advanced',51,51,51,35,35,35,0.5),
('syndicate','l6','def_robotshard_common_expert',51,72,30,35,48,21,0.5),

('syndicate','l5','def_robotshard_common_basic',38,23,51,26,15,35,0.5),
('syndicate','l5','def_robotshard_common_advanced',38,38,38,26,26,26,0.5),
('syndicate','l5','def_robotshard_common_expert',38,51,23,26,35,15,0.5),

('syndicate','l4','def_robotshard_common_basic',30,18,41,20,12,27,0.5),
('syndicate','l4','def_robotshard_common_advanced',30,30,30,20,20,20,0.5),
('syndicate','l4','def_robotshard_common_expert',30,41,18,20,27,12,0.5),

('syndicate','l3','def_robotshard_common_basic',23,14,30,15,9,21,0.5),
('syndicate','l3','def_robotshard_common_advanced',23,23,23,15,15,15,0.5),
('syndicate','l3','def_robotshard_common_expert',23,30,14,15,21,9,0.5);

--shards
INSERT INTO #LOOT_SHEET_OUTPUT_BASICS (faction, levelName, lootName, heavyQuant, mechQuant, mechEwQuant, assaultQuant, lightEWQuant, lightQuant, prob) VALUES
('thelodica','l7','def_material_boss_gamma_thelodica',6,3,3,2,2,2,1.0),
('thelodica','l6','def_material_boss_gamma_thelodica',5,2,2,1,1,1,0.9),
('thelodica','l5','def_material_boss_gamma_thelodica',4,2,2,1,1,1,0.8),
('thelodica','l4','def_material_boss_gamma_thelodica',3,2,2,1,1,1,0.65),
('thelodica','l3','def_material_boss_gamma_thelodica',2,2,2,1,1,1,0.5),

('nuimqol','l7','def_material_boss_gamma_nuimqol',6,3,3,2,2,2,1.0),
('nuimqol','l6','def_material_boss_gamma_nuimqol',5,2,2,1,1,1,0.9),
('nuimqol','l5','def_material_boss_gamma_nuimqol',4,2,2,1,1,1,0.8),
('nuimqol','l4','def_material_boss_gamma_nuimqol',3,2,2,1,1,1,0.65),
('nuimqol','l3','def_material_boss_gamma_nuimqol',2,2,2,1,1,1,0.5),

('pelistal','l7','def_material_boss_gamma_pelistal',6,3,3,2,2,2,1.0),
('pelistal','l6','def_material_boss_gamma_pelistal',5,2,2,1,1,1,0.9),
('pelistal','l5','def_material_boss_gamma_pelistal',4,2,2,1,1,1,0.8),
('pelistal','l4','def_material_boss_gamma_pelistal',3,2,2,1,1,1,0.65),
('pelistal','l3','def_material_boss_gamma_pelistal',2,2,2,1,1,1,0.5),

('syndicate','l7','def_material_boss_gamma_syndicate',6,3,3,2,2,2,1.0),
('syndicate','l6','def_material_boss_gamma_syndicate',5,2,2,1,1,1,0.9),
('syndicate','l5','def_material_boss_gamma_syndicate',4,2,2,1,1,1,0.8),
('syndicate','l4','def_material_boss_gamma_syndicate',3,2,2,1,1,1,0.65),
('syndicate','l3','def_material_boss_gamma_syndicate',2,2,2,1,1,1,0.5);


DROP TABLE IF EXISTS #LOOT_SHEET_OUTPUT_BASICS_TRANSPOSED;
CREATE TABLE #LOOT_SHEET_OUTPUT_BASICS_TRANSPOSED(
	faction varchar(64),
	levelName varchar(32),
	className varchar(32),
	lootName varchar(128),
	minQuant int,
	maxQuant int,
	prob float default 1.0
);
INSERT INTO #LOOT_SHEET_OUTPUT_BASICS_TRANSPOSED (faction, levelName, className, lootName, minQuant, maxQuant, prob)
SELECT faction, levelName, 'light', lootName, CEILING(lightQuant*0.8), lightQuant, prob
FROM #LOOT_SHEET_OUTPUT_BASICS;

INSERT INTO #LOOT_SHEET_OUTPUT_BASICS_TRANSPOSED (faction, levelName, className, lootName, minQuant, maxQuant, prob)
SELECT faction, levelName, 'assault', lootName, CEILING(assaultQuant*0.8), assaultQuant, prob
FROM #LOOT_SHEET_OUTPUT_BASICS;

INSERT INTO #LOOT_SHEET_OUTPUT_BASICS_TRANSPOSED (faction, levelName, className, lootName, minQuant, maxQuant, prob)
SELECT faction, levelName, 'light ewar', lootName, CEILING(lightEWQuant*0.8), lightEWQuant, prob
FROM #LOOT_SHEET_OUTPUT_BASICS;

INSERT INTO #LOOT_SHEET_OUTPUT_BASICS_TRANSPOSED (faction, levelName, className, lootName, minQuant, maxQuant, prob)
SELECT faction, levelName, 'mech', lootName, CEILING(mechQuant*0.8), mechQuant, prob
FROM #LOOT_SHEET_OUTPUT_BASICS;

INSERT INTO #LOOT_SHEET_OUTPUT_BASICS_TRANSPOSED (faction, levelName, className, lootName, minQuant, maxQuant, prob)
SELECT faction, levelName, 'mech ewar', lootName, CEILING(mechEwQuant*0.8), mechEwQuant, prob
FROM #LOOT_SHEET_OUTPUT_BASICS;

INSERT INTO #LOOT_SHEET_OUTPUT_BASICS_TRANSPOSED (faction, levelName, className, lootName, minQuant, maxQuant, prob)
SELECT faction, levelName, 'heavy mech', lootName, CEILING(heavyQuant*0.8), heavyQuant, prob
FROM #LOOT_SHEET_OUTPUT_BASICS;

UPDATE #LOOT_SHEET_OUTPUT_BASICS_TRANSPOSED SET
	minQuant = 1
WHERE lootName LIKE 'def_robotshard_%';


DROP TABLE IF EXISTS #LOOT_SHEET_OUTPUT_MODULES;
CREATE TABLE #LOOT_SHEET_OUTPUT_MODULES(
	faction varchar(64),
	className varchar(32),
	lootName varchar(128),
	minQuant int,
	maxQuant int,
	level7prob float,
	level6prob float,
	level5prob float,
	level4prob float,
	level3prob float
);
INSERT INTO #LOOT_SHEET_OUTPUT_MODULES (faction, className, lootName, minQuant, maxQuant, level7prob, level6prob, level5prob, level4prob, level3prob) VALUES
--'Thelodica' 'Light','min' 'qty','max' 'qty','l7' 'chance','l6' 'chance','l5' 'chance','l4' 'chance','l3' 'chance'),
('thelodica','light', 'def_named3_kin_armor_hardener',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','light', 'def_named3_damage_mod_laser',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','light', 'def_named3_resistant_plating',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','light', 'def_named3_small_armor_plate',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','light', 'def_named3_small_laser',1,2,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','light', 'def_named2_kin_armor_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','light', 'def_named2_damage_mod_laser',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','light', 'def_named2_resistant_plating',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','light', 'def_named2_small_armor_plate',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','light', 'def_named2_small_laser',1,2,0.124,0.084,0.059,0.035,0.018),
('thelodica','light', 'def_named1_kin_armor_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('thelodica','light', 'def_named1_damage_mod_laser',1,1,0.165,0.125,0.088,0.053,0.027),
('thelodica','light', 'def_named1_resistant_plating',1,1,0.165,0.125,0.088,0.053,0.027),
('thelodica','light', 'def_named1_small_armor_plate',1,1,0.165,0.125,0.088,0.053,0.027),
('thelodica','light', 'def_named1_small_laser',1,2,0.165,0.125,0.088,0.053,0.027),
('thelodica','light', 'def_standard_kin_armor_hardener',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','light', 'def_standard_damage_mod_laser',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','light', 'def_standard_resistant_plating',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','light', 'def_standard_small_armor_plate',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','light', 'def_standard_small_laser',1,2,0.35,0.35,0.35,0.35,0.35),
('thelodica','light', 'def_ammo_small_lasercrystal_b',10,200,0.35,0.35,0.35,0.35,0.35),
('thelodica','light', 'def_ammo_small_lasercrystal_d',10,200,0.35,0.35,0.35,0.35,0.35),
('thelodica','light', 'def_named2_sensor_booster',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','light', 'def_named2_webber',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','light', 'def_named1_sensor_booster',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','light', 'def_named1_webber',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','light', 'def_named1_small_armor_repairer',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','light', 'def_standard_sensor_booster',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','light', 'def_standard_webber',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','light', 'def_standard_small_armor_repairer',1,1,0.35,0.35,0.35,0.35,0.35),
-- 'Thelodica' 'Medium' 'Combat','min' 'qty','max' 'qty','l7' 'chance','l6' 'chance','l5' 'chance','l4' 'chance','l3' 'chance'),
('thelodica','mech', 'def_named3_kin_armor_hardener',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','mech', 'def_named3_damage_mod_laser',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','mech', 'def_named3_resistant_plating',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','mech', 'def_named3_medium_armor_plate',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','mech', 'def_named2_kin_armor_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','mech', 'def_named2_resistant_plating',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','mech', 'def_named2_damage_mod_laser',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','mech', 'def_named2_medium_armor_plate',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','mech', 'def_named1_kin_armor_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('thelodica','mech', 'def_named1_damage_mod_laser',1,1,0.165,0.125,0.088,0.053,0.027),
('thelodica','mech', 'def_named1_resistant_plating',1,1,0.165,0.125,0.088,0.053,0.027),
('thelodica','mech', 'def_named1_medium_armor_plate',1,1,0.165,0.125,0.088,0.053,0.027),
('thelodica','mech', 'def_standard_tracking_upgrade',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','mech', 'def_standard_medium_armor_plate',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','mech', 'def_standard_resistant_plating',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','mech', 'def_named3_medium_laser',1,2,0.0495,0.0095,0.007,0.004,NULL),
('thelodica','mech', 'def_named3_longrange_medium_laser',1,2,0.0495,0.0095,0.007,0.004,NULL),
('thelodica','mech', 'def_named2_medium_laser',1,2,0.0992,0.0592,0.041,0.025,0.013),
('thelodica','mech', 'def_named2_longrange_medium_laser',1,2,0.0992,0.0592,0.041,0.025,0.013),
('thelodica','mech', 'def_named1_medium_laser',1,2,0.132,0.092,0.064,0.038,0.019),
('thelodica','mech', 'def_named1_longrange_medium_laser',1,2,0.132,0.092,0.064,0.038,0.019),
('thelodica','mech', 'def_standard_medium_laser',1,2,0.25,0.25,0.25,0.25,0.25),
('thelodica','mech', 'def_longrange_standard_medium_laser',1,2,0.25,0.25,0.25,0.25,0.25),
('thelodica','mech', 'def_ammo_medium_lasercrystal_b',8,120,0.35,0.35,0.35,0.35,0.35),
('thelodica','mech', 'def_ammo_medium_lasercrystal_d',8,120,0.35,0.35,0.35,0.35,0.35),
('thelodica','mech', 'def_named2_tracking_upgrade',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','mech', 'def_named2_sensor_booster',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','mech', 'def_named1_tracking_upgrade',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','mech', 'def_named1_sensor_booster',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','mech', 'def_named1_medium_armor_repairer',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','mech', 'def_standard_sensor_booster',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','mech', 'def_standard_medium_armor_repairer',1,1,0.35,0.35,0.35,0.35,0.35),

('thelodica','heavy mech', 'def_named3_kin_armor_hardener',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','heavy mech', 'def_named3_damage_mod_laser',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','heavy mech', 'def_named3_resistant_plating',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','heavy mech', 'def_named3_medium_armor_plate',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','heavy mech', 'def_named2_kin_armor_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','heavy mech', 'def_named2_resistant_plating',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','heavy mech', 'def_named2_damage_mod_laser',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','heavy mech', 'def_named2_medium_armor_plate',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','heavy mech', 'def_named1_kin_armor_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('thelodica','heavy mech', 'def_named1_damage_mod_laser',1,1,0.165,0.125,0.088,0.053,0.027),
('thelodica','heavy mech', 'def_named1_resistant_plating',1,1,0.165,0.125,0.088,0.053,0.027),
('thelodica','heavy mech', 'def_named1_medium_armor_plate',1,1,0.165,0.125,0.088,0.053,0.027),
('thelodica','heavy mech', 'def_standard_tracking_upgrade',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','heavy mech', 'def_standard_medium_armor_plate',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','heavy mech', 'def_standard_resistant_plating',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','heavy mech', 'def_named3_medium_laser',1,2,0.0495,0.0095,0.007,0.004,NULL),
('thelodica','heavy mech', 'def_named3_longrange_medium_laser',1,2,0.0495,0.0095,0.007,0.004,NULL),
('thelodica','heavy mech', 'def_named2_medium_laser',1,2,0.0992,0.0592,0.041,0.025,0.013),
('thelodica','heavy mech', 'def_named2_longrange_medium_laser',1,2,0.0992,0.0592,0.041,0.025,0.013),
('thelodica','heavy mech', 'def_named1_medium_laser',1,2,0.132,0.092,0.064,0.038,0.019),
('thelodica','heavy mech', 'def_named1_longrange_medium_laser',1,2,0.132,0.092,0.064,0.038,0.019),
('thelodica','heavy mech', 'def_standard_medium_laser',1,2,0.25,0.25,0.25,0.25,0.25),
('thelodica','heavy mech', 'def_longrange_standard_medium_laser',1,2,0.25,0.25,0.25,0.25,0.25),
('thelodica','heavy mech', 'def_ammo_medium_lasercrystal_b',8,120,0.35,0.35,0.35,0.35,0.35),
('thelodica','heavy mech', 'def_ammo_medium_lasercrystal_d',8,120,0.35,0.35,0.35,0.35,0.35),
('thelodica','heavy mech', 'def_named2_tracking_upgrade',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','heavy mech', 'def_named2_sensor_booster',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','heavy mech', 'def_named1_tracking_upgrade',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','heavy mech', 'def_named1_sensor_booster',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','heavy mech', 'def_named1_medium_armor_repairer',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','heavy mech', 'def_standard_sensor_booster',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','heavy mech', 'def_standard_medium_armor_repairer',1,1,0.35,0.35,0.35,0.35,0.35),

--'Thelodica' 'Small' 'EW','min' 'qty','max' 'qty','l7' 'chance','l6' 'chance','l5' 'chance','l4' 'chance','l3' 'chance'),
('thelodica','light ewar', 'def_named3_sensor_supressor_booster',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','light ewar', 'def_named3_sensor_dampener',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','light ewar', 'def_named2_sensor_dampener',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','light ewar', 'def_named2_sensor_supressor_booster',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','light ewar', 'def_named2_kin_armor_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','light ewar', 'def_named2_small_armor_plate',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','light ewar', 'def_named1_sensor_supressor_booster',1,1,0.165,0.125,0.088,0.053,0.027),
('thelodica','light ewar', 'def_named1_sensor_dampener',1,1,0.165,0.125,0.088,0.053,0.027),
('thelodica','light ewar', 'def_named1_kin_armor_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('thelodica','light ewar', 'def_named1_small_armor_plate',1,1,0.165,0.125,0.088,0.053,0.027),
('thelodica','light ewar', 'def_standard_kin_armor_hardener',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','light ewar', 'def_standard_small_armor_plate',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','light ewar', 'def_standard_sensor_supressor_booster',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','light ewar', 'def_standard_sensor_dampener',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','light ewar', 'def_named2_mass_reductor',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','light ewar', 'def_named2_webber',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','light ewar', 'def_named1_mass_reductor',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','light ewar', 'def_named1_webber',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','light ewar', 'def_named1_sensor_jammer',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','light ewar', 'def_standard_webber',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','light ewar', 'def_standard_sensor_jammer',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','light ewar', 'def_standard_mass_reductor',1,1,0.35,0.35,0.35,0.35,0.35),
--'Thelodica' 'Medium' 'EW','min' 'qty','max' 'qty','l7' 'chance','l6' 'chance','l5' 'chance','l4' 'chance','l3' 'chance'),
('thelodica','mech ewar', 'def_named3_sensor_supressor_booster',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','mech ewar', 'def_named3_sensor_dampener',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','mech ewar', 'def_named2_sensor_dampener',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','mech ewar', 'def_named2_sensor_supressor_booster',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','mech ewar', 'def_named2_kin_armor_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','mech ewar', 'def_named2_medium_armor_plate',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','mech ewar', 'def_named1_sensor_supressor_booster',1,1,0.165,0.125,0.088,0.053,0.027),
('thelodica','mech ewar', 'def_named1_sensor_dampener',1,1,0.165,0.125,0.088,0.053,0.027),
('thelodica','mech ewar', 'def_named1_kin_armor_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('thelodica','mech ewar', 'def_named1_medium_armor_plate',1,1,0.165,0.125,0.088,0.053,0.027),
('thelodica','mech ewar', 'def_standard_kin_armor_hardener',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','mech ewar', 'def_standard_medium_armor_plate',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','mech ewar', 'def_standard_sensor_supressor_booster',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','mech ewar', 'def_standard_sensor_dampener',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','mech ewar', 'def_named2_mass_reductor',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','mech ewar', 'def_named2_webber',1,1,0.0825,0.0425,0.03,0.018,NULL),
('thelodica','mech ewar', 'def_named1_mass_reductor',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','mech ewar', 'def_named1_webber',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','mech ewar', 'def_named1_sensor_jammer',1,1,0.124,0.084,0.059,0.035,0.018),
('thelodica','mech ewar', 'def_standard_webber',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','mech ewar', 'def_standard_sensor_jammer',1,1,0.35,0.35,0.35,0.35,0.35),
('thelodica','mech ewar', 'def_standard_mass_reductor',1,1,0.35,0.35,0.35,0.35,0.35),
-- 'Nuimqol' 'Light','min' 'qty','max' 'qty','l7' 'chance','l6' 'chance','l5' 'chance','l4' 'chance','l3' 'chance'),
('nuimqol','light', 'def_named3_exp_armor_hardener',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','light', 'def_named3_damage_mod_railgun',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','light', 'def_named3_small_armor_repairer',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','light', 'def_named3_small_railgun',1,2,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','light', 'def_named2_exp_armor_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','light', 'def_named2_damage_mod_railgun',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','light', 'def_named2_small_armor_repairer',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','light', 'def_named2_small_railgun',1,2,0.124,0.084,0.059,0.035,0.018),
('nuimqol','light', 'def_named1_exp_armor_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('nuimqol','light', 'def_named1_damage_mod_railgun',1,1,0.165,0.125,0.088,0.053,0.027),
('nuimqol','light', 'def_named1_small_armor_repairer',1,1,0.165,0.125,0.088,0.053,0.027),
('nuimqol','light', 'def_named1_small_railgun',1,2,0.165,0.125,0.088,0.053,0.027),
('nuimqol','light', 'def_standard_exp_armor_hardener',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','light', 'def_standard_damage_mod_railgun',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','light', 'def_standard_small_armor_repairer',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','light', 'def_standard_small_railgun',1,2,0.35,0.35,0.35,0.35,0.35),
('nuimqol','light', 'def_ammo_small_railgun_a',10,150,0.35,0.35,0.35,0.35,0.35),
('nuimqol','light', 'def_ammo_small_railgun_d',10,150,0.35,0.35,0.35,0.35,0.35),
('nuimqol','light', 'def_named2_small_core_booster',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','light', 'def_named2_sensor_booster',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','light', 'def_named2_webber',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','light', 'def_named1_small_core_booster',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','light', 'def_named1_sensor_booster',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','light', 'def_named1_webber',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','light', 'def_named1_small_armor_plate',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','light', 'def_standard_sensor_booster',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','light', 'def_standard_webber',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','light', 'def_standard_small_core_booster',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','light', 'def_standard_small_armor_plate',1,1,0.35,0.35,0.35,0.35,0.35),
--'Nuimqol' 'Medium' 'Combat','min' 'qty','max' 'qty','l7' 'chance','l6' 'chance','l5' 'chance','l4' 'chance','l3' 'chance'),
('nuimqol','mech', 'def_named3_exp_armor_hardener',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','mech', 'def_named3_damage_mod_railgun',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','mech', 'def_named3_armor_repairer_upgrade',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','mech', 'def_named2_exp_armor_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','mech', 'def_named2_damage_mod_railgun',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','mech', 'def_named2_armor_repairer_upgrade',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','mech', 'def_named1_exp_armor_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('nuimqol','mech', 'def_named1_damage_mod_railgun',1,1,0.165,0.125,0.088,0.053,0.027),
('nuimqol','mech', 'def_named1_armor_repairer_upgrade',1,1,0.165,0.125,0.088,0.053,0.027),
('nuimqol','mech', 'def_standard_armor_repairer_upgrade',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','mech', 'def_standard_exp_armor_hardener',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','mech', 'def_standard_damage_mod_railgun',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','mech', 'def_named3_medium_railgun',1,2,0.0495,0.0095,0.007,0.004,NULL),
('nuimqol','mech', 'def_named3_longrange_medium_railgun',1,2,0.0495,0.0095,0.007,0.004,NULL),
('nuimqol','mech', 'def_named2_medium_railgun',1,2,0.0992,0.0592,0.041,0.025,0.013),
('nuimqol','mech', 'def_named2_longrange_medium_railgun',1,2,0.0992,0.0592,0.041,0.025,0.013),
('nuimqol','mech', 'def_named1_medium_railgun',1,2,0.132,0.092,0.064,0.038,0.019),
('nuimqol','mech', 'def_named1_longrange_medium_railgun',1,2,0.132,0.092,0.064,0.038,0.019),
('nuimqol','mech', 'def_standard_medium_railgun',1,2,0.25,0.25,0.25,0.25,0.25),
('nuimqol','mech', 'def_longrange_standard_medium_railgun',1,2,0.25,0.25,0.25,0.25,0.25),
('nuimqol','mech', 'def_ammo_medium_railgun_a',8,90,0.35,0.35,0.35,0.35,0.35),
('nuimqol','mech', 'def_ammo_medium_railgun_d',8,90,0.35,0.35,0.35,0.35,0.35),
('nuimqol','mech', 'def_named2_sensor_booster',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','mech', 'def_named2_medium_core_booster',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','mech', 'def_named1_sensor_booster',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','mech', 'def_named1_medium_armor_plate',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','mech', 'def_named1_resistant_plating',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','mech', 'def_named1_medium_core_booster',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','mech', 'def_standard_sensor_booster',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','mech', 'def_standard_medium_armor_plate',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','mech', 'def_standard_resistant_plating',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','mech', 'def_standard_medium_core_booster',1,1,0.35,0.35,0.35,0.35,0.35),

('nuimqol','heavy mech', 'def_named3_exp_armor_hardener',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','heavy mech', 'def_named3_damage_mod_railgun',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','heavy mech', 'def_named3_armor_repairer_upgrade',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','heavy mech', 'def_named2_exp_armor_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','heavy mech', 'def_named2_damage_mod_railgun',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','heavy mech', 'def_named2_armor_repairer_upgrade',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','heavy mech', 'def_named1_exp_armor_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('nuimqol','heavy mech', 'def_named1_damage_mod_railgun',1,1,0.165,0.125,0.088,0.053,0.027),
('nuimqol','heavy mech', 'def_named1_armor_repairer_upgrade',1,1,0.165,0.125,0.088,0.053,0.027),
('nuimqol','heavy mech', 'def_standard_armor_repairer_upgrade',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','heavy mech', 'def_standard_exp_armor_hardener',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','heavy mech', 'def_standard_damage_mod_railgun',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','heavy mech', 'def_named3_medium_railgun',1,2,0.0495,0.0095,0.007,0.004,NULL),
('nuimqol','heavy mech', 'def_named3_longrange_medium_railgun',1,2,0.0495,0.0095,0.007,0.004,NULL),
('nuimqol','heavy mech', 'def_named2_medium_railgun',1,2,0.0992,0.0592,0.041,0.025,0.013),
('nuimqol','heavy mech', 'def_named2_longrange_medium_railgun',1,2,0.0992,0.0592,0.041,0.025,0.013),
('nuimqol','heavy mech', 'def_named1_medium_railgun',1,2,0.132,0.092,0.064,0.038,0.019),
('nuimqol','heavy mech', 'def_named1_longrange_medium_railgun',1,2,0.132,0.092,0.064,0.038,0.019),
('nuimqol','heavy mech', 'def_standard_medium_railgun',1,2,0.25,0.25,0.25,0.25,0.25),
('nuimqol','heavy mech', 'def_longrange_standard_medium_railgun',1,2,0.25,0.25,0.25,0.25,0.25),
('nuimqol','heavy mech', 'def_ammo_medium_railgun_a',8,90,0.35,0.35,0.35,0.35,0.35),
('nuimqol','heavy mech', 'def_ammo_medium_railgun_d',8,90,0.35,0.35,0.35,0.35,0.35),
('nuimqol','heavy mech', 'def_named2_sensor_booster',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','heavy mech', 'def_named2_medium_core_booster',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','heavy mech', 'def_named1_sensor_booster',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','heavy mech', 'def_named1_medium_armor_plate',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','heavy mech', 'def_named1_resistant_plating',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','heavy mech', 'def_named1_medium_core_booster',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','heavy mech', 'def_standard_sensor_booster',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','heavy mech', 'def_standard_medium_armor_plate',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','heavy mech', 'def_standard_resistant_plating',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','heavy mech', 'def_standard_medium_core_booster',1,1,0.35,0.35,0.35,0.35,0.35),

-- 'Nuimqol' 'Small' 'EW','min' 'qty','max' 'qty','l7' 'chance','l6' 'chance','l5' 'chance','l4' 'chance','l3' 'chance'),
('nuimqol','light ewar', 'def_named3_ecm_booster',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','light ewar', 'def_named3_sensor_jammer',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','light ewar', 'def_named2_sensor_jammer',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','light ewar', 'def_named2_ecm_booster',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','light ewar', 'def_named2_exp_armor_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','light ewar', 'def_named2_small_armor_repairer',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','light ewar', 'def_named1_ecm_booster',1,1,0.165,0.125,0.088,0.053,0.027),
('nuimqol','light ewar', 'def_named1_sensor_jammer',1,1,0.165,0.125,0.088,0.053,0.027),
('nuimqol','light ewar', 'def_named1_exp_armor_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('nuimqol','light ewar', 'def_named1_small_armor_repairer',1,1,0.165,0.125,0.088,0.053,0.027),
('nuimqol','light ewar', 'def_standard_exp_armor_hardener',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','light ewar', 'def_standard_small_armor_repairer',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','light ewar', 'def_standard_ecm_booster',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','light ewar', 'def_standard_sensor_jammer',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','light ewar', 'def_named2_mass_reductor',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','light ewar', 'def_named2_webber',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','light ewar', 'def_named1_mass_reductor',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','light ewar', 'def_named1_webber',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','light ewar', 'def_named1_sensor_dampener',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','light ewar', 'def_standard_webber',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','light ewar', 'def_standard_sensor_dampener',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','light ewar', 'def_standard_mass_reductor',1,1,0.35,0.35,0.35,0.35,0.35),
-- 'Nuimqol' 'Medium' 'EW','min' 'qty','max' 'qty','l7' 'chance','l6' 'chance','l5' 'chance','l4' 'chance','l3' 'chance'),
('nuimqol','mech ewar', 'def_named3_ecm_booster',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','mech ewar', 'def_named3_sensor_jammer',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','mech ewar', 'def_named2_sensor_jammer',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','mech ewar', 'def_named2_ecm_booster',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','mech ewar', 'def_named2_exp_armor_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','mech ewar', 'def_named2_medium_armor_repairer',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','mech ewar', 'def_named1_ecm_booster',1,1,0.165,0.125,0.088,0.053,0.027),
('nuimqol','mech ewar', 'def_named1_sensor_jammer',1,1,0.165,0.125,0.088,0.053,0.027),
('nuimqol','mech ewar', 'def_named1_exp_armor_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('nuimqol','mech ewar', 'def_named1_medium_armor_repairer',1,1,0.165,0.125,0.088,0.053,0.027),
('nuimqol','mech ewar', 'def_standard_exp_armor_hardener',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','mech ewar', 'def_standard_medium_armor_repairer',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','mech ewar', 'def_standard_ecm_booster',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','mech ewar', 'def_standard_sensor_jammer',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','mech ewar', 'def_named2_mass_reductor',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','mech ewar', 'def_named2_webber',1,1,0.0825,0.0425,0.03,0.018,NULL),
('nuimqol','mech ewar', 'def_named1_mass_reductor',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','mech ewar', 'def_named1_webber',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','mech ewar', 'def_named1_sensor_dampener',1,1,0.124,0.084,0.059,0.035,0.018),
('nuimqol','mech ewar', 'def_standard_webber',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','mech ewar', 'def_standard_sensor_dampener',1,1,0.35,0.35,0.35,0.35,0.35),
('nuimqol','mech ewar', 'def_standard_mass_reductor',1,1,0.35,0.35,0.35,0.35,0.35),
--'Pelistal' 'Light','min' 'qty','max' 'qty','l7' 'chance','l6' 'chance','l5' 'chance','l4' 'chance','l3' 'chance'),
('pelistal','light', 'def_named3_thrm_armor_hardener',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','light', 'def_named3_damage_mod_missile',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','light', 'def_named3_small_shield_generator',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','light', 'def_named3_rocket_launcher',1,2,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','light', 'def_named2_thrm_armor_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','light', 'def_named2_damage_mod_missile',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','light', 'def_named2_small_shield_generator',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','light', 'def_named2_rocket_launcher',1,2,0.124,0.084,0.059,0.035,0.018),
('pelistal','light', 'def_named1_thrm_armor_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('pelistal','light', 'def_named1_damage_mod_missile',1,1,0.165,0.125,0.088,0.053,0.027),
('pelistal','light', 'def_named1_small_shield_generator',1,1,0.165,0.125,0.088,0.053,0.027),
('pelistal','light', 'def_named1_rocket_launcher',1,2,0.165,0.125,0.088,0.053,0.027),
('pelistal','light', 'def_standard_thrm_armor_hardener',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','light', 'def_standard_damage_mod_missile',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','light', 'def_standard_small_shield_generator',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','light', 'def_standard_rocket_launcher',1,2,0.35,0.35,0.35,0.35,0.35),
('pelistal','light', 'def_ammo_rocket_c',6,100,0.35,0.35,0.35,0.35,0.35),
('pelistal','light', 'def_ammo_rocket_d',6,100,0.35,0.35,0.35,0.35,0.35),
('pelistal','light', 'def_named2_small_core_battery',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','light', 'def_named2_sensor_booster',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','light', 'def_named2_webber',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','light', 'def_named1_small_core_battery',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','light', 'def_named1_sensor_booster',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','light', 'def_named1_webber',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','light', 'def_named1_small_armor_repairer',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','light', 'def_standard_sensor_booster',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','light', 'def_standard_webber',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','light', 'def_standard_small_core_battery',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','light', 'def_standard_small_armor_repairer',1,1,0.35,0.35,0.35,0.35,0.35),
--'Pelistal' 'Medium' 'Combat','min' 'qty','max' 'qty','l7' 'chance','l6' 'chance','l5' 'chance','l4' 'chance','l3' 'chance'),
('pelistal','mech', 'def_named3_thrm_armor_hardener',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','mech', 'def_named3_damage_mod_missile',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','mech', 'def_named3_shield_hardener',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','mech', 'def_named2_thrm_armor_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','mech', 'def_named2_damage_mod_missile',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','mech', 'def_named2_shield_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','mech', 'def_named1_thrm_armor_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('pelistal','mech', 'def_named1_damage_mod_missile',1,1,0.165,0.125,0.088,0.053,0.027),
('pelistal','mech', 'def_named1_shield_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('pelistal','mech', 'def_standard_shield_hardener',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','mech', 'def_named3_missile_launcher',1,2,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','mech', 'def_named2_missile_launcher',1,2,0.124,0.084,0.059,0.035,0.018),
('pelistal','mech', 'def_named1_missile_launcher',1,2,0.165,0.125,0.088,0.053,0.027),
('pelistal','mech', 'def_standard_missile_launcher',1,2,0.35,0.35,0.35,0.35,0.35),
('pelistal','mech', 'def_ammo_missile_d',4,35,0.35,0.35,0.35,0.35,0.35),
('pelistal','mech', 'def_ammo_longrange_missile_d',4,35,0.35,0.35,0.35,0.35,0.35),
('pelistal','mech', 'def_ammo_missile_c',4,35,0.35,0.35,0.35,0.35,0.35),
('pelistal','mech', 'def_ammo_longrange_missile_c',4,35,0.35,0.35,0.35,0.35,0.35),
('pelistal','mech', 'def_named2_sensor_booster',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','mech', 'def_named2_medium_core_battery',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','mech', 'def_named1_sensor_booster',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','mech', 'def_named1_medium_armor_repairer',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','mech', 'def_named1_resistant_plating',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','mech', 'def_named1_medium_core_battery',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','mech', 'def_standard_sensor_booster',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','mech', 'def_standard_medium_armor_repairer',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','mech', 'def_standard_resistant_plating',1,2,0.35,0.35,0.35,0.35,0.35),
('pelistal','mech', 'def_standard_medium_core_battery',1,1,0.35,0.35,0.35,0.35,0.35),

('pelistal','heavy mech', 'def_named3_thrm_armor_hardener',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','heavy mech', 'def_named3_damage_mod_missile',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','heavy mech', 'def_named3_shield_hardener',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','heavy mech', 'def_named2_thrm_armor_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','heavy mech', 'def_named2_damage_mod_missile',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','heavy mech', 'def_named2_shield_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','heavy mech', 'def_named1_thrm_armor_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('pelistal','heavy mech', 'def_named1_damage_mod_missile',1,1,0.165,0.125,0.088,0.053,0.027),
('pelistal','heavy mech', 'def_named1_shield_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('pelistal','heavy mech', 'def_standard_shield_hardener',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','heavy mech', 'def_named3_missile_launcher',1,2,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','heavy mech', 'def_named2_missile_launcher',1,2,0.124,0.084,0.059,0.035,0.018),
('pelistal','heavy mech', 'def_named1_missile_launcher',1,2,0.165,0.125,0.088,0.053,0.027),
('pelistal','heavy mech', 'def_standard_missile_launcher',1,2,0.35,0.35,0.35,0.35,0.35),
('pelistal','heavy mech', 'def_ammo_missile_d',4,35,0.35,0.35,0.35,0.35,0.35),
('pelistal','heavy mech', 'def_ammo_longrange_missile_d',4,35,0.35,0.35,0.35,0.35,0.35),
('pelistal','heavy mech', 'def_ammo_missile_c',4,35,0.35,0.35,0.35,0.35,0.35),
('pelistal','heavy mech', 'def_ammo_longrange_missile_c',4,35,0.35,0.35,0.35,0.35,0.35),
('pelistal','heavy mech', 'def_named2_sensor_booster',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','heavy mech', 'def_named2_medium_core_battery',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','heavy mech', 'def_named1_sensor_booster',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','heavy mech', 'def_named1_medium_armor_repairer',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','heavy mech', 'def_named1_resistant_plating',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','heavy mech', 'def_named1_medium_core_battery',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','heavy mech', 'def_standard_sensor_booster',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','heavy mech', 'def_standard_medium_armor_repairer',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','heavy mech', 'def_standard_resistant_plating',1,2,0.35,0.35,0.35,0.35,0.35),
('pelistal','heavy mech', 'def_standard_medium_core_battery',1,1,0.35,0.35,0.35,0.35,0.35),


--'Pelistal' 'Small' 'EW','min' 'qty','max' 'qty','l7' 'chance','l6' 'chance','l5' 'chance','l4' 'chance','l3' 'chance'),
('pelistal','light ewar', 'def_named3_energy_warfare_upgrade',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','light ewar', 'def_named3_small_energy_neutralizer',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','light ewar', 'def_named2_small_energy_neutralizer',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','light ewar', 'def_named2_energy_warfare_upgrade',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','light ewar', 'def_named2_thrm_armor_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','light ewar', 'def_named2_small_shield_generator',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','light ewar', 'def_named1_energy_warfare_upgrade',1,1,0.165,0.125,0.088,0.053,0.027),
('pelistal','light ewar', 'def_named1_small_energy_neutralizer',1,1,0.165,0.125,0.088,0.053,0.027),
('pelistal','light ewar', 'def_named1_thrm_armor_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('pelistal','light ewar', 'def_named1_small_shield_generator',1,1,0.165,0.125,0.088,0.053,0.027),
('pelistal','light ewar', 'def_standard_thrm_armor_hardener',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','light ewar', 'def_standard_small_shield_generator',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','light ewar', 'def_standard_energy_warfare_upgrade',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','light ewar', 'def_standard_small_energy_neutralizer',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','light ewar', 'def_named2_mass_reductor',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','light ewar', 'def_named2_webber',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','light ewar', 'def_named1_small_energy_vampire',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','light ewar', 'def_named1_mass_reductor',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','light ewar', 'def_named1_webber',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','light ewar', 'def_standard_webber',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','light ewar', 'def_standard_mass_reductor',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','light ewar', 'def_standard_small_energy_vampire',1,1,0.35,0.35,0.35,0.35,0.35),
--'Pelistal' 'Medium' 'EW','min' 'qty','max' 'qty','l7' 'chance','l6' 'chance','l5' 'chance','l4' 'chance','l3' 'chance'),
('pelistal','mech ewar', 'def_named3_energy_warfare_upgrade',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','mech ewar', 'def_named3_medium_energy_neutralizer',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','mech ewar', 'def_named2_energy_warfare_upgrade',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','mech ewar', 'def_named2_medium_energy_neutralizer',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','mech ewar', 'def_named2_thrm_armor_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','mech ewar', 'def_named2_medium_shield_generator',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','mech ewar', 'def_named1_energy_warfare_upgrade',1,1,0.165,0.125,0.088,0.053,0.027),
('pelistal','mech ewar', 'def_named1_medium_energy_neutralizer',1,1,0.165,0.125,0.088,0.053,0.027),
('pelistal','mech ewar', 'def_named1_thrm_armor_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('pelistal','mech ewar', 'def_named1_medium_shield_generator',1,1,0.165,0.125,0.088,0.053,0.027),
('pelistal','mech ewar', 'def_standard_thrm_armor_hardener',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','mech ewar', 'def_standard_medium_shield_generator',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','mech ewar', 'def_standard_energy_warfare_upgrade',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','mech ewar', 'def_standard_medium_energy_neutralizer',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','mech ewar', 'def_named2_mass_reductor',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','mech ewar', 'def_named2_webber',1,1,0.0825,0.0425,0.03,0.018,NULL),
('pelistal','mech ewar', 'def_named1_medium_energy_vampire',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','mech ewar', 'def_named1_mass_reductor',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','mech ewar', 'def_named1_webber',1,1,0.124,0.084,0.059,0.035,0.018),
('pelistal','mech ewar', 'def_standard_webber',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','mech ewar', 'def_standard_mass_reductor',1,1,0.35,0.35,0.35,0.35,0.35),
('pelistal','mech ewar', 'def_standard_medium_energy_vampire',1,1,0.35,0.35,0.35,0.35,0.35),
--'Syndicate' 'Light','min' 'qty','max' 'qty','l7' 'chance','l6' 'chance','l5' 'chance','l4' 'chance','l3' 'chance'),
('syndicate','light', 'def_named3_webber',1,1,0.0825,0.0425,0.03,0.018,NULL),
('syndicate','light', 'def_named3_sensor_booster',1,1,0.0825,0.0425,0.03,0.018,NULL),
('syndicate','light', 'def_named3_chm_armor_hardener',1,1,0.0825,0.0425,0.03,0.018,NULL),
('syndicate','light', 'def_named3_damage_mod_projectile',1,1,0.0825,0.0425,0.03,0.018,NULL),
('syndicate','light', 'def_named3_maneuvering_upgrade',1,1,0.0825,0.0425,0.03,0.018,NULL),
('syndicate','light', 'def_named3_small_autocannon',1,2,0.0825,0.0425,0.03,0.018,NULL),
('syndicate','light', 'def_named2_webber',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','light', 'def_named2_sensor_booster',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','light', 'def_named2_chm_armor_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','light', 'def_named2_damage_mod_projectile',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','light', 'def_named2_maneuvering_upgrade',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','light', 'def_named2_small_autocannon',1,2,0.124,0.084,0.059,0.035,0.018),
('syndicate','light', 'def_named1_webber',1,1,0.165,0.125,0.088,0.053,0.027),
('syndicate','light', 'def_named1_sensor_booster',1,1,0.165,0.125,0.088,0.053,0.027),
('syndicate','light', 'def_named1_chm_armor_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('syndicate','light', 'def_named1_damage_mod_projectile',1,1,0.165,0.125,0.088,0.053,0.027),
('syndicate','light', 'def_named1_maneuvering_upgrade',1,1,0.165,0.125,0.088,0.053,0.027),
('syndicate','light', 'def_named1_small_autocannon',1,2,0.165,0.125,0.088,0.053,0.027),
('syndicate','light', 'def_standard_sensor_booster',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','light', 'def_standard_webber',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','light', 'def_standard_chm_armor_hardener',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','light', 'def_standard_damage_mod_projectile',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','light', 'def_standard_maneuvering_upgrade',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','light', 'def_standard_small_autocannon',1,2,0.35,0.35,0.35,0.35,0.35),
('syndicate','light', 'def_ammo_small_projectile_b',10,250,0.35,0.35,0.35,0.35,0.35),
('syndicate','light', 'def_ammo_small_projectile_d',10,250,0.35,0.35,0.35,0.35,0.35),
('syndicate','light', 'def_named1_small_armor_plate',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','light', 'def_named1_small_armor_repairer',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','light', 'def_standard_small_armor_plate',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','light', 'def_standard_small_armor_repairer',1,1,0.35,0.35,0.35,0.35,0.35),
--'Syndicate' 'Medium' 'Combat','min' 'qty','max' 'qty','l7' 'chance','l6' 'chance','l5' 'chance','l4' 'chance','l3' 'chance'),
('syndicate','mech', 'def_named3_chm_armor_hardener',1,1,0.0825,0.0425,0.03,0.018,NULL),
('syndicate','mech', 'def_named3_sensor_booster',1,1,0.0825,0.0425,0.03,0.018,NULL),
('syndicate','mech', 'def_named3_damage_mod_projectile',1,1,0.0825,0.0425,0.03,0.018,NULL),
('syndicate','mech', 'def_named2_chm_armor_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','mech', 'def_named2_sensor_booster',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','mech', 'def_named2_damage_mod_projectile',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','mech', 'def_named1_chm_armor_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('syndicate','mech', 'def_named1_sensor_booster',1,1,0.165,0.125,0.088,0.053,0.027),
('syndicate','mech', 'def_named1_damage_mod_projectile',1,1,0.165,0.125,0.088,0.053,0.027),
('syndicate','mech', 'def_standard_chm_armor_hardener',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','mech', 'def_standard_sensor_booster',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','mech', 'def_standard_damage_mod_projectile',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','mech', 'def_named3_medium_autocannon',1,2,0.0495,0.0095,0.007,0.004,NULL),
('syndicate','mech', 'def_named3_longrange_medium_autocannon',1,2,0.0495,0.0095,0.007,0.004,NULL),
('syndicate','mech', 'def_named2_medium_autocannon',1,2,0.0992,0.0592,0.041,0.025,0.013),
('syndicate','mech', 'def_named2_longrange_medium_autocannon',1,2,0.0992,0.0592,0.041,0.025,0.013),
('syndicate','mech', 'def_named1_medium_autocannon',1,2,0.132,0.092,0.064,0.038,0.019),
('syndicate','mech', 'def_named1_longrange_medium_autocannon',1,2,0.132,0.092,0.064,0.038,0.019),
('syndicate','mech', 'def_standard_medium_autocannon',1,2,0.25,0.25,0.25,0.25,0.25),
('syndicate','mech', 'def_longrange_standard_medium_autocannon',1,2,0.25,0.25,0.25,0.25,0.25),
('syndicate','mech', 'def_ammo_medium_projectile_b',8,160,0.35,0.35,0.35,0.35,0.35),
('syndicate','mech', 'def_ammo_medium_projectile_d',8,160,0.35,0.35,0.35,0.35,0.35),
('syndicate','mech', 'def_named1_armor_repairer_upgrade',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','mech', 'def_named1_medium_armor_plate',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','mech', 'def_named1_resistant_plating',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','mech', 'def_named1_medium_armor_repairer',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','mech', 'def_named1_tracking_upgrade',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','mech', 'def_standard_armor_repairer_upgrade',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','mech', 'def_standard_medium_armor_plate',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','mech', 'def_standard_resistant_plating',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','mech', 'def_standard_medium_armor_repairer',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','mech', 'def_standard_tracking_upgrade',1,1,0.35,0.35,0.35,0.35,0.35),

('syndicate','heavy mech', 'def_named3_chm_armor_hardener',1,1,0.0825,0.0425,0.03,0.018,NULL),
('syndicate','heavy mech', 'def_named3_sensor_booster',1,1,0.0825,0.0425,0.03,0.018,NULL),
('syndicate','heavy mech', 'def_named3_damage_mod_projectile',1,1,0.0825,0.0425,0.03,0.018,NULL),
('syndicate','heavy mech', 'def_named2_chm_armor_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','heavy mech', 'def_named2_sensor_booster',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','heavy mech', 'def_named2_damage_mod_projectile',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','heavy mech', 'def_named1_chm_armor_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('syndicate','heavy mech', 'def_named1_sensor_booster',1,1,0.165,0.125,0.088,0.053,0.027),
('syndicate','heavy mech', 'def_named1_damage_mod_projectile',1,1,0.165,0.125,0.088,0.053,0.027),
('syndicate','heavy mech', 'def_standard_chm_armor_hardener',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','heavy mech', 'def_standard_sensor_booster',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','heavy mech', 'def_standard_damage_mod_projectile',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','heavy mech', 'def_named3_medium_autocannon',1,2,0.0495,0.0095,0.007,0.004,NULL),
('syndicate','heavy mech', 'def_named3_longrange_medium_autocannon',1,2,0.0495,0.0095,0.007,0.004,NULL),
('syndicate','heavy mech', 'def_named2_medium_autocannon',1,2,0.0992,0.0592,0.041,0.025,0.013),
('syndicate','heavy mech', 'def_named2_longrange_medium_autocannon',1,2,0.0992,0.0592,0.041,0.025,0.013),
('syndicate','heavy mech', 'def_named1_medium_autocannon',1,2,0.132,0.092,0.064,0.038,0.019),
('syndicate','heavy mech', 'def_named1_longrange_medium_autocannon',1,2,0.132,0.092,0.064,0.038,0.019),
('syndicate','heavy mech', 'def_standard_medium_autocannon',1,2,0.25,0.25,0.25,0.25,0.25),
('syndicate','heavy mech', 'def_longrange_standard_medium_autocannon',1,2,0.25,0.25,0.25,0.25,0.25),
('syndicate','heavy mech', 'def_ammo_medium_projectile_b',8,160,0.35,0.35,0.35,0.35,0.35),
('syndicate','heavy mech', 'def_ammo_medium_projectile_d',8,160,0.35,0.35,0.35,0.35,0.35),
('syndicate','heavy mech', 'def_named1_armor_repairer_upgrade',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','heavy mech', 'def_named1_medium_armor_plate',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','heavy mech', 'def_named1_resistant_plating',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','heavy mech', 'def_named1_medium_armor_repairer',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','heavy mech', 'def_named1_tracking_upgrade',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','heavy mech', 'def_standard_armor_repairer_upgrade',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','heavy mech', 'def_standard_medium_armor_plate',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','heavy mech', 'def_standard_resistant_plating',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','heavy mech', 'def_standard_medium_armor_repairer',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','heavy mech', 'def_standard_tracking_upgrade',1,1,0.35,0.35,0.35,0.35,0.35),

--'Syndicate' 'Small' 'EW','min' 'qty','max' 'qty','l7' 'chance','l6' 'chance','l5' 'chance','l4' 'chance','l3' 'chance'),
('syndicate','light ewar', 'def_named3_maneuvering_upgrade',1,1,0.0825,0.0425,0.03,0.018,NULL),
('syndicate','light ewar', 'def_named3_mass_reductor',1,1,0.0825,0.0425,0.03,0.018,NULL),
('syndicate','light ewar', 'def_named3_webber',1,1,0.0825,0.0425,0.03,0.018,NULL),
('syndicate','light ewar', 'def_named2_webber',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','light ewar', 'def_named2_maneuvering_upgrade',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','light ewar', 'def_named2_mass_reductor',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','light ewar', 'def_named2_chm_armor_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','light ewar', 'def_named2_small_armor_repairer',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','light ewar', 'def_named1_maneuvering_upgrade',1,1,0.165,0.125,0.088,0.053,0.027),
('syndicate','light ewar', 'def_named1_webber',1,1,0.165,0.125,0.088,0.053,0.027),
('syndicate','light ewar', 'def_named1_mass_reductor',1,1,0.165,0.125,0.088,0.053,0.027),
('syndicate','light ewar', 'def_named1_chm_armor_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('syndicate','light ewar', 'def_named1_small_armor_repairer',1,1,0.165,0.125,0.088,0.053,0.027),
('syndicate','light ewar', 'def_standard_chm_armor_hardener',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','light ewar', 'def_standard_small_armor_repairer',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','light ewar', 'def_standard_maneuvering_upgrade',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','light ewar', 'def_standard_mass_reductor',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','light ewar', 'def_standard_webber',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','light ewar', 'def_named1_sensor_jammer',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','light ewar', 'def_named1_sensor_dampener',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','light ewar', 'def_standard_sensor_jammer',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','light ewar', 'def_standard_sensor_dampener',1,1,0.35,0.35,0.35,0.35,0.35),
--'Syndicate' 'Medium' 'EW','min' 'qty','max' 'qty','l7' 'chance','l6' 'chance','l5' 'chance','l4' 'chance','l3' 'chance'),
('syndicate','mech ewar', 'def_named3_blob_emission_modulator',1,1,0.0825,0.0425,0.03,0.018,NULL),
('syndicate','mech ewar', 'def_named3_mass_reductor',1,1,0.0825,0.0425,0.03,0.018,NULL),
('syndicate','mech ewar', 'def_named3_webber',1,1,0.0825,0.0425,0.03,0.018,NULL),
('syndicate','mech ewar', 'def_named2_mass_reductor',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','mech ewar', 'def_named2_webber',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','mech ewar', 'def_named2_blob_emission_modulator',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','mech ewar', 'def_named2_chm_armor_hardener',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','mech ewar', 'def_named1_mass_reductor',1,1,0.165,0.125,0.088,0.053,0.027),
('syndicate','mech ewar', 'def_named1_webber',1,1,0.165,0.125,0.088,0.053,0.027),
('syndicate','mech ewar', 'def_named1_blob_emission_modulator',1,1,0.165,0.125,0.088,0.053,0.027),
('syndicate','mech ewar', 'def_named1_chm_armor_hardener',1,1,0.165,0.125,0.088,0.053,0.027),
('syndicate','mech ewar', 'def_standard_chm_armor_hardener',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','mech ewar', 'def_standard_webber',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','mech ewar', 'def_standard_blob_emission_modulator',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','mech ewar', 'def_standard_mass_reductor',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','mech ewar', 'def_named1_medium_shield_generator',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','mech ewar', 'def_named1_sensor_dampener',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','mech ewar', 'def_named1_sensor_jammer',1,1,0.124,0.084,0.059,0.035,0.018),
('syndicate','mech ewar', 'def_standard_medium_shield_generator',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','mech ewar', 'def_standard_sensor_jammer',1,1,0.35,0.35,0.35,0.35,0.35),
('syndicate','mech ewar', 'def_standard_sensor_dampener',1,1,0.35,0.35,0.35,0.35,0.35)
;



DROP TABLE IF EXISTS #LOOT_BY_NPC;
CREATE TABLE #LOOT_BY_NPC(
	npcName varchar(128),
	lootName varchar(128),
	minQuant int,
	maxQuant int,
	prob float
);
INSERT INTO #LOOT_BY_NPC (npcName, lootName, minQuant, maxQuant, prob)
SELECT n.npcName, loot.lootName, loot.minQuant, loot.maxQuant, 1.0
FROM #NPCS_BY_FACTION_BY_LEVEL n
JOIN #LOOT_SHEET_OUTPUT_BASICS_TRANSPOSED loot ON
	loot.levelName=n.levelName AND loot.faction=n.faction AND loot.className=n.className;


INSERT INTO #LOOT_BY_NPC (npcName, lootName, minQuant, maxQuant, prob)
SELECT n.npcName, loot.lootName, loot.minQuant, loot.maxQuant, loot.level7prob
FROM #NPCS_BY_FACTION_BY_LEVEL n
JOIN #LOOT_SHEET_OUTPUT_MODULES loot ON loot.faction=n.faction AND loot.className=n.className
WHERE n.levelName='l7' AND loot.level7prob IS NOT NULL;

INSERT INTO #LOOT_BY_NPC (npcName, lootName, minQuant, maxQuant, prob)
SELECT n.npcName, loot.lootName, loot.minQuant, loot.maxQuant, loot.level6prob
FROM #NPCS_BY_FACTION_BY_LEVEL n
JOIN #LOOT_SHEET_OUTPUT_MODULES loot ON loot.faction=n.faction AND loot.className=n.className
WHERE n.levelName='l6' AND loot.level6prob IS NOT NULL;

INSERT INTO #LOOT_BY_NPC (npcName, lootName, minQuant, maxQuant, prob)
SELECT n.npcName, loot.lootName, loot.minQuant, loot.maxQuant, loot.level5prob
FROM #NPCS_BY_FACTION_BY_LEVEL n
JOIN #LOOT_SHEET_OUTPUT_MODULES loot ON loot.faction=n.faction AND loot.className=n.className
WHERE n.levelName='l5' AND loot.level5prob IS NOT NULL;

INSERT INTO #LOOT_BY_NPC (npcName, lootName, minQuant, maxQuant, prob)
SELECT n.npcName, loot.lootName, loot.minQuant, loot.maxQuant, loot.level4prob
FROM #NPCS_BY_FACTION_BY_LEVEL n
JOIN #LOOT_SHEET_OUTPUT_MODULES loot ON loot.faction=n.faction AND loot.className=n.className
WHERE n.levelName='l4' AND loot.level4prob IS NOT NULL;

INSERT INTO #LOOT_BY_NPC (npcName, lootName, minQuant, maxQuant, prob)
SELECT n.npcName, loot.lootName, loot.minQuant, loot.maxQuant, loot.level3prob
FROM #NPCS_BY_FACTION_BY_LEVEL n
JOIN #LOOT_SHEET_OUTPUT_MODULES loot ON loot.faction=n.faction AND loot.className=n.className
WHERE n.levelName='l3' AND loot.level3prob IS NOT NULL;


SELECT * FROM npcloot WHERE definition IN (
	SELECT definition FROM entitydefaults WHERE definitionname in (
		SELECT DISTINCT npcName FROM  #NPCS_BY_FACTION_BY_LEVEL
	)
);

DELETE FROM npcloot WHERE definition IN (
	SELECT definition FROM entitydefaults WHERE definitionname in (
		SELECT DISTINCT npcName FROM  #NPCS_BY_FACTION_BY_LEVEL
	)
);



MERGE [dbo].[npcloot] n USING #LOOT_BY_NPC loot
ON n.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=loot.npcName)
AND n.lootdefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=loot.lootName)
WHEN MATCHED
    THEN UPDATE SET
		n.minquantity = loot.minQuant,
		n.quantity = loot.maxQuant,
		n.probability = loot.prob,
		n.repackaged = 0,
		n.dontdamage = CASE WHEN lootName like '%named%' or lootName like '%standard%' THEN 0 ELSE 1 END
WHEN NOT MATCHED
    THEN INSERT (definition, lootdefinition, quantity, minquantity, probability, dontdamage, repackaged) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=loot.npcName),
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=loot.lootName),
	loot.maxQuant, loot.minQuant, loot.prob, CASE WHEN lootName like '%named%' or lootName like '%standard%' THEN 0 ELSE 1 END, 0);



DROP TABLE IF EXISTS #BOTS_BY_FACTION;
DROP TABLE IF EXISTS #LOOT_BY_NPC;
DROP TABLE IF EXISTS #LOOT_SHEET_OUTPUT_BASICS;
DROP TABLE IF EXISTS #LOOT_SHEET_OUTPUT_BASICS_TRANSPOSED;
DROP TABLE IF EXISTS #LOOT_SHEET_OUTPUT_MODULES;
DROP TABLE IF EXISTS #NPCS_BY_FACTION_BY_LEVEL;
GO

