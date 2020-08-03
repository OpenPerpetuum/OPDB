USE [perpetuumsa]
GO


---------------------------------------------------------
-- Add table of stronghold exit locations
-- 
-- Date: 2020/08/03
---------------------------------------------------------


DROP TABLE IF EXISTS dbo.strongholdexitconfig;

CREATE TABLE dbo.strongholdexitconfig (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	zoneid INT,
	x INT,
	y INT
);

INSERT strongholdexitconfig (zoneid, x, y) VALUES
(16, 1120, 1040),
(16, 942, 993);

GO