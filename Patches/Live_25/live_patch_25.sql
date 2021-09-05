USE [perpetuumsa]
GO

-------------------------------------------------
-- Patch 25: for real, the last one before gamma...
--
--Aggvalues_z72lwfmodstats__2021_09_05.sql
--Entitydefs_bombs__2021_09_05.sql
--Entitydefs_updates_enableNpcMods__2021_09_05.sql
--missiontargetypes_updates__2021_09_05.sql
--
--Date modified: 2021/09/05
-------------------------------------------------

PRINT N'BEGIN PATCH 25';

--Aggvalues_z72lwfmodstats__2021_09_05.sql
PRINT N'Aggvalues_z72lwfmodstats__2021_09_05.sql';
USE [perpetuumsa]
GO

------------------------------------
-- Fix missing penalty on LWF
-- Date modified: 09/05/2021
------------------------------------


DROP TABLE IF EXISTS #STATS;
CREATE TABLE #STATS(
	defName varchar(100),
	fieldName varchar(100),
	fieldValue float,
);
INSERT INTO #STATS (defName, fieldName, fieldValue) VALUES
('def_elitet2_72_mass_reductor','armor_max_modifier',0.725),
('def_elitet4_72_mass_reductor','armor_max_modifier',0.735);


PRINT N'UPSERT [aggregatevalues]';
MERGE [dbo].[aggregatevalues] v USING #STATS s
ON v.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=s.defName) AND
v.field = (SELECT TOP 1 id FROM aggregatefields WHERE name=s.fieldName)
WHEN MATCHED
    THEN UPDATE SET
		v.value=s.fieldValue
WHEN NOT MATCHED
    THEN INSERT (definition, field, value) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=s.defName),
	(SELECT TOP 1 id FROM aggregatefields WHERE name=s.fieldName),
	s.fieldValue);


DROP TABLE IF EXISTS #STATS;
GO



--Entitydefs_bombs__2021_09_05.sql
PRINT N'Entitydefs_bombs__2021_09_05.sql';
USE [perpetuumsa]
GO

---------------------------------
-- Anti-wall bombs
-- Event MORE than area bombs
-- Date Modified: 2021/09/04
---------------------------------

DROP TABLE IF EXISTS #BOMB_DEFS;
CREATE TABLE #BOMB_DEFS(
	[definition] [int] NOT NULL,
	[definitionname] [varchar](100) NOT NULL,
	[quantity] [int] NOT NULL,
	[attributeflags] [bigint] NOT NULL,
	[categoryflags] [bigint] NOT NULL,
	[options] [varchar](max) NULL,
	[note] [nvarchar](2048) NULL,
	[enabled] [bit] NOT NULL,
	[volume] [float] NULL,
	[mass] [float] NULL,
	[hidden] [bit] NOT NULL,
	[health] [float] NOT NULL,
	[descriptiontoken] [nvarchar](100) NULL,
	[purchasable] [bit] NOT NULL,
	[tiertype] [int] NULL,
	[tierlevel] [int] NULL,
);
INSERT INTO #BOMB_DEFS
([definition], [definitionname],[quantity],[attributeflags],[categoryflags],[options],[note],
[enabled],[volume],[mass],[hidden],[health],[descriptiontoken],[purchasable],[tiertype],[tierlevel])
VALUES
(6090, 'def_wall_bomb_a', 1, 536871936, 131986, '#height=f2.50', 'anti-wall bomb', 1, 1, 1, 0, 100, 'def_wall_bomb_a_desc', 0, 1, 1),
(6091, 'def_wall_bomb_a_capsule', 1, 25167872, 2200, '', 'anti-wall bomb', 1, 2.0, 2500, 0, 100, 'def_wall_bomb_a_desc', 1, 1, 1),
(6092, 'def_wall_bomb_b', 1, 536871936, 131986, '#height=f2.50', 'anti-wall bomb', 1, 1, 1, 0, 100, 'def_wall_bomb_b_desc', 0, 1, 2),
(6093, 'def_wall_bomb_b_capsule', 1, 25167872, 2200, '', 'anti-wall bomb', 1, 2.0, 2500, 0, 100, 'def_wall_bomb_b_desc', 1, 1, 2);

