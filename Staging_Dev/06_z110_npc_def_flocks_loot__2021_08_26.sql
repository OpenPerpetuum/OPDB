USE [perpetuumsa]
GO

-----------------------------------------------------------
-- Gamma nuimqol T0 npcs
--
-- Date modified: 2021/09/02
-----------------------------------------------------------

DECLARE @ZONE_ID_VALUE AS INT = 110;
DECLARE @ZONE_ID AS VARCHAR(12) = CONVERT(VARCHAR(12), @ZONE_ID_VALUE);
DECLARE @BOSS_NAME AS VARCHAR(128) = 'def_npc_Gamma_Numiquol_Pitboss';
DECLARE @MINI_BOSS_NAME AS VARCHAR(128) = 'def_npc_Gamma_Numiquol_MiniBoss';
DECLARE @SPAWN_ID AS INT = (SELECT TOP 1 spawnid FROM zones WHERE id=@ZONE_ID_VALUE);

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
(7370,@BOSS_NAME,'Gamma_numiquol_pitboss',
'#robot=i1778#head=i1775#chassis=i1776#leg=i1777#container=i150#headModules=[|m0=[|definition=ib1e|slot=i1|ammoDefinition=ib34|ammoQuantity=ia]|m1=[|definition=idba|slot=i2]|m2=[|definition=idca|slot=i3]|m3=[|definition=idca|slot=i4]]#chassisModules=[|m0=[|definition=i3e9|slot=i1|ammoDefinition=iff|ammoQuantity=i32]|m1=[|definition=i3e9|slot=i2|ammoDefinition=i100|ammoQuantity=i32]|m2=[|definition=i3e9|slot=i3|ammoDefinition=i101|ammoQuantity=i32]|m3=[|definition=i3e9|slot=i4|ammoDefinition=i102|ammoQuantity=i32]|m4=[|definition=i3e9|slot=i5|ammoDefinition=i100|ammoQuantity=i32]|m5=[|definition=i3e9|slot=i6|ammoDefinition=i102|ammoQuantity=i32]]#legModules=[|m0=[|definition=i11|slot=i1]|m1=[|definition=i11|slot=i2]|m2=[|definition=i14|slot=i3]|m3=[|definition=i3b7|slot=i4]|m4=[|definition=i28a|slot=i5|ammoDefinition=i298|ammoQuantity=ia]]',
'Gamma_numiquol_pitboss',3000),
(7371,@MINI_BOSS_NAME,'Gamma_numiquol_miniboss',
'#robot=id5#head=i82#chassis=i83#leg=i84#container=i14c#headModules=[|m0=[|definition=i424|slot=i1]|m1=[|definition=i424|slot=i2]|m2=[|definition=i424|slot=i3]|m3=[|definition=i424|slot=i4]|m4=[|definition=i31|slot=i5]]#chassisModules=[|m0=[|definition=i43|slot=i1|ammoDefinition=i982|ammoQuantity=i64]|m1=[|definition=i43|slot=i2|ammoDefinition=i982|ammoQuantity=i64]|m2=[|definition=i43|slot=i3|ammoDefinition=i982|ammoQuantity=i64]|m3=[|definition=i43|slot=i4|ammoDefinition=i982|ammoQuantity=i64]|m4=[|definition=i43|slot=i5|ammoDefinition=i982|ammoQuantity=i64]|m5=[|definition=i43|slot=i6|ammoDefinition=i982|ammoQuantity=i64]|m6=[|definition=i0|slot=i7]]#legModules=[|m0=[|definition=i286|slot=i1]|m1=[|definition=i286|slot=i2]|m2=[|definition=i289|slot=i3|ammoDefinition=i298|ammoQuantity=ia]|m3=[|definition=i13|slot=i4]|m4=[|definition=i13|slot=i5]|m5=[|definition=i13|slot=i6]]',
'Gamma_numiquol_miniboss',350);

