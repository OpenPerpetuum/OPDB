USE [perpetuumsa]
GO



-----------------------------------------------------------------
--Live Patch 18: lots of fixes
--
--01_Entitydefaults_insert_strongholdRiftExit_5882__2020_08_03.sql
--02_PlantDmgType_defconfig_aggfields__2020_08_14.sql
--03_ZoneEffects_Createtable_effects_update_insert__2020_08_06.sql
--04_Table_create_StrongholdExitConfig__2020_08_03.sql
--05_Table_create_ZoneRiftConfig__2020_08_03.sql
--06_Table_create_ZoneteleportDevicemap__2020_08_09.sql
--07_Missionrewards_mineralconfigs__2020_08_14.sql
--08_Modulepropmodifier_delete_paintermask__2020_07_22.sql
--09_teleportdescriptions_update__2020_08_02.sql
--10_def_npc_goblin_lancer__2020_08_16_16_14_34.sql
--
--Date modified: 2020/08/30
-----------------------------------------------------------------


PRINT N'01_Entitydefaults_insert_strongholdRiftExit_5882__2020_08_03';
USE [perpetuumsa]
GO
---------------------------------------------------------
-- Add new "exit" rift definition to render and have title/desc for players
-- 
-- Date: 2020/08/03
---------------------------------------------------------
PRINT N'ADDING NEW "RIFT" ENTITYDEF';
DECLARE @base bigint;
SET @base = 2;

DECLARE @nonAttack BIGINT;
DECLARE @nonLock BIGINT;
DECLARE @invulnerable BIGINT;
DECLARE @useable BIGINT;

SET @nonAttack = (SELECT TOP 1 POWER(@base, offset) FROM attributeFlags WHERE name='nonattackable');
SET @nonLock = (SELECT TOP 1 POWER(@base, offset) FROM attributeFlags WHERE name='nonlockable');
SET @invulnerable = (SELECT TOP 1 POWER(@base, offset) FROM attributeFlags WHERE name='invulnerable');
SET @useable = (SELECT TOP 1 POWER(@base, offset) FROM attributeFlags WHERE name='usable');

DECLARE @exitPortalAttrFlags BIGINT;
SET @exitPortalAttrFlags = @nonAttack + @nonLock + @invulnerable + @useable;
--select * from attributeFlags where offset<63 AND POWER(@base, offset) & @exitPortalAttrFlags = POWER(@base, offset)


DECLARE @defName varchar(100);
DECLARE @defId int;
DECLARE @catFlags BIGINT;

SET @defName = 'def_stronghold_exit_rift';
SET @defId = 5882;
SET @catFlags = (SELECT TOP 1 VALUE FROM categoryFlags WHERE name='cf_portals');


PRINT N'INTEGRITY CHECK: ALL NAMED ENTITYDEFAULTS WITH SPECIFIED IDs MUST BE INSERTED WITH THE SPECIFIED ID';
IF EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE @defId=definition AND @defName!=definitionname)
BEGIN
	PRINT N'====FATAL====';
	PRINT N'DEFINITION INTEGRITY CHECK FAILED! SKIPPING ALL EXECUTION IN THIS SCRIPT';
	PRINT N'====FATAL====';
	SET NOEXEC ON;
END

IF EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE definition=@defId AND definitionname=@defName)
BEGIN
	UPDATE entitydefaults SET
		attributeflags=@exitPortalAttrFlags,
		categoryflags=@catFlags,
		descriptiontoken=@defName+'_desc',
		options='#height=f6.00',
		note='Stronghold Exit Rift!'
	WHERE definition=@defId AND definitionname=@defName;
	PRINT N'UPDATED def_stronghold_exit_rift';
