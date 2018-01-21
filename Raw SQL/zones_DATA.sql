USE perpetuumsa
GO


UPDATE zones
SET
	active = 0
	,[enabled] = 0
WHERE
	id IN (1, 2, 6, 7, 22, 25, 30, 35, 36, 39)

UPDATE zones
SET
	x = 4000
	,y = 1000
WHERE
	id = 0

UPDATE zones
SET
	x = 0
	,y = -750
WHERE
	id = 3

UPDATE zones
SET
	x = -5000
	,y = -750
WHERE
	id = 4

UPDATE zones
SET
	x = -2500
	,y = 4000
WHERE
	id = 5

UPDATE zones
SET
	x = -2500
	,y = 1000
WHERE
	id = 8

UPDATE zones
SET
	x = -5000
	,y = 2750
WHERE
	id = 9

UPDATE zones
SET
	x = 0
	,y = 2750
WHERE
	id = 10

UPDATE zones
SET
	x = -2500
	,y = -2000
WHERE
	id = 11

UPDATE zones
SET
	x = 7500
	,y = 7500
WHERE
	id = 45

