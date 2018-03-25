USE [perpetuumsa]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[opp_create_account] 

@email			VARCHAR(50),
@password		VARCHAR(100),
@campaignid		VARCHAR(512)

AS
BEGIN
	SET NOCOUNT ON

	DECLARE 
		@accountid	INT,
		@error	INT = 0



	IF @email IS NOT NULL AND @password IS NOT NULL
	BEGIN
		BEGIN TRY
			INSERT INTO [dbo].[accounts]
					   ([email]
					   ,[password]          
					   ,[accLevel]
					   ,[emailConfirmed]
					   ,[isactive]           
					   ,[campaignid])
				 VALUES
					   (@email
					   ,@password
					   ,2
					   ,0
					   ,0           
					   ,@campaignid
					   )


			SET @accountid = SCOPE_IDENTITY();

			INSERT INTO extensionpoints (accountid,points) VALUES (@accountId,40000)
		END TRY
		BEGIN CATCH
			SET @error = 1
		END CATCH
	END
	ELSE
	SET @error = 1

	SELECT @error
END
GO


