/****** Object:  Table [dbo].[MSSQLogUrl]    Script Date: 5/15/2018 12:05:19 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MSSQLogUrl](
	[urlId] [int] IDENTITY(1,1) NOT NULL,
	[url] [nvarchar](1024) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[urlHash] [int] NULL,
	[lastReference] [smalldatetime] NULL
) ON [PRIMARY]

/****** Object:  Index [PK_MSSQLogUrl]    Script Date: 5/15/2018 12:05:19 PM ******/
CREATE CLUSTERED INDEX [PK_MSSQLogUrl] ON [dbo].[MSSQLogUrl]
(
	[urlId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [IX_MSSQLogUrl_Hash]    Script Date: 5/15/2018 12:05:19 PM ******/
CREATE NONCLUSTERED INDEX [IX_MSSQLogUrl_Hash] ON [dbo].[MSSQLogUrl]
(
	[urlHash] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
