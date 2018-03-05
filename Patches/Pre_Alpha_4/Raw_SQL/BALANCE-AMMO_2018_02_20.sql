USE [perpetuumsa]
GO

PRINT N'Ammo Balance 2018-02-20';

DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_small_projectile_a' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_ammo_small_projectile_a', quantity=1000, attributeflags=34816, categoryflags=66314, options='#damageChemical=f0.00
#damageKinetic=f6.00
#damageExplosive=f6.00
#damageThermal=f0.00
#optimalRangeModifier=f1.00
#explosion_radius=f0
#bullettime=f45.0', 
                note='', enabled=1, volume=0.5, mass=0.1, hidden='False', health=100, descriptiontoken='def_ammo_projectile_a_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_explosive' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=6 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_kinetic' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12 WHERE id =  @aggvalueID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_small_projectile_b' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_ammo_small_projectile_b', quantity=1000, attributeflags=34816, categoryflags=66314, options='#damageChemical=f0.00
#damageKinetic=f6.00
#damageExplosive=f4.00
#damageThermal=f4.00
#optimalRangeModifier=f0.75
#explosion_radius=f0
#bullettime=f45.0', 
                note='', enabled=1, volume=0.5, mass=0.1, hidden='False', health=100, descriptiontoken='def_ammo_projectile_b_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_explosive' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_kinetic' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_thermal' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=10 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_small_projectile_c' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_ammo_small_projectile_c', quantity=1000, attributeflags=34816, categoryflags=66314, options='#damageChemical=f2.00
#damageKinetic=f10.00
#damageExplosive=f2.00
#damageThermal=f4.00
#optimalRangeModifier=f0.50
#explosion_radius=f0
#bullettime=f45.0', 
                note='', enabled=1, volume=0.5, mass=0.1, hidden='False', health=100, descriptiontoken='def_ammo_projectile_c_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_explosive' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_kinetic' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=6 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_chemical' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_thermal' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_small_projectile_d' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_ammo_small_projectile_d', quantity=1000, attributeflags=34816, categoryflags=66314, options='#damageChemical=f6.00
#damageKinetic=f6.00
#damageExplosive=f2.00
#damageThermal=f0.00
#optimalRangeModifier=f0.75
#explosion_radius=f0
#bullettime=f45.0', 
                note='', enabled=1, volume=0.5, mass=0.1, hidden='False', health=100, descriptiontoken='def_ammo_projectile_d_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_chemical' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=6 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_explosive' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=6 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_kinetic' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=6 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'optimal_range_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'optimal_range_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_medium_projectile_a' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_ammo_medium_projectile_a', quantity=1000, attributeflags=67584, categoryflags=131850, options='#damageChemical=f0.00
#damageKinetic=f12.00
#damageExplosive=f12.00
#damageThermal=f0.00
#optimalRangeModifier=f1.00
#explosion_radius=f0
#bullettime=f50.0', 
                note='', enabled=1, volume=1, mass=0.2, hidden='False', health=100, descriptiontoken='def_ammo_projectile_a_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_explosive' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_kinetic' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=24 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_medium_projectile_b' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_ammo_medium_projectile_b', quantity=1000, attributeflags=67584, categoryflags=131850, options='#damageChemical=f0.00
#damageKinetic=f12.00
#damageExplosive=f8.00
#damageThermal=f8.00
#optimalRangeModifier=f0.75
#explosion_radius=f0
#bullettime=f50.0', 
                note='', enabled=1, volume=1, mass=0.2, hidden='False', health=100, descriptiontoken='def_ammo_projectile_b_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_explosive' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=8 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_kinetic' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=8 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_thermal' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=20 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_medium_projectile_c' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_ammo_medium_projectile_c', quantity=1000, attributeflags=67584, categoryflags=131850, options='#damageChemical=f4.00
#damageKinetic=f20.00
#damageExplosive=f4.00
#damageThermal=f8.00
#optimalRangeModifier=f0.50
#explosion_radius=f0
#bullettime=f50.0', 
                note='', enabled=1, volume=1, mass=0.2, hidden='False', health=100, descriptiontoken='def_ammo_projectile_c_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_explosive' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=24 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_kinetic' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_thermal' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_chemical' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_medium_projectile_d' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_ammo_medium_projectile_d', quantity=1000, attributeflags=67584, categoryflags=131850, options='#damageChemical=f12.00
#damageKinetic=f12.00
#damageExplosive=f4.00
#damageThermal=f0.00
#optimalRangeModifier=f0.75
#explosion_radius=f0
#bullettime=f50.0', 
                note='', enabled=1, volume=1, mass=0.2, hidden='False', health=100, descriptiontoken='def_ammo_projectile_d_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_chemical' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_explosive' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_kinetic' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'optimal_range_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_rocket_a' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_ammo_rocket_a', quantity=1000, attributeflags=34816, categoryflags=66570, options='#damageChemical=f0.00
