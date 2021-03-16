USE [perpetuumsa]
GO

------------------------------------------------
-- Market NPC sell/buy order updates for Syndicates
-- Lights/assault bots
-- Date modified: 2021/03/15
------------------------------------------------


DECLARE @lightIndyPrice AS FLOAT = 684000;
DECLARE @lightCombatPrice AS FLOAT = 867000;
DECLARE @assaultIndyPrice AS FLOAT = 2400000;
DECLARE @assaultCombatPrice AS FLOAT = 2340000;

DECLARE @yagelDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_yagel_bot');
DECLARE @prometheusDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_prometheus_bot');
DECLARE @castelDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_castel_bot');

DECLARE @waspishDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_waspish_bot');
DECLARE @arbalestDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_arbalest_bot');
DECLARE @baphometDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_baphomet_bot');

DECLARE @arganoDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_argano_bot');
DECLARE @lairdDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_laird_bot');
DECLARE @sequerDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_sequer_bot');

PRINT N'NPC MARKET ORDERS FOR LIGHT INDY';
UPDATE marketitems SET
	price=@lightIndyPrice
WHERE duration=0 AND isSell=1 AND quantity=-1 AND isvendoritem=1 AND
itemdefinition IN (@arganoDef, @lairdDef);

UPDATE marketitems SET
	price=@lightIndyPrice/10
WHERE duration=0 AND isSell=0 AND quantity=-1 AND isvendoritem=1 AND
itemdefinition IN (@arganoDef, @lairdDef);

PRINT N'NPC MARKET ORDERS FOR LIGHT COMBAT';
UPDATE marketitems SET
	price=@lightCombatPrice
WHERE duration=0 AND isSell=1 AND quantity=-1 AND isvendoritem=1 AND
itemdefinition IN (@castelDef, @yagelDef, @prometheusDef);

UPDATE marketitems SET
	price=@lightCombatPrice/10
WHERE duration=0 AND isSell=0 AND quantity=-1 AND isvendoritem=1 AND
itemdefinition IN (@castelDef, @yagelDef, @prometheusDef);

PRINT N'NPC MARKET ORDERS FOR INDY ASSAULT';
UPDATE marketitems SET
	price=@assaultIndyPrice
WHERE duration=0 AND isSell=1 AND quantity=-1 AND isvendoritem=1 AND
itemdefinition=@sequerDef;

UPDATE marketitems SET
	price=@assaultIndyPrice/10
WHERE duration=0 AND isSell=0 AND quantity=-1 AND isvendoritem=1 AND
itemdefinition=@sequerDef;

PRINT N'NPC MARKET ORDERS FOR COMBAT ASSAULT';
UPDATE marketitems SET
	price=@assaultCombatPrice
WHERE duration=0 AND isSell=1 AND quantity=-1 AND isvendoritem=1 AND
itemdefinition IN (@arbalestDef, @baphometDef, @waspishDef);

UPDATE marketitems SET
	price=@assaultCombatPrice/10
WHERE duration=0 AND isSell=0 AND quantity=-1 AND isvendoritem=1 AND
itemdefinition IN (@arbalestDef, @baphometDef, @waspishDef);

GO


