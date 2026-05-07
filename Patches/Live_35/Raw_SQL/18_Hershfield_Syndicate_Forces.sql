-- Perpetuum.AdminTool generated script
-- Generated: 2026-05-07 04:46:41 UTC
-- Author: devours@internet.ru

SET XACT_ABORT ON;
BEGIN TRANSACTION;

-- [1] entitydefaults: insert (def_syndicate_forces_locust_main_combat_bot) + 15 stat(s) — id auto-assigned via @new_def_c91060d8
INSERT INTO entitydefaults (definitionName, descriptionToken, categoryflags, attributeflags, mass, volume, health, quantity, hidden, purchasable, tiertype, tierlevel, options, enabled) VALUES (N'def_syndicate_forces_locust_main_combat_bot', N'def_syndicate_forces_locust_main_combat_bot_desc', 143, 1024, 0, 0, 100, 1, 0, 0, NULL, NULL, N'#faction=SSyndicate', 1);
DECLARE @new_def_c91060d8 INT = SCOPE_IDENTITY();

DELETE FROM aggregatevalues WHERE definition = @new_def_c91060d8

DECLARE @field INT

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'armor_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @new_def_c91060d8 AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@new_def_c91060d8, @field, 1.3)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 3 WHERE definition = @new_def_c91060d8 AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @new_def_c91060d8 AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@new_def_c91060d8, @field, 1.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 3 WHERE definition = @new_def_c91060d8 AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'core_recharge_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @new_def_c91060d8 AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@new_def_c91060d8, @field, 1)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1 WHERE definition = @new_def_c91060d8 AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'cpu_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @new_def_c91060d8 AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@new_def_c91060d8, @field, 2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2 WHERE definition = @new_def_c91060d8 AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'damage_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @new_def_c91060d8 AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@new_def_c91060d8, @field, 1.2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.2 WHERE definition = @new_def_c91060d8 AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'falloff_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @new_def_c91060d8 AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@new_def_c91060d8, @field, 1.2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.2 WHERE definition = @new_def_c91060d8 AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @new_def_c91060d8 AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@new_def_c91060d8, @field, 1.5)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.5 WHERE definition = @new_def_c91060d8 AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'locking_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @new_def_c91060d8 AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@new_def_c91060d8, @field, 0.9)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.9 WHERE definition = @new_def_c91060d8 AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'optimal_range_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @new_def_c91060d8 AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@new_def_c91060d8, @field, 1.2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1.2 WHERE definition = @new_def_c91060d8 AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'powergrid_max_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @new_def_c91060d8 AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@new_def_c91060d8, @field, 2)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 2 WHERE definition = @new_def_c91060d8 AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'signature_radius')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @new_def_c91060d8 AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@new_def_c91060d8, @field, -0.25)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = -0.25 WHERE definition = @new_def_c91060d8 AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'turret_cycle_time_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @new_def_c91060d8 AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@new_def_c91060d8, @field, 0.9)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.9 WHERE definition = @new_def_c91060d8 AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission_radius_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @new_def_c91060d8 AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@new_def_c91060d8, @field, 0.4)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 0.4 WHERE definition = @new_def_c91060d8 AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'blob_emission_modifier_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @new_def_c91060d8 AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@new_def_c91060d8, @field, 1)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 1 WHERE definition = @new_def_c91060d8 AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'detection_strength_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @new_def_c91060d8 AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@new_def_c91060d8, @field, 25)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = 25 WHERE definition = @new_def_c91060d8 AND field = @field
END

SET @field = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'stealth_strength_modifier')

IF NOT EXISTS (SELECT 1 FROM aggregatevalues WHERE definition = @new_def_c91060d8 AND field = @field)
BEGIN
	INSERT INTO aggregatevalues (definition, field, value) VALUES (@new_def_c91060d8, @field, -10)
END
ELSE
BEGIN
	UPDATE aggregatevalues SET value = -10 WHERE definition = @new_def_c91060d8 AND field = @field
END

