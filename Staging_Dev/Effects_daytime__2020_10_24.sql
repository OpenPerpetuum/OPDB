USE [perpetuumsa]
GO

-----------------------------------------------------
-- Insert new effects, effcat, and modifiers (Part 2: Daytime effects)
-- Note: hard-coded values must match enums in server!
-- Date Modified: 10/24/2020
-----------------------------------------------------



DECLARE @effectCatName VARCHAR(100);
DECLARE @effectDayName VARCHAR(100);
DECLARE @effectNightName VARCHAR(100);
DECLARE @effCatPower INT;
DECLARE @effectDayId INT;
DECLARE @effectNightId INT;
SET @effectCatName = 'effcat_daytime_effects';
SET @effectDayName = 'effect_daytime_day';
SET @effectNightName = 'effect_daytime_night';
SET @effCatPower = 46;
SET @effectDayId = 109;
SET @effectNightId = 110;
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



IF EXISTS (SELECT TOP 1 id FROM effects WHERE name=@effectDayName)
BEGIN
	UPDATE effects SET
		effectcategory=@catFlag,
		duration=0,
		description=@effectDayName+'_desc',
		note='daytime effects',
		isaura=1,
		auraradius=0,
		ispositive=1,
		display=1,
		saveable=0
	WHERE name=@effectDayName;
END
ELSE
BEGIN
	INSERT INTO effects (id, effectcategory, duration, name, description, note, isaura, auraradius, ispositive, display, saveable) VALUES
	(@effectDayId, @catFlag, 0, @effectDayName, @effectDayName+'_desc', 'daytime effects', 1, 0, 1, 1, 0);
END

IF EXISTS (SELECT TOP 1 id FROM effects WHERE name=@effectNightName)
BEGIN
	UPDATE effects SET
		effectcategory=@catFlag,
		duration=0,
		description=@effectNightName+'_desc',
		note='daytime effects',
		isaura=1,
		auraradius=0,
		ispositive=1,
		display=1,
		saveable=0
	WHERE name=@effectNightName;
END
ELSE
BEGIN
	INSERT INTO effects (id, effectcategory, duration, name, description, note, isaura, auraradius, ispositive, display, saveable) VALUES
	(@effectNightId, @catFlag, 0, @effectNightName, @effectNightName+'_desc', 'daytime effects', 1, 0, 1, 1, 0);
END

SET IDENTITY_INSERT effects OFF;

DELETE FROM effectdefaultmodifiers WHERE effectid=(SELECT TOP 1 id FROM effects WHERE name=@effectNightName);
DELETE FROM effectdefaultmodifiers WHERE effectid=(SELECT TOP 1 id FROM effects WHERE name=@effectDayName);

INSERT INTO effectdefaultmodifiers (effectid, field, value) VALUES
((SELECT TOP 1 id FROM effects WHERE name=@effectNightName),(SELECT TOP 1 id FROM aggregatefields WHERE name = 'effect_stealth_strength_modifier'), 2),
((SELECT TOP 1 id FROM effects WHERE name=@effectDayName),(SELECT TOP 1 id FROM aggregatefields WHERE name = 'effect_stealth_strength_modifier'), -2);


GO