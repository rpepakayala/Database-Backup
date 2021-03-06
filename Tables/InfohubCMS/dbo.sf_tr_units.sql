/****** Object:  Table [dbo].[sf_tr_units]    Script Date: 5/15/2018 12:02:06 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_tr_units](
	[trns_id] [uniqueidentifier] NULL,
	[title] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[trg_val] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[src_val] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[prop_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ordinal] [real] NOT NULL,
	[id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [pk_sf_tr_units] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [idx_sf_tr_units_trns_id]    Script Date: 5/15/2018 12:02:06 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_tr_units_trns_id] ON [dbo].[sf_tr_units]
(
	[trns_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
