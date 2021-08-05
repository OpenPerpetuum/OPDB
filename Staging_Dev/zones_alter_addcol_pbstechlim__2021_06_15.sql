USE [perpetuumsa]
GO

---------------------------------------------------------
-- Add zone column for tech level limit on pbs structures
--
-- Date Modified: 2021/06/15
---------------------------------------------------------


PRINT N'ALTER [dbo].[zones]';
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[perpetuumsa].[dbo].[zones]')
	AND name = 'pbsTechLimit')
BEGIN
	PRINT N'ADDING COL pbsTechLimit';
	ALTER TABLE [perpetuumsa].[dbo].[zones] ADD
		pbsTechLimit INT NULL
END
GO
