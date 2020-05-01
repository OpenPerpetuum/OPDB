USE [perpetuumsa]
GO
-----
--Insert entitydef geoscandocument
--Insert entitydef mineral
--Insert mineral
--Insert mineralconfigs for zones
--Insert scanner ammos
--Insert mining ammo
--Insert production and research for mining ammo TODO
--geoscanner results show def_<unknown_16>..TODO




PRINT N'ADD/UPDATE def_geoscan_document_fluxore ON entitydefaults';
IF EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_geoscan_document_fluxore')
BEGIN
	UPDATE entitydefaults SET
		definitionname = 'def_geoscan_document_fluxore',
		quantity = 1,
		attributeflags = 2048,
		categoryflags = 1685,
		options = '',
		note = '',
		enabled = 1,
		volume = 0.1,
		mass = 0.1,
		hidden = 0,
		health = 100,
		descriptiontoken = 'def_geoscan_document_desc',
		purchasable = 0,
		tiertype = NULL,
		tierlevel = NULL
	WHERE definitionname = 'def_geoscan_document_fluxore';
END
ELSE
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
	VALUES 
	('def_geoscan_document_fluxore', 1, 2048, 1685, '', '', 1, 0.1, 0.1, 0, 100, 'def_geoscan_document_desc', 0, NULL, NULL); 
END

PRINT N'ADD/UPDATE def_fluxore ON entitydefaults';
IF EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_fluxore')
BEGIN
	UPDATE entitydefaults SET
		definitionname = 'def_fluxore',
		quantity = 1,
		attributeflags = 2048,
		categoryflags = 131348,
		options = '',
		note = '',
		enabled = 1,
		volume = 0.0001,
		mass = 0.01,
		hidden = 0,
		health = 100,
		descriptiontoken = 'def_fluxore_desc',
		purchasable = 1,
		tiertype = NULL,
		tierlevel = NULL
	WHERE definitionname = 'def_fluxore';
END
ELSE
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
	VALUES 
	('def_fluxore', 1, 2048, 131348, '', '', 1, 0.0001, 0.01, 0, 100, 'def_fluxore_desc', 0, NULL, NULL); 
END


PRINT N'ADD/UPDATE fluxore ON minerals';
IF EXISTS (SELECT TOP 1 idx FROM minerals WHERE name='fluxore')
BEGIN
	UPDATE minerals SET
		idx = 16,
		name = 'fluxore',
		definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_fluxore'),
		amount = 100,
		extractionType = 0,
		enablereffectrequired = 0,
		note = 'flux ore',
		geoscandocument = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_geoscan_document_fluxore')
	WHERE name='fluxore';
END
ELSE
BEGIN
	INSERT INTO minerals (idx, name, definition, amount, extractionType, enablereffectrequired, note, geoscandocument) VALUES
	(16, 'fluxore', (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_fluxore'), 100, 0, 0, 'flux ore', (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_geoscan_document_fluxore'));
END


PRINT N'ADD/UPDATE def_ammo_mining_probe_fluxore_tile ON entitydefaults';
IF EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_mining_probe_fluxore_tile')
BEGIN
	UPDATE entitydefaults SET
		definitionname = 'def_ammo_mining_probe_fluxore_tile',
		quantity = 1000,
		attributeflags = 2048,
		categoryflags = 133386,
		options = '#mineral=$fluxore #type=n1',
		note = '',
		enabled = 1,
		volume = 0.5,
		mass = 0.1,
		hidden = 0,
		health = 100,
		descriptiontoken = 'def_ammo_mining_probe_tile_desc',
		purchasable = 1,
		tiertype = NULL,
		tierlevel = NULL
	WHERE definitionname = 'def_ammo_mining_probe_fluxore_tile';
END
ELSE
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
	VALUES 
	('def_ammo_mining_probe_fluxore_tile', 1000, 2048, 133386, '#mineral=$fluxore #type=n1', '', 1, 0.5, 0.1, 0, 100, 'def_ammo_mining_probe_tile_desc', 1, NULL, NULL); 
END

