/****** Object:  Table [Royalty].[CenterSales]    Script Date: 5/15/2018 11:59:42 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Royalty].[CenterSales](
	[ID] [bigint] NOT NULL,
	[StoreNumber] [bigint] NULL,
	[WebNumber] [bigint] NULL,
	[PeriodEndDate] [datetime] NULL,
	[TotalSales] [money] NULL,
	[MonthsInOperation] [bigint] NULL,
	[StoreOpenDate] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[StoreOpenByYear] [int] NULL,
	[StoreType] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[StoreResaleDate] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_CenterSales] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [Hint_Royalty.CenterSales_PeriodEndDate]    Script Date: 5/15/2018 11:59:42 AM ******/
CREATE NONCLUSTERED INDEX [Hint_Royalty.CenterSales_PeriodEndDate] ON [Royalty].[CenterSales]
(
	[PeriodEndDate] ASC
)
INCLUDE ( 	[StoreNumber],
	[TotalSales]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
