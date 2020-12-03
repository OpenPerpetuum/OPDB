USE [perpetuumsa]
GO

------------------------------------------
-- Npcbossinfo chat messages
-- Clean up excess chatter, give others more character
-- Date modified: 2020/11/27
------------------------------------------

PRINT N'UPDATE npcbossinfo: customDeathMessage/customAggressMessage';

UPDATE npcbossinfo SET 
	customDeathMessage=NULL,
	customAggressMessage=NULL
WHERE flockid IN (SELECT id FROM npcflock WHERE name IN (
	'kain_protector_stronghold1',
	'cameleon_with_numiquol_protector',
	'arbalest_with_numiquol_protector',
	'artemis_protector_stronghold1',
	'intakt_by_protector',
	'baphomet_by_protector',
	'tyrannos_protector',
	'waspish_with_protector',
	'troiar_with_protector',
	'intakt_stronghold_trash',
	'cam_stronghold_trash',
	'troiar_stronghold_trash',
	'Baph_stronghold_trash',
	'Arbalest_stronghold_trash',
	'Waspish_stronghold_trash',
	'Rough_Rider_Leader',
	'Rough_rider_Scout1',
	'Rough_rider_scout2',
	'def_npc_Malfunctioning_Arkhe',
	'def_npc_Imperial_Infantry',
	'def_npc_Tribal_Member',
	'def_npc_Sacrist_Convert',
	'hersh_yellow_boss',
	'Blue_Hersh_mech_boss',
	'hersh_GreenBoss',
	'Hersh_RR_1',
	'Hersh_Pit_Boss'));

UPDATE npcbossinfo SET 
	customDeathMessage='bzzt.. uploading research exfiltration packets... fizzbuzz.. zorp..',
	customAggressMessage='zzzzrt.. aggressionN0 routines... ENGAGED'
WHERE flockid IN (SELECT id FROM npcflock WHERE name IN ('def_npc_Malfunctioning_Arkhe'));


UPDATE npcbossinfo SET 
	customAggressMessage='Oh? You''re Approaching Me?'
WHERE flockid IN (SELECT id FROM npcflock WHERE name IN (
	'Rough_Rider_Leader',
	'def_npc_Imperial_Infantry',
	'def_npc_Tribal_Member',
	'def_npc_Sacrist_Convert',
	'hersh_yellow_boss',
	'Blue_Hersh_mech_boss',
	'hersh_GreenBoss',
	'Hersh_RR_1',
	'Hersh_Pit_Boss'));

UPDATE npcbossinfo SET 
	customDeathMessage='The Syndicate will fall! We will see to it... Until next time Agent.'
WHERE flockid IN (SELECT id FROM npcflock WHERE name IN (
	'Rough_Rider_Leader',
	'Hersh_RR_1'));

UPDATE npcbossinfo SET 
	customDeathMessage='This will not be our last encounter human!'
WHERE flockid IN (SELECT id FROM npcflock WHERE name IN (
	'def_npc_Imperial_Infantry',
	'def_npc_Tribal_Member',
	'def_npc_Sacrist_Convert',
	'hersh_yellow_boss',
	'Blue_Hersh_mech_boss',
	'hersh_GreenBoss'));

UPDATE npcbossinfo SET 
	customDeathMessage='Thank you human, my consciousness once trapped in this abomination is now free to end this viral slavery! For Nia!'
WHERE flockid IN (SELECT id FROM npcflock WHERE name IN (
	'Hersh_Pit_Boss'));

UPDATE npcbossinfo SET 
	customDeathMessage='Impossible! Humans too self-serving to operate as collective as we. Perhaps we revise our strategies...',
	customAggressMessage='Human! I thought I could smell your viral controls on my brother. Let me free him from your digital shackles!'
WHERE flockid IN (SELECT id FROM npcflock WHERE name IN (
	'Norhoop_Pitboss_flock_boss',
	'Hokkogaros_Pitboss_flock_boss',
	'Domhalarn_Pitboss_flock_boss'));

PRINT N'DONE UPDATE npcbossinfo: customDeathMessage/customAggressMessage';
GO