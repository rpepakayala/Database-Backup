/****** Object:  Table [dbo].[sf_unsubscription_info]    Script Date: 5/15/2018 12:02:07 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_unsubscription_info](
	[sf_unsubscription_info_id] [int] NOT NULL,
	[unsubscription_list_id] [uniqueidentifier] NULL,
	[unsubscription_date] [datetime] NOT NULL,
	[id2] [uniqueidentifier] NULL,
	[reason] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[last_modified] [datetime] NULL,
	[sf_campaign_id] [uniqueidentifier] NULL,
	[id] [uniqueidentifier] NULL,
	[application_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[voa_version] [smallint] NOT NULL,
 CONSTRAINT [pk_sf_unsubscription_info] PRIMARY KEY CLUSTERED 
(
	[sf_unsubscription_info_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [idx_sf_unsubscr_info_camp_sub]    Script Date: 5/15/2018 12:02:07 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_unsubscr_info_camp_sub] ON [dbo].[sf_unsubscription_info]
(
	[sf_campaign_id] ASC,
	[id2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [idx_sf_unsubscription_info_id2]    Script Date: 5/15/2018 12:02:07 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_unsubscription_info_id2] ON [dbo].[sf_unsubscription_info]
(
	[id2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
