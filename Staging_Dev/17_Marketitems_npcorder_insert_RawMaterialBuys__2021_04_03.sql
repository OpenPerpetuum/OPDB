USE [perpetuumsa]
GO

----------------------------------------------
-- Market NPC buy orders for raw materials
-- Public alpha and beta terminal markets only
-- Date modified: 2021/04/03
----------------------------------------------

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

DECLARE @VENDOR_DEF AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_public_vendor');

DECLARE @ALPHA_MARKETS_AND_VENDOR TABLE (market BIGINT, vendor BIGINT);
INSERT INTO @ALPHA_MARKETS_AND_VENDOR (market, vendor)
SELECT m.eid market, v.eid vendor FROM entities v
JOIN entities m ON m.parent=v.parent AND v.definition=@VENDOR_DEF AND m.eid IN (SELECT eid FROM @ALPHA_MARKETS);

DECLARE @BETA_MARKETS_AND_VENDOR TABLE (market BIGINT, vendor BIGINT);
INSERT INTO @BETA_MARKETS_AND_VENDOR (market, vendor)
SELECT m.eid market, v.eid vendor FROM entities v
JOIN entities m ON m.parent=v.parent AND v.definition=@VENDOR_DEF AND m.eid IN (SELECT eid FROM @BETA_PUBLIC_MARKETS);

DECLARE @ALPHA_ORDERS TABLE (marketEid BIGINT, itemDef INT, vendorEid BIGINT, price FLOAT);
INSERT INTO @ALPHA_ORDERS (marketEid, itemDef, vendorEid, price)
SELECT market,
 (select definition from entitydefaults where definitionname=defName), 
 vendor, price
FROM @ALPHA_MARKETS_AND_VENDOR m
JOIN #ALPHA_ORE_BUYS o ON 1=1;

DECLARE @BETA_ORDERS TABLE (marketEid BIGINT, itemDef INT, vendorEid BIGINT, price FLOAT);
INSERT INTO @BETA_ORDERS (marketEid, itemDef, vendorEid, price)
SELECT market,
 (select definition from entitydefaults where definitionname=defName), 
 vendor, price
FROM @BETA_MARKETS_AND_VENDOR m
JOIN #BETA_PUBLIC_ORE_BUYS o ON 1=1;

PRINT N'UPSERT MARKET ORDERS FOR EACH MARKET';
MERGE [dbo].[marketitems] m USING @ALPHA_ORDERS o
ON m.marketeid = o.marketEid AND
m.itemdefinition = o.itemDef AND
m.submittereid = o.vendorEid AND
m.isSell=0 AND m.isVendorItem=1 AND m.duration=0 AND m.quantity=-1
WHEN MATCHED
    THEN UPDATE SET
		price = o.price
WHEN NOT MATCHED
    THEN INSERT (marketeid, itemdefinition, submittereid, duration, isSell, price, quantity, usecorporationwallet, isvendoritem) VALUES
	(o.marketEid, o.itemDef, o.vendorEid, 0, 0, o.price, -1, 0, 1);

MERGE [dbo].[marketitems] m USING @BETA_ORDERS o
ON m.marketeid = o.marketEid AND
m.itemdefinition = o.itemDef AND
m.submittereid = o.vendorEid AND
m.isSell=0 AND m.isVendorItem=1 AND m.duration=0 AND m.quantity=-1
WHEN MATCHED
    THEN UPDATE SET
		price = o.price
WHEN NOT MATCHED
    THEN INSERT (marketeid, itemdefinition, submittereid, duration, isSell, price, quantity, usecorporationwallet, isvendoritem) VALUES
	(o.marketEid, o.itemDef, o.vendorEid, 0, 0, o.price, -1, 0, 1);
GO