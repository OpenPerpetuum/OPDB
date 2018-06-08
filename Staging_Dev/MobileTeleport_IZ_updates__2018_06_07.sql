USE [perpetuumsa]
GO

DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
DECLARE @definitionID int;
DECLARE @sellprice float;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mobile_world_teleport_capsule' ORDER BY definition DESC);

PRINT N'SET IZ teleport to 1.5m->1.5m';

SET @sellprice = 1500000;

--SET IZ teleport to 1.5m
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @definitionID 
and isSell=1 and isvendoritem=1;


--SET IZ teleport Volume 60U->8U
PRINT N'SET IZ teleport Volume 60U->8U';
UPDATE entitydefaults Set definitionname='def_mobile_world_teleport_capsule', quantity=1, attributeflags=25167872, categoryflags=131480, options='#target=n3434', 
                note='ez lesz a konténeredben, jobbegér-use es csinal mobile world teleportot', enabled=1, volume=8, mass=50000, hidden='False', health=100, descriptiontoken='def_mobile_world_teleport_capsule_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


--SET IZ teleport despawn time 900s->600s
PRINT N'SET IZ teleport despawn time 900s->600s';
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'despawn_time' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=600000 WHERE id =  @aggvalueID;

--SET IZ teleport stealth_strength  25->50
PRINT N'SET IZ teleport stealth_strength  25->50';
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'stealth_strength' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=50 WHERE id =  @aggvalueID;

GO