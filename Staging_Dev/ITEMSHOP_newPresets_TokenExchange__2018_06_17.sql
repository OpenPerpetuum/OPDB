USE [perpetuumsa]
GO

--Creates new bespoke SyndicateShops at the NV outposts
--Each will host a token-exchange where one faction token can be exchanged for the other 3 types
--TL;DR A giant script to do something because the client can't deal with selling the same item twice at the same shop

--Updates public betas to be pvp presets
--Reduces PVP ammo nic cost


PRINT N'INSERT NEW ITEMSHOPPRESETS';

DECLARE @bellichaPresetName varchar(128);
DECLARE @cadavPresetName varchar(128);
DECLARE @lenworthPresetName varchar(128);

SET @bellichaPresetName = 'bellicha_preset_pve';
SET @cadavPresetName = 'cadavaria_preset_pve';
SET @lenworthPresetName = 'lenworth_preset_pve';


INSERT INTO [dbo].[itemshoppresets]
           ([name],[note])
     VALUES
           (@bellichaPresetName,'Bellicha outpost on NV shop preset'),
		   (@cadavPresetName,'Cadavaria outpost on NV shop preset'),
		   (@lenworthPresetName,'Lenworth outpost on NV shop preset');


PRINT N'UPDATE itemshop at NV outposts to new ItemshopPresets';


UPDATE itemshoplocations
SET presetid = (SELECT TOP 1 id FROM itemshoppresets WHERE name=@cadavPresetName)
WHERE locationeid = (SELECT TOP 1 locationeid FROM itemshoplocations 
	JOIN itemshoppresets ON itemshoppresets.id=presetid 
	JOIN entities ON locationeid=eid 
	WHERE entities.parent = (SELECT eid FROM entities WHERE ename='tm_outpost_s_03'));

UPDATE itemshoplocations
SET presetid = (SELECT TOP 1 id FROM itemshoppresets WHERE name=@bellichaPresetName)
WHERE locationeid = (SELECT TOP 1 locationeid FROM itemshoplocations 
	JOIN itemshoppresets ON itemshoppresets.id=presetid 
	JOIN entities ON locationeid=eid 
	WHERE entities.parent = (SELECT eid FROM entities WHERE ename='tm_outpost_w_01'));


UPDATE itemshoplocations
SET presetid = (SELECT TOP 1 id FROM itemshoppresets WHERE name=@lenworthPresetName)
WHERE locationeid = (SELECT TOP 1 locationeid FROM itemshoplocations 
	JOIN itemshoppresets ON itemshoppresets.id=presetid 
	JOIN entities ON locationeid=eid 
	WHERE entities.parent = (SELECT eid FROM entities WHERE ename='tm_outpost_i_02'));


PRINT N'UPDATE public beta terminals to have same preset as beta outposts';
----UPDATE public beta terminals to have same preset as beta outposts
UPDATE itemshoplocations
SET presetid = (SELECT TOP 1 id FROM itemshoppresets WHERE name='tm_preset_pvp')
WHERE locationeid = (SELECT TOP 1 locationeid FROM itemshoplocations 
	JOIN itemshoppresets ON itemshoppresets.id=presetid 
	JOIN entities ON locationeid=eid 
	WHERE entities.parent = (SELECT eid FROM entities WHERE ename='base_TM_secondary'));


UPDATE itemshoplocations
SET presetid = (SELECT TOP 1 id FROM itemshoppresets WHERE name='ics_preset_pvp')
WHERE locationeid = (SELECT TOP 1 locationeid FROM itemshoplocations 
	JOIN itemshoppresets ON itemshoppresets.id=presetid 
	JOIN entities ON locationeid=eid 
	WHERE entities.parent = (SELECT eid FROM entities WHERE ename='base_ICS_secondary'));


UPDATE itemshoplocations
SET presetid = (SELECT TOP 1 id FROM itemshoppresets WHERE name='asi_preset_pvp')
WHERE locationeid = (SELECT TOP 1 locationeid FROM itemshoplocations 
	JOIN itemshoppresets ON itemshoppresets.id=presetid 
	JOIN entities ON locationeid=eid 
	WHERE entities.parent = (SELECT eid FROM entities WHERE ename='base_ASI_secondary'));


