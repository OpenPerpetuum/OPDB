USE [perpetuumsa]
GO

----------------------------------------
-- Stronghold spawn rapid respawn fix
--
-- Date: 2020/07/11
----------------------------------------


UPDATE npcflock SET respawnmultiplierlow=1
WHERE name in (
	'intakt_stronghold_trash',
	'cam_stronghold_trash',
	'troiar_stronghold_trash',
	'Baph_stronghold_trash',
	'Arbalest_stronghold_trash',
	'Waspish_stronghold_trash'
);

GO