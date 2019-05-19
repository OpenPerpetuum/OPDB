USE [perpetuumsa]
GO

------------------------------------------------
-- Welcome Mail features and character
-- CREATE: premademail table
-- INSERT: account and character
-- A table of predefined mails is created with a name
-- by which to lookup mails on the server when being sent
-- A character and account are also created to allow the mail to be
-- sent from this character.
-- The account should be perma-banned, and the PASSWORD CHANGED at patch time or after
--
-- Date: 2019/04/04 
------------------------------------------------


DROP TABLE IF EXISTS dbo.premademail;
GO


/* Setup premademail */
CREATE TABLE dbo.premademail (
	id int primary key,
	name varchar(32) not null unique,
	subject nvarchar(128) not null,
	body nvarchar(2000) not null
);
GO


INSERT INTO dbo.premademail (id, name, subject, body)
VALUES (1, 'TutorialArriveMail', 'Welcome $USER$!', 'Welcome to Perpetuum $USER$!
You will begin your first steps in the Tutorial and are asked to complete the "Rookie Checklist".
If you find that you need assistance, please use the link below:
https://openperpetuum.com/help

You may in fact skip the tutorial by proceeding to the exit teleports after you undock.
However you will miss out on a lot of rewards!  Skipping is not recommended for new players.
If you have any questions, do not hesitate to reach out in Help chat or on discord at:
https://discord.gg/5ZVqabV
');

INSERT INTO dbo.premademail (id, name, subject, body)
VALUES (2, 'TutorialCompleteMail', 'Welcome to Nia $USER$! Your next move...', 'Congratulations on completing the Rookie Checklist $USER$!
You might be wondering what to do next…
First, dont forget to join the Discord:  https://discord.gg/5ZVqabV
And to view all the helpful links on https://openperpetuum.com

Remember everything you can do in the tutorial you can do on Nia, and earn NIC and EP! 
Consider joining a player Corporation - and meet other players like yourself, learn from others in the game, and go further together!
');
GO

/* Setup Welcome-Agent Account and Character */
DECLARE @PASSWORD_TEMP varbinary(40);
SET @PASSWORD_TEMP = HASHBYTES('SHA1', (LEFT(REPLACE(NEWID(),'-',''),31)));
DECLARE @PASSWORD varchar(100);
SET @PASSWORD = (SELECT CONVERT(VARCHAR(100),HASHBYTES('SHA1',CRYPT_GEN_RANDOM(32)),2));

--This account will be used to host server-defined characters for automated interactions with players
INSERT INTO [dbo].[accounts]
           ([email]
           ,[password]
           ,[firstName]
           ,[lastName]
           ,[born]
           ,[state]
           ,[accLevel]
           ,[totalMinsOnline]
           ,[lastLoggedIn]
           ,[creation]
           ,[clientType]
           ,[isLoggedIn]
           ,[bantime]
           ,[banlength]
           ,[bannote]
           ,[emailConfirmed]
           ,[firstcharacter]
           ,[note]
           ,[steamID]
           ,[twitchAuthToken]
           ,[credit]
           ,[isactive]
           ,[resetcount]
           ,[wasreset]
           ,[validUntil]
           ,[payingcustomer]
           ,[campaignid])
VALUES 
			(N'OPP_server_account', --email
			@PASSWORD, --pw
			NULL, 
			NULL,
			NULL, 
			1, --born
			2, --acclevel
			0, --mins online
			CAST(N'2019-03-17T01:01:00' AS SmallDateTime), --lastloggedin
			CAST(N'2019-03-17T01:01:00' AS SmallDateTime), --creation
			0, --clienttype
			0, --isLoggedin
			CAST(N'2019-03-17T01:01:00' AS SmallDateTime), --bantime
			2147483640, --banlength
			'DO NOT UNBAN - server defined account', 
			0, --emailconfirm
			CAST(N'2019-03-17T01:01:39.680' AS DateTime), --firstcharacter
			'SERVER DEFINED ACCOUNT for server-characters, do not login, do not unban', 
			NULL, 
			NULL, 
			0, 
			0, 
			0, 
			0, 
			NULL, 
			0, 
			N'{"host":"tooladmin"}');


--This character will be used to send informative welcome messages to new players
INSERT INTO [dbo].[characters]
           ([accountID]
           ,[rootEID]
           ,[nick]
           ,[moodMessage]
           ,[creation]
           ,[lastLogOut]
           ,[lastUsed]
           ,[credit]
           ,[inUse]
           ,[totalMinsOnline]
           ,[activeChassis]
           ,[active]
           ,[deletedAt]
           ,[baseEID]
           ,[defaultcorporationEID]
           ,[majorID]
           ,[raceID]
           ,[schoolID]
           ,[sparkID]
           ,[lastdocked]
           ,[docked]
           ,[lastteleported]
           ,[zoneID]
           ,[nickcorrected]
           ,[offensivenick]
           ,[positionX]
           ,[positionY]
           ,[homeBaseEID]
           ,[blockTrades]
           ,[globalMute]
           ,[avatar]
           ,[note]
           ,[corporationeid]
           ,[allianceeid]
           ,[language])
VALUES
			((SELECT accountID FROM dbo.accounts where email = 'overlord'), --accountID
			8702057415139945528, 
			N'[OPP] Sparky - The Syndicate Welcome Agent', --nick
			NULL, 
			CAST(N'2019-03-17T01:02:00' AS SmallDateTime), 
			CAST(N'2019-03-17T01:05:00' AS SmallDateTime), 
			CAST(N'2019-03-17T01:02:00' AS SmallDateTime), 
			10, --credit
			0, 
			3,
			8669878442849126445, 
			1,
			NULL, 
			142,
			499, 
			5, 
			1, 
			2, 
			5,
			NULL,
			1,
			NULL,
			NULL,
			0,
			0,
			NULL,
			NULL,
			561,
			0,
			0, 
			N'#background=i0#morph00=t0000803F#morph01=t00000000#morph02=t00000000#morph03=t6ABCF43E#morph04=t00000000#morph05=t250681BD#morph06=tDF4F0DBE#morph07=tFED4183F#morph08=t6666A63E#morph09=t8716993E#morph10=tE17A14BE#morph11=tFCA9713E#morph12=t00000000#morph13=tF0A746BE#morph14=t508D97BD#morph15=t0681153E#morph16=t00000000#morph17=t00000000#morph18=tC74BB7BE#morph19=t00000000#morph20=tF4FDD4BD#morph21=t21B0323F#morph22=t0681153E#morph23=t819583BE#morph24=tC74B373E#morph25=tCDCCCC3E#morph26=tD7A3F03E#morph27=t00000000#morph28=t00000000#morph29=t00000000#morph30=t00000000#morph31=t00000000#camerax=tD9CEF73D#cameray=tB6F3BD3E#light1posx=tCDCC4CBE#light1posy=t23DBB93E#light1posz=t2B8716BF#light1color=Lffffffff#light2posx=tEC51583F#light2posy=t5839343D#light2posz=tAC1C3ABF#light2color=Lff393939#eyex=tCDCC0C3F#eyey=t6F12033F#eyecolor=Lff67442e#body=i0#bodycolor=Lff572100#hair=i3#haircolor=Lff66809b#beard=i8#eyebrow=ia#beardcolor=Lff66809b#tattoo=i6#tattoocolor=Lff000000#facecolor=Lffb7befa', 
			'OPP Welcome Character - For sending mails and messages to new players', 
			499, 
			2401,
			0);

GO
