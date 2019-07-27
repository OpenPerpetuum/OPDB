USE [perpetuumsa]
GO

------------------------------------------------------------
--World Shaping: Move NV and Hersh to center, adjust beta circle
--Date modified: 2019/07/27
--------------------------------------------------------


DECLARE @NewVirginia int;
DECLARE @Hershfield int;
DECLARE @Domhalarn int;
DECLARE @Hokkogaros int;
DECLARE @Norhoop int;
DECLARE @Kentagura int;
DECLARE @Alsbale int;
DECLARE @Novastrov int;

DECLARE @Omega int;

DECLARE @Xiantor int;
DECLARE @Chalydor int;
DECLARE @Emperth int;


SET @NewVirginia = (SELECT TOP 1 id FROM dbo.zones WHERE name='zone_TM' AND note='new virginia');
SET @Hershfield = (SELECT TOP 1 id FROM dbo.zones WHERE name='zone_TM_pve' AND note='hershfield');
SET @Domhalarn = (SELECT TOP 1 id FROM dbo.zones WHERE name='zone_ICS_A_real' AND note='domhalarn');
SET @Hokkogaros = (SELECT TOP 1 id FROM dbo.zones WHERE name='zone_ASI_A_real' AND note='hokkogaros');
SET @Norhoop = (SELECT TOP 1 id FROM dbo.zones WHERE name='zone_TM_A_real' AND note='norhoop');
SET @Kentagura = (SELECT TOP 1 id FROM dbo.zones WHERE name='zone_ASI_pvp' AND note='kentagura');
SET @Alsbale = (SELECT TOP 1 id FROM dbo.zones WHERE name='zone_TM_pvp' AND note='alsbale');
SET @Novastrov = (SELECT TOP 1 id FROM dbo.zones WHERE name='zone_ICS_pvp' AND note='novastrov');

SET @Omega = (SELECT TOP 1 id FROM dbo.zones WHERE name='zone_pvp_arena' AND note='pvp arena');

SET @Xiantor = (SELECT TOP 1 id FROM dbo.zones WHERE name='zone_asi_g_4' AND note='Xiantor');
SET @Chalydor  = (SELECT TOP 1 id FROM dbo.zones WHERE name='zone_ics_g_8');
SET @Emperth  = (SELECT TOP 1 id FROM dbo.zones WHERE name='zone_tm_g_3');


--- Vanilla Islands Pre Gamma
PRINT N'Alpha/Beta islands relocation';
UPDATE zones SET 
x = 0,
y = -1000
WHERE id= @NewVirginia;

UPDATE zones SET
 x= -2000,
 y= -1000
WHERE id= @Hershfield

UPDATE zones SET
 x= -5000,
 y= -2500
WHERE id= @Hokkogaros;

UPDATE zones SET
 x= -1000,
 y= -4000
WHERE id= @Novastrov;

UPDATE zones SET
x= 3000,
y= -2500
WHERE id= @Domhalarn;

UPDATE zones SET
 x= 3000,
 y= 500
WHERE id= @Alsbale;

UPDATE zones SET
x= -1000,
y= 2000
WHERE id= @Norhoop;

UPDATE zones SET
 x= -5000,
 y= 500
WHERE id= @Kentagura;


UPDATE zones SET
 x= 10000,
 y= 10000
WHERE id= @Omega;


--- Gamma islands Island location revamp
PRINT N'Gamma location prep - still hidden';

UPDATE zones SET
x= 5000,
y= -12000
WHERE id= @Emperth;

UPDATE zones SET
 x= -1000,
 y= -10000
WHERE id= @Chalydor;

UPDATE zones SET
 x= -7000,
 y= -12000
WHERE id= @Xiantor;

GO
