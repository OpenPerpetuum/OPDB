USE [perpetuumsa]
GO

-------------------------------------------------------------------
--Artifact CT Loot rebalance
--Added Light Combat, Light E-War, Light & Assault Indy MK2 CT Capsules to Gamma Artifact Table 
--Small buffs to other MK2 CT Capsules droprate.
--Date modified: 2023/10/21
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
--LIGHT BOT: Argano
--A T1
('def_argano_mk2_A_CT_capsule', 'alpha', 1, 0.105),
('def_argano_mk2_A_CT_capsule', 'beta', 1, 0.05),
('def_argano_mk2_A_CT_capsule', 'gamma', 1, 0.03), 
--B T2
('def_argano_mk2_B_CT_capsule', 'alpha', 2, 0.105),
('def_argano_mk2_B_CT_capsule', 'beta', 2, 0.05),
('def_argano_mk2_B_CT_capsule', 'gamma', 2, 0.03),
--C T3
('def_argano_mk2_C_CT_capsule', 'alpha', 3, 0.105),
('def_argano_mk2_C_CT_capsule', 'beta', 3, 0.05),
('def_argano_mk2_C_CT_capsule', 'gamma', 3, 0.03),
--LIGHT BOT: Laird
--A T1
('def_laird_mk2_A_CT_capsule', 'alpha', 1, 0.105),
('def_laird_mk2_A_CT_capsule', 'beta', 1, 0.05),
('def_laird_mk2_A_CT_capsule', 'gamma', 1, 0.03),
--B T2
('def_laird_mk2_B_CT_capsule', 'alpha', 2, 0.105),
('def_laird_mk2_B_CT_capsule', 'beta', 2, 0.05),
('def_laird_mk2_B_CT_capsule', 'gamma', 2,0.03),
--C T3
('def_laird_mk2_C_CT_capsule', 'alpha', 3, 0.105),
('def_laird_mk2_C_CT_capsule', 'beta', 3, 0.05),
('def_laird_mk2_C_CT_capsule', 'gamma', 3, 0.03),
--ASSAULT BOT: Sequer
--A T1
('def_sequer_mk2_A_CT_capsule', 'alpha', 1, 0.0725),
('def_sequer_mk2_A_CT_capsule', 'beta', 1, 0.05),
('def_sequer_mk2_A_CT_capsule', 'gamma', 1, 0.0325),
--B T2
('def_sequer_mk2_B_CT_capsule', 'alpha', 2, 0.0725),
('def_sequer_mk2_B_CT_capsule', 'beta', 2, 0.05),
('def_sequer_mk2_B_CT_capsule', 'gamma', 2, 0.0325),
--C T3
('def_sequer_mk2_C_CT_capsule', 'alpha', 3, 0.0725),
('def_sequer_mk2_C_CT_capsule', 'beta', 3, 0.05),
('def_sequer_mk2_C_CT_capsule', 'gamma', 3, 0.0325),

--MECH BOT: Termis
--A T1
('def_termis_mk2_A_CT_capsule', 'alpha', 1, 0.0325),
('def_termis_mk2_A_CT_capsule', 'beta', 1, 0.05),
('def_termis_mk2_A_CT_capsule', 'gamma', 1, 0.0725),
--B T2
('def_termis_mk2_B_CT_capsule', 'alpha', 2, 0.03),
('def_termis_mk2_B_CT_capsule', 'beta', 2, 0.05),
('def_termis_mk2_B_CT_capsule', 'gamma', 2, 0.0725),
--C T3
('def_termis_mk2_C_CT_capsule', 'alpha', 3, 0.03),
('def_termis_mk2_C_CT_capsule', 'beta', 3, 0.05),
('def_termis_mk2_C_CT_capsule', 'gamma', 3, 0.0725),

