USE [perpetuumsa]
GO


----------------------------
--Content Team: Balance Tile Scanner charge ranges
--Date: 3/2/2019
----------------------------


DECLARE @definitionID int;
DECLARE @aggvalueID int;
DECLARE @aggfieldID int;


---Increase HDT Advanced Tile to 300M radius

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_mining_probe_crude_tile_rewa' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_ammo_mining_probe_crude_tile_rewa', quantity=1000, attributeflags=2048, categoryflags=133386, options='#mineral=$crude
#type=n1
', 
                note='', enabled=1, volume=0.5, mass=0.1, hidden=0, health=100, descriptiontoken='def_ammo_mining_probe_crude_tile_rewa_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'tile_based_mining_probe_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);



UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=30 WHERE id =  @aggvalueID;

---Increase Epi Advanced Tile to 300M radius

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_mining_probe_epriton_tile_rewa' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_ammo_mining_probe_epriton_tile_rewa', quantity=1000, attributeflags=2048, categoryflags=133386, options='#mineral=$epriton
#type=n1
', 
                note='', enabled=1, volume=0.5, mass=0.1, hidden=0, health=100, descriptiontoken='def_ammo_mining_probe_epriton_tile_rewa_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'tile_based_mining_probe_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=30 WHERE id =  @aggvalueID;

---Increase Imentium Advanced Tile to 300M radius


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_mining_probe_imentium_tile_rewa' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_ammo_mining_probe_imentium_tile_rewa', quantity=1000, attributeflags=2048, categoryflags=133386, options='#mineral=$imentium
#type=n1
', 
                note='', enabled=1, volume=0.5, mass=0.1, hidden=0, health=100, descriptiontoken='def_ammo_mining_probe_imentium_tile_rewa_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'tile_based_mining_probe_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=30 WHERE id =  @aggvalueID;


---Increase liquizit Advanced Tile to 300M radius

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_mining_probe_liquizit_tile_rewa' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_ammo_mining_probe_liquizit_tile_rewa', quantity=1000, attributeflags=2048, categoryflags=133386, options='#mineral=$liquizit
#type=n1
', 
                note='', enabled=1, volume=0.5, mass=0.1, hidden=0, health=100, descriptiontoken='def_ammo_mining_probe_liquizit_tile_rewa_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'tile_based_mining_probe_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=30 WHERE id =  @aggvalueID;

---Increase Silgium regular Tile to 100M radius


SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_mining_probe_silgium_tile' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_ammo_mining_probe_silgium_tile', quantity=1000, attributeflags=2048, categoryflags=133386, options='#mineral=$silgium
#type=n1
', 
                note='per tile scannel', enabled=1, volume=0.5, mass=0.1, hidden=0, health=100, descriptiontoken='def_ammo_mining_probe_tile_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'tile_based_mining_probe_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 10);

---Increase Stermonit Advanced Tile to 300M radius

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_mining_probe_stermonit_tile_rewa' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_ammo_mining_probe_stermonit_tile_rewa', quantity=1000, attributeflags=2048, categoryflags=133386, options='#mineral=$stermonit
#type=n1
', 
                note='', enabled=1, volume=0.5, mass=0.1, hidden=0, health=100, descriptiontoken='def_ammo_mining_probe_stermonit_tile_rewa_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;


SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'tile_based_mining_probe_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=30 WHERE id =  @aggvalueID;

---Increase Titan Advanced Tile to 300M radius

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_mining_probe_titan_tile_rewa' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_ammo_mining_probe_titan_tile_rewa', quantity=1000, attributeflags=2048, categoryflags=133386, options='#mineral=$titan
#type=n1
', 
                note='', enabled=1, volume=0.5, mass=0.1, hidden=0, health=100, descriptiontoken='def_ammo_mining_probe_titan_tile_rewa_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'tile_based_mining_probe_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


UPDATE aggregatevalues SET definition=@definitionID, field=@aggfieldID, value=30 WHERE id =  @aggvalueID;

---Increase Silgium Advanced Tile to 300M radius

SET @definitionID = (SELECT TOP 1 definition from entitydefaults WHERE [definitionname] = 'def_ammo_mining_probe_silgium_tile_rewa' ORDER BY definition DESC);

UPDATE entitydefaults Set definitionname='def_ammo_mining_probe_silgium_tile_rewa', quantity=1000, attributeflags=2048, categoryflags=133386, options='#mineral=$silgium
#type=n1
', 
                note='', enabled=1, volume=0.5, mass=0.1, hidden=0, health=100, descriptiontoken='def_ammo_mining_probe_silgium_tile_rewa_desc', purchasable=1, tiertype=0, 
                tierlevel=0 where definition=@definitionID;

SET @aggfieldID = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'tile_based_mining_probe_radius' ORDER BY [name] DESC);
SET @aggvalueID = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = @definitionID AND [field]=@aggfieldID ORDER BY definition DESC);


INSERT INTO [dbo].[aggregatevalues] ([definition],[field],[value]) VALUES (@definitionID, @aggfieldID, 30);

GO