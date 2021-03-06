/****** Object:  Table [dbo].[sf_cnt_location_filters]    Script Date: 5/15/2018 12:01:26 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_cnt_location_filters](
	[value] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[type] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[id] [uniqueidentifier] NOT NULL,
	[cnt_location_id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [pk_sf_cnt_location_filters] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [idx_cnt_lctn_cnt_id]    Script Date: 5/15/2018 12:01:26 PM ******/
CREATE NONCLUSTERED INDEX [idx_cnt_lctn_cnt_id] ON [dbo].[sf_cnt_location_filters]
(
	[cnt_location_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
