USE [perpetuumsa]
GO


----Armor Plate Balance: Demob resists----
PRINT N'Armor Plate balance';

DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;

--THE FIELD TO MODIFY--
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'massiveness' ORDER BY [name] DESC);

--SMALL PLATES--
--T1 SMALL
PRINT N'T1 SMALL';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_armor_plate' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.1 WHERE id =  @aggvalueID;


--T2 SMALL
PRINT N'T2 SMALL + proto';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_armor_plate' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.1 WHERE id =  @aggvalueID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_armor_plate_pr' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.1 WHERE id =  @aggvalueID;


--T3 SMALL
PRINT N'T3 SMALL + proto';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_small_armor_plate' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.11 WHERE id =  @aggvalueID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_small_armor_plate_pr' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.11 WHERE id =  @aggvalueID;


--T4 SMALL
PRINT N'T4 SMALL + proto';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_small_armor_plate' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.12 WHERE id =  @aggvalueID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_small_armor_plate_pr' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.12 WHERE id =  @aggvalueID;




--MEDIUM PLATES--
--T1
PRINT N'T1 Medium';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_armor_plate' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.12 WHERE id =  @aggvalueID;


--T2
PRINT N'T2 Med + proto';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_armor_plate' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.12 WHERE id =  @aggvalueID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_armor_plate_pr' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.12 WHERE id =  @aggvalueID;


--T3
PRINT N'T3 Med + proto';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_armor_plate' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.13 WHERE id =  @aggvalueID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_armor_plate_pr' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.13 WHERE id =  @aggvalueID;


--T4
PRINT N'T4 Med + proto';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_armor_plate' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.15 WHERE id =  @aggvalueID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_armor_plate_pr' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.15 WHERE id =  @aggvalueID;


GO

USE [perpetuumsa]
GO

--Free-raoming Red NPC revisions and additions
--NV will have 4 presences of 1 ECM indy light bot each, 2 arganos and 2 lairds total in 4 independent presences
--Hersh will have 4 presences of 2 ECM light indy bots each, 4 arganos and 4 lairds total, 2 presences of 2 arganos, 2 presences of 2 lairds.

PRINT N'-----------ROAMING RED NPC ECMers--Revised and New--------------';


------DISABLE OLD/BAD PRESENCES--------
PRINT N'Disable redundant/old presences and flocks for NV free roaming ecmers';
DECLARE @presenceID int;
DECLARE @flockID int;
DECLARE @definitionID int;
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'tma_antiafksequerscum' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [note] = 'DEPRECATED -- DISABLED',[enabled] = 0
                WHERE id=@presenceID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'the_joker_is_me' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [note] = 'DEPRECATED -- DISABLED',  [enabled] = 0 WHERE id=@flockID;



SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'tma_antiafksequerscum2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [note] = 'DEPRECATED -- DISABLED',[enabled] = 0
                WHERE id=@presenceID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'roamingtmasequer' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [note] = 'DEPRECATED -- DISABLED',  [enabled] = 0 WHERE id=@flockID;



SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'tma_antiafksequerscum3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [note] = 'DEPRECATED -- DISABLED',[enabled] = 0
                WHERE id=@presenceID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'tmaroamingsequer6' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [note] = 'DEPRECATED -- DISABLED',  [enabled] = 0 WHERE id=@flockID;


GO

--INSERT NEW PRESENCES
PRINT N'INSERT NEW PRESENCES';

PRINT N'NV';
--insert one add'l flock for nv
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('freeroaming_NPC_New_Virginia_4',7,7,2040,2040,'New Virginia  - 1 laird ECM free roamer',1,1,0,86400,5,0,0
			    ,0,0,0,1,1,1);


PRINT N'Hersh';
--insert new 4 for hersh
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('freeroaming_NPC_Hersh_ECM_1',7,7,2040,2040,'Hersh  - 2 laird ECM free roamer',13,1,0,86400,5,0,0
			    ,0,0,0,1,1,1);

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('freeroaming_NPC_Hersh_ECM_2',7,7,2040,2040,'Hersh  - 2 argano ECM free roamer',13,1,0,86400,5,0,0
			    ,0,0,0,1,1,1);

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('freeroaming_NPC_Hersh_ECM_3',7,7,2040,2040,'Hersh  - 2 laird ECM free roamer',13,1,0,86400,5,0,0
			    ,0,0,0,1,1,1);

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('freeroaming_NPC_Hersh_ECM_4',7,7,2040,2040,'Hersh  - 2 argano ECM free roamer',13,1,0,86400,5,0,0
			    ,0,0,0,1,1,1);


GO


-------Revisions and additions to alpha romaing presences---



