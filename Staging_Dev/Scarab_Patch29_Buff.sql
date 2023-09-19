----Scarab_Speed_Increase

--Scarab_Mk1
DECLARE @definitionID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_scarab_leg' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_scarab_leg', quantity=1, attributeflags=1024, categoryflags=262992, options='#height=f1.5#slotFlags=420,20,20', 
                note='', enabled=1, volume=35, mass=5000, hidden=1, health=100, descriptiontoken='def_scarab_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.19 WHERE id =  @aggvalueID;

--Scarab_MK1_PR

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_scarab_leg_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_scarab_leg_pr', quantity=1, attributeflags=1024, categoryflags=262992, options='#height=f1.5#slotFlags=420,20,20', 
                note='', enabled=1, volume=35, mass=5000, hidden=1, health=100, descriptiontoken='def_scarab_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.19 WHERE id =  @aggvalueID;

--Scarab_Mk2

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_scarab_leg_mk2' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_scarab_leg_mk2', quantity=1, attributeflags=1024, categoryflags=262992, options='#height=f1.5#slotFlags=420,20,20', 
                note='', enabled=1, volume=35, mass=6000, hidden=1, health=100, descriptiontoken='def_scarab_leg_mk2_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.19 WHERE id =  @aggvalueID;


---Scarab_MK1_AP_and_Reactor_increase

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_scarab_chassis' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_scarab_chassis', quantity=1, attributeflags=1024, categoryflags=262736, options='#height=f2#slotFlags=46d3,6d3', 
                note='', enabled=1, volume=175, mass=45000, hidden=1, health=100, descriptiontoken='def_scarab_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2800 WHERE id =  @aggvalueID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_scarab_chassis' ORDER BY definition DESC);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=750 WHERE id =  @aggvalueID;

---Scarab_MK1_PR

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_scarab_chassis_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_scarab_chassis_pr', quantity=1, attributeflags=1024, categoryflags=262736, options='#height=f2#slotFlags=46d3,6d3', 
                note='', enabled=1, volume=175, mass=45000, hidden=1, health=100, descriptiontoken='def_scarab_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2800 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=750 WHERE id =  @aggvalueID;

---Scarab_MK2

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_scarab_chassis_mk2' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_scarab_chassis_mk2', quantity=1, attributeflags=1024, categoryflags=262736, options='#height=f2#slotFlags=46d3,6d3', 
                note='', enabled=1, volume=175, mass=54000, hidden=1, health=100, descriptiontoken='def_scarab_chassis_mk2_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2800 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=810 WHERE id =  @aggvalueID;

---Add_Mk2_Head_slot_Scarab

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_scarab_head_mk2' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_scarab_head_mk2', quantity=1, attributeflags=1024, categoryflags=262480, options='#height=f0.1#slotFlags=48,8,8,8,8', 
                note='', enabled=1, volume=3, mass=3000, hidden=1, health=100, descriptiontoken='def_scarab_head_mk2_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

---Add_MK2_Leg_slot_Scarab

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_scarab_leg_mk2' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_scarab_leg_mk2', quantity=1, attributeflags=1024, categoryflags=262992, options='#height=f1.5#slotFlags=420,20,20,20', 
                note='', enabled=1, volume=35, mass=6000, hidden=1, health=100, descriptiontoken='def_scarab_leg_mk2_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;
