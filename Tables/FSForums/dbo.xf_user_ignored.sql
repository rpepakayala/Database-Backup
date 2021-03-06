/****** Object:  Table [dbo].[xf_user_ignored]    Script Date: 5/15/2018 12:00:40 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_user_ignored](
	[user_id] [bigint] NOT NULL,
	[ignored_user_id] [bigint] NOT NULL,
 CONSTRAINT [PK_xf_user_ignored_user_id] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[ignored_user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [ignored_user_id]    Script Date: 5/15/2018 12:00:40 PM ******/
CREATE NONCLUSTERED INDEX [ignored_user_id] ON [dbo].[xf_user_ignored]
(
	[ignored_user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
