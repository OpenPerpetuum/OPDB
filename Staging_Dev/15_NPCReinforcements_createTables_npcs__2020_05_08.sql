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


DROP TABLE IF EXISTS #WAVES;
CREATE TABLE #WAVES (
	presenceName VARCHAR(100),
	npcDefName VARCHAR(100),
	numInFlock INT,
);

INSERT INTO #WAVES (presenceName, npcDefName, numInFlock) VALUES
--Faction neutral wave
('flux_ore_npc_wave_0', 'def_npc_fivepercent_argano', 2),
('flux_ore_npc_wave_0', 'def_npc_fivepercent_Laird', 2),
--Pelistal waves
('flux_ore_npc_wave_1_pelistal', 'def_npc_fivepercent_argano', 1),
('flux_ore_npc_wave_1_pelistal', 'def_npc_fivepercent_Laird', 1),
('flux_ore_npc_wave_1_pelistal', 'def_npc_tenpercent_castel_rank1', 2),

('flux_ore_npc_wave_2_pelistal', 'def_npc_fivepercent_Laird', 1),
('flux_ore_npc_wave_2_pelistal', 'def_npc_tenpercent_castel_rank1', 2),
('flux_ore_npc_wave_2_pelistal', 'def_npc_tenpercent_castel_rank2', 1),

('flux_ore_npc_wave_3_pelistal', 'def_npc_fivepercent_argano', 1),
('flux_ore_npc_wave_3_pelistal', 'def_npc_tenpercent_castel_rank1', 2),
('flux_ore_npc_wave_3_pelistal', 'def_npc_tenpercent_castel_rank2', 2),
('flux_ore_npc_wave_3_pelistal', 'def_npc_percent_wasp_rank2', 1),

('flux_ore_npc_wave_4_pelistal', 'def_npc_fivepercent_Laird', 1),
('flux_ore_npc_wave_4_pelistal', 'def_npc_tenpercent_castel_rank1', 2),
('flux_ore_npc_wave_4_pelistal', 'def_npc_tenpercent_castel_rank2', 2),
('flux_ore_npc_wave_4_pelistal', 'def_npc_percent_wasp_rank2', 2),
('flux_ore_npc_wave_4_pelistal', 'def_npc_percent_wasp_rank3', 1),

('flux_ore_npc_wave_5_pelistal', 'def_npc_tenpercent_castel_rank2', 1),
('flux_ore_npc_wave_5_pelistal', 'def_npc_percent_wasp_rank2', 1),
('flux_ore_npc_wave_5_pelistal', 'def_npc_percent_wasp_rank3', 2),
('flux_ore_npc_wave_5_pelistal', 'def_npc_percent_tyro_rank3', 1),

('flux_ore_npc_wave_6_pelistal', 'def_npc_tenpercent_castel_rank2', 1),
('flux_ore_npc_wave_6_pelistal', 'def_npc_percent_wasp_rank3', 2),
('flux_ore_npc_wave_6_pelistal', 'def_npc_percent_tyro_rank3', 2),
('flux_ore_npc_wave_6_pelistal', 'def_npc_percent_tyro_rank4', 1),

('flux_ore_npc_wave_7_pelistal', 'def_npc_tenpercent_castel_rank2', 1),
('flux_ore_npc_wave_7_pelistal', 'def_npc_percent_wasp_rank3', 2),
('flux_ore_npc_wave_7_pelistal', 'def_npc_percent_tyro_rank4', 2),
('flux_ore_npc_wave_7_pelistal', 'def_npc_percent_tyro_rank5', 1),

('flux_ore_npc_wave_8_pelistal', 'def_npc_tenpercent_castel_rank2', 1),
('flux_ore_npc_wave_8_pelistal', 'def_npc_percent_wasp_rank3', 1),
('flux_ore_npc_wave_8_pelistal', 'def_npc_percent_tyro_rank5', 2),
('flux_ore_npc_wave_8_pelistal', 'def_npc_percent_gropho_rank4', 1),

('flux_ore_npc_wave_9_pelistal', 'def_npc_tenpercent_castel_rank2', 3),
('flux_ore_npc_wave_9_pelistal', 'def_npc_percent_wasp_rank3', 3),
('flux_ore_npc_wave_9_pelistal', 'def_npc_percent_tyro_rank5', 3),
('flux_ore_npc_wave_9_pelistal', 'def_npc_percent_gropho_rank4', 2),
('flux_ore_npc_wave_9_pelistal', 'def_npc_percent_gropho_rank5', 1),
--Thelodica waves
('flux_ore_npc_wave_1_thelodica', 'def_npc_fivepercent_argano', 1),
('flux_ore_npc_wave_1_thelodica', 'def_npc_fivepercent_Laird', 1),
('flux_ore_npc_wave_1_thelodica', 'def_npc_tenpercent_prom_rank1', 2),

