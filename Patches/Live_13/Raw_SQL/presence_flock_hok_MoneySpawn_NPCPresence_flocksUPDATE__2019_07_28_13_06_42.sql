USE [perpetuumsa]
GO

------------------------------------------------
--Fix inconsistent flock counts in hokk spawn
--Date: 2019/07/28
-----------------------------------------------


DECLARE @presenceID int
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_MoneySpawn' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_MoneySpawn',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'hokk_Moneyspawn',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

DECLARE @flockID int;
DECLARE @definitionID int;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Leg_hokk_MST3' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Leg_hokk_MST3' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 1689, [spawnoriginY] = 1341 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'Leg_hokk_MST3', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Leg_hokk_MST4' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Leg_hokk_MST4' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 1689, [spawnoriginY] = 1341 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'Leg_hokk_MST4', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_callisto_buccaneer_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Callisto_hokk_MST4' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Callisto_hokk_MST4' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 1689, [spawnoriginY] = 1341 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'Callisto_hokk_MST4', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ikarus_abstrans_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'ikarus_hokk_MST4' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'ikarus_hokk_MST4' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 1689, [spawnoriginY] = 1341 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'Ikarus_hokk_MST4', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'echelon_hokk_MST4' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'echelon_hokk_MST4' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 1689, [spawnoriginY] = 1341 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'echelon_hokk_MST4', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'echelon_hokk_MST3' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'echelon_hokk_MST3' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 1689, [spawnoriginY] = 1341 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'echelon_hokk_MST3', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;


GO
