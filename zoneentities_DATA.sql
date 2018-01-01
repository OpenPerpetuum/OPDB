USE [perpetuumsa]
GO
UPDATE [dbo].[zoneentities]
   SET [zoneID] = 45
      ,[eid] = 2461
      ,[definition] = NULL
      ,[owner] = NULL
      ,[ename] = NULL
      ,[x] = 278.5
      ,[y] = 933.5
      ,[z] = 76
      ,[orientation] = 0
      ,[enabled] = 0
      ,[note] = 'tp_train_ics_exit'
      ,[runtime] = 0
      ,[synckey] = 'tpc_kzsxdrw'
 WHERE ID=2373

UPDATE [dbo].[zoneentities]
   SET [zoneID] = 45
      ,[eid] = 2463
      ,[definition] = NULL
      ,[owner] = NULL
      ,[ename] = NULL
      ,[x] = 190.5
      ,[y] = 883.5
      ,[z] = 76
      ,[orientation] = 192
      ,[enabled] = 0
      ,[note] = 'tp_train_asi_exit'
      ,[runtime] = 0
      ,[synckey] = 'tpc_rutfrft'
 WHERE ID=2375
GO


