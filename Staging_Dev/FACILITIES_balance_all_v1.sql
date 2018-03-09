USE [perpetuumsa]
GO


---Shows all facilities---Vanilla-state---
SELECT * from entitydefaults
where categoryflags in (SELECT value from categoryFlags
where name='cf_refinery_facility' or name='cf_repair_facility'
or name='cf_reprocessor_facility' or name='cf_mill'
or name='cf_prototyper' or name='cf_research_lab');



---Update 'super' facility to 75pts------
PRINT N'public docking facility-super 100->75pt';
UPDATE entitydefaults
SET options=REPLACE(options, '#points=n100', '#points=n75')
WHERE categoryflags in (SELECT value FROM categoryFlags
WHERE name='cf_refinery_facility' or name='cf_repair_facility'
or name='cf_reprocessor_facility' or name='cf_mill'
or name='cf_prototyper' or name='cf_research_lab');
GO

---------Add new Beta Outpost Facility---------------
PRINT N'Add new facilities for 75pt OUTPOST facility (it is different)';
INSERT INTO [dbo].[entitydefaults]
           ([definitionname],[quantity],[attributeflags],[categoryflags],[options],[note],[enabled],[volume],[mass],[hidden],[health],[descriptiontoken],[purchasable],[tiertype],[tierlevel])
     VALUES
           ('def_production_public_refinery_outpost_great',1,4195328,66414,'#materialEfficiency=f0.75  #points=n75','75 pt facility',1,0,0,0,100,'def_production_public_refinery_outpost_desc',0,NULL,NULL),
		   ('def_production_public_reprocessor_outpost_great',1,4195328,263022,'#materialEfficiency=f0.1  #points=n75','75 pt facility',1,0,0,0,100,'def_production_public_reprocessor_outpost_desc',0,NULL,NULL),
		   ('def_production_public_repair_outpost_great',1,4195328,328558,'#ratio=f0.4  #points=n75','75 pt facility',1,0,0,0,100,'def_production_public_repair_outpost_desc',0,NULL,NULL),
		   ('def_production_public_mill_outpost_great',1,4195328,525166,'#perSecondPrice=f7  #productionTime=n3600  #points=n75','75 pt facility',1,0,0,0,100,'def_production_public_mill_outpost_desc',0,NULL,NULL),
		   ('def_production_public_research_lab_outpost_great',1,4195328,394094,'#productionTime=n3600  #perSecondPrice=f7  #points=n75','75 pt facility',1,0,0,0,100,'def_production_public_research_lab_outpost_desc',0,NULL,NULL),
		   ('def_production_public_prototyper_outpost_great',1,4195328,590702,'#perSecondPrice=f7  #productionTime=n3600  #points=n75','75 pt facility',1,0,0,0,100,'def_production_public_prototyper_outpost_desc',0,NULL,NULL);
GO


DECLARE @terminalID int;

PRINT N'Alpha TM outposts0';
SET @terminalID = 406; --TM outpost

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_mill_basic')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_mill_advanced')
and parent=@terminalID;

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
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_refinery_super')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_refinery_super')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_reprocessor_super')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_reprocessor_expert')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_repair_super')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_repair_expert')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_mill_super')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_mill_expert')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_research_lab_super')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_research_lab_expert')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_prototyper_super')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_prototyper_super')
and parent=@terminalID;


PRINT N'ICS-B Dom';
SET @terminalID=47379;--ICSB - Domhalarn

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_refinery_super')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_refinery_expert')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_reprocessor_super')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_reprocessor_expert')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_repair_super')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_repair_super')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_mill_super')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_mill_super')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_research_lab_super')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_research_lab_expert')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_prototyper_super')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_prototyper_expert')
and parent=@terminalID;


PRINT N'ASI-B Hokk';
SET @terminalID=47381;--ASI-B - Hokkogaros

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_refinery_super')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_refinery_expert')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_reprocessor_super')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_reprocessor_super')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_repair_super')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_repair_expert')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_mill_super')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_mill_expert')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_research_lab_super')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_research_lab_super')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_prototyper_super')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_prototyper_expert')
and parent=@terminalID;

--Kentagura
--139
--143

--Alsable
--134
--286

--Novastrov
--287
--288

PRINT N'Kent outpost 1';
SET @terminalID=139;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_refinery_outpost_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_refinery_outpost')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_reprocessor_outpost_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_reprocessor_outpost')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_repair_outpost_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_repair_outpost')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_mill_outpost_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_mill_outpost')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_research_lab_outpost_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_research_lab_outpost')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_prototyper_outpost_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_prototyper_outpost')
and parent=@terminalID;


PRINT N'Kent outpost 2';
SET @terminalID=143;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_refinery_outpost_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_refinery_outpost')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_reprocessor_outpost_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_reprocessor_outpost')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_repair_outpost_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_repair_outpost')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_mill_outpost_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_mill_outpost')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_research_lab_outpost_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_research_lab_outpost')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_prototyper_outpost_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_prototyper_outpost')
and parent=@terminalID;


--Alsable
--134
--286

PRINT N'Alsbale outpost 1';
SET @terminalID=134;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_refinery_outpost_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_refinery_outpost')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_reprocessor_outpost_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_reprocessor_outpost')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_repair_outpost_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_repair_outpost')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_mill_outpost_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_mill_outpost')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_research_lab_outpost_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_research_lab_outpost')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_prototyper_outpost_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_prototyper_outpost')
and parent=@terminalID;


PRINT N'Alsable outpost 2';
SET @terminalID=286;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_refinery_outpost_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_refinery_outpost')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_reprocessor_outpost_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_reprocessor_outpost')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_repair_outpost_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_repair_outpost')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_mill_outpost_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_mill_outpost')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_research_lab_outpost_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_research_lab_outpost')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_prototyper_outpost_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_prototyper_outpost')
and parent=@terminalID;


--Novastrov
--287
--288

PRINT N'Nova outpost 1';
SET @terminalID=287;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_refinery_outpost_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_refinery_outpost')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_reprocessor_outpost_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_reprocessor_outpost')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_repair_outpost_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_repair_outpost')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_mill_outpost_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_mill_outpost')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_research_lab_outpost_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_research_lab_outpost')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_prototyper_outpost_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_prototyper_outpost')
and parent=@terminalID;


PRINT N'Nova outpost 2';
SET @terminalID=288;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_refinery_outpost_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_refinery_outpost')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_reprocessor_outpost_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_reprocessor_outpost')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_repair_outpost_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_repair_outpost')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_mill_outpost_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_mill_outpost')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_research_lab_outpost_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_research_lab_outpost')
and parent=@terminalID;

UPDATE entities
SET definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_prototyper_outpost_great')
WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_production_public_prototyper_outpost')
and parent=@terminalID;