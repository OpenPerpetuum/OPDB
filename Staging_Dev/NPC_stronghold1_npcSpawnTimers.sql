USE [perpetuumsa]
GO

--------Stronghold 1 flock respawn timers---------------
PRINT N'Stronghold 1 flock respawn timers';


----------Boss timer 2hours------------
PRINT N'Boss spawn times';
DECLARE @MechRespawnTime int;
SET @MechRespawnTime = 7200;


UPDATE npcflock
SET respawnseconds=@MechRespawnTime
WHERE name='artemis_protector_stronghold1';

UPDATE npcflock
SET respawnseconds=@MechRespawnTime
WHERE name='kain_protector_stronghold1';

UPDATE npcflock
SET respawnseconds=@MechRespawnTime
WHERE name='tyrannos_protector';


-------Assist Spawns to 15min----------
PRINT N'2ndary spawn times';
DECLARE @SecondarySpawns int;
SET @SecondarySpawns = 900;

UPDATE npcflock
SET respawnseconds=@SecondarySpawns
WHERE name='cameleon_with_numiquol_protector';

UPDATE npcflock
SET respawnseconds=@SecondarySpawns
WHERE name='arbalest_with_numiquol_protector';

UPDATE npcflock
SET respawnseconds=@SecondarySpawns
WHERE name='intakt_by_protector';

UPDATE npcflock
SET respawnseconds=@SecondarySpawns
WHERE name='baphomet_by_protector';

UPDATE npcflock
SET respawnseconds=@SecondarySpawns
WHERE name='waspish_with_protector';

UPDATE npcflock
SET respawnseconds=@SecondarySpawns
WHERE name='troiar_with_protector';


-------Trash Spawns to 15min----------
PRINT N'Trashmob spawn times';
DECLARE @TrashSpawns int;
SET @TrashSpawns = 900;

UPDATE npcflock
SET respawnseconds=@TrashSpawns
WHERE name='intakt_stronghold_trash';

UPDATE npcflock
SET respawnseconds=@TrashSpawns
WHERE name='cam_stronghold_trash';

UPDATE npcflock
SET respawnseconds=@TrashSpawns
WHERE name='troiar_stronghold_trash';

UPDATE npcflock
SET respawnseconds=@TrashSpawns
WHERE name='Baph_stronghold_trash';

UPDATE npcflock
SET respawnseconds=@TrashSpawns
WHERE name='Arbalest_stronghold_trash';

UPDATE npcflock
SET respawnseconds=@TrashSpawns
WHERE name='Waspish_stronghold_trash';

GO