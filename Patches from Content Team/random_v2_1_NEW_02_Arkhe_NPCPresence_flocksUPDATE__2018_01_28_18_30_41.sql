DECLARE @presenceID int
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'random_v2_1_NEW_02_Arkhe' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'random_v2_1_NEW_02_Arkhe',[topx] = 1023,[topy] = 710,[bottomx] = 1223,[bottomy] = 910,[note] = '',[spawnid] = 1,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 3,[maxrandomflock] = 2,[randomcenterx] = 1123,[randomcentery] = 810
                ,[randomradius] = 5,[dynamiclifetime] = '' ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;
DECLARE @flockID int;
DECLARE @definitionID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_dummy_decoy' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_random_arkhe_basic_rank0_3member_60sec' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_random_arkhe_basic_rank0_3member_60sec' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 1473, [spawnoriginX] = 1123, [spawnoriginY] = 808 ,[spawnrangeMin] = 0, [spawnrangeMax] = 0,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 0, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

