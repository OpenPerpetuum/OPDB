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
('def_vektor_chassis', 'ext_syndicate_combat_specialist', 0.5, @toxicDamageName+'_modifier'),
('def_locust_chassis', 'ext_syndicate_combat_specialist', 0.5, @toxicDamageName+'_modifier'),
('def_echelon_chassis', 'ext_syndicate_combat_specialist', 0.5, @toxicDamageName+'_modifier'),
('def_legatus_chassis', 'ext_syndicate_combat_specialist', 0.5, @toxicDamageName+'_modifier');


DROP TABLE IF EXISTS #TOXICDMG;
CREATE TABLE #TOXICDMG(
	ammoName VARCHAR(100),
	dmg INT
);

INSERT INTO #TOXICDMG(ammoName, dmg) VALUES
('def_ammo_large_projectile_a', 36),
('def_ammo_large_projectile_b', 36),
('def_ammo_large_projectile_c', 36),
('def_ammo_large_projectile_d', 36),
('def_ammo_medium_projectile_a', 24),
('def_ammo_medium_projectile_b', 24),
('def_ammo_medium_projectile_c', 24),
('def_ammo_medium_projectile_d', 24),
('def_ammo_medium_projectile_rewa', 24),
('def_ammo_medium_projectile_rewb', 24),
('def_ammo_small_projectile_a', 12),
('def_ammo_small_projectile_b', 12),
('def_ammo_small_projectile_c', 12),
('def_ammo_small_projectile_d', 12),
('def_ammo_small_projectile_rewa', 12),
('def_ammo_small_projectile_rewb', 12);



DROP TABLE IF EXISTS #TOXICBOMB;
CREATE TABLE #TOXICBOMB(
	bombName VARCHAR(100),
	dmg INT
);

INSERT INTO #TOXICBOMB(bombName, dmg) VALUES
('def_area_bomb', 1000),
('def_area_bomb_capsule', 1000),
('def_plant_bomb', 3000),
('def_plant_bomb_capsule', 3000);



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