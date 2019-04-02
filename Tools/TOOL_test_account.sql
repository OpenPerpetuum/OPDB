USE [perpetuumsa]
GO

declare @AccountEmail varchar(50);
declare @PasswordInClear varchar(40);
declare @CharacterNick varchar(50);
declare @CharacterRootEID bigint;

set @AccountEmail = 'test';
set @PasswordInClear = 'test';
set @CharacterNick = 'test';
set @CharacterRootEID = 8702057415139945528;


/* SHA1 Hash the password */
declare @Password varchar(40);
set @Password = convert(varchar(40), hashbytes('SHA1', @PasswordInClear), 2);

insert into [dbo].[accounts] ([email], [password], [firstName], [lastName], [born], [state], [accLevel], [totalMinsOnline], [lastLoggedIn], [creation], [clientType], [isLoggedIn], [bantime], [banlength], [bannote], [emailConfirmed], [firstcharacter], [note], [steamID], [twitchAuthToken], [credit], [isactive], [resetcount], [wasreset], [validUntil], [payingcustomer], [campaignid]) 
values (@AccountEmail, @Password, NULL, NULL, NULL, 1, 14, 4, cast(N'2019-03-17T01:01:00' as SmallDateTime), cast(N'2019-03-17T01:01:00' as SmallDateTime), 0, 0, cast(N'2019-03-17T01:01:00' as SmallDateTime), 120, NULL, 0, cast(N'2019-03-17T01:01:39.680' as DateTime), NULL, NULL, NULL, 0, 0, 0, 0, NULL, 0, N'{"host":"tooladmin"}')
insert into [dbo].[characters] ([accountID], [rootEID], [nick], [moodMessage], [creation], [lastLogOut], [lastUsed], [credit], [inUse], [totalMinsOnline], [activeChassis], [active], [deletedAt], [baseEID], [defaultcorporationEID], [majorID], [raceID], [schoolID], [sparkID], [lastdocked], [docked], [lastteleported], [zoneID], [nickcorrected], [offensivenick], [positionX], [positionY], [homeBaseEID], [blockTrades], [globalMute], [avatar], [note], [corporationeid], [allianceeid], [language]) 
values ((select accountID from dbo.accounts where email = @AccountEmail), @CharacterRootEID, @CharacterNick, NULL, cast(N'2019-03-17T01:02:00' as SmallDateTime), cast(N'2019-03-17T01:05:00' as SmallDateTime), cast(N'2019-03-17T01:02:00' as SmallDateTime), 500000000000, 0, 3, 8669878442849126445, 1, NULL, 142, 499, 5, 1, 2, 5, NULL, 1, NULL, NULL, 0, 0, NULL, NULL, 561, 0, 0, N'#background=i0#morph00=t0000803F#morph01=t00000000#morph02=t00000000#morph03=t6ABCF43E#morph04=t00000000#morph05=t250681BD#morph06=tDF4F0DBE#morph07=tFED4183F#morph08=t6666A63E#morph09=t8716993E#morph10=tE17A14BE#morph11=tFCA9713E#morph12=t00000000#morph13=tF0A746BE#morph14=t508D97BD#morph15=t0681153E#morph16=t00000000#morph17=t00000000#morph18=tC74BB7BE#morph19=t00000000#morph20=tF4FDD4BD#morph21=t21B0323F#morph22=t0681153E#morph23=t819583BE#morph24=tC74B373E#morph25=tCDCCCC3E#morph26=tD7A3F03E#morph27=t00000000#morph28=t00000000#morph29=t00000000#morph30=t00000000#morph31=t00000000#camerax=tD9CEF73D#cameray=tB6F3BD3E#light1posx=tCDCC4CBE#light1posy=t23DBB93E#light1posz=t2B8716BF#light1color=Lffffffff#light2posx=tEC51583F#light2posy=t5839343D#light2posz=tAC1C3ABF#light2color=Lff393939#eyex=tCDCC0C3F#eyey=t6F12033F#eyecolor=Lff67442e#body=i0#bodycolor=Lff572100#hair=i3#haircolor=Lff66809b#beard=i8#eyebrow=ia#beardcolor=Lff66809b#tattoo=i6#tattoocolor=Lff000000#facecolor=Lffb7befa', NULL, 499, 2401, 0)

declare @CharacterID int;
set @CharacterID = (select characterID from dbo.characters where nick = @CharacterNick)

