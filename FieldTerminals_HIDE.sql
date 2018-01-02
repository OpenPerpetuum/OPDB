USE perpetuumsa
GO


UPDATE zoneentities 
SET 
	enabled=0 
WHERE ename like 'fieldTerminal_%';