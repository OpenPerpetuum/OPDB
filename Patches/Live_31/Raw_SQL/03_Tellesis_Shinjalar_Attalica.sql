-- Activate Attalica, Tellesis and Shinjalar

UPDATE zones SET active = 1 WHERE name in ('zone_ICS_pve', 'zone_ASI_pve', 'zone_ICS')

GO

-- Move Attalica, Tellesis and Shinjalar

UPDATE zones SET y = 3170, raceid = 1 WHERE name = 'zone_ICS'

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

UPDATE zoneentities SET enabled = 0 WHERE ename = 'teleport_column_icspve_1'

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
	('teleport_column_tmpve_1_to_tp_zone_6_8', 108, 256, 8, 7, 6, NULL, NULL, NULL, 7, 0, 1, 1, 2, 'teleport_column_tmpve_1', 'tp_zone_6_8')
END
ELSE
BEGIN
	UPDATE teleportdescriptions SET sourcecolumn = 108, targetcolumn = 256 WHERE description = 'teleport_column_tmpve_1_to_tp_zone_6_8'
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

-- Disable existing spawns

UPDATE p
SET p.enabled = 0
FROM npcpresence p 
INNER JOIN zones z 
ON p.spawnid = z.spawnid
WHERE z.name IN ('zone_ICS_pve', 'zone_ASI_pve', 'zone_ICS') AND p.enabled = 1 AND p.izgroupid IS NULL

GO

---- Tellesis

-- Create and fill new npc

DECLARE @sourceDefinition INT
DECLARE @targetDefinition INT
DECLARE @gamma_syndicate_shards INT
DECLARE @gamma_nuimqol_shards INT

SET @gamma_syndicate_shards = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_material_boss_gamma_syndicate')
SET @gamma_nuimqol_shards = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_material_boss_gamma_nuimqol')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_nuimqol_shards

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_nuimqol_shards

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_nuimqol_shards

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_nuimqol_shards

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_nuimqol_shards

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_nuimqol_shards

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_nuimqol_shards

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_nuimqol_shards

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_nuimqol_shards

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_nuimqol_shards

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_nuimqol_shards

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_nuimqol_shards

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_nuimqol_shards

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_nuimqol_shards

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_nuimqol_shards

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_nuimqol_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

DECLARE @epriton INT
DECLARE @noralghis INT

SET @epriton = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_epriton')
SET @noralghis = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_electroplant_fruit')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @epriton, 2000000, 1, 0, 1, 500000),
(@targetDefinition, @noralghis, 2000000, 1, 0, 1, 500000)

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_nuimqol_shards

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_nuimqol_shards

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_nuimqol_shards

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_nuimqol_shards

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_nuimqol_shards

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_nuimqol_shards

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_nuimqol_shards

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_nuimqol_shards

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_nuimqol_shards

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_nuimqol_shards

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_nuimqol_shards

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_nuimqol_shards

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_nuimqol_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_spectator_miniboss')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_npc_tellesis_spectator_miniboss', 1, 1024, 1167, '', 'Spectator, Nuimqol Drones, Shield', 1, 0, 0, 0, 100, 'def_npc_tellesis_spectator_miniboss_desc', 1, NULL, NULL)
END

SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_spectator_miniboss')

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

DECLARE @field INT

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 3)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 3 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 3)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 3 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'energy_vampired_amount_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.5 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locked_targets_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 10)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 10 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locked_targets_max_bonus')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 10)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 10 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 4.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 4.5 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.7)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.7 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_chemical')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 200)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 200 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_explosive')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 200)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 200 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_kinetic')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 200)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 200 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_thermal')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 200)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 200 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'sensor_strength_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 300)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 300 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'shield_absorbtion_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 3)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 3 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_bandwidth_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 10)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 15 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_operational_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 50)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 50 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 3)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 3 WHERE definition = @targetDefinition AND field = @field
END

--

DECLARE @robot INT
DECLARE @head INT
DECLARE @chassis INT
DECLARE @leg INT
DECLARE @inventory INT
DECLARE @shield INT
DECLARE @shield_hardener INT
DECLARE @remote_controller INT
DECLARE @recharger INT
DECLARE @drainer INT
DECLARE @sensor_booster INT
DECLARE @combat_drone INT

SET @robot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_bot')
SET @head = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_head')
SET @chassis = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_chassis')
SET @leg = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_leg')
SET @inventory = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robot_inventory_spectator')
SET @shield = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_shield_generator')
SET @shield_hardener = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_shield_hardener')
SET @remote_controller = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_remote_controller')
SET @recharger = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_core_recharger')
SET @drainer = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_energy_vampire')
SET @sensor_booster = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_sensor_booster')
SET @combat_drone = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_nuimqol_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'Spectator_Nuimqol_Drones_Shield')
BEGIN
	INSERT INTO robottemplates (name, description, note) VALUES
	('Spectator_Nuimqol_Drones_Shield', CONCAT(
		'#robot=i',
		FORMAT(@robot, 'X'),
		'#head=i',
		FORMAT(@head, 'X'),
		'#chassis=i',
		FORMAT(@chassis, 'X'),
		'#leg=i',
		FORMAT(@leg, 'X'),
		'#container=i',
		FORMAT(@inventory, 'X'),
		'#headModules=[|m0=[|definition=i',
		FORMAT(@remote_controller, 'X'),
		'|slot=i1|ammoDefinition=i',
		FORMAT(@combat_drone, 'X'),
		'|ammoQuantity=i1]|m1=[|definition=i',
		FORMAT(@sensor_booster, 'X'),
		'|slot=i2]|m2=[|definition=i',
		FORMAT(@sensor_booster, 'X'),
		'|slot=i3]|m3=[|definition=i',
		FORMAT(@shield_hardener, 'X'),
		'|slot=i4]|m4=[|definition=i',
		FORMAT(@shield_hardener, 'X'),
		'|slot=i5]|m5=[|definition=i',
		FORMAT(@shield_hardener, 'X'),
		'|slot=i6]]#chassisModules=[|m0=[|definition=i',
		FORMAT(@drainer, 'X'),
		'|slot=i1]]#legModules=[|m0=[|definition=i',
		FORMAT(@shield, 'X'),
		'|slot=i1]|m1=[|definition=i',
		FORMAT(@recharger, 'X'),
		'|slot=i2]|m2=[|definition=i',
		FORMAT(@recharger, 'X'),
		'|slot=i2]|m3=[|definition=i',
		FORMAT(@recharger, 'X'),
		'|slot=i4]|m4=[|definition=i',
		FORMAT(@recharger, 'X'),
		'|slot=i5]]'), 'NPC Shielded Spectator with Nuimqol Drones')
END
ELSE
BEGIN
	UPDATE robottemplates SET description = CONCAT(
		'#robot=i',
		FORMAT(@robot, 'X'),
		'#head=i',
		FORMAT(@head, 'X'),
		'#chassis=i',
		FORMAT(@chassis, 'X'),
		'#leg=i',
		FORMAT(@leg, 'X'),
		'#container=i',
		FORMAT(@inventory, 'X'),
		'#headModules=[|m0=[|definition=i',
		FORMAT(@remote_controller, 'X'),
		'|slot=i1|ammoDefinition=i',
		FORMAT(@combat_drone, 'X'),
		'|ammoQuantity=i1]|m1=[|definition=i',
		FORMAT(@sensor_booster, 'X'),
		'|slot=i2]|m2=[|definition=i',
		FORMAT(@sensor_booster, 'X'),
		'|slot=i3]|m3=[|definition=i',
		FORMAT(@shield_hardener, 'X'),
		'|slot=i4]|m4=[|definition=i',
		FORMAT(@shield_hardener, 'X'),
		'|slot=i5]|m5=[|definition=i',
		FORMAT(@shield_hardener, 'X'),
		'|slot=i6]]#chassisModules=[|m0=[|definition=i',
		FORMAT(@drainer, 'X'),
		'|slot=i1]]#legModules=[|m0=[|definition=i',
		FORMAT(@shield, 'X'),
		'|slot=i1]|m1=[|definition=i',
		FORMAT(@recharger, 'X'),
		'|slot=i2]|m1=[|definition=i',
		FORMAT(@recharger, 'X'),
		'|slot=i2]|m1=[|definition=i',
		FORMAT(@recharger, 'X'),
		'|slot=i4]|m1=[|definition=i',
		FORMAT(@recharger, 'X'),
		'|slot=i5]]')
	WHERE name = 'Spectator_Nuimqol_Drones_Shield'
END

DECLARE @templateId INT

SET @templateId = (SELECT TOP 1 id FROM robottemplates WHERE name = 'Spectator_Nuimqol_Drones_Shield')

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note) VALUES
(@targetDefinition, @templateId, 2, NULL, NULL, 1500, 'def_npc_tellesis_spectator_miniboss')

DELETE FROM npcloot WHERE definition = @targetDefinition

DECLARE @lootDefinition INT

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_core_recharger')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_shield_generator')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_shield_hardener')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_remote_controller')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.15, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_energy_vampire')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.25, 0, 0, 1)

--

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_core_recharger')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_shield_generator')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_shield_hardener')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.027, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.015, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_energy_vampire')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.025, 0, 0, 1)

--

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_core_recharger')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_medium_shield_generator')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_shield_hardener')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.0075, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_medium_energy_vampire')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.0125, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_mk3_A_CT_capsule')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 1, 1, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_nuimqol_combat_drone_unit')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 10, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_nuimqol_combat_drone_unit')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 10, 0.05, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_material_boss_gamma_syndicate')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 200, 1, 0, 1, 20)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_nuimqol')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 75000, 1, 0, 1, 37500)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_hitech')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 75000, 1, 0, 1, 37500)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_common')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 75000, 1, 0, 1, 37500)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_8')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.3, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_9')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.3, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_nuimqol_reactor_plasma')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 250000, 1, 0, 1, 125000)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_boost_ep_t0')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 3, 1, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_boost_ep_t1')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 2, 1, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_boost_ep_t2')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 1, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_reactore_core_heavymech')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 3, 0, 1, 1)

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

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_02_z6_sequer_basic_lindy')
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

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_yagel_speed_l3')

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
	('courier_01_z6_def_npc_tellesis_sequer_advanced_courier', @presenceid, 1, @definition, 0, 0, 0, 10, 18000, 0, 50, 'tellesis npc', 0.9, 1, 1, 1, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET flockmembercount = 1 WHERE name = 'courier_01_z6_def_npc_tellesis_sequer_advanced_courier'
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

-- spectator 1

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'spectator_01_z6' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('spectator_01_z6', 1565, 1535, 1600, 1565, 'Tellesis spectator', @spawnid, 1, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'spectator_01_z6'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'spectator_01_z6')

--

DELETE FROM npcflock WHERE presenceid = @presenceid

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_spectator_miniboss')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'spectator_01_z6_def_npc_tellesis_spectator_miniboss')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('spectator_01_z6_def_npc_tellesis_spectator_miniboss', @presenceid, 1, @definition, 1580, 1550, 0, 5, 18000, 0, 90, 'tellesis spectator npc', 0.9, 1, 1, 2, 1)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_vagabond_shield_l7')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'spectator_01_z6_def_npc_tellesis_vagabond_shield_l7')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('spectator_01_z6_def_npc_tellesis_vagabond_shield_l7', @presenceid, 2, @definition, 1580, 1550, 0, 5, 18000, 0, 90, 'tellesis spectator npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_tellesis_kain_dps_l7')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'spectator_01_z6_def_npc_tellesis_kain_dps_l7')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('spectator_01_z6_def_npc_tellesis_kain_dps_l7', @presenceid, 2, @definition, 1580, 1550, 0, 5, 18000, 0, 90, 'tellesis spectator npc', 0.9, 1, 1, 2, 0)
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

DROP TABLE IF EXISTS #EFFS;
CREATE TABLE #EFFS 
(
	effId INT,
	effName VARCHAR(100)
);

DROP TABLE IF EXISTS #EFFECTMODS;
CREATE TABLE #EFFECTMODS 
(
	effId INT,
	fieldName VARCHAR(100),
	fieldValue FLOAT
);

DECLARE @effectCatName BIGINT
SET @effectCatName = (SELECT TOP 1 flag FROM effectcategories WHERE name = 'effcat_zone_effects');

DECLARE @effectName  AS VARCHAR(100) = 'effect_alpha3_bonus';

IF NOT EXISTS (SELECT 1 FROM effects WHERE name = @effectName)
BEGIN
	INSERT INTO effects (effectcategory, duration, name, description, note, isaura, auraradius, ispositive, display, saveable) VALUES
	(@effectCatName, 0, @effectName, @effectName+'_desc', 'Alpha 3 zone effects', 1, 0, 1, 1, 0)
END

DECLARE @effectId INT;

SET @effectId = (SELECT TOP 1 id FROM effects WHERE name = @effectName)

INSERT INTO #EFFECTMODS (effId, fieldName, fieldValue) VALUES
(@effectId, 'effect_mining_amount_modifier', 1.3),
(@effectId, 'effect_harvesting_amount_modifier', 1.3),
(@effectId, 'effect_speed_highway_modifier', 0.35)

INSERT INTO #EFFS (effId, effName) VALUES
(@effectId, @effectName);

