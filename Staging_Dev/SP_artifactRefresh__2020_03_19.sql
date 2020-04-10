USE [perpetuumsa]
GO


IF OBJECT_ID('opp.artifactRefresh', 'P') IS NOT NULL
	DROP PROCEDURE [opp].[artifactRefresh];
GO

CREATE PROCEDURE [opp].[artifactRefresh]
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @fromDate DATETIME;
	SET @fromDate= DATEADD(DAY, -7, GETDATE());
	DELETE a FROM artifacts AS a JOIN artifacttypes AS t ON t.id=a.artifacttype WHERE t.persistent=1 AND a.missionguid IS NULL AND a.created < @fromDate;
END

GO


EXEC [opp].[artifactRefresh];