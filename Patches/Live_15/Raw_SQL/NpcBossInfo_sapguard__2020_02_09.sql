USE [perpetuumsa]
GO

-----------------------------------------------
--NPC SAP Guard pts to -3
--Date: 2020/02/09
-----------------------------------------------

UPDATE npcbossinfo SET 
	stabilityPts = -3 
WHERE stabilityPts = -2 and customDeathMessage='SAP Guardian down!';

GO
