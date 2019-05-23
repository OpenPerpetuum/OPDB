---------------------------------------------
--Patch 10
--Live applied 2019/04/14
--
--Files included in order:
--01_Content_Hersh_NPCs_Callisto_and_more__2019_03_02.sql
--02_Content_Hersh_NPCs_Callisto_and_more__2019_04_03.sql
--20190215T061300Z_remove_temp_stronghold_teleport.sql
--20190401T202900Z_welcome_mail.sql
--ChassisBonus_ZenithIntakt_Sensor_lock_range_fix_tobonus__2019_03_02.sql
--Epriton_Field_reductions_to_10__2019_03_10.sql
--npcflocks_ALTER_addCol_npcSpecialType__2019_03_25.sql
--NPCLoot_Ikarus_eche_legatus_updates__2019_03_02.sql
--OPP_Anniversary_gift_robot__2019_03_30.sql
--Relics_init_all__2019_02_27.sql
--ScannerAmmo_aggvalues__2019_03_02.sql
--ZoneEntities_remove_stronghold_tele_column__2019_04_01.sql
---------------------------------------



-----------------------------------------------
--01_Content_Hersh_NPCs_Callisto_and_more__2019_03_02.sql
-----------------------------------------------


USE [perpetuumsa]
GO

------------------------------------------
--Content Team updates circa Feb-March
--Hershfield and Syndicate bot adds, updates, and adjustments
--Create new Callisto npc definitions
--Rework presences and flocks
--Loot tweaks
-----------------------------------------


PRINT N'Define New Callisto NPCs!';


DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
DECLARE @templateID int;
DECLARE @lootdefinitionID int;
DECLARE @npclootID int;

----Creation to Entity Defaults

INSERT INTO entitydefaults ( definitionname ,  quantity ,  attributeflags ,  categoryflags ,  options ,  note ,  enabled ,  volume ,  mass ,  hidden , 
                health ,  descriptiontoken ,  purchasable ,  tiertype ,  tierlevel ) 
                VALUES ( 'def_npc_callisto_buccaneer_rank1', 1, 1024, 911, '', '', 1, 0, 0, 0, 100, 'def_npc_zenith_heavyew_rank2_desc', 0, 0, 0); 

INSERT INTO entitydefaults ( definitionname ,  quantity ,  attributeflags ,  categoryflags ,  options ,  note ,  enabled ,  volume ,  mass ,  hidden , 
                health ,  descriptiontoken ,  purchasable ,  tiertype ,  tierlevel ) 
                VALUES ( 'def_npc_callisto_buccaneer_rank2', 1, 1024, 911, '', '', 1, 0, 0, 0, 100, 'def_npc_zenith_heavyew_rank3_desc', 0, 0, 0); 

INSERT INTO entitydefaults ( definitionname ,  quantity ,  attributeflags ,  categoryflags ,  options ,  note ,  enabled ,  volume ,  mass ,  hidden , 
                health ,  descriptiontoken ,  purchasable ,  tiertype ,  tierlevel ) 
                VALUES ( 'def_npc_callisto_buccaneer_rank3', 1, 1024, 911, '', '', 1, 0, 0, 0, 100, 'def_npc_zenith_heavyew_rank4_desc', 0, 0, 0); 

INSERT INTO entitydefaults ( definitionname ,  quantity ,  attributeflags ,  categoryflags ,  options ,  note ,  enabled ,  volume ,  mass ,  hidden , 
                health ,  descriptiontoken ,  purchasable ,  tiertype ,  tierlevel ) 
                VALUES ( 'def_npc_callisto_buccaneer_rank4', 1, 1024, 911, '', '', 1, 0, 0, 0, 100, 'def_npc_zenith_dps_rank5_desc', 0, 0, 0); 


----Update Aggregate fields
---Rank1
PRINT N'Callisto rank 1 - NPC modifiers';

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_callisto_buccaneer_rank1' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_npc_callisto_buccaneer_rank1', quantity=1, attributeflags=1024, categoryflags=911, options='', 
                note='', enabled=1, volume=0, mass=0, hidden=0, health=100, descriptiontoken='def_npc_zenith_heavyew_rank2_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.95);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'optimal_range_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.1);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.8);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'received_repaired_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.1);

---Rank2
PRINT N'Callisto rank 2 - NPC modifiers';

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_callisto_buccaneer_rank2' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_npc_callisto_buccaneer_rank2', quantity=1, attributeflags=1024, categoryflags=911, options='', 
                note='', enabled=1, volume=0, mass=0, hidden=0, health=100, descriptiontoken='def_npc_zenith_heavyew_rank3_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.3);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.2);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_recharge_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.8);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.2);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'falloff_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.2);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locking_range_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.1);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locking_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.9);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'missile_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.9);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'optimal_range_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.2);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'turret_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.9);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'received_repaired_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.1);

---Rank3
PRINT N'Callisto rank 3 - NPC modifiers';

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_callisto_buccaneer_rank3' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_npc_callisto_buccaneer_rank3', quantity=1, attributeflags=1024, categoryflags=911, options='', 
                note='', enabled=1, volume=0, mass=0, hidden=0, health=100, descriptiontoken='def_npc_zenith_heavyew_rank4_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.5);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.3);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_recharge_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.7);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.3);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'falloff_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.3);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locking_range_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.1);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locking_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.9);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'missile_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.8);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'optimal_range_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.3);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'turret_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.8);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'received_repaired_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.1);


---Rank4
PRINT N'Callisto rank 4 - NPC modifiers';

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_callisto_buccaneer_rank4' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_npc_callisto_buccaneer_rank4', quantity=1, attributeflags=1024, categoryflags=911, options='', 
                note='', enabled=1, volume=0, mass=0, hidden=0, health=100, descriptiontoken='def_npc_zenith_dps_rank5_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.7);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.5);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_recharge_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.7);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.5);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'falloff_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.3);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locking_range_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.5);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locking_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.7);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'missile_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.7);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'optimal_range_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.3);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'turret_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.7);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'received_repaired_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.1);

----Template Creation
PRINT N'Callisto NPC Template';

INSERT INTO robottemplates ([name], [description], [note]) VALUES ('Callisto_EW', '#robot=i1590#head=i1591#chassis=i1592#leg=i1593#container=i149#headModules=[|m0=[|definition=i32|slot=i1]|m1=[|definition=i33|slot=i2]|m2=[|definition=i31|slot=i3]|m3=[|definition=i0|slot=i4]]#chassisModules=[|m0=[|definition=i24|slot=i1]|m1=[|definition=i24|slot=i2]|m2=[|definition=i3d|slot=i3|ammoDefinition=i988|ammoQuantity=i96]]#legModules=[|m0=[|definition=i12a|slot=i1]|m1=[|definition=i13|slot=i2]|m2=[|definition=i18|slot=i3]|m3=[|definition=i1a|slot=i4]|m4=[|definition=i1b|slot=i5]]', 'EW version ranks 1-4')

----Template/Relation Creation

PRINT N'Callisto NPC Template rank 1 relation';
SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'Callisto_EW' ORDER BY id DESC)

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_callisto_buccaneer_rank1' ORDER BY definition DESC);

INSERT INTO [dbo].[robottemplaterelation] ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
                VALUES (@definitionID,@templateID,0,0,0,0,0,'Callisto Rank1 NPC');
PRINT N'Callisto NPC Template rank 2 relation';
SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'Callisto_EW' ORDER BY id DESC)

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_callisto_buccaneer_rank2' ORDER BY definition DESC);

INSERT INTO [dbo].[robottemplaterelation] ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
                VALUES (@definitionID,@templateID,0,0,0,0,0,'Callisto Rank2 NPC');

PRINT N'Callisto NPC Template rank 3 relation';
SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'Callisto_EW' ORDER BY id DESC)


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_callisto_buccaneer_rank3' ORDER BY definition DESC);

INSERT INTO [dbo].[robottemplaterelation] ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
                VALUES (@definitionID,@templateID,0,0,0,0,0,'Callisto Rank3 NPC ');
PRINT N'Callisto NPC Template rank 4 relation';
SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'Callisto_EW' ORDER BY id DESC)

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_callisto_buccaneer_rank4' ORDER BY definition DESC);

INSERT INTO [dbo].[robottemplaterelation] ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
                VALUES (@definitionID,@templateID,0,0,0,0,0,'Callisto Rank4 NPC');

----Template/Relation Update
PRINT N'Callisto NPC Template rank 1 relation update';
SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'Callisto_EW' ORDER BY id DESC)

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_callisto_buccaneer_rank1' ORDER BY definition DESC);

UPDATE [dbo].[robottemplaterelation] SET [templateid] = @templateID,[itemscoresum] = 0,[raceid] = 0,
                [missionlevel] = NULL,[missionleveloverride] = NULL,[killep] = 3 ,[note] = 'Callisto Rank1 NPC' WHERE [definition] = @definitionID;
PRINT N'Callisto NPC Template rank 2 relation update';
SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'Callisto_EW' ORDER BY id DESC)

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_callisto_buccaneer_rank2' ORDER BY definition DESC);

UPDATE [dbo].[robottemplaterelation] SET [templateid] = @templateID,[itemscoresum] = 0,[raceid] = 0,
                [missionlevel] = NULL,[missionleveloverride] = NULL,[killep] = 3 ,[note] = 'Callisto Rank2 NPC' WHERE [definition] = @definitionID;
PRINT N'Callisto NPC Template rank 3 relation update';
SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'Callisto_EW' ORDER BY id DESC)

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_callisto_buccaneer_rank3' ORDER BY definition DESC);

UPDATE [dbo].[robottemplaterelation] SET [templateid] = @templateID,[itemscoresum] = 0,[raceid] = 0,
                [missionlevel] = NULL,[missionleveloverride] = NULL,[killep] = 3 ,[note] = 'Callisto Rank3 NPC ' WHERE [definition] = @definitionID;
PRINT N'Callisto NPC Template rank 4 relation update';
SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'Callisto_EW' ORDER BY id DESC)

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_callisto_buccaneer_rank4' ORDER BY definition DESC);

UPDATE [dbo].[robottemplaterelation] SET [templateid] = @templateID,[itemscoresum] = 0,[raceid] = 0,
                [missionlevel] = NULL,[missionleveloverride] = NULL,[killep] = 3 ,[note] = 'Callisto Rank4 NPC' WHERE [definition] = @definitionID;


----NPC Loots!

---Rank1
PRINT N'Callisto NPC loot rank 1';

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_callisto_buccaneer_rank1' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_sensor_dampener' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.1, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_armor_repairer' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.1, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_sensor_jammer' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.005, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_sensor_dampener' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.005, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 20, 0.5, 0,0, 10);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_advanced' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 10, 0.5, 0,0, 5);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_sensor_jammer' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.1, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_resistant_plating' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.1, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_resistant_plating' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.005, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_webber' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.1, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_energy_vampire' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.1, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_energy_vampire' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.005, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_webber' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.005, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_1' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.01, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_2' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.01, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_3' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.005, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_4' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.005, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 225, 1, 0,1, 175);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 125, 1, 1,1, 80);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_shield_generator' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.1, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_shield_generator' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.005, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_detection_modul' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_detection_modul' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.005, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_stealth_modul' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_stealth_modul' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.005, 0,0, 1);

---Rank2
PRINT N'Callisto NPC loot rank 2';

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_callisto_buccaneer_rank2' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_sensor_dampener' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.1, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_armor_repairer' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.1, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_sensor_jammer' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.005, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_sensor_dampener' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.005, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 35, 0.5, 0,0, 20);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_advanced' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 20, 0.5, 0,0, 10);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_sensor_jammer' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.1, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_resistant_plating' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.1, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_resistant_plating' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.005, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_webber' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.1, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_energy_vampire' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.1, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_energy_vampire' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.005, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_webber' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.005, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_1' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.1, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_2' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.1, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_3' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_4' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 275, 1, 0,1, 200);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 200, 1, 1,1, 150);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_shield_generator' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.1, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_shield_generator' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.005, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_detection_modul' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_detection_modul' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.005, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_stealth_modul' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_stealth_modul' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.005, 0,0, 1);

---Rank 3
PRINT N'Callisto NPC loot rank 3';

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_callisto_buccaneer_rank3' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 125, 1, 0,1, 75);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_energy_vampire' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.025, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_resistant_plating' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.025, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_sensor_dampener' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.025, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_sensor_jammer' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.025, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_webber' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.025, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_3' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.02, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_4' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.02, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_5' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.01, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_6' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.01, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_7' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.005, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_8' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.005, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_advanced' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 35, 0.5, 0,0, 25);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 20, 0.5, 0,0, 10);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_expert' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 15, 0.5, 0,0, 5);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_armor_repairer' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.15, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_energy_vampire' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.15, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_resistant_plating' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.15, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_sensor_dampener' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.15, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_sensor_jammer' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.15, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_webber' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.15, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 350, 1, 1,1, 300);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_shield_generator' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.15, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_shield_generator' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_shield_generator' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.025, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_energy_vampire' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_resistant_plating' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_sensor_dampener' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_sensor_jammer' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_detection_modul' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.15, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_stealth_modul' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.15, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_stealth_modul' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_detection_modul_pr' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_stealth_modul_pr' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.025, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_detection_modul_pr' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.025, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 350, 1, 1,1, 250);

