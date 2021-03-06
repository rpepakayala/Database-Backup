/****** Object:  Table [dbo].[MSSCrawlErrorList]    Script Date: 5/15/2018 12:09:07 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MSSCrawlErrorList](
	[ErrorID] [int] IDENTITY(1,1) NOT NULL,
	[hrResult] [int] NOT NULL,
	[ErrorLevel] [int] NOT NULL,
	[MarkDelete] [bit] NOT NULL,
	[ErrorMsg] [nvarchar](2000) COLLATE Latin1_General_CI_AS_KS_WS NULL,
 CONSTRAINT [PK_MSSCrawlErrorList] PRIMARY KEY CLUSTERED 
(
	[ErrorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [IX_MSSCrawlErrorList_hrResult]    Script Date: 5/15/2018 12:09:07 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_MSSCrawlErrorList_hrResult] ON [dbo].[MSSCrawlErrorList]
(
	[hrResult] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = ON, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[MSSCrawlErrorList] ADD  CONSTRAINT [DF_MSSCrawlErrorList_MarkDelete]  DEFAULT ((0)) FOR [MarkDelete]
GO
