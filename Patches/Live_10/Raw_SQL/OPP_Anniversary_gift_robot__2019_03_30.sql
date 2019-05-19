USE [perpetuumsa]
GO

-----------------------------------------------
--OPP 1 Year of LIVE server anniversary gifts!
--New robot definition
--New Package and gifts
--Procedure call to distribute gifts
--Date: 2019/03/20
-----------------------------------------------


PRINT N'1. Create entity)';
--WARNING: options string contains references to entitydefaults in hex (Head/leg/chassis are fixed definitions from arkhe mk2)
--ENTITYDEFAULT SAVE NEW
INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled,  volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
VALUES ( 'def_AnniversArkhe_bot', 1, 0, 257, '#head=iae8#chassis=iae9#leg=iaea#container=i147#tier=$tierlevel_mk2', 'New Arkhe for 1yr aniversary!', 1, 12, 0, 'False', 100, 'def_arkhe2_bot_desc', 1, 1, 2); 
GO

PRINT N'2. Create template (from tool)';
--WARNING: description string contains references to entitydefaults in hex
--TEMPLATE INSERT

DECLARE @definitionHex varchar;
--This is how to do lookups, convert to hex, and concat into a genxy compatible string!
SET @definitionHex = (SELECT dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_AnniversArkhe_bot');

INSERT INTO robottemplates ([name], [description], [note]) 
VALUES ('def_anniversarkhe_bot_template', '#robot=i'+@definitionHex+'#head=iae8#chassis=iae9#leg=iaea#container=i147#headModules=[|m0=[|definition=i0|slot=i1]]#chassisModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]]#legModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]]', 'OPP Live 1 year anniversary Reward');
GO

PRINT N'3. Create templaterelation';
INSERT INTO [dbo].[robottemplaterelation]
           ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
     VALUES
           ((SELECT TOP 1 definition from entitydefaults where definitionname='def_AnniversArkhe_bot')
           ,(SELECT TOP 1 id from robottemplates where name='def_anniversarkhe_bot_template'),0,1,NULL,NULL,NULL,'AnniversArkhe Template Relation year1');
GO

PRINT N'4. Insert config w/ desired tint';
INSERT INTO [dbo].[definitionconfig]
           ([definition],[tint],[note])
     VALUES
           ((SELECT TOP 1 definition from entitydefaults where definitionname='def_AnniversArkhe_bot')
           ,'#8bff00'
           ,'Color for AnniversArkhe bot');
GO

PRINT N'5. Give bot skills -- ARKHE MK2 HAS NO ENABLER SKILLS RESULT WILL BE 0 rows affected';
--Use existing bot (that was copied from entitydefault) for extensions
INSERT INTO [dbo].[enablerextensions]
           ([definition],[extensionid],[extensionlevel])
     (SELECT (SELECT TOP 1 definition from entitydefaults where definitionname='def_AnniversArkhe_bot'), extensionid, extensionlevel from enablerextensions where definition=(Select top 1 definition from entitydefaults where definitionname='def_arkhe2_bot'));
GO



PRINT N'Create Packages for pre-alpha participant levels';
INSERT INTO [dbo].[packages]
           ([name],[note])
     VALUES
           ('opp-anniversary01','1 year of OPP Live!');
GO

PRINT N'Insert items into Packages for pre-alpha participant levels';
DECLARE @packid int;
SET @packid = (SELECT TOP 1 id from packages where name='opp-anniversary01');

DECLARE @aid int;
SET @aid = (SELECT TOP 1 definition from entitydefaults where definitionname='def_anniversary_package');

DECLARE @specialBot int;
SET @specialBot = (SELECT TOP 1 definition from entitydefaults where definitionname='def_AnniversArkhe_bot');

DECLARE @epBoostT1 int;
SET @epBoostT1 = (SELECT TOP 1 definition from entitydefaults where definitionname='def_boost_ep_t1');

PRINT N'Items for opp-anniversary01!!!';
INSERT INTO [dbo].[packageitems]
           ([packageid],[definition],[quantity])
     VALUES
           (@packid, @aid, 2), 
		   (@packid, @specialBot, 1),
		   (@packid, @epBoostT1, 1);

GO



DECLARE @packid int;
SET @packid = (SELECT TOP 1 id from packages where name='opp-anniversary01');
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