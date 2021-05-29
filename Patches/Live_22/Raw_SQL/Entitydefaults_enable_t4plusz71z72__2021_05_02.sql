USE [perpetuumsa]
GO

PRINT N'Enable and show ALL T4+ FOR Z71-72';

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
		hidden=0;

PRINT N'all t4+ for z71-2 enabled and shown';
DROP TABLE IF EXISTS #HIDE;
GO