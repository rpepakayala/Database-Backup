/****** Object:  Table [dbo].[MSSCrawlDeletedURL]    Script Date: 5/15/2018 12:05:24 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MSSCrawlDeletedURL](
	[TrackID] [bigint] IDENTITY(1,1) NOT NULL,
	[StartAddressID] [int] NOT NULL,
	[ContentSourceID] [int] NULL,
	[ProjectID] [int] NULL,
	[DocID] [int] NULL,
	[CrawlID] [int] NOT NULL,
	[HisCrawlID] [int] NULL,
	[HisCommitCrawlID] [int] NULL,
	[AccessURL] [nvarchar](1500) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[AccessHash] [int] NOT NULL,
	[CompactURL] [nvarchar](40) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[CompactHash] [int] NULL,
	[DisplayURL] [nvarchar](1500) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[DisplayHash] [int] NOT NULL,
	[TransactionType] [int] NULL,
	[Scope] [int] NULL,
	[TransactionFlags] [int] NULL,
	[HostDepth] [int] NULL,
	[EnumerationDepth] [int] NULL,
	[ParentDocID] [int] NULL,
	[UseChangeLog] [int] NULL,
	[ChangeLogCookie] [nvarchar](200) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[EndPathFlag] [int] NULL,
	[HostID] [int] NULL,
	[LCID] [int] NULL,
	[LogTime] [datetime] NULL,
	[ErrorID] [int] NULL,
	[ErrorLevel] [int] NULL,
	[DeleteReason] [int] NULL,
 CONSTRAINT [PK_MSSCrawlDeletedURL] PRIMARY KEY CLUSTERED 
(
	[TrackID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [IX_MSSCrawlDeletedURL_AccessHash]    Script Date: 5/15/2018 12:05:24 PM ******/
CREATE NONCLUSTERED INDEX [IX_MSSCrawlDeletedURL_AccessHash] ON [dbo].[MSSCrawlDeletedURL]
(
	[AccessHash] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [IX_MSSCrawlDeletedURL_ErrorId]    Script Date: 5/15/2018 12:05:24 PM ******/
CREATE NONCLUSTERED INDEX [IX_MSSCrawlDeletedURL_ErrorId] ON [dbo].[MSSCrawlDeletedURL]
(
	[ErrorLevel] ASC,
	[ErrorID] ASC,
	[ProjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [IX_MSSCrawlDeletedURL_HostID]    Script Date: 5/15/2018 12:05:24 PM ******/
CREATE NONCLUSTERED INDEX [IX_MSSCrawlDeletedURL_HostID] ON [dbo].[MSSCrawlDeletedURL]
(
	[HostID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [IX_MSSCrawlDeletedURL_Time]    Script Date: 5/15/2018 12:05:24 PM ******/
CREATE NONCLUSTERED INDEX [IX_MSSCrawlDeletedURL_Time] ON [dbo].[MSSCrawlDeletedURL]
(
	[LogTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
