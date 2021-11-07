USE [perpetuumsa]
GO

------------------------------------------
-- T0 speed effect add
--
-- Date modified: 2021/11/07
------------------------------------------

DECLARE @T0_EFFECT_NAME  AS VARCHAR(100) = 'effect_gamma_t0';
DECLARE @T0_EFFECT_ID AS INT = (SELECT TOP 1 id FROM effects WHERE name=@T0_EFFECT_NAME);

DROP TABLE IF EXISTS #EFFECTMODS;
CREATE TABLE #EFFECTMODS 
(
	effId INT,
	fieldName VARCHAR(100),
	fieldValue FLOAT
);
INSERT INTO #EFFECTMODS (effId, fieldName, fieldValue) VALUES
(@T0_EFFECT_ID, 'effect_mining_amount_modifier', 1.75),
(@T0_EFFECT_ID, 'effect_harvesting_amount_modifier', 1.75),
(@T0_EFFECT_ID, 'speed_max', 0.14),
(@T0_EFFECT_ID, 'pbs_tech_limit', 0);

MERGE [dbo].[effectdefaultmodifiers] m USING #EFFECTMODS e
ON m.effectid = e.effId AND m.field=(SELECT TOP 1 id FROM aggregatefields WHERE name=e.fieldName)
WHEN MATCHED
    THEN UPDATE SET
		m.effectid=e.effId,
		m.field=(SELECT TOP 1 id FROM aggregatefields WHERE name=e.fieldName),
		m.value=e.fieldValue
WHEN NOT MATCHED
	THEN INSERT (effectid, field, value) VALUES
		(e.effId, (SELECT TOP 1 id FROM aggregatefields WHERE name=e.fieldName), e.fieldValue);
		
GO