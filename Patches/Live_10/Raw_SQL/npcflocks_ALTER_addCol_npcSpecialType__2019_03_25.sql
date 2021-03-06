USE [perpetuumsa]
GO

----------------------------------------------------------------
--Table: npcflocks, npcSpecialTypes
--ALTER: Add npcSpecialType column
--CREATE: npcSpecialTypes enum table
--Description: Adding an int enum value col to npcflocks to configure
--special logic on the server for these flock types
--
--Date: 2019/03/26
----------------------------------------------------------------

DROP TABLE IF EXISTS dbo.npcSpecialTypes;

PRINT N'Create Enum table for Special Types';
CREATE TABLE dbo.npcSpecialTypes(
id INT NOT NULL IDENTITY PRIMARY KEY,
name VARCHAR(64) NOT NULL,
value INT NOT NULL
);

PRINT N'Insert enum values (NOTE: must match server enum!)';
INSERT INTO dbo.npcSpecialTypes(name, value) 
VALUES
('normal', 0),
('boss', 1);

PRINT N'NPCFLOCKS: ADDING COLUMN npcSpecialType';
ALTER TABLE [perpetuumsa].[dbo].[npcflock]
	ADD npcSpecialType INT NOT NULL
    DEFAULT (0)
	WITH VALUES;

GO

PRINT N'Updating existing flocks to be Boss-types';
PRINT N'By Name...';
--Set flocks with these npc definitions as Boss types
UPDATE npcflock 
SET npcflock.npcSpecialType=(SELECT TOP 1 value FROM dbo.npcSpecialTypes WHERE name='boss')
WHERE respawnseconds>600
AND (
definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_One_Eye_Josef')
OR
definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_tribal_weaver')
OR
definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_clan_griffin')
OR
definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_Sacrist_Mythic')
OR
definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_Sacrist_Convert')
OR
definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_Tribal_Member')
OR
definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_Imperial_Infantry')
OR
definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_Malfunctioning_Arkhe')
OR
definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_RoughRider_Scout')
OR
definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_WilliamHBonnie')
OR
definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_Hersh_PitBoss')
);

PRINT N'By Zone...(stronghold)';
--Set all Stronghold-zoned flocks to Boss-type
UPDATE npcflock
SET npcflock.npcSpecialType=(SELECT TOP 1 value FROM dbo.npcSpecialTypes WHERE name='boss')
WHERE npcflock.id in 
(SELECT id FROM npcflock 
WHERE enabled=1 AND npcflock.presenceid in (SELECT id FROM npcpresence
WHERE enabled=1 AND npcpresence.spawnid in (SELECT id FROM npcspawn
WHERE enabled=1 AND npcspawn.id in (SELECT spawnid FROM zones 
WHERE enabled=1 AND zones.name='zone_pvp_arena' AND zones.id=16))));

GO