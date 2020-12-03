USE [perpetuumsa]
GO

PRINT N'ADDING ENVIRONMENTAL EFFECTS';

-----------------------------------------------------
-- Insert new effects, effcat, and modifiers
-- Note: hard-coded values must match enums in server!
-- Date Modified: 11/29/2020
-----------------------------------------------------

DROP TABLE IF EXISTS #EFFS;
CREATE TABLE #EFFS 
(
	effId INT,
	effName VARCHAR(100)
);

DROP TABLE IF EXISTS #EFFECTMODS;
CREATE TABLE #EFFECTMODS 
(
	effId INT,
	fieldName VARCHAR(100),
	fieldValue FLOAT
);

DECLARE @effectCatName AS VARCHAR(100) = 'effcat_environmental_effects';
DECLARE @effectDayName  AS VARCHAR(100) = 'effect_day';
DECLARE @effectDayClearName  AS VARCHAR(100) = 'effect_day_clear';
DECLARE @effectDayOvercastName  AS VARCHAR(100) = 'effect_day_overcast';
DECLARE @effectNightName  AS VARCHAR(100) = 'effect_night';
DECLARE @effectNightClearName  AS VARCHAR(100) = 'effect_night_clear';
DECLARE @effectNightOvercastName  AS VARCHAR(100) = 'effect_night_overcast';
DECLARE @effectGoodWeatherName  AS VARCHAR(100) = 'effect_weather_good';
DECLARE @effectBadWeatherName  AS VARCHAR(100) = 'effect_weather_bad';

DECLARE @effectDayId AS INT = 107;
DECLARE @effectDayClearId AS INT = 108;
DECLARE @effectDayOvercastId  AS INT = 109;
DECLARE @effectNightId  AS INT = 110;
DECLARE @effectNightClearId  AS INT = 111;
DECLARE @effectNightOvercastId  AS INT = 112;
DECLARE @effectGoodWeatherId  AS INT = 113;
DECLARE @effectBadWeatherId  AS INT = 114;

DECLARE @effCatPower AS INT = 45;

INSERT INTO #EFFECTMODS (effId, fieldName, fieldValue) VALUES
(@effectDayId, 'effect_stealth_strength_modifier', -2),
(@effectNightId, 'effect_stealth_strength_modifier', 2),

(@effectGoodWeatherId, 'effect_detection_strength_modifier', 2),
(@effectBadWeatherId, 'effect_detection_strength_modifier', -2),

(@effectDayClearId, 'effect_detection_strength_modifier', 2),
(@effectDayClearId, 'effect_stealth_strength_modifier', -2),
(@effectDayOvercastId, 'effect_detection_strength_modifier', -2),
(@effectDayOvercastId, 'effect_stealth_strength_modifier', -2),

(@effectNightClearId, 'effect_detection_strength_modifier', 2),
(@effectNightClearId, 'effect_stealth_strength_modifier', 2),
(@effectNightOvercastId, 'effect_detection_strength_modifier', -2),
(@effectNightOvercastId, 'effect_stealth_strength_modifier', 2);

INSERT INTO #EFFS (effId, effName) VALUES
(@effectDayId, @effectDayName),
(@effectDayClearId, @effectDayClearName),
(@effectDayOvercastId, @effectDayOvercastName),
(@effectNightId, @effectNightName),
(@effectNightClearId, @effectNightClearName),
(@effectNightOvercastId, @effectNightOvercastName),
(@effectGoodWeatherId, @effectGoodWeatherName),
(@effectBadWeatherId, @effectBadWeatherName);

DELETE FROM effectdefaultmodifiers WHERE effectid IN (SELECT effId FROM #EFFS);
DELETE FROM effects WHERE id IN (SELECT effId FROM #EFFS);
DELETE FROM effectcategories WHERE flag>=@effCatPower;

INSERT INTO effectcategories (name, flag, maxlevel, note) VALUES
(@effectCatName, @effCatPower, 1, 'dynamic zone environmental effects');

DECLARE @catFlag BIGINT;
SET @catFlag = POWER(CAST(2 AS BIGINT), (SELECT TOP 1 CAST(flag AS BIGINT) FROM effectcategories WHERE name=@effectCatName));

SET IDENTITY_INSERT effects ON;

INSERT INTO effects (id, effectcategory, duration, name, description, note, isaura, auraradius, ispositive, display, saveable)
SELECT effId, @catFlag, 0, effName, effName+'_desc', 'environ effects', 1, 0, 1, 1, 0
FROM #EFFS;

SET IDENTITY_INSERT effects OFF;

INSERT INTO effectdefaultmodifiers (effectid, field, value)
SELECT effId, (SELECT TOP 1 id FROM aggregatefields WHERE name=fieldName), fieldValue
FROM #EFFECTMODS;


DROP TABLE IF EXISTS #EFFECTMODS;
DROP TABLE IF EXISTS #EFFS;
GO