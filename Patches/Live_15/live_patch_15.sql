USE [perpetuumsa]
GO

--------------------------------------------------
--Patch 15 
--Sap guard pt balance
--Description tokens on new items
--Artifactloot CT balance
--------------------------------------------------



USE [perpetuumsa]
GO

-----------------------------------------------
--NPC SAP Guard pts to -3
--Date: 2020/02/09
-----------------------------------------------

UPDATE npcbossinfo SET 
	stabilityPts = -3 
WHERE stabilityPts = -2 and customDeathMessage='SAP Guardian down!';

GO


USE [perpetuumsa]
GO

-----------------------------------------------
--Entitydefaults update description tokens for resource server support
--Date: 2020/02/09
-----------------------------------------------

UPDATE entitydefaults SET
	descriptiontoken = definitionname+'_desc'
WHERE definition < 5726 AND definition > 5547;

GO


USE [perpetuumsa]
GO

-------------------------------------------------------------------
--Artifact CT Loot rebalance
--Parameters: see econ sheet
--The distribution of CT's is now a factor of the island type alpha/beta/gamma
--The CT quality is a factor of the artifacttype level
--Date modified: 2020/01/11
-------------------------------------------------------------------

DROP TABLE IF EXISTS #INDY_CTS_BY_NAME;
DROP TABLE IF EXISTS #NUIMQOL_CTS_BY_NAME;
DROP TABLE IF EXISTS #PELI_CTS_BY_NAME;
DROP TABLE IF EXISTS #THELO_CTS_BY_NAME;

CREATE TABLE #INDY_CTS_BY_NAME (defName varchar(100), islandType varchar(100), level int, chance float);
CREATE TABLE #NUIMQOL_CTS_BY_NAME (defName varchar(100), islandType varchar(100), level int, chance float);
CREATE TABLE #PELI_CTS_BY_NAME (defName varchar(100), islandType varchar(100), level int, chance float);
CREATE TABLE #THELO_CTS_BY_NAME (defName varchar(100), islandType varchar(100), level int, chance float);

DROP TABLE IF EXISTS #INDY_CTS;
DROP TABLE IF EXISTS #NUIM_CTS;
DROP TABLE IF EXISTS #PELI_CTS;
DROP TABLE IF EXISTS #THELO_CTS;
CREATE TABLE #INDY_CTS (def int, islandType varchar(100), level int, chance float);
CREATE TABLE #NUIM_CTS (def int, islandType varchar(100), level int, chance float);
CREATE TABLE #PELI_CTS (def int, islandType varchar(100), level int, chance float);
CREATE TABLE #THELO_CTS (def int, islandType varchar(100), level int, chance float);

