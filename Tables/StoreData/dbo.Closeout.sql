/****** Object:  Table [dbo].[Closeout]    Script Date: 5/15/2018 12:06:42 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Closeout](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[ModifiedByUser] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[SeqID] [int] NULL,
	[IsSystem] [bit] NULL,
	[IsActive] [bit] NULL,
	[CloseoutType] [int] NULL,
	[CategoryID] [int] NULL,
	[CloseoutTypeText] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CloseOutPeriod] [int] NULL,
 CONSTRAINT [Closeout_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[StoreID] ASC,
	[ClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [Indexe_CloseOut_CloseOutPeriod]    Script Date: 5/15/2018 12:06:42 PM ******/
CREATE NONCLUSTERED INDEX [Indexe_CloseOut_CloseOutPeriod] ON [dbo].[Closeout]
(
	[CloseOutPeriod] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [Indexe_CloseOut_CloseOutTypeText]    Script Date: 5/15/2018 12:06:42 PM ******/
CREATE NONCLUSTERED INDEX [Indexe_CloseOut_CloseOutTypeText] ON [dbo].[Closeout]
(
	[CloseoutTypeText] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Indexes_CloseOut]    Script Date: 5/15/2018 12:06:42 PM ******/
CREATE NONCLUSTERED INDEX [Indexes_CloseOut] ON [dbo].[Closeout]
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
