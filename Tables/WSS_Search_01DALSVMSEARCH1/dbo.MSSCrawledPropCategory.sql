/****** Object:  Table [dbo].[MSSCrawledPropCategory]    Script Date: 5/15/2018 12:09:06 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MSSCrawledPropCategory](
	[Propset] [uniqueidentifier] NOT NULL,
	[CategoryNameHash]  AS (binary_checksum([CategoryName])),
	[CategoryName] [nvarchar](64) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[SubCategoryName] [nvarchar](64) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[CrawledPropertyCount] [int] NOT NULL,
	[DiscoverNewProperties] [bit] NOT NULL,
	[MapToContents] [bit] NOT NULL,
	[FullTextQueriable] [bit] NOT NULL,
	[Retrievable] [bit] NOT NULL,
	[URINamespaceHash]  AS (binary_checksum([URINamespace])),
	[URINamespace] [nvarchar](440) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[LastModified] [datetime] NOT NULL,
 CONSTRAINT [PK_MSSCrawledPropCategory] PRIMARY KEY CLUSTERED 
(
	[Propset] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[MSSCrawledPropCategory] ADD  DEFAULT ((0)) FOR [CrawledPropertyCount]
ALTER TABLE [dbo].[MSSCrawledPropCategory] ADD  DEFAULT ((1)) FOR [DiscoverNewProperties]
ALTER TABLE [dbo].[MSSCrawledPropCategory] ADD  DEFAULT ((0)) FOR [MapToContents]
ALTER TABLE [dbo].[MSSCrawledPropCategory] ADD  DEFAULT ((0)) FOR [FullTextQueriable]
ALTER TABLE [dbo].[MSSCrawledPropCategory] ADD  DEFAULT ((0)) FOR [Retrievable]
ALTER TABLE [dbo].[MSSCrawledPropCategory] ADD  DEFAULT ('2000-01-01 01:01:01.000') FOR [LastModified]
GO
