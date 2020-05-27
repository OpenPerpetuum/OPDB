USE [perpetuumsa]
GO
----------------------------
--LARGE WEAPONS
--Set stats in entitydefaults and aggregatevalues
--All definitions already in defaults - no inserts for new defs
----------------------------


DROP TABLE IF EXISTS #LARGEWEP;
CREATE TABLE #LARGEWEP 
(
	defName varchar(100),
	catFlags bigint,
	attrFlags bigint,
	cargoVolume float,
	massOfModule float,
	techType int,
	techLevel int,
	genxyOptStr varchar(max),
);
INSERT INTO #LARGEWEP (defName, attrFlags, catFlags, cargoVolume, massOfModule, techType, techLevel, genxyOptStr) VALUES
('def_standard_large_laser', 402128, 50398991, 1.5, 1000, 1, 1, '#moduleFlag=i111 #ammoCapacity=i3c #ammoType=L3020a #tier=$tierlevel_t1'),
('def_named1_large_laser', 402128, 50398991, 1.5, 900, 1, 2, '#moduleFlag=i111 #ammoCapacity=i4b #ammoType=L3020a #tier=$tierlevel_t2'),
('def_named2_large_laser', 402128, 50398991, 1.5, 1000, 1, 3, '#moduleFlag=i111 #ammoCapacity=i4b #ammoType=L3020a #tier=$tierlevel_t3'),
('def_named3_large_laser', 402128, 50398991, 1.5, 1100, 1, 4, '#moduleFlag=i111 #ammoCapacity=i2d #ammoType=L3020a #tier=$tierlevel_t4'),
--
('def_longrange_standard_large_laser', 402128, 50398991, 1.5, 1300, 1, 1, '#moduleFlag=i111 #ammoCapacity=i3c #ammoType=L3020a #tier=$tierlevel_t1'),
('def_named1_longrange_large_laser', 402128, 50398991, 1.5, 1170, 1, 2, '#moduleFlag=i111 #ammoCapacity=i3c #ammoType=L3020a #tier=$tierlevel_t2'),
('def_named2_longrange_large_laser', 402128, 50398991, 1.5, 1300, 1, 3, '#moduleFlag=i111 #ammoCapacity=i3c #ammoType=L3020a #tier=$tierlevel_t3'),
('def_named3_longrange_large_laser', 402128, 50398991, 1.5, 1430, 1, 4, '#moduleFlag=i111 #ammoCapacity=i3c #ammoType=L3020a #tier=$tierlevel_t4'),
--
('def_standard_cruisemissile_launcher', 402128, 50530063, 1.5, 1000, 1, 1, '#moduleFlag=i112 #ammoCapacity=i14 #ammoType=L3040a #tier=$tierlevel_t1'),
('def_named1_cruisemissile_launcher', 402128, 50530063, 1.5, 900, 1, 2, '#moduleFlag=i112 #ammoCapacity=i14 #ammoType=L3040a #tier=$tierlevel_t2'),
('def_named2_cruisemissile_launcher', 402128, 50530063, 1.5, 1000, 1, 3, '#moduleFlag=i112 #ammoCapacity=i14 #ammoType=L3040a #tier=$tierlevel_t3'),
('def_named3_cruisemissile_launcher', 402128, 50530063, 1.5, 1100, 1, 4, '#moduleFlag=i112 #ammoCapacity=i14 #ammoType=L3040a #tier=$tierlevel_t4'),
--
('def_standard_large_railgun', 402128, 50595599, 1.5, 1000, 1, 1, '#moduleFlag=i111 #ammoCapacity=i19 #ammoType=L3010a #tier=$tierlevel_t1'),
('def_named1_large_railgun', 402128, 50595599, 1.5, 900, 1, 2, '#moduleFlag=i111 #ammoCapacity=i1e #ammoType=L3010a #tier=$tierlevel_t2'),
('def_named2_large_railgun', 402128, 50595599, 1.5, 1000, 1, 3, '#moduleFlag=i111 #ammoCapacity=i1e #ammoType=L3010a #tier=$tierlevel_t3'),
('def_named3_large_railgun', 402128, 50595599, 1.5, 1100, 1, 4, '#moduleFlag=i111 #ammoCapacity=i14 #ammoType=L3010a #tier=$tierlevel_t4'),
--
('def_longrange_standard_large_railgun', 402128, 50595599, 1.5, 1300, 1, 1, '#moduleFlag=i111 #ammoCapacity=i19 #ammoType=L3010a #tier=$tierlevel_t1'),
('def_named1_longrange_large_railgun', 402128, 50595599, 1.5, 1170, 1, 2, '#moduleFlag=i111 #ammoCapacity=i19 #ammoType=L3010a #tier=$tierlevel_t2'),
('def_named2_longrange_large_railgun', 402128, 50595599, 1.5, 1300, 1, 3, '#moduleFlag=i111 #ammoCapacity=i19 #ammoType=L3010a #tier=$tierlevel_t3'),
('def_named3_longrange_large_railgun', 402128, 50595599, 1.5, 1430, 1, 4, '#moduleFlag=i111 #ammoCapacity=i19 #ammoType=L3010a #tier=$tierlevel_t4'),
--PROTOTYPES
('def_named1_large_laser_pr', 402128, 50398991, 1.5, 900, 2, 2, '#moduleFlag=i111 #ammoCapacity=i4b #ammoType=L3020a #tier=$tierlevel_t2_pr'),
('def_named2_large_laser_pr', 402128, 50398991, 1.5, 1000, 2, 3, '#moduleFlag=i111 #ammoCapacity=i4b #ammoType=L3020a #tier=$tierlevel_t3_pr'),
('def_named3_large_laser_pr', 402128, 50398991, 1.5, 1100, 2, 4, '#moduleFlag=i111 #ammoCapacity=i2d #ammoType=L3020a #tier=$tierlevel_t4_pr'),
--
('def_named1_longrange_large_laser_pr', 402128, 50398991, 1.5, 1170, 2, 2, '#moduleFlag=i111 #ammoCapacity=i3c #ammoType=L3020a #tier=$tierlevel_t2_pr'),
('def_named2_longrange_large_laser_pr', 402128, 50398991, 1.5, 1300, 2, 3, '#moduleFlag=i111 #ammoCapacity=i3c #ammoType=L3020a #tier=$tierlevel_t3_pr'),
('def_named3_longrange_large_laser_pr', 402128, 50398991, 1.5, 1430, 2, 4, '#moduleFlag=i111 #ammoCapacity=i3c #ammoType=L3020a #tier=$tierlevel_t4_pr'),
--
('def_named1_cruisemissile_launcher_pr', 402128, 50530063, 1.5, 900, 2, 2, '#moduleFlag=i112 #ammoCapacity=i14 #ammoType=L3040a #tier=$tierlevel_t2_pr'),
('def_named2_cruisemissile_launcher_pr', 402128, 50530063, 1.5, 1000, 2, 3, '#moduleFlag=i112 #ammoCapacity=i14 #ammoType=L3040a #tier=$tierlevel_t3_pr'),
('def_named3_cruisemissile_launcher_pr', 402128, 50530063, 1.5, 1100, 2, 4, '#moduleFlag=i112 #ammoCapacity=i14 #ammoType=L3040a #tier=$tierlevel_t4_pr'),
--
('def_named1_large_railgun_pr', 402128, 50595599, 1.5, 900, 2, 2, '#moduleFlag=i111 #ammoCapacity=i1e #ammoType=L3010a #tier=$tierlevel_t2_pr'),
('def_named2_large_railgun_pr', 402128, 50595599, 1.5, 1000, 2, 3, '#moduleFlag=i111 #ammoCapacity=i1e #ammoType=L3010a #tier=$tierlevel_t3_pr'),
('def_named3_large_railgun_pr', 402128, 50595599, 1.5, 1100, 2, 4, '#moduleFlag=i111 #ammoCapacity=i14 #ammoType=L3010a #tier=$tierlevel_t4_pr'),
--
('def_named1_longrange_large_railgun_pr', 402128, 50595599, 1.5, 1170, 2, 2, '#moduleFlag=i111 #ammoCapacity=i19 #ammoType=L3010a #tier=$tierlevel_t2_pr'),
('def_named2_longrange_large_railgun_pr', 402128, 50595599, 1.5, 1300, 2, 3, '#moduleFlag=i111 #ammoCapacity=i19 #ammoType=L3010a #tier=$tierlevel_t3_pr'),
('def_named3_longrange_large_railgun_pr', 402128, 50595599, 1.5, 1430, 2, 4, '#moduleFlag=i111 #ammoCapacity=i19 #ammoType=L3010a #tier=$tierlevel_t4_pr');

