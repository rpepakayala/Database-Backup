/****** Object:  Table [dbo].[xf_user_trophy]    Script Date: 5/15/2018 12:00:41 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_user_trophy](
	[user_id] [bigint] NOT NULL,
	[trophy_id] [bigint] NOT NULL,
	[award_date] [bigint] NOT NULL,
 CONSTRAINT [PK_xf_user_trophy_trophy_id] PRIMARY KEY CLUSTERED 
(
	[trophy_id] ASC,
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [user_id_award_date]    Script Date: 5/15/2018 12:00:41 PM ******/
CREATE NONCLUSTERED INDEX [user_id_award_date] ON [dbo].[xf_user_trophy]
(
	[user_id] ASC,
	[award_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
