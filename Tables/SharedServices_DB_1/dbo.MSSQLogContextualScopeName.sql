/****** Object:  Table [dbo].[MSSQLogContextualScopeName]    Script Date: 5/15/2018 12:05:15 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MSSQLogContextualScopeName](
	[contextualScopeNameId] [int] IDENTITY(1,1) NOT NULL,
	[contextualScope] [nvarchar](100) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[lastReference] [smalldatetime] NULL
) ON [PRIMARY]

/****** Object:  Index [PK_MSSQLogContextualScopeName]    Script Date: 5/15/2018 12:05:15 PM ******/
CREATE CLUSTERED INDEX [PK_MSSQLogContextualScopeName] ON [dbo].[MSSQLogContextualScopeName]
(
	[contextualScopeNameId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [IX_MSSQLogContextualScopeName]    Script Date: 5/15/2018 12:05:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_MSSQLogContextualScopeName] ON [dbo].[MSSQLogContextualScopeName]
(
	[contextualScope] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
