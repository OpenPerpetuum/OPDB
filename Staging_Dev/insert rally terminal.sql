USE [perpetuumsa]
GO

-- Parameters
declare @terminalZone as int = 8;
declare @terminalName as nvarchar(max) = 'fieldTerminal_z08_n99';
declare @terminalSyncKey as nvarchar(max) = 'fieldterm_test1';
declare @x as int = 1120;
declare @y as int = 785;
declare @z as int = 121;

-- ID Stuff
declare @newEntityId as BigInt = (select max(eid) + 1 from entities);
declare @newEntityStorageId as BigInt = @newEntityId + 1;

-- Insert Entity for rally terminal

INSERT INTO [dbo].[entities]
           ([eid],[definition],[owner],[parent],[health],[ename],[quantity],[repackaged],[dynprop])
     VALUES
           (@newEntityId ,(select definition from entitydefaults where definitionname = 'def_field_terminal_rally'),null,null,100,@terminalName,1,0,null)

-- Insert container for rally terminal to enable storage
INSERT INTO [dbo].[entities]
           ([eid],[definition],[owner],[parent],[health],[ename],[quantity],[repackaged],[dynprop])
     VALUES
           (@newEntityStorageId,166,null,@newEntityId,100,null,1,0,'#log=i0')

-- Insert zone entity for rally terminal
INSERT INTO [dbo].[zoneentities]
           ([zoneID],[eid],[definition],[owner],[ename],[x],[y],[z],[orientation],[enabled],[note],[runtime],[synckey])
     VALUES
           (@terminalZone,@newEntityId,null,null,@terminalName,@x,@y,@z,0,1,null,0,@terminalSyncKey)

GO