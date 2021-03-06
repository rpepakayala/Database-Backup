/****** Object:  Table [dbo].[Deps]    Script Date: 5/15/2018 12:05:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Deps](
	[SiteId] [uniqueidentifier] NOT NULL,
	[DeleteTransactionId] [varbinary](16) NOT NULL,
	[FullUrl] [nvarchar](260) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[DepType] [tinyint] NOT NULL,
	[DepDesc] [nvarchar](270) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[Level] [tinyint] NOT NULL
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [Deps_DocToDep]    Script Date: 5/15/2018 12:05:34 PM ******/
CREATE CLUSTERED INDEX [Deps_DocToDep] ON [dbo].[Deps]
(
	[SiteId] ASC,
	[DeleteTransactionId] ASC,
	[FullUrl] ASC,
	[Level] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [Deps_DepToDoc]    Script Date: 5/15/2018 12:05:34 PM ******/
CREATE NONCLUSTERED INDEX [Deps_DepToDoc] ON [dbo].[Deps]
(
	[SiteId] ASC,
	[DepDesc] ASC,
	[DepType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[Deps] ADD  DEFAULT (0x) FOR [DeleteTransactionId]
ALTER TABLE [dbo].[Deps] ADD  DEFAULT ((1)) FOR [Level]
GO
