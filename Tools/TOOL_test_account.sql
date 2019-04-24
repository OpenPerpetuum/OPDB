USE [perpetuumsa]
GO

DECLARE @AccountEmail VARCHAR(50);
DECLARE @PasswordInClear VARCHAR(40);
DECLARE @CharacterNick VARCHAR(50);
DECLARE @CharacterRootEID BIGINT;

SET @AccountEmail = 'test';
SET @PasswordInClear = 'test';
SET @CharacterNick = 'test';
SET @CharacterRootEID = 8702057415139945528;

/* SHA1 Hash the password */
DECLARE @Password VARCHAR(40);
SET @Password = CONVERT(VARCHAR(40), HASHBYTES('SHA1', @PasswordInClear), 2);

-- Begin account + character + owned entities cleanup
-- Setup variables for accountID + character rootEID
DECLARE @TEMP_ACCOUNT_ID INT;
SET @TEMP_ACCOUNT_ID = (SELECT [accountID] FROM [dbo].[accounts] WHERE [email] = @AccountEmail);
DECLARE @TEMP_CHARACTER_ROOTEID BIGINT;
SET @TEMP_CHARACTER_ROOTEID = (SELECT [rootEID] FROM [dbo].[characters] WHERE [accountID] = @TEMP_ACCOUNT_ID AND [nick] = @CharacterNick);

-- Remove owned entities of test account
DELETE FROM [dbo].[entities] 
WHERE [owner] = @TEMP_CHARACTER_ROOTEID 
	OR [eid] = @TEMP_CHARACTER_ROOTEID

-- Remove characters of test account
DELETE FROM [dbo].[characters] 
WHERE [accountID] = @TEMP_ACCOUNT_ID

-- Remove test account
DELETE FROM [dbo].[accounts] 
WHERE [email] = @AccountEmail

-- Start creation of test account
-- Create the test 'tool admin' account
INSERT INTO [dbo].[accounts] 
	([email], 
	[password], 
	[firstName], 
	[lastName], 
	[born], 
	[state], 
	[accLevel], 
	[totalMinsOnline], 
	[lastLoggedIn], 
	[creation], 
	[clientType], 
	[isLoggedIn], 
	[bantime], 
	[banlength], 
	[bannote], 
	[emailConfirmed], 
	[firstcharacter], 
	[note], 
	[steamID], 
	[twitchAuthToken], 
	[credit], 
	[isactive], 
	[resetcount], 
	[wasreset], 
	[validUntil], 
	[payingcustomer], 
	[campaignid]) 
VALUES 
	(@AccountEmail, 
	@Password, 
	NULL, 
	NULL, 
	NULL, 
	1,  --born
	14, --acclevel
	0,  --mins online
	CAST(N'2019-03-17T01:01:00' as SmallDateTime), --last logged in
	CAST(N'2019-03-17T01:01:00' as SmallDateTime), --creation
	0, --client type
	0, --is logged in
	NULL, --ban time
	0, --ban length
	NULL, --ban note
	0, --email confirm
	CAST(N'2019-03-17T01:01:39.680' as DateTime),  --first character
	'TEST ACCOUNT DO NOT PUT ON LIVE DB', --note
	NULL, 
	NULL, 
	0, 
	0, 
	0, 
	0, 
	NULL, 
	0, 
	N'{"host":"tooladmin"}')

-- This character will have the tutorial done and equiped with the admin bot template
INSERT INTO [dbo].[characters] 
	([accountID], 
	[rootEID], 
	[nick], 
	[moodMessage], 
	[creation], 
	[lastLogOut], 
	[lastUsed], 
	[credit], 
	[inUse], 
	[totalMinsOnline], 
	[activeChassis], 
	[active], 
	[deletedAt], 
	[baseEID], 
	[defaultcorporationEID], 
	[majorID], 
	[raceID], 
	[schoolID], 
	[sparkID], 
	[lastdocked], 
	[docked], 
	[lastteleported], 
	[zoneID], 
	[nickcorrected], 
	[offensivenick], 
	[positionX], 
	[positionY], 
	[homeBaseEID], 
	[blockTrades], 
	[globalMute], 
	[avatar], 
	[note], 
	[corporationeid], 
	[allianceeid], 
	[language]) 
