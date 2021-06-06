--------------------------------------------------------------------------------
--Patch 11; Live-date 2019/06/30
--
--20190508T014400Z_welcome_chat_message
--Blinder_moduleAndNPCs__2019_05_22
--Characters_welcomechar-bugfix__2019_04_25
--Itemshop_EntityDefaults_updates_epbonusitem__2019_06_12
--Itemshop_Inserts_missing-silgium__2019_06_07
--Itemshop_pvpammo_hersh__2019_05_05
--NpcLoots_alpha1_omega_bosses__2019_05_02
--NPCs_Beta1__2019_05_02
--NPCs_Beta2__2019_05_02
--PitBoss_and_EPboostitem_t0loot__2019_05_23
--Proc_getExtensionSub_datetime_fix__2019_06_30
-------------------------------------------------------------------------------





PRINT N'Proc_getExtensionSub_datetime_fix__2019_06_30'
-------------------------------------------------------------------------------
USE [perpetuumsa]
GO
--------------------------------
--Fix Boost subscription check procedure utc->local
--Date: 2019/05/19
--REVISION: 2019/06/30 - bug fix on not checking accountID!
--------------------------------

IF OBJECT_ID('opp.getExtensionSubscription', 'P') IS NOT NULL
	DROP PROCEDURE [opp].[getExtensionSubscription];
GO

CREATE procedure [opp].[getExtensionSubscription]
	@accountID int
as

select top 1
	starttime,
	endtime,
	multiplierBonus
from dbo.extensionsubscription
where startTime < getdate() and endtime > getdate() and @accountID=accountid
order by endtime desc;

GO
----------------------------------------------------------------------------

PRINT N'Itemshop_pvpammo_hersh__2019_05_05'
---------------------------------------------------------------------------
USE [perpetuumsa]
GO
set noexec off;

-----------------------------------------
--Itemshop update and inserts
--Updates missile quantities
--Inserts pvp nian faction ammo at hersh
--
--Date: 2019/05/05
-----------------------------------------


DECLARE @hershfieldPresetShop int;

SET @hershfieldPresetShop = (SELECT TOP 1 id FROM itemshoppresets WHERE name = 'tm_preset_pve');

--Query to locate locations of itemshoppresets by zone
--SELECT * FROM itemshoppresets
--JOIN itemshoplocations on itemshoplocations.presetid=itemshoppresets.id
--WHERE locationeid in (SELECT e.eid FROM entities as e
--WHERE parent in (SELECT p.eid FROM entities as p
--JOIN zoneentities on zoneentities.eid=p.eid
--WHERE zoneentities.zoneID = (SELECT TOP 1 id FROM zones WHERE name='zone_TM_pve' AND note='hershfield')));

PRINT N'ItemShopPreset is (should be 1):'
PRINT @hershfieldPresetShop;


DECLARE @MissileMedLR_A int;
DECLARE @MissileMedLR_B int;
DECLARE @MissileMed_A int;
DECLARE @MissileMed_B int;
DECLARE @MissileSmall_A int;
DECLARE @MissileSmall_B int;

SET @MissileMedLR_A  = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_ammo_longrange_missile_rewa');
SET @MissileMedLR_B = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_ammo_longrange_missile_rewb');
SET @MissileMed_A = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_ammo_missile_rewa');
SET @MissileMed_B = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_ammo_missile_rewb');
SET @MissileSmall_A = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_ammo_rocket_rewa');
SET @MissileSmall_B = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_ammo_rocket_rewb');

DECLARE @LaserMed_A int;
DECLARE @LaserMed_B int;
DECLARE @LaserSmall_A int;
DECLARE @LaserSmall_B int;

SET @LaserMed_A  = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_ammo_medium_lasercrystal_rewa');
SET @LaserMed_B = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_ammo_medium_lasercrystal_rewb');
SET @LaserSmall_A = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_ammo_small_lasercrystal_rewa');
SET @LaserSmall_B = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_ammo_small_lasercrystal_rewb');


DECLARE @RailgunMed_A int;
DECLARE @RailgunMed_B int;
DECLARE @RailgunSmall_A int;
DECLARE @RailgunSmall_B int;

SET @RailgunMed_A  = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_ammo_medium_railgun_rewa');
SET @RailgunMed_B = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_ammo_medium_railgun_rewb');
SET @RailgunSmall_A = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_ammo_small_railgun_rewa');
SET @RailgunSmall_B = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_ammo_small_railgun_rewb');


PRINT N'Set all existing entries for Small Missiles to 300 per';
UPDATE dbo.itemshop
SET targetamount=300
WHERE presetid!=@hershfieldPresetShop AND
targetdefinition in (@MissileSmall_A, @MissileSmall_B);

PRINT N'Set all existing entries for Medium Missiles to 450 per';
UPDATE dbo.itemshop
SET targetamount=450
WHERE presetid!=@hershfieldPresetShop AND
targetdefinition in (@MissileMedLR_A, @MissileMedLR_B, @MissileMed_A, @MissileMed_B);

set noexec off;
IF EXISTS (SELECT TOP 1 id FROM itemshop WHERE targetdefinition=@MissileSmall_A AND presetid=@hershfieldPresetShop)
BEGIN
	PRINT N'ENTRY FOUND for missiles at hersh! Skipping inserts';
	set noexec on;
END

PRINT N'Insert missle pvp ammo at hershfield at amounts 25% less than as available on beta';
INSERT INTO [dbo].[itemshop]
           ([presetid],[targetdefinition],[targetamount],[tmcoin],[icscoin],[asicoin],[credit],[unicoin],[globallimit],[purchasecount],[standing])
     VALUES
           (@hershfieldPresetShop,@MissileSmall_A,240,100,NULL,NULL,200000,NULL,NULL,0,NULL),
		   (@hershfieldPresetShop,@MissileSmall_B,240,100,NULL,NULL,200000,NULL,NULL,0,NULL),
		   (@hershfieldPresetShop,@MissileMed_A,360,600,NULL,NULL,1200000,NULL,NULL,0,NULL),
		   (@hershfieldPresetShop,@MissileMed_B,360,600,NULL,NULL,1200000,NULL,NULL,0,NULL),
		   (@hershfieldPresetShop,@MissileMedLR_A,360,600,NULL,NULL,1200000,NULL,NULL,0,NULL),
		   (@hershfieldPresetShop,@MissileMedLR_B,360,600,NULL,NULL,1200000,NULL,NULL,0,NULL);

set noexec off;
IF EXISTS (SELECT TOP 1 id FROM itemshop WHERE targetdefinition=@LaserSmall_A AND presetid=@hershfieldPresetShop)
BEGIN
	PRINT N'ENTRY FOUND for laser ammo at hersh! Skipping inserts';
	set noexec on;
END

PRINT N'Insert laser pvp ammo at hershfield at amounts 25% less than as available on beta';
INSERT INTO [dbo].[itemshop]
           ([presetid],[targetdefinition],[targetamount],[tmcoin],[icscoin],[asicoin],[credit],[unicoin],[globallimit],[purchasecount],[standing])
     VALUES
           (@hershfieldPresetShop,@LaserSmall_A,300,NULL,NULL,100,200000,NULL,NULL,0,NULL),
		   (@hershfieldPresetShop,@LaserSmall_B,300,NULL,NULL,100,200000,NULL,NULL,0,NULL),
		   (@hershfieldPresetShop,@LaserMed_A,450,NULL,NULL,600,1200000,NULL,NULL,0,NULL),
		   (@hershfieldPresetShop,@LaserMed_B,450,NULL,NULL,600,1200000,NULL,NULL,0,NULL);


set noexec off;
IF EXISTS (SELECT TOP 1 id FROM itemshop WHERE targetdefinition=@RailgunSmall_A AND presetid=@hershfieldPresetShop)
BEGIN
	PRINT N'ENTRY FOUND for railgun ammo at hersh! Skipping inserts';
	set noexec on;
END

PRINT N'Insert railgun pvp ammo at hershfield at amounts 25% less than as available on beta';
INSERT INTO [dbo].[itemshop]
           ([presetid],[targetdefinition],[targetamount],[tmcoin],[icscoin],[asicoin],[credit],[unicoin],[globallimit],[purchasecount],[standing])
     VALUES
           (@hershfieldPresetShop,@RailgunSmall_A,240,NULL,100,NULL,200000,NULL,NULL,0,NULL),
		   (@hershfieldPresetShop,@RailgunSmall_B,240,NULL,100,NULL,200000,NULL,NULL,0,NULL),
		   (@hershfieldPresetShop,@RailgunMed_A,360,NULL,600,NULL,1200000,NULL,NULL,0,NULL),
		   (@hershfieldPresetShop,@RailgunMed_B,360,NULL,600,NULL,1200000,NULL,NULL,0,NULL);


set noexec off;
PRINT N'Itemshop update and inserts complete';
GO
--------------------------------------------------------------------------------------------------------

PRINT N'Itemshop_Inserts_missing-silgium__2019_06_07'
--------------------------------------------------------------------------------------------------------
USE [perpetuumsa]
GO

------------------------------
-- INSERT Itemshop orders
-- Missing silgium rewa ammo orders
--
-- Date: 2019/06/07
------------------------------

PRINT N'Insert missing orders for silgium tile scanner ammo in all itemshops';

DECLARE @ammo int;
SET @ammo  = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = 'def_ammo_mining_probe_silgium_tile_rewa');


DECLARE @tm_pve_shopid int;
DECLARE @ics_pve_shopid int;
DECLARE @asi_pve_shopid int;
DECLARE @tm_pvp_shopid int;
DECLARE @ics_pvp_shopid int;
DECLARE @asi_pvp_shopid int;

SET @tm_pve_shopid = (SELECT TOP 1 id from itemshoppresets where name='tm_preset_pve');
SET @ics_pve_shopid = (SELECT TOP 1 id from itemshoppresets where name='ics_preset_pve');
SET @asi_pve_shopid = (SELECT TOP 1 id from itemshoppresets where name='asi_preset_pve');
SET @tm_pvp_shopid = (SELECT TOP 1 id from itemshoppresets where name='tm_preset_pvp');
SET @ics_pvp_shopid = (SELECT TOP 1 id from itemshoppresets where name='ics_preset_pvp');
SET @asi_pvp_shopid = (SELECT TOP 1 id from itemshoppresets where name='asi_preset_pvp');


INSERT INTO [dbo].[itemshop]
           ([presetid],[targetdefinition],[targetamount],[tmcoin],[icscoin],[asicoin],[credit],[unicoin],[globallimit],[purchasecount],[standing])
     VALUES
           (@tm_pve_shopid,@ammo,10,NULL,NULL,NULL,75000,150,NULL,100,NULL),
		   (@ics_pve_shopid,@ammo,10,NULL,150,NULL,75000,NULL,NULL,100,NULL),
		   (@asi_pve_shopid,@ammo,10,NULL,NULL,150,75000,NULL,NULL,100,NULL),
		   (@tm_pvp_shopid,@ammo,12,150,NULL,NULL,75000,NULL,NULL,100,NULL),
		   (@ics_pvp_shopid,@ammo,12,NULL,150,NULL,75000,NULL,NULL,100,NULL),
		   (@asi_pvp_shopid,@ammo,12,NULL,NULL,150,75000,NULL,NULL,100,NULL);
GO

PRINT N'Inserts complete';

----------------------------------------------------------------------------------------------------------------


PRINT N'Itemshop_EntityDefaults_updates_epbonusitem__2019_06_12'
--------------------------------------------------------------------------------------------------------
USE [perpetuumsa]
GO

----------------------------------------------
--EP Bonus Item Price reduce, and Duration increase
--
--Date: 2019/06/12
----------------------------------------------

DECLARE @epboost1 int;
DECLARE @epboost2 int;
DECLARE @epboost3 int;

SET @epboost1 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_boost_ep_t1');
SET @epboost2 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_boost_ep_t2');
SET @epboost3 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_boost_ep_t3');

PRINT N'Update Entitydefault of boost items, change options(the real stuff) string and note';
UPDATE entitydefaults SET
	options = '#addBoost=n2 #timePeriodHours=i30 #tier=$tierlevel_t1',
	note = 'Adds 2 to the current EP income multiplier for 48 hours'
WHERE definition=@epboost1;

UPDATE entitydefaults SET
	options = '#addBoost=n3 #timePeriodHours=i30 #tier=$tierlevel_t2',
	note = 'Adds 3 to the current EP income multiplier for 48 hours'
WHERE definition=@epboost2;

UPDATE entitydefaults SET
	options = '#addBoost=n5 #timePeriodHours=i30 #tier=$tierlevel_t3',
	note = 'Adds 5 to the current EP income multiplier for 48 hours'
WHERE definition=@epboost3;

PRINT N'Update AggregateValues for the items despawntime, info window data to help players understand how long it lasts';
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'despawn_time' ORDER BY [name] DESC);

SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @epboost1 AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@epboost1, field=@aggfieldID, value=172800000 WHERE id =  @aggvalueID;

SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @epboost2 AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@epboost2, field=@aggfieldID, value=172800000 WHERE id =  @aggvalueID;

SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @epboost3 AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@epboost3, field=@aggfieldID, value=172800000 WHERE id =  @aggvalueID;

PRINT N'Update itemshop nic pricing to T1=40m, T2=57.5m T3=95m';
UPDATE itemshop SET
credit = 24600000
WHERE targetdefinition=@epboost1;

UPDATE itemshop SET
credit = 36000000
WHERE targetdefinition=@epboost2;

UPDATE itemshop SET
credit = 57000000
WHERE targetdefinition=@epboost3;

GO
-------------------------------------------------------------------------------------------------------------------


PRINT N'PitBoss_and_EPboostitem_t0loot__2019_05_23';
----------------------------------------------------------------------------------------------------------------
----PART 1 ADD NEW EP ITEM


USE [perpetuumsa]
GO

-------------------------------------------------
--INSERTS ENTITYDEFAULT****
--T0 EP boost item for Pitboss loot
--REQUIRED FOR PITBOSS LOOT PATCH
--Date: 2019/05/19
-------------------------------------------------



PRINT N'INSERT ENTITYDEFAULT def_boost_ep_t0';
--Insert a T0 variant EP boost item for Pitboss loot only
INSERT INTO [dbo].[entitydefaults]
           ([definitionname]
           ,[quantity]
           ,[attributeflags]
           ,[categoryflags]
           ,[options]
           ,[note]
           ,[enabled]
           ,[volume]
           ,[mass]
           ,[hidden]
           ,[health]
           ,[descriptiontoken]
           ,[purchasable]
           ,[tiertype]
           ,[tierlevel])
     VALUES
           ('def_boost_ep_t0'
           ,1
           ,2052
           ,1179
           ,'#addBoost=n1 #timePeriodHours=i1 #tier=$tierlevel_t0'
           ,'Adds 1 to the current EP multiplier for 1 hours'
           ,1
           ,1E-06
           ,1E-06
           ,0
           ,100
           ,'def_redeemable_ep_standard_desc'
           ,1
           ,1
           ,0);
GO

--Insert "despawn time" as the intended duration of the item as milliseconds
INSERT INTO dbo.aggregatevalues
(
	[definition],
	[field],
	[value]
)
VALUES
(
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_boost_ep_t0'),
	(SELECT TOP 1 id FROM dbo.aggregatefields WHERE name='despawn_time'),
	3600000
);

GO


---PART 2 ADD PITBOSS

USE [perpetuumsa]
GO

PRINT N'PITBOSS PATCH';
--------------------------------------------------------------
--PITBOSS PATCH
--Compilation of previous dev-patches in order of execution
--NPC_Pitboss_0_0__init__2018_10_15
--NPC_Pitboss_0_1__npctweak__2018_10_27
--NPC_Pitboss_0_2__loot_killep_npcmods_respawnrate__2019_01_13
--NPC_Pitboss_0_3__loot_npc_fields__2019_01_27
--NPC_Pitboss_0_4__fitting_modifiers_loot_updates__2019_03_30
--
--REQUIRES: 00_INSERT_Entitydefault_Epboostitem_t0__2019_05_19
------------------------------------------------------------



PRINT N'EXECUTING: NPC_Pitboss_0_0__init__2018_10_15';

USE [perpetuumsa]
GO

--DEFINES NEW NPC
--ENTITYDEFAULT
--ROBOTTEMPLATE
--ROBOTTEMPLATERELATION
--AGGREGATEVALUES
--NPCPRESENCE
--NPCFLOCK

--PITBOSS ON HERSHFIELD FOR DEV-TESTING PURPOSES ONLY


DECLARE @templateID int;
DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
DECLARE @flockID int;
DECLARE @presenceID int;

PRINT N'INSERT NEW NPC DEFINITION';
INSERT INTO entitydefaults ( definitionname ,  quantity ,  attributeflags ,  categoryflags ,  options ,  note ,  enabled ,  volume ,  mass ,  hidden , 
                health ,  descriptiontoken ,  purchasable ,  tiertype ,  tierlevel ) 
                VALUES ( 'def_npc_Hersh_PitBoss', 1, 1024, 911, '', '', 1, 0, 0, 0, 100, 'def_npc_seth_heavydps_rank1_desc', 0, 0, 0); 

PRINT N'INSERT NEW NPC ROBOTTEMPLATE';
INSERT INTO robottemplates ([name], [description], [note]) VALUES ('Hersh_PitBoss', '#robot=i1594#head=i1595#chassis=i1596#leg=i1597#container=i14c#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i32|slot=i2]|m2=[|definition=i33|slot=i3]|m3=[|definition=i34|slot=i4]]#chassisModules=[|m0=[|definition=i3d|slot=i1|ammoDefinition=i986|ammoQuantity=i32]|m1=[|definition=i3d|slot=i2|ammoDefinition=i986|ammoQuantity=i32]|m2=[|definition=i3d|slot=i3|ammoDefinition=i986|ammoQuantity=i32]|m3=[|definition=i3d|slot=i4|ammoDefinition=i988|ammoQuantity=i32]|m4=[|definition=i3d|slot=i5|ammoDefinition=i988|ammoQuantity=i32]|m5=[|definition=i3d|slot=i6|ammoDefinition=i988|ammoQuantity=i32]]#legModules=[|m0=[|definition=i10|slot=i1]|m1=[|definition=i18|slot=i2]|m2=[|definition=i1a|slot=i3]|m3=[|definition=i19|slot=i4]|m4=[|definition=i1b|slot=i5]|m5=[|definition=i13|slot=i6]]', 'Pit Boss for Hershfield')


