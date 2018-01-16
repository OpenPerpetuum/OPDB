USE perpetuumsa
GO

DECLARE @presenceID int;
DECLARE @flockID int;
DECLARE @definitionID int;
DECLARE @robottemplateid int;
DECLARE @lootdefinitionID int;
DECLARE @npclootID int;


--ADD NPC's
INSERT INTO robottemplates ([name], [description], [note]) VALUES ('vektor_swab_lead', '#robot=i1580#head=i1581#chassis=i1582#leg=i1583#container=i147#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i33|slot=i2]|m2=[|definition=i390|slot=i3]]#chassisModules=[|m0=[|definition=i3c|slot=i1|ammoDefinition=i103|ammoQuantity=ic8]|m1=[|definition=i3c|slot=i2|ammoDefinition=i103|ammoQuantity=ic8]|m2=[|definition=i3c|slot=i3|ammoDefinition=i103|ammoQuantity=ic8]|m3=[|definition=i3c|slot=i4|ammoDefinition=i103|ammoQuantity=ic8]]#legModules=[|m0=[|definition=ie|slot=i1]|m1=[|definition=i12|slot=i2]]', 'Vektor Swab Lead')

SET @robottemplateid = (SELECT TOP 1 id FROM robottemplates WHERE [name] = 'vektor_swab_lead' ORDER BY id DESC)

---------------------------
INSERT INTO entitydefaults ( definitionname ,  quantity ,  attributeflags ,  categoryflags ,  options ,  note ,  enabled ,  volume ,  mass ,  hidden , 
                health ,  descriptiontoken ,  purchasable ,  tiertype ,  tierlevel ) 
                VALUES ( 'def_npc_vektor_swab_rank1', 1, 1024, 911, '', '', 1, 0, 0, 'False', 100, 'def_npc_prometheus_dps_rank1_desc', 0, 0, 0); 

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank1' ORDER BY [definition] DESC)

INSERT INTO [dbo].[robottemplaterelation] ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
                VALUES (@definitionID,@robottemplateid,0,0,0,0,1,'EMPTY/NEW TEMPLATE--PLEASE EDIT AND SAVE AS NEW!');

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 17, 0.6);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 20, 0.5);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 63, 2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 143, 0.6);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 253, 1.2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 263, 2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 331, 0.4);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 335, 1.4);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 506, 0.1);

---------------------------
INSERT INTO entitydefaults ( definitionname ,  quantity ,  attributeflags ,  categoryflags ,  options ,  note ,  enabled ,  volume ,  mass ,  hidden , 
                health ,  descriptiontoken ,  purchasable ,  tiertype ,  tierlevel ) 
                VALUES ( 'def_npc_vektor_swab_rank2', 1, 1024, 911, '', '', 1, 0, 0, 'False', 100, 'def_npc_prometheus_dps_rank1_desc', 0, 0, 0);
				
SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank2' ORDER BY [definition] DESC) 

INSERT INTO [dbo].[robottemplaterelation] ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
                VALUES (@definitionID,@robottemplateid,0,0,0,0,1,'EMPTY/NEW TEMPLATE--PLEASE EDIT AND SAVE AS NEW!');

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 17, 0.95);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 63, 2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 256, 1.1);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 263, 2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 331, 0.8);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 506, 0.1);

---------------------------
INSERT INTO entitydefaults ( definitionname ,  quantity ,  attributeflags ,  categoryflags ,  options ,  note ,  enabled ,  volume ,  mass ,  hidden , 
                health ,  descriptiontoken ,  purchasable ,  tiertype ,  tierlevel ) 
                VALUES ( 'def_npc_vektor_swab_rank3', 1, 1024, 911, '', '', 1, 0, 0, 'False', 100, 'def_npc_prometheus_dps_rank1_desc', 0, 0, 0); 

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank3' ORDER BY [definition] DESC) 

INSERT INTO [dbo].[robottemplaterelation] ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
                VALUES (@definitionID,@robottemplateid,0,0,0,0,1,'EMPTY/NEW TEMPLATE--PLEASE EDIT AND SAVE AS NEW!');

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 17, 1.3);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 27, 1.2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 30, 0.8);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 63, 2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 143, 1.2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 208, 1.2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 229, 1.1);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 232, 0.9);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 253, 0.9);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 256, 1.2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 263, 2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 335, 0.9);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 506, 0.1);

