USE [perpetuumsa]
GO

------------------------------------------------------------------
--Add teleport column to Omega (stronghold zone)
--Adds or updates zoneentities
--Date modified: 2020/04/03
------------------------------------------------------------------

DECLARE @targetZoneID int;
SET @targetZoneID = (SELECT TOP 1 id FROM zones WHERE name='zone_pvp_arena' AND zonetype=4);

DECLARE @ename VARCHAR(128);
SET @ename = 'tp_zone_strnghld_01';

DECLARE @parentEntity bigint;
SET @parentEntity = (SELECT TOP 1 eid from entitystorage where storage_name='teleport_column');

DECLARE @eid bigint;
SET @eid = 50000;

IF NOT EXISTS (SELECT eid FROM entities WHERE ename=@ename)
BEGIN
	INSERT INTO entities (eid, definition, owner, parent, health, ename, quantity, repackaged, dynprop) VALUES
	(@eid, 1394, NULL, @parentEntity, 100, @ename, 1, 0, '#enabled=i1');
END
ELSE
BEGIN
	UPDATE entities SET
		eid=@eid,
		definition=1394,
		parent=@parentEntity,
		health=100,
		quantity=1,
		repackaged=0,
		dynprop='#enabled=i1'
	WHERE ename=@ename;
END


IF NOT EXISTS (SELECT eid FROM zoneentities WHERE ename=@ename)
BEGIN
	INSERT INTO zoneentities (zoneID, eid, definition, owner, ename, x, y, z, orientation, enabled, note, runtime, synckey) VALUES 
	(@targetZoneID, @eid, NULL, NULL, @ename, 1108, 1048, 50, 128, 1, 'stronghold teleport 1', 0, 'tp_strnghld_01');
END
ELSE
BEGIN
	UPDATE zoneentities SET
		zoneID = @targetZoneID,
		eid=@eid,
		x = 1108,
		y = 1048,
		z = 50,
		orientation = 128,
		enabled = 1,
		note = 'stronghold teleport 1',
		runtime = 0,
		synckey = 'tp_strnghld_01'
	WHERE ename=@ename;
END

GO