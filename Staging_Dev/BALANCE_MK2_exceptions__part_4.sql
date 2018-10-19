USE [perpetuumsa]
GO

PRINT N'MK2 STAT AND BALANCE RULE EXCEPTIONS';
-------------Scarab MK2 Exceptions----
---head/chassis/leg
---Vanilla mk2 5/2/2
---OPP     mk1 4/2/3
---OPP     mk2 4/2/3


DECLARE @definitionID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_scarab_leg_mk2' ORDER BY definition DESC);

UPDATE entitydefaults SET options='#height=f1.5#slotFlags=420,20,20' WHERE definition=@definitionID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_scarab_head_mk2' ORDER BY definition DESC);

UPDATE entitydefaults SET options='#height=f0.1#slotFlags=48,8,8,8' WHERE definition=@definitionID;

GO
