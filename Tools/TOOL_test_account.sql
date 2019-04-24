USE [perpetuumsa]
GO

-- Ensure the procedure we want to create is removed if it was already present
IF OBJECT_ID('dbo.ToolTestAccount_GetDefinitionID') IS NOT NULL DROP FUNCTION dbo.ToolTestAccount_GetDefinitionID
GO

-- Helper function
-- Input: Definition Name
-- Output: Definition ID
CREATE FUNCTION dbo.ToolTestAccount_GetDefinitionID (@DefinitionName VARCHAR(100))
RETURNS INT AS
BEGIN
	RETURN (SELECT [definition] FROM [dbo].[entitydefaults] WHERE [definitionname] = @DefinitionName)
END 
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
	5746866067632178287, --active chassis
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

-- Does the player entity is necessary?
INSERT [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) VALUES (@CharacterRootEID, 3, NULL, 499, 100, NULL, 1, 0, N'')

-- Robot root: Test bot
INSERT [dbo].[entities] 
	([eid], 
	[definition], 
	[owner], 
	[parent], 
	[health], 
	[ename], 
	[quantity], 
	[repackaged], 
	[dynprop]) 
VALUES 
	(5746866067632178287, 
	dbo.ToolTestAccount_GetDefinitionID('def_test_bot'),
	@CharacterRootEID, 
	45006, 
	100, 
	NULL, 
	1, 
	0, 
	N'#decay=iff#armor=t0000803F#tint=cff.ff.ff.ff#currentcore=t00B80848')
-- Robot head: Test bot head
INSERT [dbo].[entities] 
	([eid], 
	[definition], 
	[owner], 
	[parent], 
	[health], 
	[ename], 
	[quantity], 
	[repackaged], 
	[dynprop]) 
VALUES 
	(6855267950097474113, 
	dbo.ToolTestAccount_GetDefinitionID('def_test_bot_head'),
	@CharacterRootEID, 
	5746866067632178287, 
	100, 
	NULL, 
	1, 
	0, 
	N'')
-- Robot head slot 1: Sensor booster
INSERT [dbo].[entities] 
	([eid], 
	[definition], 
	[owner], 
	[parent], 
	[health], 
	[ename], 
	[quantity], 
	[repackaged], 
	[dynprop]) 
VALUES 
	(6918683465910511550, 
	dbo.ToolTestAccount_GetDefinitionID('def_named3_sensor_booster'), 
	@CharacterRootEID, 
	6855267950097474113, 
	100, 
	NULL, 
	1, 
	0, 
	N'#slot=i1')
-- Robot head slot 2: Cargo scanner
INSERT [dbo].[entities] 
	([eid], 
	[definition], 
	[owner], 
	[parent], 
	[health], 
	[ename], 
	[quantity], 
	[repackaged], 
	[dynprop]) 
VALUES 
	(7633214898009699544, 
	dbo.ToolTestAccount_GetDefinitionID('def_named3_cargo_scanner'), 
	@CharacterRootEID, 
	6855267950097474113, 
	100, 
	NULL, 
	1, 
	0, 
	N'#slot=i2')
-- Robot head slot 3: Chassis scanner
INSERT [dbo].[entities] 
	([eid], 
	[definition], 
	[owner], 
	[parent], 
	[health], 
	[ename], 
	[quantity], 
	[repackaged], 
	[dynprop]) 
VALUES 
	(7018772823416350409, 
	dbo.ToolTestAccount_GetDefinitionID('def_named3_chassis_scanner'), 
	@CharacterRootEID, 
	6855267950097474113, 
	100, 
	NULL, 
	1, 
	0, 
	N'#slot=i3')
-- Robot head slot 4: Webber
INSERT [dbo].[entities] 
	([eid], 
	[definition], 
	[owner], 
	[parent], 
	[health], 
	[ename], 
	[quantity], 
	[repackaged], 
	[dynprop]) 
VALUES 
	(7521905652512552190, 
	dbo.ToolTestAccount_GetDefinitionID('def_named3_webber'), 
	@CharacterRootEID, 
	6855267950097474113, 
	100, 
	NULL, 
	1, 
	0, 
	N'#slot=i4')
-- Robot head slot 5: Sensor jammer
INSERT [dbo].[entities] 
	([eid], 
	[definition], 
	[owner], 
	[parent], 
	[health], 
	[ename], 
	[quantity], 
	[repackaged], 
	[dynprop]) 
