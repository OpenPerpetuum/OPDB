
SELECT *
FROM [perpetuumsa].[dbo].[entitydefaults]
where (categoryflags & 65535)=3841;

--Fully enable all syndicate bots
UPDATE entitydefaults SET purchasable=1, enabled=1, hidden=0
WHERE (categoryflags & 65535)=3841;