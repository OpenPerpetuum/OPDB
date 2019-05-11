USE [perpetuumsa]
GO

------------------------------------------------
-- Welcome Chat message features and character
-- CREATE: premadechatmessage table
-- INSERT: account and character
-- A table of predefined chat messages is created with a name
-- by which to lookup chat messages on the server when being sent
-- A character are also created to allow the chat 
-- message to be sent from this character.
--
-- Date: 2019/05/08 
------------------------------------------------


DROP TABLE IF EXISTS dbo.premadechatmessage;
GO


/* Setup premadechatmessage */
CREATE TABLE dbo.premadechatmessage (
	id int primary key,
	name varchar(32) not null unique,
	message nvarchar(2000) not null
);
GO



INSERT INTO dbo.premadechatmessage (id, name, message)
VALUES (1, 'NewPlayerEnteredTheGame', '$NAME$ has entered the game.');

INSERT INTO dbo.premadechatmessage (id, name, message)
VALUES (2, 'NewPlayerFinishedTheTutorial', '$NAME$ has completed the tutorial, say Hello!');
GO

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
			((SELECT accountID FROM dbo.accounts where email = 'OPP_server_account'), --accountID
			8702057415139945528, 
			N'New Player Announcer', --nick
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
			'OPP Welcome Character - For sending chat messages to announce new players', 
			499, 
			2401,
			0);

GO
