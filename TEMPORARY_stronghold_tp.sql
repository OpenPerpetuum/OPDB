USE [perpetuumsa]
GO

--TEMPORARY PORT to STRONGHOLD
UPDATE [dbo].[zones]
   SET [id] = 16
      ,[x] = 2000
      ,[y] = -4000
      ,[name] = 'zone_pvp_arena'
      ,[description] = 'zone_pvp_arena'
      ,[note] = 'pvp arena'
      ,[fertility] = 20
      ,[zoneplugin] = 'zone_16'
      ,[zoneip] = '109.236.88.106'
      ,[zoneport] = 18816
      ,[isinstance] = 0
      ,[enabled] = 1
      ,[spawnid] = 21
      ,[plantruleset] = 0
      ,[protected] = 0
      ,[raceid] = 1
      ,[width] = 2048
      ,[height] = 2048
      ,[terraformable] = 0
      ,[zonetype] = 1
      ,[sparkcost] = 3
      ,[maxdockingbase] = 0
      ,[sleeping] = 0
      ,[plantaltitudescale] = 1
      ,[host] = 'genxyHost-01'
      ,[active] = 1
 WHERE ID=16
GO

UPDATE [dbo].[teleportdescriptions]
   SET [description] = 'tp_zone_39_3_to_teleport_column_tm_maddis_Z'
      ,[sourcecolumn] = 2557
      ,[targetcolumn] = 5326
      ,[sourcezone] = 16
      ,[sourcerange] = 7
      ,[targetzone] = 0
      ,[targetx] = NULL
      ,[targety] = NULL
      ,[targetz] = NULL
      ,[targetrange] = 7
      ,[usetimeout] = 0
      ,[listable] = 1
      ,[active] = 1
      ,[type] = 2
      ,[sourcecolumnname] = 'tp_zone_39_3'
      ,[targetcolumnname] = 'teleport_column_tm_maddis_Z'
	  where ID=403
GO

UPDATE [dbo].[teleportdescriptions]
   SET [description] = 'teleport_column_tm_maddis_Z_to_tp_zone_39_3'
      ,[sourcecolumn] = 5326
      ,[targetcolumn] = 2557
      ,[sourcezone] = 0
      ,[sourcerange] = 7
      ,[targetzone] = 16
      ,[targetx] = NULL
      ,[targety] = NULL
      ,[targetz] = NULL
      ,[targetrange] = 7
      ,[usetimeout] = 0
      ,[listable] = 1
      ,[active] = 1
      ,[type] = 2
      ,[sourcecolumnname] = 'teleport_column_tm_maddis_Z'
      ,[targetcolumnname] = 'tp_zone_39_3'
 WHERE ID=402
GO

UPDATE [dbo].[zoneentities]
   SET [zoneID] = 16
      ,[eid] = 2557
      ,[definition] = NULL
      ,[owner] = NULL
      ,[ename] = 'tp_zone_16_1'
      ,[x] = 1108
      ,[y] = 1048
      ,[z] = 50
      ,[orientation] = 0
      ,[enabled] = 1
      ,[note] = 'PVP Stronghold 1'
      ,[runtime] = 0
      ,[synckey] = 'tpc_glmodxi'
 WHERE ID=2417
GO

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('test_npc_stronghold1',0,0,2000,2000,'main container for flox',21,1,0,0,0,0,0
			    ,0,0,0,1,1,0);

DECLARE @presenceID int;
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'test_npc_stronghold1' ORDER BY id DESC);
UPDATE [dbo].[npcpresence]
                SET [name] = 'test_npc_stronghold1',[topx] = 0,[topy] = 0,[bottomx] = 2000,[bottomy] = 2000,[note] = 'main container for flox',[spawnid] = 21,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;
DECLARE @flockID int;
DECLARE @definitionID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_guard' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('test_kain_bot', @presenceID, 1, @definitionID, 994, 1013, 0, 5, 60, 0,
                 10, 'test1', 1, 1, 1, 1);