DROP TABLE IF EXISTS #BOMB_CONF;
CREATE TABLE #BOMB_CONF(
	definition INT, 
	targetdefinition INT NULL, 
	summonerscount INT, 
	item_work_range FLOAT, 
	explosion_radius FLOAT, 
	activationtime INT, 
	action_delay INT, 
	damage_chemical FLOAT, 
	damage_explosive FLOAT, 
	damage_kinetic FLOAT,
	damage_thermal FLOAT, 
	damage_toxic FLOAT, 
	note VARCHAR(1000)
);
INSERT INTO #BOMB_CONF (definition, targetdefinition, summonerscount, item_work_range, explosion_radius,
activationtime, action_delay, damage_chemical, damage_explosive, damage_kinetic, damage_thermal, damage_toxic, note)
VALUES
(6091, 6090, 1, 1, 30, 10000, 15000, 0, 0, 0, 0, 75000, 'wall bomb a capsule'),
(6090, NULL, 1, 1, 30, 10000, 15000, 0, 0, 0, 0, 75000, 'wall bomb a object'),
(6093, 6092, 1, 1, 30, 60000, 15000, 0, 0, 0, 0, 75000, 'wall bomb b capsule'),
(6092, NULL, 1, 1, 30, 60000, 15000, 0, 0, 0, 0, 75000, 'wall bomb b object');

DROP TABLE IF EXISTS #BOMB_STATS;
CREATE TABLE #BOMB_STATS(
	definition INT, 
	fieldName VARCHAR(100),
	fieldValue FLOAT
);
INSERT INTO #BOMB_STATS(definition, fieldName, fieldValue) VALUES
(6090, 'armor_max', 50),
(6090, 'signature_radius', 2),
(6090, 'stealth_strength', 25),
(6091, 'armor_max', 50),
(6091, 'signature_radius', 2),
(6091, 'stealth_strength', 25),

(6092, 'armor_max', 500),
(6092, 'signature_radius', 2),
(6092, 'stealth_strength', 200),
(6093, 'armor_max', 500),
(6093, 'signature_radius', 2),
(6093, 'stealth_strength', 200);


DROP TABLE IF EXISTS #BOMB_PRICE;
CREATE TABLE #BOMB_PRICE(
	definition INT, 
	nic FLOAT
);
INSERT INTO #BOMB_PRICE(definition, nic) VALUES
(6091, 500000),
(6093, 1500000);

PRINT N'UPSERT [entitydefaults]';
SET IDENTITY_INSERT entitydefaults ON;
MERGE [dbo].[entitydefaults] d USING #BOMB_DEFS b
ON d.definition = b.definition
WHEN MATCHED
    THEN UPDATE SET
		definitionname=b.definitionname,
		categoryflags=b.categoryflags,
		attributeflags=b.attributeflags,
		volume=b.volume,
		mass=b.mass,
		tiertype=b.tiertype,
		tierlevel=b.tierlevel,
		options=b.options,
		enabled=b.enabled,
		hidden=b.hidden,
		purchasable=b.purchasable,
		descriptiontoken=b.descriptiontoken
WHEN NOT MATCHED
    THEN INSERT
	([definition], [definitionname],[quantity],[attributeflags],[categoryflags],[options],[note],
	[enabled],[volume],[mass],[hidden],[health],[descriptiontoken],[purchasable],[tiertype],[tierlevel])
	VALUES
	(b.definition, b.definitionname, b.quantity, b.attributeflags, b.categoryflags, b.options, b.note,
	b.enabled, b.volume, b.mass, b.hidden, b.health, b.descriptiontoken, b.purchasable, b.tiertype, b.tierlevel);
SET IDENTITY_INSERT entitydefaults OFF;

