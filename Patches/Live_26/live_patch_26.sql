USE [perpetuumsa]
GO

PRINT N'PATCH 26: GAMMA BEGINS - PHASE 1';
------------------------------------------------------
-- Patch 26: Gamma phase 1/3
--00_harvestlog_table_proc__2021_10_15.sql
--00_npcEscalations_createtable_col__2021_09_18.sql
--01_OPP_GAMMA_ZONE_INIT__2021_06_09.sql
--02_decor_all_gammas__2021_08_06.sql
--03_artifactspawninfo__2021_08_01.sql
--04_teleports__2021_08_07.sql
--07_npcreinforcements_gamma_t0_flux__2021_09_01.sql
--09_zoneeffects__2021_09_03.sql
--14_relics__2021_10_09.sql
--Date Modified: 2021/10/20
------------------------------------------------------



PRINT N'00_harvestlog_table_proc__2021_10_15.sql';
USE [perpetuumsa]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[harvestlog]
GO

CREATE TABLE [dbo].[harvestlog](
	[eventtime] [smalldatetime] NOT NULL,
	[zoneid] [int] NOT NULL,
	[definition] [int] NOT NULL,
	[amount] [int] NOT NULL
) ON [PRIMARY]
GO


CREATE OR ALTER PROCEDURE [dbo].[writeharvestlog] 
	
	@zoneid INT,
	@definition INT,
	@quantity INT,
	@eventtime DATETIME
	
AS
BEGIN
	SET NOCOUNT ON;
		
	IF EXISTS (SELECT zoneid FROM harvestlog WHERE eventtime=@eventtime AND zoneid=@zoneid AND definition=@definition)
	BEGIN
		UPDATE harvestlog SET amount=amount+@quantity  WHERE eventtime=@eventtime AND zoneid=@zoneid AND definition=@definition
	end
	ELSE
	BEGIN
		INSERT harvestlog (zoneid,definition,amount,eventtime) VALUES (@zoneid,@definition,@quantity,@eventtime)
	END
	
    
	
END
GO


PRINT N'00_npcEscalations_createtable_col__2021_09_18.sql';
USE [perpetuumsa]
GO

-------------------------------------
-- Define new col/table for GrowingPresences
--
-- Date modifified: 2021/09/18
-------------------------------------

PRINT N'ALTER [dbo].[npcpresence]';
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[perpetuumsa].[dbo].[npcpresence]')
	AND name = 'growthseconds')
BEGIN
	PRINT N'ADDING COL pbsTechLimit';
	ALTER TABLE [perpetuumsa].[dbo].[npcpresence] ADD
		growthseconds INT NULL
END
GO

PRINT N'CREATE TABLE [dbo].[npcescalactions]';
DROP TABLE IF EXISTS dbo.npcescalactions;
CREATE TABLE dbo.npcescalactions (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	presenceId INT NOT NULL,
	flockId INT NOT NULL,
	level INT NOT NULL,
	chance FLOAT NOT NULL DEFAULT 1.0
);
GO

PRINT N'01_OPP_GAMMA_ZONE_INIT__2021_06_09.sql';
USE [perpetuumsa]
GO

-----------------------------------
-- Gamma zone inits and basic configs
-- This file sets the zone records
-- plants, minerals, and (empty) spawns
-- 
-- Date modified: 2021/10/12
-----------------------------------

DROP TABLE IF EXISTS #GAMMAPLANTS;
CREATE TABLE #GAMMAPLANTS(
	ruleSetID INT,
	plantRuleFile VARCHAR(100)
);
INSERT INTO #GAMMAPLANTS (ruleSetID, plantRuleFile) VALUES
--raceid3 thelodica
--t0
(30,'electroplant_t0.txt'),
(30,'irontree_t0.txt'),
(30,'slimeroot_t0.txt'),
--(30,'rustbush_t0.txt'),
(30,'bush_a.txt'),
(30,'bush_b.txt'),
(30,'coppertree.txt'),
(30,'devrinol.txt'),
(30,'grass_a.txt'),
(30,'grass_b.txt'),
(30,'nanowheat.txt'),
(30,'pinetree.txt'),
(30,'poffeteg.txt'),
(30,'quag.txt'),
(30,'rango.txt'),
(30,'reed.txt'),
--t1
--(31,'electroplant_t1.txt'),
(31,'irontree_t1.txt'),
(31,'slimeroot_t1.txt'),
--(31,'rustbush_t1.txt'),
(31,'electroplant_seeded_t1.txt'),
(31,'irontree_seeded_t1.txt'),
(31,'slimeroot_seeded_t1.txt'),
(31,'rustbush_seeded_t1.txt'),
(31,'bush_a.txt'),
(31,'bush_b.txt'),
(31,'coppertree.txt'),
(31,'devrinol.txt'),
(31,'grass_a.txt'),
(31,'grass_b.txt'),
(31,'nanowheat.txt'),
(31,'pinetree.txt'),
(31,'poffeteg.txt'),
(31,'quag.txt'),
(31,'rango.txt'),
(31,'reed.txt'),
(31,'wall.txt'),
--t2
--(32,'electroplant_t2.txt'),
(32,'irontree_t2.txt'),
(32,'slimeroot_t2.txt'),
--(32,'rustbush_t2.txt'),
(32,'electroplant_seeded_t2.txt'),
--(32,'irontree_seeded_t2.txt'),
--(32,'slimeroot_seeded_t2.txt'),
(32,'rustbush_seeded_t2.txt'),
(32,'bush_a.txt'),
(32,'bush_b.txt'),
(32,'coppertree.txt'),
(32,'devrinol.txt'),
(32,'grass_a.txt'),
(32,'grass_b.txt'),
(32,'nanowheat.txt'),
(32,'pinetree.txt'),
(32,'poffeteg.txt'),
(32,'quag.txt'),
(32,'rango.txt'),
(32,'reed.txt'),
(32,'wall.txt'),
--t3
--(33,'electroplant_t3.txt'),
(33,'irontree_t3.txt'),
(33,'slimeroot_t3.txt'),
--(33,'rustbush_t3.txt'),
--(33,'electroplant_seeded_t3.txt'),
--(33,'irontree_seeded_t3.txt'),
--(33,'slimeroot_seeded_t3.txt'),
(33,'rustbush_seeded_t3.txt'),
(33,'bush_a.txt'),
(33,'bush_b.txt'),
(33,'coppertree.txt'),
(33,'devrinol.txt'),
(33,'grass_a.txt'),
(33,'grass_b.txt'),
(33,'nanowheat.txt'),
(33,'pinetree.txt'),
(33,'poffeteg.txt'),
(33,'quag.txt'),
(33,'rango.txt'),
(33,'reed.txt'),
(33,'wall.txt'),
--TC
(34,'bush_a.txt'),
(34,'bush_b.txt'),
(34,'coppertree.txt'),
(34,'devrinol.txt'),
(34,'grass_a.txt'),
(34,'grass_b.txt'),
(34,'nanowheat.txt'),
(34,'pinetree.txt'),
(34,'poffeteg.txt'),
(34,'quag.txt'),
(34,'rango.txt'),
(34,'reed.txt'),

--raceid2 nuimqol
--t0
(20,'electroplant_t0.txt'),
(20,'irontree_t0.txt'),
--(20,'slimeroot_t0.txt'),
(20,'rustbush_t0.txt'),
(20,'bush_a.txt'),
(20,'bush_b.txt'),
(20,'coppertree.txt'),
(20,'devrinol.txt'),
(20,'grass_a.txt'),
(20,'grass_b.txt'),
(20,'nanowheat.txt'),
(20,'pinetree.txt'),
(20,'poffeteg.txt'),
(20,'quag.txt'),
(20,'rango.txt'),
(20,'reed.txt'),
--t1
--(21,'electroplant_t1.txt'),
(21,'irontree_t1.txt'),
--(21,'slimeroot_t1.txt'),
(21,'rustbush_t1.txt'),
(21,'electroplant_seeded_t1.txt'),
(21,'irontree_seeded_t1.txt'),
(21,'slimeroot_seeded_t1.txt'),
(21,'rustbush_seeded_t1.txt'),
(21,'bush_a.txt'),
(21,'bush_b.txt'),
(21,'coppertree.txt'),
(21,'devrinol.txt'),
(21,'grass_a.txt'),
(21,'grass_b.txt'),
(21,'nanowheat.txt'),
(21,'pinetree.txt'),
(21,'poffeteg.txt'),
(21,'quag.txt'),
(21,'rango.txt'),
(21,'reed.txt'),
(21,'wall.txt'),
--t2
--(22,'electroplant_t2.txt'),
(22,'irontree_t2.txt'),
--(22,'slimeroot_t2.txt'),
(22,'rustbush_t2.txt'),
(22,'electroplant_seeded_t2.txt'),
--(22,'irontree_seeded_t2.txt'),
(22,'slimeroot_seeded_t2.txt'),
--(22,'rustbush_seeded_t2.txt'),
(22,'bush_a.txt'),
(22,'bush_b.txt'),
(22,'coppertree.txt'),
(22,'devrinol.txt'),
(22,'grass_a.txt'),
(22,'grass_b.txt'),
(22,'nanowheat.txt'),
(22,'pinetree.txt'),
(22,'poffeteg.txt'),
(22,'quag.txt'),
(22,'rango.txt'),
(22,'reed.txt'),
(22,'wall.txt'),
--t3
--(23,'electroplant_t3.txt'),
(23,'irontree_t3.txt'),
--(23,'slimeroot_t3.txt'),
(23,'rustbush_t3.txt'),
--(23,'electroplant_seeded_t3.txt'),
--(23,'irontree_seeded_t3.txt'),
(23,'slimeroot_seeded_t3.txt'),
--(23,'rustbush_seeded_t3.txt'),
(23,'bush_a.txt'),
(23,'bush_b.txt'),
(23,'coppertree.txt'),
(23,'devrinol.txt'),
(23,'grass_a.txt'),
(23,'grass_b.txt'),
(23,'nanowheat.txt'),
(23,'pinetree.txt'),
(23,'poffeteg.txt'),
(23,'quag.txt'),
(23,'rango.txt'),
(23,'reed.txt'),
(23,'wall.txt'),
--TC
(24,'bush_a.txt'),
(24,'bush_b.txt'),
(24,'coppertree.txt'),
(24,'devrinol.txt'),
(24,'grass_a.txt'),
(24,'grass_b.txt'),
(24,'nanowheat.txt'),
(24,'pinetree.txt'),
(24,'poffeteg.txt'),
(24,'quag.txt'),
(24,'rango.txt'),
(24,'reed.txt'),

--raceid1 pelistal
--t0
(10,'electroplant_t0.txt'),
--(10,'irontree_t0.txt'),
(10,'slimeroot_t0.txt'),
(10,'rustbush_t0.txt'),
(10,'bush_a.txt'),
(10,'bush_b.txt'),
(10,'coppertree.txt'),
(10,'devrinol.txt'),
(10,'grass_a.txt'),
(10,'grass_b.txt'),
(10,'nanowheat.txt'),
(10,'pinetree.txt'),
(10,'poffeteg.txt'),
(10,'quag.txt'),
(10,'rango.txt'),
(10,'reed.txt'),
--t1
--(11,'electroplant_t1.txt'),
--(11,'irontree_t1.txt'),
(11,'slimeroot_t1.txt'),
(11,'rustbush_t1.txt'),
(11,'electroplant_seeded_t1.txt'),
(11,'irontree_seeded_t1.txt'),
(11,'slimeroot_seeded_t1.txt'),
(11,'rustbush_seeded_t1.txt'),
(11,'bush_a.txt'),
(11,'bush_b.txt'),
(11,'coppertree.txt'),
(11,'devrinol.txt'),
(11,'grass_a.txt'),
(11,'grass_b.txt'),
(11,'nanowheat.txt'),
(11,'pinetree.txt'),
(11,'poffeteg.txt'),
(11,'quag.txt'),
(11,'rango.txt'),
(11,'reed.txt'),
(11,'wall.txt'),
--t2
--(12,'electroplant_t2.txt'),
--(12,'irontree_t2.txt'),
(12,'slimeroot_t2.txt'),
(12,'rustbush_t2.txt'),
(12,'electroplant_seeded_t2.txt'),
(12,'irontree_seeded_t2.txt'),
--(12,'slimeroot_seeded_t2.txt'),
--(12,'rustbush_seeded_t2.txt'),
(12,'bush_a.txt'),
(12,'bush_b.txt'),
(12,'coppertree.txt'),
(12,'devrinol.txt'),
(12,'grass_a.txt'),
(12,'grass_b.txt'),
(12,'nanowheat.txt'),
(12,'pinetree.txt'),
(12,'poffeteg.txt'),
(12,'quag.txt'),
(12,'rango.txt'),
(12,'reed.txt'),
(12,'wall.txt'),
--t3
--(13,'electroplant_t3.txt'),
--(13,'irontree_t3.txt'),
(13,'slimeroot_t3.txt'),
(13,'rustbush_t3.txt'),
--(13,'electroplant_seeded_t3.txt'),
(13,'irontree_seeded_t3.txt'),
--(13,'slimeroot_seeded_t3.txt'),
--(13,'rustbush_seeded_t3.txt'),
(13,'bush_a.txt'),
(13,'bush_b.txt'),
(13,'coppertree.txt'),
(13,'devrinol.txt'),
(13,'grass_a.txt'),
(13,'grass_b.txt'),
(13,'nanowheat.txt'),
(13,'pinetree.txt'),
(13,'poffeteg.txt'),
(13,'quag.txt'),
(13,'rango.txt'),
(13,'reed.txt'),
(13,'wall.txt'),
--TC
(14,'bush_a.txt'),
(14,'bush_b.txt'),
(14,'coppertree.txt'),
(14,'devrinol.txt'),
(14,'grass_a.txt'),
(14,'grass_b.txt'),
(14,'nanowheat.txt'),
(14,'pinetree.txt'),
(14,'poffeteg.txt'),
(14,'quag.txt'),
(14,'rango.txt'),
(14,'reed.txt');


