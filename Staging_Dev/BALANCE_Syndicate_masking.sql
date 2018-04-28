USE [perpetuumsa]
GO


--------------Syndicate Combat masking buff--------------

DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;

PRINT N'def_legatus_head';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_legatus_head' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_legatus_head', quantity=1, attributeflags=1024, categoryflags=262480, options='#height=f0.2#slotFlags=48,8,8,8,8', 
                note='', enabled=1, volume=3, mass=1000, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'stealth_strength' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=100 WHERE id =  @aggvalueID;



PRINT N'def_echelon_head';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_echelon_head' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_echelon_head', quantity=1, attributeflags=1024, categoryflags=196944, options='#height=f0.01#slotFlags=48,8,8,8,8', 
                note='', enabled=1, volume=3, mass=700, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'stealth_strength' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=110 WHERE id =  @aggvalueID;


-----------Keep masking same for lights/assaults--------------
PRINT N'def_locust_head';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_locust_head' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_locust_head', quantity=1, attributeflags=1024, categoryflags=131408, options='#height=f0.01#slotFlags=48,8,8,8,8', 
                note='', enabled=1, volume=1, mass=300, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'stealth_strength' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=110 WHERE id =  @aggvalueID;



PRINT N'def_vektor_head';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vektor_head' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_vektor_head', quantity=1, attributeflags=1024, categoryflags=65872, options='#height=f0.01#slotFlags=48,8,8,8', 
                note='', enabled=1, volume=1, mass=300, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'stealth_strength' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=105 WHERE id =  @aggvalueID;

GO