PRINT N'UPSERT [definitionconfig]';
MERGE [dbo].[definitionconfig] cd USING #BOMB_CONF c
ON cd.definition = c.definition
WHEN MATCHED
    THEN UPDATE SET
		definition=c.definition,
		targetdefinition=c.targetdefinition,
		summonerscount=c.summonerscount,
		item_work_range=c.item_work_range,
		explosion_radius=c.explosion_radius,
		activationtime=c.activationtime,
		action_delay=c.action_delay,
		damage_chemical=c.damage_chemical,
		damage_explosive=c.damage_explosive,
		damage_kinetic=c.damage_kinetic,
		damage_thermal=c.damage_thermal,
		damage_toxic=c.damage_toxic,
		note=c.note
WHEN NOT MATCHED
    THEN INSERT
	(definition, targetdefinition, summonerscount, item_work_range, explosion_radius,
activationtime, action_delay, damage_chemical, damage_explosive, damage_kinetic, damage_thermal, damage_toxic, note)
	VALUES
	(c.definition, c.targetdefinition, c.summonerscount, c.item_work_range, c.explosion_radius,
c.activationtime, c.action_delay, c.damage_chemical, c.damage_explosive, c.damage_kinetic, c.damage_thermal, c.damage_toxic, c.note);

PRINT N'UPSERT [aggregatevalues]';
MERGE [dbo].[aggregatevalues] v USING #BOMB_STATS s
ON v.definition = s.definition AND v.field=(SELECT TOP 1 id FROM aggregatefields WHERE name=s.fieldName)
WHEN MATCHED
    THEN UPDATE SET
		value = s.fieldValue
WHEN NOT MATCHED
    THEN INSERT (definition, field, value) VALUES
	(s.definition, (SELECT TOP 1 id FROM aggregatefields WHERE name=s.fieldName), s.fieldValue);

DECLARE @PublicMarketDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_public_market');
DECLARE @PublicVendorDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_public_vendor');

DROP TABLE IF EXISTS #PUB_MARKETS;
CREATE TABLE #PUB_MARKETS(
	marketEID BIGINT,
	vendorEID BIGINT
);
INSERT INTO #PUB_MARKETS (marketEID, vendorEID)
SELECT e.eid, e2.eid from entities e
	join entities e2 on e2.parent=e.parent and e2.definition=@PublicVendorDef
	join zoneentities z on z.eid=e.parent
	where e.definition=@PublicMarketDef AND z.zoneID IN (0,8,3,4,5,9,10,11);

