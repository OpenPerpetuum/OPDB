USE [perpetuumsa]
GO

UPDATE [dbo].[zones]
   SET [id] = 16
      ,[x] = 3000
      ,[y] = -5000
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
      ,[protected] = 1
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
 WHERE id=16
GO


