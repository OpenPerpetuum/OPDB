-- Pre-Alpha Patch 6
/*
BEGIN TRANSACTION

ROLLBACK TRANSACTION

COMMIT TRANSACTION

*/


USE perpetuumsa
GO

PRINT N'1. Create entity (from tool)';
--OUTPUT FROM TOOL --WARNING: options string contains references to entitydefaults in hex
--ENTITYDEFAULT SAVE NEW
INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled,  volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
VALUES ( 'def_arkhe2_bot_pink', 1, 0, 257, '#head=iae8#chassis=iae9#leg=iaea#container=i147#tier=$tierlevel_mk2', 'Pink Arkhe Reward for Pre-alpha participation', 1, 12, 0, 'False', 100, 'def_arkhe2_bot_desc', 1, 1, 2); 
GO

PRINT N'2. Create template (from tool)';
--OUTPUT FROM TOOL--WARNING: description string contains references to entitydefaults in hex
--TEMPLATE INSERT
INSERT INTO robottemplates ([name], [description], [note]) 
VALUES ('def_arkhe2_bot_pink_template', '#robot=i15c1#head=iae8#chassis=iae9#leg=iaea#container=i147#headModules=[|m0=[|definition=i0|slot=i1]]#chassisModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]]#legModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]]', 'Pre-Alpha Participant Reward');
GO

PRINT N'3. Create templaterelation';
INSERT INTO [dbo].[robottemplaterelation]
           ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
     VALUES
           ((SELECT TOP 1 definition from entitydefaults where definitionname='def_arkhe2_bot_pink')
           ,(SELECT TOP 1 id from robottemplates where name='def_arkhe2_bot_pink_template'),0,1,0,0,0,'Pre-alpha pink arkhe template relation');
GO

PRINT N'4. Insert config w/ desired tint';
INSERT INTO [dbo].[definitionconfig]
           ([definition],[tint],[note])
     VALUES
           ((SELECT TOP 1 definition from entitydefaults where definitionname='def_arkhe2_bot_pink')
           ,'#FF80FF'
           ,'YAY PINK!');
GO

PRINT N'5. Give bot skills';
--Use existing bot (that was copied from entitydefault) for extensions
INSERT INTO [dbo].[enablerextensions]
           ([definition],[extensionid],[extensionlevel])
     (SELECT (SELECT TOP 1 definition from entitydefaults where definitionname='def_arkhe2_bot_pink'), extensionid, extensionlevel from enablerextensions where definition=(Select top 1 definition from entitydefaults where definitionname='def_arkhe2_bot'));
GO

USE [perpetuumsa]
GO


PRINT N'Create Packages for pre-alpha participant levels';
INSERT INTO [dbo].[packages]
           ([name],[note])
     VALUES
           ('pre-alpha01','standard gift pack for pre-alpha participant'),
		   ('pre-alpha02','advanced gift pack for pre-alpha active community member');
GO

PRINT N'Insert items into Packages for pre-alpha participant levels';
DECLARE @packid int;
SET @packid = (SELECT TOP 1 id from packages where name='pre-alpha01');

DECLARE @aid int;
SET @aid = (SELECT TOP 1 definition from entitydefaults where definitionname='def_anniversary_package');

DECLARE @pinkbot int;
SET @pinkbot = (SELECT TOP 1 definition from entitydefaults where definitionname='def_arkhe2_bot_pink');

PRINT N'Items for pack1';
INSERT INTO [dbo].[packageitems]
           ([packageid],[definition],[quantity])
     VALUES
           (@packid,@aid,3), 
		   (@packid,@pinkbot,1);


PRINT N'Items for pack2';
SET @packid = (SELECT TOP 1 id from packages where name='pre-alpha02');
INSERT INTO [dbo].[packageitems]
           ([packageid],[definition],[quantity])
     VALUES
           (@packid,@aid,5),
		   (@packid,@pinkbot,1);
GO

USE [perpetuumsa]
GO


-------------Balance fix prototype inconsistent mass and slots------------