DROP TABLE IF EXISTS #UNIQ_CAT_FLAGS;
CREATE TABLE #UNIQ_CAT_FLAGS
(
	catFlags bigint
);
INSERT INTO #UNIQ_CAT_FLAGS (catFlags) SELECT DISTINCT catFlags FROM #LARGEWEP;

PRINT N'UN-HIDE WEAPON CATEGORIES';
UPDATE categoryFlags SET
  hidden=0
WHERE value in (SELECT catFlags from #UNIQ_CAT_FLAGS);


PRINT N'UPDATE/INSERT WEP Category for production decalibration';
--Update/insert [productiondecalibration] entries
MERGE [dbo].[productiondecalibration] decal USING #UNIQ_CAT_FLAGS wep
ON decal.categoryflag = wep.catFlags
WHEN MATCHED
    THEN UPDATE SET
		distorsionmin=0.003,
		distorsionmax=0.005,
		decrease=1
WHEN NOT MATCHED
    THEN INSERT (categoryflag,distorsionmin,distorsionmax,decrease) VALUES
	(wep.catFlags, 0.003,0.005,1);

PRINT N'UPDATE/INSERT WEP Category for production duration';
--Update/insert [productionduration] entries
MERGE [dbo].[productionduration] dur USING #UNIQ_CAT_FLAGS wep
ON dur.category = wep.catFlags
WHEN MATCHED
    THEN UPDATE SET
		durationmodifier=3
WHEN NOT MATCHED
    THEN INSERT (category,durationmodifier) VALUES
	(wep.catFlags, 3);


DROP TABLE IF EXISTS #UNIQ_CAT_FLAGS;

DROP TABLE IF EXISTS #WEPSTATS;
CREATE TABLE #WEPSTATS 
(
	defName varchar(100),
	fieldName varchar(100),
	fieldValue float,
);
INSERT INTO #WEPSTATS (defName, fieldName, fieldValue) VALUES
('def_standard_large_laser', 'cpu_usage', 62.5),
('def_standard_large_laser', 'powergrid_usage', 350),
('def_standard_large_laser', 'core_usage', 18.9),
('def_standard_large_laser', 'cycle_time', 5000),
('def_standard_large_laser', 'damage_modifier', 1.91),
('def_standard_large_laser', 'optimal_range', 22.5),
('def_standard_large_laser', 'falloff', 10),
('def_standard_large_laser', 'accuracy', 34.5),

('def_named1_large_laser', 'cpu_usage', 55),
('def_named1_large_laser', 'powergrid_usage', 315),
('def_named1_large_laser', 'core_usage', 15.3),
('def_named1_large_laser', 'cycle_time', 5000),
('def_named1_large_laser', 'damage_modifier', 1.91),
('def_named1_large_laser', 'optimal_range', 22.5),
('def_named1_large_laser', 'falloff', 10),
('def_named1_large_laser', 'accuracy', 34.5),

('def_named1_large_laser_pr', 'cpu_usage', 55),
('def_named1_large_laser_pr', 'powergrid_usage', 315),
('def_named1_large_laser_pr', 'core_usage', 15.3),
('def_named1_large_laser_pr', 'cycle_time', 5000),
('def_named1_large_laser_pr', 'damage_modifier', 1.91),
('def_named1_large_laser_pr', 'optimal_range', 22.5),
('def_named1_large_laser_pr', 'falloff', 10),
('def_named1_large_laser_pr', 'accuracy', 34.5),

('def_named2_large_laser', 'cpu_usage', 70),
('def_named2_large_laser', 'powergrid_usage', 394),
('def_named2_large_laser', 'core_usage', 18),
('def_named2_large_laser', 'cycle_time', 4500),
('def_named2_large_laser', 'damage_modifier', 2.07),
('def_named2_large_laser', 'optimal_range', 23.5),
('def_named2_large_laser', 'falloff', 10),
('def_named2_large_laser', 'accuracy', 34.5),

('def_named2_large_laser_pr', 'cpu_usage', 70),
('def_named2_large_laser_pr', 'powergrid_usage', 394),
('def_named2_large_laser_pr', 'core_usage', 18),
('def_named2_large_laser_pr', 'cycle_time', 4500),
('def_named2_large_laser_pr', 'damage_modifier', 2.07),
('def_named2_large_laser_pr', 'optimal_range', 23.5),
('def_named2_large_laser_pr', 'falloff', 10),
('def_named2_large_laser_pr', 'accuracy', 34.5),

('def_named3_large_laser', 'cpu_usage', 75),
('def_named3_large_laser', 'powergrid_usage', 437.5),
('def_named3_large_laser', 'core_usage', 21.6),
('def_named3_large_laser', 'cycle_time', 5000),
('def_named3_large_laser', 'damage_modifier', 2.40),
('def_named3_large_laser', 'optimal_range', 24),
('def_named3_large_laser', 'falloff', 10),
('def_named3_large_laser', 'accuracy', 34.5),

('def_named3_large_laser_pr', 'cpu_usage', 75),
('def_named3_large_laser_pr', 'powergrid_usage', 437.5),
('def_named3_large_laser_pr', 'core_usage', 21.6),
('def_named3_large_laser_pr', 'cycle_time', 5000),
('def_named3_large_laser_pr', 'damage_modifier', 2.40),
('def_named3_large_laser_pr', 'optimal_range', 24),
('def_named3_large_laser_pr', 'falloff', 10),
('def_named3_large_laser_pr', 'accuracy', 34.5),
--
('def_longrange_standard_large_laser', 'cpu_usage', 75),
('def_longrange_standard_large_laser', 'powergrid_usage', 402.5),
('def_longrange_standard_large_laser', 'core_usage', 22.5),
('def_longrange_standard_large_laser', 'cycle_time', 6000),
('def_longrange_standard_large_laser', 'damage_modifier', 1.50),
('def_longrange_standard_large_laser', 'optimal_range', 50),
('def_longrange_standard_large_laser', 'falloff', 25),
('def_longrange_standard_large_laser', 'accuracy', 36),

('def_named1_longrange_large_laser', 'cpu_usage', 67.5),
('def_named1_longrange_large_laser', 'powergrid_usage', 367.5),
('def_named1_longrange_large_laser', 'core_usage', 19.8),
('def_named1_longrange_large_laser', 'cycle_time', 6000),
('def_named1_longrange_large_laser', 'damage_modifier', 1.50),
('def_named1_longrange_large_laser', 'optimal_range', 50),
('def_named1_longrange_large_laser', 'falloff', 25),
('def_named1_longrange_large_laser', 'accuracy', 36),

('def_named1_longrange_large_laser_pr', 'cpu_usage', 67.5),
('def_named1_longrange_large_laser_pr', 'powergrid_usage', 367.5),
('def_named1_longrange_large_laser_pr', 'core_usage', 19.8),
('def_named1_longrange_large_laser_pr', 'cycle_time', 6000),
('def_named1_longrange_large_laser_pr', 'damage_modifier', 1.50),
('def_named1_longrange_large_laser_pr', 'optimal_range', 50),
('def_named1_longrange_large_laser_pr', 'falloff', 25),
('def_named1_longrange_large_laser_pr', 'accuracy', 36),

('def_named2_longrange_large_laser', 'cpu_usage', 80),
('def_named2_longrange_large_laser', 'powergrid_usage', 411),
('def_named2_longrange_large_laser', 'core_usage', 23.6),
('def_named2_longrange_large_laser', 'cycle_time', 6000),
('def_named2_longrange_large_laser', 'damage_modifier', 1.88),
('def_named2_longrange_large_laser', 'optimal_range', 51.5),
('def_named2_longrange_large_laser', 'falloff', 25),
('def_named2_longrange_large_laser', 'accuracy', 36),

('def_named2_longrange_large_laser_pr', 'cpu_usage', 80),
('def_named2_longrange_large_laser_pr', 'powergrid_usage', 411),
('def_named2_longrange_large_laser_pr', 'core_usage', 23.6),
('def_named2_longrange_large_laser_pr', 'cycle_time', 6000),
('def_named2_longrange_large_laser_pr', 'damage_modifier', 1.88),
('def_named2_longrange_large_laser_pr', 'optimal_range', 51.5),
('def_named2_longrange_large_laser_pr', 'falloff', 25),
('def_named2_longrange_large_laser_pr', 'accuracy', 36),

('def_named3_longrange_large_laser', 'cpu_usage', 87.5),
('def_named3_longrange_large_laser', 'powergrid_usage', 437.5),
('def_named3_longrange_large_laser', 'core_usage', 27),
('def_named3_longrange_large_laser', 'cycle_time', 6000),
('def_named3_longrange_large_laser', 'damage_modifier', 1.95),
('def_named3_longrange_large_laser', 'optimal_range', 52.5),
('def_named3_longrange_large_laser', 'falloff', 25),
('def_named3_longrange_large_laser', 'accuracy', 36),

('def_named3_longrange_large_laser_pr', 'cpu_usage', 87.5),
('def_named3_longrange_large_laser_pr', 'powergrid_usage', 437.5),
('def_named3_longrange_large_laser_pr', 'core_usage', 27),
('def_named3_longrange_large_laser_pr', 'cycle_time', 6000),
('def_named3_longrange_large_laser_pr', 'damage_modifier', 1.95),
('def_named3_longrange_large_laser_pr', 'optimal_range', 52.5),
('def_named3_longrange_large_laser_pr', 'falloff', 25),
('def_named3_longrange_large_laser_pr', 'accuracy', 36),
--
('def_standard_large_railgun', 'cpu_usage', 80),
('def_standard_large_railgun', 'powergrid_usage', 225),
('def_standard_large_railgun', 'core_usage', 18.75),
('def_standard_large_railgun', 'cycle_time', 6000),
('def_standard_large_railgun', 'damage_modifier', 2.55),
('def_standard_large_railgun', 'optimal_range', 20),
('def_standard_large_railgun', 'falloff', 7.5),
('def_standard_large_railgun', 'accuracy', 40.5),

('def_named1_large_railgun', 'cpu_usage', 62.5),
('def_named1_large_railgun', 'powergrid_usage', 202.25),
('def_named1_large_railgun', 'core_usage', 15),
('def_named1_large_railgun', 'cycle_time', 6000),
('def_named1_large_railgun', 'damage_modifier', 2.55),
('def_named1_large_railgun', 'optimal_range', 20),
('def_named1_large_railgun', 'falloff', 7.5),
('def_named1_large_railgun', 'accuracy', 40.5),

('def_named1_large_railgun_pr', 'cpu_usage', 62.5),
('def_named1_large_railgun_pr', 'powergrid_usage', 202.25),
('def_named1_large_railgun_pr', 'core_usage', 15),
('def_named1_large_railgun_pr', 'cycle_time', 6000),
('def_named1_large_railgun_pr', 'damage_modifier', 2.55),
('def_named1_large_railgun_pr', 'optimal_range', 20),
('def_named1_large_railgun_pr', 'falloff', 7.5),
('def_named1_large_railgun_pr', 'accuracy', 40.5),

('def_named2_large_railgun', 'cpu_usage', 87.5),
('def_named2_large_railgun', 'powergrid_usage', 247.5),
('def_named2_large_railgun', 'core_usage', 18.75),
('def_named2_large_railgun', 'cycle_time', 6000),
('def_named2_large_railgun', 'damage_modifier', 3.0),
('def_named2_large_railgun', 'optimal_range', 21.5),
('def_named2_large_railgun', 'falloff', 6),
('def_named2_large_railgun', 'accuracy', 40.5),

('def_named2_large_railgun_pr', 'cpu_usage', 87.5),
('def_named2_large_railgun_pr', 'powergrid_usage', 247.5),
('def_named2_large_railgun_pr', 'core_usage', 18.75),
('def_named2_large_railgun_pr', 'cycle_time', 6000),
('def_named2_large_railgun_pr', 'damage_modifier', 3.0),
('def_named2_large_railgun_pr', 'optimal_range', 21.5),
('def_named2_large_railgun_pr', 'falloff', 6),
('def_named2_large_railgun_pr', 'accuracy', 40.5),

('def_named3_large_railgun', 'cpu_usage', 95),
('def_named3_large_railgun', 'powergrid_usage', 270),
('def_named3_large_railgun', 'core_usage', 25),
('def_named3_large_railgun', 'cycle_time', 8000),
('def_named3_large_railgun', 'damage_modifier', 4.5),
('def_named3_large_railgun', 'optimal_range', 22.5),
('def_named3_large_railgun', 'falloff', 6),
('def_named3_large_railgun', 'accuracy', 40.5),

('def_named3_large_railgun_pr', 'cpu_usage', 95),
('def_named3_large_railgun_pr', 'powergrid_usage', 270),
('def_named3_large_railgun_pr', 'core_usage', 25),
('def_named3_large_railgun_pr', 'cycle_time', 8000),
('def_named3_large_railgun_pr', 'damage_modifier', 4.5),
('def_named3_large_railgun_pr', 'optimal_range', 22.5),
('def_named3_large_railgun_pr', 'falloff', 6),
('def_named3_large_railgun_pr', 'accuracy', 40.5),
--
('def_longrange_standard_large_railgun', 'cpu_usage', 100),
('def_longrange_standard_large_railgun', 'powergrid_usage', 277.5),
('def_longrange_standard_large_railgun', 'core_usage', 33.75),
('def_longrange_standard_large_railgun', 'cycle_time', 10000),
('def_longrange_standard_large_railgun', 'damage_modifier', 3.0),
('def_longrange_standard_large_railgun', 'optimal_range', 44),
('def_longrange_standard_large_railgun', 'falloff', 22.5),
('def_longrange_standard_large_railgun', 'accuracy', 42),

('def_named1_longrange_large_railgun', 'cpu_usage', 90),
('def_named1_longrange_large_railgun', 'powergrid_usage', 277.5),
('def_named1_longrange_large_railgun', 'core_usage', 31.25),
('def_named1_longrange_large_railgun', 'cycle_time', 10000),
('def_named1_longrange_large_railgun', 'damage_modifier', 3.0),
('def_named1_longrange_large_railgun', 'optimal_range', 44),
('def_named1_longrange_large_railgun', 'falloff', 22.5),
('def_named1_longrange_large_railgun', 'accuracy', 42),

('def_named1_longrange_large_railgun_pr', 'cpu_usage', 90),
('def_named1_longrange_large_railgun_pr', 'powergrid_usage', 277.5),
('def_named1_longrange_large_railgun_pr', 'core_usage', 31.25),
('def_named1_longrange_large_railgun_pr', 'cycle_time', 10000),
('def_named1_longrange_large_railgun_pr', 'damage_modifier', 3.0),
('def_named1_longrange_large_railgun_pr', 'optimal_range', 44),
('def_named1_longrange_large_railgun_pr', 'falloff', 22.5),
('def_named1_longrange_large_railgun_pr', 'accuracy', 42),

('def_named2_longrange_large_railgun', 'cpu_usage', 107.5),
('def_named2_longrange_large_railgun', 'powergrid_usage', 277.5),
('def_named2_longrange_large_railgun', 'core_usage', 40),
('def_named2_longrange_large_railgun', 'cycle_time', 10000),
('def_named2_longrange_large_railgun', 'damage_modifier', 3.75),
('def_named2_longrange_large_railgun', 'optimal_range', 45),
('def_named2_longrange_large_railgun', 'falloff', 21.0),
('def_named2_longrange_large_railgun', 'accuracy', 42),

('def_named2_longrange_large_railgun_pr', 'cpu_usage', 107.5),
('def_named2_longrange_large_railgun_pr', 'powergrid_usage', 277.5),
('def_named2_longrange_large_railgun_pr', 'core_usage', 40),
('def_named2_longrange_large_railgun_pr', 'cycle_time', 10000),
('def_named2_longrange_large_railgun_pr', 'damage_modifier', 3.75),
('def_named2_longrange_large_railgun_pr', 'optimal_range', 45),
('def_named2_longrange_large_railgun_pr', 'falloff', 21.0),
('def_named2_longrange_large_railgun_pr', 'accuracy', 42),

('def_named3_longrange_large_railgun', 'cpu_usage', 112.5),
('def_named3_longrange_large_railgun', 'powergrid_usage', 300),
('def_named3_longrange_large_railgun', 'core_usage', 45),
('def_named3_longrange_large_railgun', 'cycle_time', 10000),
('def_named3_longrange_large_railgun', 'damage_modifier', 4.05),
('def_named3_longrange_large_railgun', 'optimal_range', 46),
('def_named3_longrange_large_railgun', 'falloff', 21),
('def_named3_longrange_large_railgun', 'accuracy', 42),

('def_named3_longrange_large_railgun_pr', 'cpu_usage', 112.5),
('def_named3_longrange_large_railgun_pr', 'powergrid_usage', 300),
('def_named3_longrange_large_railgun_pr', 'core_usage', 45),
('def_named3_longrange_large_railgun_pr', 'cycle_time', 10000),
('def_named3_longrange_large_railgun_pr', 'damage_modifier', 4.05),
('def_named3_longrange_large_railgun_pr', 'optimal_range', 46),
('def_named3_longrange_large_railgun_pr', 'falloff', 21),
('def_named3_longrange_large_railgun_pr', 'accuracy', 42),
--
('def_standard_cruisemissile_launcher', 'cpu_usage', 100),
('def_standard_cruisemissile_launcher', 'powergrid_usage', 225),
('def_standard_cruisemissile_launcher', 'core_usage', 16),
('def_standard_cruisemissile_launcher', 'cycle_time', 14000),
('def_standard_cruisemissile_launcher', 'damage_modifier', 1.5),
('def_standard_cruisemissile_launcher', 'accuracy', 1),

('def_named1_cruisemissile_launcher', 'cpu_usage', 90),
('def_named1_cruisemissile_launcher', 'powergrid_usage', 202.5),
('def_named1_cruisemissile_launcher', 'core_usage', 16),
('def_named1_cruisemissile_launcher', 'cycle_time', 14000),
('def_named1_cruisemissile_launcher', 'damage_modifier', 1.5),
('def_named1_cruisemissile_launcher', 'accuracy', 1),

('def_named1_cruisemissile_launcher_pr', 'cpu_usage', 90),
('def_named1_cruisemissile_launcher_pr', 'powergrid_usage', 202.5),
('def_named1_cruisemissile_launcher_pr', 'core_usage', 16),
('def_named1_cruisemissile_launcher_pr', 'cycle_time', 14000),
('def_named1_cruisemissile_launcher_pr', 'damage_modifier', 1.5),
('def_named1_cruisemissile_launcher_pr', 'accuracy', 1),

('def_named2_cruisemissile_launcher', 'cpu_usage', 105),
('def_named2_cruisemissile_launcher', 'powergrid_usage', 240),
('def_named2_cruisemissile_launcher', 'core_usage', 16),
('def_named2_cruisemissile_launcher', 'cycle_time', 12000),
('def_named2_cruisemissile_launcher', 'damage_modifier', 1.65),
('def_named2_cruisemissile_launcher', 'module_missile_range_modifier', 1.1),
('def_named2_cruisemissile_launcher', 'accuracy', 1),

('def_named2_cruisemissile_launcher_pr', 'cpu_usage', 105),
('def_named2_cruisemissile_launcher_pr', 'powergrid_usage', 240),
('def_named2_cruisemissile_launcher_pr', 'core_usage', 16),
('def_named2_cruisemissile_launcher_pr', 'cycle_time', 12000),
('def_named2_cruisemissile_launcher_pr', 'damage_modifier', 1.65),
('def_named2_cruisemissile_launcher_pr', 'module_missile_range_modifier', 1.1),
('def_named2_cruisemissile_launcher_pr', 'accuracy', 1),

('def_named3_cruisemissile_launcher', 'cpu_usage', 112.5),
('def_named3_cruisemissile_launcher', 'powergrid_usage', 255),
('def_named3_cruisemissile_launcher', 'core_usage', 16),
('def_named3_cruisemissile_launcher', 'cycle_time', 10500),
('def_named3_cruisemissile_launcher', 'damage_modifier', 1.8),
('def_named3_cruisemissile_launcher', 'module_missile_range_modifier', 1.2),
('def_named3_cruisemissile_launcher', 'accuracy', 1),

('def_named3_cruisemissile_launcher_pr', 'cpu_usage', 112.5),
('def_named3_cruisemissile_launcher_pr', 'powergrid_usage', 255),
('def_named3_cruisemissile_launcher_pr', 'core_usage', 16),
('def_named3_cruisemissile_launcher_pr', 'cycle_time', 10500),
('def_named3_cruisemissile_launcher_pr', 'damage_modifier', 1.8),
('def_named3_cruisemissile_launcher_pr', 'module_missile_range_modifier', 1.2),
('def_named3_cruisemissile_launcher_pr', 'accuracy', 1);


PRINT N'UPDATE/INSERT ENTITY DEFS FOR LARGE WEPS + protos';
--Update/insert [entitydefaults] entries
MERGE [dbo].[entitydefaults] def USING #LARGEWEP wep
ON def.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=wep.defName)
WHEN MATCHED
    THEN UPDATE SET
		categoryflags=catFlags,
		attributeflags=attrFlags,
		volume=cargoVolume,
		mass=massOfModule,
		tiertype=techType,
		tierlevel=techLevel,
		options=genxyOptStr,
		enabled=1,
		hidden=0,
		purchasable=1,
		descriptiontoken=defName+'_desc'
