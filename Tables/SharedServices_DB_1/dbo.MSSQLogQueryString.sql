/****** Object:  Table [dbo].[MSSQLogQueryString]    Script Date: 5/15/2018 12:05:17 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MSSQLogQueryString](
	[queryId] [int] IDENTITY(1,1) NOT NULL,
	[queryString] [nvarchar](1024) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[queryStringHash] [int] NULL,
	[lastReference] [smalldatetime] NULL
) ON [PRIMARY]

/****** Object:  Index [PK_MSSQLogQueryString]    Script Date: 5/15/2018 12:05:17 PM ******/
CREATE CLUSTERED INDEX [PK_MSSQLogQueryString] ON [dbo].[MSSQLogQueryString]
(
	[queryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [IX_MSSQLogQueryString_Hash]    Script Date: 5/15/2018 12:05:17 PM ******/
CREATE NONCLUSTERED INDEX [IX_MSSQLogQueryString_Hash] ON [dbo].[MSSQLogQueryString]
(
	[queryStringHash] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
