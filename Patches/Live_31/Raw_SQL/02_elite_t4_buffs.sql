
----12/18/2023 T4+ Buff

--T4+ ECCM Zone 70

DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_70_eccm' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_elitet4_70_eccm', quantity=1, attributeflags=524288, categoryflags=263439, options='#moduleFlag=i8#tier=$tierlevel_t4+', 
                note='elite module', enabled=1, volume=0.5, mass=75, hidden=0, health=100, descriptiontoken='def_elitet4_70_eccm_desc', purchasable=1, tiertype=3, 
                tierlevel=4 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=24 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=16 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'sensor_strength_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=78 WHERE id =  @aggvalueID;

--T4+ Med Inject Zone 70

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_70_medium_core_booster' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_elitet4_70_medium_core_booster', quantity=1, attributeflags=344084, categoryflags=34145039, options='#moduleFlag=i20#ammoCapacity=i11#ammoType=L70a#tier=$tierlevel_t4+', 
                note='elite module', enabled=1, volume=1, mass=150, hidden=0, health=100, descriptiontoken='def_elitet4_70_medium_core_booster_desc', purchasable=1, tiertype=3, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=26 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=285 WHERE id =  @aggvalueID;

--T4+ Med Shield Zone 70

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_70_medium_shield_generator' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_elitet4_70_medium_shield_generator', quantity=1, attributeflags=82200, categoryflags=33620495, options='#moduleFlag=i20#tier=$tierlevel_t4+', 
                note='elite module', enabled=1, volume=0.5, mass=352.50, hidden=0, health=100, descriptiontoken='def_elitet4_70_medium_shield_generator_desc', purchasable=1, tiertype=3, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=10.0 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=67 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=271 WHERE id =  @aggvalueID;

--T4+ Sensor amp Zone 70

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_70_sensor_booster' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_elitet4_70_sensor_booster', quantity=1, attributeflags=16656, categoryflags=66575, options='#moduleFlag=i8#tier=$tierlevel_t4+', 
                note='elite module', enabled=1, volume=0.5, mass=75, hidden=0, health=100, descriptiontoken='def_elitet4_70_sensor_booster_desc', purchasable=1, tiertype=3, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=10 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=18 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'effect_sensor_booster_locking_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.65 WHERE id =  @aggvalueID;

--T4+ Small Inject Zone 70

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_70_small_core_booster' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_elitet4_70_small_core_booster', quantity=1, attributeflags=311316, categoryflags=17367823, options='#moduleFlag=i20#ammoCapacity=i11#ammoType=L70a#tier=$tierlevel_t4+', 
                note='elite module', enabled=1, volume=0.5, mass=75, hidden=0, health=100, descriptiontoken='def_elitet4_70_small_core_booster_desc', purchasable=1, tiertype=3, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=21 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=57 WHERE id =  @aggvalueID;

--T4+ Small Shield Zone 70

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_70_small_shield_generator' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_elitet4_70_small_shield_generator', quantity=1, attributeflags=49432, categoryflags=16843279, options='#moduleFlag=i20#tier=$tierlevel_t4+', 
                note='elite module', enabled=1, volume=0.3, mass=172.5, hidden=0, health=100, descriptiontoken='def_elitet4_70_small_shield_generator_desc', purchasable=1, tiertype=3, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=48 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=54 WHERE id =  @aggvalueID;

--T4+ Range Extender Zone 70

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_70_tracking_upgrade' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_elitet4_70_tracking_upgrade', quantity=1, attributeflags=524288, categoryflags=459791, options='#moduleFlag=i8#tier=$tierlevel_t4+', 
                note='elite module', enabled=1, volume=0.1, mass=37.50, hidden=0, health=100, descriptiontoken='def_elitet4_70_tracking_upgrade_desc', purchasable=1, tiertype=3, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=38 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=119 WHERE id =  @aggvalueID;

