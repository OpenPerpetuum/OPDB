
---------------ECON_reward_by_missiontargettype--------------
--Mission bonuses by type balance
--See Econ Spreadsheet for details
USE [perpetuumsa]
GO


DECLARE @TEMPTARGETREWARDS TABLE
(
  name varchar(50), 
  reward int
)

--rewards by objective
INSERT INTO @TEMPTARGETREWARDS VALUES
('loot_item',50),
('kill_definition',50),
('scan_mineral',250),
('drill_mineral',4100),
('submit_item',200),
('use_switch',50),
('find_artifact',175),
('use_itemsupply',250),
('massproduce',500),
('research',500),
('harvest_plant',1000),
('pop_npc',12),
('lock_unit',50);

UPDATE      t1
SET         reward = t2.reward
FROM        missiontargettypes t1
INNER JOIN  @TEMPTARGETREWARDS t2
ON          t1.name = t2.name;

GO

-------------------Assignments_beta2_gather-only----------------------
USE [perpetuumsa]
GO


--Add Mining and Harvesting missions to Beta2
--Creates new agents
--Sets them to be agents at missionlocations on Beta2s
--Insert missiontoagent relations for mining/harvest missions only

PRINT N'BETA2 MISSIONS: STAGE 1 - ADD HARVEST AND MINING TO OUTPOSTS';
DECLARE @MaxLevel int;
SET @MaxLevel = 7;

DECLARE @ASI bigint;
DECLARE @ICS bigint;
DECLARE @TM bigint;

DECLARE @ASIname varchar(128);
DECLARE @ICSname varchar(128);
DECLARE @TMname varchar(128);

DECLARE @ASIagentName varchar(128);
DECLARE @ICSagentName varchar(128);
DECLARE @TMagentName varchar(128);

--names of agents
SET @ASIagentName = 'outpost_asi_beta2';
SET @ICSagentName = 'outpost_ics_beta2';
SET @TMagentName = 'outpost_tm_beta2';

--Megacorps and allianceEids
SET @ASIname = 'megacorp_ASI';
SET @ICSname = 'megacorp_ICS';
SET @TMname = 'megacorp_TM';

SET @ASI = (SELECT TOP 1 [allianceEID] FROM dbo.alliances WHERE name=@ASIname);
SET @ICS = (SELECT TOP 1 [allianceEID] FROM dbo.alliances WHERE name=@ICSname);
SET @TM = (SELECT TOP 1 [allianceEID] FROM dbo.alliances WHERE name=@TMname);

PRINT N'INSERT NEW AGENTS';

INSERT INTO [dbo].[missionagents]
           ([agentname],[owner],[ownername])
     VALUES
           (@ASIagentName,@ASI,@ASIname),
		   (@ICSagentName,@ICS,@ICSname),
		   (@TMagentName,@TM,@TMname);

--Newly inserted IDs of agents
DECLARE @ASIagent int;
DECLARE @ICSagent int;
DECLARE @TMagent int;

SET @ASIagent = (SELECT TOP 1 id FROM dbo.missionagents WHERE agentname=@ASIagentName);
SET @ICSagent = (SELECT TOP 1 id FROM dbo.missionagents WHERE agentname=@ICSagentName);
SET @TMagent = (SELECT TOP 1 id FROM dbo.missionagents WHERE agentname=@TMagentName);

PRINT N'UPDATE MISSION LOCATIONS -> ASSIGN WITH NEW AGENTS';
--Put new agents in missionlocations in each beta2 outpost
UPDATE dbo.missionlocations
SET agentid=@ASIagent,
	maxmissionlevel=@MaxLevel
WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='kentagura');

UPDATE dbo.missionlocations
SET agentid=@ICSagent,
	maxmissionlevel=@MaxLevel
WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='novastrov');

UPDATE dbo.missionlocations
SET agentid=@TMagent,
	maxmissionlevel=@MaxLevel
WHERE zoneid=(SELECT TOP 1 id FROM zones WHERE note='alsbale');

--Only 2 harvest mission templates
DECLARE @harvest1 int;
DECLARE @harvest2 int;
--Mining missions
DECLARE @mining1 int;
DECLARE @mining2 int;
DECLARE @mining3 int;