--MECH BOT: Gargoyle
--A T1
('def_gargoyle_mk2_A_CT_capsule', 'alpha', 1, 0.0325),
('def_gargoyle_mk2_A_CT_capsule', 'beta', 1, 0.05),
('def_gargoyle_mk2_A_CT_capsule', 'gamma', 1, 0.0725),
--B T2
('def_gargoyle_mk2_B_CT_capsule', 'alpha', 2, 0.0325),
('def_gargoyle_mk2_B_CT_capsule', 'beta', 2, 0.05),
('def_gargoyle_mk2_B_CT_capsule', 'gamma', 2, 0.0725),
--C T3
('def_gargoyle_mk2_C_CT_capsule', 'alpha', 3, 0.0325),
('def_gargoyle_mk2_C_CT_capsule', 'beta', 3, 0.05),
('def_gargoyle_mk2_C_CT_capsule', 'gamma', 3, 0.0725),

--HEAVYMECH BOT: Riveler
--A T1
('def_riveler_mk2_A_CT_capsule', 'alpha', 1, 0.0105),
('def_riveler_mk2_A_CT_capsule', 'beta', 1, 0.08),
('def_riveler_mk2_A_CT_capsule', 'gamma', 1, 0.10),
--B T2
('def_riveler_mk2_B_CT_capsule', 'alpha', 2, 0.0105),
('def_riveler_mk2_B_CT_capsule', 'beta', 2, 0.08),
('def_riveler_mk2_B_CT_capsule', 'gamma', 2, 0.10),
--C T3
('def_riveler_mk2_C_CT_capsule', 'alpha', 3, 0.0105),
('def_riveler_mk2_C_CT_capsule', 'beta', 3, 0.08),
('def_riveler_mk2_C_CT_capsule', 'gamma', 3, 0.10),

--HEAVYMECH BOT: Symbiont
--A T1
('def_symbiont_mk2_A_CT_capsule', 'alpha', 1, 0.0105),
('def_symbiont_mk2_A_CT_capsule', 'beta', 1, 0.08),
('def_symbiont_mk2_A_CT_capsule', 'gamma', 1, 0.10),
--B T2
('def_symbiont_mk2_B_CT_capsule', 'alpha', 2, 0.0105),
('def_symbiont_mk2_B_CT_capsule', 'beta', 2, 0.08),
('def_symbiont_mk2_B_CT_capsule', 'gamma', 2, 0.10),
--C T3
('def_symbiont_mk2_C_CT_capsule', 'alpha', 3, 0.0105),
('def_symbiont_mk2_C_CT_capsule', 'beta', 3, 0.08),
('def_symbiont_mk2_C_CT_capsule', 'gamma', 3, 0.10),

--HEAVYMECH BOT: Lithus
--A T1
('def_lithus_mk2_A_CT_capsule', 'alpha', 1, 0.0105),
('def_lithus_mk2_A_CT_capsule', 'beta', 1, 0.08),
('def_lithus_mk2_A_CT_capsule', 'gamma', 1, 0.10),
--B T2
('def_lithus_mk2_B_CT_capsule', 'alpha', 2, 0.0105),
('def_lithus_mk2_B_CT_capsule', 'beta', 2, 0.08),
('def_lithus_mk2_B_CT_capsule', 'gamma', 2, 0.10),
--C T3
('def_lithus_mk2_C_CT_capsule', 'alpha', 3, 0.0125),
('def_lithus_mk2_C_CT_capsule', 'beta', 3, 0.08),
('def_lithus_mk2_C_CT_capsule', 'gamma', 3, 0.10),
--
--HEAVYGLIDER BOT: Scarab
--A T1
('def_scarab_mk2_A_CT_capsule', 'beta', 1, 0.0105),
('def_scarab_mk2_A_CT_capsule', 'gamma', 1, 0.05),
--B T2
('def_scarab_mk2_B_CT_capsule', 'beta', 2, 0.0105),
('def_scarab_mk2_B_CT_capsule', 'gamma', 2, 0.05),
--C T3
('def_scarab_mk2_C_CT_capsule', 'beta', 3, 0.0105),
('def_scarab_mk2_C_CT_capsule', 'gamma', 3, 0.05);
--