insert [dbo].[charactersettings] ([characterid], [settingsstring]) values (@CharacterID, N'#hasBeenOnHelp=i1#hasBeenOnRecruitment=i1#visitedZones=42d,0,8#welcomeScreen=i1#tutorialTriggers=[|pseudotrigger_tutorialchecklist_introduction_usingthischecklist=i1|pseudotrigger_tutorialchecklist_introduction_uibasics=i1|pseudotrigger_tutorialchecklist_introduction_options=i1|pseudotrigger_tutorialchecklist_introduction_helpsupport=i1|trigger_joingeneralchat=i1|pseudotrigger_tutorialchecklist_essentials_terminals=i1|trigger_openprivatestorage=i1|trigger_activaterobot=i1|trigger_deploy=i1]')
insert [dbo].[charactersparks] ([characterid], [sparkid], [active], [activationtime]) values (@CharacterID, 42, 1, cast(N'2019-03-17T01:02:25.843' as DateTime))
set identity_insert [dbo].[corporationhistory] ON 
insert [dbo].[corporationhistory] ([characterID], [corporationEID], [corporationJoined], [corporationLeft], [id]) values (@CharacterID, 499, cast(N'2019-03-17T01:02:00' as SmallDateTime), NULL, 2)
insert [dbo].[corporationhistory] ([characterID], [corporationEID], [corporationJoined], [corporationLeft], [id]) values (@CharacterID, 47422, cast(N'2019-03-17T01:02:00' as SmallDateTime), cast(N'2019-03-17T01:02:00' as SmallDateTime), 1)
set identity_insert [dbo].[corporationhistory] OFF
set identity_insert [dbo].[corporationmembers] ON 
insert [dbo].[corporationmembers] ([id], [corporationEID], [memberid], [role]) values (2, 499, 2, 0)
set identity_insert [dbo].[corporationmembers] OFF

/* Add noob bot to the character and starter kit */
insert [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) values (@CharacterRootEID, 3, NULL, 499, 100, NULL, 1, 0, N'')
insert [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) values (8758900007128751226, 3253, @CharacterRootEID, 680, 100, NULL, 10, 0, N'')
insert [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) values (8290595696757209060, 891, @CharacterRootEID, 680, 100, NULL, 400, 0, N'')
insert [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) values (8819961787815210286, 2932, @CharacterRootEID, 680, 100, NULL, 20, 0, N'')
insert [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) values (6574840993063794961, 3254, @CharacterRootEID, 680, 100, NULL, 5, 0, N'')
insert [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) values (7265365075055078727, 901, @CharacterRootEID, 680, 100, NULL, 200, 0, N'')
insert [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) values (9026315727906586984, 5153, @CharacterRootEID, 680, 100, NULL, 200, 0, N'')
insert [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) values (7356365623125163024, 888, @CharacterRootEID, 680, 100, NULL, 500, 0, N'')
insert [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) values (8669878442849126445, 5, @CharacterRootEID, 45006, 100, NULL, 1, 0, N'#decay=iff#armor=t0000803F#tint=c82.0.28.ff#currentcore=t00006143')
insert [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) values (4714745354150187967, 2374, @CharacterRootEID, 5318436710320130030, 100, NULL, 45, 0, N'')
insert [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) values (6390242247659676284, 259, @CharacterRootEID, 5896526872994473577, 100, NULL, 200, 0, N'')
insert [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) values (4821030570804769155, 2374, @CharacterRootEID, 6262429094426133627, 100, NULL, 45, 0, N'')
insert [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) values (8659830082665460801, 2375, @CharacterRootEID, 6262429094426133627, 100, NULL, 10, 0, N'')
insert [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) values (5795436455642734201, 259, @CharacterRootEID, 6262429094426133627, 100, NULL, 200, 0, N'')
insert [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) values (7790860961864033977, 4570, @CharacterRootEID, 6262429094426133627, 100, NULL, 1, 1, N'')
insert [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) values (5834831523434105543, 5158, @CharacterRootEID, 6262429094426133627, 100, NULL, 40, 0, N'')
insert [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) values (8805172640914423400, 998, @CharacterRootEID, 6262429094426133627, 100, NULL, 1, 1, N'')
insert [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) values (8021672084495569360, 1474, @CharacterRootEID, 6262429094426133627, 100, NULL, 1, 1, N'')
insert [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) values (5896526872994473577, 998, @CharacterRootEID, 7328952742780165317, 100, NULL, 1, 0, N'#slot=i1')
insert [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) values (5318436710320130030, 1474, @CharacterRootEID, 7328952742780165317, 100, NULL, 1, 0, N'#slot=i2')
insert [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) values (4760986958159011996, 1475, @CharacterRootEID, 7778931410082838398, 100, NULL, 1, 0, N'#slot=i1')
insert [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) values (6343803432240506695, 996, @CharacterRootEID, 8453698831312650473, 100, NULL, 1, 0, N'#slot=i1')
insert [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) values (7397597343020212845, 997, @CharacterRootEID, 8453698831312650473, 100, NULL, 1, 0, N'#slot=i2')
insert [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) values (7778931410082838398, 6, @CharacterRootEID, 8669878442849126445, 100, NULL, 1, 0, N'')
insert [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) values (8453698831312650473, 8, @CharacterRootEID, 8669878442849126445, 100, NULL, 1, 0, N'')
insert [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) values (7328952742780165317, 7, @CharacterRootEID, 8669878442849126445, 100, NULL, 1, 0, N'')
insert [dbo].[entities] ([eid], [definition], [owner], [parent], [health], [ename], [quantity], [repackaged], [dynprop]) values (6262429094426133627, 326, @CharacterRootEID, 8669878442849126445, 100, NULL, 1, 0, N'#log=i0')


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