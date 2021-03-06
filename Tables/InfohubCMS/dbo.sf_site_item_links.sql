/****** Object:  Table [dbo].[sf_site_item_links]    Script Date: 5/15/2018 12:02:03 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_site_item_links](
	[site_id] [uniqueidentifier] NOT NULL,
	[item_type] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[item_id] [uniqueidentifier] NOT NULL,
	[application_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[voa_version] [smallint] NOT NULL,
 CONSTRAINT [pk_sf_site_item_links] PRIMARY KEY CLUSTERED 
(
	[item_id] ASC,
	[item_type] ASC,
	[site_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [idx_sf_links_item_id_type]    Script Date: 5/15/2018 12:02:03 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_links_item_id_type] ON [dbo].[sf_site_item_links]
(
	[item_id] ASC,
	[item_type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
