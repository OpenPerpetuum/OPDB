USE [perpetuumsa]
GO

PRINT N'DISTRIBUTE GIFTS FOR XMAS PATCH!';


DECLARE @packName AS VARCHAR(64) = 'gift-2020-xmas'; --make sure matches in cursor loop
DECLARE @note AS VARCHAR(MAX) = 'Package for gifting 2020 December Patch';

DECLARE @aidDefName AS VARCHAR(100) = 'def_anniversary_package';
DECLARE @ikarusDefName AS VARCHAR(100) = 'def_ikarus_bot';
DECLARE @bombDefName AS VARCHAR(100) = 'def_area_bomb_capsule';

PRINT N'Create Package';
INSERT INTO [dbo].[packages]
           ([name],[note])
     VALUES
           (@packName,@note);

DECLARE @packid AS INT = (SELECT TOP 1 id FROM packages WHERE name=@packName);

PRINT N'Items for XMAS 2020!!!';
INSERT INTO [dbo].[packageitems]
           ([packageid],[definition],[quantity])
     VALUES
           (@packid, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@aidDefName), 2), 
		   (@packid, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@ikarusDefName), 1),
		   (@packid, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@bombDefName), 1);
GO


DECLARE @packid int;
SET @packid = (SELECT TOP 1 id FROM packages WHERE name='gift-2020-xmas');
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

PRINT N'GIFTS DISTRIBUTED';

GO