/****** Object:  Table [dbo].[Category]    Script Date: 5/15/2018 12:04:39 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Category](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Description] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CategoryTemplateId] [int] NOT NULL,
	[MetaKeywords] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MetaDescription] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MetaTitle] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ParentCategoryId] [int] NOT NULL,
	[PictureId] [int] NOT NULL,
	[PageSize] [int] NOT NULL,
	[AllowCustomersToSelectPageSize] [bit] NOT NULL,
	[PageSizeOptions] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PriceRanges] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShowOnHomePage] [bit] NOT NULL,
	[IncludeInTopMenu] [bit] NOT NULL,
	[HasDiscountsApplied] [bit] NOT NULL,
	[SubjectToAcl] [bit] NOT NULL,
	[LimitedToStores] [bit] NOT NULL,
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

/****** Object:  Index [IX_Category_DisplayOrder]    Script Date: 5/15/2018 12:04:39 PM ******/
CREATE NONCLUSTERED INDEX [IX_Category_DisplayOrder] ON [dbo].[Category]
(
	[DisplayOrder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [IX_Category_LimitedToStores]    Script Date: 5/15/2018 12:04:39 PM ******/
CREATE NONCLUSTERED INDEX [IX_Category_LimitedToStores] ON [dbo].[Category]
(
	[LimitedToStores] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [IX_Category_ParentCategoryId]    Script Date: 5/15/2018 12:04:39 PM ******/
CREATE NONCLUSTERED INDEX [IX_Category_ParentCategoryId] ON [dbo].[Category]
(
	[ParentCategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [IX_Category_SubjectToAcl]    Script Date: 5/15/2018 12:04:39 PM ******/
CREATE NONCLUSTERED INDEX [IX_Category_SubjectToAcl] ON [dbo].[Category]
(
	[SubjectToAcl] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