#damageKinetic=f15.00
#damageExplosive=f15.00
#damageThermal=f0.00
#range=f10
#explosion_radius=f4
#bullettime=f15.0', 
                note='', enabled=1, volume=0.5, mass=0.2, hidden='False', health=100, descriptiontoken='def_ammo_rocket_a_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosion_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_rocket_b' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_ammo_rocket_b', quantity=1000, attributeflags=34816, categoryflags=66570, options='#damageChemical=f0.00
#damageKinetic=f0.00
#damageExplosive=f30.00
#damageThermal=f0.00
#range=f10
#explosion_radius=f3
#bullettime=f15.0', 
                note='', enabled=1, volume=0.5, mass=0.2, hidden='False', health=100, descriptiontoken='def_ammo_rocket_b_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosion_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_rocket_c' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_ammo_rocket_c', quantity=1000, attributeflags=34816, categoryflags=66570, options='#damageChemical=f0.00
#damageKinetic=f0.00
#damageExplosive=f15.00
#damageThermal=f15.00
#range=f10
#explosion_radius=f4
#bullettime=f15.0', 
                note='', enabled=1, volume=0.5, mass=0.2, hidden='False', health=100, descriptiontoken='def_ammo_rocket_c_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosion_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_rocket_d' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_ammo_rocket_d', quantity=1000, attributeflags=34816, categoryflags=66570, options='#damageChemical=f15.00
#damageKinetic=f0.00
#damageExplosive=f15.00
#damageThermal=f0.00
#range=f10
#explosion_radius=f4
#bullettime=f15.0', 
                note='', enabled=1, volume=0.5, mass=0.2, hidden='False', health=100, descriptiontoken='def_ammo_rocket_d_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosion_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_missile_b' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_ammo_missile_b', quantity=1000, attributeflags=67584, categoryflags=132106, options='#damageChemical=f0.00
#damageKinetic=f0.00
#damageExplosive=f90.00
#damageThermal=f0.00
#range=f25
#explosion_radius=f8
#bullettime=f15.0', 
                note='', enabled=1, volume=1, mass=0.4, hidden='False', health=100, descriptiontoken='def_ammo_missile_b_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosion_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_missile_a' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_ammo_missile_a', quantity=1000, attributeflags=67584, categoryflags=132106, options='#damageChemical=f0.00
#damageKinetic=f45.00
#damageExplosive=f45.00
#damageThermal=f0.00
#range=f25
#explosion_radius=f10
#bullettime=f15.0', 
                note='500 * 0.002 => 1 Volume!!!!', enabled=1, volume=1, mass=0.4, hidden='False', health=100, descriptiontoken='def_ammo_missile_a_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosion_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_missile_c' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_ammo_missile_c', quantity=1000, attributeflags=67584, categoryflags=132106, options='#damageChemical=f0.00
#damageKinetic=f0.00
#damageExplosive=f45.00
#damageThermal=f45.00
#range=f25
#explosion_radius=f10
#bullettime=f15.0', 
                note='', enabled=1, volume=1, mass=0.4, hidden='False', health=100, descriptiontoken='def_ammo_missile_c_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosion_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_missile_d' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_ammo_missile_d', quantity=1000, attributeflags=67584, categoryflags=132106, options='#damageChemical=f45.00
#damageKinetic=f.00
#damageExplosive=f45.00
#damageThermal=f0.00
#range=f25
#explosion_radius=f10
#bullettime=f15.0', 
                note='', enabled=1, volume=1, mass=0.4, hidden='False', health=100, descriptiontoken='def_ammo_missile_d_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosion_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_longrange_missile_a' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_ammo_longrange_missile_a', quantity=1000, attributeflags=67584, categoryflags=132106, options='#damageChemical=f0.00
#damageKinetic=f45.00
#damageExplosive=f45.00
#damageThermal=f0.00
#range=f25
#explosion_radius=f10
#bullettime=f15.0', 
                note='500 * 0.002 => 1 Volume!!!!', enabled=1, volume=1, mass=0.4, hidden='False', health=100, descriptiontoken='def_ammo_longrange_missile_a_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosion_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=13 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_longrange_missile_b' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_ammo_longrange_missile_b', quantity=1000, attributeflags=67584, categoryflags=132106, options='#damageChemical=f0.00
#damageKinetic=f45.00
#damageExplosive=f45.00
#damageThermal=f0.00
#range=f25
#explosion_radius=f10
#bullettime=f15.0', 
                note='500 * 0.002 => 1 Volume!!!!', enabled=1, volume=1, mass=0.4, hidden='False', health=100, descriptiontoken='def_ammo_longrange_missile_b_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosion_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=13 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_longrange_missile_c' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_ammo_longrange_missile_c', quantity=1000, attributeflags=67584, categoryflags=132106, options='#damageChemical=f0.00
#damageKinetic=f45.00
#damageExplosive=f45.00
#damageThermal=f0.00
#range=f25
#explosion_radius=f10
#bullettime=f15.0', 
                note='500 * 0.002 => 1 Volume!!!!', enabled=1, volume=1, mass=0.4, hidden='False', health=100, descriptiontoken='def_ammo_longrange_missile_c_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosion_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=13 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_longrange_missile_d' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_ammo_longrange_missile_d', quantity=1000, attributeflags=67584, categoryflags=132106, options='#damageChemical=f0.00
