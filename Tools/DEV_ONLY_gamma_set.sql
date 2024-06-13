
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
-- Leave only one line of Gamma [T0] - [T3] zones.
-------------------------------

UPDATE [dbo].[zones] SET [enabled] = 0, [active] = 0 WHERE [id] >= 100 AND [id] <= 140
-- "Jaego"
UPDATE [dbo].[zones] SET [enabled] = 1, [active] = 1 WHERE [id] = 102
-- "Djodi [T0]"
UPDATE [dbo].[zones] SET [enabled] = 1, [active] = 1 WHERE [id] = 114
-- "Myre Barrier [T1]"
UPDATE [dbo].[zones] SET [enabled] = 1, [active] = 1 WHERE [id] = 115
-- "Krempen [T2]"
UPDATE [dbo].[zones] SET [enabled] = 1, [active] = 1 WHERE [id] = 123
-- "Hazel Grove [T3]"
UPDATE [dbo].[zones] SET [enabled] = 1, [active] = 1 WHERE [id] = 122

GO
