USE [perpetuumsa]
GO

-------------------------------------------------
-- Boss announcer features
-- Add column to npcbossinfo
-- Insert new channel for reporting
-- Update select bossinfos with flag value
-- Date modified: 2021/05/10
-------------------------------------------------

PRINT N'ALTER [dbo].[npcbossinfo]';
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[perpetuumsa].[dbo].[npcbossinfo]')
	AND name = 'isAnnounced')
BEGIN
	PRINT N'ADDING COL isAnnounced';
	ALTER TABLE [perpetuumsa].[dbo].[npcbossinfo] ADD
		isAnnounced BIT NOT NULL DEFAULT(0);
END
GO

USE [perpetuumsa]
GO
PRINT N'ADDING NEW CHAT CHANNEL FOR NPC ANNOUNCEMENTS';
DECLARE @chanName AS VARCHAR(100) = 'Syndicate Radio';

IF NOT EXISTS (SELECT TOP 1 name FROM channels WHERE name=@chanName)
BEGIN
	PRINT N'INSERT INTO channels '+@chanName;
	INSERT INTO channels (name, password, topic, type) VALUES
	(@chanName, NULL, '', 1);
END

GO

USE [perpetuumsa]
GO
PRINT N'UPDATE npcbossinfo WITH isAnnounced CONFIGS';
UPDATE npcbossinfo SET
	isAnnounced=1
WHERE flockid IN (SELECT id FROM npcflock WHERE npcSpecialType=1 AND name IN 
(
'Rough_Rider_Leader',
'def_npc_Imperial_Infantry',
'def_npc_Tribal_Member',
'def_npc_Sacrist_Convert',
'hersh_yellow_boss',
'Blue_Hersh_mech_boss',
'hersh_GreenBoss',
'Hersh_RR_1',
'Hersh_Pit_Boss',
'Norhoop_Pitboss_flock_boss',
'Hokkogaros_Pitboss_flock_boss',
'Domhalarn_Pitboss_flock_boss',
'def_npc_sh70_mainboss_94_108_z70'
));

GO