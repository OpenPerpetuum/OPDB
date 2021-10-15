USE [perpetuumsa]
GO

---------------------------------------
-- NPC ALPHA MARKET SELLS for gamma items
-- Staging base, T0 blocks, decon, mods etc.
-- Date modified: 2021/10/14
---------------------------------------


DROP TABLE IF EXISTS #SELLS;
CREATE TABLE #SELLS(
	defName VARCHAR(100),
	price FLOAT
);
INSERT INTO #SELLS (defName, price) VALUES
('def_construction_module_ammo_t0', 200000),
('def_pbs_expiring_docking_base', 15000000),
('def_ammo_terraform',7500),
('def_pbs_construction_module',500000),
('def_terraform_multi_module',500000),
('def_construction_module_ammo_deconstruct', 10000);


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

DECLARE @VENDOR_DEF AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_public_vendor');

DECLARE @ALPHA_MARKETS_AND_VENDOR TABLE (market BIGINT, vendor BIGINT);
INSERT INTO @ALPHA_MARKETS_AND_VENDOR (market, vendor)
SELECT m.eid market, v.eid vendor FROM entities v
JOIN entities m ON m.parent=v.parent AND v.definition=@VENDOR_DEF AND m.eid IN (SELECT eid FROM @ALPHA_MARKETS);

DECLARE @ALPHA_ORDERS TABLE (marketEid BIGINT, itemDef INT, vendorEid BIGINT, price FLOAT);
INSERT INTO @ALPHA_ORDERS (marketEid, itemDef, vendorEid, price)
SELECT market,
 (select definition from entitydefaults where definitionname=defName), 
 vendor, price
FROM @ALPHA_MARKETS_AND_VENDOR m
JOIN #SELLS o ON 1=1;

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
	(o.marketEid, o.itemDef, o.vendorEid, 0, 1, o.price, -1, 0, 1);

PRINT N'ALPHA ORDERS FOR GAMMA SEEDED';
GO