DECLARE @flockID int;
DECLARE @definitionID int;
DECLARE @presenceID int
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'freeroaming_NPC_New_Virginia' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'freeroaming_NPC_New_Virginia',[topx] = 7,[topy] = 7,[bottomx] = 2040,[bottomy] = 2040,[note] = 'New Virginia - 1 Laird ECM free-roamer',[spawnid] = 1,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 86400,[presencetype] = 5,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;


PRINT N'set flock member count from 2->1, respawn time from 1s->180s';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'free_roaming_laird_NV' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'free_roaming_laird_NV' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 0, [spawnoriginY] = 0 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 180, [totalspawncount] = 0, [homerange] = 70 ,[note] = 'NV Roaming Spawn 1', [respawnmultiplierlow] = 0, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

PRINT N'Remove argano from freeroaming_NPC_New_Virginia';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'free_roaming_argano_nv' ORDER BY id DESC);
DELETE FROM [dbo].[npcflock] WHERE id=@flockID;



SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'freeroaming_NPC_New_Virginia_2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'freeroaming_NPC_New_Virginia_2',[topx] = 7,[topy] = 7,[bottomx] = 2040,[bottomy] = 2040,[note] = 'New Virginia - 1 argano ECM free-roamer',[spawnid] = 1,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 86400,[presencetype] = 5,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;


PRINT N'set flock member count from 2->1, respawn time from 1s->180s';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'argano_free_roaming_NV2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'argano_free_roaming_NV2' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 0, [spawnoriginY] = 0 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 180, [totalspawncount] = 0, [homerange] = 70 ,[note] = 'free_roaming_argano2', [respawnmultiplierlow] = 0, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

PRINT N'Remove laird from freeroaming_NPC_New_Virginia_2';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'laird_free_roaming_NV2' ORDER BY id DESC);
DELETE FROM [dbo].[npcflock] WHERE id=@flockID;




SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'freeroaming_NPC_New_Virginia_3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'freeroaming_NPC_New_Virginia_3',[topx] = 7,[topy] = 7,[bottomx] = 2040,[bottomy] = 2040,[note] = 'New Virginia  - 1 argano ECM free roamer',[spawnid] = 1,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 86400,[presencetype] = 5,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;


PRINT N'set flock member count from 2->1, respawn time from 1s->180s';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Free_roaming_argano_NV3' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Free_roaming_argano_NV3' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 0, [spawnoriginY] = 0 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 180, [totalspawncount] = 0, [homerange] = 70 ,[note] = 'Free_roaming_argano_NV3', [respawnmultiplierlow] = 0, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

PRINT N'Remove laird from freeroaming_NPC_New_Virginia_3';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'free_roaming_laird_NV3' ORDER BY id DESC);
DELETE FROM [dbo].[npcflock] WHERE id=@flockID;




----------New stuff


--Insert flock into 4th NV roamer presences
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'freeroaming_NPC_New_Virginia_4' ORDER BY id DESC)
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'NV_free_roamer_laird' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('NV_free_roamer_laird', @presenceID, 1, @definitionID, 0, 0, 0, 10, 180, 0, 70, 'NV laird free roamer', 0, 1, 1, 2); 




SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'freeroaming_NPC_Hersh_ECM_2' ORDER BY id DESC)
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'free_roaming_argano_Hersh_1' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('free_roaming_argano_Hersh_1', @presenceID, 2, @definitionID, 0, 0, 0, 10, 180, 0, 70, 'Pair of ecm arganos - hersh - free roam - red', 0, 1, 1, 2); 




SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'freeroaming_NPC_Hersh_ECM_3' ORDER BY id DESC)
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'free_roaming_laird_hersh_2' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('free_roaming_laird_hersh_2', @presenceID, 2, @definitionID, 0, 0, 0, 10, 180, 0, 70, 'pair of ecm lairds, - hersh -  roaming - red', 0, 1, 1, 2); 




SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'freeroaming_NPC_Hersh_ECM_1' ORDER BY id DESC)
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'free_roaming_laird_hersh_1' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('free_roaming_laird_hersh_1', @presenceID, 2, @definitionID, 0, 0, 0, 10, 180, 0, 70, 'Pair of ECM lairds - Red npc', 0, 1, 1, 2); 




SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'freeroaming_NPC_Hersh_ECM_4' ORDER BY id DESC)
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'free_roaming_argano_hersh_2' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('free_roaming_argano_hersh_2', @presenceID, 2, @definitionID, 0, 0, 0, 10, 180, 0, 70, 'pair of ecm arganos - hersh - free roaming - red', 1, 1, 1, 2); 

GO

USE [perpetuumsa]
GO


PRINT N'NEW PRESENCES AND FLOCKS TO BETA 2s';