--T4+ Demob Zone 70

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_70_webber' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_elitet4_70_webber', quantity=1, attributeflags=720, categoryflags=16844047, options='#moduleFlag=i8#tier=$tierlevel_t4+', 
                note='elite module', enabled=1, volume=0.5, mass=75, hidden=0, health=100, descriptiontoken='def_elitet4_70_webber_desc', purchasable=1, tiertype=3, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=18 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=48 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=15 WHERE id =  @aggvalueID;

-- T4+ Light Weight Frame Zone 71

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_71_maneuvering_upgrade' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_elitet4_71_maneuvering_upgrade', quantity=1, attributeflags=524300, categoryflags=656143, options='#moduleFlag=i20#tier=$tierlevel_t4+', 
                note='elite module', enabled=1, volume=0.5, mass=25, hidden=0, health=100, descriptiontoken='def_elitet4_71_maneuvering_upgrade_desc', purchasable=1, tiertype=3, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=27 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=26 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'signature_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=-1.20 WHERE id =  @aggvalueID;

-- T4+ Medium Shield Zone 71

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_71_medium_shield_generator' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_elitet4_71_medium_shield_generator', quantity=1, attributeflags=82200, categoryflags=33620495, options='#moduleFlag=i20#tier=$tierlevel_t4+', 
                note='elite module', enabled=1, volume=0.5, mass=352.50, hidden=0, health=100, descriptiontoken='def_elitet4_71_medium_shield_generator_desc', purchasable=1, tiertype=3, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=10.0 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=67 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=271 WHERE id =  @aggvalueID;

-- T4+ Geoscanner Zone 71

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_71_mining_probe_module' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_elitet4_71_mining_probe_module', quantity=1, attributeflags=2359320, categoryflags=329231, options='#moduleFlag=i8#ammoCapacity=ia#ammoType=L90a#tier=$tierlevel_t4+', 
                note='elite module', enabled=1, volume=0.5, mass=150, hidden=0, health=100, descriptiontoken='def_elitet4_71_mining_probe_module_desc', purchasable=1, tiertype=3, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=81 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=57 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=50 WHERE id =  @aggvalueID;

-- T4+ Small Shield Zone 71

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_71_small_shield_generator' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_elitet4_71_small_shield_generator', quantity=1, attributeflags=49432, categoryflags=16843279, options='#moduleFlag=i20#tier=$tierlevel_t4+', 
                note='elite module', enabled=1, volume=0.3, mass=172.50, hidden=0, health=100, descriptiontoken='def_elitet4_71_small_shield_generator_desc', purchasable=1, tiertype=3, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=48 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=54 WHERE id =  @aggvalueID;

-- T4+ firearm tuning Zone 72

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_72_damage_mod_projectile' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_elitet4_72_damage_mod_projectile', quantity=1, attributeflags=524292, categoryflags=33883919, options='#moduleFlag=i8#tier=$tierlevel_t4+', 
                note='elite module', enabled=1, volume=0.5, mass=100, hidden=0, health=100, descriptiontoken='def_elitet4_72_damage_mod_projectile_desc', purchasable=1, tiertype=3, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=15 WHERE id =  @aggvalueID;

-- T4+ Evasive Module

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_72_mass_reductor' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_elitet4_72_mass_reductor', quantity=1, attributeflags=524320, categoryflags=327951, options='#moduleFlag=i20#tier=$tierlevel_t4+', 
                note='elite module', enabled=1, volume=0.5, mass=1.5, hidden=0, health=100, descriptiontoken='def_elitet4_72_mass_reductor_desc', purchasable=1, tiertype=3, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.745 WHERE id =  @aggvalueID;

-----------------------------------------------------------------

-- Gamma Weapon modules

-- T4+ Med Firearms Auto Cannons

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_gamma_longrange_medium_autocannon' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_elitet4_gamma_longrange_medium_autocannon', quantity=1, attributeflags=336592, categoryflags=8657176335, options='#moduleFlag=i91#ammoCapacity=ib4#ammoType=L2030a#tier=$tierlevel_t4+', 
                note='elite module', enabled=1, volume=1.2, mass=715, hidden=0, health=100, descriptiontoken='def_elitet4_gamma_longrange_medium_autocannon_desc', purchasable=1, tiertype=3, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=13 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=143 WHERE id =  @aggvalueID;

