USE [perpetuumsa]
GO

/* Setup premademail */
create table dbo.premademail (
	id int primary key,
	subject nvarchar(128) not null,
	body nvarchar(2000) not null
);

insert into dbo.premademail (id, subject, body)
values (1, 'Welcome $USER$!', 'Welcome $USER$ to the to the world of Perpetuum!
You can get more help resources on the Open Perpetuum website: https://openperpetuum.com/
We are currently located in the Sagittarius constellation in the M54 globular cluster.
To be more specific, on the planet Nia.
There is a vast world to explore, gather resources, refining, manufacturing, etc.');

insert into dbo.premademail (id, subject, body)
values (2, 'Welcome again $USER$!', 'Placeholder');

/* Setup overlord character */
DECLARE @PASSWORD_TEMP varbinary(40);
SET @PASSWORD_TEMP = HASHBYTES('SHA1', 'overlord');
DECLARE @PASSWORD varchar(40);
SET @PASSWORD = CONVERT(varchar(40), @PASSWORD_TEMP, 2);

INSERT INTO [dbo].[accounts] ([email], [password], [firstName], [lastName], [born], [state], [accLevel], 
[totalMinsOnline], [lastLoggedIn], [creation], [clientType], [isLoggedIn], [bantime], [banlength], [bannote], 
[emailConfirmed], [firstcharacter], [note], [steamID], [twitchAuthToken], [credit], [isactive], [resetcount], 
[wasreset], [validUntil], [payingcustomer], [campaignid]) 
VALUES (N'overlord', @PASSWORD, NULL, NULL, NULL, 1, 14, 4, CAST(N'2019-03-17T01:01:00' AS SmallDateTime), 
CAST(N'2019-03-17T01:01:00' AS SmallDateTime), 0, 0, CAST(N'2019-03-17T01:01:00' AS SmallDateTime), 0, NULL, 
0, CAST(N'2019-03-17T01:01:39.680' AS DateTime), NULL, NULL, NULL, 0, 0, 0, 0, NULL, 0, N'{"host":"tooladmin"}')

INSERT INTO [dbo].[characters] ([accountID], [rootEID], [nick], [moodMessage], [creation], 
[lastLogOut], [lastUsed], [credit], [inUse], [totalMinsOnline], [activeChassis], [active], [deletedAt], 
[baseEID], [defaultcorporationEID], [majorID], [raceID], [schoolID], [sparkID], [lastdocked], [docked], 
[lastteleported], [zoneID], [nickcorrected], [offensivenick], [positionX], [positionY], [homeBaseEID], 
[blockTrades], [globalMute], [avatar], [note], [corporationeid], [allianceeid], [language]) 
VALUES ((SELECT accountID FROM dbo.accounts where email = 'overlord'), 8702057415139945528, N'overlord', NULL, CAST(N'2019-03-17T01:02:00' AS SmallDateTime), 
CAST(N'2019-03-17T01:05:00' AS SmallDateTime), CAST(N'2019-03-17T01:02:00' AS SmallDateTime), 500000000000, 0, 
3, 8669878442849126445, 1, NULL, 142, 499, 5, 1, 2, 5, NULL, 1, NULL, NULL, 0, 0, NULL, NULL, 561, 0, 0, 
N'#background=i0#morph00=t0000803F#morph01=t00000000#morph02=t00000000#morph03=t6ABCF43E#morph04=t00000000#morph05=t250681BD#morph06=tDF4F0DBE#morph07=tFED4183F#morph08=t6666A63E#morph09=t8716993E#morph10=tE17A14BE#morph11=tFCA9713E#morph12=t00000000#morph13=tF0A746BE#morph14=t508D97BD#morph15=t0681153E#morph16=t00000000#morph17=t00000000#morph18=tC74BB7BE#morph19=t00000000#morph20=tF4FDD4BD#morph21=t21B0323F#morph22=t0681153E#morph23=t819583BE#morph24=tC74B373E#morph25=tCDCCCC3E#morph26=tD7A3F03E#morph27=t00000000#morph28=t00000000#morph29=t00000000#morph30=t00000000#morph31=t00000000#camerax=tD9CEF73D#cameray=tB6F3BD3E#light1posx=tCDCC4CBE#light1posy=t23DBB93E#light1posz=t2B8716BF#light1color=Lffffffff#light2posx=tEC51583F#light2posy=t5839343D#light2posz=tAC1C3ABF#light2color=Lff393939#eyex=tCDCC0C3F#eyey=t6F12033F#eyecolor=Lff67442e#body=i0#bodycolor=Lff572100#hair=i3#haircolor=Lff66809b#beard=i8#eyebrow=ia#beardcolor=Lff66809b#tattoo=i6#tattoocolor=Lff000000#facecolor=Lffb7befa', 
NULL, 499, 2401, 0)

GO
