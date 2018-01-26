----------------------------------------------------------
--Remove all T2+/T4+ from npc loot 
SELECT * FROM [perpetuumsa].[dbo].[entitydefaults]
JOIN npcloot ON lootdefinition=entitydefaults.definition
WHERE tiertype = 3 AND (tierlevel=2 or tierlevel=4);

--Deletes
DELETE loot FROM [perpetuumsa].[dbo].npcloot as loot
Join entitydefaults on lootdefinition=entitydefaults.definition
where tiertype = 3 and (tierlevel=2 or tierlevel=4)


------------------------------------------------------------
--Remove all T2+/T4+, (includes lottery), and elite heavy mechs from SyndicateShops
SELECT [itemshop].*, entitydefaults.* FROM [perpetuumsa].[dbo].[itemshop]
Join entitydefaults on targetdefinition=entitydefaults.definition
where tiertype = 3 and (tierlevel=2 or tierlevel=4);

SELECT [itemshop].*, entitydefaults.* FROM [perpetuumsa].[dbo].[itemshop]
Join entitydefaults on targetdefinition=entitydefaults.definition
where entitydefaults.categoryflags=1179 and entitydefaults.definitionname like '%lottery%';

SELECT [itemshop].*, entitydefaults.* FROM [perpetuumsa].[dbo].[itemshop]
Join entitydefaults on targetdefinition=entitydefaults.definition
where entitydefaults.definitionname like '%reward1_bot%';

--Deletes
DELETE item FROM [perpetuumsa].[dbo].[itemshop] as item
Join entitydefaults on targetdefinition=entitydefaults.definition
where tiertype = 3 and (tierlevel=2 or tierlevel=4);

DELETE item FROM [perpetuumsa].[dbo].[itemshop] as item
Join entitydefaults on targetdefinition=entitydefaults.definition
where entitydefaults.categoryflags=1179 and entitydefaults.definitionname like '%lottery%';

DELETE item FROM [perpetuumsa].[dbo].[itemshop] as item
Join entitydefaults on targetdefinition=entitydefaults.definition
where entitydefaults.definitionname like '%reward1_bot%';


--------------------------------------------------------
--EntityDefault Disabling T2+/T4+, lottery, elite heavies

--Set t2+/t4+ disabled, hidden and non-purchasable
Update [perpetuumsa].[dbo].[entitydefaults]
SET enabled=0, hidden=1, purchasable=0
WHERE tiertype = 3 and (tierlevel=2 or tierlevel=4)

--Set lottery disabled, hidden and non-purchasable
Update [perpetuumsa].[dbo].[entitydefaults]
SET enabled=0, hidden=1, purchasable=0
where entitydefaults.categoryflags=1179 and entitydefaults.definitionname like '%lottery%';

--Set elite heavies disabled, hidden and non-purchasable
Update [perpetuumsa].[dbo].[entitydefaults]
SET enabled=0, hidden=1, purchasable=0
where entitydefaults.definitionname like '%reward1_bot%';


-----------------------------------------------------
--Disable PBS research tree and skill
DECLARE @groupID int;
SET @groupID = (SELECT TOP 1 id from techtreegroups where name='pbs');

--disable and hide pbs extension
UPDATE dbo.extensions
SET active=0, hidden=1
WHERE extensionid=350;

--Lockout PBS research tree
UPDATE prices
SET prices.pointtype=7
FROM techtreenodeprices prices
    INNER JOIN techtree tree ON
        prices.definition = tree.childdefinition
WHERE tree.groupID = @groupID;



----------------------------------------------------------
--Disable PBS "capsules" (things that are used to make structures)
SELECT * FROM entitydefaults
WHERE (categoryflags & 255)=154;

UPDATE entitydefaults SET enabled=0, hidden=1, purchasable=0
WHERE (categoryflags & 255)=154;


-------------------------------------------------------
--DELETE mk2 CTs from Artifact loot
SELECT artifactloot.*, entitydefaults.*
  FROM [perpetuumsa].[dbo].[artifactloot]
  join entitydefaults on artifactloot.definition=entitydefaults.definition
  WHERE entitydefaults.categoryflags=153;

--Delete all mk2 CT drops from artifacts
DELETE loot FROM [perpetuumsa].[dbo].[artifactloot] as loot
  JOIN entitydefaults ON loot.definition=entitydefaults.definition
  WHERE entitydefaults.categoryflags=153;

--Disable EntityDefaults for mk2CTS
SELECT * from entitydefaults where categoryflags=153;

--Disable mk2 CT items
UPDATE entitydefaults SET enabled=0, hidden=1
WHERE categoryflags=153;



---------------------------------------------------------------
--Disable mk2 bots
--TODO could be better query
SELECT * from entitydefaults
where definitionname like '%mk2_bot%';
--DISABLE mk2 bots
UPDATE entitydefaults SET enabled=0, hidden=1, purchasable=0
WHERE definitionname like '%mk2_bot';



--------------------------------------------------
--FINAL run cleanup procedure
EXEC dbo.cleanUpGame;
EXEC dbo.cleanUpMarket;