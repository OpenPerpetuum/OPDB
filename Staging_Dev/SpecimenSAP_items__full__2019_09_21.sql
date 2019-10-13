USE [perpetuumsa]
GO

------------------------------------------------
--Specimen SAP Item, CTs, CT-capsule, production table, and Specimen SAP item requirements
--A full rework of Specimen SAPS - largely just making new producable items
--NOW INCLUDES: a new T0 module recycled-material
--And Specimen SAP pts = 15
--
--Last Modified: 2019/10/13
------------------------------------------------

UPDATE entitydefaults
SET options='#increase=n15'
WHERE definitionname='def_sap_specimen_processing';


----------------------------------------
-- Add new material for recovery from t0 module recycling
-- To be used by specimen items production
----------------------------------------


PRINT N'INSERT new material for t0 recycling'
DECLARE @itemName VARCHAR(128);
DECLARE @categoryOfItem BIGINT;
SET @itemName = 'def_specimen_sap_item_flux';
SET @categoryOfItem = (SELECT TOP 1 value FROM categoryFlags where name='cf_pbs_reactor_booster');

IF NOT EXISTS (SELECT TOP 1 definition from entitydefaults WHERE definitionname=@itemName)
BEGIN
	PRINT N'INSERT ' + @itemName;
	INSERT INTO [dbo].[entitydefaults]
		([definitionname],[quantity],[attributeflags],[categoryflags],[options],[note],[enabled],[volume],[mass],[hidden],[health],[descriptiontoken],[purchasable],[tiertype],[tierlevel])
	VALUES
		(@itemName,1,2048,@categoryOfItem,'','Specimen Item Material',1,0.1,0.1,0,100,'def_titanium_desc',1,NULL,NULL);
END
ELSE
BEGIN
	PRINT N'Updating ' + @itemName;
	UPDATE [dbo].[entitydefaults] SET
		volume=0.1,
		mass=0.1,
		categoryflags=@categoryOfItem,
		tierlevel=NULL,
		tiertype=NULL
	WHERE definitionname=@itemName;
END

DECLARE @itemDef int;
SET @itemDef = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@itemName);

PRINT N'Adding ' + @itemName + ' to t0 components';
IF EXISTS (SELECT TOP 1 componentdefinition from [components] WHERE componentdefinition=@itemDef)
BEGIN
	PRINT N'Deleting existing entries for this type of item for any product - for re-insert';
	DELETE FROM components WHERE componentdefinition=@itemDef;
END

DECLARE @lookupFlag BIGINT;
SET @lookupFlag = (SELECT value FROM dbo.categoryFlags WHERE name='cf_robot_equipment');
PRINT N'INSERTING INTO COMPONENTS FOR T0 MODULES ' + @itemName;
--INSERT add'l component on all t0 artifact modules for recovery via recycling
INSERT INTO [dbo].[components] ([definition],[componentdefinition],[componentamount]) 
SELECT definition, @itemDef, 4 FROM entitydefaults WHERE tiertype=1 AND tierlevel=0 AND definitionname LIKE 'def_artifact_damaged_%'
AND (categoryflags & CAST(dbo.GetCFMask(@lookupFlag)as BIGINT) = @lookupFlag);

GO

-------------------------------------------------------------------------


DECLARE @dynCtCategory bigint;
DECLARE @categoryOfItem bigint;
SET @dynCtCategory = (SELECT TOP 1 value FROM categoryFlags WHERE name='cf_dynamic_cprg');
SET @categoryOfItem = (SELECT TOP 1 value FROM categoryFlags where name='cf_pbs_reactor_booster');

DECLARE @hershfieldPresetShop int;
SET @hershfieldPresetShop = (SELECT TOP 1 id FROM itemshoppresets WHERE name = 'tm_preset_pve');

--Wipe Siege table
PRINT N'CLEAR SIEGEITEMS TABLE (Speci sap req items)';
DELETE FROM [dbo].[siegeitems];

PRINT N'SETUP TEMP TABLES';
DROP TABLE IF EXISTS #NAME_TABLE
CREATE TABLE #NAME_TABLE
(
	itemName varchar(128),
	ctName varchar(128),
	capsuleName varchar(128)
)

DROP TABLE IF EXISTS #MATERIAL_TABLE
CREATE TABLE #MATERIAL_TABLE
(
	itemName varchar(128),
	mat01 varchar(128),
	mat02 varchar(128),
	mat03 varchar(128),
	mat04 varchar(128)
);

DROP TABLE IF EXISTS #AMOUNTS_TABLE
CREATE TABLE #AMOUNTS_TABLE
(
	matName varchar(128),
	matAmount int
);

