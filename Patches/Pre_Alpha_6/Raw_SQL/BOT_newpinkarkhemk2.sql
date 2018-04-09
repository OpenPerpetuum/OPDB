USE perpetuumsa
GO

PRINT N'1. Create entity (from tool)';
--OUTPUT FROM TOOL --WARNING: options string contains references to entitydefaults in hex
--ENTITYDEFAULT SAVE NEW
INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled,  volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
VALUES ( 'def_arkhe2_bot_pink', 1, 0, 257, '#head=iae8#chassis=iae9#leg=iaea#container=i147#tier=$tierlevel_mk2', 'Pink Arkhe Reward for Pre-alpha participation', 1, 12, 0, 'False', 100, 'def_arkhe2_bot_desc', 1, 1, 2); 
GO

PRINT N'2. Create template (from tool)';
--OUTPUT FROM TOOL--WARNING: description string contains references to entitydefaults in hex
--TEMPLATE INSERT
INSERT INTO robottemplates ([name], [description], [note]) 
VALUES ('def_arkhe2_bot_pink_template', '#robot=i15c1#head=iae8#chassis=iae9#leg=iaea#container=i147#headModules=[|m0=[|definition=i0|slot=i1]]#chassisModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]]#legModules=[|m0=[|definition=i0|slot=i1]|m1=[|definition=i0|slot=i2]]', 'Pre-Alpha Participant Reward');
GO

PRINT N'3. Create templaterelation';
INSERT INTO [dbo].[robottemplaterelation]
           ([definition],[templateid],[itemscoresum],[raceid],[missionlevel],[missionleveloverride],[killep],[note])
     VALUES
           ((SELECT TOP 1 definition from entitydefaults where definitionname='def_arkhe2_bot_pink')
           ,(SELECT TOP 1 id from robottemplates where name='def_arkhe2_bot_pink_template'),0,1,0,0,0,'Pre-alpha pink arkhe template relation');
GO

PRINT N'4. Insert config w/ desired tint';
INSERT INTO [dbo].[definitionconfig]
           ([definition],[tint],[note])
     VALUES
           ((SELECT TOP 1 definition from entitydefaults where definitionname='def_arkhe2_bot_pink')
           ,'#FF80FF'
           ,'YAY PINK!');
GO

PRINT N'5. Give bot skills';
--Use existing bot (that was copied from entitydefault) for extensions
INSERT INTO [dbo].[enablerextensions]
           ([definition],[extensionid],[extensionlevel])
     (SELECT (SELECT TOP 1 definition from entitydefaults where definitionname='def_arkhe2_bot_pink'), extensionid, extensionlevel from enablerextensions where definition=(Select top 1 definition from entitydefaults where definitionname='def_arkhe2_bot'));
GO
