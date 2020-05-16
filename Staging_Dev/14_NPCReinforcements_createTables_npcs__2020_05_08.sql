USE [perpetuumsa]
GO

--------------------------------------------------------------------
--Datamodel for NPC Reinforcements: A model for npc spawns that occur on particular set of conditional criteria
--Each record is a presence and a threshold that join to potentially any other table by some targetId.
--The reinforcementType determines the polymorphic behaviour of the record as it is loaded into the server.
--The threshold allows for floating point numeric criteria to gate behaviours and determine percentages or other values to trigger a particular spawn.
--ZoneId if provided can filter presences to spawn if the target event occurs on a particular zone.
--If zone is null, it will appear anywhere the event occurs at the threshold.
--
--Requires Flux ore to be defined first!
--
--Date modified: 2020/05/16
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
	presenceId INT NOT NULL,
	zoneId INT
);

GO
--TODO make new npcs for waves!
--
--Just stuff to test
PRINT N'JUST TEST PRESENCES/flocks -- TODO MAKE REAL NPCS'

--Flocks have to be deleted before the presence on which they join
DELETE FROM npcflock WHERE name in (
'flux_ore_npc_wave_0',--keep
'flux_ore_npc_wave_1',--TODO only needed for DEV to reset old ones
'flux_ore_npc_wave_2',--TODO only needed for DEV to reset old ones
'flux_ore_npc_wave_3',--TODO only needed for DEV to reset old ones
'flux_ore_npc_wave_4',--TODO only needed for DEV to reset old ones
'flux_ore_npc_wave_5',--TODO only needed for DEV to reset old ones
'flux_ore_npc_wave_6',--TODO only needed for DEV to reset old ones
'flux_ore_npc_wave_7',--TODO only needed for DEV to reset old ones
'flux_ore_npc_wave_8',--TODO only needed for DEV to reset old ones
'flux_ore_npc_wave_9',--TODO only needed for DEV to reset old ones
'flux_ore_npc_wave_1_pelistal',--keep
'flux_ore_npc_wave_2_pelistal',
'flux_ore_npc_wave_3_pelistal',
'flux_ore_npc_wave_4_pelistal',
'flux_ore_npc_wave_5_pelistal',
'flux_ore_npc_wave_6_pelistal',
'flux_ore_npc_wave_7_pelistal',
'flux_ore_npc_wave_8_pelistal',
'flux_ore_npc_wave_9_pelistal',
'flux_ore_npc_wave_1_thelodica',
'flux_ore_npc_wave_2_thelodica',
'flux_ore_npc_wave_3_thelodica',
'flux_ore_npc_wave_4_thelodica',
'flux_ore_npc_wave_5_thelodica',
'flux_ore_npc_wave_6_thelodica',
'flux_ore_npc_wave_7_thelodica',
'flux_ore_npc_wave_8_thelodica',
'flux_ore_npc_wave_9_thelodica',
'flux_ore_npc_wave_1_nuimqol',
'flux_ore_npc_wave_2_nuimqol',
'flux_ore_npc_wave_3_nuimqol',
'flux_ore_npc_wave_4_nuimqol',
'flux_ore_npc_wave_5_nuimqol',
'flux_ore_npc_wave_6_nuimqol',
'flux_ore_npc_wave_7_nuimqol',
'flux_ore_npc_wave_8_nuimqol',
'flux_ore_npc_wave_9_nuimqol');

