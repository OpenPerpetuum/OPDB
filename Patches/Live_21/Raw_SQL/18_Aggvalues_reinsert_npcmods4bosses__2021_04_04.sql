USE [perpetuumsa]
GO

-----------------------------------------------------
-- Alpha static bosses stat tweaks
-- More base HP, less masking
-- Date modified: 2021/04/04
-----------------------------------------------------
PRINT N'DELETE/REINSERT NPC MODIFIERS for some bosses (aggregatevalues)';
DROP TABLE IF EXISTS #NPC_MODS;
CREATE TABLE #NPC_MODS(
	defName VARCHAR(100),
	fieldName VARCHAR(100),
	val FLOAT
);
INSERT INTO #NPC_MODS(defName, fieldName, val) VALUES
('def_npc_WilliamHBonnie','armor_max_modifier',1.5),
('def_npc_WilliamHBonnie','armor_repair_amount_modifier',0.25),
('def_npc_WilliamHBonnie','cpu_max_modifier',2),
('def_npc_WilliamHBonnie','damage_modifier',0.5),
('def_npc_WilliamHBonnie','missile_cycle_time_modifier',1),
('def_npc_WilliamHBonnie','powergrid_max_modifier',2),
('def_npc_WilliamHBonnie','speed_max_modifier',0.5),
('def_npc_WilliamHBonnie','turret_cycle_time_modifier',1),
('def_npc_WilliamHBonnie','received_repaired_modifier',0.1),
('def_npc_WilliamHBonnie','stealth_strength_modifier',-25),

('def_npc_Imperial_Infantry','armor_max_modifier',1.1),
('def_npc_Imperial_Infantry','armor_repair_amount_modifier',0.5),
('def_npc_Imperial_Infantry','cpu_max_modifier',2),
('def_npc_Imperial_Infantry','damage_modifier',0.6),
('def_npc_Imperial_Infantry','missile_cycle_time_modifier',1.2),
('def_npc_Imperial_Infantry','powergrid_max_modifier',2),
('def_npc_Imperial_Infantry','speed_max_modifier',0.4),
('def_npc_Imperial_Infantry','turret_cycle_time_modifier',1.4),
('def_npc_Imperial_Infantry','received_repaired_modifier',0.1),
('def_npc_Imperial_Infantry','stealth_strength_modifier',-25),

('def_npc_Tribal_Member','armor_max_modifier',1.1),
('def_npc_Tribal_Member','armor_repair_amount_modifier',0.5),
('def_npc_Tribal_Member','cpu_max_modifier',2),
('def_npc_Tribal_Member','damage_modifier',0.6),
('def_npc_Tribal_Member','missile_cycle_time_modifier',1.2),
('def_npc_Tribal_Member','powergrid_max_modifier',2),
('def_npc_Tribal_Member','speed_max_modifier',0.4),
('def_npc_Tribal_Member','turret_cycle_time_modifier',1.4),
('def_npc_Tribal_Member','received_repaired_modifier',0.1),
('def_npc_Tribal_Member','stealth_strength_modifier',-25),

('def_npc_Sacrist_Convert','armor_max_modifier',1.1),
('def_npc_Sacrist_Convert','armor_repair_amount_modifier',0.5),
('def_npc_Sacrist_Convert','cpu_max_modifier',2),
('def_npc_Sacrist_Convert','damage_modifier',0.6),
('def_npc_Sacrist_Convert','missile_cycle_time_modifier',1.2),
('def_npc_Sacrist_Convert','powergrid_max_modifier',2),
('def_npc_Sacrist_Convert','speed_max_modifier',0.4),
('def_npc_Sacrist_Convert','turret_cycle_time_modifier',1.4),
('def_npc_Sacrist_Convert','received_repaired_modifier',0.1),
('def_npc_Sacrist_Convert','stealth_strength_modifier',-25),