CREATE TABLE #NPCMODS(
	defName varchar(128),
	fieldName varchar(128),
	val float
);
INSERT INTO #NPCMODS(defName, fieldName, val) VALUES
(@BOSS_NAME,'armor_max_modifier',7.5),
(@BOSS_NAME,'armor_repair_amount_modifier',2.55),
(@BOSS_NAME,'armor_repair_cycle_time_modifier',0.67),
(@BOSS_NAME,'core_max_modifier',5.25),
(@BOSS_NAME,'core_recharge_time_modifier',0.65),
(@BOSS_NAME,'cpu_max_modifier',2.5),
(@BOSS_NAME,'damage_modifier',5.5),
(@BOSS_NAME,'ecm_strength_modifier',3),
(@BOSS_NAME,'falloff_modifier',5.5),
(@BOSS_NAME,'locked_targets_max_bonus',10),
(@BOSS_NAME,'locking_range_modifier',7),
(@BOSS_NAME,'locking_time_modifier',1.25),
(@BOSS_NAME,'missile_cycle_time_modifier',1),
(@BOSS_NAME,'optimal_range_modifier',4.5),
(@BOSS_NAME,'powergrid_max_modifier',3.5),
(@BOSS_NAME,'resist_chemical',600),
(@BOSS_NAME,'resist_explosive',600),
(@BOSS_NAME,'resist_kinetic',600),
(@BOSS_NAME,'resist_thermal',600),
(@BOSS_NAME,'speed_max_modifier',1.75),
(@BOSS_NAME,'sensor_strength_modifier',200),
(@BOSS_NAME,'turret_cycle_time_modifier',1),
(@BOSS_NAME,'received_repaired_modifier',1.25),
(@BOSS_NAME,'detection_strength_modifier',50),
(@BOSS_NAME,'missile_falloff_modifier',5.5),

