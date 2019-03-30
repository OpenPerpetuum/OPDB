USE [perpetuumsa]
GO

--------------------------------------------
--New Module: The Blinder
--Not purchasable, targetpainter category item
--INSERT entitydefaults, aggregatevalues
--Date: 2019/03/30
--------------------------------------------

--Insert the Blinder definition - a targetpainter category item, not purchasable
PRINT N'entitydefaults INSERT The Blinder';
INSERT INTO entitydefaults ( definitionname ,  quantity ,  attributeflags ,  categoryflags ,  options ,  note ,  enabled ,  volume ,  mass ,  hidden , 
                health ,  descriptiontoken ,  purchasable ,  tiertype ,  tierlevel ) 
                VALUES ( 'def_standard_blinder', 1, 720, 721935, '#moduleFlag=i8#tier=$tierlevel_t1', 'THE BLINDER', 1, 0.5, 500, 0, 100, 'def_standard_target_painter_desc', 0, 1, 1); 
GO


--Set the module stats, of note: range, and detection strength modifier
PRINT N'aggregatevalues INSERT Blinder stats';
DECLARE @definitionID int;
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_blinder' ORDER BY definition DESC);


DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 25);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 55);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cycle_time' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 10000);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'optimal_range' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 25);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_usage' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 20);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'effect_detection_strength_modifier' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, -120);

GO



