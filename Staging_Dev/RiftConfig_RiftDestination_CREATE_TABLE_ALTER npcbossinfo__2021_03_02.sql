USE [perpetuumsa]
GO

--------------------------------------------------------
--Datamodel for new custom dynamic rifts and their teleport destinations
--Each riftconfig describes the behaviour of a rift, whereever and how ever it spawns
--The riftconfig points to a destination group which is a weighted-collection of locations on the world
--Riftconfigs can/will have other constraints, like max uses per its lifetime, a lifespan before it despawn, etc.
--
--Date modified: 2021/03/12
--------------------------------------------------------
PRINT N'DROP/CREATE [dbo].[riftconfigs]';
DROP TABLE IF EXISTS [dbo].[riftconfigs];
CREATE TABLE [dbo].[riftconfigs] (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	destinationGroupId INT,
	lifespanSeconds INT,
	maxUses INT,
	categoryExclusionGroupId INT
);
PRINT N'DROP/CREATE [dbo].[riftdestinations]';
DROP TABLE IF EXISTS [dbo].[riftdestinations];
CREATE TABLE [dbo].[riftdestinations] (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	groupId INT NOT NULL,
	zoneId INT NOT NULL,
	x INT,
	y INT,
	weight INT NOT NULL DEFAULT 1
);

PRINT N'DROP/CREATE [dbo].[categorygroups]';
DROP TABLE IF EXISTS [dbo].[categorygroups];
CREATE TABLE [dbo].[categorygroups] (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	groupId INT NOT NULL,
	category BIGINT NOT NULL
);

PRINT N'DROP/CREATE [dbo].[categorygroupsnames]';
DROP TABLE IF EXISTS [dbo].[categorygroupsnames];
CREATE TABLE [dbo].[categorygroupsnames] (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	name VARCHAR(100) NOT NULL
);

PRINT N'ALTER [dbo].[npcbossinfo]';
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[perpetuumsa].[dbo].[npcbossinfo]')
	AND name = 'riftConfigId')
BEGIN
	PRINT N'ADDING COL riftConfigId';
	ALTER TABLE [perpetuumsa].[dbo].[npcbossinfo] ADD
		riftConfigId INT NULL;
END
GO

USE [perpetuumsa]
GO

INSERT INTO [dbo].[categorygroupsnames] (name) VALUES
('destro'),
('destroHM'),
('destroMech'),
('destroAssault'),
('destroLight');

INSERT INTO [dbo].[categorygroups] (groupId, category) VALUES
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destro'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_walkers')),

((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroHM'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_walkers')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroHM'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_heavy_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroHM'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_industrial_heavy_gliders')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroHM'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_industrial_heavymechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroHM'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_nuimqol_heavymechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroHM'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_pelistal_heavymechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroHM'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_syndicate_heavymechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroHM'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_thelodica_heavymechs')),

((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroMech'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_walkers')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroMech'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_heavy_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroMech'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_industrial_heavy_gliders')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroMech'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_industrial_heavymechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroMech'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_nuimqol_heavymechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroMech'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_pelistal_heavymechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroMech'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_syndicate_heavymechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroMech'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_thelodica_heavymechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroMech'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroMech'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_industrial_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroMech'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_nuimqol_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroMech'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_pelistal_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroMech'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_syndicate_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroMech'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_thelodica_mechs')),

((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroAssault'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_walkers')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroAssault'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_heavy_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroAssault'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_industrial_heavy_gliders')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroAssault'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_industrial_heavymechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroAssault'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_nuimqol_heavymechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroAssault'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_pelistal_heavymechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroAssault'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_syndicate_heavymechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroAssault'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_thelodica_heavymechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroAssault'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroAssault'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_industrial_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroAssault'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_nuimqol_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroAssault'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_pelistal_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroAssault'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_syndicate_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroAssault'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_thelodica_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroAssault'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_crawlers')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroAssault'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_industrial_crawlers')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroAssault'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_nuimqol_crawlers')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroAssault'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_pelistal_crawlers')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroAssault'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_syndicate_crawlers')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroAssault'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_thelodica_crawlers')),

((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_walkers')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_heavy_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_industrial_heavy_gliders')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_industrial_heavymechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_nuimqol_heavymechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_pelistal_heavymechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_syndicate_heavymechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_thelodica_heavymechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_industrial_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_nuimqol_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_pelistal_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_syndicate_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_thelodica_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_crawlers')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_industrial_crawlers')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_nuimqol_crawlers')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_pelistal_crawlers')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_syndicate_crawlers')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_thelodica_crawlers')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_runners')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_industrial_runners')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_nuimqol_runners')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_pelistal_runners')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_syndicate_runners')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_thelodica_runners'));

PRINT N'INSERT INTO [dbo].[riftdestinations]';
INSERT INTO [dbo].[riftdestinations] (groupId, zoneId, x, y, weight) VALUES
(71, 71, 37, 170, 1),
(72, 72, 218, 29, 1);

PRINT N'INSERT INTO [dbo].[riftconfigs]';
INSERT INTO [dbo].[riftconfigs] (name, destinationGroupId, lifespanSeconds, maxUses, categoryExclusionGroupId) VALUES 
('stronghold_z71_entry', 71, 120, 1, (SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroAssault')),
('stronghold_z72_entry', 72, 120, 1, (SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroMech'));


PRINT N'UPDATE npcbossinfo for boss entry riftconfigs';
PRINT N'Boss for 71 entrance config';
UPDATE npcbossinfo SET
	riftConfigId = (SELECT TOP 1 id FROM [dbo].[riftconfigs] WHERE name='stronghold_z71_entry')
WHERE flockid = (SELECT TOP 1 id FROM npcflock WHERE name='Rough_Rider_Leader');

PRINT N'Boss for 72 entrance config';
UPDATE npcbossinfo SET
	riftConfigId = (SELECT TOP 1 id FROM [dbo].[riftconfigs] WHERE name='stronghold_z72_entry')
WHERE flockid = (SELECT TOP 1 id FROM npcflock WHERE name='Hersh_RR_1');

GO