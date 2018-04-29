USE [perpetuumsa]
GO


----------Shield cycle time adjust to match missiles------

PRINT N'Shield cycle time adjust to match missiles';

DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;


--T0 small
PRINT N'def_artifact_damaged_small_shield_generator';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_damaged_small_shield_generator' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cycle_time' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=3000 WHERE id =  @aggvalueID;


--t1 small
PRINT N'def_standard_small_shield_generator';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_shield_generator' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2750 WHERE id =  @aggvalueID;


--t2 small
PRINT N'def_named1_small_shield_generator';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_shield_generator' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2500 WHERE id =  @aggvalueID;


--t2p small
PRINT N'def_named1_small_shield_generator';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_shield_generator_pr' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2500 WHERE id =  @aggvalueID;


-- T3- small
PRINT N'def_artifact_a_small_shield_generator';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_small_shield_generator' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2375 WHERE id =  @aggvalueID;


--t3 small
PRINT N'def_named1_small_shield_generator';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_small_shield_generator' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2250 WHERE id =  @aggvalueID;


--t3p small
PRINT N'def_named1_small_shield_generator';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_small_shield_generator_pr' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2250 WHERE id =  @aggvalueID;


--t4 small
PRINT N'def_named1_small_shield_generator';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_small_shield_generator' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2000 WHERE id =  @aggvalueID;


--t4p small
PRINT N'def_named1_small_shield_generator';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_small_shield_generator_pr' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=2000 WHERE id =  @aggvalueID;



---Mediums

--t0
PRINT N'def_artifact_a_medium_shield_generator';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_a_medium_shield_generator' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=12000 WHERE id =  @aggvalueID;


--t1
PRINT N'def_standard_medium_shield_generator';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_shield_generator' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=10000 WHERE id =  @aggvalueID;


--t2
PRINT N'def_named1_medium_shield_generator';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_shield_generator' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=9500 WHERE id =  @aggvalueID;


--t2p
PRINT N'def_named1_medium_shield_generator_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_shield_generator_pr' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=9500 WHERE id =  @aggvalueID;


-- t3-
PRINT N'def_artifact_damaged_medium_shield_generator';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_artifact_damaged_medium_shield_generator' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=8500 WHERE id =  @aggvalueID;


--t3
PRINT N'def_named2_medium_shield_generator';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_shield_generator' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=7750 WHERE id =  @aggvalueID;

--t3p
PRINT N'def_named2_medium_shield_generator_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_shield_generator_pr' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=7750 WHERE id =  @aggvalueID;


--t4
PRINT N'def_named3_medium_shield_generator';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_shield_generator' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=6500 WHERE id =  @aggvalueID;


--t4p
PRINT N'def_named3_medium_shield_generator_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_shield_generator_pr' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=6500 WHERE id =  @aggvalueID;


GO