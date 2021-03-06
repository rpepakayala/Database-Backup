/****** Object:  Table [dbo].[sf_publishing_pipe_settings]    Script Date: 5/15/2018 12:02:00 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_publishing_pipe_settings](
	[ui_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[title] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[schedule_type] [int] NOT NULL,
	[schedule_time] [datetime] NULL,
	[schedule_day] [int] NOT NULL,
	[resource_class_id] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[id3] [uniqueidentifier] NULL,
	[pipe_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[max_items] [int] NOT NULL,
	[id2] [uniqueidentifier] NULL,
	[last_modified] [datetime] NULL,
	[is_inbound] [tinyint] NOT NULL,
	[is_active] [tinyint] NOT NULL,
	[invocation_mode] [int] NOT NULL,
	[id] [uniqueidentifier] NOT NULL,
	[filter_expression] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[description] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[application_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[voa_class] [int] NOT NULL,
	[voa_version] [smallint] NOT NULL,
	[user_name_reference2] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[app_id_reference] [int] NULL,
	[pop3_user_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[pop3_server] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[pop3_port] [int] NULL,
	[pop3_password] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[is_ssl_connection] [tinyint] NULL,
	[user_name_reference] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[search_pattern] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[app_name_reference] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[url_name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[output_settings] [int] NULL,
	[format_settings] [int] NULL,
	[content_size] [int] NULL,
	[search_provider_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[catalog_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[provider_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[imported_item_parent_id] [uniqueidentifier] NULL,
	[import_item_as_published] [tinyint] NULL,
	[content_type_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[back_links_page_id] [uniqueidentifier] NULL,
 CONSTRAINT [pk_sf_publishing_pipe_settings] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [idx_sf_pblshng_pp_settings_id3]    Script Date: 5/15/2018 12:02:00 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_pblshng_pp_settings_id3] ON [dbo].[sf_publishing_pipe_settings]
(
	[id3] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
