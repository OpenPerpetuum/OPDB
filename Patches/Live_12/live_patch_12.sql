USE [perpetuumsa]
GO


-----------------------------------------------------------------
--Patch 12 
--World boss tweaks v1, world changes v2, Sap masking
--Falloff bonus fix on synds, armor plate balance bug
-----------------------------------------------------------------

USE [perpetuumsa]
GO

------------------------------------------------------------
--World Shaping: Move NV and Hersh to center, adjust beta circle
--Date modified: 2019/07/27
--------------------------------------------------------


DECLARE @NewVirginia int;
DECLARE @Hershfield int;
DECLARE @Domhalarn int;
DECLARE @Hokkogaros int;
DECLARE @Norhoop int;
DECLARE @Kentagura int;
DECLARE @Alsbale int;
DECLARE @Novastrov int;

DECLARE @Omega int;

DECLARE @Xiantor int;
DECLARE @Chalydor int;
DECLARE @Emperth int;


SET @NewVirginia = (SELECT TOP 1 id FROM dbo.zones WHERE name='zone_TM' AND note='new virginia');
SET @Hershfield = (SELECT TOP 1 id FROM dbo.zones WHERE name='zone_TM_pve' AND note='hershfield');
SET @Domhalarn = (SELECT TOP 1 id FROM dbo.zones WHERE name='zone_ICS_A_real' AND note='domhalarn');
SET @Hokkogaros = (SELECT TOP 1 id FROM dbo.zones WHERE name='zone_ASI_A_real' AND note='hokkogaros');
SET @Norhoop = (SELECT TOP 1 id FROM dbo.zones WHERE name='zone_TM_A_real' AND note='norhoop');
SET @Kentagura = (SELECT TOP 1 id FROM dbo.zones WHERE name='zone_ASI_pvp' AND note='kentagura');
SET @Alsbale = (SELECT TOP 1 id FROM dbo.zones WHERE name='zone_TM_pvp' AND note='alsbale');
SET @Novastrov = (SELECT TOP 1 id FROM dbo.zones WHERE name='zone_ICS_pvp' AND note='novastrov');

SET @Omega = (SELECT TOP 1 id FROM dbo.zones WHERE name='zone_pvp_arena' AND note='pvp arena');

SET @Xiantor = (SELECT TOP 1 id FROM dbo.zones WHERE name='zone_asi_g_4' AND note='Xiantor');
SET @Chalydor  = (SELECT TOP 1 id FROM dbo.zones WHERE name='zone_ics_g_8');
SET @Emperth  = (SELECT TOP 1 id FROM dbo.zones WHERE name='zone_tm_g_3');


--- Vanilla Islands Pre Gamma
PRINT N'Alpha/Beta islands relocation';
UPDATE zones SET 
x = 0,
y = -1000
WHERE id= @NewVirginia;

UPDATE zones SET
 x= -2000,
 y= -1000
WHERE id= @Hershfield

UPDATE zones SET
 x= -5000,
 y= -2500
WHERE id= @Hokkogaros;

UPDATE zones SET
 x= -1000,
 y= -4000
WHERE id= @Novastrov;

UPDATE zones SET
x= 3000,
y= -2500
WHERE id= @Domhalarn;

UPDATE zones SET
 x= 3000,
 y= 500
WHERE id= @Alsbale;

UPDATE zones SET
x= -1000,
y= 2000
WHERE id= @Norhoop;

UPDATE zones SET
 x= -5000,
 y= 500
WHERE id= @Kentagura;


UPDATE zones SET
 x= 10000,
 y= 10000
WHERE id= @Omega;


--- Gamma islands Island location revamp
PRINT N'Gamma location prep - still hidden';

UPDATE zones SET
x= 5000,
y= -12000
WHERE id= @Emperth;

UPDATE zones SET
 x= -1000,
 y= -10000
WHERE id= @Chalydor;

