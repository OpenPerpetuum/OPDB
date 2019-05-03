USE [perpetuumsa]
GO

-------------------------------------------------
--Beta 2 NPC overhaul
--Inserts a bunch of new presences and flocks
--
--date: 2019/05/02
------------------------------------------------

DECLARE @flockID int;
DECLARE @definitionID int;
DECLARE @presenceID int;

-----B2 Group T3 spawns add for Heavy Mechs and Assault/Light

---Alsbale

PRINT N'Inserting New Presences';

set noexec off;

IF EXISTS (SELECT TOP 1 id from [npcpresence] WHERE [name] = 'presence_flock_ALB_1')
BEGIN
	PRINT N'PRESENCE FOUND! Skipping inserts';
	set noexec on;
END


INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_ALB_1',472,51,672,251,'',15,1,0,0,3,3,572
			    ,151,5,'',1,1,1);


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_ALB_1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_ALB_1',[topx] = 472,[topy] = 51,[bottomx] = 672,[bottomy] = 251,[note] = 'presence_flock_ALB_1',[spawnid] = 15,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_hybrid_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Alb_1_gropht3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Alb_1_gropht3', @presenceID, 3, @definitionID, 1222, 730, 2, 5, 60, 0, 30, 'Alb_1_gropht3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_ew_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'alb_1_tyrot3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('alb_1_tyrot3', @presenceID, 3, @definitionID, 1222, 730, 2, 5, 60, 0, 30, 'alb_1_tyrot3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ictus_dps_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'alb_1_ictust3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('alb_1_ictust3', @presenceID, 3, @definitionID, 1222, 730, 2, 5, 60, 0, 30, 'alb_1_ictust3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'alb_1_seqt3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('alb_1_seqt3', @presenceID, 3, @definitionID, 1222, 730, 2, 5, 60, 0, 30, 'alb_1_seqt3', 1, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_ALB_2',472,51,672,251,'presence_flock_ALB_2',15,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_ALB_2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_ALB_2',[topx] = 472,[topy] = 51,[bottomx] = 672,[bottomy] = 251,[note] = 'presence_flock_ALB_2',[spawnid] = 15,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_waspish_interceptor_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'alb_2_waspt3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('alb_2_waspt3', @presenceID, 3, @definitionID, 1300, 960, 2, 5, 60, 0, 30, 'alb_2_waspt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_troiar_interceptor_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'alb_2_troiart3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('alb_2_troiart3', @presenceID, 3, @definitionID, 1300, 960, 2, 5, 60, 0, 30, 'alb_2_troiart3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_castel_interceptor_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'alb_2_castelt3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('alb_2_castelt3', @presenceID, 3, @definitionID, 1300, 960, 2, 5, 60, 0, 30, 'alb_2_castelt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'alb_2_seqt3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('alb_2_seqt3', @presenceID, 3, @definitionID, 1300, 960, 2, 5, 60, 0, 30, 'alb_2_seqt3', 1, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_ALB_3',472,51,672,251,'presence_flock_ALB_3',15,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_ALB_3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_ALB_3',[topx] = 472,[topy] = 51,[bottomx] = 672,[bottomy] = 251,[note] = 'presence_flock_ALB_3',[spawnid] = 15,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_hybrid_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'alb_3_gropht3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('alb_3_gropht3', @presenceID, 3, @definitionID, 980, 1570, 2, 5, 60, 0, 30, 'alb_3_gropht3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_ew_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'alb_3_tyrot3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('alb_3_tyrot3', @presenceID, 3, @definitionID, 980, 1570, 2, 5, 60, 0, 30, 'alb_3_tyrot3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ictus_dps_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'alb_3_ictust3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('alb_3_ictust3', @presenceID, 3, @definitionID, 980, 1570, 2, 5, 60, 0, 30, 'alb_3_ictust3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'alb_3_seqt3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('alb_3_seqt3', @presenceID, 3, @definitionID, 980, 1570, 2, 5, 60, 0, 30, 'alb_3_seqt3', 1, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_ALB_4',472,51,672,251,'presence_flock_ALB_4',15,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_ALB_4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_ALB_4',[topx] = 472,[topy] = 51,[bottomx] = 672,[bottomy] = 251,[note] = 'presence_flock_ALB_4',[spawnid] = 15,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_waspish_scout_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'alb_4_waspt3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('alb_4_waspt3', @presenceID, 3, @definitionID, 430, 1560, 2, 5, 60, 0, 30, 'alb_4_waspt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_troiar_interceptor_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'alb_4_troiart3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('alb_4_troiart3', @presenceID, 3, @definitionID, 430, 1560, 2, 5, 60, 0, 30, 'alb_4_troiart3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_castel_scout_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'alb_4_castelt3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('alb_4_castelt3', @presenceID, 3, @definitionID, 430, 1560, 2, 5, 60, 0, 30, 'alb_4_castelt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'alb_4_sequert3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('alb_4_sequert3', @presenceID, 3, @definitionID, 430, 1560, 2, 5, 60, 0, 30, 'alb_4_sequert3', 1, 1, 1, 1); 


----Nova


INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_Nova_1',1340,313,1540,513,'presence_flock_Nova_1',16,1,0,0,3,3,1440
			    ,413,5,'',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_Nova_1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_Nova_1',[topx] = 1340,[topy] = 313,[bottomx] = 1540,[bottomy] = 513,[note] = 'presence_flock_Nova_1',[spawnid] = 16,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 3,[randomcenterx] = 1440,[randomcentery] = 413
                ,[randomradius] = 5,[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_hybrid_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'nova_1_mesmert3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nova_1_mesmert3', @presenceID, 3, @definitionID, 1025, 800, 2, 5, 60, 0, 30, 'nova_1_mesmert3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_ew_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'nova_1_kaint3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nova_1_kaint3', @presenceID, 3, @definitionID, 1025, 800, 2, 5, 60, 0, 30, 'nova_1_kaint3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vagabond_dps_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'nova_1_vagabondt3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nova_1_vagabondt3', @presenceID, 3, @definitionID, 1025, 800, 2, 5, 60, 0, 30, 'nova_1_vagabondt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'nova_1_sequert3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nova_1_sequert3', @presenceID, 3, @definitionID, 1025, 800, 2, 5, 60, 0, 30, 'nova_1_sequert3', 1, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_Nova_2',1340,313,1540,513,'presence_flock_Nova_2',16,1,0,0,0,3,1440
			    ,413,5,'',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_Nova_2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_Nova_2',[topx] = 1340,[topy] = 313,[bottomx] = 1540,[bottomy] = 513,[note] = 'presence_flock_Nova_2',[spawnid] = 16,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 3,[randomcenterx] = 1440,[randomcentery] = 413
                ,[randomradius] = 5,[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_scout_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'nova_2_arbyt3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nova_2_arbyt3', @presenceID, 3, @definitionID, 555, 1240, 2, 5, 60, 0, 30, 'nova_2_arbyt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_cameleon_interceptor_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'nova_2_camt3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nova_2_camt3', @presenceID, 3, @definitionID, 555, 1240, 2, 5, 60, 0, 30, 'nova_2_camt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_interceptor_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Nova_2_yagelt3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Nova_2_yagelt3', @presenceID, 3, @definitionID, 555, 1240, 2, 5, 60, 0, 30, 'Nova_2_yagelt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'nova_2_sequert3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nova_2_sequert3', @presenceID, 3, @definitionID, 555, 1240, 2, 5, 60, 0, 30, 'nova_2_sequert3', 1, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_Nova_3',1340,313,1540,513,'presence_flock_Nova_3',16,1,0,0,0,3,1440
			    ,413,5,'',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_Nova_3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_Nova_3',[topx] = 1340,[topy] = 313,[bottomx] = 1540,[bottomy] = 513,[note] = 'presence_flock_Nova_3',[spawnid] = 16,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 3,[randomcenterx] = 1440,[randomcentery] = 413
                ,[randomradius] = 5,[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_hybrid_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'nova_3_mesmert3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nova_3_mesmert3', @presenceID, 3, @definitionID, 1830, 915, 2, 5, 60, 0, 30, 'nova_3_mesmert3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_ew_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'nova_3_kaint3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nova_3_kaint3', @presenceID, 3, @definitionID, 864, 962, 2, 5, 60, 0, 30, 'nova_3_kaint3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vagabond_dps_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'nova_3_vagabondt3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nova_3_vagabondt3', @presenceID, 3, @definitionID, 864, 962, 2, 5, 60, 0, 30, 'nova_3_vagabondt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Nova_3_sequert3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Nova_3_sequert3', @presenceID, 3, @definitionID, 864, 962, 2, 5, 60, 0, 30, 'Nova_3_sequert3', 1, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_Nova_4',1340,313,1540,513,'presence_flock_Nova_4',16,1,0,0,0,3,1440
			    ,413,5,'',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_Nova_4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_Nova_4',[topx] = 1340,[topy] = 313,[bottomx] = 1540,[bottomy] = 513,[note] = 'presence_flock_Nova_4',[spawnid] = 16,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 3,[randomcenterx] = 1440,[randomcentery] = 413
                ,[randomradius] = 5,[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_scout_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'nova_4_arbyt3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nova_4_arbyt3', @presenceID, 3, @definitionID, 1560, 900, 2, 5, 60, 0, 30, 'nova_4_arbyt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_cameleon_interceptor_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'nova_4_camt3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nova_4_camt3', @presenceID, 3, @definitionID, 1560, 900, 2, 5, 60, 0, 30, 'nova_4_camt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_scout_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'nova_4_yagelt3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nova_4_yagelt3', @presenceID, 3, @definitionID, 1560, 900, 2, 5, 60, 0, 30, 'nova_4_yagelt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'nova_4_seqt3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nova_4_seqt3', @presenceID, 3, @definitionID, 1560, 900, 2, 5, 60, 0, 30, 'nova_4_seqt3', 1, 1, 1, 1); 


---Kentagura

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('Presence_flock_Kent1',464,867,664,1067,'Presence_flock_Kent1',14,1,0,0,0,0,0
			    ,0,0,0,0,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Presence_flock_Kent1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Presence_flock_Kent1',[topx] = 464,[topy] = 867,[bottomx] = 664,[bottomy] = 1067,[note] = 'Presence_flock_Kent1',[spawnid] = 14,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_hybrid_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Kent_1_setht3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kent_1_setht3', @presenceID, 3, @definitionID, 773, 350, 2, 5, 60, 0, 30, 'Kent_1_setht3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_ew_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Kent_1_artyt3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kent_1_artyt3', @presenceID, 3, @definitionID, 773, 350, 2, 5, 60, 0, 30, 'Kent_1_artyt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_zenith_dps_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Kent_1_zanitht3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kent_1_zanitht3', @presenceID, 3, @definitionID, 773, 350, 2, 5, 60, 0, 30, 'Kent_1_zanitht3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Kent_1_sequert3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kent_1_sequert3', @presenceID, 3, @definitionID, 773, 350, 2, 5, 60, 0, 30, 'Kent_1_sequert3', 1, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('Presence_flock_Kent_2',464,867,664,1067,'Presence_flock_Kent_2',14,1,0,0,0,0,0
			    ,0,0,0,0,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Presence_flock_Kent_2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Presence_flock_Kent_2',[topx] = 464,[topy] = 867,[bottomx] = 664,[bottomy] = 1067,[note] = 'Presence_flock_Kent_2',[spawnid] = 14,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_baphomet_scout_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'kent_2_bapht3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kent_2_bapht3', @presenceID, 3, @definitionID, 1190, 570, 2, 5, 60, 0, 30, 'kent_2_bapht3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_intakt_interceptor_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Kent_2_intaktt3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kent_2_intaktt3', @presenceID, 3, @definitionID, 1190, 570, 2, 5, 60, 0, 30, 'Kent_2_intaktt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_prometheus_scout_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Kent_2_promt3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kent_2_promt3', @presenceID, 3, @definitionID, 1190, 570, 2, 5, 60, 0, 30, 'Kent_2_promt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Kent_2_sequert3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kent_2_sequert3', @presenceID, 3, @definitionID, 1190, 570, 2, 5, 60, 0, 30, 'Kent_2_sequert3', 1, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('Presence_flock_Kent_3',464,867,664,1067,'Presence_flock_Kent_3',14,1,0,0,0,0,0
			    ,0,0,0,0,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Presence_flock_Kent_3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Presence_flock_Kent_3',[topx] = 464,[topy] = 867,[bottomx] = 664,[bottomy] = 1067,[note] = 'Presence_flock_Kent_3',[spawnid] = 14,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_hybrid_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Kent_3_setht3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kent_3_setht3', @presenceID, 3, @definitionID, 430, 860, 2, 5, 60, 0, 30, 'Kent_3_setht3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_ew_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Kent_3_artyt3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kent_3_artyt3', @presenceID, 3, @definitionID, 430, 860, 2, 5, 60, 0, 30, 'Kent_3_artyt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_zenith_dps_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Kent_3_zenitht3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kent_3_zenitht3', @presenceID, 3, @definitionID, 430, 860, 2, 5, 60, 0, 30, 'Kent_3_zenitht3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Kent_3_sequert3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kent_3_sequert3', @presenceID, 3, @definitionID, 430, 860, 2, 5, 60, 0, 30, 'Kent_3_sequert3', 1, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('Presence_flock_Kent_4',464,867,664,1067,'Presence_flock_Kent_4',14,1,0,0,0,0,0
			    ,0,0,0,0,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Presence_flock_Kent_4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Presence_flock_Kent_4',[topx] = 464,[topy] = 867,[bottomx] = 664,[bottomy] = 1067,[note] = 'Presence_flock_Kent_4',[spawnid] = 14,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_baphomet_scout_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'kent_4_bapht3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kent_4_bapht3', @presenceID, 3, @definitionID, 270, 840, 2, 5, 60, 0, 30, 'kent_4_bapht3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_intakt_interceptor_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'kent_4_intaktt3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kent_4_intaktt3', @presenceID, 3, @definitionID, 270, 840, 2, 5, 60, 0, 30, 'kent_4_intaktt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_prometheus_scout_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Kent_4_promt3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kent_4_promt3', @presenceID, 3, @definitionID, 270, 840, 2, 5, 60, 0, 30, 'Kent_4_promt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Kent_4_seqt3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kent_4_seqt3', @presenceID, 3, @definitionID, 270, 840, 2, 5, 60, 0, 30, 'Kent_4_seqt3', 1, 1, 1, 1); 



set noexec off;
PRINT N'COMPLETE WITH BETA2 NPC INSERTS';
GO