DELETE FROM effectdefaultmodifiers WHERE effectid IN (SELECT effId FROM #EFFS);

INSERT INTO effectdefaultmodifiers (effectid, field, value)
SELECT effId, (SELECT TOP 1 id FROM aggregatefields WHERE name=fieldName), fieldValue
FROM #EFFECTMODS;

DECLARE @zoneId INT

SET @zoneId = (SELECT TOP 1 id FROM zones WHERE name = 'zone_ICS_pve')

DELETE FROM zoneeffects WHERE zoneid = @zoneId;

INSERT INTO zoneeffects (zoneid, effectid) VALUES
(@zoneId, @effectId)

DROP TABLE IF EXISTS #EFFECTMODS;
DROP TABLE IF EXISTS #EFFS;
GO

	
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


---- Set up missions for Tellesis

DECLARE @zoneid INT

SET @zoneid = (SELECT TOP 1 id FROM zones WHERE name = 'zone_ICS_pve')

UPDATE missionlocations SET maxmissionlevel = 5 WHERE zoneid = @zoneid

---- Reconfigure plant rules for Tellesis

UPDATE zones SET plantruleset = id WHERE name = 'zone_ICS_pve'

DECLARE @rulesetid INT

SET @rulesetid = (SELECT TOP 1 plantruleset FROM zones WHERE name = 'zone_ICS_pve')

DELETE FROM plantrules WHERE rulesetid = @rulesetid

INSERT INTO plantrules (plantrule, rulesetid, note) VALUES
('bush_a.txt', @rulesetid, 'Tellesis decor'),
('bush_b.txt', @rulesetid, 'Tellesis decor'),
('coppertree.txt', @rulesetid, 'Tellesis decor'),
('grass_a.txt', @rulesetid, 'Tellesis decor'),
('grass_b.txt', @rulesetid, 'Tellesis decor'),
('pinetree.txt', @rulesetid, 'Tellesis decor'),
('quag.txt', @rulesetid, 'Tellesis decor'),
('rango.txt', @rulesetid, 'Tellesis decor'),
('reed.txt', @rulesetid, 'Tellesis decor'),
('titanplant.txt', @rulesetid, 'Tellesis decor'),
('nanowheat.txt', @rulesetid, 'Tellesis decor'),
('irontree_hi.txt', @rulesetid, 'Tellesis harvestable'),
('electroplant_hi.txt', @rulesetid, 'Tellesis harvestable'),
('rustbush_hi.txt', @rulesetid, 'Tellesis harvestable')

GO

---- Reconfigure minerals for Tellesis
DECLARE @materialType INT
DECLARE @zoneId INT

SET @zoneId = (SELECT TOP 1 id FROM zones WHERE name = 'zone_ICS_pve')

DELETE FROM mineralconfigs WHERE zoneid = @zoneId

SET @materialType = (SELECT TOP 1 idx FROM minerals WHERE name = 'titan')

INSERT INTO mineralconfigs (zoneid, materialtype, maxnodes, maxtilespernode, totalamountpernode, minthreshold) VALUES
(@zoneId, @materialType, 7, 625, 80000000, 0.5)

SET @materialType = (SELECT TOP 1 idx FROM minerals WHERE name = 'crude')

INSERT INTO mineralconfigs (zoneid, materialtype, maxnodes, maxtilespernode, totalamountpernode, minthreshold) VALUES
(@zoneId, @materialType, 7, 1000, 82125000, 0.5)

SET @materialType = (SELECT TOP 1 idx FROM minerals WHERE name = 'stermonit')

INSERT INTO mineralconfigs (zoneid, materialtype, maxnodes, maxtilespernode, totalamountpernode, minthreshold) VALUES
(@zoneId, @materialType, 7, 625, 68000000, 0.5)

SET @materialType = (SELECT TOP 1 idx FROM minerals WHERE name = 'imentium')

INSERT INTO mineralconfigs (zoneid, materialtype, maxnodes, maxtilespernode, totalamountpernode, minthreshold) VALUES
(@zoneId, @materialType, 7, 625, 68000000, 0.5)

SET @materialType = (SELECT TOP 1 idx FROM minerals WHERE name = 'liquizit')

INSERT INTO mineralconfigs (zoneid, materialtype, maxnodes, maxtilespernode, totalamountpernode, minthreshold) VALUES
(@zoneId, @materialType, 7, 625, 80000000, 0.5)

GO

---- Shinjalar

-- Create and fill new npc

DECLARE @sourceDefinition INT
DECLARE @targetDefinition INT
DECLARE @gamma_syndicate_shards INT
DECLARE @gamma_thelodica_shards INT

SET @gamma_syndicate_shards = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_material_boss_gamma_syndicate')
SET @gamma_thelodica_shards = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_material_boss_gamma_thelodica')

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_artemis_dps_l3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_shinjalar_artemis_dps_l3', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_shinjalar_artemis_dps_l3_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_artemis_dps_l3'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_artemis_dps_l3')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_artemis_dps_l3')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_thelodica_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_baphomet_dps_l3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_shinjalar_baphomet_dps_l3', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_shinjalar_baphomet_dps_l3_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_baphomet_dps_l3'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_baphomet_dps_l3')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_baphomet_dps_l3')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_thelodica_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_intakt_shield_l3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_shinjalar_intakt_shield_l3', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_shinjalar_intakt_shield_l3_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_intakt_shield_l3'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_intakt_shield_l3')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_intakt_shield_l3')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_thelodica_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_sequer_basic_lindy')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_shinjalar_sequer_basic_lindy', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_shinjalar_sequer_basic_lindy_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_sequer_basic_lindy'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_sequer_basic_lindy')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_sequer_basic_lindy')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_thelodica_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_riveler_basic_lindy')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_shinjalar_riveler_basic_lindy', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_shinjalar_riveler_basic_lindy_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_riveler_basic_lindy'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_riveler_basic_lindy')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_riveler_basic_lindy')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_thelodica_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_laird_basic_lindy')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_shinjalar_laird_basic_lindy', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_shinjalar_laird_basic_lindy_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_laird_basic_lindy'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_laird_basic_lindy')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_laird_basic_lindy')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_thelodica_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_seth_tank_l3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_shinjalar_seth_tank_l3', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_shinjalar_seth_tank_l3_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_mesmer_tank_l3'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_seth_tank_l3')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_seth_tank_l3')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_thelodica_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_artemis_tank_l3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_shinjalar_artemis_tank_l3', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_shinjalar_artemis_tank_l3_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_artemis_tank_l3'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_artemis_tank_l3')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_artemis_tank_l3')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_thelodica_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_zenith_armor_l3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_shinjalar_zenith_armor_l3', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_shinjalar_zenith_armor_l3_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_zenith_armor_l3'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_zenith_armor_l3')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_zenith_armor_l3')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_thelodica_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_intakt_armor_l3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_shinjalar_intakt_armor_l3', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_shinjalar_intakt_armor_l3_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_intakt_armor_l3'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_intakt_armor_l3')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_intakt_armor_l3')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_thelodica_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_prometheus_dps_l3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_shinjalar_prometheus_dps_l3', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_shinjalar_prometheus_dps_l3_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_prometheus_dps_l3'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_prometheus_dps_l3')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_prometheus_dps_l3')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_thelodica_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_seth_dps_l3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_shinjalar_seth_dps_l3', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_shinjalar_seth_dps_l3_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_seth_dps_l3'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_seth_dps_l3')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_seth_dps_l3')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_thelodica_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_prometheus_speed_l3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_shinjalar_prometheus_speed_l3', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_shinjalar_prometheus_speed_l3_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_prometheus_speed_l3'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_prometheus_speed_l3')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_prometheus_speed_l3')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_thelodica_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_baphomet_speed_l3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_shinjalar_baphomet_speed_l3', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_shinjalar_baphomet_speed_l3_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_baphomet_speed_l3'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_baphomet_speed_l3')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_baphomet_speed_l3')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_thelodica_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_argano_basic_lindy')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_shinjalar_argano_basic_lindy', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_shinjalar_argano_basic_lindy_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_argano_basic_lindy'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_argano_basic_lindy')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_argano_basic_lindy')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_thelodica_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_onyx_thelodica_pitboss')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_shinjalar_onyx_thelodica_pitboss', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_shinjalar_onyx_thelodica_pitboss_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_onyx_thelodica_pitboss'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_onyx_thelodica_pitboss')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_onyx_thelodica_pitboss')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_thelodica_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

DECLARE @epriton INT
DECLARE @noralghis INT

SET @epriton = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_epriton')
SET @noralghis = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_electroplant_fruit')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @epriton, 2000000, 1, 0, 1, 500000),
(@targetDefinition, @noralghis, 2000000, 1, 0, 1, 500000)

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_seth_miniboss_rank3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_shinjalar_seth_miniboss_rank3', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_shinjalar_seth_miniboss_rank3_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_seth_miniboss_rank3'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_seth_miniboss_rank3')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_seth_miniboss_rank3')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_thelodica_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_zenith_miniboss_rank3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_shinjalar_zenith_miniboss_rank3', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_shinjalar_zenith_miniboss_rank3_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_zenith_miniboss_rank3'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_zenith_miniboss_rank3')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_zenith_miniboss_rank3')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_thelodica_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_seth_boss_miniboss')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_shinjalar_seth_boss_miniboss', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_shinjalar_seth_boss_miniboss_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_seth_boss_miniboss'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_seth_boss_miniboss')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_seth_boss_miniboss')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_thelodica_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_zenith_shield_l7')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_shinjalar_zenith_shield_l7', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_shinjalar_zenith_shield_l7_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_zenith_shield_l7'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_zenith_shield_l7')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_zenith_shield_l7')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_thelodica_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_artemis_dps_l7')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_shinjalar_artemis_dps_l7', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_shinjalar_artemis_dps_l7_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_artemis_dps_l7'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_artemis_dps_l7')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_artemis_dps_l7')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_thelodica_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_baphomet_advanced_courier')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_shinjalar_baphomet_advanced_courier', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_shinjalar_baphomet_advanced_courier_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_baphomet_advanced_courier'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_baphomet_advanced_courier')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_baphomet_advanced_courier')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_thelodica_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_intakt_advanced_courier')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_shinjalar_intakt_advanced_courier', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_shinjalar_intakt_advanced_courier_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_intakt_advanced_courier'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_intakt_advanced_courier')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_intakt_advanced_courier')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_thelodica_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_sequer_advanced_courier')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_shinjalar_sequer_advanced_courier', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_shinjalar_sequer_advanced_courier_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_sequer_advanced_courier'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_sequer_advanced_courier')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_sequer_advanced_courier')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_thelodica_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_prometheus_advanced_courier')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_shinjalar_prometheus_advanced_courier', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_shinjalar_prometheus_advanced_courier_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_prometheus_advanced_courier'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_prometheus_advanced_courier')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_prometheus_advanced_courier')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_thelodica_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_hermes_advanced_courier')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_shinjalar_hermes_advanced_courier', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_shinjalar_hermes_advanced_courier_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_hermes_advanced_courier'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_hermes_advanced_courier')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_hermes_advanced_courier')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_thelodica_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_seth_advanced_observer')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_shinjalar_seth_advanced_observer', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_shinjalar_seth_advanced_observer_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_seth_advanced_observer'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_seth_advanced_observer')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_seth_advanced_observer')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_thelodica_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_artemis_advanced_observer')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_shinjalar_artemis_advanced_observer', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_shinjalar_artemis_advanced_observer_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_artemis_advanced_observer'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_artemis_advanced_observer')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_artemis_advanced_observer')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_thelodica_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_zenith_advanced_observer')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_shinjalar_zenith_advanced_observer', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_shinjalar_zenith_advanced_observer_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_zenith_advanced_observer'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_zenith_advanced_observer')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_zenith_advanced_observer')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_thelodica_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_spectator_miniboss')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_npc_shinjalar_spectator_miniboss', 1, 1024, 1167, '', 'Spectator, Thelodica Drones, Shield', 1, 0, 0, 0, 100, 'def_npc_shinjalar_spectator_miniboss_desc', 1, NULL, NULL)
END

SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_spectator_miniboss')

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

DECLARE @field INT

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 3)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 3 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 3)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 3 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'energy_vampired_amount_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.5 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locked_targets_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 10)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 10 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locked_targets_max_bonus')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 10)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 10 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 4.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 4.5 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.7)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.7 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_chemical')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 200)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 200 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_explosive')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 200)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 200 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_kinetic')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 200)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 200 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_thermal')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 200)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 200 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'sensor_strength_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 300)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 300 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'shield_absorbtion_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 3)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 3 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_bandwidth_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 10)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 15 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_operational_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 50)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 50 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 3)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 3 WHERE definition = @targetDefinition AND field = @field
END

--

DECLARE @robot INT
DECLARE @head INT
DECLARE @chassis INT
DECLARE @leg INT
DECLARE @inventory INT
DECLARE @shield INT
DECLARE @shield_hardener INT
DECLARE @remote_controller INT
DECLARE @recharger INT
DECLARE @drainer INT
DECLARE @sensor_booster INT
DECLARE @combat_drone INT

SET @robot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_bot')
SET @head = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_head')
SET @chassis = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_chassis')
SET @leg = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_leg')
SET @inventory = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robot_inventory_spectator')
SET @shield = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_shield_generator')
SET @shield_hardener = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_shield_hardener')
SET @remote_controller = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_remote_controller')
SET @recharger = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_core_recharger')
SET @drainer = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_energy_vampire')
SET @sensor_booster = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_sensor_booster')
SET @combat_drone = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_thelodica_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'Spectator_Thelodica_Drones_Shield')
BEGIN
	INSERT INTO robottemplates (name, description, note) VALUES
	('Spectator_Thelodica_Drones_Shield', CONCAT(
		'#robot=i',
		FORMAT(@robot, 'X'),
		'#head=i',
		FORMAT(@head, 'X'),
		'#chassis=i',
		FORMAT(@chassis, 'X'),
		'#leg=i',
		FORMAT(@leg, 'X'),
		'#container=i',
		FORMAT(@inventory, 'X'),
		'#headModules=[|m0=[|definition=i',
		FORMAT(@remote_controller, 'X'),
		'|slot=i1|ammoDefinition=i',
		FORMAT(@combat_drone, 'X'),
		'|ammoQuantity=i1]|m1=[|definition=i',
		FORMAT(@sensor_booster, 'X'),
		'|slot=i2]|m2=[|definition=i',
		FORMAT(@sensor_booster, 'X'),
		'|slot=i3]|m3=[|definition=i',
		FORMAT(@shield_hardener, 'X'),
		'|slot=i4]|m4=[|definition=i',
		FORMAT(@shield_hardener, 'X'),
		'|slot=i5]|m5=[|definition=i',
		FORMAT(@shield_hardener, 'X'),
		'|slot=i6]]#chassisModules=[|m0=[|definition=i',
		FORMAT(@drainer, 'X'),
		'|slot=i1]]#legModules=[|m0=[|definition=i',
		FORMAT(@shield, 'X'),
		'|slot=i1]|m1=[|definition=i',
		FORMAT(@recharger, 'X'),
		'|slot=i2]|m2=[|definition=i',
		FORMAT(@recharger, 'X'),
		'|slot=i2]|m3=[|definition=i',
		FORMAT(@recharger, 'X'),
		'|slot=i4]|m4=[|definition=i',
		FORMAT(@recharger, 'X'),
		'|slot=i5]]'), 'NPC Shielded Spectator with Thelodica Drones')
