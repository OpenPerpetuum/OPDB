USE [perpetuumsa]
GO

PRINT N'Smite compact token price fix';

UPDATE itemshop 
SET tmcoin=600
WHERE targetdefinition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_missile_rewa');

GO
