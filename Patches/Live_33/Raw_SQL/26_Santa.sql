USE perpetuumsa

GO

---- Create Santa, Deers and Elfs

DECLARE @robot INT
DECLARE @template INT
DECLARE @sourceDefinition INT
DECLARE @targetDefinition INT
DECLARE @speedModifier INT

SET @speedModifier = (SELECT TOP 1 id FROM aggregatefields WHERE name = 'speed_max_modifier')

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_hershfield_yagel_dps_l3_deer')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_hershfield_yagel_dps_l3_deer', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_hershfield_yagel_dps_l3_deer_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_yagel_dps_l3'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_yagel_dps_l3')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_hershfield_yagel_dps_l3_deer')

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

INSERT INTO aggregatevalues
SELECT @targetDefinition, field, value FROM aggregatevalues where definition = @sourceDefinition

INSERT INTO aggregatevalues (definition, field, value) VALUES
(@targetDefinition, @speedModifier, 1.5)

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'christmas_deer')
BEGIN
	INSERT INTO robottemplates (name, description, note) VALUES
	('christmas_deer', '#robot=iC1#head=i46#chassis=i47#leg=i48#headModules=[|m0=[|definition=i302|slot=i1]|m1=[|definition=i39E|slot=i2]|m2=[|definition=i39E|slot=i3]]#chassisModules=[|m0=[|definition=i35C|slot=i1|ammoDefinition=iFA|ammoQuantity=i14]|m1=[|definition=i35C|slot=i2|ammoDefinition=iFA|ammoQuantity=i14]|m2=[|definition=i35C|slot=i3|ammoDefinition=iFA|ammoQuantity=i14]|m3=[|definition=i35C|slot=i4|ammoDefinition=iFA|ammoQuantity=i14]]#legModules=[|m0=[|definition=i2B7|slot=i1]|m1=[|definition=i338|slot=i2|ammoDefinition=i298|ammoQuantity=iA]|m2=[|definition=i2D2|slot=i3]|m3=[|definition=i2B7|slot=i4]]', 'Christmas Deer')
END
ELSE
BEGIN
	UPDATE robottemplates SET description = '#robot=iC1#head=i46#chassis=i47#leg=i48#headModules=[|m0=[|definition=i302|slot=i1]|m1=[|definition=i39E|slot=i2]|m2=[|definition=i39E|slot=i3]]#chassisModules=[|m0=[|definition=i35C|slot=i1|ammoDefinition=iFA|ammoQuantity=i14]|m1=[|definition=i35C|slot=i2|ammoDefinition=iFA|ammoQuantity=i14]|m2=[|definition=i35C|slot=i3|ammoDefinition=iFA|ammoQuantity=i14]|m3=[|definition=i35C|slot=i4|ammoDefinition=iFA|ammoQuantity=i14]]#legModules=[|m0=[|definition=i2B7|slot=i1]|m1=[|definition=i338|slot=i2|ammoDefinition=i298|ammoQuantity=iA]|m2=[|definition=i2D2|slot=i3]|m3=[|definition=i2B7|slot=i4]]' WHERE name = 'christmas_deer'
END

SET @robot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_hershfield_yagel_dps_l3_deer')
SET @template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'christmas_deer')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @robot AND templateid = @template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@robot, @template, 0, 0, 'def_npc_hershfield_yagel_dps_l3_deer')
END

DELETE FROM npcloot WHERE definition = @targetDefinition

--

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_hershfield_sequer_basic_lindy_santa')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_hershfield_sequer_basic_lindy_santa', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_hershfield_sequer_basic_lindy_santa_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_sequer_basic_lindy'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_sequer_basic_lindy')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_hershfield_sequer_basic_lindy_santa')

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

INSERT INTO aggregatevalues
SELECT @targetDefinition, field, value FROM aggregatevalues where definition = @sourceDefinition

UPDATE aggregatevalues SET value = 1.5 WHERE definition = @targetDefinition AND field = @speedModifier

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'christmas_santa')
BEGIN
	INSERT INTO robottemplates (name, description, note) VALUES
	('christmas_santa', '#robot=i5CC#head=i5C8#chassis=i5C9#leg=i5CA#headModules=[|m0=[|definition=i2DE|slot=i1]|m1=[|definition=i2DE|slot=i2]|m2=[|definition=i2DE|slot=i3]|m3=[|definition=i2DE|slot=i4]]#chassisModules=[|m0=[|definition=i2EA|slot=i1]]#legModules=[|m0=[|definition=i2D5|slot=i1]|m1=[|definition=i57C|slot=i2]|m2=[|definition=i32F|slot=i3]|m3=[|definition=i338|slot=i4|ammoDefinition=i298|ammoQuantity=iA]]', 'Christmas Santa')
