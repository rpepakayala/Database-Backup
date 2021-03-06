/****** Object:  Table [dbo].[sf_page_data]    Script Date: 5/15/2018 12:01:54 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_page_data](
	[theme] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[votes_sum] [numeric](20, 10) NOT NULL,
	[votes_count] [bigint] NOT NULL,
	[visible] [tinyint] NOT NULL,
	[views_count] [int] NOT NULL,
	[view_state_encryption] [int] NOT NULL,
	[vrsion] [int] NOT NULL,
	[validate_request] [tinyint] NOT NULL,
	[url_evaluation_mode] [int] NOT NULL,
	[trace_mode] [int] NOT NULL,
	[trace] [tinyint] NOT NULL,
	[template_id] [uniqueidentifier] NULL,
	[status] [int] NOT NULL,
	[source_key] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[sliding_expiration] [tinyint] NOT NULL,
	[response_encoding] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[publication_date] [datetime] NOT NULL,
	[personalization_segment_id] [uniqueidentifier] NULL,
	[personalization_master_id] [uniqueidentifier] NULL,
	[ownr] [uniqueidentifier] NULL,
	[cache_profile] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[page_node_id] [uniqueidentifier] NULL,
	[master_page] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[maintain_scroll] [tinyint] NOT NULL,
	[locked_by] [uniqueidentifier] NULL,
	[last_modified_by] [uniqueidentifier] NULL,
	[last_modified] [datetime] NOT NULL,
	[last_control_id] [int] NOT NULL,
	[keywords_] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[is_personalized] [tinyint] NOT NULL,
	[is_auto_created] [tinyint] NOT NULL,
	[include_script_manger] [tinyint] NOT NULL,
	[content_id] [uniqueidentifier] NOT NULL,
	[html_title_] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[head_tag_content] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[flags] [int] NOT NULL,
	[external_page] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[expiration_date] [datetime] NULL,
	[error_page] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[enable_view_state_mac] [tinyint] NOT NULL,
	[enable_view_state] [tinyint] NOT NULL,
	[enable_theming] [tinyint] NOT NULL,
	[enable_session_state] [tinyint] NOT NULL,
	[enable_event_validation] [tinyint] NOT NULL,
	[description_] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[date_created] [datetime] NULL,
	[culture] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[content_state] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[comments_count] [int] NOT NULL,
	[code_behind_type] [nvarchar](510) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[cache_output] [tinyint] NOT NULL,
	[cache_duration] [int] NOT NULL,
	[build_stamp] [int] NOT NULL,
	[buffer_output] [tinyint] NOT NULL,
	[app_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [pk_sf_page_data] PRIMARY KEY CLUSTERED 
(
	[content_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [idx_sf_page_data_page_node_id]    Script Date: 5/15/2018 12:01:54 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_page_data_page_node_id] ON [dbo].[sf_page_data]
(
	[page_node_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [idx_sf_page_data_template_id]    Script Date: 5/15/2018 12:01:54 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_page_data_template_id] ON [dbo].[sf_page_data]
(
	[template_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [idx_sf_pd_pers_master_id]    Script Date: 5/15/2018 12:01:54 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_pd_pers_master_id] ON [dbo].[sf_page_data]
(
	[personalization_master_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
