USE [perpetuumsa]
GO

----------------MK2 Bonus additions----------------
--All are insertions of new Chassibonus to the Head robot component of each mk2
--This should make the mk2 have the same bonus table as a mk1 + this one bonus
--NOTE: this is to run AFTER the mk2 balance prep script

PRINT N'ALL MK2 HI-TECH SPEC BONUSES';

DECLARE @definitionID int;
DECLARE @extensionID int;
DECLARE @aggfieldID int;
DECLARE @chassisbonusID int;

DECLARE @railgun_cycle_field int;
DECLARE @railgun_cycle_bonus float;

DECLARE @ecm_strength_field int;
DECLARE @ecm_strength_bonus float;

DECLARE @missile_range_field int;
DECLARE @missile_range_bonus float;

DECLARE @neutralize_field int;
DECLARE @neutralize_bonus float;

DECLARE @drain_field int;
DECLARE @drain_bonus float;

DECLARE @crit_field int;
DECLARE @crit_bonus float;

DECLARE @suppress_time_field int;
DECLARE @suppress_time_bonus float;

DECLARE @suppress_range_field int;
DECLARE @suppress_range_bonus float;

DECLARE @harvesting_amount_field int;
DECLARE @harvesting_amount_bonus float;

DECLARE @mining_amount_field int;
DECLARE @mining_amount_bonus float;

DECLARE @demob_resist_field int;
DECLARE @demob_resist_bonus float;


SET @railgun_cycle_field = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'railgun_cycle_time_modifier' ORDER BY [name] DESC);
SET @railgun_cycle_bonus = -0.01;

SET @ecm_strength_field = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'ecm_strength_modifier' ORDER BY [name] DESC);
SET @ecm_strength_bonus =0.01;

SET @missile_range_field = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'missile_range_modifier' ORDER BY [name] DESC);
SET @missile_range_bonus = 0.01;

SET @neutralize_field = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'energy_neutralized_amount_modifier' ORDER BY [name] DESC);
SET @neutralize_bonus =0.01;

SET @drain_field =(SELECT TOP 1 id from aggregatefields WHERE[name] = 'energy_vampired_amount_modifier' ORDER BY [name] DESC);
SET @drain_bonus =0.01;

SET @crit_field  = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'critical_hit_chance_modifier' ORDER BY [name] DESC);
SET @crit_bonus =0.01;

SET @suppress_time_field = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'effect_enhancer_sensor_dampener_locking_time_modifier' ORDER BY [name] DESC);
SET @suppress_time_bonus =0.01;

SET @suppress_range_field =(SELECT TOP 1 id from aggregatefields WHERE[name] = 'effect_enhancer_sensor_dampener_locking_range_modifier' ORDER BY [name] DESC);
SET @suppress_range_bonus =0.005;

SET @mining_amount_field =(SELECT TOP 1 id from aggregatefields WHERE[name] = 'mining_amount_modifier' ORDER BY [name] DESC);
SET @mining_amount_bonus =0.01;

SET @harvesting_amount_field =(SELECT TOP 1 id from aggregatefields WHERE[name] = 'harvesting_amount_modifier' ORDER BY [name] DESC);
SET @harvesting_amount_bonus= 0.01;

SET @demob_resist_field = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'massiveness' ORDER BY [name] DESC);
SET @demob_resist_bonus = 0.01;


--The only extenstion being used here
PRINT N'ext_high_tech_specialist';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_high_tech_specialist');


--NUMIQOL COMBAT
PRINT N'def_yagel_head_mk2';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_yagel_head_mk2' ORDER BY definition DESC);
INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, @railgun_cycle_bonus, '', @railgun_cycle_field, 0);


PRINT N'def_arbalest_head_mk2';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_arbalest_head_mk2' ORDER BY definition DESC);
INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, @railgun_cycle_bonus, '', @railgun_cycle_field, 0);


PRINT N'def_kain_head_mk2';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_head_mk2' ORDER BY definition DESC);
INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, @railgun_cycle_bonus, '', @railgun_cycle_field, 0);


PRINT N'def_mesmer_head_mk2';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_head_mk2' ORDER BY definition DESC);
INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, @railgun_cycle_bonus, '', @railgun_cycle_field, 0);

--NUMIQUOL EWAR
PRINT N'def_vagabond_head_mk2';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vagabond_head_mk2' ORDER BY definition DESC);
INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, @ecm_strength_bonus, '', @ecm_strength_field, 0);


