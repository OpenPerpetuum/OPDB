USE [perpetuumsa]
GO

SET NOEXEC OFF;

IF EXISTS (SELECT TOP 1 definition from dbo.entitydefaults WHERE definitionname='def_standard_blinder')
BEGIN
	SET NOEXEC OFF;
	PRINT N'Blinder module found!  Will now add npcs that require the blinder';
END
ELSE
BEGIN
	PRINT N'BLINDER NOT FOUND! WILL NOT EXECUTE NPC CHANGES BELOW!';
	PRINT N'PLEASE VERIFY THAT THE BLINDER MODULE WAS ADDED BEFORE RUNNING THIS SCRIPT!';
	SET NOEXEC ON;
END

DECLARE @blinderModule int;
DECLARE @blinderModHex VARCHAR(50);

SET @blinderModule = (SELECT TOP 1 definition from dbo.entitydefaults WHERE definitionname='def_standard_blinder');
PRINT @blinderModule;

SET @blinderModHex = (SELECT dbo.ToHex(@blinderModule));

print '#robot=ic4#head=i4f#chassis=i50#leg=i51#container=i148#headModules=[|m0=[|definition=i'+@blinderModHex+'|slot=i3]]#chassisModules=[|m0=[|definition=i26|slot=i1]|m1=[|definition=i26|slot=i2]]#legModules=[|m0=[|definition=i12a|slot=i1]|m1=[|definition=i0|slot=i2]|m2=[|definition=i0|slot=i3]]'

DECLARE @templateID int
DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
DECLARE @lootdefinitionID int;
DECLARE @npclootID int;
DECLARE @presenceID int
DECLARE @flockID int;

--New NPC Goblin Lancer - Mirrored off Goblin Shark Attributes No guns
PRINT N'Updates to goblin shark template';
SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'goblin_shark' ORDER BY id DESC)

UPDATE robottemplates SET
name='goblin_shark',
description='#robot=ic4#head=i4f#chassis=i50#leg=i51#container=i148#headModules=[|m0=[|definition=i'+@blinderModHex+'|slot=i3]]#chassisModules=[|m0=[|definition=i26|slot=i1]|m1=[|definition=i26|slot=i2]]#legModules=[|m0=[|definition=i12a|slot=i1]|m1=[|definition=i0|slot=i2]|m2=[|definition=i0|slot=i3]]',
note='The Beta Gate Keeper'
WHERE id=@templateID;

--Set Speed of shark to 75% of its max
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_goblin_shark' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max_modifier' ORDER BY [name] DESC);

INSERT INTO [dbo].[aggregatevalues]
           ([definition],[field],[value])
     VALUES
           (@definitionID, @aggfieldID, 0.75);

--Set masking of shark to 75rf
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_goblin_shark' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'stealth_strength_modifier' ORDER BY [name] DESC);

INSERT INTO [dbo].[aggregatevalues]
           ([definition],[field],[value])
     VALUES
           (@definitionID, @aggfieldID, -25);


PRINT N'Insert new npc';
INSERT INTO entitydefaults ( definitionname ,  quantity ,  attributeflags ,  categoryflags ,  options ,  note ,  enabled ,  volume ,  mass ,  hidden , 
                health ,  descriptiontoken ,  purchasable ,  tiertype ,  tierlevel ) 
                VALUES ( 'def_npc_goblin_lancer', 1, 1024, 1423, '', '', 1, 0, 0, 0, 100, 'def_npc_castel_dps_rank1_desc', 0, 0, 0); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_goblin_lancer' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_npc_goblin_lancer', quantity=1, attributeflags=1024, categoryflags=1423, options='', 
                note='', enabled=1, volume=0, mass=0, hidden=0, health=100, descriptiontoken='def_npc_castel_dps_rank1_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'Insert new npc stats';
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.01);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 4);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_recharge_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.9);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'falloff_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.5);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locking_range_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locking_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 5);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'missile_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'optimal_range_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.5);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'turret_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'received_repaired_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.1);

--Set the ECM strength to 50%
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'ecm_strength_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.5);

--Set Speed of lancer to 50% of its max
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max_modifier' ORDER BY [name] DESC);

INSERT INTO [dbo].[aggregatevalues]
           ([definition],[field],[value])
     VALUES
           (@definitionID, @aggfieldID, 0.5);


--Set masking of lancer to 75rf
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'stealth_strength_modifier' ORDER BY [name] DESC);

INSERT INTO [dbo].[aggregatevalues]
           ([definition],[field],[value])
     VALUES
           (@definitionID, @aggfieldID, -45);


PRINT N'Insert new npc template';
INSERT INTO robottemplates ([name], [description], [note]) VALUES ('Goblin_Lancer', '#robot=i1584#head=i1585#chassis=i1586#leg=i1587#container=i146#headModules=[|m0=[|definition=i'+@blinderModHex+'|slot=i1]|m1=[|definition=i33|slot=i2]|m2=[|definition=i0|slot=i3]|m3=[|definition=i0|slot=i4]]#chassisModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]|m2=[|definition=i0|slot=i3]]#legModules=[|m0=[|definition=i286|slot=i1]|m1=[|definition=i0|slot=i2]|m2=[|definition=i0|slot=i3]]', 'AFK Roaming NPC')

PRINT N'Insert new npc template relation';
SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'Goblin_Lancer' ORDER BY id DESC)

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_goblin_lancer' ORDER BY definition DESC);

INSERT INTO [dbo].[robottemplaterelation] ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
                VALUES (@definitionID,@templateID,0,0,NULL,NULL,0,'Roaming AFK Miner Finder');

PRINT N'Insert new npc loots';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_goblin_lancer' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 200, 1, 0, 1, 100);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 100, 1, 0, 1, 50);


