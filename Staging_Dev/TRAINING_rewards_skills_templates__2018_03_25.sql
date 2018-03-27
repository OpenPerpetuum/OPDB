USE [perpetuumsa]
GO

PRINT N'Robot Template updates for training rewards';

PRINT N'baphomet_starterpack';
DECLARE @templateID int;
SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'baphomet_starterpack' ORDER BY id DESC)

UPDATE robottemplates SET name='baphomet_starterpack', description='#robot=ica#head=i61#chassis=i62#leg=i63#container=i148#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i2b|slot=i2]|m2=[|definition=i38f|slot=i3]|m3=[|definition=i38f|slot=i4]]#chassisModules=[|m0=[|definition=i39|slot=i1|ammoDefinition=i112|ammoQuantity=i78]|m1=[|definition=i39|slot=i2|ammoDefinition=i112|ammoQuantity=i78]|m2=[|definition=i39|slot=i3|ammoDefinition=i112|ammoQuantity=i78]|m3=[|definition=i39|slot=i4|ammoDefinition=i112|ammoQuantity=i78]|m4=[|definition=i39|slot=i5|ammoDefinition=i112|ammoQuantity=i78]]#legModules=[|m0=[|definition=i12|slot=i1]|m1=[|definition=ie|slot=i2]|m2=[|definition=i1b|slot=i3]|m3=[|definition=i19|slot=i4]]#items=[|i0=[|definition=i112|quantity=i1f4|repackaged=i0]]', note='' WHERE id=@templateID;

PRINT N'arbalest_starterpack';
SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'arbalest_starterpack' ORDER BY id DESC)

UPDATE robottemplates SET name='arbalest_starterpack', description='#robot=ic9#head=i5e#chassis=i5f#leg=i60#container=i148#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i38d|slot=i2]|m2=[|definition=i38d|slot=i3]|m3=[|definition=i424|slot=i4]]#chassisModules=[|m0=[|definition=i42|slot=i1|ammoDefinition=ifa|ammoQuantity=i32]|m1=[|definition=i42|slot=i2|ammoDefinition=ifa|ammoQuantity=i32]|m2=[|definition=i42|slot=i3|ammoDefinition=ifa|ammoQuantity=i32]|m3=[|definition=i42|slot=i4|ammoDefinition=ifa|ammoQuantity=i32]|m4=[|definition=i42|slot=i5|ammoDefinition=ifa|ammoQuantity=i32]]#legModules=[|m0=[|definition=i12|slot=i1]|m1=[|definition=ie|slot=i2]|m2=[|definition=i12|slot=i3]|m3=[|definition=i29|slot=i4]]#items=[|i0=[|definition=ifa|quantity=i1f4|repackaged=i0]]', note='' WHERE id=@templateID;

PRINT N'waspish_starterpack';
SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'waspish_starterpack' ORDER BY id DESC)

UPDATE robottemplates SET name='waspish_starterpack', description='#robot=ic4#head=i4f#chassis=i50#leg=i51#container=i148#headModules=[|m0=[|definition=i2b|slot=i1]|m1=[|definition=i2b|slot=i2]|m2=[|definition=i38e|slot=i3]|m3=[|definition=i1f|slot=i4]]#chassisModules=[|m0=[|definition=i3f|slot=i1|ammoDefinition=i11e|ammoQuantity=i14]|m1=[|definition=i3f|slot=i2|ammoDefinition=i11e|ammoQuantity=i14]|m2=[|definition=i3f|slot=i3|ammoDefinition=i11e|ammoQuantity=i14]|m3=[|definition=i3f|slot=i4|ammoDefinition=i11e|ammoQuantity=i14]|m4=[|definition=i3f|slot=i5|ammoDefinition=i11e|ammoQuantity=i14]]#legModules=[|m0=[|definition=i12|slot=i1]|m1=[|definition=ie|slot=i2]|m2=[|definition=i1c|slot=i3]|m3=[|definition=i29|slot=i4]]#items=[|i0=[|definition=i11e|quantity=i1f4|repackaged=i0]]', note='' WHERE id=@templateID;


PRINT N'Updates to pelistal training rewards';

