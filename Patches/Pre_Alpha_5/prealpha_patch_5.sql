USE [perpetuumsa]
GO
/*
BEGIN TRANSACTION

ROLLBACK TRANSACTION

COMMIT TRANSACTION

*/

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

GO

USE [perpetuumsa]
GO


-----------Diable Special Missions-------------------
PRINT N'Turn off special missions -- sends to inactive islands';
UPDATE missions
SET listable=0
WHERE missiontype=(SELECT id from missiontypes where name like 'missiontype_storyline');
GO

USE [perpetuumsa]
GO

---------Updates for Omega stronghold npc templates ---------------

DECLARE @templateID int;
PRINT N'Cameleon NPC miniboss3 template';
SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'Cameleon NPC miniboss3' ORDER BY id DESC);
UPDATE robottemplates SET name='Cameleon NPC miniboss3', description='#robot=iba1#head=ib98#chassis=ib99#leg=ib9a#container=i146#headModules=[|m0=[|definition=i33|slot=i4]|m1=[|definition=i32|slot=i4]|m2=[|definition=i32|slot=i4]|m3=[|definition=i391|slot=i4]|m4=[|definition=i31|slot=i4]]#chassisModules=[|m0=[|definition=i42|slot=i1|ammoDefinition=i980|ammoQuantity=i19]|m1=[|definition=i42|slot=i2|ammoDefinition=i980|ammoQuantity=i19]|m2=[|definition=i23|slot=i3|ammoDefinition=i980|ammoQuantity=ia]]#legModules=[|m0=[|definition=i12a|slot=i1]|m1=[|definition=ie|slot=i2]|m2=[|definition=i18|slot=i3]]', note='' WHERE id=@templateID;

PRINT N'Baphomet NPC miniboss3 template';
SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'Baphomet NPC miniboss3' ORDER BY id DESC);
UPDATE robottemplates SET name='Baphomet NPC miniboss3', description='#robot=ibae#head=iba7#chassis=iba8#leg=iba9#container=i148#headModules=[|m0=[|definition=i31|slot=i6]|m1=[|definition=i2b|slot=i6]|m2=[|definition=i38f|slot=i6]|m3=[|definition=i38f|slot=i6]]#chassisModules=[|m0=[|definition=i39|slot=i1|ammoDefinition=i10f|ammoQuantity=i19]|m1=[|definition=i39|slot=i2|ammoDefinition=i10f|ammoQuantity=i19]|m2=[|definition=i39|slot=i3|ammoDefinition=i10f|ammoQuantity=i19]|m3=[|definition=i39|slot=i4|ammoDefinition=i10f|ammoQuantity=i19]|m4=[|definition=i39|slot=i5|ammoDefinition=i10f|ammoQuantity=i19]]#legModules=[|m0=[|definition=ie|slot=i1]|m1=[|definition=i12|slot=i2]|m2=[|definition=i1b|slot=i3]|m3=[|definition=i12a|slot=i4]]', note='' WHERE id=@templateID;

PRINT N'Arbalest NPC miniboss3 template';
SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'Arbalest NPC miniboss3' ORDER BY id DESC);
UPDATE robottemplates SET name='Arbalest NPC miniboss3', description='#robot=ibad#head=iba4#chassis=iba5#leg=iba6#container=i148#headModules=[|m0=[|definition=i31|slot=i7]|m1=[|definition=i32|slot=i7]|m2=[|definition=i33|slot=i7]]#chassisModules=[|m0=[|definition=i42|slot=i1|ammoDefinition=if8|ammoQuantity=i19]|m1=[|definition=i42|slot=i2|ammoDefinition=if8|ammoQuantity=i19]|m2=[|definition=i42|slot=i3|ammoDefinition=if8|ammoQuantity=i19]|m3=[|definition=i42|slot=i4|ammoDefinition=if8|ammoQuantity=i19]|m4=[|definition=i42|slot=i5|ammoDefinition=if8|ammoQuantity=i19]]#legModules=[|m0=[|definition=ie|slot=i1]|m1=[|definition=i12|slot=i2]|m2=[|definition=i18|slot=i3]|m3=[|definition=i12a|slot=i4]]', note='' WHERE id=@templateID;

