USE [perpetuumsa]
GO

-------------------------------------------------------------
-- STRONGHOLD ZONE INSERTION SCRIPT
-- Runs all necesary record insertions for basic empty zone
-- Assumes layers valid and correct size for zone params
-------------------------------------------------------------

--Zone columns
DECLARE @zoneId INT;
SET @zoneId=70; --Zone ID!  Must be same as layer numbers!

DECLARE @size INT;
SET @size = 512; --Double check this!

DECLARE @x INT;
DECLARE @y INT;
DECLARE @zoneName VARCHAR(50);
DECLARE @zoneDesc VARCHAR(50);
DECLARE @note VARCHAR(2048);
DECLARE @fertility INT;
DECLARE @zoneplugin NVARCHAR(50);
DECLARE @zoneip NVARCHAR(50);
DECLARE @zoneport INT;
DECLARE @isInstance BIT;
DECLARE @enabled BIT;
DECLARE @spawnId INT;
DECLARE @plantRuleset INT;
DECLARE @protected BIT;
DECLARE @raceId INT;
DECLARE @width INT;
DECLARE @height INT;
DECLARE @terraformable BIT;
DECLARE @zoneType INT;
DECLARE @sparkCost INT;
DECLARE @maxDockingBase INT;
DECLARE @sleeping BIT;
DECLARE @plantAltitudeScale FLOAT;
DECLARE @host VARCHAR(50);
DECLARE @active BIT;
--NPCSpawn for zone
DECLARE @spawnName VARCHAR(50);
DECLARE @spawnDesc VARCHAR(50);
DECLARE @spawnNote NVARCHAR(2000);
--Entity columns for zone storage entity
DECLARE @eid BIGINT;
DECLARE @definition INT;
DECLARE @ename VARCHAR(128);

--Insert NPCSpawn first for npcspawnid
SET @spawnName = 'zone_strghld_' + CONVERT(varchar(10), @zoneId) + '_spawn';
SET @spawnDesc = 'zone_strghld_' + CONVERT(varchar(10), @zoneId) + '_spawn';
SET @spawnNote = 'Stronghold spawn for NPC base ' + CONVERT(varchar(10), @zoneId);

PRINT N'INSERTING/UPDATING NPCSPAWN TABLE';
IF EXISTS (SELECT TOP 1 id FROM npcspawn WHERE name=@spawnName)
BEGIN
	UPDATE npcspawn SET
		description=@spawnDesc,
		note=@spawnNote
	WHERE name=@spawnName;
END
ELSE
BEGIN
	INSERT INTO [dbo].[npcspawn] ([name],[description],[note])
	VALUES (@spawnName, @spawnDesc, @spawnNote);
END

--SET ZONE PARAMETERS

SET @x=20000;
SET @y=20000;
SET @zoneName = 'zone_strghld_' + CONVERT(varchar(10), @zoneId);
SET @zoneDesc = @zoneName + '_desc';
SET @note = 'NPCStrongholdBase'+CONVERT(varchar(10), @zoneId);
SET @fertility = 20;
SET @zoneplugin = 'zone_'+CONVERT(varchar(10), @zoneId)
SET @zoneip = '109.236.88.106'
SET @zoneport = 18800+@zoneId;
SET @isInstance =0;
SET @enabled =1;
SET @spawnId = (SELECT TOP 1 id FROM npcspawn WHERE name=@spawnName);
SET @plantRuleset = @zoneId;
SET @protected =1;
SET @raceId = 1;
SET @width = @size;
SET @height = @size;
SET @terraformable =0;
SET @zoneType =4;
SET @sparkCost =3;
SET @maxDockingBase = 0;
SET @sleeping= 0;
SET @plantAltitudeScale =1;
SET @host ='genxyHost-01';
SET @active =1;

