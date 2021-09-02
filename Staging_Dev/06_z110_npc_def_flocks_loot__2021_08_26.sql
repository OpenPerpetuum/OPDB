USE [perpetuumsa]
GO

DECLARE @BOSS_NAME AS VARCHAR(128) = 'def_npc_Gamma_Numiquol_Pitboss';
DECLARE @SPAWN_ID AS INT = (SELECT TOP 1 spawnid FROM zones WHERE id=110)

DROP TABLE IF EXISTS #PRES;
DROP TABLE IF EXISTS #FLOCKS;
DROP TABLE IF EXISTS #NPCDEFS;
DROP TABLE IF EXISTS #NPCMODS;
DROP TABLE IF EXISTS #NPCLOOTS;

CREATE TABLE #NPCDEFS(
	def int,
	defName varchar(128),
	templateName varchar(128),
	templateDescription varchar(max),
	templateNote nvarchar(2000),
	ep int
);
INSERT INTO #NPCDEFS(def, defName, templateName, templateDescription, templateNote, ep) VALUES
(7370,'def_npc_Gamma_Numiquol_Pitboss','Gamma_numiquol_pitboss',
'#robot=i1778#head=i1775#chassis=i1776#leg=i1777#container=i150#headModules=[|m0=[|definition=i31|slot=i1]|m1=[|definition=i1638|slot=i2]|m2=[|definition=ib52|slot=i3]|m3=[|definition=i1638|slot=i4]]#chassisModules=[|m0=[|definition=i3e9|slot=i1|ammoDefinition=iff|ammoQuantity=i32]|m1=[|definition=i3e9|slot=i2|ammoDefinition=i100|ammoQuantity=i32]|m2=[|definition=i3e9|slot=i3|ammoDefinition=i101|ammoQuantity=i32]|m3=[|definition=i3e9|slot=i4|ammoDefinition=i102|ammoQuantity=i32]|m4=[|definition=i3e9|slot=i5|ammoDefinition=i100|ammoQuantity=i32]|m5=[|definition=i3e9|slot=i6|ammoDefinition=i102|ammoQuantity=i32]]#legModules=[|m0=[|definition=i11|slot=i1]|m1=[|definition=i11|slot=i2]|m2=[|definition=i14|slot=i3]|m3=[|definition=i3b7|slot=i4]|m4=[|definition=i3b7|slot=i5]]',
'Gamma_numiquol_pitboss',3000);

CREATE TABLE #NPCMODS(
	defName varchar(128),
	fieldName varchar(128),
	val float
);
INSERT INTO #NPCMODS(defName, fieldName, val) VALUES
('def_npc_Gamma_Numiquol_Pitboss','armor_max_modifier',5.5),
('def_npc_Gamma_Numiquol_Pitboss','armor_repair_amount_modifier',2.55),
('def_npc_Gamma_Numiquol_Pitboss','armor_repair_cycle_time_modifier',0.67),
('def_npc_Gamma_Numiquol_Pitboss','core_max_modifier',5.25),
('def_npc_Gamma_Numiquol_Pitboss','core_recharge_time_modifier',0.65),
('def_npc_Gamma_Numiquol_Pitboss','cpu_max_modifier',2),
('def_npc_Gamma_Numiquol_Pitboss','damage_modifier',5),
('def_npc_Gamma_Numiquol_Pitboss','ecm_strength',3),
('def_npc_Gamma_Numiquol_Pitboss','falloff_modifier',2.5),
('def_npc_Gamma_Numiquol_Pitboss','locked_targets_max_bonus',10),
('def_npc_Gamma_Numiquol_Pitboss','locking_range_modifier',4),
('def_npc_Gamma_Numiquol_Pitboss','locking_time_modifier',1.25),
('def_npc_Gamma_Numiquol_Pitboss','missile_cycle_time_modifier',1),
('def_npc_Gamma_Numiquol_Pitboss','optimal_range_modifier',3),
('def_npc_Gamma_Numiquol_Pitboss','powergrid_max_modifier',3),
('def_npc_Gamma_Numiquol_Pitboss','resist_chemical',600),
('def_npc_Gamma_Numiquol_Pitboss','resist_explosive',600),
('def_npc_Gamma_Numiquol_Pitboss','resist_kinetic',600),
('def_npc_Gamma_Numiquol_Pitboss','resist_thermal',600),
('def_npc_Gamma_Numiquol_Pitboss','speed_max_modifier',1.75),
('def_npc_Gamma_Numiquol_Pitboss','turret_cycle_time_modifier',1),
('def_npc_Gamma_Numiquol_Pitboss','received_repaired_modifier',1.25),
('def_npc_Gamma_Numiquol_Pitboss','detection_strength_modifier',5),
('def_npc_Gamma_Numiquol_Pitboss','missile_falloff_modifier',2.5);

