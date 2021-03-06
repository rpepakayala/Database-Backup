/****** Object:  Table [dbo].[xf_conversation_message]    Script Date: 5/15/2018 12:00:19 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_conversation_message](
	[message_id] [bigint] IDENTITY(636,1) NOT NULL,
	[conversation_id] [bigint] NOT NULL,
	[message_date] [bigint] NOT NULL,
	[user_id] [bigint] NOT NULL,
	[username] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[message] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[attach_count] [int] NOT NULL,
	[ip_id] [bigint] NOT NULL,
 CONSTRAINT [PK_xf_conversation_message_message_id] PRIMARY KEY CLUSTERED 
(
	[message_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [conversation_id_message_date]    Script Date: 5/15/2018 12:00:19 PM ******/
CREATE NONCLUSTERED INDEX [conversation_id_message_date] ON [dbo].[xf_conversation_message]
(
	[conversation_id] ASC,
	[message_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [message_date]    Script Date: 5/15/2018 12:00:19 PM ******/
CREATE NONCLUSTERED INDEX [message_date] ON [dbo].[xf_conversation_message]
(
	[message_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [user_id]    Script Date: 5/15/2018 12:00:19 PM ******/
CREATE NONCLUSTERED INDEX [user_id] ON [dbo].[xf_conversation_message]
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[xf_conversation_message] ADD  DEFAULT ((0)) FOR [attach_count]
ALTER TABLE [dbo].[xf_conversation_message] ADD  DEFAULT ((0)) FOR [ip_id]
GO
