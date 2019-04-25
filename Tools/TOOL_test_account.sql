USE [perpetuumsa]
GO

 /*‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\
 | Purpose:                                                |
 | ‾‾‾‾‾‾‾‾                                                |
 | This script intent is to improve the quality of life    |
 | for the developers. It provides a stored procedure to   |
 | generate an account with the following variables:       |
 |                                                         |
 | o Account email                                         |
 | o Account password                                      |
 | o Default character name                                |
 | o Credits on the character                              |
 |                                                         |
 | The following list contains the static content that     |
 | is generated by default when calling this stored        |
 | procedure:                                              |
 |                                                         |
 | o Account Type: Tool admin                              |
 | o Tutorial skipped: Yes                                 |
 | o Active Robot: Admin bot (maxed out bot)               |
 | o Extensions: All unlocked                              |
 | o Location: Hershfield main terminal (docked)           |
 |                                                         |
 \________________________________________________________*/

 -- Ensure the procedure we want to create is removed if it was already present
IF OBJECT_ID('dbo.ToolTestAccount_GetDefinitionID') IS NOT NULL DROP FUNCTION dbo.ToolTestAccount_GetDefinitionID
IF OBJECT_ID('dbo.CreateTestAccount') IS NOT NULL DROP PROCEDURE dbo.CreateTestAccount
GO

-- Helper function to get the definition id of an entitydefault using the definition name.
-- Input: Definition Name
-- Output: Definition ID
CREATE FUNCTION dbo.ToolTestAccount_GetDefinitionID (@DefinitionName VARCHAR(100))
RETURNS INT AS
BEGIN
	RETURN (SELECT [definition] FROM [dbo].[entitydefaults] WHERE [definitionname] = @DefinitionName)
END 
GO

