USE perpdbtools

EXEC dbo.backup_server_data
EXEC dbo.restore_perpetuumsa
EXEC dbo.restore_server_data

USE perpetuumsa

TRUNCATE TABLE extensionpoints

INSERT INTO extensionpoints (accountid,points) 
SELECT
	accountid
	,200000
FROM 
	accounts
WHERE accountID <> 7 and dbo.extensionPointsCollected(accountid) < 200000

