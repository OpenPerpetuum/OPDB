USE [perpetuumsa]
GO

----------------------------------------------------------------------
--UPDATED + FIXES for Patch 13 SAP loot patch
--Wrong thelodica destro pvp ammo
--Bad plasma quantities on destros
--Bad Hi tech quantities on specis
--Last Modified: 2019/11/23
----------------------------------------------------------------------

PRINT N'FULL WIPE OF INSTRUSION LOOT';
DELETE FROM [dbo].[intrusionloot];


--OUTPOSTS
DECLARE @nuimqolOutpost INT;
DECLARE @pelistalOutpost INT;
DECLARE @thelodicaOutpost INT;

SET @nuimqolOutpost = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_public_docking_base_nuimqol_outpost');
SET @pelistalOutpost = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_public_docking_base_pelistal_outpost');
SET @thelodicaOutpost = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_public_docking_base_thelodica_outpost');

--SAPS
DECLARE @activeSAP INT;
DECLARE @destroSAP INT;
DECLARE @passiveSAP INT;
DECLARE @speciSAP INT;

SET @activeSAP = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_sap_active_hacking');
SET @destroSAP = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_sap_destruction');
SET @passiveSAP = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_sap_passive_hacking');
SET @speciSAP = (SELECT TOP 1 definition FROM entitydefaults where definitionname='def_sap_specimen_processing');

--LOOTS
DECLARE @cortexLight INT;
DECLARE @cortexAssault INT;
DECLARE @cortexMech INT;
DECLARE @cortexHMech INT;
DECLARE @decoderLv6 INT;
DECLARE @decoderLv7 INT;
DECLARE @decoderLv8 INT;
DECLARE @decoderLv9 INT;
DECLARE @kernelCommon INT;
DECLARE @kernelHitech INT;
DECLARE @kernelNuimqol INT;
DECLARE @kernelThelodica INT;
DECLARE @kernelPelistal INT;
DECLARE @plasmaCommon INT;
DECLARE @plasmaNuimqol INT;
DECLARE @plasmaThelodica INT;
DECLARE @plasmaPelistal INT;
DECLARE @ammoSmallNuimqolA INT;
DECLARE @ammoSmallNuimqolB INT;
DECLARE @ammoMedNuimqolA INT;
DECLARE @ammoMedNuimqolB INT;
DECLARE @ammoSmallThelodicaA INT;
DECLARE @ammoSmallThelodicaB INT;
DECLARE @ammoMedThelodicaA INT;
DECLARE @ammoMedThelodicaB INT;
DECLARE @ammoSmallPelistalA INT;
DECLARE @ammoSmallPelistalB INT;
DECLARE @ammoMedPelistalA INT;
DECLARE @ammoMedPelistalB INT;
DECLARE @ammoMedPelistalLRA INT;
DECLARE @ammoMedPelistalLRB INT;
DECLARE @epBoostT0 INT;

SET @cortexLight = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_reactore_core_runner');
SET @cortexAssault = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_reactore_core_assault');
SET @cortexMech = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_reactore_core_mech');
SET @cortexHMech = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_reactore_core_heavymech');
SET @decoderLv6 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_research_kit_6');
SET @decoderLv7 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_research_kit_7');
SET @decoderLv8 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_research_kit_8');
SET @decoderLv9 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_research_kit_9');
SET @kernelCommon = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_kernel_common');
SET @kernelHitech = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_kernel_hitech');
SET @kernelNuimqol = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_kernel_nuimqol');
SET @kernelThelodica = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_kernel_thelodica');
SET @kernelPelistal = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_kernel_pelistal');
SET @plasmaCommon = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_common_reactor_plasma');
SET @plasmaNuimqol = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_nuimqol_reactor_plasma');
SET @plasmaThelodica = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_thelodica_reactor_plasma');
SET @plasmaPelistal = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_pelistal_reactor_plasma');
SET @ammoSmallNuimqolA = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_small_railgun_rewa');
SET @ammoSmallNuimqolB  = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_small_railgun_rewb');
SET @ammoMedNuimqolA  = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_rewa');
SET @ammoMedNuimqolB  = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_medium_railgun_rewb');
SET @ammoSmallThelodicaA  = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_small_lasercrystal_rewa'); --fixed
SET @ammoSmallThelodicaB  = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_small_lasercrystal_rewb'); --fixed
SET @ammoMedThelodicaA  = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_rewa'); --fixed
SET @ammoMedThelodicaB  = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_medium_lasercrystal_rewb'); --fixed
SET @ammoSmallPelistalA  = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_rocket_rewa');
SET @ammoSmallPelistalB  = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_rocket_rewb');
SET @ammoMedPelistalA  = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_missile_rewa');
SET @ammoMedPelistalB  = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_missile_rewB');
SET @ammoMedPelistalLRA  = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_longrange_missile_rewa');
SET @ammoMedPelistalLRB  = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_longrange_missile_rewb');
SET @epBoostT0 = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_boost_ep_t0');

PRINT N'INSERT ALL-NEW INSTRUSION LOOTS!';

