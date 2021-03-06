/****** Object:  Table [dbo].[sf_open_stat]    Script Date: 5/15/2018 12:01:54 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_open_stat](
	[sf_open_stat_id] [int] NOT NULL,
	[subscriber_id] [uniqueidentifier] NOT NULL,
	[opened_date] [datetime] NOT NULL,
	[campaign_id] [uniqueidentifier] NOT NULL,
	[voa_version] [smallint] NOT NULL,
 CONSTRAINT [pk_sf_open_stat] PRIMARY KEY CLUSTERED 
(
	[sf_open_stat_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [idx_sf_open_stat_camp_subscr]    Script Date: 5/15/2018 12:01:54 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_open_stat_camp_subscr] ON [dbo].[sf_open_stat]
(
	[campaign_id] ASC,
	[subscriber_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
