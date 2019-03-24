USE [perpetuumsa]
GO

---------------------
-- Syndicate shop Paint price update
-- 5mil
-- 2019/02/03
---------------------

UPDATE dbo.itemshop
SET
credit = 5000000
WHERE
targetdefinition IN (SELECT definition FROM entitydefaults WHERE definitionname LIKE 'def_paint_%' AND note='Paint')
AND credit IS NOT NULL;

GO