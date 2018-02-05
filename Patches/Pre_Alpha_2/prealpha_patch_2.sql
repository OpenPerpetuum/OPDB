/*
BEGIN TRANSACTION

ROLLBACK TRANSACTION

COMMIT TRANSACTION

--fixes STOP USING IDs!
SELECT * from trainingrewards

id	level	definition	quantity	robottemplateid	raceid
125	2	56	2	NULL	1

UPDATE [dbo].[trainingrewards]
   SET [level] = 2
      ,[definition] = 56
      ,[quantity] = 2
      ,[robottemplateid] = NULL
      ,[raceid] = 5
 WHERE ID=125
*/


USE perpetuumsa
GO

SELECT * FROM itemshoplocations
JOIN entities ON locationeid=entities.eid
WHERE entities.parent=47383

--Set TMB to TM PVP synshop preset (sells green stuff with green tokens)
PRINT '--Set TMB to TM PVP synshop preset (sells green stuff with green tokens)'
UPDATE itemshoplocations
SET presetid=6
FROM itemshoplocations 
JOIN entities on itemshoplocations.locationeid=entities.eid
WHERE entities.parent=47383;

GO

---ADD DUMMY ZONES FOR TRAINING RACE SELECTION
PRINT '---ADD DUMMY ZONES FOR TRAINING RACE SELECTION'
--REQUIRES ZONE 50/51 BINS IN SERVER DATA LAYERS!
PRINT '--REQUIRES ZONE 50/51 BINS IN SERVER DATA LAYERS!'

INSERT INTO [dbo].[zones]
           ([id],[x],[y],[name],[description],[note],[fertility],[zoneplugin],[zoneip],[zoneport],[isinstance],[enabled],[spawnid],[plantruleset],[protected],[raceid],[width],[height],[terraformable],[zonetype],[sparkcost],[maxdockingbase],[sleeping],[plantaltitudescale],[host],[active])
     VALUES
           (50,50000,50000,'zone_TM','zone_TM_desc','ICS-NUIMQOL TRAINING EXIT DUMMY ISLAND',20,'zone_50',NULL,18845,0,1,0,0,1,2,1024,1024,0,3,0,0,0,1,NULL,1)
INSERT INTO [dbo].[zones]
           ([id],[x],[y],[name],[description],[note],[fertility],[zoneplugin],[zoneip],[zoneport],[isinstance],[enabled],[spawnid],[plantruleset],[protected],[raceid],[width],[height],[terraformable],[zonetype],[sparkcost],[maxdockingbase],[sleeping],[plantaltitudescale],[host],[active])
     VALUES
           (51,51000,51000,'zone_TM','zone_TM_desc','ASI-TRAINING TRAINING EXIT DUMMY ISLAND',20,'zone_50',NULL,18845,0,1,0,0,1,3,1024,1024,0,3,0,0,0,1,NULL,1)





--Set Targets for training exits to dummy zones
PRINT '--Set Targets for training exits to dummy zones'

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
 PRINT '--Re-enable teleports'
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
 PRINT '--Set and add training rewards for factions'
 --Add syndicate stuff to all exits
 PRINT '--Add syndicate stuff to all exits'

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


--Set Max mission level on hershfield to 4
PRINT '--Set Max mission level on hershfield to 4'

UPDATE missionlocations
SET maxmissionlevel=4
WHERE zoneid=8;

GO

USE [perpetuumsa]
GO

DECLARE @definitionID int;
DECLARE @lootdefinitionID int;
DECLARE @npclootID int;
DECLARE @presenceID int
DECLARE @flockID int;

--------------Increases Bullets to the Training Reward-----------------
PRINT '--------------Increases Bullets to the Training Reward-----------------'

UPDATE [dbo].[trainingrewards]
   SET [level] = 1
      ,[definition] = 259
      ,[quantity] = 2500
      ,[robottemplateid] = NULL
      ,[raceid] = 1
WHERE ID = 1

UPDATE [dbo].[trainingrewards]
   SET [level] = 1
      ,[definition] = 260
      ,[quantity] = 2500
      ,[robottemplateid] = NULL
      ,[raceid] = 1
 WHERE ID = 2

UPDATE [dbo].[trainingrewards]
   SET [level] = 1
      ,[definition] = 261
      ,[quantity] = 2500
      ,[robottemplateid] = NULL
      ,[raceid] = 1
 WHERE ID = 3

UPDATE [dbo].[trainingrewards]
   SET [level] = 1
      ,[definition] = 262
      ,[quantity] = 2500
      ,[robottemplateid] = NULL
      ,[raceid] = 1
 WHERE ID = 4

 ---------------------Adds 2 firearms tuning, 1 light plate and 2 indy tunings to training rewards-----

 INSERT INTO [dbo].[trainingrewards]
           ([level]
           ,[definition]
           ,[quantity]
           ,[robottemplateid]
           ,[raceid])
     VALUES
           (2
           ,14
           ,1
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
           ,912
           ,2
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
           ,56
           ,2
           ,NULL
           ,1)

----------Adds Optimized weapon to extensions-------
PRINT '----------Adds Optimized weapon to extensions-------'

		   INSERT INTO [dbo].[cw_race_extension]
           ([raceid]
           ,[extensionid]
           ,[levelincrement])
     VALUES
           (1
           ,219
           ,1)

----------Adds Arkhe Spawn back to NV----------
PRINT '----------Adds Arkhe Spawn back to NV----------'


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'random_v2_1_NEW_01_Arkhe' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'random_v2_1_NEW_01_Arkhe',[topx] = 912,[topy] = 730,[bottomx] = 1112,[bottomy] = 930,[note] = '',[spawnid] = 1,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 3,[maxrandomflock] = 2,[randomcenterx] = 1012,[randomcentery] = 830
                ,[randomradius] = 5,[dynamiclifetime] = '' ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;



SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'random_v2_1_NEW_02_Arkhe' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'random_v2_1_NEW_02_Arkhe',[topx] = 1023,[topy] = 710,[bottomx] = 1223,[bottomy] = 910,[note] = '',[spawnid] = 1,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 3,[maxrandomflock] = 2,[randomcenterx] = 1123,[randomcentery] = 810
                ,[randomradius] = 5,[dynamiclifetime] = '' ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_dummy_decoy' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_random_arkhe_basic_rank0_3member_60sec' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_random_arkhe_basic_rank0_3member_60sec' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 1473, [spawnoriginX] = 1123, [spawnoriginY] = 808 ,[spawnrangeMin] = 0, [spawnrangeMax] = 0,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 0, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'random_v2_1_NEW_03_Arkhe' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'random_v2_1_NEW_03_Arkhe',[topx] = 1001,[topy] = 812,[bottomx] = 1201,[bottomy] = 1012,[note] = '',[spawnid] = 1,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 3,[maxrandomflock] = 2,[randomcenterx] = 1101,[randomcentery] = 912
                ,[randomradius] = 5,[dynamiclifetime] = '' ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

-------------Removes Vektor Rank2 spawn close to the Terminal and removes Sequers----------
PRINT '-------------Removes Vektor Rank2 spawn close to the Terminal and removes Sequers----------'
 
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'tma_fort_donnerth' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'tma_fort_donnerth',[topx] = 7,[topy] = 7,[bottomx] = 2040,[bottomy] = 2040,[note] = 'tm npc set',[spawnid] = 1,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;
				
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'argano_by_terminal' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'argano_by_terminal' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2397, [spawnoriginX] = 1120, [spawnoriginY] = 820 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 15 ,[note] = 'argano_by_terminal', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'sequer_by_terminal' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'sequer_by_terminal' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2402, [spawnoriginX] = 1120, [spawnoriginY] = 820 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 15 ,[note] = 'sequer_by_terminal', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'laird_by_terminal' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'laird_by_terminal' ,[presenceid] = @presenceID, [flockmembercount] = 4, [definition] = 2402, [spawnoriginX] = 1120, [spawnoriginY] = 920 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 15 ,[note] = 'laird_by_terminal', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'sequer_by_terminal2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'sequer_by_terminal2' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2397, [spawnoriginX] = 1115, [spawnoriginY] = 660 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 15 ,[note] = 'sequer_by_terminal2', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'locust_with_sequer' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'locust_with_sequer' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5556, [spawnoriginX] = 1115, [spawnoriginY] = 660 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 15 ,[note] = 'locust_with_sequer', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'vektor_in_da_hood' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'vektor_in_da_hood' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5548, [spawnoriginX] = 1045, [spawnoriginY] = 1020 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 15 ,[note] = 'vektor_in_da_hood', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'this_little_laird' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'this_little_laird' ,[presenceid] = @presenceID, [flockmembercount] = 4, [definition] = 2403, [spawnoriginX] = 800, [spawnoriginY] = 940 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 15 ,[note] = 'went_to_the_market', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'this_little_sequer' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'this_little_sequer' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2397, [spawnoriginX] = 800, [spawnoriginY] = 940 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 15 ,[note] = 'got_cancer', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'this_little_sequer' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'this_little_sequer' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2407, [spawnoriginX] = 1400, [spawnoriginY] = 760 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 15 ,[note] = 'got_the_space_aids', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_termis_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'this_little_termis' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'this_little_termis' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2413, [spawnoriginX] = 1400, [spawnoriginY] = 760 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 15 ,[note] = 'got_ghanked_by_an_observer', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;

---------------Omega Loot Change------------------
PRINT '---------------Omega Loot Change------------------'

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_guard' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_medium_lasercrystal_d' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=10000, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=8000 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2500, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=2000 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_thelodica' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2000, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=1500 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_damage_mod_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_exp_armor_hardener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_10' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_5' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.02, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_6' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.02, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_7' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.01, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_8' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.01, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_9' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_advanced' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=3, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_expert' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=7, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_thelodica_advanced' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_thelodica_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=3, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_thelodica_expert' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=7, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_damage_mod_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_damage_mod_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.175, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_exp_armor_hardener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_kinetic_kers' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.175, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_missile_launcher' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_weapon_stabilizer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_thelodica_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=10000, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=8000 WHERE [id]=@npclootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_guard' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_medium_railgun_d' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=10000, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=5000 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2500, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=2000 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_nuimqol' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2000, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=1500 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_damage_mod_railgun' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_railgun' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_resistant_plating' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_thrm_armor_hardener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_nuimqol_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=10000, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=8000 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_10' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_5' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.02, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_6' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.02, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_7' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.01, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_8' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.01, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_9' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_advanced' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=3, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_expert' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=7, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_nuimqol_advanced' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_nuimqol_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=3, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_nuimqol_expert' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=7, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_damage_mod_railgun' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_damage_mod_railgun' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.175, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_explosive_kers' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_railgun' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_railgun' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.175, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_missile_launcher' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_resistant_plating' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_thrm_armor_hardener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_weapon_stabilizer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_guard' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_missile_d' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=10000, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=8000 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2500, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=2000 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_pelistal' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2000, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=1500 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_damage_mod_missile' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_kin_armor_hardener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_missile_launcher' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_pelistal_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=10000, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=8000 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_10' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_5' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.02, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_6' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.02, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_7' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.01, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_8' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.01, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_9' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_advanced' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=3, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_expert' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=7, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_pelistal_advanced' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_pelistal_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=3, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_pelistal_expert' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=7, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_damage_mod_missile' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_damage_mod_missile' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.175, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_kin_armor_hardener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_railgun' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_missile_launcher' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_missile_launcher' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.175, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_thermal_kers' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_weapon_stabilizer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

