/****** Object:  Table [dbo].[SiteMap]    Script Date: 5/15/2018 12:06:08 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[SiteMap](
	[Id] [uniqueidentifier] NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[DatabaseId] [uniqueidentifier] NOT NULL,
	[Path] [nvarchar](128) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[Pairing] [tinyint] NOT NULL,
	[Status] [int] NOT NULL,
	[Version] [timestamp] NOT NULL,
	[RedirectUrl] [nvarchar](512) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[HostHeaderIsSiteName] [bit] NOT NULL,
 CONSTRAINT [PK_SiteMap] PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [IX_SiteMap_ApplicationId_Path]    Script Date: 5/15/2018 12:06:08 PM ******/
CREATE UNIQUE CLUSTERED INDEX [IX_SiteMap_ApplicationId_Path] ON [dbo].[SiteMap]
(
	[Path] ASC,
	[ApplicationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [IX_SiteMap_DatabaseId]    Script Date: 5/15/2018 12:06:08 PM ******/
CREATE NONCLUSTERED INDEX [IX_SiteMap_DatabaseId] ON [dbo].[SiteMap]
(
	[DatabaseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[SiteMap] ADD  DEFAULT ((0)) FOR [Pairing]
ALTER TABLE [dbo].[SiteMap] ADD  DEFAULT ((0)) FOR [HostHeaderIsSiteName]
ALTER TABLE [dbo].[SiteMap]  WITH CHECK ADD  CONSTRAINT [FK_SiteMap_Application] FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[Objects] ([Id])
ALTER TABLE [dbo].[SiteMap] CHECK CONSTRAINT [FK_SiteMap_Application]
ALTER TABLE [dbo].[SiteMap]  WITH CHECK ADD  CONSTRAINT [FK_SiteMap_Database] FOREIGN KEY([DatabaseId])
REFERENCES [dbo].[Objects] ([Id])
ON DELETE CASCADE
ALTER TABLE [dbo].[SiteMap] CHECK CONSTRAINT [FK_SiteMap_Database]
GO
