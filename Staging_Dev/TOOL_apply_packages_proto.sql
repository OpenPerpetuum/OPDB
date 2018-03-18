USE [perpetuumsa]
GO

DECLARE @accountid INT;
DECLARE @packid INT;

--NOTE: you may want to do this differently!
--Select from table that has CORRECT accounts for the package they are to recieve
DECLARE curs CURSOR LOCAL FAST_FORWARD FOR SELECT [accountID] FROM accounts; --<<FIX accounts to-??? proper table from pre-alpha

SET @packid = (SELECT TOP 1 id FROM packages WHERE name='pre-alpha01');--<<set this to proper package name for given table of accounts
--SET @packid = (SELECT TOP 1 id FROM packages WHERE name='pre-alpha02');--<<the other package for active participants

OPEN curs

FETCH NEXT FROM curs INTO @accountid

WHILE @@FETCH_STATUS = 0 BEGIN
    EXEC dbo.accountPackageBought  @accountid, @packid; --logs the package and account
	EXEC dbo.accountPackageProcessOne @accountid, @packid; --puts items in set of redeemables for account to claim in-game
    FETCH NEXT FROM curs INTO @accountid;
END

CLOSE curs;
DEALLOCATE curs;