---------------------------
INSERT INTO entitydefaults ( definitionname ,  quantity ,  attributeflags ,  categoryflags ,  options ,  note ,  enabled ,  volume ,  mass ,  hidden , 
                health ,  descriptiontoken ,  purchasable ,  tiertype ,  tierlevel ) 
                VALUES ( 'def_npc_vektor_swab_rank4', 1, 1024, 911, '', '', 1, 0, 0, 'False', 100, 'def_npc_prometheus_dps_rank1_desc', 0, 0, 0);

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_vektor_swab_rank4' ORDER BY [definition] DESC) 

INSERT INTO [dbo].[robottemplaterelation] ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
                VALUES (@definitionID,@robottemplateid,0,0,0,0,2,'EMPTY/NEW TEMPLATE--PLEASE EDIT AND SAVE AS NEW!');

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 17, 1.5);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 27, 1.3);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 30, 0.7);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 63, 2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 143, 1.3);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 208, 1.3);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 229, 1.1);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 232, 0.9);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 253, 0.8);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 256, 1.3);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 263, 2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 335, 0.8);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 506, 0.1);

---------------------------
INSERT INTO robottemplates ([name], [description], [note]) VALUES ('ikarus_abs_transport', '#robot=i1598#head=i1599#chassis=i159a#leg=i159b#container=i157c#headModules=[|m0=[|definition=i34|slot=i1]]#chassisModules=[|m0=[|definition=i23|slot=i1]]#legModules=[|m0=[|definition=ie|slot=i1]]', 'ikarus abs transport')

SET @robottemplateid = (SELECT TOP 1 id FROM robottemplates WHERE [name] = 'ikarus_abs_transport' ORDER BY id DESC)

---------------------------
INSERT INTO entitydefaults ( definitionname ,  quantity ,  attributeflags ,  categoryflags ,  options ,  note ,  enabled ,  volume ,  mass ,  hidden , 
                health ,  descriptiontoken ,  purchasable ,  tiertype ,  tierlevel ) 
                VALUES ( 'def_npc_ikarus_abstrans_rank1', 1, 1024, 911, '', '', 1, 0, 0, 'False', 100, 'def_npc_prometheus_scout_rank1_desc', 0, 0, 0); 

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_ikarus_abstrans_rank1' ORDER BY [definition] DESC) 

INSERT INTO [dbo].[robottemplaterelation] ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
                VALUES (@definitionID,@robottemplateid,0,0,0,0,1,'EMPTY/NEW TEMPLATE--PLEASE EDIT AND SAVE AS NEW!');

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 17, 0.6);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 20, 0.5);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 63, 2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 143, 0.6);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 253, 1.2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 263, 2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 331, 0.4);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 335, 1.4);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 506, 0.1);

---------------------------
INSERT INTO entitydefaults ( definitionname ,  quantity ,  attributeflags ,  categoryflags ,  options ,  note ,  enabled ,  volume ,  mass ,  hidden , 
                health ,  descriptiontoken ,  purchasable ,  tiertype ,  tierlevel ) 
                VALUES ( 'def_npc_ikarus_abstrans_rank2', 1, 1024, 911, '', '', 1, 0, 0, 'False', 100, 'def_npc_prometheus_scout_rank1_desc', 0, 0, 0); 

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_ikarus_abstrans_rank2' ORDER BY [definition] DESC) 

INSERT INTO [dbo].[robottemplaterelation] ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
                VALUES (@definitionID,@robottemplateid,0,0,0,0,1,'EMPTY/NEW TEMPLATE--PLEASE EDIT AND SAVE AS NEW!');

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 17, 0.6);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 20, 0.5);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 63, 2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 143, 0.6);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 253, 1.2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 263, 2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 331, 0.4);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 335, 1.4);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 506, 0.1);

---------------------------
INSERT INTO entitydefaults ( definitionname ,  quantity ,  attributeflags ,  categoryflags ,  options ,  note ,  enabled ,  volume ,  mass ,  hidden , 
                health ,  descriptiontoken ,  purchasable ,  tiertype ,  tierlevel ) 
                VALUES ( 'def_npc_ikarus_abstrans_rank3', 1, 1024, 911, '', '', 1, 0, 0, 'False', 100, 'def_npc_prometheus_scout_rank1_desc', 0, 0, 0); 

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_ikarus_abstrans_rank3' ORDER BY [definition] DESC) 

