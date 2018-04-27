USE [perpetuumsa]
GO

------------Nuimqol Armor repair 7%->5%-----------

DECLARE @definitionID int;
DECLARE @extensionID int;
DECLARE @aggfieldID int;
DECLARE @chassisbonusID int;

PRINT N'def_yagel_leg';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_nuimqol_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_yagel_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);
UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;

PRINT N'def_yagel_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_yagel_leg_pr' ORDER BY definition DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);
UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;


PRINT N'def_cameleon_leg';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_leg' ORDER BY definition DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);
UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;

PRINT N'def_cameleon_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_leg_pr' ORDER BY definition DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);
UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;


PRINT N'def_arbalest_leg';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_arbalest_leg' ORDER BY definition DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);
UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;

PRINT N'def_arbalest_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_arbalest_leg_pr' ORDER BY definition DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);
UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;


PRINT N'def_kain_leg';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_leg' ORDER BY definition DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);
UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;

PRINT N'def_kain_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_leg_pr' ORDER BY definition DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);
UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;


PRINT N'def_vagabond_leg';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vagabond_leg' ORDER BY definition DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);
UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;

PRINT N'def_vagabond_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vagabond_leg_pr' ORDER BY definition DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);
UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;


PRINT N'def_mesmer_leg';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_leg' ORDER BY definition DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);
UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;

PRINT N'def_mesmer_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_leg_pr' ORDER BY definition DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);
UPDATE chassisbonus SET effectenhancer=0, bonus=0.05 WHERE id = @chassisbonusID;

GO
