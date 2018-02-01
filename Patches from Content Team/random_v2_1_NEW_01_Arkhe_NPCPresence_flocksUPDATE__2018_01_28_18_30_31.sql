DECLARE @presenceID int
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'random_v2_1_NEW_01_Arkhe' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'random_v2_1_NEW_01_Arkhe',[topx] = 912,[topy] = 730,[bottomx] = 1112,[bottomy] = 930,[note] = '',[spawnid] = 1,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 3,[maxrandomflock] = 2,[randomcenterx] = 1012,[randomcentery] = 830
                ,[randomradius] = 5,[dynamiclifetime] = '' ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;
DECLARE @flockID int;
DECLARE @definitionID int;

