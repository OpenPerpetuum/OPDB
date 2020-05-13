USE [perpetuumsa]
GO

--------------------------------------------------------------------
--Datamodel for NPC Reinforcements: A model for npc spawns that occur on particular set of conditional criteria
--Each record is a presence and a threshold that join to potentially any other table by some targetId.
--The reinforcementType determines the polymorphic behaviour of the record as it is loaded into the server.
--The threshold allows for floating point numeric criteria to gate behaviours and determine percentages or other values to trigger a particular spawn.
--
--Date modified: 2020/05/13
--------------------------------------------------------------------

DROP TABLE IF EXISTS dbo.npcreinforcementtypes;

CREATE TABLE dbo.npcreinforcementtypes (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	name VARCHAR(64) NOT NULL
);

GO

INSERT INTO dbo.npcreinforcementtypes (name) VALUES
('minerals'),
('boss');


DROP TABLE IF EXISTS dbo.npcreinforcements;

CREATE TABLE dbo.npcreinforcements (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	reinforcementType INT NOT NULL,
	targetId INT NOT NULL,
	threshold float NOT NULL,
	presenceId INT NOT NULL
);

GO
--TODO make new npcs for waves!
--
--Just stuff to test
PRINT N'JUST TEST PRESENCES/flocks -- TODO MAKE REAL NPCS'

DELETE FROM npcpresence WHERE name in (
'flux_ore_npc_wave_0',
'flux_ore_npc_wave_1',
'flux_ore_npc_wave_2',
'flux_ore_npc_wave_3',
'flux_ore_npc_wave_4',
'flux_ore_npc_wave_5',
'flux_ore_npc_wave_6',
'flux_ore_npc_wave_7',
'flux_ore_npc_wave_8',
'flux_ore_npc_wave_9');
INSERT INTO npcpresence
(name,topx,topy,bottomx,bottomy,note,spawnid,enabled,roaming,roamingrespawnseconds,presencetype,maxrandomflock,randomcenterx,randomcentery,randomradius,dynamiclifetime,isbodypull,isrespawnallowed,safebodypull,izgroupid)
VALUES
('flux_ore_npc_wave_0', 0, 0, 0, 0, 'fluxore npc wave 0 presence',10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL),
('flux_ore_npc_wave_1', 0, 0, 0, 0, 'fluxore npc wave 1 presence',10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL),
('flux_ore_npc_wave_2', 0, 0, 0, 0, 'fluxore npc wave 2 presence',10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL),
('flux_ore_npc_wave_3', 0, 0, 0, 0, 'fluxore npc wave 3 presence',10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL),
('flux_ore_npc_wave_4', 0, 0, 0, 0, 'fluxore npc wave 4 presence',10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL),
('flux_ore_npc_wave_5', 0, 0, 0, 0, 'fluxore npc wave 5 presence',10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL),
('flux_ore_npc_wave_6', 0, 0, 0, 0, 'fluxore npc wave 6 presence',10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL),
('flux_ore_npc_wave_7', 0, 0, 0, 0, 'fluxore npc wave 7 presence',10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL),
('flux_ore_npc_wave_8', 0, 0, 0, 0, 'fluxore npc wave 8 presence',10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL),
('flux_ore_npc_wave_9', 0, 0, 0, 0, 'fluxore npc wave 9 presence',10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL);

