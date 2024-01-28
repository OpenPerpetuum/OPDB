-- Activate Attalica, Tellesis and Shinjalar

UPDATE zones SET active = 1 WHERE name in ('zone_ICS_pve', 'zone_ASI_pve', 'zone_ICS')

GO

-- Move Attalica, Tellesis and Shinjalar

UPDATE zones SET y = 3170 WHERE name = 'zone_ICS'

UPDATE zones SET x = -7670, y = -1000 WHERE name = 'zone_ASI_pve'

UPDATE zones SET x = 1670, y = -5170 WHERE name = 'zone_ICS_pve'

GO

-- Reconfigure teleports

UPDATE teleportdescriptions SET active = 0, listable = 0 WHERE description in ('teleport_column_asipve_4_to_teleport_column_tm_bellicha_Z', 'teleport_column_tm_bellicha_Z_to_teleport_column_asipve_4')

UPDATE teleportdescriptions SET active = 0, listable = 0 WHERE description in ('tp_zone_4_13_to_tp_zone_7_9', 'tp_zone_7_9_to_tp_zone_4_13')

UPDATE teleportdescriptions SET active = 0, listable = 0 WHERE description in ('teleport_column_asipve_6_to_teleport_column_tm_cadavria', 'teleport_column_tm_cadavria_to_teleport_column_asipve_6')

UPDATE teleportdescriptions SET active = 0, listable = 0 WHERE description in ('tp_zone_1_10_to_teleport_column_tmpve_6', 'teleport_column_tmpve_6_to_tp_zone_1_10')

UPDATE teleportdescriptions SET active = 0, listable = 0 WHERE description in ('teleport_column_ics_berwalem_Z_to_teleport_column_tmpve_1', 'teleport_column_tmpve_1_to_teleport_column_ics_berwalem_Z')

UPDATE teleportdescriptions SET active = 0, listable = 0 WHERE description in ('teleport_column_ics_zapetsky_Z_to_teleport_column_icspve_1', 'teleport_column_icspve_1_to_teleport_column_ics_zapetsky_Z')

UPDATE teleportdescriptions SET active = 0, listable = 0 WHERE description in ('tp_zone_6_10_to_teleport_column_ics2_hillmanoc_Z', 'teleport_column_ics2_hillmanoc_Z_to_tp_zone_6_10')

UPDATE teleportdescriptions SET active = 0, listable = 0 WHERE description in ('tp_zone_6_9_to_teleport_column_ics2_vsehovski', 'teleport_column_ics2_vsehovski_to_tp_zone_6_9')

UPDATE teleportdescriptions SET active = 0, listable = 0 WHERE description in ('tp_zone_7_11_to_teleport_column_asi2_gavastrac', 'teleport_column_asi2_gavastrac_to_tp_zone_7_11')

--

IF NOT EXISTS (SELECT 1 FROM teleportdescriptions WHERE description = 'teleport_column_tm_cadavria_to_tp_zone_8_12')
BEGIN
	INSERT INTO teleportdescriptions (description, sourcecolumn, targetcolumn, sourcezone, sourcerange, targetzone, targetx, targety, targetz, targetrange, usetimeout, listable, active, type, sourcecolumnname, targetcolumnname) VALUES
	('teleport_column_tm_cadavria_to_tp_zone_8_12', 105, 250, 7, 7, 8, NULL, NULL, NULL, 7, 0, 1, 1, 2, 'teleport_column_tm_cadavria', 'tp_zone_8_12')
END

IF NOT EXISTS (SELECT 1 FROM teleportdescriptions WHERE description = 'tp_zone_8_12_to_teleport_column_tm_cadavria')
BEGIN
	INSERT INTO teleportdescriptions (description, sourcecolumn, targetcolumn, sourcezone, sourcerange, targetzone, targetx, targety, targetz, targetrange, usetimeout, listable, active, type, sourcecolumnname, targetcolumnname) VALUES
	('tp_zone_8_12_to_teleport_column_tm_cadavria', 250, 105, 8, 7, 7, NULL, NULL, NULL, 7, 0, 1, 1, 2, 'tp_zone_8_12', 'teleport_column_tm_cadavria')
END

--

IF NOT EXISTS (SELECT 1 FROM teleportdescriptions WHERE description = 'teleport_column_asipve_1_to_teleport_column_icspve_3')
BEGIN
	INSERT INTO teleportdescriptions (description, sourcecolumn, targetcolumn, sourcezone, sourcerange, targetzone, targetx, targety, targetz, targetrange, usetimeout, listable, active, type, sourcecolumnname, targetcolumnname) VALUES
	('teleport_column_asipve_1_to_teleport_column_icspve_3', 102, 98, 7, 7, 6, NULL, NULL, NULL, 7, 0, 1, 1, 2, 'teleport_column_asipve_1', 'teleport_column_icspve_3')
END

IF NOT EXISTS (SELECT 1 FROM teleportdescriptions WHERE description = 'teleport_column_icspve_3_to_teleport_column_asipve_1')
BEGIN
	INSERT INTO teleportdescriptions (description, sourcecolumn, targetcolumn, sourcezone, sourcerange, targetzone, targetx, targety, targetz, targetrange, usetimeout, listable, active, type, sourcecolumnname, targetcolumnname) VALUES
	('teleport_column_icspve_3_to_teleport_column_asipve_1', 98, 102, 6, 7, 7, NULL, NULL, NULL, 7, 0, 1, 1, 2, 'teleport_column_icspve_3', 'teleport_column_asipve_1')
END

--

IF NOT EXISTS (SELECT 1 FROM teleportdescriptions WHERE description = 'teleport_column_asipve_1_to_teleport_column_icspve_3')
BEGIN
	INSERT INTO teleportdescriptions (description, sourcecolumn, targetcolumn, sourcezone, sourcerange, targetzone, targetx, targety, targetz, targetrange, usetimeout, listable, active, type, sourcecolumnname, targetcolumnname) VALUES
	('teleport_column_asipve_1_to_teleport_column_icspve_3', 102, 98, 7, 7, 6, NULL, NULL, NULL, 7, 0, 1, 1, 2, 'teleport_column_asipve_1', 'teleport_column_icspve_3')
END