VALUES 
	((SELECT accountID FROM dbo.accounts WHERE email = @AccountEmail), --account id
	@CharacterRootEID, 
	@CharacterNick, 
	NULL, --mood message
	CAST(N'2019-03-17T01:02:00' as SmallDateTime), --creation
	CAST(N'2019-03-17T01:05:00' as SmallDateTime), --last log out
	CAST(N'2019-03-17T01:02:00' as SmallDateTime), --last used
	500000000000, --credit
	0, --in use
	3, --total mins online
	8669878442849126445, --active chassis
	1, --active
	NULL, --deleted at
	142, --base eid
	499, --default corporation eid
	5, --major id
	1, --race id
	2, --shool id
	5, --spark id
	NULL, --last docked
	1, --docked
	NULL, --last teleported
	NULL, --zone id
	0, --nick corrected
	0, --offensive nick
	NULL, --position x
	NULL, --position y
	561, --home base eid
	0, -- block trades
	0, --global mute
	N'#background=i0#morph00=t0000803F#morph01=t00000000#morph02=t00000000#morph03=t6ABCF43E#morph04=t00000000#morph05=t250681BD#morph06=tDF4F0DBE#morph07=tFED4183F#morph08=t6666A63E#morph09=t8716993E#morph10=tE17A14BE#morph11=tFCA9713E#morph12=t00000000#morph13=tF0A746BE#morph14=t508D97BD#morph15=t0681153E#morph16=t00000000#morph17=t00000000#morph18=tC74BB7BE#morph19=t00000000#morph20=tF4FDD4BD#morph21=t21B0323F#morph22=t0681153E#morph23=t819583BE#morph24=tC74B373E#morph25=tCDCCCC3E#morph26=tD7A3F03E#morph27=t00000000#morph28=t00000000#morph29=t00000000#morph30=t00000000#morph31=t00000000#camerax=tD9CEF73D#cameray=tB6F3BD3E#light1posx=tCDCC4CBE#light1posy=t23DBB93E#light1posz=t2B8716BF#light1color=Lffffffff#light2posx=tEC51583F#light2posy=t5839343D#light2posz=tAC1C3ABF#light2color=Lff393939#eyex=tCDCC0C3F#eyey=t6F12033F#eyecolor=Lff67442e#body=i0#bodycolor=Lff572100#hair=i3#haircolor=Lff66809b#beard=i8#eyebrow=ia#beardcolor=Lff66809b#tattoo=i6#tattoocolor=Lff000000#facecolor=Lffb7befa',  --avatar
	NULL, --note
	499, --corporation eid
	2401, -- alliance eid
	0) -- language

DECLARE @CharacterID INT;
SET @CharacterID = (SELECT characterID FROM dbo.characters WHERE nick = @CharacterNick)


-- Player
INSERT [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) VALUES (@CharacterRootEID, 3, NULL, 499, 100, NULL, 1, 0, N'')

