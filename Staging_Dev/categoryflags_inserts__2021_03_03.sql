USE [perpetuumsa]
GO

DROP TABLE IF EXISTS #CATS;
CREATE TABLE #CATS(
	catName VARCHAR(100),
	catValue BIGINT
);
INSERT INTO #CATS (catName, catValue) VALUES
('cf_ep_boosters',							CONVERT(BIGINT, 0x0000059b)),
('cf_paints',								CONVERT(BIGINT, 0x0000069b)),
('cf_datashards',							CONVERT(BIGINT, 0x00000694)),
('cf_ct_capsules',							CONVERT(BIGINT, 0x00000794)),
('cf_ct_capsules_ammo',						CONVERT(BIGINT, 0x00010794)),
('cf_ct_capsules_ammo_laser',				CONVERT(BIGINT, 0x01010794)),
('cf_ct_capsules_ammo_railgun',				CONVERT(BIGINT, 0x02010794)),
('cf_ct_capsules_ammo_projectile',			CONVERT(BIGINT, 0x03010794)),
('cf_ct_capsules_ammo_missile',				CONVERT(BIGINT, 0x04010794)),
('cf_ct_capsules_equipment',				CONVERT(BIGINT, 0x00020794)),
('cf_ct_capsules_equipment_armor',			CONVERT(BIGINT, 0x01020794)),
('cf_ct_capsules_equipment_ewar',			CONVERT(BIGINT, 0x02020794)),
('cf_ct_capsules_equipment_electronics',	CONVERT(BIGINT, 0x03020794)),
('cf_ct_capsules_equipment_engineering',	CONVERT(BIGINT, 0x04020794)),
('cf_ct_capsules_equipment_industrial',		CONVERT(BIGINT, 0x05020794)),
('cf_ct_capsules_equipment_shield',			CONVERT(BIGINT, 0x06020794)),
('cf_ct_capsules_equipment_weapons',		CONVERT(BIGINT, 0x07020794)),
('cf_ct_capsules_equipment_nexus',			CONVERT(BIGINT, 0x08020794)),
('cf_ct_capsules_robot',					CONVERT(BIGINT, 0x00030794)),
('cf_ct_capsules_robot_pelistal',			CONVERT(BIGINT, 0x0001030794)),
('cf_ct_capsules_robot_pelistal_light',		CONVERT(BIGINT, 0x0101030794)),
('cf_ct_capsules_robot_pelistal_assault',	CONVERT(BIGINT, 0x0201030794)),
('cf_ct_capsules_robot_pelistal_mech',		CONVERT(BIGINT, 0x0301030794)),
('cf_ct_capsules_robot_pelistal_heavymech', CONVERT(BIGINT, 0x0401030794)),
('cf_ct_capsules_robot_thelodica',			CONVERT(BIGINT, 0x0002030794)),
('cf_ct_capsules_robot_thelodica_light',	CONVERT(BIGINT, 0x0102030794)),
('cf_ct_capsules_robot_thelodica_assault',	CONVERT(BIGINT, 0x0202030794)),
('cf_ct_capsules_robot_thelodica_mech',		CONVERT(BIGINT, 0x0302030794)),
('cf_ct_capsules_robot_thelodica_heavymech', CONVERT(BIGINT, 0x0402030794)),
('cf_ct_capsules_robot_nuimqol',			CONVERT(BIGINT, 0x0003030794)),
('cf_ct_capsules_robot_nuimqol_light',		CONVERT(BIGINT, 0x0103030794)),
('cf_ct_capsules_robot_nuimqol_assault',	CONVERT(BIGINT, 0x0203030794)),
('cf_ct_capsules_robot_nuimqol_mech',		CONVERT(BIGINT, 0x0303030794)),
('cf_ct_capsules_robot_nuimqol_heavymech',	CONVERT(BIGINT, 0x0403030794)),
('cf_ct_capsules_robot_industrial',			CONVERT(BIGINT, 0x0004030794)),
('cf_ct_capsules_robot_industrial_light',	CONVERT(BIGINT, 0x0104030794)),
('cf_ct_capsules_robot_industrial_assault', CONVERT(BIGINT, 0x0204030794)),
('cf_ct_capsules_robot_industrial_mech',	CONVERT(BIGINT, 0x0304030794)),
('cf_ct_capsules_robot_industrial_heavymech', CONVERT(BIGINT, 0x0404030794)),
('cf_ct_capsules_robot_syndicate',			CONVERT(BIGINT, 0x0005030794)),
('cf_ct_capsules_robot_syndicate_light',	CONVERT(BIGINT, 0x0105030794)),
('cf_ct_capsules_robot_syndicate_assault',	CONVERT(BIGINT, 0x0205030794)),
('cf_ct_capsules_robot_syndicate_mech',		CONVERT(BIGINT, 0x0305030794)),
('cf_ct_capsules_robot_syndicate_heavymech', CONVERT(BIGINT, 0x0405030794)),
('cf_ct_capsules_misc',						CONVERT(BIGINT, 0x00040794));


DELETE FROM categoryFlags WHERE name in (SELECT DISTINCT catName FROM #CATS);
INSERT INTO categoryFlags (value, name, note, hidden, isunique)
SELECT catValue, catName, 'new opp cat', 0, 0 FROM #CATS;

--Print function to generate the enum values for server code
--SELECT CONCAT(name,' = ', CONVERT(VARCHAR(MAX),CONVERT(varbinary(8),value), 1), ',') FROM categoryFlags ORDER BY name;

--Print function to generate the enum values for the resource server
--SELECT CONCAT(
--'  |',(ROW_NUMBER() OVER (ORDER BY name)-1),
--'=[|value=L',
--LOWER(SUBSTRING(CONVERT(VARCHAR(MAX),CONVERT(varbinary(8),value), 2), patindex('%[^0]%',CONVERT(VARCHAR(MAX),CONVERT(varbinary(8),value), 2)), 10)),
--'|name=$',name,
--'|hidden=i',hidden,']') FROM categoryFlags ORDER BY name;

DROP TABLE IF EXISTS #CATS;
GO