INSERT INTO [dbo].[robottemplaterelation] ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
                VALUES (@definitionID,@robottemplateid,0,0,0,0,1,'EMPTY/NEW TEMPLATE--PLEASE EDIT AND SAVE AS NEW!');

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 17, 1.3);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 27, 1.2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 30, 0.8);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 63, 2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 143, 1.2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 208, 1.2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 229, 1.1);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 232, 0.9);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 253, 0.9);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 256, 1.2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 263, 2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 335, 0.9);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 506, 0.1);

---------------------------
INSERT INTO entitydefaults ( definitionname ,  quantity ,  attributeflags ,  categoryflags ,  options ,  note ,  enabled ,  volume ,  mass ,  hidden , 
                health ,  descriptiontoken ,  purchasable ,  tiertype ,  tierlevel ) 
                VALUES ( 'def_npc_ikarus_abstrans_rank4', 1, 1024, 911, '', '', 1, 0, 0, 'False', 100, 'def_npc_prometheus_scout_rank1_desc', 0, 0, 0); 

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_ikarus_abstrans_rank4' ORDER BY [definition] DESC) 

INSERT INTO [dbo].[robottemplaterelation] ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
                VALUES (@definitionID,@robottemplateid,0,0,0,0,2,'EMPTY/NEW TEMPLATE--PLEASE EDIT AND SAVE AS NEW!');

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 17, 1.5);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 27, 1.3);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 30, 0.7);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 63, 2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 143, 1.3);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 208, 1.3);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 229, 1.1);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 232, 0.9);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 253, 0.8);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 256, 1.3);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 263, 2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 335, 0.8);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 506, 0.1);

---------------------------
INSERT INTO robottemplates ([name], [description], [note]) VALUES ('locust_firstmate', '#robot=i1588#head=i1589#chassis=i158a#leg=i158b#container=i148#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i31|slot=i2]|m2=[|definition=i33|slot=i3]|m3=[|definition=i390|slot=i4]]#chassisModules=[|m0=[|definition=i3c|slot=i1|ammoDefinition=i103|ammoQuantity=ic8]|m1=[|definition=i3c|slot=i2|ammoDefinition=i103|ammoQuantity=ic8]|m2=[|definition=i3c|slot=i3|ammoDefinition=i103|ammoQuantity=ic8]|m3=[|definition=i3c|slot=i4|ammoDefinition=i103|ammoQuantity=ic8]|m4=[|definition=i3c|slot=i5|ammoDefinition=i103|ammoQuantity=ic8]]#legModules=[|m0=[|definition=ie|slot=i1]|m1=[|definition=i12|slot=i2]|m2=[|definition=i12a|slot=i3]]', 'Locust First Mate')

SET @robottemplateid = (SELECT TOP 1 id FROM robottemplates WHERE [name] = 'locust_firstmate' ORDER BY id DESC)

---------------------------
INSERT INTO entitydefaults ( definitionname ,  quantity ,  attributeflags ,  categoryflags ,  options ,  note ,  enabled ,  volume ,  mass ,  hidden , 
                health ,  descriptiontoken ,  purchasable ,  tiertype ,  tierlevel ) 
                VALUES ( 'def_npc_locust_firstmate_rank1', 1, 1024, 911, '', '', 1, 0, 0, 'False', 100, 'def_npc_baphomet_dps_rank1_desc', 0, 0, 0); 

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank1' ORDER BY [definition] DESC) 

INSERT INTO [dbo].[robottemplaterelation] ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
                VALUES (@definitionID,@robottemplateid,0,0,0,0,1,'EMPTY/NEW TEMPLATE--PLEASE EDIT AND SAVE AS NEW!');

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 17, 0.6);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 20, 0.5);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 63, 2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 143, 0.6);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 253, 1.2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 263, 2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 331, 0.4);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 335, 1.4);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 506, 0.1);

---------------------------
INSERT INTO entitydefaults ( definitionname ,  quantity ,  attributeflags ,  categoryflags ,  options ,  note ,  enabled ,  volume ,  mass ,  hidden , 
                health ,  descriptiontoken ,  purchasable ,  tiertype ,  tierlevel ) 
                VALUES ( 'def_npc_locust_firstmate_rank2', 1, 1024, 911, '', '', 1, 0, 0, 'False', 100, 'def_npc_baphomet_dps_rank1_desc', 0, 0, 0); 

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank2' ORDER BY [definition] DESC) 

INSERT INTO [dbo].[robottemplaterelation] ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
                VALUES (@definitionID,@robottemplateid,0,0,0,0,1,'EMPTY/NEW TEMPLATE--PLEASE EDIT AND SAVE AS NEW!');

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 17, 0.95);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 63, 2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 256, 1.1);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 263, 2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 331, 0.8);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 506, 0.1);

