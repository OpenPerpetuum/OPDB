USE [perpetuumsa]
GO

----------------------------------------------------------------
--Make Chassis Scanners offsensive module (pvp flag to use)
--Updates entitydefaults.attributeflags
--Date: 2020/03/21
----------------------------------------------------------------

PRINT N'UPDATING CHASSIS SCANNER TO BE OFFSENSIVE MODULE';
DECLARE @offset bigint;
SET @offset = (SELECT offset FROM attributeFlags WHERE name='offensive_module');

DECLARE @category bigint;
SET @category = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_chassis_scanner');

PRINT N'ENTITY DEFS TO BE UPDATED';
SELECT * FROM entitydefaults WHERE categoryflags=@category;

PRINT N'UPDATE ATTR FLAGS';
UPDATE entitydefaults SET
	attributeflags = attributeflags | POWER(2, @offset)
WHERE categoryflags=@category;

PRINT N'UPDATED ENTITY DEFS';
SELECT * FROM entitydefaults WHERE categoryflags=@category;

PRINT N'DONE WITH CHASSIS SCANNER FLAG UPDATE';
GO