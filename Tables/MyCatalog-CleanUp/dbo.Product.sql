/****** Object:  Table [dbo].[Product]    Script Date: 5/15/2018 12:03:48 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Product](
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
	[UpdatedOnUtc] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [_dta_index_Product_50_1717581157__K1_K19]    Script Date: 5/15/2018 12:03:48 PM ******/
CREATE NONCLUSTERED INDEX [_dta_index_Product_50_1717581157__K1_K19] ON [dbo].[Product]
(
	[Id] ASC,
	[Deleted] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [_dta_index_Product_50_1717581157__K18_K1_K8_K19_K3_2_4_5_6_7_9_10_11_12_13_14_15_16_17_20_21_f35]    Script Date: 5/15/2018 12:03:48 PM ******/
CREATE NONCLUSTERED INDEX [_dta_index_Product_50_1717581157__K18_K1_K8_K19_K3_2_4_5_6_7_9_10_11_12_13_14_15_16_17_20_21_f35] ON [dbo].[Product]
(
	[Published] ASC,
	[Id] ASC,
	[ShowOnHomePage] ASC,
	[Deleted] ASC,
	[Name] ASC
)
INCLUDE ( 	[StoreId],
	[ShortDescription],
	[FullDescription],
	[AdminComment],
	[ProductTemplateId],
	[MetaKeywords],
	[MetaDescription],
	[MetaTitle],
	[SeName],
	[AllowCustomerReviews],
	[ApprovedRatingSum],
	[NotApprovedRatingSum],
	[ApprovedTotalReviews],
	[NotApprovedTotalReviews],
	[CreatedOnUtc],
	[UpdatedOnUtc]) 
WHERE ([Product].[Deleted]<>(1) AND [Product].[ShowOnHomePage]=(1))
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [idx_Product_StoreId_includes]    Script Date: 5/15/2018 12:03:48 PM ******/
CREATE NONCLUSTERED INDEX [idx_Product_StoreId_includes] ON [dbo].[Product]
(
	[StoreId] ASC
)
INCLUDE ( 	[Id],
	[Name],
	[ShortDescription],
	[FullDescription],
	[AdminComment],
	[ProductTemplateId],
	[ShowOnHomePage],
	[MetaKeywords],
	[MetaDescription],
	[MetaTitle],
	[SeName],
	[AllowCustomerReviews],
	[ApprovedRatingSum],
	[NotApprovedRatingSum],
	[ApprovedTotalReviews],
	[NotApprovedTotalReviews],
	[Published],
	[Deleted],
	[CreatedOnUtc],
	[UpdatedOnUtc]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [IX_Product_Published]    Script Date: 5/15/2018 12:03:48 PM ******/
CREATE NONCLUSTERED INDEX [IX_Product_Published] ON [dbo].[Product]
(
	[Published] ASC,
	[Deleted] ASC
)
INCLUDE ( 	[Id]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [Product_Store] FOREIGN KEY([StoreId])
REFERENCES [dbo].[Store] ([Id])
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [Product_Store]
GO
