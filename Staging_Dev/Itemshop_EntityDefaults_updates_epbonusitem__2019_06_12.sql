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
