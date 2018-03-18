USE [perpetuumsa]
GO


-------------Balance fix prototype inconsistent velocities and armors------------

PRINT N'Balance fixes for prototype inconsistencies as of 3/4/2018';

DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
PRINT N'def_yagel_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_yagel_leg_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_yagel_leg_pr', quantity=1, attributeflags=1024, categoryflags=66384, options='#height=f0.35#slotFlags=420,20,20', 
                note='', enabled=1, volume=4, mass=1250, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=3.41 WHERE id =  @aggvalueID;

PRINT N'def_yagel_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_yagel_chassis_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_yagel_chassis_pr', quantity=1, attributeflags=1024, categoryflags=66128, options='#height=f0.45#slotFlags=4451,6d1,451,6d3', 
                note='', enabled=1, volume=7, mass=5000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=680 WHERE id =  @aggvalueID;


PRINT N'def_prometheus_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_chassis_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_prometheus_chassis_pr', quantity=1, attributeflags=1024, categoryflags=66128, options='#height=f0.3#slotFlags=4451,6d1,451,6d3', 
                note='', enabled=1, volume=7, mass=5250, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=760 WHERE id =  @aggvalueID;



PRINT N'def_prometheus_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_leg_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_prometheus_leg_pr', quantity=1, attributeflags=1024, categoryflags=66384, options='#height=f0.3#slotFlags=420,20,20', 
                note='', enabled=1, volume=4, mass=1875, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=3.11 WHERE id =  @aggvalueID;



PRINT N'def_cameleon_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_chassis_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_cameleon_chassis_pr', quantity=1, attributeflags=1024, categoryflags=66128, options='#height=f0.3#slotFlags=4651,651,4d0', 
                note='', enabled=1, volume=6, mass=3500, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=610 WHERE id =  @aggvalueID;


PRINT N'def_cameleon_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_leg_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_cameleon_leg_pr', quantity=1, attributeflags=1024, categoryflags=66384, options='#height=f0.35#slotFlags=420,20', 
                note='', enabled=1, volume=3, mass=1250, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=3.86 WHERE id =  @aggvalueID;


PRINT N'def_arbalest_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_arbalest_chassis_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_arbalest_chassis_pr', quantity=1, attributeflags=1024, categoryflags=131664, options='#height=f0.4#slotFlags=451,451,6d1,451,6d1,52', 
                note='', enabled=1, volume=9, mass=7187.5, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1000 WHERE id =  @aggvalueID;


PRINT N'def_arbalest_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_arbalest_leg_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_arbalest_leg_pr', quantity=1, attributeflags=1024, categoryflags=131920, options='#height=f0.6#slotFlags=420,20,20', 
                note='', enabled=1, volume=4, mass=2125, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=3.35 WHERE id =  @aggvalueID;


PRINT N'def_baphomet_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_baphomet_chassis_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_baphomet_chassis_pr', quantity=1, attributeflags=1024, categoryflags=131664, options='#height=f0.5#slotFlags=4451,6d1,451,6d1,51', 
                note='', enabled=1, volume=9, mass=7312.5, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1140 WHERE id =  @aggvalueID;


PRINT N'def_castel_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_castel_leg_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_castel_leg_pr', quantity=1, attributeflags=1024, categoryflags=66384, options='#height=f0.5#slotFlags=420,20', 
                note='', enabled=1, volume=4, mass=1500, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=3.11 WHERE id =  @aggvalueID;


PRINT N'def_kain_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_chassis_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_kain_chassis_pr', quantity=1, attributeflags=1024, categoryflags=197200, options='#height=f0.45#slotFlags=46d1,4d1,6d1,4d1,d2,d2', 
                note='', enabled=1, volume=11, mass=19000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2520 WHERE id =  @aggvalueID;


PRINT N'def_artemis_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_chassis_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_artemis_chassis_pr', quantity=1, attributeflags=1024, categoryflags=197200, options='#height=f0.5#slotFlags=46d1,4d1,6d1,4d3,d2', 
                note='', enabled=1, volume=11, mass=19500, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2800 WHERE id =  @aggvalueID;


PRINT N'def_tyrannos_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_tyrannos_chassis_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_tyrannos_chassis_pr', quantity=1, attributeflags=1024, categoryflags=197200, options='#height=f0.5#slotFlags=4d2,d2,d2,d2,6d1,6d1', 
                note='', enabled=1, volume=11, mass=20500, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2800 WHERE id =  @aggvalueID;


PRINT N'def_vagabond_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vagabond_chassis_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_vagabond_chassis_pr', quantity=1, attributeflags=1024, categoryflags=197200, options='#height=f0.45#slotFlags=44d1,4d1,d1', 
                note='', enabled=1, volume=8, mass=11000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1170 WHERE id =  @aggvalueID;


PRINT N'def_vagabond_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vagabond_leg_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_vagabond_leg_pr', quantity=1, attributeflags=1024, categoryflags=197456, options='#height=f1.25#slotFlags=420,20,20', 
                note='', enabled=1, volume=6, mass=3750, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2.96 WHERE id =  @aggvalueID;


PRINT N'def_zenith_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_zenith_chassis_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_zenith_chassis_pr', quantity=1, attributeflags=1024, categoryflags=197200, options='#height=f0.5#slotFlags=44d1,4d1,d1', 
                note='bonuszok csak armor transferre', enabled=1, volume=8, mass=10500, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1300 WHERE id =  @aggvalueID;


PRINT N'def_mesmer_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_chassis_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_mesmer_chassis_pr', quantity=1, attributeflags=1024, categoryflags=262736, options='#height=f1.1#slotFlags=46d1,d1,4d1,6d1,d1,4d1,4d0', 
                note='', enabled=1, volume=13, mass=24500, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=3600 WHERE id =  @aggvalueID;


PRINT N'def_mesmer_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_leg_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_mesmer_leg_pr', quantity=1, attributeflags=1024, categoryflags=262992, options='#height=f0.9#slotFlags=420,20,20,20,20', 
                note='', enabled=1, volume=7, mass=2700, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2.13 WHERE id =  @aggvalueID;


PRINT N'def_gropho_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_gropho_chassis_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_gropho_chassis_pr', quantity=1, attributeflags=1024, categoryflags=262736, options='#height=f0.8#slotFlags=4d2,d2,6d2,6d2,4d2,4d2,4d0', 
                note='', enabled=1, volume=13, mass=24500, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4000 WHERE id =  @aggvalueID;


PRINT N'def_kain_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_leg_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_kain_leg_pr', quantity=1, attributeflags=1024, categoryflags=197456, options='#height=f1.25#slotFlags=420,20,20,20', 
                note='', enabled=1, volume=6, mass=2300, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2.87 WHERE id =  @aggvalueID;


PRINT N'def_intakt_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_chassis_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_intakt_chassis_pr', quantity=1, attributeflags=1024, categoryflags=66128, options='#height=f0.35#slotFlags=4651,651,4d0', 
                note='cloaking core drain bonus', enabled=1, volume=6, mass=3500, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=675 WHERE id =  @aggvalueID;



