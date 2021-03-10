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
