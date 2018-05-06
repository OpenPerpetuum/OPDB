USE [perpetuumsa]
GO

--Name of the Spawn to Reallocate new presences in
DECLARE @spawnName varchar(128);
SET @spawnName = 'tm_pve'; -- Hershfield

--Name prefix for new presences
DECLARE @newPresenceNamePrefix varchar(128);
SET @newPresenceNamePrefix = 'OP-Hershfield_Pres_';

DECLARE @presNote varchar(128);
SET @presNote = 'TM - Hershfield Local Presenses - OP';


--Create Temp Table for XY pairs from existing flocks
SELECT DISTINCT spawnoriginX, spawnoriginY INTO #TEMPPRESENCES
FROM npcflock
WHERE enabled=1 and behaviorType=1 and
npcflock.presenceid in (SELECT npcpresence.id FROM npcpresence
WHERE enabled=1 and presencetype=0 and spawnid=(SELECT TOP 1 id FROM npcspawn WHERE npcspawn.name = @spawnName));

--Print out coordinates of npc-groups we wish to cluster on
SELECT * from #TEMPPRESENCES;

DECLARE @spX int;
DECLARE @spY int;
DECLARE @presName varchar(128);
DECLARE @groupRadius int;

--Set radius from which to grab neighboring flock-spawn homes to cluster into same presence (compensate for typos in origins)
SET @groupRadius = 5;


DECLARE db_cursor CURSOR FOR 
SELECT spawnoriginX, spawnoriginY FROM #TEMPPRESENCES;

OPEN db_cursor;
FETCH NEXT FROM db_cursor INTO @spX, @spY;

WHILE @@FETCH_STATUS = 0  
BEGIN  
	--Set an Informative-unique presence name
	SET @presName = @newPresenceNamePrefix+CONVERT(varchar(128), @spX)+'_'+ CONVERT(varchar(128), @spY);

	--Insert a new presence with name
	INSERT INTO [dbo].[npcpresence]
           ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds],[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
     VALUES
           (@presName,7,7,2040,2040,@presNote,(SELECT TOP 1 id FROM npcspawn where name=@spawnName),1,0,0,0,0,0,0,0,0,0,1,1);

	--Update flocks at/near that location to be in the new modular presence
	UPDATE npcflock
	SET presenceid=(SELECT TOP 1 id FROM npcpresence WHERE name=@presName)
	WHERE id in (SELECT id FROM npcflock WHERE (npcflock.spawnoriginX<@spX+@groupRadius and npcflock.spawnoriginX>@spX-@groupRadius) 
	and (npcflock.spawnoriginY<@spY+@groupRadius and npcflock.spawnoriginY>@spY-@groupRadius) and enabled=1 and behaviorType=1 and
	npcflock.presenceid in (SELECT npcpresence.id FROM npcpresence WHERE enabled=1 and presencetype=0 and 
	spawnid=(SELECT TOP 1 id FROM npcspawn WHERE npcspawn.name = @spawnName)));

	--Print out of the flocks updated
	SELECT * FROM npcflock WHERE (npcflock.spawnoriginX<@spX+@groupRadius and npcflock.spawnoriginX>@spX-@groupRadius) 
	and (npcflock.spawnoriginY<@spY+@groupRadius and npcflock.spawnoriginY>@spY-@groupRadius) and enabled=1 and behaviorType=1 and
	npcflock.presenceid in (SELECT npcpresence.id FROM npcpresence WHERE enabled=1 and presencetype=0 and 
	spawnid=(SELECT TOP 1 id FROM npcspawn WHERE npcspawn.name = @spawnName));

	FETCH NEXT FROM db_cursor INTO @spX, @spY;
END 

CLOSE db_cursor;
DEALLOCATE db_cursor;

DROP TABLE #TEMPPRESENCES;

GO


