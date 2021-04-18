USE [perpetuumsa]
GO

---------------------------------------------
-- Reduce volume of Fragments by 50%
-- Date Modified: 2021/04/10
---------------------------------------------

PRINT N'SET FRAGMENT ENTITYDEFAULT VOLUMES';
DROP TABLE IF EXISTS #FRAGS;
CREATE TABLE #FRAGS(
	defName VARCHAR(100),
	vol FLOAT
);
INSERT INTO #FRAGS (defName, vol) VALUES
('def_robotshard_common_basic',0.005),
('def_robotshard_common_advanced',0.01),
('def_robotshard_common_expert',0.015),
('def_robotshard_thelodica_basic',0.005),
('def_robotshard_thelodica_advanced',0.01),
('def_robotshard_thelodica_expert',0.015),
('def_robotshard_nuimqol_basic',0.005),
('def_robotshard_nuimqol_advanced',0.01),
('def_robotshard_nuimqol_expert',0.015),
('def_robotshard_pelistal_basic',0.005),
('def_robotshard_pelistal_advanced',0.01),
('def_robotshard_pelistal_expert',0.015);

PRINT N'MERGE/UPDATE ON FRAGS';
MERGE [dbo].[entitydefaults] e USING #FRAGS f
ON e.definitionname=f.defName
WHEN MATCHED
    THEN UPDATE SET
	volume = f.vol;

PRINT N'DONE WITH FRAG VOLUMES';
DROP TABLE IF EXISTS #FRAGS;
GO