DELETE FROM npcpresence WHERE name in (
'flux_ore_npc_wave_0', --keep
'flux_ore_npc_wave_1',--TODO only needed for DEV to reset old ones
'flux_ore_npc_wave_2',--TODO only needed for DEV to reset old ones
'flux_ore_npc_wave_3',--TODO only needed for DEV to reset old ones
'flux_ore_npc_wave_4',--TODO only needed for DEV to reset old ones
'flux_ore_npc_wave_5',--TODO only needed for DEV to reset old ones
'flux_ore_npc_wave_6',--TODO only needed for DEV to reset old ones
'flux_ore_npc_wave_7',--TODO only needed for DEV to reset old ones
'flux_ore_npc_wave_8',--TODO only needed for DEV to reset old ones
'flux_ore_npc_wave_9',--TODO only needed for DEV to reset old ones
'flux_ore_npc_wave_1_pelistal', -- keep
'flux_ore_npc_wave_2_pelistal',
'flux_ore_npc_wave_3_pelistal',
'flux_ore_npc_wave_4_pelistal',
'flux_ore_npc_wave_5_pelistal',
'flux_ore_npc_wave_6_pelistal',
'flux_ore_npc_wave_7_pelistal',
'flux_ore_npc_wave_8_pelistal',
'flux_ore_npc_wave_9_pelistal',
'flux_ore_npc_wave_1_thelodica',
'flux_ore_npc_wave_2_thelodica',
'flux_ore_npc_wave_3_thelodica',
'flux_ore_npc_wave_4_thelodica',
'flux_ore_npc_wave_5_thelodica',
'flux_ore_npc_wave_6_thelodica',
'flux_ore_npc_wave_7_thelodica',
'flux_ore_npc_wave_8_thelodica',
'flux_ore_npc_wave_9_thelodica',
'flux_ore_npc_wave_1_nuimqol',
'flux_ore_npc_wave_2_nuimqol',
'flux_ore_npc_wave_3_nuimqol',
'flux_ore_npc_wave_4_nuimqol',
'flux_ore_npc_wave_5_nuimqol',
'flux_ore_npc_wave_6_nuimqol',
'flux_ore_npc_wave_7_nuimqol',
'flux_ore_npc_wave_8_nuimqol',
'flux_ore_npc_wave_9_nuimqol');




