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