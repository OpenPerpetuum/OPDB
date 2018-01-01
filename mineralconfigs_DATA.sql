
USE [perpetuumsa]
GO

INSERT INTO [dbo].[mineralconfigs]
           ([zoneid]
           ,[materialtype]
           ,[maxnodes]
           ,[maxtilespernode]
           ,[totalamountpernode]
           ,[minthreshold])
     VALUES
           (0
           ,3
           ,8
           ,314
           ,37500000
           ,.5)

INSERT INTO [dbo].[mineralconfigs]
           ([zoneid]
           ,[materialtype]
           ,[maxnodes]
           ,[maxtilespernode]
           ,[totalamountpernode]
           ,[minthreshold])
     VALUES
           (8
           ,3
           ,8
           ,314
           ,37500000
           ,.5)

UPDATE [dbo].[mineralconfigs]
   SET [zoneid] = 8
      ,[materialtype] = 4
      ,[maxnodes] = 8
      ,[maxtilespernode] = 314
      ,[totalamountpernode] = 37500000
      ,[minthreshold] = .5
 WHERE ID=8

UPDATE [dbo].[mineralconfigs]
   SET [zoneid] = 0
      ,[materialtype] = 4
      ,[maxnodes] = 8
      ,[maxtilespernode] = 314
      ,[totalamountpernode] = 37500000
      ,[minthreshold] = .5
 WHERE ID=7


GO
