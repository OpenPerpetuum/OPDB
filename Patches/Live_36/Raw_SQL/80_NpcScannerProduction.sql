USE [perpetuumsa]
GO

-- Apply after 78_NpcScannerAmmo.sql and 79_NpcScannerExtension.sql.
-- Capsule -> dynamic CT (10/10) -> 100 charges per cycle; no research/prototype required.
-- Reapplication updates named definitions, recipe, template and shop rows in place.
SET XACT_ABORT ON;
BEGIN TRANSACTION;

DECLARE @chargeName varchar(100) = 'def_ammo_npc_scan';
DECLARE @blueprintName varchar(100) = 'def_ammo_npc_scan_cprg';
DECLARE @capsuleName varchar(100) = 'def_ammo_npc_scan_CT_capsule';
DECLARE @batch int = 100, @componentAmount int = 35;
DECLARE @materialPoints float = 10, @timePoints float = 10, @decrease float = 0.3;
DECLARE @costModifier float = 7, @durationModifier float = 1;
DECLARE @credit float = 5000000, @tokens int = 280;
DECLARE @charge int, @blueprint int, @capsule int, @category bigint;
DECLARE @templateBlueprint int, @templateCapsule int;

IF @batch <= 0 OR @componentAmount <= 1 OR @tokens < 0 OR @credit < 0
    OR @materialPoints <= 0 OR @timePoints <= 0 OR @decrease <= 0
    OR @costModifier NOT BETWEEN 1 AND 10 OR @durationModifier <= 0
    THROW 50001, 'Invalid NPC scanner production parameters.', 1;

SELECT @charge = definition, @category = categoryflags
FROM dbo.entitydefaults WITH (UPDLOCK, HOLDLOCK) WHERE definitionname = @chargeName;
SELECT @templateCapsule = definition FROM dbo.entitydefaults
WHERE definitionname = 'def_ammo_small_projectile_t_CT_capsule' AND enabled = 1;
SELECT @templateBlueprint = targetdefinition FROM dbo.calibrationtemplateitems
WHERE definition = @templateCapsule;

IF @charge IS NULL OR @templateCapsule IS NULL OR @templateBlueprint IS NULL
    THROW 50002, 'NPC charge or Machete capsule/CT template is missing.', 1;
IF NOT EXISTS (SELECT 1 FROM dbo.dynamiccalibrationtemplates WHERE definition = @templateBlueprint)
    THROW 50003, 'The Machete CT must have a dynamic production template.', 1;
IF NOT EXISTS (SELECT 1 FROM dbo.enablerextensions e JOIN dbo.extensions x ON x.extensionid=e.extensionid
               WHERE e.definition=@charge AND x.extensionname='ext_npc_scanning' AND e.extensionlevel=1)
    THROW 50004, 'Apply 79_NpcScannerExtension.sql before this patch.', 1;

DECLARE @recipe TABLE (definitionname varchar(100) PRIMARY KEY, definition int, amount int NOT NULL);
INSERT INTO @recipe (definitionname, amount) VALUES
    ('def_gamma_buildblock', @componentAmount), -- Coalimin: Titan, Epriton, Colixum
    ('def_isopropentol', @componentAmount),     -- HDT, Triandlus, Silgium
    ('def_polynucleit', @componentAmount),      -- Stermonit, Liquizit, Prismocitae
    ('def_statichnol', @componentAmount);       -- HDT, Imentium, Helioptris
UPDATE r SET definition=d.definition FROM @recipe r JOIN dbo.entitydefaults d
    ON d.definitionname=r.definitionname AND d.enabled=1;
IF EXISTS (SELECT 1 FROM @recipe WHERE definition IS NULL)
    THROW 50005, 'An enabled recipe material is missing.', 1;
IF EXISTS (SELECT 1 FROM dbo.components c WHERE c.definition=@charge
           AND NOT EXISTS (SELECT 1 FROM @recipe r WHERE r.definition=c.componentdefinition))
    THROW 50006, 'The NPC charge has an unexpected recipe component; review it before applying.', 1;

-- productioncost has no definition-specific key. This category is shared with intrusion
-- charges, which currently have no recipe. Never silently reprice another craftable item.
IF EXISTS (SELECT 1 FROM dbo.entitydefaults d WHERE d.categoryflags=@category AND d.definition<>@charge
           AND EXISTS (SELECT 1 FROM dbo.components c WHERE c.definition=d.definition))
    THROW 50007, 'Another item in the shared scanner category has a recipe; isolate its pricing first.', 1;

-- Existing batches remain the same volume per charge, including when reapplying patch 78.
UPDATE dbo.entitydefaults SET volume=volume * @batch / quantity, quantity=@batch
WHERE definition=@charge;

MERGE dbo.components WITH (HOLDLOCK) AS target
USING @recipe AS source
ON target.definition=@charge AND target.componentdefinition=source.definition
WHEN MATCHED THEN UPDATE SET componentamount=source.amount
WHEN NOT MATCHED THEN INSERT (definition, componentdefinition, componentamount)
VALUES (@charge, source.definition, source.amount);

DECLARE @definitions TABLE (name varchar(100) PRIMARY KEY, template int, description nvarchar(100), capsule bit);
INSERT INTO @definitions VALUES
    (@blueprintName, @templateBlueprint, 'def_ammo_npc_scan_cprg_desc', 0),
    (@capsuleName, @templateCapsule, 'def_ammo_npc_scan_CT_capsule_desc', 1);