INSERT INTO [dbo].[intrusionloot]
	([sitedefinition],[sapdefinition],[itemdefinition],[minquantity],[maxquantity],[minstabilitythreshold],[maxstabilitythreshold],[probability])
VALUES
--ALL
--0-49
	(@nuimqolOutpost, @activeSAP, @kernelCommon, 900, 1100, 0, 49, 1),
	(@nuimqolOutpost, @activeSAP, @kernelHitech, 150, 250, 0, 49, 1),
	(@nuimqolOutpost, @activeSAP, @plasmaCommon, 1000, 2000, 0, 49, 1),
	(@nuimqolOutpost, @activeSAP, @epBoostT0, 1, 1, 0, 49, 1),

	(@nuimqolOutpost, @passiveSAP, @kernelCommon, 900, 1100, 0, 49, 1),
	(@nuimqolOutpost, @passiveSAP, @kernelHitech, 150, 250, 0, 49, 1),
	(@nuimqolOutpost, @passiveSAP, @plasmaCommon, 1000, 2000, 0, 49, 1),
	(@nuimqolOutpost, @passiveSAP, @epBoostT0, 1, 1, 0, 49, 1),

	(@nuimqolOutpost, @destroSAP, @kernelCommon, 900, 1100, 0, 49, 1),
	(@nuimqolOutpost, @destroSAP, @kernelHitech, 150, 250, 0, 49, 1),
	(@nuimqolOutpost, @destroSAP, @plasmaCommon, 1000, 2000, 0, 49, 1),
	(@nuimqolOutpost, @destroSAP, @epBoostT0, 1, 1, 0, 49, 1),

	(@nuimqolOutpost, @speciSAP, @kernelCommon, 900, 1100, 0, 49, 1),
	(@nuimqolOutpost, @speciSAP, @kernelHitech, 150, 250, 0, 49, 1),
	(@nuimqolOutpost, @speciSAP, @plasmaCommon, 1000, 2000, 0, 49, 1),
	(@nuimqolOutpost, @speciSAP, @epBoostT0, 1, 1, 0, 49, 1),
	--pelistal
	(@pelistalOutpost, @activeSAP, @kernelCommon, 900, 1100, 0, 49, 1),
	(@pelistalOutpost, @activeSAP, @kernelHitech, 150, 250, 0, 49, 1),
	(@pelistalOutpost, @activeSAP, @plasmaCommon, 1000, 2000, 0, 49, 1),
	(@pelistalOutpost, @activeSAP, @epBoostT0, 1, 1, 0, 49, 1),

	(@pelistalOutpost, @passiveSAP, @kernelCommon, 900, 1100, 0, 49, 1),
	(@pelistalOutpost, @passiveSAP, @kernelHitech, 150, 250, 0, 49, 1),
	(@pelistalOutpost, @passiveSAP, @plasmaCommon, 1000, 2000, 0, 49, 1),
	(@pelistalOutpost, @passiveSAP, @epBoostT0, 1, 1, 0, 49, 1),

	(@pelistalOutpost, @destroSAP, @kernelCommon, 900, 1100, 0, 49, 1),
	(@pelistalOutpost, @destroSAP, @kernelHitech, 150, 250, 0, 49, 1),
	(@pelistalOutpost, @destroSAP, @plasmaCommon, 1000, 2000, 0, 49, 1),
	(@pelistalOutpost, @destroSAP, @epBoostT0, 1, 1, 0, 49, 1),

	(@pelistalOutpost, @speciSAP, @kernelCommon, 900, 1100, 0, 49, 1),
	(@pelistalOutpost, @speciSAP, @kernelHitech, 150, 250, 0, 49, 1),
	(@pelistalOutpost, @speciSAP, @plasmaCommon, 1000, 2000, 0, 49, 1),
	(@pelistalOutpost, @speciSAP, @epBoostT0, 1, 1, 0, 49, 1),
	--thelo
	(@thelodicaOutpost, @activeSAP, @kernelCommon, 900, 1100, 0, 49, 1),
	(@thelodicaOutpost, @activeSAP, @kernelHitech, 150, 250, 0, 49, 1),
	(@thelodicaOutpost, @activeSAP, @plasmaCommon, 1000, 2000, 0, 49, 1),
	(@thelodicaOutpost, @activeSAP, @epBoostT0, 1, 1, 0, 49, 1),

	(@thelodicaOutpost, @passiveSAP, @kernelCommon, 900, 1100, 0, 49, 1),
	(@thelodicaOutpost, @passiveSAP, @kernelHitech, 150, 250, 0, 49, 1),
	(@thelodicaOutpost, @passiveSAP, @plasmaCommon, 1000, 2000, 0, 49, 1),
	(@thelodicaOutpost, @passiveSAP, @epBoostT0, 1, 1, 0, 49, 1),

	(@thelodicaOutpost, @destroSAP, @kernelCommon, 900, 1100, 0, 49, 1),
	(@thelodicaOutpost, @destroSAP, @kernelHitech, 150, 250, 0, 49, 1),
	(@thelodicaOutpost, @destroSAP, @plasmaCommon, 1000, 2000, 0, 49, 1),
	(@thelodicaOutpost, @destroSAP, @epBoostT0, 1, 1, 0, 49, 1),

	(@thelodicaOutpost, @speciSAP, @kernelCommon, 900, 1100, 0, 49, 1),
	(@thelodicaOutpost, @speciSAP, @kernelHitech, 150, 250, 0, 49, 1),
	(@thelodicaOutpost, @speciSAP, @plasmaCommon, 1000, 2000, 0, 49, 1),
	(@thelodicaOutpost, @speciSAP, @epBoostT0, 1, 1, 0, 49, 1),

