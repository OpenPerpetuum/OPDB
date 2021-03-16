USE [perpetuumsa]
GO

------------------------------------------------
-- Market NPC sell/buy order updates for Syndicates
-- Lights/assault bots
-- Date modified: 2021/03/15
------------------------------------------------


DECLARE @ikarusMarketPrice AS FLOAT = 552000;
DECLARE @vektorMarketPrice AS FLOAT = 817000;
DECLARE @locustMarketPrice AS FLOAT = 2211000;
DECLARE @cronusMarketPrice AS FLOAT = 2616000;
DECLARE @hermesMarketPrice AS FLOAT = 2604000;

DECLARE @vektorDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_vektor_bot');
DECLARE @helixDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_helix_bot');
DECLARE @locustDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_locust_bot');
DECLARE @echelonDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_echelon_bot');
DECLARE @callistoDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_callisto_bot');
DECLARE @legatusDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_legatus_bot');
DECLARE @ikarusDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ikarus_bot');
DECLARE @cronusDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_cronus_bot');
DECLARE @hermesDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_hermes_bot');
DECLARE @daidalosDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_daidalos_bot');
DECLARE @metisDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_metis_bot');


PRINT N'NPC MARKET ORDERS FOR IKARUS';
UPDATE marketitems SET
	price=@ikarusMarketPrice
WHERE duration=0 AND isSell=1 AND quantity=-1 AND isvendoritem=1 AND
itemdefinition=@ikarusDef;

UPDATE marketitems SET
	price=@ikarusMarketPrice/10
WHERE duration=0 AND isSell=0 AND quantity=-1 AND isvendoritem=1 AND
itemdefinition=@ikarusDef;

PRINT N'NPC MARKET ORDERS FOR VEKTOR';
UPDATE marketitems SET
	price=@vektorMarketPrice
WHERE duration=0 AND isSell=1 AND quantity=-1 AND isvendoritem=1 AND
itemdefinition=@vektorDef;

UPDATE marketitems SET
	price=@vektorMarketPrice/10
WHERE duration=0 AND isSell=0 AND quantity=-1 AND isvendoritem=1 AND
itemdefinition=@vektorDef;

PRINT N'NPC MARKET ORDERS FOR LOCUST';
UPDATE marketitems SET
	price=@locustMarketPrice
WHERE duration=0 AND isSell=1 AND quantity=-1 AND isvendoritem=1 AND
itemdefinition=@locustDef;

UPDATE marketitems SET
	price=@locustMarketPrice/10
WHERE duration=0 AND isSell=0 AND quantity=-1 AND isvendoritem=1 AND
itemdefinition=@locustDef;

PRINT N'NPC MARKET ORDERS FOR CRONUS';
UPDATE marketitems SET
	price=@cronusMarketPrice
WHERE duration=0 AND isSell=1 AND quantity=-1 AND isvendoritem=1 AND
itemdefinition=@cronusDef;

UPDATE marketitems SET
	price=@cronusMarketPrice/10
WHERE duration=0 AND isSell=0 AND quantity=-1 AND isvendoritem=1 AND
itemdefinition=@cronusDef;

PRINT N'NPC MARKET ORDERS FOR HERMES';
UPDATE marketitems SET
	price=@hermesMarketPrice
WHERE duration=0 AND isSell=1 AND quantity=-1 AND isvendoritem=1 AND
itemdefinition=@hermesDef;

UPDATE marketitems SET
	price=@hermesMarketPrice/10
WHERE duration=0 AND isSell=0 AND quantity=-1 AND isvendoritem=1 AND
itemdefinition=@hermesDef;

GO


