USE [perpetuumsa]
GO

-----------------------------------------------------
-- Stronghold npc bugs/tweaks
-- Bonnie and helix no armor rep equipped
-- Date Modified: 2021_05_01
-----------------------------------------------------

PRINT N'UPDATE robot templates for Zone71_WilliamHBonnie and Helix_Boss_Guard';
UPDATE robottemplates SET
	description='#robot=i1590#head=i1591#chassis=i1592#leg=i1593#container=i149#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i33|slot=i2]|m2=[|definition=i32|slot=i3]|m3=[|definition=i0|slot=i4]|m4=[|definition=i0|slot=i5]]#chassisModules=[|m0=[|definition=i3d|slot=i1|ammoDefinition=i986|ammoQuantity=i1f4]|m1=[|definition=i3d|slot=i2|ammoDefinition=i988|ammoQuantity=i1f4]|m2=[|definition=i23|slot=i3]]#legModules=[|m0=[|definition=i12|slot=i1]|m1=[|definition=i19|slot=i2]|m2=[|definition=i12a|slot=i3]|m3=[|definition=i10|slot=i4]|m4=[|definition=i9f5|slot=i5]]'
WHERE name='Zone71_WilliamHBonnie';

UPDATE robottemplates SET
	description='#robot=i1584#head=i1585#chassis=i1586#leg=i1587#container=i146#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i33|slot=i2]|m2=[|definition=i32|slot=i3]|m3=[|definition=i0|slot=i4]]#chassisModules=[|m0=[|definition=i26|slot=i1]|m1=[|definition=i26|slot=i2]|m2=[|definition=i3c|slot=i3|ammoDefinition=i984|ammoQuantity=ifa]]#legModules=[|m0=[|definition=i1c|slot=i1]|m1=[|definition=i12|slot=i2]]'
WHERE name='Helix_Boss_Guard';

GO