--ACTIVE
--0-49
	(@nuimqolOutpost, @activeSAP, @cortexLight, 1, 1, 0, 49, 1),
	(@nuimqolOutpost, @activeSAP, @cortexAssault, 1, 1, 0, 49, 1),
	(@nuimqolOutpost, @activeSAP, @cortexLight, 1, 1, 0, 49, 0.125),
	(@nuimqolOutpost, @activeSAP, @cortexAssault, 1, 1, 0, 49, 0.125),
	(@nuimqolOutpost, @activeSAP, @cortexMech, 1, 1, 0, 49, 0.125),
	(@nuimqolOutpost, @activeSAP, @cortexHMech, 1, 1, 0, 49, 0.125),
	(@nuimqolOutpost, @activeSAP, @decoderLv6, 1, 1, 0, 49, 0.5),
	(@nuimqolOutpost, @activeSAP, @decoderLv7, 1, 1, 0, 49, 0.25),
	(@nuimqolOutpost, @activeSAP, @decoderLv8, 1, 1, 0, 49, 0.15),
	(@nuimqolOutpost, @activeSAP, @decoderLv9, 1, 1, 0, 49, 0.1),

	(@pelistalOutpost, @activeSAP, @cortexLight, 1, 1, 0, 49, 1),
	(@pelistalOutpost, @activeSAP, @cortexAssault, 1, 1, 0, 49, 1),
	(@pelistalOutpost, @activeSAP, @cortexLight, 1, 1, 0, 49, 0.125),
	(@pelistalOutpost, @activeSAP, @cortexAssault, 1, 1, 0, 49, 0.125),
	(@pelistalOutpost, @activeSAP, @cortexMech, 1, 1, 0, 49, 0.125),
	(@pelistalOutpost, @activeSAP, @cortexHMech, 1, 1, 0, 49, 0.125),
	(@pelistalOutpost, @activeSAP, @decoderLv6, 1, 1, 0, 49, 0.5),
	(@pelistalOutpost, @activeSAP, @decoderLv7, 1, 1, 0, 49, 0.25),
	(@pelistalOutpost, @activeSAP, @decoderLv8, 1, 1, 0, 49, 0.15),
	(@pelistalOutpost, @activeSAP, @decoderLv9, 1, 1, 0, 49, 0.1),

	(@thelodicaOutpost, @activeSAP, @cortexLight, 1, 1, 0, 49, 1),
	(@thelodicaOutpost, @activeSAP, @cortexAssault, 1, 1, 0, 49, 1),
	(@thelodicaOutpost, @activeSAP, @cortexLight, 1, 1, 0, 49, 0.125),
	(@thelodicaOutpost, @activeSAP, @cortexAssault, 1, 1, 0, 49, 0.125),
	(@thelodicaOutpost, @activeSAP, @cortexMech, 1, 1, 0, 49, 0.125),
	(@thelodicaOutpost, @activeSAP, @cortexHMech, 1, 1, 0, 49, 0.125),
	(@thelodicaOutpost, @activeSAP, @decoderLv6, 1, 1, 0, 49, 0.5),
	(@thelodicaOutpost, @activeSAP, @decoderLv7, 1, 1, 0, 49, 0.25),
	(@thelodicaOutpost, @activeSAP, @decoderLv8, 1, 1, 0, 49, 0.15),
	(@thelodicaOutpost, @activeSAP, @decoderLv9, 1, 1, 0, 49, 0.1),
