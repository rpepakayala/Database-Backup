/****** Object:  Table [dbo].[xf_moderation_queue]    Script Date: 5/15/2018 12:00:24 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_moderation_queue](
	[content_type] [varbinary](25) NOT NULL,
	[content_id] [bigint] NOT NULL,
	[content_date] [bigint] NOT NULL,
 CONSTRAINT [PK_xf_moderation_queue_content_type] PRIMARY KEY CLUSTERED 
(
	[content_type] ASC,
	[content_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [content_date]    Script Date: 5/15/2018 12:00:24 PM ******/
CREATE NONCLUSTERED INDEX [content_date] ON [dbo].[xf_moderation_queue]
(
	[content_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[xf_moderation_queue] ADD  DEFAULT ((0)) FOR [content_date]
GO