END
ELSE
BEGIN
	UPDATE robottemplates SET description = '#robot=i5CC#head=i5C8#chassis=i5C9#leg=i5CA#headModules=[|m0=[|definition=i2DE|slot=i1]|m1=[|definition=i2DE|slot=i2]|m2=[|definition=i2DE|slot=i3]|m3=[|definition=i2DE|slot=i4]]#chassisModules=[|m0=[|definition=i2EA|slot=i1]]#legModules=[|m0=[|definition=i2D5|slot=i1]|m1=[|definition=i57C|slot=i2]|m2=[|definition=i32F|slot=i3]|m3=[|definition=i338|slot=i4|ammoDefinition=i298|ammoQuantity=iA]]' WHERE name = 'christmas_santa'
END

SET @robot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_hershfield_sequer_basic_lindy_santa')
SET @template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'christmas_santa')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @robot AND templateid = @template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@robot, @template, 0, 0, 'def_npc_hershfield_sequer_basic_lindy_santa')
END

DELETE FROM npcloot WHERE definition = @targetDefinition

DECLARE @presents INT

SET @presents = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_anniversary_package')

INSERT INTO npcloot (definition, lootdefinition, quantity, probability, repackaged, dontdamage, minquantity) VALUES
(@robot, @presents, 20, 1, 0, 0, 5)

--

--

IF NOT EXISTS (SELECT 1 FROM entitydefaults WHERE definitionname = 'def_npc_hershfield_cameleon_shield_l3_elf')
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype)
	SELECT 'def_npc_hershfield_cameleon_shield_l3_elf', quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, 'def_npc_hershfield_cameleon_shield_l3_elf_desc', purchasable, tiertype FROM entitydefaults WHERE definitionname = 'def_npc_gamma_cameleon_shield_l3'
END

SET @sourceDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_gamma_cameleon_shield_l3')
SET @targetDefinition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_hershfield_cameleon_shield_l3_elf')

DELETE FROM aggregatevalues WHERE definition = @targetDefinition

INSERT INTO aggregatevalues
SELECT @targetDefinition, field, value FROM aggregatevalues where definition = @sourceDefinition

INSERT INTO aggregatevalues (definition, field, value) VALUES
(@targetDefinition, @speedModifier, 1.5)

DELETE FROM robottemplaterelation WHERE definition = @targetDefinition

IF NOT EXISTS (SELECT 1 FROM robottemplates WHERE name = 'christmas_elf')
BEGIN
	INSERT INTO robottemplates (name, description, note) VALUES
	('christmas_elf', '#robot=iC7#head=i58#chassis=i59#leg=i5A#headModules=[|m0=[|definition=i31A|slot=i1]|m1=[|definition=i31A|slot=i2]|m2=[|definition=i317|slot=i3]|m3=[|definition=i317|slot=i4]|m4=[|definition=i302|slot=i5]]#chassisModules=[|m0=[|definition=i2EA|slot=i1]|m1=[|definition=i2EA|slot=i2]|m2=[|definition=i2EA|slot=i3]]#legModules=[|m0=[|definition=i2D5|slot=i1]|m1=[|definition=i32F|slot=i2]|m2=[|definition=i2D2|slot=i3]]', 'Christmas Elf')
END
ELSE
BEGIN
	UPDATE robottemplates SET description = '#robot=iC7#head=i58#chassis=i59#leg=i5A#headModules=[|m0=[|definition=i31A|slot=i1]|m1=[|definition=i31A|slot=i2]|m2=[|definition=i317|slot=i3]|m3=[|definition=i317|slot=i4]|m4=[|definition=i302|slot=i5]]#chassisModules=[|m0=[|definition=i2EA|slot=i1]|m1=[|definition=i2EA|slot=i2]|m2=[|definition=i2EA|slot=i3]]#legModules=[|m0=[|definition=i2D5|slot=i1]|m1=[|definition=i32F|slot=i2]|m2=[|definition=i2D2|slot=i3]]' WHERE name = 'christmas_elf'
END

SET @robot = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_hershfield_cameleon_shield_l3_elf')
SET @template = (SELECT TOP 1 id FROM robottemplates WHERE name = 'christmas_elf')

IF NOT EXISTS (SELECT 1 FROM robottemplaterelation WHERE definition = @robot AND templateid = @template)
BEGIN
	INSERT INTO robottemplaterelation (definition, templateid, itemscoresum, raceid, note) VALUES
	(@robot, @template, 0, 0, 'def_npc_hershfield_cameleon_shield_l3_elf')
