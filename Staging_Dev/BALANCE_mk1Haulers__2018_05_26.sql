USE [perpetuumsa]
GO

DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
DECLARE @definitionID int;

PRINT N'UPDATE MK1 HAULER CAPACITIES';

UPDATE entitydefaults
SET options='#capacity=f30.0'
WHERE definitionname = 'def_robot_inventory_ikarus';

UPDATE entitydefaults
SET options='#capacity=f120.0'
WHERE definitionname = 'def_robot_inventory_sequer';

UPDATE entitydefaults
SET options='#capacity=f260.0'
WHERE definitionname = 'def_robot_inventory_daidalos';

UPDATE entitydefaults
SET options='#capacity=f720.0'
WHERE definitionname = 'def_robot_inventory_lithus';

UPDATE entitydefaults
SET options='#capacity=f5000.0'
WHERE definitionname = 'def_robot_inventory_scarab';

PRINT N'Update Scarab bot stats';

PRINT N'def_scarab_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_scarab_leg_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_scarab_leg_pr', quantity=1, attributeflags=1024, categoryflags=262992, options='#height=f1.5#slotFlags=420,20,20', 
                note='', enabled=1, volume=35, mass=5000, hidden='True', health=100, descriptiontoken='def_scarab_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.75 WHERE id =  @aggvalueID;


PRINT N'def_scarab_leg';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_scarab_leg' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_scarab_leg', quantity=1, attributeflags=1024, categoryflags=262992, options='#height=f1.5#slotFlags=420,20,20', 
                note='', enabled=1, volume=35, mass=5000, hidden='True', health=100, descriptiontoken='def_scarab_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.75 WHERE id =  @aggvalueID;


PRINT N'def_scarab_head_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_scarab_head_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_scarab_head_pr', quantity=1, attributeflags=1024, categoryflags=262480, options='#height=f0.1#slotFlags=48,8,8,8', 
                note='', enabled=1, volume=3, mass=2500, hidden='True', health=100, descriptiontoken='def_scarab_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=400 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'stealth_strength' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=40 WHERE id =  @aggvalueID;


PRINT N'def_scarab_head';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_scarab_head' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_scarab_head', quantity=1, attributeflags=1024, categoryflags=262480, options='#height=f0.1#slotFlags=48,8,8,8', 
                note='', enabled=1, volume=3, mass=2500, hidden='True', health=100, descriptiontoken='def_scarab_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=400 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'stealth_strength' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=40 WHERE id =  @aggvalueID;


PRINT N'def_scarab_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_scarab_chassis_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_scarab_chassis_pr', quantity=1, attributeflags=1024, categoryflags=262736, options='#height=f2#slotFlags=46d3,6d3', 
                note='', enabled=1, volume=175, mass=45000, hidden='True', health=100, descriptiontoken='def_scarab_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=3000 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1800 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=600 WHERE id =  @aggvalueID;



PRINT N'def_scarab_chassis';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_scarab_chassis' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_scarab_chassis', quantity=1, attributeflags=1024, categoryflags=262736, options='#height=f2#slotFlags=46d3,6d3', 
                note='', enabled=1, volume=175, mass=45000, hidden='True', health=100, descriptiontoken='def_scarab_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=3000 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1800 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=600 WHERE id =  @aggvalueID;

GO
