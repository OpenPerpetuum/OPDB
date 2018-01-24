USE [perpetuumsa]
GO

--TEMPORARY PORT to STRONGHOLD
--in combined file
--UPDATE [dbo].[zones]
--   SET [id] = 16
--      ,[x] = 2000
--      ,[y] = -4000
--      ,[name] = 'zone_pvp_arena'
--      ,[description] = 'zone_pvp_arena'
--      ,[note] = 'pvp arena'
--      ,[fertility] = 20
--      ,[zoneplugin] = 'zone_16'
--      ,[zoneip] = '109.236.88.106'
--      ,[zoneport] = 18816
--      ,[isinstance] = 0
--      ,[enabled] = 1
--      ,[spawnid] = 21
--      ,[plantruleset] = 0
--      ,[protected] = 0
--      ,[raceid] = 1
--      ,[width] = 2048
--      ,[height] = 2048
--      ,[terraformable] = 0
--      ,[zonetype] = 1
--      ,[sparkcost] = 3
--      ,[maxdockingbase] = 0
--      ,[sleeping] = 0
--      ,[plantaltitudescale] = 1
--      ,[host] = 'genxyHost-01'
--      ,[active] = 1
-- WHERE ID=16
--GO

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




