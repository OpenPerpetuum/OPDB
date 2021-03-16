USE [perpetuumsa]
GO

------------------------------------------------------
-- Syndicate shop orders for syndicate bot cost updates
-- Date modified: 03/15/2021
------------------------------------------------------

DECLARE @vektorDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_vektor_bot');
DECLARE @helixDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_helix_bot');
DECLARE @locustDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_locust_bot');
DECLARE @echelonDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_echelon_bot');
DECLARE @callistoDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_callisto_bot');
DECLARE @legatusDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_legatus_bot');
DECLARE @ikarusDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ikarus_bot');
DECLARE @cronusDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_cronus_bot');
DECLARE @hermesDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_hermes_bot');
DECLARE @daidalosDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_daidalos_bot');
DECLARE @metisDef AS INT = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_metis_bot');

DROP TABLE IF EXISTS #SYNSHOP;
CREATE TABLE #SYNSHOP(
	def INT,
	nic INT,
	tokens INT
);
INSERT INTO #SYNSHOP (def, nic, tokens) VALUES
(@vektorDef, 80, 490000),
(@helixDef, 230, 1380000),
(@locustDef, 220, 1330000),
(@echelonDef, 710, 4260000),
(@callistoDef, 890, 5330000),
(@legatusDef, 2980, 17870000),
(@ikarusDef, 60, 330000),
(@cronusDef, 260, 1570000),
(@hermesDef, 260, 1560000),
(@daidalosDef, 1550, 9300000),
(@metisDef, 3390, 20370000);

PRINT N'UPDATE [itemshop] WITH NEW SYNSHOP PRICING';
MERGE [dbo].[itemshop] i USING #SYNSHOP s
ON i.targetdefinition = s.def
WHEN MATCHED
    THEN UPDATE SET
		credit=s.nic,
		unicoin=s.tokens;


DROP TABLE IF EXISTS #SYNSHOP;
GO
