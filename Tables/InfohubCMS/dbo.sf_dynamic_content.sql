/****** Object:  Table [dbo].[sf_dynamic_content]    Script Date: 5/15/2018 12:01:30 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_dynamic_content](
	[was_published] [tinyint] NULL,
	[visible] [tinyint] NOT NULL,
	[vrsion] [int] NOT NULL,
	[url_name_] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[system_parent_type] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[system_parent_id] [uniqueidentifier] NULL,
	[status] [int] NOT NULL,
	[publication_date] [datetime] NOT NULL,
	[ownr] [uniqueidentifier] NULL,
	[original_content_id] [uniqueidentifier] NULL,
	[last_modified_by] [uniqueidentifier] NULL,
	[last_modified] [datetime] NULL,
	[item_default_url_] [nvarchar](510) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[inherits_permissions] [tinyint] NOT NULL,
	[include_in_sitemap] [tinyint] NOT NULL,
	[base_id] [uniqueidentifier] NOT NULL,
	[expiration_date] [datetime] NULL,
	[date_created] [datetime] NULL,
	[can_inherit_permissions] [tinyint] NOT NULL,
	[approval_workflow_state_] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[application_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[voa_version] [smallint] NOT NULL,
 CONSTRAINT [pk_sf_dynamic_content] PRIMARY KEY CLUSTERED 
(
	[base_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [idx_sf_dyn_org_cnt_id]    Script Date: 5/15/2018 12:01:30 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_dyn_org_cnt_id] ON [dbo].[sf_dynamic_content]
(
	[original_content_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [idx_sf_dyn_sys_prnt_id]    Script Date: 5/15/2018 12:01:30 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_dyn_sys_prnt_id] ON [dbo].[sf_dynamic_content]
(
	[application_name] ASC,
	[system_parent_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