(@MINI_BOSS_NAME,'armor_max_modifier',5.5),
(@MINI_BOSS_NAME,'armor_repair_amount_modifier',2.55),
(@MINI_BOSS_NAME,'armor_repair_cycle_time_modifier',0.67),
(@MINI_BOSS_NAME,'core_max_modifier',4.25),
(@MINI_BOSS_NAME,'core_recharge_time_modifier',0.65),
(@MINI_BOSS_NAME,'cpu_max_modifier',2.5),
(@MINI_BOSS_NAME,'damage_modifier',4.5),
(@MINI_BOSS_NAME,'ecm_strength_modifier',3),
(@MINI_BOSS_NAME,'falloff_modifier',5.5),
(@MINI_BOSS_NAME,'locked_targets_max_bonus',10),
(@MINI_BOSS_NAME,'locking_range_modifier',5),
(@MINI_BOSS_NAME,'locking_time_modifier',1.25),
(@MINI_BOSS_NAME,'missile_cycle_time_modifier',1),
(@MINI_BOSS_NAME,'optimal_range_modifier',4.5),
(@MINI_BOSS_NAME,'powergrid_max_modifier',3.5),
(@MINI_BOSS_NAME,'resist_chemical',500),
(@MINI_BOSS_NAME,'resist_explosive',500),
(@MINI_BOSS_NAME,'resist_kinetic',500),
(@MINI_BOSS_NAME,'resist_thermal',500),
(@MINI_BOSS_NAME,'speed_max_modifier',1.25),
(@MINI_BOSS_NAME,'sensor_strength_modifier',200),
(@MINI_BOSS_NAME,'turret_cycle_time_modifier',1),
(@MINI_BOSS_NAME,'received_repaired_modifier',1.25),
(@MINI_BOSS_NAME,'detection_strength_modifier',50),
(@MINI_BOSS_NAME,'missile_falloff_modifier',5.5);


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
(@BOSS_NAME,'def_boost_ep_t0',2,5,1,1,1),
(@BOSS_NAME,'def_boost_ep_t1',2,4,1,1,1),
(@BOSS_NAME,'def_common_reactor_plasma',80000,200000,1,1,1),
--(@BOSS_NAME,'def_gropho_mk2_A_CT_capsule',0,0,0,1,1),
--(@BOSS_NAME,'def_gropho_mk2_A_CT_capsule',0,0,0,1,1),
--(@BOSS_NAME,'def_gropho_mk2_A_CT_capsule',0,0,0,1,1),
(@BOSS_NAME,'def_kernel_common',80000,100000,1,1,1),
(@BOSS_NAME,'def_kernel_hitech',80000,100000,1,1,1),
(@BOSS_NAME,'def_kernel_nuimqol',350000,400000,1,1,1),
--(@BOSS_NAME,'def_kernel_pelistal',0,0,0,1,1),
--(@BOSS_NAME,'def_kernel_thelodica',0,0,0,1,1),
(@BOSS_NAME,'def_mesmer_mk2_A_CT_capsule',1,1,0.5,1,1),
(@BOSS_NAME,'def_mesmer_mk2_A_CT_capsule',1,1,0.5,1,1),
(@BOSS_NAME,'def_mesmer_mk2_A_CT_capsule',1,1,0.5,1,1),
(@BOSS_NAME,'def_named2_gang_assist_coordinated_maneuvering_module',1,1,0.11,0,1),
(@BOSS_NAME,'def_named2_gang_assist_coordinated_maneuvering_module',1,1,0.11,0,1),
(@BOSS_NAME,'def_named2_gang_assist_coordinated_maneuvering_module',1,1,0.11,0,1),
(@BOSS_NAME,'def_named2_gang_assist_core_management_module',1,1,0.11,0,1),
(@BOSS_NAME,'def_named2_gang_assist_core_management_module',1,1,0.11,0,1),
(@BOSS_NAME,'def_named2_gang_assist_core_management_module',1,1,0.11,0,1),
(@BOSS_NAME,'def_named2_gang_assist_defense_module',1,1,0.11,0,1),
(@BOSS_NAME,'def_named2_gang_assist_defense_module',1,1,0.11,0,1),
(@BOSS_NAME,'def_named2_gang_assist_defense_module',1,1,0.11,0,1),
(@BOSS_NAME,'def_named2_gang_assist_ewar_range_module',1,1,0.11,0,1),
(@BOSS_NAME,'def_named2_gang_assist_ewar_range_module',1,1,0.11,0,1),
(@BOSS_NAME,'def_named2_gang_assist_ewar_range_module',1,1,0.11,0,1),
(@BOSS_NAME,'def_named2_gang_assist_fast_extraction_module',1,1,0.11,0,1),
(@BOSS_NAME,'def_named2_gang_assist_fast_extraction_module',1,1,0.11,0,1),
(@BOSS_NAME,'def_named2_gang_assist_fast_extraction_module',1,1,0.11,0,1),
(@BOSS_NAME,'def_named2_gang_assist_industry_module',1,1,0.11,0,1),
(@BOSS_NAME,'def_named2_gang_assist_industry_module',1,1,0.11,0,1),
(@BOSS_NAME,'def_named2_gang_assist_industry_module',1,1,0.11,0,1),
(@BOSS_NAME,'def_named2_gang_assist_information_module',1,1,0.11,0,1),
(@BOSS_NAME,'def_named2_gang_assist_information_module',1,1,0.11,0,1),
(@BOSS_NAME,'def_named2_gang_assist_information_module',1,1,0.11,0,1),
(@BOSS_NAME,'def_named2_gang_assist_maintance_module',1,1,0.11,0,1),
(@BOSS_NAME,'def_named2_gang_assist_maintance_module',1,1,0.11,0,1),
(@BOSS_NAME,'def_named2_gang_assist_maintance_module',1,1,0.11,0,1),
(@BOSS_NAME,'def_named2_gang_assist_precision_firing_module',1,1,0.11,0,1),
(@BOSS_NAME,'def_named2_gang_assist_precision_firing_module',1,1,0.11,0,1),
(@BOSS_NAME,'def_named2_gang_assist_precision_firing_module',1,1,0.11,0,1),
(@BOSS_NAME,'def_named2_gang_assist_shared_dataprocessing_module',1,1,0.11,0,1),
(@BOSS_NAME,'def_named2_gang_assist_shared_dataprocessing_module',1,1,0.11,0,1),
(@BOSS_NAME,'def_named2_gang_assist_shared_dataprocessing_module',1,1,0.11,0,1),
(@BOSS_NAME,'def_named2_gang_assist_shield_calculation_module',1,1,0.11,0,1),
(@BOSS_NAME,'def_named2_gang_assist_shield_calculation_module',1,1,0.11,0,1),
(@BOSS_NAME,'def_named2_gang_assist_shield_calculation_module',1,1,0.11,0,1),
(@BOSS_NAME,'def_named2_gang_assist_siege_module',1,1,0.11,0,1),
(@BOSS_NAME,'def_named2_gang_assist_siege_module',1,1,0.11,0,1),
(@BOSS_NAME,'def_named2_gang_assist_siege_module',1,1,0.11,0,1),
(@BOSS_NAME,'def_named2_gang_assist_speed_module',1,1,0.11,0,1),
(@BOSS_NAME,'def_named2_gang_assist_speed_module',1,1,0.11,0,1),
(@BOSS_NAME,'def_named2_gang_assist_speed_module',1,1,0.11,0,1),
(@BOSS_NAME,'def_nuimqol_reactor_plasma',375000,500000,1,1,1),
(@BOSS_NAME,'def_pelistal_reactor_plasma',0,0,1,1,1),
(@BOSS_NAME,'def_reactore_core_assault',1,5,1,1,1),
(@BOSS_NAME,'def_reactore_core_heavymech',1,5,1,1,1),
(@BOSS_NAME,'def_reactore_core_mech',1,5,1,1,1),
(@BOSS_NAME,'def_reactore_core_runner',1,5,1,1,1),
(@BOSS_NAME,'def_research_kit_10',2,5,1,1,1),
(@BOSS_NAME,'def_research_kit_9',2,5,1,1,1),
(@BOSS_NAME,'def_robotshard_common_advanced',500,5000,1,1,1),
(@BOSS_NAME,'def_robotshard_common_basic',500,5000,1,1,1),
(@BOSS_NAME,'def_robotshard_common_expert',500,5000,1,1,1),
(@BOSS_NAME,'def_robotshard_nuimqol_advanced',500,5000,1,1,1),
(@BOSS_NAME,'def_robotshard_nuimqol_basic',500,5000,1,1,1),
(@BOSS_NAME,'def_robotshard_nuimqol_expert',500,5000,1,1,1),
--(@BOSS_NAME,'def_robotshard_pelistal_advanced',0,0,0,1,1),
--(@BOSS_NAME,'def_robotshard_pelistal_basic',0,0,0,1,1),
--(@BOSS_NAME,'def_robotshard_pelistal_expert',0,0,0,1,1),
--(@BOSS_NAME,'def_robotshard_thelodica_advanced',0,0,0,1,1),
--(@BOSS_NAME,'def_robotshard_thelodica_basic',0,0,0,1,1),
--(@BOSS_NAME,'def_robotshard_thelodica_expert',0,0,0,1,1),
(@BOSS_NAME,'def_scarab_mk2_A_CT_capsule',1,1,0.5,1,1),
(@BOSS_NAME,'def_scarab_mk2_A_CT_capsule',1,1,0.5,1,1),
(@BOSS_NAME,'def_scarab_mk2_A_CT_capsule',1,1,0.5,1,1),
--(@BOSS_NAME,'def_seth_mk2_A_CT_capsule',0,0,0,1,1),
--(@BOSS_NAME,'def_seth_mk2_A_CT_capsule',0,0,0,1,1),
--(@BOSS_NAME,'def_seth_mk2_A_CT_capsule',0,0,0,1,1),
--(@BOSS_NAME,'def_thelodica_reactor_plasma',0,0,0,1,1),
(@BOSS_NAME,'def_boost_ep_t3',1,2,1,1,1),
(@BOSS_NAME,'def_boost_ep_t2',2,3,1,1,1),
(@BOSS_NAME,'def_kain_mk2_A_CT_capsule',1,1,0.5,1,1),
(@BOSS_NAME,'def_kain_mk2_A_CT_capsule',1,1,0.5,1,1),
(@BOSS_NAME,'def_kain_mk2_A_CT_capsule',1,1,0.5,1,1),
(@BOSS_NAME,'def_vagabond_mk2_A_CT_capsule',1,1,0.5,1,1),
(@BOSS_NAME,'def_vagabond_mk2_A_CT_capsule',1,1,0.5,1,1),
(@BOSS_NAME,'def_vagabond_mk2_A_CT_capsule',1,1,0.5,1,1),
--miniboss loots
(@MINI_BOSS_NAME,'def_named3_medium_armor_repairer',1,1,0.5,1,1),
(@MINI_BOSS_NAME,'def_named3_thrm_armor_hardener',1,1,0.5,1,1),
(@MINI_BOSS_NAME,'def_named3_damage_mod_railgun',1,1,0.5,1,1),
(@MINI_BOSS_NAME,'def_named3_medium_railgun',1,1,0.5,1,1),

