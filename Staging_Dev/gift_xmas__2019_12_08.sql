USE [perpetuumsa]
GO

DECLARE @packName varchar(64);
SET @packName = 'gift-2019-xmas';


IF NOT EXISTS (SELECT TOP 1 name from [packages] WHERE name=@packName)
BEGIN
	PRINT N'Create Package for 2019-12 xmas Patch';
	INSERT INTO [dbo].[packages]
			   ([name],[note])
		 VALUES
			   (@packName,'Package for gifting 2019 December Patch');
END


PRINT N'Insert items into Package - 2x AID';
DECLARE @packid int;
SET @packid = (SELECT TOP 1 id FROM packages WHERE name=@packName);

DECLARE @aid int;
SET @aid = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_anniversary_package');

IF EXISTS (SELECT TOP 1 packageid from [dbo].[packageitems] WHERE packageid=@packid)
BEGIN
	PRINT N'Found items in packaged already --  DELETING';
	DELETE FROM [packageitems] WHERE packageid=@packid;
END

PRINT N'INSERTing gift items';
INSERT INTO [dbo].[packageitems]
           ([packageid],[definition],[quantity])
     VALUES
           (@packid,@aid,2);


PRINT N'Give everyone a gift! WARNING CURSOR AHEAD!';
DECLARE @accountID INT;

DECLARE curse CURSOR FOR SELECT accountID FROM accounts
OPEN curse

FETCH NEXT FROM curse INTO @accountID

WHILE @@FETCH_STATUS = 0 BEGIN
    EXEC dbo.accountPackageProcessOne @accountID, @packid
    FETCH NEXT FROM curse INTO @accountID
END

CLOSE curse    
DEALLOCATE curse

GO