GO

USE [perpetuumsa]
GO


---Shows all facilities---Vanilla-state---
SELECT * from entitydefaults
where categoryflags in (SELECT value from categoryFlags
where name='cf_refinery_facility' or name='cf_repair_facility'
or name='cf_reprocessor_facility' or name='cf_mill'
or name='cf_prototyper' or name='cf_research_lab');



---Update 'super' facility to 75pts------
PRINT N'public docking facility-super 100->75pt';
UPDATE entitydefaults
SET options=REPLACE(options, '#points=n100', '#points=n75')
WHERE categoryflags in (SELECT value FROM categoryFlags
WHERE name='cf_refinery_facility' or name='cf_repair_facility'
or name='cf_reprocessor_facility' or name='cf_mill'
or name='cf_prototyper' or name='cf_research_lab');
GO

---Add new entity property to boost beta 2 facilities---
Update entities
SET dynprop = '#extrapoints=n1'
WHERE entities.definition in
(SELECT definition from entitydefaults
where categoryflags in (SELECT value from categoryFlags
where name='cf_outpost_refinery' or name='cf_outpost_repair'
or name='cf_outpost_reprocessor' or name='cf_outpost_mill'
or name='cf_outpost_prototyper' or name='cf_outpost_research_lab')
and entities.parent in (SELECT eid FROM zoneentities
WHERE zoneID>8 and zoneID<12 and note like 'outpost%'));
--Note: requires server-side patch on facilities to read property

DECLARE @terminalID int;

PRINT N'Alpha TM outposts0';
SET @terminalID = 406; --TM outpost

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_mill_basic')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_mill_advanced')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_prototyper_basic')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_prototyper_advanced')
and parent=@terminalID;

PRINT N'Alpha TM outposts1';
SET @terminalID = 408; --TM outpost

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_research_lab_basic')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_research_lab_advanced')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_refinery_basic')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_refinery_advanced')
and parent=@terminalID;

PRINT N'Alpha TM outposts2';
SET @terminalID = 411; --TM outpost

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_reprocessor_basic')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_reprocessor_advanced')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_repair_basic')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_repair_advanced')
and parent=@terminalID;

PRINT N'A2 Hershfield';
SET @terminalID = 142; --HERSH

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_refinery_advanced')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_refinery_expert')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_prototyper_advanced')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_prototyper_expert')
and parent=@terminalID;

PRINT N'TMB Norhoop';
SET @terminalID=47383;--TMB Norhoop

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_refinery_super')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_refinery_super')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_reprocessor_super')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_reprocessor_expert')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_repair_super')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_repair_expert')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_mill_super')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_mill_expert')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_research_lab_super')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_research_lab_expert')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_prototyper_super')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_prototyper_super')
and parent=@terminalID;


PRINT N'ICS-B Dom';
SET @terminalID=47379;--ICSB - Domhalarn

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_refinery_super')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_refinery_expert')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_reprocessor_super')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_reprocessor_expert')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_repair_super')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_repair_super')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_mill_super')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_mill_super')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_research_lab_super')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_research_lab_expert')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_prototyper_super')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_prototyper_expert')
and parent=@terminalID;


PRINT N'ASI-B Hokk';
SET @terminalID=47381;--ASI-B - Hokkogaros

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_refinery_super')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_refinery_expert')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_reprocessor_super')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_reprocessor_super')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_repair_super')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_repair_expert')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_mill_super')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_mill_expert')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_research_lab_super')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_research_lab_super')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_prototyper_super')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_prototyper_expert')
and parent=@terminalID;

GO

CREATE TABLE [dbo].[itemcreation] (
[Id] int NOT NULL IDENTITY(1,1) ,
[Type] nvarchar(50) NOT NULL ,
[Entity] int NOT NULL ,
[Qty] int NOT NULL ,
[CharacterId] int NOT NULL ,
[IsTraining] int NOT NULL,
[ZoneId] int NOT NULL ,
[DateTime] datetime NOT NULL 
)

GO

ALTER TABLE [dbo].[itemcreation] ADD PRIMARY KEY ([Id])
GO