USE [perpetuumsa]
GO

--------------------------------------------------------------------------
-- Stronghold zone 71+72 npc loot!
-- Date: 2021/03/31
--------------------------------------------------------------------------


PRINT N'SET ALL NPC LOOT FOR NPC STRONGHOLD';
DROP TABLE IF EXISTS #LOOT;
CREATE TABLE #LOOT(
	npcName VARCHAR(100),
	lootName VARCHAR(100),
	minQuantity FLOAT,
	maxQuantity FLOAT,
	probability FLOAT DEFAULT(1.0)
);

INSERT INTO #LOOT (npcName, lootName, minQuantity, maxQuantity, probability) VALUES
('def_npc_Zone71_WilliamHBonnie','def_ammo_small_projectile_a',1000,2000,0.5),
('def_npc_Zone71_WilliamHBonnie','def_ammo_small_projectile_b',1000,2000,0.5),
('def_npc_Zone71_WilliamHBonnie','def_ammo_small_projectile_c',1000,2000,0.5),
('def_npc_Zone71_WilliamHBonnie','def_ammo_small_projectile_d',1000,2000,0.5),

('def_npc_Zone71_WilliamHBonnie','def_named1_damage_mod_projectile',1,1,1),
('def_npc_Zone71_WilliamHBonnie','def_named2_damage_mod_projectile',1,1,0.25),
('def_npc_Zone71_WilliamHBonnie','def_named1_damage_mod_projectile_pr',1,1,0.25),

('def_npc_Zone71_WilliamHBonnie','def_named1_small_autocannon',1,1,1),
('def_npc_Zone71_WilliamHBonnie','def_named2_small_autocannon',1,1,0.25),
('def_npc_Zone71_WilliamHBonnie','def_named1_small_autocannon_pr',1,1,0.25),

('def_npc_Zone71_WilliamHBonnie','def_named1_small_armor_plate',1,1,1),
('def_npc_Zone71_WilliamHBonnie','def_named1_small_armor_repairer',1,1,1),
('def_npc_Zone71_WilliamHBonnie','def_named1_small_shield_generator',1,1,1),

('def_npc_Zone71_WilliamHBonnie','def_material_boss_z71',9,11,1.0),
('def_npc_Zone71_WilliamHBonnie','def_robotshard_common_basic',50,100,1),
('def_npc_Zone71_WilliamHBonnie','def_robotshard_common_advanced',25,75,1),
('def_npc_Zone71_WilliamHBonnie','def_robotshard_common_expert',1,50,1),
('def_npc_Zone71_WilliamHBonnie','def_common_reactor_plasma',9000,10000,1),
('def_npc_Zone71_WilliamHBonnie','def_kernel_common',2500,3000,1),
('def_npc_Zone71_WilliamHBonnie','def_kernel_hitech',500,600,1),
('def_npc_Zone71_WilliamHBonnie','def_boost_ep_t0',1,1,0.25),

('def_npc_Zone72_One_Eye_Josef','def_ammo_medium_projectile_a',1000,2000,0.5),
('def_npc_Zone72_One_Eye_Josef','def_ammo_medium_projectile_b',1000,2000,0.5),
('def_npc_Zone72_One_Eye_Josef','def_ammo_medium_projectile_c',1000,2000,0.5),
('def_npc_Zone72_One_Eye_Josef','def_ammo_medium_projectile_d',1000,2000,0.5),

('def_npc_Zone72_One_Eye_Josef','def_named1_damage_mod_projectile',1,1,1),
('def_npc_Zone72_One_Eye_Josef','def_named2_damage_mod_projectile',1,1,0.25),
('def_npc_Zone72_One_Eye_Josef','def_named1_damage_mod_projectile_pr',1,1,0.25),

('def_npc_Zone72_One_Eye_Josef','def_named1_medium_autocannon',1,1,1),
('def_npc_Zone72_One_Eye_Josef','def_named2_medium_autocannon',1,1,0.25),
('def_npc_Zone72_One_Eye_Josef','def_named1_medium_autocannon_pr',1,1,0.25),

