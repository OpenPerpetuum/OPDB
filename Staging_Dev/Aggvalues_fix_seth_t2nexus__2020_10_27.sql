USE [perpetuumsa]
GO

--------------------------------------------------
-- Seth srf areas were off 23->25
-- T2 Shield nexus module missing range field (server defaults to 100, set here just in case)
-- Date: 2020/10/27
--------------------------------------------------

DROP TABLE IF EXISTS #MODIFIERS;
CREATE TABLE #MODIFIERS 
(
	defName varchar(100),
	fieldName varchar(100),
	fieldValue float,
);

INSERT INTO #MODIFIERS (defName, fieldName, fieldValue) VALUES
('def_seth_chassis', 'signature_radius', 25),
('def_seth_chassis_mk2', 'signature_radius', 25),
('def_seth_chassis_pr', 'signature_radius', 25),
('def_seth_chassis_reward1', 'signature_radius', 25),

('def_named1_gang_assist_shield_calculation_module', 'default_effect_range', 100);

PRINT N'MERGE SRF AREA UPDATES TO AGGREGATE VALUES FOR Seth and T2 shield nexus';

MERGE INTO
  aggregatevalues
USING
  #MODIFIERS
ON
  field = (SELECT TOP 1 id FROM aggregatefields WHERE fieldName=name)
  AND
  definition = (SELECT TOP 1 definition FROM entitydefaults WHERE defName=definitionname)
WHEN MATCHED THEN
  UPDATE SET
    value = fieldValue
WHEN NOT MATCHED THEN
  INSERT
    (definition, field, value)
  VALUES
    ((SELECT TOP 1 definition FROM entitydefaults WHERE defName=definitionname), (SELECT TOP 1 id FROM aggregatefields WHERE fieldName=name), fieldValue);


PRINT N'MERGED!';
DROP TABLE IF EXISTS #MODIFIERS;
GO