END
ELSE
BEGIN
	UPDATE robottemplates SET description = CONCAT(
		'#robot=i',
		FORMAT(@robot, 'X'),
		'#head=i',
		FORMAT(@head, 'X'),
		'#chassis=i',
		FORMAT(@chassis, 'X'),
		'#leg=i',
		FORMAT(@leg, 'X'),
		'#container=i',
		FORMAT(@inventory, 'X'),
		'#headModules=[|m0=[|definition=i',
		FORMAT(@remote_controller, 'X'),
		'|slot=i1|ammoDefinition=i',
		FORMAT(@combat_drone, 'X'),
		'|ammoQuantity=i1]|m1=[|definition=i',
		FORMAT(@sensor_booster, 'X'),
		'|slot=i2]|m2=[|definition=i',
		FORMAT(@sensor_booster, 'X'),
		'|slot=i3]|m3=[|definition=i',
		FORMAT(@shield_hardener, 'X'),
		'|slot=i4]|m4=[|definition=i',
		FORMAT(@shield_hardener, 'X'),
		'|slot=i5]|m5=[|definition=i',
		FORMAT(@shield_hardener, 'X'),
		'|slot=i6]]#chassisModules=[|m0=[|definition=i',
		FORMAT(@drainer, 'X'),
		'|slot=i1]]#legModules=[|m0=[|definition=i',
		FORMAT(@shield, 'X'),
		'|slot=i1]|m1=[|definition=i',
		FORMAT(@recharger, 'X'),
		'|slot=i2]|m1=[|definition=i',
		FORMAT(@recharger, 'X'),
		'|slot=i2]|m1=[|definition=i',
		FORMAT(@recharger, 'X'),
		'|slot=i4]|m1=[|definition=i',
		FORMAT(@recharger, 'X'),
		'|slot=i5]]')
	WHERE name = 'Spectator_Thelodica_Drones_Shield'
END

DECLARE @templateId INT

SET @templateId = (SELECT TOP 1 id FROM robottemplates WHERE name = 'Spectator_Thelodica_Drones_Shield')

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note) VALUES
(@targetDefinition, @templateId, 2, NULL, NULL, 1500, 'def_npc_shinjalar_spectator_miniboss')

DELETE FROM npcloot WHERE definition = @targetDefinition

DECLARE @lootDefinition INT

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_core_recharger')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_shield_generator')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_shield_hardener')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_remote_controller')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.15, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_energy_vampire')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.25, 0, 0, 1)

--

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_core_recharger')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_shield_generator')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_shield_hardener')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.027, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.015, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_energy_vampire')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.025, 0, 0, 1)

--

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_core_recharger')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_medium_shield_generator')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_shield_hardener')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.0075, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_medium_energy_vampire')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.0125, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_mk3_A_CT_capsule')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 1, 1, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_thelodica_combat_drone_unit')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 10, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_thelodica_combat_drone_unit')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 10, 0.05, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_material_boss_gamma_syndicate')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 200, 1, 0, 1, 20)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_thelodica')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 75000, 1, 0, 1, 37500)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_hitech')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 75000, 1, 0, 1, 37500)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_common')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 75000, 1, 0, 1, 37500)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_8')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.3, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_9')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.3, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_thelodica_reactor_plasma')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 250000, 1, 0, 1, 125000)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_boost_ep_t0')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 3, 1, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_boost_ep_t1')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 2, 1, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_boost_ep_t2')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 1, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_reactore_core_heavymech')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 3, 0, 1, 1)

GO

-- Add roamers for Shinjalar

DECLARE @spawnid INT
DECLARE @presenceid INT
DECLARE @definition INT
DECLARE @templateid INT

SET @spawnid = (SELECT TOP 1 spawnid FROM zones WHERE name = 'zone_ASI_pve')

--- roamers 1

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'roamer_01_z7' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('roamer_01_z7', 10, 10, 2038, 2038, 'Shinjalar roamers 1', @spawnid, 1, 1, 7200, 5, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'roamer_01_z7'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'roamer_01_z7')

----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_artemis_dps_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_01_z7_artemis_dps_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_01_z7_artemis_dps_l3', @presenceid, 2, @definition, 0, 0, 0, 10, 7200, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_baphomet_dps_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_01_z7_baphomet_dps_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_01_z7_baphomet_dps_l3', @presenceid, 4, @definition, 0, 0, 0, 10, 7200, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_intakt_shield_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_01_z7_intakt_shield_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_01_z7_intakt_shield_l3', @presenceid, 3, @definition, 0, 0, 0, 10, 7200, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

--- roamers 2

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'roamer_02_z7' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('roamer_02_z7', 10, 10, 2038, 2038, 'Shinjalar roamers 2', @spawnid, 1, 1, 7200, 5, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'roamer_02_z7'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'roamer_02_z7')

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_sequer_basic_lindy')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'roamer_02_z7_sequer_basic_lindy')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_02_z7_sequer_basic_lindy', @presenceid, 2, @definition, 0, 0, 0, 10, 7200, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_riveler_basic_lindy')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_02_z7_riveler_basic_lindy')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_02_z7_riveler_basic_lindy', @presenceid, 1, @definition, 0, 0, 0, 10, 7200, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_laird_basic_lindy')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'roamer_02_z7_laird_basic_lindy')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_02_z7_laird_basic_lindy', @presenceid, 2, @definition, 0, 0, 0, 10, 7200, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_seth_tank_l3')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'roamer_02_z7_seth_tank_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_02_z7_seth_tank_l3', @presenceid, 1, @definition, 0, 0, 0, 10, 7200, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_artemis_tank_l3')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'roamer_02_z7_artemis_tank_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_02_z7_artemis_tank_l3', @presenceid, 3, @definition, 0, 0, 0, 10, 7200, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_zenith_armor_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_02_z7_zenith_armor_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_02_z7_zenith_armor_l3', @presenceid, 1, @definition, 0, 0, 0, 10, 7200, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_intakt_armor_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_02_z7_intakt_armor_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_02_z7_intakt_armor_l3', @presenceid, 2, @definition, 0, 0, 0, 10, 7200, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_prometheus_speed_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_02_z7_prometheus_speed_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_02_z7_prometheus_speed_l3', @presenceid, 2, @definition, 0, 0, 0, 10, 7200, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

--- roamers 3

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'roamer_03_z7' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('roamer_03_z7', 10, 10, 2038, 2038, 'Shinjalar roamers 3', @spawnid, 1, 1, 7200, 5, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'roamer_03_z7'
END


SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'roamer_03_z7')

----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_baphomet_dps_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_03_z7_baphomet_dps_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_03_z7_baphomet_dps_l3', @presenceid, 4, @definition, 0, 0, 0, 10, 7200, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_zenith_armor_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_03_z7_zenith_armor_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_03_z7_zenith_armor_l3', @presenceid, 2, @definition, 0, 0, 0, 10, 7200, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_prometheus_dps_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_03_z7_prometheus_dps_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_03_z7_prometheus_dps_l3', @presenceid, 3, @definition, 0, 0, 0, 10, 7200, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

--- roamers 4

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'roamer_04_z7' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('roamer_04_z7', 10, 10, 2038, 2038, 'Shinjalar roamers 4', @spawnid, 1, 1, 7200, 5, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'roamer_04_z7'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'roamer_04_z7')

----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_seth_dps_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_04_z7_seth_dps_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_04_z7_seth_dps_l3', @presenceid, 3, @definition, 0, 0, 0, 10, 7200, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_prometheus_speed_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_04_z7_prometheus_speed_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_04_z7_prometheus_speed_l3', @presenceid, 3, @definition, 0, 0, 0, 10, 7200, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_baphomet_speed_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_04_z7_baphomet_speed_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_04_z7_baphomet_speed_l3', @presenceid, 4, @definition, 0, 0, 0, 10, 7200, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

--- roamers 5

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'roamer_05_z7' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('roamer_05_z7', 10, 10, 2038, 2038, 'Shinjalar roamers 5', @spawnid, 1, 1, 7200, 5, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'roamer_05_z7'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'roamer_05_z7')

----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_artemis_dps_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_05_z7_artemis_dps_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_05_z7_artemis_dps_l3', @presenceid, 3, @definition, 0, 0, 0, 10, 7200, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_zenith_armor_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_05_z7_zenith_armor_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_05_z7_zenith_armor_l3', @presenceid, 1, @definition, 0, 0, 0, 10, 7200, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_intakt_armor_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_05_z7_intakt_armor_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_05_z7_intakt_armor_l3', @presenceid, 1, @definition, 0, 0, 0, 10, 7200, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_prometheus_dps_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_05_z7_prometheus_dps_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_05_z7_prometheus_dps_l3', @presenceid, 3, @definition, 0, 0, 0, 10, 7200, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

--- roamers 6

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'roamer_06_z7' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('roamer_06_z7', 10, 10, 2038, 2038, 'Shinjalar roamers 6', @spawnid, 1, 1, 7200, 5, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'roamer_06_z7'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'roamer_06_z7')

----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_prometheus_speed_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_06_z7_prometheus_speed_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_06_z7_prometheus_speed_l3', @presenceid, 3, @definition, 0, 0, 0, 10, 7200, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_baphomet_speed_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_06_z7_baphomet_speed_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_06_z7_baphomet_speed_l3', @presenceid, 4, @definition, 0, 0, 0, 10, 7200, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_intakt_shield_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_06_z7_intakt_shield_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_06_z7_intakt_shield_l3', @presenceid, 2, @definition, 0, 0, 0, 10, 7200, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_artemis_dps_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_06_z7_artemis_dps_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_06_z7_artemis_dps_l3', @presenceid, 3, @definition, 0, 0, 0, 10, 7200, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

--- roamers 7

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'roamer_07_z7' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('roamer_07_z7', 10, 10, 2038, 2038, 'Shinjalar roamers 7', @spawnid, 1, 1, 7200, 5, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'roamer_07_z7'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'roamer_07_z7')

----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_prometheus_speed_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_07_z7_prometheus_speed_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_07_z7_prometheus_speed_l3', @presenceid, 2, @definition, 0, 0, 0, 10, 7200, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_intakt_shield_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_07_z7_intakt_shield_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_07_z7_intakt_shield_l3', @presenceid, 2, @definition, 0, 0, 0, 10, 7200, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_baphomet_dps_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_07_z7_baphomet_dps_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_07_z7_baphomet_dps_l3', @presenceid, 2, @definition, 0, 0, 0, 10, 7200, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

--- roamers 8

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'roamer_08_z7' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('roamer_08_z7', 10, 10, 2038, 2038, 'Shinjalar roamers 8', @spawnid, 1, 1, 7200, 5, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'roamer_08_z7'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'roamer_08_z7')

----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_seth_dps_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_08_z7_seth_dps_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_08_z7_seth_dps_l3', @presenceid, 2, @definition, 0, 0, 0, 10, 7200, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_artemis_dps_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_08_z7_artemis_dps_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_08_z7_artemis_dps_l3', @presenceid, 5, @definition, 0, 0, 0, 10, 7200, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_intakt_armor_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_08_z7_intakt_armor_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_08_z7_intakt_armor_l3', @presenceid, 2, @definition, 0, 0, 0, 10, 7200, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_prometheus_dps_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_08_z7_prometheus_dps_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_08_z7_prometheus_dps_l3', @presenceid, 3, @definition, 0, 0, 0, 10, 7200, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

--- roamers 9

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'roamer_09_z7' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('roamer_09_z7', 10, 10, 2038, 2038, 'Shinjalar roamers 9', @spawnid, 1, 1, 7200, 5, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'roamer_09_z7'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'roamer_09_z7')

----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_sequer_basic_lindy')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_09_z7_sequer_basic_lindy')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_09_z7_sequer_basic_lindy', @presenceid, 1, @definition, 0, 0, 0, 10, 7200, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_laird_basic_lindy')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_09_z7_laird_basic_lindy')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_09_z7_laird_basic_lindy', @presenceid, 1, @definition, 0, 0, 0, 10, 7200, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_argano_basic_lindy')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_09_z7_argano_basic_lindy')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_09_z7_argano_basic_lindy', @presenceid, 1, @definition, 0, 0, 0, 10, 7200, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_baphomet_speed_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_09_z7_baphomet_speed_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_09_z7_baphomet_speed_l3', @presenceid, 2, @definition, 0, 0, 0, 10, 7200, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_prometheus_speed_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_09_z7_prometheus_speed_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_09_z7_prometheus_speed_l3', @presenceid, 1, @definition, 0, 0, 0, 10, 7200, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

--- pitboss

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'pitboss_01_z7' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('pitboss_01_z7', 1790, 1725, 1855, 1790, 'Shinjalar pitboss', @spawnid, 1, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'pitboss_01_z7'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'pitboss_01_z7')

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_onyx_thelodica_pitboss')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'pitboss_01_z7_def_npc_shinjalar_onyx_thelodica_pitboss')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('pitboss_01_z7_def_npc_shinjalar_onyx_thelodica_pitboss', @presenceid, 1, @definition, 1820, 1760, 0, 15, 432000, 0, 90, 'shinjalar boss npc', 0.9, 1, 1, 2, 1)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_seth_miniboss_rank3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'pitboss_01_z7_def_npc_shinjalar_seth_miniboss_rank3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('pitboss_01_z7_def_npc_shinjalar_seth_miniboss_rank3', @presenceid, 1, @definition, 1820, 1760, 0, 15, 432000, 0, 90, 'shinjalar boss npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_zenith_miniboss_rank3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'pitboss_01_z7_def_npc_shinjalar_zenith_miniboss_rank3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('pitboss_01_z7_def_npc_shinjalar_zenith_miniboss_rank3', @presenceid, 2, @definition, 1820, 1760, 0, 15, 432000, 0, 90, 'shinjalar boss npc', 0.9, 1, 1, 2, 0)
END

--- miniboss

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'miniboss_01_z7' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('miniboss_01_z7', 225, 1660, 290, 1730, 'Shinjalar miniboss', @spawnid, 1, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'miniboss_01_z7'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'miniboss_01_z7')

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_seth_boss_miniboss')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'miniboss_01_z7_def_npc_shinjalar_seth_boss_miniboss')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('miniboss_01_z7_def_npc_shinjalar_seth_boss_miniboss', @presenceid, 1, @definition, 255, 1695, 0, 5, 18000, 0, 90, 'shinjalar mini boss npc', 0.9, 1, 1, 2, 1)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_zenith_shield_l7')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'miniboss_01_z7_def_npc_shinjalar_zenith_shield_l7')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('miniboss_01_z7_def_npc_shinjalar_zenith_shield_l7', @presenceid, 2, @definition, 255, 1695, 0, 5, 18000, 0, 90, 'shinjalar mini boss npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_artemis_dps_l7')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'miniboss_01_z7_def_npc_shinjalar_artemis_dps_l7')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('miniboss_01_z7_def_npc_shinjalar_artemis_dps_l7', @presenceid, 2, @definition, 255, 1695, 0, 5, 18000, 0, 90, 'shinjalar mini boss npc', 0.9, 1, 1, 2, 0)
END

