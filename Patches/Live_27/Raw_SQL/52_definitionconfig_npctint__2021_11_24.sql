USE [perpetuumsa]
GO

------------------------------------
-- Colors for NPC definitions, gamma and all OPP added npcs
-- Contributor: Junelicious
-- Date modified: 2021/11/24
------------------------------------

PRINT N'SET COLORS FOR ALL NPC DEFINTIONS';
DROP TABLE IF EXISTS #COLORS;
CREATE TABLE #COLORS(
    faction varchar(64),
    levelName varchar(64) NULL,
    color varchar(64)
);
INSERT INTO #COLORS (faction, levelName, color) VALUES
('syndicate', NULL, '#1a2315'),
('nuimqol', NULL, '#106CB5'),
('thelodica', NULL, '#FFBC00'),
('pelistal', NULL, '#396C43'),
('industrial', NULL, '#d9d900'),
('goblin', NULL, '#080817'),
('invader', NULL, '#811824'),
('guardian', NULL, '#112d11'),
('roughrider', NULL, '#1a7069'),
('syndicate', 'BossGuard', '#1a7069'),
('Z70', NULL, '#062a3d'),
('syndicate', 'observer', '#1a7069'),
('thelodica', 'observer', '#672200'),
('nuimqol', 'observer', '#011D39'),
('pelistal', 'observer', '#062A0D'),
('syndicate', 'miniboss', '#1a7069'),
('thelodica', 'miniboss', '#672200'),
('nuimqol', 'miniboss', '#011D39'),
('pelistal', 'miniboss', '#062A0D'),
('syndicate', 'pitboss', '#1a7069'),
('thelodica', 'pitboss', '#672200'),
('nuimqol', 'pitboss', '#011D39'),
('pelistal', 'pitboss', '#062A0D'),
('syndicate', 'courier', '#1a7069'),
('thelodica', 'courier', '#672200'),
('nuimqol', 'courier', '#011D39'),
('pelistal', 'courier', '#062A0D'),
('industrial', 'courier', '#b4311f');


DROP TABLE IF EXISTS #BOTS_BY_FACTION;
CREATE TABLE #BOTS_BY_FACTION(
    botName varchar(64),
    className varchar(64),
    faction varchar(64)
);

INSERT INTO #BOTS_BY_FACTION (botName, className, faction) VALUES
('apollo', 'destroyer', 'syndicate'),
('arbalest', 'assault', 'nuimqol'),
('artemis', 'mech', 'thelodica'),
('baphomet', 'assault', 'thelodica'),
('callisto', 'mech', 'syndicate'),
('cameleon', 'light ewar', 'nuimqol'),
('castel', 'light', 'pelistal'),
('cronus', 'assault indy', 'syndicate'),
('daidalos', 'mech indy', 'syndicate'),
('echelon', 'mech', 'syndicate'),
('felos', 'destroyer', 'nuimqol'),
('gargoyle', 'mech indy', 'industrial'),
('gropho', 'heavy mech', 'pelistal'),
('helix', 'light ewar', 'syndicate'),
('hermes', 'assault indy', 'syndicate'),
('hydra', 'destroyer', 'pelistal'),
('ictus', 'mech ewar', 'pelistal'),
('ikarus', 'light indy', 'syndicate'),
('intakt', 'light ewar', 'thelodica'),
('kain', 'mech', 'nuimqol'),
('laird', 'light indy', 'industrial'),
('legatus', 'heavy mech', 'syndicate'),
('lithus', 'heavy mech indy', 'industrial'),
('locust', 'assault', 'syndicate'),
('mesmer', 'heavy mech', 'nuimqol'),
('onyx', 'destroyer', 'thelodica'),
('prometheus', 'light', 'thelodica'),
('riveler', 'heavy mech indy', 'industrial'),
('scarab', 'heavy mech indy', 'industrial'),
('sequer', 'assault indy', 'industrial'),
('seth', 'heavy mech', 'thelodica'),
('symbiont', 'heavy mech indy', 'industrial'),
('termis', 'mech indy', 'industrial'),
('troiar', 'light ewar', 'pelistal'),
('tyrannos', 'mech', 'pelistal'),
('vagabond', 'mech', 'nuimqol'),
('vektor', 'light', 'syndicate'),
('waspish', 'assault', 'pelistal'),
('yagel', 'light', 'nuimqol'),
('zenith', 'mech ewar', 'thelodica'),
--special NPC below, all the ones still missing color
('sacrist', 'special', 'thelodica'),
('clan', 'special', 'nuimqol'),
('imperial', 'special', 'pelistal'),
('tribal_member', 'sadge', 'nuimqol'),
('tribal_weaver', 'sadge', 'pelistal'),
('roughrider', 'special', 'roughrider'),
('rough_rider', 'special', 'roughrider'),
('WilliamHBonnie', 'special', 'roughrider'),
('One_Eye_Josef', 'special', 'roughrider'),
('Malfunctioning_Arkhe', 'special', 'roughrider'),
('arby_rank', 'assault', 'nuimqol'),
('arty_rank', 'mech', 'thelodica'),
('baph_rank', 'assault', 'thelodica'),
('prom_rank', 'light', 'thelodica'),
('wasp_rank', 'assault', 'pelistal'),
('tyro_rank', 'mech', 'pelistal'),
('goblin', 'special', 'goblin'),
('sap_invade', 'special', 'invader'),
('sap_guard', 'special', 'guardian'),
('sh70', 'special', 'Z70');

