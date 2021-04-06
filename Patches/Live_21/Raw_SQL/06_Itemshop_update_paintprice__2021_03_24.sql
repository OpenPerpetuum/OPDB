USE [perpetuumsa]
GO
-----------------------------------
-- Reduce Paint price v2
-- Update price of paints everywhere to 3m nic
-- no more RGB tokens
-- Date modified: 2021/03/28
-----------------------------------

PRINT N'UPDATE itemshop (60 rows affected)';
UPDATE itemshop SET
	credit=3000000,
	unicoin=NULL,
	tmcoin=NULL,
	icscoin=NULL,
	asicoin=NULL
WHERE 
	targetdefinition IN (SELECT definition FROM entitydefaults WHERE
	categoryflags=(SELECT TOP 1 value FROM categoryFlags WHERE name='cf_paints'));

GO