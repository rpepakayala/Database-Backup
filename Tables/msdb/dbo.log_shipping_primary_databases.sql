/****** Object:  Table [dbo].[log_shipping_primary_databases]    Script Date: 5/15/2018 12:02:58 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[log_shipping_primary_databases](
	[primary_id] [uniqueidentifier] NOT NULL,
	[primary_database] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[backup_directory] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[backup_share] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[backup_retention_period] [int] NOT NULL,
	[backup_job_id] [uniqueidentifier] NOT NULL,
	[monitor_server] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[user_specified_monitor] [bit] NULL,
	[monitor_server_security_mode] [bit] NOT NULL,
	[last_backup_file] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[last_backup_date] [datetime] NULL,
	[backup_compression] [tinyint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[primary_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[primary_database] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [nc1lsprimary_databases]    Script Date: 5/15/2018 12:02:58 PM ******/
CREATE NONCLUSTERED INDEX [nc1lsprimary_databases] ON [dbo].[log_shipping_primary_databases]
(
	[monitor_server] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [nc2lsprimary_databases]    Script Date: 5/15/2018 12:02:58 PM ******/
CREATE NONCLUSTERED INDEX [nc2lsprimary_databases] ON [dbo].[log_shipping_primary_databases]
(
	[user_specified_monitor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [uc1lsprimary_databases]    Script Date: 5/15/2018 12:02:58 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [uc1lsprimary_databases] ON [dbo].[log_shipping_primary_databases]
(
	[primary_database] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[log_shipping_primary_databases] ADD  DEFAULT ((2)) FOR [backup_compression]
GO