END
ELSE
BEGIN
	SET IDENTITY_INSERT entitydefaults ON;
	INSERT INTO [dbo].[entitydefaults] ([definition],[definitionname],[quantity],[attributeflags],[categoryflags],[options],[note],[enabled],[volume],[mass],[hidden],[health],[descriptiontoken],[purchasable],[tiertype],[tierlevel]) VALUES
		(@defId,@defName,1,@exitPortalAttrFlags,@catFlags,'#height=f6.00','Stronghold Exit Rift!',1,0,0,0,100,@defName+'_desc',0,NULL,NULL);
	PRINT N'INSERTED def_stronghold_exit_rift';
	SET IDENTITY_INSERT entitydefaults OFF;
END


DROP TABLE IF EXISTS #AGGVALS;
CREATE TABLE #AGGVALS 
(
	fieldName varchar(100),
	fieldValue float,
);
INSERT INTO #AGGVALS (fieldName, fieldValue) VALUES
('armor_max', 42069),
('resist_chemical', 100000),
('resist_explosive', 100000),
('resist_kinetic', 100000),
('resist_thermal', 100000),
('signature_radius', 1),
('blob_emission', 10),
('blob_emission_radius', 50),
('stealth_strength', 1);

PRINT N'DELETE OLD STATS';
DELETE FROM aggregatevalues WHERE definition = @defId;

PRINT N'INSERT NEW STATS';
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value])
SELECT 
	@defId,
	(SELECT TOP 1 id FROM aggregatefields WHERE fieldName=name),
	fieldValue 
FROM #AGGVALS;

DROP TABLE IF EXISTS #AGGVALS;
SET NOEXEC OFF;
PRINT N'END';
GO




PRINT N'02_PlantDmgType_defconfig_aggfields__2020_08_14';
USE [perpetuumsa]
GO

--------------------------------------------------
-- Add "Toxic" damage, a new type that applies to plants only
-- ALTERS definitionconfig ADD COL
-- INSERT aggregatefields
-- INSERT/UPDATE chassisbonus
-- INSERT/UPDATE aggregatevalues
-- UPDATE definitonconfig
--
-- Add to definitionconfig for bombs
-- Add aggfields for value configuration on entitydefs
-- Add to projectile ammo
-- Add bonuses to syndicate to buff toxin damage
--
--Date modified: 2020/08/14
--------------------------------------------------

DECLARE @toxicDamageName VARCHAR(100);
SET @toxicDamageName = 'damage_toxic';


PRINT N'ADDING COL damage_toxic TO definitionconfig';
IF NOT EXISTS (
  SELECT
    *
  FROM
    INFORMATION_SCHEMA.COLUMNS
  WHERE
    TABLE_NAME = 'definitionconfig' AND COLUMN_NAME = @toxicDamageName)
BEGIN
  ALTER TABLE definitionconfig
    ADD damage_toxic float NULL
END;

PRINT N'INSERT/UPDATE definitionconfigunits';
IF NOT EXISTS (select id from definitionconfigunits where configname=@toxicDamageName)
BEGIN
	INSERT INTO definitionconfigunits (configname, measurementoffset, measurementmultiplier, digits) VALUES
	(@toxicDamageName, 0, 1, 0);

END
ELSE
BEGIN
	UPDATE definitionconfigunits SET
		measurementoffset=0,
		measurementmultiplier=1,
		digits=0
	WHERE configname=@toxicDamageName;
END


DROP TABLE IF EXISTS #BONUS;
CREATE TABLE #BONUS(
	chassisName VARCHAR(100),
	extName VARCHAR(100),
	bonusAmount float,
	fieldName VARCHAR(100)
);

INSERT INTO #BONUS (chassisName, extName, bonusAmount, fieldName) VALUES
('def_vektor_chassis', 'ext_syndicate_combat_specialist', 0.01, @toxicDamageName+'_modifier'),
('def_locust_chassis', 'ext_syndicate_combat_specialist', 0.01, @toxicDamageName+'_modifier'),
('def_echelon_chassis', 'ext_syndicate_combat_specialist', 0.01, @toxicDamageName+'_modifier'),
('def_legatus_chassis', 'ext_syndicate_combat_specialist', 0.01, @toxicDamageName+'_modifier');


