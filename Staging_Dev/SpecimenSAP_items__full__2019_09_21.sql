USE [perpetuumsa]
GO

------------------------------------------------
--Specimen SAP Items, CTs, CT-capsules, production tables, and Specimen SAP item requirements
--A full rework of Specimen SAPS - largely just making new producable items
--Last Modified: 2019/09/21
------------------------------------------------


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
	mat04 varchar(128),
	mat05 varchar(128),
	mat06 varchar(128),
	mat07 varchar(128),
	mat08 varchar(128),
	mat09 varchar(128),
	mat10 varchar(128),
	mat11 varchar(128)
);

DROP TABLE IF EXISTS #AMOUNTS_TABLE
CREATE TABLE #AMOUNTS_TABLE
(
	matName varchar(128),
	matAmount int
);

INSERT INTO #NAME_TABLE (itemName, ctName, capsuleName) VALUES
('def_specimen_sap_item_01', 'def_specimen_sap_item_01_dynamic_cprg', 'def_specimen_sap_item_01_CT_capsule'),
('def_specimen_sap_item_02', 'def_specimen_sap_item_02_dynamic_cprg', 'def_specimen_sap_item_02_CT_capsule'),
('def_specimen_sap_item_03', 'def_specimen_sap_item_03_dynamic_cprg', 'def_specimen_sap_item_03_CT_capsule'),
('def_specimen_sap_item_04', 'def_specimen_sap_item_04_dynamic_cprg', 'def_specimen_sap_item_04_CT_capsule'),
('def_specimen_sap_item_05', 'def_specimen_sap_item_05_dynamic_cprg', 'def_specimen_sap_item_05_CT_capsule'),
('def_specimen_sap_item_06', 'def_specimen_sap_item_06_dynamic_cprg', 'def_specimen_sap_item_06_CT_capsule');


INSERT INTO #MATERIAL_TABLE (itemName, mat01, mat02, mat03, mat04, mat05, mat06, mat07, mat08, mat09, mat10, mat11) VALUES
('def_specimen_sap_item_01', 'def_titan', 'def_crude', 'def_liquizit', 'def_titan_rare_small', 'def_crude_rare_small', 'def_stermonit_rare_small', 'def_imentium_rare_small', 'def_silgium_rare_small', 'def_helioptris_rare_small', 'def_triandlus_rare_small', 'def_prismocitae_rare_small'),
('def_specimen_sap_item_02', 'def_silgium', 'def_stermonit', 'def_imentium', 'def_titan_rare_medium', 'def_crude_rare_medium', 'def_stermonit_rare_medium', 'def_imentium_rare_medium', 'def_silgium_rare_medium', 'def_helioptris_rare_medium', 'def_triandlus_rare_medium', 'def_prismocitae_rare_medium'),
('def_specimen_sap_item_03', 'def_helioptris', 'def_triandlus', 'def_prismocitae', 'def_titan_rare_large', 'def_crude_rare_large', 'def_stermonit_rare_large', 'def_imentium_rare_large', 'def_silgium_rare_large', 'def_helioptris_rare_large', 'def_triandlus_rare_large', 'def_prismocitae_rare_large'),
('def_specimen_sap_item_04', 'def_silgium', 'def_triandlus', 'def_prismocitae', 'def_titan_rare_small', 'def_crude_rare_small', 'def_stermonit_rare_small', 'def_imentium_rare_small', 'def_silgium_rare_small', 'def_helioptris_rare_small', 'def_triandlus_rare_small', 'def_prismocitae_rare_small'),
('def_specimen_sap_item_05', 'def_stermonit', 'def_helioptris', 'def_prismocitae', 'def_titan_rare_medium', 'def_crude_rare_medium', 'def_stermonit_rare_medium', 'def_imentium_rare_medium', 'def_silgium_rare_medium', 'def_helioptris_rare_medium', 'def_triandlus_rare_medium', 'def_prismocitae_rare_medium'),
('def_specimen_sap_item_06', 'def_imentium', 'def_helioptris', 'def_triandlus', 'def_titan_rare_large', 'def_crude_rare_large', 'def_stermonit_rare_large', 'def_imentium_rare_large', 'def_silgium_rare_large', 'def_helioptris_rare_large', 'def_triandlus_rare_large', 'def_prismocitae_rare_large');

