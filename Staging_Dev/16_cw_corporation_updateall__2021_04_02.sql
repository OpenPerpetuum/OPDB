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