CREATE TABLE #NPCLOOTS(
	defName varchar(128),
	lootName varchar(128),
	minQuantity int,
	maxQuantity int,
	probability float,
	dontDmg bit,
	repackaged bit
);
INSERT INTO #NPCLOOTS(defName, lootName, minQuantity, maxQuantity, probability, dontDmg, repackaged) VALUES
('def_npc_Gamma_Numiquol_Pitboss','def_boost_ep_t0',2,5,1,1,1),
('def_npc_Gamma_Numiquol_Pitboss','def_boost_ep_t1',2,4,1,1,1),
('def_npc_Gamma_Numiquol_Pitboss','def_common_reactor_plasma',80000,200000,1,1,1),
--('def_npc_Gamma_Numiquol_Pitboss','def_gropho_mk2_A_CT_capsule',0,0,0,1,1),
--('def_npc_Gamma_Numiquol_Pitboss','def_gropho_mk2_A_CT_capsule',0,0,0,1,1),
--('def_npc_Gamma_Numiquol_Pitboss','def_gropho_mk2_A_CT_capsule',0,0,0,1,1),
('def_npc_Gamma_Numiquol_Pitboss','def_kernel_common',80000,100000,1,1,1),
('def_npc_Gamma_Numiquol_Pitboss','def_kernel_hitech',80000,100000,1,1,1),
('def_npc_Gamma_Numiquol_Pitboss','def_kernel_nuimqol',350000,400000,1,1,1),
--('def_npc_Gamma_Numiquol_Pitboss','def_kernel_pelistal',0,0,0,1,1),
--('def_npc_Gamma_Numiquol_Pitboss','def_kernel_thelodica',0,0,0,1,1),
('def_npc_Gamma_Numiquol_Pitboss','def_mesmer_mk2_A_CT_capsule',1,1,0.5,1,1),
('def_npc_Gamma_Numiquol_Pitboss','def_mesmer_mk2_A_CT_capsule',1,1,0.5,1,1),
('def_npc_Gamma_Numiquol_Pitboss','def_mesmer_mk2_A_CT_capsule',1,1,0.5,1,1),
('def_npc_Gamma_Numiquol_Pitboss','def_named2_gang_assist_coordinated_maneuvering_module',1,1,0.11,0,1),
('def_npc_Gamma_Numiquol_Pitboss','def_named2_gang_assist_coordinated_maneuvering_module',1,1,0.11,0,1),
('def_npc_Gamma_Numiquol_Pitboss','def_named2_gang_assist_coordinated_maneuvering_module',1,1,0.11,0,1),
('def_npc_Gamma_Numiquol_Pitboss','def_named2_gang_assist_core_management_module',1,1,0.11,0,1),
('def_npc_Gamma_Numiquol_Pitboss','def_named2_gang_assist_core_management_module',1,1,0.11,0,1),
('def_npc_Gamma_Numiquol_Pitboss','def_named2_gang_assist_core_management_module',1,1,0.11,0,1),
('def_npc_Gamma_Numiquol_Pitboss','def_named2_gang_assist_defense_module',1,1,0.11,0,1),
('def_npc_Gamma_Numiquol_Pitboss','def_named2_gang_assist_defense_module',1,1,0.11,0,1),
('def_npc_Gamma_Numiquol_Pitboss','def_named2_gang_assist_defense_module',1,1,0.11,0,1),
('def_npc_Gamma_Numiquol_Pitboss','def_named2_gang_assist_ewar_range_module',1,1,0.11,0,1),
('def_npc_Gamma_Numiquol_Pitboss','def_named2_gang_assist_ewar_range_module',1,1,0.11,0,1),
('def_npc_Gamma_Numiquol_Pitboss','def_named2_gang_assist_ewar_range_module',1,1,0.11,0,1),
('def_npc_Gamma_Numiquol_Pitboss','def_named2_gang_assist_fast_extraction_module',1,1,0.11,0,1),
('def_npc_Gamma_Numiquol_Pitboss','def_named2_gang_assist_fast_extraction_module',1,1,0.11,0,1),
('def_npc_Gamma_Numiquol_Pitboss','def_named2_gang_assist_fast_extraction_module',1,1,0.11,0,1),
('def_npc_Gamma_Numiquol_Pitboss','def_named2_gang_assist_industry_module',1,1,0.11,0,1),
('def_npc_Gamma_Numiquol_Pitboss','def_named2_gang_assist_industry_module',1,1,0.11,0,1),
('def_npc_Gamma_Numiquol_Pitboss','def_named2_gang_assist_industry_module',1,1,0.11,0,1),
('def_npc_Gamma_Numiquol_Pitboss','def_named2_gang_assist_information_module',1,1,0.11,0,1),
('def_npc_Gamma_Numiquol_Pitboss','def_named2_gang_assist_information_module',1,1,0.11,0,1),
('def_npc_Gamma_Numiquol_Pitboss','def_named2_gang_assist_information_module',1,1,0.11,0,1),
('def_npc_Gamma_Numiquol_Pitboss','def_named2_gang_assist_maintance_module',1,1,0.11,0,1),
('def_npc_Gamma_Numiquol_Pitboss','def_named2_gang_assist_maintance_module',1,1,0.11,0,1),
('def_npc_Gamma_Numiquol_Pitboss','def_named2_gang_assist_maintance_module',1,1,0.11,0,1),
('def_npc_Gamma_Numiquol_Pitboss','def_named2_gang_assist_precision_firing_module',1,1,0.11,0,1),
('def_npc_Gamma_Numiquol_Pitboss','def_named2_gang_assist_precision_firing_module',1,1,0.11,0,1),
('def_npc_Gamma_Numiquol_Pitboss','def_named2_gang_assist_precision_firing_module',1,1,0.11,0,1),
('def_npc_Gamma_Numiquol_Pitboss','def_named2_gang_assist_shared_dataprocessing_module',1,1,0.11,0,1),
('def_npc_Gamma_Numiquol_Pitboss','def_named2_gang_assist_shared_dataprocessing_module',1,1,0.11,0,1),
('def_npc_Gamma_Numiquol_Pitboss','def_named2_gang_assist_shared_dataprocessing_module',1,1,0.11,0,1),
('def_npc_Gamma_Numiquol_Pitboss','def_named2_gang_assist_shield_calculation_module',1,1,0.11,0,1),
('def_npc_Gamma_Numiquol_Pitboss','def_named2_gang_assist_shield_calculation_module',1,1,0.11,0,1),
('def_npc_Gamma_Numiquol_Pitboss','def_named2_gang_assist_shield_calculation_module',1,1,0.11,0,1),
('def_npc_Gamma_Numiquol_Pitboss','def_named2_gang_assist_siege_module',1,1,0.11,0,1),
('def_npc_Gamma_Numiquol_Pitboss','def_named2_gang_assist_siege_module',1,1,0.11,0,1),
('def_npc_Gamma_Numiquol_Pitboss','def_named2_gang_assist_siege_module',1,1,0.11,0,1),
('def_npc_Gamma_Numiquol_Pitboss','def_named2_gang_assist_speed_module',1,1,0.11,0,1),
('def_npc_Gamma_Numiquol_Pitboss','def_named2_gang_assist_speed_module',1,1,0.11,0,1),
('def_npc_Gamma_Numiquol_Pitboss','def_named2_gang_assist_speed_module',1,1,0.11,0,1),
('def_npc_Gamma_Numiquol_Pitboss','def_nuimqol_reactor_plasma',375000,500000,1,1,1),
('def_npc_Gamma_Numiquol_Pitboss','def_pelistal_reactor_plasma',0,0,1,1,1),
('def_npc_Gamma_Numiquol_Pitboss','def_reactore_core_assault',1,5,1,1,1),
('def_npc_Gamma_Numiquol_Pitboss','def_reactore_core_heavymech',1,5,1,1,1),
('def_npc_Gamma_Numiquol_Pitboss','def_reactore_core_mech',1,5,1,1,1),
('def_npc_Gamma_Numiquol_Pitboss','def_reactore_core_runner',1,5,1,1,1),
('def_npc_Gamma_Numiquol_Pitboss','def_research_kit_10',2,5,1,1,1),
('def_npc_Gamma_Numiquol_Pitboss','def_research_kit_9',2,5,1,1,1),
('def_npc_Gamma_Numiquol_Pitboss','def_robotshard_common_advanced',500,5000,1,1,1),
('def_npc_Gamma_Numiquol_Pitboss','def_robotshard_common_basic',500,5000,1,1,1),
('def_npc_Gamma_Numiquol_Pitboss','def_robotshard_common_expert',500,5000,1,1,1),
('def_npc_Gamma_Numiquol_Pitboss','def_robotshard_nuimqol_advanced',500,5000,1,1,1),
('def_npc_Gamma_Numiquol_Pitboss','def_robotshard_nuimqol_basic',500,5000,1,1,1),
('def_npc_Gamma_Numiquol_Pitboss','def_robotshard_nuimqol_expert',500,5000,1,1,1),
--('def_npc_Gamma_Numiquol_Pitboss','def_robotshard_pelistal_advanced',0,0,0,1,1),
--('def_npc_Gamma_Numiquol_Pitboss','def_robotshard_pelistal_basic',0,0,0,1,1),
--('def_npc_Gamma_Numiquol_Pitboss','def_robotshard_pelistal_expert',0,0,0,1,1),
--('def_npc_Gamma_Numiquol_Pitboss','def_robotshard_thelodica_advanced',0,0,0,1,1),
--('def_npc_Gamma_Numiquol_Pitboss','def_robotshard_thelodica_basic',0,0,0,1,1),
--('def_npc_Gamma_Numiquol_Pitboss','def_robotshard_thelodica_expert',0,0,0,1,1),
('def_npc_Gamma_Numiquol_Pitboss','def_scarab_mk2_A_CT_capsule',1,1,0.5,1,1),
('def_npc_Gamma_Numiquol_Pitboss','def_scarab_mk2_A_CT_capsule',1,1,0.5,1,1),
('def_npc_Gamma_Numiquol_Pitboss','def_scarab_mk2_A_CT_capsule',1,1,0.5,1,1),
--('def_npc_Gamma_Numiquol_Pitboss','def_seth_mk2_A_CT_capsule',0,0,0,1,1),
--('def_npc_Gamma_Numiquol_Pitboss','def_seth_mk2_A_CT_capsule',0,0,0,1,1),
--('def_npc_Gamma_Numiquol_Pitboss','def_seth_mk2_A_CT_capsule',0,0,0,1,1),
('def_npc_Gamma_Numiquol_Pitboss','def_thelodica_reactor_plasma',0,0,0,1,1),
('def_npc_Gamma_Numiquol_Pitboss','def_boost_ep_t3',1,2,1,1,1),
('def_npc_Gamma_Numiquol_Pitboss','def_boost_ep_t2',2,3,1,1,1),
('def_npc_Gamma_Numiquol_Pitboss','def_kain_mk2_A_CT_capsule',1,1,0.5,1,1),
('def_npc_Gamma_Numiquol_Pitboss','def_kain_mk2_A_CT_capsule',1,1,0.5,1,1),
('def_npc_Gamma_Numiquol_Pitboss','def_kain_mk2_A_CT_capsule',1,1,0.5,1,1),
('def_npc_Gamma_Numiquol_Pitboss','def_vagabond_mk2_A_CT_capsule',1,1,0.5,1,1),
('def_npc_Gamma_Numiquol_Pitboss','def_vagabond_mk2_A_CT_capsule',1,1,0.5,1,1),
('def_npc_Gamma_Numiquol_Pitboss','def_vagabond_mk2_A_CT_capsule',1,1,0.5,1,1);


