USE [perpetuumsa]
GO

-----------------------------------------------
-- Flux mining amount extensions
-- Adds 2 new modifier fields that must be enumerated and mapped in server enums!
-- Date Modified: 2021/05/02
-----------------------------------------------

DECLARE @miningAmountFieldID AS INT = 662;
DECLARE @miningAmountFieldName AS VARCHAR(100) = 'mining_amount_flux_modifier';
DECLARE @miningAmountSkillName AS VARCHAR(100) = 'ext_flux_miner_expert';

DECLARE @miningCycleFieldID AS INT = 663;
DECLARE @miningCycleFieldName AS VARCHAR(100) = 'mining_cycle_time_flux_modifier';
DECLARE @miningCycleSkillName AS VARCHAR(100) = 'ext_flux_mining_buffer_expert';

IF NOT EXISTS (SELECT TOP 1 id FROM dbo.aggregatefields WHERE name = @miningAmountFieldName)
BEGIN
PRINT N'INSERTING '+@miningAmountFieldName;
	SET IDENTITY_INSERT dbo.aggregatefields ON;
	INSERT INTO dbo.aggregatefields(id, name, formula, measurementunit, measurementmultiplier, measurementoffset, category, digits, moreisbetter, usedinconfig, note) VALUES
	(@miningAmountFieldID, @miningAmountFieldName, 0, @miningAmountFieldName+'_desc', 100, 0, 6, 2, 1, 1, 'Flux mining modifier');
	SET IDENTITY_INSERT dbo.aggregatefields OFF;
END

IF NOT EXISTS (SELECT TOP 1 extensionid FROM dbo.extensions WHERE extensionname = @miningAmountSkillName)
BEGIN
	PRINT N'INSERTING extensions '+@miningAmountSkillName;
	INSERT INTO dbo.extensions(extensionname, category, rank, targetlearningattribute, learningattributeprimary, learningattributesecondary, bonus, note, price, active, description, targetpropertyID, effectenhancer, hidden, freezelimit) VALUES
	(@miningAmountSkillName, 15, 7, NULL, 'attributeC', 'attributeB', 0.03, 'Flux mining skill', 245000, 1, @miningAmountSkillName+'_desc', @miningAmountFieldID, 0, 0, 7);
END


IF NOT EXISTS (SELECT TOP 1 id FROM dbo.aggregatefields WHERE name = @miningCycleFieldName)
BEGIN
	PRINT N'INSERTING aggregatefields '+@miningCycleFieldName;
	SET IDENTITY_INSERT dbo.aggregatefields ON;
	INSERT INTO dbo.aggregatefields(id, name, formula, measurementunit, measurementmultiplier, measurementoffset, category, digits, moreisbetter, usedinconfig, note) VALUES
	(@miningCycleFieldID, @miningCycleFieldName, 2, @miningCycleFieldName+'_unit', 100, -100, 6, 0, 0, 1, 'Flux mining cycle modifier');
	SET IDENTITY_INSERT dbo.aggregatefields OFF;
END


IF NOT EXISTS (SELECT TOP 1 extensionid FROM dbo.extensions WHERE extensionname = @miningCycleSkillName)
BEGIN
	PRINT N'INSERTING extensions '+@miningCycleSkillName;
	INSERT INTO dbo.extensions(extensionname, category, rank, targetlearningattribute, learningattributeprimary, learningattributesecondary, bonus, note, price, active, description, targetpropertyID, effectenhancer, hidden, freezelimit) VALUES
	(@miningCycleSkillName, 15, 7, NULL, 'attributeC', 'attributeB', 0.01, 'Flux mining skill', 245000, 1, @miningCycleSkillName+'_desc', @miningCycleFieldID, 0, 0, 7);
END


DROP TABLE IF EXISTS #EXT_REQS;
CREATE TABLE #EXT_REQS(
	extName VARCHAR(100),
	reqExtName VARCHAR(100),
	reqExtLevel INT
);
INSERT INTO #EXT_REQS (extName, reqExtName, reqExtLevel) VALUES
(@miningAmountSkillName, 'ext_epriton_miner_expert', 5),
(@miningCycleSkillName, 'ext_epriton_mining_buffer_expert', 5);

SELECT * FROM extensionprerequire WHERE 
	extensionid=(SELECT extensionid FROM extensions WHERE extensionname in (SELECT DISTINCT extName FROM #EXT_REQS));

DELETE FROM extensionprerequire WHERE 
	extensionid=(SELECT extensionid FROM extensions WHERE extensionname in (SELECT DISTINCT extName FROM #EXT_REQS));

INSERT INTO extensionprerequire (extensionid, requiredextension, requiredlevel)
SELECT 
	(SELECT extensionid FROM extensions WHERE extensionname=extName),
	(SELECT extensionid FROM extensions WHERE extensionname=reqExtName),
	reqExtLevel
FROM #EXT_REQS;

DROP TABLE IF EXISTS #EXT_REQS;
GO