--50-99
	(@nuimqolOutpost, @activeSAP, @cortexLight, 1, 1, 50, 99, 1),
	(@nuimqolOutpost, @activeSAP, @cortexAssault, 1, 1, 50, 99, 1),
	(@nuimqolOutpost, @activeSAP, @cortexMech, 1, 1, 50, 99, 1),
	(@nuimqolOutpost, @activeSAP, @cortexLight, 1, 1, 50, 99, 0.125),
	(@nuimqolOutpost, @activeSAP, @cortexAssault, 1, 1, 50, 99, 0.125),
	(@nuimqolOutpost, @activeSAP, @cortexMech, 1, 1, 50, 99, 0.125),
	(@nuimqolOutpost, @activeSAP, @cortexHMech, 1, 1, 50, 99, 0.125),
	(@nuimqolOutpost, @activeSAP, @decoderLv6, 1, 2, 50, 99, 0.5),
	(@nuimqolOutpost, @activeSAP, @decoderLv7, 1, 2, 50, 99, 0.25),
	(@nuimqolOutpost, @activeSAP, @decoderLv8, 1, 2, 50, 99, 0.15),
	(@nuimqolOutpost, @activeSAP, @decoderLv9, 1, 2, 50, 99, 0.1),

	(@pelistalOutpost, @activeSAP, @cortexLight, 1, 1, 50, 99, 1),
	(@pelistalOutpost, @activeSAP, @cortexAssault, 1, 1, 50, 99, 1),
	(@pelistalOutpost, @activeSAP, @cortexMech, 1, 1, 50, 99, 1),
	(@pelistalOutpost, @activeSAP, @cortexLight, 1, 1, 50, 99, 0.125),
	(@pelistalOutpost, @activeSAP, @cortexAssault, 1, 1, 50, 99, 0.125),
	(@pelistalOutpost, @activeSAP, @cortexMech, 1, 1, 50, 99, 0.125),
	(@pelistalOutpost, @activeSAP, @cortexHMech, 1, 1, 50, 99, 0.125),
	(@pelistalOutpost, @activeSAP, @decoderLv6, 1, 2, 50, 99, 0.5),
	(@pelistalOutpost, @activeSAP, @decoderLv7, 1, 2, 50, 99, 0.25),
	(@pelistalOutpost, @activeSAP, @decoderLv8, 1, 2, 50, 99, 0.15),
	(@pelistalOutpost, @activeSAP, @decoderLv9, 1, 2, 50, 99, 0.1),

	(@thelodicaOutpost, @activeSAP, @cortexLight, 1, 1, 50, 99, 1),
	(@thelodicaOutpost, @activeSAP, @cortexAssault, 1, 1, 50, 99, 1),
	(@thelodicaOutpost, @activeSAP, @cortexMech, 1, 1, 50, 99, 1),
	(@thelodicaOutpost, @activeSAP, @cortexLight, 1, 1, 50, 99, 0.125),
	(@thelodicaOutpost, @activeSAP, @cortexAssault, 1, 1, 50, 99, 0.125),
	(@thelodicaOutpost, @activeSAP, @cortexMech, 1, 1, 50, 99, 0.125),
	(@thelodicaOutpost, @activeSAP, @cortexHMech, 1, 1, 50, 99, 0.125),
	(@thelodicaOutpost, @activeSAP, @decoderLv6, 1, 2, 50, 99, 0.5),
	(@thelodicaOutpost, @activeSAP, @decoderLv7, 1, 2, 50, 99, 0.25),
	(@thelodicaOutpost, @activeSAP, @decoderLv8, 1, 2, 50, 99, 0.15),
	(@thelodicaOutpost, @activeSAP, @decoderLv9, 1, 2, 50, 99, 0.1),
--100+
	(@nuimqolOutpost, @activeSAP, @cortexLight, 1, 1, 100, 200, 1),
	(@nuimqolOutpost, @activeSAP, @cortexAssault, 1, 1, 100, 200, 1),
	(@nuimqolOutpost, @activeSAP, @cortexMech, 1, 1, 100, 200, 1),
	(@nuimqolOutpost, @activeSAP, @cortexHMech, 1, 1, 100, 200, 1),
	(@nuimqolOutpost, @activeSAP, @cortexLight, 1, 1, 100, 200, 0.125),
	(@nuimqolOutpost, @activeSAP, @cortexAssault, 1, 1, 100, 200, 0.125),
	(@nuimqolOutpost, @activeSAP, @cortexMech, 1, 1, 100, 200, 0.125),
	(@nuimqolOutpost, @activeSAP, @cortexHMech, 1, 1, 100, 200, 0.125),
	(@nuimqolOutpost, @activeSAP, @decoderLv6, 1, 3, 100, 200, 0.5),
	(@nuimqolOutpost, @activeSAP, @decoderLv7, 1, 3, 100, 200, 0.25),
	(@nuimqolOutpost, @activeSAP, @decoderLv8, 1, 3, 100, 200, 0.15),
	(@nuimqolOutpost, @activeSAP, @decoderLv9, 1, 3, 100, 200, 0.1),

	(@pelistalOutpost, @activeSAP, @cortexLight, 1, 1, 100, 200, 1),
	(@pelistalOutpost, @activeSAP, @cortexAssault, 1, 1, 100, 200, 1),
	(@pelistalOutpost, @activeSAP, @cortexMech, 1, 1, 100, 200, 1),
	(@pelistalOutpost, @activeSAP, @cortexHMech, 1, 1, 100, 200, 1),
	(@pelistalOutpost, @activeSAP, @cortexLight, 1, 1, 100, 200, 0.125),
	(@pelistalOutpost, @activeSAP, @cortexAssault, 1, 1, 100, 200, 0.125),
	(@pelistalOutpost, @activeSAP, @cortexMech, 1, 1, 100, 200, 0.125),
	(@pelistalOutpost, @activeSAP, @cortexHMech, 1, 1, 100, 200, 0.125),
	(@pelistalOutpost, @activeSAP, @decoderLv6, 1, 3, 100, 200, 0.5),
	(@pelistalOutpost, @activeSAP, @decoderLv7, 1, 3, 100, 200, 0.25),
	(@pelistalOutpost, @activeSAP, @decoderLv8, 1, 3, 100, 200, 0.15),
	(@pelistalOutpost, @activeSAP, @decoderLv9, 1, 3, 100, 200, 0.1),

	(@thelodicaOutpost, @activeSAP, @cortexLight, 1, 1, 100, 200, 1),
	(@thelodicaOutpost, @activeSAP, @cortexAssault, 1, 1, 100, 200, 1),
	(@thelodicaOutpost, @activeSAP, @cortexMech, 1, 1, 100, 200, 1),
	(@thelodicaOutpost, @activeSAP, @cortexHMech, 1, 1, 100, 200, 1),
	(@thelodicaOutpost, @activeSAP, @cortexLight, 1, 1, 100, 200, 0.125),
	(@thelodicaOutpost, @activeSAP, @cortexAssault, 1, 1, 100, 200, 0.125),
	(@thelodicaOutpost, @activeSAP, @cortexMech, 1, 1, 100, 200, 0.125),
	(@thelodicaOutpost, @activeSAP, @cortexHMech, 1, 1, 100, 200, 0.125),
	(@thelodicaOutpost, @activeSAP, @decoderLv6, 1, 3, 100, 200, 0.5),
	(@thelodicaOutpost, @activeSAP, @decoderLv7, 1, 3, 100, 200, 0.25),
	(@thelodicaOutpost, @activeSAP, @decoderLv8, 1, 3, 100, 200, 0.15),
	(@thelodicaOutpost, @activeSAP, @decoderLv9, 1, 3, 100, 200, 0.1),

