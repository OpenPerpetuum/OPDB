USE [perpetuumsa]
GO

----------------------------------------------------------------------------
-- P21
--
-- 01_Entitydef_targRift_insert__2021_02_19.sql
-- 02_categoryflags_inserts__2021_03_03.sql
-- 03_RiftConfig_RiftDestination_CREATE_TABLE_ALTER npcbossinfo__2021_03_02.sql
-- 04_Aggvalues_update_Metis_head__2021_03_15.sql
-- 05_Defs_aggvalues_lightbot_update__2021_02_22.sql
-- 06_Itemshop_update_paintprice__2021_03_24.sql
-- 07_Mineralconfigs_update__2021_03_24.sql
-- 08_Missions_update_levelTrewards__2021_03_21.sql
-- 09_Missiontargettypes_update__2021_03_24.sql
-- 10_NpcFlocks_NVboss_respawn2hr__2021_03_17.sql
-- 11_SyndicateCTs_upserts__2021_03_16.sql
-- 12_Marketitems_npcorder_update_syndicates__2021_03_15.sql
-- 13_Marketitems_npcorder_update_NIANbots__2021_03_15.sql
-- 14_Itemshop_update_syndicatebots__2021_03_15.sql
-- 15_Components_maskerfrags__2021_03_31.sql
-- 16_cw_corporation_updateall__2021_04_02.sql
-- 17_Marketitems_npcorder_insert_RawMaterialBuys__2021_04_03.sql
-- 18_Aggvalues_reinsert_npcmods4bosses__2021_04_04.sql
-- 19_AggFields_update_projectilemod_digits__2021_04_04.sql
-- 20_Anniversarybot_gifts_inserts__2021_04_05.sql
-- ZZ_01_Zones_Insert_71__2021_03_31.sql
-- ZZ_02_Zones_Insert_72__2021_03_31.sql
-- ZZ_03_strongholdexit_npcbossinfo__2021_02_26.sql
-- ZZ_04_Npc_defs_templates_stats_waves__2021_03_31.sql
-- ZZ_05_Elitemods_z71z72_upserts__2020_03_25.sql
-- ZZ_06_npcloot_z71_72__2021_03_31.sql
-- ZZ_71_DECOR_IMPORT_zone71_2021_04_10.sql
-- ZZ_72_DECOR_IMPORT_zone72_2021_04_10.sql
-- ZZ_73_StrghldExitConfigs_newcol__2021_04_10.sql
-- ZZ_74_EntityDefaults_fragVol_update__2021_04_10.sql
--
-- Date modified: 2021/04/10
----------------------------------------------------------------------------


PRINT N'01_Entitydef_targRift_insert__2021_02_19.sql';
USE [perpetuumsa]
GO


DECLARE @riftDefId AS INT = 5998;
DECLARE @riftDefName AS VARCHAR(100) = 'def_rift_targetted_portal'; --must match server enum
DECLARE @attFlags AS BIGINT = 939524098;
DECLARE @catFlags AS BIGINT = 3218;
DECLARE @opts AS VARCHAR(100) = '#height=f6.00';
DECLARE @note AS VARCHAR(100) = 'Rift for targetted jumps';


IF NOT EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@riftDefName)
BEGIN
	SET IDENTITY_INSERT entitydefaults ON;
	INSERT INTO entitydefaults (definition,definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel) VALUES
	(@riftDefId,@riftDefName,1,@attFlags,@catFlags,@opts,@note,1,0,0,0,100,@riftDefName+'_desc',0,NULL,NULL);
	SET IDENTITY_INSERT entitydefaults OFF;
END
ELSE
BEGIN
	UPDATE entitydefaults SET
		attributeflags=@attFlags,
		categoryflags=@catFlags,
		options=@opts,
		note=@note
	WHERE definitionname=@riftDefName;
END

GO


PRINT N'02_categoryflags_inserts__2021_03_03.sql';
USE [perpetuumsa]
GO

DROP TABLE IF EXISTS #CATS;
CREATE TABLE #CATS(
	catName VARCHAR(100),
	catValue BIGINT
);
INSERT INTO #CATS (catName, catValue) VALUES
('cf_datashards', CONVERT(BIGINT, 0x00000694)),
('cf_ep_boosters', CONVERT(BIGINT, 0x0001049b)),
('cf_paints', CONVERT(BIGINT, 0x0002049b)),
('cf_ct_capsules', CONVERT(BIGINT, 0x0003049b)),
('cf_ct_capsules_ammo', CONVERT(BIGINT, 0x000103049b)),
('cf_ct_capsules_ammo_laser', CONVERT(BIGINT, 0x010103049b)),
('cf_ct_capsules_ammo_railgun', CONVERT(BIGINT, 0x020103049b)),
('cf_ct_capsules_ammo_projectile', CONVERT(BIGINT, 0x030103049b)),
('cf_ct_capsules_ammo_missile', CONVERT(BIGINT, 0x040103049b)),
('cf_ct_capsules_equipment', CONVERT(BIGINT, 0x000203049b)),
('cf_ct_capsules_equipment_armor', CONVERT(BIGINT, 0x010203049b)),
('cf_ct_capsules_equipment_ewar', CONVERT(BIGINT, 0x020203049b)),
('cf_ct_capsules_equipment_electronics', CONVERT(BIGINT, 0x030203049b)),
('cf_ct_capsules_equipment_engineering', CONVERT(BIGINT, 0x040203049b)),
('cf_ct_capsules_equipment_industrial', CONVERT(BIGINT, 0x050203049b)),
('cf_ct_capsules_equipment_shield', CONVERT(BIGINT, 0x060203049b)),
('cf_ct_capsules_equipment_weapons', CONVERT(BIGINT, 0x070203049b)),
('cf_ct_capsules_equipment_nexus', CONVERT(BIGINT, 0x080203049b)),
('cf_ct_capsules_robot', CONVERT(BIGINT, 0x000303049b)),
('cf_ct_capsules_robot_pelistal', CONVERT(BIGINT, 0x00010303049b)),
('cf_ct_capsules_robot_pelistal_light', CONVERT(BIGINT, 0x01010303049b)),
('cf_ct_capsules_robot_pelistal_assault', CONVERT(BIGINT, 0x02010303049b)),
('cf_ct_capsules_robot_pelistal_mech', CONVERT(BIGINT, 0x03010303049b)),
('cf_ct_capsules_robot_pelistal_heavymech', CONVERT(BIGINT, 0x04010303049b)),
('cf_ct_capsules_robot_thelodica', CONVERT(BIGINT, 0x00020303049b)),
('cf_ct_capsules_robot_thelodica_light', CONVERT(BIGINT, 0x01020303049b)),
('cf_ct_capsules_robot_thelodica_assault', CONVERT(BIGINT, 0x02020303049b)),
('cf_ct_capsules_robot_thelodica_mech', CONVERT(BIGINT, 0x03020303049b)),
('cf_ct_capsules_robot_thelodica_heavymech', CONVERT(BIGINT, 0x04020303049b)),
('cf_ct_capsules_robot_nuimqol', CONVERT(BIGINT, 0x00030303049b)),
('cf_ct_capsules_robot_nuimqol_light', CONVERT(BIGINT, 0x01030303049b)),
('cf_ct_capsules_robot_nuimqol_assault', CONVERT(BIGINT, 0x02030303049b)),
('cf_ct_capsules_robot_nuimqol_mech', CONVERT(BIGINT, 0x03030303049b)),
('cf_ct_capsules_robot_nuimqol_heavymech', CONVERT(BIGINT, 0x04030303049b)),
('cf_ct_capsules_robot_industrial', CONVERT(BIGINT, 0x00040303049b)),
('cf_ct_capsules_robot_industrial_light', CONVERT(BIGINT, 0x01040303049b)),
('cf_ct_capsules_robot_industrial_assault', CONVERT(BIGINT, 0x02040303049b)),
('cf_ct_capsules_robot_industrial_mech', CONVERT(BIGINT, 0x03040303049b)),
('cf_ct_capsules_robot_industrial_heavymech', CONVERT(BIGINT, 0x04040303049b)),
('cf_ct_capsules_robot_syndicate', CONVERT(BIGINT, 0x00050303049b)),
('cf_ct_capsules_robot_syndicate_light', CONVERT(BIGINT, 0x01050303049b)),
('cf_ct_capsules_robot_syndicate_assault', CONVERT(BIGINT, 0x02050303049b)),
('cf_ct_capsules_robot_syndicate_mech', CONVERT(BIGINT, 0x03050303049b)),
('cf_ct_capsules_robot_syndicate_heavymech',CONVERT(BIGINT, 0x04050303049b)),
('cf_ct_capsules_misc', CONVERT(BIGINT, 0x000403049b));


DELETE FROM categoryFlags WHERE name in (SELECT DISTINCT catName FROM #CATS);
INSERT INTO categoryFlags (value, name, note, hidden, isunique)
SELECT catValue, catName, 'new opp cat', 0, 0 FROM #CATS;

--Print function to generate the enum values for server code
--SELECT CONCAT(name,' = ', CONVERT(VARCHAR(MAX),CONVERT(varbinary(8),value), 1), ',') FROM categoryFlags ORDER BY name;

--Print function to generate the enum values for the resource server
--SELECT CONCAT(
--'  |',(ROW_NUMBER() OVER (ORDER BY name)-1),
--'=[|value=L',
--LOWER(SUBSTRING(CONVERT(VARCHAR(MAX),CONVERT(varbinary(8),value), 2), patindex('%[^0]%',CONVERT(VARCHAR(MAX),CONVERT(varbinary(8),value), 2)), 10)),
--'|name=$',name,
--'|hidden=i',hidden,']') FROM categoryFlags ORDER BY name;

DROP TABLE IF EXISTS #CATS;
GO

USE [perpetuumsa]
GO

UPDATE entitydefaults SET
	categoryflags=(SELECT TOP 1 value FROM categoryFlags WHERE name='cf_paints')
WHERE definitionname like 'def_paint%';

UPDATE entitydefaults SET
	categoryflags=(SELECT TOP 1 value FROM categoryFlags WHERE name='cf_ct_capsules')
WHERE definitionname like '%_CT_capsule';

UPDATE entitydefaults SET
	categoryflags=(SELECT TOP 1 value FROM categoryFlags WHERE name='cf_ep_boosters')
WHERE definitionname like 'def_boost_ep%';

UPDATE entitydefaults SET
	categoryflags=(SELECT TOP 1 value FROM categoryFlags WHERE name='cf_datashards')
WHERE definitionname like 'def_material_boss_z%';


DROP TABLE IF EXISTS #CT_CAPSULE_CATS;
CREATE TABLE #CT_CAPSULE_CATS(
	defName VARCHAR(100),
	catName VARCHAR(100)
);
INSERT INTO #CT_CAPSULE_CATS (defName, catName) VALUES
('def_arbalest_mk2_A_CT_capsule', 'cf_ct_capsules_robot_nuimqol_assault'),
('def_arbalest_mk2_B_CT_capsule', 'cf_ct_capsules_robot_nuimqol_assault'),
('def_arbalest_mk2_C_CT_capsule', 'cf_ct_capsules_robot_nuimqol_assault'),
('def_argano_mk2_A_CT_capsule', 'cf_ct_capsules_robot_industrial_light'),
('def_argano_mk2_B_CT_capsule', 'cf_ct_capsules_robot_industrial_light'),
('def_argano_mk2_C_CT_capsule', 'cf_ct_capsules_robot_industrial_light'),
('def_artemis_mk2_A_CT_capsule', 'cf_ct_capsules_robot_thelodica_mech'),
('def_artemis_mk2_B_CT_capsule', 'cf_ct_capsules_robot_thelodica_mech'),
('def_artemis_mk2_C_CT_capsule', 'cf_ct_capsules_robot_thelodica_mech'),
('def_baphomet_mk2_A_CT_capsule', 'cf_ct_capsules_robot_thelodica_assault'),
('def_baphomet_mk2_B_CT_capsule', 'cf_ct_capsules_robot_thelodica_assault'),
('def_baphomet_mk2_C_CT_capsule', 'cf_ct_capsules_robot_thelodica_assault'),
('def_cameleon_mk2_A_CT_capsule', 'cf_ct_capsules_robot_nuimqol_light'),
('def_cameleon_mk2_B_CT_capsule', 'cf_ct_capsules_robot_nuimqol_light'),
('def_cameleon_mk2_C_CT_capsule', 'cf_ct_capsules_robot_nuimqol_light'),
('def_castel_mk2_A_CT_capsule', 'cf_ct_capsules_robot_pelistal_light'),
('def_castel_mk2_B_CT_capsule', 'cf_ct_capsules_robot_pelistal_light'),
('def_castel_mk2_C_CT_capsule', 'cf_ct_capsules_robot_pelistal_light'),
('def_gargoyle_mk2_A_CT_capsule', 'cf_ct_capsules_robot_industrial_mech'),
('def_gargoyle_mk2_B_CT_capsule', 'cf_ct_capsules_robot_industrial_mech'),
('def_gargoyle_mk2_C_CT_capsule', 'cf_ct_capsules_robot_industrial_mech'),
('def_gropho_mk2_A_CT_capsule', 'cf_ct_capsules_robot_pelistal_heavymech'),
('def_gropho_mk2_B_CT_capsule', 'cf_ct_capsules_robot_pelistal_heavymech'),
('def_gropho_mk2_C_CT_capsule', 'cf_ct_capsules_robot_pelistal_heavymech'),
('def_ictus_mk2_A_CT_capsule', 'cf_ct_capsules_robot_pelistal_mech'),
('def_ictus_mk2_B_CT_capsule', 'cf_ct_capsules_robot_pelistal_mech'),
('def_ictus_mk2_C_CT_capsule', 'cf_ct_capsules_robot_pelistal_mech'),
('def_intakt_mk2_A_CT_capsule', 'cf_ct_capsules_robot_thelodica_light'),
('def_intakt_mk2_B_CT_capsule', 'cf_ct_capsules_robot_thelodica_light'),
('def_intakt_mk2_C_CT_capsule', 'cf_ct_capsules_robot_thelodica_light'),
('def_kain_mk2_A_CT_capsule', 'cf_ct_capsules_robot_nuimqol_mech'),
('def_kain_mk2_B_CT_capsule', 'cf_ct_capsules_robot_nuimqol_mech'),
('def_kain_mk2_C_CT_capsule', 'cf_ct_capsules_robot_nuimqol_mech'),
('def_laird_mk2_A_CT_capsule', 'cf_ct_capsules_robot_industrial_light'),
('def_laird_mk2_B_CT_capsule', 'cf_ct_capsules_robot_industrial_light'),
('def_laird_mk2_C_CT_capsule', 'cf_ct_capsules_robot_industrial_light'),
('def_lithus_mk2_A_CT_capsule', 'cf_ct_capsules_robot_industrial_heavymech'),
('def_lithus_mk2_B_CT_capsule', 'cf_ct_capsules_robot_industrial_heavymech'),
('def_lithus_mk2_C_CT_capsule', 'cf_ct_capsules_robot_industrial_heavymech'),
('def_mesmer_mk2_A_CT_capsule', 'cf_ct_capsules_robot_nuimqol_heavymech'),
('def_mesmer_mk2_B_CT_capsule', 'cf_ct_capsules_robot_nuimqol_heavymech'),
('def_mesmer_mk2_C_CT_capsule', 'cf_ct_capsules_robot_nuimqol_heavymech'),
('def_prometheus_mk2_A_CT_capsule', 'cf_ct_capsules_robot_thelodica_light'),
('def_prometheus_mk2_B_CT_capsule', 'cf_ct_capsules_robot_thelodica_light'),
('def_prometheus_mk2_C_CT_capsule', 'cf_ct_capsules_robot_thelodica_light'),
('def_riveler_mk2_A_CT_capsule', 'cf_ct_capsules_robot_industrial_heavymech'),
('def_riveler_mk2_B_CT_capsule', 'cf_ct_capsules_robot_industrial_heavymech'),
('def_riveler_mk2_C_CT_capsule', 'cf_ct_capsules_robot_industrial_heavymech'),
('def_scarab_mk2_A_CT_capsule', 'cf_ct_capsules_robot_industrial_heavymech'),
('def_scarab_mk2_B_CT_capsule', 'cf_ct_capsules_robot_industrial_heavymech'),
('def_scarab_mk2_C_CT_capsule', 'cf_ct_capsules_robot_industrial_heavymech'),
('def_sequer_mk2_A_CT_capsule', 'cf_ct_capsules_robot_industrial_assault'),
('def_sequer_mk2_B_CT_capsule', 'cf_ct_capsules_robot_industrial_assault'),
('def_sequer_mk2_C_CT_capsule', 'cf_ct_capsules_robot_industrial_assault'),
('def_seth_mk2_A_CT_capsule', 'cf_ct_capsules_robot_thelodica_heavymech'),
('def_seth_mk2_B_CT_capsule', 'cf_ct_capsules_robot_thelodica_heavymech'),
('def_seth_mk2_C_CT_capsule', 'cf_ct_capsules_robot_thelodica_heavymech'),
('def_symbiont_mk2_A_CT_capsule', 'cf_ct_capsules_robot_industrial_heavymech'),
('def_symbiont_mk2_B_CT_capsule', 'cf_ct_capsules_robot_industrial_heavymech'),
('def_symbiont_mk2_C_CT_capsule', 'cf_ct_capsules_robot_industrial_heavymech'),
('def_termis_mk2_A_CT_capsule', 'cf_ct_capsules_robot_industrial_mech'),
('def_termis_mk2_B_CT_capsule', 'cf_ct_capsules_robot_industrial_mech'),
('def_termis_mk2_C_CT_capsule', 'cf_ct_capsules_robot_industrial_mech'),
('def_troiar_mk2_A_CT_capsule', 'cf_ct_capsules_robot_pelistal_light'),
('def_troiar_mk2_B_CT_capsule', 'cf_ct_capsules_robot_pelistal_light'),
('def_troiar_mk2_C_CT_capsule', 'cf_ct_capsules_robot_pelistal_light'),
('def_tyrannos_mk2_A_CT_capsule', 'cf_ct_capsules_robot_pelistal_mech'),
('def_tyrannos_mk2_B_CT_capsule', 'cf_ct_capsules_robot_pelistal_mech'),
('def_tyrannos_mk2_C_CT_capsule', 'cf_ct_capsules_robot_pelistal_mech'),
('def_vagabond_mk2_A_CT_capsule', 'cf_ct_capsules_robot_nuimqol_mech'),
('def_vagabond_mk2_B_CT_capsule', 'cf_ct_capsules_robot_nuimqol_mech'),
('def_vagabond_mk2_C_CT_capsule', 'cf_ct_capsules_robot_nuimqol_mech'),
('def_waspish_mk2_A_CT_capsule', 'cf_ct_capsules_robot_pelistal_assault'),
('def_waspish_mk2_B_CT_capsule', 'cf_ct_capsules_robot_pelistal_assault'),
('def_waspish_mk2_C_CT_capsule', 'cf_ct_capsules_robot_pelistal_assault'),
('def_yagel_mk2_A_CT_capsule', 'cf_ct_capsules_robot_nuimqol_light'),
('def_yagel_mk2_B_CT_capsule', 'cf_ct_capsules_robot_nuimqol_light'),
('def_yagel_mk2_C_CT_capsule', 'cf_ct_capsules_robot_nuimqol_light'),
('def_zenith_mk2_A_CT_capsule', 'cf_ct_capsules_robot_thelodica_mech'),
('def_zenith_mk2_B_CT_capsule', 'cf_ct_capsules_robot_thelodica_mech'),
('def_zenith_mk2_C_CT_capsule', 'cf_ct_capsules_robot_thelodica_mech'),
('def_specimen_sap_item_CT_capsule', 'cf_ct_capsules_misc'),
('def_ammo_small_projectile_t_CT_capsule', 'cf_ct_capsules_ammo_projectile'),
('def_ammo_medium_projectile_t_CT_capsule', 'cf_ct_capsules_ammo_projectile'),
('def_elitet2_70_small_armor_repairer_CT_capsule', 'cf_ct_capsules_equipment_armor'),
('def_elitet4_70_small_armor_repairer_CT_capsule', 'cf_ct_capsules_equipment_armor'),
('def_elitet2_70_medium_armor_repairer_CT_capsule', 'cf_ct_capsules_equipment_armor'),
('def_elitet4_70_medium_armor_repairer_CT_capsule', 'cf_ct_capsules_equipment_armor'),
('def_elitet2_70_small_shield_generator_CT_capsule', 'cf_ct_capsules_equipment_shield'),
('def_elitet4_70_small_shield_generator_CT_capsule', 'cf_ct_capsules_equipment_shield'),
('def_elitet2_70_medium_shield_generator_CT_capsule', 'cf_ct_capsules_equipment_shield'),
('def_elitet4_70_medium_shield_generator_CT_capsule', 'cf_ct_capsules_equipment_shield'),
('def_elitet2_70_sensor_booster_CT_capsule', 'cf_ct_capsules_equipment_electronics'),
('def_elitet4_70_sensor_booster_CT_capsule', 'cf_ct_capsules_equipment_electronics'),
('def_elitet2_70_webber_CT_capsule', 'cf_ct_capsules_equipment_ewar'),
('def_elitet4_70_webber_CT_capsule', 'cf_ct_capsules_equipment_ewar'),
('def_elitet2_70_eccm_CT_capsule', 'cf_ct_capsules_equipment_ewar'),
('def_elitet4_70_eccm_CT_capsule', 'cf_ct_capsules_equipment_ewar'),
('def_elitet2_70_small_core_booster_CT_capsule', 'cf_ct_capsules_equipment_engineering'),
('def_elitet4_70_small_core_booster_CT_capsule', 'cf_ct_capsules_equipment_engineering'),
('def_elitet2_70_medium_core_booster_CT_capsule', 'cf_ct_capsules_equipment_engineering'),
('def_elitet4_70_medium_core_booster_CT_capsule', 'cf_ct_capsules_equipment_engineering'),
('def_elitet2_70_tracking_upgrade_CT_capsule', 'cf_ct_capsules_equipment_electronics'),
('def_elitet4_70_tracking_upgrade_CT_capsule', 'cf_ct_capsules_equipment_electronics');


MERGE [dbo].[entitydefaults] e USING #CT_CAPSULE_CATS c
ON e.definitionname=c.defName
WHEN MATCHED
    THEN UPDATE SET
	categoryflags = (SELECT TOP 1 value FROM categoryFlags WHERE name=c.catName);


DROP TABLE IF EXISTS #CT_CAPSULE_CATS;
GO




PRINT N'03_RiftConfig_RiftDestination_CREATE_TABLE_ALTER npcbossinfo__2021_03_02.sql';
USE [perpetuumsa]
GO

--------------------------------------------------------
--Datamodel for new custom dynamic rifts and their teleport destinations
--Each riftconfig describes the behaviour of a rift, whereever and how ever it spawns
--The riftconfig points to a destination group which is a weighted-collection of locations on the world
--Riftconfigs can/will have other constraints, like max uses per its lifetime, a lifespan before it despawn, etc.
--
--Date modified: 2021/03/12
--------------------------------------------------------
PRINT N'DROP/CREATE [dbo].[riftconfigs]';
DROP TABLE IF EXISTS [dbo].[riftconfigs];
CREATE TABLE [dbo].[riftconfigs] (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	destinationGroupId INT,
	lifespanSeconds INT,
	maxUses INT,
	categoryExclusionGroupId INT
);
PRINT N'DROP/CREATE [dbo].[riftdestinations]';
DROP TABLE IF EXISTS [dbo].[riftdestinations];
CREATE TABLE [dbo].[riftdestinations] (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	groupId INT NOT NULL,
	zoneId INT NOT NULL,
	x INT,
	y INT,
	weight INT NOT NULL DEFAULT 1
);

PRINT N'DROP/CREATE [dbo].[categorygroups]';
DROP TABLE IF EXISTS [dbo].[categorygroups];
CREATE TABLE [dbo].[categorygroups] (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	groupId INT NOT NULL,
	category BIGINT NOT NULL
);

PRINT N'DROP/CREATE [dbo].[categorygroupsnames]';
DROP TABLE IF EXISTS [dbo].[categorygroupsnames];
CREATE TABLE [dbo].[categorygroupsnames] (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	name VARCHAR(100) NOT NULL
);

PRINT N'ALTER [dbo].[npcbossinfo]';
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[perpetuumsa].[dbo].[npcbossinfo]')
	AND name = 'riftConfigId')
BEGIN
	PRINT N'ADDING COL riftConfigId';
	ALTER TABLE [perpetuumsa].[dbo].[npcbossinfo] ADD
		riftConfigId INT NULL;
END
GO

USE [perpetuumsa]
GO

INSERT INTO [dbo].[categorygroupsnames] (name) VALUES
('destro'),
('destroHM'),
('destroMech'),
('destroAssault'),
('destroLight');

INSERT INTO [dbo].[categorygroups] (groupId, category) VALUES
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destro'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_walkers')),

