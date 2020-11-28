USE [perpetuumsa]
GO

------------------------------------------
-- NPCReinforcements for existing bosses
--
-- Date modified: 2020/11/27
------------------------------------------

PRINT N'ADD/UPDATE npcreinforcements FOR NPC BOSSES';

DECLARE @reinforceType AS INT = (SELECT TOP 1 id FROM npcreinforcementtypes WHERE name='boss');

DROP TABLE IF EXISTS #WAVES;
CREATE TABLE #WAVES (
	targetFlockName VARCHAR(100),
	presenceName VARCHAR(100),
	npcDefName VARCHAR(100),
	numInFlock INT,
	behaviorType INT,
	thresh FLOAT
);

INSERT INTO #WAVES (targetFlockName, presenceName, npcDefName, numInFlock, behaviorType, thresh) VALUES
--Bonnie RR boss NV
('Rough_Rider_Leader', 'reinforce_rrboss_nv_wave_0', 'def_npc_RoughRider_Scout', 1, 1, 0.5),
('Rough_Rider_Leader', 'reinforce_rrboss_nv_wave_0', 'def_npc_vektor_swab_rank1', 1, 1, 0.5),
('Rough_Rider_Leader', 'reinforce_rrboss_nv_wave_1', 'def_npc_RoughRider_Scout', 2, 1, 0.75),
('Rough_Rider_Leader', 'reinforce_rrboss_nv_wave_1', 'def_npc_vektor_swab_rank2', 1, 1, 0.75),
--Factional NV Bosses
('def_npc_Imperial_Infantry', 'reinforce_tmboss_nv_wave_0', 'def_npc_castel_scout_rank1', 1, 1, 0.5),
('def_npc_Tribal_Member', 'reinforce_icsboss_nv_wave_0', 'def_npc_yagel_scout_rank1', 1, 1, 0.5),
('def_npc_Sacrist_Convert', 'reinforce_asiboss_nv_wave_0', 'def_npc_prometheus_scout_rank1', 1, 1, 0.5),
--Hersh Factional Bosses
('hersh_GreenBoss', 'reinforce_tmboss_hersh_wave_0', 'def_npc_castel_dps_rank3', 1, 1, 0.33),
('hersh_GreenBoss', 'reinforce_tmboss_hersh_wave_0', 'def_npc_troiar_ewjammer_rank3', 1, 1, 0.33),
('hersh_GreenBoss', 'reinforce_tmboss_hersh_wave_1', 'def_npc_castel_dps_rank3', 2, 1, 0.66),
('hersh_GreenBoss', 'reinforce_tmboss_hersh_wave_1', 'def_npc_waspish_dps_rank3', 1, 1, 0.66),
('hersh_GreenBoss', 'reinforce_tmboss_hersh_wave_1', 'def_npc_troiar_ewjammer_rank3', 2, 1, 0.66),

('Blue_Hersh_mech_boss', 'reinforce_icsboss_hersh_wave_0', 'def_npc_yagel_dps_rank3', 1, 1, 0.33),
('Blue_Hersh_mech_boss', 'reinforce_icsboss_hersh_wave_0', 'def_npc_cameleon_ewjammer_rank3', 1, 1, 0.33),
('Blue_Hersh_mech_boss', 'reinforce_icsboss_hersh_wave_1', 'def_npc_yagel_dps_rank3', 2, 1, 0.66),
('Blue_Hersh_mech_boss', 'reinforce_icsboss_hersh_wave_1', 'def_npc_arbalest_dps_rank3', 1, 1, 0.66),
('Blue_Hersh_mech_boss', 'reinforce_icsboss_hersh_wave_1', 'def_npc_cameleon_ewjammer_rank3', 2, 1, 0.66),