---------------------------
INSERT INTO entitydefaults ( definitionname ,  quantity ,  attributeflags ,  categoryflags ,  options ,  note ,  enabled ,  volume ,  mass ,  hidden , 
                health ,  descriptiontoken ,  purchasable ,  tiertype ,  tierlevel ) 
                VALUES ( 'def_npc_locust_firstmate_rank3', 1, 1024, 911, '', '', 1, 0, 0, 'False', 100, 'def_npc_baphomet_dps_rank1_desc', 0, 0, 0); 

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank3' ORDER BY [definition] DESC) 

INSERT INTO [dbo].[robottemplaterelation] ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
                VALUES (@definitionID,@robottemplateid,0,0,0,0,2,'EMPTY/NEW TEMPLATE--PLEASE EDIT AND SAVE AS NEW!');

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 17, 1.3);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 27, 1.2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 30, 0.8);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 63, 2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 143, 1.2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 208, 1.2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 229, 1.1);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 232, 0.9);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 253, 0.9);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 256, 1.2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 263, 2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 335, 0.9);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 506, 0.1);

---------------------------
INSERT INTO entitydefaults ( definitionname ,  quantity ,  attributeflags ,  categoryflags ,  options ,  note ,  enabled ,  volume ,  mass ,  hidden , 
                health ,  descriptiontoken ,  purchasable ,  tiertype ,  tierlevel ) 
                VALUES ( 'def_npc_locust_firstmate_rank4', 1, 1024, 911, '', '', 1, 0, 0, 'False', 100, 'def_npc_baphomet_dps_rank1_desc', 0, 0, 0); 

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_locust_firstmate_rank4' ORDER BY [definition] DESC) 

INSERT INTO [dbo].[robottemplaterelation] ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
                VALUES (@definitionID,@robottemplateid,0,0,0,0,2,'EMPTY/NEW TEMPLATE--PLEASE EDIT AND SAVE AS NEW!');

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 17, 1.5);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 27, 1.3);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 30, 0.7);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 63, 2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 143, 1.3);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 208, 1.3);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 229, 1.1);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 232, 0.9);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 253, 0.8);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 256, 1.3);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 263, 2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 335, 0.8);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 506, 0.1);

---------------------------
INSERT INTO robottemplates ([name], [description], [note]) VALUES ('echelon_masterdeathdealer', '#robot=i158c#head=i158d#chassis=i158e#leg=i158f#container=i14a#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i390|slot=i2]|m2=[|definition=i34|slot=i3]|m3=[|definition=i33|slot=i4]]#chassisModules=[|m0=[|definition=i3d|slot=i1|ammoDefinition=i107|ammoQuantity=ic8]|m1=[|definition=i3d|slot=i2|ammoDefinition=i107|ammoQuantity=ic8]|m2=[|definition=i3d|slot=i3|ammoDefinition=i107|ammoQuantity=ic8]|m3=[|definition=i3d|slot=i4|ammoDefinition=i107|ammoQuantity=ic8]]#legModules=[|m0=[|definition=i12a|slot=i1]|m1=[|definition=i10|slot=i2]|m2=[|definition=i13|slot=i3]|m3=[|definition=i19|slot=i4]|m4=[|definition=i10|slot=i5]]', 'echelon master death dealer')

SET @robottemplateid = (SELECT TOP 1 id FROM robottemplates WHERE [name] = 'echelon_masterdeathdealer' ORDER BY id DESC)

---------------------------
INSERT INTO entitydefaults ( definitionname ,  quantity ,  attributeflags ,  categoryflags ,  options ,  note ,  enabled ,  volume ,  mass ,  hidden , 
                health ,  descriptiontoken ,  purchasable ,  tiertype ,  tierlevel ) 
                VALUES ( 'def_npc_echelon_masterdeathdealer_rank1', 1, 1024, 911, '', '', 1, 0, 0, 'False', 100, 'def_npc_artemis_dps_rank1_desc', 0, 0, 0); 

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank1' ORDER BY [definition] DESC) 

INSERT INTO [dbo].[robottemplaterelation] ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
                VALUES (@definitionID,@robottemplateid,0,0,0,0,2,'EMPTY/NEW TEMPLATE--PLEASE EDIT AND SAVE AS NEW!');

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 17, 0.6);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 20, 0.5);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 63, 2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 143, 0.6);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 253, 1.2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 263, 2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 331, 0.4);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 335, 1.4);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 506, 0.1);

