USE [perpetuumsa]
GO


--------Reduce HitDispersion Mech bonus; add explosion-size bonus-------

DECLARE @definitionID int;
DECLARE @extensionID int;
DECLARE @aggfieldID int;
DECLARE @chassisbonusID int;


PRINT N'def_legatus_head';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_legatus_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'accuracy_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.01 WHERE id = @chassisbonusID;



PRINT N'def_echelon_head';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_echelon_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'accuracy_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.02 WHERE id = @chassisbonusID;



;
PRINT N'def_locust_head';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_locust_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'accuracy_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.01 WHERE id = @chassisbonusID;




PRINT N'def_kain_head';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'massiveness' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.02 WHERE id = @chassisbonusID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'accuracy_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.01 WHERE id = @chassisbonusID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'explosion_radius_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, -0.01, '', @aggfieldID, 0);


PRINT N'def_kain_head_pr';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_head_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'massiveness' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.02 WHERE id = @chassisbonusID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'accuracy_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.01 WHERE id = @chassisbonusID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'explosion_radius_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, -0.01, '', @aggfieldID, 0);




PRINT N'def_tyrannos_head';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_tyrannos_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'locking_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.03 WHERE id = @chassisbonusID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'accuracy_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.01 WHERE id = @chassisbonusID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'explosion_radius_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, -0.01, '', @aggfieldID, 0);


PRINT N'def_tyrannos_head_pr';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_tyrannos_head_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'locking_time_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.03 WHERE id = @chassisbonusID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'accuracy_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.01 WHERE id = @chassisbonusID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'explosion_radius_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, -0.01, '', @aggfieldID, 0);



PRINT N'def_artemis_head';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'laser_optimal_range_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.02 WHERE id = @chassisbonusID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'accuracy_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.01 WHERE id = @chassisbonusID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'explosion_radius_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, -0.01, '', @aggfieldID, 0);



PRINT N'def_artemis_head_pr';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_combat_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_head_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'laser_optimal_range_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=0.02 WHERE id = @chassisbonusID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'accuracy_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.01 WHERE id = @chassisbonusID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'explosion_radius_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, -0.01, '', @aggfieldID, 0);


GO