IF NOT EXISTS (SELECT 1 FROM teleportdescriptions WHERE description = 'teleport_column_icspve_3_to_teleport_column_asipve_1')
BEGIN
	INSERT INTO teleportdescriptions (description, sourcecolumn, targetcolumn, sourcezone, sourcerange, targetzone, targetx, targety, targetz, targetrange, usetimeout, listable, active, type, sourcecolumnname, targetcolumnname) VALUES
	('teleport_column_icspve_3_to_teleport_column_asipve_1', 98, 102, 6, 7, 7, NULL, NULL, NULL, 7, 0, 1, 1, 2, 'teleport_column_icspve_3', 'teleport_column_asipve_1')
END

--

IF NOT EXISTS (SELECT 1 FROM teleportdescriptions WHERE description = 'tp_zone_6_8_to_teleport_column_tmpve_1')
BEGIN
	INSERT INTO teleportdescriptions (description, sourcecolumn, targetcolumn, sourcezone, sourcerange, targetzone, targetx, targety, targetz, targetrange, usetimeout, listable, active, type, sourcecolumnname, targetcolumnname) VALUES
	('tp_zone_6_8_to_teleport_column_tmpve_1', 256, 108, 6, 7, 8, NULL, NULL, NULL, 7, 0, 1, 1, 2, 'tp_zone_6_8', 'teleport_column_tmpve_1')
END

IF NOT EXISTS (SELECT 1 FROM teleportdescriptions WHERE description = 'teleport_column_tmpve_1_to_tp_zone_6_8')
BEGIN
	INSERT INTO teleportdescriptions (description, sourcecolumn, targetcolumn, sourcezone, sourcerange, targetzone, targetx, targety, targetz, targetrange, usetimeout, listable, active, type, sourcecolumnname, targetcolumnname) VALUES
	('teleport_column_tmpve_1_to_tp_zone_6_8', 98, 102, 8, 7, 6, NULL, NULL, NULL, 7, 0, 1, 1, 2, 'teleport_column_tmpve_1', 'tp_zone_6_8')
END

--

IF NOT EXISTS (SELECT 1 FROM teleportdescriptions WHERE description = 'teleport_column_ics_zapetsky_Z_to_tp_zone_8_10')
BEGIN
	INSERT INTO teleportdescriptions (description, sourcecolumn, targetcolumn, sourcezone, sourcerange, targetzone, targetx, targety, targetz, targetrange, usetimeout, listable, active, type, sourcecolumnname, targetcolumnname) VALUES
	('teleport_column_ics_zapetsky_Z_to_tp_zone_8_10', 1303, 248, 1, 7, 8, NULL, NULL, NULL, 7, 0, 1, 1, 2, 'teleport_column_ics_zapetsky_Z', 'tp_zone_8_10')
END

IF NOT EXISTS (SELECT 1 FROM teleportdescriptions WHERE description = 'tp_zone_8_10_to_teleport_column_ics_zapetsky_Z')
BEGIN
	INSERT INTO teleportdescriptions (description, sourcecolumn, targetcolumn, sourcezone, sourcerange, targetzone, targetx, targety, targetz, targetrange, usetimeout, listable, active, type, sourcecolumnname, targetcolumnname) VALUES
	('tp_zone_8_10_to_teleport_column_ics_zapetsky_Z', 248, 1303, 8, 7, 1, NULL, NULL, NULL, 7, 0, 1, 1, 2, 'tp_zone_8_10', 'teleport_column_ics_zapetsky_Z')
END

--

IF NOT EXISTS (SELECT 1 FROM teleportdescriptions WHERE description = 'tp_zone_1_10_to_teleport_column_asipve_6')
BEGIN
	INSERT INTO teleportdescriptions (description, sourcecolumn, targetcolumn, sourcezone, sourcerange, targetzone, targetx, targety, targetz, targetrange, usetimeout, listable, active, type, sourcecolumnname, targetcolumnname) VALUES
	('tp_zone_1_10_to_teleport_column_asipve_6', 3339, 107, 1, 7, 7, NULL, NULL, NULL, 7, 0, 1, 1, 2, 'tp_zone_1_10', 'teleport_column_asipve_6')
END

IF NOT EXISTS (SELECT 1 FROM teleportdescriptions WHERE description = 'teleport_column_asipve_6_to_tp_zone_1_10')
BEGIN
	INSERT INTO teleportdescriptions (description, sourcecolumn, targetcolumn, sourcezone, sourcerange, targetzone, targetx, targety, targetz, targetrange, usetimeout, listable, active, type, sourcecolumnname, targetcolumnname) VALUES
	('teleport_column_asipve_6_to_tp_zone_1_10', 107, 3339, 7, 7, 1, NULL, NULL, NULL, 7, 0, 1, 1, 2, 'teleport_column_asipve_6', 'tp_zone_1_10')
END

GO

-- Disable existing Tellesis and Shinjalar spawns

UPDATE p
SET p.enabled = 0
FROM npcpresence p 
INNER JOIN zones z 
ON p.spawnid = z.spawnid
WHERE z.name IN ('zone_ICS_pve', 'zone_ASI_pve', 'zone_ICS') AND p.enabled = 1 AND p.izgroupid IS NULL

GO

-- Create and fill new npc

DECLARE @sourceDefinition INT
DECLARE @targetDefinition INT

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_kain_dps_l3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_tellesis_kain_dps_l3', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_tellesis_kain_dps_l3_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_kain_dps_l3'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_kain_dps_l3')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_kain_dps_l3')

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

INSERT INTO aggregatevalues
SELECT @targetDefinition, field, value FROM aggregatevalues where definition = @sourceDefinition

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note)
SELECT @targetDefinition, templateId, raceid, missionlevel, missionleveloverride, killep, note FROM robottemplaterelation WHERE definition = @sourceDefinition

DELETE FROM npcloot WHERE definition = @targetDefinition

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, nl.lootdefinition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults ed ON nl.lootdefinition = ed.definition
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4))

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_arbalest_dps_l3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_tellesis_arbalest_dps_l3', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_tellesis_arbalest_dps_l3_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_arbalest_dps_l3'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_arbalest_dps_l3')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_arbalest_dps_l3')

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

