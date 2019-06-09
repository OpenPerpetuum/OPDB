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