--DESTRO
--0-49
	(@nuimqolOutpost, @destroSAP, @ammoSmallNuimqolA, 125, 175, 0, 49, 1),
	(@nuimqolOutpost, @destroSAP, @ammoSmallNuimqolB, 125, 175, 0, 49, 1),
	(@nuimqolOutpost, @destroSAP, @ammoMedNuimqolA, 125, 175, 0, 49, 1),
	(@nuimqolOutpost, @destroSAP, @ammoMedNuimqolB, 125, 175, 0, 49, 1),
	(@nuimqolOutpost, @destroSAP, @plasmaNuimqol, 1000, 2000, 0, 49, 1),

	(@pelistalOutpost, @destroSAP, @ammoSmallPelistalA, 125, 175, 0, 49, 1),
	(@pelistalOutpost, @destroSAP, @ammoSmallPelistalB, 125, 175, 0, 49, 1),
	(@pelistalOutpost, @destroSAP, @ammoMedPelistalA, 125, 175, 0, 49, 1),
	(@pelistalOutpost, @destroSAP, @ammoMedPelistalB, 125, 175, 0, 49, 1),
	(@pelistalOutpost, @destroSAP, @ammoMedPelistalLRA, 125, 175, 0, 49, 1),
	(@pelistalOutpost, @destroSAP, @ammoMedPelistalLRB, 125, 175, 0, 49, 1),
	(@pelistalOutpost, @destroSAP, @plasmaPelistal, 1000, 2000, 0, 49, 1),

	(@thelodicaOutpost, @destroSAP, @ammoSmallThelodicaA, 125, 175, 0, 49, 1),
	(@thelodicaOutpost, @destroSAP, @ammoSmallThelodicaB, 125, 175, 0, 49, 1),
	(@thelodicaOutpost, @destroSAP, @ammoMedThelodicaA, 125, 175, 0, 49, 1),
	(@thelodicaOutpost, @destroSAP, @ammoMedThelodicaB, 125, 175, 0, 49, 1),
	(@thelodicaOutpost, @destroSAP, @plasmaThelodica, 1000, 2000, 0, 49, 1),
--50-99
	(@nuimqolOutpost, @destroSAP, @ammoSmallNuimqolA, 250, 350, 50, 99, 1),
	(@nuimqolOutpost, @destroSAP, @ammoSmallNuimqolB, 250, 350, 50, 99, 1),
	(@nuimqolOutpost, @destroSAP, @ammoMedNuimqolA, 250, 350, 50, 99, 1),
	(@nuimqolOutpost, @destroSAP, @ammoMedNuimqolB, 250, 350, 50, 99, 1),
	(@nuimqolOutpost, @destroSAP, @plasmaNuimqol, 2000, 3000, 50, 99, 1),--fixed

	(@pelistalOutpost, @destroSAP, @ammoSmallPelistalA, 250, 350, 50, 99, 1),
	(@pelistalOutpost, @destroSAP, @ammoSmallPelistalB, 250, 350, 50, 99, 1),
	(@pelistalOutpost, @destroSAP, @ammoMedPelistalA, 250, 350, 50, 99, 1),
	(@pelistalOutpost, @destroSAP, @ammoMedPelistalB, 250, 350, 50, 99, 1),
	(@pelistalOutpost, @destroSAP, @ammoMedPelistalLRA, 250, 350, 50, 99, 1),
	(@pelistalOutpost, @destroSAP, @ammoMedPelistalLRB, 250, 350, 50, 99, 1),
	(@pelistalOutpost, @destroSAP, @plasmaPelistal, 2000, 3000, 50, 99, 1),--fixed

	(@thelodicaOutpost, @destroSAP, @ammoSmallThelodicaA, 250, 350, 50, 99, 1),
	(@thelodicaOutpost, @destroSAP, @ammoSmallThelodicaB, 250, 350, 50, 99, 1),
	(@thelodicaOutpost, @destroSAP, @ammoMedThelodicaA, 250, 350, 50, 99, 1),
	(@thelodicaOutpost, @destroSAP, @ammoMedThelodicaB, 250, 350, 50, 99, 1),
	(@thelodicaOutpost, @destroSAP, @plasmaThelodica, 2000, 3000, 50, 99, 1),--fixed