DECLARE @flockID int;
DECLARE @definitionID int;
DECLARE @presenceID int;

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('Presence_KentSI_LowLevel1',464,867,664,1067,'Presence_KentSI_LowLevel1',5,1,0,0,0,'',''
			    ,'','','',0,1,1);


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Presence_KentSI_LowLevel1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Presence_KentSI_LowLevel1',[topx] = 464,[topy] = 867,[bottomx] = 664,[bottomy] = 1067,[note] = 'Presence_KentSI_LowLevel1',[spawnid] = 14,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_prometheus_scout_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'KentSI_Lowlevel_Light' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('KentSI_Lowlevel_Light', @presenceID, 2, @definitionID, 280, 1250, 0, 5, 60, 0, 15, 'KentSI_Lowlevel_Light', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_intakt_ewjammer_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'KentSI_Lowlevel_LightEW' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('KentSI_Lowlevel_LightEW', @presenceID, 1, @definitionID, 280, 1250, 0, 5, 60, 0, 15, 'KentSI_Lowlevel_LightEW', 1, 1, 1, 1); 



INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('Presence_Kent_LowLevel2',464,867,664,1067,'Presence_Kent_LowLevel1',14,1,0,0,0,0,0
			    ,0,0,0,0,1,1);


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Presence_Kent_LowLevel2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Presence_Kent_LowLevel2',[topx] = 464,[topy] = 867,[bottomx] = 664,[bottomy] = 1067,[note] = 'Presence_Kent_LowLevel1',[spawnid] = 14,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_zenith_dps_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Kent_lowlevel2_MechEW' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kent_lowlevel2_MechEW', @presenceID, 2, @definitionID, 475, 1000, 0, 5, 60, 0, 15, 'Kent_lowlevel2_MechEW', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_hybrid_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Kent_lowlevel2_HM' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kent_lowlevel2_HM', @presenceID, 1, @definitionID, 475, 1000, 0, 5, 60, 0, 15, 'Kent_lowlevel2_HM', 1, 1, 1, 1); 



INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('Presence_KentLao_LowLevel3',464,867,664,1067,'Presence_Kent_LowLevel1',14,1,0,0,0,0,0
			    ,0,0,0,0,1,1);


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Presence_KentLao_LowLevel3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Presence_KentLao_LowLevel3',[topx] = 464,[topy] = 867,[bottomx] = 664,[bottomy] = 1067,[note] = 'Presence_KentLao_LowLevel1',[spawnid] = 14,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_prometheus_scout_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'kentLao_LowLevel3_Light' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kentLao_LowLevel3_Light', @presenceID, 2, @definitionID, 1160, 320, 0, 10, 60, 0, 15, 'kentlao_lowlevel3_Light', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_intakt_ewjammer_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'kentLao_LowLevel3_LightEW' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kentLao_LowLevel3_LightEW', @presenceID, 1, @definitionID, 1160, 320, 0, 10, 60, 0, 15, 'kentlao_lowlevel3_LightEW', 1, 1, 1, 1); 



INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('Presence_KentLao_LowLevel4',464,867,664,1067,'Presence_KentLao_LowLevel4',14,1,0,0,0,0,0
			    ,0,0,0,0,1,1);


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Presence_KentLao_LowLevel4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Presence_KentLao_LowLevel4',[topx] = 464,[topy] = 867,[bottomx] = 664,[bottomy] = 1067,[note] = 'Presence_KentLao_LowLevel4',[spawnid] = 14,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_zenith_dps_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'KentLao_LowLevel4_MechEW' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('KentLao_LowLevel4_MechEW', @presenceID, 2, @definitionID, 951, 283, 0, 10, 60, 0, 15, 'KentLao_LowLevel4_MechEW', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_hybrid_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'KentLao_LowLevel4_HM' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('KentLao_LowLevel4_HM', @presenceID, 1, @definitionID, 878, 1380, 0, 10, 60, 0, 15, 'KentLao_LowLevel4_HM', 1, 1, 1, 1); 



INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('Presence_Als_LowLevel1',464,867,664,1067,'Presence_ALS_LowLevel1',15,1,0,0,0,0,0
			    ,0,0,0,0,1,1);


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Presence_Als_LowLevel1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Presence_Als_LowLevel1',[topx] = 464,[topy] = 867,[bottomx] = 664,[bottomy] = 1067,[note] = 'Presence_ALS_LowLevel1',[spawnid] = 15,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_scout_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'ALSFD_LowLevel1_Light' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('ALSFD_LowLevel1_Light', @presenceID, 2, @definitionID, 1315, 845, 0, 5, 60, 0, 15, 'ALSFD_LowLevel1_Light', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_cameleon_interceptor_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'ALSFD_LowLevel1_LightEW' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('ALSFD_LowLevel1_LightEW', @presenceID, 1, @definitionID, 1315, 845, 0, 5, 60, 0, 15, 'ALSFD_LowLevel1_LightEW', 1, 1, 1, 1); 



INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('Presence_AlsFD_LowLevel2',464,867,664,1067,'Presence_ALSFD_LowLevel2',15,1,0,0,0,0,0
			    ,0,0,0,0,1,1);


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Presence_AlsFD_LowLevel2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Presence_AlsFD_LowLevel2',[topx] = 464,[topy] = 867,[bottomx] = 664,[bottomy] = 1067,[note] = 'Presence_ALSFD_LowLevel2',[spawnid] = 15,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_hybrid_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'ALSFD_LowLevel2_HM' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('ALSFD_LowLevel2_HM', @presenceID, 1, @definitionID, 1075, 930, 2, 5, 60, 0, 15, 'ALSFD_LowLevel2_HM', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ictus_dps_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'ALSFD_LowLevel2_MechEW' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('ALSFD_LowLevel2_MechEW', @presenceID, 2, @definitionID, 1075, 930, 2, 5, 60, 0, 15, 'ALSFD_LowLevel2_MechEW', 1, 1, 1, 1); 



INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('Presence_AlsBS_LowLevel3',464,867,664,1067,'Presence_ALSBS_LowLevel3',15,1,0,0,0,0,0
			    ,0,0,0,0,1,1);


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Presence_AlsBS_LowLevel3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Presence_AlsBS_LowLevel3',[topx] = 464,[topy] = 867,[bottomx] = 664,[bottomy] = 1067,[note] = 'Presence_ALSBS_LowLevel3',[spawnid] = 15,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_castel_scout_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'ALSBS_LowLevel3_Light' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('ALSBS_LowLevel3_Light', @presenceID, 2, @definitionID, 535, 1584, 0, 5, 60, 0, 15, 'ALSBS_LowLevel3_Light', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_troiar_ewjammer_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'ALSBS_LowLevel3_LightEW' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('ALSBS_LowLevel3_LightEW', @presenceID, 1, @definitionID, 535, 1584, 0, 5, 60, 0, 15, 'ALSBS_LowLevel3_LightEW', 1, 1, 1, 1); 



INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('Presence_AlsBS_LowLevel4',464,867,664,1067,'Presence_ALSBS_LowLevel4',15,1,0,0,0,0,0
			    ,0,0,0,0,1,1);


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Presence_AlsBS_LowLevel4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Presence_AlsBS_LowLevel4',[topx] = 464,[topy] = 867,[bottomx] = 664,[bottomy] = 1067,[note] = 'Presence_ALSBS_LowLevel4',[spawnid] = 15,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_hybrid_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'ALSBS_LowLevel4_HM' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('ALSBS_LowLevel4_HM', @presenceID, 1, @definitionID, 800, 1530, 2, 5, 60, 0, 15, 'ALSBS_LowLevel4_HM', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ictus_dps_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'ALSBS_LowLevel4_MechEW' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('ALSBS_LowLevel4_MechEW', @presenceID, 2, @definitionID, 800, 1530, 2, 5, 60, 0, 15, 'ALSBS_LowLevel4_MechEW', 1, 1, 1, 1); 



INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('Presence_NovaDana_LowLevel1',464,867,664,1067,'Presence_NovaDana_LowLevel1',16,1,0,0,0,0,0
			    ,0,0,0,0,1,1);


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Presence_NovaDana_LowLevel1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Presence_NovaDana_LowLevel1',[topx] = 464,[topy] = 867,[bottomx] = 664,[bottomy] = 1067,[note] = 'Presence_NovaDana_LowLevel1',[spawnid] = 16,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_scout_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'NovaDana_LowLevel1_light' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('NovaDana_LowLevel1_light', @presenceID, 2, @definitionID, 715, 830, 2, 5, 60, 0, 15, 'NovaDana_LowLevel1_light', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_cameleon_ewjammer_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'NovaDana_LowLevel1_LightEW' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('NovaDana_LowLevel1_LightEW', @presenceID, 1, @definitionID, 715, 830, 2, 5, 60, 0, 15, 'NovaDana_LowLevel1_light', 1, 1, 1, 1); 



INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('Presence_NovaDana_LowLevel2',464,867,664,1067,'Presence_NovaDana_LowLevel2',16,1,0,0,0,0,0
			    ,0,0,0,0,1,1);


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Presence_NovaDana_LowLevel2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Presence_NovaDana_LowLevel2',[topx] = 464,[topy] = 867,[bottomx] = 664,[bottomy] = 1067,[note] = 'Presence_NovaDana_LowLevel2',[spawnid] = 16,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_hybrid_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'NovaDana_LowLevel2_HM' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('NovaDana_LowLevel2_HM', @presenceID, 1, @definitionID, 550, 963, 2, 5, 60, 0, 15, 'NovaDana_LowLevel2_HM', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vagabond_dps_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'NovaDana_LowLevel2_MechEW' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('NovaDana_LowLevel2_MechEW', @presenceID, 2, @definitionID, 550, 963, 2, 5, 60, 0, 15, 'NovaDana_LowLevel2_MechEW', 1, 1, 1, 1); 



INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('Presence_NovaNC_LowLevel3',464,867,664,1067,'Presence_NovaNC_LowLevel3',16,1,0,0,0,0,0
			    ,0,0,0,0,1,1);


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Presence_NovaNC_LowLevel3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Presence_NovaNC_LowLevel3',[topx] = 464,[topy] = 867,[bottomx] = 664,[bottomy] = 1067,[note] = 'Presence_NovaNC_LowLevel3',[spawnid] = 16,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_scout_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'NovaNC_LowLevel3_Light' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('NovaNC_LowLevel3_Light', @presenceID, 2, @definitionID, 1700, 1190, 0, 5, 60, 0, 15, 'NovaNC_LowLevel3_Light', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_cameleon_interceptor_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'NovaNC_LowLevel3_LightEW' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('NovaNC_LowLevel3_LightEW', @presenceID, 1, @definitionID, 1700, 1190, 0, 5, 60, 0, 15, 'NovaNC_LowLevel3_lightEW', 1, 1, 1, 1); 



INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('Presence_NovaNC_LowLevel4',464,867,664,1067,'Presence_NovaNC_LowLevel4',16,1,0,0,0,0,0
			    ,0,0,0,0,1,1);


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Presence_NovaNC_LowLevel4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Presence_NovaNC_LowLevel4',[topx] = 464,[topy] = 867,[bottomx] = 664,[bottomy] = 1067,[note] = 'Presence_NovaNC_LowLevel4',[spawnid] = 16,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_hybrid_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'NovaNC_LowLevel4_HM' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('NovaNC_LowLevel4_HM', @presenceID, 1, @definitionID, 1790, 950, 0, 10, 60, 0, 15, 'NovaNC_LowLevel4_HM', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vagabond_dps_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'NovaNC_LowLevel4_mechEW' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('NovaNC_LowLevel4_mechEW', @presenceID, 2, @definitionID, 1790, 950, 0, 10, 60, 0, 15, 'NovaNC_LowLevel4_mechEW', 1, 1, 1, 1); 



GO

USE [perpetuumsa]
GO

DECLARE @flockID int;
DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
DECLARE @templateID int;
DECLARE @presenceID int;
DECLARE @lootdefinitionID int;


--YELLOW BOSS
PRINT N'YELLOW BOSS';

PRINT N'INSERT NEW NPC DEF';
INSERT INTO entitydefaults ( definitionname ,  quantity ,  attributeflags ,  categoryflags ,  options ,  note ,  enabled ,  volume ,  mass ,  hidden , 
                health ,  descriptiontoken ,  purchasable ,  tiertype ,  tierlevel ) 
                VALUES ( 'def_npc_Sacrist_Mythic', 1, 1024, 911, '', '', 1, 0, 0, 'False', 100, 'def_npc_artemis_dps_rank3_desc', 0, 0, 0); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_Sacrist_Mythic' ORDER BY definition DESC);

PRINT N'INSERT NEW AGGVALUES';
UPDATE entitydefaults Set definitionname='def_npc_Sacrist_Mythic', quantity=1, attributeflags=1024, categoryflags=911, options='', 
                note='', enabled=1, volume=0, mass=0, hidden='False', health=100, descriptiontoken='def_npc_artemis_dps_rank3_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.75);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2.0);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_recharge_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.0);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.0);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'falloff_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.0);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locking_range_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.0);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locking_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.0);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'missile_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.0);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'optimal_range_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.0);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'turret_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.0);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'received_repaired_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.1);

PRINT N'INSERT NEW TEMPLATE RELATION';
SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'Artemis NPC DPS' ORDER BY id DESC)

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_Sacrist_Mythic' ORDER BY definition DESC);

INSERT INTO [dbo].[robottemplaterelation] ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
                VALUES (@definitionID,@templateID,0,0,0,0,6,'Yellow_Hersh_boss');


PRINT N'INSERT LOOT ENTRIES';

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_Sacrist_Mythic' ORDER BY definition DESC);


SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_laser' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.5, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_sensor_jammer' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.5, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_tracking_upgrade' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.5, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_armor_repairer_upgrade' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.5, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_armor_repairer' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.5, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_armor_plate' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.5, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_resistant_plating' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.5, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_thelodica_expert' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 50, 1, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_thelodica_reactor_plasma' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 3351, 1, 0,0, 2741);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1920, 1, 0,1, 1280);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_thelodica' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 7680, 1, 0,1, 5120);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 3000, 1.0, 1,1, 2500);

PRINT N'INSERT PRESENCE';

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_Hersh_YellowBoss',822,583,1022,783,'Hersh_YellowBoss',13,1,0,0,0,0,0
			    ,0,0,0,0,1,1);

PRINT N'INSERT FLOCKS';

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_Hersh_YellowBoss' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_Hersh_YellowBoss',[topx] = 822,[topy] = 583,[bottomx] = 1022,[bottomy] = 783,[note] = 'Hersh_YellowBoss',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_Sacrist_Mythic' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'hersh_yellow_boss' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hersh_yellow_boss', @presenceID, 1, @definitionID, 825, 486, 0, 5, 7200, 0, 30, 'hersh_yellow_boss', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_intakt_miniboss_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'hersh_yellow_bossLEW' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hersh_yellow_bossLEW', @presenceID, 2, @definitionID, 825, 486, 0, 5, 7200, 0, 30, 'hersh_yellow_bossLEW', 1, 1, 1, 1); 


GO


--Blue Boss

PRINT N'BLUE BOSS';
DECLARE @flockID int;
DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
DECLARE @templateID int;
DECLARE @presenceID int;
DECLARE @lootdefinitionID int;

PRINT N'INSERT NEW NPC DEF';
INSERT INTO entitydefaults ( definitionname ,  quantity ,  attributeflags ,  categoryflags ,  options ,  note ,  enabled ,  volume ,  mass ,  hidden , 
                health ,  descriptiontoken ,  purchasable ,  tiertype ,  tierlevel ) 
                VALUES ( 'def_npc_clan_griffin', 1, 1024, 1167, '', '', 1, 0, 0, 'False', 100, 'def_npc_kain_dps_rank3_desc', 0, 0, 0); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_clan_griffin' ORDER BY definition DESC);

PRINT N'INSERT AGGVALUES';
UPDATE entitydefaults Set definitionname='def_npc_clan_griffin', quantity=1, attributeflags=1024, categoryflags=1167, options='', 
                note='', enabled=1, volume=0, mass=0, hidden='False', health=100, descriptiontoken='def_npc_kain_dps_rank3_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.75);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.5);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_recharge_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.0);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.0);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'falloff_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.0);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locking_range_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.0);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locking_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.0);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'missile_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.0);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'optimal_range_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.0);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'turret_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.0);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'received_repaired_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.1);

PRINT N'INSERT NEW TEMPLATE RELATION';
SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'Kain NPC DPS' ORDER BY id DESC)

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_clan_griffin' ORDER BY definition DESC);

INSERT INTO [dbo].[robottemplaterelation] ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
                VALUES (@definitionID,@templateID,0,0,0,0,6,'def_NPC_CLAN_GRIFFIN');

PRINT N'INSERT LOOTS';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_clan_griffin' ORDER BY definition DESC);


SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_railgun' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.5, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_sensor_jammer' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.5, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_tracking_upgrade' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.5, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_armor_repairer_upgrade' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.5, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_armor_repairer' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.5, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_armor_plate' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.5, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_resistant_plating' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.5, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_nuimqol_expert' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 50, 1, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_nuimqol_reactor_plasma' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 3351, 1, 0,0, 2741);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1920, 1, 0,1, 1280);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_nuimqol' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 7680, 1, 0,1, 5120);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 3000, 1.0, 1,1, 2500);

PRINT N'INSERT PRESENCE';
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_Hersh_BlueBoss',822,583,1022,783,'TMA_BlueBoss',1,1,0,0,0,0,0
			    ,0,0,0,0,1,1);

PRINT N'INSERT FLOCKS';
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_Hersh_BlueBoss' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_Hersh_BlueBoss',[topx] = 822,[topy] = 583,[bottomx] = 1022,[bottomy] = 783,[note] = 'Hersh_BlueBoss',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_clan_griffin' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Blue_Hersh_mech_boss' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Blue_Hersh_mech_boss', @presenceID, 1, @definitionID, 1720, 670, 0, 5, 7200, 0, 30, 'Blue_Hersh_mech_spawn', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_cameleon_miniboss_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Blue_Hersh_LEW_Bossspawn' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Blue_Hersh_LEW_Bossspawn', @presenceID, 2, @definitionID, 1720, 670, 0, 5, 7200, 0, 30, 'Blue_Hersh_LEW_Bossspawn', 1, 1, 1, 1); 


