USE [perpetuumsa]
GO


-- PATCH 29

PRINT N'Script 00_staging_table_for_pbs_hitboxes.sql';

DROP TABLE IF EXISTS [environmentdescriptionstaging];
CREATE TABLE [environmentdescriptionstaging](
	[definition] [int] NOT NULL,
	[descriptionstring] [varchar](max) NOT NULL,
 CONSTRAINT [IX_environmentdescriptionstaging] UNIQUE NONCLUSTERED 
(
	[definition] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[environmentdescriptionstaging]  WITH CHECK ADD  CONSTRAINT [FK_environmentdescriptionstaging_entitydefaults] FOREIGN KEY([definition])
REFERENCES [dbo].[entitydefaults] ([definition])
GO

ALTER TABLE [dbo].[environmentdescriptionstaging] CHECK CONSTRAINT [FK_environmentdescriptionstaging_entitydefaults]
GO

INSERT INTO environmentdescriptionstaging (definition, descriptionstring) VALUES
--------- Mining outpost ---------
--------- T1 ---------
(4689, '#blocks=[|t0=[|x=i-1|y=i-3|data=i3]|t1=[|x=i0|y=i-3|data=i3]|t2=[|x=i1|y=i-3|data=i3]|t3=[|x=i-2|y=i-2|data=i4]|t4=[|x=i-1|y=i-2|data=i4]|t5=[|x=i0|y=i-2|data=i4]|t6=[|x=i1|y=i-2|data=i4]|t7=[|x=i2|y=i-2|data=i4]|t8=[|x=i-3|y=i-1|data=i3]|t9=[|x=i-2|y=i-1|data=i4]|t10=[|x=i-1|y=i-1|data=i5]|t11=[|x=i0|y=i-1|data=i5]|t12=[|x=i1|y=i-1|data=i5]|t13=[|x=i2|y=i-1|data=i4]|t14=[|x=i3|y=i-1|data=i3]|t15=[|x=i-3|y=i0|data=i3]|t16=[|x=i-2|y=i0|data=i4]|t17=[|x=i-1|y=i0|data=i5]|t18=[|x=i0|y=i0|data=i3b]|t19=[|x=i1|y=i0|data=i5]|t20=[|x=i2|y=i0|data=i4]|t21=[|x=i3|y=i0|data=i3]|t22=[|x=i-3|y=i1|data=i3]|t23=[|x=i-2|y=i1|data=i4]|t24=[|x=i-1|y=i1|data=i5]|t25=[|x=i0|y=i1|data=i5]|t26=[|x=i1|y=i1|data=i5]|t27=[|x=i2|y=i1|data=i4]|t28=[|x=i3|y=i1|data=i3]|t29=[|x=i-2|y=i2|data=i4]|t30=[|x=i-1|y=i2|data=i4]|t31=[|x=i0|y=i2|data=i4]|t32=[|x=i1|y=i2|data=i4]|t33=[|x=i2|y=i2|data=i4]|t34=[|x=i-1|y=i3|data=i3]|t35=[|x=i0|y=i3|data=i3]|t36=[|x=i1|y=i3|data=i3]]'),
--------- T2 ---------
(4737, '#blocks=[|t0=[|x=i-1|y=i-3|data=i3]|t1=[|x=i0|y=i-3|data=i3]|t2=[|x=i1|y=i-3|data=i3]|t3=[|x=i-2|y=i-2|data=i4]|t4=[|x=i-1|y=i-2|data=i4]|t5=[|x=i0|y=i-2|data=i4]|t6=[|x=i1|y=i-2|data=i4]|t7=[|x=i2|y=i-2|data=i4]|t8=[|x=i-3|y=i-1|data=i3]|t9=[|x=i-2|y=i-1|data=i4]|t10=[|x=i-1|y=i-1|data=i5]|t11=[|x=i0|y=i-1|data=i5]|t12=[|x=i1|y=i-1|data=i5]|t13=[|x=i2|y=i-1|data=i4]|t14=[|x=i3|y=i-1|data=i3]|t15=[|x=i-3|y=i0|data=i3]|t16=[|x=i-2|y=i0|data=i4]|t17=[|x=i-1|y=i0|data=i5]|t18=[|x=i0|y=i0|data=i3b]|t19=[|x=i1|y=i0|data=i5]|t20=[|x=i2|y=i0|data=i4]|t21=[|x=i3|y=i0|data=i3]|t22=[|x=i-3|y=i1|data=i3]|t23=[|x=i-2|y=i1|data=i4]|t24=[|x=i-1|y=i1|data=i5]|t25=[|x=i0|y=i1|data=i5]|t26=[|x=i1|y=i1|data=i5]|t27=[|x=i2|y=i1|data=i4]|t28=[|x=i3|y=i1|data=i3]|t29=[|x=i-2|y=i2|data=i4]|t30=[|x=i-1|y=i2|data=i4]|t31=[|x=i0|y=i2|data=i4]|t32=[|x=i1|y=i2|data=i4]|t33=[|x=i2|y=i2|data=i4]|t34=[|x=i-1|y=i3|data=i3]|t35=[|x=i0|y=i3|data=i3]|t36=[|x=i1|y=i3|data=i3]]'),
--------- T3 ---------
(4740, '#blocks=[|t0=[|x=i-1|y=i-3|data=i3]|t1=[|x=i0|y=i-3|data=i3]|t2=[|x=i1|y=i-3|data=i3]|t3=[|x=i-2|y=i-2|data=i4]|t4=[|x=i-1|y=i-2|data=i4]|t5=[|x=i0|y=i-2|data=i4]|t6=[|x=i1|y=i-2|data=i4]|t7=[|x=i2|y=i-2|data=i4]|t8=[|x=i-3|y=i-1|data=i3]|t9=[|x=i-2|y=i-1|data=i4]|t10=[|x=i-1|y=i-1|data=i5]|t11=[|x=i0|y=i-1|data=i5]|t12=[|x=i1|y=i-1|data=i5]|t13=[|x=i2|y=i-1|data=i4]|t14=[|x=i3|y=i-1|data=i3]|t15=[|x=i-3|y=i0|data=i3]|t16=[|x=i-2|y=i0|data=i4]|t17=[|x=i-1|y=i0|data=i5]|t18=[|x=i0|y=i0|data=i3b]|t19=[|x=i1|y=i0|data=i5]|t20=[|x=i2|y=i0|data=i4]|t21=[|x=i3|y=i0|data=i3]|t22=[|x=i-3|y=i1|data=i3]|t23=[|x=i-2|y=i1|data=i4]|t24=[|x=i-1|y=i1|data=i5]|t25=[|x=i0|y=i1|data=i5]|t26=[|x=i1|y=i1|data=i5]|t27=[|x=i2|y=i1|data=i4]|t28=[|x=i3|y=i1|data=i3]|t29=[|x=i-2|y=i2|data=i4]|t30=[|x=i-1|y=i2|data=i4]|t31=[|x=i0|y=i2|data=i4]|t32=[|x=i1|y=i2|data=i4]|t33=[|x=i2|y=i2|data=i4]|t34=[|x=i-1|y=i3|data=i3]|t35=[|x=i0|y=i3|data=i3]|t36=[|x=i1|y=i3|data=i3]]'),

--------- Command relay ---------
--------- T1 ---------
(4702, '#blocks=[|t0=[|x=i-1|y=i-1|data=i5]t1=[|x=i0|y=i-1|data=i5]t2=[|x=i1|y=i-1|data=i5]|t3=[|x=i-1|y=i0|data=i5]t4=[|x=i0|y=i0|data=i17]t5=[|x=i1|y=i0|data=i5]|t6=[|x=i-1|y=i1|data=i5]t7=[|x=i0|y=i1|data=i8]t5=[|x=i1|y=i1|data=i5]]'),
--------- T2 ---------
(4743, '#blocks=[|t0=[|x=i-1|y=i-1|data=i5]t1=[|x=i0|y=i-1|data=i5]t2=[|x=i1|y=i-1|data=i5]|t3=[|x=i-1|y=i0|data=i5]t4=[|x=i0|y=i0|data=i17]t5=[|x=i1|y=i0|data=i5]|t6=[|x=i-1|y=i1|data=i5]t7=[|x=i0|y=i1|data=i8]t5=[|x=i1|y=i1|data=i5]]'),
--------- T3 ---------
(4746, '#blocks=[|t0=[|x=i-1|y=i-1|data=i5]t1=[|x=i0|y=i-1|data=i5]t2=[|x=i1|y=i-1|data=i5]|t3=[|x=i-1|y=i0|data=i5]t4=[|x=i0|y=i0|data=i17]t5=[|x=i1|y=i0|data=i5]|t6=[|x=i-1|y=i1|data=i5]t7=[|x=i0|y=i1|data=i8]t5=[|x=i1|y=i1|data=i5]]'),

--------- Repair node ---------
--------- T1 ---------
(4692, '#blocks=[|t0=[|x=i-1|y=i-1|data=i2]|t1=[|x=i0|y=i-1|data=i2]|t2=[|x=i1|y=i-1|data=i2]|t3=[|x=i-1|y=i0|data=i2]|t4=[|x=i0|y=i0|data=ib]|t5=[|x=i1|y=i0|data=i2]|t6=[|x=i-1|y=i1|data=i2]|t7=[|x=i0|y=i1|data=i2]|t8=[|x=i1|y=i1|data=i2]]'),
--------- T2 ---------
(4720, '#blocks=[|t0=[|x=i-1|y=i-1|data=i2]|t1=[|x=i0|y=i-1|data=i2]|t2=[|x=i1|y=i-1|data=i2]|t3=[|x=i-1|y=i0|data=i2]|t4=[|x=i0|y=i0|data=ib]|t5=[|x=i1|y=i0|data=i2]|t6=[|x=i-1|y=i1|data=i2]|t7=[|x=i0|y=i1|data=i2]|t8=[|x=i1|y=i1|data=i2]]'),
--------- T3 ---------
(4723, '#blocks=[|t0=[|x=i-1|y=i-1|data=i2]|t1=[|x=i0|y=i-1|data=i2]|t2=[|x=i1|y=i-1|data=i2]|t3=[|x=i-1|y=i0|data=i2]|t4=[|x=i0|y=i0|data=ib]|t5=[|x=i1|y=i0|data=i2]|t6=[|x=i-1|y=i1|data=i2]|t7=[|x=i0|y=i1|data=i2]|t8=[|x=i1|y=i1|data=i2]]'),

--------- Energy well ---------
--------- T1 ---------
(5349, '#blocks=[|t0=[|x=i-1|y=i-3|data=i1]|t1=[|x=i0|y=i-3|data=i1]|t2=[|x=i1|y=i-3|data=i1]|t3=[|x=i2|y=i-3|data=i1]|t7=[|x=i-2|y=i-2|data=i1]|t8=[|x=i-1|y=i-2|data=i1]|t9=[|x=i0|y=i-2|data=i1]|t10=[|x=i1|y=i-2|data=i1]|t11=[|x=i2|y=i-2|data=i1]|t12=[|x=i3|y=i-2|data=i1]|t13=[|x=i-3|y=i-1|data=i1]|t14=[|x=i-2|y=i-1|data=i1]|t15=[|x=i-1|y=i-1|data=i2]|t16=[|x=i0|y=i-1|data=i2]|t17=[|x=i1|y=i-1|data=i2]|t18=[|x=i3|y=i-1|data=i1]|t19=[|x=i2|y=i-1|data=i1]|t20=[|x=i-3|y=i0|data=i1]|t21=[|x=i-2|y=i0|data=i1]|t22=[|x=i-1|y=i0|data=i2]|t23=[|x=i0|y=i0|data=i3b]|t24=[|x=i1|y=i0|data=i2]|t25=[|x=i2|y=i0|data=i1]|t26=[|x=i3|y=i0|data=i1]|t27=[|x=i-3|y=i1|data=i1]|t28=[|x=i-2|y=i1|data=i1]|t29=[|x=i-1|y=i1|data=i2]|t30=[|x=i0|y=i1|data=i2]|t31=[|x=i1|y=i1|data=i2]|t32=[|x=i2|y=i1|data=i1]|t33=[|x=i3|y=i1|data=i1]|t34=[|x=i-2|y=i2|data=i1]|t35=[|x=i-1|y=i2|data=i1]|t36=[|x=i0|y=i2|data=i1]|t37=[|x=i1|y=i2|data=i1]|t38=[|x=i2|y=i2|data=i1]|t39=[|x=i-1|y=i3|data=i1]|t40=[|x=i0|y=i3|data=i1]|t41=[|x=i1|y=i3|data=i1]]'),
--------- T2 ---------
(5350, '#blocks=[|t0=[|x=i-1|y=i-3|data=i1]|t1=[|x=i0|y=i-3|data=i1]|t2=[|x=i1|y=i-3|data=i1]|t3=[|x=i2|y=i-3|data=i1]|t7=[|x=i-2|y=i-2|data=i1]|t8=[|x=i-1|y=i-2|data=i1]|t9=[|x=i0|y=i-2|data=i1]|t10=[|x=i1|y=i-2|data=i1]|t11=[|x=i2|y=i-2|data=i1]|t12=[|x=i3|y=i-2|data=i1]|t13=[|x=i-3|y=i-1|data=i1]|t14=[|x=i-2|y=i-1|data=i1]|t15=[|x=i-1|y=i-1|data=i2]|t16=[|x=i0|y=i-1|data=i2]|t17=[|x=i1|y=i-1|data=i2]|t18=[|x=i3|y=i-1|data=i1]|t19=[|x=i2|y=i-1|data=i1]|t20=[|x=i-3|y=i0|data=i1]|t21=[|x=i-2|y=i0|data=i1]|t22=[|x=i-1|y=i0|data=i2]|t23=[|x=i0|y=i0|data=i3b]|t24=[|x=i1|y=i0|data=i2]|t25=[|x=i2|y=i0|data=i1]|t26=[|x=i3|y=i0|data=i1]|t27=[|x=i-3|y=i1|data=i1]|t28=[|x=i-2|y=i1|data=i1]|t29=[|x=i-1|y=i1|data=i2]|t30=[|x=i0|y=i1|data=i2]|t31=[|x=i1|y=i1|data=i2]|t32=[|x=i2|y=i1|data=i1]|t33=[|x=i3|y=i1|data=i1]|t34=[|x=i-2|y=i2|data=i1]|t35=[|x=i-1|y=i2|data=i1]|t36=[|x=i0|y=i2|data=i1]|t37=[|x=i1|y=i2|data=i1]|t38=[|x=i2|y=i2|data=i1]|t39=[|x=i-1|y=i3|data=i1]|t40=[|x=i0|y=i3|data=i1]|t41=[|x=i1|y=i3|data=i1]]'),
--------- T3 ---------
(5351, '#blocks=[|t0=[|x=i-1|y=i-3|data=i1]|t1=[|x=i0|y=i-3|data=i1]|t2=[|x=i1|y=i-3|data=i1]|t3=[|x=i2|y=i-3|data=i1]|t7=[|x=i-2|y=i-2|data=i1]|t8=[|x=i-1|y=i-2|data=i1]|t9=[|x=i0|y=i-2|data=i1]|t10=[|x=i1|y=i-2|data=i1]|t11=[|x=i2|y=i-2|data=i1]|t12=[|x=i3|y=i-2|data=i1]|t13=[|x=i-3|y=i-1|data=i1]|t14=[|x=i-2|y=i-1|data=i1]|t15=[|x=i-1|y=i-1|data=i2]|t16=[|x=i0|y=i-1|data=i2]|t17=[|x=i1|y=i-1|data=i2]|t18=[|x=i3|y=i-1|data=i1]|t19=[|x=i2|y=i-1|data=i1]|t20=[|x=i-3|y=i0|data=i1]|t21=[|x=i-2|y=i0|data=i1]|t22=[|x=i-1|y=i0|data=i2]|t23=[|x=i0|y=i0|data=i3b]|t24=[|x=i1|y=i0|data=i2]|t25=[|x=i2|y=i0|data=i1]|t26=[|x=i3|y=i0|data=i1]|t27=[|x=i-3|y=i1|data=i1]|t28=[|x=i-2|y=i1|data=i1]|t29=[|x=i-1|y=i1|data=i2]|t30=[|x=i0|y=i1|data=i2]|t31=[|x=i1|y=i1|data=i2]|t32=[|x=i2|y=i1|data=i1]|t33=[|x=i3|y=i1|data=i1]|t34=[|x=i-2|y=i2|data=i1]|t35=[|x=i-1|y=i2|data=i1]|t36=[|x=i0|y=i2|data=i1]|t37=[|x=i1|y=i2|data=i1]|t38=[|x=i2|y=i2|data=i1]|t39=[|x=i-1|y=i3|data=i1]|t40=[|x=i0|y=i3|data=i1]|t41=[|x=i1|y=i3|data=i1]]')

GO

--------------------------------

PRINT N'Script 01_artifact_buff.sql';

----  Artifact Changes that add Light Combat and Light Ewar to Gamma Artifact table, and small buff to other CT drops 5-8%.

---Num_Science_Level_1

DECLARE @definitionID int;
DECLARE @artifactLootID int;
DECLARE @artifactTypeID int;
SET @artifactTypeID = (SELECT TOP 1 id from artifacttypes WHERE [name] = 'science_nuimqol_level1_gamma');
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_5');
SET @artifactLootID = (SELECT TOP 1 id FROM artifactloot WHERE definition = @definitionID  AND artifacttype = @artifactTypeID);

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_arbalest_mk2_A_CT_capsule');
SET @artifactLootID = (SELECT TOP 1 id FROM artifactloot WHERE definition = @definitionID  AND artifacttype = @artifactTypeID);
UPDATE artifactloot SET 
                [definition]=@definitionID,[artifacttype]=@artifactTypeID,[minquantity]=1,[maxquantity]=1,[chance]=0.08,[packed]=1 WHERE [id]=@artifactLootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_mk2_A_CT_capsule');
SET @artifactLootID = (SELECT TOP 1 id FROM artifactloot WHERE definition = @definitionID  AND artifacttype = @artifactTypeID);
UPDATE artifactloot SET 
                [definition]=@definitionID,[artifacttype]=@artifactTypeID,[minquantity]=1,[maxquantity]=1,[chance]=0.10,[packed]=1 WHERE [id]=@artifactLootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vagabond_mk2_A_CT_capsule');
SET @artifactLootID = (SELECT TOP 1 id FROM artifactloot WHERE definition = @definitionID  AND artifacttype = @artifactTypeID);
UPDATE artifactloot SET 
                [definition]=@definitionID,[artifacttype]=@artifactTypeID,[minquantity]=1,[maxquantity]=1,[chance]=0.08,[packed]=1 WHERE [id]=@artifactLootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_mk2_A_CT_capsule');
SET @artifactLootID = (SELECT TOP 1 id FROM artifactloot WHERE definition = @definitionID  AND artifacttype = @artifactTypeID);
UPDATE artifactloot SET 
                [definition]=@definitionID,[artifacttype]=@artifactTypeID,[minquantity]=1,[maxquantity]=1,[chance]=0.1,[packed]=1 WHERE [id]=@artifactLootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_mk2_A_CT_capsule');
INSERT INTO[dbo].[artifactloot] ([artifacttype],[definition],[minquantity],[maxquantity],[chance],[packed])
                VALUES (@artifactTypeID, @definitionID, 1, 1, 0.075, 1)

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_yagel_mk2_A_CT_capsule');
INSERT INTO[dbo].[artifactloot] ([artifacttype],[definition],[minquantity],[maxquantity],[chance],[packed])
                VALUES (@artifactTypeID, @definitionID, 1, 1, 0.05, 1)

---Num_Science_Level_2

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_arbalest_mk2_B_CT_capsule');
SET @artifactLootID = (SELECT TOP 1 id FROM artifactloot WHERE definition = @definitionID  AND artifacttype = @artifactTypeID);
UPDATE artifactloot SET 
                [definition]=@definitionID,[artifacttype]=@artifactTypeID,[minquantity]=1,[maxquantity]=1,[chance]=0.08,[packed]=1 WHERE [id]=@artifactLootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_mk2_B_CT_capsule');
SET @artifactLootID = (SELECT TOP 1 id FROM artifactloot WHERE definition = @definitionID  AND artifacttype = @artifactTypeID);
UPDATE artifactloot SET 
                [definition]=@definitionID,[artifacttype]=@artifactTypeID,[minquantity]=1,[maxquantity]=1,[chance]=0.10,[packed]=1 WHERE [id]=@artifactLootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vagabond_mk2_B_CT_capsule');
SET @artifactLootID = (SELECT TOP 1 id FROM artifactloot WHERE definition = @definitionID  AND artifacttype = @artifactTypeID);
UPDATE artifactloot SET 
                [definition]=@definitionID,[artifacttype]=@artifactTypeID,[minquantity]=1,[maxquantity]=1,[chance]=0.08,[packed]=1 WHERE [id]=@artifactLootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_mk2_B_CT_capsule');
SET @artifactLootID = (SELECT TOP 1 id FROM artifactloot WHERE definition = @definitionID  AND artifacttype = @artifactTypeID);
UPDATE artifactloot SET 
                [definition]=@definitionID,[artifacttype]=@artifactTypeID,[minquantity]=1,[maxquantity]=1,[chance]=0.1,[packed]=1 WHERE [id]=@artifactLootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_mk2_B_CT_capsule');
INSERT INTO[dbo].[artifactloot] ([artifacttype],[definition],[minquantity],[maxquantity],[chance],[packed])
                VALUES (@artifactTypeID, @definitionID, 1, 1, 0.0725, 1)

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_yagel_mk2_B_CT_capsule');
INSERT INTO[dbo].[artifactloot] ([artifacttype],[definition],[minquantity],[maxquantity],[chance],[packed])
                VALUES (@artifactTypeID, @definitionID, 1, 1, 0.05, 1)

---Num_Science_Level_3

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_arbalest_mk2_C_CT_capsule');
SET @artifactLootID = (SELECT TOP 1 id FROM artifactloot WHERE definition = @definitionID  AND artifacttype = @artifactTypeID);
UPDATE artifactloot SET 
                [definition]=@definitionID,[artifacttype]=@artifactTypeID,[minquantity]=1,[maxquantity]=1,[chance]=0.08,[packed]=1 WHERE [id]=@artifactLootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kain_mk2_C_CT_capsule');
SET @artifactLootID = (SELECT TOP 1 id FROM artifactloot WHERE definition = @definitionID  AND artifacttype = @artifactTypeID);
UPDATE artifactloot SET 
                [definition]=@definitionID,[artifacttype]=@artifactTypeID,[minquantity]=1,[maxquantity]=1,[chance]=0.10,[packed]=1 WHERE [id]=@artifactLootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vagabond_mk2_C_CT_capsule');
SET @artifactLootID = (SELECT TOP 1 id FROM artifactloot WHERE definition = @definitionID  AND artifacttype = @artifactTypeID);
UPDATE artifactloot SET 
                [definition]=@definitionID,[artifacttype]=@artifactTypeID,[minquantity]=1,[maxquantity]=1,[chance]=0.08,[packed]=1 WHERE [id]=@artifactLootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_mesmer_mk2_C_CT_capsule');
SET @artifactLootID = (SELECT TOP 1 id FROM artifactloot WHERE definition = @definitionID  AND artifacttype = @artifactTypeID);
UPDATE artifactloot SET 
                [definition]=@definitionID,[artifacttype]=@artifactTypeID,[minquantity]=1,[maxquantity]=1,[chance]=0.10,[packed]=1 WHERE [id]=@artifactLootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_yagel_mk2_C_CT_capsule');
INSERT INTO[dbo].[artifactloot] ([artifacttype],[definition],[minquantity],[maxquantity],[chance],[packed])
                VALUES (@artifactTypeID, @definitionID, 0, 1, 0.05, 1)

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_cameleon_mk2_C_CT_capsule');
INSERT INTO[dbo].[artifactloot] ([artifacttype],[definition],[minquantity],[maxquantity],[chance],[packed])
                VALUES (@artifactTypeID, @definitionID, 0, 1, 0.075, 1)

---Pelistal_Science_Level_1

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_waspish_mk2_A_CT_capsule');
SET @artifactLootID = (SELECT TOP 1 id FROM artifactloot WHERE definition = @definitionID  AND artifacttype = @artifactTypeID);
UPDATE artifactloot SET 
                [definition]=@definitionID,[artifacttype]=@artifactTypeID,[minquantity]=1,[maxquantity]=1,[chance]=0.08,[packed]=1 WHERE [id]=@artifactLootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_tyrannos_mk2_A_CT_capsule');
SET @artifactLootID = (SELECT TOP 1 id FROM artifactloot WHERE definition = @definitionID  AND artifacttype = @artifactTypeID);
UPDATE artifactloot SET 
                [definition]=@definitionID,[artifacttype]=@artifactTypeID,[minquantity]=1,[maxquantity]=1,[chance]=0.10,[packed]=1 WHERE [id]=@artifactLootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ictus_mk2_A_CT_capsule');
SET @artifactLootID = (SELECT TOP 1 id FROM artifactloot WHERE definition = @definitionID  AND artifacttype = @artifactTypeID);
UPDATE artifactloot SET 
                [definition]=@definitionID,[artifacttype]=@artifactTypeID,[minquantity]=1,[maxquantity]=1,[chance]=0.08,[packed]=1 WHERE [id]=@artifactLootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_gropho_mk2_A_CT_capsule');
SET @artifactLootID = (SELECT TOP 1 id FROM artifactloot WHERE definition = @definitionID  AND artifacttype = @artifactTypeID);
UPDATE artifactloot SET 
                [definition]=@definitionID,[artifacttype]=@artifactTypeID,[minquantity]=1,[maxquantity]=1,[chance]=0.1,[packed]=1 WHERE [id]=@artifactLootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_troiar_mk2_A_CT_capsule');
INSERT INTO[dbo].[artifactloot] ([artifacttype],[definition],[minquantity],[maxquantity],[chance],[packed])
                VALUES (@artifactTypeID, @definitionID, 1, 1, 0.075, 1)

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_castel_mk2_A_CT_capsule');
INSERT INTO[dbo].[artifactloot] ([artifacttype],[definition],[minquantity],[maxquantity],[chance],[packed])
                VALUES (@artifactTypeID, @definitionID, 1, 1, 0.05, 1)

---Pelistal_Science_Level_2

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_waspish_mk2_B_CT_capsule');
SET @artifactLootID = (SELECT TOP 1 id FROM artifactloot WHERE definition = @definitionID  AND artifacttype = @artifactTypeID);
UPDATE artifactloot SET 
                [definition]=@definitionID,[artifacttype]=@artifactTypeID,[minquantity]=1,[maxquantity]=1,[chance]=0.08,[packed]=1 WHERE [id]=@artifactLootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_tyrannos_mk2_B_CT_capsule');
SET @artifactLootID = (SELECT TOP 1 id FROM artifactloot WHERE definition = @definitionID  AND artifacttype = @artifactTypeID);
UPDATE artifactloot SET 
                [definition]=@definitionID,[artifacttype]=@artifactTypeID,[minquantity]=1,[maxquantity]=1,[chance]=0.10,[packed]=1 WHERE [id]=@artifactLootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ictus_mk2_B_CT_capsule');
SET @artifactLootID = (SELECT TOP 1 id FROM artifactloot WHERE definition = @definitionID  AND artifacttype = @artifactTypeID);
UPDATE artifactloot SET 
                [definition]=@definitionID,[artifacttype]=@artifactTypeID,[minquantity]=1,[maxquantity]=1,[chance]=0.08,[packed]=1 WHERE [id]=@artifactLootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_gropho_mk2_B_CT_capsule');
SET @artifactLootID = (SELECT TOP 1 id FROM artifactloot WHERE definition = @definitionID  AND artifacttype = @artifactTypeID);
UPDATE artifactloot SET 
                [definition]=@definitionID,[artifacttype]=@artifactTypeID,[minquantity]=1,[maxquantity]=1,[chance]=0.1,[packed]=1 WHERE [id]=@artifactLootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_troiar_mk2_B_CT_capsule');
INSERT INTO[dbo].[artifactloot] ([artifacttype],[definition],[minquantity],[maxquantity],[chance],[packed])
                VALUES (@artifactTypeID, @definitionID, 1, 1, 0.075, 1)

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_castel_mk2_B_CT_capsule');
INSERT INTO[dbo].[artifactloot] ([artifacttype],[definition],[minquantity],[maxquantity],[chance],[packed])
                VALUES (@artifactTypeID, @definitionID, 1, 1, 0.05, 1)

---Pelistal_Science_Level_3

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_waspish_mk2_C_CT_capsule');
SET @artifactLootID = (SELECT TOP 1 id FROM artifactloot WHERE definition = @definitionID  AND artifacttype = @artifactTypeID);
UPDATE artifactloot SET 
                [definition]=@definitionID,[artifacttype]=@artifactTypeID,[minquantity]=1,[maxquantity]=1,[chance]=0.08,[packed]=1 WHERE [id]=@artifactLootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_tyrannos_mk2_C_CT_capsule');
SET @artifactLootID = (SELECT TOP 1 id FROM artifactloot WHERE definition = @definitionID  AND artifacttype = @artifactTypeID);
UPDATE artifactloot SET 
                [definition]=@definitionID,[artifacttype]=@artifactTypeID,[minquantity]=1,[maxquantity]=1,[chance]=0.10,[packed]=1 WHERE [id]=@artifactLootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ictus_mk2_C_CT_capsule');
SET @artifactLootID = (SELECT TOP 1 id FROM artifactloot WHERE definition = @definitionID  AND artifacttype = @artifactTypeID);
UPDATE artifactloot SET 
                [definition]=@definitionID,[artifacttype]=@artifactTypeID,[minquantity]=1,[maxquantity]=1,[chance]=0.08,[packed]=1 WHERE [id]=@artifactLootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_gropho_mk2_C_CT_capsule');
SET @artifactLootID = (SELECT TOP 1 id FROM artifactloot WHERE definition = @definitionID  AND artifacttype = @artifactTypeID);
UPDATE artifactloot SET 
                [definition]=@definitionID,[artifacttype]=@artifactTypeID,[minquantity]=1,[maxquantity]=1,[chance]=0.1,[packed]=1 WHERE [id]=@artifactLootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_troiar_mk2_C_CT_capsule');
INSERT INTO[dbo].[artifactloot] ([artifacttype],[definition],[minquantity],[maxquantity],[chance],[packed])
                VALUES (@artifactTypeID, @definitionID, 1, 1, 0.075, 1)

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_castel_mk2_C_CT_capsule');
INSERT INTO[dbo].[artifactloot] ([artifacttype],[definition],[minquantity],[maxquantity],[chance],[packed])
                VALUES (@artifactTypeID, @definitionID, 1, 1, 0.05, 1)

---Theo_Science_Level_1

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_baphomet_mk2_A_CT_capsule');
SET @artifactLootID = (SELECT TOP 1 id FROM artifactloot WHERE definition = @definitionID  AND artifacttype = @artifactTypeID);
UPDATE artifactloot SET 
                [definition]=@definitionID,[artifacttype]=@artifactTypeID,[minquantity]=1,[maxquantity]=1,[chance]=0.08,[packed]=1 WHERE [id]=@artifactLootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_mk2_A_CT_capsule');
SET @artifactLootID = (SELECT TOP 1 id FROM artifactloot WHERE definition = @definitionID  AND artifacttype = @artifactTypeID);
UPDATE artifactloot SET 
                [definition]=@definitionID,[artifacttype]=@artifactTypeID,[minquantity]=1,[maxquantity]=1,[chance]=0.10,[packed]=1 WHERE [id]=@artifactLootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_zenith_mk2_A_CT_capsule');
SET @artifactLootID = (SELECT TOP 1 id FROM artifactloot WHERE definition = @definitionID  AND artifacttype = @artifactTypeID);
UPDATE artifactloot SET 
                [definition]=@definitionID,[artifacttype]=@artifactTypeID,[minquantity]=1,[maxquantity]=1,[chance]=0.08,[packed]=1 WHERE [id]=@artifactLootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_seth_mk2_A_CT_capsule');
SET @artifactLootID = (SELECT TOP 1 id FROM artifactloot WHERE definition = @definitionID  AND artifacttype = @artifactTypeID);
UPDATE artifactloot SET 
                [definition]=@definitionID,[artifacttype]=@artifactTypeID,[minquantity]=1,[maxquantity]=1,[chance]=0.1,[packed]=1 WHERE [id]=@artifactLootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_mk2_A_CT_capsule');
INSERT INTO[dbo].[artifactloot] ([artifacttype],[definition],[minquantity],[maxquantity],[chance],[packed])
                VALUES (@artifactTypeID, @definitionID, 1, 1, 0.05, 1)

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_mk2_A_CT_capsule');
INSERT INTO[dbo].[artifactloot] ([artifacttype],[definition],[minquantity],[maxquantity],[chance],[packed])
                VALUES (@artifactTypeID, @definitionID, 1, 1, 0.075, 1)

---Theo_Science_Level_2

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_baphomet_mk2_B_CT_capsule');
SET @artifactLootID = (SELECT TOP 1 id FROM artifactloot WHERE definition = @definitionID  AND artifacttype = @artifactTypeID);
UPDATE artifactloot SET 
                [definition]=@definitionID,[artifacttype]=@artifactTypeID,[minquantity]=1,[maxquantity]=1,[chance]=0.08,[packed]=1 WHERE [id]=@artifactLootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_mk2_B_CT_capsule');
SET @artifactLootID = (SELECT TOP 1 id FROM artifactloot WHERE definition = @definitionID  AND artifacttype = @artifactTypeID);
UPDATE artifactloot SET 
                [definition]=@definitionID,[artifacttype]=@artifactTypeID,[minquantity]=1,[maxquantity]=1,[chance]=0.10,[packed]=1 WHERE [id]=@artifactLootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_zenith_mk2_B_CT_capsule');
SET @artifactLootID = (SELECT TOP 1 id FROM artifactloot WHERE definition = @definitionID  AND artifacttype = @artifactTypeID);
UPDATE artifactloot SET 
                [definition]=@definitionID,[artifacttype]=@artifactTypeID,[minquantity]=1,[maxquantity]=1,[chance]=0.08,[packed]=1 WHERE [id]=@artifactLootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_seth_mk2_B_CT_capsule');
SET @artifactLootID = (SELECT TOP 1 id FROM artifactloot WHERE definition = @definitionID  AND artifacttype = @artifactTypeID);
UPDATE artifactloot SET 
                [definition]=@definitionID,[artifacttype]=@artifactTypeID,[minquantity]=1,[maxquantity]=1,[chance]=0.1,[packed]=1 WHERE [id]=@artifactLootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_mk2_B_CT_capsule');
INSERT INTO[dbo].[artifactloot] ([artifacttype],[definition],[minquantity],[maxquantity],[chance],[packed])
                VALUES (@artifactTypeID, @definitionID, 0, 1, 0.075, 1)

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_mk2_B_CT_capsule');
INSERT INTO[dbo].[artifactloot] ([artifacttype],[definition],[minquantity],[maxquantity],[chance],[packed])
                VALUES (@artifactTypeID, @definitionID, 0, 1, 0.05, 1)

---Theo_Science_Level_3

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_baphomet_mk2_C_CT_capsule');
SET @artifactLootID = (SELECT TOP 1 id FROM artifactloot WHERE definition = @definitionID  AND artifacttype = @artifactTypeID);
UPDATE artifactloot SET 
                [definition]=@definitionID,[artifacttype]=@artifactTypeID,[minquantity]=1,[maxquantity]=1,[chance]=0.08,[packed]=1 WHERE [id]=@artifactLootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artemis_mk2_C_CT_capsule');
SET @artifactLootID = (SELECT TOP 1 id FROM artifactloot WHERE definition = @definitionID  AND artifacttype = @artifactTypeID);
UPDATE artifactloot SET 
                [definition]=@definitionID,[artifacttype]=@artifactTypeID,[minquantity]=1,[maxquantity]=1,[chance]=0.10,[packed]=1 WHERE [id]=@artifactLootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_zenith_mk2_C_CT_capsule');
SET @artifactLootID = (SELECT TOP 1 id FROM artifactloot WHERE definition = @definitionID  AND artifacttype = @artifactTypeID);
UPDATE artifactloot SET 
                [definition]=@definitionID,[artifacttype]=@artifactTypeID,[minquantity]=1,[maxquantity]=1,[chance]=0.08,[packed]=1 WHERE [id]=@artifactLootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_seth_mk2_C_CT_capsule');
SET @artifactLootID = (SELECT TOP 1 id FROM artifactloot WHERE definition = @definitionID  AND artifacttype = @artifactTypeID);
UPDATE artifactloot SET 
                [definition]=@definitionID,[artifacttype]=@artifactTypeID,[minquantity]=1,[maxquantity]=1,[chance]=0.1,[packed]=1 WHERE [id]=@artifactLootID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_prometheus_mk2_C_CT_capsule');
INSERT INTO[dbo].[artifactloot] ([artifacttype],[definition],[minquantity],[maxquantity],[chance],[packed])
                VALUES (@artifactTypeID, @definitionID, 1, 1, 0.05, 1)

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_intakt_mk2_C_CT_capsule');
INSERT INTO[dbo].[artifactloot] ([artifacttype],[definition],[minquantity],[maxquantity],[chance],[packed])
                VALUES (@artifactTypeID, @definitionID, 1, 1, 0.075, 1)

GO

--------------------------------------

PRINT N'Script 02_scarab_buff.sql';

----Scarab_Speed_Increase

--Scarab_Mk1
DECLARE @definitionID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_scarab_leg' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_scarab_leg', quantity=1, attributeflags=1024, categoryflags=262992, options='#height=f1.5#slotFlags=420,20,20', 
                note='', enabled=1, volume=35, mass=5000, hidden=1, health=100, descriptiontoken='def_scarab_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.19 WHERE id =  @aggvalueID;

--Scarab_MK1_PR

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_scarab_leg_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_scarab_leg_pr', quantity=1, attributeflags=1024, categoryflags=262992, options='#height=f1.5#slotFlags=420,20,20', 
                note='', enabled=1, volume=35, mass=5000, hidden=1, health=100, descriptiontoken='def_scarab_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.19 WHERE id =  @aggvalueID;

--Scarab_Mk2

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_scarab_leg_mk2' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_scarab_leg_mk2', quantity=1, attributeflags=1024, categoryflags=262992, options='#height=f1.5#slotFlags=420,20,20', 
                note='', enabled=1, volume=35, mass=6000, hidden=1, health=100, descriptiontoken='def_scarab_leg_mk2_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.19 WHERE id =  @aggvalueID;


---Scarab_MK1_AP_and_Reactor_increase

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_scarab_chassis' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_scarab_chassis', quantity=1, attributeflags=1024, categoryflags=262736, options='#height=f2#slotFlags=46d3,6d3', 
                note='', enabled=1, volume=175, mass=45000, hidden=1, health=100, descriptiontoken='def_scarab_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2800 WHERE id =  @aggvalueID;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_scarab_chassis' ORDER BY definition DESC);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=750 WHERE id =  @aggvalueID;

---Scarab_MK1_PR

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_scarab_chassis_pr' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_scarab_chassis_pr', quantity=1, attributeflags=1024, categoryflags=262736, options='#height=f2#slotFlags=46d3,6d3', 
                note='', enabled=1, volume=175, mass=45000, hidden=1, health=100, descriptiontoken='def_scarab_chassis_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2800 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=750 WHERE id =  @aggvalueID;

---Scarab_MK2

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_scarab_chassis_mk2' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_scarab_chassis_mk2', quantity=1, attributeflags=1024, categoryflags=262736, options='#height=f2#slotFlags=46d3,6d3', 
                note='', enabled=1, volume=175, mass=54000, hidden=1, health=100, descriptiontoken='def_scarab_chassis_mk2_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2800 WHERE id =  @aggvalueID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=810 WHERE id =  @aggvalueID;

---Add_Mk2_Head_slot_Scarab

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_scarab_head_mk2' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_scarab_head_mk2', quantity=1, attributeflags=1024, categoryflags=262480, options='#height=f0.1#slotFlags=48,8,8,8,8', 
                note='', enabled=1, volume=3, mass=3000, hidden=1, health=100, descriptiontoken='def_scarab_head_mk2_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

---Add_MK2_Leg_slot_Scarab

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_scarab_leg_mk2' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_scarab_leg_mk2', quantity=1, attributeflags=1024, categoryflags=262992, options='#height=f1.5#slotFlags=420,20,20,20', 
                note='', enabled=1, volume=35, mass=6000, hidden=1, health=100, descriptiontoken='def_scarab_leg_mk2_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;
				
GO

----------------------------------------------

PRINT N'Script 03_admin_command_log.sql';

DROP TABLE IF EXISTS [dbo].[adminCommandLog]
GO

CREATE TABLE [dbo].[adminCommandLog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[eventtime] [datetime] NOT NULL,
	[characterid] [int] NOT NULL,
	[accLevel] [int] NOT NULL,
	[message] [nvarchar](255) NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[adminCommandLog] ADD  CONSTRAINT [DF_adminCommandLog_eventtime]  DEFAULT (getdate()) FOR [eventtime]
GO

-------------------------------------------------

PRINT N'Script 04_update_trainig_artifact_coordinstes.sql';

-- TRAINING ARTIFACT COORDINATES

UPDATE [dbo].[trainingartifacts] SET
    [x] = 260,
    [y] = 424
  WHERE [x] = 262 AND [y] = 426;

GO

-------------------------------------------

PRINT N'Script 05_gamma_island_speed_buff_.sql';

-- T0 speed effect add

DECLARE @T0_EFFECT_NAME  AS VARCHAR(100) = 'effect_gamma_t0';
DECLARE @T0_EFFECT_ID AS INT = (SELECT TOP 1 id FROM effects WHERE name=@T0_EFFECT_NAME);

DROP TABLE IF EXISTS #EFFECTMODS;
CREATE TABLE #EFFECTMODS 
(
	effId INT,
	fieldName VARCHAR(100),
	fieldValue FLOAT
);
INSERT INTO #EFFECTMODS (effId, fieldName, fieldValue) VALUES
(@T0_EFFECT_ID, 'effect_speed_highway_modifier', 0.5)

PRINT N'DELETING AND REINSERTING MODIFIERS FOR T0 ZONE EFFECT';
DELETE FROM [effectdefaultmodifiers] WHERE effectid=@T0_EFFECT_ID;

MERGE [dbo].[effectdefaultmodifiers] m USING #EFFECTMODS e
ON m.effectid = e.effId AND m.field=(SELECT TOP 1 id FROM aggregatefields WHERE name=e.fieldName)
WHEN MATCHED
    THEN UPDATE SET
		m.effectid=e.effId,
		m.field=(SELECT TOP 1 id FROM aggregatefields WHERE name=e.fieldName),
		m.value=e.fieldValue
WHEN NOT MATCHED
	THEN INSERT (effectid, field, value) VALUES
		(e.effId, (SELECT TOP 1 id FROM aggregatefields WHERE name=e.fieldName), e.fieldValue);

GO

-- T1 speed effect add 12.6 KPH

DECLARE @T0_EFFECT_NAME  AS VARCHAR(100) = 'effect_gamma_t1';
DECLARE @T0_EFFECT_ID AS INT = (SELECT TOP 1 id FROM effects WHERE name=@T0_EFFECT_NAME);

DROP TABLE IF EXISTS #EFFECTMODS;
CREATE TABLE #EFFECTMODS 
(
	effId INT,
	fieldName VARCHAR(100),
	fieldValue FLOAT
);
INSERT INTO #EFFECTMODS (effId, fieldName, fieldValue) VALUES
(@T0_EFFECT_ID, 'effect_speed_highway_modifier', 0.35)

PRINT N'DELETING AND REINSERTING MODIFIERS FOR T0 ZONE EFFECT';
DELETE FROM [effectdefaultmodifiers] WHERE effectid=@T0_EFFECT_ID;

MERGE [dbo].[effectdefaultmodifiers] m USING #EFFECTMODS e
ON m.effectid = e.effId AND m.field=(SELECT TOP 1 id FROM aggregatefields WHERE name=e.fieldName)
WHEN MATCHED
    THEN UPDATE SET
		m.effectid=e.effId,
		m.field=(SELECT TOP 1 id FROM aggregatefields WHERE name=e.fieldName),
		m.value=e.fieldValue
WHEN NOT MATCHED
	THEN INSERT (effectid, field, value) VALUES
		(e.effId, (SELECT TOP 1 id FROM aggregatefields WHERE name=e.fieldName), e.fieldValue);

GO

-- T2 speed effect add 9.0 KPH

DECLARE @T0_EFFECT_NAME  AS VARCHAR(100) = 'effect_gamma_t2';
DECLARE @T0_EFFECT_ID AS INT = (SELECT TOP 1 id FROM effects WHERE name=@T0_EFFECT_NAME);

DROP TABLE IF EXISTS #EFFECTMODS;
CREATE TABLE #EFFECTMODS 
(
	effId INT,
	fieldName VARCHAR(100),
	fieldValue FLOAT
);
INSERT INTO #EFFECTMODS (effId, fieldName, fieldValue) VALUES
(@T0_EFFECT_ID, 'effect_speed_highway_modifier', 0.25)

PRINT N'DELETING AND REINSERTING MODIFIERS FOR T0 ZONE EFFECT';
DELETE FROM [effectdefaultmodifiers] WHERE effectid=@T0_EFFECT_ID;

MERGE [dbo].[effectdefaultmodifiers] m USING #EFFECTMODS e
ON m.effectid = e.effId AND m.field=(SELECT TOP 1 id FROM aggregatefields WHERE name=e.fieldName)
WHEN MATCHED
    THEN UPDATE SET
		m.effectid=e.effId,
		m.field=(SELECT TOP 1 id FROM aggregatefields WHERE name=e.fieldName),
		m.value=e.fieldValue
WHEN NOT MATCHED
	THEN INSERT (effectid, field, value) VALUES
		(e.effId, (SELECT TOP 1 id FROM aggregatefields WHERE name=e.fieldName), e.fieldValue);

GO

-- T3 speed effect add 5.4 KPH

DECLARE @T0_EFFECT_NAME  AS VARCHAR(100) = 'effect_gamma_t3';
DECLARE @T0_EFFECT_ID AS INT = (SELECT TOP 1 id FROM effects WHERE name=@T0_EFFECT_NAME);

DROP TABLE IF EXISTS #EFFECTMODS;
CREATE TABLE #EFFECTMODS 
(
	effId INT,
	fieldName VARCHAR(100),
	fieldValue FLOAT
);
INSERT INTO #EFFECTMODS (effId, fieldName, fieldValue) VALUES
(@T0_EFFECT_ID, 'effect_speed_highway_modifier', 0.15)

PRINT N'DELETING AND REINSERTING MODIFIERS FOR T0 ZONE EFFECT';
DELETE FROM [effectdefaultmodifiers] WHERE effectid=@T0_EFFECT_ID;

MERGE [dbo].[effectdefaultmodifiers] m USING #EFFECTMODS e
ON m.effectid = e.effId AND m.field=(SELECT TOP 1 id FROM aggregatefields WHERE name=e.fieldName)
WHEN MATCHED
    THEN UPDATE SET
		m.effectid=e.effId,
		m.field=(SELECT TOP 1 id FROM aggregatefields WHERE name=e.fieldName),
		m.value=e.fieldValue
WHEN NOT MATCHED
	THEN INSERT (effectid, field, value) VALUES
		(e.effId, (SELECT TOP 1 id FROM aggregatefields WHERE name=e.fieldName), e.fieldValue);

GO

----------------------------------------

PRINT N'Script 06_stronghold_boss_loot_updates.sql';

--- Increase Loot buff to SH70-_Main Boss

DECLARE @definitionID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_sh70_mainboss' ORDER BY definition DESC);
DECLARE @lootdefinitionID int;
DECLARE @npclootID int;
SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_material_boss_z70' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=21000, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=19000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_boost_ep_t0' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=8, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_boost_ep_t1' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_boost_ep_t2' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=50000, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=20000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_pelistal_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=50000, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=20000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_nuimqol_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=50000, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=20000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_thelodica_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=50000, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=20000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_pelistal' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=40000, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=25000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_thelodica' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=40000, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=25000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_nuimqol' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=40000, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=25000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=40000, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=25000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=20000, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=10000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1000, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=500 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_advanced' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1000, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=400 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_expert' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1000, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=300 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_nuimqol_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1000, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=500 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_nuimqol_advanced' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1000, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=400 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_nuimqol_expert' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1000, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=300 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_pelistal_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1000, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=500 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_pelistal_advanced' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1000, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=400 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_pelistal_expert' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1000, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=400 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_thelodica_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1000, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=500 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_thelodica_advanced' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1000, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=400 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_thelodica_expert' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1000, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=300 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_reactore_core_runner' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=3 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_reactore_core_assault' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=3 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_reactore_core_mech' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=3 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_reactore_core_heavymech' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=5, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=3 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_hydra_bot_pr' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 2, 0.01, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_felos_bot_pr' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 2, 0.01, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_onyx_bot_pr' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 2, 0.01, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_70_medium_armor_repairer' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 2, 0.05, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_70_medium_shield_generator' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 2, 0.05, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_70_sensor_booster' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 2, 0.05, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_70_webber' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 2, 0.05, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_70_eccm' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 2, 0.05, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_70_medium_core_booster' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 2, 0.05, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_70_tracking_upgrade' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 2, 0.05, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_material_boss_z70' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 21000, 1, 0,0, 19000);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_research_kit_10' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 25, 1, 0,0, 5);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 50000, 1.0, 0,0, 20000);

---Zone_71_SH Boss Loot increase

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_Zone71_WilliamHBonnie' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_small_projectile_a' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2000, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_small_projectile_b' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2000, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_small_projectile_c' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2000, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_small_projectile_d' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2000, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_damage_mod_projectile' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_damage_mod_projectile' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_damage_mod_projectile_pr' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_autocannon' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_small_autocannon' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_autocannon_pr' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_shield_generator' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_material_boss_z71' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=60, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=40 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=100, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=50 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_advanced' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=75, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=25 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_expert' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=50, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=10000, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=9000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=3000, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=2500 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=600, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=500 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_boost_ep_t0' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_small_armor_plate' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 2, 0.5, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_small_armor_repairer' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 2, 0.5, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_sensor_booster' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 2, 0.5, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_small_autocannon' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 4, 0.5, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_gamma_small_autocannon' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.05, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet2_71_small_shield_generator' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.01, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_71_small_shield_generator' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.01, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_material_boss_z71' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 60, 1, 0,0, 40);