INSERT INTO npcpresence
(name,topx,topy,bottomx,bottomy,note,spawnid,enabled,roaming,roamingrespawnseconds,presencetype,maxrandomflock,randomcenterx,randomcentery,randomradius,dynamiclifetime,isbodypull,isrespawnallowed,safebodypull,izgroupid)
VALUES
('flux_ore_npc_wave_0', 0, 0, 0, 0, 'fluxore npc wave 0 presence',10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL),
--
('flux_ore_npc_wave_1_pelistal', 0, 0, 0, 0, 'fluxore npc wave 1 presence pelistal',10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL),
('flux_ore_npc_wave_2_pelistal', 0, 0, 0, 0, 'fluxore npc wave 2 presence pelistal',10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL),
('flux_ore_npc_wave_3_pelistal', 0, 0, 0, 0, 'fluxore npc wave 3 presence pelistal',10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL),
('flux_ore_npc_wave_4_pelistal', 0, 0, 0, 0, 'fluxore npc wave 4 presence pelistal',10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL),
('flux_ore_npc_wave_5_pelistal', 0, 0, 0, 0, 'fluxore npc wave 5 presence pelistal',10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL),
('flux_ore_npc_wave_6_pelistal', 0, 0, 0, 0, 'fluxore npc wave 6 presence pelistal',10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL),
('flux_ore_npc_wave_7_pelistal', 0, 0, 0, 0, 'fluxore npc wave 7 presence pelistal',10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL),
('flux_ore_npc_wave_8_pelistal', 0, 0, 0, 0, 'fluxore npc wave 8 presence pelistal',10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL),
('flux_ore_npc_wave_9_pelistal', 0, 0, 0, 0, 'fluxore npc wave 9 presence pelistal',10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL),
--
('flux_ore_npc_wave_1_thelodica', 0, 0, 0, 0, 'fluxore npc wave 1 presence thelodica',10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL),
('flux_ore_npc_wave_2_thelodica', 0, 0, 0, 0, 'fluxore npc wave 2 presence thelodica',10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL),
('flux_ore_npc_wave_3_thelodica', 0, 0, 0, 0, 'fluxore npc wave 3 presence thelodica',10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL),
('flux_ore_npc_wave_4_thelodica', 0, 0, 0, 0, 'fluxore npc wave 4 presence thelodica',10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL),
('flux_ore_npc_wave_5_thelodica', 0, 0, 0, 0, 'fluxore npc wave 5 presence thelodica',10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL),
('flux_ore_npc_wave_6_thelodica', 0, 0, 0, 0, 'fluxore npc wave 6 presence thelodica',10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL),
('flux_ore_npc_wave_7_thelodica', 0, 0, 0, 0, 'fluxore npc wave 7 presence thelodica',10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL),
('flux_ore_npc_wave_8_thelodica', 0, 0, 0, 0, 'fluxore npc wave 8 presence thelodica',10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL),
('flux_ore_npc_wave_9_thelodica', 0, 0, 0, 0, 'fluxore npc wave 9 presence thelodica',10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL),
--
('flux_ore_npc_wave_1_nuimqol', 0, 0, 0, 0, 'fluxore npc wave 1 presence nuimqol',10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL),
('flux_ore_npc_wave_2_nuimqol', 0, 0, 0, 0, 'fluxore npc wave 2 presence nuimqol',10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL),
('flux_ore_npc_wave_3_nuimqol', 0, 0, 0, 0, 'fluxore npc wave 3 presence nuimqol',10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL),
('flux_ore_npc_wave_4_nuimqol', 0, 0, 0, 0, 'fluxore npc wave 4 presence nuimqol',10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL),
('flux_ore_npc_wave_5_nuimqol', 0, 0, 0, 0, 'fluxore npc wave 5 presence nuimqol',10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL),
('flux_ore_npc_wave_6_nuimqol', 0, 0, 0, 0, 'fluxore npc wave 6 presence nuimqol',10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL),
('flux_ore_npc_wave_7_nuimqol', 0, 0, 0, 0, 'fluxore npc wave 7 presence nuimqol',10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL),
('flux_ore_npc_wave_8_nuimqol', 0, 0, 0, 0, 'fluxore npc wave 8 presence nuimqol',10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL),
('flux_ore_npc_wave_9_nuimqol', 0, 0, 0, 0, 'fluxore npc wave 9 presence nuimqol',10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL);