('flux_ore_npc_wave_2_thelodica', 'def_npc_fivepercent_Laird', 1),
('flux_ore_npc_wave_2_thelodica', 'def_npc_tenpercent_prom_rank1', 2),
('flux_ore_npc_wave_2_thelodica', 'def_npc_tenpercent_prom_rank2', 1),

('flux_ore_npc_wave_3_thelodica', 'def_npc_fivepercent_argano', 1),
('flux_ore_npc_wave_3_thelodica', 'def_npc_tenpercent_prom_rank1', 2),
('flux_ore_npc_wave_3_thelodica', 'def_npc_tenpercent_prom_rank2', 2),
('flux_ore_npc_wave_3_thelodica', 'def_npc_percent_baph_rank2', 1),

('flux_ore_npc_wave_4_thelodica', 'def_npc_fivepercent_Laird', 1),
('flux_ore_npc_wave_4_thelodica', 'def_npc_tenpercent_prom_rank1', 2),
('flux_ore_npc_wave_4_thelodica', 'def_npc_tenpercent_prom_rank2', 2),
('flux_ore_npc_wave_4_thelodica', 'def_npc_percent_baph_rank2', 2),
('flux_ore_npc_wave_4_thelodica', 'def_npc_percent_baph_rank3', 1),

('flux_ore_npc_wave_5_thelodica', 'def_npc_tenpercent_prom_rank2', 1),
('flux_ore_npc_wave_5_thelodica', 'def_npc_percent_baph_rank2', 1),
('flux_ore_npc_wave_5_thelodica', 'def_npc_percent_baph_rank3', 2),
('flux_ore_npc_wave_5_thelodica', 'def_npc_percent_arty_rank3', 1),

('flux_ore_npc_wave_6_thelodica', 'def_npc_tenpercent_prom_rank2', 1),
('flux_ore_npc_wave_6_thelodica', 'def_npc_percent_baph_rank3', 2),
('flux_ore_npc_wave_6_thelodica', 'def_npc_percent_arty_rank3', 2),
('flux_ore_npc_wave_6_thelodica', 'def_npc_percent_arty_rank4', 1),

('flux_ore_npc_wave_7_thelodica', 'def_npc_tenpercent_prom_rank2', 1),
('flux_ore_npc_wave_7_thelodica', 'def_npc_percent_baph_rank3', 2),
('flux_ore_npc_wave_7_thelodica', 'def_npc_percent_arty_rank4', 2),
('flux_ore_npc_wave_7_thelodica', 'def_npc_percent_arty_rank5', 1),

('flux_ore_npc_wave_8_thelodica', 'def_npc_tenpercent_prom_rank2', 1),
('flux_ore_npc_wave_8_thelodica', 'def_npc_percent_baph_rank3', 1),
('flux_ore_npc_wave_8_thelodica', 'def_npc_percent_arty_rank5', 2),
('flux_ore_npc_wave_8_thelodica', 'def_npc_percent_seth_rank4', 1),

('flux_ore_npc_wave_9_thelodica', 'def_npc_tenpercent_prom_rank2', 3),
('flux_ore_npc_wave_9_thelodica', 'def_npc_percent_baph_rank3', 3),
('flux_ore_npc_wave_9_thelodica', 'def_npc_percent_arty_rank5', 3),
('flux_ore_npc_wave_9_thelodica', 'def_npc_percent_seth_rank4', 2),
('flux_ore_npc_wave_9_thelodica', 'def_npc_percent_seth_rank5', 1),
--Nuimqol waves
('flux_ore_npc_wave_1_nuimqol', 'def_npc_fivepercent_argano', 1),
('flux_ore_npc_wave_1_nuimqol', 'def_npc_fivepercent_Laird', 1),
('flux_ore_npc_wave_1_nuimqol', 'def_npc_tenpercent_yagel_rank1', 2),

('flux_ore_npc_wave_2_nuimqol', 'def_npc_fivepercent_Laird', 1),
('flux_ore_npc_wave_2_nuimqol', 'def_npc_tenpercent_yagel_rank1', 2),
('flux_ore_npc_wave_2_nuimqol', 'def_npc_tenpercent_yagel_rank2', 1),

