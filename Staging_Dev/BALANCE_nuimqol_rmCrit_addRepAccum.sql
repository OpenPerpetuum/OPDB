USE [perpetuumsa]
GO


------------Nuimqol: remove crit, reduce armor repair--------


DECLARE @definitionID int;
DECLARE @extensionID int;
DECLARE @aggfieldID int;
DECLARE @chassisbonusID int;


PRINT N'def_mesmer_chassis';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_armor_repair_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, -0.01, '', @aggfieldID, 0);


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

PRINT N'def_mesmer_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_chassis_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_armor_repair_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, -0.01, '', @aggfieldID, 0);


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;




PRINT N'def_kain_chassis';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_armor_repair_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, -0.01, '', @aggfieldID, 0);


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

PRINT N'def_kain_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_chassis_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_armor_repair_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, -0.01, '', @aggfieldID, 0);


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;




PRINT N'def_arbalest_chassis_';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_arbalest_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_armor_repair_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, -0.01, '', @aggfieldID, 0);


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;

PRINT N'def_arbalest_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_arbalest_chassis_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_armor_repair_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, -0.01, '', @aggfieldID, 0);


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;





PRINT N'def_yagel_chassis';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_yagel_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_armor_repair_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, -0.01, '', @aggfieldID, 0);


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;


PRINT N'def_yagel_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_yagel_chassis_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_usage_armor_repair_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, -0.01, '', @aggfieldID, 0);


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

DELETE [dbo].[chassisbonus] WHERE id=@chassisbonusID;


GO
