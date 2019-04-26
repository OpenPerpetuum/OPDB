USE [perpetuumsa]
GO

-------------------------------------------
--Remove (disable) Teleport on Omega
--Date: 2019/04/01
-------------------------------------------


UPDATE dbo.zoneentities SET
enabled=0
WHERE 
ename='tp_zone_16_1' AND
zoneID = (SELECT TOP 1 id FROM dbo.zones WHERE name='zone_pvp_arena');

GO