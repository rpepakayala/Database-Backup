/****** Object:  Table [dbo].[sf_folders]    Script Date: 5/15/2018 12:01:39 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_folders](
	[url_name_] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[title_] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[root_id] [uniqueidentifier] NULL,
	[path] [varchar](900) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[parent_id] [uniqueidentifier] NULL,
	[is_deleted] [tinyint] NOT NULL,
	[id] [uniqueidentifier] NOT NULL,
	[description_] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[cover_id] [uniqueidentifier] NULL,
	[app_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[voa_version] [smallint] NOT NULL,
 CONSTRAINT [pk_sf_folders] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [idx_sf_fldrs_prntId]    Script Date: 5/15/2018 12:01:39 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_fldrs_prntId] ON [dbo].[sf_folders]
(
	[parent_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [idx_sf_fldrs_rtId_pth]    Script Date: 5/15/2018 12:01:39 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_fldrs_rtId_pth] ON [dbo].[sf_folders]
(
	[root_id] ASC,
	[path] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
