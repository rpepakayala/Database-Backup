/****** Object:  Table [dbo].[sf_workflow_scope]    Script Date: 5/15/2018 12:02:09 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_workflow_scope](
	[title] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[provider_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[parent_id] [uniqueidentifier] NULL,
	[last_modified] [datetime] NOT NULL,
	[lnguage] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[id] [uniqueidentifier] NOT NULL,
	[id2] [uniqueidentifier] NULL,
	[content_type] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[content_filter_expression] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[app_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[voa_version] [smallint] NOT NULL,
 CONSTRAINT [pk_sf_workflow_scope] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [idx_sf_workflow_scope_id2]    Script Date: 5/15/2018 12:02:09 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_workflow_scope_id2] ON [dbo].[sf_workflow_scope]
(
	[id2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
