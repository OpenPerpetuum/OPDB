USE [perpetuumsa]
GO


DROP TABLE IF EXISTS #ALPHA_ORE_BUYS;
CREATE TABLE #ALPHA_ORE_BUYS(
	defName VARCHAR(100),
	price FLOAT
);
DROP TABLE IF EXISTS #BETA_PUBLIC_ORE_BUYS;
CREATE TABLE #BETA_PUBLIC_ORE_BUYS(
	defName VARCHAR(100),
	price FLOAT
);

INSERT INTO #ALPHA_ORE_BUYS (defName, price) VALUES
('def_crude', 0.1),
('def_liquizit', 0.33),
('def_epriton', 1.4),
('def_titan', 0.5),
('def_imentium', 0.77),
('def_silgium', 0.77),
('def_stermonit', 0.77),
('def_prismocitae', 0.80),
('def_helioptris', 0.80),
('def_triandlus', 0.80),
('def_electroplant_fruit', 3.2);

INSERT INTO #BETA_PUBLIC_ORE_BUYS (defName, price) VALUES
('def_crude', 0.12),
('def_liquizit', 0.4),
--('def_epriton', 1.68),
('def_titan', 0.6),
('def_imentium', 0.92),
('def_silgium', 0.92),
('def_stermonit', 0.92),
('def_prismocitae', 0.96),
('def_helioptris', 0.96),
('def_triandlus', 0.96);
--('def_electroplant_fruit', 3.84);

----MAIN terminals, alpha and beta
--'def_public_docking_base_nuimqol',
--'def_public_docking_base_pelistal',
--'def_public_docking_base_thelodica',
----Outpost Alpha
--'def_public_docking_base_nuimqol_outpost_pve',
--'def_public_docking_base_thelodica_outpost_pve'
--'def_public_docking_base_pelistal_outpost_pve',
----Outpost BETA
--'def_public_docking_base_pelistal_outpost',
--'def_public_docking_base_nuimqol_outpost',
--'def_public_docking_base_thelodica_outpost',


PRINT N'SELECT TERMINAL DEFINITIONS';
DECLARE @MAIN_TERMINAL_DEFS AS TABLE (definition INT);
INSERT INTO @MAIN_TERMINAL_DEFS
SELECT definition FROM entitydefaults WHERE definitionname IN (
	'def_public_docking_base_nuimqol',
	'def_public_docking_base_pelistal',
	'def_public_docking_base_thelodica'
);

DECLARE @MAIN_AND_PVE_OUTPOSTS AS TABLE (definition INT);
INSERT INTO @MAIN_AND_PVE_OUTPOSTS (definition)
SELECT definition FROM entitydefaults WHERE definitionname IN (
	'def_public_docking_base_nuimqol_outpost_pve',
	'def_public_docking_base_thelodica_outpost_pve',
	'def_public_docking_base_pelistal_outpost_pve'
);
INSERT INTO @MAIN_AND_PVE_OUTPOSTS (definition)
SELECT definition FROM @MAIN_TERMINAL_DEFS;

PRINT N'SELECT MARKET ENTITIES';
DECLARE @ALPHA_MARKETS TABLE (eid BIGINT);
DECLARE @BETA_PUBLIC_MARKETS TABLE (eid BIGINT);
DECLARE @MARKET_DEF AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_public_market');

INSERT INTO @ALPHA_MARKETS (eid)
SELECT e.eid FROM entities e
JOIN zoneentities ze ON e.parent=ze.eid
JOIN zones z ON z.id=ze.zoneID
WHERE 
	(SELECT TOP 1 definition FROM entities WHERE eid=ze.eid) IN (SELECT definition FROM @MAIN_AND_PVE_OUTPOSTS) AND 
	e.definition=@MARKET_DEF AND z.protected=1 AND zonetype=1; --alpha

INSERT INTO @BETA_PUBLIC_MARKETS (eid)
SELECT e.eid FROM entities e
JOIN zoneentities ze ON e.parent=ze.eid
JOIN zones z ON z.id=ze.zoneID
WHERE
	(SELECT TOP 1 definition FROM entities WHERE eid=ze.eid) IN (SELECT definition FROM @MAIN_TERMINAL_DEFS) AND 
	e.definition=@MARKET_DEF AND z.protected=0 AND zonetype=2; --beta

PRINT N'UPSERT MARKET ORDERS FOR EACH MARKET';
