/****** Object:  Table [dbo].[xf_rotating_ads_item]    Script Date: 5/15/2018 12:00:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_rotating_ads_item](
	[item_id] [bigint] IDENTITY(7,1) NOT NULL,
	[name] [varbinary](255) NOT NULL,
	[position] [varbinary](255) NOT NULL,
	[link] [varbinary](max) NOT NULL,
	[html] [varbinary](max) NOT NULL,
	[expire_date] [bigint] NULL,
	[hit] [bigint] NULL,
	[is_disabled] [tinyint] NOT NULL,
	[options] [varbinary](max) NULL,
 CONSTRAINT [PK_xf_rotating_ads_item_item_id] PRIMARY KEY CLUSTERED 
(
	[item_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [position]    Script Date: 5/15/2018 12:00:32 PM ******/
CREATE NONCLUSTERED INDEX [position] ON [dbo].[xf_rotating_ads_item]
(
	[position] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[xf_rotating_ads_item] ADD  DEFAULT ((0)) FOR [expire_date]
ALTER TABLE [dbo].[xf_rotating_ads_item] ADD  DEFAULT ((0)) FOR [hit]
ALTER TABLE [dbo].[xf_rotating_ads_item] ADD  DEFAULT ((0)) FOR [is_disabled]
GO