DELETE FROM npcflock WHERE name in (
'flux_ore_npc_wave_0',
'flux_ore_npc_wave_1',
'flux_ore_npc_wave_2',
'flux_ore_npc_wave_3',
'flux_ore_npc_wave_4',
'flux_ore_npc_wave_5',
'flux_ore_npc_wave_6',
'flux_ore_npc_wave_7',
'flux_ore_npc_wave_8',
'flux_ore_npc_wave_9');
--TODO make new npcs and more complex flocks for each presence
INSERT INTO npcflock
(name,presenceid,flockmembercount,definition,spawnoriginX,spawnoriginY,spawnrangeMin,spawnrangeMax,respawnseconds,totalspawncount,homerange,note,respawnmultiplierlow,enabled,iscallforhelp,behaviorType,npcSpecialType)
VALUES
('flux_ore_npc_wave_0', (SELECT TOP 1 id FROM npcpresence WHERE name='flux_ore_npc_wave_0'), 1, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_lithus_basic_rank2'), 0, 0, 0, 10, 0, 1, 35, 'fluxore npc wave 0 flock', 0.5, 1, 1, 2, 0),
('flux_ore_npc_wave_1', (SELECT TOP 1 id FROM npcpresence WHERE name='flux_ore_npc_wave_1'), 2, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_castel_rank1_elite'), 0, 0, 0, 10, 0, 1, 35, 'fluxore npc wave 1 flock', 0.5, 1, 1, 2, 0),
('flux_ore_npc_wave_2', (SELECT TOP 1 id FROM npcpresence WHERE name='flux_ore_npc_wave_2'), 1, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_waspish_rank1_elite'), 0, 0, 0, 10, 0, 1, 35, 'fluxore npc wave 2 flock', 0.5, 1, 1, 2, 0),
('flux_ore_npc_wave_3', (SELECT TOP 1 id FROM npcpresence WHERE name='flux_ore_npc_wave_3'), 2, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_arbalest_rank2_elite'), 0, 0, 0, 10, 0, 1, 35, 'fluxore npc wave 3 flock', 0.5, 1, 1, 2, 0),
('flux_ore_npc_wave_4', (SELECT TOP 1 id FROM npcpresence WHERE name='flux_ore_npc_wave_4'), 3, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_baphomet_rank3_elite'), 0, 0, 0, 10, 0, 1, 35, 'fluxore npc wave 4 flock', 0.5, 1, 1, 2, 0),
('flux_ore_npc_wave_5', (SELECT TOP 1 id FROM npcpresence WHERE name='flux_ore_npc_wave_5'), 1, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_artemis_rank3_elite'), 0, 0, 0, 10, 0, 1, 35, 'fluxore npc wave 5 flock', 0.5, 1, 1, 2, 0),
('flux_ore_npc_wave_6', (SELECT TOP 1 id FROM npcpresence WHERE name='flux_ore_npc_wave_6'), 2, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_kain_rank3_elite'), 0, 0, 0, 10, 0, 1, 35, 'fluxore npc wave 6 flock', 0.5, 1, 1, 2, 0),
('flux_ore_npc_wave_7', (SELECT TOP 1 id FROM npcpresence WHERE name='flux_ore_npc_wave_7'), 1, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_mesmer_rank5_elite'), 0, 0, 0, 10, 0, 1, 35, 'fluxore npc wave 7 flock', 0.5, 1, 1, 2, 0),
('flux_ore_npc_wave_8', (SELECT TOP 1 id FROM npcpresence WHERE name='flux_ore_npc_wave_8'), 2, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_gropho_rank4_elite'), 0, 0, 0, 10, 0, 1, 35, 'fluxore npc wave 8 flock', 0.5, 1, 1, 2, 0),
('flux_ore_npc_wave_9', (SELECT TOP 1 id FROM npcpresence WHERE name='flux_ore_npc_wave_9'), 1, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_gropho_miniboss_2ndyear'), 0, 0, 0, 10, 0, 1, 35, 'fluxore npc wave 9 flock', 0.5, 1, 1, 2, 0);


DECLARE @fluxOre INT;
SET @fluxOre = (SELECT TOP 1 idx FROM minerals WHERE name = 'fluxore');

DECLARE @reinforceType INT;
SET @reinforceType = (SELECT TOP 1 id FROM npcreinforcementtypes WHERE name='minerals');

INSERT INTO dbo.npcreinforcements (reinforcementType, targetId, threshold, presenceId) VALUES
(@reinforceType, @fluxOre, 0.05, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_0')),
(@reinforceType, @fluxOre, 0.1, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_1')),
(@reinforceType, @fluxOre, 0.2, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_2')),
(@reinforceType, @fluxOre, 0.3, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_3')),
(@reinforceType, @fluxOre, 0.4, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_4')),
(@reinforceType, @fluxOre, 0.5, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_5')),
(@reinforceType, @fluxOre, 0.6, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_6')),
(@reinforceType, @fluxOre, 0.7, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_7')),
(@reinforceType, @fluxOre, 0.8, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_8')),
(@reinforceType, @fluxOre, 0.9, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_9'));

GO