INSERT INTO #INDY_CTS_BY_NAME (defName, islandType, level, chance) VALUES
--LIGHT BOT: ARGANO
--A T1 CT
('def_argano_mk2_A_CT_capsule', 'alpha', 1, 0.10),
('def_argano_mk2_A_CT_capsule', 'beta', 1, 0.01),
--B T2
('def_argano_mk2_B_CT_capsule', 'alpha', 2, 0.10),
('def_argano_mk2_B_CT_capsule', 'beta', 2, 0.01),
--C T3
('def_argano_mk2_C_CT_capsule', 'alpha', 3, 0.10),
('def_argano_mk2_C_CT_capsule', 'beta', 3, 0.01),
--LIGHT BOT: laird
--A T1 CT
('def_laird_mk2_A_CT_capsule', 'alpha', 1, 0.10),
('def_laird_mk2_A_CT_capsule', 'beta', 1, 0.01),
--B T2
('def_laird_mk2_B_CT_capsule', 'alpha', 2, 0.10),
('def_laird_mk2_B_CT_capsule', 'beta', 2, 0.01),
--C T3
('def_laird_mk2_C_CT_capsule', 'alpha', 3, 0.10),
('def_laird_mk2_C_CT_capsule', 'beta', 3, 0.01),
--ASSAULT BOT: sequer
--A T1 CT
('def_sequer_mk2_A_CT_capsule', 'alpha', 1, 0.05),
('def_sequer_mk2_A_CT_capsule', 'beta', 1, 0.03),
--B T2
('def_sequer_mk2_B_CT_capsule', 'alpha', 2, 0.05),
('def_sequer_mk2_B_CT_capsule', 'beta', 2, 0.03),
--C T3
('def_sequer_mk2_C_CT_capsule', 'alpha', 3, 0.05),
('def_sequer_mk2_C_CT_capsule', 'beta', 3, 0.03),
--MECH BOT: termis
--A T1 CT
('def_termis_mk2_A_CT_capsule', 'alpha', 1, 0.03),
('def_termis_mk2_A_CT_capsule', 'beta', 1, 0.05),
('def_termis_mk2_A_CT_capsule', 'gamma', 1, 0.03),
--B T2
('def_termis_mk2_B_CT_capsule', 'alpha', 2, 0.03),
('def_termis_mk2_B_CT_capsule', 'beta', 2, 0.05),
('def_termis_mk2_B_CT_capsule', 'gamma', 2, 0.03),
--C T3
('def_termis_mk2_C_CT_capsule', 'alpha', 3, 0.03),
('def_termis_mk2_C_CT_capsule', 'beta', 3, 0.05),
('def_termis_mk2_C_CT_capsule', 'gamma', 3, 0.03),
--MECH BOT: gargoyle
--A T1 CT
('def_gargoyle_mk2_A_CT_capsule', 'alpha', 1, 0.03),
('def_gargoyle_mk2_A_CT_capsule', 'beta', 1, 0.05),
('def_gargoyle_mk2_A_CT_capsule', 'gamma', 1, 0.03),
--B T2
('def_gargoyle_mk2_B_CT_capsule', 'alpha', 2, 0.03),
('def_gargoyle_mk2_B_CT_capsule', 'beta', 2, 0.05),
('def_gargoyle_mk2_B_CT_capsule', 'gamma', 2, 0.03),
--C T3
('def_gargoyle_mk2_C_CT_capsule', 'alpha', 3, 0.03),
('def_gargoyle_mk2_C_CT_capsule', 'beta', 3, 0.05),
('def_gargoyle_mk2_C_CT_capsule', 'gamma', 3, 0.03),
--HEAVYMECH BOT: riveler
--A T1 CT
('def_riveler_mk2_A_CT_capsule', 'alpha', 1, 0.01),
('def_riveler_mk2_A_CT_capsule', 'beta', 1, 0.08),
('def_riveler_mk2_A_CT_capsule', 'gamma', 1, 0.10),
--B T2
('def_riveler_mk2_B_CT_capsule', 'alpha', 2, 0.01),
('def_riveler_mk2_B_CT_capsule', 'beta', 2, 0.08),
('def_riveler_mk2_B_CT_capsule', 'gamma', 2, 0.10),
--C T3
('def_riveler_mk2_C_CT_capsule', 'alpha', 3, 0.01),
('def_riveler_mk2_C_CT_capsule', 'beta', 3, 0.08),
('def_riveler_mk2_C_CT_capsule', 'gamma', 3, 0.10),
--HEAVYMECH BOT: symbiont
--A T1 CT
('def_symbiont_mk2_A_CT_capsule', 'alpha', 1, 0.01),
('def_symbiont_mk2_A_CT_capsule', 'beta', 1, 0.08),
('def_symbiont_mk2_A_CT_capsule', 'gamma', 1, 0.10),
--B T2
('def_symbiont_mk2_B_CT_capsule', 'alpha', 2, 0.01),
('def_symbiont_mk2_B_CT_capsule', 'beta', 2, 0.08),
('def_symbiont_mk2_B_CT_capsule', 'gamma', 2, 0.10),
--C T3
('def_symbiont_mk2_C_CT_capsule', 'alpha', 3, 0.01),
('def_symbiont_mk2_C_CT_capsule', 'beta', 3, 0.08),
('def_symbiont_mk2_C_CT_capsule', 'gamma', 3, 0.10),
--HEAVYMECH BOT: lithus
--A T1 CT
('def_lithus_mk2_A_CT_capsule', 'alpha', 1, 0.01),
('def_lithus_mk2_A_CT_capsule', 'beta', 1, 0.08),
('def_lithus_mk2_A_CT_capsule', 'gamma', 1, 0.10),
--B T2
('def_lithus_mk2_B_CT_capsule', 'alpha', 2, 0.01),
('def_lithus_mk2_B_CT_capsule', 'beta', 2, 0.08),
('def_lithus_mk2_B_CT_capsule', 'gamma', 2, 0.10),
--C T3
('def_lithus_mk2_C_CT_capsule', 'alpha', 3, 0.01),
('def_lithus_mk2_C_CT_capsule', 'beta', 3, 0.08),
('def_lithus_mk2_C_CT_capsule', 'gamma', 3, 0.10),
--
--HEAVYGLIDER BOT: scarab
--A T1 CT
('def_scarab_mk2_A_CT_capsule', 'beta', 1, 0.01),
('def_scarab_mk2_A_CT_capsule', 'gamma', 1, 0.05),
--B T2
('def_scarab_mk2_B_CT_capsule', 'beta', 2, 0.01),
('def_scarab_mk2_B_CT_capsule', 'gamma', 2, 0.05),
--C T3
('def_scarab_mk2_C_CT_capsule', 'beta', 3, 0.01),
('def_scarab_mk2_C_CT_capsule', 'gamma', 3, 0.05);
--