(@MINI_BOSS_NAME,'def_kernel_common',15000,30000,1,1,1),
(@MINI_BOSS_NAME,'def_kernel_hitech',15000,30000,1,1,1),
(@MINI_BOSS_NAME,'def_kernel_nuimqol',80000,100000,1,1,1),

(@MINI_BOSS_NAME,'def_nuimqol_reactor_plasma',100000,150000,1,1,1),
(@MINI_BOSS_NAME,'def_common_reactor_plasma',100000,150000,1,1,1),

(@MINI_BOSS_NAME,'def_reactore_core_assault',1,1,1,1,1),
(@MINI_BOSS_NAME,'def_reactore_core_heavymech',1,1,1,1,1),
(@MINI_BOSS_NAME,'def_reactore_core_mech',1,1,1,1,1),
(@MINI_BOSS_NAME,'def_reactore_core_runner',1,1,1,1,1),
(@MINI_BOSS_NAME,'def_research_kit_10',1,1,0.5,1,1),
(@MINI_BOSS_NAME,'def_research_kit_9',2,2,0.75,1,1),
(@MINI_BOSS_NAME,'def_research_kit_8',2,3,0.9,1,1),
(@MINI_BOSS_NAME,'def_robotshard_common_advanced',500,1500,1,1,1),
(@MINI_BOSS_NAME,'def_robotshard_common_basic',500,1500,1,1,1),
(@MINI_BOSS_NAME,'def_robotshard_common_expert',500,500,1,1,1),
(@MINI_BOSS_NAME,'def_robotshard_nuimqol_advanced',500,1500,1,1,1),
(@MINI_BOSS_NAME,'def_robotshard_nuimqol_basic',500,1500,1,1,1),
(@MINI_BOSS_NAME,'def_robotshard_nuimqol_expert',500,500,1,1,1);



