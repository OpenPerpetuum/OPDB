USE [perpetuumsa]
GO
------------INSERT (restoring from previous removal) missiles to green syndicate shops (beta only)------------

--For reference from entitydefaults:
--  definition	definitionname
--2445	def_ammo_rocket_rewa  100  400000
--2446	def_ammo_rocket_rewb  100
--2447	def_ammo_missile_rewa  600 2400000
--2448	def_ammo_missile_rewb  600
--2449	def_ammo_longrange_missile_rewa
--2450	def_ammo_longrange_missile_rewb

DECLARE @def int;
DECLARE @presetshop int;
SET @presetshop = (SELECT TOP 1 id FROM itemshoppresets where name='tm_preset_pvp');

PRINT N'Insert def_ammo_rocket_rewa into SyndicateShop tm_preset_pvp';
SET @def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_rocket_rewa');
INSERT INTO [dbo].[itemshop]
           ([presetid],[targetdefinition],[targetamount],[tmcoin],[icscoin],[asicoin],[credit],[unicoin],[globallimit],[purchasecount],[standing])
     VALUES
           (@presetshop,2445,1000,100,NULL,NULL,400000,NULL,NULL,1,NULL);

PRINT N'Insert def_ammo_rocket_rewa into SyndicateShop tm_preset_pvp';
SET @def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_rocket_rewb');
INSERT INTO [dbo].[itemshop]
           ([presetid],[targetdefinition],[targetamount],[tmcoin],[icscoin],[asicoin],[credit],[unicoin],[globallimit],[purchasecount],[standing])
     VALUES
           (@presetshop,2446,1000,100,NULL,NULL,400000,NULL,NULL,1,NULL);

PRINT N'Insert def_ammo_missile_rewa into SyndicateShop tm_preset_pvp';
SET @def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_missile_rewa');
INSERT INTO [dbo].[itemshop]
           ([presetid],[targetdefinition],[targetamount],[tmcoin],[icscoin],[asicoin],[credit],[unicoin],[globallimit],[purchasecount],[standing])
     VALUES
           (@presetshop,2447,1000,100,NULL,NULL,2400000,NULL,NULL,1,NULL);

PRINT N'Insert def_ammo_missile_rewa into SyndicateShop tm_preset_pvp';
SET @def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_missile_rewa');
INSERT INTO [dbo].[itemshop]
           ([presetid],[targetdefinition],[targetamount],[tmcoin],[icscoin],[asicoin],[credit],[unicoin],[globallimit],[purchasecount],[standing])
     VALUES
           (@presetshop,2448,1000,600,NULL,NULL,2400000,NULL,NULL,1,NULL);

PRINT N'Insert def_ammo_longrange_missile_rewa into SyndicateShop tm_preset_pvp';
SET @def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_longrange_missile_rewa');
INSERT INTO [dbo].[itemshop]
           ([presetid],[targetdefinition],[targetamount],[tmcoin],[icscoin],[asicoin],[credit],[unicoin],[globallimit],[purchasecount],[standing])
     VALUES
           (@presetshop,2449,1000,600,NULL,NULL,2400000,NULL,NULL,1,NULL);

PRINT N'Insert def_ammo_longrange_missile_rewb into SyndicateShop tm_preset_pvp';
SET @def = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_longrange_missile_rewb');
INSERT INTO [dbo].[itemshop]
           ([presetid],[targetdefinition],[targetamount],[tmcoin],[icscoin],[asicoin],[credit],[unicoin],[globallimit],[purchasecount],[standing])
     VALUES
           (@presetshop,2450,1000,600,NULL,NULL,2400000,NULL,NULL,1,NULL);

GO