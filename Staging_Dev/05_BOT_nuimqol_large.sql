USE [perpetuumsa]
GO
--------------------------------------------------------------
--Big Bot makin script
--1 - Create robotcomponents
--2 - Create bot definition (with parts - creates associations for bonuses)
--3 - Add stats (aggvalues)
--4 - Add bonuses
--5 - Add required skills to pilot
--6 - Add RobotTemplate (empty) for robot parts - creates associations for stats and rendering definitions TODO
--7 - Create RobotTemplateRelation to relate bot def to template TODO
--------------------------------------------------------------

DECLARE @largeBotCF bigint;
SET @largeBotCF = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_walkers');
UPDATE categoryFlags SET
	hidden=0
WHERE value=@largeBotCF;

--MAKE PARTS OF ROBOT, THEN ROBOT DEFINITION
DECLARE @botName varchar(100);
DECLARE @botDef int;
DECLARE @botDefHex VARCHAR(50);
DECLARE @headName varchar(100);
DECLARE @headDef int;
DECLARE @headDefHex VARCHAR(50);
DECLARE @chassisName varchar(100);
DECLARE @chassisDef int;
DECLARE @chassisDefHex VARCHAR(50);
DECLARE @legName varchar(100);
DECLARE @legDef int;
DECLARE @legDefHex VARCHAR(50);
DECLARE @tintColor VARCHAR(50);

DECLARE @PRbotName varchar(100);
DECLARE @PRbotDef int;

SET @headName = 'def_felos_bot_head';
SET @headDef = 6005;
SET @chassisName = 'def_felos_bot_chassis';
SET @chassisDef = 6006;
SET @legName = 'def_felos_bot_leg';
SET @legDef = 6007;
SET @botName = 'def_felos_bot';
SET @botDef = 6008;
SET @tintColor ='#011D39';

SET @PRbotName = 'def_felos_bot_pr';
SET @PRbotDef = 6009;

DECLARE @headMass int;
DECLARE @chassisMass int;
DECLARE @legMass int;
SET @headMass = 3000;
SET @chassisMass = 75000;
SET @legMass = 12000;


PRINT N'INTEGRITY CHECK: ALL NAMED ENTITYDEFAULTS WITH SPECIFIED IDs MUST BE INSERTED WITH THE SPECIFIED ID';
IF EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE @botDef=definition AND @botName!=definitionname)
OR EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE @headDef=definition AND @headName!=definitionname)
OR EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE @chassisDef=definition AND @chassisName!=definitionname)
OR EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE @legDef=definition AND @legName!=definitionname)
OR EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE @PRbotDef=definition AND @PRbotName!=definitionname)
BEGIN
	PRINT N'DEFINITION INTEGRITY CHECK FAILED! SKIPPING ALL EXECUTION IN THIS SCRIPT';
	SET NOEXEC ON;
END


PRINT N'DEFINE HEAD';
IF EXISTS (SELECT TOP 1 definition from dbo.entitydefaults WHERE definitionname=@headName)
BEGIN
	UPDATE entitydefaults SET
		categoryflags = 328016,
		options = '#height=f0.2#slotFlags=48,8,8,8',
		volume = 3,
		mass = @headMass
	WHERE definitionname=@headName;
