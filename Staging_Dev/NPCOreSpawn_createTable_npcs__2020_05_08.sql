USE [perpetuumsa]
GO

--------------------------------------------------------------------
--Datamodel for NPC Ore spawns
--A presence is to spawn on some ore field when the field is depleted to particular percentages
--When the threshold is exceeded for that ore, that presence will spawn
--
--Date modified: 2020/05/08
--------------------------------------------------------------------

DROP TABLE IF EXISTS dbo.npcorespawn;

CREATE TABLE dbo.npcorespawn (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	materialType INT NOT NULL,
	presenceId INT NOT NULL,
	threshold float NOT NULL
);

GO

DECLARE @fluxOre INT;
SET @fluxOre = (SELECT TOP 1 idx FROM minerals WHERE name = 'fluxore');

--TODO build presences for this feature and use here
INSERT INTO dbo.npcorespawn(materialType, presenceId, threshold) VALUES
(@fluxOre, 500, 0.33),
(@fluxOre, 506, 0.66),
(@fluxOre, 512, 0.99);
