USE [perpetuumsa]
GO

----------------------------------
-- "Rally" Field Terminal
-- Inserts new definition
--
-- Date Modified: 2020/11/18
----------------------------------

DECLARE @def AS INT = 5930;
DECLARE @defName AS VARCHAR(100) = 'def_field_terminal_rally';


-- Add new EntityDefault for a "rally" terminal that doesn't give assignments
PRINT N'ADD RALLY FIELD TERM DEFINITION';
IF NOT EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = @defName)
BEGIN
	SET IDENTITY_INSERT [dbo].[entitydefaults] ON;
	INSERT INTO [dbo].[entitydefaults]
			   ([definition],[definitionname],[quantity],[attributeflags],[categoryflags],[options],[note],[enabled],[volume],[mass],[hidden],[health],[descriptiontoken],[purchasable],[tiertype],[tierlevel])
		 VALUES
			   (@def,@defName,1,943719424,131448,'','Field term w/o missions',1,0,0,0,100,@defName+'_desc',0,null,null);
	SET IDENTITY_INSERT [dbo].[entitydefaults] OFF;
END
ELSE
BEGIN
	UPDATE [dbo].[entitydefaults] SET
		attributeflags = 943719424,
		categoryflags = 131448,
		options = '',
		note = 'Field term w/o missions',
		enabled =1,
		volume = 0,
		mass = 0,
		hidden = 0,
		health = 100,
		descriptiontoken = @defName+'_desc',
		purchasable = 0,
		tierlevel = null,
		tiertype = null
	WHERE definitionname=@defName;
END
GO

