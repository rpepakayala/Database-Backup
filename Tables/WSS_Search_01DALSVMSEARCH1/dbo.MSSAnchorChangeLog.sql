/****** Object:  Table [dbo].[MSSAnchorChangeLog]    Script Date: 5/15/2018 12:09:03 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MSSAnchorChangeLog](
	[CrawlId] [int] NOT NULL,
	[TargetDocId] [int] NOT NULL,
	[ChangeType] [int] NOT NULL
) ON [PRIMARY]

/****** Object:  Index [IX_MSSAnchorChangeLog]    Script Date: 5/15/2018 12:09:03 PM ******/
CREATE UNIQUE CLUSTERED INDEX [IX_MSSAnchorChangeLog] ON [dbo].[MSSAnchorChangeLog]
(
	[CrawlId] ASC,
	[TargetDocId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = ON, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