PRINT N'def_cameleon_head_mk2';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_head_mk2' ORDER BY definition DESC);
INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, @ecm_strength_bonus, '', @ecm_strength_field, 0);

--PELISTAL COMBAT
PRINT N'def_castel_head_mk2';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_castel_head_mk2' ORDER BY definition DESC);
INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, @missile_range_bonus, '', @missile_range_field, 0);


PRINT N'def_waspish_head_mk2';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_waspish_head_mk2' ORDER BY definition DESC);
INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, @missile_range_bonus, '', @missile_range_field, 0);


PRINT N'def_tyrannos_head_mk2';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_tyrannos_head_mk2' ORDER BY definition DESC);
INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, @missile_range_bonus, '', @missile_range_field, 0);


PRINT N'def_gropho_head_mk2';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_gropho_head_mk2' ORDER BY definition DESC);
INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, @missile_range_bonus, '', @missile_range_field, 0);

--PELISTAL EWAR
PRINT N'def_troiar_head_mk2';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_troiar_head_mk2' ORDER BY definition DESC);
INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, @neutralize_bonus, '', @neutralize_field, 0);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, @drain_bonus, '', @drain_field, 0);


PRINT N'def_ictus_head_mk2';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ictus_head_mk2' ORDER BY definition DESC);
INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, @neutralize_bonus, '', @neutralize_field, 0);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, @drain_bonus, '', @drain_field, 0);

--THELODICA COMBAT
PRINT N'def_prometheus_head_mk2';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_head_mk2' ORDER BY definition DESC);
INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, @crit_bonus, '', @crit_field, 0);


PRINT N'def_baphomet_mk2_head';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_baphomet_mk2_head' ORDER BY definition DESC);
INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, @crit_bonus, '', @crit_field, 0);


PRINT N'def_artemis_head_mk2';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_head_mk2' ORDER BY definition DESC);
INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, @crit_bonus, '', @crit_field, 0);


PRINT N'def_seth_head_mk2';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_seth_head_mk2' ORDER BY definition DESC);
INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, @crit_bonus, '', @crit_field, 0);

--THELODICA EWAR
PRINT N'def_zenith_head_mk2';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_zenith_head_mk2' ORDER BY definition DESC);
INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, @suppress_range_bonus, '', @suppress_range_field, 0);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, @suppress_time_bonus, '', @suppress_time_field, 0);


PRINT N'def_intakt_head_mk2';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_head_mk2' ORDER BY definition DESC);
INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, @suppress_range_bonus, '', @suppress_range_field, 0);

INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, @suppress_time_bonus, '', @suppress_time_field, 0);



--MINERS
PRINT N'def_argano_head_mk2';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_argano_head_mk2' ORDER BY definition DESC);
INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, @mining_amount_bonus, '', @mining_amount_field, 0);


PRINT N'def_termis_head_mk2';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_termis_head_mk2' ORDER BY definition DESC);
INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, @mining_amount_bonus, '', @mining_amount_field, 0);


PRINT N'def_riveler_head_mk2';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_riveler_head_mk2' ORDER BY definition DESC);
INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, @mining_amount_bonus, '', @mining_amount_field, 0);


--HARVESTERS
PRINT N'def_symbiont_head_mk2';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_symbiont_head_mk2' ORDER BY definition DESC);
INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, @harvesting_amount_bonus, '', @harvesting_amount_field, 0);


PRINT N'def_gargoyle_head_mk2';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_gargoyle_head_mk2' ORDER BY definition DESC);
INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, @harvesting_amount_bonus, '', @harvesting_amount_field, 0);


PRINT N'def_laird_head_mk2';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_laird_head_mk2' ORDER BY definition DESC);
INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, @harvesting_amount_bonus, '', @harvesting_amount_field, 0);


--HAULERS
PRINT N'def_scarab_head_mk2';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_scarab_head_mk2' ORDER BY definition DESC);
INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, @demob_resist_bonus, '', @demob_resist_field, 0);


PRINT N'def_lithus_head_mk2';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_lithus_head_mk2' ORDER BY definition DESC);
INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, @demob_resist_bonus, '', @demob_resist_field, 0);


PRINT N'def_sequer_head_mk2';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_sequer_head_mk2' ORDER BY definition DESC);
INSERT INTO [dbo].[chassisbonus] ([definition],[extension],[bonus],[note],[targetpropertyID],[effectenhancer])
                VALUES (@definitionID, @extensionID, @demob_resist_bonus, '', @demob_resist_field, 0);

GO