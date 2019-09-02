USE [perpetuumsa]
GO

------------------------------------------
-- NPC Boss Info Table
-- Table create to handle more detailed settings for a BossFlock
-- 
-- Date Modified: 2019/09/01
------------------------------------------
DROP TABLE IF EXISTS dbo.npcbossinfo;

CREATE TABLE dbo.npcbossinfo(
	id INT NOT NULL IDENTITY PRIMARY KEY,
	flockid INT NOT NULL,
	respawnNoiseFactor FLOAT NULL,
	lootSplitFlag BIT NOT NULL,
	outpostEID BIGINT NULL,
	stabilityPts INT NULL,
	overrideRelations BIT NOT NULL,
	customDeathMessage VARCHAR(128) NULL,
	customAggressMessage VARCHAR(128) NULL
);

--Insert default values
INSERT INTO dbo.npcbossinfo (flockid, respawnNoiseFactor, lootSplitFlag, outpostEID, stabilityPts, overrideRelations, customDeathMessage, customAggressMessage) 
SELECT npcflock.id, 0.15, 1, NULL, NULL, 0, 'Nice Shot! Enjoy the loot ;)', 'CAUTION: you are engaging with a particularly dangerous foe!'
FROM npcflock
WHERE npcflock.npcSpecialType=1;

GO