--- courier 1

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'courier_01_z7' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('courier_01_z7', 10, 10, 2038, 2038, 'Shinjalar courier 1', @spawnid, 1, 1, 18000, 5, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'courier_01_z7'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'courier_01_z7')

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_baphomet_advanced_courier')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'courier_01_z7_def_npc_shinjalar_baphomet_advanced_courier')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('courier_01_z7_def_npc_shinjalar_baphomet_advanced_courier', @presenceid, 2, @definition, 0, 0, 0, 10, 18000, 0, 50, 'shinjalar npc', 0.9, 1, 1, 1, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_intakt_advanced_courier')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'courier_01_z7_def_npc_shinjalar_intakt_advanced_courier')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('courier_01_z7_def_npc_shinjalar_intakt_advanced_courier', @presenceid, 1, @definition, 0, 0, 0, 10, 18000, 0, 50, 'shinjalar npc', 0.9, 1, 1, 1, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_sequer_advanced_courier')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'courier_01_z7_def_npc_shinjalar_sequer_advanced_courier')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('courier_01_z7_def_npc_shinjalar_sequer_advanced_courier', @presenceid, 1, @definition, 0, 0, 0, 10, 18000, 0, 50, 'shinjalar npc', 0.9, 1, 1, 1, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET flockmembercount = 1 WHERE name = 'courier_01_z7_def_npc_shinjalar_sequer_advanced_courier'
END

--- courier 2

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'courier_02_z7' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('courier_02_z7', 10, 10, 2038, 2038, 'Shinjalar courier 2', @spawnid, 1, 1, 18000, 5, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'courier_02_z7'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'courier_02_z7')

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_prometheus_advanced_courier')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'courier_02_z7_def_npc_shinjalar_prometheus_advanced_courier')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('courier_02_z7_def_npc_shinjalar_prometheus_advanced_courier', @presenceid, 1, @definition, 0, 0, 0, 10, 18000, 0, 50, 'shinjalar npc', 0.9, 1, 1, 1, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_hermes_advanced_courier')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'courier_02_z7_def_npc_shinjalar_hermes_advanced_courier')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('courier_02_z7_def_npc_shinjalar_hermes_advanced_courier', @presenceid, 1, @definition, 0, 0, 0, 10, 18000, 0, 50, 'shinjalar npc', 0.9, 1, 1, 1, 0)
END

-- observer 1

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'observer_01_z7' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('observer_01_z7', 10, 10, 2038, 2038, 'Shinjalar observer 1', @spawnid, 1, 1, 18000, 5, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'observer_01_z7'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'observer_01_z7')

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_seth_advanced_observer')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'observer_01_z7_def_npc_shinjalar_seth_advanced_observer')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('observer_01_z7_def_npc_shinjalar_seth_advanced_observer', @presenceid, 2, @definition, 0, 0, 0, 10, 18000, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_artemis_advanced_observer')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'observer_01_z7_def_npc_shinjalar_artemis_advanced_observer')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('observer_01_z7_def_npc_shinjalar_artemis_advanced_observer', @presenceid, 1, @definition, 0, 0, 0, 10, 18000, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_zenith_advanced_observer')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'observer_01_z7_def_npc_shinjalar_zenith_advanced_observer')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('observer_01_z7_def_npc_shinjalar_zenith_advanced_observer', @presenceid, 1, @definition, 0, 0, 0, 10, 18000, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

-- observer 2

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'observer_02_z7' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('observer_02_z7', 10, 10, 2038, 2038, 'Shinjalar observer 2', @spawnid, 1, 1, 18000, 5, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'observer_02_z7'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'observer_02_z7')

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_artemis_advanced_observer')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'observer_02_z7_def_npc_shinjalar_artemis_advanced_observer')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('observer_02_z7_def_npc_shinjalar_artemis_advanced_observer', @presenceid, 2, @definition, 0, 0, 0, 10, 18000, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_zenith_advanced_observer')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'observer_02_z7_def_npc_shinjalar_zenith_advanced_observer')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('observer_02_z7_def_npc_shinjalar_zenith_advanced_observer', @presenceid, 1, @definition, 0, 0, 0, 10, 18000, 0, 50, 'shinjalar npc', 0.9, 1, 1, 2, 0)
END

-- spectator 1

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'spectator_01_z7' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('spectator_01_z7', 1790, 1280, 1855, 1345, 'Shinjalar spectator', @spawnid, 1, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'spectator_01_z7'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'spectator_01_z7')

--

DELETE FROM npcflock WHERE presenceid = @presenceid

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_spectator_miniboss')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'spectator_01_z7_def_npc_shinjalar_spectator_miniboss')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('spectator_01_z7_def_npc_shinjalar_spectator_miniboss', @presenceid, 1, @definition, 1825, 1315, 0, 5, 18000, 0, 90, 'shinjalar spectator npc', 0.9, 1, 1, 2, 1)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_zenith_shield_l7')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'spectator_01_z7_def_npc_shinjalar_zenith_shield_l7')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('spectator_01_z7_def_npc_shinjalar_zenith_shield_l7', @presenceid, 2, @definition, 1825, 1315, 0, 5, 18000, 0, 90, 'shinjalar spectator npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_shinjalar_artemis_dps_l7')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'spectator_01_z7_def_npc_shinjalar_artemis_dps_l7')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('spectator_01_z7_def_npc_shinjalar_artemis_dps_l7', @presenceid, 2, @definition, 1825, 1315, 0, 5, 18000, 0, 90, 'shinjalar spectator npc', 0.9, 1, 1, 2, 0)
END

GO

---- Add relics

DECLARE @sourceZoneId INT
DECLARE @destinationZoneId INT

-- Tellesis

SET @sourceZoneId = (SELECT TOP 1 id FROM zones WHERE name = 'zone_gamma_z137')
SET @destinationZoneId = (SELECT TOP 1 id FROM zones WHERE name = 'zone_ASI_pve')
  
DELETE FROM relicspawninfo WHERE zoneid = @destinationZoneId

INSERT INTO relicspawninfo (relictypeid, zoneid, rate, x, y)
SELECT relictypeid, @destinationZoneId, rate, x, y FROM relicspawninfo WHERE zoneid = @sourceZoneId

DELETE FROM reliczoneconfig WHERE zoneid = @destinationZoneId

INSERT INTO reliczoneconfig (zoneid, maxspawn, respawnrate)
SELECT @destinationZoneId, maxspawn, respawnrate FROM reliczoneconfig WHERE zoneid = @sourceZoneId

GO

---- Add zone effects

DROP TABLE IF EXISTS #EFFS;
CREATE TABLE #EFFS 
(
	effId INT,
	effName VARCHAR(100)
);

DROP TABLE IF EXISTS #EFFECTMODS;
CREATE TABLE #EFFECTMODS 
(
	effId INT,
	fieldName VARCHAR(100),
	fieldValue FLOAT
);

DECLARE @effectCatName BIGINT
SET @effectCatName = (SELECT TOP 1 flag FROM effectcategories WHERE name = 'effcat_zone_effects');

DECLARE @effectName  AS VARCHAR(100) = 'effect_alpha3_bonus';

IF NOT EXISTS (SELECT 1 FROM effects WHERE name = @effectName)
BEGIN
	INSERT INTO effects (effectcategory, duration, name, description, note, isaura, auraradius, ispositive, display, saveable) VALUES
	(@effectCatName, 0, @effectName, @effectName+'_desc', 'Alpha 3 zone effects', 1, 0, 1, 1, 0)
END

DECLARE @effectId INT;

SET @effectId = (SELECT TOP 1 id FROM effects WHERE name = @effectName)

INSERT INTO #EFFECTMODS (effId, fieldName, fieldValue) VALUES
(@effectId, 'effect_mining_amount_modifier', 1.3),
(@effectId, 'effect_harvesting_amount_modifier', 1.3),
(@effectId, 'effect_speed_highway_modifier', 0.35)

INSERT INTO #EFFS (effId, effName) VALUES
(@effectId, @effectName);

DELETE FROM effectdefaultmodifiers WHERE effectid IN (SELECT effId FROM #EFFS);

INSERT INTO effectdefaultmodifiers (effectid, field, value)
SELECT effId, (SELECT TOP 1 id FROM aggregatefields WHERE name=fieldName), fieldValue
FROM #EFFECTMODS;

DECLARE @zoneId INT

SET @zoneId = (SELECT TOP 1 id FROM zones WHERE name = 'zone_ASI_pve')

DELETE FROM zoneeffects WHERE zoneid = @zoneId;

INSERT INTO zoneeffects (zoneid, effectid) VALUES
(@zoneId, @effectId)

DROP TABLE IF EXISTS #EFFECTMODS;
DROP TABLE IF EXISTS #EFFS;
GO

	
GO

---- Fill syndicate market

DECLARE @sourcePresetId INT
DECLARE @destinationPresetId INT

SET @sourcePresetId = (SELECT TOP 1 id FROM itemshoppresets WHERE name = 'tm_preset_pve')
SET @destinationPresetId = (SELECT TOP 1 id FROM itemshoppresets WHERE name = 'asi_preset_pve')

DELETE FROM itemshop WHERE presetid = @destinationPresetId

INSERT INTO itemshop (presetid, targetdefinition, targetamount, tmcoin, icscoin, asicoin, credit, unicoin, globallimit, purchasecount, standing)
SELECT @destinationPresetId, targetdefinition, targetamount, tmcoin, icscoin, asicoin, credit, unicoin, globallimit, purchasecount, standing FROM itemshop its
INNER JOIN entitydefaults ed ON  its.targetdefinition = ed.definition
WHERE presetid = @sourcePresetId AND ed.categoryflags != 328859

GO


---- Set up missions for Shinjalar

DECLARE @zoneid INT

SET @zoneid = (SELECT TOP 1 id FROM zones WHERE name = 'zone_ASI_pve')

UPDATE missionlocations SET maxmissionlevel = 5 WHERE zoneid = @zoneid

---- Reconfigure plant rules for Shinjalar

UPDATE zones SET plantruleset = id WHERE name = 'zone_ASI_pve'

DECLARE @rulesetid INT

SET @rulesetid = (SELECT TOP 1 plantruleset FROM zones WHERE name = 'zone_ASI_pve')

DELETE FROM plantrules WHERE rulesetid = @rulesetid

INSERT INTO plantrules (plantrule, rulesetid, note) VALUES
('bush_a.txt', @rulesetid, 'Shinjalar decor'),
('bush_b.txt', @rulesetid, 'Shinjalar decor'),
('coppertree.txt', @rulesetid, 'Shinjalar decor'),
('grass_a.txt', @rulesetid, 'Shinjalar decor'),
('grass_b.txt', @rulesetid, 'Shinjalar decor'),
('nanowheat.txt', @rulesetid, 'Shinjalar decor'),
('pinetree.txt', @rulesetid, 'Shinjalar decor'),
('quag.txt', @rulesetid, 'Shinjalar decor'),
('rango.txt', @rulesetid, 'Shinjalar decor'),
('reed.txt', @rulesetid, 'Shinjalar decor'),
('poffeteg.txt', @rulesetid, 'Shinjalar decor'),
('electroplant_hi.txt', @rulesetid, 'Shinjalar harvestable'),
('irontree_hi.txt', @rulesetid, 'Shinjalar harvestable'),
('slimeroot_hi.txt', @rulesetid, 'Shinjalar harvestable')

GO

---- Reconfigure minerals for Shinjalar
DECLARE @materialType INT
DECLARE @zoneId INT

SET @zoneId = (SELECT TOP 1 id FROM zones WHERE name = 'zone_ASI_pve')

DELETE FROM mineralconfigs WHERE zoneid = @zoneId

SET @materialType = (SELECT TOP 1 idx FROM minerals WHERE name = 'titan')

INSERT INTO mineralconfigs (zoneid, materialtype, maxnodes, maxtilespernode, totalamountpernode, minthreshold) VALUES
(@zoneId, @materialType, 7, 625, 80000000, 0.5)

SET @materialType = (SELECT TOP 1 idx FROM minerals WHERE name = 'crude')

INSERT INTO mineralconfigs (zoneid, materialtype, maxnodes, maxtilespernode, totalamountpernode, minthreshold) VALUES
(@zoneId, @materialType, 7, 1000, 82125000, 0.5)

SET @materialType = (SELECT TOP 1 idx FROM minerals WHERE name = 'stermonit')

INSERT INTO mineralconfigs (zoneid, materialtype, maxnodes, maxtilespernode, totalamountpernode, minthreshold) VALUES
(@zoneId, @materialType, 7, 625, 68000000, 0.5)

SET @materialType = (SELECT TOP 1 idx FROM minerals WHERE name = 'silgium')
INSERT INTO mineralconfigs (zoneid, materialtype, maxnodes, maxtilespernode, totalamountpernode, minthreshold) VALUES
(@zoneId, @materialType, 7, 625, 68000000, 0.5)

SET @materialType = (SELECT TOP 1 idx FROM minerals WHERE name = 'liquizit')

INSERT INTO mineralconfigs (zoneid, materialtype, maxnodes, maxtilespernode, totalamountpernode, minthreshold) VALUES
(@zoneId, @materialType, 7, 625, 80000000, 0.5)

GO

---- Attalica

-- Create and fill new npc

DECLARE @sourceDefinition INT
DECLARE @targetDefinition INT
DECLARE @gamma_syndicate_shards INT
DECLARE @gamma_pelistal_shards INT

SET @gamma_syndicate_shards = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_material_boss_gamma_syndicate')
SET @gamma_pelistal_shards = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_material_boss_gamma_pelistal')

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_attalica_tyrannos_dps_l3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_attalica_tyrannos_dps_l3', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_attalica_tyrannos_dps_l3_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_tyrannos_dps_l3'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_tyrannos_dps_l3')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_tyrannos_dps_l3')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_pelistal_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_attalica_waspish_dps_l3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_attalica_waspish_dps_l3', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_attalica_waspish_dps_l3_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_waspish_dps_l3'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_waspish_dps_l3')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_waspish_dps_l3')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_pelistal_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_attalica_troiar_shield_l3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_attalica_troiar_shield_l3', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_attalica_troiar_shield_l3_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_troiar_shield_l3'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_troiar_shield_l3')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_troiar_shield_l3')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_pelistal_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_attalica_sequer_basic_lindy')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_attalica_sequer_basic_lindy', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_attalica_sequer_basic_lindy_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_sequer_basic_lindy'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_sequer_basic_lindy')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_sequer_basic_lindy')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_pelistal_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_attalica_riveler_basic_lindy')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_attalica_riveler_basic_lindy', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_attalica_riveler_basic_lindy_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_riveler_basic_lindy'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_riveler_basic_lindy')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_riveler_basic_lindy')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_pelistal_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_attalica_laird_basic_lindy')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_attalica_laird_basic_lindy', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_attalica_laird_basic_lindy_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_laird_basic_lindy'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_laird_basic_lindy')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_laird_basic_lindy')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_pelistal_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_attalica_gropho_tank_l3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_attalica_gropho_tank_l3', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_attalica_gropho_tank_l3_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_mesmer_tank_l3'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_gropho_tank_l3')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_gropho_tank_l3')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_pelistal_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_attalica_tyrannos_tank_l3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_attalica_tyrannos_tank_l3', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_attalica_tyrannos_tank_l3_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_tyrannos_tank_l3'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_tyrannos_tank_l3')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_tyrannos_tank_l3')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_pelistal_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_attalica_ictus_armor_l3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_attalica_ictus_armor_l3', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_attalica_ictus_armor_l3_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_ictus_armor_l3'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_ictus_armor_l3')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_ictus_armor_l3')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_pelistal_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_attalica_troiar_armor_l3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_attalica_troiar_armor_l3', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_attalica_troiar_armor_l3_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_troiar_armor_l3'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_troiar_armor_l3')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_troiar_armor_l3')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_pelistal_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_attalica_castel_dps_l3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_attalica_castel_dps_l3', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_attalica_castel_dps_l3_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_castel_dps_l3'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_castel_dps_l3')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_castel_dps_l3')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_pelistal_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_attalica_gropho_dps_l3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_attalica_gropho_dps_l3', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_attalica_gropho_dps_l3_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_gropho_dps_l3'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_gropho_dps_l3')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_gropho_dps_l3')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_pelistal_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_attalica_castel_speed_l3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_attalica_castel_speed_l3', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_attalica_castel_speed_l3_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_castel_speed_l3'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_castel_speed_l3')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_castel_speed_l3')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_pelistal_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_attalica_waspish_speed_l3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_attalica_waspish_speed_l3', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_attalica_waspish_speed_l3_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_waspish_speed_l3'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_waspish_speed_l3')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_waspish_speed_l3')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_pelistal_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_attalica_argano_basic_lindy')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_attalica_argano_basic_lindy', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_attalica_argano_basic_lindy_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_argano_basic_lindy'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_argano_basic_lindy')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_argano_basic_lindy')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_pelistal_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_attalica_hydra_pelistal_pitboss')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_attalica_hydra_pelistal_pitboss', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_attalica_hydra_pelistal_pitboss_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_hydra_pelistal_pitboss'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_hydra_pelistal_pitboss')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_hydra_pelistal_pitboss')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_pelistal_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

