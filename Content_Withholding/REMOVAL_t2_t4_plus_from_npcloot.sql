--SELECT * FROM [perpetuumsa].[dbo].[entitydefaults]
--JOIN npcloot ON lootdefinition=entitydefaults.definition
--WHERE tiertype = 3 AND (tierlevel=2 or tierlevel=4);

--Remove all T2+/T4+ from npc loot 
DELETE loot FROM [perpetuumsa].[dbo].npcloot as loot
Join entitydefaults on lootdefinition=entitydefaults.definition
where tiertype = 3 and (tierlevel=2 or tierlevel=4)
