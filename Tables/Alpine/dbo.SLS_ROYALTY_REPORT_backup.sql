/****** Object:  Table [dbo].[SLS_ROYALTY_REPORT_backup]    Script Date: 5/15/2018 11:58:40 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[SLS_ROYALTY_REPORT_backup](
	[RoyaltyReportID] [bigint] IDENTITY(1,1) NOT NULL,
	[RoyaltyPeriodID] [bigint] NOT NULL,
	[TotalSales] [numeric](18, 2) NOT NULL,
	[ReportNumber] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DateReceived] [datetime] NULL,
	[AuditID] [bigint] NULL,
	[Status] [bigint] NULL,
	[Comments] [varchar](8000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FIIDue] [money] NULL,
	[NACDue] [money] NULL,
	[OperatingMonth] [bigint] NULL
) ON [PRIMARY]

GO
