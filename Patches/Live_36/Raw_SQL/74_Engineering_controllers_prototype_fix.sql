DECLARE @prototypeId INT
DECLARE @itemId INT

-- T2

SET @prototypeId = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_engineering_remote_controller_pr')
SET @itemId = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named1_engineering_remote_controller')

DELETE FROM prototypes WHERE definition = @itemId OR prototype = @prototypeId
INSERT INTO prototypes (definition, prototype) VALUES (@itemId, @prototypeId)

UPDATE entitydefaults SET tiertype = 2 WHERE definition = @prototypeId

-- T3

SET @prototypeId = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_engineering_remote_controller_pr')
SET @itemId = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named2_engineering_remote_controller')

DELETE FROM prototypes WHERE definition = @itemId OR prototype = @prototypeId
INSERT INTO prototypes (definition, prototype) VALUES (@itemId, @prototypeId)

UPDATE entitydefaults SET tiertype = 2 WHERE definition = @prototypeId

-- T4

SET @prototypeId = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_engineering_remote_controller_pr')
SET @itemId = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_named3_engineering_remote_controller')

DELETE FROM prototypes WHERE definition = @itemId OR prototype = @prototypeId
INSERT INTO prototypes (definition, prototype) VALUES (@itemId, @prototypeId)

UPDATE entitydefaults SET tiertype = 2 WHERE definition = @prototypeId

GO
