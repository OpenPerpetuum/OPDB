USE [perpetuumsa]
GO

DECLARE @definitionID int;
DECLARE @extensionID int;
DECLARE @aggfieldID int;
DECLARE @chassisbonusID int;


PRINT N'def_castel_chassis';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_castel_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'missile_cycle_time_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);
UPDATE chassisbonus SET effectenhancer=0, bonus=0.03 WHERE id = @chassisbonusID;

PRINT N'def_castel_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_castel_chassis_pr' ORDER BY definition DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);
UPDATE chassisbonus SET effectenhancer=0, bonus=0.03 WHERE id = @chassisbonusID;


PRINT N'def_waspish_chassis';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_waspish_chassis' ORDER BY definition DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);
UPDATE chassisbonus SET effectenhancer=0, bonus=0.03 WHERE id = @chassisbonusID;

PRINT N'def_waspish_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_waspish_chassis_pr' ORDER BY definition DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);
UPDATE chassisbonus SET effectenhancer=0, bonus=0.03 WHERE id = @chassisbonusID;


PRINT N'def_tyrannos_chassis';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_tyrannos_chassis' ORDER BY definition DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);
UPDATE chassisbonus SET effectenhancer=0, bonus=0.03 WHERE id = @chassisbonusID;

PRINT N'def_tyrannos_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_tyrannos_chassis_pr' ORDER BY definition DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);
UPDATE chassisbonus SET effectenhancer=0, bonus=0.03 WHERE id = @chassisbonusID;


PRINT N'def_gropho_chassis';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_gropho_chassis' ORDER BY definition DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);
UPDATE chassisbonus SET effectenhancer=0, bonus=0.03 WHERE id = @chassisbonusID;

PRINT N'def_gropho_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_gropho_chassis_pr' ORDER BY definition DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);
UPDATE chassisbonus SET effectenhancer=0, bonus=0.03 WHERE id = @chassisbonusID;

GO