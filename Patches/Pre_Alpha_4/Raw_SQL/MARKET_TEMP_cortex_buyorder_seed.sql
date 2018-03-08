USE perpetuumsa
GO

-----------Seed Hersh with Cortex Buy orders TEMPORARY--------
PRINT N'Seed NPC buy orders for cortexes';

DECLARE @def_light_cortex int;
DECLARE @def_assault_cortex int;
DECLARE @def_mech_cortex int;
DECLARE @def_heavy_cortex int;

SET @def_light_cortex = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_reactore_core_runner');
SET @def_assault_cortex = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_reactore_core_assault');
SET @def_mech_cortex = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_reactore_core_mech');
SET @def_heavy_cortex = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_reactore_core_heavymech');

--2943	def_reactore_core_runner
--2944	def_reactore_core_assault
--2945	def_reactore_core_mech
--2946	def_reactore_core_heavymech

DECLARE @vendorid bigint;
DECLARE @buyMult float;
DECLARE @buyprice float;

--Hershfield
SET @vendorid = 5114985996031923315;
SET @buyMult = (SELECT TOP 1 vendorbuyprofit from vendors where vendorEID=@vendorid)
SET @buyprice = (500000/@buyMult);
EXEC dbo.addVendorBuyItem @vendorid, @def_light_cortex,  @buyprice, 0;

SET @buyprice = (1000000/@buyMult);
EXEC dbo.addVendorBuyItem @vendorid, @def_assault_cortex,  @buyprice, 0;

SET @buyprice = (2500000/@buyMult);
EXEC dbo.addVendorBuyItem @vendorid, @def_mech_cortex,  @buyprice, 0;

SET @buyprice = (5000000/@buyMult);
EXEC dbo.addVendorBuyItem @vendorid, @def_heavy_cortex,  @buyprice, 0;

GO