CREATE TABLE #PRES(
	[name] [varchar](128) NOT NULL,
	[topx] [int] NOT NULL,
	[topy] [int] NOT NULL,
	[bottomx] [int] NOT NULL,
	[bottomy] [int] NOT NULL,
	[note] [nvarchar](2000) NULL,
	[spawnid] [int] NULL,
	[enabled] [bit] NOT NULL,
	[roaming] [bit] NOT NULL,
	[roamingrespawnseconds] [int] NOT NULL,
	[presencetype] [int] NOT NULL,
	[maxrandomflock] [int] NULL,
	[randomcenterx] [int] NULL,
	[randomcentery] [int] NULL,
	[randomradius] [int] NULL,
	[dynamiclifetime] [int] NULL,
	[isbodypull] [bit] NOT NULL,
	[isrespawnallowed] [bit] NOT NULL,
	[safebodypull] [bit] NOT NULL,
	[izgroupid] [int] NULL
);
INSERT INTO #PRES (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid)
VALUES
('Zone_110_T0_Numiqol_Roamer_01',7,7,2040,2040,'Zone_110_T0_Numiqol_Roamer_01',63,1,0,14400,5,0,0,0,0,0,1,1,1,NULL),
('Zone_110_T0_Numiqol_Roamer_02',7,7,2040,2040,'Zone_110_T0_Numiqol_Roamer_02',63,1,0,14400,5,0,0,0,0,0,1,1,1,NULL),
('Zone_110_T0_Numiqol_Roamer_03',7,7,2040,2040,'Zone_110_T0_Numiqol_Roamer_03',63,1,0,14400,5,0,0,0,0,0,1,1,1,NULL),
('Zone_110_T0_Numiqol_Roamer_04',7,7,2040,2040,'Zone_110_T0_Numiqol_Roamer_03',63,1,0,14400,5,0,0,0,0,0,1,1,1,NULL),
('Zone_110_T0_Numiqol_Roamer_05',7,7,2040,2040,'Zone_110_T0_Numiqol_Roamer_03',63,1,0,14400,5,0,0,0,0,0,1,1,1,NULL),
('Zone_110_T0_Numiqol_Roamer_06',7,7,2040,2040,'Zone_110_T0_Numiqol_Roamer_06',63,1,0,28800,0,0,0,0,0,0,1,1,1,NULL);

