USE [perpetuumsa]
GO

------ Injector chargers reduced and T1 items reduced

UPDATE [dbo].[siegeitems]
   SET [minquantity] = 10
      ,[maxquantity] = 50
WHERE definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_corebooster_ammo');

UPDATE [dbo].[siegeitems]
   SET [minquantity] = 1
      ,[maxquantity] = 5
WHERE definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_standard_core_recharger');

UPDATE [dbo].[siegeitems]
   SET [minquantity] = 1
      ,[maxquantity] = 5
WHERE definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_standard_cpu_upgrade');

UPDATE [dbo].[siegeitems]
   SET [minquantity] = 1
      ,[maxquantity] = 5
WHERE definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_standard_medium_core_battery');

UPDATE [dbo].[siegeitems]
   SET [definition] = 42
      ,[minquantity] = 1
      ,[maxquantity] = 5
WHERE definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_standard_powergrid_upgrades');

UPDATE [dbo].[siegeitems]
   SET [minquantity] = 1
      ,[maxquantity] = 5
WHERE definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_standard_small_core_battery');
GO




