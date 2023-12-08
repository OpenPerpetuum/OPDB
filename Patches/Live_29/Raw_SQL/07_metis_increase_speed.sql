DECLARE @definitionID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_metis_leg' ORDER BY definition DESC);

DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.95 WHERE id =  @aggvalueID;