DROP TABLE IF EXISTS #TOXICDMG;
CREATE TABLE #TOXICDMG(
	ammoName VARCHAR(100),
	dmg INT
);

INSERT INTO #TOXICDMG(ammoName, dmg) VALUES
('def_ammo_large_projectile_a', 3),
('def_ammo_large_projectile_b', 3),
('def_ammo_large_projectile_c', 3),
('def_ammo_large_projectile_d', 3),
('def_ammo_medium_projectile_a', 2),
('def_ammo_medium_projectile_b', 2),
('def_ammo_medium_projectile_c', 2),
('def_ammo_medium_projectile_d', 2),
('def_ammo_medium_projectile_rewa', 2),
('def_ammo_medium_projectile_rewb', 2),
('def_ammo_small_projectile_a', 1),
('def_ammo_small_projectile_b', 1),
('def_ammo_small_projectile_c', 1),
('def_ammo_small_projectile_d', 1),
('def_ammo_small_projectile_rewa', 1),
('def_ammo_small_projectile_rewb', 1);



DROP TABLE IF EXISTS #TOXICBOMB;
CREATE TABLE #TOXICBOMB(
	bombName VARCHAR(100),
	dmg INT
);

INSERT INTO #TOXICBOMB(bombName, dmg) VALUES
('def_area_bomb', 10),
('def_area_bomb_capsule', 10),
('def_plant_bomb', 30),
('def_plant_bomb_capsule', 30);



PRINT N'INSERTING aggregatefields';
IF NOT EXISTS (SELECT TOP 1 id FROM dbo.aggregatefields WHERE name = @toxicDamageName)
BEGIN
	SET IDENTITY_INSERT dbo.aggregatefields ON;
	INSERT INTO dbo.aggregatefields(id, name, formula, measurementunit, measurementmultiplier, measurementoffset, category, digits, moreisbetter, usedinconfig, note) VALUES
	(660, @toxicDamageName, 1, @toxicDamageName+'_unit', 1, 0, 6, 0, 1, 1, 'Toxic damage to plants only'),
	(661, @toxicDamageName+'_modifier', 0, @toxicDamageName+'_modifier_unit', 100, -100, 6, 0, 1, 1, 'Toxic damage to plants only');
	SET IDENTITY_INSERT dbo.aggregatefields OFF;
END;


PRINT N'INSERT/UPDATE chassisbonus';
MERGE chassisbonus c USING #BONUS b
ON c.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=b.chassisName) AND
c.targetPropertyID = (SELECT TOP 1 id FROM aggregatefields WHERE name=b.fieldName)
WHEN MATCHED
    THEN UPDATE SET
		c.bonus = b.bonusAmount,
		c.extension = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname=b.extName)
WHEN NOT MATCHED
    THEN INSERT(definition, extension, bonus, note, targetpropertyID, effectenhancer) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=b.chassisName),
	(SELECT TOP 1 extensionid FROM extensions WHERE extensionname=b.extName),
	b.bonusAmount,
	'toxic damage bonus on syndicates!',
	(SELECT TOP 1 id FROM aggregatefields WHERE name=b.fieldName),
	0);




PRINT N'INSERT/UPDATE aggregatevalues';
MERGE aggregatevalues v USING #TOXICDMG t
ON v.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=t.ammoName) AND
v.field = (SELECT TOP 1 id FROM aggregatefields WHERE name=@toxicDamageName)
WHEN MATCHED
    THEN UPDATE SET
		v.value = t.dmg
WHEN NOT MATCHED
    THEN INSERT(definition, field, value) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=t.ammoName),
	(SELECT TOP 1 id FROM aggregatefields WHERE name=@toxicDamageName),
	t.dmg);



PRINT N'INSERT/UPDATE definitionconfig';
MERGE definitionconfig c USING #TOXICBOMB t
ON c.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=t.bombName)
WHEN MATCHED
    THEN UPDATE SET
		c.damage_toxic = t.dmg;

