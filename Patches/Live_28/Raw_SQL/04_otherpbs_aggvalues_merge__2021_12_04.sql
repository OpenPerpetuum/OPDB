USE [perpetuumsa]
GO

-----------------------------------------------
-- All other Base Stats
-- 
-- Date modified: 2021/12/04
-----------------------------------------------

DROP TABLE IF EXISTS #BASE_STATS;
CREATE TABLE #BASE_STATS(
	defName VARCHAR(128),
	fieldName VARCHAR(128),
	modValue FLOAT
);
INSERT INTO #BASE_STATS (defName, fieldName, modValue) VALUES
('def_pbs_armor_repairer_large','stealth_strength',50),
('def_pbs_armor_repairer_large','signature_radius',30),
('def_pbs_armor_repairer_large','resist_thermal',120),
('def_pbs_armor_repairer_large','resist_kinetic',120),
('def_pbs_armor_repairer_large','resist_explosive',120),
('def_pbs_armor_repairer_large','resist_chemical',120),
('def_pbs_armor_repairer_large','core_max',6000),
('def_pbs_armor_repairer_large','armor_max',75000),
('def_pbs_armor_repairer_medium','stealth_strength',50),
('def_pbs_armor_repairer_medium','signature_radius',25),
('def_pbs_armor_repairer_medium','resist_thermal',75),
('def_pbs_armor_repairer_medium','resist_kinetic',75),
('def_pbs_armor_repairer_medium','resist_explosive',75),
('def_pbs_armor_repairer_medium','resist_chemical',75),
('def_pbs_armor_repairer_medium','core_max',5500),
('def_pbs_armor_repairer_medium','armor_max',65000),
('def_pbs_armor_repairer_small','stealth_strength',50),
('def_pbs_armor_repairer_small','signature_radius',20),
('def_pbs_armor_repairer_small','resist_thermal',30),
('def_pbs_armor_repairer_small','resist_kinetic',30),
('def_pbs_armor_repairer_small','resist_explosive',30),
('def_pbs_armor_repairer_small','resist_chemical',30),
('def_pbs_armor_repairer_small','core_max',5000),
('def_pbs_armor_repairer_small','armor_max',50000),
('def_pbs_aura_emitter_large','stealth_strength',50),
('def_pbs_aura_emitter_large','signature_radius',30),
('def_pbs_aura_emitter_large','resist_thermal',120),
('def_pbs_aura_emitter_large','resist_kinetic',120),
('def_pbs_aura_emitter_large','resist_explosive',120),
('def_pbs_aura_emitter_large','resist_chemical',120),
('def_pbs_aura_emitter_large','core_max',45000),
('def_pbs_aura_emitter_large','armor_max',75000),
('def_pbs_aura_emitter_medium','stealth_strength',50),
('def_pbs_aura_emitter_medium','signature_radius',25),
('def_pbs_aura_emitter_medium','resist_thermal',75),
('def_pbs_aura_emitter_medium','resist_kinetic',75),
('def_pbs_aura_emitter_medium','resist_explosive',75),
('def_pbs_aura_emitter_medium','resist_chemical',75),
('def_pbs_aura_emitter_medium','core_max',41250),
('def_pbs_aura_emitter_medium','armor_max',65000),
('def_pbs_aura_emitter_small','stealth_strength',50),
('def_pbs_aura_emitter_small','signature_radius',20),
('def_pbs_aura_emitter_small','resist_thermal',30),
('def_pbs_aura_emitter_small','resist_kinetic',30),
('def_pbs_aura_emitter_small','resist_explosive',30),
('def_pbs_aura_emitter_small','resist_chemical',30),
('def_pbs_aura_emitter_small','core_max',37500),
('def_pbs_aura_emitter_small','armor_max',50000),
('def_pbs_calibration_forge_large','stealth_strength',50),
('def_pbs_calibration_forge_large','signature_radius',120),
('def_pbs_calibration_forge_large','resist_thermal',120),
('def_pbs_calibration_forge_large','resist_kinetic',120),
('def_pbs_calibration_forge_large','resist_explosive',120),
('def_pbs_calibration_forge_large','resist_chemical',120),
('def_pbs_calibration_forge_large','core_max',3000),
('def_pbs_calibration_forge_large','armor_max',300000),
('def_pbs_calibration_forge_medium','stealth_strength',50),
('def_pbs_calibration_forge_medium','signature_radius',65),
('def_pbs_calibration_forge_medium','resist_thermal',75),
('def_pbs_calibration_forge_medium','resist_kinetic',75),
('def_pbs_calibration_forge_medium','resist_explosive',75),
('def_pbs_calibration_forge_medium','resist_chemical',75),
('def_pbs_calibration_forge_medium','core_max',2750),
('def_pbs_calibration_forge_medium','armor_max',250000),
('def_pbs_calibration_forge_small','stealth_strength',50),
('def_pbs_calibration_forge_small','signature_radius',50),
('def_pbs_calibration_forge_small','resist_thermal',30),
('def_pbs_calibration_forge_small','resist_kinetic',30),
('def_pbs_calibration_forge_small','resist_explosive',30),
('def_pbs_calibration_forge_small','resist_chemical',30),
('def_pbs_calibration_forge_small','core_max',2500),
('def_pbs_calibration_forge_small','armor_max',200000),
('def_pbs_control_tower_large','stealth_strength',50),
('def_pbs_control_tower_large','signature_radius',30),
('def_pbs_control_tower_large','resist_thermal',120),
('def_pbs_control_tower_large','resist_kinetic',120),
('def_pbs_control_tower_large','resist_explosive',120),
('def_pbs_control_tower_large','resist_chemical',120),
('def_pbs_control_tower_large','armor_max',75000),
('def_pbs_control_tower_medium','stealth_strength',50),
('def_pbs_control_tower_medium','signature_radius',25),
('def_pbs_control_tower_medium','resist_thermal',75),
('def_pbs_control_tower_medium','resist_kinetic',75),
('def_pbs_control_tower_medium','resist_explosive',75),
('def_pbs_control_tower_medium','resist_chemical',75),
('def_pbs_control_tower_medium','armor_max',65000),
('def_pbs_control_tower_small','stealth_strength',50),
('def_pbs_control_tower_small','signature_radius',20),
('def_pbs_control_tower_small','resist_thermal',30),
('def_pbs_control_tower_small','resist_kinetic',30),
('def_pbs_control_tower_small','resist_explosive',30),
('def_pbs_control_tower_small','resist_chemical',30),
('def_pbs_control_tower_small','armor_max',50000),
('def_pbs_core_battery_large','stealth_strength',50),
('def_pbs_core_battery_large','signature_radius',60),
('def_pbs_core_battery_large','resist_thermal',120),
('def_pbs_core_battery_large','resist_kinetic',120),
('def_pbs_core_battery_large','resist_explosive',120),
('def_pbs_core_battery_large','resist_chemical',120),
('def_pbs_core_battery_large','core_max',19152000),
('def_pbs_core_battery_large','armor_max',75000),
('def_pbs_core_battery_medium','stealth_strength',50),
('def_pbs_core_battery_medium','signature_radius',50),
('def_pbs_core_battery_medium','resist_thermal',75),
('def_pbs_core_battery_medium','resist_kinetic',75),
('def_pbs_core_battery_medium','resist_explosive',75),
('def_pbs_core_battery_medium','resist_chemical',75),
('def_pbs_core_battery_medium','core_max',16128000),
('def_pbs_core_battery_medium','armor_max',65000),
('def_pbs_core_battery_small','stealth_strength',50),
('def_pbs_core_battery_small','signature_radius',40),
('def_pbs_core_battery_small','resist_thermal',30),
('def_pbs_core_battery_small','resist_kinetic',30),
('def_pbs_core_battery_small','resist_explosive',30),
('def_pbs_core_battery_small','resist_chemical',30),
('def_pbs_core_battery_small','core_max',14112000),
('def_pbs_core_battery_small','armor_max',50000),
('def_pbs_core_transmitter_large','stealth_strength',50),
('def_pbs_core_transmitter_large','signature_radius',30),
('def_pbs_core_transmitter_large','resist_thermal',120),
('def_pbs_core_transmitter_large','resist_kinetic',120),
('def_pbs_core_transmitter_large','resist_explosive',120),
('def_pbs_core_transmitter_large','resist_chemical',120),
('def_pbs_core_transmitter_large','core_max',24000),
('def_pbs_core_transmitter_large','armor_max',30000),
('def_pbs_core_transmitter_medium','stealth_strength',50),
('def_pbs_core_transmitter_medium','signature_radius',25),
('def_pbs_core_transmitter_medium','resist_thermal',75),
('def_pbs_core_transmitter_medium','resist_kinetic',75),
('def_pbs_core_transmitter_medium','resist_explosive',75),
('def_pbs_core_transmitter_medium','resist_chemical',75),
('def_pbs_core_transmitter_medium','core_max',21000),
('def_pbs_core_transmitter_medium','armor_max',25000),
('def_pbs_core_transmitter_small','stealth_strength',50),
('def_pbs_core_transmitter_small','signature_radius',20),
('def_pbs_core_transmitter_small','resist_thermal',30),
('def_pbs_core_transmitter_small','resist_kinetic',30),
('def_pbs_core_transmitter_small','resist_explosive',30),
('def_pbs_core_transmitter_small','resist_chemical',30),
('def_pbs_core_transmitter_small','core_max',18000),
('def_pbs_core_transmitter_small','armor_max',20000),
('def_pbs_docking_base_large','stealth_strength',50),
('def_pbs_docking_base_large','signature_radius',150),
('def_pbs_docking_base_large','resist_thermal',120),
('def_pbs_docking_base_large','resist_kinetic',120),
('def_pbs_docking_base_large','resist_explosive',120),
('def_pbs_docking_base_large','resist_chemical',120),
('def_pbs_docking_base_large','armor_max',750000),
('def_pbs_docking_base_medium','stealth_strength',50),
('def_pbs_docking_base_medium','signature_radius',125),
('def_pbs_docking_base_medium','resist_thermal',75),
('def_pbs_docking_base_medium','resist_kinetic',75),
('def_pbs_docking_base_medium','resist_explosive',75),
('def_pbs_docking_base_medium','resist_chemical',75),
('def_pbs_docking_base_medium','armor_max',650000),
('def_pbs_docking_base_small','stealth_strength',50),
('def_pbs_docking_base_small','signature_radius',100),
('def_pbs_docking_base_small','resist_thermal',30),
('def_pbs_docking_base_small','resist_kinetic',30),
('def_pbs_docking_base_small','resist_explosive',30),
('def_pbs_docking_base_small','resist_chemical',30),
('def_pbs_docking_base_small','armor_max',500000),
('def_pbs_effect_supplier_large','stealth_strength',50),
('def_pbs_effect_supplier_large','signature_radius',30),
('def_pbs_effect_supplier_large','resist_thermal',120),
('def_pbs_effect_supplier_large','resist_kinetic',120),
('def_pbs_effect_supplier_large','resist_explosive',120),
('def_pbs_effect_supplier_large','resist_chemical',120),
('def_pbs_effect_supplier_large','core_max',3750),
('def_pbs_effect_supplier_large','armor_max',45000),
('def_pbs_effect_supplier_medium','stealth_strength',50),
('def_pbs_effect_supplier_medium','signature_radius',25),
('def_pbs_effect_supplier_medium','resist_thermal',75),
('def_pbs_effect_supplier_medium','resist_kinetic',75),
('def_pbs_effect_supplier_medium','resist_explosive',75),
('def_pbs_effect_supplier_medium','resist_chemical',75),
('def_pbs_effect_supplier_medium','core_max',3125),
('def_pbs_effect_supplier_medium','armor_max',37500),
('def_pbs_effect_supplier_small','stealth_strength',50),
('def_pbs_effect_supplier_small','signature_radius',20),
('def_pbs_effect_supplier_small','resist_thermal',30),
('def_pbs_effect_supplier_small','resist_kinetic',30),
('def_pbs_effect_supplier_small','resist_explosive',30),
('def_pbs_effect_supplier_small','resist_chemical',30),
('def_pbs_effect_supplier_small','core_max',2500),
('def_pbs_effect_supplier_small','armor_max',30000),
('def_pbs_energywell_large','stealth_strength',50),
('def_pbs_energywell_large','signature_radius',30),
('def_pbs_energywell_large','resist_thermal',120),
('def_pbs_energywell_large','resist_kinetic',120),
('def_pbs_energywell_large','resist_explosive',120),
('def_pbs_energywell_large','resist_chemical',120),
('def_pbs_energywell_large','armor_max',30000),
('def_pbs_energywell_medium','stealth_strength',50),
('def_pbs_energywell_medium','signature_radius',25),
('def_pbs_energywell_medium','resist_thermal',75),
('def_pbs_energywell_medium','resist_kinetic',75),
('def_pbs_energywell_medium','resist_explosive',75),
('def_pbs_energywell_medium','resist_chemical',75),
('def_pbs_energywell_medium','armor_max',25000),
('def_pbs_energywell_small','stealth_strength',50),
('def_pbs_energywell_small','signature_radius',20),
('def_pbs_energywell_small','resist_thermal',30),
('def_pbs_energywell_small','resist_kinetic',30),
('def_pbs_energywell_small','resist_explosive',30),
('def_pbs_energywell_small','resist_chemical',30),
('def_pbs_energywell_small','armor_max',20000),
--('def_pbs_expiring_docking_base','stealth_strength',80),
--('def_pbs_expiring_docking_base','signature_radius',100),
--('def_pbs_expiring_docking_base','resist_thermal',50),
--('def_pbs_expiring_docking_base','resist_kinetic',50),
--('def_pbs_expiring_docking_base','resist_explosive',50),
--('def_pbs_expiring_docking_base','resist_chemical',50),
--('def_pbs_expiring_docking_base','armor_max',250000),
('def_pbs_highwaynode_large','stealth_strength',50),
('def_pbs_highwaynode_large','signature_radius',75),
('def_pbs_highwaynode_large','resist_thermal',300),
('def_pbs_highwaynode_large','resist_kinetic',300),
('def_pbs_highwaynode_large','resist_explosive',300),
('def_pbs_highwaynode_large','resist_chemical',300),
('def_pbs_highwaynode_large','core_recharge_time',345600),
('def_pbs_highwaynode_large','core_max',4500),
('def_pbs_highwaynode_large','armor_max',15000),
('def_pbs_highwaynode_medium','stealth_strength',50),
('def_pbs_highwaynode_medium','signature_radius',65),
('def_pbs_highwaynode_medium','resist_thermal',225),
('def_pbs_highwaynode_medium','resist_kinetic',225),
('def_pbs_highwaynode_medium','resist_explosive',225),
('def_pbs_highwaynode_medium','resist_chemical',225),
('def_pbs_highwaynode_medium','core_recharge_time',345600),
('def_pbs_highwaynode_medium','core_max',3750),
('def_pbs_highwaynode_medium','armor_max',12500),
('def_pbs_highwaynode_small','stealth_strength',50),
('def_pbs_highwaynode_small','signature_radius',50),
('def_pbs_highwaynode_small','resist_thermal',150),
('def_pbs_highwaynode_small','resist_kinetic',150),
('def_pbs_highwaynode_small','resist_explosive',150),
('def_pbs_highwaynode_small','resist_chemical',150),
('def_pbs_highwaynode_small','core_recharge_time',345600),
('def_pbs_highwaynode_small','core_max',3000),
('def_pbs_highwaynode_small','armor_max',10000),
('def_pbs_maskertower_large','stealth_strength',50),
('def_pbs_maskertower_large','signature_radius',30),
('def_pbs_maskertower_large','resist_thermal',120),
('def_pbs_maskertower_large','resist_kinetic',120),
('def_pbs_maskertower_large','resist_explosive',120),
('def_pbs_maskertower_large','resist_chemical',120),
('def_pbs_maskertower_large','core_max',30000),
('def_pbs_maskertower_large','armor_max',75000),
('def_pbs_maskertower_medium','stealth_strength',50),
('def_pbs_maskertower_medium','signature_radius',25),
('def_pbs_maskertower_medium','resist_thermal',75),
('def_pbs_maskertower_medium','resist_kinetic',75),
('def_pbs_maskertower_medium','resist_explosive',75),
('def_pbs_maskertower_medium','resist_chemical',75),
('def_pbs_maskertower_medium','core_max',27500),
('def_pbs_maskertower_medium','armor_max',65000),
('def_pbs_maskertower_small','stealth_strength',50),
('def_pbs_maskertower_small','signature_radius',20),
('def_pbs_maskertower_small','resist_thermal',30),
('def_pbs_maskertower_small','resist_kinetic',30),
('def_pbs_maskertower_small','resist_explosive',30),
('def_pbs_maskertower_small','resist_chemical',30),
('def_pbs_maskertower_small','core_max',25000),
('def_pbs_maskertower_small','armor_max',50000),
('def_pbs_mill_large','stealth_strength',50),
('def_pbs_mill_large','signature_radius',120),
('def_pbs_mill_large','resist_thermal',120),
('def_pbs_mill_large','resist_kinetic',120),
('def_pbs_mill_large','resist_explosive',120),
('def_pbs_mill_large','resist_chemical',120),
('def_pbs_mill_large','core_max',3000),
('def_pbs_mill_large','armor_max',300000),
('def_pbs_mill_medium','stealth_strength',50),
('def_pbs_mill_medium','signature_radius',65),
('def_pbs_mill_medium','resist_thermal',75),
('def_pbs_mill_medium','resist_kinetic',75),
('def_pbs_mill_medium','resist_explosive',75),
('def_pbs_mill_medium','resist_chemical',75),
('def_pbs_mill_medium','core_max',2750),
('def_pbs_mill_medium','armor_max',250000),
('def_pbs_mill_small','stealth_strength',50),
('def_pbs_mill_small','signature_radius',50),
('def_pbs_mill_small','resist_thermal',30),
('def_pbs_mill_small','resist_kinetic',30),
('def_pbs_mill_small','resist_explosive',30),
('def_pbs_mill_small','resist_chemical',30),
('def_pbs_mill_small','core_max',2500),
('def_pbs_mill_small','armor_max',200000),
('def_pbs_mining_tower_large','stealth_strength',50),
('def_pbs_mining_tower_large','signature_radius',45),
('def_pbs_mining_tower_large','resist_thermal',120),
('def_pbs_mining_tower_large','resist_kinetic',120),
('def_pbs_mining_tower_large','resist_explosive',120),
('def_pbs_mining_tower_large','resist_chemical',120),
('def_pbs_mining_tower_large','core_max',30000),
('def_pbs_mining_tower_large','armor_max',150000),
('def_pbs_mining_tower_medium','stealth_strength',50),
('def_pbs_mining_tower_medium','signature_radius',37.5),
('def_pbs_mining_tower_medium','resist_thermal',75),
('def_pbs_mining_tower_medium','resist_kinetic',75),
('def_pbs_mining_tower_medium','resist_explosive',75),
('def_pbs_mining_tower_medium','resist_chemical',75),
('def_pbs_mining_tower_medium','core_max',27500),
('def_pbs_mining_tower_medium','armor_max',125000),
('def_pbs_mining_tower_small','stealth_strength',50),
('def_pbs_mining_tower_small','signature_radius',30),
('def_pbs_mining_tower_small','resist_thermal',30),
('def_pbs_mining_tower_small','resist_kinetic',30),
('def_pbs_mining_tower_small','resist_explosive',30),
('def_pbs_mining_tower_small','resist_chemical',30),
('def_pbs_mining_tower_small','core_max',25000),
('def_pbs_mining_tower_small','armor_max',100000),
('def_pbs_production_upgrade_large','stealth_strength',50),
('def_pbs_production_upgrade_large','signature_radius',30),
('def_pbs_production_upgrade_large','resist_thermal',120),
('def_pbs_production_upgrade_large','resist_kinetic',120),
('def_pbs_production_upgrade_large','resist_explosive',120),
('def_pbs_production_upgrade_large','resist_chemical',120),
('def_pbs_production_upgrade_large','core_max',750),
('def_pbs_production_upgrade_large','armor_max',45000),
('def_pbs_production_upgrade_medium','stealth_strength',50),
('def_pbs_production_upgrade_medium','signature_radius',25),
('def_pbs_production_upgrade_medium','resist_thermal',75),
('def_pbs_production_upgrade_medium','resist_kinetic',75),
('def_pbs_production_upgrade_medium','resist_explosive',75),
('def_pbs_production_upgrade_medium','resist_chemical',75),
('def_pbs_production_upgrade_medium','core_max',625),
('def_pbs_production_upgrade_medium','armor_max',37500),
('def_pbs_production_upgrade_small','stealth_strength',50),
('def_pbs_production_upgrade_small','signature_radius',20),
('def_pbs_production_upgrade_small','resist_thermal',30),
('def_pbs_production_upgrade_small','resist_kinetic',30),
('def_pbs_production_upgrade_small','resist_explosive',30),
('def_pbs_production_upgrade_small','resist_chemical',30),
('def_pbs_production_upgrade_small','core_max',500),
('def_pbs_production_upgrade_small','armor_max',30000),
('def_pbs_prototyper_large','stealth_strength',50),
('def_pbs_prototyper_large','signature_radius',120),
('def_pbs_prototyper_large','resist_thermal',120),
('def_pbs_prototyper_large','resist_kinetic',120),
('def_pbs_prototyper_large','resist_explosive',120),
('def_pbs_prototyper_large','resist_chemical',120),
('def_pbs_prototyper_large','core_max',3000),
('def_pbs_prototyper_large','armor_max',300000),
('def_pbs_prototyper_medium','stealth_strength',50),
('def_pbs_prototyper_medium','signature_radius',65),
('def_pbs_prototyper_medium','resist_thermal',75),
('def_pbs_prototyper_medium','resist_kinetic',75),
('def_pbs_prototyper_medium','resist_explosive',75),
('def_pbs_prototyper_medium','resist_chemical',75),
('def_pbs_prototyper_medium','core_max',2750),
('def_pbs_prototyper_medium','armor_max',250000),
('def_pbs_prototyper_small','stealth_strength',50),
('def_pbs_prototyper_small','signature_radius',50),
('def_pbs_prototyper_small','resist_thermal',30),
('def_pbs_prototyper_small','resist_kinetic',30),
('def_pbs_prototyper_small','resist_explosive',30),
('def_pbs_prototyper_small','resist_chemical',30),
('def_pbs_prototyper_small','core_max',2500),
('def_pbs_prototyper_small','armor_max',200000),
('def_pbs_reactor_large','stealth_strength',50),
('def_pbs_reactor_large','signature_radius',75),
('def_pbs_reactor_large','resist_thermal',120),
('def_pbs_reactor_large','resist_kinetic',120),
('def_pbs_reactor_large','resist_explosive',120),
('def_pbs_reactor_large','resist_chemical',120),
('def_pbs_reactor_large','core_recharge_time',345600),
('def_pbs_reactor_large','core_max',25000000),
('def_pbs_reactor_large','armor_max',150000),
('def_pbs_reactor_medium','stealth_strength',50),
('def_pbs_reactor_medium','signature_radius',65),
('def_pbs_reactor_medium','resist_thermal',75),
('def_pbs_reactor_medium','resist_kinetic',75),
('def_pbs_reactor_medium','resist_explosive',75),
('def_pbs_reactor_medium','resist_chemical',75),
('def_pbs_reactor_medium','core_recharge_time',345600),
('def_pbs_reactor_medium','core_max',20000000),
('def_pbs_reactor_medium','armor_max',125000),
('def_pbs_reactor_small','stealth_strength',50),
('def_pbs_reactor_small','signature_radius',50),
('def_pbs_reactor_small','resist_thermal',30),
('def_pbs_reactor_small','resist_kinetic',30),
('def_pbs_reactor_small','resist_explosive',30),
('def_pbs_reactor_small','resist_chemical',30),
('def_pbs_reactor_small','core_recharge_time',345600),
('def_pbs_reactor_small','core_max',17500000),
('def_pbs_reactor_small','armor_max',100000),
('def_pbs_refinery_large','stealth_strength',50),
('def_pbs_refinery_large','signature_radius',120),
('def_pbs_refinery_large','resist_thermal',120),
('def_pbs_refinery_large','resist_kinetic',120),
('def_pbs_refinery_large','resist_explosive',120),
('def_pbs_refinery_large','resist_chemical',120),
('def_pbs_refinery_large','core_max',3000),
('def_pbs_refinery_large','armor_max',300000),
('def_pbs_refinery_medium','stealth_strength',50),
('def_pbs_refinery_medium','signature_radius',65),
('def_pbs_refinery_medium','resist_thermal',75),
('def_pbs_refinery_medium','resist_kinetic',75),
('def_pbs_refinery_medium','resist_explosive',75),
('def_pbs_refinery_medium','resist_chemical',75),
('def_pbs_refinery_medium','core_max',2750),
('def_pbs_refinery_medium','armor_max',250000),
('def_pbs_refinery_small','stealth_strength',50),
('def_pbs_refinery_small','signature_radius',50),
('def_pbs_refinery_small','resist_thermal',30),
('def_pbs_refinery_small','resist_kinetic',30),
('def_pbs_refinery_small','resist_explosive',30),
('def_pbs_refinery_small','resist_chemical',30),
('def_pbs_refinery_small','core_max',2500),
('def_pbs_refinery_small','armor_max',200000),
('def_pbs_repair_large','stealth_strength',50),
('def_pbs_repair_large','signature_radius',120),
('def_pbs_repair_large','resist_thermal',120),
('def_pbs_repair_large','resist_kinetic',120),
('def_pbs_repair_large','resist_explosive',120),
('def_pbs_repair_large','resist_chemical',120),
('def_pbs_repair_large','core_max',3000),
('def_pbs_repair_large','armor_max',300000),
('def_pbs_repair_medium','stealth_strength',50),
('def_pbs_repair_medium','signature_radius',65),
('def_pbs_repair_medium','resist_thermal',75),
('def_pbs_repair_medium','resist_kinetic',75),
('def_pbs_repair_medium','resist_explosive',75),
('def_pbs_repair_medium','resist_chemical',75),
('def_pbs_repair_medium','core_max',2750),
('def_pbs_repair_medium','armor_max',250000),
('def_pbs_repair_small','stealth_strength',50),
('def_pbs_repair_small','signature_radius',50),
('def_pbs_repair_small','resist_thermal',30),
('def_pbs_repair_small','resist_kinetic',30),
('def_pbs_repair_small','resist_explosive',30),
('def_pbs_repair_small','resist_chemical',30),
('def_pbs_repair_small','core_max',2500),
('def_pbs_repair_small','armor_max',200000),
('def_pbs_reprocessor_large','stealth_strength',50),
('def_pbs_reprocessor_large','signature_radius',120),
('def_pbs_reprocessor_large','resist_thermal',120),
('def_pbs_reprocessor_large','resist_kinetic',120),
('def_pbs_reprocessor_large','resist_explosive',120),
('def_pbs_reprocessor_large','resist_chemical',120),
('def_pbs_reprocessor_large','core_max',3000),
('def_pbs_reprocessor_large','armor_max',300000),
('def_pbs_reprocessor_medium','stealth_strength',50),
('def_pbs_reprocessor_medium','signature_radius',65),
('def_pbs_reprocessor_medium','resist_thermal',75),
('def_pbs_reprocessor_medium','resist_kinetic',75),
('def_pbs_reprocessor_medium','resist_explosive',75),
('def_pbs_reprocessor_medium','resist_chemical',75),
('def_pbs_reprocessor_medium','core_max',2750),
('def_pbs_reprocessor_medium','armor_max',250000),
('def_pbs_reprocessor_small','stealth_strength',50),
('def_pbs_reprocessor_small','signature_radius',50),
('def_pbs_reprocessor_small','resist_thermal',30),
('def_pbs_reprocessor_small','resist_kinetic',30),
('def_pbs_reprocessor_small','resist_explosive',30),
('def_pbs_reprocessor_small','resist_chemical',30),
('def_pbs_reprocessor_small','core_max',2500),
('def_pbs_reprocessor_small','armor_max',200000),
('def_pbs_research_kit_forge_large','stealth_strength',50),
('def_pbs_research_kit_forge_large','signature_radius',120),
('def_pbs_research_kit_forge_large','resist_thermal',120),
('def_pbs_research_kit_forge_large','resist_kinetic',120),
('def_pbs_research_kit_forge_large','resist_explosive',120),
('def_pbs_research_kit_forge_large','resist_chemical',120),
('def_pbs_research_kit_forge_large','core_max',3000),
('def_pbs_research_kit_forge_large','armor_max',300000),
('def_pbs_research_kit_forge_medium','stealth_strength',50),
('def_pbs_research_kit_forge_medium','signature_radius',65),
('def_pbs_research_kit_forge_medium','resist_thermal',75),
('def_pbs_research_kit_forge_medium','resist_kinetic',75),
('def_pbs_research_kit_forge_medium','resist_explosive',75),
('def_pbs_research_kit_forge_medium','resist_chemical',75),
('def_pbs_research_kit_forge_medium','core_max',2750),
('def_pbs_research_kit_forge_medium','armor_max',250000),
('def_pbs_research_kit_forge_small','stealth_strength',50),
('def_pbs_research_kit_forge_small','signature_radius',50),
('def_pbs_research_kit_forge_small','resist_thermal',30),
('def_pbs_research_kit_forge_small','resist_kinetic',30),
('def_pbs_research_kit_forge_small','resist_explosive',30),
('def_pbs_research_kit_forge_small','resist_chemical',30),
('def_pbs_research_kit_forge_small','core_max',2500),
('def_pbs_research_kit_forge_small','armor_max',200000),
('def_pbs_research_lab_large','stealth_strength',50),
('def_pbs_research_lab_large','signature_radius',120),
('def_pbs_research_lab_large','resist_thermal',120),
('def_pbs_research_lab_large','resist_kinetic',120),
('def_pbs_research_lab_large','resist_explosive',120),
('def_pbs_research_lab_large','resist_chemical',120),
('def_pbs_research_lab_large','core_max',3000),
('def_pbs_research_lab_large','armor_max',300000),
('def_pbs_research_lab_medium','stealth_strength',50),
('def_pbs_research_lab_medium','signature_radius',65),
('def_pbs_research_lab_medium','resist_thermal',75),
('def_pbs_research_lab_medium','resist_kinetic',75),
('def_pbs_research_lab_medium','resist_explosive',75),
('def_pbs_research_lab_medium','resist_chemical',75),
('def_pbs_research_lab_medium','core_max',2750),
('def_pbs_research_lab_medium','armor_max',250000),
('def_pbs_research_lab_small','stealth_strength',50),
('def_pbs_research_lab_small','signature_radius',50),
('def_pbs_research_lab_small','resist_thermal',30),
('def_pbs_research_lab_small','resist_kinetic',30),
('def_pbs_research_lab_small','resist_explosive',30),
('def_pbs_research_lab_small','resist_chemical',30),
('def_pbs_research_lab_small','core_max',2500),
('def_pbs_research_lab_small','armor_max',200000),
('def_pbs_XL_core_transmitter_large','stealth_strength',50),
('def_pbs_XL_core_transmitter_large','signature_radius',30),
('def_pbs_XL_core_transmitter_large','resist_thermal',120),
('def_pbs_XL_core_transmitter_large','resist_kinetic',120),
('def_pbs_XL_core_transmitter_large','resist_explosive',120),
('def_pbs_XL_core_transmitter_large','resist_chemical',120),
('def_pbs_XL_core_transmitter_large','core_max',120000),
('def_pbs_XL_core_transmitter_large','armor_max',45000),
('def_pbs_XL_core_transmitter_medium','stealth_strength',50),
('def_pbs_XL_core_transmitter_medium','signature_radius',25),
('def_pbs_XL_core_transmitter_medium','resist_thermal',75),
('def_pbs_XL_core_transmitter_medium','resist_kinetic',75),
('def_pbs_XL_core_transmitter_medium','resist_explosive',75),
('def_pbs_XL_core_transmitter_medium','resist_chemical',75),
('def_pbs_XL_core_transmitter_medium','core_max',105000),
('def_pbs_XL_core_transmitter_medium','armor_max',37500),
('def_pbs_XL_core_transmitter_small','stealth_strength',50),
('def_pbs_XL_core_transmitter_small','signature_radius',20),
('def_pbs_XL_core_transmitter_small','resist_thermal',30),
('def_pbs_XL_core_transmitter_small','resist_kinetic',30),
('def_pbs_XL_core_transmitter_small','resist_explosive',30),
('def_pbs_XL_core_transmitter_small','resist_chemical',30),
('def_pbs_XL_core_transmitter_small','core_max',90000),
('def_pbs_XL_core_transmitter_small','armor_max',30000);


PRINT N'Merge all PBS stats';
MERGE [dbo].[aggregatevalues] v USING #BASE_STATS s
ON v.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE s.defName=definitionname) AND
v.field = (SELECT TOP 1 id FROM aggregatefields WHERE name=s.fieldName)
WHEN MATCHED
    THEN UPDATE SET
		v.value=s.modValue
WHEN NOT MATCHED
    THEN INSERT (definition, field, value) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE s.defName=definitionname),
	(SELECT TOP 1 id FROM aggregatefields WHERE name=s.fieldName),
	s.modValue);


PRINT N'Merge all PBS stats for capsule defs';
MERGE [dbo].[aggregatevalues] v USING #BASE_STATS s
ON v.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE s.defName+'_capsule'=definitionname) AND
v.field = (SELECT TOP 1 id FROM aggregatefields WHERE name=s.fieldName)
WHEN MATCHED
    THEN UPDATE SET
		v.value=s.modValue
WHEN NOT MATCHED
    THEN INSERT (definition, field, value) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE s.defName=definitionname),
	(SELECT TOP 1 id FROM aggregatefields WHERE name=s.fieldName),
	s.modValue);

DROP TABLE IF EXISTS #BASE_STATS;
PRINT N'All PBS stats updated';
GO