INSERT INTO aggregatevalues
SELECT @targetDefinition, field, value FROM aggregatevalues where definition = @sourceDefinition

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note)
SELECT @targetDefinition, templateId, raceid, missionlevel, missionleveloverride, killep, note FROM robottemplaterelation WHERE definition = @sourceDefinition

DELETE FROM npcloot WHERE definition = @targetDefinition

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, nl.lootdefinition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults ed ON nl.lootdefinition = ed.definition
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4))

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_cameleon_shield_l3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_tellesis_cameleon_shield_l3', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_tellesis_cameleon_shield_l3_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_cameleon_shield_l3'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_cameleon_shield_l3')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_cameleon_shield_l3')

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

INSERT INTO aggregatevalues
SELECT @targetDefinition, field, value FROM aggregatevalues where definition = @sourceDefinition

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note)
SELECT @targetDefinition, templateId, raceid, missionlevel, missionleveloverride, killep, note FROM robottemplaterelation WHERE definition = @sourceDefinition

DELETE FROM npcloot WHERE definition = @targetDefinition

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, nl.lootdefinition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults ed ON nl.lootdefinition = ed.definition
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4))

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_sequer_basic_lindy')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_tellesis_sequer_basic_lindy', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_tellesis_sequer_basic_lindy_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_sequer_basic_lindy'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_sequer_basic_lindy')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_sequer_basic_lindy')

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

INSERT INTO aggregatevalues
SELECT @targetDefinition, field, value FROM aggregatevalues where definition = @sourceDefinition

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note)
SELECT @targetDefinition, templateId, raceid, missionlevel, missionleveloverride, killep, note FROM robottemplaterelation WHERE definition = @sourceDefinition

DELETE FROM npcloot WHERE definition = @targetDefinition

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, nl.lootdefinition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults ed ON nl.lootdefinition = ed.definition
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4))

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_riveler_basic_lindy')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_tellesis_riveler_basic_lindy', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_tellesis_riveler_basic_lindy_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_riveler_basic_lindy'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_riveler_basic_lindy')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_riveler_basic_lindy')

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

INSERT INTO aggregatevalues
SELECT @targetDefinition, field, value FROM aggregatevalues where definition = @sourceDefinition

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note)
SELECT @targetDefinition, templateId, raceid, missionlevel, missionleveloverride, killep, note FROM robottemplaterelation WHERE definition = @sourceDefinition

DELETE FROM npcloot WHERE definition = @targetDefinition

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, nl.lootdefinition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults ed ON nl.lootdefinition = ed.definition
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4))

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_laird_basic_lindy')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_tellesis_laird_basic_lindy', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_tellesis_laird_basic_lindy_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_laird_basic_lindy'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_laird_basic_lindy')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_laird_basic_lindy')

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

INSERT INTO aggregatevalues
SELECT @targetDefinition, field, value FROM aggregatevalues where definition = @sourceDefinition

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note)
SELECT @targetDefinition, templateId, raceid, missionlevel, missionleveloverride, killep, note FROM robottemplaterelation WHERE definition = @sourceDefinition

DELETE FROM npcloot WHERE definition = @targetDefinition

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, nl.lootdefinition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults ed ON nl.lootdefinition = ed.definition
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4))

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_mesmer_tank_l3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_tellesis_mesmer_tank_l3', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_tellesis_mesmer_tank_l3_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_mesmer_tank_l3'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_mesmer_tank_l3')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_mesmer_tank_l3')

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

INSERT INTO aggregatevalues
SELECT @targetDefinition, field, value FROM aggregatevalues where definition = @sourceDefinition

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note)
SELECT @targetDefinition, templateId, raceid, missionlevel, missionleveloverride, killep, note FROM robottemplaterelation WHERE definition = @sourceDefinition

DELETE FROM npcloot WHERE definition = @targetDefinition

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, nl.lootdefinition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults ed ON nl.lootdefinition = ed.definition
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4))

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_kain_tank_l3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_tellesis_kain_tank_l3', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_tellesis_kain_tank_l3_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_kain_tank_l3'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_kain_tank_l3')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_kain_tank_l3')

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

INSERT INTO aggregatevalues
SELECT @targetDefinition, field, value FROM aggregatevalues where definition = @sourceDefinition

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note)
SELECT @targetDefinition, templateId, raceid, missionlevel, missionleveloverride, killep, note FROM robottemplaterelation WHERE definition = @sourceDefinition

DELETE FROM npcloot WHERE definition = @targetDefinition

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, nl.lootdefinition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults ed ON nl.lootdefinition = ed.definition
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4))

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_vagabond_armor_l3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_tellesis_vagabond_armor_l3', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_tellesis_vagabond_armor_l3_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_vagabond_armor_l3'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_vagabond_armor_l3')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_vagabond_armor_l3')

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

INSERT INTO aggregatevalues
SELECT @targetDefinition, field, value FROM aggregatevalues where definition = @sourceDefinition

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note)
SELECT @targetDefinition, templateId, raceid, missionlevel, missionleveloverride, killep, note FROM robottemplaterelation WHERE definition = @sourceDefinition

DELETE FROM npcloot WHERE definition = @targetDefinition

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, nl.lootdefinition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults ed ON nl.lootdefinition = ed.definition
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4))

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_cameleon_armor_l3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_tellesis_cameleon_armor_l3', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_tellesis_cameleon_armor_l3_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_cameleon_armor_l3'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_cameleon_armor_l3')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_cameleon_armor_l3')

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

INSERT INTO aggregatevalues
SELECT @targetDefinition, field, value FROM aggregatevalues where definition = @sourceDefinition

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note)
SELECT @targetDefinition, templateId, raceid, missionlevel, missionleveloverride, killep, note FROM robottemplaterelation WHERE definition = @sourceDefinition

DELETE FROM npcloot WHERE definition = @targetDefinition

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, nl.lootdefinition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults ed ON nl.lootdefinition = ed.definition
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4))

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_yagel_dps_l3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_tellesis_yagel_dps_l3', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_tellesis_yagel_dps_l3_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_yagel_dps_l3'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_yagel_dps_l3')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_yagel_dps_l3')

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

INSERT INTO aggregatevalues
SELECT @targetDefinition, field, value FROM aggregatevalues where definition = @sourceDefinition

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note)
SELECT @targetDefinition, templateId, raceid, missionlevel, missionleveloverride, killep, note FROM robottemplaterelation WHERE definition = @sourceDefinition

