USE [perpetuumsa]
GO

------------------------------------
-- Fix construction module tech level genxy
-- Contributor: Junelicious
-- Date modified: 2021/11/24
------------------------------------


PRINT N'UPDATE ENTITYDEFAULT FOR CONSTRUCTION MOD GENXY STR';
UPDATE entitydefaults SET
	options = '#moduleFlag=i290#ammoCapacity=i2d#ammoType=L1110a#tier=$tierlevel_t1'
WHERE definitionname = 'def_pbs_construction_module';

GO