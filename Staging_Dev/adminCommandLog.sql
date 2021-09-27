USE [perpetuumsa]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [dbo].[adminCommandLog]
GO

CREATE TABLE [dbo].[adminCommandLog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[eventtime] [datetime] NOT NULL,
	[characterid] [int] NOT NULL,
	[accLevel] [int] NOT NULL,
	[message] [nvarchar](255) NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[adminCommandLog] ADD  CONSTRAINT [DF_adminCommandLog_eventtime]  DEFAULT (getdate()) FOR [eventtime]
GO