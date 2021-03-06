/****** Object:  Table [dbo].[xf_thread]    Script Date: 5/15/2018 12:00:36 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_thread](
	[thread_id] [bigint] IDENTITY(7640,1) NOT NULL,
	[node_id] [bigint] NOT NULL,
	[title] [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[reply_count] [bigint] NOT NULL,
	[view_count] [bigint] NOT NULL,
	[user_id] [bigint] NOT NULL,
	[username] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[post_date] [bigint] NOT NULL,
	[sticky] [tinyint] NOT NULL,
	[discussion_state] [nvarchar](9) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[discussion_open] [tinyint] NOT NULL,
	[discussion_type] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[first_post_id] [bigint] NOT NULL,
	[first_post_likes] [bigint] NOT NULL,
	[last_post_date] [bigint] NOT NULL,
	[last_post_id] [bigint] NOT NULL,
	[last_post_user_id] [bigint] NOT NULL,
	[last_post_username] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[prefix_id] [bigint] NOT NULL,
 CONSTRAINT [PK_xf_thread_thread_id] PRIMARY KEY CLUSTERED 
(
	[thread_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [last_post_date]    Script Date: 5/15/2018 12:00:36 PM ******/
CREATE NONCLUSTERED INDEX [last_post_date] ON [dbo].[xf_thread]
(
	[last_post_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [node_id_last_post_date]    Script Date: 5/15/2018 12:00:36 PM ******/
CREATE NONCLUSTERED INDEX [node_id_last_post_date] ON [dbo].[xf_thread]
(
	[node_id] ASC,
	[last_post_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [node_id_sticky_state_last_post]    Script Date: 5/15/2018 12:00:36 PM ******/
CREATE NONCLUSTERED INDEX [node_id_sticky_state_last_post] ON [dbo].[xf_thread]
(
	[node_id] ASC,
	[sticky] ASC,
	[discussion_state] ASC,
	[last_post_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [post_date]    Script Date: 5/15/2018 12:00:36 PM ******/
CREATE NONCLUSTERED INDEX [post_date] ON [dbo].[xf_thread]
(
	[post_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [user_id]    Script Date: 5/15/2018 12:00:36 PM ******/
CREATE NONCLUSTERED INDEX [user_id] ON [dbo].[xf_thread]
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[xf_thread] ADD  DEFAULT ((0)) FOR [reply_count]
ALTER TABLE [dbo].[xf_thread] ADD  DEFAULT ((0)) FOR [view_count]
ALTER TABLE [dbo].[xf_thread] ADD  DEFAULT ((0)) FOR [sticky]
ALTER TABLE [dbo].[xf_thread] ADD  DEFAULT (N'visible') FOR [discussion_state]
ALTER TABLE [dbo].[xf_thread] ADD  DEFAULT ((1)) FOR [discussion_open]
ALTER TABLE [dbo].[xf_thread] ADD  DEFAULT (N'') FOR [discussion_type]
ALTER TABLE [dbo].[xf_thread] ADD  DEFAULT ((0)) FOR [first_post_likes]
ALTER TABLE [dbo].[xf_thread] ADD  DEFAULT ((0)) FOR [prefix_id]
GO