CREATE TABLE #PRES(
	[name] [varchar](128) NOT NULL,
	[topx] [int] NOT NULL,
	[topy] [int] NOT NULL,
	[bottomx] [int] NOT NULL,
	[bottomy] [int] NOT NULL,
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
INSERT INTO #PRES (name, topx, topy, bottomx, bottomy, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid)
VALUES
('Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_01',7,7,2040,2040,@SPAWN_ID,1,0,14400,5,0,0,0,0,0,1,1,1,NULL),
('Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_02',7,7,2040,2040,@SPAWN_ID,1,0,14400,5,0,0,0,0,0,1,1,1,NULL),
('Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_03',7,7,2040,2040,@SPAWN_ID,1,0,14400,5,0,0,0,0,0,1,1,1,NULL),
('Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_04',7,7,2040,2040,@SPAWN_ID,1,0,14400,5,0,0,0,0,0,1,1,1,NULL),
('Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_05',7,7,2040,2040,@SPAWN_ID,1,0,14400,5,0,0,0,0,0,1,1,1,NULL),
('Zone_'+@ZONE_ID+'_T0_Numiqol_Static_06',7,7,2040,2040,@SPAWN_ID,1,0,400000,0,0,0,0,0,0,1,1,1,NULL),--STATIC BOSS PRES
('Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_07',7,7,2040,2040,@SPAWN_ID,1,0,14400,5,0,0,0,0,0,1,1,1,NULL),
('Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_08',7,7,2040,2040,@SPAWN_ID,1,0,14400,5,0,0,0,0,0,1,1,1,NULL),
('Zone_'+@ZONE_ID+'_T0_Numiqol_RoamerMiniBoss_09',7,7,2040,2040,@SPAWN_ID,1,0,20000,5,0,0,0,0,0,1,1,1,NULL);


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
	[respawnmultiplierlow] [float] NOT NULL,
	[enabled] [bit] NOT NULL,
	[iscallforhelp] [bit] NOT NULL,
	[behaviorType] [int] NOT NULL,
	[npcSpecialType] [int] NOT NULL,
);
INSERT INTO #FLOCKS (name, presenceName, definitionName, flockmembercount, spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, respawnmultiplierlow, enabled, iscallforhelp, behaviorType, npcSpecialType)
VALUES
('Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_01_Kain','Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_01','def_npc_kain_rank5_elite',2,1381,599,2,5,14400,0,50,1,1,1,2,0),
('Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_01_Arbalest','Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_01','def_npc_arbalest_rank3_elite',3,1381,599,2,5,14400,0,50,1,1,1,2,0),
('Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_01_Mesmer','Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_01','def_npc_mesmer_rank5_elite',1,1381,599,2,5,14400,0,50,1,1,1,2,0),
('Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_01_Vagabond','Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_01','def_npc_vagabond_jammer_rank5',1,1381,599,2,5,14400,0,50,1,1,1,2,0),
('Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_01_Lithus','Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_01','def_npc_lithus_basic_rank5',2,1381,599,2,5,14400,0,50,1,1,1,2,0),
('Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_02_Yagel','Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_02','def_npc_yagel_dps_rank5',2,1381,599,2,5,14400,0,50,1,1,1,2,0),
('Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_02_Cam','Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_02','def_npc_cameleon_ewjammer_rank5',1,1381,599,2,5,14400,0,50,1,1,1,2,0),
('Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_02_Arbalest','Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_02','def_npc_arbalest_rank3_elite',3,1381,599,2,5,14400,0,50,1,1,1,2,0),
('Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_02_Sequer','Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_02','def_npc_sequer_basic_rank5',2,1381,599,2,5,14400,0,50,1,1,1,2,0),
('Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_02_Kain','Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_02','def_npc_kain_rank5_elite',1,1381,599,2,5,14400,0,50,1,1,1,2,0),
('Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_03_Lithus','Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_03','def_npc_lithus_basic_rank5',3,997,719,0,2,14400,0,50,0,1,1,2,0),
('Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_03_Scarab','Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_03','def_npc_scarab_basic_rank5',2,997,719,0,2,14400,0,50,0,1,1,2,0),
('Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_03_Sequer','Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_03','def_npc_sequer_basic_rank5',4,997,719,0,2,14400,0,50,0,1,1,2,0),
('Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_03_Mesmer','Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_03','def_npc_mesmer_rank5_elite',2,997,719,0,2,14400,0,50,0,1,1,2,0),
('Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_03_Vagabond','Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_03','def_npc_vagabond_jammer_rank5',1,997,719,0,2,14400,0,50,0,1,1,2,0),
('Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_04_Arbalest','Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_04','def_npc_roaming_arbalest_alpha',2,754,1584,2,5,14400,0,50,1,1,1,2,0),
('Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_04_Mesmer','Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_04','def_npc_roaming_mesmer_beta',1,754,1584,2,5,14400,0,50,1,1,1,2,0),
('Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_04_Kain','Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_04','def_npc_roaming_kain_alpha',2,754,1584,2,5,14400,0,50,1,1,1,2,0),
('Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_05_Arbalest','Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_05','def_npc_roaming_arbalest_alpha',3,519,1377,2,5,14400,0,50,1,1,1,2,0),
('Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_05_Kain','Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_05','def_npc_roaming_kain_beta',2,519,1377,2,5,14400,0,50,1,1,1,2,0),
('Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_06_pitboss','Zone_'+@ZONE_ID+'_T0_Numiqol_Static_06',@BOSS_NAME,1,1003,1011,2,5,400000,0,50,1,1,1,2,1),
('Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_06_Mesmer','Zone_'+@ZONE_ID+'_T0_Numiqol_Static_06','def_npc_mesmer_guard',2,1003,1011,2,5,28800,0,50,1,1,1,2,0),
('Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_06_kain','Zone_'+@ZONE_ID+'_T0_Numiqol_Static_06','def_npc_kain_guard',2,1003,1011,2,5,28800,0,50,1,1,1,2,0),

('Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_07_Yagel_niani','Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_07','def_npc_tenpercent_yagel_rank2',2,1003,1011,2,5,14400,0,50,1,1,1,2,0),
('Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_07_Came','Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_07','def_npc_cameleon_interceptor_rank5',2,1003,1011,2,5,14400,0,50,1,1,1,2,0),
('Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_07_Arba','Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_07','def_npc_arbalest_interceptor_rank5',2,1003,1011,2,5,14400,0,50,1,1,1,2,0),
('Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_07_Arba_niani','Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_07','def_npc_percent_arby_rank3',2,1003,1011,2,5,14400,0,50,1,1,1,2,0),

('Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_08_Yagel','Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_08','def_npc_yagel_scout_rank5',3,1003,1011,2,5,14400,0,50,1,1,1,2,0),
('Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_08_Arba','Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_08','def_npc_arbalest_interceptor_rank5',3,1003,1011,2,5,14400,0,50,1,1,1,2,0),
('Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_08_Vaga','Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_08','def_npc_vagabond_jammer_rank5',2,1003,1011,2,5,14400,0,50,1,1,1,2,0),
('Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_08_Arba_mini','Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_08','def_npc_arbalest_miniboss_rank1',2,1003,1011,2,5,14400,0,50,1,1,1,2,0),

('Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_09_miniboss','Zone_'+@ZONE_ID+'_T0_Numiqol_RoamerMiniBoss_09',@MINI_BOSS_NAME,2,1003,1011,2,5,20000,0,50,1,1,1,2,0),
('Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_09_Kain_elite','Zone_'+@ZONE_ID+'_T0_Numiqol_RoamerMiniBoss_09','def_npc_kain_rank5_elite',2,1003,1011,2,5,20000,0,50,1,1,1,2,0),
('Zone_'+@ZONE_ID+'_T0_Numiqol_Roamer_09_Came_mini','Zone_'+@ZONE_ID+'_T0_Numiqol_RoamerMiniBoss_09','def_npc_cameleon_miniboss_rank2',2,1003,1011,2,5,20000,0,50,1,1,1,2,0);


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
	name, topx, topy, bottomx, bottomy, name, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid
FROM #PRES;

INSERT INTO npcflock ([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax]
           ,[respawnseconds],[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType],[npcSpecialType])
SELECT 
	f.name, (SELECT TOP 1 id FROM npcpresence WHERE name=f.presenceName),
	f.flockmembercount, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=f.definitionName),
	f.spawnoriginX, f.spawnoriginY, f.spawnrangeMin, f.spawnrangeMax, f.respawnseconds, f.totalspawncount,
	f.homerange, f.name, f.respawnmultiplierlow, f.enabled, f.iscallforhelp, f.behaviorType, f.npcSpecialType
FROM #FLOCKS f;

INSERT INTO npcbossinfo(flockid, respawnNoiseFactor, lootSplitFlag, overrideRelations, customAggressMessage, customDeathMessage, isAnnounced) VALUES
((SELECT TOP 1 id FROM npcflock WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@BOSS_NAME)),
0.15, 1, 0, 'This file was last editted 9/2/2021', 'oh noes i ded', 1),
((SELECT TOP 1 id FROM npcflock WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@MINI_BOSS_NAME)),
0.15, 1, 0, 'Im just a lil fella, dont mind me', 'maybe someone should think of something for me to say', 0);


DECLARE @reinforceType AS INT = (SELECT TOP 1 id FROM npcreinforcementtypes WHERE name='boss');
DECLARE @BOSSFLOCKNAME VARCHAR(128) = (SELECT TOP 1 name FROM npcflock WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@BOSS_NAME));
DECLARE @MINIBOSSFLOCKNAME VARCHAR(128) = (SELECT TOP 1 name FROM npcflock WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@MINI_BOSS_NAME));

