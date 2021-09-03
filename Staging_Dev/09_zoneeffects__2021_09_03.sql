USE [perpetuumsa]
GO

----------------------------------------
-- Zone effects for Tiered Gamma islands
--
-- Date modified: 9/3/2021
-----------------------------------------


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

DECLARE @effectCatName AS VARCHAR(100) = 'effcat_zone_effects';
DECLARE @T0_EFFECT_NAME  AS VARCHAR(100) = 'effect_gamma_t0';
DECLARE @T1_EFFECT_NAME  AS VARCHAR(100) = 'effect_gamma_t1';
DECLARE @T2_EFFECT_NAME  AS VARCHAR(100) = 'effect_gamma_t2';
DECLARE @T3_EFFECT_NAME  AS VARCHAR(100) = 'effect_gamma_t3';

DECLARE @T0_EFFECT_ID AS INT = 116;
DECLARE @T1_EFFECT_ID AS INT = 117;
DECLARE @T2_EFFECT_ID AS INT = 118;
DECLARE @T3_EFFECT_ID AS INT = 119;

DECLARE @catFlag AS BIGINT = (SELECT POWER(CAST(2 as bigint), CAST(flag as bigint)) FROM effectcategories WHERE name='effcat_zone_effects');

DECLARE @effCatPower AS BIGINT = (SELECT TOP 1 CAST(flag as bigint) FROM effectcategories WHERE name='effcat_zone_effects');;

INSERT INTO #EFFECTMODS (effId, fieldName, fieldValue) VALUES
(@T0_EFFECT_ID, 'effect_mining_amount_modifier', 1.75),
(@T0_EFFECT_ID, 'effect_harvesting_amount_modifier', 1.75),

(@T1_EFFECT_ID, 'effect_mining_amount_modifier', 1.3),
(@T1_EFFECT_ID, 'effect_harvesting_amount_modifier', 1.3),

(@T2_EFFECT_ID, 'effect_mining_amount_modifier', 1.3),
(@T2_EFFECT_ID, 'effect_harvesting_amount_modifier', 1.3),

(@T3_EFFECT_ID, 'effect_mining_amount_modifier', 1.3),
(@T3_EFFECT_ID, 'effect_harvesting_amount_modifier', 1.3);

INSERT INTO #EFFS (effId, effName) VALUES
(@T0_EFFECT_ID, @T0_EFFECT_NAME),
(@T1_EFFECT_ID, @T1_EFFECT_NAME),
(@T2_EFFECT_ID, @T2_EFFECT_NAME),
(@T3_EFFECT_ID, @T3_EFFECT_NAME);

DELETE FROM effectdefaultmodifiers WHERE effectid IN (SELECT effId FROM #EFFS);
DELETE FROM effects WHERE id IN (SELECT effId FROM #EFFS);

SET IDENTITY_INSERT effects ON;

INSERT INTO effects (id, effectcategory, duration, name, description, note, isaura, auraradius, ispositive, display, saveable)
SELECT effId, @catFlag, 0, effName, effName+'_desc', 'gamma zone effects', 1, 0, 1, 1, 0
FROM #EFFS;

SET IDENTITY_INSERT effects OFF;

INSERT INTO effectdefaultmodifiers (effectid, field, value)
SELECT effId, (SELECT TOP 1 id FROM aggregatefields WHERE name=fieldName), fieldValue
FROM #EFFECTMODS;

--SELECT * FROM zoneeffects WHERE zoneid IN (SELECT id FROM zones WHERE name LIKE 'zone_gamma_%' AND id > 105);
DELETE FROM zoneeffects WHERE zoneid IN (SELECT id FROM zones WHERE name LIKE 'zone_gamma_%' AND id > 105);

INSERT INTO zoneeffects (zoneid, effectid)
SELECT id, @T0_EFFECT_ID FROM zones
WHERE pbsTechLimit=0 AND id > 105 AND name LIKE 'zone_gamma_%';

INSERT INTO zoneeffects (zoneid, effectid)
SELECT id, @T1_EFFECT_ID FROM zones
WHERE pbsTechLimit=1 AND id > 105 AND name LIKE 'zone_gamma_%';

INSERT INTO zoneeffects (zoneid, effectid)
SELECT id, @T2_EFFECT_ID FROM zones
WHERE pbsTechLimit=2 AND id > 105 AND name LIKE 'zone_gamma_%';

INSERT INTO zoneeffects (zoneid, effectid)
SELECT id, @T3_EFFECT_ID FROM zones
WHERE pbsTechLimit=3 AND id > 105 AND name LIKE 'zone_gamma_%';

--SELECT * FROM zoneeffects WHERE zoneid IN (SELECT id FROM zones WHERE name LIKE 'zone_gamma_%' AND id > 105);

GO