USE [perpetuumsa]
GO


-------------Balance fix prototype inconsistent mass and slots------------

PRINT N'Balance fixes for prototype inconsistencies as of 3/19/2018';

DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
PRINT N'def_yagel_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_yagel_leg_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_yagel_leg_pr', quantity=1, attributeflags=1024, categoryflags=66384, options='#height=f0.35#slotFlags=420,20,20,20', 
                note='', enabled=1, volume=4, mass=1700, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'def_prometheus_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_chassis_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_prometheus_chassis_pr', quantity=1, attributeflags=1024, categoryflags=66128, options='#height=f0.3#slotFlags=4451,6d1,451,6d3', 
                note='', enabled=1, volume=7, mass=5000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'def_prometheus_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_leg_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_prometheus_leg_pr', quantity=1, attributeflags=1024, categoryflags=66384, options='#height=f0.3#slotFlags=420,20,20,20', 
                note='', enabled=1, volume=4, mass=1700, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'def_cameleon_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_chassis_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_cameleon_chassis_pr', quantity=1, attributeflags=1024, categoryflags=66128, options='#height=f0.3#slotFlags=4651,651,4d0', 
                note='', enabled=1, volume=6, mass=4000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'def_cameleon_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_leg_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_cameleon_leg_pr', quantity=1, attributeflags=1024, categoryflags=66384, options='#height=f0.35#slotFlags=420,20,20', 
                note='', enabled=1, volume=3, mass=800, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'def_arbalest_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_arbalest_chassis_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_arbalest_chassis_pr', quantity=1, attributeflags=1024, categoryflags=131664, options='#height=f0.4#slotFlags=451,451,6d1,451,6d1,52', 
                note='', enabled=1, volume=9, mass=9000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'def_arbalest_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_arbalest_leg_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_arbalest_leg_pr', quantity=1, attributeflags=1024, categoryflags=131920, options='#height=f0.6#slotFlags=420,20,20,20,20', 
                note='', enabled=1, volume=4, mass=2700, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'def_baphomet_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_baphomet_chassis_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_baphomet_chassis_pr', quantity=1, attributeflags=1024, categoryflags=131664, options='#height=f0.5#slotFlags=4451,6d1,451,6d1,51', 
                note='', enabled=1, volume=9, mass=9000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

PRINT N'def_castel_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_castel_leg_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_castel_leg_pr', quantity=1, attributeflags=1024, categoryflags=66384, options='#height=f0.5#slotFlags=420,20,20', 
                note='', enabled=1, volume=4, mass=1700, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'def_kain_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_chassis_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_kain_chassis_pr', quantity=1, attributeflags=1024, categoryflags=197200, options='#height=f0.45#slotFlags=46d1,4d1,6d1,4d1,d2,d2', 
                note='', enabled=1, volume=11, mass=21000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'def_artemis_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_chassis_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_artemis_chassis_pr', quantity=1, attributeflags=1024, categoryflags=197200, options='#height=f0.5#slotFlags=46d1,4d1,6d1,4d3,d2', 
                note='', enabled=1, volume=11, mass=21000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'def_tyrannos_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_tyrannos_chassis_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_tyrannos_chassis_pr', quantity=1, attributeflags=1024, categoryflags=197200, options='#height=f0.5#slotFlags=4d2,d2,d2,d2,6d1,6d1', 
                note='', enabled=1, volume=11, mass=21000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'def_vagabond_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vagabond_chassis_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_vagabond_chassis_pr', quantity=1, attributeflags=1024, categoryflags=197200, options='#height=f0.45#slotFlags=44d1,4d1,d1', 
                note='', enabled=1, volume=8, mass=12000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'def_vagabond_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vagabond_leg_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_vagabond_leg_pr', quantity=1, attributeflags=1024, categoryflags=197456, options='#height=f1.25#slotFlags=420,20,20,20', 
                note='', enabled=1, volume=6, mass=2400, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'def_zenith_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_zenith_chassis_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_zenith_chassis_pr', quantity=1, attributeflags=1024, categoryflags=197200, options='#height=f0.5#slotFlags=44d1,4d1,d1', 
                note='bonuszok csak armor transferre', enabled=1, volume=8, mass=12000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

PRINT N'def_mesmer_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_chassis_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_mesmer_chassis_pr', quantity=1, attributeflags=1024, categoryflags=262736, options='#height=f1.1#slotFlags=46d1,d1,4d1,6d1,d1,4d1,4d0', 
                note='', enabled=1, volume=13, mass=25000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

PRINT N'def_mesmer_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_leg_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_mesmer_leg_pr', quantity=1, attributeflags=1024, categoryflags=262992, options='#height=f0.9#slotFlags=420,20,20,20,20,20', 
                note='', enabled=1, volume=7, mass=4000, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'def_gropho_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_gropho_chassis_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_gropho_chassis_pr', quantity=1, attributeflags=1024, categoryflags=262736, options='#height=f0.8#slotFlags=4d2,d2,6d2,6d2,4d2,4d2,4d0', 
                note='', enabled=1, volume=13, mass=22000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'def_kain_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_leg_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_kain_leg_pr', quantity=1, attributeflags=1024, categoryflags=197456, options='#height=f1.25#slotFlags=420,20,20,20,20', 
                note='', enabled=1, volume=6, mass=3300, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'def_intakt_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_chassis_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_intakt_chassis_pr', quantity=1, attributeflags=1024, categoryflags=66128, options='#height=f0.35#slotFlags=4651,651,4d0', 
                note='cloaking core drain bonus', enabled=1, volume=6, mass=4000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;





