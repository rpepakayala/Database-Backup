/****** Object:  Table [dbo].[sf_mobile_apps]    Script Date: 5/15/2018 12:01:50 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_mobile_apps](
	[targeted_mobile_devices] [int] NOT NULL,
	[publication_date] [datetime] NULL,
	[ownr] [uniqueidentifier] NULL,
	[nme] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[module_provider] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[module_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[module_id] [uniqueidentifier] NULL,
	[last_modified] [datetime] NULL,
	[is_published] [tinyint] NOT NULL,
	[id] [uniqueidentifier] NOT NULL,
	[icon_id] [uniqueidentifier] NULL,
	[date_created] [datetime] NULL,
	[application_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[app_mode] [int] NOT NULL,
	[allow_tracking] [tinyint] NOT NULL,
	[voa_version] [smallint] NOT NULL,
 CONSTRAINT [pk_sf_mobile_apps] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
