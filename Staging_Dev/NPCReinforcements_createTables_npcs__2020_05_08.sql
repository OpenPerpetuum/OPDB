USE [perpetuumsa]
GO

--------------------------------------------------------------------
--Datamodel for NPC Reinforcements: A model for npc spawns that occur on particular set of conditional criteria
--Each record is a presence and a threshold that join to potentially any other table by some targetId.
--The reinforcementType determines the polymorphic behaviour of the record as it is loaded into the server.
--The threshold allows for floating point numeric criteria to gate behaviours and determine percentages or other values to trigger a particular spawn.
--
--Date modified: 2020/05/10
--------------------------------------------------------------------

DROP TABLE IF EXISTS dbo.npcreinforcementtypes;

CREATE TABLE dbo.npcreinforcementtypes (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	name VARCHAR(64) NOT NULL
);

GO

INSERT INTO dbo.npcreinforcementtypes (name) VALUES
('minerals'),
('boss');


DROP TABLE IF EXISTS dbo.npcreinforcements;

CREATE TABLE dbo.npcreinforcements (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	reinforcementType INT NOT NULL,
	targetId INT NOT NULL,
	threshold float NOT NULL,
	presenceId INT NOT NULL
);

GO
--TODO make new npcs for waves!
--
--Just stuff to test
--INSERT INTO npcpresence(name,topx,topy,bottomx,bottomy,note,spawnid,enabled,roaming,roamingrespawnseconds,presencetype,maxrandomflock,randomcenterx,randomcentery,randomradius,dynamiclifetime,isbodypull,isrespawnallowed,safebodypull,izgroupid)
--SELECT 'test-dynamic-extended-'+name,topx,topy,bottomx,bottomy,note,spawnid,enabled,roaming,roamingrespawnseconds,9,maxrandomflock,randomcenterx,randomcentery,randomradius,dynamiclifetime,isbodypull,isrespawnallowed,safebodypull,null from npcpresence 
--WHERE id in (500, 506, 512);

--INSERT INTO npcflock(name,presenceid,flockmembercount,definition,spawnoriginX,spawnoriginY,spawnrangeMin,spawnrangeMax,respawnseconds,totalspawncount,homerange,note,respawnmultiplierlow,enabled,iscallforhelp,behaviorType,npcSpecialType)
--SELECT 'test-dynamic-extended-'+name,
--(SELECT TOP 1 id FROM npcpresence WHERE name='test-dynamic-extended-'+(SELECT name FROM npcpresence WHERE id=500)),
--flockmembercount,definition,spawnoriginX,spawnoriginY,spawnrangeMin,spawnrangeMax,respawnseconds,totalspawncount,homerange,note,respawnmultiplierlow,enabled,iscallforhelp,2,0 
--FROM npcflock WHERE presenceid in (500);

--INSERT INTO npcflock(name,presenceid,flockmembercount,definition,spawnoriginX,spawnoriginY,spawnrangeMin,spawnrangeMax,respawnseconds,totalspawncount,homerange,note,respawnmultiplierlow,enabled,iscallforhelp,behaviorType,npcSpecialType)
--SELECT 'test-dynamic-extended-'+name,
--(SELECT TOP 1 id FROM npcpresence WHERE name='test-dynamic-extended-'+(SELECT name FROM npcpresence WHERE id=506)),
--flockmembercount,definition,spawnoriginX,spawnoriginY,spawnrangeMin,spawnrangeMax,respawnseconds,totalspawncount,homerange,note,respawnmultiplierlow,enabled,iscallforhelp,2,0 
--FROM npcflock WHERE presenceid in (506);

--INSERT INTO npcflock(name,presenceid,flockmembercount,definition,spawnoriginX,spawnoriginY,spawnrangeMin,spawnrangeMax,respawnseconds,totalspawncount,homerange,note,respawnmultiplierlow,enabled,iscallforhelp,behaviorType,npcSpecialType)
--SELECT 'test-dynamic-extended-'+name,
--(SELECT TOP 1 id FROM npcpresence WHERE name='test-dynamic-extended-'+(SELECT name FROM npcpresence WHERE id=512)),
--flockmembercount,definition,spawnoriginX,spawnoriginY,spawnrangeMin,spawnrangeMax,respawnseconds,totalspawncount,homerange,note,respawnmultiplierlow,enabled,iscallforhelp,2,0 
--FROM npcflock WHERE presenceid in (512);


DECLARE @fluxOre INT;
SET @fluxOre = (SELECT TOP 1 idx FROM minerals WHERE name = 'fluxore');

DECLARE @reinforceType INT;
SET @reinforceType = (SELECT TOP 1 id FROM npcreinforcementtypes WHERE name='minerals');

--TODO build presences for this feature and use here
INSERT INTO dbo.npcreinforcements(reinforcementType, targetId, threshold, presenceId) VALUES
(@reinforceType, @fluxOre, 0.33, 1780),
(@reinforceType, @fluxOre, 0.66, 1781),
(@reinforceType, @fluxOre, 0.99, 1782);
