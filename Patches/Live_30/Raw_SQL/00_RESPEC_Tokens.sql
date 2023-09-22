---- New category for RESPEC Tokens ----

INSERT INTO categoryflags (value, name, note, hidden, isunique) VALUES
(263323, 'cf_respec_tokens', 'RESPEC Tokens', 0, 0)

GO

---- RESPEC Token ----

INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
('def_respec_token', 1, 2052, 263323, '', '', 1, 0.1, 0.1, 0, 100, 'def_respec_token_desc', 1, 0, 0); 

GO

---- Add RESPEC Token into Syndicate shop ----

DECLARE @definition INT
DECLARE @itemshop_preset INT

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_respec_token')
SET @itemshop_preset = (SELECT TOP 1 definition FROM itemshoppresets WHERE name = 'tm_preset_pve')

INSERT INTO itemshop (presetid, targetdefinition, targetamount, tmcoin, icscoin, asicoin, credit, unicoin, globallimit, purchasecount, standing) VALUES
(@itemshop_preset, @definition, 1, null, null, null, 20000000, 3000, null, 0, null)

GO

---- Add new field LastRespec into characters table ----

ALTER TABLE dbo.characters ADD LastRespec datetime NULL
	
GO