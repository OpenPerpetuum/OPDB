USE [perpetuumsa]
GO

---ADD DUMMY ZONES FOR TRAINING RACE SELECTION
--REQUIRES ZONE 50/51 BINS IN SERVER DATA LAYERS!

INSERT INTO [dbo].[zones]
           ([id],[x],[y],[name],[description],[note],[fertility],[zoneplugin],[zoneip],[zoneport],[isinstance],[enabled],[spawnid],[plantruleset],[protected],[raceid],[width],[height],[terraformable],[zonetype],[sparkcost],[maxdockingbase],[sleeping],[plantaltitudescale],[host],[active])
     VALUES
           (50,50000,50000,'zone_TM','zone_TM_desc','ICS-NUIMQOL TRAINING EXIT DUMMY ISLAND',20,'zone_50',NULL,18845,0,1,0,0,1,2,1024,1024,0,3,0,0,0,1,NULL,1)
INSERT INTO [dbo].[zones]
           ([id],[x],[y],[name],[description],[note],[fertility],[zoneplugin],[zoneip],[zoneport],[isinstance],[enabled],[spawnid],[plantruleset],[protected],[raceid],[width],[height],[terraformable],[zonetype],[sparkcost],[maxdockingbase],[sleeping],[plantaltitudescale],[host],[active])
     VALUES
           (51,51000,51000,'zone_TM','zone_TM_desc','ASI-TRAINING TRAINING EXIT DUMMY ISLAND',20,'zone_50',NULL,18845,0,1,0,0,1,3,1024,1024,0,3,0,0,0,1,NULL,1)





--Set Targets for training exits to dummy zones
UPDATE [dbo].[teleportdescriptions]
   SET [description] = 'tp_training_asi_exit'
      ,[sourcecolumn] = 2463
      ,[targetcolumn] = NULL
      ,[sourcezone] = 45
      ,[sourcerange] = 10
      ,[targetzone] = 51
      ,[targetx] = 1082
      ,[targety] = 828
      ,[targetz] = NULL
      ,[targetrange] = 5
      ,[usetimeout] = 0
      ,[listable] = 1
      ,[active] = 1
      ,[type] = 3
      ,[sourcecolumnname] = 'tp_train_asi_exit'
      ,[targetcolumnname] = NULL
 WHERE [description]='tp_training_asi_exit'

UPDATE [dbo].[teleportdescriptions]
   SET [description] = 'tp_training_ics_exit'
      ,[sourcecolumn] = 2461
      ,[targetcolumn] = NULL
      ,[sourcezone] = 45
      ,[sourcerange] = 10
      ,[targetzone] = 50
      ,[targetx] = 1082
      ,[targety] = 828
      ,[targetz] = NULL
      ,[targetrange] = 5
      ,[usetimeout] = 0
      ,[listable] = 1
      ,[active] = 1
      ,[type] = 3
      ,[sourcecolumnname] = 'tp_train_ics_exit'
      ,[targetcolumnname] = NULL
 WHERE [description] = 'tp_training_ics_exit'

UPDATE [dbo].[teleportdescriptions]
   SET [description] = 'tp_training_industrial_asi_exit'
      ,[sourcecolumn] = 2466
      ,[targetcolumn] = NULL
      ,[sourcezone] = 45
      ,[sourcerange] = 10
      ,[targetzone] = 51
      ,[targetx] = 1082
      ,[targety] = 828
      ,[targetz] = NULL
      ,[targetrange] = 5
      ,[usetimeout] = 0
      ,[listable] = 1
      ,[active] = 1
      ,[type] = 3
      ,[sourcecolumnname] = 'tp_train_indy_exit'
      ,[targetcolumnname] = NULL
 WHERE [description] = 'tp_training_industrial_asi_exit'

