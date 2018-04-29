USE [perpetuumsa]
GO


PRINT N'THELO BONUS ADJ: OPTIMAL 1->2%, LASER-ACCU -2%->-3%';

DECLARE @definitionID int;
DECLARE @extensionID int;
DECLARE @aggfieldID int;
DECLARE @chassisbonusID int;


-----------THELO BONUS ADJ: OPTIMAL 1->2%, LASER-ACCU -2%->-3%------

PRINT N'def_prometheus_chassis';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_laser_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.03 WHERE id = @chassisbonusID;


PRINT N'def_baphomet_head';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_baphomet_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'laser_optimal_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.02 WHERE id = @chassisbonusID;


PRINT N'def_baphomet_chassis';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_baphomet_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_laser_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.03 WHERE id = @chassisbonusID;


PRINT N'def_artemis_head';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'laser_optimal_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.02 WHERE id = @chassisbonusID;


PRINT N'def_artemis_chassis';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_laser_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.03 WHERE id = @chassisbonusID;


PRINT N'def_seth_head';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_seth_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'laser_optimal_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.02 WHERE id = @chassisbonusID;


PRINT N'def_seth_chassis';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_seth_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_laser_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.03 WHERE id = @chassisbonusID;



-------------PROTOTYPES--------------------

PRINT N'def_prometheus_chassis';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_chassis_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_laser_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.03 WHERE id = @chassisbonusID;


PRINT N'def_baphomet_head_pr';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_baphomet_head_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'laser_optimal_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.02 WHERE id = @chassisbonusID;


PRINT N'def_baphomet_chassis_pr';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_baphomet_chassis_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_laser_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.03 WHERE id = @chassisbonusID;


PRINT N'def_artemis_head_pr';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_head_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'laser_optimal_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.02 WHERE id = @chassisbonusID;


PRINT N'def_artemis_chassis_pr';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_chassis_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_laser_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.03 WHERE id = @chassisbonusID;


PRINT N'def_seth_head_pr';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_seth_head_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'laser_optimal_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.02 WHERE id = @chassisbonusID;


PRINT N'def_seth_chassis_pr';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_seth_chassis_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_laser_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.03 WHERE id = @chassisbonusID;

GO