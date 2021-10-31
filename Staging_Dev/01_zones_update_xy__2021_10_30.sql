USE [perpetuumsa]
GO

-------------------------------------------
-- Phase 2 map tweaks
--
-- Date Modified: 2021/10/30
-------------------------------------------

DROP TABLE IF EXISTS #ZONEMAP;
CREATE TABLE #ZONEMAP(
	zoneId int,
	x int,
	y int
);
INSERT INTO #ZONEMAP (zoneId, x, y) VALUES
((SELECT TOP 1 id FROM zones WHERE name='zone_gamma_tc_z101'), 774, -36500),
((SELECT TOP 1 id FROM zones WHERE name='zone_gamma_tc_z104'), 2147, -15026),
((SELECT TOP 1 id FROM zones WHERE name='zone_gamma_z110'), 1435, -21223);

MERGE [dbo].[zones] AS z
USING #ZONEMAP AS m
ON m.zoneId=z.id
WHEN MATCHED THEN
	UPDATE SET
		x=m.x,
		y=m.y;

GO