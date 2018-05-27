USE [perpetuumsa]
GO

DECLARE @definitionID int;
DECLARE @flockID int;
DECLARE @presenceID int;
DECLARE @templateID int;

PRINT N'Hershfield presence/flocks manipulations';
----Adds More Solo spawns on Hershfield


--Numiquol
PRINT N'INSERT PRESENCE Hershfield numi Solo Spawn 1';
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('Hershfield numi Solo Spawn 1',10,10,2038,2038,'',13,1,0,0,0,0,0
			    ,0,0,0,0,1,0);

PRINT N'INSERT FLOCKS Hershfield numi Solo Spawn 1';
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Hershfield numi Solo Spawn 1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Hershfield numi Solo Spawn 1',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_cameleon_interceptor_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Cam_hersh_solospawn1' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Cam_hersh_solospawn1', @presenceID, 1, @definitionID, 1373, 437, 0, 5, 30, 0, 25, 'Cam_hersh_solospawn1', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_dps_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'yagel_hersh_solospawn1' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('yagel_hersh_solospawn1', @presenceID, 1, @definitionID, 1373, 437, 0, 5, 30, 0, 25, 'yagel_hersh_solospawn1', 1, 1, 1, 1); 


PRINT N'INSERT PRESENCE Hershfield numi Solo Spawn 2';
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('Hershfield numi Solo Spawn 2',10,10,2038,2038,'',13,1,0,0,0,0,0
			    ,0,0,0,0,1,0);
PRINT N'INSERT FLOCKS Hershfield numi Solo Spawn 2';
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Hershfield numi Solo Spawn 2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Hershfield numi Solo Spawn 2',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_dps_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'arby_hersh_solospawn2' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('arby_hersh_solospawn2', @presenceID, 1, @definitionID, 1395, 700, 2, 5, 30, 0, 25, 'arby_hersh_solospawn2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_dps_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'yagel_hersh_solospawn2' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('yagel_hersh_solospawn2', @presenceID, 1, @definitionID, 1395, 700, 2, 5, 30, 0, 25, 'yagel_hersh_solospawn2', 1, 1, 1, 1); 


PRINT N'INSERT PRESENCE Hershfield numi Solo Spawn 3';
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('Hershfield numi Solo Spawn 3',10,10,2038,2038,'',13,1,0,0,0,0,0
			    ,0,0,0,0,1,0);

PRINT N'INSERT FLOCKS Hershfield numi Solo Spawn 3';
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Hershfield numi Solo Spawn 3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Hershfield numi Solo Spawn 3',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_dps_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'kain_hersh_solospawn3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kain_hersh_solospawn3', @presenceID, 1, @definitionID, 1254, 704, 0, 5, 30, 0, 25, 'kain_hersh_solospawn3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vagabond_jammer_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'vagabond_hersh_solospawn3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('vagabond_hersh_solospawn3', @presenceID, 1, @definitionID, 1254, 704, 0, 5, 30, 0, 25, 'vaga_hersh_solospawn3', 1, 1, 1, 1); 


PRINT N'INSERT PRESENCE Hershfield numi Solo Spawn 4';
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('Hershfield numi Solo Spawn 4',10,10,2038,2038,'',13,1,0,0,0,0,0
			    ,0,0,0,0,1,0);

PRINT N'INSERT FLOCKS Hershfield numi Solo Spawn 4';
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Hershfield numi Solo Spawn 4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Hershfield numi Solo Spawn 4',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_hybrid_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mesmer_hersh_solospawn4' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('mesmer_hersh_solospawn4', @presenceID, 2, @definitionID, 1056, 566, 0, 5, 30, 0, 25, 'mesmer_hersh_solospawn4', 1, 1, 1, 1); 

----End Numiquol

--Pelistal
PRINT N'INSERT PRESENCE Hershfield Pelistal Solo Spawn 1';
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('Hershfield Pelistal Solo Spawn 1',10,10,2038,2038,'',13,0,0,0,2,'',''
			    ,'','',180000,0,0,0);

