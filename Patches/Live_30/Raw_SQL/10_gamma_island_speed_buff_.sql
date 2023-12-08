USE [perpetuumsa]
GO

------------------------------------------
-- T0 speed effect add
-- 18 KPH
-- Date modified: 2021/11/21
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
(@T0_EFFECT_ID, 'effect_speed_highway_modifier', 0.5),
(@T0_EFFECT_ID, 'effect_mining_amount_modifier', 1.75),
(@T0_EFFECT_ID, 'effect_harvesting_amount_modifier', 1.75),
(@T0_EFFECT_ID, 'pbs_tech_limit', 0);

PRINT N'DELETING AND REINSERTING MODIFIERS FOR T0 ZONE EFFECT';
DELETE FROM [effectdefaultmodifiers] WHERE effectid=@T0_EFFECT_ID;

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
		
USE [perpetuumsa]
GO
------------------------------------------
-- T1 speed effect add
-- 12.6 KPH
-- Date modified: 2021/11/21
------------------------------------------

DECLARE @T0_EFFECT_NAME  AS VARCHAR(100) = 'effect_gamma_t1';
DECLARE @T0_EFFECT_ID AS INT = (SELECT TOP 1 id FROM effects WHERE name=@T0_EFFECT_NAME);

DROP TABLE IF EXISTS #EFFECTMODS;
CREATE TABLE #EFFECTMODS 
(
	effId INT,
	fieldName VARCHAR(100),
	fieldValue FLOAT
);
INSERT INTO #EFFECTMODS (effId, fieldName, fieldValue) VALUES
(@T0_EFFECT_ID, 'effect_speed_highway_modifier', 0.35),
(@T0_EFFECT_ID, 'effect_mining_amount_modifier', 1.30),
(@T0_EFFECT_ID, 'effect_harvesting_amount_modifier', 1.30),
(@T0_EFFECT_ID, 'pbs_tech_limit', 1);

PRINT N'DELETING AND REINSERTING MODIFIERS FOR T0 ZONE EFFECT';
DELETE FROM [effectdefaultmodifiers] WHERE effectid=@T0_EFFECT_ID;

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

USE [perpetuumsa]
GO
------------------------------------------
-- T2 speed effect add
-- 9.0 KPH
-- Date modified: 2021/11/21
------------------------------------------

DECLARE @T0_EFFECT_NAME  AS VARCHAR(100) = 'effect_gamma_t2';
DECLARE @T0_EFFECT_ID AS INT = (SELECT TOP 1 id FROM effects WHERE name=@T0_EFFECT_NAME);

DROP TABLE IF EXISTS #EFFECTMODS;
CREATE TABLE #EFFECTMODS 
(
	effId INT,
	fieldName VARCHAR(100),
	fieldValue FLOAT
);
INSERT INTO #EFFECTMODS (effId, fieldName, fieldValue) VALUES
(@T0_EFFECT_ID, 'effect_speed_highway_modifier', 0.25),
(@T0_EFFECT_ID, 'effect_mining_amount_modifier', 1.30),
(@T0_EFFECT_ID, 'effect_harvesting_amount_modifier', 1.30),
(@T0_EFFECT_ID, 'pbs_tech_limit', 2);

PRINT N'DELETING AND REINSERTING MODIFIERS FOR T0 ZONE EFFECT';
DELETE FROM [effectdefaultmodifiers] WHERE effectid=@T0_EFFECT_ID;

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

USE [perpetuumsa]
GO
------------------------------------------
-- T3 speed effect add
-- 5.4 KPH
-- Date modified: 2021/11/21
------------------------------------------

DECLARE @T0_EFFECT_NAME  AS VARCHAR(100) = 'effect_gamma_t3';
DECLARE @T0_EFFECT_ID AS INT = (SELECT TOP 1 id FROM effects WHERE name=@T0_EFFECT_NAME);

DROP TABLE IF EXISTS #EFFECTMODS;
CREATE TABLE #EFFECTMODS 
(
	effId INT,
	fieldName VARCHAR(100),
	fieldValue FLOAT
);
INSERT INTO #EFFECTMODS (effId, fieldName, fieldValue) VALUES
(@T0_EFFECT_ID, 'effect_speed_highway_modifier', 0.15),
(@T0_EFFECT_ID, 'effect_mining_amount_modifier', 1.30),
(@T0_EFFECT_ID, 'effect_harvesting_amount_modifier', 1.30),
(@T0_EFFECT_ID, 'pbs_tech_limit', 3);

PRINT N'DELETING AND REINSERTING MODIFIERS FOR T0 ZONE EFFECT';
DELETE FROM [effectdefaultmodifiers] WHERE effectid=@T0_EFFECT_ID;

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

PRINT N'DONE';		
GO

