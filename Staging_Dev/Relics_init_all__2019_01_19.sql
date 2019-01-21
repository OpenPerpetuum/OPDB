USE [perpetuumsa]
GO

PRINT N'Relics - Initial config and settings 2019-01-19';

PRINT N'Dropping all Relic-related tables - This should be the first Relic Patch';
DROP TABLE IF EXISTS dbo.relicloots;
DROP TABLE IF EXISTS dbo.relicspawninfos;
DROP TABLE IF EXISTS dbo.relicinfos;
DROP TABLE IF EXISTS dbo.reliczoneconfigs;

PRINT N'Create all the Relic tables';
CREATE TABLE dbo.relicinfos(
id INT NOT NULL IDENTITY PRIMARY KEY,
name VARCHAR(128) NOT NULL,
ep INT NOT NULL
);

CREATE TABLE dbo.relicloots(
id INT NOT NULL IDENTITY PRIMARY KEY,
definition INT NOT NULL,
minquantity INT NOT NULL,
maxquantity INT NOT NULL,
chance FLOAT NOT NULL,
relicinfoid INT NOT NULL,
packed BIT NOT NULL
);

CREATE TABLE dbo.relicspawninfos(
id INT NOT NULL IDENTITY PRIMARY KEY,
relicinfoid INT NOT NULL,
zoneid INT NOT NULL,
rate INT NOT NULL,
x INT NULL,
y INT NULL
);

CREATE TABLE dbo.reliczoneconfigs(
id INT NOT NULL IDENTITY PRIMARY KEY,
zoneid INT NOT NULL,
maxspawn INT NOT NULL,
respawnrate INT NOT NULL
);

PRINT N'Set the Relic Zone Configurations';
--Relic Zone Configurations: 6 per zone, respawn at 3 hours (+/- 1hr - server-set random range)
INSERT INTO dbo.reliczoneconfigs 
	([zoneid], [maxspawn], [respawnrate]) 
SELECT 
     zones.id, 6, 10800
FROM 
     dbo.zones
WHERE 
     zones.active=1 and zones.enabled=1

PRINT N'Explicitly set some zones to "off" w/ maxspawn=0';
--Set some zones to have no natural spawning relics (will disable RelicManagers on these zones)
UPDATE dbo.reliczoneconfigs SET
	maxspawn = 0
WHERE zoneid in (16, 45, 50, 51);

--Any zone omitted or with a maxspawn<=0 will NOT have a RelicManager assigned on server boot (this is a good thing)

PRINT N'Create the initial set of Relic-types and their associated EP reward values';
--Create different relic types
INSERT INTO [dbo].[relicinfos]
           ([name],[ep])
     VALUES
           ('relic_level1_neutral_alpha1',5),
		   ('relic_level2_neutral_alpha1',10),
		   ('relic_level3_neutral_alpha1',15),
		   ('relic_level1_neutral_alpha2',15),
		   ('relic_level2_neutral_alpha2',20),
		   ('relic_level3_neutral_alpha2',25),
		   ('relic_level1_neutral_beta1',25),
		   ('relic_level2_neutral_beta1',35),
		   ('relic_level3_neutral_beta1',45),
		   ('relic_level1_neutral_beta2',45),
		   ('relic_level2_neutral_beta2',55),
		   ('relic_level3_neutral_beta2',65),
           ('relic_level1_indy_alpha1',5),
		   ('relic_level2_indy_alpha1',10),
		   ('relic_level3_indy_alpha1',15),
		   ('relic_level1_indy_alpha2',15),
		   ('relic_level2_indy_alpha2',20),
		   ('relic_level3_indy_alpha2',25),
		   ('relic_level1_indy_beta1',25),
		   ('relic_level2_indy_beta1',35),
		   ('relic_level3_indy_beta1',45),
		   ('relic_level1_indy_beta2',45),
		   ('relic_level2_indy_beta2',55),
		   ('relic_level3_indy_beta2',65),
		   ('relic_level1_numiqol_alpha1',5),
		   ('relic_level2_numiqol_alpha1',10),
		   ('relic_level3_numiqol_alpha1',15),
		   ('relic_level1_numiqol_alpha2',15),
		   ('relic_level2_numiqol_alpha2',20),
		   ('relic_level3_numiqol_alpha2',25),
		   ('relic_level1_numiqol_beta1',25),
		   ('relic_level2_numiqol_beta1',35),
		   ('relic_level3_numiqol_beta1',45),
		   ('relic_level1_numiqol_beta2',45),
		   ('relic_level2_numiqol_beta2',55),
		   ('relic_level3_numiqol_beta2',65),
           ('relic_level1_thelodica_alpha1',5),
		   ('relic_level2_thelodica_alpha1',10),
		   ('relic_level3_thelodica_alpha1',15),
		   ('relic_level1_thelodica_alpha2',15),
		   ('relic_level2_thelodica_alpha2',20),
		   ('relic_level3_thelodica_alpha2',25),
		   ('relic_level1_thelodica_beta1',25),
		   ('relic_level2_thelodica_beta1',35),
		   ('relic_level3_thelodica_beta1',45),
		   ('relic_level1_thelodica_beta2',45),
		   ('relic_level2_thelodica_beta2',55),
		   ('relic_level3_thelodica_beta2',65),
           ('relic_level1_pelistal_alpha1',5),
		   ('relic_level2_pelistal_alpha1',10),
		   ('relic_level3_pelistal_alpha1',15),
		   ('relic_level1_pelistal_alpha2',15),
		   ('relic_level2_pelistal_alpha2',20),
		   ('relic_level3_pelistal_alpha2',25),
		   ('relic_level1_pelistal_beta1',25),
		   ('relic_level2_pelistal_beta1',35),
		   ('relic_level3_pelistal_beta1',45),
		   ('relic_level1_pelistal_beta2',45),
		   ('relic_level2_pelistal_beta2',55),
		   ('relic_level3_pelistal_beta2',65);