DECLARE @epriton INT
DECLARE @noralghis INT

SET @epriton = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_epriton')
SET @noralghis = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_electroplant_fruit')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @epriton, 2000000, 1, 0, 1, 500000),
(@targetDefinition, @noralghis, 2000000, 1, 0, 1, 500000)

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_attalica_gropho_miniboss_rank3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_attalica_gropho_miniboss_rank3', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_attalica_gropho_miniboss_rank3_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gropho_miniboss_rank3'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gropho_miniboss_rank3')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_gropho_miniboss_rank3')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_pelistal_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_attalica_ictus_miniboss_rank3')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_attalica_ictus_miniboss_rank3', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_attalica_ictus_miniboss_rank3_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_ictus_miniboss_rank3'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_ictus_miniboss_rank3')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_ictus_miniboss_rank3')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_pelistal_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_attalica_gropho_boss_miniboss')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_attalica_gropho_boss_miniboss', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_attalica_gropho_boss_miniboss_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_gropho_boss_miniboss'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_gropho_boss_miniboss')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_gropho_boss_miniboss')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_pelistal_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_attalica_ictus_shield_l7')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_attalica_ictus_shield_l7', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_attalica_ictus_shield_l7_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_ictus_shield_l7'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_ictus_shield_l7')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_ictus_shield_l7')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_pelistal_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_attalica_tyrannos_dps_l7')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_attalica_tyrannos_dps_l7', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_attalica_tyrannos_dps_l7_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_tyrannos_dps_l7'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_tyrannos_dps_l7')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_tyrannos_dps_l7')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_pelistal_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_attalica_waspish_advanced_courier')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_attalica_waspish_advanced_courier', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_attalica_waspish_advanced_courier_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_waspish_advanced_courier'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_waspish_advanced_courier')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_waspish_advanced_courier')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_pelistal_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_attalica_troiar_advanced_courier')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_attalica_troiar_advanced_courier', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_attalica_troiar_advanced_courier_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_troiar_advanced_courier'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_troiar_advanced_courier')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_troiar_advanced_courier')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_pelistal_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_attalica_sequer_advanced_courier')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_attalica_sequer_advanced_courier', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_attalica_sequer_advanced_courier_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_sequer_advanced_courier'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_sequer_advanced_courier')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_sequer_advanced_courier')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_pelistal_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_attalica_castel_advanced_courier')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_attalica_castel_advanced_courier', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_attalica_castel_advanced_courier_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_castel_advanced_courier'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_castel_advanced_courier')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_castel_advanced_courier')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_pelistal_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_attalica_hermes_advanced_courier')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_attalica_hermes_advanced_courier', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_attalica_hermes_advanced_courier_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_hermes_advanced_courier'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_hermes_advanced_courier')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_hermes_advanced_courier')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_pelistal_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_attalica_gropho_advanced_observer')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_attalica_gropho_advanced_observer', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_attalica_gropho_advanced_observer_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_gropho_advanced_observer'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_gropho_advanced_observer')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_gropho_advanced_observer')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_pelistal_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_attalica_tyrannos_advanced_observer')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_attalica_tyrannos_advanced_observer', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_attalica_tyrannos_advanced_observer_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_tyrannos_advanced_observer'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_tyrannos_advanced_observer')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_tyrannos_advanced_observer')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_pelistal_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_attalica_ictus_advanced_observer')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_attalica_ictus_advanced_observer', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_attalica_ictus_advanced_observer_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_ictus_advanced_observer'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_ictus_advanced_observer')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_ictus_advanced_observer')

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
WHERE nl.definition = @sourceDefinition AND (ed.tierlevel IS NULL OR (ed.tierlevel != 4)) AND nl.lootdefinition != @gamma_syndicate_shards AND nl.lootdefinition != @gamma_pelistal_shards

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity)
SELECT @targetDefinition, t3.definition, nl.quantity, nl.probability, nl.repackaged, nl.dontdamage, nl.minquantity FROM npcloot nl
INNER JOIN entitydefaults t4 ON nl.lootdefinition = t4.definition
INNER JOIN entitydefaults t3 ON t4.categoryflags = t3.categoryflags
WHERE nl.definition = @sourceDefinition
AND t4.tiertype = 1 and  t4.tierlevel = 4 and t3.tiertype = 1 and t3.tierlevel = 3

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_attalica_spectator_miniboss')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) VALUES
	('def_npc_attalica_spectator_miniboss', 1, 1024, 1167, '', 'Spectator, Pelistal Drones, Shield', 1, 0, 0, 0, 100, 'def_npc_attalica_spectator_miniboss_desc', 1, NULL, NULL)
END

SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_spectator_miniboss')

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

DECLARE @field INT

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 3)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 3 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 3)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 3 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'energy_vampired_amount_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 1.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.5 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locked_targets_max')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 10)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 10 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locked_targets_max_bonus')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 10)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 10 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 4.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 4.5 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 0.7)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.7 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_chemical')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 200)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 200 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_explosive')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 200)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 200 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_kinetic')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 200)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 200 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'resist_thermal')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 200)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 200 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'sensor_strength_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 300)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 300 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'shield_absorbtion_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 3)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 3 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_bandwidth_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 10)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 15 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'remote_control_operational_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 50)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 50 WHERE definition = @targetDefinition AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @targetDefinition AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@targetDefinition, @field, 3)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 3 WHERE definition = @targetDefinition AND field = @field
END

--

DECLARE @robot INT
DECLARE @head INT
DECLARE @chassis INT
DECLARE @leg INT
DECLARE @inventory INT
DECLARE @shield INT
DECLARE @shield_hardener INT
DECLARE @remote_controller INT
DECLARE @recharger INT
DECLARE @drainer INT
DECLARE @sensor_booster INT
DECLARE @combat_drone INT

SET @robot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_bot')
SET @head = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_head')
SET @chassis = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_chassis')
SET @leg = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_leg')
SET @inventory = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_robot_inventory_spectator')
SET @shield = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_shield_generator')
SET @shield_hardener = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_shield_hardener')
SET @remote_controller = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_remote_controller')
SET @recharger = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_core_recharger')
SET @drainer = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_energy_vampire')
SET @sensor_booster = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_sensor_booster')
SET @combat_drone = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_pelistal_combat_drone_unit')

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'Spectator_Pelistal_Drones_Shield')
BEGIN
	INSERT INTO robottemplates (name, description, note) VALUES
	('Spectator_Pelistal_Drones_Shield', CONCAT(
		'#robot=i',
		FORMAT(@robot, 'X'),
		'#head=i',
		FORMAT(@head, 'X'),
		'#chassis=i',
		FORMAT(@chassis, 'X'),
		'#leg=i',
		FORMAT(@leg, 'X'),
		'#container=i',
		FORMAT(@inventory, 'X'),
		'#headModules=[|m0=[|definition=i',
		FORMAT(@remote_controller, 'X'),
		'|slot=i1|ammoDefinition=i',
		FORMAT(@combat_drone, 'X'),
		'|ammoQuantity=i1]|m1=[|definition=i',
		FORMAT(@sensor_booster, 'X'),
		'|slot=i2]|m2=[|definition=i',
		FORMAT(@sensor_booster, 'X'),
		'|slot=i3]|m3=[|definition=i',
		FORMAT(@shield_hardener, 'X'),
		'|slot=i4]|m4=[|definition=i',
		FORMAT(@shield_hardener, 'X'),
		'|slot=i5]|m5=[|definition=i',
		FORMAT(@shield_hardener, 'X'),
		'|slot=i6]]#chassisModules=[|m0=[|definition=i',
		FORMAT(@drainer, 'X'),
		'|slot=i1]]#legModules=[|m0=[|definition=i',
		FORMAT(@shield, 'X'),
		'|slot=i1]|m1=[|definition=i',
		FORMAT(@recharger, 'X'),
		'|slot=i2]|m2=[|definition=i',
		FORMAT(@recharger, 'X'),
		'|slot=i2]|m3=[|definition=i',
		FORMAT(@recharger, 'X'),
		'|slot=i4]|m4=[|definition=i',
		FORMAT(@recharger, 'X'),
		'|slot=i5]]'), 'NPC Shielded Spectator with Pelistal Drones')
END
ELSE
BEGIN
	UPDATE robottemplates SET description = CONCAT(
		'#robot=i',
		FORMAT(@robot, 'X'),
		'#head=i',
		FORMAT(@head, 'X'),
		'#chassis=i',
		FORMAT(@chassis, 'X'),
		'#leg=i',
		FORMAT(@leg, 'X'),
		'#container=i',
		FORMAT(@inventory, 'X'),
		'#headModules=[|m0=[|definition=i',
		FORMAT(@remote_controller, 'X'),
		'|slot=i1|ammoDefinition=i',
		FORMAT(@combat_drone, 'X'),
		'|ammoQuantity=i1]|m1=[|definition=i',
		FORMAT(@sensor_booster, 'X'),
		'|slot=i2]|m2=[|definition=i',
		FORMAT(@sensor_booster, 'X'),
		'|slot=i3]|m3=[|definition=i',
		FORMAT(@shield_hardener, 'X'),
		'|slot=i4]|m4=[|definition=i',
		FORMAT(@shield_hardener, 'X'),
		'|slot=i5]|m5=[|definition=i',
		FORMAT(@shield_hardener, 'X'),
		'|slot=i6]]#chassisModules=[|m0=[|definition=i',
		FORMAT(@drainer, 'X'),
		'|slot=i1]]#legModules=[|m0=[|definition=i',
		FORMAT(@shield, 'X'),
		'|slot=i1]|m1=[|definition=i',
		FORMAT(@recharger, 'X'),
		'|slot=i2]|m1=[|definition=i',
		FORMAT(@recharger, 'X'),
		'|slot=i2]|m1=[|definition=i',
		FORMAT(@recharger, 'X'),
		'|slot=i4]|m1=[|definition=i',
		FORMAT(@recharger, 'X'),
		'|slot=i5]]')
	WHERE name = 'Spectator_Pelistal_Drones_Shield'
END

DECLARE @templateId INT

SET @templateId = (SELECT TOP 1 id FROM robottemplates WHERE name = 'Spectator_Pelistal_Drones_Shield')

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note) VALUES
(@targetDefinition, @templateId, 2, NULL, NULL, 1500, 'def_npc_attalica_spectator_miniboss')

DELETE FROM npcloot WHERE definition = @targetDefinition

DECLARE @lootDefinition INT

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_core_recharger')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_shield_generator')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_shield_hardener')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.35, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_remote_controller')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.15, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standard_medium_energy_vampire')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.25, 0, 0, 1)

