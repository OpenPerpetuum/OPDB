USE [perpetuumsa]
GO

-------------------------------------INSERT OF PAINTS-------------------------------------
-----Create All Paint defintions, configs(color), and seed in Syndicate shops
PRINT N'PAINT';
DECLARE @alphaItemShop int;
DECLARE @betaTM int;
DECLARE @betaASI int;
DECLARE @betaICS int;

SET @alphaItemShop = (SELECT TOP 1 id FROM itemshoppresets WHERE name like 'tm_preset_pve');
SET @betaTM = (SELECT TOP 1 id FROM itemshoppresets WHERE name like 'tm_preset_pvp');
SET @betaASI = (SELECT TOP 1 id FROM itemshoppresets WHERE name like 'asi_preset_pvp');
SET @betaICS = (SELECT TOP 1 id FROM itemshoppresets WHERE name like 'ics_preset_pvp');


CREATE TABLE #PAINTS
(
	paintName varchar(100),
	paintColor varchar(50),
	tierType int,
	techLevel int,
	nicPrice int, 
	asiToken int,
	tmToken int,
	icsToken int,
	uniToken int,
	itemshopPresetID int
)

INSERT INTO #PAINTS VALUES
('def_paint_black','#010101',NULL,NULL,10000000,333,333,333,NULL,@alphaItemShop),
('def_paint_blue_dark','#010133',NULL,NULL,10000000,19,19,962,NULL,@alphaItemShop),
('def_paint_blue','#0101fb',NULL,NULL,10000000,4,4,992,NULL,@alphaItemShop),
('def_paint_green_dark','#013301',NULL,NULL,10000000,19,962,19,NULL,@alphaItemShop),
('def_paint_teal','#01c997',NULL,NULL,10000000,3,569,428,NULL,@alphaItemShop),
('def_paint_green','#01fb01',NULL,NULL,10000000,4,992,4,NULL,@alphaItemShop),
('def_paint_cyan','#01fbfb',NULL,NULL,10000000,2,499,499,NULL,@alphaItemShop),
('def_paint_red_dark','#650101',NULL,NULL,10000000,981,10,10,NULL,@alphaItemShop),
('def_paint_purple','#6501fb',NULL,NULL,10000000,286,3,711,NULL,@alphaItemShop),
('def_paint_gray','#979797',NULL,NULL,10000000,333,333,333,NULL,@alphaItemShop),
('def_paint_red','#fb0101',NULL,NULL,10000000,992,4,4,NULL,@alphaItemShop),
('def_paint_magenta','#fb01fb',NULL,NULL,10000000,499,2,499,NULL,@alphaItemShop),
('def_paint_orange','#fb9701',NULL,NULL,10000000,623,375,2,NULL,@alphaItemShop),
('def_paint_yellow','#fbfb01',NULL,NULL,10000000,499,499,2,NULL,@alphaItemShop),
('def_paint_white','#fbfbfb',NULL,NULL,10000000,333,333,333,NULL,@alphaItemShop);


DECLARE @paintName varchar(100);
DECLARE @paintColor varchar(50);
DECLARE @tierType int;
DECLARE @techLevel int;
DECLARE	@nicPrice int; 
DECLARE	@asiToken int;
DECLARE	@icsToken int;
DECLARE	@tmToken int;
DECLARE	@uniToken int;
DECLARE	@itemshopPresetID int;


DECLARE @paintDef int;


DECLARE db_cursor CURSOR FOR 
SELECT paintName,paintColor,tierType,techLevel,nicPrice, asiToken,tmToken,icsToken,uniToken,itemshopPresetID  
FROM #PAINTS


OPEN db_cursor  
FETCH NEXT FROM db_cursor INTO  @paintName,@paintColor,@tierType,@techLevel,@nicPrice,@asiToken,@tmToken,@icsToken,@uniToken,@itemshopPresetID

