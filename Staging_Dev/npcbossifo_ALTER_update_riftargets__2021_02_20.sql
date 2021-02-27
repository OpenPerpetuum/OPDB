USE [perpetuumsa]
GO

------------------------------------------------
-- ALTER npcbossinfo ADD rift target zone,x,y
-- Update npcbosses with target to mini strongholds (WIP)
--
-- Date: 2/20/2021
------------------------------------------------

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[perpetuumsa].[dbo].[npcbossinfo]')
	AND name = 'riftTargetZoneId')
BEGIN
	PRINT N'ADDING COL riftTargetZoneId';
	ALTER TABLE [perpetuumsa].[dbo].[npcbossinfo] ADD
		riftTargetZoneId INT NULL;
END

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[perpetuumsa].[dbo].[npcbossinfo]')
	AND name = 'riftTargetX')
BEGIN
	PRINT N'ADDING COL riftTargetX';
	ALTER TABLE [perpetuumsa].[dbo].[npcbossinfo] ADD
		riftTargetX INT NULL;
END

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[perpetuumsa].[dbo].[npcbossinfo]')
	AND name = 'riftTargetY')
BEGIN
	PRINT N'ADDING COL riftTargetY';
	ALTER TABLE [perpetuumsa].[dbo].[npcbossinfo] ADD
		riftTargetY INT NULL;
END

GO

USE [perpetuumsa]
GO

-- TODO placeholder values, seek design team feedback on entrance locations

UPDATE npcbossinfo SET
	riftTargetZoneId = 71,
	riftTargetX = 111,
	riftTargetY = 111
WHERE flockid = (SELECT TOP 1 id FROM npcflock WHERE name='Rough_Rider_Leader')

UPDATE npcbossinfo SET
	riftTargetZoneId = 72,
	riftTargetX = 111,
	riftTargetY = 111
WHERE flockid = (SELECT TOP 1 id FROM npcflock WHERE name='Hersh_RR_1')

GO