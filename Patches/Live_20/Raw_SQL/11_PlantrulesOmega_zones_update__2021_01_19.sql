USE [perpetuumsa]
GO

---------------------------------------------
-- Stronghold plant rule apply to Omega
--
-- Date 2021/01/19
---------------------------------------------


UPDATE zones SET
	plantruleset=(SELECT plantruleset FROM zones WHERE name='zone_strghld_70')
WHERE name='zone_pvp_arena' AND id=16;

GO