PRINT N'INSERT NEW ROBOTTEMPLATE RELATION';
SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'Hersh_PitBoss' ORDER BY id DESC)
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_Hersh_PitBoss' ORDER BY definition DESC);
--MISSION LEVEL AND MISSION LEVEL OVERRIDE NEED TO BE NULL!
INSERT INTO [dbo].[robottemplaterelation] ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
                VALUES (@definitionID,@templateID,0,0,NULL,NULL,40,'Hersh_Pit_Boss');

PRINT N'INSERT AGGVALUES - NPC modifiers';
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 3.0);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2.0);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_recharge_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.5);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2.5);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.0);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'falloff_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2.0);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locking_range_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.5);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locking_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.25);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'missile_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.0);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'optimal_range_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2.0);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'turret_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.75);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'received_repaired_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 10);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 5.0);

PRINT N'INSERT NPCPRESENCE';
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('Presence_NPC_Hersh_PitBoss',7,7,2038,2038,'Hersh_BlueBoss',13,1,1,60,5,0,0,0,0,0,0,1,1);

PRINT N'INSERT NPCFLOCK';
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Presence_NPC_Hersh_PitBoss' ORDER BY id DESC)
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_Hersh_PitBoss' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Hersh_Pit_Boss' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Hersh_Pit_Boss', @presenceID, 1, @definitionID, 933, 1231, 0, 5, 60, 0, 100, 'Hersh_Pit_Boss', 1, 1, 1, 1); 

GO

PRINT N'COMPLETE: NPC_Pitboss_0_0__init__2018_10_15';

PRINT N'EXECUTING: NPC_Pitboss_0_1__npctweak__2018_10_27';

USE [perpetuumsa]
GO

--PITBOSS experiment balance part 2
--Insert slowdown and masking drop
--update other npc properties

DECLARE @definitionID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_Hersh_PitBoss' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_npc_Hersh_PitBoss', quantity=1, attributeflags=1024, categoryflags=911, options='', 
                note='', enabled=1, volume=0, mass=0, hidden='False', health=100, descriptiontoken='def_npc_seth_heavydps_rank1_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

DECLARE @aggvalueID int;
DECLARE @aggfieldID int;

--Set Speed of Pitboss to 50% of its max
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max_modifier' ORDER BY [name] DESC);

INSERT INTO [dbo].[aggregatevalues]
           ([definition],[field],[value])
     VALUES
           (@definitionID, @aggfieldID, 0.5);


--Set modification of masking to -70 (result effect will be masking =10)
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'stealth_strength_modifier' ORDER BY [name] DESC);

INSERT INTO [dbo].[aggregatevalues]
           ([definition],[field],[value])
     VALUES
           (@definitionID, @aggfieldID, -70);



--Redundant updates to above inserts -- For use as template to future tweaks
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'stealth_strength_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=-50 WHERE id =  @aggvalueID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.5 WHERE id =  @aggvalueID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=3.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=10.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_recharge_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2.6 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.1 WHERE id =  @aggvalueID;



SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'falloff_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.6 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locking_range_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.6 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locking_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.6 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'missile_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.85 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'optimal_range_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2.1 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'turret_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.85 WHERE id =  @aggvalueID;

--Redundant updates to above inserts --
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'stealth_strength_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=-50 WHERE id =  @aggvalueID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.5 WHERE id =  @aggvalueID;

GO

PRINT N'COMPLETE NPC_Pitboss_0_1__npctweak__2018_10_27';


PRINT N'EXECUTING: NPC_Pitboss_0_2__loot_killep_npcmods_respawnrate__2019_01_13';


USE [perpetuumsa]
GO


--SETS RESPAWN RATE TO 5 DAYS
--UPDATES TEMPLATE/FITTINGS
--KILLEP SET TO 1000
--FASTER ARMOR REPAIR
--FULL LOOT TABLE
--Add Color!

--PITBOSS ON HERSHFIELD FOR DEV-TESTING PURPOSES ONLY

DECLARE @presenceID int
DECLARE @flockID int;
DECLARE @definitionID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_Hersh_PitBoss' ORDER BY definition DESC);


--Presence Update - set respawn timer to 5 days!
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Presence_NPC_Hersh_PitBoss' ORDER BY id DESC)
UPDATE [dbo].[npcpresence] SET [name] = 'Presence_NPC_Hersh_PitBoss',
[topx] = 7,[topy] = 7,[bottomx] = 2038,[bottomy] = 2038,[note] = 'Hersh_Boss',[spawnid] = 13,[enabled] = 1,[roaming] = 1,
[roamingrespawnseconds] = 432000, [presencetype] = 5, [maxrandomflock] = '', [randomcenterx] = '', [randomcentery] = '', 
[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
WHERE id=@presenceID;

--Set Flock respawn too (to be consistent)
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Hersh_Pit_Boss' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET 
[name] = 'Hersh_Pit_Boss' ,[presenceid] = @presenceID, [flockmembercount] = 1, 
[definition] = @definitionID, [spawnoriginX] = 933, [spawnoriginY] = 1231 ,
[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 432000, 
[totalspawncount] = 0, [homerange] = 100 ,[note] = 'Hersh_Pit_Boss',
[respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 
WHERE id=@flockID;



DECLARE @templateID int;
SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'Hersh_PitBoss' ORDER BY id DESC);

--Update fittings
UPDATE robottemplates SET 
name='Hersh_PitBoss', 
description='#robot=i1594#head=i1595#chassis=i1596#leg=i1597#container=i14c#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i32|slot=i2]|m2=[|definition=i33|slot=i3]|m3=[|definition=i34|slot=i4]]#chassisModules=[|m0=[|definition=i3d|slot=i1|ammoDefinition=i986|ammoQuantity=i32]|m1=[|definition=i3d|slot=i2|ammoDefinition=i986|ammoQuantity=i32]|m2=[|definition=i3d|slot=i3|ammoDefinition=i986|ammoQuantity=i32]|m3=[|definition=i3d|slot=i4|ammoDefinition=i988|ammoQuantity=i32]|m4=[|definition=i3d|slot=i5|ammoDefinition=i988|ammoQuantity=i32]|m5=[|definition=i3d|slot=i6|ammoDefinition=i988|ammoQuantity=i32]]#legModules=[|m0=[|definition=i10|slot=i1]|m1=[|definition=i18|slot=i2]|m2=[|definition=i1a|slot=i3]|m3=[|definition=i1b|slot=i4]|m4=[|definition=i13|slot=i5]|m5=[|definition=i13|slot=i6]]',
note='Pit Boss for Hershfield' 
WHERE id=@templateID;

--Update KillEP = 1000!
UPDATE [dbo].[robottemplaterelation] SET 
[templateid] = @templateID,[itemscoresum] = 0,[raceid] = 0,
[missionlevel] = NULL,[missionleveloverride] = NULL,[killep] = 1000,
[note] = 'Hersh_Pit_Boss' 
WHERE [definition] = @definitionID;


--Add faster armor repair cycles, resistance, accum
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.75);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'resist_chemical' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 300);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'resist_explosive' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 300);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'resist_kinetic' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 300);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'resist_thermal' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 300);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=3.5 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_repair_amount_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12.5 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.15 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4.5 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_recharge_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=4.5 WHERE id =  @aggvalueID;


---Add Color

INSERT INTO [dbo].[definitionconfig]
           ([definition],[targetdefinition],[summonerscount],[npcpresenceid],[item_work_range],[explosion_radius],[cycle_time],[damage_chemical]
           ,[damage_explosive],[damage_kinetic],[damage_thermal],[lifetime],[activationtime],[waves],[missionrelated],[constructionradius],[action_delay]
           ,[deploy_radius],[transmitradius],[constructionlevelmax],[blockingradius],[chargeamount],[inconnections],[outconnections],[coretransferred],[transferefficiency]
           ,[productionupgradeamount],[productionlevel],[coreconsumption],[effectid],[corecalories],[corekickstartthreshold],[reinforcecountermax],[bandwidthusage]
           ,[bandwidthcapacity],[emitradius],[tint],[typeexclusiverange],[network_node_range],[hitsize],[note])
     VALUES
           (@definitionID,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
           ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'#33000f'
		   ,NULL,NULL,NULL,'Hersh Pitboss color');



--INSERT LOOTS


DECLARE @lootdefinitionID int;
DECLARE @npclootID int;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 110000, 1.0, 1,1, 75000);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_pelistal' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 25000, 1, 1,1, 20000);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_thelodica' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 25000, 1, 1,1, 20000);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_nuimqol' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 25000, 1, 1,1, 20000);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 125000, 1, 1,1, 100000);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 50000, 1, 1,1, 50000);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 2500, 1, 1,1, 1000);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_advanced' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 2500, 1, 1,1, 1000);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_expert' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 2500, 1, 1,1, 1000);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_9' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 5, 1, 1,1, 2);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_10' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 5, 1, 1,1, 2);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_armor_plate' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.125, 1,1, 0);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_armor_repairer' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.125, 1,1, 0);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_thrm_armor_hardener' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.125, 1,1, 0);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_chm_armor_hardener' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.125, 1,1, 0);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_kin_armor_hardener' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.125, 1,1, 0);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_exp_armor_hardener' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.125, 1,1, 0);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_sensor_booster' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.125, 1,1, 0);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_sensor_jammer' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.125, 1,1, 0);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_autocannon' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 6, 0.125, 1,1, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_damage_mod_projectile' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 3, 0.125, 1,1, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_armor_repairer_upgrade' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 2, 0.125, 1,1, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_gang_assist_speed_module' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.125, 1,1, 0);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_gang_assist_precision_firing_module' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.125, 1,1, 0);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_gang_assist_ewar_range_module_pr' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.125, 1,1, 0);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_stealth_modul' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.125, 1,1, 0);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_small_shield_generator' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.125, 1,1, 0);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_medium_shield_generator' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.125, 1,1, 0);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_reactor_sealing' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.125, 1,1, 0);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_energy_warfare_upgrade' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.125, 1,1, 0);

GO


PRINT N'COMPLETE NPC_Pitboss_0_2__loot_killep_npcmods_respawnrate__2019_01_13';

PRINT N'EXECUTING: NPC_Pitboss_0_3__loot_npc_fields__2019_01_27';


USE [perpetuumsa]
GO

-------------------------
--Pitboss updates 0_3
--Difficulty increase; Loot-modules increase drop rates
--2019/01/27
-------------------------



DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_Hersh_PitBoss' ORDER BY definition DESC);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=8.5 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=9.0 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_recharge_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=9.0 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.5 WHERE id =  @aggvalueID;


--Loot updates to Pitboss

DECLARE @lootdefinitionID int;
DECLARE @npclootID int;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_Hersh_PitBoss' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=110000, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=75000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_pelistal' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=25000, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=20000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_thelodica' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=25000, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=20000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_nuimqol' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=25000, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=20000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=125000, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=100000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=50000, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=50000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2500, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=1000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_advanced' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2500, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=1000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_expert' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2500, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=1000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_9' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=2 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_10' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=2 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=0 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=0 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_thrm_armor_hardener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=0 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_chm_armor_hardener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=0 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_kin_armor_hardener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=0 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_exp_armor_hardener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=0 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_sensor_booster' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=0 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_sensor_jammer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=0 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_autocannon' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=6, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_damage_mod_projectile' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=3, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_armor_repairer_upgrade' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_gang_assist_speed_module' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=0 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_gang_assist_precision_firing_module' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=0 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_gang_assist_ewar_range_module_pr' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=0 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_stealth_modul' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=0 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_small_shield_generator' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=0 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_medium_shield_generator' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=0 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_reactor_sealing' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=0 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_energy_warfare_upgrade' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=0 WHERE [id]=@npclootID;

GO


PRINT N'COMPLETE NPC_Pitboss_0_3__loot_npc_fields__2019_01_27';


PRINT N'EXECUTING: NPC_Pitboss_0_4__fitting_modifiers_loot_updates__2019_03_30';

USE [perpetuumsa]
GO

-------------------------
--Pitboss updates 0_4
--Fitting update: add sealants
--Modifiers update: accum multipliers 9->15x
--2019/03/30
-------------------------

----- Change Leg modules around for reactor sealants

DECLARE @templateID int;
DECLARE @definitionID int;
DECLARE @lootdefinitionID int;
DECLARE @npclootID int;

PRINT N'Update fitting for Pitboss';
SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'Hersh_PitBoss' ORDER BY id DESC);

UPDATE robottemplates SET name='Hersh_PitBoss', description='#robot=i1594#head=i1595#chassis=i1596#leg=i1597#container=i14c#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i32|slot=i2]|m2=[|definition=i33|slot=i3]|m3=[|definition=i34|slot=i4]]#chassisModules=[|m0=[|definition=i3d|slot=i1|ammoDefinition=i986|ammoQuantity=i32]|m1=[|definition=i3d|slot=i2|ammoDefinition=i986|ammoQuantity=i32]|m2=[|definition=i3d|slot=i3|ammoDefinition=i986|ammoQuantity=i32]|m3=[|definition=i3d|slot=i4|ammoDefinition=i988|ammoQuantity=i32]|m4=[|definition=i3d|slot=i5|ammoDefinition=i988|ammoQuantity=i32]|m5=[|definition=i3d|slot=i6|ammoDefinition=i988|ammoQuantity=i32]]#legModules=[|m0=[|definition=i10|slot=i1]|m1=[|definition=i13|slot=i2]|m2=[|definition=i13|slot=i3]|m3=[|definition=i3b7|slot=i4]|m4=[|definition=i11e0|slot=i5]|m5=[|definition=i11e0|slot=i6]]', note='Pit Boss for Hershfield' WHERE id=@templateID;


PRINT N'Update aggregate values for Pitboss';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_Hersh_PitBoss' ORDER BY definition DESC);

DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=15 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_recharge_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=0.9 WHERE id =  @aggvalueID;


------Loot update


PRINT N'Updating Loots for Pitboss (setting minQuantity 0->1 for some items)';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_Hersh_PitBoss' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=110000, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=75000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_pelistal' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=25000, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=20000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_thelodica' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=25000, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=20000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_nuimqol' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=25000, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=20000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=125000, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=100000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=50000, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=50000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2500, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=1000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_advanced' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2500, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=1000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_expert' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2500, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=1000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_9' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=2 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_10' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=2 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_thrm_armor_hardener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_chm_armor_hardener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_kin_armor_hardener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_exp_armor_hardener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_sensor_booster' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_sensor_jammer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_autocannon' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=6, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_damage_mod_projectile' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=3, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_armor_repairer_upgrade' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_gang_assist_speed_module' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_gang_assist_precision_firing_module' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_gang_assist_ewar_range_module_pr' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_stealth_modul' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_small_shield_generator' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_medium_shield_generator' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_reactor_sealing' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_energy_warfare_upgrade' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=110000, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=75000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_pelistal' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=25000, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=20000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_thelodica' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=25000, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=20000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_nuimqol' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=25000, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=20000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=125000, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=100000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=50000, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=25000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2500, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=1000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_advanced' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2500, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=1000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_expert' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2500, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=1000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_9' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=2 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_10' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=2 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.125, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.125, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_thrm_armor_hardener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.125, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_chm_armor_hardener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.125, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_kin_armor_hardener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.125, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_exp_armor_hardener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.125, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_sensor_booster' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.125, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_sensor_jammer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.125, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_autocannon' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=6, [probability]=0.125, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_damage_mod_projectile' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=3, [probability]=0.125, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_armor_repairer_upgrade' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2, [probability]=0.125, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_gang_assist_speed_module' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.125, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_gang_assist_precision_firing_module' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.125, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_gang_assist_ewar_range_module_pr' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.125, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_stealth_modul' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.125, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_small_shield_generator' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.125, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_medium_shield_generator' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.125, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_reactor_sealing' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.125, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_energy_warfare_upgrade' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.125, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

GO

PRINT N'COMPLETE NPC_Pitboss_0_4__fitting_modifiers_loot_updates__2019_03_30';


PRINT N'Inserting EP boost T0 item into pitboss loots';

USE [perpetuumsa]
GO

DECLARE @definitionID int;
DECLARE @lootdefinitionID int;
DECLARE @npclootID int;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_Hersh_PitBoss' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_boost_ep_t0' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 1.0, 1, 1, 1);

GO


USE [perpetuumsa]
GO

DECLARE @definitionID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_Hersh_PitBoss' ORDER BY definition DESC);

UPDATE npcflock 
SET npcflock.npcSpecialType=(SELECT TOP 1 value FROM dbo.npcSpecialTypes WHERE name='boss')
WHERE definition=@definitionID;

GO

PRINT N'====PITBOSS PATCH COMPLETE======';




PRINT N'Characters_welcomechar-bugfix__2019_04_25';
---------------------------------------------------------------------------------------------------------------------
USE [perpetuumsa]
GO

-------------------------------------------------
--Set the Welcome Character to have an avatar and cool corp and alliance
--Fixes bug where account was not properly assigned!
--Date: 2019/04/25
------------------------------------------------

