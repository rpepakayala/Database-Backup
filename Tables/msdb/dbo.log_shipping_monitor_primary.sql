/****** Object:  Table [dbo].[log_shipping_monitor_primary]    Script Date: 5/15/2018 12:02:57 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[log_shipping_monitor_primary](
	[primary_id] [uniqueidentifier] NOT NULL,
	[primary_server] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[primary_database] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[backup_threshold] [int] NOT NULL,
	[threshold_alert] [int] NOT NULL,
	[threshold_alert_enabled] [bit] NOT NULL,
	[last_backup_file] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[last_backup_date] [datetime] NULL,
	[last_backup_date_utc] [datetime] NULL,
	[history_retention_period] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[primary_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [uc1lsmonitor_primary]    Script Date: 5/15/2018 12:02:57 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [uc1lsmonitor_primary] ON [dbo].[log_shipping_monitor_primary]
(
	[primary_server] ASC,
	[primary_database] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
