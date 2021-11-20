USE [perpetuumsa]
GO

--------------------------------------------
-- Gamma NPC EPs
-- TODO: missing special levels: courier/indy/observer/mini/boss
-- Date Modified: 2021/11/02
--------------------------------------------

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
('zenith', 'mech ewar', 'thelodica');

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
WHERE definitionname like 'def_npc_gamma_%';


DROP TABLE IF EXISTS #EP_BY_LEVEL_AND_CLASS;
CREATE TABLE #EP_BY_LEVEL_AND_CLASS(
	levelName varchar(32),
	className varchar(32),
	ep int
);
INSERT INTO #EP_BY_LEVEL_AND_CLASS (levelName, className, ep) VALUES
('l7', 'heavy mech', 62),
('l7', 'mech', 62),
('l7', 'mech ewar', 62),
('l7', 'assault', 41),
('l7', 'light ewar', 41),
('l7', 'light', 41),

('l6', 'heavy mech', 43),
('l6', 'mech', 43),
('l6', 'mech ewar', 43),
('l6', 'assault', 28),
('l6', 'light ewar', 28),
('l6', 'light', 28),

('l5', 'heavy mech', 31),
('l5', 'mech', 31),
('l5', 'mech ewar', 31),
('l5', 'assault', 20),
('l5', 'light ewar', 20),
('l5', 'light', 20),

('l4', 'heavy mech', 24),
('l4', 'mech', 24),
('l4', 'mech ewar', 24),
('l4', 'assault', 16),
('l4', 'light ewar', 16),
('l4', 'light', 16),

('l3', 'heavy mech', 18),
('l3', 'mech', 18),
('l3', 'mech ewar', 18),
('l3', 'assault', 12),
('l3', 'light ewar', 12),
('l3', 'light', 12);

PRINT N'UPDATING KILLEP ON THESE RELATIONS:';
--select * from robottemplaterelation
--where definition in (select def from #NPCS_BY_FACTION_BY_LEVEL);

MERGE [dbo].[robottemplaterelation] r USING #NPCS_BY_FACTION_BY_LEVEL n
ON r.definition = n.def
WHEN MATCHED
    THEN UPDATE SET
		r.killep=(SELECT TOP 1 ep FROM #EP_BY_LEVEL_AND_CLASS e WHERE e.levelName=n.levelName AND e.className=n.className);

PRINT N'UPDATED KILLEP ON GAMMA NPCS:';
select * from robottemplaterelation
where definition in (select def from #NPCS_BY_FACTION_BY_LEVEL);

DROP TABLE IF EXISTS #BOTS_BY_FACTION;
DROP TABLE IF EXISTS #EP_BY_LEVEL_AND_CLASS;
DROP TABLE IF EXISTS #NPCS_BY_FACTION_BY_LEVEL;
GO