('hersh_yellow_boss', 'reinforce_asiboss_hersh_wave_0', 'def_npc_prometheus_dps_rank3', 1, 1, 0.33),
('hersh_yellow_boss', 'reinforce_asiboss_hersh_wave_0', 'def_npc_intakt_ewjammer_rank3', 1, 1, 0.33),
('hersh_yellow_boss', 'reinforce_asiboss_hersh_wave_1', 'def_npc_prometheus_dps_rank3', 2, 1, 0.66),
('hersh_yellow_boss', 'reinforce_asiboss_hersh_wave_1', 'def_npc_baphomet_dps_rank3', 1, 1, 0.66),
('hersh_yellow_boss', 'reinforce_asiboss_hersh_wave_1', 'def_npc_intakt_ewjammer_rank3', 2, 1, 0.66),
--One-eye RR boss Hersh
('Hersh_RR_1', 'reinforce_rrboss_hersh_wave_0', 'def_npc_RoughRider_Scout', 2, 1, 0.33),
('Hersh_RR_1', 'reinforce_rrboss_hersh_wave_0', 'def_npc_RoughRider_Cavalry', 1, 1, 0.33),

('Hersh_RR_1', 'reinforce_rrboss_hersh_wave_1', 'def_npc_RoughRider_Scout', 2, 1, 0.67),
('Hersh_RR_1', 'reinforce_rrboss_hersh_wave_1', 'def_npc_RoughRider_Cavalry', 2, 1, 0.67),
('Hersh_RR_1', 'reinforce_rrboss_hersh_wave_1', 'def_npc_callisto_buccaneer_rank2', 1, 1, 0.67),

--Hersh Pitboss
('Hersh_Pit_Boss', 'reinforce_pitboss_hersh_wave_0', 'def_npc_argano_basic_rank3', 1, 1, 0.1),
('Hersh_Pit_Boss', 'reinforce_pitboss_hersh_wave_0', 'def_npc_laird_basic_rank3', 1, 1, 0.1),
('Hersh_Pit_Boss', 'reinforce_pitboss_hersh_wave_0', 'def_npc_vektor_swab_rank3', 1, 1, 0.1),

('Hersh_Pit_Boss', 'reinforce_pitboss_hersh_wave_1', 'def_npc_argano_basic_rank3', 1, 1, 0.3),
('Hersh_Pit_Boss', 'reinforce_pitboss_hersh_wave_1', 'def_npc_laird_basic_rank3', 1, 1, 0.3),
('Hersh_Pit_Boss', 'reinforce_pitboss_hersh_wave_1', 'def_npc_sequer_basic_rank3', 1, 1, 0.3),
('Hersh_Pit_Boss', 'reinforce_pitboss_hersh_wave_1', 'def_npc_locust_firstmate_rank3', 1, 1, 0.3),
('Hersh_Pit_Boss', 'reinforce_pitboss_hersh_wave_1', 'def_npc_vektor_swab_rank3', 1, 1, 0.3),

('Hersh_Pit_Boss', 'reinforce_pitboss_hersh_wave_2', 'def_npc_sequer_basic_rank4', 2, 1, 0.6),
('Hersh_Pit_Boss', 'reinforce_pitboss_hersh_wave_2', 'def_npc_termis_basic_rank3', 1, 1, 0.6),
('Hersh_Pit_Boss', 'reinforce_pitboss_hersh_wave_2', 'def_npc_gargoyle_basic_rank3', 1, 1, 0.6),
('Hersh_Pit_Boss', 'reinforce_pitboss_hersh_wave_2', 'def_npc_locust_firstmate_rank3', 2, 1, 0.6),

('Hersh_Pit_Boss', 'reinforce_pitboss_hersh_wave_3', 'def_npc_sequer_basic_rank4', 2, 1, 0.9),
('Hersh_Pit_Boss', 'reinforce_pitboss_hersh_wave_3', 'def_npc_termis_basic_rank4', 2, 1, 0.9),
('Hersh_Pit_Boss', 'reinforce_pitboss_hersh_wave_3', 'def_npc_gargoyle_basic_rank4', 2, 1, 0.9),
('Hersh_Pit_Boss', 'reinforce_pitboss_hersh_wave_3', 'def_npc_locust_firstmate_rank4', 2, 1, 0.9),
('Hersh_Pit_Boss', 'reinforce_pitboss_hersh_wave_3', 'def_npc_callisto_buccaneer_rank2', 1, 1, 0.9),