PRINT N'INSERT FLOCKS Hershfield Pelistal Solo Spawn 1';
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Hershfield Pelistal Solo Spawn 1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Hershfield Pelistal Solo Spawn 1',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 0,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 2,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = 180000 ,[isbodypull] = 0,[isrespawnallowed] = 0,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ictus_dps_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Ictus_at_solo1' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Ictus_at_solo1', @presenceID, 1, @definitionID, 1122, 1409, 0, 5, 30, 0, 25, 'Ictus_at_solo1', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_dps_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Tyra_at_solo1' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Tyra_at_solo1', @presenceID, 1, @definitionID, 1122, 1409, 0, 5, 30, 0, 25, 'Tyro_at_solo1', 0, 1, 1, 1); 

PRINT N'Updates on flocks Hershfield Pelistal Solo Spawn 1 -- for some reason';
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Hershfield Pelistal Solo Spawn 1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Hershfield Pelistal Solo Spawn 1',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 0,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = 180000 ,[isbodypull] = 0,[isrespawnallowed] = 0,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ictus_dps_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Ictus_at_solo1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Ictus_at_solo1' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1122, [spawnoriginY] = 1409 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 30, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'Ictus_at_solo1', [respawnmultiplierlow] = 0, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_dps_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Tyra_at_solo1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Tyra_at_solo1' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1122, [spawnoriginY] = 1409 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 30, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'Tyro_at_solo1', [respawnmultiplierlow] = 0, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Hershfield Pelistal Solo Spawn 1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Hershfield Pelistal Solo Spawn 1',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ictus_dps_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Ictus_at_solo1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Ictus_at_solo1' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1122, [spawnoriginY] = 1409 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 30, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'Ictus_at_solo1', [respawnmultiplierlow] = 0, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_dps_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Tyra_at_solo1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Tyra_at_solo1' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1122, [spawnoriginY] = 1409 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 30, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'Tyro_at_solo1', [respawnmultiplierlow] = 0, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;



PRINT N'INSERT PRESENCE Hershfield Pelistal Solo Spawn 2';
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('Hershfield Pelistal Solo Spawn 2',10,10,2038,2038,'',13,0,0,0,2,'',''
			    ,'','',180000,0,0,0);

PRINT N'INSERT FLOCKS Hershfield Pelistal Solo Spawn 2';
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Hershfield Pelistal Solo Spawn 2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Hershfield Pelistal Solo Spawn 2',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_waspish_dps_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Wasp_Pelistal_solo2' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Wasp_Pelistal_solo2', @presenceID, 1, @definitionID, 840, 1621, 0, 5, 30, 0, 25, 'Wasp_Pelistal_solo2', 1, 1, 1, 1); 


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_castel_dps_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'castel_pelistal_solo2' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('castel_pelistal_solo2', @presenceID, 1, @definitionID, 840, 1621, 0, 5, 30, 0, 25, 'castel_pelistal_solo2', 1, 1, 1, 1); 



PRINT N'INSERT PRESENCE Hershfield Pelistal Solo Spawn 3';
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('Hershfield Pelistal Solo Spawn 3',10,10,2038,2038,'',13,0,0,0,0,0,0
			    ,0,0,0,0,1,0);

PRINT N'INSERT FLOCKS Hershfield Pelistal Solo Spawn 3';
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Hershfield Pelistal Solo Spawn 3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Hershfield Pelistal Solo Spawn 3',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_hybrid_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Gropho_Pelistal_Hersh_Solo3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Gropho_Pelistal_Hersh_Solo3', @presenceID, 2, @definitionID, 835, 1513, 0, 5, 30, 0, 25, 'Gropho_Pelistal_Hersh_Solo3', 1, 1, 1, 1); 


PRINT N'INSERT PRESENCE Hershfield Pelistal Solo Spawn 4';
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                 VALUES ('Hershfield Pelistal Solo Spawn 4',10,10,2038,2038,'',13,1,0,0,0,0,0
			    ,0,0,0,0,1,0);

