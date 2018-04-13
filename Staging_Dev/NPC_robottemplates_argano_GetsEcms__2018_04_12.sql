USE [perpetuumsa]
GO

DECLARE @templateID int
SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'Argano NPC' ORDER BY id DESC)

UPDATE robottemplates SET name='Argano NPC', description='#robot=ic5#head=i52#chassis=i53#leg=i54#container=i149#headModules=[|m0=[|definition=ie4|slot=i1|ammoDefinition=i47b|ammoQuantity=ia]|m1=[|definition=i32|slot=i4]|m2=[|definition=i33|slot=i4]]#chassisModules=[|m0=[|definition=i35|slot=i1|ammoDefinition=i378|ammoQuantity=i2d]|m1=[|definition=i35|slot=i2|ammoDefinition=i378|ammoQuantity=i2d]|m2=[|definition=i15|slot=i3]]#legModules=[|m0=[|definition=i285|slot=i1]]#items=[|i0=[|definition=i38b|quantity=i47|repackaged=i0]|i1=[|definition=i387|quantity=i42|repackaged=i0]|i2=[|definition=i389|quantity=i36|repackaged=i0]|i3=[|definition=i388|quantity=i48|repackaged=i0]|i4=[|definition=i38a|quantity=i4e|repackaged=i0]|i5=[|definition=i378|quantity=i321|repackaged=i0]|i6=[|definition=ia8|quantity=i410|repackaged=i0]]', note='' WHERE id=@templateID;

GO
