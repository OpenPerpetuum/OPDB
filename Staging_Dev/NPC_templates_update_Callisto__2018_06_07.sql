USE [perpetuumsa]
GO

PRINT N'UPDATE Alpha Boss Template (william h bonney)';
DECLARE @templateID int
SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'CallistoAlphaBoss' ORDER BY id DESC)

UPDATE robottemplates SET name='CallistoAlphaBoss', description='#robot=i1590#head=i1591#chassis=i1592#leg=i1593#container=i149#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i33|slot=i4]]#chassisModules=[|m0=[|definition=i3d|slot=i1|ammoDefinition=i986|ammoQuantity=i0]|m1=[|definition=i3d|slot=i2|ammoDefinition=i986|ammoQuantity=i0]|m2=[|definition=i27|slot=i3]]#legModules=[|m0=[|definition=i10|slot=i1]|m1=[|definition=i19|slot=i2]|m2=[|definition=i12a|slot=i3]|m3=[|definition=i13|slot=i4]]', note='Using for boss bot' WHERE id=@templateID;

GO

