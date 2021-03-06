/****** Object:  Table [dbo].[dm_fs_product]    Script Date: 5/15/2018 12:04:03 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[dm_fs_product](
	[fs_product_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[franchiseid] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[product_id] [int] NOT NULL,
	[product_nm] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[product_desc] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[create_dt] [datetime2](0) NULL,
 CONSTRAINT [PK_dm_fs_product_fs_product_id] PRIMARY KEY CLUSTERED 
(
	[fs_product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [franchiseid]    Script Date: 5/15/2018 12:04:03 PM ******/
CREATE NONCLUSTERED INDEX [franchiseid] ON [dbo].[dm_fs_product]
(
	[franchiseid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [product_id]    Script Date: 5/15/2018 12:04:03 PM ******/
CREATE NONCLUSTERED INDEX [product_id] ON [dbo].[dm_fs_product]
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[dm_fs_product] ADD  DEFAULT (NULL) FOR [product_nm]
ALTER TABLE [dbo].[dm_fs_product] ADD  DEFAULT (NULL) FOR [create_dt]
GO