--

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_core_recharger')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_shield_generator')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_shield_hardener')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.035, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.027, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_remote_controller')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.015, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_medium_energy_vampire')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.025, 0, 0, 1)

--

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_core_recharger')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_medium_shield_generator')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_shield_hardener')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1),
(@targetDefinition, @lootDefinition, 1, 0.0175, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_remote_controller')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.0075, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_medium_energy_vampire')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.0125, 0, 0, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_spectator_mk3_A_CT_capsule')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 1, 1, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_standart_pelistal_combat_drone_unit')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 10, 0.5, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_pelistal_combat_drone_unit')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 10, 0.05, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_material_boss_gamma_syndicate')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 200, 1, 0, 1, 20)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_pelistal')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 75000, 1, 0, 1, 37500)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_hitech')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 75000, 1, 0, 1, 37500)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_kernel_common')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 75000, 1, 0, 1, 37500)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_8')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.3, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_research_kit_9')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 0.3, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_pelistal_reactor_plasma')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 250000, 1, 0, 1, 125000)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_boost_ep_t0')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 3, 1, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_boost_ep_t1')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 2, 1, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_boost_ep_t2')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 1, 0, 1, 1)

SET @lootDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_reactore_core_heavymech')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@targetDefinition, @lootDefinition, 1, 3, 0, 1, 1)

GO

-- Add roamers for attalica

DECLARE @spawnid INT
DECLARE @presenceid INT
DECLARE @definition INT
DECLARE @templateid INT

SET @spawnid = (SELECT TOP 1 spawnid FROM zones WHERE name = 'zone_ICS')

--- roamers 1

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'roamer_01_z1' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('roamer_01_z1', 10, 10, 2038, 2038, 'attalica roamers 1', @spawnid, 1, 1, 7200, 5, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'roamer_01_z1'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'roamer_01_z1')

----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_tyrannos_dps_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_01_z1_tyrannos_dps_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_01_z1_tyrannos_dps_l3', @presenceid, 2, @definition, 0, 0, 0, 10, 7200, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_waspish_dps_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_01_z1_waspish_dps_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_01_z1_waspish_dps_l3', @presenceid, 4, @definition, 0, 0, 0, 10, 7200, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_troiar_shield_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_01_z1_troiar_shield_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_01_z1_troiar_shield_l3', @presenceid, 3, @definition, 0, 0, 0, 10, 7200, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

--- roamers 2

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'roamer_02_z1' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('roamer_02_z1', 10, 10, 2038, 2038, 'attalica roamers 2', @spawnid, 1, 1, 7200, 5, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'roamer_02_z1'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'roamer_02_z1')

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_sequer_basic_lindy')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'roamer_02_z1_sequer_basic_lindy')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_02_z1_sequer_basic_lindy', @presenceid, 2, @definition, 0, 0, 0, 10, 7200, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_riveler_basic_lindy')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_02_z1_riveler_basic_lindy')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_02_z1_riveler_basic_lindy', @presenceid, 1, @definition, 0, 0, 0, 10, 7200, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_laird_basic_lindy')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'roamer_02_z1_laird_basic_lindy')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_02_z1_laird_basic_lindy', @presenceid, 2, @definition, 0, 0, 0, 10, 7200, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_gropho_tank_l3')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'roamer_02_z1_gropho_tank_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_02_z1_gropho_tank_l3', @presenceid, 1, @definition, 0, 0, 0, 10, 7200, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_tyrannos_tank_l3')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'roamer_02_z1_tyrannos_tank_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_02_z1_tyrannos_tank_l3', @presenceid, 3, @definition, 0, 0, 0, 10, 7200, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_ictus_armor_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_02_z1_ictus_armor_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_02_z1_ictus_armor_l3', @presenceid, 1, @definition, 0, 0, 0, 10, 7200, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_troiar_armor_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_02_z1_troiar_armor_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_02_z1_troiar_armor_l3', @presenceid, 2, @definition, 0, 0, 0, 10, 7200, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_castel_speed_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_02_z1_castel_speed_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_02_z1_castel_speed_l3', @presenceid, 2, @definition, 0, 0, 0, 10, 7200, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

--- roamers 3

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'roamer_03_z1' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('roamer_03_z1', 10, 10, 2038, 2038, 'attalica roamers 3', @spawnid, 1, 1, 7200, 5, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'roamer_03_z1'
END


SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'roamer_03_z1')

----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_waspish_dps_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_03_z1_waspish_dps_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_03_z1_waspish_dps_l3', @presenceid, 4, @definition, 0, 0, 0, 10, 7200, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_ictus_armor_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_03_z1_ictus_armor_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_03_z1_ictus_armor_l3', @presenceid, 2, @definition, 0, 0, 0, 10, 7200, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_castel_dps_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_03_z1_castel_dps_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_03_z1_castel_dps_l3', @presenceid, 3, @definition, 0, 0, 0, 10, 7200, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

--- roamers 4

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'roamer_04_z1' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('roamer_04_z1', 10, 10, 2038, 2038, 'attalica roamers 4', @spawnid, 1, 1, 7200, 5, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'roamer_04_z1'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'roamer_04_z1')

----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_gropho_dps_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_04_z1_gropho_dps_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_04_z1_gropho_dps_l3', @presenceid, 3, @definition, 0, 0, 0, 10, 7200, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_castel_speed_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_04_z1_castel_speed_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_04_z1_castel_speed_l3', @presenceid, 3, @definition, 0, 0, 0, 10, 7200, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_waspish_speed_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_04_z1_waspish_speed_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_04_z1_waspish_speed_l3', @presenceid, 4, @definition, 0, 0, 0, 10, 7200, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

--- roamers 5

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'roamer_05_z1' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('roamer_05_z1', 10, 10, 2038, 2038, 'attalica roamers 5', @spawnid, 1, 1, 7200, 5, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'roamer_05_z1'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'roamer_05_z1')

----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_tyrannos_dps_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_05_z1_tyrannos_dps_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_05_z1_tyrannos_dps_l3', @presenceid, 3, @definition, 0, 0, 0, 10, 7200, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_ictus_armor_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_05_z1_ictus_armor_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_05_z1_ictus_armor_l3', @presenceid, 1, @definition, 0, 0, 0, 10, 7200, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_troiar_armor_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_05_z1_troiar_armor_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_05_z1_troiar_armor_l3', @presenceid, 1, @definition, 0, 0, 0, 10, 7200, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_castel_dps_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_05_z1_castel_dps_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_05_z1_castel_dps_l3', @presenceid, 3, @definition, 0, 0, 0, 10, 7200, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

--- roamers 6

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'roamer_06_z1' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('roamer_06_z1', 10, 10, 2038, 2038, 'attalica roamers 6', @spawnid, 1, 1, 7200, 5, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'roamer_06_z1'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'roamer_06_z1')

----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_castel_speed_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_06_z1_castel_speed_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_06_z1_castel_speed_l3', @presenceid, 3, @definition, 0, 0, 0, 10, 7200, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_waspish_speed_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_06_z1_waspish_speed_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_06_z1_waspish_speed_l3', @presenceid, 4, @definition, 0, 0, 0, 10, 7200, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_troiar_shield_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_06_z1_troiar_shield_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_06_z1_troiar_shield_l3', @presenceid, 2, @definition, 0, 0, 0, 10, 7200, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_tyrannos_dps_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_06_z1_tyrannos_dps_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_06_z1_tyrannos_dps_l3', @presenceid, 3, @definition, 0, 0, 0, 10, 7200, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

--- roamers 7

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'roamer_07_z1' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('roamer_07_z1', 10, 10, 2038, 2038, 'attalica roamers 7', @spawnid, 1, 1, 7200, 5, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'roamer_07_z1'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'roamer_07_z1')

----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_castel_speed_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_07_z1_castel_speed_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_07_z1_castel_speed_l3', @presenceid, 2, @definition, 0, 0, 0, 10, 7200, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_troiar_shield_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_07_z1_troiar_shield_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_07_z1_troiar_shield_l3', @presenceid, 2, @definition, 0, 0, 0, 10, 7200, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_waspish_dps_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_07_z1_waspish_dps_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_07_z1_waspish_dps_l3', @presenceid, 2, @definition, 0, 0, 0, 10, 7200, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

--- roamers 8

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'roamer_08_z1' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('roamer_08_z1', 10, 10, 2038, 2038, 'attalica roamers 8', @spawnid, 1, 1, 7200, 5, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'roamer_08_z1'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'roamer_08_z1')

----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_gropho_dps_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_08_z1_gropho_dps_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_08_z1_gropho_dps_l3', @presenceid, 2, @definition, 0, 0, 0, 10, 7200, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_tyrannos_dps_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_08_z1_tyrannos_dps_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_08_z1_tyrannos_dps_l3', @presenceid, 5, @definition, 0, 0, 0, 10, 7200, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_troiar_armor_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_08_z1_troiar_armor_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_08_z1_troiar_armor_l3', @presenceid, 2, @definition, 0, 0, 0, 10, 7200, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_castel_dps_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_08_z1_castel_dps_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_08_z1_castel_dps_l3', @presenceid, 3, @definition, 0, 0, 0, 10, 7200, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

--- roamers 9

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'roamer_09_z1' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('roamer_09_z1', 10, 10, 2038, 2038, 'attalica roamers 9', @spawnid, 1, 1, 7200, 5, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'roamer_09_z1'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'roamer_09_z1')

----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_sequer_basic_lindy')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_09_z1_sequer_basic_lindy')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_09_z1_sequer_basic_lindy', @presenceid, 1, @definition, 0, 0, 0, 10, 7200, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_laird_basic_lindy')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_09_z1_laird_basic_lindy')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_09_z1_laird_basic_lindy', @presenceid, 1, @definition, 0, 0, 0, 10, 7200, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_argano_basic_lindy')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_09_z1_argano_basic_lindy')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_09_z1_argano_basic_lindy', @presenceid, 1, @definition, 0, 0, 0, 10, 7200, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_waspish_speed_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_09_z1_waspish_speed_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_09_z1_waspish_speed_l3', @presenceid, 2, @definition, 0, 0, 0, 10, 7200, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_castel_speed_l3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'roamer_09_z1_castel_speed_l3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_09_z1_castel_speed_l3', @presenceid, 1, @definition, 0, 0, 0, 10, 7200, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

--- pitboss

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'pitboss_01_z1' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('pitboss_01_z1', 605, 510, 670, 575, 'attalica pitboss', @spawnid, 1, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1, topx = 605, topy = 510, bottomx = 670, bottomy = 575 WHERE name = 'pitboss_01_z1'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'pitboss_01_z1')

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_hydra_pelistal_pitboss')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'pitboss_01_z1_def_npc_attalica_hydra_pelistal_pitboss')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('pitboss_01_z1_def_npc_attalica_hydra_pelistal_pitboss', @presenceid, 1, @definition, 640, 540, 0, 15, 432000, 0, 90, 'attalica boss npc', 0.9, 1, 1, 2, 1)
END
ELSE
BEGIN
	UPDATE npcflock SET spawnoriginX = 640, spawnoriginY = 540 WHERE name = 'pitboss_01_z1_def_npc_attalica_hydra_pelistal_pitboss'
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_gropho_miniboss_rank3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'pitboss_01_z1_def_npc_attalica_gropho_miniboss_rank3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('pitboss_01_z1_def_npc_attalica_gropho_miniboss_rank3', @presenceid, 1, @definition, 640, 540, 0, 15, 432000, 0, 90, 'attalica boss npc', 0.9, 1, 1, 2, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET spawnoriginX = 640, spawnoriginY = 540 WHERE name = 'pitboss_01_z1_def_npc_attalica_gropho_miniboss_rank3'
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_ictus_miniboss_rank3')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'pitboss_01_z1_def_npc_attalica_ictus_miniboss_rank3')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('pitboss_01_z1_def_npc_attalica_ictus_miniboss_rank3', @presenceid, 2, @definition, 640, 540, 0, 15, 432000, 0, 90, 'attalica boss npc', 0.9, 1, 1, 2, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET spawnoriginX = 640, spawnoriginY = 540 WHERE name = 'pitboss_01_z1_def_npc_attalica_ictus_miniboss_rank3'
END

--- miniboss

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'miniboss_01_z1' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('miniboss_01_z1', 605, 1695, 670, 1760, 'attalica miniboss', @spawnid, 1, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1, topx = 605, topy = 1695, bottomx = 670, bottomy = 1760 WHERE name = 'miniboss_01_z1'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'miniboss_01_z1')

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_gropho_boss_miniboss')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'miniboss_01_z1_def_npc_attalica_gropho_boss_miniboss')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('miniboss_01_z1_def_npc_attalica_gropho_boss_miniboss', @presenceid, 1, @definition, 640, 1725, 0, 5, 18000, 0, 90, 'attalica mini boss npc', 0.9, 1, 1, 2, 1)
END
ELSE
BEGIN
	UPDATE npcflock SET spawnoriginX = 640, spawnoriginY = 1725 WHERE name = 'miniboss_01_z1_def_npc_attalica_gropho_boss_miniboss'
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_ictus_shield_l7')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'miniboss_01_z1_def_npc_attalica_ictus_shield_l7')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('miniboss_01_z1_def_npc_attalica_ictus_shield_l7', @presenceid, 2, @definition, 640, 1725, 0, 5, 18000, 0, 90, 'attalica mini boss npc', 0.9, 1, 1, 2, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET spawnoriginX = 640, spawnoriginY = 1725 WHERE name = 'miniboss_01_z1_def_npc_attalica_ictus_shield_l7'
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_tyrannos_dps_l7')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'miniboss_01_z1_def_npc_attalica_tyrannos_dps_l7')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('miniboss_01_z1_def_npc_attalica_tyrannos_dps_l7', @presenceid, 2, @definition, 640, 1725, 0, 5, 18000, 0, 90, 'attalica mini boss npc', 0.9, 1, 1, 2, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET spawnoriginX = 640, spawnoriginY = 1725 WHERE name = 'miniboss_01_z1_def_npc_attalica_tyrannos_dps_l7'
END

