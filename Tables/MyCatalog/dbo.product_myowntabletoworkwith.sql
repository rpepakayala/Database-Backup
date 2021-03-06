/****** Object:  Table [dbo].[product_myowntabletoworkwith]    Script Date: 5/15/2018 12:03:30 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[product_myowntabletoworkwith](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StoreId] [int] NOT NULL,
	[Name] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ShortDescription] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FullDescription] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AdminComment] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ProductTemplateId] [int] NOT NULL,
	[ShowOnHomePage] [bit] NOT NULL,
	[MetaKeywords] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MetaDescription] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MetaTitle] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SeName] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AllowCustomerReviews] [bit] NOT NULL,
	[ApprovedRatingSum] [int] NOT NULL,
	[NotApprovedRatingSum] [int] NOT NULL,
	[ApprovedTotalReviews] [int] NOT NULL,
	[NotApprovedTotalReviews] [int] NOT NULL,
	[Published] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[CreatedOnUtc] [datetime] NOT NULL,
	[UpdatedOnUtc] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [IX_product_myowntabletoworkwith_StoreId]    Script Date: 5/15/2018 12:03:30 PM ******/
CREATE NONCLUSTERED INDEX [IX_product_myowntabletoworkwith_StoreId] ON [dbo].[product_myowntabletoworkwith]
(
	[StoreId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[product_myowntabletoworkwith]  WITH CHECK ADD  CONSTRAINT [product_myowntabletoworkwith_Store] FOREIGN KEY([StoreId])
REFERENCES [dbo].[Store] ([Id])
ALTER TABLE [dbo].[product_myowntabletoworkwith] CHECK CONSTRAINT [product_myowntabletoworkwith_Store]
GO
