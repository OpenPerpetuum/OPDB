USE [perpetuumsa]
GO

--------------------------------------
-- ENABLE AND UNLOCK ALL THE GAMMA THINGS
--
-- Date Modified: 2021/10/25
--------------------------------------


DECLARE @EXT_NAME AS VARCHAR(128) = 'ext_research_pbs';
DECLARE @PBS_CAT AS BIGINT = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_pbs_capsules');
DECLARE @CAT_MASK AS BIGINT = (SELECT dbo.GetCFMask(@PBS_CAT));

PRINT N'UNLOCKING DEFINITIONS:';
SELECT definition, definitionname FROM entitydefaults WHERE (categoryflags & @CAT_MASK)=@PBS_CAT;

UPDATE entitydefaults SET
	enabled=1, hidden=0, purchasable=1
WHERE (categoryflags & @CAT_MASK)=@PBS_CAT;

PRINT N'UNLOCKING MORE RELATED DEFINITIONS:';
UPDATE entitydefaults SET
	purchasable=1, enabled=1, hidden=0
WHERE definition IN (
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_terraform'),
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pbs_construction_module'),
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_terraform_multi_module'),
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_construction_module_ammo_normal'),
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_construction_module_ammo_deconstruct')
);


PRINT N'UNLOCKING SKILL '+@EXT_NAME;
UPDATE extensions SET
	active=1,
	hidden=0,
	price=405000,
	rank=9
WHERE extensionname=@EXT_NAME AND extensionid=350;

GO