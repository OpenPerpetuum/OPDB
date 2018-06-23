USE [perpetuumsa]
GO

PRINT N'UPDATE orange hue in def-config'
DECLARE @paintDef int;
SET @paintDef = (SELECT TOP 1 definition from entitydefaults where definitionname='def_paint_orange');

--update tint in config
UPDATE [dbo].[definitionconfig]
SET tint = '#fb6701'
WHERE definition=@paintDef;


GO