USE [perpetuumsa]
GO

-- Add a zone-wide NPC scanner charge, using the intrusion charge's equipment
-- category and NPC market availability. Deploy with the matching server build.
SET XACT_ABORT ON;

BEGIN TRANSACTION;

DECLARE @templateName varchar(100) = 'def_ammo_intrusion_scan';
DECLARE @chargeName varchar(100) = 'def_ammo_npc_scan';
DECLARE @templateDefinition int;

SELECT @templateDefinition = definition
FROM dbo.entitydefaults WITH (UPDLOCK, HOLDLOCK)
WHERE definitionname = @templateName;

IF @templateDefinition IS NULL
    THROW 50001, 'The intrusion scanner charge definition is missing.', 1;

IF NOT EXISTS (
    SELECT 1 FROM dbo.marketitems
    WHERE itemdefinition = @templateDefinition AND isSell = 1 AND isvendoritem = 1 AND formembersof IS NULL
)
    THROW 50002, 'The intrusion scanner charge has no public NPC sell orders to use as a template.', 1;

PRINT N'Add NPC scanner charge';

INSERT INTO dbo.entitydefaults (
    definitionname, quantity, attributeflags, categoryflags, options, enabled,
    volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel
)
SELECT @chargeName, quantity, attributeflags, categoryflags, options, 1,
    volume, mass, 0, health, 'def_ammo_npc_scan_desc', 1, tiertype, tierlevel
FROM dbo.entitydefaults
WHERE definitionname = @templateName
    AND NOT EXISTS (SELECT 1 FROM dbo.entitydefaults WHERE definitionname = @chargeName);

DECLARE @chargeDefinition int = (SELECT definition FROM dbo.entitydefaults WHERE definitionname = @chargeName);

PRINT N'Add NPC sell orders for the NPC scanner charge';

;WITH templateOrders AS (
    SELECT marketeid, submittereid, price, quantity,
        ROW_NUMBER() OVER (PARTITION BY marketeid ORDER BY price, marketitemid) AS orderNumber
    FROM dbo.marketitems
    WHERE itemdefinition = @templateDefinition AND isSell = 1 AND isvendoritem = 1 AND formembersof IS NULL
)
INSERT INTO dbo.marketitems (marketeid, itemdefinition, submittereid, isSell, price, quantity, isvendoritem)
SELECT template.marketeid, @chargeDefinition, template.submittereid, 1, template.price, template.quantity, 1
FROM templateOrders AS template
WHERE template.orderNumber = 1
    AND NOT EXISTS (
        SELECT 1 FROM dbo.marketitems AS existing
        WHERE existing.marketeid = template.marketeid AND existing.itemdefinition = @chargeDefinition
            AND existing.isSell = 1 AND existing.isvendoritem = 1 AND existing.formembersof IS NULL
    );

COMMIT TRANSACTION;
GO
