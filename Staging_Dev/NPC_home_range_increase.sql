
-----------------------INCREASE HOME RANGE FROM 10 OR 15 TO 30----------------------------

DECLARE @presenceID int
DECLARE @flockID int;
DECLARE @definitionID int;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'tma_fort_donnerth' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'tma_fort_donnerth',[topx] = 7,[topy] = 7,[bottomx] = 2040,[bottomy] = 2040,[note] = 'tm npc set',[spawnid] = 1,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'argano_by_terminal' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'argano_by_terminal' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2397, [spawnoriginX] = 1120, [spawnoriginY] = 820 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'argano_by_terminal', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'sequer_by_terminal' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'sequer_by_terminal' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2402, [spawnoriginX] = 1120, [spawnoriginY] = 820 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'sequer_by_terminal', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'laird_by_terminal' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'laird_by_terminal' ,[presenceid] = @presenceID, [flockmembercount] = 4, [definition] = 2402, [spawnoriginX] = 1120, [spawnoriginY] = 920 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'laird_by_terminal', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'sequer_by_terminal2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'sequer_by_terminal2' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2397, [spawnoriginX] = 1115, [spawnoriginY] = 660 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'sequer_by_terminal2', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'locust_with_sequer' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'locust_with_sequer' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5556, [spawnoriginX] = 1115, [spawnoriginY] = 660 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'locust_with_sequer', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'vektor_in_da_hood' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'vektor_in_da_hood' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5548, [spawnoriginX] = 1045, [spawnoriginY] = 1020 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'vektor_in_da_hood', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'this_little_laird' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'this_little_laird' ,[presenceid] = @presenceID, [flockmembercount] = 4, [definition] = 2403, [spawnoriginX] = 800, [spawnoriginY] = 940 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'went_to_the_market', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'this_little_sequer' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'this_little_sequer' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2408, [spawnoriginX] = 800, [spawnoriginY] = 940 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'got_cancer', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'this_little_sequer' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'this_little_sequer' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2407, [spawnoriginX] = 1400, [spawnoriginY] = 760 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'got_the_space_aids', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_termis_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'this_little_termis' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'this_little_termis' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2413, [spawnoriginX] = 1400, [spawnoriginY] = 760 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'got_ghanked_by_an_observer', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'tma_lenworth' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'tma_lenworth',[topx] = 7,[topy] = 7,[bottomx] = 2040,[bottomy] = 2040,[note] = 'tm npc set',[spawnid] = 1,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'vektor2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'vektor2' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5549, [spawnoriginX] = 1530, [spawnoriginY] = 1670 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'vektor2', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'locust2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'locust2' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5557, [spawnoriginX] = 1530, [spawnoriginY] = 1670 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'locust2', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'vektor1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'vektor1' ,[presenceid] = @presenceID, [flockmembercount] = 4, [definition] = 5548, [spawnoriginX] = 1670, [spawnoriginY] = 1450 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'vektor1', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'locust4' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'locust4' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5557, [spawnoriginX] = 1670, [spawnoriginY] = 1450 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'locust4', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'echelon1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'echelon1' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5561, [spawnoriginX] = 1890, [spawnoriginY] = 1537 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'echelon1', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'locustr2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'locustr2' ,[presenceid] = @presenceID, [flockmembercount] = 4, [definition] = 5557, [spawnoriginX] = 1890, [spawnoriginY] = 1537 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'locustr2', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'echelon2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'echelon2' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5561, [spawnoriginX] = 1680, [spawnoriginY] = 1800 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'echelon2', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'locust5' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'locust5' ,[presenceid] = @presenceID, [flockmembercount] = 4, [definition] = 5556, [spawnoriginX] = 1680, [spawnoriginY] = 1800 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'locust5', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'locust7' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'locust7' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5557, [spawnoriginX] = 1546, [spawnoriginY] = 1637 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'locust7', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ikarus_abstrans_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'abstrans3' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'abstrans3' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5553, [spawnoriginX] = 1546, [spawnoriginY] = 1637 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'abstrans3', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'vektor10' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'vektor10' ,[presenceid] = @presenceID, [flockmembercount] = 4, [definition] = 5549, [spawnoriginX] = 1450, [spawnoriginY] = 1550 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'vektor10', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'locust8' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'locust8' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5557, [spawnoriginX] = 1150, [spawnoriginY] = 1678 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'locust8', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'indygroup5' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'indygroup5' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2398, [spawnoriginX] = 1314, [spawnoriginY] = 1268 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'indygroup5', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'indygroup6' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'indygroup6' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2403, [spawnoriginX] = 1314, [spawnoriginY] = 1268 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'indygroup6', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'indygroup7' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'indygroup7' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2408, [spawnoriginX] = 1314, [spawnoriginY] = 1268 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'indygroup7', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'indygroup8' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'indygroup8' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = 2407, [spawnoriginX] = 685, [spawnoriginY] = 1320 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'indygroup8', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_termis_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'indygroup9' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'indygroup9' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2413, [spawnoriginX] = 685, [spawnoriginY] = 1320 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'indygroup9', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'locustr23' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'locustr23' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5557, [spawnoriginX] = 295, [spawnoriginY] = 1548 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'locustr23', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'vektor123' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'vektor123' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = 5548, [spawnoriginX] = 295, [spawnoriginY] = 1548 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'vektor123', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'locust8911' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'locust8911' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5557, [spawnoriginX] = 305, [spawnoriginY] = 1763 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'locust8911', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'sequer_that_got_lost' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'sequer_that_got_lost' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2408, [spawnoriginX] = 545, [spawnoriginY] = 1820 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'i_have_cancer', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'argano_that_got_killed' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'argano_that_got_killed' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2398, [spawnoriginX] = 545, [spawnoriginY] = 1820 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'argano_that_got_killed', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'echelonr3' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'echelonr3' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5561, [spawnoriginX] = 985, [spawnoriginY] = 1765 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'echelonr3', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'locust678' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'locust678' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5557, [spawnoriginX] = 985, [spawnoriginY] = 1765 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'locust678', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'tma_cadavria3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'tma_cadavria3',[topx] = 7,[topy] = 7,[bottomx] = 2040,[bottomy] = 2040,[note] = 'tm npc set',[spawnid] = 1,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Highpowered Vegetation Technician' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Highpowered Vegetation Technician' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5557, [spawnoriginX] = 900, [spawnoriginY] = 1370 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Highpowered Vegetation Technician', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Mechanized Space Exploration Drone' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Mechanized Space Exploration Drone' ,[presenceid] = @presenceID, [flockmembercount] = 5, [definition] = 5556, [spawnoriginX] = 380, [spawnoriginY] = 1600 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Mechanized Space Exploration Drone', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Experimental Planetary Expedition Machine' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Experimental Planetary Expedition Machine' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2398, [spawnoriginX] = 630, [spawnoriginY] = 1700 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Experimental Planetary Expedition Machine', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Generic Flora And Fauna Prototype' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Generic Flora And Fauna Prototype' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2403, [spawnoriginX] = 165, [spawnoriginY] = 525 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Generic Flora And Fauna Prototype', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gargoyle_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Artificial Planet Defence Entity' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Artificial Planet Defence Entity' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2418, [spawnoriginX] = 165, [spawnoriginY] = 525 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Artificial Planet Defence Entity', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Scrappie' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Scrappie' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2398, [spawnoriginX] = 650, [spawnoriginY] = 380 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Scrappie', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Ojv' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Ojv' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2408, [spawnoriginX] = 650, [spawnoriginY] = 380 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Ojv', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ikarus_abstrans_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Strategic Docking Prototype' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Strategic Docking Prototype' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5553, [spawnoriginX] = 710, [spawnoriginY] = 580 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Strategic Docking Prototype', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Digital War Management Bot' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Digital War Management Bot' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2408, [spawnoriginX] = 710, [spawnoriginY] = 580 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Digital War Management Bot', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Reactive Probe Android' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Reactive Probe Android' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5561, [spawnoriginX] = 1040, [spawnoriginY] = 195 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Reactive Probe Android', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Humanoid Mapping Bot' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Humanoid Mapping Bot' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5557, [spawnoriginX] = 1040, [spawnoriginY] = 195 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Humanoid Mapping Bot', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Greez' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Greez' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5556, [spawnoriginX] = 1400, [spawnoriginY] = 400 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Greez', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ikarus_abstrans_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Nuclear Safety Machine' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Nuclear Safety Machine' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5553, [spawnoriginX] = 655, [spawnoriginY] = 920 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Nuclear Safety Machine', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Global Science Entity' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Global Science Entity' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2408, [spawnoriginX] = 655, [spawnoriginY] = 920 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Global Science Entity', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Integrated Animal Handling Emulator' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Integrated Animal Handling Emulator' ,[presenceid] = @presenceID, [flockmembercount] = 5, [definition] = 5549, [spawnoriginX] = 490, [spawnoriginY] = 1280 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Integrated Animal Handling Emulator', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'tma_cadavria2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'tma_cadavria2',[topx] = 7,[topy] = 7,[bottomx] = 2040,[bottomy] = 2040,[note] = 'tm npc set',[spawnid] = 1,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Rational Expedition Android' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Rational Expedition Android' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2403, [spawnoriginX] = 278, [spawnoriginY] = 710 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Rational Expedition Android', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Mechanical Caretaker Technology' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Mechanical Caretaker Technology' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2398, [spawnoriginX] = 278, [spawnoriginY] = 710 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Mechanical Caretaker Technology', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Super Home Protection Emulator' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Super Home Protection Emulator' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5557, [spawnoriginX] = 315, [spawnoriginY] = 300 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Super Home Protection Emulator', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Digital Animal Control Machine' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Digital Animal Control Machine' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5549, [spawnoriginX] = 315, [spawnoriginY] = 300 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Digital Animal Control Machine', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Sensitive Emergency Repair Bot' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Sensitive Emergency Repair Bot' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5561, [spawnoriginX] = 580, [spawnoriginY] = 150 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Sensitive Emergency Repair Bot', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Neohuman Data Collection Drone' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Neohuman Data Collection Drone' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5556, [spawnoriginX] = 580, [spawnoriginY] = 150 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Neohuman Data Collection Drone', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Electronic Info Analyzing Golem' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Electronic Info Analyzing Golem' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2407, [spawnoriginX] = 852, [spawnoriginY] = 247 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Electronic Info Analyzing Golem', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Personal Emergency Response Machine' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Personal Emergency Response Machine' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2398, [spawnoriginX] = 852, [spawnoriginY] = 247 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Personal Emergency Response Machine', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'High-Powered Evasion Android' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'High-Powered Evasion Android' ,[presenceid] = @presenceID, [flockmembercount] = 4, [definition] = 2403, [spawnoriginX] = 1116, [spawnoriginY] = 467 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'High-Powered Evasion Android', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Rational Riot Control Juggernaut' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Rational Riot Control Juggernaut' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2408, [spawnoriginX] = 1116, [spawnoriginY] = 467 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Rational Riot Control Juggernaut', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gargoyle_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Universal Nullification Cyborg' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Universal Nullification Cyborg' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2418, [spawnoriginX] = 985, [spawnoriginY] = 583 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Universal Nullification Cyborg', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Advanced Repairation Technician' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Advanced Repairation Technician' ,[presenceid] = @presenceID, [flockmembercount] = 4, [definition] = 5549, [spawnoriginX] = 770, [spawnoriginY] = 710 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Advanced Repairation Technician', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'High-Powered Planet Exploration Juggernaut' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'High-Powered Planet Exploration Juggernaut' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = 5561, [spawnoriginX] = 1700, [spawnoriginY] = 815 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'High-Powered Planet Exploration Juggernaut', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Universal Mapping Entity' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Universal Mapping Entity' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5557, [spawnoriginX] = 1700, [spawnoriginY] = 815 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Universal Mapping Entity', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'General Operating Technology' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'General Operating Technology' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5557, [spawnoriginX] = 1619, [spawnoriginY] = 215 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'General Operating Technology', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Essential Construction Prototype' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Essential Construction Prototype' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2403, [spawnoriginX] = 1250, [spawnoriginY] = 520 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Essential Construction Prototype', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'tma_cadavria' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'tma_cadavria',[topx] = 7,[topy] = 7,[bottomx] = 2040,[bottomy] = 2040,[note] = 'tm npc set',[spawnid] = 1,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'echelon_be_swinging' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'echelon_be_swinging' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5561, [spawnoriginX] = 985, [spawnoriginY] = 1765 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'echelon_be_swinging', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'locust_hung_lo' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'locust_hung_lo' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5556, [spawnoriginX] = 985, [spawnoriginY] = 1765 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'locust_hung_lo', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'weakassvektor' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'weakassvektor' ,[presenceid] = @presenceID, [flockmembercount] = 4, [definition] = 5549, [spawnoriginX] = 910, [spawnoriginY] = 1815 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'weakassvektor', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_lithus_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'lithus_swinging' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'lithus_swinging' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = 4498, [spawnoriginX] = 740, [spawnoriginY] = 1475 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'lithus_swinging', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gargoyle_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'gargoyle_hates_juice' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'gargoyle_hates_juice' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2418, [spawnoriginX] = 740, [spawnoriginY] = 1475 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'gargoyle_hates_juice', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'vektor_goat' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'vektor_goat' ,[presenceid] = @presenceID, [flockmembercount] = 4, [definition] = 5549, [spawnoriginX] = 682, [spawnoriginY] = 1136 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'vektor_goat', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'sequer_loves_grass' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'sequer_loves_grass' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2408, [spawnoriginX] = 1190, [spawnoriginY] = 1100 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'sequer_loves_grass', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'argano_rolls_up_on_you' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'argano_rolls_up_on_you' ,[presenceid] = @presenceID, [flockmembercount] = 4, [definition] = 2398, [spawnoriginX] = 1190, [spawnoriginY] = 1100 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'argano_rolls_up_on_you', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'vektor_rooterupper' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'vektor_rooterupper' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5549, [spawnoriginX] = 1415, [spawnoriginY] = 1010 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'vektor_rooterupper', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'sequer_basic_role_too' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'sequer_basic_role_too' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2408, [spawnoriginX] = 1210, [spawnoriginY] = 855 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'sequer_basic_role_too', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_termis_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'termis_be_hangingupside_down' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'termis_be_hangingupside_down' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2413, [spawnoriginX] = 1210, [spawnoriginY] = 855 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'termis_be_hangingupside_down', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'vektor_groupie' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'vektor_groupie' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5549, [spawnoriginX] = 1020, [spawnoriginY] = 698 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'vektor_groupie', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'laird_basic_group3' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'laird_basic_group3' ,[presenceid] = @presenceID, [flockmembercount] = 4, [definition] = 2403, [spawnoriginX] = 970, [spawnoriginY] = 950 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'laird_basic_group3', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'sequer_group_five' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'sequer_group_five' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2408, [spawnoriginX] = 920, [spawnoriginY] = 754 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'sequer_group_five', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'vektor_Swab_rank3' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'vektor_Swab_rank3' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5549, [spawnoriginX] = 920, [spawnoriginY] = 754 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'vektor_swab_rank3', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'renaming_cause_bler_asked_me_too' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'renaming_cause_bler_asked_me_too' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5557, [spawnoriginX] = 353, [spawnoriginY] = 835 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'renaming_cause_bler_asked_me_too', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'tma_antiafksequerscum3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'tma_antiafksequerscum3',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = 'ezek mennek a tengerparton korbe meg be',[spawnid] = 1,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 1800,[presencetype] = 1,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'tmaroamingsequer6' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'tmaroamingsequer6' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = 2397, [spawnoriginX] = 0, [spawnoriginY] = 0 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 1800, [totalspawncount] = 0, [homerange] = 50 ,[note] = 'tmaroamingsequer6', [respawnmultiplierlow] = 0, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'tmaroamingsequer7' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'tmaroamingsequer7' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = 2402, [spawnoriginX] = 0, [spawnoriginY] = 0 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 1800, [totalspawncount] = 0, [homerange] = 50 ,[note] = 'tmaroamingsequer7', [respawnmultiplierlow] = 0, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'tmaroamingsequer8' ORDER BY id DESC);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'tmaroamingsequer8' ORDER BY id DESC);
DELETE FROM [dbo].[npcflock] WHERE id=@flockID;


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'tma_antiafksequerscum2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'tma_antiafksequerscum2',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = 'ezek mennek a tengerparton korbe meg be',[spawnid] = 1,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 1800,[presencetype] = 1,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'roamingtmasequer' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'roamingtmasequer' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = 2397, [spawnoriginX] = 800, [spawnoriginY] = 940 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 1800, [totalspawncount] = 0, [homerange] = 50 ,[note] = 'NEW FLOCK, WRITE NOTE!', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'roamingtmasequer2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'roamingtmasequer2' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = 2402, [spawnoriginX] = 1595, [spawnoriginY] = 1513 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 1800, [totalspawncount] = 0, [homerange] = 50 ,[note] = 'NEW FLOCK, WRITE NOTE!', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'roamingtmasequer3' ORDER BY id DESC);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'roamingtmasequer3' ORDER BY id DESC);
DELETE FROM [dbo].[npcflock] WHERE id=@flockID;


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'tma_antiafksequerscum' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'tma_antiafksequerscum',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = 'ezek mennek a tengerparton korbe meg be',[spawnid] = 1,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 1800,[presencetype] = 1,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'the_joker_is_me' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'the_joker_is_me' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = 2397, [spawnoriginX] = 0, [spawnoriginY] = 0 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 1800, [totalspawncount] = 0, [homerange] = 50 ,[note] = 'the_joker_is_me', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'the_joker_is_me2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'the_joker_is_me2' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = 2402, [spawnoriginX] = 0, [spawnoriginY] = 0 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 1800, [totalspawncount] = 0, [homerange] = 50 ,[note] = 'the_joker_is_me2', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'the_joker_is_me3' ORDER BY id DESC);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'the_joker_is_me3' ORDER BY id DESC);
DELETE FROM [dbo].[npcflock] WHERE id=@flockID;


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_theolodical_npcs' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'hershfield_theolodical_npcs',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_prometheus_interceptor_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'prom_at_spawn31' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'prom_at_spawn31' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 1160, [spawnoriginX] = 740, [spawnoriginY] = 550 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'prom_at_spawn31', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_intakt_ewjammer_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'intakt_at_spawn32' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'intakt_at_spawn32' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1165, [spawnoriginX] = 620, [spawnoriginY] = 720 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'intakt_at_spawn32', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_baphomet_dps_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'baph_at_spawn32' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'baph_at_spawn32' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1185, [spawnoriginX] = 620, [spawnoriginY] = 720 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'baph_at_spawn32', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_prometheus_dps_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'prom_at_spwn33' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'prom_at_spwn33' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 1156, [spawnoriginX] = 520, [spawnoriginY] = 920 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'prom_at_spwn33', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_intakt_ewjammer_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'intakt_at_spwn33' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'intakt_at_spwn33' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1166, [spawnoriginX] = 520, [spawnoriginY] = 920 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'intakt_at_spwn33', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_baphomet_scout_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'baph_at_spwn34' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'baph_at_spwn34' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1180, [spawnoriginX] = 455, [spawnoriginY] = 740 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'baph_at_spwn34', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_tank_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'art_at_spwn35' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'art_at_spwn35' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 1205, [spawnoriginX] = 820, [spawnoriginY] = 320 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'art_at_spwn35', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_intakt_heavyew_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'intakt_at_spwn35' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'intakt_at_spwn35' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1170, [spawnoriginX] = 820, [spawnoriginY] = 320 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'intakt_at_spwn35', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_heavydps_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'hm_at_spawn36' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'hm_at_spawn36' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 1216, [spawnoriginX] = 600, [spawnoriginY] = 430 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'hm_at_spawn36', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_ew_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mech_at_spawn36' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mech_at_spawn36' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1201, [spawnoriginX] = 600, [spawnoriginY] = 430 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mech_at_spawn36', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_sniper_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'sethsnip_at_spawn37' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'sethsnip_at_spawn37' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1211, [spawnoriginX] = 430, [spawnoriginY] = 540 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'sethsnip_at_spawn37', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_tank_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'sethtank_at_spawn37' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'sethtank_at_spawn37' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1226, [spawnoriginX] = 430, [spawnoriginY] = 540 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'sethtank_at_spawn37', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_zenith_heavyew_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mechew_at_spawn37' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mechew_at_spawn37' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2019, [spawnoriginX] = 430, [spawnoriginY] = 540 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mechew_at_spawn37', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_zenith_heavyew_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mechew_at_spawn38' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mechew_at_spawn38' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2019, [spawnoriginX] = 550, [spawnoriginY] = 250 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mechew_at_spawn38', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_dps_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'art_at_spwn38' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'art_at_spwn38' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1194, [spawnoriginX] = 550, [spawnoriginY] = 250 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'art_at_spwn38', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_heavydps_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'hm_at_spwn39' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'hm_at_spwn39' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 1216, [spawnoriginX] = 260, [spawnoriginY] = 650 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'hm_at_spwn39', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_sniper_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'hm2_at_spwn39' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'hm2_at_spwn39' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = 1211, [spawnoriginX] = 260, [spawnoriginY] = 650 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'hm2_spwn39', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_zenith_heavyew_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mechew_at_spwn39' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mechew_at_spwn39' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2019, [spawnoriginX] = 260, [spawnoriginY] = 650 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mechew_at_spwn39', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_baphomet_dps_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'bapho_at_spwn30' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'bapho_at_spwn30' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1184, [spawnoriginX] = 385, [spawnoriginY] = 300 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'bapho_at_spwn30', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_dps_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mech_at_spwn30' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mech_at_spwn30' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1194, [spawnoriginX] = 385, [spawnoriginY] = 300 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mech_at_spwn30', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_syndicate_npcs' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'hershfield_syndicate_npcs',[topx] = 959,[topy] = 283,[bottomx] = 1159,[bottomy] = 483,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mech_at_spawn1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mech_at_spawn1' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5562, [spawnoriginX] = 1590, [spawnoriginY] = 1550 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mech_at_spawn1', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'hm_at_spawn1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'hm_at_spawn1' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5566, [spawnoriginX] = 1590, [spawnoriginY] = 1550 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'hm_at_spawn1', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'assault_at_spawn2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'assault_at_spawn2' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5558, [spawnoriginX] = 1370, [spawnoriginY] = 1720 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'assault_at_spawn2', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'light_at_spawn2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'light_at_spawn2' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5550, [spawnoriginX] = 864, [spawnoriginY] = 962 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'light_at_spawn2', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'hm_at_spawn3' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'hm_at_spawn3' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5567, [spawnoriginX] = 1080, [spawnoriginY] = 1870 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'hm_at_spawn3', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mech_at_spawn3' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mech_at_spawn3' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5561, [spawnoriginX] = 1080, [spawnoriginY] = 1870 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mech_at_spawn3', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mech_at_spawn4' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mech_at_spawn4' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5563, [spawnoriginX] = 1410, [spawnoriginY] = 1090 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mech_at_spawn4', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'light_at_spawn4' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'light_at_spawn4' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5551, [spawnoriginX] = 1410, [spawnoriginY] = 1090 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'light_at_spawn4', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'hm_at_spawn5' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'hm_at_spawn5' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5565, [spawnoriginX] = 1170, [spawnoriginY] = 1020 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'hm_at_spawn5', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'assault_at_spawn_6' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'assault_at_spawn_6' ,[presenceid] = @presenceID, [flockmembercount] = 4, [definition] = 5559, [spawnoriginX] = 1350, [spawnoriginY] = 780 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'assault_at_spawn6', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ikarus_abstrans_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'lighttrans_at_spawn6' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'lighttrans_at_spawn6' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5555, [spawnoriginX] = 1350, [spawnoriginY] = 780 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'lighttrans_at_spawn6', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mech_at_spawn7' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mech_at_spawn7' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5561, [spawnoriginX] = 940, [spawnoriginY] = 1111 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mech_at_spawn7', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'light_at_spawn8' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'light_at_spawn8' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5550, [spawnoriginX] = 760, [spawnoriginY] = 935 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'light_at_spawn8', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'assault_at_spawn9' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'assault_at_spawn9' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5558, [spawnoriginX] = 940, [spawnoriginY] = 590 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'assault_at_spawn9', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'light_at_spawn10' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'light_at_spawn10' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5559, [spawnoriginX] = 1160, [spawnoriginY] = 640 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'light_at_spawn10', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_pelistal_npcs' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'hershfield_pelistal_npcs',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_castel_scout_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'castel_at_spawn21' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'castel_at_spawn21' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 1314, [spawnoriginX] = 1290, [spawnoriginY] = 1410 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'castel_at_21', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_troiar_interceptor_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'troiar_at_spawn22' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'troiar_at_spawn22' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1335, [spawnoriginX] = 1180, [spawnoriginY] = 1490 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'troiar_at_spawn22', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_waspish_dps_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'wasp_at_spn22' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'wasp_at_spn22' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1349, [spawnoriginX] = 1180, [spawnoriginY] = 1490 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'wasp_at_spn22', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_castel_dps_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'castel_at_spn23' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'castel_at_spn23' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 1320, [spawnoriginX] = 1030, [spawnoriginY] = 1390 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'castel_at_spn23', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_troiar_ewjammer_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'troiar_at_spn23' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'troiar_at_spn23' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1330, [spawnoriginX] = 1030, [spawnoriginY] = 1390 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'troiar_at_spn23', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_waspish_scout_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'wasp_at_spn24' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'wasp_at_spn24' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 1344, [spawnoriginX] = 940, [spawnoriginY] = 1500 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'def_npc_waspish_scout_rank3', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_tank_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mech_at_spn25' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mech_at_spn25' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 1369, [spawnoriginX] = 740, [spawnoriginY] = 1450 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'def_npc_tyrannos_tank_rank3', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_troiar_heavyew_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'lew_at_spn25' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'lew_at_spn25' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1339, [spawnoriginX] = 740, [spawnoriginY] = 1450 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'lew_at_spn25', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_heavydps_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'hm_at_spwn26' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'hm_at_spwn26' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 1380, [spawnoriginX] = 600, [spawnoriginY] = 1485 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'hm_at_spwn26', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_ew_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mech_at_spwn26' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mech_at_spwn26' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1365, [spawnoriginX] = 600, [spawnoriginY] = 1485 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mech_at_spwn26', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_sniper_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'hm_at_spwn27' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'hm_at_spwn27' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1375, [spawnoriginX] = 690, [spawnoriginY] = 1700 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'hm_at_spn27', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_tank_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'hm2_spwn27' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'hm2_spwn27' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1390, [spawnoriginX] = 690, [spawnoriginY] = 1700 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'hm2_spwn27', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ictus_heavyew_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mech_spwn27' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mech_spwn27' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2044, [spawnoriginX] = 690, [spawnoriginY] = 1700 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mech_spwn27', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ictus_heavyew_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mech_spwn28' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mech_spwn28' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2044, [spawnoriginX] = 500, [spawnoriginY] = 1730 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mech_spwn28', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_dps_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mech2_spwn28' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mech2_spwn28' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1358, [spawnoriginX] = 500, [spawnoriginY] = 1730 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mech2_spwn28', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_heavydps_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'hm1_atspwn29' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'hm1_atspwn29' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 1380, [spawnoriginX] = 400, [spawnoriginY] = 1560 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'hm1_at_spn29', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_sniper_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'hm2_at_spwn29' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'hm2_at_spwn29' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = 1375, [spawnoriginX] = 400, [spawnoriginY] = 1560 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'hm2_at_spwn29', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ictus_heavyew_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mech_at_spwn29' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mech_at_spwn29' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2044, [spawnoriginX] = 400, [spawnoriginY] = 1560 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mech_at_spwn29', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_waspish_dps_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'assault_at_spwn30' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'assault_at_spwn30' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1348, [spawnoriginX] = 240, [spawnoriginY] = 1700 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'assault_at_spwn30', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_dps_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mech_at_spwn30' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mech_at_spwn30' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1358, [spawnoriginX] = 240, [spawnoriginY] = 1700 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mech_at_spawn30', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_numiquol_npcs' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'hershfield_numiquol_npcs',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_scout_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'yagel_at_spawn41' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'yagel_at_spawn41' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 1234, [spawnoriginX] = 1510, [spawnoriginY] = 620 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'yagel_at_spawn41', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_cameleon_interceptor_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'cam_at_spawn42' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'cam_at_spawn42' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1259, [spawnoriginX] = 1540, [spawnoriginY] = 450 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'cam_at_spawn42', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_dps_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'arby_at_spawn42' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'arby_at_spawn42' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1269, [spawnoriginX] = 1540, [spawnoriginY] = 450 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'arby_at_spwn42', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_dps_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'yagel_at_spawn43' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'yagel_at_spawn43' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 1240, [spawnoriginX] = 1350, [spawnoriginY] = 320 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'yagel_at_spawn43', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_cameleon_ewjammer_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'cam_at_spawn43' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'cam_at_spawn43' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1250, [spawnoriginX] = 1350, [spawnoriginY] = 320 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'cam_at_spawn43', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_scout_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'arby_at_spwn44' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'arby_at_spwn44' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 1264, [spawnoriginX] = 1260, [spawnoriginY] = 420 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'arby_at_spawn44', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_tank_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'kain_at_spawn45' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'kain_at_spawn45' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 1289, [spawnoriginX] = 1170, [spawnoriginY] = 420 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'kain_at_spawn45', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_cameleon_heavyew_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'cam_at_spawn45' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'cam_at_spawn45' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1254, [spawnoriginX] = 1170, [spawnoriginY] = 420 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'cam_at_spawn45', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_heavydps_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mesmer_at_spawn46' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mesmer_at_spawn46' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 1300, [spawnoriginX] = 1030, [spawnoriginY] = 380 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mesmer_at_spawn46', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_ew_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'kain_at_spawn46' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'kain_at_spawn46' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1285, [spawnoriginX] = 1030, [spawnoriginY] = 380 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'kain_at_spawn46', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_sniper_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mesmer_at_spawn47' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mesmer_at_spawn47' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1295, [spawnoriginX] = 1320, [spawnoriginY] = 540 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mesmer_at_spawn47', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_tank_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mesmer2_at_spawn47' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mesmer2_at_spawn47' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1310, [spawnoriginX] = 1320, [spawnoriginY] = 540 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mesmer2_at_spawn47', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vagabond_heavyew_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'vag_at_spawn47' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'vag_at_spawn47' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2014, [spawnoriginX] = 1320, [spawnoriginY] = 540 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'vag_at_span47', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vagabond_heavyew_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'vag_at_spawn48' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'vag_at_spawn48' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2014, [spawnoriginX] = 1470, [spawnoriginY] = 290 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'vag_at_spawn48', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_dps_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'kain_at_spawn48' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'kain_at_spawn48' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1278, [spawnoriginX] = 1470, [spawnoriginY] = 290 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'kain_at_spawn48', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_heavydps_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mesmer_at_spawn49' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mesmer_at_spawn49' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 1300, [spawnoriginX] = 1290, [spawnoriginY] = 280 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mesmer_at_spawn49', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_sniper_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mesmer2_at_spawn49' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mesmer2_at_spawn49' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = 1295, [spawnoriginX] = 1290, [spawnoriginY] = 280 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mesmer_at_spawn49', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vagabond_heavyew_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'vag_at_spawn49' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'vag_at_spawn49' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2014, [spawnoriginX] = 1290, [spawnoriginY] = 280 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'vag_at_spawn49', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_dps_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'arby_at_50' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'arby_at_50' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1268, [spawnoriginX] = 1320, [spawnoriginY] = 190 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'arby_at_spawn50', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_dps_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'kain_at_50' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'kain_at_50' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1278, [spawnoriginX] = 1320, [spawnoriginY] = 190 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'kain_at_50', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_industrials_npcs' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'hershfield_industrials_npcs',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_symbiont_basic_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'hmindy_at_spawn11' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'hmindy_at_spawn11' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2429, [spawnoriginX] = 1580, [spawnoriginY] = 1710 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'hmindy_at_spawn11', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'hm2indy_at_spawn11' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'hm2indy_at_spawn11' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 4504, [spawnoriginX] = 1580, [spawnoriginY] = 1710 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'hmindy_st_spawn11', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_lithus_basic_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'hmindy_at_spawn12' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'hmindy_at_spawn12' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 4500, [spawnoriginX] = 1770, [spawnoriginY] = 1720 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'hmindy_st_spawn12', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_riveler_basic_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'hm2indy_at_spawn12' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'hm2indy_at_spawn12' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2425, [spawnoriginX] = 1770, [spawnoriginY] = 1720 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'hmindy_at_spawn12', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_symbiont_basic_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'hmindy_at_spawn13' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'hmindy_at_spawn13' ,[presenceid] = @presenceID, [flockmembercount] = 4, [definition] = 2430, [spawnoriginX] = 1765, [spawnoriginY] = 1710 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'hmindy_at_spawn13', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gargoyle_basic_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mechindy_st_spawn14' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mechindy_st_spawn14' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2420, [spawnoriginX] = 1580, [spawnoriginY] = 800 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mechindy_at_spawn14', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'assaultindy_at_spawn14' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'assaultindy_at_spawn14' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2410, [spawnoriginX] = 1580, [spawnoriginY] = 800 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'assaultindy_at_spawn14', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_termis_basic_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mechindy_at_spawn15' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mechindy_at_spawn15' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2415, [spawnoriginX] = 1730, [spawnoriginY] = 990 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mechindy_at_apawn15', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_lithus_basic_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'hmindy_at_spawn15' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'hmindy_at_spawn15' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 4500, [spawnoriginX] = 1730, [spawnoriginY] = 990 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'hmindy_at_spawn15', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ikarus_abstrans_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'indy_at_spawn16' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'indy_at_spawn16' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5555, [spawnoriginX] = 1760, [spawnoriginY] = 1270 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'indy_at_spawn16', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'lightindy_at_spawn16' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'lightindy_at_spawn16' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2405, [spawnoriginX] = 1760, [spawnoriginY] = 1270 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'laird_at_16', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'lightindy2_at_spawn16' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'lightindy2_at_spawn16' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2400, [spawnoriginX] = 1760, [spawnoriginY] = 1270 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'argano_at_16', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_termis_basic_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mechspwan_at_17' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mechspwan_at_17' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2415, [spawnoriginX] = 1410, [spawnoriginY] = 1240 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mechspawn_at_17', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gargoyle_basic_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mechspawn_at_18' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mechspawn_at_18' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2420, [spawnoriginX] = 1190, [spawnoriginY] = 820 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mechspawn_at_18', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_lithus_basic_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'hmindy_at_spawn19' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'hmindy_at_spawn19' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 4500, [spawnoriginX] = 700, [spawnoriginY] = 1120 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'hmindy_at_spawn19', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_riveler_basic_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'hmindy_at_spawn20' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'hmindy_at_spawn20' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2425, [spawnoriginX] = 1600, [spawnoriginY] = 1200 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'hmindy_at_20', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_symbiont_basic_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'hmindy2_at_spawn20' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'hmindy2_at_spawn20' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2430, [spawnoriginX] = 1600, [spawnoriginY] = 1200 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'hmindy2_at_spawn20', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_grandobservers3_npcs' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'hershfield_grandobservers3_npcs',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = 'caravan',[spawnid] = 13,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 7200,[presencetype] = 1,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_roaming_waspish_alpha' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'waspish_grand_observer' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'waspish_grand_observer' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2873, [spawnoriginX] = 849, [spawnoriginY] = 560 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 7200, [totalspawncount] = 0, [homerange] = 50 ,[note] = 'waspish_grand_observer', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_grandobservers2_npcs' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'hershfield_grandobservers2_npcs',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = 'caravan',[spawnid] = 13,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 7200,[presencetype] = 1,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_roaming_baphomet_alpha' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'baph_grand_observer' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'baph_grand_observer' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2872, [spawnoriginX] = 849, [spawnoriginY] = 560 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 7200, [totalspawncount] = 0, [homerange] = 50 ,[note] = 'baph_grand_observer', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_grandobservers_npcs' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'hershfield_grandobservers_npcs',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = 'caravan',[spawnid] = 13,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 7200,[presencetype] = 1,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_roaming_arbalest_alpha' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'arby_grand_observer' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'arby_grand_observer' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2871, [spawnoriginX] = 849, [spawnoriginY] = 560 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 7200, [totalspawncount] = 0, [homerange] = 50 ,[note] = 'grand_observer', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

