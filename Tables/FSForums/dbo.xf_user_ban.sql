/****** Object:  Table [dbo].[xf_user_ban]    Script Date: 5/15/2018 12:00:38 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_user_ban](
	[user_id] [bigint] NOT NULL,
	[ban_user_id] [bigint] NOT NULL,
	[ban_date] [bigint] NOT NULL,
	[end_date] [bigint] NOT NULL,
	[user_reason] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[triggered] [tinyint] NOT NULL,
 CONSTRAINT [PK_xf_user_ban_user_id] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [ban_date]    Script Date: 5/15/2018 12:00:38 PM ******/
CREATE NONCLUSTERED INDEX [ban_date] ON [dbo].[xf_user_ban]
(
	[ban_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [end_date]    Script Date: 5/15/2018 12:00:38 PM ******/
CREATE NONCLUSTERED INDEX [end_date] ON [dbo].[xf_user_ban]
(
	[end_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[xf_user_ban] ADD  DEFAULT ((0)) FOR [ban_date]
ALTER TABLE [dbo].[xf_user_ban] ADD  DEFAULT ((0)) FOR [end_date]
ALTER TABLE [dbo].[xf_user_ban] ADD  DEFAULT ((1)) FOR [triggered]
GO
