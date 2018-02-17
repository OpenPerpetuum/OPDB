USE [perpetuumsa]
GO



---Makes the sparks locked by ancient data consoles and from purchasable amazon packs obtainable under a 25 million nic cost 
---makes it so the OP 5% sparks are behind a 50 Million Nic Barrier
PRINT N'Spark cost increases'


UPDATE [dbo].[sparks]
   SET [sparkname] = 'spark_anniversary_combat'
      ,[unlockprice] = 25000000
      ,[energycredit] = NULL
      ,[standinglimit] = NULL
      ,[definition] = NULL
      ,[quantity] = NULL
      ,[changeprice] = 1000000
      ,[displayorder] = 511
      ,[defaultspark] = 0
      ,[icon] = 'icon_spark_anniversary_combat'
      ,[hidden] = 0
      ,[note] = NULL
      ,[allianceeid] = NULL
      ,[alliancename] = NULL
      ,[unlockable] = 1
 WHERE sparkname= 'spark_anniversary_combat'

UPDATE [dbo].[sparks]
   SET [sparkname] = 'spark_anniversary_logistic'
      ,[unlockprice] = 25000000
      ,[energycredit] = NULL
      ,[standinglimit] = NULL
      ,[definition] = NULL
      ,[quantity] = NULL
      ,[changeprice] = 1000000
      ,[displayorder] = 512
      ,[defaultspark] = 0
      ,[icon] = 'icon_spark_anniversary_indy'
      ,[hidden] = 0
      ,[note] = NULL
      ,[allianceeid] = NULL
      ,[alliancename] = NULL
      ,[unlockable] = 1
 WHERE sparkname= 'spark_anniversary_logistic'

UPDATE [dbo].[sparks]
   SET [sparkname] = 'spark_amazon_c1_combat'
      ,[unlockprice] = 25000000
      ,[energycredit] = NULL
      ,[standinglimit] = NULL
      ,[definition] = NULL
      ,[quantity] = NULL
      ,[changeprice] = 1000000
      ,[displayorder] = 521
      ,[defaultspark] = 0
      ,[icon] = 'icon_spark_amazon_c1_combat'
      ,[hidden] = 0
      ,[note] = NULL
      ,[allianceeid] = NULL
      ,[alliancename] = NULL
      ,[unlockable] = 1
 WHERE sparkname= 'spark_amazon_c1_combat'

UPDATE [dbo].[sparks]
   SET [sparkname] = 'spark_amazon_c1_indy'
      ,[unlockprice] = 25000000
      ,[energycredit] = NULL
      ,[standinglimit] = NULL
      ,[definition] = NULL
      ,[quantity] = NULL
      ,[changeprice] = 1000000
      ,[displayorder] = 522
      ,[defaultspark] = 0
      ,[icon] = 'icon_spark_amazon_c1_indy'
      ,[hidden] = 0
      ,[note] = NULL
      ,[allianceeid] = NULL
      ,[alliancename] = NULL
      ,[unlockable] = 1
 WHERE sparkname= 'spark_amazon_c1_indy'

UPDATE [dbo].[sparks]
   SET [sparkname] = 'spark_steam_a'
      ,[unlockprice] = 50000000
      ,[energycredit] = NULL
      ,[standinglimit] = NULL
      ,[definition] = NULL
      ,[quantity] = NULL
      ,[changeprice] = 1000000
      ,[displayorder] = 531
      ,[defaultspark] = 0
      ,[icon] = 'icon_spark_steam_a'
      ,[hidden] = 0
      ,[note] = NULL
      ,[allianceeid] = NULL
      ,[alliancename] = NULL
      ,[unlockable] = 1
 WHERE sparkname= 'spark_steam_a'

UPDATE [dbo].[sparks]
   SET [sparkname] = 'spark_steam_b'
      ,[unlockprice] = 50000000
      ,[energycredit] = NULL
      ,[standinglimit] = NULL
      ,[definition] = NULL
      ,[quantity] = NULL
      ,[changeprice] = 1000000
      ,[displayorder] = 532
      ,[defaultspark] = 0
      ,[icon] = 'icon_spark_steam_b'
      ,[hidden] = 0
      ,[note] = NULL
      ,[allianceeid] = NULL
      ,[alliancename] = NULL
      ,[unlockable] = 1
 WHERE sparkname= 'spark_steam_b'
GO

------------Moves this spawn so it won't spawn in the wall-------------
PRINT N'Move Spawn'

DECLARE @presenceID int
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_industrials_npcs' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'hershfield_industrials_npcs',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;
DECLARE @flockID int;
DECLARE @definitionID int;
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
UPDATE [dbo].[npcflock] SET [name] = 'hmindy_at_spawn13' ,[presenceid] = @presenceID, [flockmembercount] = 4, [definition] = 2430, [spawnoriginX] = 1770, [spawnoriginY] = 1720 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'hmindy_at_spawn13', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
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
GO


---------Moves probability of Missle launcher drop to 0 and T3 small repair to 0--------------
PRINT N'Drop probabilities on def_npc_echelon_masterdeathdealer_rank2 loot'

DECLARE @definitionID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank2' ORDER BY definition DESC);
DECLARE @lootdefinitionID int;
DECLARE @npclootID int;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_exp_armor_hardener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_missile_launcher' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_medium_lasercrystal_a' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=20, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_armor_repairer_upgrade' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_eccm' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5, [probability]=0.5, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_thelodica_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5, [probability]=0, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_1' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_2' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_thelodica_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=120, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=97 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=96, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=64 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_thelodica' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=48, [probability]=0, [repackaged]=0, [dontdamage]=1, [minquantity]=32 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_small_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=0 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=120, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=97 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=0 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=0 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_sensor_booster' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=0 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_eccm' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=0 WHERE [id]=@npclootID;
GO