PRINT N'Balance fixes for prototype inconsistencies as of 3/19/2018';

DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
PRINT N'def_yagel_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_yagel_leg_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_yagel_leg_pr', quantity=1, attributeflags=1024, categoryflags=66384, options='#height=f0.35#slotFlags=420,20,20,20', 
                note='', enabled=1, volume=4, mass=1700, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'def_prometheus_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_chassis_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_prometheus_chassis_pr', quantity=1, attributeflags=1024, categoryflags=66128, options='#height=f0.3#slotFlags=4451,6d1,451,6d3', 
                note='', enabled=1, volume=7, mass=5000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'def_prometheus_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_leg_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_prometheus_leg_pr', quantity=1, attributeflags=1024, categoryflags=66384, options='#height=f0.3#slotFlags=420,20,20,20', 
                note='', enabled=1, volume=4, mass=1700, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'def_cameleon_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_chassis_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_cameleon_chassis_pr', quantity=1, attributeflags=1024, categoryflags=66128, options='#height=f0.3#slotFlags=4651,651,4d0', 
                note='', enabled=1, volume=6, mass=4000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'def_cameleon_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_leg_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_cameleon_leg_pr', quantity=1, attributeflags=1024, categoryflags=66384, options='#height=f0.35#slotFlags=420,20,20', 
                note='', enabled=1, volume=3, mass=800, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'def_arbalest_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_arbalest_chassis_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_arbalest_chassis_pr', quantity=1, attributeflags=1024, categoryflags=131664, options='#height=f0.4#slotFlags=451,451,6d1,451,6d1,52', 
                note='', enabled=1, volume=9, mass=9000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'def_arbalest_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_arbalest_leg_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_arbalest_leg_pr', quantity=1, attributeflags=1024, categoryflags=131920, options='#height=f0.6#slotFlags=420,20,20,20,20', 
                note='', enabled=1, volume=4, mass=2700, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'def_baphomet_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_baphomet_chassis_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_baphomet_chassis_pr', quantity=1, attributeflags=1024, categoryflags=131664, options='#height=f0.5#slotFlags=4451,6d1,451,6d1,51', 
                note='', enabled=1, volume=9, mass=9000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

PRINT N'def_castel_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_castel_leg_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_castel_leg_pr', quantity=1, attributeflags=1024, categoryflags=66384, options='#height=f0.5#slotFlags=420,20,20', 
                note='', enabled=1, volume=4, mass=1700, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'def_kain_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_chassis_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_kain_chassis_pr', quantity=1, attributeflags=1024, categoryflags=197200, options='#height=f0.45#slotFlags=46d1,4d1,6d1,4d1,d2,d2', 
                note='', enabled=1, volume=11, mass=21000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'def_artemis_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_chassis_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_artemis_chassis_pr', quantity=1, attributeflags=1024, categoryflags=197200, options='#height=f0.5#slotFlags=46d1,4d1,6d1,4d3,d2', 
                note='', enabled=1, volume=11, mass=21000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'def_tyrannos_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_tyrannos_chassis_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_tyrannos_chassis_pr', quantity=1, attributeflags=1024, categoryflags=197200, options='#height=f0.5#slotFlags=4d2,d2,d2,d2,6d1,6d1', 
                note='', enabled=1, volume=11, mass=19000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'def_vagabond_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vagabond_chassis_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_vagabond_chassis_pr', quantity=1, attributeflags=1024, categoryflags=197200, options='#height=f0.45#slotFlags=44d1,4d1,d1', 
                note='', enabled=1, volume=8, mass=12000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'def_vagabond_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vagabond_leg_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_vagabond_leg_pr', quantity=1, attributeflags=1024, categoryflags=197456, options='#height=f1.25#slotFlags=420,20,20,20', 
                note='', enabled=1, volume=6, mass=2400, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'def_zenith_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_zenith_chassis_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_zenith_chassis_pr', quantity=1, attributeflags=1024, categoryflags=197200, options='#height=f0.5#slotFlags=44d1,4d1,d1', 
                note='bonuszok csak armor transferre', enabled=1, volume=8, mass=12000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