-----------------------------------------------------------------------------------------------------------------------------
-- From this line until the end of the file We are defining the implementation of the stored procedure 'CreateTestAccount' --
-----------------------------------------------------------------------------------------------------------------------------
-- Note: Where this could be stored in the DB since it can be useful for development (Quick access to create multiple test accounts
CREATE PROCEDURE dbo.CreateTestAccount
	@AccountEmail VARCHAR(50),
	@PasswordInClear VARCHAR(40),
	@CharacterNick VARCHAR(50),
	@CreditAccount FLOAT 
AS

-- Hash the password using SHA1
DECLARE @Password VARCHAR(40);
SET @Password = CONVERT(VARCHAR(40), HASHBYTES('SHA1', @PasswordInClear), 2);

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

-- Now that we have an account, we can grab the generated Account ID
DECLARE @AccountID INT;
SET @AccountID = (SELECT accountID FROM dbo.accounts WHERE email = @AccountEmail);

-- We also need to generate the Character Root EID
DECLARE @CharacterRootEID BIGINT;
SET @CharacterRootEID = dbo.GetRandomEid();

-- And the Robot EID (to set as active chassis)
DECLARE @ROBOT_EID BIGINT;
SET @ROBOT_EID = dbo.GetRandomEid()

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
	(@AccountID, --account id
	@CharacterRootEID, 
	@CharacterNick, 
	NULL, --mood message
	CAST(N'2019-03-17T01:02:00' as SmallDateTime), --creation
	CAST(N'2019-03-17T01:05:00' as SmallDateTime), --last log out
	CAST(N'2019-03-17T01:02:00' as SmallDateTime), --last used
	@CreditAccount, --credit
	0, --in use
	3, --total mins online
	@ROBOT_EID, --active chassis
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
	--
	-- Here we can change the following string to edit the character avatar
	-- 
	N'#background=i0#morph00=t0000803F#morph01=t00000000#morph02=t00000000#morph03=t6ABCF43E#morph04=t00000000#morph05=t250681BD#morph06=tDF4F0DBE#morph07=tFED4183F#morph08=t6666A63E#morph09=t8716993E#morph10=tE17A14BE#morph11=tFCA9713E#morph12=t00000000#morph13=tF0A746BE#morph14=t508D97BD#morph15=t0681153E#morph16=t00000000#morph17=t00000000#morph18=tC74BB7BE#morph19=t00000000#morph20=tF4FDD4BD#morph21=t21B0323F#morph22=t0681153E#morph23=t819583BE#morph24=tC74B373E#morph25=tCDCCCC3E#morph26=tD7A3F03E#morph27=t00000000#morph28=t00000000#morph29=t00000000#morph30=t00000000#morph31=t00000000#camerax=tD9CEF73D#cameray=tB6F3BD3E#light1posx=tCDCC4CBE#light1posy=t23DBB93E#light1posz=t2B8716BF#light1color=Lffffffff#light2posx=tEC51583F#light2posy=t5839343D#light2posz=tAC1C3ABF#light2color=Lff393939#eyex=tCDCC0C3F#eyey=t6F12033F#eyecolor=Lff67442e#body=i0#bodycolor=Lff572100#hair=i3#haircolor=Lff66809b#beard=i8#eyebrow=ia#beardcolor=Lff66809b#tattoo=i6#tattoocolor=Lff000000#facecolor=Lffb7befa',  --avatar
	NULL, --note
	499, --corporation eid
	2401, -- alliance eid
	0) -- language


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
	(@ROBOT_EID, 
	dbo.ToolTestAccount_GetDefinitionID('def_test_bot'),
	@CharacterRootEID, 
	45006, 
	100, 
	NULL, 
	1, 
	0, 
	N'#decay=iff#armor=t0000803F#tint=cff.ff.ff.ff#currentcore=t00B80848')
-- Robot head: Test bot head
DECLARE @ROBOT_HEAD_EID BIGINT;
SET @ROBOT_HEAD_EID = dbo.GetRandomEid();
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
	(@ROBOT_HEAD_EID, 
	dbo.ToolTestAccount_GetDefinitionID('def_test_bot_head'),
	@CharacterRootEID, 
	@ROBOT_EID, 
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
	(dbo.GetRandomEid(), 
	dbo.ToolTestAccount_GetDefinitionID('def_named3_sensor_booster'), 
	@CharacterRootEID, 
	@ROBOT_HEAD_EID, 
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
	(dbo.GetRandomEid(), 
	dbo.ToolTestAccount_GetDefinitionID('def_named3_cargo_scanner'), 
	@CharacterRootEID, 
	@ROBOT_HEAD_EID, 
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
	(dbo.GetRandomEid(), 
	dbo.ToolTestAccount_GetDefinitionID('def_named3_chassis_scanner'), 
	@CharacterRootEID, 
	@ROBOT_HEAD_EID, 
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
	(dbo.GetRandomEid(), 
	dbo.ToolTestAccount_GetDefinitionID('def_named3_webber'), 
	@CharacterRootEID, 
	@ROBOT_HEAD_EID, 
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
	(dbo.GetRandomEid(), 
	dbo.ToolTestAccount_GetDefinitionID('def_named3_sensor_jammer'), 
	@CharacterRootEID, 
	@ROBOT_HEAD_EID, 
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
	(dbo.GetRandomEid(), 
	dbo.ToolTestAccount_GetDefinitionID('def_named3_sensor_dampener'), 
	@CharacterRootEID, 
	@ROBOT_HEAD_EID, 
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
	(dbo.GetRandomEid(), 
	dbo.ToolTestAccount_GetDefinitionID('def_named3_eccm'), 
	@CharacterRootEID, 
	@ROBOT_HEAD_EID, 
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
	(dbo.GetRandomEid(), 
	dbo.ToolTestAccount_GetDefinitionID('def_named3_mining_probe_module'), 
	@CharacterRootEID, 
	@ROBOT_HEAD_EID, 
	100, 
	NULL, 
	1, 
	0, 
	N'#slot=i8')

-- Robot chassis: Test bot chassis
DECLARE @ROBOT_CHASSIS_EID BIGINT;
SET @ROBOT_CHASSIS_EID = dbo.GetRandomEid();
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
	(@ROBOT_CHASSIS_EID, 
	dbo.ToolTestAccount_GetDefinitionID('def_test_bot_chassis'), 
	@CharacterRootEID, 
	@ROBOT_EID, 
	100, 
	NULL, 
	1, 
	0, 
	N'')
-- Robot chassis slot 1: Zmall Rail G00n + Medium railgun C ammo
DECLARE @ROBOT_CHASSIS_SLOT_1_EID BIGINT;
SET @ROBOT_CHASSIS_SLOT_1_EID = dbo.GetRandomEid();
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
	(@ROBOT_CHASSIS_SLOT_1_EID, 
	dbo.ToolTestAccount_GetDefinitionID('def_zmall_railg00n'), 
	@CharacterRootEID, 
	@ROBOT_CHASSIS_EID, 
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
	(dbo.GetRandomEid(), 
	dbo.ToolTestAccount_GetDefinitionID('def_ammo_medium_railgun_c'), 
	@CharacterRootEID, 
	@ROBOT_CHASSIS_SLOT_1_EID, 
	100, 
	NULL, 
	9543, 
	0, 
	N'')
-- Robot chassis slot 2: Zmall Rail G00n + Medium railgun C ammo
DECLARE @ROBOT_CHASSIS_SLOT_2_EID BIGINT;
SET @ROBOT_CHASSIS_SLOT_2_EID = dbo.GetRandomEid();
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
	(@ROBOT_CHASSIS_SLOT_2_EID, 
	dbo.ToolTestAccount_GetDefinitionID('def_zmall_railg00n'), 
	@CharacterRootEID, 
	@ROBOT_CHASSIS_EID, 
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
	(dbo.GetRandomEid(), 
	dbo.ToolTestAccount_GetDefinitionID('def_ammo_medium_railgun_c'), 
	@CharacterRootEID, 
	@ROBOT_CHASSIS_SLOT_2_EID, 
	100, 
	NULL, 
	9664, 
	0, 
	N'')
-- Robot chassis slot 3: Zmall Rail G00n + Medium railgun C ammo
DECLARE @ROBOT_CHASSIS_SLOT_3_EID BIGINT;
SET @ROBOT_CHASSIS_SLOT_3_EID = dbo.GetRandomEid();
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
	(@ROBOT_CHASSIS_SLOT_3_EID, 
	dbo.ToolTestAccount_GetDefinitionID('def_zmall_railg00n'), 
	@CharacterRootEID, 
	@ROBOT_CHASSIS_EID, 
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
	(dbo.GetRandomEid(), 
	dbo.ToolTestAccount_GetDefinitionID('def_ammo_medium_railgun_c'), 
	@CharacterRootEID, 
	@ROBOT_CHASSIS_SLOT_3_EID, 
	100, 
	NULL, 
	9666, 
	0, 
	N'')
-- Robot chassis slot 4: Zmall Rail G00n + Medium railgun C ammo
DECLARE @ROBOT_CHASSIS_SLOT_4_EID BIGINT;
SET @ROBOT_CHASSIS_SLOT_4_EID = dbo.GetRandomEid();
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
	(@ROBOT_CHASSIS_SLOT_4_EID, 
	dbo.ToolTestAccount_GetDefinitionID('def_zmall_railg00n'), 
	@CharacterRootEID, 
	@ROBOT_CHASSIS_EID, 
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
	(dbo.GetRandomEid(), 
	dbo.ToolTestAccount_GetDefinitionID('def_ammo_medium_railgun_c'), 
	@CharacterRootEID, 
	@ROBOT_CHASSIS_SLOT_4_EID, 
	100, 
	NULL, 
	9632, 
	0, 
	N'')
-- Robot chassis slot 5: Zmall Rail G00n + Medium railgun C ammo
DECLARE @ROBOT_CHASSIS_SLOT_5_EID BIGINT;
SET @ROBOT_CHASSIS_SLOT_5_EID = dbo.GetRandomEid();
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
	(@ROBOT_CHASSIS_SLOT_5_EID, 
	dbo.ToolTestAccount_GetDefinitionID('def_zmall_railg00n'), 
	@CharacterRootEID, 
	@ROBOT_CHASSIS_EID, 
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
	(dbo.GetRandomEid(), 
	dbo.ToolTestAccount_GetDefinitionID('def_ammo_medium_railgun_c'), 
	@CharacterRootEID, 
	@ROBOT_CHASSIS_SLOT_5_EID, 
	100, 
	NULL, 
	9551, 
	0, 
	N'')
-- Robot chassis slot 6: Zmall Rail G00n + Medium railgun C ammo
DECLARE @ROBOT_CHASSIS_SLOT_6_EID BIGINT;
SET @ROBOT_CHASSIS_SLOT_6_EID = dbo.GetRandomEid();
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
	(@ROBOT_CHASSIS_SLOT_6_EID, 
	dbo.ToolTestAccount_GetDefinitionID('def_zmall_railg00n'), 
	@CharacterRootEID, 
	@ROBOT_CHASSIS_EID, 
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
	(dbo.GetRandomEid(), 
	dbo.ToolTestAccount_GetDefinitionID('def_ammo_medium_railgun_c'), 
	@CharacterRootEID, 
	@ROBOT_CHASSIS_SLOT_6_EID, 
	100, 
	NULL, 
	9532, 
	0, 
	N'')
-- Robot chassis slot 7: Zmall Rail G00n + Medium railgun C ammo
DECLARE @ROBOT_CHASSIS_SLOT_7_EID BIGINT;
SET @ROBOT_CHASSIS_SLOT_7_EID = dbo.GetRandomEid();
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
	(@ROBOT_CHASSIS_SLOT_7_EID, 
	dbo.ToolTestAccount_GetDefinitionID('def_zmall_railg00n'), 
	@CharacterRootEID, 
	@ROBOT_CHASSIS_EID, 
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
	(dbo.GetRandomEid(), 
	dbo.ToolTestAccount_GetDefinitionID('def_ammo_medium_railgun_c'), 
	@CharacterRootEID, 
	@ROBOT_CHASSIS_SLOT_7_EID, 
	100, 
	NULL, 
	9409, 
	0, 
	N'')
-- Robot chassis slot 8: Zmall Rail G00n + Medium railgun C ammo
DECLARE @ROBOT_CHASSIS_SLOT_8_EID BIGINT;
SET @ROBOT_CHASSIS_SLOT_8_EID = dbo.GetRandomEid();
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
	(@ROBOT_CHASSIS_SLOT_8_EID, 
	dbo.ToolTestAccount_GetDefinitionID('def_zmall_railg00n'), 
	@CharacterRootEID, 
	@ROBOT_CHASSIS_EID, 
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
	(dbo.GetRandomEid(), 
	dbo.ToolTestAccount_GetDefinitionID('def_ammo_medium_railgun_c'), 
	@CharacterRootEID, 
	@ROBOT_CHASSIS_SLOT_8_EID, 
	100, 
	NULL, 
	9103, 
	0, 
	N'')

-- Robot leg: Test bog leg
DECLARE @ROBOT_LEG_EID BIGINT;
SET @ROBOT_LEG_EID = dbo.GetRandomEid();
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
	(@ROBOT_LEG_EID, 
	dbo.ToolTestAccount_GetDefinitionID('def_test_bot_leg'), 
	@CharacterRootEID, 
	@ROBOT_EID, 
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
	(dbo.GetRandomEid(), 
	dbo.ToolTestAccount_GetDefinitionID('def_named3_medium_shield_generator'), 
	@CharacterRootEID, 
	@ROBOT_LEG_EID, 
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
	(dbo.GetRandomEid(), 
	dbo.ToolTestAccount_GetDefinitionID('def_robot_inventory_admin'), 
	@CharacterRootEID, 
	@ROBOT_EID, 
	100, 
	NULL, 
	1, 
	0, 
	N'#log=i0')

/* Unlock all skills */
DECLARE @CharacterID INT;
SET @CharacterID = (SELECT [characterID] FROM [dbo].[characters] WHERE [nick] = @CharacterNick)
DECLARE @ext_id INT;
DECLARE [db_cursor] CURSOR FOR
SELECT [extensionid] 
FROM [dbo].[extensions]

OPEN db_cursor  
FETCH NEXT FROM db_cursor INTO @ext_id  

WHILE @@FETCH_STATUS = 0  
BEGIN  
	EXEC dbo.setExtensionLevel @CharacterID, @ext_id, 10;
	FETCH NEXT FROM db_cursor INTO @ext_id 
END 

CLOSE db_cursor  
DEALLOCATE db_cursor
GO
-------------------------------------------------------------------
-- This is the end of the stored procedure dbo.CreateTestAccount --
-------------------------------------------------------------------

-- Creating a test account
 EXECUTE dbo.CreateTestAccount
	@AccountEmail = 'test',
	@PasswordInClear = 'test',
	@CharacterNick = 'test',
	@CreditAccount = 500000000000;