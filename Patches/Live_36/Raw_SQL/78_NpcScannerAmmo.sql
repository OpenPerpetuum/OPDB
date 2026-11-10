USE [perpetuumsa]
GO

-- Add a zone-wide NPC scanner charge, using the intrusion charge's equipment
-- category and NPC market availability. Deploy with the matching server build.
SET XACT_ABORT ON;

BEGIN TRANSACTION;

DECLARE @templateName varchar(100) = 'def_ammo_intrusion_scan';
DECLARE @chargeName varchar(100) = 'def_ammo_npc_scan';
DECLARE @vendorPrice float = NULL; -- NULL uses the template price on each market.
DECLARE @templateDefinition int;

SELECT @templateDefinition = definition
FROM dbo.entitydefaults WITH (UPDLOCK, HOLDLOCK)
WHERE definitionname = @templateName;

IF @templateDefinition IS NULL
    THROW 50001, 'The intrusion scanner charge definition is missing.', 1;

IF @vendorPrice <= 0
    THROW 50003, 'The NPC scanner charge price must be positive.', 1;

DECLARE @vendorOrders TABLE (
    marketeid bigint PRIMARY KEY,
    submittereid bigint NOT NULL,
    price float NOT NULL,
    quantity int NOT NULL
);

;WITH templateOrders AS (
    SELECT marketeid, submittereid, price, quantity,
        ROW_NUMBER() OVER (PARTITION BY marketeid ORDER BY price, marketitemid) AS orderNumber
    FROM dbo.marketitems
    WHERE itemdefinition = @templateDefinition AND isSell = 1 AND isvendoritem = 1 AND formembersof IS NULL
)
INSERT INTO @vendorOrders (marketeid, submittereid, price, quantity)
SELECT marketeid, submittereid, COALESCE(@vendorPrice, price), quantity
FROM templateOrders
WHERE orderNumber = 1;

IF @@ROWCOUNT = 0
    THROW 50002, 'The intrusion scanner charge has no public NPC sell orders to use as a template.', 1;

PRINT N'Configure NPC scanner charge';

MERGE dbo.entitydefaults WITH (HOLDLOCK) AS existing
USING (SELECT quantity, attributeflags, categoryflags, options, volume, mass, health, tiertype, tierlevel
       FROM dbo.entitydefaults WHERE definitionname = @templateName) AS template
ON existing.definitionname = @chargeName
WHEN MATCHED THEN UPDATE SET
    quantity = template.quantity, attributeflags = template.attributeflags, categoryflags = template.categoryflags,
    options = template.options, enabled = 1, volume = template.volume, mass = template.mass, hidden = 0,
    health = template.health, descriptiontoken = 'def_ammo_npc_scan_desc', purchasable = 1,
    tiertype = template.tiertype, tierlevel = template.tierlevel
WHEN NOT MATCHED THEN INSERT (
    definitionname, quantity, attributeflags, categoryflags, options, enabled,
    volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel
)
VALUES (@chargeName, template.quantity, template.attributeflags, template.categoryflags, template.options, 1,
    template.volume, template.mass, 0, template.health, 'def_ammo_npc_scan_desc', 1, template.tiertype, template.tierlevel);

DECLARE @chargeDefinition int = (SELECT definition FROM dbo.entitydefaults WHERE definitionname = @chargeName);

PRINT N'Configure NPC sell orders for the NPC scanner charge';

UPDATE existing
SET price = template.price, quantity = template.quantity
FROM dbo.marketitems AS existing
JOIN @vendorOrders AS template ON template.marketeid = existing.marketeid
WHERE existing.itemdefinition = @chargeDefinition AND existing.isSell = 1
    AND existing.isvendoritem = 1 AND existing.formembersof IS NULL
    AND (existing.price <> template.price OR existing.quantity <> template.quantity);

INSERT INTO dbo.marketitems (marketeid, itemdefinition, submittereid, isSell, price, quantity, isvendoritem)
SELECT template.marketeid, @chargeDefinition, template.submittereid, 1, template.price, template.quantity, 1
FROM @vendorOrders AS template
WHERE NOT EXISTS (
        SELECT 1 FROM dbo.marketitems AS existing
        WHERE existing.marketeid = template.marketeid AND existing.itemdefinition = @chargeDefinition
            AND existing.isSell = 1 AND existing.isvendoritem = 1 AND existing.formembersof IS NULL
    );

COMMIT TRANSACTION;
GO