SET @harvest1 = (SELECT TOP 1 id FROM missions WHERE title='missiontemplate_random_harvesting_01');
SET @harvest2 = (SELECT TOP 1 id FROM missions WHERE title='missiontemplate_random_harvesting_02');

SET @mining1 = (SELECT TOP 1 id FROM missions WHERE title='missiontemplate_random_mining_01');
SET @mining2 = (SELECT TOP 1 id FROM missions WHERE title='missiontemplate_random_mining_02');
SET @mining3 = (SELECT TOP 1 id FROM missions WHERE title='missiontemplate_random_mining_03');

PRINT N'INSERT MISSION-TO-AGENT RELATIONS -- ADDS HARVEST AND MINING TEMPLATES';
--Add missions to each agent
INSERT INTO [dbo].[missiontoagent]
           ([missionid],[agentid])
     VALUES
           (@mining1,@ASIagent),
		   (@mining2,@ASIagent),
		   (@mining3,@ASIagent),
		   (@harvest1,@ASIagent),
		   (@harvest2,@ASIagent),
		   (@mining1,@ICSagent),
		   (@mining2,@ICSagent),
		   (@mining3,@ICSagent),
		   (@harvest1,@ICSagent),
		   (@harvest2,@ICSagent),
		   (@mining1,@TMagent),
		   (@mining2,@TMagent),
		   (@mining3,@TMagent),
		   (@harvest1,@TMagent),
		   (@harvest2,@TMagent);


DECLARE @alsbale1 int;
DECLARE @alsbale2 int;
DECLARE @kent1 int;
DECLARE @kent2 int;
DECLARE @nova1 int;
DECLARE @nova2 int;

SET @alsbale1 = (SELECT TOP 1 id FROM missionlocations WHERE locationname='outpost_tm_1_exp1');
SET @alsbale2 = (SELECT TOP 1 id FROM missionlocations WHERE locationname='outpost_tm_2_exp1');

SET @kent1 = (SELECT TOP 1 id FROM missionlocations WHERE locationname='outpost_asi_1_exp1');
SET @kent2 = (SELECT TOP 1 id FROM missionlocations WHERE locationname='outpost_asi_2_exp1');

SET @nova1 = (SELECT TOP 1 id FROM missionlocations WHERE locationname='outpost_ics_1_exp1');
SET @nova2 = (SELECT TOP 1 id FROM missionlocations WHERE locationname='outpost_ics_2_exp1');

--Insert missiontolocation "missionresolveinfo" objects -- produced from a testing pipeline--required for each mission at each location!!
--TODO figure out how to generate records using commands!!
PRINT N'INSERT MISSION-TO-LOCATION OBJECTS -- TODO use missionTestResolve command to produce these and test missions!';
INSERT INTO [dbo].[missiontolocation]
           ([missionid],[locationid],[attempts],[success],[uniquecases],[rewardaverage])
     VALUES
           (@mining1,@alsbale1,100,100,0,0),
		   (@mining2,@alsbale1,100,100,0,0),
		   (@mining3,@alsbale1,100,100,0,0),
		   (@harvest1,@alsbale1,100,100,0,0),
		   (@harvest2,@alsbale1,100,100,0,0),

           (@mining1,@alsbale2,100,100,0,0),
		   (@mining2,@alsbale2,100,100,0,0),
		   (@mining3,@alsbale2,100,100,0,0),
		   (@harvest1,@alsbale2,100,100,0,0),
		   (@harvest2,@alsbale2,100,100,0,0),

		   (@mining1,@kent1,100,100,0,0),
		   (@mining2,@kent1,100,100,0,0),
		   (@mining3,@kent1,100,100,0,0),
		   (@harvest1,@kent1,100,100,0,0),
		   (@harvest2,@kent1,100,100,0,0),

		   (@mining1,@kent2,100,100,0,0),
		   (@mining2,@kent2,100,100,0,0),
		   (@mining3,@kent2,100,100,0,0),
		   (@harvest1,@kent2,100,100,0,0),
		   (@harvest2,@kent2,100,100,0,0),

		   (@mining1,@nova1,100,100,0,0),
		   (@mining2,@nova1,100,100,0,0),
		   (@mining3,@nova1,100,100,0,0),
		   (@harvest1,@nova1,100,100,0,0),
		   (@harvest2,@nova1,100,100,0,0),

		   (@mining1,@nova2,100,100,0,0),
		   (@mining2,@nova2,100,100,0,0),
		   (@mining3,@nova2,100,100,0,0),
		   (@harvest1,@nova2,100,100,0,0),
		   (@harvest2,@nova2,100,100,0,0);

