USE [perpetuumsa]
GO

-----------------------------------------------------------
-- Zone Effects Table + some new zone effects
-- Rename zone effect category
-- Add new effects w/ bonuses
-- Create lookup table for zone-zoneeffect associations
-- Date: 2020/08/06
-----------------------------------------------------------

PRINT N'Refactor name of effcat_zone_effects from old: effcat_zone_beta';
UPDATE effectcategories SET 
	name = 'effcat_zone_effects',
	note = 'static zone-effects'
WHERE name = 'effcat_zone_beta';

DECLARE @effectCategory BIGINT;
SET @effectCategory = (SELECT TOP 1 POWER(CAST(2 as bigint), CAST(flag as bigint)) FROM effectcategories WHERE name='effcat_zone_effects');
SELECT @effectCategory; --17592186044416

DROP TABLE IF EXISTS #EFFS;
CREATE TABLE #EFFS (
	name VARCHAR(64),
	description VARCHAR(64),
	expectedID INT
);
INSERT INTO #EFFS (name, description, expectedID) VALUES
('effect_beta_bonus', 'effect_beta_bonus_desc', 103),
('effect_beta2_bonus', 'effect_beta2_bonus_desc', 104),
('effect_alpha_bonus', 'effect_alpha_bonus_desc', 105),
('effect_alpha2_bonus', 'effect_alpha2_bonus_desc', 106);
--SERVER ENUM VALS
--effect_beta_bonus = 103,
--effect_beta2_bonus = 104,
--effect_alpha_bonus = 105,
--effect_alpha2_bonus = 106


DROP TABLE IF EXISTS #BONUSES;
CREATE TABLE #BONUSES (
	name VARCHAR(64),
	field VARCHAR(64),
	value FLOAT
);
INSERT INTO #BONUSES (name, field, value) VALUES
('effect_alpha_bonus', 'effect_detection_strength_modifier', 2),
('effect_alpha2_bonus', 'effect_harvesting_amount_modifier', 1.05),
('effect_alpha2_bonus', 'effect_mining_amount_modifier', 1.05),
('effect_beta_bonus', 'effect_harvesting_amount_modifier', 1.25),
('effect_beta_bonus', 'effect_mining_amount_modifier', 1.25),
('effect_beta2_bonus', 'effect_harvesting_amount_modifier', 1.35),
('effect_beta2_bonus', 'effect_mining_amount_modifier', 1.35);

SET IDENTITY_INSERT [dbo].[effects] ON;
PRINT N'Update/insert Effects';
--Update/insert Effects
MERGE [dbo].[effects] e USING #EFFS e2
ON e.id = e2.expectedID
WHEN MATCHED
    THEN UPDATE SET
		[effectcategory] = @effectCategory,
		[duration] = 0,
		[name] = e2.name,
		[description] = e2.description,
		[note] = 'zone effect',
		[isaura] = 1,
		[auraradius] = 0,
		[ispositive] = 1,
		[display] = 1,
		[saveable] = 0
WHEN NOT MATCHED
    THEN INSERT ([id],[effectcategory],[duration],[name],[description],[note],[isaura],[auraradius],[ispositive],[display],[saveable]) 
		   VALUES
           (e2.expectedID, @effectCategory,0,e2.name,e2.description,'zone effect',1,0,1,1,0);
SET IDENTITY_INSERT [dbo].[effects] OFF;

PRINT N'Update/insert EffectsModifiers';
--Update/insert EffectsModifiers
MERGE [dbo].[effectdefaultmodifiers] m USING #BONUSES b
ON m.effectid=(SELECT TOP 1 id FROM effects WHERE name=b.name) AND m.field=(SELECT TOP 1 id FROM aggregatefields WHERE aggregatefields.name = b.field)
WHEN MATCHED
    THEN UPDATE SET
		[value] = b.value
WHEN NOT MATCHED
    THEN INSERT ([effectid],[field],[value]) 
		   VALUES
           ((SELECT TOP 1 id FROM effects WHERE name=b.name),(SELECT TOP 1 id FROM aggregatefields WHERE aggregatefields.name = b.field), b.value);


PRINT N'RE-CREATE TABLE dbo.zoneeffects';
DROP TABLE IF EXISTS dbo.zoneeffects;

CREATE TABLE dbo.zoneeffects (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	zoneid INT NOT NULL,
	effectid INT NOT NULL
);


INSERT INTO dbo.zoneeffects (zoneid, effectid) VALUES
((SELECT TOP 1 id FROM zones WHERE name='zone_TM' AND note='new virginia'),(SELECT TOP 1 id FROM [effects] WHERE name='effect_alpha_bonus')),
((SELECT TOP 1 id FROM zones WHERE name='zone_TM_pve' AND note='hershfield'),(SELECT TOP 1 id FROM [effects] WHERE name='effect_alpha2_bonus')),
((SELECT TOP 1 id FROM zones WHERE name='zone_ICS_A_real' AND note='domhalarn'),(SELECT TOP 1 id FROM [effects] WHERE name='effect_beta_bonus')),
((SELECT TOP 1 id FROM zones WHERE name='zone_ASI_A_real' AND note='hokkogaros'),(SELECT TOP 1 id FROM [effects] WHERE name='effect_beta_bonus')),
((SELECT TOP 1 id FROM zones WHERE name='zone_TM_A_real' AND note='norhoop'),(SELECT TOP 1 id FROM [effects] WHERE name='effect_beta_bonus')),
((SELECT TOP 1 id FROM zones WHERE name='zone_ASI_pvp' AND note='kentagura'),(SELECT TOP 1 id FROM [effects] WHERE name='effect_beta2_bonus')),
((SELECT TOP 1 id FROM zones WHERE name='zone_TM_pvp' AND note='alsbale'),(SELECT TOP 1 id FROM [effects] WHERE name='effect_beta2_bonus')),
((SELECT TOP 1 id FROM zones WHERE name='zone_ICS_pvp' AND note='novastrov'),(SELECT TOP 1 id FROM [effects] WHERE name='effect_beta2_bonus'));


DROP TABLE IF EXISTS #EFFS;
DROP TABLE IF EXISTS #BONUSES;
PRINT N'zoneeffects DONE';
GO
