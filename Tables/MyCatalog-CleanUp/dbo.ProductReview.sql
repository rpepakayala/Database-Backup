/****** Object:  Table [dbo].[ProductReview]    Script Date: 5/15/2018 12:03:50 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ProductReview](
	[Id] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[Title] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ReviewText] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Rating] [int] NOT NULL,
	[HelpfulYesTotal] [int] NOT NULL,
	[HelpfulNoTotal] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [IX_ProductReview_ProductId]    Script Date: 5/15/2018 12:03:50 PM ******/
CREATE NONCLUSTERED INDEX [IX_ProductReview_ProductId] ON [dbo].[ProductReview]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[ProductReview]  WITH CHECK ADD  CONSTRAINT [ProductReview_Product1] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
ON DELETE CASCADE
ALTER TABLE [dbo].[ProductReview] CHECK CONSTRAINT [ProductReview_Product1]
ALTER TABLE [dbo].[ProductReview]  WITH CHECK ADD  CONSTRAINT [ProductReview_TypeConstraint_From_CustomerContent_To_ProductReview] FOREIGN KEY([Id])
REFERENCES [dbo].[CustomerContent] ([Id])
ALTER TABLE [dbo].[ProductReview] CHECK CONSTRAINT [ProductReview_TypeConstraint_From_CustomerContent_To_ProductReview]
GO
