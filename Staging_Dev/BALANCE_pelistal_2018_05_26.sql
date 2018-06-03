USE [perpetuumsa]
GO


----Pelistal Balance----


---Increase Small Missles +30 meters
PRINT N'Increase Small Missles +30 meters';
DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;
PRINT N'def_ammo_rocket_a';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_rocket_a' ORDER BY definition DESC);

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'optimal_range' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=18 WHERE id =  @aggvalueID;

PRINT N'def_ammo_rocket_b';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_rocket_b' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=18 WHERE id =  @aggvalueID;

PRINT N'def_ammo_rocket_c';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_rocket_c' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=18 WHERE id =  @aggvalueID;

PRINT N'def_ammo_rocket_d';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_rocket_d' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=18 WHERE id =  @aggvalueID;

PRINT N'def_ammo_rocket_rewa';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_rocket_rewa' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=18 WHERE id =  @aggvalueID;

PRINT N'def_ammo_rocket_rewb';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_rocket_rewb' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=21 WHERE id =  @aggvalueID;



----Waspish Accumulator increase by 15%
PRINT N'Waspish Accumulator increase by 15%';

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_waspish_chassis' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'core_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=483 WHERE id =  @aggvalueID;



---Pelistal CPU 10% increase
PRINT N'Pelistal CPU 10% increase';

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_castel_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_max' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);
UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=204 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_castel_head_pr' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=209 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_gropho_head' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=418 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_gropho_head_pr' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=429 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_troiar_head' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=220 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_troiar_head_pr' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=226 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_tyrannos_head' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=330 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_tyrannos_head_pr' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=341 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_waspish_head' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=275 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_waspish_head_pr' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=281 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ictus_head' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=495 WHERE id =  @aggvalueID;


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ictus_head_pr' ORDER BY definition DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=506 WHERE id =  @aggvalueID;

GO