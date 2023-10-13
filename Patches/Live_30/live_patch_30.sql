USE [perpetuumsa]
GO

PRINT N'00_removing_duplicate_plant_rules__2023_10_10.sql';

---------------------------------------
-- Removing duplicate rules for plants
-- 
-- Date modified: 2023/10/10
--      Intial commit
-- Date modified: 2023/10/13
--      fix non-ASCII characters
---------------------------------------

-- Table for suspicious rules.
DECLARE @table_for_check TABLE
(
    idx       INT          NOT NULL,
    plantrule VARCHAR(256) NOT NULL,
    rulesetid INT          NOT NULL
);

-- Select all the rules according to the template.
INSERT INTO @table_for_check (idx, plantrule, rulesetid)
    SELECT idx, plantrule, rulesetid FROM [dbo].[plantrules]
        WHERE [plantrule] LIKE '%_seeded_%';

-- Table with rows to delete.
DECLARE @table_for_removing TABLE
(
    idx       INT          NOT NULL,
    plantrule VARCHAR(256) NOT NULL,
    rulesetid INT          NOT NULL
);

-- Variables with information about the rule.
DECLARE
    @idx       INT,
    @plantrule VARCHAR(256),
    @rulesetid INT,
    @plantname VARCHAR(256), -- Name of the plant.
    @dup       INT;          -- Number of duplicates.

-- Go through all the filtered rules.
DECLARE plantrule_cursor CURSOR FOR
    SELECT [idx], [plantrule], [rulesetid] FROM @table_for_check;

OPEN plantrule_cursor  
FETCH NEXT FROM plantrule_cursor INTO @idx, @plantrule, @rulesetid;

WHILE @@FETCH_STATUS = 0  
BEGIN
    -- Extract the name of the plant from the name of the rule.
    SET @plantname = LEFT(@plantrule, PATINDEX('%_seeded_%', @plantrule) - 1);
    -- Count the number of duplicates.
    SET @dup = (SELECT COUNT(*) FROM [dbo].[plantrules]
        WHERE [plantrule] LIKE @plantname + '%' AND NOT [plantrule] = @plantrule AND [rulesetid] = @rulesetid);
    
    IF 0 = @dup
        BEGIN
            -- Everything is fine - the only rule on the island.
            PRINT  'ID:' + CONVERT(varchar(3), @rulesetid) +
            ' PLANT:' + @plantname +
            ' RULE:' + @plantrule +
            ' -- OK';
        END
    ELSE
        BEGIN
            -- There are duplicates with rules for wild plants.
            PRINT  'ID:' + CONVERT(varchar(3), @rulesetid) +
            ' PLANT:' + @plantname +
            ' RULE:' + @plantrule +
            ' -- DUP_COUNT: '  + CONVERT(varchar(3), @dup) + ' -- ADD FOR REMOVE';

            -- Add a rule for seed plants to the table for deletion.
            INSERT INTO @table_for_removing  ([idx], [plantrule], [rulesetid])
                VALUES (@idx, @plantrule, @rulesetid);
        END

    -- Next rule.
    FETCH NEXT FROM plantrule_cursor INTO @idx, @plantrule, @rulesetid;
END

CLOSE plantrule_cursor;
DEALLOCATE plantrule_cursor;

-- Visual control of all rules for deletion.
SELECT * FROM @table_for_removing;
-- If they are all for T1 islands (control by name), then we remove them from the database.
IF 0 = (SELECT COUNT(*) FROM @table_for_removing WHERE NOT [plantrule] LIKE '%_t1.txt')
BEGIN
    DELETE FROM [dbo].[plantrules] WHERE [idx] IN (SELECT [idx] FROM @table_for_removing);
END

GO