--Dom Pitboss
('Domhalarn_Pitboss_flock_boss', 'reinforce_pitboss_dom_wave_0', 'def_npc_argano_basic_rank4', 1, 1, 0.1),
('Domhalarn_Pitboss_flock_boss', 'reinforce_pitboss_dom_wave_0', 'def_npc_laird_basic_rank4', 1, 1, 0.1),
('Domhalarn_Pitboss_flock_boss', 'reinforce_pitboss_dom_wave_0', 'def_npc_yagel_dps_rank4', 1, 1, 0.1),

('Domhalarn_Pitboss_flock_boss', 'reinforce_pitboss_dom_wave_1', 'def_npc_cameleon_ewjammer_rank4', 1, 1, 0.3),
('Domhalarn_Pitboss_flock_boss', 'reinforce_pitboss_dom_wave_1', 'def_npc_arbalest_interceptor_rank4', 1, 1, 0.3),
('Domhalarn_Pitboss_flock_boss', 'reinforce_pitboss_dom_wave_1', 'def_npc_yagel_dps_rank4', 1, 1, 0.3),

('Domhalarn_Pitboss_flock_boss', 'reinforce_pitboss_dom_wave_2', 'def_npc_cameleon_ewjammer_rank4', 2, 1, 0.6),
('Domhalarn_Pitboss_flock_boss', 'reinforce_pitboss_dom_wave_2', 'def_npc_arbalest_interceptor_rank4', 1, 1, 0.6),
('Domhalarn_Pitboss_flock_boss', 'reinforce_pitboss_dom_wave_2', 'def_npc_yagel_dps_rank4', 2, 1, 0.6),
('Domhalarn_Pitboss_flock_boss', 'reinforce_pitboss_dom_wave_2', 'def_npc_kain_ew_rank4', 1, 1, 0.6),

('Domhalarn_Pitboss_flock_boss', 'reinforce_pitboss_dom_wave_3', 'def_npc_cameleon_ewjammer_rank5', 2, 1, 0.9),
('Domhalarn_Pitboss_flock_boss', 'reinforce_pitboss_dom_wave_3', 'def_npc_arbalest_interceptor_rank5', 2, 1, 0.9),
('Domhalarn_Pitboss_flock_boss', 'reinforce_pitboss_dom_wave_3', 'def_npc_vagabond_jammer_rank4', 1, 1, 0.9),
('Domhalarn_Pitboss_flock_boss', 'reinforce_pitboss_dom_wave_3', 'def_npc_kain_dps_rank5', 2, 1, 0.9),

--Hokk Pitboss
('Hokkogaros_Pitboss_flock_boss', 'reinforce_pitboss_hokk_wave_0', 'def_npc_argano_basic_rank4', 1, 1, 0.1),
('Hokkogaros_Pitboss_flock_boss', 'reinforce_pitboss_hokk_wave_0', 'def_npc_laird_basic_rank4', 1, 1, 0.1),
('Hokkogaros_Pitboss_flock_boss', 'reinforce_pitboss_hokk_wave_0', 'def_npc_prometheus_dps_rank4', 1, 1, 0.1),

('Hokkogaros_Pitboss_flock_boss', 'reinforce_pitboss_hokk_wave_1', 'def_npc_intakt_ewjammer_rank4', 1, 1, 0.3),
('Hokkogaros_Pitboss_flock_boss', 'reinforce_pitboss_hokk_wave_1', 'def_npc_baphomet_interceptor_rank4', 1, 1, 0.3),
('Hokkogaros_Pitboss_flock_boss', 'reinforce_pitboss_hokk_wave_1', 'def_npc_prometheus_dps_rank4', 1, 1, 0.3),

('Hokkogaros_Pitboss_flock_boss', 'reinforce_pitboss_hokk_wave_2', 'def_npc_intakt_ewjammer_rank4', 2, 1, 0.6),
('Hokkogaros_Pitboss_flock_boss', 'reinforce_pitboss_hokk_wave_2', 'def_npc_baphomet_interceptor_rank4', 1, 1, 0.6),
('Hokkogaros_Pitboss_flock_boss', 'reinforce_pitboss_hokk_wave_2', 'def_npc_prometheus_dps_rank4', 2, 1, 0.6),
('Hokkogaros_Pitboss_flock_boss', 'reinforce_pitboss_hokk_wave_2', 'def_npc_artemis_ew_rank4', 1, 1, 0.6),

