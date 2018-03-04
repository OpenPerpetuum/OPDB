USE [perpetuumsa]
GO

PRINT N'Bot Balance 2018-02-20';

DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vektor_head' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_vektor_head', quantity=1, attributeflags=1024, categoryflags=65872, options='#height=f0.01#slotFlags=48,8,8,8', 
                note='', enabled=1, volume=1, mass=300, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vektor_chassis' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_vektor_chassis', quantity=1, attributeflags=1024, categoryflags=66128, options='#height=f0.45#slotFlags=4451,6d1,451,6d1', 
                note='', enabled=1, volume=8, mass=5000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4.5 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vektor_leg' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_vektor_leg', quantity=1, attributeflags=1024, categoryflags=66384, options='#height=f0.35#slotFlags=420,20,20', 
                note='', enabled=1, volume=3, mass=1700, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_helix_head' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_helix_head', quantity=1, attributeflags=1024, categoryflags=65872, options='#slotFlags=48,8,8,8', 
                note='', enabled=1, volume=1, mass=200, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_helix_chassis' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_helix_chassis', quantity=1, attributeflags=1024, categoryflags=66128, options='#height=f0.3#slotFlags=4651,651,4d0', 
                note='', enabled=1, volume=6, mass=4000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_helix_leg' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_helix_leg', quantity=1, attributeflags=1024, categoryflags=66384, options='#height=f0.5#slotFlags=420,20,20', 
                note='', enabled=1, volume=5, mass=800, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_locust_head' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_locust_head', quantity=1, attributeflags=1024, categoryflags=131408, options='#height=f0.01#slotFlags=48,8,8,8,8', 
                note='', enabled=1, volume=1, mass=300, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_locust_chassis' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_locust_chassis', quantity=1, attributeflags=1024, categoryflags=131664, options='#height=f0.4#slotFlags=451,51,6d1,51,6d1', 
                note='', enabled=1, volume=8, mass=9000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=5.5 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_locust_leg' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_locust_leg', quantity=1, attributeflags=1024, categoryflags=131920, options='#height=f0.5#slotFlags=420,20,20,20', 
                note='', enabled=1, volume=7, mass=2700, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_echelon_head' ORDER BY definition DESC);
