/****** Object:  Table [dbo].[SyncTaskExecution]    Script Date: 5/15/2018 12:02:11 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[SyncTaskExecution](
	[Id] [uniqueidentifier] NOT NULL,
	[StartTime] [datetimeoffset](7) NOT NULL,
	[EndTime] [datetimeoffset](7) NULL,
	[ErrorMessage] [varchar](1024) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Status] [int] NOT NULL,
	[UsesOwnAppdomain] [tinyint] NOT NULL,
	[SyncStopAction] [int] NULL,
	[WatchdogUpdateTime] [datetimeoffset](7) NULL,
	[TaskId] [uniqueidentifier] NULL,
	[ResultId] [int] NULL,
	[SchedulerExecutionId] [uniqueidentifier] NULL,
 CONSTRAINT [pk_SyncTaskExecution] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
