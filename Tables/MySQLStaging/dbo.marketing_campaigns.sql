/****** Object:  Table [dbo].[marketing_campaigns]    Script Date: 5/15/2018 12:04:17 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[marketing_campaigns](
	[campaign_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[parent_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[franchise_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[subcategory_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[start_date] [date] NOT NULL,
	[end_date] [date] NULL,
	[name] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[description] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[code] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[purl] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[cost] [decimal](12, 2) NOT NULL,
	[activity_mandatory] [smallint] NOT NULL,
	[acceptance_required] [smallint] NOT NULL,
	[external_campaign_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[active] [smallint] NOT NULL,
	[created_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[created_on] [datetime2](0) NOT NULL,
	[modified_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[modified_on] [datetime2](0) NULL,
 CONSTRAINT [PK_marketing_campaigns_campaign_id] PRIMARY KEY CLUSTERED 
(
	[campaign_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [franchise_id]    Script Date: 5/15/2018 12:04:17 PM ******/
CREATE NONCLUSTERED INDEX [franchise_id] ON [dbo].[marketing_campaigns]
(
	[franchise_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [subcategory_id]    Script Date: 5/15/2018 12:04:17 PM ******/
CREATE NONCLUSTERED INDEX [subcategory_id] ON [dbo].[marketing_campaigns]
(
	[subcategory_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[marketing_campaigns] ADD  DEFAULT (NULL) FOR [parent_id]
ALTER TABLE [dbo].[marketing_campaigns] ADD  DEFAULT (NULL) FOR [end_date]
ALTER TABLE [dbo].[marketing_campaigns] ADD  DEFAULT (NULL) FOR [code]
ALTER TABLE [dbo].[marketing_campaigns] ADD  DEFAULT (NULL) FOR [purl]
ALTER TABLE [dbo].[marketing_campaigns] ADD  DEFAULT (NULL) FOR [external_campaign_id]
ALTER TABLE [dbo].[marketing_campaigns] ADD  DEFAULT ((1)) FOR [active]
GO
