-- Fix stack/quantity for def_ammo_raven_cannon_t - 'Machete' RAVEN gun shell (a-d use quantity 1000).
USE [perpetuumsa];
GO

UPDATE dbo.entitydefaults SET quantity = 1000 WHERE definitionname = 'def_ammo_raven_cannon_t';
GO
