/****** Object:  Table [dbo].[MSSCrawlURLLog]    Script Date: 5/15/2018 12:05:26 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MSSCrawlURLLog](
	[TrackID] [bigint] IDENTITY(1,1) NOT NULL,
	[StartAddressID] [int] NULL,
	[ContentSourceID] [int] NULL,
	[ProjectID] [int] NULL,
	[ErrorID] [int] NULL,
	[DocID] [int] NULL,
	[CrawlID] [int] NULL,
	[AccessURL] [nvarchar](1500) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[AccessHash] [int] NULL,
	[CompactURL] [nvarchar](40) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[CompactHash] [int] NULL,
	[DisplayURL] [nvarchar](1500) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[DisplayHash] [int] NULL,
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
	[LastTouchStart] [datetime] NULL,
	[LastTouchEnd] [datetime] NULL,
	[ErrorDesc] [nvarchar](512) COLLATE Latin1_General_CI_AS_KS_WS NULL,
 CONSTRAINT [PK_MSSCrawlURLLog] PRIMARY KEY CLUSTERED 
(
	[TrackID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
