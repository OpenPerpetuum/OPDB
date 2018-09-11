USE [perpetuumsa]
GO

-------------------------------
--DO NOT USE ON LIVE SERVER!
--FOR TESTING PURPOSES ONLY
-------------------------------

--Check if live server DB settings
IF 'Open Perpetuum Project Live Server - OpenPerpetuum.com' in (SELECT name from serverinfo) 
	and 1 in (SELECT isopen from serverinfo) 
	and 1 in (SELECT isbroadcast from serverinfo)
	RETURN;
--Get the hell outta here!


-------------------------------
--Testing script for adding arbitrary standings to any collection of characters from known accounts
--Inputs: Account IDs to supply standings to their characters, and target reputation value
-------------------------------

--Set this!
DECLARE @repLevel float;
SET @repLevel = 7.33;

DECLARE @ACCOUNTSTABLE TABLE(accID int);

--Set these!
INSERT INTO @ACCOUNTSTABLE
VALUES
(8),
(9);

DECLARE @CHARS TABLE(charID int, charEID bigint, currentStanding float);


INSERT INTO @CHARS
SELECT characterID, rootEID, standings.standing FROM characters
JOIN standings on standings.target=rootEID
WHERE accountID in (SELECT accID FROM @ACCOUNTSTABLE);

--Update standings for each character to the target level
UPDATE standings
SET 
standings.standing = @repLevel
FROM
@CHARS AS charTable
    INNER JOIN standings AS rep
        ON charTable.charEID = rep.target

--insert a log that approximately accounts for the standing change (uses arbitrary missionid)
INSERT INTO standinglog
 ([characterid],[eventtime],[actual],[change],[allianceeid],[missionid])
SELECT charID, GETDATE(),  @repLevel, @repLevel-currentStanding, alliances.allianceEID, 1167 FROM @CHARS
JOIN alliances ON allianceEID in (SELECT allianceEID FROM standings) and raceid!=0; 

GO