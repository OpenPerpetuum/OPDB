USE [perpetuumsa]
GO

-----------------------------
--Epriton field count 20->10
--2019/03/10
-----------------------------

DECLARE @numFields int;
DECLARE @epi int;
DECLARE @zoneID int;


SET @numFields = 10;
SET @epi = (SELECT TOP 1 idx FROM [dbo].[minerals] WHERE name='epriton');


SET @zoneID = (SELECT TOP 1 id FROM [dbo].[zones] WHERE name='zone_ICS_A_real' AND note='domhalarn');
UPDATE [dbo].[mineralconfigs]
	SET [maxnodes]= @numFields
	WHERE Zoneid=@zoneID and materialtype=@epi;

SET @zoneID = (SELECT TOP 1 id FROM [dbo].[zones] WHERE name='zone_ASI_A_real' AND note='hokkogaros');
UPDATE [dbo].[mineralconfigs]
	SET [maxnodes]= @numFields
	WHERE Zoneid=@zoneID and materialtype=@epi;

SET @zoneID = (SELECT TOP 1 id FROM [dbo].[zones] WHERE name='zone_TM_A_real' AND note='norhoop');
UPDATE [dbo].[mineralconfigs]
	SET [maxnodes]= @numFields
	WHERE Zoneid=@zoneID and materialtype=@epi;

SET @zoneID = (SELECT TOP 1 id FROM [dbo].[zones] WHERE name='zone_ICS_pvp' AND note='novastrov');
UPDATE [dbo].[mineralconfigs]
	SET [maxnodes]= @numFields
	WHERE Zoneid=@zoneID and materialtype=@epi;

SET @zoneID = (SELECT TOP 1 id FROM [dbo].[zones] WHERE name='zone_TM_pvp' AND note='alsbale');
UPDATE [dbo].[mineralconfigs]
	SET [maxnodes]= @numFields
	WHERE Zoneid=@zoneID and materialtype=@epi;

SET @zoneID = (SELECT TOP 1 id FROM [dbo].[zones] WHERE name='zone_ASI_pvp' AND note='kentagura');
UPDATE [dbo].[mineralconfigs]
	SET [maxnodes]= @numFields
	WHERE Zoneid=@zoneID and materialtype=@epi;

GO
