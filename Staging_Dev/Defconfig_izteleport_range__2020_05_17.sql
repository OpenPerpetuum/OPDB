USE [perpetuumsa]
GO

---------------------------------------------------
--Interzone range increase 30k->40k
--
--Date Modified: 2020/05/17
---------------------------------------------------

UPDATE definitionconfig SET 
	item_work_range = 4072
WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname like 'def_mobile_world_teleport%');

GO