UPDATE dbo.characters
SET accountID=(SELECT TOP 1 dbo.accounts.accountID FROM dbo.accounts WHERE email='OPP_server_account' AND note='SERVER DEFINED ACCOUNT for server-characters, do not login, do not unban'),
allianceeid=(SELECT TOP 1 id FROM dbo.alliances WHERE name='syndicate_police_alliance'),
corporationeid=(SELECT TOP 1 eid FROM dbo.corporations WHERE name='syndicate_police_central'),
avatar='#background=i1#morph00=tFA7E6A3E#morph01=t0000803F#morph02=t96438BBC#morph03=t000000BF#morph04=t931884BE#morph05=tB29DEF3E#morph06=t96438BBC#morph07=t1D5A043F#morph08=t6DE7FB3E#morph09=tFCA9B13E#morph10=t6F12233F#morph11=tF2D24D3E#morph12=t931884BE#morph13=t0000803F#morph14=t0000803F#morph15=t000000BF#morph16=tE5D0E23E#morph17=t0000803F#morph18=t46B6F3BE#morph19=t91ED1C3F#morph20=t2FDDA43E#morph21=t2B87D63E#morph22=t6F12033C#morph23=tA245363E#morph24=t9318043E#morph25=t000000BF#morph26=t6F12033D#morph27=t8716993E#morph28=t0000803E#morph29=t508D373F#morph30=t6F1283BD#morph31=t0000803F#camerax=t000080BE#cameray=t0000003F#light1posx=tAAF152BE#light1posy=tA8C64B3E#light1posz=tBE9F1ABE#light1color=Lffffffff#light2posx=t4260E53B#light2posy=t7F6ABCBC#light2posz=tE17A94BE#light2color=Lff245913#eyex=tCFF7D33E#eyey=t1904D63E#eyecolor=Lff67442e#body=i0#bodycolor=Lffffffff#hair=i8#haircolor=Lff888888#beard=i8#eyebrow=i4#beardcolor=Lff000607#tattoo=i3#tattoocolor=Lffffffff#facecolor=Lff454a73'
WHERE nick='[OPP] Sparky - The Syndicate Welcome Agent'
AND lastdocked is NULL
AND lastteleported is NULL
AND zoneID is NULL;

GO
----------------------------------------------------------------------------------------------------------

PRINT N'Blinder_moduleAndNPCs__2019_05_22';
----------------------------------------------------------------------------------------------------------
USE [perpetuumsa]
GO
--PART 1 INSERT BLINDER
--------------------------------------------
--New Module: The Blinder
--Not purchasable, targetpainter category item
--INSERT entitydefaults, aggregatevalues
--Date: 2019/03/30
--------------------------------------------

--Insert the Blinder definition - a targetpainter category item, not purchasable
PRINT N'entitydefaults INSERT The Blinder';
INSERT INTO entitydefaults ( definitionname ,  quantity ,  attributeflags ,  categoryflags ,  options ,  note ,  enabled ,  volume ,  mass ,  hidden , 
                health ,  descriptiontoken ,  purchasable ,  tiertype ,  tierlevel ) 
                VALUES ( 'def_standard_blinder', 1, 720, 721935, '#moduleFlag=i8#tier=$tierlevel_t1', 'THE BLINDER', 1, 0.5, 500, 0, 100, 'def_standard_target_painter_desc', 0, 1, 1); 
GO


--Set the module stats, of note: range, and detection strength modifier
PRINT N'aggregatevalues INSERT Blinder stats';
DECLARE @definitionID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_blinder' ORDER BY definition DESC);


DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 25);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 55);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cycle_time' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 10000);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'optimal_range' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 25);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 20);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'effect_detection_strength_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, -120);

GO



-----PART 2 ADD NPCS THAT USE BLINDER


USE [perpetuumsa]
GO

SET NOEXEC OFF;

IF EXISTS (SELECT TOP 1 definition from dbo.entitydefaults WHERE definitionname='def_standard_blinder')
BEGIN
	SET NOEXEC OFF;
	PRINT N'Blinder module found!  Will now add npcs that require the blinder';
END
ELSE
BEGIN
	PRINT N'BLINDER NOT FOUND! WILL NOT EXECUTE NPC CHANGES BELOW!';
	PRINT N'PLEASE VERIFY THAT THE BLINDER MODULE WAS ADDED BEFORE RUNNING THIS SCRIPT!';
	SET NOEXEC ON;
END

DECLARE @blinderModule int;
DECLARE @blinderModHex VARCHAR(50);

SET @blinderModule = (SELECT TOP 1 definition from dbo.entitydefaults WHERE definitionname='def_standard_blinder');
PRINT @blinderModule;

SET @blinderModHex = (SELECT dbo.ToHex(@blinderModule));

DECLARE @templateID int
DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
DECLARE @lootdefinitionID int;
DECLARE @npclootID int;
DECLARE @presenceID int
DECLARE @flockID int;

--New NPC Goblin Lancer - Mirrored off Goblin Shark Attributes No guns
PRINT N'Updates to goblin shark template';
SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'goblin_shark' ORDER BY id DESC)

UPDATE robottemplates SET
name='goblin_shark',
description='#robot=ic4#head=i4f#chassis=i50#leg=i51#container=i148#headModules=[|m0=[|definition=i'+@blinderModHex+'|slot=i3]]#chassisModules=[|m0=[|definition=i26|slot=i1]|m1=[|definition=i26|slot=i2]]#legModules=[|m0=[|definition=i12a|slot=i1]|m1=[|definition=i0|slot=i2]|m2=[|definition=i0|slot=i3]]',
note='The Beta Gate Keeper'
WHERE id=@templateID;

--Set Speed of shark to 75% of its max
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_goblin_shark' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max_modifier' ORDER BY [name] DESC);

INSERT INTO [dbo].[aggregatevalues]
           ([definition],[field],[value])
     VALUES
           (@definitionID, @aggfieldID, 0.75);

--Set masking of shark to 75rf
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_goblin_shark' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'stealth_strength_modifier' ORDER BY [name] DESC);

INSERT INTO [dbo].[aggregatevalues]
           ([definition],[field],[value])
     VALUES
           (@definitionID, @aggfieldID, -25);


PRINT N'Insert new npc';
INSERT INTO entitydefaults ( definitionname ,  quantity ,  attributeflags ,  categoryflags ,  options ,  note ,  enabled ,  volume ,  mass ,  hidden , 
                health ,  descriptiontoken ,  purchasable ,  tiertype ,  tierlevel ) 
                VALUES ( 'def_npc_goblin_lancer', 1, 1024, 1423, '', '', 1, 0, 0, 0, 100, 'def_npc_castel_dps_rank1_desc', 0, 0, 0); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_goblin_lancer' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_npc_goblin_lancer', quantity=1, attributeflags=1024, categoryflags=1423, options='', 
                note='', enabled=1, volume=0, mass=0, hidden=0, health=100, descriptiontoken='def_npc_castel_dps_rank1_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'Insert new npc stats';
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.01);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 3);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_recharge_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.9);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'falloff_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.5);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locking_range_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locking_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 5);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'missile_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'optimal_range_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.5);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'turret_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'received_repaired_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.1);

--Set the ECM strength to 75%
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'ecm_strength_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.75);

--Set Speed of lancer to 50% of its max
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max_modifier' ORDER BY [name] DESC);

INSERT INTO [dbo].[aggregatevalues]
           ([definition],[field],[value])
     VALUES
           (@definitionID, @aggfieldID, 0.5);


--Set masking of lancer to 75rf
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'stealth_strength_modifier' ORDER BY [name] DESC);

INSERT INTO [dbo].[aggregatevalues]
           ([definition],[field],[value])
     VALUES
           (@definitionID, @aggfieldID, -45);


PRINT N'Insert new npc template';
INSERT INTO robottemplates ([name], [description], [note]) VALUES ('Goblin_Lancer', '#robot=i1584#head=i1585#chassis=i1586#leg=i1587#container=i146#headModules=[|m0=[|definition=i'+@blinderModHex+'|slot=i1]|m1=[|definition=i32|slot=i2]|m2=[|definition=i0|slot=i3]|m3=[|definition=i0|slot=i4]]#chassisModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]|m2=[|definition=i0|slot=i3]]#legModules=[|m0=[|definition=i286|slot=i1]|m1=[|definition=i0|slot=i2]|m2=[|definition=i0|slot=i3]]', 'AFK Roaming NPC')

PRINT N'Insert new npc template relation';
SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'Goblin_Lancer' ORDER BY id DESC)

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_goblin_lancer' ORDER BY definition DESC);

INSERT INTO [dbo].[robottemplaterelation] ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
                VALUES (@definitionID,@templateID,0,0,NULL,NULL,0,'Roaming AFK Miner Finder');

PRINT N'Insert new npc loots';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_goblin_lancer' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 200, 1, 0, 1, 100);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 100, 1, 0, 1, 50);


--Updated Goblin Shark with Blinder Module, no guns.
PRINT N'Update goblin shark modules';
SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'goblin_shark' ORDER BY id DESC);

UPDATE robottemplates SET name='goblin_shark', description='#robot=ic4#head=i4f#chassis=i50#leg=i51#container=i148#headModules=[|m0=[|definition=i'+@blinderModHex+'|slot=i3]]#chassisModules=[|m0=[|definition=i26|slot=i1]|m1=[|definition=i26|slot=i2]]#legModules=[|m0=[|definition=i12a|slot=i1]|m1=[|definition=i0|slot=i2]|m2=[|definition=i0|slot=i3]]', note='The Beta Gate Keeper' WHERE id=@templateID;

--Updated Free Roaming Spawns NV/Hersh
PRINT N'update presences and flocks with new npcs';

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_goblin_lancer' ORDER BY definition DESC);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'freeroaming_NPC_Hersh_ECM_1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'freeroaming_NPC_Hersh_ECM_1',[topx] = 7,[topy] = 7,[bottomx] = 2040,[bottomy] = 2040,[note] = 'Hersh  - 2 laird ECM free roamer',[spawnid] = 13,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 600,[presencetype] = 5,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'free_roaming_laird_hersh_1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'free_roaming_laird_hersh_1' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 0, [spawnoriginY] = 0 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 1200, [totalspawncount] = 0, [homerange] = 35 ,[note] = 'Goblin_Lancer', [respawnmultiplierlow] = 0, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'freeroaming_NPC_Hersh_ECM_2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'freeroaming_NPC_Hersh_ECM_2',[topx] = 7,[topy] = 7,[bottomx] = 2040,[bottomy] = 2040,[note] = 'Goblin_lancer afk miner 2',[spawnid] = 13,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 600,[presencetype] = 5,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'free_roaming_argano_Hersh_1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'free_roaming_argano_Hersh_1' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 0, [spawnoriginY] = 0 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 1200, [totalspawncount] = 0, [homerange] = 35 ,[note] = 'Goblin Lancer afk miner', [respawnmultiplierlow] = 0, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'freeroaming_NPC_Hersh_ECM_3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'freeroaming_NPC_Hersh_ECM_3',[topx] = 7,[topy] = 7,[bottomx] = 2040,[bottomy] = 2040,[note] = 'Goblin_Lancer 3',[spawnid] = 13,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 600,[presencetype] = 5,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'free_roaming_laird_hersh_2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'free_roaming_laird_hersh_2' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 0, [spawnoriginY] = 0 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 1200, [totalspawncount] = 0, [homerange] = 35 ,[note] = 'goblin Lancer 3', [respawnmultiplierlow] = 0, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'freeroaming_NPC_Hersh_ECM_4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'freeroaming_NPC_Hersh_ECM_4',[topx] = 7,[topy] = 7,[bottomx] = 2040,[bottomy] = 2040,[note] = 'goblin Lancer 4',[spawnid] = 13,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 600,[presencetype] = 5,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'free_roaming_argano_hersh_2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'free_roaming_argano_hersh_2' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 0, [spawnoriginY] = 0 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 1200, [totalspawncount] = 0, [homerange] = 35 ,[note] = 'goblin lancer 4', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'freeroaming_NPC_New_Virginia' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'freeroaming_NPC_New_Virginia',[topx] = 7,[topy] = 7,[bottomx] = 2040,[bottomy] = 2040,[note] = 'New Virginia - 1 Laird ECM free-roamer',[spawnid] = 1,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 600,[presencetype] = 5,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'free_roaming_laird_NV' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'free_roaming_laird_NV' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 0, [spawnoriginY] = 0 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 1200, [totalspawncount] = 0, [homerange] = 35 ,[note] = 'NV Roaming Spawn 1', [respawnmultiplierlow] = 0, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'freeroaming_NPC_New_Virginia_2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'freeroaming_NPC_New_Virginia_2',[topx] = 7,[topy] = 7,[bottomx] = 2040,[bottomy] = 2040,[note] = 'New Virginia - 1 argano ECM free-roamer',[spawnid] = 1,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 600,[presencetype] = 5,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'argano_free_roaming_NV2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'argano_free_roaming_NV2' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 0, [spawnoriginY] = 0 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 1200, [totalspawncount] = 0, [homerange] = 35 ,[note] = 'free_roaming_argano2', [respawnmultiplierlow] = 0, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'freeroaming_NPC_New_Virginia_3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'freeroaming_NPC_New_Virginia_3',[topx] = 7,[topy] = 7,[bottomx] = 2040,[bottomy] = 2040,[note] = 'New Virginia  - 1 argano ECM free roamer',[spawnid] = 1,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 600,[presencetype] = 5,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Free_roaming_argano_NV3' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Free_roaming_argano_NV3' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 0, [spawnoriginY] = 0 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 1200, [totalspawncount] = 0, [homerange] = 35 ,[note] = 'Free_roaming_argano_NV3', [respawnmultiplierlow] = 0, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'freeroaming_NPC_New_Virginia_4' ORDER BY id DESC);
UPDATE [dbo].[npcpresence]
                SET [name] = 'freeroaming_NPC_New_Virginia_4',[topx] = 7,[topy] = 7,[bottomx] = 2040,[bottomy] = 2040,[note] = 'New Virginia  - 1 laird ECM free roamer',[spawnid] = 1,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 600,[presencetype] = 5,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'NV_free_roamer_laird' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'NV_free_roamer_laird' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 0, [spawnoriginY] = 0 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 1200, [totalspawncount] = 0, [homerange] = 35 ,[note] = 'NV laird free roamer', [respawnmultiplierlow] = 0, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;



PRINT N'Complete with blinder npc adds';
GO

SET NOEXEC OFF;
GO
----------------------------------------------------------------------------------------------------------------------


PRINT N'20190508T014400Z_welcome_chat_message';
----------------------------------------------------------------------------------------------------------------------
USE [perpetuumsa]
GO

------------------------------------------------
-- Welcome Chat message features and character
-- CREATE: premadechatmessage table
-- INSERT: account and character
-- A table of predefined chat messages is created with a name
-- by which to lookup chat messages on the server when being sent
-- A character are also created to allow the chat 
-- message to be sent from this character.
--
-- Date: 2019/05/08
-- Revision 2019/05/19
------------------------------------------------


DROP TABLE IF EXISTS dbo.premadechatmessage;
GO


/* Setup premadechatmessage */
CREATE TABLE dbo.premadechatmessage (
	id int primary key,
	name varchar(32) not null unique,
	message nvarchar(2000) not null
);
GO



INSERT INTO dbo.premadechatmessage (id, name, message)
VALUES (1, 'NewPlayerEnteredTheGame', '$NAME$ has entered the game.');

INSERT INTO dbo.premadechatmessage (id, name, message)
VALUES (2, 'NewPlayerFinishedTheTutorial', '$NAME$ has completed the tutorial, say Hello!');
GO

--This character will be used to send informative welcome messages to new players
INSERT INTO [dbo].[characters]
           ([accountID]
           ,[rootEID]
           ,[nick]
           ,[moodMessage]
           ,[creation]
           ,[lastLogOut]
           ,[lastUsed]
           ,[credit]
           ,[inUse]
           ,[totalMinsOnline]
           ,[activeChassis]
           ,[active]
           ,[deletedAt]
           ,[baseEID]
           ,[defaultcorporationEID]
           ,[majorID]
           ,[raceID]
           ,[schoolID]
           ,[sparkID]
           ,[lastdocked]
           ,[docked]
           ,[lastteleported]
           ,[zoneID]
           ,[nickcorrected]
           ,[offensivenick]
           ,[positionX]
           ,[positionY]
           ,[homeBaseEID]
           ,[blockTrades]
           ,[globalMute]
           ,[avatar]
           ,[note]
           ,[corporationeid]
           ,[allianceeid]
           ,[language])
VALUES
			((SELECT accountID FROM dbo.accounts where email = 'OPP_server_account'), --accountID
			8702057415139945528, 
			N'[OPP] Announcer', --nick
			NULL, 
			CAST(N'2019-03-17T01:02:00' AS SmallDateTime), 
			CAST(N'2019-03-17T01:05:00' AS SmallDateTime), 
			CAST(N'2019-03-17T01:02:00' AS SmallDateTime), 
			10, --credit
			0, 
			3,
			8669878442849126445, 
			1,
			NULL, 
			142,
			499, 
			5, 
			1, 
			2, 
			5,
			NULL,
			1,
			NULL,
			NULL,
			0,
			0,
			NULL,
			NULL,
			561,
			0,
			0, 
			N'#background=i0#morph00=t0000803F#morph01=t00000000#morph02=t00000000#morph03=t6ABCF43E#morph04=t00000000#morph05=t250681BD#morph06=tDF4F0DBE#morph07=tFED4183F#morph08=t6666A63E#morph09=t8716993E#morph10=tE17A14BE#morph11=tFCA9713E#morph12=t00000000#morph13=tF0A746BE#morph14=t508D97BD#morph15=t0681153E#morph16=t00000000#morph17=t00000000#morph18=tC74BB7BE#morph19=t00000000#morph20=tF4FDD4BD#morph21=t21B0323F#morph22=t0681153E#morph23=t819583BE#morph24=tC74B373E#morph25=tCDCCCC3E#morph26=tD7A3F03E#morph27=t00000000#morph28=t00000000#morph29=t00000000#morph30=t00000000#morph31=t00000000#camerax=tD9CEF73D#cameray=tB6F3BD3E#light1posx=tCDCC4CBE#light1posy=t23DBB93E#light1posz=t2B8716BF#light1color=Lffffffff#light2posx=tEC51583F#light2posy=t5839343D#light2posz=tAC1C3ABF#light2color=Lff393939#eyex=tCDCC0C3F#eyey=t6F12033F#eyecolor=Lff67442e#body=i0#bodycolor=Lff572100#hair=i3#haircolor=Lff66809b#beard=i8#eyebrow=ia#beardcolor=Lff66809b#tattoo=i6#tattoocolor=Lff000000#facecolor=Lffb7befa', 
			'OPP Welcome Character - For sending chat messages to announce new players', 
			(SELECT TOP 1 eid FROM dbo.corporations WHERE name='syndicate_police_central'),
			(SELECT TOP 1 id FROM dbo.alliances WHERE name='syndicate_police_alliance'),
			0);

