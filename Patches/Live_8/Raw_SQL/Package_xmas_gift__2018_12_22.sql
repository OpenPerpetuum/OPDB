USE [perpetuumsa]
GO

PRINT N'Create Package for 2018-12 xmas/NYE Patch';
INSERT INTO [dbo].[packages]
           ([name],[note])
     VALUES
           ('gift-2018-xmas','Package for gifting 2018 December Patch');
GO

PRINT N'Insert items into Package - 2x AID';
DECLARE @packid int;
SET @packid = (SELECT TOP 1 id from packages where name='gift-2018-xmas');

DECLARE @aid int;
SET @aid = (SELECT TOP 1 definition from entitydefaults where definitionname='def_anniversary_package');

PRINT N'INSERT item';
INSERT INTO [dbo].[packageitems]
           ([packageid],[definition],[quantity])
     VALUES
           (@packid,@aid,2);



--TODO use variant of below for future gifting
--This gift gives to all current accounts at patch-time
PRINT N'Give everyone a gift! WARNING CURSOR AHEAD!';
DECLARE @id int
DECLARE @pass varchar(100)

DECLARE curse CURSOR FOR SELECT accountID FROM accounts
OPEN curse

FETCH NEXT FROM curse INTO @id

WHILE @@FETCH_STATUS = 0 BEGIN
    EXEC dbo.accountPackageProcessOne @id, @packid
    FETCH NEXT FROM curse INTO @id
END

CLOSE curse    
DEALLOCATE curse

GO


