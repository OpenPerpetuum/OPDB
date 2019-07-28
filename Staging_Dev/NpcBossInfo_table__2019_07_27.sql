USE [perpetuumsa]
GO

------------------------------------------
-- NPC Boss Info Table
-- Table create to handle more detailed settings for a BossFlock
-- 
-- Date Modified: 2019/07/27
------------------------------------------

DROP TABLE IF EXISTS dbo.npcbossinfo;

CREATE TABLE dbo.npcbossinfo(
	id INT NOT NULL IDENTITY PRIMARY KEY,
	flockid INT NOT NULL,
	respawnNoiseFactor FLOAT NULL,
	lootSplitFlag BIT NOT NULL,
	outpostEID BIGINT NULL,
	customDeathMessage VARCHAR(128) NULL
);

--Insert default values
INSERT INTO dbo.npcbossinfo (flockid, respawnNoiseFactor, lootSplitFlag, outpostEID, customDeathMessage) 
SELECT npcflock.id, 0.15, 1, NULL, 'You killed a Boss!'
FROM npcflock
WHERE npcflock.npcSpecialType=1;

GO