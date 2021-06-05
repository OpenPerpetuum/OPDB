USE [perpetuumsa]
GO

--------------------------------------------------
-- Firearm production, reduce titanium = levels of other modules
--
-- Date modified: 2021/05/05
--------------------------------------------------

PRINT N'Firearm production adjustments';
DROP TABLE IF EXISTS #COMPS;
CREATE TABLE #COMPS(
	defName VARCHAR(100),
	compName VARCHAR(100),
	amount INT
);
INSERT INTO #COMPS (defName, compName, amount) VALUES
('def_standard_small_autocannon','def_titanium',50),
('def_standard_medium_autocannon','def_titanium',100),
('def_named1_small_autocannon','def_titanium',50),
('def_named2_small_autocannon','def_titanium',50),
('def_named3_small_autocannon','def_titanium',50),
('def_named1_medium_autocannon','def_titanium',100),
('def_named2_medium_autocannon','def_titanium',100),
('def_named3_medium_autocannon','def_titanium',100),
('def_longrange_standard_medium_autocannon','def_titanium',100),
('def_named1_longrange_medium_autocannon','def_titanium',100),
('def_named2_longrange_medium_autocannon','def_titanium',100),
('def_named3_longrange_medium_autocannon','def_titanium',100),
('def_named1_small_autocannon_pr','def_titanium',50),
('def_named2_small_autocannon_pr','def_titanium',50),
('def_named3_small_autocannon_pr','def_titanium',50),
('def_named1_medium_autocannon_pr','def_titanium',100),
('def_named2_medium_autocannon_pr','def_titanium',100),
('def_named3_medium_autocannon_pr','def_titanium',100),
('def_named1_longrange_medium_autocannon_pr','def_titanium',100),
('def_named2_longrange_medium_autocannon_pr','def_titanium',100),
('def_named3_longrange_medium_autocannon_pr','def_titanium',100);

PRINT N'Update [components]';
MERGE [dbo].[components] c USING #COMPS i
ON c.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=i.defName) AND
c.componentdefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=i.compName) 
WHEN MATCHED
    THEN UPDATE SET
		componentamount = i.amount;

PRINT N'Updated [components] for firearm prod';
DROP TABLE IF EXISTS #COMPS;
GO