PRINT N'def_mesmer_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_chassis_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_mesmer_chassis_pr', quantity=1, attributeflags=1024, categoryflags=262736, options='#height=f1.1#slotFlags=46d1,d1,4d1,6d1,d1,4d1,4d0', 
                note='', enabled=1, volume=13, mass=25000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

PRINT N'def_mesmer_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_leg_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_mesmer_leg_pr', quantity=1, attributeflags=1024, categoryflags=262992, options='#height=f0.9#slotFlags=420,20,20,20,20,20', 
                note='', enabled=1, volume=7, mass=4000, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'def_gropho_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_gropho_chassis_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_gropho_chassis_pr', quantity=1, attributeflags=1024, categoryflags=262736, options='#height=f0.8#slotFlags=4d2,d2,6d2,6d2,4d2,4d2,4d0', 
                note='', enabled=1, volume=13, mass=22000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'def_kain_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_leg_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_kain_leg_pr', quantity=1, attributeflags=1024, categoryflags=197456, options='#height=f1.25#slotFlags=420,20,20,20,20', 
                note='', enabled=1, volume=6, mass=3300, hidden='True', health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


PRINT N'def_intakt_chassis_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_chassis_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_intakt_chassis_pr', quantity=1, attributeflags=1024, categoryflags=66128, options='#height=f0.35#slotFlags=4651,651,4d0', 
                note='cloaking core drain bonus', enabled=1, volume=6, mass=4000, hidden='True', health=100, descriptiontoken='bot_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


GO

USE [perpetuumsa]
GO

----------- Create Reimbursement Log-------------
PRINT N'Creating table for reimbursement logging';

CREATE TABLE [dbo].[opp_reimburselog] (
[Id] int NOT NULL IDENTITY(1,1) ,
[ReimburseTo] int NOT NULL ,
[ReimburseBy] int NOT NULL ,
[ReimburseTime] datetime NOT NULL ,
[EntityId] int NOT NULL ,
[ItemType] nvarchar(16) NOT NULL ,
[Qty] int NOT NULL 
)

GO

USE [perpetuumsa]
GO
--For some few items, adjust buy and sell prices of orders on markets 
--For all Markets, children of Outposts and Terminals on Zones NV and Hersh

SELECT eid INTO #RELEVANTMARKETS FROM entities 
WHERE entities.definition=(SELECT TOP 1 definition from entitydefaults where definitionname='def_public_market')
AND entities.parent IN (SELECT eid FROM entities WHERE eid IN
(SELECT eid FROM zoneentities WHERE zoneID in (SELECT id FROM zones WHERE note in ('new virginia', 'hershfield'))) 
AND definition IN (SELECT definition FROM entitydefaults WHERE definitionname in ('def_public_docking_base_pelistal', 'def_public_docking_base_pelistal_outpost_pve')));

--The relevant marketeids
SELECT * FROM #RELEVANTMARKETS


DECLARE @def int;
DECLARE @sellprice float;

PRINT N'def_ammo_artifact_scan_b';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_artifact_scan_b');
SET @sellprice = 1000;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;

PRINT N'def_ammo_artifact_scan_c';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_artifact_scan_c');
SET @sellprice = 2000;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;

PRINT N'def_ammo_longrange_missile_a';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_longrange_missile_a');
SET @sellprice = 111.6;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_ammo_longrange_missile_b';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_longrange_missile_b');
SET @sellprice = 113;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_ammo_longrange_missile_d';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_longrange_missile_d');
SET @sellprice = 131.2;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_ammo_medium_lasercrystal_b';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_medium_lasercrystal_b');
SET @sellprice = 111.6;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_ammo_medium_projectile_a';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_medium_projectile_a');
SET @sellprice = 85.1;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_ammo_medium_projectile_d';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_medium_projectile_d');
SET @sellprice = 91.7;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_ammo_mining_epriton';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_mining_epriton');
SET @sellprice = 25;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;

