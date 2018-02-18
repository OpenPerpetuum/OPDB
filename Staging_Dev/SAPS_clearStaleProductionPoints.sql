USE [perpetuumsa]
GO

PRINT N'Delete Stale facility point entries on beta outposts';

SELECT *
  FROM [perpetuumsa].[dbo].[intrusionproductionstack]
  WHERE eventtime<DATETIMEFROMPARTS (2018, 1, 20, 0, 0, 0, 0);

DELETE FROM [perpetuumsa].[dbo].[intrusionproductionstack]
WHERE eventtime<DATETIMEFROMPARTS (2018, 1, 20, 0, 0, 0, 0);