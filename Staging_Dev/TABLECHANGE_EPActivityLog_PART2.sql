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
ADD bonusMultiplier int NULL
CONSTRAINT D_epforactivitylog_bonusMultiplier
DEFAULT (0)
WITH VALUES --Set all existing entries to the default server BonusMultiplier (assumes no events have run)

GO


