USE perpetuumsa
GO

PRINT N'Updates/Deletes of NV red roamers';
PRINT N'Update presence tma_antiafksequerscum3';
DECLARE @presenceID int
DECLARE @flockID int;
DECLARE @definitionID int;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'tma_antiafksequerscum3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'tma_antiafksequerscum3',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = 'ezek mennek a tengerparton korbe meg be',[spawnid] = 1,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 1800,[presencetype] = 1,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

PRINT N'Update flock tmaroamingsequer6 where npc was def_npc_argano_basic_rank1';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'tmaroamingsequer6' ORDER BY id DESC);

UPDATE [dbo].[npcflock] SET [name] = 'tmaroamingsequer6' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 0, [spawnoriginY] = 0 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 1800, [totalspawncount] = 0, [homerange] = 50 ,[note] = 'tmaroamingsequer6', [respawnmultiplierlow] = 0, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;


PRINT N'DELETE flock tmaroamingsequer7 where npc was def_npc_laird_basic_rank1';
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'tmaroamingsequer7' ORDER BY id DESC);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'tmaroamingsequer7' ORDER BY id DESC);

DELETE FROM [dbo].[npcflock] WHERE id=@flockID;
---DELETE!!----


PRINT N'Update presence tma_antiafksequerscum2';
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'tma_antiafksequerscum2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'tma_antiafksequerscum2',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = 'ezek mennek a tengerparton korbe meg be',[spawnid] = 1,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 1800,[presencetype] = 1,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;


PRINT N'Update flock roamingtmasequer where npc was def_npc_argano_basic_rank1';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'roamingtmasequer' ORDER BY id DESC);

UPDATE [dbo].[npcflock] SET [name] = 'roamingtmasequer' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 800, [spawnoriginY] = 940 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 1800, [totalspawncount] = 0, [homerange] = 50 ,[note] = 'NEW FLOCK, WRITE NOTE!', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;


PRINT N'DELETE flock roamingtmasequer2 where npc was def_npc_laird_basic_rank1';
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'roamingtmasequer2' ORDER BY id DESC);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'roamingtmasequer2' ORDER BY id DESC);

DELETE FROM [dbo].[npcflock] WHERE id=@flockID;
---DELETE!!----

PRINT N'Update presence tma_antiafksequerscum';
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'tma_antiafksequerscum' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'tma_antiafksequerscum',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = 'ezek mennek a tengerparton korbe meg be',[spawnid] = 1,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 1800,[presencetype] = 1,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;


PRINT N'Update flock the_joker_is_me where npc was def_npc_argano_basic_rank1';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'the_joker_is_me' ORDER BY id DESC);

UPDATE [dbo].[npcflock] SET [name] = 'the_joker_is_me' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 0, [spawnoriginY] = 0 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 1800, [totalspawncount] = 0, [homerange] = 50 ,[note] = 'the_joker_is_me', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;


PRINT N'DELETE flock the_joker_is_me2 where npc was def_npc_laird_basic_rank1';
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'the_joker_is_me2' ORDER BY id DESC);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'the_joker_is_me2' ORDER BY id DESC);

DELETE FROM [dbo].[npcflock] WHERE id=@flockID;
---DELETE!!----


GO

