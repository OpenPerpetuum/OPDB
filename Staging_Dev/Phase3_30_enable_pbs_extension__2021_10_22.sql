USE [perpetuumsa]
GO

----------------------------
--ENABLE AND SET PBS SKILL
--UNLOCKS RESEARCH TREE!
--
-- Date Modified: 2021/10/22
----------------------------

DECLARE @EXT_NAME AS VARCHAR(128) = 'ext_research_pbs';

UPDATE extensions SET
	active=1,
	hidden=0,
	price=405000,
	rank=9
WHERE extensionname=@EXT_NAME AND extensionid=350;

GO
