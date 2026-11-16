USE [perpetuumsa]
GO

-- Add NPC Scanning to the extraction skills and require level 1 for the NPC scanner charge.
-- Apply after 78_NpcScannerAmmo.sql. The flat range bonus is in kilometers.
SET XACT_ABORT ON;
BEGIN TRANSACTION;

DECLARE @definition int = (SELECT definition FROM dbo.entitydefaults WHERE definitionname = 'def_ammo_npc_scan');
DECLARE @extensionName varchar(128) = 'ext_npc_scanning';
DECLARE @kilometersPerLevel float = 2;
DECLARE @requiredLevel int = 1;
DECLARE @extensionId int;

IF @definition IS NULL
    THROW 50001, 'The NPC scanner charge definition is missing. Apply 78_NpcScannerAmmo.sql first.', 1;

IF @kilometersPerLevel <= 0 OR @requiredLevel NOT BETWEEN 1 AND 10
    THROW 50003, 'Set a positive range bonus and a required level from 1 to 10.', 1;

SELECT @extensionId = extensionid
FROM dbo.extensions WITH (TABLOCKX, HOLDLOCK)
WHERE extensionname = @extensionName;

IF @extensionId IS NULL
BEGIN
    SELECT @extensionId = ISNULL(MAX(extensionid), 0) + 1 FROM dbo.extensions;

    INSERT INTO dbo.extensions (
        extensionid, extensionname, category, rank, learningattributeprimary,
        learningattributesecondary, bonus, price, active, description, effectenhancer, hidden, freezelimit
    )
    SELECT @extensionId, @extensionName, category, rank, learningattributeprimary,
        learningattributesecondary, @kilometersPerLevel, price, 1, 'ext_npc_scanning_desc', 0, 0, freezelimit
    FROM dbo.extensions
    WHERE extensionname = 'ext_artifact_scan_range' AND active = 1;

    IF @@ROWCOUNT <> 1
        THROW 50002, 'The active artifact scanning extension template is missing.', 1;
END;

UPDATE dbo.extensions
SET bonus = @kilometersPerLevel, active = 1
WHERE extensionid = @extensionId AND extensionname = @extensionName
    AND (bonus <> @kilometersPerLevel OR active = 0);

UPDATE dbo.enablerextensions
SET extensionlevel = @requiredLevel
WHERE definition = @definition AND extensionid = @extensionId AND extensionlevel <> @requiredLevel;

IF NOT EXISTS (
    SELECT 1 FROM dbo.enablerextensions WHERE definition = @definition AND extensionid = @extensionId
)
    INSERT INTO dbo.enablerextensions (definition, extensionid, extensionlevel)
    VALUES (@definition, @extensionId, @requiredLevel);

PRINT N'NPC Scanning and its charge requirement are configured';
COMMIT TRANSACTION;
GO
