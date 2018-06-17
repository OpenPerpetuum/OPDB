USE [perpetuumsa]
GO

DECLARE @presenceID int
DECLARE @flockID int;
DECLARE @definitionID int;

---numiquol on hershfield respawn timer 30 seconds to 60 seconds
PRINT N'numiquol on hershfield respawn timer 30 seconds to 60 seconds';

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Hershfield numi Solo Spawn 1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Hershfield numi Solo Spawn 1',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_cameleon_interceptor_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Cam_hersh_solospawn1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Cam_hersh_solospawn1' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1373, [spawnoriginY] = 437 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'Cam_hersh_solospawn1', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_dps_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'yagel_hersh_solospawn1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'yagel_hersh_solospawn1' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1373, [spawnoriginY] = 437 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'yagel_hersh_solospawn1', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Hershfield numi Solo Spawn 2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Hershfield numi Solo Spawn 2',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_dps_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'arby_hersh_solospawn2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'arby_hersh_solospawn2' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1395, [spawnoriginY] = 700 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'arby_hersh_solospawn2', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_dps_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'yagel_hersh_solospawn2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'yagel_hersh_solospawn2' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1395, [spawnoriginY] = 700 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'yagel_hersh_solospawn2', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Hershfield numi Solo Spawn 3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Hershfield numi Solo Spawn 3',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_dps_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'kain_hersh_solospawn3' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'kain_hersh_solospawn3' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1254, [spawnoriginY] = 704 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'kain_hersh_solospawn3', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vagabond_jammer_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'vagabond_hersh_solospawn3' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'vagabond_hersh_solospawn3' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1254, [spawnoriginY] = 704 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'vaga_hersh_solospawn3', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Hershfield numi Solo Spawn 4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Hershfield numi Solo Spawn 4',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_hybrid_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mesmer_hersh_solospawn4' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mesmer_hersh_solospawn4' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = @definitionID, [spawnoriginX] = 1056, [spawnoriginY] = 566 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'mesmer_hersh_solospawn4', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;


---Pelistal on Hershfield respawn timer 30 seconds to 60 seconds
PRINT N'Pelistal on Hershfield respawn timer 30 seconds to 60 seconds';
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Hershfield Pelistal Solo Spawn 1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Hershfield Pelistal Solo Spawn 1',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ictus_dps_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Ictus_at_solo1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Ictus_at_solo1' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1122, [spawnoriginY] = 1409 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'Ictus_at_solo1', [respawnmultiplierlow] = 0, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_dps_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Tyra_at_solo1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Tyra_at_solo1' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1122, [spawnoriginY] = 1409 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'Tyro_at_solo1', [respawnmultiplierlow] = 0, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Hershfield Pelistal Solo Spawn 2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Hershfield Pelistal Solo Spawn 2',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_waspish_dps_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Wasp_Pelistal_solo2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Wasp_Pelistal_solo2' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 840, [spawnoriginY] = 1621 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'Wasp_Pelistal_solo2', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_castel_dps_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'castel_Pelistal_solo2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'castel_Pelistal_solo2' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 840, [spawnoriginY] = 1621 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'Castel_pelistal_solo2', [respawnmultiplierlow] = 0, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Hershfield Pelistal Solo Spawn 3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Hershfield Pelistal Solo Spawn 3',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_hybrid_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Gropho_Pelistal_Hersh_Solo3' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Gropho_Pelistal_Hersh_Solo3' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = @definitionID, [spawnoriginX] = 835, [spawnoriginY] = 1513 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'Gropho_Pelistal_Hersh_Solo3', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Hershfield Pelistal Solo Spawn 4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Hershfield Pelistal Solo Spawn 4',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_troiar_interceptor_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'troiar_hersh_solo4' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'troiar_hersh_solo4' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 752, [spawnoriginY] = 1578 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'troiar_hersh_solo4', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_castel_dps_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'castel_Hersh_solo4' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'castel_Hersh_solo4' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 752, [spawnoriginY] = 1578 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'castel_Hersh_solo4', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

---Theo Solo spawn on Hershfield respawn timer 30 seconds to 60 seconds
PRINT N'Theo Solo spawn on Hershfield respawn timer 30 seconds to 60 seconds';
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Hershfield theo Solo Spawn 1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Hershfield theo Solo Spawn 1',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_intakt_interceptor_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'intakt_Hersh_theo_spawn1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'intakt_Hersh_theo_spawn1' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 642, [spawnoriginY] = 881 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'intakt_Hersh_theo_spawn1', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_prometheus_scout_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'prom_Hersh_theo_spawn1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'prom_Hersh_theo_spawn1' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 642, [spawnoriginY] = 881 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'prom_Hersh_theo_spawn1', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Hershfield theo Solo Spawn 2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Hershfield theo Solo Spawn 2',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_baphomet_scout_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'baph_hersh_theo_spawn2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'baph_hersh_theo_spawn2' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 702, [spawnoriginY] = 768 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'baph_hersh_theo_spawn2', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_prometheus_scout_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'prom_Hersh_theo_spawn2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'prom_Hersh_theo_spawn2' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 702, [spawnoriginY] = 768 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'prom_Hersh_theo_spawn2', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Hershfield theo Solo Spawn 3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Hershfield theo Solo Spawn 3',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_dps_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'arty_hersh_theo_spawn3' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'arty_hersh_theo_spawn3' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 754, [spawnoriginY] = 459 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'arty_hersh_theo_spawn3', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_zenith_dps_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'zenith_hersh_theo_spawn3' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'zenith_hersh_theo_spawn3' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 754, [spawnoriginY] = 459 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'zenith_hersh_theo_spawn3', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Hershfield theo Solo Spawn 4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Hershfield theo Solo Spawn 4',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_hybrid_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'seth_hersh_theo_spawn4' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'seth_hersh_theo_spawn4' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = @definitionID, [spawnoriginX] = 340, [spawnoriginY] = 785 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'seth_hersh_theo_spawn4', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;



GO
