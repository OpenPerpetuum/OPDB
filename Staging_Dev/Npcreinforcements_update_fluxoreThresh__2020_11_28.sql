USE [perpetuumsa]
GO
------------------------------------
-- Npcreinforcements
-- Threshold adjustments to accomodate corrected algorithm
-- Date modified: 2020/11/28
------------------------------------
PRINT N'UPDATING npcreinforcements thresholds for fluxore spawns';
DECLARE @fluxOre AS INT = (SELECT TOP 1 idx FROM minerals WHERE name = 'fluxore');

DECLARE @reinforceType AS INT = (SELECT TOP 1 id FROM npcreinforcementtypes WHERE name='minerals');

UPDATE npcreinforcements SET 
	threshold=0.01
WHERE 
presenceId IN (SELECT TOP 1 id FROM npcpresence WHERE name in ('flux_ore_npc_wave_0')) AND
targetId=@fluxOre AND reinforcementType=@reinforceType;

UPDATE npcreinforcements SET 
	threshold=0.1
WHERE 
presenceId IN (SELECT id FROM npcpresence WHERE name IN 
('flux_ore_npc_wave_1_pelistal', 'flux_ore_npc_wave_1_thelodica', 'flux_ore_npc_wave_1_nuimqol')) AND
targetId=@fluxOre AND reinforcementType=@reinforceType;

UPDATE npcreinforcements SET 
	threshold=0.2
WHERE 
presenceId IN (SELECT id FROM npcpresence WHERE name IN 
('flux_ore_npc_wave_2_pelistal', 'flux_ore_npc_wave_2_thelodica', 'flux_ore_npc_wave_2_nuimqol')) AND
targetId=@fluxOre AND reinforcementType=@reinforceType;

UPDATE npcreinforcements SET 
	threshold=0.3
WHERE 
presenceId IN (SELECT id FROM npcpresence WHERE name IN 
('flux_ore_npc_wave_3_pelistal', 'flux_ore_npc_wave_3_thelodica', 'flux_ore_npc_wave_3_nuimqol')) AND
targetId=@fluxOre AND reinforcementType=@reinforceType;

UPDATE npcreinforcements SET 
	threshold=0.4
WHERE 
presenceId IN (SELECT id FROM npcpresence WHERE name IN 
('flux_ore_npc_wave_4_pelistal', 'flux_ore_npc_wave_4_thelodica', 'flux_ore_npc_wave_4_nuimqol')) AND
targetId=@fluxOre AND reinforcementType=@reinforceType;

UPDATE npcreinforcements SET 
	threshold=0.5
WHERE 
presenceId IN (SELECT id FROM npcpresence WHERE name IN 
('flux_ore_npc_wave_5_pelistal', 'flux_ore_npc_wave_5_thelodica', 'flux_ore_npc_wave_5_nuimqol')) AND
targetId=@fluxOre AND reinforcementType=@reinforceType;

UPDATE npcreinforcements SET 
	threshold=0.6
WHERE 
presenceId IN (SELECT id FROM npcpresence WHERE name IN 
('flux_ore_npc_wave_6_pelistal', 'flux_ore_npc_wave_6_thelodica', 'flux_ore_npc_wave_6_nuimqol')) AND
targetId=@fluxOre AND reinforcementType=@reinforceType;

UPDATE npcreinforcements SET 
	threshold=0.7
WHERE 
presenceId IN (SELECT id FROM npcpresence WHERE name IN 
('flux_ore_npc_wave_7_pelistal', 'flux_ore_npc_wave_7_thelodica', 'flux_ore_npc_wave_7_nuimqol')) AND
targetId=@fluxOre AND reinforcementType=@reinforceType;

UPDATE npcreinforcements SET 
	threshold=0.8
WHERE 
presenceId IN (SELECT id FROM npcpresence WHERE name IN 
('flux_ore_npc_wave_8_pelistal', 'flux_ore_npc_wave_8_thelodica', 'flux_ore_npc_wave_8_nuimqol')) AND
targetId=@fluxOre AND reinforcementType=@reinforceType;

UPDATE npcreinforcements SET 
	threshold=0.9
WHERE 
presenceId IN (SELECT id FROM npcpresence WHERE name IN 
('flux_ore_npc_wave_9_pelistal', 'flux_ore_npc_wave_9_thelodica', 'flux_ore_npc_wave_9_nuimqol')) AND
targetId=@fluxOre AND reinforcementType=@reinforceType;

PRINT N'DONE UPDATING npcreinforcements thresholds for fluxore spawns';
GO