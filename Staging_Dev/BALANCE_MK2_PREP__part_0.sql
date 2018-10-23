USE [perpetuumsa]
GO

--MK2 CHASSISBONUS AND AGGREGATEVALUES PREP SCRIPT--
--Clears ALL current mk2 bonuses, and replaces with new entries that are copies of their mk1 counterparts
--Sets ALL current mk2 stats (aggregatevalues) to be equivalent to their mk1 counterparts
--This is to be run BEFORE!!! any additions/changes to MK2 bonuses and bot stats
--The intent is to capture all mk1 stat and bonus changes, and then selectively add and modify mk2 attributes
--


PRINT N'MK2 BALANCE PREP SCRIPT - SETS ALL MK2 BONUSES AND AGGVALUE STATS TO MK1 STATE';
PRINT N'MK1 CHANGES SHOULD BE COMPLETED BEFORE THIS SCRIPT IS RUN!';

--Robot part category - for entitydefault lookup
DECLARE @cf_robot_component bigint;
SET @cf_robot_component = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_robot_components');

DROP TABLE IF EXISTS #TEMP
DROP TABLE IF EXISTS #MK1TOMK2DEF
DROP TABLE IF EXISTS #MK1TOMK2VALS

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

--Table to map aggregateValues
CREATE TABLE #MK1TOMK2VALS
(
	mk1def int,
	mk2def int,
	field int,
	value float
);

--Relate mk1 and mk2 components with string manipulation on definitionnames (!)
INSERT INTO #TEMP (mk1defname, mk2defname)
SELECT REPLACE(definitionname, '_mk2', ''), definitionname from entitydefaults 
WHERE definitionname in (SELECT definitionname FROM entitydefaults WHERE definitionname like '%_mk2%' and categoryflags = categoryflags | @cf_robot_component);

--Create map between mk1 and mk2 definitions
INSERT INTO #MK1TOMK2DEF (mk1def, mk2def)
SELECT 
(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=mk1defname), 
(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=mk2defname)
 FROM #TEMP;


--mk1-mk2 pairs with aggfield and value of the mk1 definition
INSERT INTO #MK1TOMK2VALS (mk1def, mk2def, field, value)
SELECT mk1def, mk2def, field, value FROM aggregatevalues
JOIN #MK1TOMK2DEF ON aggregatevalues.definition=mk1def
WHERE mk1def = aggregatevalues.definition

--BOT STATS
--UPDATE ALL OF THE MK2 AGGVALUES TO MK1 STATE
UPDATE aggregatevalues
SET value = mk2Vals.value
FROM aggregatevalues AS aggVals
JOIN #MK1TOMK2VALS AS mk2Vals ON mk2Vals.mk2def=aggVals.definition AND mk2Vals.field=aggVals.field

--BONUSES
--REMOVE ALL CURRENT MK2 BONUSES
DELETE FROM chassisbonus
WHERE chassisbonus.definition IN (SELECT mk2def FROM #MK1TOMK2DEF)

--INSERT MK1 BONUSES TO ALL MK2 DEFINITONS (mk2 bonuses are mk1 + extra) -- Assumes mk1 bonuses are entact!
INSERT INTO [dbo].[chassisbonus]
           ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
SELECT mk2def, extension, bonus, note, targetpropertyID, effectenhancer FROM chassisbonus
JOIN #MK1TOMK2DEF ON chassisbonus.definition=mk1def;


--cleanup garbage
DROP TABLE IF EXISTS #TEMP
DROP TABLE IF EXISTS #MK1TOMK2DEF
DROP TABLE IF EXISTS #MK1TOMK2VALS

PRINT N'MK2 AGGVALUE-STATS AND BONUSES ARE NOW == TO MK1';
GO

