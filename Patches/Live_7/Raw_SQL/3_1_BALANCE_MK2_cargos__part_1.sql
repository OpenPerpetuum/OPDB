USE [perpetuumsa]
GO

--ALL MK2 Cargos 150% of mk1 cargo
PRINT N'MK2 CARGO BALANCE';
UPDATE entitydefaults
SET options='#capacity=f4.5'
WHERE definitionname = 'def_robot_inventory_combat_ewrunner_mk2';

UPDATE entitydefaults
SET options='#capacity=f5.6'
WHERE definitionname = 'def_robot_inventory_combat_runner_mk2';

UPDATE entitydefaults
SET options='#capacity=f9.0'
WHERE definitionname = 'def_robot_inventory_combat_crawler_mk2';

UPDATE entitydefaults
SET options='#capacity=f11.25'
WHERE definitionname = 'def_robot_inventory_combat_ewmech_indy_runner_mk2';

UPDATE entitydefaults
SET options='#capacity=f13.5'
WHERE definitionname = 'def_robot_inventory_combat_mech_mk2';

UPDATE entitydefaults
SET options='#capacity=f18.0'
WHERE definitionname = 'def_robot_inventory_combat_heavymech_mk2';

UPDATE entitydefaults
SET options='#capacity=f22.5'
WHERE definitionname = 'def_robot_inventory_indy_mech_mk2';

UPDATE entitydefaults
SET options='#capacity=f31.5'
WHERE definitionname = 'def_robot_inventory_indy_heavymech_mk2';

UPDATE entitydefaults
SET options='#capacity=f1080.0'
WHERE definitionname = 'def_robot_inventory_lithus_mk2';

UPDATE entitydefaults
SET options='#capacity=f180.0'
WHERE definitionname = 'def_robot_inventory_sequer_mk2';

UPDATE entitydefaults
SET options='#capacity=f3240.0'
WHERE definitionname = 'def_robot_inventory_scarab_mk2';

GO