MERGE dbo.entitydefaults WITH (HOLDLOCK) AS target
USING (SELECT n.name, n.description, n.capsule, d.attributeflags,
              CASE WHEN n.capsule=1 THEN d.categoryflags & CAST(4294967295 AS bigint)
                   ELSE d.categoryflags END AS categoryflags,
              d.options, d.volume, d.mass, d.health, d.tiertype, d.tierlevel
       FROM @definitions n JOIN dbo.entitydefaults d ON d.definition=n.template) AS source
ON target.definitionname=source.name
WHEN MATCHED THEN UPDATE SET quantity=1, attributeflags=source.attributeflags,
    categoryflags=source.categoryflags, options=source.options, enabled=1, hidden=0,
    volume=source.volume, mass=source.mass, health=source.health, descriptiontoken=source.description,
    purchasable=source.capsule, tiertype=source.tiertype, tierlevel=source.tierlevel
WHEN NOT MATCHED THEN INSERT (definitionname, quantity, attributeflags, categoryflags, options,
    enabled, hidden, volume, mass, health, descriptiontoken, purchasable, tiertype, tierlevel)
VALUES (source.name, 1, source.attributeflags, source.categoryflags, source.options,
    1, 0, source.volume, source.mass, source.health, source.description, source.capsule, source.tiertype, source.tierlevel);

SELECT @blueprint=definition FROM dbo.entitydefaults WHERE definitionname=@blueprintName;
SELECT @capsule=definition FROM dbo.entitydefaults WHERE definitionname=@capsuleName;

-- These legacy tables lack unique keys on definition: refuse pre-existing duplicates.
IF (SELECT COUNT(*) FROM dbo.dynamiccalibrationtemplates WHERE definition=@blueprint)>1
    OR (SELECT COUNT(*) FROM dbo.calibrationtemplateitems WHERE definition=@capsule)>1
    THROW 50008, 'Duplicate NPC CT/capsule mappings exist; review before applying.', 1;

UPDATE dbo.dynamiccalibrationtemplates SET targetdefinition=@charge,
    materialefficiency=@materialPoints, timeefficiency=@timePoints WHERE definition=@blueprint;
IF @@ROWCOUNT=0
    INSERT INTO dbo.dynamiccalibrationtemplates (definition, targetdefinition, materialefficiency, timeefficiency)
    VALUES (@blueprint, @charge, @materialPoints, @timePoints);
UPDATE dbo.calibrationtemplateitems SET targetdefinition=@blueprint WHERE definition=@capsule;
IF @@ROWCOUNT=0
    INSERT INTO dbo.calibrationtemplateitems (definition, targetdefinition) VALUES (@capsule, @blueprint);

MERGE dbo.productionduration WITH (HOLDLOCK) AS target
USING (SELECT @category AS category) AS source ON target.category=source.category
WHEN MATCHED THEN UPDATE SET durationmodifier=@durationModifier
WHEN NOT MATCHED THEN INSERT (category, durationmodifier) VALUES (source.category, @durationModifier);
MERGE dbo.productiondecalibration WITH (HOLDLOCK) AS target
USING (SELECT @category AS categoryflag) AS source ON target.categoryflag=source.categoryflag
WHEN MATCHED THEN UPDATE SET decrease=@decrease
WHEN NOT MATCHED THEN INSERT (categoryflag, decrease, distorsionmin, distorsionmax)
VALUES (source.categoryflag, @decrease, 0.001, 0.0015);

IF (SELECT COUNT(*) FROM dbo.productioncost WHERE category=@category AND tiertype IS NULL AND tierlevel IS NULL)>1
    THROW 50009, 'Duplicate scanner-category production cost rows exist.', 1;
UPDATE dbo.productioncost SET costmodifier=@costModifier
WHERE category=@category AND tiertype IS NULL AND tierlevel IS NULL;
IF @@ROWCOUNT=0
    INSERT INTO dbo.productioncost (category, tiertype, tierlevel, costmodifier)
    VALUES (@category, NULL, NULL, @costModifier);

-- Reuse the five active presets (12 locations in the checked database), not hardcoded base IDs.
DECLARE @presets TABLE (presetid int PRIMARY KEY);
INSERT INTO @presets SELECT DISTINCT s.presetid FROM dbo.itemshop s
WHERE s.targetdefinition=@templateCapsule
    AND EXISTS (SELECT 1 FROM dbo.itemshoplocations l WHERE l.presetid=s.presetid);
IF NOT EXISTS (SELECT 1 FROM @presets)
    THROW 50010, 'No located Syndicate Store offers the Machete capsule.', 1;
IF EXISTS (SELECT s.presetid FROM dbo.itemshop s JOIN @presets p ON p.presetid=s.presetid
           WHERE s.targetdefinition=@capsule GROUP BY s.presetid HAVING COUNT(*)>1)
    THROW 50011, 'Duplicate NPC capsule shop offers exist; review before applying.', 1;

UPDATE s SET targetamount=1, credit=@credit, tmcoin=@tokens, icscoin=@tokens,
    asicoin=@tokens, unicoin=@tokens, standing=0, globallimit=NULL
FROM dbo.itemshop s JOIN @presets p ON p.presetid=s.presetid WHERE s.targetdefinition=@capsule;
INSERT INTO dbo.itemshop (presetid, targetdefinition, targetamount, credit,
    tmcoin, icscoin, asicoin, unicoin, standing, globallimit, purchasecount)
SELECT p.presetid, @capsule, 1, @credit, @tokens, @tokens, @tokens, @tokens, 0, NULL, 0
FROM @presets p WHERE NOT EXISTS (SELECT 1 FROM dbo.itemshop s WITH (UPDLOCK, HOLDLOCK)
    WHERE s.presetid=p.presetid AND s.targetdefinition=@capsule);

PRINT N'NPC scanner recipe, 10/10 CT, capsule and Syndicate Store offers configured';
COMMIT TRANSACTION;
GO