INSERT INTO #NAME_TABLE (itemName, ctName, capsuleName) VALUES
('def_specimen_sap_item', 'def_specimen_sap_item_dynamic_cprg', 'def_specimen_sap_item_CT_capsule');


INSERT INTO #MATERIAL_TABLE (itemName, mat01, mat02, mat03, mat04) VALUES
('def_specimen_sap_item', 'def_titan', 'def_crude', 'def_liquizit', 'def_specimen_sap_item_flux');

INSERT INTO #AMOUNTS_TABLE (matName, matAmount) VALUES
('def_titan', 50000),
('def_crude', 200000),
('def_liquizit', 100000),
('def_silgium', 50000),
('def_stermonit', 50000),
('def_imentium', 50000),
('def_helioptris', 50000),
('def_triandlus', 50000),
('def_prismocitae', 50000),
('def_specimen_sap_item_flux', 4);


DECLARE @itemName varchar(128);
DECLARE @ctName varchar(128);
DECLARE @capsuleName varchar(128);

DECLARE db_cursor CURSOR FOR 
SELECT itemName, ctName, capsuleName FROM #NAME_TABLE
OPEN db_cursor  
FETCH NEXT FROM db_cursor INTO  @itemName, @ctName, @capsuleName

WHILE @@FETCH_STATUS = 0  
BEGIN  

	PRINT N'1. MAKE THE ITEM [entitydefaults]';
	PRINT N'2. MAKE THE CT [entitydefaults]';
	PRINT N'3. MAKE THE CT-capsule [entitydefaults]';
	IF NOT EXISTS (SELECT TOP 1 definition from entitydefaults WHERE definitionname=@itemName)
	BEGIN
		INSERT INTO [dbo].[entitydefaults]
			([definitionname],[quantity],[attributeflags],[categoryflags],[options],[note],[enabled],[volume],[mass],[hidden],[health],[descriptiontoken],[purchasable],[tiertype],[tierlevel])
		VALUES
			(@itemName,1,2048,@categoryOfItem,'','Specimen Item',1,16,16,0,100,'def_titanium_desc',1,1,1),
			(@ctName,1,1024,@dynCtCategory,'','Specimen Item CT',1,0.1,0.1,0,100,'calibration_program_desc',0,1,1),
			(@capsuleName, 1, 2052, 1179, '', 'CT Capsule', 1, 0.1, 0.1, 0, 100, 'calibration_program_desc', 1, 1, 1);
	END
	ELSE
	BEGIN
		--Maybe we try different volumes on the item
		UPDATE [dbo].[entitydefaults] SET
		volume=16,
		mass=16,
		categoryflags=@categoryOfItem
		WHERE definitionname=@itemName;
	END


	DECLARE @itemDef int;
	DECLARE @ctDef int;
	DECLARE @ctCapsuleDef int;

	SET @itemDef = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@itemName);
	SET @ctDef = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@ctName);
	SET @ctCapsuleDef = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@capsuleName);

	PRINT N'4. Map the CT to produce the ITEM';
	IF NOT EXISTS (SELECT TOP 1 definition from [calibrationtemplateitems] WHERE definition=@ctCapsuleDef)
	BEGIN
		INSERT INTO [dbo].[calibrationtemplateitems]
			   ([definition],[targetdefinition])
		 VALUES
			   (@ctCapsuleDef,@ctDef);
	END

	PRINT N'5. MAP THE CT TO THE ITEM VIA [dynamiccalibrationtemplates]';
	IF NOT EXISTS (SELECT TOP 1 definition from [dynamiccalibrationtemplates] WHERE definition=@ctDef)
	BEGIN
		INSERT INTO [dbo].[dynamiccalibrationtemplates] ([definition],[materialefficiency],[timeefficiency],[targetdefinition]) 
		VALUES
			(@ctDef,180,180,@itemDef);
	END
	ELSE
	BEGIN
		--maybe we try different efficiencies
		UPDATE [dbo].[dynamiccalibrationtemplates] SET
			materialefficiency=180,
			timeefficiency=180
		WHERE definition=@ctDef;
	END


	PRINT N'6. INSERT CT INTO SYN SHOP';
	IF EXISTS (SELECT TOP 1 targetdefinition from [itemshop] WHERE targetdefinition=@ctCapsuleDef)
	BEGIN
		PRINT N'FOUND ITEM ALREADY IN SHOP - DELETING'
		DELETE FROM itemshop
		WHERE targetdefinition=@ctCapsuleDef;
		PRINT N'DELETED'
	END

	INSERT INTO [dbo].[itemshop]
		([presetid],[targetdefinition],[targetamount],[tmcoin],[icscoin],[asicoin],[credit],[unicoin],[globallimit],[purchasecount],[standing])
	VALUES
		(@hershfieldPresetShop,@ctCapsuleDef,1,10,10,10,500000,20,NULL,0,NULL);
	PRINT N'INSERTED itemshop entry for CT';

	PRINT N'7. INSERT ITEM TO SPECIMEN TABLE';
	INSERT INTO [dbo].[siegeitems] (definition, minquantity, maxquantity) VALUES
	(@itemDef, 2, 3);



	PRINT N'8. INSERT [components] FOR PRODUCTION MATERIAL REQUIREMENTS';
	IF EXISTS (SELECT TOP 1 definition from [components] WHERE definition=@itemDef)
	BEGIN
		PRINT N'Found Existing components for this item... DELETING!!!';
		DELETE FROM components WHERE definition=@itemDef;
		PRINT N'Item Production table deleted';
	END

	PRINT N'Inserting item production table';
	INSERT INTO [dbo].[components] ([definition],[componentdefinition],[componentamount]) VALUES
	(@itemDef,
	(SELECT TOP 1 definition from entitydefaults join #MATERIAL_TABLE on mat01=definitionname WHERE #MATERIAL_TABLE.itemName=@itemName),
	(SELECT TOP 1 matAmount from #AMOUNTS_TABLE join #MATERIAL_TABLE on mat01=matName)),
	(@itemDef,
	(SELECT TOP 1 definition from entitydefaults join #MATERIAL_TABLE on mat02=definitionname WHERE #MATERIAL_TABLE.itemName=@itemName),
	(SELECT TOP 1 matAmount from #AMOUNTS_TABLE join #MATERIAL_TABLE on mat02=matName)),
	(@itemDef,
	(SELECT TOP 1 definition from entitydefaults join #MATERIAL_TABLE on mat03=definitionname WHERE #MATERIAL_TABLE.itemName=@itemName),
	(SELECT TOP 1 matAmount from #AMOUNTS_TABLE join #MATERIAL_TABLE on mat03=matName)),
	(@itemDef,
	(SELECT TOP 1 definition from entitydefaults join #MATERIAL_TABLE on mat04=definitionname WHERE #MATERIAL_TABLE.itemName=@itemName),
	(SELECT TOP 1 matAmount from #AMOUNTS_TABLE join #MATERIAL_TABLE on mat04=matName));


	FETCH NEXT FROM db_cursor INTO  @itemName, @ctName, @capsuleName
END 

CLOSE db_cursor  
DEALLOCATE db_cursor




--Things that apply to all items via category
PRINT N'9. CONFIGURE THE DECALIBRATION SETTINGS FOR THE CT productiondecalibration';
IF NOT EXISTS (SELECT TOP 1 categoryflag from productiondecalibration WHERE categoryflag=@categoryOfItem)
BEGIN
	INSERT INTO productiondecalibration (categoryflag, distorsionmin, distorsionmax, decrease)
	VALUES(@categoryOfItem, 0.003, 0.005, 1);
	PRINT N'INSERTED declaibration for this category';
END
ELSE
BEGIN
	--Maybe we try differnet num runs (eff/decrease)
	UPDATE productiondecalibration
	SET
		categoryflag = @categoryOfItem,
		distorsionmax = 0.005,
		distorsionmin= 0.003,
		decrease=1
	WHERE categoryflag=@categoryOfItem;
	PRINT N'updated declaibration for this category';
END

PRINT N'10. CONFIGURE THE BASE-DURATION OF THE CT [productionduration]';
IF NOT EXISTS (SELECT TOP 1 category FROM [perpetuumsa].[dbo].[productionduration] WHERE category=@categoryOfItem)
BEGIN
	INSERT INTO [dbo].[productionduration]([category],[durationmodifier])
	VALUES
		(@categoryOfItem,0.25);
	PRINT N'INSERTED production duration for this category';
END
ELSE
BEGIN
	UPDATE [productionduration]
	SET
		durationmodifier = 0.25
	WHERE category=@categoryOfItem;
	PRINT N'updated production duration for this category';
END

--cleanup
PRINT N'DROP TEMP TABLES';
DROP TABLE IF EXISTS #NAME_TABLE
DROP TABLE IF EXISTS #MATERIAL_TABLE
DROP TABLE IF EXISTS #AMOUNTS_TABLE
PRINT N'========SPECIMEN FULL REWORK COMPLETE!============';

GO
