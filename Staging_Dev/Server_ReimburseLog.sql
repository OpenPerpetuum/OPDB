USE [perpetuumsa]
GO

----------- Create Reimbursement Log-------------
PRINT N'Creating table for reimbursement logging';

CREATE TABLE [dbo].[opp_reimburselog] (
[Id] int NOT NULL IDENTITY(1,1) ,
[ReimburseTo] int NOT NULL ,
[ReimburseBy] int NOT NULL ,
[ReimburseTime] datetime NOT NULL ,
[EntityId] int NOT NULL ,
[ItemType] nvarchar(16) NOT NULL ,
[Qty] int NOT NULL 
)

GO