---Rank 4
PRINT N'Callisto NPC loot rank 4';

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_callisto_buccaneer_rank4' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 350, 1, 0,1, 300);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_energy_vampire' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.01, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_resistant_plating' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.01, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_sensor_dampener' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.01, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_sensor_jammer' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.01, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_10' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.005, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_5' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.02, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_6' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.02, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_7' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.01, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_8' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.01, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_9' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.01, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_advanced' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 25, 0.5, 0,0, 15);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 15, 0.5, 0,0, 5);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_expert' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 35, 0.5, 0,0, 25);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_armor_repairer' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.175, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_energy_vampire' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.175, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_resistant_plating' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.175, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_sensor_dampener' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.175, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_sensor_jammer' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.175, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_webber' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.175, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 350, 1, 0,1, 300);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_shield_generator' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.175, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_detection_modul' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.175, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_stealth_modul' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.175, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_stealth_modul' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.075, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_stealth_modul' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.025, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_stealth_modul' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.01, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_detection_modul' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.075, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_detection_modul' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.025, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_detection_modul' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.01, 0,0, 1);


PRINT N'Callisto NPC stuff done!';
GO


------------------
--Now that the new Callistos are defined we can modify the Hersh spawns!
-----------------

PRINT N'RE-WORK OF ALL HERSH SPAWNS';

USE [perpetuumsa]
GO

DECLARE @presenceID int
DECLARE @flockID int;
DECLARE @definitionID int;


---Disabled Syndicate spawns on Hershfield
PRINT N'Set the Giant Syndicate Presence to DISABLED';

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_syndicate_npcs' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'hershfield_syndicate_npcs',[topx] = 959,[topy] = 283,[bottomx] = 1159,[bottomy] = 483,[note] = '',[spawnid] = 13,[enabled] = 0,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

PRINT N'Set the all old flocks to DISABLED';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mech_at_spawn1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mech_at_spawn1' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = @definitionID, [spawnoriginX] = 1590, [spawnoriginY] = 1550 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mech_at_spawn1', [respawnmultiplierlow] = 1, [enabled] = 0, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'hm_at_spawn1' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'hm_at_spawn1' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = @definitionID, [spawnoriginX] = 1590, [spawnoriginY] = 1550 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'hm_at_spawn1', [respawnmultiplierlow] = 1, [enabled] = 0, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'assault_at_spawn2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'assault_at_spawn2' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = @definitionID, [spawnoriginX] = 1370, [spawnoriginY] = 1720 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'assault_at_spawn2', [respawnmultiplierlow] = 1, [enabled] = 0, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'light_at_spawn2' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'light_at_spawn2' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = @definitionID, [spawnoriginX] = 864, [spawnoriginY] = 962 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'light_at_spawn2', [respawnmultiplierlow] = 1, [enabled] = 0, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'hm_at_spawn3' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'hm_at_spawn3' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 1080, [spawnoriginY] = 1870 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'hm_at_spawn3', [respawnmultiplierlow] = 1, [enabled] = 0, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mech_at_spawn3' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mech_at_spawn3' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = @definitionID, [spawnoriginX] = 1080, [spawnoriginY] = 1870 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mech_at_spawn3', [respawnmultiplierlow] = 1, [enabled] = 0, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mech_at_spawn4' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mech_at_spawn4' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 1410, [spawnoriginY] = 1090 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mech_at_spawn4', [respawnmultiplierlow] = 1, [enabled] = 0, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'light_at_spawn4' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'light_at_spawn4' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = @definitionID, [spawnoriginX] = 1410, [spawnoriginY] = 1090 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'light_at_spawn4', [respawnmultiplierlow] = 1, [enabled] = 0, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'hm_at_spawn5' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'hm_at_spawn5' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = @definitionID, [spawnoriginX] = 1170, [spawnoriginY] = 1020 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'hm_at_spawn5', [respawnmultiplierlow] = 1, [enabled] = 0, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'assault_at_spawn_6' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'assault_at_spawn_6' ,[presenceid] = @presenceID, [flockmembercount] = 4, [definition] = @definitionID, [spawnoriginX] = 1350, [spawnoriginY] = 780 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'assault_at_spawn6', [respawnmultiplierlow] = 1, [enabled] = 0, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ikarus_abstrans_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'lighttrans_at_spawn6' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'lighttrans_at_spawn6' ,[presenceid] = @presenceID, [flockmembercount] = 2, [definition] = @definitionID, [spawnoriginX] = 1350, [spawnoriginY] = 780 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'lighttrans_at_spawn6', [respawnmultiplierlow] = 1, [enabled] = 0, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank1' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'mech_at_spawn7' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'mech_at_spawn7' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 940, [spawnoriginY] = 1111 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'mech_at_spawn7', [respawnmultiplierlow] = 1, [enabled] = 0, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'light_at_spawn8' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'light_at_spawn8' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 760, [spawnoriginY] = 935 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'light_at_spawn8', [respawnmultiplierlow] = 1, [enabled] = 0, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'assault_at_spawn9' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'assault_at_spawn9' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 940, [spawnoriginY] = 590 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'assault_at_spawn9', [respawnmultiplierlow] = 1, [enabled] = 0, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'light_at_spawn10' ORDER BY id DESC);
UPDATE [dbo].[npcflock] SET [name] = 'light_at_spawn10' ,[presenceid] = @presenceID, [flockmembercount] = 3, [definition] = @definitionID, [spawnoriginX] = 1160, [spawnoriginY] = 640 ,[spawnrangeMin] = 0, [spawnrangeMax] = 5,[respawnseconds] = 60, [totalspawncount] = 0, [homerange] = 30 ,[note] = 'light_at_spawn10', [respawnmultiplierlow] = 1, [enabled] = 0, [iscallforhelp] = 1, [behaviorType] = 1 WHERE id=@flockID;


PRINT N'Create new modular NPC Presences - fixes aggro sharing';

INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hershfield_syndicate_npcs1',959,283,1159,483,'',13,1,0,0,0,0,0
			    ,0,0,0,0,1,0);
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hershfield_syndicate_npcs2',959,283,1159,483,'',13,1,0,0,0,0,0
			    ,0,0,0,0,1,0);
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hershfield_syndicate_npcs3',959,283,1159,483,'',13,1,0,0,0,0,0
			    ,0,0,0,0,1,0);
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hershfield_syndicate_npcs4',959,283,1159,483,'',13,1,0,0,0,0,0
			    ,0,0,0,0,1,0);
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hershfield_syndicate_npcs5',959,283,1159,483,'',13,1,0,0,0,0,0
			    ,0,0,0,0,1,0);
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hershfield_syndicate_npcs6',959,283,1159,483,'',13,1,0,0,0,0,0
			    ,0,0,0,0,1,0);
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hershfield_syndicate_npcs7',959,283,1159,483,'',13,1,0,0,0,0,0
			    ,0,0,0,0,1,0);
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hershfield_syndicate_npcs8',959,283,1159,483,'',13,1,0,0,0,0,0
			    ,0,0,0,0,1,0);
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hershfield_syndicate_npcs9',959,283,1159,483,'',13,1,0,0,0,0,0
			    ,0,0,0,0,1,0);
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hershfield_syndicate_npcs10',959,283,1159,483,'',13,1,0,0,0,0,0
			    ,0,0,0,0,1,0);
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hershfield_syndicate_npcs11',959,283,1159,483,'',13,1,0,0,0,0,0
			    ,0,0,0,0,1,0);
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hershfield_syndicate_npcs12',959,283,1159,483,'',13,1,0,0,0,0,0
			    ,0,0,0,0,1,0);
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hershfield_numiquol_npcs13',959,283,1159,483,'',13,1,0,0,0,0,0
			    ,0,0,0,0,1,0);
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hershfield_pelistal_npcs14',959,283,1159,483,'',13,1,0,0,0,0,0
			    ,0,0,0,0,1,0);
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('presence_flock_hershfield_theolidical_npcs15',959,283,1159,483,'',13,1,0,0,0,0,0
			    ,0,0,0,0,1,0);

