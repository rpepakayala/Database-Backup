/****** Object:  Table [dbo].[Topic]    Script Date: 5/15/2018 12:08:10 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Topic](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SystemName] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IncludeInSitemap] [bit] NOT NULL,
	[IsPasswordProtected] [bit] NOT NULL,
	[Password] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Title] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Body] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MetaKeywords] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MetaDescription] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MetaTitle] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LimitedToStores] [bit] NOT NULL,
	[IncludeInTopMenu] [bit] NOT NULL,
	[TopicTemplateId] [int] NOT NULL,
	[IncludeInFooterColumn1] [bit] NOT NULL,
	[IncludeInFooterColumn2] [bit] NOT NULL,
	[IncludeInFooterColumn3] [bit] NOT NULL,
	[AccessibleWhenStoreClosed] [bit] NOT NULL,
	[DisplayOrder] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
