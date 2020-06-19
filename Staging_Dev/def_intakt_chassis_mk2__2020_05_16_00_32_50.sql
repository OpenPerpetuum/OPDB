USE [perpetuumsa]
GO

----------------------------------------------------
--Intakt MK2 Reactor fix
--Date: 2020/05/16
------------------------------------------------------
DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_chassis_mk2' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=192 WHERE id =  @aggvalueID;

GO