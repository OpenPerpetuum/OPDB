DECLARE @presenceID int
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'tma_fort_donnerth' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'tma_fort_donnerth',[topx] = 7,[topy] = 7,[bottomx] = 2040,[bottomy] = 2040,[note] = 'tm npc set',[spawnid] = 1,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;
DECLARE @flockID int;
DECLARE @definitionID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'argano_by_terminal' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'argano_by_terminal' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2397, [spawnoriginX] = 1120, [spawnoriginY] = 820 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 15 ,[note] = 'argano_by_terminal', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'sequer_by_terminal' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'sequer_by_terminal' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2402, [spawnoriginX] = 1120, [spawnoriginY] = 820 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 15 ,[note] = 'sequer_by_terminal', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'laird_by_terminal' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'laird_by_terminal' ,[presenceid] = @presenceID, [flockmembercount] = 4, [definition] = 2402, [spawnoriginX] = 1120, [spawnoriginY] = 920 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 15 ,[note] = 'laird_by_terminal', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'sequer_by_terminal2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'sequer_by_terminal2' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2397, [spawnoriginX] = 1115, [spawnoriginY] = 660 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 15 ,[note] = 'sequer_by_terminal2', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'locust_with_sequer' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'locust_with_sequer' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5556, [spawnoriginX] = 1115, [spawnoriginY] = 660 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 15 ,[note] = 'locust_with_sequer', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'vektor_in_da_hood' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'vektor_in_da_hood' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5548, [spawnoriginX] = 1045, [spawnoriginY] = 1020 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 15 ,[note] = 'vektor_in_da_hood', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'this_little_laird' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'this_little_laird' ,[presenceid] = @presenceID, [flockmembercount] = 4, [definition] = 2403, [spawnoriginX] = 800, [spawnoriginY] = 940 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 15 ,[note] = 'went_to_the_market', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'this_little_sequer' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'this_little_sequer' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2397, [spawnoriginX] = 800, [spawnoriginY] = 940 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 15 ,[note] = 'got_cancer', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'this_little_sequer' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'this_little_sequer' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2407, [spawnoriginX] = 1400, [spawnoriginY] = 760 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 15 ,[note] = 'got_the_space_aids', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_termis_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'this_little_termis' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'this_little_termis' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2413, [spawnoriginX] = 1400, [spawnoriginY] = 760 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 15 ,[note] = 'got_ghanked_by_an_observer', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;