PRINT N'delete/re-insert  modulepropertymodifiers'
DELETE FROM modulepropertymodifiers WHERE 
categoryflags=(SELECT TOP 1 value FROM categoryFlags WHERE name='cf_projectiles') AND
basefield=(SELECT TOP 1 id FROM aggregatefields WHERE name=@toxicDamageName+'_modifier') AND
modifierfield=(SELECT TOP 1 id FROM aggregatefields WHERE name=@toxicDamageName+'_modifier');

INSERT INTO modulepropertymodifiers (categoryflags, basefield, modifierfield) VALUES
((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_projectiles'),
(SELECT TOP 1 id FROM aggregatefields WHERE name=@toxicDamageName+'_modifier'),
(SELECT TOP 1 id FROM aggregatefields WHERE name=@toxicDamageName+'_modifier'));


PRINT N'DONE: new damage type added to bombs and projectile ammo';
DROP TABLE IF EXISTS #BONUS;
DROP TABLE IF EXISTS #TOXICBOMB;
DROP TABLE IF EXISTS #TOXICDMG;

GO


PRINT N'03_ZoneEffects_Createtable_effects_update_insert__2020_08_06';
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


PRINT N'04_Table_create_StrongholdExitConfig__2020_08_03';
USE [perpetuumsa]
GO


---------------------------------------------------------
-- Add table of stronghold exit locations
-- 
-- Date: 2020/08/03
---------------------------------------------------------


DROP TABLE IF EXISTS dbo.strongholdexitconfig;

CREATE TABLE dbo.strongholdexitconfig (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	zoneid INT NOT NULL,
	x INT NOT NULL,
	y INT NOT NULL
);

INSERT strongholdexitconfig (zoneid, x, y) VALUES
(16, 1120, 1040),
(16, 942, 993);

GO


PRINT N'05_Table_create_ZoneRiftConfig__2020_08_03';
USE [perpetuumsa]
GO


---------------------------------------------------------
-- Add table to configure rifts and level per zone
-- 
-- Date: 2020/08/03
---------------------------------------------------------


DROP TABLE IF EXISTS dbo.zoneriftsconfig;

CREATE TABLE dbo.zoneriftsconfig (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	zoneid INT NOT NULL UNIQUE,
	maxrifts INT NOT NULL,
	maxlevel INT NOT NULL
);

INSERT zoneriftsconfig (zoneid, maxrifts, maxlevel) VALUES
((SELECT TOP 1 id FROM zones WHERE name='zone_TM' AND note='new virginia'), 10, 1),
((SELECT TOP 1 id FROM zones WHERE name='zone_ICS' AND note='attalica'), 10, 1),
((SELECT TOP 1 id FROM zones WHERE name='zone_ASI' AND note='daoden'), 10, 1),
((SELECT TOP 1 id FROM zones WHERE name='zone_ICS_A_real' AND note='domhalarn'), 10, 2),
((SELECT TOP 1 id FROM zones WHERE name='zone_ASI_A_real' AND note='hokkogaros'), 10, 2),
((SELECT TOP 1 id FROM zones WHERE name='zone_TM_A_real' AND note='norhoop'), 10, 2),
((SELECT TOP 1 id FROM zones WHERE name='zone_ICS_pve' AND note='tellesis'), 10, 1),
((SELECT TOP 1 id FROM zones WHERE name='zone_ASI_pve' AND note='shinjalar'), 10, 1),
((SELECT TOP 1 id FROM zones WHERE name='zone_TM_pve' AND note='hershfield'), 10, 1),
((SELECT TOP 1 id FROM zones WHERE name='zone_ASI_pvp' AND note='kentagura'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_TM_pvp' AND note='alsbale'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_ICS_pvp' AND note='novastrov'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_tm_g_1'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_tm_g_2'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_tm_g_3'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_tm_g_4'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_tm_g_5'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_tm_g_6'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_tm_g_7'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_tm_g_8'), 10, 3),

((SELECT TOP 1 id FROM zones WHERE name='zone_ics_g_1'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_ics_g_2'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_ics_g_3'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_ics_g_4'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_ics_g_5'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_ics_g_6'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_ics_g_7'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_ics_g_8'), 10, 3),

((SELECT TOP 1 id FROM zones WHERE name='zone_asi_g_1'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_asi_g_2'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_asi_g_3'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_asi_g_4'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_asi_g_5'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_asi_g_6'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_asi_g_7'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_asi_g_8'), 10, 3);
GO


PRINT N'06_Table_create_ZoneteleportDevicemap__2020_08_09';
USE [perpetuumsa]
GO
------------------------------------------------------------------
-- A table to map mobile teleports to zones
-- Use: mobileStrongholdTeleports
-- Date modified: 2020/08/09
------------------------------------------------------------------


PRINT N'CREATE TABLE zoneteleportdevicemap';
DROP TABLE IF EXISTS dbo.zoneteleportdevicemap;
CREATE TABLE dbo.zoneteleportdevicemap(
	id INT NOT NULL IDENTITY PRIMARY KEY,
	sourcedefinition INT NOT NULL,
	zoneid INT NOT NULL
);


INSERT INTO dbo.zoneteleportdevicemap (sourcedefinition, zoneid) VALUES
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_mobile_teleport_stronghold_basic'),
(SELECT TOP 1 id FROM zones WHERE name='zone_pvp_arena' AND note='pvp arena' AND zonetype=4));

PRINT N'DONE CREATING TABLE zoneteleportdevicemap';
GO


PRINT N'07_Missionrewards_mineralconfigs__2020_08_14';
USE [perpetuumsa]
GO

--------------------------------------------------------
-- Economy updates for P18
-- Lower number of fields on all islands (was 2x designed numbers)
-- ~10% buff to all mission target categories
-- Date Modified: 2020/08/14
--------------------------------------------------------

DROP TABLE IF EXISTS #REWARDS;
CREATE TABLE #REWARDS(
	name varchar(100),
	reward int
);
INSERT INTO #REWARDS(name, reward) VALUES
('loot_item',55),
('kill_definition',55),
('scan_mineral',200),
('drill_mineral',4200),
('submit_item',220),
('use_switch',55),
('find_artifact',200),
('use_itemsupply',275),
('massproduce',550),
('research',550),
('harvest_plant',1100),
('pop_npc',15),
('lock_unit',55);

MERGE missiontargettypes t USING #REWARDS r
ON t.name=r.name
WHEN MATCHED
    THEN UPDATE SET
		t.reward=r.reward;



DROP TABLE IF EXISTS #MINS;
CREATE TABLE #MINS(
	zoneName varchar(100),
	material int,
	numfields int
);
INSERT INTO #MINS(zoneName, material, numfields) VALUES
('zone_TM', 1, 8),
('zone_TM', 2, 8),
('zone_TM', 5, 8),
('zone_TM_pve', 1, 8),
('zone_TM_pve', 2, 8),
('zone_TM_pve', 3, 8),
('zone_TM_pve', 4, 8),
('zone_TM_pve', 5, 8),
('zone_TM_pve', 12, 8),
('zone_ICS_A_real', 1, 10),
('zone_ICS_A_real', 2, 10),
('zone_ICS_A_real', 3, 10),
('zone_ICS_A_real', 4, 10),
('zone_ICS_A_real', 5, 10),
('zone_ICS_A_real', 6, 15),
('zone_ICS_A_real', 16, 4),
('zone_ASI_A_real', 1, 10),
('zone_ASI_A_real', 2, 10),
('zone_ASI_A_real', 3, 10),
('zone_ASI_A_real', 5, 10),
('zone_ASI_A_real', 12, 10),
('zone_ASI_A_real', 6, 15),
('zone_ASI_A_real', 16, 4),
('zone_TM_A_real', 1, 10),
('zone_TM_A_real', 2, 10),
('zone_TM_A_real', 4, 10),
('zone_TM_A_real', 5, 10),
('zone_TM_A_real', 12, 10),
('zone_TM_A_real', 6, 15),
('zone_TM_A_real', 16, 4),
('zone_ICS_pvp', 1, 12),
('zone_ICS_pvp', 2, 12),
('zone_ICS_pvp', 3, 12),
('zone_ICS_pvp', 4, 12),
('zone_ICS_pvp', 5, 12),
('zone_ICS_pvp', 6, 18),
('zone_ICS_pvp', 16, 5),
('zone_ASI_pvp', 1, 12),
('zone_ASI_pvp', 2, 12),
('zone_ASI_pvp', 3, 12),
('zone_ASI_pvp', 5, 12),
('zone_ASI_pvp', 12, 12),
('zone_ASI_pvp', 6, 18),
('zone_ASI_pvp', 16, 5),
('zone_TM_pvp', 1, 12),
('zone_TM_pvp', 2, 12),
('zone_TM_pvp', 4, 12),
('zone_TM_pvp', 5, 12),
('zone_TM_pvp', 12, 12),
('zone_TM_pvp', 6, 18),
('zone_TM_pvp', 16, 5);

MERGE mineralconfigs c USING #MINS m
ON c.materialtype=m.material AND c.zoneid=(SELECT TOP 1 id FROM zones WHERE name=m.zoneName)
WHEN MATCHED
    THEN UPDATE SET
		maxNodes = m.numFields;



DROP TABLE IF EXISTS #REWARDS;
DROP TABLE IF EXISTS #MINS;
GO


PRINT N'08_Modulepropmodifier_delete_paintermask__2020_07_22';
USE [perpetuumsa]
GO

-----------------------------------------------------------------
--Target markers signal masking reduction should not be reduced by skill
--
--Date modified: 2020/07/22
-----------------------------------------------------------------

PRINT N'RECORD TO DELETE';
SELECT * FROM modulepropertymodifiers WHERE
categoryflags=(select top 1 value from categoryFlags where name='cf_target_painter') AND
basefield=(SELECT TOP 1 id FROM aggregatefields WHERE name='effect_stealth_strength_modifier') AND
modifierfield=(SELECT TOP 1 id FROM aggregatefields WHERE name='effect_enhancer_stealth_strength_modifier');

PRINT N'DELETE 1 modulepropertymodifiers';
--Delete single modulepropertymodifiers for target painters being modified by signal masker skill bonus field
DELETE FROM modulepropertymodifiers WHERE
categoryflags=(select top 1 value from categoryFlags where name='cf_target_painter') AND
basefield=(SELECT TOP 1 id FROM aggregatefields WHERE name='effect_stealth_strength_modifier') AND
modifierfield=(SELECT TOP 1 id FROM aggregatefields WHERE name='effect_enhancer_stealth_strength_modifier');

GO


PRINT N'09_teleportdescriptions_update__2020_08_02';
USE [perpetuumsa]
GO

--------------------------------------------------------
-- Teleports that perform in-zone jumps should use in-zonejump type
--
-- Date 2020/08/02
--------------------------------------------------------


--PRINT N'Teleports that should be type=1 for in-zone';
--SELECT * FROM teleportdescriptions 
--WHERE targetzone=sourcezone AND
--	type!=1

PRINT N'Update to type=1 WHERE targetzone=sourcezone';
UPDATE teleportdescriptions SET
	type=1
WHERE targetzone=sourcezone AND type!=1;
GO


PRINT N'10_def_npc_goblin_lancer__2020_08_16_16_14_34';
USE [perpetuumsa]
GO

-----------------------------------------------
-- Reduce range of Goblin Lancer to force closer to players
--
-- Date: 2020/08/16
-----------------------------------------------


DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_goblin_lancer' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_npc_goblin_lancer', quantity=1, attributeflags=1024, categoryflags=1423, options='', 
                note='', enabled=1, volume=0, mass=0, hidden=0, health=100, descriptiontoken='def_npc_goblin_lancer_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'falloff_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'optimal_range_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.9 WHERE id =  @aggvalueID;

GO


PRINT N'PATCH 18 APPLIED';