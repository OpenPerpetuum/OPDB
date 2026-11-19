USE perpetuumsa;
GO

UPDATE dbo.entitydefaults SET quantity = 10, tiertype = NULL, tierlevel = NULL where definitionname = 'def_standard_hunter_drone_rcu_pve'
UPDATE dbo.entitydefaults SET quantity = 1, tiertype = NULL, tierlevel = NULL where definitionname = 'def_standard_hunter_drone_rcu_pve_cprg'
UPDATE dbo.entitydefaults SET quantity = 10, tiertype = NULL, tierlevel = NULL where definitionname = 'def_standard_hunter_drone_rcu_pvp'
UPDATE dbo.entitydefaults SET quantity = 1, tiertype = NULL, tierlevel = NULL where definitionname = 'def_standard_hunter_drone_rcu_pvp_cprg'

GO