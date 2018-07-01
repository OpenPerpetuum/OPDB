USE [perpetuumsa]
GO


-------mobile IZ teleport Part 2 --  the deployed thing's properties---------
PRINT N'def_mobile_world_teleporter_basic';
DECLARE @definitionID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mobile_world_teleporter_basic' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_mobile_world_teleporter_basic', quantity=1, attributeflags=12583936, categoryflags=33948280, options='', 
                note='', enabled=1, volume=1, mass=1, hidden='False', health=100, descriptiontoken='def_mobile_world_teleporter_basic_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

PRINT N'despawn_time from 900s->600s';
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'despawn_time' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=600000 WHERE id =  @aggvalueID;

PRINT N'stealth_strength from 25->50rf';
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'stealth_strength' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=50 WHERE id =  @aggvalueID;

GO

