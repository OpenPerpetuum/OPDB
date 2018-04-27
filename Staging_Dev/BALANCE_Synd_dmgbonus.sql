USE [perpetuumsa]
GO



-------------Syndicate dmg inc 3->5%---------


DECLARE @definitionID int;
DECLARE @extensionID int;
DECLARE @aggfieldID int;
DECLARE @chassisbonusID int;

PRINT N'def_legatus_chassis';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_legatus_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_medium_projectile_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);
UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;


PRINT N'def_callisto_chassis';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_callisto_chassis' ORDER BY definition DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);
UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;


PRINT N'def_echelon_chassis';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_echelon_chassis' ORDER BY definition DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);
UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;


PRINT N'def_locust_chassis';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_locust_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_projectile_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);
UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;


PRINT N'def_helix_chassis';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_helix_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'damage_small_projectile_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);
UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;


PRINT N'def_vektor_chassis';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vektor_chassis' ORDER BY definition DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);
UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;

GO
