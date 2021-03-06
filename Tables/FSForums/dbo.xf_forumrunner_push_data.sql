/****** Object:  Table [dbo].[xf_forumrunner_push_data]    Script Date: 5/15/2018 12:00:23 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_forumrunner_push_data](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[user_id] [bigint] NOT NULL,
	[conversation_id] [bigint] NOT NULL,
	[thread_id] [int] NOT NULL,
	[threadread] [int] NOT NULL,
	[subsent] [tinyint] NOT NULL,
 CONSTRAINT [PK_xf_forumrunner_push_data_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[xf_forumrunner_push_data] ADD  DEFAULT ((0)) FOR [user_id]
ALTER TABLE [dbo].[xf_forumrunner_push_data] ADD  DEFAULT ((0)) FOR [conversation_id]
ALTER TABLE [dbo].[xf_forumrunner_push_data] ADD  DEFAULT ((0)) FOR [thread_id]
ALTER TABLE [dbo].[xf_forumrunner_push_data] ADD  DEFAULT ((0)) FOR [threadread]
ALTER TABLE [dbo].[xf_forumrunner_push_data] ADD  DEFAULT ((0)) FOR [subsent]
GO
