USE [perpetuumsa]
GO

--------------------------------------------------------------------
--Datamodel for NPC Ore spawns
--A presence is to spawn on some ore field when the field is depleted to particular percentages
--When the threshold is exceeded for that ore, that presence will spawn
--
--Date modified: 2020/05/09
--------------------------------------------------------------------

DROP TABLE IF EXISTS dbo.npcorespawn;

CREATE TABLE dbo.npcorespawn (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	materialType INT NOT NULL,
	presenceId INT NOT NULL,
	threshold float NOT NULL
);

GO

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

--TODO build presences for this feature and use here
INSERT INTO dbo.npcorespawn(materialType, presenceId, threshold) VALUES
(@fluxOre, 1780, 0.33),
(@fluxOre, 1781, 0.66),
(@fluxOre, 1782, 0.99);