-- Robot description (root of any bot)
INSERT [dbo].[entities] 
	([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) 
VALUES 
	(8669878442849126445, 5, @CharacterRootEID, 45006, 100, NULL, 1, 0, N'#decay=iff#armor=t0000803F#tint=c82.0.28.ff#currentcore=t00006143')


-- Robot head
INSERT [dbo].[entities] 
	([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) 
VALUES 
	(7778931410082838398, 6, @CharacterRootEID, 8669878442849126445, 100, NULL, 1, 0, N'')
-- Robot head module slot 1: Mining probe
INSERT [dbo].[entities] 
	([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) 
VALUES 
	(4760986958159011996, 1475, @CharacterRootEID, 7778931410082838398, 100, NULL, 1, 0, N'#slot=i1')


-- Robot chassis
INSERT [dbo].[entities] 
	([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) 
VALUES 
	(7328952742780165317, 7, @CharacterRootEID, 8669878442849126445, 100, NULL, 1, 0, N'')
-- Robot chassis module slot 1: Small autocannon
INSERT [dbo].[entities] 
	([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) 
VALUES 
	(5896526872994473577, 998, @CharacterRootEID, 7328952742780165317, 100, NULL, 1, 0, N'#slot=i1')
-- Robot chassis module slot 1 ammo: Mining gravel
INSERT [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) VALUES (6390242247659676284, 259, @CharacterRootEID, 5896526872994473577, 100, NULL, 200, 0, N'')
-- Robot chassis module slot 2: Small driller
INSERT [dbo].[entities] 
	([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) 
VALUES 
	(5318436710320130030, 1474, @CharacterRootEID, 7328952742780165317, 100, NULL, 1, 0, N'#slot=i2')
-- Robot chassis module slot 2 ammo: Small projectile A
INSERT [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) VALUES (4714745354150187967, 2374, @CharacterRootEID, 5318436710320130030, 100, NULL, 45, 0, N'')


-- Robot leg
INSERT [dbo].[entities] 
	([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) 
VALUES 
	(8453698831312650473, 8, @CharacterRootEID, 8669878442849126445, 100, NULL, 1, 0, N'')
-- Robot leg module slot 1:  Small armor plate
INSERT [dbo].[entities] 
	([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) 
VALUES 
	(6343803432240506695, 996, @CharacterRootEID, 8453698831312650473, 100, NULL, 1, 0, N'#slot=i1')
-- Robot leg module slot 2: Small armor repairer
INSERT [dbo].[entities] 
	([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop])
VALUES 
	(7397597343020212845, 997, @CharacterRootEID, 8453698831312650473, 100, NULL, 1, 0, N'#slot=i2')


-- Robot inventory
INSERT [dbo].[entities] 
	([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) 
VALUES 
	(6262429094426133627, 326, @CharacterRootEID, 8669878442849126445, 100, NULL, 1, 0, N'#log=i0')
-- Robot intenvory: Ammo small projectile A
INSERT [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) VALUES (5795436455642734201, 259, @CharacterRootEID, 6262429094426133627, 100, NULL, 200, 0, N'')
-- Robot intenvory: Small autocannon
INSERT [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) VALUES (8805172640914423400, 998, @CharacterRootEID, 6262429094426133627, 100, NULL, 1, 1, N'')
-- Robot intenvory: Small driller
INSERT [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) VALUES (8021672084495569360, 1474, @CharacterRootEID, 6262429094426133627, 100, NULL, 1, 1, N'')
-- Robot intenvory: Mining gravel
INSERT [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) VALUES (4821030570804769155, 2374, @CharacterRootEID, 6262429094426133627, 100, NULL, 45, 0, N'')
-- Robot intenvory: Mining probe gravel tile
INSERT [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) VALUES (8659830082665460801, 2375, @CharacterRootEID, 6262429094426133627, 100, NULL, 10, 0, N'')
-- Robot intenvory: Small harvester
INSERT [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) VALUES (7790860961864033977, 4570, @CharacterRootEID, 6262429094426133627, 100, NULL, 1, 1, N'')
-- Robot intenvory: Mining probe gravel direction
INSERT [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) VALUES (5834831523434105543, 5158, @CharacterRootEID, 6262429094426133627, 100, NULL, 40, 0, N'')


/* Unlock all skills */
declare @ext_id int;
declare db_cursor cursor for 
select extensionid 
from dbo.extensions

open db_cursor  
fetch next from db_cursor into @ext_id  

while @@FETCH_STATUS = 0  
begin  
		exec dbo.setExtensionLevel @CharacterID, @ext_id, 10;

      fetch next from db_cursor into @ext_id 
end 

close db_cursor  
deallocate db_cursor

 GO