USE [perpetuumsa]
GO

--Add Prismo to New Virginia and Hershfield
INSERT INTO [dbo].[plantrules]
           ([plantrule]
           ,[rulesetid]
           ,[note])
     VALUES
           ('irontree_lo.txt'
           ,0
           ,'tm_pve')
GO

--Add Wild Noralgis to Betas
INSERT INTO [dbo].[plantrules]
           ([plantrule]
           ,[rulesetid]
           ,[note])
     VALUES
           ('electroplant_lo_beta.txt'
           ,3
           ,'ics pvp')

INSERT INTO [dbo].[plantrules]
           ([plantrule]
           ,[rulesetid]
           ,[note])
     VALUES
           ('electroplant_lo_beta.txt'
           ,4
           ,'asi pvp')

INSERT INTO [dbo].[plantrules]
           ([plantrule]
           ,[rulesetid]
           ,[note])
     VALUES
           ('electroplant_lo_beta.txt'
           ,5
           ,'TM pvp')
GO