((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroHM'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_walkers')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroHM'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_heavy_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroHM'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_industrial_heavy_gliders')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroHM'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_industrial_heavymechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroHM'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_nuimqol_heavymechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroHM'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_pelistal_heavymechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroHM'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_syndicate_heavymechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroHM'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_thelodica_heavymechs')),

((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroMech'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_walkers')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroMech'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_heavy_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroMech'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_industrial_heavy_gliders')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroMech'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_industrial_heavymechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroMech'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_nuimqol_heavymechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroMech'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_pelistal_heavymechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroMech'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_syndicate_heavymechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroMech'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_thelodica_heavymechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroMech'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroMech'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_industrial_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroMech'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_nuimqol_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroMech'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_pelistal_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroMech'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_syndicate_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroMech'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_thelodica_mechs')),

((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroAssault'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_walkers')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroAssault'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_heavy_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroAssault'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_industrial_heavy_gliders')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroAssault'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_industrial_heavymechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroAssault'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_nuimqol_heavymechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroAssault'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_pelistal_heavymechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroAssault'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_syndicate_heavymechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroAssault'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_thelodica_heavymechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroAssault'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroAssault'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_industrial_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroAssault'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_nuimqol_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroAssault'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_pelistal_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroAssault'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_syndicate_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroAssault'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_thelodica_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroAssault'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_crawlers')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroAssault'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_industrial_crawlers')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroAssault'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_nuimqol_crawlers')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroAssault'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_pelistal_crawlers')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroAssault'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_syndicate_crawlers')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroAssault'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_thelodica_crawlers')),

((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_walkers')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_heavy_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_industrial_heavy_gliders')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_industrial_heavymechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_nuimqol_heavymechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_pelistal_heavymechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_syndicate_heavymechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_thelodica_heavymechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_industrial_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_nuimqol_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_pelistal_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_syndicate_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_thelodica_mechs')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_crawlers')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_industrial_crawlers')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_nuimqol_crawlers')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_pelistal_crawlers')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_syndicate_crawlers')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_thelodica_crawlers')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_runners')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_industrial_runners')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_nuimqol_runners')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_pelistal_runners')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_syndicate_runners')),
((SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroLight'), (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_thelodica_runners'));

PRINT N'INSERT INTO [dbo].[riftdestinations]';
INSERT INTO [dbo].[riftdestinations] (groupId, zoneId, x, y, weight) VALUES
(71, 71, 37, 170, 1),
(72, 72, 218, 29, 1);

PRINT N'INSERT INTO [dbo].[riftconfigs]';
INSERT INTO [dbo].[riftconfigs] (name, destinationGroupId, lifespanSeconds, maxUses, categoryExclusionGroupId) VALUES 
('stronghold_z71_entry', 71, 600, 9, (SELECT TOP 1 id FROM categorygroupsnames WHERE name='destroMech')),
('stronghold_z72_entry', 72, 600, 9, (SELECT TOP 1 id FROM categorygroupsnames WHERE name='destro'));

PRINT N'UPDATE npcbossinfo for boss entry riftconfigs';
PRINT N'Boss for 71 entrance config';
UPDATE npcbossinfo SET
	riftConfigId = (SELECT TOP 1 id FROM [dbo].[riftconfigs] WHERE name='stronghold_z71_entry')
WHERE flockid = (SELECT TOP 1 id FROM npcflock WHERE name='Rough_Rider_Leader');

PRINT N'Boss for 72 entrance config';
UPDATE npcbossinfo SET
	riftConfigId = (SELECT TOP 1 id FROM [dbo].[riftconfigs] WHERE name='stronghold_z72_entry')
WHERE flockid = (SELECT TOP 1 id FROM npcflock WHERE name='Hersh_RR_1');

GO




PRINT N'04_Aggvalues_update_Metis_head__2021_03_15.sql';
USE [perpetuumsa]
GO
----------------------------------
-- Metis balance updates
-- Date modified: 2021/03/15
----------------------------------

DROP TABLE IF EXISTS #AGG_VALS;
CREATE TABLE #AGG_VALS(
	defName VARCHAR(100),
	fieldName VARCHAR(100),
	fieldValue float
);
INSERT INTO #AGG_VALS (defName, fieldName, fieldValue) VALUES
('def_metis_head', 'locked_targets_max', 6),
('def_metis_head', 'sensor_strength', 95),
('def_metis_head', 'detection_strength', 80),
('def_metis_head', 'stealth_strength', 105);


PRINT N'UPDATE AGG VALUES';
MERGE [dbo].[aggregatevalues] a USING #AGG_VALS v
ON a.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=v.defName) AND
a.field = (SELECT TOP 1 id FROM aggregatefields WHERE name=v.fieldName)
WHEN MATCHED
    THEN UPDATE SET
		value=v.fieldValue;


DROP TABLE IF EXISTS #AGG_VALS;
PRINT N'UPDATED METIS BOT STATS';
GO

USE [perpetuumsa]
GO
----------------------------------
-- Metis Bonus reversed bug
-- Date modified: 2021/04/03
----------------------------------

DROP TABLE IF EXISTS #BONUS;
CREATE TABLE #BONUS(
	defName VARCHAR(100),
	bonusField VARCHAR(100),
	bonusSkill VARCHAR(100),
	bonusAmount FLOAT
);
INSERT INTO #BONUS (defName, bonusField, bonusSkill, bonusAmount) VALUES
('def_metis_head', 'reactor_radiation_modifier', 'ext_indy_role_specialist', -0.03);

PRINT N'UPDATE [chassisbonus]';
MERGE [dbo].[chassisbonus] a USING #BONUS v
ON a.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=v.defName) AND
a.targetpropertyID = (SELECT TOP 1 id FROM aggregatefields WHERE name=v.bonusField) AND
a.extension = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname=v.bonusSkill)
WHEN MATCHED
    THEN UPDATE SET
		bonus=v.bonusAmount;


DROP TABLE IF EXISTS #BONUS;
PRINT N'UPDATED METIS BOT Bonuses';
GO



PRINT N'05_Defs_aggvalues_lightbot_update__2021_02_22.sql';
USE [perpetuumsa]
GO

---------------------------------------------------
-- Light bot rebalance
-- Speed/mass, locking range, some reactor
-- EW mass added to be consistent at fitted velocity
-- Date modified: 2021/03/31
---------------------------------------------------

DROP TABLE IF EXISTS #CHASSIS_DEFS;
CREATE TABLE #CHASSIS_DEFS(
	defName VARCHAR(100),
	chassisMass float
);
INSERT INTO #CHASSIS_DEFS (defName, chassisMass) VALUES
('def_vektor_chassis', 8400),
('def_castel_chassis', 6840),
('def_yagel_chassis', 7100),
('def_prometheus_chassis', 7100),

('def_castel_chassis_pr', 6840),
('def_yagel_chassis_pr', 7100),
('def_prometheus_chassis_pr', 7100),

('def_castel_chassis_mk2', 9900),
('def_yagel_chassis_mk2', 10250),
('def_prometheus_chassis_mk2', 10250),

('def_helix_chassis', 6200),

('def_troiar_chassis', 5360),
('def_cameleon_chassis', 5000),
('def_intakt_chassis', 5000),

('def_troiar_chassis_pr', 5360),
('def_cameleon_chassis_pr', 5000),
('def_intakt_chassis_pr', 5000),

('def_troiar_chassis_mk2', 7100),
('def_cameleon_chassis_mk2', 6700),
('def_intakt_chassis_mk2', 6700);

DROP TABLE IF EXISTS #AGG_VALS;
CREATE TABLE #AGG_VALS(
	defName VARCHAR(100),
	fieldName VARCHAR(100),
	fieldValue float
);
INSERT INTO #AGG_VALS (defName, fieldName, fieldValue) VALUES
('def_vektor_leg', 'speed_max', 3.083),
('def_vektor_head', 'locking_range', 19),
('def_castel_leg', 'speed_max', 3.222),
('def_castel_head', 'locking_range', 18),
('def_castel_chassis', 'powergrid_max', 140),
('def_yagel_leg', 'speed_max', 3.527),
('def_yagel_head', 'locking_range', 17),
('def_yagel_chassis', 'powergrid_max', 155),
('def_prometheus_leg', 'speed_max', 3.222),
('def_prometheus_head', 'locking_range', 19),

('def_castel_leg_pr', 'speed_max', 3.222),
('def_castel_head_pr', 'locking_range', 18),
('def_castel_chassis_pr', 'powergrid_max', 140),
('def_yagel_leg_pr', 'speed_max', 3.527),
('def_yagel_head_pr', 'locking_range', 17),
('def_yagel_chassis_pr', 'powergrid_max', 155),
('def_prometheus_leg_pr', 'speed_max', 3.222),
('def_prometheus_head_pr', 'locking_range', 19),

('def_castel_leg_mk2', 'speed_max', 3.222),
('def_castel_head_mk2', 'locking_range', 18),
('def_castel_chassis_mk2', 'powergrid_max', 154),
('def_yagel_leg_mk2', 'speed_max', 3.527),
('def_yagel_head_mk2', 'locking_range', 17),
('def_yagel_chassis_mk2', 'powergrid_max', 170),
('def_prometheus_leg_mk2', 'speed_max', 3.222),
('def_prometheus_head_mk2', 'locking_range', 19);

PRINT N'UPDATE CHASSIS MASS';
MERGE [dbo].[entitydefaults] e USING #CHASSIS_DEFS c
ON e.definitionname = c.defName
WHEN MATCHED
    THEN UPDATE SET
		mass=c.chassisMass;

PRINT N'UPDATE AGG VALUES';
MERGE [dbo].[aggregatevalues] a USING #AGG_VALS v
ON a.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=v.defName) AND
a.field = (SELECT TOP 1 id FROM aggregatefields WHERE name=v.fieldName)
WHEN MATCHED
    THEN UPDATE SET
		value=v.fieldValue;



DROP TABLE IF EXISTS #AGG_VALS;
DROP TABLE IF EXISTS #CHASSIS_DEFS;
PRINT N'UPDATED LIGHT BOT STATS';
GO



PRINT N'06_Itemshop_update_paintprice__2021_03_24.sql';
USE [perpetuumsa]
GO
-----------------------------------
-- Reduce Paint price v2
-- Update price of paints everywhere to 3m nic
-- no more RGB tokens
-- Date modified: 2021/03/28
-----------------------------------

PRINT N'UPDATE itemshop (60 rows affected)';
UPDATE itemshop SET
	credit=3000000,
	unicoin=NULL,
	tmcoin=NULL,
	icscoin=NULL,
	asicoin=NULL
WHERE 
	targetdefinition IN (SELECT definition FROM entitydefaults WHERE
	categoryflags=(SELECT TOP 1 value FROM categoryFlags WHERE name='cf_paints'));

GO



PRINT N'07_Mineralconfigs_update__2021_03_24.sql';
USE [perpetuumsa]
GO
--------------------------------------
-- Mineral field numbers
--
-- Date Modified: 2021/03/24
--------------------------------------

DROP TABLE IF EXISTS #MINS;
CREATE TABLE #MINS(
	zoneName varchar(100),
	material int,
	numfields int
);
INSERT INTO #MINS(zoneName, material, numfields) VALUES
('zone_TM', 1, 7),
('zone_TM', 2, 7),
('zone_TM', 5, 7),
('zone_TM_pve', 1, 7),
('zone_TM_pve', 2, 7),
('zone_TM_pve', 3, 7),
('zone_TM_pve', 4, 7),
('zone_TM_pve', 5, 7),
('zone_TM_pve', 12, 7),
('zone_ICS_A_real', 1, 8),
('zone_ICS_A_real', 2, 8),
('zone_ICS_A_real', 3, 8),
('zone_ICS_A_real', 4, 8),
('zone_ICS_A_real', 5, 8),
('zone_ICS_A_real', 6, 10),
('zone_ICS_A_real', 16, 4),
('zone_ASI_A_real', 1, 8),
('zone_ASI_A_real', 2, 8),
('zone_ASI_A_real', 3, 8),
('zone_ASI_A_real', 5, 8),
('zone_ASI_A_real', 12, 8),
('zone_ASI_A_real', 6, 10),
('zone_ASI_A_real', 16, 4),
('zone_TM_A_real', 1, 8),
('zone_TM_A_real', 2, 8),
('zone_TM_A_real', 4, 8),
('zone_TM_A_real', 5, 8),
('zone_TM_A_real', 12, 8),
('zone_TM_A_real', 6, 10),
('zone_TM_A_real', 16, 4),
('zone_ICS_pvp', 1, 10),
('zone_ICS_pvp', 2, 10),
('zone_ICS_pvp', 3, 10),
('zone_ICS_pvp', 4, 10),
('zone_ICS_pvp', 5, 10),
('zone_ICS_pvp', 6, 12),
('zone_ICS_pvp', 16, 5),
('zone_ASI_pvp', 1, 10),
('zone_ASI_pvp', 2, 10),
('zone_ASI_pvp', 3, 10),
('zone_ASI_pvp', 5, 10),
('zone_ASI_pvp', 12, 10),
('zone_ASI_pvp', 6, 12),
('zone_ASI_pvp', 16, 5),
('zone_TM_pvp', 1, 10),
('zone_TM_pvp', 2, 10),
('zone_TM_pvp', 4, 10),
('zone_TM_pvp', 5, 10),
('zone_TM_pvp', 12, 10),
('zone_TM_pvp', 6, 12),
('zone_TM_pvp', 16, 5);

PRINT N'MERGE mineralconfigs (51 rows affected)';
MERGE mineralconfigs c USING #MINS m
ON c.materialtype=m.material AND c.zoneid=(SELECT TOP 1 id FROM zones WHERE name=m.zoneName)
WHEN MATCHED
    THEN UPDATE SET
		maxNodes = m.numFields;


DROP TABLE IF EXISTS #REWARDS;
DROP TABLE IF EXISTS #MINS;
GO



PRINT N'08_Missions_update_levelTrewards__2021_03_21.sql';
USE [perpetuumsa]
GO

-----------------------------------------------
-- Update Level T assignments nic rewards
-- Date modified: 2021/03/21
-----------------------------------------------

DROP TABLE IF EXISTS #REWARDS;
CREATE TABLE #REWARDS (
	name VARCHAR(128),
	reward FLOAT
);
INSERT INTO #REWARDS (name, reward) VALUES
('mission_asi_gen_tutorial_exp3_01',18750),
('mission_ics_gen_tutorial_exp3_01',18750),
('mission_tm_gen_tutorial_exp3_01',18750),
('mission_asi_gen_tutorial_exp3_02',22500),
('mission_ics_gen_tutorial_exp3_02',22500),
('mission_tm_gen_tutorial_exp3_02',22500),
('mission_asi_gen_tutorial_exp3_03',27500),
('mission_ics_gen_tutorial_exp3_03',27500),
('mission_tm_gen_tutorial_exp3_03',27500),
('mission_asi_i_tutorial_exp3_01',31250),
('mission_ics_i_tutorial_exp3_01',31250),
('mission_tm_i_tutorial_exp3_01',31250),
('mission_asi_gen_tutorial_exp3_04',33750),
('mission_ics_gen_tutorial_exp3_04',33750),
('mission_tm_gen_tutorial_exp3_04',33750),
('mission_asi_w_tutorial_exp3_01',37500),
('mission_ics_w_tutorial_exp3_01',37500),
('mission_tm_w_tutorial_exp3_01',37500),
('mission_asi_gen_tutorial_exp3_05',43750),
('mission_asi_i_tutorial_exp3_02',43750),
('mission_ics_gen_tutorial_exp3_05',43750),
('mission_ics_i_tutorial_exp3_02',43750),
('mission_tm_gen_tutorial_exp3_05',43750),
('mission_tm_i_tutorial_exp3_02',43750),
('mission_asi_w_tutorial_exp3_02',53125),
('mission_ics_w_tutorial_exp3_02',53125),
('mission_tm_w_tutorial_exp3_02',53125),
('mission_asi_i_tutorial_exp3_03',56250),
('mission_ics_i_tutorial_exp3_03',56250),
('mission_tm_i_tutorial_exp3_03',56250),
('mission_asi_w_tutorial_exp3_03',68750),
('mission_ics_w_tutorial_exp3_03',68750),
('mission_tm_w_tutorial_exp3_03',68750),
('mission_asi_i_tutorial_exp3_04',75000),
('mission_ics_i_tutorial_exp3_04',75000),
('mission_tm_i_tutorial_exp3_04',75000),
('mission_asi_w_tutorial_exp3_04',81250),
('mission_ics_w_tutorial_exp3_04',81250),
('mission_tm_w_tutorial_exp3_04',81250),
('mission_asi_i_tutorial_exp3_05',87500),
('mission_ics_i_tutorial_exp3_05',87500),
('mission_tm_i_tutorial_exp3_05',87500),
('mission_asi_w_tutorial_exp3_05',93750),
('mission_ics_w_tutorial_exp3_05',93750),
('mission_tm_w_tutorial_exp3_05',93750),
('mission_asi_w_tutorial_exp3_06',112500),
('mission_ics_w_tutorial_exp3_06',112500),
('mission_tm_w_tutorial_exp3_06',112500);

PRINT N'UPDATE LEVEL T MISSION REWARDS';
MERGE [dbo].[missions] m USING #REWARDS r
ON m.name = r.name
WHEN MATCHED
    THEN UPDATE SET
		rewardfee=r.reward;

PRINT N'DONE UPDATING LEVEL T MISSION REWARDS';
DROP TABLE IF EXISTS #REWARDS;
GO



PRINT N'09_Missiontargettypes_update__2021_03_24.sql';
USE [perpetuumsa]
GO
------------------------------------
-- Mission reward tweak, again
--
-- Date modified: 2021/03/27
------------------------------------

DROP TABLE IF EXISTS #REWARDS;
CREATE TABLE #REWARDS(
	name varchar(100),
	reward int
);
INSERT INTO #REWARDS(name, reward) VALUES
('loot_item',55),
('kill_definition',55),
('scan_mineral',175),--was 200
('drill_mineral',4000),--was4200
('submit_item',220),
('use_switch',55),
('find_artifact',175),--was 200
('use_itemsupply',275),
('massproduce',550),
('research',550),
('harvest_plant',1000),--was 1100
('pop_npc',15),
('lock_unit',55);

PRINT N'MERGE missiontargettypes';
MERGE missiontargettypes t USING #REWARDS r
ON t.name=r.name
WHEN MATCHED
    THEN UPDATE SET
		t.reward=r.reward;


DROP TABLE IF EXISTS #REWARDS;
GO


PRINT N'10_NpcFlocks_NVboss_respawn2hr__2021_03_17.sql';
USE [perpetuumsa]
GO

------------------------------------------------
-- Set spawn times of NV bosses == to Hersh bosses @2hrs
-- Date Modified: 2021/03/17
------------------------------------------------

UPDATE npcflock SET
	respawnseconds=7200
WHERE name IN (
	'Rough_Rider_Leader',
	'def_npc_Malfunctioning_Arkhe',
	'def_npc_Imperial_Infantry',
	'def_npc_Tribal_Member',
	'def_npc_Sacrist_Convert'
);

GO




PRINT N'11_SyndicateCTs_upserts__2021_03_16.sql';
USE [perpetuumsa]
GO

DECLARE @light AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_syndicate_runners');
DECLARE @assault AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_syndicate_crawlers');
DECLARE @mech AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_syndicate_mechs');
DECLARE @hmech AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_syndicate_heavymechs');

DECLARE @primaryCommodity AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_primary_commodities');

DECLARE @dynamicCtCategory AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_dynamic_cprg');--For ct capsule defined cts

DECLARE @lightSyndicateCTCapsules AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_ct_capsules_robot_syndicate_light');
DECLARE @assaultSyndicateCTCapsules AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_ct_capsules_robot_syndicate_assault');
DECLARE @mechSyndicateCTCapsules AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_ct_capsules_robot_syndicate_mech');
DECLARE @hmechSyndicateCTCapsules AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_ct_capsules_robot_syndicate_heavymech');

DECLARE @tmShops AS INT = (SELECT TOP 1 id FROM itemshoppresets WHERE name='tm_preset_pve');

DROP TABLE IF EXISTS #ENTITYDEF;
CREATE TABLE #ENTITYDEF (
	def INT,
	defName varchar(100),
	attrFlags bigint,
	catFlags bigint,
	genxyOptStr varchar(max),
	cargoVolume float,
	massOfModule float,
	techType int,
	techLevel int,
);
INSERT INTO #ENTITYDEF (def, defName, attrFlags, catFlags, genxyOptStr, cargoVolume, massOfModule, techType, techLevel) VALUES
(191,'def_biotichrin',2048,@primaryCommodity,'',0.005,0.55,NULL,NULL);

DROP TABLE IF EXISTS #CTS;
CREATE TABLE #CTS (
	def INT,
	defName varchar(100),
	attrFlags bigint,
	catFlags bigint,
	genxyOptStr varchar(max),
	cargoVolume float,
	massOfModule float,
	techType int,
	techLevel int,
);
INSERT INTO #CTS (def, defName, attrFlags, catFlags, genxyOptStr, cargoVolume, massOfModule, techType, techLevel) VALUES
(6018,'def_vektor_bot_cprg',1024,@dynamicCtCategory,'',0.01,0.1,NULL,NULL),
(6019,'def_helix_bot_cprg',1024,@dynamicCtCategory,'',0.01,0.1,NULL,NULL),
(6020,'def_locust_bot_cprg',1024,@dynamicCtCategory,'',0.01,0.1,NULL,NULL),
(6021,'def_echelon_bot_cprg',1024,@dynamicCtCategory,'',0.01,0.1,NULL,NULL),
(6022,'def_callisto_bot_cprg',1024,@dynamicCtCategory,'',0.01,0.1,NULL,NULL),
(6023,'def_legatus_bot_cprg',1024,@dynamicCtCategory,'',0.01,0.1,NULL,NULL),
(6024,'def_ikarus_bot_cprg',1024,@dynamicCtCategory,'',0.01,0.1,NULL,NULL),
(6025,'def_cronus_bot_cprg',1024,@dynamicCtCategory,'',0.01,0.1,NULL,NULL),
(6026,'def_hermes_bot_cprg',1024,@dynamicCtCategory,'',0.01,0.1,NULL,NULL),
(6027,'def_daidalos_bot_cprg',1024,@dynamicCtCategory,'',0.01,0.1,NULL,NULL),
(6028,'def_metis_bot_cprg',1024,@dynamicCtCategory,'',0.01,0.1,NULL,NULL);

DROP TABLE IF EXISTS #CTS_CAPSULES;
CREATE TABLE #CTS_CAPSULES (
	def INT,
	defName varchar(100),
	attrFlags bigint,
	catFlags bigint,
	genxyOptStr varchar(max),
	cargoVolume float,
	massOfModule float,
	techType int,
	techLevel int,
);
INSERT INTO #CTS_CAPSULES (def, defName, attrFlags, catFlags, genxyOptStr, cargoVolume, massOfModule, techType, techLevel) VALUES
(6029,'def_vektor_bot_CT_capsule',2052,@lightSyndicateCTCapsules,'',0.01,0.1,NULL,NULL),
(6030,'def_helix_bot_CT_capsule',2052,@lightSyndicateCTCapsules,'',0.01,0.1,NULL,NULL),
(6031,'def_locust_bot_CT_capsule',2052,@assaultSyndicateCTCapsules,'',0.01,0.1,NULL,NULL),
(6032,'def_echelon_bot_CT_capsule',2052,@mechSyndicateCTCapsules,'',0.01,0.1,NULL,NULL),
(6033,'def_callisto_bot_CT_capsule',2052,@mechSyndicateCTCapsules,'',0.01,0.1,NULL,NULL),
(6034,'def_legatus_bot_CT_capsule',2052,@hmechSyndicateCTCapsules,'',0.01,0.1,NULL,NULL),
(6035,'def_ikarus_bot_CT_capsule',2052,@lightSyndicateCTCapsules,'',0.01,0.1,NULL,NULL),
(6036,'def_cronus_bot_CT_capsule',2052,@assaultSyndicateCTCapsules,'',0.01,0.1,NULL,NULL),
(6037,'def_hermes_bot_CT_capsule',2052,@assaultSyndicateCTCapsules,'',0.01,0.1,NULL,NULL),
(6038,'def_daidalos_bot_CT_capsule',2052,@mechSyndicateCTCapsules,'',0.01,0.1,NULL,NULL),
(6039,'def_metis_bot_CT_capsule',2052,@hmechSyndicateCTCapsules,'',0.01,0.1,NULL,NULL);

DROP TABLE IF EXISTS #SHOPENTRIES;
CREATE TABLE #SHOPENTRIES (
	defName varchar(100),
	tokenPrice int,
	nicPrice int
);
INSERT INTO #SHOPENTRIES (defName, tokenPrice, nicPrice) VALUES
--Editted for 15pt/5-run values
('def_vektor_bot_CT_capsule',125,250000),
('def_helix_bot_CT_capsule',550,750000),
('def_locust_bot_CT_capsule',375,750000),
('def_echelon_bot_CT_capsule',1500,2250000),
('def_callisto_bot_CT_capsule',2250,3750000),
('def_legatus_bot_CT_capsule',6650,12500000),
('def_ikarus_bot_CT_capsule',50,125000),
('def_cronus_bot_CT_capsule',500,750000),
('def_hermes_bot_CT_capsule',500,875000),
('def_daidalos_bot_CT_capsule',1650,5000000),
('def_metis_bot_CT_capsule',8750,17500000);

