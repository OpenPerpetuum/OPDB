USE [perpetuumsa]
GO

-- Change extensions granted for choosing syndicate out of tutorial island
UPDATE [dbo].[cw_race_extension]
   SET [raceid] = 1
      ,[extensionid] = 355
      ,[levelincrement] = 1
 WHERE race_extension_id=11


UPDATE [dbo].[cw_race_extension]
   SET [raceid] = 1
      ,[extensionid] = 360
      ,[levelincrement] = 2
 WHERE race_extension_id=1
 
 UPDATE [dbo].[cw_race_extension]
   SET [raceid] = 1
      ,[extensionid] = 63
      ,[levelincrement] = 2
 WHERE race_extension_id=2

 UPDATE [dbo].[cw_race_extension]
   SET [raceid] = 1
      ,[extensionid] = 64
      ,[levelincrement] = 2
 WHERE race_extension_id=3
 
GO