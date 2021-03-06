/****** Object:  Table [dbo].[MSSQLogUnprocessed]    Script Date: 5/15/2018 12:05:18 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MSSQLogUnprocessed](
	[clickId] [bigint] NULL,
	[queryString] [nvarchar](1024) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[clickedUrl] [nvarchar](1024) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[resultsUrl] [nvarchar](1024) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[scope] [nvarchar](450) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[bestBet] [nvarchar](100) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[queryServer] [nvarchar](256) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[siteGuid] [uniqueidentifier] NULL,
	[searchTime] [datetime] NULL,
	[clickTime] [datetime] NULL,
	[searchDate] [smalldatetime] NULL,
	[clickedUrlRank] [int] NULL,
	[numResults] [int] NULL,
	[numHighConf] [int] NULL,
	[numBestBets] [int] NULL,
	[numScopes] [int] NULL,
	[resultView] [tinyint] NULL,
	[advancedSearch] [bit] NULL,
	[didYouMean] [bit] NULL,
	[continued] [bit] NULL,
	[contextualScope] [nvarchar](100) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[contextualScopeUrl] [nvarchar](1024) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[location] [nvarchar](60) COLLATE Latin1_General_CI_AS_KS_WS NULL
) ON [PRIMARY]

GO
