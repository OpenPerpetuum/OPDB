USE [perpetuumsa]
GO

---------------------------------------------------------
--Market: Intrusion scanner charge price -50%
--Set the intrusion scanner charge to 250k nic from npc orders
--Date: 2019/07/06
---------------------------------------------------------

PRINT N'Set price of def_ammo_intrusion_scan to 250k';
DECLARE @def int;
DECLARE @sellprice float;

SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_intrusion_scan');
SET @sellprice = 250000;


UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def 
and isSell=1 and isvendoritem=1;

GO