VALUES 
	(7559369786452310743, 
	dbo.ToolTestAccount_GetDefinitionID('def_named3_sensor_jammer'), 
	@CharacterRootEID, 
	6855267950097474113, 
	100, 
	NULL, 
	1, 
	0, 
	N'#slot=i5')
-- Robot head slot 6: Sensor dampener
INSERT [dbo].[entities] 
	([eid], 
	[definition], 
	[owner], 
	[parent], 
	[health], 
	[ename], 
	[quantity], 
	[repackaged], 
	[dynprop]) 
VALUES 
	(8385165011664691538, 
	dbo.ToolTestAccount_GetDefinitionID('def_named3_sensor_dampener'), 
	@CharacterRootEID, 
	6855267950097474113, 
	100, 
	NULL, 
	1, 
	0, 
	N'#slot=i6')
-- Robot head slot 7: ECCM
INSERT [dbo].[entities] 
	([eid], 
	[definition], 
	[owner], 
	[parent], 
	[health], 
	[ename], 
	[quantity], 
	[repackaged], 
	[dynprop]) 
VALUES 
	(7503219259451245980, 
	dbo.ToolTestAccount_GetDefinitionID('def_named3_eccm'), 
	@CharacterRootEID, 
	6855267950097474113, 
	100, 
	NULL, 
	1, 
	0, 
	N'#slot=i7')
-- Robot head slot 8: Mining probe module
INSERT [dbo].[entities] 
	([eid], 
	[definition], 
	[owner], 
	[parent], 
	[health], 
	[ename], 
	[quantity], 
	[repackaged], 
	[dynprop]) 
VALUES 
	(6474020408664789256, 
	dbo.ToolTestAccount_GetDefinitionID('def_named3_mining_probe_module'), 
	@CharacterRootEID, 
	6855267950097474113, 
	100, 
	NULL, 
	1, 
	0, 
	N'#slot=i8')

-- Robot chassis: Test bot chassis
INSERT [dbo].[entities] 
	([eid], 
	[definition], 
	[owner], 
	[parent], 
	[health], 
	[ename], 
	[quantity], 
	[repackaged], 
	[dynprop]) 
VALUES 
	(8353327551504782078, 
	dbo.ToolTestAccount_GetDefinitionID('def_test_bot_chassis'), 
	@CharacterRootEID, 
	5746866067632178287, 
	100, 
	NULL, 
	1, 
	0, 
	N'')
-- Robot chassis slot 1: Zmall Rail G00n + Medium railgun C ammo
INSERT [dbo].[entities] 
	([eid], 
	[definition], 
	[owner], 
	[parent], 
	[health], 
	[ename], 
	[quantity], 
	[repackaged], 
	[dynprop]) 
VALUES 
	(8579132053674912032, 
	dbo.ToolTestAccount_GetDefinitionID('def_zmall_railg00n'), 
	@CharacterRootEID, 
	8353327551504782078, 
	100, 
	NULL, 
	1, 
	0, 
	N'#slot=i1')
INSERT [dbo].[entities] 
	([eid], 
	[definition], 
	[owner], 
	[parent], 
	[health], 
	[ename], 
	[quantity], 
	[repackaged], 
	[dynprop]) 
VALUES 
	(6417853026066536407, 
	dbo.ToolTestAccount_GetDefinitionID('def_ammo_medium_railgun_c'), 
	@CharacterRootEID, 
	8579132053674912032, 
	100, 
	NULL, 
	9543, 
	0, 
	N'')
-- Robot chassis slot 2: Zmall Rail G00n + Medium railgun C ammo
INSERT [dbo].[entities] 
	([eid], 
	[definition], 
	[owner], 
	[parent], 
	[health], 
	[ename], 
	[quantity], 
	[repackaged], 
	[dynprop]) 
VALUES 
	(4767600390246042469, 
	dbo.ToolTestAccount_GetDefinitionID('def_zmall_railg00n'), 
	@CharacterRootEID, 
	8353327551504782078, 
	100, 
	NULL, 
	1, 
	0, 
	N'#slot=i2')
INSERT [dbo].[entities] 
	([eid], 
	[definition], 
	[owner], 
	[parent], 
	[health], 
	[ename], 
	[quantity], 
	[repackaged], 
	[dynprop]) 
