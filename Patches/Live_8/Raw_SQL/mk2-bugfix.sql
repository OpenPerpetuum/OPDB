USE [perpetuumsa]
GO


--Increases Symbiont and Riveler CPU from 450 to 495

DECLARE @riv_head int;
DECLARE @sym_head int;

SET @riv_head = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_riveler_head_mk2');
SET @sym_head = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_symbiont_head_mk2');

DECLARE @cpu_field int;

SET @cpu_field = (SELECT TOP 1 id FROM aggregatefields WHERE name='cpu_max');

UPDATE aggregatevalues SET value=495 where [definition]=@riv_head and [field]=@cpu_field;
UPDATE aggregatevalues SET value=495 where [definition]=@sym_head and [field]=@cpu_field;

--Changes hitech robot bonus on numiquol from increasing to decreasing cycle time of weapons


DECLARE @definitionID int;
DECLARE @extensionID int;
--The only extenstion being used here
PRINT N'ext_high_tech_specialist';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_high_tech_specialist');


DECLARE @railgun_cycle_field int;
DECLARE @railgun_cycle_bonus float;

SET @railgun_cycle_field = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'railgun_cycle_time_modifier' ORDER BY [name] DESC);
SET @railgun_cycle_bonus = 0.01; --THE FIX

--NUMIQOL COMBAT (update each explictly, even though this bonus and extension combination is unique to blue mk2 combats)
PRINT N'def_yagel_head_mk2';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_yagel_head_mk2' ORDER BY definition DESC);

UPDATE chassisbonus SET
bonus = @railgun_cycle_bonus
WHERE definition=@definitionID AND extension=@extensionID AND targetpropertyID=@railgun_cycle_field;


PRINT N'def_arbalest_head_mk2';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_arbalest_head_mk2' ORDER BY definition DESC);

UPDATE chassisbonus SET
bonus = @railgun_cycle_bonus
WHERE definition=@definitionID AND extension=@extensionID AND targetpropertyID=@railgun_cycle_field;


PRINT N'def_kain_head_mk2';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_head_mk2' ORDER BY definition DESC);

UPDATE chassisbonus SET
bonus = @railgun_cycle_bonus
WHERE definition=@definitionID AND extension=@extensionID AND targetpropertyID=@railgun_cycle_field;


PRINT N'def_mesmer_head_mk2';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_head_mk2' ORDER BY definition DESC);

UPDATE chassisbonus SET
bonus = @railgun_cycle_bonus
WHERE definition=@definitionID AND extension=@extensionID AND targetpropertyID=@railgun_cycle_field;


GO
