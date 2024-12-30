USE perpetuumsa;

GO

---- Fix Black Gropho price

DECLARE @definition INT
DECLARE @itemshop_preset INT
SET @itemshop_preset = (SELECT TOP 1 id FROM itemshoppresets WHERE name = 'daoden_preset')

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_gropho_reward1_bot')

IF NOT EXISTS (SELECT 1 FROM itemshop WHERE targetdefinition = @definition AND presetid = @itemshop_preset)
BEGIN
	INSERT INTO itemshop (presetid, targetdefinition, targetamount, tmcoin, icscoin, asicoin, credit, unicoin, globallimit, purchasecount, standing) VALUES
	(@itemshop_preset, @definition, 1, 50000, NULL, NULL, 5000000000, NULL, NULL, 0, NULL)
END
ELSE
BEGIN
	UPDATE itemshop SET tmcoin = 50000, icscoin = NULL, asicoin = NULL, credit = 5000000000, unicoin = NULL  WHERE targetdefinition = @definition AND presetid = @itemshop_preset
END

GO

---- Fix Martyrs EP reward

DECLARE @targetDefinition INT
DECLARE @templateId INT

SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_cultist_martyr_termis')
	
SET @templateId = (SELECT TOP 1 id FROM robottemplates WHERE name = 'Cultist_Martyr_Termis')

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note) VALUES
(@targetDefinition, @templateId, 2, NULL, NULL, 150, 'def_npc_cultist_martyr_termis')

GO

---- Fix missions reward

UPDATE missionlocations SET agentid = 30 WHERE zoneid = 2

GO