--- courier 1

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'courier_01_z1' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('courier_01_z1', 10, 10, 2038, 2038, 'attalica courier 1', @spawnid, 1, 1, 18000, 5, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'courier_01_z1'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'courier_01_z1')

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_waspish_advanced_courier')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'courier_01_z1_def_npc_attalica_waspish_advanced_courier')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('courier_01_z1_def_npc_attalica_waspish_advanced_courier', @presenceid, 2, @definition, 0, 0, 0, 10, 18000, 0, 50, 'attalica npc', 0.9, 1, 1, 1, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_troiar_advanced_courier')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'courier_01_z1_def_npc_attalica_troiar_advanced_courier')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('courier_01_z1_def_npc_attalica_troiar_advanced_courier', @presenceid, 1, @definition, 0, 0, 0, 10, 18000, 0, 50, 'attalica npc', 0.9, 1, 1, 1, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_sequer_advanced_courier')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'courier_01_z1_def_npc_attalica_sequer_advanced_courier')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('courier_01_z1_def_npc_attalica_sequer_advanced_courier', @presenceid, 1, @definition, 0, 0, 0, 10, 18000, 0, 50, 'attalica npc', 0.9, 1, 1, 1, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET flockmembercount = 1 WHERE name = 'courier_01_z1_def_npc_attalica_sequer_advanced_courier'
END

--- courier 2

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'courier_02_z1' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('courier_02_z1', 10, 10, 2038, 2038, 'attalica courier 2', @spawnid, 1, 1, 18000, 5, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'courier_02_z1'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'courier_02_z1')

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_castel_advanced_courier')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'courier_02_z1_def_npc_attalica_castel_advanced_courier')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('courier_02_z1_def_npc_attalica_castel_advanced_courier', @presenceid, 1, @definition, 0, 0, 0, 10, 18000, 0, 50, 'attalica npc', 0.9, 1, 1, 1, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_hermes_advanced_courier')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'courier_02_z1_def_npc_attalica_hermes_advanced_courier')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('courier_02_z1_def_npc_attalica_hermes_advanced_courier', @presenceid, 1, @definition, 0, 0, 0, 10, 18000, 0, 50, 'attalica npc', 0.9, 1, 1, 1, 0)
END

-- observer 1

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'observer_01_z1' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('observer_01_z1', 10, 10, 2038, 2038, 'attalica observer 1', @spawnid, 1, 1, 18000, 5, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'observer_01_z1'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'observer_01_z1')

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_gropho_advanced_observer')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'observer_01_z1_def_npc_attalica_gropho_advanced_observer')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('observer_01_z1_def_npc_attalica_gropho_advanced_observer', @presenceid, 2, @definition, 0, 0, 0, 10, 18000, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_tyrannos_advanced_observer')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'observer_01_z1_def_npc_attalica_tyrannos_advanced_observer')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('observer_01_z1_def_npc_attalica_tyrannos_advanced_observer', @presenceid, 1, @definition, 0, 0, 0, 10, 18000, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_ictus_advanced_observer')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'observer_01_z1_def_npc_attalica_ictus_advanced_observer')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('observer_01_z1_def_npc_attalica_ictus_advanced_observer', @presenceid, 1, @definition, 0, 0, 0, 10, 18000, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

-- observer 2

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'observer_02_z1' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('observer_02_z1', 10, 10, 2038, 2038, 'attalica observer 2', @spawnid, 1, 1, 18000, 5, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1 WHERE name = 'observer_02_z1'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'observer_02_z1')

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_tyrannos_advanced_observer')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'observer_02_z1_def_npc_attalica_tyrannos_advanced_observer')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('observer_02_z1_def_npc_attalica_tyrannos_advanced_observer', @presenceid, 2, @definition, 0, 0, 0, 10, 18000, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_ictus_advanced_observer')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'observer_02_z1_def_npc_attalica_ictus_advanced_observer')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('observer_02_z1_def_npc_attalica_ictus_advanced_observer', @presenceid, 1, @definition, 0, 0, 0, 10, 18000, 0, 50, 'attalica npc', 0.9, 1, 1, 2, 0)
END

-- spectator 1

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'spectator_01_z1' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('spectator_01_z1', 1310, 190, 1375, 255, 'attalica spectator', @spawnid, 1, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1, topx = 1310, topy = 190, bottomx = 1375, bottomy = 255 WHERE name = 'spectator_01_z1'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'spectator_01_z1')

--

DELETE FROM npcflock WHERE presenceid = @presenceid

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_spectator_miniboss')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'spectator_01_z1_def_npc_attalica_spectator_miniboss')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('spectator_01_z1_def_npc_attalica_spectator_miniboss', @presenceid, 1, @definition, 1345, 225, 0, 5, 18000, 0, 90, 'attalica spectator npc', 0.9, 1, 1, 2, 1)
END
ELSE
BEGIN
	UPDATE npcflock SET spawnoriginX = 1345, spawnoriginY = 225 WHERE name = 'spectator_01_z1_def_npc_attalica_spectator_miniboss'
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_ictus_shield_l7')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'spectator_01_z1_def_npc_attalica_ictus_shield_l7')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('spectator_01_z1_def_npc_attalica_ictus_shield_l7', @presenceid, 2, @definition, 1345, 225, 0, 5, 18000, 0, 90, 'attalica spectator npc', 0.9, 1, 1, 2, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET spawnoriginX = 1345, spawnoriginY = 225 WHERE name = 'spectator_01_z1_def_npc_attalica_ictus_shield_l7'
END

--

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_attalica_tyrannos_dps_l7')

IF NOT EXISTS (SELECt 1 FROM npcflock WHERE name = 'spectator_01_z1_def_npc_attalica_tyrannos_dps_l7')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('spectator_01_z1_def_npc_attalica_tyrannos_dps_l7', @presenceid, 2, @definition, 1345, 225, 0, 5, 18000, 0, 90, 'attalica spectator npc', 0.9, 1, 1, 2, 0)
END
ELSE
BEGIN
	UPDATE npcflock SET spawnoriginX = 1345, spawnoriginY = 225 WHERE name = 'spectator_01_z1_def_npc_attalica_tyrannos_dps_l7'
END

GO

---- Add relics

DECLARE @sourceZoneId INT
DECLARE @destinationZoneId INT

-- Attalica

SET @sourceZoneId = (SELECT TOP 1 id FROM zones WHERE name = 'zone_gamma_z125')
SET @destinationZoneId = (SELECT TOP 1 id FROM zones WHERE name = 'zone_ICS')
  
DELETE FROM relicspawninfo WHERE zoneid = @destinationZoneId

INSERT INTO relicspawninfo (relictypeid, zoneid, rate, x, y)
SELECT relictypeid, @destinationZoneId, rate, x, y FROM relicspawninfo WHERE zoneid = @sourceZoneId

DELETE FROM reliczoneconfig WHERE zoneid = @destinationZoneId

INSERT INTO reliczoneconfig (zoneid, maxspawn, respawnrate)
SELECT @destinationZoneId, maxspawn, respawnrate FROM reliczoneconfig WHERE zoneid = @sourceZoneId

GO

---- Add zone effects

DROP TABLE IF EXISTS #EFFS;
CREATE TABLE #EFFS 
(
	effId INT,
	effName VARCHAR(100)
);

DROP TABLE IF EXISTS #EFFECTMODS;
CREATE TABLE #EFFECTMODS 
(
	effId INT,
	fieldName VARCHAR(100),
	fieldValue FLOAT
);

DECLARE @effectCatName BIGINT
SET @effectCatName = (SELECT TOP 1 flag FROM effectcategories WHERE name = 'effcat_zone_effects');

DECLARE @effectName  AS VARCHAR(100) = 'effect_alpha3_bonus';

IF NOT EXISTS (SELECT 1 FROM effects WHERE name = @effectName)
BEGIN
	INSERT INTO effects (effectcategory, duration, name, description, note, isaura, auraradius, ispositive, display, saveable) VALUES
	(@effectCatName, 0, @effectName, @effectName+'_desc', 'Alpha 3 zone effects', 1, 0, 1, 1, 0)
END

DECLARE @effectId INT;

SET @effectId = (SELECT TOP 1 id FROM effects WHERE name = @effectName)

INSERT INTO #EFFECTMODS (effId, fieldName, fieldValue) VALUES
(@effectId, 'effect_mining_amount_modifier', 1.3),
(@effectId, 'effect_harvesting_amount_modifier', 1.3),
(@effectId, 'effect_speed_highway_modifier', 0.35)

INSERT INTO #EFFS (effId, effName) VALUES
(@effectId, @effectName);

DELETE FROM effectdefaultmodifiers WHERE effectid IN (SELECT effId FROM #EFFS);

INSERT INTO effectdefaultmodifiers (effectid, field, value)
SELECT effId, (SELECT TOP 1 id FROM aggregatefields WHERE name=fieldName), fieldValue
FROM #EFFECTMODS;

DECLARE @zoneId INT

SET @zoneId = (SELECT TOP 1 id FROM zones WHERE name = 'zone_ICS')

DELETE FROM zoneeffects WHERE zoneid = @zoneId;

INSERT INTO zoneeffects (zoneid, effectid) VALUES
(@zoneId, @effectId)

DROP TABLE IF EXISTS #EFFECTMODS;
DROP TABLE IF EXISTS #EFFS;
GO

	
GO

---- Fill syndicate market

IF NOT EXISTS (SELECT 1 FROM itemshoppresets WHERE name = 'attalica_preset')
BEGIN
	INSERT INTO itemshoppresets (name, note) VALUES ('attalica_preset', 'Attalica preset')
END

DECLARE @sourcePresetId INT
DECLARE @destinationPresetId INT

SET @sourcePresetId = (SELECT TOP 1 id FROM itemshoppresets WHERE name = 'tm_preset_pve')
SET @destinationPresetId = (SELECT TOP 1 id FROM itemshoppresets WHERE name = 'attalica_preset')

DECLARE @locationEid INT

SET @locationEid = (SELECT TOP 1 eid FROM entities WHERE ename = 'def_base_item_shop_megacorp_ICS_base_ICS')

UPDATE itemshoplocations SET presetid = @destinationPresetId WHERE locationeid = @locationEid

SET @locationEid = (SELECT TOP 1 eid FROM entities WHERE ename = 'def_base_item_shop_megacorp_ICS_ics_outpost_s_03')

UPDATE itemshoplocations SET presetid = @destinationPresetId WHERE locationeid = @locationEid

SET @locationEid = (SELECT TOP 1 eid FROM entities WHERE ename = 'def_base_item_shop_megacorp_ICS_ics_outpost_w_01')

UPDATE itemshoplocations SET presetid = @destinationPresetId WHERE locationeid = @locationEid

SET @locationEid = (SELECT TOP 1 eid FROM entities WHERE ename = 'def_base_item_shop_megacorp_ICS_ics_outpost_i_02')

UPDATE itemshoplocations SET presetid = @destinationPresetId WHERE locationeid = @locationEid

-- Disable outposts

SET @locationEid = (SELECT TOP 1 eid FROM entities WHERE ename = 'ics_outpost_s_03')

UPDATE zoneentities SET enabled = 0 WHERE eid = @locationEid

SET @locationEid = (SELECT TOP 1 eid FROM entities WHERE ename = 'ics_outpost_w_01')

UPDATE zoneentities SET enabled = 0 WHERE eid = @locationEid

SET @locationEid = (SELECT TOP 1 eid FROM entities WHERE ename = 'ics_outpost_i_02')

UPDATE zoneentities SET enabled = 0 WHERE eid = @locationEid

--

DELETE FROM itemshop WHERE presetid = @destinationPresetId

INSERT INTO itemshop (presetid, targetdefinition, targetamount, tmcoin, icscoin, asicoin, credit, unicoin, globallimit, purchasecount, standing)
SELECT @destinationPresetId, targetdefinition, targetamount, tmcoin, icscoin, asicoin, credit, unicoin, globallimit, purchasecount, standing FROM itemshop its
INNER JOIN entitydefaults ed ON  its.targetdefinition = ed.definition
WHERE presetid = @sourcePresetId AND ed.categoryflags != 328859

GO


---- Set up missions for attalica

DECLARE @zoneid INT

SET @zoneid = (SELECT TOP 1 id FROM zones WHERE name = 'zone_ICS')

UPDATE missionlocations SET maxmissionlevel = 5 WHERE zoneid = @zoneid

UPDATE missions SET listable = 0 WHERE name = 'mission_ics_gen_tutorial_exp3_01'
UPDATE missions SET listable = 0 WHERE name = 'mission_ics_gen_tutorial_exp3_02'
UPDATE missions SET listable = 0 WHERE name = 'mission_ics_gen_tutorial_exp3_03'
UPDATE missions SET listable = 0 WHERE name = 'mission_ics_gen_tutorial_exp3_04'
UPDATE missions SET listable = 0 WHERE name = 'mission_ics_gen_tutorial_exp3_05'

---- Reconfigure plant rules for attalica

UPDATE zones SET plantruleset = id WHERE name = 'zone_ASI_pve'

DECLARE @rulesetid INT

SET @rulesetid = (SELECT TOP 1 plantruleset FROM zones WHERE name = 'zone_ICS')

DELETE FROM plantrules WHERE rulesetid = @rulesetid

INSERT INTO plantrules (plantrule, rulesetid, note) VALUES
('bonsai.txt', @rulesetid, 'attalica decor'),
('bush_a.txt', @rulesetid, 'attalica decor'),
('bush_b.txt', @rulesetid, 'attalica decor'),
('coppertree.txt', @rulesetid, 'attalica decor'),
('grass_a.txt', @rulesetid, 'attalica decor'),
('grass_b.txt', @rulesetid, 'attalica decor'),
('nanowheat.txt', @rulesetid, 'attalica decor'),
('pinetree.txt', @rulesetid, 'attalica decor'),
('quag.txt', @rulesetid, 'attalica decor'),
('rango.txt', @rulesetid, 'attalica decor'),
('reed.txt', @rulesetid, 'attalica decor'),
('devrinol.txt', @rulesetid, 'attalica decor'),
('electroplant_hi.txt', @rulesetid, 'attalica harvestable'),
('rustbush_hi.txt', @rulesetid, 'attalica harvestable'),
('slimeroot_hi.txt', @rulesetid, 'attalica harvestable')

GO

---- Reconfigure minerals for attalica
DECLARE @materialType INT
DECLARE @zoneId INT

SET @zoneId = (SELECT TOP 1 id FROM zones WHERE name = 'zone_ICS')

DELETE FROM mineralconfigs WHERE zoneid = @zoneId

SET @materialType = (SELECT TOP 1 idx FROM minerals WHERE name = 'titan')

INSERT INTO mineralconfigs (zoneid, materialtype, maxnodes, maxtilespernode, totalamountpernode, minthreshold) VALUES
(@zoneId, @materialType, 7, 625, 80000000, 0.5)

SET @materialType = (SELECT TOP 1 idx FROM minerals WHERE name = 'crude')

INSERT INTO mineralconfigs (zoneid, materialtype, maxnodes, maxtilespernode, totalamountpernode, minthreshold) VALUES
(@zoneId, @materialType, 7, 1000, 82125000, 0.5)

SET @materialType = (SELECT TOP 1 idx FROM minerals WHERE name = 'imentium')

INSERT INTO mineralconfigs (zoneid, materialtype, maxnodes, maxtilespernode, totalamountpernode, minthreshold) VALUES
(@zoneId, @materialType, 7, 625, 68000000, 0.5)

SET @materialType = (SELECT TOP 1 idx FROM minerals WHERE name = 'silgium')

INSERT INTO mineralconfigs (zoneid, materialtype, maxnodes, maxtilespernode, totalamountpernode, minthreshold) VALUES
(@zoneId, @materialType, 7, 625, 68000000, 0.5)

SET @materialType = (SELECT TOP 1 idx FROM minerals WHERE name = 'liquizit')

INSERT INTO mineralconfigs (zoneid, materialtype, maxnodes, maxtilespernode, totalamountpernode, minthreshold) VALUES
(@zoneId, @materialType, 7, 625, 80000000, 0.5)

GO

---- Reconfigure facilities

DECLARE @refineryDef INT
DECLARE @reprocessorDef INT
DECLARE @repairDef INT
DECLARE @millDef INT
DECLARE @researchDef INT
DECLARE @prototyperDef INT
DECLARE @insuranceDef INT

SET @refineryDef = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname LIKE 'def_production_public_refinery_expert')
SET @reprocessorDef = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname LIKE 'def_production_public_reprocessor_expert')
SET @repairDef = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname LIKE 'def_production_public_repair_expert')
SET @millDef = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname LIKE 'def_production_public_mill_expert')
SET @researchDef = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname LIKE 'def_production_public_research_lab_expert')
SET @prototyperDef = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname LIKE 'def_production_public_prototyper_expert')

