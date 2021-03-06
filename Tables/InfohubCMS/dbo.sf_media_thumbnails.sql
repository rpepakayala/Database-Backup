/****** Object:  Table [dbo].[sf_media_thumbnails]    Script Date: 5/15/2018 12:01:48 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_media_thumbnails](
	[width] [int] NULL,
	[typ] [int] NOT NULL,
	[total_size] [bigint] NOT NULL,
	[content_id] [uniqueidentifier] NULL,
	[nme] [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[mime_type] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[id] [uniqueidentifier] NOT NULL,
	[height] [int] NULL,
	[file_id] [uniqueidentifier] NULL,
	[dta] [image] NULL,
	[culture] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[uploaded] [tinyint] NOT NULL,
	[number_of_chunks] [int] NOT NULL,
	[chunk_size] [int] NOT NULL,
	[voa_version] [smallint] NOT NULL,
 CONSTRAINT [pk_sf_media_thumbnails] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [idx_sf_md_thmbnails_content_id]    Script Date: 5/15/2018 12:01:48 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_md_thmbnails_content_id] ON [dbo].[sf_media_thumbnails]
(
	[content_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
