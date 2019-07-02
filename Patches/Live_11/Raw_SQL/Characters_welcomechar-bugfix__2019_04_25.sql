USE [perpetuumsa]
GO

-------------------------------------------------
--Set the Welcome Character to have an avatar and cool corp and alliance
--Fixes bug where account was not properly assigned!
--Date: 2019/04/25
------------------------------------------------

UPDATE dbo.characters
SET accountID=(SELECT TOP 1 dbo.accounts.accountID FROM dbo.accounts WHERE email='OPP_server_account' AND note='SERVER DEFINED ACCOUNT for server-characters, do not login, do not unban'),
allianceeid=(SELECT TOP 1 id FROM dbo.alliances WHERE name='syndicate_police_alliance'),
corporationeid=(SELECT TOP 1 eid FROM dbo.corporations WHERE name='syndicate_police_central'),
avatar='#background=i1#morph00=tFA7E6A3E#morph01=t0000803F#morph02=t96438BBC#morph03=t000000BF#morph04=t931884BE#morph05=tB29DEF3E#morph06=t96438BBC#morph07=t1D5A043F#morph08=t6DE7FB3E#morph09=tFCA9B13E#morph10=t6F12233F#morph11=tF2D24D3E#morph12=t931884BE#morph13=t0000803F#morph14=t0000803F#morph15=t000000BF#morph16=tE5D0E23E#morph17=t0000803F#morph18=t46B6F3BE#morph19=t91ED1C3F#morph20=t2FDDA43E#morph21=t2B87D63E#morph22=t6F12033C#morph23=tA245363E#morph24=t9318043E#morph25=t000000BF#morph26=t6F12033D#morph27=t8716993E#morph28=t0000803E#morph29=t508D373F#morph30=t6F1283BD#morph31=t0000803F#camerax=t000080BE#cameray=t0000003F#light1posx=tAAF152BE#light1posy=tA8C64B3E#light1posz=tBE9F1ABE#light1color=Lffffffff#light2posx=t4260E53B#light2posy=t7F6ABCBC#light2posz=tE17A94BE#light2color=Lff245913#eyex=tCFF7D33E#eyey=t1904D63E#eyecolor=Lff67442e#body=i0#bodycolor=Lffffffff#hair=i8#haircolor=Lff888888#beard=i8#eyebrow=i4#beardcolor=Lff000607#tattoo=i3#tattoocolor=Lffffffff#facecolor=Lff454a73'
WHERE nick='[OPP] Sparky - The Syndicate Welcome Agent'
AND lastdocked is NULL
AND lastteleported is NULL
AND zoneID is NULL;

GO