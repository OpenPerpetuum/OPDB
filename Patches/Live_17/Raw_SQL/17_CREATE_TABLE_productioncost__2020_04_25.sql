USE [perpetuumsa]
GO

----------------------------------------------------------------------------
--Migration to add productioncost Table
--Table contains production cost multiplier for nic costs associated with production
--
--Date modified: 2020/04/25
----------------------------------------------------------------------------


DROP TABLE IF EXISTS dbo.productioncost;

CREATE TABLE dbo.productioncost (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	category BIGINT,
	tiertype INT,
	tierlevel INT,
	costmodifier FLOAT NOT NULL DEFAULT 1.0
);


INSERT INTO dbo.productioncost (category, tiertype, tierlevel, costmodifier) VALUES
(NULL, NULL, 1, 1.0),
(NULL, NULL, 2, 2.0),
(NULL, NULL, 3, 3.0),
(NULL, NULL, 4, 4.0),
((SELECT value FROM categoryFlags WHERE name='cf_thelodica_runners'), NULL, NULL, 1.0),
((SELECT value FROM categoryFlags WHERE name='cf_thelodica_crawlers'), NULL, NULL, 2.0),
((SELECT value FROM categoryFlags WHERE name='cf_thelodica_mechs'), NULL, NULL, 3.0),
((SELECT value FROM categoryFlags WHERE name='cf_thelodica_heavymechs'), NULL, NULL, 4.0),
((SELECT value FROM categoryFlags WHERE name='cf_nuimqol_runners'), NULL, NULL, 1.0),
((SELECT value FROM categoryFlags WHERE name='cf_nuimqol_crawlers'), NULL, NULL, 2.0),
((SELECT value FROM categoryFlags WHERE name='cf_nuimqol_mechs'), NULL, NULL, 3.0),
((SELECT value FROM categoryFlags WHERE name='cf_nuimqol_heavymechs'), NULL, NULL, 4.0),
((SELECT value FROM categoryFlags WHERE name='cf_pelistal_runners'), NULL, NULL, 1.0),
((SELECT value FROM categoryFlags WHERE name='cf_pelistal_crawlers'), NULL, NULL, 2.0),
((SELECT value FROM categoryFlags WHERE name='cf_pelistal_mechs'), NULL, NULL, 3.0),
((SELECT value FROM categoryFlags WHERE name='cf_pelistal_heavymechs'), NULL, NULL, 4.0),
((SELECT value FROM categoryFlags WHERE name='cf_syndicate_runners'), NULL, NULL, 1.0),
((SELECT value FROM categoryFlags WHERE name='cf_syndicate_crawlers'), NULL, NULL, 2.0),
((SELECT value FROM categoryFlags WHERE name='cf_syndicate_mechs'), NULL, NULL, 3.0),
((SELECT value FROM categoryFlags WHERE name='cf_syndicate_heavymechs'), NULL, NULL, 4.0),
((SELECT value FROM categoryFlags WHERE name='cf_industrial_runners'), NULL, NULL, 1.0),
((SELECT value FROM categoryFlags WHERE name='cf_industrial_crawlers'), NULL, NULL, 2.0),
((SELECT value FROM categoryFlags WHERE name='cf_industrial_mechs'), NULL, NULL, 3.0),
((SELECT value FROM categoryFlags WHERE name='cf_industrial_heavymechs'), NULL, NULL, 4.0),
((SELECT value FROM categoryFlags WHERE name='cf_industrial_heavy_gliders'), NULL, NULL, 4.0),
((SELECT value FROM categoryFlags WHERE name='cf_walkers'), NULL, NULL, 5.0);

GO