DECLARE @presenceID int
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'training_shooting_range_presence' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'training_shooting_range_presence',[topx] = 20,[topy] = 20,[bottomx] = 1000,[bottomy] = 1000,[note] = '',[spawnid] = 48,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 3,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;
DECLARE @flockID int;
DECLARE @definitionID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_dummy_decoy' ORDER BY definition DESC);
UPDATE [dbo].[npcflock] SET [name] = 'training_flock_a' ,[presenceid] = @presenceID, [flockmembercount] = 20, [definition] = 1473, [spawnoriginX] = 676, [spawnoriginY] = 414 ,[spawnrangeMin] = 10, [spawnrangeMax] = 20,[respawnseconds] = 0, [totalspawncount] = 0, [homerange] = 30 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_training' ORDER BY definition DESC);
UPDATE [dbo].[npcflock] SET [name] = 'training_flock_scarab' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5334, [spawnoriginX] = 713, [spawnoriginY] = 406 ,[spawnrangeMin] = 1, [spawnrangeMax] = 2,[respawnseconds] = 0, [totalspawncount] = 0, [homerange] = 2 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;