--100+
	(@nuimqolOutpost, @destroSAP, @ammoSmallNuimqolA, 375, 525, 100, 200, 1),
	(@nuimqolOutpost, @destroSAP, @ammoSmallNuimqolB, 375, 525, 100, 200, 1),
	(@nuimqolOutpost, @destroSAP, @ammoMedNuimqolA, 375, 525, 100, 200, 1),
	(@nuimqolOutpost, @destroSAP, @ammoMedNuimqolB, 375, 525, 100, 200, 1),
	(@nuimqolOutpost, @destroSAP, @plasmaNuimqol, 3000, 4000, 100, 200, 1),--fixed

	(@pelistalOutpost, @destroSAP, @ammoSmallPelistalA, 375, 525, 100, 200, 1),
	(@pelistalOutpost, @destroSAP, @ammoSmallPelistalB, 375, 525, 100, 200, 1),
	(@pelistalOutpost, @destroSAP, @ammoMedPelistalA, 375, 525, 100, 200, 1),
	(@pelistalOutpost, @destroSAP, @ammoMedPelistalB, 375, 525, 100, 200, 1),
	(@pelistalOutpost, @destroSAP, @ammoMedPelistalLRA, 375, 525, 100, 200, 1),
	(@pelistalOutpost, @destroSAP, @ammoMedPelistalLRB, 375, 525, 100, 200, 1),
	(@pelistalOutpost, @destroSAP, @plasmaPelistal, 3000, 4000, 100, 200, 1),--fixed

	(@thelodicaOutpost, @destroSAP, @ammoSmallThelodicaA, 375, 525, 100, 200, 1),
	(@thelodicaOutpost, @destroSAP, @ammoSmallThelodicaB, 375, 525, 100, 200, 1),
	(@thelodicaOutpost, @destroSAP, @ammoMedThelodicaA, 375, 525, 100, 200, 1),
	(@thelodicaOutpost, @destroSAP, @ammoMedThelodicaB, 375, 525, 100, 200, 1),
	(@thelodicaOutpost, @destroSAP, @plasmaThelodica, 3000, 4000, 100, 200, 1),--fixed


--PASSIVE
--0-49
	(@nuimqolOutpost, @passiveSAP, @decoderLv6, 1, 1, 0, 49, 0.5),
	(@nuimqolOutpost, @passiveSAP, @decoderLv7, 1, 1, 0, 49, 0.25),
	(@nuimqolOutpost, @passiveSAP, @decoderLv8, 1, 1, 0, 49, 0.15),
	(@nuimqolOutpost, @passiveSAP, @decoderLv9, 1, 1, 0, 49, 0.1),
	(@nuimqolOutpost, @passiveSAP, @plasmaNuimqol, 2500, 3500, 0, 49, 1),

	(@pelistalOutpost, @passiveSAP, @decoderLv6, 1, 1, 0, 49, 0.5),
	(@pelistalOutpost, @passiveSAP, @decoderLv7, 1, 1, 0, 49, 0.25),
	(@pelistalOutpost, @passiveSAP, @decoderLv8, 1, 1, 0, 49, 0.15),
	(@pelistalOutpost, @passiveSAP, @decoderLv9, 1, 1, 0, 49, 0.1),
	(@pelistalOutpost, @passiveSAP, @plasmaPelistal, 2500, 3500, 0, 49, 1),

	(@thelodicaOutpost, @passiveSAP, @decoderLv6, 1, 1, 0, 49, 0.5),
	(@thelodicaOutpost, @passiveSAP, @decoderLv7, 1, 1, 0, 49, 0.25),
	(@thelodicaOutpost, @passiveSAP, @decoderLv8, 1, 1, 0, 49, 0.15),
	(@thelodicaOutpost, @passiveSAP, @decoderLv9, 1, 1, 0, 49, 0.1),
	(@thelodicaOutpost, @passiveSAP, @plasmaThelodica, 2500, 3500, 0, 49, 1),
