USE [perpetuumsa]
GO

---------------------------
--Add column to epforactivitylog table
--Req'd for ep-bonus-command Feature request
--Will log current server BonusMultiplier at each logevent
---------------------------

--Add integer column named 'multiplier'
ALTER TABLE [epforactivitylog]
ADD multiplier int; 


--Set all previous null entries to the default server BonusMultiplier (assumes no events have run)
UPDATE epforactivitylog
SET epforactivitylog.multiplier=25
WHERE
multiplier=NULL;

GO