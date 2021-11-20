USE [perpetuumsa]
GO

--------------------------------------------
-- Gamma NPC EP part 2, the special defs
-- Date modified: 2021/11/04
--------------------------------------------

DROP TABLE IF EXISTS #EP_BY_DEFNAME;
CREATE TABLE #EP_BY_DEFNAME(
	defName varchar(128),
	ep int
);
INSERT INTO #EP_BY_DEFNAME (defName, ep) VALUES
('def_npc_gamma_sequer_basic_lindy',40),
('def_npc_gamma_lithus_basic_lindy',60),
('def_npc_gamma_scarab_basic_lindy',90),
('def_npc_gamma_ikarus_basic_lindy',25),
('def_npc_gamma_daidalos_basic_lindy',50),
('def_npc_gamma_cronus_basic_lindy',40),
('def_npc_gamma_riveler_basic_lindy',60),
('def_npc_gamma_symbiont_basic_lindy',60),
('def_npc_gamma_termis_basic_lindy',50),
('def_npc_gamma_gargoyle_basic_lindy',50),
('def_npc_gamma_argano_basic_lindy',25),
('def_npc_gamma_laird_basic_lindy',25),
('def_npc_gamma_hermes_basic_lindy',40),
('def_npc_gamma_seth_advanced_observer',120),
('def_npc_gamma_artemis_advanced_observer',90),
('def_npc_gamma_zenith_advanced_observer',90),
('def_npc_gamma_gropho_advanced_observer',120),
('def_npc_gamma_tyrannos_advanced_observer',90),
('def_npc_gamma_ictus_advanced_observer',90),
('def_npc_gamma_mesmer_advanced_observer',120),
('def_npc_gamma_kain_advanced_observer',90),
('def_npc_gamma_vagabond_advanced_observer',90),
('def_npc_gamma_legatus_advanced_observer',120),
('def_npc_gamma_echelon_advanced_observer',90),
('def_npc_gamma_callisto_advanced_observer',90),
('def_npc_gamma_seth_boss_miniboss',300),
('def_npc_gamma_gropho_boss_miniboss',300),
('def_npc_gamma_mesmer_boss_miniboss',300),
('def_npc_gamma_legatus_boss_miniboss',300),
('def_npc_gamma_onyx_mammoth_destro',150),
('def_npc_gamma_hydra_mammoth_destro',150),
('def_npc_gamma_felos_mammoth_destro',150),
('def_npc_gamma_onyx_thelodica_pitboss',3000),
('def_npc_gamma_hydra_pelistal_pitboss',3000),
('def_npc_gamma_felos_nuimqol_pitboss',3000),
('def_npc_gamma_apollo_syndicate_syn_pitboss',3000),
('def_npc_gamma_baphomet_advanced_courier',90),
('def_npc_gamma_prometheus_advanced_courier',60),
('def_npc_gamma_intakt_advanced_courier',60),
('def_npc_gamma_waspish_advanced_courier',90),
('def_npc_gamma_castel_advanced_courier',60),
('def_npc_gamma_troiar_advanced_courier',60),
('def_npc_gamma_arbalest_advanced_courier',90),
('def_npc_gamma_yagel_advanced_courier',60),
('def_npc_gamma_cameleon_advanced_courier',60),
('def_npc_gamma_locust_advanced_courier',90),
('def_npc_gamma_vektor_advanced_courier',60),
('def_npc_gamma_helix_advanced_courier',60),
('def_npc_gamma_hermes_advanced_courier',90),
('def_npc_gamma_sequer_advanced_courier',60),
('def_npc_gamma_ikarus_advanced_courier',30);


MERGE [dbo].[robottemplaterelation] r USING #EP_BY_DEFNAME e
ON r.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=e.defName)
WHEN MATCHED
    THEN UPDATE SET
		r.killep = e.ep;

PRINT N'UPDATED KILLEP ON GAMMA NPCS round 2:';
SELECT * FROM robottemplaterelation
WHERE definition IN (
	SELECT definition FROM entitydefaults WHERE definitionname IN (
		SELECT distinct defName FROM #EP_BY_DEFNAME
	)
);

DROP TABLE IF EXISTS #EP_BY_DEFNAME;
GO