/****** Object:  Table [dbo].[MSSCrawlChangedTargetDocs]    Script Date: 5/15/2018 12:05:24 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MSSCrawlChangedTargetDocs](
	[CrawlId] [int] NOT NULL,
	[DocId] [int] NOT NULL
) ON [PRIMARY]

/****** Object:  Index [IX_MSSCrawlChangedTargetDocs]    Script Date: 5/15/2018 12:05:24 PM ******/
CREATE UNIQUE CLUSTERED INDEX [IX_MSSCrawlChangedTargetDocs] ON [dbo].[MSSCrawlChangedTargetDocs]
(
	[CrawlId] ASC,
	[DocId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = ON, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
