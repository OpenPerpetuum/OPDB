USE [perpetuumsa]
GO


DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_autocannon' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_standard_small_autocannon', quantity=1, attributeflags=303824, categoryflags=4362209039, options='#moduleFlag=i51#ammoCapacity=ic8#ammoType=L1030a#tier=$tierlevel_t1', 
                note='', enabled=1, volume=0.6, mass=250, hidden='False', health=100, descriptiontoken='def_standard_small_longrange_autocannon_desc', purchasable=1, tiertype=1, 
                tierlevel=1 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=5.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_rocket_launcher' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_standard_rocket_launcher', quantity=1, attributeflags=303824, categoryflags=16975631, options='#moduleFlag=i52#ammoCapacity=i14#ammoType=L1040a#tier=$tierlevel_t1', 
                note='', enabled=1, volume=1, mass=250, hidden='False', health=100, descriptiontoken='def_standard_rocket_launcher_desc', purchasable=1, tiertype=1, 
                tierlevel=1 where definition=@definitionID;





SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_railgun' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_standard_small_railgun', quantity=1, attributeflags=303824, categoryflags=17041167, options='#moduleFlag=i51#ammoCapacity=i32#ammoType=L1010a#tier=$tierlevel_t1', 
                note='', enabled=1, volume=0.5, mass=250, hidden='False', health=100, descriptiontoken='def_standard_small_longrange_railgun_desc', purchasable=1, tiertype=1, 
                tierlevel=1 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_railgun' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_standard_medium_railgun', quantity=1, attributeflags=336592, categoryflags=33818383, options='#moduleFlag=i91#ammoCapacity=i32#ammoType=L2010a#tier=$tierlevel_t1', 
                note='', enabled=1, volume=1, mass=500, hidden='False', health=100, descriptiontoken='def_standard_medium_shortrange_railgun_desc', purchasable=1, tiertype=1, 
                tierlevel=1 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=13.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_armor_plate' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_standard_medium_armor_plate', quantity=1, attributeflags=589824, categoryflags=33620239, options='#moduleFlag=i20#tier=$tierlevel_t1', 
                note='', enabled=1, volume=2, mass=3000, hidden='False', health=100, descriptiontoken='def_standard_armor_plate_desc', purchasable=1, tiertype=1, 
                tierlevel=1 where definition=@definitionID;





SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_armor_plate' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_medium_armor_plate', quantity=1, attributeflags=589824, categoryflags=33620239, options='#moduleFlag=i20#tier=$tierlevel_t2', 
                note='', enabled=1, volume=2, mass=2400, hidden='False', health=100, descriptiontoken='def_named_armor_plate_desc', purchasable=1, tiertype=1, 
                tierlevel=2 where definition=@definitionID;





SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_armor_plate' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_medium_armor_plate', quantity=1, attributeflags=589824, categoryflags=33620239, options='#moduleFlag=i20#tier=$tierlevel_t3', 
                note='', enabled=1, volume=2, mass=3000, hidden='False', health=100, descriptiontoken='def_named_armor_plate_desc', purchasable=1, tiertype=1, 
                tierlevel=3 where definition=@definitionID;





SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_armor_plate' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_medium_armor_plate', quantity=1, attributeflags=589824, categoryflags=33620239, options='#moduleFlag=i20#tier=$tierlevel_t4', 
                note='', enabled=1, volume=2, mass=3350, hidden='False', health=100, descriptiontoken='def_named_armor_plate_desc', purchasable=1, tiertype=1, 
                tierlevel=4 where definition=@definitionID;





SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_laser' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_small_laser', quantity=1, attributeflags=303824, categoryflags=16844559, options='#moduleFlag=i51#ammoCapacity=i96#ammoType=L1020a#tier=$tierlevel_t2', 
                note='', enabled=1, volume=0.5, mass=225, hidden='False', health=100, descriptiontoken='def_named_small_longrange_laser_desc', purchasable=1, tiertype=1, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_small_laser' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_small_laser', quantity=1, attributeflags=303824, categoryflags=16844559, options='#moduleFlag=i51#ammoCapacity=i96#ammoType=L1020a#tier=$tierlevel_t3', 
                note='', enabled=1, volume=0.5, mass=250, hidden='False', health=100, descriptiontoken='def_named_small_longrange_laser_desc', purchasable=1, tiertype=1, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_small_laser' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_small_laser', quantity=1, attributeflags=303824, categoryflags=16844559, options='#moduleFlag=i51#ammoCapacity=i5a#ammoType=L1020a#tier=$tierlevel_t4', 
                note='', enabled=1, volume=0.5, mass=275, hidden='False', health=100, descriptiontoken='def_named_small_longrange_laser_desc', purchasable=1, tiertype=1, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_laser' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_medium_laser', quantity=1, attributeflags=336592, categoryflags=33621775, options='#moduleFlag=i91#ammoCapacity=i96#ammoType=L2020a#tier=$tierlevel_t2', 
                note='', enabled=1, volume=1, mass=450, hidden='False', health=100, descriptiontoken='def_named_medium_shortrange_laser_desc', purchasable=1, tiertype=1, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=11.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_laser' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_medium_laser', quantity=1, attributeflags=336592, categoryflags=33621775, options='#moduleFlag=i91#ammoCapacity=i96#ammoType=L2020a#tier=$tierlevel_t3', 
                note='', enabled=1, volume=1, mass=500, hidden='False', health=100, descriptiontoken='def_named_medium_shortrange_laser_desc', purchasable=1, tiertype=1, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=11.5 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=16 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_laser' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_medium_laser', quantity=1, attributeflags=336592, categoryflags=33621775, options='#moduleFlag=i91#ammoCapacity=i5a#ammoType=L2020a#tier=$tierlevel_t4', 
                note='', enabled=1, volume=1, mass=550, hidden='False', health=100, descriptiontoken='def_named_medium_shortrange_laser_desc', purchasable=1, tiertype=1, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=11.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_autocannon' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_small_autocannon', quantity=1, attributeflags=303824, categoryflags=4362209039, options='#moduleFlag=i51#ammoCapacity=ie6#ammoType=L1030a#tier=$tierlevel_t2', 
                note='', enabled=1, volume=0.6, mass=225, hidden='False', health=100, descriptiontoken='def_named_small_longrange_autocannon_desc', purchasable=1, tiertype=1, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=5.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_small_autocannon' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_small_autocannon', quantity=1, attributeflags=303824, categoryflags=4362209039, options='#moduleFlag=i51#ammoCapacity=ic8#ammoType=L1030a#tier=$tierlevel_t3', 
                note='', enabled=1, volume=0.6, mass=250, hidden='False', health=100, descriptiontoken='def_named_small_longrange_autocannon_desc', purchasable=1, tiertype=1, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=5.5 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.2 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_small_autocannon' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_small_autocannon', quantity=1, attributeflags=303824, categoryflags=4362209039, options='#moduleFlag=i51#ammoCapacity=ic8#ammoType=L1030a#tier=$tierlevel_t4', 
                note='', enabled=1, volume=0.6, mass=275, hidden='False', health=100, descriptiontoken='def_named_small_longrange_autocannon_desc', purchasable=1, tiertype=1, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=5.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_autocannon' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_medium_autocannon', quantity=1, attributeflags=336592, categoryflags=8657176335, options='#moduleFlag=i91#ammoCapacity=ia0#ammoType=L2030a#tier=$tierlevel_t2', 
                note='', enabled=1, volume=1.2, mass=450, hidden='False', health=100, descriptiontoken='def_named_medium_shortrange_autocannon_desc', purchasable=1, tiertype=1, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=14.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_autocannon' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_medium_autocannon', quantity=1, attributeflags=336592, categoryflags=8657176335, options='#moduleFlag=i91#ammoCapacity=i96#ammoType=L2030a#tier=$tierlevel_t3', 
                note='', enabled=1, volume=1.2, mass=500, hidden='False', health=100, descriptiontoken='def_named_medium_shortrange_autocannon_desc', purchasable=1, tiertype=1, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=14.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_autocannon' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_medium_autocannon', quantity=1, attributeflags=336592, categoryflags=8657176335, options='#moduleFlag=i91#ammoCapacity=ic8#ammoType=L2030a#tier=$tierlevel_t4', 
                note='', enabled=1, volume=1.2, mass=550, hidden='False', health=100, descriptiontoken='def_named_medium_shortrange_autocannon_desc', purchasable=1, tiertype=1, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=14.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_rocket_launcher' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_rocket_launcher', quantity=1, attributeflags=303824, categoryflags=16975631, options='#moduleFlag=i52#ammoCapacity=i19#ammoType=L1040a#tier=$tierlevel_t2', 
                note='', enabled=1, volume=1, mass=225, hidden='False', health=100, descriptiontoken='def_named_rocket_launcher_desc', purchasable=1, tiertype=1, 
                tierlevel=2 where definition=@definitionID;





SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_rocket_launcher' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_rocket_launcher', quantity=1, attributeflags=303824, categoryflags=16975631, options='#moduleFlag=i52#ammoCapacity=i19#ammoType=L1040a#tier=$tierlevel_t3', 
                note='', enabled=1, volume=1, mass=250, hidden='False', health=100, descriptiontoken='def_named_rocket_launcher_desc', purchasable=1, tiertype=1, 
                tierlevel=3 where definition=@definitionID;





SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_rocket_launcher' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_rocket_launcher', quantity=1, attributeflags=303824, categoryflags=16975631, options='#moduleFlag=i52#ammoCapacity=i1e#ammoType=L1040a#tier=$tierlevel_t4', 
                note='', enabled=1, volume=1, mass=275, hidden='False', health=100, descriptiontoken='def_named_rocket_launcher_desc', purchasable=1, tiertype=1, 
                tierlevel=4 where definition=@definitionID;





SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_railgun' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_small_railgun', quantity=1, attributeflags=303824, categoryflags=17041167, options='#moduleFlag=i51#ammoCapacity=i3c#ammoType=L1010a#tier=$tierlevel_t2', 
                note='', enabled=1, volume=0.5, mass=225, hidden='False', health=100, descriptiontoken='def_named_small_longrange_railgun_desc', purchasable=1, tiertype=1, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_small_railgun' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_small_railgun', quantity=1, attributeflags=303824, categoryflags=17041167, options='#moduleFlag=i51#ammoCapacity=i3c#ammoType=L1010a#tier=$tierlevel_t3', 
                note='', enabled=1, volume=0.5, mass=250, hidden='False', health=100, descriptiontoken='def_named_small_longrange_railgun_desc', purchasable=1, tiertype=1, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_small_railgun' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_small_railgun', quantity=1, attributeflags=303824, categoryflags=17041167, options='#moduleFlag=i51#ammoCapacity=i2d#ammoType=L1010a#tier=$tierlevel_t4', 
                note='', enabled=1, volume=0.5, mass=275, hidden='False', health=100, descriptiontoken='def_named_small_longrange_railgun_desc', purchasable=1, tiertype=1, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_railgun' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_medium_railgun', quantity=1, attributeflags=336592, categoryflags=33818383, options='#moduleFlag=i91#ammoCapacity=i3c#ammoType=L2010a#tier=$tierlevel_t2', 
                note='', enabled=1, volume=1, mass=450, hidden='False', health=100, descriptiontoken='def_named_medium_shortrange_railgun_desc', purchasable=1, tiertype=1, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=13.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_railgun' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_medium_railgun', quantity=1, attributeflags=336592, categoryflags=33818383, options='#moduleFlag=i91#ammoCapacity=i3c#ammoType=L2010a#tier=$tierlevel_t3', 
                note='', enabled=1, volume=1, mass=500, hidden='False', health=100, descriptiontoken='def_named_medium_shortrange_railgun_desc', purchasable=1, tiertype=1, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=13.5 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=15 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_railgun' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_medium_railgun', quantity=1, attributeflags=336592, categoryflags=33818383, options='#moduleFlag=i91#ammoCapacity=i14#ammoType=L2010a#tier=$tierlevel_t4', 
                note='', enabled=1, volume=1, mass=550, hidden='False', health=100, descriptiontoken='def_named_medium_shortrange_railgun_desc', purchasable=1, tiertype=1, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=13.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_damage_mod_railgun' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_damage_mod_railgun', quantity=1, attributeflags=524292, categoryflags=17106703, options='#moduleFlag=i8#tier=$tierlevel_t2', 
                note='', enabled=1, volume=0.5, mass=90, hidden='False', health=100, descriptiontoken='def_damage_mod_railgun_desc', purchasable=1, tiertype=1, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'railgun_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_damage_mod_railgun' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_damage_mod_railgun', quantity=1, attributeflags=524292, categoryflags=17106703, options='#moduleFlag=i8#tier=$tierlevel_t3', 
                note='', enabled=1, volume=0.5, mass=100, hidden='False', health=100, descriptiontoken='def_damage_mod_railgun_desc', purchasable=1, tiertype=1, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'railgun_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_damage_mod_railgun' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_damage_mod_railgun', quantity=1, attributeflags=524292, categoryflags=17106703, options='#moduleFlag=i8#tier=$tierlevel_t4', 
                note='', enabled=1, volume=0.5, mass=125, hidden='False', health=100, descriptiontoken='def_damage_mod_railgun_desc', purchasable=1, tiertype=1, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'railgun_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_damage_mod_missile' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_damage_mod_missile', quantity=1, attributeflags=524292, categoryflags=67438351, options='#moduleFlag=i8#tier=$tierlevel_t2', 
                note='', enabled=1, volume=0.5, mass=90, hidden='False', health=100, descriptiontoken='def_damage_mod_missile_desc', purchasable=1, tiertype=1, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'missile_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_damage_mod_missile' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_damage_mod_missile', quantity=1, attributeflags=524292, categoryflags=67438351, options='#moduleFlag=i8#tier=$tierlevel_t3', 
                note='', enabled=1, volume=0.5, mass=100, hidden='False', health=100, descriptiontoken='def_damage_mod_missile_desc', purchasable=1, tiertype=1, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'missile_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_damage_mod_missile' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_damage_mod_missile', quantity=1, attributeflags=524292, categoryflags=67438351, options='#moduleFlag=i8#tier=$tierlevel_t4', 
                note='', enabled=1, volume=0.5, mass=125, hidden='False', health=100, descriptiontoken='def_damage_mod_missile_desc', purchasable=1, tiertype=1, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'missile_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_damage_mod_laser' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_damage_mod_laser', quantity=1, attributeflags=524292, categoryflags=50661135, options='#moduleFlag=i8#tier=$tierlevel_t2', 
                note='', enabled=1, volume=0.5, mass=90, hidden='False', health=100, descriptiontoken='def_damage_mod_laser_desc', purchasable=1, tiertype=1, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'laser_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_damage_mod_laser' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_damage_mod_laser', quantity=1, attributeflags=524292, categoryflags=50661135, options='#moduleFlag=i8#tier=$tierlevel_t3', 
                note='', enabled=1, volume=0.5, mass=100, hidden='False', health=100, descriptiontoken='def_damage_mod_laser_desc', purchasable=1, tiertype=1, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'laser_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_damage_mod_laser' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_damage_mod_laser', quantity=1, attributeflags=524292, categoryflags=50661135, options='#moduleFlag=i8#tier=$tierlevel_t4', 
                note='', enabled=1, volume=0.5, mass=125, hidden='False', health=100, descriptiontoken='def_damage_mod_laser_desc', purchasable=1, tiertype=1, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'laser_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_damage_mod_projectile' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_damage_mod_projectile', quantity=1, attributeflags=524292, categoryflags=33883919, options='#moduleFlag=i8#tier=$tierlevel_t2', 
                note='', enabled=1, volume=0.5, mass=90, hidden='False', health=100, descriptiontoken='def_damage_mod_projectile_desc', purchasable=1, tiertype=1, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'projectile_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_damage_mod_projectile' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_damage_mod_projectile', quantity=1, attributeflags=524292, categoryflags=33883919, options='#moduleFlag=i8#tier=$tierlevel_t3', 
                note='', enabled=1, volume=0.5, mass=100, hidden='False', health=100, descriptiontoken='def_damage_mod_projectile_desc', purchasable=1, tiertype=1, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'projectile_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_damage_mod_projectile' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_damage_mod_projectile', quantity=1, attributeflags=524292, categoryflags=33883919, options='#moduleFlag=i8#tier=$tierlevel_t4', 
                note='', enabled=1, volume=0.5, mass=125, hidden='False', health=100, descriptiontoken='def_damage_mod_projectile_desc', purchasable=1, tiertype=1, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'projectile_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_longrange_standard_medium_railgun' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_longrange_standard_medium_railgun', quantity=1, attributeflags=336592, categoryflags=33818383, options='#moduleFlag=i91#ammoCapacity=i32#ammoType=L2010a#tier=$tierlevel_t1', 
                note='', enabled=1, volume=1, mass=650, hidden='False', health=100, descriptiontoken='def_standard_medium_longrange_railgun_desc', purchasable=1, tiertype=1, 
                tierlevel=1 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=14 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_longrange_standard_medium_laser' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_longrange_standard_medium_laser', quantity=1, attributeflags=336592, categoryflags=33621775, options='#moduleFlag=i91#ammoCapacity=i78#ammoType=L2020a#tier=$tierlevel_t1', 
                note='', enabled=1, volume=1, mass=650, hidden='False', health=100, descriptiontoken='def_standard_medium_longrange_laser_desc', purchasable=1, tiertype=1, 
                tierlevel=1 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_longrange_standard_medium_autocannon' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_longrange_standard_medium_autocannon', quantity=1, attributeflags=336592, categoryflags=8657176335, options='#moduleFlag=i91#ammoCapacity=i96#ammoType=L2030a#tier=$tierlevel_t1', 
                note='', enabled=1, volume=1.2, mass=650, hidden='False', health=100, descriptiontoken='def_standard_medium_longrange_autocannon_desc', purchasable=1, tiertype=1, 
                tierlevel=1 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=15 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_longrange_medium_railgun' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_longrange_medium_railgun', quantity=1, attributeflags=336592, categoryflags=33818383, options='#moduleFlag=i91#ammoCapacity=i32#ammoType=L2010a#tier=$tierlevel_t2', 
                note='', enabled=1, volume=1, mass=585, hidden='False', health=100, descriptiontoken='def_named_medium_longrange_railgun_desc', purchasable=1, tiertype=1, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=14 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_longrange_medium_railgun' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_longrange_medium_railgun', quantity=1, attributeflags=336592, categoryflags=33818383, options='#moduleFlag=i91#ammoCapacity=i32#ammoType=L2010a#tier=$tierlevel_t3', 
                note='', enabled=1, volume=1, mass=650, hidden='False', health=100, descriptiontoken='def_named_medium_longrange_railgun_desc', purchasable=1, tiertype=1, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=14 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_longrange_medium_railgun' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_longrange_medium_railgun', quantity=1, attributeflags=336592, categoryflags=33818383, options='#moduleFlag=i91#ammoCapacity=i32#ammoType=L2010a#tier=$tierlevel_t4', 
                note='', enabled=1, volume=1, mass=715, hidden='False', health=100, descriptiontoken='def_named_medium_longrange_railgun_desc', purchasable=1, tiertype=1, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=14 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_longrange_medium_laser' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_longrange_medium_laser', quantity=1, attributeflags=336592, categoryflags=33621775, options='#moduleFlag=i91#ammoCapacity=i78#ammoType=L2020a#tier=$tierlevel_t2', 
                note='', enabled=1, volume=1, mass=585, hidden='False', health=100, descriptiontoken='def_named_medium_longrange_laser_desc', purchasable=1, tiertype=1, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_longrange_medium_laser' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_longrange_medium_laser', quantity=1, attributeflags=336592, categoryflags=33621775, options='#moduleFlag=i91#ammoCapacity=i78#ammoType=L2020a#tier=$tierlevel_t3', 
                note='', enabled=1, volume=1, mass=650, hidden='False', health=100, descriptiontoken='def_named_medium_longrange_laser_desc', purchasable=1, tiertype=1, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_longrange_medium_laser' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_longrange_medium_laser', quantity=1, attributeflags=336592, categoryflags=33621775, options='#moduleFlag=i91#ammoCapacity=i78#ammoType=L2020a#tier=$tierlevel_t4', 
                note='', enabled=1, volume=1, mass=715, hidden='False', health=100, descriptiontoken='def_named_medium_longrange_laser_desc', purchasable=1, tiertype=1, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_longrange_medium_laser' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_longrange_medium_laser', quantity=1, attributeflags=336592, categoryflags=33621775, options='#moduleFlag=i91#ammoCapacity=i78#ammoType=L2020a#tier=$tierlevel_t3', 
                note='', enabled=1, volume=1, mass=650, hidden='False', health=100, descriptiontoken='def_named_medium_longrange_laser_desc', purchasable=1, tiertype=1, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=21 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_longrange_medium_autocannon' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_longrange_medium_autocannon', quantity=1, attributeflags=336592, categoryflags=8657176335, options='#moduleFlag=i91#ammoCapacity=i96#ammoType=L2030a#tier=$tierlevel_t2', 
                note='', enabled=1, volume=1.2, mass=585, hidden='False', health=100, descriptiontoken='def_named_medium_longrange_autocannon_desc', purchasable=1, tiertype=1, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=15 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_longrange_medium_autocannon' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_longrange_medium_autocannon', quantity=1, attributeflags=336592, categoryflags=8657176335, options='#moduleFlag=i91#ammoCapacity=i96#ammoType=L2030a#tier=$tierlevel_t3', 
                note='', enabled=1, volume=1.2, mass=650, hidden='False', health=100, descriptiontoken='def_named_medium_longrange_autocannon_desc', purchasable=1, tiertype=1, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=15 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_longrange_medium_autocannon' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_longrange_medium_autocannon', quantity=1, attributeflags=336592, categoryflags=8657176335, options='#moduleFlag=i91#ammoCapacity=i96#ammoType=L2030a#tier=$tierlevel_t4', 
                note='', enabled=1, volume=1.2, mass=715, hidden='False', health=100, descriptiontoken='def_named_medium_longrange_autocannon_desc', purchasable=1, tiertype=1, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=15 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_armor_repairer_upgrade' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_standard_armor_repairer_upgrade', quantity=1, attributeflags=524292, categoryflags=393487, options='#moduleFlag=i8#tier=$tierlevel_t1', 
                note='', enabled=1, volume=0.5, mass=300, hidden='False', health=100, descriptiontoken='def_armor_repairer_upgrade_desc', purchasable=1, tiertype=1, 
                tierlevel=1 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.08 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.96 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_armor_repairer_upgrade' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_armor_repairer_upgrade', quantity=1, attributeflags=524292, categoryflags=393487, options='#moduleFlag=i8#tier=$tierlevel_t2', 
                note='', enabled=1, volume=0.5, mass=270, hidden='False', health=100, descriptiontoken='def_armor_repairer_upgrade_desc', purchasable=1, tiertype=1, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.08 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.96 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_armor_repairer_upgrade' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_armor_repairer_upgrade', quantity=1, attributeflags=524292, categoryflags=393487, options='#moduleFlag=i8#tier=$tierlevel_t3', 
                note='', enabled=1, volume=0.5, mass=300, hidden='False', health=100, descriptiontoken='def_armor_repairer_upgrade_desc', purchasable=1, tiertype=1, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.12 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.936 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_armor_repairer_upgrade' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_armor_repairer_upgrade', quantity=1, attributeflags=524292, categoryflags=393487, options='#moduleFlag=i8#tier=$tierlevel_t4', 
                note='', enabled=1, volume=0.5, mass=375, hidden='False', health=100, descriptiontoken='def_armor_repairer_upgrade_desc', purchasable=1, tiertype=1, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.16 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.92 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_armor_plate_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_medium_armor_plate_pr', quantity=1, attributeflags=589824, categoryflags=33620239, options='#moduleFlag=i20#tier=$tierlevel_t2_pr', 
                note='', enabled=1, volume=2, mass=1800, hidden='False', health=100, descriptiontoken='def_named_armor_plate_desc', purchasable=1, tiertype=2, 
                tierlevel=2 where definition=@definitionID;





SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_armor_plate_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_medium_armor_plate_pr', quantity=1, attributeflags=589824, categoryflags=33620239, options='#moduleFlag=i20#tier=$tierlevel_t3_pr', 
                note='', enabled=1, volume=2, mass=2250, hidden='False', health=100, descriptiontoken='def_named_armor_plate_desc', purchasable=1, tiertype=2, 
                tierlevel=3 where definition=@definitionID;





SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_armor_plate_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_medium_armor_plate_pr', quantity=1, attributeflags=589824, categoryflags=33620239, options='#moduleFlag=i20#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=2, mass=2515, hidden='False', health=100, descriptiontoken='def_named_armor_plate_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;





SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_shield_generator_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_small_shield_generator_pr', quantity=1, attributeflags=49432, categoryflags=16843279, options='#moduleFlag=i20#tier=$tierlevel_t2_pr', 
                note='', enabled=1, volume=0.3, mass=135, hidden='False', health=100, descriptiontoken='def_named_shield_generator_desc', purchasable=1, tiertype=2, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'shield_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_small_shield_generator_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_small_shield_generator_pr', quantity=1, attributeflags=49432, categoryflags=16843279, options='#moduleFlag=i20#tier=$tierlevel_t3_pr', 
                note='', enabled=1, volume=0.3, mass=157.5, hidden='False', health=100, descriptiontoken='def_named_shield_generator_desc', purchasable=1, tiertype=2, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'shield_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_small_shield_generator_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_small_shield_generator_pr', quantity=1, attributeflags=49432, categoryflags=16843279, options='#moduleFlag=i20#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=0.3, mass=172.5, hidden='False', health=100, descriptiontoken='def_named_shield_generator_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'shield_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=6 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_shield_generator_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_medium_shield_generator_pr', quantity=1, attributeflags=82200, categoryflags=33620495, options='#moduleFlag=i20#tier=$tierlevel_t2_pr', 
                note='', enabled=1, volume=0.5, mass=270, hidden='False', health=100, descriptiontoken='def_named_shield_generator_desc', purchasable=1, tiertype=2, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'shield_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_shield_generator_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_medium_shield_generator_pr', quantity=1, attributeflags=82200, categoryflags=33620495, options='#moduleFlag=i20#tier=$tierlevel_t3_pr', 
                note='', enabled=1, volume=0.5, mass=330, hidden='False', health=100, descriptiontoken='def_named_shield_generator_desc', purchasable=1, tiertype=2, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'shield_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_shield_hardener_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_shield_hardener_pr', quantity=1, attributeflags=540928, categoryflags=131599, options='#moduleFlag=i8#tier=$tierlevel_t2_pr', 
                note='', enabled=1, volume=0.5, mass=202.5, hidden='False', health=100, descriptiontoken='def_named_shield_hardener_desc', purchasable=1, tiertype=2, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'shield_absorbtion_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.2 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_shield_hardener_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_shield_hardener_pr', quantity=1, attributeflags=540928, categoryflags=131599, options='#moduleFlag=i8#tier=$tierlevel_t3_pr', 
                note='', enabled=1, volume=0.5, mass=225, hidden='False', health=100, descriptiontoken='def_named_shield_hardener_desc', purchasable=1, tiertype=2, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'shield_absorbtion_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.25 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_shield_hardener_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_shield_hardener_pr', quantity=1, attributeflags=540928, categoryflags=131599, options='#moduleFlag=i8#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=0.5, mass=232.5, hidden='False', health=100, descriptiontoken='def_named_shield_hardener_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'shield_absorbtion_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.3 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_mining_upgrade_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_mining_upgrade_pr', quantity=1, attributeflags=524288, categoryflags=263695, options='#moduleFlag=i8#tier=$tierlevel_t2_pr', 
                note='', enabled=1, volume=0.1, mass=45, hidden='False', health=100, descriptiontoken='def_named_mining_upgrade_desc', purchasable=1, tiertype=2, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'harvesting_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.05 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mining_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.05 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_mining_upgrade_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_mining_upgrade_pr', quantity=1, attributeflags=524288, categoryflags=263695, options='#moduleFlag=i8#tier=$tierlevel_t3_pr', 
                note='', enabled=1, volume=0.1, mass=45, hidden='False', health=100, descriptiontoken='def_named_mining_upgrade_desc', purchasable=1, tiertype=2, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'harvesting_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.075 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mining_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.075 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_mining_upgrade_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_mining_upgrade_pr', quantity=1, attributeflags=524288, categoryflags=263695, options='#moduleFlag=i8#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=0.1, mass=45, hidden='False', health=100, descriptiontoken='def_named_mining_upgrade_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'harvesting_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mining_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.1 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_laser_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_small_laser_pr', quantity=1, attributeflags=303824, categoryflags=16844559, options='#moduleFlag=i51#ammoCapacity=ib4#ammoType=L1020a#tier=$tierlevel_t2_pr', 
                note='', enabled=1, volume=0.5, mass=225, hidden='False', health=100, descriptiontoken='def_named_small_longrange_laser_desc', purchasable=1, tiertype=2, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_small_laser_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_small_laser_pr', quantity=1, attributeflags=303824, categoryflags=16844559, options='#moduleFlag=i51#ammoCapacity=ib4#ammoType=L1020a#tier=$tierlevel_t3_pr', 
                note='', enabled=1, volume=0.5, mass=250, hidden='False', health=100, descriptiontoken='def_named_small_longrange_laser_desc', purchasable=1, tiertype=2, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_small_laser_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_small_laser_pr', quantity=1, attributeflags=303824, categoryflags=16844559, options='#moduleFlag=i51#ammoCapacity=i6e#ammoType=L1020a#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=0.5, mass=275, hidden='False', health=100, descriptiontoken='def_named_small_longrange_laser_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_laser_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_medium_laser_pr', quantity=1, attributeflags=336592, categoryflags=33621775, options='#moduleFlag=i91#ammoCapacity=ib4#ammoType=L2020a#tier=$tierlevel_t2_pr', 
                note='', enabled=1, volume=1, mass=450, hidden='False', health=100, descriptiontoken='def_named_medium_shortrange_laser_desc', purchasable=1, tiertype=2, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=11.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_laser_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_medium_laser_pr', quantity=1, attributeflags=336592, categoryflags=33621775, options='#moduleFlag=i91#ammoCapacity=ib4#ammoType=L2020a#tier=$tierlevel_t3_pr', 
                note='', enabled=1, volume=1, mass=500, hidden='False', health=100, descriptiontoken='def_named_medium_shortrange_laser_desc', purchasable=1, tiertype=2, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=11.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_laser_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_medium_laser_pr', quantity=1, attributeflags=336592, categoryflags=33621775, options='#moduleFlag=i91#ammoCapacity=i6e#ammoType=L2020a#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=1, mass=550, hidden='False', health=100, descriptiontoken='def_named_medium_shortrange_laser_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=11.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_autocannon_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_small_autocannon_pr', quantity=1, attributeflags=303824, categoryflags=4362209039, options='#moduleFlag=i51#ammoCapacity=i118#ammoType=L1030a#tier=$tierlevel_t2_pr', 
                note='', enabled=1, volume=0.6, mass=225, hidden='False', health=100, descriptiontoken='def_named_small_longrange_autocannon_desc', purchasable=1, tiertype=2, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=5.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_small_autocannon_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_small_autocannon_pr', quantity=1, attributeflags=303824, categoryflags=4362209039, options='#moduleFlag=i51#ammoCapacity=if0#ammoType=L1030a#tier=$tierlevel_t3_pr', 
                note='', enabled=1, volume=0.6, mass=250, hidden='False', health=100, descriptiontoken='def_named_small_longrange_autocannon_desc', purchasable=1, tiertype=2, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=5.5 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.1 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_small_autocannon_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_small_autocannon_pr', quantity=1, attributeflags=303824, categoryflags=4362209039, options='#moduleFlag=i51#ammoCapacity=if0#ammoType=L1030a#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=0.6, mass=275, hidden='False', health=100, descriptiontoken='def_named_small_longrange_autocannon_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=5.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_autocannon_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_medium_autocannon_pr', quantity=1, attributeflags=336592, categoryflags=8657176335, options='#moduleFlag=i91#ammoCapacity=ibe#ammoType=L2030a#tier=$tierlevel_t2_pr', 
                note='', enabled=1, volume=1.2, mass=450, hidden='False', health=100, descriptiontoken='def_named_medium_shortrange_autocannon_desc', purchasable=1, tiertype=2, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=14.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_autocannon_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_medium_autocannon_pr', quantity=1, attributeflags=336592, categoryflags=8657176335, options='#moduleFlag=i91#ammoCapacity=ib4#ammoType=L2030a#tier=$tierlevel_t3_pr', 
                note='', enabled=1, volume=1.2, mass=500, hidden='False', health=100, descriptiontoken='def_named_medium_shortrange_autocannon_desc', purchasable=1, tiertype=2, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=14.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_autocannon_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_medium_autocannon_pr', quantity=1, attributeflags=336592, categoryflags=8657176335, options='#moduleFlag=i91#ammoCapacity=if0#ammoType=L2030a#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=1.2, mass=550, hidden='False', health=100, descriptiontoken='def_named_medium_shortrange_autocannon_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=14.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_rocket_launcher_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_rocket_launcher_pr', quantity=1, attributeflags=303824, categoryflags=16975631, options='#moduleFlag=i52#ammoCapacity=i32#ammoType=L1040a#tier=$tierlevel_t2_pr', 
                note='', enabled=1, volume=1, mass=225, hidden='False', health=100, descriptiontoken='def_named_rocket_launcher_desc', purchasable=1, tiertype=2, 
                tierlevel=2 where definition=@definitionID;





SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_rocket_launcher_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_rocket_launcher_pr', quantity=1, attributeflags=303824, categoryflags=16975631, options='#moduleFlag=i52#ammoCapacity=i32#ammoType=L1040a#tier=$tierlevel_t3_pr', 
                note='', enabled=1, volume=1, mass=250, hidden='False', health=100, descriptiontoken='def_named_rocket_launcher_desc', purchasable=1, tiertype=2, 
                tierlevel=3 where definition=@definitionID;





SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_rocket_launcher_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_rocket_launcher_pr', quantity=1, attributeflags=303824, categoryflags=16975631, options='#moduleFlag=i52#ammoCapacity=i3c#ammoType=L1040a#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=1, mass=275, hidden='False', health=100, descriptiontoken='def_named_rocket_launcher_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;





SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_missile_launcher_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_missile_launcher_pr', quantity=1, attributeflags=336592, categoryflags=33752847, options='#moduleFlag=i92#ammoCapacity=i32#ammoType=L2040a#tier=$tierlevel_t2_pr', 
                note='', enabled=1, volume=2, mass=450, hidden='False', health=100, descriptiontoken='def_named_missile_launcher_desc', purchasable=1, tiertype=2, 
                tierlevel=2 where definition=@definitionID;





SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_missile_launcher_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_missile_launcher_pr', quantity=1, attributeflags=336592, categoryflags=33752847, options='#moduleFlag=i92#ammoCapacity=i32#ammoType=L2040a#tier=$tierlevel_t3_pr', 
                note='', enabled=1, volume=2, mass=500, hidden='False', health=100, descriptiontoken='def_named_missile_launcher_desc', purchasable=1, tiertype=2, 
                tierlevel=3 where definition=@definitionID;





SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_missile_launcher_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_missile_launcher_pr', quantity=1, attributeflags=336592, categoryflags=33752847, options='#moduleFlag=i92#ammoCapacity=i3c#ammoType=L2040a#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=2, mass=550, hidden='False', health=100, descriptiontoken='def_named_missile_launcher_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;





SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_railgun_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_small_railgun_pr', quantity=1, attributeflags=303824, categoryflags=17041167, options='#moduleFlag=i51#ammoCapacity=i46#ammoType=L1010a#tier=$tierlevel_t2_pr', 
                note='', enabled=1, volume=0.5, mass=225, hidden='False', health=100, descriptiontoken='def_named_small_longrange_railgun_desc', purchasable=1, tiertype=2, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_small_railgun_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_small_railgun_pr', quantity=1, attributeflags=303824, categoryflags=17041167, options='#moduleFlag=i51#ammoCapacity=i46#ammoType=L1010a#tier=$tierlevel_t3_pr', 
                note='', enabled=1, volume=0.5, mass=250, hidden='False', health=100, descriptiontoken='def_named_small_longrange_railgun_desc', purchasable=1, tiertype=2, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_small_railgun_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_small_railgun_pr', quantity=1, attributeflags=303824, categoryflags=17041167, options='#moduleFlag=i51#ammoCapacity=i37#ammoType=L1010a#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=0.5, mass=275, hidden='False', health=100, descriptiontoken='def_named_small_longrange_railgun_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_railgun_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_medium_railgun_pr', quantity=1, attributeflags=336592, categoryflags=33818383, options='#moduleFlag=i91#ammoCapacity=i46#ammoType=L2010a#tier=$tierlevel_t2_pr', 
                note='', enabled=1, volume=1, mass=450, hidden='False', health=100, descriptiontoken='def_named_medium_shortrange_railgun_desc', purchasable=1, tiertype=2, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=13.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_railgun_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_medium_railgun_pr', quantity=1, attributeflags=336592, categoryflags=33818383, options='#moduleFlag=i91#ammoCapacity=i46#ammoType=L2010a#tier=$tierlevel_t3_pr', 
                note='', enabled=1, volume=1, mass=500, hidden='False', health=100, descriptiontoken='def_named_medium_shortrange_railgun_desc', purchasable=1, tiertype=2, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=13.5 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=15 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_railgun_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_medium_railgun_pr', quantity=1, attributeflags=336592, categoryflags=33818383, options='#moduleFlag=i91#ammoCapacity=i19#ammoType=L2010a#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=1, mass=550, hidden='False', health=100, descriptiontoken='def_named_medium_shortrange_railgun_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=13.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_damage_mod_railgun_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_damage_mod_railgun_pr', quantity=1, attributeflags=524292, categoryflags=17106703, options='#moduleFlag=i8#tier=$tierlevel_t2_pr', 
                note='', enabled=1, volume=0.5, mass=75, hidden='False', health=100, descriptiontoken='def_damage_mod_railgun_desc', purchasable=1, tiertype=2, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_railgun_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.15 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'railgun_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'railgun_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_damage_mod_railgun_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_damage_mod_railgun_pr', quantity=1, attributeflags=524292, categoryflags=17106703, options='#moduleFlag=i8#tier=$tierlevel_t3_pr', 
                note='', enabled=1, volume=0.5, mass=80, hidden='False', health=100, descriptiontoken='def_damage_mod_railgun_desc', purchasable=1, tiertype=2, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_railgun_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.2 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'railgun_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_damage_mod_railgun_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_damage_mod_railgun_pr', quantity=1, attributeflags=524292, categoryflags=17106703, options='#moduleFlag=i8#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=0.5, mass=100, hidden='False', health=100, descriptiontoken='def_damage_mod_railgun_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_railgun_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.25 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'railgun_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_damage_mod_missile_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_damage_mod_missile_pr', quantity=1, attributeflags=524292, categoryflags=67438351, options='#moduleFlag=i8#tier=$tierlevel_t2_pr', 
                note='', enabled=1, volume=0.5, mass=75, hidden='False', health=100, descriptiontoken='def_damage_mod_missile_desc', purchasable=1, tiertype=2, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_missile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.15 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'missile_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_damage_mod_missile_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_damage_mod_missile_pr', quantity=1, attributeflags=524292, categoryflags=67438351, options='#moduleFlag=i8#tier=$tierlevel_t3_pr', 
                note='', enabled=1, volume=0.5, mass=80, hidden='False', health=100, descriptiontoken='def_damage_mod_missile_desc', purchasable=1, tiertype=2, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_missile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.2 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'missile_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_damage_mod_missile_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_damage_mod_missile_pr', quantity=1, attributeflags=524292, categoryflags=67438351, options='#moduleFlag=i8#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=0.5, mass=100, hidden='False', health=100, descriptiontoken='def_damage_mod_missile_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_missile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.25 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'missile_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_damage_mod_laser_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_damage_mod_laser_pr', quantity=1, attributeflags=524292, categoryflags=50661135, options='#moduleFlag=i8#tier=$tierlevel_t2_pr', 
                note='', enabled=1, volume=0.5, mass=75, hidden='False', health=100, descriptiontoken='def_damage_mod_laser_desc', purchasable=1, tiertype=2, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_laser_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.15 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'laser_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_damage_mod_laser_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_damage_mod_laser_pr', quantity=1, attributeflags=524292, categoryflags=50661135, options='#moduleFlag=i8#tier=$tierlevel_t3_pr', 
                note='', enabled=1, volume=0.5, mass=80, hidden='False', health=100, descriptiontoken='def_damage_mod_laser_desc', purchasable=1, tiertype=2, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_laser_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.2 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'laser_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_damage_mod_laser_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_damage_mod_laser_pr', quantity=1, attributeflags=524292, categoryflags=50661135, options='#moduleFlag=i8#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=0.5, mass=100, hidden='False', health=100, descriptiontoken='def_damage_mod_laser_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_laser_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.25 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'laser_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_damage_mod_projectile_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_damage_mod_projectile_pr', quantity=1, attributeflags=524292, categoryflags=33883919, options='#moduleFlag=i8#tier=$tierlevel_t2_pr', 
                note='', enabled=1, volume=0.5, mass=75, hidden='False', health=100, descriptiontoken='def_damage_mod_projectile_desc', purchasable=1, tiertype=2, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_projectile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.15 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'projectile_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_damage_mod_projectile_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_damage_mod_projectile_pr', quantity=1, attributeflags=524292, categoryflags=33883919, options='#moduleFlag=i8#tier=$tierlevel_t3_pr', 
                note='', enabled=1, volume=0.5, mass=80, hidden='False', health=100, descriptiontoken='def_damage_mod_projectile_desc', purchasable=1, tiertype=2, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_projectile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.2 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'projectile_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_damage_mod_projectile_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_damage_mod_projectile_pr', quantity=1, attributeflags=524292, categoryflags=33883919, options='#moduleFlag=i8#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=0.5, mass=100, hidden='False', health=100, descriptiontoken='def_damage_mod_projectile_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_projectile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.25 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'projectile_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_longrange_medium_railgun_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_longrange_medium_railgun_pr', quantity=1, attributeflags=336592, categoryflags=33818383, options='#moduleFlag=i91#ammoCapacity=i3c#ammoType=L2010a#tier=$tierlevel_t2_pr', 
                note='', enabled=1, volume=1, mass=585, hidden='False', health=100, descriptiontoken='def_named_medium_longrange_railgun_desc', purchasable=1, tiertype=2, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=14 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_longrange_medium_railgun_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_longrange_medium_railgun_pr', quantity=1, attributeflags=336592, categoryflags=33818383, options='#moduleFlag=i91#ammoCapacity=i3c#ammoType=L2010a#tier=$tierlevel_t3_pr', 
                note='', enabled=1, volume=1, mass=650, hidden='False', health=100, descriptiontoken='def_named_medium_longrange_railgun_desc', purchasable=1, tiertype=2, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=14 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_longrange_medium_railgun_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_longrange_medium_railgun_pr', quantity=1, attributeflags=336592, categoryflags=33818383, options='#moduleFlag=i91#ammoCapacity=i3c#ammoType=L2010a#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=1, mass=715, hidden='False', health=100, descriptiontoken='def_named_medium_longrange_railgun_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=14 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_longrange_medium_laser_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_longrange_medium_laser_pr', quantity=1, attributeflags=336592, categoryflags=33621775, options='#moduleFlag=i91#ammoCapacity=i91#ammoType=L2020a#tier=$tierlevel_t2_pr', 
                note='', enabled=1, volume=1, mass=585, hidden='False', health=100, descriptiontoken='def_named_medium_longrange_laser_desc', purchasable=1, tiertype=2, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_longrange_medium_laser_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_longrange_medium_laser_pr', quantity=1, attributeflags=336592, categoryflags=33621775, options='#moduleFlag=i91#ammoCapacity=i91#ammoType=L2020a#tier=$tierlevel_t3_pr', 
                note='', enabled=1, volume=1, mass=650, hidden='False', health=100, descriptiontoken='def_named_medium_longrange_laser_desc', purchasable=1, tiertype=2, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=17 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_longrange_medium_laser_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_longrange_medium_laser_pr', quantity=1, attributeflags=336592, categoryflags=33621775, options='#moduleFlag=i91#ammoCapacity=i91#ammoType=L2020a#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=1, mass=715, hidden='False', health=100, descriptiontoken='def_named_medium_longrange_laser_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_longrange_medium_autocannon_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_longrange_medium_autocannon_pr', quantity=1, attributeflags=336592, categoryflags=8657176335, options='#moduleFlag=i91#ammoCapacity=ib4#ammoType=L2030a#tier=$tierlevel_t2_pr', 
                note='', enabled=1, volume=1.2, mass=585, hidden='False', health=100, descriptiontoken='def_named_medium_longrange_autocannon_desc', purchasable=1, tiertype=2, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=15 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_longrange_medium_autocannon_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_longrange_medium_autocannon_pr', quantity=1, attributeflags=336592, categoryflags=8657176335, options='#moduleFlag=i91#ammoCapacity=ib4#ammoType=L2030a#tier=$tierlevel_t3_pr', 
                note='', enabled=1, volume=1.2, mass=650, hidden='False', health=100, descriptiontoken='def_named_medium_longrange_autocannon_desc', purchasable=1, tiertype=2, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=15 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.3 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_longrange_medium_autocannon_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_longrange_medium_autocannon_pr', quantity=1, attributeflags=336592, categoryflags=8657176335, options='#moduleFlag=i91#ammoCapacity=ib4#ammoType=L2030a#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=1.2, mass=715, hidden='False', health=100, descriptiontoken='def_named_medium_longrange_autocannon_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=15 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_armor_repairer_upgrade_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_armor_repairer_upgrade_pr', quantity=1, attributeflags=524292, categoryflags=393487, options='#moduleFlag=i8#tier=$tierlevel_t2_pr', 
                note='', enabled=1, volume=0.5, mass=216, hidden='False', health=100, descriptiontoken='def_armor_repairer_upgrade_desc', purchasable=1, tiertype=2, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.08 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.96 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_armor_repairer_upgrade_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_armor_repairer_upgrade_pr', quantity=1, attributeflags=524292, categoryflags=393487, options='#moduleFlag=i8#tier=$tierlevel_t3_pr', 
                note='', enabled=1, volume=0.5, mass=240, hidden='False', health=100, descriptiontoken='def_armor_repairer_upgrade_desc', purchasable=1, tiertype=2, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.12 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.936 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_armor_repairer_upgrade_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_armor_repairer_upgrade_pr', quantity=1, attributeflags=524292, categoryflags=393487, options='#moduleFlag=i8#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=0.5, mass=300, hidden='False', health=100, descriptiontoken='def_armor_repairer_upgrade_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.16 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.92 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_medium_armor_plate' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_artifact_a_medium_armor_plate', quantity=1, attributeflags=589824, categoryflags=33620239, options='#moduleFlag=i20#tier=$tierlevel_t3a', 
                note='', enabled=1, volume=2, mass=2700, hidden='False', health=100, descriptiontoken='def_artifact_a_medium_armor_plate_desc', purchasable=1, tiertype=3, 
                tierlevel=3 where definition=@definitionID;





SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_small_shield_generator' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_artifact_a_small_shield_generator', quantity=1, attributeflags=49432, categoryflags=16843279, options='#moduleFlag=i20#tier=$tierlevel_t3a', 
                note='damage to core = shield_absorbtion * shield_absorbtion_modifier

amig ez a modul fut addig nincs damage, csak a core-bol von le.
', enabled=1, volume=0.3, mass=180, hidden='False', health=100, descriptiontoken='def_artifact_a_shield_generator_desc', purchasable=1, tiertype=3, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'shield_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_medium_shield_generator' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_artifact_a_medium_shield_generator', quantity=1, attributeflags=82200, categoryflags=33620495, options='#moduleFlag=i20#tier=$tierlevel_t3a', 
                note='', enabled=1, volume=0.5, mass=360, hidden='False', health=100, descriptiontoken='def_artifact_a_shield_generator_desc', purchasable=1, tiertype=3, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'shield_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_shield_hardener' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_artifact_a_shield_hardener', quantity=1, attributeflags=540928, categoryflags=131599, options='#moduleFlag=i8#tier=$tierlevel_t3a', 
                note='ettol a modultol tud jobban mudkodni a pajzs = kevesebb lesz a core csokkenes', enabled=1, volume=0.5, mass=270, hidden='False', health=100, descriptiontoken='def_artifact_a_shield_hardener_desc', purchasable=1, tiertype=3, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'shield_absorbtion_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.25 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_mining_upgrade' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_artifact_a_mining_upgrade', quantity=1, attributeflags=524288, categoryflags=263695, options='#moduleFlag=i8#tier=$tierlevel_t3a', 
                note='', enabled=1, volume=0.1, mass=50, hidden='False', health=100, descriptiontoken='def_artifact_a_mining_upgrade_desc', purchasable=1, tiertype=3, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'harvesting_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.075 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mining_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.075 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_small_laser' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_artifact_a_small_laser', quantity=1, attributeflags=303824, categoryflags=16844559, options='#moduleFlag=i51#ammoCapacity=i96#ammoType=L1020a#tier=$tierlevel_t3a', 
                note='', enabled=1, volume=0.5, mass=250, hidden='False', health=100, descriptiontoken='def_artifact_a_small_longrange_laser_desc', purchasable=1, tiertype=3, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_medium_laser' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_artifact_a_medium_laser', quantity=1, attributeflags=336592, categoryflags=33621775, options='#moduleFlag=i91#ammoCapacity=i96#ammoType=L2020a#tier=$tierlevel_t3a', 
                note='', enabled=1, volume=1, mass=500, hidden='False', health=100, descriptiontoken='def_artifact_a_medium_shortrange_laser_desc', purchasable=1, tiertype=3, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=11.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_damaged_longrange_medium_laser' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_artifact_damaged_longrange_medium_laser', quantity=1, attributeflags=336592, categoryflags=33621775, options='#moduleFlag=i91#ammoCapacity=i78#ammoType=L2020a#tier=$tierlevel_t0', 
                note='', enabled=1, volume=1, mass=650, hidden='False', health=100, descriptiontoken='def_artifact_damaged_medium_longrange_laser_desc', purchasable=1, tiertype=1, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=21 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_longrange_medium_laser' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_artifact_a_longrange_medium_laser', quantity=1, attributeflags=336592, categoryflags=33621775, options='#moduleFlag=i91#ammoCapacity=i78#ammoType=L2020a#tier=$tierlevel_t3a', 
                note='', enabled=1, volume=1, mass=650, hidden='False', health=100, descriptiontoken='def_artifact_a_medium_longrange_laser_desc', purchasable=1, tiertype=3, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=21 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_rocket_launcher' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_artifact_a_rocket_launcher', quantity=1, attributeflags=303824, categoryflags=16975631, options='#moduleFlag=i52#ammoCapacity=i19#ammoType=L1040a#tier=$tierlevel_t3a', 
                note='', enabled=1, volume=1, mass=250, hidden='False', health=100, descriptiontoken='def_artifact_a_rocket_launcher_desc', purchasable=1, tiertype=3, 
                tierlevel=3 where definition=@definitionID;





SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_missile_launcher' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_artifact_a_missile_launcher', quantity=1, attributeflags=336592, categoryflags=33752847, options='#moduleFlag=i92#ammoCapacity=i19#ammoType=L2040a#tier=$tierlevel_t3a', 
                note='', enabled=1, volume=2, mass=500, hidden='False', health=100, descriptiontoken='def_artifact_a_missile_launcher_desc', purchasable=1, tiertype=3, 
                tierlevel=3 where definition=@definitionID;





SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_small_railgun' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_artifact_a_small_railgun', quantity=1, attributeflags=303824, categoryflags=17041167, options='#moduleFlag=i51#ammoCapacity=i3c#ammoType=L1010a#tier=$tierlevel_t3a', 
                note='', enabled=1, volume=0.5, mass=250, hidden='False', health=100, descriptiontoken='def_artifact_a_small_longrange_railgun_desc', purchasable=1, tiertype=3, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_medium_railgun' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_artifact_a_medium_railgun', quantity=1, attributeflags=336592, categoryflags=33818383, options='#moduleFlag=i91#ammoCapacity=i3c#ammoType=L2010a#tier=$tierlevel_t3a', 
                note='', enabled=1, volume=1, mass=500, hidden='False', health=100, descriptiontoken='def_artifact_a_medium_shortrange_railgun_desc', purchasable=1, tiertype=3, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=13.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_damaged_longrange_medium_railgun' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_artifact_damaged_longrange_medium_railgun', quantity=1, attributeflags=336592, categoryflags=33818383, options='#moduleFlag=i91#ammoCapacity=i32#ammoType=L2010a#tier=$tierlevel_t0', 
                note='', enabled=1, volume=1, mass=650, hidden='False', health=100, descriptiontoken='def_artifact_damaged_medium_longrange_railgun_desc', purchasable=1, tiertype=1, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=14 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_longrange_medium_railgun' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_artifact_a_longrange_medium_railgun', quantity=1, attributeflags=336592, categoryflags=33818383, options='#moduleFlag=i91#ammoCapacity=i32#ammoType=L2010a#tier=$tierlevel_t3a', 
                note='', enabled=1, volume=1, mass=650, hidden='False', health=100, descriptiontoken='def_artifact_a_medium_longrange_railgun_desc', purchasable=1, tiertype=3, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=14 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_damage_mod_railgun' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_artifact_a_damage_mod_railgun', quantity=1, attributeflags=524292, categoryflags=17106703, options='#moduleFlag=i8#tier=$tierlevel_t3a', 
                note='', enabled=1, volume=0.5, mass=90, hidden='False', health=100, descriptiontoken='def_artifact_a_damage_mod_railgun_desc', purchasable=1, tiertype=3, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_railgun_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.2 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'railgun_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_damage_mod_laser' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_artifact_a_damage_mod_laser', quantity=1, attributeflags=524292, categoryflags=50661135, options='#moduleFlag=i8#tier=$tierlevel_t3a', 
                note='', enabled=1, volume=0.5, mass=90, hidden='False', health=100, descriptiontoken='def_artifact_a_mod_laser_desc', purchasable=1, tiertype=3, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_laser_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.2 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'laser_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_damage_mod_missile' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_artifact_a_damage_mod_missile', quantity=1, attributeflags=524292, categoryflags=67438351, options='#moduleFlag=i8#tier=$tierlevel_t3a', 
                note='', enabled=1, volume=0.5, mass=90, hidden='False', health=100, descriptiontoken='def_artifact_a_damage_mod_missile_desc', purchasable=1, tiertype=3, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_missile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.2 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'missile_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_shield_generator' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_standard_small_shield_generator', quantity=1, attributeflags=49432, categoryflags=16843279, options='#moduleFlag=i20#tier=$tierlevel_t1', 
                note='damage to core = shield_absorbtion * shield_absorbtion_modifier

amig ez a modul fut addig nincs damage, csak a core-bol von le.
', enabled=1, volume=0.3, mass=200, hidden='False', health=100, descriptiontoken='def_standard_shield_generator_desc', purchasable=1, tiertype=1, 
                tierlevel=1 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'shield_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_shield_generator' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_standard_medium_shield_generator', quantity=1, attributeflags=82200, categoryflags=33620495, options='#moduleFlag=i20#tier=$tierlevel_t1', 
                note='', enabled=1, volume=0.5, mass=400, hidden='False', health=100, descriptiontoken='def_standard_shield_generator_desc', purchasable=1, tiertype=1, 
                tierlevel=1 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'shield_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_shield_hardener' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_standard_shield_hardener', quantity=1, attributeflags=540928, categoryflags=131599, options='#moduleFlag=i8#tier=$tierlevel_t1', 
                note='ettol a modultol tud jobban mudkodni a pajzs = kevesebb lesz a core csokkenes 5%kal', enabled=1, volume=0.5, mass=300, hidden='False', health=100, descriptiontoken='def_standard_shield_hardener_desc', purchasable=1, tiertype=1, 
                tierlevel=1 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'shield_absorbtion_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.2 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_mining_upgrade' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_standard_mining_upgrade', quantity=1, attributeflags=524288, categoryflags=263695, options='#moduleFlag=i8#tier=$tierlevel_t1', 
                note='', enabled=1, volume=1, mass=100, hidden='False', health=100, descriptiontoken='def_standard_mining_upgrade_desc', purchasable=1, tiertype=1, 
                tierlevel=1 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'harvesting_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.05 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mining_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.05 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_laser' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_standard_small_laser', quantity=1, attributeflags=303824, categoryflags=16844559, options='#moduleFlag=i51#ammoCapacity=i78#ammoType=L1020a#tier=$tierlevel_t1', 
                note='', enabled=1, volume=0.5, mass=250, hidden='False', health=100, descriptiontoken='def_standard_small_longrange_laser_desc', purchasable=1, tiertype=1, 
                tierlevel=1 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_laser' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_standard_medium_laser', quantity=1, attributeflags=336592, categoryflags=33621775, options='#moduleFlag=i91#ammoCapacity=i78#ammoType=L2020a#tier=$tierlevel_t1', 
                note='', enabled=1, volume=1, mass=500, hidden='False', health=100, descriptiontoken='def_standard_medium_shortrange_laser_desc', purchasable=1, tiertype=1, 
                tierlevel=1 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=11.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_autocannon' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_standard_medium_autocannon', quantity=1, attributeflags=336592, categoryflags=8657176335, options='#moduleFlag=i91#ammoCapacity=i96#ammoType=L2030a#tier=$tierlevel_t1', 
                note='', enabled=1, volume=1.2, mass=500, hidden='False', health=100, descriptiontoken='def_standard_medium_shortrange_autocannon_desc', purchasable=1, tiertype=1, 
                tierlevel=1 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=14.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_armor_repairer_upgrade' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_artifact_a_armor_repairer_upgrade', quantity=1, attributeflags=524292, categoryflags=393487, options='#moduleFlag=i8#tier=$tierlevel_t3a', 
                note='', enabled=1, volume=0.5, mass=240, hidden='False', health=100, descriptiontoken='def_artifact_a_armor_repairer_upgrade_desc', purchasable=1, tiertype=3, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.12 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.936 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_mining_upgrade' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_mining_upgrade', quantity=1, attributeflags=524288, categoryflags=263695, options='#moduleFlag=i8#tier=$tierlevel_t2', 
                note='', enabled=1, volume=0.1, mass=60, hidden='False', health=100, descriptiontoken='def_named_mining_upgrade_desc', purchasable=1, tiertype=1, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'harvesting_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.05 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mining_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.05 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_mining_upgrade' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_mining_upgrade', quantity=1, attributeflags=524288, categoryflags=263695, options='#moduleFlag=i8#tier=$tierlevel_t3', 
                note='', enabled=1, volume=0.1, mass=60, hidden='False', health=100, descriptiontoken='def_named_mining_upgrade_desc', purchasable=1, tiertype=1, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'harvesting_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.075 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mining_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.075 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_mining_upgrade' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_mining_upgrade', quantity=1, attributeflags=524288, categoryflags=263695, options='#moduleFlag=i8#tier=$tierlevel_t4', 
                note='', enabled=1, volume=0.1, mass=60, hidden='False', health=100, descriptiontoken='def_named_mining_upgrade_desc', purchasable=1, tiertype=1, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'harvesting_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mining_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.1 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_damage_mod_railgun' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_standard_damage_mod_railgun', quantity=1, attributeflags=524292, categoryflags=17106703, options='#moduleFlag=i8#tier=$tierlevel_t1', 
                note='', enabled=1, volume=0.5, mass=100, hidden='False', health=100, descriptiontoken='def_damage_mod_railgun_desc', purchasable=1, tiertype=1, 
                tierlevel=1 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_railgun_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.15 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'railgun_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_damage_mod_missile' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_standard_damage_mod_missile', quantity=1, attributeflags=524292, categoryflags=67438351, options='#moduleFlag=i8#tier=$tierlevel_t1', 
                note='', enabled=1, volume=0.5, mass=100, hidden='False', health=100, descriptiontoken='def_damage_mod_missile_desc', purchasable=1, tiertype=1, 
                tierlevel=1 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_missile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.15 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'missile_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_damage_mod_laser' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_standard_damage_mod_laser', quantity=1, attributeflags=524292, categoryflags=50661135, options='#moduleFlag=i8#tier=$tierlevel_t1', 
                note='', enabled=1, volume=0.5, mass=100, hidden='False', health=100, descriptiontoken='def_damage_mod_laser_desc', purchasable=1, tiertype=1, 
                tierlevel=1 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_laser_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.15 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'laser_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_damage_mod_projectile' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_standard_damage_mod_projectile', quantity=1, attributeflags=524292, categoryflags=33883919, options='#moduleFlag=i8#tier=$tierlevel_t1', 
                note='', enabled=1, volume=0.5, mass=100, hidden='False', health=100, descriptiontoken='def_damage_mod_projectile_desc', purchasable=1, tiertype=1, 
                tierlevel=1 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_projectile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.15 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'projectile_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_shield_generator' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_small_shield_generator', quantity=1, attributeflags=49432, categoryflags=16843279, options='#moduleFlag=i20#tier=$tierlevel_t2', 
                note='damage to core = shield_absorbtion * shield_absorbtion_modifier

