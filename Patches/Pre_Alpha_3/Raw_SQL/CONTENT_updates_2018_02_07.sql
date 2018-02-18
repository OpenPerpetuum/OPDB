USE [perpetuumsa]
GO


-----Syndicate (new/broken) bot extension fix for proper skill requirements-----
PRINT N'Updating Syndicate Bot Extension Requirements (Fix)'
--Helix
UPDATE enablerextensions
SET extensionid=360
WHERE definition=5508 and extensionid=147 and extensionlevel=3
--Callisto
UPDATE enablerextensions
SET extensionid=360
WHERE definition=5520 and extensionid=147 and extensionlevel=7
--Legatus
UPDATE enablerextensions
SET extensionid=360
WHERE definition=5524 and extensionid=147 and extensionlevel=8
--Metis
UPDATE enablerextensions
SET extensionid=361
WHERE definition=5544 and extensionid=154 and extensionlevel=8



--------------Gives Small Armor Plate to training rewards to Numiquol and Theo
PRINT N'TRAINING REWARDS INSERTS';

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
           ,2)

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
           ,3)

----------Moves Arkhe Spawn to 1078 to 940---------
PRINT N'NPC flock for tutorial mission on NV tweak';

DECLARE @presenceID int
DECLARE @flockID int;
DECLARE @definitionID int;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'random_v2_1_NEW_02_Arkhe' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'random_v2_1_NEW_02_Arkhe',[topx] = 1023,[topy] = 710,[bottomx] = 1223,[bottomy] = 910,[note] = '',[spawnid] = 1,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 2,[randomcenterx] = 1123,[randomcentery] = 810
                ,[randomradius] = 5,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_dummy_decoy' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_random_arkhe_basic_rank0_3member_60sec' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_random_arkhe_basic_rank0_3member_60sec' ,[presenceid] = @presenceID, [flockmembercount] = 6, [definition] = 1473, [spawnoriginX] = 1078, [spawnoriginY] = 940 ,[spawnrangeMin] = 0, [spawnrangeMax] = 0,[respawnseconds] = 30, [totalspawncount] = 0, [homerange] = 30 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;


---------CHANGE NPC SPAWN POINTS FOR OBSERVERS TO 411,253 ; 596,204 ; 1220, 259------------------------------
PRINT N'NPC safespawnpoints changes for roaming spawns on Hershfield zoneid=8';

UPDATE [dbo].[npcsafespawnpoints]
   SET [zoneid] = 8
      ,[x] = 411
      ,[y] = 253
 WHERE zoneid=8 and x=1322 and y=545;
UPDATE [dbo].[npcsafespawnpoints]
   SET [zoneid] = 8
      ,[x] = 411
      ,[y] = 253
 WHERE zoneid=8 and x=1152 and y=451;
UPDATE [dbo].[npcsafespawnpoints]
   SET [zoneid] = 8
      ,[x] = 411
      ,[y] = 253
 WHERE zoneid=8 and x=924 and y=324;
UPDATE [dbo].[npcsafespawnpoints]
   SET [zoneid] = 8
      ,[x] = 411
      ,[y] = 253
 WHERE zoneid=8 and x=661 and y=284;
UPDATE [dbo].[npcsafespawnpoints]
   SET [zoneid] = 8
      ,[x] = 411
      ,[y] = 253
 WHERE zoneid=8 and x=330 and y=738;
UPDATE [dbo].[npcsafespawnpoints]
   SET [zoneid] = 8
      ,[x] = 411
      ,[y] = 253
 WHERE zoneid=8 and x=718 and y=1195;
UPDATE [dbo].[npcsafespawnpoints]
   SET [zoneid] = 8
      ,[x] = 411
      ,[y] = 253
 WHERE zoneid=8 and x=1118 and y=1018;
UPDATE [dbo].[npcsafespawnpoints]
   SET [zoneid] = 8
      ,[x] = 411
      ,[y] = 253
 WHERE zoneid=8 and x=1338 and y=1379;
