USE [perpetuumsa]
GO


DECLARE @presenceID int;
DECLARE @flockID int;
DECLARE @definitionID int;
DECLARE @robottemplateid int;
DECLARE @lootdefinitionID int;
DECLARE @npclootID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;



-----------------------
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'stronghold1_presence2' ORDER BY id DESC);
UPDATE [dbo].[npcpresence]
                SET [name] = 'stronghold1_presence2',[topx] = 0,[topy] = 0,[bottomx] = 2000,[bottomy] = 2000,[note] = 'main container for flox',[spawnid] = 21,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_guard' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from [npcflock] WHERE [name] = 'kain_protector_stronghold1' ORDER BY [name] DESC);
UPDATE [dbo].[npcflock] SET [name] = 'kain_protector_stronghold1'
                ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 994, [spawnoriginY] = 1013
               ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 20
               ,[note] = 'kain_protector_stronghold1', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;



-----------------------

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'stronghold1_presence3' ORDER BY id DESC);
UPDATE [dbo].[npcpresence]
                SET [name] = 'stronghold1_presence3',[topx] = 1020,[topy] = 940,[bottomx] = 1025,[bottomy] = 950,[note] = '',[spawnid] = 21,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_guard' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from [npcflock] WHERE [name] = 'artemis_protector_stronghold1' ORDER BY [name] DESC);
UPDATE [dbo].[npcflock] SET [name] = 'artemis_protector_stronghold1'
                ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1024, [spawnoriginY] = 946
               ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 20
               ,[note] = 'artemis_protector_stronghold1', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_intakt_miniboss_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from [npcflock] WHERE [name] = 'intakt_by_protector' ORDER BY [name] DESC);
UPDATE [dbo].[npcflock] SET [name] = 'intakt_by_protector'
                ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = @definitionID, [spawnoriginX] = 1024, [spawnoriginY] = 946
               ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 15
               ,[note] = 'def_npc_intakt_miniboss_rank3', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_baphomet_miniboss_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from [npcflock] WHERE [name] = 'baphomet_by_protector' ORDER BY [name] DESC);
UPDATE [dbo].[npcflock] SET [name] = 'baphomet_by_protector'
                ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = @definitionID, [spawnoriginX] = 1024, [spawnoriginY] = 946
               ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 15
               ,[note] = 'baphomet_by_protector', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;



-----------------------
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'stronghold1_presence4' ORDER BY id DESC);

UPDATE [dbo].[npcpresence]
                SET [name] = 'stronghold1_presence4',[topx] = 1020,[topy] = 1110,[bottomx] = 1025,[bottomy] = 1090,[note] = '',[spawnid] = 21,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_guard' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from [npcflock] WHERE [name] = 'tyrannos_protector' ORDER BY [name] DESC);
UPDATE [dbo].[npcflock] SET [name] = 'tyrannos_protector'
                ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1023, [spawnoriginY] = 1099
               ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 20
               ,[note] = 'tyrannos_protector', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_waspish_miniboss_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from [npcflock] WHERE [name] = 'waspish_with_protector' ORDER BY [name] DESC);
UPDATE [dbo].[npcflock] SET [name] = 'waspish_with_protector'
                ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = @definitionID, [spawnoriginX] = 1023, [spawnoriginY] = 1099
               ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 15
               ,[note] = 'waspish_with_protector', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_troiar_miniboss_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from [npcflock] WHERE [name] = 'troiar_with_protector' ORDER BY [name] DESC);
UPDATE [dbo].[npcflock] SET [name] = 'troiar_with_protector'
                ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = @definitionID, [spawnoriginX] = 1023, [spawnoriginY] = 1099
               ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 15
               ,[note] = 'troiar_with_protector', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;


-----------------------
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'stronghold1_presence2' ORDER BY id DESC);
UPDATE [dbo].[npcpresence]
                SET [name] = 'stronghold1_presence2',[topx] = 990,[topy] = 1010,[bottomx] = 995,[bottomy] = 1015,[note] = '',[spawnid] = 21,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_cameleon_miniboss_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from [npcflock] WHERE [name] = 'cameleon_with_numiquol_protector' ORDER BY [name] DESC);
UPDATE [dbo].[npcflock] SET [name] = 'cameleon_with_numiquol_protector'
                ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = @definitionID, [spawnoriginX] = 994, [spawnoriginY] = 1013
               ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 15
               ,[note] = 'cameleon_with_numiquol_protector', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_miniboss_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from [npcflock] WHERE [name] = 'arbalest_with_numiquol_protector' ORDER BY [name] DESC);
UPDATE [dbo].[npcflock] SET [name] = 'arbalest_with_numiquol_protector'
                ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = @definitionID, [spawnoriginX] = 994, [spawnoriginY] = 1013
               ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 15
               ,[note] = 'arbalest_with_numiquol_protector', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

-----------------------
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_guard' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_npc_kain_guard', quantity=1, attributeflags=1024, categoryflags=1167, options='', 
                note='', enabled=1, volume=0, mass=0, hidden='False', health=100, descriptiontoken='def_npc_kain_guard_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.45 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.15 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'resist_chemical' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=305 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'resist_explosive' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=305 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'resist_kinetic' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=305 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'resist_thermal' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=305 WHERE id =  @aggvalueID;

-----------------------
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_guard' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_npc_artemis_guard', quantity=1, attributeflags=1024, categoryflags=911, options='', 
                note='', enabled=1, volume=0, mass=0, hidden='False', health=100, descriptiontoken='def_npc_artemis_guard_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.45 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.15 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'resist_chemical' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=305 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'resist_explosive' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=305 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'resist_kinetic' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=305 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'resist_thermal' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=305 WHERE id =  @aggvalueID;

-----------------------
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_guard' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_npc_tyrannos_guard', quantity=1, attributeflags=1024, categoryflags=1423, options='', 
                note='', enabled=1, volume=0, mass=0, hidden='False', health=100, descriptiontoken='def_npc_tyrannos_guard_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.45 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.15 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'resist_chemical' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=305 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'resist_explosive' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=305 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'resist_kinetic' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=305 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'resist_thermal' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=305 WHERE id =  @aggvalueID;




