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