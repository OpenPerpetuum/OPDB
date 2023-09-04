USE [perpetuumsa]
GO


-------------------------------------------------------------
--PATCH 30: QoL items added (RESPEC)
--00_cf_respec_token_INSERT.sql
--01_def_respec_token_INSERT.sql
--02_itemshop_INSERT.sql
--03_characters_ALTER.sql
--05_RESERVED.sql
--06_RESERVED.sql
--07_RESERVED.sql
--08_RESERVED.sql
-------------------------------------------------------------

USE [perpetuumsa]
GO

----------------------------------------
-- RESPEC Token
-- Date Modified: 2023/09/04
----------------------------------------

PRINT N'Create new items category';
INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
(1435, 'cf_respec_token', 'RESPEC Token', 0, 0)

PRINT N'Create new entity defaults';
INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
('def_respec_token', 1, 2052, 263323, '', '', 1, 0.1, 0.1, 0, 100, 'def_respec_token_desc', 1, 0, 0); 

PRINT N'Put new item on Syndicate market';
DECLARE @definition INT

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_respec_token')

INSERT INTO itemshop (presetid, targetdefinition, targetamount, tmcoin, icscoin, asicoin, credit, unicoin, globallimit, purchasecount, standing) VALUES
(1, @definition, 1, null, null, null, 20000000, 3000, null, 0, null)

PRINT N'Add new field into character to track down RESPEC usage';
ALTER TABLE dbo.characters ADD
	LastRespec datetime NULL

PRINT N'PATCH 30 COMPLETE';
GO