--TODO make new npcs and more complex flocks for each presence
INSERT INTO npcflock
(name,presenceid,flockmembercount,definition,spawnoriginX,spawnoriginY,spawnrangeMin,spawnrangeMax,respawnseconds,totalspawncount,homerange,note,respawnmultiplierlow,enabled,iscallforhelp,behaviorType,npcSpecialType)
VALUES
('flux_ore_npc_wave_0', (SELECT TOP 1 id FROM npcpresence WHERE name='flux_ore_npc_wave_0'), 1, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_lithus_basic_rank2'), 0, 0, 0, 10, 0, 1, 35, 'fluxore npc wave 0 flock', 0.5, 1, 1, 2, 0),
--
('flux_ore_npc_wave_1_pelistal', (SELECT TOP 1 id FROM npcpresence WHERE name='flux_ore_npc_wave_1_pelistal'), 1, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_castel_rank1_elite'), 0, 0, 0, 10, 0, 1, 35, 'fluxore npc wave 1 flock pelistal', 0.5, 1, 1, 2, 0),
('flux_ore_npc_wave_2_pelistal', (SELECT TOP 1 id FROM npcpresence WHERE name='flux_ore_npc_wave_2_pelistal'), 2, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_castel_rank2_elite'), 0, 0, 0, 10, 0, 1, 35, 'fluxore npc wave 2 flock pelistal', 0.5, 1, 1, 2, 0),
('flux_ore_npc_wave_3_pelistal', (SELECT TOP 1 id FROM npcpresence WHERE name='flux_ore_npc_wave_3_pelistal'), 1, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_waspish_rank1_elite'), 0, 0, 0, 10, 0, 1, 35, 'fluxore npc wave 3 flock pelistal', 0.5, 1, 1, 2, 0),
('flux_ore_npc_wave_4_pelistal', (SELECT TOP 1 id FROM npcpresence WHERE name='flux_ore_npc_wave_4_pelistal'), 2, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_waspish_rank2_elite'), 0, 0, 0, 10, 0, 1, 35, 'fluxore npc wave 4 flock pelistal', 0.5, 1, 1, 2, 0),
('flux_ore_npc_wave_5_pelistal', (SELECT TOP 1 id FROM npcpresence WHERE name='flux_ore_npc_wave_5_pelistal'), 4, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_waspish_rank3_elite'), 0, 0, 0, 10, 0, 1, 35, 'fluxore npc wave 5 flock pelistal', 0.5, 1, 1, 2, 0),
('flux_ore_npc_wave_6_pelistal', (SELECT TOP 1 id FROM npcpresence WHERE name='flux_ore_npc_wave_6_pelistal'), 1, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_tyrannos_rank3_elite'), 0, 0, 0, 10, 0, 1, 35, 'fluxore npc wave 6 flock pelistal', 0.5, 1, 1, 2, 0),
('flux_ore_npc_wave_7_pelistal', (SELECT TOP 1 id FROM npcpresence WHERE name='flux_ore_npc_wave_7_pelistal'), 2, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_tyrannos_rank4_elite'), 0, 0, 0, 10, 0, 1, 35, 'fluxore npc wave 7 flock pelistal', 0.5, 1, 1, 2, 0),
('flux_ore_npc_wave_8_pelistal', (SELECT TOP 1 id FROM npcpresence WHERE name='flux_ore_npc_wave_8_pelistal'), 3, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_tyrannos_rank5_elite'), 0, 0, 0, 10, 0, 1, 35, 'fluxore npc wave 8 flock pelistal', 0.5, 1, 1, 2, 0),
('flux_ore_npc_wave_9_pelistal', (SELECT TOP 1 id FROM npcpresence WHERE name='flux_ore_npc_wave_9_pelistal'), 1, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_gropho_rank5_elite'), 0, 0, 0, 10, 0, 1, 35, 'fluxore npc wave 9 flock pelistal', 0.5, 1, 1, 2, 0),
--
('flux_ore_npc_wave_1_thelodica', (SELECT TOP 1 id FROM npcpresence WHERE name='flux_ore_npc_wave_1_thelodica'), 1, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_prometheus_rank1_elite'), 0, 0, 0, 10, 0, 1, 35, 'fluxore npc wave 1 flock thelodica', 0.5, 1, 1, 2, 0),
('flux_ore_npc_wave_2_thelodica', (SELECT TOP 1 id FROM npcpresence WHERE name='flux_ore_npc_wave_2_thelodica'), 2, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_prometheus_rank2_elite'), 0, 0, 0, 10, 0, 1, 35, 'fluxore npc wave 2 flock thelodica', 0.5, 1, 1, 2, 0),
('flux_ore_npc_wave_3_thelodica', (SELECT TOP 1 id FROM npcpresence WHERE name='flux_ore_npc_wave_3_thelodica'), 1, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_baphomet_rank1_elite'), 0, 0, 0, 10, 0, 1, 35, 'fluxore npc wave 3 flock thelodica', 0.5, 1, 1, 2, 0),
('flux_ore_npc_wave_4_thelodica', (SELECT TOP 1 id FROM npcpresence WHERE name='flux_ore_npc_wave_4_thelodica'), 2, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_baphomet_rank2_elite'), 0, 0, 0, 10, 0, 1, 35, 'fluxore npc wave 4 flock thelodica', 0.5, 1, 1, 2, 0),
('flux_ore_npc_wave_5_thelodica', (SELECT TOP 1 id FROM npcpresence WHERE name='flux_ore_npc_wave_5_thelodica'), 3, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_baphomet_rank3_elite'), 0, 0, 0, 10, 0, 1, 35, 'fluxore npc wave 5 flock thelodica', 0.5, 1, 1, 2, 0),
('flux_ore_npc_wave_6_thelodica', (SELECT TOP 1 id FROM npcpresence WHERE name='flux_ore_npc_wave_6_thelodica'), 1, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_artemis_rank3_elite'), 0, 0, 0, 10, 0, 1, 35, 'fluxore npc wave 6 flock thelodica', 0.5, 1, 1, 2, 0),
('flux_ore_npc_wave_7_thelodica', (SELECT TOP 1 id FROM npcpresence WHERE name='flux_ore_npc_wave_7_thelodica'), 2, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_artemis_rank4_elite'), 0, 0, 0, 10, 0, 1, 35, 'fluxore npc wave 7 flock thelodica', 0.5, 1, 1, 2, 0),
('flux_ore_npc_wave_8_thelodica', (SELECT TOP 1 id FROM npcpresence WHERE name='flux_ore_npc_wave_8_thelodica'), 3, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_artemis_rank5_elite'), 0, 0, 0, 10, 0, 1, 35, 'fluxore npc wave 8 flock thelodica', 0.5, 1, 1, 2, 0),
('flux_ore_npc_wave_9_thelodica', (SELECT TOP 1 id FROM npcpresence WHERE name='flux_ore_npc_wave_9_thelodica'), 1, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_seth_rank4_elite'), 0, 0, 0, 10, 0, 1, 35, 'fluxore npc wave 9 flock thelodica', 0.5, 1, 1, 2, 0),
--
('flux_ore_npc_wave_1_nuimqol', (SELECT TOP 1 id FROM npcpresence WHERE name='flux_ore_npc_wave_1_nuimqol'), 1, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_yagel_rank1_elite'), 0, 0, 0, 10, 0, 1, 35, 'fluxore npc wave 1 flock nuimqol', 0.5, 1, 1, 2, 0),
('flux_ore_npc_wave_2_nuimqol', (SELECT TOP 1 id FROM npcpresence WHERE name='flux_ore_npc_wave_2_nuimqol'), 2, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_yagel_rank2_elite'), 0, 0, 0, 10, 0, 1, 35, 'fluxore npc wave 2 flock nuimqol', 0.5, 1, 1, 2, 0),
('flux_ore_npc_wave_3_nuimqol', (SELECT TOP 1 id FROM npcpresence WHERE name='flux_ore_npc_wave_3_nuimqol'), 1, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_arbalest_rank1_elite'), 0, 0, 0, 10, 0, 1, 35, 'fluxore npc wave 3 flock nuimqol', 0.5, 1, 1, 2, 0),
('flux_ore_npc_wave_4_nuimqol', (SELECT TOP 1 id FROM npcpresence WHERE name='flux_ore_npc_wave_4_nuimqol'), 2, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_arbalest_rank2_elite'), 0, 0, 0, 10, 0, 1, 35, 'fluxore npc wave 4 flock nuimqol', 0.5, 1, 1, 2, 0),
('flux_ore_npc_wave_5_nuimqol', (SELECT TOP 1 id FROM npcpresence WHERE name='flux_ore_npc_wave_5_nuimqol'), 3, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_arbalest_rank3_elite'), 0, 0, 0, 10, 0, 1, 35, 'fluxore npc wave 5 flock nuimqol', 0.5, 1, 1, 2, 0),
('flux_ore_npc_wave_6_nuimqol', (SELECT TOP 1 id FROM npcpresence WHERE name='flux_ore_npc_wave_6_nuimqol'), 1, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_kain_rank3_elite'), 0, 0, 0, 10, 0, 1, 35, 'fluxore npc wave 6 flock nuimqol', 0.5, 1, 1, 2, 0),
('flux_ore_npc_wave_7_nuimqol', (SELECT TOP 1 id FROM npcpresence WHERE name='flux_ore_npc_wave_7_nuimqol'), 2, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_kain_rank4_elite'), 0, 0, 0, 10, 0, 1, 35, 'fluxore npc wave 7 flock nuimqol', 0.5, 1, 1, 2, 0),
('flux_ore_npc_wave_8_nuimqol', (SELECT TOP 1 id FROM npcpresence WHERE name='flux_ore_npc_wave_8_nuimqol'), 3, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_kain_rank5_elite'), 0, 0, 0, 10, 0, 1, 35, 'fluxore npc wave 8 flock nuimqol', 0.5, 1, 1, 2, 0),
('flux_ore_npc_wave_9_nuimqol', (SELECT TOP 1 id FROM npcpresence WHERE name='flux_ore_npc_wave_9_nuimqol'), 1, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_mesmer_rank4_elite'), 0, 0, 0, 10, 0, 1, 35, 'fluxore npc wave 9 flock nuimqol', 0.5, 1, 1, 2, 0);


DECLARE @fluxOre INT;
SET @fluxOre = (SELECT TOP 1 idx FROM minerals WHERE name = 'fluxore');

DECLARE @reinforceType INT;
SET @reinforceType = (SELECT TOP 1 id FROM npcreinforcementtypes WHERE name='minerals');


DECLARE @domhalarn INT;
DECLARE @hokkogaros INT;
DECLARE @norhoop INT;
DECLARE @kentagura INT;
DECLARE @alsbale INT;
DECLARE @novastrov INT;

SET @domhalarn = (SELECT TOP 1 id FROM zones WHERE note='domhalarn' AND name='zone_ICS_A_real');
SET @hokkogaros = (SELECT TOP 1 id FROM zones WHERE note='hokkogaros' AND name='zone_ASI_A_real');
SET @norhoop = (SELECT TOP 1 id FROM zones WHERE note='norhoop' AND name='zone_TM_A_real');
SET @kentagura = (SELECT TOP 1 id FROM zones WHERE note='kentagura' AND name='zone_ASI_pvp');
SET @alsbale = (SELECT TOP 1 id FROM zones WHERE note='alsbale' AND name='zone_TM_pvp');
SET @novastrov = (SELECT TOP 1 id FROM zones WHERE note='novastrov' AND name='zone_ICS_pvp');


INSERT INTO dbo.npcreinforcements (reinforcementType, targetId, threshold, presenceId, zoneId) VALUES
(@reinforceType, @fluxOre, 0.05, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_0'), NULL),

(@reinforceType, @fluxOre, 0.15, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_1_pelistal'), @norhoop),
(@reinforceType, @fluxOre, 0.25, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_2_pelistal'), @norhoop),
(@reinforceType, @fluxOre, 0.35, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_3_pelistal'), @norhoop),
(@reinforceType, @fluxOre, 0.45, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_4_pelistal'), @norhoop),
(@reinforceType, @fluxOre, 0.55, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_5_pelistal'), @norhoop),
(@reinforceType, @fluxOre, 0.65, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_6_pelistal'), @norhoop),
(@reinforceType, @fluxOre, 0.75, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_7_pelistal'), @norhoop),
(@reinforceType, @fluxOre, 0.85, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_8_pelistal'), @norhoop),
(@reinforceType, @fluxOre, 0.95, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_9_pelistal'), @norhoop),

(@reinforceType, @fluxOre, 0.15, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_1_pelistal'), @alsbale),
(@reinforceType, @fluxOre, 0.25, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_2_pelistal'), @alsbale),
(@reinforceType, @fluxOre, 0.35, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_3_pelistal'), @alsbale),
(@reinforceType, @fluxOre, 0.45, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_4_pelistal'), @alsbale),
(@reinforceType, @fluxOre, 0.55, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_5_pelistal'), @alsbale),
(@reinforceType, @fluxOre, 0.65, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_6_pelistal'), @alsbale),
(@reinforceType, @fluxOre, 0.75, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_7_pelistal'), @alsbale),
(@reinforceType, @fluxOre, 0.85, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_8_pelistal'), @alsbale),
(@reinforceType, @fluxOre, 0.95, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_9_pelistal'), @alsbale),

(@reinforceType, @fluxOre, 0.15, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_1_thelodica'), @hokkogaros),
(@reinforceType, @fluxOre, 0.25, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_2_thelodica'), @hokkogaros),
(@reinforceType, @fluxOre, 0.35, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_3_thelodica'), @hokkogaros),
(@reinforceType, @fluxOre, 0.45, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_4_thelodica'), @hokkogaros),
(@reinforceType, @fluxOre, 0.55, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_5_thelodica'), @hokkogaros),
(@reinforceType, @fluxOre, 0.65, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_6_thelodica'), @hokkogaros),
(@reinforceType, @fluxOre, 0.75, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_7_thelodica'), @hokkogaros),
(@reinforceType, @fluxOre, 0.85, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_8_thelodica'), @hokkogaros),
(@reinforceType, @fluxOre, 0.95, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_9_thelodica'), @hokkogaros),

(@reinforceType, @fluxOre, 0.15, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_1_thelodica'), @kentagura),
(@reinforceType, @fluxOre, 0.25, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_2_thelodica'), @kentagura),
(@reinforceType, @fluxOre, 0.35, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_3_thelodica'), @kentagura),
(@reinforceType, @fluxOre, 0.45, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_4_thelodica'), @kentagura),
(@reinforceType, @fluxOre, 0.55, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_5_thelodica'), @kentagura),
(@reinforceType, @fluxOre, 0.65, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_6_thelodica'), @kentagura),
(@reinforceType, @fluxOre, 0.75, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_7_thelodica'), @kentagura),
(@reinforceType, @fluxOre, 0.85, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_8_thelodica'), @kentagura),
(@reinforceType, @fluxOre, 0.95, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_9_thelodica'), @kentagura),

(@reinforceType, @fluxOre, 0.15, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_1_nuimqol'), @domhalarn),
(@reinforceType, @fluxOre, 0.25, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_2_nuimqol'), @domhalarn),
(@reinforceType, @fluxOre, 0.35, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_3_nuimqol'), @domhalarn),
(@reinforceType, @fluxOre, 0.45, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_4_nuimqol'), @domhalarn),
(@reinforceType, @fluxOre, 0.55, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_5_nuimqol'), @domhalarn),
(@reinforceType, @fluxOre, 0.65, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_6_nuimqol'), @domhalarn),
(@reinforceType, @fluxOre, 0.75, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_7_nuimqol'), @domhalarn),
(@reinforceType, @fluxOre, 0.85, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_8_nuimqol'), @domhalarn),
(@reinforceType, @fluxOre, 0.95, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_9_nuimqol'), @domhalarn),

(@reinforceType, @fluxOre, 0.15, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_1_nuimqol'), @novastrov),
(@reinforceType, @fluxOre, 0.25, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_2_nuimqol'), @novastrov),
(@reinforceType, @fluxOre, 0.35, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_3_nuimqol'), @novastrov),
(@reinforceType, @fluxOre, 0.45, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_4_nuimqol'), @novastrov),
(@reinforceType, @fluxOre, 0.55, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_5_nuimqol'), @novastrov),
(@reinforceType, @fluxOre, 0.65, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_6_nuimqol'), @novastrov),
(@reinforceType, @fluxOre, 0.75, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_7_nuimqol'), @novastrov),
(@reinforceType, @fluxOre, 0.85, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_8_nuimqol'), @novastrov),
(@reinforceType, @fluxOre, 0.95, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_9_nuimqol'), @novastrov);

GO