VALUES 
	(6199238281262916109, 
	dbo.ToolTestAccount_GetDefinitionID('def_ammo_medium_railgun_c'), 
	@CharacterRootEID, 
	4767600390246042469, 
	100, 
	NULL, 
	9664, 
	0, 
	N'')
-- Robot chassis slot 3: Zmall Rail G00n + Medium railgun C ammo
INSERT [dbo].[entities] 
	([eid], 
	[definition], 
	[owner], 
	[parent], 
	[health], 
	[ename], 
	[quantity], 
	[repackaged], 
	[dynprop]) 
VALUES 
	(6381743440286831057, 
	dbo.ToolTestAccount_GetDefinitionID('def_zmall_railg00n'), 
	@CharacterRootEID, 
	8353327551504782078, 
	100, 
	NULL, 
	1, 
	0, 
	N'#slot=i3')
INSERT [dbo].[entities] 
	([eid], 
	[definition], 
	[owner], 
	[parent], 
	[health], 
	[ename], 
	[quantity], 
	[repackaged], 
	[dynprop]) 
VALUES 
	(5135683293805217430, 
	dbo.ToolTestAccount_GetDefinitionID('def_ammo_medium_railgun_c'), 
	@CharacterRootEID, 
	6381743440286831057, 
	100, 
	NULL, 
	9666, 
	0, 
	N'')
-- Robot chassis slot 4: Zmall Rail G00n + Medium railgun C ammo
INSERT [dbo].[entities] 
	([eid], 
	[definition], 
	[owner], 
	[parent], 
	[health], 
	[ename], 
	[quantity], 
	[repackaged], 
	[dynprop]) 
VALUES 
	(5348940415267832597, 
	dbo.ToolTestAccount_GetDefinitionID('def_zmall_railg00n'), 
	@CharacterRootEID, 
	8353327551504782078, 
	100, 
	NULL, 
	1, 
	0, 
	N'#slot=i4')
INSERT [dbo].[entities] 
	([eid], 
	[definition], 
	[owner], 
	[parent], 
	[health], 
	[ename], 
	[quantity], 
	[repackaged], 
	[dynprop]) 
VALUES 
	(6689891144622001290, 
	dbo.ToolTestAccount_GetDefinitionID('def_ammo_medium_railgun_c'), 
	@CharacterRootEID, 
	5348940415267832597, 
	100, 
	NULL, 
	9632, 
	0, 
	N'')
-- Robot chassis slot 5: Zmall Rail G00n + Medium railgun C ammo
INSERT [dbo].[entities] 
	([eid], 
	[definition], 
	[owner], 
	[parent], 
	[health], 
	[ename], 
	[quantity], 
	[repackaged], 
	[dynprop]) 
VALUES 
	(4653773294867335077, 
	dbo.ToolTestAccount_GetDefinitionID('def_zmall_railg00n'), 
	@CharacterRootEID, 
	8353327551504782078, 
	100, 
	NULL, 
	1, 
	0, 
	N'#slot=i5')
INSERT [dbo].[entities] 
	([eid], 
	[definition], 
	[owner], 
	[parent], 
	[health], 
	[ename], 
	[quantity], 
	[repackaged], 
	[dynprop]) 
VALUES 
	(7772735567613205437, 
	dbo.ToolTestAccount_GetDefinitionID('def_ammo_medium_railgun_c'), 
	@CharacterRootEID, 
	4653773294867335077, 
	100, 
	NULL, 
	9551, 
	0, 
	N'')
-- Robot chassis slot 6: Zmall Rail G00n + Medium railgun C ammo
INSERT [dbo].[entities] 
	([eid], 
	[definition], 
	[owner], 
	[parent], 
	[health], 
	[ename], 
	[quantity], 
	[repackaged], 
	[dynprop]) 
VALUES 
	(8931362252560156695, 
	dbo.ToolTestAccount_GetDefinitionID('def_zmall_railg00n'), 
	@CharacterRootEID, 
	8353327551504782078, 
	100, 
	NULL, 
	1, 
	0, 
	N'#slot=i6')
INSERT [dbo].[entities] 
	([eid], 
	[definition], 
	[owner], 
	[parent], 
	[health], 
	[ename], 
	[quantity], 
	[repackaged], 
	[dynprop]) 
