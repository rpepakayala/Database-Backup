/****** Object:  Table [dbo].[SLS_ROYALTY_REPORT]    Script Date: 5/15/2018 11:58:40 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[SLS_ROYALTY_REPORT](
	[RoyaltyReportID] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[RoyaltyPeriodID] [bigint] NOT NULL,
	[TotalSales] [numeric](18, 2) NOT NULL,
	[ReportNumber] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DateReceived] [datetime] NULL,
	[AuditID] [bigint] NULL,
	[Status] [bigint] NULL,
	[Comments] [varchar](8000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FIIDue] [money] NULL,
	[NACDue] [money] NULL,
	[OperatingMonth] [bigint] NULL,
 CONSTRAINT [PK_SLS_ROYALTY_REPORT] PRIMARY KEY CLUSTERED 
(
	[RoyaltyReportID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 97) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [IX_SLS_ROYALTY_REPORT_RoyaltyPeriodID_TotalSales]    Script Date: 5/15/2018 11:58:40 AM ******/
CREATE NONCLUSTERED INDEX [IX_SLS_ROYALTY_REPORT_RoyaltyPeriodID_TotalSales] ON [dbo].[SLS_ROYALTY_REPORT]
(
	[RoyaltyPeriodID] ASC
)
INCLUDE ( 	[TotalSales]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