UPDATE [dbo].[teleportdescriptions]
   SET [description] = 'tp_training_industrial_ics_exit'
      ,[sourcecolumn] = 2466
      ,[targetcolumn] = NULL
      ,[sourcezone] = 45
      ,[sourcerange] = 10
      ,[targetzone] = 50
      ,[targetx] = 1082
      ,[targety] = 828
      ,[targetz] = NULL
      ,[targetrange] = 5
      ,[usetimeout] = 0
      ,[listable] = 1
      ,[active] = 1
      ,[type] = 3
      ,[sourcecolumnname] = 'tp_train_indy_exit'
      ,[targetcolumnname] = NULL
 WHERE [description] = 'tp_training_industrial_ics_exit'


 --Re-enable teleports
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
      ,[enabled] = 1
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
      ,[enabled] = 1
      ,[note] = 'tp_train_asi_exit'
      ,[runtime] = 0
      ,[synckey] = 'tpc_rutfrft'
 WHERE ID=2375


 --Set and add training rewards for factions
 --Add syndicate stuff to all exits

UPDATE [dbo].[trainingrewards]
   SET [level] = 1
      ,[definition] = 286
      ,[quantity] = 250
      ,[robottemplateid] = NULL
      ,[raceid] = 1
 WHERE ID=4

UPDATE [dbo].[trainingrewards]
   SET [level] = 1
      ,[definition] = 285
      ,[quantity] = 250
      ,[robottemplateid] = NULL
      ,[raceid] = 1
 WHERE ID=3

UPDATE [dbo].[trainingrewards]
   SET [level] = 1
      ,[definition] = 284
      ,[quantity] = 250
      ,[robottemplateid] = NULL
      ,[raceid] = 1
 WHERE ID=2

UPDATE [dbo].[trainingrewards]
   SET [level] = 1
      ,[definition] = 283
      ,[quantity] = 250
      ,[robottemplateid] = NULL
      ,[raceid] = 1
 WHERE ID=1

UPDATE [dbo].[trainingrewards]
   SET [level] = 1
      ,[definition] = 63
      ,[quantity] = 4
      ,[robottemplateid] = NULL
      ,[raceid] = 1
 WHERE ID=20

UPDATE [dbo].[trainingrewards]
   SET [level] = 2
      ,[definition] = 56
      ,[quantity] = 2
      ,[robottemplateid] = NULL
      ,[raceid] = 5
 WHERE ID=43

UPDATE [dbo].[trainingrewards]
   SET [level] = 3
      ,[definition] = NULL
      ,[quantity] = Null
      ,[robottemplateid] = 692
      ,[raceid] = 1
 WHERE ID=33

UPDATE [dbo].[trainingrewards]
   SET [level] = 3
      ,[definition] = NULL
      ,[quantity] = Null
      ,[robottemplateid] = 693
      ,[raceid] = 1
 WHERE ID=37

INSERT INTO [dbo].[trainingrewards]
           ([level]
           ,[definition]
           ,[quantity]
           ,[robottemplateid]
           ,[raceid])
     VALUES
           (2
           ,60
           ,4
           ,NULL
           ,1)

INSERT INTO [dbo].[trainingrewards]
           ([level]
           ,[definition]
           ,[quantity]
           ,[robottemplateid]
           ,[raceid])
     VALUES
           (2
           ,60
           ,4
           ,NULL
           ,2)

INSERT INTO [dbo].[trainingrewards]
           ([level]
           ,[definition]
           ,[quantity]
           ,[robottemplateid]
           ,[raceid])
     VALUES
           (2
           ,60
           ,4
           ,NULL
           ,3)

INSERT INTO [dbo].[trainingrewards]
           ([level]
           ,[definition]
           ,[quantity]
           ,[robottemplateid]
           ,[raceid])
     VALUES
           (3
           ,NULL
           ,1
           ,740
           ,1)

INSERT INTO [dbo].[trainingrewards]
           ([level]
           ,[definition]
           ,[quantity]
           ,[robottemplateid]
           ,[raceid])
     VALUES
           (3
           ,NULL
           ,1
           ,740
           ,2)

INSERT INTO [dbo].[trainingrewards]
           ([level]
           ,[definition]
           ,[quantity]
           ,[robottemplateid]
           ,[raceid])
     VALUES
           (3
           ,NULL
           ,1
           ,740
           ,3)

