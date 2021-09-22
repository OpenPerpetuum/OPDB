USE [perpetuumsa]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TABLE [dbo].[harvestlog](
	[eventtime] [smalldatetime] NOT NULL,
	[zoneid] [int] NOT NULL,
	[definition] [int] NOT NULL,
	[amount] [int] NOT NULL
) ON [PRIMARY]
GO


CREATE OR ALTER PROCEDURE [dbo].[writeharvestlog] 
	
	@zoneid INT,
	@definition INT,
	@quantity INT,
	@eventtime DATETIME
	
AS
BEGIN
	SET NOCOUNT ON;
		
	IF EXISTS (SELECT zoneid FROM harvestlog WHERE eventtime=@eventtime AND zoneid=@zoneid AND definition=@definition)
	BEGIN
		UPDATE harvestlog SET amount=amount+@quantity  WHERE eventtime=@eventtime AND zoneid=@zoneid AND definition=@definition
	end
	ELSE
	BEGIN
		INSERT harvestlog (zoneid,definition,amount,eventtime) VALUES (@zoneid,@definition,@quantity,@eventtime)
	END
	
    
	
END
GO