DROP TABLE IF EXISTS #CT_RELATE;
CREATE TABLE #CT_RELATE (
	defName varchar(100),
	ctName varchar(100),
	capName varchar(100)
);
INSERT INTO #CT_RELATE (defName, ctName, capName) VALUES
('def_vektor_bot', 'def_vektor_bot_cprg', 'def_vektor_bot_CT_capsule'),
('def_helix_bot', 'def_helix_bot_cprg', 'def_helix_bot_CT_capsule'),
('def_locust_bot', 'def_locust_bot_cprg', 'def_locust_bot_CT_capsule'),
('def_echelon_bot', 'def_echelon_bot_cprg', 'def_echelon_bot_CT_capsule'),
('def_callisto_bot', 'def_callisto_bot_cprg', 'def_callisto_bot_CT_capsule'),
('def_legatus_bot', 'def_legatus_bot_cprg', 'def_legatus_bot_CT_capsule'),
('def_ikarus_bot', 'def_ikarus_bot_cprg', 'def_ikarus_bot_CT_capsule'),
('def_cronus_bot', 'def_cronus_bot_cprg', 'def_cronus_bot_CT_capsule'),
('def_hermes_bot', 'def_hermes_bot_cprg', 'def_hermes_bot_CT_capsule'),
('def_daidalos_bot', 'def_daidalos_bot_cprg', 'def_daidalos_bot_CT_capsule'),
('def_metis_bot', 'def_metis_bot_cprg', 'def_metis_bot_CT_capsule');

DROP TABLE IF EXISTS #INDY;
CREATE TABLE #INDY (
	defName VARCHAR(100),
	commodityName VARCHAR(100),
	amount INT
);
INSERT INTO #INDY (defName, commodityName, amount) VALUES
('def_biotichrin', 'def_helioptris', 25),
('def_biotichrin', 'def_triandlus', 25),
('def_biotichrin', 'def_prismocitae', 25),
('def_biotichrin', 'def_crude', 25),

('def_vektor_bot', 'def_titanium', 560),
('def_vektor_bot', 'def_axicol', 80),
('def_vektor_bot', 'def_axicoline', 150),
('def_vektor_bot', 'def_plasteosine', 110),
('def_vektor_bot', 'def_isopropentol', 110),
('def_vektor_bot', 'def_metachropin', 110),
('def_vektor_bot', 'def_statichnol', 110),
('def_vektor_bot', 'def_biotichrin', 175),

('def_helix_bot', 'def_titanium', 750),
('def_helix_bot', 'def_axicol', 380),
('def_helix_bot', 'def_axicoline', 150),
('def_helix_bot', 'def_plasteosine', 110),
('def_helix_bot', 'def_vitricyl', 340),
('def_helix_bot', 'def_chollonin', 340),
('def_helix_bot', 'def_prilumium', 340),
('def_helix_bot', 'def_espitium', 380),
('def_helix_bot', 'def_biotichrin', 250),

('def_locust_bot', 'def_titanium', 750),
('def_locust_bot', 'def_axicol', 190),
('def_locust_bot', 'def_axicoline', 750),
('def_locust_bot', 'def_plasteosine', 380),
('def_locust_bot', 'def_isopropentol', 440),
('def_locust_bot', 'def_metachropin', 440),
('def_locust_bot', 'def_statichnol', 440),
('def_locust_bot', 'def_biotichrin', 350),

('def_echelon_bot', 'def_titanium', 2250),
('def_echelon_bot', 'def_axicol', 190),
('def_echelon_bot', 'def_axicoline', 750),
('def_echelon_bot', 'def_plasteosine', 380),
('def_echelon_bot', 'def_phlobotil', 880),
('def_echelon_bot', 'def_polynucleit', 880),
('def_echelon_bot', 'def_polynitrocol', 880),
('def_echelon_bot', 'def_hydrobenol', 750),
('def_echelon_bot', 'def_espitium', 190),
('def_echelon_bot', 'def_alligior', 380),
('def_echelon_bot', 'def_biotichrin', 700),

('def_callisto_bot', 'def_titanium', 750),
('def_callisto_bot', 'def_axicol', 1130),
('def_callisto_bot', 'def_axicoline', 380),
('def_callisto_bot', 'def_plasteosine', 190),
('def_callisto_bot', 'def_vitricyl', 1130),
('def_callisto_bot', 'def_chollonin', 1130),
('def_callisto_bot', 'def_prilumium', 1130),
('def_callisto_bot', 'def_hydrobenol', 380),
('def_callisto_bot', 'def_espitium', 1130),
('def_callisto_bot', 'def_alligior', 190),
('def_callisto_bot', 'def_unimetal', 560),
('def_callisto_bot', 'def_biotichrin', 700),

('def_legatus_bot', 'def_phlobotil', 2250),
('def_legatus_bot', 'def_polynucleit', 2250),
('def_legatus_bot', 'def_polynitrocol', 2250),
('def_legatus_bot', 'def_hydrobenol', 2630),
('def_legatus_bot', 'def_espitium', 380),
('def_legatus_bot', 'def_alligior', 3750),
('def_legatus_bot', 'def_unimetal', 3750),
('def_legatus_bot', 'def_biotichrin', 3000),

('def_ikarus_bot', 'def_titanium', 560),
('def_ikarus_bot', 'def_axicol', 230),
('def_ikarus_bot', 'def_plasteosine', 380),
('def_ikarus_bot', 'def_biotichrin', 50),

('def_cronus_bot', 'def_titanium', 2250),
('def_cronus_bot', 'def_axicol', 380),
('def_cronus_bot', 'def_plasteosine', 1130),
('def_cronus_bot', 'def_biotichrin', 800),

('def_hermes_bot', 'def_titanium', 750),
('def_hermes_bot', 'def_axicol', 190),
('def_hermes_bot', 'def_axicoline', 750),
('def_hermes_bot', 'def_plasteosine', 380),
('def_hermes_bot', 'def_biotichrin', 2500),

('def_daidalos_bot', 'def_titanium', 3000),
('def_daidalos_bot', 'def_axicol', 560),
('def_daidalos_bot', 'def_plasteosine', 1500),
('def_daidalos_bot', 'def_espitium', 750),
('def_daidalos_bot', 'def_alligior', 1880),
('def_daidalos_bot', 'def_unimetal', 3750),
('def_daidalos_bot', 'def_biotichrin', 2750),

('def_metis_bot', 'def_titanium', 6250),
('def_metis_bot', 'def_axicol', 630),
('def_metis_bot', 'def_plasteosine', 3130),
('def_metis_bot', 'def_espitium', 630),
('def_metis_bot', 'def_alligior', 3130),
('def_metis_bot', 'def_unimetal', 6250),
('def_metis_bot', 'def_biotichrin', 3000);

DROP TABLE IF EXISTS #PRODSTATS;
CREATE TABLE #PRODSTATS (
	cat BIGINT,
	costModifier FLOAT,
	distMin FLOAT,
	distMax FLOAT,
	decr FLOAT,
	durationMod FLOAT
);
INSERT INTO #PRODSTATS (cat, costModifier, distMin, distMax, decr, durationMod) VALUES
(@light, 1, 0.005, 0.01, 3, 2.25),
(@assault, 2, 0.005, 0.01, 3, 3),
(@mech, 3, 0.005, 0.01, 3, 6),
(@hmech, 4, 0.005, 0.01, 3, 7.5);


PRINT N'UPSERT [entitydefaults] identity insert ON';
SET IDENTITY_INSERT [dbo].[entitydefaults] ON;

PRINT N'UPSERT new commodity plant goo [entitydefaults]';
MERGE [dbo].[entitydefaults] e USING #ENTITYDEF d
ON e.definition = d.def
WHEN MATCHED
    THEN UPDATE SET
		categoryflags=catFlags,
		attributeflags=attrFlags,
		volume=cargoVolume,
		mass=massOfModule,
		tiertype=techType,
		tierlevel=techLevel,
		options=genxyOptStr,
		enabled=1,
		hidden=0,
		purchasable=1,
		descriptiontoken=defName+'_desc'
WHEN NOT MATCHED
    THEN INSERT (definition, definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel) VALUES
	(def,defName,1,attrFlags,catFlags,genxyOptStr,'commodity',1,cargoVolume,massOfModule,0,100,defName+'_desc',1,techType,techLevel);


PRINT N'UPSERT  cts into [entitydefaults]';
MERGE [dbo].[entitydefaults] e USING #CTS d
ON e.definition = d.def
WHEN MATCHED
    THEN UPDATE SET
		categoryflags=catFlags,
		attributeflags=attrFlags,
		volume=cargoVolume,
		mass=massOfModule,
		tiertype=techType,
		tierlevel=techLevel,
		options=genxyOptStr,
		enabled=1,
		hidden=0,
		purchasable=1,
		descriptiontoken='calibration_program_desc'
WHEN NOT MATCHED
    THEN INSERT (definition, definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel) VALUES
	(def,defName,1,attrFlags,catFlags,genxyOptStr,'syndicate bot CT',1,cargoVolume,massOfModule,0,100,'calibration_program_desc',1,techType,techLevel);

PRINT N'UPSERT  ct capsules into [entitydefaults]';
MERGE [dbo].[entitydefaults] e USING #CTS_CAPSULES d
ON e.definition = d.def
WHEN MATCHED
    THEN UPDATE SET
		categoryflags=catFlags,
		attributeflags=attrFlags,
		volume=cargoVolume,
		mass=massOfModule,
		tiertype=techType,
		tierlevel=techLevel,
		options=genxyOptStr,
		enabled=1,
		hidden=0,
		purchasable=1,
		descriptiontoken=defName+'_desc'
WHEN NOT MATCHED
    THEN INSERT (definition, definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel) VALUES
	(def,defName,1,attrFlags,catFlags,genxyOptStr,'syndicate bot CT Capsule',1,cargoVolume,massOfModule,0,100,defName+'_desc',1,techType,techLevel);

SET IDENTITY_INSERT [dbo].[entitydefaults] OFF;
PRINT N'[entitydefaults] insert/updates done - identity insert off';

PRINT N'UPSERT [dynamiccalibrationtemplates]';
MERGE [dbo].[dynamiccalibrationtemplates] t USING #CT_RELATE c
ON t.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=c.ctName)
WHEN MATCHED
    THEN UPDATE SET
		materialefficiency=15,
		timeefficiency=15,
		targetdefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=c.defName)
WHEN NOT MATCHED
    THEN INSERT (definition, materialefficiency, timeefficiency, targetdefinition) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=c.ctName),
	15,15,
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=c.defName));

PRINT N'UPSERT [calibrationtemplateitems]';
MERGE [dbo].[calibrationtemplateitems] t USING #CT_RELATE c
ON t.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=c.capName)
WHEN MATCHED
    THEN UPDATE SET
		targetdefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=c.ctName)
WHEN NOT MATCHED
    THEN INSERT (definition, targetdefinition) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=c.capName),
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=c.ctName));

PRINT N'DELETE FOR CLEAN SLATE ON [components] FOR SYNDICATE BOT PRODUCTION';
DELETE FROM components WHERE definition IN(SELECT DISTINCT definition FROM entitydefaults WHERE definitionname IN (SELECT DISTINCT defName FROM #INDY));
PRINT N'UPSERT [components]';
MERGE [dbo].[components] c USING #INDY i
ON c.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=i.defName) AND
c.componentdefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=i.commodityName) 
WHEN MATCHED
    THEN UPDATE SET
		componentamount = i.amount
WHEN NOT MATCHED
    THEN INSERT (definition, componentdefinition, componentamount) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=i.defName),
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=i.commodityName),
	i.amount);

PRINT N'UPSERT [itemshop]';
MERGE [dbo].[itemshop] shop USING #SHOPENTRIES e
ON shop.targetdefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=e.defName)
WHEN MATCHED
    THEN UPDATE SET
		presetid=@tmShops,
		targetamount=1,
		unicoin=e.tokenPrice,
		credit=e.nicPrice
WHEN NOT MATCHED
    THEN INSERT (presetid, targetdefinition, targetamount, tmcoin, icscoin, asicoin, credit, unicoin, globallimit, purchasecount, standing) VALUES
	(@tmShops, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=e.defName), 1, 0, 0, 0, e.nicPrice, e.tokenPrice, NULL, 1, 0);

PRINT N'UPSERT [productioncost]';
MERGE [dbo].[productioncost] c USING #PRODSTATS s
ON c.category = s.cat
WHEN MATCHED
    THEN UPDATE SET
		costmodifier=s.costModifier
WHEN NOT MATCHED
    THEN INSERT (category, tiertype, tierlevel, costmodifier) VALUES
	(s.cat, NULL, NULL, s.costModifier);

PRINT N'UPSERT [productiondecalibration]';
MERGE [dbo].[productiondecalibration] d USING #PRODSTATS s
ON d.categoryflag = s.cat
WHEN MATCHED
    THEN UPDATE SET
		distorsionmin=s.distMin,
		distorsionmax=s.distMax,
		decrease=s.decr
WHEN NOT MATCHED
    THEN INSERT (categoryflag, distorsionmin, distorsionmax, decrease) VALUES
	(s.cat, s.distMin, s.distMax, s.decr);

PRINT N'UPSERT [productionduration]';
MERGE [dbo].[productionduration] d USING #PRODSTATS s
ON d.category = s.cat
WHEN MATCHED
    THEN UPDATE SET
		durationmodifier=s.durationMod
WHEN NOT MATCHED
    THEN INSERT (category, durationmodifier) VALUES
	(s.cat, s.durationMod);

DROP TABLE IF EXISTS #ENTITYDEF;
DROP TABLE IF EXISTS #CT_RELATE;
DROP TABLE IF EXISTS #CTS;
DROP TABLE IF EXISTS #CTS_CAPSULES;
DROP TABLE IF EXISTS #INDY;
DROP TABLE IF EXISTS #SHOPENTRIES;
DROP TABLE IF EXISTS #PRODSTATS;
GO



PRINT N'12_Marketitems_npcorder_update_syndicates__2021_03_15.sql';
USE [perpetuumsa]
GO

------------------------------------------------
-- Market NPC sell/buy order updates for Syndicates
-- Lights/assault bots
-- Date modified: 2021/03/21
------------------------------------------------

--Training market - dont touch
DECLARE @trainingMarketEid AS BIGINT = (SELECT TOP 1 eid FROM entities
WHERE parent=(SELECT TOP 1 eid FROM entities WHERE ename='base_training') AND
definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_public_market'));

DECLARE @ikarusMarketPrice AS FLOAT = 552000;
DECLARE @vektorMarketPrice AS FLOAT = 817000;
DECLARE @locustMarketPrice AS FLOAT = 2211000;
DECLARE @cronusMarketPrice AS FLOAT = 2616000;
DECLARE @hermesMarketPrice AS FLOAT = 2604000;

DECLARE @vektorDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_vektor_bot');
DECLARE @helixDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_helix_bot');
DECLARE @locustDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_locust_bot');
DECLARE @echelonDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_echelon_bot');
DECLARE @callistoDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_callisto_bot');
DECLARE @legatusDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_legatus_bot');
DECLARE @ikarusDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ikarus_bot');
DECLARE @cronusDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_cronus_bot');
DECLARE @hermesDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_hermes_bot');
DECLARE @daidalosDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_daidalos_bot');
DECLARE @metisDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_metis_bot');


PRINT N'NPC MARKET ORDERS FOR IKARUS';
UPDATE marketitems SET
	price=@ikarusMarketPrice
WHERE duration=0 AND isSell=1 AND quantity=-1 AND isvendoritem=1 AND marketeid<>@trainingMarketEid AND
itemdefinition=@ikarusDef;

UPDATE marketitems SET
	price=@ikarusMarketPrice/10
WHERE duration=0 AND isSell=0 AND quantity=-1 AND isvendoritem=1 AND marketeid<>@trainingMarketEid AND
itemdefinition=@ikarusDef;

PRINT N'NPC MARKET ORDERS FOR VEKTOR';
UPDATE marketitems SET
	price=@vektorMarketPrice
WHERE duration=0 AND isSell=1 AND quantity=-1 AND isvendoritem=1 AND marketeid<>@trainingMarketEid AND
itemdefinition=@vektorDef;

UPDATE marketitems SET
	price=@vektorMarketPrice/10
WHERE duration=0 AND isSell=0 AND quantity=-1 AND isvendoritem=1 AND marketeid<>@trainingMarketEid AND
itemdefinition=@vektorDef;

PRINT N'NPC MARKET ORDERS FOR LOCUST';
UPDATE marketitems SET
	price=@locustMarketPrice
WHERE duration=0 AND isSell=1 AND quantity=-1 AND isvendoritem=1 AND marketeid<>@trainingMarketEid AND
itemdefinition=@locustDef;

UPDATE marketitems SET
	price=@locustMarketPrice/10
WHERE duration=0 AND isSell=0 AND quantity=-1 AND isvendoritem=1 AND marketeid<>@trainingMarketEid AND
itemdefinition=@locustDef;

PRINT N'NPC MARKET ORDERS FOR CRONUS';
UPDATE marketitems SET
	price=@cronusMarketPrice
WHERE duration=0 AND isSell=1 AND quantity=-1 AND isvendoritem=1 AND marketeid<>@trainingMarketEid AND
itemdefinition=@cronusDef;

UPDATE marketitems SET
	price=@cronusMarketPrice/10
WHERE duration=0 AND isSell=0 AND quantity=-1 AND isvendoritem=1 AND marketeid<>@trainingMarketEid AND
itemdefinition=@cronusDef;

PRINT N'NPC MARKET ORDERS FOR HERMES';
UPDATE marketitems SET
	price=@hermesMarketPrice
WHERE duration=0 AND isSell=1 AND quantity=-1 AND isvendoritem=1 AND marketeid<>@trainingMarketEid AND
itemdefinition=@hermesDef;

UPDATE marketitems SET
	price=@hermesMarketPrice/10
WHERE duration=0 AND isSell=0 AND quantity=-1 AND isvendoritem=1 AND marketeid<>@trainingMarketEid AND
itemdefinition=@hermesDef;

GO




PRINT N'13_Marketitems_npcorder_update_NIANbots__2021_03_15.sql';
USE [perpetuumsa]
GO

------------------------------------------------
-- Market NPC sell/buy order updates for Nian bots
-- Lights/assault bots
-- Date modified: 2021/03/21
------------------------------------------------

--Training market - dont touch
DECLARE @trainingMarketEid AS BIGINT = (SELECT TOP 1 eid FROM entities
WHERE parent=(SELECT TOP 1 eid FROM entities WHERE ename='base_training') AND
definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_public_market'));

DECLARE @lightIndyPrice AS FLOAT = 684000;
DECLARE @lightCombatPrice AS FLOAT = 867000;
DECLARE @assaultIndyPrice AS FLOAT = 2400000;
DECLARE @assaultCombatPrice AS FLOAT = 2340000;

DECLARE @yagelDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_yagel_bot');
DECLARE @prometheusDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_prometheus_bot');
DECLARE @castelDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_castel_bot');

DECLARE @waspishDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_waspish_bot');
DECLARE @arbalestDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_arbalest_bot');
DECLARE @baphometDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_baphomet_bot');

DECLARE @arganoDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_argano_bot');
DECLARE @lairdDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_laird_bot');
DECLARE @sequerDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_sequer_bot');

PRINT N'NPC MARKET ORDERS FOR LIGHT INDY';
UPDATE marketitems SET
	price=@lightIndyPrice
WHERE duration=0 AND isSell=1 AND quantity=-1 AND isvendoritem=1 AND marketeid<>@trainingMarketEid AND
itemdefinition IN (@arganoDef, @lairdDef);

UPDATE marketitems SET
	price=@lightIndyPrice/10
WHERE duration=0 AND isSell=0 AND quantity=-1 AND isvendoritem=1 AND marketeid<>@trainingMarketEid AND
itemdefinition IN (@arganoDef, @lairdDef);

PRINT N'NPC MARKET ORDERS FOR LIGHT COMBAT';
UPDATE marketitems SET
	price=@lightCombatPrice
WHERE duration=0 AND isSell=1 AND quantity=-1 AND isvendoritem=1 AND marketeid<>@trainingMarketEid AND
itemdefinition IN (@castelDef, @yagelDef, @prometheusDef);

UPDATE marketitems SET
	price=@lightCombatPrice/10
WHERE duration=0 AND isSell=0 AND quantity=-1 AND isvendoritem=1 AND marketeid<>@trainingMarketEid AND
itemdefinition IN (@castelDef, @yagelDef, @prometheusDef);

PRINT N'NPC MARKET ORDERS FOR INDY ASSAULT';
UPDATE marketitems SET
	price=@assaultIndyPrice
WHERE duration=0 AND isSell=1 AND quantity=-1 AND isvendoritem=1 AND marketeid<>@trainingMarketEid AND
itemdefinition=@sequerDef;

UPDATE marketitems SET
	price=@assaultIndyPrice/10
WHERE duration=0 AND isSell=0 AND quantity=-1 AND isvendoritem=1 AND marketeid<>@trainingMarketEid AND
itemdefinition=@sequerDef;

PRINT N'NPC MARKET ORDERS FOR COMBAT ASSAULT';
UPDATE marketitems SET
	price=@assaultCombatPrice
WHERE duration=0 AND isSell=1 AND quantity=-1 AND isvendoritem=1 AND marketeid<>@trainingMarketEid AND
itemdefinition IN (@arbalestDef, @baphometDef, @waspishDef);

UPDATE marketitems SET
	price=@assaultCombatPrice/10
WHERE duration=0 AND isSell=0 AND quantity=-1 AND isvendoritem=1 AND marketeid<>@trainingMarketEid AND
itemdefinition IN (@arbalestDef, @baphometDef, @waspishDef);

GO




PRINT N'14_Itemshop_update_syndicatebots__2021_03_15.sql';
USE [perpetuumsa]
GO

------------------------------------------------------
-- Syndicate shop orders for syndicate bot cost updates
-- Date modified: 03/17/2021
------------------------------------------------------

DECLARE @vektorDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_vektor_bot');
DECLARE @helixDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_helix_bot');
DECLARE @locustDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_locust_bot');
DECLARE @echelonDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_echelon_bot');
DECLARE @callistoDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_callisto_bot');
DECLARE @legatusDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_legatus_bot');
DECLARE @ikarusDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ikarus_bot');
DECLARE @cronusDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_cronus_bot');
DECLARE @hermesDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_hermes_bot');
DECLARE @daidalosDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_daidalos_bot');
DECLARE @metisDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_metis_bot');

DROP TABLE IF EXISTS #SYNSHOP;
CREATE TABLE #SYNSHOP(
	def INT,
	tokens INT,
	nic INT
);
INSERT INTO #SYNSHOP (def, tokens, nic) VALUES
(@vektorDef, 80, 490000),
(@helixDef, 230, 1380000),
(@locustDef, 220, 1330000),
(@echelonDef, 710, 4260000),
(@callistoDef, 890, 5330000),
(@legatusDef, 2980, 17870000),
(@ikarusDef, 60, 330000),
(@cronusDef, 260, 1570000),
(@hermesDef, 260, 1560000),
(@daidalosDef, 1550, 9300000),
(@metisDef, 3390, 20370000);

PRINT N'UPDATE [itemshop] WITH NEW SYNSHOP PRICING';
MERGE [dbo].[itemshop] i USING #SYNSHOP s
ON i.targetdefinition = s.def
WHEN MATCHED
    THEN UPDATE SET
		credit=s.nic,
		unicoin=s.tokens;


DROP TABLE IF EXISTS #SYNSHOP;
GO




PRINT N'15_Components_maskerfrags__2021_03_31.sql';
USE [perpetuumsa]
GO

------------------------------------------
-- Masker component fixes: common frags only
--
-- Date modified: 2021/03/31
------------------------------------------
PRINT N'FIX MASKER COMPONENTS';
DROP TABLE IF EXISTS #MASK_COMPONENTS;
CREATE TABLE #MASK_COMPONENTS(
	defName VARCHAR(100),
	compName VARCHAR(100),
	amount INT
);

