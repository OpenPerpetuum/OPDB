USE [perpetuumsa]
GO

DECLARE @respawnTime AS INT = 7200;

DROP TABLE IF EXISTS #TMPNPCPRESENCE;
CREATE TABLE #TMPNPCPRESENCE
(
	presencename varchar(128) NULL, --used to keep the general name, to join later with npcflocks
	name varchar(128) NOT NULL,
	topx int NOT NULL DEFAULT 40,
	topy int NOT NULL DEFAULT 40,
	bottomx int NOT NULL DEFAULT 2000,
	bottomy int NOT NULL DEFAULT 2000,
	note nvarchar(2000) NULL,
	spawnid int NULL,
	enabled bit NOT NULL DEFAULT 1,
	roaming bit NOT NULL DEFAULT 1,
	roamingrespawnseconds int NULL DEFAULT 7200, --respawn time
	presencetype int NOT NULL DEFAULT 5,
	maxrandomflock int NULL,
	randomcenterx int NULL,
	randomcentery int NULL,
	randomradius int NULL,
	dynamiclifetime int NULL,
	isbodypull bit NOT NULL DEFAULT 1,
	isrespawnallowed bit NOT NULL DEFAULT 1,
	safebodypull bit NOT NULL DEFAULT 1,
	izgroupid int NULL,
	growthseconds int NULL
);

