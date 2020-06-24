USE [perpetuumsa]
GO

----------------------------------------------------------------
--Coreactor and Coprocessor make 1-per robot only
--Note: only the categoryflag isunique field matters, attributes on defs just for consistency
--Date: 2020/05/26
----------------------------------------------------------------


PRINT N'UPDATE entitydefaults and categoryFlags to make co/react/cpus 1-per-robot fit';
DECLARE @oneModuleFlag BIGINT;
SET @oneModuleFlag = POWER(2, (SELECT TOP 1 offset FROM attributeFlags WHERE name='onePerRobot'));

--This doesn't actually do anything, Deprecated? But change for consistency..
UPDATE entitydefaults SET
	attributeflags = attributeflags | @oneModuleFlag
WHERE categoryflags=(SELECT TOP 1 value FROM categoryFlags WHERE name='cf_cpu_upgrades');

UPDATE entitydefaults SET
	attributeflags = attributeflags | @oneModuleFlag
WHERE categoryflags=(SELECT TOP 1 value FROM categoryFlags WHERE name='cf_powergrid_upgrades');

--This actually matters
UPDATE categoryFlags SET
	isunique = 1
WHERE value = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_powergrid_upgrades') OR
value = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_cpu_upgrades');


GO