---------------------NPC LOOT UPDATES-------------------------------
PRINT '---------------------NPC LOOT UPDATES-------------------------------'

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ikarus_abstrans_rank1' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=10, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=5 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_sensor_jammer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_sensor_dampener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_webber' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_armor_repairer_upgrade' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_energy_vampire' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_resistant_plating' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_1' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_2' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=25, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=20 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=25, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=15 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_industrial' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=25, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=15 WHERE [id]=@npclootID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ikarus_abstrans_rank2' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=15, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=10 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_advanced' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_sensor_jammer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_sensor_jammer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_sensor_dampener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_sensor_dampener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_webber' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_webber' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_armor_repairer_upgrade' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_armor_repairer_upgrade' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_energy_vampire' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_energy_vampire' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_resistant_plating' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_resistant_plating' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_1' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_2' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_3' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_4' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=35, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=20 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=50, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=25 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_industrial' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=50, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=20 WHERE [id]=@npclootID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ikarus_abstrans_rank3' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=20, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=10 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_advanced' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=15, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=10 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_expert' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_sensor_jammer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_sensor_jammer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_sensor_dampener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_sensor_dampener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_webber' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_webber' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_armor_repairer_upgrade' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_armor_repairer_upgrade' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_energy_vampire' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_energy_vampire' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_resistant_plating' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_resistant_plating' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_1' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.1, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_2' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.08, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_3' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_4' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.01, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_5' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_6' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=50, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=25 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_egg_industrial_medium_basic_capsule' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.01, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=100, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=50 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_industrial' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=85, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=60 WHERE [id]=@npclootID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ikarus_abstrans_rank4' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=25, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=20 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_advanced' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=20, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=15 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_expert' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=15, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=10 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_sensor_jammer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_sensor_jammer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_sensor_dampener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_sensor_dampener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_webber' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_webber' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_armor_repairer_upgrade' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_armor_repairer_upgrade' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_energy_vampire' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_energy_vampire' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_resistant_plating' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_resistant_plating' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_1' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.02, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_2' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.02, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_3' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.01, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_4' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.01, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_5' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_6' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=80, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=50 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_egg_industrial_medium_basic_capsule' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.01, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=125, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=100 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_industrial' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=85, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=20 WHERE [id]=@npclootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank1' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_exp_armor_hardener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_small_lasercrystal_d' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=20, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_damage_mod_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=10, [probability]=0.5, [repackaged]=0, [dontdamage]=1, [minquantity]=5 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_thelodica_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5, [probability]=0, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_1' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_2' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_thelodica_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=45, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=37 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=50, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=45 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_thelodica' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=24, [probability]=0, [repackaged]=0, [dontdamage]=1, [minquantity]=16 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=24, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=16 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_small_projectile_a' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=15, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=10 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_autocannon' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.15, [repackaged]=0, [dontdamage]=0, [minquantity]=0 WHERE [id]=@npclootID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_exp_armor_hardener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_small_lasercrystal_d' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=20, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_damage_mod_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=10, [probability]=0.5, [repackaged]=0, [dontdamage]=1, [minquantity]=5 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_thelodica_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5, [probability]=0, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_1' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_2' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_thelodica_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=45, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=37 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=48, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=32 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_thelodica' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=24, [probability]=0, [repackaged]=0, [dontdamage]=1, [minquantity]=16 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=75, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=35 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_small_projectile_a' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=25, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=10 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_autocannon' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.15, [repackaged]=0, [dontdamage]=0, [minquantity]=0 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_3' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 1,1, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_4' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 1,1, 1);

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank3' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_exp_armor_hardener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_small_lasercrystal_d' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=20, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_damage_mod_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_laser' ORDER BY definition DESC);
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
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_2' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_thelodica_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=45, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=37 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=48, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=32 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_thelodica' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=24, [probability]=0, [repackaged]=0, [dontdamage]=1, [minquantity]=16 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=152, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=100 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_small_projectile_a' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=45, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=20 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_autocannon' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.15, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=35, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=12 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_armor_plate' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_armor_repairer' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_eccm' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_sensor_booster' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_sensor_booster' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_autocannon' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank4' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_exp_armor_hardener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_small_lasercrystal_d' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=20, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_damage_mod_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=50, [probability]=0.5, [repackaged]=0, [dontdamage]=1, [minquantity]=40 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_thelodica_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5, [probability]=0, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_1' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_2' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_thelodica_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=45, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=37 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=48, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=32 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_thelodica' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=24, [probability]=0, [repackaged]=0, [dontdamage]=1, [minquantity]=16 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=315, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=210 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_small_projectile_a' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=50, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=25 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_autocannon' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.15, [repackaged]=0, [dontdamage]=0, [minquantity]=0 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=48, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=12 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_autocannon' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_sensor_dampener' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_eccm' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_armor_plate' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_small_armor_plate' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_armor_repairer' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_small_armor_repairer' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_sensor_booster' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_sensor_booster' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_eccm' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_eccm' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_3' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 1,1, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_4' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 1,1, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_5' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 1,1, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_6' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 1,1, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_7' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 1,1, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_advanced' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 50, 0.5, 1,1, 40);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_expert' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 50, 0.5, 1,1, 10);

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank1' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_small_lasercrystal_d' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=20, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=24, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=16 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_thelodica' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=12, [probability]=0, [repackaged]=0, [dontdamage]=1, [minquantity]=8 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_1' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_2' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5, [probability]=0.5, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_thelodica_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5, [probability]=0, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_damage_mod_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_thelodica_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=23, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=20 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_autocannon' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.15, [repackaged]=1, [dontdamage]=1, [minquantity]=0 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_small_projectile_a' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=15, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=10 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=35, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=25 WHERE [id]=@npclootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank2' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_small_lasercrystal_d' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=20, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=24, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=16 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_thelodica' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=12, [probability]=0, [repackaged]=0, [dontdamage]=1, [minquantity]=8 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_1' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_2' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5, [probability]=0.5, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_thelodica_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5, [probability]=0, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_damage_mod_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_thelodica_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=23, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=20 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_autocannon' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=1, [dontdamage]=1, [minquantity]=0 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_small_projectile_a' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=35, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=15 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=50, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=35 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=0 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_autocannon' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=0 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_sensor_booster' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.15, 1,1, 0);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_sensor_booster' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 0);


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank3' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_small_lasercrystal_d' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=20, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=35, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=30 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_thelodica' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=12, [probability]=0, [repackaged]=0, [dontdamage]=1, [minquantity]=8 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_1' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_2' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5, [probability]=0.5, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_thelodica_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5, [probability]=0, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_damage_mod_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_thelodica_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=23, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=20 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_autocannon' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.15, [repackaged]=1, [dontdamage]=1, [minquantity]=0 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_small_projectile_a' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=35, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=5 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=75, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=50 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=0 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_autocannon' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=0 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=55, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=35 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_small_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=0 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_small_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=0 WHERE [id]=@npclootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank4' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_small_lasercrystal_d' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=20, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=50, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=45 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_thelodica' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=12, [probability]=0, [repackaged]=0, [dontdamage]=1, [minquantity]=8 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_1' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_2' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=25, [probability]=0.5, [repackaged]=0, [dontdamage]=1, [minquantity]=15 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_thelodica_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5, [probability]=0, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_damage_mod_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_thelodica_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=23, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=20 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_autocannon' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.15, [repackaged]=1, [dontdamage]=1, [minquantity]=0 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_small_projectile_a' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=40, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=20 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=125, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=100 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=0 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_autocannon' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=0 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=85, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=80 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_small_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=0 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_small_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.1, [repackaged]=0, [dontdamage]=0, [minquantity]=0 WHERE [id]=@npclootID;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_3' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 1,1, 0);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_4' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 1,1, 0);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_5' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 1,1, 0);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_6' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 1,1, 0);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_8' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 1,1, 0);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_7' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 1,1, 0);



----------Grand Observers respawn time moved to 2 hours------------
PRINT '----------Grand Observers respawn time moved to 2 hours------------'

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_grandobservers_npcs' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'hershfield_grandobservers_npcs',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = 'caravan',[spawnid] = 13,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 7200,[presencetype] = 1,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_roaming_arbalest_alpha' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'arby_grand_observer' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'arby_grand_observer' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2871, [spawnoriginX] = 849, [spawnoriginY] = 560 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 7200, [totalspawncount] = 0, [homerange] = 50 ,[note] = 'grand_observer', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_grandobservers2_npcs' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'hershfield_grandobservers2_npcs',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = 'caravan',[spawnid] = 13,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 7200,[presencetype] = 1,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_roaming_baphomet_alpha' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'baph_grand_observer' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'baph_grand_observer' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2872, [spawnoriginX] = 849, [spawnoriginY] = 560 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 7200, [totalspawncount] = 0, [homerange] = 50 ,[note] = 'baph_grand_observer', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_grandobservers3_npcs' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'hershfield_grandobservers3_npcs',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = 'caravan',[spawnid] = 13,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 7200,[presencetype] = 1,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_roaming_waspish_alpha' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'waspish_grand_observer' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'waspish_grand_observer' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2873, [spawnoriginX] = 849, [spawnoriginY] = 560 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 7200, [totalspawncount] = 0, [homerange] = 50 ,[note] = 'waspish_grand_observer', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;



GO

DECLARE @definitionID int;
DECLARE @lootdefinitionID int;
DECLARE @npclootID int;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank1' ORDER BY definition DESC);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 223, 1, 0,1, 182);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 120, 1, 0,1, 80);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 25, 1, 0,1, 20);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 5, 0.5, 0,1, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_1' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.005, 0,1, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_2' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.005, 0,1, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_armor_plate' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_armor_repairer' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_chm_armor_hardener' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_sensor_booster' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_eccm' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_autocannon' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_damage_mod_projectile' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank2' ORDER BY definition DESC);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 290, 1, 0,1, 236);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 240, 1, 0,1, 160);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 50, 1, 0,1, 40);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 5, 0.5, 0,1, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_1' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.005, 0,1, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_2' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.005, 0,1, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_armor_plate' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_armor_repairer' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_chm_armor_hardener' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_sensor_booster' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_eccm' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_autocannon' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_damage_mod_projectile' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_damage_mod_projectile' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_autocannon' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_eccm' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_sensor_booster' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_chm_armor_hardener' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_armor_repairer' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_armor_plate' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_3' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_4' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_advanced' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 5, 0.5, 0,1, 5);


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank3' ORDER BY definition DESC);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 446, 1, 0,1, 365);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 480, 1, 0,1, 320);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 100, 1, 0,1, 50);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 7, 0.5, 0,1, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_advanced' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 5, 0.5, 0,1, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_expert' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 2, 0.5, 0,1, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_1' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,1, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_2' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,1, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_3' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,1, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_4' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,1, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_5' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,1, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_6' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,1, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_armor_plate' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_armor_repairer' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_chm_armor_hardener' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_sensor_booster' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_eccm' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_autocannon' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_armor_plate' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_armor_repairer' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_chm_armor_hardener' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_sensor_booster' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_eccm' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_autocannon' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_damage_mod_projectile' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_damage_mod_projectile' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank3' ORDER BY definition DESC);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 446, 1, 0,1, 365);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 480, 1, 0,1, 320);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 100, 1, 0,1, 50);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 7, 0.5, 0,1, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_advanced' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 5, 0.5, 0,1, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_expert' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 2, 0.5, 0,1, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_1' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,1, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_2' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,1, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_3' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,1, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_4' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,1, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_5' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,1, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_6' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,1, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_armor_plate' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_armor_repairer' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_chm_armor_hardener' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_sensor_booster' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_eccm' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_autocannon' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_armor_plate' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_armor_repairer' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_chm_armor_hardener' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_sensor_booster' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_eccm' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_autocannon' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_damage_mod_projectile' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_damage_mod_projectile' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank4' ORDER BY definition DESC);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 670, 1, 0,1, 548);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 0, 0, 0,1, 0);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 240, 1, 0,1, 160);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 2, 0.5, 0,1, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_advanced' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 5, 0.5, 0,1, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_expert' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 7, 0.5, 0,1, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_1' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,1, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_2' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,1, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_3' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,1, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_4' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,1, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_5' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,1, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_6' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,1, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_armor_plate' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_armor_repairer' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_chm_armor_hardener' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_sensor_booster' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_eccm' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_autocannon' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_armor_plate' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_armor_repairer' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_chm_armor_hardener' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_sensor_booster' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_eccm' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_autocannon' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_damage_mod_projectile' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_damage_mod_projectile' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_7' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_8' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_9' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.01, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_10' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.01, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_armor_plate' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_armor_repairer' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_chm_armor_hardener' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_sensor_booster' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_autocannon' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);

