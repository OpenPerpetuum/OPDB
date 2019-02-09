USE [perpetuumsa]
GO

CREATE SCHEMA opp
GO



-- Patch to add EP Boost Item Definition
begin transaction
set xact_abort on

create table #temp_ins_entitydefaults 
(
	[definition] int not null,
	definitionname varchar(100) not null,
	credit float not null,
	tmcoin int not null,
	icscoin int not null,
	asicoin int not null,
	unicoin int not null
);

insert into dbo.entitydefaults
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
output
	inserted.[definition] as [definition],
	inserted.definitionname as definitionname,
	75000000.0 as credit,
	36 as tmcoin,
	36 as icscoin,
	36 as asicoin,
	0 as unicoin
into #temp_ins_entitydefaults
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

insert into dbo.entitydefaults
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
output
	inserted.[definition] as [definition],
	inserted.definitionname as definitionname,
	115000000.0 as credit,
	60 as tmcoin,
	60 as icscoin,
	60 as asicoin,
	0 as unicoin
into #temp_ins_entitydefaults
values
(
	'def_boost_ep_t2', --'def_epboost_tier1', -- definitionname
	1, -- quantity
	2052, -- attribute flags : 0x804 copied from paint
	1179, -- category flags : 0x49B copied from paint
	'#addBoost=n3 #timePeriodHours=i18 #tier=$tierlevel_t2', -- options
	'Adds 3 to the current EP income multiplier for 24 hours', -- note
	1, -- enabled
	1E-06, -- volume
	1E-06, -- mass
	0, -- hidden
	100, -- health
	'def_redeemable_ep_standard_desc', -- descriptiontoken
	1, --purchasable
	1, -- tiertype
	2 -- tierlevel
);

insert into dbo.entitydefaults
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
output
	inserted.[definition] as [definition],
	inserted.definitionname as definitionname,
	185000000.0 as credit,
	120 as tmcoin,
	120 as icscoin,
	120 as asicoin,
	0 as unicoin
into #temp_ins_entitydefaults
values
(
	'def_boost_ep_t3', --'def_epboost_tier1', -- definitionname
	1, -- quantity
	2052, -- attribute flags : 0x804 copied from paint
	1179, -- category flags : 0x49B copied from paint
	'#addBoost=n5 #timePeriodHours=i18 #tier=$tierlevel_t3', -- options
	'Adds 5 to the current EP income multiplier for 24 hours', -- note
	1, -- enabled
	1E-06, -- volume
	1E-06, -- mass
	0, -- hidden
	100, -- health
	'def_redeemable_ep_standard_desc', -- descriptiontoken
	1, --purchasable
	1, -- tiertype
	3 -- tierlevel
);

insert into dbo.itemshop
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
select
	1, --presetid
	[definition], --targetdefinition
	1, -- targetamount
	credit, -- credit
	1, --purchasecount
	tmcoin, -- tmcoin
	icscoin, -- icscoin
	asicoin, -- asicoin
	unicoin -- unicoin
from #temp_ins_entitydefaults

insert into dbo.aggregatevalues
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
--drop table #temp_ins_entitydefaults;

commit transaction
go

-- Update the extensionsubscription table to add the extra bonus value
-- And switch datetimes to datetimeoffsets
begin transaction
set xact_abort on

ALTER TABLE [dbo].[extensionsubscription] DROP CONSTRAINT [DF_extensionsubscription_eventdate]

alter table dbo.extensionsubscription
ALTER COLUMN starttime datetimeoffset not null;

ALTER TABLE [dbo].[extensionsubscription] ADD  CONSTRAINT [DF_extensionsubscription_eventdate]  DEFAULT (SYSDATETIMEOFFSET()) FOR [starttime]

alter table dbo.extensionsubscription
ALTER COLUMN endtime datetimeoffset not null;

alter table dbo.extensionsubscription
add multiplierBonus int not null;

commit transaction
go


begin transaction
set xact_abort on

commit transaction
go



-- Update the subscription procedure to accept a value
-- Split into 2 parts, removal and addition
if object_id('opp.extensionSubscriptionStart', 'P') is not null
	drop procedure opp.extensionSubscriptionStart;
go

create procedure opp.extensionSubscriptionStart
	@accountID int,
	@startTime datetimeoffset,
	@endTime datetimeoffset,
	@multiplierBonus int
as

set nocount on;

begin transaction
set xact_abort on
set transaction isolation level read committed

if exists (select * from dbo.extensionsubscription where accountid = @accountID and endTime > @startTime)
	throw 100000, 'Extension bonus already active', 1;

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
if object_id('dbo.extensionSubscriptionExtend', 'P') is not null
	drop procedure dbo.extensionSubscriptionExtend;
go

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
where startTime < SYSDATETIMEOFFSET() and endtime > SYSDATETIMEOFFSET() and @accountID = accountid
order by endtime desc;

GO