-- Attalica
UPDATE entities SET definition = @refineryDef, ename = 'att_main_refinery' WHERE eid = 5411
UPDATE entities SET definition = @reprocessorDef, ename = 'att_main_reprocessor' WHERE eid = 5412
UPDATE entities SET definition = @repairDef, ename = 'att_main_repair' WHERE eid = 5413
UPDATE entities SET definition = @millDef, ename = 'att_main_mill' WHERE eid = 5419
UPDATE entities SET definition = @researchDef, ename = 'att_main_research' WHERE eid = 5421
UPDATE entities SET definition = @prototyperDef, ename = 'att_main_prototyper' WHERE eid = 7469921050646518753

-- Shinjalar
UPDATE entities SET definition = @refineryDef, ename = 'shin_main_refinery' WHERE eid = 6953725903774205181
UPDATE entities SET definition = @reprocessorDef, ename = 'shin_main_reprocessor' WHERE eid = 7160950897797548303
UPDATE entities SET definition = @repairDef, ename = 'shin_main_repair' WHERE eid = 5776273669583621555
UPDATE entities SET definition = @millDef, ename = 'shin_main_mill' WHERE eid = 4687760999444118859
UPDATE entities SET definition = @researchDef, ename = 'shin_main_research' WHERE eid = 6419890686446661826
UPDATE entities SET definition = @prototyperDef, ename = 'shin_main_prototyper' WHERE eid = 9065732703366504452

-- Tellesis
UPDATE entities SET definition = @refineryDef, ename = 'tel_main_refinery' WHERE eid = 8080016735970572393
UPDATE entities SET definition = @reprocessorDef, ename = 'tel_main_reprocessor' WHERE eid = 8776225721013037542
UPDATE entities SET definition = @repairDef, ename = 'tel_main_repair' WHERE eid = 7266435953205600529
UPDATE entities SET definition = @millDef, ename = 'tel_main_mill' WHERE eid = 5320184780249762640
UPDATE entities SET definition = @researchDef, ename = 'tel_main_research' WHERE eid = 6858374397534836457
UPDATE entities SET definition = @prototyperDef, ename = 'tel_main_prototyper' WHERE eid = 7416657246823841518

-- Bases preparation

-- Attalica

-- Turn main base into pelistal
DECLARE @tmBaseDef INT

SET @tmBaseDef = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname LIKE 'def_public_docking_base_pelistal')

UPDATE entities SET definition = @tmBaseDef, ename = 'att_main_base', dynprop = '#welcome=$welcome_base_tm_pve_exp1#dockRange=i28' WHERE eid = 5132

-- Clean up main base
EXEC dbo.deleteAllChildren 8917253067254161373
EXEC dbo.deleteAllChildren 5432
EXEC dbo.deleteAllChildren 5434
EXEC dbo.deleteAllChildren 5430
EXEC dbo.deleteAllChildren 47418
EXEC dbo.deleteAllChildren 5411
EXEC dbo.deleteAllChildren 5412
EXEC dbo.deleteAllChildren 5413
EXEC dbo.deleteAllChildren 5420
EXEC dbo.deleteAllChildren 5422
EXEC dbo.deleteAllChildren 5250766927372213455
EXEC dbo.deleteAllChildren 8663525459612277990
EXEC dbo.deleteAllChildren 1564
EXEC dbo.deleteAllChildren 5133

-- Change ownership
DECLARE @attMainBase INT
DECLARE @tmOwner INT

SET @attMainBase = (SELECT TOP 1 eid FROM entities WHERE ename = 'att_main_base')
SET @tmOwner = (SELECT TOP 1 allianceEID FROM alliances WHERE name = 'megacorp_TM')

EXEC dbo.SetTreeOwner @tmOwner, @attMainBase

-- Reset ownership for transport storage (don't know why)
UPDATE entities SET ename = 'transport_storage_att_main_base', owner = null WHERE eid = 8917253067254161373

-- Tellesis

-- Clean up main base
EXEC dbo.deleteAllChildren 7079000408655018983
EXEC dbo.deleteAllChildren 6346349162393854815
EXEC dbo.deleteAllChildren 8254218349448977068
EXEC dbo.deleteAllChildren 5173060524273328969
EXEC dbo.deleteAllChildren 6015496554627087351
EXEC dbo.deleteAllChildren 8080016735970572393
EXEC dbo.deleteAllChildren 8776225721013037542
EXEC dbo.deleteAllChildren 7266435953205600529
EXEC dbo.deleteAllChildren 7026034761124780078
EXEC dbo.deleteAllChildren 5381780705227925742
EXEC dbo.deleteAllChildren 6528090892760216464
EXEC dbo.deleteAllChildren 5182920946505958595
EXEC dbo.deleteAllChildren 1578
EXEC dbo.deleteAllChildren 7880822021729875044

-- Shinjalar

-- Clean up main base
EXEC dbo.deleteAllChildren 7258779472350990097
EXEC dbo.deleteAllChildren 8044696035941838404
EXEC dbo.deleteAllChildren 4622411127645348042
EXEC dbo.deleteAllChildren 7768681933624397078
EXEC dbo.deleteAllChildren 5513442266480423820
EXEC dbo.deleteAllChildren 6953725903774205181
EXEC dbo.deleteAllChildren 7160950897797548303
EXEC dbo.deleteAllChildren 5776273669583621555
EXEC dbo.deleteAllChildren 8872083715098634568
EXEC dbo.deleteAllChildren 4801599834043484818
EXEC dbo.deleteAllChildren 7637375043820084692
EXEC dbo.deleteAllChildren 6640458141882567997
EXEC dbo.deleteAllChildren 1563
EXEC dbo.deleteAllChildren 8507534992678485369

GO

---- Add boss info

DECLARE @flockId INT

-- Attalica

SET @flockId = (SELECT TOP 1 id FROM npcflock WHERE name = 'spectator_01_z1_def_npc_attalica_spectator_miniboss')

IF NOT EXISTS (SELECT 1 FROM npcbossinfo WHERE flockid = @flockid)
BEGIN
	INSERT INTO npcbossinfo (flockid, respawnNoiseFactor, lootSplitFlag, outpostEID, stabilityPts, overrideRelations, customDeathMessage, customAggressMessage, riftConfigId, isAnnounced) VALUES
	(@flockId, 0.15, 1, NULL, NULL, 0, 'This is not our last attempt, human! This... "creature", we will research it!!!', 'You weren''t supposed to track it down... Impossible!!!', NULL, 1)
END

SET @flockId = (SELECT TOP 1 id FROM npcflock WHERE name = 'miniboss_01_z1_def_npc_attalica_gropho_boss_miniboss')

IF NOT EXISTS (SELECT 1 FROM npcbossinfo WHERE flockid = @flockid)
BEGIN
	INSERT INTO npcbossinfo (flockid, respawnNoiseFactor, lootSplitFlag, outpostEID, stabilityPts, overrideRelations, customDeathMessage, customAggressMessage, riftConfigId, isAnnounced) VALUES
	(@flockId, 0.15, 1, NULL, NULL, 0, '', '', NULL, 1)
END

SET @flockId = (SELECT TOP 1 id FROM npcflock WHERE name = 'pitboss_01_z1_def_npc_attalica_hydra_pelistal_pitboss')

IF NOT EXISTS (SELECT 1 FROM npcbossinfo WHERE flockid = @flockid)
BEGIN
	INSERT INTO npcbossinfo (flockid, respawnNoiseFactor, lootSplitFlag, outpostEID, stabilityPts, overrideRelations, customDeathMessage, customAggressMessage, riftConfigId, isAnnounced) VALUES
	(@flockId, 0.15, 1, NULL, NULL, 0, 'My death won''t change anything, human. Attalica belongs to us!', 'Don''t you ever think of it, human!', NULL, 1)
END

-- Shinjalar

SET @flockId = (SELECT TOP 1 id FROM npcflock WHERE name = 'spectator_01_z7_def_npc_shinjalar_spectator_miniboss')

IF NOT EXISTS (SELECT 1 FROM npcbossinfo WHERE flockid = @flockid)
BEGIN
	INSERT INTO npcbossinfo (flockid, respawnNoiseFactor, lootSplitFlag, outpostEID, stabilityPts, overrideRelations, customDeathMessage, customAggressMessage, riftConfigId, isAnnounced) VALUES
	(@flockId, 0.15, 1, NULL, NULL, 0, 'This is not our last attempt, human! This... "creature", we will research it!!!', 'You weren''t supposed to track it down... Impossible!!!', NULL, 1)
END

SET @flockId = (SELECT TOP 1 id FROM npcflock WHERE name = 'miniboss_01_z1_def_npc_attalica_gropho_boss_miniboss')

IF NOT EXISTS (SELECT 1 FROM npcbossinfo WHERE flockid = @flockid)
BEGIN
	INSERT INTO npcbossinfo (flockid, respawnNoiseFactor, lootSplitFlag, outpostEID, stabilityPts, overrideRelations, customDeathMessage, customAggressMessage, riftConfigId, isAnnounced) VALUES
	(@flockId, 0.15, 1, NULL, NULL, 0, '', '', NULL, 1)
END

SET @flockId = (SELECT TOP 1 id FROM npcflock WHERE name = 'pitboss_01_z7_def_npc_shinjalar_onyx_thelodica_pitboss')

IF NOT EXISTS (SELECT 1 FROM npcbossinfo WHERE flockid = @flockid)
BEGIN
	INSERT INTO npcbossinfo (flockid, respawnNoiseFactor, lootSplitFlag, outpostEID, stabilityPts, overrideRelations, customDeathMessage, customAggressMessage, riftConfigId, isAnnounced) VALUES
	(@flockId, 0.15, 1, NULL, NULL, 0, 'My death won''t change anything, human. Shinjalar belongs to us!', 'Don''t you ever think of it, human!', NULL, 1)
END

-- Tellesis

SET @flockId = (SELECT TOP 1 id FROM npcflock WHERE name = 'spectator_01_z6_def_npc_tellesis_spectator_miniboss')

IF NOT EXISTS (SELECT 1 FROM npcbossinfo WHERE flockid = @flockid)
BEGIN
	INSERT INTO npcbossinfo (flockid, respawnNoiseFactor, lootSplitFlag, outpostEID, stabilityPts, overrideRelations, customDeathMessage, customAggressMessage, riftConfigId, isAnnounced) VALUES
	(@flockId, 0.15, 1, NULL, NULL, 0, 'This is not our last attempt, human! This... "creature", we will research it!!!', 'You weren''t supposed to track it down... Impossible!!!', NULL, 1)
END

SET @flockId = (SELECT TOP 1 id FROM npcflock WHERE name = 'miniboss_01_z6_def_npc_tellesis_mesmer_boss_miniboss')

IF NOT EXISTS (SELECT 1 FROM npcbossinfo WHERE flockid = @flockid)
BEGIN
	INSERT INTO npcbossinfo (flockid, respawnNoiseFactor, lootSplitFlag, outpostEID, stabilityPts, overrideRelations, customDeathMessage, customAggressMessage, riftConfigId, isAnnounced) VALUES
	(@flockId, 0.15, 1, NULL, NULL, 0, '', '', NULL, 1)
END

SET @flockId = (SELECT TOP 1 id FROM npcflock WHERE name = 'pitboss_01_z6_def_npc_tellesis_felos_nuimqol_pitboss')

IF NOT EXISTS (SELECT 1 FROM npcbossinfo WHERE flockid = @flockid)
BEGIN
	INSERT INTO npcbossinfo (flockid, respawnNoiseFactor, lootSplitFlag, outpostEID, stabilityPts, overrideRelations, customDeathMessage, customAggressMessage, riftConfigId, isAnnounced) VALUES
	(@flockId, 0.15, 1, NULL, NULL, 0, 'My death won''t change anything, human. Tellesis belongs to us!', 'Don''t you ever think of it, human!', NULL, 1)
END

GO