DROP TABLE IF EXISTS #TMPNPC;
CREATE TABLE #TMPNPC
(
	zonetier INT NOT NULL,
	zonefaction varchar(128) NOT NULL,
	name varchar(128) NULL,
	presencename varchar(100) NOT NULL, --temp field used to gather presence id later
	defname varchar(100) NOT NULL, --temp field used to gather definition id later
	flockmembercount int NULL --number of npc
);
INSERT INTO #TMPNPC (zonetier,zonefaction,presencename,defname,flockmembercount)
VALUES
(0,'Nuimqol','roamer_01','def_npc_gamma_kain_dps_l7',3),
(0,'Nuimqol','roamer_01','def_npc_gamma_vagabond_shield_l7',2),
(0,'Nuimqol','roamer_01','def_npc_gamma_cameleon_shield_l7',2),
(0,'Nuimqol','roamer_02','def_npc_gamma_scarab_basic_lindy',1),
(0,'Nuimqol','roamer_02','def_npc_gamma_symbiont_basic_lindy',1),
(0,'Nuimqol','roamer_02','def_npc_gamma_gargoyle_basic_lindy',2),
(0,'Nuimqol','roamer_02','def_npc_gamma_termis_basic_lindy',2),
(0,'Nuimqol','roamer_02','def_npc_gamma_mesmer_tank_l7',2),
(0,'Nuimqol','roamer_02','def_npc_gamma_mesmer_dps_l7',2),
(0,'Nuimqol','roamer_02','def_npc_gamma_kain_tank_l7',3),
(0,'Nuimqol','roamer_02','def_npc_gamma_vagabond_armor_l7',2),
(0,'Nuimqol','roamer_02','def_npc_gamma_yagel_speed_l7',2),
(0,'Nuimqol','roamer_03','def_npc_gamma_arbalest_dps_l7',3),
(0,'Nuimqol','roamer_03','def_npc_gamma_cameleon_armor_l7',2),
(0,'Nuimqol','roamer_03','def_npc_gamma_yagel_dps_l7',2),
(0,'Nuimqol','roamer_04','def_npc_gamma_mesmer_dps_l6',4),
(0,'Nuimqol','roamer_04','def_npc_gamma_vagabond_shield_l6',3),
(0,'Nuimqol','roamer_04','def_npc_gamma_arbalest_speed_l6',3),
(0,'Nuimqol','roamer_05','def_npc_gamma_kain_dps_l6',3),
(0,'Nuimqol','roamer_05','def_npc_gamma_vagabond_armor_l6',3),
(0,'Nuimqol','roamer_05','def_npc_gamma_yagel_dps_l6',2),
(0,'Nuimqol','roamer_06','def_npc_gamma_yagel_speed_l6',2),
(0,'Nuimqol','roamer_06','def_npc_gamma_sequer_basic_lindy',1),
(0,'Nuimqol','roamer_06','def_npc_gamma_termis_basic_lindy',1),
(0,'Nuimqol','roamer_06','def_npc_gamma_laird_basic_lindy',3),
(0,'Nuimqol','roamer_06','def_npc_gamma_arbalest_speed_l6',3),
(0,'Nuimqol','roamer_06','def_npc_gamma_cameleon_shield_l6',3),
(0,'Nuimqol','roamer_06','def_npc_gamma_kain_dps_l6',2),
(0,'Nuimqol','roamer_07','def_npc_gamma_yagel_speed_l6',2),
(0,'Nuimqol','roamer_07','def_npc_gamma_cameleon_shield_l6',3),
(0,'Nuimqol','roamer_07','def_npc_gamma_arbalest_speed_l6',5),
(0,'Nuimqol','roamer_08','def_npc_gamma_mesmer_dps_l6',2),
(0,'Nuimqol','roamer_08','def_npc_gamma_kain_dps_l6',5),
(0,'Nuimqol','roamer_08','def_npc_gamma_cameleon_shield_l6',2),
(0,'Nuimqol','roamer_08','def_npc_gamma_yagel_dps_l6',2),
(0,'Nuimqol','observer_01','def_npc_gamma_mesmer_advanced_observer',2),
(0,'Nuimqol','observer_01','def_npc_gamma_kain_advanced_observer',1),
(0,'Nuimqol','observer_01','def_npc_gamma_vagabond_advanced_observer',1),
(0,'Nuimqol','observer_02','def_npc_gamma_kain_advanced_observer',2),
(0,'Nuimqol','observer_02','def_npc_gamma_vagabond_advanced_observer',1),
(0,'Nuimqol','courier_01','def_npc_gamma_arbalest_advanced_courier',2),
(0,'Nuimqol','courier_01','def_npc_gamma_cameleon_advanced_courier',2),
(0,'Nuimqol','courier_01','def_npc_gamma_sequer_advanced_courier',2),
(0,'Nuimqol','courier_02','def_npc_gamma_yagel_advanced_courier',1),
(0,'Nuimqol','courier_02','def_npc_gamma_hermes_advanced_courier',1),
(0,'Nuimqol','miniboss_01','def_npc_gamma_mesmer_advanced_miniboss',1),
(0,'Nuimqol','miniboss_01','def_npc_gamma_vagabond_shield_l7',2),
(0,'Nuimqol','miniboss_01','def_npc_gamma_kain_dps_l7',2),
(0,'Nuimqol','pitboss_01','def_npc_gamma_felos_nuimqol_pitboss',1),
(0,'Nuimqol','pitboss_01','def_npc_mesmer_miniboss_rank3',2),
(0,'Nuimqol','pitboss_01','def_npc_vagabond_miniboss_rank3',2),
(0,'Thelodica','roamer_01','def_npc_gamma_artemis_dps_l7',3),
(0,'Thelodica','roamer_01','def_npc_gamma_zenith_shield_l7',2),
(0,'Thelodica','roamer_01','def_npc_gamma_intakt_shield_l7',2),
(0,'Thelodica','roamer_02','def_npc_gamma_scarab_basic_lindy',1),
(0,'Thelodica','roamer_02','def_npc_gamma_riveler_basic_lindy',1),
(0,'Thelodica','roamer_02','def_npc_gamma_gargoyle_basic_lindy',2),
(0,'Thelodica','roamer_02','def_npc_gamma_termis_basic_lindy',2),
(0,'Thelodica','roamer_02','def_npc_gamma_seth_tank_l7',2),
(0,'Thelodica','roamer_02','def_npc_gamma_seth_dps_l7',2),
(0,'Thelodica','roamer_02','def_npc_gamma_artemis_tank_l7',3),
(0,'Thelodica','roamer_02','def_npc_gamma_zenith_armor_l7',2),
(0,'Thelodica','roamer_02','def_npc_gamma_prometheus_speed_l7',2),
(0,'Thelodica','roamer_03','def_npc_gamma_baphomet_dps_l7',3),
(0,'Thelodica','roamer_03','def_npc_gamma_intakt_armor_l7',2),
(0,'Thelodica','roamer_03','def_npc_gamma_prometheus_dps_l7',2),
(0,'Thelodica','roamer_04','def_npc_gamma_seth_dps_l6',4),
(0,'Thelodica','roamer_04','def_npc_gamma_zenith_shield_l6',3),
(0,'Thelodica','roamer_04','def_npc_gamma_baphomet_speed_l6',3),
(0,'Thelodica','roamer_05','def_npc_gamma_artemis_dps_l6',3),
(0,'Thelodica','roamer_05','def_npc_gamma_zenith_armor_l6',3),
(0,'Thelodica','roamer_05','def_npc_gamma_prometheus_dps_l6',2),
(0,'Thelodica','roamer_06','def_npc_gamma_prometheus_speed_l6',2),
(0,'Thelodica','roamer_06','def_npc_gamma_sequer_basic_lindy',1),
(0,'Thelodica','roamer_06','def_npc_gamma_gargoyle_basic_lindy',1),
(0,'Thelodica','roamer_06','def_npc_gamma_argano_basic_lindy',3),
(0,'Thelodica','roamer_06','def_npc_gamma_baphomet_speed_l6',3),
(0,'Thelodica','roamer_06','def_npc_gamma_intakt_shield_l6',3),
(0,'Thelodica','roamer_06','def_npc_gamma_artemis_dps_l6',2),
(0,'Thelodica','roamer_07','def_npc_gamma_prometheus_speed_l6',2),
(0,'Thelodica','roamer_07','def_npc_gamma_intakt_shield_l6',3),
(0,'Thelodica','roamer_07','def_npc_gamma_baphomet_speed_l6',5),
(0,'Thelodica','roamer_08','def_npc_gamma_seth_dps_l6',2),
(0,'Thelodica','roamer_08','def_npc_gamma_artemis_dps_l6',5),
(0,'Thelodica','roamer_08','def_npc_gamma_intakt_shield_l6',2),
(0,'Thelodica','roamer_08','def_npc_gamma_prometheus_dps_l6',2),
(0,'Thelodica','observer_01','def_npc_gamma_seth_advanced_observer',2),
(0,'Thelodica','observer_01','def_npc_gamma_artemis_advanced_observer',1),
(0,'Thelodica','observer_01','def_npc_gamma_zenith_advanced_observer',1),
(0,'Thelodica','observer_02','def_npc_gamma_artemis_advanced_observer',2),
(0,'Thelodica','observer_02','def_npc_gamma_zenith_advanced_observer',1),
(0,'Thelodica','courier_01','def_npc_gamma_baphomet_advanced_courier',2),
(0,'Thelodica','courier_01','def_npc_gamma_intakt_advanced_courier',2),
(0,'Thelodica','courier_01','def_npc_gamma_sequer_advanced_courier',2),
(0,'Thelodica','courier_02','def_npc_gamma_prometheus_advanced_courier',1),
(0,'Thelodica','courier_02','def_npc_gamma_hermes_advanced_courier',1),
(0,'Thelodica','miniboss_01','def_npc_gamma_seth_advanced_miniboss',1),
(0,'Thelodica','miniboss_01','def_npc_gamma_zenith_shield_l7',2),
(0,'Thelodica','miniboss_01','def_npc_gamma_artemis_dps_l7',2),
(0,'Thelodica','pitboss_01','def_npc_gamma_onyx_thelodica_pitboss',1),
(0,'Thelodica','pitboss_01','def_npc_seth_miniboss_rank3',2),
(0,'Thelodica','pitboss_01','def_npc_zenith_miniboss_rank3',2),
(0,'Pelistal','roamer_01','def_npc_gamma_tyrannos_dps_l7',3),
(0,'Pelistal','roamer_01','def_npc_gamma_ictus_shield_l7',2),
(0,'Pelistal','roamer_01','def_npc_gamma_troiar_shield_l7',2),
(0,'Pelistal','roamer_02','def_npc_gamma_scarab_basic_lindy',1),
(0,'Pelistal','roamer_02','def_npc_gamma_riveler_basic_lindy',1),
(0,'Pelistal','roamer_02','def_npc_gamma_gargoyle_basic_lindy',2),
(0,'Pelistal','roamer_02','def_npc_gamma_termis_basic_lindy',2),
(0,'Pelistal','roamer_02','def_npc_gamma_gropho_tank_l7',2),
(0,'Pelistal','roamer_02','def_npc_gamma_gropho_dps_l7',2),
(0,'Pelistal','roamer_02','def_npc_gamma_tyrannos_tank_l7',3),
(0,'Pelistal','roamer_02','def_npc_gamma_ictus_armor_l7',2),
(0,'Pelistal','roamer_02','def_npc_gamma_castel_speed_l7',2),
(0,'Pelistal','roamer_03','def_npc_gamma_waspish_dps_l7',3),
(0,'Pelistal','roamer_03','def_npc_gamma_troiar_armor_l7',2),
(0,'Pelistal','roamer_03','def_npc_gamma_castel_dps_l7',2),
(0,'Pelistal','roamer_04','def_npc_gamma_gropho_dps_l6',4),
(0,'Pelistal','roamer_04','def_npc_gamma_ictus_shield_l6',3),
(0,'Pelistal','roamer_04','def_npc_gamma_waspish_speed_l6',3),
(0,'Pelistal','roamer_05','def_npc_gamma_tyrannos_dps_l6',3),
(0,'Pelistal','roamer_05','def_npc_gamma_ictus_armor_l6',3),
(0,'Pelistal','roamer_05','def_npc_gamma_castel_dps_l6',2),
(0,'Pelistal','roamer_06','def_npc_gamma_castel_speed_l6',2),
(0,'Pelistal','roamer_06','def_npc_gamma_sequer_basic_lindy',1),
(0,'Pelistal','roamer_06','def_npc_gamma_gargoyle_basic_lindy',1),
(0,'Pelistal','roamer_06','def_npc_gamma_argano_basic_lindy',3),
(0,'Pelistal','roamer_06','def_npc_gamma_waspish_speed_l6',3),
(0,'Pelistal','roamer_06','def_npc_gamma_troiar_shield_l6',3),
(0,'Pelistal','roamer_06','def_npc_gamma_tyrannos_dps_l6',2),
(0,'Pelistal','roamer_07','def_npc_gamma_castel_speed_l6',2),
(0,'Pelistal','roamer_07','def_npc_gamma_troiar_shield_l6',3),
(0,'Pelistal','roamer_07','def_npc_gamma_waspish_speed_l6',5),
(0,'Pelistal','roamer_08','def_npc_gamma_gropho_dps_l6',2),
(0,'Pelistal','roamer_08','def_npc_gamma_tyrannos_dps_l6',5),
(0,'Pelistal','roamer_08','def_npc_gamma_troiar_shield_l6',2),
(0,'Pelistal','roamer_08','def_npc_gamma_castel_dps_l6',2),
(0,'Pelistal','observer_01','def_npc_gamma_gropho_advanced_observer',2),
(0,'Pelistal','observer_01','def_npc_gamma_tyrannos_advanced_observer',1),
(0,'Pelistal','observer_01','def_npc_gamma_ictus_advanced_observer',1),
(0,'Pelistal','observer_02','def_npc_gamma_tyrannos_advanced_observer',2),
(0,'Pelistal','observer_02','def_npc_gamma_ictus_advanced_observer',1),
(0,'Pelistal','courier_01','def_npc_gamma_waspish_advanced_courier',2),
(0,'Pelistal','courier_01','def_npc_gamma_troiar_advanced_courier',2),
(0,'Pelistal','courier_01','def_npc_gamma_sequer_advanced_courier',2),
(0,'Pelistal','courier_02','def_npc_gamma_castel_advanced_courier',1),
(0,'Pelistal','courier_02','def_npc_gamma_hermes_advanced_courier',1),
(0,'Pelistal','miniboss_01','def_npc_gamma_gropho_advanced_miniboss',1),
(0,'Pelistal','miniboss_01','def_npc_gamma_ictus_shield_l7',2),
(0,'Pelistal','miniboss_01','def_npc_gamma_tyrannos_dps_l7',2),
(0,'Pelistal','pitboss_01','def_npc_gamma_onyx_thelodica_pitboss',1),
(0,'Pelistal','pitboss_01','def_npc_gropho_miniboss_rank3',2),
(0,'Pelistal','pitboss_01','def_npc_ictus_miniboss_rank3',2),
(0,'Syndicate','roamer_01','def_npc_gamma_legatus_dps_l7',2),
(0,'Syndicate','roamer_01','def_npc_gamma_echelon_dps_l7',3),
(0,'Syndicate','roamer_01','def_npc_gamma_callisto_shield_l7',2),
(0,'Syndicate','roamer_01','def_npc_gamma_helix_shield_l7',2),
(0,'Syndicate','roamer_02','def_npc_gamma_daidalos_basic_lindy',4),
(0,'Syndicate','roamer_02','def_npc_gamma_cronus_basic_lindy',2),
(0,'Syndicate','roamer_02','def_npc_gamma_legatus_tank_l7',2),
(0,'Syndicate','roamer_02','def_npc_gamma_echelon_tank_l7',2),
(0,'Syndicate','roamer_02','def_npc_gamma_callisto_armor_l7',2),
(0,'Syndicate','roamer_02','def_npc_gamma_vektor_speed_l7',2),
(0,'Syndicate','roamer_03','def_npc_gamma_locust_dps_l7',3),
(0,'Syndicate','roamer_03','def_npc_gamma_helix_armor_l7',2),
(0,'Syndicate','roamer_03','def_npc_gamma_vektor_dps_l7',2),
(0,'Syndicate','roamer_04','def_npc_gamma_legatus_dps_l6',3),
(0,'Syndicate','roamer_04','def_npc_gamma_callisto_shield_l6',3),
(0,'Syndicate','roamer_04','def_npc_gamma_locust_speed_l6',3),
(0,'Syndicate','roamer_05','def_npc_gamma_echelon_dps_l6',4),
(0,'Syndicate','roamer_05','def_npc_gamma_ikarus_basic_lindy',2),
(0,'Syndicate','roamer_05','def_npc_gamma_cronus_basic_lindy',3),
(0,'Syndicate','roamer_05','def_npc_gamma_callisto_armor_l6',3),
(0,'Syndicate','roamer_05','def_npc_gamma_vektor_dps_l6',2),
(0,'Syndicate','roamer_06','def_npc_gamma_vektor_speed_l6',2),
(0,'Syndicate','roamer_06','def_npc_gamma_locust_speed_l6',5),
(0,'Syndicate','roamer_06','def_npc_gamma_helix_shield_l6',3),
(0,'Syndicate','roamer_06','def_npc_gamma_echelon_dps_l6',2),
(0,'Syndicate','roamer_07','def_npc_gamma_vektor_speed_l6',2),
(0,'Syndicate','roamer_07','def_npc_gamma_helix_shield_l6',3),
(0,'Syndicate','roamer_07','def_npc_gamma_locust_dps_l6',2),
(0,'Syndicate','roamer_08','def_npc_gamma_legatus_dps_l6',2),
(0,'Syndicate','roamer_08','def_npc_gamma_echelon_dps_l6',5),
(0,'Syndicate','roamer_08','def_npc_gamma_helix_shield_l6',2),
(0,'Syndicate','roamer_08','def_npc_gamma_vektor_dps_l6',2),
(0,'Syndicate','roamer_09','def_npc_gamma_hermes_basic_lindy',1),
(0,'Syndicate','observer_01','def_npc_gamma_legatus_advanced_observer',2),
(0,'Syndicate','observer_01','def_npc_gamma_echelon_advanced_observer',1),
(0,'Syndicate','observer_01','def_npc_gamma_callisto_advanced_observer',1),
(0,'Syndicate','observer_02','def_npc_gamma_echelon_advanced_observer',2),
(0,'Syndicate','observer_02','def_npc_gamma_callisto_advanced_observer',1),
(0,'Syndicate','courier_01','def_npc_gamma_locust_advanced_courier',2),
(0,'Syndicate','courier_01','def_npc_gamma_helix_advanced_courier',2),
(0,'Syndicate','courier_01','def_npc_gamma_ikarus_advanced_courier',6),
(0,'Syndicate','courier_02','def_npc_gamma_vektor_advanced_courier',1),
(0,'Syndicate','courier_02','def_npc_gamma_hermes_advanced_courier',1),
(0,'Syndicate','miniboss_01','def_npc_gamma_legatus_advanced_miniboss',1),
(0,'Syndicate','miniboss_01','def_npc_gamma_callisto_shield_l7',2),
(0,'Syndicate','miniboss_01','def_npc_gamma_echelon_dps_l7',2),
(0,'Syndicate','pitboss_01','def_npc_gamma_apollo_syndicate_syn_pitboss',1),
(0,'Syndicate','pitboss_01','def_npc_gamma_legatus_advanced_observer',2),
(0,'Syndicate','pitboss_01','def_npc_gamma_callisto_advanced_observer',2),
(3,'Nuimqol','roamer_01','def_npc_gamma_kain_dps_l5',3),
(3,'Nuimqol','roamer_01','def_npc_gamma_vagabond_shield_l5',2),
(3,'Nuimqol','roamer_01','def_npc_gamma_cameleon_shield_l5',1),
(3,'Nuimqol','roamer_02','def_npc_gamma_lithus_basic_lindy',1),
(3,'Nuimqol','roamer_02','def_npc_gamma_riveler_basic_lindy',1),
(3,'Nuimqol','roamer_02','def_npc_gamma_gargoyle_basic_lindy',2),
(3,'Nuimqol','roamer_02','def_npc_gamma_mesmer_tank_l5',3),
(3,'Nuimqol','roamer_02','def_npc_gamma_kain_tank_l5',2),
(3,'Nuimqol','roamer_02','def_npc_gamma_vagabond_armor_l5',2),
(3,'Nuimqol','roamer_02','def_npc_gamma_yagel_speed_l5',2),
(3,'Nuimqol','roamer_03','def_npc_gamma_arbalest_dps_l5',3),
(3,'Nuimqol','roamer_03','def_npc_gamma_cameleon_armor_l5',2),
(3,'Nuimqol','roamer_03','def_npc_gamma_yagel_dps_l5',2),
(3,'Nuimqol','roamer_04','def_npc_gamma_mesmer_dps_l5',3),
(3,'Nuimqol','roamer_04','def_npc_gamma_vagabond_shield_l5',2),
(3,'Nuimqol','roamer_04','def_npc_gamma_arbalest_speed_l5',2),
(3,'Nuimqol','roamer_05','def_npc_gamma_mesmer_tank_l5',2),
(3,'Nuimqol','roamer_05','def_npc_gamma_kain_dps_l5',2),
(3,'Nuimqol','roamer_05','def_npc_gamma_vagabond_armor_l5',2),
(3,'Nuimqol','roamer_05','def_npc_gamma_yagel_dps_l5',2),
(3,'Nuimqol','roamer_06','def_npc_gamma_yagel_speed_l5',2),
(3,'Nuimqol','roamer_06','def_npc_gamma_arbalest_speed_l5',5),
(3,'Nuimqol','roamer_06','def_npc_gamma_cameleon_shield_l5',2),
(3,'Nuimqol','roamer_06','def_npc_gamma_kain_dps_l5',2),
(3,'Nuimqol','roamer_07','def_npc_gamma_yagel_speed_l5',2),
(3,'Nuimqol','roamer_07','def_npc_gamma_cameleon_shield_l5',2),
(3,'Nuimqol','roamer_07','def_npc_gamma_arbalest_dps_l5',2),
(3,'Nuimqol','roamer_08','def_npc_gamma_mesmer_dps_l5',2),
(3,'Nuimqol','roamer_08','def_npc_gamma_kain_dps_l5',5),
(3,'Nuimqol','roamer_08','def_npc_gamma_cameleon_shield_l5',1),
(3,'Nuimqol','roamer_08','def_npc_gamma_yagel_dps_l5',2),
(3,'Nuimqol','observer_01','def_npc_gamma_mesmer_advanced_observer',1),
(3,'Nuimqol','observer_01','def_npc_gamma_kain_advanced_observer',2),
(3,'Nuimqol','observer_01','def_npc_gamma_vagabond_advanced_observer',1),
(3,'Nuimqol','observer_02','def_npc_gamma_kain_advanced_observer',1),
(3,'Nuimqol','observer_02','def_npc_gamma_vagabond_advanced_observer',1),
(3,'Nuimqol','courier_01','def_npc_gamma_arbalest_advanced_courier',1),
(3,'Nuimqol','courier_01','def_npc_gamma_cameleon_advanced_courier',2),
(3,'Nuimqol','courier_01','def_npc_gamma_sequer_advanced_courier',1),
(2,'Nuimqol','roamer_01','def_npc_gamma_kain_dps_l4',2),
(2,'Nuimqol','roamer_01','def_npc_gamma_mesmer_dps_l4',1),
(2,'Nuimqol','roamer_01','def_npc_gamma_arbalest_dps_l4',3),
(2,'Nuimqol','roamer_01','def_npc_gamma_cameleon_shield_l4',3),
(2,'Nuimqol','roamer_02','def_npc_gamma_sequer_basic_lindy',2),
(2,'Nuimqol','roamer_02','def_npc_gamma_riveler_basic_lindy',1),
(2,'Nuimqol','roamer_02','def_npc_gamma_gargoyle_basic_lindy',2),
(2,'Nuimqol','roamer_02','def_npc_gamma_mesmer_tank_l4',2),
(2,'Nuimqol','roamer_02','def_npc_gamma_kain_tank_l4',2),
(2,'Nuimqol','roamer_02','def_npc_gamma_vagabond_armor_l4',2),
(2,'Nuimqol','roamer_02','def_npc_gamma_yagel_speed_l4',2),
(2,'Nuimqol','roamer_03','def_npc_gamma_arbalest_dps_l4',3),
(2,'Nuimqol','roamer_03','def_npc_gamma_vagabond_armor_l4',2),
(2,'Nuimqol','roamer_03','def_npc_gamma_yagel_dps_l4',3),
(2,'Nuimqol','roamer_04','def_npc_gamma_mesmer_dps_l4',3),
(2,'Nuimqol','roamer_04','def_npc_gamma_yagel_speed_l4',2),
(2,'Nuimqol','roamer_04','def_npc_gamma_arbalest_speed_l4',3),
(2,'Nuimqol','roamer_05','def_npc_gamma_kain_dps_l4',3),
(2,'Nuimqol','roamer_05','def_npc_gamma_vagabond_armor_l4',2),
(2,'Nuimqol','roamer_05','def_npc_gamma_yagel_dps_l4',3),
(2,'Nuimqol','roamer_06','def_npc_gamma_yagel_speed_l4',2),
(2,'Nuimqol','roamer_06','def_npc_gamma_arbalest_speed_l4',5),
(2,'Nuimqol','roamer_06','def_npc_gamma_cameleon_shield_l4',2),
(2,'Nuimqol','roamer_06','def_npc_gamma_kain_dps_l4',3),
(2,'Nuimqol','roamer_07','def_npc_gamma_yagel_speed_l4',2),
(2,'Nuimqol','roamer_07','def_npc_gamma_cameleon_shield_l4',2),
(2,'Nuimqol','roamer_07','def_npc_gamma_arbalest_dps_l4',2),
(2,'Nuimqol','roamer_08','def_npc_gamma_mesmer_dps_l4',2),
(2,'Nuimqol','roamer_08','def_npc_gamma_kain_dps_l4',5),
(2,'Nuimqol','roamer_08','def_npc_gamma_cameleon_armor_l4',3),
(2,'Nuimqol','roamer_08','def_npc_gamma_yagel_dps_l4',2),
(2,'Nuimqol','observer_01','def_npc_gamma_mesmer_advanced_observer',1),
(2,'Nuimqol','observer_01','def_npc_gamma_vagabond_advanced_observer',1),
(2,'Nuimqol','observer_02','def_npc_gamma_kain_advanced_observer',1),
(2,'Nuimqol','observer_02','def_npc_gamma_vagabond_advanced_observer',1),
(2,'Nuimqol','courier_01','def_npc_gamma_arbalest_advanced_courier',1),
(2,'Nuimqol','courier_01','def_npc_gamma_cameleon_advanced_courier',1),
(2,'Nuimqol','courier_01','def_npc_gamma_sequer_advanced_courier',1),
(1,'Nuimqol','roamer_01','def_npc_gamma_kain_dps_l3',2),
(1,'Nuimqol','roamer_01','def_npc_gamma_arbalest_dps_l3',4),
(1,'Nuimqol','roamer_01','def_npc_gamma_cameleon_shield_l3',3),
(1,'Nuimqol','roamer_02','def_npc_gamma_sequer_basic_lindy',1),
(1,'Nuimqol','roamer_02','def_npc_gamma_termis_basic_lindy',1),
(1,'Nuimqol','roamer_02','def_npc_gamma_laird_basic_lindy',2),
(1,'Nuimqol','roamer_02','def_npc_gamma_mesmer_tank_l3',1),
(1,'Nuimqol','roamer_02','def_npc_gamma_kain_tank_l3',3),
(1,'Nuimqol','roamer_02','def_npc_gamma_vagabond_armor_l3',1),
(1,'Nuimqol','roamer_02','def_npc_gamma_cameleon_armor_l3',2),
(1,'Nuimqol','roamer_02','def_npc_gamma_yagel_speed_l3',2),
(1,'Nuimqol','roamer_03','def_npc_gamma_arbalest_dps_l3',4),
(1,'Nuimqol','roamer_03','def_npc_gamma_vagabond_armor_l3',2),
(1,'Nuimqol','roamer_03','def_npc_gamma_yagel_dps_l3',3),
(1,'Nuimqol','roamer_04','def_npc_gamma_mesmer_dps_l3',3),
(1,'Nuimqol','roamer_04','def_npc_gamma_yagel_speed_l3',3),
(1,'Nuimqol','roamer_04','def_npc_gamma_arbalest_speed_l3',4),
(1,'Nuimqol','roamer_05','def_npc_gamma_kain_dps_l3',3),
(1,'Nuimqol','roamer_05','def_npc_gamma_vagabond_armor_l3',1),
(1,'Nuimqol','roamer_05','def_npc_gamma_cameleon_armor_l3',1),
(1,'Nuimqol','roamer_05','def_npc_gamma_yagel_dps_l3',3),
(1,'Nuimqol','roamer_06','def_npc_gamma_yagel_speed_l3',4),
(1,'Nuimqol','roamer_06','def_npc_gamma_arbalest_speed_l3',6),
(1,'Nuimqol','roamer_06','def_npc_gamma_cameleon_shield_l3',2),
(1,'Nuimqol','roamer_06','def_npc_gamma_kain_dps_l3',3),
(1,'Nuimqol','roamer_07','def_npc_gamma_yagel_speed_l3',2),
(1,'Nuimqol','roamer_07','def_npc_gamma_cameleon_shield_l3',2),
(1,'Nuimqol','roamer_07','def_npc_gamma_arbalest_dps_l3',2),
(1,'Nuimqol','roamer_08','def_npc_gamma_mesmer_dps_l3',2),
(1,'Nuimqol','roamer_08','def_npc_gamma_kain_dps_l3',5),
(1,'Nuimqol','roamer_08','def_npc_gamma_cameleon_armor_l3',2),
(1,'Nuimqol','roamer_08','def_npc_gamma_yagel_dps_l3',3),
(1,'Nuimqol','observer_01','def_npc_gamma_mesmer_advanced_observer',1),
(1,'Nuimqol','observer_01','def_npc_gamma_kain_advanced_observer',1),
(1,'Nuimqol','observer_02','def_npc_gamma_kain_advanced_observer',1),
(1,'Nuimqol','observer_02','def_npc_gamma_vagabond_advanced_observer',1),
(1,'Nuimqol','courier_01','def_npc_gamma_arbalest_advanced_courier',1),
(1,'Nuimqol','courier_01','def_npc_gamma_yagel_advanced_courier',1),
(1,'Nuimqol','courier_01','def_npc_gamma_ikarus_advanced_courier',2)
;


