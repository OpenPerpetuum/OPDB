USE [perpetuumsa]
GO

---------------------------------
-- Maintenance gift to compensate for the hosting issues
-- Date Modified: 2023/06/08
---------------------------------

IF EXISTS (SELECT * FROM [packages] WHERE name='opp-maintenance-gift00')
BEGIN
	PRINT N'PACKAGE ALREADY CREATED, SKIPPING';
	SET NOEXEC ON;
END

PRINT N'Create Reimbursement Package';
INSERT INTO [dbo].[packages]
           ([name],[note])
     VALUES
           ('opp-maintenance-gift00','Compensation for the long server instability and maintenance');

PRINT N'Insert items into Packages for pre-alpha participant levels';
DECLARE @packid int;
SET @packid = (SELECT TOP 1 id FROM packages WHERE name='opp-maintenance-gift00');

DECLARE @aid int;
SET @aid = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_anniversary_package');

DECLARE @epBoostT3 AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_boost_ep_t3');

PRINT N'Items for opp-maintenance-gift00!!!';
INSERT INTO [dbo].[packageitems]
           ([packageid],[definition],[quantity])
     VALUES
           (@packid, @aid, 10);

SET NOEXEC OFF;
PRINT N'DONE INSERTING GIFT-PACKS';
GO


PRINT N'DISTRIBUTE GIFTS TO ALL ACCOUNTS';
DECLARE @packid int;
SET @packid = (SELECT TOP 1 id FROM packages WHERE name='opp-maintenance-gift00');
--TODO use variant of below for future gifting
--This gift gives to all current accounts at patch-time
PRINT N'Give everyone a gift! WARNING CURSOR AHEAD!';
DECLARE @id int;
DECLARE @pass varchar(100);

DECLARE curse CURSOR FOR SELECT accountID FROM accounts
OPEN curse

FETCH NEXT FROM curse INTO @id

WHILE @@FETCH_STATUS = 0 BEGIN
    EXEC dbo.accountPackageProcessOne @id, @packid
    FETCH NEXT FROM curse INTO @id
END

CLOSE curse    
DEALLOCATE curse
PRINT N'DONE';
GO