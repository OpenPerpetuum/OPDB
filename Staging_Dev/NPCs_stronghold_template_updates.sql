USE [perpetuumsa]
GO

---------Updates for Omega stronghold npc templates ---------------

DECLARE @templateID int;
PRINT N'Cameleon NPC miniboss3 template';
SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'Cameleon NPC miniboss3' ORDER BY id DESC);
UPDATE robottemplates SET name='Cameleon NPC miniboss3', description='#robot=iba1#head=ib98#chassis=ib99#leg=ib9a#container=i146#headModules=[|m0=[|definition=i33|slot=i4]|m1=[|definition=i32|slot=i4]|m2=[|definition=i32|slot=i4]|m3=[|definition=i391|slot=i4]|m4=[|definition=i31|slot=i4]]#chassisModules=[|m0=[|definition=i42|slot=i1|ammoDefinition=i980|ammoQuantity=i19]|m1=[|definition=i42|slot=i2|ammoDefinition=i980|ammoQuantity=i19]|m2=[|definition=i23|slot=i3|ammoDefinition=i980|ammoQuantity=ia]]#legModules=[|m0=[|definition=i12a|slot=i1]|m1=[|definition=ie|slot=i2]|m2=[|definition=i18|slot=i3]]', note='' WHERE id=@templateID;

PRINT N'Baphomet NPC miniboss3 template';
SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'Baphomet NPC miniboss3' ORDER BY id DESC);
UPDATE robottemplates SET name='Baphomet NPC miniboss3', description='#robot=ibae#head=iba7#chassis=iba8#leg=iba9#container=i148#headModules=[|m0=[|definition=i31|slot=i6]|m1=[|definition=i2b|slot=i6]|m2=[|definition=i38f|slot=i6]|m3=[|definition=i38f|slot=i6]]#chassisModules=[|m0=[|definition=i39|slot=i1|ammoDefinition=i10f|ammoQuantity=i19]|m1=[|definition=i39|slot=i2|ammoDefinition=i10f|ammoQuantity=i19]|m2=[|definition=i39|slot=i3|ammoDefinition=i10f|ammoQuantity=i19]|m3=[|definition=i39|slot=i4|ammoDefinition=i10f|ammoQuantity=i19]|m4=[|definition=i39|slot=i5|ammoDefinition=i10f|ammoQuantity=i19]]#legModules=[|m0=[|definition=ie|slot=i1]|m1=[|definition=i12|slot=i2]|m2=[|definition=i1b|slot=i3]|m3=[|definition=i12a|slot=i4]]', note='' WHERE id=@templateID;

PRINT N'Arbalest NPC miniboss3 template';
SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'Arbalest NPC miniboss3' ORDER BY id DESC);
UPDATE robottemplates SET name='Arbalest NPC miniboss3', description='#robot=ibad#head=iba4#chassis=iba5#leg=iba6#container=i148#headModules=[|m0=[|definition=i31|slot=i7]|m1=[|definition=i32|slot=i7]|m2=[|definition=i33|slot=i7]]#chassisModules=[|m0=[|definition=i42|slot=i1|ammoDefinition=if8|ammoQuantity=i19]|m1=[|definition=i42|slot=i2|ammoDefinition=if8|ammoQuantity=i19]|m2=[|definition=i42|slot=i3|ammoDefinition=if8|ammoQuantity=i19]|m3=[|definition=i42|slot=i4|ammoDefinition=if8|ammoQuantity=i19]|m4=[|definition=i42|slot=i5|ammoDefinition=if8|ammoQuantity=i19]]#legModules=[|m0=[|definition=ie|slot=i1]|m1=[|definition=i12|slot=i2]|m2=[|definition=i18|slot=i3]|m3=[|definition=i12a|slot=i4]]', note='' WHERE id=@templateID;

