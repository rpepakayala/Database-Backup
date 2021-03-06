/****** Object:  Table [dbo].[Forums_Topic]    Script Date: 5/15/2018 12:08:33 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Forums_Topic](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ForumId] [int] NOT NULL,
	[CustomerId] [int] NOT NULL,
	[TopicTypeId] [int] NOT NULL,
	[Subject] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[NumPosts] [int] NOT NULL,
	[Views] [int] NOT NULL,
	[LastPostId] [int] NOT NULL,
	[LastPostCustomerId] [int] NOT NULL,
	[LastPostTime] [datetime] NULL,
	[CreatedOnUtc] [datetime] NOT NULL,
	[UpdatedOnUtc] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [IX_Forums_Topic_ForumId]    Script Date: 5/15/2018 12:08:33 PM ******/
CREATE NONCLUSTERED INDEX [IX_Forums_Topic_ForumId] ON [dbo].[Forums_Topic]
(
	[ForumId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[Forums_Topic]  WITH CHECK ADD  CONSTRAINT [ForumTopic_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
ALTER TABLE [dbo].[Forums_Topic] CHECK CONSTRAINT [ForumTopic_Customer]
ALTER TABLE [dbo].[Forums_Topic]  WITH CHECK ADD  CONSTRAINT [ForumTopic_Forum] FOREIGN KEY([ForumId])
REFERENCES [dbo].[Forums_Forum] ([Id])
ON DELETE CASCADE
ALTER TABLE [dbo].[Forums_Topic] CHECK CONSTRAINT [ForumTopic_Forum]
GO
