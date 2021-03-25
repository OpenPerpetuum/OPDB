USE [perpetuumsa]
GO


DECLARE @riftDefId AS INT = 5998;
DECLARE @riftDefName AS VARCHAR(100) = 'def_rift_targetted_portal'; --must match server enum
DECLARE @attFlags AS BIGINT = 939524098;
DECLARE @catFlags AS BIGINT = 3218;
DECLARE @opts AS VARCHAR(100) = '#height=f6.00';
DECLARE @note AS VARCHAR(100) = 'Rift for targetted jumps';


IF NOT EXISTS (SELECT TOP 1 definition FROM entitydefaults WHERE definitionname=@riftDefName)
BEGIN
	SET IDENTITY_INSERT entitydefaults ON;
	INSERT INTO entitydefaults (definition,definitionname,quantity,attributeflags,categoryflags,options,note,enabled,volume,mass,hidden,health,descriptiontoken,purchasable,tiertype,tierlevel) VALUES
	(@riftDefId,@riftDefName,1,@attFlags,@catFlags,@opts,@note,1,0,0,0,100,@riftDefName+'_desc',0,NULL,NULL);
	SET IDENTITY_INSERT entitydefaults OFF;
END
ELSE
BEGIN
	UPDATE entitydefaults SET
		attributeflags=@attFlags,
		categoryflags=@catFlags,
		options=@opts,
		note=@note
	WHERE definitionname=@riftDefName;
END

GO