GO



-----------------------INCREASE HOME RANGE FROM 10 OR 15 TO 30----------------------------
PRINT '-----------------------INCREASE HOME RANGE FROM 10 OR 15 TO 30----------------------------'

DECLARE @presenceID int
DECLARE @flockID int;
DECLARE @definitionID int;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'tma_fort_donnerth' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'tma_fort_donnerth',[topx] = 7,[topy] = 7,[bottomx] = 2040,[bottomy] = 2040,[note] = 'tm npc set',[spawnid] = 1,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'argano_by_terminal' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'argano_by_terminal' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2397, [spawnoriginX] = 1120, [spawnoriginY] = 820 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'argano_by_terminal', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'sequer_by_terminal' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'sequer_by_terminal' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2402, [spawnoriginX] = 1120, [spawnoriginY] = 820 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'sequer_by_terminal', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'laird_by_terminal' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'laird_by_terminal' ,[presenceid] = @presenceID, [flockmembercount] = 4, [definition] = 2402, [spawnoriginX] = 1120, [spawnoriginY] = 920 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'laird_by_terminal', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'sequer_by_terminal2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'sequer_by_terminal2' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2397, [spawnoriginX] = 1115, [spawnoriginY] = 660 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'sequer_by_terminal2', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'locust_with_sequer' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'locust_with_sequer' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5556, [spawnoriginX] = 1115, [spawnoriginY] = 660 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'locust_with_sequer', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'vektor_in_da_hood' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'vektor_in_da_hood' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5548, [spawnoriginX] = 1045, [spawnoriginY] = 1020 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'vektor_in_da_hood', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'this_little_laird' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'this_little_laird' ,[presenceid] = @presenceID, [flockmembercount] = 4, [definition] = 2403, [spawnoriginX] = 800, [spawnoriginY] = 940 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'went_to_the_market', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'this_little_sequer' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'this_little_sequer' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2408, [spawnoriginX] = 800, [spawnoriginY] = 940 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'got_cancer', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'this_little_sequer' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'this_little_sequer' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2407, [spawnoriginX] = 1400, [spawnoriginY] = 760 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'got_the_space_aids', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_termis_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'this_little_termis' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'this_little_termis' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2413, [spawnoriginX] = 1400, [spawnoriginY] = 760 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'got_ghanked_by_an_observer', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'tma_lenworth' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'tma_lenworth',[topx] = 7,[topy] = 7,[bottomx] = 2040,[bottomy] = 2040,[note] = 'tm npc set',[spawnid] = 1,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'vektor2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'vektor2' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5549, [spawnoriginX] = 1530, [spawnoriginY] = 1670 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'vektor2', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'locust2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'locust2' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5557, [spawnoriginX] = 1530, [spawnoriginY] = 1670 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'locust2', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'vektor1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'vektor1' ,[presenceid] = @presenceID, [flockmembercount] = 4, [definition] = 5548, [spawnoriginX] = 1670, [spawnoriginY] = 1450 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'vektor1', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'locust4' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'locust4' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5557, [spawnoriginX] = 1670, [spawnoriginY] = 1450 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'locust4', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'echelon1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'echelon1' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5561, [spawnoriginX] = 1890, [spawnoriginY] = 1537 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'echelon1', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'locustr2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'locustr2' ,[presenceid] = @presenceID, [flockmembercount] = 4, [definition] = 5557, [spawnoriginX] = 1890, [spawnoriginY] = 1537 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'locustr2', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'echelon2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'echelon2' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5561, [spawnoriginX] = 1680, [spawnoriginY] = 1800 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'echelon2', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'locust5' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'locust5' ,[presenceid] = @presenceID, [flockmembercount] = 4, [definition] = 5556, [spawnoriginX] = 1680, [spawnoriginY] = 1800 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'locust5', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'locust7' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'locust7' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5557, [spawnoriginX] = 1546, [spawnoriginY] = 1637 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'locust7', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ikarus_abstrans_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'abstrans3' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'abstrans3' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5553, [spawnoriginX] = 1546, [spawnoriginY] = 1637 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'abstrans3', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'vektor10' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'vektor10' ,[presenceid] = @presenceID, [flockmembercount] = 4, [definition] = 5549, [spawnoriginX] = 1450, [spawnoriginY] = 1550 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'vektor10', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'locust8' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'locust8' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5557, [spawnoriginX] = 1150, [spawnoriginY] = 1678 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'locust8', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'indygroup5' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'indygroup5' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2398, [spawnoriginX] = 1314, [spawnoriginY] = 1268 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'indygroup5', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'indygroup6' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'indygroup6' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2403, [spawnoriginX] = 1314, [spawnoriginY] = 1268 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'indygroup6', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'indygroup7' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'indygroup7' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2408, [spawnoriginX] = 1314, [spawnoriginY] = 1268 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'indygroup7', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'indygroup8' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'indygroup8' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = 2407, [spawnoriginX] = 685, [spawnoriginY] = 1320 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'indygroup8', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_termis_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'indygroup9' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'indygroup9' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2413, [spawnoriginX] = 685, [spawnoriginY] = 1320 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'indygroup9', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'locustr23' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'locustr23' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5557, [spawnoriginX] = 295, [spawnoriginY] = 1548 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'locustr23', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'vektor123' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'vektor123' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = 5548, [spawnoriginX] = 295, [spawnoriginY] = 1548 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'vektor123', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'locust8911' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'locust8911' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5557, [spawnoriginX] = 305, [spawnoriginY] = 1763 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'locust8911', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'sequer_that_got_lost' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'sequer_that_got_lost' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2408, [spawnoriginX] = 545, [spawnoriginY] = 1820 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'i_have_cancer', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'argano_that_got_killed' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'argano_that_got_killed' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2398, [spawnoriginX] = 545, [spawnoriginY] = 1820 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'argano_that_got_killed', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'echelonr3' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'echelonr3' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5561, [spawnoriginX] = 985, [spawnoriginY] = 1765 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'echelonr3', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'locust678' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'locust678' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5557, [spawnoriginX] = 985, [spawnoriginY] = 1765 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'locust678', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'tma_cadavria3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'tma_cadavria3',[topx] = 7,[topy] = 7,[bottomx] = 2040,[bottomy] = 2040,[note] = 'tm npc set',[spawnid] = 1,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Highpowered Vegetation Technician' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Highpowered Vegetation Technician' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5557, [spawnoriginX] = 900, [spawnoriginY] = 1370 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Highpowered Vegetation Technician', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Mechanized Space Exploration Drone' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Mechanized Space Exploration Drone' ,[presenceid] = @presenceID, [flockmembercount] = 5, [definition] = 5556, [spawnoriginX] = 380, [spawnoriginY] = 1600 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Mechanized Space Exploration Drone', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Experimental Planetary Expedition Machine' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Experimental Planetary Expedition Machine' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2398, [spawnoriginX] = 630, [spawnoriginY] = 1700 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Experimental Planetary Expedition Machine', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Generic Flora And Fauna Prototype' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Generic Flora And Fauna Prototype' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2403, [spawnoriginX] = 165, [spawnoriginY] = 525 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Generic Flora And Fauna Prototype', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gargoyle_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Artificial Planet Defence Entity' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Artificial Planet Defence Entity' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2418, [spawnoriginX] = 165, [spawnoriginY] = 525 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Artificial Planet Defence Entity', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Scrappie' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Scrappie' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2398, [spawnoriginX] = 650, [spawnoriginY] = 380 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Scrappie', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Ojv' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Ojv' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2408, [spawnoriginX] = 650, [spawnoriginY] = 380 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Ojv', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ikarus_abstrans_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Strategic Docking Prototype' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Strategic Docking Prototype' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5553, [spawnoriginX] = 710, [spawnoriginY] = 580 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Strategic Docking Prototype', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Digital War Management Bot' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Digital War Management Bot' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2408, [spawnoriginX] = 710, [spawnoriginY] = 580 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Digital War Management Bot', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Reactive Probe Android' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Reactive Probe Android' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5561, [spawnoriginX] = 1040, [spawnoriginY] = 195 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Reactive Probe Android', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Humanoid Mapping Bot' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Humanoid Mapping Bot' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5557, [spawnoriginX] = 1040, [spawnoriginY] = 195 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Humanoid Mapping Bot', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Greez' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Greez' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5556, [spawnoriginX] = 1400, [spawnoriginY] = 400 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Greez', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ikarus_abstrans_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Nuclear Safety Machine' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Nuclear Safety Machine' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5553, [spawnoriginX] = 655, [spawnoriginY] = 920 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Nuclear Safety Machine', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Global Science Entity' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Global Science Entity' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2408, [spawnoriginX] = 655, [spawnoriginY] = 920 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Global Science Entity', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Integrated Animal Handling Emulator' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Integrated Animal Handling Emulator' ,[presenceid] = @presenceID, [flockmembercount] = 5, [definition] = 5549, [spawnoriginX] = 490, [spawnoriginY] = 1280 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Integrated Animal Handling Emulator', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'tma_cadavria2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'tma_cadavria2',[topx] = 7,[topy] = 7,[bottomx] = 2040,[bottomy] = 2040,[note] = 'tm npc set',[spawnid] = 1,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Rational Expedition Android' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Rational Expedition Android' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2403, [spawnoriginX] = 278, [spawnoriginY] = 710 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Rational Expedition Android', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Mechanical Caretaker Technology' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Mechanical Caretaker Technology' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2398, [spawnoriginX] = 278, [spawnoriginY] = 710 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Mechanical Caretaker Technology', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Super Home Protection Emulator' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Super Home Protection Emulator' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5557, [spawnoriginX] = 315, [spawnoriginY] = 300 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Super Home Protection Emulator', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Digital Animal Control Machine' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Digital Animal Control Machine' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5549, [spawnoriginX] = 315, [spawnoriginY] = 300 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Digital Animal Control Machine', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Sensitive Emergency Repair Bot' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Sensitive Emergency Repair Bot' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5561, [spawnoriginX] = 580, [spawnoriginY] = 150 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Sensitive Emergency Repair Bot', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Neohuman Data Collection Drone' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Neohuman Data Collection Drone' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5556, [spawnoriginX] = 580, [spawnoriginY] = 150 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Neohuman Data Collection Drone', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Electronic Info Analyzing Golem' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Electronic Info Analyzing Golem' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2407, [spawnoriginX] = 852, [spawnoriginY] = 247 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Electronic Info Analyzing Golem', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Personal Emergency Response Machine' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Personal Emergency Response Machine' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2398, [spawnoriginX] = 852, [spawnoriginY] = 247 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Personal Emergency Response Machine', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'High-Powered Evasion Android' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'High-Powered Evasion Android' ,[presenceid] = @presenceID, [flockmembercount] = 4, [definition] = 2403, [spawnoriginX] = 1116, [spawnoriginY] = 467 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'High-Powered Evasion Android', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Rational Riot Control Juggernaut' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Rational Riot Control Juggernaut' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2408, [spawnoriginX] = 1116, [spawnoriginY] = 467 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Rational Riot Control Juggernaut', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gargoyle_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Universal Nullification Cyborg' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Universal Nullification Cyborg' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2418, [spawnoriginX] = 985, [spawnoriginY] = 583 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Universal Nullification Cyborg', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Advanced Repairation Technician' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Advanced Repairation Technician' ,[presenceid] = @presenceID, [flockmembercount] = 4, [definition] = 5549, [spawnoriginX] = 770, [spawnoriginY] = 710 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Advanced Repairation Technician', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'High-Powered Planet Exploration Juggernaut' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'High-Powered Planet Exploration Juggernaut' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = 5561, [spawnoriginX] = 1700, [spawnoriginY] = 815 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'High-Powered Planet Exploration Juggernaut', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Universal Mapping Entity' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Universal Mapping Entity' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5557, [spawnoriginX] = 1700, [spawnoriginY] = 815 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Universal Mapping Entity', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'General Operating Technology' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'General Operating Technology' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5557, [spawnoriginX] = 1619, [spawnoriginY] = 215 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'General Operating Technology', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Essential Construction Prototype' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Essential Construction Prototype' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2403, [spawnoriginX] = 1250, [spawnoriginY] = 520 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'Essential Construction Prototype', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'tma_cadavria' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'tma_cadavria',[topx] = 7,[topy] = 7,[bottomx] = 2040,[bottomy] = 2040,[note] = 'tm npc set',[spawnid] = 1,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'echelon_be_swinging' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'echelon_be_swinging' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5561, [spawnoriginX] = 985, [spawnoriginY] = 1765 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'echelon_be_swinging', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'locust_hung_lo' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'locust_hung_lo' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5556, [spawnoriginX] = 985, [spawnoriginY] = 1765 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'locust_hung_lo', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'weakassvektor' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'weakassvektor' ,[presenceid] = @presenceID, [flockmembercount] = 4, [definition] = 5549, [spawnoriginX] = 910, [spawnoriginY] = 1815 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'weakassvektor', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_lithus_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'lithus_swinging' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'lithus_swinging' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = 4498, [spawnoriginX] = 740, [spawnoriginY] = 1475 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'lithus_swinging', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gargoyle_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'gargoyle_hates_juice' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'gargoyle_hates_juice' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2418, [spawnoriginX] = 740, [spawnoriginY] = 1475 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'gargoyle_hates_juice', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'vektor_goat' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'vektor_goat' ,[presenceid] = @presenceID, [flockmembercount] = 4, [definition] = 5549, [spawnoriginX] = 682, [spawnoriginY] = 1136 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'vektor_goat', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'sequer_loves_grass' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'sequer_loves_grass' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2408, [spawnoriginX] = 1190, [spawnoriginY] = 1100 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'sequer_loves_grass', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'argano_rolls_up_on_you' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'argano_rolls_up_on_you' ,[presenceid] = @presenceID, [flockmembercount] = 4, [definition] = 2398, [spawnoriginX] = 1190, [spawnoriginY] = 1100 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'argano_rolls_up_on_you', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'vektor_rooterupper' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'vektor_rooterupper' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5549, [spawnoriginX] = 1415, [spawnoriginY] = 1010 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'vektor_rooterupper', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'sequer_basic_role_too' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'sequer_basic_role_too' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2408, [spawnoriginX] = 1210, [spawnoriginY] = 855 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'sequer_basic_role_too', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_termis_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'termis_be_hangingupside_down' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'termis_be_hangingupside_down' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2413, [spawnoriginX] = 1210, [spawnoriginY] = 855 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'termis_be_hangingupside_down', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'vektor_groupie' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'vektor_groupie' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5549, [spawnoriginX] = 1020, [spawnoriginY] = 698 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'vektor_groupie', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'laird_basic_group3' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'laird_basic_group3' ,[presenceid] = @presenceID, [flockmembercount] = 4, [definition] = 2403, [spawnoriginX] = 970, [spawnoriginY] = 950 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'laird_basic_group3', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'sequer_group_five' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'sequer_group_five' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2408, [spawnoriginX] = 920, [spawnoriginY] = 754 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'sequer_group_five', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'vektor_Swab_rank3' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'vektor_Swab_rank3' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5549, [spawnoriginX] = 920, [spawnoriginY] = 754 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'vektor_swab_rank3', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'renaming_cause_bler_asked_me_too' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'renaming_cause_bler_asked_me_too' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5557, [spawnoriginX] = 353, [spawnoriginY] = 835 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'renaming_cause_bler_asked_me_too', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 0, [behaviorType] = 1 WHERE id=@flockID;


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'tma_antiafksequerscum3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'tma_antiafksequerscum3',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = 'ezek mennek a tengerparton korbe meg be',[spawnid] = 1,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 1800,[presencetype] = 1,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'tmaroamingsequer6' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'tmaroamingsequer6' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = 2397, [spawnoriginX] = 0, [spawnoriginY] = 0 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 1800, [totalspawncount] = 0, [homerange] = 50 ,[note] = 'tmaroamingsequer6', [respawnmultiplierlow] = 0, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'tmaroamingsequer7' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'tmaroamingsequer7' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = 2402, [spawnoriginX] = 0, [spawnoriginY] = 0 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 1800, [totalspawncount] = 0, [homerange] = 50 ,[note] = 'tmaroamingsequer7', [respawnmultiplierlow] = 0, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'tmaroamingsequer8' ORDER BY id DESC);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'tmaroamingsequer8' ORDER BY id DESC);
DELETE FROM [dbo].[npcflock] WHERE id=@flockID;


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'tma_antiafksequerscum2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'tma_antiafksequerscum2',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = 'ezek mennek a tengerparton korbe meg be',[spawnid] = 1,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 1800,[presencetype] = 1,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'roamingtmasequer' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'roamingtmasequer' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = 2397, [spawnoriginX] = 800, [spawnoriginY] = 940 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 1800, [totalspawncount] = 0, [homerange] = 50 ,[note] = 'NEW FLOCK, WRITE NOTE!', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'roamingtmasequer2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'roamingtmasequer2' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = 2402, [spawnoriginX] = 1595, [spawnoriginY] = 1513 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 1800, [totalspawncount] = 0, [homerange] = 50 ,[note] = 'NEW FLOCK, WRITE NOTE!', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'roamingtmasequer3' ORDER BY id DESC);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'roamingtmasequer3' ORDER BY id DESC);
DELETE FROM [dbo].[npcflock] WHERE id=@flockID;


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'tma_antiafksequerscum' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'tma_antiafksequerscum',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = 'ezek mennek a tengerparton korbe meg be',[spawnid] = 1,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 1800,[presencetype] = 1,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'the_joker_is_me' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'the_joker_is_me' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = 2397, [spawnoriginX] = 0, [spawnoriginY] = 0 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 1800, [totalspawncount] = 0, [homerange] = 50 ,[note] = 'the_joker_is_me', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'the_joker_is_me2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'the_joker_is_me2' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = 2402, [spawnoriginX] = 0, [spawnoriginY] = 0 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 1800, [totalspawncount] = 0, [homerange] = 50 ,[note] = 'the_joker_is_me2', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'the_joker_is_me3' ORDER BY id DESC);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'the_joker_is_me3' ORDER BY id DESC);
DELETE FROM [dbo].[npcflock] WHERE id=@flockID;


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_theolodical_npcs' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'hershfield_theolodical_npcs',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_prometheus_interceptor_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'prom_at_spawn31' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'prom_at_spawn31' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 1160, [spawnoriginX] = 740, [spawnoriginY] = 550 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'prom_at_spawn31', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_intakt_ewjammer_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'intakt_at_spawn32' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'intakt_at_spawn32' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1165, [spawnoriginX] = 620, [spawnoriginY] = 720 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'intakt_at_spawn32', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_baphomet_dps_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'baph_at_spawn32' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'baph_at_spawn32' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1185, [spawnoriginX] = 620, [spawnoriginY] = 720 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'baph_at_spawn32', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_prometheus_dps_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'prom_at_spwn33' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'prom_at_spwn33' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 1156, [spawnoriginX] = 520, [spawnoriginY] = 920 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'prom_at_spwn33', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_intakt_ewjammer_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'intakt_at_spwn33' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'intakt_at_spwn33' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1166, [spawnoriginX] = 520, [spawnoriginY] = 920 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'intakt_at_spwn33', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_baphomet_scout_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'baph_at_spwn34' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'baph_at_spwn34' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1180, [spawnoriginX] = 455, [spawnoriginY] = 740 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'baph_at_spwn34', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_tank_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'art_at_spwn35' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'art_at_spwn35' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 1205, [spawnoriginX] = 820, [spawnoriginY] = 320 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'art_at_spwn35', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_intakt_heavyew_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'intakt_at_spwn35' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'intakt_at_spwn35' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1170, [spawnoriginX] = 820, [spawnoriginY] = 320 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'intakt_at_spwn35', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_heavydps_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'hm_at_spawn36' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'hm_at_spawn36' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 1216, [spawnoriginX] = 600, [spawnoriginY] = 430 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'hm_at_spawn36', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_ew_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mech_at_spawn36' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mech_at_spawn36' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1201, [spawnoriginX] = 600, [spawnoriginY] = 430 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mech_at_spawn36', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_sniper_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'sethsnip_at_spawn37' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'sethsnip_at_spawn37' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1211, [spawnoriginX] = 430, [spawnoriginY] = 540 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'sethsnip_at_spawn37', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_tank_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'sethtank_at_spawn37' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'sethtank_at_spawn37' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1226, [spawnoriginX] = 430, [spawnoriginY] = 540 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'sethtank_at_spawn37', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_zenith_heavyew_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mechew_at_spawn37' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mechew_at_spawn37' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2019, [spawnoriginX] = 430, [spawnoriginY] = 540 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mechew_at_spawn37', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_zenith_heavyew_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mechew_at_spawn38' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mechew_at_spawn38' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2019, [spawnoriginX] = 550, [spawnoriginY] = 250 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mechew_at_spawn38', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_dps_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'art_at_spwn38' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'art_at_spwn38' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1194, [spawnoriginX] = 550, [spawnoriginY] = 250 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'art_at_spwn38', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_heavydps_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'hm_at_spwn39' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'hm_at_spwn39' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 1216, [spawnoriginX] = 260, [spawnoriginY] = 650 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'hm_at_spwn39', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_sniper_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'hm2_at_spwn39' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'hm2_at_spwn39' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = 1211, [spawnoriginX] = 260, [spawnoriginY] = 650 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'hm2_spwn39', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_zenith_heavyew_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mechew_at_spwn39' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mechew_at_spwn39' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2019, [spawnoriginX] = 260, [spawnoriginY] = 650 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mechew_at_spwn39', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_baphomet_dps_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'bapho_at_spwn30' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'bapho_at_spwn30' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1184, [spawnoriginX] = 385, [spawnoriginY] = 300 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'bapho_at_spwn30', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_dps_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mech_at_spwn30' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mech_at_spwn30' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1194, [spawnoriginX] = 385, [spawnoriginY] = 300 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mech_at_spwn30', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_syndicate_npcs' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'hershfield_syndicate_npcs',[topx] = 959,[topy] = 283,[bottomx] = 1159,[bottomy] = 483,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mech_at_spawn1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mech_at_spawn1' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5562, [spawnoriginX] = 1590, [spawnoriginY] = 1550 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mech_at_spawn1', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'hm_at_spawn1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'hm_at_spawn1' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5566, [spawnoriginX] = 1590, [spawnoriginY] = 1550 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'hm_at_spawn1', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'assault_at_spawn2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'assault_at_spawn2' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5558, [spawnoriginX] = 1370, [spawnoriginY] = 1720 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'assault_at_spawn2', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'light_at_spawn2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'light_at_spawn2' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5550, [spawnoriginX] = 864, [spawnoriginY] = 962 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'light_at_spawn2', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'hm_at_spawn3' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'hm_at_spawn3' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5567, [spawnoriginX] = 1080, [spawnoriginY] = 1870 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'hm_at_spawn3', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mech_at_spawn3' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mech_at_spawn3' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5561, [spawnoriginX] = 1080, [spawnoriginY] = 1870 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mech_at_spawn3', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mech_at_spawn4' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mech_at_spawn4' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5563, [spawnoriginX] = 1410, [spawnoriginY] = 1090 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mech_at_spawn4', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'light_at_spawn4' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'light_at_spawn4' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5551, [spawnoriginX] = 1410, [spawnoriginY] = 1090 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'light_at_spawn4', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'hm_at_spawn5' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'hm_at_spawn5' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5565, [spawnoriginX] = 1170, [spawnoriginY] = 1020 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'hm_at_spawn5', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'assault_at_spawn_6' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'assault_at_spawn_6' ,[presenceid] = @presenceID, [flockmembercount] = 4, [definition] = 5559, [spawnoriginX] = 1350, [spawnoriginY] = 780 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'assault_at_spawn6', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ikarus_abstrans_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'lighttrans_at_spawn6' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'lighttrans_at_spawn6' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 5555, [spawnoriginX] = 1350, [spawnoriginY] = 780 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'lighttrans_at_spawn6', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mech_at_spawn7' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mech_at_spawn7' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5561, [spawnoriginX] = 940, [spawnoriginY] = 1111 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mech_at_spawn7', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'light_at_spawn8' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'light_at_spawn8' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5550, [spawnoriginX] = 760, [spawnoriginY] = 935 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'light_at_spawn8', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'assault_at_spawn9' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'assault_at_spawn9' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5558, [spawnoriginX] = 940, [spawnoriginY] = 590 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'assault_at_spawn9', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'light_at_spawn10' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'light_at_spawn10' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 5559, [spawnoriginX] = 1160, [spawnoriginY] = 640 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'light_at_spawn10', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_pelistal_npcs' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'hershfield_pelistal_npcs',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_castel_scout_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'castel_at_spawn21' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'castel_at_spawn21' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 1314, [spawnoriginX] = 1290, [spawnoriginY] = 1410 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'castel_at_21', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_troiar_interceptor_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'troiar_at_spawn22' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'troiar_at_spawn22' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1335, [spawnoriginX] = 1180, [spawnoriginY] = 1490 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'troiar_at_spawn22', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_waspish_dps_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'wasp_at_spn22' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'wasp_at_spn22' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1349, [spawnoriginX] = 1180, [spawnoriginY] = 1490 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'wasp_at_spn22', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_castel_dps_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'castel_at_spn23' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'castel_at_spn23' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 1320, [spawnoriginX] = 1030, [spawnoriginY] = 1390 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'castel_at_spn23', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_troiar_ewjammer_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'troiar_at_spn23' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'troiar_at_spn23' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1330, [spawnoriginX] = 1030, [spawnoriginY] = 1390 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'troiar_at_spn23', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_waspish_scout_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'wasp_at_spn24' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'wasp_at_spn24' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 1344, [spawnoriginX] = 940, [spawnoriginY] = 1500 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'def_npc_waspish_scout_rank3', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_tank_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mech_at_spn25' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mech_at_spn25' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 1369, [spawnoriginX] = 740, [spawnoriginY] = 1450 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'def_npc_tyrannos_tank_rank3', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_troiar_heavyew_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'lew_at_spn25' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'lew_at_spn25' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1339, [spawnoriginX] = 740, [spawnoriginY] = 1450 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'lew_at_spn25', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_heavydps_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'hm_at_spwn26' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'hm_at_spwn26' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 1380, [spawnoriginX] = 600, [spawnoriginY] = 1485 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'hm_at_spwn26', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_ew_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mech_at_spwn26' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mech_at_spwn26' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1365, [spawnoriginX] = 600, [spawnoriginY] = 1485 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mech_at_spwn26', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_sniper_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'hm_at_spwn27' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'hm_at_spwn27' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1375, [spawnoriginX] = 690, [spawnoriginY] = 1700 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'hm_at_spn27', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_tank_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'hm2_spwn27' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'hm2_spwn27' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1390, [spawnoriginX] = 690, [spawnoriginY] = 1700 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'hm2_spwn27', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ictus_heavyew_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mech_spwn27' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mech_spwn27' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2044, [spawnoriginX] = 690, [spawnoriginY] = 1700 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mech_spwn27', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ictus_heavyew_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mech_spwn28' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mech_spwn28' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2044, [spawnoriginX] = 500, [spawnoriginY] = 1730 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mech_spwn28', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_dps_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mech2_spwn28' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mech2_spwn28' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1358, [spawnoriginX] = 500, [spawnoriginY] = 1730 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mech2_spwn28', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_heavydps_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'hm1_atspwn29' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'hm1_atspwn29' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 1380, [spawnoriginX] = 400, [spawnoriginY] = 1560 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'hm1_at_spn29', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_sniper_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'hm2_at_spwn29' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'hm2_at_spwn29' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = 1375, [spawnoriginX] = 400, [spawnoriginY] = 1560 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'hm2_at_spwn29', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ictus_heavyew_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mech_at_spwn29' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mech_at_spwn29' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2044, [spawnoriginX] = 400, [spawnoriginY] = 1560 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mech_at_spwn29', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_waspish_dps_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'assault_at_spwn30' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'assault_at_spwn30' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1348, [spawnoriginX] = 240, [spawnoriginY] = 1700 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'assault_at_spwn30', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_dps_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mech_at_spwn30' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mech_at_spwn30' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1358, [spawnoriginX] = 240, [spawnoriginY] = 1700 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mech_at_spawn30', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_numiquol_npcs' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'hershfield_numiquol_npcs',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_scout_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'yagel_at_spawn41' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'yagel_at_spawn41' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 1234, [spawnoriginX] = 1510, [spawnoriginY] = 620 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'yagel_at_spawn41', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_cameleon_interceptor_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'cam_at_spawn42' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'cam_at_spawn42' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1259, [spawnoriginX] = 1540, [spawnoriginY] = 450 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'cam_at_spawn42', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_dps_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'arby_at_spawn42' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'arby_at_spawn42' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1269, [spawnoriginX] = 1540, [spawnoriginY] = 450 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'arby_at_spwn42', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_dps_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'yagel_at_spawn43' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'yagel_at_spawn43' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 1240, [spawnoriginX] = 1350, [spawnoriginY] = 320 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'yagel_at_spawn43', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_cameleon_ewjammer_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'cam_at_spawn43' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'cam_at_spawn43' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1250, [spawnoriginX] = 1350, [spawnoriginY] = 320 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'cam_at_spawn43', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_scout_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'arby_at_spwn44' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'arby_at_spwn44' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 1264, [spawnoriginX] = 1260, [spawnoriginY] = 420 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'arby_at_spawn44', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_tank_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'kain_at_spawn45' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'kain_at_spawn45' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 1289, [spawnoriginX] = 1170, [spawnoriginY] = 420 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'kain_at_spawn45', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_cameleon_heavyew_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'cam_at_spawn45' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'cam_at_spawn45' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1254, [spawnoriginX] = 1170, [spawnoriginY] = 420 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'cam_at_spawn45', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_heavydps_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mesmer_at_spawn46' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mesmer_at_spawn46' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 1300, [spawnoriginX] = 1030, [spawnoriginY] = 380 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mesmer_at_spawn46', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_ew_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'kain_at_spawn46' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'kain_at_spawn46' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1285, [spawnoriginX] = 1030, [spawnoriginY] = 380 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'kain_at_spawn46', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_sniper_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mesmer_at_spawn47' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mesmer_at_spawn47' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1295, [spawnoriginX] = 1320, [spawnoriginY] = 540 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mesmer_at_spawn47', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_tank_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mesmer2_at_spawn47' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mesmer2_at_spawn47' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1310, [spawnoriginX] = 1320, [spawnoriginY] = 540 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mesmer2_at_spawn47', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vagabond_heavyew_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'vag_at_spawn47' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'vag_at_spawn47' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2014, [spawnoriginX] = 1320, [spawnoriginY] = 540 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'vag_at_span47', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vagabond_heavyew_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'vag_at_spawn48' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'vag_at_spawn48' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2014, [spawnoriginX] = 1470, [spawnoriginY] = 290 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'vag_at_spawn48', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_dps_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'kain_at_spawn48' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'kain_at_spawn48' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1278, [spawnoriginX] = 1470, [spawnoriginY] = 290 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'kain_at_spawn48', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_heavydps_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mesmer_at_spawn49' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mesmer_at_spawn49' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 1300, [spawnoriginX] = 1290, [spawnoriginY] = 280 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mesmer_at_spawn49', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_sniper_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mesmer2_at_spawn49' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mesmer2_at_spawn49' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = 1295, [spawnoriginX] = 1290, [spawnoriginY] = 280 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mesmer_at_spawn49', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vagabond_heavyew_rank4' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'vag_at_spawn49' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'vag_at_spawn49' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = 2014, [spawnoriginX] = 1290, [spawnoriginY] = 280 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'vag_at_spawn49', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_dps_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'arby_at_50' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'arby_at_50' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1268, [spawnoriginX] = 1320, [spawnoriginY] = 190 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'arby_at_spawn50', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_dps_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'kain_at_50' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'kain_at_50' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 1278, [spawnoriginX] = 1320, [spawnoriginY] = 190 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'kain_at_50', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_industrials_npcs' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'hershfield_industrials_npcs',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

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
UPDATE [dbo].[npcflock] SET [name] = 'hmindy_at_spawn13' ,[presenceid] = @presenceID, [flockmembercount] = 4, [definition] = 2430, [spawnoriginX] = 1765, [spawnoriginY] = 1710 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'hmindy_at_spawn13', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;
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


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_grandobservers3_npcs' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'hershfield_grandobservers3_npcs',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = 'caravan',[spawnid] = 13,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 7200,[presencetype] = 1,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_roaming_waspish_alpha' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'waspish_grand_observer' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'waspish_grand_observer' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2873, [spawnoriginX] = 849, [spawnoriginY] = 560 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 7200, [totalspawncount] = 0, [homerange] = 50 ,[note] = 'waspish_grand_observer', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_grandobservers2_npcs' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'hershfield_grandobservers2_npcs',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = 'caravan',[spawnid] = 13,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 7200,[presencetype] = 1,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_roaming_baphomet_alpha' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'baph_grand_observer' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'baph_grand_observer' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2872, [spawnoriginX] = 849, [spawnoriginY] = 560 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 7200, [totalspawncount] = 0, [homerange] = 50 ,[note] = 'baph_grand_observer', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_grandobservers_npcs' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'hershfield_grandobservers_npcs',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = 'caravan',[spawnid] = 13,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 7200,[presencetype] = 1,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_roaming_arbalest_alpha' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'arby_grand_observer' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'arby_grand_observer' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = 2871, [spawnoriginX] = 849, [spawnoriginY] = 560 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 7200, [totalspawncount] = 0, [homerange] = 50 ,[note] = 'grand_observer', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