DELETE FROM npcloot WHERE definition = @targetDefinition

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, nl.lootdefinition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults ed ON nl.lootdefinition = ed.definition
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4))

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_mesmer_dps_l3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_tellesis_mesmer_dps_l3', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_tellesis_mesmer_dps_l3_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_mesmer_dps_l3'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_mesmer_dps_l3')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_mesmer_dps_l3')

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

INSERT INTO aggregatevalues
SELECT @targetDefinition, field, value FROM aggregatevalues where definition = @sourceDefinition

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note)
SELECT @targetDefinition, templateId, raceid, missionlevel, missionleveloverride, killep, note FROM robottemplaterelation WHERE definition = @sourceDefinition

DELETE FROM npcloot WHERE definition = @targetDefinition

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, nl.lootdefinition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults ed ON nl.lootdefinition = ed.definition
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4))

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_yagel_speed_l3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_tellesis_yagel_speed_l3', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_tellesis_yagel_speed_l3_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_yagel_speed_l3'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_yagel_speed_l3')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_yagel_speed_l3')

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

INSERT INTO aggregatevalues
SELECT @targetDefinition, field, value FROM aggregatevalues where definition = @sourceDefinition

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note)
SELECT @targetDefinition, templateId, raceid, missionlevel, missionleveloverride, killep, note FROM robottemplaterelation WHERE definition = @sourceDefinition

DELETE FROM npcloot WHERE definition = @targetDefinition

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, nl.lootdefinition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults ed ON nl.lootdefinition = ed.definition
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4))

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_arbalest_speed_l3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_tellesis_arbalest_speed_l3', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_tellesis_arbalest_speed_l3_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_arbalest_speed_l3'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_arbalest_speed_l3')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_arbalest_speed_l3')

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

INSERT INTO aggregatevalues
SELECT @targetDefinition, field, value FROM aggregatevalues where definition = @sourceDefinition

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note)
SELECT @targetDefinition, templateId, raceid, missionlevel, missionleveloverride, killep, note FROM robottemplaterelation WHERE definition = @sourceDefinition

DELETE FROM npcloot WHERE definition = @targetDefinition

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, nl.lootdefinition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults ed ON nl.lootdefinition = ed.definition
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4))

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_argano_basic_lindy')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_tellesis_argano_basic_lindy', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_tellesis_argano_basic_lindy_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_argano_basic_lindy'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_argano_basic_lindy')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_argano_basic_lindy')

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

INSERT INTO aggregatevalues
SELECT @targetDefinition, field, value FROM aggregatevalues where definition = @sourceDefinition

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note)
SELECT @targetDefinition, templateId, raceid, missionlevel, missionleveloverride, killep, note FROM robottemplaterelation WHERE definition = @sourceDefinition

DELETE FROM npcloot WHERE definition = @targetDefinition

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, nl.lootdefinition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults ed ON nl.lootdefinition = ed.definition
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4))

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_felos_nuimqol_pitboss')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_tellesis_felos_nuimqol_pitboss', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_tellesis_felos_nuimqol_pitboss_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_felos_nuimqol_pitboss'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_felos_nuimqol_pitboss')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_felos_nuimqol_pitboss')

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

INSERT INTO aggregatevalues
SELECT @targetDefinition, field, value FROM aggregatevalues where definition = @sourceDefinition

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note)
SELECT @targetDefinition, templateId, raceid, missionlevel, missionleveloverride, killep, note FROM robottemplaterelation WHERE definition = @sourceDefinition

DELETE FROM npcloot WHERE definition = @targetDefinition

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, nl.lootdefinition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults ed ON nl.lootdefinition = ed.definition
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4))

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_mesmer_miniboss_rank3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_tellesis_mesmer_miniboss_rank3', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_tellesis_mesmer_miniboss_rank3_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_mesmer_miniboss_rank3'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_mesmer_miniboss_rank3')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_mesmer_miniboss_rank3')

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

INSERT INTO aggregatevalues
SELECT @targetDefinition, field, value FROM aggregatevalues where definition = @sourceDefinition

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note)
SELECT @targetDefinition, templateId, raceid, missionlevel, missionleveloverride, killep, note FROM robottemplaterelation WHERE definition = @sourceDefinition

DELETE FROM npcloot WHERE definition = @targetDefinition

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, nl.lootdefinition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults ed ON nl.lootdefinition = ed.definition
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4))

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_vagabond_miniboss_rank3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_tellesis_vagabond_miniboss_rank3', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_tellesis_vagabond_miniboss_rank3_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_vagabond_miniboss_rank3'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_vagabond_miniboss_rank3')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_vagabond_miniboss_rank3')

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

INSERT INTO aggregatevalues
SELECT @targetDefinition, field, value FROM aggregatevalues where definition = @sourceDefinition

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note)
SELECT @targetDefinition, templateId, raceid, missionlevel, missionleveloverride, killep, note FROM robottemplaterelation WHERE definition = @sourceDefinition

DELETE FROM npcloot WHERE definition = @targetDefinition

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, nl.lootdefinition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults ed ON nl.lootdefinition = ed.definition
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4))

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_mesmer_boss_miniboss')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_tellesis_mesmer_boss_miniboss', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_tellesis_mesmer_boss_miniboss_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_mesmer_boss_miniboss'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_mesmer_boss_miniboss')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_mesmer_boss_miniboss')

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

INSERT INTO aggregatevalues
SELECT @targetDefinition, field, value FROM aggregatevalues where definition = @sourceDefinition

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note)
SELECT @targetDefinition, templateId, raceid, missionlevel, missionleveloverride, killep, note FROM robottemplaterelation WHERE definition = @sourceDefinition

DELETE FROM npcloot WHERE definition = @targetDefinition

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, nl.lootdefinition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults ed ON nl.lootdefinition = ed.definition
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4))

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_vagabond_shield_l7')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_tellesis_vagabond_shield_l7', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_tellesis_vagabond_shield_l7_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_vagabond_shield_l7'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_vagabond_shield_l7')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_vagabond_shield_l7')

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