UPDATE zones SET
 x= -7000,
 y= -12000
WHERE id= @Xiantor;

GO

-----------------------------------------------------------------------------------------------


USE [perpetuumsa]
GO

------------------------------------------------------
--SAP Masking decrease from 100->50rf
--
--Last modified Date: 2019/06/10
------------------------------------------------------

PRINT N'Set Masking Value';
DECLARE @maskingValue float;

SET @maskingValue = 25.0;

DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;

---Active Hacking
PRINT N'def_sap_active_hacking';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_sap_active_hacking' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'stealth_strength' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=@maskingValue WHERE id =  @aggvalueID;

---Passive Hacking
PRINT N'def_sap_passive_hacking';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_sap_passive_hacking' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'stealth_strength' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=@maskingValue WHERE id =  @aggvalueID;

---Destruction
PRINT N'def_sap_destruction';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_sap_destruction' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'stealth_strength' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=@maskingValue WHERE id =  @aggvalueID;

---Specimen
PRINT N'def_sap_specimen_processing';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_sap_specimen_processing' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'stealth_strength' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=@maskingValue WHERE id =  @aggvalueID;

GO

------------------------------------------------

USE [perpetuumsa]
GO

----------------------------------------------------------------------------
--PitBoss Live Tweaks: v1
--Changes: more dps, faster lock, blinder, misc tweaks on other modifiers
--
--Last modified: 2019/07/13
----------------------------------------------------------------------------


PRINT N'Blinder module definition lookup for template insertion';
DECLARE @blinderModule int;
DECLARE @blinderModHex VARCHAR(50);

--Blinder module definition
SET @blinderModule = (SELECT TOP 1 definition from dbo.entitydefaults WHERE definitionname='def_standard_blinder');
PRINT @blinderModule;

SET @blinderModHex = (SELECT dbo.ToHex(@blinderModule));

DECLARE @templateID int
DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;

--New NPC Goblin Lancer - Mirrored off Goblin Shark Attributes No guns
PRINT N'Pitboss: update robottemplate';

SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'Hersh_PitBoss' ORDER BY id DESC)

UPDATE robottemplates SET
name='Hersh_PitBoss',
description='#robot=i1594#head=i1595#chassis=i1596#leg=i1597#container=i14c#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i32|slot=i2]|m2=[|definition=i33|slot=i3]|m3=[|definition=i34|slot=i4]|m4=[|definition=i'+@blinderModHex+'|slot=i5]]#chassisModules=[|m0=[|definition=i3d|slot=i1|ammoDefinition=i986|ammoQuantity=i32]|m1=[|definition=i3d|slot=i2|ammoDefinition=i986|ammoQuantity=i32]|m2=[|definition=i3d|slot=i3|ammoDefinition=i986|ammoQuantity=i32]|m3=[|definition=i3d|slot=i4|ammoDefinition=i988|ammoQuantity=i32]|m4=[|definition=i3d|slot=i5|ammoDefinition=i988|ammoQuantity=i32]|m5=[|definition=i3d|slot=i6|ammoDefinition=i988|ammoQuantity=i32]]#legModules=[|m0=[|definition=i10|slot=i1]|m1=[|definition=i13|slot=i2]|m2=[|definition=i13|slot=i3]|m3=[|definition=i3b7|slot=i4]|m4=[|definition=i11e0|slot=i5]|m5=[|definition=i11e0|slot=i6]]',
note='Pit Boss for Hershfield'
WHERE id=@templateID;

PRINT N'Update aggfields on npc definition';
--Pitboss definition
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_Hersh_PitBoss' ORDER BY definition DESC);

