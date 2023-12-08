USE [perpetuumsa]
GO

------------------------------------------------------
--Ammo changes
--Buff Machete toxic dmg, change interference emitter size
--Last modified Date: 2023/05/12
------------------------------------------------------

DECLARE @aggvalueID INT;
DECLARE @smallToxicAmmo INT;
DECLARE @medToxicAmmo INT;
DECLARE @toxicDmg INT;
DECLARE @smallToxicDamage INT;
DECLARE @medToxicDamage INT;

DECLARE @emitterA INT;
DECLARE @emitterB INT;
DECLARE @emitterSize INT;

SET @smallToxicAmmo = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_small_projectile_t' ORDER BY definition DESC);
SET @medToxicAmmo = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_medium_projectile_t' ORDER BY definition DESC);
SET @toxicDmg = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_toxic' ORDER BY [name] DESC);
SET @smallToxicDamage = 40;
SET @medToxicDamage = 80;

SET @emitterA = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_blob_emission_ammo_a' ORDER BY definition DESC);
SET @emitterB = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_blob_emission_ammo_b' ORDER BY definition DESC);
SET @emitterSize = 0.2;

SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @smallToxicAmmo AND [field]=@toxicDmg ORDER BY definition DESC);
UPDATE [dbo].[aggregatevalues] 
SET [value]= @smallToxicDamage 
WHERE id = @aggvalueID;

SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @medToxicAmmo AND [field]=@toxicDmg ORDER BY definition DESC);
UPDATE [dbo].[aggregatevalues]
SET [value]= @medToxicDamage
WHERE id = @aggvalueID;

UPDATE [dbo].[entitydefaults]
SET [volume]= @emitterSize
where definition=@emitterA;

UPDATE [dbo].[entitydefaults]
SET [volume]= @emitterSize
where definition=@emitterB;

PRINT N'Machete and Emitter ammo changes applied';
GO








