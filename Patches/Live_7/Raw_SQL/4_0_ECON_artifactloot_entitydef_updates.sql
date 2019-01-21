USE perpetuumsa
GO

--Two updates: Kernel increase (artifact loot), and T0/t3- volume changes (entitydefault update)
--Basic sanity checks to guard against running multiple times because values are updated based on previous assumed state

------------Artifact Loot: Kernel Update------------
--Set the maxquantity to 2x previous (vanilla, where max-maxquantity==1600)
--Set minquantity to 50% of max

DECLARE @kernel_max_multi float;
DECLARE @kernel_min_max_factor float;

SET @kernel_max_multi = 2.0;
SET @kernel_min_max_factor = 0.5;


DECLARE @cf_kernel bigint;
SET @cf_kernel = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_kernels');


--Sanity Check that maximum kernels in table are approximately what we expect from vanilla (before this change)
DECLARE @kernel_check bit;
SET @kernel_check = 
	CASE 
		WHEN 1601 > (SELECT TOP 1 maxquantity FROM artifactloot
			JOIN entitydefaults ON artifactloot.definition=entitydefaults.definition 
			WHERE categoryflags=@cf_kernel AND definitionname LIKE 'def_kernel_%' ORDER BY maxquantity DESC)
			THEN 1
		ELSE 0
	END;

IF @kernel_check=1
	PRINT N'Kernel loot max quantity <= 1600 -- WILL RUN UPDATE!';
ELSE
	PRINT N'Kernel loot max quantity >> 1600 -- Update should NOT be executed';

IF @kernel_check=1
	--Set the MaxQuantity to 2x original
	UPDATE artifactloot
	SET
	maxquantity = maxquantity*@kernel_max_multi
	FROM artifactloot as loot
	JOIN entitydefaults as defs on loot.definition=defs.definition 
	WHERE defs.categoryflags=@cf_kernel AND defs.definitionname like 'def_kernel_%';
ELSE
	PRINT N'skipped update maxquantity on kernel loot';


IF @kernel_check=1
	--Using the NEW maxquantity value, after update, Set MinQuantity as 1/2 of max
	UPDATE artifactloot
	SET
	minquantity = maxquantity*@kernel_min_max_factor
	FROM artifactloot as loot
	JOIN entitydefaults as defs on loot.definition=defs.definition 
	WHERE defs.categoryflags=@cf_kernel AND defs.definitionname like 'def_kernel_%';
ELSE
	PRINT N'skipped update maxquantity on kernel loot';

GO



----------------Artifact Loot: T3- T0 volumes-------------
--UPDATE to ENTITYDEFAULTS
--Reduce VOLUME properties of all T0/T3- Modules to increase loot haul potential of artifacters
--Will run if max volume found to be 2.0 (current max size)
--Will not reduce volumes < 0.1


DECLARE @artifact_module_size_factor float;

SET @artifact_module_size_factor = 0.5;

DECLARE @volume_check bit;
SET @volume_check = 
	CASE 
		WHEN (2.0 <= (SELECT TOP 1 volume from entitydefaults WHERE (tiertype=3 and tierlevel=3) or (tiertype=1 and tierlevel=0) and definitionname like 'def_artifact_%' ORDER BY volume DESC)) THEN 1
		ELSE 0
	END;

IF @volume_check=1
	PRINT N'Max volume of items is >=2  WILL RUN UPDATE!';
ELSE
	PRINT N'Max volume of items is <2 -- Update should NOT be executed';

--Sanity check: Max module volume is 2.0
--Run update IFF this module size still exists
IF @volume_check=1
	UPDATE entitydefaults
	SET volume = volume * @artifact_module_size_factor
	WHERE (tiertype=3 and tierlevel=3) or (tiertype=1 and tierlevel=0) and definitionname like 'def_artifact_%' and volume>=0.1;
ELSE
	PRINT N'Update SKIPPED -- must have been run before';

GO