PRINT N'def_ammo_mining_silgium';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_mining_silgium');
SET @sellprice = 24;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;

PRINT N'def_ammo_mining_stermonit';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_mining_stermonit');
SET @sellprice = 24;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;

PRINT N'def_ammo_mining_titan';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_mining_stermonit');
SET @sellprice = 20;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;

PRINT N'def_ammo_missile_a';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_missile_a');
SET @sellprice = 111.6;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_ammo_missile_b';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_missile_b');
SET @sellprice = 113;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_ammo_missile_c';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_missile_c');
SET @sellprice = 111.6;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_ammo_missile_d';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_missile_d');
SET @sellprice = 131.2;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_ammo_rocket_a';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_rocket_a');
SET @sellprice = 55.8;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_ammo_rocket_b';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_rocket_b');
SET @sellprice = 56.5;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_ammo_rocket_c';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_rocket_c');
SET @sellprice = 55.6;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_ammo_rocket_d';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_rocket_d');
SET @sellprice = 65.6;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_ammo_small_lasercrystal_b';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_small_lasercrystal_b');
SET @sellprice = 55.8;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_ammo_small_projectile_a';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_small_projectile_a');
SET @sellprice = 42.6;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_ammo_small_projectile_d';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_ammo_small_projectile_d');
SET @sellprice = 45.8;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_castel_bot';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_castel_bot');
SET @sellprice = 584925;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_common_reactor_plasma';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_common_reactor_plasma');
SET @sellprice = 225;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_pelistal_reactor_plasma';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_pelistal_reactor_plasma');
SET @sellprice = 250;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;


PRINT N'def_standard_damage_mod_missile';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_standard_damage_mod_missile');
SET @sellprice = 146850;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_standard_gang_assist_core_management_module';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_standard_gang_assist_core_management_module');
SET @sellprice = 260700;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_standard_gang_assist_siege_module';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_standard_gang_assist_siege_module');
SET @sellprice = 248250;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_standard_medium_energy_neutralizer';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_standard_medium_energy_neutralizer');
SET @sellprice = 293700;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_standard_medium_shield_generator';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_standard_medium_shield_generator');
SET @sellprice = 521400;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_standard_missile_launcher';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_standard_missile_launcher');
SET @sellprice = 125400;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_standard_rocket_launcher';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_standard_rocket_launcher');
SET @sellprice = 62700;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_standard_shield_hardener';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_standard_shield_hardener');
SET @sellprice = 294525;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_standard_small_energy_neutralizer';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_standard_small_energy_neutralizer');
SET @sellprice = 146850;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_standard_small_shield_generator';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_standard_small_shield_generator');
SET @sellprice = 260700;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_standard_thermal_kers';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_standard_thermal_kers');
SET @sellprice = 293700;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_standard_thrm_armor_hardener';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_standard_thrm_armor_hardener');
SET @sellprice = 161700;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;

PRINT N'def_waspish_bot';
SET @def = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_waspish_bot');
SET @sellprice = 1843875;
UPDATE marketitems SET price = @sellprice
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=1 and isvendoritem=1;
UPDATE marketitems SET price = @sellprice/10.0
WHERE itemdefinition = @def and marketeid in (SELECT eid FROM #RELEVANTMARKETS)
and isSell=0 and isvendoritem=1;


DROP TABLE #RELEVANTMARKETS;
GO

USE perpetuumsa
GO

PRINT N'Updates/Deletes of NV red roamers';
PRINT N'Update presence tma_antiafksequerscum3';
DECLARE @presenceID int
DECLARE @flockID int;
DECLARE @definitionID int;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'tma_antiafksequerscum3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'tma_antiafksequerscum3',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = 'ezek mennek a tengerparton korbe meg be',[spawnid] = 1,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 1800,[presencetype] = 1,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

PRINT N'Update flock tmaroamingsequer6 where npc was def_npc_argano_basic_rank1';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'tmaroamingsequer6' ORDER BY id DESC);