DROP TABLE IF EXISTS #FACTIONPLANTMAP;
CREATE TABLE #FACTIONPLANTMAP(
	raceID INT,
	tierLevel INT,
	ruleID INT
);
INSERT INTO #FACTIONPLANTMAP (raceID, tierLevel, ruleID) VALUES
(1, 0, 10),
(1, 1, 11),
(1, 2, 12),
(1, 3, 13),
(1, -1, 14),
(2, 0, 20),
(2, 1, 21),
(2, 2, 22),
(2, 3, 23),
(2, -1, 24),
(3, 0, 30),
(3, 1, 31),
(3, 2, 32),
(3, 3, 33),
(3, -1, 34);

DROP TABLE IF EXISTS #GAMMAZONEPREP;
CREATE TABLE #GAMMAZONEPREP(
	zId INT,
	zPrefix VARCHAR(100),
	zSize INT,
	x INT,
	y INT,
	raceID INT,
	tier INT
);
INSERT INTO #GAMMAZONEPREP (zId, zPrefix, zSize, x, y, raceID, tier) VALUES
--Tc islands
(100, 'zone_gamma_tc_z', 256, 9488, -31302, 1, -1),
(101, 'zone_gamma_tc_z', 256, 774, -36237, 1, -1),
(102, 'zone_gamma_tc_z', 256, -9582, -32128, 3, -1),
(103, 'zone_gamma_tc_z', 256, -9035, -23034, 3, -1),
(104, 'zone_gamma_tc_z', 256, 1647, -16026, 2, -1),
(105, 'zone_gamma_tc_z', 256, 13275, -23435, 2, -1),

--Phase1
(106, 'zone_gamma_z', 2048, 3731, -29068, 2, 2),
(107, 'zone_gamma_z', 2048, -81, -27422, 3, 3),
(108, 'zone_gamma_z', 2048, -6233, -29242, 3, 2),
(109, 'zone_gamma_z', 2048, -5410, -22223, 3, 1),
(110, 'zone_gamma_z', 2048, 1435, -22223, 2, 0),
(111, 'zone_gamma_z', 2048, 7630, -24519, 2, 1),
(112, 'zone_gamma_z', 2048, 10923, -27985, 2, 1),
(113, 'zone_gamma_z', 2048, 3168, -33574, 1, 1),
(114, 'zone_gamma_z', 2048, -3677, -33487, 1, 0),
(115, 'zone_gamma_z', 2048, -7230, -35697, 1, 1),
(116, 'zone_gamma_z', 2048, -12862, -28548, 3, 1),

--Phase2
(117, 'zone_gamma_z', 2048, -15678, -24303, 3, 1),
(118, 'zone_gamma_z', 2048, -17584, -19624, 3, 2),
(119, 'zone_gamma_z', 2048, -16588, -31884, 3, 0),
(120, 'zone_gamma_z', 2048, -13468, -36867, 3, 1),
(121, 'zone_gamma_z', 2048, -12515, -41502, 1, 2),
(122, 'zone_gamma_z', 2048, -8876, -44102, 1, 3),
(123, 'zone_gamma_z', 2048, -4240, -42455, 1, 2),
(124, 'zone_gamma_z', 2048, -428, -46354, 1, 2),
(125, 'zone_gamma_z', 2048, 3774, -44535, 1, 1),
(126, 'zone_gamma_z', 2048, 8367, -41372, 1, 2),
(127, 'zone_gamma_z', 2048, 4858, -38556, 1, 2),
(128, 'zone_gamma_z', 2048, 9536, -36910, 2, 3),
(129, 'zone_gamma_z', 2048, 14389, -37516, 2, 2),
(130, 'zone_gamma_z', 2048, 14215, -33877, 2, 1),
(131, 'zone_gamma_z', 2048, 15299, -30108, 2, 0),
(132, 'zone_gamma_z', 2048, 17118, -25256, 2, 1),
(133, 'zone_gamma_z', 2048, 17725, -20577, 2, 2),
(134, 'zone_gamma_z', 2048, 14259, -17761, 2, 3),
(135, 'zone_gamma_z', 2048, 8973, -19147, 2, 2),
(136, 'zone_gamma_z', 2048, 10360, -13298, 2, 2),
(137, 'zone_gamma_z', 2048, 3428, -11688, 3, 1),
(138, 'zone_gamma_z', 2048, -4674, -14078, 3, 2),
(139, 'zone_gamma_z', 2048, -5150, -17674, 3, 2),
(140, 'zone_gamma_z', 2048, -13165, -17804, 3, 3);

DROP TABLE IF EXISTS #GAMMAORES;
CREATE TABLE #GAMMAORES(
	raceID INT,
	tier INT,
	mineralName VARCHAR(100),
	maxFields INT,
	maxTilesPerField INT,
	totalAmountPerField INT
);
INSERT INTO #GAMMAORES(raceID, tier, mineralName, maxFields, maxTilesPerField, totalAmountPerField) VALUES
(1, 0, 'titan', 10, 600, 225000000),
(1, 0, 'crude', 5, 600, 225000000),
--(1, 0, 'stermonit', 6, 600, 225000000),
(1, 0, 'imentium', 10, 600, 225000000),
(1, 0, 'liquizit', 5, 600, 225000000),
(1, 0, 'epriton', 5, 300, 50000000),
(1, 0, 'silgium', 10, 600, 225000000),
--(1, 0, 'gammaterial', 3, 50, 10000000),
--(1, 0, 'energymineral', 9, 200, 12000000),
(1, 0, 'fluxore', 2, 200, 5000000),

(2, 0, 'titan', 10, 600, 225000000),
(2, 0, 'crude', 5, 600, 225000000),
(2, 0, 'stermonit', 10, 600, 225000000),
(2, 0, 'imentium', 10, 600, 225000000),
(2, 0, 'liquizit', 5, 600, 225000000),
(2, 0, 'epriton', 5, 300, 50000000),
--(2, 0, 'silgium', 6, 600, 225000000),
--(2, 0, 'gammaterial', 3, 50, 10000000),
--(2, 0, 'energymineral', 9, 200, 12000000),
(2, 0, 'fluxore', 2, 200, 5000000),

(3, 0, 'titan', 10, 600, 225000000),
(3, 0, 'crude', 5, 600, 225000000),
(3, 0, 'stermonit', 10, 600, 225000000),
--(3, 0, 'imentium', 6, 600, 225000000),
(3, 0, 'liquizit', 5, 600, 225000000),
(3, 0, 'epriton', 5, 300, 50000000),
(3, 0, 'silgium', 10, 600, 225000000),
--(3, 0, 'gammaterial', 3, 50, 10000000),
--(3, 0, 'energymineral', 9, 200, 12000000),
(3, 0, 'fluxore', 2, 200, 5000000),

(1, 1, 'titan', 10, 600, 175000000),
(1, 1, 'crude', 5, 600, 175000000),
--(1, 1, 'stermonit', 5, 600, 175000000),
(1, 1, 'imentium', 10, 600, 175000000),
(1, 1, 'liquizit', 5, 600, 175000000),
--(1, 1, 'epriton', 2, 300, 50000000),
(1, 1, 'silgium', 10, 600, 175000000),
(1, 1, 'gammaterial', 10, 100, 10000000),
(1, 1, 'energymineral', 10, 200, 12000000),
--(1, 1, 'fluxore', 2, 200, 5000000),

(2, 1, 'titan', 10, 600, 175000000),
(2, 1, 'crude', 5, 600, 175000000),
(2, 1, 'stermonit', 10, 600, 175000000),
(2, 1, 'imentium', 10, 600, 175000000),
(2, 1, 'liquizit', 5, 600, 175000000),
--(2, 1, 'epriton', 2, 300, 50000000),
--(2, 1, 'silgium', 5, 600, 175000000),
(2, 1, 'gammaterial', 10, 100, 10000000),
(2, 1, 'energymineral', 10, 200, 12000000),
--(2, 1, 'fluxore', 2, 200, 5000000),

(3, 1, 'titan', 10, 600, 175000000),
(3, 1, 'crude', 5, 600, 175000000),
(3, 1, 'stermonit', 10, 600, 175000000),
--(3, 1, 'imentium', 5, 600, 175000000),
(3, 1, 'liquizit', 5, 600, 175000000),
--(3, 1, 'epriton', 2, 300, 50000000),
(3, 1, 'silgium', 10, 600, 175000000),
(3, 1, 'gammaterial', 10, 100, 10000000),
(3, 1, 'energymineral', 10, 200, 12000000),
--(3, 1, 'fluxore', 2, 200, 5000000),

(1, 2, 'titan', 7, 600, 125000000),
(1, 2, 'crude', 4, 600, 125000000),
--(1, 2, 'stermonit', 4, 600, 125000000),
(1, 2, 'imentium', 7, 600, 125000000),
(1, 2, 'liquizit', 4, 600, 125000000),
--(1, 2, 'epriton', 2, 300, 50000000),
(1, 2, 'silgium', 7, 600, 125000000),
(1, 2, 'gammaterial', 7, 100, 10000000),
(1, 2, 'energymineral', 12, 200, 24000000),
--(1, 2, 'fluxore', 2, 200, 5000000),

(2, 2, 'titan', 7, 600, 125000000),
(2, 2, 'crude', 4, 600, 125000000),
(2, 2, 'stermonit', 7, 600, 125000000),
(2, 2, 'imentium', 7, 600, 125000000),
(2, 2, 'liquizit', 4, 600, 125000000),
--(2, 2, 'epriton', 2, 300, 50000000),
--(2, 2, 'silgium', 4, 600, 125000000),
(2, 2, 'gammaterial', 7, 100, 10000000),
(2, 2, 'energymineral', 12, 200, 24000000),
--(2, 2, 'fluxore', 2, 200, 5000000),

(3, 2, 'titan', 7, 600, 125000000),
(3, 2, 'crude', 4, 600, 125000000),
(3, 2, 'stermonit', 7, 600, 125000000),
--(3, 2, 'imentium', 4, 600, 125000000),
(3, 2, 'liquizit', 4, 600, 125000000),
--(3, 2, 'epriton', 2, 300, 50000000),
(3, 2, 'silgium', 7, 600, 125000000),
(3, 2, 'gammaterial', 7, 100, 10000000),
(3, 2, 'energymineral', 12, 200, 24000000),
--(3, 2, 'fluxore', 2, 200, 5000000),

(1, 3, 'titan', 5, 600, 100000000),
(1, 3, 'crude', 3, 600, 100000000),
--(1, 3, 'stermonit', 3, 600, 100000000),
(1, 3, 'imentium', 5, 600, 100000000),
(1, 3, 'liquizit', 3, 600, 100000000),
--(1, 3, 'epriton', 2, 300, 50000000),
(1, 3, 'silgium', 5, 600, 100000000),
(1, 3, 'gammaterial', 3, 100, 10000000),
(1, 3, 'energymineral', 15, 200, 36000000),
--(1, 3, 'fluxore', 2, 200, 5000000),

(2, 3, 'titan', 5, 600, 100000000),
(2, 3, 'crude', 3, 600, 100000000),
(2, 3, 'stermonit', 5, 600, 100000000),
(2, 3, 'imentium', 5, 600, 100000000),
(2, 3, 'liquizit', 3, 600, 100000000),
--(2, 3, 'epriton', 2, 300, 50000000),
--(2, 3, 'silgium', 3, 600, 100000000),
(2, 3, 'gammaterial', 3, 100, 10000000),
(2, 3, 'energymineral', 15, 200, 36000000),
--(2, 3, 'fluxore', 2, 200, 5000000),

(3, 3, 'titan', 5, 600, 100000000),
(3, 3, 'crude', 3, 600, 100000000),
(3, 3, 'stermonit', 5, 600, 100000000),
--(3, 3, 'imentium', 3, 600, 100000000),
(3, 3, 'liquizit', 3, 600, 100000000),
--(3, 3, 'epriton', 2, 300, 50000000),
(3, 3, 'silgium', 5, 600, 100000000),
(3, 3, 'gammaterial', 3, 100, 10000000),
(3, 3, 'energymineral', 15, 200, 36000000);
--(3, 3, 'fluxore', 2, 200, 5000000);

