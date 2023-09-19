USE [perpetuumsa]
GO

--------------------------------------
-- TRAINING ARTIFACT COORDINATES
--
-- Date Modified: 2023/07/21
--------------------------------------


PRINT N'UPDATE TRAINING ARTIFACT COORDINATES'
UPDATE [dbo].[trainingartifacts] SET
    [x] = 260,
    [y] = 424
  WHERE [x] = 262 AND [y] = 426;

GO