-- T4+ Med Firearms Machine Guns

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_gamma_medium_autocannon' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_elitet4_gamma_medium_autocannon', quantity=1, attributeflags=336592, categoryflags=8657176335, options='#moduleFlag=i91#ammoCapacity=if0#ammoType=L2030a#tier=$tierlevel_t4+', 
                note='elite module', enabled=1, volume=1.2, mass=550, hidden=0, health=100, descriptiontoken='def_elitet4_gamma_medium_autocannon_desc', purchasable=1, tiertype=3, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12.0 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=133 WHERE id =  @aggvalueID;

-- T4+ Small Firearms

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_gamma_small_autocannon' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_elitet4_gamma_small_autocannon', quantity=1, attributeflags=303824, categoryflags=4362209039, options='#moduleFlag=i51#ammoCapacity=if0#ammoType=L1030a#tier=$tierlevel_t4+', 
                note='elite module', enabled=1, volume=0.6, mass=275, hidden=0, health=100, descriptiontoken='def_elitet4_gamma_small_autocannon_desc', purchasable=1, tiertype=3, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=17 WHERE id =  @aggvalueID;

-- T4+ Med Long range laser

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_gamma_longrange_medium_laser' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_elitet4_gamma_longrange_medium_laser', quantity=1, attributeflags=336592, categoryflags=33621775, options='#moduleFlag=i91#ammoCapacity=i91#ammoType=L2020a#tier=$tierlevel_t4+', 
                note='elite module', enabled=1, volume=1, mass=715, hidden=0, health=100, descriptiontoken='def_elitet4_gamma_longrange_medium_laser_desc', purchasable=1, tiertype=3, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=21.60 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=33 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=238 WHERE id =  @aggvalueID;

-- T4+ Short med lasers

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_gamma_medium_laser' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_elitet4_gamma_medium_laser', quantity=1, attributeflags=336592, categoryflags=33621775, options='#moduleFlag=i91#ammoCapacity=i6e#ammoType=L2020a#tier=$tierlevel_t4+', 
                note='elite module', enabled=1, volume=1, mass=550, hidden=0, health=100, descriptiontoken='def_elitet4_gamma_medium_laser_desc', purchasable=1, tiertype=3, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=17.60 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=29 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=238 WHERE id =  @aggvalueID;

-- T4+ Small Lasers

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_gamma_small_laser' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_elitet4_gamma_small_laser', quantity=1, attributeflags=303824, categoryflags=16844559, options='#moduleFlag=i51#ammoCapacity=i6e#ammoType=L1020a#tier=$tierlevel_t4+', 
                note='elite module', enabled=1, volume=0.5, mass=275, hidden=0, health=100, descriptiontoken='def_elitet4_gamma_small_laser_desc', purchasable=1, tiertype=3, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=21 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=42 WHERE id =  @aggvalueID;

-- T4+ med EM Guns

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_gamma_longrange_medium_railgun' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_elitet4_gamma_longrange_medium_railgun', quantity=1, attributeflags=336592, categoryflags=33818383, options='#moduleFlag=i91#ammoCapacity=i3c#ammoType=L2010a#tier=$tierlevel_t4+', 
                note='elite module', enabled=1, volume=1, mass=715, hidden=0, health=100, descriptiontoken='def_elitet4_gamma_longrange_medium_railgun_desc', purchasable=1, tiertype=3, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=43 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=190 WHERE id =  @aggvalueID;

-- T4+ Med Gauss guns

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_gamma_medium_railgun' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_elitet4_gamma_medium_railgun', quantity=1, attributeflags=336592, categoryflags=33818383, options='#moduleFlag=i91#ammoCapacity=i19#ammoType=L2010a#tier=$tierlevel_t4+', 
                note='elite module', enabled=1, volume=1, mass=550, hidden=0, health=100, descriptiontoken='def_elitet4_gamma_medium_railgun_desc', purchasable=1, tiertype=3, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=18.00 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=36 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=171 WHERE id =  @aggvalueID;

