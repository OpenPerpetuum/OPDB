USE [perpetuumsa]
GO


PRINT N'Property Modifier Table entry to support Hermes bonus relations';
--Add moduleproperty modifier to allow hermes chassis bonus to apply to geoscanners

--Allows for the mining_probe_cycle_time_intrusion_modifier
--to modify all cf_mining_probes (geoscanners) to modify cycle_time
INSERT INTO [dbo].[modulepropertymodifiers]
           ([categoryflags]
           ,[basefield]
           ,[modifierfield])
     VALUES
           ((SELECT TOP 1 value FROM categoryFlags where name='cf_mining_probes')
           ,(SELECT TOP 1 aggregatefields.id FROM aggregatefields where name='cycle_time')
           ,(SELECT TOP 1 aggregatefields.id FROM aggregatefields where name='mining_probe_cycle_time_intrusion_modifier'))
GO