WHILE @@FETCH_STATUS = 0  
BEGIN  
	--insert 'paint' definition -- use attribute/category flags of lottery item -- description of gift
	INSERT INTO [dbo].[entitydefaults]
           ([definitionname],[quantity],[attributeflags],[categoryflags],[options],[note],[enabled],[volume],[mass],[hidden],[health],[descriptiontoken],[purchasable],[tiertype],[tierlevel])
     VALUES
           (@paintName,1,2052,1179,'','Paint',1,0.000001,0.000001,0,100,'def_anniversary_package_desc',1,@tierType,@techLevel);

	SET @paintDef = (SELECT TOP 1 definition from entitydefaults where definitionname=@paintName);

	--insert defConfig to configure color of paint
	INSERT INTO [dbo].[definitionconfig]
           ([definition],[tint],[note])
     VALUES
           (@paintDef,@paintColor,'Paint Color');

	--insert Syndicate shop orders
	INSERT INTO [dbo].[itemshop]
           ([presetid],[targetdefinition],[targetamount],[tmcoin],[icscoin],[asicoin],[credit],[unicoin],[globallimit],[purchasecount],[standing])
     VALUES
           (@itemshopPresetID,@paintDef,1,NULL,NULL,NULL,@nicPrice,NULL,NULL,0,NULL),
		   (@betaTM,@paintDef,1,@tmToken,@icsToken,@asiToken,NULL,@uniToken,NULL,0,NULL),
		   (@betaASI,@paintDef,1,@tmToken,@icsToken,@asiToken,NULL,@uniToken,NULL,0,NULL),
		   (@betaICS,@paintDef,1,@tmToken,@icsToken,@asiToken,NULL,@uniToken,NULL,0,NULL);

      FETCH NEXT FROM db_cursor INTO  @paintName,@paintColor,@tierType,@techLevel,@nicPrice,@asiToken,@icsToken,@tmToken,@uniToken,@itemshopPresetID
END 

CLOSE db_cursor  
DEALLOCATE db_cursor

DROP TABLE #PAINTS

GO



---------------------------------------------
---------------ORANGE HUE TWEAK---------------

PRINT N'UPDATE orange hue in def-config'
DECLARE @paintDef int;
SET @paintDef = (SELECT TOP 1 definition from entitydefaults where definitionname='def_paint_orange');

--update tint in config
UPDATE [dbo].[definitionconfig]
SET tint = '#fb6701'
WHERE definition=@paintDef;


GO

---------------------------------------------


----------------PAINT TOKEN COST FIX------------------------
-----Create All Paint defintions, configs(color), and seed in Syndicate shops
PRINT N'PAINT -- UPDATE -- FIX TOKEN MIXUP';
DECLARE @alphaItemShop int;

SET @alphaItemShop = (SELECT TOP 1 id FROM itemshoppresets WHERE name like 'tm_preset_pve');

CREATE TABLE #PAINTS
(
	paintName varchar(100),
	paintColor varchar(50),
	tierType int,
	techLevel int,
	nicPrice int, 
	asiToken int,
	tmToken int,
	icsToken int,
	uniToken int,
	itemshopPresetID int
)

INSERT INTO #PAINTS VALUES
('def_paint_black','#010101',NULL,NULL,10000000,333,333,333,NULL,@alphaItemShop),
('def_paint_blue_dark','#010133',NULL,NULL,10000000,19,19,962,NULL,@alphaItemShop),
('def_paint_blue','#0101fb',NULL,NULL,10000000,4,4,992,NULL,@alphaItemShop),
('def_paint_green_dark','#013301',NULL,NULL,10000000,19,962,19,NULL,@alphaItemShop),
('def_paint_teal','#01c997',NULL,NULL,10000000,3,569,428,NULL,@alphaItemShop),
('def_paint_green','#01fb01',NULL,NULL,10000000,4,992,4,NULL,@alphaItemShop),
('def_paint_cyan','#01fbfb',NULL,NULL,10000000,2,499,499,NULL,@alphaItemShop),
('def_paint_red_dark','#650101',NULL,NULL,10000000,981,10,10,NULL,@alphaItemShop),
('def_paint_purple','#6501fb',NULL,NULL,10000000,286,3,711,NULL,@alphaItemShop),
('def_paint_gray','#979797',NULL,NULL,10000000,333,333,333,NULL,@alphaItemShop),
('def_paint_red','#fb0101',NULL,NULL,10000000,992,4,4,NULL,@alphaItemShop),
('def_paint_magenta','#fb01fb',NULL,NULL,10000000,499,2,499,NULL,@alphaItemShop),
('def_paint_orange','#fb6701',NULL,NULL,10000000,623,375,2,NULL,@alphaItemShop),
('def_paint_yellow','#fbfb01',NULL,NULL,10000000,499,499,2,NULL,@alphaItemShop),
('def_paint_white','#fbfbfb',NULL,NULL,10000000,333,333,333,NULL,@alphaItemShop);


