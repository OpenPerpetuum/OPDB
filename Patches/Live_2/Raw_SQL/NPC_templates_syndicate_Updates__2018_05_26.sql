USE [perpetuumsa]
GO

DECLARE @templateID int;

---REMOVE EWAR FROM ALL SYNDICATE COMBATS
PRINT N'REMOVE EWAR FROM ALL SYNDICATE COMBATS';

--echelon
SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'echelon_masterdeathdealer' ORDER BY id DESC)

UPDATE robottemplates SET name='echelon_masterdeathdealer', description='#robot=i158c#head=i158d#chassis=i158e#leg=i158f#container=i14a#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i390|slot=i2]|m2=[|definition=i34|slot=i3]]#chassisModules=[|m0=[|definition=i3d|slot=i1|ammoDefinition=i107|ammoQuantity=ic8]|m1=[|definition=i3d|slot=i2|ammoDefinition=i107|ammoQuantity=ic8]|m2=[|definition=i3d|slot=i3|ammoDefinition=i107|ammoQuantity=ic8]|m3=[|definition=i3d|slot=i4|ammoDefinition=i107|ammoQuantity=ic8]]#legModules=[|m0=[|definition=i12a|slot=i1]|m1=[|definition=i10|slot=i2]|m2=[|definition=i13|slot=i3]|m3=[|definition=i19|slot=i4]]', note='echelon master death dealer' WHERE id=@templateID;

--Legatus
SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'legatus_mastergoat' ORDER BY id DESC)

UPDATE robottemplates SET name='legatus_mastergoat', description='#robot=i1594#head=i1595#chassis=i1596#leg=i1597#container=i14c#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i34|slot=i7]|m2=[|definition=i2b|slot=i7]]#chassisModules=[|m0=[|definition=i3d|slot=i1|ammoDefinition=i107|ammoQuantity=ic8]|m1=[|definition=i3d|slot=i2|ammoDefinition=i107|ammoQuantity=ic8]|m2=[|definition=i3d|slot=i3|ammoDefinition=i107|ammoQuantity=ic8]|m3=[|definition=i3d|slot=i4|ammoDefinition=i107|ammoQuantity=ic8]|m4=[|definition=i3d|slot=i5|ammoDefinition=i107|ammoQuantity=ic8]|m5=[|definition=i3d|slot=i6|ammoDefinition=i107|ammoQuantity=ic8]]#legModules=[|m0=[|definition=i10|slot=i1]|m1=[|definition=i13|slot=i2]|m2=[|definition=i19|slot=i3]|m3=[|definition=i10|slot=i4]]', note='THE GOAT RRRAAAAWWWRRRR' WHERE id=@templateID;

--Locust
SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'locust_firstmate' ORDER BY id DESC)

UPDATE robottemplates SET name='locust_firstmate', description='#robot=i1588#head=i1589#chassis=i158a#leg=i158b#container=i148#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i2d|slot=i6]|m2=[|definition=i34|slot=i6]]#chassisModules=[|m0=[|definition=i3c|slot=i1|ammoDefinition=i103|ammoQuantity=ic8]|m1=[|definition=i3c|slot=i2|ammoDefinition=i103|ammoQuantity=ic8]|m2=[|definition=i3c|slot=i3|ammoDefinition=i103|ammoQuantity=ic8]|m3=[|definition=i3c|slot=i4|ammoDefinition=i103|ammoQuantity=ic8]|m4=[|definition=i3c|slot=i5|ammoDefinition=i103|ammoQuantity=ic8]]#legModules=[|m0=[|definition=ie|slot=i1]|m1=[|definition=i12|slot=i2]|m2=[|definition=i12a|slot=i3]]', note='Locust First Mate' WHERE id=@templateID;

--Vektor 
SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'vektor_swab_lead' ORDER BY id DESC)

UPDATE robottemplates SET name='vektor_swab_lead', description='#robot=i1580#head=i1581#chassis=i1582#leg=i1583#container=i147#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i390|slot=i5]]#chassisModules=[|m0=[|definition=i3c|slot=i1|ammoDefinition=i103|ammoQuantity=ic8]|m1=[|definition=i3c|slot=i2|ammoDefinition=i103|ammoQuantity=ic8]|m2=[|definition=i3c|slot=i3|ammoDefinition=i103|ammoQuantity=ic8]|m3=[|definition=i3c|slot=i4|ammoDefinition=i103|ammoQuantity=ic8]]#legModules=[|m0=[|definition=ie|slot=i1]|m1=[|definition=i12|slot=i2]]', note='Vektor Swab Lead' WHERE id=@templateID;

----End Ewar Removal to Syndicates


GO