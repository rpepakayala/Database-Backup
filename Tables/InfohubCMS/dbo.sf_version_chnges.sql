/****** Object:  Table [dbo].[sf_version_chnges]    Script Date: 5/15/2018 12:02:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_version_chnges](
	[vrsion] [int] NOT NULL,
	[serial_info_id] [uniqueidentifier] NULL,
	[item_id] [uniqueidentifier] NULL,
	[ownr] [uniqueidentifier] NULL,
	[metadata] [varchar](4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[last_modified] [datetime] NULL,
	[lbel] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[is_published_version] [tinyint] NOT NULL,
	[id] [uniqueidentifier] NOT NULL,
	[dta] [varbinary](max) NULL,
	[culture] [int] NOT NULL,
	[commnt] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[change_type] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[app_name] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[voa_version] [smallint] NOT NULL,
 CONSTRAINT [pk_sf_version_chnges] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [idx_sf_version_chnges_item_id]    Script Date: 5/15/2018 12:02:08 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_version_chnges_item_id] ON [dbo].[sf_version_chnges]
(
	[item_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