INSERT INTO aggregatevalues
SELECT @targetDefinition, field, value FROM aggregatevalues where definition = @sourceDefinition

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note)
SELECT @targetDefinition, templateId, raceid, missionlevel, missionleveloverride, killep, note FROM robottemplaterelation WHERE definition = @sourceDefinition

DELETE FROM npcloot WHERE definition = @targetDefinition

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, nl.lootdefinition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults ed ON nl.lootdefinition = ed.definition
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4))

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_kain_dps_l7')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_tellesis_kain_dps_l7', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_tellesis_kain_dps_l7_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_kain_dps_l7'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_kain_dps_l7')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_kain_dps_l7')

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

INSERT INTO aggregatevalues
SELECT @targetDefinition, field, value FROM aggregatevalues where definition = @sourceDefinition

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note)
SELECT @targetDefinition, templateId, raceid, missionlevel, missionleveloverride, killep, note FROM robottemplaterelation WHERE definition = @sourceDefinition

DELETE FROM npcloot WHERE definition = @targetDefinition

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, nl.lootdefinition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults ed ON nl.lootdefinition = ed.definition
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4))

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_arbalest_advanced_courier')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_tellesis_arbalest_advanced_courier', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_tellesis_arbalest_advanced_courier_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_arbalest_advanced_courier'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_arbalest_advanced_courier')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_arbalest_advanced_courier')

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

INSERT INTO aggregatevalues
SELECT @targetDefinition, field, value FROM aggregatevalues where definition = @sourceDefinition

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note)
SELECT @targetDefinition, templateId, raceid, missionlevel, missionleveloverride, killep, note FROM robottemplaterelation WHERE definition = @sourceDefinition

DELETE FROM npcloot WHERE definition = @targetDefinition

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, nl.lootdefinition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults ed ON nl.lootdefinition = ed.definition
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4))

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_cameleon_advanced_courier')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_tellesis_cameleon_advanced_courier', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_tellesis_cameleon_advanced_courier_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_cameleon_advanced_courier'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_cameleon_advanced_courier')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_cameleon_advanced_courier')

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

INSERT INTO aggregatevalues
SELECT @targetDefinition, field, value FROM aggregatevalues where definition = @sourceDefinition

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note)
SELECT @targetDefinition, templateId, raceid, missionlevel, missionleveloverride, killep, note FROM robottemplaterelation WHERE definition = @sourceDefinition

DELETE FROM npcloot WHERE definition = @targetDefinition

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, nl.lootdefinition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults ed ON nl.lootdefinition = ed.definition
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4))

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_sequer_advanced_courier')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_tellesis_sequer_advanced_courier', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_tellesis_sequer_advanced_courier_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_sequer_advanced_courier'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_sequer_advanced_courier')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_sequer_advanced_courier')

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

INSERT INTO aggregatevalues
SELECT @targetDefinition, field, value FROM aggregatevalues where definition = @sourceDefinition

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note)
SELECT @targetDefinition, templateId, raceid, missionlevel, missionleveloverride, killep, note FROM robottemplaterelation WHERE definition = @sourceDefinition

DELETE FROM npcloot WHERE definition = @targetDefinition

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, nl.lootdefinition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults ed ON nl.lootdefinition = ed.definition
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4))

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_yagel_advanced_courier')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_tellesis_yagel_advanced_courier', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_tellesis_yagel_advanced_courier_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_yagel_advanced_courier'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_yagel_advanced_courier')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_yagel_advanced_courier')

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

INSERT INTO aggregatevalues
SELECT @targetDefinition, field, value FROM aggregatevalues where definition = @sourceDefinition

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note)
SELECT @targetDefinition, templateId, raceid, missionlevel, missionleveloverride, killep, note FROM robottemplaterelation WHERE definition = @sourceDefinition

DELETE FROM npcloot WHERE definition = @targetDefinition

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, nl.lootdefinition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults ed ON nl.lootdefinition = ed.definition
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4))

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_hermes_advanced_courier')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_tellesis_hermes_advanced_courier', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_tellesis_hermes_advanced_courier_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_hermes_advanced_courier'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_hermes_advanced_courier')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_hermes_advanced_courier')

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

INSERT INTO aggregatevalues
SELECT @targetDefinition, field, value FROM aggregatevalues where definition = @sourceDefinition

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note)
SELECT @targetDefinition, templateId, raceid, missionlevel, missionleveloverride, killep, note FROM robottemplaterelation WHERE definition = @sourceDefinition

DELETE FROM npcloot WHERE definition = @targetDefinition

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, nl.lootdefinition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults ed ON nl.lootdefinition = ed.definition
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4))

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_mesmer_advanced_observer')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_tellesis_mesmer_advanced_observer', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_tellesis_mesmer_advanced_observer_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_mesmer_advanced_observer'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_mesmer_advanced_observer')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_mesmer_advanced_observer')

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

INSERT INTO aggregatevalues
SELECT @targetDefinition, field, value FROM aggregatevalues where definition = @sourceDefinition

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note)
SELECT @targetDefinition, templateId, raceid, missionlevel, missionleveloverride, killep, note FROM robottemplaterelation WHERE definition = @sourceDefinition

DELETE FROM npcloot WHERE definition = @targetDefinition

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, nl.lootdefinition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults ed ON nl.lootdefinition = ed.definition
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4))

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_kain_advanced_observer')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_tellesis_kain_advanced_observer', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_tellesis_kain_advanced_observer_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_kain_advanced_observer'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_kain_advanced_observer')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_kain_advanced_observer')

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

INSERT INTO aggregatevalues
SELECT @targetDefinition, field, value FROM aggregatevalues where definition = @sourceDefinition

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note)
SELECT @targetDefinition, templateId, raceid, missionlevel, missionleveloverride, killep, note FROM robottemplaterelation WHERE definition = @sourceDefinition

DELETE FROM npcloot WHERE definition = @targetDefinition

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, nl.lootdefinition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults ed ON nl.lootdefinition = ed.definition
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4))

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_vagabond_advanced_observer')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_tellesis_vagabond_advanced_observer', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_tellesis_vagabond_advanced_observer_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_vagabond_advanced_observer'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_vagabond_advanced_observer')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_vagabond_advanced_observer')

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

