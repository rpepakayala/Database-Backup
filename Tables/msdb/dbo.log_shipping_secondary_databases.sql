/****** Object:  Table [dbo].[log_shipping_secondary_databases]    Script Date: 5/15/2018 12:02:58 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[log_shipping_secondary_databases](
	[secondary_database] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[secondary_id] [uniqueidentifier] NOT NULL,
	[restore_delay] [int] NOT NULL,
	[restore_all] [bit] NOT NULL,
	[restore_mode] [bit] NOT NULL,
	[disconnect_users] [bit] NOT NULL,
	[block_size] [int] NULL,
	[buffer_count] [int] NULL,
	[max_transfer_size] [int] NULL,
	[last_restored_file] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[last_restored_date] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[secondary_database] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [nc1lssecondary_databases]    Script Date: 5/15/2018 12:02:58 PM ******/
CREATE NONCLUSTERED INDEX [nc1lssecondary_databases] ON [dbo].[log_shipping_secondary_databases]
(
	[secondary_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