INSERT INTO #MASK_COMPONENTS (defName, compName, amount) VALUES
('def_named1_stealth_modul','def_titanium',200),
('def_named1_stealth_modul','def_plasteosine',50),
('def_named1_stealth_modul','def_robotshard_common_basic',60),
('def_named1_stealth_modul','def_standard_stealth_modul',1),
('def_named1_stealth_modul','def_axicol',450),
('def_named2_stealth_modul','def_titanium',200),
('def_named2_stealth_modul','def_plasteosine',25),
('def_named2_stealth_modul','def_alligior',25),
('def_named2_stealth_modul','def_espitium',225),
('def_named2_stealth_modul','def_robotshard_common_basic',40),
('def_named2_stealth_modul','def_robotshard_common_advanced',40),
('def_named2_stealth_modul','def_named1_stealth_modul',1),
('def_named2_stealth_modul','def_axicol',225),
('def_named3_stealth_modul','def_titanium',200),
('def_named3_stealth_modul','def_plasteosine',50),
('def_named3_stealth_modul','def_alligior',50),
('def_named3_stealth_modul','def_espitium',450),
('def_named3_stealth_modul','def_robotshard_common_basic',30),
('def_named3_stealth_modul','def_robotshard_common_advanced',60),
('def_named3_stealth_modul','def_robotshard_common_expert',90),
('def_named3_stealth_modul','def_named2_stealth_modul',1),
('def_named3_stealth_modul','def_unimetal',200),
('def_named3_stealth_modul','def_axicol',450),
('def_named1_stealth_modul_pr','def_titanium',200),
('def_named1_stealth_modul_pr','def_plasteosine',50),
('def_named1_stealth_modul_pr','def_robotshard_common_basic',60),
('def_named1_stealth_modul_pr','def_standard_stealth_modul',1),
('def_named1_stealth_modul_pr','def_axicol',450),
('def_named2_stealth_modul_pr','def_titanium',200),
('def_named2_stealth_modul_pr','def_plasteosine',25),
('def_named2_stealth_modul_pr','def_alligior',25),
('def_named2_stealth_modul_pr','def_espitium',225),
('def_named2_stealth_modul_pr','def_robotshard_common_basic',40),
('def_named2_stealth_modul_pr','def_robotshard_common_advanced',40),
('def_named2_stealth_modul_pr','def_named1_stealth_modul',1),
('def_named2_stealth_modul_pr','def_axicol',225),
('def_named3_stealth_modul_pr','def_titanium',200),
('def_named3_stealth_modul_pr','def_plasteosine',50),
('def_named3_stealth_modul_pr','def_alligior',50),
('def_named3_stealth_modul_pr','def_espitium',450),
('def_named3_stealth_modul_pr','def_robotshard_common_basic',30),
('def_named3_stealth_modul_pr','def_robotshard_common_advanced',60),
('def_named3_stealth_modul_pr','def_robotshard_common_expert',90),
('def_named3_stealth_modul_pr','def_named2_stealth_modul',1),
('def_named3_stealth_modul_pr','def_unimetal',200),
('def_named3_stealth_modul_pr','def_axicol',450);

PRINT N'DELETES components for Maskers (58 rows affected) [if run 2nd time, just 46]';
DELETE FROM components WHERE 
	definition IN (
		SELECT definition FROM entitydefaults WHERE definitionname IN (SELECT DISTINCT defName FROM #MASK_COMPONENTS)
	);

PRINT N'RE-INSERT components FOR MASKERS';
INSERT INTO components (definition, componentdefinition, componentamount)
SELECT
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defName),
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=compName),
	amount
FROM #MASK_COMPONENTS;

PRINT N'DONE W MASKER COMPONENTS';
DROP TABLE IF EXISTS #MASK_COMPONENTS;
GO


PRINT N'16_cw_corporation_updateall__2021_04_02.sql';
USE [perpetuumsa]
GO

-------------------------------------
-- Set all default bases to TMA
-- Fix for null-terminal respawn bug
-- Date modified: 2021/04/2
-------------------------------------

DECLARE @TMA_EID AS BIGINT = (SELECT TOP 1 eid FROM zoneentities WHERE note='tm main base jol' AND zoneID=0);

-- Update all corporation default bases to TMA
UPDATE cw_corporation SET
	baseEID=@TMA_EID;
GO


PRINT N'17_Marketitems_npcorder_insert_RawMaterialBuys__2021_04_03.sql';
USE [perpetuumsa]
GO

----------------------------------------------
-- Market NPC buy orders for raw materials
-- Public alpha and beta terminal markets only
-- Date modified: 2021/04/03
----------------------------------------------

DROP TABLE IF EXISTS #ALPHA_ORE_BUYS;
CREATE TABLE #ALPHA_ORE_BUYS(
	defName VARCHAR(100),
	price FLOAT
);
DROP TABLE IF EXISTS #BETA_PUBLIC_ORE_BUYS;
CREATE TABLE #BETA_PUBLIC_ORE_BUYS(
	defName VARCHAR(100),
	price FLOAT
);

INSERT INTO #ALPHA_ORE_BUYS (defName, price) VALUES
('def_crude', 0.1),
('def_liquizit', 0.33),
('def_epriton', 1.4),
('def_titan', 0.5),
('def_imentium', 0.77),
('def_silgium', 0.77),
('def_stermonit', 0.77),
('def_prismocitae', 0.80),
('def_helioptris', 0.80),
('def_triandlus', 0.80),
('def_electroplant_fruit', 2.4);

INSERT INTO #BETA_PUBLIC_ORE_BUYS (defName, price) VALUES
('def_crude', 0.12),
('def_liquizit', 0.4),
--('def_epriton', 1.68),
('def_titan', 0.6),
('def_imentium', 0.92),
('def_silgium', 0.92),
('def_stermonit', 0.92),
('def_prismocitae', 0.96),
('def_helioptris', 0.96),
('def_triandlus', 0.96);
--('def_electroplant_fruit', 2.88);

----MAIN terminals, alpha and beta
--'def_public_docking_base_nuimqol',
--'def_public_docking_base_pelistal',
--'def_public_docking_base_thelodica',
----Outpost Alpha
--'def_public_docking_base_nuimqol_outpost_pve',
--'def_public_docking_base_thelodica_outpost_pve'
--'def_public_docking_base_pelistal_outpost_pve',
----Outpost BETA
--'def_public_docking_base_pelistal_outpost',
--'def_public_docking_base_nuimqol_outpost',
--'def_public_docking_base_thelodica_outpost',


PRINT N'SELECT TERMINAL DEFINITIONS';
DECLARE @MAIN_TERMINAL_DEFS AS TABLE (definition INT);
INSERT INTO @MAIN_TERMINAL_DEFS
SELECT definition FROM entitydefaults WHERE definitionname IN (
	'def_public_docking_base_nuimqol',
	'def_public_docking_base_pelistal',
	'def_public_docking_base_thelodica'
);

DECLARE @MAIN_AND_PVE_OUTPOSTS AS TABLE (definition INT);
INSERT INTO @MAIN_AND_PVE_OUTPOSTS (definition)
SELECT definition FROM entitydefaults WHERE definitionname IN (
	'def_public_docking_base_nuimqol_outpost_pve',
	'def_public_docking_base_thelodica_outpost_pve',
	'def_public_docking_base_pelistal_outpost_pve'
);
INSERT INTO @MAIN_AND_PVE_OUTPOSTS (definition)
SELECT definition FROM @MAIN_TERMINAL_DEFS;

PRINT N'SELECT MARKET ENTITIES';
DECLARE @ALPHA_MARKETS TABLE (eid BIGINT);
DECLARE @BETA_PUBLIC_MARKETS TABLE (eid BIGINT);
DECLARE @MARKET_DEF AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_public_market');

INSERT INTO @ALPHA_MARKETS (eid)
SELECT e.eid FROM entities e
JOIN zoneentities ze ON e.parent=ze.eid
JOIN zones z ON z.id=ze.zoneID
WHERE 
	(SELECT TOP 1 definition FROM entities WHERE eid=ze.eid) IN (SELECT definition FROM @MAIN_AND_PVE_OUTPOSTS) AND 
	e.definition=@MARKET_DEF AND z.protected=1 AND zonetype=1; --alpha

INSERT INTO @BETA_PUBLIC_MARKETS (eid)
SELECT e.eid FROM entities e
JOIN zoneentities ze ON e.parent=ze.eid
JOIN zones z ON z.id=ze.zoneID
WHERE
	(SELECT TOP 1 definition FROM entities WHERE eid=ze.eid) IN (SELECT definition FROM @MAIN_TERMINAL_DEFS) AND 
	e.definition=@MARKET_DEF AND z.protected=0 AND zonetype=2; --beta

DECLARE @VENDOR_DEF AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_public_vendor');

DECLARE @ALPHA_MARKETS_AND_VENDOR TABLE (market BIGINT, vendor BIGINT);
INSERT INTO @ALPHA_MARKETS_AND_VENDOR (market, vendor)
SELECT m.eid market, v.eid vendor FROM entities v
JOIN entities m ON m.parent=v.parent AND v.definition=@VENDOR_DEF AND m.eid IN (SELECT eid FROM @ALPHA_MARKETS);

DECLARE @BETA_MARKETS_AND_VENDOR TABLE (market BIGINT, vendor BIGINT);
INSERT INTO @BETA_MARKETS_AND_VENDOR (market, vendor)
SELECT m.eid market, v.eid vendor FROM entities v
JOIN entities m ON m.parent=v.parent AND v.definition=@VENDOR_DEF AND m.eid IN (SELECT eid FROM @BETA_PUBLIC_MARKETS);

DECLARE @ALPHA_ORDERS TABLE (marketEid BIGINT, itemDef INT, vendorEid BIGINT, price FLOAT);
INSERT INTO @ALPHA_ORDERS (marketEid, itemDef, vendorEid, price)
SELECT market,
 (select definition from entitydefaults where definitionname=defName), 
 vendor, price
FROM @ALPHA_MARKETS_AND_VENDOR m
JOIN #ALPHA_ORE_BUYS o ON 1=1;

DECLARE @BETA_ORDERS TABLE (marketEid BIGINT, itemDef INT, vendorEid BIGINT, price FLOAT);
INSERT INTO @BETA_ORDERS (marketEid, itemDef, vendorEid, price)
SELECT market,
 (select definition from entitydefaults where definitionname=defName), 
 vendor, price
FROM @BETA_MARKETS_AND_VENDOR m
JOIN #BETA_PUBLIC_ORE_BUYS o ON 1=1;

PRINT N'UPSERT MARKET ORDERS FOR EACH MARKET';
MERGE [dbo].[marketitems] m USING @ALPHA_ORDERS o
ON m.marketeid = o.marketEid AND
m.itemdefinition = o.itemDef AND
m.submittereid = o.vendorEid AND
m.isSell=0 AND m.isVendorItem=1 AND m.duration=0 AND m.quantity=-1
WHEN MATCHED
    THEN UPDATE SET
		price = o.price
WHEN NOT MATCHED
    THEN INSERT (marketeid, itemdefinition, submittereid, duration, isSell, price, quantity, usecorporationwallet, isvendoritem) VALUES
	(o.marketEid, o.itemDef, o.vendorEid, 0, 0, o.price, -1, 0, 1);

MERGE [dbo].[marketitems] m USING @BETA_ORDERS o
ON m.marketeid = o.marketEid AND
m.itemdefinition = o.itemDef AND
m.submittereid = o.vendorEid AND
m.isSell=0 AND m.isVendorItem=1 AND m.duration=0 AND m.quantity=-1
WHEN MATCHED
    THEN UPDATE SET
		price = o.price
WHEN NOT MATCHED
    THEN INSERT (marketeid, itemdefinition, submittereid, duration, isSell, price, quantity, usecorporationwallet, isvendoritem) VALUES
	(o.marketEid, o.itemDef, o.vendorEid, 0, 0, o.price, -1, 0, 1);
GO


PRINT N'18_Aggvalues_reinsert_npcmods4bosses__2021_04_04.sql';
USE [perpetuumsa]
GO

-----------------------------------------------------
-- Alpha static bosses stat tweaks
-- More base HP, less masking
-- Date modified: 2021/04/04
-----------------------------------------------------
PRINT N'DELETE/REINSERT NPC MODIFIERS for some bosses (aggregatevalues)';
DROP TABLE IF EXISTS #NPC_MODS;
CREATE TABLE #NPC_MODS(
	defName VARCHAR(100),
	fieldName VARCHAR(100),
	val FLOAT
);
INSERT INTO #NPC_MODS(defName, fieldName, val) VALUES
('def_npc_WilliamHBonnie','armor_max_modifier',1.5),
('def_npc_WilliamHBonnie','armor_repair_amount_modifier',0.25),
('def_npc_WilliamHBonnie','cpu_max_modifier',2),
('def_npc_WilliamHBonnie','damage_modifier',0.5),
('def_npc_WilliamHBonnie','missile_cycle_time_modifier',1),
('def_npc_WilliamHBonnie','powergrid_max_modifier',2),
('def_npc_WilliamHBonnie','speed_max_modifier',0.5),
('def_npc_WilliamHBonnie','turret_cycle_time_modifier',1),
('def_npc_WilliamHBonnie','received_repaired_modifier',0.1),
('def_npc_WilliamHBonnie','stealth_strength_modifier',-25),

('def_npc_Imperial_Infantry','armor_max_modifier',1.1),
('def_npc_Imperial_Infantry','armor_repair_amount_modifier',0.5),
('def_npc_Imperial_Infantry','cpu_max_modifier',2),
('def_npc_Imperial_Infantry','damage_modifier',0.6),
('def_npc_Imperial_Infantry','missile_cycle_time_modifier',1.2),
('def_npc_Imperial_Infantry','powergrid_max_modifier',2),
('def_npc_Imperial_Infantry','speed_max_modifier',0.4),
('def_npc_Imperial_Infantry','turret_cycle_time_modifier',1.4),
('def_npc_Imperial_Infantry','received_repaired_modifier',0.1),
('def_npc_Imperial_Infantry','stealth_strength_modifier',-25),

('def_npc_Tribal_Member','armor_max_modifier',1.1),
('def_npc_Tribal_Member','armor_repair_amount_modifier',0.5),
('def_npc_Tribal_Member','cpu_max_modifier',2),
('def_npc_Tribal_Member','damage_modifier',0.6),
('def_npc_Tribal_Member','missile_cycle_time_modifier',1.2),
('def_npc_Tribal_Member','powergrid_max_modifier',2),
('def_npc_Tribal_Member','speed_max_modifier',0.4),
('def_npc_Tribal_Member','turret_cycle_time_modifier',1.4),
('def_npc_Tribal_Member','received_repaired_modifier',0.1),
('def_npc_Tribal_Member','stealth_strength_modifier',-25),

('def_npc_Sacrist_Convert','armor_max_modifier',1.1),
('def_npc_Sacrist_Convert','armor_repair_amount_modifier',0.5),
('def_npc_Sacrist_Convert','cpu_max_modifier',2),
('def_npc_Sacrist_Convert','damage_modifier',0.6),
('def_npc_Sacrist_Convert','missile_cycle_time_modifier',1.2),
('def_npc_Sacrist_Convert','powergrid_max_modifier',2),
('def_npc_Sacrist_Convert','speed_max_modifier',0.4),
('def_npc_Sacrist_Convert','turret_cycle_time_modifier',1.4),
('def_npc_Sacrist_Convert','received_repaired_modifier',0.1),
('def_npc_Sacrist_Convert','stealth_strength_modifier',-25),

('def_npc_Sacrist_Mythic','armor_max_modifier',2.5),
('def_npc_Sacrist_Mythic','core_max_modifier',2),
('def_npc_Sacrist_Mythic','core_recharge_time_modifier',1),
('def_npc_Sacrist_Mythic','cpu_max_modifier',2),
('def_npc_Sacrist_Mythic','damage_modifier',1),
('def_npc_Sacrist_Mythic','falloff_modifier',1),
('def_npc_Sacrist_Mythic','locking_range_modifier',1),
('def_npc_Sacrist_Mythic','locking_time_modifier',1),
('def_npc_Sacrist_Mythic','missile_cycle_time_modifier',1),
('def_npc_Sacrist_Mythic','optimal_range_modifier',1),
('def_npc_Sacrist_Mythic','powergrid_max_modifier',2),
('def_npc_Sacrist_Mythic','turret_cycle_time_modifier',1),
('def_npc_Sacrist_Mythic','received_repaired_modifier',0.1),
('def_npc_Sacrist_Mythic','stealth_strength_modifier',-25),

('def_npc_clan_griffin','armor_max_modifier',2.5),
('def_npc_clan_griffin','core_max_modifier',2),
('def_npc_clan_griffin','core_recharge_time_modifier',1),
('def_npc_clan_griffin','cpu_max_modifier',2),
('def_npc_clan_griffin','damage_modifier',1),
('def_npc_clan_griffin','falloff_modifier',1),
('def_npc_clan_griffin','locking_range_modifier',1),
('def_npc_clan_griffin','locking_time_modifier',1),
('def_npc_clan_griffin','missile_cycle_time_modifier',1),
('def_npc_clan_griffin','optimal_range_modifier',1),
('def_npc_clan_griffin','powergrid_max_modifier',2),
('def_npc_clan_griffin','turret_cycle_time_modifier',1),
('def_npc_clan_griffin','received_repaired_modifier',0.1),
('def_npc_clan_griffin','stealth_strength_modifier',-25),

('def_npc_tribal_weaver','armor_max_modifier',2.5),
('def_npc_tribal_weaver','core_max_modifier',2),
('def_npc_tribal_weaver','core_recharge_time_modifier',1),
('def_npc_tribal_weaver','cpu_max_modifier',2),
('def_npc_tribal_weaver','damage_modifier',1),
('def_npc_tribal_weaver','falloff_modifier',1),
('def_npc_tribal_weaver','locking_range_modifier',1),
('def_npc_tribal_weaver','locking_time_modifier',1),
('def_npc_tribal_weaver','missile_cycle_time_modifier',1),
('def_npc_tribal_weaver','optimal_range_modifier',1),
('def_npc_tribal_weaver','powergrid_max_modifier',2),
('def_npc_tribal_weaver','turret_cycle_time_modifier',1),
('def_npc_tribal_weaver','received_repaired_modifier',0.1),
('def_npc_tribal_weaver','stealth_strength_modifier',-25),

('def_npc_One_Eye_Josef','armor_max_modifier',3),
('def_npc_One_Eye_Josef','core_max_modifier',2.5),
('def_npc_One_Eye_Josef','core_recharge_time_modifier',1),
('def_npc_One_Eye_Josef','cpu_max_modifier',2),
('def_npc_One_Eye_Josef','damage_modifier',0.75),
('def_npc_One_Eye_Josef','falloff_modifier',1.5),
('def_npc_One_Eye_Josef','locking_range_modifier',1.25),
('def_npc_One_Eye_Josef','locking_time_modifier',0.75),
('def_npc_One_Eye_Josef','missile_cycle_time_modifier',0.75),
('def_npc_One_Eye_Josef','optimal_range_modifier',1.5),
('def_npc_One_Eye_Josef','powergrid_max_modifier',2),
('def_npc_One_Eye_Josef','turret_cycle_time_modifier',1),
('def_npc_One_Eye_Josef','received_repaired_modifier',0.1),
('def_npc_One_Eye_Josef','stealth_strength_modifier',-25);

PRINT N'DELETE ALL AGG-VALS FOR THESE NPC DEFS';
DELETE FROM aggregatevalues WHERE definition IN (
	SELECT DISTINCT definition FROM entitydefaults WHERE definitionname IN (
		SELECT DISTINCT defName FROM #NPC_MODS
	)
);

PRINT N'RE-INSERT ALL AGG-VALS FOR THESE NPC DEFS';
INSERT INTO aggregatevalues (definition, field, value)
SELECT
	(SELECT TOP 1 definition FROM entitydefaults WHERE defName=definitionname),
	(SELECT TOP 1 id FROM aggregatefields WHERE name=fieldName),
	val
FROM #NPC_MODS;

PRINT N'DONE RE-INSERTING NPC AGG VALUES';
DROP TABLE IF EXISTS #NPC_MODS;
GO


PRINT N'19_AggFields_update_projectilemod_digits__2021_04_04.sql';
USE [perpetuumsa]
GO

-----------------------------------
-- Set digits for these fields
-- Date: 2021/04/04
-----------------------------------

UPDATE aggregatefields SET
	digits=2
WHERE name IN ('projectile_falloff_modifier', 'projectile_optimal_range_modifier');

GO


PRINT N'20_Anniversarybot_gifts_inserts__2021_04_05.sql';
USE [perpetuumsa]
GO

-----------------------------------------------
--OPP 3 Year of LIVE server anniversary gifts!
--New robot definition
--New Package and gifts
--Procedure call to distribute gifts
--Date: 2021/04/05
-----------------------------------------------

DECLARE @botName AS VARCHAR(100) = 'def_anniversarkhe_year3_bot';
DECLARE @botDef AS INT = 5999;

IF EXISTS (SELECT definition FROM entitydefaults WHERE definitionname=@botName)
BEGIN
	PRINT N'BOT ALREADY INSERTED, SKIPPING';
	SET NOEXEC ON;
END


PRINT N'1. Create entity';
--WARNING: options string contains references to entitydefaults in hex (Head/leg/chassis are fixed definitions from arkhe mk2)
--ENTITYDEFAULT SAVE NEW
SET IDENTITY_INSERT entitydefaults ON;
INSERT INTO entitydefaults (definition, definitionname, quantity, attributeflags, categoryflags, options, note, enabled,  volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
VALUES (@botDef, @botName, 1, 0, 257, '#head=iae8#chassis=iae9#leg=iaea#container=i147#tier=$tierlevel_mk2', 'New Arkhe for 3yr aniversary!', 1, 12, 0, 0, 100, CONCAT(@botName, '_desc'), 1, 1, 2); 
SET IDENTITY_INSERT entitydefaults OFF;

PRINT N'2. Create template (from tool)';
--WARNING: description string contains references to entitydefaults in hex
--TEMPLATE INSERT

DECLARE @definitionHex varchar;
--This is how to do lookups, convert to hex, and concat into a genxy compatible string!
SET @definitionHex = (SELECT dbo.ToHex(definition) FROM entitydefaults WHERE definitionname=@botName);

INSERT INTO robottemplates ([name], [description], [note]) 
VALUES (CONCAT(@botName, '_template'), '#robot=i'+@definitionHex+'#head=iae8#chassis=iae9#leg=iaea#container=i147#headModules=[|m0=[|definition=i0|slot=i1]]#chassisModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]]#legModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]]', 'OPP Live 2 year anniversary Reward');


PRINT N'3. Create templaterelation';
INSERT INTO [dbo].[robottemplaterelation]
           ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
     VALUES
           ((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@botName)
           ,(SELECT TOP 1 id FROM robottemplates WHERE name=CONCAT(@botName, '_template')),0,1,NULL,NULL,NULL,'AnniversArkhe Template Relation year3');


PRINT N'4. Insert config w/ desired tint';
INSERT INTO [dbo].[definitionconfig]
           ([definition],[tint],[note])
     VALUES
           ((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@botName)
           ,'#ff99de'
           ,'Color for AnniversArkhe2 bot');


PRINT N'5. Give bot skills -- ARKHE MK2 HAS NO ENABLER SKILLS RESULT WILL BE 0 rows affected';
--Use existing bot (that was copied from entitydefault) for extensions
INSERT INTO [dbo].[enablerextensions] ([definition],[extensionid],[extensionlevel])
     (SELECT (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@botName), extensionid, extensionlevel FROM enablerextensions WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_arkhe2_bot'));

SET NOEXEC OFF;
PRINT N'DONE INSERTING NEW BOT';

IF EXISTS (SELECT * FROM [packages] WHERE name='opp-anniversary03')
BEGIN
	PRINT N'PACKAGE ALREADY CREATED, SKIPPING';
	SET NOEXEC ON;
END

PRINT N'Create Packages for pre-alpha participant levels';
INSERT INTO [dbo].[packages]
           ([name],[note])
     VALUES
           ('opp-anniversary03','3nd year of OPP Live!');

PRINT N'Insert items into Packages for pre-alpha participant levels';
DECLARE @packid int;
SET @packid = (SELECT TOP 1 id FROM packages WHERE name='opp-anniversary03');

DECLARE @aid int;
SET @aid = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_anniversary_package');

DECLARE @specialBot int;
SET @specialBot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@botName);

DECLARE @epBoostT3 AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_boost_ep_t3');

PRINT N'Items for opp-anniversary03!!!';
INSERT INTO [dbo].[packageitems]
           ([packageid],[definition],[quantity])
     VALUES
           (@packid, @aid, 3), 
		   (@packid, @specialBot, 1),
		   (@packid, @epBoostT3, 1);

SET NOEXEC OFF;
PRINT N'DONE INSERTING GIFT-PACKS';
GO


PRINT N'DISTRIBUTE GIFTS TO ALL ACCOUNTS';
DECLARE @packid int;
SET @packid = (SELECT TOP 1 id FROM packages WHERE name='opp-anniversary03');
--TODO use variant of below for future gifting
--This gift gives to all current accounts at patch-time
PRINT N'Give everyone a gift! WARNING CURSOR AHEAD!';
DECLARE @id int;
DECLARE @pass varchar(100);

DECLARE curse CURSOR FOR SELECT accountID FROM accounts
OPEN curse

FETCH NEXT FROM curse INTO @id

WHILE @@FETCH_STATUS = 0 BEGIN
    EXEC dbo.accountPackageProcessOne @id, @packid
    FETCH NEXT FROM curse INTO @id
END

CLOSE curse    
DEALLOCATE curse
PRINT N'DONE';
GO


PRINT N'ZZ_01_Zones_Insert_71__2021_03_31.sql';
USE [perpetuumsa]
GO

-------------------------------------------------------------
-- INSERT ZONE 71
-- DATE MODIFIED: 2021/03/31
-------------------------------------------------------------

--Zone columns
DECLARE @zoneId INT;
SET @zoneId=71; --Zone ID!  Must be same as layer numbers!

DECLARE @size INT;
SET @size = 256; --Double check this!

DECLARE @x INT;
DECLARE @y INT;
DECLARE @zoneName VARCHAR(50);
DECLARE @zoneDesc VARCHAR(50);
DECLARE @note VARCHAR(2048);
DECLARE @fertility INT;
DECLARE @zoneplugin NVARCHAR(50);
DECLARE @zoneip NVARCHAR(50);
DECLARE @zoneport INT;
DECLARE @isInstance BIT;
DECLARE @enabled BIT;
DECLARE @spawnId INT;
DECLARE @plantRuleset INT;
DECLARE @protected BIT;
DECLARE @raceId INT;
DECLARE @width INT;
DECLARE @height INT;
DECLARE @terraformable BIT;
DECLARE @zoneType INT;
DECLARE @sparkCost INT;
DECLARE @maxDockingBase INT;
DECLARE @sleeping BIT;
DECLARE @plantAltitudeScale FLOAT;
DECLARE @host VARCHAR(50);
DECLARE @active BIT;
--NPCSpawn for zone
DECLARE @spawnName VARCHAR(50);
DECLARE @spawnDesc VARCHAR(50);
DECLARE @spawnNote NVARCHAR(2000);
--Entity columns for zone storage entity
DECLARE @eid BIGINT;
DECLARE @definition INT;
DECLARE @ename VARCHAR(128);

--Insert NPCSpawn first for npcspawnid
SET @spawnName = 'zone_strghld_' + CONVERT(varchar(10), @zoneId) + '_spawn';
SET @spawnDesc = 'zone_strghld_' + CONVERT(varchar(10), @zoneId) + '_spawn';
SET @spawnNote = 'Stronghold spawn for NPC base ' + CONVERT(varchar(10), @zoneId);

PRINT N'INSERTING/UPDATING NPCSPAWN TABLE';
IF EXISTS (SELECT TOP 1 id FROM npcspawn WHERE name=@spawnName)
BEGIN
	UPDATE npcspawn SET
		description=@spawnDesc,
		note=@spawnNote
	WHERE name=@spawnName;
END
ELSE
BEGIN
	INSERT INTO [dbo].[npcspawn] ([name],[description],[note])
	VALUES (@spawnName, @spawnDesc, @spawnNote);
END

--SET ZONE PARAMETERS

SET @x=15000;
SET @y=10000;
SET @zoneName = 'zone_strghld_' + CONVERT(varchar(10), @zoneId);
SET @zoneDesc = @zoneName + '_desc';
SET @note = 'NPCStrongholdBase'+CONVERT(varchar(10), @zoneId);
SET @fertility = 20;
SET @zoneplugin = 'zone_'+CONVERT(varchar(10), @zoneId)
SET @zoneip = '109.236.88.106'
SET @zoneport = 18800+@zoneId;
SET @isInstance =0;
SET @enabled =1;
SET @spawnId = (SELECT TOP 1 id FROM npcspawn WHERE name=@spawnName);
SET @plantRuleset = @zoneId;
SET @protected =1;
SET @raceId = 1;
SET @width = @size;
SET @height = @size;
SET @terraformable =0;
SET @zoneType =4;
SET @sparkCost =3;
SET @maxDockingBase = 0;
SET @sleeping= 0;
SET @plantAltitudeScale =1;
SET @host ='genxyHost-01';
SET @active =1;

PRINT N'DELETE/REINSERT NEW PLANTRULE FOR ZONE';
DROP TABLE IF EXISTS #PLANTRULE;
CREATE TABLE #PLANTRULE(
	ruleFile VARCHAR(100)
);
INSERT INTO #PLANTRULE (ruleFile) VALUES
--('bonsai.txt'),
('bush_a.txt'),
('bush_b.txt'),
('coppertree.txt'),
--('devrinol.txt'),
('grass_a.txt'),
('grass_b.txt'),
('nanowheat.txt'),
('pinetree.txt'),
--('poffeteg.txt'),
('quag.txt'),
--('rango.txt'),
('rango_lowaltitude.txt'),
--('reed.txt'),
('titanplant.txt');