WHEN NOT MATCHED
    THEN INSERT (definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel) VALUES
	(defName,1,attrFlags,catFlags,genxyOptStr,'large weapon module',1,cargoVolume,massOfModule,0,100,defName+'_desc',1,techType,techLevel);



PRINT N'PRINT OLD STATS';
SELECT definitionname, field, value FROM aggregatevalues as a
JOIN entitydefaults AS e ON e.definition=a.definition
WHERE a.definition IN (SELECT definition FROM entitydefaults WHERE definitionname IN (SELECT DISTINCT defName FROM #WEPSTATS));

PRINT N'DELETE OLD STATS (0 results if 1st run)';
DELETE FROM aggregatevalues WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #WEPSTATS));

PRINT N'INSERT NEW STATS';
INSERT INTO aggregatevalues (definition, field, value)
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defName), 
	(SELECT TOP 1 id FROM aggregatefields WHERE name=fieldName), 
	fieldValue 
FROM #WEPSTATS 




PRINT N'CREATE [modulepropertymodifiers] entries for large weapons';
PRINT N'Delete existing to avoid duplicates';
DELETE FROM [dbo].[modulepropertymodifiers] WHERE categoryflags in (
(SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_lasers'),
(SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_railguns'),
(SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_missile_launchers'));


PRINT N'INSERT [modulepropertymodifiers] for large weapon damage, cpu, and powergrid effects';
INSERT INTO [dbo].[modulepropertymodifiers] ([categoryflags],[basefield],[modifierfield]) VALUES
((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_lasers'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='cpu_usage'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='cpu_usage_large_laser_modifier')),

((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_lasers'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='damage_modifier'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='damage_large_laser_modifier')),

((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_lasers'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='powergrid_usage'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='powergrid_usage_large_laser_modifier')),

((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_railguns'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='cpu_usage'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='cpu_usage_large_railgun_modifier')),

((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_railguns'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='damage_modifier'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='damage_large_railgun_modifier')),

((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_railguns'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='powergrid_usage'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='powergrid_usage_large_railgun_modifier')),

((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_missile_launchers'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='cpu_usage'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='cpu_usage_large_missile_modifier')),

((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_missile_launchers'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='damage_modifier'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='damage_large_missile_modifier')),

((SELECT TOP 1 value FROM categoryFlags WHERE name='cf_large_missile_launchers'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='powergrid_usage'),
(SELECT TOP 1 id FROM aggregatefields WHERE name='powergrid_usage_large_missile_modifier'));

DROP TABLE IF EXISTS #WEPSTATS;
DROP TABLE IF EXISTS #LARGEWEP;
PRINT N'LARGE WEAPONS SET';
GO


PRINT N'WEAPON PROTOTYPE PAIRINGS';

DROP TABLE IF EXISTS #PROTOPAIRS;
CREATE TABLE #PROTOPAIRS
(
	defName varchar(100),
	protoDefName varchar(100),
);

INSERT INTO #PROTOPAIRS (defName, protoDefName) VALUES
('def_named1_large_laser','def_named1_large_laser_pr'),
('def_named2_large_laser','def_named2_large_laser_pr'),
('def_named3_large_laser','def_named3_large_laser_pr'),
--
('def_named1_longrange_large_laser','def_named1_longrange_large_laser_pr'),
('def_named2_longrange_large_laser','def_named2_longrange_large_laser_pr'),
('def_named3_longrange_large_laser','def_named3_longrange_large_laser_pr'),
--
('def_named1_cruisemissile_launcher','def_named1_cruisemissile_launcher_pr'),
('def_named2_cruisemissile_launcher','def_named2_cruisemissile_launcher_pr'),
('def_named3_cruisemissile_launcher','def_named3_cruisemissile_launcher_pr'),
--
('def_named1_large_railgun','def_named1_large_railgun_pr'),
('def_named2_large_railgun','def_named2_large_railgun_pr'),
('def_named3_large_railgun','def_named3_large_railgun_pr'),
--
('def_named1_longrange_large_railgun','def_named1_longrange_large_railgun_pr'),
('def_named2_longrange_large_railgun','def_named2_longrange_large_railgun_pr'),
('def_named3_longrange_large_railgun','def_named3_longrange_large_railgun_pr');

--DELETE and reinsert
PRINT N'DELETE prototypes FOR ANY EXISTING LARGE WEP-PROTO PAIRS (0 results if first run)';
SELECT * FROM prototypes WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT defName FROM #PROTOPAIRS));
DELETE FROM prototypes WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT defName FROM #PROTOPAIRS));

--INSERT
PRINT N'INSERT prototypes FOR LARGE WEP-PROTO PAIRS';
INSERT INTO prototypes (definition, prototype)
SELECT (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = defName), 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = protoDefName)
FROM #PROTOPAIRS;
DROP TABLE IF EXISTS #PROTOPAIRS;
GO


PRINT N'WEAPON PRODUCTION';

DROP TABLE IF EXISTS #WEPCOMPONENTS;
CREATE TABLE #WEPCOMPONENTS
(
	defName VARCHAR(100),
	commodityName VARCHAR(100),
	amount INT
);
INSERT INTO #WEPCOMPONENTS (defName, commodityName, amount) VALUES
('def_standard_large_laser', 'def_titanium', 150),
('def_standard_large_laser', 'def_axicoline', 150),
('def_standard_large_laser', 'def_polynucleit', 150),
('def_standard_large_laser', 'def_specimen_sap_item_flux', 10),

('def_named1_large_laser', 'def_standard_large_laser', 1),
('def_named1_large_laser', 'def_robotshard_common_basic', 45),
('def_named1_large_laser', 'def_robotshard_thelodica_basic', 45),
('def_named1_large_laser', 'def_titanium', 150),
('def_named1_large_laser', 'def_axicoline', 150),
('def_named1_large_laser', 'def_polynucleit', 150),
('def_named1_large_laser', 'def_specimen_sap_item_flux', 10),

('def_named1_large_laser_pr', 'def_standard_large_laser', 1),
('def_named1_large_laser_pr', 'def_robotshard_common_basic', 45),
('def_named1_large_laser_pr', 'def_robotshard_thelodica_basic', 45),
('def_named1_large_laser_pr', 'def_titanium', 150),
('def_named1_large_laser_pr', 'def_axicoline', 150),
('def_named1_large_laser_pr', 'def_polynucleit', 150),
('def_named1_large_laser_pr', 'def_specimen_sap_item_flux', 10),

('def_named2_large_laser', 'def_named1_large_laser', 1),
('def_named2_large_laser', 'def_robotshard_common_basic', 30),
('def_named2_large_laser', 'def_robotshard_common_advanced', 30),
('def_named2_large_laser', 'def_robotshard_thelodica_basic', 30),
('def_named2_large_laser', 'def_robotshard_thelodica_advanced', 30),
('def_named2_large_laser', 'def_titanium', 150),
('def_named2_large_laser', 'def_hydrobenol', 150),
('def_named2_large_laser', 'def_polynucleit', 150),
('def_named2_large_laser', 'def_specimen_sap_item_flux', 25),

('def_named2_large_laser_pr', 'def_named1_large_laser', 1),
('def_named2_large_laser_pr', 'def_robotshard_common_basic', 30),
('def_named2_large_laser_pr', 'def_robotshard_common_advanced', 30),
('def_named2_large_laser_pr', 'def_robotshard_thelodica_basic', 30),
('def_named2_large_laser_pr', 'def_robotshard_thelodica_advanced', 30),
('def_named2_large_laser_pr', 'def_titanium', 150),
('def_named2_large_laser_pr', 'def_hydrobenol', 150),
('def_named2_large_laser_pr', 'def_polynucleit', 150),
('def_named2_large_laser_pr', 'def_specimen_sap_item_flux', 25),

('def_named3_large_laser', 'def_named2_large_laser', 1),
('def_named3_large_laser', 'def_robotshard_common_basic', 23),
('def_named3_large_laser', 'def_robotshard_common_advanced', 45),
('def_named3_large_laser', 'def_robotshard_common_expert', 68),
('def_named3_large_laser', 'def_robotshard_thelodica_basic', 23),
('def_named3_large_laser', 'def_robotshard_thelodica_advanced', 45),
('def_named3_large_laser', 'def_robotshard_thelodica_expert', 68),
('def_named3_large_laser', 'def_unimetal', 300),
('def_named3_large_laser', 'def_hydrobenol', 300),
('def_named3_large_laser', 'def_polynucleit', 300),
('def_named3_large_laser', 'def_specimen_sap_item_flux', 50),

('def_named3_large_laser_pr', 'def_named2_large_laser', 1),
('def_named3_large_laser_pr', 'def_robotshard_common_basic', 23),
('def_named3_large_laser_pr', 'def_robotshard_common_advanced', 45),
('def_named3_large_laser_pr', 'def_robotshard_common_expert', 68),
('def_named3_large_laser_pr', 'def_robotshard_thelodica_basic', 23),
('def_named3_large_laser_pr', 'def_robotshard_thelodica_advanced', 45),
('def_named3_large_laser_pr', 'def_robotshard_thelodica_expert', 68),
('def_named3_large_laser_pr', 'def_unimetal', 300),
('def_named3_large_laser_pr', 'def_hydrobenol', 300),
('def_named3_large_laser_pr', 'def_polynucleit', 300),
('def_named3_large_laser_pr', 'def_specimen_sap_item_flux', 50),
--
('def_longrange_standard_large_laser', 'def_titanium', 150),
('def_longrange_standard_large_laser', 'def_axicoline', 150),
('def_longrange_standard_large_laser', 'def_polynucleit', 150),
('def_longrange_standard_large_laser', 'def_axicol', 75),
('def_longrange_standard_large_laser', 'def_prilumium', 75),
('def_longrange_standard_large_laser', 'def_specimen_sap_item_flux', 10),

('def_named1_longrange_large_laser', 'def_longrange_standard_large_laser', 1),
('def_named1_longrange_large_laser', 'def_robotshard_common_basic', 45),
('def_named1_longrange_large_laser', 'def_robotshard_thelodica_basic', 45),
('def_named1_longrange_large_laser', 'def_titanium', 150),
('def_named1_longrange_large_laser', 'def_axicoline', 150),
('def_named1_longrange_large_laser', 'def_polynucleit', 150),
('def_named1_longrange_large_laser', 'def_axicol', 75),
('def_named1_longrange_large_laser', 'def_prilumium', 75),
('def_named1_longrange_large_laser', 'def_specimen_sap_item_flux', 10),

('def_named1_longrange_large_laser_pr', 'def_longrange_standard_large_laser', 1),
('def_named1_longrange_large_laser_pr', 'def_robotshard_common_basic', 45),
('def_named1_longrange_large_laser_pr', 'def_robotshard_thelodica_basic', 45),
('def_named1_longrange_large_laser_pr', 'def_titanium', 150),
('def_named1_longrange_large_laser_pr', 'def_axicoline', 150),
('def_named1_longrange_large_laser_pr', 'def_polynucleit', 150),
('def_named1_longrange_large_laser_pr', 'def_axicol', 75),
('def_named1_longrange_large_laser_pr', 'def_prilumium', 75),
('def_named1_longrange_large_laser_pr', 'def_specimen_sap_item_flux', 10),

('def_named2_longrange_large_laser', 'def_named1_longrange_large_laser', 1),
('def_named2_longrange_large_laser', 'def_robotshard_common_basic', 30),
('def_named2_longrange_large_laser', 'def_robotshard_common_advanced', 30),
('def_named2_longrange_large_laser', 'def_robotshard_thelodica_basic', 30),
('def_named2_longrange_large_laser', 'def_robotshard_thelodica_advanced', 30),
('def_named2_longrange_large_laser', 'def_titanium', 150),
('def_named2_longrange_large_laser', 'def_hydrobenol', 150),
('def_named2_longrange_large_laser', 'def_polynucleit', 150),
('def_named2_longrange_large_laser', 'def_prilumium', 75),
('def_named2_longrange_large_laser', 'def_espitium', 75),
('def_named2_longrange_large_laser', 'def_specimen_sap_item_flux', 25),

('def_named2_longrange_large_laser_pr', 'def_named1_longrange_large_laser', 1),
('def_named2_longrange_large_laser_pr', 'def_robotshard_common_basic', 30),
('def_named2_longrange_large_laser_pr', 'def_robotshard_common_advanced', 30),
('def_named2_longrange_large_laser_pr', 'def_robotshard_thelodica_basic', 30),
('def_named2_longrange_large_laser_pr', 'def_robotshard_thelodica_advanced', 30),
('def_named2_longrange_large_laser_pr', 'def_titanium', 150),
('def_named2_longrange_large_laser_pr', 'def_hydrobenol', 150),
('def_named2_longrange_large_laser_pr', 'def_polynucleit', 150),
('def_named2_longrange_large_laser_pr', 'def_prilumium', 75),
('def_named2_longrange_large_laser_pr', 'def_espitium', 75),
('def_named2_longrange_large_laser_pr', 'def_specimen_sap_item_flux', 25),

('def_named3_longrange_large_laser', 'def_named2_longrange_large_laser', 1),
('def_named3_longrange_large_laser', 'def_robotshard_common_basic', 23),
('def_named3_longrange_large_laser', 'def_robotshard_common_advanced', 45),
('def_named3_longrange_large_laser', 'def_robotshard_common_expert', 68),
('def_named3_longrange_large_laser', 'def_robotshard_thelodica_basic', 23),
('def_named3_longrange_large_laser', 'def_robotshard_thelodica_advanced', 45),
('def_named3_longrange_large_laser', 'def_robotshard_thelodica_expert', 68),
('def_named3_longrange_large_laser', 'def_hydrobenol', 300),
('def_named3_longrange_large_laser', 'def_polynucleit', 300),
('def_named3_longrange_large_laser', 'def_prilumium', 150),
('def_named3_longrange_large_laser', 'def_espitium', 150),
('def_named3_longrange_large_laser', 'def_unimetal', 300),
('def_named3_longrange_large_laser', 'def_specimen_sap_item_flux', 50),

('def_named3_longrange_large_laser_pr', 'def_named2_longrange_large_laser', 1),
('def_named3_longrange_large_laser_pr', 'def_robotshard_common_basic', 23),
('def_named3_longrange_large_laser_pr', 'def_robotshard_common_advanced', 45),
('def_named3_longrange_large_laser_pr', 'def_robotshard_common_expert', 68),
('def_named3_longrange_large_laser_pr', 'def_robotshard_thelodica_basic', 23),
('def_named3_longrange_large_laser_pr', 'def_robotshard_thelodica_advanced', 45),
('def_named3_longrange_large_laser_pr', 'def_robotshard_thelodica_expert', 68),
('def_named3_longrange_large_laser_pr', 'def_hydrobenol', 300),
('def_named3_longrange_large_laser_pr', 'def_polynucleit', 300),
('def_named3_longrange_large_laser_pr', 'def_prilumium', 150),
('def_named3_longrange_large_laser_pr', 'def_espitium', 150),
('def_named3_longrange_large_laser_pr', 'def_unimetal', 300),
('def_named3_longrange_large_laser_pr', 'def_specimen_sap_item_flux', 50),
--
('def_standard_large_railgun', 'def_titanium', 150),
('def_standard_large_railgun', 'def_axicoline', 150),
('def_standard_large_railgun', 'def_polynitrocol', 150),
('def_standard_large_railgun', 'def_specimen_sap_item_flux', 10),

('def_named1_large_railgun', 'def_standard_large_railgun', 1),
('def_named1_large_railgun', 'def_robotshard_common_basic', 45),
('def_named1_large_railgun', 'def_robotshard_nuimqol_basic', 45),
('def_named1_large_railgun', 'def_titanium', 150),
('def_named1_large_railgun', 'def_axicoline', 150),
('def_named1_large_railgun', 'def_polynitrocol', 150),
('def_named1_large_railgun', 'def_specimen_sap_item_flux', 10),

('def_named1_large_railgun_pr', 'def_standard_large_railgun', 1),
('def_named1_large_railgun_pr', 'def_robotshard_common_basic', 45),
('def_named1_large_railgun_pr', 'def_robotshard_nuimqol_basic', 45),
('def_named1_large_railgun_pr', 'def_titanium', 150),
('def_named1_large_railgun_pr', 'def_axicoline', 150),
('def_named1_large_railgun_pr', 'def_polynitrocol', 150),
('def_named1_large_railgun_pr', 'def_specimen_sap_item_flux', 10),

('def_named2_large_railgun', 'def_named1_large_railgun', 1),
('def_named2_large_railgun', 'def_robotshard_common_basic', 30),
('def_named2_large_railgun', 'def_robotshard_common_advanced', 30),
('def_named2_large_railgun', 'def_robotshard_nuimqol_basic', 30),
('def_named2_large_railgun', 'def_robotshard_nuimqol_advanced', 30),
('def_named2_large_railgun', 'def_titanium', 150),
('def_named2_large_railgun', 'def_hydrobenol', 150),
('def_named2_large_railgun', 'def_polynitrocol', 150),
('def_named2_large_railgun', 'def_specimen_sap_item_flux', 25),

('def_named2_large_railgun_pr', 'def_named1_large_railgun', 1),
('def_named2_large_railgun_pr', 'def_robotshard_common_basic', 30),
('def_named2_large_railgun_pr', 'def_robotshard_common_advanced', 30),
('def_named2_large_railgun_pr', 'def_robotshard_nuimqol_basic', 30),
('def_named2_large_railgun_pr', 'def_robotshard_nuimqol_advanced', 30),
('def_named2_large_railgun_pr', 'def_titanium', 150),
('def_named2_large_railgun_pr', 'def_hydrobenol', 150),
('def_named2_large_railgun_pr', 'def_polynitrocol', 150),
('def_named2_large_railgun_pr', 'def_specimen_sap_item_flux', 25),

('def_named3_large_railgun', 'def_named2_large_railgun', 1),
('def_named3_large_railgun', 'def_robotshard_common_basic', 23),
('def_named3_large_railgun', 'def_robotshard_common_advanced', 45),
('def_named3_large_railgun', 'def_robotshard_common_expert', 68),
('def_named3_large_railgun', 'def_robotshard_nuimqol_basic', 23),
('def_named3_large_railgun', 'def_robotshard_nuimqol_advanced', 45),
('def_named3_large_railgun', 'def_robotshard_nuimqol_expert', 68),
('def_named3_large_railgun', 'def_unimetal', 300),
('def_named3_large_railgun', 'def_hydrobenol', 300),
('def_named3_large_railgun', 'def_polynitrocol', 300),
('def_named3_large_railgun', 'def_specimen_sap_item_flux', 50),

('def_named3_large_railgun_pr', 'def_named2_large_railgun', 1),
('def_named3_large_railgun_pr', 'def_robotshard_common_basic', 23),
('def_named3_large_railgun_pr', 'def_robotshard_common_advanced', 45),
('def_named3_large_railgun_pr', 'def_robotshard_common_expert', 68),
('def_named3_large_railgun_pr', 'def_robotshard_nuimqol_basic', 23),
('def_named3_large_railgun_pr', 'def_robotshard_nuimqol_advanced', 45),
('def_named3_large_railgun_pr', 'def_robotshard_nuimqol_expert', 68),
('def_named3_large_railgun_pr', 'def_unimetal', 300),
('def_named3_large_railgun_pr', 'def_hydrobenol', 300),
('def_named3_large_railgun_pr', 'def_polynitrocol', 300),
('def_named3_large_railgun_pr', 'def_specimen_sap_item_flux', 50),
--
('def_longrange_standard_large_railgun', 'def_titanium', 150),
('def_longrange_standard_large_railgun', 'def_axicoline', 150),
('def_longrange_standard_large_railgun', 'def_polynitrocol', 150),
('def_longrange_standard_large_railgun', 'def_axicol', 75),
('def_longrange_standard_large_railgun', 'def_chollonin', 75),
('def_longrange_standard_large_railgun', 'def_specimen_sap_item_flux', 10),

('def_named1_longrange_large_railgun', 'def_longrange_standard_large_railgun', 1),
('def_named1_longrange_large_railgun', 'def_robotshard_common_basic', 45),
('def_named1_longrange_large_railgun', 'def_robotshard_nuimqol_basic', 45),
('def_named1_longrange_large_railgun', 'def_titanium', 150),
('def_named1_longrange_large_railgun', 'def_axicoline', 150),
('def_named1_longrange_large_railgun', 'def_polynitrocol', 150),
('def_named1_longrange_large_railgun', 'def_axicol', 75),
('def_named1_longrange_large_railgun', 'def_chollonin', 75),
('def_named1_longrange_large_railgun', 'def_specimen_sap_item_flux', 10),

('def_named1_longrange_large_railgun_pr', 'def_longrange_standard_large_railgun', 1),
('def_named1_longrange_large_railgun_pr', 'def_robotshard_common_basic', 45),
('def_named1_longrange_large_railgun_pr', 'def_robotshard_nuimqol_basic', 45),
('def_named1_longrange_large_railgun_pr', 'def_titanium', 150),
('def_named1_longrange_large_railgun_pr', 'def_axicoline', 150),
('def_named1_longrange_large_railgun_pr', 'def_polynitrocol', 150),
('def_named1_longrange_large_railgun_pr', 'def_axicol', 75),
('def_named1_longrange_large_railgun_pr', 'def_chollonin', 75),
('def_named1_longrange_large_railgun_pr', 'def_specimen_sap_item_flux', 10),

('def_named2_longrange_large_railgun', 'def_named1_longrange_large_railgun', 1),
('def_named2_longrange_large_railgun', 'def_robotshard_common_basic', 30),
('def_named2_longrange_large_railgun', 'def_robotshard_common_advanced', 30),
('def_named2_longrange_large_railgun', 'def_robotshard_nuimqol_basic', 30),
('def_named2_longrange_large_railgun', 'def_robotshard_nuimqol_advanced', 30),
('def_named2_longrange_large_railgun', 'def_titanium', 150),
('def_named2_longrange_large_railgun', 'def_hydrobenol', 150),
('def_named2_longrange_large_railgun', 'def_polynitrocol', 150),
('def_named2_longrange_large_railgun', 'def_espitium', 75),
('def_named2_longrange_large_railgun', 'def_chollonin', 75),
('def_named2_longrange_large_railgun', 'def_specimen_sap_item_flux', 25),

('def_named2_longrange_large_railgun_pr', 'def_named1_longrange_large_railgun', 1),
('def_named2_longrange_large_railgun_pr', 'def_robotshard_common_basic', 30),
('def_named2_longrange_large_railgun_pr', 'def_robotshard_common_advanced', 30),
('def_named2_longrange_large_railgun_pr', 'def_robotshard_nuimqol_basic', 30),
('def_named2_longrange_large_railgun_pr', 'def_robotshard_nuimqol_advanced', 30),
('def_named2_longrange_large_railgun_pr', 'def_titanium', 150),
('def_named2_longrange_large_railgun_pr', 'def_hydrobenol', 150),
('def_named2_longrange_large_railgun_pr', 'def_polynitrocol', 150),
('def_named2_longrange_large_railgun_pr', 'def_espitium', 75),
('def_named2_longrange_large_railgun_pr', 'def_chollonin', 75),
('def_named2_longrange_large_railgun_pr', 'def_specimen_sap_item_flux', 25),

('def_named3_longrange_large_railgun', 'def_named2_longrange_large_railgun', 1),
('def_named3_longrange_large_railgun', 'def_robotshard_common_basic', 23),
('def_named3_longrange_large_railgun', 'def_robotshard_common_advanced', 45),
('def_named3_longrange_large_railgun', 'def_robotshard_common_expert', 68),
('def_named3_longrange_large_railgun', 'def_robotshard_nuimqol_basic', 23),
('def_named3_longrange_large_railgun', 'def_robotshard_nuimqol_advanced', 45),
('def_named3_longrange_large_railgun', 'def_robotshard_nuimqol_expert', 68),
('def_named3_longrange_large_railgun', 'def_unimetal', 300),
('def_named3_longrange_large_railgun', 'def_hydrobenol', 300),
('def_named3_longrange_large_railgun', 'def_polynitrocol', 300),
('def_named3_longrange_large_railgun', 'def_espitium', 150),
('def_named3_longrange_large_railgun', 'def_chollonin', 150),
('def_named3_longrange_large_railgun', 'def_specimen_sap_item_flux', 50),

('def_named3_longrange_large_railgun_pr', 'def_named2_longrange_large_railgun', 1),
('def_named3_longrange_large_railgun_pr', 'def_robotshard_common_basic', 23),
('def_named3_longrange_large_railgun_pr', 'def_robotshard_common_advanced', 45),
('def_named3_longrange_large_railgun_pr', 'def_robotshard_common_expert', 68),
('def_named3_longrange_large_railgun_pr', 'def_robotshard_nuimqol_basic', 23),
('def_named3_longrange_large_railgun_pr', 'def_robotshard_nuimqol_advanced', 45),
('def_named3_longrange_large_railgun_pr', 'def_robotshard_nuimqol_expert', 68),
('def_named3_longrange_large_railgun_pr', 'def_unimetal', 300),
('def_named3_longrange_large_railgun_pr', 'def_hydrobenol', 300),
('def_named3_longrange_large_railgun_pr', 'def_polynitrocol', 300),
('def_named3_longrange_large_railgun_pr', 'def_espitium', 150),
('def_named3_longrange_large_railgun_pr', 'def_chollonin', 150),
('def_named3_longrange_large_railgun_pr', 'def_specimen_sap_item_flux', 50),
--
('def_standard_cruisemissile_launcher', 'def_titanium', 150),
('def_standard_cruisemissile_launcher', 'def_axicoline', 150),
('def_standard_cruisemissile_launcher', 'def_phlobotil', 150),
('def_standard_cruisemissile_launcher', 'def_specimen_sap_item_flux', 10),

('def_named1_cruisemissile_launcher', 'def_standard_cruisemissile_launcher', 1),
('def_named1_cruisemissile_launcher', 'def_robotshard_common_basic', 45),
('def_named1_cruisemissile_launcher', 'def_robotshard_pelistal_basic', 45),
('def_named1_cruisemissile_launcher', 'def_titanium', 150),
('def_named1_cruisemissile_launcher', 'def_axicoline', 150),
('def_named1_cruisemissile_launcher', 'def_phlobotil', 150),
('def_named1_cruisemissile_launcher', 'def_specimen_sap_item_flux', 10),

('def_named1_cruisemissile_launcher_pr', 'def_standard_cruisemissile_launcher', 1),
('def_named1_cruisemissile_launcher_pr', 'def_robotshard_common_basic', 45),
('def_named1_cruisemissile_launcher_pr', 'def_robotshard_pelistal_basic', 45),
('def_named1_cruisemissile_launcher_pr', 'def_titanium', 150),
('def_named1_cruisemissile_launcher_pr', 'def_axicoline', 150),
('def_named1_cruisemissile_launcher_pr', 'def_phlobotil', 150),
('def_named1_cruisemissile_launcher_pr', 'def_specimen_sap_item_flux', 10),

('def_named2_cruisemissile_launcher', 'def_named1_cruisemissile_launcher', 1),
('def_named2_cruisemissile_launcher', 'def_robotshard_common_basic', 30),
('def_named2_cruisemissile_launcher', 'def_robotshard_common_advanced', 30),
('def_named2_cruisemissile_launcher', 'def_robotshard_pelistal_basic', 30),
('def_named2_cruisemissile_launcher', 'def_robotshard_pelistal_advanced', 30),
('def_named2_cruisemissile_launcher', 'def_titanium', 150),
('def_named2_cruisemissile_launcher', 'def_hydrobenol', 150),
('def_named2_cruisemissile_launcher', 'def_phlobotil', 150),
('def_named2_cruisemissile_launcher', 'def_specimen_sap_item_flux', 25),

('def_named2_cruisemissile_launcher_pr', 'def_named1_cruisemissile_launcher', 1),
('def_named2_cruisemissile_launcher_pr', 'def_robotshard_common_basic', 30),
('def_named2_cruisemissile_launcher_pr', 'def_robotshard_common_advanced', 30),
('def_named2_cruisemissile_launcher_pr', 'def_robotshard_pelistal_basic', 30),
('def_named2_cruisemissile_launcher_pr', 'def_robotshard_pelistal_advanced', 30),
('def_named2_cruisemissile_launcher_pr', 'def_titanium', 150),
('def_named2_cruisemissile_launcher_pr', 'def_hydrobenol', 150),
('def_named2_cruisemissile_launcher_pr', 'def_phlobotil', 150),
('def_named2_cruisemissile_launcher_pr', 'def_specimen_sap_item_flux', 25),

('def_named3_cruisemissile_launcher', 'def_named2_cruisemissile_launcher', 1),
('def_named3_cruisemissile_launcher', 'def_robotshard_common_basic', 23),
('def_named3_cruisemissile_launcher', 'def_robotshard_common_advanced', 45),
('def_named3_cruisemissile_launcher', 'def_robotshard_common_expert', 68),
('def_named3_cruisemissile_launcher', 'def_robotshard_pelistal_basic', 23),
('def_named3_cruisemissile_launcher', 'def_robotshard_pelistal_advanced', 45),
('def_named3_cruisemissile_launcher', 'def_robotshard_pelistal_expert', 68),
('def_named3_cruisemissile_launcher', 'def_unimetal', 300),
('def_named3_cruisemissile_launcher', 'def_hydrobenol', 300),
('def_named3_cruisemissile_launcher', 'def_phlobotil', 300),
('def_named3_cruisemissile_launcher', 'def_specimen_sap_item_flux', 50),

('def_named3_cruisemissile_launcher_pr', 'def_named2_cruisemissile_launcher', 1),
('def_named3_cruisemissile_launcher_pr', 'def_robotshard_common_basic', 23),
('def_named3_cruisemissile_launcher_pr', 'def_robotshard_common_advanced', 45),
('def_named3_cruisemissile_launcher_pr', 'def_robotshard_common_expert', 68),
('def_named3_cruisemissile_launcher_pr', 'def_robotshard_pelistal_basic', 23),
('def_named3_cruisemissile_launcher_pr', 'def_robotshard_pelistal_advanced', 45),
('def_named3_cruisemissile_launcher_pr', 'def_robotshard_pelistal_expert', 68),
('def_named3_cruisemissile_launcher_pr', 'def_unimetal', 300),
('def_named3_cruisemissile_launcher_pr', 'def_hydrobenol', 300),
('def_named3_cruisemissile_launcher_pr', 'def_phlobotil', 300),
('def_named3_cruisemissile_launcher_pr', 'def_specimen_sap_item_flux', 50);

PRINT N'DELETE components FOR ANY EXISTING LARGE WEPS (0 results if 1st run)';
SELECT * FROM components WHERE definition IN (SELECT definition FROM entitydefaults WHERE definitionname IN (SELECT DISTINCT defName FROM #WEPCOMPONENTS));
DELETE FROM components WHERE definition IN (SELECT definition FROM entitydefaults WHERE definitionname IN (SELECT DISTINCT defName FROM #WEPCOMPONENTS));

PRINT N'INSERT components FORLARGE WEPS';
INSERT INTO components (definition, componentdefinition, componentamount)
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=defName),
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=commodityName),
	amount
FROM #WEPCOMPONENTS;


DROP TABLE IF EXISTS #WEPCOMPONENTS;
GO


PRINT N'CALIBRATION TEMPLATES FOR WEAPONS';

DROP TABLE IF EXISTS #WEPCTS;
CREATE TABLE #WEPCTS 
(
	defName varchar(100),
	catFlags bigint,
	attrFlags bigint,
	cargoVolume float,
	massOfModule float,
	techType int,
	techLevel int,
	genxyOptStr varchar(max),
);

INSERT INTO #WEPCTS (defName, attrFlags, catFlags, cargoVolume, massOfModule, techType, techLevel, genxyOptStr) VALUES
('def_standard_large_laser_cprg', 1024, 33686550, 0.01, 0.1, 1, 1, '#tier=$tierlevel_t1'),
('def_named1_large_laser_cprg', 1024, 33686550, 0.01, 0.1, 1, 2, '#tier=$tierlevel_t2'),
('def_named2_large_laser_cprg', 1024, 33686550, 0.01, 0.1, 1, 3, '#tier=$tierlevel_t3'),
('def_named3_large_laser_cprg', 1024, 33686550, 0.01, 0.1, 1, 4, '#tier=$tierlevel_t4'),
--
('def_longrange_standard_large_laser_cprg', 1024, 33686550, 0.01, 0.1, 1, 1, '#tier=$tierlevel_t1'),
('def_named1_longrange_large_laser_cprg', 1024, 33686550, 0.01, 0.1, 1, 2, '#tier=$tierlevel_t2'),
('def_named2_longrange_large_laser_cprg', 1024, 33686550, 0.01, 0.1, 1, 3, '#tier=$tierlevel_t3'),
('def_named3_longrange_large_laser_cprg', 1024, 33686550, 0.01, 0.1, 1, 4, '#tier=$tierlevel_t4'),
--
('def_standard_cruisemissile_launcher_cprg', 1024, 67240982, 0.01, 0.1, 1, 1, '#tier=$tierlevel_t1'),
('def_named1_cruisemissile_launcher_cprg', 1024, 67240982, 0.01, 0.1, 1, 2, '#tier=$tierlevel_t2'),
('def_named2_cruisemissile_launcher_cprg', 1024, 67240982, 0.01, 0.1, 1, 3, '#tier=$tierlevel_t3'),
('def_named3_cruisemissile_launcher_cprg', 1024, 67240982, 0.01, 0.1, 1, 4, '#tier=$tierlevel_t4'),
--
('def_standard_large_railgun_cprg', 1024, 16909334, 0.01, 0.1, 1, 1, '#tier=$tierlevel_t1'),
('def_named1_large_railgun_cprg', 1024, 16909334, 0.01, 0.1, 1, 2, '#tier=$tierlevel_t2'),
('def_named2_large_railgun_cprg', 1024, 16909334, 0.01, 0.1, 1, 3, '#tier=$tierlevel_t3'),
('def_named3_large_railgun_cprg', 1024, 16909334, 0.01, 0.1, 1, 4, '#tier=$tierlevel_t4'),
--
('def_longrange_standard_large_railgun_cprg', 1024, 16909334, 0.01, 0.1, 1, 1, '#tier=$tierlevel_t1'),
('def_named1_longrange_large_railgun_cprg', 1024, 16909334, 0.01, 0.1, 1, 2, '#tier=$tierlevel_t2'),
('def_named2_longrange_large_railgun_cprg', 1024, 16909334, 0.01, 0.1, 1, 3, '#tier=$tierlevel_t3'),
('def_named3_longrange_large_railgun_cprg', 1024, 16909334, 0.01, 0.1, 1, 4, '#tier=$tierlevel_t4');


PRINT N'UPDATE/INSERT CTS';
--Update/insert [entitydefaults] entries
MERGE [dbo].[entitydefaults] def USING #WEPCTS ct
ON def.definition = (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=ct.defName)
WHEN MATCHED
    THEN UPDATE SET
		categoryflags=catFlags,
		attributeflags=attrFlags,
		volume=cargoVolume,
		mass=massOfModule,
		tiertype=techType,
		tierlevel=techLevel,
		options=genxyOptStr,
		enabled=1,
		hidden=0,
		purchasable=0,
		descriptiontoken='calibration_program_desc'
WHEN NOT MATCHED
    THEN INSERT (definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel) VALUES
	(defName, 1, attrFlags,catFlags,genxyOptStr,'CT large weapon',1,cargoVolume,massOfModule,0,100,'calibration_program_desc',0,techType,techLevel);

PRINT N'DELETE calibrationdefaults FOR ANY EXISTING LARGE WEP CTS (0 results if 1st run)';
SELECT * FROM calibrationdefaults WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #WEPCTS));
DELETE FROM calibrationdefaults WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT defName FROM #WEPCTS));

PRINT N'INSERT calibrationdefaults FOR WEP CTS';
INSERT INTO calibrationdefaults (definition, materialefficiency, timeefficiency)
SELECT (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = defName), 70, 70 FROM #WEPCTS;

DROP TABLE IF EXISTS #PROTO_TO_CT;
CREATE TABLE #PROTO_TO_CT
(
	protoDefName VARCHAR(100),
	ctDefName VARCHAR(100),
	level INT
);

INSERT INTO #PROTO_TO_CT (protoDefName, ctDefName, level) VALUES
('def_standard_large_laser', 'def_standard_large_laser_cprg', 5),
('def_named1_large_laser_pr', 'def_named1_large_laser_cprg', 6),
('def_named2_large_laser_pr', 'def_named2_large_laser_cprg', 7),
('def_named3_large_laser_pr', 'def_named3_large_laser_cprg', 8),
--
('def_longrange_standard_large_laser', 'def_longrange_standard_large_laser_cprg', 5),
('def_named1_longrange_large_laser_pr', 'def_named1_longrange_large_laser_cprg', 6),
('def_named2_longrange_large_laser_pr', 'def_named2_longrange_large_laser_cprg', 7),
('def_named3_longrange_large_laser_pr', 'def_named3_longrange_large_laser_cprg', 8),
--
('def_standard_cruisemissile_launcher', 'def_standard_cruisemissile_launcher_cprg', 5),
('def_named1_cruisemissile_launcher_pr', 'def_named1_cruisemissile_launcher_cprg', 6),
('def_named2_cruisemissile_launcher_pr', 'def_named2_cruisemissile_launcher_cprg', 7),
('def_named3_cruisemissile_launcher_pr', 'def_named3_cruisemissile_launcher_cprg', 8),
--
('def_standard_large_railgun', 'def_standard_large_railgun_cprg', 5),
('def_named1_large_railgun_pr', 'def_named1_large_railgun_cprg', 6),
('def_named2_large_railgun_pr', 'def_named2_large_railgun_cprg', 7),
('def_named3_large_railgun_pr', 'def_named3_large_railgun_cprg', 8),
--
('def_longrange_standard_large_railgun', 'def_longrange_standard_large_railgun_cprg', 5),
('def_named1_longrange_large_railgun_pr', 'def_named1_longrange_large_railgun_cprg', 6),
('def_named2_longrange_large_railgun_pr', 'def_named2_longrange_large_railgun_cprg', 7),
('def_named3_longrange_large_railgun_pr', 'def_named3_longrange_large_railgun_cprg', 8);


PRINT N'DELETE itemresearchlevels FOR ANY EXISTING LARGE WEP CTS (0 results if 1st run)';
SELECT * FROM itemresearchlevels WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT protoDefName FROM #PROTO_TO_CT));
DELETE FROM itemresearchlevels WHERE definition in (SELECT definition FROM entitydefaults WHERE definitionname in (SELECT DISTINCT protoDefName FROM #PROTO_TO_CT));

PRINT N'INSERT itemresearchlevels FOR WEP CTS';
INSERT INTO itemresearchlevels (definition, calibrationprogram, researchlevel, enabled)
SELECT 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = protoDefName), 
	(SELECT TOP 1 definition FROM entitydefaults WHERE definitionname = ctDefName), 
	level, 1
FROM #PROTO_TO_CT;


DROP TABLE IF EXISTS #WEPCTS;
DROP TABLE IF EXISTS #PROTO_TO_CT;
GO