USE [perpetuumsa]
GO


DECLARE @effectName nvarchar(50);
DECLARE @effectNote nvarchar(2048);
DECLARE @categoryBit bigint;
DECLARE @categoryFlag bigint;

SET @effectName = 'effect_beta_bonus';
SET @effectNote = 'bonus to beta';

SET @categoryFlag = 44; --Must be unique! See: Perpetuum.ExportedTypes.EffectCategory
SET @categoryBit = 17592186044416; --2^44 

PRINT N'New Effect/aura configuration';

PRINT N'1.  Create new category (if necesary)';
INSERT INTO [dbo].[effectcategories]
           ([name]
           ,[flag]
           ,[maxlevel]
           ,[note])
     VALUES
           ('effcat_zone_beta'
           ,@categoryFlag
           ,1
           ,'Effect to apply to all players on pvp zone');

PRINT N'2.  Create Effect';
--new effect of new category
  INSERT INTO [dbo].[effects]
           ([effectcategory]
           ,[duration]
           ,[name]
           ,[description]
           ,[note]
           ,[isaura]
           ,[auraradius]
           ,[ispositive]
           ,[display]
           ,[saveable])
     VALUES
           (@categoryBit
           ,0
           ,@effectName
           ,'effect_pbs_industry_lvl3_desc'
           ,@effectNote
           ,1
           ,0
           ,1
           ,1
           ,0);

PRINT N'3.  Effect properties';
--new effects properties
INSERT INTO [dbo].[effectdefaultmodifiers]
           ([effectid],[field],[value])
     VALUES
           ((SELECT TOP 1 id FROM effects WHERE effects.name = @effectName)
           ,(SELECT TOP 1 id FROM aggregatefields WHERE aggregatefields.name = 'effect_harvesting_amount_modifier')
           ,1.25);

INSERT INTO [dbo].[effectdefaultmodifiers]
           ([effectid],[field],[value])
     VALUES
           ((SELECT TOP 1 id FROM effects WHERE effects.name = @effectName)
           ,(SELECT TOP 1 id FROM aggregatefields WHERE aggregatefields.name = 'effect_mining_amount_modifier')
           ,1.25);
GO