DROP TABLE IF EXISTS #PRES;
CREATE TABLE #PRES
(	
	presencename varchar(128) NOT NULL, -- unique name created from name and zone id
	name varchar(128) NULL,
	roamingrespawnseconds int NULL,
	spawnid int NULL
);

INSERT INTO #PRES (presencename, roamingrespawnseconds)
SELECT DISTINCT presencename, @respawnTime FROM #TMPNPC;


WITH tmp(id, spawnid, raceid,pbsTechLimit)
AS
	(SELECT z.id, z.spawnid, z.raceid, z.pbsTechLimit
	FROM dbo.zones z	
	WHERE z.id > 105 and z.name not like 'zone_gamma_tc_%'
	) 
INSERT INTO #TMPNPCPRESENCE (presencename,name, roamingrespawnseconds, spawnid)
SELECT p.presencename, CONCAT(p.presencename,'_z',tmp.id) as name, p.roamingrespawnseconds, tmp.spawnid
FROM #PRES p
 INNER JOIN (SELECT DISTINCT zonetier,zonefaction,presencename FROM #TMPNPC) npc ON npc.presencename = p.presencename
LEFT JOIN TMP ON tmp.raceid = CASE LOWER(npc.zonefaction) 
									WHEN  'pelistal' THEN 1
									WHEN  'nuimqol' THEN 2
									WHEN  'thelodica' THEN 3
								END
					AND tmp.pbsTechLimit = npc.zonetier
;

PRINT N'DELETE AND REINSERT FLOCKS AND PRESENCES';

--Delete the member flocks of the presences about to be deleted
DELETE FROM npcflock WHERE presenceid IN (
	SELECT id FROM dbo.npcpresence WHERE name IN (
		SELECT NAME FROM #TMPNPCPRESENCE));

--Delete the presences about to be replaced
DELETE FROM dbo.npcpresence WHERE name IN (SELECT NAME FROM #TMPNPCPRESENCE);


INSERT INTO dbo.npcpresence
SELECT name,topx,topy,bottomx,bottomy,note,spawnid,enabled,roaming,roamingrespawnseconds,presencetype,maxrandomflock,
	randomcenterx,randomcentery,randomradius,dynamiclifetime,isbodypull,isrespawnallowed,safebodypull,izgroupid,growthseconds 
FROM #TMPNPCPRESENCE;



DROP TABLE IF EXISTS #TMPNPCFLOCK;
CREATE TABLE #TMPNPCFLOCK
(
	name varchar(128) NOT NULL,
	presenceid int NULL,
	--presencename varchar(100) NOT NULL, --temp field used to gather presence id later
	flockmembercount int NULL, --number of npc
	definition int NOT NULL, --definition (of npc)
	defname varchar(100) NOT NULL, --temp field used to gather definition id later
	spawnoriginX int NOT NULL DEFAULT 0,
	spawnoriginY int NOT NULL DEFAULT 0,
	spawnrangeMin int NOT NULL DEFAULT 0,
	spawnrangeMax int NOT NULL DEFAULT 10,
	respawnseconds int NOT NULL DEFAULT 7200,
	totalspawncount int NOT NULL DEFAULT 1,
	homerange int NOT NULL DEFAULT 50,
	note nvarchar(2000) NULL,
	respawnmultiplierlow float NULL DEFAULT 1,
	enabled bit NOT NULL DEFAULT 1,
	iscallforhelp bit NOT NULL DEFAULT 1,
	behaviorType int NOT NULL DEFAULT 2, --2=red
	npcSpecialType int NOT NULL DEFAULT 0
);
INSERT INTO #TMPNPCFLOCK (name, presenceid, flockmembercount, definition, defname, note, respawnseconds)
SELECT
	CONCAT(p.name,REPLACE(npc.defname,'def_npc_gamma','')) as name,
	(SELECT TOP 1 n.id FROM dbo.npcpresence n WHERE n.name = p.name) AS presenceid,
	npc.flockmembercount,
	(SELECT TOP 1 e.definition FROM dbo.entitydefaults e WHERE npc.defname = e.definitionname) as definition,
	npc.defname,
	'gamma npc' as note,
	pr.roamingrespawnseconds as respawnseconds
FROM #TMPNPC npc
INNER JOIN #TMPNPCPRESENCE p ON p.presencename = npc.presencename
INNER JOIN #PRES pr ON pr.presencename = npc.presencename
;

DELETE FROM dbo.npcflock WHERE name IN (SELECT distinct name from #TMPNPCFLOCK)

INSERT INTO dbo.npcflock(name,presenceid,flockmembercount,definition,spawnoriginX,spawnoriginY,spawnrangeMin,spawnrangeMax,respawnseconds,
	totalspawncount,homerange,note,respawnmultiplierlow,enabled,iscallforhelp,behaviorType,npcSpecialType)
SELECT name,presenceid,flockmembercount,definition,spawnoriginX,spawnoriginY,spawnrangeMin,spawnrangeMax,respawnseconds,
	totalspawncount,homerange,note,respawnmultiplierlow,enabled,iscallforhelp,behaviorType,npcSpecialType 
FROM #TMPNPCFLOCK
;


DROP TABLE IF EXISTS #PRES;
DROP TABLE IF EXISTS #TMPNPCPRESENCE;
DROP TABLE IF EXISTS #TMPNPCFLOCK;
DROP TABLE IF EXISTS #TMPNPC;

GO
