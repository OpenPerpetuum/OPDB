DECLARE @presenceID int
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'random_v2_1_NEW_03_Arkhe' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'random_v2_1_NEW_03_Arkhe',[topx] = 1001,[topy] = 812,[bottomx] = 1201,[bottomy] = 1012,[note] = '',[spawnid] = 1,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 3,[maxrandomflock] = 2,[randomcenterx] = 1101,[randomcentery] = 912
                ,[randomradius] = 5,[dynamiclifetime] = '' ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;
DECLARE @flockID int;
DECLARE @definitionID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_dummy_decoy_tm' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_random_arkhe_tm_rank0_3member_120sec' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_random_arkhe_tm_rank0_3member_120sec' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 1489, [spawnoriginX] = 1123, [spawnoriginY] = 807 ,[spawnrangeMin] = 0, [spawnrangeMax] = 0,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 0, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

