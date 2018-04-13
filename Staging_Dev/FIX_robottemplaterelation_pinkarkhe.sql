USE [perpetuumsa]
GO

------Pink Arkhe showing up in mission fix--------

PRINT N'BOT DEFINITIONS NEED TO HAVE NULL MISSION LEVELS!';
UPDATE robottemplaterelation
SET missionlevel=NULL, missionleveloverride=NULL, killep=NULL
WHERE definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_arkhe2_bot_pink');

GO
