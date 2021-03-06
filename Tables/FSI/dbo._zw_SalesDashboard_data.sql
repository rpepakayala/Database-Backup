/****** Object:  Table [dbo].[_zw_SalesDashboard_data]    Script Date: 5/15/2018 12:00:45 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[_zw_SalesDashboard_data](
	[DateUsed] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[dateto] [datetime] NULL,
	[dailyCloseoutStart] [datetime] NULL,
	[dailyCloseEnd] [datetime] NULL,
	[monthlyCloset] [datetime] NULL,
	[DailyPlacedAmount] [money] NULL,
	[TotalAmountPlacedMTD] [money] NULL,
	[CurrentYTD] [money] NULL,
	[CurrentRollingTwelve] [money] NULL,
	[PreviousYearYesterday] [money] NULL,
	[PreviousYearMTD] [money] NULL,
	[PreviousYearYTD] [money] NULL,
	[PreviousYearRollingTwelve] [money] NULL,
	[DailyPickedUp] [money] NULL,
	[MTDPickedUp] [money] NULL,
	[YTDPickedUp] [money] NULL,
	[R12PickedUp] [money] NULL,
	[DailyPickedUpLY] [money] NULL,
	[MTDPickedUpLY] [money] NULL,
	[YTDPickedUpLY] [money] NULL,
	[R12PickedUpLY] [money] NULL,
	[DailyBuiltAmount] [money] NULL,
	[TotalAmountBuiltMTD] [money] NULL,
	[DailyPickedUpAmount] [money] NULL,
	[TotalAmountPickedupMTD] [money] NULL,
	[DailyPaymentAmount] [money] NULL,
	[TotalAmountPaymentMTD] [money] NULL,
	[SignSales] [money] NULL,
	[ModifierSales] [money] NULL,
	[InstallSales] [money] NULL,
	[DiscountSales] [money] NULL,
	[DailyClosedAmount] [money] NULL,
	[TotalAmountClosedMTD] [money] NULL,
	[SubcontractSales] [money] NULL,
	[YTDAvg] [money] NULL,
	[LYYTDAvg] [money] NULL,
	[LastTwelveMonths] [money] NULL,
	[PreviousTwelveMonths] [money] NULL,
	[WIP] [money] NULL,
	[LastMonthSales] [money] NULL,
	[MonthlySalesGoal] [money] NULL,
	[TYForecastYesterday] [money] NULL,
	[TYForecastMTD] [money] NULL,
	[TYForecasttoLastMonth] [money] NULL,
	[TYForecastRolling12] [money] NULL,
	[FirstTimeCustomerYTD] [int] NULL,
	[FirstTimeCustomerLYYTD] [int] NULL,
	[NoOfInvoicesYTD] [int] NULL,
	[InvoiceAvgYTD] [money] NULL,
	[NoOfInvoicesLYYTD] [int] NULL,
	[InvoiceAvgLYYTD] [money] NULL,
	[OverridesLYYTD] [int] NULL,
	[OverridesYTD] [int] NULL,
	[YTDProspects] [int] NULL,
	[YTDCustomers] [int] NULL,
	[R12Customers] [int] NULL,
	[R12Orders] [int] NULL,
	[LR12Customers] [int] NULL,
	[LR12Orders] [int] NULL,
	[Deposits] [money] NULL,
	[MTDRanking] [int] NULL,
	[YTDRaning] [int] NULL,
	[MTDoutof] [int] NULL,
	[YTDoutof] [int] NULL,
	[Outof] [int] NULL
) ON [PRIMARY]

GO