--Updated Goblin Shark with Blinder Module, no guns.
PRINT N'Update goblin shark modules';
SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'goblin_shark' ORDER BY id DESC);

UPDATE robottemplates SET name='goblin_shark', description='#robot=ic4#head=i4f#chassis=i50#leg=i51#container=i148#headModules=[|m0=[|definition=i'+@blinderModHex+'|slot=i3]]#chassisModules=[|m0=[|definition=i26|slot=i1]|m1=[|definition=i26|slot=i2]]#legModules=[|m0=[|definition=i12a|slot=i1]|m1=[|definition=i0|slot=i2]|m2=[|definition=i0|slot=i3]]', note='The Beta Gate Keeper' WHERE id=@templateID;

--Updated Free Roaming Spawns NV/Hersh
PRINT N'update presences and flocks with new npcs';

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_goblin_lancer' ORDER BY definition DESC);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'freeroaming_NPC_Hersh_ECM_1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'freeroaming_NPC_Hersh_ECM_1',[topx] = 7,[topy] = 7,[bottomx] = 2040,[bottomy] = 2040,[note] = 'Hersh  - 2 laird ECM free roamer',[spawnid] = 13,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 600,[presencetype] = 5,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'free_roaming_laird_hersh_1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'free_roaming_laird_hersh_1' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 0, [spawnoriginY] = 0 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 1200, [totalspawncount] = 0, [homerange] = 35 ,[note] = 'Goblin_Lancer', [respawnmultiplierlow] = 0, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'freeroaming_NPC_Hersh_ECM_2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'freeroaming_NPC_Hersh_ECM_2',[topx] = 7,[topy] = 7,[bottomx] = 2040,[bottomy] = 2040,[note] = 'Goblin_lancer afk miner 2',[spawnid] = 13,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 600,[presencetype] = 5,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'free_roaming_argano_Hersh_1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'free_roaming_argano_Hersh_1' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 0, [spawnoriginY] = 0 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 1200, [totalspawncount] = 0, [homerange] = 35 ,[note] = 'Goblin Lancer afk miner', [respawnmultiplierlow] = 0, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'freeroaming_NPC_Hersh_ECM_3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'freeroaming_NPC_Hersh_ECM_3',[topx] = 7,[topy] = 7,[bottomx] = 2040,[bottomy] = 2040,[note] = 'Goblin_Lancer 3',[spawnid] = 13,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 600,[presencetype] = 5,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'free_roaming_laird_hersh_2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'free_roaming_laird_hersh_2' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 0, [spawnoriginY] = 0 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 1200, [totalspawncount] = 0, [homerange] = 35 ,[note] = 'goblin Lancer 3', [respawnmultiplierlow] = 0, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'freeroaming_NPC_Hersh_ECM_4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'freeroaming_NPC_Hersh_ECM_4',[topx] = 7,[topy] = 7,[bottomx] = 2040,[bottomy] = 2040,[note] = 'goblin Lancer 4',[spawnid] = 13,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 600,[presencetype] = 5,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'free_roaming_argano_hersh_2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'free_roaming_argano_hersh_2' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 0, [spawnoriginY] = 0 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 1200, [totalspawncount] = 0, [homerange] = 35 ,[note] = 'goblin lancer 4', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'freeroaming_NPC_New_Virginia' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'freeroaming_NPC_New_Virginia',[topx] = 7,[topy] = 7,[bottomx] = 2040,[bottomy] = 2040,[note] = 'New Virginia - 1 Laird ECM free-roamer',[spawnid] = 1,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 600,[presencetype] = 5,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'free_roaming_laird_NV' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'free_roaming_laird_NV' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 0, [spawnoriginY] = 0 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 1200, [totalspawncount] = 0, [homerange] = 35 ,[note] = 'NV Roaming Spawn 1', [respawnmultiplierlow] = 0, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'freeroaming_NPC_New_Virginia_2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'freeroaming_NPC_New_Virginia_2',[topx] = 7,[topy] = 7,[bottomx] = 2040,[bottomy] = 2040,[note] = 'New Virginia - 1 argano ECM free-roamer',[spawnid] = 1,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 600,[presencetype] = 5,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'argano_free_roaming_NV2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'argano_free_roaming_NV2' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 0, [spawnoriginY] = 0 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 1200, [totalspawncount] = 0, [homerange] = 35 ,[note] = 'free_roaming_argano2', [respawnmultiplierlow] = 0, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'freeroaming_NPC_New_Virginia_3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'freeroaming_NPC_New_Virginia_3',[topx] = 7,[topy] = 7,[bottomx] = 2040,[bottomy] = 2040,[note] = 'New Virginia  - 1 argano ECM free roamer',[spawnid] = 1,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 600,[presencetype] = 5,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Free_roaming_argano_NV3' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Free_roaming_argano_NV3' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 0, [spawnoriginY] = 0 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 1200, [totalspawncount] = 0, [homerange] = 35 ,[note] = 'Free_roaming_argano_NV3', [respawnmultiplierlow] = 0, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'freeroaming_NPC_New_Virginia_4' ORDER BY id DESC);
UPDATE [dbo].[npcpresence]
                SET [name] = 'freeroaming_NPC_New_Virginia_4',[topx] = 7,[topy] = 7,[bottomx] = 2040,[bottomy] = 2040,[note] = 'New Virginia  - 1 laird ECM free roamer',[spawnid] = 1,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 600,[presencetype] = 5,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'NV_free_roamer_laird' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'NV_free_roamer_laird' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 0, [spawnoriginY] = 0 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 1200, [totalspawncount] = 0, [homerange] = 35 ,[note] = 'NV laird free roamer', [respawnmultiplierlow] = 0, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;



PRINT N'Complete with blinder npc adds';
GO

SET NOEXEC OFF;
GO