('flux_ore_npc_wave_3_nuimqol', 'def_npc_fivepercent_argano', 1),
('flux_ore_npc_wave_3_nuimqol', 'def_npc_tenpercent_yagel_rank1', 2),
('flux_ore_npc_wave_3_nuimqol', 'def_npc_tenpercent_yagel_rank2', 2),
('flux_ore_npc_wave_3_nuimqol', 'def_npc_percent_arby_rank2', 1),

('flux_ore_npc_wave_4_nuimqol', 'def_npc_fivepercent_Laird', 1),
('flux_ore_npc_wave_4_nuimqol', 'def_npc_tenpercent_yagel_rank1', 2),
('flux_ore_npc_wave_4_nuimqol', 'def_npc_tenpercent_yagel_rank2', 2),
('flux_ore_npc_wave_4_nuimqol', 'def_npc_percent_arby_rank2', 2),
('flux_ore_npc_wave_4_nuimqol', 'def_npc_percent_arby_rank3', 1),

('flux_ore_npc_wave_5_nuimqol', 'def_npc_tenpercent_yagel_rank2', 1),
('flux_ore_npc_wave_5_nuimqol', 'def_npc_percent_arby_rank2', 1),
('flux_ore_npc_wave_5_nuimqol', 'def_npc_percent_arby_rank3', 2),
('flux_ore_npc_wave_5_nuimqol', 'def_npc_percent_kain_rank3', 1),

('flux_ore_npc_wave_6_nuimqol', 'def_npc_tenpercent_yagel_rank2', 1),
('flux_ore_npc_wave_6_nuimqol', 'def_npc_percent_arby_rank3', 2),
('flux_ore_npc_wave_6_nuimqol', 'def_npc_percent_kain_rank3', 2),
('flux_ore_npc_wave_6_nuimqol', 'def_npc_percent_kain_rank4', 1),

('flux_ore_npc_wave_7_nuimqol', 'def_npc_tenpercent_yagel_rank2', 1),
('flux_ore_npc_wave_7_nuimqol', 'def_npc_percent_kain_rank3', 2),
('flux_ore_npc_wave_7_nuimqol', 'def_npc_percent_kain_rank4', 2),
('flux_ore_npc_wave_7_nuimqol', 'def_npc_percent_kain_rank5', 1),

('flux_ore_npc_wave_8_nuimqol', 'def_npc_tenpercent_yagel_rank2', 1),
('flux_ore_npc_wave_8_nuimqol', 'def_npc_percent_arby_rank3', 1),
('flux_ore_npc_wave_8_nuimqol', 'def_npc_percent_kain_rank5', 2),
('flux_ore_npc_wave_8_nuimqol', 'def_npc_percent_mesmer_rank4', 1),

('flux_ore_npc_wave_9_nuimqol', 'def_npc_tenpercent_yagel_rank2', 3),
('flux_ore_npc_wave_9_nuimqol', 'def_npc_percent_arby_rank3', 3),
('flux_ore_npc_wave_9_nuimqol', 'def_npc_percent_kain_rank5', 3),
('flux_ore_npc_wave_9_nuimqol', 'def_npc_percent_mesmer_rank4', 2),
('flux_ore_npc_wave_9_nuimqol', 'def_npc_percent_mesmer_rank5', 1);


--This is what we should use
DELETE FROM npcflock WHERE presenceid in (SELECT id FROM npcpresence WHERE name in (SELECT DISTINCT presenceName FROM #WAVES));
DELETE FROM npcpresence WHERE name in (SELECT DISTINCT presenceName FROM #WAVES);

INSERT INTO npcpresence 
	(name,topx,topy,bottomx,bottomy,note,spawnid,enabled,roaming,roamingrespawnseconds,presencetype,maxrandomflock,randomcenterx,randomcentery,randomradius,dynamiclifetime,isbodypull,isrespawnallowed,safebodypull,izgroupid)
SELECT DISTINCT 
	presenceName, 0, 0, 0, 0, presenceName, 10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL
FROM #WAVES;

INSERT INTO npcflock
	(name,presenceid,flockmembercount,definition,spawnoriginX,spawnoriginY,spawnrangeMin,spawnrangeMax,respawnseconds,totalspawncount,homerange,note,respawnmultiplierlow,enabled,iscallforhelp,behaviorType,npcSpecialType)
SELECT 
	presenceName+npcDefName, (SELECT id FROM npcpresence WHERE name=presenceName), numInFlock, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=npcDefName), 0, 0, 0, 10, 0, 1, 35, presenceName+npcDefName, 0.5, 1, 1, 2, 0
FROM #WAVES;


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