PRINT N'DELETE-REINSERT aggregatevalues FOR def_ammo_mining_probe_fluxore_tile';
SELECT * FROM aggregatevalues WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_mining_probe_fluxore_tile');
DELETE FROM aggregatevalues WHERE definition=(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_mining_probe_fluxore_tile');

INSERT INTO aggregatevalues (definition, field, value) 
VALUES
((SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_mining_probe_fluxore_tile'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='tile_based_mining_probe_radius'),
10);


PRINT N'ADD/UPDATE def_ammo_mining_probe_fluxore_direction ON entitydefaults';
IF EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_mining_probe_fluxore_direction')
BEGIN
	UPDATE entitydefaults SET
		definitionname = 'def_ammo_mining_probe_fluxore_direction',
		quantity = 1000,
		attributeflags = 2048,
		categoryflags = 395530,
		options = '#mineral=$fluxore',
		note = '',
		enabled = 1,
		volume = 0.5,
		mass = 0.1,
		hidden = 0,
		health = 100,
		descriptiontoken = 'def_ammo_mining_probe_direction_desc',
		purchasable = 1,
		tiertype = NULL,
		tierlevel = NULL
	WHERE definitionname = 'def_ammo_mining_probe_fluxore_direction';
END
ELSE
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
	VALUES 
	('def_ammo_mining_probe_fluxore_direction', 1000, 2048, 395530, '#mineral=$fluxore', '', 1, 0.5, 0.1, 0, 100, 'def_ammo_mining_probe_direction_desc', 1, NULL, NULL); 
END


PRINT N'ADD/UPDATE def_ammo_mining_fluxore ON entitydefaults';
IF EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_mining_fluxore')
BEGIN
	UPDATE entitydefaults SET
		definitionname = 'def_ammo_mining_fluxore',
		quantity = 1000,
		attributeflags = 2147485696,
		categoryflags = 1290,
		options = 'mineral=$fluxore',
		note = '',
		enabled = 1,
		volume = 0.5,
		mass = 0.1,
		hidden = 0,
		health = 100,
		descriptiontoken = 'def_ammo_mining_desc',
		purchasable = 1,
		tiertype = NULL,
		tierlevel = NULL
	WHERE definitionname = 'def_ammo_mining_fluxore';
END
ELSE
BEGIN
	INSERT INTO entitydefaults (definitionname, quantity, attributeflags, categoryflags, options, note, enabled, volume, mass, hidden, health, descriptiontoken, purchasable, tiertype, tierlevel) 
	VALUES 
	('def_ammo_mining_fluxore', 1000, 2147485696, 1290, 'mineral=$fluxore', '', 1, 0.5, 1, 0, 100, 'def_ammo_mining_desc', 1, NULL, NULL); 
END

SELECT * FROM beamassignment WHERE definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_mining_fluxore');
DELETE FROM beamassignment WHERE definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_mining_fluxore');
INSERT INTO beamassignment (beam, definition) VALUES
((SELECT TOP 1 id FROM beams WHERE name='small_driller'),
(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname='def_ammo_mining_fluxore'));

DROP TABLE IF EXISTS #MINERALCONFS;
CREATE TABLE #MINERALCONFS
(
	zoneName VARCHAR(100),
	materialName VARCHAR(100),
	maxNodes INT,
	maxTilesPerNode INT,
	totalAmountPerNode INT,
	minThreshold FLOAT
);
INSERT INTO #MINERALCONFS (zoneName, materialName, maxNodes, maxTilesPerNode, totalAmountPerNode, minThreshold) VALUES
('norhoop', 'fluxore', 6, 300, 50000000, 0.5),
('domhalarn', 'fluxore', 6, 300, 50000000, 0.5),
('hokkogaros', 'fluxore', 6, 300, 50000000, 0.5),
('alsbale', 'fluxore', 10, 300, 50000000, 0.5),
('novastrov', 'fluxore', 10, 300, 50000000, 0.5),
('kentagura', 'fluxore', 10, 300, 50000000, 0.5);

PRINT N'UPDATE/INSERT mineralconfigs for fluxore';
MERGE [dbo].[mineralconfigs] configs USING #MINERALCONFS conf
ON configs.materialtype = (select top 1 idx from minerals where name=conf.materialName) AND
	configs.zoneid = (select top 1 id from zones where note=conf.zoneName)
WHEN MATCHED
    THEN UPDATE SET
		maxnodes = conf.maxNodes,
		maxtilespernode = conf.maxTilesPerNode,
		totalamountpernode = conf.totalAmountPerNode,
		minthreshold = conf.minThreshold
WHEN NOT MATCHED
    THEN INSERT (zoneid, materialtype, maxnodes, maxtilespernode, totalamountpernode, minthreshold) VALUES
	((select top 1 id from zones where note=conf.zoneName),
	(select top 1 idx from minerals where name=conf.materialName),
	conf.maxNodes,
	conf.maxTilesPerNode,
	conf.totalAmountPerNode,
	conf.minThreshold);
DROP TABLE IF EXISTS #MINERALCONFS;
PRINT N'FLUXORE IS A GO';
GO
