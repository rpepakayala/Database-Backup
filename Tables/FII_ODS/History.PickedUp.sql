/****** Object:  Table [History].[PickedUp]    Script Date: 5/15/2018 11:59:34 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [History].[PickedUp](
	[ReportDate] [date] NULL,
	[Year] [int] NULL,
	[Month] [int] NULL,
	[StoreCount] [int] NULL,
	[Sales] [money] NULL,
	[BusinessDays] [int] NULL,
	[AVGBusinessDaySales] [money] NULL,
	[AVGBusinessDaySalesDiff] [numeric](21, 6) NULL,
	[SalesDiffPercentage] [numeric](21, 6) NULL,
	[CompCenters] [int] NOT NULL,
	[AveInv] [money] NULL,
	[AveInvDiff] [numeric](19, 4) NULL
) ON [PRIMARY]

GO
