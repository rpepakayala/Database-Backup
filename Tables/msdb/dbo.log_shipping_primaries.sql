/****** Object:  Table [dbo].[log_shipping_primaries]    Script Date: 5/15/2018 12:02:57 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[log_shipping_primaries](
	[primary_id] [int] IDENTITY(1,1) NOT NULL,
	[primary_server_name] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[primary_database_name] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[maintenance_plan_id] [uniqueidentifier] NULL,
	[backup_threshold] [int] NOT NULL,
	[threshold_alert] [int] NOT NULL,
	[threshold_alert_enabled] [bit] NOT NULL,
	[last_backup_filename] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[last_updated] [datetime] NULL,
	[planned_outage_start_time] [int] NOT NULL,
	[planned_outage_end_time] [int] NOT NULL,
	[planned_outage_weekday_mask] [int] NOT NULL,
	[source_directory] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
PRIMARY KEY CLUSTERED 
(
	[primary_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
