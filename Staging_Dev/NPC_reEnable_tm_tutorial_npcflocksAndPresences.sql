USE [perpetuumsa]
GO

PRINT N'Fix for missing tutorial spawns on New Virginia';
DECLARE @presenceID int
DECLARE @flockID int;
DECLARE @definitionID int;

--Disable patched arkhe spawns
PRINT N'Disable flocks and presences that were added from patches';
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'tma_Pelistaldrones' ORDER BY id DESC)
UPDATE [dbo].[npcpresence] SET [enabled] = 0 WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_dummy_decoy_tm' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Arkhe_TM' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [enabled] = 0 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_dummy_decoy_tm' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Arkhe_TM2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [enabled] = 0 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_dummy_decoy_tm' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Arkhe_TM3' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [enabled] = 0 WHERE id=@flockID;

--Insert new Presence to handle all tutorial flocks on NV---
PRINT N'Insert new Presence to handle all tutorial flocks on NV';
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('tma_tutorial_presences',7,7,2040,2040,'tm tutorial flocks',1,1,0,0,0,0,0,0,0,0,0,1,1);


SET @presenceID = (SELECT TOP 1 id FROM npcpresence WHERE name='tma_tutorial_presences');

--Grab all old tutorial flocks from the old/disabled NV presence
PRINT N'Reassign the presenceID of all tutorial flocks to this new enabled presence';
UPDATE npcflock
SET presenceid = @presenceID
WHERE name like 'flock_missiontarget_tm_%' and name like '%tutorial%';
--Depends on old flock naming syntax!

GO