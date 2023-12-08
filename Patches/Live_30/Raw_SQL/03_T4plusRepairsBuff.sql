
-- T4+ Medium and Small Armor Repair Buff to make them in line with T4P base stats so the T4P are true upgrades.

--Zone 70 T4+ Medium Repair

DECLARE @definitionID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_70_medium_armor_repairer' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_elitet4_70_medium_armor_repairer', quantity=1, attributeflags=81936, categoryflags=33685775, options='#moduleFlag=i20#tier=$tierlevel_t4+', 
                note='elite module', enabled=1, volume=1.5, mass=600, hidden=0, health=100, descriptiontoken='def_elitet4_70_medium_armor_repairer_desc', purchasable=1, tiertype=3, 
                tierlevel=4 where definition=@definitionID;

DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=297 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=52 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=105 WHERE id =  @aggvalueID;

--Zone 70 T4+ Small Repair

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_70_small_armor_repairer' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_elitet4_70_small_armor_repairer', quantity=1, attributeflags=49168, categoryflags=16908559, options='#moduleFlag=i20#tier=$tierlevel_t4+', 
                note='elite module', enabled=1, volume=1, mass=187.5, hidden=0, health=100, descriptiontoken='def_elitet4_70_small_armor_repairer_desc', purchasable=1, tiertype=3, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=63 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=38 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=26 WHERE id =  @aggvalueID;

--Zone 72 T4+ Medium Repair

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_72_medium_armor_repairer' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_elitet4_72_medium_armor_repairer', quantity=1, attributeflags=81936, categoryflags=33685775, options='#moduleFlag=i20#tier=$tierlevel_t4+', 
                note='elite module', enabled=1, volume=1.5, mass=600, hidden=0, health=100, descriptiontoken='def_elitet4_72_medium_armor_repairer_desc', purchasable=1, tiertype=3, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=297 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=52 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=105 WHERE id =  @aggvalueID;

--Zone 72 T4+ Small Repair

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_72_small_armor_repairer' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_elitet4_72_small_armor_repairer', quantity=1, attributeflags=49168, categoryflags=16908559, options='#moduleFlag=i20#tier=$tierlevel_t4+', 
                note='elite module', enabled=1, volume=1, mass=187.5, hidden=0, health=100, descriptiontoken='def_elitet4_72_small_armor_repairer_desc', purchasable=1, tiertype=3, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=63 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=38 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=26 WHERE id =  @aggvalueID;


