USE [perpetuumsa]
GO

-----------------------------------------------------------------
--Target markers signal masking reduction should not be reduced by skill
--
--Date modified: 2020/07/22
-----------------------------------------------------------------

PRINT N'RECORD TO DELETE';
SELECT * FROM modulepropertymodifiers WHERE
categoryflags=(select top 1 value from categoryFlags where name='cf_target_painter') AND
basefield=(SELECT TOP 1 id FROM aggregatefields WHERE name='effect_stealth_strength_modifier') AND
modifierfield=(SELECT TOP 1 id FROM aggregatefields WHERE name='effect_enhancer_stealth_strength_modifier');

PRINT N'DELETE 1 modulepropertymodifiers';
--Delete single modulepropertymodifiers for target painters being modified by signal masker skill bonus field
DELETE FROM modulepropertymodifiers WHERE
categoryflags=(select top 1 value from categoryFlags where name='cf_target_painter') AND
basefield=(SELECT TOP 1 id FROM aggregatefields WHERE name='effect_stealth_strength_modifier') AND
modifierfield=(SELECT TOP 1 id FROM aggregatefields WHERE name='effect_enhancer_stealth_strength_modifier');

GO