USE [perpetuumsa]
GO

PRINT N'Split up Nuimqol hershfield presence into multiple independent presences';


PRINT N'Set the original to enabled=0';
DECLARE @presenceID int
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_numiquol_npcs' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'hershfield_numiquol_npcs',[enabled] = 0
                WHERE id=@presenceID;

PRINT N'Insert new ones to accept the old flocks';
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES 
				('hershfield_numiquol_npcs1',10,10,2038,2038,'',13,1,0,0,0,0,0,0,0,0,0,1,0),
				('hershfield_numiquol_npcs2',10,10,2038,2038,'',13,1,0,0,0,0,0,0,0,0,0,1,0),
				('hershfield_numiquol_npcs3',10,10,2038,2038,'',13,1,0,0,0,0,0,0,0,0,0,1,0),
				('hershfield_numiquol_npcs4',10,10,2038,2038,'',13,1,0,0,0,0,0,0,0,0,0,1,0),
				('hershfield_numiquol_npcs5',10,10,2038,2038,'',13,1,0,0,0,0,0,0,0,0,0,1,0),
				('hershfield_numiquol_npcs6',10,10,2038,2038,'',13,1,0,0,0,0,0,0,0,0,0,1,0),
				('hershfield_numiquol_npcs7',10,10,2038,2038,'',13,1,0,0,0,0,0,0,0,0,0,1,0),
				('hershfield_numiquol_npcs8',10,10,2038,2038,'',13,1,0,0,0,0,0,0,0,0,0,1,0),
				('hershfield_numiquol_npcs9',10,10,2038,2038,'',13,1,0,0,0,0,0,0,0,0,0,1,0),
				('hershfield_numiquol_npcs10',10,10,2038,2038,'',13,1,0,0,0,0,0,0,0,0,0,1,0);



DECLARE @flockID int;
DECLARE @definitionID int;

PRINT N'Update flocks for presence 1';
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_numiquol_npcs1' ORDER BY id DESC);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_scout_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'yagel_at_spawn41' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [presenceid] = @presenceID WHERE id=@flockID;


PRINT N'Update flocks for presence 2';
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_numiquol_npcs2' ORDER BY id DESC);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_cameleon_interceptor_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'cam_at_spawn42' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [presenceid] = @presenceID WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_dps_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'arby_at_spawn42' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [presenceid] = @presenceID WHERE id=@flockID;


PRINT N'Update flocks for presence 3';
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_numiquol_npcs3' ORDER BY id DESC);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_dps_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'yagel_at_spawn43' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [presenceid] = @presenceID WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_cameleon_ewjammer_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'cam_at_spawn43' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [presenceid] = @presenceID WHERE id=@flockID;


PRINT N'Update flocks for presence 4';
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_numiquol_npcs4' ORDER BY id DESC);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_scout_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'arby_at_spwn44' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [presenceid] = @presenceID WHERE id=@flockID;


PRINT N'Update flocks for presence 5';
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_numiquol_npcs5' ORDER BY id DESC);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_tank_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'kain_at_spawn45' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [presenceid] = @presenceID WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_cameleon_heavyew_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'cam_at_spawn45' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [presenceid] = @presenceID WHERE id=@flockID;


PRINT N'Update flocks for presence 6';
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_numiquol_npcs6' ORDER BY id DESC);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_heavydps_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mesmer_at_spawn46' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [presenceid] = @presenceID WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_ew_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'kain_at_spawn46' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [presenceid] = @presenceID WHERE id=@flockID;


PRINT N'Update flocks for presence 7';
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_numiquol_npcs7' ORDER BY id DESC);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_sniper_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mesmer_at_spawn47' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [presenceid] = @presenceID WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_tank_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mesmer2_at_spawn47' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [presenceid] = @presenceID WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vagabond_heavyew_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'vag_at_spawn47' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [presenceid] = @presenceID WHERE id=@flockID;


PRINT N'Update flocks for presence 8';
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_numiquol_npcs8' ORDER BY id DESC);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vagabond_heavyew_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'vag_at_spawn48' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [presenceid] = @presenceID WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_dps_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'kain_at_spawn48' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [presenceid] = @presenceID WHERE id=@flockID;


PRINT N'Update flocks for presence 9';
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_numiquol_npcs9' ORDER BY id DESC);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_heavydps_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mesmer_at_spawn49' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [presenceid] = @presenceID WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_sniper_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mesmer2_at_spawn49' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [presenceid] = @presenceID WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vagabond_heavyew_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'vag_at_spawn49' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [presenceid] = @presenceID WHERE id=@flockID;


PRINT N'Update flocks for presence 10';
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_numiquol_npcs10' ORDER BY id DESC);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_dps_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'arby_at_50' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [presenceid] = @presenceID WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_dps_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'kain_at_50' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [presenceid] = @presenceID WHERE id=@flockID;

GO