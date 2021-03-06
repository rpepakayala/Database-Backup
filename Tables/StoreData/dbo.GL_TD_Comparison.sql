/****** Object:  Table [dbo].[GL_TD_Comparison]    Script Date: 5/15/2018 12:06:46 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[GL_TD_Comparison](
	[Notes] [varchar](111) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[SaleYear] [int] NULL,
	[SaleMonth] [int] NULL,
	[SaleDay] [int] NULL,
	[GLYear] [int] NULL,
	[GLMonth] [int] NULL,
	[GLDay] [int] NULL,
	[OrderNumber] [int] NULL,
	[LineItemNumber] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PriorSaleEntries] [decimal](38, 4) NULL,
	[PriorTaxEntries] [decimal](38, 4) NULL,
	[FutureSaleEntries] [decimal](38, 4) NULL,
	[FutureTaxEntries] [decimal](38, 4) NULL,
	[TDTransHeaderID] [int] NULL,
	[TDTransDetailID] [int] NULL,
	[TDIncomeAmount] [decimal](18, 4) NULL,
	[TDTaxAmount] [money] NULL,
	[GLTransHeaderID] [int] NULL,
	[GLTransDetailID] [int] NULL,
	[GLTaxAmount] [decimal](38, 4) NULL,
	[GLIncomeAmount] [decimal](38, 4) NULL,
	[TaxDelta] [decimal](38, 4) NULL,
	[IncomeDelta] [decimal](38, 4) NULL,
	[PriorPeriodTaxClassID] [int] NULL,
	[LastInPeriodTaxClassID] [int] NULL,
	[LastTaxClassID] [int] NULL,
	[RowNum] [bigint] NULL,
	[TaxesFromOrder] [int] NULL,
	[TaxesFromGL] [int] NULL,
	[TaxesFromPastGL] [int] NULL,
	[TaxableFromOrder] [int] NULL,
	[TaxableFromGL] [int] NULL,
	[NonTaxableFromOrder] [int] NULL,
	[NonTaxableFromGL] [int] NULL,
	[Ignore] [int] NULL,
	[TransHeaderID] [int] NULL,
	[TransDetailID] [int] NULL,
	[Taxes] [money] NULL,
	[TaxableIncome] [money] NULL,
	[NonTaxableIncome] [money] NULL
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [TempIndex1]    Script Date: 5/15/2018 12:06:46 PM ******/
CREATE NONCLUSTERED INDEX [TempIndex1] ON [dbo].[GL_TD_Comparison]
(
	[Notes] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [TempIndex2]    Script Date: 5/15/2018 12:06:46 PM ******/
CREATE NONCLUSTERED INDEX [TempIndex2] ON [dbo].[GL_TD_Comparison]
(
	[RowNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