INSERT INTO aggregatevalues
SELECT @targetDefinition, field, value FROM aggregatevalues where definition = @sourceDefinition

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note)
SELECT @targetDefinition, templateId, raceid, missionlevel, missionleveloverride, killep, note FROM robottemplaterelation WHERE definition = @sourceDefinition

DELETE FROM npcloot WHERE definition = @targetDefinition

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, nl.lootdefinition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults ed ON nl.lootdefinition = ed.definition
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4))

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3


GO

-- Add roamers for Tellesis

DECLARE @spawnid INT
DECLARE @presenceid INT
DECLARE @definition INT
DECLARE @templateid INT

SET @spawnid = (SELECT TOP 1 spawnid FROM zones WHERE name = 'zone_ICS_pve')

--- roamers 1

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'roamer_01_z6' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('roamer_01_z6', 10, 10, 2038, 2038, 'Tellesis roamers 1', @spawnid, 1, 1, 7200, 5, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'roamer_01_z6'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'roamer_01_z6')

----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_kain_dps_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_01_z6_kain_dps_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_01_z6_kain_dps_l3', @presenceid, 2, @definition, 0, 0, 0, 10, 7200, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_arbalest_dps_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_01_z6_arbalest_dps_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_01_z6_arbalest_dps_l3', @presenceid, 4, @definition, 0, 0, 0, 10, 7200, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_cameleon_shield_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_01_z6_cameleon_shield_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_01_z6_cameleon_shield_l3', @presenceid, 3, @definition, 0, 0, 0, 10, 7200, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

--- roamers 2

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'roamer_02_z6' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('roamer_02_z6', 10, 10, 2038, 2038, 'Tellesis roamers 2', @spawnid, 1, 1, 7200, 5, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'roamer_02_z6'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'roamer_02_z6')

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_sequer_basic_lindy')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_02_z6_riveler_basic_lindy')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_02_z6_sequer_basic_lindy', @presenceid, 2, @definition, 0, 0, 0, 10, 7200, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_riveler_basic_lindy')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_02_z6_riveler_basic_lindy')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_02_z6_riveler_basic_lindy', @presenceid, 1, @definition, 0, 0, 0, 10, 7200, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_laird_basic_lindy')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_02_z6_laird_basic_lindy')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_02_z6_laird_basic_lindy', @presenceid, 2, @definition, 0, 0, 0, 10, 7200, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_mesmer_tank_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_02_z6_mesmer_tank_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_02_z6_mesmer_tank_l3', @presenceid, 1, @definition, 0, 0, 0, 10, 7200, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_kain_tank_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_02_z6_kain_tank_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_02_z6_kain_tank_l3', @presenceid, 3, @definition, 0, 0, 0, 10, 7200, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_vagabond_armor_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_02_z6_vagabond_armor_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_02_z6_vagabond_armor_l3', @presenceid, 1, @definition, 0, 0, 0, 10, 7200, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_cameleon_armor_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_02_z6_cameleon_armor_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_02_z6_cameleon_armor_l3', @presenceid, 2, @definition, 0, 0, 0, 10, 7200, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_cameleon_armor_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_02_z6_yagel_speed_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_02_z6_yagel_speed_l3', @presenceid, 2, @definition, 0, 0, 0, 10, 7200, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

--- roamers 3

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'roamer_03_z6' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('roamer_03_z6', 10, 10, 2038, 2038, 'Tellesis roamers 3', @spawnid, 1, 1, 7200, 5, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'roamer_03_z6'
END


SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'roamer_03_z6')

----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_arbalest_dps_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_03_z6_arbalest_dps_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_03_z6_arbalest_dps_l3', @presenceid, 4, @definition, 0, 0, 0, 10, 7200, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_vagabond_armor_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_03_z6_vagabond_armor_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_03_z6_vagabond_armor_l3', @presenceid, 2, @definition, 0, 0, 0, 10, 7200, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_yagel_dps_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_03_z6_yagel_dps_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_03_z6_yagel_dps_l3', @presenceid, 3, @definition, 0, 0, 0, 10, 7200, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

--- roamers 4

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'roamer_04_z6' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('roamer_04_z6', 10, 10, 2038, 2038, 'Tellesis roamers 4', @spawnid, 1, 1, 7200, 5, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'roamer_04_z6'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'roamer_04_z6')

----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_mesmer_dps_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_04_z6_mesmer_dps_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_04_z6_mesmer_dps_l3', @presenceid, 3, @definition, 0, 0, 0, 10, 7200, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_yagel_speed_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_04_z6_yagel_speed_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_04_z6_yagel_speed_l3', @presenceid, 3, @definition, 0, 0, 0, 10, 7200, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_arbalest_speed_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_04_z6_arbalest_speed_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_04_z6_arbalest_speed_l3', @presenceid, 4, @definition, 0, 0, 0, 10, 7200, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

--- roamers 5

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'roamer_05_z6' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('roamer_05_z6', 10, 10, 2038, 2038, 'Tellesis roamers 5', @spawnid, 1, 1, 7200, 5, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'roamer_05_z6'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'roamer_05_z6')

----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_kain_dps_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_05_z6_kain_dps_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_05_z6_kain_dps_l3', @presenceid, 3, @definition, 0, 0, 0, 10, 7200, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_vagabond_armor_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_05_z6_vagabond_armor_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_05_z6_vagabond_armor_l3', @presenceid, 1, @definition, 0, 0, 0, 10, 7200, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_cameleon_armor_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_05_z6_cameleon_armor_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_05_z6_cameleon_armor_l3', @presenceid, 1, @definition, 0, 0, 0, 10, 7200, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_yagel_dps_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_05_z6_yagel_dps_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_05_z6_yagel_dps_l3', @presenceid, 3, @definition, 0, 0, 0, 10, 7200, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

--- roamers 6

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'roamer_06_z6' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('roamer_06_z6', 10, 10, 2038, 2038, 'Tellesis roamers 6', @spawnid, 1, 1, 7200, 5, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'roamer_06_z6'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'roamer_06_z6')

