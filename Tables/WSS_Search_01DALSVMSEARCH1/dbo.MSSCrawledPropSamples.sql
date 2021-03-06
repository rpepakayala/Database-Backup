/****** Object:  Table [dbo].[MSSCrawledPropSamples]    Script Date: 5/15/2018 12:09:07 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MSSCrawledPropSamples](
	[DocId] [int] NOT NULL,
	[CrawledPropertyId] [int] NOT NULL,
	[AccessHash] [int] NOT NULL
) ON [PRIMARY]

/****** Object:  Index [IX_MSSCrawledPropSamplesByDocid]    Script Date: 5/15/2018 12:09:07 PM ******/
CREATE UNIQUE CLUSTERED INDEX [IX_MSSCrawledPropSamplesByDocid] ON [dbo].[MSSCrawledPropSamples]
(
	[DocId] ASC,
	[CrawledPropertyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = ON, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [IX_MSSCrawledPropSamplesByPid]    Script Date: 5/15/2018 12:09:07 PM ******/
CREATE NONCLUSTERED INDEX [IX_MSSCrawledPropSamplesByPid] ON [dbo].[MSSCrawledPropSamples]
(
	[CrawledPropertyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
