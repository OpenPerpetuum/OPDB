USE [perpetuumsa]
GO

--UPDATE misplaced flock from script: NPC_beta2_easy_spawns
PRINT N'UPDATE misplaced flock from script: NPC_beta2_easy_spawns';
PRINT N'Spawn origin fix for: KentLao_LowLevel4_HM';

UPDATE npcflock
SET spawnoriginX = 951, spawnoriginY=283
WHERE name='KentLao_LowLevel4_HM';

GO