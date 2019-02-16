USE [perpetuumsa]
GO

delete from dbo.teleportdescriptions
where id = 403
and sourcezone = (select id from dbo.zones where name = 'zone_pvp_arena' and note = 'pvp arena')
and targetzone = (select id from dbo.zones where name = 'zone_TM' and note = 'new virginia');

GO
