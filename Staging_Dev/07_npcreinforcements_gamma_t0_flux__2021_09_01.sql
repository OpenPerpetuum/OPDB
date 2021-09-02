USE [perpetuumsa]
GO

-------------------------------------
-- Npc reinforcements for Flux ore
-- on new gamma zones
-- Date modified: 2021/09/01
-------------------------------------


DECLARE @fluxOre INT;
SET @fluxOre = (SELECT TOP 1 idx FROM minerals WHERE name = 'fluxore');

DECLARE @reinforceType INT;
SET @reinforceType = (SELECT TOP 1 id FROM npcreinforcementtypes WHERE name='minerals');

SELECT * FROM npcreinforcements WHERE reinforcementType=@reinforceType AND targetId=@fluxOre AND
zoneId IN (110, 114, 119, 131);

DELETE FROM npcreinforcements WHERE reinforcementType=@reinforceType AND targetId=@fluxOre AND
zoneId IN (110, 114, 119, 131);

INSERT INTO npcreinforcements (reinforcementType, targetId, threshold, presenceId, zoneId) VALUES
(@reinforceType, @fluxOre, 0.1, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_1_pelistal'), 110),
(@reinforceType, @fluxOre, 0.2, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_2_nuimqol'), 110),
(@reinforceType, @fluxOre, 0.3, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_3_thelodica'), 110),
(@reinforceType, @fluxOre, 0.4, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_4_pelistal'), 110),
(@reinforceType, @fluxOre, 0.5, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_5_nuimqol'), 110),
(@reinforceType, @fluxOre, 0.6, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_6_thelodica'), 110),
(@reinforceType, @fluxOre, 0.7, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_7_pelistal'), 110),
(@reinforceType, @fluxOre, 0.8, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_8_nuimqol'), 110),
(@reinforceType, @fluxOre, 0.9, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_9_thelodica'), 110),

(@reinforceType, @fluxOre, 0.1, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_1_pelistal'), 114),
(@reinforceType, @fluxOre, 0.2, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_2_pelistal'), 114),
(@reinforceType, @fluxOre, 0.3, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_3_pelistal'), 114),
(@reinforceType, @fluxOre, 0.4, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_4_pelistal'), 114),
(@reinforceType, @fluxOre, 0.5, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_5_pelistal'), 114),
(@reinforceType, @fluxOre, 0.6, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_6_pelistal'), 114),
(@reinforceType, @fluxOre, 0.7, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_7_pelistal'), 114),
(@reinforceType, @fluxOre, 0.8, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_8_pelistal'), 114),
(@reinforceType, @fluxOre, 0.9, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_9_pelistal'), 114),

(@reinforceType, @fluxOre, 0.1, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_1_thelodica'), 119),
(@reinforceType, @fluxOre, 0.2, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_2_thelodica'), 119),
(@reinforceType, @fluxOre, 0.3, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_3_thelodica'), 119),
(@reinforceType, @fluxOre, 0.4, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_4_thelodica'), 119),
(@reinforceType, @fluxOre, 0.5, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_5_thelodica'), 119),
(@reinforceType, @fluxOre, 0.6, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_6_thelodica'), 119),
(@reinforceType, @fluxOre, 0.7, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_7_thelodica'), 119),
(@reinforceType, @fluxOre, 0.8, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_8_thelodica'), 119),
(@reinforceType, @fluxOre, 0.9, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_9_thelodica'), 119),

(@reinforceType, @fluxOre, 0.1, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_1_nuimqol'), 131),
(@reinforceType, @fluxOre, 0.2, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_2_nuimqol'), 131),
(@reinforceType, @fluxOre, 0.3, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_3_nuimqol'), 131),
(@reinforceType, @fluxOre, 0.4, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_4_nuimqol'), 131),
(@reinforceType, @fluxOre, 0.5, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_5_nuimqol'), 131),
(@reinforceType, @fluxOre, 0.6, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_6_nuimqol'), 131),
(@reinforceType, @fluxOre, 0.7, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_7_nuimqol'), 131),
(@reinforceType, @fluxOre, 0.8, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_8_nuimqol'), 131),
(@reinforceType, @fluxOre, 0.9, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_9_nuimqol'), 131);



GO