UPDATE [dbo].[npcflock] SET [name] = 'tmaroamingsequer6' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 0, [spawnoriginY] = 0 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 1800, [totalspawncount] = 0, [homerange] = 50 ,[note] = 'tmaroamingsequer6', [respawnmultiplierlow] = 0, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;


PRINT N'DELETE flock tmaroamingsequer7 where npc was def_npc_laird_basic_rank1';
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'tmaroamingsequer7' ORDER BY id DESC);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'tmaroamingsequer7' ORDER BY id DESC);

DELETE FROM [dbo].[npcflock] WHERE id=@flockID;
---DELETE!!----


PRINT N'Update presence tma_antiafksequerscum2';
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'tma_antiafksequerscum2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'tma_antiafksequerscum2',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = 'ezek mennek a tengerparton korbe meg be',[spawnid] = 1,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 1800,[presencetype] = 1,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;


PRINT N'Update flock roamingtmasequer where npc was def_npc_argano_basic_rank1';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'roamingtmasequer' ORDER BY id DESC);

UPDATE [dbo].[npcflock] SET [name] = 'roamingtmasequer' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 800, [spawnoriginY] = 940 ,[spawnrangeMin] = 2, [spawnrangeMax] = 5,[respawnseconds] = 1800, [totalspawncount] = 0, [homerange] = 50 ,[note] = 'NEW FLOCK, WRITE NOTE!', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;


PRINT N'DELETE flock roamingtmasequer2 where npc was def_npc_laird_basic_rank1';
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'roamingtmasequer2' ORDER BY id DESC);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'roamingtmasequer2' ORDER BY id DESC);

DELETE FROM [dbo].[npcflock] WHERE id=@flockID;
---DELETE!!----

PRINT N'Update presence tma_antiafksequerscum';
SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'tma_antiafksequerscum' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'tma_antiafksequerscum',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = 'ezek mennek a tengerparton korbe meg be',[spawnid] = 1,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 1800,[presencetype] = 1,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;


PRINT N'Update flock the_joker_is_me where npc was def_npc_argano_basic_rank1';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'the_joker_is_me' ORDER BY id DESC);

UPDATE [dbo].[npcflock] SET [name] = 'the_joker_is_me' ,[presenceid] = @presenceID, [flockmembercount] = 1, [definition] = @definitionID, [spawnoriginX] = 0, [spawnoriginY] = 0 ,[spawnrangeMin] = 0, [spawnrangeMax] = 10,[respawnseconds] = 1800, [totalspawncount] = 0, [homerange] = 50 ,[note] = 'the_joker_is_me', [respawnmultiplierlow] = 1, [enabled] = 1, [iscallforhelp] = 1, [behaviorType] = 2 WHERE id=@flockID;


PRINT N'DELETE flock the_joker_is_me2 where npc was def_npc_laird_basic_rank1';
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'the_joker_is_me2' ORDER BY id DESC);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'the_joker_is_me2' ORDER BY id DESC);

DELETE FROM [dbo].[npcflock] WHERE id=@flockID;
---DELETE!!----


GO

USE [perpetuumsa]
GO

PRINT N'Robot Template updates for training rewards';

PRINT N'baphomet_starterpack';
DECLARE @templateID int;
SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'baphomet_starterpack' ORDER BY id DESC)

UPDATE robottemplates SET name='baphomet_starterpack', description='#robot=ica#head=i61#chassis=i62#leg=i63#container=i148#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i2b|slot=i2]|m2=[|definition=i38f|slot=i3]|m3=[|definition=i38f|slot=i4]]#chassisModules=[|m0=[|definition=i39|slot=i1|ammoDefinition=i112|ammoQuantity=i78]|m1=[|definition=i39|slot=i2|ammoDefinition=i112|ammoQuantity=i78]|m2=[|definition=i39|slot=i3|ammoDefinition=i112|ammoQuantity=i78]|m3=[|definition=i39|slot=i4|ammoDefinition=i112|ammoQuantity=i78]|m4=[|definition=i39|slot=i5|ammoDefinition=i112|ammoQuantity=i78]]#legModules=[|m0=[|definition=i12|slot=i1]|m1=[|definition=ie|slot=i2]|m2=[|definition=i1b|slot=i3]|m3=[|definition=i19|slot=i4]]#items=[|i0=[|definition=i112|quantity=i1f4|repackaged=i0]]', note='' WHERE id=@templateID;

