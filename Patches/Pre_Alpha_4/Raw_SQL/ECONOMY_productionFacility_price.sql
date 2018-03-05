USE [perpetuumsa]
GO

PRINT N'Update all facility costpersecond from 3 to 7';

UPDATE entitydefaults 
SET options = REPLACE(options, '#perSecondPrice=f3', '#perSecondPrice=f7')
WHERE definition in
(SELECT DISTINCT entities.definition FROM entities
join entitydefaults on entitydefaults.definition=entities.definition
where entitydefaults.options like '%#perSecondPrice=f3%');