INSERT INTO #PELI_CTS_BY_NAME (defName, islandType, level, chance) VALUES
--LIGHT BOT: CASTEL
--A T1 CT
('def_castel_mk2_A_CT_capsule', 'alpha', 1, 0.10),
('def_castel_mk2_A_CT_capsule', 'beta', 1, 0.03),
--B T2
('def_castel_mk2_B_CT_capsule', 'alpha', 2, 0.10),
('def_castel_mk2_B_CT_capsule', 'beta', 2, 0.03),
--C T3
('def_castel_mk2_C_CT_capsule', 'alpha', 3, 0.10),
('def_castel_mk2_C_CT_capsule', 'beta', 3, 0.03),
--LIGHT ewar BOT: TROIAR
--A T1 CT
('def_troiar_mk2_A_CT_capsule', 'alpha', 1, 0.05),
('def_troiar_mk2_A_CT_capsule', 'beta', 1, 0.05),
--B T2
('def_troiar_mk2_B_CT_capsule', 'alpha', 2, 0.05),
('def_troiar_mk2_B_CT_capsule', 'beta', 2, 0.05),
--C T3
('def_troiar_mk2_C_CT_capsule', 'alpha', 3, 0.05),
('def_troiar_mk2_C_CT_capsule', 'beta', 3, 0.05),
--ASSAULT BOT: WASPISH
--A T1 CT
('def_waspish_mk2_A_CT_capsule', 'alpha', 1, 0.05),
('def_waspish_mk2_A_CT_capsule', 'beta', 1, 0.05),
('def_waspish_mk2_A_CT_capsule', 'gamma', 1, 0.01),
--B T2
('def_waspish_mk2_B_CT_capsule', 'alpha', 2, 0.05),
('def_waspish_mk2_B_CT_capsule', 'beta', 2, 0.05),
('def_waspish_mk2_B_CT_capsule', 'gamma', 2, 0.01),
--C T3
('def_waspish_mk2_C_CT_capsule', 'alpha', 3, 0.05),
('def_waspish_mk2_C_CT_capsule', 'beta', 3, 0.05),
('def_waspish_mk2_C_CT_capsule', 'gamma', 3, 0.01),
--MECH BOT: TYRANNOS
--A T1 CT
('def_tyrannos_mk2_A_CT_capsule', 'alpha', 1, 0.01),
('def_tyrannos_mk2_A_CT_capsule', 'beta', 1, 0.08),
('def_tyrannos_mk2_A_CT_capsule', 'gamma', 1, 0.05),
--B T2
('def_tyrannos_mk2_B_CT_capsule', 'alpha', 2, 0.01),
('def_tyrannos_mk2_B_CT_capsule', 'beta', 2, 0.08),
('def_tyrannos_mk2_B_CT_capsule', 'gamma', 2, 0.05),
--C T3
('def_tyrannos_mk2_C_CT_capsule', 'alpha', 3, 0.01),
('def_tyrannos_mk2_C_CT_capsule', 'beta', 3, 0.08),
('def_tyrannos_mk2_C_CT_capsule', 'gamma', 3, 0.05),
--MECH BOT: ICTUS
--A T1 CT
('def_ictus_mk2_A_CT_capsule', 'beta', 1, 0.10),
('def_ictus_mk2_A_CT_capsule', 'gamma', 1, 0.08),
--B T2
('def_ictus_mk2_B_CT_capsule', 'beta', 2, 0.10),
('def_ictus_mk2_B_CT_capsule', 'gamma', 2, 0.08),
--C T3
('def_ictus_mk2_C_CT_capsule', 'beta', 3, 0.10),
('def_ictus_mk2_C_CT_capsule', 'gamma', 3, 0.08),
--HEAVYMECH BOT: GROPHO
--A T1 CT
('def_gropho_mk2_A_CT_capsule', 'beta', 1, 0.08),
('def_gropho_mk2_A_CT_capsule', 'gamma', 1, 0.10),
--B T2
('def_gropho_mk2_B_CT_capsule', 'beta', 2, 0.08),
('def_gropho_mk2_B_CT_capsule', 'gamma', 2, 0.10),
--C T3
('def_gropho_mk2_C_CT_capsule', 'beta', 3, 0.08),
('def_gropho_mk2_C_CT_capsule', 'gamma', 3, 0.10);
--

