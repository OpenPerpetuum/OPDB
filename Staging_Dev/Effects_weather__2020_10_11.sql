USE [perpetuumsa]
GO

-----------------------------------------------------
-- Insert new effects, effcat, and modifiers
-- Note: hard-coded values must match enums in server!
-- Date Modified: 10/11/2020
-----------------------------------------------------



DECLARE @effectCatName VARCHAR(100);
DECLARE @effectGoodWeatherName VARCHAR(100);
DECLARE @effectBadWeatherName VARCHAR(100);
DECLARE @effCatPower INT;
DECLARE @effectGoodWeatherId INT;
DECLARE @effectBadWeatherId INT;
SET @effectCatName = 'effcat_weather_effects';
SET @effectGoodWeatherName = 'effect_weather_good';
SET @effectBadWeatherName = 'effect_weather_bad';
SET @effCatPower =45;
SET @effectGoodWeatherId =107;
SET @effectBadWeatherId =108;
IF EXISTS (SELECT TOP 1 flag FROM effectcategories WHERE name=@effectCatName)
BEGIN
	UPDATE effectcategories SET
		flag=@effCatPower,
		maxlevel=1, 
		note='dynamic zone environmental effects'
	WHERE name=@effectCatName;
END
ELSE
BEGIN
	INSERT INTO effectcategories (name, flag, maxlevel, note) VALUES
	(@effectCatName, @effCatPower, 1, 'dynamic zone environmental effects');
END


DECLARE @catFlag BIGINT;
SET @catFlag = POWER(CAST(2 AS BIGINT), (SELECT TOP 1 CAST(flag AS BIGINT) FROM effectcategories WHERE name=@effectCatName));

SET IDENTITY_INSERT effects ON;



IF EXISTS (SELECT TOP 1 id FROM effects WHERE name=@effectGoodWeatherName)
BEGIN
	UPDATE effects SET
		effectcategory=@catFlag,
		duration=0,
		description=@effectGoodWeatherName+'_desc',
		note='weather effects',
		isaura=1,
		auraradius=0,
		ispositive=1,
		display=1,
		saveable=0
	WHERE name=@effectGoodWeatherName;
END
ELSE
BEGIN
	INSERT INTO effects (id, effectcategory, duration, name, description, note, isaura, auraradius, ispositive, display, saveable) VALUES
	(@effectGoodWeatherId, @catFlag, 0, @effectGoodWeatherName, @effectGoodWeatherName+'_desc', 'weather effects', 1, 0, 1, 1, 0);
END

IF EXISTS (SELECT TOP 1 id FROM effects WHERE name=@effectBadWeatherName)
BEGIN
	UPDATE effects SET
		effectcategory=@catFlag,
		duration=0,
		description=@effectBadWeatherName+'_desc',
		note='weather effects',
		isaura=1,
		auraradius=0,
		ispositive=1,
		display=1,
		saveable=0
	WHERE name=@effectBadWeatherName;
END
ELSE
BEGIN
	INSERT INTO effects (id, effectcategory, duration, name, description, note, isaura, auraradius, ispositive, display, saveable) VALUES
	(@effectBadWeatherId, @catFlag, 0, @effectBadWeatherName, @effectBadWeatherName+'_desc', 'weather effects', 1, 0, 1, 1, 0);
END

SET IDENTITY_INSERT effects OFF;

DELETE FROM effectdefaultmodifiers WHERE effectid=(SELECT TOP 1 id FROM effects WHERE name=@effectBadWeatherName);
DELETE FROM effectdefaultmodifiers WHERE effectid=(SELECT TOP 1 id FROM effects WHERE name=@effectGoodWeatherName);

INSERT INTO effectdefaultmodifiers (effectid, field, value) VALUES
((SELECT TOP 1 id FROM effects WHERE name=@effectBadWeatherName),(SELECT TOP 1 id FROM aggregatefields WHERE name = 'effect_detection_strength_modifier'), -5),
((SELECT TOP 1 id FROM effects WHERE name=@effectBadWeatherName),(SELECT TOP 1 id FROM aggregatefields WHERE name = 'effect_blob_emission_radius_modifier'), 2),
((SELECT TOP 1 id FROM effects WHERE name=@effectBadWeatherName),(SELECT TOP 1 id FROM aggregatefields WHERE name = 'effect_blob_emission_modifier'), 20),
((SELECT TOP 1 id FROM effects WHERE name=@effectGoodWeatherName),(SELECT TOP 1 id FROM aggregatefields WHERE name = 'effect_detection_strength_modifier'), 2);


GO