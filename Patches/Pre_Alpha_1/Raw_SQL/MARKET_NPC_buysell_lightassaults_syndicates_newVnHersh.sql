
--VendorEIDs for NV and hersh
--TMA: 1562
--Hersh: 5114985996031923315
--Cadavria: 5017597357619707005
--Lenworth: 6748526534285802691
--Bellicha: 8565344739145077685
DECLARE @buyMult float;
DECLARE @sellMult float;
DECLARE @vendorid bigint;

DECLARE @buyprice float;
DECLARE @sellprice float;

DECLARE @vektorDef int;
DECLARE @locustDef int;
DECLARE @ikarusDef int;
DECLARE @cronusDef int;
DECLARE @hermesDef int;

SET @vektorDef=5504;
SET @locustDef=5512;
SET @ikarusDef=5528;
SET @cronusDef=5532;
SET @hermesDef=5536;


DECLARE @vekprice float;
DECLARE @cronusprice float;
DECLARE @hermesprice float;
DECLARE @ikarusprice float;
DECLARE @locustprice float;

SET @vekprice = 300000;
SET @locustprice = 1220000;
SET @ikarusprice = 190000;
SET @hermesprice = 1090000;
SET @cronusprice = 1090000;

--TMA
SET @vendorid = 1562;
SET @sellMult = (SELECT TOP 1 vendorsellprofit from vendors where vendorEID=@vendorid)
SET @buyMult = (SELECT TOP 1 vendorbuyprofit from vendors where vendorEID=@vendorid)
--vektor
SET @sellprice = @vekprice/@sellMult;
SET @buyprice = (@vekprice/@buyMult)/10;
EXEC dbo.addVendorSellItem @vendorid, @vektorDef, @sellprice, 0;
EXEC dbo.addVendorBuyItem @vendorid, @vektorDef,  @buyprice, 0;
--ikarus
SET @sellprice = @ikarusprice/@sellMult;
SET @buyprice = (@ikarusprice/@buyMult)/10;
EXEC dbo.addVendorSellItem @vendorid, @ikarusDef, @sellprice, 0;
EXEC dbo.addVendorBuyItem @vendorid, @ikarusDef,  @buyprice, 0;
--locust
SET @sellprice = @locustprice/@sellMult;
SET @buyprice = (@locustprice/@buyMult)/10;
EXEC dbo.addVendorSellItem @vendorid, @locustDef, @sellprice, 0;
EXEC dbo.addVendorBuyItem @vendorid, @locustDef,  @buyprice, 0;
--hermes
SET @sellprice = @hermesprice/@sellMult;
SET @buyprice = (@hermesprice/@buyMult)/10;
EXEC dbo.addVendorSellItem @vendorid, @hermesDef, @sellprice, 0;
EXEC dbo.addVendorBuyItem @vendorid, @hermesDef,  @buyprice, 0;
--cronus
SET @sellprice = @cronusprice/@sellMult;
SET @buyprice = (@cronusprice/@buyMult)/10;
EXEC dbo.addVendorSellItem @vendorid, @cronusDef, @sellprice, 0;
EXEC dbo.addVendorBuyItem @vendorid, @cronusDef,  @buyprice, 0;



--Hershfield
SET @vendorid = 5114985996031923315;
SET @sellMult = (SELECT TOP 1 vendorsellprofit from vendors where vendorEID=@vendorid)
SET @buyMult = (SELECT TOP 1 vendorbuyprofit from vendors where vendorEID=@vendorid)
--vektor
SET @sellprice = @vekprice/@sellMult;
SET @buyprice = (@vekprice/@buyMult)/10;
EXEC dbo.addVendorSellItem @vendorid, @vektorDef, @sellprice, 0;
EXEC dbo.addVendorBuyItem @vendorid, @vektorDef,  @buyprice, 0;
--ikarus
SET @sellprice = @ikarusprice/@sellMult;
SET @buyprice = (@ikarusprice/@buyMult)/10;
EXEC dbo.addVendorSellItem @vendorid, @ikarusDef, @sellprice, 0;
EXEC dbo.addVendorBuyItem @vendorid, @ikarusDef,  @buyprice, 0;
--locust
SET @sellprice = @locustprice/@sellMult;
SET @buyprice = (@locustprice/@buyMult)/10;
EXEC dbo.addVendorSellItem @vendorid, @locustDef, @sellprice, 0;
EXEC dbo.addVendorBuyItem @vendorid, @locustDef,  @buyprice, 0;
--hermes
SET @sellprice = @hermesprice/@sellMult;
SET @buyprice = (@hermesprice/@buyMult)/10;
EXEC dbo.addVendorSellItem @vendorid, @hermesDef, @sellprice, 0;
EXEC dbo.addVendorBuyItem @vendorid, @hermesDef,  @buyprice, 0;
--cronus
SET @sellprice = @cronusprice/@sellMult;
SET @buyprice = (@cronusprice/@buyMult)/10;
EXEC dbo.addVendorSellItem @vendorid, @cronusDef, @sellprice, 0;
EXEC dbo.addVendorBuyItem @vendorid, @cronusDef,  @buyprice, 0;




