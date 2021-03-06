/****** Object:  Table [dbo].[sf_media_file_urls]    Script Date: 5/15/2018 12:01:48 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_media_file_urls](
	[url] [nvarchar](510) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[redirect_to_default] [tinyint] NOT NULL,
	[media_file_link_id] [uniqueidentifier] NULL,
	[is_default] [tinyint] NULL,
	[id] [uniqueidentifier] NOT NULL,
	[app_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [pk_sf_media_file_urls] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [idx_sf_md_fl_rls_md_fl_link_id]    Script Date: 5/15/2018 12:01:48 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_md_fl_rls_md_fl_link_id] ON [dbo].[sf_media_file_urls]
(
	[media_file_link_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [sf_idx_mfu_url_mfl]    Script Date: 5/15/2018 12:01:48 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [sf_idx_mfu_url_mfl] ON [dbo].[sf_media_file_urls]
(
	[url] ASC,
	[media_file_link_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
