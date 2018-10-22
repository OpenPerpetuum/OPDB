USE [perpetuumsa]
GO

PRINT N'MK2 STAT AND BALANCE RULE EXCEPTIONS';
-------------Scarab MK2 Exceptions----
---head/chassis/leg
---Vanilla mk2 5/2/2
---OPP     mk1 4/2/3
---OPP     mk2 4/2/3

---Exceptional mk1 changes to fast-forward to mk2s
--HM chassis misc slots 4->2
--Gropho mk1 chassis options = '#height=f0.8#slotFlags=4d2,d2,2d2,2d2,4d2,4d2,4d0'
--Mesmer mk1 chassis options = #height=f1.1#slotFlags=46d1,d1,d1,2d1,d1,4d1,4d0
--Seth mk1 chassis options = '#height=f0.75#slotFlags=46d1,d1,d1,2d1,d1,4d1'


DECLARE @definitionID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_scarab_leg_mk2' ORDER BY definition DESC);
UPDATE entitydefaults SET options='#height=f1.5#slotFlags=420,20,20' WHERE definition=@definitionID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_scarab_head_mk2' ORDER BY definition DESC);
UPDATE entitydefaults SET options='#height=f0.1#slotFlags=48,8,8,8' WHERE definition=@definitionID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_gropho_chassis_mk2' ORDER BY definition DESC);
UPDATE entitydefaults SET options='#height=f0.8#slotFlags=4d2,d2,2d2,2d2,4d2,4d2,4d0' WHERE definition=@definitionID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_chassis_mk2' ORDER BY definition DESC);
UPDATE entitydefaults SET options='#height=f1.1#slotFlags=46d1,d1,d1,2d1,d1,4d1,4d0' WHERE definition=@definitionID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_seth_chassis_mk2' ORDER BY definition DESC);
UPDATE entitydefaults SET options='#height=f0.75#slotFlags=46d1,d1,d1,2d1,d1,4d1' WHERE definition=@definitionID;

GO