PRINT N'arbalest_starterpack';
SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'arbalest_starterpack' ORDER BY id DESC)

UPDATE robottemplates SET name='arbalest_starterpack', description='#robot=ic9#head=i5e#chassis=i5f#leg=i60#container=i148#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i38d|slot=i2]|m2=[|definition=i38d|slot=i3]|m3=[|definition=i424|slot=i4]]#chassisModules=[|m0=[|definition=i42|slot=i1|ammoDefinition=ifa|ammoQuantity=i32]|m1=[|definition=i42|slot=i2|ammoDefinition=ifa|ammoQuantity=i32]|m2=[|definition=i42|slot=i3|ammoDefinition=ifa|ammoQuantity=i32]|m3=[|definition=i42|slot=i4|ammoDefinition=ifa|ammoQuantity=i32]|m4=[|definition=i42|slot=i5|ammoDefinition=ifa|ammoQuantity=i32]]#legModules=[|m0=[|definition=i12|slot=i1]|m1=[|definition=ie|slot=i2]|m2=[|definition=i12|slot=i3]|m3=[|definition=i29|slot=i4]]#items=[|i0=[|definition=ifa|quantity=i1f4|repackaged=i0]]', note='' WHERE id=@templateID;

PRINT N'waspish_starterpack';
SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'waspish_starterpack' ORDER BY id DESC)

UPDATE robottemplates SET name='waspish_starterpack', description='#robot=ic4#head=i4f#chassis=i50#leg=i51#container=i148#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i2b|slot=i2]|m2=[|definition=i38e|slot=i3]|m3=[|definition=i1f|slot=i4]]#chassisModules=[|m0=[|definition=i3f|slot=i1|ammoDefinition=i11e|ammoQuantity=i14]|m1=[|definition=i3f|slot=i2|ammoDefinition=i11e|ammoQuantity=i14]|m2=[|definition=i3f|slot=i3|ammoDefinition=i11e|ammoQuantity=i14]|m3=[|definition=i3f|slot=i4|ammoDefinition=i11e|ammoQuantity=i14]|m4=[|definition=i3f|slot=i5|ammoDefinition=i11e|ammoQuantity=i14]]#legModules=[|m0=[|definition=i12|slot=i1]|m1=[|definition=ie|slot=i2]|m2=[|definition=i1c|slot=i3]|m3=[|definition=i29|slot=i4]]#items=[|i0=[|definition=i11e|quantity=i1f4|repackaged=i0]]', note='' WHERE id=@templateID;


PRINT N'Updates to pelistal training rewards';

