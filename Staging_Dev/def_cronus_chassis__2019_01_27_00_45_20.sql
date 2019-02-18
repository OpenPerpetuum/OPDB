USE [perpetuumsa]
GO

--
--Cronus - Add 1-turret slot to chassis
--


DECLARE @definitionID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cronus_chassis' ORDER BY definition DESC);

UPDATE entitydefaults Set options='#height=f1.3#slotFlags=4250,250,2d1,2d0' where definition=@definitionID;

GO
