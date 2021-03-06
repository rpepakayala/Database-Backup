/****** Object:  Table [dbo].[xf_notice_dismissed]    Script Date: 5/15/2018 12:00:27 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_notice_dismissed](
	[notice_id] [bigint] NOT NULL,
	[user_id] [bigint] NOT NULL,
	[dismiss_date] [bigint] NOT NULL,
 CONSTRAINT [PK_xf_notice_dismissed_notice_id] PRIMARY KEY CLUSTERED 
(
	[notice_id] ASC,
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [user_id]    Script Date: 5/15/2018 12:00:27 PM ******/
CREATE NONCLUSTERED INDEX [user_id] ON [dbo].[xf_notice_dismissed]
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[xf_notice_dismissed] ADD  DEFAULT ((0)) FOR [dismiss_date]
GO
