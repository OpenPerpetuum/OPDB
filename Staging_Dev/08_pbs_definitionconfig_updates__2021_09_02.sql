USE [perpetuumsa]
GO

-----------------------------------------------
-- Gamma building param changes
--
-- Date modified: 2021/09/02
-----------------------------------------------

DROP TABLE IF EXISTS #POSTFIXES;
CREATE TABLE #POSTFIXES(
	fix VARCHAR(128)
);
INSERT #POSTFIXES (fix) VALUES
(''),
('_capsule'),
('_capsule_pr');

DROP TABLE IF EXISTS #PBS_CONFIGS;
CREATE TABLE #PBS_CONFIGS(
	defPrefix VARCHAR(128),
	paramName VARCHAR(128),
	paramValue int
);
INSERT INTO #PBS_CONFIGS (defPrefix, paramName, paramValue) VALUES
('def_pbs_docking_base_medium', 'bandwidthcapacity', 25000),
('def_pbs_docking_base_small', 'bandwidthcapacity', 12500),

('def_pbs_calibration_forge_large', 'transmitradius', 45),
('def_pbs_calibration_forge_medium', 'transmitradius', 45),
('def_pbs_calibration_forge_small', 'transmitradius', 45),
('def_pbs_mill_large', 'transmitradius', 45),
('def_pbs_mill_medium', 'transmitradius', 45),
('def_pbs_mill_small', 'transmitradius', 45),
('def_pbs_production_upgrade_large', 'transmitradius', 45),
('def_pbs_production_upgrade_medium', 'transmitradius', 45),
('def_pbs_production_upgrade_small', 'transmitradius', 45),
('def_pbs_prototyper_large', 'transmitradius', 45),
('def_pbs_prototyper_medium', 'transmitradius', 45),
('def_pbs_prototyper_small', 'transmitradius', 45),
('def_pbs_refinery_large', 'transmitradius', 45),
('def_pbs_refinery_medium', 'transmitradius', 45),
('def_pbs_refinery_small', 'transmitradius', 45),
('def_pbs_repair_large', 'transmitradius', 45),
('def_pbs_repair_medium', 'transmitradius', 45),
('def_pbs_repair_small', 'transmitradius', 45),
('def_pbs_reprocessor_large', 'transmitradius', 45),
('def_pbs_reprocessor_medium', 'transmitradius', 45),
('def_pbs_reprocessor_small', 'transmitradius', 45),
('def_pbs_research_kit_forge_large', 'transmitradius', 45),
('def_pbs_research_kit_forge_medium', 'transmitradius', 45),
('def_pbs_research_kit_forge_small', 'transmitradius', 45),
('def_pbs_research_lab_large', 'transmitradius', 45),
('def_pbs_research_lab_medium', 'transmitradius', 45),
('def_pbs_research_lab_small', 'transmitradius', 45);

DROP TABLE IF EXISTS #PBS_CONFIGS_MERGED;
CREATE TABLE #PBS_CONFIGS_MERGED(
	def int,
	paramName VARCHAR(128),
	paramValue int
);
INSERT INTO #PBS_CONFIGS_MERGED (def, paramName, paramValue)
SELECT (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=c.defPrefix+f.fix), c.paramName, c.paramValue FROM #PBS_CONFIGS c
JOIN #POSTFIXES f ON 1=1;

--SELECT definition, transmitradius, bandwidthcapacity FROM definitionconfig
--WHERE definition in (select def from #PBS_CONFIGS_MERGED);

MERGE [dbo].[definitionconfig] AS c
USING #PBS_CONFIGS_MERGED AS p 
ON p.def=c.definition AND p.paramName='transmitradius'
WHEN MATCHED THEN 
	UPDATE SET
		transmitradius=p.paramValue;

MERGE [dbo].[definitionconfig] AS c
USING #PBS_CONFIGS_MERGED AS p 
ON p.def=c.definition AND p.paramName='bandwidthcapacity'
WHEN MATCHED THEN 
	UPDATE SET
		bandwidthcapacity=p.paramValue;

GO