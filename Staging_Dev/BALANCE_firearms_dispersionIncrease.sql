USE [perpetuumsa]
GO


-----------Firearm dispersion increase----------
------smalls 5.5->6
------med 14.5->17
------med 15->18

DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;

PRINT N'def_standard_small_autocannon';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_small_autocannon' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=6 WHERE id =  @aggvalueID;

PRINT N'def_standard_medium_autocannon';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_standard_medium_autocannon' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=17 WHERE id =  @aggvalueID;

PRINT N'def_named1_small_autocannon';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_autocannon' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=6 WHERE id =  @aggvalueID;

PRINT N'def_named2_small_autocannon';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_small_autocannon' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=6 WHERE id =  @aggvalueID;

PRINT N'def_named3_small_autocannon';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_small_autocannon' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=6 WHERE id =  @aggvalueID;

PRINT N'def_named1_medium_autocannon';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_autocannon' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=17 WHERE id =  @aggvalueID;

PRINT N'def_named2_medium_autocannon';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_autocannon' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=17 WHERE id =  @aggvalueID;

PRINT N'def_named3_medium_autocannon';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_autocannon' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=17 WHERE id =  @aggvalueID;

PRINT N'def_longrange_standard_medium_autocannon';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_longrange_standard_medium_autocannon' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=18 WHERE id =  @aggvalueID;

PRINT N'def_named1_longrange_medium_autocannon';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_longrange_medium_autocannon' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=18 WHERE id =  @aggvalueID;

PRINT N'def_named2_longrange_medium_autocannon';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_longrange_medium_autocannon' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=18 WHERE id =  @aggvalueID;

PRINT N'def_named3_longrange_medium_autocannon';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_longrange_medium_autocannon' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=18 WHERE id =  @aggvalueID;

PRINT N'PROTOTYPES';


PRINT N'def_named1_small_autocannon_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_small_autocannon_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=6 WHERE id =  @aggvalueID;

PRINT N'def_named2_small_autocannon_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_small_autocannon_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=6 WHERE id =  @aggvalueID;

PRINT N'def_named3_small_autocannon_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_small_autocannon_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=6 WHERE id =  @aggvalueID;

PRINT N'def_named1_medium_autocannon_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_medium_autocannon_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=17 WHERE id =  @aggvalueID;

PRINT N'def_named2_medium_autocannon_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_medium_autocannon_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=17 WHERE id =  @aggvalueID;

PRINT N'def_named3_medium_autocannon_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_medium_autocannon_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=17 WHERE id =  @aggvalueID;

PRINT N'def_named1_longrange_medium_autocannon_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named1_longrange_medium_autocannon_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=18 WHERE id =  @aggvalueID;

PRINT N'def_named2_longrange_medium_autocannon_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named2_longrange_medium_autocannon_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=18 WHERE id =  @aggvalueID;

PRINT N'def_named3_longrange_medium_autocannon_pr';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_named3_longrange_medium_autocannon_pr' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'accuracy' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=18 WHERE id =  @aggvalueID;


GO