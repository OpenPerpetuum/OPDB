
USE [perpetuumsa]
GO


-----Create All Paint defintions, configs(color), and seed in Syndicate shops
PRINT N'PAINT -- UPDATE -- FIX TOKEN MIXUP';
DECLARE @alphaItemShop int;

SET @alphaItemShop = (SELECT TOP 1 id FROM itemshoppresets WHERE name like 'tm_preset_pve');

CREATE TABLE #PAINTS
(
	paintName varchar(100),
	paintColor varchar(50),
	tierType int,
	techLevel int,
	nicPrice int, 
	asiToken int,
	tmToken int,
	icsToken int,
	uniToken int,
	itemshopPresetID int
)

INSERT INTO #PAINTS VALUES
('def_paint_black','#010101',NULL,NULL,10000000,333,333,333,NULL,@alphaItemShop),
('def_paint_blue_dark','#010133',NULL,NULL,10000000,19,19,962,NULL,@alphaItemShop),
('def_paint_blue','#0101fb',NULL,NULL,10000000,4,4,992,NULL,@alphaItemShop),
('def_paint_green_dark','#013301',NULL,NULL,10000000,19,962,19,NULL,@alphaItemShop),
('def_paint_teal','#01c997',NULL,NULL,10000000,3,569,428,NULL,@alphaItemShop),
('def_paint_green','#01fb01',NULL,NULL,10000000,4,992,4,NULL,@alphaItemShop),
('def_paint_cyan','#01fbfb',NULL,NULL,10000000,2,499,499,NULL,@alphaItemShop),
('def_paint_red_dark','#650101',NULL,NULL,10000000,981,10,10,NULL,@alphaItemShop),
('def_paint_purple','#6501fb',NULL,NULL,10000000,286,3,711,NULL,@alphaItemShop),
('def_paint_gray','#979797',NULL,NULL,10000000,333,333,333,NULL,@alphaItemShop),
('def_paint_red','#fb0101',NULL,NULL,10000000,992,4,4,NULL,@alphaItemShop),
('def_paint_magenta','#fb01fb',NULL,NULL,10000000,499,2,499,NULL,@alphaItemShop),
('def_paint_orange','#fb6701',NULL,NULL,10000000,623,375,2,NULL,@alphaItemShop),
('def_paint_yellow','#fbfb01',NULL,NULL,10000000,499,499,2,NULL,@alphaItemShop),
('def_paint_white','#fbfbfb',NULL,NULL,10000000,333,333,333,NULL,@alphaItemShop);


DECLARE @paintName varchar(100);
DECLARE @paintColor varchar(50);
DECLARE @tierType int;
DECLARE @techLevel int;
DECLARE	@nicPrice int; 
DECLARE	@asiToken int;
DECLARE	@icsToken int;
DECLARE	@tmToken int;
DECLARE	@uniToken int;
DECLARE	@itemshopPresetID int;


DECLARE @paintDef int;


DECLARE db_cursor CURSOR FOR 
SELECT paintName,paintColor,tierType,techLevel,nicPrice, asiToken,tmToken,icsToken,uniToken,itemshopPresetID  
FROM #PAINTS


OPEN db_cursor  
FETCH NEXT FROM db_cursor INTO  @paintName,@paintColor,@tierType,@techLevel,@nicPrice,@asiToken,@tmToken,@icsToken,@uniToken,@itemshopPresetID

WHILE @@FETCH_STATUS = 0  
BEGIN  

	SET @paintDef = (SELECT TOP 1 definition from entitydefaults where definitionname=@paintName);

	--Set paint cost on alpha to nicPrice
	UPDATE [dbo].[itemshop]
	SET credit = @nicPrice, tmcoin=NULL, icscoin=NULL, asicoin=NULL, unicoin=NULL
	WHERE targetdefinition=@paintDef AND presetid=@alphaItemShop

	--Set paint to correct token amounts and NULL nic on non-alpha shops
	UPDATE [dbo].[itemshop]
	SET tmcoin=@tmToken, icscoin=@icsToken, asicoin=@asiToken, credit=NULL, unicoin=NULL
	WHERE targetdefinition=@paintDef AND presetid!=@alphaItemShop
		
    FETCH NEXT FROM db_cursor INTO  @paintName,@paintColor,@tierType,@techLevel,@nicPrice,@asiToken,@tmToken,@icsToken,@uniToken,@itemshopPresetID
END 

CLOSE db_cursor  
DEALLOCATE db_cursor

DROP TABLE #PAINTS

GO