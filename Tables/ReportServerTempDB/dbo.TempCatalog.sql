/****** Object:  Table [dbo].[TempCatalog]    Script Date: 5/15/2018 12:05:06 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[TempCatalog](
	[EditSessionID] [varchar](32) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[TempCatalogID] [uniqueidentifier] NOT NULL,
	[ContextPath] [nvarchar](425) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[Name] [nvarchar](425) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[Content] [varbinary](max) NULL,
	[Description] [nvarchar](max) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[Intermediate] [uniqueidentifier] NULL,
	[IntermediateIsPermanent] [bit] NOT NULL,
	[Property] [nvarchar](max) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[Parameter] [nvarchar](max) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[OwnerID] [uniqueidentifier] NOT NULL,
	[CreationTime] [datetime] NOT NULL,
	[ExpirationTime] [datetime] NOT NULL,
	[DataCacheHash] [varbinary](64) NULL,
 CONSTRAINT [PK_TempCatalog] PRIMARY KEY CLUSTERED 
(
	[EditSessionID] ASC,
	[ContextPath] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UNIQ_TempCatalogID] UNIQUE NONCLUSTERED 
(
	[TempCatalogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [IX_Cleanup]    Script Date: 5/15/2018 12:05:06 PM ******/
CREATE NONCLUSTERED INDEX [IX_Cleanup] ON [dbo].[TempCatalog]
(
	[ExpirationTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[TempCatalog] ADD  DEFAULT ((0)) FOR [IntermediateIsPermanent]
GO