CREATE TABLE #FLOCKS(
	[name] [varchar](128) NOT NULL,
	presenceName [varchar](128) NOT NULL,
	definitionName [varchar](128) NOT NULL,
	[flockmembercount] [int] NOT NULL,
	[spawnoriginX] [int] NOT NULL,
	[spawnoriginY] [int] NOT NULL,
	[spawnrangeMin] [int] NOT NULL,
	[spawnrangeMax] [int] NOT NULL,
	[respawnseconds] [int] NOT NULL,
	[totalspawncount] [int] NOT NULL,
	[homerange] [int] NOT NULL,
	[note] [nvarchar](2000) NULL,
	[respawnmultiplierlow] [float] NOT NULL,
	[enabled] [bit] NOT NULL,
	[iscallforhelp] [bit] NOT NULL,
	[behaviorType] [int] NOT NULL,
	[npcSpecialType] [int] NOT NULL,
);
INSERT INTO #FLOCKS (name, presenceName, definitionName, flockmembercount, spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, enabled, iscallforhelp, behaviorType, npcSpecialType)
VALUES
('Zone_110_T0_Numiqol_Roamer_01_Kain','Zone_110_T0_Numiqol_Roamer_01','def_npc_kain_rank5_elite',2,1381,599,2,5,14400,0,50,'Zone_110_T0_Numiqol_Roamer_01_Kain',1,1,1,2,0),
('Zone_110_T0_Numiqol_Roamer_01_Arbalest','Zone_110_T0_Numiqol_Roamer_01','def_npc_arbalest_rank3_elite',3,1381,599,2,5,14400,0,50,'Zone_110_T0_Numiqol_Roamer_01_Arbalest',1,1,1,2,0),
('Zone_110_T0_Numiqol_Roamer_01_Mesmer','Zone_110_T0_Numiqol_Roamer_01','def_npc_mesmer_rank5_elite',1,1381,599,2,5,14400,0,50,'Zone_110_T0_Numiqol_Roamer_01_Mesmer',1,1,1,2,0),
('Zone_110_T0_Numiqol_Roamer_01_Vagabond','Zone_110_T0_Numiqol_Roamer_01','def_npc_vagabond_jammer_rank5',1,1381,599,2,5,14400,0,50,'Zone_110_T0_Numiqol_Roamer_01_Vagabond',1,1,1,2,0),
('Zone_110_T0_Numiqol_Roamer_01_Lithus','Zone_110_T0_Numiqol_Roamer_01','def_npc_lithus_basic_rank5',2,1381,599,2,5,14400,0,50,'Zone_110_T0_Numiqol_Roamer_01_Lithus',1,1,1,2,0),
('Zone_110_T0_Numiqol_Roamer_02_Yagel','Zone_110_T0_Numiqol_Roamer_02','def_npc_yagel_dps_rank5',2,1381,599,2,5,14400,0,50,'Zone_110_T0_Numiqol_Roamer_02_Yagel',1,1,1,2,0),
('Zone_110_T0_Numiqol_Roamer_02_Cam','Zone_110_T0_Numiqol_Roamer_02','def_npc_cameleon_ewjammer_rank5',1,1381,599,2,5,14400,0,50,'Zone_110_T0_Numiqol_Roamer_02_Cam',1,1,1,2,0),
('Zone_110_T0_Numiqol_Roamer_02_Arbalest','Zone_110_T0_Numiqol_Roamer_02','def_npc_arbalest_rank3_elite',3,1381,599,2,5,14400,0,50,'Zone_110_T0_Numiqol_Roamer_02_Arbalest',1,1,1,2,0),
('Zone_110_T0_Numiqol_Roamer_02_Sequer','Zone_110_T0_Numiqol_Roamer_02','def_npc_sequer_basic_rank5',2,1381,599,2,5,14400,0,50,'Zone_110_T0_Numiqol_Roamer_02_Sequer',1,1,1,2,0),
('Zone_110_T0_Numiqol_Roamer_02_Kain','Zone_110_T0_Numiqol_Roamer_02','def_npc_kain_rank5_elite',1,1381,599,2,5,14400,0,50,'Zone_110_T0_Numiqol_Roamer_02_Kain',1,1,1,2,0),
('Zone_110_T0_Numiqol_Roamer_03_Lithus','Zone_110_T0_Numiqol_Roamer_03','def_npc_lithus_basic_rank5',3,997,719,0,2,14400,0,50,'Zone_110_T0_Numiqol_Roamer_03_Lithus',0,1,1,2,0),
('Zone_110_T0_Numiqol_Roamer_03_Scarab','Zone_110_T0_Numiqol_Roamer_03','def_npc_scarab_basic_rank5',2,997,719,0,2,14400,0,50,'Zone_110_T0_Numiqol_Roamer_03_Scarab',0,1,1,2,0),
('Zone_110_T0_Numiqol_Roamer_03_Sequer','Zone_110_T0_Numiqol_Roamer_03','def_npc_sequer_basic_rank5',4,997,719,0,2,14400,0,50,'Zone_110_T0_Numiqol_Roamer_03_Sequer',0,1,1,2,0),
('Zone_110_T0_Numiqol_Roamer_03_Mesmer','Zone_110_T0_Numiqol_Roamer_03','def_npc_mesmer_rank5_elite',2,997,719,0,2,14400,0,50,'Zone_110_T0_Numiqol_Roamer_03_Mesmer',0,1,1,2,0),
('Zone_110_T0_Numiqol_Roamer_03_Vagabond','Zone_110_T0_Numiqol_Roamer_03','def_npc_vagabond_jammer_rank5',1,997,719,0,2,14400,0,50,'Zone_110_T0_Numiqol_Roamer_03_Vagabond',0,1,1,2,0),
('Zone_110_T0_Numiqol_Roamer_04_Arbalest','Zone_110_T0_Numiqol_Roamer_04','def_npc_roaming_arbalest_alpha',2,754,1584,2,5,14400,0,50,'Zone_110_T0_Numiqol_Roamer_04_Arbalest',1,1,1,2,0),
('Zone_110_T0_Numiqol_Roamer_04_Mesmer','Zone_110_T0_Numiqol_Roamer_04','def_npc_roaming_mesmer_beta',1,754,1584,2,5,14400,0,50,'Zone_110_T0_Numiqol_Roamer_04_Mesmer',1,1,1,2,0),
('Zone_110_T0_Numiqol_Roamer_04_Kain','Zone_110_T0_Numiqol_Roamer_04','def_npc_roaming_kain_alpha',2,754,1584,2,5,14400,0,50,'Zone_110_T0_Numiqol_Roamer_04_Kain',1,1,1,2,0),
('Zone_110_T0_Numiqol_Roamer_05_Arbalest','Zone_110_T0_Numiqol_Roamer_05','def_npc_roaming_arbalest_alpha',3,519,1377,2,5,14400,0,50,'Zone_110_T0_Numiqol_Roamer_05_Arbalest',1,1,1,2,0),
('Zone_110_T0_Numiqol_Roamer_05_Kain','Zone_110_T0_Numiqol_Roamer_05','def_npc_roaming_kain_beta',2,519,1377,2,5,14400,0,50,'Zone_110_T0_Numiqol_Roamer_05_Kain',1,1,1,2,0),
('Zone_110_T0_Numiqol_Roamer_06_pitboss','Zone_110_T0_Numiqol_Roamer_06','def_npc_Gamma_Numiquol_Pitboss',1,1003,1011,2,5,28800,0,50,'Zone_110_T0_Numiqol_Roamer_06_pitboss',1,1,1,2,1),
('Zone_110_T0_Numiqol_Roamer_06_Mesmer','Zone_110_T0_Numiqol_Roamer_06','def_npc_mesmer_guard',2,1003,1011,2,5,28800,0,50,'Zone_110_T0_Numiqol_Roamer_06_mesmer',1,1,1,2,0),
('Zone_110_T0_Numiqol_Roamer_06_kain','Zone_110_T0_Numiqol_Roamer_06','def_npc_kain_guard',2,1003,1011,2,5,28800,0,50,'Zone_110_T0_Numiqol_Roamer_06_kain',1,1,1,2,0);


