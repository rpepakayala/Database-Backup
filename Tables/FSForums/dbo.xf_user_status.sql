/****** Object:  Table [dbo].[xf_user_status]    Script Date: 5/15/2018 12:00:41 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_user_status](
	[profile_post_id] [bigint] NOT NULL,
	[user_id] [bigint] NOT NULL,
	[post_date] [bigint] NOT NULL,
 CONSTRAINT [PK_xf_user_status_profile_post_id] PRIMARY KEY CLUSTERED 
(
	[profile_post_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [post_date]    Script Date: 5/15/2018 12:00:41 PM ******/
CREATE NONCLUSTERED INDEX [post_date] ON [dbo].[xf_user_status]
(
	[post_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