--50-99
	(@nuimqolOutpost, @passiveSAP, @decoderLv6, 1, 2, 50, 99, 0.5),
	(@nuimqolOutpost, @passiveSAP, @decoderLv7, 1, 2, 50, 99, 0.25),
	(@nuimqolOutpost, @passiveSAP, @decoderLv8, 1, 2, 50, 99, 0.15),
	(@nuimqolOutpost, @passiveSAP, @decoderLv9, 1, 2, 50, 99, 0.1),
	(@nuimqolOutpost, @passiveSAP, @plasmaNuimqol, 5000, 7000, 50, 99, 1),

	(@pelistalOutpost, @passiveSAP, @decoderLv6, 1, 2, 50, 99, 0.5),
	(@pelistalOutpost, @passiveSAP, @decoderLv7, 1, 2, 50, 99, 0.25),
	(@pelistalOutpost, @passiveSAP, @decoderLv8, 1, 2, 50, 99, 0.15),
	(@pelistalOutpost, @passiveSAP, @decoderLv9, 1, 2, 50, 99, 0.1),
	(@pelistalOutpost, @passiveSAP, @plasmaPelistal, 5000, 7000, 50, 99, 1),

	(@thelodicaOutpost, @passiveSAP, @decoderLv6, 1, 2, 50, 99, 0.5),
	(@thelodicaOutpost, @passiveSAP, @decoderLv7, 1, 2, 50, 99, 0.25),
	(@thelodicaOutpost, @passiveSAP, @decoderLv8, 1, 2, 50, 99, 0.15),
	(@thelodicaOutpost, @passiveSAP, @decoderLv9, 1, 2, 50, 99, 0.1),
	(@thelodicaOutpost, @passiveSAP, @plasmaThelodica, 5000, 7000, 50, 99, 1),
--100+
	(@nuimqolOutpost, @passiveSAP, @decoderLv6, 1, 3, 100, 200, 0.5),
	(@nuimqolOutpost, @passiveSAP, @decoderLv7, 1, 3, 100, 200, 0.25),
	(@nuimqolOutpost, @passiveSAP, @decoderLv8, 1, 3, 100, 200, 0.15),
	(@nuimqolOutpost, @passiveSAP, @decoderLv9, 1, 3, 100, 200, 0.1),
	(@nuimqolOutpost, @passiveSAP, @plasmaNuimqol, 7500, 10500, 100, 200, 1),

	(@pelistalOutpost, @passiveSAP, @decoderLv6, 1, 3, 100, 200, 0.5),
	(@pelistalOutpost, @passiveSAP, @decoderLv7, 1, 3, 100, 200, 0.25),
	(@pelistalOutpost, @passiveSAP, @decoderLv8, 1, 3, 100, 200, 0.15),
	(@pelistalOutpost, @passiveSAP, @decoderLv9, 1, 3, 100, 200, 0.1),
	(@pelistalOutpost, @passiveSAP, @plasmaPelistal, 7500, 10500, 100, 200, 1),

	(@thelodicaOutpost, @passiveSAP, @decoderLv6, 1, 3, 100, 200, 0.5),
	(@thelodicaOutpost, @passiveSAP, @decoderLv7, 1, 3, 100, 200, 0.25),
	(@thelodicaOutpost, @passiveSAP, @decoderLv8, 1, 3, 100, 200, 0.15),
	(@thelodicaOutpost, @passiveSAP, @decoderLv9, 1, 3, 100, 200, 0.1),
	(@thelodicaOutpost, @passiveSAP, @plasmaThelodica, 7500, 10500, 100, 200, 1),


--SPECI
--0-49
	(@nuimqolOutpost, @speciSAP, @cortexLight, 1, 1, 0, 49, 0.33),
	(@nuimqolOutpost, @speciSAP, @cortexAssault, 1, 1, 0, 49, 0.32),
	(@nuimqolOutpost, @speciSAP, @cortexMech, 1, 1, 0, 49, 0.31),
	(@nuimqolOutpost, @speciSAP, @cortexHMech, 1, 1, 0, 49, 0.3),
	(@nuimqolOutpost, @speciSAP, @kernelCommon, 900, 1100, 0, 49, 1),
	(@nuimqolOutpost, @speciSAP, @kernelNuimqol, 900, 1100, 0, 49, 1),
	(@nuimqolOutpost, @speciSAP, @kernelHitech, 150, 250, 0, 49, 1),

	(@pelistalOutpost, @speciSAP, @cortexLight, 1, 1, 0, 49, 0.33),
	(@pelistalOutpost, @speciSAP, @cortexAssault, 1, 1, 0, 49, 0.32),
	(@pelistalOutpost, @speciSAP, @cortexMech, 1, 1, 0, 49, 0.31),
	(@pelistalOutpost, @speciSAP, @cortexHMech, 1, 1, 0, 49, 0.3),
	(@pelistalOutpost, @speciSAP, @kernelCommon, 900, 1100, 0, 49, 1),
	(@pelistalOutpost, @speciSAP, @kernelPelistal, 900, 1100, 0, 49, 1),
	(@pelistalOutpost, @speciSAP, @kernelHitech, 150, 250, 0, 49, 1),

	(@thelodicaOutpost, @speciSAP, @cortexLight, 1, 1, 0, 49, 0.33),
	(@thelodicaOutpost, @speciSAP, @cortexAssault, 1, 1, 0, 49, 0.32),
	(@thelodicaOutpost, @speciSAP, @cortexMech, 1, 1, 0, 49, 0.31),
	(@thelodicaOutpost, @speciSAP, @cortexHMech, 1, 1, 0, 49, 0.3),
	(@thelodicaOutpost, @speciSAP, @kernelCommon, 900, 1100, 0, 49, 1),
	(@thelodicaOutpost, @speciSAP, @kernelThelodica, 900, 1100, 0, 49, 1),
	(@thelodicaOutpost, @speciSAP, @kernelHitech, 150, 250, 0, 49, 1),
