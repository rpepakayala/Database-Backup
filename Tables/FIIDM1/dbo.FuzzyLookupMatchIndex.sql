/****** Object:  Table [dbo].[FuzzyLookupMatchIndex]    Script Date: 5/15/2018 11:59:52 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[FuzzyLookupMatchIndex](
	[Token] [nvarchar](100) COLLATE Latin1_General_CS_AS_KS_WS NULL,
	[ColumnNumber] [int] NULL,
	[TokenProp] [int] NULL,
	[BucketNumber] [timestamp] NOT NULL,
	[Freq] [int] NULL,
	[Rids] [nvarchar](4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [token_idx]    Script Date: 5/15/2018 11:59:52 AM ******/
CREATE CLUSTERED INDEX [token_idx] ON [dbo].[FuzzyLookupMatchIndex]
(
	[Token] ASC,
	[ColumnNumber] ASC,
	[TokenProp] ASC,
	[BucketNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
