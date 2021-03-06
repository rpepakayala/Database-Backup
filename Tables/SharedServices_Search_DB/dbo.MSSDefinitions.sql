/****** Object:  Table [dbo].[MSSDefinitions]    Script Date: 5/15/2018 12:05:26 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MSSDefinitions](
	[Term] [nvarchar](40) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[DocId] [int] NOT NULL,
	[Sentence] [nvarchar](255) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[TermOffset] [int] NOT NULL,
	[TermLength] [int] NOT NULL
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [IX_MSSDEFINITIONS_TERM]    Script Date: 5/15/2018 12:05:26 PM ******/
CREATE CLUSTERED INDEX [IX_MSSDEFINITIONS_TERM] ON [dbo].[MSSDefinitions]
(
	[Term] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [IX_MSSDEFINITIONS_DOCID]    Script Date: 5/15/2018 12:05:26 PM ******/
CREATE NONCLUSTERED INDEX [IX_MSSDEFINITIONS_DOCID] ON [dbo].[MSSDefinitions]
(
	[DocId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
