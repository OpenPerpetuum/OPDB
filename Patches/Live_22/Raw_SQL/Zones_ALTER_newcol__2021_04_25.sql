USE [perpetuumsa]
GO

PRINT N'ALTER [dbo].[zones]';
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[perpetuumsa].[dbo].[zones]')
	AND name = 'timeLimitMinutes')
BEGIN
	PRINT N'ADDING COL timeLimitMinutes';
	ALTER TABLE [perpetuumsa].[dbo].[zones] ADD
		timeLimitMinutes INT NULL;
END
GO

USE [perpetuumsa]
GO

--Set all strongholds (just in case)
UPDATE zones SET 
	timeLimitMinutes = 180
WHERE zonetype=4;

--Set the all small strongholds
UPDATE zones SET
	timeLimitMinutes = 60
WHERE zonetype=4 AND width < 257;

-- Set Omega stronghold
UPDATE zones SET 
	timeLimitMinutes = 180
WHERE zonetype=4 AND name='zone_pvp_arena';

--Set the zone 71-72 Syndicate mini strongholds to 1 hour
UPDATE zones SET
	timeLimitMinutes = 60
WHERE zonetype=4 AND name IN ('zone_strghld_71', 'zone_strghld_72');

--Set the Sentinel to 9 hours
UPDATE zones SET
	timeLimitMinutes = 540
WHERE zonetype=4 AND name='zone_strghld_70';

GO