--Cadravia
SET @vendorid = 5017597357619707005;
SET @sellMult = (SELECT TOP 1 vendorsellprofit from vendors where vendorEID=@vendorid)
SET @buyMult = (SELECT TOP 1 vendorbuyprofit from vendors where vendorEID=@vendorid)
--vektor
SET @sellprice = @vekprice/@sellMult;
SET @buyprice = (@vekprice/@buyMult)/10;
EXEC dbo.addVendorSellItem @vendorid, @vektorDef, @sellprice, 0;
EXEC dbo.addVendorBuyItem @vendorid, @vektorDef,  @buyprice, 0;
--ikarus
SET @sellprice = @ikarusprice/@sellMult;
SET @buyprice = (@ikarusprice/@buyMult)/10;
EXEC dbo.addVendorSellItem @vendorid, @ikarusDef, @sellprice, 0;
EXEC dbo.addVendorBuyItem @vendorid, @ikarusDef,  @buyprice, 0;
--locust
SET @sellprice = @locustprice/@sellMult;
SET @buyprice = (@locustprice/@buyMult)/10;
EXEC dbo.addVendorSellItem @vendorid, @locustDef, @sellprice, 0;
EXEC dbo.addVendorBuyItem @vendorid, @locustDef,  @buyprice, 0;
--hermes
SET @sellprice = @hermesprice/@sellMult;
SET @buyprice = (@hermesprice/@buyMult)/10;
EXEC dbo.addVendorSellItem @vendorid, @hermesDef, @sellprice, 0;
EXEC dbo.addVendorBuyItem @vendorid, @hermesDef,  @buyprice, 0;
--cronus
SET @sellprice = @cronusprice/@sellMult;
SET @buyprice = (@cronusprice/@buyMult)/10;
EXEC dbo.addVendorSellItem @vendorid, @cronusDef, @sellprice, 0;
EXEC dbo.addVendorBuyItem @vendorid, @cronusDef,  @buyprice, 0;
;



--Lenworth
SET @vendorid = 6748526534285802691;
SET @sellMult = (SELECT TOP 1 vendorsellprofit from vendors where vendorEID=@vendorid)
SET @buyMult = (SELECT TOP 1 vendorbuyprofit from vendors where vendorEID=@vendorid)
--vektor
SET @sellprice = @vekprice/@sellMult;
SET @buyprice = (@vekprice/@buyMult)/10;
EXEC dbo.addVendorSellItem @vendorid, @vektorDef, @sellprice, 0;
EXEC dbo.addVendorBuyItem @vendorid, @vektorDef,  @buyprice, 0;
--ikarus
SET @sellprice = @ikarusprice/@sellMult;
SET @buyprice = (@ikarusprice/@buyMult)/10;
EXEC dbo.addVendorSellItem @vendorid, @ikarusDef, @sellprice, 0;
EXEC dbo.addVendorBuyItem @vendorid, @ikarusDef,  @buyprice, 0;
--locust
SET @sellprice = @locustprice/@sellMult;
SET @buyprice = (@locustprice/@buyMult)/10;
EXEC dbo.addVendorSellItem @vendorid, @locustDef, @sellprice, 0;
EXEC dbo.addVendorBuyItem @vendorid, @locustDef,  @buyprice, 0;
--hermes
SET @sellprice = @hermesprice/@sellMult;
SET @buyprice = (@hermesprice/@buyMult)/10;
EXEC dbo.addVendorSellItem @vendorid, @hermesDef, @sellprice, 0;
EXEC dbo.addVendorBuyItem @vendorid, @hermesDef,  @buyprice, 0;
--cronus
SET @sellprice = @cronusprice/@sellMult;
SET @buyprice = (@cronusprice/@buyMult)/10;
EXEC dbo.addVendorSellItem @vendorid, @cronusDef, @sellprice, 0;
EXEC dbo.addVendorBuyItem @vendorid, @cronusDef,  @buyprice, 0;




--Bellicha
SET @vendorid = 8565344739145077685;
SET @sellMult = (SELECT TOP 1 vendorsellprofit from vendors where vendorEID=@vendorid)
SET @buyMult = (SELECT TOP 1 vendorbuyprofit from vendors where vendorEID=@vendorid)
--vektor
SET @sellprice = @vekprice/@sellMult;
SET @buyprice = (@vekprice/@buyMult)/10;
EXEC dbo.addVendorSellItem @vendorid, @vektorDef, @sellprice, 0;
EXEC dbo.addVendorBuyItem @vendorid, @vektorDef,  @buyprice, 0;
--ikarus
SET @sellprice = @ikarusprice/@sellMult;
SET @buyprice = (@ikarusprice/@buyMult)/10;
EXEC dbo.addVendorSellItem @vendorid, @ikarusDef, @sellprice, 0;
EXEC dbo.addVendorBuyItem @vendorid, @ikarusDef,  @buyprice, 0;
--locust
SET @sellprice = @locustprice/@sellMult;
SET @buyprice = (@locustprice/@buyMult)/10;
EXEC dbo.addVendorSellItem @vendorid, @locustDef, @sellprice, 0;
EXEC dbo.addVendorBuyItem @vendorid, @locustDef,  @buyprice, 0;
--hermes
SET @sellprice = @hermesprice/@sellMult;
SET @buyprice = (@hermesprice/@buyMult)/10;
EXEC dbo.addVendorSellItem @vendorid, @hermesDef, @sellprice, 0;
EXEC dbo.addVendorBuyItem @vendorid, @hermesDef,  @buyprice, 0;
--cronus
SET @sellprice = @cronusprice/@sellMult;
SET @buyprice = (@cronusprice/@buyMult)/10;
EXEC dbo.addVendorSellItem @vendorid, @cronusDef, @sellprice, 0;
EXEC dbo.addVendorBuyItem @vendorid, @cronusDef,  @buyprice, 0;

