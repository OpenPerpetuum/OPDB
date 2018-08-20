USE [perpetuumsa]
GO


PRINT N'Update FreeRoaming presences and flocks with correct respawn times, following server bugfix';

DECLARE @presenceID int;
DECLARE @respawnTime int;
DECLARE @flockID int;

--This for presence and flock should be equal and positive
SET @respawnTime = 600;

PRINT N'NV spawns';
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'free_roaming_laird_NV' ORDER BY id DESC);

UPDATE [dbo].[npcflock] 
SET [respawnseconds] = @respawnTime
WHERE id=@flockID;


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'freeroaming_NPC_New_Virginia' ORDER BY id DESC);

UPDATE [dbo].[npcpresence]
SET [roamingrespawnseconds] = @respawnTime
WHERE id=@presenceID;


SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'argano_free_roaming_NV2' ORDER BY id DESC);

UPDATE [dbo].[npcflock] 
SET [respawnseconds] = @respawnTime
WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'freeroaming_NPC_New_Virginia_2' ORDER BY id DESC);

UPDATE [dbo].[npcpresence]
SET [roamingrespawnseconds] = @respawnTime
WHERE id=@presenceID;



SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Free_roaming_argano_NV3' ORDER BY id DESC);

UPDATE [dbo].[npcflock] 
SET [respawnseconds] = @respawnTime
WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'freeroaming_NPC_New_Virginia_3' ORDER BY id DESC);

UPDATE [dbo].[npcpresence]
SET [roamingrespawnseconds] = @respawnTime
WHERE id=@presenceID;



SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'NV_free_roamer_laird' ORDER BY id DESC);

UPDATE [dbo].[npcflock] 
SET [respawnseconds] = @respawnTime
WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'freeroaming_NPC_New_Virginia_4' ORDER BY id DESC);

UPDATE [dbo].[npcpresence]
SET [roamingrespawnseconds] = @respawnTime
WHERE id=@presenceID;





PRINT N'Hershfield spawns';
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'free_roaming_laird_hersh_1' ORDER BY id DESC);

UPDATE [dbo].[npcflock] 
SET [respawnseconds] = @respawnTime
WHERE id=@flockID;


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'freeroaming_NPC_Hersh_ECM_1' ORDER BY id DESC);

UPDATE [dbo].[npcpresence]
SET [roamingrespawnseconds] = @respawnTime
WHERE id=@presenceID;


SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'free_roaming_argano_Hersh_1' ORDER BY id DESC);

UPDATE [dbo].[npcflock] 
SET [respawnseconds] = @respawnTime
WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'freeroaming_NPC_Hersh_ECM_2' ORDER BY id DESC);

UPDATE [dbo].[npcpresence]
SET [roamingrespawnseconds] = @respawnTime
WHERE id=@presenceID;



SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'free_roaming_laird_hersh_2' ORDER BY id DESC);

UPDATE [dbo].[npcflock] 
SET [respawnseconds] = @respawnTime
WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'freeroaming_NPC_Hersh_ECM_3' ORDER BY id DESC);

UPDATE [dbo].[npcpresence]
SET [roamingrespawnseconds] = @respawnTime
WHERE id=@presenceID;



SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'free_roaming_argano_hersh_2' ORDER BY id DESC);

UPDATE [dbo].[npcflock] 
SET [respawnseconds] = @respawnTime
WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'freeroaming_NPC_Hersh_ECM_4' ORDER BY id DESC);

UPDATE [dbo].[npcpresence]
SET [roamingrespawnseconds] = @respawnTime
WHERE id=@presenceID;

GO