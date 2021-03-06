/****** Object:  Table [dbo].[xf_forum_watch]    Script Date: 5/15/2018 12:00:22 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_forum_watch](
	[user_id] [bigint] NOT NULL,
	[node_id] [bigint] NOT NULL,
	[notify_on] [nvarchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[send_alert] [tinyint] NOT NULL,
	[send_email] [tinyint] NOT NULL,
 CONSTRAINT [PK_xf_forum_watch_user_id] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[node_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [node_id_notify_on]    Script Date: 5/15/2018 12:00:22 PM ******/
CREATE NONCLUSTERED INDEX [node_id_notify_on] ON [dbo].[xf_forum_watch]
(
	[node_id] ASC,
	[notify_on] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
