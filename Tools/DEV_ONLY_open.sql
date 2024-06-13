
USE [perpetuumsa]
GO

-------------------------------
--DO NOT USE ON LIVE SERVER!
--FOR TESTING PURPOSES ONLY
-------------------------------

--Check if live server DB settings
IF 'Open Perpetuum Project Live Server - OpenPerpetuum.com' in (SELECT name from serverinfo) 
	and 1 in (SELECT isopen from serverinfo) 
	and 1 in (SELECT isbroadcast from serverinfo)
	RETURN;
--Get the hell outta here!

-------------------------------
-- Open for registration from client.
-------------------------------

UPDATE [dbo].[serverinfo] SET [isopen] = 1

GO
