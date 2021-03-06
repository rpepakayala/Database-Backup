/****** Object:  Table [dbo].[xf_forum]    Script Date: 5/15/2018 12:00:22 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_forum](
	[node_id] [bigint] NOT NULL,
	[discussion_count] [bigint] NOT NULL,
	[message_count] [bigint] NOT NULL,
	[last_post_id] [bigint] NOT NULL,
	[last_post_date] [bigint] NOT NULL,
	[last_post_user_id] [bigint] NOT NULL,
	[last_post_username] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[last_thread_title] [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[moderate_messages] [tinyint] NOT NULL,
	[allow_posting] [tinyint] NOT NULL,
	[count_messages] [tinyint] NOT NULL,
	[find_new] [tinyint] NOT NULL,
	[prefix_cache] [varbinary](max) NOT NULL,
	[default_prefix_id] [bigint] NOT NULL,
	[require_prefix] [tinyint] NOT NULL,
	[allowed_watch_notifications] [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[default_sort_order] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[default_sort_direction] [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_xf_forum_node_id] PRIMARY KEY CLUSTERED 
(
	[node_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[xf_forum] ADD  DEFAULT ((0)) FOR [discussion_count]
ALTER TABLE [dbo].[xf_forum] ADD  DEFAULT ((0)) FOR [message_count]
ALTER TABLE [dbo].[xf_forum] ADD  DEFAULT ((0)) FOR [last_post_id]
ALTER TABLE [dbo].[xf_forum] ADD  DEFAULT ((0)) FOR [last_post_date]
ALTER TABLE [dbo].[xf_forum] ADD  DEFAULT ((0)) FOR [last_post_user_id]
ALTER TABLE [dbo].[xf_forum] ADD  DEFAULT (N'') FOR [last_post_username]
ALTER TABLE [dbo].[xf_forum] ADD  DEFAULT (N'') FOR [last_thread_title]
ALTER TABLE [dbo].[xf_forum] ADD  DEFAULT ((0)) FOR [moderate_messages]
ALTER TABLE [dbo].[xf_forum] ADD  DEFAULT ((1)) FOR [allow_posting]
ALTER TABLE [dbo].[xf_forum] ADD  DEFAULT ((1)) FOR [count_messages]
ALTER TABLE [dbo].[xf_forum] ADD  DEFAULT ((1)) FOR [find_new]
ALTER TABLE [dbo].[xf_forum] ADD  DEFAULT ((0)) FOR [default_prefix_id]
ALTER TABLE [dbo].[xf_forum] ADD  DEFAULT ((0)) FOR [require_prefix]
ALTER TABLE [dbo].[xf_forum] ADD  DEFAULT (N'all') FOR [allowed_watch_notifications]
ALTER TABLE [dbo].[xf_forum] ADD  DEFAULT (N'last_post_date') FOR [default_sort_order]
ALTER TABLE [dbo].[xf_forum] ADD  DEFAULT (N'desc') FOR [default_sort_direction]
GO
