/****** Object:  Table [dbo].[BlogComment]    Script Date: 5/15/2018 12:03:40 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[BlogComment](
	[Id] [int] NOT NULL,
	[CommentText] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BlogPostId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [IX_BlogComment_BlogPostId]    Script Date: 5/15/2018 12:03:40 PM ******/
CREATE NONCLUSTERED INDEX [IX_BlogComment_BlogPostId] ON [dbo].[BlogComment]
(
	[BlogPostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[BlogComment]  WITH CHECK ADD  CONSTRAINT [BlogComment_BlogPost1] FOREIGN KEY([BlogPostId])
REFERENCES [dbo].[BlogPost] ([Id])
ON DELETE CASCADE
ALTER TABLE [dbo].[BlogComment] CHECK CONSTRAINT [BlogComment_BlogPost1]
ALTER TABLE [dbo].[BlogComment]  WITH CHECK ADD  CONSTRAINT [BlogComment_TypeConstraint_From_CustomerContent_To_BlogComment] FOREIGN KEY([Id])
REFERENCES [dbo].[CustomerContent] ([Id])
ALTER TABLE [dbo].[BlogComment] CHECK CONSTRAINT [BlogComment_TypeConstraint_From_CustomerContent_To_BlogComment]
GO
