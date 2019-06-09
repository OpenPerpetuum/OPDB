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