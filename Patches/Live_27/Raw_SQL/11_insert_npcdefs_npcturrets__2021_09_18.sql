USE [perpetuumsa]
GO

-------------------------------------
-- Define new NPC Turrets
--
-- Date modifified: 2021/11/17
-------------------------------------

PRINT N'NEW NPC DEFINTIONS 6094-6109';

DECLARE @armor_max_level0 AS FLOAT = 0.5;
DECLARE @armor_max_level1 AS FLOAT = 0.75;
DECLARE @armor_max_level2 AS FLOAT = 0.9;
DECLARE @armor_max_level3 AS FLOAT = 1.0;

DECLARE @resist_level0 AS INT = 50;
DECLARE @resist_level1 AS INT = 75;
DECLARE @resist_level2 AS INT = 125;
DECLARE @resist_level3 AS INT = 150;
DECLARE @peakResistMod AS FLOAT = 1.5;

DECLARE @turretLockRangeMod AS FLOAT = 1.5;

DECLARE @turretFalloffMod AS FLOAT = 2.0;
DECLARE @turretOptimalMod_level0 AS FLOAT = 0.65;
DECLARE @turretOptimalMod_level1 AS FLOAT = 0.85;
DECLARE @turretOptimalMod_level2 AS FLOAT = 1.05;
DECLARE @turretOptimalMod_level3 AS FLOAT = 1.25;

DECLARE @turretDamageMod_level0 AS FLOAT = 0.5;
DECLARE @turretDamageMod_level1 AS FLOAT = 0.65;
DECLARE @turretDamageMod_level2 AS FLOAT = 0.8;
DECLARE @turretDamageMod_level3 AS FLOAT = 1.0;

DECLARE @turretRepAmountMod_level0 AS FLOAT = 1.0;
DECLARE @turretRepAmountMod_level1 AS FLOAT = 2.0;
DECLARE @turretRepAmountMod_level2 AS FLOAT = 4.0;
DECLARE @turretRepAmountMod_level3 AS FLOAT = 6.0;

DECLARE @turretRepRateMod AS FLOAT = 0.5;

DECLARE @npcDesc AS VARCHAR(MAX) = 'def_npc_pbs_desc';

DROP TABLE IF EXISTS #ENTITYDEFS;
CREATE TABLE #ENTITYDEFS
(
	def INT,
	defName varchar(100),
	catFlags bigint,
	attrFlags bigint,
	cargoVolume float,
	massOfModule float,
	genxyOptStr varchar(max),
	description varchar(max),
);
INSERT INTO #ENTITYDEFS (def, defName, attrFlags, catFlags, cargoVolume, massOfModule, genxyOptStr, description) VALUES
--NPC defs
(6094,'def_npc_pbs_turret_laser_level0', 1024, 911, 0, 0, NULL, @npcDesc),
(6095,'def_npc_pbs_turret_em_level0', 1024, 911, 0, 0, NULL, @npcDesc),
(6096,'def_npc_pbs_turret_missile_level0', 1024, 911, 0, 0, NULL, @npcDesc),
(6097,'def_npc_pbs_turret_ew_level0', 1024, 911, 0, 0, NULL, @npcDesc),
(6098,'def_npc_pbs_turret_laser_level1', 1024, 911, 0, 0, NULL, @npcDesc),
(6099,'def_npc_pbs_turret_em_level1', 1024, 911, 0, 0, NULL, @npcDesc),
(6100,'def_npc_pbs_turret_missile_level1', 1024, 911, 0, 0, NULL, @npcDesc),
(6101,'def_npc_pbs_turret_ew_level1', 1024, 911, 0, 0, NULL, @npcDesc),
(6102,'def_npc_pbs_turret_laser_level2', 1024, 911, 0, 0, NULL, @npcDesc),
(6103,'def_npc_pbs_turret_em_level2', 1024, 911, 0, 0, NULL, @npcDesc),
(6104,'def_npc_pbs_turret_missile_level2', 1024, 911, 0, 0, NULL, @npcDesc),
(6105,'def_npc_pbs_turret_ew_level2', 1024, 911, 0, 0, NULL, @npcDesc),
(6106,'def_npc_pbs_turret_laser_level3', 1024, 911, 0, 0, NULL, @npcDesc),
(6107,'def_npc_pbs_turret_em_level3', 1024, 911, 0, 0, NULL, @npcDesc),
(6108,'def_npc_pbs_turret_missile_level3', 1024, 911, 0, 0, NULL, @npcDesc),
(6109,'def_npc_pbs_turret_ew_level3', 1024, 911, 0, 0, NULL, @npcDesc);


DROP TABLE IF EXISTS #TEMPRELATIONS;
CREATE TABLE #TEMPRELATIONS
(
	defName varchar(100),
	tempName varchar(100),
	epKill INT,
);
INSERT INTO #TEMPRELATIONS (defName, tempName, epKill) VALUES
('def_npc_pbs_turret_laser_level0', 'def_npc_pbs_turret_laser_template', 10),
('def_npc_pbs_turret_em_level0', 'def_npc_pbs_turret_em_temlate', 10),
('def_npc_pbs_turret_missile_level0', 'def_npc_pbs_turret_missile_template', 10),
('def_npc_pbs_turret_ew_level0', 'def_npc_pbs_turret_ew_template', 10),

('def_npc_pbs_turret_laser_level1', 'def_npc_pbs_turret_laser_template', 15),
('def_npc_pbs_turret_em_level1', 'def_npc_pbs_turret_em_temlate', 15),
('def_npc_pbs_turret_missile_level1', 'def_npc_pbs_turret_missile_template', 15),
('def_npc_pbs_turret_ew_level1', 'def_npc_pbs_turret_ew_template', 15),

('def_npc_pbs_turret_laser_level2', 'def_npc_pbs_turret_laser_template', 20),
('def_npc_pbs_turret_em_level2', 'def_npc_pbs_turret_em_temlate', 20),
('def_npc_pbs_turret_missile_level2', 'def_npc_pbs_turret_missile_template', 20),
('def_npc_pbs_turret_ew_level2', 'def_npc_pbs_turret_ew_template', 20),

('def_npc_pbs_turret_laser_level3', 'def_npc_pbs_turret_laser_template', 30),
('def_npc_pbs_turret_em_level3', 'def_npc_pbs_turret_em_temlate', 30),
('def_npc_pbs_turret_missile_level3', 'def_npc_pbs_turret_missile_template', 30),
('def_npc_pbs_turret_ew_level3', 'def_npc_pbs_turret_ew_template', 30);


DROP TABLE IF EXISTS #STATS;
CREATE TABLE #STATS
(
	defName varchar(100),
	fieldName varchar(100),
	fieldValue float,
);
INSERT INTO #STATS (defName, fieldName, fieldValue) VALUES
('def_npc_pbs_base_small_rank1', 'stealth_strength_modifier', -90), --JUST FOR TESTING

