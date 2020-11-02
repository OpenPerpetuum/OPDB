USE [perpetuumsa]
GO

-- Add new EntityDefault for a "rally" terminal that doesn't give assignments
INSERT INTO [dbo].[entitydefaults]
           ([definitionname],[quantity],[attributeflags],[categoryflags],[options],[note],[enabled],[volume],[mass],[hidden],[health],[descriptiontoken],[purchasable],[tiertype],[tierlevel])
     VALUES
           ('def_field_terminal_rally',1,943719424,131448,'','',1,0,0,0,100,'def_field_terminal_rally_desc',0,null,null)
GO