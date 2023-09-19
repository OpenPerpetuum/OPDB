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