INSERT INTO [dbo].[trainingrewards]
           ([level]
           ,[definition]
           ,[quantity]
           ,[robottemplateid]
           ,[raceid])
     VALUES
           (4
           ,NULL
           ,1
           ,732
           ,1)

INSERT INTO [dbo].[trainingrewards]
           ([level]
           ,[definition]
           ,[quantity]
           ,[robottemplateid]
           ,[raceid])
     VALUES
           (4
           ,NULL
           ,1
           ,732
           ,2)

INSERT INTO [dbo].[trainingrewards]
           ([level]
           ,[definition]
           ,[quantity]
           ,[robottemplateid]
           ,[raceid])
     VALUES
           (4
           ,NULL
           ,1
           ,732
           ,3)

INSERT INTO [dbo].[trainingrewards]
           ([level]
           ,[definition]
           ,[quantity]
           ,[robottemplateid]
           ,[raceid])
     VALUES
           (2
           ,912
           ,2
           ,NULL
           ,2)

INSERT INTO [dbo].[trainingrewards]
           ([level]
           ,[definition]
           ,[quantity]
           ,[robottemplateid]
           ,[raceid])
     VALUES
           (2
           ,912
           ,2
           ,NULL
           ,3)

UPDATE [dbo].[cw_race_extension]
   SET [raceid] = 1
      ,[extensionid] = 145
      ,[levelincrement] = 1
 WHERE race_extension_id=1

INSERT INTO [dbo].[cw_race_extension]
           ([raceid]
           ,[extensionid]
           ,[levelincrement])
     VALUES
           (1
           ,360
           ,2)

INSERT INTO [dbo].[cw_race_extension]
           ([raceid]
           ,[extensionid]
           ,[levelincrement])
     VALUES
           (1
           ,74
           ,1)

INSERT INTO [dbo].[cw_race_extension]
           ([raceid]
           ,[extensionid]
           ,[levelincrement])
     VALUES
           (2
           ,64
           ,1)

INSERT INTO [dbo].[cw_race_extension]
           ([raceid]
           ,[extensionid]
           ,[levelincrement])
     VALUES
           (2
           ,63
           ,1)

INSERT INTO [dbo].[cw_race_extension]
           ([raceid]
           ,[extensionid]
           ,[levelincrement])
     VALUES
           (2
           ,360
           ,1)

INSERT INTO [dbo].[cw_race_extension]
           ([raceid]
           ,[extensionid]
           ,[levelincrement])
     VALUES
           (2
           ,219
           ,1)

INSERT INTO [dbo].[cw_race_extension]
           ([raceid]
           ,[extensionid]
           ,[levelincrement])
     VALUES
           (3
           ,219
           ,1)

INSERT INTO [dbo].[cw_race_extension]
           ([raceid]
           ,[extensionid]
           ,[levelincrement])
     VALUES
           (3
           ,63
           ,1)

INSERT INTO [dbo].[cw_race_extension]
           ([raceid]
           ,[extensionid]
           ,[levelincrement])
     VALUES
           (3
           ,64
           ,1)

INSERT INTO [dbo].[cw_race_extension]
           ([raceid]
           ,[extensionid]
           ,[levelincrement])
     VALUES
           (3
           ,360
           ,1)

INSERT INTO [dbo].[trainingrewards]
           ([level]
           ,[definition]
           ,[quantity]
           ,[robottemplateid]
           ,[raceid])
     VALUES
           (1
           ,259
           ,5000
           ,NULL
           ,1)

INSERT INTO [dbo].[trainingrewards]
           ([level]
           ,[definition]
           ,[quantity]
           ,[robottemplateid]
           ,[raceid])
     VALUES
           (1
           ,259
           ,5000
           ,NULL
           ,2)

INSERT INTO [dbo].[trainingrewards]
           ([level]
           ,[definition]
           ,[quantity]
           ,[robottemplateid]
           ,[raceid])
     VALUES
           (1
           ,259
           ,5000
           ,NULL
           ,3)

GO