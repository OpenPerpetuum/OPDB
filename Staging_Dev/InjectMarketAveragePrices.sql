PRINT N'INJECT MARKET AVERAGE PRICES';
--Notes:
--This will seed the dbo.marketaverageprices table with the necesary data to do averaging
--for any item of any commodity or material composition to be repaired
--The price average is determined by TOTAL-QUANTITY/TOTAL-PRICE
--The current configuration of this script simply seeds everything at 1 nic
--This, with other dynamic market amounts, may help stabilize repair pricing

--Seed the Past 2 weeks for full averaging computation
DECLARE @StartDate AS DATETIME
DECLARE @EndDate AS DATETIME
DECLARE @CurrentDate AS DATETIME

SET @StartDate = CAST(CONVERT(VARCHAR(20), GETDATE()-15, 112) + ' 08:00:00' AS DATETIME);
SET @EndDate = GETDATE()
SET @CurrentDate = @StartDate

--Set ENDDATE arbitrarily far in the future-- ensure future repair cost stability?

DECLARE @market_eid BIGINT
DECLARE @market_cursor CURSOR

--Grab ALL NPC held stations, and their markets
SET @market_cursor = CURSOR FOR
SELECT eid FROM entities
WHERE definition=10 and (owner=2401 or owner=5128 or owner=5129);



DECLARE @def INT
DECLARE @def_cursor CURSOR

--Loop over ALL materials and commodities
SET @def_cursor = CURSOR FOR
SELECT definition from entitydefaults
WHERE (categoryflags & 65535)=276
UNION
SELECT definition from entitydefaults
WHERE (categoryflags & 65535)=532;

OPEN @market_cursor
FETCH NEXT
FROM @market_cursor INTO @market_eid

DECLARE @market_fetch_status INT;
DECLARE @def_fetch_status INT;

SET @def_fetch_status = @@FETCH_STATUS;
SET @market_fetch_status = @@FETCH_STATUS;

--Loop over all Markets
WHILE @market_fetch_status = 0
BEGIN

	OPEN @def_cursor
	FETCH NEXT
	FROM @def_cursor INTO @def
	SET @def_fetch_status = @@FETCH_STATUS;
	--Loop over all Materials and commodities
	WHILE @def_fetch_status = 0
	BEGIN
		--Loop over days in daterange
		WHILE (@CurrentDate <= @EndDate)
		BEGIN
			--Insert average price for itemdefinition, totalprice, totalquantity, at Date
			EXEC dbo.insertAveragePrice @market_eid, @def, 1666, 1666, @CurrentDate;
			SET @CurrentDate = convert(varchar(30), dateadd(day,1, @CurrentDate), 101);
		END
		SET @CurrentDate = @StartDate

		FETCH NEXT
		FROM @def_cursor INTO @def
		SET @def_fetch_status = @@FETCH_STATUS;

	END

	CLOSE @def_cursor
	

	FETCH NEXT
	FROM @market_cursor INTO @market_eid
	SET @market_fetch_status = @@FETCH_STATUS;
END

CLOSE @market_cursor
DEALLOCATE @market_cursor
DEALLOCATE @def_cursor