GO
------------------------------------------------------------------------------------------------------------------


PRINT N'NpcLoots_alpha1_omega_bosses__2019_05_02';
------------------------------------------------------------------------------------------------------------------
USE [perpetuumsa]
GO

-------------------------------------
--Add common kernels to Alpha 1 bosses
--Add common kernels to Omega bosses
--Date: 2019/05/02
-------------------------------------
PRINT N'Add common kernels to Alpha 1 bosses';

---Tribal Add 1500 Commons

DECLARE @definitionID int;
DECLARE @lootdefinitionID int;
DECLARE @npclootID int;

PRINT N'def_npc_Imperial_Infantry';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_Imperial_Infantry' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_damage_mod_missile' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_tracking_upgrade' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_sensor_booster' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_rocket_launcher' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_resistant_plating' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_pelistal_expert' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=30, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_pelistal_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1650, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=1350 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=960, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=640 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_pelistal' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=3840, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=2560 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_rocket_launcher_pr' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.1, [repackaged]=1, [dontdamage]=1, [minquantity]=0 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_kin_armor_hardener_pr' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.1, [repackaged]=1, [dontdamage]=1, [minquantity]=0 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1500, 1, 0,1, 500);

----Imperial Add 1500

PRINT N'def_npc_Tribal_Member';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_Tribal_Member' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_railgun' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_damage_mod_railgun' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_sensor_jammer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_mass_reductor' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_resistant_plating' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_nuimqol_expert' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=30, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_nuimqol_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1650, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=1350 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=960, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=640 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_nuimqol' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=3840, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=2560 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_railgun_pr' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.1, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_thrm_armor_hardener_pr' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.1, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1500, 1, 0,1, 750);

----Sacrist Add 1500

PRINT N'def_npc_Sacrist_Convert';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_Sacrist_Convert' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_damage_mod_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_sensor_jammer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_mass_reductor' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_resistant_plating' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_thelodica_expert' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=30, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_thelodica_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1650, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=1350 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=960, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=640 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_thelodica' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=3840, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=2560 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_exp_armor_hardener_pr' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.1, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_laser_pr' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.1, [repackaged]=1, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1500, 1, 0,1, 750);

---Omega Kain 10,000 Commons

PRINT N'Add common kernels to Omega 1 bosses';
PRINT N'def_npc_kain_guard';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_guard' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_thrm_armor_hardener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_railgun' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=4, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_damage_mod_railgun' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=4, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_resistant_plating' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_medium_railgun_d' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=10000, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=5000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=250, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=200 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_advanced' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=200, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=150 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_expert' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=150, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=100 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_nuimqol_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=250, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=200 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_nuimqol_advanced' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=200, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=150 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_nuimqol_expert' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=150, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=100 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_5' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=6, [probability]=0.2, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_6' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5, [probability]=0.18, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_7' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=4, [probability]=0.16, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_8' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=3, [probability]=0.14, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_9' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2, [probability]=0.12, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_10' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.1, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_nuimqol_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=25000, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=20000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5000, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=4000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_nuimqol' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5000, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=4000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 10000, 1, 0,1, 2500);

---Omega Artemis 10K Commons
PRINT N'def_npc_artemis_guard';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_guard' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_medium_lasercrystal_d' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=10000, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=8000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5000, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=4000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_thelodica' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5000, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=4000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_damage_mod_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=4, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_exp_armor_hardener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=4, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_10' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.1, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_5' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=6, [probability]=0.2, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_6' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5, [probability]=0.18, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_7' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=4, [probability]=0.16, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_8' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=3, [probability]=0.14, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_9' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2, [probability]=0.12, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_advanced' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=200, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=150 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=250, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=200 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_expert' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=150, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=100 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_thelodica_advanced' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=200, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=150 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_thelodica_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=250, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=200 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_thelodica_expert' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=150, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=100 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_thelodica_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=25000, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=20000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 10000, 1, 0,1, 2500);

----Omega Tyro 10K Commons
PRINT N'def_npc_tyrannos_guard';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_guard' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_missile_d' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=10000, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=8000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5000, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=4000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_pelistal' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5000, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=4000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_damage_mod_missile' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=4, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_kin_armor_hardener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_missile_launcher' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=4, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_pelistal_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=25000, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=20000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_10' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.1, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_5' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=6, [probability]=0.2, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_6' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5, [probability]=0.18, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_7' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=4, [probability]=0.16, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_8' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=3, [probability]=0.14, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_9' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2, [probability]=0.12, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_advanced' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=200, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=150 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=250, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=200 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_expert' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=150, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=100 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_pelistal_advanced' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=200, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=150 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_pelistal_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=250, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=200 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_pelistal_expert' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=150, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=100 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 10000, 1, 0,1, 2500);

GO

----------------------------------------------------------------------------------------------------------------




PRINT N'NPCs_Beta1__2019_05_02';
----------------------------------------------------------------------------------------------------------------
USE [perpetuumsa]
GO

-------------------------------------------------
--Beta 1 NPC overhaul
--Sets all old npcpresences to disabled
--Inserts a bunch of new ones
--
--date: 2019/05/02
------------------------------------------------

set noexec off;
PRINT N'Disable existing old-presences';
IF 1=(SELECT TOP 1 enabled FROM npcpresence WHERE name='ics_real_presence')
BEGIN
	UPDATE npcpresence
	SET [enabled] = 0 
	WHERE npcpresence.spawnid  = (SELECT TOP 1 id from npcspawn WHERE id = (SELECT TOP 1 spawnid FROM zones WHERE note='domhalarn' AND name='zone_ICS_A_real'));
END

IF 1=(SELECT TOP 1 enabled FROM npcpresence WHERE name='asi_real_presence')
BEGIN
	UPDATE npcpresence
	SET [enabled] = 0 
	WHERE npcpresence.spawnid  = (SELECT TOP 1 id from npcspawn WHERE id = (SELECT TOP 1 spawnid FROM zones WHERE note='hokkogaros' AND name='zone_ASI_A_real'));
END

IF 1=(SELECT TOP 1 enabled FROM npcpresence WHERE name='tm_real_presence')
BEGIN
	UPDATE npcpresence
	SET [enabled] = 0 
	WHERE npcpresence.spawnid  = (SELECT TOP 1 id from npcspawn WHERE id = (SELECT TOP 1 spawnid FROM zones WHERE note='norhoop' AND name='zone_TM_A_real'));
END


PRINT N'Inserting New Presences';

set noexec off;

IF EXISTS (SELECT TOP 1 id from [npcpresence] WHERE [name] = 'presence_flock_hok_nauwy_1')
BEGIN
	PRINT N'PRESENCE FOUND! Skipping inserts';
	set noexec on;
END

DECLARE @presenceID int;
DECLARE @flockID int;
DECLARE @definitionID int;

----Nauwy outpost NPCs


INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_nauwy_1',569,244,769,444,'',8,0,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_nauwy_1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_nauwy_1',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'Nauwy 1',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_hybrid_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Seth_nauwy_1', @presenceID, 3, @definitionID, 838, 310, 0, 5, 60, 0, 25, 'Seth_nauwy_1', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_dps_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('artemis_nauwy_1', @presenceID, 3, @definitionID, 838, 310, 0, 5, 60, 0, 25, 'artemis_nauwy_1', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_zenith_dps_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('zenith_nauwy_1', @presenceID, 3, @definitionID, 838, 310, 0, 5, 60, 0, 25, 'Zenith_nauwy_1', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('sequer_nauwy_1', @presenceID, 3, @definitionID, 838, 310, 0, 5, 60, 0, 25, 'sequer_nauwy_1', 0, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_nauwy_2',569,244,769,444,'Nauwy 1',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_nauwy_2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_nauwy_2',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'Nauwy 2',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_baphomet_dps_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('baph_nauwy_2', @presenceID, 3, @definitionID, 1205, 415, 2, 5, 60, 0, 25, 'Baph_nauwy_2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_prometheus_scout_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('prometheus_nauwy_2', @presenceID, 3, @definitionID, 1205, 415, 2, 5, 60, 0, 25, 'Prometheus_nauwy_2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_intakt_interceptor_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('intakt_nauwy_2', @presenceID, 3, @definitionID, 1205, 415, 2, 5, 60, 0, 25, 'Intakt_nauwy_2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('sequer_nauwy_2', @presenceID, 3, @definitionID, 1205, 415, 2, 5, 60, 0, 25, 'Sequer_nauwy_2', 1, 1, 1, 1); 


INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_nauwy_3',569,244,769,444,'Nauwy 3',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_nauwy_3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_nauwy_3',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'Nauwy 3',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_baphomet_scout_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Baph_nauwy_3', @presenceID, 2, @definitionID, 1160, 278, 2, 5, 60, 0, 25, 'Baph_nauwy_3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_prometheus_scout_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('prom_nauwy_3', @presenceID, 2, @definitionID, 1160, 278, 2, 5, 60, 0, 25, 'Prom_nauwy_3', 1, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_nauwy_4',569,244,769,444,'Nauwy 4',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_nauwy_4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_nauwy_4',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'Nauwy 4',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_hybrid_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('seth_nauwy_4', @presenceID, 2, @definitionID, 911, 257, 2, 5, 60, 0, 25, 'Seth_nauwy_4', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_dps_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('artemis_nauwy_4', @presenceID, 2, @definitionID, 911, 257, 2, 5, 60, 0, 25, 'Artemis_nauwy_4', 1, 1, 1, 1); 

---Abbu NPCs

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_Abbu_1',569,244,769,444,'Abbu 1',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_Abbu_1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_Abbu_1',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'Abbu 1',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_hybrid_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('seth_abbu_1', @presenceID, 3, @definitionID, 1157, 780, 2, 5, 60, 0, 25, 'seth_abbu_1', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_dps_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('artemis_abbu_1', @presenceID, 3, @definitionID, 1157, 780, 2, 5, 60, 0, 25, 'artemis_abbu_1', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_zenith_dps_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Zenith_abbu_1', @presenceID, 3, @definitionID, 1157, 780, 2, 5, 60, 0, 25, 'Zenith_abbu_1', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Sequer_abbu_1', @presenceID, 3, @definitionID, 1157, 780, 2, 5, 60, 0, 25, 'Sequer_abbu_1', 0, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_Abbu_2',569,244,769,444,'Abbu 2',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_Abbu_2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_Abbu_2',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'Abbu 2',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_baphomet_scout_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Baph_abbu_2', @presenceID, 3, @definitionID, 986, 858, 2, 5, 60, 0, 25, 'Baph_abbu_2', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_prometheus_scout_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Prometheus_abbu_2', @presenceID, 3, @definitionID, 986, 858, 2, 5, 60, 0, 25, 'Prometheus_abbu_2', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_intakt_interceptor_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('intakt_abbu_2', @presenceID, 3, @definitionID, 986, 858, 2, 5, 60, 0, 25, 'intakt_abbu_2', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('sequer_abbu_2', @presenceID, 3, @definitionID, 986, 858, 2, 5, 60, 0, 25, 'sequer_abbu_2', 0, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_Abbu_3',569,244,769,444,'Abbu 3',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_Abbu_3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_Abbu_3',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'Abbu 3',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_hybrid_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('seth_abbu_3', @presenceID, 2, @definitionID, 1107, 1065, 2, 5, 60, 0, 25, 'seth_abbu_3', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_dps_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('artemis_abbu_3', @presenceID, 2, @definitionID, 1107, 1065, 2, 5, 60, 0, 25, 'artemis_abbu_3', 0, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_Abbu_4',569,244,769,444,'Abbu 4',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_Abbu_4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_Abbu_4',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'Abbu 4',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_prometheus_scout_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Promethus_Abbu_4', @presenceID, 2, @definitionID, 1415, 818, 2, 5, 60, 0, 25, 'Promethus_abbu_4', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_baphomet_scout_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Baphomet_Abbu_4', @presenceID, 2, @definitionID, 1415, 818, 2, 5, 60, 0, 25, 'Baphomet_abbu_4', 0, 1, 1, 1); 

----Darm NPCs

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_Darm_1',569,244,769,444,'Darm_1',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_Darm_1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_Darm_1',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'Darm_1',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_hybrid_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('seth_darm_1', @presenceID, 3, @definitionID, 464, 1072, 2, 5, 60, 0, 25, 'seth_darm_1', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_dps_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('artemis_darm_1', @presenceID, 3, @definitionID, 464, 1072, 2, 5, 60, 0, 25, 'artemis_darm_1', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_zenith_dps_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Zenith_darm_1', @presenceID, 3, @definitionID, 464, 1072, 2, 5, 60, 0, 25, 'zenith_darm_1', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('sequer_darm_1', @presenceID, 3, @definitionID, 464, 1072, 2, 5, 60, 0, 25, 'sequer_darm_1', 0, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_Darm_2',569,244,769,444,'Darm_2',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_Darm_2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_Darm_2',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'Darm_2',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_baphomet_scout_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('baph_Darm_2', @presenceID, 3, @definitionID, 635, 1076, 2, 5, 60, 0, 25, 'baph_Darm_2', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_prometheus_scout_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('prom_Darm_2', @presenceID, 3, @definitionID, 635, 1076, 2, 5, 60, 0, 25, 'Prom_darm_2', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_intakt_interceptor_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('intakt_Darm_2', @presenceID, 3, @definitionID, 635, 1076, 2, 5, 60, 0, 25, 'intakt_darm_2', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Sequer_Darm_2', @presenceID, 3, @definitionID, 635, 1076, 2, 5, 60, 0, 25, 'sequer_darm_2', 0, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_Darm_3',569,244,769,444,'Darm_3',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_Darm_3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_Darm_3',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'Darm_3',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_hybrid_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('seth_Darm_3', @presenceID, 2, @definitionID, 693, 1385, 2, 5, 60, 0, 25, 'seth_darm_3', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_dps_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('artemis_darm_3', @presenceID, 2, @definitionID, 693, 1385, 2, 5, 60, 0, 25, 'artemis_darm_3', 0, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_Darm_4',569,244,769,444,'Darm_4',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_Darm_4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_Darm_4',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'Darm_4',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_baphomet_scout_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Baph_Darm_4', @presenceID, 2, @definitionID, 499, 1346, 2, 5, 60, 0, 25, 'Baph_Darm_4', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_prometheus_scout_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('prom_Darm_4', @presenceID, 2, @definitionID, 499, 1346, 2, 5, 60, 0, 25, 'Prom_Darm_4', 0, 1, 1, 1); 

----Beta Terminal

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_BetaTerminal_1',569,244,769,444,'BetaTerminal_1',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_BetaTerminal_1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_BetaTerminal_1',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'BetaTerminal_1',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_hybrid_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Mesmer_BT_1', @presenceID, 2, @definitionID, 630, 400, 2, 5, 60, 0, 25, 'Mesmer_BT_1', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_dps_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kain_BT_1', @presenceID, 2, @definitionID, 630, 400, 2, 5, 60, 0, 25, 'Kain_BT_1', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vagabond_dps_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Vagabond_BT_1', @presenceID, 2, @definitionID, 630, 400, 2, 5, 60, 0, 25, 'Vagabond_BT_1', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Sequer_BT_1', @presenceID, 2, @definitionID, 630, 400, 2, 5, 60, 0, 25, 'Sequer_BT_1', 0, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_BetaTerminal_2_Blue',569,244,769,444,'BetaTerminal_2',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_BetaTerminal_2_Blue' ORDER BY id DESC)

UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_BetaTerminal_2_Blue',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'BetaTerminal_2_Blue',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_scout_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('arbalest_BT2Blue', @presenceID, 2, @definitionID, 725, 610, 2, 5, 60, 0, 25, 'arbalest_BT2Blue', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_interceptor_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('yagel_BT2Blue', @presenceID, 2, @definitionID, 725, 610, 2, 5, 60, 0, 25, 'yagel_BT2Blue', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_cameleon_interceptor_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Cameleon_BT2Blue', @presenceID, 2, @definitionID, 725, 610, 2, 5, 60, 0, 25, 'Cameleon_BT2Blue', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Sequer_BT2Bluex', @presenceID, 2, @definitionID, 725, 610, 2, 5, 60, 0, 25, 'Sequer_BT2Blue', 0, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_BetaTerminal_3_blue',569,244,769,444,'BetaTerminal_3_blue',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_BetaTerminal_3_blue' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_BetaTerminal_3_blue',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'BetaTerminal_3_blue',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_dps_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kain_BT3_blue', @presenceID, 2, @definitionID, 840, 450, 2, 5, 60, 0, 25, 'kain_BT3_blue', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_scout_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('yagel_BT3_blue', @presenceID, 2, @definitionID, 840, 450, 2, 5, 60, 0, 25, 'yagel_BT3_blue', 0, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_BetaTerminal_1_green',569,244,769,444,'BetaTerminal_1_green',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_BetaTerminal_1_green' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_BetaTerminal_1_green',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'BetaTerminal_1_green',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_hybrid_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('gropho_BTG1', @presenceID, 2, @definitionID, 565, 460, 2, 5, 60, 0, 25, 'gropho_BTG1', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_dps_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('tyrannos_BTG1', @presenceID, 2, @definitionID, 565, 460, 2, 5, 60, 0, 25, 'Tyrannos_BTG1', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ictus_dps_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('ictus_BTG1', @presenceID, 2, @definitionID, 565, 460, 2, 5, 60, 0, 25, 'ictus_BTG1', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('sequer_BTG1', @presenceID, 2, @definitionID, 565, 460, 2, 5, 60, 0, 25, 'sequer_BTG1', 0, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_BetaTerminal_2_green',569,244,769,444,'BetaTerminal_2_green',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_BetaTerminal_2_green' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_BetaTerminal_2_green',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'BetaTerminal_2_green',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_waspish_scout_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('waspish_BT2G', @presenceID, 2, @definitionID, 630, 665, 2, 5, 60, 0, 25, 'waspish_BT2G', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_castel_interceptor_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Castel_BT2G', @presenceID, 2, @definitionID, 630, 665, 2, 5, 60, 0, 25, 'Castel_BT2G', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_troiar_interceptor_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Troiar_BT2G', @presenceID, 2, @definitionID, 630, 665, 2, 5, 60, 0, 25, 'Troiar_BT2G', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Sequer_BT2G', @presenceID, 2, @definitionID, 630, 665, 2, 5, 60, 0, 25, 'Sequer_BT2G', 0, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_BetaTerminal_3_green',569,244,769,444,'BetaTerminal_3_green',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_BetaTerminal_3_green' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_BetaTerminal_3_green',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'BetaTerminal_3_green',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_castel_scout_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('castel_BT3G', @presenceID, 2, @definitionID, 915, 575, 2, 5, 60, 0, 25, 'castel_BT3G', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_dps_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Tyrannos_BT3G', @presenceID, 2, @definitionID, 915, 575, 2, 5, 60, 0, 25, 'Tyrannos_BT3G', 0, 1, 1, 1); 

-----Hitech Group Spawn

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_Hitech',569,244,769,444,'hokk_hitech',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_Hitech' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_Hitech',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'hokk_hitech',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_hybrid_rank5' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('seth_hitech_1', @presenceID, 3, @definitionID, 210, 1675, 2, 5, 60, 0, 25, 'seth_hitech_1', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_dps_rank5' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('artemis_hitech_1', @presenceID, 3, @definitionID, 210, 1675, 2, 5, 60, 0, 25, 'artemis_hitech_1', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_zenith_dps_rank5' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('zenith_hitech_1', @presenceID, 3, @definitionID, 210, 1675, 2, 5, 60, 0, 25, 'zenith_hitech_1', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank5' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('sequer_hitech_1', @presenceID, 3, @definitionID, 210, 1675, 2, 5, 60, 0, 25, 'sequer_hitech_1', 0, 1, 1, 1); 

-----Indy T3

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_IndyT3',569,244,769,444,'hokk_IndyT3',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_IndyT3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_IndyT3',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'hokk_IndyT3',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_riveler_basic_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Riveler_hokk_indyT3', @presenceID, 3, @definitionID, 1170, 1450, 2, 5, 60, 0, 25, 'Riveler_hokk_indyT3', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_symbiont_basic_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Symb_hokk_indyT3', @presenceID, 3, @definitionID, 1170, 1450, 2, 5, 60, 0, 25, 'Symb_hokk_indyT3', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_lithus_basic_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Lithus_hokk_indyT3', @presenceID, 3, @definitionID, 1170, 1450, 2, 5, 60, 0, 25, 'Lithus_hokk_indyT3', 0, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Scarab_hokk_indyT3', @presenceID, 3, @definitionID, 1170, 1450, 2, 5, 60, 0, 25, 'Scarab_hokk_indyT3', 0, 1, 1, 1); 

----Indy T5

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_IndyT5',569,244,769,444,'hokk_IndyT5',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_IndyT5' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_IndyT5',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'hokk_IndyT5',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('scarab_hokk_T5G', @presenceID, 3, @definitionID, 1880, 1610, 2, 5, 60, 0, 25, 'scarab_hokk_T5G', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_riveler_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Riveler_hokk_T5G', @presenceID, 3, @definitionID, 1880, 1610, 2, 5, 60, 0, 25, 'Riveler_hokk_T5G', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_symbiont_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Symbiont_hokk_T5G', @presenceID, 3, @definitionID, 1880, 1610, 2, 5, 60, 0, 25, 'Symbiont_hokk_T5G', 1, 1, 1, 1); 


---T3 Solo Indy

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_SoloIndyT3',569,244,769,444,'hokk_IndyT5',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_SoloIndyT3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_SoloIndyT3',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'hokk_soloIndyT3',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('scarab_hokk_T3S', @presenceID, 1, @definitionID, 1415, 1180, 2, 5, 60, 0, 25, 'scarab_hokk_t3s', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_symbiont_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Symb_hokk_T3S', @presenceID, 1, @definitionID, 1415, 1180, 2, 5, 60, 0, 25, 'symb_hokk_t3s', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_riveler_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Riveler_hokk_T3S', @presenceID, 1, @definitionID, 1415, 1180, 2, 5, 60, 0, 25, 'riveler_hokk_t3s', 1, 1, 1, 1); 


---T5 Solo Indy

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_SoloIndyT5',569,244,769,444,'hokk_soloIndyT5',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_SoloIndyT5' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_SoloIndyT5',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'hokk_soloIndyT5',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('scarab_hokk_T5S', @presenceID, 1, @definitionID, 995, 1310, 2, 5, 60, 0, 25, 'scarab_hokk_t5s', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_riveler_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Riveler_hokk_T5S', @presenceID, 1, @definitionID, 995, 1310, 2, 5, 60, 0, 25, 'Riveler_hokk_t5s', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_symbiont_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Symb_hokk_T5S', @presenceID, 1, @definitionID, 995, 1310, 2, 5, 60, 0, 25, 'Symb_hokk_T5s', 1, 1, 1, 1); 

---Hokk Money Spawn

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_MoneySpawn',569,244,769,444,'hokk_Moneyspawn',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_MoneySpawn' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_MoneySpawn',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'hokk_Moneyspawn',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Leg_hokk_MST3', @presenceID, 2, @definitionID, 1689, 1341, 2, 5, 60, 0, 25, 'Leg_hokk_MST3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank4' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Leg_hokk_MST4', @presenceID, 2, @definitionID, 1689, 1341, 2, 5, 60, 0, 25, 'Leg_hokk_MST4', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_callisto_buccaneer_rank4' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Callisto_hokk_MST4', @presenceID, 2, @definitionID, 1689, 1341, 2, 5, 60, 0, 25, 'Callisto_hokk_MST4', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ikarus_abstrans_rank4' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('ikarus_hokk_MST4', @presenceID, 2, @definitionID, 1689, 1341, 2, 5, 60, 0, 25, 'Ikarus_hokk_MST4', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank4' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('echelon_hokk_MST4', @presenceID, 2, @definitionID, 1689, 1341, 2, 5, 60, 0, 25, 'echelon_hokk_MST4', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('echelon_hokk_MST3', @presenceID, 2, @definitionID, 1689, 1341, 2, 5, 60, 0, 25, 'echelon_hokk_MST3', 1, 1, 1, 1); 

---- Solo T5 Mech/HM

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_soloT5MHM',569,244,769,444,'hokk_soloT5MHM',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_soloT5MHM' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_soloT5MHM',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'hokk_soloT5MHM',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_hybrid_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('seth_hokk_soloT5MHM', @presenceID, 2, @definitionID, 630, 1075, 2, 5, 60, 0, 25, 'seth_hokk_soloT5MHM', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_zenith_dps_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Zenith_hokk_soloT5MHM', @presenceID, 3, @definitionID, 630, 1075, 2, 5, 60, 0, 25, 'Zenith_hokk_soloT5MHM', 1, 1, 1, 1); 

------ Solo T5 Ass/Light

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_soloT5AL',569,244,769,444,'hokk_soloT5AL',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_soloT5AL' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_soloT5AL',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'hokk_soloT5AL',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_baphomet_scout_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('baph_hokk_soloT5AL', @presenceID, 2, @definitionID, 1672, 718, 2, 5, 60, 0, 25, 'baph_hokk_solo_t5al', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_intakt_interceptor_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('intakt_hokk_soloT5AL', @presenceID, 3, @definitionID, 1672, 718, 2, 5, 60, 0, 25, 'intakt_hokk_solo_T5AL', 1, 1, 1, 1); 

----- Lithus

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hok_Lithus',569,244,769,444,'hokk_Lithus',8,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hok_Lithus' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hok_Lithus',[topx] = 569,[topy] = 244,[bottomx] = 769,[bottomy] = 444,[note] = 'hokk_Lithus',[spawnid] = 8,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_lithus_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('lithus_Hokk_T3', @presenceID, 3, @definitionID, 1155, 1675, 2, 5, 60, 0, 25, 'lithus_hokk_T3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_lithus_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('lithus_Hokk_T5', @presenceID, 3, @definitionID, 1155, 1675, 2, 5, 60, 0, 25, 'lithus_hokk_T5', 1, 1, 1, 1); 

------Norhoop

----initia_1
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_initia_1',1637,1391,1837,1591,'presence_flock_nor_initia_1',7,0,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_initia_1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_initia_1',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_initia_1',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_hybrid_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('initia_1_grophoT3', @presenceID, 3, @definitionID, 550, 750, 2, 5, 60, 0, 25, 'initia_1_grophoT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_ew_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('initia_1_tyroT3', @presenceID, 3, @definitionID, 550, 750, 2, 5, 60, 0, 25, 'initia_1_tyroT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ictus_dps_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('initia_1_ictusT3', @presenceID, 3, @definitionID, 550, 750, 2, 5, 60, 0, 25, 'initia_1_ictusT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('initia_1_sequerT3', @presenceID, 3, @definitionID, 550, 750, 2, 5, 60, 0, 25, 'initia_1_sequerT3', 1, 1, 1, 1); 

----initia_2

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_initia_2',1637,1391,1837,1591,'presence_flock_nor_initia_2',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_initia_2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_initia_2',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_initia_2',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_waspish_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('initia_2_waspT3', @presenceID, 3, @definitionID, 670, 995, 2, 5, 60, 0, 25, 'initia_2_waspT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_castel_scout_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('initia_2_castelT3', @presenceID, 3, @definitionID, 670, 995, 2, 5, 60, 0, 25, 'initia_2_castelT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_troiar_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('initia_2_troiarT3', @presenceID, 3, @definitionID, 670, 995, 2, 5, 60, 0, 25, 'initia_2_troiarT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('initia_2_sequerT3', @presenceID, 3, @definitionID, 670, 995, 2, 5, 60, 0, 25, 'initia_2_sequerT3', 1, 1, 1, 1); 

-----initia_3

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_initia_3',1637,1391,1837,1591,'presence_flock_nor_initia_3',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_initia_3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_initia_3',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_initia_3',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_waspish_scout_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('initia_3_waspT3', @presenceID, 2, @definitionID, 333, 856, 2, 5, 60, 0, 25, 'initia_3_waspT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_castel_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('initia_3_castelT3', @presenceID, 2, @definitionID, 333, 856, 2, 5, 60, 0, 25, 'initia_3_castelT3', 1, 1, 1, 1); 

----initia_4

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_initia_4',1637,1391,1837,1591,'presence_flock_nor_initia_4',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_initia_4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_initia_4',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_initia_4',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_dps_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('initia_4_tyroT3', @presenceID, 2, @definitionID, 550, 1115, 2, 5, 60, 0, 25, 'initia_4_tyroT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_hybrid_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('initia_4_grophoT3', @presenceID, 2, @definitionID, 550, 1115, 2, 5, 60, 0, 25, 'initia_4_grophoT3', 1, 1, 1, 1); 

---Kara_1

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_kara_1',1637,1391,1837,1591,'presence_flock_nor_kara_1',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_kara_1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_kara_1',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_kara_1',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_hybrid_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kara_1_grophoT3', @presenceID, 3, @definitionID, 1254, 580, 2, 5, 60, 0, 25, 'kara_1_grophoT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_ew_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kara_1_tyroT3', @presenceID, 3, @definitionID, 1254, 580, 2, 5, 60, 0, 25, 'Kara_1_tyroT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ictus_dps_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kara_1_ictusT3', @presenceID, 3, @definitionID, 1254, 580, 2, 5, 60, 0, 25, 'Kara_1_ictusT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kara_1_sequerT3', @presenceID, 3, @definitionID, 1254, 580, 2, 5, 60, 0, 25, 'Kara_1_sequerT3', 1, 1, 1, 1); 

				---Kara_2

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_kara_2',1637,1391,1837,1591,'presence_flock_nor_kara_2',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_kara_2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_kara_2',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_kara_2',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_waspish_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kara_2_waspishT3', @presenceID, 3, @definitionID, 1365, 695, 2, 5, 60, 0, 25, 'Kara_2_waspishT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_troiar_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kara_2_troiarT3', @presenceID, 3, @definitionID, 1365, 695, 2, 5, 60, 0, 25, 'Kara_2_troiarT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_castel_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kara_2_castelT3', @presenceID, 3, @definitionID, 1365, 695, 2, 5, 60, 0, 25, 'Kara_2_castelT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kara_2_sequerT3', @presenceID, 3, @definitionID, 1365, 695, 2, 5, 60, 0, 25, 'Kara_2_sequerT3', 1, 1, 1, 1); 

----Kara_3

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_kara_3',1637,1391,1837,1591,'presence_flock_nor_kara_3',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_kara_3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_kara_3',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_kara_3',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_tank_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kara_3_grophoT3', @presenceID, 2, @definitionID, 1490, 564, 2, 5, 60, 0, 25, 'kara_3_grophoT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_ew_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kara_3_tyrpT3', @presenceID, 2, @definitionID, 1490, 564, 2, 5, 60, 0, 25, 'Kara_3_tyrpT3', 1, 1, 1, 1); 

----Kara_4

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_kara_4',1637,1391,1837,1591,'presence_flock_nor_kara_4',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_kara_4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_kara_4',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_kara_4',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_waspish_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kara_4_waspT3', @presenceID, 2, @definitionID, 1155, 729, 2, 5, 60, 0, 25, 'Kara_4_waspT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_castel_scout_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kara_4_castT3', @presenceID, 2, @definitionID, 1155, 729, 2, 5, 60, 0, 25, 'Kara_4_castT3', 1, 1, 1, 1); 

---Uria_1

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_uria_1',1637,1391,1837,1591,'presence_flock_nor_uria_1',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_uria_1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_uria_1',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_uria_1',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_hybrid_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('uria_1_gropht3', @presenceID, 3, @definitionID, 1165, 1645, 2, 5, 60, 0, 25, 'uria_1_gropht3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_ew_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('uria_1_tyroT3', @presenceID, 3, @definitionID, 1165, 1645, 2, 5, 60, 0, 25, 'uria_1_tyroT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ictus_dps_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('uria_1_ictusT3', @presenceID, 3, @definitionID, 1165, 1645, 2, 5, 60, 0, 25, 'uria_1_ictusT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('uria_1_sequert3', @presenceID, 3, @definitionID, 1165, 1645, 2, 5, 60, 0, 25, 'uria_1_sequert3', 1, 1, 1, 1); 

----uria_2

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_uria_2',1637,1391,1837,1591,'presence_flock_nor_uria_2',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_uria_2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_uria_2',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_uria_2',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_waspish_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('uria_2_waspT3', @presenceID, 3, @definitionID, 1315, 1467, 2, 5, 60, 0, 25, 'uria_2_waspT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_castel_scout_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('uria_2_castelT3', @presenceID, 3, @definitionID, 1315, 1467, 2, 5, 60, 0, 25, 'uria_2_castelT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_troiar_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('uria_2_troiarT3', @presenceID, 3, @definitionID, 1315, 1467, 2, 5, 60, 0, 25, 'uria_2_troiarT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('uria_2_sequerT3', @presenceID, 3, @definitionID, 1315, 1467, 2, 5, 60, 0, 25, 'uria_2_sequerT3', 1, 1, 1, 1); 

-----uria_3

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_uria_3',1637,1391,1837,1591,'presence_flock_nor_uria_3',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_uria_3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_uria_3',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_uria_3',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_hybrid_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('uria_3_grophoT3', @presenceID, 2, @definitionID, 1000, 1665, 2, 5, 60, 0, 25, 'uria_3_grophot3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_ew_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('uria_3_tyroT3', @presenceID, 2, @definitionID, 1000, 1665, 2, 5, 60, 0, 25, 'uria_3_tyroT3', 1, 1, 1, 1); 

----uria_4

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_uria_4',1637,1391,1837,1591,'presence_flock_nor_uria_4',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_uria_4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_uria_4',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_uria_4',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_waspish_scout_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('uria_4_waspT3', @presenceID, 2, @definitionID, 1190, 1361, 2, 5, 60, 0, 25, 'uria_4_waspT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_castel_scout_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('uria_4_castelT3', @presenceID, 2, @definitionID, 1190, 1361, 2, 5, 60, 0, 25, 'uria_4_castelT3', 1, 1, 1, 1); 

---TMB_1

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_TMB_1',1637,1391,1837,1591,'presence_flock_nor_TMB_1',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_TMB_1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_TMB_1',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_TMB_1',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_hybrid_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('tmb_1_SethT2', @presenceID, 2, @definitionID, 612, 1415, 2, 5, 60, 0, 25, 'tmb_1_SethT2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_ew_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('TMB_1_artyT2', @presenceID, 2, @definitionID, 612, 1415, 2, 5, 60, 0, 25, 'TMB_1_artyT2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_zenith_dps_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('TMB_1_zenithT2', @presenceID, 2, @definitionID, 612, 1415, 2, 5, 60, 0, 25, 'TMB_1_zenithT2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('TMB_1_sequerT2', @presenceID, 2, @definitionID, 612, 1415, 2, 5, 60, 0, 25, 'TMB_1_sequerT2', 1, 1, 1, 1); 

----tmb_2

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_TMB_2',1637,1391,1837,1591,'presence_flock_nor_TMB_2',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_TMB_2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_TMB_2',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_TMB_2',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_hybrid_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('TMB_2_mesmerT2', @presenceID, 2, @definitionID, 685, 1640, 2, 5, 60, 0, 25, 'TMB_2_mesmerT2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_ew_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('TMB_2_kainT2', @presenceID, 2, @definitionID, 685, 1640, 2, 5, 60, 0, 25, 'TMB_2_kainT2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vagabond_dps_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('TMB_2_vagabondT2', @presenceID, 2, @definitionID, 685, 1640, 2, 5, 60, 0, 25, 'TMB_2_vagabondT2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('TMB_2_sequerT2', @presenceID, 2, @definitionID, 685, 1640, 2, 5, 60, 0, 25, 'TMB_2_sequerT2', 1, 1, 1, 1); 

----TMB_3

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_TMB_3',1637,1391,1837,1591,'presence_flock_nor_TMB_3',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_TMB_3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_TMB_3',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_TMB_3',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_interceptor_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('TMB_3_arbyt2', @presenceID, 2, @definitionID, 291, 1843, 2, 5, 60, 0, 25, 'TMB_3_arbyt2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_cameleon_interceptor_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('TMB_3_camt2', @presenceID, 2, @definitionID, 291, 1843, 2, 5, 60, 0, 25, 'TMB_3_camt2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_interceptor_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('TMB_3_yagelt2', @presenceID, 2, @definitionID, 291, 1843, 2, 5, 60, 0, 25, 'TMB_3_yagelt2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('TMB_3_sequert2', @presenceID, 2, @definitionID, 291, 1843, 2, 5, 60, 0, 25, 'TMB_3_sequert2', 1, 1, 1, 1); 

---TMB_4

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_TMB_4',1637,1391,1837,1591,'presence_flock_nor_TMB_4',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_TMB_4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_TMB_4',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_TMB_4',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_baphomet_scout_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('TMB_4_bapht2', @presenceID, 2, @definitionID, 231, 1526, 2, 5, 60, 0, 25, 'TMB_4_bapht2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_intakt_interceptor_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('TMB_4_intaktt2', @presenceID, 2, @definitionID, 231, 1526, 2, 5, 60, 0, 25, 'TMB_4_intaktt2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_prometheus_interceptor_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('TMB_4_promt2', @presenceID, 2, @definitionID, 231, 1526, 2, 5, 60, 0, 25, 'TMB_4_promt2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('TMB_4_sequert2', @presenceID, 2, @definitionID, 231, 1526, 2, 5, 60, 0, 25, 'TMB_4_sequert2', 1, 1, 1, 1); 

----TMB_6

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_TMB_6',1637,1391,1837,1591,'presence_flock_nor_TMB_6',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_TMB_6' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_TMB_6',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_TMB_6',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_ew_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('tmb_6_artyT3', @presenceID, 2, @definitionID, 430, 1450, 2, 5, 60, 0, 25, 'tmb_6_artyT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_prometheus_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('tmb_6_promT3', @presenceID, 2, @definitionID, 430, 1450, 2, 5, 60, 0, 25, 'tmb_6_promT3', 1, 1, 1, 1); 

----TMB_7

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_TMB_7',1637,1391,1837,1591,'presence_flock_nor_TMB_7',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_TMB_7' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_TMB_7',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_TMB_7',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_ew_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('tmb_7_kaint3', @presenceID, 2, @definitionID, 500, 1775, 2, 5, 60, 0, 25, 'tmb_7_kaint3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('tmb_7_yagelt3', @presenceID, 2, @definitionID, 500, 1775, 2, 5, 60, 0, 25, 'tmb_7_yagelt3', 1, 1, 1, 1); 

-----TMB_hitech

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_hitech',1637,1391,1837,1591,'presence_flock_nor_hitech',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_hitech' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_hitech',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_hitech',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_hybrid_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hitech_grophot5', @presenceID, 3, @definitionID, 1638, 233, 2, 5, 60, 0, 25, 'hitech_grophot5', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_ew_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hitech_tyrannost5', @presenceID, 3, @definitionID, 1638, 233, 2, 5, 60, 0, 25, 'hitech_tyrannost5', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ictus_dps_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hitech_ictust5', @presenceID, 3, @definitionID, 1638, 233, 2, 5, 60, 0, 25, 'hitech_ictust5', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hitech_sequert5', @presenceID, 3, @definitionID, 1638, 233, 2, 5, 60, 0, 25, 'hitech_sequert5', 1, 1, 1, 1); 

---Nor_T3

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_indyt3',1637,1391,1837,1591,'presence_flock_nor_indyt3',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_indyt3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_indyt3',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_indyt3',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_riveler_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_indyt3_rivelert3', @presenceID, 3, @definitionID, 850, 1180, 2, 5, 60, 0, 25, 'nor_indyt3_rivelert3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_symbiont_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_indyt3_symbt3', @presenceID, 3, @definitionID, 850, 1180, 2, 5, 60, 0, 25, 'nor_indyt3_symbt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_lithus_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_indyt3_litht3', @presenceID, 3, @definitionID, 850, 1180, 2, 5, 60, 0, 25, 'nor_indyt3_litht3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_indyt3_scarabt3', @presenceID, 3, @definitionID, 850, 1180, 2, 5, 60, 0, 25, 'nor_indyt3_scarabt3', 1, 1, 1, 1); 

				----Nor_indyt5

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_indyt5',1637,1391,1837,1591,'presence_flock_nor_indyt5',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_indyt5' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_indyt5',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_indyt5',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_riveler_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_indyt5_rivelt5', @presenceID, 3, @definitionID, 824, 1024, 2, 5, 60, 0, 25, 'nor_indyt5_rivelt5', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_symbiont_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_indyt5_symbt5', @presenceID, 3, @definitionID, 824, 1024, 2, 5, 60, 0, 25, 'nor_indyt5_symbt5', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_lithus_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_indyt5_litht5', @presenceID, 3, @definitionID, 824, 1024, 2, 5, 60, 0, 25, 'nor_indyt5_litht5', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_indyt5_scarabt5', @presenceID, 3, @definitionID, 824, 1024, 2, 5, 60, 0, 25, 'nor_indyt5_scarabt5', 1, 1, 1, 1); 

-----Nor_SoloIndyT3

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_soloindyt3',1637,1391,1837,1591,'presence_flock_nor_soloindyt3',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_soloindyt3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_soloindyt3',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_soloindyt3',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_riveler_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_soloindyt3_rivt3', @presenceID, 1, @definitionID, 921, 525, 2, 5, 60, 0, 25, 'nor_soloindyt3_rivt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_symbiont_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_soloindyt3_symt3', @presenceID, 1, @definitionID, 921, 525, 2, 5, 60, 0, 25, 'nor_soloindyt3_symt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_soloindyt3_scarabt3', @presenceID, 1, @definitionID, 921, 525, 2, 5, 60, 0, 25, 'nor_soloindyt3_scarabt3', 1, 1, 1, 1); 

----Nor_soloindyt5

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_soloindyt5',1637,1391,1837,1591,'presence_flock_nor_soloindyt5',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_soloindyt5' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_soloindyt5',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_soloindyt5',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_soloindyt5_scarabt5', @presenceID, 1, @definitionID, 1875, 1665, 2, 5, 60, 0, 25, 'nor_soloindyt5_scarabt5', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_riveler_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_soloindyt5_rivelert5', @presenceID, 1, @definitionID, 1875, 1665, 2, 5, 60, 0, 25, 'nor_soloindyt5_rivelert5', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_symbiont_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_soloindyt5_symbt5', @presenceID, 1, @definitionID, 1875, 1665, 2, 5, 60, 0, 25, 'nor_soloindyt5_symbt5', 1, 1, 1, 1); 

-------Norhoop_money_spawn

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_moneyspawn',1637,1391,1837,1591,'presence_flock_nor_moneyspawn',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_moneyspawn' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_moneyspawn',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_moneyspawn',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_callisto_buccaneer_rank4' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_moneyspawn_callistoT4', @presenceID, 3, @definitionID, 1630, 1229, 2, 5, 60, 0, 25, 'nor_moneyspawn_callistoT4', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank4' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_moneyspawn_legT4', @presenceID, 3, @definitionID, 1630, 1229, 2, 5, 60, 0, 25, 'nor_moneyspawn_legT4', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_moneyspawn_legT3', @presenceID, 3, @definitionID, 1630, 1229, 2, 5, 60, 0, 25, 'nor_moneyspawn_legT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ikarus_abstrans_rank4' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_moneyspawn_ikarusT4', @presenceID, 3, @definitionID, 1630, 1229, 2, 5, 60, 0, 25, 'nor_moneyspawn_ikarusT4', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_moneyspawn_echelonT3', @presenceID, 3, @definitionID, 1630, 1229, 2, 5, 60, 0, 25, 'nor_moneyspawn_echelonT3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank4' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_moneyspawn_echelonT4', @presenceID, 3, @definitionID, 1630, 1229, 2, 5, 60, 0, 25, 'nor_moneyspawn_echelonT4', 1, 1, 1, 1); 

----Nor_solo_hitech_hm/m

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_solohitechhmm',1637,1391,1837,1591,'presence_flock_nor_solohitechhmm',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_solohitechhmm' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_solohitechhmm',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_solohitechhmm',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_hybrid_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_solohitechhmm_grophot5', @presenceID, 2, @definitionID, 704, 1919, 2, 5, 60, 0, 25, 'nor_solohitechhmm_grophot5', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ictus_dps_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_solohitechhmm_ictust5', @presenceID, 3, @definitionID, 704, 1919, 2, 5, 60, 0, 25, 'nor_solohitechhmm_ictust5', 1, 1, 1, 1); 

----solo assl

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_assl',1637,1391,1837,1591,'presence_flock_nor_assl',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_assl' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_assl',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_assl',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_waspish_scout_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_assl_waspt5', @presenceID, 2, @definitionID, 1013, 383, 2, 5, 60, 0, 25, 'nor_assl_waspt5', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_troiar_interceptor_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_assl_troiart5', @presenceID, 3, @definitionID, 1013, 383, 2, 5, 60, 0, 25, 'nor_assl_troiart5', 1, 1, 1, 1); 

-----Norhoop_lithus

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_nor_lithus',1637,1391,1837,1591,'presence_flock_nor_lithus',7,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_nor_lithus' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_nor_lithus',[topx] = 1637,[topy] = 1391,[bottomx] = 1837,[bottomy] = 1591,[note] = 'presence_flock_nor_lithus',[spawnid] = 7,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_lithus_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_lithus_lithust3', @presenceID, 3, @definitionID, 1070, 940, 2, 5, 60, 0, 25, 'nor_lithus_lithust3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_lithus_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nor_lithus_lithusT5', @presenceID, 3, @definitionID, 1070, 940, 2, 5, 60, 0, 25, 'nor_lithus_lithusT5', 1, 1, 1, 1); 


-----Dom

---moyar_1

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_moyar_1',611,259,811,459,'presence_flock_dom_moyar_1',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_moyar_1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_moyar_1',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_moyar_1',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_hybrid_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('moyar_1_mest3', @presenceID, 3, @definitionID, 1100, 1485, 2, 5, 60, 0, 25, 'moyar_1_mest3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_ew_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('moyar_1_kaint3', @presenceID, 3, @definitionID, 1100, 1485, 2, 5, 60, 0, 25, 'moyar_1_kaint3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vagabond_dps_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('moyar_1_vagat3', @presenceID, 3, @definitionID, 1100, 1485, 2, 5, 60, 0, 25, 'moyar_1_vagat3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('moyar_1_sequert3', @presenceID, 3, @definitionID, 1100, 1485, 2, 5, 60, 0, 25, 'moyar_1_sequert3', 1, 1, 1, 1); 

---moyar_2

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_moyar_2',611,259,811,459,'presence_flock_dom_moyar_2',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_moyar_2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_moyar_2',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_moyar_2',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('moyar_2_arbyt3', @presenceID, 3, @definitionID, 991, 1510, 2, 5, 60, 0, 25, 'moyar_2_arbyt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_cameleon_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('moyar_2_camt3', @presenceID, 3, @definitionID, 991, 1510, 2, 5, 60, 0, 25, 'moyar_2_camt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_scout_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('moyar_2_yagelt3', @presenceID, 3, @definitionID, 991, 1510, 2, 5, 60, 0, 25, 'moyar_2_yagelt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('moyar_2_sequert3', @presenceID, 3, @definitionID, 991, 1510, 2, 5, 60, 0, 25, 'moyar_2_sequert3', 1, 1, 1, 1); 

-----moyar_3

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_moyar_3',611,259,811,459,'presence_flock_dom_moyar_3',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_moyar_3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_moyar_3',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_moyar_3',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_hybrid_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('moyar_3_mest3', @presenceID, 2, @definitionID, 860, 1767, 2, 5, 60, 0, 25, 'moyar_3_mest3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_ew_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('moyar_3_kaint3', @presenceID, 2, @definitionID, 860, 1767, 2, 5, 60, 0, 25, 'moyar_3_kaint3', 1, 1, 1, 1); 

----moyar_4

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_moyar_4',611,259,811,459,'presence_flock_dom_moyar_4',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_moyar_4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_moyar_4',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_moyar_4',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_scout_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('moyar_4_yagelt3', @presenceID, 2, @definitionID, 1163, 1938, 2, 5, 60, 0, 25, 'moyar_4_yagelt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_scout_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('moyar_4_arbyT3', @presenceID, 2, @definitionID, 1163, 1938, 2, 5, 60, 0, 25, 'moyar_4_arbyT3', 1, 1, 1, 1); 

-----HHO_1

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_hho_1',611,259,811,459,'presence_flock_dom_hho_1',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_hho_1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_hho_1',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_hho_1',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_hybrid_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hho_1_mesmert3', @presenceID, 3, @definitionID, 1217, 1104, 2, 5, 60, 0, 25, 'hho_1_mesmert3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_ew_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hho_1_kaint3', @presenceID, 3, @definitionID, 1217, 1104, 2, 5, 60, 0, 25, 'hho_1_kaint3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vagabond_dps_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hho_1_vagat3', @presenceID, 3, @definitionID, 1217, 1104, 2, 5, 60, 0, 25, 'hho_1_vagat3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hho_1_sequert3', @presenceID, 3, @definitionID, 1217, 1104, 2, 5, 60, 0, 25, 'hho_1_sequert3', 1, 1, 1, 1); 

----hho_2

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_hho_2',611,259,811,459,'presence_flock_dom_hho_2',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_hho_2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_hho_2',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_hho_2',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hho_2_arbyt3', @presenceID, 3, @definitionID, 898, 1031, 2, 5, 60, 0, 25, 'hho_2_arbyt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_cameleon_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hho_2_camt3', @presenceID, 3, @definitionID, 898, 1031, 2, 5, 60, 0, 25, 'hho_2_camt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hho_2_yagelt3', @presenceID, 3, @definitionID, 898, 1031, 2, 5, 60, 0, 25, 'hho_2_yagelt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hho_2_sequert3', @presenceID, 3, @definitionID, 898, 1031, 2, 5, 60, 0, 25, 'hho_2_sequert3', 1, 1, 1, 1); 

----hho_3

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_hho_3',611,259,811,459,'presence_flock_dom_hho_3',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_hho_3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_hho_3',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_hho_3',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_hybrid_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hho_3_mest3', @presenceID, 2, @definitionID, 1065, 1207, 2, 5, 60, 0, 25, 'hho_3_mest3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_ew_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hho_3_kaint3', @presenceID, 2, @definitionID, 1065, 1207, 2, 5, 60, 0, 25, 'hho_3_kaint3', 1, 1, 1, 1); 

---hho_4

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_hho_4',611,259,811,459,'presence_flock_dom_hho_4',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_hho_4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_hho_4',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_hho_4',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hho_4_arbyt3', @presenceID, 2, @definitionID, 778, 1116, 2, 5, 60, 0, 25, 'hho_4_arbyt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_scout_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hho_4_yagelt3', @presenceID, 2, @definitionID, 778, 1116, 2, 5, 60, 0, 25, 'hho_4_yagelt3', 1, 1, 1, 1); 


----Kko__1

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_kko_1',611,259,811,459,'presence_flock_dom_kko_1',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_kko_1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_kko_1',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_kko_1',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_hybrid_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kko_1_mesmert3', @presenceID, 3, @definitionID, 1019, 363, 2, 5, 60, 0, 25, 'kko_1_mesmert3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_ew_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kko_1_kaint3', @presenceID, 3, @definitionID, 1019, 363, 2, 5, 60, 0, 25, 'kko_1_kaint3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vagabond_dps_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kko_1_vagat3', @presenceID, 3, @definitionID, 1019, 363, 2, 5, 60, 0, 25, 'kko_1_vagat3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kko_1_sequert3', @presenceID, 3, @definitionID, 1019, 363, 2, 5, 60, 0, 25, 'kko_1_sequert3', 1, 1, 1, 1); 

---KKO_2

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_kko_2',611,259,811,459,'presence_flock_dom_kko_2',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_kko_2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_kko_2',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_kko_2',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kko_2_arbyt3', @presenceID, 3, @definitionID, 1019, 363, 2, 5, 60, 0, 25, 'kko_2_arbyt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_cameleon_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kko_2_camt3', @presenceID, 3, @definitionID, 1019, 363, 2, 5, 60, 0, 25, 'kko_2_camt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_scout_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kko_2_yagelt3', @presenceID, 3, @definitionID, 1019, 363, 2, 5, 60, 0, 25, 'kko_2_yagelt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kko_2_sequert3', @presenceID, 3, @definitionID, 1019, 363, 2, 5, 60, 0, 25, 'kko_2_sequert3', 1, 1, 1, 1); 

----KKO_3

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_kko_3',611,259,811,459,'presence_flock_dom_kko_3',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_kko_3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_kko_3',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_kko_3',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_hybrid_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kko_3_mesmert3', @presenceID, 2, @definitionID, 1170, 613, 2, 5, 60, 0, 25, 'kko_3_mesmert3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_ew_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kko_3_kaint3', @presenceID, 2, @definitionID, 1170, 613, 2, 5, 60, 0, 25, 'kko_3_kaint3', 1, 1, 1, 1); 

----KKO_4

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_kko_4',611,259,811,459,'presence_flock_dom_kko_4',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_kko_4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_kko_4',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_kko_4',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_scout_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kko_4_arbyt3', @presenceID, 2, @definitionID, 1308, 282, 2, 5, 60, 0, 25, 'kko_4_arbyt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kko_4_yagelt3', @presenceID, 2, @definitionID, 1308, 282, 2, 5, 60, 0, 25, 'kko_4_yagelt3', 1, 1, 1, 1); 

---icsb_1

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_icsb_1',611,259,811,459,'presence_flock_dom_icsb_1',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_icsb_1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_icsb_1',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_icsb_1',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_hybrid_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('icsb_1_setht2', @presenceID, 2, @definitionID, 1800, 710, 2, 5, 60, 0, 25, 'icsb_1_setht2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_ew_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('icsb_1_artyt2', @presenceID, 2, @definitionID, 1800, 710, 2, 5, 60, 0, 25, 'icsb_1_artyt2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_zenith_dps_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('icsb_1_zenitht2', @presenceID, 2, @definitionID, 1800, 710, 2, 5, 60, 0, 25, 'icsb_1_zenitht2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('icsb_1_sequert2', @presenceID, 2, @definitionID, 1800, 710, 2, 5, 60, 0, 25, 'icsb_1_sequert2', 1, 1, 1, 1); 

----icsb_2

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_icsb_2',611,259,811,459,'presence_flock_dom_icsb_2',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_icsb_2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_icsb_2',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_icsb_2',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_hybrid_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('icsb_2_gropht2', @presenceID, 2, @definitionID, 1800, 1020, 2, 5, 60, 0, 25, 'icsb_2_gropht2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_ew_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('icsb_2_tyrot2', @presenceID, 2, @definitionID, 1800, 1020, 2, 5, 60, 0, 25, 'icsb_2_tyrot2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ictus_dps_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('icsb_2_ictust2', @presenceID, 2, @definitionID, 1800, 1020, 2, 5, 60, 0, 25, 'icsb_2_ictust2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('icsb_2_sequert2', @presenceID, 2, @definitionID, 1800, 1020, 2, 5, 60, 0, 25, 'icsb_2_sequert2', 1, 1, 1, 1); 

----icsb_3

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_icsb_3',611,259,811,459,'presence_flock_dom_icsb_2',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_icsb_3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_icsb_3',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_icsb_3',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_baphomet_interceptor_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('icsb_3_bapht2', @presenceID, 2, @definitionID, 1675, 1000, 2, 5, 60, 0, 25, 'icsb_3_bapht2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_intakt_interceptor_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('icsb_3_intaktt2', @presenceID, 2, @definitionID, 1675, 1000, 2, 5, 60, 0, 25, 'icsb_3_intaktt2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_prometheus_scout_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('icsb_3_promt2', @presenceID, 2, @definitionID, 1675, 1000, 2, 5, 60, 0, 25, 'icsb_3_promt2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('icsb_3_sequert2', @presenceID, 2, @definitionID, 1675, 1000, 2, 5, 60, 0, 25, 'icsb_3_sequert2', 1, 1, 1, 1); 

----icsb_4

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_icsb_4',611,259,811,459,'presence_flock_dom_icsb_4',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_icsb_4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_icsb_4',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_icsb_4',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_waspish_interceptor_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('icsb_4_waspisht2', @presenceID, 2, @definitionID, 1445, 845, 2, 5, 60, 0, 25, 'icsb_4_waspisht2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_troiar_interceptor_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('icsb_4_troiart2', @presenceID, 2, @definitionID, 1445, 845, 2, 5, 60, 0, 25, 'icsb_4_troiart2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_castel_interceptor_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('icsb_4_castelt2', @presenceID, 2, @definitionID, 1445, 845, 2, 5, 60, 0, 25, 'icsb_4_castelt2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('icsb_4_sequert2', @presenceID, 2, @definitionID, 1445, 845, 2, 5, 60, 0, 25, 'icsb_4_sequert2', 1, 1, 1, 1); 

----icsb_6

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_icsb_6',611,259,811,459,'presence_flock_dom_icsb_6',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_icsb_6' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_icsb_6',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_icsb_6',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_hybrid_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('icsb_6_setht2', @presenceID, 2, @definitionID, 1853, 900, 2, 5, 60, 0, 25, 'icsb_6_setht2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_intakt_interceptor_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('icsb_6_intaktt2', @presenceID, 2, @definitionID, 1853, 900, 2, 5, 60, 0, 25, 'icsb_6_intaktt2', 1, 1, 1, 1); 

----icsb_7

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_icsb_7',611,259,811,459,'presence_flock_dom_icsb_7',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_icsb_7' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_icsb_7',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_icsb_7',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_hybrid_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('icsb_7_grophot2', @presenceID, 2, @definitionID, 1500, 1075, 2, 5, 60, 0, 25, 'icsb_7_grophot2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_troiar_interceptor_rank2' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('icsb_7_troiart2', @presenceID, 2, @definitionID, 1500, 1075, 2, 5, 60, 0, 25, 'icsb_7_troiart2', 1, 1, 1, 1); 

----hitech

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_hitech',611,259,811,459,'presence_flock_dom_hitech',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_hitech' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_hitech',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_hitech',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_hybrid_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hitech_mest5', @presenceID, 3, @definitionID, 225, 1225, 2, 5, 60, 0, 25, 'hitech_mest5', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_ew_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hitech_kaint5', @presenceID, 3, @definitionID, 225, 1225, 2, 5, 60, 0, 25, 'hitech_kaint5', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vagabond_dps_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hitech_vagat5', @presenceID, 3, @definitionID, 225, 1225, 2, 5, 60, 0, 25, 'hitech_vagat5', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hitech_sequert5', @presenceID, 3, @definitionID, 225, 1225, 2, 5, 60, 0, 25, 'hitech_sequert5', 1, 1, 1, 1); 

---indyt3

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_indyt3',611,259,811,459,'presence_flock_dom_indyt3',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_indyt3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_indyt3',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_indyt3',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_symbiont_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('indyt3_symbt3', @presenceID, 3, @definitionID, 685, 365, 2, 5, 60, 0, 25, 'indyt3_symbt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_riveler_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('indyt3_rivt3', @presenceID, 3, @definitionID, 685, 365, 2, 5, 60, 0, 25, 'indyt3_rivt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_lithus_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('indyt3_litht3', @presenceID, 3, @definitionID, 685, 365, 2, 5, 60, 0, 25, 'indyt3_litht3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('indyt3_scarbt3', @presenceID, 3, @definitionID, 685, 365, 2, 5, 60, 0, 25, 'indyt3_scarbt3', 1, 1, 1, 1); 

---indyt5

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_indyt5',611,259,811,459,'presence_flock_dom_indyt5',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_indyt5' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_indyt5',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_indyt5',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_riveler_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('indyt5_rivt5', @presenceID, 3, @definitionID, 814, 814, 2, 5, 60, 0, 25, 'indyt5_rivt5', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_symbiont_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('indyt5_symbt5', @presenceID, 3, @definitionID, 814, 814, 2, 5, 60, 0, 25, 'indyt5_symbt5', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_lithus_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('indyt5_litht5', @presenceID, 3, @definitionID, 814, 814, 2, 5, 60, 0, 25, 'indyt5_litht5', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('indyt5_scarabt5', @presenceID, 3, @definitionID, 814, 814, 2, 5, 60, 0, 25, 'indyt5_scarabt5', 1, 1, 1, 1); 

-----soloindyt3

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_soloindyt3',611,259,811,459,'presence_flock_dom_soloindyt3',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_soloindyt3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_soloindyt3',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_soloindyt3',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_riveler_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('dom_soloindyt3_rivt3', @presenceID, 1, @definitionID, 950, 1400, 2, 5, 60, 0, 25, 'dom_soloindyt3_rivt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_symbiont_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('dom_soloindyt3_symbt3', @presenceID, 1, @definitionID, 950, 1400, 2, 5, 60, 0, 25, 'dom_soloindyt3_symbt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('dom_soloindyt3_scarabt3', @presenceID, 1, @definitionID, 950, 1400, 2, 5, 60, 0, 25, 'dom_soloindyt3_scarabt3', 1, 1, 1, 1); 

-----soloindyt5

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_soloindyt5',611,259,811,459,'presence_flock_dom_soloindyt5',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_soloindyt5' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_soloindyt5',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_soloindyt5',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_riveler_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('dom_soloindyt5_rivt5', @presenceID, 1, @definitionID, 1340, 1288, 2, 5, 60, 0, 25, 'dom_soloindyt5_rivt5', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_symbiont_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('dom_soloindyt5_symbt5', @presenceID, 1, @definitionID, 1340, 1288, 2, 5, 60, 0, 25, 'dom_soloindyt5_symbt5', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('dom_soloindyt5_scarabt5', @presenceID, 1, @definitionID, 1340, 1288, 2, 5, 60, 0, 25, 'dom_soloindyt5_scarabt5', 1, 1, 1, 1); 

				----moneyspawn

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_moneyspawn',611,259,811,459,'presence_flock_dom_moneyspawn',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_moneyspawn' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_moneyspawn',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_moneyspawn',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_callisto_buccaneer_rank4' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('dom_moneyspawn_callt4', @presenceID, 3, @definitionID, 690, 1255, 2, 5, 60, 0, 25, 'dom_moneyspawn_callt4', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank4' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('dom_moneyspawn_legt4', @presenceID, 3, @definitionID, 690, 1255, 2, 5, 60, 0, 25, 'dom_moneyspawn_legt4', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('dom_moneyspawn_legt3', @presenceID, 3, @definitionID, 690, 1255, 2, 5, 60, 0, 25, 'dom_moneyspawn_legt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank4' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('dom_moneyspawn_echt4', @presenceID, 3, @definitionID, 690, 1255, 2, 5, 60, 0, 25, 'dom_moneyspawn_echt4', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('dom_moneyspawn_echt3', @presenceID, 3, @definitionID, 690, 1255, 2, 5, 60, 0, 25, 'dom_moneyspawn_echt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ikarus_abstrans_rank4' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('dom_moneyspawn_ikarust4', @presenceID, 3, @definitionID, 690, 1255, 2, 5, 60, 0, 25, 'dom_moneyspawn_ikarust4', 1, 1, 1, 1); 

---hitechHMM

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_hitech_HMM',611,259,811,459,'presence_flock_dom_hitech_HMM',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_hitech_HMM' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_hitech_HMM',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_hitech_HMM',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_tank_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('dom_hitech_HMM_mest5', @presenceID, 2, @definitionID, 277, 1597, 2, 5, 60, 0, 25, 'dom_hitech_HMM_mest5', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vagabond_dps_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('dom_hitech_HMM_vagT5', @presenceID, 3, @definitionID, 277, 1597, 2, 5, 60, 0, 25, 'dom_hitech_HMM_vagT5', 1, 1, 1, 1); 

----hitech_assl

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_hitech_ASSL',611,259,811,459,'presence_flock_dom_hitech_ASSL',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_hitech_ASSL' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_hitech_ASSL',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_hitech_ASSL',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_interceptor_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('dom_hitech_assl_arbyT5', @presenceID, 2, @definitionID, 400, 400, 2, 5, 60, 0, 25, 'dom_hitech_assl_arbyT5', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_cameleon_interceptor_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('dom_hitech_assl_camT5', @presenceID, 3, @definitionID, 400, 400, 2, 5, 60, 0, 25, 'dom_hitech_assl_camT5', 1, 1, 1, 1); 

----lithus

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_dom_lithus',611,259,811,459,'presence_flock_dom_lithus',9,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_dom_lithus' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_dom_lithus',[topx] = 611,[topy] = 259,[bottomx] = 811,[bottomy] = 459,[note] = 'presence_flock_dom_lithus',[spawnid] = 9,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_lithus_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('dom_lithus_lithust3', @presenceID, 3, @definitionID, 775, 1025, 2, 5, 60, 0, 25, 'dom_lithus_lithust3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_lithus_basic_rank5' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('dom_lithus_lithusT5', @presenceID, 3, @definitionID, 775, 1025, 2, 5, 60, 0, 25, 'dom_lithus_lithusT5', 1, 1, 1, 1); 


----Cuting back on roaming spawns in the island

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'gei_roaming_01' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'gei_roaming_01',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 7,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 86400,[presencetype] = 1,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_roaming_tyrannos_beta' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_gei_roaming1_tyrannosbeta1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_gei_roaming1_tyrannosbeta1' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 559, [spawnoriginY] = 286 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'dom_roaming_01' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'dom_roaming_01',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 9,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 86400,[presencetype] = 1,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_roaming_kain_beta' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_dom_roaming1_kainbeta1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_dom_roaming1_kainbeta1' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1730, [spawnoriginY] = 1400 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hok_roaming_01' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'hok_roaming_01',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 8,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 86400,[presencetype] = 1,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_roaming_artemis_beta' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_hok_roaming1_artemisbeta1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_hok_roaming1_artemisbeta1' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1716, [spawnoriginY] = 1754 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'gei_caravan_01' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'gei_caravan_01',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 7,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 1800,[presencetype] = 1,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_gei_caravan1_sequer' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_gei_caravan1_sequer' ,[presenceid] = @presenceID, [flockmembercount] = 5, [definition] = @definitionID, [spawnoriginX] = 573, [spawnoriginY] = 279 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_troiar_interceptor_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_gei_caravan1_troiar' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_gei_caravan1_troiar' ,[presenceid] = @presenceID, [flockmembercount] = 5, [definition] = @definitionID, [spawnoriginX] = 573, [spawnoriginY] = 280 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_heavydps_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_gei_caravan1_gropho' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_gei_caravan1_gropho' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 573, [spawnoriginY] = 281 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_gei_caravan1_scarab' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_gei_caravan1_scarab' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 573, [spawnoriginY] = 279 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'dom_caravan_01' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'dom_caravan_01',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 9,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 1800,[presencetype] = 1,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_dom_caravan1_sequer' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_dom_caravan1_sequer' ,[presenceid] = @presenceID, [flockmembercount] = 5, [definition] = @definitionID, [spawnoriginX] = 1722, [spawnoriginY] = 1411 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_cameleon_interceptor_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_dom_caravan1_cameleon' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_dom_caravan1_cameleon' ,[presenceid] = @presenceID, [flockmembercount] = 5, [definition] = @definitionID, [spawnoriginX] = 1722, [spawnoriginY] = 1412 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_heavydps_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_dom_caravan1_mesmer' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_dom_caravan1_mesmer' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 1722, [spawnoriginY] = 1413 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_dom_caravan1_scarab' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_dom_caravan1_scarab' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1722, [spawnoriginY] = 1411 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hok_caravan_01' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'hok_caravan_01',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 8,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 1800,[presencetype] = 1,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_hok_caravan1_sequer' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_hok_caravan1_sequer' ,[presenceid] = @presenceID, [flockmembercount] = 5, [definition] = @definitionID, [spawnoriginX] = 1728, [spawnoriginY] = 1753 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_intakt_interceptor_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_hok_caravan1_intakt' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_hok_caravan1_intakt' ,[presenceid] = @presenceID, [flockmembercount] = 5, [definition] = @definitionID, [spawnoriginX] = 1729, [spawnoriginY] = 1754 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_heavydps_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_hok_caravan1_seth' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_hok_caravan1_seth' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 1730, [spawnoriginY] = 1755 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_hok_caravan1_scarab' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_hok_caravan1_scarab' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1730, [spawnoriginY] = 1755 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'gei_roaming_02' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'gei_roaming_02',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 7,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 86400,[presencetype] = 1,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_roaming_tyrannos_beta' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_gei_roaming2_tyrannosbeta1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_gei_roaming2_tyrannosbeta1' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 558, [spawnoriginY] = 286 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_roaming_gropho_beta' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_gei_roaming2_grophobeta1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_gei_roaming2_grophobeta1' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 557, [spawnoriginY] = 286 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'gei_caravan_02' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'gei_caravan_02',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 7,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 1800,[presencetype] = 1,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_gei_caravan2_sequer' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_gei_caravan2_sequer' ,[presenceid] = @presenceID, [flockmembercount] = 5, [definition] = @definitionID, [spawnoriginX] = 565, [spawnoriginY] = 279 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ictus_heavyew_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_gei_caravan2_ictus' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_gei_caravan2_ictus' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 565, [spawnoriginY] = 280 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_heavydps_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_gei_caravan2_gropho' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_gei_caravan2_gropho' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 565, [spawnoriginY] = 281 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_gei_caravan2_scarab' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_gei_caravan2_scarab' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = @definitionID, [spawnoriginX] = 565, [spawnoriginY] = 279 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'gei_roaming_03' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'gei_roaming_03',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 7,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 86400,[presencetype] = 1,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_troiar_interceptor_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_gei_roaming3_troiar' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_gei_roaming3_troiar' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 573, [spawnoriginY] = 290 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 3600, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_dps_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_gei_roaming3_tyrannos' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_gei_roaming3_tyrannos' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = @definitionID, [spawnoriginX] = 572, [spawnoriginY] = 290 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 3600, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_waspish_dps_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_gei_roaming3_waspish' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_gei_roaming3_waspish' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 571, [spawnoriginY] = 290 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 3600, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ictus_heavyew_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_gei_roaming3_ictus' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_gei_roaming3_ictus' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 570, [spawnoriginY] = 290 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 3600, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'dom_roaming_02' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'dom_roaming_02',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 9,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 86400,[presencetype] = 1,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_roaming_kain_beta' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_dom_roaming2_kainbeta1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_dom_roaming2_kainbeta1' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1731, [spawnoriginY] = 1399 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_roaming_mesmer_beta' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_dom_roaming2_mesmer1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_dom_roaming2_mesmer1' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1731, [spawnoriginY] = 1398 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'dom_caravan_02' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'dom_caravan_02',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 9,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 1800,[presencetype] = 1,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_heavydps_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_dom_caravan2_mesmer' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_dom_caravan2_mesmer' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 1731, [spawnoriginY] = 1410 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vagabond_heavyew_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_dom_caravan2_vagabond' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_dom_caravan2_vagabond' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 1731, [spawnoriginY] = 1409 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_dom_caravan2_sequer' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_dom_caravan2_sequer' ,[presenceid] = @presenceID, [flockmembercount] = 5, [definition] = @definitionID, [spawnoriginX] = 1731, [spawnoriginY] = 1411 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_dom_caravan2_scarab' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_dom_caravan2_scarab' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 1731, [spawnoriginY] = 1411 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_dom_caravan2_scarab' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_dom_caravan2_scarab' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = @definitionID, [spawnoriginX] = 1731, [spawnoriginY] = 1411 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'dom_roaming_03' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'dom_roaming_03',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 9,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 86400,[presencetype] = 1,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_cameleon_interceptor_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_dom_roaming3_cameleon' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_dom_roaming3_cameleon' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 1721, [spawnoriginY] = 1398 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 3600, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_dps_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_dom_roaming3_kain' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_dom_roaming3_kain' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = @definitionID, [spawnoriginX] = 1721, [spawnoriginY] = 1399 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 3600, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_dps_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_dom_roaming3_arbalest' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_dom_roaming3_arbalest' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 1721, [spawnoriginY] = 1400 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 3600, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vagabond_heavyew_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_dom_roaming3_vagabond' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_dom_roaming3_vagabond' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1721, [spawnoriginY] = 1401 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 3600, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hok_roaming_02' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'hok_roaming_02',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 8,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 86400,[presencetype] = 1,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_roaming_artemis_beta' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_hok_roaming2_artemisbeta1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_hok_roaming2_artemisbeta1' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1717, [spawnoriginY] = 1753 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_roaming_seth_beta' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_hok_roaming2_sethbeta1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_hok_roaming2_sethbeta1' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1718, [spawnoriginY] = 1752 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hok_caravan_02' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'hok_caravan_02',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 8,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 1800,[presencetype] = 1,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_hok_caravan2_sequer' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_hok_caravan2_sequer' ,[presenceid] = @presenceID, [flockmembercount] = 5, [definition] = @definitionID, [spawnoriginX] = 1724, [spawnoriginY] = 1757 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_zenith_heavyew_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_hok_caravan2_zenith' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_hok_caravan2_zenith' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 1725, [spawnoriginY] = 1758 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_heavydps_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_hok_caravan2_seth' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_hok_caravan2_seth' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 1726, [spawnoriginY] = 1759 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_hok_caravan2_scarab' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_hok_caravan2_scarab' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 1724, [spawnoriginY] = 1757 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_hok_caravan2_scarab' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_hok_caravan2_scarab' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = @definitionID, [spawnoriginX] = 1724, [spawnoriginY] = 1757 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 86400, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hok_roaming_03' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'hok_roaming_03',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 8,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 86400,[presencetype] = 1,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_intakt_interceptor_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_hok_roaming3_intakt' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_hok_roaming3_intakt' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 1718, [spawnoriginY] = 1756 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 3600, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_baphomet_dps_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_hok_roaming3_baphomet' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_hok_roaming3_baphomet' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 1719, [spawnoriginY] = 1755 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 3600, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_dps_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_hok_roaming3_artemis' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_hok_roaming3_artemis' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = @definitionID, [spawnoriginX] = 1720, [spawnoriginY] = 1754 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 3600, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_zenith_heavyew_rank5' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'flock_hok_roaming3_zenith' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'flock_hok_roaming3_zenith' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1721, [spawnoriginY] = 1753 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 3600, [totalspawncount] = 0, [homerange] = 15 ,[note] = '', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;


set noexec off;

PRINT N'BETA 1 NPC OVERHAUL PATCH COMPLETE';
GO
-------------------------------------------------------------------------------------------------------------------------



PRINT N'NPCs_Beta2__2019_05_02';
-------------------------------------------------------------------------------------------------------------------------

USE [perpetuumsa]
GO

-------------------------------------------------
--Beta 2 NPC overhaul
--Inserts a bunch of new presences and flocks
--
--date: 2019/05/02
------------------------------------------------

DECLARE @flockID int;
DECLARE @definitionID int;
DECLARE @presenceID int;

-----B2 Group T3 spawns add for Heavy Mechs and Assault/Light

---Alsbale

PRINT N'Inserting New Presences';

set noexec off;

IF EXISTS (SELECT TOP 1 id from [npcpresence] WHERE [name] = 'presence_flock_ALB_1')
BEGIN
	PRINT N'PRESENCE FOUND! Skipping inserts';
	set noexec on;
END


INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_ALB_1',472,51,672,251,'',15,1,0,0,3,3,572
			    ,151,5,'',1,1,1);


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_ALB_1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_ALB_1',[topx] = 472,[topy] = 51,[bottomx] = 672,[bottomy] = 251,[note] = 'presence_flock_ALB_1',[spawnid] = 15,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_hybrid_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Alb_1_gropht3', @presenceID, 3, @definitionID, 1222, 730, 2, 5, 60, 0, 25, 'Alb_1_gropht3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_ew_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('alb_1_tyrot3', @presenceID, 3, @definitionID, 1222, 730, 2, 5, 60, 0, 25, 'alb_1_tyrot3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ictus_dps_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('alb_1_ictust3', @presenceID, 3, @definitionID, 1222, 730, 2, 5, 60, 0, 25, 'alb_1_ictust3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('alb_1_seqt3', @presenceID, 3, @definitionID, 1222, 730, 2, 5, 60, 0, 25, 'alb_1_seqt3', 1, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_ALB_2',472,51,672,251,'presence_flock_ALB_2',15,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_ALB_2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_ALB_2',[topx] = 472,[topy] = 51,[bottomx] = 672,[bottomy] = 251,[note] = 'presence_flock_ALB_2',[spawnid] = 15,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_waspish_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('alb_2_waspt3', @presenceID, 3, @definitionID, 1300, 960, 2, 5, 60, 0, 25, 'alb_2_waspt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_troiar_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('alb_2_troiart3', @presenceID, 3, @definitionID, 1300, 960, 2, 5, 60, 0, 25, 'alb_2_troiart3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_castel_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('alb_2_castelt3', @presenceID, 3, @definitionID, 1300, 960, 2, 5, 60, 0, 25, 'alb_2_castelt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('alb_2_seqt3', @presenceID, 3, @definitionID, 1300, 960, 2, 5, 60, 0, 25, 'alb_2_seqt3', 1, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_ALB_3',472,51,672,251,'presence_flock_ALB_3',15,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_ALB_3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_ALB_3',[topx] = 472,[topy] = 51,[bottomx] = 672,[bottomy] = 251,[note] = 'presence_flock_ALB_3',[spawnid] = 15,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_hybrid_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('alb_3_gropht3', @presenceID, 3, @definitionID, 980, 1570, 2, 5, 60, 0, 25, 'alb_3_gropht3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_ew_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('alb_3_tyrot3', @presenceID, 3, @definitionID, 980, 1570, 2, 5, 60, 0, 25, 'alb_3_tyrot3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ictus_dps_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('alb_3_ictust3', @presenceID, 3, @definitionID, 980, 1570, 2, 5, 60, 0, 25, 'alb_3_ictust3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('alb_3_seqt3', @presenceID, 3, @definitionID, 980, 1570, 2, 5, 60, 0, 25, 'alb_3_seqt3', 1, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_ALB_4',472,51,672,251,'presence_flock_ALB_4',15,1,0,0,0,'',''
			    ,'','','',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_ALB_4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_ALB_4',[topx] = 472,[topy] = 51,[bottomx] = 672,[bottomy] = 251,[note] = 'presence_flock_ALB_4',[spawnid] = 15,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_waspish_scout_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('alb_4_waspt3', @presenceID, 3, @definitionID, 430, 1560, 2, 5, 60, 0, 25, 'alb_4_waspt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_troiar_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('alb_4_troiart3', @presenceID, 3, @definitionID, 430, 1560, 2, 5, 60, 0, 25, 'alb_4_troiart3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_castel_scout_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('alb_4_castelt3', @presenceID, 3, @definitionID, 430, 1560, 2, 5, 60, 0, 25, 'alb_4_castelt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('alb_4_sequert3', @presenceID, 3, @definitionID, 430, 1560, 2, 5, 60, 0, 25, 'alb_4_sequert3', 1, 1, 1, 1); 


----Nova


INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_Nova_1',1340,313,1540,513,'presence_flock_Nova_1',16,1,0,0,3,3,1440
			    ,413,5,'',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_Nova_1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_Nova_1',[topx] = 1340,[topy] = 313,[bottomx] = 1540,[bottomy] = 513,[note] = 'presence_flock_Nova_1',[spawnid] = 16,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 3,[randomcenterx] = 1440,[randomcentery] = 413
                ,[randomradius] = 5,[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_hybrid_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nova_1_mesmert3', @presenceID, 3, @definitionID, 1025, 800, 2, 5, 60, 0, 25, 'nova_1_mesmert3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_ew_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nova_1_kaint3', @presenceID, 3, @definitionID, 1025, 800, 2, 5, 60, 0, 25, 'nova_1_kaint3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vagabond_dps_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nova_1_vagabondt3', @presenceID, 3, @definitionID, 1025, 800, 2, 5, 60, 0, 25, 'nova_1_vagabondt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nova_1_sequert3', @presenceID, 3, @definitionID, 1025, 800, 2, 5, 60, 0, 25, 'nova_1_sequert3', 1, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_Nova_2',1340,313,1540,513,'presence_flock_Nova_2',16,1,0,0,0,3,1440
			    ,413,5,'',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_Nova_2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_Nova_2',[topx] = 1340,[topy] = 313,[bottomx] = 1540,[bottomy] = 513,[note] = 'presence_flock_Nova_2',[spawnid] = 16,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 3,[randomcenterx] = 1440,[randomcentery] = 413
                ,[randomradius] = 5,[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_scout_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nova_2_arbyt3', @presenceID, 3, @definitionID, 555, 1240, 2, 5, 60, 0, 25, 'nova_2_arbyt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_cameleon_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nova_2_camt3', @presenceID, 3, @definitionID, 555, 1240, 2, 5, 60, 0, 25, 'nova_2_camt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Nova_2_yagelt3', @presenceID, 3, @definitionID, 555, 1240, 2, 5, 60, 0, 25, 'Nova_2_yagelt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nova_2_sequert3', @presenceID, 3, @definitionID, 555, 1240, 2, 5, 60, 0, 25, 'nova_2_sequert3', 1, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_Nova_3',1340,313,1540,513,'presence_flock_Nova_3',16,1,0,0,0,3,1440
			    ,413,5,'',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_Nova_3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_Nova_3',[topx] = 1340,[topy] = 313,[bottomx] = 1540,[bottomy] = 513,[note] = 'presence_flock_Nova_3',[spawnid] = 16,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 3,[randomcenterx] = 1440,[randomcentery] = 413
                ,[randomradius] = 5,[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_hybrid_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nova_3_mesmert3', @presenceID, 3, @definitionID, 1830, 915, 2, 5, 60, 0, 25, 'nova_3_mesmert3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_ew_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nova_3_kaint3', @presenceID, 3, @definitionID, 864, 962, 2, 5, 60, 0, 25, 'nova_3_kaint3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vagabond_dps_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nova_3_vagabondt3', @presenceID, 3, @definitionID, 864, 962, 2, 5, 60, 0, 25, 'nova_3_vagabondt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Nova_3_sequert3', @presenceID, 3, @definitionID, 864, 962, 2, 5, 60, 0, 25, 'Nova_3_sequert3', 1, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_Nova_4',1340,313,1540,513,'presence_flock_Nova_4',16,1,0,0,0,3,1440
			    ,413,5,'',1,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_Nova_4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_Nova_4',[topx] = 1340,[topy] = 313,[bottomx] = 1540,[bottomy] = 513,[note] = 'presence_flock_Nova_4',[spawnid] = 16,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 3,[randomcenterx] = 1440,[randomcentery] = 413
                ,[randomradius] = 5,[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_scout_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nova_4_arbyt3', @presenceID, 3, @definitionID, 1560, 900, 2, 5, 60, 0, 25, 'nova_4_arbyt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_cameleon_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nova_4_camt3', @presenceID, 3, @definitionID, 1560, 900, 2, 5, 60, 0, 25, 'nova_4_camt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_scout_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nova_4_yagelt3', @presenceID, 3, @definitionID, 1560, 900, 2, 5, 60, 0, 25, 'nova_4_yagelt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('nova_4_seqt3', @presenceID, 3, @definitionID, 1560, 900, 2, 5, 60, 0, 25, 'nova_4_seqt3', 1, 1, 1, 1); 


---Kentagura

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('Presence_flock_Kent1',464,867,664,1067,'Presence_flock_Kent1',14,1,0,0,0,0,0
			    ,0,0,0,0,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Presence_flock_Kent1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Presence_flock_Kent1',[topx] = 464,[topy] = 867,[bottomx] = 664,[bottomy] = 1067,[note] = 'Presence_flock_Kent1',[spawnid] = 14,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_hybrid_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kent_1_setht3', @presenceID, 3, @definitionID, 773, 350, 2, 5, 60, 0, 25, 'Kent_1_setht3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_ew_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kent_1_artyt3', @presenceID, 3, @definitionID, 773, 350, 2, 5, 60, 0, 25, 'Kent_1_artyt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_zenith_dps_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kent_1_zanitht3', @presenceID, 3, @definitionID, 773, 350, 2, 5, 60, 0, 25, 'Kent_1_zanitht3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kent_1_sequert3', @presenceID, 3, @definitionID, 773, 350, 2, 5, 60, 0, 25, 'Kent_1_sequert3', 1, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('Presence_flock_Kent_2',464,867,664,1067,'Presence_flock_Kent_2',14,1,0,0,0,0,0
			    ,0,0,0,0,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Presence_flock_Kent_2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Presence_flock_Kent_2',[topx] = 464,[topy] = 867,[bottomx] = 664,[bottomy] = 1067,[note] = 'Presence_flock_Kent_2',[spawnid] = 14,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_baphomet_scout_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kent_2_bapht3', @presenceID, 3, @definitionID, 1190, 570, 2, 5, 60, 0, 25, 'kent_2_bapht3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_intakt_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kent_2_intaktt3', @presenceID, 3, @definitionID, 1190, 570, 2, 5, 60, 0, 25, 'Kent_2_intaktt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_prometheus_scout_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kent_2_promt3', @presenceID, 3, @definitionID, 1190, 570, 2, 5, 60, 0, 25, 'Kent_2_promt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kent_2_sequert3', @presenceID, 3, @definitionID, 1190, 570, 2, 5, 60, 0, 25, 'Kent_2_sequert3', 1, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('Presence_flock_Kent_3',464,867,664,1067,'Presence_flock_Kent_3',14,1,0,0,0,0,0
			    ,0,0,0,0,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Presence_flock_Kent_3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Presence_flock_Kent_3',[topx] = 464,[topy] = 867,[bottomx] = 664,[bottomy] = 1067,[note] = 'Presence_flock_Kent_3',[spawnid] = 14,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_hybrid_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kent_3_setht3', @presenceID, 3, @definitionID, 430, 860, 2, 5, 60, 0, 25, 'Kent_3_setht3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_ew_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kent_3_artyt3', @presenceID, 3, @definitionID, 430, 860, 2, 5, 60, 0, 25, 'Kent_3_artyt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_zenith_dps_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kent_3_zenitht3', @presenceID, 3, @definitionID, 430, 860, 2, 5, 60, 0, 25, 'Kent_3_zenitht3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kent_3_sequert3', @presenceID, 3, @definitionID, 430, 860, 2, 5, 60, 0, 25, 'Kent_3_sequert3', 1, 1, 1, 1); 

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('Presence_flock_Kent_4',464,867,664,1067,'Presence_flock_Kent_4',14,1,0,0,0,0,0
			    ,0,0,0,0,1,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Presence_flock_Kent_4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Presence_flock_Kent_4',[topx] = 464,[topy] = 867,[bottomx] = 664,[bottomy] = 1067,[note] = 'Presence_flock_Kent_4',[spawnid] = 14,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_baphomet_scout_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kent_4_bapht3', @presenceID, 3, @definitionID, 270, 840, 2, 5, 60, 0, 25, 'kent_4_bapht3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_intakt_interceptor_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kent_4_intaktt3', @presenceID, 3, @definitionID, 270, 840, 2, 5, 60, 0, 25, 'kent_4_intaktt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_prometheus_scout_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kent_4_promt3', @presenceID, 3, @definitionID, 270, 840, 2, 5, 60, 0, 25, 'Kent_4_promt3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank3' ORDER BY definition DESC);

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Kent_4_seqt3', @presenceID, 3, @definitionID, 270, 840, 2, 5, 60, 0, 25, 'Kent_4_seqt3', 1, 1, 1, 1); 



set noexec off;
PRINT N'COMPLETE WITH BETA2 NPC INSERTS';
GO

----------------------------------------------------------------------------------------------------------------




---------------------------------------------------------------------------------------------------------------------------------------------

PRINT N'PATCH 11 COMPLETE';