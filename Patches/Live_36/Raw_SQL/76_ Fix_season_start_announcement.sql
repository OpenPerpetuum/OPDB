-- Persists season start announcement dispatch so server restarts do not repost it.
-- New and recurring season rows default to unsent.

IF COL_LENGTH('dbo.seasons', 'announcement_sent') IS NULL
BEGIN
    ALTER TABLE dbo.seasons
        ADD announcement_sent BIT NOT NULL
            CONSTRAINT DF_seasons_announcement_sent DEFAULT (0);
END;

IF COL_LENGTH('dbo.season_character_points', 'announcement_mail_sent') IS NULL
BEGIN
    ALTER TABLE dbo.season_character_points
        ADD announcement_mail_sent BIT NOT NULL
            CONSTRAINT DF_season_character_points_announcement_mail_sent DEFAULT (0);
END;
