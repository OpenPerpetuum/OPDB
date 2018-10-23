USE [perpetuumsa]
GO

DECLARE @defname_head varchar(100);
DECLARE @defname_chassis varchar(100);

DECLARE @definitionID int;
DECLARE @aggvalueID int;

DECLARE @cpu_field int;
DECLARE @reactor_field int;
DECLARE @targets_field int;

DECLARE @cpu float;
DECLARE @reactor float;
DECLARE @targets float;
DECLARE @mass float;

SET @cpu_field = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'cpu_max' ORDER BY [name] DESC);
SET @reactor_field = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'powergrid_max' ORDER BY [name] DESC);
SET @targets_field = (SELECT TOP 1 id from aggregatefields WHERE [name] = 'locked_targets_max' ORDER BY [name] DESC);


DECLARE @MK2STATS TABLE
(
  headname varchar(100), 
  chassisname varchar(100), 
  cpu float, 
  reactor float, 
  targets int,
  mass float
);

--mk2 bot stat changes
INSERT INTO @MK2STATS VALUES
('def_yagel_head_mk2', 'def_yagel_chassis_mk2', 170, 165, 5, 6200),
('def_prometheus_head_mk2', 'def_prometheus_chassis_mk2', 170, 198, 5, 6200),
('def_castel_head_mk2', 'def_castel_chassis_mk2', 224, 148, 5, 5000),
('def_argano_head_mk2', 'def_argano_chassis_mk2', 192, 198, 5, 7500),
('def_laird_head_mk2', 'def_laird_chassis_mk2', 192, 209, 5, 7500),
('def_cameleon_head_mk2', 'def_cameleon_chassis_mk2', 286, 176, 6, 5000),
('def_intakt_head_mk2', 'def_intakt_chassis_mk2', 209, 165, 6, 5000),
('def_troiar_head_mk2', 'def_troiar_chassis_mk2', 242, 192, 6, 5100),
('def_arbalest_head_mk2', 'def_arbalest_chassis_mk2', 275, 346, 6, 11000),
('def_baphomet_mk2_head', 'def_baphomet_mk2_chassis', 275, 418, 6, 11000),
('def_waspish_head_mk2', 'def_waspish_chassis_mk2', 302, 330, 6, 9500),
('def_sequer_head_mk2', 'def_sequer_chassis_mk2', 198, 198, 5, 9600),
('def_kain_head_mk2', 'def_kain_chassis_mk2', 330, 990, 7, 25000),
('def_artemis_head_mk2', 'def_artemis_chassis_mk2', 280, 1210, 7, 25000),
('def_tyrannos_head_mk2', 'def_tyrannos_chassis_mk2', 363, 990, 7, 22500),
('def_termis_head_mk2', 'def_termis_chassis_mk2', 330, 825, 6, 16200),
('def_gargoyle_head_mk2', 'def_gargoyle_chassis_mk2', 330, 825, 6, 16200),
('def_vagabond_head_mk2', 'def_vagabond_chassis_mk2', 495, 660, 9, 14500),
('def_zenith_head_mk2', 'def_zenith_chassis_mk2', 467, 825, 9, 14500),
('def_ictus_head_mk2', 'def_ictus_chassis_mk2', 544, 1045, 9, 15500),
('def_mesmer_head_mk2', 'def_mesmer_chassis_mk2', 401, 1182, 8, 30000),
('def_seth_head_mk2', 'def_seth_chassis_mk2', 346, 1512, 8, 30000),
('def_gropho_head_mk2', 'def_gropho_chassis_mk2', 459, 1127, 8, 26500),
('def_riveler_head_mk2', 'def_riveler_chassis_mk2', 450, 880, 7, 42000),
('def_symbiont_head_mk2', 'def_symbiont_chassis_mk2', 450, 880, 7, 42000),
('def_lithus_head_mk2', 'def_lithus_chassis_mk2', 495, 825, 5, 78000),
('def_scarab_head_mk2', 'def_scarab_chassis_mk2', 440, 660, 5, 54000);



--UPDATE THE CPUS
UPDATE
    aggregatevalues
SET
    aggregatevalues.value = mk2stats.cpu
FROM
    aggregatevalues AS aggvalue
    INNER JOIN @MK2STATS AS mk2stats
        ON aggvalue.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=mk2stats.headname)
WHERE
    aggvalue.id = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=mk2stats.headname)
	 AND [field]=@cpu_field ORDER BY definition DESC);


--UPDATE THE REACTORS
UPDATE
    aggregatevalues
SET
    aggregatevalues.value = mk2stats.reactor
FROM
    aggregatevalues AS aggvalue
    INNER JOIN @MK2STATS AS mk2stats
        ON aggvalue.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=mk2stats.chassisname)
WHERE
    aggvalue.id = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=mk2stats.chassisname)
	 AND [field]=@reactor_field ORDER BY definition DESC);


--UPDATE THE MAX TARGETS
UPDATE
    aggregatevalues
SET
    aggregatevalues.value = mk2stats.targets
FROM
    aggregatevalues AS aggvalue
    INNER JOIN @MK2STATS AS mk2stats
        ON aggvalue.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=mk2stats.headname)
WHERE
    aggvalue.id = (SELECT TOP 1 id from aggregatevalues WHERE [definition] = 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=mk2stats.headname)
	 AND [field]=@targets_field ORDER BY definition DESC);


--UPDATE THE MASSES!!!!
UPDATE
    entitydefaults
SET
    entitydefaults.mass = mk2stats.mass
FROM
    entitydefaults AS defs
    INNER JOIN @MK2STATS AS mk2stats
        ON defs.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=mk2stats.chassisname)
WHERE
    defs.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=mk2stats.chassisname);


GO

