USE [perpetuumsa]
GO

-----------------------------------------------------------------
--ChassisBonus: Balance bug fix for falloff modifiers on syndicates
--Bug: Wrong falloff aggfield
--Updates 4 records
--Date: 2019/07/13
-----------------------------------------------------------------


DECLARE @definitionID int;
DECLARE @extensionID int;
DECLARE @newAggfieldID int;
DECLARE @oldAggfieldID int;

--The mistake: Falloff was not correct type of falloff
SET @oldAggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'falloff_modifier' ORDER BY [name] DESC);
SET @newAggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'projectile_falloff_modifier' ORDER BY [name] DESC);

--Legatus
PRINT N'Heavy/mech skill: ext_heavyarmored_unit_piloting';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');

PRINT N'Chassis def: def_legatus_chassis';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_legatus_chassis' ORDER BY definition DESC);

PRINT N'fix bonus effect field';
UPDATE chassisbonus SET 
targetpropertyID=@newAggfieldID
WHERE extension=@extensionID
AND definition=@definitionID
AND targetpropertyID=@oldAggfieldID;


--Echelon
PRINT N'Chassis def: def_echelon_chassis';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_echelon_chassis' ORDER BY definition DESC);

PRINT N'fix bonus effect field';
UPDATE chassisbonus SET 
targetpropertyID=@newAggfieldID
WHERE extension=@extensionID
AND definition=@definitionID
AND targetpropertyID=@oldAggfieldID;



--Locust
PRINT N'Light/assault skill: ext_lightarmored_unit_piloting';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');

PRINT N'Chassis def: def_locust_chassis';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_locust_chassis' ORDER BY definition DESC);

PRINT N'fix bonus effect field';
UPDATE chassisbonus SET 
targetpropertyID=@newAggfieldID
WHERE extension=@extensionID
AND definition=@definitionID
AND targetpropertyID=@oldAggfieldID;


--Vektor
PRINT N'Chassis def: def_vektor_chassis';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vektor_chassis' ORDER BY definition DESC);

PRINT N'fix bonus effect field';
UPDATE chassisbonus SET 
targetpropertyID=@newAggfieldID
WHERE extension=@extensionID
AND definition=@definitionID
AND targetpropertyID=@oldAggfieldID;

GO