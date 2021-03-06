/****** Object:  Table [dbo].[Event]    Script Date: 5/15/2018 12:02:20 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Event](
	[EventID] [uniqueidentifier] NOT NULL,
	[EventType] [nvarchar](260) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[EventData] [nvarchar](260) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[TimeEntered] [datetime] NOT NULL,
	[ProcessStart] [datetime] NULL,
	[ProcessHeartbeat] [datetime] NULL,
	[BatchID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Event] PRIMARY KEY CLUSTERED 
(
	[EventID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [IX_Event_TimeEntered]    Script Date: 5/15/2018 12:02:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_Event_TimeEntered] ON [dbo].[Event]
(
	[TimeEntered] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [IX_Event2]    Script Date: 5/15/2018 12:02:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_Event2] ON [dbo].[Event]
(
	[ProcessStart] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
