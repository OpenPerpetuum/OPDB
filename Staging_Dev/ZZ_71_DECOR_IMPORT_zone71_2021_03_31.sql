USE [perpetuumsa]
GO
----------------------------------------------------------
-- DECOR REPLICATION SCRIPT (Import)
-- Decor replication involves transfer of layers and table entries
-- These scripts handle ONLY decore table entries.  
-- Layer data should be shared manually if layers are updated!
--
-- This is the IMPORT script which requires you have:
-- A) Correctly labeled, updated layer files in C:/perpserver/data/layers
-- B) The results of the export script
-- The Import will also WIPE all existing DECOR on the same ZONE!
-- If you wish to "merge" decor, handle the conflict as you see fit.
--
-- How to use Import:
-- 0.  Set the correct ZoneID
-- 1.  From the provided export text file: copy the contents
-- 2.  Paste the contents between the 'REPLACE' and 'END REPLACE'
-- 3.  Remove the last trailing ',' (comma) and replace with ';' (semicolon)
-- 4.  Run the script
----------------------------------------------------------

DECLARE @zoneID INT;
SET @zoneID = 71;

PRINT N'DELETING ALL DECOR ON ZONE: ' + CONVERT(varchar(10), @zoneID);
DELETE FROM decor WHERE zoneid=@zoneID;
INSERT INTO decor (definition, quaternionx, quaterniony, quaternionz, quaternionw, zoneid, x, y, z, scale, changed, fadedistance, category, locked) VALUES
--REPLACE
(2762,0,-0.694658,0,0.71934,71,30501,45669,4796,1,1,0,1,1),
(3491,0,0.878817,0,0.477159,71,50691,16540,8288,1,1,0,1,1),
(2755,0,0.615662,0,0.78801,71,52443,22290,7808,1,1,0,1,1),
(3469,0,0,0,1,71,44416,10880,7808,1,1,0,1,1),
(3469,0,0,0,1,71,43648,12072,7808,1,1,0,1,1),
(3443,0,-0.147809,0,0.989016,71,46720,14976,7808,1,1,0,1,1),
(3479,-0.011752,-0.89286,-0.05457,0.446864,71,42880,17898,7808,1,1,0,1,1),
(3479,0,0.48481,0,0.87462,71,43392,21120,7854,1,1,0,1,1),
(3479,0,-0.930418,0,0.366501,71,41344,18816,7792,1,1,0,1,1),
(3479,0,0.522499,0,0.85264,71,44473,20355,7804,1,1,0,1,1),
(3690,0,0,0,1,71,41856,15488,7808,1,1,0,1,1),
(3689,0,0,0,1,71,55168,32640,7808,1,1,0,1,1),
(2764,0,-0.284015,0,0.95882,71,35439,38893,7154,1,1,0,1,1),
(3443,0,0.422618,0,0.906308,71,55936,53120,3776,1,1,0,1,1),
(3744,0,0,0,1,71,41600,19072,7806,1,1,0,1,1),
(3744,0,0,0,1,71,43136,20864,7808,1,1,0,1,1),
(3744,0,0,0,1,71,43392,18304,7806,1,1,0,1,1),
(3744,0,0,0,1,71,44416,19840,7804,1,1,0,1,1),
(2763,0,0.422618,0,0.906308,71,38868,33144,7152,1,1,0,1,1);
--END REPLACE

GO