USE [perpetuumsa]
GO

--BugFix - Procedure missing account check
if object_id('opp.getExtensionSubscription', 'P') is not null
	drop procedure opp.getExtensionSubscription;
go

create procedure opp.getExtensionSubscription
	@accountID int
as

select top 1
	starttime,
	endtime,
	multiplierBonus
from dbo.extensionsubscription
where startTime < getutcdate() and endtime > getutcdate() and @accountID = accountid
order by endtime desc;

GO