PRINT @definitionID;
UPDATE entitydefaults Set definitionname='def_echelon_head', quantity=1, attributeflags=1024, categoryflags=196944, options='#height=f0.01#slotFlags=48,8,8,8,8', 
                note='', enabled=1, volume=3, mass=700, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_echelon_chassis' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_echelon_chassis', quantity=1, attributeflags=1024, categoryflags=197200, options='#height=f0.5#slotFlags=44d1,d1,4d1,d1', 
                note='', enabled=1, volume=11, mass=21000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=11 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_echelon_leg' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_echelon_leg', quantity=1, attributeflags=1024, categoryflags=197456, options='#height=f1.1#slotFlags=420,20,20,20,20', 
                note='', enabled=1, volume=6, mass=3300, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_callisto_head' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_callisto_head', quantity=1, attributeflags=1024, categoryflags=196944, options='#height=f0.15#slotFlags=48,8,8,8,8', 
                note='', enabled=1, volume=2, mass=600, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_callisto_chassis' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_callisto_chassis', quantity=1, attributeflags=1024, categoryflags=197200, options='#height=f0.45#slotFlags=44d1,4d1,d1', 
                note='', enabled=1, volume=8, mass=12000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=9.5 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_callisto_leg' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_callisto_leg', quantity=1, attributeflags=1024, categoryflags=197456, options='#height=f1#slotFlags=420,20,20,20,20', 
                note='', enabled=1, volume=6, mass=2400, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_legatus_head' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_legatus_head', quantity=1, attributeflags=1024, categoryflags=262480, options='#height=f0.2#slotFlags=48,8,8,8,8', 
                note='', enabled=1, volume=3, mass=1000, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locking_range' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=35 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_legatus_chassis' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_legatus_chassis', quantity=1, attributeflags=1024, categoryflags=262736, options='#height=f1.1#slotFlags=46d1,d1,d1,2d1,d1,4d1', 
                note='', enabled=1, volume=13, mass=25000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=14 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_legatus_leg' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_legatus_leg', quantity=1, attributeflags=1024, categoryflags=262992, options='#height=f1.15#slotFlags=420,20,20,20,20,20', 
                note='', enabled=1, volume=7, mass=4000, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_castel_head' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_castel_head', quantity=1, attributeflags=1024, categoryflags=65872, options='#height=f0.01#slotFlags=48,8,8,8', 
                note='', enabled=1, volume=1, mass=300, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_castel_chassis' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_castel_chassis', quantity=1, attributeflags=1024, categoryflags=66128, options='#height=f0.25#slotFlags=452,d2,52,d3', 
                note='', enabled=1, volume=7, mass=4800, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=5 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_castel_leg' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_castel_leg', quantity=1, attributeflags=1024, categoryflags=66384, options='#height=f0.5#slotFlags=420,20,20', 
                note='', enabled=1, volume=4, mass=1700, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_yagel_head' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_yagel_head', quantity=1, attributeflags=1024, categoryflags=65872, options='#height=f0.01#slotFlags=48,8,8', 
                note='', enabled=1, volume=1, mass=300, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_yagel_chassis' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_yagel_chassis', quantity=1, attributeflags=1024, categoryflags=66128, options='#height=f0.45#slotFlags=4451,6d1,451,6d3', 
                note='', enabled=1, volume=7, mass=5000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=5 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_yagel_leg' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_yagel_leg', quantity=1, attributeflags=1024, categoryflags=66384, options='#height=f0.35#slotFlags=420,20,20,20', 
                note='', enabled=1, volume=4, mass=1700, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_head' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_prometheus_head', quantity=1, attributeflags=1024, categoryflags=65872, options='#height=f0.01#slotFlags=48,8,8', 
                note='', enabled=1, volume=1, mass=300, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_chassis' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_prometheus_chassis', quantity=1, attributeflags=1024, categoryflags=66128, options='#height=f0.3#slotFlags=4451,6d1,451,6d3', 
                note='', enabled=1, volume=7, mass=5000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=5 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_leg' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_prometheus_leg', quantity=1, attributeflags=1024, categoryflags=66384, options='#height=f0.3#slotFlags=420,20,20,20', 
                note='', enabled=1, volume=4, mass=1700, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_troiar_head' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_troiar_head', quantity=1, attributeflags=1024, categoryflags=65872, options='#slotFlags=48,8,8', 
                note='', enabled=1, volume=1, mass=200, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_troiar_chassis' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_troiar_chassis', quantity=1, attributeflags=1024, categoryflags=66128, options='#slotFlags=4650,650,d2,d2,450', 
                note='', enabled=1, volume=6, mass=4300, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4.5 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_troiar_leg' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_troiar_leg', quantity=1, attributeflags=1024, categoryflags=66384, options='#height=f0.3#slotFlags=420,20,20', 
                note='', enabled=1, volume=3, mass=800, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_head' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_cameleon_head', quantity=1, attributeflags=1024, categoryflags=65872, options='#height=f0.01#slotFlags=48,8,8,8,8', 
                note='', enabled=1, volume=1, mass=200, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_chassis' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_cameleon_chassis', quantity=1, attributeflags=1024, categoryflags=66128, options='#height=f0.3#slotFlags=4651,651,4d0', 
                note='', enabled=1, volume=6, mass=4000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4.5 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_leg' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_cameleon_leg', quantity=1, attributeflags=1024, categoryflags=66384, options='#height=f0.35#slotFlags=420,20,20', 
                note='', enabled=1, volume=3, mass=800, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_head' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_intakt_head', quantity=1, attributeflags=1024, categoryflags=65872, options='#height=f0.01#slotFlags=48,8,8,8,8', 
                note='scanning speed 10%', enabled=1, volume=1, mass=200, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_chassis' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_intakt_chassis', quantity=1, attributeflags=1024, categoryflags=66128, options='#height=f0.35#slotFlags=4651,651,4d0', 
                note='cloaking core drain bonus', enabled=1, volume=6, mass=4000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4.5 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_leg' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_intakt_leg', quantity=1, attributeflags=1024, categoryflags=66384, options='#height=f0.3#slotFlags=420,20,20', 
                note='', enabled=1, volume=4, mass=800, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_waspish_head' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_waspish_head', quantity=1, attributeflags=1024, categoryflags=131408, options='#height=f0.01#slotFlags=48,8,8,8,8', 
                note='', enabled=1, volume=1, mass=300, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_waspish_chassis' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_waspish_chassis', quantity=1, attributeflags=1024, categoryflags=131664, options='#height=f0.3#slotFlags=452,d2,52,52,d2,651', 
                note='', enabled=1, volume=9, mass=8000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=6 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_waspish_leg' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_waspish_leg', quantity=1, attributeflags=1024, categoryflags=131920, options='#height=f0.5#slotFlags=420,20,20,20', 
                note='', enabled=1, volume=8, mass=2700, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_arbalest_head' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_arbalest_head', quantity=1, attributeflags=1024, categoryflags=131408, options='#height=f0.05#slotFlags=48,8,8,8', 
                note='', enabled=1, volume=1, mass=300, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_arbalest_chassis' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_arbalest_chassis', quantity=1, attributeflags=1024, categoryflags=131664, options='#height=f0.4#slotFlags=451,451,6d1,451,6d1,52', 
                note='', enabled=1, volume=9, mass=9000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=6 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_arbalest_leg' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_arbalest_leg', quantity=1, attributeflags=1024, categoryflags=131920, options='#height=f0.6#slotFlags=420,20,20,20,20', 
                note='', enabled=1, volume=4, mass=2700, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_baphomet_head' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_baphomet_head', quantity=1, attributeflags=1024, categoryflags=131408, options='#height=f0.01#slotFlags=48,8,8,8,8', 
                note='', enabled=1, volume=1, mass=300, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_baphomet_chassis' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_baphomet_chassis', quantity=1, attributeflags=1024, categoryflags=131664, options='#height=f0.5#slotFlags=4451,6d1,451,6d1,51', 
                note='', enabled=1, volume=9, mass=9000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=6 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_baphomet_leg' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_baphomet_leg', quantity=1, attributeflags=1024, categoryflags=131920, options='#height=f0.5#slotFlags=420,20,20,20,20', 
                note='', enabled=1, volume=5, mass=2700, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_tyrannos_head' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_tyrannos_head', quantity=1, attributeflags=1024, categoryflags=196944, options='#height=f0.15#slotFlags=48,8,8,8,8', 
                note='', enabled=1, volume=2, mass=700, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_tyrannos_chassis' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_tyrannos_chassis', quantity=1, attributeflags=1024, categoryflags=197200, options='#height=f0.5#slotFlags=4d2,d2,d2,d2,6d1,6d1', 
                note='', enabled=1, volume=11, mass=19000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_tyrannos_leg' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_tyrannos_leg', quantity=1, attributeflags=1024, categoryflags=197456, options='#height=f1.1#slotFlags=420,20,20,20', 
                note='', enabled=1, volume=6, mass=3300, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_head' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_kain_head', quantity=1, attributeflags=1024, categoryflags=196944, options='#height=f0.15#slotFlags=48,8,8,8', 
                note='', enabled=1, volume=2, mass=700, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_chassis' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_kain_chassis', quantity=1, attributeflags=1024, categoryflags=197200, options='#height=f0.45#slotFlags=46d1,4d1,6d1,4d1,d2,d2', 
                note='', enabled=1, volume=11, mass=21000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_leg' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_kain_leg', quantity=1, attributeflags=1024, categoryflags=197456, options='#height=f1.25#slotFlags=420,20,20,20,20', 
                note='', enabled=1, volume=6, mass=3300, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2.87 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_head' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_artemis_head', quantity=1, attributeflags=1024, categoryflags=196944, options='#height=f0.15#slotFlags=48,8,8,8,8', 
                note='', enabled=1, volume=2, mass=700, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_chassis' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_artemis_chassis', quantity=1, attributeflags=1024, categoryflags=197200, options='#height=f0.5#slotFlags=46d1,4d1,6d1,4d3,d2', 
                note='', enabled=1, volume=11, mass=21000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_leg' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_artemis_leg', quantity=1, attributeflags=1024, categoryflags=197456, options='#height=f1#slotFlags=420,20,20,20,20', 
                note='', enabled=1, volume=6, mass=3300, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ictus_head' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_ictus_head', quantity=1, attributeflags=1024, categoryflags=196944, options='#height=f0.15#slotFlags=48,8,8,8', 
                note='', enabled=1, volume=2, mass=600, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ictus_chassis' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_ictus_chassis', quantity=1, attributeflags=1024, categoryflags=197200, options='#height=f0.5#slotFlags=44d0,4d0,d2,d2,492', 
                note='', enabled=1, volume=8, mass=13000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=10 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ictus_leg' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_ictus_leg', quantity=1, attributeflags=1024, categoryflags=197456, options='#height=f1#slotFlags=420,20,20,20', 
                note='', enabled=1, volume=6, mass=2400, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vagabond_head' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_vagabond_head', quantity=1, attributeflags=1024, categoryflags=196944, options='#height=f0.15#slotFlags=48,8,8,8,8,8', 
                note='', enabled=1, volume=2, mass=600, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vagabond_chassis' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_vagabond_chassis', quantity=1, attributeflags=1024, categoryflags=197200, options='#height=f0.45#slotFlags=44d1,4d1,d1', 
                note='', enabled=1, volume=8, mass=12000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=10 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vagabond_leg' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_vagabond_leg', quantity=1, attributeflags=1024, categoryflags=197456, options='#height=f1.25#slotFlags=420,20,20,20', 
                note='', enabled=1, volume=6, mass=2400, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_zenith_head' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_zenith_head', quantity=1, attributeflags=1024, categoryflags=196944, options='#height=f0.15#slotFlags=48,8,8,8,8,8', 
                note='bonuszok remote sensor boosterre ', enabled=1, volume=2, mass=600, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_zenith_chassis' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_zenith_chassis', quantity=1, attributeflags=1024, categoryflags=197200, options='#height=f0.5#slotFlags=44d1,4d1,d1', 
                note='bonuszok csak armor transferre', enabled=1, volume=8, mass=12000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=10 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_zenith_leg' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_zenith_leg', quantity=1, attributeflags=1024, categoryflags=197456, options='#height=f1#slotFlags=420,20,20,20', 
                note='', enabled=1, volume=6, mass=2400, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_gropho_head' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_gropho_head', quantity=1, attributeflags=1024, categoryflags=262480, options='#height=f0.2#slotFlags=48,8,8,8,8,8', 
                note='', enabled=1, volume=2.5, mass=1000, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_gropho_chassis' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_gropho_chassis', quantity=1, attributeflags=1024, categoryflags=262736, options='#height=f0.8#slotFlags=4d2,d2,2d2,2d2,4d2,4d2,4d0', 
                note='', enabled=1, volume=13, mass=22000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=15 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_gropho_leg' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_gropho_leg', quantity=1, attributeflags=1024, categoryflags=262992, options='#height=f1.15#slotFlags=420,20,20,20,20', 
                note='', enabled=1, volume=7, mass=4000, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_head' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_mesmer_head', quantity=1, attributeflags=1024, categoryflags=262480, options='#height=f0.15#slotFlags=48,8,8,8,8', 
                note='', enabled=1, volume=2.5, mass=1000, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_chassis' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_mesmer_chassis', quantity=1, attributeflags=1024, categoryflags=262736, options='#height=f1.1#slotFlags=46d1,d1,d1,2d1,d1,4d1,4d0', 
                note='', enabled=1, volume=13, mass=25000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=15 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_leg' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_mesmer_leg', quantity=1, attributeflags=1024, categoryflags=262992, options='#height=f0.9#slotFlags=420,20,20,20,20,20', 
                note='', enabled=1, volume=7, mass=4000, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_seth_head' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_seth_head', quantity=1, attributeflags=1024, categoryflags=262480, options='#height=f0.01#slotFlags=48,8,8,8,8,8', 
                note='', enabled=1, volume=2.5, mass=1000, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_seth_chassis' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_seth_chassis', quantity=1, attributeflags=1024, categoryflags=262736, options='#height=f0.75#slotFlags=46d1,d1,d1,2d1,d1,4d1', 
                note='', enabled=1, volume=13, mass=25000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=15 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_seth_leg' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_seth_leg', quantity=1, attributeflags=1024, categoryflags=262992, options='#height=f0.95#slotFlags=420,20,20,20,20,20', 
                note='', enabled=1, volume=7, mass=4000, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_yagel_head_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_yagel_head_pr', quantity=1, attributeflags=1024, categoryflags=65872, options='#height=f0.01#slotFlags=48,8,8', 
                note='', enabled=1, volume=1, mass=300, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_yagel_chassis_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_yagel_chassis_pr', quantity=1, attributeflags=1024, categoryflags=66128, options='#height=f0.45#slotFlags=4451,6d1,451,6d3', 
                note='', enabled=1, volume=7, mass=5000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=5 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_yagel_leg_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_yagel_leg_pr', quantity=1, attributeflags=1024, categoryflags=66384, options='#height=f0.35#slotFlags=420,20,20,20', 
                note='', enabled=1, volume=4, mass=1700, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_head_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_prometheus_head_pr', quantity=1, attributeflags=1024, categoryflags=65872, options='#height=f0.01#slotFlags=48,8,8', 
                note='', enabled=1, volume=1, mass=300, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_chassis_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_prometheus_chassis_pr', quantity=1, attributeflags=1024, categoryflags=66128, options='#height=f0.3#slotFlags=4451,6d1,451,6d3', 
                note='', enabled=1, volume=7, mass=5000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=5 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_leg_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_prometheus_leg_pr', quantity=1, attributeflags=1024, categoryflags=66384, options='#height=f0.3#slotFlags=420,20,20,20', 
                note='', enabled=1, volume=4, mass=1700, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_waspish_head_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_waspish_head_pr', quantity=1, attributeflags=1024, categoryflags=131408, options='#height=f0.01#slotFlags=48,8,8,8,8', 
                note='', enabled=1, volume=1, mass=300, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_waspish_chassis_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_waspish_chassis_pr', quantity=1, attributeflags=1024, categoryflags=131664, options='#height=f0.3#slotFlags=452,d2,52,52,d2,651', 
                note='', enabled=1, volume=9, mass=8000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=6 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_waspish_leg_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_waspish_leg_pr', quantity=1, attributeflags=1024, categoryflags=131920, options='#height=f0.5#slotFlags=420,20,20,20', 
                note='', enabled=1, volume=8, mass=2700, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_head_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_cameleon_head_pr', quantity=1, attributeflags=1024, categoryflags=65872, options='#height=f0.01#slotFlags=48,8,8,8,8', 
                note='', enabled=1, volume=1, mass=200, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_chassis_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_cameleon_chassis_pr', quantity=1, attributeflags=1024, categoryflags=66128, options='#height=f0.3#slotFlags=4651,651,4d0', 
                note='', enabled=1, volume=6, mass=4000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4.5 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_leg_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_cameleon_leg_pr', quantity=1, attributeflags=1024, categoryflags=66384, options='#height=f0.35#slotFlags=420,20,20', 
                note='', enabled=1, volume=3, mass=800, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_head_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_intakt_head_pr', quantity=1, attributeflags=1024, categoryflags=65872, options='#height=f0.01#slotFlags=48,8,8,8,8', 
                note='scanning speed 10%', enabled=1, volume=1, mass=200, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_chassis_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_intakt_chassis_pr', quantity=1, attributeflags=1024, categoryflags=66128, options='#height=f0.35#slotFlags=4651,651,4d0', 
                note='cloaking core drain bonus', enabled=1, volume=6, mass=4000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4.5 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_leg_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_intakt_leg_pr', quantity=1, attributeflags=1024, categoryflags=66384, options='#height=f0.3#slotFlags=420,20,20', 
                note='', enabled=1, volume=4, mass=800, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_arbalest_head_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_arbalest_head_pr', quantity=1, attributeflags=1024, categoryflags=131408, options='#height=f0.05#slotFlags=48,8,8,8', 
                note='', enabled=1, volume=1, mass=300, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_arbalest_chassis_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_arbalest_chassis_pr', quantity=1, attributeflags=1024, categoryflags=131664, options='#height=f0.4#slotFlags=451,451,6d1,451,6d1,52', 
                note='', enabled=1, volume=9, mass=9000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=6 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_arbalest_leg_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_arbalest_leg_pr', quantity=1, attributeflags=1024, categoryflags=131920, options='#height=f0.6#slotFlags=420,20,20,20,20', 
                note='', enabled=1, volume=4, mass=2700, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_baphomet_head_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_baphomet_head_pr', quantity=1, attributeflags=1024, categoryflags=131408, options='#height=f0.01#slotFlags=48,8,8,8,8', 
                note='', enabled=1, volume=1, mass=300, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_baphomet_chassis_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_baphomet_chassis_pr', quantity=1, attributeflags=1024, categoryflags=131664, options='#height=f0.5#slotFlags=4451,6d1,451,6d1,51', 
                note='', enabled=1, volume=9, mass=9000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=6 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_baphomet_leg_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_baphomet_leg_pr', quantity=1, attributeflags=1024, categoryflags=131920, options='#height=f0.5#slotFlags=420,20,20,20,20', 
                note='', enabled=1, volume=5, mass=2700, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_castel_head_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_castel_head_pr', quantity=1, attributeflags=1024, categoryflags=65872, options='#height=f0.01#slotFlags=48,8,8,8', 
                note='', enabled=1, volume=1, mass=300, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_castel_chassis_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_castel_chassis_pr', quantity=1, attributeflags=1024, categoryflags=66128, options='#height=f0.25#slotFlags=452,d2,52,d3', 
                note='', enabled=1, volume=7, mass=4800, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=5 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_castel_leg_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_castel_leg_pr', quantity=1, attributeflags=1024, categoryflags=66384, options='#height=f0.5#slotFlags=420,20,20', 
                note='', enabled=1, volume=4, mass=1700, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_head_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_kain_head_pr', quantity=1, attributeflags=1024, categoryflags=196944, options='#height=f0.15#slotFlags=48,8,8,8', 
                note='', enabled=1, volume=2, mass=700, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_chassis_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_kain_chassis_pr', quantity=1, attributeflags=1024, categoryflags=197200, options='#height=f0.45#slotFlags=46d1,4d1,6d1,4d1,d2,d2', 
                note='', enabled=1, volume=11, mass=21000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_leg_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_kain_leg_pr', quantity=1, attributeflags=1024, categoryflags=197456, options='#height=f1.25#slotFlags=420,20,20,20,20', 
                note='', enabled=1, volume=6, mass=3300, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_head_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_artemis_head_pr', quantity=1, attributeflags=1024, categoryflags=196944, options='#height=f0.15#slotFlags=48,8,8,8,8', 
                note='', enabled=1, volume=2, mass=700, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_chassis_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_artemis_chassis_pr', quantity=1, attributeflags=1024, categoryflags=197200, options='#height=f0.5#slotFlags=46d1,4d1,6d1,4d3,d2', 
                note='', enabled=1, volume=11, mass=21000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_leg_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_artemis_leg_pr', quantity=1, attributeflags=1024, categoryflags=197456, options='#height=f1#slotFlags=420,20,20,20,20', 
                note='', enabled=1, volume=6, mass=3300, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_tyrannos_head_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_tyrannos_head_pr', quantity=1, attributeflags=1024, categoryflags=196944, options='#height=f0.15#slotFlags=48,8,8,8,8', 
                note='', enabled=1, volume=2, mass=700, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_tyrannos_chassis_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_tyrannos_chassis_pr', quantity=1, attributeflags=1024, categoryflags=197200, options='#height=f0.5#slotFlags=4d2,d2,d2,d2,6d1,6d1', 
                note='', enabled=1, volume=11, mass=19000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_tyrannos_leg_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_tyrannos_leg_pr', quantity=1, attributeflags=1024, categoryflags=197456, options='#height=f1.1#slotFlags=420,20,20,20', 
                note='', enabled=1, volume=6, mass=3300, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vagabond_head_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_vagabond_head_pr', quantity=1, attributeflags=1024, categoryflags=196944, options='#height=f0.15#slotFlags=48,8,8,8,8,8', 
                note='', enabled=1, volume=2, mass=600, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vagabond_chassis_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_vagabond_chassis_pr', quantity=1, attributeflags=1024, categoryflags=197200, options='#height=f0.45#slotFlags=44d1,4d1,d1', 
                note='', enabled=1, volume=8, mass=12000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=10 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vagabond_leg_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_vagabond_leg_pr', quantity=1, attributeflags=1024, categoryflags=197456, options='#height=f1.25#slotFlags=420,20,20,20', 
                note='', enabled=1, volume=6, mass=2400, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_zenith_head_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_zenith_head_pr', quantity=1, attributeflags=1024, categoryflags=196944, options='#height=f0.15#slotFlags=48,8,8,8,8,8', 
                note='bonuszok remote sensor boosterre ', enabled=1, volume=2, mass=600, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_zenith_chassis_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_zenith_chassis_pr', quantity=1, attributeflags=1024, categoryflags=197200, options='#height=f0.5#slotFlags=44d1,4d1,d1', 
                note='bonuszok csak armor transferre', enabled=1, volume=8, mass=12000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=10 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_zenith_leg_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_zenith_leg_pr', quantity=1, attributeflags=1024, categoryflags=197456, options='#height=f1#slotFlags=420,20,20,20', 
                note='', enabled=1, volume=6, mass=2400, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_head_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_mesmer_head_pr', quantity=1, attributeflags=1024, categoryflags=262480, options='#height=f0.15#slotFlags=48,8,8,8,8', 
                note='', enabled=1, volume=2.5, mass=1000, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_chassis_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_mesmer_chassis_pr', quantity=1, attributeflags=1024, categoryflags=262736, options='#height=f1.1#slotFlags=46d1,d1,4d1,6d1,d1,4d1,4d0', 
                note='', enabled=1, volume=13, mass=25000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=15 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_leg_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_mesmer_leg_pr', quantity=1, attributeflags=1024, categoryflags=262992, options='#height=f0.9#slotFlags=420,20,20,20,20,20', 
                note='', enabled=1, volume=7, mass=4000, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_seth_head_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_seth_head_pr', quantity=1, attributeflags=1024, categoryflags=262480, options='#height=f0.01#slotFlags=48,8,8,8,8,8', 
                note='', enabled=1, volume=2.5, mass=1000, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_seth_chassis_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_seth_chassis_pr', quantity=1, attributeflags=1024, categoryflags=262736, options='#height=f0.75#slotFlags=46d1,d1,4d1,6d1,d1,4d1', 
                note='', enabled=1, volume=13, mass=25000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=15 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_seth_leg_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_seth_leg_pr', quantity=1, attributeflags=1024, categoryflags=262992, options='#height=f0.95#slotFlags=420,20,20,20,20,20', 
                note='', enabled=1, volume=7, mass=4000, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_gropho_head_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_gropho_head_pr', quantity=1, attributeflags=1024, categoryflags=262480, options='#height=f0.2#slotFlags=48,8,8,8,8,8', 
                note='', enabled=1, volume=2.5, mass=1000, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_gropho_chassis_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_gropho_chassis_pr', quantity=1, attributeflags=1024, categoryflags=262736, options='#height=f0.8#slotFlags=4d2,d2,6d2,6d2,4d2,4d2,4d0', 
                note='', enabled=1, volume=13, mass=22000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=15 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_gropho_leg_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_gropho_leg_pr', quantity=1, attributeflags=1024, categoryflags=262992, options='#height=f1.15#slotFlags=420,20,20,20,20', 
                note='', enabled=1, volume=7, mass=4000, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_troiar_head_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_troiar_head_pr', quantity=1, attributeflags=1024, categoryflags=65872, options='#slotFlags=48,8,8', 
                note='', enabled=1, volume=1, mass=200, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_troiar_chassis_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_troiar_chassis_pr', quantity=1, attributeflags=1024, categoryflags=66128, options='#slotFlags=4650,650,d2,d2,450', 
                note='', enabled=1, volume=6, mass=4300, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4.5 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_troiar_leg_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_troiar_leg_pr', quantity=1, attributeflags=1024, categoryflags=66384, options='#height=f0.3#slotFlags=420,20,20', 
                note='', enabled=1, volume=3, mass=800, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ictus_head_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_ictus_head_pr', quantity=1, attributeflags=1024, categoryflags=196944, options='#height=f0.15#slotFlags=48,8,8,8', 
                note='', enabled=1, volume=2, mass=600, hidden='True', health=100, descriptiontoken='bot_head_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ictus_chassis_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_ictus_chassis_pr', quantity=1, attributeflags=1024, categoryflags=197200, options='#height=f0.5#slotFlags=44d0,4d0,d2,d2,492', 
                note='', enabled=1, volume=8, mass=13000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=10 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ictus_leg_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_ictus_leg_pr', quantity=1, attributeflags=1024, categoryflags=197456, options='#height=f1#slotFlags=420,20,20,20', 
                note='', enabled=1, volume=6, mass=2400, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'Bot bonuses';