--50-99
	(@nuimqolOutpost, @speciSAP, @cortexLight, 1, 1, 50, 99, 0.66),
	(@nuimqolOutpost, @speciSAP, @cortexAssault, 1, 1, 50, 99, 0.64),
	(@nuimqolOutpost, @speciSAP, @cortexMech, 1, 1, 50, 99, 0.62),
	(@nuimqolOutpost, @speciSAP, @cortexHMech, 1, 1, 50, 99, 0.6),
	(@nuimqolOutpost, @speciSAP, @kernelCommon, 1800, 2200, 50, 99, 1),
	(@nuimqolOutpost, @speciSAP, @kernelNuimqol, 1800, 2200, 50, 99, 1),
	(@nuimqolOutpost, @speciSAP, @kernelHitech, 300, 500, 50, 99, 1),--fixed

	(@pelistalOutpost, @speciSAP, @cortexLight, 1, 1, 50, 99, 0.66),
	(@pelistalOutpost, @speciSAP, @cortexAssault, 1, 1, 50, 99, 0.64),
	(@pelistalOutpost, @speciSAP, @cortexMech, 1, 1, 50, 99, 0.62),
	(@pelistalOutpost, @speciSAP, @cortexHMech, 1, 1, 50, 99, 0.6),
	(@pelistalOutpost, @speciSAP, @kernelCommon, 1800, 2200, 50, 99, 1),
	(@pelistalOutpost, @speciSAP, @kernelPelistal, 1800, 2200, 50, 99, 1),
	(@pelistalOutpost, @speciSAP, @kernelHitech, 300, 500, 50, 99, 1),--fixed

	(@thelodicaOutpost, @speciSAP, @cortexLight, 1, 1, 50, 99, 0.66),
	(@thelodicaOutpost, @speciSAP, @cortexAssault, 1, 1, 50, 99, 0.64),
	(@thelodicaOutpost, @speciSAP, @cortexMech, 1, 1, 50, 99, 0.62),
	(@thelodicaOutpost, @speciSAP, @cortexHMech, 1, 1, 50, 99, 0.6),
	(@thelodicaOutpost, @speciSAP, @kernelCommon, 1800, 2200, 50, 99, 1),
	(@thelodicaOutpost, @speciSAP, @kernelThelodica, 1800, 2200, 50, 99, 1),
	(@thelodicaOutpost, @speciSAP, @kernelHitech, 300, 500, 50, 99, 1),--fixed
--100+
	(@nuimqolOutpost, @speciSAP, @cortexLight, 1, 1, 100, 200, 0.99),
	(@nuimqolOutpost, @speciSAP, @cortexAssault, 1, 1, 100, 200, 0.96),
	(@nuimqolOutpost, @speciSAP, @cortexMech, 1, 1, 100, 200, 0.93),
	(@nuimqolOutpost, @speciSAP, @cortexHMech, 1, 1, 100, 200, 0.9),
	(@nuimqolOutpost, @speciSAP, @kernelCommon, 2700, 3300, 100, 200, 1),
	(@nuimqolOutpost, @speciSAP, @kernelNuimqol, 2700, 3300, 100, 200, 1),
	(@nuimqolOutpost, @speciSAP, @kernelHitech, 450, 750, 100, 200, 1),

	(@pelistalOutpost, @speciSAP, @cortexLight, 1, 1, 100, 200, 0.99),
	(@pelistalOutpost, @speciSAP, @cortexAssault, 1, 1, 100, 200, 0.96),
	(@pelistalOutpost, @speciSAP, @cortexMech, 1, 1, 100, 200, 0.93),
	(@pelistalOutpost, @speciSAP, @cortexHMech, 1, 1, 100, 200, 0.9),
	(@pelistalOutpost, @speciSAP, @kernelCommon, 2700, 3300, 100, 200, 1),
	(@pelistalOutpost, @speciSAP, @kernelPelistal, 2700, 3300, 100, 200, 1),
	(@pelistalOutpost, @speciSAP, @kernelHitech, 450, 750, 100, 200, 1),

	(@thelodicaOutpost, @speciSAP, @cortexLight, 1, 1, 100, 200, 0.99),
	(@thelodicaOutpost, @speciSAP, @cortexAssault, 1, 1, 100, 200, 0.96),
	(@thelodicaOutpost, @speciSAP, @cortexMech, 1, 1, 100, 200, 0.93),
	(@thelodicaOutpost, @speciSAP, @cortexHMech, 1, 1, 100, 200, 0.9),
	(@thelodicaOutpost, @speciSAP, @kernelCommon, 2700, 3300, 100, 200, 1),
	(@thelodicaOutpost, @speciSAP, @kernelThelodica, 2700, 3300, 100, 200, 1),
	(@thelodicaOutpost, @speciSAP, @kernelHitech, 450, 750, 100, 200, 1);

GO
