USE [perpetuumsa]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[startup_standalone] 
	
AS
BEGIN
SET NOCOUNT ON;
	
--exec dbo.debug_disablezones
--exec dbo.debug_enablenpcs

--enabled zones
UPDATE zones SET [enabled]=1 WHERE active=1

--disable debug presences
update npcpresence set enabled=0 where [name] in ( 'random_flock_gatherer','debug_presence')

END





GO


