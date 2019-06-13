USE [perpetuumsa]
GO

----------------------------------------------
--EP Bonus Item Price reduce, and Duration increase
--
--Date: 2019/06/12
----------------------------------------------

DECLARE @epboost1 int;
DECLARE @epboost2 int;
DECLARE @epboost3 int;

SET @epboost1 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_boost_ep_t1');
SET @epboost2 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_boost_ep_t2');
SET @epboost3 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_boost_ep_t3');

PRINT N'Update Entitydefault of boost items, change options(the real stuff) string and note';
UPDATE entitydefaults SET
	options = '#addBoost=n2 #timePeriodHours=i30 #tier=$tierlevel_t1',
	note = 'Adds 2 to the current EP income multiplier for 48 hours'
WHERE definition=@epboost1;

UPDATE entitydefaults SET
	options = '#addBoost=n3 #timePeriodHours=i30 #tier=$tierlevel_t2',
	note = 'Adds 3 to the current EP income multiplier for 48 hours'
WHERE definition=@epboost2;

UPDATE entitydefaults SET
	options = '#addBoost=n5 #timePeriodHours=i30 #tier=$tierlevel_t3',
	note = 'Adds 5 to the current EP income multiplier for 48 hours'
WHERE definition=@epboost3;

PRINT N'Update AggregateValues for the items despawntime, info window data to help players understand how long it lasts';
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'despawn_time' ORDER BY [name] DESC);

SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @epboost1 AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@epboost1, field=@aggfieldID, value=172800000 WHERE id =  @aggvalueID;

SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @epboost2 AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@epboost2, field=@aggfieldID, value=172800000 WHERE id =  @aggvalueID;

SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @epboost3 AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@epboost3, field=@aggfieldID, value=172800000 WHERE id =  @aggvalueID;

PRINT N'Update itemshop nic pricing to T1=40m, T2=57.5m T3=95m';
UPDATE itemshop SET
credit = 40000000
WHERE targetdefinition=@epboost1;

UPDATE itemshop SET
credit = 57500000
WHERE targetdefinition=@epboost2;

UPDATE itemshop SET
credit = 95000000
WHERE targetdefinition=@epboost3;

GO
