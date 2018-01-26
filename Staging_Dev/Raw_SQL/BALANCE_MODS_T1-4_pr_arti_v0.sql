DECLARE @definitionID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_mining_upgrade' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_standard_mining_upgrade', quantity=1, attributeflags=524288, categoryflags=263695, options='#moduleFlag=i8#tier=$tierlevel_t1', 
                note='', enabled=1, volume=1, mass=100, hidden='False', health=100, descriptiontoken='def_standard_mining_upgrade_desc', purchasable=1, tiertype=1, 
                tierlevel=1 where definition=@definitionID;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'harvesting_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.1 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'harvesting_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatefields SET [name]='harvesting_amount_modifier', [formula]=1, [measurementunit]='harvesting_amount_modifier_unit', [measurementmultiplier]=100, [measurementoffset]=0, [category]=6, [digits]=2, [moreisbetter]=1, [usedinconfig]=1, [note]='' WHERE id =@aggfieldID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mining_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.1 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mining_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatefields SET [name]='mining_amount_modifier', [formula]=1, [measurementunit]='mining_amount_modifier_unit', [measurementmultiplier]=100, [measurementoffset]=0, [category]=6, [digits]=2, [moreisbetter]=1, [usedinconfig]=1, [note]='' WHERE id =@aggfieldID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_drillers_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_harvester_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_mass_reductor' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_standard_mass_reductor', quantity=1, attributeflags=524320, categoryflags=327951, options='#moduleFlag=i20#tier=$tierlevel_t1', 
                note='', enabled=1, volume=0.5, mass=2, hidden='False', health=100, descriptiontoken='def_standard_mass_reductor_desc', purchasable=1, tiertype=1, 
                tierlevel=1 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.05);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mass_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_harvester' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_standard_medium_harvester', quantity=1, attributeflags=327696, categoryflags=33949199, options='#moduleFlag=i290#ammoCapacity=i2d#ammoType=La0a#tier=$tierlevel_t1', 
                note='', enabled=1, volume=1.5, mass=1000, hidden='False', health=100, descriptiontoken='def_standard_harvester_desc', purchasable=1, tiertype=1, 
                tierlevel=1 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=55 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_driller' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_standard_medium_driller', quantity=1, attributeflags=327696, categoryflags=33621519, options='#moduleFlag=i290#ammoCapacity=i2d#ammoType=L50a#tier=$tierlevel_t1', 
                note='', enabled=1, volume=1.5, mass=1000, hidden='False', health=100, descriptiontoken='def_standard_driller_desc', purchasable=1, tiertype=1, 
                tierlevel=1 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=55 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_driller' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named1_medium_driller', quantity=1, attributeflags=327696, categoryflags=33621519, options='#moduleFlag=i290#ammoCapacity=i2d#ammoType=L50a#tier=$tierlevel_t2', 
                note='', enabled=1, volume=1.5, mass=900, hidden='False', health=100, descriptiontoken='def_named_driller_desc', purchasable=1, tiertype=1, 
                tierlevel=2 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=45 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_driller' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named2_medium_driller', quantity=1, attributeflags=327696, categoryflags=33621519, options='#moduleFlag=i290#ammoCapacity=i2d#ammoType=L50a#tier=$tierlevel_t3', 
                note='', enabled=1, volume=1.5, mass=1000, hidden='False', health=100, descriptiontoken='def_named_driller_desc', purchasable=1, tiertype=1, 
                tierlevel=3 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=60 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_driller' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named3_medium_driller', quantity=1, attributeflags=327696, categoryflags=33621519, options='#moduleFlag=i290#ammoCapacity=i2d#ammoType=L50a#tier=$tierlevel_t4', 
                note='', enabled=1, volume=1.5, mass=1000, hidden='False', health=100, descriptiontoken='def_named_driller_desc', purchasable=1, tiertype=1, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=65 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_mining_upgrade' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named1_mining_upgrade', quantity=1, attributeflags=524288, categoryflags=263695, options='#moduleFlag=i8#tier=$tierlevel_t2', 
                note='', enabled=1, volume=0.1, mass=60, hidden='False', health=100, descriptiontoken='def_named_mining_upgrade_desc', purchasable=1, tiertype=1, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'harvesting_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.15 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mining_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.15 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_drillers_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_harvester_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_mining_upgrade' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named2_mining_upgrade', quantity=1, attributeflags=524288, categoryflags=263695, options='#moduleFlag=i8#tier=$tierlevel_t3', 
                note='', enabled=1, volume=0.1, mass=60, hidden='False', health=100, descriptiontoken='def_named_mining_upgrade_desc', purchasable=1, tiertype=1, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'harvesting_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.2 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mining_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.2 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_drillers_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_harvester_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_mining_upgrade' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named3_mining_upgrade', quantity=1, attributeflags=524288, categoryflags=263695, options='#moduleFlag=i8#tier=$tierlevel_t4', 
                note='', enabled=1, volume=0.1, mass=60, hidden='False', health=100, descriptiontoken='def_named_mining_upgrade_desc', purchasable=1, tiertype=1, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'harvesting_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.25 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mining_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.25 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_drillers_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_harvester_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_harvester' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named1_medium_harvester', quantity=1, attributeflags=327696, categoryflags=33949199, options='#moduleFlag=i290#ammoCapacity=i2d#ammoType=La0a#tier=$tierlevel_t2', 
                note='', enabled=1, volume=1.5, mass=900, hidden='False', health=100, descriptiontoken='def_named_harvester_desc', purchasable=1, tiertype=1, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=45 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_harvester' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named2_medium_harvester', quantity=1, attributeflags=327696, categoryflags=33949199, options='#moduleFlag=i290#ammoCapacity=i2d#ammoType=La0a#tier=$tierlevel_t3', 
                note='', enabled=1, volume=1.5, mass=1000, hidden='False', health=100, descriptiontoken='def_named_harvester_desc', purchasable=1, tiertype=1, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=60 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_harvester' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named3_medium_harvester', quantity=1, attributeflags=327696, categoryflags=33949199, options='#moduleFlag=i290#ammoCapacity=i2d#ammoType=La0a#tier=$tierlevel_t4', 
                note='', enabled=1, volume=1.5, mass=1000, hidden='False', health=100, descriptiontoken='def_named_harvester_desc', purchasable=1, tiertype=1, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=65 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_damage_mod_railgun' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_standard_damage_mod_railgun', quantity=1, attributeflags=524292, categoryflags=17106703, options='#moduleFlag=i8#tier=$tierlevel_t1', 
                note='', enabled=1, volume=0.5, mass=100, hidden='False', health=100, descriptiontoken='def_damage_mod_railgun_desc', purchasable=1, tiertype=1, 
                tierlevel=1 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_railgun_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.1 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_railgun_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatefields SET [name]='damage_railgun_modifier', [formula]=1, [measurementunit]='damage_railgun_modifier_unit', [measurementmultiplier]=100, [measurementoffset]=0, [category]=6, [digits]=2, [moreisbetter]=1, [usedinconfig]=1, [note]='' WHERE id =@aggfieldID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_railgun_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_damage_mod_missile' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_standard_damage_mod_missile', quantity=1, attributeflags=524292, categoryflags=67438351, options='#moduleFlag=i8#tier=$tierlevel_t1', 
                note='', enabled=1, volume=0.5, mass=100, hidden='False', health=100, descriptiontoken='def_damage_mod_missile_desc', purchasable=1, tiertype=1, 
                tierlevel=1 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_missile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.1 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_missile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatefields SET [name]='damage_missile_modifier', [formula]=1, [measurementunit]='damage_missile_modifier_unit', [measurementmultiplier]=100, [measurementoffset]=0, [category]=6, [digits]=2, [moreisbetter]=1, [usedinconfig]=1, [note]='' WHERE id =@aggfieldID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_missile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_damage_mod_laser' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_standard_damage_mod_laser', quantity=1, attributeflags=524292, categoryflags=50661135, options='#moduleFlag=i8#tier=$tierlevel_t1', 
                note='', enabled=1, volume=0.5, mass=100, hidden='False', health=100, descriptiontoken='def_damage_mod_laser_desc', purchasable=1, tiertype=1, 
                tierlevel=1 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_laser_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.1 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_laser_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatefields SET [name]='damage_laser_modifier', [formula]=1, [measurementunit]='damage_laser_modifier_unit', [measurementmultiplier]=100, [measurementoffset]=0, [category]=6, [digits]=2, [moreisbetter]=1, [usedinconfig]=1, [note]='' WHERE id =@aggfieldID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_laser_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_damage_mod_projectile' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_standard_damage_mod_projectile', quantity=1, attributeflags=524292, categoryflags=33883919, options='#moduleFlag=i8#tier=$tierlevel_t1', 
                note='', enabled=1, volume=0.5, mass=100, hidden='False', health=100, descriptiontoken='def_damage_mod_projectile_desc', purchasable=1, tiertype=1, 
                tierlevel=1 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_projectile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.1 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_projectile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatefields SET [name]='damage_projectile_modifier', [formula]=1, [measurementunit]='damage_projectile_modifier_unit', [measurementmultiplier]=100, [measurementoffset]=0, [category]=6, [digits]=2, [moreisbetter]=1, [usedinconfig]=1, [note]='' WHERE id =@aggfieldID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_projectile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_damage_mod_railgun' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named1_damage_mod_railgun', quantity=1, attributeflags=524292, categoryflags=17106703, options='#moduleFlag=i8#tier=$tierlevel_t2', 
                note='', enabled=1, volume=0.5, mass=90, hidden='False', health=100, descriptiontoken='def_damage_mod_railgun_desc', purchasable=1, tiertype=1, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_railgun_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.15 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_railgun_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_damage_mod_railgun' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named2_damage_mod_railgun', quantity=1, attributeflags=524292, categoryflags=17106703, options='#moduleFlag=i8#tier=$tierlevel_t3', 
                note='', enabled=1, volume=0.5, mass=100, hidden='False', health=100, descriptiontoken='def_damage_mod_railgun_desc', purchasable=1, tiertype=1, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_railgun_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.2 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_railgun_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_damage_mod_railgun' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named3_damage_mod_railgun', quantity=1, attributeflags=524292, categoryflags=17106703, options='#moduleFlag=i8#tier=$tierlevel_t4', 
                note='', enabled=1, volume=0.5, mass=125, hidden='False', health=100, descriptiontoken='def_damage_mod_railgun_desc', purchasable=1, tiertype=1, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_railgun_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.25 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_railgun_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_damage_mod_missile' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named1_damage_mod_missile', quantity=1, attributeflags=524292, categoryflags=67438351, options='#moduleFlag=i8#tier=$tierlevel_t2', 
                note='', enabled=1, volume=0.5, mass=90, hidden='False', health=100, descriptiontoken='def_damage_mod_missile_desc', purchasable=1, tiertype=1, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_missile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.15 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_missile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_damage_mod_missile' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named2_damage_mod_missile', quantity=1, attributeflags=524292, categoryflags=67438351, options='#moduleFlag=i8#tier=$tierlevel_t3', 
                note='', enabled=1, volume=0.5, mass=100, hidden='False', health=100, descriptiontoken='def_damage_mod_missile_desc', purchasable=1, tiertype=1, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_missile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.2 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_missile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_damage_mod_missile' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named3_damage_mod_missile', quantity=1, attributeflags=524292, categoryflags=67438351, options='#moduleFlag=i8#tier=$tierlevel_t4', 
                note='', enabled=1, volume=0.5, mass=125, hidden='False', health=100, descriptiontoken='def_damage_mod_missile_desc', purchasable=1, tiertype=1, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_missile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.25 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_missile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_damage_mod_laser' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named1_damage_mod_laser', quantity=1, attributeflags=524292, categoryflags=50661135, options='#moduleFlag=i8#tier=$tierlevel_t2', 
                note='', enabled=1, volume=0.5, mass=90, hidden='False', health=100, descriptiontoken='def_damage_mod_laser_desc', purchasable=1, tiertype=1, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_laser_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.15 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_laser_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_damage_mod_laser' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named2_damage_mod_laser', quantity=1, attributeflags=524292, categoryflags=50661135, options='#moduleFlag=i8#tier=$tierlevel_t3', 
                note='', enabled=1, volume=0.5, mass=100, hidden='False', health=100, descriptiontoken='def_damage_mod_laser_desc', purchasable=1, tiertype=1, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_laser_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.2 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_laser_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_damage_mod_laser' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named3_damage_mod_laser', quantity=1, attributeflags=524292, categoryflags=50661135, options='#moduleFlag=i8#tier=$tierlevel_t4', 
                note='', enabled=1, volume=0.5, mass=125, hidden='False', health=100, descriptiontoken='def_damage_mod_laser_desc', purchasable=1, tiertype=1, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_laser_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.25 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_laser_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_damage_mod_projectile' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named1_damage_mod_projectile', quantity=1, attributeflags=524292, categoryflags=33883919, options='#moduleFlag=i8#tier=$tierlevel_t2', 
                note='', enabled=1, volume=0.5, mass=90, hidden='False', health=100, descriptiontoken='def_damage_mod_projectile_desc', purchasable=1, tiertype=1, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_projectile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.15 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_projectile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_damage_mod_projectile' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named2_damage_mod_projectile', quantity=1, attributeflags=524292, categoryflags=33883919, options='#moduleFlag=i8#tier=$tierlevel_t3', 
                note='', enabled=1, volume=0.5, mass=100, hidden='False', health=100, descriptiontoken='def_damage_mod_projectile_desc', purchasable=1, tiertype=1, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_projectile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.2 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_projectile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_damage_mod_projectile' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named3_damage_mod_projectile', quantity=1, attributeflags=524292, categoryflags=33883919, options='#moduleFlag=i8#tier=$tierlevel_t4', 
                note='', enabled=1, volume=0.5, mass=125, hidden='False', health=100, descriptiontoken='def_damage_mod_projectile_desc', purchasable=1, tiertype=1, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_projectile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.25 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_projectile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_armor_repairer_upgrade' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_standard_armor_repairer_upgrade', quantity=1, attributeflags=524292, categoryflags=393487, options='#moduleFlag=i8#tier=$tierlevel_t1', 
                note='', enabled=1, volume=0.5, mass=300, hidden='False', health=100, descriptiontoken='def_armor_repairer_upgrade_desc', purchasable=1, tiertype=1, 
                tierlevel=1 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.1 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatefields SET [name]='armor_repair_amount_modifier', [formula]=1, [measurementunit]='armor_repair_amount_modifier_unit', [measurementmultiplier]=100, [measurementoffset]=0, [category]=2, [digits]=2, [moreisbetter]=1, [usedinconfig]=1, [note]='' WHERE id =@aggfieldID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_armor_repair_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_remote_armor_repair_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_armor_repairer_upgrade' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named1_armor_repairer_upgrade', quantity=1, attributeflags=524292, categoryflags=393487, options='#moduleFlag=i8#tier=$tierlevel_t2', 
                note='', enabled=1, volume=0.5, mass=270, hidden='False', health=100, descriptiontoken='def_armor_repairer_upgrade_desc', purchasable=1, tiertype=1, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.15 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_armor_repair_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_remote_armor_repair_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_armor_repairer_upgrade' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named2_armor_repairer_upgrade', quantity=1, attributeflags=524292, categoryflags=393487, options='#moduleFlag=i8#tier=$tierlevel_t3', 
                note='', enabled=1, volume=0.5, mass=300, hidden='False', health=100, descriptiontoken='def_armor_repairer_upgrade_desc', purchasable=1, tiertype=1, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.2 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_armor_repair_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_remote_armor_repair_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_armor_repairer_upgrade' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named3_armor_repairer_upgrade', quantity=1, attributeflags=524292, categoryflags=393487, options='#moduleFlag=i8#tier=$tierlevel_t4', 
                note='', enabled=1, volume=0.5, mass=375, hidden='False', health=100, descriptiontoken='def_armor_repairer_upgrade_desc', purchasable=1, tiertype=1, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.25 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_armor_repair_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_remote_armor_repair_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_armor_repair_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_remote_armor_repair_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_mass_reductor' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named1_mass_reductor', quantity=1, attributeflags=524320, categoryflags=327951, options='#moduleFlag=i20#tier=$tierlevel_t2', 
                note='', enabled=1, volume=0.5, mass=2, hidden='False', health=100, descriptiontoken='def_named_mass_reductor_desc', purchasable=1, tiertype=1, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.1);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mass_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_mass_reductor' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named2_mass_reductor', quantity=1, attributeflags=524320, categoryflags=327951, options='#moduleFlag=i20#tier=$tierlevel_t3', 
                note='', enabled=1, volume=0.5, mass=2, hidden='False', health=100, descriptiontoken='def_named_mass_reductor_desc', purchasable=1, tiertype=1, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.2);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mass_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_mass_reductor' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named3_mass_reductor', quantity=1, attributeflags=524320, categoryflags=327951, options='#moduleFlag=i20#tier=$tierlevel_t4', 
                note='', enabled=1, volume=0.5, mass=2, hidden='False', health=100, descriptiontoken='def_named_mass_reductor_desc', purchasable=1, tiertype=1, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.25);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mass_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_damage_mod_railgun_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named1_damage_mod_railgun_pr', quantity=1, attributeflags=524292, categoryflags=17106703, options='#moduleFlag=i8#tier=$tierlevel_t2_pr', 
                note='', enabled=1, volume=0.5, mass=75, hidden='False', health=100, descriptiontoken='def_damage_mod_railgun_desc', purchasable=1, tiertype=2, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_railgun_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.05 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_railgun_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_damage_mod_railgun_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named2_damage_mod_railgun_pr', quantity=1, attributeflags=524292, categoryflags=17106703, options='#moduleFlag=i8#tier=$tierlevel_t3_pr', 
                note='', enabled=1, volume=0.5, mass=80, hidden='False', health=100, descriptiontoken='def_damage_mod_railgun_desc', purchasable=1, tiertype=2, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_railgun_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.075 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_railgun_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_damage_mod_railgun_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named3_damage_mod_railgun_pr', quantity=1, attributeflags=524292, categoryflags=17106703, options='#moduleFlag=i8#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=0.5, mass=100, hidden='False', health=100, descriptiontoken='def_damage_mod_railgun_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_railgun_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.095 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_railgun_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_damage_mod_missile_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named1_damage_mod_missile_pr', quantity=1, attributeflags=524292, categoryflags=67438351, options='#moduleFlag=i8#tier=$tierlevel_t2_pr', 
                note='', enabled=1, volume=0.5, mass=75, hidden='False', health=100, descriptiontoken='def_damage_mod_missile_desc', purchasable=1, tiertype=2, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_missile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.05 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_missile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_damage_mod_missile_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named2_damage_mod_missile_pr', quantity=1, attributeflags=524292, categoryflags=67438351, options='#moduleFlag=i8#tier=$tierlevel_t3_pr', 
                note='', enabled=1, volume=0.5, mass=80, hidden='False', health=100, descriptiontoken='def_damage_mod_missile_desc', purchasable=1, tiertype=2, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_missile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.075 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_missile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_damage_mod_missile_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named3_damage_mod_missile_pr', quantity=1, attributeflags=524292, categoryflags=67438351, options='#moduleFlag=i8#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=0.5, mass=100, hidden='False', health=100, descriptiontoken='def_damage_mod_missile_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_missile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.095 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_missile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_damage_mod_laser_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named1_damage_mod_laser_pr', quantity=1, attributeflags=524292, categoryflags=50661135, options='#moduleFlag=i8#tier=$tierlevel_t2_pr', 
                note='', enabled=1, volume=0.5, mass=75, hidden='False', health=100, descriptiontoken='def_damage_mod_laser_desc', purchasable=1, tiertype=2, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_laser_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.05 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_laser_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_damage_mod_laser_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named2_damage_mod_laser_pr', quantity=1, attributeflags=524292, categoryflags=50661135, options='#moduleFlag=i8#tier=$tierlevel_t3_pr', 
                note='', enabled=1, volume=0.5, mass=80, hidden='False', health=100, descriptiontoken='def_damage_mod_laser_desc', purchasable=1, tiertype=2, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_laser_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.075 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_laser_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_damage_mod_laser_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named3_damage_mod_laser_pr', quantity=1, attributeflags=524292, categoryflags=50661135, options='#moduleFlag=i8#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=0.5, mass=100, hidden='False', health=100, descriptiontoken='def_damage_mod_laser_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_laser_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.095 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_laser_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_damage_mod_projectile_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named1_damage_mod_projectile_pr', quantity=1, attributeflags=524292, categoryflags=33883919, options='#moduleFlag=i8#tier=$tierlevel_t2_pr', 
                note='', enabled=1, volume=0.5, mass=75, hidden='False', health=100, descriptiontoken='def_damage_mod_projectile_desc', purchasable=1, tiertype=2, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_projectile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.05 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_projectile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_damage_mod_projectile_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named2_damage_mod_projectile_pr', quantity=1, attributeflags=524292, categoryflags=33883919, options='#moduleFlag=i8#tier=$tierlevel_t3_pr', 
                note='', enabled=1, volume=0.5, mass=80, hidden='False', health=100, descriptiontoken='def_damage_mod_projectile_desc', purchasable=1, tiertype=2, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_projectile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.075 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_projectile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_damage_mod_projectile_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named3_damage_mod_projectile_pr', quantity=1, attributeflags=524292, categoryflags=33883919, options='#moduleFlag=i8#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=0.5, mass=100, hidden='False', health=100, descriptiontoken='def_damage_mod_projectile_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_projectile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.095 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_projectile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_armor_repairer_upgrade_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named1_armor_repairer_upgrade_pr', quantity=1, attributeflags=524292, categoryflags=393487, options='#moduleFlag=i8#tier=$tierlevel_t2_pr', 
                note='', enabled=1, volume=0.5, mass=216, hidden='False', health=100, descriptiontoken='def_armor_repairer_upgrade_desc', purchasable=1, tiertype=2, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.05 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_armor_repair_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_remote_armor_repair_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_armor_repairer_upgrade_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named2_armor_repairer_upgrade_pr', quantity=1, attributeflags=524292, categoryflags=393487, options='#moduleFlag=i8#tier=$tierlevel_t3_pr', 
                note='', enabled=1, volume=0.5, mass=240, hidden='False', health=100, descriptiontoken='def_armor_repairer_upgrade_desc', purchasable=1, tiertype=2, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.075 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_armor_repair_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_remote_armor_repair_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_armor_repairer_upgrade_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named3_armor_repairer_upgrade_pr', quantity=1, attributeflags=524292, categoryflags=393487, options='#moduleFlag=i8#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=0.5, mass=300, hidden='False', health=100, descriptiontoken='def_armor_repairer_upgrade_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.095 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_armor_repair_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_remote_armor_repair_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_mass_reductor_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named1_mass_reductor_pr', quantity=1, attributeflags=524320, categoryflags=327951, options='#moduleFlag=i20#tier=$tierlevel_t2_pr', 
                note='', enabled=1, volume=0.5, mass=1.5, hidden='False', health=100, descriptiontoken='def_named_mass_reductor_desc', purchasable=1, tiertype=2, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.05);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mass_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_mass_reductor_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named2_mass_reductor_pr', quantity=1, attributeflags=524320, categoryflags=327951, options='#moduleFlag=i20#tier=$tierlevel_t3_pr', 
                note='', enabled=1, volume=0.5, mass=1.5, hidden='False', health=100, descriptiontoken='def_named_mass_reductor_desc', purchasable=1, tiertype=2, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.075);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mass_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_mass_reductor_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named3_mass_reductor_pr', quantity=1, attributeflags=524320, categoryflags=327951, options='#moduleFlag=i20#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=0.5, mass=1.5, hidden='False', health=100, descriptiontoken='def_named_mass_reductor_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.095);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mass_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_damaged_armor_repairer_upgrade' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_artifact_damaged_armor_repairer_upgrade', quantity=1, attributeflags=524292, categoryflags=393487, options='#moduleFlag=i8#tier=$tierlevel_t0', 
                note='', enabled=1, volume=0.5, mass=300, hidden='False', health=100, descriptiontoken='def_artifact_damaged_armor_repairer_upgrade_desc', purchasable=1, tiertype=1, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.05 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_armor_repair_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_remote_armor_repair_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_armor_repairer_upgrade' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_artifact_a_armor_repairer_upgrade', quantity=1, attributeflags=524292, categoryflags=393487, options='#moduleFlag=i8#tier=$tierlevel_t3a', 
                note='', enabled=1, volume=0.5, mass=240, hidden='False', health=100, descriptiontoken='def_artifact_a_armor_repairer_upgrade_desc', purchasable=1, tiertype=3, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.1 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_armor_repair_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_remote_armor_repair_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_damaged_mass_reductor' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_artifact_damaged_mass_reductor', quantity=1, attributeflags=524320, categoryflags=327951, options='#moduleFlag=i20#tier=$tierlevel_t0', 
                note='', enabled=1, volume=0.5, mass=2, hidden='False', health=100, descriptiontoken='def_artifact_damaged_mass_reductor_desc', purchasable=1, tiertype=1, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.03);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mass_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_mass_reductor' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_artifact_a_mass_reductor', quantity=1, attributeflags=524320, categoryflags=327951, options='#moduleFlag=i20#tier=$tierlevel_t3a', 
                note='', enabled=1, volume=0.5, mass=2, hidden='False', health=100, descriptiontoken='def_artifact_a_mass_reductor_desc', purchasable=1, tiertype=3, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.075);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mass_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_damaged_mining_upgrade' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_artifact_damaged_mining_upgrade', quantity=1, attributeflags=524288, categoryflags=263695, options='#moduleFlag=i8#tier=$tierlevel_t0', 
                note='', enabled=1, volume=1, mass=100, hidden='False', health=100, descriptiontoken='def_artifact_damaged_mining_upgrade_desc', purchasable=1, tiertype=1, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'harvesting_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.05 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mining_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.05 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_drillers_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_harvester_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_mining_upgrade' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_artifact_a_mining_upgrade', quantity=1, attributeflags=524288, categoryflags=263695, options='#moduleFlag=i8#tier=$tierlevel_t3a', 
                note='', enabled=1, volume=0.1, mass=50, hidden='False', health=100, descriptiontoken='def_artifact_a_mining_upgrade_desc', purchasable=1, tiertype=3, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'harvesting_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.1 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mining_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.1 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_drillers_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_harvester_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_damaged_damage_mod_railgun' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_artifact_damaged_damage_mod_railgun', quantity=1, attributeflags=524292, categoryflags=17106703, options='#moduleFlag=i8#tier=$tierlevel_t0', 
                note='', enabled=1, volume=0.5, mass=100, hidden='False', health=100, descriptiontoken='def_artifact_damaged_damage_mod_railgun_desc', purchasable=1, tiertype=1, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_railgun_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.03 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_railgun_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_damage_mod_railgun' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_artifact_a_damage_mod_railgun', quantity=1, attributeflags=524292, categoryflags=17106703, options='#moduleFlag=i8#tier=$tierlevel_t3a', 
                note='', enabled=1, volume=0.5, mass=90, hidden='False', health=100, descriptiontoken='def_artifact_a_damage_mod_railgun_desc', purchasable=1, tiertype=3, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_railgun_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.075 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_railgun_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_damaged_damage_mod_laser' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_artifact_damaged_damage_mod_laser', quantity=1, attributeflags=524292, categoryflags=50661135, options='#moduleFlag=i8#tier=$tierlevel_t0', 
                note='', enabled=1, volume=0.5, mass=100, hidden='False', health=100, descriptiontoken='def_artifact_damaged_mod_laser_desc', purchasable=1, tiertype=1, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_laser_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.03 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_laser_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_damage_mod_laser' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_artifact_a_damage_mod_laser', quantity=1, attributeflags=524292, categoryflags=50661135, options='#moduleFlag=i8#tier=$tierlevel_t3a', 
                note='', enabled=1, volume=0.5, mass=90, hidden='False', health=100, descriptiontoken='def_artifact_a_mod_laser_desc', purchasable=1, tiertype=3, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_laser_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.075 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_laser_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_damaged_damage_mod_missile' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_artifact_damaged_damage_mod_missile', quantity=1, attributeflags=524292, categoryflags=67438351, options='#moduleFlag=i8#tier=$tierlevel_t0', 
                note='', enabled=1, volume=0.5, mass=100, hidden='False', health=100, descriptiontoken='def_artifact_damaged_damage_mod_missile_desc', purchasable=1, tiertype=1, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_missile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.03 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_missile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_damage_mod_missile' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_artifact_a_damage_mod_missile', quantity=1, attributeflags=524292, categoryflags=67438351, options='#moduleFlag=i8#tier=$tierlevel_t3a', 
                note='', enabled=1, volume=0.5, mass=90, hidden='False', health=100, descriptiontoken='def_artifact_a_damage_mod_missile_desc', purchasable=1, tiertype=3, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_missile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.075 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_missile_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_mining_upgrade_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named3_mining_upgrade_pr', quantity=1, attributeflags=524288, categoryflags=263695, options='#moduleFlag=i8#tier=$tierlevel_t4_pr', 
                note='', enabled=1, volume=0.1, mass=45, hidden='False', health=100, descriptiontoken='def_named_mining_upgrade_desc', purchasable=1, tiertype=2, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'harvesting_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.25 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mining_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.25 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_drillers_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_harvester_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_mining_upgrade_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named2_mining_upgrade_pr', quantity=1, attributeflags=524288, categoryflags=263695, options='#moduleFlag=i8#tier=$tierlevel_t3_pr', 
                note='', enabled=1, volume=0.1, mass=45, hidden='False', health=100, descriptiontoken='def_named_mining_upgrade_desc', purchasable=1, tiertype=2, 
                tierlevel=3 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'harvesting_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.2 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mining_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.2 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_drillers_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_harvester_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_mining_upgrade_pr' ORDER BY definition DESC);
UPDATE entitydefaults Set definitionname='def_named1_mining_upgrade_pr', quantity=1, attributeflags=524288, categoryflags=263695, options='#moduleFlag=i8#tier=$tierlevel_t2_pr', 
                note='', enabled=1, volume=0.1, mass=45, hidden='False', health=100, descriptiontoken='def_named_mining_upgrade_desc', purchasable=1, tiertype=2, 
                tierlevel=2 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'harvesting_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.15 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'mining_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.15 WHERE id =  @aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_drillers_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage_harvester_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;