INSERT INTO #AMOUNTS_TABLE (matName, matAmount) VALUES
('def_titan', 100000),
('def_crude', 500000),
('def_liquizit', 250000),
('def_silgium', 200000),
('def_stermonit', 200000),
('def_imentium', 200000),
('def_helioptris', 200000),
('def_triandlus', 200000),
('def_prismocitae', 200000),
('def_titan_rare_small', 100),
('def_titan_rare_medium', 50),
('def_titan_rare_large', 25),
('def_crude_rare_small', 200),
('def_crude_rare_medium', 100),
('def_crude_rare_large', 50),
('def_liquizit_rare_small', 200),
('def_liquizit_rare_medium', 100),
('def_liquizit_rare_large', 50),
('def_stermonit_rare_small', 100),
('def_stermonit_rare_medium', 50),
('def_stermonit_rare_large', 25),
('def_imentium_rare_small', 100),
('def_imentium_rare_medium', 50),
('def_imentium_rare_large', 25),
('def_silgium_rare_small', 100),
('def_silgium_rare_medium', 50),
('def_silgium_rare_large', 25),
('def_helioptris_rare_small', 100),
('def_helioptris_rare_medium', 50),
('def_helioptris_rare_large', 25),
('def_triandlus_rare_small', 100),
('def_triandlus_rare_medium', 50),
('def_triandlus_rare_large', 25),
('def_prismocitae_rare_small', 100),
('def_prismocitae_rare_medium', 50),
('def_prismocitae_rare_large', 25);


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
			(@ctDef,5,5,@itemDef);
	END
	ELSE
	BEGIN
		--maybe we try different efficiencies
		UPDATE [dbo].[dynamiccalibrationtemplates] SET
			materialefficiency=5,
			timeefficiency=5
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
	(@itemDef, 1, 4);



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
	(SELECT TOP 1 matAmount from #AMOUNTS_TABLE join #MATERIAL_TABLE on mat04=matName)),
	(@itemDef,
	(SELECT TOP 1 definition from entitydefaults join #MATERIAL_TABLE on mat05=definitionname WHERE #MATERIAL_TABLE.itemName=@itemName),
	(SELECT TOP 1 matAmount from #AMOUNTS_TABLE join #MATERIAL_TABLE on mat05=matName)),
	(@itemDef,
	(SELECT TOP 1 definition from entitydefaults join #MATERIAL_TABLE on mat06=definitionname WHERE #MATERIAL_TABLE.itemName=@itemName),
	(SELECT TOP 1 matAmount from #AMOUNTS_TABLE join #MATERIAL_TABLE on mat06=matName)),
	(@itemDef,
	(SELECT TOP 1 definition from entitydefaults join #MATERIAL_TABLE on mat07=definitionname WHERE #MATERIAL_TABLE.itemName=@itemName),
	(SELECT TOP 1 matAmount from #AMOUNTS_TABLE join #MATERIAL_TABLE on mat07=matName)),
	(@itemDef,
	(SELECT TOP 1 definition from entitydefaults join #MATERIAL_TABLE on mat08=definitionname WHERE #MATERIAL_TABLE.itemName=@itemName),
	(SELECT TOP 1 matAmount from #AMOUNTS_TABLE join #MATERIAL_TABLE on mat08=matName)),
	(@itemDef,
	(SELECT TOP 1 definition from entitydefaults join #MATERIAL_TABLE on mat09=definitionname WHERE #MATERIAL_TABLE.itemName=@itemName),
	(SELECT TOP 1 matAmount from #AMOUNTS_TABLE join #MATERIAL_TABLE on mat09=matName)),
	(@itemDef,
	(SELECT TOP 1 definition from entitydefaults join #MATERIAL_TABLE on mat10=definitionname WHERE #MATERIAL_TABLE.itemName=@itemName),
	(SELECT TOP 1 matAmount from #AMOUNTS_TABLE join #MATERIAL_TABLE on mat10=matName)),
	(@itemDef,
	(SELECT TOP 1 definition from entitydefaults join #MATERIAL_TABLE on mat11=definitionname WHERE #MATERIAL_TABLE.itemName=@itemName),
	(SELECT TOP 1 matAmount from #AMOUNTS_TABLE join #MATERIAL_TABLE on mat11=matName));

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
		(@categoryOfItem,0.5);
	PRINT N'INSERTED production duration for this category';
END
ELSE
BEGIN
	UPDATE [productionduration]
	SET
		durationmodifier = 0.005
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
