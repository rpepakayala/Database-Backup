/****** Object:  Table [dbo].[syssubsystems]    Script Date: 5/15/2018 12:03:12 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[syssubsystems](
	[subsystem_id] [int] NOT NULL,
	[subsystem] [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[description_id] [int] NULL,
	[subsystem_dll] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[agent_exe] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[start_entry_point] [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[event_entry_point] [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[stop_entry_point] [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[max_worker_threads] [int] NULL
) ON [PRIMARY]

/****** Object:  Index [clust]    Script Date: 5/15/2018 12:03:12 PM ******/
CREATE UNIQUE CLUSTERED INDEX [clust] ON [dbo].[syssubsystems]
(
	[subsystem_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [nc1]    Script Date: 5/15/2018 12:03:12 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [nc1] ON [dbo].[syssubsystems]
(
	[subsystem] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