DELETE FROM plantrules WHERE rulesetid=@plantRuleset;
INSERT INTO plantrules (plantrule, rulesetid, note)
SELECT ruleFile, @plantRuleset, 'stronghold plant rules' FROM #PLANTRULE;

DROP TABLE IF EXISTS #PLANTRULE;

--SET ENTITY FOR ZONE STORAGE
SET @eid=(SELECT TOP 1 eid + 1 FROM entities WHERE eid + 1 NOT IN (SELECT DISTINCT eid FROM entities));
SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_zone_storage');
SET @ename = 'es_zone_'+CONVERT(varchar(10), @zoneId)+'_storage';

PRINT N'INSERTING/UPDATING ENTITIES TABLE';
IF EXISTS (SELECT TOP 1 eid FROM entities WHERE ename=@ename)
BEGIN
	UPDATE entities SET
		definition=@definition
	WHERE ename=@ename;
	SET @eid = (SELECT TOP 1 eid FROM entities WHERE ename=@ename);
END
ELSE
BEGIN
	INSERT INTO [dbo].[entities]
			   ([eid],[definition],[owner],[parent],[health],[ename],[quantity],[repackaged],[dynprop])
		 VALUES
			   (@eid,@definition,NULL,NULL,100,@ename,1,0,NULL);
END

PRINT N'INSERTING/UPDATING entitystorage TABLE';
IF EXISTS (SELECT TOP 1 eid FROM entitystorage WHERE storage_name=@ename)
BEGIN
	UPDATE entitystorage SET
		eid=@eid
	WHERE storage_name=@ename;
END
ELSE
BEGIN
	INSERT INTO [dbo].[entitystorage]
			   (storage_name,eid)
		 VALUES
			   (@ename,@eid);
END

PRINT N'INSERTING/UPDATING ZONE TABLE';
IF EXISTS (SELECT TOP 1 id FROM zones WHERE name=@zoneName AND description=@zoneName+'_desc')
BEGIN
	UPDATE zones SET
		id=@zoneId,
		x=@x,
		y=@y,
		name=@zoneName,
		description=@zoneDesc,
		note=@note,
		fertility=@fertility,
		zoneplugin=@zoneplugin,
		zoneport=@zoneport,
		isinstance=@isInstance,
		enabled=@enabled,
		spawnid=@spawnId,
		plantruleset=@plantRuleset,
		protected=@protected,
		raceid=@raceId,
		width=@width,
		height=@height,
		terraformable=@terraformable,
		zonetype=@zoneType,
		sparkcost=@sparkCost,
		maxdockingbase=@maxDockingBase,
		sleeping=@sleeping,
		plantaltitudescale=@plantAltitudeScale,
		host=@host,
		active=@active
	WHERE name=@zoneName;

END
ELSE
BEGIN
	INSERT INTO [dbo].[zones]
           ([id],[x],[y],[name],[description],[note],[fertility],[zoneplugin],[zoneip],[zoneport],[isinstance],[enabled],[spawnid],[plantruleset]
		   ,[protected],[raceid],[width],[height],[terraformable],[zonetype],[sparkcost],[maxdockingbase],[sleeping],[plantaltitudescale],[host],[active])
     VALUES
           (@zoneId,@x,@y,@zoneName,@zoneDesc,@note,@fertility,@zoneplugin,@zoneip,@zoneport,@isInstance,@enabled,@spawnId,@plantRuleset
           ,@protected,@raceId,@width,@height,@terraformable,@zoneType,@sparkCost,@maxDockingBase,@sleeping,@plantAltitudeScale,@host,@active);
END


PRINT N'NEW ZONE READY!';
GO


PRINT N'ZZ_02_Zones_Insert_72__2021_03_31.sql';
USE [perpetuumsa]
GO

-------------------------------------------------------------
-- INSERT ZONE 72
-- DATE MODIFIED: 2021/03/31
-------------------------------------------------------------

--Zone columns
DECLARE @zoneId INT;
SET @zoneId=72; --Zone ID!  Must be same as layer numbers!

DECLARE @size INT;
SET @size = 256; --Double check this!

DECLARE @x INT;
DECLARE @y INT;
DECLARE @zoneName VARCHAR(50);
DECLARE @zoneDesc VARCHAR(50);
DECLARE @note VARCHAR(2048);
DECLARE @fertility INT;
DECLARE @zoneplugin NVARCHAR(50);
DECLARE @zoneip NVARCHAR(50);
DECLARE @zoneport INT;
DECLARE @isInstance BIT;
DECLARE @enabled BIT;
DECLARE @spawnId INT;
DECLARE @plantRuleset INT;
DECLARE @protected BIT;
DECLARE @raceId INT;
DECLARE @width INT;
DECLARE @height INT;
DECLARE @terraformable BIT;
DECLARE @zoneType INT;
DECLARE @sparkCost INT;
DECLARE @maxDockingBase INT;
DECLARE @sleeping BIT;
DECLARE @plantAltitudeScale FLOAT;
DECLARE @host VARCHAR(50);
DECLARE @active BIT;
--NPCSpawn for zone
DECLARE @spawnName VARCHAR(50);
DECLARE @spawnDesc VARCHAR(50);
DECLARE @spawnNote NVARCHAR(2000);
--Entity columns for zone storage entity
DECLARE @eid BIGINT;
DECLARE @definition INT;
DECLARE @ename VARCHAR(128);

--Insert NPCSpawn first for npcspawnid
SET @spawnName = 'zone_strghld_' + CONVERT(varchar(10), @zoneId) + '_spawn';
SET @spawnDesc = 'zone_strghld_' + CONVERT(varchar(10), @zoneId) + '_spawn';
SET @spawnNote = 'Stronghold spawn for NPC base ' + CONVERT(varchar(10), @zoneId);

PRINT N'INSERTING/UPDATING NPCSPAWN TABLE';
IF EXISTS (SELECT TOP 1 id FROM npcspawn WHERE name=@spawnName)
BEGIN
	UPDATE npcspawn SET
		description=@spawnDesc,
		note=@spawnNote
	WHERE name=@spawnName;
END
ELSE
BEGIN
	INSERT INTO [dbo].[npcspawn] ([name],[description],[note])
	VALUES (@spawnName, @spawnDesc, @spawnNote);
END

--SET ZONE PARAMETERS

SET @x=15000;
SET @y=11000;
SET @zoneName = 'zone_strghld_' + CONVERT(varchar(10), @zoneId);
SET @zoneDesc = @zoneName + '_desc';
SET @note = 'NPCStrongholdBase'+CONVERT(varchar(10), @zoneId);
SET @fertility = 20;
SET @zoneplugin = 'zone_'+CONVERT(varchar(10), @zoneId)
SET @zoneip = '109.236.88.106'
SET @zoneport = 18800+@zoneId;
SET @isInstance =0;
SET @enabled =1;
SET @spawnId = (SELECT TOP 1 id FROM npcspawn WHERE name=@spawnName);
SET @plantRuleset = @zoneId;
SET @protected =1;
SET @raceId = 1;
SET @width = @size;
SET @height = @size;
SET @terraformable =0;
SET @zoneType =4;
SET @sparkCost =3;
SET @maxDockingBase = 0;
SET @sleeping= 0;
SET @plantAltitudeScale =1;
SET @host ='genxyHost-01';
SET @active =1;

PRINT N'DELETE/REINSERT NEW PLANTRULE FOR ZONE';
DROP TABLE IF EXISTS #PLANTRULE;
CREATE TABLE #PLANTRULE(
	ruleFile VARCHAR(100)
);
INSERT INTO #PLANTRULE (ruleFile) VALUES
--('bonsai.txt'),
('bush_a.txt'),
('bush_b.txt'),
('coppertree.txt'),
--('devrinol.txt'),
('grass_a.txt'),
('grass_b.txt'),
('nanowheat.txt'),
('pinetree.txt'),
--('poffeteg.txt'),
('quag.txt'),
--('rango.txt'),
('rango_lowaltitude.txt'),
--('reed.txt'),
('titanplant.txt');

DELETE FROM plantrules WHERE rulesetid=@plantRuleset;
INSERT INTO plantrules (plantrule, rulesetid, note)
SELECT ruleFile, @plantRuleset, 'stronghold plant rules' FROM #PLANTRULE;

DROP TABLE IF EXISTS #PLANTRULE;

--SET ENTITY FOR ZONE STORAGE
SET @eid=(SELECT TOP 1 eid + 1 FROM entities WHERE eid + 1 NOT IN (SELECT DISTINCT eid FROM entities));
SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_zone_storage');
SET @ename = 'es_zone_'+CONVERT(varchar(10), @zoneId)+'_storage';

PRINT N'INSERTING/UPDATING ENTITIES TABLE';
IF EXISTS (SELECT TOP 1 eid FROM entities WHERE ename=@ename)
BEGIN
	UPDATE entities SET
		definition=@definition
	WHERE ename=@ename;
	SET @eid = (SELECT TOP 1 eid FROM entities WHERE ename=@ename);
END
ELSE
BEGIN
	INSERT INTO [dbo].[entities]
			   ([eid],[definition],[owner],[parent],[health],[ename],[quantity],[repackaged],[dynprop])
		 VALUES
			   (@eid,@definition,NULL,NULL,100,@ename,1,0,NULL);
END

PRINT N'INSERTING/UPDATING entitystorage TABLE';
IF EXISTS (SELECT TOP 1 eid FROM entitystorage WHERE storage_name=@ename)
BEGIN
	UPDATE entitystorage SET
		eid=@eid
	WHERE storage_name=@ename;
END
ELSE
BEGIN
	INSERT INTO [dbo].[entitystorage]
			   (storage_name,eid)
		 VALUES
			   (@ename,@eid);
END

PRINT N'INSERTING/UPDATING ZONE TABLE';
IF EXISTS (SELECT TOP 1 id FROM zones WHERE name=@zoneName AND description=@zoneName+'_desc')
BEGIN
	UPDATE zones SET
		id=@zoneId,
		x=@x,
		y=@y,
		name=@zoneName,
		description=@zoneDesc,
		note=@note,
		fertility=@fertility,
		zoneplugin=@zoneplugin,
		zoneport=@zoneport,
		isinstance=@isInstance,
		enabled=@enabled,
		spawnid=@spawnId,
		plantruleset=@plantRuleset,
		protected=@protected,
		raceid=@raceId,
		width=@width,
		height=@height,
		terraformable=@terraformable,
		zonetype=@zoneType,
		sparkcost=@sparkCost,
		maxdockingbase=@maxDockingBase,
		sleeping=@sleeping,
		plantaltitudescale=@plantAltitudeScale,
		host=@host,
		active=@active
	WHERE name=@zoneName;

END
ELSE
BEGIN
	INSERT INTO [dbo].[zones]
           ([id],[x],[y],[name],[description],[note],[fertility],[zoneplugin],[zoneip],[zoneport],[isinstance],[enabled],[spawnid],[plantruleset]
		   ,[protected],[raceid],[width],[height],[terraformable],[zonetype],[sparkcost],[maxdockingbase],[sleeping],[plantaltitudescale],[host],[active])
     VALUES
           (@zoneId,@x,@y,@zoneName,@zoneDesc,@note,@fertility,@zoneplugin,@zoneip,@zoneport,@isInstance,@enabled,@spawnId,@plantRuleset
           ,@protected,@raceId,@width,@height,@terraformable,@zoneType,@sparkCost,@maxDockingBase,@sleeping,@plantAltitudeScale,@host,@active);
END


PRINT N'NEW ZONE READY!';
GO


PRINT N'ZZ_03_strongholdexit_npcbossinfo__2021_02_26.sql';
USE [perpetuumsa]
GO

------------------------------------------------
-- Zone 71-72 Stronghold Exit anom configs
--
-- Date: 2021/03/30
------------------------------------------------
PRINT N'CONFIGURE STRONGHOND ZONE 71, 72 ENTRANCE AND EXITS';

PRINT N'EXIT TEMP TABLE';
DROP TABLE IF EXISTS #EXITS;
CREATE TABLE #EXITS(
	zoneid INT,
	x INT,
	y INT
);
INSERT INTO #EXITS (zoneid, x, y) VALUES
(71, 20, 175),
(71, 211, 119),
(72, 219, 28),
(72, 89, 185);

PRINT N'DELETE AND REINSERT FOR ZONES (71,72)';
DELETE FROM strongholdexitconfig WHERE zoneid IN (SELECT DISTINCT zoneid FROM #EXITS);
INSERT INTO strongholdexitconfig (zoneid, x, y)
SELECT zoneid, x, y FROM #EXITS;

DROP TABLE IF EXISTS #EXITS;
GO



PRINT N'ZZ_04_Npc_defs_templates_stats_waves__2021_03_31.sql';
USE [perpetuumsa]
GO

----------------------------------------------------------------
-- Stronghold 71-72 npcs WIP script
--
-- Date mod: 2021/03/31
----------------------------------------------------------------

IF NOT EXISTS (SELECT id FROM zones WHERE name='zone_strghld_71') OR
NOT EXISTS (SELECT 1 FROM zones WHERE name='zone_strghld_72')
BEGIN
	PRINT N'ZONE 71-72 NOT FOUND! ABORTING EXECUTION';
	SET NOEXEC ON;
END

DECLARE @zone71SpawnId AS INT = (SELECT TOP 1 spawnid FROM zones WHERE name='zone_strghld_71');
DECLARE @zone72SpawnId AS INT = (SELECT TOP 1 spawnid FROM zones WHERE name='zone_strghld_72');

DROP TABLE IF EXISTS #ED;
CREATE TABLE #ED (
	def INT,
	defName VARCHAR(128),
	templateName VARCHAR(128),
	template VARCHAR(MAX) NULL,
	epKill INT,
);

INSERT INTO #ED (def, defName, templateName, epKill, template) VALUES
(5931, 'def_npc_Zone71_WilliamHBonnie', 'Zone71_WilliamHBonnie', 100, '#robot=i1590#head=i1591#chassis=i1592#leg=i1593#container=i149#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i33|slot=i2]|m2=[|definition=i32|slot=i3]|m3=[|definition=i0|slot=i4]|m4=[|definition=i0|slot=i5]]#chassisModules=[|m0=[|definition=i3d|slot=i1|ammoDefinition=i986|ammoQuantity=i1f4]|m1=[|definition=i3d|slot=i2|ammoDefinition=i988|ammoQuantity=i1f4]|m2=[|definition=i23|slot=i3]]#legModules=[|m0=[|definition=i10|slot=i1]|m1=[|definition=i19|slot=i2]|m2=[|definition=i12a|slot=i3]|m3=[|definition=i10|slot=i4]|m4=[|definition=i9f5|slot=i5]]'),
(5932, 'def_npc_Helix_BossGuard', 'Helix_Boss_Guard', 15, '#robot=i1584#head=i1585#chassis=i1586#leg=i1587#container=i146#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i33|slot=i2]|m2=[|definition=i32|slot=i3]|m3=[|definition=i0|slot=i4]]#chassisModules=[|m0=[|definition=i26|slot=i1]|m1=[|definition=i26|slot=i2]|m2=[|definition=i3c|slot=i3|ammoDefinition=i984|ammoQuantity=ifa]]#legModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]|m2=[|definition=i0|slot=i3]]'),
(5933, 'def_npc_Zone72_One_Eye_Josef', 'echelon_masterdeathdealer', 150, NULL),
(5934, 'def_npc_Rough_Rider_Death_Dealer', 'echelon_masterdeathdealer', 10, NULL);

DROP TABLE IF EXISTS #NPC_MODS;
CREATE TABLE #NPC_MODS (
	defName VARCHAR(128),
	fieldName VARCHAR(128),
	val FLOAT
);

INSERT INTO #NPC_MODS (defName, fieldName, val) VALUES
('def_npc_Zone71_WilliamHBonnie','armor_max_modifier',3),
('def_npc_Zone71_WilliamHBonnie','core_max_modifier',2.5),
('def_npc_Zone71_WilliamHBonnie','cpu_max_modifier',2),
('def_npc_Zone71_WilliamHBonnie','damage_modifier',0.25),
('def_npc_Zone71_WilliamHBonnie','missile_cycle_time_modifier',1),
('def_npc_Zone71_WilliamHBonnie','powergrid_max_modifier',2),
('def_npc_Zone71_WilliamHBonnie','speed_max_modifier',0.5),
('def_npc_Zone71_WilliamHBonnie','turret_cycle_time_modifier',0.75),
('def_npc_Helix_BossGuard','armor_max_modifier',1.25),
('def_npc_Helix_BossGuard','core_max_modifier',2),
('def_npc_Helix_BossGuard','core_recharge_time_modifier',0.5),
('def_npc_Helix_BossGuard','cpu_max_modifier',2),
('def_npc_Helix_BossGuard','damage_modifier',1),
('def_npc_Helix_BossGuard','falloff_modifier',1.25),
('def_npc_Helix_BossGuard','locking_range_modifier',1.25),
('def_npc_Helix_BossGuard','locking_time_modifier',0.75),
('def_npc_Helix_BossGuard','optimal_range_modifier',1.25),
('def_npc_Helix_BossGuard','powergrid_max_modifier',2),
('def_npc_Zone72_One_Eye_Josef','armor_max_modifier',3),
('def_npc_Zone72_One_Eye_Josef','core_max_modifier',2.5),
('def_npc_Zone72_One_Eye_Josef','core_recharge_time_modifier',1),
('def_npc_Zone72_One_Eye_Josef','cpu_max_modifier',2),
('def_npc_Zone72_One_Eye_Josef','damage_modifier',0.5),
('def_npc_Zone72_One_Eye_Josef','falloff_modifier',1.5),
('def_npc_Zone72_One_Eye_Josef','locking_range_modifier',1.5),
('def_npc_Zone72_One_Eye_Josef','locking_time_modifier',0.75),
('def_npc_Zone72_One_Eye_Josef','missile_cycle_time_modifier',0.75),
('def_npc_Zone72_One_Eye_Josef','optimal_range_modifier',1.5),
('def_npc_Zone72_One_Eye_Josef','powergrid_max_modifier',2),
('def_npc_Zone72_One_Eye_Josef','turret_cycle_time_modifier',1),
('def_npc_Rough_Rider_Death_Dealer','armor_max_modifier',1.25),
('def_npc_Rough_Rider_Death_Dealer','armor_repair_amount_modifier',0.25),
('def_npc_Rough_Rider_Death_Dealer','cpu_max_modifier',2),
('def_npc_Rough_Rider_Death_Dealer','damage_modifier',0.5),
('def_npc_Rough_Rider_Death_Dealer','missile_cycle_time_modifier',1.25),
('def_npc_Rough_Rider_Death_Dealer','powergrid_max_modifier',2),
('def_npc_Rough_Rider_Death_Dealer','speed_max_modifier',0.75),
('def_npc_Rough_Rider_Death_Dealer','turret_cycle_time_modifier',1.4),
('def_npc_Rough_Rider_Death_Dealer','received_repaired_modifier',0.1);


DROP TABLE IF EXISTS #PRES;
CREATE TABLE #PRES(
	presName VARCHAR(128),
	spawnId INT,	
);
INSERT INTO #PRES(presName, spawnId)VALUES
('pres_z71_grp1', @zone71SpawnId),
('pres_z71_grp2', @zone71SpawnId),
('pres_z71_grp3', @zone71SpawnId),
('pres_z71_grp4', @zone71SpawnId),

('pres_z72_grp1', @zone72SpawnId),
('pres_z72_grp2', @zone72SpawnId),
('pres_z72_grp3', @zone72SpawnId),
('pres_z72_grp4', @zone72SpawnId),
('pres_z72_grp5', @zone72SpawnId),
('pres_z72_grp6', @zone72SpawnId);

DROP TABLE IF EXISTS #FLOCKS;
CREATE TABLE #FLOCKS(
	flockName VARCHAR(128),
	presName VARCHAR(128),
	npcName VARCHAR(128),
	flockCount INT,
	x INT,
	y INT,
	sMin INT,
	sMax INT,
	respawnSeconds INT,
	homeRange INT,
);

INSERT INTO #FLOCKS (flockName, presName, npcName, flockCount, x, y, sMin, sMax, respawnSeconds, homeRange) VALUES
('RR_Light_71_GRP1', 'pres_z71_grp1', 'def_npc_RoughRider_Scout', 1, 112, 192, 1, 5, 900, 35),
('RR_Assault_71_GRP1', 'pres_z71_grp1', 'def_npc_RoughRider_Cavalry', 1, 112, 192, 1, 5, 900, 35),
('RR_Light_71_GRP2', 'pres_z71_grp2', 'def_npc_RoughRider_Scout', 1, 139, 141, 1, 5, 900, 35),
('RR_Assault_71_GRP3', 'pres_z71_grp3', 'def_npc_RoughRider_Cavalry', 1, 169, 75, 1, 5, 900, 35),
('RR_Boss_71_GRP4', 'pres_z71_grp4', 'def_npc_Zone71_WilliamHBonnie', 1, 209, 116, 1, 5, 5400, 55),
('RR_Lewar_71_GRP4', 'pres_z71_grp4', 'def_npc_Helix_BossGuard', 2, 208, 116, 1, 5, 900, 55),
('RR_Assault_71_GRP4', 'pres_z71_grp4', 'def_npc_RoughRider_Cavalry', 1, 208, 116, 1, 5, 900, 45),

