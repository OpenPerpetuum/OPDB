USE perpetuumsa
GO

DECLARE @presenceID int;
DECLARE @flockID int;
DECLARE @definitionID int;
DECLARE @robottemplateid int;
DECLARE @lootdefinitionID int;
DECLARE @npclootID int;


-- Disable existing New Virgina spawns
 UPDATE npcpresence
  SET [enabled] = 0 
  WHERE spawnid = 1

  
--ADD NPC's to Spawns
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('tma_fort_donnerth',7,7,2040,2040,'tm npc set',1,0,0,0,0,'',''
			    ,'','','',0,1,1);


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'tma_fort_donnerth' ORDER BY id DESC);

UPDATE [dbo].[npcpresence]
                SET [name] = 'tma_fort_donnerth',[topx] = 7,[topy] = 7,[bottomx] = 2040,[bottomy] = 2040,[note] = 'tm npc set',[spawnid] = 1,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank1' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('argano_by_terminal', @presenceID, 4, 2397, 1120, 820, 0, 5, 60, 0,
                 15, 'argano_by_terminal', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank1' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('sequer_by_terminal', @presenceID, 3, 2407, 1120, 820, 0, 5, 60, 0,
                 15, 'sequer_by_terminal', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank1' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('laird_by_terminal', @presenceID, 4, 2402, 1120, 920, 0, 5, 60, 0,
                 15, 'laird_by_terminal', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('sequer_by_terminal2', @presenceID, 2, 2408, 1115, 660, 0, 5, 60, 0,
                 15, 'sequer_by_terminal2', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank1' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('locust_with_sequer', @presenceID, 2, 5556, 1115, 660, 0, 5, 60, 0,
                 15, 'locust_with_sequer', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('vektor_in_da_hood', @presenceID, 2, 5549, 1045, 1020, 0, 5, 60, 0,
                 15, 'vektor_in_da_hood', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('this_little_laird', @presenceID, 4, 2403, 800, 940, 0, 5, 60, 0,
                 15, 'went_to_the_market', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('this_little_sequer', @presenceID, 2, 2408, 800, 940, 0, 5, 60, 0,
                 15, 'got_cancer', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank1' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('this_little_sequer', @presenceID, 2, 2407, 1400, 760, 0, 5, 60, 0,
                 15, 'got_the_space_aids', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_termis_basic_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('this_little_termis', @presenceID, 2, 2413, 1400, 760, 0, 5, 60, 0,
                 15, 'got_ghanked_by_an_observer', 1, 1, 0, 1);

---------------------------
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('tma_lenworth',7,7,2040,2040,'tm npc set',1,1,0,0,0,'',''
			    ,'','','',0,1,1);


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'tma_lenworth' ORDER BY id DESC);

UPDATE [dbo].[npcpresence]
                SET [name] = 'tma_lenworth',[topx] = 7,[topy] = 7,[bottomx] = 2040,[bottomy] = 2040,[note] = 'tm npc set',[spawnid] = 1,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('vektor2', @presenceID, 3, @definitionID, 1530, 1670, 0, 5, 60, 0,
                 15, 'vektor2', 1, 1, 1, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('locust2', @presenceID, 2, @definitionID, 1530, 1670, 0, 5, 60, 0,
                 15, 'locust2', 1, 1, 1, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank1' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('vektor1', @presenceID, 4, @definitionID, 1670, 1450, 0, 5, 60, 0,
                 15, 'vektor1', 1, 1, 1, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('locust4', @presenceID, 2, @definitionID, 1670, 1450, 0, 5, 60, 0,
                 15, 'locust4', 1, 1, 1, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('echelon1', @presenceID, 2, @definitionID, 1890, 1537, 0, 5, 60, 0,
                 15, 'echelon1', 1, 1, 1, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('locustr2', @presenceID, 4, @definitionID, 1890, 1537, 0, 5, 60, 0,
                 15, 'locustr2', 1, 1, 1, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('echelon2', @presenceID, 2, @definitionID, 1680, 1800, 0, 5, 60, 0,
                 15, 'echelon2', 1, 1, 1, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank1' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('locust5', @presenceID, 4, @definitionID, 1680, 1800, 0, 5, 60, 0,
                 15, 'locust5', 1, 1, 1, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('locust7', @presenceID, 3, @definitionID, 1546, 1637, 0, 5, 60, 0,
                 15, 'locust7', 1, 1, 1, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_ikarus_abstrans_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('abstrans3', @presenceID, 2, @definitionID, 1546, 1637, 0, 5, 60, 0,
                 15, 'abstrans3', 1, 1, 1, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('vektor10', @presenceID, 4, 5549, 1450, 1550, 0, 5, 60, 0,
                 15, 'vektor10', 1, 1, 1, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('locust8', @presenceID, 3, @definitionID, 1150, 1678, 0, 5, 60, 0,
                 15, 'locust8', 1, 1, 1, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank2' ORDER BY [definition] DESC)				 

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('indygroup5', @presenceID, 2, @definitionID, 1314, 1268, 0, 5, 60, 0,
                 15, 'indygroup5', 1, 1, 1, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('indygroup6', @presenceID, 2, @definitionID, 1314, 1268, 0, 5, 60, 0,
                 15, 'indygroup6', 1, 1, 1, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('indygroup7', @presenceID, 2, @definitionID, 1314, 1268, 0, 5, 60, 0,
                 15, 'indygroup7', 1, 1, 1, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank1' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('indygroup8', @presenceID, 1, @definitionID, 685, 1320, 0, 5, 60, 0,
                 15, 'indygroup8', 1, 1, 1, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_termis_basic_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('indygroup9', @presenceID, 3, @definitionID, 685, 1320, 0, 5, 60, 0,
                 15, 'indygroup9', 1, 1, 1, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('locustr23', @presenceID, 3, @definitionID, 295, 1548, 0, 5, 60, 0,
                 15, 'locustr23', 1, 1, 1, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank1' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('vektor123', @presenceID, 1, @definitionID, 295, 1548, 0, 5, 60, 0,
                 15, 'vektor123', 1, 1, 1, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('locust8911', @presenceID, 3, @definitionID, 305, 1763, 0, 5, 60, 0,
                 15, 'locust8911', 1, 1, 1, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('sequer_that_got_lost', @presenceID, 3, @definitionID, 545, 1820, 0, 5, 60, 0,
                 15, 'i_have_cancer', 1, 1, 1, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('argano_that_got_killed', @presenceID, 3, @definitionID, 545, 1820, 0, 5, 60, 0,
                 15, 'argano_that_got_killed', 1, 1, 1, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('echelonr3', @presenceID, 2, @definitionID, 985, 1765, 0, 5, 60, 0,
                 15, 'echelonr3', 1, 1, 1, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('locust678', @presenceID, 2, @definitionID, 985, 1765, 0, 5, 60, 0,
                 15, 'locust678', 1, 1, 1, 1);



---------------------------
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('tma_cadavria',7,7,2040,2040,'tm npc set',1,1,0,0,0,'',''
			    ,'','','',0,1,1);

	
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'tma_cadavria' ORDER BY id DESC);

UPDATE [dbo].[npcpresence]
                SET [name] = 'tma_cadavria',[topx] = 7,[topy] = 7,[bottomx] = 2040,[bottomy] = 2040,[note] = 'tm npc set',[spawnid] = 1,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

--Removed NPC's too close to terminal and not weak
--SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_weak_bot' ORDER BY [definition] DESC)

--INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
--                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
--                ('weakass', @presenceID, 10, @definitionID, 1120, 820, 0, 5, 30, 0,
--                 5, 'weakass', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('echelon_be_swinging', @presenceID, 2, @definitionID, 985, 1765, 0, 5, 60, 0,
                 15, 'echelon_be_swinging', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank1' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('locust_hung_lo', @presenceID, 3, @definitionID, 985, 1765, 0, 5, 60, 0,
                 15, 'locust_hung_lo', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('weakassvektor', @presenceID, 4, @definitionID, 910, 1815, 0, 5, 60, 0,
                 15, 'weakassvektor', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_lithus_basic_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('lithus_swinging', @presenceID, 1, @definitionID, 740, 1475, 0, 5, 60, 0,
                 15, 'lithus_swinging', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_gargoyle_basic_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('gargoyle_hates_juice', @presenceID, 3, @definitionID, 740, 1475, 0, 5, 60, 0,
                 15, 'gargoyle_hates_juice', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('vektor_goat', @presenceID, 4, @definitionID, 682, 1136, 0, 5, 60, 0,
                 15, 'vektor_goat', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('sequer_loves_grass', @presenceID, 2, @definitionID, 1190, 1100, 0, 5, 60, 0,
                 15, 'sequer_loves_grass', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('argano_rolls_up_on_you', @presenceID, 4, @definitionID, 1190, 1100, 0, 5, 60, 0,
                 15, 'argano_rolls_up_on_you', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('vektor_rooterupper', @presenceID, 3, @definitionID, 1415, 1010, 0, 5, 60, 0,
                 15, 'vektor_rooterupper', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('sequer_basic_role_too', @presenceID, 2, @definitionID, 1210, 855, 0, 5, 60, 0,
                 15, 'sequer_basic_role_too', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_termis_basic_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('termis_be_hangingupside_down', @presenceID, 3, @definitionID, 1210, 855, 0, 5, 60, 0,
                 15, 'termis_be_hangingupside_down', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('vektor_groupie', @presenceID, 2, @definitionID, 1020, 698, 0, 5, 60, 0,
                 15, 'vektor_groupie', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('laird_basic_group3', @presenceID, 4, @definitionID, 970, 950, 0, 5, 60, 0,
                 15, 'laird_basic_group3', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('sequer_group_five', @presenceID, 2, @definitionID, 920, 754, 0, 5, 60, 0,
                 15, 'sequer_group_five', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('vektor_Swab_rank3', @presenceID, 2, @definitionID, 920, 754, 0, 5, 60, 0,
                 15, 'vektor_swab_rank3', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('renaming_cause_bler_asked_me_too', @presenceID, 3, @definitionID, 353, 835, 0, 5, 60, 0,
                 15, 'renaming_cause_bler_asked_me_too', 1, 1, 0, 1);


---------------------------
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('tma_cadavria2',7,7,2040,2040,'tm npc set',1,1,0,0,0,'',''
			    ,'','','',0,1,1);


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'tma_cadavria2' ORDER BY id DESC);

UPDATE [dbo].[npcpresence]
                SET [name] = 'tma_cadavria2',[topx] = 7,[topy] = 7,[bottomx] = 2040,[bottomy] = 2040,[note] = 'tm npc set',[spawnid] = 1,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Rational Expedition Android', @presenceID, 3, @definitionID, 278, 710, 0, 5, 60, 0,
                 15, 'Rational Expedition Android', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Mechanical Caretaker Technology', @presenceID, 3, @definitionID, 278, 710, 0, 5, 60, 0,
                 15, 'Mechanical Caretaker Technology', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Super Home Protection Emulator', @presenceID, 2, @definitionID, 315, 300, 0, 10, 60, 0,
                 15, 'Super Home Protection Emulator', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Digital Animal Control Machine', @presenceID, 3, @definitionID, 315, 300, 0, 10, 60, 0,
                 15, 'Digital Animal Control Machine', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Sensitive Emergency Repair Bot', @presenceID, 2, @definitionID, 580, 150, 0, 10, 60, 0,
                 15, 'Sensitive Emergency Repair Bot', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank1' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Neohuman Data Collection Drone', @presenceID, 3, @definitionID, 580, 150, 0, 10, 60, 0,
                 15, 'Neohuman Data Collection Drone', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank1' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Electronic Info Analyzing Golem', @presenceID, 2, @definitionID, 852, 247, 0, 10, 60, 0,
                 15, 'Electronic Info Analyzing Golem', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Personal Emergency Response Machine', @presenceID, 2, @definitionID, 852, 247, 0, 10, 60, 0,
                 15, 'Personal Emergency Response Machine', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('High-Powered Evasion Android', @presenceID, 4, @definitionID, 1116, 467, 0, 10, 60, 0,
                 15, 'High-Powered Evasion Android', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Rational Riot Control Juggernaut', @presenceID, 2, @definitionID, 1116, 467, 0, 10, 60, 0,
                 15, 'Rational Riot Control Juggernaut', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_gargoyle_basic_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Universal Nullification Cyborg', @presenceID, 3, @definitionID, 985, 583, 0, 10, 60, 0,
                 15, 'Universal Nullification Cyborg', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Advanced Repairation Technician', @presenceID, 4, @definitionID, 770, 710, 0, 10, 60, 0,
                 15, 'Advanced Repairation Technician', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('High-Powered Planet Exploration Juggernaut', @presenceID, 1, @definitionID, 1700, 815, 0, 10, 60, 0,
                 15, 'High-Powered Planet Exploration Juggernaut', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Universal Mapping Entity', @presenceID, 3, @definitionID, 1700, 815, 0, 10, 60, 0,
                 15, 'Universal Mapping Entity', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('General Operating Technology', @presenceID, 3, @definitionID, 1619, 215, 0, 10, 60, 0,
                 15, 'General Operating Technology', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank2' ORDER BY [definition] DESC)

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Essential Construction Prototype', @presenceID, 3, @definitionID, 1250, 520, 0, 10, 60, 0,
                 15, 'Essential Construction Prototype', 1, 1, 0, 1);


---------------------------
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('tma_cadavria3',7,7,2040,2040,'tm npc set',1,1,0,0,0,'',''
			    ,'','','',0,1,1);


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'tma_cadavria3' ORDER BY id DESC);

UPDATE [dbo].[npcpresence]
                SET [name] = 'tma_cadavria3',[topx] = 7,[topy] = 7,[bottomx] = 2040,[bottomy] = 2040,[note] = 'tm npc set',[spawnid] = 1,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Highpowered Vegetation Technician', @presenceID, 3, @definitionID, 900, 1370, 0, 5, 60, 0,
                 15, 'Highpowered Vegetation Technician', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank1' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Mechanized Space Exploration Drone', @presenceID, 5, @definitionID, 380, 1600, 0, 5, 60, 0,
                 15, 'Mechanized Space Exploration Drone', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Experimental Planetary Expedition Machine', @presenceID, 3, @definitionID, 630, 1700, 0, 5, 60, 0,
                 15, 'Experimental Planetary Expedition Machine', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Generic Flora And Fauna Prototype', @presenceID, 2, @definitionID, 165, 525, 0, 5, 60, 0,
                 15, 'Generic Flora And Fauna Prototype', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gargoyle_basic_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Artificial Planet Defence Entity', @presenceID, 2, @definitionID, 165, 525, 0, 5, 60, 0,
                 15, 'Artificial Planet Defence Entity', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Scrappie', @presenceID, 2, @definitionID, 650, 380, 0, 5, 60, 0,
                 15, 'Scrappie', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Ojv', @presenceID, 3, @definitionID, 650, 380, 0, 5, 60, 0,
                 15, 'Ojv', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ikarus_abstrans_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Strategic Docking Prototype', @presenceID, 3, @definitionID, 710, 580, 0, 5, 60, 0,
                 15, 'Strategic Docking Prototype', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Digital War Management Bot', @presenceID, 2, @definitionID, 710, 580, 0, 5, 60, 0,
                 15, 'Digital War Management Bot', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Reactive Probe Android', @presenceID, 2, @definitionID, 1040, 195, 0, 5, 60, 0,
                 15, 'Reactive Probe Android', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Humanoid Mapping Bot', @presenceID, 3, @definitionID, 1040, 195, 0, 5, 60, 0,
                 15, 'Humanoid Mapping Bot', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank1' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Greez', @presenceID, 3, @definitionID, 1400, 400, 0, 5, 60, 0,
                 15, 'Greez', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ikarus_abstrans_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Nuclear Safety Machine', @presenceID, 2, @definitionID, 655, 920, 0, 5, 60, 0,
                 15, 'Nuclear Safety Machine', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Global Science Entity', @presenceID, 2, @definitionID, 655, 920, 0, 5, 60, 0,
                 15, 'Global Science Entity', 1, 1, 0, 1);

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Integrated Animal Handling Emulator', @presenceID, 5, @definitionID, 490, 1280, 0, 5, 60, 0,
                 15, 'Integrated Animal Handling Emulator', 1, 1, 0, 1);


---------------------------
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('tma_antiafksequerscum',10,10,2038,2038,'ezek mennek a tengerparton korbe meg be',1,0,1,1800,1,'',''
			    ,'','','',0,0,1);


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'tma_antiafksequerscum' ORDER BY id DESC);

UPDATE [dbo].[npcpresence]
                SET [name] = 'tma_antiafksequerscum',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = 'ezek mennek a tengerparton korbe meg be',[spawnid] = 1,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 1800,[presencetype] = 1,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 0,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('the_joker_is_me', @presenceID, 1, @definitionID, 0, 0, 0, 10, 1800, 0,
                 70, 'the_joker_is_me', 1, 1, 1, 2);

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('the_joker_is_me2', @presenceID, 1, @definitionID, 0, 0, 0, 10, 1800, 0,
                 70, 'the_joker_is_me2', 1, 1, 1, 2);

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('the_joker_is_me3', @presenceID, 1, @definitionID, 0, 0, 0, 10, 1800, 0,
                 70, 'the_joker_is_me3', 1, 1, 1, 2);


---------------------------
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('tma_antiafksequerscum2',10,10,2038,2038,'ezek mennek a tengerparton korbe meg be',1,1,1,1800,1,'',''
			    ,'','','',0,0,1);


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'tma_antiafksequerscum2' ORDER BY id DESC);

UPDATE [dbo].[npcpresence]
                SET [name] = 'tma_antiafksequerscum2',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = 'ezek mennek a tengerparton korbe meg be',[spawnid] = 1,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 1800,[presencetype] = 1,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 0,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('roamingtmasequer', @presenceID, 1, @definitionID, 800, 940, 2, 5, 1800, 0,
                 15, 'NEW FLOCK, WRITE NOTE!', 1, 1, 1, 2);

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('roamingtmasequer2', @presenceID, 1, @definitionID, 1595, 1513, 2, 5, 1800, 0,
                 10, 'NEW FLOCK, WRITE NOTE!', 1, 1, 1, 2);

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('roamingtmasequer3', @presenceID, 1, @definitionID, 1595, 1513, 2, 5, 1800, 0,
                 10, 'NEW FLOCK, WRITE NOTE!', 1, 1, 1, 2);


---------------------------
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('tma_antiafksequerscum3',10,10,2038,2038,'ezek mennek a tengerparton korbe meg be',1,1,1,1800,1,'',''
			    ,'','','',0,0,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'tma_antiafksequerscum3' ORDER BY id DESC);

UPDATE [dbo].[npcpresence]
                SET [name] = 'tma_antiafksequerscum3',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = 'ezek mennek a tengerparton korbe meg be',[spawnid] = 1,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 1800,[presencetype] = 1,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 0,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('tmaroamingsequer6', @presenceID, 1, @definitionID, 0, 0, 0, 5, 1800, 0,
                 10, 'tmaroamingsequer6', 0, 1, 1, 2);

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('tmaroamingsequer7', @presenceID, 1, @definitionID, 0, 0, 0, 5, 1800, 0,
                 10, 'tmaroamingsequer7', 0, 1, 1, 2);

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('tmaroamingsequer8', @presenceID, 1, @definitionID, 0, 0, 0, 5, 1800, 0,
                 10, 'tmaroamingsequer8', 0, 1, 1, 2);