DROP TABLE IF EXISTS #WAVES;
CREATE TABLE #WAVES (
	targetFlockName VARCHAR(100),
	presenceName VARCHAR(100),
	npcDefName VARCHAR(100),
	numInFlock INT,
	thresh FLOAT
);
INSERT INTO #WAVES (targetFlockName, presenceName, npcDefName, numInFlock, thresh) VALUES
(@BOSSFLOCKNAME, 'reinforce_gamma_nuimqol_pitboss_wave_0', 'def_npc_cameleon_miniboss_rank3', 4, 0.2),
(@BOSSFLOCKNAME, 'reinforce_gamma_nuimqol_pitboss_wave_0', 'def_npc_kain_rank5_elite', 2, 0.2),

(@BOSSFLOCKNAME, 'reinforce_gamma_nuimqol_pitboss_wave_1', 'def_npc_vagabond_miniboss_rank3', 4, 0.4),
(@BOSSFLOCKNAME, 'reinforce_gamma_nuimqol_pitboss_wave_1', 'def_npc_kain_rank5_elite', 2, 0.4),
(@BOSSFLOCKNAME, 'reinforce_gamma_nuimqol_pitboss_wave_1', 'def_npc_mesmer_rank5_elite', 2, 0.4),

(@BOSSFLOCKNAME, 'reinforce_gamma_nuimqol_pitboss_wave_2', 'def_npc_percent_mesmer_rank5 ', 6, 0.6),
(@BOSSFLOCKNAME, 'reinforce_gamma_nuimqol_pitboss_wave_2', 'def_npc_pbs_turret_ew_rank1', 1, 0.6),

(@MINIBOSSFLOCKNAME, 'reinforce_gamma_nuimqol_miniboss_wave_0', 'def_npc_arbalest_miniboss_rank1', 2, 0.2),
(@MINIBOSSFLOCKNAME, 'reinforce_gamma_nuimqol_miniboss_wave_0', 'def_npc_cameleon_ewjammer_rank5', 4, 0.2),

(@MINIBOSSFLOCKNAME, 'reinforce_gamma_nuimqol_miniboss_wave_1', 'def_npc_kain_tank_rank5', 2, 0.4),
(@MINIBOSSFLOCKNAME, 'reinforce_gamma_nuimqol_miniboss_wave_1', 'def_npc_cameleon_ewjammer_rank5', 4, 0.4),

(@MINIBOSSFLOCKNAME, 'reinforce_gamma_nuimqol_miniboss_wave_2', 'def_npc_kain_ew_rank5 ', 5, 0.6);

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
	presenceName+npcDefName, (SELECT id FROM npcpresence WHERE name=presenceName), numInFlock, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=npcDefName), 0, 0, 0, 10, 0, 1, 55, presenceName+npcDefName, 0.5, 1, 1, 2, 0
FROM #WAVES;

INSERT INTO dbo.npcreinforcements
	(reinforcementType, targetId, threshold, presenceId, zoneId)
SELECT
	@reinforceType, (SELECT TOP 1 id FROM npcflock WHERE name=targetFlockName), thresh, (SELECT TOP 1 id FROM npcpresence WHERE name=presenceName), NULL
FROM #WAVES;

DROP TABLE IF EXISTS #WAVES;
DROP TABLE IF EXISTS #PRES;
DROP TABLE IF EXISTS #FLOCKS;
DROP TABLE IF EXISTS #NPCDEFS;
DROP TABLE IF EXISTS #NPCMODS;
DROP TABLE IF EXISTS #NPCLOOTS;
GO