--NEW accuracymod (lower hit chance on small doods)
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.25);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=9.0 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12.5 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2.25 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=15.0 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_recharge_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.9 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2.6 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=3.0 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'falloff_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.75 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locking_range_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.75 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locking_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'missile_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.85 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'optimal_range_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'resist_chemical' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=375 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'resist_explosive' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=375 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'resist_kinetic' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=375 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'resist_thermal' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=375 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.50 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'turret_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.85 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'received_repaired_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=10.0 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'stealth_strength_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=-60 WHERE id =  @aggvalueID;

GO


-----------------------------------------------------------

USE [perpetuumsa]
GO

---------------------------------------------------------
--Market: Intrusion scanner charge price -50%
--Set the intrusion scanner charge to 250k nic from npc orders
--Date: 2019/07/06
---------------------------------------------------------

PRINT N'Set price of def_ammo_intrusion_scan to 250k';
DECLARE @def int;
DECLARE @sellprice float;

SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_intrusion_scan');
SET @sellprice = 250000;


UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def 
and isSell=1 and isvendoritem=1;

GO

--------------------------------------------------------------
USE [perpetuumsa]
GO

-----------------------------------------------------------------
--ChassisBonus: Balance bug fix for falloff modifiers on syndicates
--Bug: Wrong falloff aggfield
--Updates 4 records
--Date: 2019/07/13
-----------------------------------------------------------------


DECLARE @definitionID int;
DECLARE @extensionID int;
DECLARE @newAggfieldID int;
DECLARE @oldAggfieldID int;

--The mistake: Falloff was not correct type of falloff
SET @oldAggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'falloff_modifier' ORDER BY [name] DESC);
SET @newAggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'projectile_falloff_modifier' ORDER BY [name] DESC);

--Legatus
PRINT N'Heavy/mech skill: ext_heavyarmored_unit_piloting';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');

PRINT N'Chassis def: def_legatus_chassis';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_legatus_chassis' ORDER BY definition DESC);

PRINT N'fix bonus effect field';
UPDATE chassisbonus SET 
targetpropertyID=@newAggfieldID
WHERE extension=@extensionID
AND definition=@definitionID
AND targetpropertyID=@oldAggfieldID;


--Echelon
PRINT N'Chassis def: def_echelon_chassis';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_echelon_chassis' ORDER BY definition DESC);

PRINT N'fix bonus effect field';
UPDATE chassisbonus SET 
targetpropertyID=@newAggfieldID
WHERE extension=@extensionID
AND definition=@definitionID
AND targetpropertyID=@oldAggfieldID;



--Locust
PRINT N'Light/assault skill: ext_lightarmored_unit_piloting';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');

PRINT N'Chassis def: def_locust_chassis';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_locust_chassis' ORDER BY definition DESC);

PRINT N'fix bonus effect field';
UPDATE chassisbonus SET 
targetpropertyID=@newAggfieldID
WHERE extension=@extensionID
AND definition=@definitionID
AND targetpropertyID=@oldAggfieldID;


--Vektor
PRINT N'Chassis def: def_vektor_chassis';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vektor_chassis' ORDER BY definition DESC);

PRINT N'fix bonus effect field';
UPDATE chassisbonus SET 
targetpropertyID=@newAggfieldID
WHERE extension=@extensionID
AND definition=@definitionID
AND targetpropertyID=@oldAggfieldID;

GO

----------------------------------------------------------------
USE [perpetuumsa]
GO

------------------------------------------------------
--Armor plate balance bugs: missed artifact types
--Massiveness was out of line from previous balancing to plates
--Date: 2019/07/13
------------------------------------------------------


DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;

PRINT N'def_artifact_a_small_armor_plate';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_small_armor_plate' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'massiveness' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.11 WHERE id =  @aggvalueID;

PRINT N'def_artifact_a_medium_armor_plate';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_medium_armor_plate' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'massiveness' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.13 WHERE id =  @aggvalueID;

PRINT N'def_artifact_damaged_medium_armor_plate';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_damaged_medium_armor_plate' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'massiveness' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.12 WHERE id =  @aggvalueID;


GO


--------------------------------------------------------------