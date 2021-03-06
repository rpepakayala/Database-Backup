/****** Object:  Table [dbo].[SyncSchedulerExecution]    Script Date: 5/15/2018 12:02:10 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[SyncSchedulerExecution](
	[Id] [uniqueidentifier] NOT NULL,
	[ProcessId] [int] NOT NULL,
	[SchedulerName] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[StartTime] [datetimeoffset](7) NOT NULL,
	[EndTime] [datetimeoffset](7) NULL,
	[WatchdogUpdateTime] [datetimeoffset](7) NULL,
	[ImportContextUpdateTime] [datetimeoffset](7) NULL,
	[Status] [int] NOT NULL,
	[ErrorMessage] [varchar](1024) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [pk_SyncSchedulerExecution] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [ix_sync_ex_name]    Script Date: 5/15/2018 12:02:10 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [ix_sync_ex_name] ON [dbo].[SyncSchedulerExecution]
(
	[SchedulerName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