--SELECT * FROM npcbossinfo WHERE flockid IN (SELECT id FROM npcflock WHERE presenceid IN (SELECT id FROM npcpresence WHERE spawnid=@SPAWN_ID);
--SELECT * FROM npcflock WHERE presenceid IN (SELECT id FROM npcpresence WHERE spawnid=@SPAWN_ID);
--SELECT * FROM npcpresence WHERE spawnid=@SPAWN_ID;

--SELECT * FROM entitydefaults WHERE definition IN (SELECT def FROM #NPCDEFS);
--SELECT * FROM aggregatevalues WHERE definition IN (SELECT def FROM #NPCDEFS);
--SELECT * FROM npcloot WHERE definition IN (SELECT def FROM #NPCDEFS);
--SELECT * FROM robottemplates WHERE id IN (SELECT templateid FROM robottemplaterelation WHERE definition IN (SELECT def FROM #NPCDEFS));
--SELECT * FROM robottemplaterelation WHERE definition IN (SELECT def FROM #NPCDEFS);

DELETE FROM npcbossinfo WHERE flockid IN (SELECT id FROM npcflock WHERE presenceid IN (SELECT id FROM npcpresence WHERE spawnid=@SPAWN_ID));
DELETE FROM npcflock WHERE presenceid IN (SELECT id FROM npcpresence WHERE spawnid=@SPAWN_ID);
DELETE FROM npcpresence WHERE spawnid=@SPAWN_ID;

DELETE FROM robottemplaterelation WHERE definition IN (SELECT def FROM #NPCDEFS);
DELETE FROM robottemplates WHERE name IN (SELECT templateName FROM #NPCDEFS);
DELETE FROM npcloot WHERE definition IN (SELECT def FROM #NPCDEFS);
DELETE FROM aggregatevalues WHERE definition IN (SELECT def FROM #NPCDEFS);
DELETE FROM entitydefaults WHERE definition IN (SELECT def FROM #NPCDEFS);


------------NPC Boss definition and templates and loot-----------------
SET IDENTITY_INSERT entitydefaults ON;
INSERT INTO entitydefaults (definition, definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
SELECT def, defName, 1, 1024, 1423, '', 'Boss definition', 1, 0, 0, 0, 100, defName+'_desc', 0, NULL, NULL
FROM #NPCDEFS;
SET IDENTITY_INSERT entitydefaults OFF;

INSERT INTO robottemplates (name, description, note)
SELECT templateName, templateDescription, templateNote FROM #NPCDEFS;

INSERT INTO robottemplaterelation(definition, templateid, itemscoresum, raceid, missionlevel, missionleveloverride, killep, note)
SELECT
	def, (SELECT TOP 1 id FROM robottemplates WHERE name=templateName), 0, 0, NULL, NULL, ep, templateNote
FROM #NPCDEFS;

INSERT INTO aggregatevalues (definition, field, value)
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defName), 
	(SELECT TOP 1 id FROM aggregatefields WHERE name=fieldName), 
	val 
FROM #NPCMODS;

INSERT INTO npcloot (definition, lootdefinition, minquantity, quantity, probability, dontdamage, repackaged)
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defName),
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=lootName),
	minQuantity, maxQuantity, probability, dontDmg, repackaged
FROM #NPCLOOTS;

------------NPC Boss definition complete-----------------


INSERT INTO npcpresence ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds],[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull],[izgroupid])
SELECT 
	name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid
FROM #PRES;


INSERT INTO npcflock ([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax]
           ,[respawnseconds],[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType],[npcSpecialType])
SELECT 
	f.name, (SELECT TOP 1 id FROM npcpresence WHERE name=f.presenceName),
	f.flockmembercount, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=f.definitionName),
	f.spawnoriginX, f.spawnoriginY, f.spawnrangeMin, f.spawnrangeMax, f.respawnseconds, f.totalspawncount,
	f.homerange, f.note, f.respawnmultiplierlow, f.enabled, f.iscallforhelp, f.behaviorType, f.npcSpecialType
FROM #FLOCKS f;

INSERT INTO npcbossinfo(flockid, respawnNoiseFactor, lootSplitFlag, overrideRelations, customAggressMessage, customDeathMessage, isAnnounced) VALUES
((SELECT TOP 1 id FROM npcflock WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@BOSS_NAME)),
0.15, 1, 0, 'GET REKT NOOB', 'Whatever, Im not bitter', 1);

DROP TABLE IF EXISTS #PRES;
DROP TABLE IF EXISTS #FLOCKS;
DROP TABLE IF EXISTS #NPCDEFS;
DROP TABLE IF EXISTS #NPCMODS;
DROP TABLE IF EXISTS #NPCLOOTS;
GO