INSERT INTO #NUIMQOL_CTS_BY_NAME (defName, islandType, level, chance) VALUES
--LIGHT BOT: YAGEL
--A T1 CT
('def_yagel_mk2_A_CT_capsule', 'alpha', 1, 0.10),
('def_yagel_mk2_A_CT_capsule', 'beta', 1, 0.03),
--B T2
('def_yagel_mk2_B_CT_capsule', 'alpha', 2, 0.10),
('def_yagel_mk2_B_CT_capsule', 'beta', 2, 0.03),
--C T3
('def_yagel_mk2_C_CT_capsule', 'alpha', 3, 0.10),
('def_yagel_mk2_C_CT_capsule', 'beta', 3, 0.03),
--LIGHT ewar BOT: CAMELEON
--A T1 CT
('def_cameleon_mk2_A_CT_capsule', 'alpha', 1, 0.05),
('def_cameleon_mk2_A_CT_capsule', 'beta', 1, 0.05),
--B T2
('def_cameleon_mk2_B_CT_capsule', 'alpha', 2, 0.05),
('def_cameleon_mk2_B_CT_capsule', 'beta', 2, 0.05),
--C T3
('def_cameleon_mk2_C_CT_capsule', 'alpha', 3, 0.05),
('def_cameleon_mk2_C_CT_capsule', 'beta', 3, 0.05),
--ASSAULT BOT: ARABLEST
--A T1 CT
('def_arbalest_mk2_A_CT_capsule', 'alpha', 1, 0.05),
('def_arbalest_mk2_A_CT_capsule', 'beta', 1, 0.05),
('def_arbalest_mk2_A_CT_capsule', 'gamma', 1, 0.01),
--B T2
('def_arbalest_mk2_B_CT_capsule', 'alpha', 2, 0.05),
('def_arbalest_mk2_B_CT_capsule', 'beta', 2, 0.05),
('def_arbalest_mk2_B_CT_capsule', 'gamma', 2, 0.01),
--C T3
('def_arbalest_mk2_C_CT_capsule', 'alpha', 3, 0.05),
('def_arbalest_mk2_C_CT_capsule', 'beta', 3, 0.05),
('def_arbalest_mk2_C_CT_capsule', 'gamma', 3, 0.01),
--MECH BOT: TYRANNOS
--A T1 CT
('def_kain_mk2_A_CT_capsule', 'alpha', 1, 0.01),
('def_kain_mk2_A_CT_capsule', 'beta', 1, 0.08),
('def_kain_mk2_A_CT_capsule', 'gamma', 1, 0.05),
--B T2
('def_kain_mk2_B_CT_capsule', 'alpha', 2, 0.01),
('def_kain_mk2_B_CT_capsule', 'beta', 2, 0.08),
('def_kain_mk2_B_CT_capsule', 'gamma', 2, 0.05),
--C T3
('def_kain_mk2_C_CT_capsule', 'alpha', 3, 0.01),
('def_kain_mk2_C_CT_capsule', 'beta', 3, 0.08),
('def_kain_mk2_C_CT_capsule', 'gamma', 3, 0.05),
--MECH BOT: ICTUS
--A T1 CT
('def_vagabond_mk2_A_CT_capsule', 'beta', 1, 0.10),
('def_vagabond_mk2_A_CT_capsule', 'gamma', 1, 0.08),
--B T2
('def_vagabond_mk2_B_CT_capsule', 'beta', 2, 0.10),
('def_vagabond_mk2_B_CT_capsule', 'gamma', 2, 0.08),
--C T3
('def_vagabond_mk2_C_CT_capsule', 'beta', 3, 0.10),
('def_vagabond_mk2_C_CT_capsule', 'gamma', 3, 0.08),
--HEAVYMECH BOT: GROPHO
--A T1 CT
('def_mesmer_mk2_A_CT_capsule', 'beta', 1, 0.08),
('def_mesmer_mk2_A_CT_capsule', 'gamma', 1, 0.10),
--B T2
('def_mesmer_mk2_B_CT_capsule', 'beta', 2, 0.08),
('def_mesmer_mk2_B_CT_capsule', 'gamma', 2, 0.10),
--C T3
('def_mesmer_mk2_C_CT_capsule', 'beta', 3, 0.08),
('def_mesmer_mk2_C_CT_capsule', 'gamma', 3, 0.10);
--