INSERT INTO #PELI_CTS_BY_NAME (defName, islandType, level, chance) VALUES
--LIGHT BOT: Castel
--A T1 
('def_castel_mk2_A_CT_capsule', 'alpha', 1, 0.105),
('def_castel_mk2_A_CT_capsule', 'beta', 1, 0.05),
('def_castel_mk2_A_CT_capsule', 'gamma', 1, 0.03),
--B T2
('def_castel_mk2_B_CT_capsule', 'alpha', 2, 0.105),
('def_castel_mk2_B_CT_capsule', 'beta', 2, 0.05),
('def_castel_mk2_B_CT_capsule', 'gamma', 2, 0.03),
--C T3
('def_castel_mk2_C_CT_capsule', 'alpha', 3, 0.105),
('def_castel_mk2_C_CT_capsule', 'beta', 3, 0.05),
('def_castel_mk2_C_CT_capsule', 'gamma', 3, 0.03),
--LIGHT EWAR BOT: Troiar
--A T1
('def_troiar_mk2_A_CT_capsule', 'alpha', 1, 0.0725),
('def_troiar_mk2_A_CT_capsule', 'beta', 1, 0.05),
('def_troiar_mk2_A_CT_capsule', 'gamma', 1, 0.05),
--B T2
('def_troiar_mk2_B_CT_capsule', 'alpha', 2, 0.0725),
('def_troiar_mk2_B_CT_capsule', 'beta', 2, 0.05),
('def_troiar_mk2_B_CT_capsule', 'gamma', 2, 0.05),
--C T3
('def_troiar_mk2_C_CT_capsule', 'alpha', 3, 0.0725),
('def_troiar_mk2_C_CT_capsule', 'beta', 3, 0.05),
('def_troiar_mk2_C_CT_capsule', 'gamma', 3, 0.05),
--ASSAULT BOT: Waspish
--A T1 CT
('def_waspish_mk2_A_CT_capsule', 'alpha', 1, 0.0725),
('def_waspish_mk2_A_CT_capsule', 'beta', 1, 0.05),
('def_waspish_mk2_A_CT_capsule', 'gamma', 1, 0.05),
--B T2
('def_waspish_mk2_B_CT_capsule', 'alpha', 2, 0.0725),
('def_waspish_mk2_B_CT_capsule', 'beta', 2, 0.05),
('def_waspish_mk2_B_CT_capsule', 'gamma', 2, 0.05),
--C T3
('def_waspish_mk2_C_CT_capsule', 'alpha', 3, 0.0725),
('def_waspish_mk2_C_CT_capsule', 'beta', 3, 0.05),
('def_waspish_mk2_C_CT_capsule', 'gamma', 3, 0.05),
--MECH BOT: Tyrannos
--A T1 CT
('def_tyrannos_mk2_A_CT_capsule', 'alpha', 1, 0.0105),
('def_tyrannos_mk2_A_CT_capsule', 'beta', 1, 0.08),
('def_tyrannos_mk2_A_CT_capsule', 'gamma', 1, 0.725),
--B T2
('def_tyrannos_mk2_B_CT_capsule', 'alpha', 2, 0.0105),
('def_tyrannos_mk2_B_CT_capsule', 'beta', 2, 0.08),
('def_tyrannos_mk2_B_CT_capsule', 'gamma', 2, 0.725),
--C T3
('def_tyrannos_mk2_C_CT_capsule', 'alpha', 3, 0.0105),
('def_tyrannos_mk2_C_CT_capsule', 'beta', 3, 0.08),
('def_tyrannos_mk2_C_CT_capsule', 'gamma', 3, 0.725),
--MECH EWAR BOT: Ictus
--A T1
('def_ictus_mk2_A_CT_capsule', 'beta', 1, 0.10),
('def_ictus_mk2_A_CT_capsule', 'gamma', 1, 0.725),
--B T2
('def_ictus_mk2_B_CT_capsule', 'beta', 2, 0.10),
('def_ictus_mk2_B_CT_capsule', 'gamma', 2, 0.725),
--C T3
('def_ictus_mk2_C_CT_capsule', 'beta', 3, 0.10),
('def_ictus_mk2_C_CT_capsule', 'gamma', 3, 0.725),
--HEAVYMECH BOT: Gropho
--A T1
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
--LIGHT BOT: Yagel
--A T1
('def_yagel_mk2_A_CT_capsule', 'alpha', 1, 0.105),
('def_yagel_mk2_A_CT_capsule', 'beta', 1, 0.05),
('def_yagel_mk2_A_CT_capsule', 'gamma', 1, 0.03),
--B T2
('def_yagel_mk2_B_CT_capsule', 'alpha', 2, 0.105),
('def_yagel_mk2_B_CT_capsule', 'beta', 2, 0.05),
('def_yagel_mk2_B_CT_capsule', 'gamma', 2, 0.03),
--C T3
('def_yagel_mk2_C_CT_capsule', 'alpha', 3, 0.105),
('def_yagel_mk2_C_CT_capsule', 'beta', 3, 0.05),
('def_yagel_mk2_C_CT_capsule', 'gamma', 3, 0.03),
--LIGHT EWAR BOT: Cameleon
--A T1
('def_cameleon_mk2_A_CT_capsule', 'alpha', 1, 0.0725),
('def_cameleon_mk2_A_CT_capsule', 'beta', 1, 0.05),
('def_cameleon_mk2_A_CT_capsule', 'gamma', 1, 0.05),
--B T2
('def_cameleon_mk2_B_CT_capsule', 'alpha', 2, 0.0725),
('def_cameleon_mk2_B_CT_capsule', 'beta', 2, 0.05),
('def_cameleon_mk2_B_CT_capsule', 'gamma', 2, 0.05),
--C T3
('def_cameleon_mk2_C_CT_capsule', 'alpha', 3, 0.0725),
('def_cameleon_mk2_C_CT_capsule', 'beta', 3, 0.05),
('def_cameleon_mk2_C_CT_capsule', 'gamma', 3, 0.05),
--ASSAULT BOT: Arbalest
--A T1
('def_arbalest_mk2_A_CT_capsule', 'alpha', 1, 0.0725),
('def_arbalest_mk2_A_CT_capsule', 'beta', 1, 0.05),
('def_arbalest_mk2_A_CT_capsule', 'gamma', 1, 0.05),
--B T2
('def_arbalest_mk2_B_CT_capsule', 'alpha', 2, 0.0725),
('def_arbalest_mk2_B_CT_capsule', 'beta', 2, 0.05),
('def_arbalest_mk2_B_CT_capsule', 'gamma', 2, 0.05),
--C T3
('def_arbalest_mk2_C_CT_capsule', 'alpha', 3, 0.0725),
('def_arbalest_mk2_C_CT_capsule', 'beta', 3, 0.05),
('def_arbalest_mk2_C_CT_capsule', 'gamma', 3, 0.05),
--MECH BOT: Kain
--A T1
('def_kain_mk2_A_CT_capsule', 'alpha', 1, 0.0105),
('def_kain_mk2_A_CT_capsule', 'beta', 1, 0.08),
('def_kain_mk2_A_CT_capsule', 'gamma', 1, 0.725),
--B T2
('def_kain_mk2_B_CT_capsule', 'alpha', 2, 0.0105),
('def_kain_mk2_B_CT_capsule', 'beta', 2, 0.08),
('def_kain_mk2_B_CT_capsule', 'gamma', 2, 0.725),
--C T3
('def_kain_mk2_C_CT_capsule', 'alpha', 3, 0.0105),
('def_kain_mk2_C_CT_capsule', 'beta', 3, 0.08),
('def_kain_mk2_C_CT_capsule', 'gamma', 3, 0.725),
--MECH EWAR : Vagabond
--A T1 CT
('def_vagabond_mk2_A_CT_capsule', 'beta', 1, 0.10),
('def_vagabond_mk2_A_CT_capsule', 'gamma', 1, 0.725),
--B T2
('def_vagabond_mk2_B_CT_capsule', 'beta', 2, 0.10),
('def_vagabond_mk2_B_CT_capsule', 'gamma', 2, 0.725),
--C T3
('def_vagabond_mk2_C_CT_capsule', 'beta', 3, 0.10),
('def_vagabond_mk2_C_CT_capsule', 'gamma', 3, 0.725),
--HEAVYMECH BOT: Mesmer
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
--LIGHT BOT: Prometheus
--A T1
('def_prometheus_mk2_A_CT_capsule', 'alpha', 1, 0.105),
('def_prometheus_mk2_A_CT_capsule', 'beta', 1, 0.05),
('def_prometheus_mk2_A_CT_capsule', 'gamma', 1, 0.03),
--B T2
('def_prometheus_mk2_B_CT_capsule', 'alpha', 2, 0.105),
('def_prometheus_mk2_B_CT_capsule', 'beta', 2, 0.05),
('def_prometheus_mk2_B_CT_capsule', 'gamma', 2, 0.03),
--C T3
('def_prometheus_mk2_C_CT_capsule', 'alpha', 3, 0.105),
('def_prometheus_mk2_C_CT_capsule', 'beta', 3, 0.05),
('def_prometheus_mk2_C_CT_capsule', 'gamma', 3, 0.03),
--LIGHT EWAR BOT: Intakt
--A T1
('def_intakt_mk2_A_CT_capsule', 'alpha', 1, 0.0725),
('def_intakt_mk2_A_CT_capsule', 'beta', 1, 0.05),
('def_intakt_mk2_A_CT_capsule', 'gamma', 1, 0.05),
--B T2
('def_intakt_mk2_B_CT_capsule', 'alpha', 2, 0.0725),
('def_intakt_mk2_B_CT_capsule', 'beta', 2, 0.05),
('def_intakt_mk2_B_CT_capsule', 'gamma', 2, 0.05),
--C T3
('def_intakt_mk2_C_CT_capsule', 'alpha', 3, 0.0725),
('def_intakt_mk2_C_CT_capsule', 'beta', 3, 0.05),
('def_intakt_mk2_C_CT_capsule', 'gamma', 3, 0.05),
--ASSAULT BOT: Baphomet
--A T1
('def_baphomet_mk2_A_CT_capsule', 'alpha', 1, 0.0725),
('def_baphomet_mk2_A_CT_capsule', 'beta', 1, 0.05),
('def_baphomet_mk2_A_CT_capsule', 'gamma', 1, 0.05),
--B T2
('def_baphomet_mk2_B_CT_capsule', 'alpha', 2, 0.0725),
('def_baphomet_mk2_B_CT_capsule', 'beta', 2, 0.05),
('def_baphomet_mk2_B_CT_capsule', 'gamma', 2, 0.05),
--C T3
('def_baphomet_mk2_C_CT_capsule', 'alpha', 3, 0.0725),
('def_baphomet_mk2_C_CT_capsule', 'beta', 3, 0.05),
('def_baphomet_mk2_C_CT_capsule', 'gamma', 3, 0.05),
--MECH BOT: Artemis
--A T1 CT
('def_artemis_mk2_A_CT_capsule', 'alpha', 1, 0.0105),
('def_artemis_mk2_A_CT_capsule', 'beta', 1, 0.08),
('def_artemis_mk2_A_CT_capsule', 'gamma', 1, 0.0725),
--B T2
('def_artemis_mk2_B_CT_capsule', 'alpha', 2, 0.0105),
('def_artemis_mk2_B_CT_capsule', 'beta', 2, 0.08),
('def_artemis_mk2_B_CT_capsule', 'gamma', 2, 0.0725),
--C T3
('def_artemis_mk2_C_CT_capsule', 'alpha', 3, 0.0105),
('def_artemis_mk2_C_CT_capsule', 'beta', 3, 0.08),
('def_artemis_mk2_C_CT_capsule', 'gamma', 3, 0.0725),
--MECH EWAR BOT: Zenith
--A T1
('def_zenith_mk2_A_CT_capsule', 'beta', 1, 0.10),
('def_zenith_mk2_A_CT_capsule', 'gamma', 1, 0.0725),
--B T2
('def_zenith_mk2_B_CT_capsule', 'beta', 2, 0.10),
('def_zenith_mk2_B_CT_capsule', 'gamma', 2, 0.0725),
--C T3
('def_zenith_mk2_C_CT_capsule', 'beta', 3, 0.10),
('def_zenith_mk2_C_CT_capsule', 'gamma', 3, 0.0725),
--HEAVYMECH BOT: Seth
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
