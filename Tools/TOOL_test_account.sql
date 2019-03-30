USE [perpetuumsa]
GO
INSERT [dbo].[accountonlinetime] ([accountid], [loggedin], [loggedout], [ip], [safelogout], [hwhash], [istrial]) VALUES (8, CAST(N'2019-03-17T01:00:55.633' AS DateTime), CAST(N'2019-03-17T01:05:07.003' AS DateTime), N'127.0.0.1', 0, N'none', 0)
GO
SET IDENTITY_INSERT [dbo].[accounts] ON 
GO

DECLARE @PASSWORD_TEMP varbinary(40);
SET @PASSWORD_TEMP = HASHBYTES('SHA1', 'test');
DECLARE @PASSWORD varchar(40);
SET @PASSWORD = CONVERT(varchar(40), @PASSWORD_TEMP, 2);
INSERT [dbo].[accounts] ([accountID], [email], [password], [firstName], [lastName], [born], [state], [accLevel], [totalMinsOnline], [lastLoggedIn], [creation], [clientType], [isLoggedIn], [bantime], [banlength], [bannote], [emailConfirmed], [firstcharacter], [note], [steamID], [twitchAuthToken], [credit], [isactive], [resetcount], [wasreset], [validUntil], [payingcustomer], [campaignid]) VALUES (8, N'test', @PASSWORD, NULL, NULL, NULL, 1, 14, 4, CAST(N'2019-03-17T01:01:00' AS SmallDateTime), CAST(N'2019-03-17T01:01:00' AS SmallDateTime), 0, 0, CAST(N'2019-03-17T01:01:00' AS SmallDateTime), 120, NULL, 0, CAST(N'2019-03-17T01:01:39.680' AS DateTime), NULL, NULL, NULL, 0, 0, 0, 0, NULL, 0, N'{"host":"tooladmin"}')
GO
SET IDENTITY_INSERT [dbo].[accounts] OFF
GO
SET IDENTITY_INSERT [dbo].[characterextensions] ON 
GO
INSERT [dbo].[characterextensions] ([characterextensionid], [characterid], [extensionid], [extensionlevel]) VALUES (382, 2, 3, 3)
GO
INSERT [dbo].[characterextensions] ([characterextensionid], [characterid], [extensionid], [extensionlevel]) VALUES (378, 2, 23, 2)
GO
INSERT [dbo].[characterextensions] ([characterextensionid], [characterid], [extensionid], [extensionlevel]) VALUES (379, 2, 27, 4)
GO
INSERT [dbo].[characterextensions] ([characterextensionid], [characterid], [extensionid], [extensionlevel]) VALUES (380, 2, 28, 1)
GO
INSERT [dbo].[characterextensions] ([characterextensionid], [characterid], [extensionid], [extensionlevel]) VALUES (389, 2, 30, 2)
GO
INSERT [dbo].[characterextensions] ([characterextensionid], [characterid], [extensionid], [extensionlevel]) VALUES (381, 2, 45, 1)
GO
INSERT [dbo].[characterextensions] ([characterextensionid], [characterid], [extensionid], [extensionlevel]) VALUES (383, 2, 51, 1)
GO
INSERT [dbo].[characterextensions] ([characterextensionid], [characterid], [extensionid], [extensionlevel]) VALUES (373, 2, 63, 2)
GO
INSERT [dbo].[characterextensions] ([characterextensionid], [characterid], [extensionid], [extensionlevel]) VALUES (374, 2, 64, 2)
GO
INSERT [dbo].[characterextensions] ([characterextensionid], [characterid], [extensionid], [extensionlevel]) VALUES (376, 2, 74, 1)
GO
INSERT [dbo].[characterextensions] ([characterextensionid], [characterid], [extensionid], [extensionlevel]) VALUES (384, 2, 79, 2)
GO
INSERT [dbo].[characterextensions] ([characterextensionid], [characterid], [extensionid], [extensionlevel]) VALUES (385, 2, 83, 2)
GO
INSERT [dbo].[characterextensions] ([characterextensionid], [characterid], [extensionid], [extensionlevel]) VALUES (398, 2, 96, 2)
GO
INSERT [dbo].[characterextensions] ([characterextensionid], [characterid], [extensionid], [extensionlevel]) VALUES (387, 2, 141, 1)
GO
INSERT [dbo].[characterextensions] ([characterextensionid], [characterid], [extensionid], [extensionlevel]) VALUES (372, 2, 145, 1)
GO
INSERT [dbo].[characterextensions] ([characterextensionid], [characterid], [extensionid], [extensionlevel]) VALUES (388, 2, 154, 3)
GO
INSERT [dbo].[characterextensions] ([characterextensionid], [characterid], [extensionid], [extensionlevel]) VALUES (386, 2, 155, 3)
GO
INSERT [dbo].[characterextensions] ([characterextensionid], [characterid], [extensionid], [extensionlevel]) VALUES (391, 2, 158, 1)
GO
INSERT [dbo].[characterextensions] ([characterextensionid], [characterid], [extensionid], [extensionlevel]) VALUES (392, 2, 161, 1)
GO
INSERT [dbo].[characterextensions] ([characterextensionid], [characterid], [extensionid], [extensionlevel]) VALUES (393, 2, 169, 3)
GO
INSERT [dbo].[characterextensions] ([characterextensionid], [characterid], [extensionid], [extensionlevel]) VALUES (394, 2, 174, 2)
GO
INSERT [dbo].[characterextensions] ([characterextensionid], [characterid], [extensionid], [extensionlevel]) VALUES (377, 2, 219, 1)
GO
INSERT [dbo].[characterextensions] ([characterextensionid], [characterid], [extensionid], [extensionlevel]) VALUES (395, 2, 241, 2)
GO
INSERT [dbo].[characterextensions] ([characterextensionid], [characterid], [extensionid], [extensionlevel]) VALUES (390, 2, 250, 1)
GO
INSERT [dbo].[characterextensions] ([characterextensionid], [characterid], [extensionid], [extensionlevel]) VALUES (396, 2, 263, 2)
GO
INSERT [dbo].[characterextensions] ([characterextensionid], [characterid], [extensionid], [extensionlevel]) VALUES (397, 2, 270, 1)
GO
INSERT [dbo].[characterextensions] ([characterextensionid], [characterid], [extensionid], [extensionlevel]) VALUES (399, 2, 310, 1)
GO
INSERT [dbo].[characterextensions] ([characterextensionid], [characterid], [extensionid], [extensionlevel]) VALUES (400, 2, 312, 1)
GO
INSERT [dbo].[characterextensions] ([characterextensionid], [characterid], [extensionid], [extensionlevel]) VALUES (371, 2, 355, 1)
GO
INSERT [dbo].[characterextensions] ([characterextensionid], [characterid], [extensionid], [extensionlevel]) VALUES (370, 2, 357, 1)
GO
INSERT [dbo].[characterextensions] ([characterextensionid], [characterid], [extensionid], [extensionlevel]) VALUES (375, 2, 360, 2)
GO
SET IDENTITY_INSERT [dbo].[characterextensions] OFF
GO
SET IDENTITY_INSERT [dbo].[characters] ON 
GO
INSERT [dbo].[characters] ([characterID], [accountID], [rootEID], [nick], [moodMessage], [creation], [lastLogOut], [lastUsed], [credit], [inUse], [totalMinsOnline], [activeChassis], [active], [deletedAt], [baseEID], [defaultcorporationEID], [majorID], [raceID], [schoolID], [sparkID], [lastdocked], [docked], [lastteleported], [zoneID], [nickcorrected], [offensivenick], [positionX], [positionY], [homeBaseEID], [blockTrades], [globalMute], [avatar], [note], [corporationeid], [allianceeid], [language]) VALUES (2, 8, 8702057415139945528, N'test', NULL, CAST(N'2019-03-17T01:02:00' AS SmallDateTime), CAST(N'2019-03-17T01:05:00' AS SmallDateTime), CAST(N'2019-03-17T01:02:00' AS SmallDateTime), 500000000000, 0, 3, 8669878442849126445, 1, NULL, 142, 499, 5, 1, 2, 5, NULL, 1, NULL, NULL, 0, 0, NULL, NULL, 561, 0, 0, N'#background=i0#morph00=t0000803F#morph01=t00000000#morph02=t00000000#morph03=t6ABCF43E#morph04=t00000000#morph05=t250681BD#morph06=tDF4F0DBE#morph07=tFED4183F#morph08=t6666A63E#morph09=t8716993E#morph10=tE17A14BE#morph11=tFCA9713E#morph12=t00000000#morph13=tF0A746BE#morph14=t508D97BD#morph15=t0681153E#morph16=t00000000#morph17=t00000000#morph18=tC74BB7BE#morph19=t00000000#morph20=tF4FDD4BD#morph21=t21B0323F#morph22=t0681153E#morph23=t819583BE#morph24=tC74B373E#morph25=tCDCCCC3E#morph26=tD7A3F03E#morph27=t00000000#morph28=t00000000#morph29=t00000000#morph30=t00000000#morph31=t00000000#camerax=tD9CEF73D#cameray=tB6F3BD3E#light1posx=tCDCC4CBE#light1posy=t23DBB93E#light1posz=t2B8716BF#light1color=Lffffffff#light2posx=tEC51583F#light2posy=t5839343D#light2posz=tAC1C3ABF#light2color=Lff393939#eyex=tCDCC0C3F#eyey=t6F12033F#eyecolor=Lff67442e#body=i0#bodycolor=Lff572100#hair=i3#haircolor=Lff66809b#beard=i8#eyebrow=ia#beardcolor=Lff66809b#tattoo=i6#tattoocolor=Lff000000#facecolor=Lffb7befa', NULL, 499, 2401, 0)
GO
SET IDENTITY_INSERT [dbo].[characters] OFF
GO
INSERT [dbo].[charactersettings] ([characterid], [settingsstring]) VALUES (2, N'#hasBeenOnHelp=i1#hasBeenOnRecruitment=i1#visitedZones=42d,0,8#welcomeScreen=i1#tutorialTriggers=[|pseudotrigger_tutorialchecklist_introduction_usingthischecklist=i1|pseudotrigger_tutorialchecklist_introduction_uibasics=i1|pseudotrigger_tutorialchecklist_introduction_options=i1|pseudotrigger_tutorialchecklist_introduction_helpsupport=i1|trigger_joingeneralchat=i1|pseudotrigger_tutorialchecklist_essentials_terminals=i1|trigger_openprivatestorage=i1|trigger_activaterobot=i1|trigger_deploy=i1]')
GO
INSERT [dbo].[charactersparks] ([characterid], [sparkid], [active], [activationtime]) VALUES (2, 42, 1, CAST(N'2019-03-17T01:02:25.843' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[corporationhistory] ON 
GO
INSERT [dbo].[corporationhistory] ([characterID], [corporationEID], [corporationJoined], [corporationLeft], [id]) VALUES (2, 499, CAST(N'2019-03-17T01:02:00' AS SmallDateTime), NULL, 2)
GO
INSERT [dbo].[corporationhistory] ([characterID], [corporationEID], [corporationJoined], [corporationLeft], [id]) VALUES (2, 47422, CAST(N'2019-03-17T01:02:00' AS SmallDateTime), CAST(N'2019-03-17T01:02:00' AS SmallDateTime), 1)
GO
SET IDENTITY_INSERT [dbo].[corporationhistory] OFF
GO
SET IDENTITY_INSERT [dbo].[corporationmembers] ON 
GO
INSERT [dbo].[corporationmembers] ([id], [corporationEID], [memberid], [role]) VALUES (2, 499, 2, 0)
GO
SET IDENTITY_INSERT [dbo].[corporationmembers] OFF
GO
INSERT [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) VALUES (8702057415139945528, 3, NULL, 499, 100, NULL, 1, 0, N'')
GO
INSERT [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) VALUES (8758900007128751226, 3253, 8702057415139945528, 680, 100, NULL, 10, 0, N'')
GO
INSERT [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) VALUES (8290595696757209060, 891, 8702057415139945528, 680, 100, NULL, 400, 0, N'')
GO
INSERT [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) VALUES (8819961787815210286, 2932, 8702057415139945528, 680, 100, NULL, 20, 0, N'')
GO
INSERT [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) VALUES (6574840993063794961, 3254, 8702057415139945528, 680, 100, NULL, 5, 0, N'')
GO
INSERT [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) VALUES (7265365075055078727, 901, 8702057415139945528, 680, 100, NULL, 200, 0, N'')
GO
INSERT [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) VALUES (9026315727906586984, 5153, 8702057415139945528, 680, 100, NULL, 200, 0, N'')
GO
INSERT [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) VALUES (7356365623125163024, 888, 8702057415139945528, 680, 100, NULL, 500, 0, N'')
GO
INSERT [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) VALUES (8669878442849126445, 5, 8702057415139945528, 45006, 100, NULL, 1, 0, N'#decay=iff#armor=t0000803F#tint=c82.0.28.ff#currentcore=t00006143')
GO
INSERT [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) VALUES (4714745354150187967, 2374, 8702057415139945528, 5318436710320130030, 100, NULL, 45, 0, N'')
GO
INSERT [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) VALUES (6390242247659676284, 259, 8702057415139945528, 5896526872994473577, 100, NULL, 200, 0, N'')
GO
INSERT [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) VALUES (4821030570804769155, 2374, 8702057415139945528, 6262429094426133627, 100, NULL, 45, 0, N'')
GO
INSERT [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) VALUES (8659830082665460801, 2375, 8702057415139945528, 6262429094426133627, 100, NULL, 10, 0, N'')
GO
INSERT [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) VALUES (5795436455642734201, 259, 8702057415139945528, 6262429094426133627, 100, NULL, 200, 0, N'')
GO
INSERT [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) VALUES (7790860961864033977, 4570, 8702057415139945528, 6262429094426133627, 100, NULL, 1, 1, N'')
GO
INSERT [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) VALUES (5834831523434105543, 5158, 8702057415139945528, 6262429094426133627, 100, NULL, 40, 0, N'')
GO
INSERT [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) VALUES (8805172640914423400, 998, 8702057415139945528, 6262429094426133627, 100, NULL, 1, 1, N'')
GO
INSERT [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) VALUES (8021672084495569360, 1474, 8702057415139945528, 6262429094426133627, 100, NULL, 1, 1, N'')
GO
INSERT [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) VALUES (5896526872994473577, 998, 8702057415139945528, 7328952742780165317, 100, NULL, 1, 0, N'#slot=i1')
GO
INSERT [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) VALUES (5318436710320130030, 1474, 8702057415139945528, 7328952742780165317, 100, NULL, 1, 0, N'#slot=i2')
GO
INSERT [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) VALUES (4760986958159011996, 1475, 8702057415139945528, 7778931410082838398, 100, NULL, 1, 0, N'#slot=i1')
GO
INSERT [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) VALUES (6343803432240506695, 996, 8702057415139945528, 8453698831312650473, 100, NULL, 1, 0, N'#slot=i1')
GO
INSERT [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) VALUES (7397597343020212845, 997, 8702057415139945528, 8453698831312650473, 100, NULL, 1, 0, N'#slot=i2')
GO
INSERT [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) VALUES (7778931410082838398, 6, 8702057415139945528, 8669878442849126445, 100, NULL, 1, 0, N'')
GO
INSERT [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) VALUES (8453698831312650473, 8, 8702057415139945528, 8669878442849126445, 100, NULL, 1, 0, N'')
GO
INSERT [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) VALUES (7328952742780165317, 7, 8702057415139945528, 8669878442849126445, 100, NULL, 1, 0, N'')
GO
INSERT [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) VALUES (6262429094426133627, 326, 8702057415139945528, 8669878442849126445, 100, NULL, 1, 0, N'#log=i0')
GO

/* Unlock all skills */
DECLARE @char_id int;
SET @char_id = (SELECT characterID from dbo.characters where nick = 'test');


DECLARE @ext_id int;

DECLARE db_cursor CURSOR FOR 
SELECT extensionid 
FROM dbo.extensions

OPEN db_cursor  
FETCH NEXT FROM db_cursor INTO @ext_id  

WHILE @@FETCH_STATUS = 0  
BEGIN  
		exec dbo.setExtensionLevel @char_id, @ext_id, 10;

      FETCH NEXT FROM db_cursor INTO @ext_id 
END 

CLOSE db_cursor  
DEALLOCATE db_cursor 