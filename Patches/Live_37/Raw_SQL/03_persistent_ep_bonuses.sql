/*
    Persistent server-wide EP bonus.
    Review and run manually against perpetuumsa after taking a backup. This script is idempotent.
*/
USE [perpetuumsa];
GO

SET XACT_ABORT ON;
BEGIN TRANSACTION;

IF OBJECT_ID(N'dbo.serverwideepbonus', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.serverwideepbonus
    (
        id tinyint NOT NULL CONSTRAINT PK_serverwideepbonus PRIMARY KEY,
        bonus int NOT NULL,
        expiresatutc datetime2(3) NULL,
        updatedatutc datetime2(3) NOT NULL,
        CONSTRAINT CK_serverwideepbonus_singleton CHECK (id = 1),
        CONSTRAINT CK_serverwideepbonus_bonus CHECK (bonus BETWEEN 0 AND 25),
        CONSTRAINT CK_serverwideepbonus_state CHECK
        (
            (bonus = 0 AND expiresatutc IS NULL)
            OR (bonus > 0 AND expiresatutc IS NOT NULL)
        )
    );
END;

IF NOT EXISTS (SELECT 1 FROM dbo.serverwideepbonus WHERE id = 1)
BEGIN
    INSERT dbo.serverwideepbonus (id, bonus, expiresatutc, updatedatutc)
    VALUES (1, 0, NULL, SYSUTCDATETIME());
END;

COMMIT TRANSACTION;
GO

/* Inspection queries (read-only):
SELECT bonus, expiresatutc, updatedatutc FROM dbo.serverwideepbonus WHERE id = 1;
*/
