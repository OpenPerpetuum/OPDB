USE [perpetuumsa]
GO

------------------------
--Simple Boost for CT drop chances
--2019/01/31
--min drop rates at 0.00125
--max drop rates at 0.005
------------------------


DECLARE @minchanceCT float;
DECLARE @maxchanceCT float;


SET @minchanceCT = (SELECT MIN(chance) from artifactloot
join entitydefaults on artifactloot.definition=entitydefaults.definition
where entitydefaults.categoryflags=1179 AND definitionname like '%CT_capsule');

SET @maxchanceCT = (SELECT MAX(chance) from artifactloot
join entitydefaults on artifactloot.definition=entitydefaults.definition
where entitydefaults.categoryflags=1179 AND definitionname like '%CT_capsule');

PRINT 'Min-chance for CT: ' + CONVERT(varchar(10), @minchanceCT); --0.00125
PRINT 'Max-chance for CT: ' + CONVERT(varchar(10), @maxchanceCT); --0.005

IF @maxchanceCT<0.01
	--Set the chance to 10x whatever it is currently
	UPDATE artifactloot
	SET chance = chance*10.0
	WHERE definition IN (SELECT definition FROM entitydefaults WHERE categoryflags=1179 AND definitionname like '%CT_capsule');
ELSE
	PRINT N'Skipped update because CT chance is at acceptable levels';



SET @minchanceCT = (SELECT MIN(chance) from artifactloot
join entitydefaults on artifactloot.definition=entitydefaults.definition
where entitydefaults.categoryflags=1179 AND definitionname like '%CT_capsule');

SET @maxchanceCT = (SELECT MAX(chance) from artifactloot
join entitydefaults on artifactloot.definition=entitydefaults.definition
where entitydefaults.categoryflags=1179 AND definitionname like '%CT_capsule');

PRINT 'Min-chance for CT: ' + CONVERT(varchar(10), @minchanceCT); --0.0125
PRINT 'Max-chance for CT: ' + CONVERT(varchar(10), @maxchanceCT); --0.05


GO