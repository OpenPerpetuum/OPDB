USE [perpetuumsa]
GO

-- ZONE

INSERT INTO [dbo].[zones]
(
[id],
[x],
[y],
[name],
[description],
[note],
[fertility],
[zoneplugin],
[zoneip],
[zoneport],
[isinstance],
[enabled],
[spawnid],
[plantruleset],
[protected],
[raceid],
[width],
[height],
[terraformable],
[zonetype],
[sparkcost],
[maxdockingbase],
[sleeping],
[plantaltitudescale],
[host],
[active]
)
VALUES
(
1024,
8700,
8700,
'zone_1024',
'zone_1024_desc',
'Empty Zone',
20,
'zone_1024',
'',
'',
0,
1,
0,
0,
0,
0,
1024,
1024,
0,
1,
0,
0,
0,
1,
'',
1
);

-- Entity for zone storage

INSERT INTO entities
(
[eid],
[definition],
[health],
[ename],
[quantity],
[repackaged]
)
VALUES
(
1670,
2735,
100,
'zone_1024_storage',
1,
0
);

-- zone storage.

INSERT INTO entitystorage
(
[storage_name],
[eid]
)
VALUES
(
'es_zone_1024_storage',
1670
);
