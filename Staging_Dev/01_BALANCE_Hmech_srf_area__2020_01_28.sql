USE [perpetuumsa]
GO


---------------------------------------------------------
--Balance: Heavy Mech Srf Area increase
--15->25 Combats
--14->23 Syndicate Combats
--14->23 Industrial
--12->15 Glider
--Last Modified: 2020/05/21
---------------------------------------------------------


DROP TABLE IF EXISTS #MODIFIERS;
CREATE TABLE #MODIFIERS 
(
	defName varchar(100),
	fieldName varchar(100),
	fieldValue float,
);

INSERT INTO #MODIFIERS (defName, fieldName, fieldValue) VALUES
--Shields
('def_named3_medium_shield_generator', 'shield_radius', 25),
('def_named3_medium_shield_generator_pr', 'shield_radius', 25),
--Hmechs
('def_gropho_chassis', 'signature_radius', 25),
('def_gropho_chassis_mk2', 'signature_radius', 25),
('def_gropho_chassis_pr', 'signature_radius', 25),
('def_gropho_chassis_reward1', 'signature_radius', 25),

('def_legatus_chassis', 'signature_radius', 23),

('def_lithus_chassis', 'signature_radius', 23),
('def_lithus_chassis_mk2', 'signature_radius', 23),
('def_lithus_chassis_pr', 'signature_radius', 23),

('def_mesmer_chassis', 'signature_radius', 25),
('def_mesmer_chassis_mk2', 'signature_radius', 25),
('def_mesmer_chassis_pr', 'signature_radius', 25),
('def_mesmer_chassis_reward1', 'signature_radius', 25),

('def_metis_chassis', 'signature_radius', 23),

('def_riveler_chassis', 'signature_radius', 23),
('def_riveler_chassis_mk2', 'signature_radius', 23),
('def_riveler_chassis_pr', 'signature_radius', 23),

('def_scarab_chassis', 'signature_radius', 15),
('def_scarab_chassis_mk2', 'signature_radius', 15),
('def_scarab_chassis_pr', 'signature_radius', 15),

('def_seth_chassis', 'signature_radius', 23),
('def_seth_chassis_mk2', 'signature_radius', 23),
('def_seth_chassis_pr', 'signature_radius', 23),
('def_seth_chassis_reward1', 'signature_radius', 23),

('def_symbiont_chassis', 'signature_radius', 23),
('def_symbiont_chassis_mk2', 'signature_radius', 23),
('def_symbiont_chassis_pr', 'signature_radius', 23);

PRINT N'ABOUT TO MERGE SRF AREA UPDATES TO AGGREGATE VALUES FOR ALL HEAVY MECH STATS (and medium t4 shield)';

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