DECLARE @extensionID int;
DECLARE @chassisbonusID int;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_echelon_chassis' ORDER BY definition DESC);
PRINT @definitionID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_medium_projectile_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.03 WHERE id = @chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_echelon_chassis' ORDER BY definition DESC);
PRINT @definitionID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'falloff_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.03 WHERE id = @chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_echelon_chassis' ORDER BY definition DESC);
PRINT @definitionID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'projectile_optimal_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;



SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_syndicate_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_locust_leg' ORDER BY definition DESC);
PRINT @definitionID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'armor_max_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.01 WHERE id = @chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_syndicate_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_locust_leg' ORDER BY definition DESC);
PRINT @definitionID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'signature_radius' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.05 WHERE id = @chassisbonusID;



PRINT N'Metis bonuses';

PRINT N'Metis leg bonuses';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_syndicate_industry_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_metis_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'shield_absorbtion_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.03, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_metis_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'shield_absorbtion_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

PRINT N'Metis head bonuses';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_indy_role_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_metis_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'reactor_radiation_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.05, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_metis_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'mining_cycle_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

PRINT N'Metis chassis bonuses';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_metis_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.05, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_metis_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'energy_transfer_amount_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 0.03, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_metis_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_armor_repair_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, -0.02, '', @aggfieldID, 0);
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_metis_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'harvesting_amount_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_industry_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_metis_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'cpu_usage_gathering_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_indy_role_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_metis_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_max_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;


