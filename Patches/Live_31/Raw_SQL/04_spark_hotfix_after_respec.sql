DELETE ce FROM characterextensions ce
INNER JOIN extensions e ON ce.extensionid = e.extensionid
WHERE e.active = 1 AND e.hidden = 1

DECLARE @characterid INT
DECLARE @sparkid INT

DECLARE curse cursor fast_forward read_only FOR
SELECT characterid, sparkid FROM charactersparks WHERE active = 1

OPEN curse

FETCH NEXT FROM curse INTO @characterid, @sparkid

WHILE @@FETCH_STATUS = 0
BEGIN
	INSERT INTO characterextensions (characterid, extensionid, extensionlevel)
	(SELECT @characterid, extensionid, extensionlevel FROM sparkextensions WHERE sparkid = @sparkid)

	FETCH NEXT FROM curse INTO @characterid, @sparkid
END
  
CLOSE curse
DEALLOCATE curse