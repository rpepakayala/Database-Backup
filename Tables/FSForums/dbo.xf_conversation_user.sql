/****** Object:  Table [dbo].[xf_conversation_user]    Script Date: 5/15/2018 12:00:19 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_conversation_user](
	[conversation_id] [bigint] NOT NULL,
	[owner_user_id] [bigint] NOT NULL,
	[is_unread] [tinyint] NOT NULL,
	[reply_count] [bigint] NOT NULL,
	[last_message_date] [bigint] NOT NULL,
	[last_message_id] [bigint] NOT NULL,
	[last_message_user_id] [bigint] NOT NULL,
	[last_message_username] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[is_starred] [tinyint] NOT NULL,
 CONSTRAINT [PK_xf_conversation_user_conversation_id] PRIMARY KEY CLUSTERED 
(
	[conversation_id] ASC,
	[owner_user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [owner_starred_date]    Script Date: 5/15/2018 12:00:19 PM ******/
CREATE NONCLUSTERED INDEX [owner_starred_date] ON [dbo].[xf_conversation_user]
(
	[owner_user_id] ASC,
	[is_starred] ASC,
	[last_message_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [owner_user_id_is_unread]    Script Date: 5/15/2018 12:00:19 PM ******/
CREATE NONCLUSTERED INDEX [owner_user_id_is_unread] ON [dbo].[xf_conversation_user]
(
	[owner_user_id] ASC,
	[is_unread] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [owner_user_id_last_message_date]    Script Date: 5/15/2018 12:00:19 PM ******/
CREATE NONCLUSTERED INDEX [owner_user_id_last_message_date] ON [dbo].[xf_conversation_user]
(
	[owner_user_id] ASC,
	[last_message_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[xf_conversation_user] ADD  DEFAULT ((0)) FOR [is_starred]
GO
