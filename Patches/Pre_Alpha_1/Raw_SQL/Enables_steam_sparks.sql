USE [perpetuumsa]
GO

UPDATE [dbo].[sparks]
   SET [sparkname] = 'spark_steam_a'
      ,[unlockprice] = NULL
      ,[energycredit] = NULL
      ,[standinglimit] = NULL
      ,[definition] = NULL
      ,[quantity] = 1
      ,[changeprice] = 100000
      ,[displayorder] = 531
      ,[defaultspark] = 'False'
      ,[icon] = 'icon_spark_steam_a'
      ,[hidden] = 'false'
      ,[note] = NULL
      ,[allianceeid] = NULL
      ,[alliancename] = NULL
      ,[unlockable] = 'true'
 WHERE ID=53

 UPDATE [dbo].[sparks]
   SET [sparkname] = 'spark_steam_b'
      ,[unlockprice] = NULL
      ,[energycredit] = NULL
      ,[standinglimit] = NULL
      ,[definition] = NULL
      ,[quantity] = 1
      ,[changeprice] = 100000
      ,[displayorder] = 532
      ,[defaultspark] = 'False'
      ,[icon] = 'icon_spark_steam_b'
      ,[hidden] = 'false'
      ,[note] = NULL
      ,[allianceeid] = NULL
      ,[alliancename] = NULL
      ,[unlockable] = 'true'
 WHERE ID=54


GO