GO

----------------NPC_red_ecm_freeroam_spawntimerfixes-----------------
USE [perpetuumsa]
GO


PRINT N'Update FreeRoaming presences and flocks with correct respawn times, following server bugfix';

DECLARE @presenceID int;
DECLARE @respawnTime int;
DECLARE @flockID int;

--This for presence and flock should be equal and positive
SET @respawnTime = 600;

PRINT N'NV spawns';
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'free_roaming_laird_NV' ORDER BY id DESC);

UPDATE [dbo].[npcflock] 
SET [respawnseconds] = @respawnTime
WHERE id=@flockID;


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'freeroaming_NPC_New_Virginia' ORDER BY id DESC);

UPDATE [dbo].[npcpresence]
SET [roamingrespawnseconds] = @respawnTime
WHERE id=@presenceID;


SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'argano_free_roaming_NV2' ORDER BY id DESC);

UPDATE [dbo].[npcflock] 
SET [respawnseconds] = @respawnTime
WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'freeroaming_NPC_New_Virginia_2' ORDER BY id DESC);

UPDATE [dbo].[npcpresence]
SET [roamingrespawnseconds] = @respawnTime
WHERE id=@presenceID;



SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'Free_roaming_argano_NV3' ORDER BY id DESC);

UPDATE [dbo].[npcflock] 
SET [respawnseconds] = @respawnTime
WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'freeroaming_NPC_New_Virginia_3' ORDER BY id DESC);

UPDATE [dbo].[npcpresence]
SET [roamingrespawnseconds] = @respawnTime
WHERE id=@presenceID;



SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'NV_free_roamer_laird' ORDER BY id DESC);

UPDATE [dbo].[npcflock] 
SET [respawnseconds] = @respawnTime
WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'freeroaming_NPC_New_Virginia_4' ORDER BY id DESC);

UPDATE [dbo].[npcpresence]
SET [roamingrespawnseconds] = @respawnTime
WHERE id=@presenceID;





PRINT N'Hershfield spawns';
SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'free_roaming_laird_hersh_1' ORDER BY id DESC);

UPDATE [dbo].[npcflock] 
SET [respawnseconds] = @respawnTime
WHERE id=@flockID;


SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'freeroaming_NPC_Hersh_ECM_1' ORDER BY id DESC);

UPDATE [dbo].[npcpresence]
SET [roamingrespawnseconds] = @respawnTime
WHERE id=@presenceID;


SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'free_roaming_argano_Hersh_1' ORDER BY id DESC);

UPDATE [dbo].[npcflock] 
SET [respawnseconds] = @respawnTime
WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'freeroaming_NPC_Hersh_ECM_2' ORDER BY id DESC);

UPDATE [dbo].[npcpresence]
SET [roamingrespawnseconds] = @respawnTime
WHERE id=@presenceID;



SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'free_roaming_laird_hersh_2' ORDER BY id DESC);

UPDATE [dbo].[npcflock] 
SET [respawnseconds] = @respawnTime
WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'freeroaming_NPC_Hersh_ECM_3' ORDER BY id DESC);

UPDATE [dbo].[npcpresence]
SET [roamingrespawnseconds] = @respawnTime
WHERE id=@presenceID;



SET @flockID = (SELECT TOP 1 id from npcflock WHERE [name] = 'free_roaming_argano_hersh_2' ORDER BY id DESC);

UPDATE [dbo].[npcflock] 
SET [respawnseconds] = @respawnTime
WHERE id=@flockID;

SET @presenceID = (SELECT TOP 1 id from npcpresence WHERE [name] = 'freeroaming_NPC_Hersh_ECM_4' ORDER BY id DESC);

UPDATE [dbo].[npcpresence]
SET [roamingrespawnseconds] = @respawnTime
WHERE id=@presenceID;

GO