PRINT N'Indy bot size adjustments in line with recent changes';

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_noob_bot_chassis' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_noob_bot_chassis', quantity=1, attributeflags=1024, categoryflags=66128, options='#height=f0.3#slotFlags=4651,653#tier=$tierlevel_s', 
                note='', enabled=1, volume=7, mass=3000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=3, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4.75 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_sequer_chassis' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_sequer_chassis', quantity=1, attributeflags=1024, categoryflags=131664, options='#height=f0.9#slotFlags=4653', 
                note='', enabled=1, volume=12, mass=8000, hidden='True', health=100, descriptiontoken='def_sequer_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ikarus_chassis' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_ikarus_chassis', quantity=1, attributeflags=1024, categoryflags=66128, options='#height=f0.3#slotFlags=46d3', 
                note='', enabled=1, volume=8, mass=6650, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_metis_chassis' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_metis_chassis', quantity=1, attributeflags=1024, categoryflags=262736, options='#height=f1#slotFlags=42d0,2d0,6d0,6d0,6d0,4d3', 
                note='', enabled=1, volume=20, mass=35000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=14 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_daidalos_chassis' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_daidalos_chassis', quantity=1, attributeflags=1024, categoryflags=197200, options='#height=f0.75#slotFlags=42d0,2d0,d1,d1', 
                note='', enabled=1, volume=13, mass=43000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=11 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_hermes_chassis' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_hermes_chassis', quantity=1, attributeflags=1024, categoryflags=131664, options='#height=f0.5#slotFlags=4451,6d1,451,6d1', 
                note='', enabled=1, volume=9, mass=4000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=5 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_lithus_chassis_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_lithus_chassis_pr', quantity=1, attributeflags=1024, categoryflags=262736, options='#height=f2#slotFlags=4d3,6d0', 
                note='', enabled=1, volume=100, mass=65000, hidden='True', health=100, descriptiontoken='def_lithus_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=14 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_sequer_chassis_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_sequer_chassis_pr', quantity=1, attributeflags=1024, categoryflags=131664, options='#height=f0.9#slotFlags=4653', 
                note='', enabled=1, volume=12, mass=8000, hidden='True', health=100, descriptiontoken='def_sequer_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=5 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_symbiont_chassis_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_symbiont_chassis_pr', quantity=1, attributeflags=1024, categoryflags=262736, options='#height=f1#slotFlags=42d0,2d0,6d0,6d0,6d0,4d3', 
                note='', enabled=1, volume=20, mass=35000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=14 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_riveler_chassis_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_riveler_chassis_pr', quantity=1, attributeflags=1024, categoryflags=262736, options='#height=f1#slotFlags=42d0,6d0,2d0,6d0,6d0,4d3', 
                note='', enabled=1, volume=20, mass=35000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=14 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_gargoyle_chassis_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_gargoyle_chassis_pr', quantity=1, attributeflags=1024, categoryflags=197200, options='#height=f1.3#slotFlags=42d0,2d0,6d0,6d0,4d3', 
                note='', enabled=1, volume=16, mass=13500, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=11 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_termis_chassis_pr' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_termis_chassis_pr', quantity=1, attributeflags=1024, categoryflags=197200, options='#height=f1.3#slotFlags=42d0,2d0,6d0,6d0,4d3', 
                note='', enabled=1, volume=16, mass=13500, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=11 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_symbiont_chassis' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_symbiont_chassis', quantity=1, attributeflags=1024, categoryflags=262736, options='#height=f1#slotFlags=42d0,2d0,6d0,6d0,6d0,4d3', 
                note='', enabled=1, volume=20, mass=35000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=14 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_riveler_chassis' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_riveler_chassis', quantity=1, attributeflags=1024, categoryflags=262736, options='#height=f1#slotFlags=42d0,6d0,2d0,6d0,6d0,4d3', 
                note='', enabled=1, volume=20, mass=35000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=14 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_gargoyle_chassis' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_gargoyle_chassis', quantity=1, attributeflags=1024, categoryflags=197200, options='#height=f1.3#slotFlags=42d0,2d0,6d0,6d0,4d3', 
                note='', enabled=1, volume=16, mass=13500, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=11 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_termis_chassis' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_termis_chassis', quantity=1, attributeflags=1024, categoryflags=197200, options='#height=f1.3#slotFlags=42d0,2d0,6d0,6d0,4d3', 
                note='', enabled=1, volume=16, mass=13500, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=11 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_lithus_chassis' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_lithus_chassis', quantity=1, attributeflags=1024, categoryflags=262736, options='#height=f2#slotFlags=4d3,6d0', 
                note='', enabled=1, volume=100, mass=65000, hidden='True', health=100, descriptiontoken='def_lithus_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=14 WHERE id =  @aggvalueID;


GO

