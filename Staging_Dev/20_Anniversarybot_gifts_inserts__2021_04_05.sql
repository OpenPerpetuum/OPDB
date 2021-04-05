USE [perpetuumsa]
GO

-----------------------------------------------
--OPP 3 Year of LIVE server anniversary gifts!
--New robot definition
--New Package and gifts
--Procedure call to distribute gifts
--Date: 2021/04/05
-----------------------------------------------

DECLARE @botName AS VARCHAR(100) = 'def_anniversarkhe_year3_bot';
DECLARE @botDef AS INT = 5999;

IF EXISTS (SELECT definition FROM entitydefaults WHERE definitionname=@botName)
BEGIN
	PRINT N'BOT ALREADY INSERTED, SKIPPING';
	SET NOEXEC ON;
END


PRINT N'1. Create entity';
--WARNING: options string contains references to entitydefaults in hex (Head/leg/chassis are fixed definitions from arkhe mk2)
--ENTITYDEFAULT SAVE NEW
SET IDENTITY_INSERT entitydefaults ON;
INSERT INTO entitydefaults (definition, definitionname, quantity, attributeflags, categoryflags, options, note, enabled,  volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
VALUES (@botDef, @botName, 1, 0, 257, '#head=iae8#chassis=iae9#leg=iaea#container=i147#tier=$tierlevel_mk2', 'New Arkhe for 3yr aniversary!', 1, 12, 0, 0, 100, CONCAT(@botName, '_desc'), 1, 1, 2); 
SET IDENTITY_INSERT entitydefaults OFF;

PRINT N'2. Create template (from tool)';
--WARNING: description string contains references to entitydefaults in hex
--TEMPLATE INSERT

DECLARE @definitionHex varchar;
--This is how to do lookups, convert to hex, and concat into a genxy compatible string!
SET @definitionHex = (SELECT dbo.ToHex(definition) FROM entitydefaults WHERE definitionname=@botName);

INSERT INTO robottemplates ([name], [description], [note]) 
VALUES (CONCAT(@botName, '_template'), '#robot=i'+@definitionHex+'#head=iae8#chassis=iae9#leg=iaea#container=i147#headModules=[|m0=[|definition=i0|slot=i1]]#chassisModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]]#legModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]]', 'OPP Live 2 year anniversary Reward');


PRINT N'3. Create templaterelation';
INSERT INTO [dbo].[robottemplaterelation]
           ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
     VALUES
           ((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@botName)
           ,(SELECT TOP 1 id FROM robottemplates WHERE name=CONCAT(@botName, '_template')),0,1,NULL,NULL,NULL,'AnniversArkhe Template Relation year3');


PRINT N'4. Insert config w/ desired tint';
INSERT INTO [dbo].[definitionconfig]
           ([definition],[tint],[note])
     VALUES
           ((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@botName)
           ,'#ff99de'
           ,'Color for AnniversArkhe2 bot');


PRINT N'5. Give bot skills -- ARKHE MK2 HAS NO ENABLER SKILLS RESULT WILL BE 0 rows affected';
--Use existing bot (that was copied from entitydefault) for extensions
INSERT INTO [dbo].[enablerextensions] ([definition],[extensionid],[extensionlevel])
     (SELECT (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@botName), extensionid, extensionlevel FROM enablerextensions WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_arkhe2_bot'));

SET NOEXEC OFF;
PRINT N'DONE INSERTING NEW BOT';

IF EXISTS (SELECT * FROM [packages] WHERE name='opp-anniversary03')
BEGIN
	PRINT N'PACKAGE ALREADY CREATED, SKIPPING';
	SET NOEXEC ON;
END

PRINT N'Create Packages for pre-alpha participant levels';
INSERT INTO [dbo].[packages]
           ([name],[note])
     VALUES
           ('opp-anniversary03','3nd year of OPP Live!');

PRINT N'Insert items into Packages for pre-alpha participant levels';
DECLARE @packid int;
SET @packid = (SELECT TOP 1 id FROM packages WHERE name='opp-anniversary03');

DECLARE @aid int;
SET @aid = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_anniversary_package');

DECLARE @specialBot int;
SET @specialBot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@botName);

DECLARE @epBoostT3 AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_boost_ep_t3');

PRINT N'Items for opp-anniversary03!!!';
INSERT INTO [dbo].[packageitems]
           ([packageid],[definition],[quantity])
     VALUES
           (@packid, @aid, 3), 
		   (@packid, @specialBot, 1),
		   (@packid, @epBoostT3, 1);

SET NOEXEC OFF;
PRINT N'DONE INSERTING GIFT-PACKS';
GO


PRINT N'DISTRIBUTE GIFTS TO ALL ACCOUNTS';
DECLARE @packid int;
SET @packid = (SELECT TOP 1 id FROM packages WHERE name='opp-anniversary03');
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