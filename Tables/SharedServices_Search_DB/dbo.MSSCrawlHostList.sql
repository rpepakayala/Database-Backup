/****** Object:  Table [dbo].[MSSCrawlHostList]    Script Date: 5/15/2018 12:05:25 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MSSCrawlHostList](
	[HostID] [int] IDENTITY(1,1) NOT NULL,
	[HostName] [nvarchar](300) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[SuccessCount] [int] NOT NULL,
	[ErrorCount] [int] NOT NULL,
	[WarningCount] [int] NOT NULL,
 CONSTRAINT [PK_MSSCrawlHostList] PRIMARY KEY CLUSTERED 
(
	[HostID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [IX_MSSCrawlHostList_Name]    Script Date: 5/15/2018 12:05:25 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_MSSCrawlHostList_Name] ON [dbo].[MSSCrawlHostList]
(
	[HostName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = ON, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[MSSCrawlHostList] ADD  CONSTRAINT [DF_MSSCrawlHostList_SuccessCount]  DEFAULT ((0)) FOR [SuccessCount]
ALTER TABLE [dbo].[MSSCrawlHostList] ADD  CONSTRAINT [DF_MSSCrawlHostList_ErrorCount]  DEFAULT ((0)) FOR [ErrorCount]
ALTER TABLE [dbo].[MSSCrawlHostList] ADD  CONSTRAINT [DF_MSSCrawlHostList_WarningCount]  DEFAULT ((0)) FOR [WarningCount]
GO
