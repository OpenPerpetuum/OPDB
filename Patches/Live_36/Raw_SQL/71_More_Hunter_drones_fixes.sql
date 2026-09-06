USE perpetuumsa;
GO

-- ISSUE-042: Hunter Drone chassis definitions are missing two options that every other
-- player-deployed drone chassis already sets, both fixed here.
--
-- === Part 1: NPCs never aggro Hunter Drones (item 3) ===
--
-- Root cause: EntityDefaultOptions.Faction (src/Perpetuum/EntityFramework/EntityDefaultOptions.cs:151-159)
-- falls back to Faction.Niani when the `faction` key is absent from a definition's options string:
--     string typeString = _dictionary.GetOrDefault<string>("faction");
--     return typeString != null ? (Faction)Enum.Parse(typeof(Faction), typeString) : Faction.Niani;
-- def_standard_hunter_drone_pve and def_standard_hunter_drone_pvp both had options = NULL (no
-- faction key at all), so both silently resolve to Faction.Niani -- the very faction the PvE
-- variant is designed to hunt.
--
-- BodyPullThreatHelper.ProcessNpcThreats (src/Perpetuum/Zones/NpcSystem/AI/BodyPullThreatHelper.cs:149-156)
-- skips adding threat whenever the scanning NPC's faction equals the target's:
--     if (smartCreature.Behavior.Type != BehaviorType.RemoteControlledTurret &&
--         smartCreature.ED.Options.Faction == unit.ED.Options.Faction)
--     { return; }
-- so any Niani-faction NPC treats a Hunter Drone as friendly and never retaliates.
--
-- Every other player-deployed drone chassis already carries an explicit faction option -- verified
-- against def_nuimqol_assault_drone, def_pelistal_assault_drone, def_repair_support_drone,
-- def_mining_industrial_drone and def_harvesting_industrial_drone, all `#faction=sSyndicate`.
--
-- === Part 2: Recalled Hunter Drones never leave the zone (found investigating item 2) ===
--
-- RemoteControlledCreature.Scoop() (src/Perpetuum/Zones/RemoteControl/RemoteControlledCreature.cs:69-89)
-- only calls RemoveFromZone() inside `if (ED.Options.PackedTurretId != 0)`. EntityDefaultOptions.PackedTurretId
-- (EntityDefaultOptions.cs:130-134) defaults to 0 when the `packedTurretId` key is absent -- which it
-- was for both hunter chassis rows -- so a drone that successfully retreats to guard range and calls
-- Scoop() (HunterRetreatAI.cs:67) would silently do nothing and sit there forever.
--
-- This is NOT missing content: def_standard_hunter_drone_rcu_pve (8978) and
-- def_standard_hunter_drone_rcu_pvp (8979) are the same dual-purpose ammo items every other drone
-- type uses -- consumed on deploy AND returned to cargo on recall. Confirmed against the existing,
-- working pointer pair for def_nuimqol_assault_drone: chassis (8603) has `packedTurretId=i219c`
-- pointing at its ammo unit (8604), and that ammo unit has `turretId=i219b` pointing back at the
-- chassis -- a bidirectional pair. The hunter RCU items already carry the forward half
-- (`def_standard_hunter_drone_rcu_pve.turretId=i230f` -> chassis 8975,
-- `def_standard_hunter_drone_rcu_pvp.turretId=i2310` -> chassis 8976); only the chassis side's
-- `packedTurretId` pointing back was missing. 8978 = 0x2312, 8979 = 0x2313 (confirmed via SQL
-- Server's own FORMAT(), not hand arithmetic).
--
-- Safe to re-run: each WHERE guard makes its statement a no-op once the option is already present.

DECLARE @tplHeadDef INT = (SELECT definition FROM entitydefaults WHERE definitionname = 'def_standard_hunter_drone_head');
DECLARE @tplChassisDef INT = (SELECT definition FROM entitydefaults WHERE definitionname = 'def_standard_hunter_drone_chassis');
DECLARE @tplLegDef INT = (SELECT definition FROM entitydefaults WHERE definitionname = 'def_standard_hunter_drone_leg');
DECLARE @tplInventoryDef INT = (SELECT definition FROM entitydefaults WHERE definitionname = 'def_standard_hunter_drone_inventory');

UPDATE dbo.entitydefaults
SET options = '#head=n' + FORMAT(@tplHeadDef, 'd') +
              '#chassis=n' + FORMAT(@tplChassisDef, 'd') +
              '#leg=n' + FORMAT(@tplLegDef, 'd') +
              '#inventory=n' + FORMAT(@tplInventoryDef, 'd')
WHERE definitionname IN ('def_standard_hunter_drone_pve', 'def_standard_hunter_drone_pvp');

UPDATE dbo.entitydefaults
SET options = COALESCE(options, '') + '#faction=sSyndicate'
WHERE definitionname IN ('def_standard_hunter_drone_pve', 'def_standard_hunter_drone_pvp')
  AND (options IS NULL OR options NOT LIKE '%faction=%');

UPDATE dbo.entitydefaults
SET options = COALESCE(options, '') + '#packedTurretId=i' + FORMAT((SELECT definition FROM dbo.entitydefaults WHERE definitionname = 'def_standard_hunter_drone_rcu_pve'), 'x')
WHERE definitionname = 'def_standard_hunter_drone_pve'
  AND (options IS NULL OR options NOT LIKE '%packedTurretId=%');

UPDATE dbo.entitydefaults
SET options = COALESCE(options, '') + '#packedTurretId=i' + FORMAT((SELECT definition FROM dbo.entitydefaults WHERE definitionname = 'def_standard_hunter_drone_rcu_pvp'), 'x')
WHERE definitionname = 'def_standard_hunter_drone_pvp'
  AND (options IS NULL OR options NOT LIKE '%packedTurretId=%');

-- Verification: both rows should now show options containing both '#faction=sSyndicate' and
-- '#packedTurretId=i...' respectively.
-- SELECT definition, definitionname, options FROM dbo.entitydefaults
-- WHERE definitionname IN ('def_standard_hunter_drone_pve', 'def_standard_hunter_drone_pvp');

-- Manual: update ammo capacity on all hunter controllers to 5
UPDATE entitydefaults SET options = '#moduleFlag=i8#tier=$tierlevel_t4_pr#ammoCapacity=i5#ammoType=L8120a' WHERE definitionname = 'def_named3_hunter_remote_controller_pr'
UPDATE entitydefaults SET options = '#moduleFlag=i8#tier=$tierlevel_t4#ammoCapacity=i5#ammoType=L8120a' WHERE definitionname = 'def_named3_hunter_remote_controller'
UPDATE entitydefaults SET options = '#moduleFlag=i8#tier=$tierlevel_t3_pr#ammoCapacity=i5#ammoType=L8120a' WHERE definitionname = 'def_named2_hunter_remote_controller_pr'
UPDATE entitydefaults SET options = '#moduleFlag=i8#tier=$tierlevel_t3#ammoCapacity=i5#ammoType=L8120a' WHERE definitionname = 'def_named2_hunter_remote_controller'
UPDATE entitydefaults SET options = '#moduleFlag=i8#tier=$tierlevel_t2_pr#ammoCapacity=i5#ammoType=L8120a' WHERE definitionname = 'def_named1_hunter_remote_controller_pr'
UPDATE entitydefaults SET options = '#moduleFlag=i8#tier=$tierlevel_t2#ammoCapacity=i5#ammoType=L8120a' WHERE definitionname = 'def_named1_hunter_remote_controller'
UPDATE dbo.entitydefaults SET options = '#moduleFlag=i8#tier=$tierlevel_t4_pr#ammoCapacity=i5#ammoType=L8120a' WHERE definitionname = 'def_named3_hunter_remote_controller_pr';
UPDATE dbo.entitydefaults SET options = '#moduleFlag=i8#tier=$tierlevel_t4#ammoCapacity=i5#ammoType=L8120a' WHERE definitionname = 'def_named3_hunter_remote_controller';
UPDATE dbo.entitydefaults SET options = '#moduleFlag=i8#tier=$tierlevel_t3_pr#ammoCapacity=i5#ammoType=L8120a' WHERE definitionname = 'def_named2_hunter_remote_controller_pr';
UPDATE dbo.entitydefaults SET options = '#moduleFlag=i8#tier=$tierlevel_t3#ammoCapacity=i5#ammoType=L8120a' WHERE definitionname = 'def_named2_hunter_remote_controller';
UPDATE dbo.entitydefaults SET options = '#moduleFlag=i8#tier=$tierlevel_t2_pr#ammoCapacity=i5#ammoType=L8120a' WHERE definitionname = 'def_named1_hunter_remote_controller_pr';
UPDATE dbo.entitydefaults SET options = '#moduleFlag=i8#tier=$tierlevel_t2#ammoCapacity=i5#ammoType=L8120a' WHERE definitionname = 'def_named1_hunter_remote_controller';
UPDATE dbo.entitydefaults SET options = '#moduleFlag=i8#tier=$tierlevel_t1#ammoCapacity=i5#ammoType=L8120a' WHERE definitionname = 'def_standard_hunter_remote_controller';

GO