END

DELETE FROM npcloot WHERE definition = @targetDefinition

GO

---- Put them on Hershfield

DECLARE @spawnid INT
DECLARE @presenceid INT
DECLARE @definition INT
DECLARE @templateid INT
DECLARE @flockId INT

SET @spawnid = (SELECT TOP 1 spawnid FROM zones WHERE name = 'zone_TM_pve')

--- roamers 1

IF NOT EXISTS (SELECT 1 FROM npcpresence WHERE name = 'roamer_santa_z8' AND spawnid = @spawnid)
BEGIN
	INSERT INTO npcpresence (name, topx, topy, bottomx, bottomy, note, spawnid, enabled, roaming, roamingrespawnseconds, presencetype, maxrandomflock, randomcenterx, randomcentery, randomradius, dynamiclifetime, isbodypull, isrespawnallowed, safebodypull, izgroupid, growthseconds) VALUES
	('roamer_santa_z8', 10, 10, 2038, 2038, 'Santa on Hershfield', @spawnid, 1, 1, 7200, 5, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL)
END
ELSE BEGIN
	UPDATE npcpresence SET enabled = 1, presencetype = 5 WHERE name = 'roamer_santa_z8'
END

SET @presenceid = (SELECT TOP 1 id FROM npcpresence WHERE name = 'roamer_santa_z8')

----

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_hershfield_cameleon_shield_l3_elf')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'roamer_santa_z8_cameleon_shield_l3_elf')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_santa_z8_cameleon_shield_l3_elf', @presenceid, 4, @definition, 0, 0, 0, 10, 7200, 0, 50, 'Santa on Hershfield', 0.9, 1, 1, 1, 0)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_hershfield_yagel_dps_l3_deer')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'roamer_santa_z8_yagel_dps_l3_deer')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_santa_z8_yagel_dps_l3_deer', @presenceid, 8, @definition, 0, 0, 0, 10, 7200, 0, 50, 'Santa on Hershfield', 0.9, 1, 1, 1, 0)
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_hershfield_sequer_basic_lindy_santa')

IF NOT EXISTS (SELECT 1 FROM npcflock WHERE name = 'roamer_santa_z8_sequer_basic_lindy_santa')
BEGIN
INSERT INTO npcflock ([name], presenceid, flockmembercount, [definition], spawnoriginX, spawnoriginY, spawnrangeMin, spawnrangeMax, respawnseconds, totalspawncount, homerange, note, respawnmultiplierlow, [enabled], iscallforhelp, behaviorType, npcSpecialType) VALUES
	('roamer_santa_z8_sequer_basic_lindy_santa', @presenceid, 1, @definition, 0, 0, 0, 10, 7200, 0, 50, 'Santa on Hershfield', 0.9, 1, 1, 1, 0)
END

SET @flockId = (SELECT TOP 1 id FROM npcflock WHERE name = 'roamer_santa_z8_sequer_basic_lindy_santa')

IF NOT EXISTS (SELECT 1 FROM npcbossinfo WHERE flockid = @flockid)
BEGIN
	INSERT INTO npcbossinfo (flockid, respawnNoiseFactor, lootSplitFlag, outpostEID, stabilityPts, overrideRelations, customDeathMessage, customAggressMessage, riftConfigId, isAnnounced) VALUES
	(@flockId, 0.15, 1, NULL, NULL, 0, 'Were you any good, Children of Earth?', 'Ho-Ho-Ho, Network Crackers', NULL, 0)
END

GO

-- Paint bots

DECLARE @definition INT

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_hershfield_yagel_dps_l3_deer')

IF NOT EXISTS (SELECT 1 FROM definitionconfig WHERE definition = @definition)
BEGIN
	INSERT INTO definitionconfig (definition, tint) VALUES (@definition, '#fb6701')
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_hershfield_cameleon_shield_l3_elf')

IF NOT EXISTS (SELECT 1 FROM definitionconfig WHERE definition = @definition)
BEGIN
	INSERT INTO definitionconfig (definition, tint) VALUES (@definition, '#013301')
END

SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_npc_hershfield_sequer_basic_lindy_santa')

IF NOT EXISTS (SELECT 1 FROM definitionconfig WHERE definition = @definition)
BEGIN
	INSERT INTO definitionconfig (definition, tint) VALUES (@definition, '#fb0101')
END

GO

---- Increase missions level for daoden

DECLARE @zoneid INT

SET @zoneid = (SELECT TOP 1 id FROM zones WHERE name = 'zone_ASI')

UPDATE missionlocations SET maxmissionlevel = 8 WHERE zoneid = @zoneid

GO