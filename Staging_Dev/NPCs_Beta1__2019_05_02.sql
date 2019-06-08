USE [perpetuumsa]
GO

-------------------------------------------------
--Beta 1 NPC overhaul
--Sets all old npcpresences to disabled
--Inserts a bunch of new ones
--
--date: 2019/05/02
------------------------------------------------

set noexec off;
PRINT N'Disable existing old-presences';
IF 1=(SELECT TOP 1 enabled FROM npcpresence WHERE name='ics_real_presence')
BEGIN
	UPDATE npcpresence
	SET [enabled] = 0 
	WHERE npcpresence.spawnid  = (SELECT TOP 1 id from npcspawn WHERE id = (SELECT TOP 1 spawnid FROM zones WHERE note='domhalarn' AND name='zone_ICS_A_real'));
END

IF 1=(SELECT TOP 1 enabled FROM npcpresence WHERE name='asi_real_presence')
BEGIN
	UPDATE npcpresence
	SET [enabled] = 0 
	WHERE npcpresence.spawnid  = (SELECT TOP 1 id from npcspawn WHERE id = (SELECT TOP 1 spawnid FROM zones WHERE note='hokkogaros' AND name='zone_ASI_A_real'));
END

IF 1=(SELECT TOP 1 enabled FROM npcpresence WHERE name='tm_real_presence')
BEGIN
	UPDATE npcpresence
	SET [enabled] = 0 
	WHERE npcpresence.spawnid  = (SELECT TOP 1 id from npcspawn WHERE id = (SELECT TOP 1 spawnid FROM zones WHERE note='norhoop' AND name='zone_TM_A_real'));
END


PRINT N'Inserting New Presences';

set noexec off;

IF EXISTS (SELECT TOP 1 id from [npcpresence] WHERE [name] = 'presence_flock_hok_nauwy_1')
BEGIN
	PRINT N'PRESENCE FOUND! Skipping inserts';
	set noexec on;
END

DECLARE @presenceID int;
DECLARE @flockID int;
DECLARE @definitionID int;

----Nauwy outpost NPCs


INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_nauwy_1',569,244,769,444,'',8,0,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_nauwy_1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_nauwy_1',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'Nauwy 1',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_hybrid_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Seth_nauwy_1', @presenceID, 3, @definitionID, 838, 310, 0, 5, 60, 0, 25, 'Seth_nauwy_1', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_dps_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('artemis_nauwy_1', @presenceID, 3, @definitionID, 838, 310, 0, 5, 60, 0, 25, 'artemis_nauwy_1', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_zenith_dps_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('zenith_nauwy_1', @presenceID, 3, @definitionID, 838, 310, 0, 5, 60, 0, 25, 'Zenith_nauwy_1', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('sequer_nauwy_1', @presenceID, 3, @definitionID, 838, 310, 0, 5, 60, 0, 25, 'sequer_nauwy_1', 0, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_nauwy_2',569,244,769,444,'Nauwy 1',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_nauwy_2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_nauwy_2',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'Nauwy 2',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_baphomet_dps_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('baph_nauwy_2', @presenceID, 3, @definitionID, 1205, 415, 2, 5, 60, 0, 25, 'Baph_nauwy_2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_prometheus_scout_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('prometheus_nauwy_2', @presenceID, 3, @definitionID, 1205, 415, 2, 5, 60, 0, 25, 'Prometheus_nauwy_2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_intakt_interceptor_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('intakt_nauwy_2', @presenceID, 3, @definitionID, 1205, 415, 2, 5, 60, 0, 25, 'Intakt_nauwy_2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('sequer_nauwy_2', @presenceID, 3, @definitionID, 1205, 415, 2, 5, 60, 0, 25, 'Sequer_nauwy_2', 1, 1, 1, 1); 


INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_nauwy_3',569,244,769,444,'Nauwy 3',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_nauwy_3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_nauwy_3',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'Nauwy 3',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_baphomet_scout_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Baph_nauwy_3', @presenceID, 2, @definitionID, 1160, 278, 2, 5, 60, 0, 25, 'Baph_nauwy_3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_prometheus_scout_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('prom_nauwy_3', @presenceID, 2, @definitionID, 1160, 278, 2, 5, 60, 0, 25, 'Prom_nauwy_3', 1, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_nauwy_4',569,244,769,444,'Nauwy 4',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_nauwy_4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_nauwy_4',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'Nauwy 4',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_hybrid_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('seth_nauwy_4', @presenceID, 2, @definitionID, 911, 257, 2, 5, 60, 0, 25, 'Seth_nauwy_4', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_dps_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('artemis_nauwy_4', @presenceID, 2, @definitionID, 911, 257, 2, 5, 60, 0, 25, 'Artemis_nauwy_4', 1, 1, 1, 1); 

---Abbu NPCs

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_Abbu_1',569,244,769,444,'Abbu 1',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_Abbu_1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_Abbu_1',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'Abbu 1',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_hybrid_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('seth_abbu_1', @presenceID, 3, @definitionID, 1157, 780, 2, 5, 60, 0, 25, 'seth_abbu_1', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_dps_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('artemis_abbu_1', @presenceID, 3, @definitionID, 1157, 780, 2, 5, 60, 0, 25, 'artemis_abbu_1', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_zenith_dps_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Zenith_abbu_1', @presenceID, 3, @definitionID, 1157, 780, 2, 5, 60, 0, 25, 'Zenith_abbu_1', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Sequer_abbu_1', @presenceID, 3, @definitionID, 1157, 780, 2, 5, 60, 0, 25, 'Sequer_abbu_1', 0, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_Abbu_2',569,244,769,444,'Abbu 2',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_Abbu_2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_Abbu_2',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'Abbu 2',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_baphomet_scout_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Baph_abbu_2', @presenceID, 3, @definitionID, 986, 858, 2, 5, 60, 0, 25, 'Baph_abbu_2', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_prometheus_scout_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Prometheus_abbu_2', @presenceID, 3, @definitionID, 986, 858, 2, 5, 60, 0, 25, 'Prometheus_abbu_2', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_intakt_interceptor_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('intakt_abbu_2', @presenceID, 3, @definitionID, 986, 858, 2, 5, 60, 0, 25, 'intakt_abbu_2', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('sequer_abbu_2', @presenceID, 3, @definitionID, 986, 858, 2, 5, 60, 0, 25, 'sequer_abbu_2', 0, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_Abbu_3',569,244,769,444,'Abbu 3',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_Abbu_3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_Abbu_3',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'Abbu 3',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_hybrid_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('seth_abbu_3', @presenceID, 2, @definitionID, 1107, 1065, 2, 5, 60, 0, 25, 'seth_abbu_3', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_dps_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('artemis_abbu_3', @presenceID, 2, @definitionID, 1107, 1065, 2, 5, 60, 0, 25, 'artemis_abbu_3', 0, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_Abbu_4',569,244,769,444,'Abbu 4',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_Abbu_4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_Abbu_4',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'Abbu 4',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_prometheus_scout_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Promethus_Abbu_4', @presenceID, 2, @definitionID, 1415, 818, 2, 5, 60, 0, 25, 'Promethus_abbu_4', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_baphomet_scout_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Baphomet_Abbu_4', @presenceID, 2, @definitionID, 1415, 818, 2, 5, 60, 0, 25, 'Baphomet_abbu_4', 0, 1, 1, 1); 

----Darm NPCs

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_Darm_1',569,244,769,444,'Darm_1',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_Darm_1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_Darm_1',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'Darm_1',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_hybrid_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('seth_darm_1', @presenceID, 3, @definitionID, 464, 1072, 2, 5, 60, 0, 25, 'seth_darm_1', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_dps_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('artemis_darm_1', @presenceID, 3, @definitionID, 464, 1072, 2, 5, 60, 0, 25, 'artemis_darm_1', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_zenith_dps_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Zenith_darm_1', @presenceID, 3, @definitionID, 464, 1072, 2, 5, 60, 0, 25, 'zenith_darm_1', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('sequer_darm_1', @presenceID, 3, @definitionID, 464, 1072, 2, 5, 60, 0, 25, 'sequer_darm_1', 0, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_Darm_2',569,244,769,444,'Darm_2',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_Darm_2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_Darm_2',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'Darm_2',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_baphomet_scout_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('baph_Darm_2', @presenceID, 3, @definitionID, 635, 1076, 2, 5, 60, 0, 25, 'baph_Darm_2', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_prometheus_scout_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('prom_Darm_2', @presenceID, 3, @definitionID, 635, 1076, 2, 5, 60, 0, 25, 'Prom_darm_2', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_intakt_interceptor_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('intakt_Darm_2', @presenceID, 3, @definitionID, 635, 1076, 2, 5, 60, 0, 25, 'intakt_darm_2', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Sequer_Darm_2', @presenceID, 3, @definitionID, 635, 1076, 2, 5, 60, 0, 25, 'sequer_darm_2', 0, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_Darm_3',569,244,769,444,'Darm_3',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_Darm_3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_Darm_3',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'Darm_3',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_hybrid_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('seth_Darm_3', @presenceID, 2, @definitionID, 693, 1385, 2, 5, 60, 0, 25, 'seth_darm_3', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_dps_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('artemis_darm_3', @presenceID, 2, @definitionID, 693, 1385, 2, 5, 60, 0, 25, 'artemis_darm_3', 0, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_Darm_4',569,244,769,444,'Darm_4',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_Darm_4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_Darm_4',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'Darm_4',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_baphomet_scout_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Baph_Darm_4', @presenceID, 2, @definitionID, 499, 1346, 2, 5, 60, 0, 25, 'Baph_Darm_4', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_prometheus_scout_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('prom_Darm_4', @presenceID, 2, @definitionID, 499, 1346, 2, 5, 60, 0, 25, 'Prom_Darm_4', 0, 1, 1, 1); 

----Beta Terminal

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_BetaTerminal_1',569,244,769,444,'BetaTerminal_1',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_BetaTerminal_1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_BetaTerminal_1',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'BetaTerminal_1',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_hybrid_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Mesmer_BT_1', @presenceID, 2, @definitionID, 630, 400, 2, 5, 60, 0, 25, 'Mesmer_BT_1', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_dps_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kain_BT_1', @presenceID, 2, @definitionID, 630, 400, 2, 5, 60, 0, 25, 'Kain_BT_1', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vagabond_dps_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Vagabond_BT_1', @presenceID, 2, @definitionID, 630, 400, 2, 5, 60, 0, 25, 'Vagabond_BT_1', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Sequer_BT_1', @presenceID, 2, @definitionID, 630, 400, 2, 5, 60, 0, 25, 'Sequer_BT_1', 0, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_BetaTerminal_2_Blue',569,244,769,444,'BetaTerminal_2',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_BetaTerminal_2_Blue' ORDER BY id DESC)

UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_BetaTerminal_2_Blue',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'BetaTerminal_2_Blue',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_scout_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('arbalest_BT2Blue', @presenceID, 2, @definitionID, 725, 610, 2, 5, 60, 0, 25, 'arbalest_BT2Blue', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_interceptor_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('yagel_BT2Blue', @presenceID, 2, @definitionID, 725, 610, 2, 5, 60, 0, 25, 'yagel_BT2Blue', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_cameleon_interceptor_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Cameleon_BT2Blue', @presenceID, 2, @definitionID, 725, 610, 2, 5, 60, 0, 25, 'Cameleon_BT2Blue', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Sequer_BT2Bluex', @presenceID, 2, @definitionID, 725, 610, 2, 5, 60, 0, 25, 'Sequer_BT2Blue', 0, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_BetaTerminal_3_blue',569,244,769,444,'BetaTerminal_3_blue',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_BetaTerminal_3_blue' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_BetaTerminal_3_blue',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'BetaTerminal_3_blue',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_dps_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kain_BT3_blue', @presenceID, 2, @definitionID, 840, 450, 2, 5, 60, 0, 25, 'kain_BT3_blue', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_scout_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('yagel_BT3_blue', @presenceID, 2, @definitionID, 840, 450, 2, 5, 60, 0, 25, 'yagel_BT3_blue', 0, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_BetaTerminal_1_green',569,244,769,444,'BetaTerminal_1_green',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_BetaTerminal_1_green' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_BetaTerminal_1_green',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'BetaTerminal_1_green',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_hybrid_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('gropho_BTG1', @presenceID, 2, @definitionID, 565, 460, 2, 5, 60, 0, 25, 'gropho_BTG1', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_dps_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('tyrannos_BTG1', @presenceID, 2, @definitionID, 565, 460, 2, 5, 60, 0, 25, 'Tyrannos_BTG1', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ictus_dps_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('ictus_BTG1', @presenceID, 2, @definitionID, 565, 460, 2, 5, 60, 0, 25, 'ictus_BTG1', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('sequer_BTG1', @presenceID, 2, @definitionID, 565, 460, 2, 5, 60, 0, 25, 'sequer_BTG1', 0, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_BetaTerminal_2_green',569,244,769,444,'BetaTerminal_2_green',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_BetaTerminal_2_green' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_BetaTerminal_2_green',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'BetaTerminal_2_green',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_waspish_scout_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('waspish_BT2G', @presenceID, 2, @definitionID, 630, 665, 2, 5, 60, 0, 25, 'waspish_BT2G', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_castel_interceptor_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Castel_BT2G', @presenceID, 2, @definitionID, 630, 665, 2, 5, 60, 0, 25, 'Castel_BT2G', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_troiar_interceptor_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Troiar_BT2G', @presenceID, 2, @definitionID, 630, 665, 2, 5, 60, 0, 25, 'Troiar_BT2G', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Sequer_BT2G', @presenceID, 2, @definitionID, 630, 665, 2, 5, 60, 0, 25, 'Sequer_BT2G', 0, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_BetaTerminal_3_green',569,244,769,444,'BetaTerminal_3_green',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_BetaTerminal_3_green' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_BetaTerminal_3_green',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'BetaTerminal_3_green',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_castel_scout_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('castel_BT3G', @presenceID, 2, @definitionID, 915, 575, 2, 5, 60, 0, 25, 'castel_BT3G', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_dps_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Tyrannos_BT3G', @presenceID, 2, @definitionID, 915, 575, 2, 5, 60, 0, 25, 'Tyrannos_BT3G', 0, 1, 1, 1); 

-----Hitech Group Spawn

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_Hitech',569,244,769,444,'hokk_hitech',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_Hitech' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_Hitech',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'hokk_hitech',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_hybrid_rank5' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('seth_hitech_1', @presenceID, 3, @definitionID, 210, 1675, 2, 5, 60, 0, 25, 'seth_hitech_1', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_dps_rank5' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('artemis_hitech_1', @presenceID, 3, @definitionID, 210, 1675, 2, 5, 60, 0, 25, 'artemis_hitech_1', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_zenith_dps_rank5' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('zenith_hitech_1', @presenceID, 3, @definitionID, 210, 1675, 2, 5, 60, 0, 25, 'zenith_hitech_1', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank5' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('sequer_hitech_1', @presenceID, 3, @definitionID, 210, 1675, 2, 5, 60, 0, 25, 'sequer_hitech_1', 0, 1, 1, 1); 

-----Indy T3

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_IndyT3',569,244,769,444,'hokk_IndyT3',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_IndyT3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_IndyT3',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'hokk_IndyT3',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_riveler_basic_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Riveler_hokk_indyT3', @presenceID, 3, @definitionID, 1170, 1450, 2, 5, 60, 0, 25, 'Riveler_hokk_indyT3', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_symbiont_basic_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Symb_hokk_indyT3', @presenceID, 3, @definitionID, 1170, 1450, 2, 5, 60, 0, 25, 'Symb_hokk_indyT3', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_lithus_basic_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Lithus_hokk_indyT3', @presenceID, 3, @definitionID, 1170, 1450, 2, 5, 60, 0, 25, 'Lithus_hokk_indyT3', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Scarab_hokk_indyT3', @presenceID, 3, @definitionID, 1170, 1450, 2, 5, 60, 0, 25, 'Scarab_hokk_indyT3', 0, 1, 1, 1); 

----Indy T5

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_IndyT5',569,244,769,444,'hokk_IndyT5',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_IndyT5' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_IndyT5',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'hokk_IndyT5',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('scarab_hokk_T5G', @presenceID, 3, @definitionID, 1880, 1610, 2, 5, 60, 0, 25, 'scarab_hokk_T5G', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_riveler_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Riveler_hokk_T5G', @presenceID, 3, @definitionID, 1880, 1610, 2, 5, 60, 0, 25, 'Riveler_hokk_T5G', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_symbiont_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Symbiont_hokk_T5G', @presenceID, 3, @definitionID, 1880, 1610, 2, 5, 60, 0, 25, 'Symbiont_hokk_T5G', 1, 1, 1, 1); 


---T3 Solo Indy

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_SoloIndyT3',569,244,769,444,'hokk_IndyT5',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_SoloIndyT3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_SoloIndyT3',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'hokk_soloIndyT3',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('scarab_hokk_T3S', @presenceID, 1, @definitionID, 1415, 1180, 2, 5, 60, 0, 25, 'scarab_hokk_t3s', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_symbiont_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Symb_hokk_T3S', @presenceID, 1, @definitionID, 1415, 1180, 2, 5, 60, 0, 25, 'symb_hokk_t3s', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_riveler_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Riveler_hokk_T3S', @presenceID, 1, @definitionID, 1415, 1180, 2, 5, 60, 0, 25, 'riveler_hokk_t3s', 1, 1, 1, 1); 


---T5 Solo Indy

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_SoloIndyT5',569,244,769,444,'hokk_soloIndyT5',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_SoloIndyT5' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_SoloIndyT5',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'hokk_soloIndyT5',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('scarab_hokk_T5S', @presenceID, 1, @definitionID, 995, 1310, 2, 5, 60, 0, 25, 'scarab_hokk_t5s', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_riveler_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Riveler_hokk_T5S', @presenceID, 1, @definitionID, 995, 1310, 2, 5, 60, 0, 25, 'Riveler_hokk_t5s', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_symbiont_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Symb_hokk_T5S', @presenceID, 1, @definitionID, 995, 1310, 2, 5, 60, 0, 25, 'Symb_hokk_T5s', 1, 1, 1, 1); 

---Hokk Money Spawn

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_MoneySpawn',569,244,769,444,'hokk_Moneyspawn',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_MoneySpawn' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_MoneySpawn',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'hokk_Moneyspawn',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Leg_hokk_MST3', @presenceID, 2, @definitionID, 1689, 1341, 2, 5, 60, 0, 25, 'Leg_hokk_MST3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank4' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Leg_hokk_MST4', @presenceID, 2, @definitionID, 1689, 1341, 2, 5, 60, 0, 25, 'Leg_hokk_MST4', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_callisto_buccaneer_rank4' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Callisto_hokk_MST4', @presenceID, 2, @definitionID, 1689, 1341, 2, 5, 60, 0, 25, 'Callisto_hokk_MST4', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ikarus_abstrans_rank4' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('ikarus_hokk_MST4', @presenceID, 2, @definitionID, 1689, 1341, 2, 5, 60, 0, 25, 'Ikarus_hokk_MST4', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank4' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('echelon_hokk_MST4', @presenceID, 2, @definitionID, 1689, 1341, 2, 5, 60, 0, 25, 'echelon_hokk_MST4', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('echelon_hokk_MST3', @presenceID, 2, @definitionID, 1689, 1341, 2, 5, 60, 0, 25, 'echelon_hokk_MST3', 1, 1, 1, 1); 

---- Solo T5 Mech/HM

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_soloT5MHM',569,244,769,444,'hokk_soloT5MHM',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_soloT5MHM' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_soloT5MHM',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'hokk_soloT5MHM',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_hybrid_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('seth_hokk_soloT5MHM', @presenceID, 2, @definitionID, 630, 1075, 2, 5, 60, 0, 25, 'seth_hokk_soloT5MHM', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_zenith_dps_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Zenith_hokk_soloT5MHM', @presenceID, 3, @definitionID, 630, 1075, 2, 5, 60, 0, 25, 'Zenith_hokk_soloT5MHM', 1, 1, 1, 1); 

------ Solo T5 Ass/Light

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_soloT5AL',569,244,769,444,'hokk_soloT5AL',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_soloT5AL' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_soloT5AL',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'hokk_soloT5AL',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_baphomet_scout_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('baph_hokk_soloT5AL', @presenceID, 2, @definitionID, 1672, 718, 2, 5, 60, 0, 25, 'baph_hokk_solo_t5al', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_intakt_interceptor_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('intakt_hokk_soloT5AL', @presenceID, 3, @definitionID, 1672, 718, 2, 5, 60, 0, 25, 'intakt_hokk_solo_T5AL', 1, 1, 1, 1); 

----- Lithus

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_Lithus',569,244,769,444,'hokk_Lithus',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_Lithus' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_Lithus',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'hokk_Lithus',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_lithus_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('lithus_Hokk_T3', @presenceID, 3, @definitionID, 1155, 1675, 2, 5, 60, 0, 25, 'lithus_hokk_T3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_lithus_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('lithus_Hokk_T5', @presenceID, 3, @definitionID, 1155, 1675, 2, 5, 60, 0, 25, 'lithus_hokk_T5', 1, 1, 1, 1); 

------Norhoop

----initia_1
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_initia_1',1637,1391,1837,1591,'presence_flock_nor_initia_1',7,0,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_initia_1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_initia_1',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_initia_1',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_hybrid_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('initia_1_grophoT3', @presenceID, 3, @definitionID, 550, 750, 2, 5, 60, 0, 25, 'initia_1_grophoT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_ew_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('initia_1_tyroT3', @presenceID, 3, @definitionID, 550, 750, 2, 5, 60, 0, 25, 'initia_1_tyroT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ictus_dps_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('initia_1_ictusT3', @presenceID, 3, @definitionID, 550, 750, 2, 5, 60, 0, 25, 'initia_1_ictusT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('initia_1_sequerT3', @presenceID, 3, @definitionID, 550, 750, 2, 5, 60, 0, 25, 'initia_1_sequerT3', 1, 1, 1, 1); 

----initia_2

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_initia_2',1637,1391,1837,1591,'presence_flock_nor_initia_2',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_initia_2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_initia_2',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_initia_2',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_waspish_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('initia_2_waspT3', @presenceID, 3, @definitionID, 670, 995, 2, 5, 60, 0, 25, 'initia_2_waspT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_castel_scout_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('initia_2_castelT3', @presenceID, 3, @definitionID, 670, 995, 2, 5, 60, 0, 25, 'initia_2_castelT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_troiar_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('initia_2_troiarT3', @presenceID, 3, @definitionID, 670, 995, 2, 5, 60, 0, 25, 'initia_2_troiarT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('initia_2_sequerT3', @presenceID, 3, @definitionID, 670, 995, 2, 5, 60, 0, 25, 'initia_2_sequerT3', 1, 1, 1, 1); 

-----initia_3

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_initia_3',1637,1391,1837,1591,'presence_flock_nor_initia_3',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_initia_3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_initia_3',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_initia_3',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_waspish_scout_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('initia_3_waspT3', @presenceID, 2, @definitionID, 333, 856, 2, 5, 60, 0, 25, 'initia_3_waspT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_castel_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('initia_3_castelT3', @presenceID, 2, @definitionID, 333, 856, 2, 5, 60, 0, 25, 'initia_3_castelT3', 1, 1, 1, 1); 

----initia_4

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_initia_4',1637,1391,1837,1591,'presence_flock_nor_initia_4',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_initia_4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_initia_4',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_initia_4',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_dps_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('initia_4_tyroT3', @presenceID, 2, @definitionID, 550, 1115, 2, 5, 60, 0, 25, 'initia_4_tyroT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_hybrid_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('initia_4_grophoT3', @presenceID, 2, @definitionID, 550, 1115, 2, 5, 60, 0, 25, 'initia_4_grophoT3', 1, 1, 1, 1); 

---Kara_1

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_kara_1',1637,1391,1837,1591,'presence_flock_nor_kara_1',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_kara_1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_kara_1',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_kara_1',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_hybrid_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kara_1_grophoT3', @presenceID, 3, @definitionID, 1254, 580, 2, 5, 60, 0, 25, 'kara_1_grophoT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_ew_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kara_1_tyroT3', @presenceID, 3, @definitionID, 1254, 580, 2, 5, 60, 0, 25, 'Kara_1_tyroT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ictus_dps_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kara_1_ictusT3', @presenceID, 3, @definitionID, 1254, 580, 2, 5, 60, 0, 25, 'Kara_1_ictusT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kara_1_sequerT3', @presenceID, 3, @definitionID, 1254, 580, 2, 5, 60, 0, 25, 'Kara_1_sequerT3', 1, 1, 1, 1); 

				---Kara_2

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_kara_2',1637,1391,1837,1591,'presence_flock_nor_kara_2',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_kara_2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_kara_2',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_kara_2',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_waspish_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kara_2_waspishT3', @presenceID, 3, @definitionID, 1365, 695, 2, 5, 60, 0, 25, 'Kara_2_waspishT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_troiar_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kara_2_troiarT3', @presenceID, 3, @definitionID, 1365, 695, 2, 5, 60, 0, 25, 'Kara_2_troiarT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_castel_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kara_2_castelT3', @presenceID, 3, @definitionID, 1365, 695, 2, 5, 60, 0, 25, 'Kara_2_castelT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kara_2_sequerT3', @presenceID, 3, @definitionID, 1365, 695, 2, 5, 60, 0, 25, 'Kara_2_sequerT3', 1, 1, 1, 1); 

----Kara_3

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_kara_3',1637,1391,1837,1591,'presence_flock_nor_kara_3',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_kara_3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_kara_3',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_kara_3',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_tank_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kara_3_grophoT3', @presenceID, 2, @definitionID, 1490, 564, 2, 5, 60, 0, 25, 'kara_3_grophoT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_ew_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kara_3_tyrpT3', @presenceID, 2, @definitionID, 1490, 564, 2, 5, 60, 0, 25, 'Kara_3_tyrpT3', 1, 1, 1, 1); 

----Kara_4

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_kara_4',1637,1391,1837,1591,'presence_flock_nor_kara_4',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_kara_4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_kara_4',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_kara_4',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_waspish_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kara_4_waspT3', @presenceID, 2, @definitionID, 1155, 729, 2, 5, 60, 0, 25, 'Kara_4_waspT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_castel_scout_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kara_4_castT3', @presenceID, 2, @definitionID, 1155, 729, 2, 5, 60, 0, 25, 'Kara_4_castT3', 1, 1, 1, 1); 

---Uria_1

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_uria_1',1637,1391,1837,1591,'presence_flock_nor_uria_1',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_uria_1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_uria_1',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_uria_1',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_hybrid_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('uria_1_gropht3', @presenceID, 3, @definitionID, 1165, 1645, 2, 5, 60, 0, 25, 'uria_1_gropht3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_ew_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('uria_1_tyroT3', @presenceID, 3, @definitionID, 1165, 1645, 2, 5, 60, 0, 25, 'uria_1_tyroT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ictus_dps_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('uria_1_ictusT3', @presenceID, 3, @definitionID, 1165, 1645, 2, 5, 60, 0, 25, 'uria_1_ictusT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('uria_1_sequert3', @presenceID, 3, @definitionID, 1165, 1645, 2, 5, 60, 0, 25, 'uria_1_sequert3', 1, 1, 1, 1); 

----uria_2

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_uria_2',1637,1391,1837,1591,'presence_flock_nor_uria_2',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_uria_2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_uria_2',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_uria_2',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_waspish_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('uria_2_waspT3', @presenceID, 3, @definitionID, 1315, 1467, 2, 5, 60, 0, 25, 'uria_2_waspT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_castel_scout_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('uria_2_castelT3', @presenceID, 3, @definitionID, 1315, 1467, 2, 5, 60, 0, 25, 'uria_2_castelT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_troiar_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('uria_2_troiarT3', @presenceID, 3, @definitionID, 1315, 1467, 2, 5, 60, 0, 25, 'uria_2_troiarT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('uria_2_sequerT3', @presenceID, 3, @definitionID, 1315, 1467, 2, 5, 60, 0, 25, 'uria_2_sequerT3', 1, 1, 1, 1); 

-----uria_3

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_uria_3',1637,1391,1837,1591,'presence_flock_nor_uria_3',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_uria_3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_uria_3',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_uria_3',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_hybrid_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('uria_3_grophoT3', @presenceID, 2, @definitionID, 1000, 1665, 2, 5, 60, 0, 25, 'uria_3_grophot3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_ew_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('uria_3_tyroT3', @presenceID, 2, @definitionID, 1000, 1665, 2, 5, 60, 0, 25, 'uria_3_tyroT3', 1, 1, 1, 1); 

----uria_4

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_uria_4',1637,1391,1837,1591,'presence_flock_nor_uria_4',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_uria_4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_uria_4',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_uria_4',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_waspish_scout_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('uria_4_waspT3', @presenceID, 2, @definitionID, 1190, 1361, 2, 5, 60, 0, 25, 'uria_4_waspT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_castel_scout_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('uria_4_castelT3', @presenceID, 2, @definitionID, 1190, 1361, 2, 5, 60, 0, 25, 'uria_4_castelT3', 1, 1, 1, 1); 

---TMB_1

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_TMB_1',1637,1391,1837,1591,'presence_flock_nor_TMB_1',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_TMB_1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_TMB_1',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_TMB_1',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_hybrid_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('tmb_1_SethT2', @presenceID, 2, @definitionID, 612, 1415, 2, 5, 60, 0, 25, 'tmb_1_SethT2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_ew_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('TMB_1_artyT2', @presenceID, 2, @definitionID, 612, 1415, 2, 5, 60, 0, 25, 'TMB_1_artyT2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_zenith_dps_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('TMB_1_zenithT2', @presenceID, 2, @definitionID, 612, 1415, 2, 5, 60, 0, 25, 'TMB_1_zenithT2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('TMB_1_sequerT2', @presenceID, 2, @definitionID, 612, 1415, 2, 5, 60, 0, 25, 'TMB_1_sequerT2', 1, 1, 1, 1); 

----tmb_2

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_TMB_2',1637,1391,1837,1591,'presence_flock_nor_TMB_2',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_TMB_2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_TMB_2',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_TMB_2',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_hybrid_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('TMB_2_mesmerT2', @presenceID, 2, @definitionID, 685, 1640, 2, 5, 60, 0, 25, 'TMB_2_mesmerT2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_ew_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('TMB_2_kainT2', @presenceID, 2, @definitionID, 685, 1640, 2, 5, 60, 0, 25, 'TMB_2_kainT2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vagabond_dps_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('TMB_2_vagabondT2', @presenceID, 2, @definitionID, 685, 1640, 2, 5, 60, 0, 25, 'TMB_2_vagabondT2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('TMB_2_sequerT2', @presenceID, 2, @definitionID, 685, 1640, 2, 5, 60, 0, 25, 'TMB_2_sequerT2', 1, 1, 1, 1); 

----TMB_3

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_TMB_3',1637,1391,1837,1591,'presence_flock_nor_TMB_3',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_TMB_3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_TMB_3',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_TMB_3',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_interceptor_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('TMB_3_arbyt2', @presenceID, 2, @definitionID, 291, 1843, 2, 5, 60, 0, 25, 'TMB_3_arbyt2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_cameleon_interceptor_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('TMB_3_camt2', @presenceID, 2, @definitionID, 291, 1843, 2, 5, 60, 0, 25, 'TMB_3_camt2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_interceptor_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('TMB_3_yagelt2', @presenceID, 2, @definitionID, 291, 1843, 2, 5, 60, 0, 25, 'TMB_3_yagelt2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('TMB_3_sequert2', @presenceID, 2, @definitionID, 291, 1843, 2, 5, 60, 0, 25, 'TMB_3_sequert2', 1, 1, 1, 1); 

---TMB_4

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_TMB_4',1637,1391,1837,1591,'presence_flock_nor_TMB_4',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_TMB_4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_TMB_4',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_TMB_4',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_baphomet_scout_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('TMB_4_bapht2', @presenceID, 2, @definitionID, 231, 1526, 2, 5, 60, 0, 25, 'TMB_4_bapht2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_intakt_interceptor_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('TMB_4_intaktt2', @presenceID, 2, @definitionID, 231, 1526, 2, 5, 60, 0, 25, 'TMB_4_intaktt2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_prometheus_interceptor_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('TMB_4_promt2', @presenceID, 2, @definitionID, 231, 1526, 2, 5, 60, 0, 25, 'TMB_4_promt2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('TMB_4_sequert2', @presenceID, 2, @definitionID, 231, 1526, 2, 5, 60, 0, 25, 'TMB_4_sequert2', 1, 1, 1, 1); 

----TMB_6

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_TMB_6',1637,1391,1837,1591,'presence_flock_nor_TMB_6',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_TMB_6' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_TMB_6',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_TMB_6',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_ew_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('tmb_6_artyT3', @presenceID, 2, @definitionID, 430, 1450, 2, 5, 60, 0, 25, 'tmb_6_artyT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_prometheus_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('tmb_6_promT3', @presenceID, 2, @definitionID, 430, 1450, 2, 5, 60, 0, 25, 'tmb_6_promT3', 1, 1, 1, 1); 

----TMB_7

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_TMB_7',1637,1391,1837,1591,'presence_flock_nor_TMB_7',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_TMB_7' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_TMB_7',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_TMB_7',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_ew_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('tmb_7_kaint3', @presenceID, 2, @definitionID, 500, 1775, 2, 5, 60, 0, 25, 'tmb_7_kaint3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('tmb_7_yagelt3', @presenceID, 2, @definitionID, 500, 1775, 2, 5, 60, 0, 25, 'tmb_7_yagelt3', 1, 1, 1, 1); 

-----TMB_hitech

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_hitech',1637,1391,1837,1591,'presence_flock_nor_hitech',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_hitech' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_hitech',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_hitech',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_hybrid_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hitech_grophot5', @presenceID, 3, @definitionID, 1638, 233, 2, 5, 60, 0, 25, 'hitech_grophot5', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_ew_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hitech_tyrannost5', @presenceID, 3, @definitionID, 1638, 233, 2, 5, 60, 0, 25, 'hitech_tyrannost5', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ictus_dps_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hitech_ictust5', @presenceID, 3, @definitionID, 1638, 233, 2, 5, 60, 0, 25, 'hitech_ictust5', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hitech_sequert5', @presenceID, 3, @definitionID, 1638, 233, 2, 5, 60, 0, 25, 'hitech_sequert5', 1, 1, 1, 1); 

---Nor_T3

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_indyt3',1637,1391,1837,1591,'presence_flock_nor_indyt3',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_indyt3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_indyt3',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_indyt3',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_riveler_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_indyt3_rivelert3', @presenceID, 3, @definitionID, 850, 1180, 2, 5, 60, 0, 25, 'nor_indyt3_rivelert3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_symbiont_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_indyt3_symbt3', @presenceID, 3, @definitionID, 850, 1180, 2, 5, 60, 0, 25, 'nor_indyt3_symbt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_lithus_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_indyt3_litht3', @presenceID, 3, @definitionID, 850, 1180, 2, 5, 60, 0, 25, 'nor_indyt3_litht3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_indyt3_scarabt3', @presenceID, 3, @definitionID, 850, 1180, 2, 5, 60, 0, 25, 'nor_indyt3_scarabt3', 1, 1, 1, 1); 

				----Nor_indyt5

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_indyt5',1637,1391,1837,1591,'presence_flock_nor_indyt5',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_indyt5' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_indyt5',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_indyt5',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_riveler_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_indyt5_rivelt5', @presenceID, 3, @definitionID, 824, 1024, 2, 5, 60, 0, 25, 'nor_indyt5_rivelt5', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_symbiont_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_indyt5_symbt5', @presenceID, 3, @definitionID, 824, 1024, 2, 5, 60, 0, 25, 'nor_indyt5_symbt5', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_lithus_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_indyt5_litht5', @presenceID, 3, @definitionID, 824, 1024, 2, 5, 60, 0, 25, 'nor_indyt5_litht5', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_indyt5_scarabt5', @presenceID, 3, @definitionID, 824, 1024, 2, 5, 60, 0, 25, 'nor_indyt5_scarabt5', 1, 1, 1, 1); 

-----Nor_SoloIndyT3

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_soloindyt3',1637,1391,1837,1591,'presence_flock_nor_soloindyt3',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_soloindyt3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_soloindyt3',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_soloindyt3',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_riveler_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_soloindyt3_rivt3', @presenceID, 1, @definitionID, 921, 525, 2, 5, 60, 0, 25, 'nor_soloindyt3_rivt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_symbiont_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_soloindyt3_symt3', @presenceID, 1, @definitionID, 921, 525, 2, 5, 60, 0, 25, 'nor_soloindyt3_symt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_soloindyt3_scarabt3', @presenceID, 1, @definitionID, 921, 525, 2, 5, 60, 0, 25, 'nor_soloindyt3_scarabt3', 1, 1, 1, 1); 

----Nor_soloindyt5

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_soloindyt5',1637,1391,1837,1591,'presence_flock_nor_soloindyt5',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_soloindyt5' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_soloindyt5',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_soloindyt5',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_soloindyt5_scarabt5', @presenceID, 1, @definitionID, 1875, 1665, 2, 5, 60, 0, 25, 'nor_soloindyt5_scarabt5', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_riveler_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_soloindyt5_rivelert5', @presenceID, 1, @definitionID, 1875, 1665, 2, 5, 60, 0, 25, 'nor_soloindyt5_rivelert5', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_symbiont_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_soloindyt5_symbt5', @presenceID, 1, @definitionID, 1875, 1665, 2, 5, 60, 0, 25, 'nor_soloindyt5_symbt5', 1, 1, 1, 1); 

-------Norhoop_money_spawn

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_moneyspawn',1637,1391,1837,1591,'presence_flock_nor_moneyspawn',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_moneyspawn' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_moneyspawn',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_moneyspawn',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_callisto_buccaneer_rank4' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_moneyspawn_callistoT4', @presenceID, 3, @definitionID, 1630, 1229, 2, 5, 60, 0, 25, 'nor_moneyspawn_callistoT4', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank4' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_moneyspawn_legT4', @presenceID, 3, @definitionID, 1630, 1229, 2, 5, 60, 0, 25, 'nor_moneyspawn_legT4', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_moneyspawn_legT3', @presenceID, 3, @definitionID, 1630, 1229, 2, 5, 60, 0, 25, 'nor_moneyspawn_legT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ikarus_abstrans_rank4' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_moneyspawn_ikarusT4', @presenceID, 3, @definitionID, 1630, 1229, 2, 5, 60, 0, 25, 'nor_moneyspawn_ikarusT4', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_moneyspawn_echelonT3', @presenceID, 3, @definitionID, 1630, 1229, 2, 5, 60, 0, 25, 'nor_moneyspawn_echelonT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank4' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_moneyspawn_echelonT4', @presenceID, 3, @definitionID, 1630, 1229, 2, 5, 60, 0, 25, 'nor_moneyspawn_echelonT4', 1, 1, 1, 1); 

----Nor_solo_hitech_hm/m

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_solohitechhmm',1637,1391,1837,1591,'presence_flock_nor_solohitechhmm',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_solohitechhmm' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_solohitechhmm',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_solohitechhmm',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_hybrid_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_solohitechhmm_grophot5', @presenceID, 2, @definitionID, 704, 1919, 2, 5, 60, 0, 25, 'nor_solohitechhmm_grophot5', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ictus_dps_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_solohitechhmm_ictust5', @presenceID, 3, @definitionID, 704, 1919, 2, 5, 60, 0, 25, 'nor_solohitechhmm_ictust5', 1, 1, 1, 1); 

----solo assl

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_assl',1637,1391,1837,1591,'presence_flock_nor_assl',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_assl' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_assl',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_assl',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_waspish_scout_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_assl_waspt5', @presenceID, 2, @definitionID, 1013, 383, 2, 5, 60, 0, 25, 'nor_assl_waspt5', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_troiar_interceptor_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_assl_troiart5', @presenceID, 3, @definitionID, 1013, 383, 2, 5, 60, 0, 25, 'nor_assl_troiart5', 1, 1, 1, 1); 

-----Norhoop_lithus

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_lithus',1637,1391,1837,1591,'presence_flock_nor_lithus',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_lithus' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_lithus',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_lithus',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_lithus_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_lithus_lithust3', @presenceID, 3, @definitionID, 1070, 940, 2, 5, 60, 0, 25, 'nor_lithus_lithust3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_lithus_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_lithus_lithusT5', @presenceID, 3, @definitionID, 1070, 940, 2, 5, 60, 0, 25, 'nor_lithus_lithusT5', 1, 1, 1, 1); 


-----Dom

---moyar_1

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_moyar_1',611,259,811,459,'presence_flock_dom_moyar_1',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_moyar_1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_moyar_1',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_moyar_1',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_hybrid_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('moyar_1_mest3', @presenceID, 3, @definitionID, 1100, 1485, 2, 5, 60, 0, 25, 'moyar_1_mest3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_ew_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('moyar_1_kaint3', @presenceID, 3, @definitionID, 1100, 1485, 2, 5, 60, 0, 25, 'moyar_1_kaint3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vagabond_dps_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('moyar_1_vagat3', @presenceID, 3, @definitionID, 1100, 1485, 2, 5, 60, 0, 25, 'moyar_1_vagat3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('moyar_1_sequert3', @presenceID, 3, @definitionID, 1100, 1485, 2, 5, 60, 0, 25, 'moyar_1_sequert3', 1, 1, 1, 1); 

---moyar_2

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_moyar_2',611,259,811,459,'presence_flock_dom_moyar_2',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_moyar_2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_moyar_2',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_moyar_2',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('moyar_2_arbyt3', @presenceID, 3, @definitionID, 991, 1510, 2, 5, 60, 0, 25, 'moyar_2_arbyt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_cameleon_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('moyar_2_camt3', @presenceID, 3, @definitionID, 991, 1510, 2, 5, 60, 0, 25, 'moyar_2_camt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_scout_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('moyar_2_yagelt3', @presenceID, 3, @definitionID, 991, 1510, 2, 5, 60, 0, 25, 'moyar_2_yagelt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('moyar_2_sequert3', @presenceID, 3, @definitionID, 991, 1510, 2, 5, 60, 0, 25, 'moyar_2_sequert3', 1, 1, 1, 1); 

-----moyar_3

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_moyar_3',611,259,811,459,'presence_flock_dom_moyar_3',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_moyar_3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_moyar_3',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_moyar_3',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_hybrid_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('moyar_3_mest3', @presenceID, 2, @definitionID, 860, 1767, 2, 5, 60, 0, 25, 'moyar_3_mest3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_ew_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('moyar_3_kaint3', @presenceID, 2, @definitionID, 860, 1767, 2, 5, 60, 0, 25, 'moyar_3_kaint3', 1, 1, 1, 1); 

----moyar_4

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_moyar_4',611,259,811,459,'presence_flock_dom_moyar_4',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_moyar_4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_moyar_4',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_moyar_4',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_scout_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('moyar_4_yagelt3', @presenceID, 2, @definitionID, 1163, 1938, 2, 5, 60, 0, 25, 'moyar_4_yagelt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_scout_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('moyar_4_arbyT3', @presenceID, 2, @definitionID, 1163, 1938, 2, 5, 60, 0, 25, 'moyar_4_arbyT3', 1, 1, 1, 1); 

-----HHO_1

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_hho_1',611,259,811,459,'presence_flock_dom_hho_1',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_hho_1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_hho_1',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_hho_1',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_hybrid_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hho_1_mesmert3', @presenceID, 3, @definitionID, 1217, 1104, 2, 5, 60, 0, 25, 'hho_1_mesmert3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_ew_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hho_1_kaint3', @presenceID, 3, @definitionID, 1217, 1104, 2, 5, 60, 0, 25, 'hho_1_kaint3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vagabond_dps_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hho_1_vagat3', @presenceID, 3, @definitionID, 1217, 1104, 2, 5, 60, 0, 25, 'hho_1_vagat3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hho_1_sequert3', @presenceID, 3, @definitionID, 1217, 1104, 2, 5, 60, 0, 25, 'hho_1_sequert3', 1, 1, 1, 1); 

----hho_2

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_hho_2',611,259,811,459,'presence_flock_dom_hho_2',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_hho_2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_hho_2',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_hho_2',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hho_2_arbyt3', @presenceID, 3, @definitionID, 898, 1031, 2, 5, 60, 0, 25, 'hho_2_arbyt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_cameleon_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hho_2_camt3', @presenceID, 3, @definitionID, 898, 1031, 2, 5, 60, 0, 25, 'hho_2_camt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hho_2_yagelt3', @presenceID, 3, @definitionID, 898, 1031, 2, 5, 60, 0, 25, 'hho_2_yagelt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hho_2_sequert3', @presenceID, 3, @definitionID, 898, 1031, 2, 5, 60, 0, 25, 'hho_2_sequert3', 1, 1, 1, 1); 

----hho_3

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_hho_3',611,259,811,459,'presence_flock_dom_hho_3',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_hho_3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_hho_3',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_hho_3',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_hybrid_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hho_3_mest3', @presenceID, 2, @definitionID, 1065, 1207, 2, 5, 60, 0, 25, 'hho_3_mest3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_ew_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hho_3_kaint3', @presenceID, 2, @definitionID, 1065, 1207, 2, 5, 60, 0, 25, 'hho_3_kaint3', 1, 1, 1, 1); 

---hho_4

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_hho_4',611,259,811,459,'presence_flock_dom_hho_4',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_hho_4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_hho_4',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_hho_4',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hho_4_arbyt3', @presenceID, 2, @definitionID, 778, 1116, 2, 5, 60, 0, 25, 'hho_4_arbyt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_scout_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hho_4_yagelt3', @presenceID, 2, @definitionID, 778, 1116, 2, 5, 60, 0, 25, 'hho_4_yagelt3', 1, 1, 1, 1); 


----Kko__1

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_kko_1',611,259,811,459,'presence_flock_dom_kko_1',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_kko_1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_kko_1',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_kko_1',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_hybrid_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kko_1_mesmert3', @presenceID, 3, @definitionID, 1019, 363, 2, 5, 60, 0, 25, 'kko_1_mesmert3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_ew_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kko_1_kaint3', @presenceID, 3, @definitionID, 1019, 363, 2, 5, 60, 0, 25, 'kko_1_kaint3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vagabond_dps_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kko_1_vagat3', @presenceID, 3, @definitionID, 1019, 363, 2, 5, 60, 0, 25, 'kko_1_vagat3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kko_1_sequert3', @presenceID, 3, @definitionID, 1019, 363, 2, 5, 60, 0, 25, 'kko_1_sequert3', 1, 1, 1, 1); 

---KKO_2

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_kko_2',611,259,811,459,'presence_flock_dom_kko_2',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_kko_2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_kko_2',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_kko_2',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kko_2_arbyt3', @presenceID, 3, @definitionID, 1019, 363, 2, 5, 60, 0, 25, 'kko_2_arbyt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_cameleon_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kko_2_camt3', @presenceID, 3, @definitionID, 1019, 363, 2, 5, 60, 0, 25, 'kko_2_camt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_scout_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kko_2_yagelt3', @presenceID, 3, @definitionID, 1019, 363, 2, 5, 60, 0, 25, 'kko_2_yagelt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kko_2_sequert3', @presenceID, 3, @definitionID, 1019, 363, 2, 5, 60, 0, 25, 'kko_2_sequert3', 1, 1, 1, 1); 

----KKO_3

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_kko_3',611,259,811,459,'presence_flock_dom_kko_3',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_kko_3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_kko_3',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_kko_3',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_hybrid_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kko_3_mesmert3', @presenceID, 2, @definitionID, 1170, 613, 2, 5, 60, 0, 25, 'kko_3_mesmert3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_ew_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kko_3_kaint3', @presenceID, 2, @definitionID, 1170, 613, 2, 5, 60, 0, 25, 'kko_3_kaint3', 1, 1, 1, 1); 

----KKO_4

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_kko_4',611,259,811,459,'presence_flock_dom_kko_4',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_kko_4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_kko_4',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_kko_4',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_scout_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kko_4_arbyt3', @presenceID, 2, @definitionID, 1308, 282, 2, 5, 60, 0, 25, 'kko_4_arbyt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kko_4_yagelt3', @presenceID, 2, @definitionID, 1308, 282, 2, 5, 60, 0, 25, 'kko_4_yagelt3', 1, 1, 1, 1); 

---icsb_1

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_icsb_1',611,259,811,459,'presence_flock_dom_icsb_1',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_icsb_1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_icsb_1',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_icsb_1',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_hybrid_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('icsb_1_setht2', @presenceID, 2, @definitionID, 1800, 710, 2, 5, 60, 0, 25, 'icsb_1_setht2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_ew_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('icsb_1_artyt2', @presenceID, 2, @definitionID, 1800, 710, 2, 5, 60, 0, 25, 'icsb_1_artyt2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_zenith_dps_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('icsb_1_zenitht2', @presenceID, 2, @definitionID, 1800, 710, 2, 5, 60, 0, 25, 'icsb_1_zenitht2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('icsb_1_sequert2', @presenceID, 2, @definitionID, 1800, 710, 2, 5, 60, 0, 25, 'icsb_1_sequert2', 1, 1, 1, 1); 

----icsb_2

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_icsb_2',611,259,811,459,'presence_flock_dom_icsb_2',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_icsb_2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_icsb_2',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_icsb_2',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_hybrid_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('icsb_2_gropht2', @presenceID, 2, @definitionID, 1800, 1020, 2, 5, 60, 0, 25, 'icsb_2_gropht2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_ew_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('icsb_2_tyrot2', @presenceID, 2, @definitionID, 1800, 1020, 2, 5, 60, 0, 25, 'icsb_2_tyrot2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ictus_dps_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('icsb_2_ictust2', @presenceID, 2, @definitionID, 1800, 1020, 2, 5, 60, 0, 25, 'icsb_2_ictust2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('icsb_2_sequert2', @presenceID, 2, @definitionID, 1800, 1020, 2, 5, 60, 0, 25, 'icsb_2_sequert2', 1, 1, 1, 1); 

----icsb_3

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_icsb_3',611,259,811,459,'presence_flock_dom_icsb_2',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_icsb_3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_icsb_3',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_icsb_3',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_baphomet_interceptor_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('icsb_3_bapht2', @presenceID, 2, @definitionID, 1675, 1000, 2, 5, 60, 0, 25, 'icsb_3_bapht2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_intakt_interceptor_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('icsb_3_intaktt2', @presenceID, 2, @definitionID, 1675, 1000, 2, 5, 60, 0, 25, 'icsb_3_intaktt2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_prometheus_scout_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('icsb_3_promt2', @presenceID, 2, @definitionID, 1675, 1000, 2, 5, 60, 0, 25, 'icsb_3_promt2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('icsb_3_sequert2', @presenceID, 2, @definitionID, 1675, 1000, 2, 5, 60, 0, 25, 'icsb_3_sequert2', 1, 1, 1, 1); 

----icsb_4

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_icsb_4',611,259,811,459,'presence_flock_dom_icsb_4',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_icsb_4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_icsb_4',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_icsb_4',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_waspish_interceptor_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('icsb_4_waspisht2', @presenceID, 2, @definitionID, 1445, 845, 2, 5, 60, 0, 25, 'icsb_4_waspisht2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_troiar_interceptor_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('icsb_4_troiart2', @presenceID, 2, @definitionID, 1445, 845, 2, 5, 60, 0, 25, 'icsb_4_troiart2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_castel_interceptor_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('icsb_4_castelt2', @presenceID, 2, @definitionID, 1445, 845, 2, 5, 60, 0, 25, 'icsb_4_castelt2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('icsb_4_sequert2', @presenceID, 2, @definitionID, 1445, 845, 2, 5, 60, 0, 25, 'icsb_4_sequert2', 1, 1, 1, 1); 

----icsb_6

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_icsb_6',611,259,811,459,'presence_flock_dom_icsb_6',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_icsb_6' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_icsb_6',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_icsb_6',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_hybrid_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('icsb_6_setht2', @presenceID, 2, @definitionID, 1853, 900, 2, 5, 60, 0, 25, 'icsb_6_setht2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_intakt_interceptor_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('icsb_6_intaktt2', @presenceID, 2, @definitionID, 1853, 900, 2, 5, 60, 0, 25, 'icsb_6_intaktt2', 1, 1, 1, 1); 

----icsb_7

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_icsb_7',611,259,811,459,'presence_flock_dom_icsb_7',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_icsb_7' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_icsb_7',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_icsb_7',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_hybrid_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('icsb_7_grophot2', @presenceID, 2, @definitionID, 1500, 1075, 2, 5, 60, 0, 25, 'icsb_7_grophot2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_troiar_interceptor_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('icsb_7_troiart2', @presenceID, 2, @definitionID, 1500, 1075, 2, 5, 60, 0, 25, 'icsb_7_troiart2', 1, 1, 1, 1); 

----hitech

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_hitech',611,259,811,459,'presence_flock_dom_hitech',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_hitech' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_hitech',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_hitech',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_hybrid_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hitech_mest5', @presenceID, 3, @definitionID, 225, 1225, 2, 5, 60, 0, 25, 'hitech_mest5', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_ew_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hitech_kaint5', @presenceID, 3, @definitionID, 225, 1225, 2, 5, 60, 0, 25, 'hitech_kaint5', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vagabond_dps_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hitech_vagat5', @presenceID, 3, @definitionID, 225, 1225, 2, 5, 60, 0, 25, 'hitech_vagat5', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hitech_sequert5', @presenceID, 3, @definitionID, 225, 1225, 2, 5, 60, 0, 25, 'hitech_sequert5', 1, 1, 1, 1); 

---indyt3

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_indyt3',611,259,811,459,'presence_flock_dom_indyt3',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_indyt3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_indyt3',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_indyt3',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_symbiont_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('indyt3_symbt3', @presenceID, 3, @definitionID, 685, 365, 2, 5, 60, 0, 25, 'indyt3_symbt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_riveler_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('indyt3_rivt3', @presenceID, 3, @definitionID, 685, 365, 2, 5, 60, 0, 25, 'indyt3_rivt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_lithus_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('indyt3_litht3', @presenceID, 3, @definitionID, 685, 365, 2, 5, 60, 0, 25, 'indyt3_litht3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('indyt3_scarbt3', @presenceID, 3, @definitionID, 685, 365, 2, 5, 60, 0, 25, 'indyt3_scarbt3', 1, 1, 1, 1); 

---indyt5

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_indyt5',611,259,811,459,'presence_flock_dom_indyt5',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_indyt5' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_indyt5',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_indyt5',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_riveler_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('indyt5_rivt5', @presenceID, 3, @definitionID, 814, 814, 2, 5, 60, 0, 25, 'indyt5_rivt5', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_symbiont_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('indyt5_symbt5', @presenceID, 3, @definitionID, 814, 814, 2, 5, 60, 0, 25, 'indyt5_symbt5', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_lithus_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('indyt5_litht5', @presenceID, 3, @definitionID, 814, 814, 2, 5, 60, 0, 25, 'indyt5_litht5', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('indyt5_scarabt5', @presenceID, 3, @definitionID, 814, 814, 2, 5, 60, 0, 25, 'indyt5_scarabt5', 1, 1, 1, 1); 

-----soloindyt3

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_soloindyt3',611,259,811,459,'presence_flock_dom_soloindyt3',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_soloindyt3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_soloindyt3',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_soloindyt3',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_riveler_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('dom_soloindyt3_rivt3', @presenceID, 1, @definitionID, 950, 1400, 2, 5, 60, 0, 25, 'dom_soloindyt3_rivt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_symbiont_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('dom_soloindyt3_symbt3', @presenceID, 1, @definitionID, 950, 1400, 2, 5, 60, 0, 25, 'dom_soloindyt3_symbt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('dom_soloindyt3_scarabt3', @presenceID, 1, @definitionID, 950, 1400, 2, 5, 60, 0, 25, 'dom_soloindyt3_scarabt3', 1, 1, 1, 1); 

-----soloindyt5

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_soloindyt5',611,259,811,459,'presence_flock_dom_soloindyt5',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_soloindyt5' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_soloindyt5',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_soloindyt5',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_riveler_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('dom_soloindyt5_rivt5', @presenceID, 1, @definitionID, 1340, 1288, 2, 5, 60, 0, 25, 'dom_soloindyt5_rivt5', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_symbiont_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('dom_soloindyt5_symbt5', @presenceID, 1, @definitionID, 1340, 1288, 2, 5, 60, 0, 25, 'dom_soloindyt5_symbt5', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('dom_soloindyt5_scarabt5', @presenceID, 1, @definitionID, 1340, 1288, 2, 5, 60, 0, 25, 'dom_soloindyt5_scarabt5', 1, 1, 1, 1); 

				----moneyspawn

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_moneyspawn',611,259,811,459,'presence_flock_dom_moneyspawn',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_moneyspawn' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_moneyspawn',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_moneyspawn',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_callisto_buccaneer_rank4' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('dom_moneyspawn_callt4', @presenceID, 3, @definitionID, 690, 1255, 2, 5, 60, 0, 25, 'dom_moneyspawn_callt4', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank4' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('dom_moneyspawn_legt4', @presenceID, 3, @definitionID, 690, 1255, 2, 5, 60, 0, 25, 'dom_moneyspawn_legt4', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('dom_moneyspawn_legt3', @presenceID, 3, @definitionID, 690, 1255, 2, 5, 60, 0, 25, 'dom_moneyspawn_legt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank4' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('dom_moneyspawn_echt4', @presenceID, 3, @definitionID, 690, 1255, 2, 5, 60, 0, 25, 'dom_moneyspawn_echt4', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('dom_moneyspawn_echt3', @presenceID, 3, @definitionID, 690, 1255, 2, 5, 60, 0, 25, 'dom_moneyspawn_echt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ikarus_abstrans_rank4' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('dom_moneyspawn_ikarust4', @presenceID, 3, @definitionID, 690, 1255, 2, 5, 60, 0, 25, 'dom_moneyspawn_ikarust4', 1, 1, 1, 1); 

---hitechHMM

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_hitech_HMM',611,259,811,459,'presence_flock_dom_hitech_HMM',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_hitech_HMM' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_hitech_HMM',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_hitech_HMM',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_tank_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('dom_hitech_HMM_mest5', @presenceID, 2, @definitionID, 277, 1597, 2, 5, 60, 0, 25, 'dom_hitech_HMM_mest5', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vagabond_dps_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('dom_hitech_HMM_vagT5', @presenceID, 3, @definitionID, 277, 1597, 2, 5, 60, 0, 25, 'dom_hitech_HMM_vagT5', 1, 1, 1, 1); 

----hitech_assl

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_hitech_ASSL',611,259,811,459,'presence_flock_dom_hitech_ASSL',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_hitech_ASSL' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_hitech_ASSL',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_hitech_ASSL',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_interceptor_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('dom_hitech_assl_arbyT5', @presenceID, 2, @definitionID, 400, 400, 2, 5, 60, 0, 25, 'dom_hitech_assl_arbyT5', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_cameleon_interceptor_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('dom_hitech_assl_camT5', @presenceID, 3, @definitionID, 400, 400, 2, 5, 60, 0, 25, 'dom_hitech_assl_camT5', 1, 1, 1, 1); 

----lithus

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_lithus',611,259,811,459,'presence_flock_dom_lithus',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_lithus' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_lithus',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_lithus',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_lithus_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('dom_lithus_lithust3', @presenceID, 3, @definitionID, 775, 1025, 2, 5, 60, 0, 25, 'dom_lithus_lithust3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_lithus_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('dom_lithus_lithusT5', @presenceID, 3, @definitionID, 775, 1025, 2, 5, 60, 0, 25, 'dom_lithus_lithusT5', 1, 1, 1, 1); 


----Cuting back on roaming spawns in the island

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'gei_roaming_01' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'gei_roaming_01',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 7,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 86400,[presencetype] = 1,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_roaming_tyrannos_beta' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_gei_roaming1_tyrannosbeta1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_gei_roaming1_tyrannosbeta1' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 559, [spawnoriginY] = 286 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'dom_roaming_01' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'dom_roaming_01',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 9,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 86400,[presencetype] = 1,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_roaming_kain_beta' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_dom_roaming1_kainbeta1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_dom_roaming1_kainbeta1' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1730, [spawnoriginY] = 1400 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hok_roaming_01' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'hok_roaming_01',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 8,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 86400,[presencetype] = 1,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_roaming_artemis_beta' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_hok_roaming1_artemisbeta1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_hok_roaming1_artemisbeta1' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1716, [spawnoriginY] = 1754 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'gei_caravan_01' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'gei_caravan_01',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 7,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 1800,[presencetype] = 1,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_gei_caravan1_sequer' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_gei_caravan1_sequer' ,[presenceid] = @presenceID, [flockmembercount] = 5, [definition] = @definitionID, [spawnoriginX] = 573, [spawnoriginY] = 279 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_troiar_interceptor_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_gei_caravan1_troiar' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_gei_caravan1_troiar' ,[presenceid] = @presenceID, [flockmembercount] = 5, [definition] = @definitionID, [spawnoriginX] = 573, [spawnoriginY] = 280 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_heavydps_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_gei_caravan1_gropho' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_gei_caravan1_gropho' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 573, [spawnoriginY] = 281 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_gei_caravan1_scarab' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_gei_caravan1_scarab' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 573, [spawnoriginY] = 279 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'dom_caravan_01' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'dom_caravan_01',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 9,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 1800,[presencetype] = 1,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_dom_caravan1_sequer' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_dom_caravan1_sequer' ,[presenceid] = @presenceID, [flockmembercount] = 5, [definition] = @definitionID, [spawnoriginX] = 1722, [spawnoriginY] = 1411 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_cameleon_interceptor_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_dom_caravan1_cameleon' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_dom_caravan1_cameleon' ,[presenceid] = @presenceID, [flockmembercount] = 5, [definition] = @definitionID, [spawnoriginX] = 1722, [spawnoriginY] = 1412 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_heavydps_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_dom_caravan1_mesmer' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_dom_caravan1_mesmer' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 1722, [spawnoriginY] = 1413 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_dom_caravan1_scarab' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_dom_caravan1_scarab' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1722, [spawnoriginY] = 1411 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hok_caravan_01' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'hok_caravan_01',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 8,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 1800,[presencetype] = 1,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_hok_caravan1_sequer' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_hok_caravan1_sequer' ,[presenceid] = @presenceID, [flockmembercount] = 5, [definition] = @definitionID, [spawnoriginX] = 1728, [spawnoriginY] = 1753 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_intakt_interceptor_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_hok_caravan1_intakt' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_hok_caravan1_intakt' ,[presenceid] = @presenceID, [flockmembercount] = 5, [definition] = @definitionID, [spawnoriginX] = 1729, [spawnoriginY] = 1754 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_heavydps_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_hok_caravan1_seth' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_hok_caravan1_seth' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 1730, [spawnoriginY] = 1755 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_hok_caravan1_scarab' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_hok_caravan1_scarab' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1730, [spawnoriginY] = 1755 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'gei_roaming_02' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'gei_roaming_02',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 7,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 86400,[presencetype] = 1,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_roaming_tyrannos_beta' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_gei_roaming2_tyrannosbeta1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_gei_roaming2_tyrannosbeta1' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 558, [spawnoriginY] = 286 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_roaming_gropho_beta' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_gei_roaming2_grophobeta1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_gei_roaming2_grophobeta1' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 557, [spawnoriginY] = 286 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'gei_caravan_02' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'gei_caravan_02',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 7,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 1800,[presencetype] = 1,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_gei_caravan2_sequer' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_gei_caravan2_sequer' ,[presenceid] = @presenceID, [flockmembercount] = 5, [definition] = @definitionID, [spawnoriginX] = 565, [spawnoriginY] = 279 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ictus_heavyew_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_gei_caravan2_ictus' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_gei_caravan2_ictus' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 565, [spawnoriginY] = 280 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_heavydps_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_gei_caravan2_gropho' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_gei_caravan2_gropho' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 565, [spawnoriginY] = 281 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_gei_caravan2_scarab' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_gei_caravan2_scarab' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = @definitionID, [spawnoriginX] = 565, [spawnoriginY] = 279 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'gei_roaming_03' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'gei_roaming_03',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 7,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 86400,[presencetype] = 1,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_troiar_interceptor_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_gei_roaming3_troiar' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_gei_roaming3_troiar' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 573, [spawnoriginY] = 290 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 3600, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_dps_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_gei_roaming3_tyrannos' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_gei_roaming3_tyrannos' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = @definitionID, [spawnoriginX] = 572, [spawnoriginY] = 290 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 3600, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_waspish_dps_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_gei_roaming3_waspish' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_gei_roaming3_waspish' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 571, [spawnoriginY] = 290 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 3600, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ictus_heavyew_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_gei_roaming3_ictus' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_gei_roaming3_ictus' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 570, [spawnoriginY] = 290 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 3600, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'dom_roaming_02' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'dom_roaming_02',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 9,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 86400,[presencetype] = 1,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_roaming_kain_beta' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_dom_roaming2_kainbeta1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_dom_roaming2_kainbeta1' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1731, [spawnoriginY] = 1399 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_roaming_mesmer_beta' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_dom_roaming2_mesmer1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_dom_roaming2_mesmer1' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1731, [spawnoriginY] = 1398 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'dom_caravan_02' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'dom_caravan_02',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 9,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 1800,[presencetype] = 1,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_heavydps_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_dom_caravan2_mesmer' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_dom_caravan2_mesmer' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 1731, [spawnoriginY] = 1410 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vagabond_heavyew_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_dom_caravan2_vagabond' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_dom_caravan2_vagabond' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 1731, [spawnoriginY] = 1409 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_dom_caravan2_sequer' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_dom_caravan2_sequer' ,[presenceid] = @presenceID, [flockmembercount] = 5, [definition] = @definitionID, [spawnoriginX] = 1731, [spawnoriginY] = 1411 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_dom_caravan2_scarab' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_dom_caravan2_scarab' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 1731, [spawnoriginY] = 1411 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_dom_caravan2_scarab' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_dom_caravan2_scarab' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = @definitionID, [spawnoriginX] = 1731, [spawnoriginY] = 1411 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'dom_roaming_03' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'dom_roaming_03',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 9,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 86400,[presencetype] = 1,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_cameleon_interceptor_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_dom_roaming3_cameleon' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_dom_roaming3_cameleon' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 1721, [spawnoriginY] = 1398 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 3600, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_dps_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_dom_roaming3_kain' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_dom_roaming3_kain' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = @definitionID, [spawnoriginX] = 1721, [spawnoriginY] = 1399 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 3600, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_dps_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_dom_roaming3_arbalest' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_dom_roaming3_arbalest' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 1721, [spawnoriginY] = 1400 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 3600, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vagabond_heavyew_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_dom_roaming3_vagabond' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_dom_roaming3_vagabond' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1721, [spawnoriginY] = 1401 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 3600, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hok_roaming_02' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'hok_roaming_02',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 8,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 86400,[presencetype] = 1,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_roaming_artemis_beta' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_hok_roaming2_artemisbeta1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_hok_roaming2_artemisbeta1' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1717, [spawnoriginY] = 1753 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_roaming_seth_beta' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_hok_roaming2_sethbeta1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_hok_roaming2_sethbeta1' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1718, [spawnoriginY] = 1752 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hok_caravan_02' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'hok_caravan_02',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 8,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 1800,[presencetype] = 1,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_hok_caravan2_sequer' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_hok_caravan2_sequer' ,[presenceid] = @presenceID, [flockmembercount] = 5, [definition] = @definitionID, [spawnoriginX] = 1724, [spawnoriginY] = 1757 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_zenith_heavyew_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_hok_caravan2_zenith' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_hok_caravan2_zenith' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 1725, [spawnoriginY] = 1758 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_heavydps_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_hok_caravan2_seth' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_hok_caravan2_seth' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 1726, [spawnoriginY] = 1759 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_hok_caravan2_scarab' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_hok_caravan2_scarab' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 1724, [spawnoriginY] = 1757 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_hok_caravan2_scarab' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_hok_caravan2_scarab' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = @definitionID, [spawnoriginX] = 1724, [spawnoriginY] = 1757 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hok_roaming_03' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'hok_roaming_03',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 8,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 86400,[presencetype] = 1,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_intakt_interceptor_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_hok_roaming3_intakt' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_hok_roaming3_intakt' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 1718, [spawnoriginY] = 1756 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 3600, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_baphomet_dps_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_hok_roaming3_baphomet' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_hok_roaming3_baphomet' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 1719, [spawnoriginY] = 1755 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 3600, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_dps_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_hok_roaming3_artemis' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_hok_roaming3_artemis' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = @definitionID, [spawnoriginX] = 1720, [spawnoriginY] = 1754 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 3600, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_zenith_heavyew_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_hok_roaming3_zenith' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_hok_roaming3_zenith' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1721, [spawnoriginY] = 1753 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 3600, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;


set noexec off;

PRINT N'BETA 1 NPC OVERHAUL PATCH COMPLETE';
GO


