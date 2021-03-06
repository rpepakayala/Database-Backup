/****** Object:  Table [dbo].[log_shipping_secondary]    Script Date: 5/15/2018 12:02:58 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[log_shipping_secondary](
	[secondary_id] [uniqueidentifier] NOT NULL,
	[primary_server] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[primary_database] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[backup_source_directory] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[backup_destination_directory] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[file_retention_period] [int] NOT NULL,
	[copy_job_id] [uniqueidentifier] NOT NULL,
	[restore_job_id] [uniqueidentifier] NOT NULL,
	[monitor_server] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[monitor_server_security_mode] [bit] NOT NULL,
	[user_specified_monitor] [bit] NULL,
	[last_copied_file] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[last_copied_date] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[secondary_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [nc1lssecondary]    Script Date: 5/15/2018 12:02:58 PM ******/
CREATE NONCLUSTERED INDEX [nc1lssecondary] ON [dbo].[log_shipping_secondary]
(
	[monitor_server] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [nc2lssecondary]    Script Date: 5/15/2018 12:02:58 PM ******/
CREATE NONCLUSTERED INDEX [nc2lssecondary] ON [dbo].[log_shipping_secondary]
(
	[user_specified_monitor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [uc1lssecondary]    Script Date: 5/15/2018 12:02:58 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [uc1lssecondary] ON [dbo].[log_shipping_secondary]
(
	[primary_server] ASC,
	[primary_database] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
