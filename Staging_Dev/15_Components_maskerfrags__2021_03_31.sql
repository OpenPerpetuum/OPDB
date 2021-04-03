USE [perpetuumsa]
GO

------------------------------------------
-- Masker component fixes: common frags only
--
-- Date modified: 2021/03/31
------------------------------------------
PRINT N'FIX MASKER COMPONENTS';
DROP TABLE IF EXISTS #MASK_COMPONENTS;
CREATE TABLE #MASK_COMPONENTS(
	defName VARCHAR(100),
	compName VARCHAR(100),
	amount INT
);

INSERT INTO #MASK_COMPONENTS (defName, compName, amount) VALUES
('def_named1_stealth_modul','def_titanium',200),
('def_named1_stealth_modul','def_plasteosine',50),
('def_named1_stealth_modul','def_robotshard_common_basic',60),
('def_named1_stealth_modul','def_standard_stealth_modul',1),
('def_named1_stealth_modul','def_axicol',450),
('def_named2_stealth_modul','def_titanium',200),
('def_named2_stealth_modul','def_plasteosine',25),
('def_named2_stealth_modul','def_alligior',25),
('def_named2_stealth_modul','def_espitium',225),
('def_named2_stealth_modul','def_robotshard_common_basic',40),
('def_named2_stealth_modul','def_robotshard_common_advanced',40),
('def_named2_stealth_modul','def_named1_stealth_modul',1),
('def_named2_stealth_modul','def_axicol',225),
('def_named3_stealth_modul','def_titanium',200),
('def_named3_stealth_modul','def_plasteosine',50),
('def_named3_stealth_modul','def_alligior',50),
('def_named3_stealth_modul','def_espitium',450),
('def_named3_stealth_modul','def_robotshard_common_basic',30),
('def_named3_stealth_modul','def_robotshard_common_advanced',60),
('def_named3_stealth_modul','def_robotshard_common_expert',90),
('def_named3_stealth_modul','def_named2_stealth_modul',1),
('def_named3_stealth_modul','def_unimetal',200),
('def_named3_stealth_modul','def_axicol',450),
('def_named1_stealth_modul_pr','def_titanium',200),
('def_named1_stealth_modul_pr','def_plasteosine',50),
('def_named1_stealth_modul_pr','def_robotshard_common_basic',60),
('def_named1_stealth_modul_pr','def_standard_stealth_modul',1),
('def_named1_stealth_modul_pr','def_axicol',450),
('def_named2_stealth_modul_pr','def_titanium',200),
('def_named2_stealth_modul_pr','def_plasteosine',25),
('def_named2_stealth_modul_pr','def_alligior',25),
('def_named2_stealth_modul_pr','def_espitium',225),
('def_named2_stealth_modul_pr','def_robotshard_common_basic',40),
('def_named2_stealth_modul_pr','def_robotshard_common_advanced',40),
('def_named2_stealth_modul_pr','def_named1_stealth_modul',1),
('def_named2_stealth_modul_pr','def_axicol',225),
('def_named3_stealth_modul_pr','def_titanium',200),
('def_named3_stealth_modul_pr','def_plasteosine',50),
('def_named3_stealth_modul_pr','def_alligior',50),
('def_named3_stealth_modul_pr','def_espitium',450),
('def_named3_stealth_modul_pr','def_robotshard_common_basic',30),
('def_named3_stealth_modul_pr','def_robotshard_common_advanced',60),
('def_named3_stealth_modul_pr','def_robotshard_common_expert',90),
('def_named3_stealth_modul_pr','def_named2_stealth_modul',1),
('def_named3_stealth_modul_pr','def_unimetal',200),
('def_named3_stealth_modul_pr','def_axicol',450);

PRINT N'DELETES components for Maskers (58 rows affected) [if run 2nd time, just 46]';
DELETE FROM components WHERE 
	definition IN (
		SELECT definition FROM entitydefaults WHERE definitionname IN (SELECT DISTINCT defName FROM #MASK_COMPONENTS)
	);

PRINT N'RE-INSERT components FOR MASKERS';
INSERT INTO components (definition, componentdefinition, componentamount)
SELECT
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defName),
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=compName),
	amount
FROM #MASK_COMPONENTS;

PRINT N'DONE W MASKER COMPONENTS';
DROP TABLE IF EXISTS #MASK_COMPONENTS;
GO