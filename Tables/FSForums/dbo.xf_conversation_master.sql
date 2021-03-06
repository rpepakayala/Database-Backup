/****** Object:  Table [dbo].[xf_conversation_master]    Script Date: 5/15/2018 12:00:19 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_conversation_master](
	[conversation_id] [bigint] IDENTITY(250,1) NOT NULL,
	[title] [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[user_id] [bigint] NOT NULL,
	[username] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[start_date] [bigint] NOT NULL,
	[open_invite] [tinyint] NOT NULL,
	[conversation_open] [tinyint] NOT NULL,
	[reply_count] [bigint] NOT NULL,
	[recipient_count] [bigint] NOT NULL,
	[first_message_id] [bigint] NOT NULL,
	[last_message_date] [bigint] NOT NULL,
	[last_message_id] [bigint] NOT NULL,
	[last_message_user_id] [bigint] NOT NULL,
	[last_message_username] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[recipients] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_xf_conversation_master_conversation_id] PRIMARY KEY CLUSTERED 
(
	[conversation_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [user_id]    Script Date: 5/15/2018 12:00:19 PM ******/
CREATE NONCLUSTERED INDEX [user_id] ON [dbo].[xf_conversation_master]
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[xf_conversation_master] ADD  DEFAULT ((0)) FOR [open_invite]
ALTER TABLE [dbo].[xf_conversation_master] ADD  DEFAULT ((1)) FOR [conversation_open]
ALTER TABLE [dbo].[xf_conversation_master] ADD  DEFAULT ((0)) FOR [reply_count]
ALTER TABLE [dbo].[xf_conversation_master] ADD  DEFAULT ((0)) FOR [recipient_count]
GO