---New 12 Syndicate Spawns and 3 Factional Spawn
PRINT N'Insert new flocks into new presences';

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hershfield_syndicate_npcs1' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hershfield_syndicate_npcs1',[topx] = 959,[topy] = 283,[bottomx] = 1159,[bottomy] = 483,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'syndicate_npc1' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('syndicate_npc1', @presenceID, 2, @definitionID, 864, 962, 2, 5, 60, 0, 30, 'syndicate_npc1', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ikarus_abstrans_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'syndicate_npc2' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('syndicate_npc2', @presenceID, 2, @definitionID, 864, 962, 2, 5, 60, 0, 30, 'syndicate_npc2', 1, 1, 1, 1); 


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hershfield_syndicate_npcs2' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hershfield_syndicate_npcs2',[topx] = 959,[topy] = 283,[bottomx] = 1159,[bottomy] = 483,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'syndicate_3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('syndicate_3', @presenceID, 2, @definitionID, 1410, 1090, 2, 5, 60, 0, 30, 'syndicate_3', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_callisto_buccaneer_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'syndicate_4' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('syndicate_4', @presenceID, 2, @definitionID, 1410, 1090, 2, 5, 60, 0, 30, 'syndicate_4', 1, 1, 1, 1); 

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hershfield_syndicate_npcs3' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hershfield_syndicate_npcs3',[topx] = 959,[topy] = 283,[bottomx] = 1159,[bottomy] = 483,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_callisto_buccaneer_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'syndicate_5' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('syndicate_5', @presenceID, 2, @definitionID, 940, 1111, 2, 5, 60, 0, 30, 'syndicate_5', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'syndicate_6' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('syndicate_6', @presenceID, 2, @definitionID, 940, 1111, 2, 5, 60, 0, 30, 'syndicate_6', 1, 1, 1, 1); 

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hershfield_syndicate_npcs4' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hershfield_syndicate_npcs4',[topx] = 959,[topy] = 283,[bottomx] = 1159,[bottomy] = 483,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_callisto_buccaneer_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'syndicate_7' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('syndicate_7', @presenceID, 2, @definitionID, 940, 590, 2, 5, 60, 0, 30, 'syndicate_7', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'syndicate_8' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('syndicate_8', @presenceID, 2, @definitionID, 940, 590, 2, 5, 60, 0, 30, 'syndicate_8', 1, 1, 1, 1); 

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hershfield_syndicate_npcs5' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hershfield_syndicate_npcs5',[topx] = 959,[topy] = 283,[bottomx] = 1159,[bottomy] = 483,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;
				
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'syndicate_9' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('syndicate_9', @presenceID, 2, @definitionID, 1350, 780, 2, 5, 60, 0, 30, 'syndicate_9', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'syndicate_10' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('syndicate_10', @presenceID, 2, @definitionID, 1350, 780, 2, 5, 60, 0, 30, 'syndicate_10', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ikarus_abstrans_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'syndicate_11' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('syndicate_11', @presenceID, 2, @definitionID, 1350, 780, 2, 5, 60, 0, 30, 'syndicate_11', 1, 1, 1, 1); 

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hershfield_syndicate_npcs6' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hershfield_syndicate_npcs6',[topx] = 959,[topy] = 283,[bottomx] = 1159,[bottomy] = 483,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'syndicate_12' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('syndicate_12', @presenceID, 2, @definitionID, 760, 935, 2, 5, 60, 0, 30, 'syndicate_12', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'syndicate_13' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('syndicate_13', @presenceID, 2, @definitionID, 760, 935, 2, 5, 60, 0, 30, 'syndicate_13', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'syndicate_14' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('syndicate_14', @presenceID, 2, @definitionID, 760, 935, 2, 5, 60, 0, 30, 'syndicate_14', 1, 1, 1, 1); 

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hershfield_syndicate_npcs7' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hershfield_syndicate_npcs7',[topx] = 959,[topy] = 283,[bottomx] = 1159,[bottomy] = 483,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Syndicate_15' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Syndicate_15', @presenceID, 2, @definitionID, 1080, 1045, 2, 5, 60, 0, 30, 'syndicate_15', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_callisto_buccaneer_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Syndicate_16' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Syndicate_16', @presenceID, 2, @definitionID, 1080, 1045, 2, 5, 60, 0, 30, 'syndicate_16', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'syndicate_17' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('syndicate_17', @presenceID, 2, @definitionID, 1080, 1045, 2, 5, 60, 0, 30, 'syndicate_17', 1, 1, 1, 1); 

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hershfield_syndicate_npcs8' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hershfield_syndicate_npcs8',[topx] = 959,[topy] = 283,[bottomx] = 1159,[bottomy] = 483,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank2' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'syndicate_18' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('syndicate_18', @presenceID, 2, @definitionID, 1170, 1020, 2, 5, 60, 0, 30, 'syndicate_18', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_callisto_buccaneer_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'syndicate_19' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('syndicate_19', @presenceID, 2, @definitionID, 1170, 1020, 2, 5, 60, 0, 30, 'syndicate_19', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'syndicate_20' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('syndicate_20', @presenceID, 1, @definitionID, 1170, 1020, 2, 5, 60, 0, 30, 'syndicate_20', 1, 1, 1, 1); 

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hershfield_syndicate_npcs9' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hershfield_syndicate_npcs9',[topx] = 959,[topy] = 283,[bottomx] = 1159,[bottomy] = 483,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Syndicate_21' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Syndicate_21', @presenceID, 3, @definitionID, 1080, 1045, 2, 5, 60, 0, 30, 'syndicate_21', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_callisto_buccaneer_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'syndicate_22' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('syndicate_22', @presenceID, 3, @definitionID, 1080, 1045, 2, 5, 60, 0, 30, 'syndicate_22', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'syndicate_23' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('syndicate_23', @presenceID, 2, @definitionID, 1080, 1045, 2, 5, 60, 0, 30, 'syndicate_23', 1, 1, 1, 1); 

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hershfield_syndicate_npcs10' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hershfield_syndicate_npcs10',[topx] = 959,[topy] = 283,[bottomx] = 1159,[bottomy] = 483,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Syndicate_24' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Syndicate_24', @presenceID, 2, @definitionID, 1370, 1720, 2, 5, 60, 0, 30, 'syndicate_24', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'syndicate_25' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('syndicate_25', @presenceID, 3, @definitionID, 1370, 1720, 2, 5, 60, 0, 30, 'syndicate_25', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'syndicate_26' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('syndicate_26', @presenceID, 2, @definitionID, 1370, 1720, 2, 5, 60, 0, 30, 'syndicate_26', 1, 1, 1, 1); 

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hershfield_syndicate_npcs11' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hershfield_syndicate_npcs11',[topx] = 959,[topy] = 283,[bottomx] = 1159,[bottomy] = 483,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'syndicate_27' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('syndicate_27', @presenceID, 3, @definitionID, 1590, 1550, 2, 5, 60, 0, 30, 'syndicate_27', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'syndicate_28' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('syndicate_28', @presenceID, 2, @definitionID, 1590, 1550, 2, 5, 60, 0, 30, 'syndicate_28', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'syndicate_29' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('syndicate_29', @presenceID, 2, @definitionID, 1590, 1550, 2, 5, 60, 0, 30, 'syndicate_29', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ikarus_abstrans_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'syndicate_30' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('syndicate_30', @presenceID, 2, @definitionID, 1590, 1550, 2, 5, 60, 0, 30, 'syndicate_30', 1, 1, 1, 1); 

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hershfield_syndicate_npcs12' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hershfield_syndicate_npcs12',[topx] = 959,[topy] = 283,[bottomx] = 1159,[bottomy] = 483,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'syndicate_31' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('syndicate_31', @presenceID, 3, @definitionID, 1080, 1870, 2, 5, 60, 0, 30, 'syndicate_31', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'syndicate_32' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('syndicate_32', @presenceID, 3, @definitionID, 1080, 1870, 2, 5, 60, 0, 30, 'syndicate_32', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_callisto_buccaneer_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'syndicate_33' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('syndicate_33', @presenceID, 2, @definitionID, 1080, 1870, 2, 5, 60, 0, 30, 'syndicate_33', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ikarus_abstrans_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'syndicate_34' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('syndicate_34', @presenceID, 2, @definitionID, 1080, 1870, 2, 5, 60, 0, 30, 'syndicate_34', 1, 1, 1, 1); 

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hershfield_numiquol_npcs13' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hershfield_numiquol_npcs13',[topx] = 959,[topy] = 283,[bottomx] = 1159,[bottomy] = 483,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_hybrid_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Num_1' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Num_1', @presenceID, 3, @definitionID, 1341, 420, 0, 5, 60, 0, 30, 'Num_1', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_ew_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Num_2' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Num_2', @presenceID, 3, @definitionID, 1341, 420, 0, 5, 60, 0, 30, 'Num_2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vagabond_dps_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Num_3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Num_3', @presenceID, 3, @definitionID, 1341, 420, 0, 5, 60, 0, 30, 'Num_3', 1, 1, 1, 1); 

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hershfield_pelistal_npcs14' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hershfield_pelistal_npcs14',[topx] = 959,[topy] = 283,[bottomx] = 1159,[bottomy] = 483,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_hybrid_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'pel_1' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('pel_1', @presenceID, 3, @definitionID, 694, 1572, 0, 5, 60, 0, 30, 'pel_1', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_ew_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'pel_2' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('pel_2', @presenceID, 3, @definitionID, 694, 1572, 0, 5, 60, 0, 30, 'pel_2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ictus_jammer_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'pel_3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('pel_3', @presenceID, 3, @definitionID, 694, 1572, 0, 5, 60, 0, 30, 'pel_3', 1, 1, 1, 1); 

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'presence_flock_hershfield_theolidical_npcs15' ORDER BY id DESC)
UPDATE [dbo].[npcpresence]
                SET [name] = 'presence_flock_hershfield_theolidical_npcs15',[topx] = 959,[topy] = 283,[bottomx] = 1159,[bottomy] = 483,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_hybrid_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'theo_1' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('theo_1', @presenceID, 3, @definitionID, 715, 393, 0, 5, 60, 0, 30, 'Theo_1', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_ew_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'theo_2' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('theo_2', @presenceID, 3, @definitionID, 715, 393, 0, 5, 60, 0, 30, 'Theo_2', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_zenith_heavyew_rank3' ORDER BY definition DESC);
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'theo_3' ORDER BY id DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('theo_3', @presenceID, 3, @definitionID, 715, 393, 0, 5, 60, 0, 30, 'Theo_3', 1, 1, 1, 1); 

GO

----------------------------------------------------
--02_Content_Hersh_NPCs_Callisto_and_more__2019_04_03.sql
-----------------------------------------------------



USE [perpetuumsa]
GO

----------------------------------------------------------------
--REQUIRES: Content_Hersh_NPCs_Callisto_and_more__2019_03_02 << must be run first
--Removed Proto Loots and Adds Regular loots for Callisto NPCs
--Date: 2019/04/03
----------------------------------------------------------------

set noexec off;

IF NOT EXISTS (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_callisto_buccaneer_rank3' ORDER BY definition DESC)
BEGIN
	set noexec on;
	PRINT N'Callisto DOES NOT EXIST!! ';
END

PRINT N'Modifying Callisto Loots';

DECLARE @definitionID int;
DECLARE @lootdefinitionID int;
DECLARE @npclootID int;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_callisto_buccaneer_rank3' ORDER BY definition DESC);

PRINT N'Deletes';
--Remove Prototypes added by accident
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_detection_modul_pr' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
DELETE FROM [dbo].[npcloot] WHERE id=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_stealth_modul_pr' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
DELETE FROM [dbo].[npcloot] WHERE id=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_detection_modul_pr' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
DELETE FROM [dbo].[npcloot] WHERE id=@npclootID;

PRINT N'Inserts';
--Add non-prototypes to callisto
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_detection_modul' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 1,1, 0);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_detection_modul' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.01, 1,1, 0);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_stealth_modul' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.01, 1,1, 0);

PRINT N'Updates';
--Updates to existing loots
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=125, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=75 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_energy_vampire' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.025, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_resistant_plating' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.025, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_sensor_dampener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.025, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_sensor_jammer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.025, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_webber' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.025, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_3' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.02, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_4' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.02, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_5' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.01, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_6' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.01, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_7' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_8' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_advanced' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=35, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=25 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=20, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=10 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_expert' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=15, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=5 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.15, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_energy_vampire' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.15, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_resistant_plating' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.15, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_sensor_dampener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.15, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_sensor_jammer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.15, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_webber' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.15, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=350, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=300 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_shield_generator' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.15, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_shield_generator' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_shield_generator' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.025, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_energy_vampire' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_resistant_plating' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_sensor_dampener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_sensor_jammer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_detection_modul' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.15, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_stealth_modul' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.15, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_stealth_modul' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=350, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=250 WHERE [id]=@npclootID;

PRINT N'Done updating Callisto rank 3 loots';
GO
set noexec off;
GO



-------------------------------------------------------
--20190215T061300Z_remove_temp_stronghold_teleport.sql
-------------------------------------------------------

USE [perpetuumsa]
GO

delete from dbo.teleportdescriptions
where description = 'tp_zone_39_3_to_teleport_column_tm_maddis_Z'
and sourcezone = (select id from dbo.zones where name = 'zone_pvp_arena' and note = 'pvp arena')
and targetzone = (select id from dbo.zones where name = 'zone_TM' and note = 'new virginia');

GO


-------------------------------------------------
--20190401T202900Z_welcome_mail.sql
-------------------------------------------------

USE [perpetuumsa]
GO

------------------------------------------------
-- Welcome Mail features and character
-- CREATE: premademail table
-- INSERT: account and character
-- A table of predefined mails is created with a name
-- by which to lookup mails on the server when being sent
-- A character and account are also created to allow the mail to be
-- sent from this character.
-- The account should be perma-banned, and the PASSWORD CHANGED at patch time or after
--
-- Date: 2019/04/04 
------------------------------------------------


DROP TABLE IF EXISTS dbo.premademail;
GO


/* Setup premademail */
CREATE TABLE dbo.premademail (
	id int primary key,
	name varchar(32) not null unique,
	subject nvarchar(128) not null,
	body nvarchar(2000) not null
);
GO


INSERT INTO dbo.premademail (id, name, subject, body)
VALUES (1, 'TutorialArriveMail', 'Welcome $USER$!', 'Welcome to Perpetuum $USER$!
You will begin your first steps in the Tutorial and are asked to complete the "Rookie Checklist".
If you find that you need assistance, please use the link below:
https://openperpetuum.com/help

You may in fact skip the tutorial by proceeding to the exit teleports after you undock.
However you will miss out on a lot of rewards!  Skipping is not recommended for new players.
If you have any questions, do not hesitate to reach out in Help chat or on discord at:
https://discord.gg/5ZVqabV
');

INSERT INTO dbo.premademail (id, name, subject, body)
VALUES (2, 'TutorialCompleteMail', 'Welcome to Nia $USER$! Your next move...', 'Congratulations on completing the Rookie Checklist $USER$!
You might be wondering what to do next…
First, dont forget to join the Discord:  https://discord.gg/5ZVqabV
And to view all the helpful links on https://openperpetuum.com

Remember everything you can do in the tutorial you can do on Nia, and earn NIC and EP! 
Consider joining a player Corporation - and meet other players like yourself, learn from others in the game, and go further together!
');
GO

/* Setup Welcome-Agent Account and Character */
DECLARE @PASSWORD_TEMP varbinary(40);
SET @PASSWORD_TEMP = HASHBYTES('SHA1', (LEFT(REPLACE(NEWID(),'-',''),31)));
DECLARE @PASSWORD varchar(100);
SET @PASSWORD = (SELECT CONVERT(VARCHAR(100),HASHBYTES('SHA1',CRYPT_GEN_RANDOM(32)),2));

--This account will be used to host server-defined characters for automated interactions with players
INSERT INTO [dbo].[accounts]
           ([email]
           ,[password]
           ,[firstName]
           ,[lastName]
           ,[born]
           ,[state]
           ,[accLevel]
           ,[totalMinsOnline]
           ,[lastLoggedIn]
           ,[creation]
           ,[clientType]
           ,[isLoggedIn]
           ,[bantime]
           ,[banlength]
           ,[bannote]
           ,[emailConfirmed]
           ,[firstcharacter]
           ,[note]
           ,[steamID]
           ,[twitchAuthToken]
           ,[credit]
           ,[isactive]
           ,[resetcount]
           ,[wasreset]
           ,[validUntil]
           ,[payingcustomer]
           ,[campaignid])
VALUES 
			(N'OPP_server_account', --email
			@PASSWORD, --pw
			NULL, 
			NULL,
			NULL, 
			1, --born
			2, --acclevel
			0, --mins online
			CAST(N'2019-03-17T01:01:00' AS SmallDateTime), --lastloggedin
			CAST(N'2019-03-17T01:01:00' AS SmallDateTime), --creation
			0, --clienttype
			0, --isLoggedin
			CAST(N'2019-03-17T01:01:00' AS SmallDateTime), --bantime
			2147483640, --banlength
			'DO NOT UNBAN - server defined account', 
			0, --emailconfirm
			CAST(N'2019-03-17T01:01:39.680' AS DateTime), --firstcharacter
			'SERVER DEFINED ACCOUNT for server-characters, do not login, do not unban', 
			NULL, 
			NULL, 
			0, 
			0, 
			0, 
			0, 
			NULL, 
			0, 
			N'{"host":"tooladmin"}');


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
			((SELECT accountID FROM dbo.accounts where email = 'overlord'), --accountID
			8702057415139945528, 
			N'[OPP] Sparky - The Syndicate Welcome Agent', --nick
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
			'OPP Welcome Character - For sending mails and messages to new players', 
			499, 
			2401,
			0);

GO


--------------------------------------------------------------
--ChassisBonus_ZenithIntakt_Sensor_lock_range_fix_tobonus__2019_03_02.sql
--------------------------------------------------------------

USE [perpetuumsa]
GO

------------------------
--Balance Team fix to Zenith and Intakt bonuses!
--2019/03/10
-----------------------
PRINT N'FIX TO ZENITH/INTAKT BONUS';

DECLARE @definitionID int;
DECLARE @extensionID int;
DECLARE @aggfieldID int;
DECLARE @chassisbonusID int;

--- Zenith MK1 Optimal Range for Suppressor
PRINT N'ZENITH MK1 BONUS';

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_zenith_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'effect_enhancer_sensor_dampener_locking_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.01 WHERE id = @chassisbonusID;

--- Zenith Mk2 Optimal Range for Suppressor
PRINT N'ZENITH MK2 BONUS';

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_zenith_chassis_mk2' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'effect_enhancer_sensor_dampener_locking_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.01 WHERE id = @chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_high_tech_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_zenith_head_mk2' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'effect_enhancer_sensor_dampener_locking_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.01 WHERE id = @chassisbonusID;

--- Zenith PR Optimal Range for Suppressor
PRINT N'ZENITH PR BONUS';

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_heavyarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_zenith_chassis_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'effect_enhancer_sensor_dampener_locking_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.01 WHERE id = @chassisbonusID;


PRINT N'INTAKT PR BONUS';
--Intakt mk1 Optimal Range modifier for Suppressor
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'effect_enhancer_sensor_dampener_locking_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.01 WHERE id = @chassisbonusID;

PRINT N'INTAKT PR BONUS';
--Intakt PR Optimal Range modifier for Suppressor
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_chassis_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'effect_enhancer_sensor_dampener_locking_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.01 WHERE id = @chassisbonusID;

PRINT N'INTAKT PR BONUS';
--Intakt MK2 Optimal Range modifier for Suppressor
SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_lightarmored_unit_piloting');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_chassis_mk2' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'effect_enhancer_sensor_dampener_locking_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.01 WHERE id = @chassisbonusID;

SET @extensionID = (SELECT TOP 1 extensionid from dbo.extensions WHERE extensionname = 'ext_high_tech_specialist');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_head_mk2' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE[name] = 'effect_enhancer_sensor_dampener_locking_range_modifier' ORDER BY [name] DESC);
 SET @chassisbonusID = (SELECT TOP 1 id from chassisbonus WHERE[definition] = @definitionID AND [extension] = @extensionID AND [targetpropertyID] = @aggfieldID ORDER BY [definition], [extension], [targetpropertyID] DESC);

UPDATE chassisbonus SET effectenhancer=0, bonus=-0.01 WHERE id = @chassisbonusID;

GO


---------------------------------------------------------
--Epriton_Field_reductions_to_10__2019_03_10.sql
---------------------------------------------------------

USE [perpetuumsa]
GO

-----------------------------
--Epriton field count 20->10
--2019/03/10
-----------------------------

DECLARE @numFields int;
DECLARE @epi int;
DECLARE @zoneID int;


SET @numFields = 10;
SET @epi = (SELECT TOP 1 idx FROM [dbo].[minerals] WHERE name='epriton');


SET @zoneID = (SELECT TOP 1 id FROM [dbo].[zones] WHERE name='zone_ICS_A_real' AND note='domhalarn');
UPDATE [dbo].[mineralconfigs]
	SET [maxnodes]= @numFields
	WHERE Zoneid=@zoneID and materialtype=@epi;

SET @zoneID = (SELECT TOP 1 id FROM [dbo].[zones] WHERE name='zone_ASI_A_real' AND note='hokkogaros');
UPDATE [dbo].[mineralconfigs]
	SET [maxnodes]= @numFields
	WHERE Zoneid=@zoneID and materialtype=@epi;

SET @zoneID = (SELECT TOP 1 id FROM [dbo].[zones] WHERE name='zone_TM_A_real' AND note='norhoop');
UPDATE [dbo].[mineralconfigs]
	SET [maxnodes]= @numFields
	WHERE Zoneid=@zoneID and materialtype=@epi;

SET @zoneID = (SELECT TOP 1 id FROM [dbo].[zones] WHERE name='zone_ICS_pvp' AND note='novastrov');
UPDATE [dbo].[mineralconfigs]
	SET [maxnodes]= @numFields
	WHERE Zoneid=@zoneID and materialtype=@epi;

SET @zoneID = (SELECT TOP 1 id FROM [dbo].[zones] WHERE name='zone_TM_pvp' AND note='alsbale');
UPDATE [dbo].[mineralconfigs]
	SET [maxnodes]= @numFields
	WHERE Zoneid=@zoneID and materialtype=@epi;

SET @zoneID = (SELECT TOP 1 id FROM [dbo].[zones] WHERE name='zone_ASI_pvp' AND note='kentagura');
UPDATE [dbo].[mineralconfigs]
	SET [maxnodes]= @numFields
	WHERE Zoneid=@zoneID and materialtype=@epi;

GO


---------------------------------------------
--npcflocks_ALTER_addCol_npcSpecialType__2019_03_25.sql
----------------------------------------------

USE [perpetuumsa]
GO

----------------------------------------------------------------
--Table: npcflocks, npcSpecialTypes
--ALTER: Add npcSpecialType column
--CREATE: npcSpecialTypes enum table
--Description: Adding an int enum value col to npcflocks to configure
--special logic on the server for these flock types
--
--Date: 2019/03/26
----------------------------------------------------------------

DROP TABLE IF EXISTS dbo.npcSpecialTypes;

PRINT N'Create Enum table for Special Types';
CREATE TABLE dbo.npcSpecialTypes(
id INT NOT NULL IDENTITY PRIMARY KEY,
name VARCHAR(64) NOT NULL,
value INT NOT NULL
);

PRINT N'Insert enum values (NOTE: must match server enum!)';
INSERT INTO dbo.npcSpecialTypes(name, value) 
VALUES
('normal', 0),
('boss', 1);

PRINT N'NPCFLOCKS: ADDING COLUMN npcSpecialType';
ALTER TABLE [perpetuumsa].[dbo].[npcflock]
	ADD npcSpecialType INT NOT NULL
    DEFAULT (0)
	WITH VALUES;

GO

PRINT N'Updating existing flocks to be Boss-types';
PRINT N'By Name...';
--Set flocks with these npc definitions as Boss types
UPDATE npcflock 
SET npcflock.npcSpecialType=(SELECT TOP 1 value FROM dbo.npcSpecialTypes WHERE name='boss')
WHERE respawnseconds>600
AND (
definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_One_Eye_Josef')
OR
definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_tribal_weaver')
OR
definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_clan_griffin')
OR
definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_Sacrist_Mythic')
OR
definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_Sacrist_Convert')
OR
definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_Tribal_Member')
OR
definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_Imperial_Infantry')
OR
definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_Malfunctioning_Arkhe')
OR
definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_RoughRider_Scout')
OR
definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_WilliamHBonnie')
OR
definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_npc_Hersh_PitBoss')
);

PRINT N'By Zone...(stronghold)';
--Set all Stronghold-zoned flocks to Boss-type
UPDATE npcflock
SET npcflock.npcSpecialType=(SELECT TOP 1 value FROM dbo.npcSpecialTypes WHERE name='boss')
WHERE npcflock.id in 
(SELECT id FROM npcflock 
WHERE enabled=1 AND npcflock.presenceid in (SELECT id FROM npcpresence
WHERE enabled=1 AND npcpresence.spawnid in (SELECT id FROM npcspawn
WHERE enabled=1 AND npcspawn.id in (SELECT spawnid FROM zones 
WHERE enabled=1 AND zones.name='zone_pvp_arena' AND zones.id=16))));

GO

-------------------------------------------------------------
--NPCLoot_Ikarus_eche_legatus_updates__2019_03_02.sql
---------------------------------------------------------

USE [perpetuumsa]
GO

--------------------------
--Content Team Loot Tweaks
--Ikarus, Legatus, Echelon
--------------------------


DECLARE @definitionID int;
DECLARE @lootdefinitionID int;
DECLARE @npclootID int;

PRINT N'Ikarus Loot Tweaks';
---Ikarus frag reduction by 5 each and lowered minimal

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ikarus_abstrans_rank3' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=10, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=2 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_advanced' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=10, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=2 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_expert' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;



SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ikarus_abstrans_rank4' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=20, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=15 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_advanced' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=15, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=10 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_expert' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=10, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=5 WHERE [id]=@npclootID;

--Buffing minquantity, was smaller than L3
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_industrial' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=85, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=70 WHERE [id]=@npclootID;


PRINT N'Legatus Loot Tweaks';
----ADD T3 drops to Legatus Rank 3

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank3' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=446, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=365 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=480, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=320 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=100, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=50 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=7, [probability]=0.5, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_advanced' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5, [probability]=0.5, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_expert' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2, [probability]=0.5, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_1' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_2' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_3' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_4' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_5' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_6' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_chm_armor_hardener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_sensor_booster' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_eccm' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_autocannon' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_chm_armor_hardener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_sensor_booster' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_eccm' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_autocannon' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_damage_mod_projectile' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_damage_mod_projectile' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=446, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=365 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=480, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=320 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=100, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=50 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=7, [probability]=0.5, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_advanced' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5, [probability]=0.5, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_expert' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2, [probability]=0.5, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_1' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_2' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_3' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_4' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_5' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_6' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_chm_armor_hardener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_sensor_booster' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_eccm' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_autocannon' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_chm_armor_hardener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_sensor_booster' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_eccm' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_autocannon' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_damage_mod_projectile' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_damage_mod_projectile' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.05, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_armor_plate' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.025, 1,1, 0);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_armor_repairer' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.025, 1,1, 0);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_autocannon' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.025, 1,1, 0);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_damage_mod_projectile' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.025, 1,1, 0);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_longrange_medium_autocannon' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.025, 1,1, 0);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_sensor_booster' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.025, 1,1, 0);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_eccm' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.025, 1,1, 0);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_chm_armor_hardener' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.025, 1,1, 0);

PRINT N'Echelon Loot Tweaks';
---Add T3 Drops to Echelon Rank3 mobs

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank3' ORDER BY definition DESC);
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_missile_launcher' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.125, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_exp_armor_hardener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_exp_armor_hardener' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_damage_mod_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_medium_lasercrystal_d' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=60, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_damage_mod_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_damage_mod_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_laser' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.125, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=7, [probability]=0.5, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_advanced' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5, [probability]=0.5, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_expert' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=3, [probability]=0.5, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_thelodica_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=7, [probability]=0, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_thelodica_advanced' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5, [probability]=0, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_thelodica_expert' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=3, [probability]=0, [repackaged]=0, [dontdamage]=1, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_1' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.02, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_2' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.02, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_3' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.01, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_4' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.01, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_5' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_6' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.005, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_thelodica_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=222, [probability]=0, [repackaged]=0, [dontdamage]=0, [minquantity]=182 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=384, [probability]=1, [repackaged]=0, [dontdamage]=1, [minquantity]=256 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_thelodica' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=192, [probability]=0, [repackaged]=0, [dontdamage]=1, [minquantity]=128 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=225, [probability]=1, [repackaged]=1, [dontdamage]=1, [minquantity]=200 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_chm_armor_hardener' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.025, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_armor_plate' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.025, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_armor_repairer' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.025, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_sensor_booster' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.025, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_eccm' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.025, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_longrange_medium_autocannon' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.025, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_damage_mod_projectile' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.025, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_autocannon' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.025, 0,0, 1);

GO

-----------------------------------------------------------
--OPP_Anniversary_gift_robot__2019_03_30.sql
-----------------------------------------------------------

USE [perpetuumsa]
GO

-----------------------------------------------
--OPP 1 Year of LIVE server anniversary gifts!
--New robot definition
--New Package and gifts
--Procedure call to distribute gifts
--Date: 2019/03/20
-----------------------------------------------


PRINT N'1. Create entity)';
--WARNING: options string contains references to entitydefaults in hex (Head/leg/chassis are fixed definitions from arkhe mk2)
--ENTITYDEFAULT SAVE NEW
INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled,  volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
VALUES ( 'def_AnniversArkhe_bot', 1, 0, 257, '#head=iae8#chassis=iae9#leg=iaea#container=i147#tier=$tierlevel_mk2', 'New Arkhe for 1yr aniversary!', 1, 12, 0, 'False', 100, 'def_arkhe2_bot_desc', 1, 1, 2); 
GO

PRINT N'2. Create template (from tool)';
--WARNING: description string contains references to entitydefaults in hex
--TEMPLATE INSERT

DECLARE @definitionHex varchar;
--This is how to do lookups, convert to hex, and concat into a genxy compatible string!
SET @definitionHex = (SELECT dbo.ToHex(definition) FROM entitydefaults WHERE definitionname='def_AnniversArkhe_bot');

INSERT INTO robottemplates ([name], [description], [note]) 
VALUES ('def_anniversarkhe_bot_template', '#robot=i'+@definitionHex+'#head=iae8#chassis=iae9#leg=iaea#container=i147#headModules=[|m0=[|definition=i0|slot=i1]]#chassisModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]]#legModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]]', 'OPP Live 1 year anniversary Reward');
GO

PRINT N'3. Create templaterelation';
INSERT INTO [dbo].[robottemplaterelation]
           ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
     VALUES
           ((SELECT TOP 1 definition from entitydefaults where definitionname='def_AnniversArkhe_bot')
           ,(SELECT TOP 1 id from robottemplates where name='def_anniversarkhe_bot_template'),0,1,NULL,NULL,NULL,'AnniversArkhe Template Relation year1');
GO

PRINT N'4. Insert config w/ desired tint';
INSERT INTO [dbo].[definitionconfig]
           ([definition],[tint],[note])
     VALUES
           ((SELECT TOP 1 definition from entitydefaults where definitionname='def_AnniversArkhe_bot')
           ,'#8bff00'
           ,'Color for AnniversArkhe bot');
GO

PRINT N'5. Give bot skills -- ARKHE MK2 HAS NO ENABLER SKILLS RESULT WILL BE 0 rows affected';
--Use existing bot (that was copied from entitydefault) for extensions
INSERT INTO [dbo].[enablerextensions]
           ([definition],[extensionid],[extensionlevel])
     (SELECT (SELECT TOP 1 definition from entitydefaults where definitionname='def_AnniversArkhe_bot'), extensionid, extensionlevel from enablerextensions where definition=(Select top 1 definition from entitydefaults where definitionname='def_arkhe2_bot'));
GO



PRINT N'Create Packages for pre-alpha participant levels';
INSERT INTO [dbo].[packages]
           ([name],[note])
     VALUES
           ('opp-anniversary01','1 year of OPP Live!');
GO

PRINT N'Insert items into Packages for pre-alpha participant levels';
DECLARE @packid int;
SET @packid = (SELECT TOP 1 id from packages where name='opp-anniversary01');

DECLARE @aid int;
SET @aid = (SELECT TOP 1 definition from entitydefaults where definitionname='def_anniversary_package');

DECLARE @specialBot int;
SET @specialBot = (SELECT TOP 1 definition from entitydefaults where definitionname='def_AnniversArkhe_bot');

DECLARE @epBoostT1 int;
SET @epBoostT1 = (SELECT TOP 1 definition from entitydefaults where definitionname='def_boost_ep_t1');

PRINT N'Items for opp-anniversary01!!!';
INSERT INTO [dbo].[packageitems]
           ([packageid],[definition],[quantity])
     VALUES
           (@packid, @aid, 2), 
		   (@packid, @specialBot, 1),
		   (@packid, @epBoostT1, 1);

GO



DECLARE @packid int;
SET @packid = (SELECT TOP 1 id from packages where name='opp-anniversary01');
--TODO use variant of below for future gifting
--This gift gives to all current accounts at patch-time
PRINT N'Give everyone a gift! WARNING CURSOR AHEAD!';
DECLARE @id int
DECLARE @pass varchar(100)

DECLARE curse CURSOR FOR SELECT accountID FROM accounts
OPEN curse

FETCH NEXT FROM curse INTO @id

WHILE @@FETCH_STATUS = 0 BEGIN
    EXEC dbo.accountPackageProcessOne @id, @packid
    FETCH NEXT FROM curse INTO @id
END

CLOSE curse    
DEALLOCATE curse

GO

--------------------------------------------------------
--Relics_init_all__2019_02_27.sql
--------------------------------------------------------


USE [perpetuumsa]
GO

PRINT N'Relic EntityDefault for server unit creation';

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
           ('def_relic'
           ,1
           ,1024
           ,0 --TODO is this ok?
           ,NULL
           ,'Relic'
           ,1
           ,1
           ,1
           ,0
           ,100
           ,NULL
           ,0
           ,NULL
           ,NULL)
GO

PRINT N'Relic Definition - Add absurd masking';
DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_relic' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'stealth_strength' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 99999999);
GO


PRINT N'Relics - Initial config and settings 2019-01-19';

PRINT N'Dropping all Relic-related tables - This should be the first Relic Patch';
DROP TABLE IF EXISTS dbo.relicloot;
DROP TABLE IF EXISTS dbo.relicspawninfo;
DROP TABLE IF EXISTS dbo.relictypes;
DROP TABLE IF EXISTS dbo.reliczoneconfig;

PRINT N'Create all the Relic tables';
CREATE TABLE dbo.relictypes(
id INT NOT NULL IDENTITY PRIMARY KEY,
name VARCHAR(128) NOT NULL,
raceid INT NULL,
level INT NULL,
ep INT NULL
);

CREATE TABLE dbo.relicloot(
id INT NOT NULL IDENTITY PRIMARY KEY,
definition INT NOT NULL,
minquantity INT NOT NULL,
maxquantity INT NOT NULL,
chance DECIMAL(9,6) NOT NULL,
relictypeid INT NOT NULL,
packed BIT NOT NULL
);

CREATE TABLE dbo.relicspawninfo(
id INT NOT NULL IDENTITY PRIMARY KEY,
relictypeid INT NOT NULL,
zoneid INT NOT NULL,
rate INT NOT NULL,
x INT NULL,
y INT NULL
);

CREATE TABLE dbo.reliczoneconfig(
id INT NOT NULL IDENTITY PRIMARY KEY,
zoneid INT NOT NULL,
maxspawn INT NOT NULL,
respawnrate INT NOT NULL
);

PRINT N'Set the Relic Zone Configurations';
--Relic Zone Configurations: 6 per zone, respawn at 3 hours (+/- 1hr - server-set random range)
INSERT INTO dbo.reliczoneconfig 
	([zoneid], [maxspawn], [respawnrate]) 
SELECT 
     zones.id, 6, 10800
FROM 
     dbo.zones
WHERE 
     zones.active=1 and zones.enabled=1

PRINT N'Explicitly set some zones to "off" w/ maxspawn=0';
--Set some zones to have no natural spawning relics (will disable RelicManagers on these zones)
UPDATE dbo.reliczoneconfig SET
	maxspawn = 0
WHERE zoneid in (16, 45, 50, 51);

--Any zone omitted or with a maxspawn<=0 will NOT have a RelicManager assigned on server boot (this is a good thing)

PRINT N'Create the initial set of Relic-types and their associated EP reward values';
--Create different relic types
INSERT INTO [dbo].[relictypes]
           ([name],[raceid],[level],[ep])
     VALUES
           ('relic_level1_neutral_alpha1',0, 1, 5),
		   ('relic_level2_neutral_alpha1',0, 2, 10),
		   ('relic_level3_neutral_alpha1',0, 3, 15),
		   ('relic_level1_neutral_alpha2',0, 1, 15),
		   ('relic_level2_neutral_alpha2',0, 2, 20),
		   ('relic_level3_neutral_alpha2',0, 3, 25),
		   ('relic_level1_neutral_beta1',0, 1, 25),
		   ('relic_level2_neutral_beta1',0, 2, 35),
		   ('relic_level3_neutral_beta1',0, 3, 45),
		   ('relic_level1_neutral_beta2',0, 1, 45),
		   ('relic_level2_neutral_beta2',0, 2, 55),
		   ('relic_level3_neutral_beta2',0, 3, 65),
           ('relic_level1_indy_alpha1',4, 1, 5),
		   ('relic_level2_indy_alpha1',4, 2, 10),
		   ('relic_level3_indy_alpha1',4, 3, 15),
		   ('relic_level1_indy_alpha2',4, 1, 15),
		   ('relic_level2_indy_alpha2',4, 2, 20),
		   ('relic_level3_indy_alpha2',4, 3, 25),
		   ('relic_level1_indy_beta1',4, 1, 25),
		   ('relic_level2_indy_beta1',4, 2, 35),
		   ('relic_level3_indy_beta1',4, 3, 45),
		   ('relic_level1_indy_beta2',4, 1, 45),
		   ('relic_level2_indy_beta2',4, 2, 55),
		   ('relic_level3_indy_beta2',4, 3, 65),
		   ('relic_level1_numiqol_alpha1',2, 1, 5),
		   ('relic_level2_numiqol_alpha1',2, 2, 10),
		   ('relic_level3_numiqol_alpha1',2, 3, 15),
		   ('relic_level1_numiqol_alpha2',2, 1, 15),
		   ('relic_level2_numiqol_alpha2',2, 2, 20),
		   ('relic_level3_numiqol_alpha2',2, 3, 25),
		   ('relic_level1_numiqol_beta1',2, 1, 25),
		   ('relic_level2_numiqol_beta1',2, 2, 35),
		   ('relic_level3_numiqol_beta1',2, 3, 45),
		   ('relic_level1_numiqol_beta2',2, 1, 45),
		   ('relic_level2_numiqol_beta2',2, 2, 55),
		   ('relic_level3_numiqol_beta2',2, 3, 65),
           ('relic_level1_thelodica_alpha1',3, 1, 5),
		   ('relic_level2_thelodica_alpha1',3, 2, 10),
		   ('relic_level3_thelodica_alpha1',3, 3, 15),
		   ('relic_level1_thelodica_alpha2',3, 1, 15),
		   ('relic_level2_thelodica_alpha2',3, 2, 20),
		   ('relic_level3_thelodica_alpha2',3, 3, 25),
		   ('relic_level1_thelodica_beta1',3, 1, 25),
		   ('relic_level2_thelodica_beta1',3, 2, 35),
		   ('relic_level3_thelodica_beta1',3, 3, 45),
		   ('relic_level1_thelodica_beta2',3, 1, 45),
		   ('relic_level2_thelodica_beta2',3, 2, 55),
		   ('relic_level3_thelodica_beta2',3, 3, 65),
           ('relic_level1_pelistal_alpha1',1, 1, 5),
		   ('relic_level2_pelistal_alpha1',1, 2, 10),
		   ('relic_level3_pelistal_alpha1',1, 3, 15),
		   ('relic_level1_pelistal_alpha2',1, 1, 15),
		   ('relic_level2_pelistal_alpha2',1, 2, 20),
		   ('relic_level3_pelistal_alpha2',1, 3, 25),
		   ('relic_level1_pelistal_beta1',1, 1, 25),
		   ('relic_level2_pelistal_beta1',1, 2, 35),
		   ('relic_level3_pelistal_beta1',1, 3, 45),
		   ('relic_level1_pelistal_beta2',1, 1, 45),
		   ('relic_level2_pelistal_beta2',1, 2, 55),
		   ('relic_level3_pelistal_beta2',1, 3, 65);


DECLARE @commonPlasma int;
DECLARE @numiqolPlasma int;
DECLARE @thelodicaPlasma int;
DECLARE @pelistalPlasma int;

DECLARE @commonKernel int;
DECLARE @hitechKernel int;
DECLARE @industrialKernel int;
DECLARE @numiqolKernel int;
DECLARE @thelodicaKernel int;
DECLARE @pelistalKernel int;


SET @commonPlasma = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_common_reactor_plasma');
SET @numiqolPlasma = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_nuimqol_reactor_plasma');
SET @thelodicaPlasma = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_thelodica_reactor_plasma');
SET @pelistalPlasma = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_pelistal_reactor_plasma');

SET @commonKernel = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_kernel_common');
SET @hitechKernel = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_kernel_hitech');
SET @industrialKernel = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_kernel_industrial');
SET @numiqolKernel = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_kernel_nuimqol');
SET @thelodicaKernel = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_kernel_thelodica');
SET @pelistalKernel = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_kernel_pelistal');

DECLARE @commonBasicFrag int;
DECLARE @commonAdvFrag int;
DECLARE @commonExpFrag int;

DECLARE @nuimqolBasicFrag int;
DECLARE @nuimqolAdvFrag int;
DECLARE @nuimqolExpFrag int;

DECLARE @pelistalBasicFrag int;
DECLARE @pelistalAdvFrag int;
DECLARE @pelistalExpFrag int;

DECLARE @thelodicaBasicFrag int;
DECLARE @thelodicaAdvFrag int;
DECLARE @thelodicaExpFrag int;


SET @commonBasicFrag = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_robotshard_common_basic');
SET @commonAdvFrag = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_robotshard_common_advanced');
SET @commonExpFrag = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_robotshard_common_expert');

SET @nuimqolBasicFrag = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_robotshard_nuimqol_basic');
SET @nuimqolAdvFrag = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_robotshard_nuimqol_advanced');
SET @nuimqolExpFrag = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_robotshard_nuimqol_expert');

SET @pelistalBasicFrag = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_robotshard_pelistal_basic');
SET @pelistalAdvFrag = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_robotshard_pelistal_advanced');
SET @pelistalExpFrag = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_robotshard_pelistal_expert');

SET @thelodicaBasicFrag = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_robotshard_thelodica_basic');
SET @thelodicaAdvFrag = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_robotshard_thelodica_advanced');
SET @thelodicaExpFrag = (SELECT TOP 1 definition FROM dbo.entitydefaults WHERE definitionname='def_robotshard_thelodica_expert');




PRINT N'Create a reasonable initial set of loots for each Relic type'; -- To be supported with future DB tool development
--Insert loots for each type
INSERT INTO [dbo].[relicloot]
           ([definition],[minquantity],[maxquantity],[chance],[relictypeid],[packed])
VALUES
			--Neutral types
			--Kernel - common 75%
           (@commonKernel,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_alpha1'),0),
           (@commonKernel,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_alpha1'),0),
		   (@commonKernel,1350,1650,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_alpha1'),0),
		   (@commonKernel,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_alpha2'),0),
		   (@commonKernel,1013,1238,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_alpha2'),0),
		   (@commonKernel,2025,2475,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_alpha2'),0),
		   (@commonKernel,1013,1238,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_beta1'),0),
		   (@commonKernel,1519,1856,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_beta1'),0),
		   (@commonKernel,3038,3713,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_beta1'),0),
		   (@commonKernel,1463,1788,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_beta2'),0),
		   (@commonKernel,2194,2681,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_beta2'),0),
		   (@commonKernel,4388,5363,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_beta2'),0),
		   --Kernel - hitech 25%
           (@hitechKernel,150,183,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_alpha1'),0),
           (@hitechKernel,225,275,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_alpha1'),0),
		   (@hitechKernel,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_alpha1'),0),
		   (@hitechKernel,225,275,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_alpha2'),0),
		   (@hitechKernel,338,413,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_alpha2'),0),
		   (@hitechKernel,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_alpha2'),0),
		   (@hitechKernel,338,413,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_beta1'),0),
		   (@hitechKernel,506,619,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_beta1'),0),
		   (@hitechKernel,1013,1238,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_beta1'),0),
		   (@hitechKernel,488,596,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_beta2'),0),
		   (@hitechKernel,731,894,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_beta2'),0),
		   (@hitechKernel,1463,1788,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_beta2'),0),
		   --Plasma - common
           (@commonPlasma,300,367,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_alpha1'),0),
           (@commonPlasma,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_alpha1'),0),
		   (@commonPlasma,900,1100,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_alpha1'),0),
		   (@commonPlasma,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_alpha2'),0),
		   (@commonPlasma,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_alpha2'),0),
		   (@commonPlasma,1350,1650,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_alpha2'),0),
		   (@commonPlasma,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_beta1'),0),
		   (@commonPlasma,1013,1238,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_beta1'),0),
		   (@commonPlasma,2025,2475,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_beta1'),0),
		   (@commonPlasma,975,1192,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_beta2'),0),
		   (@commonPlasma,1463,1788,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_beta2'),0),
		   (@commonPlasma,2925,3575,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_beta2'),0),
		   	-- Frags Common
           (@commonBasicFrag,10,15,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_alpha1'),0),
		   (@commonAdvFrag,10,15,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_alpha1'),0),
		   (@commonExpFrag,10,15,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_alpha1'),0),

           (@commonBasicFrag,15,20,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_alpha1'),0),
		   (@commonAdvFrag,15,20,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_alpha1'),0),
		   (@commonExpFrag,15,20,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_alpha1'),0),

		   (@commonBasicFrag,20,25,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_alpha1'),0),
		   (@commonAdvFrag,20,25,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_alpha1'),0),
		   (@commonExpFrag,20,25,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_alpha1'),0),

		   (@commonBasicFrag,25,30,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_alpha2'),0),
		   (@commonAdvFrag,25,30,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_alpha2'),0),
		   (@commonExpFrag,25,30,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_alpha2'),0),

		   (@commonBasicFrag,30,35,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_alpha2'),0),
		   (@commonAdvFrag,30,35,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_alpha2'),0),
		   (@commonExpFrag,30,35,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_alpha2'),0),

		   (@commonBasicFrag,35,40,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_alpha2'),0),
		   (@commonAdvFrag,35,40,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_alpha2'),0),
		   (@commonExpFrag,35,40,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_alpha2'),0),

		   (@commonBasicFrag,40,45,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_beta1'),0),
		   (@commonAdvFrag,40,45,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_beta1'),0),
		   (@commonExpFrag,40,45,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_beta1'),0),

		   (@commonBasicFrag,45,50,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_beta1'),0),
		   (@commonAdvFrag,45,50,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_beta1'),0),
		   (@commonExpFrag,45,50,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_beta1'),0),

		   (@commonBasicFrag,50,55,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_beta1'),0),
		   (@commonAdvFrag,50,55,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_beta1'),0),
		   (@commonExpFrag,50,55,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_beta1'),0),

		   (@commonBasicFrag,55,60,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_beta2'),0),
		   (@commonAdvFrag,55,60,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_beta2'),0),
		   (@commonExpFrag,55,60,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_beta2'),0),

		   (@commonBasicFrag,60,65,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_beta2'),0),
		   (@commonAdvFrag,60,65,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_beta2'),0),
		   (@commonExpFrag,60,65,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_beta2'),0),

		   (@commonBasicFrag,65,70,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_beta2'),0),
		   (@commonAdvFrag,65,70,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_beta2'),0),
		   (@commonExpFrag,65,70,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_beta2'),0),
		   

		   	--Indy types
			--Kernel - Common 50%
           (@commonKernel,300,367,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_alpha1'),0),
           (@commonKernel,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_alpha1'),0),
		   (@commonKernel,900,1100,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_alpha1'),0),
		   (@commonKernel,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_alpha2'),0),
		   (@commonKernel,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_alpha2'),0),
		   (@commonKernel,1350,1650,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_alpha2'),0),
		   (@commonKernel,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_beta1'),0),
		   (@commonKernel,1013,1238,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_beta1'),0),
		   (@commonKernel,2025,2475,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_beta1'),0),
		   (@commonKernel,975,1192,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_beta2'),0),
		   (@commonKernel,1463,1788,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_beta2'),0),
		   (@commonKernel,2925,3575,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_beta2'),0),
		   --Kernel - Indy 50%
           (@industrialKernel,300,367,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_alpha1'),0),
           (@industrialKernel,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_alpha1'),0),
		   (@industrialKernel,900,1100,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_alpha1'),0),
		   (@industrialKernel,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_alpha2'),0),
		   (@industrialKernel,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_alpha2'),0),
		   (@industrialKernel,1350,1650,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_alpha2'),0),
		   (@industrialKernel,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_beta1'),0),
		   (@industrialKernel,1013,1238,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_beta1'),0),
		   (@industrialKernel,2025,2475,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_beta1'),0),
		   (@industrialKernel,975,1192,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_beta2'),0),
		   (@industrialKernel,1463,1788,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_beta2'),0),
		   (@industrialKernel,2925,3575,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_beta2'),0),
		   --Plasma - common
           (@commonPlasma,300,367,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_alpha1'),0),
           (@commonPlasma,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_alpha1'),0),
		   (@commonPlasma,900,1100,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_alpha1'),0),
		   (@commonPlasma,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_alpha2'),0),
		   (@commonPlasma,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_alpha2'),0),
		   (@commonPlasma,1350,1650,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_alpha2'),0),
		   (@commonPlasma,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_beta1'),0),
		   (@commonPlasma,1013,1238,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_beta1'),0),
		   (@commonPlasma,2025,2475,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_beta1'),0),
		   (@commonPlasma,975,1192,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_beta2'),0),
		   (@commonPlasma,1463,1788,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_beta2'),0),
		   (@commonPlasma,2925,3575,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_beta2'),0),
		   	-- Frags Common
           (@commonBasicFrag,10,15,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_alpha1'),0),
		   (@commonAdvFrag,10,15,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_alpha1'),0),
		   (@commonExpFrag,10,15,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_alpha1'),0),

           (@commonBasicFrag,15,20,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_alpha1'),0),
		   (@commonAdvFrag,15,20,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_alpha1'),0),
		   (@commonExpFrag,15,20,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_alpha1'),0),

		   (@commonBasicFrag,20,25,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_alpha1'),0),
		   (@commonAdvFrag,20,25,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_alpha1'),0),
		   (@commonExpFrag,20,25,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_alpha1'),0),

		   (@commonBasicFrag,25,30,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_alpha2'),0),
		   (@commonAdvFrag,25,30,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_alpha2'),0),
		   (@commonExpFrag,25,30,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_alpha2'),0),

		   (@commonBasicFrag,30,35,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_alpha2'),0),
		   (@commonAdvFrag,30,35,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_alpha2'),0),
		   (@commonExpFrag,30,35,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_alpha2'),0),

		   (@commonBasicFrag,35,40,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_alpha2'),0),
		   (@commonAdvFrag,35,40,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_alpha2'),0),
		   (@commonExpFrag,35,40,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_alpha2'),0),

		   (@commonBasicFrag,40,45,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_beta1'),0),
		   (@commonAdvFrag,40,45,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_beta1'),0),
		   (@commonExpFrag,40,45,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_beta1'),0),

		   (@commonBasicFrag,45,50,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_beta1'),0),
		   (@commonAdvFrag,45,50,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_beta1'),0),
		   (@commonExpFrag,45,50,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_beta1'),0),

		   (@commonBasicFrag,50,55,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_beta1'),0),
		   (@commonAdvFrag,50,55,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_beta1'),0),
		   (@commonExpFrag,50,55,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_beta1'),0),

		   (@commonBasicFrag,55,60,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_beta2'),0),
		   (@commonAdvFrag,55,60,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_beta2'),0),
		   (@commonExpFrag,55,60,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_beta2'),0),

		   (@commonBasicFrag,60,65,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_beta2'),0),
		   (@commonAdvFrag,60,65,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_beta2'),0),
		   (@commonExpFrag,60,65,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_beta2'),0),

		   (@commonBasicFrag,65,70,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_beta2'),0),
		   (@commonAdvFrag,65,70,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_beta2'),0),
		   (@commonExpFrag,65,70,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_beta2'),0),

			--Numiqol types
			--Kernel - Common 50%
           (@commonKernel,300,367,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_alpha1'),0),
           (@commonKernel,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_alpha1'),0),
		   (@commonKernel,900,1100,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_alpha1'),0),
		   (@commonKernel,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_alpha2'),0),
		   (@commonKernel,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_alpha2'),0),
		   (@commonKernel,1350,1650,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_alpha2'),0),
		   (@commonKernel,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_beta1'),0),
		   (@commonKernel,1013,1238,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_beta1'),0),
		   (@commonKernel,2025,2475,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_beta1'),0),
		   (@commonKernel,975,1192,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_beta2'),0),
		   (@commonKernel,1463,1788,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_beta2'),0),
		   (@commonKernel,2925,3575,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_beta2'),0),
		   --Kernel - Numiqol 50%
           (@numiqolKernel,300,367,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_alpha1'),0),
           (@numiqolKernel,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_alpha1'),0),
		   (@numiqolKernel,900,1100,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_alpha1'),0),
		   (@numiqolKernel,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_alpha2'),0),
		   (@numiqolKernel,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_alpha2'),0),
		   (@numiqolKernel,1350,1650,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_alpha2'),0),
		   (@numiqolKernel,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_beta1'),0),
		   (@numiqolKernel,1013,1238,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_beta1'),0),
		   (@numiqolKernel,2025,2475,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_beta1'),0),
		   (@numiqolKernel,975,1192,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_beta2'),0),
		   (@numiqolKernel,1463,1788,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_beta2'),0),
		   (@numiqolKernel,2925,3575,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_beta2'),0),
		   --Plasma - numiqol
           (@numiqolPlasma,300,367,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_alpha1'),0),
           (@numiqolPlasma,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_alpha1'),0),
		   (@numiqolPlasma,900,1100,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_alpha1'),0),
		   (@numiqolPlasma,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_alpha2'),0),
		   (@numiqolPlasma,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_alpha2'),0),
		   (@numiqolPlasma,1350,1650,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_alpha2'),0),
		   (@numiqolPlasma,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_beta1'),0),
		   (@numiqolPlasma,1013,1238,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_beta1'),0),
		   (@numiqolPlasma,2025,2475,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_beta1'),0),
		   (@numiqolPlasma,975,1192,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_beta2'),0),
		   (@numiqolPlasma,1463,1788,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_beta2'),0),
		   (@numiqolPlasma,2925,3575,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_beta2'),0),
		   		   	-- Frags Common
           (@nuimqolBasicFrag,10,15,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_alpha1'),0),
		   (@nuimqolAdvFrag,10,15,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_alpha1'),0),
		   (@nuimqolExpFrag,10,15,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_alpha1'),0),

           (@nuimqolBasicFrag,15,20,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_alpha1'),0),
		   (@nuimqolAdvFrag,15,20,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_alpha1'),0),
		   (@nuimqolExpFrag,15,20,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_alpha1'),0),

		   (@nuimqolBasicFrag,20,25,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_alpha1'),0),
		   (@nuimqolAdvFrag,20,25,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_alpha1'),0),
		   (@nuimqolExpFrag,20,25,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_alpha1'),0),

		   (@nuimqolBasicFrag,25,30,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_alpha2'),0),
		   (@nuimqolAdvFrag,25,30,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_alpha2'),0),
		   (@nuimqolExpFrag,25,30,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_alpha2'),0),

		   (@nuimqolBasicFrag,30,35,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_alpha2'),0),
		   (@nuimqolAdvFrag,30,35,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_alpha2'),0),
		   (@nuimqolExpFrag,30,35,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_alpha2'),0),

		   (@nuimqolBasicFrag,35,40,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_alpha2'),0),
		   (@nuimqolAdvFrag,35,40,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_alpha2'),0),
		   (@nuimqolExpFrag,35,40,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_alpha2'),0),

		   (@nuimqolBasicFrag,40,45,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_beta1'),0),
		   (@nuimqolAdvFrag,40,45,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_beta1'),0),
		   (@nuimqolExpFrag,40,45,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_beta1'),0),

		   (@nuimqolBasicFrag,45,50,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_beta1'),0),
		   (@nuimqolAdvFrag,45,50,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_beta1'),0),
		   (@nuimqolExpFrag,45,50,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_beta1'),0),

		   (@nuimqolBasicFrag,50,55,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_beta1'),0),
		   (@nuimqolAdvFrag,50,55,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_beta1'),0),
		   (@nuimqolExpFrag,50,55,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_beta1'),0),

		   (@nuimqolBasicFrag,55,60,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_beta2'),0),
		   (@nuimqolAdvFrag,55,60,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_beta2'),0),
		   (@nuimqolExpFrag,55,60,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_beta2'),0),

		   (@nuimqolBasicFrag,60,65,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_beta2'),0),
		   (@nuimqolAdvFrag,60,65,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_beta2'),0),
		   (@nuimqolExpFrag,60,65,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_beta2'),0),

		   (@nuimqolBasicFrag,65,70,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_beta2'),0),
		   (@nuimqolAdvFrag,65,70,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_beta2'),0),
		   (@nuimqolExpFrag,65,70,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_beta2'),0),

			--Thelodica types
			--Kernel - Common 50%
           (@commonKernel,300,367,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_alpha1'),0),
           (@commonKernel,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_alpha1'),0),
		   (@commonKernel,900,1100,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_alpha1'),0),
		   (@commonKernel,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_alpha2'),0),
		   (@commonKernel,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_alpha2'),0),
		   (@commonKernel,1350,1650,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_alpha2'),0),
		   (@commonKernel,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_beta1'),0),
		   (@commonKernel,1013,1238,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_beta1'),0),
		   (@commonKernel,2025,2475,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_beta1'),0),
		   (@commonKernel,975,1192,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_beta2'),0),
		   (@commonKernel,1463,1788,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_beta2'),0),
		   (@commonKernel,2925,3575,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_beta2'),0),
		   --Kernel - thelodica 50%
           (@thelodicaKernel,300,367,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_alpha1'),0),
           (@thelodicaKernel,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_alpha1'),0),
		   (@thelodicaKernel,900,1100,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_alpha1'),0),
		   (@thelodicaKernel,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_alpha2'),0),
		   (@thelodicaKernel,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_alpha2'),0),
		   (@thelodicaKernel,1350,1650,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_alpha2'),0),
		   (@thelodicaKernel,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_beta1'),0),
		   (@thelodicaKernel,1013,1238,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_beta1'),0),
		   (@thelodicaKernel,2025,2475,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_beta1'),0),
		   (@thelodicaKernel,975,1192,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_beta2'),0),
		   (@thelodicaKernel,1463,1788,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_beta2'),0),
		   (@thelodicaKernel,2925,3575,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_beta2'),0),
		   --Plasma - thelodica
           (@thelodicaPlasma,300,367,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_alpha1'),0),
           (@thelodicaPlasma,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_alpha1'),0),
		   (@thelodicaPlasma,900,1100,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_alpha1'),0),
		   (@thelodicaPlasma,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_alpha2'),0),
		   (@thelodicaPlasma,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_alpha2'),0),
		   (@thelodicaPlasma,1350,1650,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_alpha2'),0),
		   (@thelodicaPlasma,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_beta1'),0),
		   (@thelodicaPlasma,1013,1238,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_beta1'),0),
		   (@thelodicaPlasma,2025,2475,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_beta1'),0),
		   (@thelodicaPlasma,975,1192,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_beta2'),0),
		   (@thelodicaPlasma,1463,1788,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_beta2'),0),
		   (@thelodicaPlasma,2925,3575,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_beta2'),0),
		   		   	-- Frags Common
           (@thelodicaBasicFrag,10,15,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_alpha1'),0),
		   (@thelodicaAdvFrag,10,15,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_alpha1'),0),
		   (@thelodicaExpFrag,10,15,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_alpha1'),0),

           (@thelodicaBasicFrag,15,20,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_alpha1'),0),
		   (@thelodicaAdvFrag,15,20,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_alpha1'),0),
		   (@thelodicaExpFrag,15,20,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_alpha1'),0),

		   (@thelodicaBasicFrag,20,25,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_alpha1'),0),
		   (@thelodicaAdvFrag,20,25,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_alpha1'),0),
		   (@thelodicaExpFrag,20,25,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_alpha1'),0),

		   (@thelodicaBasicFrag,25,30,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_alpha2'),0),
		   (@thelodicaAdvFrag,25,30,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_alpha2'),0),
		   (@thelodicaExpFrag,25,30,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_alpha2'),0),

		   (@thelodicaBasicFrag,30,35,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_alpha2'),0),
		   (@thelodicaAdvFrag,30,35,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_alpha2'),0),
		   (@thelodicaExpFrag,30,35,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_alpha2'),0),

		   (@thelodicaBasicFrag,35,40,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_alpha2'),0),
		   (@thelodicaAdvFrag,35,40,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_alpha2'),0),
		   (@thelodicaExpFrag,35,40,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_alpha2'),0),

		   (@thelodicaBasicFrag,40,45,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_beta1'),0),
		   (@thelodicaAdvFrag,40,45,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_beta1'),0),
		   (@thelodicaExpFrag,40,45,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_beta1'),0),

		   (@thelodicaBasicFrag,45,50,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_beta1'),0),
		   (@thelodicaAdvFrag,45,50,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_beta1'),0),
		   (@thelodicaExpFrag,45,50,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_beta1'),0),

		   (@thelodicaBasicFrag,50,55,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_beta1'),0),
		   (@thelodicaAdvFrag,50,55,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_beta1'),0),
		   (@thelodicaExpFrag,50,55,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_beta1'),0),

		   (@thelodicaBasicFrag,55,60,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_beta2'),0),
		   (@thelodicaAdvFrag,55,60,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_beta2'),0),
		   (@thelodicaExpFrag,55,60,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_beta2'),0),

		   (@thelodicaBasicFrag,60,65,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_beta2'),0),
		   (@thelodicaAdvFrag,60,65,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_beta2'),0),
		   (@thelodicaExpFrag,60,65,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_beta2'),0),

		   (@thelodicaBasicFrag,65,70,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_beta2'),0),
		   (@thelodicaAdvFrag,65,70,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_beta2'),0),
		   (@thelodicaExpFrag,65,70,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_beta2'),0),

			--Pelistal types
			--Kernel - Common 50%
           (@commonKernel,300,367,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_alpha1'),0),
           (@commonKernel,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_alpha1'),0),
		   (@commonKernel,900,1100,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_alpha1'),0),
		   (@commonKernel,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_alpha2'),0),
		   (@commonKernel,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_alpha2'),0),
		   (@commonKernel,1350,1650,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_alpha2'),0),
		   (@commonKernel,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_beta1'),0),
		   (@commonKernel,1013,1238,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_beta1'),0),
		   (@commonKernel,2025,2475,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_beta1'),0),
		   (@commonKernel,975,1192,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_beta2'),0),
		   (@commonKernel,1463,1788,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_beta2'),0),
		   (@commonKernel,2925,3575,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_beta2'),0),
		   --Kernel - pelistal 50%
           (@pelistalKernel,300,367,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_alpha1'),0),
           (@pelistalKernel,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_alpha1'),0),
		   (@pelistalKernel,900,1100,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_alpha1'),0),
		   (@pelistalKernel,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_alpha2'),0),
		   (@pelistalKernel,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_alpha2'),0),
		   (@pelistalKernel,1350,1650,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_alpha2'),0),
		   (@pelistalKernel,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_beta1'),0),
		   (@pelistalKernel,1013,1238,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_beta1'),0),
		   (@pelistalKernel,2025,2475,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_beta1'),0),
		   (@pelistalKernel,975,1192,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_beta2'),0),
		   (@pelistalKernel,1463,1788,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_beta2'),0),
		   (@pelistalKernel,2925,3575,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_beta2'),0),
		   --Plasma - pelistal
           (@pelistalPlasma,300,367,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_alpha1'),0),
           (@pelistalPlasma,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_alpha1'),0),
		   (@pelistalPlasma,900,1100,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_alpha1'),0),
		   (@pelistalPlasma,450,550,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_alpha2'),0),
		   (@pelistalPlasma,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_alpha2'),0),
		   (@pelistalPlasma,1350,1650,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_alpha2'),0),
		   (@pelistalPlasma,675,825,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_beta1'),0),
		   (@pelistalPlasma,1013,1238,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_beta1'),0),
		   (@pelistalPlasma,2025,2475,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_beta1'),0),
		   (@pelistalPlasma,975,1192,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_beta2'),0),
		   (@pelistalPlasma,1463,1788,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_beta2'),0),
		   (@pelistalPlasma,2925,3575,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_beta2'),0),
		   	-- Frags pelistal
           (@pelistalBasicFrag,10,15,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_alpha1'),0),
		   (@pelistalAdvFrag,10,15,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_alpha1'),0),
		   (@pelistalExpFrag,10,15,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_alpha1'),0),

           (@pelistalBasicFrag,15,20,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_alpha1'),0),
		   (@pelistalAdvFrag,15,20,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_alpha1'),0),
		   (@pelistalExpFrag,15,20,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_alpha1'),0),

		   (@pelistalBasicFrag,20,25,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_alpha1'),0),
		   (@pelistalAdvFrag,20,25,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_alpha1'),0),
		   (@pelistalExpFrag,20,25,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_alpha1'),0),

		   (@pelistalBasicFrag,25,30,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_alpha2'),0),
		   (@pelistalAdvFrag,25,30,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_alpha2'),0),
		   (@pelistalExpFrag,25,30,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_alpha2'),0),

		   (@pelistalBasicFrag,30,35,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_alpha2'),0),
		   (@pelistalAdvFrag,30,35,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_alpha2'),0),
		   (@pelistalExpFrag,30,35,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_alpha2'),0),

		   (@pelistalBasicFrag,35,40,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_alpha2'),0),
		   (@pelistalAdvFrag,35,40,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_alpha2'),0),
		   (@pelistalExpFrag,35,40,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_alpha2'),0),

		   (@pelistalBasicFrag,40,45,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_beta1'),0),
		   (@pelistalAdvFrag,40,45,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_beta1'),0),
		   (@pelistalExpFrag,40,45,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_beta1'),0),

		   (@pelistalBasicFrag,45,50,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_beta1'),0),
		   (@pelistalAdvFrag,45,50,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_beta1'),0),
		   (@pelistalExpFrag,45,50,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_beta1'),0),

		   (@pelistalBasicFrag,50,55,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_beta1'),0),
		   (@pelistalAdvFrag,50,55,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_beta1'),0),
		   (@pelistalExpFrag,50,55,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_beta1'),0),

		   (@pelistalBasicFrag,55,60,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_beta2'),0),
		   (@pelistalAdvFrag,55,60,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_beta2'),0),
		   (@pelistalExpFrag,55,60,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_beta2'),0),

		   (@pelistalBasicFrag,60,65,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_beta2'),0),
		   (@pelistalAdvFrag,60,65,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_beta2'),0),
		   (@pelistalExpFrag,60,65,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_beta2'),0),

		   (@pelistalBasicFrag,65,70,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_beta2'),0),
		   (@pelistalAdvFrag,65,70,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_beta2'),0),
		   (@pelistalExpFrag,65,70,1.0,(SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_beta2'),0);
GO




DECLARE @newVirginia int;
DECLARE @hersh int;
DECLARE @domhalarn int;
DECLARE @hokk int;
DECLARE @hoop int;
DECLARE @kent int;
DECLARE @alsbale int;
DECLARE @nova int;

SET @newVirginia = (SELECT TOP 1 id FROM zones WHERE note='new virginia');
SET @hersh = (SELECT TOP 1 id FROM zones WHERE note='hershfield');
SET @domhalarn = (SELECT TOP 1 id FROM zones WHERE note='domhalarn');
SET @hokk = (SELECT TOP 1 id FROM zones WHERE note='hokkogaros');
SET @hoop = (SELECT TOP 1 id FROM zones WHERE note='norhoop');
SET @kent = (SELECT TOP 1 id FROM zones WHERE note='kentagura');
SET @alsbale = (SELECT TOP 1 id FROM zones WHERE note='alsbale');
SET @nova = (SELECT TOP 1 id FROM zones WHERE note='novastrov');

PRINT N'Assign spawnrates for each type to each zone';
INSERT INTO [dbo].[relicspawninfo]
           ([relictypeid],[zoneid],[rate],[x],[y])
VALUES
			--NV alpha1
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_alpha1'),@newVirginia,30,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_alpha1'),@newVirginia,20,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_alpha1'),@newVirginia,10,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_alpha1'),@newVirginia,30,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_alpha1'),@newVirginia,20,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_alpha1'),@newVirginia,10,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_alpha1'),@newVirginia,30,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_alpha1'),@newVirginia,20,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_alpha1'),@newVirginia,10,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_alpha1'),@newVirginia,30,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_alpha1'),@newVirginia,20,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_alpha1'),@newVirginia,10,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_alpha1'),@newVirginia,30,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_alpha1'),@newVirginia,20,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_alpha1'),@newVirginia,10,NULL,NULL),
		   --hersh A2
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_alpha2'),@hersh,30,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_alpha2'),@hersh,20,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_alpha2'),@hersh,10,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_alpha2'),@hersh,30,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_alpha2'),@hersh,20,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_alpha2'),@hersh,10,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_alpha2'),@hersh,30,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_alpha2'),@hersh,20,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_alpha2'),@hersh,10,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_alpha2'),@hersh,30,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_alpha2'),@hersh,20,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_alpha2'),@hersh,10,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_alpha2'),@hersh,30,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_alpha2'),@hersh,20,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_alpha2'),@hersh,10,NULL,NULL),
		   --Domharlarn - numiqol B1
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_beta1'),@domhalarn,30,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_beta1'),@domhalarn,20,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_beta1'),@domhalarn,10,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_beta1'),@domhalarn,30,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_beta1'),@domhalarn,20,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_beta1'),@domhalarn,10,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_beta1'),@domhalarn,120,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_beta1'),@domhalarn,80,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_beta1'),@domhalarn,40,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_beta1'),@domhalarn,30,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_beta1'),@domhalarn,20,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_beta1'),@domhalarn,10,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_beta1'),@domhalarn,30,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_beta1'),@domhalarn,20,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_beta1'),@domhalarn,10,NULL,NULL),
		   --Hokkogaros - thelodica B1
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_beta1'),@hokk,30,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_beta1'),@hokk,20,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_beta1'),@hokk,10,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_beta1'),@hokk,30,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_beta1'),@hokk,20,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_beta1'),@hokk,10,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_beta1'),@hokk,30,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_beta1'),@hokk,20,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_beta1'),@hokk,10,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_beta1'),@hokk,120,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_beta1'),@hokk,80,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_beta1'),@hokk,40,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_beta1'),@hokk,30,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_beta1'),@hokk,20,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_beta1'),@hokk,10,NULL,NULL),
		   --Norhoop - pelistal B1
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_beta1'),@hoop,30,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_beta1'),@hoop,20,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_beta1'),@hoop,10,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_beta1'),@hoop,30,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_beta1'),@hoop,20,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_beta1'),@hoop,10,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_beta1'),@hoop,30,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_beta1'),@hoop,20,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_beta1'),@hoop,10,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_beta1'),@hoop,30,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_beta1'),@hoop,20,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_beta1'),@hoop,10,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_beta1'),@hoop,120,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_beta1'),@hoop,80,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_beta1'),@hoop,40,NULL,NULL),

		   --Novastrov - numiqol B2
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_beta2'),@nova,30,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_beta2'),@nova,20,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_beta2'),@nova,10,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_beta2'),@nova,30,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_beta2'),@nova,20,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_beta2'),@nova,10,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_beta2'),@nova,120,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_beta2'),@nova,80,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_beta2'),@nova,40,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_beta2'),@nova,30,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_beta2'),@nova,20,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_beta2'),@nova,10,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_beta2'),@nova,30,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_beta2'),@nova,20,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_beta2'),@nova,10,NULL,NULL),
		   --Kentagura - thelodica B2
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_beta2'),@kent,30,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_beta2'),@kent,20,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_beta2'),@kent,10,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_beta2'),@kent,30,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_beta2'),@kent,20,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_beta2'),@kent,10,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_beta2'),@kent,30,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_beta2'),@kent,20,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_beta2'),@kent,10,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_beta2'),@kent,120,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_beta2'),@kent,80,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_beta2'),@kent,40,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_beta2'),@kent,30,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_beta2'),@kent,20,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_beta2'),@kent,10,NULL,NULL),
		   --Alsbale - pelistal B2
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_neutral_beta2'),@alsbale,30,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_neutral_beta2'),@alsbale,20,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_neutral_beta2'),@alsbale,10,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_indy_beta2'),@alsbale,30,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_indy_beta2'),@alsbale,20,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_indy_beta2'),@alsbale,10,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_numiqol_beta2'),@alsbale,30,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_numiqol_beta2'),@alsbale,20,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_numiqol_beta2'),@alsbale,10,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_thelodica_beta2'),@alsbale,30,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_thelodica_beta2'),@alsbale,20,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_thelodica_beta2'),@alsbale,10,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level1_pelistal_beta2'),@alsbale,120,NULL,NULL),
           ((SELECT relictypes.id FROM relictypes WHERE name='relic_level2_pelistal_beta2'),@alsbale,80,NULL,NULL),
		   ((SELECT relictypes.id FROM relictypes WHERE name='relic_level3_pelistal_beta2'),@alsbale,40,NULL,NULL);

GO
--Also note where a zone does not have any relictypes to select from, that zone will also have a null RelicManager to safely prevent issues server-side



--Let's see what happened!
SELECT * from reliczoneconfig;
SELECT * from relicspawninfo;
SELECT * from relictypes;
SELECT * from relicloot;
--wow cool

PRINT N'DONE! Init-ing relic tables';

GO


-----------------------------------------------------
--ScannerAmmo_aggvalues__2019_03_02.sql
-----------------------------------------------------


USE [perpetuumsa]
GO


----------------------------
--Content Team: Balance Tile Scanner charge ranges
--Date: 3/2/2019
----------------------------


DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;


---Increase HDT Advanced Tile to 300M radius

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_mining_probe_crude_tile_rewa' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_ammo_mining_probe_crude_tile_rewa', quantity=1000, attributeflags=2048, categoryflags=133386, options='#mineral=$crude
#type=n1
', 
                note='', enabled=1, volume=0.5, mass=0.1, hidden=0, health=100, descriptiontoken='def_ammo_mining_probe_crude_tile_rewa_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'tile_based_mining_probe_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);



UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=30 WHERE id =  @aggvalueID;

---Increase Epi Advanced Tile to 300M radius

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_mining_probe_epriton_tile_rewa' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_ammo_mining_probe_epriton_tile_rewa', quantity=1000, attributeflags=2048, categoryflags=133386, options='#mineral=$epriton
#type=n1
', 
                note='', enabled=1, volume=0.5, mass=0.1, hidden=0, health=100, descriptiontoken='def_ammo_mining_probe_epriton_tile_rewa_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'tile_based_mining_probe_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=30 WHERE id =  @aggvalueID;

---Increase Imentium Advanced Tile to 300M radius


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_mining_probe_imentium_tile_rewa' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_ammo_mining_probe_imentium_tile_rewa', quantity=1000, attributeflags=2048, categoryflags=133386, options='#mineral=$imentium
#type=n1
', 
                note='', enabled=1, volume=0.5, mass=0.1, hidden=0, health=100, descriptiontoken='def_ammo_mining_probe_imentium_tile_rewa_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'tile_based_mining_probe_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=30 WHERE id =  @aggvalueID;


---Increase liquizit Advanced Tile to 300M radius

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_mining_probe_liquizit_tile_rewa' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_ammo_mining_probe_liquizit_tile_rewa', quantity=1000, attributeflags=2048, categoryflags=133386, options='#mineral=$liquizit
#type=n1
', 
                note='', enabled=1, volume=0.5, mass=0.1, hidden=0, health=100, descriptiontoken='def_ammo_mining_probe_liquizit_tile_rewa_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'tile_based_mining_probe_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=30 WHERE id =  @aggvalueID;

---Increase Silgium regular Tile to 100M radius


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_mining_probe_silgium_tile' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_ammo_mining_probe_silgium_tile', quantity=1000, attributeflags=2048, categoryflags=133386, options='#mineral=$silgium
#type=n1
', 
                note='per tile scannel', enabled=1, volume=0.5, mass=0.1, hidden=0, health=100, descriptiontoken='def_ammo_mining_probe_tile_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'tile_based_mining_probe_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 10);

---Increase Stermonit Advanced Tile to 300M radius

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_mining_probe_stermonit_tile_rewa' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_ammo_mining_probe_stermonit_tile_rewa', quantity=1000, attributeflags=2048, categoryflags=133386, options='#mineral=$stermonit
#type=n1
', 
                note='', enabled=1, volume=0.5, mass=0.1, hidden=0, health=100, descriptiontoken='def_ammo_mining_probe_stermonit_tile_rewa_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'tile_based_mining_probe_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=30 WHERE id =  @aggvalueID;

---Increase Titan Advanced Tile to 300M radius

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_mining_probe_titan_tile_rewa' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_ammo_mining_probe_titan_tile_rewa', quantity=1000, attributeflags=2048, categoryflags=133386, options='#mineral=$titan
#type=n1
', 
                note='', enabled=1, volume=0.5, mass=0.1, hidden=0, health=100, descriptiontoken='def_ammo_mining_probe_titan_tile_rewa_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'tile_based_mining_probe_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=30 WHERE id =  @aggvalueID;

---Increase Silgium Advanced Tile to 300M radius

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_mining_probe_silgium_tile_rewa' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_ammo_mining_probe_silgium_tile_rewa', quantity=1000, attributeflags=2048, categoryflags=133386, options='#mineral=$silgium
#type=n1
', 
                note='', enabled=1, volume=0.5, mass=0.1, hidden=0, health=100, descriptiontoken='def_ammo_mining_probe_silgium_tile_rewa_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'tile_based_mining_probe_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 30);

GO


-----------------------------------------------------------
--ZoneEntities_remove_stronghold_tele_column__2019_04_01.sql
-----------------------------------------------------------
USE [perpetuumsa]
GO

-------------------------------------------
--Remove (disable) Teleport on Omega
--Date: 2019/04/01
-------------------------------------------


UPDATE dbo.zoneentities SET
enabled=0
WHERE 
ename='tp_zone_16_1' AND
zoneID = (SELECT TOP 1 id FROM dbo.zones WHERE name='zone_pvp_arena');

GO


PRINT N'PATCH 10 HAS APPLIED, BEST CHECK YO SELF BEFORE YO REK YOSELF';
GO