SELECT * FROM marketitems WHERE itemdefinition IN (SELECT DISTINCT definition FROM #BOMB_PRICE) AND
isvendoritem=1 AND quantity=-1 AND duration=0;
DELETE FROM marketitems WHERE itemdefinition IN (SELECT DISTINCT definition FROM #BOMB_PRICE) AND
isvendoritem=1 AND quantity=-1 AND duration=0;

INSERT INTO marketitems (marketeid, itemdefinition, submittereid, submitted, duration, isSell, price, quantity, usecorporationwallet, isvendoritem)
SELECT m.marketEID, b.definition, m.vendorEID, GETDATE(), 0, 1, b.nic, -1, 0, 1 FROM #PUB_MARKETS m
JOIN #BOMB_PRICE b ON 1=1;

UPDATE entitydefaults SET
	purchasable=0
WHERE definition IN (
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_terraform'),
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_construction_module'),
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_terraform_multi_module'),
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_construction_module_ammo_syndicate'),
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_construction_module_ammo_normal'),
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_construction_module_ammo_deconstruct')
);

UPDATE marketitems SET
	price=10000
WHERE isvendoritem=1 AND quantity=-1 AND duration=0 AND isSell=1
AND itemdefinition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_terraform');

UPDATE marketitems SET
	price=400000
WHERE isvendoritem=1 AND quantity=-1 AND duration=0 AND isSell=1
AND itemdefinition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_construction_module');

UPDATE marketitems SET
	price=400000
WHERE isvendoritem=1 AND quantity=-1 AND duration=0 AND isSell=1
AND itemdefinition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_terraform_multi_module');

UPDATE marketitems SET
	price=300000
WHERE isvendoritem=1 AND quantity=-1 AND duration=0 AND isSell=1
AND itemdefinition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_construction_module_ammo_syndicate');

UPDATE marketitems SET
	price=60000
WHERE isvendoritem=1 AND quantity=-1 AND duration=0 AND isSell=1
AND itemdefinition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_plant_seed_wall');

UPDATE marketitems SET
	price=150000
WHERE isvendoritem=1 AND quantity=-1 AND duration=0 AND isSell=1
AND itemdefinition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_standard_wall_builder');

UPDATE marketitems SET
	price=6000
WHERE isvendoritem=1 AND quantity=-1 AND duration=0 AND isSell=1
AND itemdefinition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_wall_builder_ammo_a');

UPDATE marketitems SET
	price=125000
WHERE isvendoritem=1 AND quantity=-1 AND duration=0 AND isSell=1
AND itemdefinition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_wall_healer_small_capsule');

UPDATE marketitems SET
	price=250000
WHERE isvendoritem=1 AND quantity=-1 AND duration=0 AND isSell=1
AND itemdefinition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_wall_healer_medium_capsule');

UPDATE marketitems SET
	price=325000
WHERE isvendoritem=1 AND quantity=-1 AND duration=0 AND isSell=1
AND itemdefinition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_wall_healer_large_capsule');


DROP TABLE IF EXISTS #PUB_MARKETS;
DROP TABLE IF EXISTS #BOMB_PRICE;
DROP TABLE IF EXISTS #BOMB_STATS;
DROP TABLE IF EXISTS #BOMB_CONF;
DROP TABLE IF EXISTS #BOMB_DEFS;
GO





--Entitydefs_updates_enableNpcMods__2021_09_05.sql
PRINT N'Entitydefs_updates_enableNpcMods__2021_09_05.sql';
USE [perpetuumsa]
GO

---------------------------------------------
-- Fix miniboss npc fittings w/ disabled mods defs
-- note: definitions not found on loot tables - NPC mods only!
-- Date modified: 2021/09/05
---------------------------------------------
PRINT N'Print definitions to enable - (90 rows affected) on first run';
SELECT * FROM entitydefaults
WHERE enabled=0 AND tiertype=3 AND tierlevel IN (2,4) AND definition >=3535 AND definition<=4437;

PRINT N'UPDATE entitydefaults - (90 rows affected) on first run';
UPDATE entitydefaults SET
	enabled=1
WHERE enabled=0 AND tiertype=3 AND tierlevel IN (2,4) AND definition >=3535 AND definition<=4437;

PRINT N'Done!';
GO



--missiontargetypes_updates__2021_09_05.sql
PRINT N'missiontargetypes_updates__2021_09_05.sql';
USE [perpetuumsa]
GO

--------------------------------------------------------
-- Economy updates for P25
-- 
-- Date Modified: 2021/09/05
--------------------------------------------------------

UPDATE missionconstants SET
	value=0.25
WHERE name='ScaleMineralLevelFractionForGangMember';

DROP TABLE IF EXISTS #REWARDS;
CREATE TABLE #REWARDS(
	name varchar(100),
	reward int
);
INSERT INTO #REWARDS(name, reward) VALUES
('loot_item',60),
('kill_definition',60),
('scan_mineral',200),
('drill_mineral',4200),
('submit_item',220),
('use_switch',60),
('find_artifact',200),
('use_itemsupply',275),
('massproduce',550),
('research',550),
('harvest_plant',1100),
('pop_npc',20),
('lock_unit',60);


MERGE missiontargettypes t USING #REWARDS r
ON t.name=r.name
WHEN MATCHED
    THEN UPDATE SET
		t.reward=r.reward;


DROP TABLE IF EXISTS #REWARDS;
GO



PRINT N'PATCH 25 APPLIED';
GO