END
ELSE
BEGIN
	SET IDENTITY_INSERT entitydefaults ON;
	INSERT INTO entitydefaults (definition, definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
	VALUES 
	(@headDef, @headName, 1, 1024, 328016, '#height=f0.2#slotFlags=48,8,8,8', '', 1, 3, @headMass, 1, 100, 'bot_head_desc', 0, 0, 0); 
	SET IDENTITY_INSERT entitydefaults OFF;
END

PRINT N'DEFINE CHASSIS';

IF EXISTS (SELECT TOP 1 definition from dbo.entitydefaults WHERE definitionname=@chassisName)
BEGIN
	UPDATE entitydefaults SET
		categoryflags = 328272,
		options = '#height=f2#slotFlags=4111,111,111,111,111,111',
		volume = 20,
		mass = @chassisMass
	WHERE definitionname=@chassisName;
END
ELSE
BEGIN
	SET IDENTITY_INSERT entitydefaults ON;
	INSERT INTO entitydefaults (definition, definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
	VALUES 
	(@chassisDef, @chassisName, 1, 1024, 328272, '#height=f2#slotFlags=4111,111,111,111,111,111', '', 1, 20, @chassisMass, 1, 100, 'bot_chassis_desc', 0, 0, 0); 
	SET IDENTITY_INSERT entitydefaults OFF;
END

PRINT N'DEFINE LEGS';

IF EXISTS (SELECT TOP 1 definition from dbo.entitydefaults WHERE definitionname=@legName)
BEGIN
	UPDATE entitydefaults SET
		categoryflags = 328528,
		options = '#height=f1.1#slotFlags=420,20,20,20,20',
		volume = 20,
		mass = @legMass
	WHERE definitionname=@legName;
END
ELSE
BEGIN
	SET IDENTITY_INSERT entitydefaults ON;
	INSERT INTO entitydefaults (definition, definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
	VALUES 
	(@legDef, @legName, 1, 1024, 328528, '#height=f1.1#slotFlags=420,20,20,20,20', '', 1, 20, @legMass, 1, 100, 'bot_leg_desc', 0, 0, 0); 
	SET IDENTITY_INSERT entitydefaults OFF;
END


SET @headDef = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@headName);
SET @headDefHex = (SELECT dbo.ToHex(@headDef));
SET @chassisDef = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@chassisName);
SET @chassisDefHex = (SELECT dbo.ToHex(@chassisDef));
SET @legDef = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@legName);
SET @legDefHex = (SELECT dbo.ToHex(@legDef));

PRINT N'DEFINE BOT';

--BOT DEFINITION
IF EXISTS (SELECT TOP 1 definition from dbo.entitydefaults WHERE definitionname=@botName)
BEGIN
	UPDATE entitydefaults SET
		attributeflags=0,
		categoryflags = @largeBotCF,
		options = '#head=i'+@headDefHex+'#chassis=i'+@chassisDefHex+'#leg=i'+@legDefHex+'#container=i14c',
		volume = 22.5,
		mass = 0,
		descriptiontoken = @botName+'_desc'
	WHERE definitionname=@botName;
