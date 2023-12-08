USE [perpetuumsa]
GO

-----------------------------
--Changing density and quantity of fields on Hersh, and density on NV
--2023/06/27
-----------------------------

DECLARE @numFields int;
DECLARE @amountTitan int;
DECLARE @amountFaction int;
DECLARE @tileQty int;
DECLARE @titan int;
DECLARE @stermonit int;
DECLARE @imentium int;
DECLARE @silgium int;
DECLARE @zoneID int;


SET @numFields = 12;
SET @amountTitan = 30000000;
SET @amountFaction = 18000000;
SET @tileQty = 200;
SET @titan = (SELECT TOP 1 idx FROM [dbo].[minerals] WHERE name='titan');
SET @stermonit = (SELECT TOP 1 idx FROM [dbo].[minerals] WHERE name='stermonit');
SET @imentium = (SELECT TOP 1 idx FROM [dbo].[minerals] WHERE name='imentium');
SET @silgium = (SELECT TOP 1 idx FROM [dbo].[minerals] WHERE name='silgium');


SET @zoneID = (SELECT TOP 1 id FROM [dbo].[zones] WHERE name='zone_TM_pve' AND note='hershfield');
UPDATE [dbo].[mineralconfigs]
	SET 
	[maxnodes]= @numFields,
	[totalamountpernode]= @amountTitan,
	[maxtilespernode]= @tileQty
	WHERE Zoneid=@zoneID and materialtype=@titan;

UPDATE [dbo].[mineralconfigs]
	SET 
	[maxnodes]= @numFields,
	[totalamountpernode]= @amountFaction,
	[maxtilespernode]= @tileQty
	WHERE Zoneid=@zoneID and materialtype=@stermonit;

UPDATE [dbo].[mineralconfigs]
	SET 
	[maxnodes]= @numFields,
	[totalamountpernode]= @amountFaction,
	[maxtilespernode]= @tileQty
	WHERE Zoneid=@zoneID and materialtype=@imentium;

UPDATE [dbo].[mineralconfigs]
	SET 
	[maxnodes]= @numFields,
	[totalamountpernode]= @amountFaction,
	[maxtilespernode]= @tileQty
	WHERE Zoneid=@zoneID and materialtype=@silgium;

SET @zoneID = (SELECT TOP 1 id FROM [dbo].[zones] WHERE name='zone_TM' AND note='new virginia');
UPDATE [dbo].[mineralconfigs]
	SET [totalamountpernode]= 500
	WHERE Zoneid=@zoneID and materialtype=@titan;

PRINT N'Alpha ores densified';
GO