UPDATE [dbo].[trainingrewards]
   SET [level] = 1
      ,[definition] = (SELECT definition FROM entitydefaults WHERE definitionname='def_ammo_rocket_a')
      ,[quantity] = 250
      ,[robottemplateid] = NULL
      ,[raceid] = 1
 WHERE raceid=1 and level=1 and quantity=2500 and definition=(SELECT definition FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_a');

UPDATE [dbo].[trainingrewards]
   SET [level] = 1
      ,[definition] = (SELECT definition FROM entitydefaults WHERE definitionname='def_ammo_rocket_b')
      ,[quantity] = 250
      ,[robottemplateid] = NULL
      ,[raceid] = 1
 WHERE raceid=1 and level=1 and quantity=2500 and definition=(SELECT definition FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_b');

 UPDATE [dbo].[trainingrewards]
   SET [level] = 1
      ,[definition] = (SELECT definition FROM entitydefaults WHERE definitionname='def_ammo_rocket_c')
      ,[quantity] = 250
      ,[robottemplateid] = NULL
      ,[raceid] = 1
 WHERE raceid=1 and level=1 and quantity=2500 and definition=(SELECT definition FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_c');

UPDATE [dbo].[trainingrewards]
   SET [level] = 1
      ,[definition] = (SELECT definition FROM entitydefaults WHERE definitionname='def_ammo_rocket_d')
      ,[quantity] = 250
      ,[robottemplateid] = NULL
      ,[raceid] = 1
 WHERE raceid=1 and level=1 and quantity=2500 and definition=(SELECT definition FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_d');

SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'waspish_starterpack' ORDER BY id DESC)
 UPDATE [dbo].[trainingrewards]
   SET [level] = 4
      ,[definition] = NULL
      ,[quantity] = NULL
      ,[robottemplateid] = @templateID
      ,[raceid] = 1
 WHERE raceid=1 and level=3 and robottemplateid =@templateID

GO


PRINT N'Insert Addl skills on trainingexit';

DECLARE @extid int;


SET @extid = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname='ext_core_management');

PRINT N'Insert ext_core_management skill to races 1-3';

INSERT INTO [dbo].[cw_race_extension]
           ([raceid],[extensionid],[levelincrement])
     VALUES
           (1,@extid,2);

INSERT INTO [dbo].[cw_race_extension]
           ([raceid],[extensionid],[levelincrement])
     VALUES
           (2,@extid,2);

INSERT INTO [dbo].[cw_race_extension]
           ([raceid],[extensionid],[levelincrement])
     VALUES
           (3,@extid,2);


SET @extid = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname='ext_shield_operation');

PRINT N'Insert ext_shield_operation skill to race 1';	   

INSERT INTO [dbo].[cw_race_extension]
           ([raceid],[extensionid],[levelincrement])
     VALUES
           (1,@extid,4);


SET @extid = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname='ext_shield_upgrades');

PRINT N'Insert ext_shield_upgrades skill to race 1';	 


INSERT INTO [dbo].[cw_race_extension]
           ([raceid],[extensionid],[levelincrement])
     VALUES
           (1,@extid,1);


SET @extid = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname='ext_hull_upgrades');

PRINT N'Insert ext_hull_upgrades skill to race 3';	 

 INSERT INTO [dbo].[cw_race_extension]
           ([raceid],[extensionid],[levelincrement])
     VALUES
           (3,@extid,1);



SET @extid = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname='ext_weapon_cpu_upgrade');

PRINT N'Insert ext_weapon_cpu_upgrade skill to races 1-3';	 

INSERT INTO [dbo].[cw_race_extension]
           ([raceid],[extensionid],[levelincrement])
     VALUES
           (1,@extid,1);

INSERT INTO [dbo].[cw_race_extension]
           ([raceid],[extensionid],[levelincrement])
     VALUES
           (2,@extid,1);

INSERT INTO [dbo].[cw_race_extension]
           ([raceid],[extensionid],[levelincrement])
     VALUES
           (3,@extid,1);


GO

USE [perpetuumsa]
GO

-----Pelistal Enwar bots reduce accum recharge time bonus per level from 4% to 2%-----
PRINT N'Bonuses for accum on green enwar to -0.02';
DECLARE @definitionID int;
DECLARE @extensionID int;
DECLARE @aggfieldID int;
DECLARE @chassisbonusID int;
DECLARE @bonus float;

SET @bonus = -0.02;

PRINT N'def_troiar_leg_pr';
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_pelistal_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_troiar_leg_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'core_recharge_time_modifier' ORDER BY [name] DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=@bonus WHERE id = @chassisbonusID;

PRINT N'def_troiar_leg';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_troiar_leg' ORDER BY definition DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=@bonus WHERE id = @chassisbonusID;

PRINT N'def_ictus_leg_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ictus_leg_pr' ORDER BY definition DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=@bonus WHERE id = @chassisbonusID;

PRINT N'def_ictus_leg';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ictus_leg' ORDER BY definition DESC);
SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=@bonus WHERE id = @chassisbonusID;

GO