----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_yagel_speed_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_06_z6_yagel_speed_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_06_z6_yagel_speed_l3', @presenceid, 3, @definition, 0, 0, 0, 10, 7200, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_arbalest_speed_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_06_z6_arbalest_speed_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_06_z6_arbalest_speed_l3', @presenceid, 4, @definition, 0, 0, 0, 10, 7200, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_cameleon_shield_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_06_z6_cameleon_shield_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_06_z6_cameleon_shield_l3', @presenceid, 2, @definition, 0, 0, 0, 10, 7200, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_kain_dps_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_06_z6_kain_dps_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_06_z6_kain_dps_l3', @presenceid, 3, @definition, 0, 0, 0, 10, 7200, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

--- roamers 7

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'roamer_07_z6' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('roamer_07_z6', 10, 10, 2038, 2038, 'Tellesis roamers 7', @spawnid, 1, 1, 7200, 5, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'roamer_07_z6'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'roamer_07_z6')

----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_yagel_speed_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_07_z6_yagel_speed_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_07_z6_yagel_speed_l3', @presenceid, 2, @definition, 0, 0, 0, 10, 7200, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_cameleon_shield_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_07_z6_cameleon_shield_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_07_z6_cameleon_shield_l3', @presenceid, 2, @definition, 0, 0, 0, 10, 7200, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_arbalest_dps_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_07_z6_arbalest_dps_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_07_z6_arbalest_dps_l3', @presenceid, 2, @definition, 0, 0, 0, 10, 7200, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

--- roamers 8

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'roamer_08_z6' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('roamer_08_z6', 10, 10, 2038, 2038, 'Tellesis roamers 8', @spawnid, 1, 1, 7200, 5, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'roamer_08_z6'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'roamer_08_z6')

----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_mesmer_dps_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_08_z6_mesmer_dps_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_08_z6_mesmer_dps_l3', @presenceid, 2, @definition, 0, 0, 0, 10, 7200, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_kain_dps_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_08_z6_kain_dps_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_08_z6_kain_dps_l3', @presenceid, 5, @definition, 0, 0, 0, 10, 7200, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_cameleon_armor_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_08_z6_cameleon_armor_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_08_z6_cameleon_armor_l3', @presenceid, 2, @definition, 0, 0, 0, 10, 7200, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_yagel_dps_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_08_z6_yagel_dps_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_08_z6_yagel_dps_l3', @presenceid, 3, @definition, 0, 0, 0, 10, 7200, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

--- roamers 9

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'roamer_09_z6' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('roamer_09_z6', 10, 10, 2038, 2038, 'Tellesis roamers 9', @spawnid, 1, 1, 7200, 5, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'roamer_09_z6'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'roamer_09_z6')

----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_sequer_basic_lindy')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_09_z6_sequer_basic_lindy')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_09_z6_sequer_basic_lindy', @presenceid, 1, @definition, 0, 0, 0, 10, 7200, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_laird_basic_lindy')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_09_z6_laird_basic_lindy')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_09_z6_laird_basic_lindy', @presenceid, 1, @definition, 0, 0, 0, 10, 7200, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_argano_basic_lindy')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_09_z6_argano_basic_lindy')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_09_z6_argano_basic_lindy', @presenceid, 1, @definition, 0, 0, 0, 10, 7200, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_arbalest_speed_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_09_z6_arbalest_speed_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_09_z6_arbalest_speed_l3', @presenceid, 2, @definition, 0, 0, 0, 10, 7200, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_yagel_speed_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_09_z6_yagel_speed_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_09_z6_yagel_speed_l3', @presenceid, 1, @definition, 0, 0, 0, 10, 7200, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

--- pitboss

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'pitboss_01_z6' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('pitboss_01_z6', 300, 380, 400, 500, 'Tellesis pitboss', @spawnid, 1, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'pitboss_01_z6'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'pitboss_01_z6')

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_felos_nuimqol_pitboss')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'pitboss_01_z6_def_npc_tellesis_felos_nuimqol_pitboss')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('pitboss_01_z6_def_npc_tellesis_felos_nuimqol_pitboss', @presenceid, 1, @definition, 350, 440, 0, 15, 432000, 0, 90, 'tellesis boss npc', 0.9, 1, 1, 2, 1)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_mesmer_miniboss_rank3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'pitboss_01_z6_def_npc_tellesis_mesmer_miniboss_rank3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('pitboss_01_z6_def_npc_tellesis_mesmer_miniboss_rank3', @presenceid, 1, @definition, 350, 440, 0, 15, 432000, 0, 90, 'tellesis boss npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_vagabond_miniboss_rank3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'pitboss_01_z6_def_npc_tellesis_vagabond_miniboss_rank3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('pitboss_01_z6_def_npc_tellesis_vagabond_miniboss_rank3', @presenceid, 2, @definition, 350, 440, 0, 15, 432000, 0, 90, 'tellesis boss npc', 0.9, 1, 1, 2, 0)
END

--- miniboss

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'miniboss_01_z6' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('miniboss_01_z6', 1910, 495, 2000, 600, 'Tellesis miniboss', @spawnid, 1, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'miniboss_01_z6'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'miniboss_01_z6')

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_mesmer_boss_miniboss')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'miniboss_01_z6_def_npc_tellesis_mesmer_boss_miniboss')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('miniboss_01_z6_def_npc_tellesis_mesmer_boss_miniboss', @presenceid, 1, @definition, 1950, 550, 0, 5, 18000, 0, 90, 'tellesis mini boss npc', 0.9, 1, 1, 2, 1)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_vagabond_shield_l7')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'miniboss_01_z6_def_npc_tellesis_vagabond_shield_l7')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('miniboss_01_z6_def_npc_tellesis_vagabond_shield_l7', @presenceid, 2, @definition, 1950, 550, 0, 5, 18000, 0, 90, 'tellesis mini boss npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_kain_dps_l7')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'miniboss_01_z6_def_npc_tellesis_kain_dps_l7')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('miniboss_01_z6_def_npc_tellesis_kain_dps_l7', @presenceid, 2, @definition, 1950, 550, 0, 5, 18000, 0, 90, 'tellesis mini boss npc', 0.9, 1, 1, 2, 0)
END

