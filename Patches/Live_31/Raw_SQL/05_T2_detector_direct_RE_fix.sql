PRINT N'Forbid Reverse Engineer T2 signal detector';

UPDATE [dbo].[itemresearchlevels] 
    SET [enabled] = 0 
    WHERE definition IN (SELECT definition FROM entitydefaults WHERE definitionname='def_named1_detection_modul');

GO