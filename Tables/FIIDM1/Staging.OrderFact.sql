/****** Object:  Table [Staging].[OrderFact]    Script Date: 5/15/2018 11:59:57 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Staging].[OrderFact](
	[OrderKey] [int] NULL,
	[T_WebNumber] [smallint] NULL,
	[T_OrderID] [int] NULL,
	[T_CustomerID] [int] NULL,
	[T_ContactID] [int] NULL,
	[OrderDate] [datetime] NULL,
	[OrderDateKey] [int] NULL,
	[SalesAmt] [money] NULL
) ON [PRIMARY]

GO