GO

DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
DECLARE @extensionID int;
DECLARE @chassisbonusID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vektor_leg' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_vektor_leg', quantity=1, attributeflags=1024, categoryflags=66384, options='#height=f0.35#slotFlags=420,20', 
                note='', enabled=1, volume=3, mass=1450, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2.81 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_castel_leg' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_castel_leg', quantity=1, attributeflags=1024, categoryflags=66384, options='#height=f0.5#slotFlags=420,20', 
                note='', enabled=1, volume=4, mass=1500, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=3.11 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_yagel_leg' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_yagel_leg', quantity=1, attributeflags=1024, categoryflags=66384, options='#height=f0.35#slotFlags=420,20,20', 
                note='', enabled=1, volume=4, mass=1250, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=3.41 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_leg' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_prometheus_leg', quantity=1, attributeflags=1024, categoryflags=66384, options='#height=f0.3#slotFlags=420,20,20', 
                note='', enabled=1, volume=4, mass=1875, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=3.11 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_leg' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_cameleon_leg', quantity=1, attributeflags=1024, categoryflags=66384, options='#height=f0.35#slotFlags=420,20', 
                note='', enabled=1, volume=3, mass=1250, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=3.86 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_locust_leg' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_locust_leg', quantity=1, attributeflags=1024, categoryflags=131920, options='#height=f0.5#slotFlags=420,20,20', 
                note='', enabled=1, volume=7, mass=4600, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2.78 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_arbalest_leg' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_arbalest_leg', quantity=1, attributeflags=1024, categoryflags=131920, options='#height=f0.6#slotFlags=420,20,20,20', 
                note='', enabled=1, volume=4, mass=2125, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=3.35 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_echelon_leg' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_echelon_leg', quantity=1, attributeflags=1024, categoryflags=197456, options='#height=f1.1#slotFlags=420,20,20,20,20', 
                note='', enabled=1, volume=6, mass=5800, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2.37 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vagabond_leg' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_vagabond_leg', quantity=1, attributeflags=1024, categoryflags=197456, options='#height=f1.25#slotFlags=420,20,20', 
                note='', enabled=1, volume=6, mass=3750, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2.96 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_leg' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_mesmer_leg', quantity=1, attributeflags=1024, categoryflags=262992, options='#height=f0.9#slotFlags=420,20,20,20,20', 
                note='', enabled=1, volume=7, mass=2700, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2.13 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_legatus_chassis' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_legatus_chassis', quantity=1, attributeflags=1024, categoryflags=262736, options='#height=f1.1#slotFlags=46d1,d1,d1,2d1,d1,4d1', 
                note='', enabled=1, volume=13, mass=24500, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4400 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=3850 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1200 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'resist_chemical' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=45 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'resist_explosive' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=45 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'resist_thermal' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=45 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=9 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_legatus_head' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_legatus_head', quantity=1, attributeflags=1024, categoryflags=262480, options='#height=f0.2#slotFlags=48,8,8,8', 
                note='', enabled=1, volume=3, mass=2000, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=370 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locked_targets_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=6 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locking_range' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=350 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'sensor_strength' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=90 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'blob_emission_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=30 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'blob_level_low' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=90 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'blob_level_high' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=405 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'detection_strength' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=90 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'stealth_strength' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=90 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_legatus_leg' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_legatus_leg', quantity=1, attributeflags=1024, categoryflags=262992, options='#height=f1.15#slotFlags=420,20,20,20,20,20', 
                note='', enabled=1, volume=7, mass=3150, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.766 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_chassis' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_mesmer_chassis', quantity=1, attributeflags=1024, categoryflags=262736, options='#height=f1.1#slotFlags=46d1,d1,d1,2d1,d1,4d1,4d0', 
                note='', enabled=1, volume=13, mass=24500, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=3600 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_seth_chassis' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_seth_chassis', quantity=1, attributeflags=1024, categoryflags=262736, options='#height=f0.75#slotFlags=46d1,d1,d1,2d1,d1,4d1', 
                note='', enabled=1, volume=13, mass=26000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_gropho_chassis' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_gropho_chassis', quantity=1, attributeflags=1024, categoryflags=262736, options='#height=f0.8#slotFlags=4d2,d2,2d2,2d2,4d2,4d2,4d0', 
                note='', enabled=1, volume=13, mass=24500, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4000 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vagabond_chassis' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_vagabond_chassis', quantity=1, attributeflags=1024, categoryflags=197200, options='#height=f0.45#slotFlags=44d1,4d1,d1', 
                note='', enabled=1, volume=8, mass=11000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1170 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_zenith_chassis' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_zenith_chassis', quantity=1, attributeflags=1024, categoryflags=197200, options='#height=f0.5#slotFlags=44d1,4d1,d1', 
                note='bonuszok csak armor transferre', enabled=1, volume=8, mass=10500, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1300 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_callisto_chassis' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_callisto_chassis', quantity=1, attributeflags=1024, categoryflags=197200, options='#height=f0.45#slotFlags=44d1,4d1,d1', 
                note='', enabled=1, volume=8, mass=11000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1430 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2600 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=700 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'resist_chemical' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=45 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'resist_explosive' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=45 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'resist_thermal' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=45 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=6 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_callisto_leg' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_callisto_leg', quantity=1, attributeflags=1024, categoryflags=197456, options='#height=f1#slotFlags=420,20,20,20', 
                note='', enabled=1, volume=6, mass=3250, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2.422 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_callisto_head' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_callisto_head', quantity=1, attributeflags=1024, categoryflags=196944, options='#height=f0.15#slotFlags=48,8,8,8', 
                note='', enabled=1, volume=2, mass=600, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=450 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locking_range' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=40 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'detection_strength' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=110 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'stealth_strength' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=110 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_helix_head' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_helix_head', quantity=1, attributeflags=1024, categoryflags=65872, options='#slotFlags=48,8,8', 
                note='', enabled=1, volume=1, mass=200, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=220 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locking_range' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=35 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'sensor_strength' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=110 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'detection_strength' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=75 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'stealth_strength' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=120 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_helix_chassis' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_helix_chassis', quantity=1, attributeflags=1024, categoryflags=66128, options='#height=f0.3#slotFlags=4651,651,4d0', 
                note='', enabled=1, volume=6, mass=3500, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=740 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=350 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=170 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'resist_chemical' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=45 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'resist_explosive' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=45 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'resist_thermal' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=45 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_helix_leg' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_helix_leg', quantity=1, attributeflags=1024, categoryflags=66384, options='#height=f0.5#slotFlags=420,20', 
                note='', enabled=1, volume=5, mass=2812.5, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=3.144 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_echelon_chassis' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_echelon_chassis', quantity=1, attributeflags=1024, categoryflags=197200, options='#height=f0.5#slotFlags=44d1,d1,4d1,d1', 
                note='', enabled=1, volume=11, mass=22000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=3080 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_chassis' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_kain_chassis', quantity=1, attributeflags=1024, categoryflags=197200, options='#height=f0.45#slotFlags=46d1,4d1,6d1,4d1,d2,d2', 
                note='', enabled=1, volume=11, mass=19000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2520 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_chassis' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_artemis_chassis', quantity=1, attributeflags=1024, categoryflags=197200, options='#height=f0.5#slotFlags=46d1,4d1,6d1,4d3,d2', 
                note='', enabled=1, volume=11, mass=19500, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2800 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_tyrannos_chassis' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_tyrannos_chassis', quantity=1, attributeflags=1024, categoryflags=197200, options='#height=f0.5#slotFlags=4d2,d2,d2,d2,6d1,6d1', 
                note='', enabled=1, volume=11, mass=20500, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2800 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_locust_chassis' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_locust_chassis', quantity=1, attributeflags=1024, categoryflags=131664, options='#height=f0.4#slotFlags=451,51,6d1,51,6d1', 
                note='', enabled=1, volume=8, mass=10000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1250 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_arbalest_chassis' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_arbalest_chassis', quantity=1, attributeflags=1024, categoryflags=131664, options='#height=f0.4#slotFlags=451,451,6d1,451,6d1,52', 
                note='', enabled=1, volume=9, mass=7187.5, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1000 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_baphomet_chassis' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_baphomet_chassis', quantity=1, attributeflags=1024, categoryflags=131664, options='#height=f0.5#slotFlags=4451,6d1,451,6d1,51', 
                note='', enabled=1, volume=9, mass=7312.5, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1140 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_chassis' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_cameleon_chassis', quantity=1, attributeflags=1024, categoryflags=66128, options='#height=f0.3#slotFlags=4651,651,4d0', 
                note='', enabled=1, volume=6, mass=3500, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=610 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_chassis' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_intakt_chassis', quantity=1, attributeflags=1024, categoryflags=66128, options='#height=f0.35#slotFlags=4651,651,4d0', 
                note='cloaking core drain bonus', enabled=1, volume=6, mass=3500, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=675 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vektor_chassis' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_vektor_chassis', quantity=1, attributeflags=1024, categoryflags=66128, options='#height=f0.45#slotFlags=4451,6d1,451,6d1', 
                note='', enabled=1, volume=8, mass=6000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=830 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_yagel_chassis' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_yagel_chassis', quantity=1, attributeflags=1024, categoryflags=66128, options='#height=f0.45#slotFlags=4451,6d1,451,6d3', 
                note='', enabled=1, volume=7, mass=5000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=680 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_chassis' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_prometheus_chassis', quantity=1, attributeflags=1024, categoryflags=66128, options='#height=f0.3#slotFlags=4451,6d1,451,6d3', 
                note='', enabled=1, volume=7, mass=5250, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=760 WHERE id =  @aggvalueID;


SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vektor_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'detection_strength' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 2, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vektor_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'accuracy_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_castel_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'detection_strength' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 2, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_castel_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'locking_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'detection_strength' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 2, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'critical_hit_chance' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_spec_ops_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_callisto_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'stealth_strength' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 2, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_callisto_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'effect_enhancer_sensor_dampener_locking_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_callisto_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'effect_enhancer_sensor_dampener_locking_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_spec_ops_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'stealth_strength' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 2, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'ecm_strength_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_spec_ops_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vagabond_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'stealth_strength' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 2, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vagabond_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'ecm_strength_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_spec_ops_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_troiar_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'stealth_strength' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 2, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_troiar_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'energy_neutralizer_optimal_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_troiar_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'energy_vampire_optimal_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_spec_ops_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ictus_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'stealth_strength' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 2, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ictus_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'energy_neutralizer_optimal_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ictus_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'energy_vampire_optimal_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_spec_ops_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'stealth_strength' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 2, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'effect_enhancer_sensor_dampener_locking_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'effect_enhancer_sensor_dampener_locking_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_spec_ops_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_zenith_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'stealth_strength' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 2, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_zenith_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'effect_enhancer_sensor_dampener_locking_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_zenith_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'effect_enhancer_sensor_dampener_locking_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_locust_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'accuracy_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, -0.02, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_locust_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'accuracy_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_echelon_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'accuracy_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, -0.02, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_echelon_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'accuracy_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_legatus_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'accuracy_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, -0.02, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_legatus_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'harvesting_cycle_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_arbalest_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'massiveness' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.02, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_arbalest_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'turret_fallof_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'massiveness' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.02, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'turret_fallof_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'massiveness' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.02, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'turret_fallof_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_waspish_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'locking_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.03, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_waspish_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'locking_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_tyrannos_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'locking_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.03, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_tyrannos_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'locking_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_gropho_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'locking_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.03, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_gropho_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'locking_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_baphomet_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'laser_optimal_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.01, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_baphomet_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'critical_hit_chance' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'laser_optimal_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.01, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'critical_hit_chance' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_seth_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'laser_optimal_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.01, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_seth_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'critical_hit_chance' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_syndicate_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vektor_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'signature_radius' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, -0.1, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_syndicate_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vektor_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'armor_max_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.03, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vektor_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'signature_radius' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_syndicate_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_helix_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'signature_radius' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, -0.1, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_syndicate_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_helix_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'armor_max_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.03, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_helix_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_max_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_syndicate_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_locust_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'signature_radius' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, -0.1, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_syndicate_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_locust_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'armor_max_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.03, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_locust_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'signature_radius' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_syndicate_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_echelon_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'signature_radius' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, -0.1, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_syndicate_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_echelon_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'armor_max_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.03, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_echelon_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'signature_radius' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_syndicate_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_hermes_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'signature_radius' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, -0.1, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_syndicate_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_hermes_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'armor_max_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.03, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_hermes_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'mining_probe_accuracy_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_syndicate_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_callisto_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'signature_radius' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, -0.1, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_syndicate_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_callisto_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'armor_max_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.03, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_callisto_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_recharge_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_syndicate_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_legatus_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'signature_radius' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, -0.1, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_syndicate_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_legatus_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'armor_max_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.03, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_legatus_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'shield_absorbtion_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_nuimqol_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_yagel_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.03, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_yagel_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_nuimqol_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.03, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_nuimqol_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_arbalest_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.03, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_arbalest_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_nuimqol_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.03, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_nuimqol_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vagabond_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.03, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vagabond_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_nuimqol_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.03, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_pelistal_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_troiar_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_recharge_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, -0.04, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_troiar_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_recharge_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_pelistal_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ictus_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_recharge_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, -0.04, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ictus_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_recharge_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_pelistal_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_castel_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'shield_absorbtion_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.05, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_castel_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_recharge_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_pelistal_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_waspish_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'shield_absorbtion_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.05, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_waspish_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'shield_absorbtion_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_pelistal_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_tyrannos_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'shield_absorbtion_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.05, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_tyrannos_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_recharge_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_pelistal_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_gropho_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'shield_absorbtion_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.05, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_gropho_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'shield_absorbtion_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_chemical' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=5 WHERE id = @chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_explosive' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=5 WHERE id = @chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_kinetic' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=5 WHERE id = @chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_thermal' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=5 WHERE id = @chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_chemical' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=5 WHERE id = @chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_explosive' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=5 WHERE id = @chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_kinetic' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=5 WHERE id = @chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_thermal' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=5 WHERE id = @chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_thelodica_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_chemical' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 5, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_thelodica_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_explosive' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 5, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_thelodica_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_kinetic' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 5, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_thelodica_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_thermal' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 5, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_chemical' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_explosive' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_kinetic' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_thermal' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_thelodica_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_chemical' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 5, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_thelodica_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_explosive' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 5, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_thelodica_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_kinetic' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 5, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_thelodica_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_thermal' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 5, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_chemical' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_explosive' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_kinetic' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_thermal' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_thelodica_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_baphomet_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_chemical' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 5, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_thelodica_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_baphomet_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_explosive' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 5, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_thelodica_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_baphomet_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_kinetic' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 5, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_thelodica_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_baphomet_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_thermal' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 5, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_baphomet_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_max_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_thelodica_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_chemical' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 5, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_thelodica_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_explosive' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 5, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_thelodica_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_kinetic' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 5, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_thelodica_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_thermal' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 5, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_chemical' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_explosive' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_kinetic' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_thermal' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_thelodica_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_zenith_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_chemical' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 5, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_thelodica_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_zenith_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_explosive' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 5, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_thelodica_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_zenith_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_kinetic' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 5, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_thelodica_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_zenith_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_thermal' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 5, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_zenith_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_chemical' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_zenith_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_explosive' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_zenith_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_kinetic' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_zenith_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_thermal' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_thelodica_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_seth_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_chemical' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 5, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_thelodica_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_seth_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_explosive' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 5, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_thelodica_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_seth_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_kinetic' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 5, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_thelodica_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_seth_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_thermal' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 5, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_seth_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_max_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vektor_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_small_projectile_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.03 WHERE id = @chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vektor_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'projectile_optimal_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.03, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_syndicate_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vektor_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'projectile_cycle_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vektor_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'detection_strength' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_helix_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_sensor_jammer_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.03 WHERE id = @chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_helix_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_sensor_dampener_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.03 WHERE id = @chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_helix_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_webber_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.03 WHERE id = @chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_helix_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_small_projectile_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.03, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_spec_ops_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_helix_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'stealth_strength' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_nuimqol_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_helix_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'railgun_cycle_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_locust_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_projectile_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.03 WHERE id = @chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_locust_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'projectile_optimal_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.03, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_syndicate_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_locust_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'projectile_cycle_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_locust_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'projectile_optimal_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_hermes_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_projectile_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.03 WHERE id = @chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_hermes_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'mining_probe_accuracy_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.03, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_hermes_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'mining_probe_artifact_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.03, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_syndicate_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_hermes_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'projectile_cycle_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_syndicate_industry_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_hermes_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'stealth_strength' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_hermes_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'mining_probe_artifact_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_echelon_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_medium_projectile_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.03, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_echelon_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'projectile_optimal_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.03, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_echelon_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_projectile_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_syndicate_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_echelon_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'projectile_cycle_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_echelon_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'massiveness' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_callisto_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_sensor_jammer_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.03 WHERE id = @chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_callisto_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_sensor_dampener_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.03 WHERE id = @chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_callisto_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_webber_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.03 WHERE id = @chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_callisto_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_medium_projectile_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.03, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_spec_ops_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_callisto_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'stealth_strength' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_nuimqol_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_callisto_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'railgun_cycle_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_legatus_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_medium_projectile_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.03, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_legatus_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'projectile_optimal_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.03, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_legatus_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_medium_railgun_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_nuimqol_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_legatus_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'railgun_cycle_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_legatus_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_legatus_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_chemical' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_legatus_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_explosive' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_legatus_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_kinetic' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_legatus_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_thermal' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_legatus_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_medium_railgun_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_nuimqol_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_legatus_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'railgun_cycle_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_legatus_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_legatus_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_chemical' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_legatus_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_explosive' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_legatus_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_kinetic' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_legatus_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_thermal' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_yagel_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_small_railgun_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_nuimqol_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_yagel_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'railgun_cycle_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_yagel_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_yagel_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'detection_strength' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_webber_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.03 WHERE id = @chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'ecm_strength_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.03, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_small_railgun_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.05, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_sensor_dampener_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_sensor_jammer_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_spec_ops_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'stealth_strength' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_nuimqol_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'railgun_cycle_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_nuimqol_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'railgun_cycle_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_spec_ops_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'stealth_strength' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_sensor_dampener_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_sensor_jammer_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_arbalest_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_railgun_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_nuimqol_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_arbalest_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'railgun_cycle_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_arbalest_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_arbalest_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'railgun_optimal_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_railgun_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_missile_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.05, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_nuimqol_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'railgun_cycle_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'massiveness' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vagabond_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_webber_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.03 WHERE id = @chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vagabond_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'ecm_strength_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.03, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vagabond_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_medium_railgun_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.05, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vagabond_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_sensor_jammer_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vagabond_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_sensor_dampener_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_spec_ops_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vagabond_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'stealth_strength' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_nuimqol_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vagabond_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'railgun_cycle_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_medium_railgun_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_nuimqol_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'railgun_cycle_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_chemical' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_explosive' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_kinetic' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_thermal' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_castel_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_small_missile_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_pelistal_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_castel_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'missile_cycle_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_castel_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_castel_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'detection_strength' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_troiar_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'energy_neutralized_amount_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_troiar_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'energy_vampired_amount_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_troiar_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'energy_neutralizer_optimal_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.03, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_troiar_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'energy_vampire_optimal_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.03, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_troiar_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_small_missile_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.05, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_spec_ops_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_troiar_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'stealth_strength' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_pelistal_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_troiar_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'missile_cycle_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ictus_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'energy_neutralized_amount_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ictus_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'energy_vampired_amount_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.05, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ictus_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'energy_neutralizer_optimal_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.03, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ictus_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'energy_vampire_optimal_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.03, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ictus_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_medium_missile_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.05, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_spec_ops_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ictus_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'stealth_strength' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_pelistal_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ictus_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'missile_cycle_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_waspish_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_missile_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_pelistal_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_waspish_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'missile_cycle_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_waspish_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'missile_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_waspish_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_tyrannos_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_medium_missile_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.05, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_tyrannos_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'massiveness' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_tyrannos_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_pelistal_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_tyrannos_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'missile_cycle_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_tyrannos_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_missile_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_gropho_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_medium_missile_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_pelistal_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_gropho_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'missile_cycle_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_gropho_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_gropho_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_chemical' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_gropho_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_explosive' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_gropho_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_kinetic' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_gropho_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_thermal' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_small_laser_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_small_missile_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.05, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_thelodica_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'laser_cycle_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'detection_strength' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_baphomet_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_laser_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_baphomet_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_missile_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.05, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_thelodica_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_baphomet_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'laser_cycle_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_baphomet_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'laser_optimal_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_baphomet_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_medium_laser_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.05, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_medium_missile_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.05, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_laser_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_thelodica_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'laser_cycle_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'massiveness' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_seth_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_medium_laser_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_thelodica_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_seth_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'laser_cycle_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_seth_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_seth_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_chemical' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_seth_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_explosive' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_seth_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_thermal' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_seth_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'resist_kinetic' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_webber_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.03 WHERE id = @chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'effect_enhancer_sensor_dampener_locking_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.01, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'effect_enhancer_sensor_dampener_locking_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.02, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_small_laser_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 5, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_thelodica_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'laser_cycle_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_spec_ops_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'stealth_strength' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_sensor_jammer_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_sensor_dampener_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_zenith_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_webber_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.03 WHERE id = @chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_zenith_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'effect_enhancer_sensor_dampener_locking_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.01, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_zenith_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'effect_enhancer_sensor_dampener_locking_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.02, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_zenith_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_medium_laser_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.05, '', @aggfieldID, 0);

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_spec_ops_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_zenith_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'stealth_strength' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_zenith_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_sensor_jammer_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_zenith_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_sensor_dampener_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_thelodica_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_zenith_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'laser_cycle_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