DECLARE @paintName varchar(100);
DECLARE @paintColor varchar(50);
DECLARE @tierType int;
DECLARE @techLevel int;
DECLARE	@nicPrice int; 
DECLARE	@asiToken int;
DECLARE	@icsToken int;
DECLARE	@tmToken int;
DECLARE	@uniToken int;
DECLARE	@itemshopPresetID int;


DECLARE @paintDef int;


DECLARE db_cursor CURSOR FOR 
SELECT paintName,paintColor,tierType,techLevel,nicPrice, asiToken,tmToken,icsToken,uniToken,itemshopPresetID  
FROM #PAINTS


OPEN db_cursor  
FETCH NEXT FROM db_cursor INTO  @paintName,@paintColor,@tierType,@techLevel,@nicPrice,@asiToken,@tmToken,@icsToken,@uniToken,@itemshopPresetID

WHILE @@FETCH_STATUS = 0  
BEGIN  

	SET @paintDef = (SELECT TOP 1 definition from entitydefaults where definitionname=@paintName);

	--Set paint cost on alpha to nicPrice
	UPDATE [dbo].[itemshop]
	SET credit = @nicPrice, tmcoin=NULL, icscoin=NULL, asicoin=NULL, unicoin=NULL
	WHERE targetdefinition=@paintDef AND presetid=@alphaItemShop

	--Set paint to correct token amounts and NULL nic on non-alpha shops
	UPDATE [dbo].[itemshop]
	SET tmcoin=@tmToken, icscoin=@icsToken, asicoin=@asiToken, credit=NULL, unicoin=NULL
	WHERE targetdefinition=@paintDef AND presetid!=@alphaItemShop
		
    FETCH NEXT FROM db_cursor INTO  @paintName,@paintColor,@tierType,@techLevel,@nicPrice,@asiToken,@tmToken,@icsToken,@uniToken,@itemshopPresetID
END 

CLOSE db_cursor  
DEALLOCATE db_cursor

DROP TABLE #PAINTS

GO

--------------------------------------------------------------



-------------SYNDICATE SHOP CHANGES----------------------------

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

-------------------------------------------------------------------------------------



---------------------INTERZONE TELEPORT FIX PART 2 (PART 1 IN LIVE_PATCH_2)----------------

-------mobile IZ teleport Part 2 --  the deployed thing's properties---------
PRINT N'def_mobile_world_teleporter_basic';
DECLARE @definitionID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mobile_world_teleporter_basic' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_mobile_world_teleporter_basic', quantity=1, attributeflags=12583936, categoryflags=33948280, options='', 
                note='', enabled=1, volume=1, mass=1, hidden='False', health=100, descriptiontoken='def_mobile_world_teleporter_basic_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

PRINT N'despawn_time from 900s->600s';
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'despawn_time' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=600000 WHERE id =  @aggvalueID;

PRINT N'stealth_strength from 25->50rf';
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'stealth_strength' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=50 WHERE id =  @aggvalueID;

GO


------------------------------------------------------------------







-------------------------NPC 'SOLO SPAWNS' SPAWNTIMER UPDATE/FIX-------------

DECLARE @presenceID int
DECLARE @flockID int;
DECLARE @definitionID int;

---numiquol on hershfield respawn timer 30 seconds to 60 seconds
PRINT N'numiquol on hershfield respawn timer 30 seconds to 60 seconds';

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Hershfield numi Solo Spawn 1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Hershfield numi Solo Spawn 1',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_cameleon_interceptor_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Cam_hersh_solospawn1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Cam_hersh_solospawn1' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1373, [spawnoriginY] = 437 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'Cam_hersh_solospawn1', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_dps_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'yagel_hersh_solospawn1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'yagel_hersh_solospawn1' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1373, [spawnoriginY] = 437 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'yagel_hersh_solospawn1', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Hershfield numi Solo Spawn 2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Hershfield numi Solo Spawn 2',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_dps_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'arby_hersh_solospawn2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'arby_hersh_solospawn2' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1395, [spawnoriginY] = 700 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'arby_hersh_solospawn2', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_dps_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'yagel_hersh_solospawn2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'yagel_hersh_solospawn2' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1395, [spawnoriginY] = 700 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'yagel_hersh_solospawn2', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Hershfield numi Solo Spawn 3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Hershfield numi Solo Spawn 3',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_dps_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'kain_hersh_solospawn3' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'kain_hersh_solospawn3' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1254, [spawnoriginY] = 704 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'kain_hersh_solospawn3', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vagabond_jammer_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'vagabond_hersh_solospawn3' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'vagabond_hersh_solospawn3' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1254, [spawnoriginY] = 704 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'vaga_hersh_solospawn3', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Hershfield numi Solo Spawn 4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Hershfield numi Solo Spawn 4',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_hybrid_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mesmer_hersh_solospawn4' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mesmer_hersh_solospawn4' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = @definitionID, [spawnoriginX] = 1056, [spawnoriginY] = 566 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'mesmer_hersh_solospawn4', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;


