USE [perpetuumsa]
GO

----------------------------------
-- Add "Rally" Field Terminal to zone 70
-- Note: Requires Zone 70!
--
-- Date Modified: 2020/11/18
----------------------------------

IF NOT EXISTS (SELECT TOP 1 id FROM zones WHERE id=70)
BEGIN
	PRINT N'ZONE 70 NOT FOUND -- NOT EXECUTING INSERTS!!';
	SET NOEXEC ON;
END

-- Parameters
DECLARE @terminalZone AS INT = 70;
DECLARE @terminalName AS VARCHAR(128) = 'fieldTerminal_z'+CAST(@terminalZone AS VARCHAR(24))+'_n00';
DECLARE @terminalSyncKey AS VARCHAR(50) = 'fieldterm_z70n00';
DECLARE @x AS INT = 454;
DECLARE @y AS INT = 397;
DECLARE @z AS INT = 125;

-- ID Stuff
DECLARE @rallyTermDef AS INT = (select definition from entitydefaults where definitionname = 'def_field_terminal_rally');
DECLARE @storageDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_public_container');
DECLARE @newEntityId AS BIGINT = (SELECT TOP 1 eid + 1 FROM entities WHERE eid + 1 NOT IN (SELECT DISTINCT eid FROM entities));
DECLARE @newEntityStorageId AS BIGINT = (SELECT TOP 1 eid + 1 FROM entities WHERE eid + 1 NOT IN (SELECT DISTINCT eid FROM entities) AND eid+1 <> @newEntityId);

IF NOT EXISTS (SELECT TOP 1 eid FROM entities WHERE ename=@terminalName)
BEGIN
	-- Insert Entity for rally terminal
	PRINT N'Insert Entity for rally terminal';
	INSERT INTO [dbo].[entities]
			   ([eid],[definition],[owner],[parent],[health],[ename],[quantity],[repackaged],[dynprop])
		 VALUES
			   (@newEntityId,@rallyTermDef,null,null,100,@terminalName,1,0,null);

	-- Insert container for rally terminal to enable storage
	PRINT N'Insert container for rally terminal to enable storage';
	INSERT INTO [dbo].[entities]
			   ([eid],[definition],[owner],[parent],[health],[ename],[quantity],[repackaged],[dynprop])
		 VALUES
			   (@newEntityStorageId,@storageDef,null,@newEntityId,100,null,1,0,'#log=i0')

	-- Insert zone entity for rally terminal
	PRINT N'Insert zone entity for rally terminal';
	INSERT INTO [dbo].[zoneentities]
			   ([zoneID],[eid],[definition],[owner],[ename],[x],[y],[z],[orientation],[enabled],[note],[runtime],[synckey])
		 VALUES
			   (@terminalZone,@newEntityId,null,null,@terminalName,@x,@y,@z,0,1,null,0,@terminalSyncKey);
END
ELSE
BEGIN
	PRINT N'WARN: OPERATION HAS ALREADY RUN, ENTITY FOUND OF NAME:'+@terminalName;
	PRINT N'NO INSERTIONS MADE!!!';
END

SET NOEXEC OFF;
GO