--- courier 1

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'courier_01_z6' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('courier_01_z6', 10, 10, 2038, 2038, 'Tellesis courier 1', @spawnid, 1, 1, 18000, 5, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'courier_01_z6'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'courier_01_z6')

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_arbalest_advanced_courier')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'courier_01_z6_def_npc_tellesis_arbalest_advanced_courier')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('courier_01_z6_def_npc_tellesis_arbalest_advanced_courier', @presenceid, 2, @definition, 0, 0, 0, 10, 18000, 0, 50, 'tellesis npc', 0.9, 1, 1, 1, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_cameleon_advanced_courier')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'courier_01_z6_def_npc_tellesis_cameleon_advanced_courier')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('courier_01_z6_def_npc_tellesis_cameleon_advanced_courier', @presenceid, 1, @definition, 0, 0, 0, 10, 18000, 0, 50, 'tellesis npc', 0.9, 1, 1, 1, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_sequer_advanced_courier')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'courier_01_z6_def_npc_tellesis_sequer_advanced_courier')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('courier_01_z6_def_npc_tellesis_sequer_advanced_courier', @presenceid, 3, @definition, 0, 0, 0, 10, 18000, 0, 50, 'tellesis npc', 0.9, 1, 1, 1, 0)
END

--- courier 2

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'courier_02_z6' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('courier_02_z6', 10, 10, 2038, 2038, 'Tellesis courier 2', @spawnid, 1, 1, 18000, 5, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'courier_02_z6'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'courier_02_z6')

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_yagel_advanced_courier')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'courier_02_z6_def_npc_tellesis_yagel_advanced_courier')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('courier_02_z6_def_npc_tellesis_yagel_advanced_courier', @presenceid, 1, @definition, 0, 0, 0, 10, 18000, 0, 50, 'tellesis npc', 0.9, 1, 1, 1, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_hermes_advanced_courier')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'courier_02_z6_def_npc_tellesis_hermes_advanced_courier')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('courier_02_z6_def_npc_tellesis_hermes_advanced_courier', @presenceid, 1, @definition, 0, 0, 0, 10, 18000, 0, 50, 'tellesis npc', 0.9, 1, 1, 1, 0)
END

-- observer 1

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'observer_01_z6' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('observer_01_z6', 10, 10, 2038, 2038, 'Tellesis observer 1', @spawnid, 1, 1, 18000, 5, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'observer_01_z6'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'observer_01_z6')

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_mesmer_advanced_observer')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'observer_01_z6_def_npc_tellesis_mesmer_advanced_observer')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('observer_01_z6_def_npc_tellesis_mesmer_advanced_observer', @presenceid, 2, @definition, 0, 0, 0, 10, 18000, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_kain_advanced_observer')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'observer_01_z6_def_npc_tellesis_kain_advanced_observer')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('observer_01_z6_def_npc_tellesis_kain_advanced_observer', @presenceid, 1, @definition, 0, 0, 0, 10, 18000, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_vagabond_advanced_observer')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'observer_01_z6_def_npc_tellesis_vagabond_advanced_observer')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('observer_01_z6_def_npc_tellesis_vagabond_advanced_observer', @presenceid, 1, @definition, 0, 0, 0, 10, 18000, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

-- observer 2

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'observer_02_z6' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('observer_02_z6', 10, 10, 2038, 2038, 'Tellesis observer 2', @spawnid, 1, 1, 18000, 5, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'observer_02_z6'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'observer_02_z6')

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_kain_advanced_observer')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'observer_02_z6_def_npc_tellesis_kain_advanced_observer')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('observer_02_z6_def_npc_tellesis_kain_advanced_observer', @presenceid, 2, @definition, 0, 0, 0, 10, 18000, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_vagabond_advanced_observer')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'observer_02_z6_def_npc_tellesis_vagabond_advanced_observer')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('observer_02_z6_def_npc_tellesis_vagabond_advanced_observer', @presenceid, 1, @definition, 0, 0, 0, 10, 18000, 0, 50, 'tellesis npc', 0.9, 1, 1, 2, 0)
END

GO

---- Add relics

DECLARE @sourceZoneId INT
DECLARE @destinationZoneId INT

-- Tellesis

SET @sourceZoneId = (SELECT TOP 1 id FROM zones WHERE name = 'zone_gamma_z132')
SET @destinationZoneId = (SELECT TOP 1 id FROM zones WHERE name = 'zone_ICS_pve')
  
DELETE FROM relicspawninfo WHERE zoneid = @destinationZoneId

INSERT INTO relicspawninfo (relictypeid, zoneid, rate, x, y)
SELECT relictypeid, @destinationZoneId, rate, x, y FROM relicspawninfo WHERE zoneid = @sourceZoneId

DELETE FROM reliczoneconfig WHERE zoneid = @destinationZoneId

INSERT INTO reliczoneconfig (zoneid, maxspawn, respawnrate)
SELECT @destinationZoneId, maxspawn, respawnrate FROM reliczoneconfig WHERE zoneid = @sourceZoneId

GO

---- Add zone effects

DECLARE @sourceZoneId INT
DECLARE @destinationZoneId INT

SET @sourceZoneId = (SELECT TOP 1 id FROM zones WHERE name = 'zone_gamma_z132')
SET @destinationZoneId = (SELECT TOP 1 id FROM zones WHERE name = 'zone_ICS_pve')

DELETE FROM zoneeffects WHERE zoneid = @destinationZoneId

INSERT INTO zoneeffects (zoneid, effectid)
SELECT @destinationZoneId, effectid FROM zoneeffects WHERE zoneid = @sourceZoneId

GO

---- Fill syndicate market

DECLARE @sourcePresetId INT
DECLARE @destinationPresetId INT

SET @sourcePresetId = (SELECT TOP 1 id FROM itemshoppresets WHERE name = 'tm_preset_pve')
SET @destinationPresetId = (SELECT TOP 1 id FROM itemshoppresets WHERE name = 'ics_preset_pve')

DELETE FROM itemshop WHERE presetid = @destinationPresetId

INSERT INTO itemshop (presetid, targetdefinition, targetamount, tmcoin, icscoin, asicoin, credit, unicoin, globallimit, purchasecount, standing)
SELECT @destinationPresetId, targetdefinition, targetamount, tmcoin, icscoin, asicoin, credit, unicoin, globallimit, purchasecount, standing FROM itemshop its
INNER JOIN entitydefaults ed ON  its.targetdefinition = ed.definition
WHERE presetid = @sourcePresetId AND ed.categoryflags != 328859

GO
