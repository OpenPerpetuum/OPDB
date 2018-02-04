---BALANCE bots mk1 v0 must be run first! --

DECLARE @definitionID int;
DECLARE @extensionID int;
DECLARE @aggfieldID int;
DECLARE @chassisbonusID int;
DECLARE @aggvalueID int;


SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_syndicate_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_legatus_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'armor_max_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.03 WHERE id = @chassisbonusID;


SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_syndicate_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_legatus_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'signature_radius' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.2 WHERE id = @chassisbonusID;


SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_webber_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.03 WHERE id = @chassisbonusID;


SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'effect_enhancer_sensor_dampener_locking_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.01 WHERE id = @chassisbonusID;


SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'effect_enhancer_sensor_dampener_locking_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.02 WHERE id = @chassisbonusID;


SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_small_laser_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;


SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_yagel_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'detection_strength' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, 2, '', @aggfieldID, 0);


SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_yagel_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'turret_fallof_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;


SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_nuimqol_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_yagel_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.07 WHERE id = @chassisbonusID;


SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_nuimqol_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.07 WHERE id = @chassisbonusID;


SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_nuimqol_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_arbalest_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.07 WHERE id = @chassisbonusID;


SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_nuimqol_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.07 WHERE id = @chassisbonusID;


SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_nuimqol_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vagabond_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.07 WHERE id = @chassisbonusID;


SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_nuimqol_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.07 WHERE id = @chassisbonusID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_mass_reductor' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_standard_mass_reductor', quantity=1, attributeflags=524320, categoryflags=327951, options='#moduleFlag=i20#tier=$tierlevel_t1', 
                note='', enabled=1, volume=0.5, mass=2, hidden='False', health=100, descriptiontoken='def_standard_mass_reductor_desc', purchasable=1, tiertype=1, 
                tierlevel=1 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.15 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_mining_upgrade' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_standard_mining_upgrade', quantity=1, attributeflags=524288, categoryflags=263695, options='#moduleFlag=i8#tier=$tierlevel_t1', 
                note='', enabled=1, volume=1, mass=100, hidden='False', health=100, descriptiontoken='def_standard_mining_upgrade_desc', purchasable=1, tiertype=1, 
                tierlevel=1 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'harvesting_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'harvesting_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatefields SET [name]='harvesting_amount_modifier', [formula]=0, [measurementunit]='harvesting_amount_modifier_unit', [measurementmultiplier]=100, [measurementoffset]=-100, [category]=6, [digits]=2, [moreisbetter]=1, [usedinconfig]=1, [note]='' WHERE id =@aggfieldID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mining_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mining_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatefields SET [name]='mining_amount_modifier', [formula]=0, [measurementunit]='mining_amount_modifier_unit', [measurementmultiplier]=100, [measurementoffset]=-100, [category]=6, [digits]=2, [moreisbetter]=1, [usedinconfig]=1, [note]='' WHERE id =@aggfieldID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_mining_upgrade' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named1_mining_upgrade', quantity=1, attributeflags=524288, categoryflags=263695, options='#moduleFlag=i8#tier=$tierlevel_t2', 
                note='', enabled=1, volume=0.1, mass=60, hidden='False', health=100, descriptiontoken='def_named_mining_upgrade_desc', purchasable=1, tiertype=1, 
                tierlevel=2 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'harvesting_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mining_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.1 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_mining_upgrade' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named2_mining_upgrade', quantity=1, attributeflags=524288, categoryflags=263695, options='#moduleFlag=i8#tier=$tierlevel_t3', 
                note='', enabled=1, volume=0.1, mass=60, hidden='False', health=100, descriptiontoken='def_named_mining_upgrade_desc', purchasable=1, tiertype=1, 
                tierlevel=3 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'harvesting_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.15 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mining_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.15 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_mining_upgrade' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named3_mining_upgrade', quantity=1, attributeflags=524288, categoryflags=263695, options='#moduleFlag=i8#tier=$tierlevel_t4', 
                note='', enabled=1, volume=0.1, mass=60, hidden='False', health=100, descriptiontoken='def_named_mining_upgrade_desc', purchasable=1, tiertype=1, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'harvesting_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.2 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mining_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.2 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_armor_repairer_upgrade' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_standard_armor_repairer_upgrade', quantity=1, attributeflags=524292, categoryflags=393487, options='#moduleFlag=i8#tier=$tierlevel_t1', 
                note='', enabled=1, volume=0.5, mass=300, hidden='False', health=100, descriptiontoken='def_armor_repairer_upgrade_desc', purchasable=1, tiertype=1, 
                tierlevel=1 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatefields SET [name]='armor_repair_amount_modifier', [formula]=0, [measurementunit]='armor_repair_amount_modifier_unit', [measurementmultiplier]=100, [measurementoffset]=-100, [category]=2, [digits]=2, [moreisbetter]=1, [usedinconfig]=1, [note]='' WHERE id =@aggfieldID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_armor_repairer_upgrade' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named2_armor_repairer_upgrade', quantity=1, attributeflags=524292, categoryflags=393487, options='#moduleFlag=i8#tier=$tierlevel_t3', 
                note='', enabled=1, volume=0.5, mass=300, hidden='False', health=100, descriptiontoken='def_armor_repairer_upgrade_desc', purchasable=1, tiertype=1, 
                tierlevel=3 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.15 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.92 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_armor_repairer_upgrade' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named3_armor_repairer_upgrade', quantity=1, attributeflags=524292, categoryflags=393487, options='#moduleFlag=i8#tier=$tierlevel_t4', 
                note='', enabled=1, volume=0.5, mass=375, hidden='False', health=100, descriptiontoken='def_armor_repairer_upgrade_desc', purchasable=1, tiertype=1, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.2 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_mass_reductor' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named1_mass_reductor', quantity=1, attributeflags=524320, categoryflags=327951, options='#moduleFlag=i20#tier=$tierlevel_t2', 
                note='', enabled=1, volume=0.5, mass=2, hidden='False', health=100, descriptiontoken='def_named_mass_reductor_desc', purchasable=1, tiertype=1, 
                tierlevel=2 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.15 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'massiveness' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=-0.25 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_armor_repairer_upgrade_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named1_armor_repairer_upgrade_pr', quantity=1, attributeflags=524292, categoryflags=393487, options='#moduleFlag=i8#tier=$tierlevel_t2_pr', 
                note='', enabled=1, volume=0.5, mass=216, hidden='False', health=100, descriptiontoken='def_armor_repairer_upgrade_desc', purchasable=1, tiertype=2, 
                tierlevel=2 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.1 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_armor_repairer_upgrade_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named2_armor_repairer_upgrade_pr', quantity=1, attributeflags=524292, categoryflags=393487, options='#moduleFlag=i8#tier=$tierlevel_t3_pr', 
                note='', enabled=1, volume=0.5, mass=240, hidden='False', health=100, descriptiontoken='def_armor_repairer_upgrade_desc', purchasable=1, tiertype=2, 
                tierlevel=3 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.15 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.92 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_armor_repairer_upgrade_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named3_armor_repairer_upgrade_pr', quantity=1, attributeflags=524292, categoryflags=393487, options='#moduleFlag=i8#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=0.5, mass=300, hidden='False', health=100, descriptiontoken='def_armor_repairer_upgrade_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.2 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_mass_reductor_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named1_mass_reductor_pr', quantity=1, attributeflags=524320, categoryflags=327951, options='#moduleFlag=i20#tier=$tierlevel_t2_pr', 
                note='', enabled=1, volume=0.5, mass=1.5, hidden='False', health=100, descriptiontoken='def_named_mass_reductor_desc', purchasable=1, tiertype=2, 
                tierlevel=2 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.15 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'massiveness' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=-0.25 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_mass_reductor_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named2_mass_reductor_pr', quantity=1, attributeflags=524320, categoryflags=327951, options='#moduleFlag=i20#tier=$tierlevel_t3_pr', 
                note='', enabled=1, volume=0.5, mass=1.5, hidden='False', health=100, descriptiontoken='def_named_mass_reductor_desc', purchasable=1, tiertype=2, 
                tierlevel=3 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.2 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'massiveness' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=-0.25 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_mass_reductor_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named3_mass_reductor_pr', quantity=1, attributeflags=524320, categoryflags=327951, options='#moduleFlag=i20#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=0.5, mass=1.5, hidden='False', health=100, descriptiontoken='def_named_mass_reductor_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.25 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'massiveness' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=-0.25 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_armor_repairer_upgrade' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_artifact_a_armor_repairer_upgrade', quantity=1, attributeflags=524292, categoryflags=393487, options='#moduleFlag=i8#tier=$tierlevel_t3a', 
                note='', enabled=1, volume=0.5, mass=240, hidden='False', health=100, descriptiontoken='def_artifact_a_armor_repairer_upgrade_desc', purchasable=1, tiertype=3, 
                tierlevel=3 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.15 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.92 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_mass_reductor' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_artifact_a_mass_reductor', quantity=1, attributeflags=524320, categoryflags=327951, options='#moduleFlag=i20#tier=$tierlevel_t3a', 
                note='', enabled=1, volume=0.5, mass=2, hidden='False', health=100, descriptiontoken='def_artifact_a_mass_reductor_desc', purchasable=1, tiertype=3, 
                tierlevel=3 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.2 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'massiveness' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=-0.25 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_reactor_sealing' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_standard_reactor_sealing', quantity=1, attributeflags=524292, categoryflags=918287, options='#moduleFlag=i20#tier=$tierlevel_t1', 
                note='', enabled=1, volume=1, mass=150, hidden='False', health=100, descriptiontoken='def_standard_reactor_sealing_desc', purchasable=1, tiertype=1, 
                tierlevel=1 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'reactor_radiation_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.5 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_reactor_sealing' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named1_reactor_sealing', quantity=1, attributeflags=524292, categoryflags=918287, options='#moduleFlag=i20#tier=$tierlevel_t2', 
                note='', enabled=1, volume=1, mass=135, hidden='False', health=100, descriptiontoken='def_named_reactor_sealing_desc', purchasable=1, tiertype=1, 
                tierlevel=2 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'reactor_radiation_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.5 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_reactor_sealing' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named2_reactor_sealing', quantity=1, attributeflags=524292, categoryflags=918287, options='#moduleFlag=i20#tier=$tierlevel_t3', 
                note='', enabled=1, volume=1, mass=150, hidden='False', health=100, descriptiontoken='def_named_reactor_sealing_desc', purchasable=1, tiertype=1, 
                tierlevel=3 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'reactor_radiation_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.4 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_reactor_sealing' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named3_reactor_sealing', quantity=1, attributeflags=524292, categoryflags=918287, options='#moduleFlag=i20#tier=$tierlevel_t4', 
                note='', enabled=1, volume=1, mass=165, hidden='False', health=100, descriptiontoken='def_named_reactor_sealing_desc', purchasable=1, tiertype=1, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'reactor_radiation_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.3 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_reactor_sealing_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named3_reactor_sealing_pr', quantity=1, attributeflags=524292, categoryflags=918287, options='#moduleFlag=i20#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=1, mass=165, hidden='False', health=100, descriptiontoken='def_named_reactor_sealing_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'reactor_radiation_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.5 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_reactor_sealing_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named2_reactor_sealing_pr', quantity=1, attributeflags=524292, categoryflags=918287, options='#moduleFlag=i20#tier=$tierlevel_t3_pr', 
                note='', enabled=1, volume=1, mass=150, hidden='False', health=100, descriptiontoken='def_named_reactor_sealing_desc', purchasable=1, tiertype=2, 
                tierlevel=3 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'reactor_radiation_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.4 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_reactor_sealing_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named1_reactor_sealing_pr', quantity=1, attributeflags=524292, categoryflags=918287, options='#moduleFlag=i20#tier=$tierlevel_t2_pr', 
                note='', enabled=1, volume=1, mass=135, hidden='False', health=100, descriptiontoken='def_named_reactor_sealing_desc', purchasable=1, tiertype=2, 
                tierlevel=2 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'reactor_radiation_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.3 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_reactor_sealing_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named3_reactor_sealing_pr', quantity=1, attributeflags=524292, categoryflags=918287, options='#moduleFlag=i20#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=1, mass=165, hidden='False', health=100, descriptiontoken='def_named_reactor_sealing_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'reactor_radiation_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.3 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_reactor_sealing_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named3_reactor_sealing_pr', quantity=1, attributeflags=524292, categoryflags=918287, options='#moduleFlag=i20#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=1, mass=165, hidden='False', health=100, descriptiontoken='def_named_reactor_sealing_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'reactor_radiation_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.5 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_mining_upgrade_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named1_mining_upgrade_pr', quantity=1, attributeflags=524288, categoryflags=263695, options='#moduleFlag=i8#tier=$tierlevel_t2_pr', 
                note='', enabled=1, volume=0.1, mass=45, hidden='False', health=100, descriptiontoken='def_named_mining_upgrade_desc', purchasable=1, tiertype=2, 
                tierlevel=2 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'harvesting_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.1 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mining_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.1 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_mining_upgrade_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named2_mining_upgrade_pr', quantity=1, attributeflags=524288, categoryflags=263695, options='#moduleFlag=i8#tier=$tierlevel_t3_pr', 
                note='', enabled=1, volume=0.1, mass=45, hidden='False', health=100, descriptiontoken='def_named_mining_upgrade_desc', purchasable=1, tiertype=2, 
                tierlevel=3 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'harvesting_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.15 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mining_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.15 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_mining_upgrade_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named3_mining_upgrade_pr', quantity=1, attributeflags=524288, categoryflags=263695, options='#moduleFlag=i8#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=0.1, mass=45, hidden='False', health=100, descriptiontoken='def_named_mining_upgrade_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'harvesting_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.2 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mining_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.2 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_armor_repairer_upgrade' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named1_armor_repairer_upgrade', quantity=1, attributeflags=524292, categoryflags=393487, options='#moduleFlag=i8#tier=$tierlevel_t2', 
                note='', enabled=1, volume=0.5, mass=270, hidden='False', health=100, descriptiontoken='def_armor_repairer_upgrade_desc', purchasable=1, tiertype=1, 
                tierlevel=2 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.1 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_mining_upgrade' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_artifact_a_mining_upgrade', quantity=1, attributeflags=524288, categoryflags=263695, options='#moduleFlag=i8#tier=$tierlevel_t3a', 
                note='', enabled=1, volume=0.1, mass=50, hidden='False', health=100, descriptiontoken='def_artifact_a_mining_upgrade_desc', purchasable=1, tiertype=3, 
                tierlevel=3 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'harvesting_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.15 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mining_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.15 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_damaged_mining_upgrade' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_artifact_damaged_mining_upgrade', quantity=1, attributeflags=524288, categoryflags=263695, options='#moduleFlag=i8#tier=$tierlevel_t0', 
                note='', enabled=1, volume=1, mass=100, hidden='False', health=100, descriptiontoken='def_artifact_damaged_mining_upgrade_desc', purchasable=1, tiertype=1, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'harvesting_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.05 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mining_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.05 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_damaged_armor_repairer_upgrade' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_artifact_damaged_armor_repairer_upgrade', quantity=1, attributeflags=524292, categoryflags=393487, options='#moduleFlag=i8#tier=$tierlevel_t0', 
                note='', enabled=1, volume=0.5, mass=300, hidden='False', health=100, descriptiontoken='def_artifact_damaged_armor_repairer_upgrade_desc', purchasable=1, tiertype=1, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.05 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_reactor_sealing_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named3_reactor_sealing_pr', quantity=1, attributeflags=524292, categoryflags=918287, options='#moduleFlag=i20#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=1, mass=165, hidden='False', health=100, descriptiontoken='def_named_reactor_sealing_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'reactor_radiation_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.3 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_reactor_sealing_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named1_reactor_sealing_pr', quantity=1, attributeflags=524292, categoryflags=918287, options='#moduleFlag=i20#tier=$tierlevel_t2_pr', 
                note='', enabled=1, volume=1, mass=135, hidden='False', health=100, descriptiontoken='def_named_reactor_sealing_desc', purchasable=1, tiertype=2, 
                tierlevel=2 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'reactor_radiation_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.5 WHERE id =  @aggvalueID;

