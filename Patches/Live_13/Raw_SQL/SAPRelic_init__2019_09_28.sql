USE [perpetuumsa]
GO

-------------------------------------------------------
--New Relic Definition for SAP Relics
--
--Date modified: 2019/09/28
-------------------------------------------------------

PRINT N'SAPRelic EntityDefault for server unit creation';

INSERT INTO [dbo].[entitydefaults]
           ([definitionname],[quantity],[attributeflags],[categoryflags],[options],[note],[enabled],[volume],[mass],[hidden],[health],[descriptiontoken],[purchasable],[tiertype],[tierlevel])
     VALUES
           ('def_relic_sap',1,1024,0 ,NULL,'SAP Relic',1,1,1,0,100,NULL,0,NULL,NULL);
GO

PRINT N'SAPRelic Definition - Add absurd masking';
DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_relic_sap' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'stealth_strength' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 99999999);
GO


INSERT INTO [dbo].[relictypes]
           ([name],[raceid],[level],[ep])
     VALUES
           ('sap_relic_basetype', 0, 0, 50);
GO

DECLARE @sapRelicType int;
SET @sapRelicType = (SELECT TOP 1 id FROM relictypes WHERE name='sap_relic_basetype');


INSERT INTO [dbo].[relicloot]
           ([definition],[minquantity],[maxquantity],[chance],[relictypeid],[packed])
SELECT [definition],[minquantity],[maxquantity],[chance],@sapRelicType,[packed] FROM relicloot
WHERE [relictypeid]=(SELECT TOP 1 id FROM relictypes WHERE name='relic_level1_neutral_beta1');
GO