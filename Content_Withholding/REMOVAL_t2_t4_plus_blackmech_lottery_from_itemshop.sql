SELECT [itemshop].*, entitydefaults.* FROM [perpetuumsa].[dbo].[itemshop]
Join entitydefaults on targetdefinition=entitydefaults.definition
where tiertype = 3 and (tierlevel=2 or tierlevel=4);

SELECT [itemshop].*, entitydefaults.* FROM [perpetuumsa].[dbo].[itemshop]
Join entitydefaults on targetdefinition=entitydefaults.definition
where entitydefaults.categoryflags=1179 and entitydefaults.definitionname like '%lottery%';

SELECT [itemshop].*, entitydefaults.* FROM [perpetuumsa].[dbo].[itemshop]
Join entitydefaults on targetdefinition=entitydefaults.definition
where entitydefaults.definitionname like '%reward1_bot%';

--Remove all T2+/T4+, (includes lottery), and elite heavy mechs from SyndicateShops
DELETE item FROM [perpetuumsa].[dbo].[itemshop] as item
Join entitydefaults on targetdefinition=entitydefaults.definition
where tiertype = 3 and (tierlevel=2 or tierlevel=4);

DELETE item FROM [perpetuumsa].[dbo].[itemshop] as item
Join entitydefaults on targetdefinition=entitydefaults.definition
where entitydefaults.categoryflags=1179 and entitydefaults.definitionname like '%lottery%';

DELETE item FROM [perpetuumsa].[dbo].[itemshop] as item
Join entitydefaults on targetdefinition=entitydefaults.definition
where entitydefaults.definitionname like '%reward1_bot%';