INSERT INTO #THELO_CTS_BY_NAME (defName, islandType, level, chance) VALUES
--LIGHT BOT: PROMETHEUS
--A T1 CT
('def_prometheus_mk2_A_CT_capsule', 'alpha', 1, 0.10),
('def_prometheus_mk2_A_CT_capsule', 'beta', 1, 0.03),
--B T2
('def_prometheus_mk2_B_CT_capsule', 'alpha', 2, 0.10),
('def_prometheus_mk2_B_CT_capsule', 'beta', 2, 0.03),
--C T3
('def_prometheus_mk2_C_CT_capsule', 'alpha', 3, 0.10),
('def_prometheus_mk2_C_CT_capsule', 'beta', 3, 0.03),
--LIGHT ewar BOT: INTAKT
--A T1 CT
('def_intakt_mk2_A_CT_capsule', 'alpha', 1, 0.05),
('def_intakt_mk2_A_CT_capsule', 'beta', 1, 0.05),
--B T2
('def_intakt_mk2_B_CT_capsule', 'alpha', 2, 0.05),
('def_intakt_mk2_B_CT_capsule', 'beta', 2, 0.05),
--C T3
('def_intakt_mk2_C_CT_capsule', 'alpha', 3, 0.05),
('def_intakt_mk2_C_CT_capsule', 'beta', 3, 0.05),
--ASSAULT BOT: BAPHOMET
--A T1 CT
('def_baphomet_mk2_A_CT_capsule', 'alpha', 1, 0.05),
('def_baphomet_mk2_A_CT_capsule', 'beta', 1, 0.05),
('def_baphomet_mk2_A_CT_capsule', 'gamma', 1, 0.01),
--B T2
('def_baphomet_mk2_B_CT_capsule', 'alpha', 2, 0.05),
('def_baphomet_mk2_B_CT_capsule', 'beta', 2, 0.05),
('def_baphomet_mk2_B_CT_capsule', 'gamma', 2, 0.01),
--C T3
('def_baphomet_mk2_C_CT_capsule', 'alpha', 3, 0.05),
('def_baphomet_mk2_C_CT_capsule', 'beta', 3, 0.05),
('def_baphomet_mk2_C_CT_capsule', 'gamma', 3, 0.01),
--MECH BOT: ARTEMIS
--A T1 CT
('def_artemis_mk2_A_CT_capsule', 'alpha', 1, 0.01),
('def_artemis_mk2_A_CT_capsule', 'beta', 1, 0.08),
('def_artemis_mk2_A_CT_capsule', 'gamma', 1, 0.05),
--B T2
('def_artemis_mk2_B_CT_capsule', 'alpha', 2, 0.01),
('def_artemis_mk2_B_CT_capsule', 'beta', 2, 0.08),
('def_artemis_mk2_B_CT_capsule', 'gamma', 2, 0.05),
--C T3
('def_artemis_mk2_C_CT_capsule', 'alpha', 3, 0.01),
('def_artemis_mk2_C_CT_capsule', 'beta', 3, 0.08),
('def_artemis_mk2_C_CT_capsule', 'gamma', 3, 0.05),
--MECH BOT: ZENITH
--A T1 CT
('def_zenith_mk2_A_CT_capsule', 'beta', 1, 0.10),
('def_zenith_mk2_A_CT_capsule', 'gamma', 1, 0.08),
--B T2
('def_zenith_mk2_B_CT_capsule', 'beta', 2, 0.10),
('def_zenith_mk2_B_CT_capsule', 'gamma', 2, 0.08),
--C T3
('def_zenith_mk2_C_CT_capsule', 'beta', 3, 0.10),
('def_zenith_mk2_C_CT_capsule', 'gamma', 3, 0.08),
--HEAVYMECH BOT: SETH
--A T1 CT
('def_seth_mk2_A_CT_capsule', 'beta', 1, 0.08),
('def_seth_mk2_A_CT_capsule', 'gamma', 1, 0.10),
--B T2
('def_seth_mk2_B_CT_capsule', 'beta', 2, 0.08),
('def_seth_mk2_B_CT_capsule', 'gamma', 2, 0.10),
--C T3
('def_seth_mk2_C_CT_capsule', 'beta', 3, 0.08),
('def_seth_mk2_C_CT_capsule', 'gamma', 3, 0.10);
--