PRINT N'INSERT FLOCKS Hershfield Pelistal Solo Spawn 4';
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Hershfield Pelistal Solo Spawn 4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Hershfield Pelistal Solo Spawn 4',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_troiar_interceptor_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'troiar_hersh_solo4' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('troiar_hersh_solo4', @presenceID, 1, @definitionID, 752, 1578, 0, 5, 30, 0, 25, 'troiar_hersh_solo4', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_castel_dps_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'castel_Hersh_solo4' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('castel_Hersh_solo4', @presenceID, 1, @definitionID, 752, 1578, 0, 5, 30, 0, 25, 'castel_Hersh_solo4', 1, 1, 1, 1); 

-----End Pelistal

--Theolodical


PRINT N'INSERT PRESENCE Hershfield theo Solo Spawn 1';
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('Hershfield theo Solo Spawn 1',10,10,2038,2038,'',13,1,0,0,0,0,0
			    ,0,0,0,0,1,0);


PRINT N'INSERT FLOCKS Hershfield theo Solo Spawn 1';
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Hershfield theo Solo Spawn 1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Hershfield theo Solo Spawn 1',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_intakt_interceptor_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'intakt_Hersh_theo_spawn1' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('intakt_Hersh_theo_spawn1', @presenceID, 1, @definitionID, 642, 881, 0, 5, 30, 0, 25, 'intakt_Hersh_theo_spawn1', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_prometheus_scout_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'prom_Hersh_theo_spawn1' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('prom_Hersh_theo_spawn1', @presenceID, 1, @definitionID, 642, 881, 0, 5, 30, 0, 25, 'prom_Hersh_theo_spawn1', 1, 1, 1, 1); 


PRINT N'INSERT PRESENCE Hershfield theo Solo Spawn 2';
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('Hershfield theo Solo Spawn 2',10,10,2038,2038,'',13,1,0,0,0,0,0
			    ,0,0,0,0,1,0);

PRINT N'INSERT FLOCKS Hershfield theo Solo Spawn 2';
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Hershfield theo Solo Spawn 2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Hershfield theo Solo Spawn 2',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_baphomet_scout_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'baph_hersh_theo_spawn2' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('baph_hersh_theo_spawn2', @presenceID, 1, @definitionID, 702, 768, 0, 5, 30, 0, 25, 'baph_hersh_theo_spawn2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_prometheus_scout_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'prom_Hersh_theo_spawn2' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('prom_Hersh_theo_spawn2', @presenceID, 1, @definitionID, 702, 768, 0, 5, 30, 0, 25, 'prom_Hersh_theo_spawn2', 1, 1, 1, 1); 


PRINT N'INSERT PRESENCE Hershfield theo Solo Spawn 3';
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('Hershfield theo Solo Spawn 3',10,10,2038,2038,'',13,1,0,0,0,0,0
			    ,0,0,0,0,1,0);

PRINT N'INSERT FLOCKS Hershfield theo Solo Spawn 3';
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Hershfield theo Solo Spawn 3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Hershfield theo Solo Spawn 3',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_dps_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'arty_hersh_theo_spawn3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('arty_hersh_theo_spawn3', @presenceID, 1, @definitionID, 754, 459, 0, 5, 30, 0, 25, 'arty_hersh_theo_spawn3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_zenith_dps_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'zenith_hersh_theo_spawn3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('zenith_hersh_theo_spawn3', @presenceID, 1, @definitionID, 754, 459, 0, 5, 30, 0, 25, 'zenith_hersh_theo_spawn3', 1, 1, 1, 1); 


PRINT N'INSERT PRESENCE Hershfield theo Solo Spawn 4';
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('Hershfield theo Solo Spawn 4',10,10,2038,2038,'',13,1,0,0,0,0,0
			    ,0,0,0,0,1,0);

PRINT N'INSERT FLOCKS Hershfield theo Solo Spawn 4';
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Hershfield theo Solo Spawn 4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Hershfield theo Solo Spawn 4',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_hybrid_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'seth_hersh_theo_spawn4' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('seth_hersh_theo_spawn4', @presenceID, 2, @definitionID, 340, 785, 0, 5, 30, 0, 25, 'seth_hersh_theo_spawn4', 1, 1, 1, 1); 


---End Theolodical



GO