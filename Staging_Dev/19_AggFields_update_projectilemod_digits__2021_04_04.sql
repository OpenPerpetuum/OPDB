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