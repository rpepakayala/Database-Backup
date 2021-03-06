/****** Object:  Table [dbo].[xf_search_index]    Script Date: 5/15/2018 12:00:33 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_search_index](
	[content_type] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[content_id] [bigint] NOT NULL,
	[title] [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[message] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[metadata] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[user_id] [bigint] NOT NULL,
	[item_date] [bigint] NOT NULL,
	[discussion_id] [bigint] NOT NULL,
 CONSTRAINT [PK_xf_search_index_content_type] PRIMARY KEY CLUSTERED 
(
	[content_type] ASC,
	[content_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [user_id_item_date]    Script Date: 5/15/2018 12:00:33 PM ******/
CREATE NONCLUSTERED INDEX [user_id_item_date] ON [dbo].[xf_search_index]
(
	[user_id] ASC,
	[item_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[xf_search_index] ADD  DEFAULT (N'') FOR [title]
ALTER TABLE [dbo].[xf_search_index] ADD  DEFAULT ((0)) FOR [user_id]
ALTER TABLE [dbo].[xf_search_index] ADD  DEFAULT ((0)) FOR [discussion_id]
GO
