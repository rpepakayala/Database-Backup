/****** Object:  Table [dbo].[OrderFact]    Script Date: 5/15/2018 11:59:53 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[OrderFact](
	[OrderFactID] [int] IDENTITY(1,1) NOT NULL,
	[OrderKey] [int] NOT NULL,
	[DateKey] [int] NOT NULL,
	[StoreKey] [int] NOT NULL,
	[CustomerKey] [int] NOT NULL,
	[ContactKey] [int] NOT NULL,
	[SalesAmt] [money] NULL,
	[T_WebNumber] [int] NULL,
	[T_StoreID] [int] NULL,
	[T_CustomerID] [int] NULL,
	[T_ContactID] [int] NULL,
	[T_OrderID] [int] NULL,
	[T_OrderDate] [datetime] NULL,
	[T_PickedUpDate] [datetime] NULL,
	[WIP_Amt]  AS (case when [T_PickedUpDate] IS NULL then [SalesAmt] else (0) end),
	[PickedUpAmt]  AS (case when [T_PickedUpDate] IS NOT NULL then [SalesAmt] else (0) end),
	[SalesTotalAmt] [money] NULL,
	[TaxTotalAmt] [money] NULL,
	[ShippingChargeAmt] [money] NULL,
 CONSTRAINT [PK_OrderFact] PRIMARY KEY CLUSTERED 
(
	[OrderFactID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [IX_OrderFact_DateKey]    Script Date: 5/15/2018 11:59:53 AM ******/
CREATE NONCLUSTERED INDEX [IX_OrderFact_DateKey] ON [dbo].[OrderFact]
(
	[DateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
