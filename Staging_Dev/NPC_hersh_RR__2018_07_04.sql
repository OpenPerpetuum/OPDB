USE [perpetuumsa]
GO


PRINT N'HERSHFIELD ROUGH RIDERS';

DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
DECLARE @templateID int;
DECLARE @lootdefinitionID int;
DECLARE @npclootID int;
DECLARE @presenceID int;
DECLARE @flockID int;


PRINT N'INSERT ENTITYDEF def_npc_One_Eye_Josef';
INSERT INTO entitydefaults ( definitionname ,  quantity ,  attributeflags ,  categoryflags ,  options ,  note ,  enabled ,  volume ,  mass ,  hidden , 
                health ,  descriptiontoken ,  purchasable ,  tiertype ,  tierlevel ) 
                VALUES ( 'def_npc_One_Eye_Josef', 1, 1024, 911, '', '', 1, 0, 0, 'False', 100, 'def_npc_One_Eye_Josef', 0, 0, 0); 


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_One_Eye_Josef' ORDER BY definition DESC);

PRINT N'INSERT [aggregatevalues] FOR def_npc_One_Eye_Josef';
UPDATE entitydefaults Set definitionname='def_npc_One_Eye_Josef', quantity=1, attributeflags=1024, categoryflags=911, options='', 
                note='', enabled=1, volume=0, mass=0, hidden='False', health=100, descriptiontoken='def_npc_One_Eye_Josef', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'armor_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2.0);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.5);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_recharge_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.0);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'damage_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.75);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'falloff_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.5);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locking_range_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.25);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locking_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.75);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'missile_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.75);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'optimal_range_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.5);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_max_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 2);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'turret_cycle_time_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 1.0);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'received_repaired_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 0.1);


PRINT N'INSERT [robottemplaterelation] FOR def_npc_One_Eye_Josef TO echelon_masterdeathdealer';
SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'echelon_masterdeathdealer' ORDER BY id DESC)

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_One_Eye_Josef' ORDER BY definition DESC);

INSERT INTO [dbo].[robottemplaterelation] ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
                VALUES (@definitionID,@templateID,0,0,6,0,15,'def_NPC_One_Eye_Josef');


PRINT N'INSERT LOOTS FOR def_npc_One_Eye_Josef';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_One_Eye_Josef' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 15000, 1, 1,1, 12000);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 2500, 1, 1,1, 2000);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1000, 1, 1,1, 750);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 350, 0.5, 1,1, 250);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_advanced' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 350, 0.5, 1,1, 250);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_4' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.5, 1,1, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_5' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.5, 1,1, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_6' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.5, 1,1, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_armor_plate_pr' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.1, 1,1, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_armor_plate_pr' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.1, 1,1, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_armor_repairer_pr' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.1, 1,1, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_armor_repairer_pr' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.1, 1,1, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_sensor_booster_pr' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.1, 1,1, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_mass_reductor_pr' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.1, 1,1, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_7' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.5, 1,1, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_8' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.5, 1,1, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_longrange_medium_autocannon' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 2, 0.5, 1,1, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_damage_mod_projectile' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 2, 0.5, 1,1, 1);


PRINT N'INSERT [npcpresence] FOR hershfield_rough_riders';
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES 
				('hershfield_rough_riders',10,10,2038,2038,'',13,1,0,0,0,0,0,0,0,0,0,1,0);

GO


PRINT N'INSERT [npcflock]s FOR hershfield_rough_riders';
DECLARE @presenceID int;
DECLARE @definitionID int;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_rough_riders' ORDER BY id DESC);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_One_Eye_Josef' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Hersh_RR_1', @presenceID, 1, @definitionID, 1976, 1810, 0, 5, 7200, 0, 30, 'Hersh_RR_1', 1, 1, 1, 1); 

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'Rough Rider Cavalry' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Hersh_RR_2', @presenceID, 2, @definitionID, 1976, 1810, 0, 5, 900, 0, 30, 'Hersh_RR_2', 1, 1, 1, 1); 

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Hersh_RR_3', @presenceID, 2, @definitionID, 1930, 1753, 0, 5, 900, 0, 30, 'Hersh_RR_3', 1, 1, 1, 1); 

INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Hersh_RR_4', @presenceID, 2, @definitionID, 1869, 1890, 0, 5, 900, 0, 30, 'Hersh_RR_4', 1, 1, 1, 1); 


INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('Hersh_RR_5', @presenceID, 2, @definitionID, 1760, 1846, 0, 5, 900, 0, 30, 'Hersh_RR_5', 1, 1, 1, 1); 



GO