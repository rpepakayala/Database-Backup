/****** Object:  Table [dbo].[sf_events]    Script Date: 5/15/2018 12:01:38 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_events](
	[votes_sum] [numeric](20, 10) NOT NULL,
	[votes_count] [bigint] NOT NULL,
	[visible] [tinyint] NOT NULL,
	[views_count] [int] NOT NULL,
	[vrsion] [int] NOT NULL,
	[url_name_] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[title_] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[status] [int] NOT NULL,
	[source_key] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[publication_date] [datetime] NOT NULL,
	[post_rights] [int] NOT NULL,
	[ownr] [uniqueidentifier] NULL,
	[original_content_id] [uniqueidentifier] NULL,
	[last_modified_by] [uniqueidentifier] NULL,
	[last_modified] [datetime] NULL,
	[include_in_sitemap] [tinyint] NOT NULL,
	[content_id] [uniqueidentifier] NOT NULL,
	[expiration_date] [datetime] NULL,
	[email_author] [tinyint] NULL,
	[draft_culture] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[description_] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[default_page_id] [uniqueidentifier] NULL,
	[date_created] [datetime] NULL,
	[content_state] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[approve_comments] [tinyint] NULL,
	[app_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[allow_track_backs] [tinyint] NULL,
	[allow_comments] [tinyint] NULL,
	[was_published] [tinyint] NULL,
	[timezone_id] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[summary_] [nvarchar](4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[street_] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[state_] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[recurrence_expression] [nvarchar](2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[parent_id] [uniqueidentifier] NOT NULL,
	[lcation] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[item_default_url_] [nvarchar](510) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[is_recurrent] [tinyint] NOT NULL,
	[inherits_permissions] [tinyint] NOT NULL,
	[event_start] [datetime] NOT NULL,
	[event_end] [datetime] NULL,
	[country_] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[content_] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[contact_web] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[contact_phone_] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[contact_name_] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[contact_email] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[contact_cell_] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[city_] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[can_inherit_permissions] [tinyint] NOT NULL,
	[approval_workflow_state_] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[all_day_event] [tinyint] NOT NULL,
	[voa_version] [smallint] NOT NULL,
 CONSTRAINT [pk_sf_events] PRIMARY KEY CLUSTERED 
(
	[content_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [idx_sf_events]    Script Date: 5/15/2018 12:01:38 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_events] ON [dbo].[sf_events]
(
	[app_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [idx_sf_events_org_cnt_id]    Script Date: 5/15/2018 12:01:38 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_events_org_cnt_id] ON [dbo].[sf_events]
(
	[original_content_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