amig ez a modul fut addig nincs damage, csak a core-bol von le.
', enabled=1, volume=0.3, mass=180, hidden='False', health=100, descriptiontoken='def_named_shield_generator_desc', purchasable=1, tiertype=1, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'shield_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_small_shield_generator' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_small_shield_generator', quantity=1, attributeflags=49432, categoryflags=16843279, options='#moduleFlag=i20#tier=$tierlevel_t3', 
                note='damage to core = shield_absorbtion * shield_absorbtion_modifier

amig ez a modul fut addig nincs damage, csak a core-bol von le.
', enabled=1, volume=0.3, mass=210, hidden='False', health=100, descriptiontoken='def_named_shield_generator_desc', purchasable=1, tiertype=1, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'shield_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_small_shield_generator' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_small_shield_generator', quantity=1, attributeflags=49432, categoryflags=16843279, options='#moduleFlag=i20#tier=$tierlevel_t4', 
                note='damage to core = shield_absorbtion * shield_absorbtion_modifier

amig ez a modul fut addig nincs damage, csak a core-bol von le.
', enabled=1, volume=0.3, mass=230, hidden='False', health=100, descriptiontoken='def_named_shield_generator_desc', purchasable=1, tiertype=1, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'shield_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=6 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_shield_generator' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_medium_shield_generator', quantity=1, attributeflags=82200, categoryflags=33620495, options='#moduleFlag=i20#tier=$tierlevel_t2', 
                note='', enabled=1, volume=0.5, mass=360, hidden='False', health=100, descriptiontoken='def_named_shield_generator_desc', purchasable=1, tiertype=1, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'shield_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_shield_generator' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_medium_shield_generator', quantity=1, attributeflags=82200, categoryflags=33620495, options='#moduleFlag=i20#tier=$tierlevel_t3', 
                note='', enabled=1, volume=0.5, mass=440, hidden='False', health=100, descriptiontoken='def_named_shield_generator_desc', purchasable=1, tiertype=1, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'shield_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_shield_generator' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_medium_shield_generator', quantity=1, attributeflags=82200, categoryflags=33620495, options='#moduleFlag=i20#tier=$tierlevel_t4', 
                note='', enabled=1, volume=0.5, mass=470, hidden='False', health=100, descriptiontoken='def_named_shield_generator_desc', purchasable=1, tiertype=1, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'shield_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=15 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_shield_hardener' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_shield_hardener', quantity=1, attributeflags=540928, categoryflags=131599, options='#moduleFlag=i8#tier=$tierlevel_t2', 
                note='ettol a modultol tud jobban mudkodni a pajzs = kevesebb lesz a core csokkenes ', enabled=1, volume=0.5, mass=270, hidden='False', health=100, descriptiontoken='def_named_shield_hardener_desc', purchasable=1, tiertype=1, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'shield_absorbtion_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.2 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_shield_hardener' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_shield_hardener', quantity=1, attributeflags=540928, categoryflags=131599, options='#moduleFlag=i8#tier=$tierlevel_t3', 
                note='ettol a modultol tud jobban mudkodni a pajzs = kevesebb lesz a core csokkenes', enabled=1, volume=0.5, mass=300, hidden='False', health=100, descriptiontoken='def_named_shield_hardener_desc', purchasable=1, tiertype=1, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'shield_absorbtion_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.25 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_shield_hardener' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_shield_hardener', quantity=1, attributeflags=540928, categoryflags=131599, options='#moduleFlag=i8#tier=$tierlevel_t4', 
                note='ettol a modultol tud jobban mudkodni a pajzs = kevesebb lesz a core csokkenes', enabled=1, volume=0.5, mass=310, hidden='False', health=100, descriptiontoken='def_named_shield_hardener_desc', purchasable=1, tiertype=1, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'shield_absorbtion_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.3 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_kinetic_kers' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_standard_kinetic_kers', quantity=1, attributeflags=524292, categoryflags=17498895, options='#moduleFlag=i20#tier=$tierlevel_t1', 
                note='', enabled=1, volume=1, mass=500, hidden='False', health=100, descriptiontoken='def_standard_kinetic_kers_desc', purchasable=1, tiertype=1, 
                tierlevel=1 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'kinetic_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.45 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'thermal_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.3 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosive_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.3 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_kinetic_kers' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_kinetic_kers', quantity=1, attributeflags=524292, categoryflags=17498895, options='#moduleFlag=i20#tier=$tierlevel_t2', 
                note='', enabled=1, volume=1, mass=450, hidden='False', health=100, descriptiontoken='def_named_kinetic_kers_desc', purchasable=1, tiertype=1, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'kinetic_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.45 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'thermal_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.3 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosive_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.3 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_kinetic_kers' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_kinetic_kers', quantity=1, attributeflags=524292, categoryflags=17498895, options='#moduleFlag=i20#tier=$tierlevel_t3', 
                note='', enabled=1, volume=1, mass=500, hidden='False', health=100, descriptiontoken='def_named_kinetic_kers_desc', purchasable=1, tiertype=1, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'kinetic_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.55 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'thermal_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.35 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosive_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.35 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_kinetic_kers' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_kinetic_kers', quantity=1, attributeflags=524292, categoryflags=17498895, options='#moduleFlag=i20#tier=$tierlevel_t4', 
                note='', enabled=1, volume=1, mass=525, hidden='False', health=100, descriptiontoken='def_named_kinetic_kers_desc', purchasable=1, tiertype=1, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'kinetic_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.6 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'thermal_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.4 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosive_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.4 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_thermal_kers' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_standard_thermal_kers', quantity=1, attributeflags=524292, categoryflags=51053327, options='#moduleFlag=i20#tier=$tierlevel_t1', 
                note='', enabled=1, volume=1, mass=500, hidden='False', health=100, descriptiontoken='def_standard_thermal_kers_desc', purchasable=1, tiertype=1, 
                tierlevel=1 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'kinetic_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.3 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'thermal_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.45 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosive_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.3 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_thermal_kers' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_thermal_kers', quantity=1, attributeflags=524292, categoryflags=51053327, options='#moduleFlag=i20#tier=$tierlevel_t2', 
                note='', enabled=1, volume=1, mass=450, hidden='False', health=100, descriptiontoken='def_named_thermal_kers_desc', purchasable=1, tiertype=1, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'kinetic_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.3 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'thermal_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.45 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosive_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.3 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_thermal_kers' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_thermal_kers', quantity=1, attributeflags=524292, categoryflags=51053327, options='#moduleFlag=i20#tier=$tierlevel_t3', 
                note='', enabled=1, volume=1, mass=500, hidden='False', health=100, descriptiontoken='def_named_thermal_kers_desc', purchasable=1, tiertype=1, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'kinetic_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.35 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'thermal_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.55 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosive_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.35 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_thermal_kers' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_thermal_kers', quantity=1, attributeflags=524292, categoryflags=51053327, options='#moduleFlag=i20#tier=$tierlevel_t4', 
                note='', enabled=1, volume=1, mass=525, hidden='False', health=100, descriptiontoken='def_named_thermal_kers_desc', purchasable=1, tiertype=1, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'kinetic_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.4 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'thermal_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=6 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosive_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.4 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_explosive_kers' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_standard_explosive_kers', quantity=1, attributeflags=524292, categoryflags=34276111, options='#moduleFlag=i20#tier=$tierlevel_t1', 
                note='', enabled=1, volume=1, mass=500, hidden='False', health=100, descriptiontoken='def_standard_explosive_kers_desc', purchasable=1, tiertype=1, 
                tierlevel=1 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'kinetic_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.3 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'thermal_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.3 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosive_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.45 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_explosive_kers' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named1_explosive_kers', quantity=1, attributeflags=524292, categoryflags=34276111, options='#moduleFlag=i20#tier=$tierlevel_t2', 
                note='', enabled=1, volume=1, mass=450, hidden='False', health=100, descriptiontoken='def_named_explosive_kers_desc', purchasable=1, tiertype=1, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'kinetic_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.3 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'thermal_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.3 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosive_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.45 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_explosive_kers' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named2_explosive_kers', quantity=1, attributeflags=524292, categoryflags=34276111, options='#moduleFlag=i20#tier=$tierlevel_t3', 
                note='', enabled=1, volume=1, mass=500, hidden='False', health=100, descriptiontoken='def_named_explosive_kers_desc', purchasable=1, tiertype=1, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'kinetic_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.35 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'thermal_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.35 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosive_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.55 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_explosive_kers' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_named3_explosive_kers', quantity=1, attributeflags=524292, categoryflags=34276111, options='#moduleFlag=i20#tier=$tierlevel_t4', 
                note='', enabled=1, volume=1, mass=525, hidden='False', health=100, descriptiontoken='def_named_explosive_kers_desc', purchasable=1, tiertype=1, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'kinetic_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.4 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'thermal_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.4 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosive_damage_to_core_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.6 WHERE id =  @aggvalueID;



GO