('Hokkogaros_Pitboss_flock_boss', 'reinforce_pitboss_hokk_wave_3', 'def_npc_intakt_ewjammer_rank5', 2, 1, 0.9),
('Hokkogaros_Pitboss_flock_boss', 'reinforce_pitboss_hokk_wave_3', 'def_npc_baphomet_interceptor_rank5', 2, 1, 0.9),
('Hokkogaros_Pitboss_flock_boss', 'reinforce_pitboss_hokk_wave_3', 'def_npc_zenith_jammer_rank4', 1, 1, 0.9),
('Hokkogaros_Pitboss_flock_boss', 'reinforce_pitboss_hokk_wave_3', 'def_npc_artemis_dps_rank5', 2, 1, 0.9),

--Nor Pitboss
('Norhoop_Pitboss_flock_boss', 'reinforce_pitboss_hoop_wave_0', 'def_npc_argano_basic_rank4', 1, 1, 0.1),
('Norhoop_Pitboss_flock_boss', 'reinforce_pitboss_hoop_wave_0', 'def_npc_laird_basic_rank4', 1, 1, 0.1),
('Norhoop_Pitboss_flock_boss', 'reinforce_pitboss_hoop_wave_0', 'def_npc_castel_dps_rank4', 1, 1, 0.1),

('Norhoop_Pitboss_flock_boss', 'reinforce_pitboss_hoop_wave_1', 'def_npc_troiar_ewjammer_rank4', 1, 1, 0.3),
('Norhoop_Pitboss_flock_boss', 'reinforce_pitboss_hoop_wave_1', 'def_npc_waspish_interceptor_rank4', 1, 1, 0.3),
('Norhoop_Pitboss_flock_boss', 'reinforce_pitboss_hoop_wave_1', 'def_npc_castel_dps_rank4', 1, 1, 0.3),

('Norhoop_Pitboss_flock_boss', 'reinforce_pitboss_hoop_wave_2', 'def_npc_troiar_ewjammer_rank4', 2, 1, 0.6),
('Norhoop_Pitboss_flock_boss', 'reinforce_pitboss_hoop_wave_2', 'def_npc_waspish_interceptor_rank4', 1, 1, 0.6),
('Norhoop_Pitboss_flock_boss', 'reinforce_pitboss_hoop_wave_2', 'def_npc_castel_dps_rank4', 2, 1, 0.6),
('Norhoop_Pitboss_flock_boss', 'reinforce_pitboss_hoop_wave_2', 'def_npc_tyrannos_ew_rank4', 1, 1, 0.6),

('Norhoop_Pitboss_flock_boss', 'reinforce_pitboss_hoop_wave_3', 'def_npc_troiar_ewjammer_rank5', 2, 1, 0.9),
('Norhoop_Pitboss_flock_boss', 'reinforce_pitboss_hoop_wave_3', 'def_npc_waspish_interceptor_rank4', 2, 1, 0.9),
('Norhoop_Pitboss_flock_boss', 'reinforce_pitboss_hoop_wave_3', 'def_npc_ictus_jammer_rank4', 1, 1, 0.9),
('Norhoop_Pitboss_flock_boss', 'reinforce_pitboss_hoop_wave_3', 'def_npc_tyrannos_dps_rank5', 2, 1, 0.9),

--Blue SAP guards
('def_npc_sap_invade_koy_SAP_FLOCK', 'reinforce_invade_koy_wave_0', 'def_npc_cameleon_heavyew_rank5', 1, 1, 0.55),
('def_npc_sap_invade_hey_SAP_FLOCK', 'reinforce_invade_hey_wave_0', 'def_npc_cameleon_heavyew_rank5', 1, 1, 0.55),
('def_npc_sap_invade_moy_SAP_FLOCK', 'reinforce_invade_moy_wave_0', 'def_npc_cameleon_heavyew_rank5', 1, 1, 0.55),

