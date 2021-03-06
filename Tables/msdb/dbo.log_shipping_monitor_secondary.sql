/****** Object:  Table [dbo].[log_shipping_monitor_secondary]    Script Date: 5/15/2018 12:02:57 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[log_shipping_monitor_secondary](
	[secondary_server] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[secondary_database] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[secondary_id] [uniqueidentifier] NOT NULL,
	[primary_server] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[primary_database] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[restore_threshold] [int] NOT NULL,
	[threshold_alert] [int] NOT NULL,
	[threshold_alert_enabled] [bit] NOT NULL,
	[last_copied_file] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[last_copied_date] [datetime] NULL,
	[last_copied_date_utc] [datetime] NULL,
	[last_restored_file] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[last_restored_date] [datetime] NULL,
	[last_restored_date_utc] [datetime] NULL,
	[last_restored_latency] [int] NULL,
	[history_retention_period] [int] NOT NULL,
 CONSTRAINT [pklsmonitor_secondary] PRIMARY KEY CLUSTERED 
(
	[secondary_id] ASC,
	[secondary_database] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [nc1lsmonitor_secondary]    Script Date: 5/15/2018 12:02:57 PM ******/
CREATE NONCLUSTERED INDEX [nc1lsmonitor_secondary] ON [dbo].[log_shipping_monitor_secondary]
(
	[secondary_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [nc2lsmonitor_secondary]    Script Date: 5/15/2018 12:02:57 PM ******/
CREATE NONCLUSTERED INDEX [nc2lsmonitor_secondary] ON [dbo].[log_shipping_monitor_secondary]
(
	[restore_threshold] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [nc3lsmonitor_secondary]    Script Date: 5/15/2018 12:02:57 PM ******/
CREATE NONCLUSTERED INDEX [nc3lsmonitor_secondary] ON [dbo].[log_shipping_monitor_secondary]
(
	[last_restored_latency] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [uc1lsmonitor_secondary]    Script Date: 5/15/2018 12:02:57 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [uc1lsmonitor_secondary] ON [dbo].[log_shipping_monitor_secondary]
(
	[secondary_server] ASC,
	[secondary_database] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