#damageKinetic=f45.00
#damageExplosive=f45.00
#damageThermal=f0.00
#range=f25
#explosion_radius=f10
#bullettime=f15.0', 
                note='500 * 0.002 => 1 Volume!!!!', enabled=1, volume=1, mass=0.4, hidden='False', health=100, descriptiontoken='def_ammo_longrange_missile_d_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosion_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=13 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_small_projectile_rewb' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_ammo_small_projectile_rewb', quantity=1000, attributeflags=34816, categoryflags=66314, options='#damageChemical=f0.00
#damageKinetic=f6.00
#damageExplosive=f6.00
#damageThermal=f0.00
#optimalRangeModifier=f1.00
#explosion_radius=f0
#bullettime=f25.0', 
                note='', enabled=1, volume=0.5, mass=0.1, hidden='False', health=100, descriptiontoken='def_ammo_projectile_rewb_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_explosive' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_kinetic' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'falloff_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.3 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_chemical' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_thermal' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_medium_projectile_rewb' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_ammo_medium_projectile_rewb', quantity=1000, attributeflags=67584, categoryflags=131850, options='#damageChemical=f0.00
#damageKinetic=f12.00
#damageExplosive=f12.00
#damageThermal=f0.00
#optimalRangeModifier=f1.00
#explosion_radius=f0
#bullettime=f30.0', 
                note='', enabled=1, volume=1, mass=0.2, hidden='False', health=100, descriptiontoken='def_ammo_projectile_rewb_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_explosive' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=24 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_kinetic' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=24 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'falloff_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.3 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_chemical' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_thermal' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_rocket_rewa' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_ammo_rocket_rewa', quantity=1000, attributeflags=34816, categoryflags=66570, options='#damageChemical=f0.00
#damageKinetic=f15.00
#damageExplosive=f15.00
#damageThermal=f0.00
#range=f10
#explosion_radius=f4
#bullettime=f15.0', 
                note='', enabled=1, volume=0.5, mass=0.2, hidden='False', health=100, descriptiontoken='def_ammo_rocket_rewa_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosion_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_rocket_rewb' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_ammo_rocket_rewb', quantity=1000, attributeflags=34816, categoryflags=66570, options='#damageChemical=f0.00
#damageKinetic=f15.00
#damageExplosive=f15.00
#damageThermal=f0.00
#range=f10
#explosion_radius=f4
#bullettime=f15.0', 
                note='', enabled=1, volume=0.5, mass=0.2, hidden='False', health=100, descriptiontoken='def_ammo_rocket_rewb_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosion_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_missile_rewa' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_ammo_missile_rewa', quantity=1000, attributeflags=67584, categoryflags=132106, options='#damageChemical=f0.00
#damageKinetic=f45.00
#damageExplosive=f45.00
#damageThermal=f0.00
#range=f25
#explosion_radius=f10
#bullettime=f15.0', 
                note='500 * 0.002 => 1 Volume!!!!', enabled=1, volume=1, mass=0.4, hidden='False', health=100, descriptiontoken='def_ammo_missile_rewa_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosion_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_missile_rewb' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_ammo_missile_rewb', quantity=1000, attributeflags=67584, categoryflags=132106, options='#damageChemical=f0.00
#damageKinetic=f45.00
#damageExplosive=f45.00
#damageThermal=f0.00
#range=f25
#explosion_radius=f10
#bullettime=f15.0', 
                note='500 * 0.002 => 1 Volume!!!!', enabled=1, volume=1, mass=0.4, hidden='False', health=100, descriptiontoken='def_ammo_missile_rewb_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosion_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12.5 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_longrange_missile_rewa' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_ammo_longrange_missile_rewa', quantity=1000, attributeflags=67584, categoryflags=132106, options='#damageChemical=f0.00
#damageKinetic=f45.00
#damageExplosive=f45.00
#damageThermal=f0.00
#range=f25
#explosion_radius=f10
#bullettime=f15.0', 
                note='500 * 0.002 => 1 Volume!!!!', enabled=1, volume=1, mass=0.4, hidden='False', health=100, descriptiontoken='def_ammo_longrange_missile_rewa_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosion_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=13 WHERE id =  @aggvalueID;




SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_longrange_missile_rewb' ORDER BY definition DESC);
PRINT @definitionID;

UPDATE entitydefaults Set definitionname='def_ammo_longrange_missile_rewb', quantity=1000, attributeflags=67584, categoryflags=132106, options='#damageChemical=f0.00
#damageKinetic=f45.00
#damageExplosive=f45.00
#damageThermal=f0.00
#range=f25
#explosion_radius=f10
#bullettime=f15.0', 
                note='500 * 0.002 => 1 Volume!!!!', enabled=1, volume=1, mass=0.4, hidden='False', health=100, descriptiontoken='def_ammo_longrange_missile_rewb_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'explosion_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=13 WHERE id =  @aggvalueID;


GO
