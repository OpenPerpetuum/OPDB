USE [perpetuumsa]
GO

--------------------------------------------------
-- Increase HP of concrete layers (devrinol) to 50k effective HP
--
-- Devrinol plant rules represent concrete layer terrain tiles.
-- Base health set to 250 with damageScale set to 0.005
-- (250 / 0.005 = 50,000 effective HP) across all growing states
-- in Server/data/plantrules/devrinol.txt and devrinol_wild.txt.
--
-- Date modified: 2026-09-16
--------------------------------------------------

PRINT N'Increase concrete layer HP to 50k effective HP (devrinol.txt / devrinol_wild.txt: damageScale=0.005, health=250)';

GO
