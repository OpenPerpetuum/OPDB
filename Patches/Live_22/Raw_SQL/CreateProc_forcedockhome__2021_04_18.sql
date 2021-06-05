USE [perpetuumsa]
GO

----------------------------------------------------
-- Dock character to their home or TMA
-- 
-- Date modified: 2021/04/18
----------------------------------------------------


DROP PROCEDURE IF EXISTS [opp].[characterForceDockHome];

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [opp].[characterForceDockHome]
	@characterId INT
	
AS
BEGIN
		SET NOCOUNT ON;
		DECLARE @baseEid BIGINT, @publicContainer BIGINT, @activeRobot BIGINT;
		SET @baseEid = 561; --TMA default

		DECLARE @homeBaseEid AS BIGINT = (SELECT TOP 1 homeBaseEID FROM dbo.characters WHERE characterID=@characterId);
		IF (@homeBaseEid IS NOT NULL)
		BEGIN
			SET @baseEid = @homeBaseEid;
		END 
		SET @publicContainer = (SELECT TOP 1 eid FROM entities WHERE parent=@baseEid AND
			definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_public_container'));
		
		--dock character to tma
		UPDATE dbo.characters SET 
			docked=1,
			zoneID=NULL,
			positionX=NULL,
			positionY=NULL,
			baseEID=@baseEid 
		WHERE characterID=@characterId;
		 
		SET @activeRobot = (SELECT activechassis FROM dbo.characters WHERE characterID=@characterId);
		
		IF (@activeRobot IS NOT NULL)
		BEGIN
			--parent robot to tma public container
			UPDATE dbo.entities SET parent=@publicContainer WHERE eid=@activeRobot
		END     
	
END
GO
