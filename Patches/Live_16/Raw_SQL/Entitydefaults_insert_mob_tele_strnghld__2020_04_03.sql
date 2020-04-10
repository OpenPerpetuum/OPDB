USE [perpetuumsa]
GO

------------------------------------------------------------------
--Stronghold teleporter item definitions
--Adds or updates entitydefaults
--Date modified: 2020/04/03
------------------------------------------------------------------


DECLARE @capsuleName VARCHAR(128);
DECLARE @fieldDevName VARCHAR(128);

SET @capsuleName = 'def_mobile_teleport_stronghold_capsule';
SET @fieldDevName = 'def_mobile_teleport_stronghold_basic';

IF NOT EXISTS (SELECT definition FROM entitydefaults WHERE definitionname=@capsuleName)
BEGIN
	INSERT INTO [dbo].[entitydefaults] ([definitionname],[quantity],[attributeflags],[categoryflags],[options],[note],[enabled],[volume],[mass],[hidden],[health],[descriptiontoken],[purchasable],[tiertype],[tierlevel]) VALUES
	(@capsuleName,1,25167872,131480,'','Stronghold teleport capsule',1,4,8000,0,100,'def_mobile_teleport_stronghold_capsule_desc',1,0,0);
END
ELSE
BEGIN
	UPDATE entitydefaults SET
		attributeflags = 25167872,
		categoryflags = 131480,
		note = 'Stronghold teleport capsule',
		volume = 4,
		mass = 8000
	WHERE definitionname=@capsuleName;
END

IF NOT EXISTS (SELECT definition FROM entitydefaults WHERE definitionname=@fieldDevName)
BEGIN
INSERT INTO [dbo].[entitydefaults] ([definitionname],[quantity],[attributeflags],[categoryflags],[options],[note],[enabled],[volume],[mass],[hidden],[health],[descriptiontoken],[purchasable],[tiertype],[tierlevel]) VALUES
(@fieldDevName,1,12583936,33948280,'','Stronghold teleport field obj',1,4,8000,0,100,'def_mobile_teleport_stronghold_basic_desc',0,0,0);
END
ELSE
BEGIN
	UPDATE entitydefaults SET
		attributeflags = 12583936,
		categoryflags = 33948280,
		note = 'Stronghold teleport field ob',
		volume = 4,
		mass = 8000
	WHERE definitionname=@fieldDevName;
END


IF NOT EXISTS (SELECT definition FROM definitionconfig WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = @capsuleName))
BEGIN
	INSERT INTO definitionconfig (definition, targetdefinition, action_delay, note) VALUES
	((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = @capsuleName), 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = @fieldDevName), 
	120000, 
	'Stronghold mobile teleport mapping');
END
ELSE
BEGIN
	UPDATE definitionconfig SET
		action_delay=120000
	WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = @capsuleName);
END


DECLARE @tmShops INT;
DECLARE @strongholdTeleDef INT;
SET @strongholdTeleDef = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = @capsuleName);

SET @tmShops = (SELECT TOP 1 id FROM itemshoppresets WHERE name='tm_preset_pve');

IF NOT EXISTS (SELECT [targetdefinition] FROM [itemshop] WHERE [targetdefinition]=@strongholdTeleDef)
BEGIN
INSERT INTO [dbo].[itemshop]
           ([presetid],[targetdefinition],[targetamount],[tmcoin],[icscoin],[asicoin],[credit],[unicoin],[globallimit],[purchasecount],[standing])
     VALUES
		   (@tmShops,@strongholdTeleDef,1,100,100,100,1000000,100,NULL,0,1);
END
ELSE
BEGIN
	UPDATE [dbo].[itemshop] SET
		tmcoin=100,
		icscoin=100,
		asicoin=100,
		credit=1000000,
		unicoin=100,
		standing=1
	WHERE presetid=@tmShops AND targetdefinition=@strongholdTeleDef;
END

GO