---Pelistal on Hershfield respawn timer 30 seconds to 60 seconds
PRINT N'Pelistal on Hershfield respawn timer 30 seconds to 60 seconds';
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Hershfield Pelistal Solo Spawn 1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Hershfield Pelistal Solo Spawn 1',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ictus_dps_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Ictus_at_solo1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Ictus_at_solo1' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1122, [spawnoriginY] = 1409 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'Ictus_at_solo1', [respawnmultiplierlow] = 0, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_dps_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Tyra_at_solo1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Tyra_at_solo1' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 1122, [spawnoriginY] = 1409 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'Tyro_at_solo1', [respawnmultiplierlow] = 0, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Hershfield Pelistal Solo Spawn 2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Hershfield Pelistal Solo Spawn 2',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_waspish_dps_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Wasp_Pelistal_solo2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Wasp_Pelistal_solo2' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 840, [spawnoriginY] = 1621 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'Wasp_Pelistal_solo2', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_castel_dps_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'castel_Pelistal_solo2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'castel_Pelistal_solo2' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 840, [spawnoriginY] = 1621 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'Castel_pelistal_solo2', [respawnmultiplierlow] = 0, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Hershfield Pelistal Solo Spawn 3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Hershfield Pelistal Solo Spawn 3',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_hybrid_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Gropho_Pelistal_Hersh_Solo3' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'Gropho_Pelistal_Hersh_Solo3' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = @definitionID, [spawnoriginX] = 835, [spawnoriginY] = 1513 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'Gropho_Pelistal_Hersh_Solo3', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Hershfield Pelistal Solo Spawn 4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Hershfield Pelistal Solo Spawn 4',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_troiar_interceptor_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'troiar_hersh_solo4' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'troiar_hersh_solo4' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 752, [spawnoriginY] = 1578 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'troiar_hersh_solo4', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_castel_dps_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'castel_Hersh_solo4' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'castel_Hersh_solo4' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 752, [spawnoriginY] = 1578 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'castel_Hersh_solo4', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

---Theo Solo spawn on Hershfield respawn timer 30 seconds to 60 seconds
PRINT N'Theo Solo spawn on Hershfield respawn timer 30 seconds to 60 seconds';
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Hershfield theo Solo Spawn 1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Hershfield theo Solo Spawn 1',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_intakt_interceptor_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'intakt_Hersh_theo_spawn1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'intakt_Hersh_theo_spawn1' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 642, [spawnoriginY] = 881 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'intakt_Hersh_theo_spawn1', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_prometheus_scout_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'prom_Hersh_theo_spawn1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'prom_Hersh_theo_spawn1' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 642, [spawnoriginY] = 881 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'prom_Hersh_theo_spawn1', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Hershfield theo Solo Spawn 2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Hershfield theo Solo Spawn 2',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_baphomet_scout_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'baph_hersh_theo_spawn2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'baph_hersh_theo_spawn2' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 702, [spawnoriginY] = 768 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'baph_hersh_theo_spawn2', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_prometheus_scout_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'prom_Hersh_theo_spawn2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'prom_Hersh_theo_spawn2' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 702, [spawnoriginY] = 768 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'prom_Hersh_theo_spawn2', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Hershfield theo Solo Spawn 3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Hershfield theo Solo Spawn 3',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_dps_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'arty_hersh_theo_spawn3' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'arty_hersh_theo_spawn3' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 754, [spawnoriginY] = 459 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'arty_hersh_theo_spawn3', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_zenith_dps_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'zenith_hersh_theo_spawn3' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'zenith_hersh_theo_spawn3' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 754, [spawnoriginY] = 459 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'zenith_hersh_theo_spawn3', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'Hershfield theo Solo Spawn 4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'Hershfield theo Solo Spawn 4',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_hybrid_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'seth_hersh_theo_spawn4' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'seth_hersh_theo_spawn4' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = @definitionID, [spawnoriginX] = 340, [spawnoriginY] = 785 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 25 ,[note] = 'seth_hersh_theo_spawn4', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;



GO