DECLARE @npcCat AS BIGINT = (SELECT TOP 1 value FROM dbo.categoryFlags WHERE name='cf_npc');
DECLARE @mask AS BIGINT = dbo.GetCFMask(@npcCat);


DROP TABLE IF EXISTS #NPCS_BY_FACTION_BY_LEVEL;
CREATE TABLE #NPCS_BY_FACTION_BY_LEVEL(
    def int,
    npcName varchar(128),
    className varchar(64),
    faction varchar(64),
    levelName varchar(32)
);
INSERT INTO #NPCS_BY_FACTION_BY_LEVEL (def, npcName, className, faction, levelName)
SELECT d.definition, d.definitionname, f.className, f.faction, RIGHT(d.definitionname, CHARINDEX('_',REVERSE(d.definitionname))-1)
FROM entitydefaults d
JOIN #BOTS_BY_FACTION f ON d.definitionname like '%'+f.botName+'%'
WHERE definitionname like 'def_npc%' AND d.definition > 5547 AND 
(categoryflags & @mask = @npcCat); /* filtering out all vanilla NPCs */

PRINT N'TABLE OF NPCS BY FACTION AND LEVEL TO RECEIVE COLOR';
SELECT * FROM #NPCS_BY_FACTION_BY_LEVEL
ORDER BY def;


PRINT N'DELETE/REINSERT definitionconfig FOR BASE FACTION COLORS';
--SELECT * FROM definitionconfig WHERE definition in (select def from #NPCS_BY_FACTION_BY_LEVEL);
DELETE FROM definitionconfig WHERE definition in (select def from #NPCS_BY_FACTION_BY_LEVEL);

INSERT INTO definitionconfig(definition, tint, note)
SELECT def, c.color, 'Color for the NPC!'
FROM #NPCS_BY_FACTION_BY_LEVEL n
JOIN #COLORS c ON c.faction=n.faction AND c.levelName IS NULL;


DROP TABLE IF EXISTS #SPECIAL_COLORS;
CREATE TABLE #SPECIAL_COLORS(
    def int,
    color varchar(64)
);
INSERT INTO #SPECIAL_COLORS (def, color)
SELECT def, c.color
    FROM #NPCS_BY_FACTION_BY_LEVEL n
    JOIN #COLORS c ON c.faction=n.faction AND c.levelName=n.levelName;

PRINT N'UPDATE ONLY definitionconfig FOR FACTION+LEVEL COLOR COMBINATIONS';
MERGE definitionconfig d
USING #SPECIAL_COLORS c
ON d.definition=c.def
WHEN MATCHED
    THEN UPDATE SET
        note='Special Color for npc!',
        tint=c.color;

PRINT N'COLORS APPLIED:';
SELECT d.definition, d.definitionname, c.tint, c.note FROM definitionconfig c
JOIN entitydefaults d on d.definition=c.definition
WHERE d.definition IN (SELECT def FROM #NPCS_BY_FACTION_BY_LEVEL)
ORDER BY d.definition;


DROP TABLE IF EXISTS #SPECIAL_COLORS;
DROP TABLE IF EXISTS #BOTS_BY_FACTION;
DROP TABLE IF EXISTS #NPCS_BY_FACTION_BY_LEVEL;
DROP TABLE IF EXISTS #COLORS;
PRINT N'DONE APPLYING COLORS';
GO