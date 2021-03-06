/****** Object:  Table [dbo].[ANLResource]    Script Date: 5/15/2018 12:05:09 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ANLResource](
	[ResourceId] [int] IDENTITY(1,1) NOT NULL,
	[WebAppGuid] [uniqueidentifier] NOT NULL,
	[SiteGuid] [uniqueidentifier] NOT NULL,
	[WebGuid] [uniqueidentifier] NOT NULL,
	[DocName] [nvarchar](260) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[FullUrl] [nvarchar](260) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[HostDns] [nvarchar](64) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
 CONSTRAINT [PK_ANLResource] PRIMARY KEY CLUSTERED 
(
	[ResourceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [IX_ANLResourceResourceIdSiteGuid]    Script Date: 5/15/2018 12:05:09 PM ******/
CREATE NONCLUSTERED INDEX [IX_ANLResourceResourceIdSiteGuid] ON [dbo].[ANLResource]
(
	[ResourceId] ASC,
	[WebGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [IX_ANLResourceSiteGuidWebGuidResourceId]    Script Date: 5/15/2018 12:05:09 PM ******/
CREATE NONCLUSTERED INDEX [IX_ANLResourceSiteGuidWebGuidResourceId] ON [dbo].[ANLResource]
(
	[SiteGuid] ASC,
	[WebGuid] ASC,
	[ResourceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [IX_ANLResourceWebGuid]    Script Date: 5/15/2018 12:05:09 PM ******/
CREATE NONCLUSTERED INDEX [IX_ANLResourceWebGuid] ON [dbo].[ANLResource]
(
	[WebGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [IX_ANLResourceWebGuidSiteGuid]    Script Date: 5/15/2018 12:05:09 PM ******/
CREATE NONCLUSTERED INDEX [IX_ANLResourceWebGuidSiteGuid] ON [dbo].[ANLResource]
(
	[WebGuid] ASC,
	[SiteGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
