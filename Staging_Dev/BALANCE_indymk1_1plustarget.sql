USE [perpetuumsa]
GO

------INDY MK1 BOT STAT: +1 TARGET--------
DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
PRINT N'def_symbiont_head_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_symbiont_head_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_symbiont_head_pr', quantity=1, attributeflags=1024, categoryflags=262480, options='#height=f0.2#slotFlags=48,8,8,8', 
                note='', enabled=1, volume=3, mass=2000, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locked_targets_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=5 WHERE id =  @aggvalueID;


PRINT N'def_riveler_head_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_riveler_head_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_riveler_head_pr', quantity=1, attributeflags=1024, categoryflags=262480, options='#height=f0.2#slotFlags=48,8,8,8', 
                note='', enabled=1, volume=3, mass=2000, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locked_targets_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=5 WHERE id =  @aggvalueID;



PRINT N'def_gargoyle_head_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_gargoyle_head_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_gargoyle_head_pr', quantity=1, attributeflags=1024, categoryflags=196944, options='#height=f0.2#slotFlags=48,8,8,8', 
                note='', enabled=1, volume=2, mass=560, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locked_targets_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4 WHERE id =  @aggvalueID;



PRINT N'def_termis_head_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_termis_head_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_termis_head_pr', quantity=1, attributeflags=1024, categoryflags=196944, options='#height=f0.2#slotFlags=48,8,8,8', 
                note='', enabled=1, volume=2, mass=560, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locked_targets_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4 WHERE id =  @aggvalueID;



PRINT N'def_laird_head_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_laird_head_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_laird_head_pr', quantity=1, attributeflags=1024, categoryflags=65872, options='#height=f0.01#slotFlags=48,8,8', 
                note='', enabled=1, volume=3, mass=225, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locked_targets_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=3 WHERE id =  @aggvalueID;


PRINT N'def_argano_head_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_argano_head_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_argano_head', quantity=1, attributeflags=1024, categoryflags=65872, options='#height=f0.05#slotFlags=48,8,8', 
                note='', enabled=1, volume=3, mass=225, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locked_targets_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=3 WHERE id =  @aggvalueID;


PRINT N'def_symbiont_head';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_symbiont_head' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_symbiont_head', quantity=1, attributeflags=1024, categoryflags=262480, options='#height=f0.2#slotFlags=48,8,8,8', 
                note='', enabled=1, volume=3, mass=2000, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locked_targets_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=5 WHERE id =  @aggvalueID;



PRINT N'def_riveler_head';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_riveler_head' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_riveler_head', quantity=1, attributeflags=1024, categoryflags=262480, options='#height=f0.2#slotFlags=48,8,8,8', 
                note='', enabled=1, volume=3, mass=2000, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locked_targets_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=5 WHERE id =  @aggvalueID;



PRINT N'def_gargoyle_head';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_gargoyle_head' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_gargoyle_head', quantity=1, attributeflags=1024, categoryflags=196944, options='#height=f0.2#slotFlags=48,8,8,8', 
                note='', enabled=1, volume=2, mass=560, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locked_targets_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4 WHERE id =  @aggvalueID;


PRINT N'def_termis_head';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_termis_head' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_termis_head', quantity=1, attributeflags=1024, categoryflags=196944, options='#height=f0.2#slotFlags=48,8,8,8', 
                note='', enabled=1, volume=2, mass=560, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locked_targets_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4 WHERE id =  @aggvalueID;



PRINT N'def_laird_head';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_laird_head' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_laird_head', quantity=1, attributeflags=1024, categoryflags=65872, options='#height=f0.01#slotFlags=48,8,8', 
                note='', enabled=1, volume=3, mass=225, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locked_targets_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=3 WHERE id =  @aggvalueID;


PRINT N'def_argano_head';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_argano_head' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_argano_head', quantity=1, attributeflags=1024, categoryflags=65872, options='#height=f0.05#slotFlags=48,8,8', 
                note='', enabled=1, volume=3, mass=225, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locked_targets_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=3 WHERE id =  @aggvalueID;

GO