GO



--GREEN BOSS
PRINT N'GREEN BOSS';

DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
DECLARE @templateID int
DECLARE @lootdefinitionID int;
DECLARE @npclootID int;
DECLARE @presenceID int
DECLARE @flockID int;

PRINT N'INSERT NEW NPC DEF';
INSERT INTO entitydefaults ( definitionname ,  quantity ,  attributeflags ,  categoryflags ,  options ,  note ,  enabled ,  volume ,  mass ,  hidden , 
                health ,  descriptiontoken ,  purchasable ,  tiertype ,  tierlevel ) 
                VALUES ( 'def_npc_tribal_weaver', 1, 1024, 1423, '', '', 1, 0, 0, 'False', 100, 'def_npc_tyrannos_dps_rank3_desc', 0, 0, 0); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tribal_weaver' ORDER BY definition DESC);

PRINT N'INSERT AGGVALUES';
UPDATE entitydefaults Set definitionname='def_npc_tribal_weaver', quantity=1, attributeflags=1024, categoryflags=1423, options='', 
                note='', enabled=1, volume=0, mass=0, hidden='False', health=100, descriptiontoken='def_npc_tyrannos_dps_rank3_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.75);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.0);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_recharge_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.0);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.0);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'falloff_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.0);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locking_range_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.0);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locking_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.0);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'missile_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.0);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'optimal_range_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.0);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'turret_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.0);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'received_repaired_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.1);

PRINT N'INSERT TEMPLATE RELATION';
SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'Tyrannos NPC DPS' ORDER BY id DESC)


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tribal_weaver' ORDER BY definition DESC);

INSERT INTO [dbo].[robottemplaterelation] ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
                VALUES (@definitionID,@templateID,0,0,0,0,6,'Tribal_Weaver');

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tribal_weaver' ORDER BY definition DESC);

PRINT N'INSERT LOOT';
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_armor_repairer_upgrade' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.5, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_tracking_upgrade' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.5, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_sensor_jammer' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.5, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_missile_launcher' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.5, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_armor_repairer' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.5, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_resistant_plating' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.5, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_armor_plate' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.5, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_pelistal_expert' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 50, 1, 0,1, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_pelistal_reactor_plasma' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 3351, 1, 0,0, 2741);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1920, 1, 0,1, 1280);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_pelistal' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 7680, 1, 0,1, 5120);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 3000, 1, 1,1, 2500);

PRINT N'INSERT PRESENCE';
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_Hersh_GreenBoss',822,583,1022,783,'Hersh_GreenBoss',13,1,0,0,0,0,0
			    ,0,0,0,0,1,1);

PRINT N'INSERT FLOCKS';
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_Hersh_GreenBoss' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_Hersh_GreenBoss',[topx] = 822,[topy] = 583,[bottomx] = 1022,[bottomy] = 783,[note] = 'Hersh_GreenBoss',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tribal_weaver' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'hersh_GreenBoss' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hersh_GreenBoss', @presenceID, 1, @definitionID, 395, 1852, 0, 5, 7200, 0, 30, 'hersh_greenboss', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_troiar_miniboss_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'hersh_greenLEWBOSS' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hersh_greenLEWBOSS', @presenceID, 2, @definitionID, 395, 1852, 0, 5, 7200, 0, 30, 'hersh_greenLEWBOSS', 1, 1, 1, 1); 



GO

USE [perpetuumsa]
GO


PRINT N'HERSHFIELD ROUGH RIDERS';

DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
DECLARE @templateID int;
DECLARE @lootdefinitionID int;
DECLARE @npclootID int;
DECLARE @presenceID int;
DECLARE @flockID int;


PRINT N'INSERT ENTITYDEF def_npc_One_Eye_Josef';
INSERT INTO entitydefaults ( definitionname ,  quantity ,  attributeflags ,  categoryflags ,  options ,  note ,  enabled ,  volume ,  mass ,  hidden , 
                health ,  descriptiontoken ,  purchasable ,  tiertype ,  tierlevel ) 
                VALUES ( 'def_npc_One_Eye_Josef', 1, 1024, 911, '', '', 1, 0, 0, 'False', 100, 'def_npc_One_Eye_Josef', 0, 0, 0); 


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_One_Eye_Josef' ORDER BY definition DESC);

