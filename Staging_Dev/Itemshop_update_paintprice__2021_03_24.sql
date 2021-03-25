USE [perpetuumsa]
GO
-----------------------------------
-- Reduce Paint price v2
-- Date modified: 2021/03/24
-----------------------------------
PRINT N'UPDATE itemshop (15 rows affected)';
UPDATE itemshop SET
	credit=3000000
WHERE credit=5000000 AND presetid=1 AND
	targetdefinition IN (SELECT definition FROM entitydefaults WHERE
	categoryflags=(SELECT TOP 1 value FROM categoryFlags WHERE name='cf_paints'));

GO