USE [perpetuumsa]
GO


---------------------------------------------------------
-- Add table to configure rifts and level per zone
-- 
-- Date: 2020/08/03
---------------------------------------------------------


DROP TABLE IF EXISTS dbo.zoneriftsconfig;

CREATE TABLE dbo.zoneriftsconfig (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	zoneid INT NOT NULL UNIQUE,
	maxrifts INT NOT NULL,
	maxlevel INT NOT NULL
);

INSERT zoneriftsconfig (zoneid, maxrifts, maxlevel) VALUES
((SELECT TOP 1 id FROM zones WHERE name='zone_TM' AND note='new virginia'), 10, 1),
((SELECT TOP 1 id FROM zones WHERE name='zone_ICS' AND note='attalica'), 10, 1),
((SELECT TOP 1 id FROM zones WHERE name='zone_ASI' AND note='daoden'), 10, 1),
((SELECT TOP 1 id FROM zones WHERE name='zone_ICS_A_real' AND note='domhalarn'), 10, 2),
((SELECT TOP 1 id FROM zones WHERE name='zone_ASI_A_real' AND note='hokkogaros'), 10, 2),
((SELECT TOP 1 id FROM zones WHERE name='zone_TM_A_real' AND note='norhoop'), 10, 2),
((SELECT TOP 1 id FROM zones WHERE name='zone_ICS_pve' AND note='tellesis'), 10, 1),
((SELECT TOP 1 id FROM zones WHERE name='zone_ASI_pve' AND note='shinjalar'), 10, 1),
((SELECT TOP 1 id FROM zones WHERE name='zone_TM_pve' AND note='hershfield'), 10, 1),
((SELECT TOP 1 id FROM zones WHERE name='zone_ASI_pvp' AND note='kentagura'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_TM_pvp' AND note='alsbale'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_ICS_pvp' AND note='novastrov'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_tm_g_1'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_tm_g_2'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_tm_g_3'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_tm_g_4'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_tm_g_5'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_tm_g_6'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_tm_g_7'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_tm_g_8'), 10, 3),

((SELECT TOP 1 id FROM zones WHERE name='zone_ics_g_1'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_ics_g_2'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_ics_g_3'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_ics_g_4'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_ics_g_5'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_ics_g_6'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_ics_g_7'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_ics_g_8'), 10, 3),

((SELECT TOP 1 id FROM zones WHERE name='zone_asi_g_1'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_asi_g_2'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_asi_g_3'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_asi_g_4'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_asi_g_5'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_asi_g_6'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_asi_g_7'), 10, 3),
((SELECT TOP 1 id FROM zones WHERE name='zone_asi_g_8'), 10, 3);

GO