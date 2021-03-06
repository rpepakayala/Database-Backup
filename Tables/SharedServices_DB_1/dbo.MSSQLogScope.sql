/****** Object:  Table [dbo].[MSSQLogScope]    Script Date: 5/15/2018 12:05:18 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MSSQLogScope](
	[scopeId] [int] IDENTITY(1,1) NOT NULL,
	[numScopes] [int] NULL,
	[scope] [nvarchar](450) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[lastReference] [smalldatetime] NULL
) ON [PRIMARY]

/****** Object:  Index [PK_MSSQLogScope]    Script Date: 5/15/2018 12:05:18 PM ******/
CREATE CLUSTERED INDEX [PK_MSSQLogScope] ON [dbo].[MSSQLogScope]
(
	[scopeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [IX_MSSQLogScope]    Script Date: 5/15/2018 12:05:18 PM ******/
CREATE NONCLUSTERED INDEX [IX_MSSQLogScope] ON [dbo].[MSSQLogScope]
(
	[scope] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