('RR_Light_72_GRP1', 'pres_z72_grp1', 'def_npc_RoughRider_Scout', 1, 133, 75, 1, 5, 900, 45),
('RR_Assault_72_GRP2', 'pres_z72_grp2', 'def_npc_RoughRider_Cavalry', 1, 53, 80, 1, 5, 900, 45),
('RR_Mech_72_GRP2', 'pres_z72_grp2', 'def_npc_Rough_Rider_Death_Dealer', 1, 53, 80, 1, 5, 900, 45),
('RR_Mech_72_GRP3', 'pres_z72_grp4', 'def_npc_Rough_Rider_Death_Dealer', 1, 58, 130, 1, 5, 900, 45),
('RR_Boss_72_GRP4', 'pres_z72_grp4', 'def_npc_Zone72_One_Eye_Josef', 1, 86, 179, 1, 5, 5400, 45),
('RR_Mech_72_GRP5', 'pres_z72_grp4', 'def_npc_Rough_Rider_Death_Dealer', 1, 86, 179, 1, 5, 900, 45),
('RR_Lewar_72_GRP5', 'pres_z72_grp4', 'def_npc_Helix_BossGuard', 1, 86, 179, 1, 5, 900, 55),
('RR_Light_72_GRP5', 'pres_z72_grp5', 'def_npc_Rough_Rider_Death_Dealer', 1, 161, 95, 1, 5, 900, 45),
('IMHM_HM_72_GRP6', 'pres_z72_grp6', 'def_npc_riveler_basic_rank5', 1, 208, 180, 1, 5, 900, 45),
('RR_Lewar_72_GRP6', 'pres_z72_grp6', 'def_npc_Helix_BossGuard', 2, 208, 180, 1, 5, 900, 55),
('IHM_HM_72_GRP6', 'pres_z72_grp6', 'def_npc_scarab_basic_rank5', 1, 208, 180, 1, 5, 900, 45);

DROP TABLE IF EXISTS #BOSSINFO;
CREATE TABLE #BOSSINFO (
	flockName VARCHAR(128),
	respawnNoise FLOAT,
	aggMsg VARCHAR(128),
	deathMsg VARCHAR(128)
);

INSERT INTO #BOSSINFO (flockName, respawnNoise, aggMsg, deathMsg) VALUES
('RR_Boss_71_GRP4', 0.1, 'Alright boys, leave no witnesses. We cant have the Syndicate tracking this location!', 'You have not seen the last of the Rough Riders!'),
('RR_Boss_72_GRP4', 0.1, 'I may have one eye, but I can see you are fixin for a fight.', 'You fool! Dont you know the Syndicate is using you to ... *explodes*');


DECLARE @behaviourType AS INT = 2; --aggressive
DROP TABLE IF EXISTS #WAVES;
CREATE TABLE #WAVES (
	targetFlockName VARCHAR(100),
	presenceName VARCHAR(100),
	npcDefName VARCHAR(100),
	numInFlock INT,
	thresh FLOAT
);
INSERT INTO #WAVES (targetFlockName, presenceName, npcDefName, numInFlock, thresh) VALUES
--Stronghold 71 boss waves
('RR_Boss_71_GRP4', 'reinforce_stronghold_miniboss_a_z71_wave_0', 'def_npc_RoughRider_Scout', 1, 0.05),

('RR_Boss_71_GRP4', 'reinforce_stronghold_miniboss_a_z71_wave_1', 'def_npc_RoughRider_Scout', 1, 0.25),
('RR_Boss_71_GRP4', 'reinforce_stronghold_miniboss_a_z71_wave_1', 'def_npc_RoughRider_Cavalry', 1, 0.25),

('RR_Boss_71_GRP4', 'reinforce_stronghold_miniboss_a_z71_wave_2', 'def_npc_RoughRider_Scout', 1, 0.55),
('RR_Boss_71_GRP4', 'reinforce_stronghold_miniboss_a_z71_wave_2', 'def_npc_RoughRider_Cavalry', 1, 0.55),
('RR_Boss_71_GRP4', 'reinforce_stronghold_miniboss_a_z71_wave_2', 'def_npc_Helix_BossGuard', 1, 0.55),

('RR_Boss_71_GRP4', 'reinforce_stronghold_miniboss_a_z71_wave_3', 'def_npc_Helix_BossGuard', 2, 0.75),

--Stronghold 72 boss waves
('RR_Boss_72_GRP4', 'reinforce_stronghold_miniboss_a_z72_wave_0', 'def_npc_RoughRider_Cavalry', 1, 0.05),

('RR_Boss_72_GRP4', 'reinforce_stronghold_miniboss_a_z72_wave_1', 'def_npc_RoughRider_Cavalry', 1, 0.25),
('RR_Boss_72_GRP4', 'reinforce_stronghold_miniboss_a_z72_wave_1', 'def_npc_Helix_BossGuard', 1, 0.25),

('RR_Boss_72_GRP4', 'reinforce_stronghold_miniboss_a_z72_wave_2', 'def_npc_RoughRider_Cavalry', 1, 0.55),
('RR_Boss_72_GRP4', 'reinforce_stronghold_miniboss_a_z72_wave_2', 'def_npc_Helix_BossGuard', 2, 0.55),
('RR_Boss_72_GRP4', 'reinforce_stronghold_miniboss_a_z72_wave_2', 'def_npc_Rough_Rider_Death_Dealer', 1, 0.55),

('RR_Boss_72_GRP4', 'reinforce_stronghold_miniboss_a_z72_wave_3', 'def_npc_Helix_BossGuard', 2, 0.75),
('RR_Boss_72_GRP4', 'reinforce_stronghold_miniboss_a_z72_wave_3', 'def_npc_Rough_Rider_Death_Dealer', 2, 0.75);

