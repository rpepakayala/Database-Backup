/****** Object:  Table [dbo].[MSSChangeLogCookies]    Script Date: 5/15/2018 12:05:24 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MSSChangeLogCookies](
	[ChangeLogCookie_old] [nvarchar](200) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[ChangeLogCookie_new] [nvarchar](200) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[CrawlID] [int] NOT NULL,
	[DocID] [int] NOT NULL,
	[UpdateTime] [datetime] NOT NULL
) ON [PRIMARY]

GO
