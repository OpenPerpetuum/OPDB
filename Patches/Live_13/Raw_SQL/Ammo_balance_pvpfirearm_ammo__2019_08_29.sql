USE [perpetuumsa]
GO


--------------------------
--Syndicate PVP Ammo rebalance
--Flechette 
--small 24dmg -> 18dmg, med 48->36
---70% falloff -> +25% optimal
--Date: 2019/08/29
--------------------------

PRINT N'Small ammo';
DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_small_projectile_rewb' ORDER BY definition DESC);

UPDATE entitydefaults SET
options='#damageChemical=f0.00
#damageKinetic=f6.00
#damageExplosive=f6.00
#damageThermal=f6.00
#optimalRangeModifier=f1.00
#explosion_radius=f0
#bullettime=f25.0'
WHERE definition=@definitionID;

PRINT N'updates'
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_explosive' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=6 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_kinetic' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=6 WHERE id =  @aggvalueID;

PRINT N'inserts'
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'optimal_range_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.25);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_thermal' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 6);

PRINT N'delete'
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'falloff_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;





PRINT N'Medium ammo';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_medium_projectile_rewb' ORDER BY definition DESC);

UPDATE entitydefaults SET
options='#damageChemical=f0.00
#damageKinetic=f12.00
#damageExplosive=f12.00
#damageThermal=f0.00
#optimalRangeModifier=f1.00
#explosion_radius=f0
#bullettime=f30.0'
WHERE definition=@definitionID;


PRINT N'updates'
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_explosive' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_kinetic' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12 WHERE id =  @aggvalueID;

PRINT N'inserts'
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_thermal' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 12);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'optimal_range' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2.5);

PRINT N'delete'
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'falloff_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
DELETE FROM [dbo].[aggregatevalues] WHERE id=@aggvalueID;

GO