('def_npc_sap_guard_koy_SAP_FLOCK', 'reinforce_guard_koy_wave_0', 'def_npc_cameleon_heavyew_rank5', 1, 1, 0.55),
('def_npc_sap_guard_hey_SAP_FLOCK', 'reinforce_guard_hey_wave_0', 'def_npc_cameleon_heavyew_rank5', 1, 1, 0.55),
('def_npc_sap_guard_moy_SAP_FLOCK', 'reinforce_guard_moy_wave_0', 'def_npc_cameleon_heavyew_rank5', 1, 1, 0.55),
--beta2
('def_npc_sap_invade_dana_SAP_FLOCK', 'reinforce_invade_dana_wave_0', 'def_npc_cameleon_heavyew_rank5', 1, 1, 0.55),
('def_npc_sap_invade_newcrim_SAP_FLOCK', 'reinforce_invade_newcrim_wave_0', 'def_npc_cameleon_heavyew_rank5', 1, 1, 0.55),
('def_npc_sap_guard_dana_SAP_FLOCK', 'reinforce_guard_dana_wave_0', 'def_npc_cameleon_heavyew_rank5', 1, 1, 0.55),
('def_npc_sap_guard_newcrim_SAP_FLOCK', 'reinforce_guard_newcrim_wave_0', 'def_npc_cameleon_heavyew_rank5', 1, 1, 0.55),

--Yellow SAP guards
('def_npc_sap_invade_nauwy_SAP_FLOCK', 'reinforce_invade_nauwy_wave_0', 'def_npc_intakt_heavyew_rank5', 1, 1, 0.55),
('def_npc_sap_invade_abbu_SAP_FLOCK', 'reinforce_invade_abbu_wave_0', 'def_npc_intakt_heavyew_rank5', 1, 1, 0.55),
('def_npc_sap_invade_darm_SAP_FLOCK', 'reinforce_invade_darm_wave_0', 'def_npc_intakt_heavyew_rank5', 1, 1, 0.55),

('def_npc_sap_guard_nauwy_SAP_FLOCK', 'reinforce_guard_nauwy_wave_0', 'def_npc_intakt_heavyew_rank5', 1, 1, 0.55),
('def_npc_sap_guard_abbu_SAP_FLOCK', 'reinforce_guard_abbu_wave_0', 'def_npc_intakt_heavyew_rank5', 1, 1, 0.55),
('def_npc_sap_guard_darm_SAP_FLOCK', 'reinforce_guard_darm_wave_0', 'def_npc_intakt_heavyew_rank5', 1, 1, 0.55),
--beta2
('def_npc_sap_invade_lao_SAP_FLOCK', 'reinforce_invade_lao_wave_0', 'def_npc_intakt_heavyew_rank5', 1, 1, 0.55),
('def_npc_sap_invade_southi_SAP_FLOCK', 'reinforce_invade_southi_wave_0', 'def_npc_intakt_heavyew_rank5', 1, 1, 0.55),
('def_npc_sap_guard_lao_SAP_FLOCK', 'reinforce_guard_lao_wave_0', 'def_npc_intakt_heavyew_rank5', 1, 1, 0.55),
('def_npc_sap_guard_southi_SAP_FLOCK', 'reinforce_guard_southi_wave_0', 'def_npc_intakt_heavyew_rank5', 1, 1, 0.55),

--Green SAP guards
('def_npc_sap_invade_initia_SAP_FLOCK', 'reinforce_invade_initia_wave_0', 'def_npc_troiar_ewjammer_rank5', 1, 1, 0.55),
('def_npc_sap_invade_kara_SAP_FLOCK', 'reinforce_invade_kara_wave_0', 'def_npc_troiar_ewjammer_rank5', 1, 1, 0.55),
('def_npc_sap_invade_uria_SAP_FLOCK', 'reinforce_invade_uria_wave_0', 'def_npc_troiar_ewjammer_rank5', 1, 1, 0.55),

