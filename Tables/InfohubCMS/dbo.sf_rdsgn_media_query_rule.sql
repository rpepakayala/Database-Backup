/****** Object:  Table [dbo].[sf_rdsgn_media_query_rule]    Script Date: 5/15/2018 12:02:01 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_rdsgn_media_query_rule](
	[width_type] [int] NOT NULL,
	[resulting_rule] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[resolution] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[parent_media_query_id] [uniqueidentifier] NULL,
	[orientation] [int] NOT NULL,
	[min_width] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[min_height] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[max_width] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[max_height] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[last_modified] [datetime] NOT NULL,
	[is_monochrome] [tinyint] NOT NULL,
	[is_manual_media_query] [tinyint] NOT NULL,
	[is_grid] [tinyint] NOT NULL,
	[id] [uniqueidentifier] NOT NULL,
	[height_type] [int] NOT NULL,
	[exact_width] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[exact_height] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[device_type_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[description] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[aspect_ratio] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[application_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[voa_version] [smallint] NOT NULL,
 CONSTRAINT [pk_sf_rdsgn_media_query_rule] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [idx_sf_rdsgn_md_qry_rl_prnt_md]    Script Date: 5/15/2018 12:02:01 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_rdsgn_md_qry_rl_prnt_md] ON [dbo].[sf_rdsgn_media_query_rule]
(
	[parent_media_query_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
