-- Perpetuum.AdminTool generated script
-- Generated: 2026-05-06 07:18:00 UTC
-- Author: devours@internet.ru

SET XACT_ABORT ON;
BEGIN TRANSACTION;

-- [1] npcflock: update id 8534 ('syndicate_N01_z2_echelon_main_combat', 1 column(s))
UPDATE npcflock SET behaviorType = 1 WHERE id = 8534
;

-- [2] npcflock: update id 8535 ('syndicate_N02_z2_echelon_main_combat', 1 column(s))
UPDATE npcflock SET behaviorType = 1 WHERE id = 8535
;

-- [3] npcflock: update id 8536 ('syndicate_N03_z2_echelon_main_combat', 1 column(s))
UPDATE npcflock SET behaviorType = 1 WHERE id = 8536
;

COMMIT TRANSACTION;
