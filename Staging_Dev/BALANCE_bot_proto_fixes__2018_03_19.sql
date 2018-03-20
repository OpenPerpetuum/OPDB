USE [perpetuumsa]
GO


-------------Balance fix prototype inconsistent velocities and armors------------

PRINT N'Balance fixes for prototype inconsistencies as of 3/19/2018';

DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
PRINT N'def_yagel_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_yagel_leg_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_yagel_leg_pr', quantity=1, attributeflags=1024, categoryflags=66384, options='#height=f0.35#slotFlags=420,20,20,20', 
                note='', enabled=1, volume=4, mass=1250, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'def_prometheus_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_leg_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_prometheus_leg_pr', quantity=1, attributeflags=1024, categoryflags=66384, options='#height=f0.3#slotFlags=420,20,20,20', 
                note='', enabled=1, volume=4, mass=1875, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'def_cameleon_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_chassis_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_cameleon_chassis_pr', quantity=1, attributeflags=1024, categoryflags=66128, options='#height=f0.3#slotFlags=4651,651,4d0', 
                note='', enabled=1, volume=6, mass=3500, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'def_cameleon_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_leg_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_cameleon_leg_pr', quantity=1, attributeflags=1024, categoryflags=66384, options='#height=f0.35#slotFlags=420,20,20', 
                note='', enabled=1, volume=3, mass=1250, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'def_arbalest_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_arbalest_leg_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_arbalest_leg_pr', quantity=1, attributeflags=1024, categoryflags=131920, options='#height=f0.6#slotFlags=420,20,20,20', 
                note='', enabled=1, volume=4, mass=2125, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'def_castel_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_castel_leg_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_castel_leg_pr', quantity=1, attributeflags=1024, categoryflags=66384, options='#height=f0.5#slotFlags=420,20,20', 
                note='', enabled=1, volume=4, mass=1500, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'def_vagabond_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vagabond_leg_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_vagabond_leg_pr', quantity=1, attributeflags=1024, categoryflags=197456, options='#height=f1.25#slotFlags=420,20,20,20', 
                note='', enabled=1, volume=6, mass=3750, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'def_mesmer_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_leg_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_mesmer_leg_pr', quantity=1, attributeflags=1024, categoryflags=262992, options='#height=f0.9#slotFlags=420,20,20,20,20,20', 
                note='', enabled=1, volume=7, mass=2700, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'def_kain_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_leg_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_kain_leg_pr', quantity=1, attributeflags=1024, categoryflags=197456, options='#height=f1.25#slotFlags=420,20,20,20,20', 
                note='', enabled=1, volume=6, mass=2300, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;




