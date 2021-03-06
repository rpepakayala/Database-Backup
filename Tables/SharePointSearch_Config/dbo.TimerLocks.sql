/****** Object:  Table [dbo].[TimerLocks]    Script Date: 5/15/2018 12:06:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[TimerLocks](
	[JobId] [uniqueidentifier] NULL,
	[LockedByServerName] [nvarchar](128) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[LockedTime] [datetime] NOT NULL
) ON [PRIMARY]

/****** Object:  Index [IX_TimerLocks_JobId]    Script Date: 5/15/2018 12:06:08 PM ******/
CREATE UNIQUE CLUSTERED INDEX [IX_TimerLocks_JobId] ON [dbo].[TimerLocks]
(
	[JobId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [IX_TimerLocks_LockedByServerName]    Script Date: 5/15/2018 12:06:08 PM ******/
CREATE NONCLUSTERED INDEX [IX_TimerLocks_LockedByServerName] ON [dbo].[TimerLocks]
(
	[LockedByServerName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
