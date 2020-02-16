USE [perpetuumsa]
GO

-----------------------------------------------
--Entitydefaults update description tokens for resource server support
--Date: 2020/02/09
-----------------------------------------------

UPDATE entitydefaults SET
	descriptiontoken = definitionname+'_desc'
WHERE definition < 5726 AND definition > 5547;

GO