USE [perpetuumsa]
GO

--------------------------------
--Syndicate rebalance and bug fixin
--Helix Slope capability 51->56
--All Syndicate Masses increased
--Masking +10 on helix and locust
--
--Date Modified: 2019/08/29
---------------------------------


DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;


----Helix Leg Slope Capability----
PRINT N'Helix Leg incr Slope 5->6';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_helix_leg' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'slope' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET
value=6 
WHERE id = @aggvalueID;


----Helix Chassis Mass----
PRINT N'Helix Chassis Mass 4000->5000';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_helix_chassis' ORDER BY definition DESC);

UPDATE entitydefaults SET 
mass=5000 
WHERE definition=@definitionID;


--Helix Signal Masking Increase
PRINT N'Helix Masking incr 120->130';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_helix_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'stealth_strength' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET 
value=130 
WHERE id = @aggvalueID;

----Vektor Mass Incr 5000->6000------
PRINT N'Vektor Mass Incr 5000->6000';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_vektor_chassis' ORDER BY definition DESC);

UPDATE entitydefaults SET
 mass=6000
 WHERE definition=@definitionID;


--Locust Signal Masking Increase 
PRINT N'Locust Masking incr 110->120';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_locust_head' ORDER BY definition DESC);
SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'stealth_strength' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);

UPDATE aggregatevalues SET 
value=120 
WHERE id = @aggvalueID;

--Locust Mass Incr 
PRINT N'Locust Mass incr 9000->11000';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_locust_chassis' ORDER BY definition DESC);

UPDATE entitydefaults SET
 mass=11000 
 WHERE definition=@definitionID;


---Echelon Mass Incr
PRINT N'Echelon Mass incr 21000->24000';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_echelon_chassis' ORDER BY definition DESC);

UPDATE entitydefaults SET 
mass=24000 
WHERE definition=@definitionID;


--Callisto Mass Incr
PRINT N'Echelon Mass incr 12k->14k';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_callisto_chassis' ORDER BY definition DESC);

UPDATE entitydefaults SET
  mass=14000 
  WHERE definition=@definitionID;

--Legatus Mass Incr
PRINT N'Echelon Mass incr 25k->30k';
SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_legatus_chassis' ORDER BY definition DESC);

UPDATE entitydefaults SET 
mass=30000 
WHERE definition=@definitionID;


GO