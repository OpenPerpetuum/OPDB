USE [perpetuumsa]
GO

-------------------------------------------------
--INSERTS ENTITYDEFAULT****
--T0 EP boost item for Pitboss loot
--REQUIRED FOR PITBOSS LOOT PATCH
--Date: 2019/05/19
-------------------------------------------------



PRINT N'INSERT ENTITYDEFAULT def_boost_ep_t0';
--Insert a T0 variant EP boost item for Pitboss loot only
INSERT INTO [dbo].[entitydefaults]
           ([definitionname]
           ,[quantity]
           ,[attributeflags]
           ,[categoryflags]
           ,[options]
           ,[note]
           ,[enabled]
           ,[volume]
           ,[mass]
           ,[hidden]
           ,[health]
           ,[descriptiontoken]
           ,[purchasable]
           ,[tiertype]
           ,[tierlevel])
     VALUES
           ('def_boost_ep_t0'
           ,1
           ,2052
           ,1179
           ,'#addBoost=n1 #timePeriodHours=i1 #tier=$tierlevel_t0'
           ,'Adds 1 to the current EP multiplier for 1 hours'
           ,1
           ,1E-06
           ,1E-06
           ,0
           ,100
           ,'def_redeemable_ep_standard_desc'
           ,1
           ,1
           ,0);
GO

--Insert "despawn time" as the intended duration of the item as milliseconds
INSERT INTO dbo.aggregatevalues
(
	[definition],
	[field],
	[value]
)
VALUES
(
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_boost_ep_t0'),
	(SELECT TOP 1 id FROM dbo.aggregatefields WHERE name='despawn_time'),
	3600000
);

GO