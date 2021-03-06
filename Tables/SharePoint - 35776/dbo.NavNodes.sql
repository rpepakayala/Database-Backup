/****** Object:  Table [dbo].[NavNodes]    Script Date: 5/15/2018 12:05:42 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[NavNodes](
	[SiteId] [uniqueidentifier] NOT NULL,
	[WebId] [uniqueidentifier] NOT NULL,
	[Eid] [int] NOT NULL,
	[EidParent] [int] NOT NULL,
	[NumChildren] [int] NOT NULL,
	[RankChild] [int] NOT NULL,
	[ElementType] [tinyint] NOT NULL,
	[Url] [nvarchar](260) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[DocId] [uniqueidentifier] NULL,
	[Name] [nvarchar](256) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[DateLastModified] [datetime] NOT NULL,
	[NodeMetainfo] [image] NULL,
	[NonNavPage] [bit] NOT NULL,
	[NavSequence] [bit] NOT NULL,
	[ChildOfSequence] [bit] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [NavNodes_PK]    Script Date: 5/15/2018 12:05:42 PM ******/
CREATE UNIQUE CLUSTERED INDEX [NavNodes_PK] ON [dbo].[NavNodes]
(
	[SiteId] ASC,
	[WebId] ASC,
	[Eid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [NavNodes_AltPK]    Script Date: 5/15/2018 12:05:42 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [NavNodes_AltPK] ON [dbo].[NavNodes]
(
	[SiteId] ASC,
	[WebId] ASC,
	[EidParent] ASC,
	[RankChild] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [NavNodes_DocId]    Script Date: 5/15/2018 12:05:42 PM ******/
CREATE NONCLUSTERED INDEX [NavNodes_DocId] ON [dbo].[NavNodes]
(
	[DocId] ASC,
	[ChildOfSequence] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