-- [2] robottemplates: insert (Locust_Main_Combat) — id auto-assigned via @new_tmpl_f7c1f420
INSERT INTO robottemplates (name, description, note) VALUES (N'Locust_Main_Combat', N'#robot=i1588#head=i1589#chassis=i158a#leg=i158b#container=i148#headModules=[|m0=[|definition=i302|slot=i1]|m1=[|definition=i314|slot=i2]|m2=[|definition=i31d|slot=i3]|m3=[|definition=i3a7|slot=i4]|m4=[|definition=i3a7|slot=i5]]#chassisModules=[|m0=[|definition=i34a|slot=i1|ammoDefinition=i984|ammoQuantity=ic8]|m1=[|definition=i34a|slot=i2|ammoDefinition=i984|ammoQuantity=ic8]|m2=[|definition=i34a|slot=i3|ammoDefinition=i984|ammoQuantity=ic8]|m3=[|definition=i34a|slot=i4|ammoDefinition=i984|ammoQuantity=ic8]|m4=[|definition=i34a|slot=i5|ammoDefinition=i984|ammoQuantity=ic8]]#legModules=[|m0=[|definition=i2b7|slot=i1]|m1=[|definition=i3bc|slot=i2]|m2=[|definition=i3bc|slot=i3]|m3=[|definition=i2ae|slot=i4]]', N'Syndicate Forces Main Combat Locust');
DECLARE @new_tmpl_f7c1f420 INT = SCOPE_IDENTITY();

DELETE FROM robottemplaterelation WHERE definition = @new_def_c91060d8

INSERT INTO robottemplaterelation (definition, templateid, raceid, missionlevel, missionleveloverride, killep, note) VALUES
(@new_def_c91060d8, @new_tmpl_f7c1f420, 0, NULL, NULL, 15, 'def_npc_hersh_locust_main_combat')

-- [1] npcpresence: insert 'syndicate_N01_z8' (spawn 13)
INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES (N'syndicate_N01_z8', 640, 380, 1405, 1150, N'hershfield syndicate forces 1', 13, 1, 1, 900, 5, NULL, 945, 790, 350, NULL, 1, 1, 1, NULL, NULL)
;

-- [1] npcflock: insert 'syndicate_N01_z8_argano_main_support' (presence 2511, def 8941)
INSERT INTO npcflock (name, presenceid, flockmembercount, definition, spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, enabled, iscallforhelp, behaviorType, npcSpecialType) VALUES (N'syndicate_N01_z8_argano_main_support', 2511, 2, 8941, 0, 0, 0, 10, 7200, 0, 50, N'hershfield npc', 0.9, 1, 1, 1, 0)
;

-- [2] npcflock: insert 'syndicate_N01_z8_locust_main_combat' (presence 2511, def 8957)
INSERT INTO npcflock (name, presenceid, flockmembercount, definition, spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, enabled, iscallforhelp, behaviorType, npcSpecialType) VALUES (N'syndicate_N01_z8_locust_main_combat', 2511, 3, 8957, 0, 0, 0, 10, 7200, 0, 50, N'hershfield npc', 0.9, 1, 1, 1, 0)
;

-- [1] npcpresence: insert 'syndicate_N02_z8' (spawn 13)
INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES (N'syndicate_N02_z8', 640, 380, 1405, 1150, N'hershfield syndicate forces 2', 13, 1, 1, 900, 5, NULL, 945, 790, 350, NULL, 1, 1, 1, NULL, NULL)
;

-- [1] npcflock: insert 'syndicate_N01_z8_argano_main_support' (presence 2511, def 8941)
INSERT INTO npcflock (name, presenceid, flockmembercount, definition, spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, enabled, iscallforhelp, behaviorType, npcSpecialType) VALUES (N'syndicate_N02_z8_argano_main_support', 2511, 2, 8941, 0, 0, 0, 10, 7200, 0, 50, N'hershfield npc', 0.9, 1, 1, 1, 0)
;

-- [2] npcflock: insert 'syndicate_N01_z8_locust_main_combat' (presence 2511, def 8957)
INSERT INTO npcflock (name, presenceid, flockmembercount, definition, spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, enabled, iscallforhelp, behaviorType, npcSpecialType) VALUES (N'syndicate_N02_z8_locust_main_combat', 2511, 3, 8957, 0, 0, 0, 10, 7200, 0, 50, N'hershfield npc', 0.9, 1, 1, 1, 0)
;

COMMIT TRANSACTION;
