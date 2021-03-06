/****** Object:  Table [dbo].[ProductReview]    Script Date: 5/15/2018 12:07:50 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ProductReview](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[IsApproved] [bit] NOT NULL,
	[Title] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ReviewText] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Rating] [int] NOT NULL,
	[HelpfulYesTotal] [int] NOT NULL,
	[HelpfulNoTotal] [int] NOT NULL,
	[CreatedOnUtc] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [IX_ProductReview_ProductId]    Script Date: 5/15/2018 12:07:50 PM ******/
CREATE NONCLUSTERED INDEX [IX_ProductReview_ProductId] ON [dbo].[ProductReview]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[ProductReview]  WITH CHECK ADD  CONSTRAINT [ProductReview_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
ON DELETE CASCADE
ALTER TABLE [dbo].[ProductReview] CHECK CONSTRAINT [ProductReview_Customer]
ALTER TABLE [dbo].[ProductReview]  WITH CHECK ADD  CONSTRAINT [ProductReview_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
ON DELETE CASCADE
ALTER TABLE [dbo].[ProductReview] CHECK CONSTRAINT [ProductReview_Product]
GO