-- T4+ Small Rail gun

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_gamma_small_railgun' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_elitet4_gamma_small_railgun', quantity=1, attributeflags=303824, categoryflags=17041167, options='#moduleFlag=i51#ammoCapacity=i37#ammoType=L1010a#tier=$tierlevel_t4+', 
                note='elite module', enabled=1, volume=0.5, mass=275, hidden=0, health=100, descriptiontoken='def_elitet4_gamma_small_railgun_desc', purchasable=1, tiertype=3, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=29 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=35 WHERE id =  @aggvalueID;

-- T4+ small missles

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_gamma_rocket_launcher' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_elitet4_gamma_rocket_launcher', quantity=1, attributeflags=303824, categoryflags=16975631, options='#moduleFlag=i52#ammoCapacity=i3c#ammoType=L1040a#tier=$tierlevel_t4+', 
                note='elite module', enabled=1, volume=1, mass=275, hidden=0, health=100, descriptiontoken='def_elitet4_gamma_rocket_launcher_desc', purchasable=1, tiertype=3, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=32 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=28 WHERE id =  @aggvalueID;

-- T4+ Medium Missles

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_gamma_missile_launcher' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_elitet4_gamma_missile_launcher', quantity=1, attributeflags=336592, categoryflags=33752847, options='#moduleFlag=i92#ammoCapacity=i3c#ammoType=L2040a#tier=$tierlevel_t4+', 
                note='elite module', enabled=1, volume=2, mass=550, hidden=0, health=100, descriptiontoken='def_elitet4_gamma_missile_launcher_desc', purchasable=1, tiertype=3, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=43 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=162 WHERE id =  @aggvalueID;


-- T4+ Small Miner

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_gamma_small_driller' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_elitet4_gamma_small_driller', quantity=1, attributeflags=294928, categoryflags=16844303, options='#moduleFlag=i250#ammoCapacity=i37#ammoType=L50a#tier=$tierlevel_t4+', 
                note='elite module', enabled=1, volume=1, mass=300, hidden=0, health=100, descriptiontoken='def_elitet4_gamma_small_driller_desc', purchasable=1, tiertype=3, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=20 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=43 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=31 WHERE id =  @aggvalueID;

-- T4+ Medium Miner

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_gamma_medium_driller' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_elitet4_gamma_medium_driller', quantity=1, attributeflags=327696, categoryflags=33621519, options='#moduleFlag=i290#ammoCapacity=i37#ammoType=L50a#tier=$tierlevel_t4+', 
                note='elite module', enabled=1, volume=1.5, mass=750, hidden=0, health=100, descriptiontoken='def_elitet4_gamma_medium_driller_desc', purchasable=1, tiertype=3, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=52 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=162 WHERE id =  @aggvalueID;

-- T4+ Small Harvester

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_gamma_small_harvester' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_elitet4_gamma_small_harvester', quantity=1, attributeflags=294928, categoryflags=17171983, options='#moduleFlag=i250#ammoCapacity=i37#ammoType=La0a#tier=$tierlevel_t4+', 
                note='elite module', enabled=1, volume=1, mass=300, hidden=0, health=100, descriptiontoken='def_elitet4_gamma_small_harvester_desc', purchasable=1, tiertype=3, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=20 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=42 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=31 WHERE id =  @aggvalueID;

-- T4+ Harvesters

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_gamma_medium_harvester' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_elitet4_gamma_medium_harvester', quantity=1, attributeflags=327696, categoryflags=33949199, options='#moduleFlag=i290#ammoCapacity=i37#ammoType=La0a#tier=$tierlevel_t4+', 
                note='elite module', enabled=1, volume=1.5, mass=750, hidden=0, health=100, descriptiontoken='def_elitet4_gamma_medium_harvester_desc', purchasable=1, tiertype=3, 
                tierlevel=4 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=52 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=150 WHERE id =  @aggvalueID;