PRINT N'DELETE npcflock, npcpresence, npcreinforcements IF EXISTS where data in temp table';
DELETE FROM npcflock WHERE presenceid in (SELECT id FROM npcpresence WHERE name in (SELECT DISTINCT presenceName FROM #WAVES));
DELETE FROM npcpresence WHERE name in (SELECT DISTINCT presenceName FROM #WAVES);
DELETE FROM npcreinforcements WHERE targetId in (SELECT id FROM npcflock WHERE name IN (SELECT DISTINCT targetFlockName from #WAVES));


PRINT N'DELETE npc def, templates, and all occurences';
DELETE FROM robottemplaterelation WHERE definition IN (SELECT definition FROM entitydefaults WHERE definitionname IN (SELECT defName FROM #ED));
DELETE FROM aggregatevalues WHERE definition IN (SELECT definition FROM entitydefaults WHERE definitionname IN (SELECT defName FROM #ED));
DELETE FROM robottemplates WHERE name IN (SELECT templateName FROM #ED WHERE template IS NOT NULL);
DELETE FROM npcbossinfo WHERE flockid IN (SELECT id FROM npcflock WHERE name IN (SELECT flockName FROM #BOSSINFO));
DELETE FROM npcflock WHERE name IN (SELECT flockName FROM #FLOCKS);
DELETE FROM npcpresence WHERE name IN (SELECT presName FROM #PRES);
DELETE FROM npcloot WHERE definition IN (SELECT definition FROM entitydefaults WHERE definitionname IN (SELECT defName FROM #ED));
DELETE FROM entitydefaults WHERE definitionname IN (SELECT defName FROM #ED);


PRINT N'INSERT npc def, templates, ETC';
SET IDENTITY_INSERT dbo.entitydefaults ON;
INSERT INTO entitydefaults (definition,definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel) 
SELECT def, defName, 1, 1024, 911, NULL, defName, 1, 0, 0, 0, 100, defName+'_desc', 0, 0, 0 FROM #ED;
SET IDENTITY_INSERT dbo.entitydefaults OFF;

PRINT N'DELETE ALL AGG-VALS FOR THESE NPC DEFS';
DELETE FROM aggregatevalues WHERE definition IN (
	SELECT DISTINCT definition FROM entitydefaults WHERE definitionname IN (
		SELECT DISTINCT defName FROM #NPC_MODS
	)
);

PRINT N'RE-INSERT ALL AGG-VALS FOR THESE NPC DEFS';
INSERT INTO aggregatevalues (definition, field, value)
SELECT
	(SELECT TOP 1 definition FROM entitydefaults WHERE defName=definitionname),
	(SELECT TOP 1 id FROM aggregatefields WHERE name=fieldName),
	val
FROM #NPC_MODS;

INSERT INTO dbo.robottemplates (name, description, note)
SELECT templateName, template, defName+' template' FROM #ED WHERE template IS NOT NULL;

INSERT dbo.robottemplaterelation (definition, templateid, itemscoresum, raceid, missionlevel, missionleveloverride, killep, note)
SELECT 
	def,
	(SELECT TOP 1 id FROM robottemplates WHERE name=templateName),
	0, 0, NULL, NULL, epKill, defName+'<->'+templateName
FROM #ED; 

INSERT INTO dbo.npcpresence(name,topx,topy,bottomx,bottomy,note,spawnid,enabled,roaming,roamingrespawnseconds,presencetype,maxrandomflock,randomcenterx,randomcentery,randomradius,dynamiclifetime,isbodypull,isrespawnallowed,safebodypull,izgroupid)
SELECT presName,5,5,245,245,presName,spawnId,1,0,0,0,NULL,NULL,NULL,NULL,NULL,1,1,1,NULL FROM #PRES;

INSERT INTO dbo.npcflock(name,presenceid,flockmembercount,definition,spawnoriginX,spawnoriginY,spawnrangeMin,spawnrangeMax,respawnseconds,totalspawncount,homerange,note,
respawnmultiplierlow,enabled,iscallforhelp,behaviorType,npcSpecialType)
SELECT
	flockName,
	(SELECT TOP 1 id FROM npcpresence WHERE name=presName),
	flockCount,
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=npcName),
	x, y, sMin, sMax, respawnSeconds, 0, homeRange, flockName+' of '+npcName, 
	1,1,1,2,0
FROM #FLOCKS;

PRINT N'UPDATE JUST BOSS FLOCKS TO SPECIAL TYPE';
UPDATE npcflock SET
	npcSpecialType=1
WHERE name IN (SELECT flockName FROM #BOSSINFO);

INSERT INTO dbo.npcbossinfo(flockid,respawnNoiseFactor,lootSplitFlag,outpostEID,stabilityPts,overrideRelations,customDeathMessage,customAggressMessage)
SELECT 
	(SELECT TOP 1 id FROM npcflock WHERE name=flockName),
	respawnNoise, 1, NULL, NULL, 0, deathMsg, aggMsg 
FROM #BOSSINFO;

DECLARE @reinforceType AS INT = (SELECT TOP 1 id FROM npcreinforcementtypes WHERE name='boss');
PRINT N'INSERT npcflock, npcpresence, npcreinforcements FROM #WAVES table';
INSERT INTO npcpresence 
	(name,topx,topy,bottomx,bottomy,note,spawnid,enabled,roaming,roamingrespawnseconds,presencetype,maxrandomflock,randomcenterx,randomcentery,randomradius,dynamiclifetime,isbodypull,isrespawnallowed,safebodypull,izgroupid)
SELECT DISTINCT 
	presenceName, 0, 0, 0, 0, presenceName, 10, 1, 0, 0, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, 1, NULL
FROM #WAVES;

INSERT INTO npcflock
	(name,presenceid,flockmembercount,definition,spawnoriginX,spawnoriginY,spawnrangeMin,spawnrangeMax,respawnseconds,totalspawncount,homerange,note,respawnmultiplierlow,enabled,iscallforhelp,behaviorType,npcSpecialType)
SELECT 
	presenceName+npcDefName, (SELECT id FROM npcpresence WHERE name=presenceName), numInFlock, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=npcDefName), 0, 0, 0, 10, 0, 1, 55, presenceName+npcDefName, 0.5, 1, 1, @behaviourType, 0
FROM #WAVES;

INSERT INTO dbo.npcreinforcements
	(reinforcementType, targetId, threshold, presenceId, zoneId)
SELECT
	@reinforceType, (SELECT TOP 1 id FROM npcflock WHERE name=targetFlockName), thresh, (SELECT TOP 1 id FROM npcpresence WHERE name=presenceName), NULL
FROM #WAVES;


DROP TABLE IF EXISTS #ED;
DROP TABLE IF EXISTS #NPC_MODS;
DROP TABLE IF EXISTS #PRES;
DROP TABLE IF EXISTS #FLOCKS;
DROP TABLE IF EXISTS #BOSSINFO;
DROP TABLE IF EXISTS #WAVES;

SET NOEXEC OFF;
GO



PRINT N'ZZ_05_Elitemods_z71z72_upserts__2020_03_25.sql';
USE [perpetuumsa]
GO

--------------------------------------------
-- ELITE MODULES for Stronghold zone 71 and 72 bosses
-- a lot
-- Date modified: 2021/03/28
--------------------------------------------

DECLARE @dataShardCat AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_datashards');

DECLARE @dynamicCtCategory AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_dynamic_cprg');--For ct capsule defined cts

DECLARE @tmShops AS INT = (SELECT TOP 1 id FROM itemshoppresets WHERE name='tm_preset_pve');
DECLARE @t2smallpriceNIC AS INT = 600000;
DECLARE @t4smallpriceNIC AS INT = 800000;
DECLARE @t2medpriceNIC AS INT = 1200000;
DECLARE @t4medpriceNIC AS INT = 1600000;

DECLARE @t2smallpriceTOK AS INT = 30;
DECLARE @t4smallpriceTOK AS INT = 40;
DECLARE @t2medpriceTOK AS INT = 60;
DECLARE @t4medpriceTOK AS INT = 80;


DROP TABLE IF EXISTS #ENTITYDEF;
CREATE TABLE #ENTITYDEF 
(
	def INT,
	defName varchar(100),
	attrFlags bigint,
	catFlags bigint,
	genxyOptStr varchar(max),
	cargoVolume float,
	massOfModule float,
	techType int,
	techLevel int,
);

INSERT INTO #ENTITYDEF (def, defName, attrFlags, catFlags, genxyOptStr, cargoVolume, massOfModule, techType, techLevel) VALUES
(6042,'def_elitet2_72_small_armor_repairer',49168,16908559,'#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t2+',1,168.75,3,2),
(6043,'def_elitet4_72_small_armor_repairer',49168,16908559,'#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t4+',1,250,3,4),

(6044,'def_elitet2_72_medium_armor_repairer',81936,33685775,'#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t2+',1.5,506.25,3,2),
(6045,'def_elitet4_72_medium_armor_repairer',81936,33685775,'#moduleFlag=i20 #ammoCapacity=i0 #tier=$tierlevel_t4+',1.5,800,3,4),

(6046,'def_elitet2_71_small_shield_generator',49432,16843279,'#moduleFlag=i20#tier=$tierlevel_t2+',0.3,135,3,2),
(6047,'def_elitet4_71_small_shield_generator',49432,16843279,'#moduleFlag=i20#tier=$tierlevel_t4+',0.3,230,3,4),

(6048,'def_elitet2_71_medium_shield_generator',82200,33620495,'#moduleFlag=i20#tier=$tierlevel_t2+',0.5,270,3,2),
(6049,'def_elitet4_71_medium_shield_generator',82200,33620495,'#moduleFlag=i20#tier=$tierlevel_t4+',0.5,470,3,4),
--geoscanner
(6050,'def_elitet2_71_mining_probe_module',2359320,329231,'#moduleFlag=i8 #ammoCapacity=ia #ammoType=L90a #tier=$tierlevel_t2+',0.5,135,3,2),
(6051,'def_elitet4_71_mining_probe_module',2359320,329231,'#moduleFlag=i8 #ammoCapacity=ia #ammoType=L90a #tier=$tierlevel_t4+',0.5,200,3,4),

(6052,'def_elitet2_72_damage_mod_projectile',524292,33883919,'#moduleFlag=i8 #tier=$tierlevel_t2+',0.5,75,3,2),
(6053,'def_elitet4_72_damage_mod_projectile',524292,33883919,'#moduleFlag=i8 #tier=$tierlevel_t4+',0.5,125,3,4),
--LWF
(6054,'def_elitet2_72_mass_reductor',524320,327951,'#moduleFlag=i20 #tier=$tierlevel_t2+',0.5,1.5,3,2),
(6055,'def_elitet4_72_mass_reductor',524320,327951,'#moduleFlag=i20 #tier=$tierlevel_t4+',0.5,2,3,4),
--evasive
(6056,'def_elitet2_71_maneuvering_upgrade',524300,656143,'#moduleFlag=i20 #tier=$tierlevel_t2+',0.5,17,3,2),
(6057,'def_elitet4_71_maneuvering_upgrade',524300,656143,'#moduleFlag=i20 #tier=$tierlevel_t4+',0.5,35,3,4);



DROP TABLE IF EXISTS #CTS;
CREATE TABLE #CTS 
(
	def INT,
	defName varchar(100),
	attrFlags bigint,
	catFlags bigint,
	genxyOptStr varchar(max),
	cargoVolume float,
	massOfModule float,
	techType int,
	techLevel int,
);
INSERT INTO #CTS (def, defName, attrFlags, catFlags, genxyOptStr, cargoVolume, massOfModule, techType, techLevel) VALUES
(6058,'def_elitet2_72_small_armor_repairer_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t2+',0.01,0.1,3,2),
(6059,'def_elitet4_72_small_armor_repairer_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),

(6060,'def_elitet2_72_medium_armor_repairer_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t2+',0.01,0.1,3,2),
(6061,'def_elitet4_72_medium_armor_repairer_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),

(6062,'def_elitet2_71_small_shield_generator_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t2+',0.01,0.1,3,2),
(6063,'def_elitet4_71_small_shield_generator_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),

(6064,'def_elitet2_71_medium_shield_generator_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t2+',0.01,0.1,3,2),
(6065,'def_elitet4_71_medium_shield_generator_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),

(6066,'def_elitet2_71_mining_probe_module_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t2+',0.01,0.1,3,2),
(6067,'def_elitet4_71_mining_probe_module_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),

(6068,'def_elitet2_72_damage_mod_projectile_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t2+',0.01,0.1,3,2),
(6069,'def_elitet4_72_damage_mod_projectile_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),

(6070,'def_elitet2_72_mass_reductor_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t2+',0.01,0.1,3,2),
(6071,'def_elitet4_72_mass_reductor_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4),

(6072,'def_elitet2_71_maneuvering_upgrade_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t2+',0.01,0.1,3,2),
(6073,'def_elitet4_71_maneuvering_upgrade_cprg',1024,@dynamicCtCategory,'#tier=$tierlevel_t4+',0.01,0.1,3,4);

DECLARE @ArmorCTCapsule AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_ct_capsules_equipment_armor');
DECLARE @ShieldCTCapsule AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_ct_capsules_equipment_shield');
DECLARE @IndyCTCapsule AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_ct_capsules_equipment_industrial');
DECLARE @WeaponCTCapsule AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_ct_capsules_equipment_weapons');
DECLARE @EngineeringCTCapsule AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_ct_capsules_equipment_engineering');

DROP TABLE IF EXISTS #CTS_CAPSULES;
CREATE TABLE #CTS_CAPSULES 
(
	def INT,
	defName varchar(100),
	attrFlags bigint,
	catFlags bigint,
	genxyOptStr varchar(max),
	cargoVolume float,
	massOfModule float,
	techType int,
	techLevel int,
);
INSERT INTO #CTS_CAPSULES (def, defName, attrFlags, catFlags, genxyOptStr, cargoVolume, massOfModule, techType, techLevel) VALUES
(6074,'def_elitet2_72_small_armor_repairer_CT_capsule',2052,@ArmorCTCapsule,'#tier=$tierlevel_t2+',0.1,0.1,3,2),
(6075,'def_elitet4_72_small_armor_repairer_CT_capsule',2052,@ArmorCTCapsule,'#tier=$tierlevel_t4+',0.1,0.1,3,4),

(6076,'def_elitet2_72_medium_armor_repairer_CT_capsule',2052,@ArmorCTCapsule,'#tier=$tierlevel_t2+',0.1,0.1,3,2),
(6077,'def_elitet4_72_medium_armor_repairer_CT_capsule',2052,@ArmorCTCapsule,'#tier=$tierlevel_t4+',0.1,0.1,3,4),

(6078,'def_elitet2_71_small_shield_generator_CT_capsule',2052,@ShieldCTCapsule,'#tier=$tierlevel_t2+',0.1,0.1,3,2),
(6079,'def_elitet4_71_small_shield_generator_CT_capsule',2052,@ShieldCTCapsule,'#tier=$tierlevel_t4+',0.1,0.1,3,4),

(6080,'def_elitet2_71_medium_shield_generator_CT_capsule',2052,@ShieldCTCapsule,'#tier=$tierlevel_t2+',0.1,0.1,3,2),
(6081,'def_elitet4_71_medium_shield_generator_CT_capsule',2052,@ShieldCTCapsule,'#tier=$tierlevel_t4+',0.1,0.1,3,4),

(6082,'def_elitet2_71_mining_probe_module_CT_capsule',2052,@IndyCTCapsule,'#tier=$tierlevel_t2+',0.1,0.1,3,2),
(6083,'def_elitet4_71_mining_probe_module_CT_capsule',2052,@IndyCTCapsule,'#tier=$tierlevel_t4+',0.1,0.1,3,4),

(6084,'def_elitet2_72_damage_mod_projectile_CT_capsule',2052,@WeaponCTCapsule,'#tier=$tierlevel_t2+',0.1,0.1,3,2),
(6085,'def_elitet4_72_damage_mod_projectile_CT_capsule',2052,@WeaponCTCapsule,'#tier=$tierlevel_t4+',0.1,0.1,3,4),

(6086,'def_elitet2_72_mass_reductor_CT_capsule',2052,@ArmorCTCapsule,'#tier=$tierlevel_t2+',0.1,0.1,3,2),
(6087,'def_elitet4_72_mass_reductor_CT_capsule',2052,@ArmorCTCapsule,'#tier=$tierlevel_t4+',0.1,0.1,3,4),

(6088,'def_elitet2_71_maneuvering_upgrade_CT_capsule',2052,@EngineeringCTCapsule,'#tier=$tierlevel_t2+',0.1,0.1,3,2),
(6089,'def_elitet4_71_maneuvering_upgrade_CT_capsule',2052,@EngineeringCTCapsule,'#tier=$tierlevel_t4+',0.1,0.1,3,4);

DROP TABLE IF EXISTS #MATERIALDEF;
CREATE TABLE #MATERIALDEF 
(
	def INT,
	defName varchar(100),
	attrFlags bigint,
	catFlags bigint,
	genxyOptStr varchar(max),
	cargoVolume float,
	massOfModule float,
	techType int,
	techLevel int,
);
INSERT INTO #MATERIALDEF (def, defName, attrFlags, catFlags, genxyOptStr, cargoVolume, massOfModule, techType, techLevel) VALUES
(6040,'def_material_boss_z71',2048,@dataShardCat,NULL,0.01,0.5,NULL,NULL),
(6041,'def_material_boss_z72',2048,@dataShardCat,NULL,0.01,0.5,NULL,NULL);


DROP TABLE IF EXISTS #SHOPENTRIES;
CREATE TABLE #SHOPENTRIES
(
	defName varchar(100),
	tokenPrice int,
	nicPrice int
);
INSERT INTO #SHOPENTRIES (defName, tokenPrice, nicPrice) VALUES
('def_elitet2_72_small_armor_repairer_CT_capsule',@t2smallpriceTOK,@t2smallpriceNIC),
('def_elitet4_72_small_armor_repairer_CT_capsule',@t4smallpriceTOK,@t4smallpriceNIC),
('def_elitet2_72_medium_armor_repairer_CT_capsule',@t2medpriceTOK,@t2medpriceNIC),
('def_elitet4_72_medium_armor_repairer_CT_capsule',@t4medpriceTOK,@t4medpriceNIC),
('def_elitet2_71_small_shield_generator_CT_capsule',@t2smallpriceTOK,@t2smallpriceNIC),
('def_elitet4_71_small_shield_generator_CT_capsule',@t4smallpriceTOK,@t4smallpriceNIC),
('def_elitet2_71_medium_shield_generator_CT_capsule',@t2medpriceTOK,@t2medpriceNIC),
('def_elitet4_71_medium_shield_generator_CT_capsule',@t4medpriceTOK,@t4medpriceNIC),
('def_elitet2_71_mining_probe_module_CT_capsule',@t2medpriceTOK,@t2medpriceNIC),
('def_elitet4_71_mining_probe_module_CT_capsule',@t4medpriceTOK,@t4medpriceNIC),
('def_elitet2_72_damage_mod_projectile_CT_capsule',@t2medpriceTOK,@t2medpriceNIC),
('def_elitet4_72_damage_mod_projectile_CT_capsule',@t4medpriceTOK,@t4medpriceNIC),
('def_elitet2_72_mass_reductor_CT_capsule',@t2medpriceTOK,@t2medpriceNIC),
('def_elitet4_72_mass_reductor_CT_capsule',@t4medpriceTOK,@t4medpriceNIC),
('def_elitet2_71_maneuvering_upgrade_CT_capsule',@t2medpriceTOK,@t2medpriceNIC),
('def_elitet4_71_maneuvering_upgrade_CT_capsule',@t4medpriceTOK,@t4medpriceNIC);


DROP TABLE IF EXISTS #CT_RELATE;
CREATE TABLE #CT_RELATE 
(
	defName varchar(100),
	ctName varchar(100),
	capName varchar(100)
);
INSERT INTO #CT_RELATE (defName, ctName, capName) VALUES
('def_elitet2_72_small_armor_repairer', 'def_elitet2_72_small_armor_repairer_cprg', 'def_elitet2_72_small_armor_repairer_CT_capsule'),
('def_elitet4_72_small_armor_repairer', 'def_elitet4_72_small_armor_repairer_cprg', 'def_elitet4_72_small_armor_repairer_CT_capsule'),

('def_elitet2_72_medium_armor_repairer', 'def_elitet2_72_medium_armor_repairer_cprg', 'def_elitet2_72_medium_armor_repairer_CT_capsule'),
('def_elitet4_72_medium_armor_repairer', 'def_elitet4_72_medium_armor_repairer_cprg', 'def_elitet4_72_medium_armor_repairer_CT_capsule'),

('def_elitet2_71_small_shield_generator', 'def_elitet2_71_small_shield_generator_cprg', 'def_elitet2_71_small_shield_generator_CT_capsule'),
('def_elitet4_71_small_shield_generator', 'def_elitet4_71_small_shield_generator_cprg', 'def_elitet4_71_small_shield_generator_CT_capsule'),

('def_elitet2_71_medium_shield_generator', 'def_elitet2_71_medium_shield_generator_cprg', 'def_elitet2_71_medium_shield_generator_CT_capsule'),
('def_elitet4_71_medium_shield_generator', 'def_elitet4_71_medium_shield_generator_cprg', 'def_elitet4_71_medium_shield_generator_CT_capsule'),

('def_elitet2_71_mining_probe_module', 'def_elitet2_71_mining_probe_module_cprg', 'def_elitet2_71_mining_probe_module_CT_capsule'),
('def_elitet4_71_mining_probe_module', 'def_elitet4_71_mining_probe_module_cprg', 'def_elitet4_71_mining_probe_module_CT_capsule'),

('def_elitet2_72_damage_mod_projectile', 'def_elitet2_72_damage_mod_projectile_cprg', 'def_elitet2_72_damage_mod_projectile_CT_capsule'),
('def_elitet4_72_damage_mod_projectile', 'def_elitet4_72_damage_mod_projectile_cprg', 'def_elitet4_72_damage_mod_projectile_CT_capsule'),

('def_elitet2_72_mass_reductor', 'def_elitet2_72_mass_reductor_cprg', 'def_elitet2_72_mass_reductor_CT_capsule'),
('def_elitet4_72_mass_reductor', 'def_elitet4_72_mass_reductor_cprg', 'def_elitet4_72_mass_reductor_CT_capsule'),

('def_elitet2_71_maneuvering_upgrade', 'def_elitet2_71_maneuvering_upgrade_cprg', 'def_elitet2_71_maneuvering_upgrade_CT_capsule'),
('def_elitet4_71_maneuvering_upgrade', 'def_elitet4_71_maneuvering_upgrade_cprg', 'def_elitet4_71_maneuvering_upgrade_CT_capsule');


DROP TABLE IF EXISTS #STATS;
CREATE TABLE #STATS(
	defName varchar(100),
	fieldName varchar(100),
	fieldValue float,
);
INSERT INTO #STATS (defName, fieldName, fieldValue) VALUES

('def_elitet2_72_small_armor_repairer','armor_max',110),--hp
('def_elitet2_72_small_armor_repairer','armor_repair_amount',65),
('def_elitet2_72_small_armor_repairer','core_usage',54),
('def_elitet2_72_small_armor_repairer','cpu_usage',29),
('def_elitet2_72_small_armor_repairer','cycle_time',13500),
('def_elitet2_72_small_armor_repairer','powergrid_usage',17),

('def_elitet4_72_small_armor_repairer','armor_max',180),--hp
('def_elitet4_72_small_armor_repairer','armor_repair_amount',75),
('def_elitet4_72_small_armor_repairer','core_usage',70),
('def_elitet4_72_small_armor_repairer','cpu_usage',40),
('def_elitet4_72_small_armor_repairer','cycle_time',12000),
('def_elitet4_72_small_armor_repairer','powergrid_usage',27),

('def_elitet2_72_medium_armor_repairer','armor_max',245),--hp
('def_elitet2_72_medium_armor_repairer','armor_repair_amount',200),
('def_elitet2_72_medium_armor_repairer','core_usage',278),
('def_elitet2_72_medium_armor_repairer','cpu_usage',43),
('def_elitet2_72_medium_armor_repairer','cycle_time',13500),
('def_elitet2_72_medium_armor_repairer','powergrid_usage',87),

('def_elitet4_72_medium_armor_repairer','armor_max',405),--hp
('def_elitet4_72_medium_armor_repairer','armor_repair_amount',230),
('def_elitet4_72_medium_armor_repairer','core_usage',330),
('def_elitet4_72_medium_armor_repairer','cpu_usage',55),
('def_elitet4_72_medium_armor_repairer','cycle_time',12000),
('def_elitet4_72_medium_armor_repairer','powergrid_usage',110),

('def_elitet2_71_small_shield_generator','signature_radius',-0.2),-- -0.2m srf area
('def_elitet2_71_small_shield_generator','core_usage',1),
('def_elitet2_71_small_shield_generator','cpu_usage',38),
('def_elitet2_71_small_shield_generator','cycle_time',2250),
('def_elitet2_71_small_shield_generator','powergrid_usage',43),
('def_elitet2_71_small_shield_generator','shield_absorbtion',2.1277),--47% ap ratio
('def_elitet2_71_small_shield_generator','shield_radius',5),

('def_elitet4_71_small_shield_generator','signature_radius',-0.3),-- -0.3m srf area
('def_elitet4_71_small_shield_generator','core_usage',1),
('def_elitet4_71_small_shield_generator','cpu_usage',50),
('def_elitet4_71_small_shield_generator','cycle_time',2000),
('def_elitet4_71_small_shield_generator','powergrid_usage',57),
('def_elitet4_71_small_shield_generator','shield_absorbtion',2),
('def_elitet4_71_small_shield_generator','shield_radius',6),

('def_elitet2_71_medium_shield_generator','signature_radius',-0.4), -- -0.4m srf area
('def_elitet2_71_medium_shield_generator','core_usage',12.5),
('def_elitet2_71_medium_shield_generator','cpu_usage',57),
('def_elitet2_71_medium_shield_generator','cycle_time',7000),
('def_elitet2_71_medium_shield_generator','powergrid_usage',214),
('def_elitet2_71_medium_shield_generator','shield_absorbtion',2.1277),
('def_elitet2_71_medium_shield_generator','shield_radius',12),

('def_elitet4_71_medium_shield_generator','signature_radius',-0.6), -- -0.6m srf area
('def_elitet4_71_medium_shield_generator','core_usage',12.5),
('def_elitet4_71_medium_shield_generator','cpu_usage',70),
('def_elitet4_71_medium_shield_generator','cycle_time',6500),
('def_elitet4_71_medium_shield_generator','powergrid_usage',285),
('def_elitet4_71_medium_shield_generator','shield_absorbtion',2),
('def_elitet4_71_medium_shield_generator','shield_radius',25),

('def_elitet2_71_maneuvering_upgrade','armor_max',110), -- hp+
('def_elitet2_71_maneuvering_upgrade','cpu_usage',19),
('def_elitet2_71_maneuvering_upgrade','powergrid_usage',21),
('def_elitet2_71_maneuvering_upgrade','signature_radius',-1.00),
('def_elitet2_71_maneuvering_upgrade','massiveness',0.05),

('def_elitet4_71_maneuvering_upgrade','armor_max',180), -- hp+
('def_elitet4_71_maneuvering_upgrade','cpu_usage',29),
('def_elitet4_71_maneuvering_upgrade','powergrid_usage',28),
('def_elitet4_71_maneuvering_upgrade','signature_radius',-1.15),
('def_elitet4_71_maneuvering_upgrade','massiveness',0.075),

('def_elitet2_72_mass_reductor','signature_radius',-0.2), -- -0.2m
('def_elitet2_72_mass_reductor','cpu_usage',5),
('def_elitet2_72_mass_reductor','powergrid_usage',2),
('def_elitet2_72_mass_reductor','speed_max_modifier',1.19),
('def_elitet2_72_mass_reductor','massiveness',-0.2),

('def_elitet4_72_mass_reductor','signature_radius',-0.3), -- -0.3m
('def_elitet4_72_mass_reductor','cpu_usage',7),
('def_elitet4_72_mass_reductor','powergrid_usage',3),
('def_elitet4_72_mass_reductor','speed_max_modifier',1.25),
('def_elitet4_72_mass_reductor','massiveness',-0.25),

('def_elitet2_71_mining_probe_module','stealth_strength',10), -- 10 masking
('def_elitet2_71_mining_probe_module','core_usage',45),
('def_elitet2_71_mining_probe_module','cpu_usage',38),
('def_elitet2_71_mining_probe_module','cycle_time',15000),
('def_elitet2_71_mining_probe_module','powergrid_usage',43),
('def_elitet2_71_mining_probe_module','mining_probe_accuracy',0.6),

('def_elitet4_71_mining_probe_module','stealth_strength',17.5), -- 17.5 masking
('def_elitet4_71_mining_probe_module','core_usage',90),
('def_elitet4_71_mining_probe_module','cpu_usage',60),
('def_elitet4_71_mining_probe_module','cycle_time',10000),
('def_elitet4_71_mining_probe_module','powergrid_usage',53),
('def_elitet4_71_mining_probe_module','mining_probe_accuracy',0.7),

('def_elitet2_72_damage_mod_projectile','projectile_optimal_range_modifier',1.015), -- 1.5% optimal
('def_elitet2_72_damage_mod_projectile','projectile_falloff_modifier',1.03), --3% falloff
('def_elitet2_72_damage_mod_projectile','cpu_usage',13),
('def_elitet2_72_damage_mod_projectile','powergrid_usage',4),
('def_elitet2_72_damage_mod_projectile','damage_projectile_modifier',0.19),

('def_elitet4_72_damage_mod_projectile','projectile_optimal_range_modifier',1.025), -- 2.5% optimal
('def_elitet4_72_damage_mod_projectile','projectile_falloff_modifier',1.05),--5% falloff
('def_elitet4_72_damage_mod_projectile','cpu_usage',16),
('def_elitet4_72_damage_mod_projectile','powergrid_usage',5),
('def_elitet4_72_damage_mod_projectile','damage_projectile_modifier',0.25);


DROP TABLE IF EXISTS #SKILLS;
CREATE TABLE #SKILLS (
	defName varchar(100),
	extName varchar(100),
	extLevel float,
);
INSERT INTO #SKILLS (defName, extName, extLevel) VALUES
('def_elitet2_72_small_armor_repairer','ext_repair_systems',6),
('def_elitet4_72_small_armor_repairer','ext_repair_systems',7),
('def_elitet2_72_medium_armor_repairer','ext_repair_systems',6),
('def_elitet4_72_medium_armor_repairer','ext_repair_systems',7),
('def_elitet2_71_small_shield_generator','ext_shield_operation',6),
('def_elitet4_71_small_shield_generator','ext_shield_operation',7),
('def_elitet2_71_medium_shield_generator','ext_shield_upgrades',6),
('def_elitet4_71_medium_shield_generator','ext_shield_upgrades',7),
('def_elitet2_71_mining_probe_module', 'ext_electronics', 6),
('def_elitet4_71_mining_probe_module', 'ext_electronics', 7),
('def_elitet2_72_damage_mod_projectile', 'ext_weapon_cpu_upgrade', 6),
('def_elitet4_72_damage_mod_projectile', 'ext_weapon_cpu_upgrade', 7),
('def_elitet2_72_mass_reductor', 'ext_mechanic', 6),
('def_elitet4_72_mass_reductor', 'ext_mechanic', 7),
('def_elitet2_71_maneuvering_upgrade', 'ext_mechanic', 6),
('def_elitet4_71_maneuvering_upgrade', 'ext_mechanic', 7);


DROP TABLE IF EXISTS #INDY;
CREATE TABLE #INDY
(
	defName VARCHAR(100),
	commodityName VARCHAR(100),
	amount INT
);
INSERT INTO #INDY (defName, commodityName, amount) VALUES
('def_elitet2_72_small_armor_repairer','def_named1_small_armor_repairer',1),
('def_elitet2_72_small_armor_repairer','def_material_boss_z72',150),

('def_elitet4_72_small_armor_repairer','def_named3_small_armor_repairer',1),
('def_elitet4_72_small_armor_repairer','def_material_boss_z72',200),

('def_elitet2_72_medium_armor_repairer','def_named1_medium_armor_repairer',1),
('def_elitet2_72_medium_armor_repairer','def_material_boss_z72',300),

('def_elitet4_72_medium_armor_repairer','def_named3_medium_armor_repairer',1),
('def_elitet4_72_medium_armor_repairer','def_material_boss_z72',400),

('def_elitet2_71_small_shield_generator','def_named1_small_shield_generator',1),
('def_elitet2_71_small_shield_generator','def_material_boss_z71',150),

('def_elitet4_71_small_shield_generator','def_named3_small_shield_generator',1),
('def_elitet4_71_small_shield_generator','def_material_boss_z71',200),

('def_elitet2_71_medium_shield_generator','def_named1_medium_shield_generator',1),
('def_elitet2_71_medium_shield_generator','def_material_boss_z71',300),

('def_elitet4_71_medium_shield_generator','def_named3_medium_shield_generator',1),
('def_elitet4_71_medium_shield_generator','def_material_boss_z71',400),

('def_elitet2_71_mining_probe_module','def_named1_mining_probe_module',1),
('def_elitet2_71_mining_probe_module','def_material_boss_z71',300),

('def_elitet4_71_mining_probe_module','def_named3_mining_probe_module',1),
('def_elitet4_71_mining_probe_module','def_material_boss_z71',400),

('def_elitet2_72_damage_mod_projectile','def_named1_damage_mod_projectile',1),
('def_elitet2_72_damage_mod_projectile','def_material_boss_z72',300),

('def_elitet4_72_damage_mod_projectile','def_named3_damage_mod_projectile',1),
('def_elitet4_72_damage_mod_projectile','def_material_boss_z72',400),

('def_elitet2_72_mass_reductor','def_named1_mass_reductor',1),
('def_elitet2_72_mass_reductor','def_material_boss_z72',300),

('def_elitet4_72_mass_reductor','def_named3_mass_reductor',1),
('def_elitet4_72_mass_reductor','def_material_boss_z72',400),

('def_elitet2_71_maneuvering_upgrade','def_named1_maneuvering_upgrade',1),
('def_elitet2_71_maneuvering_upgrade','def_material_boss_z71',300),

('def_elitet4_71_maneuvering_upgrade','def_named3_maneuvering_upgrade',1),
('def_elitet4_71_maneuvering_upgrade','def_material_boss_z71',400);


PRINT N'UPSERT [entitydefaults] identity insert ON';
SET IDENTITY_INSERT [dbo].[entitydefaults] ON;
MERGE [dbo].[entitydefaults] e USING #ENTITYDEF d
ON e.definition = d.def
WHEN MATCHED
    THEN UPDATE SET
		categoryflags=catFlags,
		attributeflags=attrFlags,
		volume=cargoVolume,
		mass=massOfModule,
		tiertype=techType,
		tierlevel=techLevel,
		options=genxyOptStr,
		enabled=1,
		hidden=0,
		purchasable=1,
		descriptiontoken=defName+'_desc'
WHEN NOT MATCHED
    THEN INSERT (definition, definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel) VALUES
	(def,defName,1,attrFlags,catFlags,genxyOptStr,'elite module',1,cargoVolume,massOfModule,0,100,defName+'_desc',1,techType,techLevel);

PRINT N'UPSERT  cts into [entitydefaults]';
MERGE [dbo].[entitydefaults] e USING #CTS d
ON e.definition = d.def
WHEN MATCHED
    THEN UPDATE SET
		categoryflags=catFlags,
		attributeflags=attrFlags,
		volume=cargoVolume,
		mass=massOfModule,
		tiertype=techType,
		tierlevel=techLevel,
		options=genxyOptStr,
		enabled=1,
		hidden=0,
		purchasable=1,
		descriptiontoken='calibration_program_desc'
WHEN NOT MATCHED
    THEN INSERT (definition, definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel) VALUES
	(def,defName,1,attrFlags,catFlags,genxyOptStr,'elite module ct',1,cargoVolume,massOfModule,0,100,'calibration_program_desc',1,techType,techLevel);

PRINT N'UPSERT  ct capsules into [entitydefaults]';
MERGE [dbo].[entitydefaults] e USING #CTS_CAPSULES d
ON e.definition = d.def
WHEN MATCHED
    THEN UPDATE SET
		categoryflags=catFlags,
		attributeflags=attrFlags,
		volume=cargoVolume,
		mass=massOfModule,
		tiertype=techType,
		tierlevel=techLevel,
		options=genxyOptStr,
		enabled=1,
		hidden=0,
		purchasable=1,
		descriptiontoken='elite_ct_capsule_desc'
WHEN NOT MATCHED
    THEN INSERT (definition, definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel) VALUES
	(def,defName,1,attrFlags,catFlags,genxyOptStr,'elite module ct capsule',1,cargoVolume,massOfModule,0,100,'elite_ct_capsule_desc',1,techType,techLevel);

PRINT N'UPSERT  new boss material into [entitydefaults]';
MERGE [dbo].[entitydefaults] e USING #MATERIALDEF d
ON e.definition = d.def
WHEN MATCHED
    THEN UPDATE SET
		categoryflags=catFlags,
		attributeflags=attrFlags,
		volume=cargoVolume,
		mass=massOfModule,
		tiertype=techType,
		tierlevel=techLevel,
		options=genxyOptStr,
		enabled=1,
		hidden=0,
		purchasable=1,
		descriptiontoken=defName+'_desc'
WHEN NOT MATCHED
    THEN INSERT (definition, definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel) VALUES
	(def,defName,1,attrFlags,catFlags,genxyOptStr,'elite module material',1,cargoVolume,massOfModule,0,100,defName+'_desc',1,techType,techLevel);

SET IDENTITY_INSERT [dbo].[entitydefaults] OFF;
PRINT N'[entitydefaults] insert/updates done - identity insert off';

PRINT N'DELETE [aggregatevalues] (0 if first run)';
DELETE FROM aggregatevalues WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #STATS));
PRINT N'UPSERT [aggregatevalues]';
MERGE [dbo].[aggregatevalues] v USING #STATS s
ON v.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=s.defName) AND
v.field = (SELECT TOP 1 id FROM aggregatefields WHERE name=s.fieldName)
WHEN MATCHED
    THEN UPDATE SET
		v.value=s.fieldValue
WHEN NOT MATCHED
    THEN INSERT (definition, field, value) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=s.defName),
	(SELECT TOP 1 id FROM aggregatefields WHERE name=s.fieldName),
	s.fieldValue);

PRINT N'UPSERT [enablerextensions]';
MERGE [dbo].[enablerextensions] e USING #SKILLS s
ON e.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=s.defName) AND
e.extensionid = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname=s.extName)
WHEN MATCHED
    THEN UPDATE SET
		e.extensionlevel=s.extLevel
WHEN NOT MATCHED
    THEN INSERT (definition, extensionid, extensionlevel) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=s.defName),
	(SELECT TOP 1 extensionid FROM extensions WHERE extensionname=s.extName),
	s.extLevel);

PRINT N'UPSERT [dynamiccalibrationtemplates]';
MERGE [dbo].[dynamiccalibrationtemplates] t USING #CT_RELATE c
ON t.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=c.ctName)
WHEN MATCHED
    THEN UPDATE SET
		materialefficiency=1,
		timeefficiency=1,
		targetdefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=c.defName)
WHEN NOT MATCHED
    THEN INSERT (definition, materialefficiency, timeefficiency, targetdefinition) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=c.ctName),
	1,1,
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=c.defName));

PRINT N'UPSERT [calibrationtemplateitems]';
MERGE [dbo].[calibrationtemplateitems] t USING #CT_RELATE c
ON t.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=c.capName)
WHEN MATCHED
    THEN UPDATE SET
		targetdefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=c.ctName)
WHEN NOT MATCHED
    THEN INSERT (definition, targetdefinition) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=c.capName),
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=c.ctName));

PRINT N'UPSERT [components]';
MERGE [dbo].[components] c USING #INDY i
ON c.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=i.defName) AND
c.componentdefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=i.commodityName) 
WHEN MATCHED
    THEN UPDATE SET
		componentamount = i.amount
WHEN NOT MATCHED
    THEN INSERT (definition, componentdefinition, componentamount) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=i.defName),
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=i.commodityName),
	i.amount);

PRINT N'UPSERT [itemshop]';
MERGE [dbo].[itemshop] shop USING #SHOPENTRIES e
ON shop.targetdefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=e.defName)
WHEN MATCHED
    THEN UPDATE SET
		presetid=@tmShops,
		targetamount=1,
		unicoin=e.tokenPrice,
		credit=e.nicPrice
WHEN NOT MATCHED
    THEN INSERT (presetid, targetdefinition, targetamount, tmcoin, icscoin, asicoin, credit, unicoin, globallimit, purchasecount, standing) VALUES
	(@tmShops, (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=e.defName), 1, 0, 0, 0, e.nicPrice, e.tokenPrice, NULL, 1, 0);


DROP TABLE IF EXISTS #STATS;
DROP TABLE IF EXISTS #ENTITYDEF;
DROP TABLE IF EXISTS #MATERIALDEF;
DROP TABLE IF EXISTS #CT_RELATE;
DROP TABLE IF EXISTS #CTS;
DROP TABLE IF EXISTS #CTS_CAPSULES;
DROP TABLE IF EXISTS #INDY;
DROP TABLE IF EXISTS #SKILLS;
DROP TABLE IF EXISTS #SHOPENTRIES; 
GO


USE [perpetuumsa]
GO

PRINT N'TEMPORARILY HIDE AND DISABLE ALL T4+ FOR Z71-72';

PRINT N'TABLE OF NAMES';
DROP TABLE IF EXISTS #HIDE;
CREATE TABLE #HIDE (
	defName VARCHAR(100)
);
INSERT INTO #HIDE (defName) VALUES 
('def_elitet4_72_small_armor_repairer'),
('def_elitet4_72_medium_armor_repairer'),
('def_elitet4_71_small_shield_generator'),
('def_elitet4_71_medium_shield_generator'),
('def_elitet4_71_mining_probe_module'),
('def_elitet4_72_damage_mod_projectile'),
('def_elitet4_72_mass_reductor'),
('def_elitet4_71_maneuvering_upgrade'),

('def_elitet4_72_small_armor_repairer_cprg'),
('def_elitet4_72_medium_armor_repairer_cprg'),
('def_elitet4_71_small_shield_generator_cprg'),
('def_elitet4_71_medium_shield_generator_cprg'),
('def_elitet4_71_mining_probe_module_cprg'),
('def_elitet4_72_damage_mod_projectile_cprg'),
('def_elitet4_72_mass_reductor_cprg'),
('def_elitet4_71_maneuvering_upgrade_cprg'),

('def_elitet4_72_small_armor_repairer_CT_capsule'),
('def_elitet4_72_medium_armor_repairer_CT_capsule'),
('def_elitet4_71_small_shield_generator_CT_capsule'),
('def_elitet4_71_medium_shield_generator_CT_capsule'),
('def_elitet4_71_mining_probe_module_CT_capsule'),
('def_elitet4_72_damage_mod_projectile_CT_capsule'),
('def_elitet4_72_mass_reductor_CT_capsule'),
('def_elitet4_71_maneuvering_upgrade_CT_capsule');

PRINT N'MERGE/UPDATE ALL MATCHING DEFS';
MERGE [dbo].[entitydefaults] e USING #HIDE d
ON e.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=d.defName)
WHEN MATCHED
    THEN UPDATE SET
		enabled=1,
		hidden=1;

PRINT N'all t4+ for z71-2 hidden';
DROP TABLE IF EXISTS #HIDE;
GO



PRINT N'ZZ_06_npcloot_z71_72__2021_03_31.sql';
USE [perpetuumsa]
GO

--------------------------------------------------------------------------
-- Stronghold zone 71+72 npc loot!
-- Date: 2021/03/31
--------------------------------------------------------------------------


