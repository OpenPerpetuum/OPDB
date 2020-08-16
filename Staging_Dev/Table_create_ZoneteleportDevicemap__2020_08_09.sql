USE [perpetuumsa]
GO
------------------------------------------------------------------
-- A table to map mobile teleports to zones
-- Use: mobileStrongholdTeleports
-- Date modified: 2020/08/09
------------------------------------------------------------------


PRINT N'CREATE TABLE zoneteleportdevicemap';
DROP TABLE IF EXISTS dbo.zoneteleportdevicemap;
CREATE TABLE dbo.zoneteleportdevicemap(
	id INT NOT NULL IDENTITY PRIMARY KEY,
	sourcedefinition INT NOT NULL,
	zoneid INT NOT NULL
);


INSERT INTO dbo.zoneteleportdevicemap (sourcedefinition, zoneid) VALUES
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_mobile_teleport_stronghold_basic'),
(SELECT TOP 1 id FROM zones WHERE name='zone_pvp_arena' AND note='pvp arena' AND zonetype=4));

PRINT N'DONE CREATING TABLE zoneteleportdevicemap';
GO

