/****** Object:  Table [dbo].[xf_feed]    Script Date: 5/15/2018 12:00:21 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_feed](
	[feed_id] [bigint] IDENTITY(15,1) NOT NULL,
	[title] [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[url] [nvarchar](2083) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[frequency] [bigint] NOT NULL,
	[node_id] [bigint] NOT NULL,
	[user_id] [bigint] NOT NULL,
	[prefix_id] [bigint] NOT NULL,
	[title_template] [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[message_template] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[discussion_visible] [tinyint] NOT NULL,
	[discussion_open] [tinyint] NOT NULL,
	[discussion_sticky] [tinyint] NOT NULL,
	[last_fetch] [bigint] NOT NULL,
	[active] [bigint] NOT NULL,
 CONSTRAINT [PK_xf_feed_feed_id] PRIMARY KEY CLUSTERED 
(
	[feed_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [active]    Script Date: 5/15/2018 12:00:21 PM ******/
CREATE NONCLUSTERED INDEX [active] ON [dbo].[xf_feed]
(
	[active] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[xf_feed] ADD  DEFAULT ((1800)) FOR [frequency]
ALTER TABLE [dbo].[xf_feed] ADD  DEFAULT ((0)) FOR [user_id]
ALTER TABLE [dbo].[xf_feed] ADD  DEFAULT ((0)) FOR [prefix_id]
ALTER TABLE [dbo].[xf_feed] ADD  DEFAULT (N'') FOR [title_template]
ALTER TABLE [dbo].[xf_feed] ADD  DEFAULT ((1)) FOR [discussion_visible]
ALTER TABLE [dbo].[xf_feed] ADD  DEFAULT ((1)) FOR [discussion_open]
ALTER TABLE [dbo].[xf_feed] ADD  DEFAULT ((0)) FOR [discussion_sticky]
ALTER TABLE [dbo].[xf_feed] ADD  DEFAULT ((0)) FOR [last_fetch]
ALTER TABLE [dbo].[xf_feed] ADD  DEFAULT ((0)) FOR [active]
GO
