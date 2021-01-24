USE [perpetuumsa]
GO

------------------------------------------
-- Set production costs for T2+/4+
-- Date: 2021/1/21
------------------------------------------

PRINT N'UPSERT productioncost FOR T2/4+';

IF EXISTS (SELECT TOP 1 id FROM productioncost WHERE tiertype=3 AND tierlevel=2 AND category IS NULL)
BEGIN
	UPDATE productioncost SET
		costmodifier=5
	WHERE tiertype=3 AND tierlevel=2 AND category IS NULL;
END
ELSE
BEGIN
	INSERT INTO productioncost (category, tiertype, tierlevel, costmodifier) VALUES
	(NULL, 3, 2, 5);
END

IF EXISTS (SELECT TOP 1 id FROM productioncost WHERE tiertype=3 AND tierlevel=4 AND category IS NULL)
BEGIN
	UPDATE productioncost SET
		costmodifier=6
	WHERE tiertype=3 AND tierlevel=4 AND category IS NULL;
END
ELSE
BEGIN
	INSERT INTO productioncost (category, tiertype, tierlevel, costmodifier) VALUES
	(NULL, 3, 4, 6);
END
PRINT N'DONE UPSERT productioncost FOR T2/4+';

GO