---------------------------
INSERT INTO entitydefaults ( definitionname ,  quantity ,  attributeflags ,  categoryflags ,  options ,  note ,  enabled ,  volume ,  mass ,  hidden , 
                health ,  descriptiontoken ,  purchasable ,  tiertype ,  tierlevel ) 
                VALUES ( 'def_npc_echelon_masterdeathdealer_rank2', 1, 1024, 911, '', '', 1, 0, 0, 'False', 100, 'def_npc_artemis_dps_rank1_desc', 0, 0, 0); 

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank2' ORDER BY [definition] DESC) 

INSERT INTO [dbo].[robottemplaterelation] ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
                VALUES (@definitionID,@robottemplateid,0,0,0,0,2,'EMPTY/NEW TEMPLATE--PLEASE EDIT AND SAVE AS NEW!');

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 17, 0.95);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 63, 2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 256, 1.1);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 263, 2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 331, 0.8);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 506, 0.1);

---------------------------
INSERT INTO entitydefaults ( definitionname ,  quantity ,  attributeflags ,  categoryflags ,  options ,  note ,  enabled ,  volume ,  mass ,  hidden , 
                health ,  descriptiontoken ,  purchasable ,  tiertype ,  tierlevel ) 
                VALUES ( 'def_npc_echelon_masterdeathdealer_rank3', 1, 1024, 911, '', '', 1, 0, 0, 'False', 100, 'def_npc_artemis_dps_rank1_desc', 0, 0, 0); 

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank3' ORDER BY [definition] DESC) 

INSERT INTO [dbo].[robottemplaterelation] ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
                VALUES (@definitionID,@robottemplateid,0,0,0,0,2,'EMPTY/NEW TEMPLATE--PLEASE EDIT AND SAVE AS NEW!');

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 17, 1.3);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 27, 1.2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 30, 0.8);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 63, 2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 143, 1.2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 208, 1.2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 229, 1.1);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 232, 0.9);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 253, 0.9);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 256, 1.2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 263, 2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 335, 0.9);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 506, 0.1);

---------------------------
INSERT INTO entitydefaults ( definitionname ,  quantity ,  attributeflags ,  categoryflags ,  options ,  note ,  enabled ,  volume ,  mass ,  hidden , 
                health ,  descriptiontoken ,  purchasable ,  tiertype ,  tierlevel ) 
                VALUES ( 'def_npc_echelon_masterdeathdealer_rank4', 1, 1024, 911, '', '', 1, 0, 0, 'False', 100, 'def_npc_artemis_dps_rank1_desc', 0, 0, 0); 

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_echelon_masterdeathdealer_rank4' ORDER BY [definition] DESC) 

INSERT INTO [dbo].[robottemplaterelation] ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
                VALUES (@definitionID,@robottemplateid,0,0,0,0,3,'EMPTY/NEW TEMPLATE--PLEASE EDIT AND SAVE AS NEW!');

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 17, 1.5);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 27, 1.3);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 30, 0.7);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 63, 2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 143, 1.3);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 208, 1.3);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 229, 1.1);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 232, 0.9);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 253, 0.8);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 256, 1.3);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 263, 2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 335, 0.8);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 506, 0.1);

---------------------------
INSERT INTO robottemplates ([name], [description], [note]) VALUES ('legatus_mastergoat', '#robot=i1594#head=i1595#chassis=i1596#leg=i1597#container=i14c#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i32|slot=i2]|m2=[|definition=i33|slot=i3]|m3=[|definition=i34|slot=i4]]#chassisModules=[|m0=[|definition=i3d|slot=i1|ammoDefinition=i107|ammoQuantity=ic8]|m1=[|definition=i3d|slot=i2|ammoDefinition=i107|ammoQuantity=ic8]|m2=[|definition=i3d|slot=i3|ammoDefinition=i107|ammoQuantity=ic8]|m3=[|definition=i3d|slot=i4|ammoDefinition=i107|ammoQuantity=ic8]|m4=[|definition=i3d|slot=i5|ammoDefinition=i107|ammoQuantity=ic8]|m5=[|definition=i3d|slot=i6|ammoDefinition=i107|ammoQuantity=ic8]|m6=[|definition=i3d|slot=i7|ammoDefinition=i107|ammoQuantity=ic8]]#legModules=[|m0=[|definition=i10|slot=i1]|m1=[|definition=i13|slot=i2]|m2=[|definition=i19|slot=i3]|m3=[|definition=i10|slot=i4]]', 'THE GOAT RRRAAAAWWWRRRR')

