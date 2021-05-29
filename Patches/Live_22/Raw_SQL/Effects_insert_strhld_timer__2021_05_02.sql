USE [perpetuumsa]
GO

-------------------------------------------
-- Add effect for stronghold player time expiration
--
-- Date modified: 2021/05/02 
-------------------------------------------


DECLARE @effectID AS INT = 115;
DECLARE @effectName AS VARCHAR(100) = 'effect_stronghold_despawn_timer';
DECLARE @effectCat AS BIGINT = POWER(CAST(2 AS BIGINT), CAST((SELECT TOP 1 flag from effectcategories where NAME='effcat_terrain_object_effects') AS BIGINT));

IF NOT EXISTS (SELECT TOP 1 id FROM dbo.effects WHERE name = @effectName)
BEGIN
PRINT N'INSERTING '+@effectName;
	SET IDENTITY_INSERT dbo.effects ON;
	INSERT INTO dbo.effects(id, effectcategory, duration, name, description, note, isaura, auraradius, ispositive, display, saveable) VALUES
	(@effectID, @effectCat, 600000, @effectName, @effectName+'_desc', 'stronghold despawn timer', 0, 0, 0, 3, 0);
	SET IDENTITY_INSERT dbo.effects OFF;
END

GO