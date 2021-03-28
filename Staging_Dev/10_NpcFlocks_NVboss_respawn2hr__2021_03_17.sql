USE [perpetuumsa]
GO

------------------------------------------------
-- Set spawn times of NV bosses == to Hersh bosses @2hrs
-- Date Modified: 2021/03/17
------------------------------------------------

UPDATE npcflock SET
	respawnseconds=7200
WHERE name IN (
	'Rough_Rider_Leader',
	'def_npc_Malfunctioning_Arkhe',
	'def_npc_Imperial_Infantry',
	'def_npc_Tribal_Member',
	'def_npc_Sacrist_Convert'
);

GO
