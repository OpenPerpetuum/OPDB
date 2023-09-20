DECLARE @definitionID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_metis_leg' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_metis_leg', quantity=1, attributeflags=1024, categoryflags=262992, options='#height=f1.1#slotFlags=420,20,20,20,20', 
                note='', enabled=1, volume=20, mass=15000, hidden=1, health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

DECLARE @aggvalueID int;
DECLARE @aggfieldID int;


