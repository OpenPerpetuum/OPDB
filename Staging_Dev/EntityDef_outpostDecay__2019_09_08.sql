USE [perpetuumsa]
GO

--------------------------------------------
--Outpost Decay Definition
--A definition for valid intrusion events and logs
--
--Date Modified: 2019/09/08
--------------------------------------------

INSERT INTO [dbo].[entitydefaults]
           ([definitionname],[quantity],[attributeflags],[categoryflags],[options],[note],[enabled],[volume],[mass],[hidden],[health],[descriptiontoken],[purchasable],[tiertype],[tierlevel])
     VALUES
           ('def_outpost_decay',1,2,(SELECT value FROM categoryFlags WHERE name = 'cf_intrusion_objects'),'','Decay def',1,1,1,0,100,'',0,1,1);
GO