PRINT N'INSERT [aggregatevalues] FOR def_npc_One_Eye_Josef';
UPDATE entitydefaults Set definitionname='def_npc_One_Eye_Josef', quantity=1, attributeflags=1024, categoryflags=911, options='', 
                note='', enabled=1, volume=0, mass=0, hidden='False', health=100, descriptiontoken='def_npc_One_Eye_Josef', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2.0);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.5);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_recharge_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.0);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.75);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'falloff_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.5);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locking_range_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.25);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locking_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.75);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'missile_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.75);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'optimal_range_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.5);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'turret_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.0);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'received_repaired_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.1);


PRINT N'INSERT [robottemplaterelation] FOR def_npc_One_Eye_Josef TO echelon_masterdeathdealer';
SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'echelon_masterdeathdealer' ORDER BY id DESC)

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_One_Eye_Josef' ORDER BY definition DESC);

INSERT INTO [dbo].[robottemplaterelation] ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
                VALUES (@definitionID,@templateID,0,0,6,0,15,'def_NPC_One_Eye_Josef');


PRINT N'INSERT LOOTS FOR def_npc_One_Eye_Josef';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_One_Eye_Josef' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 15000, 1, 1,1, 12000);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 2500, 1, 1,1, 2000);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1000, 1, 1,1, 750);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 350, 0.5, 1,1, 250);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_advanced' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 350, 0.5, 1,1, 250);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_4' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.5, 1,1, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_5' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.5, 1,1, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_6' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.5, 1,1, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_armor_plate_pr' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.1, 1,1, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_armor_plate_pr' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.1, 1,1, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_armor_repairer_pr' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.1, 1,1, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_armor_repairer_pr' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.1, 1,1, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_sensor_booster_pr' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.1, 1,1, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_mass_reductor_pr' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.1, 1,1, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_7' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.5, 1,1, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_8' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.5, 1,1, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_longrange_medium_autocannon' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 2, 0.5, 1,1, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_damage_mod_projectile' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 2, 0.5, 1,1, 1);


PRINT N'INSERT [npcpresence] FOR hershfield_rough_riders';
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES 
				('hershfield_rough_riders',10,10,2038,2038,'',13,1,0,0,0,0,0,0,0,0,0,1,0);

GO


PRINT N'INSERT [npcflock]s FOR hershfield_rough_riders';
DECLARE @presenceID int;
DECLARE @definitionID int;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_rough_riders' ORDER BY id DESC);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_One_Eye_Josef' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Hersh_RR_1', @presenceID, 1, @definitionID, 1976, 1810, 0, 5, 7200, 0, 30, 'Hersh_RR_1', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_RoughRider_Cavalry' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Hersh_RR_2', @presenceID, 2, @definitionID, 1976, 1810, 0, 5, 900, 0, 30, 'Hersh_RR_2', 1, 1, 1, 1); 

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Hersh_RR_3', @presenceID, 2, @definitionID, 1930, 1753, 0, 5, 900, 0, 30, 'Hersh_RR_3', 1, 1, 1, 1); 

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Hersh_RR_4', @presenceID, 2, @definitionID, 1869, 1890, 0, 5, 900, 0, 30, 'Hersh_RR_4', 1, 1, 1, 1); 

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Hersh_RR_5', @presenceID, 2, @definitionID, 1760, 1846, 0, 5, 900, 0, 30, 'Hersh_RR_5', 1, 1, 1, 1); 



GO

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

USE [perpetuumsa]
GO

PRINT N'UPDATE LOOT FOR def_npc_RoughRider_Scout';


DECLARE @definitionID int;
DECLARE @lootdefinitionID int;
DECLARE @npclootID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_RoughRider_Scout' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=100, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=75 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=25, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=15 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_2' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_3' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_4' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.15, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.15, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_sensor_booster' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.15, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_autocannon' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.15, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 50, 1.0, 1,1, 25);



------Cavalry----


PRINT N'UPDATE LOOT FOR def_npc_RoughRider_Cavalry';

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_RoughRider_Cavalry' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=200, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=150 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_autocannon' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_4' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_5' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_6' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_advanced' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=25, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=15 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=40, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=35 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_chm_armor_hardener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.15, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_exp_armor_hardener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.15, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_kin_armor_hardener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.15, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_sensor_booster' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.15, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.15, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.15, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_remote_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.15, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_shield_generator' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.15, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_thrm_armor_hardener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.15, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 75, 1.0, 1,1, 25);


GO

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

USE [perpetuumsa]
GO

--UPDATE misplaced flock from script: NPC_beta2_easy_spawns
PRINT N'UPDATE misplaced flock from script: NPC_beta2_easy_spawns';
PRINT N'Spawn origin fix for: KentLao_LowLevel4_HM';

UPDATE npcflock
SET spawnoriginX = 951, spawnoriginY=283
WHERE name='KentLao_LowLevel4_HM';

GO