('def_npc_sap_guard_initia_SAP_FLOCK', 'reinforce_guard_initia_wave_0', 'def_npc_troiar_ewjammer_rank5', 1, 1, 0.55),
('def_npc_sap_guard_kara_SAP_FLOCK', 'reinforce_guard_kara_wave_0', 'def_npc_troiar_ewjammer_rank5', 1, 1, 0.55),
('def_npc_sap_guard_uria_SAP_FLOCK', 'reinforce_guard_uria_wave_0', 'def_npc_troiar_ewjammer_rank5', 1, 1, 0.55),
--beta2
('def_npc_sap_invade_fortd_SAP_FLOCK', 'reinforce_invade_fortd_wave_0', 'def_npc_troiar_ewjammer_rank5', 1, 1, 0.55),
('def_npc_sap_invade_bstone_SAP_FLOCK', 'reinforce_invade_bstone_wave_0', 'def_npc_troiar_ewjammer_rank5', 1, 1, 0.55),
('def_npc_sap_guard_fortd_SAP_FLOCK', 'reinforce_guard_fortd_wave_0', 'def_npc_troiar_ewjammer_rank5', 1, 1, 0.55),
('def_npc_sap_guard_bstone_SAP_FLOCK', 'reinforce_guard_bstone_wave_0', 'def_npc_troiar_ewjammer_rank5', 1, 1, 0.55),

--Omega Stronghold Bosses
('tyrannos_protector', 'reinforce_strnghld1_tyrannos_wave_0', 'def_npc_troiar_ewjammer_rank5', 1, 2, 0.5),
('tyrannos_protector', 'reinforce_strnghld1_tyrannos_wave_1', 'def_npc_troiar_ewjammer_rank5', 2, 2, 0.75),

('artemis_protector_stronghold1', 'reinforce_strnghld1_artemis_wave_0', 'def_npc_intakt_ewjammer_rank5', 1, 2, 0.5),
('artemis_protector_stronghold1', 'reinforce_strnghld1_artemis_wave_1', 'def_npc_intakt_ewjammer_rank5', 2, 2, 0.75),

('kain_protector_stronghold1', 'reinforce_strnghld1_kain_wave_0', 'def_npc_cameleon_ewjammer_rank5', 1, 2, 0.5),
('kain_protector_stronghold1', 'reinforce_strnghld1_kain_wave_1', 'def_npc_cameleon_ewjammer_rank5', 2, 2, 0.75);

PRINT N'DELETE npcflock, npcpresence, npcreinforcements IF EXISTS where data in temp table';
DELETE FROM npcflock WHERE presenceid in (SELECT id FROM npcpresence WHERE name in (SELECT DISTINCT presenceName FROM #WAVES));
DELETE FROM npcpresence WHERE name in (SELECT DISTINCT presenceName FROM #WAVES);
DELETE FROM npcreinforcements WHERE targetId in (SELECT id FROM npcflock WHERE name IN (SELECT DISTINCT targetFlockName from #WAVES));

PRINT N'INSERT npcflock, npcpresence, npcreinforcements FROM temp table';
INSERT INTO npcpresence 
	(name,topx,topy,bottomx,bottomy,note,spawnid,enabled,roaming,roamingrespawnseconds,presencetype,maxrandomflock,randomcenterx,randomcentery,randomradius,dynamiclifetime,isbodypull,isrespawnallowed,safebodypull,izgroupid)
SELECT DISTINCT 
	presenceName, 0, 0, 0, 0, presenceName, 10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL
FROM #WAVES;

INSERT INTO npcflock
	(name,presenceid,flockmembercount,definition,spawnoriginX,spawnoriginY,spawnrangeMin,spawnrangeMax,respawnseconds,totalspawncount,homerange,note,respawnmultiplierlow,enabled,iscallforhelp,behaviorType,npcSpecialType)
SELECT 
	presenceName+npcDefName, (SELECT id FROM npcpresence WHERE name=presenceName), numInFlock, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=npcDefName), 0, 0, 0, 10, 0, 1, 35, presenceName+npcDefName, 0.5, 1, 1, behaviorType, 0
FROM #WAVES;

INSERT INTO dbo.npcreinforcements
	(reinforcementType, targetId, threshold, presenceId, zoneId)
SELECT
	@reinforceType, (SELECT TOP 1 id FROM npcflock WHERE name=targetFlockName), thresh, (SELECT TOP 1 id FROM npcpresence WHERE name=presenceName), NULL
FROM #WAVES;

PRINT N'DONE w/ ADD/UPDATE npcreinforcements FOR NPC BOSSES';
GO

