/****** Object:  Table [dbo].[xf_user_privacy]    Script Date: 5/15/2018 12:00:41 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_user_privacy](
	[user_id] [bigint] NOT NULL,
	[allow_view_profile] [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[allow_post_profile] [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[allow_send_personal_conversation] [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[allow_view_identities] [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[allow_receive_news_feed] [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_xf_user_privacy_user_id] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[xf_user_privacy] ADD  DEFAULT (N'everyone') FOR [allow_view_profile]
ALTER TABLE [dbo].[xf_user_privacy] ADD  DEFAULT (N'everyone') FOR [allow_post_profile]
ALTER TABLE [dbo].[xf_user_privacy] ADD  DEFAULT (N'everyone') FOR [allow_send_personal_conversation]
ALTER TABLE [dbo].[xf_user_privacy] ADD  DEFAULT (N'everyone') FOR [allow_view_identities]
ALTER TABLE [dbo].[xf_user_privacy] ADD  DEFAULT (N'everyone') FOR [allow_receive_news_feed]
GO
