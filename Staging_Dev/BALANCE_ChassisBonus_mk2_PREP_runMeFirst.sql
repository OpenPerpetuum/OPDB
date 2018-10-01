USE [perpetuumsa]
GO

--MK2 CHASSISBONUS PREP SCRIPT--
--Clears ALL current mk2 bonuses, and replaces with new entries that are copies of their mk1 counterparts
--This is to be run BEFORE!!! any additions/changes to MK2 bonuses
--The intent is to capture all mk1 bonuses changes, and then selectively add the new mk2 bonus
--


--Robot part category - for entitydefault lookup
DECLARE @cf_robot_component bigint;
SET @cf_robot_component = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_robot_components');

DROP TABLE IF EXISTS #TEMP
DROP TABLE IF EXISTS #MK1TOMK2DEF

--Table to map the definitonnames
CREATE TABLE #TEMP
( 
  mk1defname varchar(100),
  mk2defname varchar(100)
);

--Table to map actual definitons
CREATE TABLE #MK1TOMK2DEF
( 
  mk1def int,
  mk2def int
);

INSERT INTO #TEMP (mk1defname, mk2defname)
SELECT REPLACE(definitionname, '_mk2', ''), definitionname from entitydefaults 
WHERE definitionname in (SELECT definitionname FROM entitydefaults WHERE definitionname like '%_mk2%' and categoryflags = categoryflags | @cf_robot_component);

INSERT INTO #MK1TOMK2DEF (mk1def, mk2def)
SELECT 
(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=mk1defname), 
(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=mk2defname)
 FROM #TEMP;

--REMOVE ALL CURRENT MK2 BONUSES
DELETE FROM chassisbonus
where chassisbonus.definition in (SELECT mk2def FROM #MK1TOMK2DEF)


--INSERT MK1 BONUSES TO ALL MK2 DEFINITONS (mk2 bonuses are mk1 + extra) -- Assumes mk1 bonuses are entact!
INSERT INTO [dbo].[chassisbonus]
           ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
SELECT mk2def, extension, bonus, note, targetpropertyID, effectenhancer from chassisbonus
join #MK1TOMK2DEF on chassisbonus.definition=mk1def;


--cleanup garbage
DROP TABLE IF EXISTS #TEMP
DROP TABLE IF EXISTS #MK1TOMK2DEF
GO

