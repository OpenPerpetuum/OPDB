USE [perpetuumsa]
GO

-------------------------------------
-- Define new col/table for GrowingPresences
--
-- Date modifified: 2021/09/18
-------------------------------------

PRINT N'ALTER [dbo].[npcpresence]';
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[perpetuumsa].[dbo].[npcpresence]')
	AND name = 'growthseconds')
BEGIN
	PRINT N'ADDING COL pbsTechLimit';
	ALTER TABLE [perpetuumsa].[dbo].[npcpresence] ADD
		growthseconds INT NULL
END
GO

PRINT N'CREATE TABLE [dbo].[npcescalactions]';
DROP TABLE IF EXISTS dbo.npcescalactions;
CREATE TABLE dbo.npcescalactions (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	presenceId INT NOT NULL,
	flockId INT NOT NULL,
	level INT NOT NULL,
	chance FLOAT NOT NULL DEFAULT 1.0
);
GO