PRINT N'UPDATE NIC COST OF ALL AMMOS: cut in half';
----UPDATE NIC COST OF ALL AMMOS---
UPDATE [dbo].[itemshop]
SET credit = credit*0.5
WHERE targetdefinition in (SELECT definition FROM entitydefaults
WHERE definitionname LIKE '%rew%' and definitionname like 'def_ammo_%');



PRINT N'INSERT token exchanges at each outpost preset and the TM alpha shops (only TMA and hersh now)';
-----------TOKEN EXCHANGES--------------
DECLARE @tmShops int;
DECLARE @bellichaShop int;
DECLARE @cadavShop int;
DECLARE @lenworthShop int;
DECLARE @icsTokenDef int;
DECLARE @tmTokenDef int;
DECLARE @asiTokenDef int;
DECLARE @uniTokenDef int;

SET @tmShops = (SELECT TOP 1 id FROM itemshoppresets WHERE name='tm_preset_pve');
SET @bellichaShop = (SELECT TOP 1 id FROM itemshoppresets WHERE name=@bellichaPresetName);
SET @cadavShop = (SELECT TOP 1 id FROM itemshoppresets WHERE name=@cadavPresetName);
SET @lenworthShop = (SELECT TOP 1 id FROM itemshoppresets WHERE name=@lenworthPresetName);
SET @icsTokenDef = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ics_mission_coin');
SET @tmTokenDef = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_tm_mission_coin');
SET @asiTokenDef = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_asi_mission_coin');
SET @uniTokenDef = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_universal_mission_coin');


DECLARE @targetAmount int;
DECLARE @targetCost int;
DECLARE @purchaseNICFee int;

SET @targetAmount = 1;
SET @targetCost = 5;
SET @purchaseNICFee = 10;

--Each token exchange accepts one token type and sells the 3 others
INSERT INTO [dbo].[itemshop]
           ([presetid],[targetdefinition],[targetamount],[tmcoin],[icscoin],[asicoin],[credit],[unicoin],[globallimit],[purchasecount],[standing])
     VALUES
           (@bellichaShop,@asiTokenDef,@targetAmount,NULL,@targetCost,NULL,@purchaseNICFee,NULL,NULL,0,NULL),
		   (@bellichaShop,@tmTokenDef,@targetAmount,NULL,@targetCost,NULL,@purchaseNICFee,NULL,NULL,0,NULL),
		   (@bellichaShop,@uniTokenDef,@targetAmount,NULL,@targetCost,NULL,@purchaseNICFee,NULL,NULL,0,NULL),
		   (@cadavShop,@icsTokenDef,@targetAmount,NULL,NULL,@targetCost,@purchaseNICFee,NULL,NULL,0,NULL),
		   (@cadavShop,@tmTokenDef,@targetAmount,NULL,NULL,@targetCost,@purchaseNICFee,NULL,NULL,0,NULL),
		   (@cadavShop,@uniTokenDef,@targetAmount,NULL,NULL,@targetCost,@purchaseNICFee,NULL,NULL,0,NULL),
		   (@lenworthShop,@asiTokenDef,@targetAmount,@targetCost,NULL,NULL,@purchaseNICFee,NULL,NULL,0,NULL),
		   (@lenworthShop,@icsTokenDef,@targetAmount,@targetCost,NULL,NULL,@purchaseNICFee,NULL,NULL,0,NULL),
		   (@lenworthShop,@uniTokenDef,@targetAmount,@targetCost,NULL,NULL,@purchaseNICFee,NULL,NULL,0,NULL),
		   (@tmShops,@asiTokenDef,@targetAmount,NULL,NULL,NULL,@purchaseNICFee,@targetCost,NULL,0,NULL),
		   (@tmShops,@icsTokenDef,@targetAmount,NULL,NULL,NULL,@purchaseNICFee,@targetCost,NULL,0,NULL),
		   (@tmShops,@tmTokenDef,@targetAmount,NULL,NULL,NULL,@purchaseNICFee,@targetCost,NULL,0,NULL);


GO