PRINT N'DELETE/REINSERT NEW PLANTRULE FOR ZONE';
DROP TABLE IF EXISTS #PLANTRULE;
CREATE TABLE #PLANTRULE(
	ruleFile VARCHAR(100)
);
INSERT INTO #PLANTRULE (ruleFile) VALUES
--('bonsai.txt'),
('bush_a.txt'),
('bush_b.txt'),
('coppertree.txt'),
--('devrinol.txt'),
('grass_a.txt'),
('grass_b.txt'),
('nanowheat.txt'),
('pinetree.txt'),
--('poffeteg.txt'),
('quag.txt'),
--('rango.txt'),
('rango_lowaltitude.txt'),
--('reed.txt'),
('titanplant.txt');

DELETE FROM plantrules WHERE rulesetid=@plantRuleset;
INSERT INTO plantrules (plantrule, rulesetid, note)
SELECT ruleFile, @plantRuleset, 'stronghold plant rules' FROM #PLANTRULE;

DROP TABLE IF EXISTS #PLANTRULE;

--SET ENTITY FOR ZONE STORAGE
SET @eid=(SELECT TOP 1 eid + 1 FROM entities WHERE eid + 1 NOT IN (SELECT DISTINCT eid FROM entities));
SET @definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_zone_storage');
SET @ename = 'es_zone_'+CONVERT(varchar(10), @zoneId)+'_storage';

PRINT N'INSERTING/UPDATING ENTITIES TABLE';
IF EXISTS (SELECT TOP 1 eid FROM entities WHERE ename=@ename)
BEGIN
	UPDATE entities SET
		definition=@definition
	WHERE ename=@ename;
	SET @eid = (SELECT TOP 1 eid FROM entities WHERE ename=@ename);
END
ELSE
BEGIN
	INSERT INTO [dbo].[entities]
			   ([eid],[definition],[owner],[parent],[health],[ename],[quantity],[repackaged],[dynprop])
		 VALUES
			   (@eid,@definition,NULL,NULL,100,@ename,1,0,NULL);
END

PRINT N'INSERTING/UPDATING entitystorage TABLE';
IF EXISTS (SELECT TOP 1 eid FROM entitystorage WHERE storage_name=@ename)
BEGIN
	UPDATE entitystorage SET
		eid=@eid
	WHERE storage_name=@ename;
END
ELSE
BEGIN
	INSERT INTO [dbo].[entitystorage]
			   (storage_name,eid)
		 VALUES
			   (@ename,@eid);
END

PRINT N'INSERTING/UPDATING ZONE TABLE';
IF EXISTS (SELECT TOP 1 id FROM zones WHERE name=@zoneName AND description=@zoneName+'_desc')
BEGIN
	UPDATE zones SET
		id=@zoneId,
		x=@x,
		y=@y,
		name=@zoneName,
		description=@zoneDesc,
		note=@note,
		fertility=@fertility,
		zoneplugin=@zoneplugin,
		zoneport=@zoneport,
		isinstance=@isInstance,
		enabled=@enabled,
		spawnid=@spawnId,
		plantruleset=@plantRuleset,
		protected=@protected,
		raceid=@raceId,
		width=@width,
		height=@height,
		terraformable=@terraformable,
		zonetype=@zoneType,
		sparkcost=@sparkCost,
		maxdockingbase=@maxDockingBase,
		sleeping=@sleeping,
		plantaltitudescale=@plantAltitudeScale,
		host=@host,
		active=@active
	WHERE name=@zoneName;

END
ELSE
BEGIN
	INSERT INTO [dbo].[zones]
           ([id],[x],[y],[name],[description],[note],[fertility],[zoneplugin],[zoneip],[zoneport],[isinstance],[enabled],[spawnid],[plantruleset]
		   ,[protected],[raceid],[width],[height],[terraformable],[zonetype],[sparkcost],[maxdockingbase],[sleeping],[plantaltitudescale],[host],[active])
     VALUES
           (@zoneId,@x,@y,@zoneName,@zoneDesc,@note,@fertility,@zoneplugin,@zoneip,@zoneport,@isInstance,@enabled,@spawnId,@plantRuleset
           ,@protected,@raceId,@width,@height,@terraformable,@zoneType,@sparkCost,@maxDockingBase,@sleeping,@plantAltitudeScale,@host,@active);
END


PRINT N'NEW ZONE READY!';
GO