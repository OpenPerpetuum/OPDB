-- Patch to add EP Boost Item Definition
begin transaction
set xact_abort on

create table #temp_ins_entitydefaults 
(
	[definition] int not null,
	definitionname varchar(100) not null
);

insert into entitydefaults
(
	definitionname,
	quantity,
	attributeflags,
	categoryflags,
	options,
	note,
	[enabled],
	volume,
	mass,
	[hidden],
	health,
	descriptiontoken,
	purchasable,
	tiertype,
	tierlevel
)
output inserted.[definition], inserted.definitionname into #temp_ins_entitydefaults
values
(
	'def_boost_ep_t1', --'def_epboost_tier1', -- definitionname
	1, -- quantity
	2052, -- attribute flags : 0x804 copied from paint
	1179, -- category flags : 0x49B copied from paint
	'#addBoost=n2 #timePeriodHours=i18 #tier=$tierlevel_t1', -- options
	'Adds 2 to the current EP income multiplier for 24 hours', -- note
	1, -- enabled
	1E-06, -- volume
	1E-06, -- mass
	0, -- hidden
	100, -- health
	'def_redeemable_ep_standard_desc', -- descriptiontoken
	1, --purchasable
	1, -- tiertype
	1 -- tierlevel
);

insert into itemshop
(
	presetid,
	targetdefinition,
	targetamount,
	credit,
	purchasecount,
	tmcoin,
	icscoin,
	asicoin,
	unicoin
)
select top 1
	1, --presetid
	[definition], --targetdefinition
	1, -- targetamount
	350000000.00, -- credit
	1, --purchasecount
	5, -- tmcoin
	5, -- icscoin
	5, -- asicoin
	5 -- unicoin
from #temp_ins_entitydefaults

insert into aggregatevalues
(
	[definition],
	[field],
	[value]
)
select
	[definition],
	af.id,
	8.64E+7
from #temp_ins_entitydefaults
join aggregatefields af on af.[name] = 'despawn_time';

select * from #temp_ins_entitydefaults

commit transaction
go

-- Update the extensionsubscription table to add the extra bonus value
begin transaction
set xact_abort on

alter table extensionsubscription
add multiplierBonus int not null;

commit transaction
go


-- Update the subscription procedure to accept a value
-- Split into 2 parts, removal and addition
if object_id('extensionSubscriptionStart', 'P') is not null
	drop procedure extensionSubscriptionStart;
go

create procedure extensionSubscriptionStart
	@accountID int,
	@startTime datetime,
	@endTime datetime,
	@multiplierBonus int
as

set nocount on;

begin transaction
set xact_abort on
set transaction isolation level read committed

if exists (select * from extensionsubscription where accountid = @accountID and @endTime > @startTime)-- and multiplierBonus <> @multiplierBonus)
	throw 100000, 'Extension bonus already active', 1; --delete from extensionsubscription where accountid = @accountID;

insert into dbo.extensionsubscription
(
	accountid,
	starttime,
	endtime,
	multiplierBonus
)
values
(
	@accountid,
	@startTime,
	@endTime,
	@multiplierBonus
)
commit transaction
go


-- Remove the extension extension procedure - no longer required
if object_id('extensionSubscriptionExtend', 'P') is not null
	drop procedure extensionSubscriptionExtend;
go

if object_id('getExtensionSubscription', 'P') is not null
	drop procedure getExtensionSubscription;
go

create procedure getExtensionSubscription
	@accountID int
as

select top 1
	starttime,
	endtime,
	multiplierBonus
from extensionsubscription
where startTime < getutcdate() and endtime > getutcdate()
order by endtime desc;

--begin tran
--set xact_abort on

--delete ag from aggregatevalues ag join #temp_ins_entitydefaults tie on ag.[definition] = tie.[definition];
--delete its from itemshop its join #temp_ins_entitydefaults tie on its.targetdefinition = tie.[definition];
--delete ed from entitydefaults ed join #temp_ins_entitydefaults tie on ed.[definition] = tie.[definition]

--drop table #temp_ins_entitydefaults;
--commit tran