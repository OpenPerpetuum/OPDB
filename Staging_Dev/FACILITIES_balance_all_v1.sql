USE [perpetuumsa]
GO


---------Add new Facility---------------
PRINT N'Add new facilities for 75pt facility';
INSERT INTO [dbo].[entitydefaults]
           ([definitionname],[quantity],[attributeflags],[categoryflags],[options],[note],[enabled],[volume],[mass],[hidden],[health],[descriptiontoken],[purchasable],[tiertype],[tierlevel])
     VALUES
           ('def_production_public_refinery_great',1,4195328,66414,'#points=n75','75 pt facility',1,0,0,0,100,'',0,NULL,NULL),
		   ('def_production_public_reprocessor_great',1,4195328,263022,'#points=n75','75 pt facility',1,0,0,0,100,'',0,NULL,NULL),
		   ('def_production_public_repair_great',1,4195328,328558,'#ratio=f0.3#points=n75','75 pt facility',1,0,0,0,100,'',0,NULL,NULL),
		   ('def_production_public_mill_great',1,4195328,525166,'#perSecondPrice=f7#productionTime=n3600#points=n75','75 pt facility',1,0,0,0,100,'',0,NULL,NULL),
		   ('def_production_public_research_lab_great',1,4195328,394094,'#perSecondPrice=f7#productionTime=n3600#points=n75','75 pt facility',1,0,0,0,100,'',0,NULL,NULL),
		   ('def_production_public_prototyper_great',1,4195328,590702,'#perSecondPrice=f7#productionTime=n3600#points=n75','75 pt facility',1,0,0,0,100,'',0,NULL,NULL);
GO


---Shows all facilities---
SELECT * from entitydefaults
where categoryflags in (SELECT value from categoryFlags
where name='cf_refinery_facility' or name='cf_repair_facility'
or name='cf_reprocessor_facility' or name='cf_mill'
or name='cf_prototyper' or name='cf_research_lab');



DECLARE @terminalID int;

PRINT N'Alpha TM outposts0';
SET @terminalID = 406; --TM outpost

-----Query for facilities in a given terminal----
--SELECT * FROM entities
--join entitydefaults on entities.definition=entitydefaults.definition
--WHERE parent=@terminalID and parent in (SELECT eid FROM entities 
--WHERE definition in (SELECT definition
--FROM [perpetuumsa].[dbo].[entitydefaults] 
--WHERE categoryflags in (SELECT value FROM categoryFlags 
--WHERE categoryFlags.name='cf_public_docking_base')));



UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_prototyper_basic')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_prototyper_advanced')
and parent=@terminalID;

PRINT N'Alpha TM outposts1';
SET @terminalID = 408; --TM outpost

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_research_lab_basic')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_research_lab_advanced')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_refinery_basic')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_refinery_advanced')
and parent=@terminalID;

PRINT N'Alpha TM outposts2';
SET @terminalID = 411; --TM outpost

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_reprocessor_basic')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_reprocessor_advanced')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_repair_basic')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_repair_advanced')
and parent=@terminalID;

PRINT N'A2 Hershfield';
SET @terminalID = 142; --HERSH

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_refinery_advanced')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_refinery_expert')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_prototyper_advanced')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_prototyper_expert')
and parent=@terminalID;

PRINT N'TMB Norhoop';
SET @terminalID=47383;--TMB Norhoop

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_refinery_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_refinery_super')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_reprocessor_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_reprocessor_expert')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_repair_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_repair_expert')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_mill_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_mill_expert')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_research_lab_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_research_lab_expert')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_prototyper_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_prototyper_super')
and parent=@terminalID;


PRINT N'ICS-B Dom';
SET @terminalID=47379;--ICSB - Domhalarn

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_refinery_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_refinery_expert')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_reprocessor_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_reprocessor_expert')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_repair_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_repair_super')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_mill_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_mill_super')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_research_lab_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_research_lab_expert')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_prototyper_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_prototyper_expert')
and parent=@terminalID;


PRINT N'ASI-B Hokk';
SET @terminalID=47381;--ASI-B - Hokkogaros

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_refinery_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_refinery_expert')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_reprocessor_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_reprocessor_super')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_repair_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_repair_expert')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_mill_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_mill_expert')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_research_lab_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_research_lab_super')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_prototyper_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_prototyper_expert')
and parent=@terminalID;

GO