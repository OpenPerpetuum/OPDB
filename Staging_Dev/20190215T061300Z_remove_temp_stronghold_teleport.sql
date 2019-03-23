USE [perpetuumsa]
GO

delete from dbo.teleportdescriptions
where description = 'tp_zone_39_3_to_teleport_column_tm_maddis_Z'
and sourcezone = (select id from dbo.zones where name = 'zone_pvp_arena' and note = 'pvp arena')
and targetzone = (select id from dbo.zones where name = 'zone_TM' and note = 'new virginia');

GO
