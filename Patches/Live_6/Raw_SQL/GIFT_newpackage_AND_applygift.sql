USE [perpetuumsa]
GO

PRINT N'Create Package for general purpose use for patch-day gifting';
INSERT INTO [dbo].[packages]
           ([name],[note])
     VALUES
           ('gift','Package that contains 1x gift -- For the occasional holiday and anniversary');
GO

PRINT N'Insert items into Package - 1x AID';
DECLARE @packid int;
SET @packid = (SELECT TOP 1 id from packages where name='gift');

DECLARE @aid int;
SET @aid = (SELECT TOP 1 definition from entitydefaults where definitionname='def_anniversary_package');

PRINT N'INSERT item';
INSERT INTO [dbo].[packageitems]
           ([packageid],[definition],[quantity])
     VALUES
           (@packid,@aid,1);



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


