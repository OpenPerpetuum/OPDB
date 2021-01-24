USE [perpetuumsa]
GO
--------------------------------------------------------------------------
-- NPC PBS DEFINITIONS + stronghold npcs
-- Inserts entitydefaults for: robot components and npc defs of npc-pbs
-- Insert aggregatevalues for stats and npc modifier/bonuses
-- Insert robottemplates and relations
-- Date: 2021/01/20
--------------------------------------------------------------------------

DECLARE @compDesc VARCHAR(MAX);
DECLARE @npcDesc VARCHAR(MAX);

SET @compDesc = 'def_npcpbs_component_desc';
SET @npcDesc = 'def_npc_pbs_desc';

DECLARE @baseResist AS INT = 150;
DECLARE @turretResist AS INT = 250;
DECLARE @turretResistPeak AS INT = 400;
DECLARE @turretLockRangeMod AS FLOAT = 1.5;
DECLARE @turretFalloffMod AS FLOAT = 2.0;
DECLARE @turretOptimalMod AS FLOAT = 1.0;
DECLARE @turretDamageMod AS FLOAT = 1.0;
DECLARE @turretRepAmountMod AS FLOAT = 8.0;
DECLARE @turretRepRateMod AS FLOAT = 0.5;

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
--Robot component definitions
(5883,'def_npcpbs_turret_head', 1024, 336, 2, 1000, '#height=f0.10  #slotFlags=48,8,8,8,8,8,8,8', @compDesc),
(5884,'def_npcpbs_turret_chassis', 1024, 592, 2, 1000, '#slotFlags=4693,693  #height=f2.50  #decay=n500', @compDesc),
(5885,'def_npcpbs_turret_leg', 1024, 848, 2, 1000, '#height=f5.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5886,'def_npcpbs_reactor_leg', 1024, 848, 2, 1000, '#height=f5.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5887,'def_npcpbs_e_transmitter_leg', 1024, 848, 2, 1000, '#height=f5.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5888,'def_npcpbs_e_transfer_leg', 1024, 848, 2, 1000, '#height=f5.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5889,'def_npcpbs_e_battery_leg', 1024, 848, 2, 1000, '#height=f5.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5890,'def_npcpbs_facility_leg', 1024, 848, 2, 1000, '#height=f5.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5891,'def_npcpbs_facility_upgrade_leg', 1024, 848, 2, 1000, '#height=f5.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5892,'def_npcpbs_mining_tower_leg', 1024, 848, 2, 1000, '#height=f5.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5893,'def_npcpbs_repair_leg', 1024, 848, 2, 1000, '#height=f5.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5894,'def_npcpbs_eff_booster_leg', 1024, 848, 2, 1000, '#height=f5.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5895,'def_npcpbs_eff_emitter_leg', 1024, 848, 2, 1000, '#height=f5.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5896,'def_npcpbs_control_tower_leg', 1024, 848, 2, 1000, '#height=f5.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5897,'def_npcpbs_base_small_leg', 1024, 848, 2, 1000, '#height=f7.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5898,'def_npcpbs_base_medium_leg', 1024, 848, 2, 1000,'#height=f7.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5899,'def_npcpbs_base_large_leg', 1024, 848, 2, 1000, '#height=f7.00  #slotFlags=420,20,20,20,20,20,20,20', @compDesc),
(5900,'def_npcpbs_invis_head', 1024, 336, 2, 1000, '#height=f0.10  #slotFlags=48,8,8,8,8,8,8,8', @compDesc),
(5901,'def_npcpbs_invis_chassis', 1024, 592, 2, 1000,  '#height=f1.00', @compDesc),
--NPC defs
(5902,'def_npc_pbs_turret_laser_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5903,'def_npc_pbs_turret_em_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5904,'def_npc_pbs_turret_missile_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5905,'def_npc_pbs_turret_ew_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5906,'def_npc_pbs_reactor_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5907,'def_npc_pbs_e_emitter_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5908,'def_npc_pbs_e_transfer_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5909,'def_npc_pbs_e_battery_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5910,'def_npc_pbs_facility_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5911,'def_npc_pbs_facility_upgrade_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5912,'def_npc_pbs_miner_tower_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5913,'def_npc_pbs_energy_tower_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5914,'def_npc_pbs_repair_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5915,'def_npc_pbs_eff_booster_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5916,'def_npc_pbs_eff_emitter_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5917,'def_npc_pbs_control_tower_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5918,'def_npc_pbs_base_small_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5919,'def_npc_pbs_base_medium_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5920,'def_npc_pbs_base_large_rank1', 1024, 911, 0, 0, NULL, @npcDesc),
(5921,'def_npc_sh70_mainboss', 1024, 911, 0, 0, NULL, 'def_npc_sh70_mainboss_desc'),
(5996,'def_npc_sh70_miniboss_a', 1024, 911, 0, 0, NULL, 'def_npc_sh70_miniboss_a_desc'),
(5997,'def_npc_sh70_miniboss_b', 1024, 911, 0, 0, NULL, 'def_npc_sh70_miniboss_b_desc');

DROP TABLE IF EXISTS #TEMPLATES;
CREATE TABLE #TEMPLATES
(
	tempName varchar(100),
	botName varchar(100),
	headName varchar(100),
	chassisName varchar(100),
	legName varchar(100),
	inventoryName varchar(100),
	loadOut VARCHAR(MAX)
);
INSERT INTO #TEMPLATES (tempName, botName, headName, chassisName, legName, inventoryName, loadOut) VALUES
('def_npc_pbs_turret_laser_template', 'def_pbs_turret_bot', 'def_npcpbs_turret_head', 'def_npcpbs_turret_chassis', 'def_npcpbs_turret_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[|m0=[|definition=i12ff|slot=i1|ammoDefinition=i1439|ammoQuantity=i19]|m1=[|definition=i12ff|slot=i2|ammoDefinition=i1439|ammoQuantity=i19]]#legModules=[|m0=[|definition=i14|slot=i1]]'),
('def_npc_pbs_turret_em_temlate', 'def_pbs_turret_bot', 'def_npcpbs_turret_head', 'def_npcpbs_turret_chassis', 'def_npcpbs_turret_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[|m0=[|definition=i1301|slot=i1|ammoDefinition=i1438|ammoQuantity=i14]|m1=[|definition=i1301|slot=i2|ammoDefinition=i1438|ammoQuantity=i14]]#legModules=[|m0=[|definition=i14|slot=i1]]'),
('def_npc_pbs_turret_missile_template', 'def_pbs_turret_bot', 'def_npcpbs_turret_head', 'def_npcpbs_turret_chassis', 'def_npcpbs_turret_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[|m0=[|definition=i1300|slot=i1|ammoDefinition=i143a|ammoQuantity=i14]|m1=[|definition=i1300|slot=i2|ammoDefinition=i143a|ammoQuantity=i14]]#legModules=[|m0=[|definition=i14|slot=i1]]'),
('def_npc_pbs_turret_ew_template', 'def_pbs_turret_bot', 'def_npcpbs_turret_head', 'def_npcpbs_turret_chassis', 'def_npcpbs_turret_leg', 'def_robot_inventory_daidalos',
'#headModules=[|m0=[|definition=i1370|slot=i1]|m1=[|definition=i1371|slot=i2]|m2=[|definition=i1372|slot=i3]|m3=[|definition=i1371|slot=i4]|m4=[|definition=i1372|slot=i5]]#chassisModules=[|m0=[|definition=i136f|slot=i1]|m1=[|definition=i136f|slot=i2]]#legModules=[|m0=[|definition=i14|slot=i1]]'),
('def_npc_pbs_reactor_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_reactor_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]'),
('def_npc_pbs_e_emitter_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_e_transmitter_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]'),
('def_npc_pbs_e_transfer_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_e_transfer_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]'),
('def_npc_pbs_e_battery_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_e_battery_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]'),
('def_npc_pbs_facility_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_facility_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]'),
('def_npc_pbs_facility_upgrade_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_facility_upgrade_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]'),
('def_npc_pbs_miner_tower_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_mining_tower_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]'),
('def_npc_pbs_repair_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_repair_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]'),
('def_npc_pbs_eff_booster_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_eff_booster_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]'),
('def_npc_pbs_eff_emitter_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_eff_emitter_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]'),
('def_npc_pbs_control_tower_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_control_tower_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]'),
('def_npc_pbs_base_small_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_base_small_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]'),
('def_npc_pbs_base_medium_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_base_medium_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]'),
('def_npc_pbs_base_large_template', 'def_pbs_turret_bot', 'def_npcpbs_invis_head', 'def_npcpbs_invis_chassis', 'def_npcpbs_base_large_leg', 'def_robot_inventory_daidalos',
'#headModules=[]#chassisModules=[]#legModules=[|m0=[|definition=i12|slot=i1]]'),
('def_npc_sh70_miniboss_a_template', 'def_ictus_mk2_bot', 'def_ictus_head_mk2', 'def_ictus_chassis_mk2', 'def_ictus_leg_mk2', 'def_robot_inventory_daidalos',
'#headModules=[|m0=[|definition=i32|slot=i1]|m1=[|definition=i33|slot=i2]|m2=[|definition=i33|slot=i3]|m3=[|definition=i32|slot=i4]]#chassisModules=[|m0=[|definition=i27|slot=i1]|m1=[|definition=i27|slot=i2]|m2=[|definition=i40|slot=i3|ammoDefinition=i991|ammoQuantity=if]|m3=[|definition=i40|slot=i4|ammoDefinition=i992|ammoQuantity=if]|m4=[|definition=i27|slot=i5]]#legModules=[|m0=[|definition=i1d|slot=i1]|m1=[|definition=i28a|slot=i2|ammoDefinition=i298|ammoQuantity=ia]|m2=[|definition=i14|slot=i3]|m3=[|definition=i18|slot=i4]]'),
('def_npc_sh70_miniboss_b_template', 'def_tyrannos_mk2_bot', 'def_tyrannos_head_mk2', 'def_tyrannos_chassis_mk2', 'def_tyrannos_leg_mk2', 'def_robot_inventory_daidalos',
'#headModules=[|m0=[|definition=i31|slot=i1]|m1=[|definition=i32|slot=i2]|m2=[|definition=i33|slot=i3]|m3=[|definition=i34|slot=i4]|m4=[|definition=i34|slot=i5]]#chassisModules=[|m0=[|definition=i40|slot=i1|ammoDefinition=i992|ammoQuantity=if]|m1=[|definition=i40|slot=i2|ammoDefinition=i991|ammoQuantity=if]|m2=[|definition=i40|slot=i3|ammoDefinition=i992|ammoQuantity=if]|m3=[|definition=i40|slot=i4|ammoDefinition=i991|ammoQuantity=if]|m4=[|definition=i3e9|slot=i5|ammoDefinition=i101|ammoQuantity=if]|m5=[|definition=i3e9|slot=i6|ammoDefinition=i102|ammoQuantity=if]]#legModules=[|m0=[|definition=i1d|slot=i1]|m1=[|definition=i289|slot=i2|ammoDefinition=i298|ammoQuantity=ia]|m2=[|definition=i1a|slot=i3]|m3=[|definition=i14|slot=i4]]'),
('def_npc_sh70_mainboss_template', 'def_hydra_bot', 'def_hydra_bot_head', 'def_hydra_bot_chassis', 'def_hydra_bot_leg', 'def_robot_inventory_daidalos',
'#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=ib52|slot=i2]|m2=[|definition=i32|slot=i3]|m3=[|definition=i33|slot=i4]|m4=[|definition=i34|slot=i5]]#chassisModules=[|m0=[|definition=i41|slot=i1|ammoDefinition=i123|ammoQuantity=i32]|m1=[|definition=i41|slot=i2|ammoDefinition=i123|ammoQuantity=i32]|m2=[|definition=i41|slot=i3|ammoDefinition=i123|ammoQuantity=i32]|m3=[|definition=i41|slot=i4|ammoDefinition=i123|ammoQuantity=i32]|m4=[|definition=i41|slot=i5|ammoDefinition=i123|ammoQuantity=i32]|m5=[|definition=i41|slot=i6|ammoDefinition=i123|ammoQuantity=i32]]#legModules=[|m0=[|definition=i11|slot=i1]|m1=[|definition=i14|slot=i2]|m2=[|definition=i19|slot=i3]|m3=[|definition=i287|slot=i4]]');

DROP TABLE IF EXISTS #TEMPRELATIONS;
CREATE TABLE #TEMPRELATIONS
(
	defName varchar(100),
	tempName varchar(100),
	epKill INT,
);
INSERT INTO #TEMPRELATIONS (defName, tempName, epKill) VALUES
('def_npc_pbs_turret_laser_rank1', 'def_npc_pbs_turret_laser_template', 10),
('def_npc_pbs_turret_em_rank1', 'def_npc_pbs_turret_em_temlate', 10),
('def_npc_pbs_turret_missile_rank1', 'def_npc_pbs_turret_missile_template', 10),
('def_npc_pbs_turret_ew_rank1', 'def_npc_pbs_turret_ew_template', 10),
('def_npc_pbs_reactor_rank1', 'def_npc_pbs_reactor_template', 20),
('def_npc_pbs_e_emitter_rank1', 'def_npc_pbs_e_emitter_template', 10),
('def_npc_pbs_e_transfer_rank1', 'def_npc_pbs_e_transfer_template', 10),
('def_npc_pbs_e_battery_rank1', 'def_npc_pbs_e_battery_template', 10),
('def_npc_pbs_facility_rank1', 'def_npc_pbs_facility_template', 10),
('def_npc_pbs_facility_upgrade_rank1', 'def_npc_pbs_facility_upgrade_template', 10),
('def_npc_pbs_miner_tower_rank1', 'def_npc_pbs_miner_tower_template', 15),
('def_npc_pbs_energy_tower_rank1', 'def_npc_pbs_miner_tower_template', 15),
('def_npc_pbs_repair_rank1', 'def_npc_pbs_miner_tower_template', 15),
('def_npc_pbs_eff_booster_rank1', 'def_npc_pbs_eff_booster_template', 15),
('def_npc_pbs_eff_emitter_rank1', 'def_npc_pbs_eff_emitter_template', 15),
('def_npc_pbs_control_tower_rank1', 'def_npc_pbs_control_tower_template', 20),
('def_npc_pbs_base_small_rank1', 'def_npc_pbs_base_small_template', 50),
('def_npc_pbs_base_medium_rank1', 'def_npc_pbs_base_medium_template', 100),
('def_npc_pbs_base_large_rank1', 'def_npc_pbs_base_large_template', 150),
('def_npc_sh70_miniboss_a', 'def_npc_sh70_miniboss_a_template', 200),
('def_npc_sh70_miniboss_b', 'def_npc_sh70_miniboss_b_template', 200),
('def_npc_sh70_mainboss', 'def_npc_sh01_mainboss_template', 1000);

DROP TABLE IF EXISTS #STATS;
CREATE TABLE #STATS
(
	defName varchar(100),
	fieldName varchar(100),
	fieldValue float,
);
INSERT INTO #STATS (defName, fieldName, fieldValue) VALUES
('def_npcpbs_turret_head', 'cpu_max', 5000),
('def_npcpbs_turret_head', 'locked_targets_max', 100),
('def_npcpbs_turret_head', 'locking_range', 100),
('def_npcpbs_turret_head', 'locking_time', 5000),
('def_npcpbs_turret_head', 'sensor_strength', 200),
('def_npcpbs_turret_head', 'detection_strength', 125),
('def_npcpbs_turret_head', 'stealth_strength', 100),
('def_npcpbs_turret_head', 'blob_level_low', 300),
('def_npcpbs_turret_head', 'blob_level_high', 500),
('def_npcpbs_turret_chassis', 'ammo_reload_time', 10000),
('def_npcpbs_turret_chassis', 'armor_max', 75000),
('def_npcpbs_turret_chassis', 'core_max', 30000),
('def_npcpbs_turret_chassis', 'core_recharge_time', 300),
('def_npcpbs_turret_chassis', 'powergrid_max', 5000),
('def_npcpbs_turret_chassis', 'resist_chemical', @baseResist),
('def_npcpbs_turret_chassis', 'resist_explosive', @baseResist),
('def_npcpbs_turret_chassis', 'resist_kinetic', @baseResist),
('def_npcpbs_turret_chassis', 'resist_thermal', @baseResist),
('def_npcpbs_turret_chassis', 'signature_radius', 30),
('def_npcpbs_turret_chassis', 'missile_miss', 1),
('def_npcpbs_turret_chassis', 'reactor_radiation', 1),
('def_npcpbs_turret_leg', 'speed_max', 0),
('def_npcpbs_turret_leg', 'slope', 4),
--
('def_npcpbs_reactor_leg', 'armor_max', 100000),
('def_npcpbs_reactor_leg', 'resist_chemical', @baseResist),
('def_npcpbs_reactor_leg', 'resist_explosive', @baseResist),
('def_npcpbs_reactor_leg', 'resist_kinetic', @baseResist),
('def_npcpbs_reactor_leg', 'resist_thermal', @baseResist),
('def_npcpbs_reactor_leg', 'signature_radius', 30),
--
('def_npcpbs_e_transmitter_leg', 'armor_max', 50000),
('def_npcpbs_e_transmitter_leg', 'resist_chemical', @baseResist),
('def_npcpbs_e_transmitter_leg', 'resist_explosive', @baseResist),
('def_npcpbs_e_transmitter_leg', 'resist_kinetic', @baseResist),
('def_npcpbs_e_transmitter_leg', 'resist_thermal', @baseResist),
('def_npcpbs_e_transmitter_leg', 'signature_radius', 20),
--
('def_npcpbs_e_transfer_leg', 'armor_max', 50000),
('def_npcpbs_e_transfer_leg', 'resist_chemical', @baseResist),
('def_npcpbs_e_transfer_leg', 'resist_explosive', @baseResist),
('def_npcpbs_e_transfer_leg', 'resist_kinetic', @baseResist),
('def_npcpbs_e_transfer_leg', 'resist_thermal', @baseResist),
('def_npcpbs_e_transfer_leg', 'signature_radius', 20),
--
('def_npcpbs_e_battery_leg', 'armor_max', 75000),
('def_npcpbs_e_battery_leg', 'resist_chemical', @baseResist),
('def_npcpbs_e_battery_leg', 'resist_explosive', @baseResist),
('def_npcpbs_e_battery_leg', 'resist_kinetic', @baseResist),
('def_npcpbs_e_battery_leg', 'resist_thermal', @baseResist),
('def_npcpbs_e_battery_leg', 'signature_radius', 25),
--
('def_npcpbs_facility_leg', 'armor_max', 10000),
('def_npcpbs_facility_leg', 'resist_chemical', @baseResist),
('def_npcpbs_facility_leg', 'resist_explosive', @baseResist),
('def_npcpbs_facility_leg', 'resist_kinetic', @baseResist),
('def_npcpbs_facility_leg', 'resist_thermal', @baseResist),
('def_npcpbs_facility_leg', 'signature_radius', 35),
--
('def_npcpbs_facility_upgrade_leg', 'armor_max', 25000),
('def_npcpbs_facility_upgrade_leg', 'resist_chemical', @baseResist),
('def_npcpbs_facility_upgrade_leg', 'resist_explosive', @baseResist),
('def_npcpbs_facility_upgrade_leg', 'resist_kinetic', @baseResist),
('def_npcpbs_facility_upgrade_leg', 'resist_thermal', @baseResist),
('def_npcpbs_facility_upgrade_leg', 'signature_radius', 20),
--
('def_npcpbs_mining_tower_leg', 'armor_max', 75000),
('def_npcpbs_mining_tower_leg', 'resist_chemical', @baseResist),
('def_npcpbs_mining_tower_leg', 'resist_explosive', @baseResist),
('def_npcpbs_mining_tower_leg', 'resist_kinetic', @baseResist),
('def_npcpbs_mining_tower_leg', 'resist_thermal', @baseResist),
('def_npcpbs_mining_tower_leg', 'signature_radius', 30),
--
('def_npcpbs_repair_leg', 'armor_max', 50000),
('def_npcpbs_repair_leg', 'resist_chemical', @baseResist),
('def_npcpbs_repair_leg', 'resist_explosive', @baseResist),
('def_npcpbs_repair_leg', 'resist_kinetic', @baseResist),
('def_npcpbs_repair_leg', 'resist_thermal', @baseResist),
('def_npcpbs_repair_leg', 'signature_radius', 20),
--
('def_npcpbs_eff_booster_leg', 'armor_max', 25000),
('def_npcpbs_eff_booster_leg', 'resist_chemical', @baseResist),
('def_npcpbs_eff_booster_leg', 'resist_explosive', @baseResist),
('def_npcpbs_eff_booster_leg', 'resist_kinetic', @baseResist),
('def_npcpbs_eff_booster_leg', 'resist_thermal', @baseResist),
('def_npcpbs_eff_booster_leg', 'signature_radius', 20),
--
('def_npcpbs_eff_emitter_leg', 'armor_max', 25000),
('def_npcpbs_eff_emitter_leg', 'resist_chemical', @baseResist),
('def_npcpbs_eff_emitter_leg', 'resist_explosive', @baseResist),
('def_npcpbs_eff_emitter_leg', 'resist_kinetic', @baseResist),
('def_npcpbs_eff_emitter_leg', 'resist_thermal', @baseResist),
('def_npcpbs_eff_emitter_leg', 'signature_radius', 20),
--
('def_npcpbs_control_tower_leg', 'armor_max', 50000),
('def_npcpbs_control_tower_leg', 'resist_chemical', @baseResist),
('def_npcpbs_control_tower_leg', 'resist_explosive', @baseResist),
('def_npcpbs_control_tower_leg', 'resist_kinetic', @baseResist),
('def_npcpbs_control_tower_leg', 'resist_thermal', @baseResist),
('def_npcpbs_control_tower_leg', 'signature_radius', 30),
--
('def_npcpbs_base_small_leg', 'armor_max', 100000),
('def_npcpbs_base_small_leg', 'resist_chemical', @baseResist),
('def_npcpbs_base_small_leg', 'resist_explosive', @baseResist),
('def_npcpbs_base_small_leg', 'resist_kinetic', @baseResist),
('def_npcpbs_base_small_leg', 'resist_thermal', @baseResist),
('def_npcpbs_base_small_leg', 'signature_radius', 30),
--
('def_npcpbs_base_medium_leg', 'armor_max', 125000),
('def_npcpbs_base_medium_leg', 'resist_chemical', @baseResist),
('def_npcpbs_base_medium_leg', 'resist_explosive', @baseResist),
('def_npcpbs_base_medium_leg', 'resist_kinetic', @baseResist),
('def_npcpbs_base_medium_leg', 'resist_thermal', @baseResist),
('def_npcpbs_base_medium_leg', 'signature_radius', 35),
--
('def_npcpbs_base_large_leg', 'armor_max', 150000),
('def_npcpbs_base_large_leg', 'resist_chemical', @baseResist),
('def_npcpbs_base_large_leg', 'resist_explosive', @baseResist),
('def_npcpbs_base_large_leg', 'resist_kinetic', @baseResist),
('def_npcpbs_base_large_leg', 'resist_thermal', @baseResist),
('def_npcpbs_base_large_leg', 'signature_radius', 45),

--common to all non-turret npcs
('def_npcpbs_invis_head', 'cpu_max', 1000),
('def_npcpbs_invis_head', 'locked_targets_max', 0),
('def_npcpbs_invis_head', 'locking_range', 1),
('def_npcpbs_invis_head', 'locking_time', 10000),
('def_npcpbs_invis_head', 'sensor_strength', 200),
('def_npcpbs_invis_head', 'detection_strength', 125),
('def_npcpbs_invis_head', 'stealth_strength', 100),
('def_npcpbs_invis_head', 'blob_level_low', 300),
('def_npcpbs_invis_head', 'blob_level_high', 500),
('def_npcpbs_invis_head', 'ammo_reload_time', 10000),
('def_npcpbs_invis_head', 'core_max', 3000),
('def_npcpbs_invis_head', 'core_recharge_time', 1800),
('def_npcpbs_invis_head', 'powergrid_max', 1000),
('def_npcpbs_invis_head', 'missile_miss', 1),
('def_npcpbs_invis_head', 'reactor_radiation', 1),
('def_npcpbs_invis_head', 'speed_max', 0),
('def_npcpbs_invis_head', 'slope', 4),
--
('def_npc_pbs_turret_laser_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_turret_laser_rank1', 'armor_repair_amount_modifier', @turretRepAmountMod),
('def_npc_pbs_turret_laser_rank1', 'armor_repair_cycle_time_modifier', @turretRepRateMod),
('def_npc_pbs_turret_laser_rank1', 'core_max_modifier',2),
('def_npc_pbs_turret_laser_rank1', 'core_recharge_time_modifier',0.5),
('def_npc_pbs_turret_laser_rank1', 'damage_modifier', @turretDamageMod),
('def_npc_pbs_turret_laser_rank1', 'falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_laser_rank1', 'locking_range_modifier', @turretLockRangeMod),
('def_npc_pbs_turret_laser_rank1', 'locking_time_modifier', 1.25),
('def_npc_pbs_turret_laser_rank1', 'missile_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_laser_rank1', 'optimal_range_modifier', @turretOptimalMod),
('def_npc_pbs_turret_laser_rank1', 'turret_fallof_modifier', @turretFalloffMod),
('def_npc_pbs_turret_laser_rank1', 'resist_chemical', @turretResist),
('def_npc_pbs_turret_laser_rank1', 'resist_explosive', @turretResist),
('def_npc_pbs_turret_laser_rank1', 'resist_kinetic', @turretResist),
('def_npc_pbs_turret_laser_rank1', 'resist_thermal', @turretResistPeak),
('def_npc_pbs_turret_laser_rank1', 'turret_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_laser_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_turret_em_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_turret_em_rank1', 'armor_repair_amount_modifier', @turretRepAmountMod),
('def_npc_pbs_turret_em_rank1', 'armor_repair_cycle_time_modifier', @turretRepRateMod),
('def_npc_pbs_turret_em_rank1', 'core_max_modifier',2),
('def_npc_pbs_turret_em_rank1', 'core_recharge_time_modifier',0.5),
('def_npc_pbs_turret_em_rank1', 'damage_modifier', @turretDamageMod),
('def_npc_pbs_turret_em_rank1', 'falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_em_rank1', 'locking_range_modifier', @turretLockRangeMod),
('def_npc_pbs_turret_em_rank1', 'locking_time_modifier', 1.25),
('def_npc_pbs_turret_em_rank1', 'missile_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_em_rank1', 'optimal_range_modifier', @turretOptimalMod),
('def_npc_pbs_turret_em_rank1', 'turret_fallof_modifier', @turretFalloffMod),
('def_npc_pbs_turret_em_rank1', 'resist_chemical', @turretResist),
('def_npc_pbs_turret_em_rank1', 'resist_explosive', @turretResist),
('def_npc_pbs_turret_em_rank1', 'resist_kinetic', @turretResistPeak),
('def_npc_pbs_turret_em_rank1', 'resist_thermal', @turretResist),
('def_npc_pbs_turret_em_rank1', 'turret_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_em_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_turret_missile_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_turret_missile_rank1', 'armor_repair_amount_modifier', @turretRepAmountMod),
('def_npc_pbs_turret_missile_rank1', 'armor_repair_cycle_time_modifier', @turretRepRateMod),
('def_npc_pbs_turret_missile_rank1', 'core_max_modifier',2),
('def_npc_pbs_turret_missile_rank1', 'core_recharge_time_modifier',0.5),
('def_npc_pbs_turret_missile_rank1', 'damage_modifier', @turretDamageMod),
('def_npc_pbs_turret_missile_rank1', 'falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_missile_rank1', 'locking_range_modifier', @turretLockRangeMod),
('def_npc_pbs_turret_missile_rank1', 'locking_time_modifier', 1.25),
('def_npc_pbs_turret_missile_rank1', 'missile_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_missile_rank1', 'effect_missile_range_modifier', 1.1),
('def_npc_pbs_turret_missile_rank1', 'optimal_range_modifier', @turretOptimalMod),
('def_npc_pbs_turret_missile_rank1', 'missile_falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_missile_rank1', 'resist_chemical', @turretResist),
('def_npc_pbs_turret_missile_rank1', 'resist_explosive', @turretResistPeak),
('def_npc_pbs_turret_missile_rank1', 'resist_kinetic', @turretResist),
('def_npc_pbs_turret_missile_rank1', 'resist_thermal', @turretResist),
('def_npc_pbs_turret_missile_rank1', 'turret_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_missile_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_turret_ew_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_turret_ew_rank1', 'armor_repair_amount_modifier', @turretRepAmountMod),
('def_npc_pbs_turret_ew_rank1', 'armor_repair_cycle_time_modifier', @turretRepRateMod),
('def_npc_pbs_turret_ew_rank1', 'core_max_modifier',2),
('def_npc_pbs_turret_ew_rank1', 'core_recharge_time_modifier',0.5),
('def_npc_pbs_turret_ew_rank1', 'damage_modifier', @turretDamageMod),
('def_npc_pbs_turret_ew_rank1', 'ecm_strength_modifier', @turretDamageMod),
('def_npc_pbs_turret_ew_rank1', 'energy_neutralized_amount_modifier', @turretDamageMod),
('def_npc_pbs_turret_ew_rank1', 'falloff_modifier', @turretFalloffMod),
('def_npc_pbs_turret_ew_rank1', 'locking_range_modifier', @turretLockRangeMod),
('def_npc_pbs_turret_ew_rank1', 'locking_time_modifier', 1.25),
('def_npc_pbs_turret_ew_rank1', 'missile_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_ew_rank1', 'optimal_range_modifier', @turretOptimalMod),
('def_npc_pbs_turret_ew_rank1', 'resist_chemical', @turretResist),
('def_npc_pbs_turret_ew_rank1', 'resist_explosive', @turretResist),
('def_npc_pbs_turret_ew_rank1', 'resist_kinetic', @turretResist),
('def_npc_pbs_turret_ew_rank1', 'resist_thermal', @turretResist),
('def_npc_pbs_turret_ew_rank1', 'turret_cycle_time_modifier', 1.1),
('def_npc_pbs_turret_ew_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_reactor_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_reactor_rank1', 'resist_chemical', @baseResist),
('def_npc_pbs_reactor_rank1', 'resist_explosive', @baseResist),
('def_npc_pbs_reactor_rank1', 'resist_kinetic', @baseResist),
('def_npc_pbs_reactor_rank1', 'resist_thermal', @baseResist),
('def_npc_pbs_reactor_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_e_emitter_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_e_emitter_rank1', 'resist_chemical', @baseResist),
('def_npc_pbs_e_emitter_rank1', 'resist_explosive', @baseResist),
('def_npc_pbs_e_emitter_rank1', 'resist_kinetic', @baseResist),
('def_npc_pbs_e_emitter_rank1', 'resist_thermal', @baseResist),
('def_npc_pbs_e_emitter_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_e_transfer_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_e_transfer_rank1', 'resist_chemical', @baseResist),
('def_npc_pbs_e_transfer_rank1', 'resist_explosive', @baseResist),
('def_npc_pbs_e_transfer_rank1', 'resist_kinetic', @baseResist),
('def_npc_pbs_e_transfer_rank1', 'resist_thermal', @baseResist),
('def_npc_pbs_e_transfer_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_e_battery_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_e_battery_rank1', 'resist_chemical', @baseResist),
('def_npc_pbs_e_battery_rank1', 'resist_explosive', @baseResist),
('def_npc_pbs_e_battery_rank1', 'resist_kinetic', @baseResist),
('def_npc_pbs_e_battery_rank1', 'resist_thermal', @baseResist),
('def_npc_pbs_e_battery_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_facility_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_facility_rank1', 'resist_chemical', @baseResist),
('def_npc_pbs_facility_rank1', 'resist_explosive', @baseResist),
('def_npc_pbs_facility_rank1', 'resist_kinetic', @baseResist),
('def_npc_pbs_facility_rank1', 'resist_thermal', @baseResist),
('def_npc_pbs_facility_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_facility_upgrade_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_facility_upgrade_rank1', 'resist_chemical', @baseResist),
('def_npc_pbs_facility_upgrade_rank1', 'resist_explosive', @baseResist),
('def_npc_pbs_facility_upgrade_rank1', 'resist_kinetic', @baseResist),
('def_npc_pbs_facility_upgrade_rank1', 'resist_thermal', @baseResist),
('def_npc_pbs_facility_upgrade_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_miner_tower_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_miner_tower_rank1', 'resist_chemical', @baseResist),
('def_npc_pbs_miner_tower_rank1', 'resist_explosive', @baseResist),
('def_npc_pbs_miner_tower_rank1', 'resist_kinetic', @baseResist),
('def_npc_pbs_miner_tower_rank1', 'resist_thermal', @baseResist),
('def_npc_pbs_miner_tower_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_energy_tower_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_energy_tower_rank1', 'resist_chemical', @baseResist),
('def_npc_pbs_energy_tower_rank1', 'resist_explosive', @baseResist),
('def_npc_pbs_energy_tower_rank1', 'resist_kinetic', @baseResist),
('def_npc_pbs_energy_tower_rank1', 'resist_thermal', @baseResist),
('def_npc_pbs_energy_tower_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_repair_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_repair_rank1', 'resist_chemical', @baseResist),
('def_npc_pbs_repair_rank1', 'resist_explosive', @baseResist),
('def_npc_pbs_repair_rank1', 'resist_kinetic', @baseResist),
('def_npc_pbs_repair_rank1', 'resist_thermal', @baseResist),
('def_npc_pbs_repair_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_eff_booster_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_eff_booster_rank1', 'resist_chemical', @baseResist),
('def_npc_pbs_eff_booster_rank1', 'resist_explosive', @baseResist),
('def_npc_pbs_eff_booster_rank1', 'resist_kinetic', @baseResist),
('def_npc_pbs_eff_booster_rank1', 'resist_thermal', @baseResist),
('def_npc_pbs_eff_booster_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_eff_emitter_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_eff_emitter_rank1', 'resist_chemical', @baseResist),
('def_npc_pbs_eff_emitter_rank1', 'resist_explosive', @baseResist),
('def_npc_pbs_eff_emitter_rank1', 'resist_kinetic', @baseResist),
('def_npc_pbs_eff_emitter_rank1', 'resist_thermal', @baseResist),
('def_npc_pbs_eff_emitter_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_control_tower_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_control_tower_rank1', 'resist_chemical', @baseResist),
('def_npc_pbs_control_tower_rank1', 'resist_explosive', @baseResist),
('def_npc_pbs_control_tower_rank1', 'resist_kinetic', @baseResist),
('def_npc_pbs_control_tower_rank1', 'resist_thermal', @baseResist),
('def_npc_pbs_control_tower_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_base_small_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_base_small_rank1', 'resist_chemical', @baseResist),
('def_npc_pbs_base_small_rank1', 'resist_explosive', @baseResist),
('def_npc_pbs_base_small_rank1', 'resist_kinetic', @baseResist),
('def_npc_pbs_base_small_rank1', 'resist_thermal', @baseResist),
('def_npc_pbs_base_small_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_base_medium_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_base_medium_rank1', 'resist_chemical', @baseResist),
('def_npc_pbs_base_medium_rank1', 'resist_explosive', @baseResist),
('def_npc_pbs_base_medium_rank1', 'resist_kinetic', @baseResist),
('def_npc_pbs_base_medium_rank1', 'resist_thermal', @baseResist),
('def_npc_pbs_base_medium_rank1', 'received_repaired_modifier', 1.1),
--
('def_npc_pbs_base_large_rank1', 'armor_max_modifier', 1.05),
('def_npc_pbs_base_large_rank1', 'resist_chemical', @baseResist),
('def_npc_pbs_base_large_rank1', 'resist_explosive', @baseResist),
('def_npc_pbs_base_large_rank1', 'resist_kinetic', @baseResist),
('def_npc_pbs_base_large_rank1', 'resist_thermal', @baseResist),
('def_npc_pbs_base_large_rank1', 'received_repaired_modifier', 1.1), 

('def_npc_sh70_miniboss_a', 'armor_max_modifier',5.5),
('def_npc_sh70_miniboss_a', 'armor_repair_amount_modifier', 1.55),
('def_npc_sh70_miniboss_a', 'armor_repair_cycle_time_modifier', 0.67),
('def_npc_sh70_miniboss_a', 'core_max_modifier',5.25),
('def_npc_sh70_miniboss_a', 'core_recharge_time_modifier',0.55),
('def_npc_sh70_miniboss_a', 'cpu_max_modifier',2),
('def_npc_sh70_miniboss_a', 'damage_modifier', 3),
('def_npc_sh70_miniboss_a', 'detection_strength_modifier',15),
('def_npc_sh70_miniboss_a', 'falloff_modifier',2.5),
('def_npc_sh70_miniboss_a', 'missile_falloff_modifier', 2.5),
('def_npc_sh70_miniboss_a', 'locking_range_modifier',4),
('def_npc_sh70_miniboss_a', 'locking_time_modifier',1.25),
('def_npc_sh70_miniboss_a', 'locked_targets_max_bonus',10),
('def_npc_sh70_miniboss_a', 'missile_cycle_time_modifier',1),
('def_npc_sh70_miniboss_a', 'optimal_range_modifier',3),
('def_npc_sh70_miniboss_a', 'powergrid_max_modifier',3),
('def_npc_sh70_miniboss_a', 'resist_chemical',400),
('def_npc_sh70_miniboss_a', 'resist_explosive',400),
('def_npc_sh70_miniboss_a', 'resist_kinetic',400),
('def_npc_sh70_miniboss_a', 'resist_thermal',400),
('def_npc_sh70_miniboss_a', 'speed_max_modifier', 1.5),
('def_npc_sh70_miniboss_a', 'turret_fallof_modifier', 2.5),
('def_npc_sh70_miniboss_a', 'turret_cycle_time_modifier',1),
('def_npc_sh70_miniboss_a', 'received_repaired_modifier',1.25),

('def_npc_sh70_miniboss_b', 'armor_max_modifier',5.5),
('def_npc_sh70_miniboss_b', 'armor_repair_amount_modifier', 1.55),
('def_npc_sh70_miniboss_b', 'armor_repair_cycle_time_modifier', 0.67),
('def_npc_sh70_miniboss_b', 'core_max_modifier',5.25),
('def_npc_sh70_miniboss_b', 'core_recharge_time_modifier',0.55),
('def_npc_sh70_miniboss_b', 'cpu_max_modifier',2),
('def_npc_sh70_miniboss_b', 'damage_modifier', 3),
('def_npc_sh70_miniboss_b', 'detection_strength_modifier',15),
('def_npc_sh70_miniboss_b', 'falloff_modifier',2.5),
('def_npc_sh70_miniboss_b', 'missile_falloff_modifier', 2.5),
('def_npc_sh70_miniboss_b', 'locking_range_modifier',4),
('def_npc_sh70_miniboss_b', 'locking_time_modifier',1.25),
('def_npc_sh70_miniboss_b', 'locked_targets_max_bonus',10),
('def_npc_sh70_miniboss_b', 'missile_cycle_time_modifier',1),
('def_npc_sh70_miniboss_b', 'optimal_range_modifier',3),
('def_npc_sh70_miniboss_b', 'powergrid_max_modifier',3),
('def_npc_sh70_miniboss_b', 'resist_chemical',400),
('def_npc_sh70_miniboss_b', 'resist_explosive',400),
('def_npc_sh70_miniboss_b', 'resist_kinetic',400),
('def_npc_sh70_miniboss_b', 'resist_thermal',400),
('def_npc_sh70_miniboss_b', 'speed_max_modifier', 1.5),
('def_npc_sh70_miniboss_b', 'turret_fallof_modifier', 2.5),
('def_npc_sh70_miniboss_b', 'turret_cycle_time_modifier',1),
('def_npc_sh70_miniboss_b', 'received_repaired_modifier',1.25),

('def_npc_sh70_mainboss', 'armor_max_modifier',5.5),
('def_npc_sh70_mainboss', 'armor_repair_amount_modifier', 2.55),
('def_npc_sh70_mainboss', 'armor_repair_cycle_time_modifier', 0.67),
('def_npc_sh70_mainboss', 'core_max_modifier',5.25),
('def_npc_sh70_mainboss', 'core_recharge_time_modifier',0.65),
('def_npc_sh70_mainboss', 'cpu_max_modifier',2),
('def_npc_sh70_mainboss', 'damage_modifier', 5),
('def_npc_sh70_mainboss', 'detection_strength_modifier',5),
('def_npc_sh70_mainboss', 'falloff_modifier',2.5),
('def_npc_sh70_mainboss', 'missile_falloff_modifier', 2.5),
('def_npc_sh70_mainboss', 'locking_range_modifier',4),
('def_npc_sh70_mainboss', 'locking_time_modifier',1.25),
('def_npc_sh70_mainboss', 'locked_targets_max_bonus',10),
('def_npc_sh70_mainboss', 'missile_cycle_time_modifier',1),
('def_npc_sh70_mainboss', 'optimal_range_modifier',3),
('def_npc_sh70_mainboss', 'powergrid_max_modifier',3),
('def_npc_sh70_mainboss', 'resist_chemical',600),
('def_npc_sh70_mainboss', 'resist_explosive',600),
('def_npc_sh70_mainboss', 'resist_kinetic',600),
('def_npc_sh70_mainboss', 'resist_thermal',600),
('def_npc_sh70_mainboss', 'speed_max_modifier', 1.75),
('def_npc_sh70_mainboss', 'turret_cycle_time_modifier',1),
('def_npc_sh70_mainboss', 'received_repaired_modifier',1.25);

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

DELETE FROM robottemplaterelation WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #TEMPRELATIONS));
DELETE FROM robottemplates WHERE name in (SELECT tempName FROM #TEMPLATES);

INSERT INTO robottemplates (name, description, note)
SELECT t.tempName,
	'#robot=i'+dbo.ToHex((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=t.botName))+
	'#head=i'+dbo.ToHex((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=t.headName))+
	'#chassis=i'+dbo.ToHex((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=t.chassisName))+
	'#leg=i'+dbo.ToHex((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=t.legName))+
	'#container=i'+dbo.ToHex((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=t.inventoryName))+
	t.loadOut,
	'NPC PBS TEMPLATE'
 FROM #TEMPLATES as t;


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