SET @robottemplateid = (SELECT TOP 1 id FROM robottemplates WHERE [name] = 'legatus_mastergoat' ORDER BY id DESC)

---------------------------
INSERT INTO entitydefaults ( definitionname ,  quantity ,  attributeflags ,  categoryflags ,  options ,  note ,  enabled ,  volume ,  mass ,  hidden , 
                health ,  descriptiontoken ,  purchasable ,  tiertype ,  tierlevel ) 
                VALUES ( 'def_npc_legatus_mastergoat_rank1', 1, 1024, 911, '', '', 1, 0, 0, 'False', 100, 'def_npc_seth_heavydps_rank1_desc', 0, 0, 0); 

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank1' ORDER BY [definition] DESC) 

INSERT INTO [dbo].[robottemplaterelation] ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
                VALUES (@definitionID,@robottemplateid,0,0,0,0,3,'EMPTY/NEW TEMPLATE--PLEASE EDIT AND SAVE AS NEW!');

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 17, 0.6);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 20, 0.5);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 63, 2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 143, 0.6);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 253, 1.2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 263, 2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 331, 0.4);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 335, 1.4);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 506, 0.1);

---------------------------
INSERT INTO entitydefaults ( definitionname ,  quantity ,  attributeflags ,  categoryflags ,  options ,  note ,  enabled ,  volume ,  mass ,  hidden , 
                health ,  descriptiontoken ,  purchasable ,  tiertype ,  tierlevel ) 
                VALUES ( 'def_npc_legatus_mastergoat_rank2', 1, 1024, 911, '', '', 1, 0, 0, 'False', 100, 'def_npc_seth_heavydps_rank1_desc', 0, 0, 0); 

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank2' ORDER BY [definition] DESC) 

INSERT INTO [dbo].[robottemplaterelation] ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
                VALUES (@definitionID,@robottemplateid,0,0,0,0,3,'EMPTY/NEW TEMPLATE--PLEASE EDIT AND SAVE AS NEW!');

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 17, 0.95);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 63, 2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 256, 1.1);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 263, 2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 331, 0.8);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 506, 0.1);

---------------------------
INSERT INTO entitydefaults ( definitionname ,  quantity ,  attributeflags ,  categoryflags ,  options ,  note ,  enabled ,  volume ,  mass ,  hidden , 
                health ,  descriptiontoken ,  purchasable ,  tiertype ,  tierlevel ) 
                VALUES ( 'def_npc_legatus_mastergoat_rank3', 1, 1024, 911, '', '', 1, 0, 0, 'False', 100, 'def_npc_seth_heavydps_rank1_desc', 0, 0, 0); 

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank3' ORDER BY [definition] DESC) 

INSERT INTO [dbo].[robottemplaterelation] ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
                VALUES (@definitionID,@robottemplateid,0,0,0,0,3,'EMPTY/NEW TEMPLATE--PLEASE EDIT AND SAVE AS NEW!');

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 17, 1.3);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 27, 1.2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 30, 0.8);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 63, 2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 143, 1.2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 208, 1.2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 229, 1.1);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 232, 0.9);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 253, 0.9);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 256, 1.2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 263, 2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 335, 0.9);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 506, 0.1);

---------------------------
INSERT INTO entitydefaults ( definitionname ,  quantity ,  attributeflags ,  categoryflags ,  options ,  note ,  enabled ,  volume ,  mass ,  hidden , 
                health ,  descriptiontoken ,  purchasable ,  tiertype ,  tierlevel ) 
                VALUES ( 'def_npc_legatus_mastergoat_rank4', 1, 1024, 911, '', '', 1, 0, 0, 'False', 100, 'def_npc_seth_heavydps_rank1_desc', 0, 0, 0); 

SET @definitionID = (SELECT TOP 1 [definition] FROM entitydefaults WHERE [definitionname] = 'def_npc_legatus_mastergoat_rank4' ORDER BY [definition] DESC) 

INSERT INTO [dbo].[robottemplaterelation] ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
                VALUES (@definitionID,@robottemplateid,0,0,0,0,3,'EMPTY/NEW TEMPLATE--PLEASE EDIT AND SAVE AS NEW!');

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 17, 1.5);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 27, 1.3);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 30, 0.7);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 63, 2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 143, 1.3);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 208, 1.3);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 229, 1.1);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 232, 0.9);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 253, 0.8);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 256, 1.3);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 263, 2);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 335, 0.8);
INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, 506, 0.1);