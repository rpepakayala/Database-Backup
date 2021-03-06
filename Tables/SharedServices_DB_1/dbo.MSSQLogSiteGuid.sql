/****** Object:  Table [dbo].[MSSQLogSiteGuid]    Script Date: 5/15/2018 12:05:18 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MSSQLogSiteGuid](
	[siteId] [int] IDENTITY(1,1) NOT NULL,
	[siteGuid] [uniqueidentifier] NULL,
	[lastReference] [smalldatetime] NULL
) ON [PRIMARY]

/****** Object:  Index [PK_MSSQLogSiteGuid]    Script Date: 5/15/2018 12:05:18 PM ******/
CREATE CLUSTERED INDEX [PK_MSSQLogSiteGuid] ON [dbo].[MSSQLogSiteGuid]
(
	[siteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [IX_MSSQLogSiteGuid]    Script Date: 5/15/2018 12:05:18 PM ******/
CREATE NONCLUSTERED INDEX [IX_MSSQLogSiteGuid] ON [dbo].[MSSQLogSiteGuid]
(
	[siteGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