UPDATE [dbo].[npcsafespawnpoints]
   SET [zoneid] = 8
      ,[x] = 411
      ,[y] = 253
 WHERE zoneid=8 and x=1056 and y=1456;
UPDATE [dbo].[npcsafespawnpoints]
   SET [zoneid] = 8
      ,[x] = 596
      ,[y] = 204
 WHERE zoneid=8 and x=1712 and y=1371;
UPDATE [dbo].[npcsafespawnpoints]
   SET [zoneid] = 8
      ,[x] = 596
      ,[y] = 204
 WHERE zoneid=8 and x=1743 and y=1191;
UPDATE [dbo].[npcsafespawnpoints]
   SET [zoneid] = 8
      ,[x] = 596
      ,[y] = 204
 WHERE zoneid=8 and x=1743 and y=1016;
UPDATE [dbo].[npcsafespawnpoints]
   SET [zoneid] = 8
      ,[x] = 596
      ,[y] = 204
 WHERE zoneid=8 and x=1734 and y=860;
UPDATE [dbo].[npcsafespawnpoints]
   SET [zoneid] = 8
      ,[x] = 596
      ,[y] = 204
 WHERE zoneid=8 and x=1614 and y=764;
UPDATE [dbo].[npcsafespawnpoints]
   SET [zoneid] = 8
      ,[x] = 596
      ,[y] = 204
 WHERE zoneid=8 and x=777 and y=1428;
UPDATE [dbo].[npcsafespawnpoints]
   SET [zoneid] = 8
      ,[x] = 596
      ,[y] = 204
 WHERE zoneid=8 and x=1585 and y=1062;
UPDATE [dbo].[npcsafespawnpoints]
   SET [zoneid] = 8
      ,[x] = 596
      ,[y] = 204
 WHERE zoneid=8 and x=880 and y=1587;
UPDATE [dbo].[npcsafespawnpoints]
   SET [zoneid] = 8
      ,[x] = 596
      ,[y] = 204
 WHERE zoneid=8 and x=1408 and y=1247;
UPDATE [dbo].[npcsafespawnpoints]
   SET [zoneid] = 8
      ,[x] = 1220
      ,[y] = 259
 WHERE zoneid=8 and x=1016 and y=434;
UPDATE [dbo].[npcsafespawnpoints]
   SET [zoneid] = 8
      ,[x] = 1220
      ,[y] = 259
 WHERE zoneid=8 and x=469 and y=292;
UPDATE [dbo].[npcsafespawnpoints]
   SET [zoneid] = 8
      ,[x] = 1220
      ,[y] = 259
 WHERE zoneid=8 and x=303 and y=610;
UPDATE [dbo].[npcsafespawnpoints]
   SET [zoneid] = 8
      ,[x] = 1220
      ,[y] = 259
 WHERE zoneid=8 and x=622 and y=1100;
UPDATE [dbo].[npcsafespawnpoints]
   SET [zoneid] = 8
      ,[x] = 1220
      ,[y] = 259
 WHERE zoneid=8 and x=919 and y=1234;
UPDATE [dbo].[npcsafespawnpoints]
   SET [zoneid] = 8
      ,[x] = 1220
      ,[y] = 259
 WHERE zoneid=8 and x=1359 and y=1203;
UPDATE [dbo].[npcsafespawnpoints]
   SET [zoneid] = 8
      ,[x] = 1220
      ,[y] = 259
 WHERE zoneid=8 and x=498 and y=899;
UPDATE [dbo].[npcsafespawnpoints]
   SET [zoneid] = 8
      ,[x] = 1220
      ,[y] = 259
 WHERE zoneid=8 and x=1085 and y=1542;
UPDATE [dbo].[npcsafespawnpoints]
   SET [zoneid] = 8
      ,[x] = 1220
      ,[y] = 259
 WHERE zoneid=8 and x=1367 and y=1406;



GO