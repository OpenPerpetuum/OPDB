USE [perpetuumsa]
GO


PRINT N'Create Packages for pre-alpha participant levels';
INSERT INTO [dbo].[packages]
           ([name],[note])
     VALUES
           ('pre-alpha01','standard gift pack for pre-alpha participant'),
		   ('pre-alpha02','advanced gift pack for pre-alpha active community member');
GO

PRINT N'Insert items into Packages for pre-alpha participant levels';
DECLARE @packid int;
SET @packid = (SELECT TOP 1 id from packages where name='pre-alpha01');

DECLARE @aid int;
SET @aid = (SELECT TOP 1 definition from entitydefaults where definitionname='def_anniversary_package');

DECLARE @pinkbot int;
SET @pinkbot = (SELECT TOP 1 definition from entitydefaults where definitionname='def_arkhe2_bot_pink');

PRINT N'Items for pack1';
INSERT INTO [dbo].[packageitems]
           ([packageid],[definition],[quantity])
     VALUES
           (@packid,@aid,3), 
		   (@packid,@pinkbot,1);


PRINT N'Items for pack2';
SET @packid = (SELECT TOP 1 id from packages where name='pre-alpha02');
INSERT INTO [dbo].[packageitems]
           ([packageid],[definition],[quantity])
     VALUES
           (@packid,@aid,5),
		   (@packid,@pinkbot,1);
GO