END
ELSE
BEGIN
	SET IDENTITY_INSERT entitydefaults ON;
	INSERT INTO entitydefaults (definition, definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
	VALUES 
	(@botDef, @botName, 1, 0, @largeBotCF, '#head=i'+@headDefHex+'#chassis=i'+@chassisDefHex+'#leg=i'+@legDefHex+'#container=i14c', '', 1, 22.5, 0, 0, 100, @botName+'_desc', 1, 0, 0); 
	SET IDENTITY_INSERT entitydefaults OFF;
END

--PROTOYPE BOT DEFINITION
IF EXISTS (SELECT TOP 1 definition from dbo.entitydefaults WHERE definitionname=@PRbotName)
BEGIN
	UPDATE entitydefaults SET
		attributeflags=0,
		categoryflags = @largeBotCF,
		options = '#head=i'+@headDefHex+'#chassis=i'+@chassisDefHex+'#leg=i'+@legDefHex+'#container=i14c',
		volume = 22.5,
		mass = 0,
		descriptiontoken = @PRbotName+'_desc'
	WHERE definitionname=@PRbotName;
END
ELSE
BEGIN
	SET IDENTITY_INSERT entitydefaults ON;
	INSERT INTO entitydefaults (definition, definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
	VALUES 
	(@PRbotDef, @PRbotName, 1, 0, @largeBotCF, '#head=i'+@headDefHex+'#chassis=i'+@chassisDefHex+'#leg=i'+@legDefHex+'#container=i14c', '', 1, 22.5, 0, 0, 100, @PRbotName+'_desc', 1, 0, 0);
	SET IDENTITY_INSERT entitydefaults OFF;
END

SET @botDef = (SELECT TOP 1 definition from dbo.entitydefaults WHERE definitionname=@botName);
SET @botDefHex = (SELECT dbo.ToHex(@botDef));


PRINT N'DEFINE ROBOTTEMPLATE';
DECLARE @botTemplateName VARCHAR(100);
SET @botTemplateName = @botName+'_template';

IF EXISTS (SELECT TOP 1 id FROM robottemplates WHERE name=@botTemplateName)
BEGIN
	UPDATE robottemplates SET
	description = '#robot=i'+@botDefHex+'#head=i'+@headDefHex+'#chassis=i'+@chassisDefHex+'#leg=i'+@legDefHex+'#container=i1148#headModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]|m2=[|definition=i0|slot=i3]|m3=[|definition=i0|slot=i4]]#chassisModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]|m2=[|definition=i0|slot=i3]|m3=[|definition=i0|slot=i4]|m4=[|definition=i0|slot=i5]|m5=[|definition=i0|slot=i6]]#legModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]|m2=[|definition=i0|slot=i3]|m3=[|definition=i0|slot=i4]]'
	WHERE name=@botTemplateName;
END
ELSE
BEGIN
	INSERT INTO robottemplates ([name], [description], [note]) VALUES 
	(@botTemplateName,
	'#robot=i'+@botDefHex+'#head=i'+@headDefHex+'#chassis=i'+@chassisDefHex+'#leg=i'+@legDefHex+'#container=i1148#headModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]|m2=[|definition=i0|slot=i3]|m3=[|definition=i0|slot=i4]]#chassisModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]|m2=[|definition=i0|slot=i3]|m3=[|definition=i0|slot=i4]|m4=[|definition=i0|slot=i5]|m5=[|definition=i0|slot=i6]]#legModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]|m2=[|definition=i0|slot=i3]|m3=[|definition=i0|slot=i4]]',
	'new large robot template - empty');
END

PRINT N'DEFINE ROBOTTEMPLATERELATION';
IF EXISTS (SELECT TOP 1 definition FROM [robottemplaterelation] WHERE definition=@botDef)
BEGIN
	UPDATE [robottemplaterelation] SET
		templateid = (SELECT TOP 1 id FROM robottemplates WHERE name=@botTemplateName),
		itemscoresum = 0,
		raceid = 1,
		missionlevel = NULL,
		missionleveloverride = NULL,
		killep = 0
	WHERE definition=@botDef;
END
ELSE
BEGIN
	INSERT INTO [dbo].[robottemplaterelation]([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
	VALUES
	(@botDef,(SELECT TOP 1 id FROM robottemplates WHERE name=@botTemplateName),0,1,NULL,NULL,0,'new large bot relation - empty');
END

PRINT N'DEFINE ROBOTTEMPLATERELATION FOR PROTO';
IF EXISTS (SELECT TOP 1 definition FROM [robottemplaterelation] WHERE definition=@PRbotDef)
BEGIN
	UPDATE [robottemplaterelation] SET
		templateid = (SELECT TOP 1 id FROM robottemplates WHERE name=@botTemplateName),
		itemscoresum = 0,
		raceid = 1,
		missionlevel = NULL,
		missionleveloverride = NULL,
		killep = 0
	WHERE definition=@PRbotDef;
END
ELSE
BEGIN
	INSERT INTO [dbo].[robottemplaterelation]([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
	VALUES
	(@PRbotDef,(SELECT TOP 1 id FROM robottemplates WHERE name=@botTemplateName),0,1,NULL,NULL,0,'new large bot relation - empty');
END

--BOT STATS

DROP TABLE IF EXISTS #BOTSTATS
CREATE TABLE #BOTSTATS 
(
	partDef int,
	name varchar(100),
	value float,
)

INSERT INTO #BOTSTATS (partDef, name, value) VALUES
(@headDef, 'cpu_max', 1750),
(@headDef, 'locked_targets_max', 8),
(@headDef, 'locking_range', 42.9),
(@headDef, 'locking_time', 15000),
(@headDef, 'sensor_strength', 95),
(@headDef, 'blob_emission', 25),
(@headDef, 'blob_emission_radius', 35),
(@headDef, 'blob_level_low', 75),
(@headDef, 'blob_level_high', 400),
(@headDef, 'detection_strength', 55),
(@headDef, 'stealth_strength', 55),
(@chassisDef, 'ammo_reload_time', 15000),
(@chassisDef, 'armor_max', 6000),
(@chassisDef, 'core_max', 5900),
(@chassisDef, 'core_recharge_time', 1200),
(@chassisDef, 'powergrid_max', 5160),
(@chassisDef, 'resist_chemical', 30),
(@chassisDef, 'resist_explosive', 150),
(@chassisDef, 'resist_kinetic', 45),
(@chassisDef, 'resist_thermal', 10),
(@chassisDef, 'signature_radius', 30),
(@chassisDef, 'missile_miss', 0.9),
(@chassisDef, 'reactor_radiation', 15),
(@legDef, 'slope', 4),
(@legDef, 'speed_max', 1.833);

PRINT N'DELETE BOT STATS';
DELETE FROM aggregatevalues WHERE definition in (SELECT DISTINCT partDef FROM #BOTSTATS);


PRINT N'INSERT BOT STATS';
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value])
SELECT 
	#BOTSTATS.partDef, 
	(SELECT TOP 1 id FROM aggregatefields WHERE #BOTSTATS.name=aggregatefields.name),
	#BOTSTATS.value 
FROM #BOTSTATS


DECLARE @extensionName varchar(100);
DECLARE @extensionID int;

SET @extensionName = 'ext_assault_unit_piloting';
SET @extensionID = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname=@extensionName);

DECLARE @factionPilotExt int;
SET @factionPilotExt = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname='ext_nuimqol_specialist');

DECLARE @combatSpecExt int;
SET @combatSpecExt = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname='ext_combat_specialist');


PRINT N'UNHIDE ANY NEW EXTENSIONS USED FOR BOT BONUSES';
UPDATE extensions SET active=1, hidden=0 WHERE extensionid=@extensionID;

DROP TABLE IF EXISTS #BOTBONUSES;
CREATE TABLE #BOTBONUSES 
(
	partDef int,
	extID int,
	name varchar(100),
	bonus float,
);
INSERT INTO #BOTBONUSES (partDef, extID, name, bonus) VALUES
(@chassisDef, @extensionID, 'cpu_usage_large_railgun_modifier', 0.03),
(@chassisDef, @extensionID, 'powergrid_usage_large_railgun_modifier', 0.03),
(@chassisDef, @extensionID, 'damage_large_railgun_modifier', 0.05),
(@chassisDef, @combatSpecExt, 'massiveness', 0.02),
(@chassisDef, @combatSpecExt, 'core_usage_railgun_modifier', -0.02),
(@chassisDef, @factionPilotExt, 'armor_repair_amount_modifier', 0.05);

PRINT N'DELETE BOT BONUSES';
DELETE FROM chassisbonus WHERE definition in (SELECT DISTINCT partDef FROM #BOTBONUSES);

PRINT N'INSERT BOT BONUSES';
INSERT INTO chassisbonus (definition, extension, bonus, note, targetpropertyID, effectenhancer)
SELECT b.partDef, b.extID, b.bonus, 'Large bot bonus', (SELECT TOP 1 id FROM aggregatefields WHERE name=b.name), 0 FROM #BOTBONUSES AS b;

--DELETE and REINSERT
PRINT N'DELETE BOT REQ-EXTENSIONS';
DELETE FROM enablerextensions WHERE definition=@botDef;
PRINT N'INSERT BOT REQ-EXTENSIONS';
INSERT INTO [dbo].[enablerextensions] ([definition],[extensionid],[extensionlevel]) VALUES
(@botDef, @extensionID, 4),
(@botDef, (SELECT TOP 1 extensionid FROM extensions WHERE extensionname='ext_high_tech_specialist'), 8),
(@botDef, @factionPilotExt, 10);

PRINT N'DELETE PROTO-BOT REQ-EXTENSIONS';
DELETE FROM enablerextensions WHERE definition=@PRbotDef;
PRINT N'INSERT PROTO-BOT REQ-EXTENSIONS';
INSERT INTO [dbo].[enablerextensions] ([definition],[extensionid],[extensionlevel]) VALUES
(@PRbotDef, @extensionID, 4),
(@PRbotDef, (SELECT TOP 1 extensionid FROM extensions WHERE extensionname='ext_high_tech_specialist'), 8),
(@PRbotDef, @factionPilotExt, 10);


PRINT N'DEFINE colors';
IF EXISTS (SELECT TOP 1 definition FROM [definitionconfig] WHERE definition=@botDef)
BEGIN
	UPDATE [definitionconfig] SET
		tint=@tintColor
	WHERE definition in (@headDef, @chassisDef, @legDef, @botDef, @PRbotDef);
END
ELSE
BEGIN
	INSERT INTO [dbo].[definitionconfig]
		([definition],[tint],[note])
	VALUES
		(@headDef, @tintColor,'Large bot native color'),
		(@chassisDef, @tintColor,'Large bot native color'),
		(@legDef, @tintColor,'Large bot native color'),
		(@botDef, @tintColor,'Large bot native color'),
		(@PRbotDef, @tintColor,'Large bot native color');
END


DROP TABLE IF EXISTS #BOTSTATS;
DROP TABLE IF EXISTS #BOTBONUSES;
SET NOEXEC OFF;
PRINT N'LARGE NUIMQOL BOT INSERT';
GO
