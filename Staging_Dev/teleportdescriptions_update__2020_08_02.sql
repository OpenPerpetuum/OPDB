USE [perpetuumsa]
GO

--------------------------------------------------------
-- Teleports that perform in-zone jumps should use in-zonejump type
--
-- Date 2020/08/02
--------------------------------------------------------


--PRINT N'Teleports that should be type=1 for in-zone';
--SELECT * FROM teleportdescriptions 
--WHERE targetzone=sourcezone AND
--	type!=1

PRINT N'Update to type=1 WHERE targetzone=sourcezone';
UPDATE teleportdescriptions SET
	type=1
WHERE targetzone=sourcezone AND type!=1;

GO
