/****** Object:  Table [dbo].[xf_liked_content]    Script Date: 5/15/2018 12:00:24 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_liked_content](
	[like_id] [bigint] IDENTITY(1489,1) NOT NULL,
	[content_type] [varbinary](25) NOT NULL,
	[content_id] [bigint] NOT NULL,
	[like_user_id] [bigint] NOT NULL,
	[like_date] [bigint] NOT NULL,
	[content_user_id] [bigint] NOT NULL,
 CONSTRAINT [PK_xf_liked_content_like_id] PRIMARY KEY CLUSTERED 
(
	[like_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [xf_liked_content$content_type_id_like_user_id] UNIQUE NONCLUSTERED 
(
	[content_type] ASC,
	[content_id] ASC,
	[like_user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [content_user_id_like_date]    Script Date: 5/15/2018 12:00:24 PM ******/
CREATE NONCLUSTERED INDEX [content_user_id_like_date] ON [dbo].[xf_liked_content]
(
	[content_user_id] ASC,
	[like_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [like_date]    Script Date: 5/15/2018 12:00:24 PM ******/
CREATE NONCLUSTERED INDEX [like_date] ON [dbo].[xf_liked_content]
(
	[like_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [like_user_content_type_id]    Script Date: 5/15/2018 12:00:24 PM ******/
CREATE NONCLUSTERED INDEX [like_user_content_type_id] ON [dbo].[xf_liked_content]
(
	[like_user_id] ASC,
	[content_type] ASC,
	[content_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