('def_npc_pbs_turret_laser_level0', 'armor_max_modifier', @armor_max_level0),
('def_npc_pbs_turret_laser_level0', 'armor_repair_amount_modifier', @turretRepAmountMod_level0),
('def_npc_pbs_turret_laser_level0', 'armor_repair_cycle_time_modifier', @turretRepRateMod),
('def_npc_pbs_turret_laser_level0', 'core_max_modifier',2),
('def_npc_pbs_turret_laser_level0', 'core_recharge_time_modifier',0.5),
('def_npc_pbs_turret_laser_level0', 'damage_modifier', @turretDamageMod_level0),
('def_npc_pbs_turret_laser_level0', 'falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_laser_level0', 'locking_range_modifier', @turretLockRangeMod),
('def_npc_pbs_turret_laser_level0', 'locking_time_modifier', 1.25),
('def_npc_pbs_turret_laser_level0', 'missile_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_laser_level0', 'optimal_range_modifier', @turretOptimalMod_level0),
('def_npc_pbs_turret_laser_level0', 'turret_fallof_modifier', @turretFalloffMod),
('def_npc_pbs_turret_laser_level0', 'resist_chemical',@resist_level0),
('def_npc_pbs_turret_laser_level0', 'resist_explosive', @resist_level0),
('def_npc_pbs_turret_laser_level0', 'resist_kinetic', @resist_level0),
('def_npc_pbs_turret_laser_level0', 'resist_thermal', @resist_level0*@peakResistMod),
('def_npc_pbs_turret_laser_level0', 'turret_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_laser_level0', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_turret_em_level0', 'armor_max_modifier', @armor_max_level0),
('def_npc_pbs_turret_em_level0', 'armor_repair_amount_modifier', @turretRepAmountMod_level0),
('def_npc_pbs_turret_em_level0', 'armor_repair_cycle_time_modifier', @turretRepRateMod),
('def_npc_pbs_turret_em_level0', 'core_max_modifier',2),
('def_npc_pbs_turret_em_level0', 'core_recharge_time_modifier',0.5),
('def_npc_pbs_turret_em_level0', 'damage_modifier', @turretDamageMod_level0),
('def_npc_pbs_turret_em_level0', 'falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_em_level0', 'locking_range_modifier', @turretLockRangeMod),
('def_npc_pbs_turret_em_level0', 'locking_time_modifier', 1.25),
('def_npc_pbs_turret_em_level0', 'missile_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_em_level0', 'optimal_range_modifier', @turretOptimalMod_level0),
('def_npc_pbs_turret_em_level0', 'turret_fallof_modifier', @turretFalloffMod),
('def_npc_pbs_turret_em_level0', 'resist_chemical', @resist_level0),
('def_npc_pbs_turret_em_level0', 'resist_explosive', @resist_level0),
('def_npc_pbs_turret_em_level0', 'resist_kinetic', @resist_level0*@peakResistMod),
('def_npc_pbs_turret_em_level0', 'resist_thermal', @resist_level0),--TODO
('def_npc_pbs_turret_em_level0', 'turret_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_em_level0', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_turret_missile_level0', 'armor_max_modifier', @armor_max_level0),
('def_npc_pbs_turret_missile_level0', 'armor_repair_amount_modifier', @turretRepAmountMod_level0),
('def_npc_pbs_turret_missile_level0', 'armor_repair_cycle_time_modifier', @turretRepRateMod),
('def_npc_pbs_turret_missile_level0', 'core_max_modifier',2),
('def_npc_pbs_turret_missile_level0', 'core_recharge_time_modifier',0.5),
('def_npc_pbs_turret_missile_level0', 'damage_modifier', @turretDamageMod_level0),
('def_npc_pbs_turret_missile_level0', 'falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_missile_level0', 'locking_range_modifier', @turretLockRangeMod),
('def_npc_pbs_turret_missile_level0', 'locking_time_modifier', 1.25),
('def_npc_pbs_turret_missile_level0', 'missile_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_missile_level0', 'effect_missile_range_modifier', 1.1),
('def_npc_pbs_turret_missile_level0', 'optimal_range_modifier', @turretOptimalMod_level0),
('def_npc_pbs_turret_missile_level0', 'missile_falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_missile_level0', 'resist_chemical', @resist_level0),
('def_npc_pbs_turret_missile_level0', 'resist_explosive', @resist_level0*@peakResistMod),
('def_npc_pbs_turret_missile_level0', 'resist_kinetic', @resist_level0),
('def_npc_pbs_turret_missile_level0', 'resist_thermal', @resist_level0),
('def_npc_pbs_turret_missile_level0', 'turret_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_missile_level0', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_turret_ew_level0', 'armor_max_modifier', @armor_max_level0),
('def_npc_pbs_turret_ew_level0', 'armor_repair_amount_modifier', @turretRepAmountMod_level0),
('def_npc_pbs_turret_ew_level0', 'armor_repair_cycle_time_modifier', @turretRepRateMod),
('def_npc_pbs_turret_ew_level0', 'core_max_modifier',2),
('def_npc_pbs_turret_ew_level0', 'core_recharge_time_modifier',0.5),
('def_npc_pbs_turret_ew_level0', 'damage_modifier', @turretDamageMod_level0),
('def_npc_pbs_turret_ew_level0', 'ecm_strength_modifier', @turretDamageMod_level0),
('def_npc_pbs_turret_ew_level0', 'energy_neutralized_amount_modifier', @turretDamageMod_level0),
('def_npc_pbs_turret_ew_level0', 'falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_ew_level0', 'locking_range_modifier', @turretLockRangeMod),
('def_npc_pbs_turret_ew_level0', 'locking_time_modifier', 1.25),
('def_npc_pbs_turret_ew_level0', 'missile_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_ew_level0', 'optimal_range_modifier', @turretOptimalMod_level0),
('def_npc_pbs_turret_ew_level0', 'resist_chemical', @resist_level0*@peakResistMod),
('def_npc_pbs_turret_ew_level0', 'resist_explosive', @resist_level0),
('def_npc_pbs_turret_ew_level0', 'resist_kinetic', @resist_level0),
('def_npc_pbs_turret_ew_level0', 'resist_thermal', @resist_level0),
('def_npc_pbs_turret_ew_level0', 'turret_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_ew_level0', 'received_repaired_modifier', 1.1);

INSERT INTO #STATS (defName, fieldName, fieldValue) VALUES
('def_npc_pbs_turret_laser_level1', 'armor_max_modifier', @armor_max_level1),
('def_npc_pbs_turret_laser_level1', 'armor_repair_amount_modifier', @turretRepAmountMod_level1),
('def_npc_pbs_turret_laser_level1', 'armor_repair_cycle_time_modifier', @turretRepRateMod),
('def_npc_pbs_turret_laser_level1', 'core_max_modifier',2),
('def_npc_pbs_turret_laser_level1', 'core_recharge_time_modifier',0.5),
('def_npc_pbs_turret_laser_level1', 'damage_modifier', @turretDamageMod_level1),
('def_npc_pbs_turret_laser_level1', 'falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_laser_level1', 'locking_range_modifier', @turretLockRangeMod),
('def_npc_pbs_turret_laser_level1', 'locking_time_modifier', 1.25),
('def_npc_pbs_turret_laser_level1', 'missile_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_laser_level1', 'optimal_range_modifier', @turretOptimalMod_level1),
('def_npc_pbs_turret_laser_level1', 'turret_fallof_modifier', @turretFalloffMod),
('def_npc_pbs_turret_laser_level1', 'resist_chemical',@resist_level1),
('def_npc_pbs_turret_laser_level1', 'resist_explosive', @resist_level1),
('def_npc_pbs_turret_laser_level1', 'resist_kinetic', @resist_level1),
('def_npc_pbs_turret_laser_level1', 'resist_thermal', @resist_level1*@peakResistMod),
('def_npc_pbs_turret_laser_level1', 'turret_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_laser_level1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_turret_em_level1', 'armor_max_modifier', @armor_max_level1),
('def_npc_pbs_turret_em_level1', 'armor_repair_amount_modifier', @turretRepAmountMod_level1),
('def_npc_pbs_turret_em_level1', 'armor_repair_cycle_time_modifier', @turretRepRateMod),
('def_npc_pbs_turret_em_level1', 'core_max_modifier',2),
('def_npc_pbs_turret_em_level1', 'core_recharge_time_modifier',0.5),
('def_npc_pbs_turret_em_level1', 'damage_modifier', @turretDamageMod_level1),
('def_npc_pbs_turret_em_level1', 'falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_em_level1', 'locking_range_modifier', @turretLockRangeMod),
('def_npc_pbs_turret_em_level1', 'locking_time_modifier', 1.25),
('def_npc_pbs_turret_em_level1', 'missile_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_em_level1', 'optimal_range_modifier', @turretOptimalMod_level1),
('def_npc_pbs_turret_em_level1', 'turret_fallof_modifier', @turretFalloffMod),
('def_npc_pbs_turret_em_level1', 'resist_chemical', @resist_level1),
('def_npc_pbs_turret_em_level1', 'resist_explosive', @resist_level1),
('def_npc_pbs_turret_em_level1', 'resist_kinetic', @resist_level1*@peakResistMod),
('def_npc_pbs_turret_em_level1', 'resist_thermal', @resist_level1),--TODO
('def_npc_pbs_turret_em_level1', 'turret_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_em_level1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_turret_missile_level1', 'armor_max_modifier', @armor_max_level1),
('def_npc_pbs_turret_missile_level1', 'armor_repair_amount_modifier', @turretRepAmountMod_level1),
('def_npc_pbs_turret_missile_level1', 'armor_repair_cycle_time_modifier', @turretRepRateMod),
('def_npc_pbs_turret_missile_level1', 'core_max_modifier',2),
('def_npc_pbs_turret_missile_level1', 'core_recharge_time_modifier',0.5),
('def_npc_pbs_turret_missile_level1', 'damage_modifier', @turretDamageMod_level1),
('def_npc_pbs_turret_missile_level1', 'falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_missile_level1', 'locking_range_modifier', @turretLockRangeMod),
('def_npc_pbs_turret_missile_level1', 'locking_time_modifier', 1.25),
('def_npc_pbs_turret_missile_level1', 'missile_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_missile_level1', 'effect_missile_range_modifier', 1.1),
('def_npc_pbs_turret_missile_level1', 'optimal_range_modifier', @turretOptimalMod_level1),
('def_npc_pbs_turret_missile_level1', 'missile_falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_missile_level1', 'resist_chemical', @resist_level1),
('def_npc_pbs_turret_missile_level1', 'resist_explosive', @resist_level1*@peakResistMod),
('def_npc_pbs_turret_missile_level1', 'resist_kinetic', @resist_level1),
('def_npc_pbs_turret_missile_level1', 'resist_thermal', @resist_level1),
('def_npc_pbs_turret_missile_level1', 'turret_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_missile_level1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_turret_ew_level1', 'armor_max_modifier', @armor_max_level1),
('def_npc_pbs_turret_ew_level1', 'armor_repair_amount_modifier', @turretRepAmountMod_level1),
('def_npc_pbs_turret_ew_level1', 'armor_repair_cycle_time_modifier', @turretRepRateMod),
('def_npc_pbs_turret_ew_level1', 'core_max_modifier',2),
('def_npc_pbs_turret_ew_level1', 'core_recharge_time_modifier',0.5),
('def_npc_pbs_turret_ew_level1', 'damage_modifier', @turretDamageMod_level1),
('def_npc_pbs_turret_ew_level1', 'ecm_strength_modifier', @turretDamageMod_level1),
('def_npc_pbs_turret_ew_level1', 'energy_neutralized_amount_modifier', @turretDamageMod_level1),
('def_npc_pbs_turret_ew_level1', 'falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_ew_level1', 'locking_range_modifier', @turretLockRangeMod),
('def_npc_pbs_turret_ew_level1', 'locking_time_modifier', 1.25),
('def_npc_pbs_turret_ew_level1', 'missile_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_ew_level1', 'optimal_range_modifier', @turretOptimalMod_level1),
('def_npc_pbs_turret_ew_level1', 'resist_chemical', @resist_level1*@peakResistMod),
('def_npc_pbs_turret_ew_level1', 'resist_explosive', @resist_level1),
('def_npc_pbs_turret_ew_level1', 'resist_kinetic', @resist_level1),
('def_npc_pbs_turret_ew_level1', 'resist_thermal', @resist_level1),
('def_npc_pbs_turret_ew_level1', 'turret_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_ew_level1', 'received_repaired_modifier', 1.1);

INSERT INTO #STATS (defName, fieldName, fieldValue) VALUES
('def_npc_pbs_turret_laser_level2', 'armor_max_modifier', @armor_max_level2),
('def_npc_pbs_turret_laser_level2', 'armor_repair_amount_modifier', @turretRepAmountMod_level2),
('def_npc_pbs_turret_laser_level2', 'armor_repair_cycle_time_modifier', @turretRepRateMod),
('def_npc_pbs_turret_laser_level2', 'core_max_modifier',2),
('def_npc_pbs_turret_laser_level2', 'core_recharge_time_modifier',0.5),
('def_npc_pbs_turret_laser_level2', 'damage_modifier', @turretDamageMod_level2),
('def_npc_pbs_turret_laser_level2', 'falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_laser_level2', 'locking_range_modifier', @turretLockRangeMod),
('def_npc_pbs_turret_laser_level2', 'locking_time_modifier', 1.25),
('def_npc_pbs_turret_laser_level2', 'missile_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_laser_level2', 'optimal_range_modifier', @turretOptimalMod_level2),
('def_npc_pbs_turret_laser_level2', 'turret_fallof_modifier', @turretFalloffMod),
('def_npc_pbs_turret_laser_level2', 'resist_chemical',@resist_level2),
('def_npc_pbs_turret_laser_level2', 'resist_explosive', @resist_level2),
('def_npc_pbs_turret_laser_level2', 'resist_kinetic', @resist_level2),
('def_npc_pbs_turret_laser_level2', 'resist_thermal', @resist_level2*@peakResistMod),
('def_npc_pbs_turret_laser_level2', 'turret_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_laser_level2', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_turret_em_level2', 'armor_max_modifier', @armor_max_level2),
('def_npc_pbs_turret_em_level2', 'armor_repair_amount_modifier', @turretRepAmountMod_level2),
('def_npc_pbs_turret_em_level2', 'armor_repair_cycle_time_modifier', @turretRepRateMod),
('def_npc_pbs_turret_em_level2', 'core_max_modifier',2),
('def_npc_pbs_turret_em_level2', 'core_recharge_time_modifier',0.5),
('def_npc_pbs_turret_em_level2', 'damage_modifier', @turretDamageMod_level2),
('def_npc_pbs_turret_em_level2', 'falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_em_level2', 'locking_range_modifier', @turretLockRangeMod),
('def_npc_pbs_turret_em_level2', 'locking_time_modifier', 1.25),
('def_npc_pbs_turret_em_level2', 'missile_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_em_level2', 'optimal_range_modifier', @turretOptimalMod_level2),
('def_npc_pbs_turret_em_level2', 'turret_fallof_modifier', @turretFalloffMod),
('def_npc_pbs_turret_em_level2', 'resist_chemical', @resist_level2),
('def_npc_pbs_turret_em_level2', 'resist_explosive', @resist_level2),
('def_npc_pbs_turret_em_level2', 'resist_kinetic', @resist_level2*@peakResistMod),
('def_npc_pbs_turret_em_level2', 'resist_thermal', @resist_level2),--TODO
('def_npc_pbs_turret_em_level2', 'turret_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_em_level2', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_turret_missile_level2', 'armor_max_modifier', @armor_max_level2),
('def_npc_pbs_turret_missile_level2', 'armor_repair_amount_modifier', @turretRepAmountMod_level2),
('def_npc_pbs_turret_missile_level2', 'armor_repair_cycle_time_modifier', @turretRepRateMod),
('def_npc_pbs_turret_missile_level2', 'core_max_modifier',2),
('def_npc_pbs_turret_missile_level2', 'core_recharge_time_modifier',0.5),
('def_npc_pbs_turret_missile_level2', 'damage_modifier', @turretDamageMod_level2),
('def_npc_pbs_turret_missile_level2', 'falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_missile_level2', 'locking_range_modifier', @turretLockRangeMod),
('def_npc_pbs_turret_missile_level2', 'locking_time_modifier', 1.25),
('def_npc_pbs_turret_missile_level2', 'missile_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_missile_level2', 'effect_missile_range_modifier', 1.1),
('def_npc_pbs_turret_missile_level2', 'optimal_range_modifier', @turretOptimalMod_level2),
('def_npc_pbs_turret_missile_level2', 'missile_falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_missile_level2', 'resist_chemical', @resist_level2),
('def_npc_pbs_turret_missile_level2', 'resist_explosive', @resist_level2*@peakResistMod),
('def_npc_pbs_turret_missile_level2', 'resist_kinetic', @resist_level2),
('def_npc_pbs_turret_missile_level2', 'resist_thermal', @resist_level2),
('def_npc_pbs_turret_missile_level2', 'turret_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_missile_level2', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_turret_ew_level2', 'armor_max_modifier', @armor_max_level2),
('def_npc_pbs_turret_ew_level2', 'armor_repair_amount_modifier', @turretRepAmountMod_level2),
('def_npc_pbs_turret_ew_level2', 'armor_repair_cycle_time_modifier', @turretRepRateMod),
('def_npc_pbs_turret_ew_level2', 'core_max_modifier',2),
('def_npc_pbs_turret_ew_level2', 'core_recharge_time_modifier',0.5),
('def_npc_pbs_turret_ew_level2', 'damage_modifier', @turretDamageMod_level2),
('def_npc_pbs_turret_ew_level2', 'ecm_strength_modifier', @turretDamageMod_level2),
('def_npc_pbs_turret_ew_level2', 'energy_neutralized_amount_modifier', @turretDamageMod_level2),
('def_npc_pbs_turret_ew_level2', 'falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_ew_level2', 'locking_range_modifier', @turretLockRangeMod),
('def_npc_pbs_turret_ew_level2', 'locking_time_modifier', 1.25),
('def_npc_pbs_turret_ew_level2', 'missile_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_ew_level2', 'optimal_range_modifier', @turretOptimalMod_level2),
('def_npc_pbs_turret_ew_level2', 'resist_chemical', @resist_level2*@peakResistMod),
('def_npc_pbs_turret_ew_level2', 'resist_explosive', @resist_level2),
('def_npc_pbs_turret_ew_level2', 'resist_kinetic', @resist_level2),
('def_npc_pbs_turret_ew_level2', 'resist_thermal', @resist_level2),
('def_npc_pbs_turret_ew_level2', 'turret_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_ew_level2', 'received_repaired_modifier', 1.1);


INSERT INTO #STATS (defName, fieldName, fieldValue) VALUES
('def_npc_pbs_turret_laser_level3', 'armor_max_modifier', @armor_max_level3),
('def_npc_pbs_turret_laser_level3', 'armor_repair_amount_modifier', @turretRepAmountMod_level3),
('def_npc_pbs_turret_laser_level3', 'armor_repair_cycle_time_modifier', @turretRepRateMod),
('def_npc_pbs_turret_laser_level3', 'core_max_modifier',2),
('def_npc_pbs_turret_laser_level3', 'core_recharge_time_modifier',0.5),
('def_npc_pbs_turret_laser_level3', 'damage_modifier', @turretDamageMod_level3),
('def_npc_pbs_turret_laser_level3', 'falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_laser_level3', 'locking_range_modifier', @turretLockRangeMod),
('def_npc_pbs_turret_laser_level3', 'locking_time_modifier', 1.25),
('def_npc_pbs_turret_laser_level3', 'missile_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_laser_level3', 'optimal_range_modifier', @turretOptimalMod_level3),
('def_npc_pbs_turret_laser_level3', 'turret_fallof_modifier', @turretFalloffMod),
('def_npc_pbs_turret_laser_level3', 'resist_chemical',@resist_level3),
('def_npc_pbs_turret_laser_level3', 'resist_explosive', @resist_level3),
('def_npc_pbs_turret_laser_level3', 'resist_kinetic', @resist_level3),
('def_npc_pbs_turret_laser_level3', 'resist_thermal', @resist_level3*@peakResistMod),
('def_npc_pbs_turret_laser_level3', 'turret_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_laser_level3', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_turret_em_level3', 'armor_max_modifier', @armor_max_level3),
('def_npc_pbs_turret_em_level3', 'armor_repair_amount_modifier', @turretRepAmountMod_level3),
('def_npc_pbs_turret_em_level3', 'armor_repair_cycle_time_modifier', @turretRepRateMod),
('def_npc_pbs_turret_em_level3', 'core_max_modifier',2),
('def_npc_pbs_turret_em_level3', 'core_recharge_time_modifier',0.5),
('def_npc_pbs_turret_em_level3', 'damage_modifier', @turretDamageMod_level3),
('def_npc_pbs_turret_em_level3', 'falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_em_level3', 'locking_range_modifier', @turretLockRangeMod),
('def_npc_pbs_turret_em_level3', 'locking_time_modifier', 1.25),
('def_npc_pbs_turret_em_level3', 'missile_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_em_level3', 'optimal_range_modifier', @turretOptimalMod_level3),
('def_npc_pbs_turret_em_level3', 'turret_fallof_modifier', @turretFalloffMod),
('def_npc_pbs_turret_em_level3', 'resist_chemical', @resist_level3),
('def_npc_pbs_turret_em_level3', 'resist_explosive', @resist_level3),
('def_npc_pbs_turret_em_level3', 'resist_kinetic', @resist_level3*@peakResistMod),
('def_npc_pbs_turret_em_level3', 'resist_thermal', @resist_level3),--TODO
('def_npc_pbs_turret_em_level3', 'turret_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_em_level3', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_turret_missile_level3', 'armor_max_modifier', @armor_max_level3),
('def_npc_pbs_turret_missile_level3', 'armor_repair_amount_modifier', @turretRepAmountMod_level3),
('def_npc_pbs_turret_missile_level3', 'armor_repair_cycle_time_modifier', @turretRepRateMod),
('def_npc_pbs_turret_missile_level3', 'core_max_modifier',2),
('def_npc_pbs_turret_missile_level3', 'core_recharge_time_modifier',0.5),
('def_npc_pbs_turret_missile_level3', 'damage_modifier', @turretDamageMod_level3),
('def_npc_pbs_turret_missile_level3', 'falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_missile_level3', 'locking_range_modifier', @turretLockRangeMod),
('def_npc_pbs_turret_missile_level3', 'locking_time_modifier', 1.25),
('def_npc_pbs_turret_missile_level3', 'missile_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_missile_level3', 'effect_missile_range_modifier', 1.1),
('def_npc_pbs_turret_missile_level3', 'optimal_range_modifier', @turretOptimalMod_level3),
('def_npc_pbs_turret_missile_level3', 'missile_falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_missile_level3', 'resist_chemical', @resist_level3),
('def_npc_pbs_turret_missile_level3', 'resist_explosive', @resist_level3*@peakResistMod),
('def_npc_pbs_turret_missile_level3', 'resist_kinetic', @resist_level3),
('def_npc_pbs_turret_missile_level3', 'resist_thermal', @resist_level3),
('def_npc_pbs_turret_missile_level3', 'turret_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_missile_level3', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_turret_ew_level3', 'armor_max_modifier', @armor_max_level3),
('def_npc_pbs_turret_ew_level3', 'armor_repair_amount_modifier', @turretRepAmountMod_level3),
('def_npc_pbs_turret_ew_level3', 'armor_repair_cycle_time_modifier', @turretRepRateMod),
('def_npc_pbs_turret_ew_level3', 'core_max_modifier',2),
('def_npc_pbs_turret_ew_level3', 'core_recharge_time_modifier',0.5),
('def_npc_pbs_turret_ew_level3', 'damage_modifier', @turretDamageMod_level3),
('def_npc_pbs_turret_ew_level3', 'ecm_strength_modifier', @turretDamageMod_level3),
('def_npc_pbs_turret_ew_level3', 'energy_neutralized_amount_modifier', @turretDamageMod_level3),
('def_npc_pbs_turret_ew_level3', 'falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_ew_level3', 'locking_range_modifier', @turretLockRangeMod),
('def_npc_pbs_turret_ew_level3', 'locking_time_modifier', 1.25),
('def_npc_pbs_turret_ew_level3', 'missile_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_ew_level3', 'optimal_range_modifier', @turretOptimalMod_level3),
('def_npc_pbs_turret_ew_level3', 'resist_chemical', @resist_level3*@peakResistMod),
('def_npc_pbs_turret_ew_level3', 'resist_explosive', @resist_level3),
('def_npc_pbs_turret_ew_level3', 'resist_kinetic', @resist_level3),
('def_npc_pbs_turret_ew_level3', 'resist_thermal', @resist_level3),
('def_npc_pbs_turret_ew_level3', 'turret_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_ew_level3', 'received_repaired_modifier', 1.1);


SET IDENTITY_INSERT [dbo].[entitydefaults] ON;
PRINT N'UPDATE/INSERT ENTITY DEFS for NPC PBS definitions';
--Update/insert [entitydefaults] entries
MERGE [dbo].[entitydefaults] def USING #ENTITYDEFS d2
ON def.definition = d2.def
WHEN MATCHED
    THEN UPDATE SET
		definitionname=defName,
		categoryflags=catFlags,
		attributeflags=attrFlags,
		volume=cargoVolume,
		mass=massOfModule,
		tiertype=NULL,
		tierlevel=NULL,
		options=genxyOptStr,
		enabled=1,
		hidden=0,
		purchasable=0,
		descriptiontoken=description
WHEN NOT MATCHED
    THEN INSERT (definition, definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel) VALUES
	(def, defName, 1, attrFlags, catFlags, genxyOptStr, 'NPC PBS components and bot definitions', 1 ,cargoVolume, massOfModule, 0, 100, description, 0, NULL, NULL);
SET IDENTITY_INSERT [dbo].[entitydefaults] OFF;

PRINT N'DELETE OLD STATS (0 results if 1st run)';
DELETE FROM aggregatevalues WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #STATS));

PRINT N'INSERT NEW STATS';
INSERT INTO aggregatevalues (definition, field, value)
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defName), 
	(SELECT TOP 1 id FROM aggregatefields WHERE name=fieldName), 
	fieldValue
FROM #STATS;

PRINT N'DELETE OLD robottemplaterelation (0 results if 1st run)';
DELETE FROM robottemplaterelation WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #TEMPRELATIONS));
PRINT N'INSERT robottemplaterelation';
INSERT INTO robottemplaterelation ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
SELECT
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=t.defName),
	(SELECT TOP 1 id FROM robottemplates WHERE name=t.tempName),
	0, 0, NULL, NULL, t.epKill, 'Relate: '+t.defName+ '<->'+t.tempName
FROM #TEMPRELATIONS AS t;
DROP TABLE IF EXISTS #TEMPRELATIONS;
DROP TABLE IF EXISTS #TEMPLATES;
DROP TABLE IF EXISTS #STATS;
DROP TABLE IF EXISTS #ENTITYDEFS;
GO

USE [perpetuumsa]
GO
PRINT N'LOOTS';

DROP TABLE IF EXISTS #NPCLOOTS;
CREATE TABLE #NPCLOOTS(
	defName varchar(128),
	lootName varchar(128),
	minQuantity int,
	maxQuantity int,
	probability float,
);
INSERT INTO #NPCLOOTS(defName, lootName, minQuantity, maxQuantity, probability) VALUES
('def_npc_pbs_turret_em_level0','def_titanium',5,10,0.5),
('def_npc_pbs_turret_em_level0','def_hydrobenol',75,150,0.5),
('def_npc_pbs_turret_em_level0','def_espitium',50,100,0.5),
('def_npc_pbs_turret_em_level0','def_unimetal',10,20,0.5),
('def_npc_pbs_turret_em_level0','def_axicol',25,50,0.5),
('def_npc_pbs_turret_em_level0','def_axicoline',37,75,0.5),
('def_npc_pbs_turret_em_level0','def_gamma_buildblock',5,10,0.5),
('def_npc_pbs_turret_em_level0','def_gamma_energyblock',25,50,0.5),
('def_npc_pbs_turret_em_level0','def_gamma_offenseblock',37,75,0.5),
('def_npc_pbs_turret_em_level0','def_nuimqol_reactor_plasma',500,1000,1),
('def_npc_pbs_turret_em_level0','def_kernel_nuimqol',500,1000,1),
('def_npc_pbs_turret_em_level0','def_robotshard_nuimqol_basic',30,30,1),
('def_npc_pbs_turret_em_level0','def_robotshard_nuimqol_advanced',20,20,1),
('def_npc_pbs_turret_em_level0','def_robotshard_nuimqol_expert',10,10,1),
('def_npc_pbs_turret_ew_level0','def_titanium',5,10,0.5),
('def_npc_pbs_turret_ew_level0','def_hydrobenol',75,150,0.5),
('def_npc_pbs_turret_ew_level0','def_espitium',50,100,0.5),
('def_npc_pbs_turret_ew_level0','def_unimetal',10,20,0.5),
('def_npc_pbs_turret_ew_level0','def_axicol',25,50,0.5),
('def_npc_pbs_turret_ew_level0','def_axicoline',37,75,0.5),
('def_npc_pbs_turret_ew_level0','def_gamma_buildblock',5,10,0.5),
('def_npc_pbs_turret_ew_level0','def_gamma_energyblock',25,50,0.5),
('def_npc_pbs_turret_ew_level0','def_gamma_offenseblock',37,75,0.5),
('def_npc_pbs_turret_ew_level0','def_common_reactor_plasma',500,1000,1),
('def_npc_pbs_turret_ew_level0','def_kernel_common',500,1000,1),
('def_npc_pbs_turret_ew_level0','def_kernel_hitech',250,500,1),
('def_npc_pbs_turret_ew_level0','def_robotshard_common_basic',30,30,1),
('def_npc_pbs_turret_ew_level0','def_robotshard_common_advanced',20,20,1),
('def_npc_pbs_turret_ew_level0','def_robotshard_common_expert',10,10,1),
('def_npc_pbs_turret_laser_level0','def_titanium',5,10,0.5),
('def_npc_pbs_turret_laser_level0','def_hydrobenol',75,150,0.5),
('def_npc_pbs_turret_laser_level0','def_espitium',50,100,0.5),
('def_npc_pbs_turret_laser_level0','def_unimetal',10,20,0.5),
('def_npc_pbs_turret_laser_level0','def_axicol',25,50,0.5),
('def_npc_pbs_turret_laser_level0','def_axicoline',37,75,0.5),
('def_npc_pbs_turret_laser_level0','def_gamma_buildblock',5,10,0.5),
('def_npc_pbs_turret_laser_level0','def_gamma_energyblock',25,50,0.5),
('def_npc_pbs_turret_laser_level0','def_gamma_offenseblock',37,75,0.5),
('def_npc_pbs_turret_laser_level0','def_thelodica_reactor_plasma',500,1000,1),
('def_npc_pbs_turret_laser_level0','def_kernel_thelodica',500,1000,1),
('def_npc_pbs_turret_laser_level0','def_robotshard_thelodica_basic',30,30,1),
('def_npc_pbs_turret_laser_level0','def_robotshard_thelodica_advanced',20,20,1),
('def_npc_pbs_turret_laser_level0','def_robotshard_thelodica_expert',10,10,1),
('def_npc_pbs_turret_missile_level0','def_titanium',5,10,0.5),
('def_npc_pbs_turret_missile_level0','def_hydrobenol',75,150,0.5),
('def_npc_pbs_turret_missile_level0','def_espitium',50,100,0.5),
('def_npc_pbs_turret_missile_level0','def_unimetal',10,20,0.5),
('def_npc_pbs_turret_missile_level0','def_axicol',25,50,0.5),
('def_npc_pbs_turret_missile_level0','def_axicoline',37,75,0.5),
('def_npc_pbs_turret_missile_level0','def_gamma_buildblock',5,10,0.5),
('def_npc_pbs_turret_missile_level0','def_gamma_energyblock',25,50,0.5),
('def_npc_pbs_turret_missile_level0','def_gamma_offenseblock',37,75,0.5),
('def_npc_pbs_turret_missile_level0','def_pelistal_reactor_plasma',500,1000,1),
('def_npc_pbs_turret_missile_level0','def_kernel_pelistal',500,1000,1),
('def_npc_pbs_turret_missile_level0','def_robotshard_pelistal_basic',30,30,1),
('def_npc_pbs_turret_missile_level0','def_robotshard_pelistal_advanced',20,20,1),
('def_npc_pbs_turret_missile_level0','def_robotshard_pelistal_expert',10,10,1),
--
('def_npc_pbs_turret_em_level1','def_titanium',5,10,0.75),
('def_npc_pbs_turret_em_level1','def_hydrobenol',75,150,0.75),
('def_npc_pbs_turret_em_level1','def_espitium',50,100,0.75),
('def_npc_pbs_turret_em_level1','def_unimetal',10,20,0.75),
('def_npc_pbs_turret_em_level1','def_axicol',25,50,0.75),
('def_npc_pbs_turret_em_level1','def_axicoline',37,75,0.75),
('def_npc_pbs_turret_em_level1','def_gamma_buildblock',5,10,0.75),
('def_npc_pbs_turret_em_level1','def_gamma_energyblock',25,50,0.75),
('def_npc_pbs_turret_em_level1','def_gamma_offenseblock',37,75,0.75),
('def_npc_pbs_turret_em_level1','def_nuimqol_reactor_plasma',1000,1100,1),
('def_npc_pbs_turret_em_level1','def_kernel_nuimqol',1000,1100,1),
('def_npc_pbs_turret_em_level1','def_robotshard_nuimqol_basic',30,40,1),
('def_npc_pbs_turret_em_level1','def_robotshard_nuimqol_advanced',20,30,1),
('def_npc_pbs_turret_em_level1','def_robotshard_nuimqol_expert',10,20,1),
('def_npc_pbs_turret_ew_level1','def_titanium',5,10,0.75),
('def_npc_pbs_turret_ew_level1','def_hydrobenol',75,150,0.75),
('def_npc_pbs_turret_ew_level1','def_espitium',50,100,0.75),
('def_npc_pbs_turret_ew_level1','def_unimetal',10,20,0.75),
('def_npc_pbs_turret_ew_level1','def_axicol',25,50,0.75),
('def_npc_pbs_turret_ew_level1','def_axicoline',37,75,0.75),
('def_npc_pbs_turret_ew_level1','def_gamma_buildblock',5,10,0.75),
('def_npc_pbs_turret_ew_level1','def_gamma_energyblock',25,50,0.75),
('def_npc_pbs_turret_ew_level1','def_gamma_offenseblock',37,75,0.75),
('def_npc_pbs_turret_ew_level1','def_common_reactor_plasma',1000,1100,1),
('def_npc_pbs_turret_ew_level1','def_kernel_common',1000,1100,1),
('def_npc_pbs_turret_ew_level1','def_kernel_hitech',500,1100,1),
('def_npc_pbs_turret_ew_level1','def_robotshard_common_basic',30,40,1),
('def_npc_pbs_turret_ew_level1','def_robotshard_common_advanced',20,30,1),
('def_npc_pbs_turret_ew_level1','def_robotshard_common_expert',10,20,1),
('def_npc_pbs_turret_laser_level1','def_titanium',5,10,0.75),
('def_npc_pbs_turret_laser_level1','def_hydrobenol',75,150,0.75),
('def_npc_pbs_turret_laser_level1','def_espitium',50,100,0.75),
('def_npc_pbs_turret_laser_level1','def_unimetal',10,20,0.75),
('def_npc_pbs_turret_laser_level1','def_axicol',25,50,0.75),
('def_npc_pbs_turret_laser_level1','def_axicoline',37,75,0.75),
('def_npc_pbs_turret_laser_level1','def_gamma_buildblock',5,10,0.75),
('def_npc_pbs_turret_laser_level1','def_gamma_energyblock',25,50,0.75),
('def_npc_pbs_turret_laser_level1','def_gamma_offenseblock',37,75,0.75),
('def_npc_pbs_turret_laser_level1','def_thelodica_reactor_plasma',1000,1100,1),
('def_npc_pbs_turret_laser_level1','def_kernel_thelodica',1000,1100,1),
('def_npc_pbs_turret_laser_level1','def_robotshard_thelodica_basic',30,40,1),
('def_npc_pbs_turret_laser_level1','def_robotshard_thelodica_advanced',20,30,1),
('def_npc_pbs_turret_laser_level1','def_robotshard_thelodica_expert',10,20,1),
('def_npc_pbs_turret_missile_level1','def_titanium',5,10,0.75),
('def_npc_pbs_turret_missile_level1','def_hydrobenol',75,150,0.75),
('def_npc_pbs_turret_missile_level1','def_espitium',50,100,0.75),
('def_npc_pbs_turret_missile_level1','def_unimetal',10,20,0.75),
('def_npc_pbs_turret_missile_level1','def_axicol',25,50,0.75),
('def_npc_pbs_turret_missile_level1','def_axicoline',37,75,0.75),
('def_npc_pbs_turret_missile_level1','def_gamma_buildblock',5,10,0.75),
('def_npc_pbs_turret_missile_level1','def_gamma_energyblock',25,50,0.75),
('def_npc_pbs_turret_missile_level1','def_gamma_offenseblock',37,75,0.75),
('def_npc_pbs_turret_missile_level1','def_pelistal_reactor_plasma',1000,1100,1),
('def_npc_pbs_turret_missile_level1','def_kernel_pelistal',1000,1100,1),
('def_npc_pbs_turret_missile_level1','def_robotshard_pelistal_basic',30,40,1),
('def_npc_pbs_turret_missile_level1','def_robotshard_pelistal_advanced',20,30,1),
('def_npc_pbs_turret_missile_level1','def_robotshard_pelistal_expert',10,20,1),
--
('def_npc_pbs_turret_em_level2','def_titanium',5,10,0.9),
('def_npc_pbs_turret_em_level2','def_hydrobenol',75,150,0.9),
('def_npc_pbs_turret_em_level2','def_espitium',50,100,0.9),
('def_npc_pbs_turret_em_level2','def_unimetal',10,20,0.9),
('def_npc_pbs_turret_em_level2','def_axicol',25,50,0.9),
('def_npc_pbs_turret_em_level2','def_axicoline',37,75,0.9),
('def_npc_pbs_turret_em_level2','def_gamma_buildblock',5,10,0.9),
('def_npc_pbs_turret_em_level2','def_gamma_energyblock',25,50,0.9),
('def_npc_pbs_turret_em_level2','def_gamma_offenseblock',37,75,0.9),
('def_npc_pbs_turret_em_level2','def_nuimqol_reactor_plasma',1000,2000,1),
('def_npc_pbs_turret_em_level2','def_kernel_nuimqol',1000,2000,1),
('def_npc_pbs_turret_em_level2','def_robotshard_nuimqol_basic',30,50,1),
('def_npc_pbs_turret_em_level2','def_robotshard_nuimqol_advanced',20,40,1),
('def_npc_pbs_turret_em_level2','def_robotshard_nuimqol_expert',10,30,1),
('def_npc_pbs_turret_ew_level2','def_titanium',5,10,0.9),
('def_npc_pbs_turret_ew_level2','def_hydrobenol',75,150,0.9),
('def_npc_pbs_turret_ew_level2','def_espitium',50,100,0.9),
('def_npc_pbs_turret_ew_level2','def_unimetal',10,20,0.9),
('def_npc_pbs_turret_ew_level2','def_axicol',25,50,0.9),
('def_npc_pbs_turret_ew_level2','def_axicoline',37,75,0.9),
('def_npc_pbs_turret_ew_level2','def_gamma_buildblock',5,10,0.9),
('def_npc_pbs_turret_ew_level2','def_gamma_energyblock',25,50,0.9),
('def_npc_pbs_turret_ew_level2','def_gamma_offenseblock',37,75,0.9),
('def_npc_pbs_turret_ew_level2','def_common_reactor_plasma',1000,2000,1),
('def_npc_pbs_turret_ew_level2','def_kernel_common',1000,2000,1),
('def_npc_pbs_turret_ew_level2','def_kernel_hitech',500,1000,1),
('def_npc_pbs_turret_ew_level2','def_robotshard_common_basic',30,50,1),
('def_npc_pbs_turret_ew_level2','def_robotshard_common_advanced',20,30,1),
('def_npc_pbs_turret_ew_level2','def_robotshard_common_expert',10,30,1),
('def_npc_pbs_turret_laser_level2','def_titanium',5,10,0.9),
('def_npc_pbs_turret_laser_level2','def_hydrobenol',75,150,0.9),
('def_npc_pbs_turret_laser_level2','def_espitium',50,100,0.9),
('def_npc_pbs_turret_laser_level2','def_unimetal',10,20,0.9),
('def_npc_pbs_turret_laser_level2','def_axicol',25,50,0.9),
('def_npc_pbs_turret_laser_level2','def_axicoline',37,75,0.9),
('def_npc_pbs_turret_laser_level2','def_gamma_buildblock',5,10,0.9),
('def_npc_pbs_turret_laser_level2','def_gamma_energyblock',25,50,0.9),
('def_npc_pbs_turret_laser_level2','def_gamma_offenseblock',37,75,0.9),
('def_npc_pbs_turret_laser_level2','def_thelodica_reactor_plasma',1000,2000,1),
('def_npc_pbs_turret_laser_level2','def_kernel_thelodica',1000,2000,1),
('def_npc_pbs_turret_laser_level2','def_robotshard_thelodica_basic',30,50,1),
('def_npc_pbs_turret_laser_level2','def_robotshard_thelodica_advanced',20,40,1),
('def_npc_pbs_turret_laser_level2','def_robotshard_thelodica_expert',10,30,1),
('def_npc_pbs_turret_missile_level2','def_titanium',5,10,0.9),
('def_npc_pbs_turret_missile_level2','def_hydrobenol',75,150,0.9),
('def_npc_pbs_turret_missile_level2','def_espitium',50,100,0.9),
('def_npc_pbs_turret_missile_level2','def_unimetal',10,20,0.9),
('def_npc_pbs_turret_missile_level2','def_axicol',25,50,0.9),
('def_npc_pbs_turret_missile_level2','def_axicoline',37,75,0.9),
('def_npc_pbs_turret_missile_level2','def_gamma_buildblock',5,10,0.9),
('def_npc_pbs_turret_missile_level2','def_gamma_energyblock',25,50,0.9),
('def_npc_pbs_turret_missile_level2','def_gamma_offenseblock',37,75,0.9),
('def_npc_pbs_turret_missile_level2','def_pelistal_reactor_plasma',1000,2000,1),
('def_npc_pbs_turret_missile_level2','def_kernel_pelistal',1000,2000,1),
('def_npc_pbs_turret_missile_level2','def_robotshard_pelistal_basic',30,50,1),
('def_npc_pbs_turret_missile_level2','def_robotshard_pelistal_advanced',20,40,1),
('def_npc_pbs_turret_missile_level2','def_robotshard_pelistal_expert',10,30,1),
--
('def_npc_pbs_turret_em_level3','def_titanium',5,10,1),
('def_npc_pbs_turret_em_level3','def_hydrobenol',75,150,1),
('def_npc_pbs_turret_em_level3','def_espitium',50,100,1),
('def_npc_pbs_turret_em_level3','def_unimetal',10,20,1),
('def_npc_pbs_turret_em_level3','def_axicol',25,50,1),
('def_npc_pbs_turret_em_level3','def_axicoline',37,75,1),
('def_npc_pbs_turret_em_level3','def_gamma_buildblock',5,10,1),
('def_npc_pbs_turret_em_level3','def_gamma_energyblock',25,50,1),
('def_npc_pbs_turret_em_level3','def_gamma_offenseblock',37,75,1),
('def_npc_pbs_turret_em_level3','def_nuimqol_reactor_plasma',1000,3000,1),
('def_npc_pbs_turret_em_level3','def_kernel_nuimqol',1000,3000,1),
('def_npc_pbs_turret_em_level3','def_robotshard_nuimqol_basic',30,60,1),
('def_npc_pbs_turret_em_level3','def_robotshard_nuimqol_advanced',20,50,1),
('def_npc_pbs_turret_em_level3','def_robotshard_nuimqol_expert',10,40,1),
('def_npc_pbs_turret_ew_level3','def_titanium',5,10,1),
('def_npc_pbs_turret_ew_level3','def_hydrobenol',75,150,1),
('def_npc_pbs_turret_ew_level3','def_espitium',50,100,1),
('def_npc_pbs_turret_ew_level3','def_unimetal',10,20,1),
('def_npc_pbs_turret_ew_level3','def_axicol',25,50,1),
('def_npc_pbs_turret_ew_level3','def_axicoline',37,75,1),
('def_npc_pbs_turret_ew_level3','def_gamma_buildblock',5,10,1),
('def_npc_pbs_turret_ew_level3','def_gamma_energyblock',25,50,1),
('def_npc_pbs_turret_ew_level3','def_gamma_offenseblock',37,75,1),
('def_npc_pbs_turret_ew_level3','def_common_reactor_plasma',1000,3000,1),
('def_npc_pbs_turret_ew_level3','def_kernel_common',1000,3000,1),
('def_npc_pbs_turret_ew_level3','def_kernel_hitech',500,1500,1),
('def_npc_pbs_turret_ew_level3','def_robotshard_common_basic',30,60,1),
('def_npc_pbs_turret_ew_level3','def_robotshard_common_advanced',20,50,1),
('def_npc_pbs_turret_ew_level3','def_robotshard_common_expert',10,40,1),
('def_npc_pbs_turret_laser_level3','def_titanium',5,10,1),
('def_npc_pbs_turret_laser_level3','def_hydrobenol',75,150,1),
('def_npc_pbs_turret_laser_level3','def_espitium',50,100,1),
('def_npc_pbs_turret_laser_level3','def_unimetal',10,20,1),
('def_npc_pbs_turret_laser_level3','def_axicol',25,50,1),
('def_npc_pbs_turret_laser_level3','def_axicoline',37,75,1),
('def_npc_pbs_turret_laser_level3','def_gamma_buildblock',5,10,1),
('def_npc_pbs_turret_laser_level3','def_gamma_energyblock',25,50,1),
('def_npc_pbs_turret_laser_level3','def_gamma_offenseblock',37,75,1),
('def_npc_pbs_turret_laser_level3','def_thelodica_reactor_plasma',1000,3000,1),
('def_npc_pbs_turret_laser_level3','def_kernel_thelodica',1000,3000,1),
('def_npc_pbs_turret_laser_level3','def_robotshard_thelodica_basic',30,60,1),
('def_npc_pbs_turret_laser_level3','def_robotshard_thelodica_advanced',20,50,1),
('def_npc_pbs_turret_laser_level3','def_robotshard_thelodica_expert',10,40,1),
('def_npc_pbs_turret_missile_level3','def_titanium',5,10,1),
('def_npc_pbs_turret_missile_level3','def_hydrobenol',75,150,1),
('def_npc_pbs_turret_missile_level3','def_espitium',50,100,1),
('def_npc_pbs_turret_missile_level3','def_unimetal',10,20,1),
('def_npc_pbs_turret_missile_level3','def_axicol',25,50,1),
('def_npc_pbs_turret_missile_level3','def_axicoline',37,75,1),
('def_npc_pbs_turret_missile_level3','def_gamma_buildblock',5,10,1),
('def_npc_pbs_turret_missile_level3','def_gamma_energyblock',25,50,1),
('def_npc_pbs_turret_missile_level3','def_gamma_offenseblock',37,75,1),
('def_npc_pbs_turret_missile_level3','def_pelistal_reactor_plasma',1000,3000,1),
('def_npc_pbs_turret_missile_level3','def_kernel_pelistal',1000,3000,1),
('def_npc_pbs_turret_missile_level3','def_robotshard_pelistal_basic',30,60,1),
('def_npc_pbs_turret_missile_level3','def_robotshard_pelistal_advanced',20,50,1),
('def_npc_pbs_turret_missile_level3','def_robotshard_pelistal_expert',10,40,1);


PRINT N'DELETE ALL LOOTS (0 if 1st run) FOR NEW NPC DEFS';
DELETE FROM npcloot WHERE definition IN (
	SELECT definition FROM entitydefaults WHERE definitionname IN (
		SELECT DISTINCT defName FROM #NPCLOOTS
	)
);

PRINT N'UPDATE/INSERT ALL LOOTS';
MERGE npcloot n USING #NPCLOOTS o
ON n.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=o.defName) AND
n.lootdefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=o.lootName)
WHEN MATCHED
    THEN UPDATE SET
		minquantity=o.minQuantity,
		quantity=o.maxQuantity,
		probability=o.probability
WHEN NOT MATCHED
    THEN INSERT (definition, lootdefinition, minquantity, quantity, probability, repackaged, dontdamage) VALUES
		((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=o.defName),
		(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=o.lootName),
		o.minQuantity, o.maxQuantity, o.probability, 0, 0);


PRINT N'DONE WITH NPC LOOTS';
DROP TABLE IF EXISTS #NPCLOOTS;
GO