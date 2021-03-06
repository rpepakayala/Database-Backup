/****** Object:  Table [dbo].[CollationNames]    Script Date: 5/15/2018 12:05:33 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[CollationNames](
	[CollationName] [nvarchar](32) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[Collation] [smallint] NOT NULL
) ON [PRIMARY]

/****** Object:  Index [CollationNames_Collation]    Script Date: 5/15/2018 12:05:33 PM ******/
CREATE CLUSTERED INDEX [CollationNames_Collation] ON [dbo].[CollationNames]
(
	[Collation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
