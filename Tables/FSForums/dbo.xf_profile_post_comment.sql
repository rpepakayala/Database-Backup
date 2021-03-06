/****** Object:  Table [dbo].[xf_profile_post_comment]    Script Date: 5/15/2018 12:00:31 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_profile_post_comment](
	[profile_post_comment_id] [bigint] IDENTITY(16,1) NOT NULL,
	[profile_post_id] [bigint] NOT NULL,
	[user_id] [bigint] NOT NULL,
	[username] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[comment_date] [bigint] NOT NULL,
	[message] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ip_id] [bigint] NOT NULL,
 CONSTRAINT [PK_xf_profile_post_comment_profile_post_comment_id] PRIMARY KEY CLUSTERED 
(
	[profile_post_comment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [comment_date]    Script Date: 5/15/2018 12:00:31 PM ******/
CREATE NONCLUSTERED INDEX [comment_date] ON [dbo].[xf_profile_post_comment]
(
	[comment_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [profile_post_id_comment_date]    Script Date: 5/15/2018 12:00:31 PM ******/
CREATE NONCLUSTERED INDEX [profile_post_id_comment_date] ON [dbo].[xf_profile_post_comment]
(
	[profile_post_id] ASC,
	[comment_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [user_id]    Script Date: 5/15/2018 12:00:31 PM ******/
CREATE NONCLUSTERED INDEX [user_id] ON [dbo].[xf_profile_post_comment]
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[xf_profile_post_comment] ADD  DEFAULT ((0)) FOR [ip_id]
GO
