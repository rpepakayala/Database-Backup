/****** Object:  Table [dbo].[sf_rbin_item]    Script Date: 5/15/2018 12:02:00 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_rbin_item](
	[owner] [uniqueidentifier] NULL,
	[last_modified] [datetime] NOT NULL,
	[id] [uniqueidentifier] NOT NULL,
	[del_item_wrkfl_status] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[del_item_type_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[del_item_title] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[del_item_site_id] [uniqueidentifier] NULL,
	[del_item_prvdr_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[del_item_parent_type_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[del_item_titles_path] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[del_item_lang] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[del_item_id] [uniqueidentifier] NULL,
	[date_created] [datetime] NOT NULL,
	[app_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[voa_version] [smallint] NOT NULL,
 CONSTRAINT [pk_sf_rbin_item] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [idx_sf_rbin_date_created]    Script Date: 5/15/2018 12:02:00 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_rbin_date_created] ON [dbo].[sf_rbin_item]
(
	[date_created] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [idx_sf_rbin_item_type_prov_id]    Script Date: 5/15/2018 12:02:00 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_rbin_item_type_prov_id] ON [dbo].[sf_rbin_item]
(
	[del_item_type_name] ASC,
	[del_item_prvdr_name] ASC,
	[del_item_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