----Zone72_SH_Boss

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_npc_Zone72_One_Eye_Josef' ORDER BY definition DESC);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_medium_projectile_a' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2000, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_medium_projectile_b' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2000, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_medium_projectile_c' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2000, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_medium_projectile_d' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=2000, [probability]=0.5, [repackaged]=0, [dontdamage]=0, [minquantity]=1000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_damage_mod_projectile' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_damage_mod_projectile' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_damage_mod_projectile_pr' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_autocannon' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_autocannon' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_autocannon_pr' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_armor_plate' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_armor_repairer' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_shield_generator' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_material_boss_z72' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=60, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=40 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_basic' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=200, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=100 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_advanced' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=150, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=50 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_robotshard_common_expert' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=100, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_common_reactor_plasma' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=15000, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=12000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_common' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=3500, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=3000 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_kernel_hitech' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=600, [probability]=1, [repackaged]=0, [dontdamage]=0, [minquantity]=500 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_boost_ep_t0' ORDER BY definition DESC);
SET @npclootID = (SELECT TOP 1 id from npcloot WHERE definition = @definitionID AND lootdefinition = @lootdefinitionID  ORDER BY definition, lootdefinition DESC);
UPDATE npcloot SET [definition]=@definitionID, [lootdefinition]=@lootdefinitionID, [quantity]=1, [probability]=0.25, [repackaged]=0, [dontdamage]=0, [minquantity]=1 WHERE [id]=@npclootID;

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_72_small_armor_repairer' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.01, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_72_medium_armor_repairer' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.01, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_72_damage_mod_projectile' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.01, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_elitet4_72_mass_reductor' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 1, 0.01, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_armor_plate' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 2, 0.5, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_armor_repairer' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 2, 0.5, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_damage_mod_projectile' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 4, 0.25, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_longrange_medium_autocannon' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 4, 0.25, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_sensor_booster' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 2, 0.5, 0,0, 1);

SET @lootdefinitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_material_boss_z72' ORDER BY definition DESC);
INSERT INTO [dbo].[npcloot] ([definition],[lootdefinition],[quantity],[probability],[repackaged],[dontdamage],[minquantity]) VALUES(@definitionID, @lootdefinitionID, 60, 1, 0,0, 40);

GO

--------------------------------------

PRINT N'Script 07_metis_add_leg_slot.sql';

DECLARE @definitionID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_metis_leg' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_metis_leg', quantity=1, attributeflags=1024, categoryflags=262992, options='#height=f1.1#slotFlags=420,20,20,20,20', 
                note='', enabled=1, volume=20, mass=15000, hidden=1, health=100, descriptiontoken='bot_leg_desc', purchasable=0, tiertype=0, 
                tierlevel=0 where definition=@definitionID;
				
GO

----------------------------------------

PRINT N'Script 08_metis_increase_speed.sql';

DECLARE @definitionID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_metis_leg' ORDER BY definition DESC);

DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'speed_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=1.95 WHERE id =  @aggvalueID;

GO

PRINT N'Completed';