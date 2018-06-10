USE [perpetuumsa]
GO

--SET PROBE SELL PRICE TO 800k
PRINT N'Set price of def_visibility_probe_capsule to 800k';
DECLARE @def int;
DECLARE @sellprice float;


SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_visibility_probe_capsule');
SET @sellprice = 800000;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def 
and isSell=1 and isvendoritem=1;

GO