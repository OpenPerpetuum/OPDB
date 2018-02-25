DECLARE @definitionID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_core_battery' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_standard_medium_core_battery', quantity=1, attributeflags=589828, categoryflags=34079503, options='#moduleFlag=i20#tier=$tierlevel_t1', 
                note='', enabled=1, volume=1, mass=1500, hidden='False', health=100, descriptiontoken='def_standard_core_battery_desc', purchasable=1, tiertype=1, 
                tierlevel=1 where definition=@definitionID;

DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=105 WHERE id =  @aggvalueID;



DECLARE @definitionID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_core_battery' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_named1_medium_core_battery', quantity=1, attributeflags=589824, categoryflags=34079503, options='#moduleFlag=i20#tier=$tierlevel_t2', 
                note='', enabled=1, volume=1, mass=1350, hidden='False', health=100, descriptiontoken='def_named_core_battery_desc', purchasable=1, tiertype=1, 
                tierlevel=2 where definition=@definitionID;

DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=100 WHERE id =  @aggvalueID;



DECLARE @definitionID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_core_battery' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_named2_medium_core_battery', quantity=1, attributeflags=589824, categoryflags=34079503, options='#moduleFlag=i20#tier=$tierlevel_t3', 
                note='', enabled=1, volume=1, mass=1500, hidden='False', health=100, descriptiontoken='def_named_core_battery_desc', purchasable=1, tiertype=1, 
                tierlevel=3 where definition=@definitionID;

DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=107 WHERE id =  @aggvalueID;



DECLARE @definitionID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_core_battery' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_named3_medium_core_battery', quantity=1, attributeflags=589828, categoryflags=34079503, options='#moduleFlag=i20#tier=$tierlevel_t4', 
                note='', enabled=1, volume=1, mass=1500, hidden='False', health=100, descriptiontoken='def_named_core_battery_desc', purchasable=1, tiertype=1, 
                tierlevel=4 where definition=@definitionID;

DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=109 WHERE id =  @aggvalueID;



DECLARE @definitionID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_core_battery_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_named1_medium_core_battery_pr', quantity=1, attributeflags=589824, categoryflags=34079503, options='#moduleFlag=i20#tier=$tierlevel_t2_pr', 
                note='', enabled=1, volume=1, mass=1350, hidden='False', health=100, descriptiontoken='def_named_core_battery_desc', purchasable=1, tiertype=2, 
                tierlevel=2 where definition=@definitionID;

DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=97 WHERE id =  @aggvalueID;



DECLARE @definitionID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_core_battery_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_named2_medium_core_battery_pr', quantity=1, attributeflags=589824, categoryflags=34079503, options='#moduleFlag=i20#tier=$tierlevel_t3_pr', 
                note='', enabled=1, volume=1, mass=1500, hidden='False', health=100, descriptiontoken='def_named_core_battery_desc', purchasable=1, tiertype=2, 
                tierlevel=3 where definition=@definitionID;

DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=103 WHERE id =  @aggvalueID;



DECLARE @definitionID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_core_battery_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_named3_medium_core_battery_pr', quantity=1, attributeflags=589828, categoryflags=34079503, options='#moduleFlag=i20#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=1, mass=1500, hidden='False', health=100, descriptiontoken='def_named_core_battery_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;

DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=105 WHERE id =  @aggvalueID;



DECLARE @definitionID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_damaged_medium_core_battery' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_artifact_damaged_medium_core_battery', quantity=1, attributeflags=589828, categoryflags=34079503, options='#moduleFlag=i20#tier=$tierlevel_t0', 
                note='', enabled=1, volume=1, mass=1500, hidden='False', health=100, descriptiontoken='def_artifact_damaged_core_battery_desc', purchasable=1, tiertype=1, 
                tierlevel=0 where definition=@definitionID;

DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=105 WHERE id =  @aggvalueID;



DECLARE @definitionID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_medium_core_battery' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_artifact_a_medium_core_battery', quantity=1, attributeflags=589824, categoryflags=34079503, options='#moduleFlag=i20#tier=$tierlevel_t3a', 
                note='', enabled=1, volume=1, mass=1500, hidden='False', health=100, descriptiontoken='def_artifact_a_core_battery_desc', purchasable=1, tiertype=3, 
                tierlevel=3 where definition=@definitionID;

DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=115 WHERE id =  @aggvalueID;



