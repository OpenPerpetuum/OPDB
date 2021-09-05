USE [perpetuumsa]
GO

---------------------------------------------
-- Fix miniboss npc fittings w/ disabled mods defs
-- note: definitions not found on loot tables - NPC mods only!
-- Date modified: 2021/09/05
---------------------------------------------
PRINT N'Print definitions to enable - (90 rows affected) on first run';
SELECT * FROM entitydefaults
WHERE enabled=0 AND tiertype=3 AND tierlevel IN (2,4) AND definition >=3535 AND definition<=4437;

PRINT N'UPDATE entitydefaults - (90 rows affected) on first run';
UPDATE entitydefaults SET
	enabled=1
WHERE enabled=0 AND tiertype=3 AND tierlevel IN (2,4) AND definition >=3535 AND definition<=4437;

PRINT N'Done!';
GO