('def_npc_Zone72_One_Eye_Josef','def_named1_medium_armor_plate',1,1,1),
('def_npc_Zone72_One_Eye_Josef','def_named1_medium_armor_repairer',1,1,1),
('def_npc_Zone72_One_Eye_Josef','def_named1_medium_shield_generator',1,1,1),

('def_npc_Zone72_One_Eye_Josef','def_material_boss_z72',9,11,1.0),
('def_npc_Zone72_One_Eye_Josef','def_robotshard_common_basic',100,200,1),
('def_npc_Zone72_One_Eye_Josef','def_robotshard_common_advanced',50,150,1),
('def_npc_Zone72_One_Eye_Josef','def_robotshard_common_expert',1,100,1),
('def_npc_Zone72_One_Eye_Josef','def_common_reactor_plasma',12000,15000,1),
('def_npc_Zone72_One_Eye_Josef','def_kernel_common',3000,3500,1),
('def_npc_Zone72_One_Eye_Josef','def_kernel_hitech',500,600,1),
('def_npc_Zone72_One_Eye_Josef','def_boost_ep_t0',1,1,0.25),

('def_npc_Helix_BossGuard','def_named1_cpu_upgrade',1,1,0.1),
('def_npc_Helix_BossGuard','def_named2_cpu_upgrade',1,1,0.02),
('def_npc_Helix_BossGuard','def_named1_sensor_supressor_booster',1,1,0.1),
('def_npc_Helix_BossGuard','def_named1_sensor_booster',1,1,0.1),
('def_npc_Helix_BossGuard','def_named1_ecm_booster',1,1,0.1),
('def_npc_Helix_BossGuard','def_robotshard_common_basic',10,15,1),
('def_npc_Helix_BossGuard','def_robotshard_common_advanced',5,10,1),
('def_npc_Helix_BossGuard','def_robotshard_common_expert',2,8,1),
('def_npc_Helix_BossGuard','def_common_reactor_plasma',75,99,1),
('def_npc_Helix_BossGuard','def_kernel_common',100,150,1),

('def_npc_Rough_Rider_Death_Dealer','def_named1_powergrid_upgrades',1,1,0.1),
('def_npc_Rough_Rider_Death_Dealer','def_named2_powergrid_upgrades',1,1,0.02),
('def_npc_Rough_Rider_Death_Dealer','def_named1_maneuvering_upgrade',1,1,0.1),
('def_npc_Rough_Rider_Death_Dealer','def_named2_maneuvering_upgrade',1,1,0.02),
('def_npc_Rough_Rider_Death_Dealer','def_robotshard_common_basic',15,20,1),
('def_npc_Rough_Rider_Death_Dealer','def_robotshard_common_advanced',10,15,1),
('def_npc_Rough_Rider_Death_Dealer','def_robotshard_common_expert',5,10,1),
('def_npc_Rough_Rider_Death_Dealer','def_common_reactor_plasma',125,155,1),
('def_npc_Rough_Rider_Death_Dealer','def_kernel_common',150,200,1);

PRINT N'DELETE ALL LOOT TO BE REINSERTED (0 if new)';
DELETE FROM npcloot WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT npcName FROM #LOOT));

PRINT N'UPDATE/INSERT ALL LOOTS';
MERGE npcloot n USING #LOOT o
ON n.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=o.npcName) AND
n.lootdefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=o.lootName)
WHEN MATCHED
    THEN UPDATE SET
		minquantity=o.minQuantity,
		quantity=o.maxQuantity,
		probability=o.probability
WHEN NOT MATCHED
    THEN INSERT (definition, lootdefinition, minquantity, quantity, probability, repackaged, dontdamage) VALUES
		((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=o.npcName),
		(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=o.lootName),
		o.minQuantity, o.maxQuantity, o.probability, 0, 0);



DROP TABLE IF EXISTS #LOOT;
PRINT N'ALL STRONGHOLD PBS NPCS LOOT SET';
GO