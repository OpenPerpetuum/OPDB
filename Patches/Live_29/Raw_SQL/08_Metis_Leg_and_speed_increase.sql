---Metis Additional Leg Slot and Speed increase 08/16/2023

DECLARE @definitionID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_metis_leg' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_metis_leg', quantity=1, attributeflags=1024, categoryflags=262992, options='#height=f1.1#slotFlags=420,20,20,20,20', 
                note='', enabled=1, volume=20, mass=15000, hidden=1, health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

DECLARE @aggvalueID int;
DECLARE @aggfieldID int;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_metis_leg' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_metis_leg', quantity=1, attributeflags=1024, categoryflags=262992, options='#height=f1.1#slotFlags=420,20,20,20,20', 
                note='', enabled=1, volume=20, mass=15000, hidden=1, health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.95 WHERE id =  @aggvalueID;