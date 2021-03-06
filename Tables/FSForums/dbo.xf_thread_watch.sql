/****** Object:  Table [dbo].[xf_thread_watch]    Script Date: 5/15/2018 12:00:37 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_thread_watch](
	[user_id] [bigint] NOT NULL,
	[thread_id] [bigint] NOT NULL,
	[email_subscribe] [tinyint] NOT NULL,
 CONSTRAINT [PK_xf_thread_watch_user_id] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[thread_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [thread_id_email_subscribe]    Script Date: 5/15/2018 12:00:37 PM ******/
CREATE NONCLUSTERED INDEX [thread_id_email_subscribe] ON [dbo].[xf_thread_watch]
(
	[thread_id] ASC,
	[email_subscribe] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[xf_thread_watch] ADD  DEFAULT ((0)) FOR [email_subscribe]
GO