PRINT N'SET ALL NPC LOOT FOR NPC STRONGHOLD';
DROP TABLE IF EXISTS #LOOT;
CREATE TABLE #LOOT(
	npcName VARCHAR(100),
	lootName VARCHAR(100),
	minQuantity FLOAT,
	maxQuantity FLOAT,
	probability FLOAT DEFAULT(1.0)
);

INSERT INTO #LOOT (npcName, lootName, minQuantity, maxQuantity, probability) VALUES
('def_npc_Zone71_WilliamHBonnie','def_ammo_small_projectile_a',1000,2000,0.5),
('def_npc_Zone71_WilliamHBonnie','def_ammo_small_projectile_b',1000,2000,0.5),
('def_npc_Zone71_WilliamHBonnie','def_ammo_small_projectile_c',1000,2000,0.5),
('def_npc_Zone71_WilliamHBonnie','def_ammo_small_projectile_d',1000,2000,0.5),

('def_npc_Zone71_WilliamHBonnie','def_named1_damage_mod_projectile',1,1,1),
('def_npc_Zone71_WilliamHBonnie','def_named2_damage_mod_projectile',1,1,0.25),
('def_npc_Zone71_WilliamHBonnie','def_named1_damage_mod_projectile_pr',1,1,0.25),

('def_npc_Zone71_WilliamHBonnie','def_named1_small_autocannon',1,1,1),
('def_npc_Zone71_WilliamHBonnie','def_named2_small_autocannon',1,1,0.25),
('def_npc_Zone71_WilliamHBonnie','def_named1_small_autocannon_pr',1,1,0.25),

('def_npc_Zone71_WilliamHBonnie','def_named1_small_armor_plate',1,1,1),
('def_npc_Zone71_WilliamHBonnie','def_named1_small_armor_repairer',1,1,1),
('def_npc_Zone71_WilliamHBonnie','def_named1_small_shield_generator',1,1,1),

('def_npc_Zone71_WilliamHBonnie','def_material_boss_z71',9,11,1.0),
('def_npc_Zone71_WilliamHBonnie','def_robotshard_common_basic',50,100,1),
('def_npc_Zone71_WilliamHBonnie','def_robotshard_common_advanced',25,75,1),
('def_npc_Zone71_WilliamHBonnie','def_robotshard_common_expert',1,50,1),
('def_npc_Zone71_WilliamHBonnie','def_common_reactor_plasma',9000,10000,1),
('def_npc_Zone71_WilliamHBonnie','def_kernel_common',2500,3000,1),
('def_npc_Zone71_WilliamHBonnie','def_kernel_hitech',500,600,1),
('def_npc_Zone71_WilliamHBonnie','def_boost_ep_t0',1,1,0.25),

('def_npc_Zone72_One_Eye_Josef','def_ammo_medium_projectile_a',1000,2000,0.5),
('def_npc_Zone72_One_Eye_Josef','def_ammo_medium_projectile_b',1000,2000,0.5),
('def_npc_Zone72_One_Eye_Josef','def_ammo_medium_projectile_c',1000,2000,0.5),
('def_npc_Zone72_One_Eye_Josef','def_ammo_medium_projectile_d',1000,2000,0.5),

('def_npc_Zone72_One_Eye_Josef','def_named1_damage_mod_projectile',1,1,1),
('def_npc_Zone72_One_Eye_Josef','def_named2_damage_mod_projectile',1,1,0.25),
('def_npc_Zone72_One_Eye_Josef','def_named1_damage_mod_projectile_pr',1,1,0.25),

('def_npc_Zone72_One_Eye_Josef','def_named1_medium_autocannon',1,1,1),
('def_npc_Zone72_One_Eye_Josef','def_named2_medium_autocannon',1,1,0.25),
('def_npc_Zone72_One_Eye_Josef','def_named1_medium_autocannon_pr',1,1,0.25),

('def_npc_Zone72_One_Eye_Josef','def_named1_medium_armor_plate',1,1,1),
('def_npc_Zone72_One_Eye_Josef','def_named1_medium_armor_repairer',1,1,1),
('def_npc_Zone72_One_Eye_Josef','def_named1_medium_shield_generator',1,1,1),

('def_npc_Zone72_One_Eye_Josef','def_material_boss_z72',9,11,1.0),
('def_npc_Zone72_One_Eye_Josef','def_robotshard_common_basic',100,200,1),
('def_npc_Zone72_One_Eye_Josef','def_robotshard_common_advanced',50,150,1),
('def_npc_Zone72_One_Eye_Josef','def_robotshard_common_expert',1,100,1),
('def_npc_Zone72_One_Eye_Josef','def_common_reactor_plasma',12000,15000,1),
('def_npc_Zone72_One_Eye_Josef','def_kernel_common',3000,3500,1),
('def_npc_Zone72_One_Eye_Josef','def_kernel_hitech',500,600,1),
('def_npc_Zone72_One_Eye_Josef','def_boost_ep_t0',1,1,0.25),

('def_npc_Helix_BossGuard','def_named1_cpu_upgrade',1,1,0.1),
('def_npc_Helix_BossGuard','def_named2_cpu_upgrade',1,1,0.02),
('def_npc_Helix_BossGuard','def_named1_sensor_supressor_booster',1,1,0.1),
('def_npc_Helix_BossGuard','def_named1_sensor_booster',1,1,0.1),
('def_npc_Helix_BossGuard','def_named1_ecm_booster',1,1,0.1),
('def_npc_Helix_BossGuard','def_robotshard_common_basic',10,15,1),
('def_npc_Helix_BossGuard','def_robotshard_common_advanced',5,10,1),
('def_npc_Helix_BossGuard','def_robotshard_common_expert',2,8,1),
('def_npc_Helix_BossGuard','def_common_reactor_plasma',75,99,1),
('def_npc_Helix_BossGuard','def_kernel_common',100,150,1),

('def_npc_Rough_Rider_Death_Dealer','def_named1_powergrid_upgrades',1,1,0.1),
('def_npc_Rough_Rider_Death_Dealer','def_named2_powergrid_upgrades',1,1,0.02),
('def_npc_Rough_Rider_Death_Dealer','def_named1_maneuvering_upgrade',1,1,0.1),
('def_npc_Rough_Rider_Death_Dealer','def_named2_maneuvering_upgrade',1,1,0.02),
('def_npc_Rough_Rider_Death_Dealer','def_robotshard_common_basic',15,20,1),
('def_npc_Rough_Rider_Death_Dealer','def_robotshard_common_advanced',10,15,1),
('def_npc_Rough_Rider_Death_Dealer','def_robotshard_common_expert',5,10,1),
('def_npc_Rough_Rider_Death_Dealer','def_common_reactor_plasma',125,155,1),
('def_npc_Rough_Rider_Death_Dealer','def_kernel_common',150,200,1);

PRINT N'DELETE ALL LOOT TO BE REINSERTED (0 if new)';
DELETE FROM npcloot WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT npcName FROM #LOOT));

PRINT N'UPDATE/INSERT ALL LOOTS';
MERGE npcloot n USING #LOOT o
ON n.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=o.npcName) AND
n.lootdefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=o.lootName)
WHEN MATCHED
    THEN UPDATE SET
		minquantity=o.minQuantity,
		quantity=o.maxQuantity,
		probability=o.probability
WHEN NOT MATCHED
    THEN INSERT (definition, lootdefinition, minquantity, quantity, probability, repackaged, dontdamage) VALUES
		((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=o.npcName),
		(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=o.lootName),
		o.minQuantity, o.maxQuantity, o.probability, 0, 0);



DROP TABLE IF EXISTS #LOOT;
PRINT N'ALL STRONGHOLD PBS NPCS LOOT SET';
GO


PRINT N'ZZ_71_DECOR_IMPORT_zone71_2021_03_31.sql';
USE [perpetuumsa]
GO
----------------------------------------------------------
-- DECOR REPLICATION SCRIPT (Import)
-- Decor replication involves transfer of layers and table entries
-- These scripts handle ONLY decore table entries.  
-- Layer data should be shared manually if layers are updated!
--
-- This is the IMPORT script which requires you have:
-- A) Correctly labeled, updated layer files in C:/perpserver/data/layers
-- B) The results of the export script
-- The Import will also WIPE all existing DECOR on the same ZONE!
-- If you wish to "merge" decor, handle the conflict as you see fit.
--
-- How to use Import:
-- 0.  Set the correct ZoneID
-- 1.  From the provided export text file: copy the contents
-- 2.  Paste the contents between the 'REPLACE' and 'END REPLACE'
-- 3.  Remove the last trailing ',' (comma) and replace with ';' (semicolon)
-- 4.  Run the script
----------------------------------------------------------

DECLARE @zoneID INT;
SET @zoneID = 71;

PRINT N'DELETING ALL DECOR ON ZONE: ' + CONVERT(varchar(10), @zoneID);
DELETE FROM decor WHERE zoneid=@zoneID;
INSERT INTO decor (definition, quaternionx, quaterniony, quaternionz, quaternionw, zoneid, x, y, z, scale, changed, fadedistance, category, locked) VALUES
--REPLACE
(2762,0,-0.694658,0,0.71934,71,30501,45669,4796,1,1,0,1,1),
(3491,0,0.878817,0,0.477159,71,50691,16540,8288,1,1,0,1,1),
(2755,0,0.615662,0,0.78801,71,52443,22290,7808,1,1,0,1,1),
(3443,0,-0.147809,0,0.989016,71,46720,14976,7808,1,1,0,1,1),
(3479,-0.011752,-0.89286,-0.05457,0.446864,71,42880,17898,7808,1,1,0,1,1),
(3479,0,0.48481,0,0.87462,71,43392,21120,7854,1,1,0,1,1),
(3479,0,-0.930418,0,0.366501,71,41344,18816,7792,1,1,0,1,1),
(3479,0,0.522499,0,0.85264,71,44473,20355,7804,1,1,0,1,1),
(2764,0,-0.284015,0,0.95882,71,35439,38893,7154,1,1,0,1,1),
(3443,0,0.422618,0,0.906308,71,55936,53120,3776,1,1,0,1,1),
(3744,0,0,0,1,71,41600,19072,7806,1,1,0,1,1),
(3744,0,0,0,1,71,43136,20864,7808,1,1,0,1,1),
(3744,0,0,0,1,71,43392,18304,7806,1,1,0,1,1),
(3744,0,0,0,1,71,44416,19840,7804,1,1,0,1,1),
(2763,0,0.422618,0,0.906308,71,38868,33144,7152,1,1,0,1,1),
(3689,0,0,0,1,71,55168,32640,7716,1,1,0,1,1),
(3690,0,0,0,1,71,41856,15488,7724,1,1,0,1,1),
(3469,0,0,0,1,71,44416,10880,7728,1,1,0,1,1),
(3469,0,0,0,1,71,43648,12164,7734,1,1,0,1,1);
--END REPLACE

GO


PRINT N'ZZ_72_DECOR_IMPORT_zone72_2021_03_31.sql';
USE [perpetuumsa]
GO
----------------------------------------------------------
-- DECOR REPLICATION SCRIPT (Import)
-- Decor replication involves transfer of layers and table entries
-- These scripts handle ONLY decore table entries.  
-- Layer data should be shared manually if layers are updated!
--
-- This is the IMPORT script which requires you have:
-- A) Correctly labeled, updated layer files in C:/perpserver/data/layers
-- B) The results of the export script
-- The Import will also WIPE all existing DECOR on the same ZONE!
-- If you wish to "merge" decor, handle the conflict as you see fit.
--
-- How to use Import:
-- 0.  Set the correct ZoneID
-- 1.  From the provided export text file: copy the contents
-- 2.  Paste the contents between the 'REPLACE' and 'END REPLACE'
-- 3.  Remove the last trailing ',' (comma) and replace with ';' (semicolon)
-- 4.  Run the script
----------------------------------------------------------

DECLARE @zoneID INT;
SET @zoneID = 72;

PRINT N'DELETING ALL DECOR ON ZONE: ' + CONVERT(varchar(10), @zoneID);
DELETE FROM decor WHERE zoneid=@zoneID;
INSERT INTO decor (definition, quaternionx, quaterniony, quaternionz, quaternionw, zoneid, x, y, z, scale, changed, fadedistance, category, locked) VALUES
--REPLACE
(2760,0,-0.398749,0,0.91706,72,52608,7012,6698,1,1,0,1,1),
(2760,0,0.91706,0,0.398749,72,57097,10469,6697,1,1,0,1,1),
(3346,0,-0.390731,0,0.920505,72,0,524288,156298,1,1,0,1,1),
(2829,0,0.91706,0,0.398749,72,40787,37310,6342,1,1,0,1,1),
(3474,-0.016182,0.37455,-0.006538,0.927043,72,46366,33264,6334,1,1,0,1,1),
(3443,0,-0.422618,0,0.906308,72,51072,32896,6342,1,1,0,1,1),
(3720,0,0.333807,0,0.942641,72,54144,35534,6216,1,1,0,1,1),
(3722,0,0.173648,0,-0.984808,72,56042,42603,5488,1,1,0,1,1),
(1407,0,0,0,1,72,57923,49602,3676,1,1,0,1,1),
(3393,0,0,0,1,72,42624,44928,4854,1,1,0,1,1),
(1405,0,-0.406736,0,0.913546,72,33022,40864,9810,1,1,0,1,1),
(1405,0,-0.390731,0,0.920505,72,22063,30558,9829,1,1,0,1,1),
(3463,0,0.374606,0,0.927184,72,25401,35178,7730,1,1,0,1,1),
(3463,0,-0.382683,0,-0.923879,72,25984,35741,7730,1,1,0,1,1),
(3463,0,0.374607,0,0.927184,72,26584,36339,7730,1,1,0,1,1),
(3464,0,-0.390731,0,0.920505,72,22570,51982,9803,1,1,0,1,1),
(3464,0,0.374606,0,0.927184,72,11614,41827,9796,1,1,0,1,1),
(3309,0,0.147809,0,0.989016,72,44110,38346,7701,1,1,0,1,1),
(3309,0,0.382683,0,0.923879,72,38862,35160,7355,1,1,0,1,1),
(3715,0,-0.414694,0,0.909961,72,36379,34004,7891,1,1,0,1,1),
(2799,0,0.358368,0,0.93358,72,35988,35473,6495,1,1,0,1,1),
(2799,0.029148,0.928071,0.013273,-0.371025,72,33716,33339,6430,1,1,0,1,1),
(3310,0,-0.422618,0,0.906308,72,42337,28190,8626,1,1,0,1,1),
(3310,0,0.906307,0,0.422618,72,43932,26291,8631,1,1,0,1,1),
(3310,0,-0.430511,0,0.902586,72,45733,24111,8633,1,1,0,1,1),
(2760,0,-0.414693,0,0.909961,72,47663,23186,6342,1,1,0,1,1),
(2818,0,0,0,1,72,48000,46208,4484,1,1,0,1,1),
(2826,0,-0.275637,0,0.961262,72,46938,42603,5250,1,1,0,1,1),
(3336,0,0,0,1,72,48600,44416,4906,1,1,0,1,1),
(3702,0,-0.258819,0,0.965926,72,22144,40576,7730,1,1,0,1,1),
(2760,0,0.366501,0,0.930418,72,28783,41603,7730,1,1,0,1,1),
(3721,0,0.92388,0,0.382683,72,25831,37540,7730,1,1,0,1,1),
(3392,0,-0.927184,0,0.374606,72,19111,31750,6988,1,1,0,1,1),
(3392,0,0.390732,0,0.920504,72,30446,45882,6983,1,1,0,1,1),
(3393,0,0.382683,0,0.92388,72,34432,41088,6988,1,1,0,1,1),
(3694,0,0,0,1,72,43392,48000,4046,1,1,0,1,1),
(3694,0,0,0,1,72,53120,47488,4020,1,1,0,1,1),
(2788,0,0.913545,0,0.406737,72,14099,20739,6250,1,1,0,1,1),
(3690,0,0,0,1,72,13666,25472,6253,1,1,0,1,1),
(3466,0,0,0,1,72,22537,51989,11262,1,1,0,1,1),
(2797,0,0.906308,0,0.422618,72,7040,14976,4480,1,1,0,1,1),
(3466,0,0,0,1,72,11604,41823,11262,1,1,0,1,1),
(2798,0,0.382683,0,0.923879,72,9945,14111,4407,1,1,0,1,1),
(2826,0,0.942641,0,-0.333807,72,6272,21928,4710,1,1,0,1,1),
(3334,0,0.390731,0,0.920505,72,7296,23680,5280,1,1,0,1,1),
(3292,0,0.414693,0,0.909961,72,51716,25942,6340,1,1,0,1,1),
(3292,0,-0.909961,0,0.414693,72,48103,29056,6342,1,1,0,1,1),
(3337,0,0,0,1,72,50942,30460,8559,1,1,0,1,1),
(3337,0,0,0,1,72,50958,28291,8544,1,1,0,1,1),
(3337,0,0.923879,0,0.382683,72,50079,25102,8656,1,1,0,1,1),
(3337,0,-0.052336,0,0.99863,72,0,50322,-19400,1,1,0,1,1),
(3337,0,0,0,1,72,50962,27029,8550,1,1,0,1,1),
(2802,0,0,0,1,72,50938,26128,8889,1,1,0,1,1),
(2760,0,-0.069756,0,0.997564,72,52301,42796,5164,1,1,0,1,1),
(3293,0,0,0,1,72,54912,27264,6340,1,1,0,1,1),
(3312,0,0.803857,0,0.594823,72,57393,17107,4915,2,1,0,1,1),
(3312,0,0.700909,0,0.71325,72,56192,26240,4889,2,1,0,1,1),
(3312,0,-0.731354,0,0.681998,72,56749,34357,5036,2,1,0,1,1),
(3312,0,0.920505,0,0.390731,72,37497,45952,4803,2,1,0,1,1),
(3312,0.008003,0.917026,0.00348,0.398733,72,31295,52470,4862,2,1,0,1,1),
(3312,0,0.909961,0,0.414693,72,25728,58618,4831,2,1,0,1,1),
(3313,0,0.91706,0,0.398749,72,19533,58294,4251,1,1,0,1,1),
(3313,0,0.909961,0,0.414693,72,12072,51584,4680,1,1,0,1,1),
(3313,0,0.930418,0,0.366501,72,5309,45440,4766,1,1,0,1,1),
(3313,0,0.358368,0,0.93358,72,5426,38272,4539,1,1,0,1,1),
(3313,0,-0.241922,0,0.970296,72,7475,30502,3690,1,1,0,1,1),
(3313,0,0.366501,0,0.930418,72,26691,13437,4594,1,1,0,1,1),
(3313,0,-0.580703,0,0.814116,72,34422,11329,4485,1,1,0,1,1),
(3313,0,0.566406,0,0.824127,72,43233,11254,4432,1,1,0,1,1),
(3313,0,0.406737,0,0.913546,72,49609,5760,4469,1,1,0,1,1),
(3313,0,-0.406736,0,0.913545,72,56155,5576,4498,1,1,0,1,1),
(3313,0,0.139173,0,0.990268,72,59222,13769,4789,1,1,0,1,1),
(2828,0,-0.350208,0,0.936672,72,27008,20783,6340,1,1,0,1,1),
(3498,0,-0.366501,0,-0.930417,72,33520,28935,6452,1,1,0,1,1),
(2755,0,-0.406736,0,0.913545,72,36056,29482,6342,1,1,0,1,1),
(1137,0,0.34202,0,0.939692,72,21856,41401,7180,0.5,1,0,1,1),
(1146,0,0,0,1,72,57728,44928,3866,1,1,0,1,1),
(3720,0,-0.390731,0,0.920505,72,34754,34725,7946,1,1,0,1,1),
(3719,0,0.737278,0,-0.67559,72,48786,38112,6020,1,1,0,1,1),
(3309,0,0.649448,0,0.760406,72,42003,40847,8190,1,1,0,1,1),
(3309,0,-0.75471,0,0.65606,72,42337,43195,8183,1,1,0,1,1),
(3309,0,-0.414693,0,0.909961,72,19664,42764,7956,1,1,0,1,1);
--END REPLACE

GO


PRINT N'ZZ_73_StrghldExitConfigs_newcol__2021_04_10.sql';
USE [perpetuumsa]
GO

-------------------------------------------------
-- All stronghold exits now get a RiftConfig to set their destinations
-- new rift configs for all stronghold exits
-- update strongholdexits with new config ids
-- Date: 2021/04/10
-------------------------------------------------

PRINT N'ALTER [dbo].[strongholdexitconfig]';
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[perpetuumsa].[dbo].[strongholdexitconfig]')
	AND name = 'riftConfigId')
BEGIN
	PRINT N'ADDING COL riftConfigId';
	ALTER TABLE [perpetuumsa].[dbo].strongholdexitconfig ADD
		riftConfigId INT NULL;
END
GO


USE [perpetuumsa]
GO

DROP TABLE IF EXISTS #CONFIGS;
CREATE TABLE #CONFIGS(
	name VARCHAR(100),
	groupId INT,
	zoneId INT,
	x INT,
	y INT,
	w FLOAT
);
INSERT INTO #CONFIGS (name, groupId, zoneId, x, y, w) VALUES
('stronghold_default_exit', 1, 8, 970, 810, 1),
('stronghold_z71_exit', 2, 0, 1750, 850, 1),
('stronghold_z72_exit', 3, 8, 1970, 1830, 1),
('stronghold_z71_exit_boss', 4, 0, 1100, 865, 1),
('stronghold_z72_exit_boss', 5, 8, 971, 811, 1);

DROP TABLE IF EXISTS #EXITS;
CREATE TABLE #EXITS(
	zoneid INT,
	x INT,
	y INT,
	configName VARCHAR(100)
);
INSERT INTO #EXITS (zoneid, x, y, configName) VALUES
(71, 20, 175, 'stronghold_z71_exit'),
(71, 211, 119, 'stronghold_z71_exit_boss'),
(72, 219, 28, 'stronghold_z72_exit'),
(72, 89, 185, 'stronghold_z72_exit_boss');

DELETE FROM riftdestinations WHERE groupId IN (SELECT destinationGroupId from riftconfigs WHERE name IN (SELECT name FROM #CONFIGS));
DELETE FROM riftconfigs WHERE name IN (SELECT name FROM #CONFIGS);

PRINT N'INSERT INTO [dbo].[riftdestinations]';
INSERT INTO [dbo].[riftdestinations] (groupId, zoneId, x, y, weight)
	SELECT groupId, zoneId, x, y, w
	FROM #CONFIGS;

PRINT N'INSERT INTO [dbo].[riftconfigs]';
INSERT INTO [dbo].[riftconfigs] (name, destinationGroupId)
	SELECT name, groupId
	FROM #CONFIGS;


PRINT N'UPDATE strongholdexitconfig for boss entry riftconfigs';
PRINT N'Strongholds 16 and 70 all go to hershfield default exit destination';
UPDATE strongholdexitconfig SET
	riftConfigId = (SELECT TOP 1 id FROM [dbo].[riftconfigs] WHERE name='stronghold_default_exit')
WHERE zoneid=16 OR zoneid=70;


PRINT N'DELETE AND REINSERT FOR ZONES (71,72)';
DELETE FROM strongholdexitconfig WHERE zoneid IN (SELECT DISTINCT zoneid FROM #EXITS);
INSERT INTO strongholdexitconfig (zoneid, x, y, riftConfigId)
SELECT zoneid, x, y, (SELECT TOP 1 id FROM riftconfigs WHERE name=configName)
FROM #EXITS;


DROP TABLE IF EXISTS #CONFIGS;
DROP TABLE IF EXISTS #EXITS;
GO



PRINT N'ZZ_74_EntityDefaults_fragVol_update__2021_04_10.sql';
USE [perpetuumsa]
GO

---------------------------------------------
-- Reduce volume of Fragments by 50%
-- Date Modified: 2021/04/10
---------------------------------------------

PRINT N'SET FRAGMENT ENTITYDEFAULT VOLUMES';
DROP TABLE IF EXISTS #FRAGS;
CREATE TABLE #FRAGS(
	defName VARCHAR(100),
	vol FLOAT
);
INSERT INTO #FRAGS (defName, vol) VALUES
('def_robotshard_common_basic',0.005),
('def_robotshard_common_advanced',0.01),
('def_robotshard_common_expert',0.015),
('def_robotshard_thelodica_basic',0.005),
('def_robotshard_thelodica_advanced',0.01),
('def_robotshard_thelodica_expert',0.015),
('def_robotshard_nuimqol_basic',0.005),
('def_robotshard_nuimqol_advanced',0.01),
('def_robotshard_nuimqol_expert',0.015),
('def_robotshard_pelistal_basic',0.005),
('def_robotshard_pelistal_advanced',0.01),
('def_robotshard_pelistal_expert',0.015);

PRINT N'MERGE/UPDATE ON FRAGS';
MERGE [dbo].[entitydefaults] e USING #FRAGS f
ON e.definitionname=f.defName
WHEN MATCHED
    THEN UPDATE SET
	volume = f.vol;

PRINT N'DONE WITH FRAG VOLUMES';
DROP TABLE IF EXISTS #FRAGS;
GO



PRINT N'PATCH 21 APPLIED';
GO
