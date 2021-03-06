/****** Object:  Table [dbo].[sf_ab_campaign]    Script Date: 5/15/2018 12:01:22 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_ab_campaign](
	[winning_condition] [int] NULL,
	[winner_issue_original_id] [uniqueidentifier] NULL,
	[winner_issue_id] [uniqueidentifier] NULL,
	[testing_sample_percentage] [int] NULL,
	[testing_note] [nvarchar](4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[testing_ends] [datetime] NULL,
	[root_campaign_id] [uniqueidentifier] NULL,
	[nme] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[last_modified] [datetime] NOT NULL,
	[id] [uniqueidentifier] NOT NULL,
	[date_sent] [datetime] NULL,
	[conclusion] [nvarchar](4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[campaign_b_id] [uniqueidentifier] NULL,
	[campaign_a_id] [uniqueidentifier] NULL,
	[application_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[a_b_testing_status] [int] NULL,
	[voa_version] [smallint] NOT NULL,
 CONSTRAINT [pk_sf_ab_campaign] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [idx_sf_ab_campaign_campaign_a]    Script Date: 5/15/2018 12:01:22 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_ab_campaign_campaign_a] ON [dbo].[sf_ab_campaign]
(
	[campaign_a_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [idx_sf_ab_campaign_campaign_b]    Script Date: 5/15/2018 12:01:22 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_ab_campaign_campaign_b] ON [dbo].[sf_ab_campaign]
(
	[campaign_b_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
