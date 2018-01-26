USE perpetuumsa
GO

DECLARE @presenceID int;
DECLARE @flockID int;
DECLARE @definitionID int;
DECLARE @robottemplateid int;
DECLARE @lootdefinitionID int;
DECLARE @npclootID int;


-- Disable existing Hershfield spawns
 UPDATE npcpresence
  SET [enabled] = 0 
  WHERE spawnid = 13

-- Add spawns
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('hershfield_syndicate_npcs',959,283,1159,483,'',13,1,0,0,3,3,1059
			    ,383,5,'',0,1,0);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_syndicate_npcs' ORDER BY id DESC);
UPDATE [dbo].[npcpresence]
                SET [name] = 'hershfield_syndicate_npcs',[topx] = 959,[topy] = 283,[bottomx] = 1159,[bottomy] = 483,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('mech_at_spawn1', @presenceID, 2, @definitionID, 1590, 1550, 0, 5, 60, 0,
                 10, 'mech_at_spawn1', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hm_at_spawn1', @presenceID, 2, @definitionID, 1590, 1550, 0, 5, 60, 0,
                 10, 'hm_at_spawn1', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('assault_at_spawn2', @presenceID, 2, @definitionID, 1370, 1720, 0, 5, 60, 0,
                 10, 'assault_at_spawn2', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('light_at_spawn2', @presenceID, 2, @definitionID, 864, 962, 0, 5, 60, 0,
                 10, 'light_at_spawn2', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hm_at_spawn3', @presenceID, 3, @definitionID, 1080, 1870, 0, 5, 60, 0,
                 10, 'hm_at_spawn3', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('mech_at_spawn3', @presenceID, 2, @definitionID, 1080, 1870, 0, 5, 60, 0,
                 10, 'mech_at_spawn3', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('mech_at_spawn4', @presenceID, 3, @definitionID, 1410, 1090, 0, 5, 60, 0,
                 10, 'mech_at_spawn4', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('light_at_spawn4', @presenceID, 2, @definitionID, 1410, 1090, 0, 5, 60, 0,
                 10, 'light_at_spawn4', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hm_at_spawn5', @presenceID, 2, @definitionID, 1170, 1020, 0, 5, 60, 0,
                 10, 'hm_at_spawn5', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('assault_at_spawn_6', @presenceID, 4, @definitionID, 1350, 780, 0, 5, 60, 0,
                 10, 'assault_at_spawn6', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ikarus_abstrans_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('lighttrans_at_spawn6', @presenceID, 2, @definitionID, 1350, 780, 0, 5, 60, 0,
                 10, 'lighttrans_at_spawn6', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('mech_at_spawn7', @presenceID, 3, @definitionID, 940, 1111, 0, 5, 60, 0,
                 10, 'mech_at_spawn7', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('light_at_spawn8', @presenceID, 3, @definitionID, 760, 935, 0, 5, 60, 0,
                 10, 'light_at_spawn8', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('assault_at_spawn9', @presenceID, 3, @definitionID, 940, 590, 0, 5, 60, 0,
                 10, 'assault_at_spawn9', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('light_at_spawn10', @presenceID, 3, @definitionID, 1160, 640, 0, 5, 60, 0,
                 10, 'light_at_spawn10', 1, 1, 1, 1);

---------------------------
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('hershfield_industrials_npcs',10,10,2038,2038,'',13,1,0,0,0,0,0
			    ,0,0,0,0,1,0);


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_industrials_npcs' ORDER BY id DESC);
UPDATE [dbo].[npcpresence]
                SET [name] = 'hershfield_industrials_npcs',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_symbiont_basic_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hmindy_at_spawn11', @presenceID, 3, @definitionID, 1580, 1710, 0, 5, 60, 0,
                 10, 'hmindy_at_spawn11', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_scarab_basic_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hm2indy_at_spawn11', @presenceID, 2, @definitionID, 1580, 1710, 0, 5, 60, 0,
                 10, 'hmindy_st_spawn11', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_lithus_basic_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hmindy_at_spawn12', @presenceID, 2, @definitionID, 1770, 1720, 0, 5, 60, 0,
                 10, 'hmindy_st_spawn12', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_riveler_basic_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hm2indy_at_spawn12', @presenceID, 3, @definitionID, 1770, 1720, 0, 5, 60, 0,
                 10, 'hmindy_at_spawn12', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_symbiont_basic_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hmindy_at_spawn13', @presenceID, 4, @definitionID, 1765, 1710, 0, 5, 60, 0,
                 10, 'hmindy_at_spawn13', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gargoyle_basic_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('mechindy_st_spawn14', @presenceID, 3, @definitionID, 1580, 800, 0, 5, 60, 0,
                 10, 'mechindy_at_spawn14', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sequer_basic_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('assaultindy_at_spawn14', @presenceID, 2, @definitionID, 1580, 800, 0, 5, 60, 0,
                 10, 'assaultindy_at_spawn14', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_termis_basic_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('mechindy_at_spawn15', @presenceID, 3, @definitionID, 1730, 990, 0, 5, 60, 0,
                 10, 'mechindy_at_apawn15', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_lithus_basic_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hmindy_at_spawn15', @presenceID, 2, @definitionID, 1730, 990, 0, 5, 60, 0,
                 10, 'hmindy_at_spawn15', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ikarus_abstrans_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('indy_at_spawn16', @presenceID, 2, @definitionID, 1760, 1270, 0, 5, 60, 0,
                 10, 'indy_at_spawn16', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_laird_basic_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('lightindy_at_spawn16', @presenceID, 2, @definitionID, 1760, 1270, 0, 5, 60, 0,
                 10, 'laird_at_16', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_argano_basic_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('lightindy2_at_spawn16', @presenceID, 2, @definitionID, 1760, 1270, 0, 5, 60, 0,
                 10, 'argano_at_16', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_termis_basic_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('mechspwan_at_17', @presenceID, 3, @definitionID, 1410, 1240, 0, 5, 60, 0,
                 10, 'mechspawn_at_17', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gargoyle_basic_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('mechspawn_at_18', @presenceID, 3, @definitionID, 1190, 820, 0, 5, 60, 0,
                 10, 'mechspawn_at_18', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_lithus_basic_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hmindy_at_spawn19', @presenceID, 3, @definitionID, 700, 1120, 0, 5, 60, 0,
                 10, 'hmindy_at_spawn19', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_riveler_basic_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hmindy_at_spawn20', @presenceID, 3, @definitionID, 1600, 1200, 0, 5, 60, 0,
                 10, 'hmindy_at_20', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_symbiont_basic_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hmindy2_at_spawn20', @presenceID, 3, @definitionID, 1600, 1200, 0, 5, 60, 0,
                 10, 'hmindy2_at_spawn20', 1, 1, 1, 1);

---------------------------
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('hershfield_pelistal_npcs',10,10,2038,2038,'',13,1,0,0,0,0,0
			    ,0,0,0,0,1,0);


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_pelistal_npcs' ORDER BY id DESC);
UPDATE [dbo].[npcpresence]
                SET [name] = 'hershfield_pelistal_npcs',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_castel_scout_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('castel_at_spawn21', @presenceID, 3, @definitionID, 1290, 1410, 0, 5, 60, 0,
                 10, 'castel_at_21', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_troiar_interceptor_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('troiar_at_spawn22', @presenceID, 2, @definitionID, 1180, 1490, 0, 5, 60, 0,
                 10, 'troiar_at_spawn22', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_waspish_dps_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('wasp_at_spn22', @presenceID, 2, @definitionID, 1180, 1490, 0, 5, 60, 0,
                 10, 'wasp_at_spn22', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_castel_dps_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('castel_at_spn23', @presenceID, 3, @definitionID, 1030, 1390, 0, 5, 60, 0,
                 10, 'castel_at_spn23', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_troiar_ewjammer_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('troiar_at_spn23', @presenceID, 2, @definitionID, 1030, 1390, 0, 5, 60, 0,
                 10, 'troiar_at_spn23', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_waspish_scout_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('wasp_at_spn24', @presenceID, 3, @definitionID, 940, 1500, 0, 5, 60, 0,
                 10, 'def_npc_waspish_scout_rank3', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_tank_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('mech_at_spn25', @presenceID, 3, @definitionID, 740, 1450, 0, 5, 60, 0,
                 10, 'def_npc_tyrannos_tank_rank3', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_troiar_heavyew_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('lew_at_spn25', @presenceID, 2, @definitionID, 740, 1450, 0, 5, 60, 0,
                 10, 'lew_at_spn25', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_heavydps_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hm_at_spwn26', @presenceID, 3, @definitionID, 600, 1485, 0, 5, 60, 0,
                 10, 'hm_at_spwn26', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_ew_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('mech_at_spwn26', @presenceID, 2, @definitionID, 600, 1485, 0, 5, 60, 0,
                 10, 'mech_at_spwn26', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_sniper_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hm_at_spwn27', @presenceID, 2, @definitionID, 690, 1700, 0, 5, 60, 0,
                 10, 'hm_at_spn27', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_tank_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hm2_spwn27', @presenceID, 2, @definitionID, 690, 1700, 0, 5, 60, 0,
                 10, 'hm2_spwn27', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ictus_heavyew_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('mech_spwn27', @presenceID, 3, @definitionID, 690, 1700, 0, 5, 60, 0,
                 10, 'mech_spwn27', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ictus_heavyew_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('mech_spwn28', @presenceID, 2, @definitionID, 500, 1730, 0, 5, 60, 0,
                 10, 'mech_spwn28', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_dps_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('mech2_spwn28', @presenceID, 2, @definitionID, 500, 1730, 0, 5, 60, 0,
                 10, 'mech2_spwn28', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_heavydps_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hm1_atspwn29', @presenceID, 3, @definitionID, 400, 1560, 0, 5, 60, 0,
                 10, 'hm1_at_spn29', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_gropho_sniper_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hm2_at_spwn29', @presenceID, 1, @definitionID, 400, 1560, 0, 5, 60, 0,
                 10, 'hm2_at_spwn29', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_ictus_heavyew_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('mech_at_spwn29', @presenceID, 3, @definitionID, 400, 1560, 0, 5, 60, 0,
                 10, 'mech_at_spwn29', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_waspish_dps_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('assault_at_spwn30', @presenceID, 2, @definitionID, 240, 1700, 0, 5, 60, 0,
                 10, 'assault_at_spwn30', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_tyrannos_dps_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('mech_at_spwn30', @presenceID, 2, @definitionID, 240, 1700, 0, 5, 60, 0,
                 10, 'mech_at_spawn30', 1, 1, 1, 1);

---------------------------
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('hershfield_theolodical_npcs',10,10,2038,2038,'',13,1,0,0,0,0,0
			    ,0,0,0,0,1,0);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_theolodical_npcs' ORDER BY id DESC);
UPDATE [dbo].[npcpresence]
                SET [name] = 'hershfield_theolodical_npcs',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_prometheus_interceptor_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('prom_at_spawn31', @presenceID, 3, @definitionID, 740, 550, 0, 5, 60, 0,
                 10, 'prom_at_spawn31', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_intakt_ewjammer_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('intakt_at_spawn32', @presenceID, 2, @definitionID, 620, 720, 0, 5, 60, 0,
                 10, 'intakt_at_spawn32', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_baphomet_dps_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('baph_at_spawn32', @presenceID, 2, @definitionID, 620, 720, 0, 5, 60, 0,
                 10, 'baph_at_spawn32', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_prometheus_dps_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('prom_at_spwn33', @presenceID, 3, @definitionID, 520, 920, 0, 5, 60, 0,
                 10, 'prom_at_spwn33', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_intakt_ewjammer_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('intakt_at_spwn33', @presenceID, 2, @definitionID, 520, 920, 0, 5, 60, 0,
                 10, 'intakt_at_spwn33', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_baphomet_scout_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('baph_at_spwn34', @presenceID, 2, @definitionID, 455, 740, 0, 5, 60, 0,
                 10, 'baph_at_spwn34', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_tank_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('art_at_spwn35', @presenceID, 3, @definitionID, 820, 320, 0, 5, 60, 0,
                 10, 'art_at_spwn35', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_intakt_heavyew_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('intakt_at_spwn35', @presenceID, 2, @definitionID, 820, 320, 0, 5, 60, 0,
                 10, 'intakt_at_spwn35', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_heavydps_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hm_at_spawn36', @presenceID, 3, @definitionID, 600, 430, 0, 5, 60, 0,
                 10, 'hm_at_spawn36', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_ew_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('mech_at_spawn36', @presenceID, 2, @definitionID, 600, 430, 0, 5, 60, 0,
                 10, 'mech_at_spawn36', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_sniper_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('sethsnip_at_spawn37', @presenceID, 2, @definitionID, 430, 540, 0, 5, 60, 0,
                 10, 'sethsnip_at_spawn37', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_tank_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('sethtank_at_spawn37', @presenceID, 2, @definitionID, 430, 540, 0, 5, 60, 0,
                 10, 'sethtank_at_spawn37', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_zenith_heavyew_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('mechew_at_spawn37', @presenceID, 3, @definitionID, 430, 540, 0, 5, 60, 0,
                 10, 'mechew_at_spawn37', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_zenith_heavyew_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('mechew_at_spawn38', @presenceID, 2, @definitionID, 550, 250, 0, 5, 60, 0,
                 10, 'mechew_at_spawn38', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_dps_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('art_at_spwn38', @presenceID, 2, @definitionID, 550, 250, 0, 5, 60, 0,
                 10, 'art_at_spwn38', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_heavydps_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hm_at_spwn39', @presenceID, 3, @definitionID, 260, 650, 0, 5, 60, 0,
                 10, 'hm_at_spwn39', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_seth_sniper_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('hm2_at_spwn39', @presenceID, 1, @definitionID, 260, 650, 0, 5, 60, 0,
                 10, 'hm2_spwn39', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_zenith_heavyew_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('mechew_at_spwn39', @presenceID, 3, @definitionID, 260, 650, 0, 5, 60, 0,
                 10, 'mechew_at_spwn39', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_baphomet_dps_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('bapho_at_spwn30', @presenceID, 2, @definitionID, 385, 300, 0, 5, 60, 0,
                 10, 'bapho_at_spwn30', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_artemis_dps_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('mech_at_spwn30', @presenceID, 2, @definitionID, 385, 300, 0, 5, 60, 0,
                 10, 'mech_at_spwn30', 1, 1, 1, 1);

---------------------------
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('hershfield_numiquol_npcs',10,10,2038,2038,'',13,1,0,0,0,0,0
			    ,0,0,0,0,1,0);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_numiquol_npcs' ORDER BY id DESC);
UPDATE [dbo].[npcpresence]
                SET [name] = 'hershfield_numiquol_npcs',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = '',[spawnid] = 13,[enabled] = 1,[roaming] = 0
                ,[roamingrespawnseconds] = 0,[presencetype] = 0,[maxrandomflock] = 0,[randomcenterx] = 0,[randomcentery] = 0
                ,[randomradius] = 0,[dynamiclifetime] = 0 ,[isbodypull] = 0,[isrespawnallowed] = 1,[safebodypull] = 0
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_scout_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('yagel_at_spawn41', @presenceID, 3, @definitionID, 1510, 620, 0, 5, 60, 0,
                 10, 'yagel_at_spawn41', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_cameleon_interceptor_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('cam_at_spawn42', @presenceID, 2, @definitionID, 1540, 450, 0, 5, 60, 0,
                 10, 'cam_at_spawn42', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_dps_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('arby_at_spawn42', @presenceID, 2, @definitionID, 1540, 450, 0, 5, 60, 0,
                 10, 'arby_at_spwn42', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_yagel_dps_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('yagel_at_spawn43', @presenceID, 3, @definitionID, 1350, 320, 0, 5, 60, 0,
                 10, 'yagel_at_spawn43', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_cameleon_ewjammer_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('cam_at_spawn43', @presenceID, 2, @definitionID, 1350, 320, 0, 5, 60, 0,
                 10, 'cam_at_spawn43', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_scout_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('arby_at_spwn44', @presenceID, 3, @definitionID, 1260, 420, 0, 5, 60, 0,
                 10, 'arby_at_spawn44', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_tank_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kain_at_spawn45', @presenceID, 3, @definitionID, 1170, 420, 0, 5, 60, 0,
                 10, 'kain_at_spawn45', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_cameleon_heavyew_rank3' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('cam_at_spawn45', @presenceID, 2, @definitionID, 1170, 420, 0, 5, 60, 0,
                 10, 'cam_at_spawn45', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_heavydps_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('mesmer_at_spawn46', @presenceID, 3, @definitionID, 1030, 380, 0, 5, 60, 0,
                 10, 'mesmer_at_spawn46', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_ew_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kain_at_spawn46', @presenceID, 2, @definitionID, 1030, 380, 0, 5, 60, 0,
                 10, 'kain_at_spawn46', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_sniper_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('mesmer_at_spawn47', @presenceID, 2, @definitionID, 1320, 540, 0, 5, 60, 0,
                 10, 'mesmer_at_spawn47', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_tank_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('mesmer2_at_spawn47', @presenceID, 2, @definitionID, 1320, 540, 0, 5, 60, 0,
                 10, 'mesmer2_at_spawn47', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vagabond_heavyew_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('vag_at_spawn47', @presenceID, 3, @definitionID, 1320, 540, 0, 5, 60, 0,
                 10, 'vag_at_span47', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vagabond_heavyew_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('vag_at_spawn48', @presenceID, 2, @definitionID, 1470, 290, 0, 5, 60, 0,
                 10, 'vag_at_spawn48', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_dps_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kain_at_spawn48', @presenceID, 2, @definitionID, 1470, 290, 0, 5, 60, 0,
                 10, 'kain_at_spawn48', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_heavydps_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('mesmer_at_spawn49', @presenceID, 3, @definitionID, 1290, 280, 0, 5, 60, 0,
                 10, 'mesmer_at_spawn49', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_mesmer_sniper_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('mesmer2_at_spawn49', @presenceID, 1, @definitionID, 1290, 280, 0, 5, 60, 0,
                 10, 'mesmer_at_spawn49', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_vagabond_heavyew_rank4' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('vag_at_spawn49', @presenceID, 3, @definitionID, 1290, 280, 0, 5, 60, 0,
                 10, 'vag_at_spawn49', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_arbalest_dps_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('arby_at_50', @presenceID, 2, @definitionID, 1320, 190, 0, 5, 60, 0,
                 10, 'arby_at_spawn50', 1, 1, 1, 1);
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_kain_dps_rank2' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('kain_at_50', @presenceID, 2, @definitionID, 1320, 190, 0, 5, 60, 0,
                 10, 'kain_at_50', 1, 1, 1, 1);

---------------------------
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('hershfield_grandobservers_npcs',10,10,2038,2038,'caravan',13,1,1,1800,1,'',''
			    ,'','','',1,0,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_grandobservers_npcs' ORDER BY id DESC);
UPDATE [dbo].[npcpresence]
                SET [name] = 'hershfield_grandobservers_npcs',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = 'caravan',[spawnid] = 13,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 1800,[presencetype] = 1,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_roaming_arbalest_alpha' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('arby_grand_observer', @presenceID, 2, @definitionID, 849, 560, 2, 5, 60, 0,
                 10, 'grand_observer', 1, 1, 1, 2);

---------------------------
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('hershfield_grandobservers2_npcs',10,10,2038,2038,'caravan',13,1,1,1800,1,'',''
			    ,'','','',1,0,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_grandobservers2_npcs' ORDER BY id DESC);
UPDATE [dbo].[npcpresence]
                SET [name] = 'hershfield_grandobservers2_npcs',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = 'caravan',[spawnid] = 13,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 1800,[presencetype] = 1,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_roaming_baphomet_alpha' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('baph_grand_observer', @presenceID, 2, @definitionID, 849, 560, 2, 5, 60, 0,
                 10, 'baph_grand_observer', 1, 1, 1, 2);

---------------------------
INSERT INTO [dbo].[npcpresence] ([name],[topx],[topy],[bottomx],[bottomy],[note],[spawnid],[enabled],[roaming],[roamingrespawnseconds]
                ,[presencetype],[maxrandomflock],[randomcenterx],[randomcentery],[randomradius],[dynamiclifetime],[isbodypull],[isrespawnallowed],[safebodypull])
                VALUES ('hershfield_grandobservers3_npcs',10,10,2038,2038,'caravan',13,1,1,1800,1,'',''
			    ,'','','',1,0,1);

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'hershfield_grandobservers3_npcs' ORDER BY id DESC);
UPDATE [dbo].[npcpresence]
                SET [name] = 'hershfield_grandobservers3_npcs',[topx] = 10,[topy] = 10,[bottomx] = 2038,[bottomy] = 2038,[note] = 'caravan',[spawnid] = 13,[enabled] = 1,[roaming] = 1
                ,[roamingrespawnseconds] = 1800,[presencetype] = 1,[maxrandomflock] = '',[randomcenterx] = '',[randomcentery] = ''
                ,[randomradius] = '',[dynamiclifetime] = '' ,[isbodypull] = 1,[isrespawnallowed] = 0,[safebodypull] = 1
                WHERE id=@presenceID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_roaming_waspish_alpha' ORDER BY definition DESC);
INSERT INTO[dbo].[npcflock]([name],[presenceid],[flockmembercount],[definition],[spawnoriginX],[spawnoriginY],[spawnrangeMin],[spawnrangeMax],[respawnseconds]
                ,[totalspawncount],[homerange],[note],[respawnmultiplierlow],[enabled],[iscallforhelp],[behaviorType]) VALUES
                ('waspish_grand_observer', @presenceID, 2, @definitionID, 849, 560, 2, 5, 60, 0,
                 10, 'waspish_grand_observer', 1, 1, 1, 2);

---------------------------






