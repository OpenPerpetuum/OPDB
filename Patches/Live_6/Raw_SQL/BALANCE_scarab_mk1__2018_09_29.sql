USE [perpetuumsa]
GO

PRINT N'Scarab mk1/pr Balance tweaks';
--Set Scarab cargo from 5000->2160
UPDATE entitydefaults
SET options='#capacity=f2160.0'
WHERE definitionname = 'def_robot_inventory_scarab';


DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;

--Set Scarab Speed from 26->30kph
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_scarab_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.8333 WHERE id =  @aggvalueID;

GO