DECLARE @commonPlasma int;
DECLARE @numiqolPlasma int;
DECLARE @thelodicaPlasma int;
DECLARE @pelistalPlasma int;

DECLARE @commonKernel int;
DECLARE @hitechKernel int;
DECLARE @industrialKernel int;
DECLARE @numiqolKernel int;
DECLARE @thelodicaKernel int;
DECLARE @pelistalKernel int;


SET @commonPlasma = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_common_reactor_plasma');
SET @numiqolPlasma = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_nuimqol_reactor_plasma');
SET @thelodicaPlasma = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_thelodica_reactor_plasma');
SET @pelistalPlasma = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_pelistal_reactor_plasma');

SET @commonKernel = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_kernel_common');
SET @hitechKernel = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_kernel_hitech');
SET @industrialKernel = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_kernel_industrial');
SET @numiqolKernel = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_kernel_nuimqol');
SET @thelodicaKernel = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_kernel_thelodica');
SET @pelistalKernel = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_kernel_pelistal');

PRINT N'Create a reasonable initial set of loots for each Relic type'; -- To be supported with future DB tool development
--Insert loots for each type
INSERT INTO [dbo].[relicloots]
           ([definition],[minquantity],[maxquantity],[chance],[relicinfoid],[packed])
VALUES
			--Neutral types
			--Kernel - common 75%
           (@commonKernel,450,550,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_neutral_alpha1'),1),
           (@commonKernel,675,825,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_neutral_alpha1'),1),
		   (@commonKernel,1350,1650,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_neutral_alpha1'),1),
		   (@commonKernel,675,825,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_neutral_alpha2'),1),
		   (@commonKernel,1013,1238,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_neutral_alpha2'),1),
		   (@commonKernel,2025,2475,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_neutral_alpha2'),1),
		   (@commonKernel,1013,1238,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_neutral_beta1'),1),
		   (@commonKernel,1519,1856,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_neutral_beta1'),1),
		   (@commonKernel,3038,3713,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_neutral_beta1'),1),
		   (@commonKernel,1463,1788,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_neutral_beta2'),1),
		   (@commonKernel,2194,2681,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_neutral_beta2'),1),
		   (@commonKernel,4388,5363,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_neutral_beta2'),1),
		   --Kernel - hitech 25%
           (@hitechKernel,150,183,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_neutral_alpha1'),1),
           (@hitechKernel,225,275,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_neutral_alpha1'),1),
		   (@hitechKernel,450,550,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_neutral_alpha1'),1),
		   (@hitechKernel,225,275,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_neutral_alpha2'),1),
		   (@hitechKernel,338,413,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_neutral_alpha2'),1),
		   (@hitechKernel,675,825,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_neutral_alpha2'),1),
		   (@hitechKernel,338,413,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_neutral_beta1'),1),
		   (@hitechKernel,506,619,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_neutral_beta1'),1),
		   (@hitechKernel,1013,1238,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_neutral_beta1'),1),
		   (@hitechKernel,488,596,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_neutral_beta2'),1),
		   (@hitechKernel,731,894,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_neutral_beta2'),1),
		   (@hitechKernel,1463,1788,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_neutral_beta2'),1),
		   --Plasma - common
           (@commonPlasma,300,367,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_pelistal_alpha1'),1),
           (@commonPlasma,450,550,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_pelistal_alpha1'),1),
		   (@commonPlasma,900,1100,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_pelistal_alpha1'),1),
		   (@commonPlasma,450,550,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_pelistal_alpha2'),1),
		   (@commonPlasma,675,825,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_pelistal_alpha2'),1),
		   (@commonPlasma,1350,1650,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_pelistal_alpha2'),1),
		   (@commonPlasma,675,825,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_pelistal_beta1'),1),
		   (@commonPlasma,1013,1238,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_pelistal_beta1'),1),
		   (@commonPlasma,2025,2475,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_pelistal_beta1'),1),
		   (@commonPlasma,975,1192,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_pelistal_beta2'),1),
		   (@commonPlasma,1463,1788,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_pelistal_beta2'),1),
		   (@commonPlasma,2925,3575,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_pelistal_beta2'),1),

		   	--Indy types
			--Kernel - Common 50%
           (@commonKernel,300,367,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_indy_alpha1'),1),
           (@commonKernel,450,550,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_indy_alpha1'),1),
		   (@commonKernel,900,1100,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_indy_alpha1'),1),
		   (@commonKernel,450,550,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_indy_alpha2'),1),
		   (@commonKernel,675,825,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_indy_alpha2'),1),
		   (@commonKernel,1350,1650,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_indy_alpha2'),1),
		   (@commonKernel,675,825,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_indy_beta1'),1),
		   (@commonKernel,1013,1238,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_indy_beta1'),1),
		   (@commonKernel,2025,2475,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_indy_beta1'),1),
		   (@commonKernel,975,1192,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_indy_beta2'),1),
		   (@commonKernel,1463,1788,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_indy_beta2'),1),
		   (@commonKernel,2925,3575,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_indy_beta2'),1),
		   --Kernel - Indy 50%
           (@industrialKernel,300,367,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_indy_alpha1'),1),
           (@industrialKernel,450,550,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_indy_alpha1'),1),
		   (@industrialKernel,900,1100,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_indy_alpha1'),1),
		   (@industrialKernel,450,550,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_indy_alpha2'),1),
		   (@industrialKernel,675,825,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_indy_alpha2'),1),
		   (@industrialKernel,1350,1650,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_indy_alpha2'),1),
		   (@industrialKernel,675,825,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_indy_beta1'),1),
		   (@industrialKernel,1013,1238,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_indy_beta1'),1),
		   (@industrialKernel,2025,2475,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_indy_beta1'),1),
		   (@industrialKernel,975,1192,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_indy_beta2'),1),
		   (@industrialKernel,1463,1788,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_indy_beta2'),1),
		   (@industrialKernel,2925,3575,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_indy_beta2'),1),
		   --Plasma - common
           (@commonPlasma,300,367,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_pelistal_alpha1'),1),
           (@commonPlasma,450,550,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_pelistal_alpha1'),1),
		   (@commonPlasma,900,1100,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_pelistal_alpha1'),1),
		   (@commonPlasma,450,550,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_pelistal_alpha2'),1),
		   (@commonPlasma,675,825,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_pelistal_alpha2'),1),
		   (@commonPlasma,1350,1650,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_pelistal_alpha2'),1),
		   (@commonPlasma,675,825,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_pelistal_beta1'),1),
		   (@commonPlasma,1013,1238,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_pelistal_beta1'),1),
		   (@commonPlasma,2025,2475,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_pelistal_beta1'),1),
		   (@commonPlasma,975,1192,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_pelistal_beta2'),1),
		   (@commonPlasma,1463,1788,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_pelistal_beta2'),1),
		   (@commonPlasma,2925,3575,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_pelistal_beta2'),1),

			--Numiqol types
			--Kernel - Common 50%
           (@commonKernel,300,367,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_numiqol_alpha1'),1),
           (@commonKernel,450,550,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_numiqol_alpha1'),1),
		   (@commonKernel,900,1100,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_numiqol_alpha1'),1),
		   (@commonKernel,450,550,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_numiqol_alpha2'),1),
		   (@commonKernel,675,825,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_numiqol_alpha2'),1),
		   (@commonKernel,1350,1650,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_numiqol_alpha2'),1),
		   (@commonKernel,675,825,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_numiqol_beta1'),1),
		   (@commonKernel,1013,1238,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_numiqol_beta1'),1),
		   (@commonKernel,2025,2475,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_numiqol_beta1'),1),
		   (@commonKernel,975,1192,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_numiqol_beta2'),1),
		   (@commonKernel,1463,1788,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_numiqol_beta2'),1),
		   (@commonKernel,2925,3575,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_numiqol_beta2'),1),
		   --Kernel - Numiqol 50%
           (@numiqolKernel,300,367,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_numiqol_alpha1'),1),
           (@numiqolKernel,450,550,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_numiqol_alpha1'),1),
		   (@numiqolKernel,900,1100,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_numiqol_alpha1'),1),
		   (@numiqolKernel,450,550,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_numiqol_alpha2'),1),
		   (@numiqolKernel,675,825,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_numiqol_alpha2'),1),
		   (@numiqolKernel,1350,1650,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_numiqol_alpha2'),1),
		   (@numiqolKernel,675,825,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_numiqol_beta1'),1),
		   (@numiqolKernel,1013,1238,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_numiqol_beta1'),1),
		   (@numiqolKernel,2025,2475,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_numiqol_beta1'),1),
		   (@numiqolKernel,975,1192,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_numiqol_beta2'),1),
		   (@numiqolKernel,1463,1788,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_numiqol_beta2'),1),
		   (@numiqolKernel,2925,3575,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_numiqol_beta2'),1),
		   --Plasma - numiqol
           (@numiqolPlasma,300,367,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_pelistal_alpha1'),1),
           (@numiqolPlasma,450,550,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_pelistal_alpha1'),1),
		   (@numiqolPlasma,900,1100,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_pelistal_alpha1'),1),
		   (@numiqolPlasma,450,550,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_pelistal_alpha2'),1),
		   (@numiqolPlasma,675,825,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_pelistal_alpha2'),1),
		   (@numiqolPlasma,1350,1650,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_pelistal_alpha2'),1),
		   (@numiqolPlasma,675,825,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_pelistal_beta1'),1),
		   (@numiqolPlasma,1013,1238,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_pelistal_beta1'),1),
		   (@numiqolPlasma,2025,2475,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_pelistal_beta1'),1),
		   (@numiqolPlasma,975,1192,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_pelistal_beta2'),1),
		   (@numiqolPlasma,1463,1788,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_pelistal_beta2'),1),
		   (@numiqolPlasma,2925,3575,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_pelistal_beta2'),1),

			--Thelodica types
			--Kernel - Common 50%
           (@commonKernel,300,367,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_thelodica_alpha1'),1),
           (@commonKernel,450,550,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_thelodica_alpha1'),1),
		   (@commonKernel,900,1100,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_thelodica_alpha1'),1),
		   (@commonKernel,450,550,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_thelodica_alpha2'),1),
		   (@commonKernel,675,825,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_thelodica_alpha2'),1),
		   (@commonKernel,1350,1650,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_thelodica_alpha2'),1),
		   (@commonKernel,675,825,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_thelodica_beta1'),1),
		   (@commonKernel,1013,1238,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_thelodica_beta1'),1),
		   (@commonKernel,2025,2475,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_thelodica_beta1'),1),
		   (@commonKernel,975,1192,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_thelodica_beta2'),1),
		   (@commonKernel,1463,1788,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_thelodica_beta2'),1),
		   (@commonKernel,2925,3575,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_thelodica_beta2'),1),
		   --Kernel - thelodica 50%
           (@thelodicaKernel,300,367,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_thelodica_alpha1'),1),
           (@thelodicaKernel,450,550,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_thelodica_alpha1'),1),
		   (@thelodicaKernel,900,1100,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_thelodica_alpha1'),1),
		   (@thelodicaKernel,450,550,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_thelodica_alpha2'),1),
		   (@thelodicaKernel,675,825,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_thelodica_alpha2'),1),
		   (@thelodicaKernel,1350,1650,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_thelodica_alpha2'),1),
		   (@thelodicaKernel,675,825,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_thelodica_beta1'),1),
		   (@thelodicaKernel,1013,1238,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_thelodica_beta1'),1),
		   (@thelodicaKernel,2025,2475,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_thelodica_beta1'),1),
		   (@thelodicaKernel,975,1192,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_thelodica_beta2'),1),
		   (@thelodicaKernel,1463,1788,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_thelodica_beta2'),1),
		   (@thelodicaKernel,2925,3575,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_thelodica_beta2'),1),
		   --Plasma - thelodica
           (@thelodicaPlasma,300,367,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_pelistal_alpha1'),1),
           (@thelodicaPlasma,450,550,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_pelistal_alpha1'),1),
		   (@thelodicaPlasma,900,1100,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_pelistal_alpha1'),1),
		   (@thelodicaPlasma,450,550,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_pelistal_alpha2'),1),
		   (@thelodicaPlasma,675,825,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_pelistal_alpha2'),1),
		   (@thelodicaPlasma,1350,1650,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_pelistal_alpha2'),1),
		   (@thelodicaPlasma,675,825,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_pelistal_beta1'),1),
		   (@thelodicaPlasma,1013,1238,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_pelistal_beta1'),1),
		   (@thelodicaPlasma,2025,2475,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_pelistal_beta1'),1),
		   (@thelodicaPlasma,975,1192,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_pelistal_beta2'),1),
		   (@thelodicaPlasma,1463,1788,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_pelistal_beta2'),1),
		   (@thelodicaPlasma,2925,3575,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_pelistal_beta2'),1),

			--Pelistal types
			--Kernel - Common 50%
           (@commonKernel,300,367,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_pelistal_alpha1'),1),
           (@commonKernel,450,550,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_pelistal_alpha1'),1),
		   (@commonKernel,900,1100,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_pelistal_alpha1'),1),
		   (@commonKernel,450,550,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_pelistal_alpha2'),1),
		   (@commonKernel,675,825,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_pelistal_alpha2'),1),
		   (@commonKernel,1350,1650,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_pelistal_alpha2'),1),
		   (@commonKernel,675,825,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_pelistal_beta1'),1),
		   (@commonKernel,1013,1238,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_pelistal_beta1'),1),
		   (@commonKernel,2025,2475,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_pelistal_beta1'),1),
		   (@commonKernel,975,1192,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_pelistal_beta2'),1),
		   (@commonKernel,1463,1788,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_pelistal_beta2'),1),
		   (@commonKernel,2925,3575,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_pelistal_beta2'),1),
		   --Kernel - pelistal 50%
           (@pelistalKernel,300,367,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_pelistal_alpha1'),1),
           (@pelistalKernel,450,550,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_pelistal_alpha1'),1),
		   (@pelistalKernel,900,1100,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_pelistal_alpha1'),1),
		   (@pelistalKernel,450,550,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_pelistal_alpha2'),1),
		   (@pelistalKernel,675,825,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_pelistal_alpha2'),1),
		   (@pelistalKernel,1350,1650,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_pelistal_alpha2'),1),
		   (@pelistalKernel,675,825,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_pelistal_beta1'),1),
		   (@pelistalKernel,1013,1238,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_pelistal_beta1'),1),
		   (@pelistalKernel,2025,2475,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_pelistal_beta1'),1),
		   (@pelistalKernel,975,1192,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_pelistal_beta2'),1),
		   (@pelistalKernel,1463,1788,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_pelistal_beta2'),1),
		   (@pelistalKernel,2925,3575,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_pelistal_beta2'),1),
		   --Plasma - pelistal
           (@pelistalPlasma,300,367,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_pelistal_alpha1'),1),
           (@pelistalPlasma,450,550,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_pelistal_alpha1'),1),
		   (@pelistalPlasma,900,1100,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_pelistal_alpha1'),1),
		   (@pelistalPlasma,450,550,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_pelistal_alpha2'),1),
		   (@pelistalPlasma,675,825,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_pelistal_alpha2'),1),
		   (@pelistalPlasma,1350,1650,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_pelistal_alpha2'),1),
		   (@pelistalPlasma,675,825,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_pelistal_beta1'),1),
		   (@pelistalPlasma,1013,1238,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_pelistal_beta1'),1),
		   (@pelistalPlasma,2025,2475,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_pelistal_beta1'),1),
		   (@pelistalPlasma,975,1192,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_pelistal_beta2'),1),
		   (@pelistalPlasma,1463,1788,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_pelistal_beta2'),1),
		   (@pelistalPlasma,2925,3575,1.0,(SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_pelistal_beta2'),1);
GO




DECLARE @newVirginia int;
DECLARE @hersh int;
DECLARE @domhalarn int;
DECLARE @hokk int;
DECLARE @hoop int;
DECLARE @kent int;
DECLARE @alsbale int;
DECLARE @nova int;

SET @newVirginia = (SELECT TOP 1 id FROM zones WHERE note='new virginia');
SET @hersh = (SELECT TOP 1 id FROM zones WHERE note='hershfield');
SET @domhalarn = (SELECT TOP 1 id FROM zones WHERE note='domhalarn');
SET @hokk = (SELECT TOP 1 id FROM zones WHERE note='hokkogaros');
SET @hoop = (SELECT TOP 1 id FROM zones WHERE note='norhoop');
SET @kent = (SELECT TOP 1 id FROM zones WHERE note='kentagura');
SET @alsbale = (SELECT TOP 1 id FROM zones WHERE note='alsbale');
SET @nova = (SELECT TOP 1 id FROM zones WHERE note='novastrov');

PRINT N'Assign spawnrates for each type to each zone';
INSERT INTO [dbo].[relicspawninfos]
           ([relicinfoid],[zoneid],[rate],[x],[y])
VALUES
			--NV alpha1
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_neutral_alpha1'),@newVirginia,30,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_neutral_alpha1'),@newVirginia,20,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_neutral_alpha1'),@newVirginia,10,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_indy_alpha1'),@newVirginia,30,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_indy_alpha1'),@newVirginia,20,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_indy_alpha1'),@newVirginia,10,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_numiqol_alpha1'),@newVirginia,30,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_numiqol_alpha1'),@newVirginia,20,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_numiqol_alpha1'),@newVirginia,10,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_thelodica_alpha1'),@newVirginia,30,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_thelodica_alpha1'),@newVirginia,20,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_thelodica_alpha1'),@newVirginia,10,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_pelistal_alpha1'),@newVirginia,30,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_pelistal_alpha1'),@newVirginia,20,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_pelistal_alpha1'),@newVirginia,10,NULL,NULL),
		   --hersh A2
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_neutral_alpha2'),@hersh,30,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_neutral_alpha2'),@hersh,20,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_neutral_alpha2'),@hersh,10,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_indy_alpha2'),@hersh,30,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_indy_alpha2'),@hersh,20,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_indy_alpha2'),@hersh,10,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_numiqol_alpha2'),@hersh,30,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_numiqol_alpha2'),@hersh,20,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_numiqol_alpha2'),@hersh,10,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_thelodica_alpha2'),@hersh,30,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_thelodica_alpha2'),@hersh,20,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_thelodica_alpha2'),@hersh,10,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_pelistal_alpha2'),@hersh,30,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_pelistal_alpha2'),@hersh,20,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_pelistal_alpha2'),@hersh,10,NULL,NULL),
		   --Domharlarn - numiqol B1
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_neutral_beta1'),@domhalarn,30,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_neutral_beta1'),@domhalarn,20,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_neutral_beta1'),@domhalarn,10,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_indy_beta1'),@domhalarn,30,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_indy_beta1'),@domhalarn,20,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_indy_beta1'),@domhalarn,10,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_numiqol_beta1'),@domhalarn,120,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_numiqol_beta1'),@domhalarn,80,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_numiqol_beta1'),@domhalarn,40,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_thelodica_beta1'),@domhalarn,30,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_thelodica_beta1'),@domhalarn,20,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_thelodica_beta1'),@domhalarn,10,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_pelistal_beta1'),@domhalarn,30,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_pelistal_beta1'),@domhalarn,20,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_pelistal_beta1'),@domhalarn,10,NULL,NULL),
		   --Hokkogaros - thelodica B1
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_neutral_beta1'),@hokk,30,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_neutral_beta1'),@hokk,20,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_neutral_beta1'),@hokk,10,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_indy_beta1'),@hokk,30,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_indy_beta1'),@hokk,20,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_indy_beta1'),@hokk,10,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_numiqol_beta1'),@hokk,30,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_numiqol_beta1'),@hokk,20,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_numiqol_beta1'),@hokk,10,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_thelodica_beta1'),@hokk,120,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_thelodica_beta1'),@hokk,80,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_thelodica_beta1'),@hokk,40,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_pelistal_beta1'),@hokk,30,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_pelistal_beta1'),@hokk,20,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_pelistal_beta1'),@hokk,10,NULL,NULL),
		   --Norhoop - pelistal B1
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_neutral_beta1'),@hoop,30,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_neutral_beta1'),@hoop,20,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_neutral_beta1'),@hoop,10,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_indy_beta1'),@hoop,30,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_indy_beta1'),@hoop,20,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_indy_beta1'),@hoop,10,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_numiqol_beta1'),@hoop,30,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_numiqol_beta1'),@hoop,20,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_numiqol_beta1'),@hoop,10,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_thelodica_beta1'),@hoop,30,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_thelodica_beta1'),@hoop,20,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_thelodica_beta1'),@hoop,10,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_pelistal_beta1'),@hoop,120,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_pelistal_beta1'),@hoop,80,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_pelistal_beta1'),@hoop,40,NULL,NULL),

		   --Novastrov - numiqol B2
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_neutral_beta2'),@nova,30,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_neutral_beta2'),@nova,20,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_neutral_beta2'),@nova,10,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_indy_beta2'),@nova,30,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_indy_beta2'),@nova,20,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_indy_beta2'),@nova,10,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_numiqol_beta2'),@nova,120,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_numiqol_beta2'),@nova,80,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_numiqol_beta2'),@nova,40,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_thelodica_beta2'),@nova,30,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_thelodica_beta2'),@nova,20,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_thelodica_beta2'),@nova,10,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_pelistal_beta2'),@nova,30,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_pelistal_beta2'),@nova,20,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_pelistal_beta2'),@nova,10,NULL,NULL),
		   --Kentagura - thelodica B2
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_neutral_beta2'),@kent,30,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_neutral_beta2'),@kent,20,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_neutral_beta2'),@kent,10,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_indy_beta2'),@kent,30,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_indy_beta2'),@kent,20,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_indy_beta2'),@kent,10,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_numiqol_beta2'),@kent,30,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_numiqol_beta2'),@kent,20,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_numiqol_beta2'),@kent,10,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_thelodica_beta2'),@kent,120,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_thelodica_beta2'),@kent,80,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_thelodica_beta2'),@kent,40,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_pelistal_beta2'),@kent,30,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_pelistal_beta2'),@kent,20,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_pelistal_beta2'),@kent,10,NULL,NULL),
		   --Alsbale - pelistal B2
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_neutral_beta2'),@alsbale,30,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_neutral_beta2'),@alsbale,20,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_neutral_beta2'),@alsbale,10,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_indy_beta2'),@alsbale,30,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_indy_beta2'),@alsbale,20,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_indy_beta2'),@alsbale,10,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_numiqol_beta2'),@alsbale,30,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_numiqol_beta2'),@alsbale,20,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_numiqol_beta2'),@alsbale,10,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_thelodica_beta2'),@alsbale,30,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_thelodica_beta2'),@alsbale,20,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_thelodica_beta2'),@alsbale,10,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level1_pelistal_beta2'),@alsbale,120,NULL,NULL),
           ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level2_pelistal_beta2'),@alsbale,80,NULL,NULL),
		   ((SELECT relicinfos.id FROM relicinfos WHERE name='relic_level3_pelistal_beta2'),@alsbale,40,NULL,NULL);

GO
--Also note where a zone does not have any RelicInfos to select from, that zone will also have a null RelicManager to safely prevent issues server-side



--Let's see what happened!
SELECT * from reliczoneconfigs;
SELECT * from relicspawninfos;
SELECT * from relicinfos;
SELECT * from relicloots;
--wow cool

PRINT N'DONE! Init-ing relic tables';
