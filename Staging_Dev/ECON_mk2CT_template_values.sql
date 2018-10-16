USE [perpetuumsa]
GO

---[ECONOMY REQUEST]  MK2 CT Base values---
--Base MK2 CT pt values set to 50%
--A = low (50->25)
--B = mid (100->50)
--C = hi (150->75)

UPDATE
    [dynamiccalibrationtemplates]
SET
    [dynamiccalibrationtemplates].materialefficiency = CASE 
		WHEN defs.definitionname like '%_mk2_A_%' THEN 25
		WHEN defs.definitionname like '%_mk2_B_%' THEN 50
		WHEN defs.definitionname like '%_mk2_C_%' THEN 75
		ELSE 10 END,
    [dynamiccalibrationtemplates].timeefficiency = CASE 
		WHEN defs.definitionname like '%_mk2_A_%' THEN 25
		WHEN defs.definitionname like '%_mk2_B_%' THEN 50
		WHEN defs.definitionname like '%_mk2_C_%' THEN 75
		ELSE 10 END
FROM
    [dynamiccalibrationtemplates] AS mk2CTs
    INNER JOIN entitydefaults AS defs
        ON mk2CTs.definition = defs.definition

GO