VALUES 
	(6730439507818329604, 
	dbo.ToolTestAccount_GetDefinitionID('def_ammo_medium_railgun_c'), 
	@CharacterRootEID, 
	8931362252560156695, 
	100, 
	NULL, 
	9532, 
	0, 
	N'')
-- Robot chassis slot 7: Zmall Rail G00n + Medium railgun C ammo
INSERT [dbo].[entities] 
	([eid], 
	[definition], 
	[owner], 
	[parent], 
	[health], 
	[ename], 
	[quantity], 
	[repackaged], 
	[dynprop]) 
VALUES 
	(8173856768944043382, 
	dbo.ToolTestAccount_GetDefinitionID('def_zmall_railg00n'), 
	@CharacterRootEID, 
	8353327551504782078, 
	100, 
	NULL, 
	1, 
	0, 
	N'#slot=i7')
INSERT [dbo].[entities] 
	([eid], 
	[definition], 
	[owner], 
	[parent], 
	[health], 
	[ename], 
	[quantity], 
	[repackaged], 
	[dynprop]) 
VALUES 
	(7549771380571893378, 
	dbo.ToolTestAccount_GetDefinitionID('def_ammo_medium_railgun_c'), 
	@CharacterRootEID, 
	8173856768944043382, 
	100, 
	NULL, 
	9409, 
	0, 
	N'')
-- Robot chassis slot 8: Zmall Rail G00n + Medium railgun C ammo
INSERT [dbo].[entities] 
	([eid], 
	[definition], 
	[owner], 
	[parent], 
	[health], 
	[ename], 
	[quantity], 
	[repackaged], 
	[dynprop]) 
VALUES 
	(5174340000571150121, 
	dbo.ToolTestAccount_GetDefinitionID('def_zmall_railg00n'), 
	@CharacterRootEID, 
	8353327551504782078, 
	100, 
	NULL, 
	1, 
	0, 
	N'#slot=i8')
INSERT [dbo].[entities] 
	([eid], 
	[definition], 
	[owner], 
	[parent], 
	[health], 
	[ename], 
	[quantity], 
	[repackaged], 
	[dynprop]) 
VALUES 
	(6959965314561947423, 
	dbo.ToolTestAccount_GetDefinitionID('def_ammo_medium_railgun_c'), 
	@CharacterRootEID, 
	5174340000571150121, 
	100, 
	NULL, 
	9103, 
	0, 
	N'')

-- Robot leg: Test bog leg
INSERT [dbo].[entities] 
	([eid], 
	[definition], 
	[owner], 
	[parent], 
	[health], 
	[ename], 
	[quantity], 
	[repackaged], 
	[dynprop]) 
VALUES 
	(7730835551356351196, 
	dbo.ToolTestAccount_GetDefinitionID('def_test_bot_leg'), 
	@CharacterRootEID, 
	5746866067632178287, 
	100, 
	NULL, 
	1, 
	0, 
	N'')
-- Robot leg slot 1: Medium shield generator
INSERT [dbo].[entities] 
	([eid], 
	[definition], 
	[owner], 
	[parent], 
	[health], 
	[ename], 
	[quantity], 
	[repackaged], 
	[dynprop]) 
VALUES 
	(8286175745994502481, 
	dbo.ToolTestAccount_GetDefinitionID('def_named3_medium_shield_generator'), 
	@CharacterRootEID, 
	7730835551356351196, 
	100, 
	NULL, 
	1, 
	0, 
	N'#slot=i1')

-- Robot inventory: Robot inventory admin
INSERT [dbo].[entities] 
	([eid], 
	[definition], 
	[owner], 
	[parent], 
	[health], 
	[ename], 
	[quantity], 
	[repackaged], 
	[dynprop]) 
VALUES 
	(4798113171342288817, 
	dbo.ToolTestAccount_GetDefinitionID('def_robot_inventory_admin'), 
	@CharacterRootEID, 
	5746866067632178287, 
	100, 
	NULL, 
	1, 
	0, 
	N'#log=i0')

/* Unlock all skills */
DECLARE @CharacterID INT;
SET @CharacterID = (SELECT characterID FROM dbo.characters WHERE nick = @CharacterNick)
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

-- Remove the temporary procedure
IF OBJECT_ID('dbo.ToolTestAccount_GetDefinitionID') IS NOT NULL DROP FUNCTION dbo.ToolTestAccount_GetDefinitionID

 GO