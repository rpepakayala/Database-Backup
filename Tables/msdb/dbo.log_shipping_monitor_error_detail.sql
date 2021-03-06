/****** Object:  Table [dbo].[log_shipping_monitor_error_detail]    Script Date: 5/15/2018 12:02:57 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[log_shipping_monitor_error_detail](
	[agent_id] [uniqueidentifier] NOT NULL,
	[agent_type] [tinyint] NOT NULL,
	[session_id] [int] NOT NULL,
	[database_name] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[sequence_number] [int] NOT NULL,
	[log_time] [datetime] NOT NULL,
	[log_time_utc] [datetime] NOT NULL,
	[message] [nvarchar](4000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[source] [nvarchar](4000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[help_url] [nvarchar](4000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]

/****** Object:  Index [c1lsmonitor_error_detail]    Script Date: 5/15/2018 12:02:57 PM ******/
CREATE CLUSTERED INDEX [c1lsmonitor_error_detail] ON [dbo].[log_shipping_monitor_error_detail]
(
	[agent_id] ASC,
	[agent_type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [nc2lsmonitor_error_detail]    Script Date: 5/15/2018 12:02:57 PM ******/
CREATE NONCLUSTERED INDEX [nc2lsmonitor_error_detail] ON [dbo].[log_shipping_monitor_error_detail]
(
	[database_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [nc3lsmonitor_error_detail]    Script Date: 5/15/2018 12:02:57 PM ******/
CREATE NONCLUSTERED INDEX [nc3lsmonitor_error_detail] ON [dbo].[log_shipping_monitor_error_detail]
(
	[log_time_utc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
