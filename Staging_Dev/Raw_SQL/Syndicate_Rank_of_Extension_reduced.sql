USE [perpetuumsa]
GO

UPDATE [dbo].[extensions]
   SET [extensionid] = 361
      ,[extensionname] = 'ext_syndicate_industry_specialist'
      ,[category] = 13
      ,[rank] = 6
      ,[targetlearningattribute] = NULL
      ,[learningattributeprimary] = 'attributeA'
      ,[learningattributesecondary] = 'attributeB'
      ,[bonus] = .01
      ,[note] = NULL
      ,[price] = 180000
      ,[active] = 1
      ,[description] = 'ext_syndicate_industry_specialist_desc'
      ,[targetpropertyID] = NULL
      ,[effectenhancer] = 0
      ,[hidden] = 0
      ,[freezelimit] = 7
 WHERE extensionid=361

UPDATE [dbo].[extensions]
   SET [extensionid] = 360
      ,[extensionname] = 'ext_syndicate_combat_specialist'
      ,[category] = 13
      ,[rank] = 6
      ,[targetlearningattribute] = NULL
      ,[learningattributeprimary] = 'attributeA'
      ,[learningattributesecondary] = 'attributeB'
      ,[bonus] = .01
      ,[note] = NULL
      ,[price] = 180000
      ,[active] = 1
      ,[description] = 'ext_syndicate_combat_specialist_desc'
      ,[targetpropertyID] = NULL
      ,[effectenhancer] = 0
      ,[hidden] = 0
      ,[freezelimit] = 7
 WHERE extensionid=360