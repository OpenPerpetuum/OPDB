USE [master]
GO

/*
###################################################################################################
Note: Creates dbtools database for handling processes for managing the main game db

TODO: add db file path selection
###################################################################################################
*/

IF EXISTS(select * from sys.databases where name='perpdbtools')
BEGIN
ALTER DATABASE perpdbtools
SET SINGLE_USER WITH
ROLLBACK IMMEDIATE

DROP DATABASE perpdbtools
END

IF NOT EXISTS(select * from sys.databases where name='perpdbtools')
BEGIN
	CREATE DATABASE [perpdbtools]
	 CONTAINMENT = NONE
	 ON  PRIMARY 
	( NAME = N'perpdbtools', FILENAME = N'C:\PerpetuumServer\data\database\perpdbtools.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
	 LOG ON 
	( NAME = N'perpdbtools_log', FILENAME = N'C:\PerpetuumServer\data\database\perpdbtools_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
END
GO

IF NOT EXISTS(select * from sys.databases where name='perpdbtools')
BEGIN
	ALTER DATABASE [perpdbtools] SET ANSI_NULL_DEFAULT OFF 
	ALTER DATABASE [perpdbtools] SET ANSI_NULLS OFF 
	ALTER DATABASE [perpdbtools] SET ANSI_PADDING OFF 
	ALTER DATABASE [perpdbtools] SET ANSI_WARNINGS OFF 
	ALTER DATABASE [perpdbtools] SET ARITHABORT OFF 
	ALTER DATABASE [perpdbtools] SET AUTO_CLOSE OFF 
	ALTER DATABASE [perpdbtools] SET AUTO_SHRINK OFF 
	ALTER DATABASE [perpdbtools] SET AUTO_UPDATE_STATISTICS ON 
	ALTER DATABASE [perpdbtools] SET CURSOR_CLOSE_ON_COMMIT OFF 
	ALTER DATABASE [perpdbtools] SET CURSOR_DEFAULT  GLOBAL 
	ALTER DATABASE [perpdbtools] SET CONCAT_NULL_YIELDS_NULL OFF 
	ALTER DATABASE [perpdbtools] SET NUMERIC_ROUNDABORT OFF 
	ALTER DATABASE [perpdbtools] SET QUOTED_IDENTIFIER OFF 
	ALTER DATABASE [perpdbtools] SET RECURSIVE_TRIGGERS OFF 
	ALTER DATABASE [perpdbtools] SET  DISABLE_BROKER 
	ALTER DATABASE [perpdbtools] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
	ALTER DATABASE [perpdbtools] SET DATE_CORRELATION_OPTIMIZATION OFF 
	ALTER DATABASE [perpdbtools] SET TRUSTWORTHY OFF 
	ALTER DATABASE [perpdbtools] SET ALLOW_SNAPSHOT_ISOLATION OFF 
	ALTER DATABASE [perpdbtools] SET PARAMETERIZATION SIMPLE 
	ALTER DATABASE [perpdbtools] SET READ_COMMITTED_SNAPSHOT OFF 
	ALTER DATABASE [perpdbtools] SET HONOR_BROKER_PRIORITY OFF 
	ALTER DATABASE [perpdbtools] SET RECOVERY SIMPLE 
	ALTER DATABASE [perpdbtools] SET  MULTI_USER 
	ALTER DATABASE [perpdbtools] SET PAGE_VERIFY CHECKSUM  
	ALTER DATABASE [perpdbtools] SET DB_CHAINING OFF 
	ALTER DATABASE [perpdbtools] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
	ALTER DATABASE [perpdbtools] SET TARGET_RECOVERY_TIME = 60 SECONDS 
	ALTER DATABASE [perpdbtools] SET DELAYED_DURABILITY = DISABLED 
	ALTER DATABASE [perpdbtools] SET QUERY_STORE = OFF
END
GO




IF NOT EXISTS(select * from sys.databases where name='perpdbtools')
BEGIN
	USE [perpdbtools]

	ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
	ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
	ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
	ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
	ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
	ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
	ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
	ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
	ALTER DATABASE [perpdbtools] SET  READ_WRITE
END
GO

USE [perpdbtools]
GO

IF OBJECT_ID('[dbo].[restore_perpetuumsa]') IS NOT NULL DROP PROCEDURE [dbo].[restore_perpetuumsa]
IF OBJECT_ID('[dbo].[backup_server_data]') IS NOT NULL DROP PROCEDURE [dbo].[backup_server_data]
IF OBJECT_ID('[dbo].[restore_server_data]') IS NOT NULL DROP PROCEDURE [dbo].[restore_server_data]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[restore_perpetuumsa]

@backuppath			varchar(max)	= 'C:\PerpetuumServer\data\database\',
@backup_filename	varchar(max)	= 'perpetuumsa.bak',
@dbpath				varchar(max)	= 'C:\PerpetuumServer\data\database\'

AS
BEGIN

	SET NOCOUNT ON

	DECLARE 
		@backup_full_path	VARCHAR(MAX),
		@mdf_full_path		VARCHAR(MAX),
		@ldf_full_path		VARCHAR(MAX)


	SET @backup_full_path = @backuppath + @backup_filename
	SET @mdf_full_path = @dbpath + 'psa.mdf'
	SET @ldf_full_path = @dbpath + 'psa_log.mdf'

	ALTER DATABASE perpetuumsa
	SET SINGLE_USER WITH
	ROLLBACK IMMEDIATE

	

	RESTORE DATABASE perpetuumsa FROM DISK = @backup_full_path WITH 
	MOVE 'perpetuumsa' TO @mdf_full_path,
	MOVE 'perpetuumsa_log' TO @ldf_full_path, REPLACE

	ALTER DATABASE perpetuumsa SET MULTI_USER

END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[backup_server_data]

AS
BEGIN

--TODO: standings
--TODO: full corp - tech tree storage etc

IF OBJECT_ID('[dbo].[accounts]') IS NOT NULL DROP TABLE [dbo].[accounts]
IF OBJECT_ID('[dbo].[accountonlinetime]') IS NOT NULL DROP TABLE [dbo].[accountonlinetime]
IF OBJECT_ID('[dbo].[accountextensionspent]') IS NOT NULL DROP TABLE [dbo].[accountextensionspent]
IF OBJECT_ID('[dbo].[characterextensions]') IS NOT NULL DROP TABLE [dbo].[characterextensions]
IF OBJECT_ID('[dbo].[characterhighscore]') IS NOT NULL DROP TABLE [dbo].[characterhighscore]
IF OBJECT_ID('[dbo].[characterkillreports]') IS NOT NULL DROP TABLE [dbo].[characterkillreports]
IF OBJECT_ID('[dbo].[characters]') IS NOT NULL DROP TABLE [dbo].[characters]
IF OBJECT_ID('[dbo].[charactersettings]') IS NOT NULL DROP TABLE [dbo].[charactersettings]
IF OBJECT_ID('[dbo].[charactersparks]') IS NOT NULL DROP TABLE [dbo].[charactersparks]
IF OBJECT_ID('[dbo].[corporationmembers]') IS NOT NULL DROP TABLE [dbo].[corporationmembers]
IF OBJECT_ID('[dbo].[corporations]') IS NOT NULL DROP TABLE [dbo].[corporations]
IF OBJECT_ID('[dbo].[entities]') IS NOT NULL DROP TABLE [dbo].[entities]
IF OBJECT_ID('[dbo].[epforactivitylog]') IS NOT NULL DROP TABLE [dbo].[epforactivitylog]
IF OBJECT_ID('[dbo].[extensionpoints]') IS NOT NULL DROP TABLE [dbo].[extensionpoints]
IF OBJECT_ID('[dbo].[serverinfo]') IS NOT NULL DROP TABLE [dbo].[serverinfo]
--IF OBJECT_ID('[dbo].') IS NOT NULL DROP TABLE [dbo].

SELECT * INTO [dbo].[accounts] FROM [perpetuumsa].[dbo].[accounts]
SELECT * INTO [dbo].[accountonlinetime] FROM [perpetuumsa].[dbo].[accountonlinetime]
SELECT * INTO [dbo].[accountextensionspent] FROM [perpetuumsa].[dbo].[accountextensionspent]
SELECT * INTO [dbo].[characterextensions] FROM [perpetuumsa].[dbo].[characterextensions]
SELECT * INTO [dbo].[characterhighscore] FROM [perpetuumsa].[dbo].[characterhighscore]
SELECT * INTO [dbo].[characterkillreports] FROM [perpetuumsa].[dbo].[characterkillreports]
SELECT * INTO [dbo].[characters] FROM [perpetuumsa].[dbo].[characters]
SELECT * INTO [dbo].[charactersettings] FROM [perpetuumsa].[dbo].[charactersettings]
SELECT * INTO [dbo].[charactersparks] FROM [perpetuumsa].[dbo].[charactersparks]
SELECT * INTO [dbo].[corporationmembers] FROM [perpetuumsa].[dbo].[corporationmembers]
SELECT * INTO [dbo].[corporations] FROM [perpetuumsa].[dbo].[corporations] WHERE defaultcorp <> 1
SELECT * INTO [dbo].[entities] FROM [perpetuumsa].[dbo].[entities] WHERE [owner] IN (SELECT rootEID FROM [perpetuumsa].[dbo].[characters])
SELECT * INTO [dbo].[epforactivitylog] FROM [perpetuumsa].[dbo].[epforactivitylog]
SELECT * INTO [dbo].[extensionpoints] FROM [perpetuumsa].[dbo].[extensionpoints] WHERE [accountid] IN (SELECT accountID FROM [perpetuumsa].[dbo].[accounts]) -- no identity insert
SELECT * INTO [dbo].[serverinfo] FROM [perpetuumsa].[dbo].[serverinfo]

END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[restore_server_data]

AS
BEGIN

--TODO: Restore Morethan just account info options

SET IDENTITY_INSERT [perpetuumsa].[dbo].[accounts] ON

INSERT [perpetuumsa].[dbo].[accounts]
	(
	[accountID],
	[email],
	[password],
	[firstName],
	[lastName],
	[born],
	[state],
	[accLevel],
	[totalMinsOnline],
	[lastLoggedIn],
	[creation],
	[clientType],
	[isLoggedIn],
	[bantime],
	[banlength],
	[bannote],
	[emailConfirmed],
	[firstcharacter],
	[note],
	[steamID],
	[twitchAuthToken],
	[credit],
	[isactive],
	[resetcount],
	[wasreset],
	[validUntil],
	[payingcustomer],
	[campaignid]
	) 
SELECT	
	[accountID],
	[email],
	[password],
	[firstName],
	[lastName],
	[born],
	[state],
	[accLevel],
	[totalMinsOnline],
	[lastLoggedIn],
	[creation],
	[clientType],
	[isLoggedIn],
	[bantime],
	[banlength],
	[bannote],
	[emailConfirmed],
	[firstcharacter],
	[note],
	[steamID],
	[twitchAuthToken],
	[credit],
	[isactive],
	[resetcount],
	[wasreset],
	[validUntil],
	[payingcustomer],
	[campaignid]	
FROM
	[dbo].[accounts]
WHERE
	[accounts].[email] <> 'ADMIN'

SET IDENTITY_INSERT [perpetuumsa].[dbo].[accounts] OFF


UPDATE [perpetuumsa].[dbo].[accounts]
SET
	[password] = (SELECT [password] FROM [dbo].[accounts] WHERE [accounts].[email] = 'ADMIN')
WHERE
	[accounts].[email] = 'ADMIN'


UPDATE [perpetuumsa].[dbo].[serverinfo]
SET
	[name] = (SELECT [name] FROM [dbo].[serverinfo]),
	[description] = (SELECT [description] FROM [dbo].[serverinfo]),
	[contact] = (SELECT [contact] FROM [dbo].[serverinfo]),
	[isopen] = (SELECT [isopen] FROM [dbo].[serverinfo]),
	[isbroadcast] = (SELECT [isbroadcast] FROM [dbo].[serverinfo])


END
GO

