USE [perpetuumsa]
GO
---------------------------------------------------------
-- Add new "exit" rift definition to render and have title/desc for players
-- 
-- Date: 2020/08/03
---------------------------------------------------------
PRINT N'ADDING NEW "RIFT" ENTITYDEF';
DECLARE @base bigint;
SET @base = 2;

DECLARE @nonAttack BIGINT;
DECLARE @nonLock BIGINT;
DECLARE @invulnerable BIGINT;
DECLARE @useable BIGINT;

SET @nonAttack = (SELECT TOP 1 POWER(@base, offset) FROM attributeFlags WHERE name='nonattackable');
SET @nonLock = (SELECT TOP 1 POWER(@base, offset) FROM attributeFlags WHERE name='nonlockable');
SET @invulnerable = (SELECT TOP 1 POWER(@base, offset) FROM attributeFlags WHERE name='invulnerable');
SET @useable = (SELECT TOP 1 POWER(@base, offset) FROM attributeFlags WHERE name='usable');

DECLARE @exitPortalAttrFlags BIGINT;
SET @exitPortalAttrFlags = @nonAttack + @nonLock + @invulnerable + @useable;
--select * from attributeFlags where offset<63 AND POWER(@base, offset) & @exitPortalAttrFlags = POWER(@base, offset)


DECLARE @defName varchar(100);
DECLARE @defId int;
DECLARE @catFlags BIGINT;

SET @defName = 'def_stronghold_exit_rift';
SET @defId = 5882;
SET @catFlags = (SELECT TOP 1 VALUE FROM categoryFlags WHERE name='cf_portals');


PRINT N'INTEGRITY CHECK: ALL NAMED ENTITYDEFAULTS WITH SPECIFIED IDs MUST BE INSERTED WITH THE SPECIFIED ID';
IF EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE @defId=definition AND @defName!=definitionname)
BEGIN
	PRINT N'====FATAL====';
	PRINT N'DEFINITION INTEGRITY CHECK FAILED! SKIPPING ALL EXECUTION IN THIS SCRIPT';
	PRINT N'====FATAL====';
	SET NOEXEC ON;
END

IF EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE definition=@defId AND definitionname=@defName)
BEGIN
	UPDATE entitydefaults SET
		attributeflags=@exitPortalAttrFlags,
		categoryflags=@catFlags,
		descriptiontoken=@defName+'_desc',
		options='#height=f6.00',
		note='Stronghold Exit Rift!'
	WHERE definition=@defId AND definitionname=@defName;
	PRINT N'UPDATED def_stronghold_exit_rift';
END
ELSE
BEGIN
	SET IDENTITY_INSERT entitydefaults ON;
	INSERT INTO [dbo].[entitydefaults] ([definition],[definitionname],[quantity],[attributeflags],[categoryflags],[options],[note],[enabled],[volume],[mass],[hidden],[health],[descriptiontoken],[purchasable],[tiertype],[tierlevel]) VALUES
		(@defId,@defName,1,@exitPortalAttrFlags,@catFlags,'#height=f6.00','Stronghold Exit Rift!',1,0,0,0,100,@defName+'_desc',0,NULL,NULL);
	PRINT N'INSERTED def_stronghold_exit_rift';
	SET IDENTITY_INSERT entitydefaults OFF;
END


DROP TABLE IF EXISTS #AGGVALS;
CREATE TABLE #AGGVALS 
(
	fieldName varchar(100),
	fieldValue float,
);
INSERT INTO #AGGVALS (fieldName, fieldValue) VALUES
('armor_max', 42069),
('resist_chemical', 100000),
('resist_explosive', 100000),
('resist_kinetic', 100000),
('resist_thermal', 100000),
('signature_radius', 1),
('blob_emission', 10),
('blob_emission_radius', 50),
('stealth_strength', 1);

PRINT N'DELETE OLD STATS';
DELETE FROM aggregatevalues WHERE definition = @defId;

PRINT N'INSERT NEW STATS';
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value])
SELECT 
	@defId,
	(SELECT TOP 1 id FROM aggregatefields WHERE fieldName=name),
	fieldValue 
FROM #AGGVALS;

SET NOEXEC OFF;
PRINT N'END';
GO