UPDATE [dbo].[trainingrewards]
   SET [level] = 1
      ,[definition] = (SELECT definition FROM entitydefaults WHERE definitionname='def_ammo_rocket_a')
      ,[quantity] = 250
      ,[robottemplateid] = NULL
      ,[raceid] = 1
 WHERE raceid=1 and level=1 and quantity=2500 and definition=(SELECT definition FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_a');

UPDATE [dbo].[trainingrewards]
   SET [level] = 1
      ,[definition] = (SELECT definition FROM entitydefaults WHERE definitionname='def_ammo_rocket_b')
      ,[quantity] = 250
      ,[robottemplateid] = NULL
      ,[raceid] = 1
 WHERE raceid=1 and level=1 and quantity=2500 and definition=(SELECT definition FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_b');

 UPDATE [dbo].[trainingrewards]
   SET [level] = 1
      ,[definition] = (SELECT definition FROM entitydefaults WHERE definitionname='def_ammo_rocket_c')
      ,[quantity] = 250
      ,[robottemplateid] = NULL
      ,[raceid] = 1
 WHERE raceid=1 and level=1 and quantity=2500 and definition=(SELECT definition FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_c');

UPDATE [dbo].[trainingrewards]
   SET [level] = 1
      ,[definition] = (SELECT definition FROM entitydefaults WHERE definitionname='def_ammo_rocket_d')
      ,[quantity] = 250
      ,[robottemplateid] = NULL
      ,[raceid] = 1
 WHERE raceid=1 and level=1 and quantity=2500 and definition=(SELECT definition FROM entitydefaults WHERE definitionname='def_ammo_small_projectile_d');

SET @templateID = (SELECT TOP 1 id from robottemplates WHERE [name] = 'waspish_starterpack' ORDER BY id DESC)
 UPDATE [dbo].[trainingrewards]
   SET [level] = 4
      ,[definition] = NULL
      ,[quantity] = NULL
      ,[robottemplateid] = @templateID
      ,[raceid] = 1
 WHERE raceid=1 and level=3 and robottemplateid =@templateID

GO


PRINT N'Insert Addl skills on trainingexit';

DECLARE @extid int;


SET @extid = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname='ext_core_management');

PRINT N'Insert ext_core_management skill to races 1-3';

INSERT INTO [dbo].[cw_race_extension]
           ([raceid],[extensionid],[levelincrement])
     VALUES
           (1,@extid,2);

INSERT INTO [dbo].[cw_race_extension]
           ([raceid],[extensionid],[levelincrement])
     VALUES
           (2,@extid,2);

INSERT INTO [dbo].[cw_race_extension]
           ([raceid],[extensionid],[levelincrement])
     VALUES
           (3,@extid,2);


SET @extid = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname='ext_shield_operation');

PRINT N'Insert ext_shield_operation skill to race 1';	   

INSERT INTO [dbo].[cw_race_extension]
           ([raceid],[extensionid],[levelincrement])
     VALUES
           (1,@extid,4);


SET @extid = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname='ext_shield_upgrades');

PRINT N'Insert ext_shield_upgrades skill to race 1';	 


INSERT INTO [dbo].[cw_race_extension]
           ([raceid],[extensionid],[levelincrement])
     VALUES
           (1,@extid,1);


SET @extid = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname='ext_hull_upgrades');

PRINT N'Insert ext_hull_upgrades skill to race 3';	 

 INSERT INTO [dbo].[cw_race_extension]
           ([raceid],[extensionid],[levelincrement])
     VALUES
           (3,@extid,1);



SET @extid = (SELECT TOP 1 extensionid FROM extensions WHERE extensionname='ext_weapon_cpu_upgrade');

PRINT N'Insert ext_weapon_cpu_upgrade skill to races 1-3';	 

INSERT INTO [dbo].[cw_race_extension]
           ([raceid],[extensionid],[levelincrement])
     VALUES
           (1,@extid,1);

INSERT INTO [dbo].[cw_race_extension]
           ([raceid],[extensionid],[levelincrement])
     VALUES
           (2,@extid,1);

INSERT INTO [dbo].[cw_race_extension]
           ([raceid],[extensionid],[levelincrement])
     VALUES
           (3,@extid,1);


GO

