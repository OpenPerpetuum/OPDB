USE [perpetuumsa]
GO

--Mixed up cargos on hermes patch
--SET HERMES CARGO 16->20
PRINT N'HERMES cargo for real this time';
UPDATE entitydefaults
SET options='#capacity=f20.0'
WHERE definitionname = 'def_robot_inventory_hermes';

--FIX FOR DEV
PRINT N'IKARUS cargo fix';
UPDATE entitydefaults
SET options='#capacity=f30.0'
WHERE definitionname = 'def_robot_inventory_ikarus';

GO