--PRINT N'CLEAR teleportdescriptions';
--DELETE FROM teleportdescriptions WHERE sourcezone in (SELECT zId FROM #GAMMAZONEPREP) OR targetzone in (SELECT zId FROM #GAMMAZONEPREP);
--DELETE FROM zoneentities WHERE zoneID in (SELECT zId FROM #GAMMAZONEPREP);
--DELETE FROM zoneuserentities WHERE zoneID in (SELECT zId FROM #GAMMAZONEPREP);


PRINT N'CLEAR PLANT RULES';
SELECT * FROM plantrules WHERE rulesetid IN (SELECT DISTINCT ruleSetID FROM #GAMMAPLANTS);
DELETE FROM plantrules WHERE rulesetid IN (SELECT DISTINCT ruleSetID FROM #GAMMAPLANTS);
PRINT N'INSERT PLANT RULES';
INSERT INTO plantrules (plantrule, rulesetid, note)
SELECT plantRuleFile, ruleSetID, 'Gamma Plant Rules' FROM #GAMMAPLANTS;


PRINT N'CLEAR FLOCKS';
SELECT * FROM npcflock WHERE presenceid IN (
	SELECT id FROM npcpresence WHERE spawnid IN (
		SELECT spawnid FROM zones WHERE id IN (
			SELECT zId FROM #GAMMAZONEPREP
		)
	)
);
DELETE FROM npcflock WHERE presenceid IN (
	SELECT id FROM npcpresence WHERE spawnid IN (
		SELECT spawnid FROM zones WHERE id IN (
			SELECT zId FROM #GAMMAZONEPREP
		)
	)
);
PRINT N'CLEAR PRESENCE';
SELECT * FROM npcpresence WHERE spawnid IN (
	SELECT spawnid FROM zones WHERE id IN (
		SELECT zId FROM #GAMMAZONEPREP
	)
);
DELETE FROM npcpresence WHERE spawnid IN (
	SELECT spawnid FROM zones WHERE id IN (
		SELECT zId FROM #GAMMAZONEPREP
	)
);

PRINT N'CLEAR SPAWN';
SELECT * FROM npcspawn WHERE name IN (SELECT 'zone_gamma_' + CONVERT(varchar(10), zId) + '_spawn' FROM #GAMMAZONEPREP);
DELETE FROM npcspawn WHERE name IN (SELECT 'zone_gamma_' + CONVERT(varchar(10), zId) + '_spawn' FROM #GAMMAZONEPREP);


PRINT N'INSERT SPAWN';
INSERT INTO [dbo].[npcspawn] ([name],[description],[note])
SELECT 'zone_gamma_' + CONVERT(varchar(10), zId) + '_spawn',
'zone_gamma_' + CONVERT(varchar(10), zId) + '_spawn',
'zone_gamma_' + CONVERT(varchar(10), zId) + '_spawn' FROM #GAMMAZONEPREP;


--SET ENTITY FOR ZONE STORAGE
DECLARE @storageDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_zone_storage');
--MAJOR ASSUMPTION [entities] eid's 2200<->2300 are unused!
MERGE [dbo].[entities] AS e
USING #GAMMAZONEPREP AS g 
ON (e.ename = 'es_zone_'+CONVERT(varchar(10), g.zId)+'_storage') 
WHEN MATCHED THEN 
	UPDATE SET
		e.eid=2100+g.zId
WHEN NOT MATCHED 
	THEN INSERT (eid,definition,owner,parent,health,ename,quantity,repackaged,dynprop) VALUES 
		(2100+zId,@storageDef,NULL,NULL,100,'es_zone_'+CONVERT(varchar(10), zId)+'_storage',1,0,NULL);

MERGE [dbo].[entitystorage] AS s
USING #GAMMAZONEPREP AS g 
ON (s.storage_name = 'es_zone_'+CONVERT(varchar(10), g.zId)+'_storage') 
WHEN MATCHED THEN 
	UPDATE SET
		s.eid=(SELECT TOP 1 eid FROM entities WHERE ename='es_zone_'+CONVERT(varchar(10), zId)+'_storage')
WHEN NOT MATCHED 
	THEN INSERT (storage_name,eid) VALUES 
		('es_zone_'+CONVERT(varchar(10), zId)+'_storage', (SELECT TOP 1 eid FROM entities WHERE ename='es_zone_'+CONVERT(varchar(10), zId)+'_storage'));


MERGE [dbo].[zones] AS z
USING #GAMMAZONEPREP AS g
ON g.zId=z.id
WHEN MATCHED THEN
	UPDATE SET
		x=g.x,
		y=g.y,
		name=g.zPrefix+CONVERT(varchar(10), g.zId),
		description=g.zPrefix+CONVERT(varchar(10), g.zId)+'_desc',
		note='gamma tier '+CONVERT(varchar(10), g.tier),
		fertility=15,
		zoneplugin='zone_'+CONVERT(varchar(10), g.zId),
		zoneip='109.236.88.106',
		zoneport=18800+g.zId,
		isinstance=0,
		enabled=1,
		spawnid=(SELECT TOP 1 id FROM npcspawn WHERE name='zone_gamma_' + CONVERT(varchar(10), g.zId) + '_spawn'),
		plantruleset=(SELECT TOP 1 f.ruleID FROM #FACTIONPLANTMAP AS f WHERE f.raceID=g.raceID AND f.tierLevel=g.tier),
		protected=0,
		raceid=g.raceID,
		width=g.zSize,
		height=g.zSize,
		terraformable=CASE WHEN g.tier > 0 THEN 1 ELSE 0 END,
		zonetype=2,
		sparkcost=3,
		maxdockingbase=CASE WHEN g.tier > 0 THEN 2 ELSE 0 END,
		sleeping=0,
		plantaltitudescale=1,
		host='genxyHost-01',
		active=1,
		pbsTechLimit=CASE WHEN g.tier > 0 THEN g.tier ELSE 0 END
WHEN NOT MATCHED THEN 
	INSERT ([id],[x],[y],[name],[description],[note],[fertility],[zoneplugin],[zoneip],[zoneport],[isinstance],[enabled],[spawnid],[plantruleset]
		,[protected],[raceid],[width],[height],[terraformable],[zonetype],[sparkcost],[maxdockingbase],[sleeping],[plantaltitudescale],[host],[active],[pbsTechLimit])
VALUES
	(g.zId,
	g.x,
	g.y, 
	g.zPrefix+CONVERT(varchar(10), g.zId),--[name]
	g.zPrefix+CONVERT(varchar(10), g.zId)+'_desc',--[description]
	'gamma tier '+CONVERT(varchar(10), g.tier),--[note]
	15,--[fertility]
	'zone_'+CONVERT(varchar(10), g.zId),--[zoneplugin]
	'109.236.88.106',--[zoneip]
	18800+g.zId,--[zoneport]
	0,--[isinstance]
	1,--[enabled]
	(SELECT TOP 1 id FROM npcspawn WHERE name='zone_gamma_' + CONVERT(varchar(10), g.zId) + '_spawn'),--[spawnid]
	(SELECT TOP 1 f.ruleID FROM #FACTIONPLANTMAP AS f WHERE f.raceID=g.raceID AND f.tierLevel=g.tier),--[plantruleset]
	0,--[protected]
	g.raceID,--[raceid]
	g.zSize,--[width]
	g.zSize,--[height]
	CASE WHEN g.tier > 0 THEN 1 ELSE 0 END,--[terraformable]--Set to 0 to disable erosion to altitude edits
	2,--[zonetype]
	3,--[sparkcost]
	CASE WHEN g.tier > 0 THEN 2 ELSE 0 END, --[maxdockingbase] 
	0,--[sleeping]
	1,--[plantaltitudescale]
	'genxyHost-01',--[host]
	1,--[active],
	CASE WHEN g.tier > 0 THEN g.tier ELSE 0 END--[pbsTechLimit]
);


SELECT * FROM zoneriftsconfig WHERE zoneid IN (SELECT zId FROM #GAMMAZONEPREP);
DELETE FROM zoneriftsconfig WHERE zoneid IN (SELECT zId FROM #GAMMAZONEPREP);

INSERT INTO zoneriftsconfig (zoneid, maxrifts, maxlevel)
	SELECT zId, 10, 4 FROM #GAMMAZONEPREP WHERE tier>0 OR zSize>2000;

INSERT INTO zoneriftsconfig (zoneid, maxrifts, maxlevel)
	SELECT zId, 0, 0 FROM #GAMMAZONEPREP WHERE zId NOT IN (SELECT zoneid FROM zoneriftsconfig);

SELECT * FROM mineralnodes WHERE zoneid IN (SELECT zId FROM #GAMMAZONEPREP);
DELETE FROM mineralnodes WHERE zoneid IN (SELECT zId FROM #GAMMAZONEPREP);

SELECT * FROM mineralconfigs WHERE zoneid IN (SELECT zId FROM #GAMMAZONEPREP);
DELETE FROM mineralconfigs WHERE zoneid IN (SELECT zId FROM #GAMMAZONEPREP);


INSERT INTO mineralconfigs (zoneid, materialtype, maxnodes, maxtilespernode, totalamountpernode, minthreshold)
	SELECT 
		z.zId,
		(select top 1 idx from minerals where name=o.mineralName) as matId,
		o.maxFields,
		o.maxTilesPerField,
		o.totalAmountPerField,
		0.5
	 FROM #GAMMAZONEPREP z JOIN #GAMMAORES o on o.tier=z.tier AND o.raceID=z.raceID
	 order by z.zId, matId;


DROP TABLE IF EXISTS #FACTIONPLANTMAP;
DROP TABLE IF EXISTS #GAMMAPLANTS;
DROP TABLE IF EXISTS #GAMMAORES;
DROP TABLE IF EXISTS #GAMMAZONEPREP;
GO


PRINT N'02_decor_all_gammas__2021_08_06.sql';
USE [perpetuumsa]
GO

-------------------------------------------
-- Set Decor of all applicable gamma zones
--
-- Date Modified: 2021/08/06
-------------------------------------------


PRINT N'SETTING DECOR ON ALL DECORED GAMMAS';
USE [perpetuumsa]
GO
DECLARE @zoneID INT;
SET @zoneID = 110;

PRINT N'DELETING ALL DECOR ON ZONE: ' + CONVERT(varchar(10), @zoneID);
DELETE FROM decor WHERE zoneid=@zoneID;
INSERT INTO decor (definition, quaternionx, quaterniony, quaternionz, quaternionw, zoneid, x, y, z, scale, changed, fadedistance, category, locked) VALUES
(3424,0,0,0,1,110,257152,255616,23599,1,1,0,1,1);

SET @zoneID = 114;

PRINT N'DELETING ALL DECOR ON ZONE: ' + CONVERT(varchar(10), @zoneID);
DELETE FROM decor WHERE zoneid=@zoneID;
INSERT INTO decor (definition, quaternionx, quaterniony, quaternionz, quaternionw, zoneid, x, y, z, scale, changed, fadedistance, category, locked) VALUES
(3493,0,0.544639,0,0.838671,114,233088,254080,21642,1,1,0,1,1);

SET @zoneID = 119;

PRINT N'DELETING ALL DECOR ON ZONE: ' + CONVERT(varchar(10), @zoneID);
DELETE FROM decor WHERE zoneid=@zoneID;
INSERT INTO decor (definition, quaternionx, quaterniony, quaternionz, quaternionw, zoneid, x, y, z, scale, changed, fadedistance, category, locked) VALUES
(3495,0,0,0,1,119,295552,253824,30190,1,1,0,1,1);

SET @zoneID = 131;

PRINT N'DELETING ALL DECOR ON ZONE: ' + CONVERT(varchar(10), @zoneID);
DELETE FROM decor WHERE zoneid=@zoneID;
INSERT INTO decor (definition, quaternionx, quaterniony, quaternionz, quaternionw, zoneid, x, y, z, scale, changed, fadedistance, category, locked) VALUES
(3430,0,0,0,1,131,261248,249984,27424,1,1,0,1,1);

GO

USE [perpetuumsa]
GO
DECLARE @zoneID INT;
SET @zoneID = 105;

PRINT N'DELETING ALL DECOR ON ZONE: ' + CONVERT(varchar(10), @zoneID);
DELETE FROM decor WHERE zoneid=@zoneID;
INSERT INTO decor (definition, quaternionx, quaterniony, quaternionz, quaternionw, zoneid, x, y, z, scale, changed, fadedistance, category, locked) VALUES
--REPLACE
(3291,0,0,0,1,105,20096,26496,4140,1,1,0,1,1),
(3291,0,0.507538,0,0.861629,105,15232,34944,4140,1,1,0,1,1),
(3291,0,-0.529919,0,0.848048,105,26752,35456,4140,1,1,0,1,1),
(3291,0.095229,0.01085,0.112682,0.988997,105,20096,21852,4077,1,1,0,1,1),
(3291,0,0,-0.078459,0.996917,105,20096,17252,4073,1,1,0,1,1),
(3291,0,0,0.07846,0.996917,105,20096,12944,3953,1,1,0,1,1),
(3291,0.023254,0.189387,-0.11963,0.97431,105,20847,8767,3954,1,1,0,1,1),
(3291,-0.050837,-0.528265,0.000929,0.847556,105,31068,37741,4140,1,1,0,1,1),
(3291,-0.143563,-0.519404,0.049008,0.840956,105,34695,39727,4018,1,1,0,1,1),
(3291,0.012692,0.500902,0.098366,0.859801,105,10437,37389,4031,1,1,0,1,1),
(3692,0,0,0,1,105,17792,28288,4122,1,1,0,1,1),
(3691,0,0,0,1,105,23424,28288,4140,1,1,0,1,1),
(3692,0,0,0.241922,0.970296,105,23680,42112,3426,1,1,0,1,1),
(3693,0,0,-0.34202,0.939693,105,20864,45696,4008,1,1,0,1,1),
(3691,0,0,-0.113203,0.993572,105,17024,40320,3247,1,1,0,1,1);
--END REPLACE

GO

USE [perpetuumsa]
GO
DECLARE @zoneID INT;
SET @zoneID = 104;

PRINT N'DELETING ALL DECOR ON ZONE: ' + CONVERT(varchar(10), @zoneID);
DELETE FROM decor WHERE zoneid=@zoneID;
INSERT INTO decor (definition, quaternionx, quaterniony, quaternionz, quaternionw, zoneid, x, y, z, scale, changed, fadedistance, category, locked) VALUES
--REPLACE
(3343,-0.002131,0.997527,-0.034834,0.061012,104,18048,29568,4834,5,1,0,1,1),
(3443,0,0,0.052336,0.99863,104,13952,17024,4107,1,1,0,1,1),
(3498,-0.046422,0.758988,-0.039648,-0.648237,104,24704,21856,5158,0.5,1,0,1,1),
(2747,0,0,-0.165048,0.986286,104,47488,35712,911,1,1,0,1,1);
--END REPLACE

GO

USE [perpetuumsa]
GO
DECLARE @zoneID INT;
SET @zoneID = 103;

PRINT N'DELETING ALL DECOR ON ZONE: ' + CONVERT(varchar(10), @zoneID);
DELETE FROM decor WHERE zoneid=@zoneID;
INSERT INTO decor (definition, quaternionx, quaterniony, quaternionz, quaternionw, zoneid, x, y, z, scale, changed, fadedistance, category, locked) VALUES
--REPLACE
(3474,0,0,0,1,103,43136,30336,4144,1,1,0,1,1),
(3337,0,0,0,1,103,43136,33152,6460,1,1,0,1,1),
(3337,0,0,0,1,103,43136,31872,6462,1,1,0,1,1),
(3474,0,0,0,1,103,43109,27776,4144,1,1,0,1,1),
(3337,0,0,0,1,103,43154,29056,6477,1,1,0,1,1),
(3345,0,0.99863,0,0.052336,103,43136,26240,3625,1,1,0,1,1),
(3718,0,-0.999657,0,-0.026177,103,44908,20864,4144,1,1,0,1,1),
(3718,0,0.999847,0,0.017452,103,44943,23424,4144,1,1,0,1,1),
(3727,0,0,0,1,103,44117,26953,4144,3,1,0,1,1),
(3393,0,0,0,1,103,44160,25425,4144,1,1,0,1,1),
(3396,0,0,0,1,103,44292,27008,9146,1,1,0,1,1),
(3697,0,0,0,1,103,40064,33152,4144,1,1,0,1,1),
(3697,0,0,0,1,103,47744,29312,4136,1,1,0,1,1),
(3697,0,0,0,1,103,39040,22400,4144,1,1,0,1,1),
(3337,0,0.707107,0,0.707106,103,17280,19995,4487,1,1,0,1,1),
(3337,0,0.707107,0,0.707107,103,19599,20000,4475,1,1,0,1,1),
(3337,0,0.700909,0,0.71325,103,21960,19972,4456,1,1,0,1,1),
(3337,0,0.707106,0,0.707107,103,24192,19953,4452,1,1,0,1,1),
(3337,0,0.707107,0,0.707106,103,26496,19948,4453,1,1,0,1,1),
(3458,0,-0.999049,0,-0.043619,103,20956,20096,3509,1,1,0,1,1),
(3458,0,-0.999049,0,-0.043619,103,25340,20096,3472,1,1,0,1,1),
(3458,0,0.99863,0,0.052336,103,27682,19929,3430,1,1,0,1,1),
(3342,0,-0.737278,0,0.67559,103,16053,21632,4144,1,1,0,1,1),
(3342,0,-0.725375,0,0.688354,103,18264,21632,4144,1,1,0,1,1),
(3342,0,-0.725375,0,0.688354,103,20806,21632,4144,1,1,0,1,1),
(3342,0,-0.725375,0,0.688354,103,23006,21632,4144,1,1,0,1,1),
(3342,0,-0.725375,0,0.688354,103,25205,21632,4144,1,1,0,1,1),
(3342,0,-0.725375,0,0.688354,103,25205,21632,4144,1,1,0,1,1),
(3342,0,-0.725375,0,0.688354,103,27549,21632,4144,1,1,0,1,1),
(1406,0,0,0,1,103,20864,54656,4122,2.5,1,0,1,1),
(3458,0,-0.999049,0,-0.043619,103,23124,20096,3529,1,1,0,1,1),
(3458,0,-0.999048,0,-0.043619,103,16163,20096,3382,1,1,0,1,1),
(3458,0,-0.999657,0,-0.026177,103,18397,20096,3402,1,1,0,1,1),
(3723,0,0.999848,0,-0.017452,103,42839,26949,3837,5,1,0,1,1),
(2762,0,0,0,1,103,52699,38801,534,7.5,1,0,1,1);
--END REPLACE

GO

USE [perpetuumsa]
GO
DECLARE @zoneID INT;
SET @zoneID = 102;

PRINT N'DELETING ALL DECOR ON ZONE: ' + CONVERT(varchar(10), @zoneID);
DELETE FROM decor WHERE zoneid=@zoneID;
INSERT INTO decor (definition, quaternionx, quaterniony, quaternionz, quaternionw, zoneid, x, y, z, scale, changed, fadedistance, category, locked) VALUES
--REPLACE
(3288,0.040722,0.015632,-0.017435,0.998896,102,18561,38333,1542,1,1,0,1,1);
--END REPLACE

GO

USE [perpetuumsa]
GO
DECLARE @zoneID INT;
SET @zoneID = 101;

PRINT N'DELETING ALL DECOR ON ZONE: ' + CONVERT(varchar(10), @zoneID);
DELETE FROM decor WHERE zoneid=@zoneID;
INSERT INTO decor (definition, quaternionx, quaterniony, quaternionz, quaternionw, zoneid, x, y, z, scale, changed, fadedistance, category, locked) VALUES
--REPLACE
(3509,0,0,0,1,101,22400,22912,4242,1,1,0,1,1),
(2760,0,0,0,1,101,8320,24192,6372,1,1,0,1,1),
(2760,0.095846,0,0,0.995396,101,56019,29056,-3823,3,1,0,1,1),
(2753,0,0,-0.156434,0.98769,101,43882,46206,-415,1,1,0,1,1),
(1993,0,0,0,1,101,35712,36480,4310,1,1,0,1,1),
(1992,0,0,0,1,101,38016,34432,5208,1,1,0,1,1),
(1992,0,0,0,1,101,36785,35200,4940,1,1,0,1,1);
--END REPLACE

GO

USE [perpetuumsa]
GO
DECLARE @zoneID INT;
SET @zoneID = 100;

PRINT N'DELETING ALL DECOR ON ZONE: ' + CONVERT(varchar(10), @zoneID);
DELETE FROM decor WHERE zoneid=@zoneID;
INSERT INTO decor (definition, quaternionx, quaterniony, quaternionz, quaternionw, zoneid, x, y, z, scale, changed, fadedistance, category, locked) VALUES
--REPLACE
(3491,0,0,0,1,100,32883,33910,5778,1,1,0,1,1),
(3458,0,-0.997564,0,0.069756,100,44672,35712,3994,1,1,0,1,1),
(3458,0,0.999848,0,0.017452,100,47232,35712,3942,1,1,0,1,1),
(2798,0,0,0,1,100,46922,35495,3992,1,1,0,1,1),
(3464,0,0,0,1,100,42264,37504,5256,1,1,0,1,1),
(3464,0,0,0,1,100,42131,41772,5296,1,1,0,1,1),
(3689,0,0,0,1,100,40320,42112,4998,1,1,0,1,1),
(3696,0,0,0,1,100,32128,41344,5020,1,1,0,1,1),
(3718,0,0,0,1,100,45695,33408,3984,1,1,0,1,1),
(2760,0,0,0,1,100,41088,34029,4998,1,1,0,1,1),
(2826,0,0,0,1,100,42943,20608,5020,1,1,0,1,1),
(3689,0,-0.207912,0,0.978148,100,39421,20096,5020,1,1,0,1,1),
(3393,0,0,0,1,100,43904,24960,5018,1,1,0,1,1),
(3393,0,0,0,1,100,43878,27008,5020,1,1,0,1,1),
(3333,0,0.71325,0,0.700909,100,47232,29312,3712,1,1,0,1,1),
(3333,0,0.707107,0,0.707107,100,47229,25728,3660,1,1,0,1,1),
(3333,0,0.694658,0,0.71934,100,47159,22144,3540,1,1,0,1,1),
(3333,0,0.694659,0,0.719339,100,47133,18816,3496,1,1,0,1,1),
(3333,0,0,0,1,100,45850,17160,3836,1,1,0,1,1),
(3333,0,0,0,1,100,42546,17108,4044,1,1,0,1,1),
(3333,0,0,0,1,100,39040,17121,3870,1,1,0,1,1),
(3333,0,-0.390731,0,0.920505,100,34363,21120,3958,1,1,0,1,1),
(3333,0,-0.358368,0,0.93358,100,29654,25650,3982,1,1,0,1,1),
(3333,0,0.707106,0,-0.707107,100,28496,28145,3944,1,1,0,1,1),
(3333,0,0.700909,0,-0.713251,100,28469,31809,4027,1,1,0,1,1),
(3333,0,0.681998,0,-0.731354,100,28663,35200,3992,1,1,0,1,1),
(3333,0,0.707106,0,-0.707107,100,28699,38528,4035,1,1,0,1,1),
(3333,0,-0.707107,0,0.707107,100,28779,42368,3985,1,1,0,1,1),
(3333,0,0,0,1,100,39552,44928,3966,1,1,0,1,1),
(3333,0,-0.008727,0,0.999962,100,36300,44886,3966,1,1,0,1,1),
(3333,0,0,0,1,100,33278,44879,3966,1,1,0,1,1),
(3333,0,0,0,1,100,30046,44806,4030,1,1,0,1,1),
(3333,0,0,0,1,100,42557,44928,3966,1,1,0,1,1),
(3333,-0.006111,-0.430364,-0.025453,0.902276,100,36413,18358,3966,1,1,0,1,1),
(3333,0,-0.382683,0,0.92388,100,32057,23334,3844,1,1,0,1,1),
(3689,0,0,0,1,100,43904,29056,5018,1,1,0,1,1);
--END REPLACE


PRINT N'DONE SETTING DECOR ON ALL DECORED GAMMAS';
GO

PRINT N'03_artifactspawninfo__2021_08_01.sql';
USE [perpetuumsa]
GO

---------------------------------------------
-- GAMMA ARTIFACT SPAWN INFO
--
-- Date Modified: 2021/08/01
---------------------------------------------


DROP TABLE IF EXISTS #GAMMA_ARTI_SPAWN_INFO;
CREATE TABLE #GAMMA_ARTI_SPAWN_INFO(
	tier INT NULL,
	artifactTypeName VARCHAR(100),
	probWeight FLOAT
);
INSERT INTO #GAMMA_ARTI_SPAWN_INFO(tier, artifactTypeName, probWeight) VALUES
--(0,'salvage_pelistal_level1_gamma',0),
--(0,'observer_pelistal_level1_gamma',0),
--(0,'infestation_pelistal_level1_gamma',0),
--(0,'industrial_pelistal_level1_gamma',0),
(0,'salvage_pelistal_level2_gamma',10),
(0,'science_pelistal_level2_gamma',10),
(0,'observer_pelistal_level2_gamma',10),
(0,'infestation_pelistal_level2_gamma',10),
(0,'industrial_pelistal_level2_gamma',10),
(0,'salvage_pelistal_level3_gamma',75),
(0,'science_pelistal_level3_gamma',75),
(0,'observer_pelistal_level3_gamma',75),
(0,'infestation_pelistal_level3_gamma',75),
(0,'industrial_pelistal_level3_gamma',75),
--(0,'science_nuimqol_level1_gamma',0),
--(0,'salvage_nuimqol_level1_gamma',0),
--(0,'observer_nuimqol_level1_gamma',0),
--(0,'infestation_nuimqol_level1_gamma',0),
--(0,'industrial_nuimqol_level1_gamma',0),
(0,'salvage_nuimqol_level2_gamma',10),
(0,'science_nuimqol_level2_gamma',10),
(0,'observer_nuimqol_level2_gamma',10),
(0,'infestation_nuimqol_level2_gamma',10),
(0,'industrial_nuimqol_level2_gamma',10),
(0,'salvage_nuimqol_level3_gamma',75),
(0,'science_nuimqol_level3_gamma',75),
(0,'observer_nuimqol_level3_gamma',75),
(0,'infestation_nuimqol_level3_gamma',75),
(0,'industrial_nuimqol_level3_gamma',75),
--(0,'salvage_thelodica_level1_gamma',0),
--(0,'science_thelodica_level1_gamma',0),
--(0,'observer_thelodica_level1_gamma',0),
--(0,'infestation_thelodica_level1_gamma',0),
--(0,'industrial_thelodica_level1_gamma',0),
(0,'salvage_thelodica_level2_gamma',10),
(0,'infestation_thelodica_level2_gamma',10),
(0,'industrial_thelodica_level2_gamma',10),
(0,'salvage_thelodica_level3_gamma',75),
(0,'science_thelodica_level3_gamma',75),
(0,'observer_thelodica_level3_gamma',75),
(0,'infestation_thelodica_level3_gamma',75),
(0,'industrial_thelodica_level3_gamma',75),

--(1,'salvage_pelistal_level1_gamma',0),
--(1,'observer_pelistal_level1_gamma',0),
--(1,'infestation_pelistal_level1_gamma',0),
--(1,'industrial_pelistal_level1_gamma',0),
(1,'salvage_pelistal_level2_gamma',25),
(1,'science_pelistal_level2_gamma',25),
(1,'observer_pelistal_level2_gamma',25),
(1,'infestation_pelistal_level2_gamma',25),
(1,'industrial_pelistal_level2_gamma',25),
(1,'salvage_pelistal_level3_gamma',50),
(1,'science_pelistal_level3_gamma',50),
(1,'observer_pelistal_level3_gamma',50),
(1,'infestation_pelistal_level3_gamma',50),
(1,'industrial_pelistal_level3_gamma',50),
--(1,'science_nuimqol_level1_gamma',0),
--(1,'salvage_nuimqol_level1_gamma',0),
--(1,'observer_nuimqol_level1_gamma',0),
--(1,'infestation_nuimqol_level1_gamma',0),
--(1,'industrial_nuimqol_level1_gamma',0),
(1,'salvage_nuimqol_level2_gamma',25),
(1,'science_nuimqol_level2_gamma',25),
(1,'observer_nuimqol_level2_gamma',25),
(1,'infestation_nuimqol_level2_gamma',25),
(1,'industrial_nuimqol_level2_gamma',25),
(1,'salvage_nuimqol_level3_gamma',50),
(1,'science_nuimqol_level3_gamma',50),
(1,'observer_nuimqol_level3_gamma',50),
(1,'infestation_nuimqol_level3_gamma',50),
(1,'industrial_nuimqol_level3_gamma',50),
--(1,'salvage_thelodica_level1_gamma',0),
--(1,'science_thelodica_level1_gamma',0),
--(1,'observer_thelodica_level1_gamma',0),
--(1,'infestation_thelodica_level1_gamma',0),
--(1,'industrial_thelodica_level1_gamma',0),
(1,'salvage_thelodica_level2_gamma',25),
(1,'infestation_thelodica_level2_gamma',25),
(1,'industrial_thelodica_level2_gamma',25),
(1,'salvage_thelodica_level3_gamma',50),
(1,'science_thelodica_level3_gamma',50),
(1,'observer_thelodica_level3_gamma',50),
(1,'infestation_thelodica_level3_gamma',50),
(1,'industrial_thelodica_level3_gamma',50),

(2,'salvage_pelistal_level1_gamma',5),
(2,'observer_pelistal_level1_gamma',5),
(2,'infestation_pelistal_level1_gamma',5),
(2,'industrial_pelistal_level1_gamma',5),
(2,'salvage_pelistal_level2_gamma',20),
(2,'science_pelistal_level2_gamma',20),
(2,'observer_pelistal_level2_gamma',20),
(2,'infestation_pelistal_level2_gamma',20),
(2,'industrial_pelistal_level2_gamma',20),
(2,'salvage_pelistal_level3_gamma',50),
(2,'science_pelistal_level3_gamma',50),
(2,'observer_pelistal_level3_gamma',50),
(2,'infestation_pelistal_level3_gamma',50),
(2,'industrial_pelistal_level3_gamma',50),
(2,'science_nuimqol_level1_gamma',5),
(2,'salvage_nuimqol_level1_gamma',5),
(2,'observer_nuimqol_level1_gamma',5),
(2,'infestation_nuimqol_level1_gamma',5),
(2,'industrial_nuimqol_level1_gamma',5),
(2,'salvage_nuimqol_level2_gamma',20),
(2,'science_nuimqol_level2_gamma',20),
(2,'observer_nuimqol_level2_gamma',20),
(2,'infestation_nuimqol_level2_gamma',20),
(2,'industrial_nuimqol_level2_gamma',20),
(2,'salvage_nuimqol_level3_gamma',50),
(2,'science_nuimqol_level3_gamma',50),
(2,'observer_nuimqol_level3_gamma',50),
(2,'infestation_nuimqol_level3_gamma',50),
(2,'industrial_nuimqol_level3_gamma',50),
(2,'salvage_thelodica_level1_gamma',5),
(2,'science_thelodica_level1_gamma',5),
(2,'observer_thelodica_level1_gamma',5),
(2,'infestation_thelodica_level1_gamma',5),
(2,'industrial_thelodica_level1_gamma',5),
(2,'salvage_thelodica_level2_gamma',20),
(2,'infestation_thelodica_level2_gamma',20),
(2,'industrial_thelodica_level2_gamma',20),
(2,'salvage_thelodica_level3_gamma',50),
(2,'science_thelodica_level3_gamma',50),
(2,'observer_thelodica_level3_gamma',50),
(2,'infestation_thelodica_level3_gamma',50),
(2,'industrial_thelodica_level3_gamma',50),

(3,'salvage_pelistal_level1_gamma',10),
(3,'observer_pelistal_level1_gamma',10),
(3,'infestation_pelistal_level1_gamma',10),
(3,'industrial_pelistal_level1_gamma',10),
(3,'salvage_pelistal_level2_gamma',15),
(3,'science_pelistal_level2_gamma',15),
(3,'observer_pelistal_level2_gamma',15),
(3,'infestation_pelistal_level2_gamma',15),
(3,'industrial_pelistal_level2_gamma',15),
(3,'salvage_pelistal_level3_gamma',20),
(3,'science_pelistal_level3_gamma',20),
(3,'observer_pelistal_level3_gamma',20),
(3,'infestation_pelistal_level3_gamma',20),
(3,'industrial_pelistal_level3_gamma',20),
(3,'science_nuimqol_level1_gamma',10),
(3,'salvage_nuimqol_level1_gamma',10),
(3,'observer_nuimqol_level1_gamma',10),
(3,'infestation_nuimqol_level1_gamma',10),
(3,'industrial_nuimqol_level1_gamma',10),
(3,'salvage_nuimqol_level2_gamma',15),
(3,'science_nuimqol_level2_gamma',15),
(3,'observer_nuimqol_level2_gamma',15),
(3,'infestation_nuimqol_level2_gamma',15),
(3,'industrial_nuimqol_level2_gamma',15),
(3,'salvage_nuimqol_level3_gamma',20),
(3,'science_nuimqol_level3_gamma',20),
(3,'observer_nuimqol_level3_gamma',20),
(3,'infestation_nuimqol_level3_gamma',20),
(3,'industrial_nuimqol_level3_gamma',20),
(3,'salvage_thelodica_level1_gamma',10),
(3,'science_thelodica_level1_gamma',10),
(3,'observer_thelodica_level1_gamma',10),
(3,'infestation_thelodica_level1_gamma',10),
(3,'industrial_thelodica_level1_gamma',10),
(3,'salvage_thelodica_level2_gamma',15),
(3,'infestation_thelodica_level2_gamma',15),
(3,'industrial_thelodica_level2_gamma',15),
(3,'salvage_thelodica_level3_gamma',20),
(3,'science_thelodica_level3_gamma',20),
(3,'observer_thelodica_level3_gamma',20),
(3,'infestation_thelodica_level3_gamma',20),
(3,'industrial_thelodica_level3_gamma',20);

SELECT * FROM artifactspawninfo WHERE zoneid > 99 AND zoneid < 141;
DELETE artifactspawninfo WHERE zoneid > 99 AND zoneid < 141;

INSERT INTO artifactspawninfo(artifacttype, zoneid, rate)
SELECT 
	(SELECT TOP 1 id FROM artifacttypes WHERE i.artifactTypeName=name),
	z.id,
	i.probWeight
FROM #GAMMA_ARTI_SPAWN_INFO i
JOIN zones z ON z.pbsTechLimit=i.tier AND z.id > 105
ORDER BY z.pbsTechLimit, z.id;


DROP TABLE IF EXISTS #GAMMA_ARTI_SPAWN_INFO;
GO

PRINT N'04_teleports__2021_08_07.sql';
USE [perpetuumsa]
GO

-----------------------------------------------
-- Gamma teleport network
-- Phase 1: setup all but disable beta/gamma connections
-- Date modified: 2021/10/20
-----------------------------------------------

PRINT N'BUILDING TELEPORT NETWORK';

DECLARE @eidStart AS BIGINT = 5600;

DROP TABLE IF EXISTS #TELEDEF_BYRACE;
CREATE TABLE #TELEDEF_BYRACE(
	def int,
	raceId int
);
INSERT INTO #TELEDEF_BYRACE (def, raceId) VALUES
(1394,1),
(1395,2),
(667,3);

DROP TABLE IF EXISTS #DISABLED_CONNECTIONS;
CREATE TABLE #DISABLED_CONNECTIONS(
	sourceColName VARCHAR(100),
	targetColName VARCHAR(100)
);
INSERT INTO #DISABLED_CONNECTIONS (sourceColName, targetColName) VALUES
('teleport_column_tmpvp_4','tpc_z100'),
('tpc_z100','teleport_column_tmpvp_4'),
('teleport_column_initia_sw','tpc_z101'),
('tpc_z101','teleport_column_initia_sw'),
('teleport_column_asipvp_5','tpc_z102'),
('tpc_z102','teleport_column_asipvp_5'),
('teleport_column_asi2_vougar','tpc_z103'),
('tpc_z103','teleport_column_asi2_vougar'),
('teleport_column_icspvp_2','tpc_z104'),
('tpc_z104','teleport_column_icspvp_2'),
('teleport_column_ics2_vsehovski','tpc_z105'),
('tpc_z105','teleport_column_ics2_vsehovski');

DROP TABLE IF EXISTS #CONNECTIONS;
CREATE TABLE #CONNECTIONS(
	sourceColName VARCHAR(100),
	targetColName VARCHAR(100)
);
INSERT INTO #CONNECTIONS (sourceColName, targetColName) VALUES
('teleport_column_tmpvp_4','tpc_z100'),
('tpc_z100','teleport_column_tmpvp_4'),
('tpc_z100','tpc_z130_SW'),
('tpc_z100','tpc_z112_NE'),
('tpc_z100','tpc_z113_S'),

('teleport_column_initia_sw','tpc_z101'),
('tpc_z101','teleport_column_initia_sw'),
('tpc_z101','tpc_z113_N'),
('tpc_z101','tpc_z115_E'),

('teleport_column_asipvp_5','tpc_z102'),
('tpc_z102','teleport_column_asipvp_5'),
('tpc_z102','tpc_z120_SE'),
('tpc_z102','tpc_z115_W'),
('tpc_z102','tpc_z116_N'),

('teleport_column_asi2_vougar','tpc_z103'),
('tpc_z103','teleport_column_asi2_vougar'),
('tpc_z103','tpc_z116_S'),
('tpc_z103','tpc_z117_E'),
('tpc_z103','tpc_z109_N'),

('teleport_column_icspvp_2','tpc_z104'),
('tpc_z104','teleport_column_icspvp_2'),
('tpc_z104','tpc_z137_N'),
('tpc_z104','tpc_z109_S'),
('tpc_z104','tpc_z111_W'),

('teleport_column_ics2_vsehovski','tpc_z105'),
('tpc_z105','teleport_column_ics2_vsehovski'),
('tpc_z105','tpc_z132_SW'),
('tpc_z105','tpc_z112_SE'),
('tpc_z105','tpc_z111_E'),

('tpc_z110_W','tpc_z109_E'),
('tpc_z110_E','tpc_z111_N'),


('tpc_z119_S','tpc_z117_NW'),
('tpc_z119_N','tpc_z120_SW'),
('tpc_z131_NW','tpc_z130_SE'),
('tpc_z131_E','tpc_z132_NW'),

('tpc_z106_NE','tpc_z112_NW'),
('tpc_z106_SW','tpc_z107_E'),

('tpc_z107_E','tpc_z106_SW'),

('tpc_z107_W','tpc_z108_E'),

('tpc_z108_E','tpc_z107_W'),

('tpc_z108_SW','tpc_z116_E'),
('tpc_z109_N','tpc_z103'),
('tpc_z109_W','tpc_z139_N'),
('tpc_z109_S','tpc_z104'),
('tpc_z109_E','tpc_z110_W'),
('tpc_z111_N','tpc_z110_E'),
('tpc_z111_E','tpc_z105'),
('tpc_z111_S','tpc_z135_N'),
('tpc_z111_W','tpc_z104'),
('tpc_z112_NW','tpc_z106_NE'),
('tpc_z112_NE','tpc_z100'),
('tpc_z112_SE','tpc_z105'),



('tpc_z113_N','tpc_z101'),

('tpc_z113_S','tpc_z100'),
('tpc_z113_E','tpc_z127_SW'),

('tpc_z114_S','tpc_z113_W'),
('tpc_z114_N','tpc_z115_S'),

('tpc_z115_N','tpc_z123_SW'),

('tpc_z115_S','tpc_z114_N'),


('tpc_z116_S','tpc_z103'),
('tpc_z116_E','tpc_z108_SW'),
('tpc_z117_NW','tpc_z119_S'),
('tpc_z117_NE','tpc_z103'),

('tpc_z117_SW','tpc_z118_N'),
('tpc_z118_N','tpc_z117_SW'),

('tpc_z118_S','tpc_z140_W'),

('tpc_z120_NW','tpc_z121_SW'),

('tpc_z120_SE','tpc_z102'),
('tpc_z120_SW','tpc_z119_N'),

('tpc_z121_NE','tpc_z122_NW'),

('tpc_z121_SW','tpc_z120_NW'),
('tpc_z122_NW','tpc_z121_NE'),
('tpc_z122_SE','tpc_z123_NW'),

('tpc_z123_NW','tpc_z122_SE'),
('tpc_z123_NE','tpc_z124_W'),

('tpc_z123_SW','tpc_z115_N'),

('tpc_z124_E','tpc_z125_N'),

('tpc_z124_W','tpc_z123_NE'),
('tpc_z125_N','tpc_z124_E'),
('tpc_z125_E','tpc_z126_N'),

('tpc_z125_W','tpc_z101'),
('tpc_z126_N','tpc_z125_E'),

('tpc_z126_S','tpc_z127_NE'),

('tpc_z127_SW','tpc_z113_E'),
('tpc_z127_SE','tpc_z128_NW'),
('tpc_z127_NE','tpc_z126_S'),
('tpc_z128_NW','tpc_z127_SE'),
('tpc_z128_NE','tpc_z129_W'),

('tpc_z129_W','tpc_z128_NE'),
('tpc_z129_S','tpc_z130_NE'),

('tpc_z130_NE','tpc_z129_S'),
('tpc_z130_SE','tpc_z131_NW'),
('tpc_z130_SW','tpc_z100'),
('tpc_z132_NW','tpc_z131_E'),

('tpc_z132_SE','tpc_z133_NE'),
('tpc_z132_SW','tpc_z105'),

('tpc_z133_NE','tpc_z132_SE'),

('tpc_z133_SW','tpc_z134_E'),

('tpc_z134_W','tpc_z135_E'),

('tpc_z134_E','tpc_z133_SW'),
('tpc_z135_N','tpc_z111_S'),

('tpc_z135_S','tpc_z136_N'),
('tpc_z135_E','tpc_z134_W'),
('tpc_z136_N','tpc_z135_S'),
('tpc_z136_W','tpc_z137_E'),

('tpc_z137_N','tpc_z104'),
('tpc_z137_W','tpc_z138_E'),

('tpc_z137_E','tpc_z136_W'),
('tpc_z138_N','tpc_z139_S'),

('tpc_z138_E','tpc_z137_W'),
('tpc_z139_N','tpc_z109_W'),
('tpc_z139_W','tpc_z140_E'),
('tpc_z139_S','tpc_z138_N'),

('tpc_z140_W','tpc_z118_S'),

('tpc_z140_E','tpc_z139_W');



DROP TABLE IF EXISTS #RAWDATA;
CREATE TABLE #RAWDATA(
	zoneid int,
	raceid int,
	x int,
	y int,
	teleName VARCHAR(100)
);
INSERT INTO #RAWDATA (zoneid, raceid, x, y, teleName) VALUES
(100,1,139, 131,'tpc_z100'),
(101,1,90, 85,'tpc_z101'),
(102,3,73, 148,'tpc_z102'),
(103,3,92,121,'tpc_z103'),
(104,2,128, 81,'tpc_z104'),
(105,2,78, 127,'tpc_z105'),

(110,2,261, 1201,'tpc_z110_W'),
(110,2,1711, 1155,'tpc_z110_E'),
(114,1,1642, 1607,'tpc_z114_S'),
(114,1,463,507,'tpc_z114_N'),
(119,3,580, 1635,'tpc_z119_S'),
(119,3,1428, 481,'tpc_z119_N'),
(131,2,471,456,'tpc_z131_NW'),
(131,2,1779, 1162,'tpc_z131_E'),

(106,2,289, 468,'tpc_z106_NW'),
(106,2,1390, 1829,'tpc_z106_SE'),
(106,2,1695, 348,'tpc_z106_NE'),
(106,2,187, 1536,'tpc_z106_SW'),
(107,3,996,297,'tpc_z107_N'),
(107,3,1761, 1192,'tpc_z107_E'),
(107,3,1013, 1911,'tpc_z107_S'),
(107,3,288, 1190,'tpc_z107_W'),
(108,3,1015, 435,'tpc_z108_N'),
(108,3,1821, 856,'tpc_z108_E'),
(108,3,1764, 1740,'tpc_z108_SE'),
(108,3,603, 1694,'tpc_z108_SW'),
(109,3,975, 333,'tpc_z109_N'),
(109,3,255, 915,'tpc_z109_W'),
(109,3,1109, 1720,'tpc_z109_S'),
(109,3,1718, 801,'tpc_z109_E'),
(111,2,619, 313,'tpc_z111_N'),
(111,2,1878, 897,'tpc_z111_E'),
(111,2,1416, 1849,'tpc_z111_S'),
(111,2,289, 1316,'tpc_z111_W'),
(112,2,386, 235,'tpc_z112_NW'),
(112,2,1577, 199,'tpc_z112_NE'),
(112,2,1364, 1269,'tpc_z112_SE'),
(112,2,602, 1663,'tpc_z112_SW'),
(113,1,1068, 346,'tpc_z113_N'),
(113,1,342, 1482,'tpc_z113_W'),
(113,1,1416, 1802,'tpc_z113_S'),
(113,1,1729, 857,'tpc_z113_E'),
(115,1,929, 265,'tpc_z115_N'),
(115,1,324, 1315,'tpc_z115_W'),
(115,1,1759, 1755,'tpc_z115_S'),
(115,1,1699, 881,'tpc_z115_E'),
(116,3,975, 534,'tpc_z116_N'),
(116,3,156, 1189,'tpc_z116_W'),
(116,3,1405, 1874,'tpc_z116_S'),
(116,3,1897, 1044,'tpc_z116_E'),
(117,3,280, 247,'tpc_z117_NW'),
(117,3,1425, 389,'tpc_z117_NE'),
(117,3,1731, 1348,'tpc_z117_SE'),
(117,3,808, 1456,'tpc_z117_SW'),
(118,3,1245, 272,'tpc_z118_N'),
(118,3,1789, 769,'tpc_z118_E'),
(118,3,837, 1807,'tpc_z118_S'),
(118,3,302, 930,'tpc_z118_W'),
(120,3,460, 270,'tpc_z120_NW'),
(120,3,1531, 321,'tpc_z120_NE'),
(120,3,1547, 1408,'tpc_z120_SE'),
(120,3,254, 1387,'tpc_z120_SW'),
(121,1,428, 305,'tpc_z121_NW'),
(121,1,1624, 401,'tpc_z121_NE'),
(121,1,1566, 1679,'tpc_z121_SE'),
(121,1,436, 1739,'tpc_z121_SW'),
(122,1,369, 622,'tpc_z122_NW'),
(122,1,1648, 1673,'tpc_z122_SE'),
(122,1,1430, 486,'tpc_z122_NE'),
(122,1,535, 1739,'tpc_z122_SW'),
(123,1,265, 446,'tpc_z123_NW'),
(123,1,1570, 352,'tpc_z123_NE'),
(123,1,1431, 1559,'tpc_z123_SE'),
(123,1,381, 1806,'tpc_z123_SW'),
(124,1,829, 325,'tpc_z124_N'),
(124,1,1794, 900,'tpc_z124_E'),
(124,1,1363, 1722,'tpc_z124_S'),
(124,1,285, 1251,'tpc_z124_W'),
(125,1,756, 233,'tpc_z125_N'),
(125,1,1772, 888,'tpc_z125_E'),
(125,1,1151, 1667,'tpc_z125_S'),
(125,1,380, 1277,'tpc_z125_W'),
(126,1,880, 262,'tpc_z126_N'),
(126,1,1725, 884,'tpc_z126_E'),
(126,1,1226, 1583,'tpc_z126_S'),
(126,1,385, 1171,'tpc_z126_W'),
(127,1,916, 382,'tpc_z127_NW'),
(127,1,348, 1715,'tpc_z127_SW'),
(127,1,1542, 1478,'tpc_z127_SE'),
(127,1,1856, 584,'tpc_z127_NE'),
(128,2,375, 240,'tpc_z128_NW'),
(128,2,1837, 515,'tpc_z128_NE'),
(128,2,1669, 1410,'tpc_z128_SE'),
(128,2,359, 1518,'tpc_z128_SW'),
(129,2,1020, 233,'tpc_z129_N'),
(129,2,1727, 777,'tpc_z129_E'),
(129,2,234, 1271,'tpc_z129_W'),
(129,2,1508, 1737,'tpc_z129_S'),
(130,2,530, 387,'tpc_z130_NW'),
(130,2,1675, 372,'tpc_z130_NE'),
(130,2,1715, 1534,'tpc_z130_SE'),
(130,2,600, 1448,'tpc_z130_SW'),
(132,2,683, 245,'tpc_z132_NW'),
(132,2,1767, 148,'tpc_z132_NE'),
(132,2,1768, 1543,'tpc_z132_SE'),
(132,2,229, 1281,'tpc_z132_SW'),
(133,2,340, 546,'tpc_z133_NW'),
(133,2,1780, 856,'tpc_z133_NE'),
(133,2,1708, 1664,'tpc_z133_SE'),
(133,2,284, 1725,'tpc_z133_SW'),
(134,2,992, 199,'tpc_z134_N'),
(134,2,283, 978,'tpc_z134_W'),
(134,2,651, 1597,'tpc_z134_S'),
(134,2,1809, 835,'tpc_z134_E'),
(135,2,528, 416,'tpc_z135_N'),
(135,2,261, 1217,'tpc_z135_W'),
(135,2,1159, 1780,'tpc_z135_S'),
(135,2,1833, 1239,'tpc_z135_E'),
(136,2,866, 448,'tpc_z136_N'),
(136,2,333, 982,'tpc_z136_W'),
(136,2,942, 1635,'tpc_z136_S'),
(136,2,1770, 952,'tpc_z136_E'),
(137,3,984, 456,'tpc_z137_N'),
(137,3,187, 1057,'tpc_z137_W'),
(137,3,1126, 1770,'tpc_z137_S'),
(137,3,1609, 991,'tpc_z137_E'),
(138,3,1176, 309,'tpc_z138_N'),
(138,3,320, 1036,'tpc_z138_W'),
(138,3,652, 1745,'tpc_z138_S'),
(138,3,1604, 978,'tpc_z138_E'),
(139,3,855, 273,'tpc_z139_N'),
(139,3,336, 1231,'tpc_z139_W'),
(139,3,1168, 1720,'tpc_z139_S'),
(139,3,1863, 916,'tpc_z139_E'),
(140,3,411, 314,'tpc_z140_W'),
(140,3,1758, 438,'tpc_z140_N'),
(140,3,1484, 1371,'tpc_z140_E'),
(140,3,548, 1617,'tpc_z140_S');

DROP TABLE IF EXISTS #TELES;
CREATE TABLE #TELES(
	zoneid int,
	raceid int,
	x int,
	y int,
	eid bigint,
	def int,
	ename NVARCHAR(128),
	synckey varchar(50),
);
INSERT INTO #TELES (zoneid, raceid, x, y, eid, def, ename, synckey)
SELECT
	d.zoneid,
	d.raceid,
	d.x,
	d.y,
	@eidStart+ROW_NUMBER() OVER(order by d.zoneid),
	(SELECT TOP 1 r.def FROM #TELEDEF_BYRACE r WHERE r.raceid=d.raceid),
	d.teleName,
	d.teleName
FROM #RAWDATA d order by d.zoneid;


PRINT N'DELETE AND REINSERT teleportdescriptions,  entities, zoneentities';
--select * from entities where eid in (select eid from #TELES)
--select * from zoneentities where eid in (select eid from #TELES)
--SELECT * FROM teleportdescriptions WHERE sourcecolumn in (select eid from #TELES) OR targetcolumn in (select eid from #TELES);
DELETE FROM teleportdescriptions WHERE sourcecolumn in (select eid from #TELES) OR targetcolumn in (select eid from #TELES);
DELETE from entities where eid in (select eid from #TELES);
DELETE from zoneentities where eid in (select eid from #TELES);

PRINT N'INSERT entities';
INSERT INTO entities (eid, definition, owner, parent, health, ename, quantity, repackaged, dynprop)
SELECT eid, def, NULL, NULL, 100, ename, 1, 0, '#enabled=i1' FROM #TELES;

PRINT N'INSERT zoneentities';
INSERT INTO zoneentities (zoneID, eid, definition, owner, ename, x, y, z, orientation, enabled, note, runtime, synckey)
SELECT zoneid, eid, NULL, NULL, ename, x+0.5, y+0.5, 0, 0, 1, 'tpcol', 0, synckey FROM #TELES;


PRINT N'INSERT *EXISTING* TELEPORT ENTITIES INTO #TELES (AFTER DELETE/INSERT CALLS USING #TELES)';
INSERT INTO #TELES (zoneid, raceid, x, y, eid, def, ename, synckey)
SELECT zoneID, 
	(SELECT TOP 1 r.raceId FROM #TELEDEF_BYRACE r WHERE r.def=e.definition),
	z.x, z.y, z.eid, e.definition, z.ename, z.synckey
FROM zoneentities z 
INNER JOIN entities e ON e.ename=z.ename
WHERE z.ename in (SELECT distinct sourceColName FROM #CONNECTIONS) AND z.ename NOT IN (SELECT ename FROM #TELES);

PRINT N'INSERT teleportdescriptions';
PRINT N'CONNECTING A->B';
INSERT INTO teleportdescriptions
	(description, sourcecolumn, targetcolumn, sourcezone, sourcerange, targetzone, targetrange, usetimeout, listable, active, type, sourcecolumnname, targetcolumnname)
SELECT
	s.ename+'_to_'+t.ename,
	s.eid, t.eid, s.zoneid, 7, t.zoneid, 7, 0, 1, 1, 2, s.ename, t.ename 
FROM #CONNECTIONS c
INNER JOIN #TELES s on s.ename = c.sourceColName
INNER JOIN #TELES t on t.ename = c.targetColName;


PRINT N'Bidirectional misses: ';
SELECT
	s.ename+'_to_'+t.ename,
	s.eid, t.eid, s.zoneid, 7, t.zoneid, 7, 0, 1, 1, 2, s.ename, t.ename 
FROM #CONNECTIONS c
INNER JOIN #TELES s on s.ename = c.targetColName
INNER JOIN #TELES t on t.ename = c.sourceColName
WHERE s.ename+'_to_'+t.ename NOT IN (SELECT description from teleportdescriptions)
PRINT N'CONNECTING B->A if missing from config';
--Insert the other direction by joining the opposite names
INSERT INTO teleportdescriptions
	(description, sourcecolumn, targetcolumn, sourcezone, sourcerange, targetzone, targetrange, usetimeout, listable, active, type, sourcecolumnname, targetcolumnname)
SELECT
	s.ename+'_to_'+t.ename,
	s.eid, t.eid, s.zoneid, 7, t.zoneid, 7, 0, 1, 1, 2, s.ename, t.ename 
FROM #CONNECTIONS c
INNER JOIN #TELES s on s.ename = c.targetColName
INNER JOIN #TELES t on t.ename = c.sourceColName
WHERE s.ename+'_to_'+t.ename NOT IN (SELECT description from teleportdescriptions)




PRINT N'DISABLING KEY BETA<->GAMMA TELEPORTS FOR PHASE 1';
SELECT * FROM teleportdescriptions
WHERE sourcecolumn IN (SELECT eid FROM zoneentities WHERE ename IN (SELECT sourceColName FROM #DISABLED_CONNECTIONS)) 
AND targetcolumn IN (SELECT eid FROM zoneentities WHERE ename IN (SELECT targetColName FROM #DISABLED_CONNECTIONS)) 

UPDATE teleportdescriptions SET
	active=0
WHERE sourcecolumn IN (SELECT eid FROM zoneentities WHERE ename IN (SELECT sourceColName FROM #DISABLED_CONNECTIONS)) 
AND targetcolumn IN (SELECT eid FROM zoneentities WHERE ename IN (SELECT targetColName FROM #DISABLED_CONNECTIONS)) 

DROP TABLE IF EXISTS #RAWDATA;
DROP TABLE IF EXISTS #TELES;
DROP TABLE IF EXISTS #TELEDEF_BYRACE;
DROP TABLE IF EXISTS #CONNECTIONS;
DROP TABLE IF EXISTS #DISABLED_CONNECTIONS;
PRINT N'TELEPORT NETWORK BUILT';
GO



PRINT N'07_npcreinforcements_gamma_t0_flux__2021_09_01.sql';
USE [perpetuumsa]
GO

-------------------------------------
-- Npc reinforcements for Flux ore
-- on new gamma zones
-- Date modified: 2021/09/01
-------------------------------------


DECLARE @fluxOre INT;
SET @fluxOre = (SELECT TOP 1 idx FROM minerals WHERE name = 'fluxore');

DECLARE @reinforceType INT;
SET @reinforceType = (SELECT TOP 1 id FROM npcreinforcementtypes WHERE name='minerals');

SELECT * FROM npcreinforcements WHERE reinforcementType=@reinforceType AND targetId=@fluxOre AND
zoneId IN (110, 114, 119, 131);

DELETE FROM npcreinforcements WHERE reinforcementType=@reinforceType AND targetId=@fluxOre AND
zoneId IN (110, 114, 119, 131);

INSERT INTO npcreinforcements (reinforcementType, targetId, threshold, presenceId, zoneId) VALUES
(@reinforceType, @fluxOre, 0.1, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_1_pelistal'), 110),
(@reinforceType, @fluxOre, 0.2, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_2_nuimqol'), 110),
(@reinforceType, @fluxOre, 0.3, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_3_thelodica'), 110),
(@reinforceType, @fluxOre, 0.4, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_4_pelistal'), 110),
(@reinforceType, @fluxOre, 0.5, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_5_nuimqol'), 110),
(@reinforceType, @fluxOre, 0.6, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_6_thelodica'), 110),
(@reinforceType, @fluxOre, 0.7, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_7_pelistal'), 110),
(@reinforceType, @fluxOre, 0.8, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_8_nuimqol'), 110),
(@reinforceType, @fluxOre, 0.9, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_9_thelodica'), 110),

(@reinforceType, @fluxOre, 0.1, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_1_pelistal'), 114),
(@reinforceType, @fluxOre, 0.2, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_2_pelistal'), 114),
(@reinforceType, @fluxOre, 0.3, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_3_pelistal'), 114),
(@reinforceType, @fluxOre, 0.4, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_4_pelistal'), 114),
(@reinforceType, @fluxOre, 0.5, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_5_pelistal'), 114),
(@reinforceType, @fluxOre, 0.6, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_6_pelistal'), 114),
(@reinforceType, @fluxOre, 0.7, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_7_pelistal'), 114),
(@reinforceType, @fluxOre, 0.8, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_8_pelistal'), 114),
(@reinforceType, @fluxOre, 0.9, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_9_pelistal'), 114),

(@reinforceType, @fluxOre, 0.1, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_1_thelodica'), 119),
(@reinforceType, @fluxOre, 0.2, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_2_thelodica'), 119),
(@reinforceType, @fluxOre, 0.3, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_3_thelodica'), 119),
(@reinforceType, @fluxOre, 0.4, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_4_thelodica'), 119),
(@reinforceType, @fluxOre, 0.5, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_5_thelodica'), 119),
(@reinforceType, @fluxOre, 0.6, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_6_thelodica'), 119),
(@reinforceType, @fluxOre, 0.7, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_7_thelodica'), 119),
(@reinforceType, @fluxOre, 0.8, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_8_thelodica'), 119),
(@reinforceType, @fluxOre, 0.9, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_9_thelodica'), 119),

(@reinforceType, @fluxOre, 0.1, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_1_nuimqol'), 131),
(@reinforceType, @fluxOre, 0.2, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_2_nuimqol'), 131),
(@reinforceType, @fluxOre, 0.3, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_3_nuimqol'), 131),
(@reinforceType, @fluxOre, 0.4, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_4_nuimqol'), 131),
(@reinforceType, @fluxOre, 0.5, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_5_nuimqol'), 131),
(@reinforceType, @fluxOre, 0.6, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_6_nuimqol'), 131),
(@reinforceType, @fluxOre, 0.7, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_7_nuimqol'), 131),
(@reinforceType, @fluxOre, 0.8, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_8_nuimqol'), 131),
(@reinforceType, @fluxOre, 0.9, (SELECT TOP 1 id FROM npcpresence WHERE NAME='flux_ore_npc_wave_9_nuimqol'), 131);



GO


PRINT N'09_zoneeffects__2021_09_03.sql';
USE [perpetuumsa]
GO

----------------------------------------
-- Zone effects for Tiered Gamma islands
--
-- Date modified: 9/3/2021
-----------------------------------------

DROP TABLE IF EXISTS #FIELDS;
CREATE TABLE #FIELDS 
(
	fieldID INT,
	fieldName VARCHAR(100)
);
INSERT INTO #FIELDS (fieldID, fieldName) VALUES
(664, 'pbs_tech_limit'),
(665, 'pvp_no_teleport');

DROP TABLE IF EXISTS #EFFS;
CREATE TABLE #EFFS 
(
	effId INT,
	effName VARCHAR(100)
);

DROP TABLE IF EXISTS #EFFECTMODS;
CREATE TABLE #EFFECTMODS 
(
	effId INT,
	fieldName VARCHAR(100),
	fieldValue FLOAT
);

DECLARE @effectCatName AS VARCHAR(100) = 'effcat_zone_effects';

DECLARE @T0_EFFECT_NAME  AS VARCHAR(100) = 'effect_gamma_t0';
DECLARE @T1_EFFECT_NAME  AS VARCHAR(100) = 'effect_gamma_t1';
DECLARE @T2_EFFECT_NAME  AS VARCHAR(100) = 'effect_gamma_t2';
DECLARE @T3_EFFECT_NAME  AS VARCHAR(100) = 'effect_gamma_t3';
DECLARE @TC_EFFECT_NAME  AS VARCHAR(100) = 'effect_gamma_tc';

DECLARE @T0_EFFECT_ID AS INT = 116;
DECLARE @T1_EFFECT_ID AS INT = 117;
DECLARE @T2_EFFECT_ID AS INT = 118;
DECLARE @T3_EFFECT_ID AS INT = 119;
DECLARE @TC_EFFECT_ID AS INT = 120;

DECLARE @catFlag AS BIGINT = (SELECT POWER(CAST(2 as bigint), CAST(flag as bigint)) FROM effectcategories WHERE name='effcat_zone_effects');

DECLARE @effCatPower AS BIGINT = (SELECT TOP 1 CAST(flag as bigint) FROM effectcategories WHERE name='effcat_zone_effects');;

INSERT INTO #EFFECTMODS (effId, fieldName, fieldValue) VALUES
(@T0_EFFECT_ID, 'effect_mining_amount_modifier', 1.75),
(@T0_EFFECT_ID, 'effect_harvesting_amount_modifier', 1.75),
(@T0_EFFECT_ID, 'pbs_tech_limit', 0),

(@T1_EFFECT_ID, 'effect_mining_amount_modifier', 1.3),
(@T1_EFFECT_ID, 'effect_harvesting_amount_modifier', 1.3),
(@T1_EFFECT_ID, 'pbs_tech_limit', 1),

(@T2_EFFECT_ID, 'effect_mining_amount_modifier', 1.3),
(@T2_EFFECT_ID, 'effect_harvesting_amount_modifier', 1.3),
(@T2_EFFECT_ID, 'pbs_tech_limit', 2),

(@T3_EFFECT_ID, 'effect_mining_amount_modifier', 1.3),
(@T3_EFFECT_ID, 'effect_harvesting_amount_modifier', 1.3),
(@T3_EFFECT_ID, 'pbs_tech_limit', 3),

(@TC_EFFECT_ID, 'pvp_no_teleport', 1);

INSERT INTO #EFFS (effId, effName) VALUES
(@TC_EFFECT_ID, @TC_EFFECT_NAME),
(@T0_EFFECT_ID, @T0_EFFECT_NAME),
(@T1_EFFECT_ID, @T1_EFFECT_NAME),
(@T2_EFFECT_ID, @T2_EFFECT_NAME),
(@T3_EFFECT_ID, @T3_EFFECT_NAME);

DELETE FROM effectdefaultmodifiers WHERE effectid IN (SELECT effId FROM #EFFS);
DELETE FROM effects WHERE id IN (SELECT effId FROM #EFFS);
DELETE FROM aggregatefields where id IN (SELECT fieldId FROM #FIELDS);

SET IDENTITY_INSERT aggregatefields ON;
INSERT INTO aggregatefields (id, name, formula, measurementunit, measurementmultiplier, measurementoffset, category, digits, moreisbetter, usedinconfig, note)
SELECT fieldID, fieldName, 1, fieldName+'_unit', 1, 0, 6, 0, 0, 0, 'Special Gamma zone effect fields'
FROM #FIELDS;
SET IDENTITY_INSERT aggregatefields OFF;

SET IDENTITY_INSERT effects ON;

INSERT INTO effects (id, effectcategory, duration, name, description, note, isaura, auraradius, ispositive, display, saveable)
SELECT effId, @catFlag, 0, effName, effName+'_desc', 'gamma zone effects', 1, 0, 1, 1, 0
FROM #EFFS;

SET IDENTITY_INSERT effects OFF;

INSERT INTO effectdefaultmodifiers (effectid, field, value)
SELECT effId, (SELECT TOP 1 id FROM aggregatefields WHERE name=fieldName), fieldValue
FROM #EFFECTMODS;

--SELECT * FROM zoneeffects WHERE zoneid IN (SELECT id FROM zones WHERE name LIKE 'zone_gamma_%' AND id > 99);
DELETE FROM zoneeffects WHERE zoneid IN (SELECT id FROM zones WHERE name LIKE 'zone_gamma_%' AND id > 99);

INSERT INTO zoneeffects (zoneid, effectid)
SELECT id, @TC_EFFECT_ID FROM zones
WHERE pbsTechLimit=0 AND id <= 105 AND name LIKE 'zone_gamma_tc_%' AND id > 99;

INSERT INTO zoneeffects (zoneid, effectid)
SELECT id, @T0_EFFECT_ID FROM zones
WHERE pbsTechLimit=0 AND id > 105 AND name LIKE 'zone_gamma_%';

INSERT INTO zoneeffects (zoneid, effectid)
SELECT id, @T1_EFFECT_ID FROM zones
WHERE pbsTechLimit=1 AND id > 105 AND name LIKE 'zone_gamma_%';

INSERT INTO zoneeffects (zoneid, effectid)
SELECT id, @T2_EFFECT_ID FROM zones
WHERE pbsTechLimit=2 AND id > 105 AND name LIKE 'zone_gamma_%';

INSERT INTO zoneeffects (zoneid, effectid)
SELECT id, @T3_EFFECT_ID FROM zones
WHERE pbsTechLimit=3 AND id > 105 AND name LIKE 'zone_gamma_%';

DROP TABLE IF EXISTS #EFFECTMODS;
DROP TABLE IF EXISTS #EFFS;
DROP TABLE IF EXISTS #FIELDS;
GO


USE [perpetuumsa]
GO
PRINT N'14_relics__2021_10_09.sql';
USE [perpetuumsa]
GO
---------------------------------
-- GAMMA RELICS
-- Contributors: Ghroom
-- Date Modified: 2021/10/20
---------------------------------
PRINT N'Configure and insert gamma relics';
DROP TABLE IF EXISTS #TMPRELICTYPE;
CREATE TABLE #TMPRELICTYPE(
	name varchar(128) NOT NULL,
	raceid int NULL,
	level int NULL,
	ep int NULL
);
INSERT INTO #TMPRELICTYPE (name,raceid,level,ep) VALUES
('relic_level4_neutral_gamma',0,4,130),
('relic_level4_indy_gamma',4,4,130),
('relic_level4_numiqol_gamma',2,4,130),
('relic_level4_thelodica_gamma',3,4,130),
('relic_level4_pelistal_gamma',1,4,130);

--SELECT * FROM relictypes WHERE name IN (SELECT DISTINCT name FROM #TMPRELICTYPE);
DELETE FROM relictypes WHERE name IN (SELECT DISTINCT name FROM #TMPRELICTYPE);

INSERT INTO relictypes (name, raceid, level, ep)
SELECT name, raceid, level, ep FROM #TMPRELICTYPE;

INSERT INTO dbo.relictypes (name,raceid,level,ep)
SELECT name,raceid,level,ep
FROM #TMPRELICTYPE;

DROP TABLE IF EXISTS #TMPRELICTYPE;
GO

USE [perpetuumsa]
GO

DROP TABLE IF EXISTS #ZONES_BY_TIER;
CREATE TABLE #ZONES_BY_TIER(
	zoneid int,
	tier int
);
INSERT INTO #ZONES_BY_TIER (zoneid, tier)
SELECT id, pbsTechLimit FROM zones WHERE pbsTechLimit IS NOT NULL AND id>99;

--Tc's flag with -1 for case statement
UPDATE #ZONES_BY_TIER SET
	tier = -1
WHERE zoneid < 106 AND zoneid > 99;


DROP TABLE IF EXISTS #TMPRELICSPAWNINFO;
CREATE TABLE #TMPRELICSPAWNINFO(	
	tiername varchar(100),
	relictypename varchar(100),
	relictypeid int NULL,
	tier int NULL,
	rate int NOT NULL,
	x int NULL,
	y int NULL
);

INSERT INTO #TMPRELICSPAWNINFO(tiername,relictypename,rate)
VALUES
('T0','relic_level2_neutral_beta2',10),
('T0','relic_level3_neutral_beta2',20),
('T0','relic_level4_neutral_gamma',25),
('T0','relic_level2_indy_beta2',10),
('T0','relic_level3_indy_beta2',20),
('T0','relic_level4_indy_gamma',25),
('T0','relic_level2_numiqol_beta2',10),
('T0','relic_level3_numiqol_beta2',20),
('T0','relic_level4_numiqol_gamma',25),
('T0','relic_level2_thelodica_beta2',10),
('T0','relic_level3_thelodica_beta2',20),
('T0','relic_level4_thelodica_gamma',25),
('T0','relic_level2_pelistal_beta2',10),
('T0','relic_level3_pelistal_beta2',20),
('T0','relic_level4_pelistal_gamma',25),
('T1','relic_level2_neutral_beta2',10),
('T1','relic_level3_neutral_beta2',25),
('T1','relic_level4_neutral_gamma',20),
('T1','relic_level2_indy_beta2',10),
('T1','relic_level3_indy_beta2',25),
('T1','relic_level4_indy_gamma',20),
('T1','relic_level2_numiqol_beta2',10),
('T1','relic_level3_numiqol_beta2',25),
('T1','relic_level4_numiqol_gamma',20),
('T1','relic_level2_thelodica_beta2',10),
('T1','relic_level3_thelodica_beta2',25),
('T1','relic_level4_thelodica_gamma',20),
('T1','relic_level2_pelistal_beta2',10),
('T1','relic_level3_pelistal_beta2',25),
('T1','relic_level4_pelistal_gamma',20),
('T2','relic_level2_neutral_beta2',15),
('T2','relic_level3_neutral_beta2',25),
('T2','relic_level4_neutral_gamma',15),
('T2','relic_level2_indy_beta2',15),
('T2','relic_level3_indy_beta2',25),
('T2','relic_level4_indy_gamma',15),
('T2','relic_level2_numiqol_beta2',15),
('T2','relic_level3_numiqol_beta2',25),
('T2','relic_level4_numiqol_gamma',15),
('T2','relic_level2_thelodica_beta2',10),
('T2','relic_level3_thelodica_beta2',25),
('T2','relic_level4_thelodica_gamma',20),
('T2','relic_level2_pelistal_beta2',10),
('T2','relic_level3_pelistal_beta2',25),
('T2','relic_level4_pelistal_gamma',20),
('T3','relic_level2_neutral_beta2',30),
('T3','relic_level3_neutral_beta2',20),
('T3','relic_level4_neutral_gamma',10),
('T3','relic_level2_indy_beta2',30),
('T3','relic_level3_indy_beta2',20),
('T3','relic_level4_indy_gamma',10),
('T3','relic_level2_numiqol_beta2',30),
('T3','relic_level3_numiqol_beta2',20),
('T3','relic_level4_numiqol_gamma',10),
('T3','relic_level2_thelodica_beta2',30),
('T3','relic_level3_thelodica_beta2',20),
('T3','relic_level4_thelodica_gamma',10),
('T3','relic_level2_pelistal_beta2',30),
('T3','relic_level3_pelistal_beta2',20),
('T3','relic_level4_pelistal_gamma',10),
('TC','relic_level2_neutral_beta2',20),
('TC','relic_level2_indy_beta2',20),
('TC','relic_level2_numiqol_beta2',20),
('TC','relic_level2_pelistal_beta2',20),
('TC','relic_level2_thelodica_beta2',20);

DROP TABLE IF EXISTS #CONFIG;
CREATE TABLE #CONFIG(
	tier int,
	maxSpawn int,
	respawnRate int
);
INSERT INTO #CONFIG(tier, maxSpawn, respawnRate) VALUES
(-1, 0, 10800),
(0, 18, 10800),
(1, 9, 10800),
(2, 9, 10800),
(3, 9, 10800);

UPDATE t
SET t.relictypeid = (SELECT TOP 1 reltyp.id FROM dbo.relictypes reltyp WHERE reltyp.name = t.relictypename),
	t.tier = (CASE WHEN t.tiername = 'TC' THEN -1
				WHEN t.tiername = 'T0' THEN 0
				WHEN t.tiername = 'T1' THEN 1
				WHEN t.tiername = 'T2' THEN 2
				WHEN t.tiername = 'T3' THEN 3
			END)
FROM #TMPRELICSPAWNINFO t;


DROP TABLE IF EXISTS #INFOS;
CREATE TABLE #INFOS(	
	relictypeid int NULL,
	zoneid int NULL,
	rate int NOT NULL,
	x int NULL,
	y int NULL
);
INSERT INTO #INFOS (relictypeid, zoneid, rate)
SELECT t.relictypeid, z.zoneid, t.rate
FROM #ZONES_BY_TIER z
JOIN #TMPRELICSPAWNINFO t ON t.tier=z.tier;

--SELECT * FROM dbo.relicspawninfo WHERE zoneid IN (SELECT DISTINCT zoneid FROM #ZONES_BY_TIER);
DELETE FROM dbo.relicspawninfo WHERE zoneid IN (SELECT DISTINCT zoneid FROM #ZONES_BY_TIER);

INSERT INTO dbo.relicspawninfo (relictypeid,zoneid,rate)
SELECT relictypeid,zoneid,rate
FROM #INFOS;

--SELECT * FROM dbo.reliczoneconfig WHERE zoneid IN (SELECT DISTINCT zoneid FROM #ZONES_BY_TIER);
DELETE FROM dbo.reliczoneconfig WHERE zoneid IN (SELECT DISTINCT zoneid FROM #ZONES_BY_TIER);

INSERT INTO dbo.reliczoneconfig(zoneid, maxspawn, respawnrate)
SELECT z.zoneid, c.maxSpawn, c.respawnRate
FROM #ZONES_BY_TIER z
JOIN #CONFIG c ON c.tier=z.tier;

DROP TABLE IF EXISTS #INFOS;
DROP TABLE IF EXISTS #TMPRELICSPAWNINFO;
DROP TABLE IF EXISTS #ZONES_BY_TIER;
GO

USE [perpetuumsa]
GO

DROP TABLE IF EXISTS #TMPRELICLOOT;
CREATE TABLE #TMPRELICLOOT(	
	relicname varchar(100) NOT NULL,
	defname varchar(100) NOT NULL,
	minquantity int NOT NULL,
	maxquantity int NOT NULL,
	chance decimal(9, 6) NOT NULL,
	definition int NULL,
	relictypeid int NULL
);

INSERT INTO #TMPRELICLOOT (relicname,defname,minquantity,maxquantity,chance)
VALUES
('relic_level4_neutral_gamma','def_robotshard_common_basic',70,75,1),
('relic_level4_neutral_gamma','def_robotshard_common_advanced',70,75,1),
('relic_level4_neutral_gamma','def_robotshard_common_expert',70,75,1),
('relic_level4_neutral_gamma','def_common_reactor_plasma',5850,7150,1),
('relic_level4_neutral_gamma','def_kernel_common',8776,10726,1),
('relic_level4_neutral_gamma','def_kernel_hitech',2926,3576,1),

('relic_level4_indy_gamma','def_robotshard_common_basic',70,75,1),
('relic_level4_indy_gamma','def_robotshard_common_advanced',70,75,1),
('relic_level4_indy_gamma','def_robotshard_common_expert',70,75,1),
('relic_level4_indy_gamma','def_common_reactor_plasma',5850,7150,1),
('relic_level4_indy_gamma','def_kernel_industrial',5850,7150,1),
('relic_level4_indy_gamma','def_kernel_common',5850,7150,1),

('relic_level4_numiqol_gamma','def_robotshard_nuimqol_basic',70,75,1),
('relic_level4_numiqol_gamma','def_robotshard_nuimqol_advanced',70,75,1),
('relic_level4_numiqol_gamma','def_robotshard_nuimqol_expert',70,75,1),
('relic_level4_numiqol_gamma','def_nuimqol_reactor_plasma',5850,7150,1),
('relic_level4_numiqol_gamma','def_kernel_nuimqol',5850,7150,1),
('relic_level4_numiqol_gamma','def_kernel_common',5850,7150,1),

('relic_level4_thelodica_gamma','def_robotshard_thelodica_basic',70,75,1),
('relic_level4_thelodica_gamma','def_robotshard_thelodica_advanced',70,75,1),
('relic_level4_thelodica_gamma','def_robotshard_thelodica_expert',70,75,1),
('relic_level4_thelodica_gamma','def_thelodica_reactor_plasma',5850,7150,1),
('relic_level4_thelodica_gamma','def_kernel_thelodica',5850,7150,1),
('relic_level4_thelodica_gamma','def_kernel_common',5850,7150,1),

('relic_level4_pelistal_gamma','def_robotshard_pelistal_basic',70,75,1),
('relic_level4_pelistal_gamma','def_robotshard_pelistal_advanced',70,75,1),
('relic_level4_pelistal_gamma','def_robotshard_pelistal_expert',70,75,1),
('relic_level4_pelistal_gamma','def_pelistal_reactor_plasma',5850,7150,1),
('relic_level4_pelistal_gamma','def_kernel_pelistal',5850,7150,1),
('relic_level4_pelistal_gamma','def_kernel_common',5850,7150,1);

UPDATE t
SET t.relictypeid = (SELECT TOP 1 reltyp.id FROM dbo.relictypes reltyp WHERE reltyp.name = t.relicname),
	t.definition = (SELECT TOP 1 e.definition FROM dbo.entitydefaults e WHERE e.definitionname = t.defname)
FROM #TMPRELICLOOT t;

--SELECT * FROM relicloot WHERE id IN (SELECT DISTINCT relictypeid FROM #TMPRELICLOOT);
DELETE FROM relicloot WHERE id IN (SELECT DISTINCT relictypeid FROM #TMPRELICLOOT);

INSERT INTO dbo.relicloot (definition,minquantity,maxquantity,chance,relictypeid,packed)
SELECT definition, minquantity, maxquantity, chance, relictypeid, 0 as packed
FROM #TMPRELICLOOT

DROP TABLE IF EXISTS #TMPRELICLOOT;
GO

PRINT N'GAMMA RELICS CONFIGURED AND INSERTED';

GO

PRINT N'PATCH 26: GAMMA PHASE 1/3 COMPLETE';
GO