GO

---BALANCE bots mk1 v0 must be run first! --
PRINT '---BALANCE bots mk1 v0 must be run first! --'

DECLARE @definitionID int;
DECLARE @extensionID int;
DECLARE @aggfieldID int;
DECLARE @chassisbonusID int;
DECLARE @aggvalueID int;


SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_syndicate_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_legatus_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'armor_max_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.03 WHERE id = @chassisbonusID;


SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_syndicate_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_legatus_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'signature_radius' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.2 WHERE id = @chassisbonusID;


SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_webber_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.03 WHERE id = @chassisbonusID;


SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'effect_enhancer_sensor_dampener_locking_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.01 WHERE id = @chassisbonusID;


SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'effect_enhancer_sensor_dampener_locking_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.02 WHERE id = @chassisbonusID;


SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_small_laser_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;


SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_yagel_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'detection_strength' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 2, '', @aggfieldID, 0);


SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_yagel_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'turret_fallof_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;


SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_nuimqol_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_yagel_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.07 WHERE id = @chassisbonusID;


SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_nuimqol_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.07 WHERE id = @chassisbonusID;


SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_nuimqol_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_arbalest_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.07 WHERE id = @chassisbonusID;


SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_nuimqol_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.07 WHERE id = @chassisbonusID;


SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_nuimqol_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vagabond_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.07 WHERE id = @chassisbonusID;


SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_nuimqol_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.07 WHERE id = @chassisbonusID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_mass_reductor' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_standard_mass_reductor', quantity=1, attributeflags=524320, categoryflags=327951, options='#moduleFlag=i20#tier=$tierlevel_t1', 
                note='', enabled=1, volume=0.5, mass=2, hidden='False', health=100, descriptiontoken='def_standard_mass_reductor_desc', purchasable=1, tiertype=1, 
                tierlevel=1 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.15 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_mining_upgrade' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_standard_mining_upgrade', quantity=1, attributeflags=524288, categoryflags=263695, options='#moduleFlag=i8#tier=$tierlevel_t1', 
                note='', enabled=1, volume=1, mass=100, hidden='False', health=100, descriptiontoken='def_standard_mining_upgrade_desc', purchasable=1, tiertype=1, 
                tierlevel=1 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'harvesting_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'harvesting_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatefields SET [name]='harvesting_amount_modifier', [formula]=0, [measurementunit]='harvesting_amount_modifier_unit', [measurementmultiplier]=100, [measurementoffset]=-100, [category]=6, [digits]=2, [moreisbetter]=1, [usedinconfig]=1, [note]='' WHERE id =@aggfieldID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mining_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mining_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatefields SET [name]='mining_amount_modifier', [formula]=0, [measurementunit]='mining_amount_modifier_unit', [measurementmultiplier]=100, [measurementoffset]=-100, [category]=6, [digits]=2, [moreisbetter]=1, [usedinconfig]=1, [note]='' WHERE id =@aggfieldID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_mining_upgrade' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named1_mining_upgrade', quantity=1, attributeflags=524288, categoryflags=263695, options='#moduleFlag=i8#tier=$tierlevel_t2', 
                note='', enabled=1, volume=0.1, mass=60, hidden='False', health=100, descriptiontoken='def_named_mining_upgrade_desc', purchasable=1, tiertype=1, 
                tierlevel=2 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'harvesting_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mining_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.1 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_mining_upgrade' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named2_mining_upgrade', quantity=1, attributeflags=524288, categoryflags=263695, options='#moduleFlag=i8#tier=$tierlevel_t3', 
                note='', enabled=1, volume=0.1, mass=60, hidden='False', health=100, descriptiontoken='def_named_mining_upgrade_desc', purchasable=1, tiertype=1, 
                tierlevel=3 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'harvesting_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.15 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mining_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.15 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_mining_upgrade' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named3_mining_upgrade', quantity=1, attributeflags=524288, categoryflags=263695, options='#moduleFlag=i8#tier=$tierlevel_t4', 
                note='', enabled=1, volume=0.1, mass=60, hidden='False', health=100, descriptiontoken='def_named_mining_upgrade_desc', purchasable=1, tiertype=1, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'harvesting_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.2 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mining_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.2 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_armor_repairer_upgrade' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_standard_armor_repairer_upgrade', quantity=1, attributeflags=524292, categoryflags=393487, options='#moduleFlag=i8#tier=$tierlevel_t1', 
                note='', enabled=1, volume=0.5, mass=300, hidden='False', health=100, descriptiontoken='def_armor_repairer_upgrade_desc', purchasable=1, tiertype=1, 
                tierlevel=1 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatefields SET [name]='armor_repair_amount_modifier', [formula]=0, [measurementunit]='armor_repair_amount_modifier_unit', [measurementmultiplier]=100, [measurementoffset]=-100, [category]=2, [digits]=2, [moreisbetter]=1, [usedinconfig]=1, [note]='' WHERE id =@aggfieldID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_armor_repairer_upgrade' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named2_armor_repairer_upgrade', quantity=1, attributeflags=524292, categoryflags=393487, options='#moduleFlag=i8#tier=$tierlevel_t3', 
                note='', enabled=1, volume=0.5, mass=300, hidden='False', health=100, descriptiontoken='def_armor_repairer_upgrade_desc', purchasable=1, tiertype=1, 
                tierlevel=3 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.15 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.92 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_armor_repairer_upgrade' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named3_armor_repairer_upgrade', quantity=1, attributeflags=524292, categoryflags=393487, options='#moduleFlag=i8#tier=$tierlevel_t4', 
                note='', enabled=1, volume=0.5, mass=375, hidden='False', health=100, descriptiontoken='def_armor_repairer_upgrade_desc', purchasable=1, tiertype=1, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.2 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_mass_reductor' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named1_mass_reductor', quantity=1, attributeflags=524320, categoryflags=327951, options='#moduleFlag=i20#tier=$tierlevel_t2', 
                note='', enabled=1, volume=0.5, mass=2, hidden='False', health=100, descriptiontoken='def_named_mass_reductor_desc', purchasable=1, tiertype=1, 
                tierlevel=2 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.15 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'massiveness' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=-0.25 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_armor_repairer_upgrade_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named1_armor_repairer_upgrade_pr', quantity=1, attributeflags=524292, categoryflags=393487, options='#moduleFlag=i8#tier=$tierlevel_t2_pr', 
                note='', enabled=1, volume=0.5, mass=216, hidden='False', health=100, descriptiontoken='def_armor_repairer_upgrade_desc', purchasable=1, tiertype=2, 
                tierlevel=2 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.1 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_armor_repairer_upgrade_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named2_armor_repairer_upgrade_pr', quantity=1, attributeflags=524292, categoryflags=393487, options='#moduleFlag=i8#tier=$tierlevel_t3_pr', 
                note='', enabled=1, volume=0.5, mass=240, hidden='False', health=100, descriptiontoken='def_armor_repairer_upgrade_desc', purchasable=1, tiertype=2, 
                tierlevel=3 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.15 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.92 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_armor_repairer_upgrade_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named3_armor_repairer_upgrade_pr', quantity=1, attributeflags=524292, categoryflags=393487, options='#moduleFlag=i8#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=0.5, mass=300, hidden='False', health=100, descriptiontoken='def_armor_repairer_upgrade_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.2 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_mass_reductor_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named1_mass_reductor_pr', quantity=1, attributeflags=524320, categoryflags=327951, options='#moduleFlag=i20#tier=$tierlevel_t2_pr', 
                note='', enabled=1, volume=0.5, mass=1.5, hidden='False', health=100, descriptiontoken='def_named_mass_reductor_desc', purchasable=1, tiertype=2, 
                tierlevel=2 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.15 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'massiveness' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=-0.25 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_mass_reductor_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named2_mass_reductor_pr', quantity=1, attributeflags=524320, categoryflags=327951, options='#moduleFlag=i20#tier=$tierlevel_t3_pr', 
                note='', enabled=1, volume=0.5, mass=1.5, hidden='False', health=100, descriptiontoken='def_named_mass_reductor_desc', purchasable=1, tiertype=2, 
                tierlevel=3 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.2 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'massiveness' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=-0.25 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_mass_reductor_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named3_mass_reductor_pr', quantity=1, attributeflags=524320, categoryflags=327951, options='#moduleFlag=i20#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=0.5, mass=1.5, hidden='False', health=100, descriptiontoken='def_named_mass_reductor_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.25 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'massiveness' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=-0.25 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_armor_repairer_upgrade' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_artifact_a_armor_repairer_upgrade', quantity=1, attributeflags=524292, categoryflags=393487, options='#moduleFlag=i8#tier=$tierlevel_t3a', 
                note='', enabled=1, volume=0.5, mass=240, hidden='False', health=100, descriptiontoken='def_artifact_a_armor_repairer_upgrade_desc', purchasable=1, tiertype=3, 
                tierlevel=3 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.15 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.92 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_mass_reductor' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_artifact_a_mass_reductor', quantity=1, attributeflags=524320, categoryflags=327951, options='#moduleFlag=i20#tier=$tierlevel_t3a', 
                note='', enabled=1, volume=0.5, mass=2, hidden='False', health=100, descriptiontoken='def_artifact_a_mass_reductor_desc', purchasable=1, tiertype=3, 
                tierlevel=3 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.2 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'massiveness' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=-0.25 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_reactor_sealing' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_standard_reactor_sealing', quantity=1, attributeflags=524292, categoryflags=918287, options='#moduleFlag=i20#tier=$tierlevel_t1', 
                note='', enabled=1, volume=1, mass=150, hidden='False', health=100, descriptiontoken='def_standard_reactor_sealing_desc', purchasable=1, tiertype=1, 
                tierlevel=1 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'reactor_radiation_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.5 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_reactor_sealing' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named1_reactor_sealing', quantity=1, attributeflags=524292, categoryflags=918287, options='#moduleFlag=i20#tier=$tierlevel_t2', 
                note='', enabled=1, volume=1, mass=135, hidden='False', health=100, descriptiontoken='def_named_reactor_sealing_desc', purchasable=1, tiertype=1, 
                tierlevel=2 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'reactor_radiation_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.5 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_reactor_sealing' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named2_reactor_sealing', quantity=1, attributeflags=524292, categoryflags=918287, options='#moduleFlag=i20#tier=$tierlevel_t3', 
                note='', enabled=1, volume=1, mass=150, hidden='False', health=100, descriptiontoken='def_named_reactor_sealing_desc', purchasable=1, tiertype=1, 
                tierlevel=3 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'reactor_radiation_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.4 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_reactor_sealing' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named3_reactor_sealing', quantity=1, attributeflags=524292, categoryflags=918287, options='#moduleFlag=i20#tier=$tierlevel_t4', 
                note='', enabled=1, volume=1, mass=165, hidden='False', health=100, descriptiontoken='def_named_reactor_sealing_desc', purchasable=1, tiertype=1, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'reactor_radiation_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.3 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_reactor_sealing_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named3_reactor_sealing_pr', quantity=1, attributeflags=524292, categoryflags=918287, options='#moduleFlag=i20#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=1, mass=165, hidden='False', health=100, descriptiontoken='def_named_reactor_sealing_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'reactor_radiation_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.5 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_reactor_sealing_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named2_reactor_sealing_pr', quantity=1, attributeflags=524292, categoryflags=918287, options='#moduleFlag=i20#tier=$tierlevel_t3_pr', 
                note='', enabled=1, volume=1, mass=150, hidden='False', health=100, descriptiontoken='def_named_reactor_sealing_desc', purchasable=1, tiertype=2, 
                tierlevel=3 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'reactor_radiation_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.4 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_reactor_sealing_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named1_reactor_sealing_pr', quantity=1, attributeflags=524292, categoryflags=918287, options='#moduleFlag=i20#tier=$tierlevel_t2_pr', 
                note='', enabled=1, volume=1, mass=135, hidden='False', health=100, descriptiontoken='def_named_reactor_sealing_desc', purchasable=1, tiertype=2, 
                tierlevel=2 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'reactor_radiation_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.3 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_reactor_sealing_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named3_reactor_sealing_pr', quantity=1, attributeflags=524292, categoryflags=918287, options='#moduleFlag=i20#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=1, mass=165, hidden='False', health=100, descriptiontoken='def_named_reactor_sealing_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'reactor_radiation_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.3 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_reactor_sealing_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named3_reactor_sealing_pr', quantity=1, attributeflags=524292, categoryflags=918287, options='#moduleFlag=i20#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=1, mass=165, hidden='False', health=100, descriptiontoken='def_named_reactor_sealing_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'reactor_radiation_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.5 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_mining_upgrade_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named1_mining_upgrade_pr', quantity=1, attributeflags=524288, categoryflags=263695, options='#moduleFlag=i8#tier=$tierlevel_t2_pr', 
                note='', enabled=1, volume=0.1, mass=45, hidden='False', health=100, descriptiontoken='def_named_mining_upgrade_desc', purchasable=1, tiertype=2, 
                tierlevel=2 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'harvesting_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.1 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mining_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.1 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_mining_upgrade_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named2_mining_upgrade_pr', quantity=1, attributeflags=524288, categoryflags=263695, options='#moduleFlag=i8#tier=$tierlevel_t3_pr', 
                note='', enabled=1, volume=0.1, mass=45, hidden='False', health=100, descriptiontoken='def_named_mining_upgrade_desc', purchasable=1, tiertype=2, 
                tierlevel=3 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'harvesting_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.15 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mining_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.15 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_mining_upgrade_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named3_mining_upgrade_pr', quantity=1, attributeflags=524288, categoryflags=263695, options='#moduleFlag=i8#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=0.1, mass=45, hidden='False', health=100, descriptiontoken='def_named_mining_upgrade_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'harvesting_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.2 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mining_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.2 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_armor_repairer_upgrade' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named1_armor_repairer_upgrade', quantity=1, attributeflags=524292, categoryflags=393487, options='#moduleFlag=i8#tier=$tierlevel_t2', 
                note='', enabled=1, volume=0.5, mass=270, hidden='False', health=100, descriptiontoken='def_armor_repairer_upgrade_desc', purchasable=1, tiertype=1, 
                tierlevel=2 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.1 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_mining_upgrade' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_artifact_a_mining_upgrade', quantity=1, attributeflags=524288, categoryflags=263695, options='#moduleFlag=i8#tier=$tierlevel_t3a', 
                note='', enabled=1, volume=0.1, mass=50, hidden='False', health=100, descriptiontoken='def_artifact_a_mining_upgrade_desc', purchasable=1, tiertype=3, 
                tierlevel=3 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'harvesting_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.15 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mining_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.15 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_damaged_mining_upgrade' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_artifact_damaged_mining_upgrade', quantity=1, attributeflags=524288, categoryflags=263695, options='#moduleFlag=i8#tier=$tierlevel_t0', 
                note='', enabled=1, volume=1, mass=100, hidden='False', health=100, descriptiontoken='def_artifact_damaged_mining_upgrade_desc', purchasable=1, tiertype=1, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'harvesting_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.05 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mining_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.05 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_damaged_armor_repairer_upgrade' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_artifact_damaged_armor_repairer_upgrade', quantity=1, attributeflags=524292, categoryflags=393487, options='#moduleFlag=i8#tier=$tierlevel_t0', 
                note='', enabled=1, volume=0.5, mass=300, hidden='False', health=100, descriptiontoken='def_artifact_damaged_armor_repairer_upgrade_desc', purchasable=1, tiertype=1, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.05 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_reactor_sealing_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named3_reactor_sealing_pr', quantity=1, attributeflags=524292, categoryflags=918287, options='#moduleFlag=i20#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=1, mass=165, hidden='False', health=100, descriptiontoken='def_named_reactor_sealing_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'reactor_radiation_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.3 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_reactor_sealing_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named1_reactor_sealing_pr', quantity=1, attributeflags=524292, categoryflags=918287, options='#moduleFlag=i20#tier=$tierlevel_t2_pr', 
                note='', enabled=1, volume=1, mass=135, hidden='False', health=100, descriptiontoken='def_named_reactor_sealing_desc', purchasable=1, tiertype=2, 
                tierlevel=2 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'reactor_radiation_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.5 WHERE id =  @aggvalueID;

GO