('def_npc_Sacrist_Mythic','armor_max_modifier',3),
('def_npc_Sacrist_Mythic','core_max_modifier',2),
('def_npc_Sacrist_Mythic','core_recharge_time_modifier',1),
('def_npc_Sacrist_Mythic','cpu_max_modifier',2),
('def_npc_Sacrist_Mythic','damage_modifier',1),
('def_npc_Sacrist_Mythic','falloff_modifier',1),
('def_npc_Sacrist_Mythic','locking_range_modifier',1),
('def_npc_Sacrist_Mythic','locking_time_modifier',1),
('def_npc_Sacrist_Mythic','missile_cycle_time_modifier',1),
('def_npc_Sacrist_Mythic','optimal_range_modifier',1),
('def_npc_Sacrist_Mythic','powergrid_max_modifier',2),
('def_npc_Sacrist_Mythic','turret_cycle_time_modifier',1),
('def_npc_Sacrist_Mythic','received_repaired_modifier',0.1),
('def_npc_Sacrist_Mythic','stealth_strength_modifier',-25),

('def_npc_clan_griffin','armor_max_modifier',3),
('def_npc_clan_griffin','core_max_modifier',2),
('def_npc_clan_griffin','core_recharge_time_modifier',1),
('def_npc_clan_griffin','cpu_max_modifier',2),
('def_npc_clan_griffin','damage_modifier',1),
('def_npc_clan_griffin','falloff_modifier',1),
('def_npc_clan_griffin','locking_range_modifier',1),
('def_npc_clan_griffin','locking_time_modifier',1),
('def_npc_clan_griffin','missile_cycle_time_modifier',1),
('def_npc_clan_griffin','optimal_range_modifier',1),
('def_npc_clan_griffin','powergrid_max_modifier',2),
('def_npc_clan_griffin','turret_cycle_time_modifier',1),
('def_npc_clan_griffin','received_repaired_modifier',0.1),
('def_npc_clan_griffin','stealth_strength_modifier',-25),

('def_npc_tribal_weaver','armor_max_modifier',3),
('def_npc_tribal_weaver','core_max_modifier',2),
('def_npc_tribal_weaver','core_recharge_time_modifier',1),
('def_npc_tribal_weaver','cpu_max_modifier',2),
('def_npc_tribal_weaver','damage_modifier',1),
('def_npc_tribal_weaver','falloff_modifier',1),
('def_npc_tribal_weaver','locking_range_modifier',1),
('def_npc_tribal_weaver','locking_time_modifier',1),
('def_npc_tribal_weaver','missile_cycle_time_modifier',1),
('def_npc_tribal_weaver','optimal_range_modifier',1),
('def_npc_tribal_weaver','powergrid_max_modifier',2),
('def_npc_tribal_weaver','turret_cycle_time_modifier',1),
('def_npc_tribal_weaver','received_repaired_modifier',0.1),
('def_npc_tribal_weaver','stealth_strength_modifier',-25),

('def_npc_One_Eye_Josef','armor_max_modifier',3),
('def_npc_One_Eye_Josef','core_max_modifier',2.5),
('def_npc_One_Eye_Josef','core_recharge_time_modifier',1),
('def_npc_One_Eye_Josef','cpu_max_modifier',2),
('def_npc_One_Eye_Josef','damage_modifier',0.75),
('def_npc_One_Eye_Josef','falloff_modifier',1.5),
('def_npc_One_Eye_Josef','locking_range_modifier',1.25),
('def_npc_One_Eye_Josef','locking_time_modifier',0.75),
('def_npc_One_Eye_Josef','missile_cycle_time_modifier',0.75),
('def_npc_One_Eye_Josef','optimal_range_modifier',1.5),
('def_npc_One_Eye_Josef','powergrid_max_modifier',2),
('def_npc_One_Eye_Josef','turret_cycle_time_modifier',1),
('def_npc_One_Eye_Josef','received_repaired_modifier',0.1),
('def_npc_One_Eye_Josef','stealth_strength_modifier',-25);

PRINT N'DELETE ALL AGG-VALS FOR THESE NPC DEFS';
DELETE FROM aggregatevalues WHERE definition IN (
	SELECT DISTINCT definition FROM entitydefaults WHERE definitionname IN (
		SELECT DISTINCT defName FROM #NPC_MODS
	)
);

PRINT N'RE-INSERT ALL AGG-VALS FOR THESE NPC DEFS';
INSERT INTO aggregatevalues (definition, field, value)
SELECT
	(SELECT TOP 1 definition FROM entitydefaults WHERE defName=definitionname),
	(SELECT TOP 1 id FROM aggregatefields WHERE name=fieldName),
	val
FROM #NPC_MODS;

PRINT N'DONE RE-INSERTING NPC AGG VALUES';
DROP TABLE IF EXISTS #NPC_MODS;
GO