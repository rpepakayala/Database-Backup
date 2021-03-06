/****** Object:  Table [dbo].[Category]    Script Date: 5/15/2018 12:03:41 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Category](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StoreId] [int] NOT NULL,
	[Name] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Description] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MetaKeywords] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MetaDescription] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MetaTitle] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SeName] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ParentCategoryId] [int] NOT NULL,
	[PictureId] [int] NOT NULL,
	[PageSize] [int] NOT NULL,
	[PriceRanges] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShowOnHomePage] [bit] NOT NULL,
	[Published] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[CreatedOnUtc] [datetime] NOT NULL,
	[UpdatedOnUtc] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [_dta_index_Category_50_149575571__K2_K14_K13_K15_K1_K16_3_4_5_6_7_8_9_10_11_12_17_18]    Script Date: 5/15/2018 12:03:41 PM ******/
CREATE NONCLUSTERED INDEX [_dta_index_Category_50_149575571__K2_K14_K13_K15_K1_K16_3_4_5_6_7_8_9_10_11_12_17_18] ON [dbo].[Category]
(
	[StoreId] ASC,
	[Published] ASC,
	[ShowOnHomePage] ASC,
	[Deleted] ASC,
	[Id] ASC,
	[DisplayOrder] ASC
)
INCLUDE ( 	[Name],
	[Description],
	[MetaKeywords],
	[MetaDescription],
	[MetaTitle],
	[SeName],
	[ParentCategoryId],
	[PictureId],
	[PageSize],
	[PriceRanges],
	[CreatedOnUtc],
	[UpdatedOnUtc]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [IX_Category_ParentCategoryId]    Script Date: 5/15/2018 12:03:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_Category_ParentCategoryId] ON [dbo].[Category]
(
	[ParentCategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [IX_Category_StoreId]    Script Date: 5/15/2018 12:03:41 PM ******/
CREATE NONCLUSTERED INDEX [IX_Category_StoreId] ON [dbo].[Category]
(
	[StoreId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[Category]  WITH CHECK ADD  CONSTRAINT [Category_Store] FOREIGN KEY([StoreId])
REFERENCES [dbo].[Store] ([Id])
ALTER TABLE [dbo].[Category] CHECK CONSTRAINT [Category_Store]
GO