SELECT * FROM #INDY_CTS_BY_NAME;
SELECT * FROM #NUIMQOL_CTS_BY_NAME;
SELECT * FROM #PELI_CTS_BY_NAME;
SELECT * FROM #THELO_CTS_BY_NAME;

PRINT N'INSERT TABLES WITH DEFINITION ID LOOKUP';
INSERT INTO #INDY_CTS (def, islandType, level, chance)
SELECT (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=#INDY_CTS_BY_NAME.defName) as def, islandType, level, chance FROM #INDY_CTS_BY_NAME;

INSERT INTO #NUIM_CTS (def, islandType, level, chance)
SELECT (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=#NUIMQOL_CTS_BY_NAME.defName) as def, islandType, level, chance FROM #NUIMQOL_CTS_BY_NAME;

INSERT INTO #PELI_CTS (def, islandType, level, chance)
SELECT (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=#PELI_CTS_BY_NAME.defName) as def, islandType, level, chance FROM #PELI_CTS_BY_NAME;

INSERT INTO #THELO_CTS (def, islandType, level, chance)
SELECT (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=#THELO_CTS_BY_NAME.defName) as def, islandType, level, chance FROM #THELO_CTS_BY_NAME;


DECLARE @cf_modules bigint;
SET @cf_modules = (SELECT value FROM categoryFlags WHERE name='cf_lottery_items');

--Old Loot
PRINT N'SELECTING ALL CT CAPSULE LOOT'
SELECT * FROM artifactloot JOIN artifacttypes ON artifacttype=artifacttypes.id 
WHERE definition IN (
SELECT definition FROM entitydefaults WHERE definitionname LIKE '%_CT_capsule' AND note='MK2 CT Capsule!' AND
categoryflags & CAST(dbo.GetCFMask(@cf_modules) as BIGINT) = @cf_modules
);

--DELETE ALL CT-CAPSULES FROM ARTIFACT LOOT (AND RE-INSERT)
PRINT N'DELETING ALL CT CAPSULE LOOT'
DELETE FROM artifactloot WHERE definition IN (
SELECT definition FROM entitydefaults WHERE definitionname LIKE '%_CT_capsule' AND note='MK2 CT Capsule!' AND
categoryflags & CAST(dbo.GetCFMask(@cf_modules) as BIGINT) = @cf_modules
);


--INSERT PELISTAL CTS TO PELISTAL SCIENCE ARTIFACTS
PRINT N'PELISTAL SCIENTIFIC ARTIFACTS';
PRINT N'science_pelistal_level1_alpha';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_pelistal_level1_alpha'), def, 1, 1, chance, 1 
	FROM #PELI_CTS WHERE level=1 AND islandType='alpha';

PRINT N'science_pelistal_level2_alpha';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_pelistal_level2_alpha'), def, 1, 1, chance, 1 
	FROM #PELI_CTS WHERE level=2 AND islandType='alpha';

PRINT N'science_pelistal_level3_alpha';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_pelistal_level3_alpha'), def, 1, 1, chance, 1 
	FROM #PELI_CTS WHERE level=3 AND islandType='alpha';

PRINT N'science_pelistal_level1_beta';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_pelistal_level1_beta'), def, 1, 1, chance, 1 
	FROM #PELI_CTS WHERE level=1 AND islandType='beta';

PRINT N'science_pelistal_level2_beta';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_pelistal_level2_beta'), def, 1, 1, chance, 1 
	FROM #PELI_CTS WHERE level=2 AND islandType='beta';

PRINT N'science_pelistal_level3_beta';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_pelistal_level3_beta'), def, 1, 1, chance, 1 
	FROM #PELI_CTS WHERE level=3 AND islandType='beta';

PRINT N'science_pelistal_level1_gamma';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_pelistal_level1_gamma'), def, 1, 1, chance, 1 
	FROM #PELI_CTS WHERE level=1 AND islandType='gamma';

PRINT N'science_pelistal_level2_gamma';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_pelistal_level2_gamma'), def, 1, 1, chance, 1 
	FROM #PELI_CTS WHERE level=2 AND islandType='gamma';

PRINT N'science_pelistal_level3_gamma';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_pelistal_level3_gamma'), def, 1, 1, chance, 1 
	FROM #PELI_CTS WHERE level=3 AND islandType='gamma';


--INSERT NUIMQOL CTS TO NUIMQOL SCIENCE ARTIFACTS
PRINT N'NUIMQOL SCIENTIFIC ARTIFACTS';
PRINT N'science_nuimqol_level1_alpha';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_nuimqol_level1_alpha'), def, 1, 1, chance, 1 
	FROM #NUIM_CTS WHERE level=1 AND islandType='alpha';

PRINT N'science_nuimqol_level2_alpha';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_nuimqol_level2_alpha'), def, 1, 1, chance, 1 
	FROM #NUIM_CTS WHERE level=2 AND islandType='alpha';

PRINT N'science_nuimqol_level3_alpha';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_nuimqol_level3_alpha'), def, 1, 1, chance, 1 
	FROM #NUIM_CTS WHERE level=3 AND islandType='alpha';

PRINT N'science_nuimqol_level1_beta';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_nuimqol_level1_beta'), def, 1, 1, chance, 1 
	FROM #NUIM_CTS WHERE level=1 AND islandType='beta';

PRINT N'science_nuimqol_level2_beta';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_nuimqol_level2_beta'), def, 1, 1, chance, 1 
	FROM #NUIM_CTS WHERE level=2 AND islandType='beta';

PRINT N'science_nuimqol_level3_beta';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_nuimqol_level3_beta'), def, 1, 1, chance, 1 
	FROM #NUIM_CTS WHERE level=3 AND islandType='beta';

PRINT N'science_nuimqol_level1_gamma';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_nuimqol_level1_gamma'), def, 1, 1, chance, 1 
	FROM #NUIM_CTS WHERE level=1 AND islandType='gamma';

PRINT N'science_nuimqol_level2_gamma';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_nuimqol_level2_gamma'), def, 1, 1, chance, 1 
	FROM #NUIM_CTS WHERE level=2 AND islandType='gamma';

PRINT N'science_nuimqol_level3_gamma';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_nuimqol_level3_gamma'), def, 1, 1, chance, 1 
	FROM #NUIM_CTS WHERE level=3 AND islandType='gamma';


--INSERT THELODICA CTS TO THELODICA SCIENCE ARTIFACTS
PRINT N'THELODICA SCIENTIFIC ARTIFACTS';
PRINT N'science_thelodica_level1_alpha';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_thelodica_level1_alpha'), def, 1, 1, chance, 1 
	FROM #THELO_CTS WHERE level=1 AND islandType='alpha';

PRINT N'science_thelodica_level2_alpha';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_thelodica_level2_alpha'), def, 1, 1, chance, 1 
	FROM #THELO_CTS WHERE level=2 AND islandType='alpha';

PRINT N'science_thelodica_level3_alpha';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_thelodica_level3_alpha'), def, 1, 1, chance, 1 
	FROM #THELO_CTS WHERE level=3 AND islandType='alpha';

PRINT N'science_thelodica_level1_beta';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_thelodica_level1_beta'), def, 1, 1, chance, 1 
	FROM #THELO_CTS WHERE level=1 AND islandType='beta';

PRINT N'science_thelodica_level2_beta';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_thelodica_level2_beta'), def, 1, 1, chance, 1 
	FROM #THELO_CTS WHERE level=2 AND islandType='beta';

PRINT N'science_thelodica_level3_beta';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_thelodica_level3_beta'), def, 1, 1, chance, 1 
	FROM #THELO_CTS WHERE level=3 AND islandType='beta';

PRINT N'science_thelodica_level1_gamma';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_thelodica_level1_gamma'), def, 1, 1, chance, 1 
	FROM #THELO_CTS WHERE level=1 AND islandType='gamma';

PRINT N'science_thelodica_level2_gamma';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_thelodica_level2_gamma'), def, 1, 1, chance, 1 
	FROM #THELO_CTS WHERE level=2 AND islandType='gamma';

PRINT N'science_thelodica_level3_gamma';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'science_thelodica_level3_gamma'), def, 1, 1, chance, 1 
	FROM #THELO_CTS WHERE level=3 AND islandType='gamma';


--INSERT INDUSTRIAL CTS TO NUIMQOL INDUSTRIAL ARTIFACTS
PRINT N'NUIMQOL INDUSTRIAL ARTIFACTS';
PRINT N'industrial_nuimqol_level1_alpha';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_nuimqol_level1_alpha'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=1 AND islandType='alpha';

PRINT N'industrial_nuimqol_level2_alpha';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_nuimqol_level2_alpha'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=2 AND islandType='alpha';

PRINT N'industrial_nuimqol_level3_alpha';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_nuimqol_level3_alpha'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=3 AND islandType='alpha';

PRINT N'industrial_nuimqol_level1_beta';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_nuimqol_level1_beta'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=1 AND islandType='beta';

PRINT N'industrial_nuimqol_level2_beta';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_nuimqol_level2_beta'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=2 AND islandType='beta';

PRINT N'industrial_nuimqol_level3_beta';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_nuimqol_level3_beta'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=3 AND islandType='beta';

PRINT N'industrial_nuimqol_level1_gamma';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_nuimqol_level1_gamma'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=1 AND islandType='gamma';

PRINT N'industrial_nuimqol_level2_gamma';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_nuimqol_level2_gamma'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=2 AND islandType='gamma';

PRINT N'industrial_nuimqol_level3_gamma';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_nuimqol_level3_gamma'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=3 AND islandType='gamma';


--INSERT INDUSTRIAL CTS TO PELISTAL INDUSTRIAL ARTIFACTS
PRINT N'PELISTAL INDUSTRIAL ARTIFACTS';
PRINT N'industrial_pelistal_level1_alpha';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_pelistal_level1_alpha'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=1 AND islandType='alpha';

PRINT N'industrial_pelistal_level2_alpha';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_pelistal_level2_alpha'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=2 AND islandType='alpha';

PRINT N'industrial_pelistal_level3_alpha';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_pelistal_level3_alpha'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=3 AND islandType='alpha';

PRINT N'industrial_pelistal_level1_beta';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_pelistal_level1_beta'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=1 AND islandType='beta';

PRINT N'industrial_pelistal_level2_beta';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_pelistal_level2_beta'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=2 AND islandType='beta';

PRINT N'industrial_pelistal_level3_beta';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_pelistal_level3_beta'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=3 AND islandType='beta';

PRINT N'industrial_pelistal_level1_gamma';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_pelistal_level1_gamma'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=1 AND islandType='gamma';

PRINT N'industrial_pelistal_level2_gamma';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_pelistal_level2_gamma'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=2 AND islandType='gamma';

PRINT N'industrial_pelistal_level3_gamma';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_pelistal_level3_gamma'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=3 AND islandType='gamma';


--INSERT INDUSTRIAL CTS TO THELODICA INDUSTRIAL ARTIFACTS
PRINT N'THELODICA INDUSTRIAL ARTIFACTS';
PRINT N'industrial_thelodica_level1_alpha';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_thelodica_level1_alpha'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=1 AND islandType='alpha';

PRINT N'industrial_thelodica_level2_alpha';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_thelodica_level2_alpha'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=2 AND islandType='alpha';

PRINT N'industrial_thelodica_level3_alpha';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_thelodica_level3_alpha'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=3 AND islandType='alpha';

PRINT N'industrial_thelodica_level1_beta';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_thelodica_level1_beta'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=1 AND islandType='beta';

PRINT N'industrial_thelodica_level2_beta';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_thelodica_level2_beta'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=2 AND islandType='beta';

PRINT N'industrial_thelodica_level3_beta';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_thelodica_level3_beta'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=3 AND islandType='beta';

PRINT N'industrial_thelodica_level1_gamma';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_thelodica_level1_gamma'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=1 AND islandType='gamma';

PRINT N'industrial_thelodica_level2_gamma';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_thelodica_level2_gamma'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=2 AND islandType='gamma';

PRINT N'industrial_thelodica_level3_gamma';
INSERT INTO artifactloot (artifacttype, definition, minquantity, maxquantity, chance, packed)
SELECT (SELECT TOP 1 id FROM artifacttypes WHERE name = 'industrial_thelodica_level3_gamma'), def, 1, 1, chance, 1 
	FROM #INDY_CTS WHERE level=3 AND islandType='gamma';

GO