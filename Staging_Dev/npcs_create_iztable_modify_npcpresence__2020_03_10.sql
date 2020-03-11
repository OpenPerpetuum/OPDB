USE [perpetuumsa]
GO


IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[npcpresence]') 
         AND name = 'izgroupid'
)
BEGIN
	ALTER TABLE [dbo].[npcpresence]
	  ADD izgroupid INT NULL;
END

DROP TABLE IF EXISTS dbo.npcinterzonegroup;

CREATE TABLE dbo.npcinterzonegroup(
	id INT NOT NULL IDENTITY PRIMARY KEY,
	name VARCHAR(64) NOT NULL
);


GO