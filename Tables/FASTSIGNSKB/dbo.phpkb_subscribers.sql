/****** Object:  Table [dbo].[phpkb_subscribers]    Script Date: 5/15/2018 11:59:19 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[phpkb_subscribers](
	[subscriber_id] [int] IDENTITY(1,1) NOT NULL,
	[item_id] [int] NOT NULL,
	[subscriber_name] [nvarchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[subscriber_email] [nvarchar](75) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[subscription_key] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[subscription_date] [smalldatetime] NOT NULL,
	[subscription_status] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[subscription_type] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [subscriber_id] PRIMARY KEY CLUSTERED 
(
	[subscriber_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[phpkb_subscribers] ADD  DEFAULT ('0') FOR [item_id]
ALTER TABLE [dbo].[phpkb_subscribers] ADD  DEFAULT ('inactive') FOR [subscription_status]
ALTER TABLE [dbo].[phpkb_subscribers] ADD  DEFAULT ('knowledgebase') FOR [subscription_type]
ALTER TABLE [dbo].[phpkb_subscribers]  WITH CHECK ADD CHECK  (([subscription_status]='inactive' OR [subscription_status]='active'))
ALTER TABLE [dbo].[phpkb_subscribers]  WITH CHECK ADD CHECK  (([subscription_type]='knowledgebase' OR [subscription_type]='category' OR [subscription_type]='article'))
GO
