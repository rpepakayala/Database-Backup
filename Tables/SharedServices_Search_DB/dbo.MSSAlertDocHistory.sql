/****** Object:  Table [dbo].[MSSAlertDocHistory]    Script Date: 5/15/2018 12:05:23 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MSSAlertDocHistory](
	[UrlSignature] [bigint] NULL,
	[ContentSignature] [bigint] NULL,
	[SchemaSignature] [int] NULL,
	[DiscoveryTime] [bigint] NULL,
	[ModificationTime] [bigint] NULL,
	[SchemaModificationTime] [bigint] NULL
) ON [PRIMARY]

/****** Object:  Index [IX_AlertDocHistory]    Script Date: 5/15/2018 12:05:23 PM ******/
CREATE UNIQUE CLUSTERED INDEX [IX_AlertDocHistory] ON [dbo].[MSSAlertDocHistory]
(
	[UrlSignature] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = ON, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
