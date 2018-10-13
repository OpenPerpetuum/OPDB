USE [perpetuumsa]
GO


-----------PART2-----------
--Req's TABLECHANGE_EPActivityLog to be applied FIRST
---------------------------
--Add column to epforactivitylog table  PART 2
--Req'd for ep-bonus-command Feature request
--Will log any ADDITIONAL BonusMultiplier boost there may be
---------------------------

--Add integer column named 'bonusMultiplier'
ALTER TABLE [epforactivitylog]
ADD bonusMultiplier int; 

GO

--Set all previous null entries to the default server BonusMultiplier (assumes no events have run)
UPDATE 
	epforactivitylog
SET 
	bonusMultiplier = 0
WHERE
	bonusMultiplier IS NULL;

GO